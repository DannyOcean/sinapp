=begin
Laboratory work #2
Performed by Kondratenko Denis, IKIT 417

Substitution algorithm:
- Reverse string
- Replace characters to ascii code
- Replace ascii code to hexadecimal numbers
- Replace letters in hexadecimal numbers
=end

class Permutator
  attr_reader :encoded_phrase, :decoded_phrase
  
  def encode(phrase)
    _phrase = phrase.reverse.chars
    _phrase.each_index do |i| 
      _phrase[i] = _phrase[i].ord.to_s(16)    #convert characters to ascii code, then ascii code to hexadecimal number
      substitute! _phrase[i]                  #substitute chars
    end
    @encoded_phrase = _phrase.join('//')
  end

  def decode(phrase)
    _phrase = phrase.split('//')
    _phrase.each_index do |i|
      de_substitute! _phrase[i]               #substitute chars
      _phrase[i] = _phrase[i].hex.chr         #convert to hexadecimal number, then to chararacter
    end
    @decoded_phrase = _phrase.join('').reverse
  end

  private

  def substitute!(string)
    string.chars.each_index do |i|
      case string[i]
      when 'a' then string[i] = 'c'
      when 'b' then string[i] = 'd'
      when 'c' then string[i] = 'b'
      when 'd' then string[i] = 'a'
      end
    end
    string
  end

  def de_substitute!(string)
    string.chars.each_index do |i|
      case string[i]
      when 'c' then string[i] = 'a'
      when 'd' then string[i] = 'b'
      when 'b' then string[i] = 'c'
      when 'a' then string[i] = 'd'
      end
    end
    string
  end
end