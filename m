Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1084F48B784
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 20:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbiAKTms (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 14:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbiAKTmp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 14:42:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92152C061751
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:42:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a84-20020a251a57000000b0061171f19f8dso7247019yba.13
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sxvbc7bGwYaMSWzxJGMkvPlmIs+2+EWa68wYWXx+WlQ=;
        b=kiwFv3ubbdVeoHOyf9A5AC0GiQ3S1Wtf2dWo4fVq8U0qsoqck7oV9f8a860p0sjoQT
         WdhSKirjVqLL4+z+pzfREj/HF2NOvYXD81oCK7pMTy/HZnR9lxq0pKxKafmasSgsyWAv
         9dHsCZtY0PeKcTaQrXGEEtV+xFB+LoUolPH9Q6fUmAnS/MN2i0j19HA2swQWB5NdVJM0
         5DhgAOonQ98rGbAPJYOv8m0HGuaK8Lk+59LUzVmgdndsCZTyqs8OGExVRfRN77F28Ubm
         ep0jNcFl0zdZm9Ky/zgPfEFu5l2y+BHl9R5OpmyFcK3XGMY24XHvhuD4g6a2Wu6hdWyh
         Z/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sxvbc7bGwYaMSWzxJGMkvPlmIs+2+EWa68wYWXx+WlQ=;
        b=6+8U00+klXEuTwAJKEaAkkz3ICThERRsfedxb20A6gi4JsYQbrk6hOiLQ7+vc0FhmE
         CzP8grRa0egYe6za4Dp0yGKo0114apxo2klXgQ1ZP7JKuBu8Wb3AsofYv8hlDbBQzH9F
         QAWOwnumjKl5qyTEp4qy3Lkb1MY6v0Of6azeASPuoBRIpuDB9sZqOrIY+4AmBOSxBJS1
         8TeKsOpJk6gW86MVkCq06argp9Bo3ZveWtMq0zk2hErt8QtMAj0bC53WtvyyoNN1wd50
         2X1QZBjrZ7qcAtY9Prc32uglcRk4O8+dDRU1lT4BCTU3tqOam0wSWmoSDv4D2aZ9T4IP
         st+A==
X-Gm-Message-State: AOAM532YE6GXhytAQrsHOW8HS//yufh6S/EX3RbkBz2NBaEcEJFf08yY
        qlsLAF9PYjEcOOhG4HFKhC4c7sF26/3N2Q==
X-Google-Smtp-Source: ABdhPJwaSjGoUr7Ea82OVwl9y0xe+KO+zhJGwPYVotL9crsYQr0M9kyLKiJ5ci/7Aw+Bns+YkCirZoCtEdY8tw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8c76:9de0:1a30:7de8])
 (user=dlatypov job=sendgmr) by 2002:a25:8b0e:: with SMTP id
 i14mr7567465ybl.218.1641930164872; Tue, 11 Jan 2022 11:42:44 -0800 (PST)
Date:   Tue, 11 Jan 2022 11:42:28 -0800
In-Reply-To: <20220111194231.1797841-1-dlatypov@google.com>
Message-Id: <20220111194231.1797841-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH v2 3/6] kunit: drop unused kunit* field in kunit_assert
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
Note: string_stream needs it, but it has its own `test` field. I assume
`test` in `kunit_assert` predates this and was leftover after some
refactoring.

This patch removes the field and cleans up the macros to avoid
needlessly passing around `test`.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: David Gow <davidgow@google.com>
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
index 12cabd15449a..25ea3bce6663 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -790,7 +790,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 	KUNIT_ASSERTION(test,						       \
 			false,						       \
 			kunit_fail_assert,				       \
-			KUNIT_INIT_FAIL_ASSERT_STRUCT(test, assert_type),      \
+			KUNIT_INIT_FAIL_ASSERT_STRUCT(assert_type),      \
 			fmt,						       \
 			##__VA_ARGS__)
 
@@ -820,8 +820,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 	KUNIT_ASSERTION(test,						       \
 			!!(condition) == !!expected_true,		       \
 			kunit_unary_assert,				       \
-			KUNIT_INIT_UNARY_ASSERT_STRUCT(test,		       \
-						       assert_type,	       \
+			KUNIT_INIT_UNARY_ASSERT_STRUCT(assert_type,	       \
 						       #condition,	       \
 						       expected_true),	       \
 			fmt,						       \
@@ -879,8 +878,7 @@ do {									       \
 	KUNIT_ASSERTION(test,						       \
 			__left op __right,				       \
 			assert_class,					       \
-			ASSERT_CLASS_INIT(test,				       \
-					  assert_type,			       \
+			ASSERT_CLASS_INIT(assert_type,			       \
 					  #op,				       \
 					  #left,			       \
 					  __left,			       \
@@ -1234,8 +1232,7 @@ do {									       \
 	KUNIT_ASSERTION(test,						       \
 			strcmp(__left, __right) op 0,			       \
 			kunit_binary_str_assert,			       \
-			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,	       \
-							assert_type,	       \
+			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(assert_type,       \
 							#op,		       \
 							#left,		       \
 							__left,		       \
@@ -1294,8 +1291,7 @@ do {									       \
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

