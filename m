Return-Path: <linux-kselftest+bounces-19109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E49916F0
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 15:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2E61F22784
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 13:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93B414EC47;
	Sat,  5 Oct 2024 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utC19Vmt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCE139578;
	Sat,  5 Oct 2024 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728133722; cv=none; b=LX3tkoDeXYZv796LwpPKUKpaBcZEa8713ODjNWy+tXSwu2TlAzYiNG5dMNuCV2FnHzJm0dO8G8hiUCcJ+yyph9uDvlAInm2Sv4qw21OVi3nfwYqxW4TzbyhhpP97wgEAyXOMkXBpoMXLCyUdEdUupXT3pKsHu6wrul0/iRMGe5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728133722; c=relaxed/simple;
	bh=OehJ0O89f+iqXPi9LRqnKDAU2cxxrfwIrYGp9bcDgUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9KLHX8/uFslOjRvMDjd6mevVfIfrdFtL8ubpRTQMtGAB2wf+XTnYLYl0GWAXrmN3A9CS8dxM1d433wTBJWVhJPk3/OHoR1m8wQx/fDZTEWB+lxW7SCzHkNNj4jkOXICN7kg2pTmMrXkNcO7jgnw1vWEUaGFZfyhxpSI7rl27gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utC19Vmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C059DC4CEC2;
	Sat,  5 Oct 2024 13:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728133722;
	bh=OehJ0O89f+iqXPi9LRqnKDAU2cxxrfwIrYGp9bcDgUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=utC19VmtYWaZpQCAUe68NNnKbI4ACFrsbMCRWM3kPzcsZkHKM3edeT0cL+J+QSxfs
	 8qNeA3YJEoet4z02oC8D/NzNQkY9j5ePact4qallu1QunaC/OvC/F0tf7hmsLxq+zb
	 7vPTeXsolPhjcyLGEtvHl+XsMCnaAnCMTqHIyizNEOBF41ZOW4SOI1+2YaXnI5iPMa
	 InflVz7/5HmMTqTNB6/ND/ub/eumHzX5G9BwxDNyzgCnpF4024G8sycV9VmwUdeXgl
	 U/hR1BTItonY8YplsRAb9Bmz7APXKp0H50k6uy3l/q0sm2dSS+2uoGnR3nPayYKX/G
	 cDISZkafgle/A==
Date: Sat, 5 Oct 2024 14:08:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 3/5] KVM: arm64: Manage GCS access and registers for
 guests
Message-ID: <ZwE6V9cqf7jD1rTc@finisterre.sirena.org.uk>
References: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
 <20241005-arm64-gcs-v14-3-59060cd6092b@kernel.org>
 <87iku6vl4z.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Zl5x4KmDRvfIeyQ"
Content-Disposition: inline
In-Reply-To: <87iku6vl4z.wl-maz@kernel.org>
X-Cookie: Editing is a rewording activity.


--0Zl5x4KmDRvfIeyQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 05, 2024 at 12:34:20PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > +	if (!kvm_has_gcs(kvm)) {
> > +		kvm->arch.fgu[HFGxTR_GROUP] |=3D (HFGxTR_EL2_nGCS_EL0 |
> > +						HFGxTR_EL2_nGCS_EL1);
> > +		kvm->arch.fgu[HFGITR_GROUP] |=3D (HFGITR_EL2_nGCSEPP |
> > +						HFGITR_EL2_nGCSSTR_EL1 |
> > +						HFGITR_EL2_nGCSPUSHM_EL1);

> Where is the handling of traps resulting of HFGITR_EL2.nGCSSTR_EL1?

These will trap with an EC of 0x2d which isn't known so I was expecting
this to get handled in the same way as for example a return of false
=66rom kvm_hyp_handle_fpsimd() for SVE when unsupported, or for the
simiarly unknown SME EC, currently.  I gather from your comment that
you're instead expecting to see an explicit exit handler for this EC
that just injects the UNDEF directly?

--0Zl5x4KmDRvfIeyQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcBOlYACgkQJNaLcl1U
h9BPNgf+NKmTsL3+8wUVfE0aTQRrfj4Erqq1BDE4dbvUjwaSbqFx2JUxrfPNaIZJ
j9+kfFc0HH9nUA4g33py2M8TZwQbvjalv7zQYqoZn1JFg2yi16SUD9BieooOtGIs
tIBvdWV6F8YHte2wvinDjBe9Zhxo/mJ4T90vMPUKwcsq1yP5i+XXs9jlfxX9bdAi
dMhs0VxWtc7WwaIR2Q68A+oUinqGk63rBnViO0i45u0y/mOb+OQKssk9/KjRRcZH
/joGYIpGp5k677g63M3bcB2BBonPiPkTo9+YR1cl2Ib96xxWYywNGR6s9+DqFZr2
wssYGEdqveRLKJkK+lN8TcPqWLYPSA==
=JcmO
-----END PGP SIGNATURE-----

--0Zl5x4KmDRvfIeyQ--

