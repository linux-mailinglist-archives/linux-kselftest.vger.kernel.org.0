Return-Path: <linux-kselftest+bounces-46504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D96C5C8A407
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6696F4E1AEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 14:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC582F998A;
	Wed, 26 Nov 2025 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Iocj3pUA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762DD2F39C1
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764166412; cv=none; b=Z6G2tmBda2/g8sTIDkbQaELPi4kL7iW/5WHRuetjZWiHBxQ5NIfuhsHEsfG8iyemPkGM5rliA220EXJTaYz11FrMcGL/YhVW/X0j4pfRBwkgO/sp2SdfG9cXfV4Jo8SXpf/BUR9Dw5Oss1QPT7Z/EoY1SJNkdFjH1v2zg7BkpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764166412; c=relaxed/simple;
	bh=SpEpOMWjQiFTx5TbkzxR/6qBRSl71Owku3WAktx3f8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYgaQ48Fl+ANV7ILQhfWUFDwLfpRz7ZqBaXbKv9/MHlwonRNrn6fWwIqLn1mTNu2b/RfrJ1GXSC6xSfuv0vx8TyyMgfayA+DUPIekOaC6bqhuj99T1a09pUg2kJ8W4zwMCYgjHmUfN+4Jz6pn8Dp0lB0nI67ef/NLY+MFe9okEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Iocj3pUA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso66128375e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 06:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764166409; x=1764771209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SpEpOMWjQiFTx5TbkzxR/6qBRSl71Owku3WAktx3f8A=;
        b=Iocj3pUAnp0VGNC+GC5lb1+JBLU4AvS77Rlh+iMInG8NBkjRnrjiwXCmGZv2EgtmBa
         JkeulYzKqD42xZ/Zs0YjLogK29e/NQyzh6WH2H0GpIX3oyoqfB/g6eoE9/A+vDn9pjgi
         F7MNgCsWouxFC0DeqiknVBTjIK4Ob9puDA6q9FH3qpfqEBJcEJMaDisoXvFjqqI2vthv
         PL3B16zOS2PntQRjDQ55oFn9muT5L9IHtwqAw1Re+VQCl7MUGVyHpq83ALTBRAaQqtjA
         dEzsLN+KCFhkA6ICSNmzKSL1HQGSg/N7n3moyzalAN1bgPZoXNLjix9qKDG4vZGWL/CA
         ICZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764166409; x=1764771209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpEpOMWjQiFTx5TbkzxR/6qBRSl71Owku3WAktx3f8A=;
        b=KOLy5s9TAQSxPSGngjAMS1UrQa6n/c4ZO4ty332GTEooy3VHxd/2xd9E2uS3R8r5fg
         X9DW1mGhMfax1PJPonGhNhhtTob7uDRbBw5BZGt1Ipn8z/0Sx2DIBdQ+r+/y2TD7KuVa
         Zf2bhRUJkEF10JftA7WXTUDMMR0sEZH6addirJ36TZcxLmWcXsAPJem/Mur41X3Fygb5
         Ndh6t/HCW90UdR1N4toyCwWZGqa2EnsauzFwQSPpg+wP60SxftG7lWf7PrmGW3MCvEBe
         54cxePsg7HeDQlx8SQoI1NzOdfbgjxZuA9v7i6gtKVhhnkBswKpMN/Gk0QQm/0IqXht3
         hnVA==
X-Forwarded-Encrypted: i=1; AJvYcCXwXmuhQBUpDYJ63VgQCnnem9VjvCqA3zN7kDgN80i3nbYU004BGVL2OnIq80KdsLIWQRH5Etv+F9eORioAbh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySK2ijCzmc+8MfYuhrrdM+N+6I4tyl3grfc8/400KwmYfp40Pe
	1OSjm//0jCRiDLSvg0mat7qRFsRzrJWpi8PSR5goIXvo9Bj8/BbhdLRIntbq9wala3mhgfepBIc
	oXjSz
X-Gm-Gg: ASbGncvmXXtJHOp8AyWOCxocKLgPOhyjrwMWAsFUHhnCYHFpk6hrdhHcgvhLcNolcqf
	i1Yu1aM+ZFWCAKYuV7V+tWkQg9OijHCYWniBmY6qp6x4Ac/+UFyNIpy/KIWteInLeYvw0HV5jao
	qKss7gOmgg7AbdfPa+5JDvX8qggbbUiGK1pyrxyLtVrPA6T68N+IKD8weBngD8fA0fZkyO2Pt3U
	giVLUvwqeo+7neoWLdZEyoFXD9DEYQR9UJeuJk/+AH94Zh40CBu2NvjgEamuWTswlDKeCr+aIO3
	orb9LDM8S+cNT6XHwdKdJzOa/z3uGoZ4kZkEJsjpNrGpJvU9GPYJBafWVwno2HJrvycHyrCga80
	mc+NsHc5zda8gDKucCi3pbTrDw5EsXRnqtiDbRd6HwR/YignBRjEQBDzVpyYfWHT7lzpNxfOD0p
	qlyQrk7dzuh+kGiWZjFZkSsXcQ2YIYMYA=
X-Google-Smtp-Source: AGHT+IGFpRXTSTb7swHITU7mmJHy7IJjJYr3Iym9aDPRGHiTXQT5yWcYFNOIGgrmS3RXQ2H/6XR4Dw==
X-Received: by 2002:a05:600c:3b07:b0:471:c72:c7f8 with SMTP id 5b1f17b1804b1-477c01d4b3dmr155445345e9.21.1764166408705;
        Wed, 26 Nov 2025 06:13:28 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adc8bc7sm49416005e9.1.2025.11.26.06.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 06:13:28 -0800 (PST)
Date: Wed, 26 Nov 2025 15:13:26 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Sun Shaojie <sunshaojie@kylinos.cn>, chenridong@huaweicloud.com, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
Message-ID: <ur4ukfqtqq5jfmuia4tbvsdz3jn3zk6nx2ok4xtnlxth6ulrql@nmetgsxm3lik>
References: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
 <20251119105749.1385946-1-sunshaojie@kylinos.cn>
 <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="664w4jtlmtmugwma"
Content-Disposition: inline
In-Reply-To: <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>


--664w4jtlmtmugwma
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
MIME-Version: 1.0

On Mon, Nov 24, 2025 at 05:30:47PM -0500, Waiman Long <llong@redhat.com> wr=
ote:
> In the example above, the final configuration is A1:0-1 & B1:1-2. As the =
cpu
> lists overlap, we can't have both of them as valid partition roots. So
> either one of A1 or B1 is valid or they are both invalid. The current code
> makes them both invalid no matter the operation ordering.=A0 This patch w=
ill
> make one of them valid given the operation ordering above. To minimize
> partition invalidation, we will have to live with the fact that it will be
> first-come first-serve as noted by Michal. I am not against this, we just
> have to document it. However, the following operation order will still ma=
ke
> both of them invalid:

I'm skeptical of the FCFS behavior since I'm afraid it may be subject to
race conditions in practice.
BTW should cpuset.cpus and cpuset.cpus.exclusive have different behavior
in this regard?

Thanks,
Michal

--664w4jtlmtmugwma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaScLBBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Aiy0AEAilgySpjIAW+lcEdRVWvo
jOfzCwRE1uabDygqux31fQcA/ivj2nRO3WUNZpe5yd4+iohLGi1U8mf4DsMZiFFT
yGYJ
=L8+/
-----END PGP SIGNATURE-----

--664w4jtlmtmugwma--

