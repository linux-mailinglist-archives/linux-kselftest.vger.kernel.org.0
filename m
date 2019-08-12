Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3FD58A629
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2019 20:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfHLSZ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Aug 2019 14:25:56 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:54779 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfHLSZK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Aug 2019 14:25:10 -0400
Received: by mail-pg1-f202.google.com with SMTP id m17so56153136pgh.21
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Aug 2019 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7Ze1aqEJgREX1Z2p2csfzk9t7DuMISfNfNdzropprns=;
        b=tfqctJbztEPABF4ZMcrP03gV67Uv8c+oKUyR8ySoNF5aagiSlAkc0KHbRtfHt/sSXe
         wIe1kKxmKAWLPAxdTIzDTaKROtFPU8q24HhcOpQOaAWOvuk1yxjvdakJtbX4cfcJglKi
         hYyq0qYGLTlXv6MCFb4Ft5Y1Fov5KKn78Zzqs8ioBbmwZQ0y2kIHk9Gs+Ae1rbgASEor
         h4jHIhTrheBkEyli/UrOpPNsgYMlSYSfYZkn5gQ0va1YuqjLZoTABlt7wK7XzaOcmnW4
         p4dpMRwuuGd4dHU+7rLAZkid9AWpkPcEZ/vThXirroJFp5Xy5UNDnC4MbuBDqM4wPk9d
         Tamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7Ze1aqEJgREX1Z2p2csfzk9t7DuMISfNfNdzropprns=;
        b=H+h1DQfFm4r8KskkNElNQDgiHQFYm/G473cjQ0MkwagxSV1uUl8KBOPPuE/QlE6Chp
         TJaI4X88yTiPgr9keLzlk+sBhmtz4SJ4zbxH0fsp913lf7D0901Nt2K715d632mG0rTp
         4qh1w8AMvxp2DNd+HXJzpFljGpOgD1bhiRsXRXrPR70GMgg6JZ3ZvVSSzly3uKWAuuIg
         tQLH+hBQQPUKVfaRxVKHGPqXAzSiC58BujDN46yrMTvLLxWYQzBQ5llQxM/hMMBA1ctc
         nwS/ciSGbrZNrT9PmXsQZ1Fy2ypGczKtWiuhpkxXPrYI5roJYZfO+/6DvujnF0+m8CVS
         PwFQ==
X-Gm-Message-State: APjAAAU7TZQ+S9VHw0fCPN1B5BcPHfptZxTj0/cS7+KnpCYRQ1RPX5pV
        H7y4Ru3o/lz4UuqV0QMxzYS+jhZlaRnpl4O7pFzwVQ==
X-Google-Smtp-Source: APXvYqy/TyRuRLImWMCOkm0LvtLcH/n4uh8pZppkp+EJCWzXZp1pAZO8XBLzVX6pnDAV0brzxxLngIvPpTL7/lSjo378kg==
X-Received: by 2002:a63:7245:: with SMTP id c5mr31787467pgn.11.1565634308713;
 Mon, 12 Aug 2019 11:25:08 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:24:14 -0700
