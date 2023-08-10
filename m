Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0191C77845C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 01:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjHJXxf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 19:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjHJXxf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 19:53:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFB12D44
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 16:53:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso17245e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691711613; x=1692316413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LcZjEWwMjW14ZELW9BY/FR1fyGDBnsYDTfUbUBTAWA=;
        b=qNB+gL/2cvP4goqMU8TqAQeKuWf0r67BmiHH3pCvsawtk8MyagaUIHirFa1heUudc+
         Fw1Kdpr/eUZ5V6ll8TsFDMDOZ/W+eRbCzMCDVlicSukdc9lAmJZVBuk8NjgFJryj7wBR
         pfnn2OHhZAdxc7VRjGofnp1U7tRTvxZPune9nI1LOfjRUXdSj5LyM5J9ZbAn3DOnWkq8
         TacuGulhLMj8eBMfRoipSzSEr6lXzAcCe3XY7t9HgNgyT9KEUAUvZzEGJfiBZJHKsCkA
         pC9qUq2kOoJ3G3zIRy/fBUZpK2iLGS3dgZBsZqN+PnhQ2iuxbmsmJFzI+ZyVAds8VtYt
         K+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691711613; x=1692316413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LcZjEWwMjW14ZELW9BY/FR1fyGDBnsYDTfUbUBTAWA=;
        b=DAwN5IEQnl/iZpueuvQjxZZulMlrav9IFspRr7FtL3WIxchcdnNOFAtdH18NjvDwY/
         MyoRbgRuuWIWFBCw2JCgjy6/GHtOug+lyS7utwrmx5+C5LYITdYR/W/5Gu8Gz6l3WryL
         v8YDe0M7bKwes7U9i1o6yKF3fj9ZD2KicbA+vricLVUpsVkJIbPC7+o3HtNjU/laxDW5
         bv6ugFse6tt1/H3yUPxt4axULHIi+EePjuZfJQBSAcTqBYU1Ngog009IaOgVxU0Bpyn3
         Tgfm82+svVTj8uqpteuxqspbwONdHFR24Q4p17V0vFqwdD8ACcljwmhw2sCwvhccEjEX
         I9Jg==
X-Gm-Message-State: AOJu0Yx3pxlm8s3gtWt78e2IuWi8/HBjSqgwh6Xd3Rs1fuC/sXJHLWsn
        iTFGpaWoiAoXOC12AlAITDvyCQBvThGqcG4PqKDKSg==
X-Google-Smtp-Source: AGHT+IEiz7Dp8+W4vaThZwyvkdM9rOPk4cwGgq+Y7g7kpEL5D2iwE2i+LTIhts5BCKFnRZ9nXSD/p06b4OW1Bq8KFZA=
X-Received: by 2002:a05:600c:1d84:b0:3f1:73b8:b5fe with SMTP id
 p4-20020a05600c1d8400b003f173b8b5femr28240wms.3.1691711612982; Thu, 10 Aug
 2023 16:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230809155438.22470-1-rf@opensource.cirrus.com> <20230809155438.22470-8-rf@opensource.cirrus.com>
In-Reply-To: <20230809155438.22470-8-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 10 Aug 2023 18:53:20 -0500
Message-ID: <CA+GJov7DgJg=wd7xBHV-LkQDa=uM=v6cVTe8THjdcnfXs4Jitw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] kunit: Don't waste first attempt to format string
 in kunit_log_append()
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
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

On Wed, Aug 9, 2023 at 10:54=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> It's wasteful to call vsnprintf() only to figure out the length of the
> string. The string might fit in the available buffer space but we have to
> vsnprintf() again to do that.
>
> Instead, attempt to format the string to the available buffer at the same
> time as finding the string length. Only if the string didn't fit the
> available space is it necessary to extend the log and format the string
> again to a new fragment buffer.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Hello!

I find this version slightly more confusing but I realize that the
extra vsnprintf() call is unnecessary. So I am ok with this version
except for one question below.

I am curious what David Gow thinks and it would also be good to have
another set of eyes here.

My testing of this showed no problems.

Thanks!
-Rae

> ---
>  lib/kunit/test.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 28d0048d6171..230ec5e9824f 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -196,11 +196,21 @@ void kunit_log_append(struct list_head *log, const =
char *fmt, ...)
>         if (!log)
>                 return;
>
> -       /* Evaluate length of line to add to log */
> +       frag =3D list_last_entry(log, struct kunit_log_frag, list);
> +       log_len =3D strlen(frag->buf);
> +       len_left =3D sizeof(frag->buf) - log_len - 1;
> +
> +       /* Attempt to print formatted line to current fragment */
>         va_start(args, fmt);
> -       len =3D vsnprintf(NULL, 0, fmt, args) + 1;
> +       len =3D vsnprintf(frag->buf + log_len, len_left, fmt, args) + 1;
>         va_end(args);
>
> +       if (len <=3D len_left)
> +               goto out_newline;
> +
> +       /* Abandon the truncated result of vsnprintf */
> +       frag->buf[log_len] =3D '\0';
> +
>         if (len > sizeof(frag->buf) - 1) {
>                 va_start(args, fmt);
>                 tmp =3D kvasprintf(GFP_KERNEL, fmt, args);
> @@ -212,24 +222,15 @@ void kunit_log_append(struct list_head *log, const =
char *fmt, ...)
>                 return;
>         }
>
> -       frag =3D list_last_entry(log, struct kunit_log_frag, list);
> -       log_len =3D strlen(frag->buf);
> -       len_left =3D sizeof(frag->buf) - log_len - 1;
> -
> -       if (len > len_left) {
> -               frag =3D kunit_log_extend(log);
> -               if (!frag)
> -                       return;
> -
> -               len_left =3D sizeof(frag->buf) - 1;
> -               log_len =3D 0;
> -       }
> +       frag =3D kunit_log_extend(log);

Are we meant to be using the remainder of the last fragment to its
capacity or just start again with a new fragment and leave some of the
last fragment empty? I worry we abandoned using the last fragment or
is that the intention? Let me know if I understand this correctly.

> +       if (!frag)
> +               return;
>
>         /* Print formatted line to the log */
>         va_start(args, fmt);
> -       vsnprintf(frag->buf + log_len, min(len, len_left), fmt, args);
> +       vsnprintf(frag->buf, sizeof(frag->buf) - 1, fmt, args);
>         va_end(args);
> -
> +out_newline:
>         /* Add newline to end of log if not already present. */
>         kunit_log_newline(frag);
>  }
> --
> 2.30.2
>
