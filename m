Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67E7799183
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 23:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbjIHVcD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 17:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjIHVcC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 17:32:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770CDDC
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 14:31:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fc7afa4beso29402237b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694208717; x=1694813517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R7b9OwuJv//o+ELCx6dXPif0Xt9fI41k+DjaD06EUhk=;
        b=g7h0pQqLgkTyJOB05DFW8IDpmoUm2gdMjuWU7ITFm0Z0rkLJnr/7TyJx6BorHGOFqJ
         +M7Dg2SLb0vbIyUCGoZ+JQbE52JJUufc9ZOfoaNf9d6uzEzBqEUq8xrICsCUWLsINtu+
         /v7mEpVR/REz/q2W9+UuOfscHmMXgreT1eD8Ssq0lNk4KKyXN6AzOnb0LQBr9xRw7U3W
         X6lpl2rpl9UtX807K8KGmvZIh1IzS7Ch18THaplOx2BBGQhMzJAaXqoI+LhLaph7WUuz
         CgUvVTYh5TAFN4zmWQKIBMPu1G5jntSx1FNoL7BFRdWm3HvnizO+nvyGCPl4lVhel6Dw
         6NwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694208717; x=1694813517;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7b9OwuJv//o+ELCx6dXPif0Xt9fI41k+DjaD06EUhk=;
        b=oN+HQ5aFIfyGp2GAy57DC+ot45TEOL7EGoQuFw+DdOh7sFgFKJNfSZZmYqwgLdjHNw
         eXJ3nwePU4W5wlzragOwNsVmkRMB9yIv2mwXuDoiTpPNtQvPMgC+u/YSpbbE4KQkd7Nv
         PqM7qvopxnnR0zy7l0P0fbWYIpWps36OR0NCceatwMTGKnn+qoSl3ioyvA0j5XGb3jCg
         swtA4l3lRXtbZxmfyvRErKM7Qp5YEC43fn/lUlkCkJLMg/VSIDjsN+jQrJk8eWKkB9bo
         +Mmj9Okn8Uh6dCjglFTCUvmgVhESzqTmzD3YQSlHYhZf7sFtKXryx93E3Bq64H//G1KM
         O8bg==
X-Gm-Message-State: AOJu0YzEaj9Jv3vQWMebRFGBJAn39Ho3xV3WxwRFYUBVjHRofw/7OlgM
        bECPZBSemKYVfNp7Z/rN1KTAjGZr1A==
X-Google-Smtp-Source: AGHT+IEw+uv+zm8RDEBGwRxkANylW/q4pnLNxvXTx2e/IAUJA2oImZKkJ8rFY6JBFveIzVpREN4PUp1ToA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:8203:0:b0:d7e:b82a:ef68 with SMTP id
 q3-20020a258203000000b00d7eb82aef68mr78275ybk.3.1694208717716; Fri, 08 Sep
 2023 14:31:57 -0700 (PDT)
Date:   Fri,  8 Sep 2023 21:31:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908213148.3610108-1-rmoar@google.com>
Subject: [PATCH v2 1/2] kunit: add ability to run tests after boot using debugfs
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev, sadiyakazi@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add functionality to run built-in tests after boot by writing to a
debugfs file.

Add a new debugfs file labeled "run" for each test suite to use for
this purpose.

As an example, write to the file using the following:

echo "any string" > /sys/kernel/debugfs/kunit/<testsuite>/run

This will trigger the test suite to run and will print results to the
kernel log.

Note that what you "write" to the debugfs file will not be saved.

To guard against running tests concurrently with this feature, add a
mutex lock around running kunit. This supports the current practice of
not allowing tests to be run concurrently on the same kernel.

This functionality may not work for all tests.

This new functionality could be used to design a parameter
injection feature in the future.

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v1:
- Removed second patch as this problem has been fixed
- Added Documentation patch
- Made changes to work with new dynamically-extending log feature

Note that these patches now rely on (and are rebased on) the patch series:
https://lore.kernel.org/all/20230828104111.2394344-1-rf@opensource.cirrus.com/

 lib/kunit/debugfs.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c    | 13 +++++++++
 2 files changed, 79 insertions(+)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 270d185737e6..8c0a970321ce 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -8,12 +8,14 @@
 #include <linux/module.h>
 
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 
 #include "string-stream.h"
 #include "debugfs.h"
 
 #define KUNIT_DEBUGFS_ROOT             "kunit"
 #define KUNIT_DEBUGFS_RESULTS          "results"
