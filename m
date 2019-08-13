Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10FA88AF6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfHMGLg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:11:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60092 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfHMGLf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:11:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68wPH010973;
        Tue, 13 Aug 2019 06:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=pxWQMkeXEo6VK4H0xnGRztYzh1TzSktDwlYf6T9k180=;
 b=kgiwVKgPjPDCglibAMRFBnvyiQK3Q4CLKUGpGS/t+UUoombTyEKmaSlicV9y40Nk/gVK
 deAVKRl55c4l6FKW15TWhNfS6XGl3m1Q3taJHr/bzbh8n4qbwOgULIkO5oGrwkkBKORS
 NYRQm62C4BOcJZu00baRgZNpMnJRgdR6/yNJkToMXgtVFhLvEEuPl29BLhmXrjKvEqGj
 7trPciy6yqU9mizDXrM1fVgPCAsXK56VAY0dEubzfNdqWNaSxMdIn003bnlJWv/DmCBp
 gXPB6+LPyNfJoDg6GC3HXNPoNBrtZW3u64V32lhqFa66AbABesBmU993BR26cP43CYgH Vw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=pxWQMkeXEo6VK4H0xnGRztYzh1TzSktDwlYf6T9k180=;
 b=1RfCiHk2eZTGIi7RCgPiHW4m5uUwcs0myIWjsNnlWqxacHVFmQ+JqwcFvdu1nPnLZaQh
 9U5hSVYuwPMr/SdxzVynnxQZHgVjyHc4D3cI+DvkjNL+04+XkteABuAblsCpAKqAlX0W
 GoxFTZtwQecm+PRgfif0KrXD8ALt1qTnCpYsYD40/6xLzNVQiajB4tDNNyvh7MEpjepJ
 vN9cmpVK7115D5H006GBN3rWcW78nz8ZoBYcRKL2qw28Ar7tZ0SDPwT0ilEW8dBW5GNW
 mEGeRa8KhYuDSD8XwQy7GQK7Er9C4UrzvjpF7zgTCekJZhNlCpq5pcpaNRE9ULNb2FEZ Dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u9nbtc0vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68TeZ056702;
        Tue, 13 Aug 2019 06:11:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2u9n9hs2cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:15 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7D6BEPf013396;
        Tue, 13 Aug 2019 06:11:14 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:13 -0700
From:   Knut Omang <knut.omang@oracle.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: [RFC 06/19] ktf: A simple debugfs interface to test results
Date:   Tue, 13 Aug 2019 08:09:21 +0200
Message-Id: <ae6c38384e2338aa3cfb8a4e4dd1002833789253.1565676440.git-series.knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130067
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Alan Maguire <alan.maguire@oracle.com>

While test results is available via netlink from user space, sometimes
it may be useful to be able to access the results from the kernel as well,
for instance due to a crash. Make that possible via debugfs.

ktf_debugfs.h:   Support for creating a debugfs representation of test

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/kernel/ktf_debugfs.c | 356 ++++++++++++++++-
 tools/testing/selftests/ktf/kernel/ktf_debugfs.h |  34 ++-
 2 files changed, 390 insertions(+)
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_debugfs.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_debugfs.h

