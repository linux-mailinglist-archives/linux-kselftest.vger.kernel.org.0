Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891BA488070
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jan 2022 02:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiAHBXc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jan 2022 20:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiAHBXb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jan 2022 20:23:31 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EEBC061401
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jan 2022 17:23:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b144-20020a253496000000b0060bddc72114so15489412yba.4
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jan 2022 17:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pVN2Fx9XGwqMqyXiMDiR9EhkLf7LsMfEMRy4//JUQzk=;
        b=gVllR1aATpJPFgR32dYfQ3v/CWR84qq2bE6jixkdRt7rxKre/8PoombLazVkLHM3zQ
         6zWOOe9vUA8aoFqNksNFDvIT22bSpBruZvOBajuRN7f2KLEI0Z4mNvbF1k/Z+btb1d7M
         MbPvooD5YJS3WDh5sPSa5H3MbkNnHnLJEZT0PdGxJdT84QSji+iNr665zw2ZPwxwmvEA
         UG7ifioPP5E8/a2TEvy7tr9IdG1U5SSk71oHz1eHzBUm5n+VFcj5FKU620KXYuqClIsi
         66hZ0J8FebxX5OuWzq/wLyqsekhhzyLMLPuBS7g1i7GxCP2qSU1PWPR0cs7CwHKEO/J8
         eOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pVN2Fx9XGwqMqyXiMDiR9EhkLf7LsMfEMRy4//JUQzk=;
        b=ABR2CuF2zSu3Fyd4OrzJRnMWnpItOXvYMc4nvkBy0v/tvmKyjZ7IzvY8rb7q3NIZPd
         3YRWJSzvmzoKAvoixPzPk3ZETJGfUIIOg7rTidheK74oeCbyjorv4qOL4P1vreB5YmbB
         SlePYVWdG1jKrqVZEtd9n8JZPvVBYDHxFEE50rwQLoWp2QqIFRfiBTzvmC8I/DL6mjNV
         +KCBxEXAFjFDElt1dVofClcnr+c7sGXaZy8B8v9pUJYRCB4jFjAZnmPeJEEtSu6hZyo9
         I0r0ugti9FPQD1/UPx+px/tXeZlw59Le82qhGyTxRf/CiPBTm+zdkqefnachSmf810vZ
         aGCA==
X-Gm-Message-State: AOAM532dJc8LzmQ4lEaoln0f8j/HYCgy8Rd+zAlRBj1uT+alNLWcqdfT
        vE+OvmvTcoHG/tw50c/6OYDze36c30+8ZQ==
X-Google-Smtp-Source: ABdhPJzJ+Ye8ZlMTssCeQKX+wrtnd+Dpg1Twtowc5dvnIKUKPQfEM0sQjzHz6LB7RAX/qyoumdMNOX9Vab4qkg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bf8a:7e90:eb70:9b2b])
 (user=dlatypov job=sendgmr) by 2002:a25:d142:: with SMTP id
 i63mr75437812ybg.253.1641605010903; Fri, 07 Jan 2022 17:23:30 -0800 (PST)
Date:   Fri,  7 Jan 2022 17:23:01 -0800
In-Reply-To: <20220108012304.1049587-1-dlatypov@google.com>
Message-Id: <20220108012304.1049587-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH 3/6] kunit: drop unused kunit* field in kunit_assert
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        torvalds@linux-foundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The `struct kunit* test` field in kunit_assert is unused.
Note: we have access to `test` where we need it via the string_stream
object. I assume `test` in `kunit_assert` predates this and was leftover
after some refactoring.

