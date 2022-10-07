Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D6C5F72FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Oct 2022 05:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJGDEB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Oct 2022 23:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJGDD7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Oct 2022 23:03:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40477B03E0;
        Thu,  6 Oct 2022 20:03:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f140so3807786pfa.1;
        Thu, 06 Oct 2022 20:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dnBNEJVnli6D71Ymn0JtYVsF8R/SrWka4rQ71ILKc8=;
        b=IwKhRbZksxUTWls/SveEkPyJyKyHGUhPT3DVSheKM1BO5di4tG2MfU8j+ySXDjDHIj
         lwU7tH9xZpSjPRG71tGmviIGCUCg4YJk48pT7uriVseEyKVFZnHEqXJjTRRaQrRwHKnJ
         8hRRMxN5YJQOo4HWGmQf7JA0gKnDMXH2j2MU0SBuna9lTHoJz2yKRkhiR+vx7CmMhdbL
         Dk8/H21tQlrv6bRF99mkgpqEDxGKmBiAew8zVQw4Et0/19LsvkNJAXf8UZ+aYpE9nWPX
         iHptgUlmMAriULp5BwujEv+onAiMlR+reiZSHa3mWU8JdhPUY/yV7ZOfpD68ofNDR6aW
         7q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dnBNEJVnli6D71Ymn0JtYVsF8R/SrWka4rQ71ILKc8=;
        b=CzVUBiWwHjyrLCbGJOxauG3sV8wLv6ERsufqt9XKk0wxx83Ho3Mc81piSd2HRQVsF/
         D0pjfCTChprsE5g5pprvwokSROTGm4hteNoFJvGRUGK8w9u3X7gxFYzLZDxA7Wnx1zO6
         RE1NUql3IglYbRqa7c+03WivzbckVvyZRNOj9eSsqgCFWI9sekgtKBnRN6SPVukZ8G/u
         NG2CRHMAWJeinjVDlpPMP1D3SARFNj2yZV++KVLQaySOk2qvlbOsUZDXOTCDCtzDdnoK
         7U37eWBM2NnFXL+zBq4JSYNjMi40sj7CBbfhf1DgiXTf8KhFIDx+bl4o5cY3hl07/wWe
         NUOw==
X-Gm-Message-State: ACrzQf0gkGAHmj3TnwA86Qg1JV3KY6LEiBGSB2ZG+CAHiiLSE38amWdd
        PFWZ2ODyCIS6jX5k3AzOXnk=
X-Google-Smtp-Source: AMsMyM78bjLyC4pgj5ZKCpFHSJvV6cXT0bzOjPgmmKFzAFJpTz33QX93YFkodf4SEQDXEmM09+kCog==
X-Received: by 2002:a05:6a02:205:b0:41b:96dc:bb2a with SMTP id bh5-20020a056a02020500b0041b96dcbb2amr2659594pgb.116.1665111837584;
        Thu, 06 Oct 2022 20:03:57 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-55.three.co.id. [116.206.12.55])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090a160900b001f319e9b9e5sm3545870pja.16.2022.10.06.20.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 20:03:56 -0700 (PDT)
Message-ID: <95439cec-5357-0953-8f55-e3486f763345@gmail.com>
Date:   Fri, 7 Oct 2022 10:03:52 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] Documentation: kunit: rewrite writing first test
 instructions
Content-Language: en-US
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Khalid Masum <khalid.masum.92@gmail.com>
References: <20220929132549.56452-1-bagasdotme@gmail.com>
 <CAO2JNKUqkt3p1OcRt9tSa9T=sv8RG+F3LydZfTdVBc0WewhHVg@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAO2JNKUqkt3p1OcRt9tSa9T=sv8RG+F3LydZfTdVBc0WewhHVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/6/22 16:41, Sadiya Kazi wrote:
