Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC66C72A724
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 02:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjFJAwQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 20:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjFJAwN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 20:52:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C791730
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 17:52:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569fee67d9dso51178527b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 17:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686358330; x=1688950330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kg21mZWTzPOwmlFSsLi8itlal2bzL2xDdn1UhMA3w20=;
        b=WswYlHq6/ZHkfHrmbeb7arHsRL5XXKC8w3ETG7ZaFzcMXt+WpH/QTKK+jz6PoG+QBq
         uSLDTqnyS2MGajKMA2iGh6RvicQOPQNCY9hKFYLRHors5KSEWpXfWHeYr5OioTJ9AZaR
         g0DySrOCSRUfojMwgtpCy9mXPqIxoJEepKcqLZhGTnqA3PQCrSwPR5Hsc5RogDCN6I7w
         l+YR05Q6aB93INFQnuCul5Nrk+j1ZgV0B8doglxFpMexoWkNgWPW74Kq2jJ5bEy+eIh7
         b6O8jeGG3jRv3NtDrrmAR7MMIAZEBNe5HmVSmu2BiBOyacZdvyi+Qyfe7vjBpuIrhgnd
         Pl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686358330; x=1688950330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kg21mZWTzPOwmlFSsLi8itlal2bzL2xDdn1UhMA3w20=;
        b=Kfwg/htWk3OqupxZOQtCu9HhQlwoWfLYZkbr4cKzBvf/O0i++L5BybkA7zl6eBQNRN
         0UMtdCNl5uKW0dCKzbjn2SXV9a6lpXWVmxswDXA3J1n0TC41WgJklOE1q3AvebbRdONA
         pT9AbUUFoQSsyGbSwxaXYl9j186T+pLDUZo7V/slsU+XvfcyMxaYWUqbD55d69XblDPZ
         mOecz6oyYFZqwQa+eFulIpVyXpzSnGsSh7T7ILrH47NWdVVfapDMElUd6agWTPXfz5rC
         iBJ3QLGQmUA0LTHaam53hY15m22kbomIThkxyGBmXa5Ntmv1q+gdOWk8KQ20nkzwtK2i
         2gMQ==
X-Gm-Message-State: AC+VfDxy0Y2GfX3pCjEZFAIn0ObroQfnd9GdmeaTYM4E5FRsIrrmKvdI
        ttad/aalob6UH7tI9Hfp4HVO2KdUdw==
X-Google-Smtp-Source: ACHHUZ7RszgYDSykFAHyd5I6mFbzO6p8gosaq49TdYgyFazuZ9cddVRnvGvD+puCkZo6ToTL3ooh2Fefzw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:c01:b0:565:d5f6:a390 with SMTP id
 cl1-20020a05690c0c0100b00565d5f6a390mr2450767ywb.2.1686358330655; Fri, 09 Jun
 2023 17:52:10 -0700 (PDT)
Date:   Sat, 10 Jun 2023 00:51:45 +0000
In-Reply-To: <20230610005149.1145665-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230610005149.1145665-3-rmoar@google.com>
Subject: [RFC v1 2/6] kunit: Add speed attribute
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

Currently the categories of speed proposed are: fast, normal, slow, and
very_slow. These are outlined in the enum kunit_speed. Note the speed
attribute can also be left as unset and then, will act as the default which
is "normal", during filtering.

Note speed is intended to be marked based on relative speeds rather than
quantitative speeds of KUnit tests. This is because tests may run on
various architectures at different speeds.

Add the macro KUNIT_CASE_SLOW to set a test as slow, as this is likely a
common use of the attributes API.

Add an example of marking a slow test to kunit-example-test.c.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 include/kunit/test.h           | 31 ++++++++++++++++++++++-
 lib/kunit/attributes.c         | 45 +++++++++++++++++++++++++++++++++-
 lib/kunit/kunit-example-test.c |  9 +++++++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 1fc9155988e9..3d684723ae57 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -63,8 +63,26 @@ enum kunit_status {
 	KUNIT_SKIPPED,
 };
 
+/* Attribute struct/enum definitions */
+
+/*
+ * Speed Attribute is stored as an enum and separated into categories of
+ * speed: very_slowm, slow, normal, and fast. These speeds are relative
+ * to other KUnit tests.
+ */
+enum kunit_speed {
+	KUNIT_SPEED_UNSET,
+	KUNIT_SPEED_VERY_SLOW,
+	KUNIT_SPEED_SLOW,
+	KUNIT_SPEED_NORMAL,
+	KUNIT_SPEED_FAST,
+	KUNIT_SPEED_MAX = KUNIT_SPEED_FAST,
+};
+
 /* Holds attributes for each test case and suite */
-struct kunit_attributes {};
+struct kunit_attributes {
+	enum kunit_speed speed;
+};
 
 /**
  * struct kunit_case - represents an individual test case.
@@ -150,6 +168,17 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
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
index 0ea641be795f..e17889f94693 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -28,9 +28,52 @@ struct kunit_attr {
 	void *attr_default;
 };
 
+/* String Lists for enum Attributes */
+
+static const char * const speed_str_list[] = {"unset", "very_slow", "slow", "normal", "fast"};
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
+/* Attribute Struct Definitions */
+
+static const struct kunit_attr speed_attr = {
+	.name = "speed",
+	.get_attr = attr_speed_get,
+	.to_string = attr_speed_to_string,
+	.attr_default = (void *)KUNIT_SPEED_NORMAL,
+};
+
 /* List of all Test Attributes */
 
-static struct kunit_attr kunit_attr_list[1] = {};
+static struct kunit_attr kunit_attr_list[1] = {speed_attr};
 
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
2.41.0.162.gfafddb0af9-goog

