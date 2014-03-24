#laboratory work #3
#performed by Kondratenko Denis, IKIT 417

#Variant #1 >>>>>
class Gamma
  attr_reader :encrypted_phrase, :decrypted_phrase, :mapped_gamma

  def initialize
    alphabet  = 'a'..'z'
    @alphabet = alphabet.to_a
  end

  # Encrypts the phrase by substitution characters
  # Replaceable characters determined by the following formula:
  # Ri = |( Si + Gi ) - (k –1)|, where
  # Ri, – encrypted text symbols
  # Si – original text symbols
  # Gi – gamma symbols
  # k – amount of symbols in alphabet

  def encrypt(phrase, gamma)
    @phrase = phrase.downcase
    @gamma  = gamma.downcase
    map_gamma
    encrypted_phrase = []
    @mapped_gamma.chars.each_with_index do |char, i|
      unless char =~ /[^\w]|[\d]|[\s]/
        si = @alphabet.index @phrase[i]
        gi  = @alphabet.index char
        sum = si + gi 
        size = @alphabet.size - 1
        if size <= sum
          ri = sum - size
        else
          ri = sum
        end
        encrypted_phrase << @alphabet[ri]
      else
        encrypted_phrase << char     
      end
    end
    @encrypted_phrase = encrypted_phrase.join('')
  end

  def decrypt(phrase, gamma)
    @phrase = phrase.downcase
    @gamma  = gamma.downcase
    map_gamma
    decrypted_phrase = []
    @mapped_gamma.chars.each_with_index do |char, i|
      unless char =~ /[^\w]|[\d]|[\s]/
        ri = @alphabet.index @phrase[i]
        gi = @alphabet.index char
        size = @alphabet.size - 1
        if ri - gi >= 0
          si = ri - gi
        else
          si = size - (gi - ri)
        end
        decrypted_phrase << @alphabet[si]
      else
        decrypted_phrase << char
      end
    end
    @decrypted_phrase = decrypted_phrase.join('')
  end

  private

  # map_gamma returns phrase with replaced characters 
  # with characters from gamma
  def map_gamma
    k = 0 
    phrase_chars = @phrase.chars
    phrase_chars.each_index do |i|
      gamma_char = @gamma.chars[k]
      unless phrase_chars[i] =~ /[^\w]|[\d]|[\s]/
        phrase_chars[i] = gamma_char
        k += 1
      end
      k = 0 if k == @gamma.length
    end
    @mapped_gamma = phrase_chars.join('')
  end

end