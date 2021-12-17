Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E36478441
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 05:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhLQEto (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 23:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbhLQEtj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 23:49:39 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB71C06173F
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 20:49:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r18-20020a25ac52000000b005c9047c420bso2606354ybd.4
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 20:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=opHVVXQwq0ris/o3ooVoEDXe3BdvLnJIhZdJVwDqaGk=;
        b=hr3/yoBNmakRjS4h7b1e9GCF5vXDExhWJaI5zj7lNjlUmHX2EKNNJlE4TYmPJaO+qW
         7j4iHg7A2fIjt70I0LUiAH6T3HM7PS+QHTj6sef0wOk6dc68VAhhVz+IUnNUPPcGzqTO
         uXOQEr7mHpGnyI0EZD+XxnkzZtCpKLbiknPcqx6Or1cXw48CK4UHwM/koPDfiys1Seyb
         s3Lh2Bqs3QD+eeYaN2vcYUx/37aWV1zkYMOPAm0Oi0EYqmZljDI4SurJdNnKg99um6d5
         i6FSY2BjSoFxkNdHzxR3fDl86O+iIfN29qw34jd6pnsUckITGAVyRbDsKUmHn3QQT1JL
         oDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=opHVVXQwq0ris/o3ooVoEDXe3BdvLnJIhZdJVwDqaGk=;
        b=Msdj35kGogTpCPA9ZBHpZgNEOcO5QbkZqJCcIbTl93cGy1OzsH83RdPmBrCmCynt+B
         xB/5fU8dm4bHgiRUbx2NTtAyrbhijhgnqq404ZT0fzrY+RolxgdBELq6z1ypc0PwBdLQ
         p2Bi6vxvDOhQko5QIcIaBRGK7xH7za3/VjAErd8HQzEP8Hsx5Yw0Zg0tVd5a0cEhjmY7
         if5ziFSTtQqxe/qbWmxvoAIvlRQ71EIlLcO51hvvRs9gcW/CN8wWUrIMDzOKsajwLEon
         okcVs5VzCsbzhJidEIMd61ZPx9WsKRVVBDFWltDYhLkhuVFnbcZVMp1Sx8Lhgxf3n2sR
         0BWQ==
X-Gm-Message-State: AOAM530sg0UfQJhXk2G4txQUxyHl78pb1OucwQ3cq5RtLP3CYhVfDayY
        VJeGraJd+OkIGdNbJLn4YVsfWUcNprl5gBw=
X-Google-Smtp-Source: ABdhPJwfH0gJkVklzOnzZvA+zdmVuZRwFIUhoemeaf58KDr1WmQ0+3kfvKvqkXQcu8+Ex5fIZRbGTH5MVRZ7Bu8=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a25:ae21:: with SMTP id
 a33mr1948875ybj.569.1639716578594; Thu, 16 Dec 2021 20:49:38 -0800 (PST)
Date:   Fri, 17 Dec 2021 04:49:07 +0000
In-Reply-To: <20211217044911.798817-1-sharinder@google.com>
Message-Id: <20211217044911.798817-4-sharinder@google.com>
Mime-Version: 1.0
References: <20211217044911.798817-1-sharinder@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v6 3/7] Documentation: KUnit: Added KUnit Architecture
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.bird@sony.com, elver@google.com,
        Harinder Singh <sharinder@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Describe the components of KUnit and how the kernel mode parts
interact with kunit_tool.

Signed-off-by: Harinder Singh <sharinder@google.com>
---
 .../dev-tools/kunit/architecture.rst          | 204 ++++++++++++++++++
 Documentation/dev-tools/kunit/index.rst       |   2 +
 .../kunit/kunit_suitememorydiagram.svg        |  81 +++++++
 Documentation/dev-tools/kunit/start.rst       |   1 +
 4 files changed, 288 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/architecture.rst
 create mode 100644 Documentation/dev-tools/kunit/kunit_suitememorydiagram.=
svg

diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentation=
/dev-tools/kunit/architecture.rst
new file mode 100644
index 000000000000..aa2cea821e25
--- /dev/null
+++ b/Documentation/dev-tools/kunit/architecture.rst
@@ -0,0 +1,204 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+KUnit Architecture
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The KUnit architecture can be divided into two parts:
+
+- Kernel testing library
+- kunit_tool (Command line test harness)
+
+In-Kernel Testing Framework
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+The kernel testing library supports KUnit tests written in C using
+KUnit. KUnit tests are kernel code. KUnit does several things:
+
+- Organizes tests
+- Reports test results
+- Provides test utilities
+
+Test Cases
+----------
+
+The fundamental unit in KUnit is the test case. The KUnit test cases are
+grouped into KUnit suites. A KUnit test case is a function with type
+signature ``void (*)(struct kunit *test)``.
+These test case functions are wrapped in a struct called
+``struct kunit_case``. For code, see:
+
+.. kernel-doc:: include/kunit/test.h
+	:identifiers: kunit_case
+
+.. note:
+	``generate_params`` is optional for non-parameterized tests.
+
+Each KUnit test case gets a ``struct kunit`` context
+object passed to it that tracks a running test. The KUnit assertion
+macros and other KUnit utilities use the ``struct kunit`` context
+object. As an exception, there are two fields:
+
+- ``->priv``: The setup functions can use it to store arbitrary test
+  user data.
+
+- ``->param_value``: It contains the parameter value which can be
+  retrieved in the parameterized tests.
+
+Test Suites
+-----------
+
+A KUnit suite includes a collection of test cases. The KUnit suites
+are represented by the ``struct kunit_suite``. For example:
+
+.. code-block:: c
+
+	static struct kunit_case example_test_cases[] =3D {
+		KUNIT_CASE(example_test_foo),
+		KUNIT_CASE(example_test_bar),
+		KUNIT_CASE(example_test_baz),
+		{}
+	};
+
+	static struct kunit_suite example_test_suite =3D {
+		.name =3D "example",
+		.init =3D example_test_init,
+		.exit =3D example_test_exit,
+		.test_cases =3D example_test_cases,
+	};
+	kunit_test_suite(example_test_suite);
+
+In the above example, the test suite ``example_test_suite``, runs the
+test cases ``example_test_foo``, ``example_test_bar``, and
+``example_test_baz``. Before running the test, the ``example_test_init``
+is called and after running the test, ``example_test_exit`` is called.
+The ``kunit_test_suite(example_test_suite)`` registers the test suite
+with the KUnit test framework.
+
+Executor
+--------
+
+The KUnit executor can list and run built-in KUnit tests on boot.
+The Test suites are stored in a linker section
+called ``.kunit_test_suites``. For code, see:
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/in=
clude/asm-generic/vmlinux.lds.h?h=3Dv5.15#n945.
+The linker section consists of an array of pointers to
+``struct kunit_suite``, and is populated by the ``kunit_test_suites()``
+macro. To run all tests compiled into the kernel, the KUnit executor
+iterates over the linker section array.
+
+.. kernel-figure:: kunit_suitememorydiagram.svg
+	:alt:	KUnit Suite Memory
+
+	KUnit Suite Memory Diagram
+
+On the kernel boot, the KUnit executor uses the start and end addresses
+of this section to iterate over and run all tests. For code, see:
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/li=
b/kunit/executor.c
+
+When built as a module, the ``kunit_test_suites()`` macro defines a
+``module_init()`` function, which runs all the tests in the compilation
+unit instead of utilizing the executor.
+
+In KUnit tests, some error classes do not affect other tests
+or parts of the kernel, each KUnit case executes in a separate thread
+context. For code, see:
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/li=
b/kunit/try-catch.c?h=3Dv5.15#n58
+
+Assertion Macros
+----------------
+
+KUnit tests verify state using expectations/assertions.
+All expectations/assertions are formatted as:
+``KUNIT_{EXPECT|ASSERT}_<op>[_MSG](kunit, property[, message])``
+
+- ``{EXPECT|ASSERT}`` determines whether the check is an assertion or an
+  expectation.
+
+	- For an expectation, if the check fails, marks the test as failed
+	  and logs the failure.
+
+	- An assertion, on failure, causes the test case to terminate
+	  immediately.
+
+		- Assertions call function:
+		  ``void __noreturn kunit_abort(struct kunit *)``.
+
+		- ``kunit_abort`` calls function:
+		  ``void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_ca=
tch)``.
+
+		- ``kunit_try_catch_throw`` calls function:
+		  ``void complete_and_exit(struct completion *, long) __noreturn;``
+		  and terminates the special thread context.
+
+- ``<op>`` denotes a check with options: ``TRUE`` (supplied property
+  has the boolean value =E2=80=9Ctrue=E2=80=9D), ``EQ`` (two supplied prop=
erties are
+  equal), ``NOT_ERR_OR_NULL`` (supplied pointer is not null and does not
+  contain an =E2=80=9Cerr=E2=80=9D value).
+
+- ``[_MSG]`` prints a custom message on failure.
+
+Test Result Reporting
+---------------------
+KUnit prints test results in KTAP format. KTAP is based on TAP14, see:
+https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14=
-specification.md.
+KTAP (yet to be standardized format) works with KUnit and Kselftest.
+The KUnit executor prints KTAP results to dmesg, and debugfs
+(if configured).
+
+Parameterized Tests
+-------------------
+
+Each KUnit parameterized test is associated with a collection of
+parameters. The test is invoked multiple times, once for each parameter
+value and the parameter is stored in the ``param_value`` field.
+The test case includes a ``KUNIT_CASE_PARAM()`` macro that accepts a
+generator function.
+The generator function is passed the previous parameter and returns the ne=
xt
+parameter. It also provides a macro to generate common-case generators bas=
ed on
+arrays.
+
+For code, see:
+
+.. kernel-doc:: include/kunit/test.h
+	:identifiers: KUNIT_ARRAY_PARAM
+
+
+kunit_tool (Command Line Test Harness)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+kunit_tool is a Python script ``(tools/testing/kunit/kunit.py)``
+that can be used to configure, build, exec, parse and run (runs other
+commands in order) test results. You can either run KUnit tests using
+kunit_tool or can include KUnit in kernel and parse manually.
+
+- ``configure`` command generates the kernel ``.config`` from a
+  ``.kunitconfig`` file (and any architecture-specific options).
+  For some architectures, additional config options are specified in the
+  ``qemu_config`` Python script
+  (For example: ``tools/testing/kunit/qemu_configs/powerpc.py``).
+  It parses both the existing ``.config`` and the ``.kunitconfig`` files
+  and ensures that ``.config`` is a superset of ``.kunitconfig``.
+  If this is not the case, it will combine the two and run
+  ``make olddefconfig`` to regenerate the ``.config`` file. It then
+  verifies that ``.config`` is now a superset. This checks if all
+  Kconfig dependencies are correctly specified in ``.kunitconfig``.
+  ``kunit_config.py`` includes the parsing Kconfigs code. The code which
+  runs ``make olddefconfig`` is a part of ``kunit_kernel.py``. You can
+  invoke this command via: ``./tools/testing/kunit/kunit.py config`` and
+  generate a ``.config`` file.
+- ``build`` runs ``make`` on the kernel tree with required options
+  (depends on the architecture and some options, for example: build_dir)
+  and reports any errors.
+  To build a KUnit kernel from the current ``.config``, you can use the
+  ``build`` argument: ``./tools/testing/kunit/kunit.py build``.
+- ``exec`` command executes kernel results either directly (using
+  User-mode Linux configuration), or via an emulator such
+  as QEMU. It reads results from the log via standard
+  output (stdout), and passes them to ``parse`` to be parsed.
+  If you already have built a kernel with built-in KUnit tests,
+  you can run the kernel and display the test results with the ``exec``
+  argument: ``./tools/testing/kunit/kunit.py exec``.
+- ``parse`` extracts the KTAP output from a kernel log, parses
+  the test results, and prints a summary. For failed tests, any
+  diagnostic output will be included.
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-to=
ols/kunit/index.rst
index 55d2444b0745..50d3ef9359dd 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -9,6 +9,7 @@ KUnit - Linux Kernel Unit Testing
 	:caption: Contents:
