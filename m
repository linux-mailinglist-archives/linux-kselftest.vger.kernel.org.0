Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FD07783BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 00:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjHJWlu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 18:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHJWlu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 18:41:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EF4273D
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 15:41:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so12625e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691707307; x=1692312107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6HsG3TdTc3uIggYTt+QrxTqSYca2qRoq6w/qVYjf+Y=;
        b=rNJKqfKw6LNTRuuAjrZpZT9+NKLnqervN6pWlJxOaqsv7hISsBMN5ua/rlwKRZDiZ0
         9gEaKX3ZxyuydkALn99gKGqo6FxadmRSgok+OJNAtzRnmhK0bqC0TT3YfMbQspdk4J8M
         6y3Dgz1hf3/+rMgRE0VgCzH2Tj7KPl8MOSpsgVKsIyk9pXhi77wqfVQqHUZU1WP21wFC
         L6hEG/J1lU+Tlm8jCSgMOrX1ojFoiDM3wszbu5tcrTMRg4yEa6ksD6oRDTejBBn8ar01
         pMzrjpOMZZUHwnfkL7rVqhmwcs6PhY0Vy9B+TMBJQSVFFLcg6DIm9gZFLAth5x+aKw9u
         qrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691707307; x=1692312107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6HsG3TdTc3uIggYTt+QrxTqSYca2qRoq6w/qVYjf+Y=;
        b=baxdDRBmd7VEwtjZPTwNzc5EjHSibsvDDNb3ugzslrS/YyK94FI8dGjV36pC4Us5yE
         Z3g+pqJFSwzVcbjW1t7U2YcPW7p8sF8UaswuYLnYeO+NtTt997SIXcZqCKsBtQbTiJa7
         50lV+JjZioIRSkTISebzdMhVfE2iB9XhR+IuWFcdiUST4y3SsLfoP9kIYICSiI0XL30u
         TU9+4hSb+OGTS4Up6OgDy0um6lj5V9meXtGt8llUQzzn3lHlXP+pba6IfcvFZm1gszzB
         IqgzjyB/YS8x0Cen2CLWLGiXjGUaSTpzFYhyWnq0cfbKi7e/wSYynNWXmh3ft7NZlAPI
         vXRQ==
X-Gm-Message-State: AOJu0YwECctN1fD9qAZ/FTmFxNeWMT7mIJkFkgrxlUZh5GMiy5qnQyBP
        UQUZ1HeUBu3wFUKRegnVm4Tg5dG68TWnACpYWE+fuBCeBLczyGSiiJbdFg==
X-Google-Smtp-Source: AGHT+IExTEOMBN431S/Ioay1m5j1mSrH6pIAsQsFpz/rnkjODgeu3v6jZVYJ61uGLt8a2D2+YESaYTMLaioeWVJ6hT4=
X-Received: by 2002:a05:600c:1e23:b0:3f1:9a3d:4f7f with SMTP id
 ay35-20020a05600c1e2300b003f19a3d4f7fmr23322wmb.1.1691707307300; Thu, 10 Aug
 2023 15:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230809155438.22470-1-rf@opensource.cirrus.com>
 <20230809155438.22470-4-rf@opensource.cirrus.com> <CABVgOSn4PWT6+TobiJd+ppmPXsL+0qtLdazgjuQmfymUfkYhnA@mail.gmail.com>
In-Reply-To: <CABVgOSn4PWT6+TobiJd+ppmPXsL+0qtLdazgjuQmfymUfkYhnA@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 10 Aug 2023 17:41:34 -0500
Message-ID: <CA+GJov5Bc2=AWQcNGvq67Ft05OK3nd_ERac0xFS5adR2DScMGg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] kunit: Handle logging of lines longer than the
 fragment buffer size
To:     David Gow <davidgow@google.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
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

On Thu, Aug 10, 2023 at 9:38=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Wed, 9 Aug 2023 at 23:54, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
> >
> > Add handling to kunit_log_append() for log messages that are longer tha=
n
> > a single buffer fragment.
> >
> > The initial implementation of fragmented buffers did not change the log=
ic
> > of the original kunit_log_append(). A consequence was that it still had
> > the original assumption that a log line will fit into one buffer.
> >
> > This patch checks for log messages that are larger than one fragment
> > buffer. In that case, kvasprintf() is used to format it into a temporar=
y
> > buffer and that content is then split across as many fragments as
> > necessary.
> >
> > Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> > ---
>
> I think this looks good (and is a long-overdue addition to the logging
> functionality).
>
> One thought I have (and I'm kicking myself for not thinking of it
> earlier) is that this is starting to get very similar to the "string
> stream" functionality in lib/kunit/string-stream.{h,c}. Now, I
> actually think this implementation is much more efficient (using
> larger fragments, whereas the string stream uses variable-sized ones).
> Particularly since there are a lot of cases where string streams are
> created, converted to a string, and then logged, there's almost
> certainly a bunch of redundant work being done here.
>
> My gut feeling is that we should stick with this as-is, and maybe try
> to either work out some better integration between string streams and
> logging (to avoid that extra string allocation) or find some way of
> combining them.
>
> Regardless, this seems good as-is to me. There are some minor comments
> below, but nothing disastrous. I'll let Rae have a look over the
> various strscpy and strlcat calls, though, as while I did check them
> carefully (and KASAN hasn't complained), it's always best to have as
> many eyes on C string code as possible. :-)
>

