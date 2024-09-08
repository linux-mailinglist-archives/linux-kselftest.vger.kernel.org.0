Return-Path: <linux-kselftest+bounces-17450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1116B970991
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Sep 2024 21:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC471C217C0
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Sep 2024 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC837177991;
	Sun,  8 Sep 2024 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYcLvKKS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0B2206E;
	Sun,  8 Sep 2024 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725824496; cv=none; b=SLki9Gdc01attL1+w/PnmnXE9i4bb9HN2nnsZTiWQzGSyLMXVfxVhn4uH5GSxM7P15dy0ujIfZhbzAVqSh3NmTTaUjfaXhCAsBu/5Mdqi/ThsqdjMvUvRE4BnyTsDD8+8N16YG3BEsZvlFsQsq++9QQ7rQAW/2FjgP/pitjJQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725824496; c=relaxed/simple;
	bh=xz5tWGZSEJ980kVQmcGgkGRs7fv4OtphlnEBZ6R6gRA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TAfw2zA6vgoF81fv4EivMH5P5pAfqH8nQ2HMCgJjah/WXi5+GDaZn2X68ZCIesvxSOr5awgcSdP7+pBA1cYRhSXRfPKuvuw/53PK/g5CxR4gU5C8x68BQv8KzxJK95aEsQH59ZxZuLdicbOOP+HIGR1Z7mePAQmADnQiCrn/fZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYcLvKKS; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c359c1a2fdso21586656d6.2;
        Sun, 08 Sep 2024 12:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725824494; x=1726429294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz5tWGZSEJ980kVQmcGgkGRs7fv4OtphlnEBZ6R6gRA=;
        b=lYcLvKKSxsvQz/bDOZvE8ePI9UnJmME06F34ezZZHty4NySx4sw/0taCUiQss2rMdl
         pSf4qugCOqd+VWU6w5ri8wR4/NcAZLCZD962YJ5A9ITqRITC3hQB2qESrnMt7gRTTnlw
         SIZ18HMT/ArB9tar3QbrsnPOeNQOOwOIryEu/JociUfvc5LFzU5f/3EKbKA7cwsHMNtD
         mafmmDsdWSOkob6v6uhBmuwKt0LnjKqYr56RSIv7VqdjtPdWD5ROQdWjtBPjt7YoUvEW
         skIbCxtQZ/8Jx2+Trvkd7tDiYnR0qlMgQFI4yNuk2GU/1XbU/uMYTIOPNVLDnYfQ3zok
         +vsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725824494; x=1726429294;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xz5tWGZSEJ980kVQmcGgkGRs7fv4OtphlnEBZ6R6gRA=;
        b=HHAZkVzwX/zwbJkT+WUNj9Q1CVu9SjV4i6aLOsu6Qzsh5pril/ZSGtMCo2tRKjI964
         BlsR3BGX9kIQ8oSEuBw+PooyrXrHSc50+fivDKn0VH8Et1zVBn6Ffq9f+Vflg0ngjQIe
         PFTGCu47Qe19vGv8W2hseiNJOqQ1MiNp34rivDIMDHFYmkZcXU2OzKlMohhDlXWEhMhf
         WMiTbHlNfJiTLLFkDDs7qKTc8lIITIYKwvPSFgJFVaAAShJ1CQ6Lyb7L2G2Gz8uceSjo
         CHV4eCKNK3257cARBevfUl6Svs7oCuB/Ucu2foLi7cPqq7zjwJ7xM1m7uWs9YMBy8eKu
         9jHA==
X-Forwarded-Encrypted: i=1; AJvYcCW0NTf8cZs7ATcQO1HKCXzX3uXVcKnrz1KyxelkjTuOWgzXaRCwngDjNRxu5283tMCG5JvbaFCt@vger.kernel.org, AJvYcCXG58ItLEW4HceQrrpZKgUDx/6S4AZINfVCG52tTuXay82rlDp9bCa9hZ5HWI8XnMCX3SaBadLQLcTIwLTWw7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxne2IIGPsRSwS0rEvwbhJIcgtaJB4KCfsdOb/c/wB/VaqT3pnG
	p2+8uyYdJ3phc/kq3MOaK5FuQTIE+AYxtFJKp0WNFxjEtzqd5rL5
X-Google-Smtp-Source: AGHT+IFmR/tPXNm79YOtLkdwhZ9f7b5XEqEXRuZ66d74lDKkcxHzcvxNks7RPUuBVbn7ChS3ZWaG8w==
X-Received: by 2002:a05:6214:4607:b0:6c3:5926:a070 with SMTP id 6a1803df08f44-6c5284f4c8cmr128625486d6.30.1725824493757;
        Sun, 08 Sep 2024 12:41:33 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d8d7sm14816366d6.95.2024.09.08.12.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:41:33 -0700 (PDT)
