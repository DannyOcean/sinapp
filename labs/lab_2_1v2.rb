#laboratory work #4
#performed by Kondratenko Denis, ICIT 417
require './labs/lab_1_3'

class BlockCipher2
  attr_reader :encrypted_phrase, :decrypted_phrase, :blocks
  BLOCK_SIZE = 8

  def initialize 
    @g = Gamma.new
  end

  def encrypt(data, key)
    blockinate data
    @blocks.each_with_index do |block, i|
      unless i.odd?
        @blocks[i] = xor block, key
      else
        @blocks[i] = @g.encrypt block, key
      end
    end
    @encrypted_phrase = @blocks.join
  end
  
  def decrypt(data, key)
    blockinate data
    @blocks.each_with_index do |block, i|
      unless i.odd?
        @blocks[i] = xor block, key
      else
        @blocks[i] = @g.decrypt block, key
      end
    end
    @decrypted_phrase = @blocks.join    
  end

  private
  
  def xor(block, key)
    block = block.codepoints.to_a
    key = key.bytes
    res = []
    0.upto(BLOCK_SIZE - 1) do |i|
      res << (block[i] ^ key[i])
    end
    res.pack("U*")
  end

  #following method devide data on blocks of 8 bytes size each
  def blockinate(data)
    blocks = []
    i, j = 0, BLOCK_SIZE
    n = data.size / BLOCK_SIZE
    n.times do
      block = data[i..j]
      blocks << block
      i = j + 1
      j += BLOCK_SIZE
    end
    if blocks.last.size < BLOCK_SIZE
      n = BLOCK_SIZE - blocks.last.size
      n.times { blocks.last << '0' }
    end
    @blocks = blocks
  end
end