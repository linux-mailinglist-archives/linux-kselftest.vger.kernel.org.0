Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3850E19B4EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Apr 2020 19:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbgDARyl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Apr 2020 13:54:41 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42258 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732331AbgDARyk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Apr 2020 13:54:40 -0400
Received: by mail-il1-f193.google.com with SMTP id f16so823577ilj.9
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Apr 2020 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=sk0xFcFxTYfHYi1Iq9Zz9JID/tROtSUHOjdZ5FBNB/I=;
        b=W5os0M1nA+AtkZh4fR/Y2zQcVsRy3XHnIGZ5k7a0G0nJUH+/4n4v54epMTATs+fECX
         VcJ0wCc6pyyhKDhPWWlnIF4HwYfopaLR3dcUiPXHy1RK6gg9lkVz5QV6AJFegEF4/QNw
         FMEL9bONjizzMR6aJwKWu9WpN7MD1g5MF2/j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=sk0xFcFxTYfHYi1Iq9Zz9JID/tROtSUHOjdZ5FBNB/I=;
        b=lySKO+JLUzQp1qnFefJ5vziY9+luX4ocsziCwjjDFwEKSN6H6pI9Egrk+wE+WedrY7
         zYjhcwX+2XhHXINnbSt1oGVO6knwQXO9Tfpep62zEVn2GCefzO/lcRV4gyiNdyGHIwWh
         St6I6dXKx7ZCI/K/O7gegQXb/ueyoeMbyfNnr85eq9njf3AcEEJfWOP1xvez897GDY+y
         et1EpJMD0Tyn79990Lt71qDKgU3BUMP+uCZe6/lDJmb2NDhxjSok+eJ/+7d0kbPl7xqj
         s8Tuf1ctgQ/14CudxhVRdkrdI5gPzVqxKZcpA/gIF/bDTMuNQ8ENHtDldy0JkvHo5OJF
         lI5A==
X-Gm-Message-State: ANhLgQ0eUaUuwyIwYiuvXSrW4wKLLgffozOJejs+A1ByHUAT2tBnUO9J
        iWJ/Ym0pZncX8BZyAfFg/7OdJ3O9tfQ=
X-Google-Smtp-Source: ADFU+vtObFHlcJWX8Z5jYHnFm/9hnwhYJabFtrNoIX5+heq+Iu/fo1C1iAkL/xUF4l++2HaTrh3PCQ==
X-Received: by 2002:a92:cb49:: with SMTP id f9mr22333625ilq.193.1585763678491;
        Wed, 01 Apr 2020 10:54:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k1sm769531iob.48.2020.04.01.10.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 10:54:37 -0700 (PDT)
To:     torvalds@linux-foundation.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest-kunit update for Linux 5.7-rc1
Message-ID: <db495f50-087f-695c-67d8-22683cce0a77@linuxfoundation.org>
Date:   Wed, 1 Apr 2020 11:54:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2A68A3C7E86FE0C0D99BB039"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------2A68A3C7E86FE0C0D99BB039
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest Kunit update for Linux 5.7-rc1.

This kunit update for Linux-5.7-rc1 consists of:

- debugfs support for displaying kunit test suite results; this is
   especially useful for module-loaded tests to allow disentangling of
   test result display from other dmesg events. CONFIG_KUNIT_DEBUGFS
   enables/disables the debugfs support.

