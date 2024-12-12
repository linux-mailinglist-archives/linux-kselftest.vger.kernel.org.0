Return-Path: <linux-kselftest+bounces-23252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E562F9EE51C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 12:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38035282BDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFB120B807;
	Thu, 12 Dec 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk4cN6NT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F10290F;
	Thu, 12 Dec 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003192; cv=none; b=D1WhYIxdTZoHNbzk7Dritcxd2cOFkF9Lg+sFLntwx/QsCYaR/b7RJzUhmonk0H00AuKarFGuPde2s2vV5s9ZvKruC5ciaaWJCwm7FGkaJhG/8CCZmnvJQZ2LLW9UHVPXE4Ql7ChrHX5NvGZp06djURVSvZxk5ofOYwClzN6jlFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003192; c=relaxed/simple;
	bh=bI+wKiXz+sjwrXGi9W8a7W5Mqy1BmYf1t3VdgNU8DeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuriFMTmMCYGFY5vWEAAmAcYP+pCrUtAjc9sCyoDOD/qbWQmPXew66usHcENnAJP9w5Pj59ID1c34Ut0qmCDkPVuRb8RfGWjEh3W/oROo7JO5NAc/b+G+spRkoJtDHNQNiBKjiopUqJ7bfGUOWZ7sWh06TWtChSMM5Z8PRcL9WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk4cN6NT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E3BC4CED4;
	Thu, 12 Dec 2024 11:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003192;
	bh=bI+wKiXz+sjwrXGi9W8a7W5Mqy1BmYf1t3VdgNU8DeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dk4cN6NTIy2EYGlRKrBLcv8H25jiVzfMj+JOS+5UV3Q6EiSqkPEvqWwc4w7MMOylo
	 o/DH1ZUOM8UkfVfIMd8gN+z5G39uY4kSPbqjN0lMevSrvzs2PdHwguxSMWXz9iotEZ
	 fYn4pz+J2iIQ/1lgydd29BcI5TNCjOmJKnikWAt9Tb+fyCcnrx09XtDBlbChM335dM
	 HrQdGVJx336iJSTYcIjD4CK6/EAgIbf4dbr84Bke5HKdqxBf6+R96Ui1nSMOOZ99y+
	 Iq88KR0ONVsEbL9CB3TywJTtsVQQEYqAaO3jDnvPe+bz34WzQ4fbOIY+mH8/YUVutW
	 48SY8Dk2mTf1w==
Date: Thu, 12 Dec 2024 11:33:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/9] arm64/sysreg: Update ID_AA64ISAR3_EL1 to DDI0601
 2024-09
Message-ID: <248dea18-bfad-4ec9-9a7d-5c87c7f48c84@sirena.org.uk>
References: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
 <20241203-arm64-2024-dpisa-v3-2-a6c78b1aa297@kernel.org>
 <20241210170953.GB16075@willie-the-truck>
 <b859bdcd-7343-4d53-9f3a-f374deca725a@sirena.org.uk>
 <20241211224015.GB17836@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cChPOZNdbKWWH8te"
Content-Disposition: inline
In-Reply-To: <20241211224015.GB17836@willie-the-truck>
X-Cookie: All is fear in love and war.


--cChPOZNdbKWWH8te
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 11, 2024 at 10:40:15PM +0000, Will Deacon wrote:
> On Tue, Dec 10, 2024 at 06:43:05PM +0000, Mark Brown wrote:

> > Yes, the issues here are not technical ones.  Though there are some
> > complications -  eg, IIRC the XML doesn't encode the signedness of
> > fields like we do and there's areas where we've deliberately diverged.
> > Given the amount of review I end up having to do of sysreg changes your
> > reasoning is especially apparent to me.  I've passed this feedback on
> > (again).

> One thing we _could_ do is have a tool (in-tree) that takes two copies
> of the sysreg file (i.e. before and after applying a diff) along with a
> copy of the XML and, for the the new fields being added, shows how the
> XML represents those compared to the diff. It should then be relatively
> straightforward to flag the use of an unallocated encoding (like we had
> here) and also things like assigning a field name to a RES0 region.

> So this wouldn't be generating the patches from the XML, but more like
> using the XML as an oracle in a linter.

That'd be useful, yes - unfortunately I think that's still something I
can't work on myself at the moment for the above mentioned non-technical
reasons.

--cChPOZNdbKWWH8te
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdayfAACgkQJNaLcl1U
h9Bo9wf8DjHXD65QAeLiB/WQD6MKK2q1vhHifOtaL+lp7nN90YodMEadPyi1bgC0
7kGLdiSnfBrGie39QosDOpgsd8FrzTWBLbvr7eoAWBjuhNZlFmz0S1sMsZ5eESte
qFb6DrYC1LG2RbGC6TUy+CUW8gxKmzVYlbES/17f1lrq3v1yH5QSKhZNu2o1uSIJ
FneGYGH2H23/rX8qM+0QVZlRgiRkUN1AFmlZPOol5YpDCwgppQH4VBMoRgg/kKVs
4tOIqWWuDBnQ0thBa4o7EeoN+qS7iHl7mEzTkbHxse7zMe+mg3Ffs8jgdtxN55In
2Rt9VoKhAE5mbSmIlPhZUM08qgHkBA==
=OGMy
-----END PGP SIGNATURE-----

--cChPOZNdbKWWH8te--

