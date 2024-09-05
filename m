Return-Path: <linux-kselftest+bounces-17241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E49996DAF5
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A83F1C23E1A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5206419CCEC;
	Thu,  5 Sep 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvDLPVn4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4C19C579;
	Thu,  5 Sep 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544673; cv=none; b=DAQw/ztvNv9ED/vd/8gVtFs4sulmue6RTYRU7H97RLn4q9gUaJ5p7JvekfA/ar+E3zKrEz+99sVTnldQMOHcAkFrbDUQm4cTbA4koobsEUvhLQ+HJ41hlWuKiuaui8CgZcXFJEinCLgD2XR/nrR7SfnkDdQddja8I5TgF/aP7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544673; c=relaxed/simple;
	bh=D+IM1exUi6dXRIYxYadwyNFqkF3Bgy+iAJVKXmC+BLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujwE9om875FgUBbC2wLrKGvDF2T2bojRGIrtCAQW68V1ngS6vBmeyy7e+Lqtz1KkbKKc7FofbGn90gK3pzBDQ1C+wWQK0NRGFsJ1csE5pxZnXM+S/Eav9i1kh+dSvSCHFruXRT9Ep2ESl7OcZt9GA9NFxSxdbQIi4VTFQwFXspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvDLPVn4; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39d4161c398so3131195ab.3;
        Thu, 05 Sep 2024 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725544671; x=1726149471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hm/ZpgBj2dX3v3bvnmnFE2yuR0EtKOAxp+T3eZ1bXCg=;
        b=SvDLPVn4kPR/9kMqeWi0c1RGjV8y0vwEh9LUbAFbhbbIGgvQrOeFqcNb4lAkd7upLx
         MhRmi/RaYgdpqMeZuQBMLZhyMEFfcHeABlHgMg2RAbexsGBSA2lmKeJJne0yDgnmd2w6
         C/IfRJK34I0PEIJCpgCZ5jhPBcWVCnzwXerHgqT5jVXsZPJTK3O2JqpffiNvP4fZGBfz
         0fsitWRdAwSk4FSbhCQH+kTA/CR9tzp9D5B0udG8HC+hp4qeH13efYXTpCx1vux0ZQp1
         dMeXijLBJalMGeKIN9PvcyEvN/jCVObJqpW4pC3QlCid4/7BGhQszcnLlmAeBzpW6dJC
         Jt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725544671; x=1726149471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hm/ZpgBj2dX3v3bvnmnFE2yuR0EtKOAxp+T3eZ1bXCg=;
        b=XlhPXNVi8BCxuMsWia0Gzih2tHPc1F2aNYKzsK6ETz+yoCvRTsCtcXU6M5ECDFHpba
         +yO28p8vRLHtYS7fxpdRlo7SYC0cdBYDf/vXNmHNEyv4aLIt7QZ8KKbtursMcVX3Ri1J
         hkgFiXI2LCox/kA1mRZskjSArjY8WZovjb4VZ5WevK4fe4fJyzPRzwN9tIGyR5hlhtR4
         puqDHDgKvfwFR1NsyOOFEOr4Lndfb8f74y5cYeOk5cM7L9aM1RSRKb1wz1dKmZbQcT7w
         uWWbe9XKNaq0frUOTAGSMyBItc6IjSZARo3IQwXaqQbVkRfHK96/y91qyy6Yt65762wQ
         Jw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqYnUgSvvNkHQ6jA6Nr0PGBCkrg0u842FFTOLTaN+/SIAYjZtztV0AGXpUuUilLmn/kaufzOs+@vger.kernel.org, AJvYcCWI2lIAMbwm170s9smwGfImFvCbZvytH4iT+h+vtsdxUokMgv4pvQCUw13nukFf+ofIu1HOEVaxSrt7v1mDHZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVGJAlkzRu5kKbZFJDK7PAc8apTzVBLIrgw7TsHTPGd1/w6pLG
	UqtazKdwhi6reiQr1NnVTwOqr/ay2PPO5iLjvavAXkCcrT/hAx5ZOXtCWrcaiAEUALGFzPM6w4v
	pcQGqgJlgVOrlzLr6Ad92tirjx+Q=
X-Google-Smtp-Source: AGHT+IHCwDIF+TdkPpYw0LUdh2ovQTJMr0t5YuHc2zXP/2YMdbkRl3j8jzk081FZdb3Cj6mfiM4LGk+0rCGepAFYtgU=
X-Received: by 2002:a05:6e02:2196:b0:39e:3952:6dd4 with SMTP id
 e9e14a558f8ab-39f4f55eedbmr209818465ab.20.1725544670526; Thu, 05 Sep 2024
 06:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
 <20240905071738.3725-4-kerneljasonxing@gmail.com> <66d9b5db807aa_18ac2129468@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d9b5db807aa_18ac2129468@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Sep 2024 21:57:13 +0800
