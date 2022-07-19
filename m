Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC64A579C65
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 14:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbiGSMkE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 08:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbiGSMi0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 08:38:26 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E6B1096;
        Tue, 19 Jul 2022 05:15:05 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LnHg40tP6zDr1t;
        Tue, 19 Jul 2022 12:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1658232528; bh=Z13t3JOfWBRbGEZspQFZUoMZr2VJ7vNKr43KVUMXLlc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=pWm379O8WhBzqWzedY4Y/sJ+9XR6AK7oaYUmBneLjkVB81aPy/H70yCPZOC5SJ0Hv
         Atkc9JXBhwY4VYE0689smXDfL2jDJEx8v/1u2btFfQR6TZ4EEvA24vO+gKOnPb1wqq
         8xGkCeG/v1nUQR7vdXQq4Pe5JUMKYHdMtkHl+GF4=
X-Riseup-User-ID: CC50CB2FC9280A4B27EC4D83902A937600070A38BFC170A4ECC504A879609B86
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LnHg12K6Nz5vW6;
        Tue, 19 Jul 2022 12:08:45 +0000 (UTC)
Message-ID: <8e0ad6ee-2542-1049-6106-b5dcc44ec164@riseup.net>
Date:   Tue, 19 Jul 2022 09:08:41 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] Documentation: kunit: Add CLI args for kunit_tool
Content-Language: en-US
To:     Sadiya Kazi <sadiyakazi@google.com>, brendanhiggins@google.com,
        davidgow@google.com, skhan@linuxfoundation.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220719092214.995965-1-sadiyakazi@google.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220719092214.995965-1-sadiyakazi@google.com>
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

On 7/19/22 06:22, 'Sadiya Kazi' via KUnit Development wrote:
> Run_wrapper.rst was missing some command line arguments. Added
> additional args in the file. Included all initial review comments.
> 
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> ---
>  Documentation/dev-tools/kunit/run_wrapper.rst | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
> index 5e560f2c5fca..91f5dda36e83 100644
> --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ b/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -257,3 +257,51 @@ command line arguments:
>              added or modified. Instead, enable all tests
>              which have satisfied dependencies by adding
>              ``CONFIG_KUNIT_ALL_TESTS=y`` to your ``.kunitconfig``.
> +- ``--kunitconfig``: Specifies the path to the ``.kunitconfig`` file.
> +  This Kconfig fragment enables KUnit tests. The "/.kunitconfig" gets
> +  appended to the path specified. For example, If a directory path "lib/kunit"
You might want to change it for a lower-case "if", like: "For example,
if a directory path "lib/kunit"".

> +  is given, the complete path will be "lib/kunit/.kunitconfig".

This explanation may imply that if I pass `--kunitconfig
lib/kunit/.kunitconfig` it wouldn't work, as "/.kunitconfig" is always
appended to the path. But this is not true, both `--kunitconfig
lib/kunit/.kunitconfig` and `--kunitconfig lib/kunit` are valid options.

> +
> +- ``--kconfig_add``: Specifies additional configuration options to be
> +  appended to the ``.kunitconfig`` file. For example, ``CONFIG_KASAN=y``.

You could expand this example to:
```
./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
```

> +
> +- ``--arch``: Runs tests with the specified architecture. The architecture

"Runs tests on the specified architecture."

> +  specified must match the string passed to the ARCH make parameter.

ARCH is not a "make parameter", ARCH is a environment variable.
Therefor, ARCH is not "passed to make", as it a environment variable on
the shell. Check the ARCH documentation [1].

> +  For example, i386, x86_64, arm, um, etc. Non-UML architectures run on QEMU.
> +  Default to 'um'.
> +
> +- ``--cross_compile``: Specifies the Kbuild toolchain. It passes the
> +  same argument as passed to the ``CROSS_COMPILE`` variable used by> +  Kbuild. This will be the prefix for the toolchain
> +  binaries such as GCC. For example:
> +
> +  - ``sparc64-linux-gnu`` if we have the sparc toolchain installed on
> +    our system.
> +
> +  - ``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux``
> +    if we have downloaded the microblaze toolchain from the 0-day
> +    website to a specified path in our home directory called toolchains.

This is a copy of the explanation on [2]. You may want to delete the
previous explanation or change this one.

> +
> +- ``--qemu_config``: Specifies the path to the file containing a

"Specifies the path to a file containing a"

> +  custom qemu architecture definition. This should be a python file
> +  containing a QemuArchParams object.

"containing a `QemuArchParams` object."

The qemu_config has also a pretty good documentation on [2].

> +
> +- ``--qemu_args``: Specifies additional QEMU arguments, for example, "-smp 8".
> +
> +- ``--jobs``: Specifies the number of jobs (commands) to run simultaneously.
> +  By default, this is set to the number of cores on your system.

This CLI argument is already explained on [3]. You may want to delete
the previous explanation or change this one.

> +
> +- ``--timeout``: Specifies the maximum number of seconds allowed for all tests to run.
> +  This does not include the time taken to build the tests.

Same here.

> +
> +- ``--kernel_args``: Specifies the kernel command-line arguments. Might be repeated.
> +
> +- ``--run_isolated``: If set, boots the kernel for each individual suite/test.
> +  This is useful for debugging a non-hermetic test, one that
> +  might pass/fail based on what ran before it.
> +
> +- ``--raw_output``: If set, generates unformatted output from kernel.
> +  If set to ``--raw_output=kunit``, filters to just KUnit output.

This command line argument is already explain on the Parse Test Results
section [4].

> +
> +- ``--json``: If set, it stores the test results in a JSON format and prints to stdout or

"If set, it stores the test results in a JSON format and prints it to
`stdout` or"

> +  saves to a file if a filename is specified.

It's great to see new documentation for KUnit!

[1] https://docs.kernel.org/kbuild/kbuild.html#arch
[2]
https://docs.kernel.org/dev-tools/kunit/run_wrapper.html#run-tests-on-qemu
[3]
https://docs.kernel.org/dev-tools/kunit/run_wrapper.html#run-tests-with-kunit-tool
[4]
https://docs.kernel.org/dev-tools/kunit/run_wrapper.html#parse-test-results

Best Regards,
- Maíra Canal
