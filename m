Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB9275A1C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 00:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGSWYD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 18:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjGSWYA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 18:24:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C722118
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 15:23:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c6db61f7f64so123693276.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 15:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689805436; x=1692397436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd3boOdAlfH2nRM3+RX0LZSIemRKG8MVf9sKC/jWVn8=;
        b=ZxrsLCF8zArTqOVJ6JX4jfVhGjbQDfz604yPryk2p5bCmj3ZcxkurE6OosjJIz2dqe
         1wrHH00+ExltFh++DlxRaxwseeAZaN/WsUt4cc18viWQTwhfQNhUOD6xiH8fAFt546wk
         /Lwjx6v4/dapgFODMZg9a4bTtx0vMOXdxBluDQi6ZPE6ZULysdMCV9jn4M4xXEjamXaX
         QOPS7HCzF0iImxVDcPXS0qWQiWnVUwVoLrvU0zzVb0CNZWBs9BYywXExdHg9fxrc4HJZ
         NtXX1MKs05AABQQ/0jjgKpU2J1Mwfoz2JcXiAGPwWN3UD+1etnHzP4AYg0Psx0SKTCEi
         pt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805436; x=1692397436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd3boOdAlfH2nRM3+RX0LZSIemRKG8MVf9sKC/jWVn8=;
        b=l4plhsG4e3PE9YXlQAp4mwkrJcx2hrcYCsUhwM2a0eIJ964UFsPwq04RxGugJszGd6
         XNU4xppYPDssozgQlLxPS3XwnCDcPfEuh4uGS2YRwisRg3HDKVv4WUWV12OZ7K5Y2/ts
         L39FUsXK2nxm6gbJAuY1kxlELlDV6oQKnriFtc93lHqD6Kvq4T6pH8D3f+q1BbO9vcY8
         zZRAI0hDPpiHPuDDqMh2uqHT4YEONOiovSoQbzrFsLfTlPM1yXra/OUk1EMPiVTaBwCr
         pcqTFtD/l863R8ebpoON8wkpEmDr85GKGoIiZJ0V+MeTwb+kXkX5ZaIcoNzTbFXDghq2
         IrfA==
X-Gm-Message-State: ABy/qLaOvveZAuGC2DceUTEALmF834ZPT2YCMUlYaULEDY3qZAaZLsHu
        IbaGZM7f6rgHq8ZCJ/TN2JWKwZx0AA==
X-Google-Smtp-Source: APBJJlFJoNuU+UE39XO0UaovGMTShePgnxiZ3V2UQyVVMe70Tv1/5UzXVkg/ZqQ+UXDG89ufoC3XGwimcA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:ab04:0:b0:bfe:ea69:91b4 with SMTP id
 u4-20020a25ab04000000b00bfeea6991b4mr29862ybi.4.1689805436512; Wed, 19 Jul
 2023 15:23:56 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:23:30 +0000
In-Reply-To: <20230719222338.259684-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230719222338.259684-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719222338.259684-4-rmoar@google.com>
Subject: [PATCH v1 3/9] kunit: Add module attribute
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

Changes since RFC v2:
- No changes.

Changes: since RFC v1:
- This is a new patch.

 include/kunit/test.h   | 13 ++++++++-----
 lib/kunit/attributes.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 6 deletions(-)

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

