Return-Path: <linux-kselftest+bounces-43663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB15BBF792E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 18:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 779024E1A18
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC43446DC;
	Tue, 21 Oct 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FIVtOlHx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6F341AC1
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062728; cv=none; b=BrHt+sIUSuOZ0IKYDY5zk5g0B4CIaWzRq6Q5zo0w05CQlhAtdtbESUkf2rvkeBO/ZU8ETk7yKJCkcNVHUEGDqvOageP0gmfTdI3bVBVSM7ALKUOZ474JQUS7z5D/tbCbiJAXmGCRkSuUibX+HOI3OMGolh94lkhqRUsZDauBr9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062728; c=relaxed/simple;
	bh=bJwV/4fjdh41ZSy3se1KK9PXofaQ/FMRYPJpfMZGJi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVan9VV4jt74QH3BkXunsbWoWWDPLZPYxVBxpWpIhEvUhz47EhYru/OgKPb4Yy5cfLzYjyA3rbYK6XGL25s5Q7nmEXADotMho3ovSadgXUziz7WGmExiE0QaddKP5DLWplqS7vRpzOD51hfELwcRm4Dwr7IK0g2aOBWWI5y4T9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FIVtOlHx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so8542326a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761062725; x=1761667525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2rsp273D+5b2xXwhTqrhSGacsVEuhyzYQN7tg2ibaE=;
        b=FIVtOlHxgbh+T/iD+qwgOmLsgMjeV2cNcfPrWTGx6bcrMx3GWhinUX1+xOn2UqYgPR
         D7ehECyYMGq6WyuilvbiyPXLQjRucGeP7lYfejfG7m5krU85luIH2YO9w3L5Ahrtg0Cu
         2ocCsnJGWQQMviSqiEyfcZ9MuuZLbIwX1Jm9fpwQhzIL5lkctIMHeIAVKZXOcSlx7Jbr
         adVbfGC8WRQtQryjWVZycvV2I9A12axWXJhHX0uaSte+IEyNWzj1V3LS8QLyZwvAH6Ws
         0xwJWXwOmibzhxV4UxbgVXTOssRH1AkQfZLn/jmvYA95g3LXqKPFZIM1YgOcAYEMg6xr
         2ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062725; x=1761667525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2rsp273D+5b2xXwhTqrhSGacsVEuhyzYQN7tg2ibaE=;
        b=j1Fp/kzpoenINMplsSb7Zsamv/gT9WPk+wj9QWvD8sb7V57y9JRTLAoDpGhtxHrgG9
         vaYo6HuaPi/Gc6Jl6IAyYqTd618PYmyh+H8deaqj9bleHluaYCCL1J4pKtitW6FxacsB
         b0T/0RJWqBBIsyJe/q22MFrkNcHtehsdpvdZEQIfIZTJ8Q+mlJckBE1itpLDGUQszk/y
         V9ccrhVt/WLGbpY/ku02jOr3uySQtnPVndNX8gpBnl6/HODGJfTZgZxBXRM67/qVOjia
         m84Xh7mJsZ70xpEpv6I2Ijwg0XjYSQqJ96GoJebb/JrM6Q8jk2OURyIh0DduJWwY0s29
         WJsg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7nxN8En62YaLo1kezwQ0uLWmHADVGdrU2xBL00GxDr61RUgNYhNBWsMq9pYkOVHrsnY3Z8myBENqXSN5KSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYWoCEJiKulDC263cf5B/h9A5EbfyN3Fs89Fy8TfJ7AJrfPfGA
	YJINPCDjHYdYPE79JsX0Z4jN+aymfcd9rh4/J08Zrd+J2mKbzSqcbMM3CHhh8EEigPmaPDzlhiq
	LXQGY2fX4fm4ueuTfxg6xstInUEHjzl0zmlyWWV4YhA==
