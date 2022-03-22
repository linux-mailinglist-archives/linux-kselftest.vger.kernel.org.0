Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABA04E3643
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 02:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiCVBx0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 21:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiCVBxZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 21:53:25 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E4313D29
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Mar 2022 18:51:56 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-de3ca1efbaso536236fac.9
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Mar 2022 18:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=sF3HPzwNtwMST/vvDP3CAeHI5x9AltrJiTUwWsqZN48=;
        b=A0tww5gQq6R2yP/cqJ2KYSVciDj6VflxqbjhxFa7L/klsSLC8dV7FPzcQG2GiHT+gW
         H9cdV/d0cF+pPrUY+r8HgjOwwjy4VIQhNZa+TatncCBcnnQav07lSPxtPAruj4m7diko
         0F6xf/HORBD+uomREoQUZC9s+uLCBOvP04MrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=sF3HPzwNtwMST/vvDP3CAeHI5x9AltrJiTUwWsqZN48=;
        b=tXALxtUt1jveqUgzx5LNBXE4q17XjeRtF9w7Kf/2p+DXyvLhwFu48ahmClB2pNWYV4
         So2xu2jIHLSRshDje2jJ4JHIikiT+7ad5iTbcEQTkUdlM6kJNWgFVnwBOhsugY8NzJzw
         dqN1HC7MzcPeWK7v4KLOmFVcvraaaP/ptb7uOwH6LGTyIKIBPA/mGvHzVzghiKGgjHHK
         nPUgqGO2cA81q+G0QLIJt5qXnnnYztItMvas/yEx3xrJmToJbyD80TOkHQ5AAETDjzFH
         PBlO/8q4usAcoVgsN3Yf5V96l45XovnuYWRDIGBtfio9xO90sVsmrLuU6BrMNSvZ0xJ8
         qg0w==
X-Gm-Message-State: AOAM531hhDaLXsBqG7aIy4uqb22BjA5Z4jQ7T53PNeH4Y6pVLJiVC2CG
        sRbHZn3aAb21PXhA1ISVs/H72A==
X-Google-Smtp-Source: ABdhPJzQKJWGPBmh6K2AyNfm2Cwkq4/HxT3sx1pIh5xqGC84ZidWeEJ+RvJhj0fHGAAG4Ef0ZAFbJQ==
X-Received: by 2002:a05:6870:9711:b0:dd:fc52:1d17 with SMTP id n17-20020a056870971100b000ddfc521d17mr751978oaq.220.1647913914778;
        Mon, 21 Mar 2022 18:51:54 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l1-20020a056830268100b005c93e625b9dsm8728307otu.46.2022.03.21.18.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 18:51:54 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.18-rc1
Message-ID: <d138a93a-997f-bfb6-6119-83aa2c00a49d@linuxfoundation.org>
Date:   Mon, 21 Mar 2022 19:51:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------DC1A7EE224A683C6C672C857"
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------DC1A7EE224A683C6C672C857
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit update for Linux 5.18-rc1.

This KUnit update for Linux 5.18-rc1 consists of:

- changes to decrease macro layering string, integer, EQ/NE asserts
- remove unused macros
- several cleanups and fixes
- new list tests for list_del_init_careful(), list_is_head() and
   list_entry_is_head()

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.18-rc1

