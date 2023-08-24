Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61483787192
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 16:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbjHXOcl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 10:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241636AbjHXOcU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 10:32:20 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A9B1BC6;
        Thu, 24 Aug 2023 07:32:14 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37O7iEx8023063;
        Thu, 24 Aug 2023 09:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=lOM1+VyD0NxxiKa/rVXqPOdYK3QPp+JP1t7dVR+Q7J0=; b=
        PAi+aggG9dtgoa8VB0HE+Ymd0YeWF7D7mnWmGWcXbZIO1nVP02+tITV7W+sLhH2l
        r/6jyzRdqb29+3H14h+F/8B4x+Qy6n6Zie1oanJxodYpOp0S+DgFp5144rPTj9rY
        9ZT/RmMcS6D56Yg5f5DL8QKBg8Aei9dyhIhMvtDaaSagXXjhjabMiRKK+utG7x7P
        VlpltwuwICBQTuyC6Um0dnEt8Emeio9jlyfrFfV+ZPxlt/wCwAE8HTro2XFpNuO+
        9/ubxt8ewMsFxil/dnUxOE6qY3wwyzRenYRa33w3ekd5767n+/cbRpuvXLGshzhd
        WIlKavLtXNxC05qcbSaNGg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sp1rbghkk-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 09:31:35 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 24 Aug
 2023 15:31:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Thu, 24 Aug 2023 15:31:30 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 378C5357C;
        Thu, 24 Aug 2023 14:31:30 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v5 09/10] kunit: Use string_stream for test log
Date:   Thu, 24 Aug 2023 15:31:28 +0100
Message-ID: <20230824143129.1957914-10-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230824143129.1957914-1-rf@opensource.cirrus.com>
References: <20230824143129.1957914-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nhdoOAfSO2qDVA5xC2xuB1dQfzG0RRLn
X-Proofpoint-GUID: nhdoOAfSO2qDVA5xC2xuB1dQfzG0RRLn
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace the fixed-size log buffer with a string_stream so that the
log can grow as lines are added.

string_stream_clear() has been made public for the log truncation
done in kunit_init_test().

The existing kunit log tests have been updated for using a
string_stream as the log. No new test have been added because there
are already tests for the underlying string_stream.

As the log tests now depend on string_stream functions they cannot
build when kunit-test is a module. They have been surrounded by
a #if to replace them with skipping version when the test is
build as a module. Though this isn't pretty, it avoids moving
code to another file while that code is also being changed.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes since V4:
- Don't move the log tests to another file. Deal with only including them
  when the test is built-in by wrapping them in a #if. This is to simplify
  code review, because it avoids having a block of code which moves from
  one file to another but at the same time the code has changed.
- Use kunit_add_action() to automatically free the string returned by
  string_stream_get_string().
---
 include/kunit/test.h      | 14 +++++-------
 lib/kunit/debugfs.c       | 36 +++++++++++++++++++-----------
 lib/kunit/kunit-test.c    | 46 ++++++++++++++++++++++++++++++++-------
 lib/kunit/string-stream.c |  2 +-
 lib/kunit/string-stream.h |  2 ++
 lib/kunit/test.c          | 44 +++++--------------------------------
 6 files changed, 75 insertions(+), 69 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index d33114097d0d..b915a0fe93c0 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -32,9 +32,7 @@
 DECLARE_STATIC_KEY_FALSE(kunit_running);
 
 struct kunit;
-
-/* Size of log associated with test. */
-#define KUNIT_LOG_SIZE 2048
+struct string_stream;
 
 /* Maximum size of parameter description string. */
 #define KUNIT_PARAM_DESC_SIZE 128
@@ -132,7 +130,7 @@ struct kunit_case {
 	/* private: internal use only. */
 	enum kunit_status status;
 	char *module_name;
-	char *log;
+	struct string_stream *log;
 };
 
 static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
@@ -252,7 +250,7 @@ struct kunit_suite {
 	/* private: internal use only */
 	char status_comment[KUNIT_STATUS_COMMENT_SIZE];
 	struct dentry *debugfs;
-	char *log;
+	struct string_stream *log;
 	int suite_init_err;
 };
 
