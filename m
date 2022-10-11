Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590945FAFB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Oct 2022 11:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJKJv4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Oct 2022 05:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJKJvz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Oct 2022 05:51:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6AC12D11;
        Tue, 11 Oct 2022 02:51:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p14so8711680pfq.5;
        Tue, 11 Oct 2022 02:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCDQTD5Y+nV66C8T+N3XM1jxi8bXdGKiIQYvzLDQz8s=;
        b=nxdKN0aPRzjLYhg2it7lOi1lDMZfXjvaYXlrrCj0lTvPisF0Xay85zsbSMl4h/T9RE
         W+nQo++LE1Zg5lo2UAGH6b0D37Z7CKl8cja2Sa/e5G+QyXb7jMhmc50qou5vxEQ1Iq+0
         NxyNkDohGv9OHwPZyqMyL1qhnOGQycZvlGnaDzUT3xR6/apOtWD3vi4fF4Sokqxe8cTA
         XZMH00bJgQCiAsPDs6lCn5WmEt9o+ZjfHg+2HJETlCLuxQ9sJkO3lUVYXWrJMbocAotR
         3pNEIwP1fF9VSSxnU2GVKfhmkvA6p4xRzrGZi3eMveeNU8izynEgllH0NyuUe9yYanq0
         MYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCDQTD5Y+nV66C8T+N3XM1jxi8bXdGKiIQYvzLDQz8s=;
        b=fp73s8BmIgP3iwkaa/X4uCV/MIFs4W6aN6fgZy4vc+nhQEKPO8w3aEGTDYAN6qdo3Z
         Quz/tR5LcQb4gG/VW2/S8KJAXL/xPW768t8K0LzfM7+EsBHPARGxBYLGYY/GoJznDgR2
         Ae1ppDWxBUTSL5j+RYP5Ygnhj0W59Kt7ogOeY1yXSnuhon33p2+ZWlZzoU+1FH/GWATh
         Gt2LNDnkd339ClzdrbBNhNYQfwOteA1gf4iZFCxFVNkx0VQpELvbTyDCBnNIxUUmQjbY
         NjEgUXPD6Xb60O2WFbdj/aDGdRCTNlZowsIoC8CUC/m4YkoODQEeBnL58yB2ykxPk5Zm
         yxww==
X-Gm-Message-State: ACrzQf2oNVetmWYCHcoXoSoY9N/gTwNIhMtAR3aXhEIJnyWFqduuouts
        k7chTpZeA9j8FJDH9vvJLLs=
X-Google-Smtp-Source: AMsMyM5wnvFTpjb3HNpa8Hu6dDL/94wrx8LzNTgoXcPZHasHeNQwOesYKfvS02YPwHxJbXSAnnZHmA==
X-Received: by 2002:a63:6c84:0:b0:43c:700f:6218 with SMTP id h126-20020a636c84000000b0043c700f6218mr20235234pgc.420.1665481909940;
        Tue, 11 Oct 2022 02:51:49 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-57.three.co.id. [116.206.28.57])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b00178b77b7e71sm8247582plg.188.2022.10.11.02.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 02:51:49 -0700 (PDT)
Message-ID: <2d174fee-bdd1-a304-c66c-09e957120af1@gmail.com>
Date:   Tue, 11 Oct 2022 16:51:45 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] Documentation: Kunit: Update architecture.rst for minor
 fixes
Content-Language: en-US
To:     Sadiya Kazi <sadiyakazi@google.com>, brendanhiggins@google.com,
        davidgow@google.com, skhan@linuxfoundation.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010171353.1106166-1-sadiyakazi@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221010171353.1106166-1-sadiyakazi@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/11/22 00:13, Sadiya Kazi wrote:
>  The kernel testing library supports KUnit tests written in C using
> -KUnit. KUnit tests are kernel code. KUnit does several things:
> +KUnit. KUnit tests are written in the kernel code. KUnit performs the following
> +tasks:
> 

What about "The kernel testing library supports KUnit tests, which are
written in ordinary kernel code."?

>  - Organizes tests
>  - Reports test results
> @@ -22,8 +23,8 @@ KUnit. KUnit tests are kernel code. KUnit does several things:
>  Test Cases
>  ----------
>  
> -The fundamental unit in KUnit is the test case. The KUnit test cases are
> -grouped into KUnit suites. A KUnit test case is a function with type
> +The test case is the fundamental unit in KUnit. KUnit test cases are organised
> +into suites. A KUnit test case is a function with type

"which is organized into a test suite".

>  The KUnit executor can list and run built-in KUnit tests on boot.
>  The Test suites are stored in a linker section
> -called ``.kunit_test_suites``. For code, see:
> +called ``.kunit_test_suites``. For code, see the following link:
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/asm-generic/vmlinux.lds.h?h=v5.15#n945.

Instead of link to torvalds's tree, just say "See ``include/asm-generic/vmlinux.lds.h``
for the full code".

