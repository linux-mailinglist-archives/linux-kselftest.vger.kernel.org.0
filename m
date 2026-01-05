Return-Path: <linux-kselftest+bounces-48220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B1CF4D8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 17:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DED5F3285F79
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5F1314B87;
	Mon,  5 Jan 2026 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPfguw5w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABC330DEC1;
	Mon,  5 Jan 2026 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631556; cv=none; b=rPy+npUcl7b0z0YlKfduPyD2VKOuYaNZiVye3kc5/rB92l7cVw3zAtIdveyuCZoxtLQyKS38503dPJA2oUPgkF0/pm1GxVQHhijgGj4Tv/IGzDpTjSBkrmX3lLuIclziIt6VTkmpQo6O+gvRQsB+Zz8tE8x5CANKF5bTS7rt5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631556; c=relaxed/simple;
	bh=hRalsOfosJADEMwrxolfPeTiI+tRS96R5nKkLXSFV/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyYwDY8kHKAGltiEDCXX2vHHSaHeQT0vPUf5TlZEkhZIiQQU3F5H/NaT9NpQ9SjlwsolpRc0u+vdvGd8GdGyM2hBO9ZowKWJnQ+18b62Z50lmSiisgEU1mfqGlocXsaxwYAqjn3M43R/zFRvevNlYtm/GwrfYZRwNo53LUDobxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPfguw5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B224C116D0;
	Mon,  5 Jan 2026 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767631555;
	bh=hRalsOfosJADEMwrxolfPeTiI+tRS96R5nKkLXSFV/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPfguw5wUf0G5rvgYSSC+g28McqYU8gqXVj8JYZ+U8ufWLR7fto+11FmxnlkVAxpl
	 N7iSNf2UWBzRnGn+E1W12qH2/H+zIhgltq1o+HRYJA6RrIeL5Jyqv/WVux6VeBIM2j
	 uTYiGXzfhMmrH2o7mFMzPfqVGZQgD/acDW0xD67Fy5HXACXJKk0PCRSJkfEAZ7vkdL
	 BCDDhWuwbUSAnGqGGrgJpAIFoGeZ6aPJtbJeZwPKvP7KL2exfNnBx8jZ52jx1XNasD
	 Ut3JWJH/qncBbGk9Tdbkd2sW1v+zKNwNRvPUnuM/jhFQAxKfXQv+6T59eyayyKb1py
	 7Z/KNGAwnelPg==
Date: Mon, 5 Jan 2026 16:45:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Ben Horgan <ben.horgan@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] KVM: selftests: arm64: Skip all 32 bit IDs when
 set_id_regs is aarch64 only
Message-ID: <90fb25bd-fa79-4980-902b-497346a3e6d5@sirena.org.uk>
References: <20251219-kvm-arm64-set-id-regs-aarch64-v3-0-bfa474ec3218@kernel.org>
 <20251219-kvm-arm64-set-id-regs-aarch64-v3-4-bfa474ec3218@kernel.org>
 <363e440d-4e29-4286-ade4-b4be2f856859@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jUgQ9HrVrHCgvOyK"
Content-Disposition: inline
In-Reply-To: <363e440d-4e29-4286-ade4-b4be2f856859@arm.com>
X-Cookie: So many women


--jUgQ9HrVrHCgvOyK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 02, 2026 at 02:50:07PM +0000, Ben Horgan wrote:
> On 12/19/25 19:28, Mark Brown wrote:

> > +			if (aarch64_only && sys_reg_CRm(reg_id) < 4) {
> > +				ksft_test_result_skip("%s value seen in guest\n",
> > +						      get_reg_name(reg_id));
> > +				break;
> > +			}
> > +

> Unnecessary? The decision for which regs are testing is made in
> guest_code().

The guest code has a fixed list of registers it reads blindly and we
skip the write for these so our expected value won't be something we
explicitly set.  The actual test is done here in the host code and it
seems both more maintainable to keep the skip adjacent to the live test
and clearer to be more explicit about nothing actually being tested.

> > +	if (aarch64_only && sys_reg_CRm(encoding) < 4) {

> Doesn't this exclude more registers than needed? E.g. MIDR?

Yes, I took this test from somewhere without thinking about it properly
- it's been so long I can't remember but it was clearly wrong in this
context.  I'll update.

--jUgQ9HrVrHCgvOyK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlb6r0ACgkQJNaLcl1U
h9B3Wwf9Ei81DVRAliYp+f2cGXjW5ohJtH7FHEVkRHuPfeDT/8tWAFsmGjASwsQv
4Xm4CiVybCEghpj+Ld9vTaF0LYm1yaNVkTPl0EuIWBxMXBxI2OaXhqZ2+N8tzhQ7
vdBXg9vaumylp81y7RDEeaHySwWg7ZtydV4zNMoq6bRkq02iwcuuDuC6hYwUSOFR
hpr3yKDBfZ/kDHzZ3IUFrKiGQQCKuHtZ0FZgBPP0syz9rMVmxBaAAyKPGNmEtuvv
iH5iQy58lagYJfMrRFTxYnAg4w0jN9VIFjiSxabF213G+fIyx0qtpw6X2SiZBof9
e6MtF7Jgpg4sNydpvFXSxryixWYU3A==
=HcmY
-----END PGP SIGNATURE-----

--jUgQ9HrVrHCgvOyK--