@@ -278,7 +276,7 @@ struct kunit {
 
 	/* private: internal use only. */
 	const char *name; /* Read only after initialization! */
-	char *log; /* Points at case log after initialization */
+	struct string_stream *log; /* Points at case log after initialization */
 	struct kunit_try_catch try_catch;
 	/* param_value is the current parameter value for a test case. */
 	const void *param_value;
@@ -314,7 +312,7 @@ const char *kunit_filter_glob(void);
 char *kunit_filter(void);
 char *kunit_filter_action(void);
 
-void kunit_init_test(struct kunit *test, const char *name, char *log);
+void kunit_init_test(struct kunit *test, const char *name, struct string_stream *log);
 
 int kunit_run_tests(struct kunit_suite *suite);
 
@@ -472,7 +470,7 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
 
 void kunit_cleanup(struct kunit *test);
 
-void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
+void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt, ...);
 
 /**
  * kunit_mark_skipped() - Marks @test_or_suite as skipped
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 22c5c496a68f..270d185737e6 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -37,14 +37,21 @@ void kunit_debugfs_init(void)
 		debugfs_rootdir = debugfs_create_dir(KUNIT_DEBUGFS_ROOT, NULL);
 }
 
-static void debugfs_print_result(struct seq_file *seq,
-				 struct kunit_suite *suite,
-				 struct kunit_case *test_case)
+static void debugfs_print_result(struct seq_file *seq, struct string_stream *log)
 {
-	if (!test_case || !test_case->log)
+	struct string_stream_fragment *frag_container;
+
+	if (!log)
 		return;
 
-	seq_printf(seq, "%s", test_case->log);
+	/*
+	 * Walk the fragments so we don't need to allocate a temporary
+	 * buffer to hold the entire string.
+	 */
+	spin_lock(&log->lock);
+	list_for_each_entry(frag_container, &log->fragments, node)
+		seq_printf(seq, "%s", frag_container->fragment);
+	spin_unlock(&log->lock);
 }
 
 /*
@@ -69,10 +76,9 @@ static int debugfs_print_results(struct seq_file *seq, void *v)
 	seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n", kunit_suite_num_test_cases(suite));
 
 	kunit_suite_for_each_test_case(suite, test_case)
-		debugfs_print_result(seq, suite, test_case);
+		debugfs_print_result(seq, test_case->log);
 
-	if (suite->log)
-		seq_printf(seq, "%s", suite->log);
+	debugfs_print_result(seq, suite->log);
 
 	seq_printf(seq, "%s %d %s\n",
 		   kunit_status_to_ok_not_ok(success), 1, suite->name);
@@ -105,9 +111,13 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
 	struct kunit_case *test_case;
 
 	/* Allocate logs before creating debugfs representation. */
-	suite->log = kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
-	kunit_suite_for_each_test_case(suite, test_case)
-		test_case->log = kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
+	suite->log = alloc_string_stream(GFP_KERNEL);
+	string_stream_set_append_newlines(suite->log, true);
+
+	kunit_suite_for_each_test_case(suite, test_case) {
+		test_case->log = alloc_string_stream(GFP_KERNEL);
+		string_stream_set_append_newlines(test_case->log, true);
+	}
 
 	suite->debugfs = debugfs_create_dir(suite->name, debugfs_rootdir);
 
@@ -121,7 +131,7 @@ void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
 	struct kunit_case *test_case;
 
 	debugfs_remove_recursive(suite->debugfs);
-	kfree(suite->log);
+	string_stream_destroy(suite->log);
 	kunit_suite_for_each_test_case(suite, test_case)
-		kfree(test_case->log);
+		string_stream_destroy(test_case->log);
 }
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 83d8e90ca7a2..616e287aa4bf 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -8,6 +8,7 @@
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 
+#include "string-stream.h"
 #include "try-catch-impl.h"
 
 struct kunit_try_catch_test_context {
@@ -530,12 +531,19 @@ static struct kunit_suite kunit_resource_test_suite = {
 	.test_cases = kunit_resource_test_cases,
 };
 
+/*
+ * Log tests call string_stream functions, which aren't exported. So only
+ * build this code if this test is built-in.
+ */
+#if IS_BUILTIN(CONFIG_KUNIT_TEST)
 static void kunit_log_test(struct kunit *test)
 {
 	struct kunit_suite suite;
+	char *full_log;
 
-	suite.log = kunit_kzalloc(test, KUNIT_LOG_SIZE, GFP_KERNEL);
+	suite.log = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
+	string_stream_set_append_newlines(suite.log, true);
 
 	kunit_log(KERN_INFO, test, "put this in log.");
 	kunit_log(KERN_INFO, test, "this too.");
@@ -543,14 +551,21 @@ static void kunit_log_test(struct kunit *test)
 	kunit_log(KERN_INFO, &suite, "along with this.");
 
 #ifdef CONFIG_KUNIT_DEBUGFS
+	KUNIT_EXPECT_TRUE(test, test->log->append_newlines);
+
+	full_log = string_stream_get_string(test->log);
+	kunit_add_action(test, (kunit_action_t *)kfree, full_log);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(test->log, "put this in log."));
+				     strstr(full_log, "put this in log."));
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(test->log, "this too."));
+				     strstr(full_log, "this too."));
+
+	full_log = string_stream_get_string(suite.log);
+	kunit_add_action(test, (kunit_action_t *)kfree, full_log);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(suite.log, "add to suite log."));
+				     strstr(full_log, "add to suite log."));
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(suite.log, "along with this."));
+				     strstr(full_log, "along with this."));
 #else
 	KUNIT_EXPECT_NULL(test, test->log);
 #endif
