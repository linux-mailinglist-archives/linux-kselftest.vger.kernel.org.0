Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4E5F175B
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 02:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiJAA1Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 20:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiJAA1A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 20:27:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBA81CF
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 17:26:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y5-20020a25bb85000000b006af8f244604so5115653ybg.7
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 17:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=NEg2UNzhugdAp054uzB1fjyZlTKV+IDmlPKtVI1Rou4=;
        b=DC9XtIzCxpTKCO6GS4PJLU8yLC6nZUZ81Xq/XkgrjTOFfSEnxSueP+PxaqX6MRpQNo
         wJuFToy4coT1kB9n/j7i+aJikBGzzYcYz7O/Nhbjv0objPyqomYpaPBHIEz6CdQtWQtU
         m16zhORNmSoiMauyBaRZEy0HeeI8zdCryXHACZagr+tjhvoy4apexvOtD/PPIHAdy8dM
         f3kdzSeFaJQGfwQpr/7Ddzp//lsQbyXoCu90tz5YWmzob2UV0sB6IqU2iH38/Lh0kwr3
         SngsM3HaZPWrJh8fhYu8Bzlv2abb+f22GcJ7luH6yIST9jy6ZisZgYZO/CtVjSkgbyHz
         lgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=NEg2UNzhugdAp054uzB1fjyZlTKV+IDmlPKtVI1Rou4=;
        b=B+Y9YFhRU2sTO5aylVXUWuGauarJWKqGymGzN7lfPdHmiEzUOf4jNI4SICHs48kGxb
         Ixw/3Ai8GRW6T/2rZ0lr1Vy6gL4NigM4WEgQUyyqp5lRrwcH3NDW9/IqjNR4XyQmsxQ5
         hu678Yh97bysUMTIg+BZoOUYQgP7g7rgpcI5VIc6Dn0dWdB/FEUqpx7CrNxO3xgg8aQu
         64AePuMGK7SuGQ0yfopH56nkXN4ABBvMq5ehTD0N1SoZ8R5MBOH3z0oakalrR7xrODb4
         QwCR7+41fq/Yk5ExSaItZjEWOa8eU/7jl8f01U88KwosTDlsLoBH9Zzs47wVjXJ3qJkP
         KYGQ==
X-Gm-Message-State: ACrzQf15RTIqlGxRGC5iFQMG/UJCV0yuy4Q1HosXt82HeQ1UjJ5tgefN
        iWZEDKBSifYHBDiiTjWOQN/+D/Uk96wSmg==
X-Google-Smtp-Source: AMsMyM5+EXF3DUU8+VvZr1/7b/bGHnSKI8SVwNHpkpimiQlJaZuEPPsQs+WThQ/7g7BoiOCU/RnkEyiL43I38A==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a25:af48:0:b0:6a9:455a:ff10 with SMTP id
 c8-20020a25af48000000b006a9455aff10mr10736229ybj.84.1664584008001; Fri, 30
 Sep 2022 17:26:48 -0700 (PDT)
Date:   Fri, 30 Sep 2022 17:26:35 -0700
In-Reply-To: <20221001002638.2881842-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001002638.2881842-2-dlatypov@google.com>
Subject: [PATCH 1/4] kunit: remove format func from struct kunit_assert, get
 it to 0 bytes
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        miguel.ojeda.sandonis@gmail.com,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
index 4b52e12c2ae8..ace3de8d1ee7 100644
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
+				const struct va_format *message,
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
index 840a2c375065..3476549106f7 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -472,9 +472,10 @@ void kunit_do_failed_assertion(struct kunit *test,
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
@@ -482,6 +483,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 					  &__loc,			       \
 					  assert_type,			       \
 					  &__assertion.assert,		       \
+					  assert_format,		       \
 					  fmt,				       \
 					  ##__VA_ARGS__);		       \
 	}								       \
@@ -493,7 +495,8 @@ void kunit_do_failed_assertion(struct kunit *test,
 			assert_type,					       \
 			false,						       \
 			kunit_fail_assert,				       \
-			KUNIT_INIT_FAIL_ASSERT_STRUCT,			       \
+			kunit_fail_assert_format,			       \
+			{},						       \
 			fmt,						       \
 			##__VA_ARGS__)
 
@@ -524,6 +527,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 			assert_type,					       \
 			!!(condition) == !!expected_true,		       \
 			kunit_unary_assert,				       \
+			kunit_unary_assert_format,			       \
 			KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,	       \
 						       expected_true),	       \
 			fmt,						       \
@@ -581,8 +585,8 @@ do {									       \
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
@@ -639,8 +643,8 @@ do {									       \
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
@@ -659,6 +663,7 @@ do {									       \
 			assert_type,					       \
 			!IS_ERR_OR_NULL(__ptr),				       \
 			kunit_ptr_not_err_assert,			       \
+			kunit_ptr_not_err_assert_format,		       \
 			KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr,		       \
 						      __ptr),		       \
 			fmt,						       \
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index b73d5bb5c473..53bf1793f915 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -247,7 +247,7 @@ static void kunit_print_string_stream(struct kunit *test,
 
 static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
 		       enum kunit_assert_type type, const struct kunit_assert *assert,
-		       const struct va_format *message)
+		       assert_format_t assert_format, const struct va_format *message)
 {
 	struct string_stream *stream;
 
@@ -263,7 +263,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
 	}
 
 	kunit_assert_prologue(loc, type, stream);
-	assert->format(assert, message, stream);
+	assert_format(assert, message, stream);
 
 	kunit_print_string_stream(test, stream);
 
@@ -287,6 +287,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 			       const struct kunit_loc *loc,
 			       enum kunit_assert_type type,
 			       const struct kunit_assert *assert,
+			       assert_format_t assert_format,
 			       const char *fmt, ...)
 {
 	va_list args;
@@ -296,7 +297,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 	message.fmt = fmt;
 	message.va = &args;
 
-	kunit_fail(test, loc, type, assert, &message);
+	kunit_fail(test, loc, type, assert, assert_format, &message);
 
 	va_end(args);
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

