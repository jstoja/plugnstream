# @api dispatch
module RessourceController
  # Creates a new session in the database. To start a session, a server must have been registered before so it can be used as a session server.
  # @param args [Hash{ip=>String, type=>String}] The IP address of the server and the type of the server (session/distribution).
  # @return [Boolean] Is the ressource registered.
  def register_ressource(args)
  end

  # Set the ressource in the occupied state.
  # @param ressource_id [Integer] The id of the ressource.
  # @return [Boolean] Is the action done without problem.
  def occupy_ressource(ressource_id)
  end

  # Set the ressource in the unoccupied state.
  # @param ressource_id [Integer] The id of the ressource.
  # @return [Boolean] Is the action done without problem.
  def unoccupy_ressource(ressource_id)
  end

  # Put the ressource off availability. It's not erased from the DB to keep the logs.
  # @param ressource_id [Integer] The id of the ressource.
  # @return [Boolean] Is the action done without problem.
  def unregister_ressource(ressource_id)
  end

end
