Return-Path: <linux-kselftest+bounces-38997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C660BB26C5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 18:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 230D27BB285
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 16:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C716253B52;
	Thu, 14 Aug 2025 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HXY5mizg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201F3221FDD
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188348; cv=none; b=Wj2d7fcDMV8+SKWwtkOkp2LCHX0lLw5sBQ/45IwkQEL6WcyW2JydDh2SNmfZo8B8BncIZjxNZ8+i6rLt7pfBbuq54cDFBmMh1kY2b+5tDqCyUgFSE4/sp1yQiFpaWfTVq6A5bv6PQaxvql+CinxhLTOhMFaKkpDxGDLbhJzeT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188348; c=relaxed/simple;
	bh=Ho+veYR4eyGRfH1azB8q/7OlJZNmty5Qrjgwiyi3Xg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS54R3zAwwsRqQbD4/OwhoHfHsKpSlvu+bYDL/lD7n4iPKueS3+S4YA7M3YubwYApedeyeUAzluAzPS97syLsf8bucTCni8xzzK6Duvpail04Pv0lpa+lOBmGY9wzz3jo6lMucxA8UKetpQrOQwRyvVGgqqpfsh/Aux/5VHIFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HXY5mizg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9dc55d84bso819053f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 09:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755188344; x=1755793144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HuOCifwiCgtVaXq13iP0/DzbcIxLYQgeVMC4irOhBlc=;
        b=HXY5mizgSnqX/9f9KrPI/qoc5C7cdTrnjK5vvx5Kv+3fyqAENbKYnnaxUsjPkpghEi
         qbEBDCTJ7lEZabzz/cdPja8q6SMVYTlHtxAp5jbEpj5Y3onxZyxFU9lM393QNffoTggi
         Y4FNzYwqo0W3wzOZatLrijEf8mFX0JTYVgzfrmpO2tKBSTgCAXO3NjtOhaCqxhxeO3NQ
         603wi5ylLfBR1Z93BgEdGUy9Z2+QT86jOMYlyuPJBlFPeX07ZcZN0P4afkt7JQ5HTbY5
         +dJOtdpJPpWf9SH1ijCHNq5GUOO/y1rcPwON2ZxcvU5AWjQt7zRwwsA/nxTBDQmLT91Q
         Yg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188344; x=1755793144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuOCifwiCgtVaXq13iP0/DzbcIxLYQgeVMC4irOhBlc=;
        b=QF6ZXhM4KvfCOlsA/57J+vNOF2BFkRd50backueIfpaOXfqHD5iQX3djNKAlPrHTMv
         Il79qouRCM1vHDSrIVwQL9RMT+2UjQpYfQC7OO+hvXyNeVyygWcoIRQQ3IwWh0HPSNhq
         zlM1HgKGuUd+gKjcCICErnJv9yeaVfaTyliW7dUzpD7td9rjnsMDLZLpOv/Ef3uZtQn1
         A3rU04JlivNju4HewPz/0pbS4M8Hrc7r0yJ+pmT7QeZxiVOpASnWVVhF4PJPwMNfEClY
         5anAcY8JvQcFHr/A/EbSKxlDbqqp0RMz7VEkZC1JAfmltbVFqSP2EnrVIX2fQlEqu/7i
         Vvsg==
X-Forwarded-Encrypted: i=1; AJvYcCUT7fAdzrYlUfPGa6OQD+iwYvo6IG/vNNH1ciBn4jLxVl5+BjCRgRm5+TrN/bjv4HQVxm4gVzzza+inXaf4iKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1gBBAi4SErhNDTZzrsNMmi2Y9M6Fvq9LCvU3TgCbBtm9vgciE
	WURtHFvg6kfeRSn9XZ8VC2An+g4ehrc21n9LYsDpwRKXuIEZXcNwWAf6L6/Wd7/ryb4=
X-Gm-Gg: ASbGnctCnnLQ/rEga5B0RaEhDE67Ro85LmB8Sj1iLBYagrqM1J4g/Vsu+Dq2Jz8Gg7E
	heKyLpikmYB3SV8gOehiKFzGKRV1tjsVgLFRHkn7m9rzJWrrsTlVvB7NSHP0n8+fOKN87zSPGyB
	wbtKuwR4t5I+a5WHl7X7VbxgWOlbDrZPYjX5LtLdi9ttx6UR0X0S9ghxo9n8THmrLE3pP+uMZd1
	CzuRbgVqLbeqsFEyUnvmD7I0cGUp8hZlmeGpgOjmnBKRmjx/q0Inh9NLLjBbq4MDkKZLlOBkxCE
	vafyCX7MAMvs2Owrx412BMg+Dfiz69LmfRxcFmGzlQzYYlegrY1CmWCVrNKCwF9uo02jgHrQdX1
	a2/NIEjJKc0pTG68GPaCHEINP8J2N1uwYcD86gZBVTw==
