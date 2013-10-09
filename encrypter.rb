class Encryptor
  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    Hash[characters.zip(rotated_characters)]
  end

  def encrypt_letter(letter,rotate)
    cipher_for_rotation = cipher(rotate)
    cipher_for_rotation[letter]
  end

  def encrypt(string,rotate)
    results = string.split("").collect do |letter| 
      encrypt_letter(letter,rotate)
    end
    results.join  
  end

  def decrypt_letter(letter,rotate)
  	cipher_for_rotation = cipher(rotate)
  	cipher_for_rotation.invert
  	cipher_for_rotation[letter]
  end

  def decrypt(string,rotate)
    encrypt(string, rotate * -1)  
  end

  def encrypt_file (filename,rotate)
  	new_file_name = "#{filename}.encrypted"
    encrypted_contents = encrypt(get_file_contents(filename),rotate)
    puts "#{encrypted_contents}"    
    write_to_file(new_file_name,encrypted_contents)
    puts "#{filename} has been encrypted and renamed to #{filename}.encrypted"
  end

  def decrypt_file(filename,rotate)
    new_file_name = filename.gsub(".encrypted", ".decrypted")
    file_contents = get_file_contents(filename)
    decrypted_contents = decrypt(file_contents, rotate)
    puts "#{decrypted_contents}"
    write_to_file(new_file_name, decrypted_contents)
    puts "#{filename} has been decrypted and renamed to #{filename}"

  end   

  def write_to_file(filename,data)
    output = File.open(filename, "w")
    output.write(data)
    output.close
  end	
  
  def get_file_contents(filename)
    input = File.open(filename, "r")
    contents = input.read
    input.close
    return contents
  end    

end


e = Encryptor.new
e.encrypt_file("sample.txt", 11)
e.decrypt_file("sample.txt.encrypted", 11)


#e.encrypt("q")
#e.decrypt("d")
#e.decrypt("onananf")
#e.encrypt("bananas")