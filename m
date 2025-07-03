Return-Path: <linux-kselftest+bounces-36460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2200EAF7D23
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 18:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14ECF1C84A0A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C760F23BCE7;
	Thu,  3 Jul 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TPvsPcQB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F1623A99D
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Jul 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558334; cv=none; b=ZRzfmzwyjf7BYcCRDgBH0rS4/C0u0nYgLOzRClrnPqwO2FtVIViN73MQ8bBnT92KWSHjEZaSxRlbuWz1seKZ/xQGLX1JrD2R1KY++HcakSqJkIglEz4DxxsPfFfF51LhGzIC+H6gWYtSJLgMH4cUJtsreiX6oZ5XWBw10y1Uxak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558334; c=relaxed/simple;
	bh=6TojZ78eEbxhRsuBRUuBMZf6SEaQ1t+9yVSxoCPVVQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGo7zdlPNSkGn3R5vHcpJsZTtTTsqAjjR6AvOWccl+Jo7toGhblEHKtTCq7OnqKQfjOtiFBJypnuZ+tklAGTIcVt2AiiXABZQD19Ygyoak2Bl2gqlLiN/UoffURLnUeEnX5lDJx/sspZB8p81jdUtlf4595wcmpXTV0XZdFc1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TPvsPcQB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4530921461aso246725e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Jul 2025 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751558331; x=1752163131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CJaN7nbaO6lmM2Mxzm86rsAdldbhCFrvDwkgjL03x1A=;
        b=TPvsPcQBtsQ/mbEPgBEIzslCmWo230SVP/NmsQNJz+otsARABUPjGwzNMu4ONh1Off
         EjrcP58YtOg/8W9znosD54jKFb212u3Viv1NjYeL4ExzXpn4SEfKPNlVx8LOYUK2wWSF
         ofvz6Dlx/MMaOGtDmcBrqH60iCn88qW76sSkmF1bHyE9ulCdplj0zDDJgq9Kp44jwKbz
         7fKAjNWPY0ZdS8uSZLvcrg2ry5uJmxJdz38beSMc+KzaF1gcqI1xeTq87ikFKe8eIOGi
         hZUcDZlJHgA8hp+A5oubB916oBAv/L8i3FztnlQHLKsATbAL23kHJcXkd9hFBv3jLkvB
         0CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751558331; x=1752163131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJaN7nbaO6lmM2Mxzm86rsAdldbhCFrvDwkgjL03x1A=;
        b=oCnd3fQuHvEglhFx+v2FFNv6xnwtTKgCz5uDbKlfD1udM68RfUKphGZoHUpWIJh26+
         yN7E2Gp0gscKUbFqOr/CFK1Ur08TuHKu/FgPFNJgx7rX4kkSD0/Hb9FXBOpsgASOxKW/
         CEcGAliD2CvNgoYH8w8TQC6dprQlBjwaU03b2uwOsY3CmnKpKH9XgYdflGE/+FV+saSA
         O8LC/uf6ROc7da+THcMObaMCIIDiHH5KDTts50Tuv62ozkQsBtC+htHL/PWvz9Bpb+n9
         PfkDJ1tu8vWXGgPpKAwrWuTLC4Muz66N+2d5RDtVFuRSY9tkctfxM+ktegnVPXLkUfCw
         g04Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5+G0AQcRxmm0xU8YGOEpvzK5EoUmLoUqIc7+NesGlgB0+7A+4bpXBOBXXEsTZZMyarrFcXWTE1RLMLXkR99o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9aTatDG6CQaICcupHLAedOe6R6V6oYvLA3Mw0vQbjjQu8Hbxx
	0SEephOMI6S9bpAhh4BiS71Up5jgwY6znLRMmigYoaY7KCl3AeeRWUlfll0J8uFtBO0=
X-Gm-Gg: ASbGncvTsdZRkBYc7/etWqKhtVXQQEMUmkDBmJ0w9Sa8fITmhnB5hqJ7D70a6UxxumK
	1K/gh5c5vA/9DLHt8BIEKtewmzMIW1mYBrdhso1Q0nrQHLLH/cPXBH23ctnsb1j+UKCGkffy6iY
	PtERbFFqwK600aWeCCU85lAc26NuZo9lN5vxGr2MkJscRdd6RDgbqQVEfZOdUqngbwZ/cXErkhh
	yZ7k6g8kv9xTUdtgZmGHebIOike3+sDdkFilf92taB5IkgZ9FRc/qhLic9sxB3/nBc47y+SBJzT
	vmAZaI/eiSHZbkV/VgORB21POgVoXrtcEA5muOkRCUlMkKMpFug3OriNs1EbSznW
