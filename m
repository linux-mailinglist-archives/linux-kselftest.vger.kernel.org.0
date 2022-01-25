Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550F449B672
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 15:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbiAYOgB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 09:36:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55734 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388731AbiAYOZx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 09:25:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF378B80ED5
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 14:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0BFC340E0;
        Tue, 25 Jan 2022 14:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643120744;
        bh=AAEEAEnnyX/L1DH7WC8/0Km2eJQRUtDNv04WJ7pfQAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c335kB7NRNmQyuY3LbHiWWUUhNJ86fldQs6hst8PLp9IMNMaTRN+9AST0UapK9FlL
         AK0pkuZN9WcyrHbIDWgEKl5boRHWH1vcesmo92RMXQiXLDwjDqPkBK/6E/DEq/BnOj
         lXmRAG6UlNVTl5CkM7xcz0u2Ts865Dne2q5eb8HhwdDDprTAi9JvNyDQLmKw6CRO1l
         8nbyFXkKAxS7aNDSRxh4RNCcpOgTCMLUsknYPo1lthhjJRQY/FjNGcTz0HrDpmN6NX
         Q3J8V7F1L3b/krG3MoowyL/HCNcVRyICWb2XfJtlsbl12TQ5hbZHQ6RorbzTCLFKNf
         9lN/Cc7njaAlQ==
Date:   Tue, 25 Jan 2022 14:25:38 +0000
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
Message-ID: <YfAIYp1m/zLKkmbd@sirena.org.uk>
References: <20220125001114.193425-1-broonie@kernel.org>
 <20220125001114.193425-26-broonie@kernel.org>
 <87y2346on8.wl-maz@kernel.org>
 <Ye/sS0jEXnBuumeG@sirena.org.uk>
 <87v8y86jdg.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YEhifuxFIuvQlt0I"
Content-Disposition: inline
In-Reply-To: <87v8y86jdg.wl-maz@kernel.org>
X-Cookie: The second best policy is dishonesty.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--YEhifuxFIuvQlt0I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 25, 2022 at 01:21:47PM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > OK, I'll remove the defensiveness here.  FGT is mandatory from v8.6 and
> > SME is a v9 feature so people shouldn't build a SME implementation that
> > lacks FGT.

> Can you then please make it that SME doesn't get enabled at all if FGT
> isn't present? It would also be good to have a clarification in the
> architecture that it isn't allowed to build SME without FGT (specially
> given that v9.0 is congruent to v8.5, and thus doesn't have FGT).

Right, this should be handled by the time the full spec is published -
it's an issue people are aware of and it's not something that should
ever get built.

It would be good to explicitly handle the dependency in the cpufeature
stuff, we'll have other issues like this, but I'd like to handle that
separately since at first look doing it properly is a bit of surgery on
cpufeature and the series is already rather large.

--YEhifuxFIuvQlt0I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHwCGEACgkQJNaLcl1U
h9B+Iwf/UgQEid+JO2QkdGR/J+t4OgReatZ/I57vAqYAESGun3agL/oLDXInx20v
eCGN2xA+iulobCXCAGt6m6oRNJhjux5DYsqlrakgTTzcFXDDli+O2igLbjtk0mGh
KkLjqK5y4ZNaspiYv8TncnOA6zG6KsMiRVQ+2/K+sfFaFXELoqsVdoYRDfxpEYRH
P8/ii51TJiXcpLSQ2XVUy1s3Zux3OqDGq3BPE9C8NRG0E24/Ca+fcH0QyWPFKfPH
OAgFgzukSkGpPDLJbnd1p3I3AONEyVyRBbYxNTisQiOPfhvl17mGFbaUzQumzkdY
DCzSIFm7LoUu+rhxz0R6Xjhl27iSrA==
=+7k2
-----END PGP SIGNATURE-----

--YEhifuxFIuvQlt0I--
