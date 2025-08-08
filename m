Return-Path: <linux-kselftest+bounces-38564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A70EB1E9F6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 16:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CF2625F0E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 14:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8F027B4EE;
	Fri,  8 Aug 2025 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HK8r9EDm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329B12609D6
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662000; cv=none; b=UsHfRdV3PzceyBKm+cBrhD1qccq4YbgcvVhJyJPjif5pWlAnzWHKxtovsPpjmcvQ1qssea4XFxCeuQ3TxbE6dGRazAzACqXQpawl/JTUG9/mdGhB0eJjQz8biRXZj2X9CB7CWc07GbHRoE3f0L6qZd5bnpSA5QwfRoYUwKI0ViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662000; c=relaxed/simple;
	bh=Iq6OPfb0BUy4RFBX3eUrfo9zr9SoPfRQuh+fqYCnQLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfshviM4XmgNTudpogKH3rZraeZiuvA7F7NT4vBJSaF0gMyN5Ahq1LR8GvHHR0llkSCqtYoukEyuppHnh5xCzNejfvDeQoedLauCuPTyQ6U9IDcyHo+Y1YmKsZaiUz2+7XatP5AK4E4eo/QsCN4/6Gwotpfirw0377FkuQ/paDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HK8r9EDm; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b0784e3153so37046861cf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Aug 2025 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754661998; x=1755266798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziOgj5AOK/KCYmHORFalDdaCAEaK5JFXOuVwayAxXmk=;
        b=HK8r9EDmbd5MzTcRUmlHPMzvrN3shxlR0iJElTnkj0pLIp+EPyB/8VIs0i5KAMV10R
         ESqETDrG3Xc6I4fDf26ncn7iSacCjhAJoOigbp7iH9VJ8ETXE7vnsuUVmmx8O1OVrEKe
         U+kseDaP/m/IyjcCGbM3MtiNgQhYeeIdBhcX8eRHEK9fJ1oVT9o9Q+3mYsLWaHho7twc
         MO06XOypLUi51ybX/pWPuznD/CQvdKbmaHt++uJgNcC4kMTGjbcSzxedV1WAAS4kR/Ct
         6AXnrzgYD9+iaE9lC2SyehFmDa1795ZWGMc46wdIym+cqwcJyLGI51A0lGrWxX0RrWBD
         xOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661998; x=1755266798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziOgj5AOK/KCYmHORFalDdaCAEaK5JFXOuVwayAxXmk=;
        b=j1Y9Uzs9Gyprd27ytVT5hUr+3VQ94GRSvCaZsjwkDfS7+IE10BAuXg4pTCwZtC+Chg
         fWgd24eTR9CGQrWcnYB9X0DBIkx2PK/qIYQw0w+yUy3Z1M1ZxHpT7wFeh3hf9gvcLsem
         r7VqlqqN/YHQU43lDSURuPUbU2lJD7MeVes6+gOOGs2LXjNQptTRvNoRrpBU6H1Rcw4J
         nkKDsI0/z0VdPVJU8L404vWIj8+uvZ1wM6PuGQ2HNrhlPDEsrgUNI2aAJdGer5HF2G56
         mZUH30d0is72G5hDm7ixb8oZ8iaumSO7ZKeFo9D7HmfscJI3GaWYsRRarZsj7asmt7LE
         o9eg==
X-Forwarded-Encrypted: i=1; AJvYcCVV257P/a2m3UsGAnpVtxymIRjvQWzEd2BFsZbr4KqEoAcxw4+kSfO1NKa1OP8dMYRKuMpAJFwIr3NOe4JA3rE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+j4iqB60EIki2kBVm74fmAPki8eLQtVLqIWo4IHyuZGvR1mqn
	29cr73OglUYTjNPK0veYCL0UaibPiR7Y9WOZdi3j/1IEOsf79y3YUIgz/26sDsEvqR8Smi20Dty
	2eS9e27nB4lRXCR3RcgNGrXNATXF4sOsjSgRxQH8E
X-Gm-Gg: ASbGncuUTg15Xs+85+a9RON6qC+L0yPHTvWtJhVqVQrs0HL51dEkHRE7yI2vtx4ubGf
	kvNc6TpwYUgIsR2yS1VGYDy0TdYEq9RrxMtx4+A4/v1vpdDy91q+Y9yT3nIbBnaG98GgcL/aqiP
	rlpEIbSGKERSlbFbYtzpiRbNBb+xBSpfkUgWRCbh+4h+sxSBfhF14UDMyntVhNQ0GcXxRa/qxSs
	r3P6XGzv2UE1jo=
X-Google-Smtp-Source: AGHT+IHRGdX/ZHsgv2T1azwRgMELMQE11Kj9YJ9ySkdVHUQtPdOrWYZ9G4v5taRpQQUvTlquoKOl4cF58xAG4tcTuiU=
X-Received: by 2002:ac8:5a52:0:b0:4b0:6463:7d0d with SMTP id
 d75a77b69052e-4b0aee038e8mr47518731cf.42.1754661997500; Fri, 08 Aug 2025
 07:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180510.3656677-1-kuba@kernel.org> <CANn89iKvW8jSrktWVd6g4m8qycp32-M=gFxwZRJ3LZi1h2Q80Q@mail.gmail.com>
 <20250806132034.55292365@kernel.org> <CANn89iLbDQ2Le-7WU2dWvr3bc4J-Jcra-rX935Or4wRXDGVViw@mail.gmail.com>
 <20250808065730.602dac6a@kernel.org>
In-Reply-To: <20250808065730.602dac6a@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Aug 2025 07:06:25 -0700
X-Gm-Features: Ac12FXwxiUBJWwumM34Me8cVKTR6BwlbT11JvjUaBWegzEU4L43LQNutELiGo54
Message-ID: <CANn89iKs4AsfM_315030-08s2f_1jmzo4Hou-MDKu21q1JcXWg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tls: handle data disappearing from under the TLS ULP
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com, 
	john.fastabend@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	sd@queasysnail.net, will@willsroot.io, savy@syst3mfailure.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 6:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 8 Aug 2025 06:51:06 -0700 Eric Dumazet wrote:
> > > > Can a 2^32 wrap occur eventually ?
> > >
> > > Hm, good point. Is it good enough if we also check it in data_ready?
> > > That way we should notice that someone is eating our data before
> > > the seq had a chance to wrap?
> >
> > I could not understand what your suggestion was.
> >
> > Perhaps store both copued_seq and tp->bytes_received and
> >
> > check if (tp->bytes_received - strp->bytes_received) is smaller than 2^=
31 .
> >
> >               if (unlikely(strp->copied_seq !=3D tp->copied_seq ||
> >                                (tp->bytes_received -
> > strp->bytes_received >=3D (1ULL < 31)) ||
> >                             WARN_ON(tcp_inq(strp->sk) < strp->stm.full_=
len))) {
>
> Nice, I think that would work.
> I was wondering how to solve this yesterday and I realized the extra
> condition isn't really needed. We just have to handle the inq < full_len
> more carefully and remove the WARN_ON(). I posted a v2.

Ah I must have missed the v2, let me check it.

