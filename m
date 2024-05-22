Return-Path: <linux-kselftest+bounces-10589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E998CC5CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 19:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8F9282BC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C53145B2C;
	Wed, 22 May 2024 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akvgZ3UT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8C145B1F
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400040; cv=none; b=Voks9ndF1ECIA+lkLcsZ9UAaKgc34d1n5eBhgt1x9qmxgZYo1phHvJsT309I0l1Aqul6UbPtY3HFzraDabBrnKcHLJ3Ym2fOniN5PQ0N1cBIWt5F0PJZQJbuaauzDGzEPTpQVfQk6VRrAtAd6Hv9/B9sKqkX1ij0OgDI8DuwcL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400040; c=relaxed/simple;
	bh=l/aqMP/pAxxQNkv1cpn6DL6g6yJONydNx3Emd5onJIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsR+psKr8n2CrFArQ24SL18AKBd5Wpja2Y/ITHXhNSmchA7Q9O/8yQv6VZYhqIQnFiPjIsrMUnS8RMrOaYXR2m/Niy0QGLnL7EUfkSOXK6lQR72sqJTcQkifyUHioh1l7qO/W/5FmrneqnYrnMgM08CN44jg45jp/OBrOC559DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=akvgZ3UT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso699a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716400037; x=1717004837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxpzkj4h24ckPZbqXAVMFddkCZE0Xyra0TpA42yUw6Y=;
        b=akvgZ3UTlTl9+ivduLm+K+kDJXBgX7m9rh6LWIoJ5H2KbLUZiAEB+xALqgtsTGcreC
         /iGvWquaYv1hZkIID9rsWH+bYGPL6cSEsuu9vwcfp8yYhRq43Gc0JxhJxl5pavZeNLgf
         V5pUTOKdLZycj5x8roYhHYzdODB4RXw2uQ5wRgrNK2r5wdpnM1rukZEcDTa7gomOZaIe
         8gv/LNbpNsqpwDslxTRQeWL5ogIzMRe4J1F6OlwOJyEZK87fsy8x8cx251k/J+4mmtgv
         CgJxGH85eI1EexL14QfqlkKsmNLAOqijklgJtii18KpWAe9UOs0ibb0ysTJhD2wrnZDm
         6cPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716400037; x=1717004837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxpzkj4h24ckPZbqXAVMFddkCZE0Xyra0TpA42yUw6Y=;
        b=WSzWEUZmUDFKfvpI8vTZHioypBP9uW55FAxDUyd3VNYcSK9koROvmAI01mB2gQ8Cny
         zHUhxPrGGNeC8rHOplTcTKVxV8ba2Rdv7NK/LfhurUYT9UtkEz2YrXKhkhMzr0mKTj1U
         673UeDmFYQxGv2DiDhFRJL3ul3Lab3NEG/tc2WhqPSxVyMm6ycVFNxTQq0epCk/gPZDn
         CbbBzkebk2L0lIUw4V+dmn37V3IAh0KjwevJz/DF0DsLDiicZHxmKQB/bV5ZjQVqDSig
         Xq8amXwsUn+ZFWYZajcMO5Qel6sgL9d7aHzGoI80aakRhxWj4bt4tfFU+PktASyFFIUU
         paUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzriTanGu2uUwx6jz1U/S8wJCWKo1CLyX30/5nk4U4r+ohzMbUzK9TmE9BpCztKkR/KUSh8mXpHgt+8/IWWEZ13zjjAFtPZgN+FP/K1vVi
X-Gm-Message-State: AOJu0YwxVT1vjBmHN2xziSagArRG07WyLxqDohl5TIH8Mv1oEAreL3zc
	PyTbP+TpTXqBeqWoIITu5dDJOTKlCOFiZLWfyjtGJYu9Y6icK5yo/kvTRWWi2kYfcjqCvO+O0c8
	nAyJ7xnBwJJaUJPJRLZXgnHsI0mZWR5yngfFv
X-Google-Smtp-Source: AGHT+IEhvV3LATx35FZqHosI0UhkBDI1Niq/eTXGrnklxwDEu8dQhBOKQ05jw+yjdKEjHZAcrzgbp92SS4Zf1xFsuR0=
X-Received: by 2002:a05:6402:50cf:b0:572:57d8:4516 with SMTP id
 4fb4d7f45d1cf-5782f9f7e7bmr285506a12.2.1716400037143; Wed, 22 May 2024
 10:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com> <20240522005913.3540131-3-edliaw@google.com>
 <94b73291-5b8a-480d-942d-cfc72971c2f5@sirena.org.uk>
In-Reply-To: <94b73291-5b8a-480d-942d-cfc72971c2f5@sirena.org.uk>
From: Edward Liaw <edliaw@google.com>
Date: Wed, 22 May 2024 10:46:50 -0700
Message-ID: <CAG4es9WAASaSG+Xgp31-kLT3G8wpeT5vAqbCA4r=Z8G_zAF73w@mail.gmail.com>
Subject: Re: [PATCH v5 02/68] kselftest: Desecalate reporting of missing _GNU_SOURCE
To: Mark Brown <broonie@kernel.org>
Cc: shuah@kernel.org, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kees Cook <keescook@chromium.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 4:21=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, May 22, 2024 at 12:56:48AM +0000, Edward Liaw wrote:
>
> > to make stopping builds early replace the static_assert() with a
> > missing without making the error more severe than it already was.  This
> > will be moot once the issue is fixed properly but reduces the disruptio=
n
> > while that happens.
> >
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  tools/testing/selftests/kselftest_harness.h | 2 +-
>
> You've not provided a Signed-off-by for this so people can't do anything
> with it, please see Documentation/process/submitting-patches.rst for
> details on what this is and why it's important.

Sorry, my mistake, I forgot to add it after cherry-picking.  If added
in a reply like so would it suffice, or would I need to send another
patch?

Signed-off-by: Edward Liaw <edliaw@google.com>

