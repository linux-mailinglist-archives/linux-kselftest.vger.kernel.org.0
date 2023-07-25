Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6DF762452
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 23:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjGYVZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 17:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjGYVZf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 17:25:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B89A1FE6
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-564fb1018bcso72150587b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690320333; x=1690925133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQABQp9/fgq5do2PMDLxADuXEdETdAo+fTGFrKhT3xM=;
        b=jflwaAyedN/44AlTS/1LBQZ2iOctYb54voSmLUC7KqyJwqTDzemtXJi2RUu0W8uF0B
         Zn+c1hipTe94C17FmEdWXbpbkMZ0V1gPdMeobJE/K55o8vVB7nvNd/nsXkEBknQUwuRo
         NjP/M1egHlpX69ETuSa/AYPlS18wxOxne37oLti2YRj1roxxT8YsJQC57oCJ1hb5rBPG
         nGsMO3FE26jfPLXiCtnb4LCz2vWcYgkUysEGZNtRn1uQiGIacB4U1akaMInllMJeoCNA
         fl3uBVC4v/xCr6Myn3tv5jLaCk9sN5VJumemnf9MXeofRTPYb5ylW7USeqPG0jc9OC5e
         PeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320333; x=1690925133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQABQp9/fgq5do2PMDLxADuXEdETdAo+fTGFrKhT3xM=;
        b=Jy90a26IjYIQfJZvuVxzaYTNiSMGwp1IL04ItS+171nHDrv4DtOS64PxRcLJCTQEVI
         L+T0vIychZGcaOV6Z8Z/MSXn6Trw5P/nwGPSCWOg2K3m6HdRkDb/H2iweOyRQ3KquyVh
         kCdCvaQ4k0Xt9XuSw962HYCiqfUcvyK0sWYkIwrXLz5dnCgoTSbHHKY+yTRPqHFDJCBh
         iyr+P2sOStZCzQtgwyT/t/pHOUVfd+E31ynVSTF/PTtfMDw0uDD1k+Tsslk+7vzgNP1a
         7zSXE0DBnMC2C+/iDOhuUm/u0vU5ESe6/xA0fEsp6OjltP4Nawhh4JiEhn21FIFgXNbE
         JKAg==
X-Gm-Message-State: ABy/qLatjgQjgj2gEPBQZSYvx1+t1o0mYxl4ETJNukdpLUxx4Zt26LmI
        Ivf+RyTcFj0Wans63F8sTjNJKfHJWg==
X-Google-Smtp-Source: APBJJlHlirou98NBt4AkCpdrgz6nHsMm8KPUoNreSfSI1YkyEZ/9+IhgTHHhe1LAkpBK0VKXMvnLxQR1JA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:db84:0:b0:d0a:86fc:536c with SMTP id
 g126-20020a25db84000000b00d0a86fc536cmr1183ybf.2.1690320333783; Tue, 25 Jul
 2023 14:25:33 -0700 (PDT)
Date:   Tue, 25 Jul 2023 21:25:14 +0000
In-Reply-To: <20230725212522.1622716-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230725212522.1622716-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725212522.1622716-4-rmoar@google.com>
Subject: [PATCH v3 3/9] kunit: Add module attribute
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

Add module attribute to the test attribute API. This attribute stores the
module name associated with the test using KBUILD_MODNAME.

The name of a test suite and the module name often do not match. A
reference to the module name associated with the suite could be extremely
helpful in running tests as modules without needing to check the codebase.

This attribute will be printed for each suite.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v2:
- No changes.
Changes since v1:
- Change kunit_attr_list definition to fix compile error
Changes since RFC v2:
- No changes.
Changes: since RFC v1:
- This is a new patch.

 include/kunit/test.h   | 13 ++++++++-----
 lib/kunit/attributes.c | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index ed5f5000a095..011e0d6bb506 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -131,6 +131,7 @@ struct kunit_case {
 
 	/* private: internal use only. */
 	enum kunit_status status;
+	char *module_name;
 	char *log;
 };
 
@@ -155,7 +156,9 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  * &struct kunit_case object from it. See the documentation for
  * &struct kunit_case for an example on how to use it.
  */
-#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
+#define KUNIT_CASE(test_name)			\
+		{ .run_case = test_name, .name = #test_name,	\
+		  .module_name = KBUILD_MODNAME}
 
 /**
  * KUNIT_CASE_ATTR - A helper for creating a &struct kunit_case
@@ -167,7 +170,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  */
 #define KUNIT_CASE_ATTR(test_name, attributes)			\
 		{ .run_case = test_name, .name = #test_name,	\
-		  .attr = attributes }
+		  .attr = attributes, .module_name = KBUILD_MODNAME}
 
 /**
  * KUNIT_CASE_SLOW - A helper for creating a &struct kunit_case
@@ -178,7 +181,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
 
 #define KUNIT_CASE_SLOW(test_name)			\
 		{ .run_case = test_name, .name = #test_name,	\
-		  .attr.speed = KUNIT_SPEED_SLOW }
+		  .attr.speed = KUNIT_SPEED_SLOW, .module_name = KBUILD_MODNAME}
 
 /**
  * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
@@ -199,7 +202,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  */
 #define KUNIT_CASE_PARAM(test_name, gen_params)			\
 		{ .run_case = test_name, .name = #test_name,	\
-		  .generate_params = gen_params }
+		  .generate_params = gen_params, .module_name = KBUILD_MODNAME}
 
 /**
  * KUNIT_CASE_PARAM_ATTR - A helper for creating a parameterized &struct
@@ -213,7 +216,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
 #define KUNIT_CASE_PARAM_ATTR(test_name, gen_params, attributes)	\
 		{ .run_case = test_name, .name = #test_name,	\
 		  .generate_params = gen_params,				\
-		  .attr = attributes }
+		  .attr = attributes, .module_name = KBUILD_MODNAME}
 
 /**
  * struct kunit_suite - describes a related collection of &struct kunit_case
diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index ffd0d692b334..9dce4f4d726c 100644
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
 /* List of all Test Attributes */
 
 static struct kunit_attr kunit_attr_list[] = {
@@ -84,6 +102,13 @@ static struct kunit_attr kunit_attr_list[] = {
 		.attr_default = (void *)KUNIT_SPEED_NORMAL,
 		.print = PRINT_ALWAYS,
 	},
+	{
+		.name = "module",
+		.get_attr = attr_module_get,
+		.to_string = attr_string_to_string,
+		.attr_default = (void *)"",
+		.print = PRINT_SUITE,
+	}
 };
 
 /* Helper Functions to Access Attributes */
-- 
2.41.0.487.g6d72f3e995-goog

