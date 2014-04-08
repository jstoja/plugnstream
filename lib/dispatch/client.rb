require 'commons/middleware'
require 'dispatch/client_api'

module Middlewares
  class Client < Commons::Middleware
    
    include ClientAPI
  end
end