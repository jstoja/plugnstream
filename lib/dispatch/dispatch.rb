require 'commons/listener'

require 'dispatch/database'
require 'dispatch/dispatch_listener'

# require 'dispatch/session'
# require 'dispatch/client'

class Dispatch
  include Celluloid
  include Celluloid::Logger

  finalizer :close_server

  def close_server
    # Celluloid.kill(Celluloid::Actor[:listener])
    Celluloid::Actor[:database_mid].async.terminate
    Celluloid::Actor[:listener].async.terminate
    # puts "closing server"
    # current_actor.kill(Celluloid::Actor[:clients_mid])
  end

  # Initialize all the actors
  def initialize
    info "Starting the actors..."
    # Celluloid::Actor[:listener] = Commons::Listener.new(9000)
    Celluloid::Actor[:listener] = DispatchListener.new(9000)
    Celluloid::Actor[:database_mid] = Middlewares::Database.new
    # Celluloid::Actor[:client_mid] = Middlewares::Client.new
    # Celluloid::Actor[:session_mid] = Middlewares::Session.new
    info "All actors started."
  end

  # Initialize start all the servers inside the actors
  def start
    info "Configuring the actors..."
    Celluloid::Actor[:listener].async.start
    Celluloid::Actor[:database_mid].async.start
    info "All actors configured."
  end
end