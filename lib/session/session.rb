require 'session/dispatch'
require 'session/stream'

class Session
  include Celluloid
  include Celluloid::Logger

  def initialize(dispatch_ip, dispatch_port)
    info "Starting the actors..."
    Celluloid::Actor[:listener] = Commons::Listener(9001)
    Celluloid::Actor[:dispatch_mid] = Middlewares::Dispatch.new(dispatch_ip, dispatch_port) # To send even if the dispatch server never contacted you
    Celluloid::Actor[:stream_mid] = Middlewares::Stream.new
    info "All actors started."
  end
end