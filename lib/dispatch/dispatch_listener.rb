
require 'commons/listener'
# require 'dispatch/session'
require 'dispatch/client'

class DispatchListener < Commons::Listener

  def create_receiver(receiver_type, receiver_socket)
    if receiver_type == "client"
      Middlewares::Client.new(receiver_socket)
    elsif receiver_type == "session"
      Middlewares::Session.new(receiver_socket)
    end
  end

end