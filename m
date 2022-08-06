Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775C458B609
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Aug 2022 16:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiHFOVK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Aug 2022 10:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiHFOVJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Aug 2022 10:21:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78485BE1B;
        Sat,  6 Aug 2022 07:21:08 -0700 (PDT)
Received: from [192.168.10.23] (unknown [39.46.64.186])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 37C456601B6F;
        Sat,  6 Aug 2022 15:21:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659795666;
        bh=DdYokYyNOQKr/29EyYNDz69mki37RBqdEUsJqKiFd9I=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=DniTRkWDOsrlXo9E9ST1J0pc09lSLBYynlpfLEtf7lzCVOtEv24smPYjOwG1HKFiA
         5SwPizXCqJPojliBkk1nBbZYlDOMjcVeX3huZe8sVwoKGMyUP9PWkDRCfoGkpQyRIb
         EyFhl0kQyZSFFgUnuVfjdfFw0B382hVsu0JWP9pcfccjDCPlMLMyYT66j4Wo+TPn5L
         zfVKTMpQNBlGuYY8Rw9HceVYI1YEYU/grGx0MU4z1pLuJ2odVzX/1muErkGPGDq0AL
         9GSjh9e5pUd0cCv6jsOe+3YIWG4iSQkSc+OstW0jvUx6Vy5fGSM93pu/DB+iCRvv92
         /G5y+V4u+NQQw==
Message-ID: <1b3298b3-13b5-fbbb-bc8e-f3d0af726d71@collabora.com>
Date:   Sat, 6 Aug 2022 19:20:58 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     usama.anjum@collabora.com, andrealmeid@riseup.net,
        melissa.srw@gmail.com, siqueirajordao@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] kunit: Introduce KUNIT_EXPECT_MEMEQ and
 KUNIT_EXPECT_MEMNEQ macros
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        davidgow@google.com, Daniel Latypov <dlatypov@google.com>,
        airlied@linux.ie, daniel@ffwll.ch, davem@davemloft.net,
        kuba@kernel.org, jose.exposito89@gmail.com, javierm@redhat.com
References: <20220803215855.258704-1-mairacanal@riseup.net>
 <20220803215855.258704-2-mairacanal@riseup.net>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220803215855.258704-2-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/4/22 2:58 AM, Maíra Canal wrote:
