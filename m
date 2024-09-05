Return-Path: <linux-kselftest+bounces-17244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C4496DC47
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA66028A019
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3867BB15;
	Thu,  5 Sep 2024 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2UWBN8+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B077E175A1;
	Thu,  5 Sep 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547620; cv=none; b=swAVQM6vHU3G1u3qrqIjFqPTF3+pIlULMuhV1fh9NJ5fQ2vPTREKw/wZ2vS7VLQC87Ttm6XXjZzvbGFwf283gchRJzswIp0R33jtwjhwZY7b3ughOx13Ls+Jx20bLdvv18qgcnKGfi7F53CpeCOsXOSu01vVc4joxg7uq9zKC/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547620; c=relaxed/simple;
	bh=pLSdSQ4gVo/mTWjxso8VjH8g1mc/d9Oj99Bg5bVrXqY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=m22+sVPB+eXN0acfeHPwr75KpFjjGY4rmbGp5XkE0h3qB/njYTkS2IIhJ+LhvtN2ZPYMHwstNwva7C4ALmVkcSMvHfl8perdv8ulMIZTY4sMAWfCokDaPJRfURYYzRTVKN/8Cl+qgeaUFQ/k1A9huornnqBe9boXpswttyflzYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2UWBN8+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c35b72f943so7910416d6.0;
        Thu, 05 Sep 2024 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725547616; x=1726152416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPFUE7dvbfF77LCBnGqPIs9yfaCYu6aE6rpzwn4hzXQ=;
        b=R2UWBN8+f86swXcKmjLoK2hKKZIUslDjc4U9n+P1u6kBoCUS+Sd+AQOMkq2irtbLUx
         LSlwjwiZCKAlWi1inGRVtfQhCgHAgFMmC/zzuM66set23l1BkFq9yrqzrEhDUrUi0myY
         eo15Df5gF7DRHVhc0qb8kd5mCJgOloU/ios9/Ypbp3NcEQxtykQRTY7aYXaZgefSCf1l
         EertAtvYCvQBfRgi7lBuxqjbVIIRMImAEnhmqRKLQ7zrYbq9WjFFCUDCTLXbUzk4QXSI
         IwZatJ2/58U+2+FdZkhOSNkHZzGWZfi149DG3xcltBDTMCxQPklZkzBpcdkG4KBD9zXz
         9dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547616; x=1726152416;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UPFUE7dvbfF77LCBnGqPIs9yfaCYu6aE6rpzwn4hzXQ=;
        b=u4WkobLwqknQirRGRPbKEtb56fzPbRsIQc23YLlKkiADObVB2CcMRiySnsGyMw/M9M
         PdsAGXSOCyNROctdQBndH8drE8MyVjzhr6Lrl4z8/YBzGXgBMZhNqZt3ZcNtk+kXAaKr
         3nybs9ZbTu4yhXi0dqt1RjuNQTd8FAXJRWTfgvdWnKyevDDY+VrlVVG037hw7kqrNbZG
         lh724+2nC+p+Gi+2S+mFcah+b2hdFh47N+/FzGFeZsHjiw1C2EheJhKe/rqC3xYvF9Fm
         hLoIAHElWuYG9CKcBdfzYlam4cF8qsGk6LUtTShpFsUTkCDTVgzrTMdZKw03cHuWog8s
         UdRg==
X-Forwarded-Encrypted: i=1; AJvYcCU15PZ0biq1x13SOkbchBYqKP4RuFeqxajbsuuj79ASsPS/qMJ6/6gtaPQvZlLm9nnHa0KO5s5GMORZokUT22c=@vger.kernel.org, AJvYcCX4YA51xZtUsdJGW8W6cQ+tm2GgPaVkMmcBcgzwi2OLJolmDq1A9N6H6NWv82zAfaUx8HDfTNo9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vCq8/Q6lyk+BnU+iunUYnnuB6lo3NCyM7hA9TC076j+rmBuV
	j5mnXMkwePZVTDaNlhKtyCcuigAtnHBAeKYFO61umYj4TNj8w5RGeW6yrQ==
X-Google-Smtp-Source: AGHT+IGA5f6ILZdwB/TYky0s/xg1evmm3bqGwzCoIQFGYD624aGUhG8vS9QUvwL0PpZ20JqWn8365A==
X-Received: by 2002:a05:6214:4585:b0:6c5:1f00:502f with SMTP id 6a1803df08f44-6c51f005481mr89338866d6.2.1725547616317;
        Thu, 05 Sep 2024 07:46:56 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201e42a5sm8092586d6.36.2024.09.05.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:46:55 -0700 (PDT)
