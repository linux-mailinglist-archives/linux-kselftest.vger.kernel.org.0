Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A76C5FA285
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Oct 2022 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJJRO1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Oct 2022 13:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJJRO0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Oct 2022 13:14:26 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C146CF61
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Oct 2022 10:14:24 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id b11-20020a630c0b000000b0044c0bb18323so6554658pgl.17
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Oct 2022 10:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cAwntTht7vvV9oxCOBslJVqo2TXDBUk8x9753HYndRc=;
        b=S5e8XLnL/nAPaZBH4YN/vmrU9/+uwqw+PYHqxhkgSgK/8SJWcE8TesWfseNrwvy9og
         oX+zn0ive0lco6fIeB5IOdAwv86s9jee0G79Kq3Y9w7f+QqAnvXF97KPA8JtO5GVOPqk
         4W9uASCWtSnrlcNHj5SNjWHuzrDaBQp8+6igXdeymP2vxlmnepHYiugbSv7DKF8lRksv
         Cw99O1ympau0w5gcUkV91/6AJjeXEH5fJP3Xc9rr0PAM33EAYTHTrtNgRzWgNEHAc20I
         NR8hm2BwYa4LEyPNydKvBOb+DpdjeRCWU4wS4FTUn+YBRAK2sTQ5yvdCbqyamTFTQlOx
         EniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAwntTht7vvV9oxCOBslJVqo2TXDBUk8x9753HYndRc=;
        b=dzmKOS0fFOmpU4/y6SY7o1iRqHLtfQTowggI4fHnVLPz6okhgsLEsZrESijapTuJUF
         OFhjxKjKYPgNa7kbL2F16aISaALjhLzRIHTXDRTeBnVYFkIOByoDJV8/6G4ltGrdzfJ5
         4/6iz8xaSKjsb//+WKarmvJWICQaQZqxKvi4PpxU/oly8oiAiPeCTzWYTWo6NPwNmknq
         l2PIiGsLLnoVZQk5JTMB1qZFJHTOX6HKU6/mF3DgLByJocY1xcHWdqdqUXgzRhB9a7oa
         bwHL8HlAwzaWFwsa6TqNuePv4QwWfq4O5xBSnK9dAPF5MDYZOCiIOzvgdCqD3OtYs78v
         vUnQ==
X-Gm-Message-State: ACrzQf0SPHZxbXh1JfL8g8OhSNbl/pTLUlSjTsrjrHxOVo/g4T/xLCXs
        TRaIlUnSVXZr7iOy93fDy5K2j1lr5LE574ie
X-Google-Smtp-Source: AMsMyM4/KhCeZt7MtQT4H/0WOAC4s2/9IzaROtYHmADdAx7Z/WCoIWYVYcVoGDz3sO9clOrdZB7edA8dVBw/iMsQ
X-Received: from skazigti.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:411e])
 (user=sadiyakazi job=sendgmr) by 2002:a17:90b:3e81:b0:20a:81b2:bc3 with SMTP
 id rj1-20020a17090b3e8100b0020a81b20bc3mr32327278pjb.60.1665422063531; Mon,
 10 Oct 2022 10:14:23 -0700 (PDT)
Date:   Mon, 10 Oct 2022 17:13:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010171353.1106166-1-sadiyakazi@google.com>
Subject: [PATCH] Documentation: Kunit: Update architecture.rst for minor fixes
From:   Sadiya Kazi <sadiyakazi@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Updated the architecture.rst page with the following changes:
-Add missing article _the_ across the document.
-Reword content across for style and standard.
-Upate all occurrences of Command Line to Command-line across the document.
-Correct grammatical issues, for example - added _it_wherever missing.
-Update all occurrences of _via_ to either use _through_ or _using_.
-Update the text preceding the external links and pushed the full
link to a new line for better readability.
-Reword content under the config command to make it more clear and concise.

Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
---
 .../dev-tools/kunit/architecture.rst          | 86 ++++++++++---------
 1 file changed, 45 insertions(+), 41 deletions(-)

diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentation=
/dev-tools/kunit/architecture.rst
index 8efe792bdcb9..1736c37c33f2 100644
--- a/Documentation/dev-tools/kunit/architecture.rst
+++ b/Documentation/dev-tools/kunit/architecture.rst
@@ -4,16 +4,17 @@
 KUnit Architecture
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-The KUnit architecture can be divided into two parts:
+The KUnit architecture is divided into two parts:
=20
 - `In-Kernel Testing Framework`_
