Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE09074B885
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 23:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGGVKA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 17:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGGVJ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 17:09:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A681FC7
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 14:09:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57320c10635so25486367b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 14:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688764196; x=1691356196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hUcGEqtlluMX6NZEM+7hYDwj/e0I3om+hZITatQmd6E=;
        b=qTGOw2wrPvHH2w4fAaaPPXvirw01AezLvmnN/mEeeSLQBRYryUnE5ca7I+GAH7yBjV
         CETRdi/JS9fkTD6W2qjRS8HzNrxhfb5P/U12D43zEXRi5wMIdh8Vr8r99vCCfWlkc0Oi
         zEyjF0aSeMFFwiiJ1y7+NfIwZ4e1a4dwdkGNJ9oC7og9oQ1+SN5mBc5MyZDxc/O+oFMU
         5NAdQgsQE3dB1bTnO3j5aUBGUbxbJ8eyy2IsMW9kAbHJb9obmm6t9dBH/Tu3BfySHl48
         n/Mle6u+KKUnqjWQX6lBGLW0zmvtUw1/gueuzQbzY0tDzE3vPZFCTRBWcUrue7aWn0Sz
         BZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764196; x=1691356196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUcGEqtlluMX6NZEM+7hYDwj/e0I3om+hZITatQmd6E=;
        b=fHD4MVygIMV+TxDJbURvDvlcaNNnKi+ekvgK5uOEXWm7AS3Jv8zYrQ7PPKfUtdOI2R
         A6JmPFB2z0PTJU6lnJG6X46bY43bHZ45qAJYSabinxrTkol25SLycbcJWGG0q8zbeojK
         WfMK1LQ7UhxTw/4bT1JYnjPH5z8GboGTsHNc7RrPk/kQEZiSQzLnSvN1hEz4y9N3vHg+
         ZISVT697YQU00xjQmSNLjHl+fplR3KLVz6N9t1sve9M5j7OWjNytTup9r+9ovQOWhgBi
         6KmwZbeYpB6crmy2tZ2e0UEz2zPr7arBav2exnQAnMf3qiVoyaHCxlMtxeloYOyLlSGG
         npmw==
X-Gm-Message-State: ABy/qLbrpMw5/Ojt2tdgkXEVrnoWKBqjqOdN5bqZLSKhLFyA0IEMoDJE
        HputeIcsYKe2cGqnBVUJ7O8TVlbZlg==
X-Google-Smtp-Source: APBJJlGRYsFKjLPun9xnFvHpF28LBjYuIAnvKXF/RiVwqGU6vaDv3MSP0aBmLC+xvSEzTR4hjBqVHqTfsQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:404d:0:b0:570:75a8:7867 with SMTP id
 m13-20020a81404d000000b0057075a87867mr44359ywn.4.1688764196315; Fri, 07 Jul
 2023 14:09:56 -0700 (PDT)
Date:   Fri,  7 Jul 2023 21:09:40 +0000
In-Reply-To: <20230707210947.1208717-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707210947.1208717-3-rmoar@google.com>
Subject: [RFC v2 2/9] kunit: Add speed attribute
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

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v1:
- Remove the "fast" category of speed.

 include/kunit/test.h           | 30 +++++++++++++++++++++-
 lib/kunit/attributes.c         | 46 +++++++++++++++++++++++++++++++++-
 lib/kunit/kunit-example-test.c |  9 +++++++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 1fc9155988e9..c255c98a58f7 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -63,8 +63,25 @@ enum kunit_status {
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
@@ -150,6 +167,17 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
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
index 9bda5a5f4030..e97096dbb3b1 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -40,9 +40,53 @@ struct kunit_attr {
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
+/* Attribute Struct Definitions */
+
+static const struct kunit_attr speed_attr = {
+	.name = "speed",
+	.get_attr = attr_speed_get,
+	.to_string = attr_speed_to_string,
+	.attr_default = (void *)KUNIT_SPEED_NORMAL,
+	.print = PRINT_ALWAYS,
+};
+
 /* List of all Test Attributes */
 
-static struct kunit_attr kunit_attr_list[] = {};
+static struct kunit_attr kunit_attr_list[] = {speed_attr};
 
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
2.41.0.255.g8b1d071c50-goog

