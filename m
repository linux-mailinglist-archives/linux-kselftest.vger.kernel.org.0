Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E2147893B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 11:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhLQKuQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 05:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbhLQKuQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 05:50:16 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB26C06173F
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 02:50:15 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so2347269otu.10
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 02:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ChAQgQ67R/IfTiZcoWSnAH60LCShrosGvHLHIofQtOY=;
        b=lKx/LadyuNCtf5NKPeaK3K7P5iBR/KAPy+3eeZjSalLRBIwj80hClAAY6lLEWAhved
         0JjsHBi/tS9IeSMq+DTKYahwJrauEh28Q/C5K1lsTBPBuXKFTG6qzNbtxdEXZtyaQpbT
         8TOyQS/wozWpqfdKz7O2JExRaFoWuUu34Kndj9fV3X5VSC0Bo3BXVPLGc4ZcTKMS+XtZ
         1H7s+Iu4bW2L72eQxsVarLcPfbdlKARqrOdQ4qNGJcUiIVug0J2A5BG6XqUAeOKgl2Y3
         7Y7lynvjjqM5Bfbyl6nS49utzOF8gPS/gItmtO7srHNhdmYLuoAQIqIqZCrROaIfPFsx
         4SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ChAQgQ67R/IfTiZcoWSnAH60LCShrosGvHLHIofQtOY=;
        b=1Q6WnFXZFUbC0XfHlbvBAP0HiF/Yl5XhEeLbaKr3AgaFDMgPzgfLQTTcUfFNlmdYwe
         tuC/mOn6FM4Fo8Ej7nHepuwZ2ezWeBEY3TP+eZCl57yyk7pa/yVYSV0f/lcMxiSt9Buv
         vhnGXM+lAVd+mp/wtnr0THpF/4U4g4DKY6W5u35t1McpeRS1cWwDmqDRHdWSHT91uq/D
         Fwq4rmm6KiygqNtLL5msIOK0FKWx7MSSKSyDDt96ofiW8U1miq1EDnvc259LC0EfFRg7
         mx2M+QgYuOVsVn95CpfjNUQLQMkL2UZMSHmYlJ5wni5LPyowh9m5HXsU/dPjI77kkylu
         mnwg==
X-Gm-Message-State: AOAM532oZOuvPgX5me+9+OuiY5fg4yU5m646RvtVcvTyVVDC6KUT7nof
        A+O7qDDFSbY7D1sy28PxFQbXgtSD6NTA8ShK4uUQdA==
X-Google-Smtp-Source: ABdhPJwRnAonVZjGqTFN2dX7KGtpy2hYHKmh7cmpGhv6LaIh4vcm44N2JaaCFdzONE8hQi/51peHk29GxHVDQms7x1w=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr1674722otl.329.1639738214883;
 Fri, 17 Dec 2021 02:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20211217044911.798817-1-sharinder@google.com> <20211217044911.798817-4-sharinder@google.com>
In-Reply-To: <20211217044911.798817-4-sharinder@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 17 Dec 2021 11:50:03 +0100
Message-ID: <CANpmjNMz7nh7Eo97p-ikdE6cyTu_Vge_RJktj68BpC9QHqE7iw@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] Documentation: KUnit: Added KUnit Architecture
To:     Harinder Singh <sharinder@google.com>
Cc:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tim.Bird@sony.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 17 Dec 2021 at 05:49, Harinder Singh <sharinder@google.com> wrote:
>
> Describe the components of KUnit and how the kernel mode parts
> interact with kunit_tool.
>
> Signed-off-by: Harinder Singh <sharinder@google.com>

Acked-by: Marco Elver <elver@google.com>

For the .svg file, I think per
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign=
-your-work-the-developer-s-certificate-of-origin
at least my Signed-off-by is required, but probably also my
Co-developed-by? In any case my SOB for kunit_suitememorydiagram.svg
is hereby given:

Signed-off-by: Marco Elver <elver@google.com>

Thanks,
-- Marco

