require 'session/dispatch_api'

module Middlewares

  class Dispatch < Commons::Middleware

    def initialize(dispatch_ip, dispatch_port)
      @server = {:ip => dispatch_ip, :port => dispatch_port}
    end

    include DispatchAPI

  end

end