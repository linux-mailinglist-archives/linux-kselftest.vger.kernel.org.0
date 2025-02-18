Return-Path: <linux-kselftest+bounces-26908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B524CA3AC0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 23:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694E03B20E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 22:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C951DDA39;
	Tue, 18 Feb 2025 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiOZcO7g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930811D8A0D;
	Tue, 18 Feb 2025 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919301; cv=none; b=kbLCz0MTw9i4aK2RbcNaskftyB7Eb5Pypv7jpT8mTOFZnr141vuqt4erjQOHV0SLQHLJ+lwVaTZgOz46MqH40X2mC4b0JRQ29ZZXh3aTT70l8xYY8+j6TCi0pOLOOFIrQKomhlIy7cvqGGXTQ4VariEDJ94Cbnj+8gRArYp+WHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919301; c=relaxed/simple;
	bh=JfZZ5wVAOe/Y1NihNftjYuYbwLi7XmW8eEZlPrqPMd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtgLHhWS2qFYesAWal7ExFsAez1OBW0cB1j2SQvKVZCUuTaKFT+IW9DhOw+tGXpqgbmc4Zyqdim5rsGBDwa+09ctw+aDDKCfksoBg8ng1nObxQAWwMQWeIk2045a6WD22wq0nQ636c1L2roOs/ctLY+aTEn4GLpTMZl/bxomZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiOZcO7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F80C4CEE2;
	Tue, 18 Feb 2025 22:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739919301;
	bh=JfZZ5wVAOe/Y1NihNftjYuYbwLi7XmW8eEZlPrqPMd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiOZcO7gz+YKbzy7UfmkDhU3tc1GP77KXGgqZvo8QBWC5vgpTgTrmRki8TY27KEG9
	 8HqF/60pEH5UBgtSchm3Se6wqh0dZaDowr6l0b6r0YUl+j0tajI/QC2mEqdWnL1GnL
	 LiqABVRTk5NWk1BgguBFuStYX4r6uCiugCD746iyvxydi45/2eBqxBVJGd1AGnfWRG
	 ylD6MnyNRCoHpbpVjxW/FVxP8oPsdm4slgSekZk/4aRmRIPRkFjtlJborqm0BF8/oW
	 GCSKlZDlRTb1JiQ+9Nn3ndwQV91qYjgd4h0D3IG0l3MLO6jxlYtY1qBAyD9YDZ6pGA
	 E6dhuaXIuBhyA==
Date: Tue, 18 Feb 2025 22:54:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 00/27] KVM: arm64: Implement support for SME in
 non-protected guests
Message-ID: <Z7UPwXVqkaKZDtGk@finisterre.sirena.org.uk>
References: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
 <86pljkswuk.wl-maz@kernel.org>
 <Z69dsGn1JVWPCqAi@finisterre.sirena.org.uk>
 <86h64ssyi1.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S0+W34M0g75qMnHY"
Content-Disposition: inline
In-Reply-To: <86h64ssyi1.wl-maz@kernel.org>
X-Cookie: Editing is a rewording activity.


--S0+W34M0g75qMnHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 09:37:26AM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Feb 14, 2025 at 09:24:03AM +0000, Marc Zyngier wrote:

> > > Why SVCR? This isn't a register, just an architected accessor to
> > > PSTATE.{ZA,SM}. Userspace already has direct access to PSTATE, so I
> > > don't understand this requirement.

> > Could you be more explicit as to what you mean by direct access to
> > PSTATE here?  The direct access to these PSTATE fields is in the form of

> I'm painfully aware of the architecture limitations.

> However, I don't get your mention of SPSR here. The architecture is
> quite clear that PSTATE is where these bits are held, that they are
> not propagated anywhere else, and that's where userspace should expect
> to find them.

> The fact that SW must use SVCR to alter PSTATE.{ZA,SM} doesn't matter.
> We save/restore registers, not accessors. If this means we need to
> play a dance when the VMM accesses PSTATE to reconciliate KVM's
> internal view with the userspace view, so be it.

