Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2407534091
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 May 2022 17:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiEYPpM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 May 2022 11:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245253AbiEYPpC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 May 2022 11:45:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF7F31378
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 08:44:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d7eaa730d9so182014427b3.13
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tmO2qs2LNYzR+TlpvHKwl7wCARa3+s+fYe2/d+I3X6M=;
        b=VoR/WphEp0RSbSVgBmUuQrebaa7xCuolaDuEZS9YoRyE+Gtzx8pYu51VVMV2PMSSiR
         0kZtTYSSwJMc2bZe5gfTztkBVQ8w4ycXSpM2+scxAFn8TUlxWnAGgIbSSLytcEFKzOtu
         wSjSL4c3W0RZSzN2EO+Z7de9uNddCaXmVRU/h7SvAIjPZPGYJeFHQN74Nu2JLpQMiirw
         DLh+4yiN3+XSrKoAgdfQYP2q1GRonpvbYtzZihFLThZohd8FWMjt/EjZNMTcc/dUeRYX
         ovB0K3ueSvglStOjrUbOI2BwDYDI9WTnDMz69lOfBNDfM3Ma+mfHOsh37nqw3zL1nft4
         en/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tmO2qs2LNYzR+TlpvHKwl7wCARa3+s+fYe2/d+I3X6M=;
        b=iCa/hDWQA8Isv0ZS7sXpW9QuXLiPIa0lCrAN596qfc3okaARaqyHdP+hahV/Fxh4kw
         pc1ZCxB8FtqHv0JDOuiEVSGbIe7ra3tB6+1/bRadi9pfIIMqUL2H9S9JFREftPtf7sJQ
         sD2GHmE1Oqqm2h+EQYR1/UnhUUizGMkG1rLzTKXV+MZwAY/f4GyCC/QMjSxLPWcYmDB1
         690ZR18RaxmzjNP3Jq9iQuk01pd5s+YWH/xQIxkOzrQO2Alz7CU50xuURJbot6mAHjKe
         M7YqxzuUCgeR6fY6ozp8Hv14pVzgZTxtABJlzQB5FP4Tmj0FGvAjXZYzKaWXFkGfUyYH
         xsjg==
X-Gm-Message-State: AOAM5319vzB+9qZ3RzW0gW0UyRZZslqjHAhkqMZeosQYwSkRaUuSZcJF
        OUT01u6Orp/I9Ql8uCCGS7rospnfBINuqA==
X-Google-Smtp-Source: ABdhPJyiRpEeVxByFgMFpyHc5M8y7Z+h709UrDEtJPQkcjqn7TgPXBQJQKs5Xi2YSqWqowEtffWMdPAcId2zzg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5bba:b161:2a8a:2ddd])
 (user=dlatypov job=sendgmr) by 2002:a25:3857:0:b0:652:3012:bfc2 with SMTP id
 f84-20020a253857000000b006523012bfc2mr8683767yba.116.1653493498478; Wed, 25
 May 2022 08:44:58 -0700 (PDT)
Date:   Wed, 25 May 2022 08:44:39 -0700
In-Reply-To: <20220525154442.1438081-1-dlatypov@google.com>
Message-Id: <20220525154442.1438081-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220525154442.1438081-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH 1/4] rfc: kunit: remove format func from struct
 kunit_assert, get it to 0 bytes
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     ojeda@kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>
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

Each calll to a KUNIT_EXPECT_*() macro creates a local variable which
contains a struct kunit_assert.

Normally, we'd hope the compiler would be able to optimize this away,
but we've seen cases where it hasn't, see
https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/GbrMNej2BAAJ.

