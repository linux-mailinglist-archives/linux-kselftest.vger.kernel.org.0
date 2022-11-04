Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70EA61A16F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 20:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKDTsM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 15:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKDTsL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 15:48:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53332C64E
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Nov 2022 12:48:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-367f94b9b16so54648007b3.11
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Nov 2022 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2bUeD5ryefkaAP3EviNA21y9Ow7pZ1M96u/IoQ0qxoI=;
        b=YaMKPHlxllqPZ2vZAbyCAJhIsE2fCVjETNrDBwTKTaMYWSnJY/XMvkmxwORj69K0sq
         0BtGbu/xP2uIqvv+taFyl3bA6mjZ3G7OGW3dg8QBDW2Gni38+3BviMEaJBpPrZ5Ubf6H
         Qc8YNfqdAp9oCJHMvyPZYcU99U4EGRi7twWVQ/jSsbGdJEGVUyeC07T0eau1msopD2D5
         wngbzRBrXgoxvgt+6TbATOp6wukwI2wy0Kz5lq2iFy4B3Snv9aKONfSGDYuVvAP8To4w
         Mp1/45dn8qs2+VwioIE9vxGzTL/J9iNtLFgxmZBGAQuQvQNggXRs1ezIzoixl7V18vBk
         1A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bUeD5ryefkaAP3EviNA21y9Ow7pZ1M96u/IoQ0qxoI=;
        b=g/OaxFmH5hwKtgsb+GiJPEhIH4EBsNTLZURzlhslSo+Am9qthCDa6X33X+gxDSE/sZ
         Eh2gTHK1CF1kCEp6cJMim/jm480qomKEEwIzgtFa0dgRehCWL/yCiZEToqNRvIKHO9Ta
         yDSLGDyuO0tXNBVU0RsD65QgcLyIWUCvJx1Woxl5bQ2IGlUwg5BnUSAyRqggQWFlaW8H
         LJXxTopIaa/auLDpnDdHUIo4GdsjAW8EZ9R8NTYuU+BmJ0lNdjWZp4R1uUW2QN9OUsuv
         HYif2saxRy2kzyZ3a2UR+e9zfOK9R1DwEfZ5uqKXaUngJ8otxxBIaLSqm/+IMlvBnhA0
         rfgg==
X-Gm-Message-State: ACrzQf1F6v4uju/1DWnqCpaxPV85cvt6WNo2mC+ydtgNfgw1EgC6y0k5
        4/62wS7XInS3lEZmM22X0fBUKvMBzg==
X-Google-Smtp-Source: AMsMyM7FsouUddU78TNpSIgNZtAiPALUe5pVe6fS3dDNYAfuDKO/q7rIG8hftoj6D5/F6Z41c0QqbJ4omQ==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a81:17d1:0:b0:36a:6185:fb06 with SMTP id
 200-20020a8117d1000000b0036a6185fb06mr35749150ywx.351.1667591289013; Fri, 04
 Nov 2022 12:48:09 -0700 (PDT)
Date:   Fri,  4 Nov 2022 19:47:04 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104194705.3245738-1-rmoar@google.com>
Subject: [PATCH v1 1/2] kunit: improve KTAP compliance of KUnit test output
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Rae Moar <rmoar@google.com>
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

Change KUnit test output to comply with KTAP version 1 specifications
found here: https://kernel.org/doc/html/latest/dev-tools/ktap.html.
1) Use "KTAP version 1" instead of "TAP version 14" as test output header
2) Remove '-' between test number and test name on test result lines
2) Add KTAP version lines to each subtest header as well

Original output:

 TAP version 14
 1..1
   # Subtest: kunit-test-suite
   1..3
   ok 1 - kunit_test_1
   ok 2 - kunit_test_2
   ok 3 - kunit_test_3
 # kunit-test-suite: pass:3 fail:0 skip:0 total:3
 # Totals: pass:3 fail:0 skip:0 total:3
 ok 1 - kunit-test-suite

New output:

 KTAP version 1
 1..1
   # Subtest: kunit-test-suite
   KTAP version 1
   1..3
   ok 1 kunit_test_1
   ok 2 kunit_test_2
   ok 3 kunit_test_3
 # kunit-test-suite: pass:3 fail:0 skip:0 total:3
 # Totals: pass:3 fail:0 skip:0 total:3
 ok 1 kunit-test-suite

Signed-off-by: Rae Moar <rmoar@google.com>
---
 lib/kunit/executor.c | 6 +++---
 lib/kunit/test.c     | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 9bbc422c284b..74982b83707c 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -166,7 +166,7 @@ static void kunit_exec_run_tests(struct suite_set *suite_set)
 {
 	size_t num_suites = suite_set->end - suite_set->start;
 
-	pr_info("TAP version 14\n");
+	pr_info("KTAP version 1\n");
 	pr_info("1..%zu\n", num_suites);
 
 	__kunit_test_suites_init(suite_set->start, num_suites);
@@ -177,8 +177,8 @@ static void kunit_exec_list_tests(struct suite_set *suite_set)
 	struct kunit_suite * const *suites;
 	struct kunit_case *test_case;
 
-	/* Hack: print a tap header so kunit.py can find the start of KUnit output. */
-	pr_info("TAP version 14\n");
+	/* Hack: print a ktap header so kunit.py can find the start of KUnit output. */
+	pr_info("KTAP version 1\n");
 
 	for (suites = suite_set->start; suites < suite_set->end; suites++)
 		kunit_suite_for_each_test_case((*suites), test_case) {
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 90640a43cf62..b541d59a05c3 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -151,6 +151,7 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
 {
 	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
 		  suite->name);
+	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
 	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
 		  kunit_suite_num_test_cases(suite));
 }
@@ -175,13 +176,13 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 	 * representation.
 	 */
 	if (suite)
-		pr_info("%s %zd - %s%s%s\n",
+		pr_info("%s %zd %s%s%s\n",
 			kunit_status_to_ok_not_ok(status),
 			test_number, description, directive_header,
 			(status == KUNIT_SKIPPED) ? directive : "");
 	else
 		kunit_log(KERN_INFO, test,
-			  KUNIT_SUBTEST_INDENT "%s %zd - %s%s%s",
+			  KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
 			  kunit_status_to_ok_not_ok(status),
 			  test_number, description, directive_header,
 			  (status == KUNIT_SKIPPED) ? directive : "");

base-commit: 6fe1ad4a156095859721fef85073df3ed43081d4
-- 
2.38.1.431.g37b22c650d-goog

