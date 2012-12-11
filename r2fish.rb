#!/usr/bin/env ruby
# encoding: utf-8

# $ ruby -e "require 'openssl'; c=OpenSSL::Cipher.new 'bf'; puts c.key_len; c.key_len=5; puts c.key_len"

$stdout.puts <<-END
============================================
   BSK.Project - Blowfish file de/encrypt
============================================

END

# Schować guzik po kliknięciu żeby zablokować stackowanie kliknięć

include FileTest

require 'getoptlong'
require 'securerandom'
require 'openssl'
require 'base64'

require './cli/help'
require './resources/stringxor.rb'

begin
  
  require 'Qt4'
  
  require './resources/icons'
  require './ui/Ui_R2Fish'
  require './ui/R2Fish'
  require './ui/R2Fish_help'
  
  $GUI_AVAILABLE = true
rescue LoadError
  err = $!
  $stderr.puts 'Some GUI deps were not found :: GUI will not be available'
  $stderr.puts 'Be sure to have "qtbindings" gem installed'
  $stderr.puts
  p err 
  $GUI_AVAILABLE = false
end

opts = GetoptLong.new(
  ['--input',             '-i', GetoptLong::REQUIRED_ARGUMENT],
  ['--output',            '-o', GetoptLong::REQUIRED_ARGUMENT],
  ['--mode',              '-m', GetoptLong::REQUIRED_ARGUMENT],
  ['--feedback',          '-f', GetoptLong::OPTIONAL_ARGUMENT],
  ['--passphrase',        '-p', GetoptLong::OPTIONAL_ARGUMENT],
  ['--keysize',           '-k', GetoptLong::OPTIONAL_ARGUMENT],
  ['--overwrite-output',  '-O', GetoptLong::NO_ARGUMENT],
  ['--encrypt',           '-e', GetoptLong::NO_ARGUMENT],
  ['--decrypt',           '-d', GetoptLong::NO_ARGUMENT],
  ['--no-gui',            '-n', GetoptLong::NO_ARGUMENT],
    
  ['--debug',             '-D', GetoptLong::NO_ARGUMENT],
  ['--help',              '-h', GetoptLong::NO_ARGUMENT]
)
opts.quiet = true

# And you shall become the one known to everyone!
@parsedOpts = Array.new

begin
  opts.each do |opt, arg|
    @parsedOpts.push( [opt, arg] )
  end
rescue GetoptLong::InvalidOption
  $stderr.puts "ERROR: Hi, Y U using unknown opts?"
  $stderr.puts "ERROR: #{opts.error_message()}"
  usage
  exit
rescue GetoptLong::NeedlessArgument
  $stderr.puts "ERROR: Hi, Y U stuffing me things?"
  $stderr.puts "ERROR: #{opts.error_message()}"
  usage
  exit
rescue GetoptLong::MissingArgument
  $stderr.puts "ERROR: Hi, Y U no feed me right?"
  $stderr.puts "ERROR: #{opts.error_message()}"
  usage
  exit
end

if @parsedOpts.assoc('--help')
  $stdout.puts(Cli::help())
  exit
end


