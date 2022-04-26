Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC85106A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 20:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbiDZSWv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 14:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiDZSWu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 14:22:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402A5197F91
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 11:19:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v17-20020a056902029100b006484d85132eso6658556ybh.14
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ISf/anLTGG8aDfdYm3HlRvwPzm+lbJ5gZK255uLU0N0=;
        b=Ur5xXORcPM2CZ439vOEwCulasH931zg9WytiwjntMXBrnbbzDY69LUuWucG4wHMCwE
         4jr8lL1Bs3Ws8X3XRy8waN0e6K9qT52c02h+Rk2QaKhygzEYSgqzAOh+/CojekNAC+qD
         dFMSkG+mo3EoNlQ5vB5RGNUw0AdibLl8uXveQ+GKNfxn3tJ0qF6sn+ea+m0WSCIyEWxM
         ZkG/aK/tiH5824o7GHgYNVyJOhrvDWJ6mA+Z1Us5Nug/Hbcvri0g8eR0a0UQ0hiX8c8F
         AKeK0n19dC58zNBVaMyNpozByExipLG9wdOnf07v2TaC7wiTiErttyUvdbbz3jpuddED
         pJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ISf/anLTGG8aDfdYm3HlRvwPzm+lbJ5gZK255uLU0N0=;
        b=oeJEMyPFytMwtTnbL8YnEOVCMEhX45E382/1wgyJR6EDATIHh1nsvjZpa1E+PQR1SW
         FB5cLtyY/W7WiRTBNx/ie4JLBGktJHn4RP07kDHZK80zTNB+ywjp04hIEu3fH3VkBWZa
         L244DlVOVopRYfmTogXzbmjzJfucF09t1uWTsNSAw4bRvIO0cXp6oIFWTmO4dqzvOcAk
         W79cRl8wiq+r8nP7g8CKPDbnKm+0Yjp/XLB30XwoLOwYesolM/vAiH6auCOZHnTaggY8
         U1JHk7NfAwlmdqQ/h5sQ0GtvX+IzwVJiAOQRUfMVY3m7DXEJeRi/WUygBUfpT2J4RJKh
         s9JA==
X-Gm-Message-State: AOAM532bkqLazasfGUctP0W7MD5k4yfhp4+kDHIfUd+8spemLsF6NDwo
        uazccLgNXl5tWhYCNmGiAUnYzN53Q5UurA==
X-Google-Smtp-Source: ABdhPJwPXVW3jrSsfOmBbLULPEFpZ1wlX5n1zj8BpLWvhRxzippBSvFduoToUHwDEkVuZv2mBhYmhuduAUThkA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:b03d:8d64:4a06:2c5f])
 (user=dlatypov job=sendgmr) by 2002:a25:2487:0:b0:645:7751:ba68 with SMTP id
 k129-20020a252487000000b006457751ba68mr22631565ybk.333.1650997181489; Tue, 26
 Apr 2022 11:19:41 -0700 (PDT)
Date:   Tue, 26 Apr 2022 11:19:22 -0700
Message-Id: <20220426181925.3940286-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH 1/3] kunit: rename print_subtest_{start,end} for clarity (s/subtest/suite)
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
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

These names sound more general than they are.

The _end() function increments a `static int kunit_suite_counter`, so it
can only safely be called on suites, aka top-level subtests.
It would need to have a separate counter for each level of subtest to be
generic enough.

So rename it to make it clear it's only appropriate for suites.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
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
2.36.0.rc2.479.g8af0fa9b8e-goog

