Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E297147109
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 19:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAWSrZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 13:47:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48862 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgAWSrX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 13:47:23 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NINnTF142585;
        Thu, 23 Jan 2020 18:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=aYr1nhx6hnpX/O9gguMhhD0wt2UAM6w7uZ7asmBRcvc=;
 b=ky/vmK6uzdHJvrfvbGN7TxAzcJAr/cAYrrxRoSOmkGjNf8I3M4gDlBTp75Qzz45puPyC
 mLHBxJsGIqm1gYxlWrA4svYrhTIPwBkvVtm0suuVkXZX/O0XbrF1MKJKxKAwkAW9EHPA
 SslMmPIjPQ0G2m5KXWUTdp4bsIAjHhDVxtBZHtdpnm86vEgD495QA2I4YGpGJIx8MC5A
 kKy8eBa+d/sKrzM4MuT22XAI2UYlJqaPjKJMQPwho+kvUlTAFXQb1sNSHdRrY0E7m9CQ
 X3vaSfhF2Qnmx+P4byPgxRHA8WOUttMif8lRbT32oMRFTPPKcL2TnPPHQoPdx7dAKPdG mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xkseuvdjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 18:47:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NINbCI163476;
        Thu, 23 Jan 2020 18:47:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xpq0x4fah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 18:47:17 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00NIlHvw016248;
        Thu, 23 Jan 2020 18:47:17 GMT
Received: from dhcp-10-175-166-237.vpn.oracle.com (/10.175.166.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 10:47:17 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 kunit-next 1/3] kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display
Date:   Thu, 23 Jan 2020 18:46:59 +0000
Message-Id: <1579805221-31905-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579805221-31905-1-git-send-email-alan.maguire@oracle.com>
References: <1579805221-31905-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230141
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

add debugfs support for displaying kunit test suite results; this is
especially useful for module-loaded tests to allow disentangling of
test result display from other dmesg events.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/kunit/test.h |  21 ++++++++---
 lib/kunit/Makefile   |   3 +-
 lib/kunit/debugfs.c  | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/debugfs.h  |  16 ++++++++
 lib/kunit/test.c     |  85 ++++++++++++++++++++++++++++++-----------
 5 files changed, 202 insertions(+), 27 deletions(-)
 create mode 100644 lib/kunit/debugfs.c
 create mode 100644 lib/kunit/debugfs.h

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 2dfb550..37219b8a 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -125,6 +125,8 @@ struct kunit_case {
 	bool success;
 };
 
+#define	kunit_status2str(status)	(status ? "ok" : "not ok")
+
 /**
  * KUNIT_CASE - A helper for creating a &struct kunit_case
  *
@@ -157,6 +159,9 @@ struct kunit_suite {
 	int (*init)(struct kunit *test);
 	void (*exit)(struct kunit *test);
 	struct kunit_case *test_cases;
+
+	/* private - internal use only */
+	struct dentry *debugfs;
 };
 
 /**
@@ -197,6 +202,15 @@ struct kunit {
 
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
@@ -226,15 +240,12 @@ struct kunit {
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
 
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index fab5564..869aab0 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -3,7 +3,8 @@ obj-$(CONFIG_KUNIT) +=			kunit.o
 kunit-objs +=				test.o \
 					string-stream.o \
 					assert.o \
-					try-catch.o
+					try-catch.o \
+					debugfs.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
new file mode 100644
index 0000000..578843c
--- /dev/null
+++ b/lib/kunit/debugfs.c
@@ -0,0 +1,104 @@
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
+	if (!test_case)
+		return;
+
+	seq_printf(seq, "\t%s %d - %s\n", kunit_status2str(test_case->success),
+		   kunit_test_case_num(suite, test_case), test_case->name);
+}
+
+/*
+ * /sys/kernel/debug/kunit/<testsuite>/results shows all results for testsuite.
+ */
+static int debugfs_print_results(struct seq_file *seq, void *v)
+{
+	struct kunit_suite *suite = (struct kunit_suite *)seq->private;
+	struct kunit_case *test_case;
+
+	if (!suite)
+		return 0;
+
+	seq_printf(seq, "\t# Subtest: %s\n", suite->name);
+	seq_printf(seq, "\t1..%zd\n", kunit_suite_num_test_cases(suite));
+
+	for (test_case = suite->test_cases; test_case->run_case; test_case++)
+		debugfs_print_result(seq, suite, test_case);
+
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
+	/* First add /sys/kernel/debug/kunit/<testsuite> */
+	suite->debugfs = debugfs_create_dir(suite->name, debugfs_rootdir);
+
+	debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
+			    suite->debugfs,
+			    suite, &debugfs_results_fops);
+}
+
+void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
+{
+	debugfs_remove_recursive(suite->debugfs);
+}
diff --git a/lib/kunit/debugfs.h b/lib/kunit/debugfs.h
new file mode 100644
index 0000000..9a92d5e
--- /dev/null
+++ b/lib/kunit/debugfs.h
@@ -0,0 +1,16 @@
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
+void kunit_debugfs_create_suite(struct kunit_suite *suite);
+void kunit_debugfs_destroy_suite(struct kunit_suite *suite);
+void kunit_debugfs_init(void);
+void kunit_debugfs_cleanup(void);
+
+#endif /* _KUNIT_DEBUGFS_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 9242f93..07089ca 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/sched/debug.h>
 
