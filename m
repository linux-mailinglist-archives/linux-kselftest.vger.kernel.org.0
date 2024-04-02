Return-Path: <linux-kselftest+bounces-6997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E0895A92
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 19:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE637B24954
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 17:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905A15A48F;
	Tue,  2 Apr 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUsFC7g0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969D159915;
	Tue,  2 Apr 2024 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078521; cv=none; b=lZ8WfDYuC9kl+bOSgieuvlOVNc2HbgfCLWnb5pa+5X6vn+EMubyAXgJ5LdFAKwaNj8ASD939tEsUEiT6MuM4CIvdgSlJ5mfmyTBwtpcYvR/fT0CbjTyvEJ5pNlf8uMpPjisrea3rNs4hxQG+j5mTEuwbUd5sQK5yDK0HaKDnzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078521; c=relaxed/simple;
	bh=H8uWhCo1O/OYYi2drPcE1c99n/60JeLgX1yS8IFjOsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGjNJvIGiGFxZ35jwloiqOyX4lx1s7uKAagoiaDbI6kFisY5rIQHe7dCCwMtSZUPhlAN3SpNNa9DtWbtyJKI6VDlkLQyR+FzTMr6O+gYwE6uF83XOnsZrbys24cOTWffYgrkhfy7Lf/LKtdQsbcBFKiOpOh/O51Visq3xBA0CkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUsFC7g0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42F3C43390;
	Tue,  2 Apr 2024 17:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712078521;
	bh=H8uWhCo1O/OYYi2drPcE1c99n/60JeLgX1yS8IFjOsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUsFC7g0Q8/lx515dHicpBE0b06tm9dIdiVGdJrsr/6FaGJR6vinlLAZH9bgWuqvl
	 f4m31h7gXvhkrs0Dl8t1ul36NFUo6zzgt3NSRwa3AZxkWbcqfLL+Vlm95Rdg+9Dv8C
	 WROYbTvaWiWyVC7ninEYSu2rSblY5/Pb1IXjdYYsIFsuw49/0sFPUwVcyf5kdR92rr
	 KYKKG/aeS2u88JSqQHabJxVZo6DzmwNi1Acf2aV65bvZp9NvABFZtzSW/dL1Dv87dL
	 ybQ6VcrhQTLubmx+epTLdNltL5zoO8PwmeYkORVX/BkT3fbVJSo+kxqxJjejJooHH9
	 FYkLS5oUeTWng==
Date: Tue, 2 Apr 2024 18:21:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 2/5] KVM: arm64: Add newly allocated ID registers to
 register descriptions
Message-ID: <73c6012f-adb0-470b-bd47-6093d28aea97@sirena.org.uk>
References: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
 <20240329-arm64-2023-dpisa-v6-2-ba42db6c27f3@kernel.org>
 <87le5ysm4l.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pwE/A28+XRVGQBHe"
Content-Disposition: inline
In-Reply-To: <87le5ysm4l.wl-maz@kernel.org>
X-Cookie: Knowledge is power.


--pwE/A28+XRVGQBHe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 31, 2024 at 11:59:06AM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > The 2023 architecture extensions have allocated some new ID registers, add
> > them to the KVM system register descriptions so that they are visible to
> > guests.

> > We make the newly introduced dpISA features writeable, as well as
> > allowing writes to ID_AA64ISAR3_EL1.CPA for FEAT_CPA which only
> > introduces straigforward new instructions with no additional
> > architectural state or traps.

> FPMR actively gets trapped by HCRX_EL2.

Sure, I'm not clear what you're trying to say here?  The "no additional"
bit is referring to FEAT_CPA.

> > -	ID_UNALLOCATED(6,3),
> > +	ID_WRITABLE(ID_AA64ISAR3_EL1, ~(ID_AA64ISAR2_EL1_RES0 |
> > +					ID_AA64ISAR3_EL1_PACM |
> > +					ID_AA64ISAR3_EL1_TLBIW)),
> >  	ID_UNALLOCATED(6,4),
> >  	ID_UNALLOCATED(6,5),
> >  	ID_UNALLOCATED(6,6),

> Where is the code that enforces the lack of support for MTEFAR,
> MTESTOREONLY, and MTEPERM for SCTLR_ELx, EnPACM and EnFPM in HCRX_EL2?

Could you please be more explicit regarding what you're expecting to see
here?  Other than the writeability mask for the ID register I would have
expected to need explicit code to enable new features rather than
explicit code to keep currently unsupported features unsupported.  I'm
sure what you're referencing will be obvious once I see it but I'm
drawing a blank.

> And I haven't checked whether TLBI VMALLWS2 can be trapped.

I didn't see anything but I might not be aware of where to look, there
doesn't seem to be anything for that specifically in HFGITR_EL2 or
HFGITR2_EL2 which would be the main places I'd expect to find something.

--pwE/A28+XRVGQBHe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYMPrIACgkQJNaLcl1U
h9CulwgAgH5V5RmaWYuHCCBQIUQDkouUTMklMpA9Df1ChBIBvmW1OZl0PeW56Sui
640DAUobRml9J+gh6HsMUS3vnRLyGP11gEhxxTccwvoKuxH6ZsiBUaXkdN+f2Qfv
R8XxRO7JYoC7un2DPg2IjgAuyEX9OB8XzPmnRnFj276YjsQHy/oYUkwqemOMCMvB
3/rWpnLsoQ6/UC0RAfXCqN5jTPVG2fVBEFKcyiFi3eLqBxdDF/ugPgTIHtgP31Fz
rPtAVmzDu6El/d+hpIqAtb70IH/mk8uqYzd1EoTuiTZlGnsIoZLjn5Yft89t0Ets
B51k7JPujYgRrvFdBiC0WlPL3wYmjg==
=Xh1Z
-----END PGP SIGNATURE-----

--pwE/A28+XRVGQBHe--

