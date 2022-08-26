Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED765A2013
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 06:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbiHZEze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 00:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244830AbiHZEzc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 00:55:32 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B71EA4
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Aug 2022 21:55:29 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id d6so180723vko.7
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Aug 2022 21:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1jtmWtzM6Yk07qzjuLVCq+dPF0Ezq/6MS5+GxOyTMng=;
        b=Nb2/gKRm3cZMlWGprybC5wjbnytVFXIi3Pi6etqqAxmwkji+HDAbnMVB+/WdBq98On
         Q3jLqjtvF3BTEF48FsbcGso8eB17tl+v0wYZVWJcMHPBuT/43ZpmBpSxoHCGSEhghd6U
         FXNe4SRCrjtreBZiVnsEqDWglKY6WjV8iIu2t7ELKmJ/Wqc4zjfhnEUDGBhhhh2WIqJ+
         D2szqCbF9uA6PBDsmzvad1AFfydZuFwXjQsRtthVTlDbh/R5WVDs57fXzFfLhCFGEKAC
         RyXgxr/An6j/MJwq1NrJAk715oZCOmM/v9/BgmPvu1sVnOpUugRh2P8RfvsUoRiLHhCy
         s54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1jtmWtzM6Yk07qzjuLVCq+dPF0Ezq/6MS5+GxOyTMng=;
        b=bOGwHCtkXjOyLHm9T9uGSLnQYKG8zORjI0djNsyWi1fzh5H3TydlKnKCNoXuKInsXs
         IW1YKXYlFBzCrsfL0zQIort2a7DeZX5l7xNyNhE+vGjxlgJlcXl+L43CqyrldovGDirL
         QhZ69kYHMQ0fGDZQMBm7HtyTmptLKQK+MtoWiyW4kIbJREgo6rqzRpxTK3tnnU+Gjmo8
         TfMW8WDhr2UvPl6ptebp3XU39JGZ8sw/PhC/cq3ID27G6xQHE3FaZemRjLXmtMupm0/Q
         BkQNA/07pqWl8PmVOJnA9O0IG15CQH8gqzx9xGUMOsKqf703ERNa3+M2x/rqxv3UxIuG
         Rxig==
X-Gm-Message-State: ACgBeo13keuL2z7+aSI09MBhMe1wyKyeUCIc8bJgGvJItbHM9SBBcm/f
        b3gS1vdol2tnURpgM0D6DGE6cq+M8DsGcokzfSC9UA==
X-Google-Smtp-Source: AA6agR7itMs1AgKOk/B63AVRKiAeKtGyry8X+MDUfJNL6DWKrQJRQ5nSFbIx+zA9UCJZ81QyIjBeXrAwmIJu13vwH10=
X-Received: by 2002:a1f:ad50:0:b0:377:fba2:803b with SMTP id
 w77-20020a1fad50000000b00377fba2803bmr2777109vke.34.1661489728388; Thu, 25
 Aug 2022 21:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220822180956.4013497-1-sadiyakazi@google.com>
In-Reply-To: <20220822180956.4013497-1-sadiyakazi@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 26 Aug 2022 12:55:16 +0800
Message-ID: <CABVgOSkhT2dVOuzzNYuYWp_s4VLPjHST++xQqeq7j0nKKfjh8g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: KUnit: Reword kunit_tool guide
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001ad4f505e71db945"
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

--0000000000001ad4f505e71db945
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 23, 2022 at 2:10 AM Sadiya Kazi <sadiyakazi@google.com> wrote:
>
> Updated the kunit_tool.rst guide to streamline it. The following changes
> were made:
> 1. Updated headings
> 2. Reworded content across sections
> 3. Added a cross reference to full list of command-line args
>
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> ---

This looks okay overall, but there are definitely some parts I'm more
comfortable with than others.

The "kunit_tool How-To" name was fine by my book, but I also like
"Understanding kunit_tool".

My biggest concern here is actually that there's another patch which
removes this page entirely. It makes very little sense to tidy this up
only to delete it:
https://lore.kernel.org/all/20220822022646.98581-2-tales.aparecida@gmail.com/

While there is an argument for keeping this page (its purpose as a
"reference" differs slightly from the more "tutorialised"
run_wrapper.rst, as well as wanting to avoid breaking any external
links if we can), I think that overall, we'll probably lose this page
entirely.

Regardless, I've commented on the exact changes below.

Cheers,
-- David

>  Documentation/dev-tools/kunit/kunit-tool.rst | 82 ++++++++++----------
>  1 file changed, 42 insertions(+), 40 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
> index ae52e0f489f9..33186679f5de 100644
> --- a/Documentation/dev-tools/kunit/kunit-tool.rst
> +++ b/Documentation/dev-tools/kunit/kunit-tool.rst
> @@ -1,8 +1,10 @@
>  .. SPDX-License-Identifier: GPL-2.0
>
> -=================
> -kunit_tool How-To
> -=================
> +========================
> +Understanding kunit_tool
> +========================
> +
> +This page introduces the kunit_tool and covers the concepts and working of this tool.

Nit: just "kunit_tool", not "the kunit_tool". Also, is this sentence
really telling us anything?

