require 'rack'
module Rack
  class Request
    autoload :Jpmobile, 'rack/request/jpmobile'
  end

  module Auth
    autoload :Jpmobile, 'rack/auth/jpmobile'
    autoload :IP, 'rack/auth/ip'
  end

  module Jpmobile
    autoload :CombinedLogger, 'rack/jpmobile/combined_logger'
  end
end