-- `kunit_tool (Command Line Test Harness)`_
+- `kunit_tool (Command-line Test Harness)`_
=20
 In-Kernel Testing Framework
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=20
 The kernel testing library supports KUnit tests written in C using
-KUnit. KUnit tests are kernel code. KUnit does several things:
+KUnit. KUnit tests are written in the kernel code. KUnit performs the foll=
owing
+tasks:
=20
 - Organizes tests
 - Reports test results
@@ -22,8 +23,8 @@ KUnit. KUnit tests are kernel code. KUnit does several th=
ings:
 Test Cases
 ----------
=20
-The fundamental unit in KUnit is the test case. The KUnit test cases are
-grouped into KUnit suites. A KUnit test case is a function with type
+The test case is the fundamental unit in KUnit. KUnit test cases are organ=
ised
+into suites. A KUnit test case is a function with type
 signature ``void (*)(struct kunit *test)``.
 These test case functions are wrapped in a struct called
 struct kunit_case.
@@ -31,8 +32,8 @@ struct kunit_case.
 .. note:
 	``generate_params`` is optional for non-parameterized tests.
=20
-Each KUnit test case gets a ``struct kunit`` context
-object passed to it that tracks a running test. The KUnit assertion
+Each KUnit test case receives a ``struct kunit`` context object that track=
s a
+running test. The KUnit assertion
 macros and other KUnit utilities use the ``struct kunit`` context
 object. As an exception, there are two fields:
=20
@@ -77,11 +78,12 @@ Executor
=20
 The KUnit executor can list and run built-in KUnit tests on boot.
 The Test suites are stored in a linker section
-called ``.kunit_test_suites``. For code, see:
+called ``.kunit_test_suites``. For code, see the following link:
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/in=
clude/asm-generic/vmlinux.lds.h?h=3Dv5.15#n945.
+
 The linker section consists of an array of pointers to
 ``struct kunit_suite``, and is populated by the ``kunit_test_suites()``
-macro. To run all tests compiled into the kernel, the KUnit executor
+macro. To run all the compiled tests into the kernel, the KUnit executor
 iterates over the linker section array.
=20
 .. kernel-figure:: kunit_suitememorydiagram.svg
@@ -90,8 +92,8 @@ iterates over the linker section array.
 	KUnit Suite Memory Diagram
=20
 On the kernel boot, the KUnit executor uses the start and end addresses
-of this section to iterate over and run all tests. For code, see:
-https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/li=
b/kunit/executor.c
+of this section to iterate over and run all tests. For code, see the follo=
wing link:
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/li=
b/kunit/executor.c.
=20
 When built as a module, the ``kunit_test_suites()`` macro defines a
 ``module_init()`` function, which runs all the tests in the compilation
@@ -99,46 +101,48 @@ unit instead of utilizing the executor.
=20
 In KUnit tests, some error classes do not affect other tests
 or parts of the kernel, each KUnit case executes in a separate thread
-context. For code, see:
+context. For code, see the following link:
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/li=
b/kunit/try-catch.c?h=3Dv5.15#n58
=20
 Assertion Macros
 ----------------
=20
-KUnit tests verify state using expectations/assertions.
+KUnit tests verify the state using expectations/assertions.
 All expectations/assertions are formatted as:
 ``KUNIT_{EXPECT|ASSERT}_<op>[_MSG](kunit, property[, message])``
=20
 - ``{EXPECT|ASSERT}`` determines whether the check is an assertion or an
   expectation.
=20
-	- For an expectation, if the check fails, marks the test as failed
+	- For an expectation, if the check fails, it marks the test as failed
 	  and logs the failure.
=20
 	- An assertion, on failure, causes the test case to terminate
 	  immediately.
=20
-		- Assertions call function:
+		- Assertion calls the function:
 		  ``void __noreturn kunit_abort(struct kunit *)``.
=20
-		- ``kunit_abort`` calls function:
+		- ``kunit_abort`` calls the function:
 		  ``void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_ca=
tch)``.
=20
-		- ``kunit_try_catch_throw`` calls function:
+		- ``kunit_try_catch_throw`` calls the function:
 		  ``void kthread_complete_and_exit(struct completion *, long) __noreturn=
;``
 		  and terminates the special thread context.
=20
 - ``<op>`` denotes a check with options: ``TRUE`` (supplied property
-  has the boolean value =E2=80=9Ctrue=E2=80=9D), ``EQ`` (two supplied prop=
erties are
+  has the boolean value "true"), ``EQ`` (two supplied properties are
   equal), ``NOT_ERR_OR_NULL`` (supplied pointer is not null and does not
-  contain an =E2=80=9Cerr=E2=80=9D value).
+  contain an "err" value).
=20
 - ``[_MSG]`` prints a custom message on failure.
