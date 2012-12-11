R2Fish
======

School project - CLI data encryption with Blowfish in Ruby which was originally Twofish project (hence the name)

There is a complete fuck-up with key length. I can't set any other key length than 16 bytes.
Dunno who is the one to blame.
According to:
http://linux.die.net/man/3/evp_cipher_ctx_set_key_length 
OpenSSL should've been able to set.

However judging from OpenSSL module source from ruby they fucked up in:
ossl_cipher_initialize(VALUE self, VALUE str)
because they want to be totally ready to use .update() without worrying about SEGV

I'm not sure if one can set another key length once cipher is initialized with some key...

Further reading:
http://www.openssl.org/docs/crypto/EVP_EncryptInit.html


Decomposition

Ruby call:
> cipher = OpenSSL::Cipher.new('bf')
calls:
ossl_cipher_initialize(VALUE self, VALUE str)
{
    EVP_CIPHER_CTX *ctx;
    const EVP_CIPHER *cipher;
    char *name;
    unsigned char key[EVP_MAX_KEY_LENGTH];

    name = StringValuePtr(str);
    GetCipherInit(self, ctx);
    if (ctx) {
        ossl_raise(rb_eRuntimeError, "Cipher already inititalized!");
    }
    AllocCipher(self, ctx);
    EVP_CIPHER_CTX_init(ctx);
    if (!(cipher = EVP_get_cipherbyname(name))) {
        ossl_raise(rb_eRuntimeError, "unsupported cipher algorithm (%s)", name);
    }
    /*
     * The EVP which has EVP_CIPH_RAND_KEY flag (such as DES3) allows
     * uninitialized key, but other EVPs (such as AES) does not allow it.
     * Calling EVP_CipherUpdate() without initializing key causes SEGV so we
     * set the data filled with "\0" as the key by default.
     */
    memset(key, 0, EVP_MAX_KEY_LENGTH);
    if (EVP_CipherInit_ex(ctx, cipher, NULL, key, NULL, -1) != 1)
        ossl_raise(eCipherError, NULL);

    return self;
}

Ruby call:
> cipher.encrypt()
calls:
ossl_cipher_encrypt(int argc, VALUE *argv, VALUE self)
{
    return ossl_cipher_init(argc, argv, self, 1);
}

ossl_cipher_init(int argc, VALUE *argv, VALUE self, int mode)
{
    EVP_CIPHER_CTX *ctx;
    unsigned char key[EVP_MAX_KEY_LENGTH], *p_key = NULL;
    unsigned char iv[EVP_MAX_IV_LENGTH], *p_iv = NULL;
    VALUE pass, init_v;

    if(rb_scan_args(argc, argv, "02", &pass, &init_v) > 0){
        /*
         * oops. this code mistakes salt for IV.
         * We deprecated the arguments for this method, but we decided
         * keeping this behaviour for backward compatibility.
         */
        const char *cname  = rb_class2name(rb_obj_class(self));
        rb_warn("arguments for %s#encrypt and %s#decrypt were deprecated; "
                "use %s#pkcs5_keyivgen to derive key and IV",
                cname, cname, cname);
        StringValue(pass);
        GetCipher(self, ctx);
        if (NIL_P(init_v)) memcpy(iv, "OpenSSL for Ruby rulez!", sizeof(iv));
        else{
            StringValue(init_v);
            if (EVP_MAX_IV_LENGTH > RSTRING_LEN(init_v)) {
                memset(iv, 0, EVP_MAX_IV_LENGTH);
                memcpy(iv, RSTRING_PTR(init_v), RSTRING_LEN(init_v));
            }
            else memcpy(iv, RSTRING_PTR(init_v), sizeof(iv));
        }
        EVP_BytesToKey(EVP_CIPHER_CTX_cipher(ctx), EVP_md5(), iv,
                       (unsigned char *)RSTRING_PTR(pass), RSTRING_LENINT(pass), 1, key, NULL);
        p_key = key;
        p_iv = iv;
    }
    else {
        GetCipher(self, ctx);
    }
    if (EVP_CipherInit_ex(ctx, NULL, NULL, p_key, p_iv, mode) != 1) {
        ossl_raise(eCipherError, NULL);
    }

    return self;
}

Ruby call:
> cipher.key = 'some key'
calls:
ossl_cipher_set_key(VALUE self, VALUE key)
{
    EVP_CIPHER_CTX *ctx;

    StringValue(key);
    GetCipher(self, ctx);

    if (RSTRING_LEN(key) < EVP_CIPHER_CTX_key_length(ctx))
        ossl_raise(eCipherError, "key length too short");

    if (EVP_CipherInit_ex(ctx, NULL, NULL, (unsigned char *)RSTRING_PTR(key), NULL, -1) != 1)
        ossl_raise(eCipherError, NULL);

    return key;
}

Ruby call:
> cipher.key_len = 20
calls:
ossl_cipher_set_key_length(VALUE self, VALUE key_length)
{
    int len = NUM2INT(key_length);
    EVP_CIPHER_CTX *ctx;

    GetCipher(self, ctx);
    if (EVP_CIPHER_CTX_set_key_length(ctx, len) != 1)
        ossl_raise(eCipherError, NULL);

    return key_length;
}


Bug report:
OpenSSL::Cipher key_len, iv_len and block_size should read values from cipher context

Currently when  