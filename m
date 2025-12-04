Return-Path: <linux-kselftest+bounces-47025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 842C2CA430D
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 16:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F39831A978A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08772D8390;
	Thu,  4 Dec 2025 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AZt/Wrlw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881F2D6E70
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860852; cv=none; b=LRqV+oh2SxTuJxVpqW1gvB+v7RtRdg1sPXURefsCxzXAJ/UK5BnR9xyNR0Xp6cQWR2i12gKzPNBjcR4DphjWDZ2vbtrWTeXgBv+EFN5Wg99kV9abRD/Qb3QhGShUy0I1hLBs2ekW+yRixqIiAju6QhxLkNfP1FG0JVuGMnDNQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860852; c=relaxed/simple;
	bh=FQvfDdkjjrLfAU24ywC3NvSVagFmvkVgdCf4tPwhv94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdKU0+MiE0Y0ztpQpC23aUKLjZLF+I2TWUnYF3slu4KwTI+vGKvgxcnhMK9Xr0ojqVE0Tn+jbvHUvvu+T4s9MeiDd2g37f4KHilWVQsVLQdJrXTGusi08RGFeZl1PBCIAGdA07NLfbT/d1evTN1zREu6q3jn3UrLxfYHIuNAerg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AZt/Wrlw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso8588085e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 07:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764860849; x=1765465649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LV+NgISCgSwq4CsmAo0crFfEsNkEPc+BvKvvHIanIM=;
        b=AZt/WrlwfBawSkHPQ0q1QnjXTft24AHKFQJ7K6hxZtZl4n3YiEfx2UN0ivvDssZwIL
         Nx8GysgHVMBXA4b3cMD6j+BiqvZJ57JQw6nIY7oWysLk1YKuc5D/2u96KdAJ7Y3+y+Wr
         SmQq6Xkf/SjUvQfy+uAUYQsC29qoQFN/tHLk2y3hZY9/aEuAANg+Ys7qPJNK8B7ql8tL
         bTM4yXJ1u9McAnIJigUbPSuxd78CAgqIL7zGYkCUNV5gMzR8yjN7/fQwz1+TG6XV31OZ
         /84PFnOR/qfI4KARjyDqRDI3ZpVdERW6OGFD9BL8n3Ifk7gFOaA0948O+yp49n4NqDS7
         CvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764860849; x=1765465649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LV+NgISCgSwq4CsmAo0crFfEsNkEPc+BvKvvHIanIM=;
        b=YZaFuukdXxln19zxzLw8SyEaICbHiqKPP/ZNHEquk4YtBq2Zx6Aw2ePlEgKDsLKiiF
         IEz20Xu3hmJ9EzDHofiHFIMS3DzPc9R9HGZJMXm1z1VQivYUV3+12cZ2Pza/BQWKTe0Z
         07/5Bd7aeSSDjb8qcVkzzJi2EhlrdZiQ8eik5EZHR5XVUEi0aqQSxjxAmeP3YNoPdict
         XP0qT6CxDd0VDADh7cQAORteWFU17iXeJ3LpQsvQMnzGjDLB7FbkcgyGeztSm17zPrhm
         R1oPaU2LO8crmcnvho4rOPfRP0XskdyGDNTBaxh+fDhQBiAT0w7Qx3Tx6xAPmiKqLmIb
         /Flw==
X-Forwarded-Encrypted: i=1; AJvYcCWwYk+TlcSJoqUw9OxYritjwluCJJfOH+9EF5Nd/deNu1H9eKasK9J2wFEmx7mmZnY5Vq9WMKbCr8kPfNiPpek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwhK5ep5A0TqMbdatG+1T2xWt56FiNl8qXk0J6Vctj0Gc8iNx
	DZKoAO8Yefvh+wHMNr3AUsnYtWV35WPHmmOC+UV72Q2/gA+2Q5b5wbpHtKcoGLgURZ8=