In-Reply-To: <20190812182421.141150-1-brendanhiggins@google.com>
Message-Id: <20190812182421.141150-12-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v12 11/18] kunit: test: add the concept of assertions
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
 include/kunit/test.h       | 297 ++++++++++++++++++++++++++++++++++++-
 kunit/string-stream-test.c |  12 +-
 kunit/test-test.c          |   2 +
 3 files changed, 302 insertions(+), 9 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 93381f841e09f..dcebaca456a1f 100644
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
@@ -1176,4 +1177,294 @@ do {									       \
 							fmt,		       \
 							##__VA_ARGS__)
 
+#define KUNIT_ASSERT_FAILURE(test, fmt, ...) \
+		KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION, fmt, ##__VA_ARGS__)
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
+#define KUNIT_ASSERT_TRUE(test, condition) \
+		KUNIT_TRUE_ASSERTION(test, KUNIT_ASSERTION, condition)
+
+#define KUNIT_ASSERT_TRUE_MSG(test, condition, fmt, ...)		       \
+		KUNIT_TRUE_MSG_ASSERTION(test,				       \
+					 KUNIT_ASSERTION,		       \
+					 condition,			       \
+					 fmt,				       \
+					 ##__VA_ARGS__)
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
+		KUNIT_FALSE_ASSERTION(test, KUNIT_ASSERTION, condition)
+
+#define KUNIT_ASSERT_FALSE_MSG(test, condition, fmt, ...)		       \
+		KUNIT_FALSE_MSG_ASSERTION(test,				       \
+					  KUNIT_ASSERTION,		       \
+					  condition,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
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
+		KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_EQ_MSG_ASSERTION(test,			       \
+					      KUNIT_ASSERTION,		       \
+					      left,			       \
+					      right,			       \
+					      fmt,			       \
+					      ##__VA_ARGS__)
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
+		KUNIT_BINARY_PTR_EQ_ASSERTION(test,			       \
+					      KUNIT_ASSERTION,		       \
+					      left,			       \
+					      right)
+
+#define KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,			       \
+						  KUNIT_ASSERTION,	       \
+						  left,			       \
+						  right,		       \
+						  fmt,			       \
+						  ##__VA_ARGS__)
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
+		KUNIT_BINARY_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_NE_MSG_ASSERTION(test,			       \
+					      KUNIT_ASSERTION,		       \
+					      left,			       \
+					      right,			       \
+					      fmt,			       \
+					      ##__VA_ARGS__)
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
+		KUNIT_BINARY_PTR_NE_ASSERTION(test,			       \
+					      KUNIT_ASSERTION,		       \
+					      left,			       \
+					      right)
+
+#define KUNIT_ASSERT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,			       \
+						  KUNIT_ASSERTION,	       \
+						  left,			       \
+						  right,		       \
+						  fmt,			       \
+						  ##__VA_ARGS__)
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
+		KUNIT_BINARY_LT_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_LT_MSG_ASSERTION(test,			       \
+					      KUNIT_ASSERTION,		       \
+					      left,			       \
+					      right,			       \
+					      fmt,			       \
+					      ##__VA_ARGS__)
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
+		KUNIT_BINARY_LE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_LE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_LE_MSG_ASSERTION(test,			       \
+					      KUNIT_ASSERTION,		       \
+					      left,			       \
+					      right,			       \
+					      fmt,			       \
+					      ##__VA_ARGS__)
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
+		KUNIT_BINARY_GT_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_GT_MSG_ASSERTION(test,			       \
+					      KUNIT_ASSERTION,		       \
+					      left,			       \
+					      right,			       \
+					      fmt,			       \
+					      ##__VA_ARGS__)
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
+		KUNIT_BINARY_GE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_GE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_GE_MSG_ASSERTION(test,			       \
+					      KUNIT_ASSERTION,		       \
+					      left,			       \
+					      right,			       \
+					      fmt,			       \
+					      ##__VA_ARGS__)
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
+#define KUNIT_ASSERT_STREQ(test, left, right)				       \
+		KUNIT_BINARY_STR_EQ_ASSERTION(test,			       \
+					      KUNIT_ASSERTION,		       \
+					      left,			       \
+					      right)
+
+#define KUNIT_ASSERT_STREQ_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,			       \
+						  KUNIT_ASSERTION,	       \
+						  left,			       \
+						  right,		       \
+						  fmt,			       \
+						  ##__VA_ARGS__)
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
+#define KUNIT_ASSERT_STRNEQ(test, left, right)				       \
+		KUNIT_BINARY_STR_NE_ASSERTION(test,			       \
+					      KUNIT_ASSERTION,		       \
+					      left,			       \
+					      right)
+
+#define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,			       \
+						  KUNIT_ASSERTION,	       \
+						  left,			       \
+						  right,		       \
+						  fmt,			       \
+						  ##__VA_ARGS__)
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
+#define KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr)				       \
+		KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test,		       \
+						    KUNIT_ASSERTION,	       \
+						    ptr)
+
+#define KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
+		KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,		       \
+							KUNIT_ASSERTION,       \
+							ptr,		       \
+							fmt,		       \
+							##__VA_ARGS__)
+
 #endif /* _KUNIT_TEST_H */
diff --git a/kunit/string-stream-test.c b/kunit/string-stream-test.c
index 9cf08f9dadf36..fd928ab7d65a8 100644
--- a/kunit/string-stream-test.c
+++ b/kunit/string-stream-test.c
@@ -35,7 +35,7 @@ static void string_stream_test_get_string(struct kunit *test)
 	string_stream_add(stream, " %s", "bar");
 
 	output = string_stream_get_string(stream);
-	KUNIT_EXPECT_STREQ(test, output, "Foo bar");
+	KUNIT_ASSERT_STREQ(test, output, "Foo bar");
 }
 
 static void string_stream_test_add_and_clear(struct kunit *test)
@@ -48,15 +48,15 @@ static void string_stream_test_add_and_clear(struct kunit *test)
 		string_stream_add(stream, "A");
 
 	output = string_stream_get_string(stream);
-	KUNIT_EXPECT_STREQ(test, output, "AAAAAAAAAA");
-	KUNIT_EXPECT_EQ(test, stream->length, (size_t)10);
-	KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
+	KUNIT_ASSERT_STREQ(test, output, "AAAAAAAAAA");
+	KUNIT_ASSERT_EQ(test, stream->length, (size_t)10);
+	KUNIT_ASSERT_FALSE(test, string_stream_is_empty(stream));
 
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
-- 
2.23.0.rc1.153.gdeed80330f-goog

