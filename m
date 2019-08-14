Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633568CB64
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2019 07:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfHNFxt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Aug 2019 01:53:49 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:43527 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfHNFwW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Aug 2019 01:52:22 -0400
Received: by mail-vs1-f74.google.com with SMTP id p63so2167551vsd.10
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2019 22:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c9HdQNUc/QzKY3rRahJT8eukla0s2Ua8md5qT18TEw8=;
        b=u+vsjmKBzcPBBARThL4C+8C5vkyMgU4hW4H3vFWhbBOEWgkujyxd4+IuL/TrJF8rGA
         9LqnlQ9WeKmcIfPF3n0n/h6ysT78tLLr03yNcKZq5j2lbCwHHT2BaFK7A/uYUfvVNF5L
         JBPPabagZW5ptAZ3SEdoQ//IK6jD+7/Omzjxn7xtIXc4+YJhrjbpUMuAsQOagtSR++CY
         zO2AZas/Mg3FCF/KI62Za+v5BSSKu9wZUEmNGw6mBasKGCp+MSjjagOdsAYNy4RLIvqU
         +zZb+ER4al237maMsfrHvK6ah3DYNa89sDKSbAEmCiPZY/Ptypn1WCAdaoH2aDtLofz0
         rUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c9HdQNUc/QzKY3rRahJT8eukla0s2Ua8md5qT18TEw8=;
        b=mJg32YfiQsmWe5rKuoOHDgo5miTE4QFoOMv8hzf4+3wucSBBeIf9eKTbJD5B20qFfm
         e2kTdW2L7lYfwqr1l7xTKEeizwgo2Rvl3lGXbtJeUDje97XUSPYWh4Gf8djQ9sMy25i5
         VBYl2ODrgx1aziGOT3tuk7JPWrq10Pn9WmHZowDQL1UVoHDBEGYiEzuS+LZUbRmLgNeo
         aSybqtlsGSoY3HdU6ukcMTbHb6DjEydHWdJFNixEFoaBZb9oaqyVZAIQ3mIedfoygTaR
         T5gusUiOao2AsIpoFsykfCFo8Qq5ptn9HH7Ngv5uKDJXDtG93P/Byrcc9iN/sLVlLkEF
         4NTw==
X-Gm-Message-State: APjAAAVcmO1ljZ779UZtuErTPea9d1ASwJbjW91r/WhJ0GBd6rvC0/PC
        RxBN78G8jpBXem8I0Sk7keGJb6bDC+xQPH4WRLyWvA==
X-Google-Smtp-Source: APXvYqyHV/u0FrJ7yIPXIDTnlGMB24jJxrblTbG/QlS4lRmw4MZfCQGRvJV/33bxnUnoxdB7bwriU3q06DLYUbTcU5fmmg==
X-Received: by 2002:ab0:4744:: with SMTP id i4mr764853uac.63.1565761939878;
 Tue, 13 Aug 2019 22:52:19 -0700 (PDT)