>
>  What is kunit_tool?
>  ===================
> @@ -10,39 +12,37 @@ What is kunit_tool?
>  kunit_tool is a script (``tools/testing/kunit/kunit.py``) that aids in building
>  the Linux kernel as UML (`User Mode Linux
>  <http://user-mode-linux.sourceforge.net/>`_), running KUnit tests, parsing
> -the test results and displaying them in a user friendly manner.
> +the test results and displaying them in a user-friendly manner.
>
>  kunit_tool addresses the problem of being able to run tests without needing a
>  virtual machine or actual hardware with User Mode Linux. User Mode Linux is a
>  Linux architecture, like ARM or x86; however, unlike other architectures it
> -compiles the kernel as a standalone Linux executable that can be run like any
> +compiles the kernel as a standalone Linux executable. This executable can be run like any
>  other program directly inside of a host operating system. To be clear, it does
>  not require any virtualization support: it is just a regular program.
>
> -What is a .kunitconfig?
> -=======================
> +What is .kunitconfig?
> +=====================

There can be multiple .kunitconfig files, so this may make sense to
leave as "a .kunitconfig"

>
> -It's just a defconfig that kunit_tool looks for in the build directory
> -(``.kunit`` by default).  kunit_tool uses it to generate a .config as you might
> -expect. In addition, it verifies that the generated .config contains the CONFIG
> -options in the .kunitconfig; the reason it does this is so that it is easy to
> -be sure that a CONFIG that enables a test actually ends up in the .config.
> +.kunitconfig is a default configuration file (defconfig) that kunit_tool looks
> +for in the build directory (``.kunit``). The kunit_tool uses this file to
> +generate a .config. Additionally, it also verifies that the generated .config contains the CONFIG options in the .kunitconfig file. This is done to make sure that a CONFIG that enables a test is  actually part of the .config file.

Word wrapping, "the kunit_tool" -> "kunit_tool", the build directory
may not be ``.kunit``, so re-introduce "by default".

>
> -It's also possible to pass a separate .kunitconfig fragment to kunit_tool,
> +It is also possible to pass a separate .kunitconfig fragment to kunit_tool,
>  which is useful if you have several different groups of tests you wish
> -to run independently, or if you want to use pre-defined test configs for
> +to run independently, or if you want to use pre-defined test configurations for
>  certain subsystems.
>
> -Getting Started with kunit_tool
> +Getting started with kunit_tool

The capitalisation of headings in the KUnit documentation (and,
indeed, the whole kernel documentation) is pretty inconsistent. I
wouldn't mind it if these changes to improve consistency, but let's
not just change one page without committing to doing so on all of
them. Particularly since, at the moment, I think we're using (an
approximation of) title-case in more pages.

>  ===============================
>
> -If a kunitconfig is present at the root directory, all you have to do is:
> +If a kunitconfig is present at the root directory, run the following command:

Do we want to standardise on .kunitconfig or kunitconfig? I think we'd
decided that we should use ".kunitconfig" everywhere.

Also, this is outdated: the .kunitconfig needs to be in the build
directory, not the root directory.



>  .. code-block:: bash
>
>         ./tools/testing/kunit/kunit.py run
>
> -However, you most likely want to use it with the following options:
> +However, most likely you may want to use it with the following options:

Personally, I find the earlier version clearer here, but could live
with the change if there's a good reason behind it I'm missing...

>
>  .. code-block:: bash
>
> @@ -68,20 +68,20 @@ For a list of all the flags supported by kunit_tool, you can run:
>
>         ./tools/testing/kunit/kunit.py run --help
>
> -Configuring, Building, and Running Tests
> +Configuring, building, and running tests
>  ========================================
>
> -It's also possible to run just parts of the KUnit build process independently,
> -which is useful if you want to make manual changes to part of the process.
> +It is also possible to run specific parts of the KUnit build process independently.
> +This is useful if you want to make manual changes to part of the process.
>
> -A .config can be generated from a .kunitconfig by using the ``config`` argument
> +If you want to generate a .config from a .kunitconfig, you can use the ``config`` argument
>  when running kunit_tool:
>
>  .. code-block:: bash
>
>         ./tools/testing/kunit/kunit.py config
>
> -Similarly, if you just want to build a KUnit kernel from the current .config,
> +Similarly, if you want to build a KUnit kernel from the current .config,

I think the "just" here is valuable: "kunit.py run" is the default
that most people will use, and it's very easy to assume "kunit.py
build" will do everything required to build the kernel (including
config), but it doesn't.

>  you can use the ``build`` argument:
>
>  .. code-block:: bash
> @@ -95,33 +95,31 @@ run the kernel and display the test results with the ``exec`` argument:
>
>         ./tools/testing/kunit/kunit.py exec
>
> -The ``run`` command which is discussed above is equivalent to running all three
> +The ``run`` command, discussed above is equivalent to running all three
>  of these in sequence.
>
>  All of these commands accept a number of optional command-line arguments. The
>  ``--help`` flag will give a complete list of these, or keep reading this page
>  for a guide to some of the more useful ones.
>
> -Parsing Test Results
> +Parsing test results
>  ====================
>
> -KUnit tests output their results in TAP (Test Anything Protocol) format.
> -kunit_tool will, when running tests, parse this output and print a summary
> -which is much more pleasant to read. If you wish to look at the raw test
> -results in TAP format, you can pass the ``--raw_output`` argument.
> +The output of the KUnit test results are displayed in TAP (Test Anything Protocol) format.
> +When running tests, the kunit_tool parses this output and prints a plaintext, human-readable summary. To view the raw test results in TAP format, you can use the ``--raw_output`` argument.

