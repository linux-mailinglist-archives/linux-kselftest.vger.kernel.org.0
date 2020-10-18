Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA3429202A
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Oct 2020 23:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgJRVd4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 18 Oct 2020 17:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgJRVdz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 18 Oct 2020 17:33:55 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9197C0613CE
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Oct 2020 14:33:55 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r4so10819481ioh.0
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Oct 2020 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=7SFhWhCtqEqyEPfzgJoQsOkg59oQS9Jslb3StF5NbPM=;
        b=FlEO37vgDG6l1RAhCVgkK+sQlZjV0sDO/FqRDs2wZfDLTbEVNbzcNx/mnw+s5C5Bkw
         Pr4PHZ4pdgLdCy3suK+ImER+ogQro4rw1sM6/T79Hrwah6EG4KQPykReOWUxkR7dBS6W
         75/E1XsLSYQ+WJItvd/MSHsYiFFd6iD4pPUHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=7SFhWhCtqEqyEPfzgJoQsOkg59oQS9Jslb3StF5NbPM=;
        b=UZPTO0RRUaXGY97S6udN6UlcGNdfGopbcVBdHFokDTUj2XEcbmymtTsFphY4uX3Y7C
         /tMGCBrQvWxdO8PWQDmDNbIAMbLgsHp/J742y3p2E7BW9nAPP+oK6lbHBVwEwluNQ4P9
         +U+3S1KVxm8j39owIoYytYH6lshsMsLj4c8NMIVyFTBUxtynUF39rc263PbnqdWQn+hI
         r8d7itf1nk547B/KzSLlLQboJjeYsJtxhMSdkNsx5zOH7uynZ8xYuIOav5kLOZLN3iNk
         8qrXhq9WbsnSbql6iQmHrjshoN2wGOZvj2khSjgOfbz6lkhr0HgKK3t67tzSp0DE2uj/
         QsPA==
X-Gm-Message-State: AOAM5326as7jMDc4bMgQFMEunEbG6n2bzT4eO/8sLp8XV6mBxidkpB8i
        l8EIihTcaEHbYRK+WTEaJ+vmZg==
X-Google-Smtp-Source: ABdhPJy3K7In4uGktm9zCd6prQNN+0Do+W7cQUUfEisvlycXBIt1ZR3ssiOUz+SJ0aB8onfhXX2r0w==
X-Received: by 2002:a05:6638:d0c:: with SMTP id q12mr9256263jaj.95.1603056834888;
        Sun, 18 Oct 2020 14:33:54 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b9sm8646544ilq.51.2020.10.18.14.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 14:33:54 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kunit next update for Linux 5.10-rc1
Message-ID: <6ad05bbb-d437-57b8-25a6-fed80852ecec@linuxfoundation.org>
Date:   Sun, 18 Oct 2020 15:33:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------D4E78063255210154232B046"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------D4E78063255210154232B046
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kunit next update for Linux 5.10-rc1.

This Kunit update for Linux 5.10-rc1 consists of:

- add Kunit to kernel_init() and remove KUnit from init calls entirely.
   This addresses the concern Kunit would not work correctly during
   late init phase.
- add a linker section where KUnit can put references to its test
   suites.
   This patch is the first step in transitioning to dispatching all KUnit
   tests from a centralized executor rather than having each as its own
   separate late_initcall.
- add a centralized executor to dispatch tests rather than relying on
   late_initcall to schedule each test suite separately. Centralized
   execution is for built-in tests only; modules will execute tests when
   loaded.
- convert bitfield test to use KUnit framework
- Documentation updates for naming guidelines and how kunit_test_suite()
   works.
- add test plan to KUnit TAP format

diff is attached.

Please note that there is a conflict in lib/kunit/test.c

between commit:

   45dcbb6f5ef7 ("kunit: test: add test plan to KUnit TAP format")

from the kunit-next tree and commit:

e685acc91080 ("KUnit: KASAN Integration")

from the akpm-current tree. (now in master)

Stephen fixed this up in linux-next. Please let me know if you run
into any problems.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-5.10-rc1

for you to fetch changes up to 294a7f1613ee49a608361bd319519561c0ca7e72:

   lib: kunit: Fix compilation test when using TEST_BIT_FIELD_COMPILE 
