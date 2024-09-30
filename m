Return-Path: <linux-kselftest+bounces-18615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B7798A021
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 13:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D831C21744
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 11:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210BA18DF6B;
	Mon, 30 Sep 2024 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEjgyIlU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4218CBEE;
	Mon, 30 Sep 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727694906; cv=none; b=alo2ChV5x9sqSBPu7W3psr3v5f+TX3NeWgs62wnehK84E9TL3S/MjIAea6LX3snYh4oT8Q6ZVXiQRUMLDZs7phyK23v7fCnXgOLn64b1y1hHLtLsyny/rNQVBZzvOGI1zpX5M3r6dLieYsFrIwztBvMUQHI/+nLdpL/xYIJav7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727694906; c=relaxed/simple;
	bh=Fm/jwymiVG6aluV8SzUl+/aNXa6EyqXf4LxGaqQhncg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmD5bVojhTMkRZU8cBmfknmfek4ShkoIPV8OXBp6yshvPaXnOxAFMem75GTu64cHkZ92/3kGEpBadwpPdAtgtPqv+WxPUPuBsImBISZxcl+6kPhmuVdJgskETmgZkAS5eqnQQvXAVdez8elIX6FvkR4NIVfQ0DA5PIw/fEZ/TUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEjgyIlU; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-831e62bfa98so186169139f.1;
        Mon, 30 Sep 2024 04:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727694903; x=1728299703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvO1fI5LVfatVmb1BgSfqE/N8FdFcxW2MnpATHdB/KQ=;
        b=lEjgyIlU/4hriTv+B9rAMugsvcWjU9j177h/T+JDvCGoAcTsWxtiCCuJPLhMXrJnnR
         F9HAfEKE2cdZ9bzGCAhqzUjTTPJ6v2dIh5oL8bq+invgcDRBHtv4phWW21B3D8seuu03
         9yLvfNPLZhRSU7ubRimRu77hZI/FGhfNjADmm5i9AIIlYj9hCLsH7yDyJ8jvVmou+JIf
         SyDwlxCU4naZVZ3mUq6S64XXKdXS5rwmAtOmdP0iWyyLoahDxKdy7dh1NwxLHOfJTj4B
         /T/v0z00In9w0q0hub2266rql2Ps2+pMUnl54dvw0+t7pjju5xiDj3JYnFumX32kM9LW
         XHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727694903; x=1728299703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvO1fI5LVfatVmb1BgSfqE/N8FdFcxW2MnpATHdB/KQ=;
        b=TrdJN8o5KR+kCHodfRZRNfw3MKNb8vA88GiMsKutxKrYhSYl+uhvwXIryDb1XcSFxq
         /LPdAgCxGTpTa6dXwUgOodIudI9oqbm2tx9cnRsEzbmdFHe9jmskdtWHUBGoxSWXi54U
         xQ/d0u47gRw1b+R2+T/vuvtsZEpdX26rfs/GHr6h5tXTziebz67u8nN98GnVHM/WAqG3
         kXvuBpEqhnxOm1/B2Ex4DfmOumlmfRQDHB2dz9Ap9BzWLx/GV8SBP/IAcssrOho2ObUX
         e4joU7PMF+dlPtcQaxpPXi5dE3yMb5gNLcrJk8x5Hu7i54zl7R/Jfg/GIbNxy4cn8wUA
         xz7g==
X-Forwarded-Encrypted: i=1; AJvYcCVMURySGXXkjNg5RhfoKLwKqHWdTdcehaCkIbLEpeivE37PX9Ffgub+N8mww01ZKWPRWYncY01smRnqEqEhmuM=@vger.kernel.org, AJvYcCWb76iVggflBicuU8AeqVRvrHQdJVtgXDzJq6R9DKb8emzGgmO8d3/M3CtWa+JTdoxJoF3GSyIV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2FbepbBUq8xNAh7D54np9/tp11AnwsiqSlBlJPa27hOKABjyZ
	nqvlWA2uvmSV2R41kYJUepYxV8CMJs7DKi5fDu987GAQRs3oTYkXfILZcNkKZUe0pR5XPdl7F2E
	bybDnQ+1ryHdg2iNHBSZdVT0W9hxtQw==
