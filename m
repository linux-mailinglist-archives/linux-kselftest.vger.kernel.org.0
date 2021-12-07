Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94A846B2A3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 06:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhLGF5C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 00:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLGF5B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 00:57:01 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC854C061746
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 21:53:31 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id l24so24449243uak.2
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Dec 2021 21:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqHDZyVf7fgTG+ga4HpiYWXkGhE03mIlODLJWPiIug8=;
        b=J2Jkd1scsl/Ir3tRrbckF2npsOaQqjjAW/UmvV0ujnObQrY1FjXxwDKXiAKRGKxzeY
         HXiJjSIHsvffAy3OvO8RIS0a8m7E7a6GaW7K3UU+n75FP2/aJD9Uk85fbaxrOL5hwMbi
         5qnUenhP/SQZDN5H1b3Q7OHd2i8y2/DLRjQ5NOULxwugwP3iV/48n4IJJtDqBsq0vA2n
         wIi5Ngwcm8aenTWCS72CcjSGw6hRaLz2NSx6EGIKnhKQsR/WnD/4rfwMbiCSgAOhG6qF
         FlgRN2t2VQ8ge8ABMiChNed0a5Z3uZhjmgFxXwrRaIkzaT4mfrccOhscyaEDXAumKCvg
         NQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqHDZyVf7fgTG+ga4HpiYWXkGhE03mIlODLJWPiIug8=;
        b=BhwHhm4cpCsabz3BOUTRm/5M0l2N9qq5S8npEw/npKF3akmVzwYJt9x3Q3X1GroVR+
         Gadvb2WJMF6KbmjaJ1c2W/PEIzwKnEj/c7laG19jH3QS4lOaDwEcbB2AfhryP51nXE+j
         6BLHrJ7uy3l1zInL8nIZzesa1e/MGfGC8dgeFYz7ByHTbg4gq4C1ShuN/4IH6mS9Y8xR
         2OzJpb/n6ruJnF8+pneB123TaUJR48sYPJYvzNHJUbUetnF/Zy4FpiXhvYASBriXZmKJ
         HHd8nYPWhEGM0/lOrUstLxHgWgMDSX9vIY7tvBwBHfW/S4FBfO7C70+IyPIQOsrfjlwn
         7v7A==
X-Gm-Message-State: AOAM532LBbOlPmTgir4VwNOQOb006K48zMBaljqx2ZgYtja23niQsgEu
        55MEC+H9Rxa07kPr7f3uIgbVE182ed3j74f66M9jwOexI9l6NVHO
X-Google-Smtp-Source: ABdhPJx5tzzHjJaJCjXh6SUaHfrTZx90R4esWq2ZOoRDdPHClFW0Ma69W24nkEyg16IBMm0PQWepsiaB2BRjQzWVc8I=
X-Received: by 2002:a05:6102:a4a:: with SMTP id i10mr42041933vss.47.1638856410752;
 Mon, 06 Dec 2021 21:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20211203042437.740255-1-sharinder@google.com> <20211203042437.740255-3-sharinder@google.com>
 <BYAPR13MB25033EC6C480D74E59D6DE75FD6A9@BYAPR13MB2503.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB25033EC6C480D74E59D6DE75FD6A9@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   Harinder Singh <sharinder@google.com>
Date:   Tue, 7 Dec 2021 11:23:20 +0530
Message-ID: <CAHLZCaEqr-0OipzKhDRXgtqrYqxNT6rNWpk5orFY0m5mYFdb2Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] Documentation: KUnit: Rewrite getting started
To:     tim.bird@sony.com
Cc:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Tim,

Thanks for the review comments.

I incorporated your comments in v2 here:
https://lore.kernel.org/linux-kselftest/20211207054019.1455054-3-sharinder@google.com/

Please see my comments below.

