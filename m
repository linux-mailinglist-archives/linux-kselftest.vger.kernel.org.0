Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7035012669E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2019 17:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfLSQS4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Dec 2019 11:18:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36436 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLSQSz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Dec 2019 11:18:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGEIVW126473;
        Thu, 19 Dec 2019 16:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=4BqdBd9ZGTADtabO363Xd1QXkKgwbMdYacFmLSEosQI=;
 b=WddqqQWBrSJFTv3J9dCrwuqCd6NYKSfEd2XSp9Naq4XaKBim2CQl9MQ1yDqRvewD23aC
 22LenO1Qk5OZ9jMLAtsORzj0UcHhP42chAIJjoNufXxLkmr+aeZtNyYwNakrKVzzqNVK
 8W+UDTbJISVQ5mDA5Oc8RXz9cCXnZXkEjFr1R21fbezoEv/+RO5hg3GzAnW1tLM25W7s
 LAc+PFubb3Za34tO7ose4+5PyHE5qU4TLiLD9ya61TEzyRKE5CuxvH+Yf4eHrko2bbz3
 hBj2ffWUqCMJF3GuEnFnWqAIQHs/dmAXNoEA4rCpEzJAqlwkMCxF2V2FigVcPx+56QdE 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2x01knkuqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 16:18:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGEOMe136590;
        Thu, 19 Dec 2019 16:18:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wyut5jj8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 16:18:30 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJGIQ9m019781;
        Thu, 19 Dec 2019 16:18:27 GMT
Received: from dhcp-10-175-212-35.vpn.oracle.com (/10.175.212.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 08:18:25 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        davidgow@google.com, adilger.kernel@dilger.ca, tytso@mit.edu,
        mcgrof@kernel.org, linux-doc@vger.kernel.org, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-ext4@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Subject: [PATCH v7 linux-kselftest-test 3/6] kunit: allow kunit tests to be loaded as a module
Date:   Thu, 19 Dec 2019 16:17:36 +0000
Message-Id: <1576772259-31382-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576772259-31382-1-git-send-email-alan.maguire@oracle.com>
References: <1576772259-31382-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=973
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190135
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
o drivers/base/power/qos-test.c contains a few unexported interface
  references, namely freq_qos_read_value() and freq_constraints_init().
  Both of these could be potentially defined as static inline functions
  in include/linux/pm_qos.h, but for now we simply avoid supporting
  module build for that test suite.
o support a new way of declaring test suites.  Because a module cannot
  do multiple late_initcall()s, we provide a kunit_test_suites() macro
  to declare multiple suites within the same module at once.
o some test module names would have been too general ("test-test"
  and "example-test" for kunit tests, "inode-test" for ext4 tests);
  rename these as appropriate ("kunit-test", "kunit-example-test"
  and "ext4-inode-test" respectively).

Also define kunit_test_suite() via kunit_test_suites()
as callers in other trees may need the old definition.

Co-developed-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Theodore Ts'o <tytso@mit.edu> # for ext4 bits
Acked-by: David Gow <davidgow@google.com> # For list-test
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/base/power/qos-test.c                      |  2 +-
 fs/ext4/Kconfig                                    |  2 +-
 fs/ext4/Makefile                                   |  3 +-
 fs/ext4/inode-test.c                               |  4 ++-
 include/kunit/test.h                               | 37 ++++++++++++++++------
 kernel/sysctl-test.c                               |  4 ++-
 lib/Kconfig.debug                                  |  4 +--
 lib/kunit/Kconfig                                  |  4 +--
 lib/kunit/Makefile                                 | 10 ++++--
 lib/kunit/assert.c                                 |  8 +++++
 lib/kunit/{example-test.c => kunit-example-test.c} |  4 ++-
 lib/kunit/{test-test.c => kunit-test.c}            |  5 +--
 lib/kunit/string-stream-test.c                     |  2 +-
 lib/kunit/test.c                                   |  8 +++++
 lib/kunit/try-catch.c                              |  2 ++
 lib/list-test.c                                    |  4 ++-
 16 files changed, 76 insertions(+), 27 deletions(-)
 rename lib/kunit/{example-test.c => kunit-example-test.c} (97%)
 rename lib/kunit/{test-test.c => kunit-test.c} (98%)

diff --git a/drivers/base/power/qos-test.c b/drivers/base/power/qos-test.c
index 3115db0..79fc6c4 100644
--- a/drivers/base/power/qos-test.c
+++ b/drivers/base/power/qos-test.c
@@ -114,4 +114,4 @@ static void freq_qos_test_readd(struct kunit *test)
 	.name = "qos-kunit-test",
 	.test_cases = pm_qos_test_cases,
 };
