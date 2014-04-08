require 'dispatch/models/user'
require 'dispatch/models/session'
require 'dispatch/models/ressource'

require 'dispatch/controllers/user_controller'
require 'dispatch/controllers/session_controller'
require 'dispatch/controllers/ressource_controller'

# @api dispatch
module DatabaseAPI
  include UserController
  include SessionController
  include RessourceController
end