On Sat, Dec 4, 2021 at 12:04 AM <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Harinder Singh <sharinder@google.com>
> > Sent: Thursday, December 2, 2021 9:25 PM
> > To: davidgow@google.com; brendanhiggins@google.com; shuah@kernel.org; corbet@lwn.net
> > Cc: linux-kselftest@vger.kernel.org; kunit-dev@googlegroups.com; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; Harinder
> > Singh <sharinder@google.com>
> > Subject: [PATCH v1 2/7] Documentation: KUnit: Rewrite getting started
> >
> > Clarify the purpose of kunit_tool and fixed consistency issues
> >
> > Signed-off-by: Harinder Singh <sharinder@google.com>
> > ---
> >  Documentation/dev-tools/kunit/start.rst | 192 ++++++++++++------------
> >  1 file changed, 98 insertions(+), 94 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > index 1e00f9226f74..04b6b6a37488 100644
> > --- a/Documentation/dev-tools/kunit/start.rst
> > +++ b/Documentation/dev-tools/kunit/start.rst
> > @@ -4,132 +4,131 @@
> >  Getting Started
> >  ===============
> >
> > -Installing dependencies
> > +Installing Dependencies
> >  =======================
> > -KUnit has the same dependencies as the Linux kernel. As long as you can build
> > -the kernel, you can run KUnit.
> > +KUnit has the same dependencies as the Linux kernel. As long as you can
> > +build the kernel, you can run KUnit.
> >
> > -Running tests with the KUnit Wrapper
> > -====================================
> > -Included with KUnit is a simple Python wrapper which runs tests under User Mode
> > -Linux, and formats the test results.
> > -
> > -The wrapper can be run with:
> > +Running tests with kunit_tool
> > +=============================
> > +kunit_tool is a Python script, which configures and build a kernel, runs
>
> build -> builds

Done

> > +tests, and formats the test results. From the kernel repository, you
> > +can run kunit_tool:
> >
> >  .. code-block:: bash
> >
> >       ./tools/testing/kunit/kunit.py run
> >
> > -For more information on this wrapper (also called kunit_tool) check out the
> > -Documentation/dev-tools/kunit/kunit-tool.rst page.
> > +For more information on this wrapper, see:
> > +Documentation/dev-tools/kunit/kunit-tool.rst.
> > +
> > +Creating a ``.kunitconfig``
> > +---------------------------
> > +If you want to run a specific set of tests (rather than those listed in
> > +the KUnit ``defconfig``), you can provide Kconfig options in the
> > +``.kunitconfig`` file.
>
> I know you didn't change this sentence, but it never made sense to me.
> If we're in here changing the format, can we rewrite this to be more clear?
>
> What is the purpose of .kunitconfig?
>
> Here's an alternative wording (which I'm not sure is correct):
>
> By default, KUnit provides a ``defconfig`` which runs all of the unit
> tests.  However, you can control which set of unit tests to run by creating
> a ``.kunitconfig`` file with kernel config options that enable only a specific
> set of tests and their dependencies.

Rewrote the paragraph.

> > This file contains the regular
> > +Kernel config with the specific test targets. The
>
> What does "This file contains the regular Kernel config" mean?
> Does it have all the entries from a standard .config file?

Rewrote the paragraph.

> My kunit default.config looks like this:
> CONFIG_KUNIT=y
> CONFIG_KUNIT_EXAMPLE_TEST=y
> CONFIG_KUNIT_ALL_TESTS=y
>
> I think it would be better to say something like:
> "This file contains the default configuration for KUnit, which is to run an example
> test and all unit tests"

I am not sure what you mean. This part is not talking about the
default.config. We reworded the section in the next version. If it is
not clear please elaborate.

> > +``.kunitconfig`` also contains any other test specific config options,
> > +such as test dependencies. For
> > +example: the ``FAT_FS`` tests - ``FAT_KUNIT_TEST``, depends on
> > +``FAT_FS``. ``FAT_FS`` can be enabled by selecting either ``MSDOS_FS``
> > +or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kunitconfig`` has:
> > +
> > +.. code-block:: none
> >
> > -Creating a .kunitconfig
> > ------------------------
> > -If you want to run a specific set of tests (rather than those listed in the
> > -KUnit defconfig), you can provide Kconfig options in the ``.kunitconfig`` file.
> > -This file essentially contains the regular Kernel config, with the specific
> > -test targets as well. The ``.kunitconfig`` should also contain any other config
> > -options required by the tests.
> > +     CONFIG_KUNIT=y
> > +     CONFIG_MSDOS_FS=y
> > +     CONFIG_FAT_KUNIT_TEST=y
> >
> > -A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
> > +1. A good starting point for the ``.kunitconfig``, is the KUnit default
> > +   config. Run the command:
> >
> >  .. code-block:: bash
> >
> >       cd $PATH_TO_LINUX_REPO
> >       cp tools/testing/kunit/configs/default.config .kunitconfig
> >
> > -You can then add any other Kconfig options you wish, e.g.:
> > +2. You can then add any other Kconfig options, for example:
>
> Don't you also need to also remove CONFIG_KUNIT_ALL_TESTS?

Added a note in version 2. Also removing an option for .kunitconfig
would take effect immediately without this patch:
https://lore.kernel.org/linux-kselftest/20211119232316.2246034-1-dlatypov@google.com/

