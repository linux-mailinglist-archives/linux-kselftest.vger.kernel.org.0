Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFB25F07FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 11:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiI3JvS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiI3JvP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 05:51:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24162E9063;
        Fri, 30 Sep 2022 02:51:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d11so3533931pll.8;
        Fri, 30 Sep 2022 02:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dAI/zB5X3r1p0+6wjY89ucLgBKUEAusottjilwFBw6w=;
        b=BZ6i7zNjO0iV1zrKwolGYdd4DMx/UCzFxhuvU6ejIDLoHEXU1PAhqhptrsCny8N9OF
         Q+CKnLYTPWxPEDzx466beXCthImnCLrwOpfRM9CBBCGBuu/8KhzS1EZbzUAXA1VTEcc6
         jxwGS4PlAzU3IzThJlB3e3eL5dkeDBqi6CGeNqEV4T1h0fUQ6h/z112Yi0raMLbXGUD0
         jnwWeDQnZ8c75nN12HPv1WJvO1UJajKenf3KGNUfY31kmPpI4O1e3qM+VsActQAHVb6x
         6GI5i2xhjep1y+kBrAEo+XDU0Q1e+kYxpUDb/ZNrxvrkgSQ19yKTVxHmhGdSGVk/Ysdf
         ekCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dAI/zB5X3r1p0+6wjY89ucLgBKUEAusottjilwFBw6w=;
        b=ViQnQ/hMpVLZ+vqVbyEHh9SFUMnXTQO0Nsbt/N/pNQnesOjRnCowkfiVQJUQNQYqaN
         1oKJeT11flm/QoR7fq32wweicwCsfEcYzojhqEwOAe9SFsAZYWSEmSrJzPoWH9R+2O6Q
         HOKgsCDvCu2fObHbDvaQn7WeZyC2c2FpTwM5pABO9ArMgG97WL5L0h05hQ0gHs1479J8
         C3TuyCk00f5ZAdAolVT4/dZt7GCq2mT42EbmLcmp3EvyVkP0UvW3TIQ2ggqKCFel8tQ5
         YhV1fbo7SNNt8mJFDRwkvyt9MuXvg0OAuClqUHdUJ6lJh3VPtMQoW9oIOK0dgZXIGl8v
         3upw==
X-Gm-Message-State: ACrzQf1myExE3OpDpaqUyD1xwzNaHeDlUJ8bfJ2OdbG7aWyOOnKtdT3G
        Z8cfntcid5BVh+eH/v1owb0=
X-Google-Smtp-Source: AMsMyM69G7WPK/dtK5ih/7WLbCJL0YgY0S/p7hg+S9OB4guCwbNb05zO/lPFd40BBNBJP7dB0W2gyw==
X-Received: by 2002:a17:902:b705:b0:17a:dd:4c3e with SMTP id d5-20020a170902b70500b0017a00dd4c3emr8042122pls.14.1664531473600;
        Fri, 30 Sep 2022 02:51:13 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-35.three.co.id. [116.206.28.35])
        by smtp.gmail.com with ESMTPSA id u15-20020a170903124f00b001709b9d292esm1450485plh.268.2022.09.30.02.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 02:51:13 -0700 (PDT)
Message-ID: <464981b6-d9d7-e656-261f-ef48661deaa2@gmail.com>
Date:   Fri, 30 Sep 2022 16:51:08 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] Documentation: kunit: rewrite writing first test
 instructions
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>
References: <20220929132549.56452-1-bagasdotme@gmail.com>
 <CABVgOSkT-EWLqr6R=RvbEgmkMAY0680YbRnEBg1un6h-=TzrUg@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CABVgOSkT-EWLqr6R=RvbEgmkMAY0680YbRnEBg1un6h-=TzrUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/30/22 13:42, David Gow wrote:
> 
> While I like the idea behind this, the wording probably needs a bit of
> tweaking. In addition, by describing everything in too much detail, I
> fear we might just be adding some needless redundancy. My suspicion is
> that everyone who's going to be writing KUnit tests already knows C
> (or has access to better learning materials than this), so we're
> unlikely to need to describe in detail that, e.g., misc_example_add()
> adds two numbers together when the code is right there,
> 

We should just say "First, write the driver implementation" (without
describing writing C code in detail), right?

>>
>> -.. code-block:: c
>> +   .. code-block:: c
> 
> Why are all of these code-block declarations being indented? It
> doesn't seem to affect the actual documentation build, so I guess it's
> harmless, but it'd be better not to have it change unnecessarily and
> clutter up the diff.
> 

The indentation for code-block directive is required, since the preceding
paragraph is multiline; otherwise there will be Sphinx warnings.

>>
>>         int misc_example_add(int left, int right);
>>
>> -2. Create a file ``drivers/misc/example.c``, which includes:
>> +   Then implement the function in ``drivers/misc/example.c``:
> 
>>
>> -.. code-block:: c
>> +   .. code-block:: c
> 
> Again, code-block indentation?

Yes, for consistency.

> 
>>
>>         #include <linux/errno.h>
>>
>> @@ -152,24 +154,25 @@ In your kernel repository, let's add some code that we can test.
>>                 return left + right;
>>         }
>>
>> -3. Add the following lines to ``drivers/misc/Kconfig``:
>> +2. Add Kconfig menu entry for the feature to ``drivers/misc/Kconfig``:
> 
> This needs rewording to add back an article ("a" or "the"), and we
> probably want to call this a "Kconfig entry" rather than a "Kconfig
> menu entry". Maybe "Add a Kconfig entry for the driver..."?
> 
>>
>> -.. code-block:: kconfig
>> +   .. code-block:: kconfig
> 
> Indentation again?

Yes, see above reply.

> 
>>
>>         config MISC_EXAMPLE
>>                 bool "My example"
>>
>> -4. Add the following lines to ``drivers/misc/Makefile``:
>> +3. Add the kbuild goal that will build the feature to
>> +   ``drivers/misc/Makefile``:
> 
> Kbuild goal? I've never heard of this being called a Kbuild goal before?
> 
> How about a "make target"?
> 

At the time of writing this patch, I use terminology in
Documentation/kbuild/makefiles.rst, which the "make target" is called
"Kbuild goal".

>>
>> -.. code-block:: make
>> +   .. code-block:: make
> 
> Indentation?

Yes, for consistency with the first code-block directive.

>>
>> -.. code-block:: c
>> +   .. code-block:: c
> 
> Indentation.
> 

See above reply.

>>
>> -.. code-block:: kconfig
>> +   .. code-block:: kconfig
> 
> Indentation?

See above reply.

>>
>> -.. code-block:: make
>> +   .. code-block:: make
> 
> Indentation?

See above reply.

>>
>> -.. code-block:: none
>> +   .. code-block:: none
> 
> Indentation?
> 

See above reply.

>>
>>         CONFIG_MISC_EXAMPLE=y
>>         CONFIG_MISC_EXAMPLE_TEST=y
>>
>>  5. Run the test:
>>
>> -.. code-block:: bash
>> +   .. code-block:: bash
> 
> Indentation?

See above reply.

Thanks for reviewing.

-- 
An old man doll... just what I always wanted! - Clara
