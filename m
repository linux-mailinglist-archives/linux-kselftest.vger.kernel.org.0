Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397CE393D08
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 May 2021 08:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhE1GSv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 May 2021 02:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhE1GSu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 May 2021 02:18:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A51FC06174A
        for <linux-kselftest@vger.kernel.org>; Thu, 27 May 2021 23:17:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g17so2035517wrs.13
        for <linux-kselftest@vger.kernel.org>; Thu, 27 May 2021 23:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTg7vSvSMg7/6ghE5wo0iVQ4AZ5FSEftwnKC/vRqzxM=;
        b=j0g+bdW/lBxdHQTCjNOqOH83aCtJu3dihgaaTtOsczJNfbEV7w4DruPkGZ6rAaMGAV
         kePWluUaQS2orgPxYvjf/E+bqD2gLG8eLx0MErdsWpVgBV8QpVoX+azGzheaGETycN8D
         KeKROIjWE6NyLDV4umTcwiv+Eba2HHjb/FWOr/P8gFwN2/6qPNL0LNH2eVZrYAPMcHwP
         AAXFnvHMpkvlxcDRK+TwdjrGhs5gJRgnFOGRjtPtgzmHfh4EiOrUqGIVHR3Ep8BA0i26
         gVHT68rQkfL8215DxCrJWvfTrg7Re7dzPP70D+xuholWS1ktW4xVUeovG9A+/xVVM9yB
         gXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTg7vSvSMg7/6ghE5wo0iVQ4AZ5FSEftwnKC/vRqzxM=;
        b=OQhZzlKYIsa+Ry4oHNJA79Z3CqA7XFHThCm4cS4jikG/6xrJWzbFn/AUTqIcyi1mTf
         S9c06k+TFf0dRXBEXhwDiLib1IiFobr+2sRDjqBQ8iSf6ooKCbw4pGnKTNl+RnGMKwl9
         i2h4rv6JMpmf4DmxP5gjvOgFcY0Ek8yovi29pFDe6ctD7YSC0g1A/fQtoZPyyPwtsl1f
         gOwAtmKVUQ5djh8LiJsxd6ACeedaySNH7mnqhdc0jzTSvdLmnNAq8CmLSvP2C3BkyKiY
         v1cSQwuJGXQqkHRgqydvkFWtstEeaEWer6KuwIbrFz8t8+liPTX8bqSoiM7kws57iuo6
         pI3g==
X-Gm-Message-State: AOAM532U2p8KjTH9BGbuIK9xGwGYPl1FwGQDWtIFxJg3pGoFTrFMy5qx
        zcv/s9oTIr62cur+FtKfa9ba/LqK0pD7Jtch83M7eA==
X-Google-Smtp-Source: ABdhPJz+VvvL1c9WVcBRcVmeW9gMz+SBb2P7gqH67arJOcyyBIN4ShwE0VJ1R0dUxCpKlR8EsnGirZ2cqZWdTxAtsbo=
X-Received: by 2002:adf:d08f:: with SMTP id y15mr6740140wrh.39.1622182633283;
 Thu, 27 May 2021 23:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210526212407.2753879-1-brendanhiggins@google.com> <20210526212407.2753879-5-brendanhiggins@google.com>
In-Reply-To: <20210526212407.2753879-5-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 28 May 2021 14:17:02 +0800
Message-ID: <CABVgOSnwMBg840Tf+hx5zrC-a56zyG8SYm3TDGq-5v48anNU7A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Documentation: kunit: document support for QEMU in kunit_tool
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 27, 2021 at 5:24 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Document QEMU support, what it does, and how to use it in kunit_tool.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> Changes since last revision:
>
> - Finally, I added a new section to the kunit_tool documentation to
>   document the new command line flags I added.
>

Thanks! This looks good to me, modulo a couple of nitpicky
spelling/grammar notes below.

Reviewed-by: David Gow <davidgow@google.com>

Cheers
-- David

> ---
>  Documentation/dev-tools/kunit/kunit-tool.rst | 48 +++++++++++++++++++
>  Documentation/dev-tools/kunit/usage.rst      | 50 +++++++++++++++-----
>  2 files changed, 87 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
> index 4247b7420e3ba..c7ff9afe407a5 100644
> --- a/Documentation/dev-tools/kunit/kunit-tool.rst
> +++ b/Documentation/dev-tools/kunit/kunit-tool.rst
> @@ -145,6 +145,54 @@ to run KUnit resource tests, you could use:
>
>  This uses the standard glob format for wildcards.
>
> +Running Tests on QEMU
> +=====================
> +
> +kunit_tool supports running tests on QEMU as well as via UML (as mentioned
> +elsewhere). The default way of running tests on QEMU requires two flags:
> +
> +``--arch``
> +       Selects a collection of configs (Kconfig as well as QEMU configs
> +       options, etc) that allow KUnit tests to be run on the specified

Nit: should "configs options" be "config options"?

