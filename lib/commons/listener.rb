require 'msgpack'
require 'pp'
require 'celluloid/io'

module Commons
  class Listener
    include Celluloid::IO
    include Celluloid::Logger

    finalizer :shutdown

    def initialize(port_number)
      puts "*** Starting echo server on #{port_number}"

      @port_number = port_number
      @server = TCPServer.new("localhost", @port_number.to_s)
    end

    def start()
      async.run
    end

    def shutdown
      debug "Terminating the listener " + self.to_s
      @server.close if @server
    end

    def run()
      info "Listening to clients on port " + @port_number.to_s
      loop do
        client = @server.accept
        clients_info = client.addr :hostname
        info "New client accepted: " + clients_info[2] + " " + clients_info[3]
        async.process_packet client, clients_info[3]
      end
    end

    private

    # Launch the processing of the request
    # @param client The client socket
    # @param ip_address The IP address of the connected socket
    def process_packet(client, ip_address)
      receiver = nil
      # u = MessagePack::Unpacker.new(client)
      # u.each do |received_unpacked|
      #   debug "Received command " + received_unpacked.to_s + " from " + ip_address
      #   unless (received_unpacked.nil?) then
      #     if received_unpacked.class.to_s != "Hash" then
      #       warn "------------#{client} is sending me crap, go away."
      #       return client.close
      #     end
      #     receiver = process_deeper(client, received_unpacked, receiver)
      #   end
      # end

      _, port, host = client.peeraddr
      puts "*** Received connection from #{host}:#{port}"
      loop {
        data = client.readpartial(4096)
        u ||= MessagePack::Unpacker.new
        u.feed_each(data) { |received_unpacked|
          debug "Received command " + received_unpacked.to_s + " from " + ip_address
          unless (received_unpacked.nil?) then
            if received_unpacked.class.to_s != "Hash" then
              warn "------------#{client} is sending me crap, go away."
              return client.close
            end
            receiver = process_deeper(client, received_unpacked, receiver)
          end
        }        
      }
    rescue EOFError
      _, port, host = client.peeraddr
      warn "------------#{host}:#{port} disconnected"
      client.close
      receiver.async.terminate if receiver
    rescue IOError => ioerror
      warn "------------#{host}:#{port} disconnected"
      puts ioerror
    end

    def process_deeper(client, received_unpacked, receiver)
      if received_unpacked['action'] == 'close' then
        warn "------------ Yes i'm closing."
        client.close
        receiver.async.terminate
        return nil
      elsif received_unpacked['action'] == 'init' then
        unless received_unpacked['to'].nil? then
          receiver = create_receiver(received_unpacked['to'], client)
          send_to(client, {"status" => "ok"})
          return receiver
        else
          warn "------------ #{client} you don't even init correctly... go away."
          send_to(client, {"status" => "need_init"})
          client.close
          return nil
        end
      else
        if receiver == nil
          warn "------------ #{client} you don't wanna init... go away."
          send_to(client, {"status" => "need_init_before"})
          client.close
        else
          receiver.async.process(received_unpacked) ## GO INTO THE API FOR MORE COMPLEX QUERIES
        end
        return receiver
      end
    end

    def send_to(socket, message)
        test = message.to_msgpack.to_s
        socket.send test, 0     
        socket.flush 
    end

  end
end