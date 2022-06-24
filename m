Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9F9559B47
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiFXONE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 10:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiFXOMl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 10:12:41 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9864EF5A
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 07:12:31 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id p8so3737897oip.8
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=53vn64yRjkuEqyIkeDEPFdD1GdqreawtSTg5tA38ztc=;
        b=WXeOGiZSKfJi8wPbxbmili7ih72qBD23TwXrQBHuZHvfzmcq6Er+YNYvSdH/HmgHeD
         VypMF7/0UMSO5rHU0BlQ6fxGo5ez1v3piaCwPMcFAmLtLQVkrDBqnhrnaOodn8+bYy+i
         VHbE770laSJnTHcgq2kFwuZv31jdeAbt9kH5Npe4yYBHJHLUw97hEdsWEPA1DGXssdQ/
         ckIFXzg4Jt0IG++z+tCO/vVkQ8Im8qIFzmPLp2KnALrCtjomN0wd4NoRXHzEGXovsQ2C
         1rLVukf/f59njTkqYToRzuJYsSVDl3/hpfepx4xNWlm5Wb8pupA1P9gg4/7xX0jJjg5W
         7aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=53vn64yRjkuEqyIkeDEPFdD1GdqreawtSTg5tA38ztc=;
        b=Fli1lw5RkTPgdZvMsxZGolUEelpoQ1HTLStuUlN4HqVBxTJ5Zw/VT8hagjNz0+Y/m1
         J3dJ4jfY3sPU8HnSazirbTjPF90fcwlJ5y//vclAFdkoMdQnGXGb70slRI0Fy1sqjFlC
         LCXS51p8X9DelWwInrGn6IHXl2gDYeYsAxyVczBMK12N2gXdlOhLMiVO4aXpApRjrbyE
         suQEw1Qqqetgoa3LTJLcEdQf9iLwg4dpuHWvnj7n4ji2Wv89UZ1Czs88xa6uuwJXgpUA
         QpTJCoUoohVDHHqVxeL2P5RRAvdsdL65e/LoqWcE0XlebgTdPIp2obLcuRaIkJdvSovy
         cAKQ==
X-Gm-Message-State: AJIora8Zr/R75uvergElF0sr4aUHbSgnffLIzKI6LV8KVk7BDZqk035w
        GbUiRcGVXyC4jJnv6vk6LgP/Bg==
X-Google-Smtp-Source: AGRyM1tif/mYo2Axv1kHqjLLaKd7z6gFWV5L7ioC4lXyTirFj2AYoeXuow9Nk7oOkoAFuuZimHYg9w==
X-Received: by 2002:a05:6808:1183:b0:2d4:5eeb:1ca3 with SMTP id j3-20020a056808118300b002d45eeb1ca3mr2025609oil.8.1656079949917;
        Fri, 24 Jun 2022 07:12:29 -0700 (PDT)
Received: from [172.20.18.220] (gwsc.sc.usp.br. [143.107.225.16])
        by smtp.gmail.com with ESMTPSA id g13-20020a05683030ad00b0060afaae0e34sm1638172ots.0.2022.06.24.07.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 07:12:29 -0700 (PDT)
Message-ID: <6e46976d-bcf3-e7fd-cd30-bc25c67c5518@usp.br>
Date:   Fri, 24 Jun 2022 11:12:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] kunit: add coverage_uml.config to enable GCOV on UML
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220624001247.3255978-1-dlatypov@google.com>
 <20220624001247.3255978-2-dlatypov@google.com>
 <CABVgOSn_v8p2nRaioz2MK0FEV6UmzfHHFipiqy05d54y73XFzQ@mail.gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>
In-Reply-To: <CABVgOSn_v8p2nRaioz2MK0FEV6UmzfHHFipiqy05d54y73XFzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/24/22 04:55, 'David Gow' via KUnit Development wrote:
> On Fri, Jun 24, 2022 at 8:12 AM 'Daniel Latypov' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
>>
>> Now that kunit.py's --kunitconfig is repeatable, let's create a file to
>> hold the various options needed to enable coverage under UML.
>>
>> This can be used like so:
>> $ ./tools/testing/kunit/kunit.py run \
>>    --kunitconfig=tools/testing/kunit/configs/all_tests_uml.config \
>>    --kunitconfig=tools/testing/kunit/configs/coverage_uml.config \
>>    --make_options=CC=/usr/bin/gcc-6
>>
>> which on my system is enough to get coverage working [1].
>>

