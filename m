Return-Path: <linux-kselftest+bounces-17454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3091970A98
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 01:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E06B210F4
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Sep 2024 23:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B491531E0;
	Sun,  8 Sep 2024 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/M0uMMh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DD1474D8;
	Sun,  8 Sep 2024 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725838192; cv=none; b=Gqg7nsqSb3iVjuVBByyB4DuKLvxbcTvfQMoZwY+wOAmI+a/9Jfek8J7tn90Ku/RFEkzg2eBesrDjT1RGDvbZVqIt0YyEKE1+l6bvgPFDb2ZW23A9PuX4ARLSDmufOdcVOdIpIy0hgaR6iwpGUbV239KxGbywNJS+yldU+5qIT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725838192; c=relaxed/simple;
	bh=7+WQr77Uv58jDsJdy/r0FvLNgg2SS5QnZf4G8hiahno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/4CjsM7+YDCfddzJttqzV6cglxXWQNQXm6N32+bNpDKJtDbSyIsOQ3JhMnAeMpmfSqlMor8CUC3JDdQ3K24yjOuRJ3Ftumn+bETevL2z9nGo0E8EBO3QJuPGJg9v31I7RjjxIO/Rq4tUifwyb8Aw7XMo5e018nm82JnLz3OnHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/M0uMMh; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82aab679b7bso46428439f.0;
        Sun, 08 Sep 2024 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725838190; x=1726442990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+WQr77Uv58jDsJdy/r0FvLNgg2SS5QnZf4G8hiahno=;
        b=P/M0uMMhrgdv4huffFQg4hgzI4wnSSP84ElukoYhZufmqkkRhhugj2zuxendAGRQTp
         auiXcRLo8lH6B0dQmArwwzgXg2BvMHUuXybvT06pot5Y4P8sA83PeKds6IK8OhHzoz5n
         EUuE4Y1l0Fxz84VaOwI8xMPn+O0/Ufs7F9seI3rNd9GzQ/5MKA5beZS1/iekxEAHfvWn
         zXGRKSEIARHd1t1njL3ZsLaeYqk7kLaxswvVXYwWxFElv8CuU0xwoRkmkupMK6yGx/SW
         o2IPUZzpvY8qJtZGv8aPkJ1SBKDJQcJWK02dzHf5zAbqHy5Kx0ZJPF2d8Wx65eIg0VZm
         /btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725838190; x=1726442990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+WQr77Uv58jDsJdy/r0FvLNgg2SS5QnZf4G8hiahno=;
        b=dhPj7Wc7BeB7Z9DeSByQgzPd8Em5v6vJq0lSeNxENE2nUXy+1CvtLty5CWNfu8oFxA
         DHY6a74QuU9c5lIQCC7kcNoIq6xTpv1WINYH9by5SypOnZB+edSwKEY3jDPPmG2RvJWw
         ByuV4gC86n0k356YAK8188bjz+5LYfvWNFZGfFTcZitrN94kH2Rw0TCOzM0sRrBLle/h
         oMKzv8XeJ2nw/X427oq7kD3H+YPguLwGn+aeHW/OZPAT7rueyVjCM3P74GAeQeiKG8gL
         a6nTNNRUrjESyNorIuea4RGPpNEff2raYPAaUfwFbMWRzY3utGHxH06mWTJs8NqcvWGJ
         +VhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjAhuJoVyD2salFWYOuD8X84629JA23i55FH70x2J7HpviIni96GbSUKiMPf+IPsF8Vfc2sZN1cJ4o6wMT3kM=@vger.kernel.org, AJvYcCWhg3yOuD6knNReOeZnoMc9irIiAXEEoRFtC4bLL631pVA1m8owv2XYEOd1qJb8HIG8iC8Ab4G/@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXVly/OV+huIDTP1CyYjLZfalyy1Ns97hfvAELnjE62CEvdxk
	lRPY9Fklwk6JY/4L/ftZZj55WYHR550uybD9bS8wmjxFZlmoC9g9lPucMpRcnRDnfJFX9kQc4nt
	MsfOMQtYawHkmi5QRbUQC8nJj9U0=
