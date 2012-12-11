# encoding: utf-8

#require 'rubygems'
#require 'crypt/blowfish'
#
#blowfish = Crypt::Blowfish.new("key")
#plainBlock = "ABCD1234"
#encryptedBlock = blowfish.encrypt_block(plainBlock)
#
#exit

module Crypt
  module StringXor
  
    def ^(a_string)
      a = self.unpack('C'*(self.length))
      b = a_string.unpack('C'*(a_string.length))
      if (b.length < a.length)
        (a.length - b.length).times { b << 0 }
      end
      xor = ""
      0.upto(a.length-1) { |pos|
        x = a[pos] ^ b[pos]
        xor << x.chr()
      }
      return(xor)
    end
  
  end
end

class String
  include Crypt::StringXor
end

# CFB ENCRYPT
# 1. przygotować IV do ECB
# 2. zaszyfrować IV w trybie ECB

# 3. zabrać z wyjścia (2) z ECB [feedbackSize] bajtów z początku
# 4. StringXor [feedbackSize] bajtów wejścia z [feedbackSize] bajtami wyjścia ECB
# 5. Efekt (4) dodać do szyfrogramu
# 6. Efekt (4) wstawić na koniec IV do ECB z (1)
# 7. Usunąć [feedbackSize] bajtów z -początku- IV do ECB z (1)

require 'openssl'

input = 'abcdefghijklmnopqrstuwvxyz'


#feedbackSize = 3
#
puts 'RUBY :: CFB from ECB'
puts '      IN: ' + input.bytesize.to_s + ' :: ' + input

for feedbackSize in 1..8
  output = ''
  inputPosition = 0

  c = OpenSSL::Cipher.new('bf-ecb')
  
  
  c.encrypt
  c.key = '1234567890123456'
  
  # initialize shiftRegister
  shiftRegister = '00000000'
  
  # LOOP
  while inputPart = input.byteslice(inputPosition, feedbackSize)
    if inputPart.length() == 0
      break
    end
    
    # start mangling
    cipherBlock = c.update(shiftRegister);
    
    # set new position in input
    inputPosition += feedbackSize # new position in input
    
    # extract [feedbackSize] bytes from the begining of encrypted block for XORing with inputPart
    cipherBlockPart = cipherBlock.byteslice(0, feedbackSize)
    
    # XOR inputPart with cipherBlockPart (lengths should be equal?)
    xoredPart = (inputPart ^ cipherBlockPart)
    
    # append xoredPart to output
    output += xoredPart
    
    # overwrite shiftRegister with that part of shiftRegister that should be left
    # start at position [feedbackSize] and extract that many bytes as [feedbackSize]
    shiftRegister = shiftRegister.byteslice(feedbackSize, (shiftRegister.length - feedbackSize))
      
    # add xoredPart to the end of shiftRegister
    shiftRegister = shiftRegister + xoredPart
      
  end
  # ENDLOOP
  
  puts ' CFB OUT: ' + output.bytesize.to_s + ' :: ' + output.unpack('h*')[0] + ' :: feedbackSize: ' + feedbackSize.to_s
  
  #
  # DECRYPTION CFB
  #
  # reinitialize for decryption
  outputDecrypted = ''
  inputPosition = 0
  
  c = OpenSSL::Cipher.new('bf-ecb')
  
  
  c.encrypt
  c.key = '1234567890123456'
  
  # initialize shiftRegister
  shiftRegister = '00000000'
  
  # LOOP
  while inputPart = output.byteslice(inputPosition, feedbackSize)
    if inputPart.length() == 0
      break
    end
    
    # start mangling
    cipherBlock = c.update(shiftRegister);
    
    # set new position in input
    inputPosition += feedbackSize # new position in input
    
    # extract [feedbackSize] bytes from the begining of encrypted block for XORing with inputPart
    cipherBlockPart = cipherBlock.byteslice(0, feedbackSize)
    
    # XOR inputPart with cipherBlockPart (lengths should be equal?)
    xoredPart = (inputPart ^ cipherBlockPart)
    
    # append xoredPart to output
    outputDecrypted += xoredPart
    
    # overwrite shiftRegister with that part of shiftRegister that should be left
    # start at position [feedbackSize] and extract that many bytes as [feedbackSize]
    shiftRegister = shiftRegister.byteslice(feedbackSize, (shiftRegister.length - feedbackSize))
      
    # add xoredPart to the end of shiftRegister
    # shiftRegister = shiftRegister + xoredPart
    
    # when decrypting add inputPart to the end of shiftRegister
    shiftRegister = shiftRegister + inputPart
      
  end
  # ENDLOOP
  
puts 'RCFB OUT: ' + outputDecrypted.bytesize.to_s + ' :: ' + outputDecrypted + ' :: feedbackSize: ' + feedbackSize.to_s
end

puts 'RUBY :: OFB from ECB'
puts '      IN: ' + input.bytesize.to_s + ' :: ' + input

