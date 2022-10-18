Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D733602053
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Oct 2022 03:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJRBVV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 21:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJRBVU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 21:21:20 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F227D7BA
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 18:21:16 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id 1so9021075vsx.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 18:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mM5R0L0ZlGDkJR2ljt4mT2qLk9PRw5ZOibDQbiOtG64=;
        b=NnqZY8C04MHHimt8RmYTyxiP/2EQHmgBT3tfekqlMcyG1ewf6MLoQPDb3gtrfzgicB
         ST9/UnCEZpfsYT7DKV9OzmaaCxXw7xgwYCvGj8vWkVFOetI3LLAJB++8+JD/0oXbSSLd
         9+Q7UZj2nPKzdsYSE92IVWrje/Hl81xMV8rWz3TlKIv3JGxeYUQSoxwU59IY5S88NPn1
         d0xARpi01GbCxDvewRQJP1Ie84Ow9FeI9vSFZglYUqSaH3+TmGxmJ0JF+mdw4G99uRyT
         kFi+TbK5DuxvP6AbjLZEha6eeK95HhBXtr4KYAX7VSvaLBN1u2fefLsP3j3VBQoSjdnz
         ahkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mM5R0L0ZlGDkJR2ljt4mT2qLk9PRw5ZOibDQbiOtG64=;
        b=lzheThWqR90NlQJgp9kMWbxJ8hG2/k+HsqANLnXjhNWy8N4n5pghLgjV/t+hKFS7lH
         LpNJEzSD4wvj1z4cwCSOENlpx0FdMa5w7m8gOHG8Pxx+imhYBlY2X/LTPJTV4f8oHkMY
         a/p5rBa0+Xc0WfX/fkO0SIrmDvruqbbc2Bq57AXCtk2QRYTM68RztfJA5jdhacDz0ley
         ll/WkS8ccJfF/k4sR+WKVwZbHVISEZS6uSunwOXVqO3R7PLjAPaIjd1jz6UwoBK1onLH
         GPfdQlsYy9ki5yVTtOVs6CajF/DJ4b+fdIcWPGXLiuV6A1DSN84z4MkKZEmx4RapA25C
         GJuA==
X-Gm-Message-State: ACrzQf0Iz430WHqpkN2nxk3MSsN7GGenOM+BNvAPiLucOvqdV9FGYGpC
        mqDfZOuQ6m02arwO3eu/m5Aa87pcItby5/5bT10Yfw==
X-Google-Smtp-Source: AMsMyM7FAhICjhp2XbJkq0N/fuiPE6BhprOLF9hAl8lHdXw1zCJss8mnATnLQ4KKFhPmrZzlGmmRAnNWBo19KCs7bJs=
X-Received: by 2002:a67:d20b:0:b0:3a7:2b99:bab8 with SMTP id
 y11-20020a67d20b000000b003a72b99bab8mr269670vsi.35.1666056075521; Mon, 17 Oct
 2022 18:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221017070820.2253501-1-sadiyakazi@google.com>
In-Reply-To: <20221017070820.2253501-1-sadiyakazi@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 Oct 2022 09:21:03 +0800
Message-ID: <CABVgOSmK9fM5xEyxgKv8fh_sbKOsWxe5QGhHigKySn0CECYYqA@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: Kunit: Update architecture.rst for
 minor fixes
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        corbet@lwn.net, bagasdotme@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000963c0105eb44e86b"
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

--000000000000963c0105eb44e86b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2022 at 3:13 PM 'Sadiya Kazi' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Updated the architecture.rst page with the following changes:
> -Add missing article _the_ across the document.
> -Reword content across for style and standard.
> -Update all occurrences of Command Line to Command-line
>  across the document.
> -Correct grammatical issues, for example,
>  added _it_wherever missing.
> -Update all occurrences of =E2=80=9Cvia" to either use
>  =E2=80=9Cthrough=E2=80=9D or =E2=80=9Cusing=E2=80=9D.
> -Update the text preceding the external links and pushed the full
>  link to a new line for better readability.
> -Reword content under the config command to make it more clear and concis=
e.
>
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> ---

Thanks very much: this looks good to me. A few very minor notes below,
otherwise this is good to go.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> Please Note: The link in the change log in my previous email was broken a=
s it got
> mixed with the next line. I have resent the email.
>
> Thank you Bagas for your detailed comments.
> I think the current commit message does convey the right message as it is=
 not a complete rewrite, hence retained it.
