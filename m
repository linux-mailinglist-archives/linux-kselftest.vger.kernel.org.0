Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC575881CF
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 20:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiHBSTy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiHBSTw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 14:19:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0FE32EE8
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Aug 2022 11:19:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kb8so12826347ejc.4
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Aug 2022 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Re8bYtKln7RC+3qj9zMUzi4ZgWsVQeLKoaiYEZ//j9Q=;
        b=gf/1Id31QC1xL+SdQIsEdIT5zddMbQ+zhJLZ22Y47Ekf0+tSX8U71TOrF95IxMhYDr
         n7Alol5UQEG7oKokijxJCf/jckmYReXPgfOR7Z8HgHzgu1ZyqFHAGSyuuvlE5mulKZXU
         KiJ3uG5kBXBpP5yx2ujYiZf4cJQ9gvDKDld4Pn5LT7CJoYJdH1OxhK2vTEkQSPkVr7lc
         KKVZV9hoMrsY0ueBPZoIEBEXKx/19wiz4/PD3bLV7lu4fWHQ2Ezg9+ZI+C1Lk9Bz8WmP
         Q/e4lFVtCBwZw9I5Lxv73MIs7g5l42Vx/FYyhLTUFIjZDd1j1cLRD7H+FKoVutIqWyzp
         7Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Re8bYtKln7RC+3qj9zMUzi4ZgWsVQeLKoaiYEZ//j9Q=;
        b=Pdn0u0HJyBXwHVgqtRTHa0bqYt03cWgbdmFkoWBAVPUJXTYW2vFemNxphKxJSNBDcx
         oJyHhvOoL+7aVmrIKRny2iXi1RUR4uAFGj9EUeHpp6eIXWcKIW1ASJ+Jb3rf5CweWl1B
         BsCtK3oeZZsuoDfqRU/dFVWfycARdRq6g2yxNFd/7cDghERNzEVdW5Om0KNwU+9Q0OB/
         Mr/wT+3PBPzYeVP8ymGKrOmQ/JjbHRi2DzKnw3U4Hl/9LVvPHrnRa1mwwCwVl12L1o4a
         bn2Sx6BLfcN9XK0isMvY+c888JzJbsba2G0yMHdKHf1jbTwOZR9tSU8b0iJch+4RWkk8
         +aDw==
X-Gm-Message-State: ACgBeo2zWeB4tfz1P/cOs763zUU0Flq0QowtzkR1apxHpBGz8Gk07y7J
        hm72Hp6vIh6MXg8nJb6f5oGYkDjgqcXhXnJTEp4/kA==
X-Google-Smtp-Source: AA6agR6cYB/NrmvHxrmGUiCflNUg0pKSfrhkxO7RlLqFU+bMDRJkrjlJ86SiWYkdjX47EddHdsfANMw6uW6AMOQnXys=
X-Received: by 2002:a17:907:3e21:b0:730:92bb:7fcd with SMTP id
 hp33-20020a1709073e2100b0073092bb7fcdmr7049686ejc.170.1659464387742; Tue, 02
 Aug 2022 11:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220802161206.228707-1-mairacanal@riseup.net> <20220802161206.228707-2-mairacanal@riseup.net>
In-Reply-To: <20220802161206.228707-2-mairacanal@riseup.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 2 Aug 2022 11:19:36 -0700
Message-ID: <CAGS_qxr28UB68fsaCpczA8pibsfNsNnvP+hRiudmMT-ZYWJw6g@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: Introduce KUNIT_EXPECT_ARREQ and
 KUNIT_EXPECT_ARRNEQ macros
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        airlied@linux.ie, daniel@ffwll.ch, davem@davemloft.net,
        kuba@kernel.org, jose.exposito89@gmail.com, javierm@redhat.com,
        andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