(2020-10-16 13:25:14 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-5.10-rc1

This Kunit update for Linux 5.10-rc1 consists of:

- add Kunit to kernel_init() and remove KUnit from init calls entirely.
   This addresses the concern Kunit would not work correctly during
   late init phase.
- add a linker section where KUnit can put references to its test suites.
   This patch is the first step in transitioning to dispatching all KUnit
   tests from a centralized executor rather than having each as its own
   separate late_initcall.
- add a centralized executor to dispatch tests rather than relying on
   late_initcall to schedule each test suite separately. Centralized
   execution is for built-in tests only; modules will execute tests when
   loaded.
- convert bitfield test to use KUnit framework
- Documentation updates for naming guidelines and how kunit_test_suite()
   works.
- add test plan to KUnit TAP format

----------------------------------------------------------------
Alan Maguire (1):
       kunit: test: create a single centralized executor for all tests

Brendan Higgins (4):
       vmlinux.lds.h: add linker section for KUnit test suites
       init: main: add KUnit to kernel init
       kunit: test: add test plan to KUnit TAP format
       Documentation: kunit: add a brief blurb about kunit_test_suite

David Gow (1):
       Documentation: kunit: Add naming guidelines

Vitor Massaru Iha (2):
       lib: kunit: add bitfield test conversion to KUnit
       lib: kunit: Fix compilation test when using TEST_BIT_FIELD_COMPILE

  Documentation/dev-tools/kunit/index.rst            |   1 +
  Documentation/dev-tools/kunit/style.rst            | 205 
+++++++++++++++++++++
  Documentation/dev-tools/kunit/usage.rst            |   5 +
  include/asm-generic/vmlinux.lds.h                  |  10 +-
  include/kunit/test.h                               |  76 +++++---
  init/main.c                                        |   4 +
  lib/Kconfig.debug                                  |  23 ++-
lib/Makefile                                       |   2 +-
  lib/{test_bitfield.c => bitfield_kunit.c}          |  90 ++++-----
  lib/kunit/Makefile                                 |   3 +-
  lib/kunit/executor.c                               |  43 +++++
  lib/kunit/test.c                                   |  13 +-
  tools/testing/kunit/kunit_parser.py                |  76 ++++++--
  .../test_data/test_is_test_passed-all_passed.log   | Bin 1562 -> 1567 
bytes
  .../kunit/test_data/test_is_test_passed-crash.log  | Bin 3016 -> 3021 
bytes
  .../test_data/test_is_test_passed-failure.log      | Bin 1700 -> 1705 
bytes
  16 files changed, 441 insertions(+), 110 deletions(-)
  create mode 100644 Documentation/dev-tools/kunit/style.rst
  rename lib/{test_bitfield.c => bitfield_kunit.c} (67%)
  create mode 100644 lib/kunit/executor.c
----------------------------------------------------------------

--------------D4E78063255210154232B046
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.10-rc1.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.10-rc1.diff"

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index e93606ecfb01..c234a3ab3c34 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -11,6 +11,7 @@ KUnit - Unit Testing for the Linux Kernel
 	usage
 	kunit-tool
 	api/index
+	style
 	faq
 
 What is KUnit?
diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
new file mode 100644
index 000000000000..da1d6f0ed6bc
--- /dev/null
+++ b/Documentation/dev-tools/kunit/style.rst
@@ -0,0 +1,205 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+Test Style and Nomenclature
+===========================
+
+To make finding, writing, and using KUnit tests as simple as possible, it's
+strongly encouraged that they are named and written according to the guidelines
+below. While it's possible to write KUnit tests which do not follow these rules,
+they may break some tooling, may conflict with other tests, and may not be run
+automatically by testing systems.
+
+It's recommended that you only deviate from these guidelines when:
+
+1. Porting tests to KUnit which are already known with an existing name, or
+2. Writing tests which would cause serious problems if automatically run (e.g.,
+   non-deterministically producing false positives or negatives, or taking an
+   extremely long time to run).
+
+Subsystems, Suites, and Tests
+=============================
+
+In order to make tests as easy to find as possible, they're grouped into suites
+and subsystems. A test suite is a group of tests which test a related area of
+the kernel, and a subsystem is a set of test suites which test different parts
+of the same kernel subsystem or driver.
+
+Subsystems
+----------
+
+Every test suite must belong to a subsystem. A subsystem is a collection of one
+or more KUnit test suites which test the same driver or part of the kernel. A
+rule of thumb is that a test subsystem should match a single kernel module. If
+the code being tested can't be compiled as a module, in many cases the subsystem
+should correspond to a directory in the source tree or an entry in the
+MAINTAINERS file. If unsure, follow the conventions set by tests in similar
+areas.
+
+Test subsystems should be named after the code being tested, either after the
+module (wherever possible), or after the directory or files being tested. Test
+subsystems should be named to avoid ambiguity where necessary.
+
+If a test subsystem name has multiple components, they should be separated by
+underscores. *Do not* include "test" or "kunit" directly in the subsystem name
+unless you are actually testing other tests or the kunit framework itself.
+
+Example subsystems could be:
+
+``ext4``
+  Matches the module and filesystem name.
+``apparmor``
+  Matches the module name and LSM name.
+``kasan``
+  Common name for the tool, prominent part of the path ``mm/kasan``
+``snd_hda_codec_hdmi``
+  Has several components (``snd``, ``hda``, ``codec``, ``hdmi``) separated by
+  underscores. Matches the module name.
+
+Avoid names like these:
+
+``linear-ranges``
+  Names should use underscores, not dashes, to separate words. Prefer
+  ``linear_ranges``.
+``qos-kunit-test``
+  As well as using underscores, this name should not have "kunit-test" as a
+  suffix, and ``qos`` is ambiguous as a subsystem name. ``power_qos`` would be a
+  better name.
+``pc_parallel_port``
+  The corresponding module name is ``parport_pc``, so this subsystem should also
+  be named ``parport_pc``.
+
+.. note::
+        The KUnit API and tools do not explicitly know about subsystems. They're
+        simply a way of categorising test suites and naming modules which
+        provides a simple, consistent way for humans to find and run tests. This
+        may change in the future, though.
+
+Suites
+------
+
+KUnit tests are grouped into test suites, which cover a specific area of
+functionality being tested. Test suites can have shared initialisation and
+shutdown code which is run for all tests in the suite.
+Not all subsystems will need to be split into multiple test suites (e.g. simple drivers).
+
+Test suites are named after the subsystem they are part of. If a subsystem
+contains several suites, the specific area under test should be appended to the
+subsystem name, separated by an underscore.
+
+In the event that there are multiple types of test using KUnit within a
+subsystem (e.g., both unit tests and integration tests), they should be put into
+separate suites, with the type of test as the last element in the suite name.
+Unless these tests are actually present, avoid using ``_test``, ``_unittest`` or
+similar in the suite name.
+
+The full test suite name (including the subsystem name) should be specified as
+the ``.name`` member of the ``kunit_suite`` struct, and forms the base for the
+module name (see below).
+
+Example test suites could include:
+
+``ext4_inode``
+  Part of the ``ext4`` subsystem, testing the ``inode`` area.
+``kunit_try_catch``
+  Part of the ``kunit`` implementation itself, testing the ``try_catch`` area.
+``apparmor_property_entry``
+  Part of the ``apparmor`` subsystem, testing the ``property_entry`` area.
+``kasan``
+  The ``kasan`` subsystem has only one suite, so the suite name is the same as
+  the subsystem name.
+
+Avoid names like:
+
+``ext4_ext4_inode``
+  There's no reason to state the subsystem twice.
+``property_entry``
+  The suite name is ambiguous without the subsystem name.
+``kasan_integration_test``
+  Because there is only one suite in the ``kasan`` subsystem, the suite should
+  just be called ``kasan``. There's no need to redundantly add
+  ``integration_test``. Should a separate test suite with, for example, unit
+  tests be added, then that suite could be named ``kasan_unittest`` or similar.
+
+Test Cases
+----------
+
+Individual tests consist of a single function which tests a constrained
+codepath, property, or function. In the test output, individual tests' results
+will show up as subtests of the suite's results.
+
+Tests should be named after what they're testing. This is often the name of the
+function being tested, with a description of the input or codepath being tested.
+As tests are C functions, they should be named and written in accordance with
+the kernel coding style.
+
+.. note::
+        As tests are themselves functions, their names cannot conflict with
+        other C identifiers in the kernel. This may require some creative
+        naming. It's a good idea to make your test functions `static` to avoid
+        polluting the global namespace.
+
+Example test names include:
+
+``unpack_u32_with_null_name``
+  Tests the ``unpack_u32`` function when a NULL name is passed in.
+``test_list_splice``
+  Tests the ``list_splice`` macro. It has the prefix ``test_`` to avoid a
+  name conflict with the macro itself.
+
+
+Should it be necessary to refer to a test outside the context of its test suite,
+the *fully-qualified* name of a test should be the suite name followed by the
+test name, separated by a colon (i.e. ``suite:test``).
+
+Test Kconfig Entries
+====================
+
+Every test suite should be tied to a Kconfig entry.
+
+This Kconfig entry must:
+
+* be named ``CONFIG_<name>_KUNIT_TEST``: where <name> is the name of the test
+  suite.
+* be listed either alongside the config entries for the driver/subsystem being
+  tested, or be under [Kernel Hacking]→[Kernel Testing and Coverage]
+* depend on ``CONFIG_KUNIT``
+* be visible only if ``CONFIG_KUNIT_ALL_TESTS`` is not enabled.
+* have a default value of ``CONFIG_KUNIT_ALL_TESTS``.
+* have a brief description of KUnit in the help text
+
+Unless there's a specific reason not to (e.g. the test is unable to be built as
+a module), Kconfig entries for tests should be tristate.
+
+An example Kconfig entry:
+
+.. code-block:: none
+
+        config FOO_KUNIT_TEST
+                tristate "KUnit test for foo" if !KUNIT_ALL_TESTS
+                depends on KUNIT
+                default KUNIT_ALL_TESTS
+                help
+                    This builds unit tests for foo.
+
+                    For more information on KUnit and unit tests in general, please refer
+                    to the KUnit documentation in Documentation/dev-tools/kunit
+
+                    If unsure, say N
+
+
+Test File and Module Names
+==========================
+
+KUnit tests can often be compiled as a module. These modules should be named
+after the test suite, followed by ``_test``. If this is likely to conflict with
+non-KUnit tests, the suffix ``_kunit`` can also be used.
+
+The easiest way of achieving this is to name the file containing the test suite
+``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
+placed next to the code under test.
+
+If the suite name contains some or all of the name of the test's parent
+directory, it may make sense to modify the source filename to reduce redundancy.
+For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.c``
+file.
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 3c3fe8b5fecc..961d3ea3ca19 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -211,6 +211,11 @@ KUnit test framework.
 .. note::
    A test case will only be run if it is associated with a test suite.
 
