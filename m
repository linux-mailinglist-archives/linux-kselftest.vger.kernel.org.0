Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE43C776475
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 17:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjHIPzC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 11:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjHIPy7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 11:54:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7119E1FF9;
        Wed,  9 Aug 2023 08:54:58 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379EvsGK002928;
        Wed, 9 Aug 2023 10:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=+CEzH+rL6x1SVzo0jVm7sIO4j6kpVtWp3r0+9eaMezs=; b=
        YqWwbgN+4r1+7vpX5GKG6vN0967F2QKalGYYhjsTZkcplF+5JsykTU4dEHM6Kc+s
        ZJGre2b9BSUr5EPSBFQSyJjglnf6KTe/CwXxid3WbxPJAoiLDt+k+6/BHA8Solla
        fzwb1xOfe6VS+LZ/Ziv1N1wCxGmZDbNLSk5Gr2iRfFj3qZwIlSRmD7yE8CJu7wHq
        3X7xEzC/zryPU+C6C10bNailca0Q9ENZ7qMeiaj+tUNSczv1gb/1qQmRx7TUIUa8
        5Lmiv4p4WacFESbqgJdB1vvAowGEoeRaMGpMdURvi2AKcuWC5RNTIxC4qP3TBQRF
        628ZLl3ImMVeIuWxDRhKuw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhuvg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 10:54:47 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 16:54:46 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Wed, 9 Aug 2023 16:54:46 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9D12E3578;
        Wed,  9 Aug 2023 15:54:45 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 1/7] kunit: Replace fixed-size log with dynamically-extending buffer
Date:   Wed, 9 Aug 2023 16:54:32 +0100
Message-ID: <20230809155438.22470-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230809155438.22470-1-rf@opensource.cirrus.com>
References: <20230809155438.22470-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Nf0KBYJ2lHGpFOy5JOMIOqxElt1ZMGuA
X-Proofpoint-ORIG-GUID: Nf0KBYJ2lHGpFOy5JOMIOqxElt1ZMGuA
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Re-implement the log buffer as a list of buffer fragments that can
be extended as the size of the log info grows.

When using parameterization the test case can run many times and create
a large amount of log. It's not really practical to keep increasing the
size of the fixed buffer every time a test needs more space. And a big
fixed buffer wastes memory.

The original char *log pointer is replaced by a pointer to a list of
struct kunit_log_frag, each containing a fixed-size buffer.

kunit_log_append() now attempts to append to the last kunit_log_frag in
the list. If there isn't enough space it will append a new kunit_log_frag
to the list. This simple implementation does not attempt to completely
fill the buffer in every kunit_log_frag.

The 'log' member of kunit_suite, kunit_test_case and kunit_suite must be a
pointer because the API of kunit_log() requires that is the same type in
all  three structs. As kunit.log is a pointer to the 'log' of the current
kunit_case, it must be a pointer in the other two structs.

The existing kunit-test.c log tests have been updated to build against the
new fragmented log implementation. If the test fails the new function
get_concatenated_log() constructs a single contiguous string from the
log fragments so that the whole log can be emitted in the failure
message.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/kunit/test.h   | 25 +++++++++++-----
 lib/kunit/debugfs.c    | 65 ++++++++++++++++++++++++++++++++++--------
 lib/kunit/kunit-test.c | 48 +++++++++++++++++++++++++------
 lib/kunit/test.c       | 63 ++++++++++++++++++++++++++++------------
 4 files changed, 155 insertions(+), 46 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index d33114097d0d..cb5082efc91c 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -33,8 +33,8 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
 
 struct kunit;
 
-/* Size of log associated with test. */
-#define KUNIT_LOG_SIZE 2048
+/* Size of log buffer fragments. */
+#define KUNIT_LOG_FRAGMENT_SIZE (256 - sizeof(struct list_head))
 
 /* Maximum size of parameter description string. */
 #define KUNIT_PARAM_DESC_SIZE 128
@@ -85,6 +85,17 @@ struct kunit_attributes {
 	enum kunit_speed speed;
 };
 
