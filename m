Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DDE588020
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 18:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiHBQSQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 12:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiHBQSI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 12:18:08 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AC1D84;
        Tue,  2 Aug 2022 09:18:07 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Ly0XG5lCkzDqSk;
        Tue,  2 Aug 2022 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659457087; bh=PfiR7jLdYDVoXBOzYYraiTyBY6D2IUfGLPtZuLagOSs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kgpuzymPwDiXRj+iy+qgI4YFFadIdUz21FqrmnQqOjebtOz4D5dEBpwo2NWlJx4eF
         zbr9URqrVJ/M5z8gu/NaMs3uiJVEwFFgdvqVp54h/bonsT6i4Tx44bLqF0EJBZ3bMs
         wPmGZWpHm4iT8/rbVno4OEOPczD66D8LrNkas5Iw=
X-Riseup-User-ID: 2F6C0564F674F1D5BB00B7549818878FD5957A3C8B1332C30285BB795A04B226
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Ly0XB3ZDwz5vfs;
        Tue,  2 Aug 2022 16:18:02 +0000 (UTC)
Message-ID: <951b07d6-c4cb-0b15-aa16-9347a861d985@riseup.net>
Date:   Tue, 2 Aug 2022 13:17:59 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] kunit: Introduce KUNIT_EXPECT_ARREQ and
 KUNIT_EXPECT_ARRNEQ macros
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
Cc:     melissa.srw@gmail.com, jose.exposito89@gmail.com, kuba@kernel.org,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, airlied@linux.ie, davidgow@google.com,
        Brendan Higgins <brendanhiggins@google.com>,
        davem@davemloft.net, javierm@redhat.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, daniel@ffwll.ch
References: <20220802161206.228707-1-mairacanal@riseup.net>
 <20220802161206.228707-2-mairacanal@riseup.net>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>
In-Reply-To: <20220802161206.228707-2-mairacanal@riseup.net>
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

Hi Maíra,

Thanks for the patch!

Às 13:12 de 02/08/22, Maíra Canal escreveu:
> Currently, in order to compare arrays in KUnit, the KUNIT_EXPECT_EQ or
> KUNIT_EXPECT_FALSE macros are used in conjunction with the memcmp
> function, such as:
>     KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);
> 
> Although this usage produces correct results for the test cases, when
> the expectation fails, the error message is not very helpful,
> indicating only the return of the memcmp function.
> 
> Therefore, create a new set of macros KUNIT_EXPECT_ARREQ and
> KUNIT_EXPECT_ARRNEQ that compare memory blocks until a determined size.
> In case of expectation failure, those macros print the hex dump of the
> memory blocks, making it easier to debug test failures for arrays.
> 
> That said, the expectation
> 
>     KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);
> 
> would translate to the expectation
> 
>     KUNIT_EXPECT_ARREQ(test, foo, bar, size);
> 
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
> ---
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index d00d6d181ee8..0b537a8690e0 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -204,3 +204,46 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>  	kunit_assert_print_msg(message, stream);
>  }
>  EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
> +
> +/* Adds a hexdump of a buffer to a string_stream */
> +static void kunit_assert_hexdump(struct string_stream *stream,
> +		const void *buf, const size_t len)
> +{
> +	const u8 *ptr = buf;
> +	int i, linelen, remaining = len;
> +	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
> +
> +	for (i = 0; i < len; i += 16) {
> +		linelen = min(remaining, 16);
> +		remaining -= 16;
> +
> +		hex_dump_to_buffer(ptr + i, linelen, 16, 1, linebuf, sizeof(linebuf), false);
> +
> +		string_stream_add(stream, "%.8x: %s\n", i, linebuf);
> +	}
> +}
> +
> +void kunit_arr_assert_format(const struct kunit_assert *assert,
> +				    const struct va_format *message,
> +				    struct string_stream *stream)
> +{
> +	struct kunit_arr_assert *arr_assert;
> +
> +	arr_assert = container_of(assert, struct kunit_arr_assert,
> +				     assert);
> +
> +	string_stream_add(stream,
> +			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
> +			  arr_assert->text->left_text,
> +			  arr_assert->text->operation,
> +			  arr_assert->text->right_text);
> +
> +	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \n", arr_assert->text->left_text);
> +	kunit_assert_hexdump(stream, arr_assert->left_value, arr_assert->size);

I think using `:` instead of `==` gives a better output here

  [12:38:20] dst:
  [12:38:20] 00000000: 33 0a 60 12 00 a8 00 00 00 00 8e 6b 33 0a 60 12
  [12:38:20] 00000010: 00 00 00 00 00 a8 8e 6b 33 0a 00 00 00 00
  [12:38:20] result->expected:
  [12:38:20] 00000000: 31 0a 60 12 00 a8 00 00 00 00 81 6b 33 0a 60 12
  [12:38:20] 00000010: 00 00 00 00 01 a8 8e 6b 33 0a 00 00 00 00

> +
> +	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \n", arr_assert->text->right_text);
> +	kunit_assert_hexdump(stream, arr_assert->right_value, arr_assert->size);
> +
> +	kunit_assert_print_msg(message, stream);
> +}
> +EXPORT_SYMBOL_GPL(kunit_arr_assert_format);
