Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC9FDB58C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395496AbfJQSJF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 14:09:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34880 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395417AbfJQSJF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 14:09:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HI4BiS161325;
        Thu, 17 Oct 2019 18:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=eGFxGT0sCmiQABEVnhIzmqtfbnf0SEuMq3D6lWk+X5U=;
 b=SXgXLBGtrGr3axSLO9guucDBqQFg0JWaQapefLk9uNl2GV9p50SXizjAmP1dgkul6OVd
 0FMcVhtMJEmv/9ski0L9HM3uYfxrHzTcnidarFc+r8J7Uf/5XMjF+L6TkC1e8WaBSsA0
 VY446GXoofV0B6W65sOLcIG2rjsvyTKOMQswxpNcgfbjqyb4VH12J+m6eXnINh08Xs+I
 WwieghEHNRArc8wVM43p7Z4tK/u+P+WqkEl8Lv3pLxPHIeRAqM0334ZGbqdLjqvuPl5B
 x7HgDwLPlWKx8ZhGe+mmOjomlHfBkeWG9u3BtvnjpQDTrF6iqlvCt3HjO7Bi671+uonq 8A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vk68v055b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:08:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HI8JMj176263;
        Thu, 17 Oct 2019 18:08:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vpvtm1nsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:08:27 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9HI7wnU029198;
        Thu, 17 Oct 2019 18:07:58 GMT
Received: from dhcp-10-175-161-223.vpn.oracle.com (/10.175.161.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 18:07:58 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Subject: [PATCH v3 linux-kselftest-test 4/6] kunit: allow kunit tests to be loaded as a module
Date:   Thu, 17 Oct 2019 19:07:17 +0100
Message-Id: <1571335639-21675-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com>
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=739
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=823 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170163
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

as tests are added to kunit, it will become less feasible to execute
all built tests together.  By supporting modular tests we provide
a simple way to do selective execution on a running system; specifying

CONFIG_KUNIT=y
CONFIG_KUNIT_EXAMPLE_TEST=m

...means we can simply "insmod example-test.ko" to run the tests.

To achieve this we need to

o export the required symbols in kunit
o for non-exported symbols, we need to utilize kunit_find_symbol;
  the simplest way is for the test suite init to call
  KUNIT_INIT_[FN|VAR]_SYMBOL() for each non-exported symbol.
o support a new way of declaring test suites.  Because a module cannot
  do multiple late_initcall()s, we provide a kunit_test_suites() macro
  to declare multiple suites within the same module at once.

When compiled as a module, use of KUNIT_INIT_[FN|VAR]_symbol() will
retrieve the symbol address via kunit_find_symbol() and assign a local
variable with the same symbol name appropriately.  When compiled builtin,
these definitions are used to verify that the types we specify match
the type of the symbol we are looking for.  Compiler errors will be
generated if not.

One wrinkle here is that we cannot use the same names for local function
pointer definitions; the reason for this is we have likely #included
a definition for the function in question already, so an attempt to
redefine it as a function pointer variable fails.  As a result the
KUNIT_INIT_FN_SYMBOL() macro requires a name for a local symbol we
have defined as a function pointer (with a signature matching the
desired function).

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 include/kunit/test.h           | 115 +++++++++++++++++++++++++++++++++++++----
 kernel/sysctl-test.c           |   4 +-
 lib/Kconfig.debug              |   2 +-
 lib/kunit/Kconfig              |   4 +-
 lib/kunit/assert.c             |   8 +++
 lib/kunit/example-test.c       |   4 +-
 lib/kunit/string-stream-test.c |  44 ++++++++++++----
 lib/kunit/test-test.c          |  32 ++++++++----
 lib/kunit/test.c               |   9 ++++
 lib/kunit/try-catch.c          |   2 +
 10 files changed, 187 insertions(+), 37 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index c645d18..9a3835a 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -12,6 +12,7 @@
 #include <kunit/assert.h>
 #include <kunit/try-catch.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -78,6 +79,86 @@ struct kunit_resource {
 	struct list_head node;
 };
 