This patch removes the field and cleans up the macros to avoid
needlessly passing around `test`.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/assert.h | 45 ++++++++++++------------------------------
 include/kunit/test.h   | 14 +++++--------
 2 files changed, 18 insertions(+), 41 deletions(-)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index ad889b539ab3..3da6c792496c 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -30,7 +30,6 @@ enum kunit_assert_type {
 
 /**
  * struct kunit_assert - Data for printing a failed assertion or expectation.
- * @test: the test case this expectation/assertion is associated with.
  * @type: the type (either an expectation or an assertion) of this kunit_assert.
  * @line: the source code line number that the expectation/assertion is at.
  * @file: the file path of the source file that the expectation/assertion is in.
@@ -41,7 +40,6 @@ enum kunit_assert_type {
  * format a string to a user reporting the failure.
  */
 struct kunit_assert {
-	struct kunit *test;
 	enum kunit_assert_type type;
 	int line;
 	const char *file;
@@ -60,14 +58,12 @@ struct kunit_assert {
 
 /**
  * KUNIT_INIT_ASSERT_STRUCT() - Initializer for a &struct kunit_assert.
- * @kunit: The test case that this expectation/assertion is associated with.
  * @assert_type: The type (assertion or expectation) of this kunit_assert.
  * @fmt: The formatting function which builds a string out of this kunit_assert.
  *
  * The base initializer for a &struct kunit_assert.
  */
-#define KUNIT_INIT_ASSERT_STRUCT(kunit, assert_type, fmt) {		       \
-	.test = kunit,							       \
+#define KUNIT_INIT_ASSERT_STRUCT(assert_type, fmt) {			       \
 	.type = assert_type,						       \
 	.file = __FILE__,						       \
 	.line = __LINE__,						       \
@@ -96,15 +92,13 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
 
 /**
  * KUNIT_INIT_FAIL_ASSERT_STRUCT() - Initializer for &struct kunit_fail_assert.
- * @test: The test case that this expectation/assertion is associated with.
  * @type: The type (assertion or expectation) of this kunit_assert.
  *
  * Initializes a &struct kunit_fail_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {			       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
-					   type,			       \
+#define KUNIT_INIT_FAIL_ASSERT_STRUCT(type) {			       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(type,			       \
 					   kunit_fail_assert_format)	       \
 }
 
@@ -129,7 +123,6 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 
 /**
  * KUNIT_INIT_UNARY_ASSERT_STRUCT() - Initializes &struct kunit_unary_assert.
- * @test: The test case that this expectation/assertion is associated with.
  * @type: The type (assertion or expectation) of this kunit_assert.
  * @cond: A string representation of the expression asserted true or false.
  * @expect_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
@@ -137,9 +130,8 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
  * Initializes a &struct kunit_unary_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_UNARY_ASSERT_STRUCT(test, type, cond, expect_true) {	       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
-					   type,			       \
+#define KUNIT_INIT_UNARY_ASSERT_STRUCT(type, cond, expect_true) {	       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(type,			       \
 					   kunit_unary_assert_format),	       \
 	.condition = cond,						       \
 	.expected_true = expect_true					       \
@@ -167,7 +159,6 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 /**
  * KUNIT_INIT_PTR_NOT_ERR_ASSERT_STRUCT() - Initializes a
  *	&struct kunit_ptr_not_err_assert.
- * @test: The test case that this expectation/assertion is associated with.
  * @type: The type (assertion or expectation) of this kunit_assert.
  * @txt: A string representation of the expression passed to the expectation.
  * @val: The actual evaluated pointer value of the expression.
@@ -175,9 +166,8 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
  * Initializes a &struct kunit_ptr_not_err_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(test, type, txt, val) {		       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
-					   type,			       \
+#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(type, txt, val) {			       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(type,			       \
 					   kunit_ptr_not_err_assert_format),   \
 	.text = txt,							       \
 	.value = val							       \
@@ -212,7 +202,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 /**
  * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a
  *	&struct kunit_binary_assert.
- * @test: The test case that this expectation/assertion is associated with.
  * @type: The type (assertion or expectation) of this kunit_assert.
  * @op_str: A string representation of the comparison operator (e.g. "==").
  * @left_str: A string representation of the expression in the left slot.
@@ -223,15 +212,13 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
  * Initializes a &struct kunit_binary_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_BINARY_ASSERT_STRUCT(test,				       \
-					type,				       \
+#define KUNIT_INIT_BINARY_ASSERT_STRUCT(type,				       \
 					op_str,				       \
 					left_str,			       \
 					left_val,			       \
 					right_str,			       \
 					right_val) {			       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
-					   type,			       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(type,			       \
 					   kunit_binary_assert_format),	       \
 	.operation = op_str,						       \
 	.left_text = left_str,						       \
@@ -269,7 +256,6 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 /**
  * KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT() - Initializes a
  *	&struct kunit_binary_ptr_assert.
- * @test: The test case that this expectation/assertion is associated with.
  * @type: The type (assertion or expectation) of this kunit_assert.
  * @op_str: A string representation of the comparison operator (e.g. "==").
  * @left_str: A string representation of the expression in the left slot.
@@ -280,15 +266,13 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
  * Initializes a &struct kunit_binary_ptr_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(test,			       \
-					    type,			       \
+#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(type,			       \
 					    op_str,			       \
 					    left_str,			       \
 					    left_val,			       \
 					    right_str,			       \
 					    right_val) {		       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
-					   type,			       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(type,			       \
 					   kunit_binary_ptr_assert_format),    \
 	.operation = op_str,						       \
 	.left_text = left_str,						       \
@@ -326,7 +310,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 /**
  * KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() - Initializes a
  *	&struct kunit_binary_str_assert.
- * @test: The test case that this expectation/assertion is associated with.
  * @type: The type (assertion or expectation) of this kunit_assert.
  * @op_str: A string representation of the comparison operator (e.g. "==").
  * @left_str: A string representation of the expression in the left slot.
@@ -337,15 +320,13 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
  * Initializes a &struct kunit_binary_str_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,			       \
-					    type,			       \
+#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(type,			       \
 					    op_str,			       \
 					    left_str,			       \
 					    left_val,			       \
 					    right_str,			       \
 					    right_val) {		       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
-					   type,			       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(type,			       \
 					   kunit_binary_str_assert_format),    \
 	.operation = op_str,						       \
 	.left_text = left_str,						       \
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 690a28dfc795..ebd45593321e 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -789,7 +789,7 @@ void kunit_failed_assertion(struct kunit *test,
 	KUNIT_ASSERTION(test,						       \
 			false,						       \
 			kunit_fail_assert,				       \
-			KUNIT_INIT_FAIL_ASSERT_STRUCT(test, assert_type),      \
+			KUNIT_INIT_FAIL_ASSERT_STRUCT(assert_type),      \
 			fmt,						       \
 			##__VA_ARGS__)
 
@@ -819,8 +819,7 @@ void kunit_failed_assertion(struct kunit *test,
 	KUNIT_ASSERTION(test,						       \
 			!!(condition) == !!expected_true,		       \
 			kunit_unary_assert,				       \
-			KUNIT_INIT_UNARY_ASSERT_STRUCT(test,		       \
-						       assert_type,	       \
+			KUNIT_INIT_UNARY_ASSERT_STRUCT(assert_type,	       \
 						       #condition,	       \
 						       expected_true),	       \
 			fmt,						       \
@@ -878,8 +877,7 @@ do {									       \
 	KUNIT_ASSERTION(test,						       \
 			__left op __right,				       \
 			assert_class,					       \
-			ASSERT_CLASS_INIT(test,				       \
-					  assert_type,			       \
+			ASSERT_CLASS_INIT(assert_type,			       \
 					  #op,				       \
 					  #left,			       \
 					  __left,			       \
@@ -1233,8 +1231,7 @@ do {									       \
 	KUNIT_ASSERTION(test,						       \
 			strcmp(__left, __right) op 0,			       \
 			kunit_binary_str_assert,			       \
-			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,	       \
-							assert_type,	       \
+			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(assert_type,       \
 							#op,		       \
 							#left,		       \
 							__left,		       \
@@ -1293,8 +1290,7 @@ do {									       \
 	KUNIT_ASSERTION(test,						       \
 			!IS_ERR_OR_NULL(__ptr),				       \
 			kunit_ptr_not_err_assert,			       \
-			KUNIT_INIT_PTR_NOT_ERR_STRUCT(test,		       \
-						      assert_type,	       \
+			KUNIT_INIT_PTR_NOT_ERR_STRUCT(assert_type,	       \
 						      #ptr,		       \
 						      __ptr),		       \
 			fmt,						       \
-- 
2.34.1.575.g55b058a8bb-goog

