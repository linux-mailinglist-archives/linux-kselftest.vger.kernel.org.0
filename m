Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB75269FAFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 19:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjBVS1s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 13:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjBVS1r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 13:27:47 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2763A878
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 10:27:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536e8d6d9ceso52159407b3.12
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 10:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677090465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEsXaJ/BmtRM1h8LKXkgldxjS4A8ATj9p4wwTNADwEY=;
        b=Ve+ZD02zHsXEI17UKVYpl6yb85DnWCCrPiUxqWYLSVkdZ2IYEErSnksjqrJpxiV/kh
         cWhkpntc0StOjwUow3u/8ihVgVdmJPo58WzytiXyW5c/L0q4nkx8dJrJ/byC4ijNbcTa
         yjWGrfM0v7MMhOnI2dEuNCzNb4wNuPRC4eU5dJB7I45kcO1+ZQrwnAqIOcN9jdkspaNn
         O37fBcjMABfxLDbgz/oE4DoMpKKf8cCuylVNS4NE+1Qc5om/EvsCrNukZvl/wbFP4e5p
         E5ovZntulinLjXg0HfxpiJy8Jp+KmQ7qBvSn5daJi1uDUSfLmpb8zNPBW1LtgVDOzUyF
         T9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677090465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEsXaJ/BmtRM1h8LKXkgldxjS4A8ATj9p4wwTNADwEY=;
        b=fXfz0DJ6vjF5LWGBlp6D07WKXRRYDCTLRM3b7k2enJeZWNdnznT/VZTGHxeskSLqzD
         AhhGhblbXU2lhUMuVQBZNS2/hkzJOaB3fKvYk0U0N1L6eo6EYknes851KsBsDatC3Jsp
         T5/Mr47L9vJdInLYnRQ8eAnVexCyrf8PsPtQC1uQnyH5UdcBzSKBr0XCPTqUr3Nyyhog
         IzLvqbJrVLakdDq1g9QpeHr1WAGMamP1bVm30yI0BK6cR6RoOwLpCwntkyYp9P07e7iw
         ggd7llrYN48HPZBz7TGQE4EVDyOvvruio6ZkoQ9BHV69NF5jXagIyRMvlBBIAKf8bhJ5
         HDSQ==
X-Gm-Message-State: AO0yUKV1PMI1CSzJD4dMR46pDcWdAOqCAqrEiE0wrWESn40RDkW6jvMg
        V99CVokgdcVt+6ySsxRSRUHtZ5Axwg==
X-Google-Smtp-Source: AK7set93R2asmBbd0F48XMArEIndL/iKkrb1ztKBeofHDUyqy5vBnqhZ6yZqo+54MPCk9HNHeiTR63y6Jw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a5b:6cf:0:b0:a03:da3f:3e65 with SMTP id
 r15-20020a5b06cf000000b00a03da3f3e65mr469778ybq.6.1677090465183; Wed, 22 Feb
 2023 10:27:45 -0800 (PST)
Date:   Wed, 22 Feb 2023 18:27:39 +0000
In-Reply-To: <20230222182740.254087-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230222182740.254087-1-rmoar@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230222182740.254087-2-rmoar@google.com>
Subject: [PATCH v2 2/3] kunit: fix bug in the order of lines in debugfs logs
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix bug in debugfs logs that causes an incorrect order of lines in the
debugfs log.

Currently, the test counts lines that show the number of tests passed,
failed, and skipped, as well as any suite diagnostic lines,
appear prior to the individual results, which is a bug.

Ensure the order of printing for the debugfs log is correct. Additionally,
add a KTAP header to so the debugfs logs can be valid KTAP.

This is an example of the kunit_status debugfs log prior to these fixes:

     KTAP version 1

     # Subtest: kunit_status
     1..2
 # kunit_status: pass:2 fail:0 skip:0 total:2
 # Totals: pass:2 fail:0 skip:0 total:2
     ok 1 kunit_status_set_failure_test
     ok 2 kunit_status_mark_skipped_test
 ok 1 kunit_status

Note the two lines with stats are out of order. This is the same debugfs
log after the fixes (in combination with the third patch to remove the
extra line):

 KTAP version 1
 1..1
     KTAP version 1
     # Subtest: kunit_status
     1..2
     ok 1 kunit_status_set_failure_test
     ok 2 kunit_status_mark_skipped_test
 # kunit_status: pass:2 fail:0 skip:0 total:2
 # Totals: pass:2 fail:0 skip:0 total:2
 ok 1 kunit_status

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes from v1 -> v2:
- Add KTAP header.
- Ensure test result number is 1.
- Add before and after results to the commit message.

 lib/kunit/debugfs.c | 14 ++++++++++++--
 lib/kunit/test.c    | 21 ++++++++++++++-------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index de0ee2e03ed6..b08bb1fba106 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -55,14 +55,24 @@ static int debugfs_print_results(struct seq_file *seq, void *v)
 	enum kunit_status success = kunit_suite_has_succeeded(suite);
 	struct kunit_case *test_case;
 
-	if (!suite || !suite->log)
+	if (!suite)
 		return 0;
 
-	seq_printf(seq, "%s", suite->log);
+	/* Print KTAP header so the debugfs log can be parsed as valid KTAP. */
+	seq_puts(seq, "KTAP version 1\n");
+	seq_puts(seq, "1..1\n");
+
+	/* Print suite header because it is not stored in the test logs. */
+	seq_puts(seq, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
+	seq_printf(seq, KUNIT_SUBTEST_INDENT "# Subtest: %s\n", suite->name);
+	seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n", kunit_suite_num_test_cases(suite));
 
 	kunit_suite_for_each_test_case(suite, test_case)
 		debugfs_print_result(seq, suite, test_case);
 
+	if (suite->log)
+		seq_printf(seq, "%s", suite->log);
+
 	seq_printf(seq, "%s %d %s\n",
 		   kunit_status_to_ok_not_ok(success), 1, suite->name);
 	return 0;
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c406aa07d875..fb6b39cca0ae 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -151,10 +151,18 @@ EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
 
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
+	pr_info(KUNIT_SUBTEST_INDENT "# Subtest: %s\n",
 		  suite->name);
-	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
+	pr_info(KUNIT_SUBTEST_INDENT "1..%zd\n",
 		  kunit_suite_num_test_cases(suite));
 }
 
@@ -171,10 +179,9 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 
 	/*
 	 * We do not log the test suite results as doing so would
-	 * mean debugfs display would consist of the test suite
-	 * description and status prior to individual test results.
-	 * Hence directly printk the suite status, and we will
-	 * separately seq_printf() the suite status for the debugfs
+	 * mean debugfs display would consist of an incorrect test
+	 * number. Hence directly printk the suite result, and we will
+	 * separately seq_printf() the suite results for the debugfs
 	 * representation.
 	 */
 	if (suite)
-- 
2.39.2.637.g21b0678d19-goog

