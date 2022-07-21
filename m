Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18257C990
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 13:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiGULIl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 07:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiGULIk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 07:08:40 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6F48320B;
        Thu, 21 Jul 2022 04:08:39 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LpVDk4qLxzDr6X;
        Thu, 21 Jul 2022 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1658401718; bh=Nf1Dgyv2qaHl47cUqOxNgenpTkbTW3KND8cpE9za7yk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RjKBmBNQbQslRmze9bo/XVKPk77TFgIvcK1Dv8HnaTofJnxTpQcEXxcnLS8Yiwa33
         tanx5l2Lc6dVK6HJULsCPpwSTwtPZtvkiV2XjNHYD9yEZKcDrnRd0JajOZHgwHbldu
         XS0lWir6cL85jZ2XLbpjW9phtYqjCtq3DYNHy7iE=
X-Riseup-User-ID: 3DFB8BB18B9E4F6B665E5F162549BF310BD214B1CF39F868FF7A64C7FB799035
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4LpVDg3hKDz1xph;
        Thu, 21 Jul 2022 11:08:35 +0000 (UTC)
Message-ID: <130be97c-b2cd-5ecc-1549-5b83993843e2@riseup.net>
Date:   Thu, 21 Jul 2022 08:08:32 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v2] Documentation: kunit: Add CLI args for kunit_tool
Content-Language: en-US
To:     Sadiya Kazi <sadiyakazi@google.com>, brendanhiggins@google.com,
        davidgow@google.com, skhan@linuxfoundation.org, corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220721081026.1247067-1-sadiyakazi@google.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220721081026.1247067-1-sadiyakazi@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 7/21/22 05:10, Sadiya Kazi wrote:
> Run_wrapper.rst was missing some command line arguments. Added
> additional args in the file.
> 
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> ---
> Changes since V1:
> https://lore.kernel.org/linux-kselftest/20220719092214.995965-1-sadiyakazi@google.com/
> - Addressed most of the review comments from Maira and David, except
>   removing the duplicate arguments as I felt its worth keeping them in
>   the reference documentation as well as in context. We can improve them
>   and differentiate their use cases in the future patches.
> 
> 
> ---
>  Documentation/dev-tools/kunit/run_wrapper.rst | 60 ++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
> index 5e560f2c5fca..600af7ac5f88 100644
> --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ b/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -233,7 +233,7 @@ Command-Line Arguments
>  ======================
>  
>  kunit_tool has a number of other command-line arguments which can
> -be useful for our test environment. Below the most commonly used
> +be useful for our test environment. Below are the most commonly used
>  command line arguments:
>  
>  - ``--help``: Lists all available options. To list common options,
> @@ -257,3 +257,61 @@ command line arguments:
>              added or modified. Instead, enable all tests
>              which have satisfied dependencies by adding
>              ``CONFIG_KUNIT_ALL_TESTS=y`` to your ``.kunitconfig``.
> +
> +- ``--kunitconfig``: Specifies the path or the directory of the ``.kunitconfig``
> +  file. For example:
> +
> +  - ``lib/kunit/.kunitconfig`` can be the path of the file.
> +
> +  - ``lib/kunit`` can be the directory in which the file is located.
> +
> +  This file is used to build and run with a predefined set of tests
> +  and their dependencies. For example, to run tests for a given subsystem.
> +
> +- ``--kconfig_add``: Specifies additional configuration options to be
> +  appended to the ``.kunitconfig`` file.
> +  For example, ``./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y``.

Small nit pick: I would rather do:

```
./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
```

> +
> +- ``--arch``: Runs tests on the specified architecture. The architecture
> +  specified must match the Kbuild ARCH environment variable.
> +  For example, i386, x86_64, arm, um, etc. Non-UML architectures run on QEMU.
> +  Default is `um`.
> +
> +- ``--cross_compile``: Specifies the Kbuild toolchain. It passes the
> +  same argument as passed to the ``CROSS_COMPILE`` variable used by
> +  Kbuild. This will be the prefix for the toolchain
> +  binaries such as GCC. For example:
> +
> +  - ``sparc64-linux-gnu-`` if we have the sparc toolchain installed on
> +    our system.
> +
> +  - ``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux``
> +    if we have downloaded the microblaze toolchain from the 0-day
> +    website to a specified path in our home directory called toolchains.
> +
> +- ``--qemu_config``: Specifies the path to a file containing a
> +  custom qemu architecture definition. This should be a python file
> +  containing a `QemuArchParams` object.

Nit: choose a standard for referring to qemu. Either "qemu" or "QEMU" is
great for me, but it is ideal that you chose one and stick with it.
Here, you used "qemu" and on the next argument, you used "QEMU".

> +
> +- ``--qemu_args``: Specifies additional QEMU arguments, for example, "-smp 8".
> +
> +- ``--jobs``: Specifies the number of jobs (commands) to run simultaneously.
> +  By default, this is set to the number of cores on your system.
> +
> +- ``--timeout``: Specifies the maximum number of seconds allowed for all tests to run.
> +  This does not include the time taken to build the tests.
> +
> +- ``--kernel_args``: Specifies additional kernel command-line arguments. Might be repeated.
> +
> +- ``--run_isolated``: If set, boots the kernel for each individual suite/test.
> +  This is useful for debugging a non-hermetic test, one that
> +  might pass/fail based on what ran before it.
> +
> +- ``--raw_output``: If set, generates unformatted output from kernel. Possible options are:
> +
> +   - ``all``: To view the full kernel output, use ``--raw_output=all``.
> +
> +   - ``kunit``: This is the default option and filters to KUnit output. Use ``--raw_output`` or ``--raw_output=kunit``.
> +
> +- ``--json``: If set, stores the test results in a JSON format and prints to `stdout` or
> +  saves to a file if a filename is specified.

Anyway, the documentation is pretty good and informative! The small nits
I pointed out are optional. So,

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

Best Regards,
- Maíra Canal
