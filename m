Return-Path: <linux-kselftest+bounces-19111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E786991712
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 15:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D588528360F
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B9614BFA2;
	Sat,  5 Oct 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMUixHR0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC03513C8F6;
	Sat,  5 Oct 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728136093; cv=none; b=WslOEayv2/3MD+xRULCJxwZwyLj7yKRLybyr1X87TJTPVRq8BWqCWGvzWP1/NFaBi4l3YXUVWu6yMVsCmeTAb+hD4sFBLbzekD4p3lDGVvxuJH8rjvo41CYdonTG4CUp4A6fNYtcNWgOkuiTPR/zvSPDc5vNr+2v1lxSr9Vc9sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728136093; c=relaxed/simple;
	bh=n8s7hIwQ/x5IgIyFZ4FVm1VE3nnhRGEjX2SMzNPVERw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVMqO38PA5Jv/TSe818tUCOqE+AY6UnyqL2fEFUxe259GbylgFK3Grav0ZW+r+QMUXVsXiSmt4aZVe0t7Zc9MrJwwe/Hgajyui5L2O0vIeicbGMHYVNOqoYCIxSLx015btpn0/fXZ+YYVBncTAfGSOfb1cQoc5f7Zqbclut0esw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMUixHR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC79CC4CEC2;
	Sat,  5 Oct 2024 13:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728136092;
	bh=n8s7hIwQ/x5IgIyFZ4FVm1VE3nnhRGEjX2SMzNPVERw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMUixHR0auV5QBT17RfYkYuenaryRBGO3oXXZg7KGPOcZ+UyfL8iqznY/dEG52KHn
	 axdfzSfrkHP03lYT99sJI5391GmNGWs2l5GZl0RGBnpOYC2m/+/M5oScqwRYEyTtcD
	 S2ARc2d1Xf4xKEnnQA7NQg+SXRe5Ew8/wusAYyJI2DUyoP22PuLUyDrTpcVnBKZZMP
	 IKx5XRdUdGhQmFursTyGQtrTwNJuE+eA240lp8z4wMR8D7aDdi9WBb6OqUgMTZVUnA
	 v6ErpKZ4h1qLi1LO1Faz/Z4TmGpuGmmT4TW5KCL6rFIjph86GUuOEjHCWKhklaFb6K
	 wMjCh4xaBdcsA==
Date: Sat, 5 Oct 2024 14:48:09 +0100
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
Message-ID: <ZwFDmaeIgPKfmJnj@finisterre.sirena.org.uk>
References: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
 <20241005-arm64-gcs-v14-3-59060cd6092b@kernel.org>
 <87iku6vl4z.wl-maz@kernel.org>
 <ZwE6V9cqf7jD1rTc@finisterre.sirena.org.uk>
 <87frpavgam.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0YRMIZaZW9+FLJoj"
Content-Disposition: inline
In-Reply-To: <87frpavgam.wl-maz@kernel.org>
X-Cookie: Editing is a rewording activity.


--0YRMIZaZW9+FLJoj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 05, 2024 at 02:18:57PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Sat, Oct 05, 2024 at 12:34:20PM +0100, Marc Zyngier wrote:

> > > Where is the handling of traps resulting of HFGITR_EL2.nGCSSTR_EL1?

> > These will trap with an EC of 0x2d which isn't known so I was expecting
> > this to get handled in the same way as for example a return of false
> > from kvm_hyp_handle_fpsimd() for SVE when unsupported, or for the
> > simiarly unknown SME EC, currently.  I gather from your comment that
> > you're instead expecting to see an explicit exit handler for this EC
> > that just injects the UNDEF directly?

> Not just inject an UNDEF directly, but also track whether this needs
> to be forwarded when the guest's HFGITR_EL2.nGCSSTR_EL1 is 0 while not
> being not RES0. Basically following what the pseudocode describes.

Ah, I see.  I'd been under the impression that the generic machinery was
supposed to handle this already using the descriptions in
emulate-nested.c and we only needed handlers for more specific actions.

--0YRMIZaZW9+FLJoj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcBQ5gACgkQJNaLcl1U
h9DN7gf/V5OGlMlnZmPwrXkPthgq3Dn4q6KAnpeQPJzjQbZdZQ8oF0bZCwHtl0U8
efKR8SmVxPeT5ZrHWhO/PdpnjYN10D4JKUmE02N2dVrxkbY23zuprklCdPoZIb64
yCTIJWzpAaCUqjJyRt0wJKcC5mRQzniglC7Ym4gIerf6bKbP83yR1w8YyWixXHYX
0Sas82Jo1yI6F6gKZC2Xpw00XWu7tA9SBgBn+cYal3SIleyVE9Anwbt58MRA+buN
AeAyDLRlFQdIOiP/OpawGQC0vEXCC7SH4sKlJ2baaSYrzIoA/HNK/Ptwz4BmVQKr
eU/R7hoTsVQc7R5d+GSQVGEv8LxwZw==
=yFUF
-----END PGP SIGNATURE-----

--0YRMIZaZW9+FLJoj--

