Return-Path: <linux-kselftest+bounces-28207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA16A4E0D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 15:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365CF3A640E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3218B205AD6;
	Tue,  4 Mar 2025 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E8AudygG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C068205503
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098064; cv=none; b=JVmXjCp0L88zz99OWwYS6YB0b+ZZ43D+wDBuCZeJ6kytlP1hnUKKoW9gu3pKrHdPTeTfrTt9/2JOumfOeEk+ZYdtit1HMH70NjuEa5tzAnHUvZmbyPPvaa3zCHj9qfgYCTUwTtD7KY7WHqmvdbI0OxgcaD+cL/iAHOZL8th3nVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098064; c=relaxed/simple;
	bh=+A2SxfolgsDIP4h/EI1LbULSBtNo2qFsWGcuHThszaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxaRoqu80dv0kaspmqQo+Y+8U4oCPOiJNZOUlWm6VVWqKyKCrwrlJO8qhyP88Xzj4Amq6mku0rDugjf7Xjt6aH0c0Do84HOvj+RjX0aNmoOW8BgaS9+hVLOQlLmoqQ25EUWa44y27SyqbU1XB/VMBDMDbUAbz2Rm/df0HG/wjgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E8AudygG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390ec7c2d40so3979886f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 06:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741098060; x=1741702860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ms6VvRKF2/scJw/4d4p+LMJvPrNkvNdjmSsh3E28KZE=;
        b=E8AudygGA6kl/SnAigYZxaY2awxM+/KB3t4h3QnKZ0ci5XMo5GNsRk51+Y3IoCw4h9
         Sjl2P149LjWMzsbBdmSHxRsCD3wgxDxjBlpQvaIXaJM6/Mj0HYC+/Dz5QQbCJ6P4ftnz
         VxIf14P8cOp1tQ96Wmm5re7UbMqR76TDO+BhsCFOFjnXuLBkzd5pgW2nJnCXxwmT7f5D
         5uQQtpLyyYrRefnQt42hvBZqSRPpauRsUCxGF08syADa0TGI8leWM6ugDl5Vh0zHnfjD
         TS8kXlWEO6iL4eHkeHcONGd7D2AcLiDDC4h//X+y32K3IdxHLVAWumI3Vnf+Y5sApFp+
         CQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741098060; x=1741702860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms6VvRKF2/scJw/4d4p+LMJvPrNkvNdjmSsh3E28KZE=;
        b=MbLPzpfl755Vd8fCprLKTqhmZGg/BBsN019Vp57uBuLsjL9o11sp7ucZuDH+L4xUil
         nrLm64mafAysDt2G2eBTOrY0Pm/8uHmxXx7VPNv1juYLHPjBollFT1xDlzfE1kk3q3XD
         QW3l6lNT8tPq8Ta8t7/tN8JuRCbTgLUfRePxZcynx8vJnnY9L1Ke3kFIfgnTgD+uyGVF
         Keez46fxlM3aoQj0p0Ssnou2HFexqpJ5uSYLivOwB3NBAXq7gpey8dhQ0XHjPfS134cb
         nuKkeCG9kOSzZ3sHKw04mFZu8F4gn3qu5AkrRkQVlNqPOeWJh2I6W6x7fQvOCsaUPQDr
         edsw==
X-Forwarded-Encrypted: i=1; AJvYcCVRFOlkXijROKkY86GJj6PQprEIcElPDHU7xs4o8UKrdbgWF0YtQi87xsvVAMWOB1nWhNBjWLKyHpMLFp7CFY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAPJCC0Mz6W5YG0Mgwj1QFphZSvWqERK3H+JZVAYBkr3tXhda2
	u9TX4PkpEj0vd8fy/iwz2h7YrgK8E7UAkvtvj7W0EMklzNfp+XsNCaLwAwZCJKAa9SJ+FPqJKXl
	uYOQ=
X-Gm-Gg: ASbGncssLbjqWBpi0DFNEI5UND6/1G5pzC7zwdXsGQ9c7JBDXuCDzMuCsIk+2DudacE
	/X9BGWtetNy7mlwaue8IxnLBlN9urZ9/aaXYlrY48v2eSiy4HhQLzW3LAUqkt8JvjoBH2jBYl8p
	omFKp3zAFvv0svPCjK+UwiOvamAdapDIdYTVtIohjUAmzsNtyCa4wdsB47TFvudQSEkRt8MqtS3
	Q4i3q/iVfj2NhCkFLWinKpsl/J8cU9g7f6obKyU25dFSuh84QBJ2B2q7HMj6/n6b8HwztzFnu/A
	KtXofK564yd5sFnHzL9VXvbR8C1qJBEbvIQiu7YbHh+q/T8=
