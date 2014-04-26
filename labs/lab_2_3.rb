# laboratory work #2.3
# performed by Kondratenko Denis, ICIT 417
# All rights reserved (c)
require 'openssl'
require 'Base64'

class DES
  attr_reader :encrypted_phrase, :decrypted_phrase

  def encrypt(data, key)
    cipher = OpenSSL::Cipher::DES.new(:ECB)
    cipher.encrypt
    cipher.key = key
    encrypted_phrase = cipher.update(data) + cipher.final
    @encrypted_phrase = Base64.encode64(encrypted_phrase).encode('utf-8')
  end

  def decrypt(data, key)
    data = Base64.decode64 data.encode('ascii-8bit')
    decipher = OpenSSL::Cipher::DES.new(:ECB)
    decipher.decrypt
    decipher.key = key
    decrypted_phrase = decipher.update(data) + decipher.final
    @decrypted_phrase = decrypted_phrase
  end
end