for you to fetch changes up to 5debe5bfa02c4c8922bd2d0f82c9c3a70bec8944:

   list: test: Add a test for list_entry_is_head() (2022-02-25 08:39:01 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-5.18-rc1

This KUnit update for Linux 5.18-rc1 consists of:

- changes to decrease macro layering string, integer, EQ/NE asserts
- remove unused macros
- several cleanups and fixes
- new list tests for list_del_init_careful(), list_is_head() and
   list_entry_is_head()

----------------------------------------------------------------
Daniel Latypov (16):
       kunit: add example test case showing off all the expect macros
       kunit: move check if assertion passed into the macros
       kunit: drop unused kunit* field in kunit_assert
       kunit: factor out kunit_base_assert_format() call into kunit_fail()
       kunit: split out part of kunit_assert into a static const
       kunit: drop unused assert_type from kunit_assert and clean up macros
       kunit: make KUNIT_EXPECT_EQ() use KUNIT_EXPECT_EQ_MSG(), etc.
       kunit: drop unused intermediate macros for ptr inequality checks
       kunit: reduce layering in string assertion macros
       kunit: decrease macro layering for integer asserts
       kunit: decrease macro layering for EQ/NE asserts
       kunit: tool: drop mostly unused KunitResult.result field
       kunit: remove va_format from kunit_assert
       kunit: consolidate KUNIT_INIT_BINARY_ASSERT_STRUCT macros
       kunit: factor out str constants from binary assertion structs
       kunit: cleanup assertion macro internal variables

David Gow (3):
       list: test: Add test for list_del_init_careful()
       list: test: Add a test for list_is_head()
       list: test: Add a test for list_entry_is_head()

  include/kunit/assert.h         | 220 ++++--------
  include/kunit/test.h           | 745 +++++++++++------------------------------
  lib/kunit/assert.c             |  80 ++---
  lib/kunit/kunit-example-test.c |  42 +++
  lib/kunit/test.c               |  35 +-
  lib/list-test.c                |  61 ++++
  tools/testing/kunit/kunit.py   |  24 +-
  7 files changed, 420 insertions(+), 787 deletions(-)
----------------------------------------------------------------

--------------DC1A7EE224A683C6C672C857
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.18-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.18-rc1.diff"

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index ccbc36c0b02f..4b52e12c2ae8 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -28,58 +28,34 @@ enum kunit_assert_type {
 	KUNIT_EXPECTATION,
 };
 
+/**
+ * struct kunit_loc - Identifies the source location of a line of code.
+ * @line: the line number in the file.
+ * @file: the file name.
+ */
+struct kunit_loc {
+	int line;
+	const char *file;
+};
+
+#define KUNIT_CURRENT_LOC { .file = __FILE__, .line = __LINE__ }
+
 /**
  * struct kunit_assert - Data for printing a failed assertion or expectation.
- * @test: the test case this expectation/assertion is associated with.
- * @type: the type (either an expectation or an assertion) of this kunit_assert.
- * @line: the source code line number that the expectation/assertion is at.
- * @file: the file path of the source file that the expectation/assertion is in.
- * @message: an optional message to provide additional context.
  * @format: a function which formats the data in this kunit_assert to a string.
  *
  * Represents a failed expectation/assertion. Contains all the data necessary to
  * format a string to a user reporting the failure.
  */
 struct kunit_assert {
-	struct kunit *test;
-	enum kunit_assert_type type;
-	int line;
-	const char *file;
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
- * @kunit: The test case that this expectation/assertion is associated with.
- * @assert_type: The type (assertion or expectation) of this kunit_assert.
- * @fmt: The formatting function which builds a string out of this kunit_assert.
- *
- * The base initializer for a &struct kunit_assert.
- */
-#define KUNIT_INIT_ASSERT_STRUCT(kunit, assert_type, fmt) {		       \
-	.test = kunit,							       \
-	.type = assert_type,						       \
-	.file = __FILE__,						       \
-	.line = __LINE__,						       \
-	.message = KUNIT_INIT_VA_FMT_NULL,				       \
-	.format = fmt							       \
-}
-
-void kunit_base_assert_format(const struct kunit_assert *assert,
-			      struct string_stream *stream);
-
-void kunit_assert_print_msg(const struct kunit_assert *assert,
-			    struct string_stream *stream);
+void kunit_assert_prologue(const struct kunit_loc *loc,
+			   enum kunit_assert_type type,
+			   struct string_stream *stream);
 
 /**
  * struct kunit_fail_assert - Represents a plain fail expectation/assertion.
@@ -92,20 +68,17 @@ struct kunit_fail_assert {
 };
 
 void kunit_fail_assert_format(const struct kunit_assert *assert,
+			      const struct va_format *message,
 			      struct string_stream *stream);
 
 /**
- * KUNIT_INIT_FAIL_ASSERT_STRUCT() - Initializer for &struct kunit_fail_assert.
- * @test: The test case that this expectation/assertion is associated with.
- * @type: The type (assertion or expectation) of this kunit_assert.
+ * KUNIT_INIT_FAIL_ASSERT_STRUCT - Initializer for &struct kunit_fail_assert.
  *
  * Initializes a &struct kunit_fail_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {			       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
-					   type,			       \
-					   kunit_fail_assert_format)	       \
+#define KUNIT_INIT_FAIL_ASSERT_STRUCT {					\
+	.assert = { .format = kunit_fail_assert_format },		\
 }
 
 /**
@@ -125,22 +98,19 @@ struct kunit_unary_assert {
 };
 
 void kunit_unary_assert_format(const struct kunit_assert *assert,
+			       const struct va_format *message,
 			       struct string_stream *stream);
 
 /**
  * KUNIT_INIT_UNARY_ASSERT_STRUCT() - Initializes &struct kunit_unary_assert.
- * @test: The test case that this expectation/assertion is associated with.
- * @type: The type (assertion or expectation) of this kunit_assert.
  * @cond: A string representation of the expression asserted true or false.
  * @expect_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
  *
  * Initializes a &struct kunit_unary_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_UNARY_ASSERT_STRUCT(test, type, cond, expect_true) {	       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
-					   type,			       \
-					   kunit_unary_assert_format),	       \
+#define KUNIT_INIT_UNARY_ASSERT_STRUCT(cond, expect_true) {		       \
+	.assert = { .format = kunit_unary_assert_format },		       \
 	.condition = cond,						       \
 	.expected_true = expect_true					       \
 }
@@ -162,35 +132,43 @@ struct kunit_ptr_not_err_assert {
 };
 
 void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
+				     const struct va_format *message,
 				     struct string_stream *stream);
 
 /**
  * KUNIT_INIT_PTR_NOT_ERR_ASSERT_STRUCT() - Initializes a
  *	&struct kunit_ptr_not_err_assert.
- * @test: The test case that this expectation/assertion is associated with.
- * @type: The type (assertion or expectation) of this kunit_assert.
  * @txt: A string representation of the expression passed to the expectation.
  * @val: The actual evaluated pointer value of the expression.
  *
  * Initializes a &struct kunit_ptr_not_err_assert. Intended to be used in
  * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
  */
-#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(test, type, txt, val) {		       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
-					   type,			       \
-					   kunit_ptr_not_err_assert_format),   \
+#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(txt, val) {			       \
+	.assert = { .format = kunit_ptr_not_err_assert_format },	       \
 	.text = txt,							       \
 	.value = val							       \
 }
 
+/**
+ * struct kunit_binary_assert_text - holds strings for &struct
+ *	kunit_binary_assert and friends to try and make the structs smaller.
+ * @operation: A string representation of the comparison operator (e.g. "==").
+ * @left_text: A string representation of the left expression (e.g. "2+2").
+ * @right_text: A string representation of the right expression (e.g. "2+2").
+ */
+struct kunit_binary_assert_text {
+	const char *operation;
+	const char *left_text;
+	const char *right_text;
+};
+
 /**
  * struct kunit_binary_assert - An expectation/assertion that compares two
  *	non-pointer values (for example, KUNIT_EXPECT_EQ(test, 1 + 1, 2)).
  * @assert: The parent of this type.
- * @operation: A string representation of the comparison operator (e.g. "==").
- * @left_text: A string representation of the expression in the left slot.
+ * @text: Holds the textual representations of the operands and op (e.g.  "==").
  * @left_value: The actual evaluated value of the expression in the left slot.
- * @right_text: A string representation of the expression in the right slot.
  * @right_value: The actual evaluated value of the expression in the right slot.
  *
  * Represents an expectation/assertion that compares two non-pointer values. For
@@ -199,44 +177,36 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
  */
 struct kunit_binary_assert {
 	struct kunit_assert assert;
-	const char *operation;
-	const char *left_text;
+	const struct kunit_binary_assert_text *text;
 	long long left_value;
-	const char *right_text;
 	long long right_value;
 };
 
 void kunit_binary_assert_format(const struct kunit_assert *assert,
+				const struct va_format *message,
 				struct string_stream *stream);
 
 /**
- * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a
- *	&struct kunit_binary_assert.
- * @test: The test case that this expectation/assertion is associated with.
- * @type: The type (assertion or expectation) of this kunit_assert.
- * @op_str: A string representation of the comparison operator (e.g. "==").
- * @left_str: A string representation of the expression in the left slot.
+ * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a binary assert like
+ *	kunit_binary_assert, kunit_binary_ptr_assert, etc.
+ *
+ * @format_func: a function which formats the assert to a string.
+ * @text_: Pointer to a kunit_binary_assert_text.
  * @left_val: The actual evaluated value of the expression in the left slot.
- * @right_str: A string representation of the expression in the right slot.
  * @right_val: The actual evaluated value of the expression in the right slot.
  *
- * Initializes a &struct kunit_binary_assert. Intended to be used in
- * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ * Initializes a binary assert like kunit_binary_assert,
+ * kunit_binary_ptr_assert, etc. This relies on these structs having the same
+ * fields but with different types for left_val/right_val.
+ * This is ultimately used by binary assertion macros like KUNIT_EXPECT_EQ, etc.
  */