@@ -558,15 +573,30 @@ static void kunit_log_test(struct kunit *test)
 
 static void kunit_log_newline_test(struct kunit *test)
 {
+	char *full_log;
+
 	kunit_info(test, "Add newline\n");
 	if (test->log) {
-		KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "Add newline\n"),
-			"Missing log line, full log:\n%s", test->log);
-		KUNIT_EXPECT_NULL(test, strstr(test->log, "Add newline\n\n"));
+		full_log = string_stream_get_string(test->log);
+		kunit_add_action(test, (kunit_action_t *)kfree, full_log);
+		KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(full_log, "Add newline\n"),
+			"Missing log line, full log:\n%s", full_log);
+		KUNIT_EXPECT_NULL(test, strstr(full_log, "Add newline\n\n"));
 	} else {
 		kunit_skip(test, "only useful when debugfs is enabled");
 	}
 }
+#else
+static void kunit_log_test(struct kunit *test)
+{
+	kunit_skip(test, "Log tests only run when built-in");
+}
+
+static void kunit_log_newline_test(struct kunit *test)
+{
+	kunit_skip(test, "Log tests only run when built-in");
+}
+#endif /* IS_BUILTIN(CONFIG_KUNIT_TEST) */
 
 static struct kunit_case kunit_log_test_cases[] = {
 	KUNIT_CASE(kunit_log_test),
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index d2ded5207e9e..a6f3616c2048 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -99,7 +99,7 @@ int string_stream_add(struct string_stream *stream, const char *fmt, ...)
 	return result;
 }
 
-static void string_stream_clear(struct string_stream *stream)
+void string_stream_clear(struct string_stream *stream)
 {
 	struct string_stream_fragment *frag_container, *frag_container_safe;
 
diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
index c55925a9b67f..7be2450c7079 100644
--- a/lib/kunit/string-stream.h
+++ b/lib/kunit/string-stream.h
@@ -42,6 +42,8 @@ int __printf(2, 0) string_stream_vadd(struct string_stream *stream,
 				      const char *fmt,
 				      va_list args);
 
+void string_stream_clear(struct string_stream *stream);
+
 char *string_stream_get_string(struct string_stream *stream);
 
 int string_stream_append(struct string_stream *stream,
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 2ad45a4ac06a..b153808ff1ec 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -109,51 +109,17 @@ static void kunit_print_test_stats(struct kunit *test,
 		  stats.total);
 }
 
-/**
- * kunit_log_newline() - Add newline to the end of log if one is not
- * already present.
- * @log: The log to add the newline to.
- */
-static void kunit_log_newline(char *log)
-{
-	int log_len, len_left;
-
-	log_len = strlen(log);
-	len_left = KUNIT_LOG_SIZE - log_len - 1;
-
-	if (log_len > 0 && log[log_len - 1] != '\n')
-		strncat(log, "\n", len_left);
-}
-
-/*
- * Append formatted message to log, size of which is limited to
- * KUNIT_LOG_SIZE bytes (including null terminating byte).
- */
-void kunit_log_append(char *log, const char *fmt, ...)
+/* Append formatted message to log. */
+void kunit_log_append(struct string_stream *log, const char *fmt, ...)
 {
 	va_list args;
-	int len, log_len, len_left;
 
 	if (!log)
 		return;
 
-	log_len = strlen(log);
-	len_left = KUNIT_LOG_SIZE - log_len - 1;
-	if (len_left <= 0)
-		return;
-
-	/* Evaluate length of line to add to log */
 	va_start(args, fmt);
-	len = vsnprintf(NULL, 0, fmt, args) + 1;
+	string_stream_vadd(log, fmt, args);
 	va_end(args);
-
-	/* Print formatted line to the log */
-	va_start(args, fmt);
-	vsnprintf(log + log_len, min(len, len_left), fmt, args);
-	va_end(args);
-
-	/* Add newline to end of log if not already present. */
-	kunit_log_newline(log);
 }
 EXPORT_SYMBOL_GPL(kunit_log_append);
 
@@ -359,14 +325,14 @@ void __kunit_do_failed_assertion(struct kunit *test,
 }
 EXPORT_SYMBOL_GPL(__kunit_do_failed_assertion);
 
-void kunit_init_test(struct kunit *test, const char *name, char *log)
+void kunit_init_test(struct kunit *test, const char *name, struct string_stream *log)
 {
 	spin_lock_init(&test->lock);
 	INIT_LIST_HEAD(&test->resources);
 	test->name = name;
 	test->log = log;
 	if (test->log)
-		test->log[0] = '\0';
+		string_stream_clear(log);
 	test->status = KUNIT_SUCCESS;
 	test->status_comment[0] = '\0';
 }
-- 
2.30.2