Message-ID: <CAL+tcoBPJCP1yUTCe3CLDjBR6rd2BphxTV0bPMdXhh7_CAfOtA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] net-timestamp: extend SOF_TIMESTAMPING_OPT_RX_FILTER
 for hardware use
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 9:45=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In the previous patch, we found things could happen in the rx software
> > timestamp. Here, we also noticed that, for rx hardware timestamp case,
> > it could happen when one process enables the rx hardware timestamp
> > generating flag first, then another process only setting
> > SOF_TIMESTAMPING_RAW_HARDWARE report flag can still get the hardware
> > timestamp.
> >
> > In this patch, we extend the OPT_RX_FILTER flag to filter out the
> > above case for hardware use.
> >
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > Link: https://lore.kernel.org/all/20240903121940.6390b958@kernel.org/
> > ---
> >  Documentation/networking/timestamping.rst | 15 +++++++++------
> >  net/core/sock.c                           |  5 +++--
> >  net/ipv4/tcp.c                            |  3 ++-
> >  net/socket.c                              |  3 ++-
> >  4 files changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/networking/timestamping.rst b/Documentation/=
networking/timestamping.rst
> > index ac57d9de2f11..55e79ea71f3e 100644
> > --- a/Documentation/networking/timestamping.rst
> > +++ b/Documentation/networking/timestamping.rst
> > @@ -268,12 +268,15 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
> >    each containing just one timestamp.
> >
> >  SOF_TIMESTAMPING_OPT_RX_FILTER:
> > -  Used in the receive software timestamp. Enabling the flag along with
> > -  SOF_TIMESTAMPING_SOFTWARE will not report the rx timestamp to the
> > -  userspace so that it can filter out the case where one process start=
s
> > -  first which turns on netstamp_needed_key through setting generation
> > -  flags like SOF_TIMESTAMPING_RX_SOFTWARE, then another one only passi=
ng
> > -  SOF_TIMESTAMPING_SOFTWARE report flag could also get the rx timestam=
p.
> > +  Used in the receive software/hardware timestamp. Enabling the flag
> > +  along with SOF_TIMESTAMPING_SOFTWARE/SOF_TIMESTAMPING_RAW_HARDWARE
> > +  will not report the rx timestamp to the userspace so that it can
> > +  filter out the cases where 1) one process starts first which turns
> > +  on netstamp_needed_key through setting generation flags like
> > +  SOF_TIMESTAMPING_RX_SOFTWARE, or 2) similarly one process enables
> > +  generating the hardware timestamp already, then another one only
> > +  passing SOF_TIMESTAMPING_SOFTWARE report flag could also get the
> > +  rx timestamp.
>
> I think this patch should be squashed into patch 1.
>
> Else SOF_TIMESTAMPING_OPT_RX_FILTER has two subtly different behaviors
> across its lifetime. Even if it is only two SHA1s apart.

I thought about last night as well. Like the patch [2/4] and this
patch, the reason why I wanted to split is because I have to explain a
lot for both hw and sw in one patch. One patch mixes different things.

No strong preference. If you still think so, I definitely can squash
them as you said :)

>
> It also avoids such duplicate changes to the same code/text blocks.
>
> More importantly, it matters for the behavior, see below.
>
> >
> >    SOF_TIMESTAMPING_OPT_RX_FILTER prevents the application from being
> >    influenced by others and let the application choose whether to repor=
t
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 6a93344e21cf..dc4a43cfff59 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -908,8 +908,9 @@ int sock_set_timestamping(struct sock *sk, int optn=
ame,
> >           !(val & SOF_TIMESTAMPING_OPT_ID))
> >               return -EINVAL;
> >
> > -     if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
> > -         val & SOF_TIMESTAMPING_OPT_RX_FILTER)
> > +     if (val & SOF_TIMESTAMPING_OPT_RX_FILTER &&
> > +         (val & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > +          val & SOF_TIMESTAMPING_RX_HARDWARE))
> >               return -EINVAL;
>
> There may be legitimate use cases of wanting to receive hardware
> receive timestamps, plus software transmit timestamp, but
> suppress spurious software timestamps (or vice versa):
>
>     SOF_TIMESTAMPING_RAW_HARDWARE | \
>     SOF_TIMESTAMPING_RX_HARDWARE | \
>     SOF_TIMESTAMPING_SOFTWARE | \
>     SOF_TIMESTAMPING_TX_SOFTWARE | \
>     SOF_TIMESTAMPING_OPT_RX_FILTER

Oh, right, it can happen! RAW_HARDWARE is a little bit different,
covering both ingress and egress path.

>
> Admittedly this seems a bit contrived. But it's little hassle to
> support it?
>
> We just can no longer use the branch simplification that Jakub
> pointed out.
>

I see. I'm going to do two things as you said:
1) restore the simplification branch
2) only take care of software case in sock_set_timestamping()

Thanks for pointing this out!