In changes like commit 21957f90b28f ("kunit: split out part of
kunit_assert into a static const"), we've moved more and more parts out
of struct kunit_assert and its children types (kunit_binary_assert).

This patch removes the final field and gets us to:
  sizeof(struct kunit_assert) == 0
  sizeof(struct kunit_binary_assert) == 24 (on UML x86_64).

This also reduces the amount of macro plumbing going on at the cost of
passing in one more arg to the base KUNIT_ASSERTION macro and
kunit_do_failed_assertion().

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/assert.h | 28 ++++++----------------------
 include/kunit/test.h   | 17 +++++++++++------
 lib/kunit/test.c       |  7 ++++---
 3 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 4b52e12c2ae8..aab5b1147df9 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -42,16 +42,15 @@ struct kunit_loc {
 
 /**
  * struct kunit_assert - Data for printing a failed assertion or expectation.
- * @format: a function which formats the data in this kunit_assert to a string.
  *
  * Represents a failed expectation/assertion. Contains all the data necessary to
  * format a string to a user reporting the failure.
  */
-struct kunit_assert {
-	void (*format)(const struct kunit_assert *assert,
-		       const struct va_format *message,
-		       struct string_stream *stream);
-};
+struct kunit_assert {};
+
+typedef void (*assert_format_t)(const struct kunit_assert *assert,
+			        const struct va_format *message,
+				struct string_stream *stream);
 
 void kunit_assert_prologue(const struct kunit_loc *loc,
 			   enum kunit_assert_type type,
@@ -71,16 +70,6 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
 			      const struct va_format *message,
 			      struct string_stream *stream);
 
-/**
- * KUNIT_INIT_FAIL_ASSERT_STRUCT - Initializer for &struct kunit_fail_assert.
- *
- * Initializes a &struct kunit_fail_assert. Intended to be used in
- * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
- */
-#define KUNIT_INIT_FAIL_ASSERT_STRUCT {					\
-	.assert = { .format = kunit_fail_assert_format },		\
-}
-
 /**
  * struct kunit_unary_assert - Represents a KUNIT_{EXPECT|ASSERT}_{TRUE|FALSE}
  * @assert: The parent of this type.
@@ -110,7 +99,6 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
 #define KUNIT_INIT_UNARY_ASSERT_STRUCT(cond, expect_true) {		       \
-	.assert = { .format = kunit_unary_assert_format },		       \
 	.condition = cond,						       \
 	.expected_true = expect_true					       \
 }
@@ -145,7 +133,6 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
 #define KUNIT_INIT_PTR_NOT_ERR_STRUCT(txt, val) {			       \
-	.assert = { .format = kunit_ptr_not_err_assert_format },	       \
 	.text = txt,							       \
 	.value = val							       \
 }
@@ -190,7 +177,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
  * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a binary assert like
  *	kunit_binary_assert, kunit_binary_ptr_assert, etc.
  *
- * @format_func: a function which formats the assert to a string.
  * @text_: Pointer to a kunit_binary_assert_text.
  * @left_val: The actual evaluated value of the expression in the left slot.
  * @right_val: The actual evaluated value of the expression in the right slot.
@@ -200,11 +186,9 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
  * fields but with different types for left_val/right_val.
  * This is ultimately used by binary assertion macros like KUNIT_EXPECT_EQ, etc.
  */
-#define KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,			       \
-					text_,				       \
+#define KUNIT_INIT_BINARY_ASSERT_STRUCT(text_,				       \
 					left_val,			       \
 					right_val) {			       \
-	.assert = { .format = format_func },				       \
 	.text = text_,							       \
 	.left_value = left_val,						       \
 	.right_value = right_val					       \
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8ffcd7de9607..6730734a2216 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -509,9 +509,10 @@ void kunit_do_failed_assertion(struct kunit *test,
 			       const struct kunit_loc *loc,
 			       enum kunit_assert_type type,
 			       const struct kunit_assert *assert,
+			       assert_format_t assert_format,
 			       const char *fmt, ...);
 
-#define KUNIT_ASSERTION(test, assert_type, pass, assert_class, INITIALIZER, fmt, ...) do { \
+#define KUNIT_ASSERTION(test, assert_type, pass, assert_class, assert_format, INITIALIZER, fmt, ...) do { \
 	if (unlikely(!(pass))) {					       \
 		static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;       \
 		struct assert_class __assertion = INITIALIZER;		       \
@@ -519,6 +520,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 					  &__loc,			       \
 					  assert_type,			       \
 					  &__assertion.assert,		       \
+					  assert_format,		       \
 					  fmt,				       \
 					  ##__VA_ARGS__);		       \
 	}								       \
@@ -530,7 +532,8 @@ void kunit_do_failed_assertion(struct kunit *test,
 			assert_type,					       \
 			false,						       \
 			kunit_fail_assert,				       \
-			KUNIT_INIT_FAIL_ASSERT_STRUCT,			       \
+			kunit_fail_assert_format,			       \
+			{},						       \
 			fmt,						       \
 			##__VA_ARGS__)
 
@@ -561,6 +564,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 			assert_type,					       \
 			!!(condition) == !!expected_true,		       \
 			kunit_unary_assert,				       \
+			kunit_unary_assert_format,			       \
 			KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,	       \
 						       expected_true),	       \
 			fmt,						       \
@@ -618,8 +622,8 @@ do {									       \
 			assert_type,					       \
 			__left op __right,				       \
 			assert_class,					       \
-			KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,	       \
-							&__text,	       \
+			format_func,					       \
+			KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,	       \
 							__left,		       \
 							__right),	       \
 			fmt,						       \
@@ -676,8 +680,8 @@ do {									       \
 			assert_type,					       \
 			strcmp(__left, __right) op 0,			       \
 			kunit_binary_str_assert,			       \
-			KUNIT_INIT_BINARY_ASSERT_STRUCT(kunit_binary_str_assert_format,\
-							&__text,	       \
+			kunit_binary_str_assert_format,			       \
+			KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,	       \
 							__left,		       \
 							__right),	       \
 			fmt,						       \
@@ -696,6 +700,7 @@ do {									       \
 			assert_type,					       \
 			!IS_ERR_OR_NULL(__ptr),				       \
 			kunit_ptr_not_err_assert,			       \
+			kunit_ptr_not_err_assert_format,		       \
 			KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr,		       \
 						      __ptr),		       \
 			fmt,						       \
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index a5053a07409f..3845765e3a80 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -245,7 +245,7 @@ static void kunit_print_string_stream(struct kunit *test,
 
 static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
 		       enum kunit_assert_type type, const struct kunit_assert *assert,
-		       const struct va_format *message)
+		       assert_format_t assert_format, const struct va_format *message)
 {
 	struct string_stream *stream;
 
@@ -261,7 +261,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
 	}
 
 	kunit_assert_prologue(loc, type, stream);
-	assert->format(assert, message, stream);
+	assert_format(assert, message, stream);
 
 	kunit_print_string_stream(test, stream);
 
@@ -285,6 +285,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 			       const struct kunit_loc *loc,
 			       enum kunit_assert_type type,
 			       const struct kunit_assert *assert,
+			       assert_format_t assert_format,
 			       const char *fmt, ...)
 {
 	va_list args;
@@ -294,7 +295,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 	message.fmt = fmt;
 	message.va = &args;
 
-	kunit_fail(test, loc, type, assert, &message);
+	kunit_fail(test, loc, type, assert, assert_format, &message);
 
 	va_end(args);
 
-- 
2.36.1.124.g0e6072fb45-goog

