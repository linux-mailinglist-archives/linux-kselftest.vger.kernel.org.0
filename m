Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E943603A2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Oct 2022 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJSGyS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Oct 2022 02:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiJSGyP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Oct 2022 02:54:15 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0481274E3A
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Oct 2022 23:54:11 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id y129so7912647vkg.8
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Oct 2022 23:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exjhnc0jol93ehFZZIlNSZQ3bQ20N7dRysuGwRktYrg=;
        b=fcTEee2Ici1ziSJPjaymEHaWkZc1jnEPANWyeGJv/34YBlHDqghJ7ry2yYf6RmIm+s
         JT3fWqy6seczvnOYDCk6RCXXL6tPuK3RPJB8svYPM3wLCaj1PFnP+vUAkRLEEE/bSGNC
         DK644PYMNgi/fdpQu+2xP8UM5OTYWunZy+inDWe9o8iWoo2Oue2GHbcd4oBJ0LFOclSF
         goKJ7YqFnS+hmMDXjnAZOWGPmJlSXDnCjYwd/Q3PZ3DpqZsuJK10uXok5bG8q6U9PnJY
         x/MZJVTRPYOkO3wP7DMMtO6QfO/5aFXqPcTnSC6nFefzb7C8sPDZ8RuBw2Ax2uojtBhO
         ZI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exjhnc0jol93ehFZZIlNSZQ3bQ20N7dRysuGwRktYrg=;
        b=2PDUczx270sqwv93qPVYbUO19i8lyNYoK6XOrv7C38P1vEfMckCE3HevpHmd2yn+qJ
         aKAnepSTmEnWlmF2v2xCNqvN3nmCZeofxzkCDFaXI2811Yqm1NeLzhgw4T0gDrXKXg3y
         mc5wQKBNhqQG7VRAkQRQ1IqP8eWwgQAkjIdYEmCluVpyqm/RNuZbN6lTBNLnIm6XozCg
         K52FrJvU6TalkpwKXuXCJP2nOawIfLOesjI4RnuP7usP7Ou2+o0hOv4Sr7kq262UBdPE
         GaZhHMIBsmM4Yy+S1nb4drwihESdkKvl4Uf6miOEyHNkq7yqdgWCm/BOw8XhCGfUW5AC
         vzcA==
X-Gm-Message-State: ACrzQf0HWJGDrYiFxOoP2nbc4BljDKCbzW6mMO0f5BvYmUW6F9e3Wpfz
        mbCnCrsVAZyLUxjm1JJBBzwNQuj7zlQ3ySwmcQCEJA==
X-Google-Smtp-Source: AMsMyM77Sbgazl44qKdEIqQXFzOY0SYgE4PPyTtZgxTg9q+KyGWFZc5Z8H7haPb1IzfjG9R3QDT4cUFxcirLJknSjxE=
X-Received: by 2002:a1f:adca:0:b0:3ab:b862:2042 with SMTP id
 w193-20020a1fadca000000b003abb8622042mr3277841vke.37.1666162450560; Tue, 18
 Oct 2022 23:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221018190541.189780-1-mairacanal@riseup.net> <20221018190541.189780-2-mairacanal@riseup.net>
In-Reply-To: <20221018190541.189780-2-mairacanal@riseup.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Oct 2022 14:53:58 +0800
Message-ID: <CABVgOSkJJftfC_j7SX1YuvHR=mESCeZ5dSWV+Pvz2=irOgmXNw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] kunit: Introduce KUNIT_EXPECT_MEMEQ and
 KUNIT_EXPECT_MEMNEQ macros
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>, airlied@gmail.com,
        daniel@ffwll.ch, davem@davemloft.net, kuba@kernel.org,
        jose.exposito89@gmail.com, javierm@redhat.com,
        andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 19, 2022 at 3:06 AM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
>
> Currently, in order to compare memory blocks in KUnit, the KUNIT_EXPECT_E=
Q
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
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---

Thanks very much for rebasing this! I'm using it a bit in some tests
I'm working on, and it's been very useful!

One minor formatting nitpick below, otherwise we'll pull this into the
kunit branch as soon as possible.

And this is still
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/assert.h | 33 ++++++++++++++++
>  include/kunit/test.h   | 87 ++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/assert.c     | 56 +++++++++++++++++++++++++++
>  3 files changed, 176 insertions(+)
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index ace3de8d1ee7..fd59ac4a63b9 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -240,4 +240,37 @@ void kunit_binary_str_assert_format(const struct kun=
it_assert *assert,
>                                     const struct va_format *message,
>                                     struct string_stream *stream);
>
> +#define KUNIT_INIT_MEM_ASSERT_STRUCT(text_, left_val, right_val, size_) =
       \
