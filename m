Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6745FAB7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Oct 2022 05:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJKD5b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Oct 2022 23:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJKD5a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Oct 2022 23:57:30 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3019E7E810
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Oct 2022 20:57:28 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id k6so13065717vsc.8
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Oct 2022 20:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDuaNOIG6h0VISUOlP+uDBByl04L64AdQ5GBoU048Ts=;
        b=dHHAs46zaPrpqTTib4r55Pumy6W7bd8nhvORuIf9l0szR2rfX40+7dOTazDe89PjvJ
         aLBCzl+9Z5slUmiLCyBOzVqVgbFw3fUnzo8h5/+IaWRIazFuJ+pkSKSBsOQkYzzRRnM9
         flGKMGRIZxxg8/7AOSNCr9ht+6IHGrq+Vgp71RALoFls3O6R1QI4ouQivOjsKXEWkkqu
         Yc3Euxq0/eAAlekWGOPM5FA0lO/RNscfsMv5o5I40+3qo0IkxUywm6VmyNrdBgGxh6qm
         7d0bPop5zp5Rnkbhy9rWHnd8fT87xMbpwh/bFi8Vdh9SImAfZV2EIZ1x3jTkdY7PXUkE
         VnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDuaNOIG6h0VISUOlP+uDBByl04L64AdQ5GBoU048Ts=;
        b=z+RxHOX9Yd0hMxjObwGkkP8fVbi+fgTNTSWmZc66FpnYN+5rMFhj6HLuaKtPfLdB+a
         z5Q347qmSHALogKBpCzbXixoPAOOs7GusRSKfDgqGNnbdtvHqTgCL9LufS9qrrXQspi8
         tRVpdOg2w2GSzBEcKLB7xeNeZ+nk+XDB0kWKco3lGlJn9EnDfy+Fik/uylaRpEha334J
         NwWIj/gIwlqxltDiEqnowVmSQ0E8bk0HPG4qrFYNeUPgwUYh9E9Kv066ecqZ/LHxCVY5
         zaBb0XqyZ4gfWIzwdmFLqJDFactbqCHk1VDpUQITZgMMZqRE0Wmi2C2qJIcQ9/99I0E3
         +CCQ==
X-Gm-Message-State: ACrzQf0grd9loCln5ZsdvAx9w+lKLRRVLrZwJNJXfsUUNr7ki9PbsthM
        HprssahPtfhq2/l+Gxz89nT6j5Igu6xC7snQH03H3Rd/TSVIjg==
X-Google-Smtp-Source: AMsMyM5jKFZECE5eU8vhQKWibWDPmnw498Dqb96SvLJ0DS1Pt6n0q/ebViULAfZywnSYltWsp95vg8elSbmkk5TPT74=
X-Received: by 2002:a67:d20b:0:b0:3a7:2b99:bab8 with SMTP id
 y11-20020a67d20b000000b003a72b99bab8mr8976913vsi.35.1665460647152; Mon, 10
 Oct 2022 20:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221010171353.1106166-1-sadiyakazi@google.com>
In-Reply-To: <20221010171353.1106166-1-sadiyakazi@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 11 Oct 2022 11:57:15 +0800
Message-ID: <CABVgOSmgevkObB2zuCGawQn+P01Je7Csg49ukUO=si2igFKZ2Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Kunit: Update architecture.rst for minor fixes
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Oct 11, 2022 at 1:14 AM 'Sadiya Kazi' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Updated the architecture.rst page with the following changes:
> -Add missing article _the_ across the document.
> -Reword content across for style and standard.
> -Upate all occurrences of Command Line to Command-line across the documen=
t.

Nit: spelling of "Update"

> -Correct grammatical issues, for example - added _it_wherever missing.
> -Update all occurrences of _via_ to either use _through_ or _using_.
> -Update the text preceding the external links and pushed the full
> link to a new line for better readability.
> -Reword content under the config command to make it more clear and concis=
e.
>
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> ---