> Also since we talk about the two parts of the architecture, I have retain=
ed the it as 'kunit_tool (Command-line Test Harness)' instead of 'Running T=
ests Options'.
>
> Changes since v2:
> https://lore.kernel.org/linux-kselftest/20221013080545.1552573-1-sadiyaka=
zi@google.com/
>
> -Updated the link descriptions as per Bagas=E2=80=99s feedback
> -Reworded content talking about options to run tests and added links as p=
er Bagas=E2=80=99s feedback
>
> Best Regards,
> Sadiya Kazi
> ---
>  .../dev-tools/kunit/architecture.rst          | 118 +++++++++---------
>  1 file changed, 60 insertions(+), 58 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentati=
on/dev-tools/kunit/architecture.rst
> index 8efe792bdcb9..52b1a30c9f89 100644
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
> +KUnit. These KUnit tests are kernel code. KUnit performs the following
> +tasks:
>
>  - Organizes tests
>  - Reports test results
> @@ -22,19 +23,17 @@ KUnit. KUnit tests are kernel code. KUnit does severa=
l things:
>  Test Cases
>  ----------
>
> -The fundamental unit in KUnit is the test case. The KUnit test cases are
> -grouped into KUnit suites. A KUnit test case is a function with type
> -signature ``void (*)(struct kunit *test)``.
> -These test case functions are wrapped in a struct called
> -struct kunit_case.
> +The test case is the fundamental unit in KUnit. KUnit test cases are org=
anised
> +into suites. A KUnit test case is a function with type signature
> +``void (*)(struct kunit *test)``. These test case functions are wrapped =
in a
> +struct called struct kunit_case.
>
>  .. note:
>         ``generate_params`` is optional for non-parameterized tests.
>
> -Each KUnit test case gets a ``struct kunit`` context
> -object passed to it that tracks a running test. The KUnit assertion
> -macros and other KUnit utilities use the ``struct kunit`` context
> -object. As an exception, there are two fields:
> +Each KUnit test case receives a ``struct kunit`` context object that tra=
cks a
> +running test. The KUnit assertion macros and other KUnit utilities use t=
he
> +``struct kunit`` context object. As an exception, there are two fields:
>
>  - ``->priv``: The setup functions can use it to store arbitrary test
>    user data.
> @@ -75,14 +74,15 @@ with the KUnit test framework.
>  Executor
>  --------
>
> -The KUnit executor can list and run built-in KUnit tests on boot.
> +The KUnit executor can list and run built-in KUnit tests on boot

Nit: shouldn't we keep the full stop here?

>  The Test suites are stored in a linker section
> -called ``.kunit_test_suites``. For code, see:
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
include/asm-generic/vmlinux.lds.h?h=3Dv5.15#n945.
> +called ``.kunit_test_suites``. For the code, see ``KUNIT_TABLE()`` macro
> +definition in
> +`include/asm-generic/vmlinux.lds.h <https://git.kernel.org/pub/scm/linux=
/kernel/git/torvalds/linux.git/tree/include/asm-generic/vmlinux.lds.h?h=3Dv=
6.0#n950>`_.
>  The linker section consists of an array of pointers to
>  ``struct kunit_suite``, and is populated by the ``kunit_test_suites()``
> -macro. To run all tests compiled into the kernel, the KUnit executor
> -iterates over the linker section array.
> +macro. The KUnit executor iterates over the linker section array in orde=
r to
> +run all the tests that are compiled into the kernel.
>
>  .. kernel-figure:: kunit_suitememorydiagram.svg
>         :alt:   KUnit Suite Memory
> @@ -90,17 +90,18 @@ iterates over the linker section array.
>         KUnit Suite Memory Diagram
>
>  On the kernel boot, the KUnit executor uses the start and end addresses
> -of this section to iterate over and run all tests. For code, see:
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
lib/kunit/executor.c
> -
> +of this section to iterate over and run all tests. For the implementatio=
n of the
> +executor, see
> +`lib/kunit/executor.c <https://git.kernel.org/pub/scm/linux/kernel/git/t=
orvalds/linux.git/tree/lib/kunit/executor.c>`_.
>  When built as a module, the ``kunit_test_suites()`` macro defines a
>  ``module_init()`` function, which runs all the tests in the compilation
>  unit instead of utilizing the executor.
>
>  In KUnit tests, some error classes do not affect other tests
>  or parts of the kernel, each KUnit case executes in a separate thread
> -context. For code, see:
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
lib/kunit/try-catch.c?h=3Dv5.15#n58
> +context. For the implememtation details, see ``kunit_try_catch_run()`` f=
unction

Nit: spelling of "implementation". Also, it should be "see _the_
``kunit_try_catch_run()`` function". (In fact, I think we could drop
"For the implementation details" here, which seems redundant to me,
but I'm also okay with keeping it, if you prefer.)