- Several fixes and improvements to kunit framework and tool.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 2c523b344dfa65a3738e7039832044aa133c75fb:

   Linux 5.6-rc5 (2020-03-08 17:44:44 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-5.7-rc1

for you to fetch changes up to e23349af9ee25a5760112a2f8476b94a4ec86f1c:

   kunit: tool: add missing test data file content (2020-03-26 14:11:12 
-0600)

----------------------------------------------------------------
linux-kselftest-kunit-5.7-rc1

This kunit update for Linux-5.7-rc1 consists of:

- debugfs support for displaying kunit test suite results; this is
   especially useful for module-loaded tests to allow disentangling of
   test result display from other dmesg events. CONFIG_KUNIT_DEBUGFS
   enables/disables the debugfs support.

- Several fixes and improvements to kunit framework and tool.

----------------------------------------------------------------
Alan Maguire (4):
       kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display
       kunit: add log test
       kunit: subtests should be indented 4 spaces according to TAP
       kunit: update documentation to describe debugfs representation

Brendan Higgins (1):
       kunit: tool: add missing test data file content

David Gow (4):
       kunit: Always print actual pointer values in asserts
       kunit: kunit_tool: Allow .kunitconfig to disable config items
       Fix linked-list KUnit test when run multiple times
       Documentation: kunit: Make the KUnit documentation less UML-specific

Greg Thelen (1):
       kunit: add --make_options

Heidi Fahim (2):
       kunit: kunit_parser: make parser more robust
       kunit: Run all KUnit tests through allyesconfig

  Documentation/dev-tools/kunit/index.rst            |  40 +++---
  Documentation/dev-tools/kunit/kunit-tool.rst       |   7 +
  Documentation/dev-tools/kunit/start.rst            |  80 +++++++++--
  Documentation/dev-tools/kunit/usage.rst            |  14 ++
  include/kunit/test.h                               |  63 +++++++--
  lib/kunit/Kconfig                                  |   8 ++
  lib/kunit/Makefile                                 |   4 +
  lib/kunit/assert.c                                 |  79 +++++------
  lib/kunit/debugfs.c                                | 116 ++++++++++++++++
  lib/kunit/debugfs.h                                |  30 +++++
  lib/kunit/kunit-test.c                             |  44 +++++-
lib/kunit/test.c                                   | 148 
++++++++++++++++-----
  lib/list-test.c                                    |   4 +-
  tools/testing/kunit/.gitattributes                 |   1 +
  tools/testing/kunit/configs/broken_on_uml.config   |  41 ++++++
  tools/testing/kunit/kunit.py                       |  38 ++++--
  tools/testing/kunit/kunit_config.py                |  41 ++++--
  tools/testing/kunit/kunit_kernel.py                |  84 ++++++++----
  tools/testing/kunit/kunit_parser.py                |  51 +++----
  tools/testing/kunit/kunit_tool_test.py             | 108 ++++++++++++---
  .../kunit/test_data/test_config_printk_time.log    | Bin 0 -> 1584 bytes
  .../test_data/test_interrupted_tap_output.log      | Bin 0 -> 1982 bytes
  .../test_data/test_kernel_panic_interrupt.log      | Bin 0 -> 1321 bytes
  .../kunit/test_data/test_multiple_prefixes.log     | Bin 0 -> 1832 bytes
  .../test_output_with_prefix_isolated_correctly.log | Bin 0 -> 1655 bytes
  .../kunit/test_data/test_pound_no_prefix.log       | Bin 0 -> 1193 bytes
  tools/testing/kunit/test_data/test_pound_sign.log  | Bin 0 -> 1656 bytes
  27 files changed, 799 insertions(+), 202 deletions(-)
  create mode 100644 lib/kunit/debugfs.c
  create mode 100644 lib/kunit/debugfs.h
  create mode 100644 tools/testing/kunit/.gitattributes
  create mode 100644 tools/testing/kunit/configs/broken_on_uml.config
  create mode 100644 
tools/testing/kunit/test_data/test_config_printk_time.log
  create mode 100644 
tools/testing/kunit/test_data/test_interrupted_tap_output.log
  create mode 100644 
tools/testing/kunit/test_data/test_kernel_panic_interrupt.log
  create mode 100644 
tools/testing/kunit/test_data/test_multiple_prefixes.log
  create mode 100644 
tools/testing/kunit/test_data/test_output_with_prefix_isolated_correctly.log
  create mode 100644 tools/testing/kunit/test_data/test_pound_no_prefix.log
  create mode 100644 tools/testing/kunit/test_data/test_pound_sign.log

----------------------------------------------------------------

--------------2A68A3C7E86FE0C0D99BB039
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.7-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.7-rc1.diff"

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index d16a4d2c3a41..e93606ecfb01 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -17,14 +17,23 @@ What is KUnit?
 ==============
 
 KUnit is a lightweight unit testing and mocking framework for the Linux kernel.
-These tests are able to be run locally on a developer's workstation without a VM
-or special hardware.
 
 KUnit is heavily inspired by JUnit, Python's unittest.mock, and
 Googletest/Googlemock for C++. KUnit provides facilities for defining unit test
 cases, grouping related test cases into test suites, providing common
 infrastructure for running tests, and much more.
 
+KUnit consists of a kernel component, which provides a set of macros for easily
+writing unit tests. Tests written against KUnit will run on kernel boot if
+built-in, or when loaded if built as a module. These tests write out results to
+the kernel log in `TAP <https://testanything.org/>`_ format.
+
+To make running these tests (and reading the results) easier, KUnit offers
+:doc:`kunit_tool <kunit-tool>`, which builds a `User Mode Linux
+<http://user-mode-linux.sourceforge.net>`_ kernel, runs it, and parses the test
+results. This provides a quick way of running KUnit tests during development,
+without requiring a virtual machine or separate hardware.
+
 Get started now: :doc:`start`
 
 Why KUnit?
@@ -36,21 +45,20 @@ allow all possible code paths to be tested in the code under test; this is only
 possible if the code under test is very small and does not have any external
 dependencies outside of the test's control like hardware.
 
-Outside of KUnit, there are no testing frameworks currently
-available for the kernel that do not require installing the kernel on a test
-machine or in a VM and all require tests to be written in userspace running on
-the kernel; this is true for Autotest, and kselftest, disqualifying
-any of them from being considered unit testing frameworks.
+KUnit provides a common framework for unit tests within the kernel.
+
+KUnit tests can be run on most architectures, and most tests are architecture
+independent. All built-in KUnit tests run on kernel startup.  Alternatively,
+KUnit and KUnit tests can be built as modules and tests will run when the test
+module is loaded.
 
-KUnit addresses the problem of being able to run tests without needing a virtual
-machine or actual hardware with User Mode Linux. User Mode Linux is a Linux
-architecture, like ARM or x86; however, unlike other architectures it compiles
-to a standalone program that can be run like any other program directly inside
-of a host operating system; to be clear, it does not require any virtualization
-support; it is just a regular program.
+.. note::
 
-Alternatively, kunit and kunit tests can be built as modules and tests will
-run when the test module is loaded.
+        KUnit can also run tests without needing a virtual machine or actual
+        hardware under User Mode Linux. User Mode Linux is a Linux architecture,
+        like ARM or x86, which compiles the kernel as a Linux executable. KUnit
+        can be used with UML either by building with ``ARCH=um`` (like any other
+        architecture), or by using :doc:`kunit_tool <kunit-tool>`.
 
 KUnit is fast. Excluding build time, from invocation to completion KUnit can run
 several dozen tests in only 10 to 20 seconds; this might not sound like a big
@@ -81,3 +89,5 @@ How do I use it?
 *   :doc:`start` - for new users of KUnit
 *   :doc:`usage` - for a more detailed explanation of KUnit features
 *   :doc:`api/index` - for the list of KUnit APIs used for testing
+*   :doc:`kunit-tool` - for more information on the kunit_tool helper script
+*   :doc:`faq` - for answers to some common questions about KUnit
diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
index 50d46394e97e..949af2da81e5 100644
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -12,6 +12,13 @@ the Linux kernel as UML (`User Mode Linux
 <http://user-mode-linux.sourceforge.net/>`_), running KUnit tests, parsing
 the test results and displaying them in a user friendly manner.
 
+kunit_tool addresses the problem of being able to run tests without needing a
+virtual machine or actual hardware with User Mode Linux. User Mode Linux is a
+Linux architecture, like ARM or x86; however, unlike other architectures it
+compiles the kernel as a standalone Linux executable that can be run like any
+other program directly inside of a host operating system. To be clear, it does
+not require any virtualization support: it is just a regular program.
+
 What is a kunitconfig?
 ======================
 
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 4e1d24db6b13..e1c5ce80ce12 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -9,11 +9,10 @@ Installing dependencies
 KUnit has the same dependencies as the Linux kernel. As long as you can build
 the kernel, you can run KUnit.
 
-KUnit Wrapper
-=============
-Included with KUnit is a simple Python wrapper that helps format the output to
-easily use and read KUnit output. It handles building and running the kernel, as
-well as formatting the output.
+Running tests with the KUnit Wrapper
+====================================
+Included with KUnit is a simple Python wrapper which runs tests under User Mode
+Linux, and formats the test results.
 
 The wrapper can be run with:
 
@@ -21,22 +20,42 @@ The wrapper can be run with:
 
 	./tools/testing/kunit/kunit.py run --defconfig
 
-For more information on this wrapper (also called kunit_tool) checkout the
+For more information on this wrapper (also called kunit_tool) check out the
 :doc:`kunit-tool` page.
 
 Creating a .kunitconfig
-=======================
-The Python script is a thin wrapper around Kbuild. As such, it needs to be
-configured with a ``.kunitconfig`` file. This file essentially contains the
-regular Kernel config, with the specific test targets as well.
-
+-----------------------
+If you want to run a specific set of tests (rather than those listed in the
+KUnit defconfig), you can provide Kconfig options in the ``.kunitconfig`` file.
+This file essentially contains the regular Kernel config, with the specific
+test targets as well. The ``.kunitconfig`` should also contain any other config
+options required by the tests.
+
+A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
 .. code-block:: bash
 
 	cd $PATH_TO_LINUX_REPO
 	cp arch/um/configs/kunit_defconfig .kunitconfig
 
-Verifying KUnit Works
----------------------
+You can then add any other Kconfig options you wish, e.g.:
+.. code-block:: none
+
+        CONFIG_LIST_KUNIT_TEST=y
+
+:doc:`kunit_tool <kunit-tool>` will ensure that all config options set in
+``.kunitconfig`` are set in the kernel ``.config`` before running the tests.
+It'll warn you if you haven't included the dependencies of the options you're
+using.
+
+.. note::
+   Note that removing something from the ``.kunitconfig`` will not trigger a
+   rebuild of the ``.config`` file: the configuration is only updated if the
+   ``.kunitconfig`` is not a subset of ``.config``. This means that you can use
+   other tools (such as make menuconfig) to adjust other config options.
+
+
+Running the tests
+-----------------
 
 To make sure that everything is set up correctly, simply invoke the Python
 wrapper from your kernel repo:
@@ -62,6 +81,41 @@ followed by a list of tests that are run. All of them should be passing.
 	Because it is building a lot of sources for the first time, the
 	``Building KUnit kernel`` step may take a while.
 
+Running tests without the KUnit Wrapper
+=======================================
+
+If you'd rather not use the KUnit Wrapper (if, for example, you need to
+integrate with other systems, or use an architecture other than UML), KUnit can
+be included in any kernel, and the results read out and parsed manually.
+
+.. note::
+   KUnit is not designed for use in a production system, and it's possible that
+   tests may reduce the stability or security of the system.
+
+
+
+Configuring the kernel
+----------------------
+
+In order to enable KUnit itself, you simply need to enable the ``CONFIG_KUNIT``
+Kconfig option (it's under Kernel Hacking/Kernel Testing and Coverage in
+menuconfig). From there, you can enable any KUnit tests you want: they usually
+have config options ending in ``_KUNIT_TEST``.
+
+KUnit and KUnit tests can be compiled as modules: in this case the tests in a
+module will be run when the module is loaded.
+
+Running the tests
+-----------------
+
+Build and run your kernel as usual. Test output will be written to the kernel
+log in `TAP <https://testanything.org/>`_ format.
+
+.. note::
+   It's possible that there will be other lines and/or data interspersed in the
+   TAP output.
+
+
 Writing your first test
 =======================
 
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 607758a66a99..473a2361ec37 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -591,3 +591,17 @@ able to run one test case per invocation.
 
 .. TODO(brendanhiggins@google.com): Add an actual example of an architecture
    dependent KUnit test.
