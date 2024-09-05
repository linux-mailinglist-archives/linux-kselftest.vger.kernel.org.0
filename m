Return-Path: <linux-kselftest+bounces-17240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF2496DAA0
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A331F22438
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96CB19ABDE;
	Thu,  5 Sep 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjiCD+eJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F53D47796;
	Thu,  5 Sep 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543954; cv=none; b=lUPBfSQtl+zl1b3J5zaFEmFXpuAbVIlIhkBfuzWRfvmZVMJvL78l5O2OZS3sDfOiCpHOR7FpMkMYpepaotk8o6rHzvgFlE+Z6Rvqb5fWDKrO5VAUnSc4fVAptyalxPtsFLC1PCrNwjHEdnkTFCytWR1dw+ZwuF5IAjHhpHSa/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543954; c=relaxed/simple;
	bh=RFuEVp5ebo3g50E2xfpWCD0hDN4ut2/GtUnlb/JbUEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzRYF1NR6MBKUYbzZpBx5FjtiVFJrmflb6kmntgniI1k6h3m7FGEIt4BEddw710g55PNp9o2c5y3vWfiOy3CeoFUWh7e3HQ0Bn19swpWmEhxvKnRsOpedutCbVKAFIkNJdV47nr3qLqI8CBrKwuMEKyfabcxI8ULFvCSadOjrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjiCD+eJ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39f4f62a303so2616005ab.1;
        Thu, 05 Sep 2024 06:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725543952; x=1726148752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcxIvkRZU1SqPEsBoyBEtfb+O+7powXbfi0GRTT8Stg=;
        b=FjiCD+eJjTiLjHNtgjNEqHfEJED7EPdPd/aHIW2Qz6nuuK/Bp90uCWknz17d1k1EaP
         VoC1RsEBKJivPGqKP407jZXnYfWWvT4HbUFr3D5Jks2U2zSA9w2bo2K0pLNo31GlLRBL
         6TU53zJpneDZsFoBbhT51oVZgRSh2McPrvvRyNHkp+vYBSagTXNorP9p59UbgGAMP/gL
         ZSAtOd9hFd+gQD/4SBamVciGAXT88rX9QdDDCNBaE70IWl71WYHM6Thnlq2rJlfoq/2b
         GBvSgLxhuYaXaXD5WkSywZkmvJnyLshUmuXPCU8/TTjehUSt02Gv1ekHD8UtIipLGR6z
         o1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543952; x=1726148752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcxIvkRZU1SqPEsBoyBEtfb+O+7powXbfi0GRTT8Stg=;
        b=wtZ7DQIVww0Mu4CsGYQTT1+02mokZ4k7aU7Si+03L9z6zV2npL7bhQUinTvd3FDiAx
         Uyve3NimOA6b5plxB6kVokNUXoDIDPHFnI2QWnoKzVDFFJBUfeMnDejWOJB4Pvhh96UL
         1lN8/0g7/wSyT4cXPEOZm1oFH0IU6EWwbkMTMatC69cI81hTpsghts0WewQLYcGFUw5H
         CmREGgSvczjbHOHaYm1zc5SiqYpWo+u2C9+FufJvn/oWvLXoIIW4fLFzWGRI+5AaGwgL
         Z/ICu/x+kVUoqOk3XggdRD9i0pVwVo/Kqjacliv34LomyuuVEPIPZl5dnlPoHt1GU4yu
         weag==
X-Forwarded-Encrypted: i=1; AJvYcCVXOnZ0ampnwGM13K6VXzbkVOq4dr7fu2n0GhaQmOphpjr9Q4JZ1MH3Rvd0M7qWaCrrZERV4cvR@vger.kernel.org, AJvYcCWPgx02X088KJhywuYlka3PbOu9rQ7UkMa931Re0MnOjyeCTLAeG1TPG7Jo1Bho68IHUj56h34Gp6ty9sudjms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ5d3RGHTderb2qyOU2+AiZx4XPvj1Hbf7yos9oh5OJzgeDWlh
	Mt4OKL92uqOfUY909ppv8fL1HRNa27xNloULQHQEAKMacvGz5GK/npJkTsJ3AiNs/UYfugI8PA3
	nWmFJoJYKwnfXAcxkDkUbkSaGaxjBh/4s340=
