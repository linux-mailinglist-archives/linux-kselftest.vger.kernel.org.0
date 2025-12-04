Return-Path: <linux-kselftest+bounces-47022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6AECA432C
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 16:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CA403170F2A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE52D6639;
	Thu,  4 Dec 2025 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WaeKVD4n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14D2D1F64
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860689; cv=none; b=BDrKhcK0p1HZxs3OBV0bBQu4ML8fxskiPO28KXG0l8Nl973V9Th8x5HZy9nGsjpD1W6JnV73/FKpjm3NRFpuH8s9Xbp6gw6lRjqd40cqWXE8Bx9C9DAxHuWTnHmZGPcrnU1p7HzqeMPElId6jW4Ale1C/D5A8DmMx5O22gNvhZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860689; c=relaxed/simple;
	bh=z0sISq1eXiAzaQp/iLGCP1tqREDNFziuTkdLtskF5bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pl5ajFbxWSD8RsJkESuHozRE70NMu/ETwhhbVTcQBZKbmkdeNhQiYfruGcMgDwhBKAYZHI1olDazc/18g5qeLqcUcRdkJz58wgkae+KflpR1NQeOSfU2bN4dom3mP5sDdjydRgvoNB717qzpJFDjY0C5NnRqZr2C9340GtvkyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WaeKVD4n; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477b91680f8so10495575e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 07:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764860684; x=1765465484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LX7F8EnGPs4lEcXvyS5uWsAw+PN9HNPUTl46be39l9s=;
        b=WaeKVD4ny9Xf8dy/LYVVpXepPWUnRon0EqHT1N0JK19M9vy6tBq24Lb8uNqJcgidy9
         guUT6z+OrYoYLAAxR+QTpFnP/S2XgU+jtruC08/JKkD+YHW9v4DW5mPK3Z2m0ACH8xF2
         2qyElLmgglMg101H/l9Vl2C+HAEMje7jWMll2f5iAxgifBRPDip2+3lHRO9zJOkiaHPv
         otY9DBDu8u8RoOMVMX2ith8hvuXkImw3Qaqz290aXNRZ9X0NVZByVTaVD73XdLGh8b7D
         s2N1zMNjR7ASd6VAfkxxmpG3z25q9onAVkEJKj4FNT82WF5zsf/RqFeBxyEK9BbiaDs6
         idbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764860684; x=1765465484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LX7F8EnGPs4lEcXvyS5uWsAw+PN9HNPUTl46be39l9s=;
        b=Ig+iGiXnWVfBRSV4WQlWaBpgD9KiIok5DVNl7oFx8MuvdhsGWk4kW8XW6SUcFmrVot
         0OuGfZRPpAch492i2Lf+tnsgahnT+64tc+BG8sNw8XQwlmv3dQnC9eFTDSFkpCxeEWjB
         7mXsTobZ2A/CcfDEm7s/teROZ2Oma/W9D4HG1JCogEwQGoKCg5CBH/8QdI5nLAO6s00I
         BfSt13fkSBMwxpSu/eVIdksRkKwWcNeIXY66SnFpVRmZeYus+Yoo8EJP/MHe/69Bntjw
         ppeXXnu2dJK9DwHKSqvdQkNHYb0du3wwhVB5rB2vlfrgKy6WhWaowPJxEeQPHISdct4H
         G9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYGm58lYYTTS0gmv7XZMKdus+vt3guUf3dJHqyBgwpQHE3d2QFliZ3VMg1HYWAJpephp5AxNITp4sUDxABeYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSNPVa3r4UWJ80ozzgrjyqPdxKBfq7VudBbOEuR3bVw3ZyO92h
	VGG91qSSEBNCwDckfNve3czmDEz70WnRGUNCUPcol65RdWd+tDbeJTHA5Ha2fhVZk+Q=