Date: Sun, 08 Sep 2024 15:41:32 -0400
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
Message-ID: <66ddfdece6d32_2fb98729447@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoC2TajcYLewWrhpF7KL75XyMiW_G0RV+58=fbMEH8rf=g@mail.gmail.com>
References: <20240906095640.77533-1-kerneljasonxing@gmail.com>
 <20240906095640.77533-2-kerneljasonxing@gmail.com>
 <66db8f293dbd1_2a33ef294b3@willemb.c.googlers.com.notmuch>
 <CAL+tcoC9NoE3ws3nA-_ANAqD1cWpv9JDzFY11ACryZgg35dQrg@mail.gmail.com>
 <66dbbbac6a6df_2b0bd0294d3@willemb.c.googlers.com.notmuch>
 <CAL+tcoC2TajcYLewWrhpF7KL75XyMiW_G0RV+58=fbMEH8rf=g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/2] net-timestamp: introduce
 SOF_TIMESTAMPING_OPT_RX_FILTER flag
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
> On Sat, Sep 7, 2024 at 10:34=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Sat, Sep 7, 2024 at 7:24=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > introduce a new flag SOF_TIMESTAMPING_OPT_RX_FILTER in the rece=
ive
> > > > > path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
> > > > > out rx software timestamp report, especially after a process tu=
rns on
> > > > > netstamp_needed_key which can time stamp every incoming skb.
> > > > >
> > > > > Previously, we found out if an application starts first which t=
urns on
> > > > > netstamp_needed_key, then another one only passing SOF_TIMESTAM=
PING_SOFTWARE
> > > > > could also get rx timestamp. Now we handle this case by introdu=
cing this
> > > > > new flag without breaking users.
> > > > >
> > > > > Quoting Willem to explain why we need the flag:
> > > > > "why a process would want to request software timestamp reporti=
ng, but
> > > > > not receive software timestamp generation. The only use I see i=
s when
> > > > > the application does request
> > > > > SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE."
> > > > >
> > > > > Similarly, this new flag could also be used for hardware case w=
here we
> > > > > can set it with SOF_TIMESTAMPING_RAW_HARDWARE, then we won't re=
ceive
> > > > > hardware receive timestamp.
> > > > >
> > > > > Another thing about errqueue in this patch I have a few words t=
o say:
> > > > > In this case, we need to handle the egress path carefully, or e=
lse
> > > > > reporting the tx timestamp will fail. Egress path and ingress p=
ath will
> > > > > finally call sock_recv_timestamp(). We have to distinguish them=
.
> > > > > Errqueue is a good indicator to reflect the flow direction.
> > > > >
> > > > > Suggested-by: Willem de Bruijn <willemb@google.com>
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > High level: where is the harm in receiving unsolicited timestamps=
?
> > > > A process can easily ignore them. I do wonder if the only use cas=
e is
> > > > an overly strict testcase. Was reminded of this as I tried to wri=
te
> > > > a more concise paragraph for the documentation.
> > >
> > > You raised a good question.
> > >
> > > I think It's more of a design consideration instead of a bugfix
> > > actually. So it is not solving a bug which makes the apps wrong but=

> > > gives users a hint that we can explicitly and accurately do what we=

> > > want and we expect.
> > >
> > > Let's assume: if we remove all the report flags design, what will
> > > happen? It can work of course. I don't believe that people choose t=
o
> > > enable the generation flag but are not willing to report it. Of
> > > course, It's another thing. I'm just saying.
> >
> > Let's not debate the existing API. Its design predates both of our
> > contributions.
> =

> Yep.
> =

> >
> > > I wonder if it makes sense to you :) ?
> >
> > I don't see a strong use case. I know we're on v5 while I reopen that=

> > point, sorry.
> =

> That's all right. No worries.
> =

> >
> > It seems simpler to me to not read spurious fields that are not
> > requested, rather than to explicitly request them to be set to zero.
> >
> > Adding more flags is not free. An extra option adds mental load for
> > casual users of this alread complex API. This may certainly sound
> > hypocritical coming from me, as I added my fair share. But I hope
> > their functionality outweighs that cost (well.. in at least one case
> > it was an ugly fix for a bad first attempt.. OPT_ID).
> =

> I understand what you meant here. But I'm lost...
> =

> For some users, they might use the tsflags in apps to test whether
> they need to receive/report the rx timestamp or not, and someday they
> will notice there are unexpected timestamps that come out. As we know,
> it's more of a design consideration about whether the users can
> control it by setsockopt...
> =

> In addition to the design itself, above is the only use case I know.

Ok. I'm on the fence, but not a hard no. Evidently you see value, so
others may too.

A pendantic use case is if the caller expects other cmsg, but not
these. Then the amount of cmsg space used will depend on a third
process enabling receive timestamps. Again, can be worked around. But
admittedly is surprising behavior.

> >
> > I got to this point trying to condense the proposed documentation.
> > We can add this if you feel strongly.
> =

> If the new flag is not good for future development, we can stop it and
> then _only_ document the special case, which we both agreed about a
> week ago.
> =

> Personally, I don't want to let it go easily. But It's just me. You
> are the maintainer, so you have to make the decision. I'm totally fine
> with either way. Thanks.
> =

> I was only trying to make the feature better. At least, we both have
> tried a lot.
> =

> >
> > But then my main feedback is that the doc has to be shorter and to
> =

> It's truly very long, to be honest. I thought I needed to list the
> possible combination use cases.
> =

> > the point. Why would a user user this? No background on how we got
> > here, what they might already do accidentally.
> =

> It looks like I should remove those use cases? And then clarify the
> reason is per socket control?
> =

> I have no idea if I should continue on this.

My attempt to document, feel free to revise:

SOF_TIMESTAMPING_OPT_RX_FILTER:

Filter out spurious receive timestamps: report a receive timestamp
only if the matching timestamp generation flag is enabled.

Receive timestamps are generated early in the ingress path, before a
packet's destination socket is known. If any socket enables receive
timestamps, packets for all socket will receive timestamped packets.
Including those that request timestamp reporting with
SOF_TIMESTAMPING_SOFTWARE and/or SOF_TIMESTAMPING_RAW_HARDWARE, but
do not request receive timestamp generation. This can happen when
requesting transmit timestamps only.

Receiving spurious timestamps is generally benign. A process can
ignore the unexpected non-zero value. But it makes behavior subtly
dependent on other sockets. This flag isolates the socket for more
deterministic behavior.

