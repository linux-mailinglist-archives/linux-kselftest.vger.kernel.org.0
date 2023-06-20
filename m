Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD9C7366F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 11:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjFTJHs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 05:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjFTJHr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 05:07:47 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68588B9;
        Tue, 20 Jun 2023 02:07:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 2adb3069b0e04-4f955def3a5so59551e87.0;
        Tue, 20 Jun 2023 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687252062; x=1689844062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGS7NeM6a0TRa9MgngivWkVQd9RoCsbI/u1bjUhzsAY=;
        b=Z3A5SgoMsZZI/IOZKA0EJeuqa+VEjhwotQ6RMv+8YdadbUAbhwEbX+cslIcrrfurEe
         84NkEhfl3GT7GYhMBK4iAMwWuOvJWB6vAr8F/7kKzcFLKIxY0gFdYs8I/JTthK2UlMik
         VTxrLLOPTBwfa4VNSCsLeTDHN0qRaetCLgB/hN+kjb6rYJSNK9ill+xSeqhhCxYWGiax
         zK8iU553FUZ0bsTMFmFwzf/Xx+YppsR7Ft8Qls+O5e/r7TLlMcWGgkNPC/xVVRqWoVi6
         EEU21cIwjJi2reiJ/9xM0iuJV04NxmInvnNGxORDoMCz8X7/57sK6dCww1+IV59eCwVg
         uiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687252062; x=1689844062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGS7NeM6a0TRa9MgngivWkVQd9RoCsbI/u1bjUhzsAY=;
        b=Wuyh656WFr3ZxERwG56Plxp7D2B0B9bGlatRiLR3SmIcF66gJFMyYsk3LIUG2LLTsu
         SiSVu/FOpK814OXaSjjfBxVdBYz4vWTawzuBXAxiWlpvevHP0FrQTvki6ZWJQhQoOCrQ
         QrIZBvo2DGCXsLpBQltT3asOmm21KFz3WGjyjUYVk3Uory0Suqg4LhfkLYQu8pqzxwjt
         OUn2ujTCrHP57KbV4e+/Abm4c6GFfPlv47jAWngvroJZU7mo74NPvYiRcz0o41bakRrY
         vHZBfZQzV1MHnT6QAxllslL0691sQvsv3LFGwZ4Zd1mOYOo90tS8hPEvAUtOVA8+d4Tv
         stAQ==
X-Gm-Message-State: AC+VfDz6Bj4FOXqjYWCn2IxMVaWXsEuFliyeSKmwxUklAXmK0lBo7iHK
        A6+8UaHKrcyIx/lADVx/zR23EO7Ut8bemZw3LA==
X-Google-Smtp-Source: ACHHUZ5vfpktClWHjrxt+djdq7PbNWMenSFwb/G6DRupMMWPlnOXD6+NIv1/HNuBKBIZzb9xYHQfHVYTcKailZ9Bbb8=
X-Received: by 2002:a19:7719:0:b0:4f3:ac64:84f5 with SMTP id
 s25-20020a197719000000b004f3ac6484f5mr5962706lfc.36.1687252061967; Tue, 20
 Jun 2023 02:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230609030302.1278716-1-sunliming@kylinos.cn>
 <20230609030302.1278716-2-sunliming@kylinos.cn> <20230616160845.GA88@W11-BEAU-MD.localdomain>
 <CAJncD7Sfasoe4-hKZP4c3bPZ892S2Kk5JaMo-aca6eBDwLjLNQ@mail.gmail.com> <20230619184044.GA88@W11-BEAU-MD.localdomain>
