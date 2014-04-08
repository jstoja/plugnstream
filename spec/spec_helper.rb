ENV['ENVIRONMENT'] = 'test'

def basic_communication(message, expect)
  ret = nil

  init = {"to" => "client", "action" => "init"}.to_msgpack.to_s
  answer_init = {"status" => "ok"}
  TCPSocket.open("localhost", 9000) {|s|

    s.set_encoding 'utf-8'
    s.send init, 0
    s.flush
    get = s.recv(1024)

    s.send message, 0
    s.flush

    get = s.recv(1024)
    ret = MessagePack.unpack(get)

    s.close
  }
  ret.should eq(expect)
end

def send_and_expect(message, expect)
  ret = nil
  TCPSocket.open("localhost", 9000) {|s|
    s.set_encoding 'utf-8'
    s.send message, 0
    s.flush
    get = s.recv(1024)
    ret = MessagePack.unpack(get)
    s.close
  }
  ret.should eq(expect)
end