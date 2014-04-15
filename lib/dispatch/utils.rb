require 'openssl'

module Utils

  # Creates the hash and the salt of the given password
  # @param password The password to be processed
  # @return [{salt => String, password => String}] The salt and the hashed password.
  def self.hash_and_salt_password(password)
    salt = OpenSSL::Random.random_bytes(16) #store this with the generated value
    iter = 20000
    digest = OpenSSL::Digest::SHA256.new
    len = digest.digest_length
    #the final value to be stored
    value = OpenSSL::PKCS5.pbkdf2_hmac(password, salt, iter, len, digest)
    {salt: salt, password: value}
  end

  def self.salt_password(password, salt)
    iter = 20000
    digest = OpenSSL::Digest::SHA256.new
    len = digest.digest_length
    #the final value to be stored
    OpenSSL::PKCS5.pbkdf2_hmac(password, salt, iter, len, digest)
  end

end