Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3F047841C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 05:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhLQEiH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 23:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhLQEiC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 23:38:02 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1854C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 20:38:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so2529652ybe.8
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 20:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=K24+5mXsl0tqDSvX4ae3NiIhxWkMNrm1J2fCengDhvg=;
        b=V0w9l5S/XUm9lh3XahP/yUKAfho+70crDg/SbtQAsQZ3X176LBgkZyLkO2yvFzjUvU
         wZu+ixfocHpPY4bOW2gLVDwQT8JrKfSgy7wjujqd33ZSJVpAnEZJDaaOWgwOIS8vg+V9
         k1GccRV27efOaJkUSbNv8gEMYf5OTg6/7F1U2/uWijvS68GXhHTeU3NxDY9ZOcusz28v
         4Dz3R4cxQC7A06co/+mKtEXg0GggqKvCxuxwpWXL6KbODOkXZhR3z7DLI/td3aU+7nm1
         AnbBxewLLJGq2ptUuzdldvzVwFLrN4ICKQrLLtflcQzGpx4ovRQB9Qg4P1PJTdEL3fLi
         ZPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=K24+5mXsl0tqDSvX4ae3NiIhxWkMNrm1J2fCengDhvg=;
        b=3Pm/Dwkp9zZYqjKNUDy8iHfvHs3AW23qVEYGzWrncUugnkmoWYTWm7fqfSfNPioIXw
         7dxjTTX5pppmZvldFFR9B0IH615MfvMqUFdy6WYUBnjWLcki1QMN2fO5FqmYJL1HGmFY
         KMQrW/G74TJb35ob+KzGSq/pvnboqby5NnUSnKLpU9l6N5UywVoWySaUfwkCj/g0sAab
         s8WEB9pwx+lSw6ABciuOjxECTeXwND/7jmqSghViaIpzzSAI6RRo60RmOqiocYLjR9tg
         DhE/KnH64L4U0i1L1EJjiltwEXL1frLWUcWtzN9BN/quZzX6m20YVBomv6RW/iyKs8hF
         Hu3Q==
X-Gm-Message-State: AOAM530Oz3r8we1yeCmrITEqDafx73U5Mu2idh9bUF88Kg98y962BNMZ
        rvFdBvFTimp3RvL0zAOKClB6YkOSbCNljCg=
X-Google-Smtp-Source: ABdhPJzqb//QMYNzU3s7+A1AheVZ9d9MNeiHYI3pxRtbg5y1pKJfXtJdinP3EdbvXpG8i54PHGKibmXfxMeTbAA=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a25:7ec1:: with SMTP id
 z184mr1919789ybc.103.1639715881010; Thu, 16 Dec 2021 20:38:01 -0800 (PST)
Date:   Fri, 17 Dec 2021 04:37:12 +0000
In-Reply-To: <20211217043716.794289-1-sharinder@google.com>
Message-Id: <20211217043716.794289-4-sharinder@google.com>
Mime-Version: 1.0
References: <20211217043716.794289-1-sharinder@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v5 3/7] Documentation: KUnit: Added KUnit Architecture
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
 Documentation/dev-tools/kunit/start.rst       |   1 +
 3 files changed, 207 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/architecture.rst

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

