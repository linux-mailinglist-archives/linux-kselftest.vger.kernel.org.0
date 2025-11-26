Return-Path: <linux-kselftest+bounces-46541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A32F9C8B783
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88D0F4E4E92
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 18:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8780B33F363;
	Wed, 26 Nov 2025 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1zPS+LK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D11D331237;
	Wed, 26 Nov 2025 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182506; cv=none; b=L1MZzFhzSdDlClvec+pCoqWxHu+N/O0l/ChhMGzL7V4dYNE37PN228mHnhEAzWxTfY8l3k15pQ/Pb2nGC7fE26so/N9BDYmKqhxGh+TgQQ6X3dIxdJ79x8dMP8l8Cof/KYLoSA/UcGZS7pIFyZ7OgX9P8Mbna9fy/xfy+mj0oLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182506; c=relaxed/simple;
	bh=OrhxCJrCTAVZNlhdhhsJnvnRtmy8sEmyPzUtcg6Xrw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GssvyNDWuK24o/KCEf5YniPvHcrGTr3nrffMss3CDur0wuic/pFh32+wbfCnDbxDxKTd6PEPeVAocniez1mA68DmMtnaGttGjFgnZVeU6pvktv5WFXdGMMivjTvjcplAEVfOHDGuJcuF2PcoL1U8rMffA/26SpYX6t1qwNBMyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1zPS+LK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C166C4CEF8;
	Wed, 26 Nov 2025 18:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764182505;
	bh=OrhxCJrCTAVZNlhdhhsJnvnRtmy8sEmyPzUtcg6Xrw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1zPS+LKUaXXpTefzHkDWvnRO47r2FZ8n+VfyP6uAEXavpdrJ98W4D0ey5rqVQL2b
	 2kszPt8wjH6Ol4z2gl2D2DiQqTajn79gCa1MzviSWJxj5+/jQSZ60fxptQztxSz4ET
	 0HLdIhBY0PA+USuTNyivVs32an/VfAP7QFm7y7VP8+dChFC+NeQeoG1P85OAM5DzTj
	 In1e6YUqNJMlhUEt7m8V9Eoju6QjA8OsR/ejIs9jV/Ln7jBXGWFasGxxH3EO0NwkTG
	 0ApqTvKMaPdShngMRvVSRoUfN7cZ1eJ/DaeAITctDy82/41WBm3INKD5BK9nHKMHjg
	 PUS+LdeMvdfuQ==
Date: Wed, 26 Nov 2025 18:41:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Fuad Tabba <tabba@google.com>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 11/29] KVM: arm64: Document the KVM ABI for SME
Message-ID: <8d27e309-15d7-47de-b51a-9f0e0bfa4766@sirena.org.uk>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
 <20250902-kvm-arm64-sme-v8-11-2cb2199c656c@kernel.org>
 <CAFEAcA_GJ7gzn7aMCZYxHnJWvx4tHSHBKsOxtQ7NTb4gPjkMJQ@mail.gmail.com>
 <df712591-397e-422b-b9c9-fbf080cad9aa@sirena.org.uk>
 <aScfSMZEKCeUq7Zn@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qeptf6kasDv7BEH7"
Content-Disposition: inline
In-Reply-To: <aScfSMZEKCeUq7Zn@e133380.arm.com>
X-Cookie: Murphy was an optimist.


--qeptf6kasDv7BEH7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 05:23:47PM +0000, Dave Martin wrote:
> On Mon, Nov 24, 2025 at 08:12:56PM +0000, Mark Brown wrote:
> > On Mon, Nov 24, 2025 at 03:48:06PM +0000, Peter Maydell wrote:

> > > >  .. [1] These encodings are not accepted for SVE-enabled vcpus.  See
> > > > -       :ref:`KVM_ARM_VCPU_INIT`.
> > > > +       :ref:`KVM_ARM_VCPU_INIT`.  They are also not accepted when =
SME is
> > > > +       enabled without SVE and the vcpu is in streaming mode.

> > > Does this mean that on an SME-no-SVE VM the VMM needs to know
> > > if the vcpu is currently in streaming mode or not to determine
> > > whether to read the FP registers as fp_regs or sve regs? That
> > > seems unpleasant -- I was expecting this to be strictly a
> > > matter of how the VM was configured (as it is with SVE).

> > Yes, it does.

> Is the above condition right re streaming mode?  The original reason
> for this restriction was that the SVE Z-regs and FPSIMD V-regs are
> aliases when SVE is present.  To avoid having to worry about how to
> order register accesses and/or paste parts of them together, we went
> down the road of banishing encodings that alias a subset of the
> register state accessed by some other encoding.

