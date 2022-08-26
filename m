Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99845A21DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 09:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245014AbiHZH35 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 03:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiHZH34 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 03:29:56 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C9181B2E
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 00:29:43 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id t64so285015vkb.12
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JlR/trpis3+yVvmobdJVyM2bgnKLqFR2qSdDfF0hnNM=;
        b=r3AYViG4ETWqnadJfFhujI/gn57QwdJ29bTvnksKfio4HeWkn+3m2PbcYVnS9zaj2o
         yG/pm8fQDzVMgxi4R73K60iSymxVr7jjWYDDuon0mePAHtsKJg3E/ktIStVFsCgsKn+i
         1YA7u5P8AsLJfAwEOVSqkft8UUXi2iLsDX4EYGimeOVIlYeVhSkEWtG1f/j+Nc8BjJSf
         ObGlFiKo3zNW8sV4APEBJcazKEYJeJjxQUSCEQ+bSTT001O9A7vsM5hAj9kRwjUAc4l6
         Xrnofma+/RR+h9KfpzsIoknaK8mWUIX5vfC5o09pPMPRWjSTh13BrnAHoSJs3mG4cLZG
         ZzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JlR/trpis3+yVvmobdJVyM2bgnKLqFR2qSdDfF0hnNM=;
        b=zqlyDLCQ8K3wIHuzFDjxUj7+H6GdnvZMYpSXxhZYob+jyWOOi8w/Ay6JYZIIQ6ZL+s
         fwbLmZe0ro5mXONlsYZGGCEHAt/CWA2ueyZ7XJtQOfMRv0UmbyP9/TAOFUjmGxWf/Odp
         nTysK9GNx3CcykB0U7J4MXHuf+V1sRkp88BQYx4LN3OigkY9UccCQ2ftmvQDdIfTBgXe
         rijFythMyYsMHPuoewDoyId5t15MS/+Dk4Z2e+IWShcyCdG//AlyZiWbxDZ+BH9ahvkt
         ERh5X04SeXEg8+nkwJ58aLyJHx5/hy6O/eOuCZIJsINB3rz7s+aad/mR5EA4T2C4C/pX
         9FVQ==
X-Gm-Message-State: ACgBeo3BX6RFJj5bAqmbneEjG8xe6iFPG9fMck0a2ZeOm2uOQcnnl3eJ
        hLsyVydmfbsUffUS3kSogTVOrEw6Mj7D32tS+S/hmw==
X-Google-Smtp-Source: AA6agR5ANh2BQXryfJ7USf/ao38bnOMB9SN8DkhdElvABtWzfs7z/lPomplvfAH4LGy2Pyb6uUB2yt4EhlF3d4EAadU=
X-Received: by 2002:a05:6122:635:b0:389:9ad6:f974 with SMTP id
 g21-20020a056122063500b003899ad6f974mr2794218vkp.4.1661498982559; Fri, 26 Aug
 2022 00:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220822022646.98581-1-tales.aparecida@gmail.com> <20220822022646.98581-2-tales.aparecida@gmail.com>
In-Reply-To: <20220822022646.98581-2-tales.aparecida@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 26 Aug 2022 15:29:30 +0800
Message-ID: <CABVgOSnNh4ESvhC+5aeypC7Zrh6GpYp0hnZx6rTavJ4mhU+CcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] Documentation: KUnit: remove duplicated docs for kunit_tool
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000adaf7b05e71fe0f9"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000adaf7b05e71fe0f9
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 22, 2022 at 10:30 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Delete "kunit-tool.rst" to remove repeated info from KUnit docs.
> "What is kunit_tool?" was integrated into index.rst, the remaining
> sections were moved into run_wrapper.rst and renamed as follows:
>
> "What is a .kunitconfig?" -> "Creating a ``.kunitconfig`` file"
> "Getting Started with kunit_tool" -> "Running tests with kunit_tool"
> "Configuring, Building, and Running Tests" ->
>         "Configuring, building, and running tests"
> "Running Tests on QEMU" -> "Running tests on QEMU"
> "Parsing Test Results" -> "Parsing test results"
> "Filtering Tests" -> "Filtering tests"
> "Other Useful Options" -> "Running command-line arguments"
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>
>
> ---
> Notes:
>     Update titles on run_wrapper.rst (Sadiya Kazi)
> ---
While I think there are some reasons we might want to keep this page,
ultimately, I agree we should get rid of it.

