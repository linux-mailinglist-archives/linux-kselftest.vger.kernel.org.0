Return-Path: <linux-kselftest+bounces-14794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F79947F0E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28271F21DD4
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 16:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303D15B102;
	Mon,  5 Aug 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE9vq1Bu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31FC376F5;
	Mon,  5 Aug 2024 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874610; cv=none; b=KiShkVMzy3riGBIWjU6WexpAhqQrLXPCcN67Ho7Ct/PUjhg686UGaa+GcQzcyv6e3hR/J3liKIQ9Rkd5xxvmI5NIYBO6XgDEKS3EAki1URQmyG5JQ5sQsyfv/hqR4mZ0oDz9xC1FQ9iSr60AMlovL/DaJESfc4Iu9cm4eVQFxyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874610; c=relaxed/simple;
	bh=y9ldZbTyfHtWmV56N6wsb2EpJn4YFyke+2byGlPJ2Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqDlFTXSmSzJKkne3TIKWJ/9Q9iMA8m60W/+A0kE1L9pdsYSddQM2DvuZ1rEjhGFepTzjYeQU1UnZgt/qLIcyI1yDxeXpdP/C5JKZSDx9bu3KlTxob7C5XgQ7TaCYVi5B11f5rIUY+pFfoocNvnw7nl4Ud88D+SAFT8XKbZBtp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE9vq1Bu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69E9C4AF0C;
	Mon,  5 Aug 2024 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722874609;
	bh=y9ldZbTyfHtWmV56N6wsb2EpJn4YFyke+2byGlPJ2Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dE9vq1BuB7DySNJ0jmsO8oDVdSmXiOtDPZZ+qMEI4JVqefYufKzfUqg36Y8Gtymsn
	 yw8UXACxwiu7eOw2VaFkkLc9DKj+IcG8GYXfAQ7axO+sy+4Opse6dwr+CwW795gh8I
	 Yy6XsxPaiwvT55c5+H2DphPa9LPRBo7WzA/TKvrZcGTy6LsO6m1iXKKZedZzwVB504
	 QjmY78WVHFacbV9dV2pWObXlY4M94SsfzOB7Qh40ctDl74gMT+EI9RHeQlieTk7c+6
	 CJ71uHEUxPNKvoJxM44gmoUiTq6g1QfZFJY3baXmSMWlbwiJAcTvBXyD+N4ly0eZ4k
	 fI8UPtwF5DtqQ==
Date: Mon, 5 Aug 2024 17:16:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: arm64: Use generated defines for
 named system registers
Message-ID: <6c1beda4-7211-4f64-95c8-7a11c489b145@sirena.org.uk>
References: <20240802-kvm-arm64-get-reg-list-v1-0-3a5bf8f80765@kernel.org>
 <20240802-kvm-arm64-get-reg-list-v1-2-3a5bf8f80765@kernel.org>
 <868qxe0wzp.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vBXB/GZWADW/Ncoh"
Content-Disposition: inline
In-Reply-To: <868qxe0wzp.wl-maz@kernel.org>
X-Cookie: Goodbye, cool world.


--vBXB/GZWADW/Ncoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 03, 2024 at 10:35:54AM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > This conversion was done with the sed command:

> >   sed -i -E 's-ARM64_SYS_REG.*/\* (.*) \*/-KVM_ARM64_SYS_REG(SYS_\1),-' tools/testing/selftests/kvm/aarch64/get-reg-list.c

> [Eyes rolling]

> What I asked about scripting the whole thing, it never occurred to me
> that you would use the *comments* as a reliable source of information.
> Do we have anything less reliable than comments in the kernel?

I think we should ultimately be using both the comments and the
encodings - the comments indicate what people thought was being tested
and it's useful to make sure we have that coverage even if the
implementation were to have been wrong.

Doing this step is also going to have picked up registers which we don't
yet have in the sysreg file, some of which are going to be painful to
add there (things like ESR for example) so aren't likely to get done in
a hurry due to complexity in their definitions.

This was quick to do, represents progress, and offers a hint to anyone
adding new registers that they should use the symbolic definitions.

> The matching must be done from the arch/arm64/tools/sysreg file,
> because that's the (admittedly dubious) source of truth. We actually
> trust the encodings because they are reported by the kernel itself.
> The comment is hand-written, and likely wrong.

Sure, there's a reason I compared the resulting binaries rather than
just trusting that the conversion gave the same result.

> > -	ARM64_SYS_REG(3, 3, 14, 3, 1),	/* CNTV_CTL_EL0 */
> > -	ARM64_SYS_REG(3, 3, 14, 3, 2),	/* CNTV_CVAL_EL0 */
> > +	KVM_ARM64_SYS_REG(SYS_CNTV_CTL_EL0),
> > +	KVM_ARM64_SYS_REG(SYS_CNTV_CVAL_EL0),
> >  	ARM64_SYS_REG(3, 3, 14, 0, 2),

> Great. So not only you fail convert a register, but you also ignore
> the nugget described in arch/arm64/invlude/uapi/asm/kvm.h:267.

That's that CNTV_CTL_EL0 and CNTV_CVAL_EL0 have their encodings
reversed in the ABI.

> Sure, having both described hides the crap, as we don't attach any
> significance to the registers themselves. But that shows how
> untrustworthy the comments are.

I'm afraid that any automated conversion is likely to trip over an ABI
issue like that - the obvious thing to do when looking up by encoding
would be to just emit a KVM_ARM64_SYS_REG() if we find the encoding
which would give the same end result.  I'll add a separate manual update
of these registers.

Are there any other similar issues?  I didn't spot anything in kvm.h.

> >  	ARM64_SYS_REG(2, 0, 0, 0, 4),
> >  	ARM64_SYS_REG(2, 0, 0, 0, 5),
> >  	ARM64_SYS_REG(2, 0, 0, 0, 6),

> As far as I can tell, these registers are not unallocated, and they
> should be named.

I agree that we should do all named registers eventually, the above are
numbered debug registers (DBGBVR0_EL1, DBGBCR0_EL1 and DBGWVR0_EL1)
which aren't in the sysreg file yet so wouldn't currently be covered by
a conversion based on pulling encodings from there.  They could also be
done immediately with a generator script as there are DBGBVRn_EL1 style
macros there.

Like I say this is a quick first step and does improve things, there's
still more to do but I do think this moves us forward.  We can and
should come back later and build on things as people have time.

--vBXB/GZWADW/Ncoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaw+usACgkQJNaLcl1U
h9A5QQf/eq0ZOdpYjJXRG4CZ3SHDFIZ/NM9H8ZnuG8wQ5BVfd1DI1hdEiZ9P+jT5
IgxAmzyq0jBtYm+llNM9Bh/KmjK9rLDfqIDPmfgpIKithc/IVo56E5SYXakQG5Fl
7pAT1nQt9Favk+dUlWY/4gShcfvJw12CpZn6hGI+6ZYr5tfYL7WbCrSlJ9XXlVPX
NU3YDGHDj0x2jiQDLndhAEeg53i3KwXSsngtyXQejpaI5GB6EIdTUKQ0bOVBoDq2
2PUjl74LLOZ/ELvCZsRGm7bPhZeMV5QBafI4H2Dl2fE02TM5ObCIjSW3sDdQXZTf
v6kOGV2I6Y9d+DfFwOec3a308g10rQ==
=TkJy
-----END PGP SIGNATURE-----

--vBXB/GZWADW/Ncoh--

