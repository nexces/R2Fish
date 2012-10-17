#!/usr/bin/env ruby

$KCODE='u'

$stdout.puts <<-END
============================================
   BSK.Project - Blowfish file de/encrypt
============================================

END


include FileTest

require 'rubygems'  
require 'getoptlong'
require 'openssl'
require 'base64'

require 'Qt4'

require 'cli/help'

require 'resources/icons'
require 'ui/Ui_R2Fish'
require 'ui/R2Fish'
require 'ui/R2Fish_help'

opts = GetoptLong.new(
  ['--input',             '-i', GetoptLong::REQUIRED_ARGUMENT],
  ['--output',            '-o', GetoptLong::REQUIRED_ARGUMENT],
  ['--mode',              '-m', GetoptLong::REQUIRED_ARGUMENT],
  ['--passphrase',        '-p', GetoptLong::OPTIONAL_ARGUMENT],
  ['--overwrite-output',  '-O', GetoptLong::NO_ARGUMENT],
  ['--encrypt',           '-e', GetoptLong::NO_ARGUMENT],
  ['--decrypt',           '-d', GetoptLong::NO_ARGUMENT],
  ['--no-gui',            '-n', GetoptLong::NO_ARGUMENT],
    
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

if !@parsedOpts.assoc('--no-gui') 

  app = Qt::Application.new(ARGV)
  
  r2fish = R2Fish.new()
  r2fish.show()
  
  app.exec()
  
  
else
  # don't think... do...
  load 'cli/checks.rb'
  
  bf = OpenSSL::Cipher::Cipher.new('bf-' + @parsedOpts.assoc('--mode')[1].downcase)
end
