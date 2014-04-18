# laboratory work #2.2
# performed by Kondratenko Denis, ICIT 417
# All rights reserved (c)

class FeistelCipher
  attr_reader :encrypted_phrase, :decrypted_phrase, :blocks
  ROUNDS = 16

  def encrypt(phrase, key)
    blockinate phrase
    @blocks.each_with_index do |block, i|
      left  = block[0]
      right = block[1]
      ROUNDS.times do
        tmp   = xor(f_enc(left, key), right)
        right = left
        left  = tmp
      end
      @blocks[i] = left + right
      @blocks[i] = characterize @blocks[i]
    end
    @encrypted_phrase = @blocks.join('')
  end

  def decrypt(phrase, key)
    blockinate phrase
    @blocks.each_with_index do |block, i|
      left  = block[0]
      right = block[1]
      ROUNDS.times do
        tmp   = xor(left, f_dec(right, key))
        left  = right
        right = tmp
      end
      @blocks[i] = left + right
      @blocks[i] = characterize @blocks[i]
    end
    @decrypted_phrase = @blocks.join('')
  end

  private
  def xor(left, right)
    res = Array.new
    0.upto(3) do |i|
      temp = left[i] ^ right[i]
      res << temp
    end
    res
  end

  # works with strings that consists only of 1 char :D
  # optimal integer radix is 3 (numbers from 0..999)
  def f_enc(block, key)
    unless key.class == String
      block.map { |i| i.odd? ? i ^ key : i ^ ROUNDS }
    else
      key = key.bytes.join.to_i
      block.map { |i| i.odd? ? i ^ key : i ^ ROUNDS }
    end
  end

  # works with strings that consists only of 1 char :D
  # optimal integer radix is 3 (numbers from 0..999)
  def f_dec(block, key)
    unless key.class == String
      block.map { |i| i.even? ? i ^ key : i ^ ROUNDS }
    else
      key = key.bytes.join.to_i
      block.map { |i| i.even? ? i ^ key : i ^ ROUNDS }
    end
  end

  # return 3d array of binary nums (array of blocks with subblocks) 
  # [ [[sub], [sub]], [[sub], [sub]] ]
  def blockinate(phrase)
    tmp = phrase.bytes.each_slice(4).to_a
    if tmp.last.size < 4
      n = 4 - tmp.last.size
      n.times { |n| tmp.last << 0 }
    end
    @blocks = tmp.each_slice(2).to_a
    if @blocks.last.size == 1
      @blocks.last << [0] * 4
    end
  end

  def characterize(block)
    ch = block
    ch.each_index do |i|
      ch[i] = ch[i].chr.unpack("C*").pack("U*")
    end
    ch.join('')
  end
end
