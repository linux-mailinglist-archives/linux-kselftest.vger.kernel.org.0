Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193DD57D775
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jul 2022 01:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiGUXy2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 19:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGUXy0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 19:54:26 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C2278232
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 16:54:21 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id f3so1303993uaq.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtYczuHhIpE7bWu8QNlaqNlPc/Yb6w4amtZYdihwjGs=;
        b=aSybbqRteJF9FM1MEcuxfiEKcG3cKkUItxrCLrCsmhgJy4Gb0C5Dp2cgVQ4XUaO+oF
         xDwSwtlT6oMFmf9vRO40yVSKfuMzw3PoaMIidUQqAmGpY3S6XQH0NfW+lbpGJRehAim5
         KTQrTPvHhfDa0ykkbFYF/MmHTl8c9euFhC6U7FvGEYv6WwcjUSMwgHKG2oxLmHpz03Eb
         +6JmxGIcyHYAn6J6jUkavfj7qxiUEKF+TD1hXJVH5vhtd0CTcePdQfUReE/EsGs3ZbBl
         fLglp7wn7r91YMYgebMMcTDVorqh1ghjEROrlRHLcGaqGdd2l4wInpGWqrjxQaPq1XXh
         INRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtYczuHhIpE7bWu8QNlaqNlPc/Yb6w4amtZYdihwjGs=;
        b=X4Ly1vbEail9U5sLQA/gt2diUft6NNBbJg20xkG6ijnXEqtRlb0ZUipNMmm3/019yu
         C2zVioC9uUlcBdA1SwV6avc4fAq+2xhrAMf3XzlTdZEV9kbzAMAOhXGJa9e8iN1SwoJE
         q/1SClm3zwmsEU6rrsaiyLngEz8cC1lGH+pZfy22yxlKwEMBT+EK14+eKcbUUeW0zChZ
         fs5Av1wR8b7a3B0O4hn70WHIBx74ib73n8CBzaG4see4ryHf8S65pmmq6vftxUCtAIHG
         MILDW8uopRPdzbW4hlAZCQWvfRvpZFRiCKOcY7psBqE6XB1mrTe8ZoaQntq1kek2bY2B
         nRHQ==
X-Gm-Message-State: AJIora/WJmqd3cr3qih5GsBdiiWQfDvv11M1vNpWEq3ho/MAcKG5oHUz
        n4u1lNwQb6uwHHT2PAfC08ZeVrKqJEN0omF+FYIXPg==
X-Google-Smtp-Source: AGRyM1tdx8kLjlcV51jrflrWwGExmOREJd4TjCuKF5p8XGFc3o+TklGRnmVssXjDKp+NGaD1drIjrjgkBk9hTuKzyc0=
X-Received: by 2002:a9f:2f0f:0:b0:384:26c2:ead1 with SMTP id
 x15-20020a9f2f0f000000b0038426c2ead1mr277189uaj.107.1658447660782; Thu, 21
 Jul 2022 16:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220721081026.1247067-1-sadiyakazi@google.com>
In-Reply-To: <20220721081026.1247067-1-sadiyakazi@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 Jul 2022 07:54:09 +0800
Message-ID: <CABVgOS=iOkquTXEPdS1skRj7Bda-H-REDW8mozziEYjn8RnRnw@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: Add CLI args for kunit_tool
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 21, 2022 at 4:26 PM Sadiya Kazi <sadiyakazi@google.com> wrote:
>
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

Looks good to me. A couple of super-minor suggestions below, and a
note about how KASAN/UML support hasn't fully landed yet (but I still
like it as an example, so maybe leave it as-is).

None of these are deal breakers, though, and I'd be okay with this
going in as-is, as well.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

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
> +

Just FYI, this example won't work as-is until KASAN for UML is merged.
It's already sitting in uml/next, so this shouldn't be a problem:
https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git/commit/?h=next&id=5b301409e8bc5d7fad2ee138be44c5c529dd0874

But if you want to try it on 5.19 or the current kunit branch, you'll
need to add, e.g., --arch=x86_64

> +- ``--arch``: Runs tests on the specified architecture. The architecture
> +  specified must match the Kbuild ARCH environment variable.

I'm not quite sold on 'must match the Kbuild ARCH environment
variable'. That seems to imply to me that you need to set ARCH= _and_
use --arch. Instead, --arch itself sets ARCH=, so the values use the
same names.

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
> +
> +- ``--qemu_args``: Specifies additional QEMU arguments, for example, "-smp 8".
> +
> +- ``--jobs``: Specifies the number of jobs (commands) to run simultaneously.4
> +  By default, this is set to the number of cores on your system.
> +
> +- ``--timeout``: Specifies the maximum number of seconds allowed for all tests to run.
> +  This does not include the time taken to build the tests.
> +
> +- ``--kernel_args``: Specifies additional kernel command-line arguments. Might be repeated.

Nit: maybe "can be repeated"? As it's the reader of this documentation
who will likely be doing the repeating. Or "may be repeated"?
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
> --
> 2.37.0.170.g444d1eabd0-goog
>
