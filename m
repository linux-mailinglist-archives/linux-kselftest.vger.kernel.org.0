Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE214D0B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2020 19:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgA2SsL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jan 2020 13:48:11 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:38867 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgA2SsK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jan 2020 13:48:10 -0500
Received: by mail-il1-f194.google.com with SMTP id f5so786111ilq.5
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2020 10:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=D0bEJJ1a4++6y4/p7kp90UaO28AhGCLzaUpSiPWEDFI=;
        b=fzUjojcY2MvsdyZGEKaPXQqWh1L6AEojwytgIHXKf6sAYgnP/A+w73NblRdF5GCrA0
         6fwp4yBS5k5tYd8HnIqx+AajYuUVrkHkL42sLtjIqhUe/N0J05/a+xk5njWeeGpUM6UF
         TsESJycAMbapkpED1ZrQvaH6c/O0r35BIJuow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=D0bEJJ1a4++6y4/p7kp90UaO28AhGCLzaUpSiPWEDFI=;
        b=Dw/uG5iOpKGJJh2NQDbmpkStstfLTZm6MAoy7oaK2ibrVTK0HHXiYFkab3qd3LyCkR
         dz8/FI2XdxDXQ0cP8v9X2t/NsJ0VXncA56kSYVfxXfKEGxj2fspNb2UgJNkWds/7j83b
         xnG9oy0vEEWchJmuoRuZeT0IOu4LM/52jBbr/yU0hWs6VvolgH/xJFQPxLsDE7SvaYfl
         I+sE+s+Lek/pNWguvXpSnUOEqo4wcP3rGnUoNX1AsVyUbVxhMyzBhqRXtYdLJ/6gFNb2
         TYAKXK+039t/Wc2zxlAGvDNiuK5eBmpCUWhITeJz8i5o+NbQw4r+hjnqQA90KWdIrk5q
         Vvvg==
X-Gm-Message-State: APjAAAWaEz6IpdA2bThsKyyznlgVKEH/EieouPAzkbdBErqnPqL7ew3e
        60d8ptgTHRpxc5AVfCrGGfSerQ==
X-Google-Smtp-Source: APXvYqwxxX6IETQTvXugr8CExXc3RTocynp+JcUsYfQc1GvOuxvVCzEtcxc4KIUAw4z9neJjc2J93w==
X-Received: by 2002:a92:c848:: with SMTP id b8mr694447ilq.168.1580323689403;
        Wed, 29 Jan 2020 10:48:09 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c8sm981412ilh.58.2020.01.29.10.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 10:48:08 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest kunit update for Linux 5.6-rc1
Message-ID: <5d0a37f1-f857-eadf-5e20-872ca6c7f656@linuxfoundation.org>
Date:   Wed, 29 Jan 2020 11:48:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------7408E280292BCD3F101B597F"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------7408E280292BCD3F101B597F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest kunit update for Linux 5.6-rc1

This kunit update for Linux 5.6-rc1 consists of:

-- Support for building kunit as a module from Alan Maguire
-- AppArmor KUnit tests for policy unpack from Mike Salvatore

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

   Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.6-rc1-kunit

for you to fetch changes up to 35c57fc3f8eac81b38664a0fe160e267b908d8b8:

   kunit: building kunit as a module breaks allmodconfig (2020-01-10 
14:36:37 -0700)

----------------------------------------------------------------
linux-kselftest-5.6-rc1-kunit

This kunit update for Linux 5.6-rc1 consists of:

-- Support for building kunit as a module from Alan Maguire
-- AppArmor KUnit tests for policy unpack from Mike Salvatore

----------------------------------------------------------------
Alan Maguire (7):
       kunit: move string-stream.h to lib/kunit
       kunit: hide unexported try-catch interface in try-catch-impl.h
       kunit: allow kunit tests to be loaded as a module
       kunit: remove timeout dependence on sysctl_hung_task_timeout_seconds
       kunit: allow kunit to be loaded as a module
       kunit: update documentation to describe module-based build
       kunit: building kunit as a module breaks allmodconfig

Mike Salvatore (1):
       apparmor: add AppArmor KUnit tests for policy unpack

  Documentation/dev-tools/kunit/faq.rst              |   3 +-
  Documentation/dev-tools/kunit/index.rst            |   3 +
  Documentation/dev-tools/kunit/usage.rst            |  16 +
  drivers/base/Kconfig                               |   2 +-
  drivers/base/power/qos-test.c                      |   2 +-
  fs/ext4/Kconfig                                    |   2 +-
  fs/ext4/Makefile                                   |   3 +-
  fs/ext4/inode-test.c                               |   4 +-
  include/kunit/assert.h                             |   3 +-
  include/kunit/test.h                               |  37 +-
  include/kunit/try-catch.h                          |  10 -
  kernel/sysctl-test.c                               |   4 +-
  lib/Kconfig.debug                                  |   4 +-
  lib/kunit/Kconfig                                  |   6 +-
  lib/kunit/Makefile                                 |  14 +-
  lib/kunit/assert.c                                 |  10 +
  lib/kunit/{example-test.c => kunit-example-test.c} |   4 +-
  lib/kunit/{test-test.c => kunit-test.c}            |   7 +-
  lib/kunit/string-stream-test.c                     |   5 +-
  lib/kunit/string-stream.c                          |   3 +-
  {include => lib}/kunit/string-stream.h             |   0
  lib/kunit/test.c                                   |  25 +-
  lib/kunit/try-catch-impl.h                         |  27 +
  lib/kunit/try-catch.c                              |  37 +-
  lib/list-test.c                                    |   4 +-
  security/apparmor/Kconfig                          |  16 +
  security/apparmor/policy_unpack.c                  |   4 +
  security/apparmor/policy_unpack_test.c             | 607 
+++++++++++++++++++++
  28 files changed, 788 insertions(+), 74 deletions(-)
  rename lib/kunit/{example-test.c => kunit-example-test.c} (97%)
  rename lib/kunit/{test-test.c => kunit-test.c} (98%)
  rename {include => lib}/kunit/string-stream.h (100%)
  create mode 100644 lib/kunit/try-catch-impl.h
  create mode 100644 security/apparmor/policy_unpack_test.c

