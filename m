Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B185BF306
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 03:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiIUBpo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 21:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiIUBpk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 21:45:40 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EC07A75F;
        Tue, 20 Sep 2022 18:45:39 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MXLpV70n9z9sc0;
        Wed, 21 Sep 2022 01:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1663724739; bh=EL2zYHge90uxxzq1docwWSyygKAr3hhhftipqU+iz9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=InWOIohjax5pql+IGr88+kYYNl9NNkorfQYmisYPdB+ntDSnDaU5VsqBlChEedJyf
         BA4PHfniQe31kaq2wxa9SiYeY5sJpYLbhW9emtZZJdOUgLHhVTm/z3py2ZIRZZ2WCx
         /FIpK58whrL4PGgUv+Er3wbPyZytBTTN5L9kZQ34=
X-Riseup-User-ID: 0AF5D053D03E323ABA3121D0054048927DA7DA6862DB46678E0395F6AEE26288
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MXLpR51jMz5vMb;
        Wed, 21 Sep 2022 01:45:35 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        Daniel Latypov <dlatypov@google.com>, daniel@ffwll.ch,
        davem@davemloft.net, kuba@kernel.org, jose.exposito89@gmail.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v5 1/3] kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros
Date:   Tue, 20 Sep 2022 22:45:13 -0300
Message-Id: <20220921014515.113062-2-mairacanal@riseup.net>
In-Reply-To: <20220921014515.113062-1-mairacanal@riseup.net>
References: <20220921014515.113062-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, in order to compare memory blocks in KUnit, the KUNIT_EXPECT_EQ
or KUNIT_EXPECT_FALSE macros are used in conjunction with the memcmp
function, such as:
    KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);

Although this usage produces correct results for the test cases, when
the expectation fails, the error message is not very helpful,
indicating only the return of the memcmp function.

Therefore, create a new set of macros KUNIT_EXPECT_MEMEQ and
KUNIT_EXPECT_MEMNEQ that compare memory blocks until a specified size.
In case of expectation failure, those macros print the hex dump of the
memory blocks, making it easier to debug test failures for memory blocks.

That said, the expectation

    KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);

would translate to the expectation

    KUNIT_EXPECT_MEMEQ(test, foo, bar, size);

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 include/kunit/assert.h | 34 +++++++++++++++++
 include/kunit/test.h   | 84 ++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/assert.c     | 56 ++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 4b52e12c2ae8..4b817a8eb619 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -256,4 +256,38 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    const struct va_format *message,
 				    struct string_stream *stream);
 
+#define KUNIT_INIT_MEM_ASSERT_STRUCT(text_, left_val, right_val, size_)   \
+	{                                                                 \
+		.assert = { .format = kunit_mem_assert_format },          \
+		.text = text_,                                            \
+		.left_value = left_val,                                   \
+		.right_value = right_val, .size = size_,                  \
+	}
+
+/**
+ * struct kunit_mem_assert - An expectation/assertion that compares two
+ *	memory blocks.
+ * @assert: The parent of this type.
+ * @text: Holds the textual representations of the operands and comparator.
+ * @left_value: The actual evaluated value of the expression in the left slot.
+ * @right_value: The actual evaluated value of the expression in the right slot.
+ * @size: Size of the memory block analysed in bytes.
+ *
+ * Represents an expectation/assertion that compares two memory blocks. For
+ * example, to expect that the first three bytes of foo is equal to the
+ * first three bytes of bar, you can use the expectation
+ * KUNIT_EXPECT_MEMEQ(test, foo, bar, 3);
+ */
+struct kunit_mem_assert {
+	struct kunit_assert assert;
+	const struct kunit_binary_assert_text *text;
+	const void *left_value;
+	const void *right_value;
+	const size_t size;
+};
+
+void kunit_mem_assert_format(const struct kunit_assert *assert,
+			     const struct va_format *message,
+			     struct string_stream *stream);
+
 #endif /*  _KUNIT_ASSERT_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index c958855681cc..d384d61e7f11 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -647,6 +647,36 @@ do {									       \
 			##__VA_ARGS__);					       \
 } while (0)
 
+#define KUNIT_MEM_ASSERTION(test,					       \
+			    assert_type,				       \
+			    left,					       \
+			    op,						       \
+			    right,					       \
+			    size,					       \
+			    fmt,					       \
+			    ...)					       \
+do {									       \
+	const void *__left = (left);					       \
+	const void *__right = (right);					       \
+	const size_t __size = (size);					       \
+	static const struct kunit_binary_assert_text __text = {		       \
+		.operation = #op,					       \
+		.left_text = #left,					       \
+		.right_text = #right,					       \
+	};								       \
+									       \
+	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
+			memcmp(__left, __right, __size) op 0,		       \
+			kunit_mem_assert,				       \
+			KUNIT_INIT_MEM_ASSERT_STRUCT(&__text,		       \
+						     __left,		       \
+						     __right,		       \
+						     __size),		       \
+			fmt,						       \
+			##__VA_ARGS__);					       \
+} while (0)
+
 #define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
 						assert_type,		       \
 						ptr,			       \