Word wrapping.

>
>  .. code-block:: bash
>
>         ./tools/testing/kunit/kunit.py run --raw_output
>
>  The raw output from test runs may contain other, non-KUnit kernel log
> -lines. You can see just KUnit output with ``--raw_output=kunit``:
> +lines. To view only the KUnit output, you can use ``--raw_output=kunit``:
>
>  .. code-block:: bash
>
>         ./tools/testing/kunit/kunit.py run --raw_output=kunit
>
> -If you have KUnit results in their raw TAP format, you can parse them and print
> +If you have KUnit results in the raw TAP format, you can parse them and print
>  the human-readable summary with the ``parse`` command for kunit_tool. This
>  accepts a filename for an argument, or will read from standard input.
>
> @@ -135,11 +133,11 @@ accepts a filename for an argument, or will read from standard input.
>  This is very useful if you wish to run tests in a configuration not supported
>  by kunit_tool (such as on real hardware, or an unsupported architecture).
>
> -Filtering Tests
> +Filtering tests
>  ===============
>
> -It's possible to run only a subset of the tests built into a kernel by passing
> -a filter to the ``exec`` or ``run`` commands. For example, if you only wanted
> +It is possible to run only a subset of the tests built into a kernel by passing
> +a filter to the ``exec`` or ``run`` commands. For example, if you want
>  to run KUnit resource tests, you could use:

Again, I'm quite partial to the "only" here, as test filtering can
only _remove_ tests/suites from the set to be executed, not add them.


>
>  .. code-block:: bash
> @@ -148,15 +146,14 @@ to run KUnit resource tests, you could use:
>
>  This uses the standard glob format for wildcards.
>
> -Running Tests on QEMU
> +Running tests on QEMU
>  =====================
>
> -kunit_tool supports running tests on QEMU as well as via UML (as mentioned
> -elsewhere). The default way of running tests on QEMU requires two flags:
> +kunit_tool supports running tests on QEMU as well as via UML. The default way of running tests on QEMU requires two flags:

Word Wrapping

>
>  ``--arch``
>         Selects a collection of configs (Kconfig as well as QEMU configs
> -       options, etc) that allow KUnit tests to be run on the specified
> +       options and so on) that allow KUnit tests to be run on the specified

Do we really need to remove "etc"? "and so on" is less visually distinct, IMO.

>         architecture in a minimal way; this is usually not much slower than
>         using UML. The architecture argument is the same as the name of the
>         option passed to the ``ARCH`` variable used by Kbuild. Not all
> @@ -196,8 +193,8 @@ look something like this:
>                 --jobs=12 \
>                 --qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
>
> -Other Useful Options
> -====================
> +Other useful options
> +======================
>
>  kunit_tool has a number of other command-line arguments which can be useful
>  when adapting it to fit your environment or needs.
> @@ -228,5 +225,10 @@ Some of the more useful ones are:
>          dependencies by adding ``CONFIG_KUNIT_ALL_TESTS=1`` to your
>          .kunitconfig is preferable.
>
> -There are several other options (and new ones are often added), so do check
> +There are several other options (and new ones are often added), so do run
>  ``--help`` if you're looking for something not mentioned here.
> +For more information on these options, see `Command-line-arguments
> +<https://www.kernel.org/doc/html/latest/dev-tools/kunit/run_wrapper.html#command-line-arguments>`__
> +
> +
> +.

Newlines, full stop at the end of this doc should be removed.

> --
> 2.37.1.595.g718a3a8f04-goog
>

--0000000000001ad4f505e71db945
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB4
ZcJ8TeQ52Ba+caWzi07cmCAdiQNtUq0rG8YAr5vNCDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MjYwNDU1MjlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAGI8w4xVx4vXg+ROTxOY3
mdJD6MqB9wjr410dSwJuFvYoaiDRxrPHzEsQxibRYdC5kKsbWr6AIsU7+Gy6pvpgQiwDftj5J2N4
ULH4DPqlHI9HmxJ0djbUMxOQwWmPc1XEQtdCeOehzHIO7DoQcu33kEMXRH9L2IiVvbWi6leXTJRC
zQySQSJ7Os1+ivYqEwbvVC+eJuS4A390SUnQNQOH4JFp7NoSvkGKMozRdnuDHCHDD9PDxiNa5ztA
IVH7KAflSeFholiDdPoViaRFe0T8HoMSyjnibDVhjrjY4fHIxocYwfLzRkMPmt03S6iL56XImfJF
XoFEeLadW0QgwW2fLg==
--0000000000001ad4f505e71db945--
