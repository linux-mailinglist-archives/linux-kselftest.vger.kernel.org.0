Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7BC51536A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Apr 2022 20:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355638AbiD2SQ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 14:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiD2SQ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 14:16:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9BEA6E37
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 11:13:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4dee8688cso80455907b3.16
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 11:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2kiTLLWMzE1fRaVFv2RZTJ9b23xbStkawa5kRyjYyA8=;
        b=keqK+zylXN4pY8llCOBPg1Er0xKEg1omQb4Cj4I7sP2jLPCAJxPCRtn2RdUNZGfWA2
         FGOCY8T7aXIKF8uj4+c8dGhHnigGnxQu9g3akFu5WpTlvCwa0owfS9ei/ZrL6lUrF9pJ
         RLbPdQpht3OpwGjuhaMLs5UkOEAg7ZOnXSE6whUlBoUhl9PKXtjNdBJfDZia/A0YKEt4
         sruyz8Uv6xOLeo4z/CO+19HT2Ld/0qcE92J+5JwquXW3cXxP7qguCR5+9qM8rO71vw6Q
         9yGtVMTNpd6Y7h0MlWSEH1mJNIkJNicH2NJRugMUaQv79RX/Dhru8UyxOol5dieNeLd0
         4XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2kiTLLWMzE1fRaVFv2RZTJ9b23xbStkawa5kRyjYyA8=;
        b=lP8R5aBSUEiS+W9lJKM/A+dR2QEktOj3UYs5oUB7WBXmgitwmSnyHPS/H2AOBy88/3
         VgCaWUNG49VrsCgpx2TLWUYd+bfGEdrYmZiVtfK1e9fvVs/14BtGmz+UJuYHhNDhqTYt
         mxZGSiGtV26Wbswy/9XbXuPQrVg2fC+MQmiRFz7si+s+c3Oaph6rDvuFtDYcjZy3WJY0
         0HeEsVG1Ie+4NC99ZJ7XKVQrq0H/jewDTwFtad4UK6BR8TjlRBEBLpQI8x2vzmeskL8G
         Fh59aA8eOCgZetV1AgTLv02BTtgX+SfW+WTZdrONMIIstyzOSN4JiyNDfukAbulMcNyN
         S3vg==
X-Gm-Message-State: AOAM531Ws4sb2bKhKmO9pMYhv7toPDZpD3zkkePVftrJpVHUkCbzyZFr
        KpssPgrCNv3NGEz7mLBLm1vjzchlXdIWRg==
X-Google-Smtp-Source: ABdhPJww5bRnHtr8wc3vsPj0eMHvAcjEqA+BTTAGRMBxrErBjDajT2Sbx0bHXuuQSEFvAbFSto7zqzARc3pVjw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:183a:36d7:2dcb:1773])
 (user=dlatypov job=sendgmr) by 2002:a25:d354:0:b0:645:d617:560a with SMTP id
 e81-20020a25d354000000b00645d617560amr682256ybf.247.1651255986725; Fri, 29
 Apr 2022 11:13:06 -0700 (PDT)
Date:   Fri, 29 Apr 2022 11:12:56 -0700
Message-Id: <20220429181259.622060-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 1/4] kunit: rename print_subtest_{start,end} for clarity (s/subtest/suite)
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
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

These names sound more general than they are.

The _end() function increments a `static int kunit_suite_counter`, so it
can only safely be called on suites, aka top-level subtests.
It would need to have a separate counter for each level of subtest to be
generic enough.

So rename it to make it clear it's only appropriate for suites.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2: no change (see patch 2 and 4)
---
 lib/kunit/test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 0f66c13d126e..64ee6a9d8003 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -134,7 +134,7 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
 }
 EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
 
-static void kunit_print_subtest_start(struct kunit_suite *suite)
+static void kunit_print_suite_start(struct kunit_suite *suite)
 {
 	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
 		  suite->name);
@@ -192,7 +192,7 @@ EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
 
 static size_t kunit_suite_counter = 1;
 
-static void kunit_print_subtest_end(struct kunit_suite *suite)
+static void kunit_print_suite_end(struct kunit_suite *suite)
 {
 	kunit_print_ok_not_ok((void *)suite, false,
 			      kunit_suite_has_succeeded(suite),
@@ -498,7 +498,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
 
-	kunit_print_subtest_start(suite);
+	kunit_print_suite_start(suite);
 
 	kunit_suite_for_each_test_case(suite, test_case) {
 		struct kunit test = { .param_value = NULL, .param_index = 0 };
@@ -552,7 +552,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 	}
 
 	kunit_print_suite_stats(suite, suite_stats, total_stats);
-	kunit_print_subtest_end(suite);
+	kunit_print_suite_end(suite);
 
 	return 0;
 }

base-commit: 59729170afcd4900e08997a482467ffda8d88c7f
-- 
2.36.0.464.gb9c8b46e94-goog

