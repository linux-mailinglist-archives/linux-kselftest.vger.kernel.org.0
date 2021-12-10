Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54502470E64
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Dec 2021 00:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344909AbhLJXME (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 18:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243586AbhLJXME (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 18:12:04 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00F1C0617A2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 15:08:28 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso11167059ota.5
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 15:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dat5kyZKot4IhlMKiuB4dKQqIsQxOxcE3gpS3KNZLgk=;
        b=sOrn1km2+Ttm9WOZyPMMIl/kBn17/TbnfKGx/uHYXwNH9eGTUrBSo6lbZQtrr4nKa1
         MvpPRevYhXpMZPWQ1S/PA4ZC5uPzi2dmoHzhoy8cA9DPSsbxZfYV0crQ8YpCLqd2jDKy
         D39DQanYyCjasM9aD4TilJ5xx8YvGd7akjl5uAkys33rxfMvB1h7N/aRbl2isYv0proH
         c1jnIzovZRIL2uHXqoRm1BP1BHdWlGNkaSgmesfEjtMqe254UPnRThlpxKryngX93lUX
         CGPwsh7jo35/imthbkwYTkXSDYQ3AKbhycNDLq2nviEwap49vbKFrwqTwyzGqcc50Iq8
         sTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dat5kyZKot4IhlMKiuB4dKQqIsQxOxcE3gpS3KNZLgk=;
        b=3KOcvFi5W04N7b9ExZ88MzDSJcmpTRyWTlspeoztdmI25atD5ROZk25LjIZUHJAjxj
         J88jbQkg/X0ZKQhC8XN7qETVrSfs+1Kj0mOHFRzuTSsHMHjEDOBxS79MVUXjPi9b+5lZ
         bVjp1M1xbD+wm/nRAlNUPj2ZNt7ZHZfzbO8Glbu/mXoP/hAx4c/g/0QM6HYmToJfrv9g
         ZT02e7giJX1719FMLMGapjvdX9DLfImo8Z/1zizx8bufF7EGD6GNmosWxXNf2fvyz1j5
         Y+Dhys03dGXZhb63Ujfop19yDgWRockUDZgfQ9DT8dzlOHebf2mkN4FN01xctdUmpkpu
         hj/A==
X-Gm-Message-State: AOAM530rWiFQiHB+2FIO4b704890iiZbyfmrubFTghckSIJj1cAFFvOX
        kyQIXcDohukQp0xP0k2eAv4PoLrUFcno6kHEAhJolw==
X-Google-Smtp-Source: ABdhPJy1fOr05bX3PtKi9zjSdRhoxOoeVhC6R6UsQU4dVXwK30j5fpXdbkIesfZoLKccjogt4lfyFXyl2Rx4BeUeEas=
X-Received: by 2002:a9d:2ae1:: with SMTP id e88mr13060622otb.157.1639177707630;
 Fri, 10 Dec 2021 15:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20211207054019.1455054-1-sharinder@google.com> <20211207054019.1455054-4-sharinder@google.com>
In-Reply-To: <20211207054019.1455054-4-sharinder@google.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 11 Dec 2021 00:08:16 +0100
Message-ID: <CANpmjNORiy0Zq7T=C-izJSZjwhisATDQiv1+fBs1iEnHcx0WQw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] Documentation: KUnit: Added KUnit Architecture
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

On Tue, 7 Dec 2021 at 06:41, 'Harinder Singh' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Describe the components of KUnit and how the kernel mode parts
> interact with kunit_tool.
>
> Signed-off-by: Harinder Singh <sharinder@google.com>
> ---

You are including several external links to kernel sources via
elixir.bootlin.com. This should be avoided, where kernel.org
alternatives exist.

See one of my comments below which gives an example how you can avoid
this, either by providing a kernel.org link, or better, rendering the
kernel-doc in ReST where appropriate. You should be able to test this
with "make htmldocs".

>  .../dev-tools/kunit/architecture.rst          | 206 ++++++++++++++++++
>  Documentation/dev-tools/kunit/index.rst       |   2 +
>  .../kunit/kunit_suitememorydiagram.png        | Bin 0 -> 24174 bytes
>  Documentation/dev-tools/kunit/start.rst       |   1 +
>  4 files changed, 209 insertions(+)
>  create mode 100644 Documentation/dev-tools/kunit/architecture.rst
>  create mode 100644 Documentation/dev-tools/kunit/kunit_suitememorydiagra=
m.png
>
> diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentati=
on/dev-tools/kunit/architecture.rst
> new file mode 100644
> index 000000000000..bb0fb3e3ed01
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/architecture.rst
> @@ -0,0 +1,206 @@
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
> +https://elixir.bootlin.com/linux/latest/source/include/kunit/test.h#L145
> +
> +It includes:
> +
> +- ``run_case``: the function implementing the actual test case.
> +- ``name``: the test case name.
> +- ``generate_params``: the parameterized tests generator function. This
> +  is optional for non-parameterized tests.
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
> +https://elixir.bootlin.com/linux/v5.12/source/include/asm-generic/vmlinu=
x.lds.h#L918.
> +The linker section consists of an array of pointers to
> +``struct kunit_suite``, and is populated by the ``kunit_test_suites()``
> +macro. To run all tests compiled into the kernel, the KUnit executor
> +iterates over the linker section array.
> +
> +.. kernel-figure:: kunit_suitememorydiagram.png
> +       :alt:   KUnit Suite Memory
> +
> +       KUnit Suite Memory Diagram
> +
> +On the kernel boot, the KUnit executor uses the start and end addresses
> +of this section to iterate over and run all tests. For code, see:
> +https://elixir.bootlin.com/linux/latest/source/lib/kunit/executor.c
> +
> +When built as a module, the ``kunit_test_suites()`` macro defines a
> +``module_init()`` function, which runs all the tests in the compilation
> +unit instead of utilizing the executor.
> +
> +In KUnit tests, some error classes do not affect other tests
> +or parts of the kernel, each KUnit case executes in a separate thread
> +context. For code, see:
> +https://elixir.bootlin.com/linux/latest/source/lib/kunit/try-catch.c#L58
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
> +The generator function returns the next parameter given to the
> +previous parameter in parameterized tests. It also provides a macro to
> +generate common-case generators based on arrays.
> +
> +For code, see:
> +https://elixir.bootlin.com/linux/v5.12/source/include/kunit/test.h#L1783

This is a link to an external mirror of the kernel, which should not
be used. If you must point to a specific version and line of the
kernel, use a kernel.org link:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/kunit/test.h?h=3Dv5.15#n1872

and ideally using a ReST link.

Furthermore, ReST actually lets you select to inline certain
documentation, which would be appropriate in this case. This can be
done via the ".. kernel-doc: <file>" directive, and you can select
which identifier you want to render in the final document. See
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#including-=
kernel-doc-comments

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
> index ebf4bffaa1ca..75e4ae85adbb 100644
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
> diff --git a/Documentation/dev-tools/kunit/kunit_suitememorydiagram.png b=
/Documentation/dev-tools/kunit/kunit_suitememorydiagram.png
> new file mode 100644
> index 0000000000000000000000000000000000000000..a1aa7c3b0f63edfea83eb1cef=
3e2257b47b5ca7b
> GIT binary patch

I think adding binary blobs like this is quite unusual.

There currently are no .png files in the kernel repo, and this would
be the first.

How difficult is it to create an ascii diagram?

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
> 2.34.1.400.ga245620fadb-goog
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20211207054019.1455054-4-sharinder%40google.com.
