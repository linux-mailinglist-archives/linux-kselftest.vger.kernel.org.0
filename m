Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4F6A5A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2019 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbfGPJo3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jul 2019 05:44:29 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56563 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733079AbfGPJnl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jul 2019 05:43:41 -0400
Received: by mail-pg1-f202.google.com with SMTP id h5so12300970pgq.23
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2019 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xXqIbYkr4UlpIwtnaxR+79zOl8LXXaaSzeU+HVUGOxs=;
        b=AaMW0MvwiGe6xdWUtMCyRhah8AwyCGdQgTTo2jR2xz8CC8s+eOMicWbqJbQ/YwOJsJ
         xQGUH/eniAvMrZ3ZVLOq5VY33F+44VFusYmTMk/Hu3Vhn2QmIVYajs3faD18GI43ww9I
         3h1SvE6Nqb3zozPM+RNVm6x0408SQw3/+dXJaBpqNbvyz3OPXdTCi2U2Wa+JQw5rD+7O
         nQIl44ypOzdV67X0ff4GP0T8E2ijftIIADaDLvToJwyCoh6iQ9krQLrCcSaWk2HOt4aL
         65LJKR+iMjnvpsvo7JVA5+UtijOwzqhXxFJwCCmAG9eVUWO6gpVc1m4QvYlaVoEMExuu
         wEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xXqIbYkr4UlpIwtnaxR+79zOl8LXXaaSzeU+HVUGOxs=;
        b=mzTMq1/UwJcLTwoXYij4QwUFgcZJz9jlPWqRIZI9V4goDqb4rwb8+6Do93/TVet+Ph
         xenTUhmnzgzUklsu+aWFfQSamMxeGSiF2CEyaXRziQxb1vmWyliomI49zA4sz2/QcG/x
         quwHsxDWsTNC/aWKfZHOBfDi5ChGbMJrSByRtJIU7Xm4wtqUzpiuRMpbare25+YQGZxv
         eqslIxBm/zr7f2lzHkcUHbh4dIidDUe4J89nuxqixMTt7EG2AzF5waa/XklOv9ey3K7t
         MaT+vKRqnlYeA9hF3Uqfkhd7MJNFTiXD2twrlgVk+dZ4KVp6/M+IAFB3wsJhJMOMuHle
         oHWQ==
X-Gm-Message-State: APjAAAVNvuwmVeQVt19LRaXikUQeNsdI0A4YT6CNbWntjW63OwDsADCV
        wFAfR1OM/DjSOD2hRCWvx/mDtVIue/LMpKOg22/0Dg==
X-Google-Smtp-Source: APXvYqw7PVk5uhObcCCNuB/yP3FuT80jZrgsR2G2FMarz3MpOUuU+Z36kpIMsb+3+Kv2LbGkLx6xPybhAm+PFa3dFYFChw==
X-Received: by 2002:a63:e953:: with SMTP id q19mr32597431pgj.313.1563270219508;
 Tue, 16 Jul 2019 02:43:39 -0700 (PDT)
Date:   Tue, 16 Jul 2019 02:42:55 -0700
In-Reply-To: <20190716094302.180360-1-brendanhiggins@google.com>
Message-Id: <20190716094302.180360-12-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190716094302.180360-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v10 11/18] kunit: test: add the concept of assertions
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

Add support for assertions which are like expectations except the test
terminates if the assertion is not satisfied.

The idea with assertions is that you use them to state all the
preconditions for your test. Logically speaking, these are the premises
of the test case, so if a premise isn't true, there is no point in
continuing the test case because there are no conclusions that can be
drawn without the premises. Whereas, the expectation is the thing you
are trying to prove. It is not used universally in x-unit style test
frameworks, but I really like it as a convention.  You could still
express the idea of a premise using the above idiom, but I think
KUNIT_ASSERT_* states the intended idea perfectly.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/kunit/test.h       | 499 ++++++++++++++++++++++++++++++++++++-
 kunit/string-stream-test.c |  12 +-
 kunit/test-test.c          |   2 +
 kunit/test.c               |  66 +++++
 4 files changed, 570 insertions(+), 9 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 1d35f542a30c9..06f849430ce4b 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -86,9 +86,10 @@ struct kunit;
  * @name: the name of the test case.
  *
  * A test case is a function with the signature, ``void (*)(struct kunit *)``
