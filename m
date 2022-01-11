Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693D748B789
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 20:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbiAKTmy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 14:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbiAKTmw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 14:42:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B19C06173F
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:42:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m202-20020a25d4d3000000b0061196f2a881so730833ybf.19
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=njxZip906y8sbtXtB//R8uMp68/sA5bXENQX80k/Srk=;
        b=pgaVZovcHu1KrMz6FM69+AY1yG/4j980SRhfQVG6QwMEMtghVw8m2q0kzrLv8OpMwj
         dYm5c/lbDNUbBmSeRAnwCt99w2PwfOZRWj1cbpNv6n/nB1UXKHCxlw52Gayj/SL4VRnd
         1LchSJFvnKWmaQducCuoajMvAvlhnZ0ngcKNxaf085NYFn938gBKm4xTKqXawG1d9ldr
         TNRm+ZKf/h2PT+lUBAf0EyZpA3tsqd59lkfglYnKvweUUPEFUC8sBIfEGJHtHRZolpzH
         cI6jQ8V1twj30jy484Y0KekoWZzP3N5v5UQBKt4IsBjXkTE1pxixOH5B9tm77XB1qtft
         pgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=njxZip906y8sbtXtB//R8uMp68/sA5bXENQX80k/Srk=;
        b=1gtvpacX/ros3X98PJ9SSJ//zFDSh9xolSCjun4/IQ7Vcup5IjpjteDFikq1uagvSS
         YNY4Ogn7N4RJ5s1E7qobbieLjLWvg6mUkbskdb1DCYKGUtvgHWTQdrpjZXsPkq3+oBsN
         OgF1DmfJpnjwKyaxx8qjPJkuOvpxb8j5sGUAqRp6jPgo00Hcub9gnnqJ8maqUZZ4XHFO
         JgjhjrVm1ZQPGD2CvN7PBjUPasx3QAySPV097cxigOi/ARrG7BzkRlRvmZC59iPmmnRd
         S/hJWbw9R6EI5ZBSyXp/qD8pZNubxrBQrWNQJem3gtnOYae6kW2t/RkGzfRnP8+NYS6i
         b4AQ==
X-Gm-Message-State: AOAM533eqNanolTcvzEw54+s03gILtH3EA7fwTDdvLq1pnm3izp7yzL9
        yTqaYivFYnc/YMWLhGkb/64I23UpfYIUKQ==
X-Google-Smtp-Source: ABdhPJzqmLf41D4hrwL52IQzu7lV1Y001ZUixSM5TOCzSUksWiYeMSuwhv/K72vYxYeFplp/THLgBxSReIn6yg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8c76:9de0:1a30:7de8])
 (user=dlatypov job=sendgmr) by 2002:a25:c747:: with SMTP id
 w68mr4511513ybe.302.1641930171578; Tue, 11 Jan 2022 11:42:51 -0800 (PST)
Date:   Tue, 11 Jan 2022 11:42:31 -0800
In-Reply-To: <20220111194231.1797841-1-dlatypov@google.com>
Message-Id: <20220111194231.1797841-7-dlatypov@google.com>
Mime-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH v2 6/6] kunit: drop unused assert_type from kunit_assert and
 clean up macros
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        torvalds@linux-foundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This field has been split out from kunit_assert to make the struct less
heavy along with the filename and line number.

