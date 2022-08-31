Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAD75A76B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 08:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiHaGdf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 02:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHaGde (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 02:33:34 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D4E71BE2;
        Tue, 30 Aug 2022 23:33:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mj6so8182793pjb.1;
        Tue, 30 Aug 2022 23:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/XDxhjNlq4gyzaDjpgxRbEwirHYZSuYrPebUVgPN1pA=;
        b=dJHgTBdoT2PRdenrrTNN8KvYE3ggd+ikQ9ioX48KNObKa1KPUDouNH1Ffc+blt2ujZ
         vHUtFMsJcam3olGKqXlUMDLDOcWDckCyiJPNefxLHD2Ta/Itv/KfThgfKe1V5n+CbZUK
         Bewn8rJ5E9BxElbsc0rrzv9VJzO4+vCK6NoP/F24mSFKNg4fZegdCg45KyTRTm7OeZwI
         quIS929QiSm0sRKjDmaKM3gDI/5ri3KwglhWjULsRwj7RRfUyTnjYgeC0O3s6yyqkrlP
         GXIEOFfPdeWCJ0qNxSsDKXp4M3XEl0xg4kujZcHLIAsIXniw8ZGGDocIJq2sHf48ozoh
         mW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/XDxhjNlq4gyzaDjpgxRbEwirHYZSuYrPebUVgPN1pA=;
        b=p5mzPF4FYDf0k5JxOGXy4s4l8F6a+fJLb95/8Eqe3y6fG8vUaR0cXtnfsRnbNn1mwB
         LgLUf9OE9dPxVy77Zt2dtKSzdqgxU9/+wa6Jktpy/z/GQejWFwq/IlV8GLZ1Lcbz7Z7e
         y/Z9J1idUP10LFnRZXPrKH3M9UgacTEYiAbiacoaTgq+ZoiYi4V0OcoW5mUlD6RcCu40
         ls3t1RnpOyjLsspHdKcNrnxqEnkXy9DyJJ0qLeA/GszHIEOC53CiVb8B2ADR6wfi+SV1
         OKrXW81HXTgNLN828fK4/EXPKG3/P7/awpf9KO/8EjTvyCtsrLQxivAODmqDHVDbQfFK
         t7Zg==
X-Gm-Message-State: ACgBeo2mfqKLhilvMUQ40EuczI40PgEfzkgzCs9NWQfvSzIrCnUCammQ
        dr786xsBVZPsleOL1UvdEB2DloAx3kQ=
X-Google-Smtp-Source: AA6agR7QJATqhsCQovjYcvO8OXimxMt1xO+WVZ5Z+hIwRsSqoJ8GSxSlryEgnA+EyUxWk2c20ND9PQ==
X-Received: by 2002:a17:90a:8d03:b0:1fd:7012:9096 with SMTP id c3-20020a17090a8d0300b001fd70129096mr1734434pjo.225.1661927613470;
        Tue, 30 Aug 2022 23:33:33 -0700 (PDT)
Received: from ?IPV6:2402:4000:1247:dd4f:8fe6:f39:f10b:e964? ([2402:4000:1247:dd4f:8fe6:f39:f10b:e964])
        by smtp.gmail.com with ESMTPSA id bb5-20020a170902bc8500b0016db7f49cc2sm10735990plb.115.2022.08.30.23.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 23:33:33 -0700 (PDT)
Message-ID: <a226891f-e589-04ea-f595-fed3d1f75691@gmail.com>
Date:   Wed, 31 Aug 2022 06:33:26 +0000
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
 <86e2c049-b289-8b1f-9fc2-8938abefa7d4@gmail.com>
 <Yw60DQEbmQDKka9G@kernel.org>
From:   Dhanuka <wdnuka@gmail.com>
In-Reply-To: <Yw60DQEbmQDKka9G@kernel.org>
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

On 8/31/22 01:06, Jarkko Sakkinen wrote:
> On Tue, Aug 30, 2022 at 11:18:03AM +0000, Dhanuka wrote:
>> On 8/30/22 02:52, Jarkko Sakkinen wrote:
>>> On Mon, Aug 29, 2022 at 03:15:30PM +0300, Jarkko Sakkinen wrote:
>>>> On Sun, Aug 28, 2022 at 11:48:59AM +0530, Dhanuka Warusadura wrote:
>>>>> These changes fix the "error: ‘ERR_get_error_line’ is deprecated:
>>>>> Since OpenSSL 3.0" warning.
>>>>>
>>>>> Signed-off-by: Dhanuka Warusadura <wdnuka@gmail.com>
>>>>> ---
>>>>>    tools/testing/selftests/sgx/sigstruct.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
>>>>> index 50c5ab1aa6fa..671d9b58e274 100644
>>>>> --- a/tools/testing/selftests/sgx/sigstruct.c
>>>>> +++ b/tools/testing/selftests/sgx/sigstruct.c
>>>>> @@ -136,7 +136,7 @@ static bool check_crypto_errors(void)
>>>>>    			break;
>>>>>    		had_errors = true;
>>>>> -		err = ERR_get_error_line(&filename, &line);
>>>>> +		err = ERR_peek_last_error_line(&filename, &line);
>>>>>    		ERR_error_string_n(err, str, sizeof(str));
>>>>>    		fprintf(stderr, "crypto: %s: %s:%d\n", str, filename, line);
>>>>>    	}
>>>>> -- 
>>>>> 2.37.2
>>>>>
>>>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> Actually NAK.
>>>
>>> This fix is not complete:
>>>
>>> sigstruct.c: In function ‘get_modulus’:
>>> sigstruct.c:151:9: error: ‘RSA_get0_key’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
>>>     151 |         RSA_get0_key(key, &n, NULL, NULL);
>>>         |         ^~~~~~~~~~~~
>>> In file included from /usr/include/openssl/x509.h:36,
>>>                    from /usr/include/openssl/pem.h:23,
>>>                    from sigstruct.c:16:
>>> /usr/include/openssl/rsa.h:217:28: note: declared here
>>>     217 | OSSL_DEPRECATEDIN_3_0 void RSA_get0_key(const RSA *r,
>>>         |                            ^~~~~~~~~~~~
>>> sigstruct.c: In function ‘gen_sign_key’:
>>> sigstruct.c:168:9: error: ‘PEM_read_bio_RSAPrivateKey’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declaration
>>> ]
>>>     168 |         key = PEM_read_bio_RSAPrivateKey(bio, NULL, NULL, NULL);
>>>         |         ^~~
>>> /usr/include/openssl/pem.h:447:1: note: declared here
>>>     447 | DECLARE_PEM_rw_cb_attr(OSSL_DEPRECATEDIN_3_0, RSAPrivateKey, RSA)
>>>         | ^~~~~~~~~~~~~~~~~~~~~~
>>> sigstruct.c: In function ‘encl_measure’:
>>> sigstruct.c:364:9: error: ‘RSA_sign’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
>>>     364 |         if (!RSA_sign(NID_sha256, digest, SHA256_DIGEST_LENGTH,
>>>         |         ^~
>>> /usr/include/openssl/rsa.h:348:27: note: declared here
>>>     348 | OSSL_DEPRECATEDIN_3_0 int RSA_sign(int type, const unsigned char *m,
>>>         |                           ^~~~~~~~
>>> sigstruct.c:377:9: error: ‘RSA_free’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
>>>     377 |         RSA_free(key);
>>>         |         ^~~~~~~~
>>> /usr/include/openssl/rsa.h:293:28: note: declared here
>>>     293 | OSSL_DEPRECATEDIN_3_0 void RSA_free(RSA *r);
>>>         |                            ^~~~~~~~
>>> sigstruct.c:382:9: error: ‘RSA_free’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
>>>     382 |         RSA_free(key);
>>>         |         ^~~~~~~~
>>> /usr/include/openssl/rsa.h:293:28: note: declared here
>>>     293 | OSSL_DEPRECATEDIN_3_0 void RSA_free(RSA *r);
>>>         |                            ^~~~~~~~
>>> cc1: all warnings being treated as errors
>>> make: *** [Makefile:39: /home/jarkko/work/linux-sgx/tools/testing/selftests/sgx/sigstruct.o] Error 1
>>>
>>> BR, Jarkko
>> Thanks for the review.
>>
>> But, my intention was to just fix the `ERR_get_error_line` deprecated
>> warning (as mentioned in the commit header) and not all the OpenSSL
>> deprecated warnings found in `sigstruct.c`
>>
>> Do I need to fix all these OpenSSL deprecated warnings in `sigstruct.c` in
>> order to get this patch merged?
> Yes, it is incomplete as it is.
>
> BR, Jarkko

Understood. Will try to resolve the remaining deprecated warnings as well.

Thanks,
Dhanuka

