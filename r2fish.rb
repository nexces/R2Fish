#!/usr/bin/env ruby

$stdout.puts <<-END
===========================================
    BSK.Project - *fish file de/encrypt
===========================================

END


$:.push(
  'twofish.rb/lib', 
  'twofish.rb/lib/twofish',
  'parts'
  )

include FileTest
  
require 'getoptlong'
require 'openssl'
require 'base64'

require 'twofish'

require 'usage'



opts = GetoptLong.new(
  ['--input',             '-i', GetoptLong::REQUIRED_ARGUMENT],
  ['--output',            '-o', GetoptLong::REQUIRED_ARGUMENT],
  ['--algorithm',         '-a', GetoptLong::REQUIRED_ARGUMENT],
  ['--mode',              '-m', GetoptLong::REQUIRED_ARGUMENT],
  ['--passphrase',        '-p', GetoptLong::OPTIONAL_ARGUMENT],
  ['--overwrite-output',  '-O', GetoptLong::NO_ARGUMENT],
  ['--encrypt',           '-e', GetoptLong::NO_ARGUMENT],
  ['--decrypt',           '-d', GetoptLong::NO_ARGUMENT],
  ['--crap',              '-c', GetoptLong::NO_ARGUMENT],
    
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

if @parsedOpts.assoc('--crap')
  $stdout.puts OpenSSL::Cipher.ciphers
  exit
end

if @parsedOpts.assoc('--help')
  usage
  exit
end

# don't think... do...
load 'parts/checks.rb'


if @parsedOpts.assoc('--passphrase')
  key = @parsedOpts.assoc('--passphrase')[1]
else
  key = ''
end


if 'twofish' == @parsedOpts.assoc('--algorithm')[1]
  mode = case @parsedOpts.assoc('--mode')[1].downcase
    when 'cbc' then Twofish::Mode::CBC
    when 'ecb' then Twofish::Mode::ECB
  end
  
  tf = Twofish.new(key, :mode => mode)
  tf.iv = OpenSSL::Random.random_bytes(16)
  
  crypted = tf.encrypt(File.open(@parsedOpts.assoc('--input')[1], 'rb').read)
  puts Base64.encode64(crypted)
end
