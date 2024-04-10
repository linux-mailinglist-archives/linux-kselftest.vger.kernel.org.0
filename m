Return-Path: <linux-kselftest+bounces-7576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFBF89FCF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 18:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC2F1C20FA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4652F17B500;
	Wed, 10 Apr 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW+Hl4No"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C83EC3;
	Wed, 10 Apr 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766838; cv=none; b=J56UdHAfglbfSCUDQPiqdyg8ENNMvAdWriOXTpIyRq7wT5lYW3ctkidyfIAVZm0jErhJbA/8UbdVnIPXxf63VV8E+dVjkFRMGB2mHxcYb8S0Al8nuKwOF51uD1DOyQK5jlAhVa6Ymq4Q7aDk7geqKA72Ocr29wyrdNmUN3JO0fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766838; c=relaxed/simple;
	bh=Lxk+nu1ElmHbPqbruGu7bsCZtblhfeKs04cJc3fu7sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ajm76df1MDiwOh95ZARK3UXy6Ro92TM7ngggzpq1GTTcRPe9Z2HKM63j54JUiCnmv1Evea2wIgbxraG5v1KjIEun+sduztHGyGoZ5ftlxnAYn5Aqp/G69rmdzleHDWlxo280sge4Yx2nNyZbYGPI02iM1P4/5cW3dUCWYLnsJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW+Hl4No; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967DBC433F1;
	Wed, 10 Apr 2024 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712766837;
	bh=Lxk+nu1ElmHbPqbruGu7bsCZtblhfeKs04cJc3fu7sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FW+Hl4NofBz3bb9/GOCLtbNKqxiAn1TWdNN3GjRrqtJHwGxDcCubSNaWE3Do938+7
	 aYHv6EhsuI1WuxI3jzD0kThrtlO+DLOapzjM5Ud+RcLxG6DP5ApxDtsBgrUUQ0xoHz
	 Xby8GC2mEEs7sHmahMt0C6wK5ofCaZ/EOS0HnqmPoCY2K8o9zaYNFZFGIibeBECdu9
	 40EJFHEYvUsFZHcyh49fWsvnAiOtA7CbvtS0r1tjn1WGlLFt6R+kOQNcnkwgcUw2N7
	 T7yuLRbQ3/olqdsLWkWDmCabyw7d/wC+fmByyL8BU0gN0Da9H/2m01bMEHdylz6D5d
	 OQldnWjCWBRRA==
Date: Wed, 10 Apr 2024 17:33:49 +0100
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
Message-ID: <d7263b50-adda-44c0-90de-0e0890722b92@sirena.org.uk>
References: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
 <20240329-arm64-2023-dpisa-v6-2-ba42db6c27f3@kernel.org>
 <87le5ysm4l.wl-maz@kernel.org>
 <73c6012f-adb0-470b-bd47-6093d28aea97@sirena.org.uk>
 <86ttk9se3h.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x4qkr4Sz7m9EvEWi"
Content-Disposition: inline
In-Reply-To: <86ttk9se3h.wl-maz@kernel.org>
X-Cookie: A bachelor is an unaltared male.


--x4qkr4Sz7m9EvEWi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:32:02AM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Sun, Mar 31, 2024 at 11:59:06AM +0100, Marc Zyngier wrote:
> > > Mark Brown <broonie@kernel.org> wrote:

> And when it comes to CPA, there are additional controls in SCTLR2_ELx,
> which doesn't even gets context switched for EL1. What could possibly
> go wrong?

Yes, I'd missed those - they were rather buried in the XML
unfortunately.  I'd already disabled CPA in my local code, and I've also
refactored the exposure of FPMR to be in the patch that context switches
it.

> > > > -	ID_UNALLOCATED(6,3),
> > > > +	ID_WRITABLE(ID_AA64ISAR3_EL1, ~(ID_AA64ISAR2_EL1_RES0 |
> > > > +					ID_AA64ISAR3_EL1_PACM |

> > > >  	ID_UNALLOCATED(6,4),
> > > >  	ID_UNALLOCATED(6,5),
> > > >  	ID_UNALLOCATED(6,6),

> > > Where is the code that enforces the lack of support for MTEFAR,
> > > MTESTOREONLY, and MTEPERM for SCTLR_ELx, EnPACM and EnFPM in HCRX_EL2?

> > Could you please be more explicit regarding what you're expecting to see
> > here?

> I'm expecting you to add all the required masking and fine-grained
> disabling of features that are not explicitly advertised to the guest.

> This should translate into additional init code in kvm_init_sysreg(),
> kvm_init_nv_sysregs() and limit_nv_id_reg(). You also should update

I see that in limit_nv_id_reg() I am missing updates to expose the new
dpISA features to nested guests.  However from a first pass it looks
like kvm_init_nv_sysregs() already handles everything I'd expect it to,
AFAICT it's handling all known trap bits?  For kvm_init_sysreg() with
HCRX AFAICT we default to having all bits 0 with explicit relaxations
for supported features (currently FEAT_MOPS, also FEAT_FPMR with this
series) meaning that I'm still unclear what exactly the updates you're
looking for are.  For SCTLR unless I'm misunderstanding things we've got
an existing issue with not initialising the res0 and res1 fields in
kvm_init_nv_sysregs() but that doesn't seem right... =20

> the exception triaging infrastructure in emulate-nested.c.

Again I am really struggling to identify which specific updates you are
looking for here.

> > > And I haven't checked whether TLBI VMALLWS2 can be trapped.

> > I didn't see anything but I might not be aware of where to look, there
> > doesn't seem to be anything for that specifically in HFGITR_EL2 or
> > HFGITR2_EL2 which would be the main places I'd expect to find
> > something.

> That's a really odd place to look. This is a S2 invalidation
> primitive, which by definition is under the sole control of EL2, and
> therefore cannot be trapped by any of the FGT registers, as they only
> affect lesser-privileged ELs.

> The instruction is described in the XML:

> https://developer.arm.com/documentation/ddi0601/2024-03/AArch64-Instructi=
ons/TLBI-VMALLWS2E1--TLB-Invalidate-stage-2-dirty-state-by-VMID--EL1-0

That's TLBI VMALLWSE1 which is a more specific instruction.  TBH I can't
remember exactly what I was looking for, I did go into the instruction
pseudocode a bit (I was going in via SYS at one point) but didn't find
anything so was also trawling sysregs looking for something.  If I'm
reading this right there are no traps?

--x4qkr4Sz7m9EvEWi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYWv2wACgkQJNaLcl1U
h9C8OQf/X+t5aQ5/nMQBNyVUWzuv0H4al1uPXrqHbjYcuaLB6extGWPsVnzhcikJ
ejycYkszbTrF/28+Ix3QmYCqv5bNph/A8a2xAvtbhcqAmQ3m1NuH5aCfGNcGxOmk
VWtSmljce1GeJh6xPOkCbTF8zwIoSp0cvubFxTTaZb4LnaiJdT+28TGVzpmc1vQl
ZFrv/ZRyf8lxVu9IZuCRtSthRJOYyhkwC1GUcBnyrZ+4ViJE0qmzxDDTO9kvtoVu
weHy/oBXNsfRdlkZubuQv2/zCqo2MVXkUhoxwGPXqPRgN0DFCgyFt70N841OjP4j
hwQ0PKE5A4w3JRp+kM/DX0MURgxStg==
=zSnw
-----END PGP SIGNATURE-----

--x4qkr4Sz7m9EvEWi--

