#laboratory work #4
#performed by Kondratenko Denis, ICIT 417
require './labs/lab_1_3'

class BlockCipher
  attr_reader :encrypted_phrase, :decrypted_phrase, :blocks
  BLOCK_SIZE = 8

  def initialize 
    @gamma = Gamma.new
  end

  def encrypt(phrase, key)
    blockinate phrase
    @blocks.each_with_index do |block, i|
      unless i.odd?
        @blocks[i] = binarize block
        @blocks[i] = reverse_bin @blocks[i]
        @blocks[i] = bin_to_unicode @blocks[i]
      else
        @blocks[i] = @gamma.encrypt(block, key)        
      end
    end
    @encrypted_phrase = @blocks.join
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
    @decrypted_phrase = @blocks.join
  end

  private

  #following method devide data on blocks of 8 bytes size each
  def blockinate(data)
    blocks = []
    i, j = 0, BLOCK_SIZE - 1
    n = (data.size / BLOCK_SIZE) + 1
    n.times do
      block = data[i..j]
      blocks << block
      i = j + 1
      j += BLOCK_SIZE
    end
    if blocks.last.size < BLOCK_SIZE
      n = BLOCK_SIZE - blocks.last.size
      n.times { blocks.last << ' ' }
    end
    @blocks = blocks
  end

  #substitute 1 with 0 and vise versa in the given block
  #returns block
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

  #following method converts each char of the string 
  #into binary number of its ascii code
  #return array of binarized characters
  def binarize(string)
    string.codepoints.to_a.map { |byte| byte.to_s(2).insert(0, '0') }
  end

  #replace binary numbers with characters from ascii table
  #return string
  def unbinarize(block)
    block.map { |byte| byte.to_i(2).chr }.join
  end

  #replace binary number with its char equivalent from ascii table
  #reurn block with characters
  def bin_to_unicode(block)
    block.map { |bin| bin.to_i(2).chr.unpack("C*").pack("U*") }
  end
  
  #replace unicode chars with binary number that corresponds its ascii code
  #return block with binaries
  def unicode_to_bin(block)
    block.codepoints.to_a.map { |byte| byte.to_s(2) }
  end
end