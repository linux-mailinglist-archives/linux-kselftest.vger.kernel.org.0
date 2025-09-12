Return-Path: <linux-kselftest+bounces-41404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7C5B554B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 18:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FAB7C68D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7A131AF3F;
	Fri, 12 Sep 2025 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKDuNMrg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD06221FCA;
	Fri, 12 Sep 2025 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694819; cv=none; b=KdT3ocXK5AB9aXLne58Ex6ecsFie8Xh065xTLNxwvSlmkwPjcGDxjs1V2y7QoU/U/H23Y4AhFYD60BauBswEP9u06u9x7hnvhtZnaBhQu+mIshfgxybWjMWmm69HDxsTGexKUR5FPlQtD3aC223GmoIx/oiRrwHBTy8JMTFiC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694819; c=relaxed/simple;
	bh=40D3azo32aA432DW1jWO97dUK4u+gf4msaD08ReAdlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuBN9U3csWgOMCyTS3W8MP0xzSSMjKA3y7b0boJrAFUgkEIue8mOBmKmZO+IekRPnrfzghZpJUzhxemCU7/kj/Hl7TlXVCFC72tKy+0K95mAvEEm0gT8c0BS1HfPzGiaqvvclxQMZvLFerjNzNFyXlkg+xu/ctvx1YoWJzxGrD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKDuNMrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B2CC4CEF1;
	Fri, 12 Sep 2025 16:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757694819;
	bh=40D3azo32aA432DW1jWO97dUK4u+gf4msaD08ReAdlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKDuNMrgspTKbgKs/S3dV0K/yVqGkd+Mc06d0z1Hs9jytEautBcOG9mVnAMSOfi7T
	 HvBDXePdazel5390VyNYnn/xv3+rn/vW2s6bgyLc/IBSG2NMWAFLMUDaes15fp2p0N
	 DkZoRUnpad0gCJrmECdXdY+uE0FKo/3nLDL4jUbpZAgPBYKFVoYz9+TYtZl+8BESRn
	 TeTVTxn0gytq7iBJd+TKhBxB9lhbqH31KQ7rRiqjzPOZope7CwxDgO2So/ErWAEal1
	 gbJlZYEJ3DZPftPQBBosopqREX0gQnLwu1Wt5kw6lkociLd/HvQWradNN7SZ2zxMbp
	 0tyAHTMyymsNQ==
Date: Fri, 12 Sep 2025 17:33:36 +0100
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
Message-ID: <aMRLYBWfDFiIB7wx@finisterre.sirena.org.uk>
References: <20250912-arm64-gcs-v16-0-6435e5ec37db@kernel.org>
 <20250912-arm64-gcs-v16-2-6435e5ec37db@kernel.org>
 <865xdndgpw.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bzAqF05U+jmCCGjc"
Content-Disposition: inline
In-Reply-To: <865xdndgpw.wl-maz@kernel.org>
X-Cookie: Filmed before a live audience.


--bzAqF05U+jmCCGjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2025 at 12:59:23PM +0100, Marc Zyngier wrote:
> On Fri, 12 Sep 2025 10:25:28 +0100,
> Mark Brown <broonie@kernel.org> wrote:

> >  		MAPPED_EL2_SYSREG(PIR_EL2,     PIR_EL1,     NULL	     );
> >  		MAPPED_EL2_SYSREG(PIRE0_EL2,   PIRE0_EL1,   NULL	     );
> >  		MAPPED_EL2_SYSREG(POR_EL2,     POR_EL1,     NULL	     );
> > +		MAPPED_EL2_SYSREG(GCSCR_EL2,   GCSCR_EL1,   NULL             );
> > +		MAPPED_EL2_SYSREG(GCSPR_EL2,   GCSPR_EL1,   NULL             );
> >  		MAPPED_EL2_SYSREG(AMAIR_EL2,   AMAIR_EL1,   NULL	     );
> >  		MAPPED_EL2_SYSREG(ELR_EL2,     ELR_EL1,	    NULL	     );
> >  		MAPPED_EL2_SYSREG(SPSR_EL2,    SPSR_EL1,    NULL	     );

> Just like the previous version, you're missing the accessors that
> would be this table useful. Meaning that the vcpu_read_sys_reg() and
> vcpu_write_sys_reg() accessors will fail for all 4 GSC registers.

Just to confirm, this is __vcpu_{read,write}_sysreg()?

Sorry, I missed your comment about this on the prior version due to UI
confusion with my mail cllent.  My mistake.

--bzAqF05U+jmCCGjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjES10ACgkQJNaLcl1U
h9AzDgf/duT63XwRmgWz0snIItmYAaIOhyi9DSxNDPK1rp7/ouyg/0hMk2fa5glv
1ILW6aKRp8AdJeKuqbRnCdJ+G5dxtmtOV6BmkxcK7bPorQYP51Xlat7OqsLF56R2
vRT2MwbM6VDt9cyp08gbJ6TVLrbHfwYz9XEr19HsrDqRYyCojz41cGf7QzPbKIBz
6HeUZQHSZnsf6Ov7DIsZons63MmVdvYgKAv29I5tLca+TlnwVoumfVCGNeM1BB/4
/9yhS+DQB47AvKDMX2jI3MzaQ3n3NLL7pYUF7c5K3e7uiToZZZRjxm2hTvPYGzrS
I0ulFq9qRSGr6EH8H02+ru7NA5yWOA==
=rXPS
-----END PGP SIGNATURE-----

--bzAqF05U+jmCCGjc--

