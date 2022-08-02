Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0925A58842E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 00:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbiHBWZI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 18:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiHBWZH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 18:25:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C90753D1A
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Aug 2022 15:25:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kb8so13773508ejc.4
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Aug 2022 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K9zCr1Ua5Z5qld+qZnE6ufAcMkPILK5j4hP/Kmv7z4Q=;
        b=fPeWFzpguMC2ok/r6m5/wFGNI4Vpwps2mjYbnuB72rg3CWEdNIanju6umfeRlVyIHj
         o53Z8VliqtA8T9G6X+DjIsaIXr+QtA/ZRgLs48fqtcySgf5BE5cV9FHYo73gX/N4PoL9
         DfmeZ/+cOAqleFYDQpG1Zwtenkbnum5NfzeyxEs+O0ZhUabRpVKkDB2BKkds3RPlVfEA
         ghZTxrgXhh6G9umrx1PBlSs3LrDlqtr51QEPXvoxhUSDUowltkXISgfkjZPLoNa06901
         Ns1yQxD6dwkcvCRnH8zWzMEcSuY5Ayf1gLS8ucp2y5i+eX6AeId2Ry8VVkfkoADGKEe3
         N0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K9zCr1Ua5Z5qld+qZnE6ufAcMkPILK5j4hP/Kmv7z4Q=;
        b=gYeL+PIIoL3VG0Q/7lvXnWkUojzYxerVjvyBqonya22b8BmbxYE4y04zJXIw6KN6ze
         s7M20OWk80NYooOHyFPDsydaj93pmvolpk9lDPI3UmokqnizWHCwZhCTzgSZ7tALnctK
         gbkoGWZpZK3t2lkRiOeYwLsLHd/+/NvvlIeVEc/Uyg83aWKJWbH3TK8KuDaL206BKWR+
         fQxtOPruR3qkVzqxj4InmHOeSpOZilOgT5umZOUMjNpb3msrT+yp2bvfu6UbiUjlbnfp
         44o1FuD8K25jv/imwlKWANJ1SB+0RNeRs5kgIJrkWAG+Wyb2v1VO6nWUZgtaM9wAuXhW
         2aGA==
X-Gm-Message-State: ACgBeo2+J35JTN/L43muIBvOB7TnmS0+cn36WIrx8yCCIdJJbQoIQY0J
        jGVS3cwkRVnZ6nIKLoXHr0OEsE+GR+fPwAdfGrYiFw==
X-Google-Smtp-Source: AA6agR7m/4yk72Yrra1mZ03lh/mGJ8i/zB89ellNcKdmgT0x1mIJ//kyaqU7IU0LpmUKUNhe5IiDLngr8Zk5BMlPqEE=
X-Received: by 2002:a17:907:7b89:b0:730:8649:983c with SMTP id
 ne9-20020a1709077b8900b007308649983cmr8717759ejc.542.1659479104597; Tue, 02
 Aug 2022 15:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220802212621.420840-1-mairacanal@riseup.net> <20220802212621.420840-2-mairacanal@riseup.net>
In-Reply-To: <20220802212621.420840-2-mairacanal@riseup.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 2 Aug 2022 15:24:53 -0700
Message-ID: <CAGS_qxq_meFFwLQV+_aEL+kr-q6x0WNeq7OS99bq_MyES5T98w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kunit: Introduce KUNIT_EXPECT_MEMEQ and
 KUNIT_EXPECT_MEMNEQ macros
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 2, 2022 at 2:26 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wro=
te:
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

Reviewed-by: Daniel Latypov <dlatypov@google.com>
Thanks, this is nice to have and I think the clarity issues have been resol=
ved.

Some various optional nits about whitespace below.
I'd see if anyone has any complaints about the output format before
wasting any time on those nits.

Looking at example output now, I see
    Expected array2 =3D=3D array1, but
        array2 =3D=3D
<1f> 00 00 00 ff 00 00 00
        array1 =3D=3D
<0f> 00 00 00 ff 00 00 00
    not ok 4 - example_all_expect_macros_test

Looks good to me.

