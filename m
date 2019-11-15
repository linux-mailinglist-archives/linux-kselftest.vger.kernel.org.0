Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856F1FDAFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2019 11:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKOKRG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Nov 2019 05:17:06 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40746 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfKOKRG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Nov 2019 05:17:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFAESnF039115;
        Fri, 15 Nov 2019 10:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=p1o1TXYgkhuSmy+/5e1DV+WNci6/qvJJ5VYZZq8fLaE=;
 b=P7215GLznALutqWm+ndtHPGDPTFEJWSLFdKCwmgOCU9CRbe5JD5LesQ/LmrIV18uHvxT
 DHWvTpiF1ztW/drIfiuthhfpKq/BWEdSlioBkho8KEnuJivTm39+SaEafFm0f9EalOfM
 5PyhqkLJncjUZfvSXXRemQB5dU7bn+mHMoAC7LP3S5Emvc+CexaNWlSTEEDV4h3jJaeZ
 zmaaBlLgd4tOy13ix4F1AEH+wltoYTdU5WekjadCwQaFwiRf3FGHduF6b++nxFsvx3zc
 ibCMCEaIGx9Xp85wNLQZf/HXLqkv/tD6PdqMhC4ErTmifP2SuMpojRU6YpxT/uyD065a lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w9gxpjd2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 10:16:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFADMnu109733;
        Fri, 15 Nov 2019 10:16:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2w9h14fgh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 10:16:39 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAFAGaWW016332;
        Fri, 15 Nov 2019 10:16:37 GMT
Received: from dhcp-10-175-208-51.vpn.oracle.com (/10.175.208.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 02:16:36 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, tytso@mit.edu, adilger.kernel@dilger.ca,
        mcgrof@kernel.org, changbin.du@intel.com,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Subject: [PATCH v4 linux-kselftest-test 3/6] kunit: allow kunit tests to be loaded as a module
Date:   Fri, 15 Nov 2019 10:16:09 +0000
Message-Id: <1573812972-10529-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com>
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150096
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As tests are added to kunit, it will become less feasible to execute
all built tests together.  By supporting modular tests we provide
a simple way to do selective execution on a running system; specifying

CONFIG_KUNIT=y
CONFIG_KUNIT_EXAMPLE_TEST=m

...means we can simply "insmod example-test.ko" to run the tests.

To achieve this we need to do the following:

o export the required symbols in kunit
o string-stream tests utilize non-exported symbols so for now we skip
  building them when CONFIG_KUNIT_TEST=m.
o support a new way of declaring test suites.  Because a module cannot
  do multiple late_initcall()s, we provide a kunit_test_suites() macro
  to declare multiple suites within the same module at once.
o some test module names would have been too general ("test-test"
  and "example-test" for kunit tests, "inode-test" for ext4 tests);
  rename these as appropriate ("kunit-test", "kunit-example-test"
  and "ext4-inode-test" respectively).

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 fs/ext4/Kconfig                |   2 +-
 fs/ext4/Makefile               |   5 +
 fs/ext4/inode-test.c           |   4 +-
 include/kunit/test.h           |  35 +++--
 kernel/sysctl-test.c           |   4 +-
 lib/Kconfig.debug              |   4 +-
 lib/kunit/Kconfig              |   4 +-
 lib/kunit/Makefile             |  10 +-
 lib/kunit/assert.c             |   8 +
 lib/kunit/example-test.c       |  88 -----------
 lib/kunit/kunit-example-test.c |  90 +++++++++++
 lib/kunit/kunit-test.c         | 334 +++++++++++++++++++++++++++++++++++++++++
 lib/kunit/string-stream-test.c |   2 +-
 lib/kunit/test-test.c          | 333 ----------------------------------------
 lib/kunit/test.c               |   8 +
 lib/kunit/try-catch.c          |   2 +
 lib/list-test.c                |   4 +-
 17 files changed, 494 insertions(+), 443 deletions(-)
 delete mode 100644 lib/kunit/example-test.c
 create mode 100644 lib/kunit/kunit-example-test.c
 create mode 100644 lib/kunit/kunit-test.c
 delete mode 100644 lib/kunit/test-test.c

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index ef42ab0..435510f 100644
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
index 840b91d..1e72ef6 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -13,5 +13,10 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
 
 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
+ifeq ($(CONFIG_EXT4_KUNIT_TESTS),y)
 ext4-$(CONFIG_EXT4_KUNIT_TESTS)		+= inode-test.o
+else
+obj-$(CONFIG_EXT4_KUNIT_TESTS)		+= ext4-inode-test.o
+ext4-inode-test-objs			+= inode-test.o
+endif
 ext4-$(CONFIG_FS_VERITY)		+= verity.o
diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
index 92a9da1..5a59978 100644
--- a/fs/ext4/inode-test.c
+++ b/fs/ext4/inode-test.c
@@ -269,4 +269,6 @@ static void inode_test_xtimestamp_decoding(struct kunit *test)
 	.test_cases = ext4_inode_test_cases,
 };
 