-#define KUNIT_INIT_BINARY_ASSERT_STRUCT(test,				       \
-					type,				       \
-					op_str,				       \
-					left_str,			       \
+#define KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,			       \
+					text_,				       \
 					left_val,			       \
-					right_str,			       \
 					right_val) {			       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
-					   type,			       \
-					   kunit_binary_assert_format),	       \
-	.operation = op_str,						       \
-	.left_text = left_str,						       \
+	.assert = { .format = format_func },				       \
+	.text = text_,							       \
 	.left_value = left_val,						       \
-	.right_text = right_str,					       \
 	.right_value = right_val					       \
 }
 
@@ -244,10 +214,8 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
  * struct kunit_binary_ptr_assert - An expectation/assertion that compares two
  *	pointer values (for example, KUNIT_EXPECT_PTR_EQ(test, foo, bar)).
  * @assert: The parent of this type.
- * @operation: A string representation of the comparison operator (e.g. "==").
- * @left_text: A string representation of the expression in the left slot.
+ * @text: Holds the textual representations of the operands and op (e.g.  "==").
  * @left_value: The actual evaluated value of the expression in the left slot.
- * @right_text: A string representation of the expression in the right slot.
  * @right_value: The actual evaluated value of the expression in the right slot.
  *
  * Represents an expectation/assertion that compares two pointer values. For
@@ -256,55 +224,21 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
  */
 struct kunit_binary_ptr_assert {
 	struct kunit_assert assert;
-	const char *operation;
-	const char *left_text;
+	const struct kunit_binary_assert_text *text;
 	const void *left_value;
-	const char *right_text;
 	const void *right_value;
 };
 
 void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
+				    const struct va_format *message,
 				    struct string_stream *stream);
 
-/**
- * KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT() - Initializes a
- *	&struct kunit_binary_ptr_assert.
- * @test: The test case that this expectation/assertion is associated with.
- * @type: The type (assertion or expectation) of this kunit_assert.
- * @op_str: A string representation of the comparison operator (e.g. "==").
- * @left_str: A string representation of the expression in the left slot.
- * @left_val: The actual evaluated value of the expression in the left slot.
- * @right_str: A string representation of the expression in the right slot.
- * @right_val: The actual evaluated value of the expression in the right slot.
- *
- * Initializes a &struct kunit_binary_ptr_assert. Intended to be used in
- * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
- */
-#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(test,			       \
-					    type,			       \
-					    op_str,			       \
-					    left_str,			       \
-					    left_val,			       \
-					    right_str,			       \
-					    right_val) {		       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
-					   type,			       \
-					   kunit_binary_ptr_assert_format),    \
-	.operation = op_str,						       \
-	.left_text = left_str,						       \
-	.left_value = left_val,						       \
-	.right_text = right_str,					       \
-	.right_value = right_val					       \
-}
-
 /**
  * struct kunit_binary_str_assert - An expectation/assertion that compares two
  *	string values (for example, KUNIT_EXPECT_STREQ(test, foo, "bar")).
  * @assert: The parent of this type.
- * @operation: A string representation of the comparison operator (e.g. "==").
- * @left_text: A string representation of the expression in the left slot.
+ * @text: Holds the textual representations of the operands and comparator.
  * @left_value: The actual evaluated value of the expression in the left slot.
- * @right_text: A string representation of the expression in the right slot.
  * @right_value: The actual evaluated value of the expression in the right slot.
  *
  * Represents an expectation/assertion that compares two string values. For
@@ -313,45 +247,13 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
  */
 struct kunit_binary_str_assert {
 	struct kunit_assert assert;
-	const char *operation;
-	const char *left_text;
+	const struct kunit_binary_assert_text *text;
 	const char *left_value;
-	const char *right_text;
 	const char *right_value;
 };
 
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
+				    const struct va_format *message,
 				    struct string_stream *stream);
 
-/**
- * KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() - Initializes a
- *	&struct kunit_binary_str_assert.
- * @test: The test case that this expectation/assertion is associated with.
- * @type: The type (assertion or expectation) of this kunit_assert.
- * @op_str: A string representation of the comparison operator (e.g. "==").
- * @left_str: A string representation of the expression in the left slot.
- * @left_val: The actual evaluated value of the expression in the left slot.
- * @right_str: A string representation of the expression in the right slot.
- * @right_val: The actual evaluated value of the expression in the right slot.
- *
- * Initializes a &struct kunit_binary_str_assert. Intended to be used in
- * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
- */
-#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,			       \
-					    type,			       \
-					    op_str,			       \
-					    left_str,			       \
-					    left_val,			       \
-					    right_str,			       \
-					    right_val) {		       \
-	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
-					   type,			       \
-					   kunit_binary_str_assert_format),    \
-	.operation = op_str,						       \
-	.left_text = left_str,						       \
-	.left_value = left_val,						       \
-	.right_text = right_str,					       \
-	.right_value = right_val					       \
-}
-
 #endif /*  _KUNIT_ASSERT_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index b26400731c02..00b9ff7783ab 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -12,6 +12,7 @@
 #include <kunit/assert.h>
 #include <kunit/try-catch.h>
 
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -770,26 +771,32 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
  */
 #define KUNIT_SUCCEED(test) do {} while (0)
 