On Tue, Aug 2, 2022 at 9:12 AM Ma=C3=ADra Canal <mairacanal@riseup.net> wro=
te:
>
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
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  include/kunit/assert.h | 35 +++++++++++++++++++
>  include/kunit/test.h   | 76 ++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/assert.c     | 43 ++++++++++++++++++++++++
>  3 files changed, 154 insertions(+)
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 4b52e12c2ae8..b8fac8eec0af 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -256,4 +256,39 @@ void kunit_binary_str_assert_format(const struct kun=
it_assert *assert,
>                                     const struct va_format *message,
>                                     struct string_stream *stream);
>
> +
> +#define KUNIT_INIT_ARR_ASSERT_STRUCT(text_, left_val, right_val, size_) =
\
> +       {                                                                =
 \
> +               .assert =3D { .format =3D kunit_arr_assert_format },   \
> +               .text =3D text_,                                         =
   \
> +               .left_value =3D left_val,                                =
   \
> +               .right_value =3D right_val, .size =3D size_,             =
     \
> +       }

FYI, I have an RFC series out to simplify assertions a bit more.
https://lore.kernel.org/linux-kselftest/20220525154442.1438081-4-dlatypov@g=
oogle.com/
in particular eliminates these INIT_STRUCT macros.

That series would break the Rust for Linux one, so I've been waiting
to see how that plays out.
At this point, this series might go in before my RFC one, so I'll
likely rebase on top of yours.

But if not, I can provide a diff to help rebase this series on top of
mine at that time.

> +
> +/**
> + * struct kunit_arr_assert - An expectation/assertion that compares two
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
> + * KUNIT_EXPECT_ARREQ(test, foo, bar, 3);
> + */
> +struct kunit_arr_assert {
> +       struct kunit_assert assert;
> +       const struct kunit_binary_assert_text *text;
> +       const void *left_value;
> +       const void *right_value;
> +       const size_t size;
> +};
> +
> +void kunit_arr_assert_format(const struct kunit_assert *assert,
> +                                   const struct va_format *message,
> +                                   struct string_stream *stream);
> +
>  #endif /*  _KUNIT_ASSERT_H */
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 8ffcd7de9607..30547fc57c1e 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -684,6 +684,36 @@ do {                                                =
                              \
>                         ##__VA_ARGS__);                                  =
      \
>  } while (0)
>
> +#define KUNIT_ARRAY_ASSERTION(test,                                   \
> +                                  assert_type,                          =
      \
> +                                  left,                                 =
      \
> +                                  op,                                   =
      \
> +                                  right,                                =
      \
> +                                  size,                       \
> +                                  fmt,                                  =
      \
> +                                  ...)                                  =
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
> +       KUNIT_ASSERTION(test,                                            =
      \
> +                       assert_type,                                     =
      \
> +                       memcmp(__left, __right, __size) op 0,            =
              \
> +                       kunit_arr_assert,                              \
> +                       KUNIT_INIT_ARR_ASSERT_STRUCT(&__text,       \
> +                                                       __left,          =
      \
> +                                                       __right,         =
  \
> +                                                       __size),         =
      \
> +                       fmt,                                             =
      \
> +                       ##__VA_ARGS__);                                  =
      \
> +} while (0)
> +
>  #define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                   =
      \
>                                                 assert_type,             =
      \
>                                                 ptr,                     =
      \
