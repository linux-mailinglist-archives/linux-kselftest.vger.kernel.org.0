Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B653948DC66
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jan 2022 18:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbiAMRAE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jan 2022 12:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbiAMRAD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jan 2022 12:00:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C96CC06174E
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jan 2022 09:00:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s89-20020a25aa62000000b00611afc92630so8250853ybi.17
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jan 2022 09:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0bSkrcDseCcepTlbkkVY4WyOT+vh8pWdvwaC0weZr8k=;
        b=SRNkewrPCE3hhhgkfSpyZ1krbT2ltJgY0MCWbi/p19A0XttAR1PPeCq7fshKk3LE3k
         +Csn8rVgcCHlbWMs6Lez95tknhJKYr5L5OWiXZ3+IrE6sH7NSOV4Tw3E+hcqGRqPCeE+
         OFdJ/iMW51H3Rgx2+87J1oRNHmFsVOKUNPxPO75Csd90uRO14LAH7Re7jzwcLNw0Z1VJ
         DxAfUqWLWnwMGYWTCQQD+ylGICx6WOF7wAO62B+uiOwUeB5OqXOpxHcj0Nj/yMHaNEhB
         AaMwdAe4HC8OCvd0v8IOSL1kjZN6Bkdtj2k78nlNgNO4MQTLJ6aiz/NsgEmWRR6sTCo+
         rZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0bSkrcDseCcepTlbkkVY4WyOT+vh8pWdvwaC0weZr8k=;
        b=mGi2m/9cVv69ZEgDM8ZCzozO0NP/v5xM4TJPENHEm+x2kt9vq+5AB2A0QX5Iw8QSGc
         jlC+nm3iLuV57eZn5GrvDQUMPJDNpc0tcJwmabcLZymHkGP5JW+CMUXPEat5hp1w5PdA
         2GbjU9QvREOaenXWuvyJW+YYIsMRDjdq2+vOrWt3fTBXU0dIZ7JWazjSF/L55RrupVcv
         UbvxbHAJiWoys5ApgfHGhEDHGiMLZKIRz+NfOwJCxqZ4qGjntSI7bMFSKr5lt7W3pYVb
         ON6piuEVmDB5xGSbnAebkLLkO441wUusbuMjlaaI3+4bqZ4W1UKk4hVTbSkE9Xl2F1DR
         y8kQ==
X-Gm-Message-State: AOAM533U5QRF6hWRLCJOuJWiN0sj0/HRVF+umK90zRrv0Q1jIJS3lM7I
        mOwPXNFvuRMigG4kl2kx6T2my5lIE9DyfA==
X-Google-Smtp-Source: ABdhPJytMkIwXFVdejHx594HPVb/wCwE1vSNjB2mnuNJno8qwjNEAq1n33F0hODqJJDSJt50KAaVqwzdAU5N9g==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1a70:cede:4191:24bc])
 (user=dlatypov job=sendgmr) by 2002:a25:9881:: with SMTP id
 l1mr6676467ybo.262.1642093201398; Thu, 13 Jan 2022 09:00:01 -0800 (PST)
Date:   Thu, 13 Jan 2022 08:59:31 -0800
In-Reply-To: <20220113165931.451305-1-dlatypov@google.com>
Message-Id: <20220113165931.451305-7-dlatypov@google.com>
Mime-Version: 1.0
References: <20220113165931.451305-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v3 6/6] kunit: drop unused assert_type from kunit_assert and
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/assert.h | 48 ++++++++++++------------------------------
 include/kunit/test.h   | 14 +++++-------
 2 files changed, 19 insertions(+), 43 deletions(-)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 3d7e46901478..21299232c120 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -42,7 +42,6 @@ struct kunit_loc {
 
 /**
  * struct kunit_assert - Data for printing a failed assertion or expectation.
- * @type: the type (either an expectation or an assertion) of this kunit_assert.
  * @message: an optional message to provide additional context.
  * @format: a function which formats the data in this kunit_assert to a string.
  *
@@ -50,9 +49,6 @@ struct kunit_loc {
  * format a string to a user reporting the failure.
  */
 struct kunit_assert {
-	 // TODO(dlatypov@google.com): delete this unused field when we've
-	 // updated all the related KUNIT_INIT_ASSERT* macros.
-	enum kunit_assert_type type;
 	struct va_format message;
 	void (*format)(const struct kunit_assert *assert,
 		       struct string_stream *stream);
@@ -68,13 +64,11 @@ struct kunit_assert {
 
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
@@ -100,15 +94,13 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
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
@@ -132,16 +124,14 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 
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
@@ -168,16 +158,14 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
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
@@ -211,7 +199,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 /**
  * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a
  *	&struct kunit_binary_assert.
- * @type: The type (assertion or expectation) of this kunit_assert.
  * @op_str: A string representation of the comparison operator (e.g. "==").
  * @left_str: A string representation of the expression in the left slot.
  * @left_val: The actual evaluated value of the expression in the left slot.
@@ -221,14 +208,12 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
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
@@ -275,14 +260,12 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
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
@@ -319,7 +302,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 /**
  * KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() - Initializes a
  *	&struct kunit_binary_str_assert.
- * @type: The type (assertion or expectation) of this kunit_assert.
  * @op_str: A string representation of the comparison operator (e.g. "==").
  * @left_str: A string representation of the expression in the left slot.
  * @left_val: The actual evaluated value of the expression in the left slot.
@@ -329,14 +311,12 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
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
2.34.1.703.g22d0c6ccf7-goog

