Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5BE588015
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 18:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiHBQQl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbiHBQPo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 12:15:44 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1778550BE;
        Tue,  2 Aug 2022 09:13:07 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Ly0Q451y1zDqgm;
        Tue,  2 Aug 2022 16:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659456764; bh=uX+yUVEMXQ+7yrD+pwEtCZDWkvwi6ncDAlUK5Q8evAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EY+wMyuonv/AGRhoTCXQV8LVl9Gm6MJJ0NHuKteUt6T/mMud7EIKoqe1yO7nWbXxS
         eYeb9VVnnJk4WpnQ99lY9xNbxMpzvhXcLPKP5DvXVgvJBmIawIkHP5Xga5JsHZCjwU
         dWALEjhtdvOQlOUs2xpHO1mQmJHbTGTV57Td9fGc=
X-Riseup-User-ID: DED1D15536D78D6B3302E27F739E8EC4D37862F5129D63327B02F0F26625185B
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Ly0Pz0TbMz5vTk;
        Tue,  2 Aug 2022 16:12:38 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        airlied@linux.ie, daniel@ffwll.ch, davem@davemloft.net,
        kuba@kernel.org, jose.exposito89@gmail.com, javierm@redhat.com
Cc:     andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH 1/3] kunit: Introduce KUNIT_EXPECT_ARREQ and KUNIT_EXPECT_ARRNEQ macros
Date:   Tue,  2 Aug 2022 13:12:04 -0300
Message-Id: <20220802161206.228707-2-mairacanal@riseup.net>
In-Reply-To: <20220802161206.228707-1-mairacanal@riseup.net>
References: <20220802161206.228707-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, in order to compare arrays in KUnit, the KUNIT_EXPECT_EQ or
KUNIT_EXPECT_FALSE macros are used in conjunction with the memcmp
function, such as:
    KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);

Although this usage produces correct results for the test cases, when
the expectation fails, the error message is not very helpful,
indicating only the return of the memcmp function.

Therefore, create a new set of macros KUNIT_EXPECT_ARREQ and
KUNIT_EXPECT_ARRNEQ that compare memory blocks until a determined size.
In case of expectation failure, those macros print the hex dump of the
memory blocks, making it easier to debug test failures for arrays.

That said, the expectation

    KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);

would translate to the expectation

    KUNIT_EXPECT_ARREQ(test, foo, bar, size);

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 include/kunit/assert.h | 35 +++++++++++++++++++
 include/kunit/test.h   | 76 ++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/assert.c     | 43 ++++++++++++++++++++++++
 3 files changed, 154 insertions(+)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 4b52e12c2ae8..b8fac8eec0af 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -256,4 +256,39 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    const struct va_format *message,
 				    struct string_stream *stream);
 
+
+#define KUNIT_INIT_ARR_ASSERT_STRUCT(text_, left_val, right_val, size_) \
+	{                                                                 \
+		.assert = { .format = kunit_arr_assert_format },   \
+		.text = text_,                                            \
+		.left_value = left_val,                                   \
+		.right_value = right_val, .size = size_,                  \
+	}
+
+/**
+ * struct kunit_arr_assert - An expectation/assertion that compares two
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
+ * KUNIT_EXPECT_ARREQ(test, foo, bar, 3);
+ */
+struct kunit_arr_assert {
+	struct kunit_assert assert;
+	const struct kunit_binary_assert_text *text;
+	const void *left_value;
+	const void *right_value;
+	const size_t size;
+};
+
+void kunit_arr_assert_format(const struct kunit_assert *assert,
+				    const struct va_format *message,
+				    struct string_stream *stream);
+
 #endif /*  _KUNIT_ASSERT_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8ffcd7de9607..30547fc57c1e 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -684,6 +684,36 @@ do {									       \
 			##__VA_ARGS__);					       \
 } while (0)
 