> +       {                                                                =
      \
> +               .text =3D text_,                                         =
        \
> +               .left_value =3D left_val,                                =
        \
> +               .right_value =3D right_val, .size =3D size_,             =
          \

Nit: Could we have the style of this macro match the other
INIT_*_ASSERT_STRUCT() ones: in particular, having the open brace on
the first line, and the close brace non-indented. It'd also be nice to
have .size set on its own line, like the other struct members.


> +       }
> +
> +/**
> + * struct kunit_mem_assert - An expectation/assertion that compares two
> + *     memory blocks.
> + * @assert: The parent of this type.
> + * @text: Holds the textual representations of the operands and comparat=
or.
> + * @left_value: The actual evaluated value of the expression in the left=
 slot.
> + * @right_value: The actual evaluated value of the expression in the rig=
ht slot.
> + * @size: Size of the memory block analysed in bytes.
> + *
> + * Represents an expectation/assertion that compares two memory blocks. =
For
> + * example, to expect that the first three bytes of foo is equal to the
> + * first three bytes of bar, you can use the expectation
> + * KUNIT_EXPECT_MEMEQ(test, foo, bar, 3);
> + */
> +struct kunit_mem_assert {
> +       struct kunit_assert assert;
> +       const struct kunit_binary_assert_text *text;
> +       const void *left_value;
> +       const void *right_value;
> +       const size_t size;
> +};
> +
> +void kunit_mem_assert_format(const struct kunit_assert *assert,
> +                            const struct va_format *message,
> +                            struct string_stream *stream);
> +
>  #endif /*  _KUNIT_ASSERT_H */
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b1ab6b32216d..cde97dc4eed5 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -658,6 +658,39 @@ do {                                                =
                              \
>                       ##__VA_ARGS__);                                    =
      \
>  } while (0)
>
> +#define KUNIT_MEM_ASSERTION(test,                                       =
      \
> +                           assert_type,                                 =
      \
> +                           left,                                        =
      \
> +                           op,                                          =
      \
> +                           right,                                       =
      \
> +                           size,                                        =
      \
> +                           fmt,                                         =
      \
> +                           ...)                                         =
      \
