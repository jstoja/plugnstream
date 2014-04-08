require 'msgpack'
require 'celluloid'

module Commons
  class Middleware
    include Celluloid
    include Celluloid::Logger

    finalizer :close_socket

    def initialize(socket)
      @socket = socket
      debug "Creating a new middleware " + self.to_s
    end

    def send_(message)
      @socket.send message.to_msgpack, 0
      @socket.flush
    end

    def process(message)
      send(message["action"].to_sym, message)
    end

    def close_socket
      @socket.close unless @socket.nil?
      debug "Terminating the Middleware " + self.to_s
    rescue IOError
      debug "Terminating the Middleware " + self.to_s
    end

    # Catch all the wrong API calls
    def method_missing(symbol, *args)
      warn (self.name.to_s + " -- Unregistered call: " + symbol.to_s + " is not existant. Please verify your call and refer to the documentation.")
    end

  end
end