diff --git a/tools/testing/selftests/ktf/kernel/ktf_debugfs.c b/tools/testing/selftests/ktf/kernel/ktf_debugfs.c
new file mode 100644
index 0000000..a20fbd2
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_debugfs.c
@@ -0,0 +1,356 @@
+/*
+ * Copyright (c) 2009, 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Alan Maguire <alan.maguire@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ */
+#include <asm/unistd.h>
+#include <linux/module.h>
+#include <linux/time.h>
+#include "ktf_debugfs.h"
+#include "ktf.h"
+#include "ktf_test.h"
+#include "ktf_cov.h"
+
+/* Create a debugfs representation of test sets/tests.  Hierarchy looks like
+ * this:
+ *
+ * Path					Semantics
+ * /sys/kernel/debug/ktf/run/<testset>		Run all tests in testset
+ * /sys/kernel/debug/ktf/run/<testset>/<test>	Run specific test in testset
+ * /sys/kernel/debug/ktf/results/<testset>	Show results of last run for
+ *						testset
+ *
+ * /sys/kernel/debug/ktf/results/<testset>/<test>
+ *						Show results of last run for
+ *						test
+ *
+ */
+
+static struct dentry *ktf_debugfs_rootdir;
+static struct dentry *ktf_debugfs_rundir;
+static struct dentry *ktf_debugfs_resultsdir;
+static struct dentry *ktf_debugfs_cov_file;
+
+static void ktf_debugfs_print_result(struct seq_file *seq, struct ktf_test *t)
+{
+	struct timespec now;
+
+	if (t && strlen(t->log) > 0) {
+		getnstimeofday(&now);
+		seq_printf(seq, "[%s/%s, %ld seconds ago] %s\n",
+			   t->tclass, t->name,
+			   now.tv_sec - t->lastrun.tv_sec, t->log);
+	}
+}
+
+/* /sys/kernel/debug/ktf/results/<testset>-tests/<test> shows specific result */
+static int ktf_debugfs_result(struct seq_file *seq, void *v)
+{
+	struct ktf_test *t = (struct ktf_test *)seq->private;
+
+	ktf_debugfs_print_result(seq, t);
+
+	return 0;
+}
+
+/* /sys/kernel/debug/ktf/results/<testset> shows all results for testset. */
+static int ktf_debugfs_results_all(struct seq_file *seq, void *v)
+{
+	struct ktf_case *testset = (struct ktf_case *)seq->private;
+	struct ktf_test *t;
+
+	if (!testset)
+		return 0;
+
+	seq_printf(seq, "%s results:\n", ktf_case_name(testset));
+	ktf_testcase_for_each_test(t, testset)
+		ktf_debugfs_print_result(seq, t);
+
+	return 0;
+}
+
+/* /sys/kernel/debug/ktf/run/<testset>-tests/<test> runs specific test. */
+static int ktf_debugfs_run(struct seq_file *seq, void *v)
+{
+	struct ktf_test *t = (struct ktf_test *)seq->private;
+
+	if (!t)
+		return 0;
+
+	ktf_run_hook(NULL, NULL, t, 0, NULL, 0);
+	ktf_debugfs_print_result(seq, t);
+
+	return 0;
+}
+
+/* /sys/kernel/debug/ktf/run/<testset> runs all tests in testset. */
+static int ktf_debugfs_run_all(struct seq_file *seq, void *v)
+{
+	struct ktf_case *testset = (struct ktf_case *)seq->private;
+	struct ktf_test *t;
+
+	if (!testset)
+		return 0;
+
+	seq_printf(seq, "Running %s\n", ktf_case_name(testset));
+	ktf_testcase_for_each_test(t, testset) {
+		ktf_run_hook(NULL, NULL, t, 0, NULL, 0);
+		ktf_debugfs_print_result(seq, t);
+	}
+
+	return 0;
+}
+
+static int ktf_run_test_open(struct inode *inode, struct file *file)
+{
+	struct ktf_test *t;
+
+	if (!try_module_get(THIS_MODULE))
+		return -EIO;
+
+	t = (struct ktf_test *)inode->i_private;
+
+	return single_open(file, ktf_debugfs_run, t);
+}
+
+static int ktf_debugfs_release(struct inode *inode, struct file *file)
+{
+	module_put(THIS_MODULE);
+	return single_release(inode, file);
+}
+
+static const struct file_operations ktf_run_test_fops = {
+	.open = ktf_run_test_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = ktf_debugfs_release,
+};
+
+static int ktf_results_test_open(struct inode *inode, struct file *file)
+{
+	struct ktf_test *t;
+
+	if (!try_module_get(THIS_MODULE))
+		return -EIO;
+
+	t = (struct ktf_test *)inode->i_private;
+
+	return single_open(file, ktf_debugfs_result, t);
+}
+
+static const struct file_operations ktf_results_test_fops = {
+	.open = ktf_results_test_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = ktf_debugfs_release,
+};
+
+static void _ktf_debugfs_destroy_test(struct ktf_test *t)
+{
+	if (!t)
+		return;
+
+	tlog(T_DEBUG, "Destroying debugfs test %s", t->name);
+	debugfs_remove(t->debugfs.debugfs_results_test);
+	debugfs_remove(t->debugfs.debugfs_run_test);
+	memset(&t->debugfs, 0, sizeof(t->debugfs));
+}
+
+void ktf_debugfs_create_test(struct ktf_test *t)
+{
+	struct ktf_case *testset = ktf_case_find(t->tclass);
+
+	if (!testset)
+		return;
+
+	memset(&t->debugfs, 0, sizeof(t->debugfs));
+
+	t->debugfs.debugfs_results_test =
+		debugfs_create_file(t->name, S_IFREG | 0444,
+				    testset->debugfs.debugfs_results_test,
+				 t, &ktf_results_test_fops);
+
+	if (t->debugfs.debugfs_results_test) {
+		t->debugfs.debugfs_run_test =
+			debugfs_create_file(t->name, S_IFREG | 0444,
+					    testset->debugfs.debugfs_run_test,
+				 t, &ktf_run_test_fops);
+		if (!t->debugfs.debugfs_run_test) {
+			_ktf_debugfs_destroy_test(t);
+		} else {
+			/* Take reference for test for debugfs */
+			ktf_test_get(t);
+		}
+	}
+	/* Drop reference to testset from ktf_case_find(). */
+	ktf_case_put(testset);
+}
+
+void ktf_debugfs_destroy_test(struct ktf_test *t)
+{
+	_ktf_debugfs_destroy_test(t);
+	/* Release reference now debugfs files are gone. */
+	ktf_test_put(t);
+}
+
+static int ktf_results_testset_open(struct inode *inode, struct file *file)
+{
+	struct ktf_case *testset;
+
+	if (!try_module_get(THIS_MODULE))
+		return -EIO;
+
+	testset = (struct ktf_case *)inode->i_private;
+
+	return single_open(file, ktf_debugfs_results_all, testset);
+}
+
+static const struct file_operations ktf_results_testset_fops = {
+	.open = ktf_results_testset_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = ktf_debugfs_release,
+};
+
+static int ktf_run_testset_open(struct inode *inode, struct file *file)
+{
+	struct ktf_case *testset;
+
+	if (!try_module_get(THIS_MODULE))
+		return -EIO;
+
+	testset = (struct ktf_case *)inode->i_private;
+
+	return single_open(file, ktf_debugfs_run_all, testset);
+}
+
+static const struct file_operations ktf_run_testset_fops = {
+	.open = ktf_run_testset_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = ktf_debugfs_release,
+};
+
+static void _ktf_debugfs_destroy_testset(struct ktf_case *testset)
+{
+	debugfs_remove(testset->debugfs.debugfs_run_testset);
+	debugfs_remove(testset->debugfs.debugfs_run_test);
+	debugfs_remove(testset->debugfs.debugfs_results_testset);
+	debugfs_remove(testset->debugfs.debugfs_results_test);
+}
+
+void ktf_debugfs_create_testset(struct ktf_case *testset)
+{
+	char tests_subdir[KTF_DEBUGFS_NAMESZ];
+	const char *name = ktf_case_name(testset);
+
+	memset(&testset->debugfs, 0, sizeof(testset->debugfs));
+
+	/* First add /sys/kernel/debug/ktf/[results|run]/<testset> */
+	testset->debugfs.debugfs_results_testset =
+		debugfs_create_file(name, S_IFREG | 0444,
+				    ktf_debugfs_resultsdir,
+				 testset, &ktf_results_testset_fops);
+	if (!testset->debugfs.debugfs_results_testset)
+		goto err;
+
+	testset->debugfs.debugfs_run_testset =
+		debugfs_create_file(name, S_IFREG | 0444,
+				    ktf_debugfs_rundir,
+				    testset, &ktf_run_testset_fops);
+	if (!testset->debugfs.debugfs_run_testset)
+		goto err;
+
+	/* Now add parent directories for individual test result/run tests
+	 * which live in
+	 * /sys/kernel/debug/ktf/[results|run]/<testset>-tests/<testname>
+	 */
+	(void)snprintf(tests_subdir, sizeof(tests_subdir), "%s%s",
+			name, KTF_DEBUGFS_TESTS_SUFFIX);
+
+	testset->debugfs.debugfs_results_test =
+		debugfs_create_dir(tests_subdir, ktf_debugfs_resultsdir);
+	if (!testset->debugfs.debugfs_results_test)
+		goto err;
+
+	testset->debugfs.debugfs_run_test =
+		debugfs_create_dir(tests_subdir, ktf_debugfs_rundir);
+	if (!testset->debugfs.debugfs_run_test)
+		goto err;
+
+	/* Take reference count for testset.  One will do as we will always
+	 * free testset debugfs resources together.
+	 */
+	ktf_case_get(testset);
+	return;
+err:
+	_ktf_debugfs_destroy_testset(testset);
+}
+
+void ktf_debugfs_destroy_testset(struct ktf_case *testset)
+{
+	tlog(T_DEBUG, "Destroying debugfs testset %s", ktf_case_name(testset));
+	_ktf_debugfs_destroy_testset(testset);
+	/* Remove our debugfs reference cout to testset */
+	ktf_case_put(testset);
+}
+
+/* /sys/kernel/debug/ktf/coverage shows coverage statistics. */
+static int ktf_debugfs_cov(struct seq_file *seq, void *v)
+{
+	ktf_cov_seq_print(seq);
+
+	return 0;
+}
+
+static int ktf_cov_open(struct inode *inode, struct file *file)
+{
+	if (!try_module_get(THIS_MODULE))
+		return -EIO;
+
+	return single_open(file, ktf_debugfs_cov, NULL);
+}
+
+static const struct file_operations ktf_cov_fops = {
+	.open = ktf_cov_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = ktf_debugfs_release,
+};
+
+void ktf_debugfs_cleanup(void)
+{
+	tlog(T_DEBUG, "Removing ktf debugfs dirs...");
+	debugfs_remove(ktf_debugfs_cov_file);
+	debugfs_remove(ktf_debugfs_rundir);
+	debugfs_remove(ktf_debugfs_resultsdir);
+	debugfs_remove(ktf_debugfs_rootdir);
+}
+
+void ktf_debugfs_init(void)
+{
+	ktf_debugfs_rootdir = debugfs_create_dir(KTF_DEBUGFS_ROOT, NULL);
+	if (!ktf_debugfs_rootdir)
+		goto err;
+	ktf_debugfs_rundir = debugfs_create_dir(KTF_DEBUGFS_RUN,
+						ktf_debugfs_rootdir);
+	if (!ktf_debugfs_rundir)
+		goto err;
+	ktf_debugfs_resultsdir = debugfs_create_dir(KTF_DEBUGFS_RESULTS,
+						    ktf_debugfs_rootdir);
+	if (!ktf_debugfs_resultsdir)
+		goto err;
+
+	ktf_debugfs_cov_file = debugfs_create_file(KTF_DEBUGFS_COV,
+						   S_IFREG | 0444,
+						   ktf_debugfs_rootdir,
+						   NULL,
+						   &ktf_cov_fops);
+	if (ktf_debugfs_cov_file)
+		return;
+err:
+	terr("Could not init %s\n", KTF_DEBUGFS_ROOT);
+	ktf_debugfs_cleanup();
+}
diff --git a/tools/testing/selftests/ktf/kernel/ktf_debugfs.h b/tools/testing/selftests/ktf/kernel/ktf_debugfs.h
new file mode 100644
index 0000000..4dab1ea
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_debugfs.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2009, 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Alan Maguire <alan.maguire@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_debugfs.h: Support for creating a debugfs representation of test
+ * sets/tests.
+ */
+
+#ifndef KTF_DEBUGFS_H
+#define KTF_DEBUGFS_H
+#include <linux/debugfs.h>
+
+#define KTF_DEBUGFS_ROOT                        "ktf"
+#define KTF_DEBUGFS_RUN                         "run"
+#define KTF_DEBUGFS_RESULTS                     "results"
+#define KTF_DEBUGFS_COV				"coverage"
+#define KTF_DEBUGFS_TESTS_SUFFIX                "-tests"
+
+#define KTF_DEBUGFS_NAMESZ                      256
+
+struct ktf_test;
+struct ktf_case;
+
+void ktf_debugfs_create_test(struct ktf_test *);
+void ktf_debugfs_destroy_test(struct ktf_test *);
+void ktf_debugfs_create_testset(struct ktf_case *);
+void ktf_debugfs_destroy_testset(struct ktf_case *);
+void ktf_debugfs_init(void);
+void ktf_debugfs_cleanup(void);
+
+
+#endif
-- 
git-series 0.9.1
