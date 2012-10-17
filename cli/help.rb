module Cli
  
  def self.help
<<-END
Help shall be given to you

Usage: #{__FILE__} [OPTIONS]

-h, --help:
    show help

-i FILE, --input FILE:
    input file
  
-o FILE, --output FILE:
    output file
  
-O, --overwrite-output:
    overwrite output file if it exists
  
-e, --encrypt:
    output file becomes encrypted version of input file
  
-d, --decrypt:
    output file becomes decrypted version of input file
  
-m MODE, --mode MODE:
    cipher mode, which is one of:
      CBC, CFB, ECB, OFB
  
-p PASSPHRASE, --passphrase PASSPHRASE:
    passphrase to use
  
... and that concludes your basic tutorial
END
  end
  
end