Return-Path: <linux-kselftest+bounces-19113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C7899173F
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0D31C21531
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FFF1509BF;
	Sat,  5 Oct 2024 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7TcEjn8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C090813A24E;
	Sat,  5 Oct 2024 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728137664; cv=none; b=reYuA9FiW8nHhIQK5HbNcr8VKaPaIi2jGiuCcc7qUQa2N4dAPgHV80EzXq5nj5PRcUhpwl9UITJ46idTcP67WJSC1pEPuWWK0hBuBecKNf+3xblJXJhDkMHNStJ/5tb4jyp6Cg7Nxvj7j5Nfx3Afd07k0tqr4DxpjCkNEqGmcoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728137664; c=relaxed/simple;
	bh=rqef6z37tTRS6xVZHzzMQ/a+6aNMrJcvG4GllSXvWS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHXriUiJgSYQBAATMSJjFyRbsmUsDp2PoGxIKB/hAtM/m41AQp1J+rqcPc/eLwVzKyZNM0cCwnlDTlUBeMckoZ6HV2G3etRbelroDRiWz5M8H0l9D23D0F4709VYwWJPbX7N41p7jc2GAY+ObLgrLDv21VeO0Yy44VluEMsa/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7TcEjn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CA5C4CEC2;
	Sat,  5 Oct 2024 14:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728137664;
	bh=rqef6z37tTRS6xVZHzzMQ/a+6aNMrJcvG4GllSXvWS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7TcEjn8vFeumYvp6IIucFIxiiMAlL73sGyNIMejwA9XAkTnJQlGNW2etsK/nBnCR
	 SZaLPqInXxdTnv8Mn9l7jbCdIVQqsgsWnmEPtBoWV+xyn3Z2RMt4SZ8Q//tuGtLgMv
	 8mYJ/pRbiLFtd88PwQTmQL78rnmjGz4kvOXb9wL6GkoRqcdlHDKnVlCrWsRv+CUiTC
	 1xfmBxVABQxxVLEX0W1w+R6goHfzu2E0Tym/TxE17bLtHotIRL9adSm88mjLqkbmC6
	 qhZNgEC9yfa+WJJxbqom00vngtl/kaTbbgP2Oc7CO+KuVmSg7Qb+5rGjAEaSmvvGNb
	 2QiQMCVta4G/g==
Date: Sat, 5 Oct 2024 15:14:21 +0100
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
Subject: Re: [PATCH v14 4/5] KVM: arm64: Set PSTATE.EXLOCK when entering an
 exception
Message-ID: <ZwFJvV7lrFStWD-r@finisterre.sirena.org.uk>
References: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
 <20241005-arm64-gcs-v14-4-59060cd6092b@kernel.org>
 <87h69qvi9y.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7srDnRXLH2tW0fM5"
Content-Disposition: inline
In-Reply-To: <87h69qvi9y.wl-maz@kernel.org>
X-Cookie: Editing is a rewording activity.


--7srDnRXLH2tW0fM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 05, 2024 at 01:36:09PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > +	// PSTATE.EXLOCK is set to 0 upon any exception to a higher
> > +	// EL, or to GCSCR_ELx.EXLOCKEN for an exception to the same
> > +	// exception level.  See ARM DDI 0487 RWTXBY, D.1.3.2 in K.a.
> > +	if (kvm_has_gcs(vcpu->kvm) &&
> > +	    (target_mode & PSR_EL_MASK) == (mode & PSR_EL_MASK)) {
> > +		u64 gcscr = __vcpu_read_sys_reg(vcpu, GCSCR_EL1);

> No, please. This only works by luck when a guest has AArch32 EL0, and
> creates more havoc on a NV guest. In general, this PSR_EL_MASK creates
> more problem than anything else, and doesn't fit the rest of the code.

You say luck, I say careful architecture definition but sure.

> So this needs to:
> - explicitly only apply to exceptions from AArch64
> - handle exception from EL2, since this helper already deals with that

> The latter point of course means introducing GCSCR_EL2 (and everything
> that depends on it, such as the trap handling).

For clarity, which trap handling specifically?

--7srDnRXLH2tW0fM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcBSb0ACgkQJNaLcl1U
h9CARwf/W/4NPsmf9qhqoOTzd0rZbHoSTiPcidtGSwoehyH7lZAHiN7aWC4VGzZ/
NNnT/s8zL3SKw38Ow9EFIt0/kNVlc6yjdo8r9RVT5TYMAl/noRDS12MM8BgK/c8E
LzXHbOcoxrsSdFAGS3ORw/cVCRRQffw5RTSdkUsArXU5RXxzRHdPHCBn8tu2FlWx
kPnkUzm7jfeRldHf0SIMtwEo+Uki1Yk9wWPBbAkna0ToTU1dRsGr4E8VLUDYajYv
iWmLuEhoQMji7UO8XB+PcjkydMU40e/SnjFztV+M+gsCKruAxMrI0jXOCwhmT7qB
me4Ik1c9rgceNAXrkR7zawTtNDgr3Q==
=S3+a
-----END PGP SIGNATURE-----

--7srDnRXLH2tW0fM5--