X-Google-Smtp-Source: AGHT+IGlnyGS7gqwhS8wePjPiIB3BXgNNdrFKFsrbP/+U+ucgIevSjzoucdoLb5MypgU2mfoLh8AuQ==
X-Received: by 2002:a5d:5d0c:0:b0:3a5:57b7:cd7b with SMTP id ffacd0b85a97d-3b9e417d3c4mr3055770f8f.22.1755188344333;
        Thu, 14 Aug 2025 09:19:04 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf8f12c95sm28381883b3a.2.2025.08.14.09.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:19:03 -0700 (PDT)
Date: Thu, 14 Aug 2025 18:18:47 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, kernel-team@android.com, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/2] cgroup: selftests: Add tests for freezer time
Message-ID: <ftydqeu3zxmgdvkz6f4jrf4qyrs72ar7jc4j3khlkyi4mditfe@g62znohovca7>
References: <20250805032940.3587891-4-ynaffit@google.com>
 <20250805032940.3587891-6-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v5h3r47ybde3pttq"
Content-Disposition: inline
In-Reply-To: <20250805032940.3587891-6-ynaffit@google.com>


--v5h3r47ybde3pttq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v3 2/2] cgroup: selftests: Add tests for freezer time
MIME-Version: 1.0

On Mon, Aug 04, 2025 at 08:29:42PM -0700, Tiffany Yang <ynaffit@google.com>=
 wrote:

> +static int test_cgfreezer_time_empty(const char *root)
> +{
> +	int ret =3D KSFT_FAIL;
> +	char *cgroup =3D NULL;
> +	long prev, curr;
> +	int i;
> +
> +	cgroup =3D cg_name(root, "cg_time_test_empty");
> +	if (!cgroup)
> +		goto cleanup;
> +
> +	/*
> +	 * 1) Create an empty cgroup and check that its freeze time
> +	 *    is 0.
> +	 */
> +	if (cg_create(cgroup))
> +		goto cleanup;
> +
> +	curr =3D cg_check_freezetime(cgroup);
> +	if (curr) {
> +		if (curr < 0)
> +			ret =3D KSFT_SKIP;
> +		else
> +			debug("Expect time (%ld) to be 0\n", curr);
> +
> +		goto cleanup;
> +	}

	if (curr < 0) {
		ret =3D KSFT_SKIP;
		goto cleanup;
	}
	if (curr > 0) {
		debug("Expect time (%ld) to be 0\n", curr);
		goto cleanup;
	}

I might like the version with less indentation and explicit guards. It's
only minor stylistic issue.

> +
> +	/*
> +	 * 2) Freeze the cgroup. Check that its freeze time is
> +	 *    larger than 0.
> +	 */
> +	if (cg_freeze_nowait(cgroup, true))
> +		goto cleanup;
> +	prev =3D curr;
> +	curr =3D cg_check_freezetime(cgroup);
> +	if (curr <=3D prev) {

Here and...
> +		debug("Expect time (%ld) > 0\n", curr);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * 3) Sleep for 100 us. Check that the freeze time is at
> +	 *    least 100 us larger than it was at 2).
> +	 */
> +	usleep(100);
> +	prev =3D curr;
> +	curr =3D cg_check_freezetime(cgroup);
> +	if ((curr - prev) < 100) {

=2E..here
I'm slightly worried it may cause test flakiness on systems with too
coarse clock granularity.

Is the first check anyhow meaningful? (I think it's only as strong as
checking return value of the preceding write(2) to cgroup.freeze.)

Would it compromise your use case if the latter check was at least
1000=C2=A0=CE=BCs (based on other usleeps in cgroup selftests)? (Ditto for =
other
100 =CE=BCs checks.)

Or does anything guarantee the minimal precision in common selftest
environments?


Thanks,
Michal


--v5h3r47ybde3pttq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ4MZQAKCRB+PQLnlNv4
CFeIAQDNXGSJkd5sGTNDbnfBkIAZKUtkNR40R5JJ6cwupQR+EAEA1wI9dZb4+3WT
4dkEz1/Y/JbIGOGtHc4u42WZJG9hiQ8=
=kmva
-----END PGP SIGNATURE-----

--v5h3r47ybde3pttq--