I queried the issue with requiring that writes to the registers be done
in a specific order - we apparently have some other examples of this
already (I would need to go and check which specifically) so that was
seen as OK.

> In line with this principle, with SME Vn and Zn are aliases when
> *not* in streaming mode, so allowing access through the Vn view feels
> problematic too?  (And when in streaming mode, the Vn regs don't exist
> at all.)

The ABI proposed here is that the V registers will only be available
with a VM that lacks SVE, you'll never have them both simultaneously but
rather which is available at any given moment will vary on a SME without
SVE VM.  This obviously has complications, but aliasing is not one of
them.

Another option would be to represent the V registers as 128 bit Z
registers, giving you something similar to how they'd appear on a VM
with both SVE and SME for a SME only VM.

> Whether the proposed ABI is considered awkward for VMMs or not is a
> separate matter...)

Indeed.

> > > > +       max_vq.  This is the maximum vector length currently availa=
ble to
> > > > +       the guest on this vcpu, and determines which register slice=
s are
> > > > +       visible through this ioctl interface.
> >=20
> > > > +       If SME is supported then the max_vq used for the Z and P re=
gisters
> > > > +       while SVCR.SM is 1 this vector length will be the maximum S=
ME
> > > > +       vector length available for the guest, otherwise it will be=
 the
> > > > +       maximum SVE vector length available.

> The max_vq name here is not ABI; it's just linking concepts together in
> the documentation text.

> So, can we give explicitly different names to these two max_vq values?

We could call them sve_max_vq and sme_max_vq?

> Splitting the affected register descriptions into "SVCR.SM =3D=3D 0" and
> "SVCR.SM =3D=3D 1" cases also be helpful to make this special-casing clea=
r.

Possibly I'm looking at the wrong thing here but the overall text for
describing the vector registers is relatively long so I worry that it'd
be harder for readers to play spot the difference if there was
duplication.  I figured explicitly calling out the differences would be
clearer and less error prone in terms of any future updates.

> > This is attempting to say that the VL for the Z and P registers (and
> > FFR) will vary depending on if the vCPU is in streaming mode or not if
> > the maximum VL for SVE and SME differs, similarly to how the Z, P and
> > FFR registers disappear when we are not in streaming mode in a SME only
> > system.

> May flipping SVCR.SM through KVM_SET_ONE_REG have the architectural
> effect of zeroing the vector regs?  That feels like something that
> should be stated explicitly.

Yes, it should zero them - I'll find some place/way to add that.

> I'd agree that this mutating interface feels odd, and does not follow
> the original spirit of the design here.

> But the SME architecture doesn't fit well with the spirit of the
> original KVM ABI here either, so I guess there won't be a perfect
> solution.

Something's going to be awkward somewhere.

> It seems that when SME is enabled in the vCPU features and the VMM is
> planning to dump or set affected registers, there is a requirement to
> dump / set SVCR.SM first, and then go down one of two code paths.  Can
> this be called out explicitly?  This is a departure from the the
> previous interaction model, so it probably deserves its own section,
> which can then be cross-referenced from individual reg
> descriptions.

> SVCR.SM exhibits this modality w.r.t a specific set of affected
> register encodings; it would be good to have that captured clearly in
> one place.

As I said above my understanding is that this is not actually a
departure from the current stituation, this not being noticed probably
highlights why it'd be good to improve the documentation here!  I think
grouping all behaviours like this together would be good from a
usability point of view.  I don't know how much of that that fits
directly in the ABI document or in a separate "here's some gotchas" type
document, things are already getting a bit difficult to manage.
Possibly both.

--qeptf6kasDv7BEH7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmknSeIACgkQJNaLcl1U
h9Docgf/cPhrqw0FDee6DcZOryTwO1VKQ+JqiWC1SI9SblwgQ/XgIeIYAQSjWrPM
0pvT2htq6pm7QwQc0l0eX4Np6yo/OSjiCrjuCkJF1QHevk3sdguC+hCjaabkfDBm
LbPLGdx3q7k6E4zza+kXg6inA0+D3T/fvLnFvvrDgnu7V3FmHlRCoIvinIpOeWZR
7qZ+rZdUBKnljxQXBbbx3NPx5//xeYHlzxXLXwJU2CzCCSOSqKGIpuM0nLVaaoZS
4sCzTBvU112uGizcjZGRruKfZ59Mp+xQKUrxnFb2HaO8udriyait0aMv7s08Xw/V
z3/GvVCRxxcUSHXSYIwmWQPJeVqv4w==
=dEOw
-----END PGP SIGNATURE-----

--qeptf6kasDv7BEH7--

