Return-Path: <linux-kselftest+bounces-47020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4C9CA42B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 16:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A902A3071A80
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 15:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F071C2D0601;
	Thu,  4 Dec 2025 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SjzS+vfZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2002D0C7F
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860676; cv=none; b=XdQpF+BdIOhmbltOGyTAAldKS6Ku/P81npdu7IyEV4T9z9P0i2Iipx3grwqVz7Cff/LM4TPVCdxpYDiS9ObOL59NNfmJHrchZJ/iuOy3V2Oi/a2V/146+7lNHvpblrq+fMHAfkwbndEG1inj6k6RsA9XqN/Gm/FH5KgF6+luLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860676; c=relaxed/simple;
	bh=GMkwodQqv5ihAipiYFBchfaUkJN2URH6VBm6faQyQkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFTeQXJ3vrbNdt1z9Magmyz57G3yZmjIJ7efmzDy51L7NqPpqB/ZF4yNe/SNVtFqAgoThbVI0xiab8+Q/60zruWkUFxGVTQ0PEgVXQQbEAQxC7V+B9GS6piPaXPK3zKrlXURlz0bIDMhFcYDFObV5pe8aYLC0jJ8f+2NWbrk42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SjzS+vfZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47790b080e4so6771395e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 07:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764860673; x=1765465473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2DDwYlN2TdolRTMzvF0ERtGgzkk3rvSJWuGnqVeCtdA=;
        b=SjzS+vfZwCK98oIaR2MLf5LH8JzXpS8UFKcQXIFZmzGreY4NWXxgBe5Da/6Dzp5ZiX
         2KtYia/YAWhzflFAqlGDh1qqw1DV5J+M6YM9rN1GDMBiA0LW6x4ZBLAzj54NssVHjAAy
         oqaWSP533ICYn3AwZ5RyMzoneWpDf8YF8vTDiBVv0lkon3j05XGAs7+k1CPEUvW7OcYY
         CP34v7xdwKyLXP7UppfCVPfNVDbdK2mdgku0CpWt3uP41zmr3PsfBWxVEPvOkKyyXG3o
         zISHz/YScJvR2MLjzGuRrzIXL0hOUKSsPoTRiId8jTLaZpX9aV3quJEtCMeXOraFzd+7
         W6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764860673; x=1765465473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DDwYlN2TdolRTMzvF0ERtGgzkk3rvSJWuGnqVeCtdA=;
        b=YNunMwvczZJnfQauuvFGksLyFhJ4iKD0yPPLGu3xpljEsZxwYKwZNKhuJC7VHEKmHO
         HMfb/NjJ8/e3XsuXkltTPns8S4MYvqLBDoHiKjGzI8OGLZeEFalj5iL+F89A3s26waHG
         +1yOZyfwu4fflMQCOrhSaSnvhmVWomWK3vF/sVjoxosiHBKrF962LxLu6KGXaXMrtBOg
         HZ44itwj309K0ctJIP7IGWEufoGjsp+yoegGnuDDjKPruM+ZIi5V1uSi/DSjwicoqack
         a+e2ypE3m73z+4TgFFXHcNpTBCVXtyzgwp+ebRj9uQgNscaHU2qyk+MCwNHgNRaM6Xl0
         IswQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4KOQadbfmBX3Yr4W4h65CgB4Schfu/Nv7+CXHFF2Qwei94urhelDM9LOnvaEL/P76BLAZC0Fr6AAFb7Agsxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2oRegGjH+djRI1vDOxHNCqMm0dG3es3p4EjurVi1c6DrXEl5K
	j22734kPTjsqAyoRbU/8o1zr2XY3dz3AFBrSfjLiTxeWMaWWaOZezC4eklJew83AWac=
X-Gm-Gg: ASbGncuonZ+DA9BeBCMr3gRYrmxPLdjcZ9a3ncgdw99GDJ15jhgOLZ9VBRScHylaH+m
	TEDwHGQvUarFK9mS/HQFvUFWMUi3/pLeAwMXce/5DJLB6Nah/NNU1+4z5SesPYwPG9KbyUakr4E
	rfosjNrPjwsEb5pAQNRCcfzDmGkS7ipfOnvvy5GzSfayFhapE1TvlLR0qIrJyeYsJm4SUdNq9DQ
	ZGUDj+suhl4Urv3wCCM19drQjvT07HewXJaZBvR7XTMQZuPFihjGlAJEC2oHbHslRta1TvpKgOK
	Q3F4XDum+A0TFi9vNjxcpUq6TXfIjXND4zUmv18El277scdoT+UE+fAw2YotQwiragcgarJOvAm
	r3IMPPdE6vSei0uS3nsW1tQBQOt4Dag55nAJ9+nMoaYOVMQ8i0lCYbbTG26a/CPD63cbNqV2ijk
	jhCW7h1m6hauwvc1L5kUKwYv6s6bk8djk=
X-Google-Smtp-Source: AGHT+IH2NIlz/wz6Kqufkv//L8zRMTY07VdB0gJrxPl/jBzW9+fRPbrtuIwMHrwY/OcmxIGtd7X+Tg==
X-Received: by 2002:a05:600c:3b1f:b0:477:8a2a:123e with SMTP id 5b1f17b1804b1-4792af4046fmr57480815e9.33.1764860673050;
        Thu, 04 Dec 2025 07:04:33 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b02e7fbsm39364055e9.2.2025.12.04.07.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 07:04:32 -0800 (PST)
Date: Thu, 4 Dec 2025 16:04:30 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org, 
	roman.gushchin@linux.dev, lance.yang@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] selftests: cgroup: Add cg_read_key_long_poll() to
 poll a cgroup key with retries
Message-ID: <jp3gp3qbbqmq7nbn5i7qbsgxj3vwquibsxubvvkhc37p3pcc2m@24bljtuw6diy>
References: <20251203115631.947908-1-zhangguopeng@kylinos.cn>
 <20251203115631.947908-2-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="alsebtq3iwjlaxr2"
Content-Disposition: inline
In-Reply-To: <20251203115631.947908-2-zhangguopeng@kylinos.cn>


--alsebtq3iwjlaxr2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/3] selftests: cgroup: Add cg_read_key_long_poll() to
 poll a cgroup key with retries
MIME-Version: 1.0

On Wed, Dec 03, 2025 at 07:56:29PM +0800, Guopeng Zhang <zhangguopeng@kylin=
os.cn> wrote:
> Introduce a new helper function `cg_read_key_long_poll()` in
> cgroup_util.h. This function polls the specified key in a cgroup file
> until it matches the expected value or the retry limit is reached,
> with configurable wait intervals between retries.
>=20
> This helper is particularly useful for handling asynchronously updated
> cgroup statistics (e.g., memory.stat), where immediate reads may
> observe stale values, especially on busy systems. It allows tests and
> other utilities to handle such cases more flexibly.
>=20
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> Suggested-by: Michal Koutn=FD <mkoutny@suse.com>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  .../selftests/cgroup/lib/cgroup_util.c        | 21 +++++++++++++++++++
>  .../cgroup/lib/include/cgroup_util.h          |  5 +++++
>  2 files changed, 26 insertions(+)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--alsebtq3iwjlaxr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTGi+xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiVAQD9GDHbzq27fgmc8XyKGDiK
IgD/7BYZ1+cvN45rEc0/vzoBAMk4RTHxSBm6UOa0ZfWYb1vuWJwjUshDzUhrZvnV
/1oJ
=YEEX
-----END PGP SIGNATURE-----

--alsebtq3iwjlaxr2--