-void kunit_do_assertion(struct kunit *test,
-			struct kunit_assert *assert,
-			bool pass,
-			const char *fmt, ...);
-
-#define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
-	struct assert_class __assertion = INITIALIZER;			       \
-	kunit_do_assertion(test,					       \
-			   &__assertion.assert,				       \
-			   pass,					       \
-			   fmt,						       \
-			   ##__VA_ARGS__);				       \
+void kunit_do_failed_assertion(struct kunit *test,
+			       const struct kunit_loc *loc,
+			       enum kunit_assert_type type,
+			       struct kunit_assert *assert,
+			       const char *fmt, ...);
+
+#define KUNIT_ASSERTION(test, assert_type, pass, assert_class, INITIALIZER, fmt, ...) do { \
+	if (unlikely(!(pass))) {					       \
+		static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;       \
+		struct assert_class __assertion = INITIALIZER;		       \
+		kunit_do_failed_assertion(test,				       \
+					  &__loc,			       \
+					  assert_type,			       \
+					  &__assertion.assert,		       \
+					  fmt,				       \
+					  ##__VA_ARGS__);		       \
+	}								       \
 } while (0)
 
 
 #define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...)		       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			false,						       \
 			kunit_fail_assert,				       \
-			KUNIT_INIT_FAIL_ASSERT_STRUCT(test, assert_type),      \
+			KUNIT_INIT_FAIL_ASSERT_STRUCT,			       \
 			fmt,						       \
 			##__VA_ARGS__)
 
@@ -817,11 +824,10 @@ void kunit_do_assertion(struct kunit *test,
 			      fmt,					       \
 			      ...)					       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			!!(condition) == !!expected_true,		       \
 			kunit_unary_assert,				       \
-			KUNIT_INIT_UNARY_ASSERT_STRUCT(test,		       \
-						       assert_type,	       \
-						       #condition,	       \
+			KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,	       \
 						       expected_true),	       \
 			fmt,						       \
 			##__VA_ARGS__)
@@ -834,9 +840,6 @@ void kunit_do_assertion(struct kunit *test,
 			      fmt,					       \
 			      ##__VA_ARGS__)
 
-#define KUNIT_TRUE_ASSERTION(test, assert_type, condition) \
-	KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, NULL)
-
 #define KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)      \
 	KUNIT_UNARY_ASSERTION(test,					       \
 			      assert_type,				       \
@@ -845,9 +848,6 @@ void kunit_do_assertion(struct kunit *test,
 			      fmt,					       \
 			      ##__VA_ARGS__)
 
-#define KUNIT_FALSE_ASSERTION(test, assert_type, condition) \
-	KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, NULL)
-
 /*
  * A factory macro for defining the assertions and expectations for the basic
  * comparisons defined for the built in types.
@@ -864,7 +864,7 @@ void kunit_do_assertion(struct kunit *test,
  */
 #define KUNIT_BASE_BINARY_ASSERTION(test,				       \
 				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
+				    format_func,			       \
 				    assert_type,			       \
 				    left,				       \
 				    op,					       \
@@ -872,353 +872,56 @@ void kunit_do_assertion(struct kunit *test,
 				    fmt,				       \
 				    ...)				       \
 do {									       \
-	typeof(left) __left = (left);					       \
-	typeof(right) __right = (right);				       \
+	const typeof(left) __left = (left);				       \
+	const typeof(right) __right = (right);				       \
+	static const struct kunit_binary_assert_text __text = {		       \
+		.operation = #op,					       \
+		.left_text = #left,					       \
+		.right_text = #right,					       \
+	};								       \
 									       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			__left op __right,				       \
 			assert_class,					       \
-			ASSERT_CLASS_INIT(test,				       \
-					  assert_type,			       \
-					  #op,				       \
-					  #left,			       \
-					  __left,			       \
-					  #right,			       \
-					  __right),			       \
+			KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,	       \
+							&__text,	       \
+							__left,		       \
+							__right),	       \
 			fmt,						       \
 			##__VA_ARGS__);					       \
 } while (0)
 
-#define KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ...)				       \
-	KUNIT_BASE_BINARY_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left, ==, right,			       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ...)				       \
-	KUNIT_BASE_BINARY_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left, !=, right,			       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ...)				       \
-	KUNIT_BASE_BINARY_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left, <, right,			       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ...)				       \
-	KUNIT_BASE_BINARY_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left, <=, right,			       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
+#define KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left,				       \
+				   op,					       \
+				   right,				       \
+				   fmt,					       \
 				    ...)				       \
 	KUNIT_BASE_BINARY_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
+				    kunit_binary_assert,		       \
+				    kunit_binary_assert_format,		       \
 				    assert_type,			       \
-				    left, >, right,			       \
+				    left, op, right,			       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
+#define KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left,				       \
+				   op,					       \
+				   right,				       \
+				   fmt,					       \
 				    ...)				       \
 	KUNIT_BASE_BINARY_ASSERTION(test,				       \
-				    assert_class,			       \
-				    ASSERT_CLASS_INIT,			       \
-				    assert_type,			       \
-				    left, >=, right,			       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
-	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
-				    kunit_binary_assert,		       \
-				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_EQ_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
-				      assert_type,			       \
-				      left,				       \
-				      right,				       \
-				      NULL)
-
-#define KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_PTR_EQ_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
-#define KUNIT_BINARY_NE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
-	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
-				    kunit_binary_assert,		       \
-				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
-				      assert_type,			       \
-				      left,				       \
-				      right,				       \
-				      NULL)
-
-#define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
 				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_PTR_NE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
-#define KUNIT_BINARY_LT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
-	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
-				    kunit_binary_assert,		       \
-				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    kunit_binary_ptr_assert_format,	       \
 				    assert_type,			       \
-				    left,				       \
-				    right,				       \
+				    left, op, right,			       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
-#define KUNIT_BINARY_LT_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
-				      assert_type,			       \
-				      left,				       \
-				      right,				       \
-				      NULL)
-
-#define KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_PTR_LT_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
-#define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
-	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
-				    kunit_binary_assert,		       \
-				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_LE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
-				      assert_type,			       \
-				      left,				       \
-				      right,				       \
-				      NULL)
-
-#define KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_PTR_LE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
-#define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
-	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
-				    kunit_binary_assert,		       \
-				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_GT_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
-				      assert_type,			       \
-				      left,				       \
-				      right,				       \
-				      NULL)
-
-#define KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_PTR_GT_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
-#define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
-	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
-				    kunit_binary_assert,		       \
-				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_GE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
-				      assert_type,			       \
-				      left,				       \
-				      right,				       \
-				      NULL)
-
-#define KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_PTR_GE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_BINARY_STR_ASSERTION(test,				       \
 				   assert_type,				       \
 				   left,				       \
@@ -1228,85 +931,43 @@ do {									       \
 				   ...)					       \
 do {									       \
 	const char *__left = (left);					       \
-	const char *__right = (right);				       \
+	const char *__right = (right);					       \
+	static const struct kunit_binary_assert_text __text = {		       \
+		.operation = #op,					       \
+		.left_text = #left,					       \
+		.right_text = #right,					       \
+	};								       \
 									       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			strcmp(__left, __right) op 0,			       \
 			kunit_binary_str_assert,			       \
-			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,	       \
-							assert_type,	       \
-							#op,		       \
-							#left,		       \
+			KUNIT_INIT_BINARY_ASSERT_STRUCT(kunit_binary_str_assert_format,\
+							&__text,	       \
 							__left,		       \
-							#right,		       \
 							__right),	       \
 			fmt,						       \
 			##__VA_ARGS__);					       \
 } while (0)
 
