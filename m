Return-Path: <linux-kselftest+bounces-19149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCED992FB7
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11389B23EA1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5D41D1748;
	Mon,  7 Oct 2024 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJgyKYyi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD21E49E;
	Mon,  7 Oct 2024 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312334; cv=none; b=G/jsy8qcw2LZd84uUQ9dC08TWNwll4Lg0N1+NFk8AHMthDJe8ORBs+OcgbybPmQaPUQtmmVSXjHC4nc9URXYYa5IoDNBONfd4au5dPexb+KkDCujkPxCUunh5sv6GK5JXACyK7SkrsnhG8/K4InfL55bti7YvIXYm2t2xVZo2EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312334; c=relaxed/simple;
	bh=3FB+fM1SR/GBiOLKvg963NUMpjWXq1ClTwQgLNpRUjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdE7DWhTm/RKXjfpzEyc9ARgtNldzQkM15atN07IMUaYhdEGaECrL3VOlnDIhGzx6NfH7HeHe+tr5/9JtOM7RgXVxQiUDiCMqFjAv/JONXeLGVo38u/yOf7/MFjuLxXPFOPtx0eS6XLMA7tJuuVngFPxrjFwDn2o8HJMv8dEC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJgyKYyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EBCC4CEC6;
	Mon,  7 Oct 2024 14:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728312333;
	bh=3FB+fM1SR/GBiOLKvg963NUMpjWXq1ClTwQgLNpRUjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJgyKYyi6E6PdkP2KFIApIt1zGeY44HkEypv1U0uHgtenil12+iN0S09ZXgJZRCKE
	 pggRteEFcZ5N39BBicIygOlg7ulAJZXGCQzY0nDlsCB3FKK+RojoMO49mRq/ZXgpzv
	 Qv55RWc0k00hQjSORbrH0W+Ry/bvL+T19NW4Ntpuw6mv7CApwGtz4T9t1NVheik3I8
	 rD/chLiY4YSiDJuEEpBBTxFMbdlJmweWoxgjHw6rj7fA+/l0FREY78hgDdaLI/5QkF
	 DHmUaiBg4J2+Y4GBc3ceYC1PMCqkbWvJaVQL7qcHPgueLjZIhOYAH1rLdyJi+vlgHx
	 kUc95jN2jT22A==
Date: Mon, 7 Oct 2024 15:45:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
	oleg@redhat.com, mingo@kernel.org, tglx@linutronix.de,
	mark.rutland@arm.com, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
	aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, sj@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
Message-ID: <ZwPz-MXhbJMY6-ZU@finisterre.sirena.org.uk>
References: <806e4be0-4b1f-4818-806f-a844d952d54e@arm.com>
 <fff2b685-a7a5-4260-a293-f2abf55d9ce4@linuxfoundation.org>
 <514713eb-235c-40ee-8c25-f1f3e1ca7f7a@arm.com>
 <d5dc1bd9-4473-405f-99fc-192691f41c4f@linuxfoundation.org>
 <0b3af60f-0449-48a1-b228-f26618b9d50a@arm.com>
 <fcdbd8bc-9986-497e-8de4-86d3e619ca73@linuxfoundation.org>
 <03c5b10d-b81c-4074-9c27-8ffc8c7fc84a@arm.com>
 <cb2f88e0-8e31-43a0-a5ea-03f0ab05417e@linuxfoundation.org>
 <e497c022-549f-4adf-83f8-8f8c54d7c998@arm.com>
 <5400ac3c-f730-4ede-a35a-7d9cc79bf997@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zI1WmKFLB9+n5Rbe"
Content-Disposition: inline
In-Reply-To: <5400ac3c-f730-4ede-a35a-7d9cc79bf997@arm.com>
X-Cookie: Editing is a rewording activity.


--zI1WmKFLB9+n5Rbe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 07, 2024 at 10:07:24AM +0530, Dev Jain wrote:
> On 9/16/24 09:28, Dev Jain wrote:

> > Gentle ping, adding all x86 maintainers and the x86 list, in case they
> > missed.

> Gentle ping

Given that this was posted prior to the merge window you should probably
resend it at this point.

--zI1WmKFLB9+n5Rbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcD8/gACgkQJNaLcl1U
h9Ddrgf/ecjm5cqThpdVO55ZcWo1Tl68da7MT8BBf2KnrlBHpFW2DgVjvVt5//Rw
UcXrkPb/CFPPs8buUCeMSuj23bgcT0557mL45gETXpkZ+favSEItVl7ypm7Ty5zE
HjOpfdvAvmYwBiqAbM2lNQBCMe6VnIuKR/czVd5Ir+VG7M+D/xn875ZdPB+/J04q
I87Hl7jhVvh0UeniDGNtHUSMefM1Wn9HIMhiiGbA6IlrarG1hQGtPYwlpfnP8Daq
9hNSO29t/CJ7XvWQOaZE9Rvd+VzBqVKvSmRNGF3x/rAGpkYVioJELxznPlAEVnp7
qcD0nYKoX370q1qULPMpJzySnGXhnQ==
=3dxY
-----END PGP SIGNATURE-----

--zI1WmKFLB9+n5Rbe--

