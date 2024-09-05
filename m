Return-Path: <linux-kselftest+bounces-17294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A289C96E09A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B711F25514
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006E61A08A4;
	Thu,  5 Sep 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp03+FHu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0419DFB8;
	Thu,  5 Sep 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555492; cv=none; b=JDWHN1qs8LaisuaVCcKOtmZJzfjWGf7otxknD1ewM3ZtBJiB5ltJrfun773W5MFw9HwFjL1F8V9Ylcv+XumDVSloI+nzXosroQQWuFrzlx4cN2FrwrzVMC2jkfRTM6WXNgpTLh2QEFg5d6tCbQ2X6tfuwP4jFBiL3ldK5Ashdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555492; c=relaxed/simple;
	bh=5cOlrMSa4enwzy5kOehx/g0ttsB6VJcem7FdzSWWb/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeRGoZcMfEkWSenSh+zd+7PpTG43zw+Ndj5xdrMCMrkAVCUtrTTq6T7UGMIvHa/xxI0+LLmjSpts3SRD23k9JKjm4Jq+sKuqYVxeVTb/Trc7B/1UA3ZnFp2D8ovlqXIO137k9DSxxfyJ9l96JG2/ezlKoAQscenb6FIzytWJWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp03+FHu; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82a35ea3edaso46206939f.3;
        Thu, 05 Sep 2024 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725555489; x=1726160289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyD4e/E61RVOfeL0Lv733vcQsQrgYruyTC07VZWtD+A=;
        b=Cp03+FHuGl6rQU2Sb7LngBdEFBzDtSBNbFaIUtpYDurjZmVm46yDpM0D1tWJaKajR3
         i2N+QS+S/XahdNaz0BkcsyXUWZm9EfW3yAb4ukufO4oRt1BnQrEoH0Ctu7iss6rR9j0X
         PdQccr2KASHvO3dkAOkY9DMT1TTwmxW3CF4gcf/krSOCSGsiaw2VibCzCeQBGV6p4JsV
         CF4nm/3xrWNasfX8SSDEnoIrtaAeflpDpenvICqOUivad0SHeDOcgyE0qrroUpBOdzjs
         sQt4raR6z9KTi/JXREROmgwNUy5/KaabhTL7hQdGOFqKn3nOqOLYkBFSn+MfR5eYzib4
         HxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725555489; x=1726160289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyD4e/E61RVOfeL0Lv733vcQsQrgYruyTC07VZWtD+A=;
        b=Vcqorka9a3zv02Nd5XXXSY7OCYXpqv72QwGv5H+y4mhf80by9LJLnwO8frwbgm2Iit
         F+LFRYgH1eSfuUphCwxREDKMqx7zykw2PskQJaTVROoiMwaUmkM0QhFMRrq7Ceie3naL
         m9omuNL5wc0DFIGsW0n8gIpT9/kE1UCnuMbnL8NezvtA92qztglC6XEuzgZFKB6XViFd
         6wie6+BjTmingDRp+5j18s35PLGHqXIOsfFIEMJdPg5GlsyyQXDumhphsjoMMq6YobzM
         l2902eVD8VGIwv3tScpvYknA3gwWE5wombWytzrsE4Loqf6RuDvqCzWTrkmDp8ivWQfm
         0PYA==
X-Forwarded-Encrypted: i=1; AJvYcCU0VGTaqfsJNXuHxiqCD3eJxnrX3w2D//BFJs4EoiKvbdVQOVmxdEn2ToYtsEUPMgIRaxExSqZt@vger.kernel.org, AJvYcCWMctiG/6eKoPwKuOKGvCSLqhE4cISFkSSEAVTVOkav98ohRoqyUFNEbVtLT9tNoX4UJ9LGbf7QGJmgJhyUc9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzQ+AgmX81R6fu8oFE3PeBJrGmI4us4kzQWQVCa9pPhVSSvyDJ
	kqyM/eBk5LwWZz6X9THspWi2itMhrDyWbZRSbXFl5Utfu3N33a3kr6bSwU1eBJ6ufEcAKtgT5O+
	WIFaVbkRea8PB/vZY6kNSkMfDd0E=