+#define KUNIT_ARRAY_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left,				       \
+				   op,					       \
+				   right,				       \
+				   size,                       \
+				   fmt,					       \
+				   ...)					       \
+do {									       \
+	const void *__left = (left);				       \
+	const void *__right = (right);				       \
+	const size_t __size = (size);					       \
+	static const struct kunit_binary_assert_text __text = {		       \
+		.operation = #op,					       \
+		.left_text = #left,					       \
+		.right_text = #right,					       \
+	};								       \
+									       \
+	KUNIT_ASSERTION(test,						       \
+			assert_type,					       \
+			memcmp(__left, __right, __size) op 0,			       \
+			kunit_arr_assert,			       \
+			KUNIT_INIT_ARR_ASSERT_STRUCT(&__text,	    \
+							__left,		       \
+							__right,           \
+							__size),	       \
+			fmt,						       \
+			##__VA_ARGS__);					       \
+} while (0)
+
 #define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
 						assert_type,		       \
 						ptr,			       \
@@ -952,6 +982,52 @@ do {									       \
 				   fmt,					       \
 				   ##__VA_ARGS__)
 
+/**
+ * KUNIT_EXPECT_ARREQ() - Expects that the first @size bytes of @left and @right are equal.
+ * @test: The test context object.
+ * @left: An arbitrary expression that evaluates to a determinated size.
+ * @right: An arbitrary expression that evaluates to a determinated size.
+ * @size: Number of bytes compared.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, !memcmp((@left), (@right), (@size))). See
+ * KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_EXPECT_ARREQ(test, left, right, size) \
+	KUNIT_EXPECT_ARREQ_MSG(test, left, right, size, NULL)
+
+#define KUNIT_EXPECT_ARREQ_MSG(test, left, right, size, fmt, ...)		       \
+	KUNIT_ARRAY_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, ==, right,			       \
+				   size,                       \
+				   fmt,					   \
+				   ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_STRNEQ() - Expects that the first @size bytes of @left and @right are not equal.
+ * @test: The test context object.
+ * @left: An arbitrary expression that evaluates to a determinated size.
+ * @right: An arbitrary expression that evaluates to a determinated size.
+ * @size: Number of bytes compared.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * not equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, memcmp((@left), (@right), (@size))). See
+ * KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_EXPECT_ARRNEQ(test, left, right, size) \
+	KUNIT_EXPECT_ARRNEQ_MSG(test, left, right, size, NULL)
+
+#define KUNIT_EXPECT_ARRNEQ_MSG(test, left, right, size, fmt, ...)		       \
+	KUNIT_ARRAY_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   left, !=, right,			       \
+				   size,                       \
+				   fmt,					   \
+				   ##__VA_ARGS__)
+
 /**
  * KUNIT_EXPECT_NULL() - Expects that @ptr is null.
  * @test: The test context object.
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index d00d6d181ee8..0b537a8690e0 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -204,3 +204,46 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
+
+/* Adds a hexdump of a buffer to a string_stream */
+static void kunit_assert_hexdump(struct string_stream *stream,
+		const void *buf, const size_t len)
+{
+	const u8 *ptr = buf;
+	int i, linelen, remaining = len;
+	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
+
+	for (i = 0; i < len; i += 16) {
+		linelen = min(remaining, 16);
+		remaining -= 16;
+
+		hex_dump_to_buffer(ptr + i, linelen, 16, 1, linebuf, sizeof(linebuf), false);
+
+		string_stream_add(stream, "%.8x: %s\n", i, linebuf);
+	}
+}
+
+void kunit_arr_assert_format(const struct kunit_assert *assert,
+				    const struct va_format *message,
+				    struct string_stream *stream)
+{
+	struct kunit_arr_assert *arr_assert;
+
+	arr_assert = container_of(assert, struct kunit_arr_assert,
+				     assert);
+
+	string_stream_add(stream,
+			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
+			  arr_assert->text->left_text,
+			  arr_assert->text->operation,
+			  arr_assert->text->right_text);
+
+	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \n", arr_assert->text->left_text);
+	kunit_assert_hexdump(stream, arr_assert->left_value, arr_assert->size);
+
+	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \n", arr_assert->text->right_text);
+	kunit_assert_hexdump(stream, arr_assert->right_value, arr_assert->size);
+
+	kunit_assert_print_msg(message, stream);
+}
+EXPORT_SYMBOL_GPL(kunit_arr_assert_format);
-- 
2.37.1

