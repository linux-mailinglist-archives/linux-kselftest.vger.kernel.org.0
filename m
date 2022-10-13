Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C955FDBF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 16:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJMOEc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 10:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJMOE3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 10:04:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF6CE09EC;
        Thu, 13 Oct 2022 07:04:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id l4so1885012plb.8;
        Thu, 13 Oct 2022 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PR4Wz8uxoKrl14L2NkKeOXMambCK9Hk6dDvuFd0x/UA=;
        b=p0CI0NH7yR/JB/+UNC6eI3cVxZVEAdrIOj94BQjElN0EoH3jjebmrH2SXv+CYNYVNX
         yQDeJPfH+bW/fUqVK5X0I/G39PLJ582AE6JyP3ttd3c0PT/ntbefVBiYXNBY9DyUn20D
         P7iXWkSoPwdUklJf+rIeo38KVNxFGlmU28X9p+wcAfBW3M6DB5Na/Eau4thJqrnAV6Aa
         nplLd9406B05CJUhgWaoKRPV71z1y2nhCfmVLr1WqAlVL3/BQVAWbxiT8flI1JQ/O1Q5
         /+LfR4UcL77r7RzvKQpDn2AoaHjL++BJ3Tb/xPiw/I1o0yel+Xr89aBsKBpWvZ2lIGQr
         ArJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR4Wz8uxoKrl14L2NkKeOXMambCK9Hk6dDvuFd0x/UA=;
        b=oZ7mLPmDQJf63gtbrvH5x7Nur11JAPJV2IybpkfbHxxM0PVNyN5+d6HWM958Q83gRz
         JvSpFDYnBmzZMjJUY5Kx6c2sgBJySH8Uh7GtP9ABxi5JXpz+Vxu9ZfhgSagltt+lL6+7
         wXCXWL5ZV0HuTIudb6SqfNYvR1vjU5ehsfgWbF8LenbMsYuv37xVQkjD9hFnQT6mMhya
         ni9H/DPxw5/0f77qNia3NQoLbc0XGwf+yG86JO8jJXZvpGpTWsFZwgh80wLXc6qDXd+1
         ZZmZRmsrsLp+FqKGi6HRQ9VN1fZOjm1Sj+SRjgpQwq5dsfCGnpGNN3YuyJw8T+YpOmvU
         Xi1g==
X-Gm-Message-State: ACrzQf2RKUQFOF6bQbJRssNZvfiHX3PAZLbrNkwimDpYkh4uZ3RvhCtY
        NeXdQIv5dnBfXfE5LrYM2JE=
X-Google-Smtp-Source: AMsMyM5Z6ahIFlkanbPGOmwm+hINGZRrrPw4yOXVVKjUKpJaBcR3roE7fRHlZxzQUfDH1UT/u4kr9Q==
X-Received: by 2002:a17:902:7883:b0:17f:9503:abe5 with SMTP id q3-20020a170902788300b0017f9503abe5mr121976pll.41.1665669765788;
        Thu, 13 Oct 2022 07:02:45 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id c72-20020a621c4b000000b00561c179e17dsm2050412pfc.76.2022.10.13.07.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 07:02:45 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D4C6B100190; Thu, 13 Oct 2022 21:02:40 +0700 (WIB)
Date:   Thu, 13 Oct 2022 21:02:40 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Kunit: Update architecture.rst for
 minor fixes
Message-ID: <Y0gagAeBlO2rtZYe@debian.me>
References: <20221013080545.1552573-1-sadiyakazi@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bro1OLzb/5Nx05b5"
Content-Disposition: inline
In-Reply-To: <20221013080545.1552573-1-sadiyakazi@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--bro1OLzb/5Nx05b5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 13, 2022 at 08:05:46AM +0000, Sadiya Kazi wrote:
> Updated the architecture.rst page with the following changes:
> -Add missing article _the_ across the document.
> -Reword content across for style and standard.
> -Update all occurrences of Command Line to
>  Command-line across the document.
> -Correct grammatical issues, for example, added _it_
>  wherever missing.
> -Update all occurrences of =E2=80=9Cvia" to either
>  use =E2=80=9Cthrough=E2=80=9D or =E2=80=9Cusing=E2=80=9D.
> -Update the text preceding the external links and pushed
> the full link to a new line for better readability.
> -Reword content under the config command to make it
>  more clear and concise.
>=20

I think this patch is rewriting the documentation, since you touch most
of the doc.

> diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentati=
on/dev-tools/kunit/architecture.rst
> index 8efe792bdcb9..b8ee0fa8afc3 100644
> --- a/Documentation/dev-tools/kunit/architecture.rst
> +++ b/Documentation/dev-tools/kunit/architecture.rst
> @@ -4,16 +4,17 @@
>  KUnit Architecture
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -The KUnit architecture can be divided into two parts:
> +The KUnit architecture is divided into two parts:
> =20
>  - `In-Kernel Testing Framework`_
> -- `kunit_tool (Command Line Test Harness)`_
> +- `kunit_tool (Command-line Test Harness)`_
> =20
>  In-Kernel Testing Framework
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> =20
>  The kernel testing library supports KUnit tests written in C using
> -KUnit. KUnit tests are kernel code. KUnit does several things:
> +KUnit. These KUnit tests are kernel code. KUnit performs the following
> +tasks:
> =20
>  - Organizes tests
>  - Reports test results
> @@ -22,19 +23,17 @@ KUnit. KUnit tests are kernel code. KUnit does severa=
l things:
>  Test Cases
>  ----------
> =20
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
> =20
>  .. note:
>  	``generate_params`` is optional for non-parameterized tests.
> =20
> -Each KUnit test case gets a ``struct kunit`` context
> -object passed to it that tracks a running test. The KUnit assertion
> -macros and other KUnit utilities use the ``struct kunit`` context
> -object. As an exception, there are two fields:
> +Each KUnit test case receives a ``struct kunit`` context object that tra=
cks a
> +running test. The KUnit assertion macros and other KUnit utilities use t=
he
> +``struct kunit`` context object. As an exception, there are two fields:
> =20
>  - ``->priv``: The setup functions can use it to store arbitrary test
>    user data.
> @@ -77,12 +76,12 @@ Executor
> =20
>  The KUnit executor can list and run built-in KUnit tests on boot.
>  The Test suites are stored in a linker section
> -called ``.kunit_test_suites``. For code, see:
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
include/asm-generic/vmlinux.lds.h?h=3Dv5.15#n945.
> +called ``.kunit_test_suites``. For the full code, see
> +`include/asm-generic/vmlinux.lds.h <https://git.kernel.org/pub/scm/linux=
/kernel/git/torvalds/linux.git/tree/include/asm-generic/vmlinux.lds.h?h=3Dv=
6.0#n950>`_ .
>  The linker section consists of an array of pointers to
>  ``struct kunit_suite``, and is populated by the ``kunit_test_suites()``
> -macro. To run all tests compiled into the kernel, the KUnit executor
> -iterates over the linker section array.
> +macro. The KUnit executor iterates over the linker section array in orde=
r to
> +run all the tests that are compiled into the kernel.
> =20
>  .. kernel-figure:: kunit_suitememorydiagram.svg
>  	:alt:	KUnit Suite Memory
> @@ -90,17 +89,16 @@ iterates over the linker section array.
>  	KUnit Suite Memory Diagram
> =20
>  On the kernel boot, the KUnit executor uses the start and end addresses
> -of this section to iterate over and run all tests. For code, see:
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
lib/kunit/executor.c
> -
> +of this section to iterate over and run all tests. For the full code, see
> +`executor.c <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/tree/lib/kunit/executor.c>`_.
>  When built as a module, the ``kunit_test_suites()`` macro defines a
>  ``module_init()`` function, which runs all the tests in the compilation
>  unit instead of utilizing the executor.
> =20
>  In KUnit tests, some error classes do not affect other tests
>  or parts of the kernel, each KUnit case executes in a separate thread
> -context. For code, see:
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
lib/kunit/try-catch.c?h=3Dv5.15#n58
> +context. For the full code, see
> +`try-catch.c <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git/tree/lib/kunit/try-catch.c?h=3Dv5.15#n58>`_.
> =20
>  Assertion Macros
>  ----------------
> @@ -111,37 +109,36 @@ All expectations/assertions are formatted as:
> =20
>  - ``{EXPECT|ASSERT}`` determines whether the check is an assertion or an
>    expectation.
> +  In the event of a failure, the testing flow differs as follows:
> =20
> -	- For an expectation, if the check fails, marks the test as failed
> -	  and logs the failure.
> +	- For expectations, the test is marked as failed and the failure is log=
ged.
> =20
> -	- An assertion, on failure, causes the test case to terminate
> -	  immediately.
> +	- Failing assertions, on the other hand, result in the test case being
> +	  terminated immediately.
> =20
> -		- Assertions call function:
> +		- Assertions call the function:
>  		  ``void __noreturn kunit_abort(struct kunit *)``.
> =20
> -		- ``kunit_abort`` calls function:
> +		- ``kunit_abort`` calls the function:
>  		  ``void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_=
catch)``.
> =20
> -		- ``kunit_try_catch_throw`` calls function:
> +		- ``kunit_try_catch_throw`` calls the function:
>  		  ``void kthread_complete_and_exit(struct completion *, long) __noretu=
rn;``
>  		  and terminates the special thread context.
> =20
>  - ``<op>`` denotes a check with options: ``TRUE`` (supplied property
> -  has the boolean value =E2=80=9Ctrue=E2=80=9D), ``EQ`` (two supplied pr=
operties are
> +  has the boolean value "true"), ``EQ`` (two supplied properties are
>    equal), ``NOT_ERR_OR_NULL`` (supplied pointer is not null and does not
> -  contain an =E2=80=9Cerr=E2=80=9D value).
> +  contain an "err" value).
> =20
>  - ``[_MSG]`` prints a custom message on failure.
> =20
>  Test Result Reporting
>  ---------------------
> -KUnit prints test results in KTAP format. KTAP is based on TAP14, see:
> -https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-=
14-specification.md.
> -KTAP (yet to be standardized format) works with KUnit and Kselftest.
> -The KUnit executor prints KTAP results to dmesg, and debugfs
> -(if configured).
> +KUnit prints the test results in KTAP format. KTAP is based on TAP14, see
> +Documentation/dev-tools/ktap.rst.
> +KTAP works with KUnit and Kselftest. The KUnit executor prints KTAP resu=
lts to
> +dmesg, and debugfs (if configured).
> =20
>  Parameterized Tests
>  -------------------
> @@ -150,33 +147,33 @@ Each KUnit parameterized test is associated with a =
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
> =20
> -kunit_tool (Command Line Test Harness)
> +kunit_tool (Command-line Test Harness)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
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
> +You have two options for running KUnit tests: either use KUnit
> +directly through the kernel and parse manually, or use the ``kunit_tool`=
`.
> =20
>  - ``configure`` command generates the kernel ``.config`` from a
>    ``.kunitconfig`` file (and any architecture-specific options).
> -  For some architectures, additional config options are specified in the
> -  ``qemu_config`` Python script
> -  (For example: ``tools/testing/kunit/qemu_configs/powerpc.py``).
> +  The Python scripts available in ``qemu_configs`` folder
> +  (for example, ``tools/testing/kunit/qemu configs/powerpc.py``) contains
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
d in the file
> +  ``.kunitconfig``. The ``kunit_config.py`` script contains the code for=
 parsing