X-Google-Smtp-Source: AGHT+IGxVfqxe0VMsjPEv2lBj+Xq4zB28tu8D9cFC/yICb/A0zbJo5FOmgG0O+CLVTr2S/kHcSjcLw==
X-Received: by 2002:a05:6000:188c:b0:38d:e15e:17e1 with SMTP id ffacd0b85a97d-390ec7c6743mr14760832f8f.10.1741098060456;
        Tue, 04 Mar 2025 06:21:00 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc1a7429csm75810925e9.36.2025.03.04.06.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:21:00 -0800 (PST)
Date: Tue, 4 Mar 2025 15:20:58 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: selftests: cgroup: Failures =?utf-8?B?4oCTIFRpbWVvdXQ=?=
 =?utf-8?Q?s?= & OOM Issues Analysis
Message-ID: <exfgzrx7u3s77gsoxqzm4zhb6mr7aysc2vzus5ob3zeadkm7ut@3dzkywk3jfqr>
References: <CA+G9fYsrfM62=kr=q1nu_Nx9-sTHQw-6A-3OWkiqgs4JiKzvgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcfzwvt6k4h7ttan"
Content-Disposition: inline
In-Reply-To: <CA+G9fYsrfM62=kr=q1nu_Nx9-sTHQw-6A-3OWkiqgs4JiKzvgA@mail.gmail.com>


--pcfzwvt6k4h7ttan
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: selftests: cgroup: Failures =?utf-8?B?4oCTIFRpbWVvdXQ=?=
 =?utf-8?Q?s?= & OOM Issues Analysis
MIME-Version: 1.0

Hello Naresh.

On Tue, Mar 04, 2025 at 05:26:45PM +0530, Naresh Kamboju <naresh.kamboju@li=
naro.org> wrote:
> As part of LKFT=E2=80=99s re-validation of known issues, we have observed=
 that
> the selftests: cgroup suite is consistently failing across almost all
> LKFT-supported devices due to:
>  - Test timeouts (45 seconds limit reached)
>  - OOM-killer invocation

Thanks for reporting the issues with the tests.

> ## Key Questions for Discussion:
>  - Would it be beneficial to increase the test timeout to ~180 seconds
>    to allow sufficient execution time?

That depends.

test_cpu has some lenghtier checks and they can in sum surpass 45s,
it'd might be better to shorten them (withing precision margin) instead
of prolonging the limit.

test_kmem -- it shouldn't take so long, if anything I'd suspect
/proc/kpagecgroup -- are your systems larger than 100GiB of memory
(that's my rough estimate for this reads to take above the limit)?

(Are there any other timeouts?)

OOM -- some tests are supposed to trigger memcg OOM.

>  - Should we enhance logging to explicitly print failure reasons when a
>    test fails?

These tests are useful when run by developers them_selves_. In such a
case it's handy to obtain more info running them understrace (since
they're so simple).

>  - Are there any missing dependencies that could be causing these failure=
s?
>      Note: The required selftests/cgroup/config options were included in
>      LKFT's build and test plans.

The deps are rather minimal, only some coreutils (cgroup selftests
should be covered by e.g. this list [1]).



>=20
> ## Devices Affected:
> The following DUTs consistently experience these failures:
>   -  dragonboard-410c (arm64)
>   -  dragonboard-845c (arm64)
>   -  e850-96 (arm64)
>   -  juno-r2 (arm64)
>   -  qemu-arm64 (arm64)
>   -  qemu-armv7
>   -  qemu-x86_64
>   -  rk3399-rock-pi-4b (arm64)
>   -  x15 (arm)
>   -  x86_64
>=20
> Regression Analysis:
>  - New regression? No (these failures have been observed for months/years=
).

Actually, I noticed test_memcontrol failure yesterday (with ~mainline
kernel) but I remember they used to work also rather recently. I haven't
got time to look into that but at least that one may be a regression (in
code or test).

>  - Reproducibility? Yes, the failures occur consistently.

+/- as that may depend no nr_cpus or totalram.

>  - Test suite affected? selftests: cgroup (timeouts and OOM-related failu=
res).


Michal

--pcfzwvt6k4h7ttan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8cMRwAKCRAt3Wney77B
SRJxAP9P0BNVxEJoSyAW/NxnhKcTEwUAjxmtBvpDFXXGLv3UfwEA7O8iCYplvX71
vK94Co38SIprgRkg1DKFarv2l4U5OQg=
=OykF
-----END PGP SIGNATURE-----

--pcfzwvt6k4h7ttan--