This change drops the assert_type field and cleans up all the macros
that were plumbing assert_type into kunit_assert.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 include/kunit/assert.h | 46 +++++++++++++-----------------------------
 include/kunit/test.h   | 14 +++++--------
 2 files changed, 19 insertions(+), 41 deletions(-)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 4f91dbdb886a..21299232c120 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -42,7 +42,6 @@ struct kunit_loc {
 
 /**
  * struct kunit_assert - Data for printing a failed assertion or expectation.
- * @type: the type (either an expectation or an assertion) of this kunit_assert.
  * @message: an optional message to provide additional context.
  * @format: a function which formats the data in this kunit_assert to a string.
  *
@@ -50,7 +49,6 @@ struct kunit_loc {
  * format a string to a user reporting the failure.
  */
 struct kunit_assert {
-	enum kunit_assert_type type; // TODO(dlatypov@google.com): delete this
 	struct va_format message;
 	void (*format)(const struct kunit_assert *assert,
 		       struct string_stream *stream);
@@ -66,13 +64,11 @@ struct kunit_assert {
 
 /**
  * KUNIT_INIT_ASSERT_STRUCT() - Initializer for a &struct kunit_assert.
- * @assert_type: The type (assertion or expectation) of this kunit_assert.
  * @fmt: The formatting function which builds a string out of this kunit_assert.
  *
  * The base initializer for a &struct kunit_assert.
  */
-#define KUNIT_INIT_ASSERT_STRUCT(assert_type, fmt) {			       \
-	.type = assert_type,						       \
+#define KUNIT_INIT_ASSERT_STRUCT(fmt) {					       \
 	.message = KUNIT_INIT_VA_FMT_NULL,				       \
 	.format = fmt							       \
 }
@@ -98,15 +94,13 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
 			      struct string_stream *stream);
 
 /**
- * KUNIT_INIT_FAIL_ASSERT_STRUCT() - Initializer for &struct kunit_fail_assert.
- * @type: The type (assertion or expectation) of this kunit_assert.
+ * KUNIT_INIT_FAIL_ASSERT_STRUCT - Initializer for &struct kunit_fail_assert.
  *
  * Initializes a &struct kunit_fail_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_FAIL_ASSERT_STRUCT(type) {			       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(type,			       \
-					   kunit_fail_assert_format)	       \
+#define KUNIT_INIT_FAIL_ASSERT_STRUCT {					\
+	.assert = KUNIT_INIT_ASSERT_STRUCT(kunit_fail_assert_format)	\
 }
 
 /**
@@ -130,16 +124,14 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 
 /**
  * KUNIT_INIT_UNARY_ASSERT_STRUCT() - Initializes &struct kunit_unary_assert.
- * @type: The type (assertion or expectation) of this kunit_assert.
  * @cond: A string representation of the expression asserted true or false.
  * @expect_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
  *
  * Initializes a &struct kunit_unary_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_UNARY_ASSERT_STRUCT(type, cond, expect_true) {	       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(type,			       \
-					   kunit_unary_assert_format),	       \
+#define KUNIT_INIT_UNARY_ASSERT_STRUCT(cond, expect_true) {		       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(kunit_unary_assert_format),	       \
 	.condition = cond,						       \
 	.expected_true = expect_true					       \
 }
@@ -166,16 +158,14 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 /**
  * KUNIT_INIT_PTR_NOT_ERR_ASSERT_STRUCT() - Initializes a
  *	&struct kunit_ptr_not_err_assert.
- * @type: The type (assertion or expectation) of this kunit_assert.
  * @txt: A string representation of the expression passed to the expectation.
  * @val: The actual evaluated pointer value of the expression.
  *
  * Initializes a &struct kunit_ptr_not_err_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(type, txt, val) {			       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(type,			       \
-					   kunit_ptr_not_err_assert_format),   \
+#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(txt, val) {			       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(kunit_ptr_not_err_assert_format),   \
 	.text = txt,							       \
 	.value = val							       \
 }
@@ -209,7 +199,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 /**
  * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a
  *	&struct kunit_binary_assert.
- * @type: The type (assertion or expectation) of this kunit_assert.
  * @op_str: A string representation of the comparison operator (e.g. "==").
  * @left_str: A string representation of the expression in the left slot.
  * @left_val: The actual evaluated value of the expression in the left slot.
@@ -219,14 +208,12 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
  * Initializes a &struct kunit_binary_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_BINARY_ASSERT_STRUCT(type,				       \
-					op_str,				       \
+#define KUNIT_INIT_BINARY_ASSERT_STRUCT(op_str,				       \
 					left_str,			       \
 					left_val,			       \
 					right_str,			       \
 					right_val) {			       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(type,			       \
-					   kunit_binary_assert_format),	       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_assert_format),	       \
 	.operation = op_str,						       \
 	.left_text = left_str,						       \
 	.left_value = left_val,						       \
@@ -273,14 +260,12 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
  * Initializes a &struct kunit_binary_ptr_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(type,			       \
-					    op_str,			       \
+#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(op_str,			       \
 					    left_str,			       \
 					    left_val,			       \
 					    right_str,			       \
 					    right_val) {		       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(type,			       \
-					   kunit_binary_ptr_assert_format),    \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_ptr_assert_format),    \
 	.operation = op_str,						       \
 	.left_text = left_str,						       \
 	.left_value = left_val,						       \
@@ -317,7 +302,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 /**
  * KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() - Initializes a
  *	&struct kunit_binary_str_assert.
- * @type: The type (assertion or expectation) of this kunit_assert.
  * @op_str: A string representation of the comparison operator (e.g. "==").
  * @left_str: A string representation of the expression in the left slot.
  * @left_val: The actual evaluated value of the expression in the left slot.
@@ -327,14 +311,12 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
  * Initializes a &struct kunit_binary_str_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(type,			       \
-					    op_str,			       \
+#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(op_str,			       \
 					    left_str,			       \
 					    left_val,			       \
 					    right_str,			       \
 					    right_val) {		       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(type,			       \
-					   kunit_binary_str_assert_format),    \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_str_assert_format),    \
 	.operation = op_str,						       \
 	.left_text = left_str,						       \
 	.left_value = left_val,						       \
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 7b752175e614..5964af750d93 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -796,7 +796,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 			assert_type,					       \
 			false,						       \
 			kunit_fail_assert,				       \
-			KUNIT_INIT_FAIL_ASSERT_STRUCT(assert_type),      \
+			KUNIT_INIT_FAIL_ASSERT_STRUCT,			       \
 			fmt,						       \
 			##__VA_ARGS__)
 
@@ -827,8 +827,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 			assert_type,					       \
 			!!(condition) == !!expected_true,		       \
 			kunit_unary_assert,				       \
-			KUNIT_INIT_UNARY_ASSERT_STRUCT(assert_type,	       \
-						       #condition,	       \
+			KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,	       \
 						       expected_true),	       \
 			fmt,						       \
 			##__VA_ARGS__)
@@ -886,8 +885,7 @@ do {									       \
 			assert_type,					       \
 			__left op __right,				       \
 			assert_class,					       \
-			ASSERT_CLASS_INIT(assert_type,			       \
-					  #op,				       \
+			ASSERT_CLASS_INIT(#op,				       \
 					  #left,			       \
 					  __left,			       \
 					  #right,			       \
@@ -1241,8 +1239,7 @@ do {									       \
 			assert_type,					       \
 			strcmp(__left, __right) op 0,			       \
 			kunit_binary_str_assert,			       \
-			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(assert_type,       \
-							#op,		       \
+			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(#op,	       \
 							#left,		       \
 							__left,		       \
 							#right,		       \
@@ -1301,8 +1298,7 @@ do {									       \
 			assert_type,					       \
 			!IS_ERR_OR_NULL(__ptr),				       \
 			kunit_ptr_not_err_assert,			       \
-			KUNIT_INIT_PTR_NOT_ERR_STRUCT(assert_type,	       \
-						      #ptr,		       \
+			KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr,		       \
 						      __ptr),		       \
 			fmt,						       \
 			##__VA_ARGS__);					       \
-- 
2.34.1.575.g55b058a8bb-goog

