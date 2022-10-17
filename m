Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D0F600721
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 08:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJQG4w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 02:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiJQG4W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 02:56:22 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64EE389C
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Oct 2022 23:56:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36144a71051so103034207b3.19
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Oct 2022 23:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mwXkiJpyXszOYeaS5kG3VAZ2YoiwGwYHcpmiHrFrcts=;
        b=roDFn8omU7wnmMudjnSUOiAGszxw+QGhON7IWQRPOaHfdtnPmUE8nNQhQxmOg0DEf8
         bQm3KSB/rQ9xd4jdPxHbckgm8C6oUTKZjbgWoBtEu+BE7S3sB/LslVQ5gUFlPWCe02ZK
         JueN75mvsRblKc7vyLybbNFSNlAtbBsIuqRrbcASeRsjdUMPfLJIAIDvgzAWu1VJsezM
         77oOUX5k1N8dhzj1/Y0xDW4UGCqQsQabUwUvXEoQqnIQUCsaAFFvRsU2sLIo+RTMuZ/s
         3sWRmcFpijCHYJTsDSZ+HbydBmZ+T+XXgFil8Bb9mTof+j4+6YT0E9hq5MB45mftQR2u
         j0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwXkiJpyXszOYeaS5kG3VAZ2YoiwGwYHcpmiHrFrcts=;
        b=HA47SlewVtq+75Jk6uB/NZnLR1As+wtllGcgBCClXJDZba/RWr8uJes/DKh+bY8KyC
         pJjId6UjRcuPbz7jxWFVOe1IUrRwoWRwt+Lc3RnH6pAGk6wIZhR/w2aDaTSPs5Vf6W/M
         L06vA14RQkdNEFCwdNl8ZhRNQ+N14ltZ/9fu+edfie+3mH6O2v3RGssDZ7G0yO9ErSsY
         So/bi0rt50kPSNvCdqKnLd+VyIMJMHTUmU8iPkyAvg34mlWK8I/jsMpDrJAyOfxm5+Hf
         KvE98UBPtf24Cu22Oh5WzY2EM3XZO5qaFVolF/8D/YvBGxp1p6IA0AvWJEtsPnt8pgps
         BLZw==
X-Gm-Message-State: ACrzQf22cwwPHv8pBPg3U0fsTSy19Mjt5uY/aOrFmL3OYsGj5UJBU4E2
        94gqCDZGishAaB4hfQkuP144A7scHn5geia5
X-Google-Smtp-Source: AMsMyM4Ng4pCcCrVTiu96rzWmaxFC5Di/VjnWfc6zxEpsP7MFY97oiAeeQ/WR982LUEM8D0pmlaoMUiVZDcvDYRe
X-Received: from skazigti.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:411e])
 (user=sadiyakazi job=sendgmr) by 2002:a25:9d0a:0:b0:6bc:2641:19d4 with SMTP
 id i10-20020a259d0a000000b006bc264119d4mr7781133ybp.388.1665989767169; Sun,
 16 Oct 2022 23:56:07 -0700 (PDT)
Date:   Mon, 17 Oct 2022 06:54:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221017065452.2250273-1-sadiyakazi@google.com>
Subject: [PATCH v3] Documentation: Kunit: Update architecture.rst for minor fixes
From:   Sadiya Kazi <sadiyakazi@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net, bagasdotme@gmail.com
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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
-Update all occurrences of Command Line to Command-line
 across the document.
-Correct grammatical issues, for example,
 added _it_wherever missing.
-Update all occurrences of =E2=80=9Cvia" to either use
 =E2=80=9Cthrough=E2=80=9D or =E2=80=9Cusing=E2=80=9D.
-Update the text preceding the external links and pushed the full
 link to a new line for better readability.
-Reword content under the config command to make it more clear and concise.

Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
---

Thank you Bagas for your detailed comments.=20
I think the current commit message does convey the right message as it is n=
ot a complete rewrite, hence retained it.=20
Also since we talk about the two parts of the architecture, I have retained=
 the it as 'kunit_tool (Command-line Test Harness)' instead of 'Running Tes=
