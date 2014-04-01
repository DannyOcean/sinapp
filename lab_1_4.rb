#laboratory work #4
#performed by Kondratenko Denis, ICIT 417

class BlockCipher
	attr_reader :encrypted_phrase, :decrypted_phrase, :blocks
  
  def initialize 
    @gamma = Gamma.new
  end

	def encrypt(phrase, key)
    blockinate phrase
    @blocks.each_with_index do |block, i|
      unless i.odd?
        @blocks[i] = binarize block
        @blocks[i] = reverse_bin @blocks[i]
        @blocks[i] = bin_to_char @blocks[i]
      else
        @blocks[i] = @gamma.encrypt(block, key)
      end
    end
    @encrypted_phrase = @blocks.join('')
	end

  def decrypt(phrase, key)
    blockinate phrase
    @blocks.each_with_index do |block, i|
      unless i.odd?
        @blocks[i] = unicode_to_bin block
        @blocks[i] = reverse_bin @blocks[i]
        @blocks[i] = unbinarize @blocks[i]
      else
        @blocks[i] = @gamma.decrypt(block, key) 
      end
    end
    @decrypted_phrase = @blocks.join('')
  end

  private

  #following method devide phrase on blocks of 8 bytes size each
  #except the last one.
  #1 char = 1 byte. block = 64 bits = 8 bytes.
  def blockinate(phrase)
    blocks = []
    i, j = 0, 7
    n = phrase.size / 8
    n.times do
      block = phrase[i..j]
      blocks << block
      i = j + 1
      j += 9
    end
    @blocks = blocks
  end

  #following method converts each char of the string 
  #into binary number of its ascii code
  #return array of binarized characters
  def binarize(string)
    binarized_str = string.bytes
    binarized_str.each_index do |i|
      binarized_str[i] = binarized_str[i].to_s(2)
    end
    binarized_str
  end

  #replace binary numbers with characters from ascii table
  #return string
  def unbinarize(block)
    block.each_index do |i|
      block[i] = block[i].to_i(2).chr
    end
    block.join('')
  end

  #substitute 1 with 0 and vise versa in the given block
  #returns array with strings
  def reverse_bin(block)
    block.each_with_index do |bin, i|
      reversed = bin.chars
      reversed.each_with_index do |char, i|
        if char == '1'
          reversed[i] = '0'
        else
          reversed[i] = '1'
        end
      end
      block[i] = reversed.join('')
    end
    block
  end

  #replace binary number with its char equivalent from ascii table
  #reurn block with characters
  def bin_to_char(block)
    block.each_with_index do |bin, i|
      block[i] = unescape(bin.to_i(2).chr)
    end
    block
  end

  #replace unicode chars with binary number that corresponds its ascii code
  #return block with binaries
  def unicode_to_bin(block)
    str = block.chars
    str.each_index do |i|
      str[i] = str[i].ord.to_s(2)
    end
    block = str
  end

  #unescapes "\x" in unicode charaters in string
  def unescape(str)
    str.unpack("C*").pack("U*")
  end

end