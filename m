Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B550846FA5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 06:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbhLJFcN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 00:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbhLJFcN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 00:32:13 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0925C061353
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 21:28:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y17-20020a2586d1000000b005f6596e8760so14747607ybm.17
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Dec 2021 21:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=dkVq2c/USJFTEn84w7rBqjnzFqKUFPLBCbWD/rUhLq0=;
        b=qKELGGVfkLR5SXU9Ywccq5sPS5LKnrt6MwN5677ASM2eN6RzWH75oiBdvGg10XppnV
         KZ0KlrE23COYvRFpQSJbpRNZkCIldGePqdfJF+NDC1gtKJiDLjOEL9GiIW0TFlUlzGba
         /FBe+VONxRn3GYNXXfTsByj7tfPueI3e5zlQytjQw1mbb4QhTyG+sGP8Wu8zuC5MBkp3
         Zx/PVUNtRbbWS+Hj6FYTI3iNnVQTXP6/0V260BcgDpYivlmecQfChAyCGIjnb+1TCAfB
         kn+oC9OA6MxnzIygfpX1Ew/MoaIzUhhvNUT+9exXgVDCEqBV+IwvfVO3GWAPJ13c77zD
         f0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=dkVq2c/USJFTEn84w7rBqjnzFqKUFPLBCbWD/rUhLq0=;
        b=HaKh7VJUKahKUiiCX+z7M06oBG6HEhJieUpdPDWpc+JSuNRVc0+1FDCz1Apdj9kZ3s
         GbLkP8ts3BbvhwfdcklQ/Z/MlSdsg/fhMbju5SwC/zQnW1hT8dNmknrpgp/i6RovMZAc
         QVuAXDidNGpoAeyht4vXeJbKP4BBSSxD6WUGdLV1m3GfKrYRYVYsh7tpqhYbGBD1e9g3
         DSHeTrgpbmPjk4fvEjZgQ/YyDgiSMHT2l8O4VgnW2m62wQSna7xBmrxjEPjSjdt6przM
         zYzjhhdNroOEHPAc/AwqzbkAVoMq7aXBpSlvAKH05KQPOI2OHRViuXc9WcZxLq57SNtF
         hViA==
X-Gm-Message-State: AOAM5313AOGlJttJlQipqEEP6ZuDU6aYcHbnVnzgAZILcQFNeor9ZPor
        C7cW5Z6yms9QnO9MuzM0FnbW0rA6QmZC7Zk=
X-Google-Smtp-Source: ABdhPJxW448CTqIryUP2I8V9ELMNUDacageyqLoL8qlwcAq8nSoTkPFCp9k1uGIOreK3zElcTGUrKmsts3RH5v8=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a25:8607:: with SMTP id
 y7mr12102129ybk.283.1639114117813; Thu, 09 Dec 2021 21:28:37 -0800 (PST)
Date:   Fri, 10 Dec 2021 05:28:08 +0000
In-Reply-To: <20211210052812.1998578-1-sharinder@google.com>
Message-Id: <20211210052812.1998578-4-sharinder@google.com>
Mime-Version: 1.0
References: <20211210052812.1998578-1-sharinder@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 3/7] Documentation: KUnit: Added KUnit Architecture
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.bird@sony.com, Harinder Singh <sharinder@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Describe the components of KUnit and how the kernel mode parts
interact with kunit_tool.

Signed-off-by: Harinder Singh <sharinder@google.com>
---
 .../dev-tools/kunit/architecture.rst          | 206 ++++++++++++++++++
 Documentation/dev-tools/kunit/index.rst       |   2 +
 .../kunit/kunit_suitememorydiagram.png        | Bin 0 -> 24174 bytes
 Documentation/dev-tools/kunit/start.rst       |   1 +
 4 files changed, 209 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/architecture.rst
 create mode 100644 Documentation/dev-tools/kunit/kunit_suitememorydiagram.=
png

diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentation=
/dev-tools/kunit/architecture.rst
new file mode 100644
index 000000000000..ad6744001990
--- /dev/null
+++ b/Documentation/dev-tools/kunit/architecture.rst
@@ -0,0 +1,206 @@
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
+https://elixir.bootlin.com/linux/latest/source/include/kunit/test.h#L145
+
+It includes:
+
+- ``run_case``: the function implementing the actual test case.
+- ``name``: the test case name.
+- ``generate_params``: the parameterized tests generator function. This
+  is optional for non-parameterized tests.
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
+https://elixir.bootlin.com/linux/v5.12/source/include/asm-generic/vmlinux.=
lds.h#L918.
+The linker section consists of an array of pointers to
+``struct kunit_suite``, and is populated by the ``kunit_test_suites()``
+macro. To run all tests compiled into the kernel, the KUnit executor
+iterates over the linker section array.
+
+.. kernel-figure:: kunit_suitememorydiagram.png
+	:alt:	KUnit Suite Memory
+
+	KUnit Suite Memory Diagram
+
+On the kernel boot, the KUnit executor uses the start and end addresses
+of this section to iterate over and run all tests. For code, see:
+https://elixir.bootlin.com/linux/latest/source/lib/kunit/executor.c
+
+When built as a module, the ``kunit_test_suites()`` macro defines a
+``module_init()`` function, which runs all the tests in the compilation
+unit instead of utilizing the executor.
+
+In KUnit tests, some error classes do not affect other tests
+or parts of the kernel, each KUnit case executes in a separate thread
+context. For code, see:
+https://elixir.bootlin.com/linux/latest/source/lib/kunit/try-catch.c#L58
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
+https://elixir.bootlin.com/linux/v5.12/source/include/kunit/test.h#L1783
+
+
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
diff --git a/Documentation/dev-tools/kunit/kunit_suitememorydiagram.png b/D=
ocumentation/dev-tools/kunit/kunit_suitememorydiagram.png
new file mode 100644
index 0000000000000000000000000000000000000000..a1aa7c3b0f63edfea83eb1cef3e=
2257b47b5ca7b
GIT binary patch
literal 24174
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

literal 0
HcmV?d00001

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

