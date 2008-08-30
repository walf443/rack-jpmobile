module Rack
  class Request
    class Jpmobile < ::Rack::Request
      include ::Jpmobile::RequestWithMobile
    end
  end
end
