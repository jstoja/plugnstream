require 'dispatch/utils'

# @api dispatch
module UserController
  # Creates a new user in the database.
  # @param args [Hash{name=>String, mail=>String, password=>String, level=>level}] There must be a key `:name`, `:mail` and `:password`.
  # @return [Boolean] Has the user has been created.
  def create_user(args)
    hash_passwd = Utils::hash_and_salt_password(args["password"])
    user = {
      name: args["name"],
      mail: args["mail"],
      password: hash_passwd[:password].force_encoding('utf-8'),
      password_salt: hash_passwd[:salt].force_encoding('utf-8'),
      token_salt: Digest::MD5.base64digest(args["name"])[0..5],
      level: args["level"]
    }
    User.create(user)
  end

  # Modify the user with the given id.
  # @param args [Hash{id=>Integer, ...}] There must be a key `:id` and the key with the attributes to modify.
  # @return [Boolean] Is something has been edited.
  def edit_user(args)
  end

  # Get the user with the given id.
  # @param args [Integer].
  # @return [Hash{id=>Integer, name=>String, mail=>String, password_salt=>String, token_salt=>String}] The hash of the user attributes (id, name, mail, password_salt, token_salt).
  def show_user(args)
  end


  # Delete the user with the given id.
  # @param id [Integer] The id of the user to delete.
  # @return [Boolean] Is something has been deleted.
  def destroy_user(id)
    #TODO:
    # ADD SOME USER LEVEL TO AVOID THESE
  end

  # Identify the user with the given mail and hashed_password.
  # @param args [Hash{mail=>String, password=>String}] The hash containing the key `:mail` and `password`.
  # @return [Boolean] Is something has been deleted.
  def identify_user(args)
  end

  # Send the salt for the password from the given user id or mail
  # param args [Hash{id=>Integer, mail=>String}] The id and/or the mail of the user.
  # @return [String] The salt for the password.
  def get_salt_user(args)
  end
end