X-Google-Smtp-Source: AGHT+IFyXjwixsa18a3Z5q8iNR7AJrkl8rpWAV9EPyOzUVRitN3+ofwvHwId4tO1j44Kc2EWNcADMZWxwhOC2o4Rzbg=
X-Received: by 2002:a05:6e02:1feb:b0:39f:51d1:c5fc with SMTP id
 e9e14a558f8ab-3a05746401dmr50235975ab.11.1725838190262; Sun, 08 Sep 2024
 16:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906095640.77533-1-kerneljasonxing@gmail.com>
 <20240906095640.77533-2-kerneljasonxing@gmail.com> <66db8f293dbd1_2a33ef294b3@willemb.c.googlers.com.notmuch>
 <CAL+tcoC9NoE3ws3nA-_ANAqD1cWpv9JDzFY11ACryZgg35dQrg@mail.gmail.com>
 <66dbbbac6a6df_2b0bd0294d3@willemb.c.googlers.com.notmuch>
 <CAL+tcoC2TajcYLewWrhpF7KL75XyMiW_G0RV+58=fbMEH8rf=g@mail.gmail.com> <66ddfdece6d32_2fb98729447@willemb.c.googlers.com.notmuch>
In-Reply-To: <66ddfdece6d32_2fb98729447@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 9 Sep 2024 07:29:14 +0800
Message-ID: <CAL+tcoD4NQSYcdFOpOxXQnfPwjsck5bzZZXzAbOGMKFHvp_d6w@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/2] net-timestamp: introduce
 SOF_TIMESTAMPING_OPT_RX_FILTER flag
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Willem,

