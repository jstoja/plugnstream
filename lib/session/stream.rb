require 'commons/listener'

module Middlewares

  class Stream < Commons::Middleware
    include StreamAPI
  end
end