@@ -915,6 +945,60 @@ do {									       \
 				   fmt,					       \
 				   ##__VA_ARGS__)
 
+/**
+ * KUNIT_EXPECT_MEMEQ() - Expects that the first @size bytes of @left and @right are equal.
+ * @test: The test context object.
+ * @left: An arbitrary expression that evaluates to the specified size.
+ * @right: An arbitrary expression that evaluates to the specified size.
+ * @size: Number of bytes compared.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, !memcmp((@left), (@right), (@size))). See
+ * KUNIT_EXPECT_TRUE() for more information.
+ *
+ * Although this expectation works for any memory block, it is not recommended
+ * for comparing more structured data, such as structs. This expectation is
+ * recommended for comparing, for example, data arrays.
+ */
+#define KUNIT_EXPECT_MEMEQ(test, left, right, size) \
+	KUNIT_EXPECT_MEMEQ_MSG(test, left, right, size, NULL)
+
+#define KUNIT_EXPECT_MEMEQ_MSG(test, left, right, size, fmt, ...)	       \
+	KUNIT_MEM_ASSERTION(test,					       \
+			    KUNIT_EXPECTATION,				       \
+			    left, ==, right,				       \
+			    size,					       \
+			    fmt,					       \
+			    ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_MEMNEQ() - Expects that the first @size bytes of @left and @right are not equal.
+ * @test: The test context object.
+ * @left: An arbitrary expression that evaluates to the specified size.
+ * @right: An arbitrary expression that evaluates to the specified size.
+ * @size: Number of bytes compared.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * not equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, memcmp((@left), (@right), (@size))). See
+ * KUNIT_EXPECT_TRUE() for more information.
+ *
+ * Although this expectation works for any memory block, it is not recommended
+ * for comparing more structured data, such as structs. This expectation is
+ * recommended for comparing, for example, data arrays.
+ */
+#define KUNIT_EXPECT_MEMNEQ(test, left, right, size) \
+	KUNIT_EXPECT_MEMNEQ_MSG(test, left, right, size, NULL)
+
+#define KUNIT_EXPECT_MEMNEQ_MSG(test, left, right, size, fmt, ...)	       \
+	KUNIT_MEM_ASSERTION(test,					       \
+			    KUNIT_EXPECTATION,				       \
+			    left, !=, right,				       \
+			    size,					       \
+			    fmt,					       \
+			    ##__VA_ARGS__)
+
 /**
  * KUNIT_EXPECT_NULL() - Expects that @ptr is null.
  * @test: The test context object.
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index d00d6d181ee8..c346a8d7fa6e 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -204,3 +204,59 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
+
+/* Adds a hexdump of a buffer to a string_stream comparing it with
+ * a second buffer. The different bytes are marked with <>.
+ */
+static void kunit_assert_hexdump(struct string_stream *stream,
+				 const void *buf,
+				 const void *compared_buf,
+				 const size_t len)
+{
+	size_t i;
+	const u8 *buf1 = buf;
+	const u8 *buf2 = compared_buf;
+
+	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT);
+
+	for (i = 0; i < len; ++i) {
+		if (!(i % 16) && i)
+			string_stream_add(stream, "\n" KUNIT_SUBSUBTEST_INDENT);
+
+		if (buf1[i] != buf2[i])
+			string_stream_add(stream, "<%02x>", buf1[i]);
+		else
+			string_stream_add(stream, " %02x ", buf1[i]);
+	}
+}
+
+void kunit_mem_assert_format(const struct kunit_assert *assert,
+			     const struct va_format *message,
+			     struct string_stream *stream)
+{
+	struct kunit_mem_assert *mem_assert;
+
+	mem_assert = container_of(assert, struct kunit_mem_assert,
+				  assert);
+
+	string_stream_add(stream,
+			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
+			  mem_assert->text->left_text,
+			  mem_assert->text->operation,
+			  mem_assert->text->right_text);
+
+	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
+			  mem_assert->text->left_text);
+	kunit_assert_hexdump(stream, mem_assert->left_value,
+			     mem_assert->right_value, mem_assert->size);
+
+	string_stream_add(stream, "\n");
+
+	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
+			  mem_assert->text->right_text);
+	kunit_assert_hexdump(stream, mem_assert->right_value,
+			     mem_assert->left_value, mem_assert->size);
+
+	kunit_assert_print_msg(message, stream);
+}
+EXPORT_SYMBOL_GPL(kunit_mem_assert_format);
-- 
2.37.3

