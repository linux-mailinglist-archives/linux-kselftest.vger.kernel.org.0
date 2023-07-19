Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A06075A1CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 00:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjGSWYp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 18:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjGSWYd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 18:24:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C2270A
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 15:24:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cb8263615d7so119152276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689805447; x=1692397447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQo2ACncIiMoW4snSusP13oUfZPvI4xKN74RE19L4FM=;
        b=Q4Zh3SLbR44hDRlXzaT+zQxNSWeXzIjU88VDCkpERye0YEfCt+tY3H2rYz4rSQVWgQ
         Ie4YM59v5zsyfR3DjNd1gf5pSaj67mdRXXkCEdHJV6F3a4L6DZRqavMh3J+Vup9qEBhC
         xatop62wdduovazhYwCxhf3SqLB4Eg/orY5nyXoOyXGRNudft0ly0O7NeFLC1bqe/gRQ
         lVbeo3MA/jK9NoXJ7Nj+v0pPfwTkf2DD38Wy60se7hRWjh8hISNceZPCniu7tgb4HbBa
         nA61r0K6y3mXNppm4Lx16k/zJCLtVRnbUIDj2H1ygCfOPr3ISXjV4yvmGQLy+wHJHnqT
         JhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805447; x=1692397447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQo2ACncIiMoW4snSusP13oUfZPvI4xKN74RE19L4FM=;
        b=Op8Fk62tJ2GimpdKrBNcZkT82/y/KxJp3kFB7P0mej/TncMMteIQKNsb6CXsil/Zwc
         8DgRM1qHaZ5OaDiY1WNESzOyQTjrqyYInJ9CIz7LKFYdOO9m1OQ6pk6ikbEyjWqGndvm
         reZXETtO4o1QQGuTt0Jf9vGSvSXOyfUcaNsnHsAMEeLPowFdLZkGWYCyNSVLjV7gulw6
         Wi6sDW1TXLk+obcNLQ0xu/rZrvojlPPEy4HYc6vAkAr9sO3WqehWc0gXepA+Jm5WYqa3
         XwrtCjEfHLyysgA7ZTjlWrFqhDxkwHOyhSuEUcV24dmoIMYx+vlJkrh5/OGIGh6TM5pm
         yjrg==
X-Gm-Message-State: ABy/qLZFQ1iqNPX5vJWXKGoiaK/ng/4qqq0rzklkt2Rsf+ZGybURvJFy
        XkD2nck3l2nf1LXspYxg9kZc5929fw==
X-Google-Smtp-Source: APBJJlF7DoBCoXDEt6Y3RVuCXFCgl14+OrfUPQQdZavytMrt7C26boR7YwNp5KFOYUlvmBG0TgDoMvGqIQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:1005:b0:cb3:c343:19e5 with SMTP id
 w5-20020a056902100500b00cb3c34319e5mr39825ybt.2.1689805447446; Wed, 19 Jul
 2023 15:24:07 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:23:35 +0000
In-Reply-To: <20230719222338.259684-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230719222338.259684-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719222338.259684-9-rmoar@google.com>
Subject: [PATCH v1 8/9] kunit: add tests for filtering attributes
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

- filter_attr_skip_test - to test the configurable filter skip option

Signed-off-by: Rae Moar <rmoar@google.com>
---

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
2.41.0.255.g8b1d071c50-goog

