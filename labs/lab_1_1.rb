#Laboratory work #1
#Performed by Kondratenko Denis, IKIT 417

class Cipher
  attr_accessor :key, :phrase
  attr_reader :mapped_phrase, :vigenere_table, :sub_phrase, :decrypt_flag

  def initialize
    alphabet = 'a'..'z'
    alphabet = alphabet.to_a
    @vigenere_table = Hash.new
    @vigenere_table["alphabet"] = alphabet #инииализируем таблиу виженера с массивом английского алфавита (без смещения)
    @decrypt_flag = false                  #if decrypt_flag false, then method 'substitute' encrypts, if true it decrypts
  end

  def encrypt(phrase, key)
    @phrase = phrase.downcase
    @key = key.downcase
    @decrypt_flag = false
    push_vigenere_table_by_key
    map_key
    substitute
    return @sub_phrase
  end

  def decrypt(phrase, key)
    @phrase = phrase.downcase
    @key = key.downcase
    @decrypt_flag = true
    if @vigenere_table.size == 1
      push_vigenere_table_by_key
      map_key
      substitute
    else
      substitute
    end
    return @sub_phrase
  end

  private

  # создаем таблицу вижинера на основе ключа 
  # чтобы не хранить большой хэш на каждую букву алфавита, 
  # создаем только необходимые массивы со "смещенным" алфавитом
  def push_vigenere_table_by_key
    @key.chars.each do |i|
      range_1 = "#{i}"..'z'
      range_2 = 'a'..."#{i}"
      range_1 = range_1.to_a
      range_2 = range_2.to_a
      @vigenere_table["#{i}"] = range_1 + range_2
    end
  end

  # подстановка во фразу ключа
  def map_key
    k = 0 
    phrase_chars = @phrase.chars
    phrase_chars.each_index do |i|
      key_char = @key.chars[k]
      unless phrase_chars[i] =~ /[^\w]|[\d]|[\s]/    #игнорируем пробелы и все что не являеться буквой
        phrase_chars[i] = key_char
        k += 1
      end
      k = 0 if k == @key.length
    end
    @mapped_phrase = phrase_chars.join('')
  end

  # if decrypt_flag false - then method 'substitute' encrypts 
  # if true - it decrypts
  def substitute
    alphabet = @vigenere_table["alphabet"]                                        # алфавит без ключа
    encrypted_phrase_chars = @mapped_phrase.chars
    encrypted_phrase_chars.each_with_index do |char, i|
      unless char =~ /[^\w]|[\d]|[\s]/
        target = @phrase.chars[i]                                                 # буква которую заменяем 
        unless @decrypt_flag
          target_index = @vigenere_table['alphabet'].index("#{target}")           # индекс буквы на которую будем заменяь в адфавите для подмены
          encrypted_phrase_chars[i] = @vigenere_table["#{char}"][target_index]    # подмена буквы на букву из таблицы вижинера
        else
          target_index = @vigenere_table["#{char}"].index("#{target}")            # индекс буквы на которую будем заменяь в адфавите для подмены
          encrypted_phrase_chars[i] = alphabet[target_index]                      # подмена буквы на букву из алфавита
        end
      end
    end
    @sub_phrase = encrypted_phrase_chars.join('')      #заменённая фраза (зависит от флага @decrypt_flag, или зашифрованная, или расшифрованная)
  end
end