module Rack
  class Request
    # SYNOPSIS
    #
    #   require 'rack/jpmobile'
    #   class YourApp
    #     def call env
    #       req = Rack::Request::Jpmobile.new env
    #       if req.mobile?
    #         p req.mobile   #=> Jpmobile::Mobile::xxxx's instance ( for example, Jpmobile::Mobile::Docomo ).
    #         return [ 403, {'Content-Type' => 'text/plain'}, '403 FORBIDDEN'] unless req.mobile.valid_ip?
    #
    #         # do something for mobile
    #       else
    #         # do something for pc
    #       end
    #     end
    #   end
    #
    # SEE ALSO: +Jpmobile::RequestWithMobile+, +Jpmobile::Mobile::AbstractMobile+
    #
    class Jpmobile < ::Rack::Request
      include ::Jpmobile::RequestWithMobile
    end
  end
end