def crypto (fin, fout, task, password, keysize, mode, feedbackSize, interface)
  
  # $stdout.puts "Crypto initiated with task: " + task
  
  keyFromPassword = OpenSSL::PKCS5.pbkdf2_hmac_sha1(password, '', 2000, 128)
    
  finHandler = File.open(fin, 'rb')
  foutHandler = File.open(fout, 'wb+')
  
  dataSize = finSize = File.size(fin)
  
  cipherKey = OpenSSL::Cipher.new('bf-ecb')
  cipherKey.key_len = keyFromPassword.length
  cipherKey.key = keyFromPassword
  

  
  # hdr_len:            1
  # cipher_name_len:    1
  # prefix_cipher_name: 5
  # cipher_name:        8
  # mode_len            1
  # prefix_mode:        4
  # mode:               3
  # fb_len:             1
  # key_len:            1
  # prefix_key:         5 
  # key:                56
  # iv_len:             1
  # prefix_iv:          5
  # iv:                 8

  
  if (task == "decryption")
    # TODO odczytać nagłówek i zmielić dane z niego
    
    headerSize = finHandler.read(1).unpack("C")[0].to_i
    finHandler.seek(0, IO::SEEK_SET)
    
    header = finHandler.read(headerSize)
    header = header.unpack("C" + "Ca5a8" + "Ca5a3C" + "Ca5a56" + "Ca5a8")
    
    mode = header[6]
    feedbackSize = header[7]
    sessionKeyEncrypted = header[10][0..(header[8]-6)]
    iv = header[13][0..(header[11]-6)]
    
    # $stdout.puts "sessionKeyEncrypted: " + sessionKeyEncrypted
    
    if (mode.downcase == 'cbc')
      cipher = OpenSSL::Cipher.new('bf-cbc')
    else
      cipher = OpenSSL::Cipher.new('bf-ecb')
    end
    
    # for OFB and CFB we're always encrypting ;)
    if (['cfb', 'ofb'].include?(mode.downcase))
      $stdout.puts "Decrytion override due to fact that CFB and OFB are always encrypting"
      cipher.encrypt()
    else 
      cipher.decrypt()
    end
    
    cipherKey.decrypt()
    
    cipherKey.key = keyFromPassword
    sessionKey = ''
    sessionKey += cipherKey.update(sessionKeyEncrypted)
    
    begin
      sessionKey += cipherKey.final()
    rescue
      sessionKey = sessionKeyEncrypted
    end

    # $stdout.puts "sessionKey: " + sessionKey
    
  end
  
  if (task == "encryption")
    if (mode.downcase == 'cbc')
      cipher = OpenSSL::Cipher.new('bf-cbc')
    else
      cipher = OpenSSL::Cipher.new('bf-ecb')
    end
    cipher.encrypt()
    cipherKey.encrypt()
    
    sessionKey = SecureRandom.random_bytes(keysize)
    # $stdout.puts "sessionKey: " + sessionKey

    # użycie ciągu wytworzonego z hasła jako klucza do szyfrowania klucza sesyjnego
    cipherKey.key = keyFromPassword

    sessionKeyEncrypted = ''
    sessionKeyEncrypted += cipherKey.update(sessionKey)
    sessionKeyEncrypted += cipherKey.final()
    # `sessionKeyEncrypted` zawiera zaszyfrowany klucz sesyjny
    # $stdout.puts "sessionKeyEncrypted: " + sessionKeyEncrypted
    
    iv = SecureRandom.random_bytes(cipher.block_size)
    
    header = [
      13, "CIPH", "Blowfish", 
      7, "MODE", mode, feedbackSize, 
      (sessionKeyEncrypted.length+5), "KEY", sessionKeyEncrypted,
      (iv.length+5), "IV", iv
      ].pack("Ca5a8" + "Ca5a3C" + "Ca5a56" + "Ca5a8")
    
    header = [header.length+1].pack("C") + header 
    # header zostaje zapisany do pliku wynikowego
    foutHandler.write(header)
  end
  
  cipher.key_len = sessionKey.length
  cipher.key = sessionKey
  
  cipher.iv = iv

  shiftRegister = iv

  # $stdout.puts 'IV/shiftRegister :: ' + iv
  
#  $stdout.puts "Entering " + task
#  $stdout.puts "Mode: " + mode.upcase
#  $stdout.puts "feedbackSize: " + feedbackSize.to_s
#  $stdout.puts "IV: " + iv.unpack("H*")[0]
#  $stdout.puts "shiftRegister: " + shiftRegister.unpack("H*")[0]
#  $stdout.puts "sessionKey: " + sessionKey.unpack("H*")[0]
  
  
  blockNo = 0;
  blockCount = dataSize / feedbackSize
  
  while inputPart = finHandler.read(feedbackSize)
    blockNo += 1
    
    if (['cfb', 'ofb'].include?(mode.downcase))
      cipherBlock = cipher.update(shiftRegister);
      cipherBlockPart = cipherBlock.byteslice(0, feedbackSize)
      xoredPart = (inputPart ^ cipherBlockPart)
      shiftRegister = shiftRegister.byteslice(feedbackSize, (shiftRegister.length - feedbackSize))
      if ('cfb' == mode.downcase)
        if (task == 'encryption')
          shiftRegister = shiftRegister + xoredPart
        else
          shiftRegister = shiftRegister + inputPart
        end
      end
      if ('ofb' == mode.downcase)
        shiftRegister = shiftRegister + cipherBlockPart
      end
      output = xoredPart
    else
      output = cipher.update(inputPart)
    end
    
    foutHandler.write(output)
    
    if (nil != interface)
      interface.progress_update(blockNo, blockCount)
    end
    
  end
  
  if !['cfb', 'ofb'].include?(mode.downcase)
    begin
      foutHandler.write(cipher.final())
    rescue
    end
  end
  finHandler.close()
  foutHandler.close()
  
  
end

if !@parsedOpts.assoc('--no-gui') && $GUI_AVAILABLE

  app = Qt::Application.new(ARGV)
  
  r2fish = R2Fish.new()
  r2fish.show()
  
  app.exec()
  
  
else
  # don't think... do...
  load 'cli/checks.rb'
  if (@parsedOpts.assoc('--encrypt'))
    task = 'encryption'
  end
  
  if (@parsedOpts.assoc('--decrypt'))
    task = 'decryption'
  end
  
  crypto(
    @parsedOpts.assoc('--input')[1],
    @parsedOpts.assoc('--output')[1],
    task,
    @parsedOpts.assoc('--passphrase')[1],
    @parsedOpts.assoc('--keysize')[1].to_i,
    @parsedOpts.assoc('--mode')[1],
    @parsedOpts.assoc('--feedback')[1].to_i,
    nil)
end