+``kunit_test_suite(...)`` is a macro which tells the linker to put the specified
+test suite in a special linker section so that it can be run by KUnit either
+after late_init, or when the test module is loaded (depending on whether the
+test was built in or not).
+
 For more information on these types of things see the :doc:`api/test`.
 
 Isolating Behavior
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5430febd34be..31e08674b542 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -717,7 +717,8 @@
 	THERMAL_TABLE(governor)						\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
-	EARLY_LSM_TABLE()
+	EARLY_LSM_TABLE()						\
+	KUNIT_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
@@ -909,6 +910,13 @@
 		KEEP(*(.con_initcall.init))				\
 		__con_initcall_end = .;
 
+/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
+#define KUNIT_TABLE()							\
+		. = ALIGN(8);						\
+		__kunit_suites_start = .;				\
+		KEEP(*(.kunit_test_suites))				\
+		__kunit_suites_end = .;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 59f3144f009a..7ea24466e49c 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -233,10 +233,19 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
 unsigned int kunit_test_case_num(struct kunit_suite *suite,
 				 struct kunit_case *test_case);
 
-int __kunit_test_suites_init(struct kunit_suite **suites);
+int __kunit_test_suites_init(struct kunit_suite * const * const suites);
 
 void __kunit_test_suites_exit(struct kunit_suite **suites);
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+int kunit_run_all_tests(void);
+#else
+static inline int kunit_run_all_tests(void)
+{
+	return 0;
+}
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 /**
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
@@ -246,34 +255,57 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
  * Registers @suites_list with the test framework. See &struct kunit_suite for
  * more information.
  *
- * When builtin, KUnit tests are all run as late_initcalls; this means
- * that they cannot test anything where tests must run at a different init
- * phase. One significant restriction resulting from this is that KUnit
- * cannot reliably test anything that is initialize in the late_init phase;
- * another is that KUnit is useless to test things that need to be run in
- * an earlier init phase.
- *
- * An alternative is to build the tests as a module.  Because modules
- * do not support multiple late_initcall()s, we need to initialize an
- * array of suites for a module.
- *
- * TODO(brendanhiggins@google.com): Don't run all KUnit tests as
- * late_initcalls.  I have some future work planned to dispatch all KUnit
- * tests from the same place, and at the very least to do so after
- * everything else is definitely initialized.
+ * If a test suite is built-in, module_init() gets translated into
+ * an initcall which we don't want as the idea is that for builtins
+ * the executor will manage execution.  So ensure we do not define
+ * module_{init|exit} functions for the builtin case when registering
+ * suites via kunit_test_suites() below.
  */
