Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA96B133A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 21:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCHUkA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 15:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCHUj7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 15:39:59 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6A9BBB06
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 12:39:57 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-53700262a47so178027557b3.4
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 12:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678307996;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XhemoCGkjfimbQttrNXjqCx4q4XXWm2P3IE9aNxV0Ao=;
        b=UdO6+fi5nMMmDymcYlh0h0YFaMxt0sdCFQ60J0jGfIqLkO51bwO4eRagZ1Q0mwICcO
         Q88cMMueFP22vKYxzyU3CrNwFQsSjhoobMlNLHWtpuAYfTzAmuWo9yBumN3RZW+JRsdL
         ZFYGog6kbywxL/X4ygdHs9GRUhbJ9KAnSRhL6btq83J6mNwjBJ0Xc74QRPLlEnJX2T/D
         DhFyMBXNvNNTiHgUayimeS0tgorrMTTWDlxW65AKCDKg9ozg2OivwDa1FdfP7RV8afRi
         +EAH2yIp7afJbWxFckFGum54jsEt0u13KkiykSmMtKg+vSvwVrYqg2gRRPqHQqAB/Q7G
         4oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678307996;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XhemoCGkjfimbQttrNXjqCx4q4XXWm2P3IE9aNxV0Ao=;
        b=r2FCX4uHHpJ42m7qXR0LvQBEEK9hR2TPr0IaoYJndyeKq4MWsGOswBhDQ1F8QHLrvN
         FEiV5lOv6V5vYGvFVF9iqgzkqo4g3XWOcJiy6aRpYqai6tSURKq23X5PbCNd4MNtj3Yd
         ETbjTrL4syJIWRF5eTlIuRi68bpKYT0cJdiCaBpjv7YAXXFrP+R83vN9+TNHIW2CiaXy
         3RDLwQDgJ2dtw+U1KDOWFjUob845D2ocaqV+ext8erv06dfyokfDx4CMO1ggYl4p3kBC
         Hl3o5dPhgWWRLCzU195s4S0PCA/EjLqSm/s+VSFArHWXVBSSyuWeRl6R6C2SxurRhu/W
         Nn8g==
X-Gm-Message-State: AO0yUKWyCyvNg1A1K8cNgIqJfOu3x/7t5aCUJOW+fWEvlEC1iL8X1Or+
        oYAt697C9K0M5FVg/UUzQIfuI4HHPw==
X-Google-Smtp-Source: AK7set9xWrCKF1fDWyXTChtuvjg/LRtLnOCLyXhXcxqUUu96L+Lj+knEFA1NVZjkgb5WUH4fGiLhGaX4lQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:185:b0:acd:7374:f15b with SMTP id
 t5-20020a056902018500b00acd7374f15bmr11814350ybh.13.1678307996377; Wed, 08
 Mar 2023 12:39:56 -0800 (PST)
Date:   Wed,  8 Mar 2023 20:39:50 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308203952.3060546-1-rmoar@google.com>
Subject: [PATCH v4 1/3] kunit: fix bug in debugfs logs of parameterized tests
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

Fix bug in debugfs logs that causes individual parameterized results to not
appear because the log is reinitialized (cleared) when each parameter is
run.

Ensure these results appear in the debugfs logs, increase log size to
allow for the size of parameterized results. As a result, append lines to
the log directly rather than using an intermediate variable that can cause
stack size warnings due to the increased log size.

Here is the debugfs log of ext4_inode_test which uses parameterized tests
before the fix:

     KTAP version 1

     # Subtest: ext4_inode_test
     1..1
 # Totals: pass:16 fail:0 skip:0 total:16
 ok 1 ext4_inode_test

As you can see, this log does not include any of the individual
parametrized results.

After (in combination with the next two fixes to remove extra empty line
and ensure KTAP valid format):

 KTAP version 1
 1..1
     KTAP version 1
     # Subtest: ext4_inode_test
     1..1
        KTAP version 1
         # Subtest: inode_test_xtimestamp_decoding
         ok 1 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
         ... (the rest of the individual parameterized tests)
         ok 16 2446-05-10 Upper bound of 32bit >=0 timestamp. All extra
     # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16
     ok 1 inode_test_xtimestamp_decoding
 # Totals: pass:16 fail:0 skip:0 total:16
 ok 1 ext4_inode_test

Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---

Changes from v3 -> v4:
- No changes.

Changes from v2 -> v3:
- Fix a off-by-one bug in the kunit_log_append method.

Changes from v1 -> v2:
- Remove the use of the line variable in kunit_log_append that was
  causing stack size warnings.
- Add before and after to the commit message.

 include/kunit/test.h |  2 +-
 lib/kunit/test.c     | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 08d3559dd703..0668d29f3453 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -34,7 +34,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
 struct kunit;
 
 /* Size of log associated with test. */
-#define KUNIT_LOG_SIZE	512
+#define KUNIT_LOG_SIZE 1500
 
 /* Maximum size of parameter description string. */
 #define KUNIT_PARAM_DESC_SIZE 128
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c9e15bb60058..c4d6304edd61 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -114,22 +114,27 @@ static void kunit_print_test_stats(struct kunit *test,
  */
 void kunit_log_append(char *log, const char *fmt, ...)
 {
-	char line[KUNIT_LOG_SIZE];
 	va_list args;
-	int len_left;
+	int len, log_len, len_left;
 
 	if (!log)
 		return;
 
-	len_left = KUNIT_LOG_SIZE - strlen(log) - 1;
+	log_len = strlen(log);
+	len_left = KUNIT_LOG_SIZE - log_len - 1;
 	if (len_left <= 0)
 		return;
 
+	/* Evaluate length of line to add to log */
 	va_start(args, fmt);
-	vsnprintf(line, sizeof(line), fmt, args);
+	len = vsnprintf(NULL, 0, fmt, args) + 1;
+	va_end(args);
+
+	/* Print formatted line to the log */
+	va_start(args, fmt);
+	vsnprintf(log + log_len, min(len, len_left), fmt, args);
 	va_end(args);
 
-	strncat(log, line, len_left);
 }
 EXPORT_SYMBOL_GPL(kunit_log_append);
 
@@ -437,7 +442,6 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	struct kunit_try_catch_context context;
 	struct kunit_try_catch *try_catch;
 
-	kunit_init_test(test, test_case->name, test_case->log);
 	try_catch = &test->try_catch;
 
 	kunit_try_catch_init(try_catch,
@@ -533,6 +537,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 		struct kunit_result_stats param_stats = { 0 };
 		test_case->status = KUNIT_SKIPPED;
 
+		kunit_init_test(&test, test_case->name, test_case->log);
+
 		if (!test_case->generate_params) {
 			/* Non-parameterised test. */
 			kunit_run_case_catch_errors(suite, test_case, &test);

base-commit: 60684c2bd35064043360e6f716d1b7c20e967b7d
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