X-Google-Smtp-Source: AGHT+IHYMleovLYWsOmzsSPJCWjryeJ9LwIknhwvV7f7hhexuDzYX6uZS1XXOjNtVIzKN88tmXmB2hw9mz30fuiGWak=
X-Received: by 2002:a05:6e02:1fc2:b0:39d:323d:89b2 with SMTP id
 e9e14a558f8ab-39f6d797daamr118321655ab.26.1725543952369; Thu, 05 Sep 2024
 06:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
 <20240905071738.3725-2-kerneljasonxing@gmail.com> <66d9b40ecd086_18ac212943@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d9b40ecd086_18ac212943@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Sep 2024 21:45:16 +0800
Message-ID: <CAL+tcoD=hF3OE0e2e2O8BLVyFtQe_XOttJY_8NKnyX+uEh0EQw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] net-timestamp: filter out report when
 setting SOF_TIMESTAMPING_SOFTWARE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 9:37=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > introduce a new flag SOF_TIMESTAMPING_OPT_RX_FILTER in the receive
> > path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
> > out rx software timestamp report, especially after a process turns on
> > netstamp_needed_key which can time stamp every incoming skb.
> >
> > Previously, we found out if an application starts first which turns on
> > netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SOF=
TWARE
> > could also get rx timestamp. Now we handle this case by introducing thi=
s
> > new flag without breaking users.
> >
> > Quoting Willem to explain why we need the flag:
> > "why a process would want to request software timestamp reporting, but
> > not receive software timestamp generation. The only use I see is when
> > the application does request
> > SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE."
> >
> > In this way, we have two kinds of combination:
> > 1. setting SOF_TIMESTAMPING_SOFTWARE|SOF_TIMESTAMPING_RX_SOFTWARE, it
> > will surely allow users to get the rx software timestamp report.
> > 2. setting SOF_TIMESTAMPING_SOFTWARE|SOF_TIMESTAMPING_OPT_RX_FILTER
> > while the skb is timestamped, it will stop reporting the rx software
> > timestamp.
> >
> > Another thing about errqueue in this patch I have a few words to say:
> > In this case, we need to handle the egress path carefully, or else
> > reporting the tx timestamp will fail. Egress path and ingress path will
> > finally call sock_recv_timestamp(). We have to distinguish them.
> > Errqueue is a good indicator to reflect the flow direction.
> >
> > Suggested-by: Willem de Bruijn <willemb@google.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> nit: Reviewed-by tags are only sticky if no changes are made.

I got it. I will remove it.

>
> > diff --git a/Documentation/networking/timestamping.rst b/Documentation/=
networking/timestamping.rst
> > index 5e93cd71f99f..37ead02be3b1 100644
> > --- a/Documentation/networking/timestamping.rst
> > +++ b/Documentation/networking/timestamping.rst
> > @@ -266,6 +266,18 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
> >    two separate messages will be looped to the socket's error queue,
> >    each containing just one timestamp.
> >
> > +SOF_TIMESTAMPING_OPT_RX_FILTER:
> > +  Used in the receive software timestamp. Enabling the flag along with
> > +  SOF_TIMESTAMPING_SOFTWARE will not report the rx timestamp to the
> > +  userspace so that it can filter out the case where one process start=
s
> > +  first which turns on netstamp_needed_key through setting generation
> > +  flags like SOF_TIMESTAMPING_RX_SOFTWARE, then another one only passi=
ng
> > +  SOF_TIMESTAMPING_SOFTWARE report flag could also get the rx timestam=
p.
>
> This raises the question: why would a process request
> report flag SOF_TIMESTAMPING_SOFTWARE without generate flag
> SOF_TIMESTAMPING_RX_SOFTWARE? The only sensible use case I see is when
> it sets SOF_TIMSETAMPING_TX_SOFTWARE. Probably good to mention that.
>
> May also be good to mention that existing applications sometimes set
> SOF_TIMESTAMPING_SOFTWARE only, because they implicitly came to depend
> on another (usually daemon) process to enable rx timestamps systemwide.

Much better. Thanks. I will add them too.

>
> > +
> > +  SOF_TIMESTAMPING_OPT_RX_FILTER prevents the application from being
> > +  influenced by others and let the application choose whether to repor=
t
> > +  the timestamp in the receive path or not.
> > +
>
> I'd drop this paragraph. It's more of a value statement.
>

I see. Will drop it.

Thanks,
Jason

