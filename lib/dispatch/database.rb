require 'active_record'
require 'logger'

require 'plugnstream'

require 'commons/middleware'

require 'dispatch/database_api'

module Middlewares

	class Database < Commons::Middleware

    def initialize()
      @dbconfig = Plugnstream.db_config
    end

    # Starts the connection with the DB
    def start
      info "Connection to the database..."
      ActiveRecord::Base.establish_connection(@dbconfig)
      ActiveRecord::Base.logger = ::Logger.new(STDERR)
    end

    include DatabaseAPI
	end

end