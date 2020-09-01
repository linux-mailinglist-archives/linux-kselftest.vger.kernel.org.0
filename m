Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABEE258D00
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 12:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIAKri (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 06:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgIAKrd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 06:47:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2D7206C0;
        Tue,  1 Sep 2020 10:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598957252;
        bh=eP4q1p11WzN5WKwI6hk4Fgwfr7yOfJDe2qOvgtwwQTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DyUUJmZwGkDbPfnBuDAsMAVRUYPLtj5Kr9BhIzz5qrnoN5aluJHp1WfhbaDgUwm6c
         Z3Tix+VNtTyCnPR8c0/jHtkHiPZGz+ifRX0ngD1nz8v9uFw5yBNlj4aAPqsnbafdNO
         nSQIWlFzoicfHMr3WRIxW4mz9XJ0gz+Muv1w3Tf4=
Date:   Tue, 1 Sep 2020 11:46:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3 0/5] arm64: vdso: getcpu() support
Message-ID: <20200901104652.GA6262@sirena.org.uk>
References: <20200819121318.52158-1-broonie@kernel.org>
 <315d97af-715a-9942-a731-11de2fbbbded@linuxfoundation.org>
 <20200901092551.GG5561@gaia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20200901092551.GG5561@gaia>
X-Cookie: Equal bytes for women.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2020 at 10:25:52AM +0100, Catalin Marinas wrote:

> Thanks Shuah for the ack. We are still pondering whether the merge these
> patches as they have some limitations (the per-CPU data structures may
> not fit in the sole data vDSO page).

They definitely don't fit, I did have some half-written proof of concept
patches that I posted that extend this but I was waiting to see if there
was any interest in a vDSO getcpu() at all before taking it further.
Vincenzo's work on doing the multipage user data that he announced at
Plumbers would cover it as well, I hadn't been aware of that.

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9OJpwACgkQJNaLcl1U
h9AJbwf+NnZaU2qy244rbX9A60dIIsoejhe2IdUqWfUtrupmdl8JK7s0VP5Bxh7z
0UeIlPxLb8xY7OalRrmWDLYEJAK9zVDVmRaUkuwWaKQICNAfkwq/G0aMXndKLBA3
CvQVNZXFuzW39z3W2e/+DZ3pwW2AYQmD6hiLv9Y7TTat+JM4CL73C1xH4R82Wsdo
HicEuEvSfuR0mvCcK2/W521PXabdaSPPQZAkhd41FflS3SXUgfTdUsdx4ZV00c36
Or6s+JRdKTQ5CyGb8cfdi4myEKu9kXAn6Lw7FOS5WUYDomiZPi7eTFHX0e6xTUZ5
2dWx1UbtRwR3o4anKiDjinQB2JgHUg==
=FH9R
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