=20
 	start
+	architecture
 	usage
 	kunit-tool
 	api/index
@@ -96,6 +97,7 @@ How do I use it?
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 *   Documentation/dev-tools/kunit/start.rst - for KUnit new users.
+*   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
 *   Documentation/dev-tools/kunit/usage.rst - KUnit features.
 *   Documentation/dev-tools/kunit/tips.rst - best practices with
     examples.
diff --git a/Documentation/dev-tools/kunit/kunit_suitememorydiagram.svg b/D=
ocumentation/dev-tools/kunit/kunit_suitememorydiagram.svg
new file mode 100644
index 000000000000..cf8fddc27500
--- /dev/null
+++ b/Documentation/dev-tools/kunit/kunit_suitememorydiagram.svg
@@ -0,0 +1,81 @@
+<?xml version=3D"1.0" encoding=3D"UTF-8"?>
+<svg width=3D"796.93" height=3D"555.73" version=3D"1.1" viewBox=3D"0 0 796=
.93 555.73" xmlns=3D"http://www.w3.org/2000/svg">
+	<g transform=3D"translate(-13.724 -17.943)">
+		<g fill=3D"#dad4d4" fill-opacity=3D".91765" stroke=3D"#1a1a1a">
+			<rect x=3D"323.56" y=3D"18.443" width=3D"115.75" height=3D"41.331"/>
+			<rect x=3D"323.56" y=3D"463.09" width=3D"115.75" height=3D"41.331"/>
+			<rect x=3D"323.56" y=3D"531.84" width=3D"115.75" height=3D"41.331"/>
+			<rect x=3D"323.56" y=3D"88.931" width=3D"115.75" height=3D"74.231"/>
+		</g>
+		<g>
+			<rect x=3D"323.56" y=3D"421.76" width=3D"115.75" height=3D"41.331" fill=
=3D"#b9dbc6" stroke=3D"#1a1a1a"/>
+			<text x=3D"328.00888" y=3D"446.61826" fill=3D"#000000" font-family=3D"s=
ans-serif" font-size=3D"16px" style=3D"line-height:1.25" xml:space=3D"prese=
rve"><tspan x=3D"328.00888" y=3D"446.61826" font-family=3D"monospace" font-=
size=3D"16px">kunit_suite</tspan></text>
+		</g>
+		<g transform=3D"translate(0 -258.6)">
+			<rect x=3D"323.56" y=3D"421.76" width=3D"115.75" height=3D"41.331" fill=
=3D"#b9dbc6" stroke=3D"#1a1a1a"/>
+			<text x=3D"328.00888" y=3D"446.61826" fill=3D"#000000" font-family=3D"s=
ans-serif" font-size=3D"16px" style=3D"line-height:1.25" xml:space=3D"prese=
rve"><tspan x=3D"328.00888" y=3D"446.61826" font-family=3D"monospace" font-=
size=3D"16px">kunit_suite</tspan></text>
+		</g>
+		<g transform=3D"translate(0 -217.27)">
+			<rect x=3D"323.56" y=3D"421.76" width=3D"115.75" height=3D"41.331" fill=
=3D"#b9dbc6" stroke=3D"#1a1a1a"/>
+			<text x=3D"328.00888" y=3D"446.61826" fill=3D"#000000" font-family=3D"s=
ans-serif" font-size=3D"16px" style=3D"line-height:1.25" xml:space=3D"prese=
rve"><tspan x=3D"328.00888" y=3D"446.61826" font-family=3D"monospace" font-=
size=3D"16px">kunit_suite</tspan></text>
+		</g>
+		<g transform=3D"translate(0 -175.94)">
+			<rect x=3D"323.56" y=3D"421.76" width=3D"115.75" height=3D"41.331" fill=
=3D"#b9dbc6" stroke=3D"#1a1a1a"/>
+			<text x=3D"328.00888" y=3D"446.61826" fill=3D"#000000" font-family=3D"s=
ans-serif" font-size=3D"16px" style=3D"line-height:1.25" xml:space=3D"prese=
rve"><tspan x=3D"328.00888" y=3D"446.61826" font-family=3D"monospace" font-=
size=3D"16px">kunit_suite</tspan></text>
+		</g>
+		<g transform=3D"translate(0 -134.61)">
+			<rect x=3D"323.56" y=3D"421.76" width=3D"115.75" height=3D"41.331" fill=
=3D"#b9dbc6" stroke=3D"#1a1a1a"/>
+			<text x=3D"328.00888" y=3D"446.61826" fill=3D"#000000" font-family=3D"s=
ans-serif" font-size=3D"16px" style=3D"line-height:1.25" xml:space=3D"prese=
rve"><tspan x=3D"328.00888" y=3D"446.61826" font-family=3D"monospace" font-=
size=3D"16px">kunit_suite</tspan></text>
+		</g>
+		<g transform=3D"translate(0 -41.331)">
+			<rect x=3D"323.56" y=3D"421.76" width=3D"115.75" height=3D"41.331" fill=
=3D"#b9dbc6" stroke=3D"#1a1a1a"/>
+			<text x=3D"328.00888" y=3D"446.61826" fill=3D"#000000" font-family=3D"s=
ans-serif" font-size=3D"16px" style=3D"line-height:1.25" xml:space=3D"prese=
rve"><tspan x=3D"328.00888" y=3D"446.61826" font-family=3D"monospace" font-=
size=3D"16px">kunit_suite</tspan></text>
+		</g>
+		<g transform=3D"translate(3.4459e-5 -.71088)">
+			<rect x=3D"502.19" y=3D"143.16" width=3D"201.13" height=3D"41.331" fill=
=3D"#dad4d4" fill-opacity=3D".91765" stroke=3D"#1a1a1a"/>
+			<text x=3D"512.02319" y=3D"168.02026" font-family=3D"sans-serif" font-s=
ize=3D"16px" style=3D"line-height:1.25" xml:space=3D"preserve"><tspan x=3D"=
512.02319" y=3D"168.02026" font-family=3D"monospace">_kunit_suites_start</t=
span></text>
+		</g>
+		<g transform=3D"translate(3.0518e-5 -3.1753)">
+			<rect x=3D"502.19" y=3D"445.69" width=3D"201.13" height=3D"41.331" fill=
=3D"#dad4d4" fill-opacity=3D".91765" stroke=3D"#1a1a1a"/>
+			<text x=3D"521.61694" y=3D"470.54846" font-family=3D"sans-serif" font-s=
ize=3D"16px" style=3D"line-height:1.25" xml:space=3D"preserve"><tspan x=3D"=
521.61694" y=3D"470.54846" font-family=3D"monospace">_kunit_suites_end</tsp=
an></text>
+		</g>
+		<rect x=3D"14.224" y=3D"277.78" width=3D"134.47" height=3D"41.331" fill=
=3D"#dad4d4" fill-opacity=3D".91765" stroke=3D"#1a1a1a"/>
+		<text x=3D"32.062176" y=3D"304.41287" font-family=3D"sans-serif" font-si=
ze=3D"16px" style=3D"line-height:1.25" xml:space=3D"preserve"><tspan x=3D"3=
2.062176" y=3D"304.41287" font-family=3D"monospace">.init.data</tspan></tex=
t>
+		<g transform=3D"translate(217.98 145.12)" stroke=3D"#1a1a1a">
+			<circle cx=3D"149.97" cy=3D"373.01" r=3D"3.4012"/>
+			<circle cx=3D"163.46" cy=3D"373.01" r=3D"3.4012"/>
+			<circle cx=3D"176.95" cy=3D"373.01" r=3D"3.4012"/>
+		</g>
+		<g transform=3D"translate(217.98 -298.66)" stroke=3D"#1a1a1a">
+			<circle cx=3D"149.97" cy=3D"373.01" r=3D"3.4012"/>
+			<circle cx=3D"163.46" cy=3D"373.01" r=3D"3.4012"/>
+			<circle cx=3D"176.95" cy=3D"373.01" r=3D"3.4012"/>
+		</g>
+		<g stroke=3D"#1a1a1a">
+			<rect x=3D"323.56" y=3D"328.49" width=3D"115.75" height=3D"51.549" fill=
=3D"#b9dbc6"/>
+			<g transform=3D"translate(217.98 -18.75)">
+				<circle cx=3D"149.97" cy=3D"373.01" r=3D"3.4012"/>
+				<circle cx=3D"163.46" cy=3D"373.01" r=3D"3.4012"/>
+				<circle cx=3D"176.95" cy=3D"373.01" r=3D"3.4012"/>
+			</g>
+		</g>
+		<g transform=3D"scale(1.0933 .9147)" stroke-width=3D"32.937" aria-label=
=3D"{">
+			<path d=3D"m275.49 545.57c-35.836-8.432-47.43-24.769-47.957-64.821v-88.=
536c-0.527-44.795-10.54-57.97-49.538-67.456 38.998-10.013 49.011-23.715 49.=
538-67.983v-88.536c0.527-40.052 12.121-56.389 47.957-64.821v-5.797c-65.348 =
0-85.901 17.391-86.955 73.253v93.806c-0.527 36.89-10.013 50.065-44.795 59.5=
51 34.782 10.013 44.268 23.188 44.795 60.078v93.279c1.581 56.389 21.607 73.=
78 86.955 73.78z"/>
+		</g>
+		<g transform=3D"scale(1.1071 .90325)" stroke-width=3D"14.44" aria-label=
=3D"{">
+			<path d=3D"m461.46 443.55c-15.711-3.6967-20.794-10.859-21.025-28.418v-3=
8.815c-0.23104-19.639-4.6209-25.415-21.718-29.574 17.097-4.3898 21.487-10.3=
97 21.718-29.805v-38.815c0.23105-17.559 5.314-24.722 21.025-28.418v-2.5415c=
-28.649 0-37.66 7.6244-38.122 32.115v41.126c-0.23105 16.173-4.3898 21.949-1=
9.639 26.108 15.249 4.3898 19.408 10.166 19.639 26.339v40.895c0.69313 24.72=
2 9.4728 32.346 38.122 32.346z"/>
+		</g>
+		<path d=3D"m449.55 161.84v2.5h49.504v-2.5z" color=3D"#000000" style=3D"-=
inkscape-stroke:none"/>
+		<g fill-rule=3D"evenodd">
+			<path d=3D"m443.78 163.09 8.65-5v10z" color=3D"#000000" stroke-width=3D=
"1pt" style=3D"-inkscape-stroke:none"/>
+			<path d=3D"m453.1 156.94-10.648 6.1543 0.99804 0.57812 9.6504 5.5781zm-=
1.334 2.3125v7.6856l-6.6504-3.8438z" color=3D"#000000" style=3D"-inkscape-s=
troke:none"/>
+		</g>
+		<path d=3D"m449.55 461.91v2.5h49.504v-2.5z" color=3D"#000000" style=3D"-=
inkscape-stroke:none"/>
+		<g fill-rule=3D"evenodd">
+			<path d=3D"m443.78 463.16 8.65-5v10z" color=3D"#000000" stroke-width=3D=
"1pt" style=3D"-inkscape-stroke:none"/>
+			<path d=3D"m453.1 457-10.648 6.1562 0.99804 0.57617 9.6504 5.5781zm-1.3=
34 2.3125v7.6856l-6.6504-3.8438z" color=3D"#000000" style=3D"-inkscape-stro=
ke:none"/>
+		</g>
+		<rect x=3D"515.64" y=3D"223.9" width=3D"294.52" height=3D"178.49" fill=
=3D"#dad4d4" fill-opacity=3D".91765" stroke=3D"#1a1a1a"/>
+		<text x=3D"523.33319" y=3D"262.52542" font-family=3D"monospace" font-siz=
e=3D"14.667px" style=3D"line-height:1.25" xml:space=3D"preserve"><tspan x=
=3D"523.33319" y=3D"262.52542"><tspan fill=3D"#008000" font-family=3D"monos=
pace" font-size=3D"14.667px" font-weight=3D"bold">struct</tspan> kunit_suit=
e {</tspan><tspan x=3D"523.33319" y=3D"280.8588"><tspan fill=3D"#008000" fo=
nt-family=3D"monospace" font-size=3D"14.667px" font-weight=3D"bold">  const=
 char</tspan> name[<tspan fill=3D"#ff00ff" font-size=3D"14.667px">256</tspa=
n>];</tspan><tspan x=3D"523.33319" y=3D"299.19217">  <tspan fill=3D"#008000=
" font-family=3D"monospace" font-size=3D"14.667px" font-weight=3D"bold">int=
</tspan> (*init)(<tspan fill=3D"#008000" font-family=3D"monospace" font-siz=
e=3D"14.667px" font-weight=3D"bold">struct</tspan> kunit *);</tspan><tspan =
x=3D"523.33319" y=3D"317.52554">  <tspan fill=3D"#008000" font-family=3D"mo=
nospace" font-size=3D"14.667px" font-weight=3D"bold">void</tspan> (*exit)(<=
tspan fill=3D"#008000" font-family=3D"monospace" font-size=3D"14.667px" fon=
t-weight=3D"bold">struct</tspan> kunit *);</tspan><tspan x=3D"523.33319" y=
=3D"335.85892">  <tspan fill=3D"#008000" font-family=3D"monospace" font-siz=
e=3D"14.667px" font-weight=3D"bold">struct</tspan> kunit_case *test_cases;<=
/tspan><tspan x=3D"523.33319" y=3D"354.19229">  ...</tspan><tspan x=3D"523.=
33319" y=3D"372.52567">};</tspan></text>
+	</g>
+</svg>
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-to=
ols/kunit/start.rst
index 55f8df1abd40..5dd2c88fa2bd 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -240,6 +240,7 @@ Congrats! You just wrote your first KUnit test.
 Next Steps
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
+*   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
 *   Documentation/dev-tools/kunit/usage.rst - KUnit features.
 *   Documentation/dev-tools/kunit/tips.rst - best practices with
     examples.
--=20
2.34.1.173.g76aa8bc2d0-goog

