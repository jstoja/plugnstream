require 'commons/middleware'
require 'dispatch/session_api'

module Middlewares
  class Session < Commons::Middleware
    include SessionAPI
  end
end