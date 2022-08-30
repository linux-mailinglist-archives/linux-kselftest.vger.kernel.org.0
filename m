Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B842B5A6180
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 13:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiH3LSn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 07:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiH3LSn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 07:18:43 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A957F3268;
        Tue, 30 Aug 2022 04:18:42 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v5so4575885plo.9;
        Tue, 30 Aug 2022 04:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=grE24v0lhplNrqPfVi9a+1KQidAnwVRGryN7PjklDRg=;
        b=PAob7LNajtx5NsgcRwzDcgq5uuVKilFaVwoJ6aWJll/ydYTliGSJ1JSVZL1P+q4Kvw
         zcjECbq7gAKmSKYyy/gDaiBIye3ctCzPRurBo/doGCDBRw+/W50yCx/yl6AH9aTfMEqp
         VBEAi2iZgjPiins5bjcU+XyMpO+tCgfUivlrjyP/IZDAKvobru4HMclgOfBTaz6h0sVn
         TGScYnKfYvKnW/0ZvUzBJ5VDc2r4SrkATQnBB4lRR4dgFk0N0qHLxQxJy6+eEtn/Xw+C
         0RJ0AeCRq/+FUzTBYBQz3H9y+RO4mj7DH509SuXGe9ZKcGB+xkrXtkGiifQXVO9d9fL9
         qMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=grE24v0lhplNrqPfVi9a+1KQidAnwVRGryN7PjklDRg=;
        b=3U079lN47MQtZ0iqArjqgp0jTcdF6qLW5i2ONPR/KDncd4IqOmuj4RxJ+THefV+f8i
         xdteMBQzcK5DOIQvlSQRCbyiYmAo4P8f5ZGZdvJKge8l3G9u3CEe4lrQmTUlOrA67eHR
         COTKMA00Bi1h7c/pkLONDCJHviZ5doAi5XRnqoHR2ZzxyJYvalLSccimoFRRrNVvIgeE
         99Xmzy1i0ZDcMr6Gs0DI5L4oGS1GLU6Cue/x6laPlgIl4na9CgOLYOhtmC3QFjz7vP+P
         pqxueyKxhByZUI5eLs8gvVA4quiIZIKTPcqzeCx2KpFgWyNbwR7jK6bGLBz4I4m/6eAV
         BcUQ==
X-Gm-Message-State: ACgBeo3g/AekdN1wlEFa1ygzSAeLGfAx65EKMnvr2NjqHsRnBXKd8dN+
        DpFl/CNtJECNN3Q5Lc/bPQGToTA4rALbPw==
X-Google-Smtp-Source: AA6agR6IyZqWdbANz+5DyF9I50LpwUemRHmtw2sPIfMTjiF9O3R1Un2csPfHYsqR7chLutWoo5nDig==
X-Received: by 2002:a17:902:c613:b0:174:7a32:f76 with SMTP id r19-20020a170902c61300b001747a320f76mr13598509plr.165.1661858321927;
        Tue, 30 Aug 2022 04:18:41 -0700 (PDT)
Received: from [192.168.1.9] ([112.134.153.184])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ab9100b0016dc78d0153sm9357784plr.296.2022.08.30.04.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 04:18:41 -0700 (PDT)
Message-ID: <86e2c049-b289-8b1f-9fc2-8938abefa7d4@gmail.com>
Date:   Tue, 30 Aug 2022 11:18:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Firefox/102.0
Subject: Re: [PATCH] selftests/sgx: Fix OpenSSL deprecated warning for
 ERR_get_error_line
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     dave.hansen@linux.intel.com, shuah@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220828061859.181061-1-wdnuka@gmail.com>
 <Ywyt4tvHrK4r48RK@kernel.org> <Yw17hyrjX1AiELZG@kernel.org>