-kunit_test_suite(pm_qos_test_module);
+kunit_test_suites(&pm_qos_test_module);
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
index 840b91d..4ccb3c9 100644
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
index 92a9da1..95620bf 100644
--- a/fs/ext4/inode-test.c
+++ b/fs/ext4/inode-test.c
@@ -269,4 +269,6 @@ static void inode_test_xtimestamp_decoding(struct kunit *test)
 	.test_cases = ext4_inode_test_cases,
 };
 
-kunit_test_suite(ext4_inode_test_suite);
+kunit_test_suites(&ext4_inode_test_suite);
+
+MODULE_LICENSE("GPL v2");
diff --git a/include/kunit/test.h b/include/kunit/test.h
index dba4830..2dfb550 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -12,6 +12,7 @@
 #include <kunit/assert.h>
 #include <kunit/try-catch.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -197,31 +198,47 @@ struct kunit {
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
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 2a63241..ccb7850 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -389,4 +389,6 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 	.test_cases = sysctl_test_cases,
 };
 
-kunit_test_suite(sysctl_test_suite);
+kunit_test_suites(&sysctl_test_suite);
+
+MODULE_LICENSE("GPL v2");
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d1842fe..e23c923 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1980,7 +1980,7 @@ config TEST_SYSCTL
 	  If unsure, say N.
 
 config SYSCTL_KUNIT_TEST
-	bool "KUnit test for sysctl"
+	tristate "KUnit test for sysctl"
 	depends on KUNIT
 	help
 	  This builds the proc sysctl unit test, which runs on boot.
@@ -1991,7 +1991,7 @@ config SYSCTL_KUNIT_TEST
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
diff --git a/lib/kunit/example-test.c b/lib/kunit/kunit-example-test.c
similarity index 97%
rename from lib/kunit/example-test.c
rename to lib/kunit/kunit-example-test.c
index f64a829..be1164e 100644
--- a/lib/kunit/example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -85,4 +85,6 @@ static int example_test_init(struct kunit *test)
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
index 5a6cc04..ccb8d2e 100644
--- a/lib/kunit/test-test.c
+++ b/lib/kunit/kunit-test.c
@@ -102,7 +102,6 @@ static int kunit_try_catch_test_init(struct kunit *test)
 	.init = kunit_try_catch_test_init,
 	.test_cases = kunit_try_catch_test_cases,
 };
-kunit_test_suite(kunit_try_catch_test_suite);
 
 /*
  * Context for testing test managed resources
@@ -330,4 +329,6 @@ static void kunit_resource_test_exit(struct kunit *test)
 	.exit = kunit_resource_test_exit,
 	.test_cases = kunit_resource_test_cases,
 };
-kunit_test_suite(kunit_resource_test_suite);
+kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite);
+
+MODULE_LICENSE("GPL v2");
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
index 363c600..76babb1 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -743,4 +743,6 @@ static void list_test_list_for_each_entry_reverse(struct kunit *test)
 	.test_cases = list_test_cases,
 };
 
-kunit_test_suite(list_test_module);
+kunit_test_suites(&list_test_module);
+
+MODULE_LICENSE("GPL v2");
-- 
1.8.3.1

