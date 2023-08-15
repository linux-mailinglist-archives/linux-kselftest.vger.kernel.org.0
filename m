Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6402177D38D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 21:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjHOTqf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 15:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbjHOTqY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 15:46:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F79C10C1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 12:46:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c583f885cso12841137b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692128783; x=1692733583;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XcSNYdbUd1AhRFi9pMN5EdJQjbktUS+uwajttagvnVk=;
        b=sh9L8oBg7uhZs3hWPB4hvZTovLDjYtOeg4nrZR8ZrYLVXZEUOLrYqsdphD7G2bQvnH
         pIk81/An66xCoVzfZMgdX6xo4NBsvdZeQMtHiDK448BlB3vzZoShyQAlA3QqBjYJ2yhR
         HGY4yRw0ThgjTntCibnAzAIK+q8i4ZCBXX+fONQ0jI1FHkQPMM3HUBBB9+kKQqrGvQJA
         qFEZ1AZh5rM8hxkdnijiFhuP6VYKjqZ/MORSrPgfoI0PO1l+BB9UA89b5mMSEBz7fL7w
         86CwzoWl6yZSTSLYFeIeN7luehFYvRk9LXv21wcmtY+RupXJocdh0pYdGZp30Ojyoswx
         /slA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128783; x=1692733583;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XcSNYdbUd1AhRFi9pMN5EdJQjbktUS+uwajttagvnVk=;
        b=ExzGes+/PSOn9r+mR7k0MlZO77mWAGNYOwLMAbN4Pfy0gxZ4Ts3PJtom1t8J3epcT3
         /MUnlYdajOIddqXdL43F40jreWSQ6YelWlMDb+xL878bXcGZjAbtVd5irJCIAS4L6Uh+
         SvKq5ZrxDgwJm4tnyfYPRXbBZiKmBV6NHgXajL7KnweWLglKmYEMG2PnYnorBPFgwVhT
         oodK+YuNQPfEj3W9cmdPiYUHZ3+wjdz5Wu8YWJCa/DHz4hUtBIlRaX4saXuvEjvMuKRi
         v7AA7AB7Fb27FE02fws+opCCXL4MDrCiysCEGKLwZ7LvR19SO0X33Rl0kAs16Q3zZxsx
         gtzw==
X-Gm-Message-State: AOJu0YydTnfPy9OD7j9HcOWh48DU5ldhwxAtZitooZRGzERJ8V3M5BAo
        A/irlLMS60NFRkxLCH4u5/Sy5vjawQ==
X-Google-Smtp-Source: AGHT+IEG47PIIAqQ69ooJE9qpICC1Gi70TGJIYklRgXMR4NBqCjrONMM3zPjLBPzTYjSMeIW1AcPvbUEJA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:ac65:0:b0:55d:d5b1:c2bd with SMTP id
 z37-20020a81ac65000000b0055dd5b1c2bdmr182988ywj.8.1692128782840; Tue, 15 Aug
 2023 12:46:22 -0700 (PDT)
Date:   Tue, 15 Aug 2023 19:45:40 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815194541.497115-1-rmoar@google.com>
Subject: [PATCH 1/2] kunit: add ability to run tests after boot using debugfs
From:   Rae Moar <rmoar@google.com>
To:     brendan.higgins@linux.dev, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
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

Interested in what people think of this idea. I will be adding
documentation in v2.

Note this may need to be changed once the patches on extending logs
land.

Thanks!
-Rae

 lib/kunit/debugfs.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c    | 13 +++++++++
 2 files changed, 79 insertions(+)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 22c5c496a68f..7f76cb909a97 100644
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
 
@@ -93,6 +97,51 @@ static int debugfs_results_open(struct inode *inode, struct file *file)
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
@@ -100,10 +149,23 @@ static const struct file_operations debugfs_results_fops = {
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
+		suite->log[0] = '\0';
+		return;
+	}
 	/* Allocate logs before creating debugfs representation. */
 	suite->log = kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
 	kunit_suite_for_each_test_case(suite, test_case)
@@ -114,6 +176,10 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
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
index 49698a168437..5058a72d9e8a 100644
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
@@ -702,6 +705,11 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 		return 0;
 	}
 
+	/* Use mutex lock to guard against running tests concurrently. */
+	if (mutex_lock_interruptible(&kunit_run_lock)) {
+		pr_err("kunit: test interrupted\n");
+		return -EINTR;
+	}
 	static_branch_inc(&kunit_running);
 
 	for (i = 0; i < num_suites; i++) {
@@ -710,6 +718,7 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 	}
 
 	static_branch_dec(&kunit_running);
+	mutex_unlock(&kunit_run_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
@@ -869,6 +878,10 @@ static int __init kunit_init(void)
 	kunit_install_hooks();
 
 	kunit_debugfs_init();
+
+	/* Initialize lock to guard against running tests concurrently. */
+	mutex_init(&kunit_run_lock);
+
 #ifdef CONFIG_MODULES
 	return register_module_notifier(&kunit_mod_nb);
 #else

base-commit: 582eb3aeed2d06b122fba95518b84506d3d4ceb9
-- 
2.41.0.694.ge786442a9b-goog

