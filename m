Return-Path: <linux-kselftest+bounces-17439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4A096FF0B
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 03:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AEE21F23CA5
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 01:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01AC8E9;
	Sat,  7 Sep 2024 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjPDFXp6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3788825;
	Sat,  7 Sep 2024 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725673538; cv=none; b=MFtS4BeWslnNdYQ0o/NQKZILSgRljcNSARsHdu7OFbDvb551jJaeLLlM9Bd+u6408RN1JPkL3R8Gxr5zYL7fqlrigB0348iLzzeT0W3rwnpQfzgIsEwIxFIjicw7FLDhzJ7bFTPECWDb/9r1ADnhv1Z5gF6VidchroKNjPYrS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725673538; c=relaxed/simple;
	bh=F3dlnUNv4zgdn0Rqfq8lOtRN3zyzegNGNCm4TyEBokM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbN2jl2RiMNM5mrRrjvDRLi7mICmTChpKaA/25Brc3Ubh0pHYd68mUbh8v3pBUI30DQwwCUBcWj1D9gf3yMJa1SOxKa4tuNmrLVlHhf4aZq37QmNBtIMF27rCkaaSAvvBhXv0Z2VFvQuA6ehBcbiMNR+jjMnXYSs+c0p7t+jB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjPDFXp6; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39f4827a07aso9714565ab.1;
        Fri, 06 Sep 2024 18:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725673536; x=1726278336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3dlnUNv4zgdn0Rqfq8lOtRN3zyzegNGNCm4TyEBokM=;
        b=mjPDFXp6XQHwZjNrV+R29+fZUutPs6hMKz3nyszY9iAmTYIZnSL45YgiJW+PnE2qYV
         xcuNV0u1oxmVeUZBj8m655PCXtZld/IYwp1sxiIw5nDl5JjRo+QDh/jMogbf33CX6w9W
         e05I/IQbC+/R4Us4slk2YiBF+i9wBEF+bjI8n1sF41IN1qIZQ/UjX++D7Bl+tVW/IzlR
         DTV8YBZwBMsADXRyKyLKKNKJhYC4metWdzRJHMxPy1xVCC3Q5lCGTjzPTrWDIPLX8Zme
         TsASPhSsq/hdvHIc9eT865JoV0rZn1FhitMlbAKwgamOYqBKghjuMui3kirCD0ujvQB/
         /CGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725673536; x=1726278336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3dlnUNv4zgdn0Rqfq8lOtRN3zyzegNGNCm4TyEBokM=;
        b=weKiXf1dXiAu72Q8Sz0+Pga9qg5pqQMFbR1eK7s/nOXg6NghTHOWIFCZGPkdimRn0v
         zoTVWzkOpqc9hz1oVNBfEHncy9cGMKOr90cSIUhfx11bVcWBOwCtf63ktwXsg+MJTSyV
         dDwsqoO85L/0HVETdqmdYWOHS31WomvZ2mNRCA5whb9++97ccLajjl4ckjrMdbNeBIBS
         mSQtVq6XF8L6P9EHcL7teU5ZNfYw/PxMiunOnVsgAqcyNjNjBNrySBRtrq3bMNDnAb/M
         ZInhHA8NwMEOz4TpmHKGto8Si/6q1iGiE3Bl/XVY5YHVSDaEYTKJ9HCJEwSnZZzPDOsZ
         gO1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5SeQ/oqh3B5KxICrbN288Mdgi4PHwqzjHcmxe1sxxIeDJDFOhNUFCIXCJH9a2smaBEeXJzdDq1JCEGiNijKI=@vger.kernel.org, AJvYcCXFzxNeNQnulcJ7iXB7Rzey8x25ei4zluFd+Z7T02XoYE8wgIenDQbgkElPGF+dJr8UplHMO+2D@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8wbT8HiocnLHO0LMZLmA9zKrHyEGFPrVHYu9/OY6isM7oIyx
	AkBzmplo26PYl5XkLZbXzw4n92cxxw9JLuM8kOFb6p1qcRlFvQLM3rG2Yq7pwDCE1aUYYGGYe/O
	2idqmvSIHqGmQ8gZ+a+jilbhbS/HLf9fe
X-Google-Smtp-Source: AGHT+IG9H30f8yV89g0X1fKNwyyF+ZeP9MVBANiBWV5y5JeJ4a12Tos1vqm/s5uA/pMWQQ/H7yFxEnURaUV9WcaueZI=
X-Received: by 2002:a05:6e02:180a:b0:3a0:47eb:3650 with SMTP id
 e9e14a558f8ab-3a04f08271fmr58547455ab.11.1725673536384; Fri, 06 Sep 2024
 18:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906095640.77533-1-kerneljasonxing@gmail.com>
 <20240906095640.77533-2-kerneljasonxing@gmail.com> <66db8f293dbd1_2a33ef294b3@willemb.c.googlers.com.notmuch>
 <CAL+tcoC9NoE3ws3nA-_ANAqD1cWpv9JDzFY11ACryZgg35dQrg@mail.gmail.com>
In-Reply-To: <CAL+tcoC9NoE3ws3nA-_ANAqD1cWpv9JDzFY11ACryZgg35dQrg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 7 Sep 2024 09:45:00 +0800
Message-ID: <CAL+tcoBHP7pZdWB+b1tj12=8VGSeMwvEezkQAvB3qOf81Uqk5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/2] net-timestamp: introduce
 SOF_TIMESTAMPING_OPT_RX_FILTER flag
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 9:23=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Sat, Sep 7, 2024 at 7:24=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > introduce a new flag SOF_TIMESTAMPING_OPT_RX_FILTER in the receive
> > > path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
> > > out rx software timestamp report, especially after a process turns on
> > > netstamp_needed_key which can time stamp every incoming skb.
> > >
> > > Previously, we found out if an application starts first which turns o=
n
> > > netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_S=
OFTWARE
> > > could also get rx timestamp. Now we handle this case by introducing t=
his
> > > new flag without breaking users.
> > >
> > > Quoting Willem to explain why we need the flag:
> > > "why a process would want to request software timestamp reporting, bu=
t
> > > not receive software timestamp generation. The only use I see is when
> > > the application does request
> > > SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE."
> > >
> > > Similarly, this new flag could also be used for hardware case where w=
e
> > > can set it with SOF_TIMESTAMPING_RAW_HARDWARE, then we won't receive
> > > hardware receive timestamp.
> > >
> > > Another thing about errqueue in this patch I have a few words to say:
> > > In this case, we need to handle the egress path carefully, or else
> > > reporting the tx timestamp will fail. Egress path and ingress path wi=
ll
> > > finally call sock_recv_timestamp(). We have to distinguish them.
> > > Errqueue is a good indicator to reflect the flow direction.
> > >
> > > Suggested-by: Willem de Bruijn <willemb@google.com>
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >
> > High level: where is the harm in receiving unsolicited timestamps?
> > A process can easily ignore them. I do wonder if the only use case is
> > an overly strict testcase. Was reminded of this as I tried to write
> > a more concise paragraph for the documentation.
>
> You raised a good question.
>
> I think It's more of a design consideration instead of a bugfix
> actually. So it is not solving a bug which makes the apps wrong but
> gives users a hint that we can explicitly and accurately do what we
> want and we expect.

One more thing: if I recall correctly, the initial reason I proposed
is that the rx report flag is not controlled under per socket but
maybe affected by others. It's against the expectation.

