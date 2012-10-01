#######################################
# make some checks for input
############################
if !@parsedOpts.assoc('--input')
  $stderr.puts "ERROR: No input file specified!"
  exit
end
if !FileTest.file?(@parsedOpts.assoc('--input')[1])
  $stderr.puts "ERROR: input file named '#{@parsedOpts.assoc('--input')[1]}' does not exist"
  exit
end
if !FileTest.size?(@parsedOpts.assoc('--input')[1])
  $stderr.puts "ERROR: file '#{@parsedOpts.assoc('--input')[1]}' is empty"
  exit
end

#######################################
# checks for output
###################
if !@parsedOpts.assoc('--output')
  $stderr.puts "ERROR: No output file specified!"
  exit
end
if FileTest.file?(@parsedOpts.assoc('--output')[1]) && !@parsedOpts.assoc('--overwrite-output')
  $stderr.puts "ERROR: output file named '#{@parsedOpts.assoc('--output')[1]}' exists"
  exit
end

#######################################
# Lets see what we have to do
#############################
if !@parsedOpts.assoc('--encrypt') && !@parsedOpts.assoc('--decrypt')
  $stderr.puts "ERROR: No action specified!\nI can't decide for you what you want to do!"
  exit
end
if @parsedOpts.assoc('--encrypt') && @parsedOpts.assoc('--decrypt')
  $stderr.puts "ERROR: Only one action can be specified!"
  exit
end

#######################################
# cipher checks
###############
if !@parsedOpts.assoc('--algorithm')
  $stderr.puts "ERROR: Cipher needs to be defined!"
  exit
end

if !['twofish', 'blowfish'].index(@parsedOpts.assoc('--algorithm')[1].downcase)
  $stderr.puts "ERROR: Unrecognized cipher!"
  exit
end

if !@parsedOpts.assoc('--mode')
  $stderr.puts "ERROR: Cipher mode needs to be defined!"
  exit
end

if !['cbc','cfb','ecb','ofb'].index(@parsedOpts.assoc('--mode')[1].downcase)
  $stderr.puts "ERROR: Unrecognized cipher mode!"
  exit
end

if 'twofish' == @parsedOpts.assoc('--algorithm')[1].downcase && 
  !['cbc','ecb'].index(@parsedOpts.assoc('--mode')[1].downcase)
  $stderr.puts "ERROR: Included implementation of twofish does not support this mode!"
  exit
end

if !@parsedOpts.assoc('--passphrase') || @parsedOpts.assoc('--passphrase')[1].length == 0
  $stdout.puts "WARNING: Yes... no password... so secure!"
end