> +code in
> +`lib/kunit/try-catch.c <https://git.kernel.org/pub/scm/linux/kernel/git/=
torvalds/linux.git/tree/lib/kunit/try-catch.c?h=3Dv5.15#n58>`_.
>
>  Assertion Macros
>  ----------------
> @@ -111,37 +112,36 @@ All expectations/assertions are formatted as:
>
>  - ``{EXPECT|ASSERT}`` determines whether the check is an assertion or an
>    expectation.
> +  In the event of a failure, the testing flow differs as follows:
>
> -       - For an expectation, if the check fails, marks the test as faile=
d
> -         and logs the failure.
> +       - For expectations, the test is marked as failed and the failure =
is logged.
>
> -       - An assertion, on failure, causes the test case to terminate
> -         immediately.
> +       - Failing assertions, on the other hand, result in the test case =
being
> +         terminated immediately.
>
> -               - Assertions call function:
> +               - Assertions call the function:
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
> -https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-=
14-specification.md.
> -KTAP (yet to be standardized format) works with KUnit and Kselftest.
> -The KUnit executor prints KTAP results to dmesg, and debugfs
> -(if configured).
> +KUnit prints the test results in KTAP format. KTAP is based on TAP14, se=
e
> +Documentation/dev-tools/ktap.rst.
> +KTAP works with KUnit and Kselftest. The KUnit executor prints KTAP resu=
lts to
> +dmesg, and debugfs (if configured).
>
>  Parameterized Tests
>  -------------------
> @@ -150,33 +150,35 @@ Each KUnit parameterized test is associated with a =
collection of
>  parameters. The test is invoked multiple times, once for each parameter
>  value and the parameter is stored in the ``param_value`` field.
>  The test case includes a KUNIT_CASE_PARAM() macro that accepts a
> -generator function.
> -The generator function is passed the previous parameter and returns the =
next
> -parameter. It also provides a macro to generate common-case generators b=
ased on
> -arrays.
> +generator function. The generator function is passed the previous parame=
ter
> +and returns the next parameter. It also includes a macro for generating
> +array-based common-case generators.
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
> +is used to configure, build, execute, parse test results and run all of =
the
> +previous commands in correct order (i.e., configure, build, execute and =
parse).
> +You have two options for running KUnit tests: either build the kernel wi=
th KUnit
> +enabled and manually parse the results (see
> +Documentation/dev-tools/kunit/run_manual.rst) or use ``kunit_tool``
> +(see Documentation/dev-tools/kunit/run_wrapper.rst).
>
>  - ``configure`` command generates the kernel ``.config`` from a
>    ``.kunitconfig`` file (and any architecture-specific options).
> -  For some architectures, additional config options are specified in the
> -  ``qemu_config`` Python script
> -  (For example: ``tools/testing/kunit/qemu_configs/powerpc.py``).
> +  The Python scripts available in ``qemu_configs`` folder
> +  (for example, ``tools/testing/kunit/qemu configs/powerpc.py``) contain=
s
> +  additional configuration options for specific architectures.
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
> +  If not, it will combine the two and run ``make olddefconfig`` to regen=
erate
> +  the ``.config`` file. It then checks to see if ``.config`` has become =
a superset.
> +  This verifies that all the Kconfig dependencies are correctly specifie=
d in the
> +  file ``.kunitconfig``. The ``kunit_config.py`` script contains the cod=
e for parsing
> +  Kconfigs. The code which runs ``make olddefconfig`` is part of the
> +  ``kunit_kernel.py`` script. You can invoke this command through:
> +  ``./tools/testing/kunit/kunit.py config`` and
>    generate a ``.config`` file.
>  - ``build`` runs ``make`` on the kernel tree with required options
>    (depends on the architecture and some options, for example: build_dir)
> @@ -184,8 +186,8 @@ kunit_tool or can include KUnit in kernel and parse m=
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
> 2.38.0.413.g74048e4d9e-goog
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20221017070820.2253501-1-sadiyakazi%40google.com.

--000000000000963c0105eb44e86b
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC+
WEnSgnrWnT+uwGXmz1PDEfg1a5kwoUXXZNgG5ichjjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEwMTgwMTIxMTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALFEABAoEsqPqNCHqmogi
eQGrWp7f+FIHBPY75vnizqbdZ5Bf61llQ4huNtIntrKfFhbYzxBxfddxLnoVl8OWsovzEvX+EZ0F
SrQnSNQ4L5v1zsEgSVlUiLhfQQKiqvTf5TBlG3UCNxRlreO8HepeHEguzh/X5rSgrFz8i2DpYu7x
OWB+f3st7jhD2NspLmygEb8KvxOv9DDJYZDGs2A9rS21I3Ql2rUJLzKz2k4g5kxP7ntvNmxH87Pn
Uc7HO5une9cPtxoiSFfgq7UCRciz1aZ8lwDTNN9G8r6GgySQxUrwoj7WLZplayExzL7eNXaqxR34
G8HcVpytxsAc1A7Iug==
--000000000000963c0105eb44e86b--
