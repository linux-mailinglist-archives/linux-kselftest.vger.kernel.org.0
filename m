Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD4174B886
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 23:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjGGVKC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 17:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGGVKB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 17:10:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED5B2128
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 14:09:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c64ef5bde93so2385395276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688764198; x=1691356198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4/N3lql+QjOhywr0kUr+CykzU7mEjW+9OvJReKSAxY=;
        b=gpXSScKDfQA7qE+/XPGnr89Eo7bWM+xw6GP7QYWjGkJdHCNbN5XrEZnTN6OVsb/6Bk
         +yHByH5qifyNlgiM4Rzq6Zelc7aTJ759crIvvjwPE6ULrrzHFZavWsUYP/QktM1WuEmJ
         JqSXV5IkIbM5ecTgi94VfHUwNAhSeKS3UuJJ/K7aIuv0eByalRZIM0ju/HuXJYQ7pnzg
         2Ld6acTY9R2amfjsCPyQ44ZJH7QPgloufM5XTPB9NtyDdvMyzlHUFF5xpUDJp6pWQ6MC
         pIjfxNbV3VQGYtGwNNQZk/bxKn2Lt7Vx8LIjJDnbZFaG9wvXmMdNZ3Osp6V3s3fE97yS
         47ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764198; x=1691356198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4/N3lql+QjOhywr0kUr+CykzU7mEjW+9OvJReKSAxY=;
        b=KOhPfKpi9x4jNy5LGUhrT82ud3Gul+uvlmlIgZCHhryzQ21VGdDXZDetojXBeft1LA
         J1cMFxj6vbtxQH4UXDphm9uComhkguvMxZ8uZioukMPmt9MMwVXVdum2KO/TnocUbEzm
         8vDmwxwQvFY/Zzgh093dqeOyb43J6MRUpQDQBvtE4Ug1GC25Z4Q2ZQUeWsryJx5OABaT
         beR7EJZ9XoMmg36lfn3Vms6EJED/BG03GtAsxtUcBpxJlqGnXyxbMdfnJxOtaLxxKj4r
         mqbvwwCCo7pYnKnaxBTF5J+RWDq/mC5PigSrEBrOGcm0debDP/xiRtrfkEYb0eNpPHqG
         F3Cw==
X-Gm-Message-State: ABy/qLarsk/zuukaBwHbyO2zZJIuOeNE0MtFAbLSFGRffNIutA1w6rCq
        bVKaRG76jvTiekrbzEGfoJg++NYGvQ==
X-Google-Smtp-Source: APBJJlEuJchtfIn6B8DmRbOZ5306C1gjdqjJaBCAHSYG7F59XZWqpKPjGag7UZ0TnY5JDYiGys/6snhISg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a5b:bc1:0:b0:c4e:3060:41f9 with SMTP id
 c1-20020a5b0bc1000000b00c4e306041f9mr58815ybr.9.1688764198480; Fri, 07 Jul
 2023 14:09:58 -0700 (PDT)
Date:   Fri,  7 Jul 2023 21:09:41 +0000
In-Reply-To: <20230707210947.1208717-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707210947.1208717-4-rmoar@google.com>
Subject: [RFC v2 3/9] kunit: Add module attribute
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

Add module attribute to the test attribute API. This attribute stores the
module name associated with the test using KBUILD_MODNAME.

The name of a test suite and the module name often do not match. A
reference to the module name associated with the suite could be extremely
helpful in running tests as modules without needing to check the codebase.

This attribute will be printed for each suite.

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes: since v1:
- This is a new patch.

 include/kunit/test.h   | 13 ++++++++-----
 lib/kunit/attributes.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index c255c98a58f7..cdfc3f42e899 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -129,6 +129,7 @@ struct kunit_case {
 
 	/* private: internal use only. */
 	enum kunit_status status;
+	char *module_name;
 	char *log;
 };
 
@@ -153,7 +154,9 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  * &struct kunit_case object from it. See the documentation for
  * &struct kunit_case for an example on how to use it.
  */
-#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
+#define KUNIT_CASE(test_name)			\
+		{ .run_case = test_name, .name = #test_name,	\
+		  .module_name = KBUILD_MODNAME}
 
 /**
  * KUNIT_CASE_ATTR - A helper for creating a &struct kunit_case
@@ -165,7 +168,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  */
 #define KUNIT_CASE_ATTR(test_name, attributes)			\
 		{ .run_case = test_name, .name = #test_name,	\
-		  .attr = attributes }
+		  .attr = attributes, .module_name = KBUILD_MODNAME}
 
 /**
  * KUNIT_CASE_SLOW - A helper for creating a &struct kunit_case
@@ -176,7 +179,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
 
 #define KUNIT_CASE_SLOW(test_name)			\
 		{ .run_case = test_name, .name = #test_name,	\
-		  .attr.speed = KUNIT_SPEED_SLOW }
+		  .attr.speed = KUNIT_SPEED_SLOW, .module_name = KBUILD_MODNAME}
 
 /**
  * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
@@ -197,7 +200,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  */
 #define KUNIT_CASE_PARAM(test_name, gen_params)			\
 		{ .run_case = test_name, .name = #test_name,	\
-		  .generate_params = gen_params }
+		  .generate_params = gen_params, .module_name = KBUILD_MODNAME}
 
 /**
  * KUNIT_CASE_PARAM_ATTR - A helper for creating a parameterized &struct
@@ -211,7 +214,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
 #define KUNIT_CASE_PARAM_ATTR(test_name, gen_params, attributes)	\
 		{ .run_case = test_name, .name = #test_name,	\
 		  .generate_params = gen_params,				\
-		  .attr = attributes }
+		  .attr = attributes, .module_name = KBUILD_MODNAME}
 
 /**
  * struct kunit_suite - describes a related collection of &struct kunit_case
diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index e97096dbb3b1..43dcb5de8b8f 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -61,6 +61,12 @@ static const char *attr_speed_to_string(void *attr, bool *to_free)
 	return attr_enum_to_string(attr, speed_str_list, to_free);
 }
 
+static const char *attr_string_to_string(void *attr, bool *to_free)
+{
+	*to_free = false;
+	return (char *) attr;
+}
+
 /* Get Attribute Methods */
 
 static void *attr_speed_get(void *test_or_suite, bool is_test)
@@ -74,6 +80,18 @@ static void *attr_speed_get(void *test_or_suite, bool is_test)
 		return ((void *) suite->attr.speed);
 }
 
+static void *attr_module_get(void *test_or_suite, bool is_test)
+{
+	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
+	struct kunit_case *test = is_test ? test_or_suite : NULL;
+
+	// Suites get their module attribute from their first test_case
+	if (test)
+		return ((void *) test->module_name);
+	else
+		return ((void *) suite->test_cases[0].module_name);
+}
+
 /* Attribute Struct Definitions */
 
 static const struct kunit_attr speed_attr = {
@@ -84,9 +102,17 @@ static const struct kunit_attr speed_attr = {
 	.print = PRINT_ALWAYS,
 };
 
+static const struct kunit_attr module_attr = {
+	.name = "module",
+	.get_attr = attr_module_get,
+	.to_string = attr_string_to_string,
+	.attr_default = (void *)"",
+	.print = PRINT_SUITE,
+};
+
 /* List of all Test Attributes */
 
-static struct kunit_attr kunit_attr_list[] = {speed_attr};
+static struct kunit_attr kunit_attr_list[] = {speed_attr, module_attr};
 
 /* Helper Functions to Access Attributes */
 
-- 
2.41.0.255.g8b1d071c50-goog