+struct kunit_log_frag {
+	struct list_head list;
+	char buf[KUNIT_LOG_FRAGMENT_SIZE];
+};
+
+static inline void kunit_init_log_frag(struct kunit_log_frag *frag)
+{
+	INIT_LIST_HEAD(&frag->list);
+	frag->buf[0] = '\0';
+}
+
 /**
  * struct kunit_case - represents an individual test case.
  *
@@ -132,7 +143,7 @@ struct kunit_case {
 	/* private: internal use only. */
 	enum kunit_status status;
 	char *module_name;
-	char *log;
+	struct list_head *log;
 };
 
 static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
@@ -252,7 +263,7 @@ struct kunit_suite {
 	/* private: internal use only */
 	char status_comment[KUNIT_STATUS_COMMENT_SIZE];
 	struct dentry *debugfs;
-	char *log;
+	struct list_head *log;
 	int suite_init_err;
 };
 
@@ -278,7 +289,7 @@ struct kunit {
 
 	/* private: internal use only. */
 	const char *name; /* Read only after initialization! */
-	char *log; /* Points at case log after initialization */
+	struct list_head *log; /* Points at case log after initialization */
 	struct kunit_try_catch try_catch;
 	/* param_value is the current parameter value for a test case. */
 	const void *param_value;
@@ -314,7 +325,7 @@ const char *kunit_filter_glob(void);
 char *kunit_filter(void);
 char *kunit_filter_action(void);
 
-void kunit_init_test(struct kunit *test, const char *name, char *log);
+void kunit_init_test(struct kunit *test, const char *name, struct list_head *log);
 
 int kunit_run_tests(struct kunit_suite *suite);
 
@@ -472,7 +483,7 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
 
 void kunit_cleanup(struct kunit *test);
 
-void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
+void __printf(2, 3) kunit_log_append(struct list_head *log, const char *fmt, ...);
 
 /**
  * kunit_mark_skipped() - Marks @test_or_suite as skipped
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 22c5c496a68f..a26b6d31bd2f 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/list.h>
 #include <linux/module.h>
 
 #include <kunit/test.h>
@@ -37,14 +38,15 @@ void kunit_debugfs_init(void)
 		debugfs_rootdir = debugfs_create_dir(KUNIT_DEBUGFS_ROOT, NULL);
 }
 
-static void debugfs_print_result(struct seq_file *seq,
-				 struct kunit_suite *suite,
-				 struct kunit_case *test_case)
+static void debugfs_print_log(struct seq_file *seq, const struct list_head *log)
 {
-	if (!test_case || !test_case->log)
+	struct kunit_log_frag *frag;
+
+	if (!log)
 		return;
 
-	seq_printf(seq, "%s", test_case->log);
+	list_for_each_entry(frag, log, list)
+		seq_puts(seq, frag->buf);
 }
 
 /*
@@ -69,10 +71,9 @@ static int debugfs_print_results(struct seq_file *seq, void *v)
 	seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n", kunit_suite_num_test_cases(suite));
 
 	kunit_suite_for_each_test_case(suite, test_case)
-		debugfs_print_result(seq, suite, test_case);
+		debugfs_print_log(seq, test_case->log);
 
-	if (suite->log)
-		seq_printf(seq, "%s", suite->log);
+	debugfs_print_log(seq, suite->log);
 
 	seq_printf(seq, "%s %d %s\n",
 		   kunit_status_to_ok_not_ok(success), 1, suite->name);
@@ -100,14 +101,53 @@ static const struct file_operations debugfs_results_fops = {
 	.release = debugfs_release,
 };
 
+static struct list_head *kunit_debugfs_alloc_log(void)
+{
+	struct list_head *log;
+	struct kunit_log_frag *frag;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		return NULL;
+
+	INIT_LIST_HEAD(log);
+
+	frag = kmalloc(sizeof(*frag), GFP_KERNEL);
+	if (!frag) {
+		kfree(log);
+		return NULL;
+	}
+
+	kunit_init_log_frag(frag);
+	list_add_tail(&frag->list, log);
+
+	return log;
+}
+
+static void kunit_debugfs_free_log(struct list_head *log)
+{
+	struct kunit_log_frag *frag, *n;
+
+	if (!log)
+		return;
+
+	list_for_each_entry_safe(frag, n, log, list) {
+		list_del(&frag->list);
+		kfree(frag);
+	}
+
+	kfree(log);
+}
+
 void kunit_debugfs_create_suite(struct kunit_suite *suite)
 {
 	struct kunit_case *test_case;
 
 	/* Allocate logs before creating debugfs representation. */
-	suite->log = kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
+	suite->log = kunit_debugfs_alloc_log();
+
 	kunit_suite_for_each_test_case(suite, test_case)
-		test_case->log = kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
+		test_case->log = kunit_debugfs_alloc_log();
 
 	suite->debugfs = debugfs_create_dir(suite->name, debugfs_rootdir);
 
@@ -121,7 +161,8 @@ void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
 	struct kunit_case *test_case;
 
 	debugfs_remove_recursive(suite->debugfs);
-	kfree(suite->log);
+	kunit_debugfs_free_log(suite->log);
+
 	kunit_suite_for_each_test_case(suite, test_case)
-		kfree(test_case->log);
+		kunit_debugfs_free_log(test_case->log);
 }
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 83d8e90ca7a2..a199f83bac67 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -530,12 +530,37 @@ static struct kunit_suite kunit_resource_test_suite = {
 	.test_cases = kunit_resource_test_cases,
 };
 
