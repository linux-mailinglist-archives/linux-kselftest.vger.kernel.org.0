Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC16749BD95
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 22:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiAYVA3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 16:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiAYVA2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 16:00:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB58BC061744
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 13:00:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c76-20020a25c04f000000b00613e2c514e2so39848009ybf.21
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 13:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R688BOqi998uMoUSe2juA24py6qr+QQ9+6E7CfL0h8w=;
        b=JFhHSdXUQYauV/isv6gWaTwFc3y10s4IjXdSUwzkw0WiuFrKaTYBS4o+LM1RIlgji6
         rraWdg2LzkfuwAeYOY5IdW/ZXCH/vAj7gpHKtrTRSm2NA5Tl/XhcajW+SD0ZyR7PJI2R
         0r2JN5VHisqSAta6jP82zPEZrUPG6YXjJX4sKJfm9vAeR0yyquLwtt0oNg/zkrc5V8gb
         ZORckA+ZmDlUC1s/liB0dK5/NW9vBehJUeeJo4lFs7m2Je8ZJJ8TtaIHRjGhFAs9qFW3
         gSnMdIujZMj+/Fum6YVGt4NhlJ5bk9O6hpN8tawYOUY3k9ju6lyxY0I6sHNXpAD8r2U/
         NGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R688BOqi998uMoUSe2juA24py6qr+QQ9+6E7CfL0h8w=;
        b=JAGX7wNB3G8lY48C4DYl7RCzOcE0h+jixOg8vOaQFcKo1QwoRp7z2njU2uuhskfrWJ
         xDOa7rd71tWwUkmVMMdtNTaMUIvF/glZTEZv8OU5epv7v2TIgFboUPA7tMbTLY70RIbh
         cRM4L50sR1pdxHVxPie8joNr/Wk07s67fuh27bANpuUE3lL9fFzQS2uiZ4hAkZnffGS9
         VFWILCum3W2dlegPrZ7c4vblN7IBWBbOExzQyfmE0s8WmkeQpuMGx2zuwIW0I2g02dYx
         sz6NIRXOYX5o1wYnWb4YD4j/IKE960D2C7IAtpcHA++IkeoLMnmxFJtd41W5ggsPNOZj
         xQ4w==
X-Gm-Message-State: AOAM533SZne7P4+9VQd5lSWuYsjvFurWHjsTJjhBg4yTVheHFoQDcFUg
        MMH2S3klmWOWCGCONTosNQbHDEPMEd/GZA==
X-Google-Smtp-Source: ABdhPJxnH0p+sBicrChT+vSCovp7VfdTanYniynyWttkJQ8CisUZuDOl1bTO01iplZPiPudkgkAOqHaDJcgr+w==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:ec63:7812:5e4a:c688])
 (user=dlatypov job=sendgmr) by 2002:a25:70d5:: with SMTP id
 l204mr33815488ybc.193.1643144427159; Tue, 25 Jan 2022 13:00:27 -0800 (PST)
Date:   Tue, 25 Jan 2022 13:00:09 -0800
In-Reply-To: <20220125210011.3817742-1-dlatypov@google.com>
Message-Id: <20220125210011.3817742-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220125210011.3817742-1-dlatypov@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH 1/3] kunit: remove va_format from kunit_assert
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The concern is that having a lot of redundant fields in kunit_assert can
blow up stack usage if the compiler doesn't optimize them away [1].

The comment on this field implies that it was meant to be initialized
when the expect/assert was declared, but this only happens when we run
kunit_do_failed_assertion().

We don't need to access it outside of that function, so move it out of
the struct and make it a local variable there.

This change also takes the chance to reduce the number of macros by
inlining the now simplified KUNIT_INIT_ASSERT_STRUCT() macro.

