Return-Path: <linux-kselftest+bounces-24001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F359A04456
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 16:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683883A6BBB
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3084A1F3D47;
	Tue,  7 Jan 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNClHMxv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A81F37A6;
	Tue,  7 Jan 2025 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263600; cv=none; b=ev7VZlkr9jKqqQy/mcTuY4UukWe22TktAAedXMLWSgKJEhdR7zkp4g4YAmq7aebFTQh+NSg+hDEKEySS7tFGNUFOj7R4TCVQlSR97k/GwbCcpzaoD3aG5JQtidGI2khNuNjWznkcLl2VN182Fe/5pVmwpb8ThHbVRVVx5QvtZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263600; c=relaxed/simple;
	bh=XLhFtGuCY7Ucnc0+mL9iU40HruI6bI2yyylWOOmbdBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhDB1tkn1mflr2H/cEHBt97lpMCEqNwDzidJhGf5JFGgL+buVdcVnz6vpirjnFP6iomNB9E0oIXJCjgn2nhqclunxi0Iww7IkjtpEMG/aYi/fgRk59ucmWoIOViWdABnwJKLnxhEnKcCL7l2GyC8fmzLGXWLostFnxfaTn5BF3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNClHMxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07739C4CED6;
	Tue,  7 Jan 2025 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736263599;
	bh=XLhFtGuCY7Ucnc0+mL9iU40HruI6bI2yyylWOOmbdBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNClHMxv6p/dLY5+H6IrLV2GgRuM3AJ/jXNOKbmh33jnrWRFFQTJRzGLC7ksuXZVr
	 JrlJdHSYeddVvb2snAryytnQjmfznMiFcphfrjgxlkW0pa54qHmm9+ThhTd9PkCyuC
	 DVF4cOdR4Vmgj6qG1I3IMwUkw5ueHEEZd5vZoU7TCDjToaHxX7vAMvMwlgNJ4yKEY6
	 5G6Av0R9yKRrRBIQF9QEx7XhWVNDsGd2jD5RTXNjInIuyjIHhlBh6sYnc7844RBc4e
	 3RTjNz891V50dItetB3/UFc6WIu/IjqkjjZIfJebKUq4PuAopbtQEeIFsS4dSFy38n
	 4D1v16/V6aZog==
Date: Tue, 7 Jan 2025 15:26:34 +0000
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
Subject: Re: [PATCH v4 5/9] arm64/sysreg: Update ID_AA64SMFR0_EL1 to DDI0601
 2024-09
Message-ID: <9e93418d-ef66-42bb-b276-9f92da2596fa@sirena.org.uk>
References: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
 <20241211-arm64-2024-dpisa-v4-5-0fd403876df2@kernel.org>
 <20250107151323.GA7368@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WU010yCTaQZA793v"
Content-Disposition: inline
In-Reply-To: <20250107151323.GA7368@willie-the-truck>
X-Cookie: PIZZA!!


--WU010yCTaQZA793v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 07, 2025 at 03:13:24PM +0000, Will Deacon wrote:
> On Wed, Dec 11, 2024 at 01:02:50AM +0000, Mark Brown wrote:

> > -Res0	27:0
> > +UnsignedEnum	27	SF8MM8
> > +	0b0	NI
> > +	0b1	IMP
> > +EndEnum
> > +UnsignedEnum	26	SF8MM4
> > +	0b0	NI
> > +	0b1	IMP
> > +EndEnum

> afaict, bits 27 and 26 are still RES0 in all the documentation I can
> find...

They're in the 2024-09 XML release here:

   https://developer.arm.com/documentation/ddi0601/2024-09/AArch64-Registers/ID-AA64SMFR0-EL1--SME-Feature-ID-Register-0?lang=en

which was current at the time the series was sent but I see that they've
been removed in the 2024-12 release which came out later, right at the
end of last year:

   https://developer.arm.com/documentation/ddi0601/2024-12/AArch64-Registers/ID-AA64SMFR0-EL1--SME-Feature-ID-Register-0?lang=en

so we should just remove these.  I'll respin (or should I do it
incrementally to save on re-review of the rest of it?).

--WU010yCTaQZA793v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmd9R6kACgkQJNaLcl1U
h9D72Af+M48CMQ4TIZD35lakuJUDfvdH5F0JSqhHzYmkjf4C8IuujOjIMolmgRbc
ZVBjkcuQj6Q89kTchmXRgQ5msV9oDWEZht9yXHpg26dRcRYxIBI0dOC/knLGJSji
HMA4+I+lxNv0GU+nAW7nnNjkqZ8NmsSP9YPGmp/cSDtShgg3yUiNE1jwh5PWwK+D
5qKhNoowGtcoILJg6EqRooDviDutHZmmgfH+MxnoV5jnxhQWWeQgeNXs/lP3615F
M91mZMSCYmGzlqvdkWBq8byLYqBbqBLeceJ/xVOcVzrIc7HsMXVPBiCsp+D+4HmK
uohnU4LbTo4AJZv5QR0/BH/Cisw7PA==
=lqNc
-----END PGP SIGNATURE-----

--WU010yCTaQZA793v--