-kunit_test_suite(ext4_inode_test_suite);
+kunit_test_suites(&ext4_inode_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/include/kunit/test.h b/include/kunit/test.h
index dba4830..4e21a36 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -12,6 +12,7 @@
 #include <kunit/assert.h>
 #include <kunit/try-catch.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -197,31 +198,45 @@ struct kunit {
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
 
 /*
  * Like kunit_alloc_resource() below, but returns the struct kunit_resource
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 2a63241..98d3e4e 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -389,4 +389,6 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 	.test_cases = sysctl_test_cases,
 };
 
-kunit_test_suite(sysctl_test_suite);
+kunit_test_suites(&sysctl_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6c1be61..4b25bef 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1951,7 +1951,7 @@ config TEST_SYSCTL
 	  If unsure, say N.
 
 config SYSCTL_KUNIT_TEST
-	bool "KUnit test for sysctl"
+	tristate "KUnit test for sysctl"
 	depends on KUNIT
 	help
 	  This builds the proc sysctl unit test, which runs on boot.
@@ -1962,7 +1962,7 @@ config SYSCTL_KUNIT_TEST
 	  If unsure, say N.
 
 config LIST_KUNIT_TEST
-	bool "KUnit Test for Kernel Linked-list structures"
+	tristate "KUnit Test for Kernel Linked-list structures"
 	depends on KUNIT
 	help
 	  This builds the linked list KUnit test suite.
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index af37016..9ebd5e6 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
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
index 769d940..bc6e5e54 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -3,7 +3,11 @@ obj-$(CONFIG_KUNIT) +=			test.o \
 					assert.o \
 					try-catch.o
 
-obj-$(CONFIG_KUNIT_TEST) +=		test-test.o \
-					string-stream-test.o
+obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 
-obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	example-test.o
+# string-stream-test compiles built-in only.
+ifeq ($(CONFIG_KUNIT_TEST),y)
+obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
+endif
+
+obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 9aca71c..b24bebc 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -26,6 +26,7 @@ void kunit_base_assert_format(const struct kunit_assert *assert,
 	string_stream_add(stream, "%s FAILED at %s:%d\n",
 			 expect_or_assert, assert->file, assert->line);
 }
+EXPORT_SYMBOL_GPL(kunit_base_assert_format);
 
 void kunit_assert_print_msg(const struct kunit_assert *assert,
 			    struct string_stream *stream)
@@ -33,6 +34,7 @@ void kunit_assert_print_msg(const struct kunit_assert *assert,
 	if (assert->message.fmt)
 		string_stream_add(stream, "\n%pV", &assert->message);
 }
+EXPORT_SYMBOL_GPL(kunit_assert_print_msg);
 
 void kunit_fail_assert_format(const struct kunit_assert *assert,
 			      struct string_stream *stream)
@@ -40,6 +42,7 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream, "%pV", &assert->message);
 }
+EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
 
 void kunit_unary_assert_format(const struct kunit_assert *assert,
 			       struct string_stream *stream)
@@ -58,6 +61,7 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 				 unary_assert->condition);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_unary_assert_format);
 
 void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 				     struct string_stream *stream)
@@ -78,6 +82,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 	}
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
 
 void kunit_binary_assert_format(const struct kunit_assert *assert,
 				struct string_stream *stream)
@@ -99,6 +104,7 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
 
 void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
@@ -120,6 +126,7 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
 
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
@@ -141,3 +148,4 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
diff --git a/lib/kunit/example-test.c b/lib/kunit/example-test.c
deleted file mode 100644
index f64a829..0000000
--- a/lib/kunit/example-test.c
+++ /dev/null
@@ -1,88 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Example KUnit test to show how to use KUnit.
- *
- * Copyright (C) 2019, Google LLC.
- * Author: Brendan Higgins <brendanhiggins@google.com>
- */
-
-#include <kunit/test.h>
-
-/*
- * This is the most fundamental element of KUnit, the test case. A test case
- * makes a set EXPECTATIONs and ASSERTIONs about the behavior of some code; if
- * any expectations or assertions are not met, the test fails; otherwise, the
- * test passes.
- *
- * In KUnit, a test case is just a function with the signature
- * `void (*)(struct kunit *)`. `struct kunit` is a context object that stores
- * information about the current test.
- */
-static void example_simple_test(struct kunit *test)
-{
-	/*
-	 * This is an EXPECTATION; it is how KUnit tests things. When you want
-	 * to test a piece of code, you set some expectations about what the
-	 * code should do. KUnit then runs the test and verifies that the code's
-	 * behavior matched what was expected.
-	 */
-	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
-}
-
-/*
- * This is run once before each test case, see the comment on
- * example_test_suite for more information.
- */
-static int example_test_init(struct kunit *test)
-{
-	kunit_info(test, "initializing\n");
-
-	return 0;
-}
-
-/*
- * Here we make a list of all the test cases we want to add to the test suite
- * below.
- */
-static struct kunit_case example_test_cases[] = {
-	/*
-	 * This is a helper to create a test case object from a test case
-	 * function; its exact function is not important to understand how to
-	 * use KUnit, just know that this is how you associate test cases with a
-	 * test suite.
-	 */
-	KUNIT_CASE(example_simple_test),
-	{}
-};
-
-/*
- * This defines a suite or grouping of tests.
- *
- * Test cases are defined as belonging to the suite by adding them to
- * `kunit_cases`.
- *
- * Often it is desirable to run some function which will set up things which
- * will be used by every test; this is accomplished with an `init` function
- * which runs before each test case is invoked. Similarly, an `exit` function
- * may be specified which runs after every test case and can be used to for
- * cleanup. For clarity, running tests in a test suite would behave as follows:
- *
- * suite.init(test);
- * suite.test_case[0](test);
- * suite.exit(test);
- * suite.init(test);
- * suite.test_case[1](test);
- * suite.exit(test);
- * ...;
- */
-static struct kunit_suite example_test_suite = {
-	.name = "example",
-	.init = example_test_init,
-	.test_cases = example_test_cases,
-};
-
-/*
- * This registers the above test suite telling KUnit that this is a suite of
- * tests that need to be run.
- */
-kunit_test_suite(example_test_suite);
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
new file mode 100644
index 0000000..ff930e0
--- /dev/null
+++ b/lib/kunit/kunit-example-test.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Example KUnit test to show how to use KUnit.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+
+/*
+ * This is the most fundamental element of KUnit, the test case. A test case
+ * makes a set EXPECTATIONs and ASSERTIONs about the behavior of some code; if
+ * any expectations or assertions are not met, the test fails; otherwise, the
+ * test passes.
+ *
+ * In KUnit, a test case is just a function with the signature
+ * `void (*)(struct kunit *)`. `struct kunit` is a context object that stores
+ * information about the current test.
+ */
+static void example_simple_test(struct kunit *test)
+{
+	/*
+	 * This is an EXPECTATION; it is how KUnit tests things. When you want
+	 * to test a piece of code, you set some expectations about what the
+	 * code should do. KUnit then runs the test and verifies that the code's
+	 * behavior matched what was expected.
+	 */
+	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
+}
+
+/*
+ * This is run once before each test case, see the comment on
+ * example_test_suite for more information.
+ */
+static int example_test_init(struct kunit *test)
+{
+	kunit_info(test, "initializing\n");
+
+	return 0;
+}
+
+/*
+ * Here we make a list of all the test cases we want to add to the test suite
+ * below.
+ */
+static struct kunit_case example_test_cases[] = {
+	/*
+	 * This is a helper to create a test case object from a test case
+	 * function; its exact function is not important to understand how to
+	 * use KUnit, just know that this is how you associate test cases with a
+	 * test suite.
+	 */
+	KUNIT_CASE(example_simple_test),
+	{}
+};
+
+/*
+ * This defines a suite or grouping of tests.
+ *
+ * Test cases are defined as belonging to the suite by adding them to
+ * `kunit_cases`.
+ *
+ * Often it is desirable to run some function which will set up things which
+ * will be used by every test; this is accomplished with an `init` function
+ * which runs before each test case is invoked. Similarly, an `exit` function
+ * may be specified which runs after every test case and can be used to for
+ * cleanup. For clarity, running tests in a test suite would behave as follows:
+ *
+ * suite.init(test);
+ * suite.test_case[0](test);
+ * suite.exit(test);
+ * suite.init(test);
+ * suite.test_case[1](test);
+ * suite.exit(test);
+ * ...;
+ */
+static struct kunit_suite example_test_suite = {
+	.name = "example",
+	.init = example_test_init,
+	.test_cases = example_test_cases,
+};
+
+/*
+ * This registers the above test suite telling KUnit that this is a suite of
+ * tests that need to be run.
+ */
+kunit_test_suites(&example_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
new file mode 100644
index 0000000..1f5942e
--- /dev/null
+++ b/lib/kunit/kunit-test.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for core test infrastructure.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+#include <kunit/test.h>
+
+#include "try-catch-impl.h"
+
+struct kunit_try_catch_test_context {
+	struct kunit_try_catch *try_catch;
+	bool function_called;
+};
+
+static void kunit_test_successful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+static void kunit_test_no_catch(void *data)
+{
+	struct kunit *test = data;
+
+	KUNIT_FAIL(test, "Catch should not be called\n");
+}
+
+static void kunit_test_try_catch_successful_try_no_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_successful_try,
+			     kunit_test_no_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static void kunit_test_unsuccessful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_throw(try_catch);
+	KUNIT_FAIL(test, "This line should never be reached\n");
+}
+
+static void kunit_test_catch(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+static void kunit_test_try_catch_unsuccessful_try_does_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_unsuccessful_try,
+			     kunit_test_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static int kunit_try_catch_test_init(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	test->priv = ctx;
+
+	ctx->try_catch = kunit_kmalloc(test,
+				       sizeof(*ctx->try_catch),
+				       GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->try_catch);
+
+	return 0;
+}
+
+static struct kunit_case kunit_try_catch_test_cases[] = {
+	KUNIT_CASE(kunit_test_try_catch_successful_try_no_catch),
+	KUNIT_CASE(kunit_test_try_catch_unsuccessful_try_does_catch),
+	{}
+};
+
+static struct kunit_suite kunit_try_catch_test_suite = {
+	.name = "kunit-try-catch-test",
+	.init = kunit_try_catch_test_init,
+	.test_cases = kunit_try_catch_test_cases,
+};
+
+/*
+ * Context for testing test managed resources
+ * is_resource_initialized is used to test arbitrary resources
+ */
+struct kunit_test_resource_context {
+	struct kunit test;
+	bool is_resource_initialized;
+	int allocate_order[2];
+	int free_order[2];
+};
+
+static int fake_resource_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	res->allocation = &ctx->is_resource_initialized;
+	ctx->is_resource_initialized = true;
+	return 0;
+}
+
+static void fake_resource_free(struct kunit_resource *res)
+{
+	bool *is_resource_initialized = res->allocation;
+
+	*is_resource_initialized = false;
+}
+
+static void kunit_resource_test_init_resources(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_init_test(&ctx->test, "testing_test_init_test");
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_alloc_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res;
+	kunit_resource_free_t free = fake_resource_free;
+
+	res = kunit_alloc_and_get_resource(&ctx->test,
+					   fake_resource_init,
+					   fake_resource_free,
+					   GFP_KERNEL,
+					   ctx);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    &ctx->is_resource_initialized,
+			    (bool *) res->allocation);
+	KUNIT_EXPECT_TRUE(test, list_is_last(&res->node, &ctx->test.resources));
+	KUNIT_EXPECT_PTR_EQ(test, free, res->free);
+}
+
+static void kunit_resource_test_destroy_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res = kunit_alloc_and_get_resource(
+			&ctx->test,
+			fake_resource_init,
+			fake_resource_free,
+			GFP_KERNEL,
+			ctx);
+
+	KUNIT_ASSERT_FALSE(test,
+			   kunit_resource_destroy(&ctx->test,
+						  kunit_resource_instance_match,
+						  res->free,
+						  res->allocation));
+
+	KUNIT_EXPECT_FALSE(test, ctx->is_resource_initialized);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_cleanup_resources(struct kunit *test)
+{
+	int i;
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *resources[5];
+
+	for (i = 0; i < ARRAY_SIZE(resources); i++) {
+		resources[i] = kunit_alloc_and_get_resource(&ctx->test,
+							    fake_resource_init,
+							    fake_resource_free,
+							    GFP_KERNEL,
+							    ctx);
+	}
+
+	kunit_cleanup(&ctx->test);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_mark_order(int order_array[],
+					   size_t order_size,
+					   int key)
+{
+	int i;
+
+	for (i = 0; i < order_size && order_array[i]; i++)
+		;
+
+	order_array[i] = key;
+}
+
+#define KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, order_field, key)		       \
+		kunit_resource_test_mark_order(ctx->order_field,	       \
+					       ARRAY_SIZE(ctx->order_field),   \
+					       key)
+
+static int fake_resource_2_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 2);
+
+	res->allocation = ctx;
+
+	return 0;
+}
+
+static void fake_resource_2_free(struct kunit_resource *res)
+{
+	struct kunit_test_resource_context *ctx = res->allocation;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 2);
+}
+
+static int fake_resource_1_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	kunit_alloc_and_get_resource(&ctx->test,
+				     fake_resource_2_init,
+				     fake_resource_2_free,
+				     GFP_KERNEL,
+				     ctx);
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 1);
+
+	res->allocation = ctx;
+
+	return 0;
+}
+
+static void fake_resource_1_free(struct kunit_resource *res)
+{
+	struct kunit_test_resource_context *ctx = res->allocation;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 1);
+}
+
+/*
+ * TODO(brendanhiggins@google.com): replace the arrays that keep track of the
+ * order of allocation and freeing with strict mocks using the IN_SEQUENCE macro
+ * to assert allocation and freeing order when the feature becomes available.
+ */
+static void kunit_resource_test_proper_free_ordering(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	/* fake_resource_1 allocates a fake_resource_2 in its init. */
+	kunit_alloc_and_get_resource(&ctx->test,
+				     fake_resource_1_init,
+				     fake_resource_1_free,
+				     GFP_KERNEL,
+				     ctx);
+
+	/*
+	 * Since fake_resource_2_init calls KUNIT_RESOURCE_TEST_MARK_ORDER
+	 * before returning to fake_resource_1_init, it should be the first to
+	 * put its key in the allocate_order array.
+	 */
+	KUNIT_EXPECT_EQ(test, ctx->allocate_order[0], 2);
+	KUNIT_EXPECT_EQ(test, ctx->allocate_order[1], 1);
+
+	kunit_cleanup(&ctx->test);
+
+	/*
+	 * Because fake_resource_2 finishes allocation before fake_resource_1,
+	 * fake_resource_1 should be freed first since it could depend on
+	 * fake_resource_2.
+	 */
+	KUNIT_EXPECT_EQ(test, ctx->free_order[0], 1);
+	KUNIT_EXPECT_EQ(test, ctx->free_order[1], 2);
+}
+
+static int kunit_resource_test_init(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx =
+			kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	test->priv = ctx;
+
+	kunit_init_test(&ctx->test, "test_test_context");
+
+	return 0;
+}
+
+static void kunit_resource_test_exit(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_cleanup(&ctx->test);
+	kfree(ctx);
+}
+
+static struct kunit_case kunit_resource_test_cases[] = {
+	KUNIT_CASE(kunit_resource_test_init_resources),
+	KUNIT_CASE(kunit_resource_test_alloc_resource),
+	KUNIT_CASE(kunit_resource_test_destroy_resource),
+	KUNIT_CASE(kunit_resource_test_cleanup_resources),
+	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
+	{}
+};
+
+static struct kunit_suite kunit_resource_test_suite = {
+	.name = "kunit-resource-test",
+	.init = kunit_resource_test_init,
+	.exit = kunit_resource_test_exit,
+	.test_cases = kunit_resource_test_cases,
+};
+kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 6c70dc8..110f3a9 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -50,4 +50,4 @@ static void string_stream_test_get_string(struct kunit *test)
 	.name = "string-stream-test",
 	.test_cases = string_stream_test_cases
 };
