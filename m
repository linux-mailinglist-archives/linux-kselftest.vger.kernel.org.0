Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F201947C67
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2019 10:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfFQI1B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jun 2019 04:27:01 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:54132 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfFQI07 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jun 2019 04:26:59 -0400
Received: by mail-ua1-f74.google.com with SMTP id z23so900195uag.20
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2019 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xEJMkGFtF5XwVoJnOv9xNCkGyRuPzyP2W7F37aJmIrU=;
        b=J4/V2tgdON3t2E8oV6VOtU82qpAo3llKtFVfbUK9I4f5ndTVU+quA+a6UsTD1p0cWs
         D/IqivgM0zYSmruJR5jwzr1wHA+sJniG5RaWLiSMUqJzGRrsqtpamMMDIicM5DctIoYB
         0f/wJsUMAb6RxBD5jqcatiIbluZ0xTYVf8AR/SOpbXmP0UzO1gcpfvmLRWf206JAW6Du
         wFAA8zKV8PmyjoIkNbI4OwC9KCROpVM1w/sT/lBn8rDiq3Hn6o+XDstnKhKgxmW3Cp4b
         8zRCmKg1G0TC4MEHOA8e0nWpDQjCl302faKNnBJ6Chf1JnphCG7d67AzxOaN9rV4hPRJ
         s0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xEJMkGFtF5XwVoJnOv9xNCkGyRuPzyP2W7F37aJmIrU=;
        b=nLa+x8iSJO4U8BUHJG211Edrs+WvLk83+yZcaw0anKvNLzt38Xb0bETONgArw7Bd/v
         wCNdDWJTVN/s0Og0c6OO/MTE99yway+LN78ChkArUldQfui50mJ1aQM4OodFToKDjqRV
         BQRHdH4LzSnTmhAQ7kxSHRgFoIHtqEjRX0G80fiCYKlhMLAOPVr1DB27mHkTCsbIWx2E
         vfIU9HVeefMhleq657x3pC+8NvGKQQPU4y6QumAMI2R6wbhHCStQT44ecEW7srHPaZNE
         NKNL0Hwc86LbayU2q3x9HBpDJyAOHPif6tLImGhh2agI6bs/Yl5qi7OHUfGorTk3Hv10
         GuFg==
X-Gm-Message-State: APjAAAW4UrRTpHJoGC3AuiFMgaz/dOaBgAobQosb7aUsap2hIxF9dPj8
        5zp+mcaL8kmfhQBEQaT6Wwqcu1Fsk4p9tOYwSg3AWQ==
X-Google-Smtp-Source: APXvYqxCUjW7sC4JM3ynUVNFBOBCcFQEue1WjUpmgelmghMKM9vseHcn08NSjtODBu6IS7F9rxj4EMPD/gf2+qwKWEpuqQ==
X-Received: by 2002:a1f:2b07:: with SMTP id r7mr18950757vkr.65.1560760017944;
 Mon, 17 Jun 2019 01:26:57 -0700 (PDT)
Date:   Mon, 17 Jun 2019 01:26:00 -0700
In-Reply-To: <20190617082613.109131-1-brendanhiggins@google.com>
Message-Id: <20190617082613.109131-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 05/18] kunit: test: add the concept of expectations
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

Add support for expectations, which allow properties to be specified and
then verified in tests.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
Changes Since Last Revision:
 - Added typechecking to expectations that compare two things of
   arbitrary types (it just verifies that the two compared types match),
   as suggested by Stephen Boyd.
---
 include/kunit/test.h | 525 +++++++++++++++++++++++++++++++++++++++++++
 kunit/test.c         |  66 ++++++
 2 files changed, 591 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 83fb7ace1b320..e4c760ccc8717 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -9,6 +9,7 @@
 #ifndef _KUNIT_TEST_H
 #define _KUNIT_TEST_H
 