----------------------------------------------------------------

--------------7408E280292BCD3F101B597F
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.6-rc1-kunit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.6-rc1-kunit.diff"

diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
index bf2095112d89..ea55b2467653 100644
--- a/Documentation/dev-tools/kunit/faq.rst
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -29,7 +29,8 @@ Yes, well, mostly.
 
 For the most part, the KUnit core framework (what you use to write the tests)
 can compile to any architecture; it compiles like just another part of the
-kernel and runs when the kernel boots. However, there is some infrastructure,
+kernel and runs when the kernel boots, or when built as a module, when the
+module is loaded.  However, there is some infrastructure,
 like the KUnit Wrapper (``tools/testing/kunit/kunit.py``) that does not support
 other architectures.
 
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index c60d760a0eed..d16a4d2c3a41 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -49,6 +49,9 @@ to a standalone program that can be run like any other program directly inside
 of a host operating system; to be clear, it does not require any virtualization
 support; it is just a regular program.
 
+Alternatively, kunit and kunit tests can be built as modules and tests will
+run when the test module is loaded.
+
 KUnit is fast. Excluding build time, from invocation to completion KUnit can run
 several dozen tests in only 10 to 20 seconds; this might not sound like a big
 deal to some people, but having such fast and easy to run tests fundamentally
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index b9a065ab681e..7cd56a1993b1 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -539,6 +539,22 @@ Interspersed in the kernel logs you might see the following:
 
 Congratulations, you just ran a KUnit test on the x86 architecture!
 
+In a similar manner, kunit and kunit tests can also be built as modules,
+so if you wanted to run tests in this way you might add the following config
+options to your ``.config``:
+
+.. code-block:: none
+
+	CONFIG_KUNIT=m
+	CONFIG_KUNIT_EXAMPLE_TEST=m
+
+Once the kernel is built and installed, a simple
+
+.. code-block:: bash
+	modprobe example-test
+
+...will run the tests.
+
 Writing new tests for other architectures
 -----------------------------------------
 
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index c3b3b5c0b0da..5f0bc74d2409 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -150,7 +150,7 @@ config DEBUG_TEST_DRIVER_REMOVE
 
 config PM_QOS_KUNIT_TEST
 	bool "KUnit Test for PM QoS features"
-	depends on KUNIT
+	depends on KUNIT=y
 
 config HMEM_REPORTING
 	bool
diff --git a/drivers/base/power/qos-test.c b/drivers/base/power/qos-test.c
index 3115db08d56b..79fc6c4418da 100644
--- a/drivers/base/power/qos-test.c
+++ b/drivers/base/power/qos-test.c
@@ -114,4 +114,4 @@ static struct kunit_suite pm_qos_test_module = {
 	.name = "qos-kunit-test",
 	.test_cases = pm_qos_test_cases,
 };
-kunit_test_suite(pm_qos_test_module);
+kunit_test_suites(&pm_qos_test_module);
diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index ef42ab040905..435510f83297 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -108,7 +108,7 @@ config EXT4_DEBUG
 		echo 1 > /sys/module/ext4/parameters/mballoc_debug
 
 config EXT4_KUNIT_TESTS
-	bool "KUnit tests for ext4"
+	tristate "KUnit tests for ext4"
 	select EXT4_FS
 	depends on KUNIT
 	help
diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 840b91d040f1..4ccb3c9189d8 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -13,5 +13,6 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
 
 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
-ext4-$(CONFIG_EXT4_KUNIT_TESTS)		+= inode-test.o
+ext4-inode-test-objs			+= inode-test.o
+obj-$(CONFIG_EXT4_KUNIT_TESTS)		+= ext4-inode-test.o
 ext4-$(CONFIG_FS_VERITY)		+= verity.o
diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
index bbce1c328d85..d62d802c9c12 100644
--- a/fs/ext4/inode-test.c
+++ b/fs/ext4/inode-test.c
@@ -269,4 +269,6 @@ static struct kunit_suite ext4_inode_test_suite = {
 	.test_cases = ext4_inode_test_cases,
 };
 
-kunit_test_suite(ext4_inode_test_suite);
+kunit_test_suites(&ext4_inode_test_suite);
+
+MODULE_LICENSE("GPL v2");
diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index db6a0fca09b4..ad889b539ab3 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -9,10 +9,11 @@
 #ifndef _KUNIT_ASSERT_H
 #define _KUNIT_ASSERT_H
 
-#include <kunit/string-stream.h>
 #include <linux/err.h>
+#include <linux/kernel.h>
 
 struct kunit;
+struct string_stream;
 
 /**
  * enum kunit_assert_type - Type of expectation/assertion.
diff --git a/include/kunit/test.h b/include/kunit/test.h
index dba48304b3bd..2dfb550c6723 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -12,6 +12,7 @@
 #include <kunit/assert.h>
 #include <kunit/try-catch.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -197,31 +198,47 @@ void kunit_init_test(struct kunit *test, const char *name);
 int kunit_run_tests(struct kunit_suite *suite);
 
 /**
- * kunit_test_suite() - used to register a &struct kunit_suite with KUnit.
+ * kunit_test_suites() - used to register one or more &struct kunit_suite
+ *			 with KUnit.
  *
- * @suite: a statically allocated &struct kunit_suite.
+ * @suites: a statically allocated list of &struct kunit_suite.
  *
- * Registers @suite with the test framework. See &struct kunit_suite for
+ * Registers @suites with the test framework. See &struct kunit_suite for
  * more information.
  *
- * NOTE: Currently KUnit tests are all run as late_initcalls; this means
+ * When builtin,  KUnit tests are all run as late_initcalls; this means
  * that they cannot test anything where tests must run at a different init
  * phase. One significant restriction resulting from this is that KUnit
  * cannot reliably test anything that is initialize in the late_init phase;
  * another is that KUnit is useless to test things that need to be run in
  * an earlier init phase.
  *
+ * An alternative is to build the tests as a module.  Because modules
+ * do not support multiple late_initcall()s, we need to initialize an
+ * array of suites for a module.
+ *
  * TODO(brendanhiggins@google.com): Don't run all KUnit tests as
  * late_initcalls.  I have some future work planned to dispatch all KUnit
  * tests from the same place, and at the very least to do so after
  * everything else is definitely initialized.
  */
