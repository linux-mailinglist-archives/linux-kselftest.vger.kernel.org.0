Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDBF1B1389
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 19:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgDTRuc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 13:50:32 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:37014 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgDTRuc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 13:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1587405031; x=1618941031;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=pRrOkVplgZuTn0u25tCHFZxzo9Wgq7pwIAyHlvUjY+8=;
  b=Eki9xxxSsWPse0uqTQTjz2VvMSCTFqhd27AJA21LQk5jmG4V2+CLWa5W
   5mWMKHSM7a7oBa5KmIY3rrksNf/t+97GODNTib6WRfytB/J+aj8fFsz86
   XcBKjqdqT7NB9TxntOmAucxAe9yxqiVQis1Ts4zAB86Fc6IcdlfQ+oUd2
   0=;
IronPort-SDR: o4F6bHpf8KdtBRsZsDGRRnL68jBR8qcpI3ZWHDt1qQM9PB1+Tl27mo6FcdxTvP0xD30NWszjM/
 fDRe+1iuWkpg==
X-IronPort-AV: E=Sophos;i="5.72,407,1580774400"; 
   d="scan'208";a="38178943"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 20 Apr 2020 17:50:14 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 7C34AA1BC0;
        Mon, 20 Apr 2020 17:50:13 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Apr 2020 17:50:12 +0000
Received: from 38f9d3582de7.ant.amazon.com (10.43.162.203) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Apr 2020 17:50:08 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        <osa-contribution-log@amazon.com>
Subject: [PATCH v3] selftests/harness: Add support for argc and argv.
Date:   Tue, 21 Apr 2020 02:50:02 +0900
Message-ID: <20200420175002.55864-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.203]
X-ClientProxiedBy: EX13D22UWC002.ant.amazon.com (10.43.162.29) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently tests are often written in C and shell script. In many cases, the
script passes some arguments to the C program. However, the helper
functions do not support arguments, so many tests are written without
helper functions.

This patch introduces two function macros: ARG_SETUP and ARG_TEARDOWN. The
'argc' and 'argv' are exposed as the member of the 'arg'. We can parse them
and populate/cleanup the 'arg->data' in ARG_SETUP/ARG_TEARDOWN. The 'arg'
is passed to TEST, TEST_*, and FIXTURE_* so that we can write tests more
flexibly with helper functions.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
---
 tools/testing/selftests/kselftest_harness.h | 108 +++++++++++++++++---
 1 file changed, 93 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2902f6a78f8a..a3ae6701e1ff 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -18,7 +18,7 @@
  *
  *    TEST(standalone_test) {
  *      do_some_stuff;
- *      EXPECT_GT(10, stuff) {
+ *      EXPECT_GT(10, ((struct myarg *)arg->data)->stuff) {
  *         stuff_state_t state;
  *         enumerate_stuff_state(&state);
  *         TH_LOG("expectation failed with state: %s", state.msg);
@@ -44,6 +44,13 @@
  *      EXPECT_EQ(1, is_my_data_good(self->data));
  *    }
  *
+ *    ARG_SETUP {
+ *      arg->data = myarg_new(argc, argv);
+ *    }
+ *    ARG_TEARDOWN {
+ *      myarg_free(arg->data);
+ *    }
+ *
  *    TEST_HARNESS_MAIN
  */
 
@@ -141,7 +148,9 @@
  * Defines a test by name.
  * Names must be unique and tests must not be run in parallel.  The
  * implementation containing block is a function and scoping should be treated
- * as such.  Returning early may be performed with a bare "return;" statement.
+ * as such.  The arguments will be exposed as *arg* populated in ARG_SETUP()
+ * for the implementation.  Returning early may be performed with a bare
+ * "return;" statement.
  *
  * EXPECT_* and ASSERT_* are valid in a TEST() { } context.
  */
@@ -167,7 +176,8 @@
 #define TEST_SIGNAL(test_name, signal) __TEST_IMPL(test_name, signal)
 
 #define __TEST_IMPL(test_name, _signal) \
-	static void test_name(struct __test_metadata *_metadata); \
+	static void test_name(struct __test_metadata *_metadata, \
+		struct __test_arg __attribute__((unused)) *arg); \
 	static struct __test_metadata _##test_name##_object = \
 		{ .name = "global." #test_name, \
 		  .fn = &test_name, .termsig = _signal, \
@@ -177,7 +187,8 @@
 		__register_test(&_##test_name##_object); \
 	} \
 	static void test_name( \
-		struct __test_metadata __attribute__((unused)) *_metadata)
+		struct __test_metadata __attribute__((unused)) *_metadata, \
+		struct __test_arg __attribute__((unused)) *arg)
 
 /**
  * FIXTURE_DATA(datatype_name) - Wraps the struct name so we have one less
@@ -241,7 +252,9 @@
 #define FIXTURE_SETUP(fixture_name) \
 	void fixture_name##_setup( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
+		struct __test_arg __attribute__((unused)) *arg, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
+
 /**
  * FIXTURE_TEARDOWN(fixture_name)
  * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
@@ -261,6 +274,7 @@
 #define FIXTURE_TEARDOWN(fixture_name) \
 	void fixture_name##_teardown( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
+		struct __test_arg __attribute__((unused)) *arg, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
 
 /**
@@ -293,19 +307,21 @@
 #define __TEST_F_IMPL(fixture_name, test_name, signal, tmout) \
 	static void fixture_name##_##test_name( \
 		struct __test_metadata *_metadata, \
+		struct __test_arg *arg, \
 		FIXTURE_DATA(fixture_name) *self); \
 	static inline void wrapper_##fixture_name##_##test_name( \
-		struct __test_metadata *_metadata) \
+		struct __test_metadata *_metadata, \
+		struct __test_arg *arg) \
 	{ \
 		/* fixture data is alloced, setup, and torn down per call. */ \
 		FIXTURE_DATA(fixture_name) self; \
 		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
-		fixture_name##_setup(_metadata, &self); \
+		fixture_name##_setup(_metadata, arg, &self); \
 		/* Let setup failure terminate early. */ \
 		if (!_metadata->passed) \
 			return; \
-		fixture_name##_##test_name(_metadata, &self); \
-		fixture_name##_teardown(_metadata, &self); \
+		fixture_name##_##test_name(_metadata, arg, &self); \
+		fixture_name##_teardown(_metadata, arg, &self); \
 	} \
 	static struct __test_metadata \
 		      _##fixture_name##_##test_name##_object = { \
@@ -321,8 +337,47 @@
 	} \
 	static void fixture_name##_##test_name( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
