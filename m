Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A0546FA74
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 06:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhLJFfE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 00:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbhLJFfE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 00:35:04 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DD8C0617A1
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 21:31:29 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id i6so14870762uae.6
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Dec 2021 21:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xpJdKJy0M6hLcNFoEH5Ayyap4q3VzL88+z05qgZFvMg=;
        b=VvYNcHPIlSY6yu1V3U/LjpskGtgyvRn/c1YmEuzZTOSOHaF49DAxg0+uV7rjy0RIOy
         vguDZd1N8K24mXkokHSvTEp8q8rP6U0zV1XrWyTOhA/ZQ3YdJZxUu++jqytXs0KQypyJ
         5SwSojcbTLVc19+ZIB8qZSShInA7vxUnMQFCL93R7h38DlUYn1AIeLMFm9SAe2mNaWsk
         EPOSZ6xXZNp95UiJ3ivcBiZEf2ChK54aEZtknbAWjbImhlOheslLhK6WfheGbjeLPUfC
         5M3xkb+musbeoUGj4R3QIPxCV1St6PuOMHpiQlW82sk67TMYg5emS4y0M1wW55JTFdM8
         iWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xpJdKJy0M6hLcNFoEH5Ayyap4q3VzL88+z05qgZFvMg=;
        b=vtW2GE6pKBvBxhCCKvmaYhtJ+Zfl8DEIGoo4g9oDdygq9uwSGty2/T7EOB/lFye+19
         tIAKhHRYhg/0x3uty6o4R++WgOeRoZLYhuNJ9IxmT/oxF78muNM56iRPAxOYADf2T1e/
         pQAjjaB/fxUERKMf8x7BWhECGTsYpNPVSL70lkLt7rXrcrJ+PpLK2sX/qbwXtQYhxXSk
         La5Ot1wkwQYUWkD4pf4vW/zsYpZRF1YRYKzhcM9ezG2eEK4F7JyK3qnvqDgJ4/gsekYv
         LZbzmza6390PRTlFK5z+hOBFDgY27DW/cSdOQnSm27g2CEIUYoj7dee3mi9iKSAkqGvT
         ZJLg==
X-Gm-Message-State: AOAM532lYxSTmRL+XJHxKiBq/YiOR/ZnQhgOLx0TWGZhYXt6+MqKEpWp
        DoakDJt1fdhTkBfNRgL6MLlBwScqx+yveeAz9nqEMg==
X-Google-Smtp-Source: ABdhPJxOGpGuk+y33tEpLvFGU7fkwHLwxH08J/Bt3EjAeWTOMF88g+Il/pi5N3TuB6oKmp5c1Mhiyu9Flspl/FZsXCY=
X-Received: by 2002:ab0:6f47:: with SMTP id r7mr26118086uat.85.1639114288848;
 Thu, 09 Dec 2021 21:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20211207054019.1455054-1-sharinder@google.com>
 <20211207054019.1455054-4-sharinder@google.com> <BYAPR13MB2503D5A5E52D5645C5CA3C3AFD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB2503D5A5E52D5645C5CA3C3AFD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   Harinder Singh <sharinder@google.com>
Date:   Fri, 10 Dec 2021 11:01:17 +0530
Message-ID: <CAHLZCaHMpNz97wQa8aOKQ7qORKe3Bt=dVzmf8ykkPE2DVhXOXA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] Documentation: KUnit: Added KUnit Architecture
To:     tim.bird@sony.com
Cc:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Tim,

Thanks for your review.

See my comments below.

