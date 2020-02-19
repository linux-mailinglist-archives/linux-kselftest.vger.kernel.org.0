Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4DA1649C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 17:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgBSQRx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 11:17:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51004 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgBSQRw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 11:17:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JGDILc100092;
        Wed, 19 Feb 2020 16:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=KUMy13JjOb/6lJJ51B67bhnT295mRh5uD5MDaBaeIx8=;
 b=vX9tiWgviAAhBe2w6AWO5pHGAPju7EgEFNfqjTxmIunpyQTu5pzIV0Qj53Ior9wR9C3x
 n1KDaq8IqeBWdeTJBJ2zzCav6526N42qKbbnR/5qP1sDCi1a9qKcTSlkWUdNxQwINhV5
 ivRtfnRgCgtCV0idvxb/SFcfnF6/+hCiRmCeLiVfqlexMSSdhdc6m4dBMg/6OvAePYiQ
 YVccDL3q6YHECfmcmfLSYUIRK5Q2nh1uwhN8yuG6NuSQJ0I8m1ZcpxKh5m87MBjIZLkK
 uWDkLM79AFDUZxT2F5T7MTVzr+8yDS2NyR37tmOrGL8MVMJvXY/L4zG8HkMe7TW0fzxp xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2y8udkc6ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 16:17:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JGHbGX174248;
        Wed, 19 Feb 2020 16:17:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2y8ud1ft8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 16:17:43 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01JGHeJ1008160;
        Wed, 19 Feb 2020 16:17:40 GMT
Received: from dhcp-10-175-189-86.vpn.oracle.com (/10.175.189.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 08:17:39 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 kunit-next 1/4] kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display
Date:   Wed, 19 Feb 2020 16:17:07 +0000
Message-Id: <1582129030-22282-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582129030-22282-1-git-send-email-alan.maguire@oracle.com>
References: <1582129030-22282-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=11 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=11
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190122
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

add debugfs support for displaying kunit test suite results; this is
especially useful for module-loaded tests to allow disentangling of
test result display from other dmesg events.  debugfs support is
provided if CONFIG_KUNIT_DEBUGFS=y.

As well as printk()ing messages, we append them to a per-test log.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h   |  54 ++++++++++++++++++----
 lib/kunit/Kconfig      |   8 ++++
 lib/kunit/Makefile     |   4 ++
 lib/kunit/debugfs.c    | 116 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/debugfs.h    |  30 ++++++++++++
 lib/kunit/kunit-test.c |   4 +-
 lib/kunit/test.c       | 122 ++++++++++++++++++++++++++++++++++++-------------
 7 files changed, 297 insertions(+), 41 deletions(-)
 create mode 100644 lib/kunit/debugfs.c
 create mode 100644 lib/kunit/debugfs.h

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 2dfb550..7ce5125 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -81,6 +81,9 @@ struct kunit_resource {
 
 struct kunit;
 
+/* Size of log associated with test. */
+#define KUNIT_LOG_SIZE	512
+
 /**
  * struct kunit_case - represents an individual test case.
  *
@@ -123,8 +126,14 @@ struct kunit_case {
 
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
@@ -157,6 +166,10 @@ struct kunit_suite {
 	int (*init)(struct kunit *test);
 	void (*exit)(struct kunit *test);
 	struct kunit_case *test_cases;
+
+	/* private - internal use only */
+	struct dentry *debugfs;
+	char *log;
 };
 
 /**
@@ -175,6 +188,7 @@ struct kunit {
 
 	/* private: internal use only. */
 	const char *name; /* Read only after initialization! */
+	char *log; /* Points at case log after initialization */
 	struct kunit_try_catch try_catch;
 	/*
 	 * success starts as true, and may only be set to false during a
@@ -193,10 +207,19 @@ struct kunit {
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
@@ -226,20 +249,22 @@ struct kunit {
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
@@ -356,8 +381,21 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
 
 void kunit_cleanup(struct kunit *test);
 
-#define kunit_printk(lvl, test, fmt, ...) \
-	printk(lvl "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
+/*
+ * printk and log to per-test or per-suite log buffer.  Logging only done
+ * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/used.
+ */
+#define kunit_log(lvl, test_or_suite, fmt, ...)				\
+	do {								\
+		printk(lvl fmt, ##__VA_ARGS__);				\
+		if ((test_or_suite)->log)				\
+			snprintf((test_or_suite)->log, KUNIT_LOG_SIZE,	\
+				 "%s" fmt "\n",				\
+				 (test_or_suite)->log, ##__VA_ARGS__);	\
+	} while (0)
+
+#define kunit_printk(lvl, test, fmt, ...)				\
+	kunit_log(lvl, test, "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
 
 /**
  * kunit_info() - Prints an INFO level message associated with @test.
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 065aa16..95d12e3 100644
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
index fab5564..724b943 100644
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
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
new file mode 100644
index 0000000..9214c49
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
index 0000000..dcc7d75
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
index ccb8d2e..aceb5bf 100644
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
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 9242f93..c0f65b9 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/sched/debug.h>
 
+#include "debugfs.h"
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
@@ -28,73 +29,91 @@ static void kunit_print_tap_version(void)
 	}
 }
 
-static size_t kunit_test_cases_len(struct kunit_case *test_cases)
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
+	kunit_log(KERN_INFO, suite, "# Subtest: %s", suite->name);
+	kunit_log(KERN_INFO, suite, "1..%zd",
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
+	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
+	struct kunit *test = is_test ? test_or_suite : NULL;
 
-	if (should_indent)
-		indent = "\t";
-	else
-		indent = "";
-
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
+		kunit_log(KERN_INFO, test, "\t%s %zd - %s",
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
@@ -102,6 +121,9 @@ static void kunit_print_string_stream(struct kunit *test,
 	struct string_stream_fragment *fragment;
 	char *buf;
 
+	if (string_stream_is_empty(stream))
+		return;
+
 	buf = string_stream_get_string(stream);
 	if (!buf) {
 		kunit_err(test,
@@ -175,11 +197,14 @@ void kunit_do_assertion(struct kunit *test,
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
@@ -290,7 +315,7 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	struct kunit_try_catch *try_catch;
 	struct kunit test;
 
-	kunit_init_test(&test, test_case->name);
+	kunit_init_test(&test, test_case->name, test_case->log);
 	try_catch = &test.try_catch;
 
 	kunit_try_catch_init(try_catch,
@@ -303,19 +328,20 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
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
 
@@ -323,6 +349,37 @@ int kunit_run_tests(struct kunit_suite *suite)
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
@@ -489,12 +546,15 @@ void kunit_cleanup(struct kunit *test)
 
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
 
-- 
1.8.3.1