> ---
>  .../dev-tools/kunit/architecture.rst          | 204 ++++++++++++++++++
>  Documentation/dev-tools/kunit/index.rst       |   2 +
>  .../kunit/kunit_suitememorydiagram.svg        |  81 +++++++
>  Documentation/dev-tools/kunit/start.rst       |   1 +
>  4 files changed, 288 insertions(+)
>  create mode 100644 Documentation/dev-tools/kunit/architecture.rst
>  create mode 100644 Documentation/dev-tools/kunit/kunit_suitememorydiagra=
m.svg
>
> diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentati=
on/dev-tools/kunit/architecture.rst
> new file mode 100644
> index 000000000000..aa2cea821e25
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/architecture.rst
> @@ -0,0 +1,204 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +KUnit Architecture
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The KUnit architecture can be divided into two parts:
> +
> +- Kernel testing library
> +- kunit_tool (Command line test harness)
> +
> +In-Kernel Testing Framework
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +The kernel testing library supports KUnit tests written in C using
> +KUnit. KUnit tests are kernel code. KUnit does several things:
> +
> +- Organizes tests
> +- Reports test results
> +- Provides test utilities
> +
> +Test Cases
> +----------
> +
> +The fundamental unit in KUnit is the test case. The KUnit test cases are
> +grouped into KUnit suites. A KUnit test case is a function with type
> +signature ``void (*)(struct kunit *test)``.
> +These test case functions are wrapped in a struct called
> +``struct kunit_case``. For code, see:
> +
> +.. kernel-doc:: include/kunit/test.h
> +       :identifiers: kunit_case
> +
> +.. note:
> +       ``generate_params`` is optional for non-parameterized tests.
> +
> +Each KUnit test case gets a ``struct kunit`` context
> +object passed to it that tracks a running test. The KUnit assertion
> +macros and other KUnit utilities use the ``struct kunit`` context
> +object. As an exception, there are two fields:
> +
> +- ``->priv``: The setup functions can use it to store arbitrary test
> +  user data.
> +
> +- ``->param_value``: It contains the parameter value which can be
> +  retrieved in the parameterized tests.
> +
> +Test Suites
> +-----------
> +
> +A KUnit suite includes a collection of test cases. The KUnit suites
> +are represented by the ``struct kunit_suite``. For example:
> +
> +.. code-block:: c
> +
> +       static struct kunit_case example_test_cases[] =3D {
> +               KUNIT_CASE(example_test_foo),
> +               KUNIT_CASE(example_test_bar),
> +               KUNIT_CASE(example_test_baz),
> +               {}
> +       };
> +
> +       static struct kunit_suite example_test_suite =3D {
> +               .name =3D "example",
> +               .init =3D example_test_init,
> +               .exit =3D example_test_exit,
> +               .test_cases =3D example_test_cases,
> +       };
> +       kunit_test_suite(example_test_suite);
> +
> +In the above example, the test suite ``example_test_suite``, runs the
> +test cases ``example_test_foo``, ``example_test_bar``, and
> +``example_test_baz``. Before running the test, the ``example_test_init``
> +is called and after running the test, ``example_test_exit`` is called.
> +The ``kunit_test_suite(example_test_suite)`` registers the test suite
> +with the KUnit test framework.
> +
> +Executor
> +--------
> +
> +The KUnit executor can list and run built-in KUnit tests on boot.
> +The Test suites are stored in a linker section
> +called ``.kunit_test_suites``. For code, see:
> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
include/asm-generic/vmlinux.lds.h?h=3Dv5.15#n945.
> +The linker section consists of an array of pointers to
> +``struct kunit_suite``, and is populated by the ``kunit_test_suites()``
> +macro. To run all tests compiled into the kernel, the KUnit executor
> +iterates over the linker section array.
> +
> +.. kernel-figure:: kunit_suitememorydiagram.svg
> +       :alt:   KUnit Suite Memory
> +
> +       KUnit Suite Memory Diagram
> +
> +On the kernel boot, the KUnit executor uses the start and end addresses
> +of this section to iterate over and run all tests. For code, see:
> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
lib/kunit/executor.c
> +
> +When built as a module, the ``kunit_test_suites()`` macro defines a
> +``module_init()`` function, which runs all the tests in the compilation
> +unit instead of utilizing the executor.
> +
> +In KUnit tests, some error classes do not affect other tests
> +or parts of the kernel, each KUnit case executes in a separate thread
> +context. For code, see:
> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
lib/kunit/try-catch.c?h=3Dv5.15#n58
> +
> +Assertion Macros
> +----------------
> +
> +KUnit tests verify state using expectations/assertions.
> +All expectations/assertions are formatted as:
> +``KUNIT_{EXPECT|ASSERT}_<op>[_MSG](kunit, property[, message])``
> +
> +- ``{EXPECT|ASSERT}`` determines whether the check is an assertion or an
> +  expectation.
> +
> +       - For an expectation, if the check fails, marks the test as faile=
d
> +         and logs the failure.
> +
> +       - An assertion, on failure, causes the test case to terminate
> +         immediately.
> +
> +               - Assertions call function:
> +                 ``void __noreturn kunit_abort(struct kunit *)``.
> +
> +               - ``kunit_abort`` calls function:
> +                 ``void __noreturn kunit_try_catch_throw(struct kunit_tr=
y_catch *try_catch)``.
> +
> +               - ``kunit_try_catch_throw`` calls function:
> +                 ``void complete_and_exit(struct completion *, long) __n=
oreturn;``
> +                 and terminates the special thread context.
> +
> +- ``<op>`` denotes a check with options: ``TRUE`` (supplied property
> +  has the boolean value =E2=80=9Ctrue=E2=80=9D), ``EQ`` (two supplied pr=
operties are
> +  equal), ``NOT_ERR_OR_NULL`` (supplied pointer is not null and does not
> +  contain an =E2=80=9Cerr=E2=80=9D value).
> +
> +- ``[_MSG]`` prints a custom message on failure.
> +
> +Test Result Reporting
> +---------------------
> +KUnit prints test results in KTAP format. KTAP is based on TAP14, see:
> +https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-=
14-specification.md.
> +KTAP (yet to be standardized format) works with KUnit and Kselftest.
> +The KUnit executor prints KTAP results to dmesg, and debugfs
> +(if configured).
> +
> +Parameterized Tests
> +-------------------
> +
> +Each KUnit parameterized test is associated with a collection of
> +parameters. The test is invoked multiple times, once for each parameter
> +value and the parameter is stored in the ``param_value`` field.
> +The test case includes a ``KUNIT_CASE_PARAM()`` macro that accepts a
> +generator function.
> +The generator function is passed the previous parameter and returns the =
next
> +parameter. It also provides a macro to generate common-case generators b=
ased on
> +arrays.
> +
> +For code, see:
> +
> +.. kernel-doc:: include/kunit/test.h
> +       :identifiers: KUNIT_ARRAY_PARAM
> +
> +
> +kunit_tool (Command Line Test Harness)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +kunit_tool is a Python script ``(tools/testing/kunit/kunit.py)``
> +that can be used to configure, build, exec, parse and run (runs other
> +commands in order) test results. You can either run KUnit tests using
> +kunit_tool or can include KUnit in kernel and parse manually.
> +
> +- ``configure`` command generates the kernel ``.config`` from a
> +  ``.kunitconfig`` file (and any architecture-specific options).
> +  For some architectures, additional config options are specified in the
> +  ``qemu_config`` Python script
> +  (For example: ``tools/testing/kunit/qemu_configs/powerpc.py``).
> +  It parses both the existing ``.config`` and the ``.kunitconfig`` files
> +  and ensures that ``.config`` is a superset of ``.kunitconfig``.
> +  If this is not the case, it will combine the two and run
> +  ``make olddefconfig`` to regenerate the ``.config`` file. It then
> +  verifies that ``.config`` is now a superset. This checks if all
> +  Kconfig dependencies are correctly specified in ``.kunitconfig``.
> +  ``kunit_config.py`` includes the parsing Kconfigs code. The code which
> +  runs ``make olddefconfig`` is a part of ``kunit_kernel.py``. You can
> +  invoke this command via: ``./tools/testing/kunit/kunit.py config`` and
> +  generate a ``.config`` file.
> +- ``build`` runs ``make`` on the kernel tree with required options
> +  (depends on the architecture and some options, for example: build_dir)
> +  and reports any errors.
> +  To build a KUnit kernel from the current ``.config``, you can use the
> +  ``build`` argument: ``./tools/testing/kunit/kunit.py build``.
> +- ``exec`` command executes kernel results either directly (using
> +  User-mode Linux configuration), or via an emulator such
> +  as QEMU. It reads results from the log via standard
> +  output (stdout), and passes them to ``parse`` to be parsed.
> +  If you already have built a kernel with built-in KUnit tests,
> +  you can run the kernel and display the test results with the ``exec``
> +  argument: ``./tools/testing/kunit/kunit.py exec``.
> +- ``parse`` extracts the KTAP output from a kernel log, parses
> +  the test results, and prints a summary. For failed tests, any
> +  diagnostic output will be included.
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-=
tools/kunit/index.rst
> index 55d2444b0745..50d3ef9359dd 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -9,6 +9,7 @@ KUnit - Linux Kernel Unit Testing
>         :caption: Contents:
>
>         start
> +       architecture
>         usage
>         kunit-tool
>         api/index
> @@ -96,6 +97,7 @@ How do I use it?
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  *   Documentation/dev-tools/kunit/start.rst - for KUnit new users.
> +*   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
>  *   Documentation/dev-tools/kunit/usage.rst - KUnit features.
>  *   Documentation/dev-tools/kunit/tips.rst - best practices with
>      examples.
> diff --git a/Documentation/dev-tools/kunit/kunit_suitememorydiagram.svg b=
/Documentation/dev-tools/kunit/kunit_suitememorydiagram.svg
> new file mode 100644
> index 000000000000..cf8fddc27500
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/kunit_suitememorydiagram.svg
> @@ -0,0 +1,81 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8"?>
> +<svg width=3D"796.93" height=3D"555.73" version=3D"1.1" viewBox=3D"0 0 7=
96.93 555.73" xmlns=3D"http://www.w3.org/2000/svg">
> +       <g transform=3D"translate(-13.724 -17.943)">
> +               <g fill=3D"#dad4d4" fill-opacity=3D".91765" stroke=3D"#1a=
1a1a">
> +                       <rect x=3D"323.56" y=3D"18.443" width=3D"115.75" =
height=3D"41.331"/>
> +                       <rect x=3D"323.56" y=3D"463.09" width=3D"115.75" =
height=3D"41.331"/>
> +                       <rect x=3D"323.56" y=3D"531.84" width=3D"115.75" =
height=3D"41.331"/>
> +                       <rect x=3D"323.56" y=3D"88.931" width=3D"115.75" =
height=3D"74.231"/>
> +               </g>
> +               <g>
> +                       <rect x=3D"323.56" y=3D"421.76" width=3D"115.75" =
height=3D"41.331" fill=3D"#b9dbc6" stroke=3D"#1a1a1a"/>
> +                       <text x=3D"328.00888" y=3D"446.61826" fill=3D"#00=
0000" font-family=3D"sans-serif" font-size=3D"16px" style=3D"line-height:1.=
25" xml:space=3D"preserve"><tspan x=3D"328.00888" y=3D"446.61826" font-fami=
ly=3D"monospace" font-size=3D"16px">kunit_suite</tspan></text>
> +               </g>
> +               <g transform=3D"translate(0 -258.6)">
> +                       <rect x=3D"323.56" y=3D"421.76" width=3D"115.75" =
height=3D"41.331" fill=3D"#b9dbc6" stroke=3D"#1a1a1a"/>
> +                       <text x=3D"328.00888" y=3D"446.61826" fill=3D"#00=
0000" font-family=3D"sans-serif" font-size=3D"16px" style=3D"line-height:1.=
25" xml:space=3D"preserve"><tspan x=3D"328.00888" y=3D"446.61826" font-fami=
ly=3D"monospace" font-size=3D"16px">kunit_suite</tspan></text>
> +               </g>
> +               <g transform=3D"translate(0 -217.27)">
> +                       <rect x=3D"323.56" y=3D"421.76" width=3D"115.75" =
height=3D"41.331" fill=3D"#b9dbc6" stroke=3D"#1a1a1a"/>
> +                       <text x=3D"328.00888" y=3D"446.61826" fill=3D"#00=
0000" font-family=3D"sans-serif" font-size=3D"16px" style=3D"line-height:1.=
25" xml:space=3D"preserve"><tspan x=3D"328.00888" y=3D"446.61826" font-fami=
ly=3D"monospace" font-size=3D"16px">kunit_suite</tspan></text>
> +               </g>
> +               <g transform=3D"translate(0 -175.94)">
> +                       <rect x=3D"323.56" y=3D"421.76" width=3D"115.75" =
height=3D"41.331" fill=3D"#b9dbc6" stroke=3D"#1a1a1a"/>
> +                       <text x=3D"328.00888" y=3D"446.61826" fill=3D"#00=
0000" font-family=3D"sans-serif" font-size=3D"16px" style=3D"line-height:1.=
25" xml:space=3D"preserve"><tspan x=3D"328.00888" y=3D"446.61826" font-fami=
ly=3D"monospace" font-size=3D"16px">kunit_suite</tspan></text>
> +               </g>
> +               <g transform=3D"translate(0 -134.61)">
> +                       <rect x=3D"323.56" y=3D"421.76" width=3D"115.75" =
height=3D"41.331" fill=3D"#b9dbc6" stroke=3D"#1a1a1a"/>
> +                       <text x=3D"328.00888" y=3D"446.61826" fill=3D"#00=
0000" font-family=3D"sans-serif" font-size=3D"16px" style=3D"line-height:1.=
25" xml:space=3D"preserve"><tspan x=3D"328.00888" y=3D"446.61826" font-fami=
ly=3D"monospace" font-size=3D"16px">kunit_suite</tspan></text>
> +               </g>
> +               <g transform=3D"translate(0 -41.331)">
> +                       <rect x=3D"323.56" y=3D"421.76" width=3D"115.75" =
height=3D"41.331" fill=3D"#b9dbc6" stroke=3D"#1a1a1a"/>
> +                       <text x=3D"328.00888" y=3D"446.61826" fill=3D"#00=
0000" font-family=3D"sans-serif" font-size=3D"16px" style=3D"line-height:1.=
25" xml:space=3D"preserve"><tspan x=3D"328.00888" y=3D"446.61826" font-fami=
ly=3D"monospace" font-size=3D"16px">kunit_suite</tspan></text>
> +               </g>
> +               <g transform=3D"translate(3.4459e-5 -.71088)">
> +                       <rect x=3D"502.19" y=3D"143.16" width=3D"201.13" =
height=3D"41.331" fill=3D"#dad4d4" fill-opacity=3D".91765" stroke=3D"#1a1a1=
a"/>
> +                       <text x=3D"512.02319" y=3D"168.02026" font-family=
=3D"sans-serif" font-size=3D"16px" style=3D"line-height:1.25" xml:space=3D"=
preserve"><tspan x=3D"512.02319" y=3D"168.02026" font-family=3D"monospace">=
_kunit_suites_start</tspan></text>
> +               </g>
> +               <g transform=3D"translate(3.0518e-5 -3.1753)">
> +                       <rect x=3D"502.19" y=3D"445.69" width=3D"201.13" =
height=3D"41.331" fill=3D"#dad4d4" fill-opacity=3D".91765" stroke=3D"#1a1a1=
a"/>
> +                       <text x=3D"521.61694" y=3D"470.54846" font-family=
=3D"sans-serif" font-size=3D"16px" style=3D"line-height:1.25" xml:space=3D"=
preserve"><tspan x=3D"521.61694" y=3D"470.54846" font-family=3D"monospace">=
_kunit_suites_end</tspan></text>
> +               </g>
> +               <rect x=3D"14.224" y=3D"277.78" width=3D"134.47" height=
=3D"41.331" fill=3D"#dad4d4" fill-opacity=3D".91765" stroke=3D"#1a1a1a"/>
> +               <text x=3D"32.062176" y=3D"304.41287" font-family=3D"sans=
-serif" font-size=3D"16px" style=3D"line-height:1.25" xml:space=3D"preserve=
"><tspan x=3D"32.062176" y=3D"304.41287" font-family=3D"monospace">.init.da=
ta</tspan></text>
> +               <g transform=3D"translate(217.98 145.12)" stroke=3D"#1a1a=
1a">
> +                       <circle cx=3D"149.97" cy=3D"373.01" r=3D"3.4012"/=
>
> +                       <circle cx=3D"163.46" cy=3D"373.01" r=3D"3.4012"/=
>
> +                       <circle cx=3D"176.95" cy=3D"373.01" r=3D"3.4012"/=
>
> +               </g>
> +               <g transform=3D"translate(217.98 -298.66)" stroke=3D"#1a1=
a1a">
> +                       <circle cx=3D"149.97" cy=3D"373.01" r=3D"3.4012"/=
>
> +                       <circle cx=3D"163.46" cy=3D"373.01" r=3D"3.4012"/=
>
> +                       <circle cx=3D"176.95" cy=3D"373.01" r=3D"3.4012"/=
>
> +               </g>
> +               <g stroke=3D"#1a1a1a">
> +                       <rect x=3D"323.56" y=3D"328.49" width=3D"115.75" =
height=3D"51.549" fill=3D"#b9dbc6"/>
> +                       <g transform=3D"translate(217.98 -18.75)">
> +                               <circle cx=3D"149.97" cy=3D"373.01" r=3D"=
3.4012"/>
> +                               <circle cx=3D"163.46" cy=3D"373.01" r=3D"=
3.4012"/>
> +                               <circle cx=3D"176.95" cy=3D"373.01" r=3D"=
3.4012"/>
> +                       </g>
> +               </g>
> +               <g transform=3D"scale(1.0933 .9147)" stroke-width=3D"32.9=
37" aria-label=3D"{">
> +                       <path d=3D"m275.49 545.57c-35.836-8.432-47.43-24.=
769-47.957-64.821v-88.536c-0.527-44.795-10.54-57.97-49.538-67.456 38.998-10=
.013 49.011-23.715 49.538-67.983v-88.536c0.527-40.052 12.121-56.389 47.957-=
64.821v-5.797c-65.348 0-85.901 17.391-86.955 73.253v93.806c-0.527 36.89-10.=
013 50.065-44.795 59.551 34.782 10.013 44.268 23.188 44.795 60.078v93.279c1=
.581 56.389 21.607 73.78 86.955 73.78z"/>
> +               </g>
> +               <g transform=3D"scale(1.1071 .90325)" stroke-width=3D"14.=
44" aria-label=3D"{">
> +                       <path d=3D"m461.46 443.55c-15.711-3.6967-20.794-1=
0.859-21.025-28.418v-38.815c-0.23104-19.639-4.6209-25.415-21.718-29.574 17.=
097-4.3898 21.487-10.397 21.718-29.805v-38.815c0.23105-17.559 5.314-24.722 =
21.025-28.418v-2.5415c-28.649 0-37.66 7.6244-38.122 32.115v41.126c-0.23105 =
16.173-4.3898 21.949-19.639 26.108 15.249 4.3898 19.408 10.166 19.639 26.33=
9v40.895c0.69313 24.722 9.4728 32.346 38.122 32.346z"/>
> +               </g>
> +               <path d=3D"m449.55 161.84v2.5h49.504v-2.5z" color=3D"#000=
000" style=3D"-inkscape-stroke:none"/>
> +               <g fill-rule=3D"evenodd">
> +                       <path d=3D"m443.78 163.09 8.65-5v10z" color=3D"#0=
00000" stroke-width=3D"1pt" style=3D"-inkscape-stroke:none"/>
> +                       <path d=3D"m453.1 156.94-10.648 6.1543 0.99804 0.=
57812 9.6504 5.5781zm-1.334 2.3125v7.6856l-6.6504-3.8438z" color=3D"#000000=
" style=3D"-inkscape-stroke:none"/>
> +               </g>
> +               <path d=3D"m449.55 461.91v2.5h49.504v-2.5z" color=3D"#000=
000" style=3D"-inkscape-stroke:none"/>
> +               <g fill-rule=3D"evenodd">
> +                       <path d=3D"m443.78 463.16 8.65-5v10z" color=3D"#0=
00000" stroke-width=3D"1pt" style=3D"-inkscape-stroke:none"/>
> +                       <path d=3D"m453.1 457-10.648 6.1562 0.99804 0.576=
17 9.6504 5.5781zm-1.334 2.3125v7.6856l-6.6504-3.8438z" color=3D"#000000" s=
tyle=3D"-inkscape-stroke:none"/>
> +               </g>
> +               <rect x=3D"515.64" y=3D"223.9" width=3D"294.52" height=3D=
"178.49" fill=3D"#dad4d4" fill-opacity=3D".91765" stroke=3D"#1a1a1a"/>
> +               <text x=3D"523.33319" y=3D"262.52542" font-family=3D"mono=
space" font-size=3D"14.667px" style=3D"line-height:1.25" xml:space=3D"prese=
rve"><tspan x=3D"523.33319" y=3D"262.52542"><tspan fill=3D"#008000" font-fa=
mily=3D"monospace" font-size=3D"14.667px" font-weight=3D"bold">struct</tspa=
n> kunit_suite {</tspan><tspan x=3D"523.33319" y=3D"280.8588"><tspan fill=
=3D"#008000" font-family=3D"monospace" font-size=3D"14.667px" font-weight=
=3D"bold">  const char</tspan> name[<tspan fill=3D"#ff00ff" font-size=3D"14=
.667px">256</tspan>];</tspan><tspan x=3D"523.33319" y=3D"299.19217">  <tspa=
n fill=3D"#008000" font-family=3D"monospace" font-size=3D"14.667px" font-we=
ight=3D"bold">int</tspan> (*init)(<tspan fill=3D"#008000" font-family=3D"mo=
nospace" font-size=3D"14.667px" font-weight=3D"bold">struct</tspan> kunit *=
);</tspan><tspan x=3D"523.33319" y=3D"317.52554">  <tspan fill=3D"#008000" =
font-family=3D"monospace" font-size=3D"14.667px" font-weight=3D"bold">void<=
/tspan> (*exit)(<tspan fill=3D"#008000" font-family=3D"monospace" font-size=
=3D"14.667px" font-weight=3D"bold">struct</tspan> kunit *);</tspan><tspan x=
=3D"523.33319" y=3D"335.85892">  <tspan fill=3D"#008000" font-family=3D"mon=
ospace" font-size=3D"14.667px" font-weight=3D"bold">struct</tspan> kunit_ca=
se *test_cases;</tspan><tspan x=3D"523.33319" y=3D"354.19229">  ...</tspan>=
<tspan x=3D"523.33319" y=3D"372.52567">};</tspan></text>
> +       </g>
> +</svg>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-=
tools/kunit/start.rst
> index 55f8df1abd40..5dd2c88fa2bd 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -240,6 +240,7 @@ Congrats! You just wrote your first KUnit test.
>  Next Steps
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> +*   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
>  *   Documentation/dev-tools/kunit/usage.rst - KUnit features.
>  *   Documentation/dev-tools/kunit/tips.rst - best practices with
>      examples.
> --
> 2.34.1.173.g76aa8bc2d0-goog
>