Thanks very much for such a thorough cleanup here. On the whole, I
really like this, but have (quite) a few comments on the individual
changes below.

Cheers,
-- David

>  .../dev-tools/kunit/architecture.rst          | 86 ++++++++++---------
>  1 file changed, 45 insertions(+), 41 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentati=
on/dev-tools/kunit/architecture.rst
> index 8efe792bdcb9..1736c37c33f2 100644
> --- a/Documentation/dev-tools/kunit/architecture.rst
> +++ b/Documentation/dev-tools/kunit/architecture.rst
> @@ -4,16 +4,17 @@
>  KUnit Architecture
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -The KUnit architecture can be divided into two parts:
> +The KUnit architecture is divided into two parts:
>
>  - `In-Kernel Testing Framework`_
> -- `kunit_tool (Command Line Test Harness)`_
> +- `kunit_tool (Command-line Test Harness)`_
>
>  In-Kernel Testing Framework
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
>  The kernel testing library supports KUnit tests written in C using
> -KUnit. KUnit tests are kernel code. KUnit does several things:
> +KUnit. KUnit tests are written in the kernel code. KUnit performs the fo=
llowing

I think "KUnit tests are kernel code" is better than "are written in
the kernel code": the distinction we're trying to draw here is between
"kernel" and "userspace" code.

> +tasks:
>
>  - Organizes tests
>  - Reports test results
> @@ -22,8 +23,8 @@ KUnit. KUnit tests are kernel code. KUnit does several =
things:
>  Test Cases
>  ----------
>
> -The fundamental unit in KUnit is the test case. The KUnit test cases are
> -grouped into KUnit suites. A KUnit test case is a function with type
> +The test case is the fundamental unit in KUnit. KUnit test cases are org=
anised
> +into suites. A KUnit test case is a function with type
>  signature ``void (*)(struct kunit *test)``.
>  These test case functions are wrapped in a struct called
>  struct kunit_case.
> @@ -31,8 +32,8 @@ struct kunit_case.
>  .. note:
>         ``generate_params`` is optional for non-parameterized tests.
>
> -Each KUnit test case gets a ``struct kunit`` context
> -object passed to it that tracks a running test. The KUnit assertion
> +Each KUnit test case receives a ``struct kunit`` context object that tra=
cks a
> +running test. The KUnit assertion
>  macros and other KUnit utilities use the ``struct kunit`` context
>  object. As an exception, there are two fields:
>
> @@ -77,11 +78,12 @@ Executor
>
>  The KUnit executor can list and run built-in KUnit tests on boot.
>  The Test suites are stored in a linker section
> -called ``.kunit_test_suites``. For code, see:
> +called ``.kunit_test_suites``. For code, see the following link:

I prefer just "see" to "see the following link".

But maybe the whole thing could be "are stored in a linker section
called ``.kunit_test_suites``, as defined in:"

>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
include/asm-generic/vmlinux.lds.h?h=3Dv5.15#n945.

If we're updating things, do we update the link to a newer version?

> +
>  The linker section consists of an array of pointers to
>  ``struct kunit_suite``, and is populated by the ``kunit_test_suites()``
> -macro. To run all tests compiled into the kernel, the KUnit executor
> +macro. To run all the compiled tests into the kernel, the KUnit executor

I think we want "all the tests [which are] compiled into the kernel" here.

>  iterates over the linker section array.
>
>  .. kernel-figure:: kunit_suitememorydiagram.svg
> @@ -90,8 +92,8 @@ iterates over the linker section array.
>         KUnit Suite Memory Diagram
>
>  On the kernel boot, the KUnit executor uses the start and end addresses
> -of this section to iterate over and run all tests. For code, see:
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
lib/kunit/executor.c
> +of this section to iterate over and run all tests. For code, see the fol=
lowing link:

As above, I prefer this without "the following link".

> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
lib/kunit/executor.c.
>
>  When built as a module, the ``kunit_test_suites()`` macro defines a
>  ``module_init()`` function, which runs all the tests in the compilation
> @@ -99,46 +101,48 @@ unit instead of utilizing the executor.
>
>  In KUnit tests, some error classes do not affect other tests
>  or parts of the kernel, each KUnit case executes in a separate thread
> -context. For code, see:
> +context. For code, see the following link:

[And again.] Also, this (and the above) links could be updated if we
were updating the lines around them. Since we might drop this part of
the change, though, it's probably not worth it.

>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
lib/kunit/try-catch.c?h=3Dv5.15#n58
>
>  Assertion Macros
>  ----------------
>
> -KUnit tests verify state using expectations/assertions.
> +KUnit tests verify the state using expectations/assertions.

This could go either way, I think since these are verifying "some"
state, but each call does not verify "all" of the state, it's better
without the "the" here.

I could be persuaded otherwise.

>  All expectations/assertions are formatted as:
>  ``KUNIT_{EXPECT|ASSERT}_<op>[_MSG](kunit, property[, message])``
>
>  - ``{EXPECT|ASSERT}`` determines whether the check is an assertion or an
>    expectation.
>
> -       - For an expectation, if the check fails, marks the test as faile=
d
> +       - For an expectation, if the check fails, it marks the test as fa=
iled

Maybe just "An exception, if the check fails, marks the test as
failed". Or something else less convoluted?

>           and logs the failure.
>
>         - An assertion, on failure, causes the test case to terminate
>           immediately.
>
> -               - Assertions call function:
> +               - Assertion calls the function:

"Assertions call the function"? There can be many assertions.


>                   ``void __noreturn kunit_abort(struct kunit *)``.
>
> -               - ``kunit_abort`` calls function:
> +               - ``kunit_abort`` calls the function:
>                   ``void __noreturn kunit_try_catch_throw(struct kunit_tr=
y_catch *try_catch)``.
>
> -               - ``kunit_try_catch_throw`` calls function:
> +               - ``kunit_try_catch_throw`` calls the function:
>                   ``void kthread_complete_and_exit(struct completion *, l=
ong) __noreturn;``
>                   and terminates the special thread context.
>
>  - ``<op>`` denotes a check with options: ``TRUE`` (supplied property
> -  has the boolean value =E2=80=9Ctrue=E2=80=9D), ``EQ`` (two supplied pr=
operties are
> +  has the boolean value "true"), ``EQ`` (two supplied properties are
>    equal), ``NOT_ERR_OR_NULL`` (supplied pointer is not null and does not
> -  contain an =E2=80=9Cerr=E2=80=9D value).
> +  contain an "err" value).
>
>  - ``[_MSG]`` prints a custom message on failure.
>
>  Test Result Reporting
>  ---------------------
> -KUnit prints test results in KTAP format. KTAP is based on TAP14, see:
> +KUnit prints the test results in KTAP format.
> +KTAP is based on TAP14, see:
>  https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-=
14-specification.md.
> +

Let's take this opportunity to link to the final KTAP spec in
Documentation/dev-tools/ktap.rst

>  KTAP (yet to be standardized format) works with KUnit and Kselftest.

Let's update this, as KTAP is standardised.

>  The KUnit executor prints KTAP results to dmesg, and debugfs
>  (if configured).
> @@ -151,32 +155,32 @@ parameters. The test is invoked multiple times, onc=
e for each parameter
>  value and the parameter is stored in the ``param_value`` field.
>  The test case includes a KUNIT_CASE_PARAM() macro that accepts a
>  generator function.
> -The generator function is passed the previous parameter and returns the =
next
> -parameter. It also provides a macro to generate common-case generators b=
ased on
> -arrays.
> +The previous parameter is passed to the generator function, which return=
s
> +the next parameter. It also includes a macro for generating array-based
> +common-case generators.

In this case, I prefer the first one, as the "generator function" is
what we're describing, so should be the subject of the sentence.

