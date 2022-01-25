Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AFA49BD98
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 22:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiAYVBD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 16:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiAYVAd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 16:00:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43C5C061744
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 13:00:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u185-20020a2560c2000000b0060fd98540f7so43967503ybb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 13:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PnhbZKIYa8wTZ5Q0pqZwN7UuO5Cn2oSOpbwAfA2BCf4=;
        b=J6ih3SCpSCowfaTACnSWbAYrjoWbOfS+5K8syXJCtBDstndXOzeMD/klS6/EGxc5Bc
         Rlg8t+1dyc+jL9Aq8p0kZ50BhKa0wcqGnWZ9YjS/r5z9bqOsHmHzMy5As7ZuanFUJahE
         wfroa1+9qVzH71JD2x1VnBNVIXniLD8hL6viK4tMT8Ix3M901WTTFnrvjcn4PXpU9GYi
         yfezwd0YJ7FqucIXoO0ytC34eBPrrH4anYNcWeSHdB0fXrM14A3pDmw7mXA2anLeq8JJ
         DrCeuzdXNCmI3nCk2bYIxERGZ09vgPAhlLKzNac0jHxF/EMCvVoLgcEGDerxlVOdnoOc
         N1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PnhbZKIYa8wTZ5Q0pqZwN7UuO5Cn2oSOpbwAfA2BCf4=;
        b=8C9qegx+QJFaLTpyc8lv/p885Iw2DOLZIZD8jXVvT8mH/xO4O7zOK8NOxjVrG6aseX
         h4Ot7fSKD20wijt8iKCO3f4CbIrEtEWz+wztnZk3rFwZldeWSIme5aSTg8JjKDWlPPQg
         lWzmq6ilhOrxhjF4MCCBkLSNjQiHMh/J+9e+A7QNKazcLK4T1E+lM21LddGql7H6J6+b
         xrXDU+6erxUBXyB/bJQn03YHvWN0h8fHOmYBf/8abL9MVrV1OPN0iC4yD4t2/yhg7jTI
         leOzQ+j0C5lvGC2A1Us5rzY9KGhL5iH5tHmnZAxoe37mno9kNOmqXvPqc/JJNbi5P7LA
         zSyQ==
X-Gm-Message-State: AOAM530Xf37/pdh5nnLn+gZ2bgvVyn3OEUSizKOoMHrbXV3CuPOG9r0n
        0mHls3XK+HZnz/p1Z463Y5UNs8b/Wd7f6w==
X-Google-Smtp-Source: ABdhPJyMZhNYyS83wOWFPezd3HvWn8rCBp+/mGJ50rt71YCf2/TwJNzf8xalNeNJreVU2FGNkol0rw41eob3Iw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:ec63:7812:5e4a:c688])
 (user=dlatypov job=sendgmr) by 2002:a25:2743:: with SMTP id
 n64mr31434847ybn.417.1643144432175; Tue, 25 Jan 2022 13:00:32 -0800 (PST)
Date:   Tue, 25 Jan 2022 13:00:11 -0800
In-Reply-To: <20220125210011.3817742-1-dlatypov@google.com>
Message-Id: <20220125210011.3817742-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20220125210011.3817742-1-dlatypov@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH 3/3] kunit: factor out str constants from binary assertion structs
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If the compiler doesn't optimize them away, each kunit assertion (use of
KUNIT_EXPECT_EQ, etc.) can use 88 bytes of stack space in the worst and
most common case. This has led to compiler warnings and a suggestion
from Linus to move data from the structs into static const's where
possible [1].

This builds upon [2] which did so for the base struct kunit_assert type.
That only reduced sizeof(struct kunit_binary_assert) from 88 to 64.

Given these are by far the most commonly used asserts, this patch
factors out the textual representations of the operands and comparator
into another static const, saving 16 more bytes.

In detail, KUNIT_EXPECT_EQ(test, 2 + 2, 5) yields the following struct
  (struct kunit_binary_assert) {
    .assert = <struct kunit_assert>,
    .operation = "==",
    .left_text = "2 + 2",
    .left_value = 4,
    .right_text = "5",
    .right_value = 5,
  }
