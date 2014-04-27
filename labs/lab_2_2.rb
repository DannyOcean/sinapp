# laboratory work #2.2
# performed by Kondratenko Denis, ICIT 417
# All rights reserved (c)
require 'openssl'

class FeistelCipher
  attr_reader :encrypted_phrase, :decrypted_phrase, :blocks
  ROUNDS = 16

  def encrypt(phrase, key)
    phrase = phrase.codepoints.to_a
    blockinate phrase
    @blocks.each_with_index do |block, i|
      left  = block[0]
      right = block[1]
      ROUNDS.times do
        tmp   = xor(crypt(left, key), right)
        right = left
        left  = tmp
      end
      @blocks[i] = left + right
      @blocks[i] = @blocks[i].pack "U*"
    end
    @encrypted_phrase =  @blocks.join
  end

  def decrypt(phrase, key)
    phrase = phrase.codepoints.to_a
    blockinate phrase
    @blocks.each_with_index do |block, i|
      left  = block[0]
      right = block[1]
      ROUNDS.times do
        tmp   = xor(left, crypt(right, key))
        left  = right
        right = tmp
      end
      @blocks[i] = left + right
      @blocks[i] = @blocks[i].pack "U*"
    end
    @decrypted_phrase = @blocks.join
  end

  private

  # performing bit xor for each bit of left and right blocks
  # returns arra of result of xor operation
  def xor(left, right)
    res = Array.new
    0.upto(3) do |i|
      temp = left[i] ^ right[i]
      res << temp
    end
    res
  end

  # works with key length from 16 bits
  def crypt(block, key)
    key = key.bytes
    k = []
    k << key.first << key.last
    k = k.join.to_i
    block.map { |bit| bit.odd? ? bit ^ k : bit ^ (ROUNDS ^ k) }
  end

  # return 3d array of binary nums (array of blocks with subblocks) 
  # [ [[sub], [sub]], [[sub], [sub]] ]
  def blockinate(bytes)
    tmp = bytes.each_slice(4).to_a
    if tmp.last.size < 4
      n = 4 - tmp.last.size
      n.times { |n| tmp.last << 0 }
    end
    @blocks = tmp.each_slice(2).to_a
    if @blocks.last.size == 1
      @blocks.last << [0] * 4
    end
  end
end