- * that makes expectations (see KUNIT_EXPECT_TRUE()) about code under test. Each
- * test case is associated with a &struct kunit_suite and will be run after the
- * suite's init function and followed by the suite's exit function.
+ * that makes expectations and assertions (see KUNIT_EXPECT_TRUE() and
+ * KUNIT_ASSERT_TRUE()) about code under test. Each test case is associated with
+ * a &struct kunit_suite and will be run after the suite's init function and
+ * followed by the suite's exit function.
  *
  * A test case should be static and should only be created with the KUNIT_CASE()
  * macro; additionally, every array of test cases should be terminated with an
@@ -863,4 +864,496 @@ do {									       \
 	KUNIT_EXPECT_END(test, !IS_ERR_OR_NULL(__ptr), __stream);	       \
 } while (0)
 
+static inline struct kunit_stream *kunit_assert_start(struct kunit *test,
+						      const char *file,
+						      const char *line)
+{
+	struct kunit_stream *stream = alloc_kunit_stream(test, KERN_ERR);
+
+	kunit_stream_add(stream, "ASSERTION FAILED at %s:%s\n\t", file, line);
+
+	return stream;
+}
+
+static inline void kunit_assert_end(struct kunit *test,
+				    bool success,
+				    struct kunit_stream *stream)
+{
+	if (!success) {
+		kunit_fail(test, stream);
+		kunit_abort(test);
+	} else {
+		kunit_stream_clear(stream);
+	}
+}
+
+#define KUNIT_ASSERT_START(test) \
+		kunit_assert_start(test, __FILE__, __stringify(__LINE__))
+
+#define KUNIT_ASSERT_END(test, success, stream) \
+		kunit_assert_end(test, success, stream)
+
+#define KUNIT_ASSERT(test, success, message) do {			       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+									       \
+	kunit_stream_add(__stream, message);				       \
+	KUNIT_ASSERT_END(test, success, __stream);			       \
+} while (0)
+
+#define KUNIT_ASSERT_MSG(test, success, message, fmt, ...) do {		       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+									       \
+	kunit_stream_add(__stream, message);				       \
+	kunit_stream_add(__stream, fmt, ##__VA_ARGS__);			       \
+	KUNIT_ASSERT_END(test, success, __stream);			       \
+} while (0)
+
+#define KUNIT_ASSERT_FAILURE(test, fmt, ...) do {			       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+									       \
+	kunit_stream_add(__stream, fmt, ##__VA_ARGS__);			       \
+	KUNIT_ASSERT_END(test, false, __stream);			       \
+} while (0)
+
+/**
+ * KUNIT_ASSERT_TRUE() - Sets an assertion that @condition is true.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression. The test fails and aborts when
+ * this does not evaluate to true.
+ *
+ * This and assertions of the form `KUNIT_ASSERT_*` will cause the test case to
+ * fail *and immediately abort* when the specified condition is not met. Unlike
+ * an expectation failure, it will prevent the test case from continuing to run;
+ * this is otherwise known as an *assertion failure*.
+ */
+#define KUNIT_ASSERT_TRUE(test, condition)				       \
+		KUNIT_ASSERT(test, (condition),				       \
+			     "Asserted " #condition " is true, but is false\n")
+
+#define KUNIT_ASSERT_TRUE_MSG(test, condition, fmt, ...)		       \
+		KUNIT_ASSERT_MSG(test, (condition),			       \
+				 "Asserted " #condition " is true, but is false\n",\
+				 fmt, ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_FALSE() - Sets an assertion that @condition is false.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression.
+ *
+ * Sets an assertion that the value that @condition evaluates to is false. This
+ * is the same as KUNIT_EXPECT_FALSE(), except it causes an assertion failure
+ * (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_FALSE(test, condition)				       \
+		KUNIT_ASSERT(test, !(condition),			       \
+			     "Asserted " #condition " is false, but is true\n")
+
+#define KUNIT_ASSERT_FALSE_MSG(test, condition, fmt, ...)		       \
+		KUNIT_ASSERT_MSG(test, !(condition),			       \
+				 "Asserted " #condition " is false, but is true\n",\
+				 fmt, ##__VA_ARGS__)
+
+void kunit_assert_binary_msg(struct kunit *test,
+			     long long left, const char *left_name,
+			     long long right, const char *right_name,
+			     bool compare_result,
+			     const char *compare_name,
+			     const char *file,
+			     const char *line,
+			     const char *fmt, ...);
+
+static inline void kunit_assert_binary(struct kunit *test,
+				       long long left, const char *left_name,
+				       long long right, const char *right_name,
+				       bool compare_result,
+				       const char *compare_name,
+				       const char *file,
+				       const char *line)
+{
+	kunit_assert_binary_msg(test,
+				left, left_name,
+				right, right_name,
+				compare_result,
+				compare_name,
+				file,
+				line,
+				NULL);
+}
+
+void kunit_assert_ptr_binary_msg(struct kunit *test,
+				 void *left, const char *left_name,
+				 void *right, const char *right_name,
+				 bool compare_result,
+				 const char *compare_name,
+				 const char *file,
+				 const char *line,
+				 const char *fmt, ...);
+
+static inline void kunit_assert_ptr_binary(struct kunit *test,
+					   void *left, const char *left_name,
+					   void *right, const char *right_name,
+					   bool compare_result,
+					   const char *compare_name,
+					   const char *file,
+					   const char *line)
+{
+	kunit_assert_ptr_binary_msg(test,
+				    left, left_name,
+				    right, right_name,
+				    compare_result,
+				    compare_name,
+				    file,
+				    line,
+				    NULL);
+}
+
+/*
+ * A factory macro for defining the expectations for the basic comparisons
+ * defined for the built in types.
+ *
+ * Unfortunately, there is no common type that all types can be promoted to for
+ * which all the binary operators behave the same way as for the actual types
+ * (for example, there is no type that long long and unsigned long long can
+ * both be cast to where the comparison result is preserved for all values). So
+ * the best we can do is do the comparison in the original types and then coerce
+ * everything to long long for printing; this way, the comparison behaves
+ * correctly and the printed out value usually makes sense without
+ * interpretation, but can always be interpretted to figure out the actual
+ * value.
+ */
+#define KUNIT_ASSERT_BINARY(test, left, condition, right) do {		       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
+	kunit_assert_binary(test,					       \
+			    (long long) __left, #left,			       \
+			    (long long) __right, #right,		       \
+			    __left condition __right, #condition,	       \
+			    __FILE__, __stringify(__LINE__));		       \
+} while (0)
+
+#define KUNIT_ASSERT_BINARY_MSG(test, left, condition, right, fmt, ...) do {   \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
+	kunit_assert_binary_msg(test,					       \
+				(long long) __left, #left,		       \
+				(long long) __right, #right,		       \
+				__left condition __right, #condition,	       \
+				__FILE__, __stringify(__LINE__),	       \
+				fmt, ##__VA_ARGS__);			       \
+} while (0)
+
+/*
+ * Just like KUNIT_EXPECT_BINARY, but for comparing pointer types.
+ */
+#define KUNIT_ASSERT_PTR_BINARY(test, left, condition, right) do {	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
+	kunit_assert_ptr_binary(test,					       \
+				(void *) __left, #left,			       \
+				(void *) __right, #right,		       \
+				__left condition __right, #condition,	       \
+				__FILE__, __stringify(__LINE__));	       \
+} while (0)
+
+#define KUNIT_ASSERT_PTR_BINARY_MSG(test, left, condition, right, fmt, ...)    \
+do {									       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
+	kunit_assert_ptr_binary_msg(test,				       \
+				    (void *) __left, #left,		       \
+				    (void *) __right, #right,		       \
+				    __left condition __right, #condition,      \
+				    __FILE__, __stringify(__LINE__),	       \
+				    fmt, ##__VA_ARGS__);		       \
+} while (0)
+
+/**
+ * KUNIT_ASSERT_EQ() - Sets an assertion that @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are
+ * equal. This is the same as KUNIT_EXPECT_EQ(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_EQ(test, left, right) \
+		KUNIT_ASSERT_BINARY(test, left, ==, right)
+
+#define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_BINARY_MSG(test,				       \
+					left,				       \
+					==,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a pointer.
+ * @right: an arbitrary expression that evaluates to a pointer.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are
+ * equal. This is the same as KUNIT_EXPECT_EQ(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_PTR_EQ(test, left, right) \
+		KUNIT_ASSERT_PTR_BINARY(test, left, ==, right)
+
+#define KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_PTR_BINARY_MSG(test,			       \
+					    left,			       \
+					    ==,				       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_NE() - An assertion that @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are not
+ * equal. This is the same as KUNIT_EXPECT_NE(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_NE(test, left, right) \
+		KUNIT_ASSERT_BINARY(test, left, !=, right)
+
+#define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_BINARY_MSG(test,				       \
+					left,				       \
+					!=,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_PTR_NE() - Asserts that pointers @left and @right are not equal.
+ * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a pointer.
+ * @right: an arbitrary expression that evaluates to a pointer.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are not
+ * equal. This is the same as KUNIT_EXPECT_NE(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_PTR_NE(test, left, right) \
+		KUNIT_ASSERT_PTR_BINARY(test, left, !=, right)
+
+#define KUNIT_ASSERT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_PTR_BINARY_MSG(test,			       \
+					    left,			       \
+					    !=,				       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+/**
+ * KUNIT_ASSERT_LT() - An assertion that @left is less than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the value that @left evaluates to is less than the
+ * value that @right evaluates to. This is the same as KUNIT_EXPECT_LT(), except
+ * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
+ * is not met.
+ */
+#define KUNIT_ASSERT_LT(test, left, right) \
+		KUNIT_ASSERT_BINARY(test, left, <, right)
+
+#define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_BINARY_MSG(test,				       \
+					left,				       \
+					<,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+/**
+ * KUNIT_ASSERT_LE() - An assertion that @left is less than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the value that @left evaluates to is less than or
+ * equal to the value that @right evaluates to. This is the same as
+ * KUNIT_EXPECT_LE(), except it causes an assertion failure (see
+ * KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_LE(test, left, right) \
+		KUNIT_ASSERT_BINARY(test, left, <=, right)
+
+#define KUNIT_ASSERT_LE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_BINARY_MSG(test,				       \
+					left,				       \
+					<=,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+/**
+ * KUNIT_ASSERT_GT() - An assertion that @left is greater than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the value that @left evaluates to is greater than the
+ * value that @right evaluates to. This is the same as KUNIT_EXPECT_GT(), except
+ * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
+ * is not met.
+ */
+#define KUNIT_ASSERT_GT(test, left, right) \
+		KUNIT_ASSERT_BINARY(test, left, >, right)
+
+#define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_BINARY_MSG(test,				       \
+					left,				       \
+					>,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_GE() - Assertion that @left is greater than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the value that @left evaluates to is greater than the
+ * value that @right evaluates to. This is the same as KUNIT_EXPECT_GE(), except
+ * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
+ * is not met.
+ */
+#define KUNIT_ASSERT_GE(test, left, right) \
+		KUNIT_ASSERT_BINARY(test, left, >=, right)
+
+#define KUNIT_ASSERT_GE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_ASSERT_BINARY_MSG(test,				       \
+					left,				       \
+					>=,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_STREQ() - An assertion that strings @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are
+ * equal. This is the same as KUNIT_EXPECT_STREQ(), except it causes an
+ * assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_STREQ(test, left, right) do {			       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	kunit_stream_add(__stream, "Asserted " #left " == " #right ", but\n"); \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #left, __left);	       \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #right, __right);	       \
+									       \
+	KUNIT_ASSERT_END(test, !strcmp(left, right), __stream);		       \
+} while (0)
+
+#define KUNIT_ASSERT_STREQ_MSG(test, left, right, fmt, ...) do {	       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	kunit_stream_add(__stream, "Asserted " #left " == " #right ", but\n"); \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #left, __left);	       \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #right, __right);	       \
+	kunit_stream_add(__stream, fmt, ##__VA_ARGS__);			       \
+									       \
+	KUNIT_ASSERT_END(test, !strcmp(left, right), __stream);		       \
+} while (0)
+
+/**
+ * KUNIT_ASSERT_STRNEQ() - Expects that strings @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * not equal. This is semantically equivalent to
+ * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT_TRUE()
+ * for more information.
+ */
+#define KUNIT_ASSERT_STRNEQ(test, left, right) do {			       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	kunit_stream_add(__stream, "Asserted " #left " == " #right ", but\n"); \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #left, __left);	       \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #right, __right);	       \
+									       \
+	KUNIT_ASSERT_END(test, strcmp(left, right), __stream);		       \
+} while (0)
+
+#define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...) do {	       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	kunit_stream_add(__stream, "Asserted " #left " == " #right ", but\n"); \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #left, __left);	       \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #right, __right);	       \
+	kunit_stream_add(__stream, fmt, ##__VA_ARGS__);			       \
+									       \
+	KUNIT_ASSERT_END(test, strcmp(left, right), __stream);		       \
+} while (0)
+
+/**
+ * KUNIT_ASSERT_NOT_ERR_OR_NULL() - Assertion that @ptr is not null and not err.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an assertion that the value that @ptr evaluates to is not null and not
+ * an errno stored in a pointer. This is the same as
+ * KUNIT_EXPECT_NOT_ERR_OR_NULL(), except it causes an assertion failure (see
+ * KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr) do {			       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+	typeof(ptr) __ptr = (ptr);					       \
+									       \
+	if (!__ptr)							       \
+		kunit_stream_add(__stream,				       \
+				 "Asserted " #ptr " is not null, but is\n");  \
+	if (IS_ERR(__ptr))						       \
+		kunit_stream_add(__stream,				       \
+				 "Asserted " #ptr " is not error, but is: %ld\n",\
+				 PTR_ERR(__ptr));			       \
+									       \
+	KUNIT_ASSERT_END(test, !IS_ERR_OR_NULL(__ptr), __stream);	       \
+} while (0)
+
+#define KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...) do {	       \
+	struct kunit_stream *__stream = KUNIT_ASSERT_START(test);	       \
+	typeof(ptr) __ptr = (ptr);					       \
+									       \
+	if (!__ptr) {							       \
+		kunit_stream_add(__stream,				       \
+				 "Asserted " #ptr " is not null, but is\n");  \
+		kunit_stream_add(__stream, fmt, ##__VA_ARGS__);		       \
+	}								       \
+	if (IS_ERR(__ptr)) {						       \
+		kunit_stream_add(__stream,				       \
+				 "Asserted " #ptr " is not error, but is: %ld\n",\
+				 PTR_ERR(__ptr));			       \
+									       \
+		kunit_stream_add(__stream, fmt, ##__VA_ARGS__);		       \
+	}								       \
+	KUNIT_ASSERT_END(test, !IS_ERR_OR_NULL(__ptr), __stream);	       \
+} while (0)
+
 #endif /* _KUNIT_TEST_H */
diff --git a/kunit/string-stream-test.c b/kunit/string-stream-test.c
index b5641b078b8f6..5f27d576d2daf 100644
--- a/kunit/string-stream-test.c
+++ b/kunit/string-stream-test.c
@@ -34,7 +34,7 @@ static void string_stream_test_get_string(struct kunit *test)
 	string_stream_add(stream, " %s", "bar");
 
 	output = string_stream_get_string(stream);
-	KUNIT_EXPECT_STREQ(test, output, "Foo bar");
+	KUNIT_ASSERT_STREQ(test, output, "Foo bar");
 	kfree(output);
 }
 
@@ -48,16 +48,16 @@ static void string_stream_test_add_and_clear(struct kunit *test)
 		string_stream_add(stream, "A");
 
 	output = string_stream_get_string(stream);
-	KUNIT_EXPECT_STREQ(test, output, "AAAAAAAAAA");
-	KUNIT_EXPECT_EQ(test, stream->length, (size_t)10);
-	KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
+	KUNIT_ASSERT_STREQ(test, output, "AAAAAAAAAA");
+	KUNIT_ASSERT_EQ(test, stream->length, (size_t)10);
+	KUNIT_ASSERT_FALSE(test, string_stream_is_empty(stream));
 	kfree(output);
 
 	string_stream_clear(stream);
 
 	output = string_stream_get_string(stream);
-	KUNIT_EXPECT_STREQ(test, output, "");
-	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
+	KUNIT_ASSERT_STREQ(test, output, "");
+	KUNIT_ASSERT_TRUE(test, string_stream_is_empty(stream));
 }
 
 static struct kunit_case string_stream_test_cases[] = {
diff --git a/kunit/test-test.c b/kunit/test-test.c
index 88f4cdf03db2a..058f3fb37458a 100644
--- a/kunit/test-test.c
+++ b/kunit/test-test.c
@@ -78,11 +78,13 @@ static int kunit_try_catch_test_init(struct kunit *test)
 	struct kunit_try_catch_test_context *ctx;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 	test->priv = ctx;
 
 	ctx->try_catch = kunit_kmalloc(test,
 				       sizeof(*ctx->try_catch),
 				       GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->try_catch);
 
 	return 0;
 }
diff --git a/kunit/test.c b/kunit/test.c
index 12db50b221781..2723f7bc04682 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -499,3 +499,69 @@ void kunit_expect_ptr_binary_msg(struct kunit *test,
 
 	kunit_expect_end(test, compare_result, stream);
 }
+
+void kunit_assert_binary_msg(struct kunit *test,
+			     long long left, const char *left_name,
+			     long long right, const char *right_name,
+			     bool compare_result,
+			     const char *compare_name,
+			     const char *file,
+			     const char *line,
+			     const char *fmt, ...)
+{
+	struct kunit_stream *stream = kunit_assert_start(test, file, line);
+	struct va_format vaf;
+	va_list args;
+
+	kunit_stream_add(stream,
+			 "Asserted %s %s %s, but\n",
+			 left_name, compare_name, right_name);
+	kunit_stream_add(stream, "\t\t%s == %lld\n", left_name, left);
+	kunit_stream_add(stream, "\t\t%s == %lld\n", right_name, right);
+
+	if (fmt) {
+		va_start(args, fmt);
+
+		vaf.fmt = fmt;
+		vaf.va = &args;
+
+		kunit_stream_add(stream, "\n%pV", &vaf);
+
+		va_end(args);
+	}
+
+	kunit_assert_end(test, compare_result, stream);
+}
+
+void kunit_assert_ptr_binary_msg(struct kunit *test,
+				 void *left, const char *left_name,
+				 void *right, const char *right_name,
+				 bool compare_result,
+				 const char *compare_name,
+				 const char *file,
+				 const char *line,
+				 const char *fmt, ...)
+{
+	struct kunit_stream *stream = kunit_assert_start(test, file, line);
+	struct va_format vaf;
+	va_list args;
+
+	kunit_stream_add(stream,
+			 "Asserted %s %s %s, but\n",
+			 left_name, compare_name, right_name);
+	kunit_stream_add(stream, "\t\t%s == %pK\n", left_name, left);
+	kunit_stream_add(stream, "\t\t%s == %pK", right_name, right);
+
+	if (fmt) {
+		va_start(args, fmt);
+
+		vaf.fmt = fmt;
+		vaf.va = &args;
+
+		kunit_stream_add(stream, "\n%pV", &vaf);
+
+		va_end(args);
+	}
+
+	kunit_assert_end(test, compare_result, stream);
+}
-- 
2.22.0.510.g264f2c817a-goog