From:   Dhanuka <wdnuka@gmail.com>
In-Reply-To: <Yw17hyrjX1AiELZG@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/30/22 02:52, Jarkko Sakkinen wrote:
> On Mon, Aug 29, 2022 at 03:15:30PM +0300, Jarkko Sakkinen wrote:
>> On Sun, Aug 28, 2022 at 11:48:59AM +0530, Dhanuka Warusadura wrote:
>>> These changes fix the "error: ‘ERR_get_error_line’ is deprecated:
>>> Since OpenSSL 3.0" warning.
>>>
>>> Signed-off-by: Dhanuka Warusadura <wdnuka@gmail.com>
>>> ---
>>>   tools/testing/selftests/sgx/sigstruct.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
>>> index 50c5ab1aa6fa..671d9b58e274 100644
>>> --- a/tools/testing/selftests/sgx/sigstruct.c
>>> +++ b/tools/testing/selftests/sgx/sigstruct.c
>>> @@ -136,7 +136,7 @@ static bool check_crypto_errors(void)
>>>   			break;
>>>   
>>>   		had_errors = true;
>>> -		err = ERR_get_error_line(&filename, &line);
>>> +		err = ERR_peek_last_error_line(&filename, &line);
>>>   		ERR_error_string_n(err, str, sizeof(str));
>>>   		fprintf(stderr, "crypto: %s: %s:%d\n", str, filename, line);
>>>   	}
>>> -- 
>>> 2.37.2
>>>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Actually NAK.
>
> This fix is not complete:
>
> sigstruct.c: In function ‘get_modulus’:
> sigstruct.c:151:9: error: ‘RSA_get0_key’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
>    151 |         RSA_get0_key(key, &n, NULL, NULL);
>        |         ^~~~~~~~~~~~
> In file included from /usr/include/openssl/x509.h:36,
>                   from /usr/include/openssl/pem.h:23,
>                   from sigstruct.c:16:
> /usr/include/openssl/rsa.h:217:28: note: declared here
>    217 | OSSL_DEPRECATEDIN_3_0 void RSA_get0_key(const RSA *r,
>        |                            ^~~~~~~~~~~~
> sigstruct.c: In function ‘gen_sign_key’:
> sigstruct.c:168:9: error: ‘PEM_read_bio_RSAPrivateKey’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declaration
> ]
>    168 |         key = PEM_read_bio_RSAPrivateKey(bio, NULL, NULL, NULL);
>        |         ^~~
> /usr/include/openssl/pem.h:447:1: note: declared here
>    447 | DECLARE_PEM_rw_cb_attr(OSSL_DEPRECATEDIN_3_0, RSAPrivateKey, RSA)
>        | ^~~~~~~~~~~~~~~~~~~~~~
> sigstruct.c: In function ‘encl_measure’:
> sigstruct.c:364:9: error: ‘RSA_sign’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
>    364 |         if (!RSA_sign(NID_sha256, digest, SHA256_DIGEST_LENGTH,
>        |         ^~
> /usr/include/openssl/rsa.h:348:27: note: declared here
>    348 | OSSL_DEPRECATEDIN_3_0 int RSA_sign(int type, const unsigned char *m,
>        |                           ^~~~~~~~
> sigstruct.c:377:9: error: ‘RSA_free’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
>    377 |         RSA_free(key);
>        |         ^~~~~~~~
> /usr/include/openssl/rsa.h:293:28: note: declared here
>    293 | OSSL_DEPRECATEDIN_3_0 void RSA_free(RSA *r);
>        |                            ^~~~~~~~
> sigstruct.c:382:9: error: ‘RSA_free’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
>    382 |         RSA_free(key);
>        |         ^~~~~~~~
> /usr/include/openssl/rsa.h:293:28: note: declared here
>    293 | OSSL_DEPRECATEDIN_3_0 void RSA_free(RSA *r);
>        |                            ^~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [Makefile:39: /home/jarkko/work/linux-sgx/tools/testing/selftests/sgx/sigstruct.o] Error 1
>
> BR, Jarkko

Thanks for the review.

But, my intention was to just fix the `ERR_get_error_line` deprecated 
warning (as mentioned in the commit header) and not all the OpenSSL 
deprecated warnings found in `sigstruct.c`

Do I need to fix all these OpenSSL deprecated warnings in `sigstruct.c` 
in order to get this patch merged?

Thanks,
Dhanuka

