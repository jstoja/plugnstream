require 'session/dispatch_api/from_session'
require 'session/dispatch_api/from_stream'

module DispatchAPI
  include FromSession
  include FromStream
end