X-Gm-Gg: ASbGncvk449p1GW7XVRW6q5u7XwarBWJAi4cknCyC0ZELWdN81/gcQbJaPu/ZxRCbbD
	NWAklu/3MJHM7eNmYpgIs0dl28LMeoGCw9PIkBoJSzF7SDntLI6/QecK08bF/uXcrXAX2R3eQ6h
	TTEWGis08dorVwd05y6NhibhVZvix60z5oCEJ3B7b5YU/+qLu0A/KfiWl324f+01N4gHKXp5JVi
	VRg7JT2xxd6NoaOjn4nuv6R2NzbeplT/LTkuis0rCPCC/1IiXTPBKZyXg==
X-Google-Smtp-Source: AGHT+IEeLKgKPa2ao1C+DHLxoNObY+PUJkOnP4atEfZz4NGBJudxoOmpcHAQfeKUlWWXs9tatq7N0kg5qlHh96IaXc4=
X-Received: by 2002:a05:6402:4316:b0:637:ee0d:383d with SMTP id
 4fb4d7f45d1cf-63c1f62cad5mr17942304a12.3.1761062724284; Tue, 21 Oct 2025
 09:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com> <aPchmxfh4ACM0vY2@kernel.org>
In-Reply-To: <aPchmxfh4ACM0vY2@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 21 Oct 2025 12:04:47 -0400
X-Gm-Features: AS18NWCWk4RBaudjWOtzT3Lj31f5xnWLUFz70tsgIQAGYSdCdW8mVv8zsn8kkEQ
Message-ID: <CA+CK2bAHH1tzMEGxAwbmrLnLTzJANMntRu=cp0J8-n101ER7Pw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] KHO: kfence + KHO memory corruption fix
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 2:01=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Mon, Oct 20, 2025 at 08:08:49PM -0400, Pasha Tatashin wrote:
> > This series fixes a memory corruption bug in KHO that occurs when KFENC=
E
> > is enabled.
> >
> > The root cause is that KHO metadata, allocated via kzalloc(), can be
> > randomly serviced by kfence_alloc(). When a kernel boots via KHO, the
> > early memblock allocator is restricted to a "scratch area". This forces
> > the KFENCE pool to be allocated within this scratch area, creating a
> > conflict. If KHO metadata is subsequently placed in this pool, it gets
> > corrupted during the next kexec operation.
> >
> > Patch 1/3 introduces a debug-only feature (CONFIG_KEXEC_HANDOVER_DEBUG)
> > that adds checks to detect and fail any operation that attempts to plac=
e
> > KHO metadata or preserved memory within the scratch area. This serves a=
s
> > a validation and diagnostic tool to confirm the problem without
> > affecting production builds.
> >
> > Patch 2/3 Increases bitmap to PAGE_SIZE, so buddy allocator can be used=
.
> >
> > Patch 3/3 Provides the fix by modifying KHO to allocate its metadata
> > directly from the buddy allocator instead of slab. This bypasses the
> > KFENCE interception entirely.
> >
> > Pasha Tatashin (3):
> >   liveupdate: kho: warn and fail on metadata or preserved memory in
> >     scratch area
> >   liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
> >   liveupdate: kho: allocate metadata directly from the buddy allocator
>
> With liveupdate: dropped from the subjects

I noticed "liveupdate: " subject prefix left over only after sending
these patches. Andrew, would you like me to resend them, or could you
remove the prefix from these patches?

> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> >  include/linux/gfp.h              |  3 ++
> >  kernel/Kconfig.kexec             |  9 ++++
> >  kernel/Makefile                  |  1 +
> >  kernel/kexec_handover.c          | 72 ++++++++++++++++++++------------
> >  kernel/kexec_handover_debug.c    | 25 +++++++++++
> >  kernel/kexec_handover_internal.h | 16 +++++++
> >  6 files changed, 100 insertions(+), 26 deletions(-)
> >  create mode 100644 kernel/kexec_handover_debug.c
> >  create mode 100644 kernel/kexec_handover_internal.h
> >
> >
> > base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
> > --
> > 2.51.0.869.ge66316f041-goog
> >
>
> --
> Sincerely yours,
> Mike.