X-Gm-Gg: ASbGncs5Wy2kWageVHE+Ns5qOx+ZTiKfgvQjcBXoInIwwJl0ZwTuWd/as3PycNgiMcQ
	SnECoELk6ayORRuqWLwuZVJZD46FL4uj+RYBDnf0tDUnIjayVbK0M/ygCp2EdgB+mnWLxMIaBZz
	r7w/ny7BQVJwUMCYrYpbbIULX+/8a6aI24r3WUwz8XSyppWNR/QYOjm0up+PvDvbjYKT+/MqDht
	Gw7vHY7E8f2kUhRDq58Dn1qW9T49J3tao+jtBhaCimGrP/hxIaJ6avsusFB971ktghkdo95M3yO
	Q9PKbfntBDiheQxELDtuYFkDP7p42o+FEJGc5KLm7fPN8Ab7gMjNXoNRhIMS7DN2YKJtL/b9lq2
	lxA95gEphxJgsrXy0IQJACgjyT5dFRR3kJiaAJ47cxZ+XGoligGQEdj+xi2DVbjx3rsrDfWnbAe
	DRm5+ojZ14PeuaJ4vis9laMibggOY7d/g=
X-Google-Smtp-Source: AGHT+IFnyscrwkzl65AaAi4UQZiDJKmqiyXsvifrqrv/e75ucjpUSFJYwRcAP12w9MJC6xJxQ7PXLQ==
X-Received: by 2002:a05:600c:1907:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-4792aef70bbmr86623265e9.15.1764860683713;
        Thu, 04 Dec 2025 07:04:43 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b152a68sm38677005e9.15.2025.12.04.07.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 07:04:42 -0800 (PST)
Date: Thu, 4 Dec 2025 16:04:41 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org, 
	roman.gushchin@linux.dev, lance.yang@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] selftests: cgroup: Replace sleep with
 cg_read_key_long_poll() for waiting on nr_dying_descendants
Message-ID: <ud6wzhszf5jwg23c7wtq2wfhwann2c3uuib2bsx2ty7sd6x6ym@3admzvaukqq4>
References: <20251203115631.947908-1-zhangguopeng@kylinos.cn>
 <20251203115631.947908-4-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="254t2h75sguwzjq3"
Content-Disposition: inline
In-Reply-To: <20251203115631.947908-4-zhangguopeng@kylinos.cn>


--254t2h75sguwzjq3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 3/3] selftests: cgroup: Replace sleep with
 cg_read_key_long_poll() for waiting on nr_dying_descendants
MIME-Version: 1.0

On Wed, Dec 03, 2025 at 07:56:31PM +0800, Guopeng Zhang <zhangguopeng@kylin=
os.cn> wrote:
> Replace the manual sleep-and-retry logic in test_kmem_dead_cgroups()
> with the new helper `cg_read_key_long_poll()`. This change improves
> the robustness of the test by polling the "nr_dying_descendants"
> counter in `cgroup.stat` until it reaches 0 or the timeout is exceeded.
>=20
> Additionally, increase the retry timeout to 8 seconds (from 5 seconds)
> based on testing results:
>   - With 5-second timeout: 4/20 runs passed.
>   - With 8-second timeout: 20/20 runs passed.
>=20
> The 8 second timeout is based on stress testing of test_kmem_dead_cgroups=
()
> under load: 5 seconds was occasionally not enough for reclaim of dying
> descendants to complete, whereas 8 seconds consistently covered the obser=
ved
> latencies. This value is intended as a generous upper bound for the
> asynchronous reclaim and is not tied to any specific kernel constant, so =
it
> can be adjusted in the future if reclaim behavior changes.

Great!

>=20
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  tools/testing/selftests/cgroup/test_kmem.c | 33 ++++++++++------------
>  1 file changed, 15 insertions(+), 18 deletions(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--254t2h75sguwzjq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTGjBhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ag4/AEA8vnYZURHlpYUdZIwoG6K
cj1NLOcwOwt2c17lJN9cY3gBAOy6FJ7n6hKdI/nDTvB65mNiVjVrKrmHDFdRgBX1
GTQL
=2g5W
-----END PGP SIGNATURE-----

--254t2h75sguwzjq3--