Could you please clarify what you're referring to as the VMM accessing
PSTATE here?  The KVM API documentation defines it's concept of PSTATE
as:

 0x6030 0000 0010 0042 PSTATE      64  regs.pstate

in api.rst but does not futher elaborate.  Looking at the code the
values that appear there seem to be mapped fairly directly to SPSR
values, this is why I was talking about them above.

It's not clear to me that PSTATE in the architecture is a register
exactly.  DDI0487 L.a D1.4 defines the PSTATE bits as being stored in a
ProcState pseudocode structure (ProcState is defined in J1.3.3.457, the
pseudocode maps PSTATE in J1.3.3.454) but has an explicit comment that
"There is no significace in the field order".  I can't seem to locate an
architectural definition of the layout of PSTATE as a whole.  I also
can't find any direct observability of PSTATE as a whole which would
require a layout definition for PSTATE itself from the architecture. =20

There *is* a statement in R_DQXFW that "The contents of PSTATE
immediately before the exception was taken are written to SPSR_ELx"
which is somewhat in conflict with the absence of SM and ZA fields in
any of SPSR_ELx.  There's also R_BWCFK similarly for exception return,
though that also already has some additional text for PSTATE.{IT,T} for
returns to AArch32.  If everything in PSTATE ends up getting written to
SPSR then we can use SPSR as our representation of PSTATE.

> It probably means you need to obtain a clarification of the
> architecture to define *where* these bits are stored in PSTATE,
> because that's not currently defined.

I will raise the issue with R_DQXFW and friends with the architects but
I'm not convinced that at this point the clarification wouldn't be an
adjustment to those rules rather than the addition of fields for SM and
ZA in the SPSRs.  Without any additions the only access we have is via
SVCR.

> > > Isn't it that there is simply a dependency between restoring PSTATE
> > > and any of the vector stuff? Also, how do you preserve the current ABI
> > > that do not have this requirement?

> > Yes, that's the dependency - I'm spelling out explicitly what changes in
> > the register view when PSTATE.{SM,ZA} are restored.  This ABI is what
> > you appeared to be asking for the last time we discussed this.

=2E..

> > Would you prefer:

> >  - Changing the register view based on the current value of PSTATE.SM.
> >  - Exposing streaming mode Z and P as separate registers.
> >  - Exposing the existing Z and P registers with the maximum S?E VL.

> > or some other option?

> My take on this hasn't changed. I want to see something that behaves
> *exactly* like the architecture defines the expected behaviour of a
> CPU.

> But you still haven't answered my question: How is the *current* ABI
> preserved? Does it require *not* selecting SME? Does it require
> anything else? I'm expecting simple answers to simple questions, not a

Yes, it requires not selecting SME and only that.  If the VMM does not
enable SME then it should see no change.

> wall of text describing something that is not emulating the
> architecture.

I'm not clear what you're referring to as not emulating the architecture
here, I *think* it's the issues with PSTATE.{SM,ZA} not appearing in
SPSR_ELx and hence KVM's pstate?

Your general style of interaction means that it is not always altogether
clear when your intent is to just ask a simple question or when it is to
point out some problem you have seen.

--S0+W34M0g75qMnHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme1D8EACgkQJNaLcl1U
h9Ag7Af9FSno1GEtP2DysLSKInBllL4rhNcN+6z7D0oMeZYX+CbjmeedfMLNVwdd
quEjDrrV5PN76cyP3s35ABkWOUUUWyrUMYt3sP6vVesfNuMhjb54DETOj71CTEaW
wt8TicvFuN6erEuz85tgB5CPng+CEGwJRhu6STP7/gBEfPou7y/9dH6xj++i/ueD
Affm1jdtJAtdk6lDgtqjF0K9Tkawu8SM/0MkoITsCRK3R05LpSLBiCvr3S0e/rUv
r616LswXOvPnYxuJ3Cr2phgx5ZTGgSo+IH/KQUOdK9lM1E6YkqXDtNQtw5qXldu+
NYjTRYepfepTBCUZ6GVhkP7IEmi+tQ==
=qowg
-----END PGP SIGNATURE-----

--S0+W34M0g75qMnHY--

