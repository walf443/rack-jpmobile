module Rack
  class Request
    class Jpmobile < Request
      include Jpmobile::RequestWithMobile
    end
  end
end