> >
> >  .. code-block:: none
> >
> >       CONFIG_LIST_KUNIT_TEST=y
> >
> > -:doc:`kunit_tool <kunit-tool>` will ensure that all config options set in
> > -``.kunitconfig`` are set in the kernel ``.config`` before running the tests.
> > -It'll warn you if you haven't included the dependencies of the options you're
> > -using.
> > -
> > -.. note::
> > -   Note that removing something from the ``.kunitconfig`` will not trigger a
> > -   rebuild of the ``.config`` file: the configuration is only updated if the
> > -   ``.kunitconfig`` is not a subset of ``.config``. This means that you can use
> > -   other tools (such as make menuconfig) to adjust other config options.
> > -
> > +Before running the tests, kunit_tool ensures that all config options
> > +set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
> > +you if you have not included dependencies for the options used.
> >
> > -Running the tests (KUnit Wrapper)
> > ----------------------------------
> > +.. note ::
> > +   The configuration is only updated if the ``.kunitconfig`` is not a
> > +   subset of ``.config``. You can use tools (for example:
> > +   make menuconfig) to adjust other config options.
> >
> > -To make sure that everything is set up correctly, simply invoke the Python
> > -wrapper from your kernel repo:
> > +Running Tests (KUnit Wrapper)
> > +-----------------------------
> > +1. To make sure that everything is set up correctly, invoke the Python
> > +   wrapper from your kernel repository:
> >
> >  .. code-block:: bash
> >
> >       ./tools/testing/kunit/kunit.py run
> >
> > -.. note::
> > -   You may want to run ``make mrproper`` first.
> > -
> >  If everything worked correctly, you should see the following:
> >
> > -.. code-block:: bash
> > +.. code-block::
> >
> >       Generating .config ...
> >       Building KUnit Kernel ...
> >       Starting KUnit Kernel ...
> >
> > -followed by a list of tests that are run. All of them should be passing.
> > +The tests will pass or fail.
> >
> > -.. note::
> > -     Because it is building a lot of sources for the first time, the
> > -     ``Building KUnit kernel`` step may take a while.
> > +.. note ::
> > +   Because it is building a lot of sources for the first time, the
> > +   ``Building KUnit kernel`` may take a while.
> >
> > -Running tests without the KUnit Wrapper
> > +Running Tests without the KUnit Wrapper
> >  =======================================
> > -
> > -If you'd rather not use the KUnit Wrapper (if, for example, you need to
> > -integrate with other systems, or use an architecture other than UML), KUnit can
> > -be included in any kernel, and the results read out and parsed manually.
> > -
> > -.. note::
> > -   KUnit is not designed for use in a production system, and it's possible that
> > -   tests may reduce the stability or security of the system.
> > -
> > -
> > -
> > -Configuring the kernel
> > +If you do not want to use the KUnit Wrapper (for example: you want code
> > +under test to integrate with other systems, or use a different/
> > +unsupported architecture or configuration), KUnit can be included in
> > +any kernel, and the results are read out and parsed manually.
> > +
> > +.. note ::
> > +   ``CONFIG_KUNIT`` should not be enabled in a production environment.
> > +   Enabling KUnit disables Kernel Address-Space Layout Randomization
> > +   (KASLR), and tests may affect the state of the kernel not
>
> kernel not -> kernel in ways not

Done.