+
+KUnit debugfs representation
+============================
+When kunit test suites are initialized, they create an associated directory
+in /sys/kernel/debug/kunit/<test-suite>.  The directory contains one file
+
+- results: "cat results" displays results of each test case and the results
+  of the entire suite for the last test run.
+
+The debugfs representation is primarily of use when kunit test suites are
+run in a native environment, either as modules or builtin.  Having a way
+to display results like this is valuable as otherwise results can be
+intermixed with other events in dmesg output.  The maximum size of each
+results file is KUNIT_LOG_SIZE bytes (defined in include/kunit/test.h).
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 2dfb550c6723..9b0c46a6ca1f 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -81,6 +81,17 @@ struct kunit_resource {
 
 struct kunit;
 
+/* Size of log associated with test. */
+#define KUNIT_LOG_SIZE	512
+
+/*
+ * TAP specifies subtest stream indentation of 4 spaces, 8 spaces for a
+ * sub-subtest.  See the "Subtests" section in
+ * https://node-tap.org/tap-protocol/
+ */
+#define KUNIT_SUBTEST_INDENT		"    "
+#define KUNIT_SUBSUBTEST_INDENT		"        "
+
 /**
  * struct kunit_case - represents an individual test case.
  *
@@ -123,8 +134,14 @@ struct kunit_case {
 
 	/* private: internal use only. */
 	bool success;
+	char *log;
 };
 
+static inline char *kunit_status_to_string(bool status)
+{
+	return status ? "ok" : "not ok";
+}
+
 /**
  * KUNIT_CASE - A helper for creating a &struct kunit_case
  *
@@ -157,6 +174,10 @@ struct kunit_suite {
 	int (*init)(struct kunit *test);
 	void (*exit)(struct kunit *test);
 	struct kunit_case *test_cases;
+
+	/* private - internal use only */
+	struct dentry *debugfs;
+	char *log;
 };
 
 /**
@@ -175,6 +196,7 @@ struct kunit {
 
 	/* private: internal use only. */
 	const char *name; /* Read only after initialization! */
+	char *log; /* Points at case log after initialization */
 	struct kunit_try_catch try_catch;
 	/*
 	 * success starts as true, and may only be set to false during a
@@ -193,10 +215,19 @@ struct kunit {
 	struct list_head resources; /* Protected by lock. */
 };
 
-void kunit_init_test(struct kunit *test, const char *name);
+void kunit_init_test(struct kunit *test, const char *name, char *log);
 
 int kunit_run_tests(struct kunit_suite *suite);
 