> ---
> v1 -> v2:
> - Change "determinated" to "specified" (Daniel Latypov).
> - Change the macro KUNIT_EXPECT_ARREQ to KUNIT_EXPECT_MEMEQ, in order to =
make
> it easier for users to infer the right size unit (Daniel Latypov).
> - Mark the different bytes on the failure message with a <> (Daniel Latyp=
ov).
> ---
>  include/kunit/assert.h | 35 +++++++++++++++++++
>  include/kunit/test.h   | 76 ++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/assert.c     | 54 ++++++++++++++++++++++++++++++
>  3 files changed, 165 insertions(+)
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 4b52e12c2ae8..a54f5253b997 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -256,4 +256,39 @@ void kunit_binary_str_assert_format(const struct kun=
it_assert *assert,
>                                     const struct va_format *message,
>                                     struct string_stream *stream);
>
> +
> +#define KUNIT_INIT_MEM_ASSERT_STRUCT(text_, left_val, right_val, size_) =
\
> +       {                                                                =
 \
> +               .assert =3D { .format =3D kunit_mem_assert_format },   \
> +               .text =3D text_,                                         =
   \
> +               .left_value =3D left_val,                                =
   \
> +               .right_value =3D right_val, .size =3D size_,             =
     \
> +       }

very nit: the trailing \s aren't quite lined up.
In this particular case, I'm planning on deleting this block in the
future, so it doesn't matter too much.

> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 8ffcd7de9607..1925d648eec8 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -684,6 +684,36 @@ do {                                                =
                              \
>                         ##__VA_ARGS__);                                  =
      \
>  } while (0)
>
> +#define KUNIT_MEM_ASSERTION(test,                                     \

very nit: the trailing \s are also a bit out of line here.
We can fix this particular line by just adding another \t after "test,"

In general, lining these up is just a matter of adding a \t after the
text and then maybe add or delete some of the " "s before the \s.
E.g. with vim's `:set list`, after lining up the \s, I get

#define KUNIT_MEM_ASSERTION(test,^I^I^I^I^I       \$
^I^I^I^I   assert_type,^I^I^I^I       \$
^I^I^I^I   left,^I^I^I^I       \$
^I^I^I^I   op,^I^I^I^I^I       \$
^I^I^I^I   right,^I^I^I^I       \$
^I^I^I^I   size,^I^I                       \$
^I^I^I^I   fmt,^I^I^I^I^I       \$
^I^I^I^I   ...)^I^I^I^I^I       \$
do {^I^I^I^I^I^I^I^I^I       \$
^Iconst void *__left =3D (left);^I^I^I^I^I       \$
...

> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index d00d6d181ee8..abd434bc7ec6 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -204,3 +204,57 @@ void kunit_binary_str_assert_format(const struct kun=
it_assert *assert,
>         kunit_assert_print_msg(message, stream);
>  }
>  EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
> +
> +/* Adds a hexdump of a buffer to a string_stream comparing it with
> + * a second buffer. The different bytes are marked with <>.
> + */
> +static void kunit_assert_hexdump(struct string_stream *stream,
> +               const void *buf, const void *compared_buf, const size_t l=
en)
> +{
> +       size_t i;
> +       const u8 *buf1 =3D buf;
> +       const u8 *buf2 =3D compared_buf;
> +
> +       for (i =3D 0; i < len; ++i) {
> +               if (i % 16)
> +                       string_stream_add(stream, " ");
> +               else if (i)
> +                       string_stream_add(stream, "\n ");
> +
> +               if (buf1[i] !=3D buf2[i])
> +                       string_stream_add(stream, "<%02x>", buf1[i]);
> +               else
> +                       string_stream_add(stream, "%02x", buf1[i]);
> +       }
> +}
> +
> +void kunit_mem_assert_format(const struct kunit_assert *assert,
> +                                   const struct va_format *message,
> +                                   struct string_stream *stream)

very nit: the func above doesn't line up the params, but I don't think
it matters too much.
It uses \t\t whereas this one is \t\t\t + some spaces.

I think it'd be fine if they were consistent with each other, or if
you're willing to mess around with spaces, we could get the parameters
to line up.
(e.g. see how kunit_binary_ptr_assert_format and others do their line break=
s)