In-Reply-To: <20230619184044.GA88@W11-BEAU-MD.localdomain>
From:   sunliming <kelulanainsley@gmail.com>
Date:   Tue, 20 Jun 2023 17:07:30 +0800
Message-ID: <CAJncD7SSAcHpSA5tVHCahg=m6dFb0EzERardWk6diUa52npq7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tracing/user_events: Fix incorrect return value
 for writing operation when events are disabled
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Beau Belgrave <beaub@linux.microsoft.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=882=
0=E6=97=A5=E5=91=A8=E4=BA=8C 02:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jun 19, 2023 at 04:51:56PM +0800, sunliming wrote:
> > Beau Belgrave <beaub@linux.microsoft.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=
=8817=E6=97=A5=E5=91=A8=E5=85=AD 00:08=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Jun 09, 2023 at 11:03:00AM +0800, sunliming wrote:
> > > > The writing operation return the count of writes whether events are
> > > > enabled or disabled. This is incorrect when events are disabled. Fi=
x
> > > > this by just return -ENOENT when events are disabled.
> > > >
> > >
> > > When testing this patch locally I found that we would occasionally ge=
t
> > > -ENOENT when events were enabled, but then become disabled, since wri=
tes
> > > do not have any locking around the tracepoint checks for performance
> > > reasons.
> > >
> > > I've asked a few peers of mine their thoughts on this, whether an err=
or
> > > should result when there are no enabled events. The consensus I've he=
ard
> > > back is that they would not consider this case an actual error, just =
as
> > > writing to /dev/null does not actually return an error.
> > >
> > > However, if you feel strongly we need this and have a good use case, =
it
> > > seems better to enable this logic behind a flag instead of having it
> > > default based on my conversations with others.
> > >
> > > Thanks,
> > > -Beau
> >
> >
> >
> > There is indeed a problem. Once enabled, perform the write operation
> > immediately.
> >
>
> The immediate write does work, and gets put into a buffer. The ftrace
> and perf self tests do the above case. So, no worries at this point.
>
> > Now=EF=BC=8Cwhen the event is disabled, the trace record appears to be =
lost.
>
> I'm taking this to mean, if in between the time of the bit check and the
> actual write() /writev() syscall the event becomes disabled, the event
> won't write to the buffer. Yes, that is expected.
>
Yes , got it, thank you for your explanation.

> > In some situations
> > where data timing is sensitive, it may cause confusion. In this case,
> > not returning an
> > error (as mentioned in your reply, it is not considered this case an
> > actual error) and
> > returning 0 ( meaning that the number of data to be written is 0) may
> > be a good way
> > to handle it?
>
> This is where I get a little lost. What would a user process do with a
> return of 0 bytes? It shouldn't retry, since it just hit that small
> timing window. In reality, it just incurred a temporary excessive
> syscall cost, but no real data loss (the operator/admin turned the event
> off).
>
> I'm missing why you feel it's important the user process know such a
> window was hit?
>
> Can you help me understand that?
>
I haven't encountered a specific scenario that it's important the user proc=
ess
know such a window was hit. This may be a mistake in my understanding.
When someone uses user events checking the output of an event to confirm
the execution status of a program, it may cause confusion if someone else
prohibits the event. This shouldn't be a serious issue, this patch just mak=
es
things look better.

Thanks,
-Sunliming

> I do think returning 0 bytes is better than an error here, but I'd
> really like to know why the user process wants to know at all. Maybe
> they have user-space only logging and want to be able to mark there if
> it's in both spots (kernel and user buffers)?
>
> Thanks,
> -Beau
>
> > Thanks,
> > -Sunliming
> >
> > >
> > > > Signed-off-by: sunliming <sunliming@kylinos.cn>
> > > > ---
> > > >  kernel/trace/trace_events_user.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_=
events_user.c
> > > > index 1ac5ba5685ed..92204bbe79da 100644
> > > > --- a/kernel/trace/trace_events_user.c
> > > > +++ b/kernel/trace/trace_events_user.c
> > > > @@ -1957,7 +1957,8 @@ static ssize_t user_events_write_core(struct =
file *file, struct iov_iter *i)
> > > >
> > > >               if (unlikely(faulted))
> > > >                       return -EFAULT;
> > > > -     }
> > > > +     } else
> > > > +             return -ENOENT;
> > > >
> > > >       return ret;
> > > >  }
> > > > --
> > > > 2.25.1