> +  Kconfigs. The code which runs ``make olddefconfig`` is part of the
> +  ``kunit_kernel.py`` script. You can invoke this command through:
> +  ``./tools/testing/kunit/kunit.py config`` and
>    generate a ``.config`` file.
>  - ``build`` runs ``make`` on the kernel tree with required options
>    (depends on the architecture and some options, for example: build_dir)
> @@ -184,8 +181,8 @@ kunit_tool or can include KUnit in kernel and parse m=
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
> @@ -193,3 +190,6 @@ kunit_tool or can include KUnit in kernel and parse m=
anually.
>  - ``parse`` extracts the KTAP output from a kernel log, parses
>    the test results, and prints a summary. For failed tests, any
>    diagnostic output will be included.
> +
> +For more information on kunit_tool, see
> +Documentation/dev-tools/kunit/run_wrapper.rst.

That's not what I mean in my review to v1 [1], so here are the proper
changes:

---- >8 ----
diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentation=
/dev-tools/kunit/architecture.rst
index b8ee0fa8afc3ea..1f0fd53b66858d 100644
--- a/Documentation/dev-tools/kunit/architecture.rst
+++ b/Documentation/dev-tools/kunit/architecture.rst
@@ -7,7 +7,7 @@ KUnit Architecture
 The KUnit architecture is divided into two parts:
=20
 - `In-Kernel Testing Framework`_
-- `kunit_tool (Command-line Test Harness)`_
+- `Running Tests Options`_
=20
 In-Kernel Testing Framework
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
@@ -76,8 +76,8 @@ Executor
=20
 The KUnit executor can list and run built-in KUnit tests on boot.
 The Test suites are stored in a linker section
-called ``.kunit_test_suites``. For the full code, see
-`include/asm-generic/vmlinux.lds.h <https://git.kernel.org/pub/scm/linux/k=
ernel/git/torvalds/linux.git/tree/include/asm-generic/vmlinux.lds.h?h=3Dv6.=
0#n950>`_ .
+called ``.kunit_test_suites``. For the code, see ``KUNIT_TABLE()`` macro
+definition in ``include/asm-generic/vmlinux.lds.h``
 The linker section consists of an array of pointers to
 ``struct kunit_suite``, and is populated by the ``kunit_test_suites()``
 macro. The KUnit executor iterates over the linker section array in order =