Date: Thu, 05 Sep 2024 10:46:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66d9c45f8b419_18de4129492@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoBPJCP1yUTCe3CLDjBR6rd2BphxTV0bPMdXhh7_CAfOtA@mail.gmail.com>
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
 <20240905071738.3725-4-kerneljasonxing@gmail.com>
 <66d9b5db807aa_18ac2129468@willemb.c.googlers.com.notmuch>
 <CAL+tcoBPJCP1yUTCe3CLDjBR6rd2BphxTV0bPMdXhh7_CAfOtA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] net-timestamp: extend
 SOF_TIMESTAMPING_OPT_RX_FILTER for hardware use
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Thu, Sep 5, 2024 at 9:45=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > In the previous patch, we found things could happen in the rx softw=
are
> > > timestamp. Here, we also noticed that, for rx hardware timestamp ca=
se,
> > > it could happen when one process enables the rx hardware timestamp
> > > generating flag first, then another process only setting
> > > SOF_TIMESTAMPING_RAW_HARDWARE report flag can still get the hardwar=
e
> > > timestamp.
> > >
> > > In this patch, we extend the OPT_RX_FILTER flag to filter out the
> > > above case for hardware use.
> > >
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > Link: https://lore.kernel.org/all/20240903121940.6390b958@kernel.or=
g/
> > > ---
> > >  Documentation/networking/timestamping.rst | 15 +++++++++------
> > >  net/core/sock.c                           |  5 +++--
> > >  net/ipv4/tcp.c                            |  3 ++-
> > >  net/socket.c                              |  3 ++-
> > >  4 files changed, 16 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/Documentation/networking/timestamping.rst b/Documentat=
ion/networking/timestamping.rst
> > > index ac57d9de2f11..55e79ea71f3e 100644
> > > --- a/Documentation/networking/timestamping.rst
> > > +++ b/Documentation/networking/timestamping.rst
> > > @@ -268,12 +268,15 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
> > >    each containing just one timestamp.
> > >
> > >  SOF_TIMESTAMPING_OPT_RX_FILTER:
> > > -  Used in the receive software timestamp. Enabling the flag along =
with
> > > -  SOF_TIMESTAMPING_SOFTWARE will not report the rx timestamp to th=
e
> > > -  userspace so that it can filter out the case where one process s=
tarts
> > > -  first which turns on netstamp_needed_key through setting generat=
ion
> > > -  flags like SOF_TIMESTAMPING_RX_SOFTWARE, then another one only p=
assing
> > > -  SOF_TIMESTAMPING_SOFTWARE report flag could also get the rx time=
stamp.
> > > +  Used in the receive software/hardware timestamp. Enabling the fl=
ag
> > > +  along with SOF_TIMESTAMPING_SOFTWARE/SOF_TIMESTAMPING_RAW_HARDWA=
RE
> > > +  will not report the rx timestamp to the userspace so that it can=

> > > +  filter out the cases where 1) one process starts first which tur=
ns
> > > +  on netstamp_needed_key through setting generation flags like
> > > +  SOF_TIMESTAMPING_RX_SOFTWARE, or 2) similarly one process enable=
s
> > > +  generating the hardware timestamp already, then another one only=

> > > +  passing SOF_TIMESTAMPING_SOFTWARE report flag could also get the=

> > > +  rx timestamp.
> >
> > I think this patch should be squashed into patch 1.
> >
> > Else SOF_TIMESTAMPING_OPT_RX_FILTER has two subtly different behavior=
s
> > across its lifetime. Even if it is only two SHA1s apart.
> =

> I thought about last night as well. Like the patch [2/4] and this
> patch, the reason why I wanted to split is because I have to explain a
> lot for both hw and sw in one patch. One patch mixes different things.
> =

> No strong preference. If you still think so, I definitely can squash
> them as you said :)

No strong preference on 2/4. See other reply.

In this case, patch 1/4 introduces some behavior and 3/4 immediately
updates it. I think it makes more sense to combine them.

> >
> > It also avoids such duplicate changes to the same code/text blocks.
> >
> > More importantly, it matters for the behavior, see below.
> >
> > >
> > >    SOF_TIMESTAMPING_OPT_RX_FILTER prevents the application from bei=
ng
> > >    influenced by others and let the application choose whether to r=
eport
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 6a93344e21cf..dc4a43cfff59 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -908,8 +908,9 @@ int sock_set_timestamping(struct sock *sk, int =
optname,
> > >           !(val & SOF_TIMESTAMPING_OPT_ID))
> > >               return -EINVAL;
> > >
> > > -     if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
> > > -         val & SOF_TIMESTAMPING_OPT_RX_FILTER)
> > > +     if (val & SOF_TIMESTAMPING_OPT_RX_FILTER &&
> > > +         (val & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > +          val & SOF_TIMESTAMPING_RX_HARDWARE))
> > >               return -EINVAL;
> >
> > There may be legitimate use cases of wanting to receive hardware
> > receive timestamps, plus software transmit timestamp, but
> > suppress spurious software timestamps (or vice versa):
> >
> >     SOF_TIMESTAMPING_RAW_HARDWARE | \
> >     SOF_TIMESTAMPING_RX_HARDWARE | \
> >     SOF_TIMESTAMPING_SOFTWARE | \
> >     SOF_TIMESTAMPING_TX_SOFTWARE | \
> >     SOF_TIMESTAMPING_OPT_RX_FILTER
> =

> Oh, right, it can happen! RAW_HARDWARE is a little bit different,
> covering both ingress and egress path.

As said, it is a bit contrived. Feel free to disagree and keep as is
too.
 =

> >
> > Admittedly this seems a bit contrived. But it's little hassle to
> > support it?
> >
> > We just can no longer use the branch simplification that Jakub
> > pointed out.
> >
> =

> I see. I'm going to do two things as you said:
> 1) restore the simplification branch
> 2) only take care of software case in sock_set_timestamping()
> =

> Thanks for pointing this out!