>  On the kernel boot, the KUnit executor uses the start and end addresses
> -of this section to iterate over and run all tests. For code, see:
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/kunit/executor.c
> +of this section to iterate over and run all tests. For code, see the following link:
> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/kunit/executor.c.
>  

Same reply above.

>  In KUnit tests, some error classes do not affect other tests
>  or parts of the kernel, each KUnit case executes in a separate thread
> -context. For code, see:
> +context. For code, see the following link:
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/kunit/try-catch.c?h=v5.15#n58
>  

Same reply above.

>  Assertion Macros
>  ----------------
>  
> -KUnit tests verify state using expectations/assertions.
> +KUnit tests verify the state using expectations/assertions.
>  All expectations/assertions are formatted as:
>  ``KUNIT_{EXPECT|ASSERT}_<op>[_MSG](kunit, property[, message])``
>  
>  - ``{EXPECT|ASSERT}`` determines whether the check is an assertion or an
>    expectation.
>  
> -	- For an expectation, if the check fails, marks the test as failed
> +	- For an expectation, if the check fails, it marks the test as failed
>  	  and logs the failure.
>  
>  	- An assertion, on failure, causes the test case to terminate
>  	  immediately.

Better say:

```
In case of failure, there are differences on testing flow:

   - For expectations, the test is marked as failed and the failure is logged.
   - On the other hand, failing assertions cause the test case to be
     immediately terminated.
```

> -kunit_tool (Command Line Test Harness)
> +kunit_tool (Command-line Test Harness)
>  ======================================
>  
> -kunit_tool is a Python script ``(tools/testing/kunit/kunit.py)``
> -that can be used to configure, build, exec, parse and run (runs other
> -commands in order) test results. You can either run KUnit tests using
> -kunit_tool or can include KUnit in kernel and parse manually.
> +``kunit_tool`` is a Python script, found in ``tools/testing/kunit/kunit.py``. It
> +is used to configure, build, execute, parse, and run (other commands in order)
> +test results. You have two options for running KUnit tests: either include KUnit
> +in the kernel and parse manually, or use the ``kunit_tool``.
>  >  - ``configure`` command generates the kernel ``.config`` from a
>    ``.kunitconfig`` file (and any architecture-specific options).
> -  For some architectures, additional config options are specified in the
> -  ``qemu_config`` Python script
> -  (For example: ``tools/testing/kunit/qemu_configs/powerpc.py``).
> +  The Python script available in ``qemu_configs`` folder
> +  (for example, ``tools/testing/kunit/qemu configs/powerpc.py``) contains
> +  additional configuration options for specific architectures.
>    It parses both the existing ``.config`` and the ``.kunitconfig`` files
> -  and ensures that ``.config`` is a superset of ``.kunitconfig``.
> -  If this is not the case, it will combine the two and run
> -  ``make olddefconfig`` to regenerate the ``.config`` file. It then
> -  verifies that ``.config`` is now a superset. This checks if all
> -  Kconfig dependencies are correctly specified in ``.kunitconfig``.
> -  ``kunit_config.py`` includes the parsing Kconfigs code. The code which
> -  runs ``make olddefconfig`` is a part of ``kunit_kernel.py``. You can
> -  invoke this command via: ``./tools/testing/kunit/kunit.py config`` and
> +  to ensure that ``.config`` is a superset of ``.kunitconfig``.
> +  If not, it will combine the two and execute ``make olddefconfig`` to regenerate
> +  the ``.config`` file. It then checks to see if ``.config`` has become a superset.
> +  This verifies that all the Kconfig dependencies are correctly specified in the file
> +  ``.kunitconfig``. The
> +  ``kunit_config.py`` script contains the code for parsing Kconfigs. The code which
> +  runs ``make olddefconfig`` is part of the ``kunit_kernel.py`` script. You can
> +  invoke this command through: ``./tools/testing/kunit/kunit.py config`` and
>    generate a ``.config`` file.
>  - ``build`` runs ``make`` on the kernel tree with required options
>    (depends on the architecture and some options, for example: build_dir)
> @@ -184,8 +188,8 @@ kunit_tool or can include KUnit in kernel and parse manually.
>    To build a KUnit kernel from the current ``.config``, you can use the
>    ``build`` argument: ``./tools/testing/kunit/kunit.py build``.
>  - ``exec`` command executes kernel results either directly (using
> -  User-mode Linux configuration), or via an emulator such
> -  as QEMU. It reads results from the log via standard
> +  User-mode Linux configuration), or through an emulator such
> +  as QEMU. It reads results from the log using standard
>    output (stdout), and passes them to ``parse`` to be parsed.
>    If you already have built a kernel with built-in KUnit tests,
>    you can run the kernel and display the test results with the ``exec``

The kunit_tool description above is redundant. Instead, just say "For
the documentation on using kunit_tool, see
Documentation/dev-tools/kunit/run_wrapper.rst".

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

