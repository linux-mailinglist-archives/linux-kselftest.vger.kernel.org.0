Return-Path: <linux-kselftest+bounces-32399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCBCAA98B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4CC1884C5B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B5625DCEC;
	Mon,  5 May 2025 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d/aZ2g9q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651B2586EF
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462139; cv=none; b=bDzFRKb+2ZQPKZVepnynFaoE9nS0732ofABhaJNFF0Dov3QQ+nmGcG/C+wjJUF3NHCY5j6CzUFc+Nwwd3q/fYnMkzs0GRKAVqmxH6L1a7qln13jHPbRj+lBG/wmy2nfkuep11ZiFnAf/gWCJhUDqV6h6lEOpyb0A1KvtzlVmN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462139; c=relaxed/simple;
	bh=dx+0A0+zGYkg14I6OBkj3/ss6kuJ7p0HznjIA0M5sBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugXmM+NeR73nYyXFCR0ldNqSsVX6TEX4ZBXaY37ruYwmvU5wOm5ne95LVKE5mGrp6L1z5h7yfCBiL0sWJgmvDiWbvtpVOfTEmmK5ec9GmVb2Qh5CyETUKekrW6fgBL1hazpKiuX7lIL/dHERVbos36FcRLXMM/Y7Ta7n32MFrco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d/aZ2g9q; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ff27ad48beso38441827b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 09:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746462137; x=1747066937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUSGTKlbA5H24+yBQN4jIkG58T5ExeiJA4eFJ+JNTtQ=;
        b=d/aZ2g9q4bY9fC5ic82QjW2gNn84oN08nKwoGcD2su899FBEW/oaxzkyoC/rX5BDWT
         7WtVn/VgA4O6UlDBrtXJI0KzzYRjd5O/Fce5mGCyT0iQrp1+3Qct2UdcDGQk2qCbTJ4J
         qLt9+T11iy68OREJTQJHK7tHvhe3nmKHUuQUdGWsdRANAQlIaS+zo0X2QSstvtQ9iwQG
         wb6sxZk+TB59/B/z3u1H+oYg1d7qmU2NciHyaucXTz4rGDNeDHJH7W1Qh3XDdhFdP13m
         Ilf/DtHSyKqqa92kCbzcfyM2PfEAaoRuNCM+kKeLuJc/eJWX8ZjrGcO25vuT0p60nZvs
         +N5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462137; x=1747066937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUSGTKlbA5H24+yBQN4jIkG58T5ExeiJA4eFJ+JNTtQ=;
        b=YRpf7b4p7zt+ZcEi4yrmQY9TK+8yIxjyQjfG69P1C0dbH3FOPCBUsyog9RtO1giC2Z
         QuPbAUjOZ0l3Hd1PKLA/agfhLewgV7DChCi1DvWMD2FXvJeh4GUFvaLx5PUyxKx8RfDF
         1inGiB69MjYYIgWe2bLSfFGxVdkV5KsDj93jEEYmL5n/Dbz0Aj46JLP1aWagDjeALCEr
         PL89wnsj8pbyi7EX09GuMNisHc8VWysckvSkrLZnH7iTMX4qI7cks3A8Oycx6018A5HG
         Tt29xKy0bN9VlxbEYY/xlykBsgIGhXpXtasXwJlljWGrnAZAyHlF9MpqC4CsqZwA6H04
         2Iyg==
X-Forwarded-Encrypted: i=1; AJvYcCUtZDaatrz47Ga9UQgcgj5gIzAvyZPjJdErHQdRisN6vcbW+3znkorIKM58Xb7t//CplPnq3Zw3pgHTgM8l3yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT3p09SnNOWS2mX1ZvjZst/Kpua1/IwTLvTSbKknF8uuqseToZ
	NB6sc5SunrdF4z1IRz/dHn7sX8fFxaarp7xfeqmJ7so7JK+gUgk3p1oZXh4X43Ki3kKBT4zDW4y
	98oz/JpybdtpEmz9x5pDwj7K3hiEIIXQn+jgn
X-Gm-Gg: ASbGnctVOI9gw6EVJhH2woT5l3qAgUJmAgOTUDaq3R7G5laO9TmeTGv14NLu67lqSTb
	0AvCDS/uSE5hdq7Hm+nKi0e/NAgbZQc1DJgHJnBDwUR2LXmj5/bT0hjk+f2ydRVL4zQqXoWnrY6
	huMWfOROTxHA+zzEOUBoHpqw==
X-Google-Smtp-Source: AGHT+IH2DUE5HVNEg2bSjlLOWtDIRC8IZyXb2mE2mCyNBUhFsO4FmPL69/3p57Fob2eoRjHd/ddHHp962kCkNWER8p8=
X-Received: by 2002:a05:690c:6504:b0:702:537b:dca8 with SMTP id
 00721157ae682-708e119b266mr116732617b3.4.1746462136818; Mon, 05 May 2025
 09:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
 <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
In-Reply-To: <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 May 2025 12:22:05 -0400
X-Gm-Features: ATxdqUHVSCLwU25t9Nh-Eb-QNfhRN532QIA5RHPtIkiKO7hREbMXnOdoRrxJisQ
Message-ID: <CAHC9VhRf2gBDGFBW1obwCaGzK4RdH+ft_J-HXV6U7x7yiCJn5g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: KP Singh <kpsingh@kernel.org>
Cc: bboscaccy@linux.microsoft.com, James.Bottomley@hansenpartnership.com, 
	bpf@vger.kernel.org, code@tyhicks.com, corbet@lwn.net, davem@davemloft.net, 
	dhowells@redhat.com, gnoack@google.com, herbert@gondor.apana.org.au, 
	jarkko@kernel.org, jmorris@namei.org, jstancek@redhat.com, 
	justinstitt@google.com, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, 
	llvm@lists.linux.dev, masahiroy@kernel.org, mic@digikod.net, morbo@google.com, 
	nathan@kernel.org, neal@gompa.dev, nick.desaulniers+lkml@gmail.com, 
	nicolas@fjasle.eu, nkapron@google.com, roberto.sassu@huawei.com, 
	serge@hallyn.com, shuah@kernel.org, teknoraver@meta.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 7:25=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
> On Sun, May 4, 2025 at 7:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Fri, May 2, 2025 at 5:00=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:

...

> > > ... here's how we think it should be done:
> > >
> > > * The core signing logic and the tooling stays in BPF, something that=
 the users
> > >   are already using. No new tooling.
> >
> > I think we need a more detailed explanation of this approach on-list.
> > There has been a lot of vague guidance on BPF signature validation
> > from the BPF community which I believe has partly led us into the
> > situation we are in now.  If you are going to require yet another
> > approach, I think we all need to see a few paragraphs on-list
> > outlining the basic design.
>
> Definitely, happy to share design / code.

At this point I think a quick paragraph or two on how you believe the
design should work would be a good start, I don't think code is
necessary unless you happen to already have something written.

--=20
paul-moore.com

