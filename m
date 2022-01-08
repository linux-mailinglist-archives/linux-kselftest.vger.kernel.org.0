Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573D8488074
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jan 2022 02:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiAHBXi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jan 2022 20:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiAHBXg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jan 2022 20:23:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D39C06173E
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jan 2022 17:23:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i129-20020a255487000000b006107b38b495so6447275ybb.16
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jan 2022 17:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zl3tYUGZQ69Xabi7Vl+AmAQkNx7RzOfesWcbmkVMLC0=;
        b=ir0flGO7cqrT+By+EKhPJd20fm00kXlllVFU+soUpFIn6IqY/4bDgJ9NmeoyOFyGMX
         KkIPjNCKZcQKtV06ZLBdhJXaGZEEK6jMZW/f20fXsgDbyydiog5QBRK+CRfO5FMXB52E
         QWNO3oi+FWiUFA6AdZWiMPzBsmDmxwQHGO0nSNF2B8WGgNOoIXCHTj3XjNWH/rS+EV0c
         HVjH7OC4Huv4BQOjGezbxecIqHHMye9Yocd/8MTpQ+TDAWLkbZkR5Zc4+hck4al90Q4p
         yHL7xrInFqX3AN+H1l4sxBb6JyPiyM8bbvE5EBE8SB4vJdGQ2rqKBjVEs1tgKzuZEcgm
         smrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zl3tYUGZQ69Xabi7Vl+AmAQkNx7RzOfesWcbmkVMLC0=;
        b=yacb5bR5Wru89/7Er/QhXJP/QaSt5f/S4indP1Osnd+QYSS2zy6TFgwVcRNJ+ANRit
         2SOLmc4muHESlS+79JVa98D44NIYULck6I7Gv8IgW5CUzLqsxv7BdkNP0TQrgI8W88s+
         Zwyc5kr9sPAX15Y7cLVgWaDcwPVyHvd1o5UholjQ/9RRa+zaMlV0ZRwg/73wWWHINnuy
         KOSqix/CPpo0JEvcJnttiIFsr41fi71pUeFuwEhr9NohZR/4jqYLyhtq3IwTGqAyCPYT
         ymu3tmh4mWbXhfEzASmjvspJalpBBjd6tWq0nII7bugDZHw73/CJgkCLhnI0Z85cdJG+
         HUoQ==
X-Gm-Message-State: AOAM531o/LqRHjzhqCSpWm0to4YTU/pLTtTYmw6PFfWCafilrNgqw1no
        9/aKpUVrDyWxDPnJMv2G0YhkFmwoFP99Kg==
X-Google-Smtp-Source: ABdhPJxhgH/z/ZwRJwL4bRP4xb8fEBdVqhdaTg9EVoCmk/1ZcrubjfB3aXrl8dmxTnklc+7BnKr0gWOqzEyUDQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bf8a:7e90:eb70:9b2b])
 (user=dlatypov job=sendgmr) by 2002:a25:403:: with SMTP id
 3mr68628764ybe.696.1641605015212; Fri, 07 Jan 2022 17:23:35 -0800 (PST)
Date:   Fri,  7 Jan 2022 17:23:03 -0800
In-Reply-To: <20220108012304.1049587-1-dlatypov@google.com>
Message-Id: <20220108012304.1049587-6-dlatypov@google.com>
Mime-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH 5/6] kunit: split out part of kunit_assert into a static const
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        torvalds@linux-foundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is per Linus's suggestion in [1].

The issue there is that every KUNIT_EXPECT/KUNIT_ASSERT puts a
kunit_assert object onto the stack. Normally we rely on compilers to
elide this, but when that doesn't work out, this blows up the stack
usage of kunit test functions.

We can move some data off the stack by making it static.
This change introduces a new `struct kunit_loc` to hold the file and
line number and then just passing assert_type (EXPECT or ASSERT) as an
argument.

In [1], it was suggested to also move out the format string as well, but
users could theoretically craft a format string at runtime, so we can't.

This change leaves a copy of `assert_type` in kunit_assert for now
because cleaning up all the macros to not pass it around is a bit more
involved.

