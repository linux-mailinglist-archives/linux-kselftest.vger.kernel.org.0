Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEBB683902
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 23:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjAaWER (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 17:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjAaWEP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 17:04:15 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5A95AA6D
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 14:04:11 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-51ccd655ed8so29948227b3.18
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 14:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=moADQALSg0tb19IAK6VFXnHmoG36e7OfUG93vqCxfyc=;
        b=ogWowkUFyiShxyTJKM1sRMy0WMSVn9B6vJ/j9Q1ZU9IBIJHls038PG7jyled6Xu8e8
         yn6idyvDB1l1avNxwbYlYNfJmkYAzlvnAANQB3dwXB2qhj73opiaDUkrx1w2Z+IglkGi
         uWUCUVd5QykzNEhJahoLrLihjwTwQsIOyQPn3rYEYa1vwuTkWiFqmTvWcSWMWPHDzCPj
         z+umS6DMaXCJ04fcogS2vWHa6Mau0fcnyNuj0fZCZSahC0BscGxWPz67iG+U3L6VuZSp
         e9pFUSSxgQkDH0/oweIMI89A6i93+W7Yhx/H/IxbfFeI/YaP/gojn1aqq0o34TSlnQ9f
         izUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moADQALSg0tb19IAK6VFXnHmoG36e7OfUG93vqCxfyc=;
        b=PoHuGJAJtSeDALfV10wV0Fpveg3lcxZZHmQB/h6Bzt4AHx3DXFxWbiF1F9JADceOrc
         ZyLT12PbRSIzrtnQxCGI5FVEqoB1JRZYHCMsmiAqiBFnMwUphsobCUj8/hRnqacFXQJk
         1l2AeovPaB7Ex6P0oP38TwSJ0hj2CnzODzBUb6V5DddlXdUgQ+E3V8FzUyvDIDVE29yV
         NYcALDYtCjtmNlNbTMYSO2xYIU5mY4YWuXxab1HEtHmxVA7V7IyPLyvjPWOfwL6iXY5e
         zHzCF89tBU62JDa1qKPzr+CkpLZWI93sYfdLpQtigxmqjq6kyktcMcCWer5KTp8ByW0k
         HYuw==
X-Gm-Message-State: AO0yUKVCikDi4dV8XDxEwhxpM3GqzjYzieGQWZ0wnQH1CAEZh8l3hebf
        2tGtjC20X9n+oP3D90rmXsjQ0oPoAg==
X-Google-Smtp-Source: AK7set9Dy3KTgirTMtUUw+IeaYDLfCtmGVkArC89tinayABqHTuJ6pYnAC8nBVevxDWu1TmKNkfwQsudlw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:d1b:b0:506:6e1a:9b0 with SMTP id
 cn27-20020a05690c0d1b00b005066e1a09b0mr3288384ywb.277.1675202650592; Tue, 31
 Jan 2023 14:04:10 -0800 (PST)
Date:   Tue, 31 Jan 2023 22:03:54 +0000
In-Reply-To: <20230131220355.1603527-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230131220355.1603527-1-rmoar@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230131220355.1603527-3-rmoar@google.com>
Subject: [PATCH v1 2/3] kunit: fix bug in the order of lines in debugfs logs
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix bug in debugfs logs that causes an incorrect order of lines in the
debugfs log.

Currently, any suite diagnostic lines, including the test counts lines
that show the number of tests passed, failed, and skipped,
appear prior to the individual results, which is a bug.

Ensure the order of printing for the debugfs log is correct.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 lib/kunit/debugfs.c | 13 ++++++++-----
 lib/kunit/test.c    | 24 ++++++++++++------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index de0ee2e03ed6..fbc645590701 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -52,19 +52,22 @@ static void debugfs_print_result(struct seq_file *seq,
 static int debugfs_print_results(struct seq_file *seq, void *v)
 {
 	struct kunit_suite *suite = (struct kunit_suite *)seq->private;
-	enum kunit_status success = kunit_suite_has_succeeded(suite);
 	struct kunit_case *test_case;
 
-	if (!suite || !suite->log)
+	if (!suite)
 		return 0;
 
-	seq_printf(seq, "%s", suite->log);
+	/* Print suite header because it is not stored in the test logs. */
+	seq_puts(seq, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
+	seq_printf(seq, KUNIT_SUBTEST_INDENT "# Subtest: %s\n", suite->name);
+	seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n", kunit_suite_num_test_cases(suite));
 
 	kunit_suite_for_each_test_case(suite, test_case)
 		debugfs_print_result(seq, suite, test_case);
 
-	seq_printf(seq, "%s %d %s\n",
-		   kunit_status_to_ok_not_ok(success), 1, suite->name);
+	if (suite->log)
+		seq_printf(seq, "%s", suite->log);
+
 	return 0;
 }
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 66ba93b8222c..27763f0b420c 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -147,10 +147,18 @@ EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
 
 static void kunit_print_suite_start(struct kunit_suite *suite)
 {
-	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
-	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
+	/*
+	 * We do not log the test suite header as doing so would
+	 * mean debugfs display would consist of the test suite
+	 * header prior to individual test results.
+	 * Hence directly printk the suite status, and we will
+	 * separately seq_printf() the suite header for the debugfs
+	 * representation.
+	 */
+	pr_info(KUNIT_SUBTEST_INDENT "KTAP version 1\n");
+	pr_info(KUNIT_SUBTEST_INDENT "# Subtest: %s",
 		  suite->name);
-	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
+	pr_info(KUNIT_SUBTEST_INDENT "1..%zd",
 		  kunit_suite_num_test_cases(suite));
 }
 
@@ -165,16 +173,8 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 	struct kunit *test = is_test ? test_or_suite : NULL;
 	const char *directive_header = (status == KUNIT_SKIPPED) ? " # SKIP " : "";
 
-	/*
-	 * We do not log the test suite results as doing so would
-	 * mean debugfs display would consist of the test suite
-	 * description and status prior to individual test results.
-	 * Hence directly printk the suite status, and we will
-	 * separately seq_printf() the suite status for the debugfs
-	 * representation.
-	 */
 	if (suite)
-		pr_info("%s %zd %s%s%s\n",
+		kunit_log(KERN_INFO, suite, "%s %zd %s%s%s\n",
 			kunit_status_to_ok_not_ok(status),
 			test_number, description, directive_header,
 			(status == KUNIT_SKIPPED) ? directive : "");
-- 
2.39.1.456.gfc5497dd1b-goog

