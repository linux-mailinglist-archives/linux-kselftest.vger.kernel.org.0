Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734FE72D98D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 07:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbjFMFwq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 01:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjFMFwp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 01:52:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1570493;
        Mon, 12 Jun 2023 22:52:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-3f736e0c9b1so53336605e9.3;
        Mon, 12 Jun 2023 22:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686635562; x=1689227562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnWtW/ElDXGPeeUTMVZo+NOre0OXSgOJd8mjZ41ZIeI=;
        b=iVi2RF7AC3GEQKcNXSzQ+N+muvrDe7wYIoGFL/z160heGt9CG9Mujh3JFiPan8LxmY
         wa/I9uplZsrhtfMcFTJkfM6ocy255EyPIkhPb7u99+dKNr1vQKPpWUP0oBxLJRi3Hmdw
         gBz4H6CdvufVa83zAP1AQQt8BWpndCf7yhN+AsSlMv2BbFzIuEpp4Yxiw+gmhIPq/cTC
         kVo8PCEPlRs/pC43r6l16r4YJshAyaZT+6S832TOSkxleY4PaaYJfjCambPWYv0HJVxm
         kFaeAF+Ud3gy2vvOPd+dxcbfGsC2ZdJ80jJGvPdbPv+92I5ecG/jYj6id+q2vNlM9gO1
         pwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686635562; x=1689227562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnWtW/ElDXGPeeUTMVZo+NOre0OXSgOJd8mjZ41ZIeI=;
        b=fhWDpdLbnMbrBMVMejOANn4hmRxn3XlkVjLPIRGwdMip+0YreaaWAAFLT6T69TOvtG
         +j9IufMjGE57fIoAb9WZMieDLTViulXoWslDU+l5mHTzaSlMmQYClbVKQyABl95nH348
         rCpMv1TQME9KICMFeKtkUvDDejzRNhF8R3oYyoQJcis1WGJkA0rJNUA5Y8ARimUfPrTq
         P0yQINSifZB+5eLBW7oBPIs0R/+givRDpM+FcrdWF64lfUuG5F6mOzI4Ux1TXe9HP91o
         ILVHNEassQWL8MMJJt9WZcRaA0mPl4gEe6EJKIEk+Qbhls2UojpjCwUgdgdilXEbFLeo
         amsw==
X-Gm-Message-State: AC+VfDzz46nFE8tufPvCgWStLWwCQPgy2O+cF/XgIaP0Hi1OPNoHpWTU
        p8XfrKMVC/iqLYly2eVn+8gk1aiXJBMiZ2h5CvUV0Pt8cG+F
X-Google-Smtp-Source: ACHHUZ6+/XQjuoc8EXTn9xMCJ1PWf+2WgnJCBw6vBI6595zL40SXJNM97U5eAvWmFnYNcuiq8fCe+syTMxNdTbHoX54=
X-Received: by 2002:a05:6000:1282:b0:30f:c6c3:e6d9 with SMTP id
 f2-20020a056000128200b0030fc6c3e6d9mr2941734wrx.46.1686635562254; Mon, 12 Jun
 2023 22:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230608011554.1181097-1-sunliming@kylinos.cn>
 <20230608011554.1181097-2-sunliming@kylinos.cn> <20230608171921.GA74@W11-BEAU-MD.localdomain>
In-Reply-To: <20230608171921.GA74@W11-BEAU-MD.localdomain>
From:   sunliming <kelulanainsley@gmail.com>
Date:   Tue, 13 Jun 2023 13:52:29 +0800
Message-ID: <CAJncD7QWnPbbZTUVbKF2F6cZ-X96djvoo=6rHg5yVzF-S-cMTw@mail.gmail.com>
Subject: Re: [PATCH 1/3] tracing/user_events: Fix incorrect return value for
 writing operation when events are disabled
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Beau Belgrave <beaub@linux.microsoft.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=94 01:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 08, 2023 at 09:15:52AM +0800, sunliming wrote:
> > The writing operation return the count of writes whether events are
> > enabled or disabled. This is incorrect when events are disabled. Fix
> > this by just return -EFAULT when events are disabled.
> >
> > Signed-off-by: sunliming <sunliming@kylinos.cn>
> > ---
> >  kernel/trace/trace_events_user.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_even=
ts_user.c
> > index 1ac5ba5685ed..970bac0503fd 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -1957,7 +1957,8 @@ static ssize_t user_events_write_core(struct file=
 *file, struct iov_iter *i)
> >
> >               if (unlikely(faulted))
> >                       return -EFAULT;
> > -     }
> > +     } else
> > +             return -EFAULT;
> >
>
> I'm not sure this is a good idea. Imagine this scenario:
> A user process writes out a user_event and it hits a fault that gets
> returned as errno (EFAULT).
>
> The user process is likely to either forget it and say, not worth
> retrying, or it will retry (potentially in a loop).
>
> If the process does retry and it's now disabled, it might try many
> times.
>
> I think that -ENOENT is a better error to use here. That way a user
> process will know it got disabled mid-write vs a fault that might want
> to be re-attempted.
>
> Thanks,
> -Beau
>
I think you are right. I have resend the V2 version of this series of
patches based on suggestions,
patches link :
https://lore.kernel.org/linux-trace-kernel/20230609030302.1278716-1-sunlimi=
ng@kylinos.cn/T/#t
Thanks.
> >       return ret;
> >  }
> > --
> > 2.25.1