-#define kunit_test_suite(suite)						       \
-	static int kunit_suite_init##suite(void)			       \
-	{								       \
-		return kunit_run_tests(&suite);				       \
-	}								       \
-	late_initcall(kunit_suite_init##suite)
+#define kunit_test_suites(...)						\
+	static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};	\
+	static int kunit_test_suites_init(void)				\
+	{								\
+		unsigned int i;						\
+		for (i = 0; suites[i] != NULL; i++)			\
+			kunit_run_tests(suites[i]);			\
+		return 0;						\
+	}								\
+	late_initcall(kunit_test_suites_init);				\
+	static void __exit kunit_test_suites_exit(void)			\
+	{								\
+		return;							\
+	}								\
+	module_exit(kunit_test_suites_exit)
+
+#define kunit_test_suite(suite)	kunit_test_suites(&suite)
 
 /*
  * Like kunit_alloc_resource() below, but returns the struct kunit_resource
diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
index 404f336cbdc8..c507dd43119d 100644
--- a/include/kunit/try-catch.h
+++ b/include/kunit/try-catch.h
@@ -53,11 +53,6 @@ struct kunit_try_catch {
 	void *context;
 };
 
-void kunit_try_catch_init(struct kunit_try_catch *try_catch,
-			  struct kunit *test,
-			  kunit_try_catch_func_t try,
-			  kunit_try_catch_func_t catch);
-
 void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context);
 
 void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch);
@@ -67,9 +62,4 @@ static inline int kunit_try_catch_get_result(struct kunit_try_catch *try_catch)
 	return try_catch->try_result;
 }
 
-/*
- * Exposed for testing only.
- */
-void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch);
-
 #endif /* _KUNIT_TRY_CATCH_H */
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 2a63241a8453..ccb78509f1a8 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -389,4 +389,6 @@ static struct kunit_suite sysctl_test_suite = {
 	.test_cases = sysctl_test_cases,
 };
 
-kunit_test_suite(sysctl_test_suite);
+kunit_test_suites(&sysctl_test_suite);
+
+MODULE_LICENSE("GPL v2");
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5ffe144c9794..4ef415fff308 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2025,7 +2025,7 @@ config TEST_SYSCTL
 	  If unsure, say N.
 
 config SYSCTL_KUNIT_TEST
-	bool "KUnit test for sysctl"
+	tristate "KUnit test for sysctl"
 	depends on KUNIT
 	help
 	  This builds the proc sysctl unit test, which runs on boot.
@@ -2036,7 +2036,7 @@ config SYSCTL_KUNIT_TEST
 	  If unsure, say N.
 
 config LIST_KUNIT_TEST
-	bool "KUnit Test for Kernel Linked-list structures"
+	tristate "KUnit Test for Kernel Linked-list structures"
 	depends on KUNIT
 	help
 	  This builds the linked list KUnit test suite.
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index af37016bfdd4..065aa16f448b 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig KUNIT
-	bool "KUnit - Enable support for unit tests"
+	tristate "KUnit - Enable support for unit tests"
 	help
 	  Enables support for kernel unit tests (KUnit), a lightweight unit
 	  testing and mocking framework for the Linux kernel. These tests are
@@ -15,7 +15,7 @@ menuconfig KUNIT
 if KUNIT
 
 config KUNIT_TEST
-	bool "KUnit test for KUnit"
+	tristate "KUnit test for KUnit"
 	help
 	  Enables the unit tests for the KUnit test framework. These tests test
 	  the KUnit test framework itself; the tests are both written using
@@ -24,7 +24,7 @@ config KUNIT_TEST
 	  expected.
 
 config KUNIT_EXAMPLE_TEST
-	bool "Example test for KUnit"
+	tristate "Example test for KUnit"
 	help
 	  Enables an example unit test that illustrates some of the basic
 	  features of KUnit. This test only exists to help new users understand
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 769d9402b5d3..fab55649b69a 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,9 +1,15 @@
-obj-$(CONFIG_KUNIT) +=			test.o \
+obj-$(CONFIG_KUNIT) +=			kunit.o
+
+kunit-objs +=				test.o \
 					string-stream.o \
 					assert.o \
 					try-catch.o
 
-obj-$(CONFIG_KUNIT_TEST) +=		test-test.o \
-					string-stream-test.o
+obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
+
+# string-stream-test compiles built-in only.
+ifeq ($(CONFIG_KUNIT_TEST),y)
+obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
+endif
 
-obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	example-test.o
+obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 86013d4cf891..b24bebca052d 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -7,6 +7,8 @@
  */
 #include <kunit/assert.h>
 
+#include "string-stream.h"
+
 void kunit_base_assert_format(const struct kunit_assert *assert,
 			      struct string_stream *stream)
 {
@@ -24,6 +26,7 @@ void kunit_base_assert_format(const struct kunit_assert *assert,
 	string_stream_add(stream, "%s FAILED at %s:%d\n",
 			 expect_or_assert, assert->file, assert->line);
 }
+EXPORT_SYMBOL_GPL(kunit_base_assert_format);
 
 void kunit_assert_print_msg(const struct kunit_assert *assert,
 			    struct string_stream *stream)
@@ -31,6 +34,7 @@ void kunit_assert_print_msg(const struct kunit_assert *assert,
 	if (assert->message.fmt)
 		string_stream_add(stream, "\n%pV", &assert->message);
 }
+EXPORT_SYMBOL_GPL(kunit_assert_print_msg);
 
 void kunit_fail_assert_format(const struct kunit_assert *assert,
 			      struct string_stream *stream)
@@ -38,6 +42,7 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream, "%pV", &assert->message);
 }
+EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
 
 void kunit_unary_assert_format(const struct kunit_assert *assert,
 			       struct string_stream *stream)
@@ -56,6 +61,7 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 				 unary_assert->condition);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_unary_assert_format);
 
 void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 				     struct string_stream *stream)
@@ -76,6 +82,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 	}
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
 
 void kunit_binary_assert_format(const struct kunit_assert *assert,
 				struct string_stream *stream)
@@ -97,6 +104,7 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
 
 void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
@@ -118,6 +126,7 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
 
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
@@ -139,3 +148,4 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
diff --git a/lib/kunit/example-test.c b/lib/kunit/kunit-example-test.c
similarity index 97%
rename from lib/kunit/example-test.c
rename to lib/kunit/kunit-example-test.c
index f64a829aa441..be1164ecc476 100644
--- a/lib/kunit/example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -85,4 +85,6 @@ static struct kunit_suite example_test_suite = {
  * This registers the above test suite telling KUnit that this is a suite of
  * tests that need to be run.
  */
-kunit_test_suite(example_test_suite);
+kunit_test_suites(&example_test_suite);
+
+MODULE_LICENSE("GPL v2");
diff --git a/lib/kunit/test-test.c b/lib/kunit/kunit-test.c
similarity index 98%
rename from lib/kunit/test-test.c
rename to lib/kunit/kunit-test.c
index 5ebe059d16e2..ccb8d2e332f7 100644
--- a/lib/kunit/test-test.c
+++ b/lib/kunit/kunit-test.c
@@ -7,6 +7,8 @@
  */
 #include <kunit/test.h>
 
+#include "try-catch-impl.h"
+
 struct kunit_try_catch_test_context {
 	struct kunit_try_catch *try_catch;
 	bool function_called;
@@ -100,7 +102,6 @@ static struct kunit_suite kunit_try_catch_test_suite = {
 	.init = kunit_try_catch_test_init,
 	.test_cases = kunit_try_catch_test_cases,
 };
-kunit_test_suite(kunit_try_catch_test_suite);
 
 /*
  * Context for testing test managed resources
@@ -328,4 +329,6 @@ static struct kunit_suite kunit_resource_test_suite = {
 	.exit = kunit_resource_test_exit,
 	.test_cases = kunit_resource_test_cases,
 };
-kunit_test_suite(kunit_resource_test_suite);
+kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite);
+
+MODULE_LICENSE("GPL v2");
diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 76cc05eb00ed..110f3a993250 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -6,10 +6,11 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
-#include <kunit/string-stream.h>
 #include <kunit/test.h>
 #include <linux/slab.h>
 
+#include "string-stream.h"
+
 static void string_stream_test_empty_on_creation(struct kunit *test)
 {
 	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
@@ -49,4 +50,4 @@ static struct kunit_suite string_stream_test_suite = {
 	.name = "string-stream-test",
 	.test_cases = string_stream_test_cases
 };
-kunit_test_suite(string_stream_test_suite);
+kunit_test_suites(&string_stream_test_suite);
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index e6d17aacca30..350392013c14 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -6,11 +6,12 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
-#include <kunit/string-stream.h>
 #include <kunit/test.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 
+#include "string-stream.h"
+
 struct string_stream_fragment_alloc_context {
 	struct kunit *test;
 	int len;
diff --git a/include/kunit/string-stream.h b/lib/kunit/string-stream.h
similarity index 100%
rename from include/kunit/string-stream.h
rename to lib/kunit/string-stream.h
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c83c0fa59cbd..9242f932896c 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -7,10 +7,12 @@
  */
 
 #include <kunit/test.h>
-#include <kunit/try-catch.h>
 #include <linux/kernel.h>
 #include <linux/sched/debug.h>
 
+#include "string-stream.h"
+#include "try-catch-impl.h"
+
 static void kunit_set_failure(struct kunit *test)
 {
 	WRITE_ONCE(test->success, false);
@@ -171,6 +173,7 @@ void kunit_do_assertion(struct kunit *test,
 	if (assert->type == KUNIT_ASSERTION)
 		kunit_abort(test);
 }
+EXPORT_SYMBOL_GPL(kunit_do_assertion);
 
 void kunit_init_test(struct kunit *test, const char *name)
 {
@@ -179,6 +182,7 @@ void kunit_init_test(struct kunit *test, const char *name)
 	test->name = name;
 	test->success = true;
 }
+EXPORT_SYMBOL_GPL(kunit_init_test);
 
 /*
  * Initializes and runs test case. Does not clean up or do post validations.
@@ -317,6 +321,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kunit_run_tests);
 
 struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
 						    kunit_resource_init_t init,
@@ -342,6 +347,7 @@ struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
 
 	return res;
 }
+EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
 
 static void kunit_resource_free(struct kunit *test, struct kunit_resource *res)
 {
@@ -400,6 +406,7 @@ int kunit_resource_destroy(struct kunit *test,
 	kunit_resource_free(test, resource);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kunit_resource_destroy);
 
 struct kunit_kmalloc_params {
 	size_t size;
@@ -435,6 +442,7 @@ void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
 				    gfp,
 				    &params);
 }
+EXPORT_SYMBOL_GPL(kunit_kmalloc);
 
 void kunit_kfree(struct kunit *test, const void *ptr)
 {
@@ -447,6 +455,7 @@ void kunit_kfree(struct kunit *test, const void *ptr)
 
 	WARN_ON(rc);
 }
+EXPORT_SYMBOL_GPL(kunit_kfree);
 
 void kunit_cleanup(struct kunit *test)
 {
@@ -476,3 +485,17 @@ void kunit_cleanup(struct kunit *test)
 		kunit_resource_free(test, resource);
 	}
 }
+EXPORT_SYMBOL_GPL(kunit_cleanup);
+
+static int __init kunit_init(void)
+{
+	return 0;
+}
+late_initcall(kunit_init);
+
+static void __exit kunit_exit(void)
+{
+}
+module_exit(kunit_exit);
+
+MODULE_LICENSE("GPL v2");
diff --git a/lib/kunit/try-catch-impl.h b/lib/kunit/try-catch-impl.h
new file mode 100644
index 000000000000..203ba6a5e740
--- /dev/null
+++ b/lib/kunit/try-catch-impl.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Internal kunit try catch implementation to be shared with tests.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_TRY_CATCH_IMPL_H
+#define _KUNIT_TRY_CATCH_IMPL_H
+
+#include <kunit/try-catch.h>
+#include <linux/types.h>
+
+struct kunit;
+
+static inline void kunit_try_catch_init(struct kunit_try_catch *try_catch,
+					struct kunit *test,
+					kunit_try_catch_func_t try,
+					kunit_try_catch_func_t catch)
+{
+	try_catch->test = test;
+	try_catch->try = try;
+	try_catch->catch = catch;
+}
+
+#endif /* _KUNIT_TRY_CATCH_IMPL_H */
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 55686839eb61..0dd434e40487 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -8,17 +8,18 @@
  */
 
 #include <kunit/test.h>
-#include <kunit/try-catch.h>
 #include <linux/completion.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
-#include <linux/sched/sysctl.h>
+
+#include "try-catch-impl.h"
 
 void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
 {
 	try_catch->try_result = -EFAULT;
 	complete_and_exit(try_catch->try_completion, -EFAULT);
 }
+EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
 
 static int kunit_generic_run_threadfn_adapter(void *data)
 {
@@ -31,8 +32,6 @@ static int kunit_generic_run_threadfn_adapter(void *data)
 
 static unsigned long kunit_test_timeout(void)
 {
-	unsigned long timeout_msecs;
-
 	/*
 	 * TODO(brendanhiggins@google.com): We should probably have some type of
 	 * variable timeout here. The only question is what that timeout value
@@ -49,22 +48,11 @@ static unsigned long kunit_test_timeout(void)
 	 *
 	 * For more background on this topic, see:
 	 * https://mike-bland.com/2011/11/01/small-medium-large.html
+	 *
+	 * If tests timeout due to exceeding sysctl_hung_task_timeout_secs,
+	 * the task will be killed and an oops generated.
 	 */
-	if (sysctl_hung_task_timeout_secs) {
-		/*
-		 * If sysctl_hung_task is active, just set the timeout to some
-		 * value less than that.
-		 *
-		 * In regards to the above TODO, if we decide on variable
-		 * timeouts, this logic will likely need to change.
-		 */
-		timeout_msecs = (sysctl_hung_task_timeout_secs - 1) *
-				MSEC_PER_SEC;
-	} else {
-		timeout_msecs = 300 * MSEC_PER_SEC; /* 5 min */
-	}
-
-	return timeout_msecs;
+	return 300 * MSEC_PER_SEC; /* 5 min */
 }
 
 void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
@@ -106,13 +94,4 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 
 	try_catch->catch(try_catch->context);
 }
-
-void kunit_try_catch_init(struct kunit_try_catch *try_catch,
-			  struct kunit *test,
-			  kunit_try_catch_func_t try,
-			  kunit_try_catch_func_t catch)
-{
-	try_catch->test = test;
-	try_catch->try = try;
-	try_catch->catch = catch;
-}
+EXPORT_SYMBOL_GPL(kunit_try_catch_run);
diff --git a/lib/list-test.c b/lib/list-test.c
index 363c600491c3..76babb1df889 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -743,4 +743,6 @@ static struct kunit_suite list_test_module = {
 	.test_cases = list_test_cases,
 };
 
-kunit_test_suite(list_test_module);
+kunit_test_suites(&list_test_module);
+
+MODULE_LICENSE("GPL v2");
diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index a422a349f926..0fe336860773 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -68,3 +68,19 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
 	  Set the default value of the apparmor.debug kernel parameter.
 	  When enabled, various debug messages will be logged to
 	  the kernel message buffer.
+
+config SECURITY_APPARMOR_KUNIT_TEST
+	bool "Build KUnit tests for policy_unpack.c"
+	depends on KUNIT=y && SECURITY_APPARMOR
+	help
+	  This builds the AppArmor KUnit tests.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running KUnit test harness and are not for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 80364310fb1e..2d743c004bc4 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1228,3 +1228,7 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
 
 	return error;
 }
+
+#ifdef CONFIG_SECURITY_APPARMOR_KUNIT_TEST
+#include "policy_unpack_test.c"
+#endif /* CONFIG_SECURITY_APPARMOR_KUNIT_TEST */
diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
new file mode 100644
index 000000000000..533137f45361
--- /dev/null
+++ b/security/apparmor/policy_unpack_test.c
@@ -0,0 +1,607 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for AppArmor's policy unpack.
+ */
+
+#include <kunit/test.h>
+
+#include "include/policy.h"
+#include "include/policy_unpack.h"
+
+#define TEST_STRING_NAME "TEST_STRING"
+#define TEST_STRING_DATA "testing"
+#define TEST_STRING_BUF_OFFSET \
+	(3 + strlen(TEST_STRING_NAME) + 1)
+
+#define TEST_U32_NAME "U32_TEST"
+#define TEST_U32_DATA ((u32)0x01020304)
+#define TEST_NAMED_U32_BUF_OFFSET \
+	(TEST_STRING_BUF_OFFSET + 3 + strlen(TEST_STRING_DATA) + 1)
+#define TEST_U32_BUF_OFFSET \
+	(TEST_NAMED_U32_BUF_OFFSET + 3 + strlen(TEST_U32_NAME) + 1)
+
+#define TEST_U16_OFFSET (TEST_U32_BUF_OFFSET + 3)
+#define TEST_U16_DATA ((u16)(TEST_U32_DATA >> 16))
+
+#define TEST_U64_NAME "U64_TEST"
+#define TEST_U64_DATA ((u64)0x0102030405060708)
+#define TEST_NAMED_U64_BUF_OFFSET (TEST_U32_BUF_OFFSET + sizeof(u32) + 1)
+#define TEST_U64_BUF_OFFSET \
+	(TEST_NAMED_U64_BUF_OFFSET + 3 + strlen(TEST_U64_NAME) + 1)
+
+#define TEST_BLOB_NAME "BLOB_TEST"
+#define TEST_BLOB_DATA "\xde\xad\x00\xbe\xef"
+#define TEST_BLOB_DATA_SIZE (ARRAY_SIZE(TEST_BLOB_DATA))
+#define TEST_NAMED_BLOB_BUF_OFFSET (TEST_U64_BUF_OFFSET + sizeof(u64) + 1)
+#define TEST_BLOB_BUF_OFFSET \
+	(TEST_NAMED_BLOB_BUF_OFFSET + 3 + strlen(TEST_BLOB_NAME) + 1)
+
+#define TEST_ARRAY_NAME "ARRAY_TEST"
+#define TEST_ARRAY_SIZE 16
+#define TEST_NAMED_ARRAY_BUF_OFFSET \
+	(TEST_BLOB_BUF_OFFSET + 5 + TEST_BLOB_DATA_SIZE)
+#define TEST_ARRAY_BUF_OFFSET \
+	(TEST_NAMED_ARRAY_BUF_OFFSET + 3 + strlen(TEST_ARRAY_NAME) + 1)
+
+struct policy_unpack_fixture {
+	struct aa_ext *e;
+	size_t e_size;
+};
+
+struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
+				   struct kunit *test, size_t buf_size)
+{
+	char *buf;
+	struct aa_ext *e;
+
+	buf = kunit_kzalloc(test, buf_size, GFP_USER);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, buf);
+
+	e = kunit_kmalloc(test, sizeof(*e), GFP_USER);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, e);
+
+	e->start = buf;
+	e->end = e->start + buf_size;
+	e->pos = e->start;
+
+	*buf = AA_NAME;
+	*(buf + 1) = strlen(TEST_STRING_NAME) + 1;
+	strcpy(buf + 3, TEST_STRING_NAME);
+
+	buf = e->start + TEST_STRING_BUF_OFFSET;
+	*buf = AA_STRING;
+	*(buf + 1) = strlen(TEST_STRING_DATA) + 1;
+	strcpy(buf + 3, TEST_STRING_DATA);
+
+	buf = e->start + TEST_NAMED_U32_BUF_OFFSET;
+	*buf = AA_NAME;
+	*(buf + 1) = strlen(TEST_U32_NAME) + 1;
+	strcpy(buf + 3, TEST_U32_NAME);
+	*(buf + 3 + strlen(TEST_U32_NAME) + 1) = AA_U32;
+	*((u32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = TEST_U32_DATA;
+
+	buf = e->start + TEST_NAMED_U64_BUF_OFFSET;
+	*buf = AA_NAME;
+	*(buf + 1) = strlen(TEST_U64_NAME) + 1;
+	strcpy(buf + 3, TEST_U64_NAME);
+	*(buf + 3 + strlen(TEST_U64_NAME) + 1) = AA_U64;
+	*((u64 *)(buf + 3 + strlen(TEST_U64_NAME) + 2)) = TEST_U64_DATA;
+
+	buf = e->start + TEST_NAMED_BLOB_BUF_OFFSET;
+	*buf = AA_NAME;
+	*(buf + 1) = strlen(TEST_BLOB_NAME) + 1;
+	strcpy(buf + 3, TEST_BLOB_NAME);
+	*(buf + 3 + strlen(TEST_BLOB_NAME) + 1) = AA_BLOB;
+	*(buf + 3 + strlen(TEST_BLOB_NAME) + 2) = TEST_BLOB_DATA_SIZE;
+	memcpy(buf + 3 + strlen(TEST_BLOB_NAME) + 6,
+		TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE);
+
+	buf = e->start + TEST_NAMED_ARRAY_BUF_OFFSET;
+	*buf = AA_NAME;
+	*(buf + 1) = strlen(TEST_ARRAY_NAME) + 1;
+	strcpy(buf + 3, TEST_ARRAY_NAME);
+	*(buf + 3 + strlen(TEST_ARRAY_NAME) + 1) = AA_ARRAY;
+	*((u16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = TEST_ARRAY_SIZE;
+
+	return e;
+}
+
+static int policy_unpack_test_init(struct kunit *test)
+{
+	size_t e_size = TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1;
+	struct policy_unpack_fixture *puf;
+
+	puf = kunit_kmalloc(test, sizeof(*puf), GFP_USER);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, puf);
+
+	puf->e_size = e_size;
+	puf->e = build_aa_ext_struct(puf, test, e_size);
+
+	test->priv = puf;
+	return 0;
+}
+
+static void policy_unpack_test_inbounds_when_inbounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+
+	KUNIT_EXPECT_TRUE(test, inbounds(puf->e, 0));
+	KUNIT_EXPECT_TRUE(test, inbounds(puf->e, puf->e_size / 2));
+	KUNIT_EXPECT_TRUE(test, inbounds(puf->e, puf->e_size));
+}
+
+static void policy_unpack_test_inbounds_when_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+
+	KUNIT_EXPECT_FALSE(test, inbounds(puf->e, puf->e_size + 1));
+}
+
+static void policy_unpack_test_unpack_array_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	u16 array_size;
+
+	puf->e->pos += TEST_ARRAY_BUF_OFFSET;
+
+	array_size = unpack_array(puf->e, NULL);
+
+	KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+		puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
+}
+
+static void policy_unpack_test_unpack_array_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_ARRAY_NAME;
+	u16 array_size;
+
+	puf->e->pos += TEST_NAMED_ARRAY_BUF_OFFSET;
+
+	array_size = unpack_array(puf->e, name);
+
+	KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+		puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
+}
+
+static void policy_unpack_test_unpack_array_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_ARRAY_NAME;
+	u16 array_size;
+
+	puf->e->pos += TEST_NAMED_ARRAY_BUF_OFFSET;
+	puf->e->end = puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16);
+
+	array_size = unpack_array(puf->e, name);
+
+	KUNIT_EXPECT_EQ(test, array_size, (u16)0);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+		puf->e->start + TEST_NAMED_ARRAY_BUF_OFFSET);
+}
+
+static void policy_unpack_test_unpack_blob_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *blob = NULL;
+	size_t size;
+
+	puf->e->pos += TEST_BLOB_BUF_OFFSET;
+	size = unpack_blob(puf->e, &blob, NULL);
+
+	KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);
+	KUNIT_EXPECT_TRUE(test,
+		memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
+}
+
+static void policy_unpack_test_unpack_blob_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *blob = NULL;
+	size_t size;
+
+	puf->e->pos += TEST_NAMED_BLOB_BUF_OFFSET;
+	size = unpack_blob(puf->e, &blob, TEST_BLOB_NAME);
+
+	KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);
+	KUNIT_EXPECT_TRUE(test,
+		memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
+}
+
+static void policy_unpack_test_unpack_blob_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *blob = NULL;
+	void *start;
+	int size;
+
+	puf->e->pos += TEST_NAMED_BLOB_BUF_OFFSET;
+	start = puf->e->pos;
+	puf->e->end = puf->e->start + TEST_BLOB_BUF_OFFSET
+		+ TEST_BLOB_DATA_SIZE - 1;
+
+	size = unpack_blob(puf->e, &blob, TEST_BLOB_NAME);
+
+	KUNIT_EXPECT_EQ(test, size, 0);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
+}
+
+static void policy_unpack_test_unpack_str_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char *string = NULL;
+	size_t size;
+
+	puf->e->pos += TEST_STRING_BUF_OFFSET;
+	size = unpack_str(puf->e, &string, NULL);
+
+	KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
+	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
+}
+
+static void policy_unpack_test_unpack_str_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char *string = NULL;
+	size_t size;
+
+	size = unpack_str(puf->e, &string, TEST_STRING_NAME);
+
+	KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
+	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
+}
+
+static void policy_unpack_test_unpack_str_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char *string = NULL;
+	void *start = puf->e->pos;
+	int size;
+
+	puf->e->end = puf->e->pos + TEST_STRING_BUF_OFFSET
+		+ strlen(TEST_STRING_DATA) - 1;
+
+	size = unpack_str(puf->e, &string, TEST_STRING_NAME);
+
+	KUNIT_EXPECT_EQ(test, size, 0);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
+}
+
+static void policy_unpack_test_unpack_strdup_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *string = NULL;
+	size_t size;
+
+	puf->e->pos += TEST_STRING_BUF_OFFSET;
+	size = unpack_strdup(puf->e, &string, NULL);
+
+	KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
+	KUNIT_EXPECT_FALSE(test,
+			   ((uintptr_t)puf->e->start <= (uintptr_t)string)
+			   && ((uintptr_t)string <= (uintptr_t)puf->e->end));
+	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
+}
+
+static void policy_unpack_test_unpack_strdup_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *string = NULL;
+	size_t size;
+
+	size = unpack_strdup(puf->e, &string, TEST_STRING_NAME);
+
+	KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
+	KUNIT_EXPECT_FALSE(test,
+			   ((uintptr_t)puf->e->start <= (uintptr_t)string)
+			   && ((uintptr_t)string <= (uintptr_t)puf->e->end));
+	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
+}
+
+static void policy_unpack_test_unpack_strdup_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	void *start = puf->e->pos;
+	char *string = NULL;
+	int size;
+
+	puf->e->end = puf->e->pos + TEST_STRING_BUF_OFFSET
+		+ strlen(TEST_STRING_DATA) - 1;
+
+	size = unpack_strdup(puf->e, &string, TEST_STRING_NAME);
+
+	KUNIT_EXPECT_EQ(test, size, 0);
+	KUNIT_EXPECT_PTR_EQ(test, string, (char *)NULL);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
+}
+
+static void policy_unpack_test_unpack_nameX_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success;
+
+	puf->e->pos += TEST_U32_BUF_OFFSET;
+
+	success = unpack_nameX(puf->e, AA_U32, NULL);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			    puf->e->start + TEST_U32_BUF_OFFSET + 1);
+}
+
+static void policy_unpack_test_unpack_nameX_with_wrong_code(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success;
+
+	puf->e->pos += TEST_U32_BUF_OFFSET;
+
+	success = unpack_nameX(puf->e, AA_BLOB, NULL);
+
+	KUNIT_EXPECT_FALSE(test, success);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			    puf->e->start + TEST_U32_BUF_OFFSET);
+}
+
+static void policy_unpack_test_unpack_nameX_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_U32_NAME;
+	bool success;
+
+	puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
+
+	success = unpack_nameX(puf->e, AA_U32, name);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			    puf->e->start + TEST_U32_BUF_OFFSET + 1);
+}
+
+static void policy_unpack_test_unpack_nameX_with_wrong_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	static const char name[] = "12345678";
+	bool success;
+
+	puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
+
+	success = unpack_nameX(puf->e, AA_U32, name);
+
+	KUNIT_EXPECT_FALSE(test, success);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			    puf->e->start + TEST_NAMED_U32_BUF_OFFSET);
+}
+
+static void policy_unpack_test_unpack_u16_chunk_basic(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *chunk = NULL;
+	size_t size;
+
+	puf->e->pos += TEST_U16_OFFSET;
+	/*
+	 * WARNING: For unit testing purposes, we're pushing puf->e->end past
+	 * the end of the allocated memory. Doing anything other than comparing
+	 * memory addresses is dangerous.
+	 */
+	puf->e->end += TEST_U16_DATA;
+
+	size = unpack_u16_chunk(puf->e, &chunk);
+
+	KUNIT_EXPECT_PTR_EQ(test, (void *)chunk,
+			    puf->e->start + TEST_U16_OFFSET + 2);
+	KUNIT_EXPECT_EQ(test, size, (size_t)TEST_U16_DATA);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, (void *)(chunk + TEST_U16_DATA));
+}
+
+static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
+		struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *chunk = NULL;
+	size_t size;
+
+	puf->e->pos = puf->e->end - 1;
+
+	size = unpack_u16_chunk(puf->e, &chunk);
+
+	KUNIT_EXPECT_EQ(test, size, (size_t)0);
+	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
+}
+
+static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_2(
+		struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *chunk = NULL;
+	size_t size;
+
+	puf->e->pos += TEST_U16_OFFSET;
+	/*
+	 * WARNING: For unit testing purposes, we're pushing puf->e->end past
+	 * the end of the allocated memory. Doing anything other than comparing
+	 * memory addresses is dangerous.
+	 */
+	puf->e->end = puf->e->pos + TEST_U16_DATA - 1;
+
+	size = unpack_u16_chunk(puf->e, &chunk);
+
+	KUNIT_EXPECT_EQ(test, size, (size_t)0);
+	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
+}
+
+static void policy_unpack_test_unpack_u32_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success;
+	u32 data;
+
+	puf->e->pos += TEST_U32_BUF_OFFSET;
+
+	success = unpack_u32(puf->e, &data, NULL);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_EQ(test, data, TEST_U32_DATA);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			puf->e->start + TEST_U32_BUF_OFFSET + sizeof(u32) + 1);
+}
+
+static void policy_unpack_test_unpack_u32_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_U32_NAME;
+	bool success;
+	u32 data;
+
+	puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
+
+	success = unpack_u32(puf->e, &data, name);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_EQ(test, data, TEST_U32_DATA);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			puf->e->start + TEST_U32_BUF_OFFSET + sizeof(u32) + 1);
+}
+
+static void policy_unpack_test_unpack_u32_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_U32_NAME;
+	bool success;
+	u32 data;
+
+	puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
+	puf->e->end = puf->e->start + TEST_U32_BUF_OFFSET + sizeof(u32);
+
+	success = unpack_u32(puf->e, &data, name);
+
+	KUNIT_EXPECT_FALSE(test, success);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			puf->e->start + TEST_NAMED_U32_BUF_OFFSET);
+}
+
+static void policy_unpack_test_unpack_u64_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success;
+	u64 data;
+
+	puf->e->pos += TEST_U64_BUF_OFFSET;
+
+	success = unpack_u64(puf->e, &data, NULL);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_EQ(test, data, TEST_U64_DATA);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			puf->e->start + TEST_U64_BUF_OFFSET + sizeof(u64) + 1);
+}
+
+static void policy_unpack_test_unpack_u64_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_U64_NAME;
+	bool success;
+	u64 data;
+
+	puf->e->pos += TEST_NAMED_U64_BUF_OFFSET;
+
+	success = unpack_u64(puf->e, &data, name);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_EQ(test, data, TEST_U64_DATA);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			puf->e->start + TEST_U64_BUF_OFFSET + sizeof(u64) + 1);
+}
+
+static void policy_unpack_test_unpack_u64_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_U64_NAME;
+	bool success;
+	u64 data;
+
+	puf->e->pos += TEST_NAMED_U64_BUF_OFFSET;
+	puf->e->end = puf->e->start + TEST_U64_BUF_OFFSET + sizeof(u64);
+
+	success = unpack_u64(puf->e, &data, name);
+
+	KUNIT_EXPECT_FALSE(test, success);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			puf->e->start + TEST_NAMED_U64_BUF_OFFSET);
+}
+
+static void policy_unpack_test_unpack_X_code_match(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success = unpack_X(puf->e, AA_NAME);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_TRUE(test, puf->e->pos == puf->e->start + 1);
+}
+
+static void policy_unpack_test_unpack_X_code_mismatch(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success = unpack_X(puf->e, AA_STRING);
+
+	KUNIT_EXPECT_FALSE(test, success);
+	KUNIT_EXPECT_TRUE(test, puf->e->pos == puf->e->start);
+}
+
+static void policy_unpack_test_unpack_X_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success;
+
+	puf->e->pos = puf->e->end;
+	success = unpack_X(puf->e, AA_NAME);
+
+	KUNIT_EXPECT_FALSE(test, success);
+}
+
+static struct kunit_case apparmor_policy_unpack_test_cases[] = {
+	KUNIT_CASE(policy_unpack_test_inbounds_when_inbounds),
+	KUNIT_CASE(policy_unpack_test_inbounds_when_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_array_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_array_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_array_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_blob_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_blob_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_blob_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_nameX_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_nameX_with_wrong_code),
+	KUNIT_CASE(policy_unpack_test_unpack_nameX_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_nameX_with_wrong_name),
+	KUNIT_CASE(policy_unpack_test_unpack_str_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_str_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_str_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_strdup_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_strdup_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_strdup_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_u16_chunk_basic),
+	KUNIT_CASE(policy_unpack_test_unpack_u16_chunk_out_of_bounds_1),
+	KUNIT_CASE(policy_unpack_test_unpack_u16_chunk_out_of_bounds_2),
+	KUNIT_CASE(policy_unpack_test_unpack_u32_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_u32_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_u32_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_u64_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_u64_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_u64_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_X_code_match),
+	KUNIT_CASE(policy_unpack_test_unpack_X_code_mismatch),
+	KUNIT_CASE(policy_unpack_test_unpack_X_out_of_bounds),
+	{},
+};
+
+static struct kunit_suite apparmor_policy_unpack_test_module = {
+	.name = "apparmor_policy_unpack",
+	.init = policy_unpack_test_init,
+	.test_cases = apparmor_policy_unpack_test_cases,
+};
+
+kunit_test_suite(apparmor_policy_unpack_test_module);

--------------7408E280292BCD3F101B597F--