-#define kunit_test_suites(suites_list...)				\
-	static struct kunit_suite *suites[] = {suites_list, NULL};	\
-	static int kunit_test_suites_init(void)				\
+#ifdef MODULE
+#define kunit_test_suites_for_module(__suites)				\
+	static int __init kunit_test_suites_init(void)			\
 	{								\
-		return __kunit_test_suites_init(suites);		\
+		return __kunit_test_suites_init(__suites);		\
 	}								\
-	late_initcall(kunit_test_suites_init);				\
+	module_init(kunit_test_suites_init);				\
+									\
 	static void __exit kunit_test_suites_exit(void)			\
 	{								\
-		return __kunit_test_suites_exit(suites);		\
+		return __kunit_test_suites_exit(__suites);		\
 	}								\
 	module_exit(kunit_test_suites_exit)
+#else
+#define kunit_test_suites_for_module(__suites)
+#endif /* MODULE */
+
+#define __kunit_test_suites(unique_array, unique_suites, ...)		       \
+	static struct kunit_suite *unique_array[] = { __VA_ARGS__, NULL };     \
+	kunit_test_suites_for_module(unique_array);			       \
+	static struct kunit_suite **unique_suites			       \
+	__used __section(.kunit_test_suites) = unique_array
+
+/**
+ * kunit_test_suites() - used to register one or more &struct kunit_suite
+ *			 with KUnit.
+ *
+ * @suites: a statically allocated list of &struct kunit_suite.
+ *
+ * Registers @suites with the test framework. See &struct kunit_suite for
+ * more information.
+ *
+ * When builtin,  KUnit tests are all run via executor; this is done
+ * by placing the array of struct kunit_suite * in the .kunit_test_suites
+ * ELF section.
+ *
+ * An alternative is to build the tests as a module.  Because modules do not
+ * support multiple initcall()s, we need to initialize an array of suites for a
+ * module.
+ *
+ */
+#define kunit_test_suites(...)						\
+	__kunit_test_suites(__UNIQUE_ID(array),				\
+			    __UNIQUE_ID(suites),			\
+			    __VA_ARGS__)
 
 #define kunit_test_suite(suite)	kunit_test_suites(&suite)
 