Date:   Tue, 13 Aug 2019 22:50:54 -0700
In-Reply-To: <20190814055108.214253-1-brendanhiggins@google.com>
Message-Id: <20190814055108.214253-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190814055108.214253-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v13 04/18] kunit: test: add assertion printing library
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add `struct kunit_assert` and friends which provide a structured way to
capture data from an expectation or an assertion (introduced later in
the series) so that it may be printed out in the event of a failure.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/assert.h | 356 +++++++++++++++++++++++++++++++++++++++++
 kunit/Makefile         |   3 +-
 kunit/assert.c         | 141 ++++++++++++++++
 3 files changed, 499 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/assert.h
 create mode 100644 kunit/assert.c

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
new file mode 100644
index 0000000000000..db6a0fca09b49
--- /dev/null
+++ b/include/kunit/assert.h
@@ -0,0 +1,356 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Assertion and expectation serialization API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_ASSERT_H
+#define _KUNIT_ASSERT_H
+
+#include <kunit/string-stream.h>
+#include <linux/err.h>
+
+struct kunit;
+
+/**
+ * enum kunit_assert_type - Type of expectation/assertion.
+ * @KUNIT_ASSERTION: Used to denote that a kunit_assert represents an assertion.
+ * @KUNIT_EXPECTATION: Denotes that a kunit_assert represents an expectation.
+ *
+ * Used in conjunction with a &struct kunit_assert to denote whether it
+ * represents an expectation or an assertion.
+ */
+enum kunit_assert_type {
+	KUNIT_ASSERTION,
+	KUNIT_EXPECTATION,
+};
+
+/**
+ * struct kunit_assert - Data for printing a failed assertion or expectation.
+ * @test: the test case this expectation/assertion is associated with.
+ * @type: the type (either an expectation or an assertion) of this kunit_assert.
+ * @line: the source code line number that the expectation/assertion is at.
+ * @file: the file path of the source file that the expectation/assertion is in.
+ * @message: an optional message to provide additional context.
+ * @format: a function which formats the data in this kunit_assert to a string.
+ *
+ * Represents a failed expectation/assertion. Contains all the data necessary to
+ * format a string to a user reporting the failure.
+ */
+struct kunit_assert {
+	struct kunit *test;
+	enum kunit_assert_type type;
+	int line;
+	const char *file;
+	struct va_format message;
+	void (*format)(const struct kunit_assert *assert,
+		       struct string_stream *stream);
+};
+
+/**
+ * KUNIT_INIT_VA_FMT_NULL - Default initializer for struct va_format.
+ *
+ * Used inside a struct initialization block to initialize struct va_format to
+ * default values where fmt and va are null.
+ */
+#define KUNIT_INIT_VA_FMT_NULL { .fmt = NULL, .va = NULL }
+
+/**
+ * KUNIT_INIT_ASSERT_STRUCT() - Initializer for a &struct kunit_assert.
+ * @kunit: The test case that this expectation/assertion is associated with.
+ * @assert_type: The type (assertion or expectation) of this kunit_assert.
+ * @fmt: The formatting function which builds a string out of this kunit_assert.
+ *
+ * The base initializer for a &struct kunit_assert.
+ */
+#define KUNIT_INIT_ASSERT_STRUCT(kunit, assert_type, fmt) {		       \
+	.test = kunit,							       \
+	.type = assert_type,						       \
+	.file = __FILE__,						       \
+	.line = __LINE__,						       \
+	.message = KUNIT_INIT_VA_FMT_NULL,				       \
+	.format = fmt							       \
+}
+
+void kunit_base_assert_format(const struct kunit_assert *assert,
+			      struct string_stream *stream);
+
+void kunit_assert_print_msg(const struct kunit_assert *assert,
+			    struct string_stream *stream);
+
+/**
+ * struct kunit_fail_assert - Represents a plain fail expectation/assertion.
+ * @assert: The parent of this type.
+ *
+ * Represents a simple KUNIT_FAIL/KUNIT_ASSERT_FAILURE that always fails.
+ */
+struct kunit_fail_assert {
+	struct kunit_assert assert;
+};
+
+void kunit_fail_assert_format(const struct kunit_assert *assert,
+			      struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_FAIL_ASSERT_STRUCT() - Initializer for &struct kunit_fail_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ *
+ * Initializes a &struct kunit_fail_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {			       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_fail_assert_format)	       \
+}
+
+/**
+ * struct kunit_unary_assert - Represents a KUNIT_{EXPECT|ASSERT}_{TRUE|FALSE}
+ * @assert: The parent of this type.
+ * @condition: A string representation of a conditional expression.
+ * @expected_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
+ *
+ * Represents a simple expectation or assertion that simply asserts something is
+ * true or false. In other words, represents the expectations:
+ * KUNIT_{EXPECT|ASSERT}_{TRUE|FALSE}
+ */
+struct kunit_unary_assert {
+	struct kunit_assert assert;
+	const char *condition;
+	bool expected_true;
+};
+
+void kunit_unary_assert_format(const struct kunit_assert *assert,
+			       struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_UNARY_ASSERT_STRUCT() - Initializes &struct kunit_unary_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @cond: A string representation of the expression asserted true or false.
+ * @expect_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
+ *
+ * Initializes a &struct kunit_unary_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_UNARY_ASSERT_STRUCT(test, type, cond, expect_true) {	       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_unary_assert_format),	       \
+	.condition = cond,						       \
+	.expected_true = expect_true					       \
+}
+
+/**
+ * struct kunit_ptr_not_err_assert - An expectation/assertion that a pointer is
+ *	not NULL and not a -errno.
+ * @assert: The parent of this type.
+ * @text: A string representation of the expression passed to the expectation.
+ * @value: The actual evaluated pointer value of the expression.
+ *
+ * Represents an expectation/assertion that a pointer is not null and is does
+ * not contain a -errno. (See IS_ERR_OR_NULL().)
+ */
+struct kunit_ptr_not_err_assert {
+	struct kunit_assert assert;
+	const char *text;
+	const void *value;
+};
+
+void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
+				     struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_PTR_NOT_ERR_ASSERT_STRUCT() - Initializes a
+ *	&struct kunit_ptr_not_err_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @txt: A string representation of the expression passed to the expectation.
+ * @val: The actual evaluated pointer value of the expression.
+ *
+ * Initializes a &struct kunit_ptr_not_err_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(test, type, txt, val) {		       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_ptr_not_err_assert_format),   \
+	.text = txt,							       \
+	.value = val							       \
+}
+
+/**
+ * struct kunit_binary_assert - An expectation/assertion that compares two
+ *	non-pointer values (for example, KUNIT_EXPECT_EQ(test, 1 + 1, 2)).
+ * @assert: The parent of this type.
+ * @operation: A string representation of the comparison operator (e.g. "==").
+ * @left_text: A string representation of the expression in the left slot.
+ * @left_value: The actual evaluated value of the expression in the left slot.
+ * @right_text: A string representation of the expression in the right slot.
+ * @right_value: The actual evaluated value of the expression in the right slot.
+ *
+ * Represents an expectation/assertion that compares two non-pointer values. For
+ * example, to expect that 1 + 1 == 2, you can use the expectation
+ * KUNIT_EXPECT_EQ(test, 1 + 1, 2);
+ */
+struct kunit_binary_assert {
+	struct kunit_assert assert;
+	const char *operation;
+	const char *left_text;
+	long long left_value;
+	const char *right_text;
+	long long right_value;
+};
+
+void kunit_binary_assert_format(const struct kunit_assert *assert,
+				struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a
+ *	&struct kunit_binary_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @op_str: A string representation of the comparison operator (e.g. "==").
+ * @left_str: A string representation of the expression in the left slot.
+ * @left_val: The actual evaluated value of the expression in the left slot.
+ * @right_str: A string representation of the expression in the right slot.
+ * @right_val: The actual evaluated value of the expression in the right slot.
+ *
+ * Initializes a &struct kunit_binary_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_BINARY_ASSERT_STRUCT(test,				       \
+					type,				       \
+					op_str,				       \
+					left_str,			       \
+					left_val,			       \
+					right_str,			       \
+					right_val) {			       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_binary_assert_format),	       \
+	.operation = op_str,						       \
+	.left_text = left_str,						       \
+	.left_value = left_val,						       \
+	.right_text = right_str,					       \
+	.right_value = right_val					       \
+}
+
+/**
+ * struct kunit_binary_ptr_assert - An expectation/assertion that compares two
+ *	pointer values (for example, KUNIT_EXPECT_PTR_EQ(test, foo, bar)).
+ * @assert: The parent of this type.
+ * @operation: A string representation of the comparison operator (e.g. "==").
+ * @left_text: A string representation of the expression in the left slot.
+ * @left_value: The actual evaluated value of the expression in the left slot.
+ * @right_text: A string representation of the expression in the right slot.
+ * @right_value: The actual evaluated value of the expression in the right slot.
+ *
+ * Represents an expectation/assertion that compares two pointer values. For
+ * example, to expect that foo and bar point to the same thing, you can use the
+ * expectation KUNIT_EXPECT_PTR_EQ(test, foo, bar);
+ */
+struct kunit_binary_ptr_assert {
+	struct kunit_assert assert;
+	const char *operation;
+	const char *left_text;
+	const void *left_value;
+	const char *right_text;
+	const void *right_value;
+};
+
+void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
+				    struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT() - Initializes a
+ *	&struct kunit_binary_ptr_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @op_str: A string representation of the comparison operator (e.g. "==").
+ * @left_str: A string representation of the expression in the left slot.
+ * @left_val: The actual evaluated value of the expression in the left slot.
+ * @right_str: A string representation of the expression in the right slot.
+ * @right_val: The actual evaluated value of the expression in the right slot.
+ *
+ * Initializes a &struct kunit_binary_ptr_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(test,			       \
+					    type,			       \
+					    op_str,			       \
+					    left_str,			       \
+					    left_val,			       \
+					    right_str,			       \
+					    right_val) {		       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_binary_ptr_assert_format),    \
+	.operation = op_str,						       \
+	.left_text = left_str,						       \
+	.left_value = left_val,						       \
+	.right_text = right_str,					       \
+	.right_value = right_val					       \
+}
+
+/**
+ * struct kunit_binary_str_assert - An expectation/assertion that compares two
+ *	string values (for example, KUNIT_EXPECT_STREQ(test, foo, "bar")).
+ * @assert: The parent of this type.
+ * @operation: A string representation of the comparison operator (e.g. "==").
+ * @left_text: A string representation of the expression in the left slot.
+ * @left_value: The actual evaluated value of the expression in the left slot.
+ * @right_text: A string representation of the expression in the right slot.
+ * @right_value: The actual evaluated value of the expression in the right slot.
+ *
+ * Represents an expectation/assertion that compares two string values. For
+ * example, to expect that the string in foo is equal to "bar", you can use the
+ * expectation KUNIT_EXPECT_STREQ(test, foo, "bar");
+ */
+struct kunit_binary_str_assert {
+	struct kunit_assert assert;
+	const char *operation;
+	const char *left_text;
+	const char *left_value;
+	const char *right_text;
+	const char *right_value;
+};
+
+void kunit_binary_str_assert_format(const struct kunit_assert *assert,
+				    struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() - Initializes a
+ *	&struct kunit_binary_str_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @op_str: A string representation of the comparison operator (e.g. "==").
+ * @left_str: A string representation of the expression in the left slot.
+ * @left_val: The actual evaluated value of the expression in the left slot.
+ * @right_str: A string representation of the expression in the right slot.
+ * @right_val: The actual evaluated value of the expression in the right slot.
+ *
+ * Initializes a &struct kunit_binary_str_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,			       \
+					    type,			       \
+					    op_str,			       \
+					    left_str,			       \
+					    left_val,			       \
+					    right_str,			       \
+					    right_val) {		       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_binary_str_assert_format),    \
+	.operation = op_str,						       \
+	.left_text = left_str,						       \
+	.left_value = left_val,						       \
+	.right_text = right_str,					       \
+	.right_value = right_val					       \
+}
+
+#endif /*  _KUNIT_ASSERT_H */
diff --git a/kunit/Makefile b/kunit/Makefile
index 275b565a0e81f..6dcbe309036b8 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_KUNIT) +=			test.o \
-					string-stream.o
+					string-stream.o \
+					assert.o
diff --git a/kunit/assert.c b/kunit/assert.c
new file mode 100644
index 0000000000000..86013d4cf891c
--- /dev/null
+++ b/kunit/assert.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Assertion and expectation serialization API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+#include <kunit/assert.h>
+
+void kunit_base_assert_format(const struct kunit_assert *assert,
+			      struct string_stream *stream)
+{
+	const char *expect_or_assert = NULL;
+
+	switch (assert->type) {
+	case KUNIT_EXPECTATION:
+		expect_or_assert = "EXPECTATION";
+		break;
+	case KUNIT_ASSERTION:
+		expect_or_assert = "ASSERTION";
+		break;
+	}
+
+	string_stream_add(stream, "%s FAILED at %s:%d\n",
+			 expect_or_assert, assert->file, assert->line);
+}
+
+void kunit_assert_print_msg(const struct kunit_assert *assert,
+			    struct string_stream *stream)
+{
+	if (assert->message.fmt)
+		string_stream_add(stream, "\n%pV", &assert->message);
+}
+
+void kunit_fail_assert_format(const struct kunit_assert *assert,
+			      struct string_stream *stream)
+{
+	kunit_base_assert_format(assert, stream);
+	string_stream_add(stream, "%pV", &assert->message);
+}
+
+void kunit_unary_assert_format(const struct kunit_assert *assert,
+			       struct string_stream *stream)
+{
+	struct kunit_unary_assert *unary_assert = container_of(
+			assert, struct kunit_unary_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	if (unary_assert->expected_true)
+		string_stream_add(stream,
+				 "\tExpected %s to be true, but is false\n",
+				 unary_assert->condition);
+	else
+		string_stream_add(stream,
+				 "\tExpected %s to be false, but is true\n",
+				 unary_assert->condition);
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
+				     struct string_stream *stream)
+{
+	struct kunit_ptr_not_err_assert *ptr_assert = container_of(
+			assert, struct kunit_ptr_not_err_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	if (!ptr_assert->value) {
+		string_stream_add(stream,
+				 "\tExpected %s is not null, but is\n",
+				 ptr_assert->text);
+	} else if (IS_ERR(ptr_assert->value)) {
+		string_stream_add(stream,
+				 "\tExpected %s is not error, but is: %ld\n",
+				 ptr_assert->text,
+				 PTR_ERR(ptr_assert->value));
+	}
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_binary_assert_format(const struct kunit_assert *assert,
+				struct string_stream *stream)
+{
+	struct kunit_binary_assert *binary_assert = container_of(
+			assert, struct kunit_binary_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	string_stream_add(stream,
+			 "\tExpected %s %s %s, but\n",
+			 binary_assert->left_text,
+			 binary_assert->operation,
+			 binary_assert->right_text);
+	string_stream_add(stream, "\t\t%s == %lld\n",
+			 binary_assert->left_text,
+			 binary_assert->left_value);
+	string_stream_add(stream, "\t\t%s == %lld",
+			 binary_assert->right_text,
+			 binary_assert->right_value);
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
+				    struct string_stream *stream)
+{
+	struct kunit_binary_ptr_assert *binary_assert = container_of(
+			assert, struct kunit_binary_ptr_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	string_stream_add(stream,
+			 "\tExpected %s %s %s, but\n",
+			 binary_assert->left_text,
+			 binary_assert->operation,
+			 binary_assert->right_text);
+	string_stream_add(stream, "\t\t%s == %pK\n",
+			 binary_assert->left_text,
+			 binary_assert->left_value);
+	string_stream_add(stream, "\t\t%s == %pK",
+			 binary_assert->right_text,
+			 binary_assert->right_value);
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_binary_str_assert_format(const struct kunit_assert *assert,
+				    struct string_stream *stream)
+{
+	struct kunit_binary_str_assert *binary_assert = container_of(
+			assert, struct kunit_binary_str_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	string_stream_add(stream,
+			 "\tExpected %s %s %s, but\n",
+			 binary_assert->left_text,
+			 binary_assert->operation,
+			 binary_assert->right_text);
+	string_stream_add(stream, "\t\t%s == %s\n",
+			 binary_assert->left_text,
+			 binary_assert->left_value);
+	string_stream_add(stream, "\t\t%s == %s",
+			 binary_assert->right_text,
+			 binary_assert->right_value);
+	kunit_assert_print_msg(assert, stream);
+}
-- 
2.23.0.rc1.153.gdeed80330f-goog