+size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
+
+unsigned int kunit_test_case_num(struct kunit_suite *suite,
+				 struct kunit_case *test_case);
+
+int __kunit_test_suites_init(struct kunit_suite **suites);
+
+void __kunit_test_suites_exit(struct kunit_suite **suites);
+
 /**
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
@@ -226,20 +257,22 @@ int kunit_run_tests(struct kunit_suite *suite);
 	static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};	\
 	static int kunit_test_suites_init(void)				\
 	{								\
-		unsigned int i;						\
-		for (i = 0; suites[i] != NULL; i++)			\
-			kunit_run_tests(suites[i]);			\
-		return 0;						\
+		return __kunit_test_suites_init(suites);		\
 	}								\
 	late_initcall(kunit_test_suites_init);				\
 	static void __exit kunit_test_suites_exit(void)			\
 	{								\
-		return;							\
+		return __kunit_test_suites_exit(suites);		\
 	}								\
 	module_exit(kunit_test_suites_exit)
 
 #define kunit_test_suite(suite)	kunit_test_suites(&suite)
 
+#define kunit_suite_for_each_test_case(suite, test_case)		\
+	for (test_case = suite->test_cases; test_case->run_case; test_case++)
+
+bool kunit_suite_has_succeeded(struct kunit_suite *suite);
+
 /*
  * Like kunit_alloc_resource() below, but returns the struct kunit_resource
  * object that contains the allocation. This is mostly for testing purposes.
@@ -356,8 +389,22 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
 
 void kunit_cleanup(struct kunit *test);
 
-#define kunit_printk(lvl, test, fmt, ...) \
-	printk(lvl "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
+void kunit_log_append(char *log, const char *fmt, ...);
+
+/*
+ * printk and log to per-test or per-suite log buffer.  Logging only done
+ * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/used.
+ */
+#define kunit_log(lvl, test_or_suite, fmt, ...)				\
+	do {								\
+		printk(lvl fmt, ##__VA_ARGS__);				\
+		kunit_log_append((test_or_suite)->log,	fmt "\n",	\
+				 ##__VA_ARGS__);			\
+	} while (0)
+
+#define kunit_printk(lvl, test, fmt, ...)				\
+	kunit_log(lvl, test, KUNIT_SUBTEST_INDENT "# %s: " fmt,		\
+		  (test)->name,	##__VA_ARGS__)
 
 /**
  * kunit_info() - Prints an INFO level message associated with @test.
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 065aa16f448b..95d12e3d6d95 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -14,6 +14,14 @@ menuconfig KUNIT
 
 if KUNIT
 
+config KUNIT_DEBUGFS
+	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
+	help
+	  Enable debugfs representation for kunit.  Currently this consists
+	  of /sys/kernel/debug/kunit/<test_suite>/results files for each
+	  test suite, which allow users to see results of the last test suite
+	  run that occurred.
+
 config KUNIT_TEST
 	tristate "KUnit test for KUnit"
 	help
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index fab55649b69a..724b94311ca3 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -5,6 +5,10 @@ kunit-objs +=				test.o \
 					assert.o \
 					try-catch.o
 
+ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
+kunit-objs +=				debugfs.o
+endif
+
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 
 # string-stream-test compiles built-in only.
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index b24bebca052d..33acdaa28a7d 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -6,6 +6,7 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 #include <kunit/assert.h>
+#include <kunit/test.h>
 
 #include "string-stream.h"
 
@@ -53,12 +54,12 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 	kunit_base_assert_format(assert, stream);
 	if (unary_assert->expected_true)
 		string_stream_add(stream,
-				 "\tExpected %s to be true, but is false\n",
-				 unary_assert->condition);
+				  KUNIT_SUBTEST_INDENT "Expected %s to be true, but is false\n",
+				  unary_assert->condition);
 	else
 		string_stream_add(stream,
-				 "\tExpected %s to be false, but is true\n",
-				 unary_assert->condition);
+				  KUNIT_SUBTEST_INDENT "Expected %s to be false, but is true\n",
+				  unary_assert->condition);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_unary_assert_format);
@@ -72,13 +73,13 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 	kunit_base_assert_format(assert, stream);
 	if (!ptr_assert->value) {
 		string_stream_add(stream,
-				 "\tExpected %s is not null, but is\n",
-				 ptr_assert->text);
+				  KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
+				  ptr_assert->text);
 	} else if (IS_ERR(ptr_assert->value)) {
 		string_stream_add(stream,
-				 "\tExpected %s is not error, but is: %ld\n",
-				 ptr_assert->text,
-				 PTR_ERR(ptr_assert->value));
+				  KUNIT_SUBTEST_INDENT "Expected %s is not error, but is: %ld\n",
+				  ptr_assert->text,
+				  PTR_ERR(ptr_assert->value));
 	}
 	kunit_assert_print_msg(assert, stream);
 }
@@ -92,16 +93,16 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
-			 "\tExpected %s %s %s, but\n",
-			 binary_assert->left_text,
-			 binary_assert->operation,
-			 binary_assert->right_text);
-	string_stream_add(stream, "\t\t%s == %lld\n",
-			 binary_assert->left_text,
-			 binary_assert->left_value);
-	string_stream_add(stream, "\t\t%s == %lld",
-			 binary_assert->right_text,
-			 binary_assert->right_value);
+			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
+			  binary_assert->left_text,
+			  binary_assert->operation,
+			  binary_assert->right_text);
+	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
+			  binary_assert->left_text,
+			  binary_assert->left_value);
+	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
+			  binary_assert->right_text,
+			  binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
@@ -114,16 +115,16 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
-			 "\tExpected %s %s %s, but\n",
-			 binary_assert->left_text,
-			 binary_assert->operation,
-			 binary_assert->right_text);
-	string_stream_add(stream, "\t\t%s == %pK\n",
-			 binary_assert->left_text,
-			 binary_assert->left_value);
-	string_stream_add(stream, "\t\t%s == %pK",
-			 binary_assert->right_text,
-			 binary_assert->right_value);
+			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
+			  binary_assert->left_text,
+			  binary_assert->operation,
+			  binary_assert->right_text);
+	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
+			  binary_assert->left_text,
+			  binary_assert->left_value);
+	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px",
+			  binary_assert->right_text,
+			  binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
@@ -136,16 +137,16 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
-			 "\tExpected %s %s %s, but\n",
-			 binary_assert->left_text,
-			 binary_assert->operation,
-			 binary_assert->right_text);
-	string_stream_add(stream, "\t\t%s == %s\n",
-			 binary_assert->left_text,
-			 binary_assert->left_value);
-	string_stream_add(stream, "\t\t%s == %s",
-			 binary_assert->right_text,
-			 binary_assert->right_value);
+			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
+			  binary_assert->left_text,
+			  binary_assert->operation,
+			  binary_assert->right_text);
+	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %s\n",
+			  binary_assert->left_text,
+			  binary_assert->left_value);
+	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %s",
+			  binary_assert->right_text,
+			  binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
new file mode 100644
index 000000000000..9214c493d8b7
--- /dev/null
+++ b/lib/kunit/debugfs.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ *    Author: Alan Maguire <alan.maguire@oracle.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/module.h>
+
+#include <kunit/test.h>
+
+#include "string-stream.h"
+
+#define KUNIT_DEBUGFS_ROOT             "kunit"
+#define KUNIT_DEBUGFS_RESULTS          "results"
+
+/*
+ * Create a debugfs representation of test suites:
+ *
+ * Path						Semantics
+ * /sys/kernel/debug/kunit/<testsuite>/results	Show results of last run for
+ *						testsuite
+ *
+ */
+
+static struct dentry *debugfs_rootdir;
+
+void kunit_debugfs_cleanup(void)
+{
+	debugfs_remove_recursive(debugfs_rootdir);
+}
+
+void kunit_debugfs_init(void)
+{
+	if (!debugfs_rootdir)
+		debugfs_rootdir = debugfs_create_dir(KUNIT_DEBUGFS_ROOT, NULL);
+}
+
+static void debugfs_print_result(struct seq_file *seq,
+				 struct kunit_suite *suite,
+				 struct kunit_case *test_case)
+{
+	if (!test_case || !test_case->log)
+		return;
+
+	seq_printf(seq, "%s", test_case->log);
+}
+
+/*
+ * /sys/kernel/debug/kunit/<testsuite>/results shows all results for testsuite.
+ */
+static int debugfs_print_results(struct seq_file *seq, void *v)
+{
+	struct kunit_suite *suite = (struct kunit_suite *)seq->private;
+	bool success = kunit_suite_has_succeeded(suite);
+	struct kunit_case *test_case;
+
+	if (!suite || !suite->log)
+		return 0;
+
+	seq_printf(seq, "%s", suite->log);
+
+	kunit_suite_for_each_test_case(suite, test_case)
+		debugfs_print_result(seq, suite, test_case);
+
+	seq_printf(seq, "%s %d - %s\n",
+		   kunit_status_to_string(success), 1, suite->name);
+	return 0;
+}
+
+static int debugfs_release(struct inode *inode, struct file *file)
+{
+	return single_release(inode, file);
+}
+
+static int debugfs_results_open(struct inode *inode, struct file *file)
+{
+	struct kunit_suite *suite;
+
+	suite = (struct kunit_suite *)inode->i_private;
+
+	return single_open(file, debugfs_print_results, suite);
+}
+
+static const struct file_operations debugfs_results_fops = {
+	.open = debugfs_results_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = debugfs_release,
+};
+
+void kunit_debugfs_create_suite(struct kunit_suite *suite)
+{
+	struct kunit_case *test_case;
+
+	/* Allocate logs before creating debugfs representation. */
+	suite->log = kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
+	kunit_suite_for_each_test_case(suite, test_case)
+		test_case->log = kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
+
+	suite->debugfs = debugfs_create_dir(suite->name, debugfs_rootdir);
+
+	debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
+			    suite->debugfs,
+			    suite, &debugfs_results_fops);
+}
+
+void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
+{
+	struct kunit_case *test_case;
+
+	debugfs_remove_recursive(suite->debugfs);
+	kfree(suite->log);
+	kunit_suite_for_each_test_case(suite, test_case)
+		kfree(test_case->log);
+}
diff --git a/lib/kunit/debugfs.h b/lib/kunit/debugfs.h
new file mode 100644
index 000000000000..dcc7d7556107
--- /dev/null
+++ b/lib/kunit/debugfs.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020, Oracle and/or its affiliates.
+ */
+
+#ifndef _KUNIT_DEBUGFS_H
+#define _KUNIT_DEBUGFS_H
+
+#include <kunit/test.h>
+
+#ifdef CONFIG_KUNIT_DEBUGFS
+
+void kunit_debugfs_create_suite(struct kunit_suite *suite);
+void kunit_debugfs_destroy_suite(struct kunit_suite *suite);
+void kunit_debugfs_init(void);
+void kunit_debugfs_cleanup(void);
+
+#else
+
+static inline void kunit_debugfs_create_suite(struct kunit_suite *suite) { }
+
+static inline void kunit_debugfs_destroy_suite(struct kunit_suite *suite) { }
+
+static inline void kunit_debugfs_init(void) { }
+
+static inline void kunit_debugfs_cleanup(void) { }
+
+#endif /* CONFIG_KUNIT_DEBUGFS */
+
+#endif /* _KUNIT_DEBUGFS_H */
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index ccb8d2e332f7..4f3d36a72f8f 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -134,7 +134,7 @@ static void kunit_resource_test_init_resources(struct kunit *test)
 {
 	struct kunit_test_resource_context *ctx = test->priv;
 
-	kunit_init_test(&ctx->test, "testing_test_init_test");
+	kunit_init_test(&ctx->test, "testing_test_init_test", NULL);
 
 	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
 }
@@ -301,7 +301,7 @@ static int kunit_resource_test_init(struct kunit *test)
 
 	test->priv = ctx;
 
-	kunit_init_test(&ctx->test, "test_test_context");
+	kunit_init_test(&ctx->test, "test_test_context", NULL);
 
 	return 0;
 }
@@ -329,6 +329,44 @@ static struct kunit_suite kunit_resource_test_suite = {
 	.exit = kunit_resource_test_exit,
 	.test_cases = kunit_resource_test_cases,
 };
-kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite);
+
+static void kunit_log_test(struct kunit *test);
+
+static struct kunit_case kunit_log_test_cases[] = {
+	KUNIT_CASE(kunit_log_test),
+	{}
+};
+
+static struct kunit_suite kunit_log_test_suite = {
+	.name = "kunit-log-test",
+	.test_cases = kunit_log_test_cases,
+};
+
+static void kunit_log_test(struct kunit *test)
+{
+	struct kunit_suite *suite = &kunit_log_test_suite;
+
+	kunit_log(KERN_INFO, test, "put this in log.");
+	kunit_log(KERN_INFO, test, "this too.");
+	kunit_log(KERN_INFO, suite, "add to suite log.");
+	kunit_log(KERN_INFO, suite, "along with this.");
+
+#ifdef CONFIG_KUNIT_DEBUGFS
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(test->log, "put this in log."));
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(test->log, "this too."));
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(suite->log, "add to suite log."));
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(suite->log, "along with this."));
+#else
+	KUNIT_EXPECT_PTR_EQ(test, test->log, (char *)NULL);
+	KUNIT_EXPECT_PTR_EQ(test, suite->log, (char *)NULL);
+#endif
+}
+
+kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
+		  &kunit_log_test_suite);
 
 MODULE_LICENSE("GPL v2");
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 9242f932896c..7a6430a7fca0 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/sched/debug.h>
 
+#include "debugfs.h"
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
@@ -28,73 +29,117 @@ static void kunit_print_tap_version(void)
 	}
 }
 
-static size_t kunit_test_cases_len(struct kunit_case *test_cases)
+/*
+ * Append formatted message to log, size of which is limited to
+ * KUNIT_LOG_SIZE bytes (including null terminating byte).
+ */
+void kunit_log_append(char *log, const char *fmt, ...)
+{
+	char line[KUNIT_LOG_SIZE];
+	va_list args;
+	int len_left;
+
+	if (!log)
+		return;
+
+	len_left = KUNIT_LOG_SIZE - strlen(log) - 1;
+	if (len_left <= 0)
+		return;
+
+	va_start(args, fmt);
+	vsnprintf(line, sizeof(line), fmt, args);
+	va_end(args);
+
+	strncat(log, line, len_left);
+}
+EXPORT_SYMBOL_GPL(kunit_log_append);
+
+size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
 {
 	struct kunit_case *test_case;
 	size_t len = 0;
 
-	for (test_case = test_cases; test_case->run_case; test_case++)
+	kunit_suite_for_each_test_case(suite, test_case)
 		len++;
 
 	return len;
 }
+EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
 
 static void kunit_print_subtest_start(struct kunit_suite *suite)
 {
 	kunit_print_tap_version();
-	pr_info("\t# Subtest: %s\n", suite->name);
-	pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
+	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
+		  suite->name);
+	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
+		  kunit_suite_num_test_cases(suite));
 }
 
-static void kunit_print_ok_not_ok(bool should_indent,
+static void kunit_print_ok_not_ok(void *test_or_suite,
+				  bool is_test,
 				  bool is_ok,
 				  size_t test_number,
 				  const char *description)
 {
-	const char *indent, *ok_not_ok;
-
-	if (should_indent)
-		indent = "\t";
-	else
-		indent = "";
+	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
+	struct kunit *test = is_test ? test_or_suite : NULL;
 
-	if (is_ok)
-		ok_not_ok = "ok";
+	/*
+	 * We do not log the test suite results as doing so would
+	 * mean debugfs display would consist of the test suite
+	 * description and status prior to individual test results.
+	 * Hence directly printk the suite status, and we will
+	 * separately seq_printf() the suite status for the debugfs
+	 * representation.
+	 */
+	if (suite)
+		pr_info("%s %zd - %s",
+			kunit_status_to_string(is_ok),
+			test_number, description);
 	else
-		ok_not_ok = "not ok";
-
-	pr_info("%s%s %zd - %s\n", indent, ok_not_ok, test_number, description);
+		kunit_log(KERN_INFO, test, KUNIT_SUBTEST_INDENT "%s %zd - %s",
+			  kunit_status_to_string(is_ok),
+			  test_number, description);
 }
 
-static bool kunit_suite_has_succeeded(struct kunit_suite *suite)
+bool kunit_suite_has_succeeded(struct kunit_suite *suite)
 {
 	const struct kunit_case *test_case;
 
-	for (test_case = suite->test_cases; test_case->run_case; test_case++)
+	kunit_suite_for_each_test_case(suite, test_case) {
 		if (!test_case->success)
 			return false;
+	}
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
 
 static void kunit_print_subtest_end(struct kunit_suite *suite)
 {
 	static size_t kunit_suite_counter = 1;
 
-	kunit_print_ok_not_ok(false,
+	kunit_print_ok_not_ok((void *)suite, false,
 			      kunit_suite_has_succeeded(suite),
 			      kunit_suite_counter++,
 			      suite->name);
 }
 
-static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
-					    size_t test_number)
+unsigned int kunit_test_case_num(struct kunit_suite *suite,
+				 struct kunit_case *test_case)
 {
-	kunit_print_ok_not_ok(true,
-			      test_case->success,
-			      test_number,
-			      test_case->name);
+	struct kunit_case *tc;
+	unsigned int i = 1;
+
+	kunit_suite_for_each_test_case(suite, tc) {
+		if (tc == test_case)
+			return i;
+		i++;
+	}
+
+	return 0;
 }
+EXPORT_SYMBOL_GPL(kunit_test_case_num);
 
 static void kunit_print_string_stream(struct kunit *test,
 				      struct string_stream *stream)
@@ -102,6 +147,9 @@ static void kunit_print_string_stream(struct kunit *test,
 	struct string_stream_fragment *fragment;
 	char *buf;
 
+	if (string_stream_is_empty(stream))
+		return;
+
 	buf = string_stream_get_string(stream);
 	if (!buf) {
 		kunit_err(test,
@@ -175,11 +223,14 @@ void kunit_do_assertion(struct kunit *test,
 }
 EXPORT_SYMBOL_GPL(kunit_do_assertion);
 
-void kunit_init_test(struct kunit *test, const char *name)
+void kunit_init_test(struct kunit *test, const char *name, char *log)
 {
 	spin_lock_init(&test->lock);
 	INIT_LIST_HEAD(&test->resources);
 	test->name = name;
+	test->log = log;
+	if (test->log)
+		test->log[0] = '\0';
 	test->success = true;
 }
 EXPORT_SYMBOL_GPL(kunit_init_test);
@@ -290,7 +341,7 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	struct kunit_try_catch *try_catch;
 	struct kunit test;
 
-	kunit_init_test(&test, test_case->name);
+	kunit_init_test(&test, test_case->name, test_case->log);
 	try_catch = &test.try_catch;
 
 	kunit_try_catch_init(try_catch,
@@ -303,19 +354,20 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	kunit_try_catch_run(try_catch, &context);
 
 	test_case->success = test.success;
+
+	kunit_print_ok_not_ok(&test, true, test_case->success,
+			      kunit_test_case_num(suite, test_case),
+			      test_case->name);
 }
 
 int kunit_run_tests(struct kunit_suite *suite)
 {
 	struct kunit_case *test_case;
-	size_t test_case_count = 1;
 
 	kunit_print_subtest_start(suite);
 
-	for (test_case = suite->test_cases; test_case->run_case; test_case++) {
+	kunit_suite_for_each_test_case(suite, test_case)
 		kunit_run_case_catch_errors(suite, test_case);
-		kunit_print_test_case_ok_not_ok(test_case, test_case_count++);
-	}
 
 	kunit_print_subtest_end(suite);
 
@@ -323,6 +375,37 @@ int kunit_run_tests(struct kunit_suite *suite)
 }
 EXPORT_SYMBOL_GPL(kunit_run_tests);
 
+static void kunit_init_suite(struct kunit_suite *suite)
+{
+	kunit_debugfs_create_suite(suite);
+}
+
+int __kunit_test_suites_init(struct kunit_suite **suites)
+{
+	unsigned int i;
+
+	for (i = 0; suites[i] != NULL; i++) {
+		kunit_init_suite(suites[i]);
+		kunit_run_tests(suites[i]);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
+
+static void kunit_exit_suite(struct kunit_suite *suite)
+{
+	kunit_debugfs_destroy_suite(suite);
+}
+
+void __kunit_test_suites_exit(struct kunit_suite **suites)
+{
+	unsigned int i;
+
+	for (i = 0; suites[i] != NULL; i++)
+		kunit_exit_suite(suites[i]);
+}
+EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
+
 struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
 						    kunit_resource_init_t init,
 						    kunit_resource_free_t free,
@@ -489,12 +572,15 @@ EXPORT_SYMBOL_GPL(kunit_cleanup);
 
 static int __init kunit_init(void)
 {
+	kunit_debugfs_init();
+
 	return 0;
 }
 late_initcall(kunit_init);
 
 static void __exit kunit_exit(void)
 {
+	kunit_debugfs_cleanup();
 }
 module_exit(kunit_exit);
 
diff --git a/lib/list-test.c b/lib/list-test.c
index 76babb1df889..ee09505df16f 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -659,7 +659,7 @@ static void list_test_list_for_each_prev_safe(struct kunit *test)
 static void list_test_list_for_each_entry(struct kunit *test)
 {
 	struct list_test_struct entries[5], *cur;
-	static LIST_HEAD(list);
+	LIST_HEAD(list);
 	int i = 0;
 
 	for (i = 0; i < 5; ++i) {
@@ -680,7 +680,7 @@ static void list_test_list_for_each_entry(struct kunit *test)
 static void list_test_list_for_each_entry_reverse(struct kunit *test)
 {
 	struct list_test_struct entries[5], *cur;
-	static LIST_HEAD(list);
+	LIST_HEAD(list);
 	int i = 0;
 
 	for (i = 0; i < 5; ++i) {
diff --git a/tools/testing/kunit/.gitattributes b/tools/testing/kunit/.gitattributes
new file mode 100644
index 000000000000..5b7da1fc3b8f
--- /dev/null
+++ b/tools/testing/kunit/.gitattributes
@@ -0,0 +1 @@
+test_data/* binary
diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testing/kunit/configs/broken_on_uml.config
new file mode 100644
index 000000000000..239b9f03da2c
--- /dev/null
+++ b/tools/testing/kunit/configs/broken_on_uml.config
@@ -0,0 +1,41 @@
+# These are currently broken on UML and prevent allyesconfig from building
+# CONFIG_STATIC_LINK is not set
+# CONFIG_UML_NET_VECTOR is not set
+# CONFIG_UML_NET_VDE is not set
+# CONFIG_UML_NET_PCAP is not set
+# CONFIG_NET_PTP_CLASSIFY is not set
+# CONFIG_IP_VS is not set
+# CONFIG_BRIDGE_EBT_BROUTE is not set
+# CONFIG_BRIDGE_EBT_T_FILTER is not set
+# CONFIG_BRIDGE_EBT_T_NAT is not set
+# CONFIG_MTD_NAND_CADENCE is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_BLK_DEV_NULL_BLK is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_SCSI_DEBUG is not set
+# CONFIG_NET_VENDOR_XILINX is not set
+# CONFIG_NULL_TTY is not set
+# CONFIG_PTP_1588_CLOCK is not set
+# CONFIG_PINCTRL_EQUILIBRIUM is not set
+# CONFIG_DMABUF_SELFTESTS is not set
+# CONFIG_COMEDI is not set
+# CONFIG_XIL_AXIS_FIFO is not set
+# CONFIG_EXFAT_FS is not set
+# CONFIG_STM_DUMMY is not set
+# CONFIG_FSI_MASTER_ASPEED is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_UBIFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
+# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
+# CONFIG_KCOV is not set
+# CONFIG_LKDTM is not set
+# CONFIG_REED_SOLOMON_TEST is not set
+# CONFIG_TEST_RHASHTABLE is not set
+# CONFIG_TEST_MEMINIT is not set
+# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
+# CONFIG_DEBUG_INFO_BTF is not set
+# CONFIG_PTP_1588_CLOCK_INES is not set
+# CONFIG_QCOM_CPR is not set
+# CONFIG_RESET_BRCMSTB_RESCAL is not set
+# CONFIG_RESET_INTEL_GW is not set
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 180ad1e1b04f..7dca74774dd2 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -22,7 +22,9 @@ import kunit_parser
 
 KunitResult = namedtuple('KunitResult', ['status','result'])
 
-KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir', 'defconfig'])
+KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
+					   'build_dir', 'defconfig',
+					   'alltests', 'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -47,7 +49,7 @@ def get_kernel_root_path():
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
 	config_start = time.time()
-	success = linux.build_reconfig(request.build_dir)
+	success = linux.build_reconfig(request.build_dir, request.make_options)
 	config_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.CONFIG_FAILURE, 'could not configure kernel')
@@ -55,24 +57,24 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
 
 	build_start = time.time()
-	success = linux.build_um_kernel(request.jobs, request.build_dir)
+	success = linux.build_um_kernel(request.alltests,
+					request.jobs,
+					request.build_dir,
+					request.make_options)
 	build_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
 
 	kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
 	test_start = time.time()
-
-	test_result = kunit_parser.TestResult(kunit_parser.TestStatus.SUCCESS,
-					      [],
-					      'Tests not Parsed.')
+	kunit_output = linux.run_kernel(
+		timeout=None if request.alltests else request.timeout,
+		build_dir=request.build_dir)
 	if request.raw_output:
-		kunit_parser.raw_output(
-			linux.run_kernel(timeout=request.timeout,
-					 build_dir=request.build_dir))
+		raw_output = kunit_parser.raw_output(kunit_output)
+		isolated = list(kunit_parser.isolate_kunit_output(raw_output))
+		test_result = kunit_parser.parse_test_result(isolated)
 	else:
-		kunit_output = linux.run_kernel(timeout=request.timeout,
-						build_dir=request.build_dir)
 		test_result = kunit_parser.parse_run_tests(kunit_output)
 	test_end = time.time()
 
@@ -120,6 +122,14 @@ def main(argv, linux=None):
 				help='Uses a default .kunitconfig.',
 				action='store_true')
 
+	run_parser.add_argument('--alltests',
+				help='Run all KUnit tests through allyesconfig',
+				action='store_true')
+
+	run_parser.add_argument('--make_options',
+				help='X=Y make option, can be repeated.',
+				action='append')
+
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
@@ -143,7 +153,9 @@ def main(argv, linux=None):
 				       cli_args.timeout,
 				       cli_args.jobs,
 				       cli_args.build_dir,
-				       cli_args.defconfig)
+				       cli_args.defconfig,
+				       cli_args.alltests,
+				       cli_args.make_options)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index ebf3942b23f5..e75063d603b5 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -9,16 +9,18 @@
 import collections
 import re
 
-CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_\w+ is not set$'
-CONFIG_PATTERN = r'^CONFIG_\w+=\S+$'
-
-KconfigEntryBase = collections.namedtuple('KconfigEntry', ['raw_entry'])
+CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
+CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+)$'
 
+KconfigEntryBase = collections.namedtuple('KconfigEntry', ['name', 'value'])
 
 class KconfigEntry(KconfigEntryBase):
 
 	def __str__(self) -> str:
-		return self.raw_entry
+		if self.value == 'n':
+			return r'# CONFIG_%s is not set' % (self.name)
+		else:
+			return r'CONFIG_%s=%s' % (self.name, self.value)
 
 
 class KconfigParseError(Exception):
@@ -38,7 +40,17 @@ class Kconfig(object):
 		self._entries.append(entry)
 
 	def is_subset_of(self, other: 'Kconfig') -> bool:
-		return self.entries().issubset(other.entries())
+		for a in self.entries():
+			found = False
+			for b in other.entries():
+				if a.name != b.name:
+					continue
+				if a.value != b.value:
+					return False
+				found = True
+			if a.value != 'n' and found == False:
+				return False
+		return True
 
 	def write_to_file(self, path: str) -> None:
 		with open(path, 'w') as f:
@@ -54,9 +66,20 @@ class Kconfig(object):
 			line = line.strip()
 			if not line:
 				continue
-			elif config_matcher.match(line) or is_not_set_matcher.match(line):
-				self._entries.append(KconfigEntry(line))
-			elif line[0] == '#':
+
+			match = config_matcher.match(line)
+			if match:
+				entry = KconfigEntry(match.group(1), match.group(2))
+				self.add_entry(entry)
+				continue
+
+			empty_match = is_not_set_matcher.match(line)
+			if empty_match:
+				entry = KconfigEntry(empty_match.group(1), 'n')
+				self.add_entry(entry)
+				continue
+
+			if line[0] == '#':
 				continue
 			else:
 				raise KconfigParseError('Failed to parse: ' + line)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index d99ae75ef72f..63dbda2d029f 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -10,11 +10,16 @@
 import logging
 import subprocess
 import os
+import signal
+
+from contextlib import ExitStack
 
 import kunit_config
+import kunit_parser
 
 KCONFIG_PATH = '.config'
 kunitconfig_path = '.kunitconfig'
+BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -35,19 +40,40 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output)
 
-	def make_olddefconfig(self, build_dir):
+	def make_olddefconfig(self, build_dir, make_options):
 		command = ['make', 'ARCH=um', 'olddefconfig']
+		if make_options:
+			command.extend(make_options)
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
-			subprocess.check_output(command)
+			subprocess.check_output(command, stderr=subprocess.PIPE)
 		except OSError as e:
 			raise ConfigError('Could not call make command: ' + e)
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output)
 
-	def make(self, jobs, build_dir):
+	def make_allyesconfig(self):
+		kunit_parser.print_with_timestamp(
+			'Enabling all CONFIGs for UML...')
+		process = subprocess.Popen(
+			['make', 'ARCH=um', 'allyesconfig'],
+			stdout=subprocess.DEVNULL,
+			stderr=subprocess.STDOUT)
+		process.wait()
+		kunit_parser.print_with_timestamp(
+			'Disabling broken configs to run KUnit tests...')
+		with ExitStack() as es:
+			config = open(KCONFIG_PATH, 'a')
+			disable = open(BROKEN_ALLCONFIG_PATH, 'r').read()
+			config.write(disable)
+		kunit_parser.print_with_timestamp(
+			'Starting Kernel with all configs takes a few minutes...')
+
+	def make(self, jobs, build_dir, make_options):
 		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
+		if make_options:
+			command.extend(make_options)
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
@@ -57,18 +83,16 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise BuildError(e.output)
 
-	def linux_bin(self, params, timeout, build_dir):
+	def linux_bin(self, params, timeout, build_dir, outfile):
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = './linux'
 		if build_dir:
 			linux_bin = os.path.join(build_dir, 'linux')
-		process = subprocess.Popen(
-			[linux_bin] + params,
-			stdin=subprocess.PIPE,
-			stdout=subprocess.PIPE,
-			stderr=subprocess.PIPE)
-		process.wait(timeout=timeout)
-		return process
+		with open(outfile, 'w') as output:
+			process = subprocess.Popen([linux_bin] + params,
+						   stdout=output,
+						   stderr=subprocess.STDOUT)
+			process.wait(timeout)
 
 
 def get_kconfig_path(build_dir):
@@ -84,6 +108,7 @@ class LinuxSourceTree(object):
 		self._kconfig = kunit_config.Kconfig()
 		self._kconfig.read_from_file(kunitconfig_path)
 		self._ops = LinuxSourceTreeOperations()
+		signal.signal(signal.SIGINT, self.signal_handler)
 
 	def clean(self):
 		try:
@@ -107,19 +132,19 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def build_config(self, build_dir):
+	def build_config(self, build_dir, make_options):
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
 		self._kconfig.write_to_file(kconfig_path)
 		try:
-			self._ops.make_olddefconfig(build_dir)
+			self._ops.make_olddefconfig(build_dir, make_options)
 		except ConfigError as e:
 			logging.error(e)
 			return False
 		return self.validate_config(build_dir)
 
-	def build_reconfig(self, build_dir):
+	def build_reconfig(self, build_dir, make_options):
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if os.path.exists(kconfig_path):
@@ -128,26 +153,33 @@ class LinuxSourceTree(object):
 			if not self._kconfig.is_subset_of(existing_kconfig):
 				print('Regenerating .config ...')
 				os.remove(kconfig_path)
-				return self.build_config(build_dir)
+				return self.build_config(build_dir, make_options)
 			else:
 				return True
 		else:
 			print('Generating .config ...')
-			return self.build_config(build_dir)
+			return self.build_config(build_dir, make_options)
 
-	def build_um_kernel(self, jobs, build_dir):
+	def build_um_kernel(self, alltests, jobs, build_dir, make_options):
+		if alltests:
+			self._ops.make_allyesconfig()
 		try:
-			self._ops.make_olddefconfig(build_dir)
-			self._ops.make(jobs, build_dir)
+			self._ops.make_olddefconfig(build_dir, make_options)
+			self._ops.make(jobs, build_dir, make_options)
 		except (ConfigError, BuildError) as e:
 			logging.error(e)
 			return False
 		return self.validate_config(build_dir)
 
-	def run_kernel(self, args=[], timeout=None, build_dir=''):
-		args.extend(['mem=256M'])
-		process = self._ops.linux_bin(args, timeout, build_dir)
-		with open(os.path.join(build_dir, 'test.log'), 'w') as f:
-			for line in process.stdout:
-				f.write(line.rstrip().decode('ascii') + '\n')
-				yield line.rstrip().decode('ascii')
+	def run_kernel(self, args=[], build_dir='', timeout=None):
+		args.extend(['mem=1G'])
+		outfile = 'test.log'
+		self._ops.linux_bin(args, timeout, build_dir, outfile)
+		subprocess.call(['stty', 'sane'])
+		with open(outfile, 'r') as file:
+			for line in file:
+				yield line
+
+	def signal_handler(self, sig, frame):
+		logging.error('Build interruption occurred. Cleaning console.')
+		subprocess.call(['stty', 'sane'])
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 4ffbae0f6732..64aac9dcd431 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -46,23 +46,26 @@ class TestStatus(Enum):
 	TEST_CRASHED = auto()
 	NO_TESTS = auto()
 
-kunit_start_re = re.compile(r'^TAP version [0-9]+$')
-kunit_end_re = re.compile('List of all partitions:')
+kunit_start_re = re.compile(r'TAP version [0-9]+$')
+kunit_end_re = re.compile('(List of all partitions:|'
+			  'Kernel panic - not syncing: VFS:|reboot: System halted)')
 
 def isolate_kunit_output(kernel_output):
 	started = False
 	for line in kernel_output:
-		if kunit_start_re.match(line):
+		if kunit_start_re.search(line):
+			prefix_len = len(line.split('TAP version')[0])
 			started = True
-			yield line
-		elif kunit_end_re.match(line):
+			yield line[prefix_len:] if prefix_len > 0 else line
+		elif kunit_end_re.search(line):
 			break
 		elif started:
-			yield line
+			yield line[prefix_len:] if prefix_len > 0 else line
 
 def raw_output(kernel_output):
 	for line in kernel_output:
 		print(line)
+		yield line
 
 DIVIDER = '=' * 60
 
@@ -91,7 +94,7 @@ def print_log(log):
 	for m in log:
 		print_with_timestamp(m)
 
-TAP_ENTRIES = re.compile(r'^(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t?#).*$')
+TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*#).*$')
 
 def consume_non_diagnositic(lines: List[str]) -> None:
 	while lines and not TAP_ENTRIES.match(lines[0]):
@@ -104,22 +107,20 @@ def save_non_diagnositic(lines: List[str], test_case: TestCase) -> None:
 
 OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
 
-OK_NOT_OK_SUBTEST = re.compile(r'^\t(ok|not ok) [0-9]+ - (.*)$')
+OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
 
 OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) [0-9]+ - (.*)$')
 
-def parse_ok_not_ok_test_case(lines: List[str],
-			      test_case: TestCase,
-			      expecting_test_case: bool) -> bool:
+def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
 	save_non_diagnositic(lines, test_case)
 	if not lines:
-		if expecting_test_case:
-			test_case.status = TestStatus.TEST_CRASHED
-			return True
-		else:
-			return False
+		test_case.status = TestStatus.TEST_CRASHED
+		return True
 	line = lines[0]
 	match = OK_NOT_OK_SUBTEST.match(line)
+	while not match and lines:
+		line = lines.pop(0)
+		match = OK_NOT_OK_SUBTEST.match(line)
 	if match:
 		test_case.log.append(lines.pop(0))
 		test_case.name = match.group(2)
@@ -133,7 +134,7 @@ def parse_ok_not_ok_test_case(lines: List[str],
 	else:
 		return False
 
-SUBTEST_DIAGNOSTIC = re.compile(r'^\t# .*?: (.*)$')
+SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# .*?: (.*)$')
 DIAGNOSTIC_CRASH_MESSAGE = 'kunit test case crashed!'
 
 def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
@@ -150,17 +151,17 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
 	else:
 		return False
 
-def parse_test_case(lines: List[str], expecting_test_case: bool) -> TestCase:
+def parse_test_case(lines: List[str]) -> TestCase:
 	test_case = TestCase()
 	save_non_diagnositic(lines, test_case)
 	while parse_diagnostic(lines, test_case):
 		pass
-	if parse_ok_not_ok_test_case(lines, test_case, expecting_test_case):
+	if parse_ok_not_ok_test_case(lines, test_case):
 		return test_case
 	else:
 		return None
 
-SUBTEST_HEADER = re.compile(r'^\t# Subtest: (.*)$')
+SUBTEST_HEADER = re.compile(r'^[\s]+# Subtest: (.*)$')
 
 def parse_subtest_header(lines: List[str]) -> str:
 	consume_non_diagnositic(lines)
@@ -173,7 +174,7 @@ def parse_subtest_header(lines: List[str]) -> str:
 	else:
 		return None
 
-SUBTEST_PLAN = re.compile(r'\t[0-9]+\.\.([0-9]+)')
+SUBTEST_PLAN = re.compile(r'[\s]+[0-9]+\.\.([0-9]+)')
 
 def parse_subtest_plan(lines: List[str]) -> int:
 	consume_non_diagnositic(lines)
@@ -234,11 +235,11 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
 	expected_test_case_num = parse_subtest_plan(lines)
 	if not expected_test_case_num:
 		return None
-	test_case = parse_test_case(lines, expected_test_case_num > 0)
-	expected_test_case_num -= 1
-	while test_case:
+	while expected_test_case_num > 0:
+		test_case = parse_test_case(lines)
+		if not test_case:
+			break
 		test_suite.cases.append(test_case)
-		test_case = parse_test_case(lines, expected_test_case_num > 0)
 		expected_test_case_num -= 1
 	if parse_ok_not_ok_test_suite(lines, test_suite):
 		test_suite.status = bubble_up_test_case_errors(test_suite)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index cba97756ac4a..984588d6ba95 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -37,7 +37,7 @@ class KconfigTest(unittest.TestCase):
 		self.assertTrue(kconfig0.is_subset_of(kconfig0))
 
 		kconfig1 = kunit_config.Kconfig()
-		kconfig1.add_entry(kunit_config.KconfigEntry('CONFIG_TEST=y'))
+		kconfig1.add_entry(kunit_config.KconfigEntry('TEST', 'y'))
 		self.assertTrue(kconfig1.is_subset_of(kconfig1))
 		self.assertTrue(kconfig0.is_subset_of(kconfig1))
 		self.assertFalse(kconfig1.is_subset_of(kconfig0))
@@ -51,15 +51,15 @@ class KconfigTest(unittest.TestCase):
 
 		expected_kconfig = kunit_config.Kconfig()
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_UML=y'))
+			kunit_config.KconfigEntry('UML', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_MMU=y'))
+			kunit_config.KconfigEntry('MMU', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_TEST=y'))
+			kunit_config.KconfigEntry('TEST', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_EXAMPLE_TEST=y'))
+			kunit_config.KconfigEntry('EXAMPLE_TEST', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('# CONFIG_MK8 is not set'))
+			kunit_config.KconfigEntry('MK8', 'n'))
 
 		self.assertEqual(kconfig.entries(), expected_kconfig.entries())
 
@@ -68,15 +68,15 @@ class KconfigTest(unittest.TestCase):
 
 		expected_kconfig = kunit_config.Kconfig()
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_UML=y'))
+			kunit_config.KconfigEntry('UML', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_MMU=y'))
+			kunit_config.KconfigEntry('MMU', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_TEST=y'))
+			kunit_config.KconfigEntry('TEST', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_EXAMPLE_TEST=y'))
+			kunit_config.KconfigEntry('EXAMPLE_TEST', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('# CONFIG_MK8 is not set'))
+			kunit_config.KconfigEntry('MK8', 'n'))
 
 		expected_kconfig.write_to_file(kconfig_path)
 
@@ -108,6 +108,36 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertContains('ok 1 - example', result)
 		file.close()
 
+	def test_output_with_prefix_isolated_correctly(self):
+		log_path = get_absolute_path(
+			'test_data/test_pound_sign.log')
+		with open(log_path) as file:
+			result = kunit_parser.isolate_kunit_output(file.readlines())
+		self.assertContains('TAP version 14\n', result)
+		self.assertContains('	# Subtest: kunit-resource-test', result)
+		self.assertContains('	1..5', result)
+		self.assertContains('	ok 1 - kunit_resource_test_init_resources', result)
+		self.assertContains('	ok 2 - kunit_resource_test_alloc_resource', result)
+		self.assertContains('	ok 3 - kunit_resource_test_destroy_resource', result)
+		self.assertContains(' foo bar 	#', result)
+		self.assertContains('	ok 4 - kunit_resource_test_cleanup_resources', result)
+		self.assertContains('	ok 5 - kunit_resource_test_proper_free_ordering', result)
+		self.assertContains('ok 1 - kunit-resource-test', result)
+		self.assertContains(' foo bar 	# non-kunit output', result)
+		self.assertContains('	# Subtest: kunit-try-catch-test', result)
+		self.assertContains('	1..2', result)
+		self.assertContains('	ok 1 - kunit_test_try_catch_successful_try_no_catch',
+				    result)
+		self.assertContains('	ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch',
+				    result)
+		self.assertContains('ok 2 - kunit-try-catch-test', result)
+		self.assertContains('	# Subtest: string-stream-test', result)
+		self.assertContains('	1..3', result)
+		self.assertContains('	ok 1 - string_stream_test_empty_on_creation', result)
+		self.assertContains('	ok 2 - string_stream_test_not_empty_after_add', result)
+		self.assertContains('	ok 3 - string_stream_test_get_string', result)
+		self.assertContains('ok 3 - string-stream-test', result)
+
 	def test_parse_successful_test_log(self):
 		all_passed_log = get_absolute_path(
 			'test_data/test_is_test_passed-all_passed.log')
@@ -150,6 +180,45 @@ class KUnitParserTest(unittest.TestCase):
 			result.status)
 		file.close()
 
+	def test_ignores_prefix_printk_time(self):
+		prefix_log = get_absolute_path(
+			'test_data/test_config_printk_time.log')
+		with open(prefix_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_ignores_multiple_prefixes(self):
+		prefix_log = get_absolute_path(
+			'test_data/test_multiple_prefixes.log')
+		with open(prefix_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_prefix_mixed_kernel_output(self):
+		mixed_prefix_log = get_absolute_path(
+			'test_data/test_interrupted_tap_output.log')
+		with open(mixed_prefix_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_prefix_poundsign(self):
+		pound_log = get_absolute_path('test_data/test_pound_sign.log')
+		with open(pound_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_kernel_panic_end(self):
+		panic_log = get_absolute_path('test_data/test_kernel_panic_interrupt.log')
+		with open(panic_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
+	def test_pound_no_prefix(self):
+		pound_log = get_absolute_path('test_data/test_pound_no_prefix.log')
+		with open(pound_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual('kunit-resource-test', result.suites[0].name)
+
 class StrContains(str):
 	def __eq__(self, other):
 		return self in other
@@ -174,7 +243,8 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=300)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			build_dir='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_fail(self):
@@ -189,25 +259,27 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_run_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		kunit.main(['run', '--raw_output'], self.linux_source_mock)
+		with self.assertRaises(SystemExit) as e:
+			kunit.main(['run', '--raw_output'], self.linux_source_mock)
+		assert type(e.exception) == SystemExit
+		assert e.exception.code == 1
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 1
-		for kall in self.print_mock.call_args_list:
-			assert kall != mock.call(StrContains('Testing complete.'))
-			assert kall != mock.call(StrContains(' 0 tests run'))
 
 	def test_run_timeout(self):
 		timeout = 3453
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=timeout)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			build_dir='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['run', '--build_dir', build_dir], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			build_dir=build_dir, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 if __name__ == '__main__':
diff --git a/tools/testing/kunit/test_data/test_config_printk_time.log b/tools/testing/kunit/test_data/test_config_printk_time.log
new file mode 100644
index 000000000000..c02ca773946d
Binary files /dev/null and b/tools/testing/kunit/test_data/test_config_printk_time.log differ
diff --git a/tools/testing/kunit/test_data/test_interrupted_tap_output.log b/tools/testing/kunit/test_data/test_interrupted_tap_output.log
new file mode 100644
index 000000000000..5c73fb3a1c6f
Binary files /dev/null and b/tools/testing/kunit/test_data/test_interrupted_tap_output.log differ
diff --git a/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log b/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log
new file mode 100644
index 000000000000..c045eee75f27
Binary files /dev/null and b/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log differ
diff --git a/tools/testing/kunit/test_data/test_multiple_prefixes.log b/tools/testing/kunit/test_data/test_multiple_prefixes.log
new file mode 100644
index 000000000000..bc48407dcc36
Binary files /dev/null and b/tools/testing/kunit/test_data/test_multiple_prefixes.log differ
diff --git a/tools/testing/kunit/test_data/test_output_with_prefix_isolated_correctly.log b/tools/testing/kunit/test_data/test_output_with_prefix_isolated_correctly.log
new file mode 100644
index 000000000000..0f87cdabebb0
Binary files /dev/null and b/tools/testing/kunit/test_data/test_output_with_prefix_isolated_correctly.log differ
diff --git a/tools/testing/kunit/test_data/test_pound_no_prefix.log b/tools/testing/kunit/test_data/test_pound_no_prefix.log
new file mode 100644
index 000000000000..2ceb360be7d5
Binary files /dev/null and b/tools/testing/kunit/test_data/test_pound_no_prefix.log differ
diff --git a/tools/testing/kunit/test_data/test_pound_sign.log b/tools/testing/kunit/test_data/test_pound_sign.log
new file mode 100644
index 000000000000..28ffa5ba03bf
Binary files /dev/null and b/tools/testing/kunit/test_data/test_pound_sign.log differ

--------------2A68A3C7E86FE0C0D99BB039--
