Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636C376245B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 23:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjGYV0Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 17:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjGYVZs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 17:25:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6736B2689
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cab7304dcccso6758797276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690320342; x=1690925142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9AM4snvivssy7wbsIDxQ8HBHmF7mOFqa14w1fvW/F8=;
        b=5MDPJHFpRS8tRtMD7HzumQ0dmv4Mg4ioTG0yOfG3gxsAWIDO5UQ7AA6LpSKJyI6Rm1
         GsnP9eBT8wummS6ZYf6Pw5HF1Rek/IfFaaHrW+WIjI2cmc94qshWdb6b0XR2ZtDP+fK3
         E51ad7H7hq1WX2TMA/UGvSupcyOkUI/WesiT1+t2+zWezq/58SrhD6xq9624B6at9vXh
         vZAmIyRSUx9hKQquUvA3K2nEpWYWSPdNfcIQ42EfoyMiK8XqzKLUnOs8Zlyky1hhpwpV
         Tr7nyjIEE0R4MRkTW0zimQJC7AsIDDbTunUt5MXOaKmGputJISLxgsUQQDgAofrvMfFw
         WKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320342; x=1690925142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9AM4snvivssy7wbsIDxQ8HBHmF7mOFqa14w1fvW/F8=;
        b=TF1yAOlrei9tcJaLy93UKcEjase+KtrDS5diD0rIYY1pSJV+1I8MBUY4llNjtvjgcB
         mE6EIqqFr9XZ+ppevCyfmdD4OXntny0cxtWR1BRnxgKYAfk9bTfopHrSTZwYyAUYUxDx
         P7Bfa8SRJIFc408KBfkXGUwgw8ayn4o+zWc+1dmD1Yeehou7iJo1S684MS468i7q0QKL
         1vL0vYC1cH377m867qxUsmoUClsUMHxV/d5cUwKaa210cgmzJkz3EDIScLzOnVpztuyx
         WON/WpbMqabNSxYYjqp2yPysnqfjvBAgTYMn037R6ksr80LK9irMu+BXIRbbM2Zz3NAm
         S7/A==
X-Gm-Message-State: ABy/qLa0YfT/ANCVh8sWcRhz27r0x7xum0It4vVMlulEAwJbuY0WT5+/
        p/MSyFgIZxodbFi2vK3P5y0kROwW4w==
X-Google-Smtp-Source: APBJJlFCmt7oRxlkGB6KpzQDr1mW8YStaSYdV1LBvCXv9TEzZGowLNs1x8pzgajWNsXp1Fs95OMoXadY8w==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:512:0:b0:d0d:cce3:d32d with SMTP id
 18-20020a250512000000b00d0dcce3d32dmr1498ybf.6.1690320342696; Tue, 25 Jul
 2023 14:25:42 -0700 (PDT)
Date:   Tue, 25 Jul 2023 21:25:19 +0000
In-Reply-To: <20230725212522.1622716-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230725212522.1622716-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725212522.1622716-9-rmoar@google.com>
Subject: [PATCH v3 8/9] kunit: add tests for filtering attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add four tests to executor_test.c to test behavior of filtering attributes.

- parse_filter_attr_test - to test the parsing of inputted filters

- filter_attr_test - to test the filtering procedure on attributes

- filter_attr_empty_test - to test the behavior when all tests are filtered
  out

- filter_attr_skip_test - to test the configurable filter_action=skip
  option

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v2:
- No changes.
Changes since v1:
- No changes.
Changes since RFC v2:
- Change fake suite and test case names.
- Add a few ASSERT statements.
Changes since RFC v1:
- This is a new patch

 lib/kunit/executor_test.c | 116 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index d7ab069324b5..01280cb8d451 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/attributes.h>
 
 static void kfree_at_end(struct kunit *test, const void *to_free);
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
@@ -108,11 +109,126 @@ static void filter_suites_to_empty_test(struct kunit *test)
 				"should be empty to indicate no match");
 }
 