[1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/assert.h | 43 +++++++++++++-----------------------------
 lib/kunit/assert.c     | 27 +++++++++++++++-----------
 lib/kunit/test.c       | 12 +++++++-----
 3 files changed, 36 insertions(+), 46 deletions(-)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index f2b3ae5cc2de..0b3704db54b6 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -42,44 +42,21 @@ struct kunit_loc {
 
 /**
  * struct kunit_assert - Data for printing a failed assertion or expectation.
- * @message: an optional message to provide additional context.
  * @format: a function which formats the data in this kunit_assert to a string.
  *
  * Represents a failed expectation/assertion. Contains all the data necessary to
  * format a string to a user reporting the failure.
  */
 struct kunit_assert {
-	struct va_format message;
 	void (*format)(const struct kunit_assert *assert,
+		       const struct va_format *message,
 		       struct string_stream *stream);
 };
 
-/**
- * KUNIT_INIT_VA_FMT_NULL - Default initializer for struct va_format.
- *
- * Used inside a struct initialization block to initialize struct va_format to
- * default values where fmt and va are null.
- */
-#define KUNIT_INIT_VA_FMT_NULL { .fmt = NULL, .va = NULL }
-
-/**
- * KUNIT_INIT_ASSERT_STRUCT() - Initializer for a &struct kunit_assert.
- * @fmt: The formatting function which builds a string out of this kunit_assert.
- *
- * The base initializer for a &struct kunit_assert.
- */
-#define KUNIT_INIT_ASSERT_STRUCT(fmt) {					       \
-	.message = KUNIT_INIT_VA_FMT_NULL,				       \
-	.format = fmt							       \
-}
-
 void kunit_assert_prologue(const struct kunit_loc *loc,
 			   enum kunit_assert_type type,
 			   struct string_stream *stream);
 
-void kunit_assert_print_msg(const struct kunit_assert *assert,
-			    struct string_stream *stream);
-
 /**
  * struct kunit_fail_assert - Represents a plain fail expectation/assertion.
  * @assert: The parent of this type.
@@ -91,6 +68,7 @@ struct kunit_fail_assert {
 };
 
 void kunit_fail_assert_format(const struct kunit_assert *assert,
+			      const struct va_format *message,
 			      struct string_stream *stream);
 
 /**
@@ -100,7 +78,7 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
 #define KUNIT_INIT_FAIL_ASSERT_STRUCT {					\
-	.assert = KUNIT_INIT_ASSERT_STRUCT(kunit_fail_assert_format)	\
+	.assert = { .format = kunit_fail_assert_format },		\
 }
 
 /**
@@ -120,6 +98,7 @@ struct kunit_unary_assert {
 };
 
 void kunit_unary_assert_format(const struct kunit_assert *assert,
+			       const struct va_format *message,
 			       struct string_stream *stream);
 
 /**
@@ -131,7 +110,7 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
 #define KUNIT_INIT_UNARY_ASSERT_STRUCT(cond, expect_true) {		       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(kunit_unary_assert_format),	       \
+	.assert = { .format = kunit_unary_assert_format },		       \
 	.condition = cond,						       \
 	.expected_true = expect_true					       \
 }
@@ -153,6 +132,7 @@ struct kunit_ptr_not_err_assert {
 };
 
 void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
+				     const struct va_format *message,
 				     struct string_stream *stream);
 
 /**
@@ -165,7 +145,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
 #define KUNIT_INIT_PTR_NOT_ERR_STRUCT(txt, val) {			       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(kunit_ptr_not_err_assert_format),   \
+	.assert = { .format = kunit_ptr_not_err_assert_format },	       \
 	.text = txt,							       \
 	.value = val							       \
 }
@@ -194,6 +174,7 @@ struct kunit_binary_assert {
 };
 
 void kunit_binary_assert_format(const struct kunit_assert *assert,
+				const struct va_format *message,
 				struct string_stream *stream);
 
 /**
@@ -213,7 +194,7 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 					left_val,			       \
 					right_str,			       \
 					right_val) {			       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_assert_format),	       \
+	.assert = { .format = kunit_binary_assert_format },		       \
 	.operation = op_str,						       \
 	.left_text = left_str,						       \
 	.left_value = left_val,						       \
@@ -245,6 +226,7 @@ struct kunit_binary_ptr_assert {
 };
 
 void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
+				    const struct va_format *message,
 				    struct string_stream *stream);
 
 /**
@@ -265,7 +247,7 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 					    left_val,			       \
 					    right_str,			       \
 					    right_val) {		       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_ptr_assert_format),    \
+	.assert = { .format = kunit_binary_ptr_assert_format },		       \
 	.operation = op_str,						       \
 	.left_text = left_str,						       \
 	.left_value = left_val,						       \
@@ -297,6 +279,7 @@ struct kunit_binary_str_assert {
 };
 
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
+				    const struct va_format *message,
 				    struct string_stream *stream);
 
 /**
@@ -316,7 +299,7 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 					    left_val,			       \
 					    right_str,			       \
 					    right_val) {		       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_str_assert_format),    \
+	.assert = { .format = kunit_binary_str_assert_format },		       \
 	.operation = op_str,						       \
 	.left_text = left_str,						       \
 	.left_value = left_val,						       \
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 9f4492a8e24e..c9c7ee0dfafa 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -30,22 +30,23 @@ void kunit_assert_prologue(const struct kunit_loc *loc,
 }
 EXPORT_SYMBOL_GPL(kunit_assert_prologue);
 
-void kunit_assert_print_msg(const struct kunit_assert *assert,
-			    struct string_stream *stream)
+static void kunit_assert_print_msg(const struct va_format *message,
+				   struct string_stream *stream)
 {
-	if (assert->message.fmt)
-		string_stream_add(stream, "\n%pV", &assert->message);
+	if (message->fmt)
+		string_stream_add(stream, "\n%pV", message);
 }
-EXPORT_SYMBOL_GPL(kunit_assert_print_msg);
 
 void kunit_fail_assert_format(const struct kunit_assert *assert,
+			      const struct va_format *message,
 			      struct string_stream *stream)
 {
-	string_stream_add(stream, "%pV", &assert->message);
+	string_stream_add(stream, "%pV", message);
 }
 EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
 
 void kunit_unary_assert_format(const struct kunit_assert *assert,
+			       const struct va_format *message,
 			       struct string_stream *stream)
 {
 	struct kunit_unary_assert *unary_assert;
@@ -60,11 +61,12 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 		string_stream_add(stream,
 				  KUNIT_SUBTEST_INDENT "Expected %s to be false, but is true\n",
 				  unary_assert->condition);
-	kunit_assert_print_msg(assert, stream);
+	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_unary_assert_format);
 
 void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
+				     const struct va_format *message,
 				     struct string_stream *stream)
 {
 	struct kunit_ptr_not_err_assert *ptr_assert;
@@ -82,7 +84,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 				  ptr_assert->text,
 				  PTR_ERR(ptr_assert->value));
 	}
-	kunit_assert_print_msg(assert, stream);
+	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
 
@@ -110,6 +112,7 @@ static bool is_literal(struct kunit *test, const char *text, long long value,
 }
 
 void kunit_binary_assert_format(const struct kunit_assert *assert,
+				const struct va_format *message,
 				struct string_stream *stream)
 {
 	struct kunit_binary_assert *binary_assert;
@@ -132,11 +135,12 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
 				  binary_assert->right_text,
 				  binary_assert->right_value);
-	kunit_assert_print_msg(assert, stream);
+	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
 
 void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
+				    const struct va_format *message,
 				    struct string_stream *stream)
 {
 	struct kunit_binary_ptr_assert *binary_assert;
@@ -155,7 +159,7 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px",
 			  binary_assert->right_text,
 			  binary_assert->right_value);
-	kunit_assert_print_msg(assert, stream);
+	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
 
@@ -176,6 +180,7 @@ static bool is_str_literal(const char *text, const char *value)
 }
 
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
+				    const struct va_format *message,
 				    struct string_stream *stream)
 {
 	struct kunit_binary_str_assert *binary_assert;
@@ -196,6 +201,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"",
 				  binary_assert->right_text,
 				  binary_assert->right_value);
-	kunit_assert_print_msg(assert, stream);
+	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 7dec3248562f..3bca3bf5c15b 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -241,7 +241,8 @@ static void kunit_print_string_stream(struct kunit *test,
 }
 
 static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
-		       enum kunit_assert_type type, struct kunit_assert *assert)
+		       enum kunit_assert_type type, struct kunit_assert *assert,
+		       const struct va_format *message)
 {
 	struct string_stream *stream;
 
@@ -257,7 +258,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
 	}
 
 	kunit_assert_prologue(loc, type, stream);
-	assert->format(assert, stream);
+	assert->format(assert, message, stream);
 
 	kunit_print_string_stream(test, stream);
 
@@ -284,12 +285,13 @@ void kunit_do_failed_assertion(struct kunit *test,
 			       const char *fmt, ...)
 {
 	va_list args;
+	struct va_format message;
 	va_start(args, fmt);
 
-	assert->message.fmt = fmt;
-	assert->message.va = &args;
+	message.fmt = fmt;
+	message.va = &args;
 
-	kunit_fail(test, loc, type, assert);
+	kunit_fail(test, loc, type, assert, &message);
 
 	va_end(args);
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

