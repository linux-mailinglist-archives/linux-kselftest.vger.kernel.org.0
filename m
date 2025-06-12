Return-Path: <linux-kselftest+bounces-34812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFADAD7121
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 15:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6609174123
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 13:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAE723BD1F;
	Thu, 12 Jun 2025 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8qCSoTN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC0286A9;
	Thu, 12 Jun 2025 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733623; cv=none; b=LRZRx64Bzm0eaMvR1A2pT+Q2WU0wY6aHs9zRMmobSz7wK8Ivs5RwEq9mb/wW5Hwj0O0J+S8koMZT1ISjrmqniGMww4bVyKFPdSDZzDRGRG81tx/GPB5s2umlbc3OrE4YJUIM2IRi63KCgVJrlpECEe5u5ZXAGu83ysnpLs7ZqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733623; c=relaxed/simple;
	bh=nIP1KIkmxoz7t37R+vM8UOzEC9TBC8VT+7bu8mFXQBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+0bkXFSzT995gzN/e/Sv3Z2DJ42zktUaOBBbcsK7p1/c+377a3anxUJVTWyItqHN93dXeUEpZy6hCxwHtGyYrrWTsFDDXN6AIz5y8Nqg3W8psj/dbq+GMp/1VavZqmtL1nUN+M2LywJAgP1/CMSBlAOqtDLbM1ygHuWAASB29Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8qCSoTN; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e2a7a2ce6so1313057b3.0;
        Thu, 12 Jun 2025 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749733620; x=1750338420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YTCIHOoiA9wRuF/wA++te8rmMS3KK10f8exb80B8Zk=;
        b=j8qCSoTNYEpYVfpo95pLWKyvxFiCvvODRUKU14sh15BiE15xzUbZDkA7035UESbzOk
         41qHJ1ZK3ACRify4EatJBTzAKP+jc4POzJfo5sxc7LI64JVtW/GNO05LJMgf9UYHCZ5s
         MOE8k7OEObkRQVVZWGarhHhjJUve/XdZcWqKH5iCxS+xaTikLcSu1VWlW5MLSQ0cNv4E
         RCVCmYVIk7p+ih3mLWGucptj1JxjcBPV5QnCeDf3kp9SHLUXrZDOEAjN/7mmsMaRUrVf
         SDg2n1BOzQAVbu11MSDfbZ9GyMD4sZNobUdKpg1uTPaeaKE7SPK9QhbRcLW6VeEAhmPs
         OWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749733620; x=1750338420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YTCIHOoiA9wRuF/wA++te8rmMS3KK10f8exb80B8Zk=;
        b=uTqhvb1dPyWlQi/nU2zR4CpUfjkg2MkwfBG6TGXR/HewqNKGSkg97wbRJCOcVbHiFf
         2UH9tBU5Bjr6zwJrTnFP+rShRNhbWyCaore3XRdVxWq9SWMZYIG3q1RQ1Ij/y741iij4
         rC/xdiIOEa83q7jPKpNsLPTUJ470YSa4DTUs8k3/braMOwp/1RxBH+5eDPS6S/1hLNJe
         KxmVaWFW60rFmIgz1zMaMhsRLLUS1rRsB2lA/uSc9rp1E0ubU9YPAch214WNHg0US+1R
         /batTyAaArBPpYeit83s9+/JPTLORumrGWcI68OxH5Ubu+edsn/pBnoIPI5kGBMf2Xkv
         h4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV2F3TaqyCv267oxeRQuAfk1ANDYolHUGOITror0c8AexKQ3gMxXxW7ZqvDIna/PXckXMhDm90ow6+7d80a@vger.kernel.org, AJvYcCWDlUoOMEfrJVNooR1ZIB99xnOSM9DVpxhaBRYYk26c7IE2gltrpXilsDvilJAAwsGYGaKfuaZT@vger.kernel.org, AJvYcCWu4oL4CM70sGI8Q/2DksL9ooG9FeAQva7Zl2PTWQnh7aCTih7tfKFcxTI8kr5nqwcwfnSwucOPxFs=@vger.kernel.org, AJvYcCXKwO0rKrqDMljOIX+B0I3oOQ0f9nl3QAcqYRGFRJqrs7su4Lylu8dmksjkqtASgUoSeEx57kAHJc4HkSXqhMmm@vger.kernel.org
