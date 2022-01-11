Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADBD48B787
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 20:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbiAKTmw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 14:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbiAKTmu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 14:42:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350D9C061748
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:42:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v66-20020a256145000000b006115377709aso66945ybb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0ZjUIsLW4acHCjBv+u6cMQmjq5bt8fbJ806Zes8EZIE=;
        b=sQL03s7vgv1vzShIYJCYEgWgL8UsKXJ/CtD9/dVCEARL96A5mtf6TDO9DH9SJwPIZM
         XjKg5FXk0TmxaIWA4pbZfrq2ZwgKKdy65x/X+xBYVjs6TZpAWXmH7cSSpSTTAfAUAM3+
         tcxjJRRR74sp25hss6iri/Q8XK86hgDpJz9RU4hwk+91wi2Ggh/JscN9K1K5j1IrEftA
         6Wl6abam9t63aKn3pLFzeyXFtgmwd1iz3od5cnTw5Y1+DSbRqUzIr0/2qtNvidI6xNqU
         tjVhJ4rYxf7SsbIyGTeBVdN2FKNDixNySKhcr44DX6nDYV7wtEYnqccuxBLqs41cP2z5
         9DTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0ZjUIsLW4acHCjBv+u6cMQmjq5bt8fbJ806Zes8EZIE=;
        b=gXnlYXZ+12Y+dYj0Oxopd0l8wlEEgEZ+Z36WCH0QF+AjXD1bOaXQToAi8LIdP7SVlQ
         ny+ejF+6P5llDAwnJvquMFys721cEJdM/6JTkqJwLHNBzZ03clsmZNMUVaKieS23LG4J
         ZJ40XZxhOORDw57gJtOBedjS5/cX4ml9ctFfsn8KyHg5bD6jNlddP/3nhY7DEf7j5KPA
         /1whQSRKbdNWSShPzWT6tKPbkk5rldAzUDW8jKzkjjxOI+DAt82HobD8Uw8ECfw8OqX0
         zCPNEEJRZ5/jVCtdbYX+WjngcvM6WgB58pnbweWekBDerqRmHeAy0GL/0hk/luozCdIM
         yY2w==
X-Gm-Message-State: AOAM531MOm5mao/vRksCfnifQJM/LEwB42TubGliesmj8pIsx4/fkjkj
        TjDBHu5CeD4akB4xZaydQAzlIbYq/JAwhw==
X-Google-Smtp-Source: ABdhPJxEyrBFfq0EYaHGpSsAPYXRIdOZ3Ncs6drlt0Rmh9umYGkQ5WeQEHRGNEmQLAyl+Xx3Qa3D5/15ICrrUw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8c76:9de0:1a30:7de8])
 (user=dlatypov job=sendgmr) by 2002:a25:cdc3:: with SMTP id
 d186mr8428161ybf.400.1641930169460; Tue, 11 Jan 2022 11:42:49 -0800 (PST)
Date:   Tue, 11 Jan 2022 11:42:30 -0800
In-Reply-To: <20220111194231.1797841-1-dlatypov@google.com>
Message-Id: <20220111194231.1797841-6-dlatypov@google.com>
Mime-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH v2 5/6] kunit: split out part of kunit_assert into a static const
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
if (__builtin_expect(!!(!(false)), 0)) {
  static const struct kunit_loc loc = { .file = ... };
  struct kunit_fail_assert __assertion = { .assert = { .type ...  };
  kunit_do_failed_assertion(test, &loc, KUNIT_EXPECTATION, &__assertion.assert, ...);
};

[1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: David Gow <davidgow@google.com>
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
index 25ea3bce6663..7b752175e614 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -772,13 +772,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
 #define KUNIT_SUCCEED(test) do {} while (0)
 
 void kunit_do_failed_assertion(struct kunit *test,
+			       const struct kunit_loc *loc,
+			       enum kunit_assert_type type,
 			       struct kunit_assert *assert,
 			       const char *fmt, ...);
 
-#define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
+#define KUNIT_ASSERTION(test, assert_type, pass, assert_class, INITIALIZER, fmt, ...) do { \
 	if (unlikely(!(pass))) {					       \
+		static const struct kunit_loc loc = KUNIT_CURRENT_LOC;	       \
 		struct assert_class __assertion = INITIALIZER;		       \
 		kunit_do_failed_assertion(test,				       \
+					  &loc,				       \
+					  assert_type,			       \
 					  &__assertion.assert,		       \
 					  fmt,				       \
 					  ##__VA_ARGS__);		       \
@@ -788,6 +793,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 
 #define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...)		       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			false,						       \
 			kunit_fail_assert,				       \
 			KUNIT_INIT_FAIL_ASSERT_STRUCT(assert_type),      \
@@ -818,6 +824,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 			      fmt,					       \
 			      ...)					       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			!!(condition) == !!expected_true,		       \
 			kunit_unary_assert,				       \
 			KUNIT_INIT_UNARY_ASSERT_STRUCT(assert_type,	       \
@@ -876,6 +883,7 @@ do {									       \
 	typeof(right) __right = (right);				       \
 									       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			__left op __right,				       \
 			assert_class,					       \
 			ASSERT_CLASS_INIT(assert_type,			       \
@@ -1230,6 +1238,7 @@ do {									       \
 	const char *__right = (right);				       \
 									       \
 	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
 			strcmp(__left, __right) op 0,			       \
 			kunit_binary_str_assert,			       \
 			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(assert_type,       \
@@ -1289,6 +1298,7 @@ do {									       \
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
index 345a9dd88c27..7dec3248562f 100644
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
 
 void kunit_do_failed_assertion(struct kunit *test,
+			       const struct kunit_loc *loc,
+			       enum kunit_assert_type type,
 			       struct kunit_assert *assert,
 			       const char *fmt, ...)
 {
@@ -286,11 +289,11 @@ void kunit_do_failed_assertion(struct kunit *test,
 	assert->message.fmt = fmt;
 	assert->message.va = &args;
 
-	kunit_fail(test, assert);
+	kunit_fail(test, loc, type, assert);
 
 	va_end(args);
 
-	if (assert->type == KUNIT_ASSERTION)
+	if (type == KUNIT_ASSERTION)
 		kunit_abort(test);
 }
 EXPORT_SYMBOL_GPL(kunit_do_failed_assertion);
-- 
2.34.1.575.g55b058a8bb-goog