> Consider updating this section as below:
> In this section, you will learn how to write a program to test the addition
> of two numbers using KUnit. To do so, you must write the addition driver
> code followed by the test case.
> 
> 1.To write the addition driver code, follow the steps given below:
> 
>> a.Navigate to the Kernel repository.
> 
>     b.Create a file ``drivers/misc/example.h``.
>     c.In the ``example.h`` file, add the following code to declare the
> function ``misc_example_add()``:
> 
>>
>> -1. Create a file ``drivers/misc/example.h``, which includes:
>> +1. Write the feature that will be tested. First, write the declaration
>> +   for ``misc_example_add()`` in ``drivers/misc/example.h``:
>>
>> -.. code-block:: c
>> +   .. code-block:: c
>>
>>         int misc_example_add(int left, int right);
>>
>> -2. Create a file ``drivers/misc/example.c``, which includes:
>> +   Then implement the function in ``drivers/misc/example.c``:
> 
> 
> d. To implement the function, create a file ``drivers/misc/example.c` and
> add the following code to it:
> 
> 
>>
>> -.. code-block:: c
>> +   .. code-block:: c
>>
>>         #include <linux/errno.h>
>>
>> @@ -152,24 +154,25 @@ In your kernel repository, let's add some code that
>> we can test.
>>                 return left + right;
>>         }
>>
>> -3. Add the following lines to ``drivers/misc/Kconfig``:
>> +2. Add Kconfig menu entry for the feature to ``drivers/misc/Kconfig``:
>>
> 
> e. Update ``drivers/misc/Kconfig`` with the following code to add the
> driver configuration:
> 
> 
>>
>> -.. code-block:: kconfig
>> +   .. code-block:: kconfig
>>
>>         config MISC_EXAMPLE
>>                 bool "My example"
>>
>> -4. Add the following lines to ``drivers/misc/Makefile``:
>> +3. Add the kbuild goal that will build the feature to
>> +   ``drivers/misc/Makefile``:
>>
> f.To build the feature, update ``drivers/misc/Makefile`` with the following
> code:
> 
> 
>>
>> -.. code-block:: make
>> +   .. code-block:: make
>>
>>         obj-$(CONFIG_MISC_EXAMPLE) += example.o
>>
>>  Now we are ready to write the test cases.
>>
> 2. To write the test cases, follow the steps given below:
> 
>>
>> -1. Add the below test case in ``drivers/misc/example_test.c``:
>> +1. Write the test in ``drivers/misc/example_test.c``:
>>
>     a. Write the test in ``drivers/misc/example_test.c``:
> 
>>
>> -.. code-block:: c
>> +   .. code-block:: c
>>
>>         #include <kunit/test.h>
>>         #include "example.h"
>> @@ -202,31 +205,32 @@ Now we are ready to write the test cases.
>>         };
>>         kunit_test_suite(misc_example_test_suite);
>>
>> -2. Add the following lines to ``drivers/misc/Kconfig``:
>> +2. Add following Kconfig entry for the test to ``drivers/misc/Kconfig``:
>>
>     b. Add the following test configuration to ``drivers/misc/Kconfig``:
> 
>>
>> -.. code-block:: kconfig
>> +   .. code-block:: kconfig
>>
>>         config MISC_EXAMPLE_TEST
>>                 tristate "Test for my example" if !KUNIT_ALL_TESTS
>>                 depends on MISC_EXAMPLE && KUNIT=y
>>                 default KUNIT_ALL_TESTS
>>
>> -3. Add the following lines to ``drivers/misc/Makefile``:
>> +3. Add kbuild goal of the test to ``drivers/misc/Makefile``:
>>
>   c. Update ``drivers/misc/Makefile`` with the following code:
> 
>>
>> -.. code-block:: make
>> +   .. code-block:: make
>>
>>         obj-$(CONFIG_MISC_EXAMPLE_TEST) += example_test.o
>>
>> -4. Add following configuration fragments to ``.kunit/.kunitconfig``:
>> +4. Add following configuration fragments for the test to
>> +   ``.kunit/.kunitconfig``:
>>
> d. Add the following test configuration to ``.kunit/.kunitconfig``:
> 
>>
>> -.. code-block:: none
>> +   .. code-block:: none
>>
>>         CONFIG_MISC_EXAMPLE=y
>>         CONFIG_MISC_EXAMPLE_TEST=y
>>
>>  5. Run the test:
>>
> e. Run the test using the following command:
> 
>>
>> -.. code-block:: bash
>> +   .. code-block:: bash
>>
>>         ./tools/testing/kunit/kunit.py run
>>

I think the documentation assumes the knowledge of writing kernel
code (C language and build infrastructure). This means that the
instructions should be written for brevity.

-- 
An old man doll... just what I always wanted! - Clara