X-Gm-Gg: ASbGncvEU6laGYXLZddXxJrbWMwdVOg0D4UZ07zyegDItYmmRoQCz2h7cQ7k3QcMZjx
	yTyGpeqJDaWflXnATVTKUu1UYQ5DJ0GNaED24gvluyJL7vT744/6b7PIRhxLTYOyt3hidK4BRdy
	+fLOepX3FxuzxndpXli2xqFO4NgS0g7/w4nDx3858EKO+DWZEe9dsYe9iMKOrVDr805XlzDG1Sn
	CTfndqPABu1zVAiIFkt3fMqOWpdUU6GNoDLvwzYyl8fp2hqV9g2Zl4tswI1hcnlUYaCxwgbuVQU
	W+5/w/7Es31la90Vf/n7jvMpD7DxRkx7361TFs9B90ewb43kYvzH5BsK+Nj9ofvAaHqwjiV6R/P
	l9ETCB1VKd/lgx12E0TiCS/Rxo3gRp0ZKwEf+RKH7oF4WaRSvTHyyWFvoHPLTDJVS4mYtLU0iXB
	xqbSpXEulBRMwM0/NogHE+6brtyRGV9/c=
X-Google-Smtp-Source: AGHT+IEgegdBeJe5UDZpUgbKF1HYqW837uojM+NO07aLzwRyc14WjPBXJbR8fQgrSzPjg7+ikvCL3w==
X-Received: by 2002:a05:600c:46c4:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-4792af1b19dmr68170455e9.18.1764860849081;
        Thu, 04 Dec 2025 07:07:29 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311ee44csm34364715e9.14.2025.12.04.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 07:07:28 -0800 (PST)
Date: Thu, 4 Dec 2025 16:07:27 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	lance.yang@linux.dev, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: cgroup: make test_memcg_sock robust
 against delayed sock stats
Message-ID: <tjs4ai55xpqmmq3t7drwor44xz2vdcsjrpfbl2lnddxwnkqw6b@i5f3vknfxeg4>
References: <20251120060406.2846257-1-zhangguopeng@kylinos.cn>
 <p655qedqjaakrnqpytc6dltejfluxo6jrffcltfz2ivonmk6lb@bxf5xlgo4iw2>
 <f7553219-e19d-4172-90da-a2077cb574cc@kylinos.cn>
 <440f6a44-5d1a-44d6-b776-ec58e6c79f37@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iitwagde47fsnofu"
Content-Disposition: inline
In-Reply-To: <440f6a44-5d1a-44d6-b776-ec58e6c79f37@kylinos.cn>


--iitwagde47fsnofu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] selftests: cgroup: make test_memcg_sock robust
 against delayed sock stats
MIME-Version: 1.0

On Wed, Dec 03, 2025 at 07:59:46PM +0800, Guopeng Zhang <zhangguopeng@kylin=
os.cn> wrote:
> In v5 I tried to follow that direction by introducing a generic helper
> function:
>=20
>     cg_read_key_long_poll()
>=20
> in cgroup_util.[ch]. This helper encapsulates the "poll with retries"
> logic and returns the final value, while leaving the actual assertion
> to the callers. Tests like test_memcg_sock() and test_kmem_dead_cgroups()
> then decide what condition they want to check (e.g. =3D=3D 0, > 0, etc.),
> which seemed a bit more flexible and reusable for other cgroup stats.
>=20
> Please let me know if you think this direction makes sense or if you have
> any further suggestions.

Thanks, I think this is ideal for the current tests. (I skimmed through
the v5 and I have no more remarks.)

Michal

--iitwagde47fsnofu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTGjrRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgQ3AEAsJsktpUy+qq0NNw0kbSh
vDI4eyB0KxjD+vhI9+63j70BAPdrUD/EGfHNf7Dpruu+CFaGuoHmujIDaazi+7dv
FigO
=MDvm
-----END PGP SIGNATURE-----

--iitwagde47fsnofu--