+		struct __test_arg __attribute__((unused)) *arg, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
 
+/**
+ * ARG_SETUP - Prepares the setup function for the arguments.
+ *
+ * .. code-block:: c
+ *
+ *     ARG_SETUP { implementation }
+ *
+ * Populates the required "setup" function for arguments. The argc and argv
+ * will be exposed as the member of *arg* for the implementation to populate
+ * the arg->data.
+ */
+#define ARG_SETUP \
+	static void __arg_setup(struct __test_arg *arg); \
+	static void __attribute__((constructor)) __arg_setup_ptr_init(void) \
+	{ \
+		__arg_setup_ptr = __arg_setup; \
+	} \
+	static void __arg_setup(struct __test_arg *arg)
+
+/**
+ * ARG_TEARDOWN
+ *
+ * .. code-block:: c
+ *
+ *     ARG_TEARDOWN { implementation }
+ *
+ * Populates the required "teardown" function for arguments. The argc and argv
+ * will be exposed as the member of *arg* for the implementation to clean up
+ * the arg->data.
+ */
+#define ARG_TEARDOWN \
+	static void __arg_teardown(struct __test_arg *arg); \
+	static void __attribute__((constructor)) __arg_teardown_ptr_init(void) \
+	{ \
+		__arg_teardown_ptr = __arg_teardown; \
+	} \
+	static void __arg_teardown(struct __test_arg *arg)
+
 /**
  * TEST_HARNESS_MAIN - Simple wrapper to run the test harness
  *
@@ -631,10 +686,17 @@
 	} \
 } while (0); OPTIONAL_HANDLER(_assert)
 
+/* Storage for the arguments */
+struct __test_arg {
+	int argc;
+	char **argv;
+	void *data;
+};
+
 /* Contains all the information for test execution and status checking. */
 struct __test_metadata {
 	const char *name;
-	void (*fn)(struct __test_metadata *);
+	void (*fn)(struct __test_metadata *, struct __test_arg *);
 	pid_t pid;	/* pid of test when being run */
 	int termsig;
 	int passed;
@@ -651,6 +713,8 @@ static struct __test_metadata *__test_list;
 static unsigned int __test_count;
 static unsigned int __fixture_count;
 static int __constructor_order;
+static void (*__arg_setup_ptr)(struct __test_arg *);
+static void (*__arg_teardown_ptr)(struct __test_arg *);
 
 #define _CONSTRUCTOR_ORDER_FORWARD   1
 #define _CONSTRUCTOR_ORDER_BACKWARD -1
@@ -790,7 +854,7 @@ void __wait_for_test(struct __test_metadata *t)
 	}
 }
 
-void __run_test(struct __test_metadata *t)
+void __run_test(struct __test_metadata *t, struct __test_arg *arg)
 {
 	t->passed = 1;
 	t->trigger = 0;
@@ -800,7 +864,7 @@ void __run_test(struct __test_metadata *t)
 		printf("ERROR SPAWNING TEST CHILD\n");
 		t->passed = 0;
 	} else if (t->pid == 0) {
-		t->fn(t);
+		t->fn(t, arg);
 		/* return the step that failed or 0 */
 		_exit(t->passed ? 0 : t->step);
 	} else {
@@ -809,20 +873,30 @@ void __run_test(struct __test_metadata *t)
 	printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"), t->name);
 }
 
-static int test_harness_run(int __attribute__((unused)) argc,
-			    char __attribute__((unused)) **argv)
+static int test_harness_run(int argc, char **argv)
 {
 	struct __test_metadata *t;
+	struct __test_arg arg = {
+		.argc = argc,
+		.argv = argv
+	};
 	int ret = 0;
 	unsigned int count = 0;
 	unsigned int pass_count = 0;
 
-	/* TODO(wad) add optional arguments similar to gtest. */
+	if (!!__arg_setup_ptr ^ !!__arg_teardown_ptr) {
+		printf("ERROR NO ARG_SETUP OR ARG_TEARDOWN\n");
+		return 1;
+	}
+
+	if (__arg_setup_ptr)
+		__arg_setup_ptr(&arg);
+
 	printf("[==========] Running %u tests from %u test cases.\n",
 	       __test_count, __fixture_count + 1);
 	for (t = __test_list; t; t = t->next) {
 		count++;
-		__run_test(t);
+		__run_test(t, &arg);
 		if (t->passed)
 			pass_count++;
 		else
@@ -830,6 +904,10 @@ static int test_harness_run(int __attribute__((unused)) argc,
 	}
 	printf("[==========] %u / %u tests passed.\n", pass_count, count);
 	printf("[  %s  ]\n", (ret ? "FAILED" : "PASSED"));
+
+	if (__arg_teardown_ptr)
+		__arg_teardown_ptr(&arg);
+
 	return ret;
 }
 
-- 
2.17.2 (Apple Git-113)