My concerns were basically that:
1. Having a distinction between a more tutorialised ("here's how to
run tests via kunit_tool") and reference-y ("a list of every option
kunit_tool has") pages makes sense. Then again, these pages were close
to identical in practice, so it's a theoretical objection at best.
2. There may be some links or references to the kunit_tool page (from
outside the kernel documentation) which will break. But, I'm not aware
of any, so they're certainly not common.

Let's move forward with this.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David



>  Documentation/dev-tools/kunit/index.rst       |   3 -
>  Documentation/dev-tools/kunit/kunit-tool.rst  | 232 ------------------
>  Documentation/dev-tools/kunit/run_wrapper.rst |  32 +--
>  Documentation/dev-tools/kunit/start.rst       |   2 -
>  4 files changed, 16 insertions(+), 253 deletions(-)
>  delete mode 100644 Documentation/dev-tools/kunit/kunit-tool.rst
>
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> index bc91ad7b8961..d7187282ba28 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -13,7 +13,6 @@ KUnit - Linux Kernel Unit Testing
>         run_wrapper
>         run_manual
>         usage
> -       kunit-tool
>         api/index
>         style
>         faq
> @@ -109,7 +108,5 @@ How do I use it?
>      examples.
>  *   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
>      used for testing.
> -*   Documentation/dev-tools/kunit/kunit-tool.rst - kunit_tool helper
> -    script.
>  *   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
>      answers.
> diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
> deleted file mode 100644
> index ae52e0f489f9..000000000000
> --- a/Documentation/dev-tools/kunit/kunit-tool.rst
> +++ /dev/null
> @@ -1,232 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0
> -
> -=================
> -kunit_tool How-To
> -=================
> -
> -What is kunit_tool?
> -===================
> -
> -kunit_tool is a script (``tools/testing/kunit/kunit.py``) that aids in building
> -the Linux kernel as UML (`User Mode Linux
> -<http://user-mode-linux.sourceforge.net/>`_), running KUnit tests, parsing
> -the test results and displaying them in a user friendly manner.
> -
> -kunit_tool addresses the problem of being able to run tests without needing a
> -virtual machine or actual hardware with User Mode Linux. User Mode Linux is a
> -Linux architecture, like ARM or x86; however, unlike other architectures it
> -compiles the kernel as a standalone Linux executable that can be run like any
> -other program directly inside of a host operating system. To be clear, it does
> -not require any virtualization support: it is just a regular program.
> -
> -What is a .kunitconfig?
> -=======================
> -
> -It's just a defconfig that kunit_tool looks for in the build directory
> -(``.kunit`` by default).  kunit_tool uses it to generate a .config as you might
> -expect. In addition, it verifies that the generated .config contains the CONFIG
> -options in the .kunitconfig; the reason it does this is so that it is easy to
> -be sure that a CONFIG that enables a test actually ends up in the .config.
> -
> -It's also possible to pass a separate .kunitconfig fragment to kunit_tool,
> -which is useful if you have several different groups of tests you wish
> -to run independently, or if you want to use pre-defined test configs for
> -certain subsystems.
> -
> -Getting Started with kunit_tool
> -===============================
> -
> -If a kunitconfig is present at the root directory, all you have to do is:
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py run
> -
> -However, you most likely want to use it with the following options:
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all`
> -
> -- ``--timeout`` sets a maximum amount of time to allow tests to run.
> -- ``--jobs`` sets the number of threads to use to build the kernel.
> -
> -.. note::
> -       This command will work even without a .kunitconfig file: if no
> -       .kunitconfig is present, a default one will be used instead.
> -
> -If you wish to use a different .kunitconfig file (such as one provided for
> -testing a particular subsystem), you can pass it as an option.
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig
> -
> -For a list of all the flags supported by kunit_tool, you can run:
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py run --help
> -
> -Configuring, Building, and Running Tests
> -========================================
> -
> -It's also possible to run just parts of the KUnit build process independently,
> -which is useful if you want to make manual changes to part of the process.
> -
> -A .config can be generated from a .kunitconfig by using the ``config`` argument
> -when running kunit_tool:
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py config
> -
> -Similarly, if you just want to build a KUnit kernel from the current .config,
> -you can use the ``build`` argument:
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py build
> -
> -And, if you already have a built UML kernel with built-in KUnit tests, you can
> -run the kernel and display the test results with the ``exec`` argument:
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py exec
> -
> -The ``run`` command which is discussed above is equivalent to running all three
> -of these in sequence.
> -
> -All of these commands accept a number of optional command-line arguments. The
> -``--help`` flag will give a complete list of these, or keep reading this page
> -for a guide to some of the more useful ones.
> -
> -Parsing Test Results
> -====================
> -
> -KUnit tests output their results in TAP (Test Anything Protocol) format.
> -kunit_tool will, when running tests, parse this output and print a summary
> -which is much more pleasant to read. If you wish to look at the raw test
> -results in TAP format, you can pass the ``--raw_output`` argument.
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py run --raw_output
> -
> -The raw output from test runs may contain other, non-KUnit kernel log
> -lines. You can see just KUnit output with ``--raw_output=kunit``:
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py run --raw_output=kunit
> -
> -If you have KUnit results in their raw TAP format, you can parse them and print
> -the human-readable summary with the ``parse`` command for kunit_tool. This
> -accepts a filename for an argument, or will read from standard input.
> -
> -.. code-block:: bash
> -
> -       # Reading from a file
> -       ./tools/testing/kunit/kunit.py parse /var/log/dmesg
> -       # Reading from stdin
> -       dmesg | ./tools/testing/kunit/kunit.py parse
> -
> -This is very useful if you wish to run tests in a configuration not supported
> -by kunit_tool (such as on real hardware, or an unsupported architecture).
> -
> -Filtering Tests
> -===============
> -
> -It's possible to run only a subset of the tests built into a kernel by passing
> -a filter to the ``exec`` or ``run`` commands. For example, if you only wanted
> -to run KUnit resource tests, you could use:
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py run 'kunit-resource*'
> -
> -This uses the standard glob format for wildcards.
> -
> -Running Tests on QEMU
> -=====================
> -
> -kunit_tool supports running tests on QEMU as well as via UML (as mentioned
> -elsewhere). The default way of running tests on QEMU requires two flags:
> -
> -``--arch``
> -       Selects a collection of configs (Kconfig as well as QEMU configs
> -       options, etc) that allow KUnit tests to be run on the specified
> -       architecture in a minimal way; this is usually not much slower than
> -       using UML. The architecture argument is the same as the name of the
> -       option passed to the ``ARCH`` variable used by Kbuild. Not all
> -       architectures are currently supported by this flag, but can be handled
> -       by the ``--qemu_config`` discussed later. If ``um`` is passed (or this
> -       this flag is ignored) the tests will run via UML. Non-UML architectures,
> -       e.g. i386, x86_64, arm, um, etc. Non-UML run on QEMU.
> -
> -``--cross_compile``
> -       Specifies the use of a toolchain by Kbuild. The argument passed here is
> -       the same passed to the ``CROSS_COMPILE`` variable used by Kbuild. As a
> -       reminder this will be the prefix for the toolchain binaries such as gcc
> -       for example ``sparc64-linux-gnu-`` if you have the sparc toolchain
> -       installed on your system, or
> -       ``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux-``
> -       if you have downloaded the microblaze toolchain from the 0-day website
> -       to a directory in your home directory called ``toolchains``.
> -
> -In many cases it is likely that you may want to run an architecture which is
> -not supported by the ``--arch`` flag, or you may want to just run KUnit tests
> -on QEMU using a non-default configuration. For this use case, you can write
> -your own QemuConfig. These QemuConfigs are written in Python. They must have an
> -import line ``from ..qemu_config import QemuArchParams`` at the top of the file
> -and the file must contain a variable called ``QEMU_ARCH`` that has an instance
> -of ``QemuArchParams`` assigned to it. An example can be seen in
> -``tools/testing/kunit/qemu_configs/x86_64.py``.
> -
> -Once you have a QemuConfig you can pass it into kunit_tool using the
> -``--qemu_config`` flag; when used this flag replaces the ``--arch`` flag. If we
> -were to do this with the ``x86_64.py`` example from above, the invocation would
> -look something like this:
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py run \
> -               --timeout=60 \
> -               --jobs=12 \
> -               --qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
> -
> -Other Useful Options
> -====================
> -
> -kunit_tool has a number of other command-line arguments which can be useful
> -when adapting it to fit your environment or needs.
> -
> -Some of the more useful ones are:
> -
> -``--help``
> -       Lists all of the available options. Note that different commands
> -       (``config``, ``build``, ``run``, etc) will have different supported
> -       options. Place ``--help`` before the command to list common options,
> -       and after the command for options specific to that command.
> -
> -``--build_dir``
> -       Specifies the build directory that kunit_tool will use. This is where
> -       the .kunitconfig file is located, as well as where the .config and
> -       compiled kernel will be placed. Defaults to ``.kunit``.
> -
> -``--make_options``
> -       Specifies additional options to pass to ``make`` when compiling a
> -       kernel (with the ``build`` or ``run`` commands). For example, to enable
> -       compiler warnings, you can pass ``--make_options W=1``.
> -
> -``--alltests``
> -        Builds a UML kernel with all config options enabled using ``make
> -        allyesconfig``. This allows you to run as many tests as is possible,
> -        but is very slow and prone to breakage as new options are added or
> -        modified. In most cases, enabling all tests which have satisfied
> -        dependencies by adding ``CONFIG_KUNIT_ALL_TESTS=1`` to your
> -        .kunitconfig is preferable.
> -
> -There are several other options (and new ones are often added), so do check
> -``--help`` if you're looking for something not mentioned here.
> diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
> index a1070def284f..518cf87ea732 100644
> --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ b/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
>
> -=========================
> -Run Tests with kunit_tool
> -=========================
> +=============================
> +Running tests with kunit_tool
> +=============================
>
>  We can either run KUnit tests using kunit_tool or can run tests
>  manually, and then use kunit_tool to parse the results. To run tests
> @@ -58,8 +58,8 @@ To view kunit_tool flags (optional command-line arguments), run:
>
>         ./tools/testing/kunit/kunit.py run --help
>
> -Create a  ``.kunitconfig`` File
> -===============================
> +Creating a ``.kunitconfig`` file
> +================================
>
>  If we want to run a specific set of tests (rather than those listed
>  in the KUnit ``defconfig``), we can provide Kconfig options in the
> @@ -98,8 +98,8 @@ have not included the options dependencies.
>     The build dir needs to be set for ``make menuconfig`` to
>     work, therefore  by default use ``make O=.kunit menuconfig``.
>
> -Configure, Build, and Run Tests
> -===============================
> +Configuring, building, and running tests
> +========================================
>
>  If we want to make manual changes to the KUnit build process, we
>  can run part of the KUnit build process independently.
> @@ -125,11 +125,11 @@ argument:
>
>         ./tools/testing/kunit/kunit.py exec
>
> -The ``run`` command discussed in section: **Run Tests with kunit_tool**,
> +The ``run`` command discussed in section: **Running tests with kunit_tool**,
>  is equivalent to running the above three commands in sequence.
>
> -Parse Test Results
> -==================
> +Parsing test results
> +====================
>
>  KUnit tests output displays results in TAP (Test Anything Protocol)
>  format. When running tests, kunit_tool parses this output and prints
> @@ -152,8 +152,8 @@ standard input.
>         # Reading from stdin
>         dmesg | ./tools/testing/kunit/kunit.py parse
>
> -Run Selected Test Suites
> -========================
> +Filtering tests
> +===============
>
>  By passing a bash style glob filter to the ``exec`` or ``run``
>  commands, we can run a subset of the tests built into a kernel . For
> @@ -167,8 +167,8 @@ This uses the standard glob format with wildcard characters.
>
>  .. _kunit-on-qemu:
>
> -Run Tests on qemu
> -=================
> +Running tests on QEMU
> +=====================
>
>  kunit_tool supports running tests on  qemu as well as
>  via UML. To run tests on qemu, by default it requires two flags:
> @@ -231,8 +231,8 @@ as
>                 --jobs=12 \
>                 --qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
>
> -Command-Line Arguments
> -======================
> +Running command-line arguments
> +==============================
>
>  kunit_tool has a number of other command-line arguments which can
>  be useful for our test environment. Below are the most commonly used
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index 867a4bba6bf6..e730df1f468e 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -254,7 +254,5 @@ Next Steps
>      examples.
>  *   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
>      used for testing.
> -*   Documentation/dev-tools/kunit/kunit-tool.rst - kunit_tool helper
> -    script.
>  *   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
>      answers.
> --
> 2.37.2
>

--000000000000adaf7b05e71fe0f9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDt
1ds6W2OPGLu0xN+8vTMtC9ZNlHZONmvTB/HzLCdXXDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MjYwNzI5NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAGakfSa1NTiqnxu3GYpWN
1m2ig0eSFyT4mCqTihIUrNRIEOjz0AJTZbAxR+NdRpWCe7xSCigAzM9EL38wE7sx3/25O6HcezrJ
G7QhRN0R7q8NQ0fJLsKPTS+SMHn5y5B3z7cW1hqBgfZj6TzASAdYq5gnVuz6ndFy1ADe5d036Tep
kJn7wuBJPB5+F80OqAa2B6yadIrmIqh2n3UzxU8B8IKwUhVQGI7an5zQu/qSKIU2HJK6ApmSvRjc
yCoQbQMYwHvP7ldPGjgAgduAGa+5e/a63Rbm1THwEl4UtneVl8rgjFJAAeVr+HZohYvbyZKOeZTK
tP1CAitsRCBhzudLUA==
--000000000000adaf7b05e71fe0f9--