+static void parse_filter_attr_test(struct kunit *test)
+{
+	int j, filter_count;
+	struct kunit_attr_filter *parsed_filters;
+	char *filters = "speed>slow, module!=example";
+	int err = 0;
+
+	filter_count = kunit_get_filter_count(filters);
+	KUNIT_EXPECT_EQ(test, filter_count, 2);
+
+	parsed_filters = kunit_kcalloc(test, filter_count + 1, sizeof(*parsed_filters),
+			GFP_KERNEL);
+	for (j = 0; j < filter_count; j++) {
+		parsed_filters[j] = kunit_next_attr_filter(&filters, &err);
+		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter '%s'", filters[j]);
+	}
+
+	KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[0]), "speed");
+	KUNIT_EXPECT_STREQ(test, parsed_filters[0].input, ">slow");
+
+	KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[1]), "module");
+	KUNIT_EXPECT_STREQ(test, parsed_filters[1].input, "!=example");
+}
+
+static struct kunit_case dummy_attr_test_cases[] = {
+	/* .run_case is not important, just needs to be non-NULL */
+	{ .name = "slow", .run_case = dummy_test, .module_name = "dummy",
+	  .attr.speed = KUNIT_SPEED_SLOW },
+	{ .name = "normal", .run_case = dummy_test, .module_name = "dummy" },
+	{},
+};
+
+static void filter_attr_test(struct kunit *test)
+{
+	struct kunit_suite *subsuite[3] = {NULL, NULL};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
+	struct suite_set got;
+	int err = 0;
+
+	subsuite[0] = alloc_fake_suite(test, "normal_suite", dummy_attr_test_cases);
+	subsuite[1] = alloc_fake_suite(test, "slow_suite", dummy_attr_test_cases);
+	subsuite[1]->attr.speed = KUNIT_SPEED_SLOW; // Set suite attribute
+
+	/*
+	 * Want: normal_suite(slow, normal), slow_suite(slow, normal),
+	 *		NULL -> normal_suite(normal), NULL
+	 *
+	 * The normal test in slow_suite is filtered out because the speed
+	 * attribute is unset and thus, the filtering is based on the parent attribute
+	 * of slow.
+	 */
+	got = kunit_filter_suites(&suite_set, NULL, "speed>slow", NULL, &err);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	kfree_at_end(test, got.start);
+
+	/* Validate we just have normal_suite */
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
+	KUNIT_EXPECT_STREQ(test, got.start[0]->name, "normal_suite");
+	KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
+
+	/* Now validate we just have normal test case */
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
+	KUNIT_EXPECT_STREQ(test, got.start[0]->test_cases[0].name, "normal");
+	KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
+}
+
+static void filter_attr_empty_test(struct kunit *test)
+{
+	struct kunit_suite *subsuite[3] = {NULL, NULL};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
+	struct suite_set got;
+	int err = 0;
+
+	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_attr_test_cases);
+	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_attr_test_cases);
+
+	got = kunit_filter_suites(&suite_set, NULL, "module!=dummy", NULL, &err);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	kfree_at_end(test, got.start); /* just in case */
+
+	KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
+				"should be empty to indicate no match");
+}
+
+static void filter_attr_skip_test(struct kunit *test)
+{
+	struct kunit_suite *subsuite[2] = {NULL};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[1]};
+	struct suite_set got;
+	int err = 0;
+
+	subsuite[0] = alloc_fake_suite(test, "suite", dummy_attr_test_cases);
+
+	/* Want: suite(slow, normal), NULL -> suite(slow with SKIP, normal), NULL */
+	got = kunit_filter_suites(&suite_set, NULL, "speed>slow", "skip", &err);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	kfree_at_end(test, got.start);
+
+	/* Validate we have both the slow and normal test */
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
+	KUNIT_ASSERT_EQ(test, kunit_suite_num_test_cases(got.start[0]), 2);
+	KUNIT_EXPECT_STREQ(test, got.start[0]->test_cases[0].name, "slow");
+	KUNIT_EXPECT_STREQ(test, got.start[0]->test_cases[1].name, "normal");
+
+	/* Now ensure slow is skipped and normal is not */
+	KUNIT_EXPECT_EQ(test, got.start[0]->test_cases[0].status, KUNIT_SKIPPED);
+	KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].status);
+}
+
 static struct kunit_case executor_test_cases[] = {
 	KUNIT_CASE(parse_filter_test),
 	KUNIT_CASE(filter_suites_test),
 	KUNIT_CASE(filter_suites_test_glob_test),
 	KUNIT_CASE(filter_suites_to_empty_test),
+	KUNIT_CASE(parse_filter_attr_test),
+	KUNIT_CASE(filter_attr_test),
+	KUNIT_CASE(filter_attr_empty_test),
+	KUNIT_CASE(filter_attr_skip_test),
 	{}
 };
 
-- 
2.41.0.487.g6d72f3e995-goog

