Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A40E77D38C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 21:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbjHOTqg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 15:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbjHOTq1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 15:46:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7387A10FF
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 12:46:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c4d30c349so20657837b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 12:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692128785; x=1692733585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6RAEeq+C0W6SwJZ/YEOnzqyIIK3nkPxdLI5lLoEzx+s=;
        b=hZn5SljZOe3N+jH/R2VvkAXWuZx8uHTNLbKpZJv6cKpiSxkzzmx2msDBlZn7BYOdnc
         ianYU0wWYbDAkUiFCnzJfMyyb649Sas3p6+bcHgWtS002NjqjatTNQW3n+QZwqPTKS3L
         HOadGKuRWJwjfooYR3NjYGkU3uUPeDvV1ymLb5s71DXWrzmc+XyUbgYScy3Pw8Op2BQq
         jxnOpKQR21ni31lFkhiQIHWXALW1qOOvI5x7LobMtoA82Ef0V5gSQzRBSI0ewNYt8dlB
         yh3emINmhenzHHw6OgiI1edJSoZ174fJRUlg62h7O1YZommVUtIESxxvEiejOHksqW8S
         zkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128785; x=1692733585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RAEeq+C0W6SwJZ/YEOnzqyIIK3nkPxdLI5lLoEzx+s=;
        b=MGN4pqyUrpiZTgjs3dBCWd+Xsy2XUPNQui7UCmItwfn0cqFFDDmdg4IkuuLs9DU6rm
         0woxIPvs7/zivzqzr3Eh1tkusk9bfaEQENUeWxIPzUMX7M7gt8V90pfV5rsHf6aTD4WC
         mU9Li3VMMohofbuQ88hJn6yLrL5Z0Ox41k4eOx/MDeiQXKxl8QuCtgGpC6jVP/eXAr42
         JhPSoo8ho8j5rWVfXJHoxM2gaeivdcc5XEFXPbbsC9K8TSwCCwCT09BgJZeSopJlQipy
         2ITWsPEl1DjcjxhAxTYY3Vr3KlXt9quZzSKEtpC3ta0n2IPeVFPubprJtOa4tuXs0eU/
         p6GA==
X-Gm-Message-State: AOJu0YzXtBuyETALuMb79tTvvBcWsj0TlVa1Oy/vf94sIGDtzhtuC7ff
        HzyHSBpZI5H2Kdde94Nyfcu7w+vDSw==
X-Google-Smtp-Source: AGHT+IFtd2t9NaTpudbZDzFhdmRgojf0QntbLY8VGpagxAig4mAvXf9wo6s1KihYjXCI1S4MASHiNUdHIA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:1584:b0:d10:5b67:843c with SMTP id
 k4-20020a056902158400b00d105b67843cmr185393ybu.4.1692128785761; Tue, 15 Aug
 2023 12:46:25 -0700 (PDT)
Date:   Tue, 15 Aug 2023 19:45:41 +0000
In-Reply-To: <20230815194541.497115-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230815194541.497115-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815194541.497115-2-rmoar@google.com>
Subject: [PATCH 2/2] kunit: fix kunit_executor_test to allow for run after boot
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

Change implementation of executor tests to allow for use of new run
after boot feature.

Without this fix, the tests will cause a kernel crash if run after boot
due to permissions issue in accessing constant strings.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 lib/kunit/executor_test.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index 4084071d0eb5..66a02291892d 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -119,9 +119,12 @@ static void parse_filter_attr_test(struct kunit *test)
 {
 	int j, filter_count;
 	struct kunit_attr_filter *parsed_filters;
-	char *filters = "speed>slow, module!=example";
+	int max_char = 30;
+	char *filters = kunit_kzalloc(test, sizeof(char) * max_char, GFP_KERNEL);
 	int err = 0;
 
+	strscpy(filters, "speed>slow, module!=example", max_char);
+
 	filter_count = kunit_get_filter_count(filters);
 	KUNIT_EXPECT_EQ(test, filter_count, 2);
 
@@ -154,6 +157,8 @@ static void filter_attr_test(struct kunit *test)
 		.start = subsuite, .end = &subsuite[2],
 	};
 	struct kunit_suite_set got;
+	int max_char = 30;
+	char *filter = kunit_kzalloc(test, sizeof(char) * max_char, GFP_KERNEL);
 	int err = 0;
 
 	subsuite[0] = alloc_fake_suite(test, "normal_suite", dummy_attr_test_cases);
@@ -168,7 +173,8 @@ static void filter_attr_test(struct kunit *test)
 	 * attribute is unset and thus, the filtering is based on the parent attribute
 	 * of slow.
 	 */
-	got = kunit_filter_suites(&suite_set, NULL, "speed>slow", NULL, &err);
+	strscpy(filter, "speed>slow", max_char);
+	got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start);
@@ -191,12 +197,15 @@ static void filter_attr_empty_test(struct kunit *test)
 		.start = subsuite, .end = &subsuite[2],
 	};
 	struct kunit_suite_set got;
+	int max_char = 30;
+	char *filter = kunit_kzalloc(test, sizeof(char) * max_char, GFP_KERNEL);
 	int err = 0;
 
 	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_attr_test_cases);
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_attr_test_cases);
 
-	got = kunit_filter_suites(&suite_set, NULL, "module!=dummy", NULL, &err);
+	strscpy(filter, "module!=dummy", max_char);
+	got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start); /* just in case */
 
@@ -211,12 +220,15 @@ static void filter_attr_skip_test(struct kunit *test)
 		.start = subsuite, .end = &subsuite[1],
 	};
 	struct kunit_suite_set got;
+	int max_char = 30;
+	char *filter = kunit_kzalloc(test, sizeof(char) * max_char, GFP_KERNEL);
 	int err = 0;
 
 	subsuite[0] = alloc_fake_suite(test, "suite", dummy_attr_test_cases);
 
 	/* Want: suite(slow, normal), NULL -> suite(slow with SKIP, normal), NULL */
-	got = kunit_filter_suites(&suite_set, NULL, "speed>slow", "skip", &err);
+	strscpy(filter, "speed>slow", max_char);
+	got = kunit_filter_suites(&suite_set, NULL, filter, "skip", &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start);
-- 
2.41.0.694.ge786442a9b-goog