ts Options'.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20221013080545.1552573-1-sadiyakazi=
@google.com/
-Updated the link descriptions as per Bagas=E2=80=99s feedback
-Reworded content talking about options to run tests and added links as per=
 Bagas=E2=80=99s feedback

Best Regards,
Sadiya Kazi
---
 .../dev-tools/kunit/architecture.rst          | 118 +++++++++---------
 1 file changed, 60 insertions(+), 58 deletions(-)

diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentation=
/dev-tools/kunit/architecture.rst
index 8efe792bdcb9..52b1a30c9f89 100644
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
+KUnit. These KUnit tests are kernel code. KUnit performs the following
+tasks:
=20
 - Organizes tests
 - Reports test results
@@ -22,19 +23,17 @@ KUnit. KUnit tests are kernel code. KUnit does several =
things:
 Test Cases
 ----------
=20
-The fundamental unit in KUnit is the test case. The KUnit test cases are
-grouped into KUnit suites. A KUnit test case is a function with type
-signature ``void (*)(struct kunit *test)``.
-These test case functions are wrapped in a struct called
-struct kunit_case.
+The test case is the fundamental unit in KUnit. KUnit test cases are organ=
ised
+into suites. A KUnit test case is a function with type signature
+``void (*)(struct kunit *test)``. These test case functions are wrapped in=
 a
+struct called struct kunit_case.
=20
 .. note:
 	``generate_params`` is optional for non-parameterized tests.
=20
-Each KUnit test case gets a ``struct kunit`` context
-object passed to it that tracks a running test. The KUnit assertion
-macros and other KUnit utilities use the ``struct kunit`` context
-object. As an exception, there are two fields:
+Each KUnit test case receives a ``struct kunit`` context object that track=
s a
+running test. The KUnit assertion macros and other KUnit utilities use the
+``struct kunit`` context object. As an exception, there are two fields:
=20
 - ``->priv``: The setup functions can use it to store arbitrary test
   user data.
@@ -75,14 +74,15 @@ with the KUnit test framework.
 Executor
 --------
=20
-The KUnit executor can list and run built-in KUnit tests on boot.
+The KUnit executor can list and run built-in KUnit tests on boot
 The Test suites are stored in a linker section
-called ``.kunit_test_suites``. For code, see:
-https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/in=
clude/asm-generic/vmlinux.lds.h?h=3Dv5.15#n945.
+called ``.kunit_test_suites``. For the code, see ``KUNIT_TABLE()`` macro
+definition in
+`include/asm-generic/vmlinux.lds.h <https://git.kernel.org/pub/scm/linux/k=
ernel/git/torvalds/linux.git/tree/include/asm-generic/vmlinux.lds.h?h=3Dv6.=
0#n950>`_.
 The linker section consists of an array of pointers to
 ``struct kunit_suite``, and is populated by the ``kunit_test_suites()``
-macro. To run all tests compiled into the kernel, the KUnit executor
-iterates over the linker section array.
+macro. The KUnit executor iterates over the linker section array in order =
to
+run all the tests that are compiled into the kernel.
=20
 .. kernel-figure:: kunit_suitememorydiagram.svg
 	:alt:	KUnit Suite Memory
@@ -90,17 +90,18 @@ iterates over the linker section array.
 	KUnit Suite Memory Diagram
=20
 On the kernel boot, the KUnit executor uses the start and end addresses
-of this section to iterate over and run all tests. For code, see:
-https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/li=
b/kunit/executor.c
-
+of this section to iterate over and run all tests. For the implementation =
of the
+executor, see
+`lib/kunit/executor.c <https://git.kernel.org/pub/scm/linux/kernel/git/tor=
valds/linux.git/tree/lib/kunit/executor.c>`_.
 When built as a module, the ``kunit_test_suites()`` macro defines a
 ``module_init()`` function, which runs all the tests in the compilation
 unit instead of utilizing the executor.