-kunit_test_suite(string_stream_test_suite);
+kunit_test_suites(&string_stream_test_suite);
diff --git a/lib/kunit/test-test.c b/lib/kunit/test-test.c
deleted file mode 100644
index 5a6cc04..0000000
--- a/lib/kunit/test-test.c
+++ /dev/null
@@ -1,333 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * KUnit test for core test infrastructure.
- *
- * Copyright (C) 2019, Google LLC.
- * Author: Brendan Higgins <brendanhiggins@google.com>
- */
-#include <kunit/test.h>
-
-#include "try-catch-impl.h"
-
-struct kunit_try_catch_test_context {
-	struct kunit_try_catch *try_catch;
-	bool function_called;
-};
-
-static void kunit_test_successful_try(void *data)
-{
-	struct kunit *test = data;
-	struct kunit_try_catch_test_context *ctx = test->priv;
-
-	ctx->function_called = true;
-}
-
-static void kunit_test_no_catch(void *data)
-{
-	struct kunit *test = data;
-
-	KUNIT_FAIL(test, "Catch should not be called\n");
-}
-
-static void kunit_test_try_catch_successful_try_no_catch(struct kunit *test)
-{
-	struct kunit_try_catch_test_context *ctx = test->priv;
-	struct kunit_try_catch *try_catch = ctx->try_catch;
-
-	kunit_try_catch_init(try_catch,
-			     test,
-			     kunit_test_successful_try,
-			     kunit_test_no_catch);
-	kunit_try_catch_run(try_catch, test);
-
-	KUNIT_EXPECT_TRUE(test, ctx->function_called);
-}
-
-static void kunit_test_unsuccessful_try(void *data)
-{
-	struct kunit *test = data;
-	struct kunit_try_catch_test_context *ctx = test->priv;
-	struct kunit_try_catch *try_catch = ctx->try_catch;
-
-	kunit_try_catch_throw(try_catch);
-	KUNIT_FAIL(test, "This line should never be reached\n");
-}
-
-static void kunit_test_catch(void *data)
-{
-	struct kunit *test = data;
-	struct kunit_try_catch_test_context *ctx = test->priv;
-
-	ctx->function_called = true;
-}
-
-static void kunit_test_try_catch_unsuccessful_try_does_catch(struct kunit *test)
-{
-	struct kunit_try_catch_test_context *ctx = test->priv;
-	struct kunit_try_catch *try_catch = ctx->try_catch;
-
-	kunit_try_catch_init(try_catch,
-			     test,
-			     kunit_test_unsuccessful_try,
-			     kunit_test_catch);
-	kunit_try_catch_run(try_catch, test);
-
-	KUNIT_EXPECT_TRUE(test, ctx->function_called);
-}
-
-static int kunit_try_catch_test_init(struct kunit *test)
-{
-	struct kunit_try_catch_test_context *ctx;
-
-	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-	test->priv = ctx;
-
-	ctx->try_catch = kunit_kmalloc(test,
-				       sizeof(*ctx->try_catch),
-				       GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->try_catch);
-
-	return 0;
-}
-
-static struct kunit_case kunit_try_catch_test_cases[] = {
-	KUNIT_CASE(kunit_test_try_catch_successful_try_no_catch),
-	KUNIT_CASE(kunit_test_try_catch_unsuccessful_try_does_catch),
-	{}
-};
-
-static struct kunit_suite kunit_try_catch_test_suite = {
-	.name = "kunit-try-catch-test",
-	.init = kunit_try_catch_test_init,
-	.test_cases = kunit_try_catch_test_cases,
-};
-kunit_test_suite(kunit_try_catch_test_suite);
-
-/*
- * Context for testing test managed resources
- * is_resource_initialized is used to test arbitrary resources
- */
-struct kunit_test_resource_context {
-	struct kunit test;
-	bool is_resource_initialized;
-	int allocate_order[2];
-	int free_order[2];
-};
-
-static int fake_resource_init(struct kunit_resource *res, void *context)
-{
-	struct kunit_test_resource_context *ctx = context;
-
-	res->allocation = &ctx->is_resource_initialized;
-	ctx->is_resource_initialized = true;
-	return 0;
-}
-
-static void fake_resource_free(struct kunit_resource *res)
-{
-	bool *is_resource_initialized = res->allocation;
-
-	*is_resource_initialized = false;
-}
-
-static void kunit_resource_test_init_resources(struct kunit *test)
-{
-	struct kunit_test_resource_context *ctx = test->priv;
-
-	kunit_init_test(&ctx->test, "testing_test_init_test");
-
-	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
-}
-
-static void kunit_resource_test_alloc_resource(struct kunit *test)
-{
-	struct kunit_test_resource_context *ctx = test->priv;
-	struct kunit_resource *res;
-	kunit_resource_free_t free = fake_resource_free;
-
-	res = kunit_alloc_and_get_resource(&ctx->test,
-					   fake_resource_init,
-					   fake_resource_free,
-					   GFP_KERNEL,
-					   ctx);
-
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
-	KUNIT_EXPECT_PTR_EQ(test,
-			    &ctx->is_resource_initialized,
-			    (bool *) res->allocation);
-	KUNIT_EXPECT_TRUE(test, list_is_last(&res->node, &ctx->test.resources));
-	KUNIT_EXPECT_PTR_EQ(test, free, res->free);
-}
-
-static void kunit_resource_test_destroy_resource(struct kunit *test)
-{
-	struct kunit_test_resource_context *ctx = test->priv;
-	struct kunit_resource *res = kunit_alloc_and_get_resource(
-			&ctx->test,
-			fake_resource_init,
-			fake_resource_free,
-			GFP_KERNEL,
-			ctx);
-
-	KUNIT_ASSERT_FALSE(test,
-			   kunit_resource_destroy(&ctx->test,
-						  kunit_resource_instance_match,
-						  res->free,
-						  res->allocation));
-
-	KUNIT_EXPECT_FALSE(test, ctx->is_resource_initialized);
-	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
-}
-
-static void kunit_resource_test_cleanup_resources(struct kunit *test)
-{
-	int i;
-	struct kunit_test_resource_context *ctx = test->priv;
-	struct kunit_resource *resources[5];
-
-	for (i = 0; i < ARRAY_SIZE(resources); i++) {
-		resources[i] = kunit_alloc_and_get_resource(&ctx->test,
-							    fake_resource_init,
-							    fake_resource_free,
-							    GFP_KERNEL,
-							    ctx);
-	}
-
-	kunit_cleanup(&ctx->test);
-
-	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
-}
-
-static void kunit_resource_test_mark_order(int order_array[],
-					   size_t order_size,
-					   int key)
-{
-	int i;
-
-	for (i = 0; i < order_size && order_array[i]; i++)
-		;
-
-	order_array[i] = key;
-}
-
-#define KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, order_field, key)		       \
-		kunit_resource_test_mark_order(ctx->order_field,	       \
-					       ARRAY_SIZE(ctx->order_field),   \
-					       key)
-
-static int fake_resource_2_init(struct kunit_resource *res, void *context)
-{
-	struct kunit_test_resource_context *ctx = context;
-
-	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 2);
-
-	res->allocation = ctx;
-
-	return 0;
-}
-
-static void fake_resource_2_free(struct kunit_resource *res)
-{
-	struct kunit_test_resource_context *ctx = res->allocation;
-
-	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 2);
-}
-
-static int fake_resource_1_init(struct kunit_resource *res, void *context)
-{
-	struct kunit_test_resource_context *ctx = context;
-
-	kunit_alloc_and_get_resource(&ctx->test,
-				     fake_resource_2_init,
-				     fake_resource_2_free,
-				     GFP_KERNEL,
-				     ctx);
-
-	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 1);
-
-	res->allocation = ctx;
-
-	return 0;
-}
-
-static void fake_resource_1_free(struct kunit_resource *res)
-{
-	struct kunit_test_resource_context *ctx = res->allocation;
-
-	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 1);
-}
-
-/*
- * TODO(brendanhiggins@google.com): replace the arrays that keep track of the
- * order of allocation and freeing with strict mocks using the IN_SEQUENCE macro
- * to assert allocation and freeing order when the feature becomes available.
- */
-static void kunit_resource_test_proper_free_ordering(struct kunit *test)
-{
-	struct kunit_test_resource_context *ctx = test->priv;
-
-	/* fake_resource_1 allocates a fake_resource_2 in its init. */
-	kunit_alloc_and_get_resource(&ctx->test,
-				     fake_resource_1_init,
-				     fake_resource_1_free,
-				     GFP_KERNEL,
-				     ctx);
-
-	/*
-	 * Since fake_resource_2_init calls KUNIT_RESOURCE_TEST_MARK_ORDER
-	 * before returning to fake_resource_1_init, it should be the first to
-	 * put its key in the allocate_order array.
-	 */
-	KUNIT_EXPECT_EQ(test, ctx->allocate_order[0], 2);
-	KUNIT_EXPECT_EQ(test, ctx->allocate_order[1], 1);
-
-	kunit_cleanup(&ctx->test);
-
-	/*
-	 * Because fake_resource_2 finishes allocation before fake_resource_1,
-	 * fake_resource_1 should be freed first since it could depend on
-	 * fake_resource_2.
-	 */
-	KUNIT_EXPECT_EQ(test, ctx->free_order[0], 1);
-	KUNIT_EXPECT_EQ(test, ctx->free_order[1], 2);
-}
-
-static int kunit_resource_test_init(struct kunit *test)
-{
-	struct kunit_test_resource_context *ctx =
-			kzalloc(sizeof(*ctx), GFP_KERNEL);
-
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
-	test->priv = ctx;
-
-	kunit_init_test(&ctx->test, "test_test_context");
-
-	return 0;
-}
-
-static void kunit_resource_test_exit(struct kunit *test)
-{
-	struct kunit_test_resource_context *ctx = test->priv;
-
-	kunit_cleanup(&ctx->test);
-	kfree(ctx);
-}
-
-static struct kunit_case kunit_resource_test_cases[] = {
-	KUNIT_CASE(kunit_resource_test_init_resources),
-	KUNIT_CASE(kunit_resource_test_alloc_resource),
-	KUNIT_CASE(kunit_resource_test_destroy_resource),
-	KUNIT_CASE(kunit_resource_test_cleanup_resources),
-	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
-	{}
-};
-
-static struct kunit_suite kunit_resource_test_suite = {
-	.name = "kunit-resource-test",
-	.init = kunit_resource_test_init,
-	.exit = kunit_resource_test_exit,
-	.test_cases = kunit_resource_test_cases,
-};
-kunit_test_suite(kunit_resource_test_suite);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 58a6227..87b5cf1 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -173,6 +173,7 @@ void kunit_do_assertion(struct kunit *test,
 	if (assert->type == KUNIT_ASSERTION)
 		kunit_abort(test);
 }