> > +   suitable for production.
> > +
> > +Configuring the Kernel
> >  ----------------------
> > +To enable KUnit itself, you need to enable the ``CONFIG_KUNIT`` Kconfig
> > +option (under Kernel Hacking/Kernel Testing and Coverage in
> > +``menuconfig``). From there, you can enable any KUnit tests. They
> > +usually have config options ending in ``_KUNIT_TEST``.
> >
> > -In order to enable KUnit itself, you simply need to enable the ``CONFIG_KUNIT``
> > -Kconfig option (it's under Kernel Hacking/Kernel Testing and Coverage in
> > -menuconfig). From there, you can enable any KUnit tests you want: they usually
> > -have config options ending in ``_KUNIT_TEST``.
> > -
> > -KUnit and KUnit tests can be compiled as modules: in this case the tests in a
> > -module will be run when the module is loaded.
> > -
> > +KUnit and KUnit tests can be compiled as modules. The tests in a module
> > +will run when the module is loaded.
> >
> > -Running the tests (w/o KUnit Wrapper)
> > +Running Tests (without KUnit Wrapper)
> >  -------------------------------------
> > +Build and run your kernel. In the kernel log, the test output is printed
> > +out in the TAP format. This will only happen by default if KUnit/tests
> > +are built-in. Otherwise the module will need to be loaded.
> >
> > -Build and run your kernel as usual. Test output will be written to the kernel
> > -log in `TAP <https://testanything.org/>`_ format.
> > +.. note ::
> > +   Some lines and/or data may get interspersed in the TAP output.
> >
> > -.. note::
> > -   It's possible that there will be other lines and/or data interspersed in the
> > -   TAP output.
> > -
> > -
> > -Writing your first test
> > +Writing Your First Test
> >  =======================
> > +In your kernel repository, let's add some code that we can test.
> >
> > -In your kernel repo let's add some code that we can test. Create a file
> > -``drivers/misc/example.h`` with the contents:
> > +1. Create a file ``drivers/misc/example.h``, which includes:
> >
> >  .. code-block:: c
> >
> >       int misc_example_add(int left, int right);
> >
> > -create a file ``drivers/misc/example.c``:
> > +2. Create a file ``drivers/misc/example.c``, which includes:
> >
> >  .. code-block:: c
> >
> > @@ -142,21 +141,22 @@ create a file ``drivers/misc/example.c``:
> >               return left + right;
> >       }
> >
> > -Now add the following lines to ``drivers/misc/Kconfig``:
> > +3. Add the following lines to ``drivers/misc/Kconfig``:
> >
> >  .. code-block:: kconfig
> >
> >       config MISC_EXAMPLE
> >               bool "My example"
> >
> > -and the following lines to ``drivers/misc/Makefile``:
> > +4. Add the following lines to ``drivers/misc/Makefile``:
> >
> >  .. code-block:: make
> >
> >       obj-$(CONFIG_MISC_EXAMPLE) += example.o
> >
> > -Now we are ready to write the test. The test will be in
> > -``drivers/misc/example-test.c``:
> > +Now we are ready to write the test cases.
> > +
> > +1. Add the below test case in ``drivers/misc/example_test.c``:
> >
> >  .. code-block:: c
> >
> > @@ -191,7 +191,7 @@ Now we are ready to write the test. The test will be in
> >       };
> >       kunit_test_suite(misc_example_test_suite);
> >
> > -Now add the following to ``drivers/misc/Kconfig``:
> > +2. Add the following lines to ``drivers/misc/Kconfig``:
> >
> >  .. code-block:: kconfig
> >
> > @@ -200,26 +200,26 @@ Now add the following to ``drivers/misc/Kconfig``:
> >               depends on MISC_EXAMPLE && KUNIT=y
> >               default KUNIT_ALL_TESTS
> >
> > -and the following to ``drivers/misc/Makefile``:
> > +3. Add the following lines to ``drivers/misc/Makefile``:
> >
> >  .. code-block:: make
> >
> > -     obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
> > +     obj-$(CONFIG_MISC_EXAMPLE_TEST) += example_test.o
> >
> > -Now add it to your ``.kunitconfig``:
> > +4. Add the following lines to ``.kunitconfig``:
> >
> >  .. code-block:: none
> >
> >       CONFIG_MISC_EXAMPLE=y
> >       CONFIG_MISC_EXAMPLE_TEST=y
> >
> > -Now you can run the test:
> > +5. Run the test:
> >
> >  .. code-block:: bash
> >
> >       ./tools/testing/kunit/kunit.py run
> >
> > -You should see the following failure:
> > +You should see the following failiure:
>
> failiure -> failure

Done.


> >
> >  .. code-block:: none
> >
> > @@ -227,16 +227,20 @@ You should see the following failure:
> >       [16:08:57] [PASSED] misc-example:misc_example_add_test_basic
> >       [16:08:57] [FAILED] misc-example:misc_example_test_failure
> >       [16:08:57] EXPECTATION FAILED at drivers/misc/example-test.c:17
> > -     [16:08:57]      This test never passes.
> > +     [16:08:57]      This test never passes.
> >       ...
> >
> > -Congrats! You just wrote your first KUnit test!
> > +Congrats! You just wrote your first KUnit test.
> >
> >  Next Steps
> >  ==========
> > -*   Check out the Documentation/dev-tools/kunit/tips.rst page for tips on
> > -    writing idiomatic KUnit tests.
> > -*   Check out the :doc:`running_tips` page for tips on
> > -    how to make running KUnit tests easier.
> > -*   Optional: see the :doc:`usage` page for a more
> > -    in-depth explanation of KUnit.
> > +
> > +*   Documentation/dev-tools/kunit/usage.rst - KUnit features.
> > +*   Documentation/dev-tools/kunit/tips.rst - best practices with
> > +    examples.
> > +*   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
> > +    used for testing.
> > +*   Documentation/dev-tools/kunit/kunit-tool.rst - kunit_tool helper
> > +    script.
> > +*   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
> > +    answers.
> > --
> > 2.34.0.384.gca35af8252-goog
>
Regards,
Harinder Singh
