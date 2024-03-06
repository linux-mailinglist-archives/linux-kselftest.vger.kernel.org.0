Return-Path: <linux-kselftest+bounces-6001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49C0873C6F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 17:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6651F22078
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408A3137901;
	Wed,  6 Mar 2024 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GppPyV3r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC2135403;
	Wed,  6 Mar 2024 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743309; cv=none; b=dVEDDZJLJDDfBVS7HNr3TcznYm40FoNBk0j+SaJCdsMzSzbdBp6SQx1go5HmcELf8yIXZ1CYkye+cVPDANVNQV5Fw8k1Zp2mLCpVppr21JrmNfiEsCetzqFNQ5Qlygz9sTkZ4s9RRsIJ4C1VZhMJI21UuUnp65VysaI1go5YFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743309; c=relaxed/simple;
	bh=wGBQne2ty3/taGy9HQjjtG+8Fp+vs6DMKxTi7WRGvyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqOpHOejeydO14fIydiK6lfjieTMum4XbqWiGltuOJQ5zLMlZ1C+U7bKmDgzkIdnvrT1J3n/yxZ0ARXo6XUGpX9CfARDRbMDvd4Bht37VsUixQhhxm/1JSjVGhDmwIhC48ycLZ6FNTQu7eIEaFguxzELVZ67Mn7kLFTmDLVdQOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GppPyV3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FBFC433C7;
	Wed,  6 Mar 2024 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709743308;
	bh=wGBQne2ty3/taGy9HQjjtG+8Fp+vs6DMKxTi7WRGvyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GppPyV3rzK/xE80tjNFWepHf8hXDwBG28/3MXkYmRLJ1+A5Las0Ak2fTCY3lANmuQ
	 Y7J6njFEPsjWONxUxWZbw00mzqg/b05IgkQmZP0TyxkcjmqhsSLthX8wqe6xsDlRgW
	 N6aM9s4w3hsA9rm+uPV0Z8WQP8s+1LlzutUwUMKkdRMmOKbo69uWKlWBMgIXOkal3p
	 tqHq4rdqmW3kaOADWFMJL4gfPMJ4tTuVCEo3eHTPoL6PYyGMtfNoFrBTvnwatSiAQ4
	 viBpMCeiz3mZENWu3phlxvzVv1Fu6j7zYVak4uoiuThlQXjYTd2lqPZbcYczrRkEcT
	 zOV6KAWagcTjQ==
Date: Wed, 6 Mar 2024 16:41:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dave Martin <dave.martin@arm.com>, kvmarm@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 03/14] arm64/fpsimd: Support FEAT_FPMR
Message-ID: <c7e3d57d-92fa-4013-b0fc-e2941fb43d20@sirena.org.uk>
References: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
 <20240122-arm64-2023-dpisa-v4-3-776e094861df@kernel.org>
 <86r0h330dl.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T+O4zNYAuWrtYgTu"
Content-Disposition: inline
In-Reply-To: <86r0h330dl.wl-maz@kernel.org>
X-Cookie: Have at you!


--T+O4zNYAuWrtYgTu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 11:07:02AM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > --- a/arch/arm64/kvm/fpsimd.c
> > +++ b/arch/arm64/kvm/fpsimd.c
> > @@ -153,6 +153,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
> >  		fp_state.sve_vl =3D vcpu->arch.sve_max_vl;
> >  		fp_state.sme_state =3D NULL;
> >  		fp_state.svcr =3D &vcpu->arch.svcr;
> > +		fp_state.fpmr =3D &vcpu->arch.fpmr;
> >  		fp_state.fp_type =3D &vcpu->arch.fp_type;

> Given the number of fields you keep track of, it would make a lot more
> sense if these FP-related fields were in their own little structure
> and tracked by a single pointer (I don't think there is a case where
> we track them independently).

I sent a patch series that attempted to address this somewhat by
refactoring things so that we initialise the struct we bind during vCPU
setup rather than each time we prepare to switch away from the guest:

    https://lore.kernel.org/linux-arm-kernel/20240226-kvm-arm64-group-fp-da=
ta-v1-0-07d13759517e@kernel.org/

which you weren't terribly enthusiastic about:

    https://lore.kernel.org/all/86y1b027mc.wl-maz@kernel.org/

As covered in the changelog for patch 2 of that series the FP state
includes both system registers which KVM wants to expose via it's system
register ABI and FPSIMD state which the host kernel wants to flag as
suitable for hardended usercopy by embedding in thread_struct.uw.  This
means that pulling everything into a single structure which is used
throughout the kernel would require a bunch of surgery which I'm not
sure is worth the effort or ongoing maintainance cost.=20

The current approach is verbose but not complicated and localised to the
code managing the FP state, as I said in the discussion on that thread I
think it represents a reasonable tradeoff.

--T+O4zNYAuWrtYgTu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXonMYACgkQJNaLcl1U
h9B/+Qf/X/CYJWoG3QUjQ5cmho9TBU5+IqB0WCYPIzgJVWLlUrRY08PS7uM0PF8N
vNaNHLP8Z+zIOThBVW9/pBaXMN9m0jlecqbQAKL0lvtlpFMuzJP4zedWghG9yO+D
rdoghtMVlnOqhPffn3r6+m4XIpXPZ9LCG6qXErTRuqPq+sC43suO71htli7syZH1
TaiV35xQc16sCRmFfGtF9raNEIBNTti+SNYjaglAeQ/XvWIiLIGKKaOLtLyDEUIL
fmCY6Ky815C65RMnc6KwNTnVhv7wfQhpFBRmN2oswlJZbPOocYoNo1vGr1yKi+z7
zHvnBZOnpV5QqRJUCGzLlPE0DIB4hQ==
=MdZw
-----END PGP SIGNATURE-----

--T+O4zNYAuWrtYgTu--