+#include "debugfs.h"
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
@@ -28,22 +29,24 @@ static void kunit_print_tap_version(void)
 	}
 }
 
-static size_t kunit_test_cases_len(struct kunit_case *test_cases)
+size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
 {
-	struct kunit_case *test_case;
+	struct kunit_case *test_case, *test_cases = suite->test_cases;
 	size_t len = 0;
 
-	for (test_case = test_cases; test_case->run_case; test_case++)
+	for (test_case = test_cases; test_case && test_case->run_case;
+	     test_case++)
 		len++;
 
 	return len;
 }
+EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
 
 static void kunit_print_subtest_start(struct kunit_suite *suite)
 {
 	kunit_print_tap_version();
 	pr_info("\t# Subtest: %s\n", suite->name);
-	pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
+	pr_info("\t1..%zd\n", kunit_suite_num_test_cases(suite));
 }
 
 static void kunit_print_ok_not_ok(bool should_indent,
@@ -51,19 +54,15 @@ static void kunit_print_ok_not_ok(bool should_indent,
 				  size_t test_number,
 				  const char *description)
 {
-	const char *indent, *ok_not_ok;
+	const char *indent;
 
 	if (should_indent)
 		indent = "\t";
 	else
 		indent = "";
 
-	if (is_ok)
-		ok_not_ok = "ok";
-	else
-		ok_not_ok = "not ok";
-
-	pr_info("%s%s %zd - %s\n", indent, ok_not_ok, test_number, description);
+	pr_info("%s%s %zd - %s\n", indent, kunit_status2str(is_ok),
+		test_number, description);
 }
 
 static bool kunit_suite_has_succeeded(struct kunit_suite *suite)
@@ -87,14 +86,20 @@ static void kunit_print_subtest_end(struct kunit_suite *suite)
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
+	unsigned int i;
+
+	for (i = 1, tc = suite->test_cases; tc->run_case; tc++, i++) {
+		if (tc == test_case)
+			return i;
+	}
+
+	return 0;
 }
+EXPORT_SYMBOL_GPL(kunit_test_case_num);
 
 static void kunit_print_string_stream(struct kunit *test,
 				      struct string_stream *stream)
@@ -102,6 +107,9 @@ static void kunit_print_string_stream(struct kunit *test,
 	struct string_stream_fragment *fragment;
 	char *buf;
 
+	if (string_stream_is_empty(stream))
+		return;
+
 	buf = string_stream_get_string(stream);
 	if (!buf) {
 		kunit_err(test,
@@ -303,19 +311,20 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	kunit_try_catch_run(try_catch, &context);
 
 	test_case->success = test.success;
+
+	kunit_print_ok_not_ok(true, test_case->success,
+			      kunit_test_case_num(suite, test_case),
+			      test_case->name);
 }
 
 int kunit_run_tests(struct kunit_suite *suite)
 {
 	struct kunit_case *test_case;
-	size_t test_case_count = 1;
 
 	kunit_print_subtest_start(suite);
 
-	for (test_case = suite->test_cases; test_case->run_case; test_case++) {
+	for (test_case = suite->test_cases; test_case->run_case; test_case++)
 		kunit_run_case_catch_errors(suite, test_case);
-		kunit_print_test_case_ok_not_ok(test_case, test_case_count++);
-	}
 
 	kunit_print_subtest_end(suite);
 
@@ -323,6 +332,37 @@ int kunit_run_tests(struct kunit_suite *suite)
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
@@ -489,12 +529,15 @@ void kunit_cleanup(struct kunit *test)
 
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