+#define KUNIT_DEBUGFS_RUN              "run"
 
 /*
  * Create a debugfs representation of test suites:
@@ -21,6 +23,8 @@
  * Path						Semantics
  * /sys/kernel/debug/kunit/<testsuite>/results	Show results of last run for
  *						testsuite
+ * /sys/kernel/debug/kunit/<testsuite>/run	Write to this file to trigger
+ *						testsuite to run
  *
  */
 
@@ -99,6 +103,51 @@ static int debugfs_results_open(struct inode *inode, struct file *file)
 	return single_open(file, debugfs_print_results, suite);
 }
 
+/*
+ * Print a usage message to the debugfs "run" file
+ * (/sys/kernel/debug/kunit/<testsuite>/run) if opened.
+ */
+static int debugfs_print_run(struct seq_file *seq, void *v)
+{
+	struct kunit_suite *suite = (struct kunit_suite *)seq->private;
+
+	seq_puts(seq, "Write to this file to trigger the test suite to run.\n");
+	seq_printf(seq, "usage: echo \"any string\" > /sys/kernel/debugfs/kunit/%s/run\n",
+			suite->name);
+	return 0;
+}
+
+/*
+ * The debugfs "run" file (/sys/kernel/debug/kunit/<testsuite>/run)
+ * contains no information. Write to the file to trigger the test suite
+ * to run.
+ */
+static int debugfs_run_open(struct inode *inode, struct file *file)
+{
+	struct kunit_suite *suite;
+
+	suite = (struct kunit_suite *)inode->i_private;
+
+	return single_open(file, debugfs_print_run, suite);
+}
+
+/*
+ * Trigger a test suite to run by writing to the suite's "run" debugfs
+ * file found at: /sys/kernel/debug/kunit/<testsuite>/run
+ *
+ * Note: what is written to this file will not be saved.
+ */
+static ssize_t debugfs_run(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct inode *f_inode = file->f_inode;
+	struct kunit_suite *suite = (struct kunit_suite *) f_inode->i_private;
+
+	__kunit_test_suites_init(&suite, 1);
+
+	return count;
+}
+
 static const struct file_operations debugfs_results_fops = {
 	.open = debugfs_results_open,
 	.read = seq_read,
@@ -106,10 +155,23 @@ static const struct file_operations debugfs_results_fops = {
 	.release = debugfs_release,
 };
 
+static const struct file_operations debugfs_run_fops = {
+	.open = debugfs_run_open,
+	.read = seq_read,
+	.write = debugfs_run,
+	.llseek = seq_lseek,
+	.release = debugfs_release,
+};
+
 void kunit_debugfs_create_suite(struct kunit_suite *suite)
 {
 	struct kunit_case *test_case;
 
+	if (suite->log) {
+		/* Clear the suite log that's leftover from a previous run. */
+		string_stream_clear(suite->log);
+		return;
+	}
 	/* Allocate logs before creating debugfs representation. */
 	suite->log = alloc_string_stream(GFP_KERNEL);
 	string_stream_set_append_newlines(suite->log, true);
@@ -124,6 +186,10 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
 	debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
 			    suite->debugfs,
 			    suite, &debugfs_results_fops);
+
+	debugfs_create_file(KUNIT_DEBUGFS_RUN, S_IFREG | 0644,
+			    suite->debugfs,
+			    suite, &debugfs_run_fops);
 }
 
 void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 651cbda9f250..d376b886d72d 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
@@ -22,6 +23,8 @@
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
+static struct mutex kunit_run_lock;
+
 /*
  * Hook to fail the current test and print an error message to the log.
  */
@@ -668,6 +671,11 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 		return 0;
 	}
 
+	/* Use mutex lock to guard against running tests concurrently. */
+	if (mutex_lock_interruptible(&kunit_run_lock)) {
+		pr_err("kunit: test interrupted\n");
+		return -EINTR;
+	}
 	static_branch_inc(&kunit_running);
 
 	for (i = 0; i < num_suites; i++) {
@@ -676,6 +684,7 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 	}
 
 	static_branch_dec(&kunit_running);
+	mutex_unlock(&kunit_run_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
@@ -836,6 +845,10 @@ static int __init kunit_init(void)
 	kunit_install_hooks();
 
 	kunit_debugfs_init();
+
+	/* Initialize lock to guard against running tests concurrently. */
+	mutex_init(&kunit_run_lock);
+
 #ifdef CONFIG_MODULES
 	return register_module_notifier(&kunit_mod_nb);
 #else

base-commit: b754593274e04fc840482a658b29791bc8f8b933
-- 
2.42.0.283.g2d96d420d3-goog