diff --git a/init/main.c b/init/main.c
index ae78fb68d231..232c8df465ee 100644
--- a/init/main.c
+++ b/init/main.c
@@ -107,6 +107,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/initcall.h>
 
+#include <kunit/test.h>
+
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
@@ -1511,6 +1513,8 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
+	kunit_run_all_tests();
+
 	console_on_rootfs();
 
 	/*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e068c3c7189a..4f09c6505a2e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2037,13 +2037,6 @@ config TEST_BITMAP
 
 	  If unsure, say N.
 
-config TEST_BITFIELD
-	tristate "Test bitfield functions at runtime"
-	help
-	  Enable this option to test the bitfield functions at boot.
-
-	  If unsure, say N.
-
 config TEST_UUID
 	tristate "Test functions located in the uuid module at runtime"
 
@@ -2193,6 +2186,22 @@ config TEST_SYSCTL
 
 	  If unsure, say N.
 
+config BITFIELD_KUNIT
+	tristate "KUnit test bitfield functions at runtime"
+	depends on KUNIT
+	help
+	  Enable this option to test the bitfield functions at boot.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running the KUnit test harness, and not intended for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config SYSCTL_KUNIT_TEST
 	tristate "KUnit test for sysctl" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index e290fc5707ea..d862d41fdc3d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -80,7 +80,6 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
-obj-$(CONFIG_TEST_BITFIELD) += test_bitfield.o
 obj-$(CONFIG_TEST_UUID) += test_uuid.o
 obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
 obj-$(CONFIG_TEST_PARMAN) += test_parman.o
@@ -340,6 +339,7 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 obj-$(CONFIG_PLDMFW) += pldmfw/
 
 # KUnit tests
+obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
diff --git a/lib/test_bitfield.c b/lib/bitfield_kunit.c
similarity index 67%
rename from lib/test_bitfield.c
rename to lib/bitfield_kunit.c
index 5b8f4108662d..1473d8b4bf0f 100644
--- a/lib/test_bitfield.c
+++ b/lib/bitfield_kunit.c
@@ -5,8 +5,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <kunit/test.h>
 #include <linux/bitfield.h>
 
 #define CHECK_ENC_GET_U(tp, v, field, res) do {				\
@@ -14,13 +13,11 @@
 			u##tp _res;					\
 									\
 			_res = u##tp##_encode_bits(v, field);		\
-			if (_res != res) {				\
-				pr_warn("u" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != " #res "\n",\
-					(u64)_res);			\
-				return -EINVAL;				\
-			}						\
-			if (u##tp##_get_bits(_res, field) != v)		\
-				return -EINVAL;				\
+			KUNIT_ASSERT_FALSE_MSG(context, _res != res,	\
+				       "u" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != " #res "\n",	\
+				       (u64)_res);			\
+			KUNIT_ASSERT_FALSE(context,			\
+				   u##tp##_get_bits(_res, field) != v);	\
 		}							\
 	} while (0)
 
@@ -29,14 +26,13 @@
 			__le##tp _res;					\
 									\
 			_res = le##tp##_encode_bits(v, field);		\
-			if (_res != cpu_to_le##tp(res)) {		\
-				pr_warn("le" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx\n",\
-					(u64)le##tp##_to_cpu(_res),	\
-					(u64)(res));			\
-				return -EINVAL;				\
-			}						\
-			if (le##tp##_get_bits(_res, field) != v)	\
-				return -EINVAL;				\
+			KUNIT_ASSERT_FALSE_MSG(context,			\
+				       _res != cpu_to_le##tp(res),	\
+				       "le" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx",\
+				       (u64)le##tp##_to_cpu(_res),	\
+				       (u64)(res));			\
+			KUNIT_ASSERT_FALSE(context,			\
+				   le##tp##_get_bits(_res, field) != v);\
 		}							\
 	} while (0)
 
@@ -45,14 +41,13 @@
 			__be##tp _res;					\
 									\
 			_res = be##tp##_encode_bits(v, field);		\
-			if (_res != cpu_to_be##tp(res)) {		\
-				pr_warn("be" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx\n",\
-					(u64)be##tp##_to_cpu(_res),	\
-					(u64)(res));			\
-				return -EINVAL;				\
-			}						\
-			if (be##tp##_get_bits(_res, field) != v)	\
-				return -EINVAL;				\
+			KUNIT_ASSERT_FALSE_MSG(context,			\
+				       _res != cpu_to_be##tp(res),	\
+				       "be" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx",	\
+				       (u64)be##tp##_to_cpu(_res),	\
+				       (u64)(res));			\
+			KUNIT_ASSERT_FALSE(context,			\
+				   be##tp##_get_bits(_res, field) != v);\
 		}							\
 	} while (0)
 
@@ -62,7 +57,7 @@
 		CHECK_ENC_GET_BE(tp, v, field, res);			\
 	} while (0)
 
-static int test_constants(void)
+static void __init test_bitfields_constants(struct kunit *context)
 {
 	/*
 	 * NOTE
@@ -95,19 +90,17 @@ static int test_constants(void)
 	CHECK_ENC_GET(64,  7, 0x00f0000000000000ull, 0x0070000000000000ull);
 	CHECK_ENC_GET(64, 14, 0x0f00000000000000ull, 0x0e00000000000000ull);
 	CHECK_ENC_GET(64, 15, 0xf000000000000000ull, 0xf000000000000000ull);
-
-	return 0;
 }
 
 #define CHECK(tp, mask) do {						\
 		u64 v;							\
 									\
 		for (v = 0; v < 1 << hweight32(mask); v++)		\
-			if (tp##_encode_bits(v, mask) != v << __ffs64(mask)) \
-				return -EINVAL;				\
+			KUNIT_ASSERT_FALSE(context,			\
+				tp##_encode_bits(v, mask) != v << __ffs64(mask));\
 	} while (0)
 
-static int test_variables(void)
+static void __init test_bitfields_variables(struct kunit *context)
 {
 	CHECK(u8, 0x0f);
 	CHECK(u8, 0xf0);
@@ -130,39 +123,32 @@ static int test_variables(void)
 	CHECK(u64, 0x000000007f000000ull);
 	CHECK(u64, 0x0000000018000000ull);
 	CHECK(u64, 0x0000001f8000000ull);
-
-	return 0;
 }
 
-static int __init test_bitfields(void)
-{
-	int ret = test_constants();
-
-	if (ret) {
-		pr_warn("constant tests failed!\n");
-		return ret;
-	}
-
-	ret = test_variables();
-	if (ret) {
-		pr_warn("variable tests failed!\n");
-		return ret;
-	}
-
 #ifdef TEST_BITFIELD_COMPILE
+static void __init test_bitfields_compile(struct kunit *context)
+{
 	/* these should fail compilation */
 	CHECK_ENC_GET(16, 16, 0x0f00, 0x1000);
 	u32_encode_bits(7, 0x06000000);
 
 	/* this should at least give a warning */
 	u16_encode_bits(0, 0x60000);
