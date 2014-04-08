require 'thor'
require 'celluloid'
require 'celluloid/autostart'
require 'plugnstream/version'

module Plugnstream

  class Cli < Thor
    desc "dispatcher", "launch the dispatcher server"
    option :db
    # TODO: PUT THE DATABASE IN PARAMETERS
    def dispatcher()
      require 'dispatch/dispatch'
      @dispatch = Dispatch.new
      @dispatch.start
      sleep
    end

    desc "session DISPATCH_SERVER_IP DISPATCH_SERVER_PORT", "launch the session server"
    def session(dispatch_ip, dispatch_port)
      require 'session/session'
      @session = Session.new
      @session.start(dispatch_ip, dispatch_port)
      sleep
    end
  end

  def self.db_config
    @db_config ||= YAML::load(File.open( __dir__ + '/../config/database.yml'))
    @db_config[ENV['ENVIRONMENT']]
  end
end