for feedbackSize in 1..8
  output = ''
  inputPosition = 0

  c = OpenSSL::Cipher.new('bf-ecb')
  
  
  c.encrypt
  c.key = '1234567890123456'
  
  # initialize shiftRegister
  c.iv = shiftRegister = '00000000'
  
  # LOOP
  while inputPart = input.byteslice(inputPosition, feedbackSize)
    if inputPart.length() == 0
      break
    end
    
    # start mangling
    cipherBlock = c.update(shiftRegister);
    
    # set new position in input
    inputPosition += feedbackSize # new position in input
    
    # extract [feedbackSize] bytes from the begining of encrypted block for XORing with inputPart
    cipherBlockPart = cipherBlock.byteslice(0, feedbackSize)
    
    # XOR inputPart with cipherBlockPart (lengths should be equal?)
    xoredPart = (inputPart ^ cipherBlockPart)
    
    # append xoredPart to output
    output += xoredPart
    
    # overwrite shiftRegister with that part of shiftRegister that should be left
    # start at position [feedbackSize] and extract that many bytes as [feedbackSize]
    shiftRegister = shiftRegister.byteslice(feedbackSize, (shiftRegister.length - feedbackSize))
      
    # add xoredPart to the end of shiftRegister 
    # shiftRegister = shiftRegister + xoredPart
    
    # OFB doesn't uses cipherBlockPart in place of xoredPart for filling shiftRegister
    shiftRegister = shiftRegister + cipherBlockPart
      
  end
  # ENDLOOP
  
  puts ' OFB OUT: ' + output.bytesize.to_s + ' :: ' + output.unpack('h*')[0] + ' :: feedbackSize: ' + feedbackSize.to_s
  
  #
  # DECRYPTION CFB
  #
  # reinitialize for decryption
  outputDecrypted = ''
  inputPosition = 0

  c = OpenSSL::Cipher.new('bf-ecb')
  
  
  c.encrypt
  c.key = '1234567890123456'
  
  # initialize shiftRegister
  c.iv = shiftRegister = '00000000'
  
  # LOOP
  while inputPart = output.byteslice(inputPosition, feedbackSize)
    if inputPart.length() == 0
      break
    end
    
    # start mangling
    cipherBlock = c.update(shiftRegister);
    
    # set new position in input
    inputPosition += feedbackSize # new position in input
    
    # extract [feedbackSize] bytes from the begining of encrypted block for XORing with inputPart
    cipherBlockPart = cipherBlock.byteslice(0, feedbackSize)
    
    # XOR inputPart with cipherBlockPart (lengths should be equal?)
    xoredPart = (inputPart ^ cipherBlockPart)
    
    # append xoredPart to output
    outputDecrypted += xoredPart
    
    # overwrite shiftRegister with that part of shiftRegister that should be left
    # start at position [feedbackSize] and extract that many bytes as [feedbackSize]
    shiftRegister = shiftRegister.byteslice(feedbackSize, (shiftRegister.length - feedbackSize))
      
    # add xoredPart to the end of shiftRegister 
    # shiftRegister = shiftRegister + xoredPart
    
    # OFB doesn't uses cipherBlockPart in place of xoredPart for filling shiftRegister
    shiftRegister = shiftRegister + cipherBlockPart
      
  end
  # ENDLOOP
  
  puts 'ROFB OUT: ' + outputDecrypted.bytesize.to_s + ' :: ' + outputDecrypted + ' :: feedbackSize: ' + feedbackSize.to_s
  
  
end

exit

puts 'RUBY :: Actual'
puts '      IN: ' + input.bytesize.to_s + ' :: ' + input

c = OpenSSL::Cipher.new('bf-ecb')
c.encrypt
c.key = '1234567890123456'
c.iv = '00000000'
out = c.update(input) 
out += c.final
puts ' ECB OUT: ' + out.bytesize.to_s + ' :: ' + out.unpack('h*')[0]

c = OpenSSL::Cipher.new('bf-cbc')
c.encrypt
c.key = '1234567890123456'
c.iv = '00000000'
out = c.update(input) 
out += c.final
puts ' CBC OUT: ' + out.bytesize.to_s + ' :: ' + out.unpack('h*')[0]

c = OpenSSL::Cipher.new('bf-cfb')
c.encrypt
c.key = '1234567890123456'
c.iv = '00000000'
out = c.update(input) 
out += c.final
puts ' CFB OUT: ' + out.bytesize.to_s + ' :: ' + out.unpack('h*')[0]

c = OpenSSL::Cipher.new('bf-ofb')
c.encrypt
c.key = '1234567890123456'
c.iv = '00000000'
out = c.update(input) 
out += c.final
puts ' OFB OUT: ' + out.bytesize.to_s + ' :: ' + out.unpack('h*')[0]

#c = OpenSSL::Cipher.new('bf-cbc')
#c.decrypt
#c.key = '1234567890123456'
#c.iv = '00000000'
#rin = c.update(out) 
#rin += c.final
#puts 'RIN: ' + rin.bytesize.to_s + ' :: ' + rin

exit