> @@ -952,6 +982,52 @@ do {                                                =
                              \
>                                    fmt,                                  =
      \
>                                    ##__VA_ARGS__)
>
> +/**
> + * KUNIT_EXPECT_ARREQ() - Expects that the first @size bytes of @left an=
d @right are equal.
> + * @test: The test context object.
> + * @left: An arbitrary expression that evaluates to a determinated size.

nit: "determinated" isn't a word, though it would make sense as one.
Perhaps instead:
  to the specified size
  to the specified @size
  to a predetermined size

> + * @right: An arbitrary expression that evaluates to a determinated size=
.
> + * @size: Number of bytes compared.


As noted on patch 2/3, this is very subtle.
The fact it's in "bytes" and not "array elements" can mix people up
who would likely assume ARRAY_SIZE() would be appropriate.

Should we perhaps internally do
  size_bytes =3D (size) * sizeof((left)[0])
so users can just deal with # of array elements and not bytes?

> + *
> + * Sets an expectation that the values that @left and @right evaluate to=
 are
> + * equal. This is semantically equivalent to
> + * KUNIT_EXPECT_TRUE(@test, !memcmp((@left), (@right), (@size))). See
> + * KUNIT_EXPECT_TRUE() for more information.
> + */
> +#define KUNIT_EXPECT_ARREQ(test, left, right, size) \
> +       KUNIT_EXPECT_ARREQ_MSG(test, left, right, size, NULL)
> +
> +#define KUNIT_EXPECT_ARREQ_MSG(test, left, right, size, fmt, ...)       =
              \
> +       KUNIT_ARRAY_ASSERTION(test,                                    \
> +                                  KUNIT_EXPECTATION,                    =
      \
> +                                  left, =3D=3D, right,                  =
          \
> +                                  size,                       \
> +                                  fmt,                                  =
  \
> +                                  ##__VA_ARGS__)
> +
> +/**
> + * KUNIT_EXPECT_STRNEQ() - Expects that the first @size bytes of @left a=
nd @right are not equal.

nit: s/STR/ARR

> + * @test: The test context object.
> + * @left: An arbitrary expression that evaluates to a determinated size.
> + * @right: An arbitrary expression that evaluates to a determinated size=
.
> + * @size: Number of bytes compared.
> + *
> + * Sets an expectation that the values that @left and @right evaluate to=
 are
> + * not equal. This is semantically equivalent to
> + * KUNIT_EXPECT_TRUE(@test, memcmp((@left), (@right), (@size))). See
> + * KUNIT_EXPECT_TRUE() for more information.
> + */
> +#define KUNIT_EXPECT_ARRNEQ(test, left, right, size) \
> +       KUNIT_EXPECT_ARRNEQ_MSG(test, left, right, size, NULL)
> +
> +#define KUNIT_EXPECT_ARRNEQ_MSG(test, left, right, size, fmt, ...)      =
              \
> +       KUNIT_ARRAY_ASSERTION(test,                                    \
> +                                  KUNIT_EXPECTATION,                    =
      \
> +                                  left, !=3D, right,                    =
        \
> +                                  size,                       \
> +                                  fmt,                                  =
  \
> +                                  ##__VA_ARGS__)
> +
>  /**
>   * KUNIT_EXPECT_NULL() - Expects that @ptr is null.
>   * @test: The test context object.
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index d00d6d181ee8..0b537a8690e0 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -204,3 +204,46 @@ void kunit_binary_str_assert_format(const struct kun=
it_assert *assert,
>         kunit_assert_print_msg(message, stream);
>  }
>  EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
> +
> +/* Adds a hexdump of a buffer to a string_stream */
> +static void kunit_assert_hexdump(struct string_stream *stream,
> +               const void *buf, const size_t len)
> +{
> +       const u8 *ptr =3D buf;
> +       int i, linelen, remaining =3D len;
> +       unsigned char linebuf[32 * 3 + 2 + 32 + 1];
> +
> +       for (i =3D 0; i < len; i +=3D 16) {
> +               linelen =3D min(remaining, 16);
> +               remaining -=3D 16;
> +
> +               hex_dump_to_buffer(ptr + i, linelen, 16, 1, linebuf, size=
of(linebuf), false);
> +
> +               string_stream_add(stream, "%.8x: %s\n", i, linebuf);
> +       }
> +}

As noted on the cover letter, I think we probably want to have our
output make it easier to spot the differing bytes if possible.
It's sufficiently annoying that I hadn't bothered to do it, so perhaps
we can keep it simple like this for now and revisit it later.
