Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD10DB9B82
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2019 02:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437371AbfIUAUk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Sep 2019 20:20:40 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36903 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437325AbfIUATi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Sep 2019 20:19:38 -0400
Received: by mail-pg1-f202.google.com with SMTP id h189so5019726pgc.4
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2019 17:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V+e6Sk3SdH6RDyqe735Wb6nHpwM2/KCwKA8BXrg2X1g=;
        b=EL9E0aGWGlYFhRl782uDZmL7KmDfagNyc2mcU+WUagYr0iFn5pdPBmWiRVpFoQzd1H
         8jkekJfjsclpqGwFbGAPdj+tj5/0gZrOFUk/aHXBEBknDHxbVfBh1Q0vkH2er1L8CimY
         Yq7GZjB/OG9fHAR9BPDG/PCFDeProSnICztWgVUvq3GAKUxB4FjZ7J+SP0KG20Vr2KSz
         4Dlvs+XW3P8rqraZWCFKFj/PFX3gvWi1SbocPXVL1Nmx1pokLT/EGPSKhPsccerwMpLa
         8S17KgafTC1G+aLj2yReKsVTUipW1Ty5FfiqXM1Xrq/pUiGB7q6lNm+A04SqO6rLzPRo
         5M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V+e6Sk3SdH6RDyqe735Wb6nHpwM2/KCwKA8BXrg2X1g=;
        b=SzP7MIb5wjPLgRYu2obhocrFLe6LHy8J6lFWwzJX/kEnpCjAgmscVzfvfW87ZJxgkd
         oQ6T3lPkv8XKti6q4scv/tfKulaNrdTS/yBxW8dZjOGICHx5sXAzKxUOr1DzCkjHvJ68
         xhBaKcq7MrApop0rQqPQ3K8jFNSm/XbEUNmv7lSNhAmrHQcYLO+ZQgK9d62spUA79tDr
         +IlELU9sso4CiFl5Ji0K/GD7BlvmlLwzYGZMe+H15nYhnawTd8qGPXsaK9+NA6ST5O7d
         yRbtiClRTumxfhJqtU9g7BtUKws+m8egBAdj6TwmkKC8eY/4WpJ2+FSEV8IE9OgdWirS
         0rbw==
X-Gm-Message-State: APjAAAVw44trNNN1AfNZaC2pRgLEuHZkGSUmQoWh0scobfbBDhWZVzCe
        bnYx7i8YVIkn4C7HdzaYjyIdrLT5yS6K6QIlLtLdSA==
X-Google-Smtp-Source: APXvYqwJ0hCWtWuBhSP1A5imO8bDnHn/YlRWYbHhziu0OIEZSoc6DwRhlg6lW9/m211ny/N+uAyj3lWfXjWHSxv4V+eJwQ==
X-Received: by 2002:a63:161b:: with SMTP id w27mr17380001pgl.38.1569025175151;
 Fri, 20 Sep 2019 17:19:35 -0700 (PDT)
Date:   Fri, 20 Sep 2019 17:18:47 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-12-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 11/19] kunit: test: add the concept of assertions
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
        wfg@linux.intel.com, torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>
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
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/test.h           | 282 ++++++++++++++++++++++++++++++++-
 lib/kunit/string-stream-test.c |   2 +-
 lib/kunit/test-test.c          |   7 +-
 3 files changed, 283 insertions(+), 8 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 3d554d7c1c79..8b7eb03d4971 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -87,8 +87,9 @@ struct kunit;
  * @name:     the name of the test case.
  *
  * A test case is a function with the signature,
- * ``void (*)(struct kunit *)`` that makes expectations (see
- * KUNIT_EXPECT_TRUE()) about code under test. Each test case is associated
+ * ``void (*)(struct kunit *)``
+ * that makes expectations and assertions (see KUNIT_EXPECT_TRUE() and
+ * KUNIT_ASSERT_TRUE()) about code under test. Each test case is associated
  * with a &struct kunit_suite and will be run after the suite's init
  * function and followed by the suite's exit function.
  *
@@ -1210,4 +1211,281 @@ do {									       \
 						fmt,			       \
 						##__VA_ARGS__)
 
+#define KUNIT_ASSERT_FAILURE(test, fmt, ...) \
+	KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION, fmt, ##__VA_ARGS__)
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
+	KUNIT_TRUE_ASSERTION(test, KUNIT_ASSERTION, condition)
+
+#define KUNIT_ASSERT_TRUE_MSG(test, condition, fmt, ...)		       \
+	KUNIT_TRUE_MSG_ASSERTION(test,					       \
+				 KUNIT_ASSERTION,			       \
+				 condition,				       \
+				 fmt,					       \
+				 ##__VA_ARGS__)
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
+#define KUNIT_ASSERT_FALSE(test, condition) \
+	KUNIT_FALSE_ASSERTION(test, KUNIT_ASSERTION, condition)
+
+#define KUNIT_ASSERT_FALSE_MSG(test, condition, fmt, ...)		       \
+	KUNIT_FALSE_MSG_ASSERTION(test,					       \
+				  KUNIT_ASSERTION,			       \
+				  condition,				       \
+				  fmt,					       \
+				  ##__VA_ARGS__)
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
+	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
+				      KUNIT_ASSERTION,			       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
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
+	KUNIT_BINARY_PTR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  KUNIT_ASSERTION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
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
+	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
+				      KUNIT_ASSERTION,			       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
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
+	KUNIT_BINARY_PTR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  KUNIT_ASSERTION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
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
+	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
+				      KUNIT_ASSERTION,			       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
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
+	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_LE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
+				      KUNIT_ASSERTION,			       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
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
+	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
+				      KUNIT_ASSERTION,			       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
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
+	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_GE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
+				      KUNIT_ASSERTION,			       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
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
+#define KUNIT_ASSERT_STREQ(test, left, right) \
+	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_STREQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
+					  KUNIT_ASSERTION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
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
+#define KUNIT_ASSERT_STRNEQ(test, left, right) \
+	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
+					  KUNIT_ASSERTION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
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
+#define KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr) \
+	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_ASSERTION, ptr)
+
+#define KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
+	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
+						KUNIT_ASSERTION,	       \
+						ptr,			       \
+						fmt,			       \
+						##__VA_ARGS__)
+
 #endif /* _KUNIT_TEST_H */
diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 75229e267c32..76cc05eb00ed 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -35,7 +35,7 @@ static void string_stream_test_get_string(struct kunit *test)
 	string_stream_add(stream, " %s", "bar");
 
 	output = string_stream_get_string(stream);
-	KUNIT_EXPECT_STREQ(test, output, "Foo bar");
+	KUNIT_ASSERT_STREQ(test, output, "Foo bar");
 }
 
 static struct kunit_case string_stream_test_cases[] = {
diff --git a/lib/kunit/test-test.c b/lib/kunit/test-test.c
index 06d34d36b103..e0ab4bd546ea 100644
--- a/lib/kunit/test-test.c
+++ b/lib/kunit/test-test.c
@@ -78,16 +78,13 @@ static int kunit_try_catch_test_init(struct kunit *test)
 	struct kunit_try_catch_test_context *ctx;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
-
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 	test->priv = ctx;
 
 	ctx->try_catch = kunit_kmalloc(test,
 				       sizeof(*ctx->try_catch),
 				       GFP_KERNEL);
-	if (!ctx->try_catch)
-		return -ENOMEM;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->try_catch);
 
 	return 0;
 }
-- 
2.23.0.351.gc4317032e6-goog

