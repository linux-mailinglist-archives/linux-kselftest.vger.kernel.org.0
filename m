Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D45049B401
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 13:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450926AbiAYM2i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 07:28:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59460 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382901AbiAYM0A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 07:26:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55BD9B817ED
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 12:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DDFC340E8;
        Tue, 25 Jan 2022 12:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643113554;
        bh=5B9ipYG7P2XAgJiApkrkAj/aL+rVlE6P2bCU9qSvapk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PS9tLmv0jJluiKXrT6PmvhZ/8nrKq52kM+3Ipn1TbFwOWu0GUUTP4RD4RgTKcRMAI
         mqJwDpEi6BJMVRl4JVSZkm6N181F7XGH6io2CR67oRP74Uf3//Xqy9GbY7wGB9JZJh
         A25OKzB99K2UJ31J4UX9loeAeziFbI3ACh0Fr/0HF75LvTg+v2bqf0WUd/UH5hJG01
         HoxHQ/GyR5Y5/zXYI1VVF6u9+JS2lnr1mlSBpSrX1TSMaMtC9uUhOqxLVTV7i8lFwJ
         0mkCF5Y5UGDoFXzcRg3NQ9gfgNt/ai5w9aXbSDWtieYH1TXf3/+iGb4d3/QFUAdMrV
         p/Qjm657opWLw==
Date:   Tue, 25 Jan 2022 12:25:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v8 25/38] KVM: arm64: Trap SME usage in guest
Message-ID: <Ye/sS0jEXnBuumeG@sirena.org.uk>
References: <20220125001114.193425-1-broonie@kernel.org>
 <20220125001114.193425-26-broonie@kernel.org>
 <87y2346on8.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlKet4hlDtIiiSTT"
Content-Disposition: inline
In-Reply-To: <87y2346on8.wl-maz@kernel.org>
X-Cookie: The second best policy is dishonesty.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--HlKet4hlDtIiiSTT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 25, 2022 at 11:27:55AM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > +	if (IS_ENABLED(CONFIG_ARM64_SME) && cpus_have_final_cap(ARM64_SME))

> Please drop the IS_ENABLED(). We purposely avoid conditional
> compilation in KVM in order to avoid bitrot, and the amount of code
> you save isn't significant. Having a static key is more than enough to
> avoid runtime costs.

Sure, I wanted to be extra careful here as this is all in hot paths and
going to get moved elsewhere when we have real guest support.

> > +	if (IS_ENABLED(CONFIG_ARM64_SME) && cpus_have_final_cap(ARM64_SME) &&
> > +	    cpus_have_final_cap(ARM64_HAS_FGT)) {
> > +		val = read_sysreg_s(SYS_HFGRTR_EL2);
> > +		val &= ~(HFGxTR_EL2_nTPIDR_EL0_MASK |
> > +			 HFGxTR_EL2_nSMPRI_EL1_MASK);
> > +		write_sysreg_s(val, SYS_HFGRTR_EL2);
> > +
> > +		val = read_sysreg_s(SYS_HFGWTR_EL2);
> > +		val &= ~(HFGxTR_EL2_nTPIDR_EL0_MASK |
> > +			 HFGxTR_EL2_nSMPRI_EL1_MASK);
> > +		write_sysreg_s(val, SYS_HFGWTR_EL2);
> > +	}

> If the CPUs do not have FGT, what provides the equivalent trapping?

Nothing for nVHE mode.

> If FGT is mandatory when SME exists, then you should simplify the
> condition.

OK, I'll remove the defensiveness here.  FGT is mandatory from v8.6 and
SME is a v9 feature so people shouldn't build a SME implementation that
lacks FGT.

--HlKet4hlDtIiiSTT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHv7EoACgkQJNaLcl1U
h9CPdwf/bepHM47acsAUJ/1SIELl2t6fb0e3PrHQy3ufg4GKQoisB2ANDhSGiKsa
3OuSW0C6z4VSsOMnjzoiIBHO0mpQ1Q0lGtZoZk5kiQMASY5kvzIvebAwxxQZ3+NT
kEqUu1zQHln1+t0vIrQX4W5aOV+B2PP1WIVEmWYRETuHYmBPJTWLymDzVORJsCDu
uXBhoLNH10E/7D8ouGsYrYKFhJdiWoBsSstWUszgsq/VYHOJmAjhc7phBP9roUwY
7m/O5xgUW8uIKRBLmjOYJGPdCxZxbN8sWmXdZVxDW3DeThj0EspdSsZ5Ruaib9Ws
cJZA2h5jK5cJwpyCWb7vltdzl03rhw==
=m+CQ
-----END PGP SIGNATURE-----

--HlKet4hlDtIiiSTT--