Here's an example of the expanded code for KUNIT_FAIL():
if (!(false)) {
  static const struct kunit_loc loc = { .file = ... };
  struct kunit_unary_assert __assertion = { .assert = { .type ...  };
  kunit_failed_assertion(test, &loc, &__assertion.assert, ((void *)0));
};

[1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/kunit/assert.h | 25 ++++++++++++++++---------
 include/kunit/test.h   | 12 +++++++++++-
 lib/kunit/assert.c     |  9 +++++----
 lib/kunit/test.c       | 15 +++++++++------
 4 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 3da6c792496c..4f91dbdb886a 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -28,11 +28,21 @@ enum kunit_assert_type {
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
  * @type: the type (either an expectation or an assertion) of this kunit_assert.
- * @line: the source code line number that the expectation/assertion is at.
- * @file: the file path of the source file that the expectation/assertion is in.
  * @message: an optional message to provide additional context.
  * @format: a function which formats the data in this kunit_assert to a string.
  *
@@ -40,9 +50,7 @@ enum kunit_assert_type {
  * format a string to a user reporting the failure.
  */
 struct kunit_assert {
-	enum kunit_assert_type type;
-	int line;
-	const char *file;
+	enum kunit_assert_type type; // TODO(dlatypov@google.com): delete this
 	struct va_format message;
 	void (*format)(const struct kunit_assert *assert,
 		       struct string_stream *stream);
@@ -65,14 +73,13 @@ struct kunit_assert {
  */
 #define KUNIT_INIT_ASSERT_STRUCT(assert_type, fmt) {			       \
 	.type = assert_type,						       \
-	.file = __FILE__,						       \
-	.line = __LINE__,						       \
 	.message = KUNIT_INIT_VA_FMT_NULL,				       \
 	.format = fmt							       \
 }
 
-void kunit_base_assert_format(const struct kunit_assert *assert,
-			      struct string_stream *stream);
+void kunit_assert_prologue(const struct kunit_loc *loc,
+			   enum kunit_assert_type type,
+			   struct string_stream *stream);
 
 void kunit_assert_print_msg(const struct kunit_assert *assert,
 			    struct string_stream *stream);
diff --git a/include/kunit/test.h b/include/kunit/test.h
index ebd45593321e..6e201b45ada6 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -771,13 +771,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
 #define KUNIT_SUCCEED(test) do {} while (0)
 
 void kunit_failed_assertion(struct kunit *test,
+			    const struct kunit_loc *loc,
+			    enum kunit_assert_type type,
 			    struct kunit_assert *assert,
 			    const char *fmt, ...);
 
-#define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
+#define KUNIT_ASSERTION(test, assert_type, pass, assert_class, INITIALIZER, fmt, ...) do { \
 	if (!(pass)) {							       \
+		static const struct kunit_loc loc = KUNIT_CURRENT_LOC;	       \
 		struct assert_class __assertion = INITIALIZER;		       \
 		kunit_failed_assertion(test,				       \
+				       &loc,				       \
+				       assert_type,			       \
 				       &__assertion.assert,		       \
 				       fmt,				       \
 				       ##__VA_ARGS__);			       \
@@ -787,6 +792,7 @@ void kunit_failed_assertion(struct kunit *test,
 
 #define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...)		       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			false,						       \
 			kunit_fail_assert,				       \
 			KUNIT_INIT_FAIL_ASSERT_STRUCT(assert_type),      \
@@ -817,6 +823,7 @@ void kunit_failed_assertion(struct kunit *test,
 			      fmt,					       \
 			      ...)					       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			!!(condition) == !!expected_true,		       \
 			kunit_unary_assert,				       \
 			KUNIT_INIT_UNARY_ASSERT_STRUCT(assert_type,	       \
@@ -875,6 +882,7 @@ do {									       \
 	typeof(right) __right = (right);				       \
 									       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			__left op __right,				       \
 			assert_class,					       \
 			ASSERT_CLASS_INIT(assert_type,			       \
@@ -1229,6 +1237,7 @@ do {									       \
 	const char *__right = (right);				       \
 									       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			strcmp(__left, __right) op 0,			       \
 			kunit_binary_str_assert,			       \
 			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(assert_type,       \
@@ -1288,6 +1297,7 @@ do {									       \
 	typeof(ptr) __ptr = (ptr);					       \
 									       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			!IS_ERR_OR_NULL(__ptr),				       \
 			kunit_ptr_not_err_assert,			       \
 			KUNIT_INIT_PTR_NOT_ERR_STRUCT(assert_type,	       \
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 4d9a1295efc7..9f4492a8e24e 100644
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
@@ -25,9 +26,9 @@ void kunit_base_assert_format(const struct kunit_assert *assert,
 	}
 
 	string_stream_add(stream, "%s FAILED at %s:%d\n",
-			  expect_or_assert, assert->file, assert->line);
+			  expect_or_assert, loc->file, loc->line);
 }
-EXPORT_SYMBOL_GPL(kunit_base_assert_format);
+EXPORT_SYMBOL_GPL(kunit_assert_prologue);
 
 void kunit_assert_print_msg(const struct kunit_assert *assert,
 			    struct string_stream *stream)
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 735c1b67d843..3108ed0575d4 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -240,7 +240,8 @@ static void kunit_print_string_stream(struct kunit *test,
 	}
 }
 
-static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
+static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
+		       enum kunit_assert_type type, struct kunit_assert *assert)
 {
 	struct string_stream *stream;
 
@@ -250,12 +251,12 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
 	if (!stream) {
 		WARN(true,
 		     "Could not allocate stream to print failed assertion in %s:%d\n",
-		     assert->file,
-		     assert->line);
+		     loc->file,
+		     loc->line);
 		return;
 	}
 
-	kunit_base_assert_format(assert, stream);
+	kunit_assert_prologue(loc, type, stream);
 	assert->format(assert, stream);
 
 	kunit_print_string_stream(test, stream);
@@ -277,6 +278,8 @@ static void __noreturn kunit_abort(struct kunit *test)
 }
 
 void kunit_failed_assertion(struct kunit *test,
+			    const struct kunit_loc *loc,
+			    enum kunit_assert_type type,
 			    struct kunit_assert *assert,
 			    const char *fmt, ...)
 {
@@ -286,11 +289,11 @@ void kunit_failed_assertion(struct kunit *test,
 	assert->message.fmt = fmt;
 	assert->message.va = &args;
 
-	kunit_fail(test, assert);
+	kunit_fail(test, loc, type, assert);
 
 	va_end(args);
 
-	if (assert->type == KUNIT_ASSERTION)
+	if (type == KUNIT_ASSERTION)
 		kunit_abort(test);
 }
 EXPORT_SYMBOL_GPL(kunit_failed_assertion);
-- 
2.34.1.575.g55b058a8bb-goog