+}
 #endif
 
-	pr_info("tests passed\n");
+static struct kunit_case __refdata bitfields_test_cases[] = {
+	KUNIT_CASE(test_bitfields_constants),
+	KUNIT_CASE(test_bitfields_variables),
+	{}
+};
 
-	return 0;
-}
-module_init(test_bitfields)
+static struct kunit_suite bitfields_test_suite = {
+	.name = "bitfields",
+	.test_cases = bitfields_test_cases,
+};
+
+kunit_test_suites(&bitfields_test_suite);
 
 MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
 MODULE_LICENSE("GPL");
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 724b94311ca3..c49f4ffb6273 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -3,7 +3,8 @@ obj-$(CONFIG_KUNIT) +=			kunit.o
 kunit-objs +=				test.o \
 					string-stream.o \
 					assert.o \
-					try-catch.o
+					try-catch.o \
+					executor.o
 
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
new file mode 100644
index 000000000000..a95742a4ece7
--- /dev/null
+++ b/lib/kunit/executor.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/test.h>
+
+/*
+ * These symbols point to the .kunit_test_suites section and are defined in
+ * include/asm-generic/vmlinux.lds.h, and consequently must be extern.
+ */
+extern struct kunit_suite * const * const __kunit_suites_start[];
+extern struct kunit_suite * const * const __kunit_suites_end[];
+
+#if IS_BUILTIN(CONFIG_KUNIT)
+
+static void kunit_print_tap_header(void)
+{
+	struct kunit_suite * const * const *suites, * const *subsuite;
+	int num_of_suites = 0;
+
+	for (suites = __kunit_suites_start;
+	     suites < __kunit_suites_end;
+	     suites++)
+		for (subsuite = *suites; *subsuite != NULL; subsuite++)
+			num_of_suites++;
+
+	pr_info("TAP version 14\n");
+	pr_info("1..%d\n", num_of_suites);
+}
+
+int kunit_run_all_tests(void)
+{
+	struct kunit_suite * const * const *suites;
+
+	kunit_print_tap_header();
+
+	for (suites = __kunit_suites_start;
+	     suites < __kunit_suites_end;
+	     suites++)
+			__kunit_test_suites_init(*suites);
+
+	return 0;
+}
+
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c36037200310..de07876b6601 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -20,16 +20,6 @@ static void kunit_set_failure(struct kunit *test)
 	WRITE_ONCE(test->success, false);
 }
 
