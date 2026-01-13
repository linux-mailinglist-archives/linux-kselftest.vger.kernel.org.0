Return-Path: <linux-kselftest+bounces-48887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F4D1B01F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 20:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8ACC1300DD8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 19:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA7736BCF9;
	Tue, 13 Jan 2026 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaHa3cbX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3BF36AB51;
	Tue, 13 Jan 2026 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332029; cv=none; b=lW/Udy4g25HLADG6iybFXofQdKxHhnyIwESZakQQ7IktoZE+G+xMTA6vCVC4GdKZGu4UcKFIskIDZ7xM3paHeq+Bdsg3VabpFcFBb34tK4m5Bg1Mbl8YYD64CXE00j7eXddd65AwOX79zXHRxlnqDpa57HML7/3E9s4cormOGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332029; c=relaxed/simple;
	bh=qurAIc6DbD1P3VjWT14CBlpPJbKMYx/2lRbDteQqJK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6wO4wHUeMW9n1QxymD9s4K90VgH/62MN9tfMFPM+6YbmOKbSAL596rbRw9hABD3gbbX8ypzFK8WRci0JDttU4pYHt4Bdq3/0XkfqigJFCvTd5uH+hINk6CnWQ8+AvF1m8xa4t3lMMK64cTn/dgSOZFJFY5jsh1B4jNgvpgE0ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaHa3cbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3C8C116C6;
	Tue, 13 Jan 2026 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768332029;
	bh=qurAIc6DbD1P3VjWT14CBlpPJbKMYx/2lRbDteQqJK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DaHa3cbXEWuHjYxQZyPsiCHXYiKK9rHndIT3XdWTaG/6sourN0aJq7yqPYNbx22xn
	 UwNvhMabpIoW8zban8RFgByaiJvtYg71554T9rpFCBpZj90wCnAPDmX+uEc4L4Eu01
	 1NZsxcAt3x1hJxYysaSl3TOVK1O41SSeBnO894H3fmSljNfa43IHXeVV6L/j6TsOMU
	 O2lbsaEatx9p3T/guWqUFxOkbMGUh7ILJqDVWD4saquvkehNCjMHpGsNK9pGI3AgKM
	 HFpPW24VJsUfgHrvDjClx28HsV9GspEm0TaaqnwZt34e0XX1/6E+aXGIkvWs1LBqae
	 EbXrFf/G9aDPQ==
Date: Tue, 13 Jan 2026 19:20:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v9 19/30] KVM: arm64: Provide assembly for SME register
 access
Message-ID: <6f0e94ab-7c9c-4705-a90b-aea09ca629de@sirena.org.uk>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-19-8be3867cb883@kernel.org>
 <CA+EHjTwQ4fLBE1YXoB6M0eamSgGDW=nfLaC+-_surBfVbh3byQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lDAyLxtvXSswRf14"
Content-Disposition: inline
In-Reply-To: <CA+EHjTwQ4fLBE1YXoB6M0eamSgGDW=nfLaC+-_surBfVbh3byQ@mail.gmail.com>
X-Cookie: All models over 18 years of age.


--lDAyLxtvXSswRf14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 12, 2026 at 05:59:17PM +0000, Fuad Tabba wrote:
> On Tue, 23 Dec 2025 at 01:22, Mark Brown <broonie@kernel.org> wrote:

> > +void __sme_save_state(void const *state, bool restore_zt);
> > +void __sme_restore_state(void const *state, bool restore_zt);

> Would it be a good idea to pass the VL to these functions. Currently,
> they assume that the hardware's current VL matches the buffer's
> intended layout. But if there is a mismatch between the guest's VL and
> the current one, this could be difficult to debug. Passing the VL and
> checking it against _sme_rdsvl would be an inexpensive way to avoid
> these.

This mirrors the way that we've handled this for the SVE and for the
host kernel.  We don't really have any good way to tell anything about
problems if things go wrong inside the hypervisor.

> > +SYM_FUNC_START(__sve_get_vl)
> > +       _sve_rdvl       0, 1
> > +       ret
> > +SYM_FUNC_END(__sve_get_vl)

> Since this is just one instruction, would it be better to implement it
> as an inline assembly in the header file rather than a full
> SYM_FUNC_START, to reduce the overhead?

Actually this isn't referenced anymore so could just be deleted.  It
mirrors what we've got in the host code, we have to hand assemble
everything because we still don't require binutils that supports SVE,
let alone SME, and that's done with macros that do argument validation
which don't play nice with C.  Even with an assembler that supports the
instruction using a SVE instruction from C code gets annoying.  It has
crossed my mind to inline but it never seemed worth the effort

> > +SYM_FUNC_START(__sme_save_state)

> I think that this needs an isb(). We need to ensure that SMCR updates
> are visible here. Looking ahead to where you introduce
> __hyp_sme_save_guest(), that doesn't have a barrier after updating
> SMCR. The alternative is to call the barrier where it's needed, but
> make sure that this is well documented.

I think we should put the barrier where the update that needs it is.

--lDAyLxtvXSswRf14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlmmvUACgkQJNaLcl1U
h9BzvQf/f/p7RflGxj3KstGrHbuuy4Zn+p2w36WodM7yaxNSGN6NOAbQBf6mbd/+
Gp4Wa+DlxmHvWufQbs4ZVzvcD6cJra7yLtKwDkrUVbwYXZiruLL8mx1TbR31PEel
YTiZq/e+84A0Iq/I1MJa3Gp6pMKR0wWROTckUgHz84pVh4RKJb8727K7223icJPp
x5bv2TbtkOOTqEz2Lkinhs/f8aFOaxG5EcibGp2MLK9F15ev8XdervooOujztXSk
DN0+jPCZgE4U1Ik3RXooRy/dNKtzlU086OecNGWrFghqupbtCFPLGLFXwbOZeFtk
kPCeRN/8k4SkdXhMDgXAvYhuOOPdQQ==
=Xzoc
-----END PGP SIGNATURE-----

--lDAyLxtvXSswRf14--

