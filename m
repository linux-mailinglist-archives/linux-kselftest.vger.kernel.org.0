Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209D375FC25
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGXQaq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 12:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXQan (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 12:30:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195D110C3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 09:30:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cbcffb18afeso4166210276.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690216228; x=1690821028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/n6z3jVDugJtd8hEqhJ3SYr02T4ZdkB3+d9CQl9+UoY=;
        b=S5HbzgDivGpIklGgkQh013hsPVpnjZ1nd5ClrGqyLJ/80QBvbXYuDS6GM8OY1v4G64
         WheWSo41V1+kAtB7ggGOrPk9/vLiKuKhQQep+3bNH8xM3UOoqxA7PpYya0n1S4fCRsHj
         8eJKxRwuk5sHgK2jWGdAbTVLcjrlpFLVM03WN/LS5FNUqi798c4SolN1GAfjOzlQ6V6F
         Bgb4wQwON3ImIasrJg2po4ziGp1iD/ZCeu/W76JYgN2jFgG8fCrTDcNbNECL1kGTCfdC
         3xMucJG//iqM9XzKWpVDQUiklOQRj3AE4O3pAsABKxezs4qvbB02lyqKc4F65Ij6K4C4
         KcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216228; x=1690821028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/n6z3jVDugJtd8hEqhJ3SYr02T4ZdkB3+d9CQl9+UoY=;
        b=b0M9jTNPz6KuDEcwwlZYomNPC/QSwlQH0XClmfFsFOOIKop2bhNQvmpjew58GPGXnK
         Q3bJb8mCoemvAwnAs5yqv3f4shjeOGgHwrIlpJrGLBgbFOROrZ/m5eyifFgcq+Ej/ZUU
         yKK6q/7m3S0iAqkw/cnbeFJd5iq3DqXJ+FktCRTdwTNIPZEuZ2XKtgzSt+WZlya5IRDO
         dbVY/QA6YzxxdzCsTUjYv742kzddjPBA+q8OjinEYT1RdFbdE0BaQr+qGlsh+VFNh7Uw
         a0Vzf3P3krP0B8OytmmJcEddL3GemD4SR0DfzgkaNSFEQOHwpAh7qaRkxzVDAnHJFHBQ
         4t1w==
X-Gm-Message-State: ABy/qLa1t8ZgSrp8gtK5MNGr1CUhq89wpO/V3dqMzby7jnDnC8jow/r3
        2h5WPxuhqF9KbR5YC7707Rp13N+dVg==
X-Google-Smtp-Source: APBJJlFK1Hpzn7T8Xo3S1J6jHyFpLXZLTuF1yjkWCRI8SxNVouCj2GdmbKC7d3CKAzD7RUQL1XOhU00zng==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:378f:0:b0:d0c:1fc:747a with SMTP id
 e137-20020a25378f000000b00d0c01fc747amr31827yba.5.1690216228285; Mon, 24 Jul
 2023 09:30:28 -0700 (PDT)
Date:   Mon, 24 Jul 2023 16:28:22 +0000
In-Reply-To: <20230724162834.1354164-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230724162834.1354164-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724162834.1354164-3-rmoar@google.com>
Subject: [PATCH v2 2/9] kunit: Add speed attribute
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

Add speed attribute to the test attribute API. This attribute will allow
users to mark tests with a category of speed.

Currently the categories of speed proposed are: normal, slow, and very_slow
(outlined in enum kunit_speed). These are outlined in the enum kunit_speed.

The assumed default speed for tests is "normal". This indicates that the
test takes a relatively trivial amount of time (less than 1 second),
regardless of the machine it is running on. Any test slower than this could
be marked as "slow" or "very_slow".

Add the macro KUNIT_CASE_SLOW to set a test as slow, as this is likely a
common use of the attributes API.

Add an example of marking a slow test to kunit-example-test.c.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v1:
- Change kunit_attr_list definition to fix compile error.
Changes since RFC v2:
- Fixup comment.
Changes since RFC v1:
- Remove the "fast" category of speed.

 include/kunit/test.h           | 32 ++++++++++++++++++++++++-
 lib/kunit/attributes.c         | 44 +++++++++++++++++++++++++++++++++-
 lib/kunit/kunit-example-test.c |  9 +++++++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 1fc9155988e9..ed5f5000a095 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -63,8 +63,27 @@ enum kunit_status {
 	KUNIT_SKIPPED,
 };
 
+/* Attribute struct/enum definitions */
+
+/*
+ * Speed Attribute is stored as an enum and separated into categories of
+ * speed: very_slowm, slow, and normal. These speeds are relative to
+ * other KUnit tests.
+ *
+ * Note: unset speed attribute acts as default of KUNIT_SPEED_NORMAL.
+ */
+enum kunit_speed {
+	KUNIT_SPEED_UNSET,
+	KUNIT_SPEED_VERY_SLOW,
+	KUNIT_SPEED_SLOW,
+	KUNIT_SPEED_NORMAL,
+	KUNIT_SPEED_MAX = KUNIT_SPEED_NORMAL,
+};
+
 /* Holds attributes for each test case and suite */
-struct kunit_attributes {};
+struct kunit_attributes {
+	enum kunit_speed speed;
+};
 
 /**
  * struct kunit_case - represents an individual test case.
@@ -150,6 +169,17 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
 		{ .run_case = test_name, .name = #test_name,	\
 		  .attr = attributes }
 
+/**
+ * KUNIT_CASE_SLOW - A helper for creating a &struct kunit_case
+ * with the slow attribute
+ *
+ * @test_name: a reference to a test case function.
+ */
+
+#define KUNIT_CASE_SLOW(test_name)			\
+		{ .run_case = test_name, .name = #test_name,	\
+		  .attr.speed = KUNIT_SPEED_SLOW }
+
 /**
  * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
  *
diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index 9bda5a5f4030..ffd0d692b334 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -40,9 +40,51 @@ struct kunit_attr {
 	enum print_ops print;
 };
 
+/* String Lists for enum Attributes */
+
+static const char * const speed_str_list[] = {"unset", "very_slow", "slow", "normal"};
+
+/* To String Methods */
+
+static const char *attr_enum_to_string(void *attr, const char * const str_list[], bool *to_free)
+{
+	long val = (long)attr;
+
+	*to_free = false;
+	if (!val)
+		return NULL;
+	return str_list[val];
+}
+
+static const char *attr_speed_to_string(void *attr, bool *to_free)
+{
+	return attr_enum_to_string(attr, speed_str_list, to_free);
+}
+
+/* Get Attribute Methods */
+
+static void *attr_speed_get(void *test_or_suite, bool is_test)
+{
+	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
+	struct kunit_case *test = is_test ? test_or_suite : NULL;
+
+	if (test)
+		return ((void *) test->attr.speed);
+	else
+		return ((void *) suite->attr.speed);
+}
+
 /* List of all Test Attributes */
 
-static struct kunit_attr kunit_attr_list[] = {};
+static struct kunit_attr kunit_attr_list[] = {
+	{
+		.name = "speed",
+		.get_attr = attr_speed_get,
+		.to_string = attr_speed_to_string,
+		.attr_default = (void *)KUNIT_SPEED_NORMAL,
+		.print = PRINT_ALWAYS,
+	},
+};
 
 /* Helper Functions to Access Attributes */
 
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index b69b689ea850..01a769f35e1d 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -220,6 +220,14 @@ static void example_params_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, param->value % param->value, 0);
 }
 
+/*
+ * This test should always pass. Can be used to practice filtering attributes.
+ */
+static void example_slow_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
+}
+
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -237,6 +245,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_all_expect_macros_test),
 	KUNIT_CASE(example_static_stub_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
+	KUNIT_CASE_SLOW(example_slow_test),
 	{}
 };
 
-- 
2.41.0.487.g6d72f3e995-goog