On Tue, Dec 7, 2021 at 10:54 PM <Tim.Bird@sony.com> wrote:
>
> > -----Original Message-----
> > From: Harinder Singh <sharinder@google.com>
> >
> > Describe the components of KUnit and how the kernel mode parts
> > interact with kunit_tool.
> >
> > Signed-off-by: Harinder Singh <sharinder@google.com>
> > ---
> >  .../dev-tools/kunit/architecture.rst          | 206 ++++++++++++++++++
> >  Documentation/dev-tools/kunit/index.rst       |   2 +
> >  .../kunit/kunit_suitememorydiagram.png        | Bin 0 -> 24174 bytes
> >  Documentation/dev-tools/kunit/start.rst       |   1 +
> >  4 files changed, 209 insertions(+)
> >  create mode 100644 Documentation/dev-tools/kunit/architecture.rst
> >  create mode 100644 Documentation/dev-tools/kunit/kunit_suitememorydiag=
ram.png
> >
> > diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documenta=
tion/dev-tools/kunit/architecture.rst
> > new file mode 100644
> > index 000000000000..bb0fb3e3ed01
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/architecture.rst
> > @@ -0,0 +1,206 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +KUnit Architecture
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The KUnit architecture can be divided into two parts:
> > +
> > +- Kernel testing library
> > +- kunit_tool (Command line test harness)
> > +
> > +In-Kernel Testing Framework
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +
> > +The kernel testing library supports KUnit tests written in C using
> > +KUnit. KUnit tests are kernel code. KUnit does several things:
> > +
> > +- Organizes tests
> > +- Reports test results
> > +- Provides test utilities
> > +
> > +Test Cases
> > +----------
> > +
> > +The fundamental unit in KUnit is the test case. The KUnit test cases a=
re
> > +grouped into KUnit suites. A KUnit test case is a function with type
> > +signature ``void (*)(struct kunit *test)``.
> > +These test case functions are wrapped in a struct called
> > +``struct kunit_case``. For code, see:
> > +https://elixir.bootlin.com/linux/latest/source/include/kunit/test.h#L1=
45
> > +
> > +It includes:
> > +
> > +- ``run_case``: the function implementing the actual test case.
> > +- ``name``: the test case name.
> > +- ``generate_params``: the parameterized tests generator function. Thi=
s
> > +  is optional for non-parameterized tests.
> > +
> > +Each KUnit test case gets a ``struct kunit`` context
> > +object passed to it that tracks a running test. The KUnit assertion
> > +macros and other KUnit utilities use the ``struct kunit`` context
> > +object. As an exception, there are two fields:
> > +
> > +- ``->priv``: The setup functions can use it to store arbitrary test
> > +  user data.
> > +
> > +- ``->param_value``: It contains the parameter value which can be
> > +  retrieved in the parameterized tests.
> > +
> > +Test Suites
> > +-----------
> > +
> > +A KUnit suite includes a collection of test cases. The KUnit suites
> > +are represented by the ``struct kunit_suite``. For example:
> > +
> > +.. code-block:: c
> > +
> > +     static struct kunit_case example_test_cases[] =3D {
> > +             KUNIT_CASE(example_test_foo),
> > +             KUNIT_CASE(example_test_bar),
> > +             KUNIT_CASE(example_test_baz),
> > +             {}
> > +     };
> > +
> > +     static struct kunit_suite example_test_suite =3D {
> > +             .name =3D "example",
> > +             .init =3D example_test_init,
> > +             .exit =3D example_test_exit,
> > +             .test_cases =3D example_test_cases,
> > +     };
> > +     kunit_test_suite(example_test_suite);
> > +
> > +In the above example, the test suite ``example_test_suite``, runs the
> > +test cases ``example_test_foo``, ``example_test_bar``, and
> > +``example_test_baz``. Before running the test, the ``example_test_init=
``
> > +is called and after running the test, ``example_test_exit`` is called.
> > +The ``kunit_test_suite(example_test_suite)`` registers the test suite
> > +with the KUnit test framework.
> > +
> > +Executor
> > +--------
> > +
> > +The KUnit executor can list and run built-in KUnit tests on boot.
> > +The Test suites are stored in a linker section
> > +called ``.kunit_test_suites``. For code, see:
> > +https://elixir.bootlin.com/linux/v5.12/source/include/asm-generic/vmli=
nux.lds.h#L918.
> > +The linker section consists of an array of pointers to
> > +``struct kunit_suite``, and is populated by the ``kunit_test_suites()`=
`
> > +macro. To run all tests compiled into the kernel, the KUnit executor
> > +iterates over the linker section array.
> > +
> > +.. kernel-figure:: kunit_suitememorydiagram.png
> > +     :alt:   KUnit Suite Memory
> > +
> > +     KUnit Suite Memory Diagram
> > +
> > +On the kernel boot, the KUnit executor uses the start and end addresse=
s
> > +of this section to iterate over and run all tests. For code, see:
> > +https://elixir.bootlin.com/linux/latest/source/lib/kunit/executor.c
> > +
> > +When built as a module, the ``kunit_test_suites()`` macro defines a
> > +``module_init()`` function, which runs all the tests in the compilatio=
n
> > +unit instead of utilizing the executor.
> > +
> > +In KUnit tests, some error classes do not affect other tests
> > +or parts of the kernel, each KUnit case executes in a separate thread
> > +context. For code, see:
> > +https://elixir.bootlin.com/linux/latest/source/lib/kunit/try-catch.c#L=
58
> > +
> > +Assertion Macros
> > +----------------
> > +
> > +KUnit tests verify state using expectations/assertions.
> > +All expectations/assertions are formatted as:
> > +``KUNIT_{EXPECT|ASSERT}_<op>[_MSG](kunit, property[, message])``
> > +
> > +- ``{EXPECT|ASSERT}`` determines whether the check is an assertion or =
an
> > +  expectation.
> > +
> > +     - For an expectation, if the check fails, marks the test as faile=
d
> > +       and logs the failure.
> > +
> > +     - An assertion, on failure, causes the test case to terminate
> > +       immediately.
> > +
> > +             - Assertions call function:
> > +               ``void __noreturn kunit_abort(struct kunit *)``.
> > +
> > +             - ``kunit_abort`` calls function:
> > +               ``void __noreturn kunit_try_catch_throw(struct kunit_tr=
y_catch *try_catch)``.
> > +
> > +             - ``kunit_try_catch_throw`` calls function:
> > +               ``void complete_and_exit(struct completion *, long) __n=
oreturn;``
> > +               and terminates the special thread context.
> > +
> > +- ``<op>`` denotes a check with options: ``TRUE`` (supplied property
> > +  has the boolean value =E2=80=9Ctrue=E2=80=9D), ``EQ`` (two supplied =
properties are
> > +  equal), ``NOT_ERR_OR_NULL`` (supplied pointer is not null and does n=
ot
> > +  contain an =E2=80=9Cerr=E2=80=9D value).
> > +
> > +- ``[_MSG]`` prints a custom message on failure.
> > +
> > +Test Result Reporting
> > +---------------------
> > +KUnit prints test results in KTAP format. KTAP is based on TAP14, see:
> > +https://github.com/isaacs/testanything.github.io/blob/tap14/tap-versio=
n-14-specification.md.
> > +KTAP (yet to be standardized format) works with KUnit and Kselftest.
> > +The KUnit executor prints KTAP results to dmesg, and debugfs
> > +(if configured).
> > +
> > +Parameterized Tests
> > +-------------------
> > +
> > +Each KUnit parameterized test is associated with a collection of
> > +parameters. The test is invoked multiple times, once for each paramete=
r
> > +value and the parameter is stored in the ``param_value`` field.
> > +The test case includes a ``KUNIT_CASE_PARAM()`` macro that accepts a
> > +generator function.
> > +The generator function returns the next parameter given to the
>
> given to the -> given the
>

Reworded the sentence as "The generator function is passed the
previous parameter and returns the next
parameter".

> > +previous parameter in parameterized tests. It also provides a macro to
> > +generate common-case generators based on arrays.
> > +
> > +For code, see:
> > +https://elixir.bootlin.com/linux/v5.12/source/include/kunit/test.h#L17=
83
>
> The rest looks OK, as far as I can tell.
>  -- Tim
>

Regards,
Harinder Singh