=20
 In KUnit tests, some error classes do not affect other tests
 or parts of the kernel, each KUnit case executes in a separate thread
-context. For code, see:
-https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/li=
b/kunit/try-catch.c?h=3Dv5.15#n58
+context. For the implememtation details, see ``kunit_try_catch_run()`` fun=
ction
+code in
+`lib/kunit/try-catch.c <https://git.kernel.org/pub/scm/linux/kernel/git/to=
rvalds/linux.git/tree/lib/kunit/try-catch.c?h=3Dv5.15#n58>`_.
=20
 Assertion Macros
 ----------------
@@ -111,37 +112,36 @@ All expectations/assertions are formatted as:
=20
 - ``{EXPECT|ASSERT}`` determines whether the check is an assertion or an
   expectation.
+  In the event of a failure, the testing flow differs as follows:
=20
-	- For an expectation, if the check fails, marks the test as failed
-	  and logs the failure.
+	- For expectations, the test is marked as failed and the failure is logge=
d.
=20
-	- An assertion, on failure, causes the test case to terminate
-	  immediately.
+	- Failing assertions, on the other hand, result in the test case being
+	  terminated immediately.
=20
-		- Assertions call function:
+		- Assertions call the function:
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
-https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14=
-specification.md.
-KTAP (yet to be standardized format) works with KUnit and Kselftest.
-The KUnit executor prints KTAP results to dmesg, and debugfs
-(if configured).
+KUnit prints the test results in KTAP format. KTAP is based on TAP14, see
+Documentation/dev-tools/ktap.rst.
+KTAP works with KUnit and Kselftest. The KUnit executor prints KTAP result=
s to
+dmesg, and debugfs (if configured).
=20
 Parameterized Tests
 -------------------
@@ -150,33 +150,35 @@ Each KUnit parameterized test is associated with a co=
llection of
 parameters. The test is invoked multiple times, once for each parameter
 value and the parameter is stored in the ``param_value`` field.
 The test case includes a KUNIT_CASE_PARAM() macro that accepts a
-generator function.
-The generator function is passed the previous parameter and returns the ne=
xt
-parameter. It also provides a macro to generate common-case generators bas=
ed on
-arrays.
+generator function. The generator function is passed the previous paramete=
r
+and returns the next parameter. It also includes a macro for generating
+array-based common-case generators.
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
+is used to configure, build, execute, parse test results and run all of th=
e
+previous commands in correct order (i.e., configure, build, execute and pa=
rse).
+You have two options for running KUnit tests: either build the kernel with=
 KUnit
+enabled and manually parse the results (see
+Documentation/dev-tools/kunit/run_manual.rst) or use ``kunit_tool``
+(see Documentation/dev-tools/kunit/run_wrapper.rst).
=20
 - ``configure`` command generates the kernel ``.config`` from a
   ``.kunitconfig`` file (and any architecture-specific options).
-  For some architectures, additional config options are specified in the
-  ``qemu_config`` Python script
-  (For example: ``tools/testing/kunit/qemu_configs/powerpc.py``).
+  The Python scripts available in ``qemu_configs`` folder
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
+  If not, it will combine the two and run ``make olddefconfig`` to regener=
ate
+  the ``.config`` file. It then checks to see if ``.config`` has become a =
superset.
+  This verifies that all the Kconfig dependencies are correctly specified =
in the
+  file ``.kunitconfig``. The ``kunit_config.py`` script contains the code =
for parsing
+  Kconfigs. The code which runs ``make olddefconfig`` is part of the
+  ``kunit_kernel.py`` script. You can invoke this command through:
+  ``./tools/testing/kunit/kunit.py config`` and
   generate a ``.config`` file.
 - ``build`` runs ``make`` on the kernel tree with required options
   (depends on the architecture and some options, for example: build_dir)
@@ -184,8 +186,8 @@ kunit_tool or can include KUnit in kernel and parse man=
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
2.38.0.413.g74048e4d9e-goog

