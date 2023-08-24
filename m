Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AF6787BD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 01:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbjHXXOJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 19:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjHXXNf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 19:13:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94AA1BD8
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 16:13:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso15085e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 16:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692918811; x=1693523611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4cOoqot2PG/+7ie4WFX4qHem0rPJppcoToSeRWL29o=;
        b=5OBWXdNRGJSLIwOt/DmPFuHbvq/VIJ7FWTwbW/gA0iZs3cGlaz7fZDyZtHfIEmNUvK
         UekTzY+zu8LJ7w4OdhnNctrA4N1197F5Rs99ye1WbzU0FgLt/NgeUAy1siAzmPsJUEqN
         31zgPPp39nCWZlPO24PAB2RaIPPfFEY8z8YSwkvtJnfIw3Ed3NTaGSPd0Rz1qMrXLtS7
         UX9C99ea24XWAr32koXsef1yubk7C9Jcw0xzSyVO+xOWZ3oQFuy2bPUbhJqD65VWuakA
         zo88L0Tb8VkwLyuNOPu2vhPe/kDDYY3s4vaRWxc/aCWguaNieYwbAFqKAKTiRsR2WfHj
         kP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692918811; x=1693523611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4cOoqot2PG/+7ie4WFX4qHem0rPJppcoToSeRWL29o=;
        b=lX+zCUrhQZFhD930tvlEVc05hqw8e2HNCtDxiPx78F8qUEdRuTf4C1na/Jo8CfenNO
         rzEoW8PrcCmw6uX7Ij3o9uhnVE6W1nnQHssooifXZaKFp9EVQioQ9WBuQ9HEPgKEoUcL
         sH9B78T0Ep/NSAgWO7okIJkqr6jdoYSbvC81Wap4cPlYMLLFgDCtLCGYS3/JihgYErfy
         LT+GKgN9QW2XUDMWrq5GJ7hnihPmvdsFjCmER7U9ButQ1bb9ULqbTQjd8DmIqkcd5gEQ
         gr2WKAVhAAqNiqn3aMZJ/U9Ji84WZigNSFArwvwBuH4XsCXmbY1IL+0frhSSztfrCG/k
         dcCA==
X-Gm-Message-State: AOJu0Yx3ttNf+DstRATGoHZ25DK+gVgmm04div0Q1xktbr18NDLlA6Qn
        z42YUGr1358+/ZdfJci6p2Fp8/NMLoSNYw6epHXLRg==
X-Google-Smtp-Source: AGHT+IHyCKfSu9lpI0BCsLt9JtpdoXhU4zzYiPKZdLvtAWvY7nwXd0kgnvosd4pFoPZPN/e5278rZZR7Efj77a5zYWI=
X-Received: by 2002:a05:600c:891:b0:3fe:ef25:8b86 with SMTP id
 l17-20020a05600c089100b003feef258b86mr80548wmp.4.1692918811122; Thu, 24 Aug
 2023 16:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com> <20230824143129.1957914-4-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-4-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 24 Aug 2023 19:13:19 -0400
Message-ID: <CA+GJov6W8ui_fmgwqWOSe8wJRi3fj=Z3x7rU4MLTT4GVXe7+1g@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] kunit: string-stream: Add option to make all
 lines end with newline
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 24, 2023 at 10:32=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add an optional feature to string_stream that will append a newline to
> any added string that does not already end with a newline. The purpose
> of this is so that string_stream can be used to collect log lines.
>
> This is enabled/disabled by calling string_stream_set_append_newlines().
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Hello,

This again looks good to me!

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/string-stream.c | 28 +++++++++++++++++++++-------
>  lib/kunit/string-stream.h |  7 +++++++
>  2 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index ed24d86af9f5..1dcf6513b692 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -44,32 +44,46 @@ int string_stream_vadd(struct string_stream *stream,
>                        va_list args)
>  {
>         struct string_stream_fragment *frag_container;
> -       int len;
> +       int buf_len, result_len;
>         va_list args_for_counting;
>
>         /* Make a copy because `vsnprintf` could change it */
>         va_copy(args_for_counting, args);
>
>         /* Evaluate length of formatted string */
> -       len =3D vsnprintf(NULL, 0, fmt, args_for_counting);
> +       buf_len =3D vsnprintf(NULL, 0, fmt, args_for_counting);
>
>         va_end(args_for_counting);
>
> -       if (len =3D=3D 0)
> +       if (buf_len =3D=3D 0)
>                 return 0;
>
> +       /* Reserve one extra for possible appended newline. */
> +       if (stream->append_newlines)
> +               buf_len++;
> +
>         /* Need space for null byte. */
> -       len++;
> +       buf_len++;
>
>         frag_container =3D alloc_string_stream_fragment(stream->test,
> -                                                     len,
> +                                                     buf_len,
>                                                       stream->gfp);
>         if (IS_ERR(frag_container))
>                 return PTR_ERR(frag_container);
>
> -       len =3D vsnprintf(frag_container->fragment, len, fmt, args);
> +       if (stream->append_newlines) {
> +               /* Don't include reserved newline byte in writeable lengt=
h. */
> +               result_len =3D vsnprintf(frag_container->fragment, buf_le=
n - 1, fmt, args);
> +
> +               /* Append newline if necessary. */
> +               if (frag_container->fragment[result_len - 1] !=3D '\n')
> +                       result_len =3D strlcat(frag_container->fragment, =
"\n", buf_len);
> +       } else {
> +               result_len =3D vsnprintf(frag_container->fragment, buf_le=
n, fmt, args);
> +       }
> +
>         spin_lock(&stream->lock);
> -       stream->length +=3D len;
> +       stream->length +=3D result_len;
>         list_add_tail(&frag_container->node, &stream->fragments);
>         spin_unlock(&stream->lock);
>
> diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
> index b669f9a75a94..048930bf97f0 100644
> --- a/lib/kunit/string-stream.h
> +++ b/lib/kunit/string-stream.h
> @@ -25,6 +25,7 @@ struct string_stream {
>         spinlock_t lock;
>         struct kunit *test;
>         gfp_t gfp;
> +       bool append_newlines;
>  };
>
>  struct kunit;
> @@ -47,4 +48,10 @@ bool string_stream_is_empty(struct string_stream *stre=
am);
>
>  void string_stream_destroy(struct string_stream *stream);
>
> +static inline void string_stream_set_append_newlines(struct string_strea=
m *stream,
> +                                                    bool append_newlines=
)
> +{
> +       stream->append_newlines =3D append_newlines;
> +}
> +
>  #endif /* _KUNIT_STRING_STREAM_H */
> --
> 2.30.2
>
