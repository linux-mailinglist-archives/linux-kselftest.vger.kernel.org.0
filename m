Return-Path: <linux-kselftest+bounces-5010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7E385B693
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 10:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B1C1F25016
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28EA5F555;
	Tue, 20 Feb 2024 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="rKWXKsfJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410745C8E9;
	Tue, 20 Feb 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419794; cv=none; b=Fjq7aGPWiFhdFHNM3n49Zhf7b+SJTKh6gSlvn3bx5CAXHO5pov7JxSB5QjNjuKkuw9acav8itiFT3E+7s+7fqbIaQzLF9dVoenZIyoEGyMLt37Xlr1uRT2W/CG4TejkN+4NbNFeIizRpo7jK8uy4Q4WoNM63Ow4lFn00frtoAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419794; c=relaxed/simple;
	bh=JceG0EdglJthXyZekPMBQ1UrnXqMgMpzZET8QvST5k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuxhyBJflhToNLG1nug+m4a7ywuBBZ9rSvd2Vi385mkr7npd7ZE0P1idihuRWlMssDjKQsRyR4FA1+t9s70iYuQXmMARZiT6yobTOPaSivFD66AWzSPI8O031W40kA3oUx8mIyMuptOCKJpHvQWlVEpI02bUQs7D6zmaX2YeS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=rKWXKsfJ; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id BFA16635B056;
	Tue, 20 Feb 2024 10:03:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1708419782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yqtS9OdSkKTkmUyYkJaIlBJaviSDyIFjBjSZbNBn07E=;
	b=rKWXKsfJ8o3lefY6RKvN3UuSJvK4ybWAncvyjvNfyyN3kLsGnjZ83xEQS73j9psgeqrgkK
	od6Es83fuZI/nffi5iSKfYGZbM42qtRvc/g0R8KJeyxuZwXXpBG9u1Vz/Ltlnl3PwWw6gK
	KMNOqhDkuF3LM6aMFmWKNtuiOeAlwTs=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael@kernel.org, Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
Cc: Perry.Yuan@amd.com, Xiaojian.Du@amd.com, alexander.deucher@amd.com,
 bp@alien8.de, deepak.sharma@amd.com, li.meng@amd.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-pm@vger.kernel.org,
 mario.limonciello@amd.com, nathan.fontenot@amd.com,
 rafael.j.wysocki@intel.com, ray.huang@amd.com, shimmer.huang@amd.com,
 skhan@linuxfoundation.org, viresh.kumar@linaro.org, x86@kernel.org,
 Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
Subject:
 Re: [PATCH] [PATCH] amd_pstate: fix erroneous highest_perf value on some CPUs
Date: Tue, 20 Feb 2024 10:02:48 +0100
Message-ID: <3868832.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20240218161435.38312-2-lucasleeeeeeeee@gmail.com>
References:
 <CAJZ5v0hRk3tME7yeC+1r0RM4-oPPrnSu2=JCsOshBbJp_Nq2Hg@mail.gmail.com>
 <20240218161435.38312-1-lucasleeeeeeeee@gmail.com>
 <20240218161435.38312-2-lucasleeeeeeeee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13532597.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart13532597.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael@kernel.org, Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
Date: Tue, 20 Feb 2024 10:02:48 +0100
Message-ID: <3868832.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20240218161435.38312-2-lucasleeeeeeeee@gmail.com>
MIME-Version: 1.0

Hello.

