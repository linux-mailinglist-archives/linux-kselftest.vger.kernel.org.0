Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E392D77B9D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 15:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjHNNXy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 09:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjHNNXj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 09:23:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0596C10C6;
        Mon, 14 Aug 2023 06:23:38 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37E5t3EN003856;
        Mon, 14 Aug 2023 08:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=+BBXdxK8Pf+uSHNbvIHSNZw2FpnfU50yVfAT5GHEHYw=; b=
        npPWybSDyR3lARAVejRhn7FXbLDU6w64fSAjmnKlXANaWXCgVsXVd7f+iqn0pqph
        jQ57EaxbiTF6yrSnm969fyrb0DAE5g01vaMzXFVUJis/QExLCsMsSiO6GTbfk5Bl
        eCQ6xsjofegOAoko7xvPKr025ZtsOYuVcA+vgEX8egsBmRCTAeRuOirQvTCllB34
        Y1FBmKMh2cs/C4uTD/tbky2rC57qPgID6sQ1wXAhQ3HyOjMYl1ZnWGs2/u2GET7s
        F0nsWfBpaEQ0AD0zifafrrpSj9cy/x67ZohQVzuAZc2SxHr419FGdaXpp4EhmMVe
        tByZNloonmngYCtH7CwDXw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kqt6x8-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:23:19 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 14 Aug
 2023 14:23:16 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Mon, 14 Aug 2023 14:23:16 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9AA4F15B4;
        Mon, 14 Aug 2023 13:23:15 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 09/10] kunit: Use string_stream for test log
Date:   Mon, 14 Aug 2023 14:23:08 +0100
Message-ID: <20230814132309.32641-10-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230814132309.32641-1-rf@opensource.cirrus.com>
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7De8gvqUaM7YifO5SdZIjnbEJxphFxX5
X-Proofpoint-GUID: 7De8gvqUaM7YifO5SdZIjnbEJxphFxX5
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace the fixed-size log buffer with a string_stream so that the
log can grow as lines are added.

The existing kunit log tests have been updated for using a
string_stream as the log. As they now depend on string_stream
functions they cannot build when kunit-test is a module. They have
been moved to a separate source file to be built only if kunit-test
is built-in.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/kunit/test.h   | 14 ++++----
 lib/kunit/Makefile     |  5 +--
 lib/kunit/debugfs.c    | 36 +++++++++++++--------
 lib/kunit/kunit-test.c | 52 +-----------------------------
 lib/kunit/log-test.c   | 72 ++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c       | 44 +++-----------------------
 6 files changed, 110 insertions(+), 113 deletions(-)
 create mode 100644 lib/kunit/log-test.c

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
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 46f75f23dfe4..65735c2e1d14 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -18,9 +18,10 @@ obj-y +=				hooks.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 
-# string-stream-test compiles built-in only.
+# string-stream-test and log-test compiles built-in only.
 ifeq ($(CONFIG_KUNIT_TEST),y)
-obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
+obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o \
+					log-test.o
 endif
 
 obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 22c5c496a68f..ab53a7e5c898 100644
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
+	suite->log = raw_alloc_string_stream(GFP_KERNEL);
+	string_stream_set_append_newlines(suite->log, true);
+
+	kunit_suite_for_each_test_case(suite, test_case) {
+		test_case->log = raw_alloc_string_stream(GFP_KERNEL);
+		string_stream_set_append_newlines(test_case->log, true);
+	}
 
 	suite->debugfs = debugfs_create_dir(suite->name, debugfs_rootdir);
 
@@ -121,7 +131,7 @@ void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
 	struct kunit_case *test_case;
 
 	debugfs_remove_recursive(suite->debugfs);
-	kfree(suite->log);
+	raw_free_string_stream(suite->log);
 	kunit_suite_for_each_test_case(suite, test_case)
-		kfree(test_case->log);
+		raw_free_string_stream(test_case->log);
 }
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 83d8e90ca7a2..ecc39d5f7411 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -530,55 +530,6 @@ static struct kunit_suite kunit_resource_test_suite = {
 	.test_cases = kunit_resource_test_cases,
 };
 