=20
 Test Result Reporting
 ---------------------
-KUnit prints test results in KTAP format. KTAP is based on TAP14, see:
+KUnit prints the test results in KTAP format.
+KTAP is based on TAP14, see:
 https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14=
-specification.md.
+
 KTAP (yet to be standardized format) works with KUnit and Kselftest.
 The KUnit executor prints KTAP results to dmesg, and debugfs
 (if configured).
@@ -151,32 +155,32 @@ parameters. The test is invoked multiple times, once =
for each parameter
 value and the parameter is stored in the ``param_value`` field.
 The test case includes a KUNIT_CASE_PARAM() macro that accepts a
 generator function.
-The generator function is passed the previous parameter and returns the ne=
xt
-parameter. It also provides a macro to generate common-case generators bas=
ed on
-arrays.
+The previous parameter is passed to the generator function, which returns
+the next parameter. It also includes a macro for generating array-based
+common-case generators.
=20
-kunit_tool (Command Line Test Harness)
+kunit_tool (Command-line Test Harness)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-kunit_tool is a Python script ``(tools/testing/kunit/kunit.py)``
-that can be used to configure, build, exec, parse and run (runs other
-commands in order) test results. You can either run KUnit tests using
-kunit_tool or can include KUnit in kernel and parse manually.
+``kunit_tool`` is a Python script, found in ``tools/testing/kunit/kunit.py=
``. It
+is used to configure, build, execute, parse, and run (other commands in or=
der)
+test results. You have two options for running KUnit tests: either include=
 KUnit
+in the kernel and parse manually, or use the ``kunit_tool``.
=20
 - ``configure`` command generates the kernel ``.config`` from a
   ``.kunitconfig`` file (and any architecture-specific options).
-  For some architectures, additional config options are specified in the
-  ``qemu_config`` Python script
-  (For example: ``tools/testing/kunit/qemu_configs/powerpc.py``).
+  The Python script available in ``qemu_configs`` folder
+  (for example, ``tools/testing/kunit/qemu configs/powerpc.py``) contains
+  additional configuration options for specific architectures.
   It parses both the existing ``.config`` and the ``.kunitconfig`` files
-  and ensures that ``.config`` is a superset of ``.kunitconfig``.
-  If this is not the case, it will combine the two and run
-  ``make olddefconfig`` to regenerate the ``.config`` file. It then
-  verifies that ``.config`` is now a superset. This checks if all
-  Kconfig dependencies are correctly specified in ``.kunitconfig``.
-  ``kunit_config.py`` includes the parsing Kconfigs code. The code which
-  runs ``make olddefconfig`` is a part of ``kunit_kernel.py``. You can
-  invoke this command via: ``./tools/testing/kunit/kunit.py config`` and
+  to ensure that ``.config`` is a superset of ``.kunitconfig``.
+  If not, it will combine the two and execute ``make olddefconfig`` to reg=
enerate
+  the ``.config`` file. It then checks to see if ``.config`` has become a =
superset.
+  This verifies that all the Kconfig dependencies are correctly specified =
in the file
+  ``.kunitconfig``. The
+  ``kunit_config.py`` script contains the code for parsing Kconfigs. The c=
ode which
+  runs ``make olddefconfig`` is part of the ``kunit_kernel.py`` script. Yo=
u can
+  invoke this command through: ``./tools/testing/kunit/kunit.py config`` a=
nd
   generate a ``.config`` file.
 - ``build`` runs ``make`` on the kernel tree with required options
   (depends on the architecture and some options, for example: build_dir)
@@ -184,8 +188,8 @@ kunit_tool or can include KUnit in kernel and parse man=
ually.
   To build a KUnit kernel from the current ``.config``, you can use the
   ``build`` argument: ``./tools/testing/kunit/kunit.py build``.
 - ``exec`` command executes kernel results either directly (using
-  User-mode Linux configuration), or via an emulator such
-  as QEMU. It reads results from the log via standard
+  User-mode Linux configuration), or through an emulator such
+  as QEMU. It reads results from the log using standard
   output (stdout), and passes them to ``parse`` to be parsed.
   If you already have built a kernel with built-in KUnit tests,
   you can run the kernel and display the test results with the ``exec``
--=20
2.38.0.rc1.362.ged0d419d3c-goog