+static char *get_concatenated_log(struct kunit *test, const struct list_head *log)
+{
+	struct kunit_log_frag *frag;
+	size_t len = 0;
+	char *p;
+
+	list_for_each_entry(frag, log, list)
+		len += strlen(frag->buf);
+
+	len++; /* for terminating '\0' */
+	p = kunit_kzalloc(test, len, GFP_KERNEL);
+
+	list_for_each_entry(frag, log, list)
+		strlcat(p, frag->buf, len);
+
+	return p;
+}
+
 static void kunit_log_test(struct kunit *test)
 {
 	struct kunit_suite suite;
+	struct kunit_log_frag *frag;
 
-	suite.log = kunit_kzalloc(test, KUNIT_LOG_SIZE, GFP_KERNEL);
+	suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
+	INIT_LIST_HEAD(suite.log);
+	frag = kunit_kmalloc(test, sizeof(*frag), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
+	kunit_init_log_frag(frag);
+	KUNIT_EXPECT_EQ(test, frag->buf[0], '\0');
+	list_add_tail(&frag->list, suite.log);
 
 	kunit_log(KERN_INFO, test, "put this in log.");
 	kunit_log(KERN_INFO, test, "this too.");
@@ -543,14 +568,17 @@ static void kunit_log_test(struct kunit *test)
 	kunit_log(KERN_INFO, &suite, "along with this.");
 
 #ifdef CONFIG_KUNIT_DEBUGFS
+	frag = list_first_entry(test->log, struct kunit_log_frag, list);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(test->log, "put this in log."));
+				     strstr(frag->buf, "put this in log."));
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(test->log, "this too."));
+				     strstr(frag->buf, "this too."));
+
+	frag = list_first_entry(suite.log, struct kunit_log_frag, list);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(suite.log, "add to suite log."));
+				     strstr(frag->buf, "add to suite log."));
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(suite.log, "along with this."));
+				     strstr(frag->buf, "along with this."));
 #else
 	KUNIT_EXPECT_NULL(test, test->log);
 #endif
@@ -558,11 +586,15 @@ static void kunit_log_test(struct kunit *test)
 
 static void kunit_log_newline_test(struct kunit *test)
 {
+	struct kunit_log_frag *frag;
+
 	kunit_info(test, "Add newline\n");
 	if (test->log) {
-		KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "Add newline\n"),
-			"Missing log line, full log:\n%s", test->log);
-		KUNIT_EXPECT_NULL(test, strstr(test->log, "Add newline\n\n"));
+		frag = list_first_entry(test->log, struct kunit_log_frag, list);
+		KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(frag->buf, "Add newline\n"),
+			"Missing log line, full log:\n%s",
+			get_concatenated_log(test, test->log));
+		KUNIT_EXPECT_NULL(test, strstr(frag->buf, "Add newline\n\n"));
 	} else {
 		kunit_skip(test, "only useful when debugfs is enabled");
 	}
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 49698a168437..dfe51bc2b387 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,6 +11,7 @@
 #include <kunit/test-bug.h>
 #include <kunit/attributes.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/panic.h>