-static void kunit_print_tap_version(void)
-{
-	static bool kunit_has_printed_tap_version;
-
-	if (!kunit_has_printed_tap_version) {
-		pr_info("TAP version 14\n");
-		kunit_has_printed_tap_version = true;
-	}
-}
-
 /*
  * Append formatted message to log, size of which is limited to
  * KUNIT_LOG_SIZE bytes (including null terminating byte).
@@ -69,7 +59,6 @@ EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
 
 static void kunit_print_subtest_start(struct kunit_suite *suite)
 {
-	kunit_print_tap_version();
 	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
 		  suite->name);
 	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
@@ -381,7 +370,7 @@ static void kunit_init_suite(struct kunit_suite *suite)
 	kunit_debugfs_create_suite(suite);
 }
 
-int __kunit_test_suites_init(struct kunit_suite **suites)
+int __kunit_test_suites_init(struct kunit_suite * const * const suites)
 {
 	unsigned int i;
 
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index f13e0c0d6663..8019e3dd4c32 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -45,10 +45,11 @@ class TestStatus(Enum):
 	FAILURE = auto()
 	TEST_CRASHED = auto()
 	NO_TESTS = auto()
+	FAILURE_TO_PARSE_TESTS = auto()
 
 kunit_start_re = re.compile(r'TAP version [0-9]+$')
 kunit_end_re = re.compile('(List of all partitions:|'
-			  'Kernel panic - not syncing: VFS:|reboot: System halted)')
+			  'Kernel panic - not syncing: VFS:)')
 
 def isolate_kunit_output(kernel_output):
 	started = False
@@ -109,7 +110,7 @@ OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
 
 OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
 
-OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) [0-9]+ - (.*)$')
+OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
 
 def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
 	save_non_diagnositic(lines, test_case)
@@ -197,7 +198,9 @@ def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
 	else:
 		return TestStatus.SUCCESS
 
-def parse_ok_not_ok_test_suite(lines: List[str], test_suite: TestSuite) -> bool:
+def parse_ok_not_ok_test_suite(lines: List[str],
+			       test_suite: TestSuite,
+			       expected_suite_index: int) -> bool:
 	consume_non_diagnositic(lines)
 	if not lines:
 		test_suite.status = TestStatus.TEST_CRASHED
@@ -210,6 +213,12 @@ def parse_ok_not_ok_test_suite(lines: List[str], test_suite: TestSuite) -> bool:
 			test_suite.status = TestStatus.SUCCESS
 		else:
 			test_suite.status = TestStatus.FAILURE
+		suite_index = int(match.group(2))
+		if suite_index != expected_suite_index:
+			print_with_timestamp(
+				red('[ERROR] ') + 'expected_suite_index ' +
+				str(expected_suite_index) + ', but got ' +
+				str(suite_index))
 		return True
 	else:
 		return False
@@ -222,7 +231,7 @@ def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
 	max_test_case_status = bubble_up_errors(lambda x: x.status, test_suite.cases)
 	return max_status(max_test_case_status, test_suite.status)
 
-def parse_test_suite(lines: List[str]) -> TestSuite:
+def parse_test_suite(lines: List[str], expected_suite_index: int) -> TestSuite:
 	if not lines:
 		return None
 	consume_non_diagnositic(lines)
@@ -241,7 +250,7 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
 			break
 		test_suite.cases.append(test_case)
 		expected_test_case_num -= 1
-	if parse_ok_not_ok_test_suite(lines, test_suite):
+	if parse_ok_not_ok_test_suite(lines, test_suite, expected_suite_index):
 		test_suite.status = bubble_up_test_case_errors(test_suite)
 		return test_suite
 	elif not lines:
@@ -261,6 +270,17 @@ def parse_tap_header(lines: List[str]) -> bool:
 	else:
 		return False
 
+TEST_PLAN = re.compile(r'[0-9]+\.\.([0-9]+)')
+
+def parse_test_plan(lines: List[str]) -> int:
+	consume_non_diagnositic(lines)
+	match = TEST_PLAN.match(lines[0])
+	if match:
+		lines.pop(0)
+		return int(match.group(1))
+	else:
+		return None
+
 def bubble_up_suite_errors(test_suite_list: List[TestSuite]) -> TestStatus:
 	return bubble_up_errors(lambda x: x.status, test_suite_list)
 
@@ -268,20 +288,33 @@ def parse_test_result(lines: List[str]) -> TestResult:
 	consume_non_diagnositic(lines)
 	if not lines or not parse_tap_header(lines):
 		return TestResult(TestStatus.NO_TESTS, [], lines)
+	expected_test_suite_num = parse_test_plan(lines)
+	if not expected_test_suite_num:
+		return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
 	test_suites = []
-	test_suite = parse_test_suite(lines)
-	while test_suite:
-		test_suites.append(test_suite)
-		test_suite = parse_test_suite(lines)
-	return TestResult(bubble_up_suite_errors(test_suites), test_suites, lines)
+	for i in range(1, expected_test_suite_num + 1):
+		test_suite = parse_test_suite(lines, i)
+		if test_suite:
+			test_suites.append(test_suite)
+		else:
+			print_with_timestamp(
+				red('[ERROR] ') + ' expected ' +
+				str(expected_test_suite_num) +
+				' test suites, but got ' + str(i - 2))
+			break
+	test_suite = parse_test_suite(lines, -1)
+	if test_suite:
+		print_with_timestamp(red('[ERROR] ') +
+			'got unexpected test suite: ' + test_suite.name)
+	if test_suites:
+		return TestResult(bubble_up_suite_errors(test_suites), test_suites, lines)
+	else:
+		return TestResult(TestStatus.NO_TESTS, [], lines)
 
-def parse_run_tests(kernel_output) -> TestResult:
+def print_and_count_results(test_result: TestResult) -> None:
 	total_tests = 0
 	failed_tests = 0
 	crashed_tests = 0
-	test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
-	if test_result.status == TestStatus.NO_TESTS:
-		print_with_timestamp(red('[ERROR] ') + 'no kunit output detected')
 	for test_suite in test_result.suites:
 		if test_suite.status == TestStatus.SUCCESS:
 			print_suite_divider(green('[PASSED] ') + test_suite.name)
@@ -303,6 +336,21 @@ def parse_run_tests(kernel_output) -> TestResult:
 				print_with_timestamp(red('[FAILED] ') + test_case.name)
 				print_log(map(yellow, test_case.log))
 				print_with_timestamp('')
+	return total_tests, failed_tests, crashed_tests
+
+def parse_run_tests(kernel_output) -> TestResult:
+	total_tests = 0
+	failed_tests = 0
+	crashed_tests = 0
+	test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
+	if test_result.status == TestStatus.NO_TESTS:
+		print(red('[ERROR] ') + yellow('no tests run!'))
+	elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
+		print(red('[ERROR] ') + yellow('could not parse test results!'))
+	else:
+		(total_tests,
+		 failed_tests,
+		 crashed_tests) = print_and_count_results(test_result)
 	print_with_timestamp(DIVIDER)
 	fmt = green if test_result.status == TestStatus.SUCCESS else red
 	print_with_timestamp(
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log b/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
index 62ebc0288355..bc0dc8fe35b7 100644
Binary files a/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log and b/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log differ
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-crash.log b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
index 0b249870c8be..4d97f6708c4a 100644
Binary files a/tools/testing/kunit/test_data/test_is_test_passed-crash.log and b/tools/testing/kunit/test_data/test_is_test_passed-crash.log differ
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure.log b/tools/testing/kunit/test_data/test_is_test_passed-failure.log
index 9e89d32d5667..7a416497e3be 100644
Binary files a/tools/testing/kunit/test_data/test_is_test_passed-failure.log and b/tools/testing/kunit/test_data/test_is_test_passed-failure.log differ

--------------D4E78063255210154232B046--