X-Google-Smtp-Source: AGHT+IFJFzy1IMaAsy43PK9Ap21IqXuX/q5xZ8BQOx5wECbPsGCl0nphWIj3t6Iyfaly778yE3QWUbjkvCgK7uIMW38=
X-Received: by 2002:a05:6e02:20e6:b0:39d:1ca5:3904 with SMTP id
 e9e14a558f8ab-39f3793205dmr234164025ab.14.1725555489293; Thu, 05 Sep 2024
 09:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
 <20240905071738.3725-4-kerneljasonxing@gmail.com> <66d9b5db807aa_18ac2129468@willemb.c.googlers.com.notmuch>
 <CAL+tcoBPJCP1yUTCe3CLDjBR6rd2BphxTV0bPMdXhh7_CAfOtA@mail.gmail.com>
 <66d9c45f8b419_18de4129492@willemb.c.googlers.com.notmuch>
 <CAL+tcoDStC4c1XRT_xKgNJJxWC9-9zU=GEC1rbfHF7eWctQCVg@mail.gmail.com> <66d9df2c33de1_1eae1a294d6@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d9df2c33de1_1eae1a294d6@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 6 Sep 2024 00:57:33 +0800
Message-ID: <CAL+tcoC9_sCunEzM6sLqWkhuZETYmAYxPWY-utenbDCWoUe6vg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] net-timestamp: extend SOF_TIMESTAMPING_OPT_RX_FILTER
 for hardware use
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 12:41=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Thu, Sep 5, 2024 at 10:46=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Thu, Sep 5, 2024 at 9:45=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > In the previous patch, we found things could happen in the rx s=
oftware
> > > > > > timestamp. Here, we also noticed that, for rx hardware timestam=
p case,
> > > > > > it could happen when one process enables the rx hardware timest=
amp
> > > > > > generating flag first, then another process only setting
> > > > > > SOF_TIMESTAMPING_RAW_HARDWARE report flag can still get the har=
dware
> > > > > > timestamp.
> > > > > >
> > > > > > In this patch, we extend the OPT_RX_FILTER flag to filter out t=
he
> > > > > > above case for hardware use.
> > > > > >
> > > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > > Link: https://lore.kernel.org/all/20240903121940.6390b958@kerne=
l.org/
> > > > > > ---
> > > > > >  Documentation/networking/timestamping.rst | 15 +++++++++------
> > > > > >  net/core/sock.c                           |  5 +++--
> > > > > >  net/ipv4/tcp.c                            |  3 ++-
> > > > > >  net/socket.c                              |  3 ++-
> > > > > >  4 files changed, 16 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > diff --git a/Documentation/networking/timestamping.rst b/Docume=
ntation/networking/timestamping.rst
> > > > > > index ac57d9de2f11..55e79ea71f3e 100644
> > > > > > --- a/Documentation/networking/timestamping.rst
> > > > > > +++ b/Documentation/networking/timestamping.rst
> > > > > > @@ -268,12 +268,15 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
> > > > > >    each containing just one timestamp.
> > > > > >
> > > > > >  SOF_TIMESTAMPING_OPT_RX_FILTER:
> > > > > > -  Used in the receive software timestamp. Enabling the flag al=
ong with
> > > > > > -  SOF_TIMESTAMPING_SOFTWARE will not report the rx timestamp t=
o the
> > > > > > -  userspace so that it can filter out the case where one proce=
ss starts
> > > > > > -  first which turns on netstamp_needed_key through setting gen=
eration
> > > > > > -  flags like SOF_TIMESTAMPING_RX_SOFTWARE, then another one on=
ly passing
> > > > > > -  SOF_TIMESTAMPING_SOFTWARE report flag could also get the rx =
timestamp.
> > > > > > +  Used in the receive software/hardware timestamp. Enabling th=
e flag
> > > > > > +  along with SOF_TIMESTAMPING_SOFTWARE/SOF_TIMESTAMPING_RAW_HA=
RDWARE
> > > > > > +  will not report the rx timestamp to the userspace so that it=
 can
> > > > > > +  filter out the cases where 1) one process starts first which=
 turns
