Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA36B133B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 21:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCHUkF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 15:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjCHUkB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 15:40:01 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D44BC6E5
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 12:39:59 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-53700262a47so178028207b3.4
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 12:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678307998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9uPe01ic6JuqQnU17qCIsYYrqwEpH1+M6H+qOnSQkRs=;
        b=HLrEDU0CrciNsNja7SILtiCywPnrwyeTk24ItVY3nzBMUOuaC52dfyVhKWxNZOxJ4X
         YTc7EaSAPK53dvw65w4EwPI9NtokGSx/MhpeMlJ38bBgRfaNCzoJbeLPyg7RkODWSivS
         Ic1zgYzpK8qCqUXCinxOpAyBfpOVaoClxweewRkGKKh/wOWpGAHqA8FczhWOCG/2SnJr
         yopTFlyvXHX5Wj+6j0sxCHdfG2hgd7eQnoPOqKz3ikKTvyE3FFwpkIdIr7qZvlb1VrGF
         xTX9T1a2YjoMxVPFAXKlNDgvETJM1Cm8NBmoktL+pAzzWalzOlJXRDC5Vtxu1ii3Kgzd
         tdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678307998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uPe01ic6JuqQnU17qCIsYYrqwEpH1+M6H+qOnSQkRs=;
        b=Ao+nsa4u8oGeoa0SrwI47wFSQ7XbqiQB35pGGs+Gv953+I10pmXrJb9LNPP/BCTnFe
         sNi2ebD/P/b8hIq+ZqN4XUiSShfPQMrykAuJbN8kk33bnztiuSENGf17rnOLr4goZRWX
         NmuQMKvLWyEBMWLoEcrKbDL9xcFMG7jKya6eVNebXEEVPQCY6zY6vdr57KhJpVol1Rm2
         wPz9U6INXA68kBnIIgds3uqvSNqI6ZqfyeAmk8I1uN/7stXT8bUZlMOUy12JMMSTCyq4
         scX5kbsF/7faVav/EsNLzJOhUBtmS+9aUY67+lM8EyUcd/edC329qc5+H6+efE1txLVi
         Dxfg==
X-Gm-Message-State: AO0yUKXG2Sqw+6sICbjzX99Ji+Y18quJYelkKpUFhK0XYn0v88kF5xgX
        knX8tj+4XS4zdZDCzJKlW+8vf+nKDQ==
X-Google-Smtp-Source: AK7set/R5HHPdjUZVjiuZxGGtXQ+3059B+JTHOcU6Mm15JTXyVb/9JD/Tq2DXiVaqWJij61oUA3oNIZMKg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:7dd7:0:b0:538:7680:412a with SMTP id
 y206-20020a817dd7000000b005387680412amr4ywc.437.1678307998208; Wed, 08 Mar
 2023 12:39:58 -0800 (PST)
Date:   Wed,  8 Mar 2023 20:39:51 +0000
In-Reply-To: <20230308203952.3060546-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230308203952.3060546-1-rmoar@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308203952.3060546-2-rmoar@google.com>
Subject: [PATCH v4 2/3] kunit: fix bug in the order of lines in debugfs logs
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

Currently, the test counts lines that show the number of tests passed,
failed, and skipped, as well as any suite diagnostic lines,
appear prior to the individual results, which is a bug.

Ensure the order of printing for the debugfs log is correct. Additionally,
add a KTAP header to so the debugfs logs can be valid KTAP.

This is an example of a log prior to these fixes:

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
Reviewed-by: David Gow <davidgow@google.com>
---

Changes from v3 -> v4:
- No changes.

Changes from v2 -> v3:
- No changes.

Changes from v1 -> v2:
- Add KTAP header.
- Ensure test result number is 1.

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
index c4d6304edd61..811fcc376d2f 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -152,10 +152,18 @@ EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
 
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
 
@@ -172,10 +180,9 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 
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
2.40.0.rc0.216.gc4246ad0f0-goog

