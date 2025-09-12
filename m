Return-Path: <linux-kselftest+bounces-41414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11F9B55561
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 19:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD05AC553B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E6F322A22;
	Fri, 12 Sep 2025 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9JrERn+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242BE32252C;
	Fri, 12 Sep 2025 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757697251; cv=none; b=eqmgPgYk1EjPWPnuvNsF0/peTEow66n7Yak3xyNEmL8P+kqTwUdUKxflEqXnx1V9uLpBa0UUhM8ODR0tZoeMGqVxMPjQczixtqpflH+IWSObZ+dDAuy3NmXfftLWZnmHXcg0w/vI8Bv9aqsNtZhupURYwUlBY64ll2dGdrc9YwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757697251; c=relaxed/simple;
	bh=pwqpv0OMmuh14dvqJoXmhqMPOebR0cDuIlzyHJCB7FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXfNt3y5OUQLJtD1iecRLgHHJZ4fLnwPPDE1CMA2htg3S6jmr6FZWXWIq+etSrRRo9l8ZPzeeBQCZ10GlFdbyc0XGUBpQa0HbWR3bVjwBLxNQjDzTxgrz5U0vf7t4PHwgh2DUmfSt4SeFPgTNiMnX0NJjn1tG1ufMpPy+BY7Chg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9JrERn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DD9C4CEF1;
	Fri, 12 Sep 2025 17:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757697250;
	bh=pwqpv0OMmuh14dvqJoXmhqMPOebR0cDuIlzyHJCB7FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W9JrERn+KoIxQfx9Yk0iMN3Gomju4XAAwgpdQ2MqGJwl30FZw0g9IcS4YMSSyAzq9
	 eimaUJjSJFo4d58GUD6bp9JkOpFKojq2tM0WkyPCc2mvTz3XejGtlnO2AzvjQkQOnJ
	 0z51JO3q7zfPY1JKO5QCa2k0sZlqvZdV7KTX9xg5EVi+0Do7ZjCXnl7LBDjal2fiHt
	 nKe6ZM7o5Aasih3d/b/BuG8CHqy/W8lUn9B42OhDzOspQUm0sy17LBMh7BeLKOOhkX
	 A1m2D8dwOnrZDyHlogQdH1NOxF13JK3PujUqc2kQutHyk6ZODhgyydyVOJetYbxbl5
	 ypKNA6bFCEoTA==
Date: Fri, 12 Sep 2025 18:14:07 +0100
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
Subject: Re: [PATCH v16 2/6] KVM: arm64: Manage GCS access and registers for
 guests
Message-ID: <aMRU3zCRpA4Zuj0L@finisterre.sirena.org.uk>
References: <20250912-arm64-gcs-v16-0-6435e5ec37db@kernel.org>
 <20250912-arm64-gcs-v16-2-6435e5ec37db@kernel.org>
 <865xdndgpw.wl-maz@kernel.org>
 <aMRLYBWfDFiIB7wx@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DpzIhk4kEi/ksl0o"
Content-Disposition: inline
In-Reply-To: <aMRLYBWfDFiIB7wx@finisterre.sirena.org.uk>
X-Cookie: Filmed before a live audience.


--DpzIhk4kEi/ksl0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2025 at 05:33:39PM +0100, Mark Brown wrote:
> On Fri, Sep 12, 2025 at 12:59:23PM +0100, Marc Zyngier wrote:

> > Just like the previous version, you're missing the accessors that
> > would be this table useful. Meaning that the vcpu_read_sys_reg() and
> > vcpu_write_sys_reg() accessors will fail for all 4 GSC registers.

> Just to confirm, this is __vcpu_{read,write}_sysreg()?

Sorry, that should have been __vcpu_{read,write}_sys_reg_{to,from}_cpu()
*sigh*

--DpzIhk4kEi/ksl0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjEVNYACgkQJNaLcl1U
h9C9MAf/ZDTHvq/toZNl1zFIlYCxa5MviqirC4jCkD4bApiu8FXEn37o5QLHvV1a
TScrRejLtHsbWbAOcXqDXGKodfclNDTwGvxbqbHCwHhYLWbr6p2D1vAa48iYJIhv
gnKnhDqBNSvx4LrNuFwaUJyPhich4VOvTjmSvJPJU8oCLAdPfTECSghGmFnW0FEG
LdO+0s95tByeppfr9prmKGg8/ctwQ10rlmfVFavH6fvx7zfpFoVrSMFKpzp6z8Hq
uqT918mBpk8+wcxaGuheKypl/OQVBGv8OjFpY191RQkSB2PvLelMr2QEG1T6CzeS
9/DQ8sbVFO1rzwaGCpfVMWJL+EKxkA==
=YqIz
-----END PGP SIGNATURE-----

--DpzIhk4kEi/ksl0o--