@@ -114,46 +115,66 @@ static void kunit_print_test_stats(struct kunit *test,
  * already present.
  * @log: The log to add the newline to.
  */
-static void kunit_log_newline(char *log)
+static void kunit_log_newline(struct kunit_log_frag *frag)
 {
 	int log_len, len_left;
 
-	log_len = strlen(log);
-	len_left = KUNIT_LOG_SIZE - log_len - 1;
+	log_len = strlen(frag->buf);
+	len_left = sizeof(frag->buf) - log_len - 1;
 
-	if (log_len > 0 && log[log_len - 1] != '\n')
-		strncat(log, "\n", len_left);
+	if (log_len > 0 && frag->buf[log_len - 1] != '\n')
+		strncat(frag->buf, "\n", len_left);
 }
 
-/*
- * Append formatted message to log, size of which is limited to
- * KUNIT_LOG_SIZE bytes (including null terminating byte).
- */
-void kunit_log_append(char *log, const char *fmt, ...)
+static struct kunit_log_frag *kunit_log_extend(struct list_head *log)
+{
+	struct kunit_log_frag *frag;
+
+	frag = kmalloc(sizeof(*frag), GFP_KERNEL);
+	if (!frag)
+		return NULL;
+
+	kunit_init_log_frag(frag);
+	list_add_tail(&frag->list, log);
+
+	return frag;
+}
+
+/* Append formatted message to log, extending the log buffer if necessary. */
+void kunit_log_append(struct list_head *log, const char *fmt, ...)
 {
 	va_list args;
+	struct kunit_log_frag *frag;
 	int len, log_len, len_left;
 
 	if (!log)
 		return;
 
-	log_len = strlen(log);
-	len_left = KUNIT_LOG_SIZE - log_len - 1;
-	if (len_left <= 0)
-		return;
+	frag = list_last_entry(log, struct kunit_log_frag, list);
+	log_len = strlen(frag->buf);
+	len_left = sizeof(frag->buf) - log_len - 1;
 
 	/* Evaluate length of line to add to log */
 	va_start(args, fmt);
 	len = vsnprintf(NULL, 0, fmt, args) + 1;
 	va_end(args);
 
+	if (len > len_left) {
+		frag = kunit_log_extend(log);
+		if (!frag)
+			return;
+
+		len_left = sizeof(frag->buf) - 1;
+		log_len = 0;
+	}
+
 	/* Print formatted line to the log */
 	va_start(args, fmt);
-	vsnprintf(log + log_len, min(len, len_left), fmt, args);
+	vsnprintf(frag->buf + log_len, min(len, len_left), fmt, args);
 	va_end(args);
 
 	/* Add newline to end of log if not already present. */
-	kunit_log_newline(log);
+	kunit_log_newline(frag);
 }
 EXPORT_SYMBOL_GPL(kunit_log_append);
 
@@ -359,14 +380,18 @@ void __kunit_do_failed_assertion(struct kunit *test,
 }
 EXPORT_SYMBOL_GPL(__kunit_do_failed_assertion);
 
-void kunit_init_test(struct kunit *test, const char *name, char *log)
+void kunit_init_test(struct kunit *test, const char *name, struct list_head *log)
 {
 	spin_lock_init(&test->lock);
 	INIT_LIST_HEAD(&test->resources);
 	test->name = name;
 	test->log = log;
-	if (test->log)
-		test->log[0] = '\0';
+	if (test->log) {
+		struct kunit_log_frag *frag = list_first_entry(test->log,
+							       struct kunit_log_frag,
+							       list);
+		frag->buf[0] = '\0';
+	}
 	test->status = KUNIT_SUCCESS;
 	test->status_comment[0] = '\0';
 }
-- 
2.30.2

