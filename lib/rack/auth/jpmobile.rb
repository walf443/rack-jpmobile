module Rack
  module Auth
    # in your_app.ru
    #
    # allow access using subscribe_id
    #   require 'rack/jpmobile'
    #   use Rack::Auth::Jpmobile::Au, :ident_subscriber => %w( xxxxxx.ez_web.ne.jp )
    #
    # also check ip address ( in this case, access only from Docomo )
    #   require 'rack/jpmobile'
    #   use Rack::Auth::Jpmobile::Docomo, :ident_subscriber => %w( xxxxxx ), :check_ip => true
    #
    # check ip but allow localhost
    #   require 'rack/jpmobile'
    #   use Rack::Auth::Jpmobile::Docomo, {
    #      :ident => %w( xxxxxx ), 
    #      :check_ip => true, 
    #      :allow_ip => %w( 127.0.0.1 )
    #   }
    #
    # you can use block
    # req is Rack::Request::Jpmobile's subclass instance.
    #   require 'rack/jpmobile'
    #   use Rack::Auth::Jpmobile {|req|
    #     Your::Model::AuSubno.count(:subno => req.ident) != 0
    #   }
    class Jpmobile
      FORBIDDEN = [403, {'Content-Type' => 'text/plain' }, 'Forbidden' ]

      def initialize app, hash=nil, &block
        @app = app
        if hash
          @ident = hash[:ident]
          @check_ip         = hash[:check_ip]
          @allow_ip         = hash[:allow_ip]
        end
        @cond = block
      end

      def career
      end

      def call env
        req = career.new(Rack::Request::Jpmobile.new(env))

        if req.mobile?
          if @ident && @ident.include?(req.ident)
            if !@check_ip or req.valid_ip?
              return @app.call(env)
            else
              if @allow_ip
                return Rack::Auth::IP.new(@app, @allow_ip).call(env)
              else
                return FORBIDDEN
              end
            end
          end
        else
          if @allow_ip
            return Rack::Auth::IP.new(@app, @allow_ip).call(env)
          end
        end

        if @cond
          if @cond.call(req)
            return @app.call(env)
          else
            return FORBIDDEN
          end
        end
        
        return FORBIDDEN
      end

      ::Jpmobile::Model.constants.each do |career|
        klass = Class.new(self)
        klass.class_eval do
          define_method :career do
            ::Jpmobile::Mobile.const_get(career)
          end
        end
        const_set(career, klass)
      end
    end
  end
end