+EXPORT_SYMBOL_GPL(kunit_do_assertion);
 
 void kunit_init_test(struct kunit *test, const char *name)
 {
@@ -181,6 +182,7 @@ void kunit_init_test(struct kunit *test, const char *name)
 	test->name = name;
 	test->success = true;
 }
+EXPORT_SYMBOL_GPL(kunit_init_test);
 
 /*
  * Initializes and runs test case. Does not clean up or do post validations.
@@ -319,6 +321,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kunit_run_tests);
 
 struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
 						    kunit_resource_init_t init,
@@ -344,6 +347,7 @@ struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
 
 	return res;
 }
+EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
 
 static void kunit_resource_free(struct kunit *test, struct kunit_resource *res)
 {
@@ -402,6 +406,7 @@ int kunit_resource_destroy(struct kunit *test,
 	kunit_resource_free(test, resource);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kunit_resource_destroy);
 
 struct kunit_kmalloc_params {
 	size_t size;
@@ -437,6 +442,7 @@ void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
 				    gfp,
 				    &params);
 }
+EXPORT_SYMBOL_GPL(kunit_kmalloc);
 
 void kunit_kfree(struct kunit *test, const void *ptr)
 {
@@ -449,6 +455,7 @@ void kunit_kfree(struct kunit *test, const void *ptr)
 
 	WARN_ON(rc);
 }
+EXPORT_SYMBOL_GPL(kunit_kfree);
 
 void kunit_cleanup(struct kunit *test)
 {
@@ -478,3 +485,4 @@ void kunit_cleanup(struct kunit *test)
 		kunit_resource_free(test, resource);
 	}
 }
+EXPORT_SYMBOL_GPL(kunit_cleanup);
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 4a66d16..0247a28 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -20,6 +20,7 @@ void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
 	try_catch->try_result = -EFAULT;
 	complete_and_exit(try_catch->try_completion, -EFAULT);
 }
+EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
 
 static int kunit_generic_run_threadfn_adapter(void *data)
 {
@@ -107,3 +108,4 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 
 	try_catch->catch(try_catch->context);
 }
+EXPORT_SYMBOL_GPL(kunit_try_catch_run);
diff --git a/lib/list-test.c b/lib/list-test.c
index 363c600..4c31a91 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -743,4 +743,6 @@ static void list_test_list_for_each_entry_reverse(struct kunit *test)
 	.test_cases = list_test_cases,
 };
 
-kunit_test_suite(list_test_module);
+kunit_test_suites(&list_test_module);
+
+MODULE_LICENSE("GPL");
-- 
1.8.3.1