On Mon, Sep 9, 2024 at 3:41=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Sat, Sep 7, 2024 at 10:34=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Sat, Sep 7, 2024 at 7:24=E2=80=AFAM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > introduce a new flag SOF_TIMESTAMPING_OPT_RX_FILTER in the rece=
ive
> > > > > > path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
> > > > > > out rx software timestamp report, especially after a process tu=
rns on
> > > > > > netstamp_needed_key which can time stamp every incoming skb.
> > > > > >
> > > > > > Previously, we found out if an application starts first which t=
urns on
> > > > > > netstamp_needed_key, then another one only passing SOF_TIMESTAM=
PING_SOFTWARE
> > > > > > could also get rx timestamp. Now we handle this case by introdu=
cing this
> > > > > > new flag without breaking users.
> > > > > >
> > > > > > Quoting Willem to explain why we need the flag:
> > > > > > "why a process would want to request software timestamp reporti=
ng, but
> > > > > > not receive software timestamp generation. The only use I see i=
s when
> > > > > > the application does request
> > > > > > SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE."
> > > > > >
> > > > > > Similarly, this new flag could also be used for hardware case w=
here we
> > > > > > can set it with SOF_TIMESTAMPING_RAW_HARDWARE, then we won't re=
ceive
> > > > > > hardware receive timestamp.
> > > > > >
> > > > > > Another thing about errqueue in this patch I have a few words t=
o say:
> > > > > > In this case, we need to handle the egress path carefully, or e=
lse
> > > > > > reporting the tx timestamp will fail. Egress path and ingress p=
ath will
> > > > > > finally call sock_recv_timestamp(). We have to distinguish them=
.
> > > > > > Errqueue is a good indicator to reflect the flow direction.
> > > > > >
> > > > > > Suggested-by: Willem de Bruijn <willemb@google.com>
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > High level: where is the harm in receiving unsolicited timestamps=
?
> > > > > A process can easily ignore them. I do wonder if the only use cas=
e is
> > > > > an overly strict testcase. Was reminded of this as I tried to wri=
te
> > > > > a more concise paragraph for the documentation.
> > > >
> > > > You raised a good question.
> > > >
> > > > I think It's more of a design consideration instead of a bugfix
> > > > actually. So it is not solving a bug which makes the apps wrong but
> > > > gives users a hint that we can explicitly and accurately do what we
> > > > want and we expect.
> > > >
> > > > Let's assume: if we remove all the report flags design, what will
> > > > happen? It can work of course. I don't believe that people choose t=
o
> > > > enable the generation flag but are not willing to report it. Of
> > > > course, It's another thing. I'm just saying.
> > >
> > > Let's not debate the existing API. Its design predates both of our
> > > contributions.
> >
> > Yep.
> >
> > >
> > > > I wonder if it makes sense to you :) ?
> > >
> > > I don't see a strong use case. I know we're on v5 while I reopen that
> > > point, sorry.
> >
> > That's all right. No worries.
> >
> > >
> > > It seems simpler to me to not read spurious fields that are not
> > > requested, rather than to explicitly request them to be set to zero.
> > >
> > > Adding more flags is not free. An extra option adds mental load for
> > > casual users of this alread complex API. This may certainly sound
> > > hypocritical coming from me, as I added my fair share. But I hope
> > > their functionality outweighs that cost (well.. in at least one case
> > > it was an ugly fix for a bad first attempt.. OPT_ID).
> >
> > I understand what you meant here. But I'm lost...
> >
> > For some users, they might use the tsflags in apps to test whether
> > they need to receive/report the rx timestamp or not, and someday they
> > will notice there are unexpected timestamps that come out. As we know,
> > it's more of a design consideration about whether the users can
> > control it by setsockopt...
> >
> > In addition to the design itself, above is the only use case I know.
>
> Ok. I'm on the fence, but not a hard no. Evidently you see value, so
> others may too.
>
> A pendantic use case is if the caller expects other cmsg, but not
> these. Then the amount of cmsg space used will depend on a third
> process enabling receive timestamps. Again, can be worked around. But
> admittedly is surprising behavior.
>
> > >
> > > I got to this point trying to condense the proposed documentation.
> > > We can add this if you feel strongly.
> >
> > If the new flag is not good for future development, we can stop it and
> > then _only_ document the special case, which we both agreed about a
> > week ago.
> >
> > Personally, I don't want to let it go easily. But It's just me. You
> > are the maintainer, so you have to make the decision. I'm totally fine
> > with either way. Thanks.
> >
> > I was only trying to make the feature better. At least, we both have
> > tried a lot.
> >
> > >
> > > But then my main feedback is that the doc has to be shorter and to
> >
> > It's truly very long, to be honest. I thought I needed to list the
> > possible combination use cases.
> >
> > > the point. Why would a user user this? No background on how we got
> > > here, what they might already do accidentally.
> >
> > It looks like I should remove those use cases? And then clarify the
> > reason is per socket control?
> >
> > I have no idea if I should continue on this.
>
> My attempt to document, feel free to revise:
>
> SOF_TIMESTAMPING_OPT_RX_FILTER:
>
> Filter out spurious receive timestamps: report a receive timestamp
> only if the matching timestamp generation flag is enabled.
>
> Receive timestamps are generated early in the ingress path, before a
> packet's destination socket is known. If any socket enables receive
> timestamps, packets for all socket will receive timestamped packets.
> Including those that request timestamp reporting with
> SOF_TIMESTAMPING_SOFTWARE and/or SOF_TIMESTAMPING_RAW_HARDWARE, but
> do not request receive timestamp generation. This can happen when
> requesting transmit timestamps only.
>
> Receiving spurious timestamps is generally benign. A process can
> ignore the unexpected non-zero value. But it makes behavior subtly
> dependent on other sockets. This flag isolates the socket for more
> deterministic behavior.

Willem, thanks so much for your effort!!! I learn a lot these days.

I'm going to completely replace it with your description.

Thanks,
Jason