>
> -kunit_tool (Command Line Test Harness)
> +kunit_tool (Command-line Test Harness)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -kunit_tool is a Python script ``(tools/testing/kunit/kunit.py)``
> -that can be used to configure, build, exec, parse and run (runs other
> -commands in order) test results. You can either run KUnit tests using
> -kunit_tool or can include KUnit in kernel and parse manually.
> +``kunit_tool`` is a Python script, found in ``tools/testing/kunit/kunit.=
py``. It
> +is used to configure, build, execute, parse, and run (other commands in =
order)

"run" runs all of the previous commands in order (i.e., configure,
build, execute, and parse), so maybe we can expand the parenthetical
to make that more obvious?

> +test results. You have two options for running KUnit tests: either inclu=
de KUnit
> +in the kernel and parse manually, or use the ``kunit_tool``.

Maybe we should avoid saying "include KUnit in the kernel" here. This
has always been a bit misleading. KUnit is always included in the
kernel, but can be "configured, built, and run" manually, or via
kunit_tool. kunit_tool can also parse the results.

>
>  - ``configure`` command generates the kernel ``.config`` from a
>    ``.kunitconfig`` file (and any architecture-specific options).
> -  For some architectures, additional config options are specified in the
> -  ``qemu_config`` Python script
> -  (For example: ``tools/testing/kunit/qemu_configs/powerpc.py``).
> +  The Python script available in ``qemu_configs`` folder
> +  (for example, ``tools/testing/kunit/qemu configs/powerpc.py``) contain=
s
> +  additional configuration options for specific architectures.

I think this should be "the Python scripts", as there's one per architectur=
e.

>    It parses both the existing ``.config`` and the ``.kunitconfig`` files
> -  and ensures that ``.config`` is a superset of ``.kunitconfig``.
> -  If this is not the case, it will combine the two and run
> -  ``make olddefconfig`` to regenerate the ``.config`` file. It then
> -  verifies that ``.config`` is now a superset. This checks if all
> -  Kconfig dependencies are correctly specified in ``.kunitconfig``.
> -  ``kunit_config.py`` includes the parsing Kconfigs code. The code which
> -  runs ``make olddefconfig`` is a part of ``kunit_kernel.py``. You can
> -  invoke this command via: ``./tools/testing/kunit/kunit.py config`` and
> +  to ensure that ``.config`` is a superset of ``.kunitconfig``.
> +  If not, it will combine the two and execute ``make olddefconfig`` to r=
egenerate

"run" reads more cleanly than "execute" here, IMO.

> +  the ``.config`` file. It then checks to see if ``.config`` has become =
a superset.
> +  This verifies that all the Kconfig dependencies are correctly specifie=
d in the file
> +  ``.kunitconfig``. The

Word wrapping is a bit odd here?

> +  ``kunit_config.py`` script contains the code for parsing Kconfigs. The=
 code which
> +  runs ``make olddefconfig`` is part of the ``kunit_kernel.py`` script. =
You can
> +  invoke this command through: ``./tools/testing/kunit/kunit.py config``=
 and
>    generate a ``.config`` file.
>  - ``build`` runs ``make`` on the kernel tree with required options
>    (depends on the architecture and some options, for example: build_dir)
> @@ -184,8 +188,8 @@ kunit_tool or can include KUnit in kernel and parse m=
anually.
>    To build a KUnit kernel from the current ``.config``, you can use the
>    ``build`` argument: ``./tools/testing/kunit/kunit.py build``.
>  - ``exec`` command executes kernel results either directly (using
> -  User-mode Linux configuration), or via an emulator such
> -  as QEMU. It reads results from the log via standard
> +  User-mode Linux configuration), or through an emulator such
> +  as QEMU. It reads results from the log using standard
>    output (stdout), and passes them to ``parse`` to be parsed.
>    If you already have built a kernel with built-in KUnit tests,
>    you can run the kernel and display the test results with the ``exec``
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20221010171353.1106166-1-sadiyakazi%40google.com.
