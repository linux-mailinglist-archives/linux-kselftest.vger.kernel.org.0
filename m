Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05F649B464
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 13:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443368AbiAYMym (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 07:54:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53618 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457591AbiAYMw1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 07:52:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84AEF6135D
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 12:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C87C340E8;
        Tue, 25 Jan 2022 12:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643115144;
        bh=v0FpQ2FqcGsRyWxNTDzGDDdUHBpQFuTqv/W9HGKRr/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAUsOJDG7jv8KWz7/qbyX9tPKq29KB8ajYN+T6vd0AzxvyMlhZObgNQLmo0fBORbt
         8/W9UcLtNg3lJ5/vuFjE5K+JS24ytUuHBkmKikam6SJQDQ7PjjPOTu2Epui6eRZKId
         yds1FqJ6rx6iKE3nIzphE6iGlP/D2lsWwPfmjaJKQYLPLxqUNWPUUdeoifMzR11+Lx
         +OxEku+cBS78xkynrWuLjcGq9xYkH/eglXwS26dS0aclHRNE3/IWCe56YHfl6+x4UE
         ZpELsAeltyMVf7P1IhhZbJeAJgK3TmyPjGjy3SyhUdSPIoMo754sqtccNQoHlVkobT
         Zm15izsNhSsSA==
Date:   Tue, 25 Jan 2022 12:52:18 +0000
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
Subject: Re: [PATCH v8 26/38] KVM: arm64: Handle SME host state when running
 guests
Message-ID: <Ye/ygvnlzPKYT2z6@sirena.org.uk>
References: <20220125001114.193425-1-broonie@kernel.org>
 <20220125001114.193425-27-broonie@kernel.org>
 <87wnio6n7d.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g/kTMzpZSB0D4ujj"
Content-Disposition: inline
In-Reply-To: <87wnio6n7d.wl-maz@kernel.org>
X-Cookie: The second best policy is dishonesty.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--g/kTMzpZSB0D4ujj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 25, 2022 at 11:59:02AM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > +	if (has_vhe()) {
> > +		if (system_supports_sme()) {

> nit:	if (has_vhe() && system_supports_sme()) {

> saves you one level of indentation.

Yes, for now.  IIRC there was some other stuff there when I had some of
the code for doing the register switching properly.

> > +			/* Also restore EL0 state seen on entry */
> > +			if (vcpu->arch.flags & KVM_ARM64_HOST_SME_ENABLED)
> > +				sysreg_clear_set(CPACR_EL1, 0,
> > +						 CPACR_EL1_SMEN_EL0EN |
> > +						 CPACR_EL1_SMEN_EL1EN);
> > +			else
> > +				sysreg_clear_set(CPACR_EL1,
> > +						 CPACR_EL1_SMEN_EL0EN,
> > +						 CPACR_EL1_SMEN_EL1EN);

> I find the use of CPACR_EL1_SMEN in some cases and its individual bits
> in some others pretty confusing. I understand that you have modelled
> it after the SVE code, but maybe this is a mistake we don't need to
> repeat. I'd be in favour of directly exposing the individual bits in
> all cases.

OK, it is just the KVM code that uses the plain ZEN.  I'll add a cleanup
patch for that at the start of the series for ZEN I guess otherwise it
looks worse, though that will inflate the size of the series a bit.

--g/kTMzpZSB0D4ujj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHv8oEACgkQJNaLcl1U
h9AbDgf7BGgVAuzrvNsIsDdC5IPALhwPBZ4yHOUqqUx68sa/YCRWjKn/HIIzHQb7
ZpmK+BCPHMwsaq9L1U0pKc2R9fv1Tysq718RzbjkakHjDTjX/myMdOURVGo+PvJc
cRwvN7J67L7uphIGBs9Zw7eFe7hZ/UhaXqUA2DcR8wEGxM3INgLzi8mlGpUPBCMN
4d+glYNXhy4CA+GOqBbAhi99Ap29zBBi7a2+97eUviYrUWuSIylEKJYnt7mEvqRd
PncYFUlT+3VTIKGZxj+xqK+c70dJ7vvLm6kLWx/KMOexeJ9uJcCXkyeo4UVfBneh
ShqSHbhaHl1BeVT5rFN8GMCOKu0ckA==
=EO4F
-----END PGP SIGNATURE-----

--g/kTMzpZSB0D4ujj--