After this change
  static const struct kunit_binary_assert_text __text = {
    .operation = "==",
    .left_text = "2 + 2",
    .right_text = "5",
  };
  (struct kunit_binary_assert) {
    .assert = <struct kunit_assert>,
    .text = &__text,
    .left_value = 4,
    .right_value = 5,
  }

This also DRYs the code a bit more since these str fields were repeated
for the string and pointer versions of kunit_binary_assert.

Note: we could name the kunit_binary_assert_text fields left/right
instead of left_text/right_text. But that would require changing the
macros a bit since they have args called "left" and "right" which would
be substituted in `.left = #left` as `.2 + 2 = \"2 + 2\"`.

[1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
[2] https://lore.kernel.org/linux-kselftest/20220113165931.451305-6-dlatypov@google.com/

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/assert.h | 49 +++++++++++++++++++-----------------------
 include/kunit/test.h   | 20 +++++++++++------
 lib/kunit/assert.c     | 38 ++++++++++++++++----------------
 3 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 649bfac9f406..4b52e12c2ae8 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -150,14 +150,25 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
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
@@ -166,10 +177,8 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
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
 
@@ -182,10 +191,8 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
  *	kunit_binary_assert, kunit_binary_ptr_assert, etc.
  *
  * @format_func: a function which formats the assert to a string.
- * @op_str: A string representation of the comparison operator (e.g. "==").
- * @left_str: A string representation of the expression in the left slot.
+ * @text_: Pointer to a kunit_binary_assert_text.
  * @left_val: The actual evaluated value of the expression in the left slot.
- * @right_str: A string representation of the expression in the right slot.
  * @right_val: The actual evaluated value of the expression in the right slot.
  *
  * Initializes a binary assert like kunit_binary_assert,
@@ -194,16 +201,12 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
  * This is ultimately used by binary assertion macros like KUNIT_EXPECT_EQ, etc.
  */
 #define KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,			       \
-					op_str,				       \
-					left_str,			       \
+					text_,				       \
 					left_val,			       \
-					right_str,			       \
 					right_val) {			       \
 	.assert = { .format = format_func },				       \
-	.operation = op_str,						       \
-	.left_text = left_str,						       \
+	.text = text_,							       \
 	.left_value = left_val,						       \
-	.right_text = right_str,					       \
 	.right_value = right_val					       \
 }
 
@@ -211,10 +214,8 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
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
@@ -223,10 +224,8 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
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
 
@@ -238,10 +237,8 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
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
@@ -250,10 +247,8 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
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
 
diff --git a/include/kunit/test.h b/include/kunit/test.h
index a93dfb8ff393..088ff394ae94 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -874,16 +874,19 @@ void kunit_do_failed_assertion(struct kunit *test,
 do {									       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	static const struct kunit_binary_assert_text __text = {		       \
+		.operation = #op,					       \
+		.left_text = #left,					       \
+		.right_text = #right,					       \
+	};								       \
 									       \
 	KUNIT_ASSERTION(test,						       \
 			assert_type,					       \
 			__left op __right,				       \
 			assert_class,					       \
 			KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,	       \
-							#op,		       \
-							#left,		       \
+							&__text,	       \
 							__left,		       \
-							#right,		       \
 							__right),	       \
 			fmt,						       \
 			##__VA_ARGS__);					       \
@@ -928,17 +931,20 @@ do {									       \
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
 			assert_type,					       \
 			strcmp(__left, __right) op 0,			       \
 			kunit_binary_str_assert,			       \
 			KUNIT_INIT_BINARY_ASSERT_STRUCT(kunit_binary_str_assert_format,\
-							#op,		       \
-							#left,		       \
+							&__text,	       \
 							__left,		       \
-							#right,		       \
 							__right),	       \
 			fmt,						       \
 			##__VA_ARGS__);					       \
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index c9c7ee0dfafa..d00d6d181ee8 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -122,18 +122,18 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 
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
 	kunit_assert_print_msg(message, stream);
 }
@@ -150,14 +150,14 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 
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
 	kunit_assert_print_msg(message, stream);
 }
@@ -190,16 +190,16 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 
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
 	kunit_assert_print_msg(message, stream);
 }
-- 
2.35.0.rc2.247.g8bbb082509-goog

