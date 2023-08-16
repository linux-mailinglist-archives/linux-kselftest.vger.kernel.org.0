Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD4477E9F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 21:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345888AbjHPTxo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 15:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345965AbjHPTxf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 15:53:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C93D1BE8
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 12:53:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so23555e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 12:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692215611; x=1692820411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjZcGXPnlXJEWm9BIa+f89XFEArucLUPHdSHGXk1d/w=;
        b=IyFxfLj7xDLudTw/xVRaJHcuzEOJb5kPTgLFVvnC9Far+IdxcKc5M+oXx/Ad5gyIpr
         TJgx2+zTNBZYpf7LhLLv+E4bHmqNM/LCgY7kchOwnxUxLbuNfh5Q7OIomzgIj/24Hjm3
         5CSwavPMENV81t3hQVeWqDenHc/WbgsjYnUKLknaHL/pvAHDk8Igqh3Yviq3xfUWeIla
         PlIYkk9Bn0FedKkiIBGOUum1R15D8eAXbU6iHeIa10lUp4Z29mDATXcKN89qDviaa6ow
         OXCWIXqOAql9+X/fmc/hThTF8fA4xSCJ/gjaCsxGFusCzZrUgXKBVfuYVOWeIuUUqj01
         31AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692215611; x=1692820411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjZcGXPnlXJEWm9BIa+f89XFEArucLUPHdSHGXk1d/w=;
        b=UUNw/69Q0iQ916uXogjawvAfp/S969mxSL8oZ8iRsei/lOlaYJKR0OTffRw7UVaVdf
         WpfHKkmPWExhKCvVJJAnQp6PzDcalZkop/uOFr+etp6pg8ugMx4kAbdcAJsbWQ8Oq6JY
         FuIfZr5nJP29CQPCbguObDWVlK/pqxGWHsGnXPeW1W3LSVl83xHUruQARntSPhMsrCCJ
         kWn/08vf9WxwKxuyy79UDd4Qe9yXXXANRSPEWDPuPJEVojLWHGcJxjCKHJomvFjzXZqB
         9Y9cpJb80k3HDg1AanlOpqCqQl68v5gntGrEsL0CnRoiZtaWnNXC2HD4KifV51euX5Z8
         V/TQ==
X-Gm-Message-State: AOJu0YyNo2JF/ftA9ahN3K31J/yxh2gwzz2z+1Dt4qJwxRs+SnVNy06W
        HFUj8sYu1XUgD5+gJ0zUdpGCpCE9G8B+tRwdd3f8SQ==
X-Google-Smtp-Source: AGHT+IH6EB6nefXDOnRa6XCL0NSsYy+0d2zddCdTBWkkLgFbZRz9HaMNDNtwUtcZ6VJLcq/wHec8IgljrY4b8f90mPQ=
X-Received: by 2002:a05:600c:4711:b0:3fe:5ec3:447f with SMTP id
 v17-20020a05600c471100b003fe5ec3447fmr2729wmo.1.1692215611484; Wed, 16 Aug
 2023 12:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com> <20230814132309.32641-5-rf@opensource.cirrus.com>
In-Reply-To: <20230814132309.32641-5-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 16 Aug 2023 15:53:19 -0400
Message-ID: <CA+GJov6kBuOKH1c9Vh7uwJqWicjwTe4FBBGbd7pbtrA-W25F9A@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] kunit: string-stream: Add option to make all
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 14, 2023 at 9:23=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add an optional feature to string_stream that will append a newline to
> any added string that does not already end with a newline. The purpose
> of this is so that string_stream can be used to collect log lines.
>
> This is enabled/disabled by calling string_stream_set_append_newlines().
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Hello!

I just wanted to look over handling the newline and this looks good to
me. I agree with David that I don't mind one extra allocated byte.

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