> +       architecture in a minimal way; this is usually not much slower than
> +       using UML. The architecture argument is the same as the name of the
> +       option passed to the ``ARCH`` variable used by Kbuild. Not all
> +       architectures are currently supported by this flag, but can be handled
> +       by the ``--qemu_config`` discussed later. If ``um`` is passed (or this

Nit: "by the ``--qemu_config`` _option_", or just "by ``--qemu_config``".

> +       this flag is ignored) the tests will run via UML. Non-UML architectures,
> +       e.g. i386, x86_64, arm, um, etc. Non-UML run on QEMU.
> +
> +``--cross_compile``
> +       Specifies the use of a toolchain by Kbuild. The argument passed here is
> +       the same passed to the ``CROSS_COMPILE`` variable used by Kbuild. As a
> +       reminder this will be the prefix for the toolchain binaries such as gcc
> +       for example ``sparc64-linux-gnu-`` if you have the sparc toolchain
> +       installed on your system, or
> +       ``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux-``
> +       if you have downloaded the microblaze toolchain from the 0-day website
> +       to a directory in your home directory called ``toolchains``.
> +
> +In many cases it is likely that you may want to run an architecture which is
> +not supported by the ``--arch`` flag, or you may want to just run KUnit tests
> +on QEMU using a non-default configuration. For this use case, you can write
> +your own QemuConfig. These QemuConfigs are written in Python. They must have an
> +import line ``from ..qemu_config import QemuArchParams`` at the top of the file
> +and the file must contain a variable called ``QEMU_ARCH`` that has an instance
> +of ``QemuArchParams`` assigned to it. An example can be seen in
> +``tools/testing/kunit/qemu_configs/x86_64.py``.
> +
> +Once you have a QemuConfig you can pass it into kunit_tool using the
> +``--qemu_config`` flag; when used this flag replaces the ``--arch`` flag. If we
> +were to do this with the ``x86_64.py`` example from above, the invocation would
> +look something like this:
> +
> +.. code-block:: bash
> +
> +       ./tools/testing/kunit/kunit.py run \
> +               --timeout=60 \
> +               --jobs=12 \
> +               --qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
> +
>  Other Useful Options
>  ====================
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 650f99590df57..888c341701da4 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -609,17 +609,45 @@ non-UML architectures:
>  None of these are reasons not to run your KUnit tests on real hardware; they are
>  only things to be aware of when doing so.
>
> -The biggest impediment will likely be that certain KUnit features and
> -infrastructure may not support your target environment. For example, at this
> -time the KUnit Wrapper (``tools/testing/kunit/kunit.py``) does not work outside
> -of UML. Unfortunately, there is no way around this. Using UML (or even just a
> -particular architecture) allows us to make a lot of assumptions that make it
> -possible to do things which might otherwise be impossible.
> -
> -Nevertheless, all core KUnit framework features are fully supported on all
> -architectures, and using them is straightforward: all you need to do is to take
> -your kunitconfig, your Kconfig options for the tests you would like to run, and
> -merge them into whatever config your are using for your platform. That's it!
> +Currently, the KUnit Wrapper (``tools/testing/kunit/kunit.py``) (aka
> +kunit_tool) only fully supports running tests inside of UML and QEMU; however,

I was going to whinge a bit about the fact that we have three names
for the "KUnit Wrapper" here, and "KUnit Wrapper" didn't seem to be
used much. Then I looked at the rest of the documentation, and "KUnit
Wrapper" is used all over the place.

I think it'd be nice to consolidate on one (or, if we have to, two)
names for this, but this doc is probably not the place to do so.

> +this is only due to our own time limitations as humans working on KUnit. It is
> +entirely possible to support other emulators and even actual hardware, but for
> +now QEMU and UML is what is fully supported within the KUnit Wrapper. Again, to
> +be clear, this is just the Wrapper. The actualy KUnit tests and the KUnit

This maybe could be a little more succinct.
"for now only QEMU and UML are supported by  the KUnit Wrapper. The
KUnit library and most KUnit tests are fully architecture agnostic..."

Also, "actualy" -> "actually".

> +library they are written in is fully architecture agnostic and can be used in
> +virtually any setup, you just won't have the benefit of typing a single command
> +out of the box and having everything magically work perfectly.
> +
> +Again, all core KUnit framework features are fully supported on all
> +architectures, and using them is straightforward: Most popular architectures
> +are supported directly in the KUnit Wrapper via QEMU. Currently, supported
> +architectures on QEMU include:
> +
> +*   i386
> +*   x86_64
> +*   arm
> +*   arm64
> +*   alpha
> +*   powerpc
> +*   riscv
> +*   s390
> +*   sparc
> +
> +In order to run KUnit tests on one of these architectures via QEMU with the
> +KUnit wrapper, all you need to do is specify the flags ``--arch`` and
> +``--cross_compile`` when invoking the KUnit Wrapper. For example, we could run
> +the default KUnit tests on ARM in the following manner (assuming we have an ARM
> +toolchain installed):
> +
> +.. code-block:: bash
> +
> +       tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --arch=arm --cross_compile=arm-linux-gnueabihf-
> +
> +Alternatively, if you want to run your tests on real hardware or in some other
> +emulation environment, all you need to do is to take your kunitconfig, your
> +Kconfig options for the tests you would like to run, and merge them into
> +whatever config your are using for your platform. That's it!

Nit "your are" -> "you are" / "you're"

>
>  For example, let's say you have the following kunitconfig:
>
> --
> 2.31.1.818.g46aad6cb9e-goog
>