X-Google-Smtp-Source: AGHT+IGOdqwh+prx1CMvKrozB3yHTxkvomqeSkFHf9OzqxVK+h2PONAOl4dn1TVwcAb/HP3myCfYHA==
X-Received: by 2002:a05:600c:820d:b0:442:f4a3:b5f2 with SMTP id 5b1f17b1804b1-454ab368d5dmr35870815e9.6.1751558330555;
        Thu, 03 Jul 2025 08:58:50 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9be5bbfsm29835925e9.34.2025.07.03.08.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:58:50 -0700 (PDT)
Date: Thu, 3 Jul 2025 17:58:48 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v2] selftests/cgroup: improve the accuracy of cpu.max
 tests
Message-ID: <l3sal6zkvo4lqnfs6fepxytnrmqmqwfvtxudnjm53oigtuatpd@7czfeursgwyh>
References: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
 <20250703120325.2905314-1-shashank.mahadasyam@sony.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ctwb4begphfg7q3l"
Content-Disposition: inline
In-Reply-To: <20250703120325.2905314-1-shashank.mahadasyam@sony.com>


--ctwb4begphfg7q3l
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] selftests/cgroup: improve the accuracy of cpu.max
 tests
MIME-Version: 1.0

On Thu, Jul 03, 2025 at 09:03:20PM +0900, Shashank Balaji <shashank.mahadas=
yam@sony.com> wrote:
> Current cpu.max tests (both the normal one and the nested one) are inaccu=
rate.
>=20
> They setup cpu.max with 1000 us quota and the default period (100,000 us).
> A cpu hog is run for a duration of 1s as per wall clock time. This corres=
ponds
> to 10 periods, hence an expected usage of 10,000 us. We want the measured
> usage (as per cpu.stat) to be close to 10,000 us.
>=20
> Previously, this approximate equality test was done by
> `!values_close(usage_usec, duration_usec, 95)`: if the absolute
> difference between usage_usec and duration_usec is greater than 95% of
> their sum, then we pass. This is problematic for two reasons:
>=20
> 1. Semantics: When one sees `values_close` they expect the error
>    percentage to be some small number, not 95. The intent behind using
> `values_close` is lost by using a high error percent such as 95. The
> intent it's actually going for is "values far".
>=20
> 2. Bound too wide: The condition translates to the following expression:
>=20
> 	|usage_usec - duration_usec| > (usage_usec + duration_usec)*0.95
>=20
>   	0.05*duration_usec > 1.95*usage_usec (usage < duration)
>=20
> 	usage_usec < 0.0257*duration_usec =3D 25,641 us
>=20
>    So, this condition passes as long as usage_usec is lower than 25,641
> us, while all we want is for it to be close to 10,000 us.
>=20
> Fix this by explicitly calcuating the expected usage duration based on the
> configured quota, default period, and the duration, and compare usage_usec
> and expected_usage_usec using values_close() with a 10% error margin.
>=20
> Also, use snprintf to get the quota string to write to cpu.max instead of
> hardcoding the quota, ensuring a single source of truth.
>=20
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
>=20
> ---
>=20
> Changes in v2:
> - Incorporate Michal's suggestions:
> 	- Merge two patches into one
> 	- Generate the quota string from the variable instead of hardcoding it
> 	- Use values_close() instead of labs()
> 	- Explicitly calculate expected_usage_usec
> - v1: https://lore.kernel.org/all/20250701-kselftest-cgroup-fix-cpu-max-v=
1-0-049507ad6832@sony.com/
> ---
>  tools/testing/selftests/cgroup/test_cpu.c | 63 ++++++++++++++++-------
>  1 file changed, 43 insertions(+), 20 deletions(-)


> -	user_usec =3D cg_read_key_long(cpucg, "cpu.stat", "user_usec");
> -	if (user_usec <=3D 0)
> +	if (usage_usec <=3D 0)
>  		goto cleanup;
> =20
> -	if (user_usec >=3D expected_usage_usec)
> -		goto cleanup;

I think this was a meaningful check. Not sure if dropped accidentally or
on purpose w/out explanation.

After that's addressed, feel free to add
Acked-by: Michal Koutn=FD <mkoutny@suse.com>


--ctwb4begphfg7q3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaGaotgAKCRB+PQLnlNv4
CEdaAP0XHWsChnbaP5kR0bs2fgV1QmnWmul24yC8kEn2cDlzUAD8C2S+dXKJJUMt
We9vCI1hRxJLPl7E7xFaqmhjWJ8dxQo=
=xHRi
-----END PGP SIGNATURE-----

--ctwb4begphfg7q3l--

