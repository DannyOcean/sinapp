# laboratory work #2.3
# performed by Kondratenko Denis, ICIT 417
# All rights reserved (c)
require 'openssl'

class DES
  attr_reader :encrypted_phrase, :decrypted_phrase

  def encrypt(data, key)
    cipher = OpenSSL::Cipher::DES.new(:ECB)
    cipher.encrypt
    cipher.key = key
    @encrypted_phrase = cipher.update(data) + cipher.final
  end

  def decrypt(data, key)
    decipher = OpenSSL::Cipher::DES.new(:ECB)
    decipher.decrypt
    decipher.key = key
    @decrypted_phrase = decipher.update(data) + decipher.final
  end
end
