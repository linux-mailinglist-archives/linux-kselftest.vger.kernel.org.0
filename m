Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A8775FC31
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjGXQbm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 12:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGXQbX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 12:31:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AB31FEB
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 09:31:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583f048985bso17046487b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690216260; x=1690821060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TaYYDbqmmDckH6pc4Vdf+rin+HNGA4/7Qk/7Hqzm7lg=;
        b=VsA04xXz2yaWHYNlKIOVpPS62IACK2QPKU4oW6ALdlxjRtVdsCeN2KFVsO6F3DGL00
         7/jmz7AQ+hYFRWR5hKgKJpjQS5H2qNjnHgyL1JaZLIdKVT/SWO9S7xlZG/puZ4T8kLoY
         6peUjhQRBJR6kiP68ivLk1Lh0N+AnJxjwnHzdC+QY1A5zm30AL71I3qif/yLzCrcNFMW
         VBy1PAWnmUjqvjFBK1TfgGG8LkykXh5K6FtszK4MjfGfeDo3f8oQAHhl1SeI9KuwZX34
         VsoDAdyDKtb4k5X6nMBmCbWN0Ab01A1c/iYbwLUClFIduhcjA5XODVWthWGvgxAcg1dr
         78nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216260; x=1690821060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TaYYDbqmmDckH6pc4Vdf+rin+HNGA4/7Qk/7Hqzm7lg=;
        b=JguH0g4DvjCpWQkLHRb7tmzsrtYUb5gQr12vzPQiMTGHFGnQiiqrB6yEEWxZBF9v2G
         oWzzMQaNmfSFMmth0lwD1DSILGHIDpk9I+YHAKPnQMPxj1enpb75WdC7nKWNDp0Ihog2
         g8hblHzSABMXYxEPYJtIVWrxdbe4Sji5SUlYwZJP8rJ3rOM2ieOnmCCO3b7yfMl0lVWS
         TYPckGRyxdK9UraMAMTyP5x/bcE8ua3kO2URbH6W1VdMjXmXqzR+oq+EN1fNRkgUrH0A
         A//H+q+TMYaZEMF3W95e1U4VDp8Ax+9omVatnV8W5VoSvYWyKU7Bd6/QIfaMPwnt2oMY
         ekXA==
X-Gm-Message-State: ABy/qLZgwDVvyZtVaoFbZTRizRT8j23hxPLS//JjmxFjLmf/01484sFZ
        NsJ5hncF8VA+WNNB+fj7o6fiab6jYQ==
X-Google-Smtp-Source: APBJJlEcY5LWNxdK7bzCfZY1KAY0UoSZt0T0PDL0QdiI1lDlM446ydir0ErQ3vflpRsNfdutNKgb9oPXfw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:102f:b0:c22:38c2:43de with SMTP id
 x15-20020a056902102f00b00c2238c243demr66603ybt.11.1690216260122; Mon, 24 Jul
 2023 09:31:00 -0700 (PDT)
Date:   Mon, 24 Jul 2023 16:28:28 +0000
In-Reply-To: <20230724162834.1354164-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230724162834.1354164-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724162834.1354164-9-rmoar@google.com>
Subject: [PATCH v2 8/9] kunit: add tests for filtering attributes
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
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v1:
- No changes.
Changes since RFC v2:
- Change fake suite and test case names.
- Add a few ASSERT statements.
Changes since RFC v1:
- This is a new patch.

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