X-Google-Smtp-Source: AGHT+IEuabbt3muDpmwV9fFuCqXP/WTomEA+OreuKtxeBBmDAMGZJc+XjTfeEZTflQ3zyGRYWVusUGIGy952ysoaf8E=
X-Received: by 2002:a92:ca47:0:b0:3a0:9050:702a with SMTP id
 e9e14a558f8ab-3a3451bc245mr81566185ab.17.1727694903537; Mon, 30 Sep 2024
 04:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-4-kerneljasonxing@gmail.com> <66fa81b2ddf10_17948d294bb@willemb.c.googlers.com.notmuch>
In-Reply-To: <66fa81b2ddf10_17948d294bb@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 30 Sep 2024 19:14:27 +0800
Message-ID: <CAL+tcoDo8-q_pkQBTSMM9v7ESZKO2v5aTK=W1mLxF3JJutBjYA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net-timestamp: namespacify the sysctl_tstamp_allow_data
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:47=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Let it be tuned in per netns by admins.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> +1 on the idea
>
> > ---
> >  include/net/netns/core.h   |  1 +
> >  include/net/sock.h         |  2 --
>
> also remove the static global from sock.c

Thanks for pointing this out.

>
> >  net/core/net_namespace.c   |  1 +
> >  net/core/skbuff.c          |  2 +-
> >  net/core/sysctl_net_core.c | 18 +++++++++---------
> >  5 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/net/netns/core.h b/include/net/netns/core.h
> > index 78214f1b43a2..ef8b3105c632 100644
> > --- a/include/net/netns/core.h
> > +++ b/include/net/netns/core.h
> > @@ -23,6 +23,7 @@ struct netns_core {
> >  #if IS_ENABLED(CONFIG_RPS) && IS_ENABLED(CONFIG_SYSCTL)
> >       struct cpumask *rps_default_mask;
> >  #endif
> > +     int     sysctl_tstamp_allow_data;
> >  };
> >
> >  #endif
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index c58ca8dd561b..4f31be0fd671 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2808,8 +2808,6 @@ void sk_get_meminfo(const struct sock *sk, u32 *m=
eminfo);
> >  extern __u32 sysctl_wmem_max;
> >  extern __u32 sysctl_rmem_max;
> >
> > -extern int sysctl_tstamp_allow_data;
> > -
> >  extern __u32 sysctl_wmem_default;
> >  extern __u32 sysctl_rmem_default;
> >
> > diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> > index e39479f1c9a4..e78c01912c64 100644
> > --- a/net/core/net_namespace.c
> > +++ b/net/core/net_namespace.c
> > @@ -317,6 +317,7 @@ static __net_init void preinit_net_sysctl(struct ne=
t *net)
> >        */
> >       net->core.sysctl_optmem_max =3D 128 * 1024;
> >       net->core.sysctl_txrehash =3D SOCK_TXREHASH_ENABLED;
> > +     net->core.sysctl_tstamp_allow_data =3D 1;
> >  }
> >
> >  /* init code that must occur even if setup_net() is not called. */
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 74149dc4ee31..ad727d924f73 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5506,7 +5506,7 @@ static bool skb_may_tx_timestamp(struct sock *sk,=
 bool tsonly)
> >  {
> >       bool ret;
> >
> > -     if (likely(READ_ONCE(sysctl_tstamp_allow_data) || tsonly))
> > +     if (likely(READ_ONCE(sock_net(sk)->core.sysctl_tstamp_allow_data)=
 || tsonly))
> >               return true;
>
> Let's switch order of the tests here too

Got it. Will do it.

Thanks,
Jason