Hello!

I have tested and taken a look at this and it looks overall good to
me. I think all of the string copying and concatenating is right.

Other than David's comments below, especially whether we should do
this with string-stream, I am pretty happy to accept this as is.

Thanks!
Rae

> But in my eyes, this is
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
> >  lib/kunit/test.c | 65 +++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 61 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index dfe51bc2b387..28d0048d6171 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -140,25 +140,82 @@ static struct kunit_log_frag *kunit_log_extend(st=
ruct list_head *log)
> >         return frag;
> >  }
> >
> > +static void kunit_log_append_string(struct list_head *log, const char =
*src)
> > +{
> > +       struct kunit_log_frag *frag, *new_frag;
> > +       int log_len, bytes_left;
> > +       ssize_t written;
> > +       char *p;
> > +
> > +       frag =3D list_last_entry(log, struct kunit_log_frag, list);
> > +       log_len =3D strlen(frag->buf);
> > +       bytes_left =3D sizeof(frag->buf) - log_len;
> > +
> > +       written =3D strscpy(frag->buf + log_len, src, bytes_left);
> > +       if (written !=3D -E2BIG)
> > +               goto newline;
> > +
> > +       src +=3D bytes_left - 1;
> > +       do {
> > +               new_frag =3D kunit_log_extend(log);
> > +               if (!new_frag)
> > +                       goto newline;
> > +
> > +               frag =3D new_frag;
> > +               written =3D strscpy(frag->buf, src, sizeof(frag->buf));
> > +               src +=3D sizeof(frag->buf) - 1;
> > +       } while (written =3D=3D -E2BIG);
> > +
> > +newline:
> > +       if (written =3D=3D -E2BIG)
>
> I think that this can only be true if kunit_log_extend() fails. If the
> do/while loop ends naturally, then written !=3D -E2BIG, as is the case
> with the strscpy goto above.
>
> Do you think it's cleaner to move the 'written =3D strlen(frag->buf)
> into the if (!new_frag) statement within the loop?
>
> > +               written =3D strlen(frag->buf);
> > +
> > +       p =3D &frag->buf[written - 1];
> > +       if (*p !=3D '\n') {
> > +               if (strlcat(frag->buf, "\n", sizeof(frag->buf)) >=3D si=
zeof(frag->buf)) {
> > +                       frag =3D kunit_log_extend(log);
> > +                       if (!frag) {
>
> A comment here could be useful. Something like "If we can't extend the
> log to add a newline, truncate the last message".
>
> > +                               *p =3D '\n';
> > +                               return;
> > +                       }
> > +
> > +                       frag->buf[0] =3D '\n';
> > +                       frag->buf[1] =3D '\0';
> > +               }
> > +       }
> > +}
> > +
> >  /* Append formatted message to log, extending the log buffer if necess=
ary. */
> >  void kunit_log_append(struct list_head *log, const char *fmt, ...)
> >  {
> >         va_list args;
> >         struct kunit_log_frag *frag;
> >         int len, log_len, len_left;
> > +       char *tmp =3D NULL;
> >
> >         if (!log)
> >                 return;
> >
> > -       frag =3D list_last_entry(log, struct kunit_log_frag, list);
> > -       log_len =3D strlen(frag->buf);
> > -       len_left =3D sizeof(frag->buf) - log_len - 1;
> > -
> >         /* Evaluate length of line to add to log */
> >         va_start(args, fmt);
> >         len =3D vsnprintf(NULL, 0, fmt, args) + 1;
> >         va_end(args);
> >
> > +       if (len > sizeof(frag->buf) - 1) {
> > +               va_start(args, fmt);
> > +               tmp =3D kvasprintf(GFP_KERNEL, fmt, args);
> > +               va_end(args);
> > +
>
> Should we handle the case where kvasprintf() fails here and drop the
> log message?
>
>
> > +               kunit_log_append_string(log, tmp);
> > +               kfree(tmp);
> > +
> > +               return;
> > +       }
> > +
> > +       frag =3D list_last_entry(log, struct kunit_log_frag, list);
> > +       log_len =3D strlen(frag->buf);
> > +       len_left =3D sizeof(frag->buf) - log_len - 1;
> > +
> >         if (len > len_left) {
> >                 frag =3D kunit_log_extend(log);
> >                 if (!frag)
> > --
> > 2.30.2
> >
