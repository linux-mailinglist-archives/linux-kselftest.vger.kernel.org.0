Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D93B49B532
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 14:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385523AbiAYNg7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 08:36:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33290 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577514AbiAYNeN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 08:34:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA868B81807
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 13:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8D9C340E0;
        Tue, 25 Jan 2022 13:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643117648;
        bh=pJMyQhuuFBmj58qKusgKdVkV+CnMwFe0bFQsGC9tLjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7MlSLh5uI+RmIexbdKv7iK8kzfAQOIXtZANjrj123XSXrn/rqNVnW5zY5h7OVowK
         XKnY0UsvEhgJ3I5pJ+YbIrSlu3nIQgWoLt+UjuneRZM0CJpW1vjq4/d9nJSjNfaSVo
         S6MpTWg6ywQLDKBZMK+KVMmkRAUU36pQHoW0VGiAHXRnHwVmkQVZmZ6Px+26sqkE1C
         bDUmicdu0VoCHMp37X6QiZG/h7t53cdYdFkTfT1o0cQxeDrj0TDpN9T1czGpGHJtGZ
         weIeABHpELXG6gpOxfZsjE6ChRhwT8Q54vDxRfgHMkysIUlECLx9Rq/3SHvSr5w0Tq
         j6sfqoebxenWg==
Date:   Tue, 25 Jan 2022 13:34:02 +0000
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
Message-ID: <Ye/8SoZn2TJeShrl@sirena.org.uk>
References: <20220125001114.193425-1-broonie@kernel.org>
 <20220125001114.193425-27-broonie@kernel.org>
 <87wnio6n7d.wl-maz@kernel.org>
 <Ye/ygvnlzPKYT2z6@sirena.org.uk>
 <87tuds6jbo.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="83e/iXmvSHvukbBv"
Content-Disposition: inline
In-Reply-To: <87tuds6jbo.wl-maz@kernel.org>
X-Cookie: The second best policy is dishonesty.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--83e/iXmvSHvukbBv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 25, 2022 at 01:22:51PM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > > I find the use of CPACR_EL1_SMEN in some cases and its individual bits
> > > in some others pretty confusing. I understand that you have modelled
> > > it after the SVE code, but maybe this is a mistake we don't need to
> > > repeat. I'd be in favour of directly exposing the individual bits in
> > > all cases.

> > OK, it is just the KVM code that uses the plain ZEN.  I'll add a cleanup
> > patch for that at the start of the series for ZEN I guess otherwise it
> > looks worse, though that will inflate the size of the series a bit.

> I'm happy to merge such a patch early if that helps.

That'd be good.  There's also similar stuff going on with FPEN BTW
(which is I imagine where the SVE stuff came from).

--83e/iXmvSHvukbBv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHv/EkACgkQJNaLcl1U
h9DQPQf9GCKTKy4vTTTLzIlWshJTSRt31q72CwCyj/DNyVIr6JptpqeVFdrCGzmd
q1jbV7gjgj4AUBvx1sdjnLYAZr9JkGEMqJRYZ9u/23bkeGHx4hlTJUDwTunyBPrV
018rqaAibQu02YHYieZvvcWchrSLo+OG/L9OKcOcuaBxcvthPCYDoaDPs76/cEG+
1bQvnst3cfuSPSD+GXcssAZPbXSvmGcXViVOZ5dyVB36N3XVXG89zPs/4PtGBoO5
RVUPOZq/sq4PzR+0e7lV4xKjVkMmkfqFzYquLueE3XBVHY9vhLbwNdu12Qf+31Ss
qRhpcxR98hOBToPYMpwJgD1sip7+QA==
=IIxh
-----END PGP SIGNATURE-----

--83e/iXmvSHvukbBv--