-#define KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BINARY_STR_ASSERTION(test,				       \
-				   assert_type,				       \
-				   left, ==, right,			       \
-				   fmt,					       \
-				   ##__VA_ARGS__)
-
-#define KUNIT_BINARY_STR_EQ_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
-#define KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BINARY_STR_ASSERTION(test,				       \
-				   assert_type,				       \
-				   left, !=, right,			       \
-				   fmt,					       \
-				   ##__VA_ARGS__)
-
-#define KUNIT_BINARY_STR_NE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
 						assert_type,		       \
 						ptr,			       \
 						fmt,			       \
 						...)			       \
 do {									       \
-	typeof(ptr) __ptr = (ptr);					       \
+	const typeof(ptr) __ptr = (ptr);				       \
 									       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			!IS_ERR_OR_NULL(__ptr),				       \
 			kunit_ptr_not_err_assert,			       \
-			KUNIT_INIT_PTR_NOT_ERR_STRUCT(test,		       \
-						      assert_type,	       \
-						      #ptr,		       \
+			KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr,		       \
 						      __ptr),		       \
 			fmt,						       \
 			##__VA_ARGS__);					       \
 } while (0)
 
-#define KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, assert_type, ptr)	       \
-	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
-						assert_type,		       \
-						ptr,			       \
-						NULL)
-
 /**
  * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
  * @test: The test context object.
@@ -1319,7 +980,7 @@ do {									       \
  * *expectation failure*.
  */
 #define KUNIT_EXPECT_TRUE(test, condition) \