-static void kunit_log_test(struct kunit *test)
-{
-	struct kunit_suite suite;
-
-	suite.log = kunit_kzalloc(test, KUNIT_LOG_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
-
-	kunit_log(KERN_INFO, test, "put this in log.");
-	kunit_log(KERN_INFO, test, "this too.");
-	kunit_log(KERN_INFO, &suite, "add to suite log.");
-	kunit_log(KERN_INFO, &suite, "along with this.");
-
-#ifdef CONFIG_KUNIT_DEBUGFS
-	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(test->log, "put this in log."));
-	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(test->log, "this too."));
-	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(suite.log, "add to suite log."));
-	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(suite.log, "along with this."));
-#else
-	KUNIT_EXPECT_NULL(test, test->log);
-#endif
-}
-
-static void kunit_log_newline_test(struct kunit *test)
-{
-	kunit_info(test, "Add newline\n");
-	if (test->log) {
-		KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "Add newline\n"),
-			"Missing log line, full log:\n%s", test->log);
-		KUNIT_EXPECT_NULL(test, strstr(test->log, "Add newline\n\n"));
-	} else {
-		kunit_skip(test, "only useful when debugfs is enabled");
-	}
-}
-
-static struct kunit_case kunit_log_test_cases[] = {
-	KUNIT_CASE(kunit_log_test),
-	KUNIT_CASE(kunit_log_newline_test),
-	{}
-};
-
-static struct kunit_suite kunit_log_test_suite = {
-	.name = "kunit-log-test",
-	.test_cases = kunit_log_test_cases,
-};
-
 static void kunit_status_set_failure_test(struct kunit *test)
 {
 	struct kunit fake;
@@ -658,7 +609,6 @@ static struct kunit_suite kunit_current_test_suite = {
 };
 
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
-		  &kunit_log_test_suite, &kunit_status_test_suite,
-		  &kunit_current_test_suite);
+		  &kunit_status_test_suite, &kunit_current_test_suite);
 
 MODULE_LICENSE("GPL v2");
diff --git a/lib/kunit/log-test.c b/lib/kunit/log-test.c
new file mode 100644
index 000000000000..a93d87112fea
--- /dev/null
+++ b/lib/kunit/log-test.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for logging.
+ *
+ * Based on code:
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+#include <kunit/test.h>
+
+#include "string-stream.h"
+
+static void kunit_log_test(struct kunit *test)
+{
+	struct kunit_suite suite;
+	char *full_log;
+
+	suite.log = alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
+	string_stream_set_append_newlines(suite.log, true);
+
+	kunit_log(KERN_INFO, test, "put this in log.");
+	kunit_log(KERN_INFO, test, "this too.");
+	kunit_log(KERN_INFO, &suite, "add to suite log.");
+	kunit_log(KERN_INFO, &suite, "along with this.");
+
+#ifdef CONFIG_KUNIT_DEBUGFS
+	KUNIT_EXPECT_TRUE(test, test->log->append_newlines);
+
+	full_log = string_stream_get_string(test, test->log, GFP_KERNEL);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(full_log, "put this in log."));
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(full_log, "this too."));
+
+	full_log = string_stream_get_string(test, suite.log, GFP_KERNEL);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(full_log, "add to suite log."));
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(full_log, "along with this."));
+#else
+	KUNIT_EXPECT_NULL(test, test->log);
+#endif
+}
+
+static void kunit_log_newline_test(struct kunit *test)
+{
+	char *full_log;
+
+	kunit_info(test, "Add newline\n");
+	if (test->log) {
+		full_log = string_stream_get_string(test, test->log, GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(full_log, "Add newline\n"),
+			"Missing log line, full log:\n%s", full_log);
+		KUNIT_EXPECT_NULL(test, strstr(full_log, "Add newline\n\n"));
+	} else {
+		kunit_skip(test, "only useful when debugfs is enabled");
+	}
+}
+
+static struct kunit_case kunit_log_test_cases[] = {
+	KUNIT_CASE(kunit_log_test),
+	KUNIT_CASE(kunit_log_newline_test),
+	{}
+};
+
+static struct kunit_suite kunit_log_test_suite = {
+	.name = "kunit-log-test",
+	.test_cases = kunit_log_test_cases,
+};
+
+kunit_test_suites(&kunit_log_test_suite);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 4b69d12dfc96..14e889e80129 100644
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