+#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <kunit/kunit-stream.h>
@@ -271,4 +272,528 @@ void __printf(3, 4) kunit_printk(const char *level,
 #define kunit_err(test, fmt, ...) \
 		kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
 
+/*
+ * Generates a compile-time warning in case of comparing incompatible types.
+ */
+#define __kunit_typecheck(lhs, rhs) \
+	((void) __typecheck(lhs, rhs))
+
+static inline struct kunit_stream *kunit_expect_start(struct kunit *test,
+						      const char *file,
+						      const char *line)
+{
+	struct kunit_stream *stream = alloc_kunit_stream(test, KERN_ERR);
+
+	kunit_stream_add(stream, "EXPECTATION FAILED at %s:%s\n\t", file, line);
+
+	return stream;
+}
+
+static inline void kunit_expect_end(struct kunit *test,
+				    bool success,
+				    struct kunit_stream *stream)
+{
+	if (!success)
+		kunit_fail(test, stream);
+	else
+		kunit_stream_clear(stream);
+}
+
+#define KUNIT_EXPECT_START(test) \
+		kunit_expect_start(test, __FILE__, __stringify(__LINE__))
+
+#define KUNIT_EXPECT_END(test, success, stream) \
+		kunit_expect_end(test, success, stream)
+
+#define KUNIT_EXPECT_MSG(test, success, message, fmt, ...) do {		       \
+	struct kunit_stream *__stream = KUNIT_EXPECT_START(test);	       \
+									       \
+	kunit_stream_add(__stream, message);				       \
+	kunit_stream_add(__stream, fmt, ##__VA_ARGS__);			       \
+	KUNIT_EXPECT_END(test, success, __stream);			       \
+} while (0)
+
+#define KUNIT_EXPECT(test, success, message) do {			       \
+	struct kunit_stream *__stream = KUNIT_EXPECT_START(test);	       \
+									       \
+	kunit_stream_add(__stream, message);				       \
+	KUNIT_EXPECT_END(test, success, __stream);			       \
+} while (0)
+
+/**
+ * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
+ * @test: The test context object.
+ *
+ * The opposite of KUNIT_FAIL(), it is an expectation that cannot fail. In other
+ * words, it does nothing and only exists for code clarity. See
+ * KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_SUCCEED(test) do {} while (0)
+
+/**
+ * KUNIT_FAIL() - Always causes a test to fail when evaluated.
+ * @test: The test context object.
+ * @fmt: an informational message to be printed when the assertion is made.
+ * @...: string format arguments.
+ *
+ * The opposite of KUNIT_SUCCEED(), it is an expectation that always fails. In
+ * other words, it always results in a failed expectation, and consequently
+ * always causes the test case to fail when evaluated. See KUNIT_EXPECT_TRUE()
+ * for more information.
+ */
+#define KUNIT_FAIL(test, fmt, ...) do {					       \
+	struct kunit_stream *__stream = KUNIT_EXPECT_START(test);	       \
+									       \
+	kunit_stream_add(__stream, fmt, ##__VA_ARGS__);			       \
+	KUNIT_EXPECT_END(test, false, __stream);			       \
+} while (0)
+
+/**
+ * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression. The test fails when this does
+ * not evaluate to true.
+ *
+ * This and expectations of the form `KUNIT_EXPECT_*` will cause the test case
+ * to fail when the specified condition is not met; however, it will not prevent
+ * the test case from continuing to run; this is otherwise known as an
+ * *expectation failure*.
+ */
+#define KUNIT_EXPECT_TRUE(test, condition)				       \
+		KUNIT_EXPECT(test, (condition),				       \
+		       "Expected " #condition " is true, but is false\n")
+
+#define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)		       \
+		KUNIT_EXPECT_MSG(test, (condition),			       \
+				"Expected " #condition " is true, but is false\n",\
+				fmt, ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_FALSE() - Makes a test failure when the expression is not false.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression. The test fails when this does
+ * not evaluate to false.
+ *
+ * Sets an expectation that @condition evaluates to false. See
+ * KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_EXPECT_FALSE(test, condition)				       \
+		KUNIT_EXPECT(test, !(condition),			       \
+		       "Expected " #condition " is false, but is true\n")
+
+#define KUNIT_EXPECT_FALSE_MSG(test, condition, fmt, ...)		       \
+		KUNIT_EXPECT_MSG(test, !(condition),			       \
+				"Expected " #condition " is false, but is true\n",\
+				fmt, ##__VA_ARGS__)
+
+void kunit_expect_binary_msg(struct kunit *test,
+			     long long left, const char *left_name,
+			     long long right, const char *right_name,
+			     bool compare_result,
+			     const char *compare_name,
+			     const char *file,
+			     const char *line,
+			     const char *fmt, ...);
+
+static inline void kunit_expect_binary(struct kunit *test,
+				       long long left, const char *left_name,
+				       long long right, const char *right_name,
+				       bool compare_result,
+				       const char *compare_name,
+				       const char *file,
+				       const char *line)
+{
+	kunit_expect_binary_msg(test,
+				left, left_name,
+				right, right_name,
+				compare_result,
+				compare_name,
+				file,
+				line,
+				NULL);
+}
+
+void kunit_expect_ptr_binary_msg(struct kunit *test,
+				 void *left, const char *left_name,
+				 void *right, const char *right_name,
+				 bool compare_result,
+				 const char *compare_name,
+				 const char *file,
+				 const char *line,
+				 const char *fmt, ...);
+
+static inline void kunit_expect_ptr_binary(struct kunit *test,
+					   void *left, const char *left_name,
+					   void *right, const char *right_name,
+					   bool compare_result,
+					   const char *compare_name,
+					   const char *file,
+					   const char *line)
+{
+	kunit_expect_ptr_binary_msg(test,
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
+#define KUNIT_EXPECT_BINARY(test, left, condition, right) do {		       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
+	kunit_expect_binary(test,					       \
+			    (long long) __left, #left,			       \
+			    (long long) __right, #right,		       \
+			    __left condition __right, #condition,	       \
+			    __FILE__, __stringify(__LINE__));		       \
+} while (0)
+
+#define KUNIT_EXPECT_BINARY_MSG(test, left, condition, right, fmt, ...) do {   \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
+	kunit_expect_binary_msg(test,					       \
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
+#define KUNIT_EXPECT_PTR_BINARY(test, left, condition, right) do {	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
+	kunit_expect_ptr_binary(test,					       \
+			    (void *) __left, #left,			       \
+			    (void *) __right, #right,			       \
+			    __left condition __right, #condition,	       \
+			    __FILE__, __stringify(__LINE__));		       \
+} while (0)
+
+#define KUNIT_EXPECT_PTR_BINARY_MSG(test, left, condition, right, fmt, ...)    \
+do {									       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
+	kunit_expect_ptr_binary_msg(test,				       \
+				    (void *) __left, #left,		       \
+				    (void *) __right, #right,		       \
+				    __left condition __right, #condition,      \
+				    __FILE__, __stringify(__LINE__),	       \
+				    fmt, ##__VA_ARGS__);		       \
+} while (0)
+
+/**
+ * KUNIT_EXPECT_EQ() - Sets an expectation that @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_EQ(test, left, right) \
+		KUNIT_EXPECT_BINARY(test, left, ==, right)
+
+#define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_EXPECT_BINARY_MSG(test,				       \
+					left,				       \
+					==,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_PTR_EQ() - Expects that pointers @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a pointer.
+ * @right: an arbitrary expression that evaluates to a pointer.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_PTR_EQ(test, left, right) \
+		KUNIT_EXPECT_PTR_BINARY(test, left, ==, right)
+
+#define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_EXPECT_PTR_BINARY_MSG(test,			       \
+					    left,			       \
+					    ==,				       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_NE() - An expectation that @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are not
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_NE(test, left, right) \
+		KUNIT_EXPECT_BINARY(test, left, !=, right)
+
+#define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_EXPECT_BINARY_MSG(test,				       \
+					left,				       \
+					!=,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_PTR_NE() - Expects that pointers @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a pointer.
+ * @right: an arbitrary expression that evaluates to a pointer.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are not
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_PTR_NE(test, left, right) \
+		KUNIT_EXPECT_PTR_BINARY(test, left, !=, right)
+
+#define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_EXPECT_PTR_BINARY_MSG(test,			       \
+					    left,			       \
+					    !=,				       \
+					    right,			       \
+					    fmt,			       \
+					    ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_LT() - An expectation that @left is less than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is less than the
+ * value that @right evaluates to. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) < (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_LT(test, left, right) \
+		KUNIT_EXPECT_BINARY(test, left, <, right)
+
+#define KUNIT_EXPECT_LT_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_EXPECT_BINARY_MSG(test,				       \
+					left,				       \
+					<,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_LE() - Expects that @left is less than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is less than or
+ * equal to the value that @right evaluates to. Semantically this is equivalent
+ * to KUNIT_EXPECT_TRUE(@test, (@left) <= (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_LE(test, left, right) \
+		KUNIT_EXPECT_BINARY(test, left, <=, right)
+
+#define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_EXPECT_BINARY_MSG(test,				       \
+					left,				       \
+					<=,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_GT() - An expectation that @left is greater than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is greater than
+ * the value that @right evaluates to. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) > (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_GT(test, left, right) \
+		KUNIT_EXPECT_BINARY(test, left, >, right)
+
+#define KUNIT_EXPECT_GT_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_EXPECT_BINARY_MSG(test,				       \
+					left,				       \
+					>,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_GE() - Expects that @left is greater than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is greater than
+ * the value that @right evaluates to. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) >= (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_GE(test, left, right) \
+		KUNIT_EXPECT_BINARY(test, left, >=, right)
+
+#define KUNIT_EXPECT_GE_MSG(test, left, right, fmt, ...)		       \
+		KUNIT_EXPECT_BINARY_MSG(test,				       \
+					left,				       \
+					>=,				       \
+					right,				       \
+					fmt,				       \
+					##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_STREQ() - Expects that strings @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, !strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
+ * for more information.
+ */
+#define KUNIT_EXPECT_STREQ(test, left, right) do {			       \
+	struct kunit_stream *__stream = KUNIT_EXPECT_START(test);	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	kunit_stream_add(__stream, "Expected " #left " == " #right ", but\n"); \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #left, __left);	       \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #right, __right);	       \
+									       \
+	KUNIT_EXPECT_END(test, !strcmp(left, right), __stream);		       \
+} while (0)
+
+#define KUNIT_EXPECT_STREQ_MSG(test, left, right, fmt, ...) do {	       \
+	struct kunit_stream *__stream = KUNIT_EXPECT_START(test);	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	kunit_stream_add(__stream, "Expected " #left " == " #right ", but\n"); \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #left, __left);	       \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #right, __right);	       \
+	kunit_stream_add(__stream, fmt, ##__VA_ARGS__);			       \
+									       \
+	KUNIT_EXPECT_END(test, !strcmp(left, right), __stream);		       \
+} while (0)
+
+/**
+ * KUNIT_EXPECT_STRNEQ() - Expects that strings @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * not equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
+ * for more information.
+ */
+#define KUNIT_EXPECT_STRNEQ(test, left, right) do {			       \
+	struct kunit_stream *__stream = KUNIT_EXPECT_START(test);	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	kunit_stream_add(__stream, "Expected " #left " != " #right ", but\n"); \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #left, __left);	       \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #right, __right);	       \
+									       \
+	KUNIT_EXPECT_END(test, strcmp(left, right), __stream);		       \
+} while (0)
+
+#define KUNIT_EXPECT_STRNEQ_MSG(test, left, right, fmt, ...) do {	       \
+	struct kunit_stream *__stream = KUNIT_EXPECT_START(test);	       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	kunit_stream_add(__stream, "Expected " #left " != " #right ", but\n"); \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #left, __left);	       \
+	kunit_stream_add(__stream, "\t\t%s == %s\n", #right, __right);	       \
+	kunit_stream_add(__stream, fmt, ##__VA_ARGS__);			       \
+									       \
+	KUNIT_EXPECT_END(test, strcmp(left, right), __stream);		       \
+} while (0)
+
+/**
+ * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an expectation that the value that @ptr evaluates to is not null and not
+ * an errno stored in a pointer. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, !IS_ERR_OR_NULL(@ptr)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ptr) do {			       \
+	struct kunit_stream *__stream = KUNIT_EXPECT_START(test);	       \
+	typeof(ptr) __ptr = (ptr);					       \
+									       \
+	if (!__ptr)							       \
+		kunit_stream_add(__stream,				       \
+			      "Expected " #ptr " is not null, but is\n");      \
+	if (IS_ERR(__ptr))						       \
+		kunit_stream_add(__stream,				       \
+			      "Expected " #ptr " is not error, but is: %ld",   \
+			      PTR_ERR(__ptr));				       \
+									       \
+	KUNIT_EXPECT_END(test, !IS_ERR_OR_NULL(__ptr), __stream);	       \
+} while (0)
+
+#define KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...) do {	       \
+	struct kunit_stream *__stream = KUNIT_EXPECT_START(test);	       \
+	typeof(ptr) __ptr = (ptr);					       \
+									       \
+	if (!__ptr) {							       \
+		kunit_stream_add(__stream,				       \
+			      "Expected " #ptr " is not null, but is\n");      \
+		kunit_stream_add(__stream, fmt, ##__VA_ARGS__);		       \
+	}								       \
+	if (IS_ERR(__ptr)) {						       \
+		kunit_stream_add(__stream,				       \
+			      "Expected " #ptr " is not error, but is: %ld",   \
+			      PTR_ERR(__ptr));				       \
+									       \
+		kunit_stream_add(__stream, fmt, ##__VA_ARGS__);		       \
+	}								       \
+	KUNIT_EXPECT_END(test, !IS_ERR_OR_NULL(__ptr), __stream);	       \
+} while (0)
+
 #endif /* _KUNIT_TEST_H */
diff --git a/kunit/test.c b/kunit/test.c
index 9404e4d34fa3f..0ba05467d525f 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -309,3 +309,69 @@ void kunit_printk(const char *level,
 
 	va_end(args);
 }
+
+void kunit_expect_binary_msg(struct kunit *test,
+			     long long left, const char *left_name,
+			     long long right, const char *right_name,
+			     bool compare_result,
+			     const char *compare_name,
+			     const char *file,
+			     const char *line,
+			     const char *fmt, ...)
+{
+	struct kunit_stream *stream = kunit_expect_start(test, file, line);
+	struct va_format vaf;
+	va_list args;
+
+	kunit_stream_add(stream,
+			 "Expected %s %s %s, but\n",
+			 left_name, compare_name, right_name);
+	kunit_stream_add(stream, "\t\t%s == %lld\n", left_name, left);
+	kunit_stream_add(stream, "\t\t%s == %lld", right_name, right);
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
+	kunit_expect_end(test, compare_result, stream);
+}
+
+void kunit_expect_ptr_binary_msg(struct kunit *test,
+				 void *left, const char *left_name,
+				 void *right, const char *right_name,
+				 bool compare_result,
+				 const char *compare_name,
+				 const char *file,
+				 const char *line,
+				 const char *fmt, ...)
+{
+	struct kunit_stream *stream = kunit_expect_start(test, file, line);
+	struct va_format vaf;
+	va_list args;
+
+	kunit_stream_add(stream,
+			 "Expected %s %s %s, but\n",
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
+	kunit_expect_end(test, compare_result, stream);
+}
-- 
2.22.0.410.gd8fdbe21b5-goog

