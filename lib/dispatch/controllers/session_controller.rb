# @api dispatch
module SessionController

  # Creates a new session in the database. To start a session, a server must have been registered before so it can be used as a session server.
  # @param user_id [Integer] The id of the user starting the session.
  # @return [String] The token of the session if the creation is successful.
  def create_session(user_id)
  end

  # Ends a session by freeing the ressources in the database
  # @param token [String] The token of the session to stop.
  # @return [Boolean] Has the session correctly ended.
  def end_session(token)
  end

  # # Modify the session with the given id.
  # # @param args [Hash{id=>Integer, ...}] There must be a key `:id` and the key with the attributes to modify.
  # # @return [Boolean] Is something has been edited.
  # def edit_session(args)
  # end

  # # Get the user with the given id.
  # # @param args [Integer].
  # # @return [Hash{id=>Integer, name=>String, mail=>String, password_salt=>String, token_salt=>String}] The hash of the user attributes (id, name, mail, password_salt, token_salt).
  # def show_session(args)
  # end


  # # Delete the user with the given id.
  # # @param args [Integer].
  # # @return [Boolean] Is something has been deleted.
  # def destroy_session(args)
  #   #TODO:
  #   # ADD SOME USER LEVEL TO AVOID THESE
  # end
end