to
@@ -89,16 +89,17 @@ run all the tests that are compiled into the kernel.
 	KUnit Suite Memory Diagram
=20
 On the kernel boot, the KUnit executor uses the start and end addresses
-of this section to iterate over and run all tests. For the full code, see
-`executor.c <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/tree/lib/kunit/executor.c>`_.
+of this section to iterate over and run all tests. For the implementation
+of executor, see
+``lib/kunit/executor.c``.
 When built as a module, the ``kunit_test_suites()`` macro defines a
 ``module_init()`` function, which runs all the tests in the compilation
 unit instead of utilizing the executor.
=20
 In KUnit tests, some error classes do not affect other tests
 or parts of the kernel, each KUnit case executes in a separate thread
-context. For the full code, see
-`try-catch.c <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/tree/lib/kunit/try-catch.c?h=3Dv5.15#n58>`_.
+context. See ``kunit_try_catch_run()`` function code in
+``lib/kunit/try-catch.c`` for the implementation details.
=20
 Assertion Macros
 ----------------
@@ -151,45 +152,10 @@ generator function. The generator function is passed =
the previous parameter
 and returns the next parameter. It also includes a macro for generating
 array-based common-case generators.
=20
-kunit_tool (Command-line Test Harness)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Running Tests Options
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-``kunit_tool`` is a Python script, found in ``tools/testing/kunit/kunit.py=
``. It
-is used to configure, build, execute, parse test results and run all of the
-previous commands in correct order (i.e., configure, build, execute and pa=
rse).
-You have two options for running KUnit tests: either use KUnit
-directly through the kernel and parse manually, or use the ``kunit_tool``.
-
-- ``configure`` command generates the kernel ``.config`` from a
-  ``.kunitconfig`` file (and any architecture-specific options).
-  The Python scripts available in ``qemu_configs`` folder
-  (for example, ``tools/testing/kunit/qemu configs/powerpc.py``) contains
-  additional configuration options for specific architectures.
-  It parses both the existing ``.config`` and the ``.kunitconfig`` files
-  to ensure that ``.config`` is a superset of ``.kunitconfig``.
-  If not, it will combine the two and run ``make olddefconfig`` to regener=
ate
-  the ``.config`` file. It then checks to see if ``.config`` has become a =
superset.
-  This verifies that all the Kconfig dependencies are correctly specified =
in the file
-  ``.kunitconfig``. The ``kunit_config.py`` script contains the code for p=
arsing
-  Kconfigs. The code which runs ``make olddefconfig`` is part of the
-  ``kunit_kernel.py`` script. You can invoke this command through:
-  ``./tools/testing/kunit/kunit.py config`` and
-  generate a ``.config`` file.
-- ``build`` runs ``make`` on the kernel tree with required options
-  (depends on the architecture and some options, for example: build_dir)
-  and reports any errors.
-  To build a KUnit kernel from the current ``.config``, you can use the
-  ``build`` argument: ``./tools/testing/kunit/kunit.py build``.
-- ``exec`` command executes kernel results either directly (using
-  User-mode Linux configuration), or through an emulator such
-  as QEMU. It reads results from the log using standard
-  output (stdout), and passes them to ``parse`` to be parsed.
-  If you already have built a kernel with built-in KUnit tests,
-  you can run the kernel and display the test results with the ``exec``
-  argument: ``./tools/testing/kunit/kunit.py exec``.
-- ``parse`` extracts the KTAP output from a kernel log, parses
-  the test results, and prints a summary. For failed tests, any
-  diagnostic output will be included.
-
-For more information on kunit_tool, see
-Documentation/dev-tools/kunit/run_wrapper.rst.
+There are two options to run tests: either build the kernel with KUnit
+enabled and manually parse the results (see
+Documentation/dev-tools/kunit/run_manual.rst) or use kunit_tool script
+(see Documentation/dev-tools/kunit/run_wrapper.rst).

Thanks.

[1]: https://lore.kernel.org/linux-kselftest/2d174fee-bdd1-a304-c66c-09e957=
120af1@gmail.com/

--=20
An old man doll... just what I always wanted! - Clara

--bro1OLzb/5Nx05b5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0gafAAKCRD2uYlJVVFO
o+ZhAQDDyXL101bXatVgyqkMKDjged6YHF7MZqpzEWXYC3yL8gEAjz6KwwxQosrP
DG/ToYQZr/scVYPDKKeWBLygS8mvdwc=
=HZ5d
-----END PGP SIGNATURE-----

--bro1OLzb/5Nx05b5--