+/**
+ * KUNIT_VAR_SYMBOL - A helper for defining non-exported variable symbols
+ *
+ * @name: name of the symbol.
+ * @type: type of symbol.
+ *
+ * In the module case, we define the pointer to the symbol type where
+ * we will store the symbol address; KUNIT_INIT_VAR_SYMBOL() will assign
+ * the symbol name to the dereferenced kunit_<symbol_name>.  Note that
+ * in the builtin case we still define kunit_<symbol_name>; the reason
+ * for this is it allows us to verify that the type value is correct
+ * in the builtin case and has not fallen out-of-sync with its original
+ * definition.
+ */
+#ifdef MODULE
+#define KUNIT_VAR_SYMBOL(symbol, type)					\
+	type * kunit_##symbol;						\
+	type symbol
+#else
+#define KUNIT_VAR_SYMBOL(symbol, type)					\
+	type * kunit_##symbol
+#endif
+
+/**
+ * KUNIT_INIT_VAR_SYMBOL - A helper for initializing non-exported variable
+ *			   symbols
+ * @test: optional pointer to test context
+ * @name: name of symbol
+ *
+ * In the module case, initialization consists of using kunit_find_symbol()
+ * to find the address of the symbol, and if found, we set the variable
+ * to the dereferenced address value.  As mentioned above, in the builtin
+ * case we simply assing kunit_<symbol_name> to &<symbol_name> ; this will
+ * generate a compilation warning if the type we specified in KUNIT_VAR_SYMBOL
+ * and the type of the symbol itself do not match.
+ */
+#ifdef MODULE
+#define KUNIT_INIT_VAR_SYMBOL(test, symbol)				\
+	do {								\
+		if (!(kunit_##symbol)) {				\
+			kunit_##symbol = kunit_find_symbol(#symbol);	\
+			if (!IS_ERR((kunit_##symbol)))			\
+				symbol = *(kunit_##symbol);		\
+		}							\
+		if (test)						\
+			KUNIT_ASSERT_NOT_ERR_OR_NULL(test,		\
+						     kunit_##symbol);	\
+	} while (0)
+#else
+#define KUNIT_INIT_VAR_SYMBOL(test, symbol)				\
+	kunit_##symbol = &(symbol)
+#endif
+
+/**
+ * KUNIT_INIT_FN_SYMBOL - A helper for initializing non-exported function
+ *			  symbols
+ * @test: optional pointer to test context
+ * @symbol: name of symbol
+ * @name: local name of function used to store function pointer to symbol
+ *
+ * In the module case, initialization consists of using kunit_find_symbol()
+ * to find the address of the symbol, and if found, we set function pointer
+ * name to the function address value.  In the non-module case, we simply
+ * assign name to symbol; this will generate a compilation error if the
+ * type we specified for function pointer @name does not match the symbol
+ * function type.
+ */
+#ifdef MODULE
+#define KUNIT_INIT_FN_SYMBOL(test, symbol, name)			\
+	do {								\
+		if (!name)						\
+			name = kunit_find_symbol(#symbol);		\
+		if (test)                                               \
+			KUNIT_ASSERT_NOT_ERR_OR_NULL(test, name);	\
+	} while (0)
+#else
+#define KUNIT_INIT_FN_SYMBOL(test, symbol, name)			\
+	name = symbol
+#endif
+
 struct kunit;
 
 /**
@@ -197,31 +278,45 @@ struct kunit {
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
index a3017a5..cdf14ce 100644
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
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index d8ae94e..2d57302 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -25,6 +25,7 @@ void kunit_base_assert_format(const struct kunit_assert *assert,
 	string_stream_add(stream, "%s FAILED at %s:%d\n",
 			 expect_or_assert, assert->file, assert->line);
 }
+EXPORT_SYMBOL_GPL(kunit_base_assert_format);
 
 void kunit_assert_print_msg(const struct kunit_assert *assert,
 			    struct string_stream *stream)
@@ -32,6 +33,7 @@ void kunit_assert_print_msg(const struct kunit_assert *assert,
 	if (assert->message.fmt)
 		string_stream_add(stream, "\n%pV", &assert->message);
 }
+EXPORT_SYMBOL_GPL(kunit_assert_print_msg);
 
 void kunit_fail_assert_format(const struct kunit_assert *assert,
 			      struct string_stream *stream)
@@ -39,6 +41,7 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream, "%pV", &assert->message);
 }
+EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
 
 void kunit_unary_assert_format(const struct kunit_assert *assert,
 			       struct string_stream *stream)
@@ -57,6 +60,7 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 				 unary_assert->condition);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_unary_assert_format);
 
 void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 				     struct string_stream *stream)
@@ -77,6 +81,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 	}
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
 
 void kunit_binary_assert_format(const struct kunit_assert *assert,
 				struct string_stream *stream)
@@ -98,6 +103,7 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
 
 void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
@@ -119,6 +125,7 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
 
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
@@ -140,3 +147,4 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
+EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
diff --git a/lib/kunit/example-test.c b/lib/kunit/example-test.c
index f64a829..ff930e0 100644
--- a/lib/kunit/example-test.c
+++ b/lib/kunit/example-test.c
@@ -85,4 +85,6 @@ static int example_test_init(struct kunit *test)
  * This registers the above test suite telling KUnit that this is a suite of
  * tests that need to be run.
  */
-kunit_test_suite(example_test_suite);
+kunit_test_suites(&example_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 25b2cf3..7d6055a 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -10,34 +10,53 @@
 #include <linux/slab.h>
 #include "string-stream-impl.h"
 
+/* Non-exported string stream functions which we will use in testing. */
+struct string_stream * (*_alloc_string_stream)(struct kunit *test, gfp_t gfp);
+int __printf(2, 3) (*_string_stream_add)(struct string_stream *stream,
+					 const char *fmt, ...);
+char * (*_string_stream_get_string)(struct string_stream *stream);
+bool (*_string_stream_is_empty)(struct string_stream *stream);
+
 static void string_stream_test_empty_on_creation(struct kunit *test)
 {
-	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+	struct string_stream *stream = _alloc_string_stream(test, GFP_KERNEL);
 
-	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
+	KUNIT_EXPECT_TRUE(test, _string_stream_is_empty(stream));
 }
 
 static void string_stream_test_not_empty_after_add(struct kunit *test)
 {
-	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+	struct string_stream *stream = _alloc_string_stream(test, GFP_KERNEL);
 
-	string_stream_add(stream, "Foo");
+	_string_stream_add(stream, "Foo");
 
-	KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
+	KUNIT_EXPECT_FALSE(test, _string_stream_is_empty(stream));
 }
 
 static void string_stream_test_get_string(struct kunit *test)
 {
-	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+	struct string_stream *stream = _alloc_string_stream(test, GFP_KERNEL);
 	char *output;
 
-	string_stream_add(stream, "Foo");
-	string_stream_add(stream, " %s", "bar");
+	_string_stream_add(stream, "Foo");
+	_string_stream_add(stream, " %s", "bar");
 
-	output = string_stream_get_string(stream);
+	output = _string_stream_get_string(stream);
 	KUNIT_ASSERT_STREQ(test, output, "Foo bar");
 }
 
+static int string_stream_test_init(struct kunit *test)
+{
+	KUNIT_INIT_FN_SYMBOL(test, alloc_string_stream, _alloc_string_stream);
+	KUNIT_INIT_FN_SYMBOL(test, string_stream_add, _string_stream_add);
+	KUNIT_INIT_FN_SYMBOL(test, string_stream_get_string,
+			     _string_stream_get_string);
+	KUNIT_INIT_FN_SYMBOL(test, string_stream_is_empty,
+			     _string_stream_is_empty);
+
+	return 0;
+}
+
 static struct kunit_case string_stream_test_cases[] = {
 	KUNIT_CASE(string_stream_test_empty_on_creation),
 	KUNIT_CASE(string_stream_test_not_empty_after_add),
@@ -47,6 +66,9 @@ static void string_stream_test_get_string(struct kunit *test)
 
 static struct kunit_suite string_stream_test_suite = {
 	.name = "string-stream-test",
-	.test_cases = string_stream_test_cases
+	.test_cases = string_stream_test_cases,
+	.init = string_stream_test_init
 };
-kunit_test_suite(string_stream_test_suite);
+kunit_test_suites(&string_stream_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/lib/kunit/test-test.c b/lib/kunit/test-test.c
index 7f09dd0..b4c1216 100644
--- a/lib/kunit/test-test.c
+++ b/lib/kunit/test-test.c
@@ -8,6 +8,11 @@
 #include <kunit/test.h>
 #include "try-catch-impl.h"
 
+void (*_kunit_try_catch_init)(struct kunit_try_catch *try_catch,
+			      struct kunit *test,
+			      kunit_try_catch_func_t try,
+			      kunit_try_catch_func_t catch);
+
 struct kunit_try_catch_test_context {
 	struct kunit_try_catch *try_catch;
 	bool function_called;
@@ -33,10 +38,10 @@ static void kunit_test_try_catch_successful_try_no_catch(struct kunit *test)
 	struct kunit_try_catch_test_context *ctx = test->priv;
 	struct kunit_try_catch *try_catch = ctx->try_catch;
 
-	kunit_try_catch_init(try_catch,
-			     test,
-			     kunit_test_successful_try,
-			     kunit_test_no_catch);
+	_kunit_try_catch_init(try_catch,
+			      test,
+			      kunit_test_successful_try,
+			      kunit_test_no_catch);
 	kunit_try_catch_run(try_catch, test);
 
 	KUNIT_EXPECT_TRUE(test, ctx->function_called);
@@ -65,10 +70,10 @@ static void kunit_test_try_catch_unsuccessful_try_does_catch(struct kunit *test)
 	struct kunit_try_catch_test_context *ctx = test->priv;
 	struct kunit_try_catch *try_catch = ctx->try_catch;
 
-	kunit_try_catch_init(try_catch,
-			     test,
-			     kunit_test_unsuccessful_try,
-			     kunit_test_catch);
+	_kunit_try_catch_init(try_catch,
+			      test,
+			      kunit_test_unsuccessful_try,
+			      kunit_test_catch);
 	kunit_try_catch_run(try_catch, test);
 
 	KUNIT_EXPECT_TRUE(test, ctx->function_called);
@@ -78,6 +83,8 @@ static int kunit_try_catch_test_init(struct kunit *test)
 {
 	struct kunit_try_catch_test_context *ctx;
 
+	KUNIT_INIT_FN_SYMBOL(test, kunit_try_catch_init, _kunit_try_catch_init);
+
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 	test->priv = ctx;
@@ -101,7 +108,6 @@ static int kunit_try_catch_test_init(struct kunit *test)
 	.init = kunit_try_catch_test_init,
 	.test_cases = kunit_try_catch_test_cases,
 };
-kunit_test_suite(kunit_try_catch_test_suite);
 
 /*
  * Context for testing test managed resources
@@ -329,7 +335,6 @@ static void kunit_resource_test_exit(struct kunit *test)
 	.exit = kunit_resource_test_exit,
 	.test_cases = kunit_resource_test_cases,
 };
-kunit_test_suite(kunit_resource_test_suite);
 
 /*
  * Find non-exported kernel symbol; we use the modules list as a safe
@@ -348,4 +353,9 @@ static void kunit_find_symbol_kernel(struct kunit *test)
 	.name = "kunit-find-symbol",
 	.test_cases = kunit_find_symbol_test_cases,
 };
-kunit_test_suite(kunit_find_symbol_test_suite);
+
+kunit_test_suites(&kunit_resource_test_suite,
+		  &kunit_try_catch_test_suite,
+		  &kunit_find_symbol_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index a2b1b46..e8b2443 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -174,6 +174,7 @@ void kunit_do_assertion(struct kunit *test,
 	if (assert->type == KUNIT_ASSERTION)
 		kunit_abort(test);
 }
+EXPORT_SYMBOL_GPL(kunit_do_assertion);
 
 void kunit_init_test(struct kunit *test, const char *name)
 {
@@ -182,6 +183,7 @@ void kunit_init_test(struct kunit *test, const char *name)
 	test->name = name;
 	test->success = true;
 }
+EXPORT_SYMBOL_GPL(kunit_init_test);
 
 /*
  * Initializes and runs test case. Does not clean up or do post validations.
@@ -320,6 +322,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kunit_run_tests);
 
 struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
 						    kunit_resource_init_t init,
@@ -345,6 +348,7 @@ struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
 
 	return res;
 }
+EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
 
 static void kunit_resource_free(struct kunit *test, struct kunit_resource *res)
 {
@@ -403,6 +407,7 @@ int kunit_resource_destroy(struct kunit *test,
 	kunit_resource_free(test, resource);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kunit_resource_destroy);
 
 struct kunit_kmalloc_params {
 	size_t size;
@@ -438,6 +443,7 @@ void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
 				    gfp,
 				    &params);
 }
+EXPORT_SYMBOL_GPL(kunit_kmalloc);
 
 void kunit_kfree(struct kunit *test, const void *ptr)
 {
@@ -450,6 +456,7 @@ void kunit_kfree(struct kunit *test, const void *ptr)
 
 	WARN_ON(rc);
 }
+EXPORT_SYMBOL_GPL(kunit_kfree);
 
 void kunit_cleanup(struct kunit *test)
 {
@@ -479,6 +486,7 @@ void kunit_cleanup(struct kunit *test)
 		kunit_resource_free(test, resource);
 	}
 }
+EXPORT_SYMBOL_GPL(kunit_cleanup);
 
 /*
  * Support for looking up kernel/module internal symbols to enable testing.
@@ -514,3 +522,4 @@ void *kunit_find_symbol(const char *sym)
 #endif
 	return ERR_PTR(-ENOENT);
 }
+EXPORT_SYMBOL(kunit_find_symbol);
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 0c4c90c..1c1e9af 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -20,6 +20,7 @@ void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
 	try_catch->try_result = -EFAULT;
 	complete_and_exit(try_catch->try_completion, -EFAULT);
 }
+EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
 
 static int kunit_generic_run_threadfn_adapter(void *data)
 {
@@ -107,6 +108,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 
 	try_catch->catch(try_catch->context);
 }
+EXPORT_SYMBOL_GPL(kunit_try_catch_run);
 
 void kunit_try_catch_init(struct kunit_try_catch *try_catch,
 			  struct kunit *test,
-- 
1.8.3.1