> > > > > > +  on netstamp_needed_key through setting generation flags like
> > > > > > +  SOF_TIMESTAMPING_RX_SOFTWARE, or 2) similarly one process en=
ables
> > > > > > +  generating the hardware timestamp already, then another one =
only
> > > > > > +  passing SOF_TIMESTAMPING_SOFTWARE report flag could also get=
 the
> > > > > > +  rx timestamp.
> > > > >
> > > > > I think this patch should be squashed into patch 1.
> > > > >
> > > > > Else SOF_TIMESTAMPING_OPT_RX_FILTER has two subtly different beha=
viors
> > > > > across its lifetime. Even if it is only two SHA1s apart.
> > > >
> > > > I thought about last night as well. Like the patch [2/4] and this
> > > > patch, the reason why I wanted to split is because I have to explai=
n a
> > > > lot for both hw and sw in one patch. One patch mixes different thin=
gs.
> > > >
> > > > No strong preference. If you still think so, I definitely can squas=
h
> > > > them as you said :)
> > >
> > > No strong preference on 2/4. See other reply.
> > >
> > > In this case, patch 1/4 introduces some behavior and 3/4 immediately
> > > updates it. I think it makes more sense to combine them.
> >
> > Roger that. Will squash this one:)
> >
> > >
> > > > >
> > > > > It also avoids such duplicate changes to the same code/text block=
s.
> > > > >
> > > > > More importantly, it matters for the behavior, see below.
> > > > >
> > > > > >
> > > > > >    SOF_TIMESTAMPING_OPT_RX_FILTER prevents the application from=
 being
> > > > > >    influenced by others and let the application choose whether =
to report
> > > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > > index 6a93344e21cf..dc4a43cfff59 100644
> > > > > > --- a/net/core/sock.c
> > > > > > +++ b/net/core/sock.c
> > > > > > @@ -908,8 +908,9 @@ int sock_set_timestamping(struct sock *sk, =
int optname,
> > > > > >           !(val & SOF_TIMESTAMPING_OPT_ID))
> > > > > >               return -EINVAL;
> > > > > >
> > > > > > -     if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
> > > > > > -         val & SOF_TIMESTAMPING_OPT_RX_FILTER)
> > > > > > +     if (val & SOF_TIMESTAMPING_OPT_RX_FILTER &&
> > > > > > +         (val & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > > > > +          val & SOF_TIMESTAMPING_RX_HARDWARE))
> > > > > >               return -EINVAL;
> > > > >
> > > > > There may be legitimate use cases of wanting to receive hardware
> > > > > receive timestamps, plus software transmit timestamp, but
> > > > > suppress spurious software timestamps (or vice versa):
> > > > >
> > > > >     SOF_TIMESTAMPING_RAW_HARDWARE | \
> > > > >     SOF_TIMESTAMPING_RX_HARDWARE | \
> > > > >     SOF_TIMESTAMPING_SOFTWARE | \
> > > > >     SOF_TIMESTAMPING_TX_SOFTWARE | \
> > > > >     SOF_TIMESTAMPING_OPT_RX_FILTER
> >
> > Sorry, I think my initial understanding at first read is not right. I
> > was thinking you want this combination to pass the check in
> > sock_set_timestamping().
> >
> > If the users insist on receiving "hardware receive timestamps" with
> > OPT_RX_FILTER enabled in this case, I think we should implement
> > another new flag, say, OPT_RX_HARDWARE_FILTER...
>
> My interpretation of the OPT_RX_FILTER flag is:
>
> Only return RX timestamps if the socket also has the corresponding
> reporting flag set.
>
> So it is valid to have
>
>   SOF_TIMESTAMPING_RAW_HARDWARE |
>   SOF_TIMESTAMPING_RX_HARDWARE |
>   SOF_TIMESTAMPING_SOFTWARE |
>   SOF_TIMESTAMPING_OPT_RX_FILTER
>
> To filter out the software rx timestamps, but let through the
> hardware rx timestamps.

I see. Thanks for your advice.

If both SOF_TIMESTAMPING_RX_SOFTWARE and
SOF_TIMESTAMPING_OPT_RX_FILTER are set at once, the latter will not
take any effect.

I will 1) completely remove the limitation in sock_set_timestamping(),
2) restore those simplification branches.

