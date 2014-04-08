module ClientAPI
  def new_user(args)
    Celluloid::Actor[:database_mid].async.create_user(args)
    send_({"status" => "user_created"})
  end

  def auth(args)
    
  end
end