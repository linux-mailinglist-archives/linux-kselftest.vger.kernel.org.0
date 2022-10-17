Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FD4600B36
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 11:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiJQJpD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 05:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiJQJpB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 05:45:01 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A385A275EB;
        Mon, 17 Oct 2022 02:44:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f23so10272745plr.6;
        Mon, 17 Oct 2022 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cqiAlzCu1M7hbptqd9bs/f6Fb99fEGoTcNv+wTuLZE4=;
        b=JPaKRjVIVXbCqHtVJ/N1q8seetDSOka/ZyXmWq8HGRbBDRlqx9bh8YOH7q8LCGXzwC
         JPD4ykDLUcVrc7bhxmvMaURds5xYRmaoC3vWyblSz/Wj6HjUvUUW7RFfY03M1va+iyr/
         ID9KoGr1sEIj5XpMUfNbSQnU+qlYiOW5plwbjTOWgGfSWfd7eN/dgz8NTr7p+3tx8RzG
         bIsJmFwPooq07jZwZeqa8QIG8NJ7y3Sg8Jw6BzACa1uUi+TuNwx3xUGYBZB/bOI8SjQ7
         QZRd4KwJZ29wXE4of3TosJ1S3lJ0msTZdfid+IvKKdGrGzIM2PuAVa84ctErgX52Yo46
         Mj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqiAlzCu1M7hbptqd9bs/f6Fb99fEGoTcNv+wTuLZE4=;
        b=1l38rH0/p35E3pFqgEvWUMYcNAP9iu6r4xK3KKZ971uEfznTEj4T2oy7nMVkYrp9eo
         OuAAUnbF4ZehgW+gvYzv8Z+DmxHqXaqmLzAdRgJZPnGaw4rOKPSFp0QR/av5TnPzuB0R
         rCgUVe+FSlDEsijZ3RBQl7rhyONMK/52HO3q9VKKPMiKWnpAbIDqS0QIA1frSWMeoZWT
         o4z6HwkvnrTJDGUOW4Th+sJC2xw6FP67ptcoLm1sOZ4mF8pM9SFK5fsPHPDJw811QbIQ
         cHLH6Cg8mZJrXQHmHP6GDZ3PmEl3ZowiL0IbAMHSAH2gnLa5I20ult+IRqggzVZrL9Gu
         ZElg==
X-Gm-Message-State: ACrzQf3AAVuCTR8fL3Sg6mxE36zSFldzcm/YF7AAsCl8xDLYBDebVJ1M
        LxDRcv+mTDKyjH7FOGA8zlg=
X-Google-Smtp-Source: AMsMyM5K9ZTucg9g7sM+aexaLUQAQRQ4+CZMokPrWXks/084Z00OzBeO7xQ3BIC1Tt45xB4xKa99Zw==
X-Received: by 2002:a17:90a:2849:b0:20a:f3ff:c983 with SMTP id p9-20020a17090a284900b0020af3ffc983mr12893902pjf.198.1665999898978;
        Mon, 17 Oct 2022 02:44:58 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id nh12-20020a17090b364c00b0020dda04df79sm1367693pjb.44.2022.10.17.02.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:44:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C2D56103E64; Mon, 17 Oct 2022 16:38:35 +0700 (WIB)
Date:   Mon, 17 Oct 2022 16:38:35 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: Kunit: Update architecture.rst for
 minor fixes
Message-ID: <Y00im2gq9/c5NzVt@debian.me>
References: <20221017070820.2253501-1-sadiyakazi@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4yZrwh7LMvg4p5Xk"
Content-Disposition: inline
In-Reply-To: <20221017070820.2253501-1-sadiyakazi@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--4yZrwh7LMvg4p5Xk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2022 at 07:08:21AM +0000, Sadiya Kazi wrote:
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
> Please Note: The link in the change log in my previous email was broken a=
s it got
> mixed with the next line. I have resent the email.
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
>=20
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

Seems like you ignore my requested changes from v1 and v2 review (code
location link and redundant kunit_tool summary), hence NAK until you
have addressed them.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--4yZrwh7LMvg4p5Xk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY00ilgAKCRD2uYlJVVFO
oz8QAQDop9z/KFT1Sk9UFEslUOjnen6I4kq7NlvfpCBGExyZkgD/YuH4CV2VW3I5
/KZrRArluL1YMiFFOcxsEBadcag4FAc=
=Zjvf
-----END PGP SIGNATURE-----

--4yZrwh7LMvg4p5Xk--