X-Gm-Message-State: AOJu0YySQjKzkbf7PRt3K186SugSO5p5NvW9SVpN9tPEvCNH9zTKIcVM
	Hx7j+2Wo9cO5m20D7jToR7UD5J04GRH9Fjd6s9/AD+HyMLlxxsKA1wnBLRql+7ID2v8sgeJRg4D
	1yOexl5NdQif4C5uMFR3WLu4yocvyFio=
X-Gm-Gg: ASbGnctzHhCpyaEM2d90rk1Y80ryqPIP4Ys95rpkVFZQphdAds63SuBOKvSjYCPA8X9
	OS42F142Rqx1t8HNqK9JyQ/bGuFa1Pvt7uCbN9/AVj8vveKuPtmsChYCb/INEewTVChzsYBSymY
	JeXgEuDM+orfKiRPjNr8RxRTCQRs2ZUMKDnKwJWCIGIWGkpRcx/4EVeCiB1GU=
X-Google-Smtp-Source: AGHT+IED2kJYub7iNi0oRog4IGfnH9hPbxnLWmdDYPS9CmCqxhHia+Ei+Yb2xOs3aB5jRFj+uweNWOPbidBRGHLDI3A=
X-Received: by 2002:a05:690c:498c:b0:70e:614d:6446 with SMTP id
 00721157ae682-71140ae0684mr46959417b3.7.1749733620418; Thu, 12 Jun 2025
 06:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
 <20250611-netconsole-msgid-v1-3-1784a51feb1e@gmail.com> <aEmhA0QoZy3LbAu+@gmail.com>
In-Reply-To: <aEmhA0QoZy3LbAu+@gmail.com>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 12 Jun 2025 14:06:48 +0100
X-Gm-Features: AX0GCFvy6Zg8RCik0v6KsjOcOWhTWL4dg3oZ5AKee0pu47fXiiZYXGhJgvckdwQ
Message-ID: <CAGSyskW0XHZGHsJ1R2e_Lgh1nG+SJ9Rwk_-nWfU6Xdw5VQTd8A@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] netconsole: append msgid to sysdata
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 4:30=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Wed, Jun 11, 2025 at 07:36:05AM -0700, Gustavo Luiz Duarte wrote:
> > Add msgcounter to the netconsole_target struct to generate message IDs.
> > If the msgid_enabled attribute is true, increment msgcounter and append
> > msgid=3D<msgcounter> to sysdata buffer before sending the message.
> >
> > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> > ---
> >  drivers/net/netconsole.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 813f50abaf9f..34b61e299eeb 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -155,6 +155,8 @@ struct netconsole_target {
> >       size_t                  userdata_length;
> >       /* bit-wise with sysdata_feature bits */
> >       u32                     sysdata_fields;
> > +     /* protected by target_list_lock */
> > +     u32                     msgcounter;
> >  #endif
> >       struct netconsole_target_stats stats;
> >       bool                    enabled;
> > @@ -1345,13 +1347,21 @@ static int sysdata_append_release(struct netcon=
sole_target *nt, int offset)
> >                        init_utsname()->release);
> >  }
> >
> > +static int sysdata_append_msgid(struct netconsole_target *nt, int offs=
et)
> > +{
> > +     nt->msgcounter++;
>
> This will eventually wrap. I am wondering if you should use the
> overflow.h helpers to avoid warnings in UBSAN and friends.

Good point. I will send v2 using one of the overflow safe macros.
Thanks for reviewing!

>
> Quick glanced over that filed, I found:
>
>         /**
>         * wrapping_add() - Intentionally perform a wrapping addition
>         * @type: type for result of calculation
>         * @a: first addend
>         * @b: second addend
>         *
>         * Return the potentially wrapped-around addition without
>         * tripping any wrap-around sanitizers that may be enabled.
>         */
>
> > +     return scnprintf(&nt->extradata_complete[offset],
> > +                      MAX_EXTRADATA_ENTRY_LEN, " msgid=3D%u\n",
> > +                      nt->msgcounter);
> > +}
> > +
> >  /*
> >   * prepare_extradata - append sysdata at extradata_complete in runtime
> >   * @nt: target to send message to
> >   */
> >  static int prepare_extradata(struct netconsole_target *nt)
> >  {
> > -     u32 fields =3D SYSDATA_CPU_NR | SYSDATA_TASKNAME;
> > +     u32 fields =3D SYSDATA_CPU_NR | SYSDATA_TASKNAME | SYSDATA_MSGID;
>
> This might be gone now, according to your last patch.,
>
> LGTM.