-	KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
+	KUNIT_EXPECT_TRUE_MSG(test, condition, NULL)
 
 #define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)		       \
 	KUNIT_TRUE_MSG_ASSERTION(test,					       \
@@ -1338,7 +999,7 @@ do {									       \
  * KUNIT_EXPECT_TRUE() for more information.
  */
 #define KUNIT_EXPECT_FALSE(test, condition) \
-	KUNIT_FALSE_ASSERTION(test, KUNIT_EXPECTATION, condition)
+	KUNIT_EXPECT_FALSE_MSG(test, condition, NULL)
 
 #define KUNIT_EXPECT_FALSE_MSG(test, condition, fmt, ...)		       \
 	KUNIT_FALSE_MSG_ASSERTION(test,					       \
@@ -1359,15 +1020,14 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_EQ(test, left, right) \
-	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_PTR_EQ() - Expects that pointers @left and @right are equal.
@@ -1381,18 +1041,14 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_PTR_EQ(test, left, right)				       \
-	KUNIT_BINARY_PTR_EQ_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right)
+	KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
-					  KUNIT_EXPECTATION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_NE() - An expectation that @left and @right are not equal.
@@ -1406,15 +1062,14 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_NE(test, left, right) \
-	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_NE_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_PTR_NE() - Expects that pointers @left and @right are not equal.
@@ -1428,18 +1083,14 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_PTR_NE(test, left, right)				       \
-	KUNIT_BINARY_PTR_NE_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right)
+	KUNIT_EXPECT_PTR_NE_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
-					  KUNIT_EXPECTATION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_LT() - An expectation that @left is less than @right.
@@ -1453,15 +1104,14 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_LT(test, left, right) \
-	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_LT_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_LT_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, <, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_LE() - Expects that @left is less than or equal to @right.
@@ -1475,15 +1125,14 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_LE(test, left, right) \
-	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_LE_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, <=, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_GT() - An expectation that @left is greater than @right.
@@ -1497,15 +1146,14 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_GT(test, left, right) \
-	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_GT_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_GT_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, >, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_GE() - Expects that @left is greater than or equal to @right.
@@ -1519,15 +1167,14 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_GE(test, left, right) \
-	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_GE_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_GE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
-				      KUNIT_EXPECTATION,		       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, >=, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_STREQ() - Expects that strings @left and @right are equal.
@@ -1541,15 +1188,14 @@ do {									       \
  * for more information.
  */
 #define KUNIT_EXPECT_STREQ(test, left, right) \
-	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_STREQ_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_STREQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
-					  KUNIT_EXPECTATION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_STRNEQ() - Expects that strings @left and @right are not equal.
@@ -1563,15 +1209,14 @@ do {									       \
  * for more information.
  */
 #define KUNIT_EXPECT_STRNEQ(test, left, right) \
-	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+	KUNIT_EXPECT_STRNEQ_MSG(test, left, right, NULL)
 
 #define KUNIT_EXPECT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
-					  KUNIT_EXPECTATION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
@@ -1584,7 +1229,7 @@ do {									       \
  * more information.
  */
 #define KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ptr) \
-	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_EXPECTATION, ptr)
+	KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
 
 #define KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
 	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
@@ -1608,7 +1253,7 @@ do {									       \
  * this is otherwise known as an *assertion failure*.
  */
 #define KUNIT_ASSERT_TRUE(test, condition) \
-	KUNIT_TRUE_ASSERTION(test, KUNIT_ASSERTION, condition)
+	KUNIT_ASSERT_TRUE_MSG(test, condition, NULL)
 
 #define KUNIT_ASSERT_TRUE_MSG(test, condition, fmt, ...)		       \
 	KUNIT_TRUE_MSG_ASSERTION(test,					       \
@@ -1627,7 +1272,7 @@ do {									       \
  * (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_FALSE(test, condition) \
-	KUNIT_FALSE_ASSERTION(test, KUNIT_ASSERTION, condition)
+	KUNIT_ASSERT_FALSE_MSG(test, condition, NULL)
 
 #define KUNIT_ASSERT_FALSE_MSG(test, condition, fmt, ...)		       \
 	KUNIT_FALSE_MSG_ASSERTION(test,					       \
@@ -1647,15 +1292,14 @@ do {									       \
  * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_EQ(test, left, right) \
-	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_EQ_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
-				      KUNIT_ASSERTION,			       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
@@ -1668,15 +1312,14 @@ do {									       \
  * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_PTR_EQ(test, left, right) \
-	KUNIT_BINARY_PTR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
-					  KUNIT_ASSERTION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_NE() - An assertion that @left and @right are not equal.
@@ -1689,15 +1332,14 @@ do {									       \
  * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_NE(test, left, right) \
-	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_NE_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
-				      KUNIT_ASSERTION,			       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_PTR_NE() - Asserts that pointers @left and @right are not equal.
@@ -1711,15 +1353,14 @@ do {									       \
  * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_PTR_NE(test, left, right) \
-	KUNIT_BINARY_PTR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_PTR_NE_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
-					  KUNIT_ASSERTION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 /**
  * KUNIT_ASSERT_LT() - An assertion that @left is less than @right.
  * @test: The test context object.
@@ -1732,15 +1373,14 @@ do {									       \
  * is not met.
  */
 #define KUNIT_ASSERT_LT(test, left, right) \
-	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_LT_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
-				      KUNIT_ASSERTION,			       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, <, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 /**
  * KUNIT_ASSERT_LE() - An assertion that @left is less than or equal to @right.
  * @test: The test context object.
@@ -1753,15 +1393,14 @@ do {									       \
  * KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_LE(test, left, right) \
-	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_LE_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_LE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
-				      KUNIT_ASSERTION,			       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, <=, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_GT() - An assertion that @left is greater than @right.
@@ -1775,15 +1414,14 @@ do {									       \
  * is not met.
  */
 #define KUNIT_ASSERT_GT(test, left, right) \
-	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_GT_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
-				      KUNIT_ASSERTION,			       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, >, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_GE() - Assertion that @left is greater than or equal to @right.
@@ -1797,15 +1435,14 @@ do {									       \
  * is not met.
  */
 #define KUNIT_ASSERT_GE(test, left, right) \
-	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_GE_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_GE_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
-				      KUNIT_ASSERTION,			       \
-				      left,				       \
-				      right,				       \
-				      fmt,				       \
-				      ##__VA_ARGS__)
+	KUNIT_BINARY_INT_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, >=, right,			       \
+				   fmt,					       \
+				    ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_STREQ() - An assertion that strings @left and @right are equal.
@@ -1818,15 +1455,14 @@ do {									       \
  * assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_STREQ(test, left, right) \
-	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_STREQ_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_STREQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
-					  KUNIT_ASSERTION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_STRNEQ() - Expects that strings @left and @right are not equal.
@@ -1840,15 +1476,14 @@ do {									       \
  * for more information.
  */
 #define KUNIT_ASSERT_STRNEQ(test, left, right) \
-	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+	KUNIT_ASSERT_STRNEQ_MSG(test, left, right, NULL)
 
 #define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
-	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
-					  KUNIT_ASSERTION,		       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ##__VA_ARGS__)
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
 
 /**
  * KUNIT_ASSERT_NOT_ERR_OR_NULL() - Assertion that @ptr is not null and not err.
@@ -1861,7 +1496,7 @@ do {									       \
  * KUNIT_ASSERT_TRUE()) when the assertion is not met.
  */
 #define KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr) \
-	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_ASSERTION, ptr)
+	KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
 
 #define KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
 	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index b972bda61c0c..d00d6d181ee8 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -10,12 +10,13 @@
 
 #include "string-stream.h"
 
-void kunit_base_assert_format(const struct kunit_assert *assert,
+void kunit_assert_prologue(const struct kunit_loc *loc,
+			   enum kunit_assert_type type,
 			      struct string_stream *stream)
 {
 	const char *expect_or_assert = NULL;
 
-	switch (assert->type) {
+	switch (type) {
 	case KUNIT_EXPECTATION:
 		expect_or_assert = "EXPECTATION";
 		break;
@@ -25,34 +26,33 @@ void kunit_base_assert_format(const struct kunit_assert *assert,
 	}
 
 	string_stream_add(stream, "%s FAILED at %s:%d\n",
-			  expect_or_assert, assert->file, assert->line);
+			  expect_or_assert, loc->file, loc->line);
 }
-EXPORT_SYMBOL_GPL(kunit_base_assert_format);
+EXPORT_SYMBOL_GPL(kunit_assert_prologue);
 
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
-	kunit_base_assert_format(assert, stream);
-	string_stream_add(stream, "%pV", &assert->message);
+	string_stream_add(stream, "%pV", message);
 }
 EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
 
 void kunit_unary_assert_format(const struct kunit_assert *assert,
+			       const struct va_format *message,
 			       struct string_stream *stream)
 {
 	struct kunit_unary_assert *unary_assert;
 
 	unary_assert = container_of(assert, struct kunit_unary_assert, assert);
 
-	kunit_base_assert_format(assert, stream);
 	if (unary_assert->expected_true)
 		string_stream_add(stream,
 				  KUNIT_SUBTEST_INDENT "Expected %s to be true, but is false\n",
@@ -61,11 +61,12 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
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
@@ -73,7 +74,6 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 	ptr_assert = container_of(assert, struct kunit_ptr_not_err_assert,
 				  assert);
 
-	kunit_base_assert_format(assert, stream);
 	if (!ptr_assert->value) {
 		string_stream_add(stream,
 				  KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
@@ -84,7 +84,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 				  ptr_assert->text,
 				  PTR_ERR(ptr_assert->value));
 	}
-	kunit_assert_print_msg(assert, stream);
+	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
 
@@ -112,6 +112,7 @@ static bool is_literal(struct kunit *test, const char *text, long long value,
 }
 
 void kunit_binary_assert_format(const struct kunit_assert *assert,
+				const struct va_format *message,
 				struct string_stream *stream)
 {
 	struct kunit_binary_assert *binary_assert;
@@ -119,27 +120,27 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 	binary_assert = container_of(assert, struct kunit_binary_assert,
 				     assert);
 
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
 			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
-			  binary_assert->left_text,
-			  binary_assert->operation,
-			  binary_assert->right_text);
-	if (!is_literal(stream->test, binary_assert->left_text,
+			  binary_assert->text->left_text,
+			  binary_assert->text->operation,
+			  binary_assert->text->right_text);
+	if (!is_literal(stream->test, binary_assert->text->left_text,
 			binary_assert->left_value, stream->gfp))
 		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
-				  binary_assert->left_text,
+				  binary_assert->text->left_text,
 				  binary_assert->left_value);
-	if (!is_literal(stream->test, binary_assert->right_text,
+	if (!is_literal(stream->test, binary_assert->text->right_text,
 			binary_assert->right_value, stream->gfp))
 		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
-				  binary_assert->right_text,
+				  binary_assert->text->right_text,
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
@@ -147,19 +148,18 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 	binary_assert = container_of(assert, struct kunit_binary_ptr_assert,
 				     assert);
 
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
 			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
-			  binary_assert->left_text,
-			  binary_assert->operation,
-			  binary_assert->right_text);
+			  binary_assert->text->left_text,
+			  binary_assert->text->operation,
+			  binary_assert->text->right_text);
 	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
-			  binary_assert->left_text,
+			  binary_assert->text->left_text,
 			  binary_assert->left_value);
 	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px",
-			  binary_assert->right_text,
+			  binary_assert->text->right_text,
 			  binary_assert->right_value);
-	kunit_assert_print_msg(assert, stream);
+	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
 
@@ -180,6 +180,7 @@ static bool is_str_literal(const char *text, const char *value)
 }
 
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
+				    const struct va_format *message,
 				    struct string_stream *stream)
 {
 	struct kunit_binary_str_assert *binary_assert;
@@ -187,20 +188,19 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 	binary_assert = container_of(assert, struct kunit_binary_str_assert,
 				     assert);
 
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
 			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
-			  binary_assert->left_text,
-			  binary_assert->operation,
-			  binary_assert->right_text);
-	if (!is_str_literal(binary_assert->left_text, binary_assert->left_value))
+			  binary_assert->text->left_text,
+			  binary_assert->text->operation,
+			  binary_assert->text->right_text);
+	if (!is_str_literal(binary_assert->text->left_text, binary_assert->left_value))
 		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"\n",
-				  binary_assert->left_text,
+				  binary_assert->text->left_text,
 				  binary_assert->left_value);
-	if (!is_str_literal(binary_assert->right_text, binary_assert->right_value))
+	if (!is_str_literal(binary_assert->text->right_text, binary_assert->right_value))
 		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"",
-				  binary_assert->right_text,
+				  binary_assert->text->right_text,
 				  binary_assert->right_value);
-	kunit_assert_print_msg(assert, stream);
+	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 51099b0ca29c..4bbf37c04eba 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -69,6 +69,47 @@ static void example_mark_skipped_test(struct kunit *test)
 	/* This line should run */
 	kunit_info(test, "You should see this line.");
 }
+
+/*
+ * This test shows off all the types of KUNIT_EXPECT macros.
+ */
+static void example_all_expect_macros_test(struct kunit *test)
+{
+	/* Boolean assertions */
+	KUNIT_EXPECT_TRUE(test, true);
+	KUNIT_EXPECT_FALSE(test, false);
+
+	/* Integer assertions */
+	KUNIT_EXPECT_EQ(test, 1, 1); /* check == */
+	KUNIT_EXPECT_GE(test, 1, 1); /* check >= */
+	KUNIT_EXPECT_LE(test, 1, 1); /* check <= */
+	KUNIT_EXPECT_NE(test, 1, 0); /* check != */
+	KUNIT_EXPECT_GT(test, 1, 0); /* check >  */
+	KUNIT_EXPECT_LT(test, 0, 1); /* check <  */
+
+	/* Pointer assertions */
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, test);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, NULL);
+	KUNIT_EXPECT_PTR_NE(test, test, NULL);
+
+	/* String assertions */
+	KUNIT_EXPECT_STREQ(test, "hi", "hi");
+	KUNIT_EXPECT_STRNEQ(test, "hi", "bye");
+
+	/*
+	 * There are also ASSERT variants of all of the above that abort test
+	 * execution if they fail. Useful for memory allocations, etc.
+	 */
+	KUNIT_ASSERT_GT(test, sizeof(char), 0);
+
+	/*
+	 * There are also _MSG variants of all of the above that let you include
+	 * additional text on failure.
+	 */
+	KUNIT_EXPECT_GT_MSG(test, sizeof(int), 0, "Your ints are 0-bit?!");
+	KUNIT_ASSERT_GT_MSG(test, sizeof(int), 0, "Your ints are 0-bit?!");
+}
+
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -83,6 +124,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_simple_test),
 	KUNIT_CASE(example_skip_test),
 	KUNIT_CASE(example_mark_skipped_test),
+	KUNIT_CASE(example_all_expect_macros_test),
 	{}
 };
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c7ed4aabec04..3bca3bf5c15b 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -240,7 +240,9 @@ static void kunit_print_string_stream(struct kunit *test,
 	}
 }
 
-static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
+static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
+		       enum kunit_assert_type type, struct kunit_assert *assert,
+		       const struct va_format *message)
 {
 	struct string_stream *stream;
 
@@ -250,12 +252,13 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
 	if (!stream) {
 		WARN(true,
 		     "Could not allocate stream to print failed assertion in %s:%d\n",
-		     assert->file,
-		     assert->line);
+		     loc->file,
+		     loc->line);
 		return;
 	}
 
-	assert->format(assert, stream);
+	kunit_assert_prologue(loc, type, stream);
+	assert->format(assert, message, stream);
 
 	kunit_print_string_stream(test, stream);
 
@@ -275,29 +278,27 @@ static void __noreturn kunit_abort(struct kunit *test)
 	WARN_ONCE(true, "Throw could not abort from test!\n");
 }
 
-void kunit_do_assertion(struct kunit *test,
-			struct kunit_assert *assert,
-			bool pass,
-			const char *fmt, ...)
+void kunit_do_failed_assertion(struct kunit *test,
+			       const struct kunit_loc *loc,
+			       enum kunit_assert_type type,
+			       struct kunit_assert *assert,
+			       const char *fmt, ...)
 {
 	va_list args;
-
-	if (pass)
-		return;
-
+	struct va_format message;
 	va_start(args, fmt);
 
-	assert->message.fmt = fmt;
-	assert->message.va = &args;
+	message.fmt = fmt;
+	message.va = &args;
 
-	kunit_fail(test, assert);
+	kunit_fail(test, loc, type, assert, &message);
 
 	va_end(args);
 
-	if (assert->type == KUNIT_ASSERTION)
+	if (type == KUNIT_ASSERTION)
 		kunit_abort(test);
 }
-EXPORT_SYMBOL_GPL(kunit_do_assertion);
+EXPORT_SYMBOL_GPL(kunit_do_failed_assertion);
 
 void kunit_init_test(struct kunit *test, const char *name, char *log)
 {
diff --git a/lib/list-test.c b/lib/list-test.c
index ee09505df16f..035ef6597640 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -161,6 +161,26 @@ static void list_test_list_del_init(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
 }
 
+static void list_test_list_del_init_careful(struct kunit *test)
+{
+	/* NOTE: This test only checks the behaviour of this function in
+	 * isolation. It does not verify memory model guarantees.
+	 */
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a -> b */
+	list_del_init_careful(&a);
+	/* after: [list] -> b, a initialised */
+
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
+}
+
 static void list_test_list_move(struct kunit *test)
 {
 	struct list_head a, b;
@@ -234,6 +254,24 @@ static void list_test_list_bulk_move_tail(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, i, 2);
 }
 
+static void list_test_list_is_head(struct kunit *test)
+{
+	struct list_head a, b, c;
+
+	/* Two lists: [a] -> b, [c] */
+	INIT_LIST_HEAD(&a);
+	INIT_LIST_HEAD(&c);
+	list_add_tail(&b, &a);
+
+	KUNIT_EXPECT_TRUE_MSG(test, list_is_head(&a, &a),
+		"Head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test, list_is_head(&a, &b),
+		"Non-head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test, list_is_head(&a, &c),
+		"Head element of different list");
+}
+
+
 static void list_test_list_is_first(struct kunit *test)
 {
 	struct list_head a, b;
@@ -511,6 +549,26 @@ static void list_test_list_entry(struct kunit *test)
 				struct list_test_struct, list));
 }
 
+static void list_test_list_entry_is_head(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2, test_struct3;
+
+	INIT_LIST_HEAD(&test_struct1.list);
+	INIT_LIST_HEAD(&test_struct3.list);
+
+	list_add_tail(&test_struct2.list, &test_struct1.list);
+
+	KUNIT_EXPECT_TRUE_MSG(test,
+		list_entry_is_head((&test_struct1), &test_struct1.list, list),
+		"Head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test,
+		list_entry_is_head((&test_struct2), &test_struct1.list, list),
+		"Non-head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test,
+		list_entry_is_head((&test_struct3), &test_struct1.list, list),
+		"Head element of different list");
+}
+
 static void list_test_list_first_entry(struct kunit *test)
 {
 	struct list_test_struct test_struct1, test_struct2;
@@ -707,9 +765,11 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_replace_init),
 	KUNIT_CASE(list_test_list_swap),
 	KUNIT_CASE(list_test_list_del_init),
+	KUNIT_CASE(list_test_list_del_init_careful),
 	KUNIT_CASE(list_test_list_move),
 	KUNIT_CASE(list_test_list_move_tail),
 	KUNIT_CASE(list_test_list_bulk_move_tail),
+	KUNIT_CASE(list_test_list_is_head),
 	KUNIT_CASE(list_test_list_is_first),
 	KUNIT_CASE(list_test_list_is_last),
 	KUNIT_CASE(list_test_list_empty),
@@ -724,6 +784,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_splice_init),
 	KUNIT_CASE(list_test_list_splice_tail_init),
 	KUNIT_CASE(list_test_list_entry),
