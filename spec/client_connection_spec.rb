require 'msgpack'

require 'plugnstream'
require 'spec_helper'
require 'dispatch/dispatch'
require 'dispatch/utils'

describe "a client connection" do
  before(:each) do
      @dispatch = Dispatch.new
      @dispatch.start
  end

  after(:each) do
    @dispatch.terminate
  end

  it "should init" do
    init = {"to" => "client", "action" => "init"}.to_msgpack.to_s
    answer = {"status" => "ok"}
    send_and_expect(init, answer)
  end

  it "should fail if init without \"to\" field" do
    init = {"action" => "init"}.to_msgpack.to_s
    answer = {"status" => "need_init"}
    send_and_expect(init, answer)
  end

  it "should fail if not init" do
    init = {"to" => "client", "action" => "not_init"}.to_msgpack.to_s
    answer = {"status" => "need_init_before"}
    ret = nil
    send_and_expect(init, answer)
  end

  it "should close when asking" do
    init = {"to" => "client", "action" => "init"}.to_msgpack.to_s
    answer_init = {"status" => "ok"}
    close = {"to" => "client", "action" => "close"}.to_msgpack.to_s
    @ret = nil

    TCPSocket.open("localhost", 9000) {|s|
      s.set_encoding 'utf-8'
      s.send init, 0
      s.flush
      get = s.recv(1024)
      s.send close, 0
      s.flush
      expect(s.eof?).to eql(true)
    }
  end
end

describe "client actions" do
  before(:each) do
      @dispatch = Dispatch.new
      @dispatch.start
  end

  after(:each) do
    @dispatch.terminate
  end

  it "should be able to register" do
    create_user = {"from" => "client", "action" => "new_user", "mail" => "me@noob.com", "name" => "julien", "password" => "passdemerde"}.to_msgpack.to_s
    create_user_answer = {"status" => "user_created"}
    basic_communication(create_user, create_user_answer)
  end

  it "should be able to login" do
    create_user = {"from" => "client", "action" => "new_user", "mail" => "me@noob.com", "name" => "julien", "password" => "passdemerde"}.to_msgpack.to_s
    get_salt = {"from" => "client", "action" => "get_salt", "mail" => "me@noob.com"}

    expect = {"status" => "logged"}

    close = {"to" => "client", "action" => "close"}.to_msgpack.to_s
    @ret = nil

    TCPSocket.open("localhost", 9000) {|s|
      s.set_encoding 'utf-8'
      s.send create_user, 0
      s.flush
      get = s.recv(1024)

      s.send get_salt, 0
      s.flush
      get = s.recv(1024)
      ret = MessagePack.unpack(get)

      login = {"from" => "client", "action" => "login", "mail" => "me@noob.com", "password" => Utils::salt_password("passdemerde", ret["salt"])}
      s.send login, 0
      s.flush
      get = s.recv(1024)
      ret = MessagePack.unpack(get)
      ret.should eq(expect)

      s.send close, 0
      s.flush
    }
  end

  it "should be able to delete his account" do
  end

  it "should be able to create admin if logged and have rights" do
  end
end