> Currently, in order to compare memory blocks in KUnit, the KUNIT_EXPECT_EQ
> or KUNIT_EXPECT_FALSE macros are used in conjunction with the memcmp
> function, such as:
>     KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);
> 
> Although this usage produces correct results for the test cases, when
> the expectation fails, the error message is not very helpful,
> indicating only the return of the memcmp function.
> 
> Therefore, create a new set of macros KUNIT_EXPECT_MEMEQ and
> KUNIT_EXPECT_MEMNEQ that compare memory blocks until a specified size.
> In case of expectation failure, those macros print the hex dump of the
> memory blocks, making it easier to debug test failures for memory blocks.
> 
> That said, the expectation
> 
>     KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);
> 
> would translate to the expectation
> 
>     KUNIT_EXPECT_MEMEQ(test, foo, bar, size);
> 
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> v1 -> v2:
> - Change "determinated" to "specified" (Daniel Latypov).
> - Change the macro KUNIT_EXPECT_ARREQ to KUNIT_EXPECT_MEMEQ, in order to make
> it easier for users to infer the right size unit (Daniel Latypov).
> - Mark the different bytes on the failure message with a <> (Daniel Latypov).
> 
> v2 -> v3:
> - Make the bytes aligned at output.
> - Add KUNIT_SUBSUBTEST_INDENT to the output for the indentation (Daniel Latypov).
> - Line up the trailing \ at macros using tabs (Daniel Latypov).
> - Line up the params to the functions (Daniel Latypov).
> ---
>  include/kunit/assert.h | 34 +++++++++++++++++++
>  include/kunit/test.h   | 76 ++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/assert.c     | 56 +++++++++++++++++++++++++++++++
>  3 files changed, 166 insertions(+)
> 
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 4b52e12c2ae8..4b817a8eb619 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -256,4 +256,38 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
> 				    const struct va_format *message,
> 				    struct string_stream *stream);
> 
> +#define KUNIT_INIT_MEM_ASSERT_STRUCT(text_, left_val, right_val, size_)   \
> +	{                                                                 \
> +		.assert = { .format = kunit_mem_assert_format },          \
> +		.text = text_,                                            \
> +		.left_value = left_val,                                   \
> +		.right_value = right_val, .size = size_,                  \
> +	}
> +
> +/**
> + * struct kunit_mem_assert - An expectation/assertion that compares two
> + *	memory blocks.
> + * @assert: The parent of this type.
> + * @text: Holds the textual representations of the operands and comparator.
> + * @left_value: The actual evaluated value of the expression in the left slot.
> + * @right_value: The actual evaluated value of the expression in the right slot.
> + * @size: Size of the memory block analysed in bytes.
> + *
> + * Represents an expectation/assertion that compares two memory blocks. For
> + * example, to expect that the first three bytes of foo is equal to the
> + * first three bytes of bar, you can use the expectation
> + * KUNIT_EXPECT_MEMEQ(test, foo, bar, 3);
> + */
> +struct kunit_mem_assert {
> +	struct kunit_assert assert;
> +	const struct kunit_binary_assert_text *text;
> +	const void *left_value;
> +	const void *right_value;
> +	const size_t size;
> +};
> +
> +void kunit_mem_assert_format(const struct kunit_assert *assert,
> +			     const struct va_format *message,
> +			     struct string_stream *stream);
> +
>  #endif /*  _KUNIT_ASSERT_H */
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 8ffcd7de9607..02eeaff1c58e 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -684,6 +684,36 @@ do {									       \
> 			##__VA_ARGS__);					       \
>  } while (0)
> 
> +#define KUNIT_MEM_ASSERTION(test,					       \
> +			    assert_type,				       \
> +			    left,					       \
> +			    op,						       \
> +			    right,					       \
> +			    size,					       \
> +			    fmt,					       \
> +			    ...)					       \
> +do {									       \
> +	const void *__left = (left);					       \
> +	const void *__right = (right);					       \
> +	const size_t __size = (size);					       \
> +	static const struct kunit_binary_assert_text __text = {		       \
> +		.operation = #op,					       \
> +		.left_text = #left,					       \
> +		.right_text = #right,					       \
> +	};								       \
> +									       \
> +	KUNIT_ASSERTION(test,						       \
> +			assert_type,					       \
> +			memcmp(__left, __right, __size) op 0,		       \
> +			kunit_mem_assert,				       \
> +			KUNIT_INIT_MEM_ASSERT_STRUCT(&__text,		       \
> +						     __left,		       \
> +						     __right,		       \
> +						     __size),		       \
> +			fmt,						       \
> +			##__VA_ARGS__);					       \
> +} while (0)
> +
>  #define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
> 						assert_type,		       \
> 						ptr,			       \
> @@ -952,6 +982,52 @@ do {									       \
> 				   fmt,					       \
> 				   ##__VA_ARGS__)
> 
> +/**
> + * KUNIT_EXPECT_MEMEQ() - Expects that the first @size bytes of @left and @right are equal.
> + * @test: The test context object.
> + * @left: An arbitrary expression that evaluates to the specified size.
> + * @right: An arbitrary expression that evaluates to the specified size.
> + * @size: Number of bytes compared.
> + *
> + * Sets an expectation that the values that @left and @right evaluate to are
> + * equal. This is semantically equivalent to
> + * KUNIT_EXPECT_TRUE(@test, !memcmp((@left), (@right), (@size))). See
> + * KUNIT_EXPECT_TRUE() for more information.
> + */
> +#define KUNIT_EXPECT_MEMEQ(test, left, right, size) \
> +	KUNIT_EXPECT_MEMEQ_MSG(test, left, right, size, NULL)
> +
> +#define KUNIT_EXPECT_MEMEQ_MSG(test, left, right, size, fmt, ...)	       \
> +	KUNIT_MEM_ASSERTION(test,					       \
> +			    KUNIT_EXPECTATION,				       \
> +			    left, ==, right,				       \
> +			    size,					       \
> +			    fmt,					       \
> +			    ##__VA_ARGS__)
> +
> +/**
> + * KUNIT_EXPECT_MEMNEQ() - Expects that the first @size bytes of @left and @right are not equal.
> + * @test: The test context object.
> + * @left: An arbitrary expression that evaluates to the specified size.
> + * @right: An arbitrary expression that evaluates to the specified size.
> + * @size: Number of bytes compared.
> + *
> + * Sets an expectation that the values that @left and @right evaluate to are
> + * not equal. This is semantically equivalent to
> + * KUNIT_EXPECT_TRUE(@test, memcmp((@left), (@right), (@size))). See
> + * KUNIT_EXPECT_TRUE() for more information.
> + */
> +#define KUNIT_EXPECT_MEMNEQ(test, left, right, size) \
> +	KUNIT_EXPECT_MEMNEQ_MSG(test, left, right, size, NULL)
> +
> +#define KUNIT_EXPECT_MEMNEQ_MSG(test, left, right, size, fmt, ...)	       \
> +	KUNIT_MEM_ASSERTION(test,					       \
> +			    KUNIT_EXPECTATION,				       \
> +			    left, !=, right,				       \
> +			    size,					       \
> +			    fmt,					       \
> +			    ##__VA_ARGS__)
> +
>  /**
>   * KUNIT_EXPECT_NULL() - Expects that @ptr is null.
>   * @test: The test context object.
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index d00d6d181ee8..c346a8d7fa6e 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -204,3 +204,59 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
> 	kunit_assert_print_msg(message, stream);
>  }
>  EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
> +
> +/* Adds a hexdump of a buffer to a string_stream comparing it with
> + * a second buffer. The different bytes are marked with <>.
> + */
> +static void kunit_assert_hexdump(struct string_stream *stream,
> +				 const void *buf,
> +				 const void *compared_buf,
> +				 const size_t len)
> +{
> +	size_t i;
> +	const u8 *buf1 = buf;
> +	const u8 *buf2 = compared_buf;
> +
> +	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT);
> +
> +	for (i = 0; i < len; ++i) {
> +		if (!(i % 16) && i)
> +			string_stream_add(stream, "\n" KUNIT_SUBSUBTEST_INDENT);
> +
> +		if (buf1[i] != buf2[i])
> +			string_stream_add(stream, "<%02x>", buf1[i]);
> +		else
> +			string_stream_add(stream, " %02x ", buf1[i]);
> +	}
> +}
> +
> +void kunit_mem_assert_format(const struct kunit_assert *assert,
> +			     const struct va_format *message,
> +			     struct string_stream *stream)
> +{
> +	struct kunit_mem_assert *mem_assert;
> +
> +	mem_assert = container_of(assert, struct kunit_mem_assert,
> +				  assert);
> +
> +	string_stream_add(stream,
> +			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
> +			  mem_assert->text->left_text,
> +			  mem_assert->text->operation,
> +			  mem_assert->text->right_text);
> +
> +	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
> +			  mem_assert->text->left_text);
> +	kunit_assert_hexdump(stream, mem_assert->left_value,
> +			     mem_assert->right_value, mem_assert->size);
> +
> +	string_stream_add(stream, "\n");
> +
> +	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
> +			  mem_assert->text->right_text);
> +	kunit_assert_hexdump(stream, mem_assert->right_value,
> +			     mem_assert->left_value, mem_assert->size);
> +
> +	kunit_assert_print_msg(message, stream);
> +}
> +EXPORT_SYMBOL_GPL(kunit_mem_assert_format);
> --
> 2.37.1
> 

-- 
Muhammad Usama Anjum