+	KUNIT_CASE(list_test_list_entry_is_head),
 	KUNIT_CASE(list_test_list_first_entry),
 	KUNIT_CASE(list_test_list_last_entry),
 	KUNIT_CASE(list_test_list_first_entry_or_null),
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7a706f96f68d..9274c6355809 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -17,7 +17,7 @@ assert sys.version_info >= (3, 7), "Python version is too old"
 
 from dataclasses import dataclass
 from enum import Enum, auto
-from typing import Any, Iterable, Sequence, List, Optional
+from typing import Iterable, List, Optional, Sequence, Tuple
 
 import kunit_json
 import kunit_kernel
@@ -32,7 +32,6 @@ class KunitStatus(Enum):
 @dataclass
 class KunitResult:
 	status: KunitStatus
-	result: Any
 	elapsed_time: float
 
 @dataclass
@@ -82,10 +81,8 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
 	config_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.CONFIG_FAILURE,
-				   'could not configure kernel',
 				   config_end - config_start)
 	return KunitResult(KunitStatus.SUCCESS,
-			   'configured kernel successfully',
 			   config_end - config_start)
 
 def build_tests(linux: kunit_kernel.LinuxSourceTree,
@@ -100,14 +97,11 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 	build_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE,
-				   'could not build kernel',
 				   build_end - build_start)
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE,
-				   'could not build kernel',
 				   build_end - build_start)
 	return KunitResult(KunitStatus.SUCCESS,
-			   'built kernel successfully',
 			   build_end - build_start)
 
 def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