> +do {                                                                    =
      \
> +       const void *__left =3D (left);                                   =
        \
> +       const void *__right =3D (right);                                 =
        \
> +       const size_t __size =3D (size);                                  =
        \
> +       static const struct kunit_binary_assert_text __text =3D {        =
        \
> +               .operation =3D #op,                                      =
        \
> +               .left_text =3D #left,                                    =
        \
> +               .right_text =3D #right,                                  =
        \
> +       };                                                               =
      \
> +                                                                        =
      \
> +       if (likely(memcmp(__left, __right, __size) op 0))                =
      \
> +               break;                                                   =
      \
> +                                                                        =
      \
> +       _KUNIT_FAILED(test,                                              =
      \
> +                     assert_type,                                       =
      \
> +                     kunit_mem_assert,                                  =
      \
> +                     kunit_mem_assert_format,                           =
      \
> +                     KUNIT_INIT_MEM_ASSERT_STRUCT(&__text,              =
      \
> +                                                  __left,               =
      \
> +                                                  __right,              =
      \
> +                                                  __size),              =
      \
> +                     fmt,                                               =
      \
> +                     ##__VA_ARGS__);                                    =
      \
> +} while (0)
> +
>  #define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                   =
      \
>                                                 assert_type,             =
      \
>                                                 ptr,                     =
      \
> @@ -928,6 +961,60 @@ do {                                                =
                              \
>                                    fmt,                                  =
      \
>                                    ##__VA_ARGS__)
>
> +/**
> + * KUNIT_EXPECT_MEMEQ() - Expects that the first @size bytes of @left an=
d @right are equal.
> + * @test: The test context object.
> + * @left: An arbitrary expression that evaluates to the specified size.
> + * @right: An arbitrary expression that evaluates to the specified size.
> + * @size: Number of bytes compared.
> + *
> + * Sets an expectation that the values that @left and @right evaluate to=
 are
> + * equal. This is semantically equivalent to
> + * KUNIT_EXPECT_TRUE(@test, !memcmp((@left), (@right), (@size))). See
> + * KUNIT_EXPECT_TRUE() for more information.
> + *
> + * Although this expectation works for any memory block, it is not recom=
mended
> + * for comparing more structured data, such as structs. This expectation=
 is
> + * recommended for comparing, for example, data arrays.
> + */
> +#define KUNIT_EXPECT_MEMEQ(test, left, right, size) \
> +       KUNIT_EXPECT_MEMEQ_MSG(test, left, right, size, NULL)
> +
> +#define KUNIT_EXPECT_MEMEQ_MSG(test, left, right, size, fmt, ...)       =
      \
> +       KUNIT_MEM_ASSERTION(test,                                        =
      \
> +                           KUNIT_EXPECTATION,                           =
      \
> +                           left, =3D=3D, right,                         =
          \
> +                           size,                                        =
      \
> +                           fmt,                                         =
      \
> +                           ##__VA_ARGS__)
> +
> +/**
> + * KUNIT_EXPECT_MEMNEQ() - Expects that the first @size bytes of @left a=
nd @right are not equal.
> + * @test: The test context object.
> + * @left: An arbitrary expression that evaluates to the specified size.
> + * @right: An arbitrary expression that evaluates to the specified size.
> + * @size: Number of bytes compared.
> + *
> + * Sets an expectation that the values that @left and @right evaluate to=
 are
> + * not equal. This is semantically equivalent to
> + * KUNIT_EXPECT_TRUE(@test, memcmp((@left), (@right), (@size))). See
> + * KUNIT_EXPECT_TRUE() for more information.
> + *
> + * Although this expectation works for any memory block, it is not recom=
mended
> + * for comparing more structured data, such as structs. This expectation=
 is
> + * recommended for comparing, for example, data arrays.
> + */
> +#define KUNIT_EXPECT_MEMNEQ(test, left, right, size) \
> +       KUNIT_EXPECT_MEMNEQ_MSG(test, left, right, size, NULL)
> +
> +#define KUNIT_EXPECT_MEMNEQ_MSG(test, left, right, size, fmt, ...)      =
      \
> +       KUNIT_MEM_ASSERTION(test,                                        =
      \
> +                           KUNIT_EXPECTATION,                           =
      \
> +                           left, !=3D, right,                           =
        \
> +                           size,                                        =
      \
> +                           fmt,                                         =
      \
> +                           ##__VA_ARGS__)
> +
>  /**
>   * KUNIT_EXPECT_NULL() - Expects that @ptr is null.
>   * @test: The test context object.
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index d00d6d181ee8..c346a8d7fa6e 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -204,3 +204,59 @@ void kunit_binary_str_assert_format(const struct kun=
it_assert *assert,
>         kunit_assert_print_msg(message, stream);
>  }
>  EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
> +
> +/* Adds a hexdump of a buffer to a string_stream comparing it with
> + * a second buffer. The different bytes are marked with <>.
> + */
> +static void kunit_assert_hexdump(struct string_stream *stream,
> +                                const void *buf,
> +                                const void *compared_buf,
> +                                const size_t len)
> +{
> +       size_t i;
> +       const u8 *buf1 =3D buf;
> +       const u8 *buf2 =3D compared_buf;
> +
> +       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT);
> +
> +       for (i =3D 0; i < len; ++i) {
> +               if (!(i % 16) && i)
> +                       string_stream_add(stream, "\n" KUNIT_SUBSUBTEST_I=
NDENT);
> +
> +               if (buf1[i] !=3D buf2[i])
> +                       string_stream_add(stream, "<%02x>", buf1[i]);
> +               else
> +                       string_stream_add(stream, " %02x ", buf1[i]);
> +       }
> +}
> +
> +void kunit_mem_assert_format(const struct kunit_assert *assert,
> +                            const struct va_format *message,
> +                            struct string_stream *stream)
> +{
> +       struct kunit_mem_assert *mem_assert;
> +
> +       mem_assert =3D container_of(assert, struct kunit_mem_assert,
> +                                 assert);
> +
> +       string_stream_add(stream,
> +                         KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n"=
,
> +                         mem_assert->text->left_text,
> +                         mem_assert->text->operation,
> +                         mem_assert->text->right_text);
> +
> +       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=3D\n",
> +                         mem_assert->text->left_text);
> +       kunit_assert_hexdump(stream, mem_assert->left_value,
> +                            mem_assert->right_value, mem_assert->size);
> +
> +       string_stream_add(stream, "\n");
> +
> +       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=3D\n",
> +                         mem_assert->text->right_text);
> +       kunit_assert_hexdump(stream, mem_assert->right_value,
> +                            mem_assert->left_value, mem_assert->size);
> +
> +       kunit_assert_print_msg(message, stream);
> +}
> +EXPORT_SYMBOL_GPL(kunit_mem_assert_format);
> --
> 2.37.3
>