It's great to see this coming to KUnit! As I was testing this series, I 
wasn't able to generate the coverage stats with GCC11. I got a linking 
error from ld:

ERROR:root:/usr/bin/ld: 
/usr/lib/gcc/x86_64-redhat-linux/11/libgcov.a(_gcov.o): in function 
`mangle_path':
(.text+0x19f0): multiple definition of `mangle_path'; 
fs/seq_file.o:/home/mairacanal/linux/.kunit/../fs/seq_file.c:441: first 
defined here
collect2: error: ld returned 1 exit status

By changing the name of the function to `seq_mangle_path`, it is 
possible to solve the linking error and run the tests. But, anyway, no 
.gcda files are generated.

I checked out, and this is a known issue that was already discussed in 
this series [1] (but I guess it didn't move on).

Is there any hope to see better UM support for gcov as using GCC6 is 
quite uncommon nowadays?

[1] 
https://lore.kernel.org/all/20210312095526.197739-1-johannes@sipsolutions.net/

Best regards,
- Maíra Canal

>> This is still a clunky command, but far better than before.
>>
>> [1] at the time of this commit, I get:
>>    Overall coverage rate:
>>      lines......: 11.6% (34112 of 295033 lines)
>>      functions..: 15.3% (3721 of 24368 functions)
>>
>> Signed-off-by: Daniel Latypov <dlatypov@google.com>
>> ---
> 
> Looks good to me: depending on whether or not we do something like
> [1], we should add a pci_uml.config as well.
> 
> Alas, I don't have a working gcc 6 install anymore, so I wasn't able
> to test the coverage here, but I at least got an encouraging-looking
> error, and the change looks very sensible, so:
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David
> 
> [1] https://lore.kernel.org/linux-kselftest/20220622035326.759935-1-davidgow@google.com/
> 
> 
>>   Documentation/dev-tools/kunit/running_tips.rst  |  3 +--
>>   tools/testing/kunit/configs/coverage_uml.config | 11 +++++++++++
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>   create mode 100644 tools/testing/kunit/configs/coverage_uml.config
>>
>> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
>> index c36f6760087d..205ea21c9cca 100644
>> --- a/Documentation/dev-tools/kunit/running_tips.rst
>> +++ b/Documentation/dev-tools/kunit/running_tips.rst
>> @@ -123,8 +123,7 @@ Putting it together into a copy-pastable sequence of commands:
>>   .. code-block:: bash
>>
>>          # Append coverage options to the current config
>> -       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
>> -       $ ./tools/testing/kunit/kunit.py run
>> +       $ ./tools/testing/kunit/kunit.py run --kunitconfig=.kunit/ --kunitconfig=tools/testing/kunit/configs/coverage_uml.config
>>          # Extract the coverage information from the build dir (.kunit/)
>>          $ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/
>>
>> diff --git a/tools/testing/kunit/configs/coverage_uml.config b/tools/testing/kunit/configs/coverage_uml.config
>> new file mode 100644
>> index 000000000000..bacb77664fa8
>> --- /dev/null
>> +++ b/tools/testing/kunit/configs/coverage_uml.config
>> @@ -0,0 +1,11 @@
>> +# This config fragment enables coverage on UML, which is different from the
>> +# normal gcov used in other arches (no debugfs).
>> +# Example usage:
>> +# ./tools/testing/kunit/kunit.py run \
>> +#   --kunitconfig=tools/testing/kunit/configs/all_tests_uml.config \
>> +#   --kunitconfig=tools/testing/kunit/configs/coverage_uml.config
>> +
>> +CONFIG_DEBUG_KERNEL=y
>> +CONFIG_DEBUG_INFO=y
>> +CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
>> +CONFIG_GCOV=y
>> --
>> 2.37.0.rc0.104.g0611611a94-goog
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220624001247.3255978-2-dlatypov%40google.com.
> 