@@ -173,14 +167,14 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 			filter_glob=filter_glob,
 			build_dir=request.build_dir)
 
-		result = parse_tests(request, run_result)
+		_, test_result = parse_tests(request, run_result)
 		# run_kernel() doesn't block on the kernel exiting.
 		# That only happens after we get the last line of output from `run_result`.
 		# So exec_time here actually contains parsing + execution time, which is fine.
 		test_end = time.time()
 		exec_time += test_end - test_start
 
-		test_counts.add_subtest_counts(result.result.counts)
+		test_counts.add_subtest_counts(test_result.counts)
 
 	if len(filter_globs) == 1 and test_counts.crashed > 0:
 		bd = request.build_dir
@@ -189,7 +183,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 				bd, bd, kunit_kernel.get_outfile_path(bd), bd, sys.argv[0]))
 
 	kunit_status = _map_to_overall_status(test_counts.get_status())
-	return KunitResult(status=kunit_status, result=result, elapsed_time=exec_time)
+	return KunitResult(status=kunit_status, elapsed_time=exec_time)
 
 def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
 	if test_status in (kunit_parser.TestStatus.SUCCESS, kunit_parser.TestStatus.SKIPPED):
@@ -197,7 +191,7 @@ def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
 	else:
 		return KunitStatus.TEST_FAILURE
 
-def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitResult:
+def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[KunitResult, kunit_parser.Test]:
 	parse_start = time.time()
 
 	test_result = kunit_parser.Test()
@@ -231,11 +225,9 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitR
 			print(json_obj)
 
 	if test_result.status != kunit_parser.TestStatus.SUCCESS:
-		return KunitResult(KunitStatus.TEST_FAILURE, test_result,
-				   parse_end - parse_start)
+		return KunitResult(KunitStatus.TEST_FAILURE, parse_end - parse_start), test_result
 
-	return KunitResult(KunitStatus.SUCCESS, test_result,
-				parse_end - parse_start)
+	return KunitResult(KunitStatus.SUCCESS, parse_end - parse_start), test_result
 
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
@@ -513,7 +505,7 @@ def main(argv, linux=None):
 		request = KunitParseRequest(raw_output=cli_args.raw_output,
 					    build_dir='',
 					    json=cli_args.json)
-		result = parse_tests(request, kunit_output)
+		result, _ = parse_tests(request, kunit_output)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	else:

--------------DC1A7EE224A683C6C672C857--
