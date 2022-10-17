Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF0A600B34
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 11:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiJQJpC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 05:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiJQJpB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 05:45:01 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C75D275D4;
        Mon, 17 Oct 2022 02:44:59 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 129so9979012pgc.5;
        Mon, 17 Oct 2022 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6w1PAaUTCjPukGI0vOQ+R/3atXqjV5uO6exD9p/X6Y=;
        b=XoJMbly4B0saJm8NDptnA8WAcCvDISv6V1tu5Uq2PyfezORvoT5eZAMSRnFicyfFEa
         +KuoQ6Je6IhleHFxTy4R15hlsp/KVLeipZsHasv6AsMns8nfmLzVVqV1uZqZhwANhIPX
         22xBytCuPjVnViGmUPBD6H4LafjzUBsXh7+APjNjqEzYmY25NWSdqRR9Lm837rS2VNst
         g5OKC9MDH5/GRB5R5NbWzF5faOGLQcP6JkcvqyNAGsauI4/8m7UezJtTiff6EDwIFx4K
         fYuY+iG7mNte3KrCjCnVMwg2z5XHCQ6rW1sIEgkiuzbd0fu+VKQawYT1ATE+TcRKFm36
         Rrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6w1PAaUTCjPukGI0vOQ+R/3atXqjV5uO6exD9p/X6Y=;
        b=7uKrvl7Q1WvzpheH3XFibU76hYf94y/olVkYLmqSnembDHuzNfiHIduI24abfnJFfc
         wNnGa5aSbrzzkx5KkPBfOTyIhOrbK0FboLdMOcxg0wLBdwceul1ixl27ZkLKt/IAkw0t
         WejxUCO0lj4omNUn2mVqqs+MQTBe4HjffIfpY891arK/GpWE/OlrrSmWleDbwXdq26q3
         L32jn3N3kUw8Qhqw3LvYEhx5laVacEbCapoS3H5IZKuSlB+KE7GZMQKlvuqYob6NaPRK
         M80gKE8GpYYZuuceYYW+RLUsgwClJjIGNZg+/eLvrVOfMpGa+0slE5E9BhSbEUe1RrlN
         u99g==
X-Gm-Message-State: ACrzQf2ORhEHYpdANIOtXyfmGxHxgUJNM6rrcD47NlomC1h6xViClLYy
        GjEL89p8Sr+LeIFQxp3XXJY=
X-Google-Smtp-Source: AMsMyM5BXk/q1P6qGLg/Z74zMGlJFMN8GlQri0Kne+PjFcGu4ypvQ3aEdW6meCz5SXtVhhOXI/JozQ==
X-Received: by 2002:a63:1521:0:b0:43c:9566:7a6a with SMTP id v33-20020a631521000000b0043c95667a6amr9971910pgl.339.1665999898521;
        Mon, 17 Oct 2022 02:44:58 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id t25-20020aa79479000000b0056126b79072sm6615433pfq.21.2022.10.17.02.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:44:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DB0851017B5; Mon, 17 Oct 2022 16:27:24 +0700 (WIB)
Date:   Mon, 17 Oct 2022 16:27:24 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: Kunit: Update architecture.rst for
 minor fixes
Message-ID: <Y00f/OHxTJXH2vYc@debian.me>
References: <20221017065452.2250273-1-sadiyakazi@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EY4KXZ7eqD8LDJOn"
Content-Disposition: inline
In-Reply-To: <20221017065452.2250273-1-sadiyakazi@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--EY4KXZ7eqD8LDJOn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2022 at 06:54:53AM +0000, Sadiya Kazi wrote:
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
>=20
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> ---
>=20
> Thank you Bagas for your detailed comments.=20
> I think the current commit message does convey the right message as it is=
 not a complete rewrite, hence retained it.=20
> Also since we talk about the two parts of the architecture, I have retain=
ed the it as 'kunit_tool (Command-line Test Harness)' instead of 'Running T=
ests Options'.
>=20
> Changes since v2:
> https://lore.kernel.org/linux-kselftest/20221013080545.1552573-1-sadiyaka=
zi@google.com/
> -Updated the link descriptions as per Bagas=E2=80=99s feedback
> -Reworded content talking about options to run tests and added links as p=
er Bagas=E2=80=99s feedback
>=20
> Best Regards,
> Sadiya Kazi
> ---
>  .../dev-tools/kunit/architecture.rst          | 118 +++++++++---------
>  1 file changed, 60 insertions(+), 58 deletions(-)
>=20
> diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentati=
on/dev-tools/kunit/architecture.rst
> index 8efe792bdcb9..52b1a30c9f89 100644
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
> @@ -75,14 +74,15 @@ with the KUnit test framework.
>  Executor
>  --------
> =20
> -The KUnit executor can list and run built-in KUnit tests on boot.
> +The KUnit executor can list and run built-in KUnit tests on boot
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
> =20
>  .. kernel-figure:: kunit_suitememorydiagram.svg
>  	:alt:	KUnit Suite Memory
> @@ -90,17 +90,18 @@ iterates over the linker section array.
>  	KUnit Suite Memory Diagram
> =20
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
> =20
>  In KUnit tests, some error classes do not affect other tests
>  or parts of the kernel, each KUnit case executes in a separate thread
> -context. For code, see:
> -https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
lib/kunit/try-catch.c?h=3Dv5.15#n58
> +context. For the implememtation details, see ``kunit_try_catch_run()`` f=
unction
> +code in
> +`lib/kunit/try-catch.c <https://git.kernel.org/pub/scm/linux/kernel/git/=
torvalds/linux.git/tree/lib/kunit/try-catch.c?h=3Dv5.15#n58>`_.
> =20
>  Assertion Macros
>  ----------------
> @@ -111,37 +112,36 @@ All expectations/assertions are formatted as:
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
> +You have two options for running KUnit tests: either build the kernel wi=
th KUnit
> +enabled and manually parse the results (see
> +Documentation/dev-tools/kunit/run_manual.rst) or use ``kunit_tool``
> +(see Documentation/dev-tools/kunit/run_wrapper.rst).
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

Seems like you're ignoring my review suggestions from both v1 and v2
(code locations and redundant kunit_tool summary), hence NAK until you addr=
ess
them.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--EY4KXZ7eqD8LDJOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY00f9AAKCRD2uYlJVVFO
owc1AQDWTYT2DMbm74SVnn8XCVjnQ8vz+q1vXx8amO9uf1kZyAEAh0XlxHs8C+NM
I0A9yvFsnyC+ZtSGiOcqwnj63TPohwY=
=mNlc
-----END PGP SIGNATURE-----

--EY4KXZ7eqD8LDJOn--