On ned=C4=9Ble 18. =C3=BAnora 2024 17:10:31 CET Lucas Lee Jing Yi wrote:
> On a Ryzen 7840HS the highest_perf value is 196, not 166 as AMD assumed.
> This leads to the advertised max clock speed to only be 4.35ghz instead o=
f 5.14ghz , leading to a large degradation in performance.
>=20
> Fix the broken assumption and revert back to the old logic for getting hi=
ghest_perf.
>=20
> TEST:
> Geekbench 6 Before Patch:
> Single Core:	2325 (-22%)!
> Multi Core:	11335 (-10%)
>=20
> Geekbench 6 AFTER Patch:
> Single Core:	2635
> Multi Core:	12487
>=20
> Signed-off-by: Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 08e112444c27..54df68773620 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -50,7 +50,6 @@
> =20
>  #define AMD_PSTATE_TRANSITION_LATENCY	20000
>  #define AMD_PSTATE_TRANSITION_DELAY	1000
> -#define AMD_PSTATE_PREFCORE_THRESHOLD	166
> =20
>  /*
>   * TODO: We need more time to fine tune processors with shared memory so=
lution
> @@ -299,15 +298,12 @@ static int pstate_init_perf(struct amd_cpudata *cpu=
data)
>  				     &cap1);
>  	if (ret)
>  		return ret;
> -
> -	/* For platforms that do not support the preferred core feature, the
> -	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> -	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> -	 * the default max perf.
> +=20
> +	/* Some CPUs have different highest_perf from others, it is safer=20
> +	 * to read it than to assume some erroneous value, leading to performan=
ce issues.
>  	 */
> -	if (cpudata->hw_prefcore)
> -		highest_perf =3D AMD_PSTATE_PREFCORE_THRESHOLD;
> -	else
> +	highest_perf =3D amd_get_highest_perf();
> +	if(highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
>  		highest_perf =3D AMD_CPPC_HIGHEST_PERF(cap1);
> =20
>  	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> @@ -329,9 +325,11 @@ static int cppc_init_perf(struct amd_cpudata *cpudat=
a)
>  	if (ret)
>  		return ret;
> =20
> -	if (cpudata->hw_prefcore)
> -		highest_perf =3D AMD_PSTATE_PREFCORE_THRESHOLD;
> -	else
> +	/* Some CPUs have different highest_perf from others, it is safer=20
> +	 * to read it than to assume some erroneous value, leading to performan=
ce issues.
> +	 */
> +	highest_perf =3D amd_get_highest_perf();
> +	if(highest_perf > cppc_perf.highest_perf)
>  		highest_perf =3D cppc_perf.highest_perf;
> =20
>  	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>=20

Please pay attention to trailing whitespaces, adding whitespaces to blank l=
ines, and whitespaces between `if` and opening `(`.

`scripts/checkpatch.pl` may help you with that.

Thank you.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart13532597.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmXUargACgkQil/iNcg8
M0uKvBAA75ErCLUkoBjqYUXvYnxdCiWChCP3YbRF+TZpge2SRBrdHkP37tb0h5xj
/YidBER2zYHcqz5PKoflu54fCIQod0VkX33TQ8HkXjm4tytT75WKs6invTYQOMOD
wrZmWRw5AvsjKNxUGuhtg2sp3CJjigzk7E8JUdeE2L07Wo5//npN2T4uNZAzI3wA
MX6ACRYwwh8yY4iIRTv2PJZfZATo69iRnNbo7UlLAgKqQA+GOsF+jwio2d41O+ZE
5xUfZQDx8DV7Bg/nbhTR0gg0Il3SwsxBg5lIeeLxJch7Rex6tI/Qhj6M0QCPViEA
w+ZyB9yMNhwy5yHH0t3KiSBB3ONy7CI0Umw+xriblr0iWRhlDCktI4/PkGhu6QfB
CLNk2Xrh8zYVUuZ91YBkxE0HEWxRBlI8c5RdMvS2qYqjdBgvdR8n1ZRVfDioIUHc
GCrQSI3/bkfvZDgHJIqFJAQTwS2o4SLUHiNgbrB0V66V9RRvqTlWbqIdztXgWhKi
egIAdiyKMEckiymU9Cqh8Q34Voaf2+o7mOE3Hj1l5s2NCBxk4fWoYJP1uRRF+wZm
FRQ/DuT2EgDDynHHLybnLl5Fy2LAEFh5cdWdZum8aOuCmruEsG06srI6j8qJ1FLk
NjH/oCDfkMemqkVHUFmOO4W9MgY89I4UVQuZGaYDAg2vTDY8+0E=
=MiiV
-----END PGP SIGNATURE-----

--nextPart13532597.O9o76ZdvQC--




