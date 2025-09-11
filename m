Return-Path: <linux-kselftest+bounces-41267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804E8B53D6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 23:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABAA566399
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 21:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B325A2C3;
	Thu, 11 Sep 2025 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN10WaBm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948DB67F;
	Thu, 11 Sep 2025 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624510; cv=none; b=NRsk4hEXK1lR7FH1+Wpo81Qv2m6mYZroLpmq6ggQvB4do+//Ch2nolx+xZorMRlR+EBa56h7nOIcvt++nvHQdU6NN1ei772yjyKVA5hDR5+0wfkWrqV+I4KSp7ykn1Jph0lFD8h/Ndh2kuFJDdOTD9Kzhs2kqDvN1DF4ncv/sxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624510; c=relaxed/simple;
	bh=TnKAQTc7XGro9Bv4vH66mq9n6MJAi4rgkbNv8BEGp+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1zLRcuHVHMhdvqZXkwvobphr9s1asLnTdwDAqsS08Cp2HsXTFGGJ17nlfc29Ghw5ztJ7wiDoz86WoLZ68buVkzzl3U1Ba5NMhngkav5euqyubK4I4Or/4kX4PsrLF+m7QneQWbA7ENWLM6bocBCHT53jVHcJuLx6JPN+c0kR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AN10WaBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B037BC4CEF0;
	Thu, 11 Sep 2025 21:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757624509;
	bh=TnKAQTc7XGro9Bv4vH66mq9n6MJAi4rgkbNv8BEGp+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AN10WaBmgi+RXVhno4BE+S55iu8EnUJWANOscD0dQ6FBxV/ctEQVofudWCJwFvmYz
	 yHPg5tSaSWUx6VV0B9WLKe/r1DEIB/s/ZQzAYrLYI+9MYzktAza/scMSJPqdAShmcD
	 FjvHHKPc2HInQOfx8yNRu5co5MSNyDCw1nlwlRtmn6mWypUk0rA041rgWjLVzVHzVU
	 qB+YNPEfYu7Nmx09q/in82XKv8qqYdWxMUGlH662MHmpSEY9L8iTa7ikRtEuayM39v
	 tIsr/voF7PQtSbBM9rqYsf0uaB8mQTyPY0bibuuwH4xta1CG8bj4iosC3tDqwWQIf/
	 5vtty7su7aKYA==
Date: Thu, 11 Sep 2025 22:01:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: next-20250909: selftests/arm64/gcs/basic-gcs.c:390:30: error:
 use of undeclared identifier 'HWCAP_GCS'
Message-ID: <a275fc97-24d8-477d-b7aa-79c2d61d93ad@sirena.org.uk>
References: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vzK/nDSaTzO/04Bu"
Content-Disposition: inline
In-Reply-To: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com>
X-Cookie: Your domestic life may be harmonious.


--vzK/nDSaTzO/04Bu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:48:47AM +0530, Naresh Kamboju wrote:
> The following build warnings / errors noticed on arm64 defconfig
> with clang-20 and gcc-13 toolchains on the Linux next-20250909
> till next-20250911 tag while building selftests/arm64.
>=20
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? yes
>=20
> First seen on  next-20250909
>  Good: next-20250908
>  Bad: next-20250909 till next-20250911
>=20
> Test regression: next-20250909:
> selftests/arm64/gcs/basic-gcs.c:390:30: error: use of undeclared
> identifier 'HWCAP_GCS'

This will be due to Thomas Wei=DFschuh's nolibc changes which went in
during that time period and did change the program to use nolibc's
getauxval, presumably that's broken with this clang version or
something?

--vzK/nDSaTzO/04Bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjDOLcACgkQJNaLcl1U
h9BI/Qf9EK0NgoUZ4q96FEARPBhR/Va4JSSHIcl2WyWNfMuLGBi4fv3F6r3GQlnS
/pv7buWYB/3owgjNjmJTDIjTCuqoaGSyoAsIQJCac6gAi1Fn99E6XQ6fP8dGHNAd
A1H/dQsANu/5zzLxFZe2AHwBL9xrvWr55ZnhoL7R9C0eU+u3HbNzoiTr0sJvtOti
vxDis4GP1Jc2b7W9R/t9iE7czTRIDSM3CbCzWn4PwSm5AkifhWzvgV18719x+NQB
Sx/0X+5x2BcGr5a7RTc+3BhJvFg59eRvi6MrPHHTvGbebxSJ1Y0M6Jucix8WMQEI
oUOM7SJHlvm4AIZS+P2HD2EsCC5Yuw==
=zR3h
-----END PGP SIGNATURE-----

--vzK/nDSaTzO/04Bu--

