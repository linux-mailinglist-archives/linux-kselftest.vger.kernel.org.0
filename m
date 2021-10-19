Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD69433A70
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 17:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhJSPd3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 11:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSPd3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 11:33:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10F2C60FED;
        Tue, 19 Oct 2021 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634657476;
        bh=g/LCTBJZlRI60kyyEyUXcMM+o+1u2Nv1vexSMBofSUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMg25ivd4K9M8XJOltU8d3i3UOGxekjY6SdvmEErDVssBcn0sel2gP4m+qggGXajJ
         rSMwX0dFkTz7lENStiMEvFLgpiN+rVGLcvhAUHTLsjc2ZtZLFFJsmACVUnS2cCUhXw
         keN5wILiVaMFF43xqJfSmTmWra1Yb4KG23rQeEeJGQUtL7J92qN4sY5ZK6XbejJ2XC
         BkXUihqL8KfzSYQtCmnYIADeujfYxVKlu7HKoFHuIRDTzqrgeJEqsQHyEt/zl/U/Ev
         Ue3JEAcT/LXu0J8DGyGn0D5jZNN7a1Gyti03t+jNbGF/4pRjYLXUP7LU68SaRKuKSW
         gykMfkta70Y6A==
Date:   Tue, 19 Oct 2021 16:31:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 04/42] arm64/sve: Make access to FFR optional
Message-ID: <YW7kwYuUR92WGtW1@sirena.org.uk>
References: <20211018190858.2119209-1-broonie@kernel.org>
 <20211018190858.2119209-5-broonie@kernel.org>
 <20211019101447.GA13251@willie-the-truck>
 <20211019135853.GA4938@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cON5Kj0vMEV+sjrd"
Content-Disposition: inline
In-Reply-To: <20211019135853.GA4938@lakrids.cambridge.arm.com>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--cON5Kj0vMEV+sjrd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 19, 2021 at 03:39:11PM +0100, Mark Rutland wrote:
> On Tue, Oct 19, 2021 at 11:14:47AM +0100, Will Deacon wrote:

> > > +		sve_flush_live(true, vq_minus_one);

> > What does the pcs say about passing bools in registers? Can we guarantee
> > that false is a 64-bit zero?

> Per usual rules, bits [63:8] can be arbitrary -- AAPCS64 leaves it to the callee
> to extend values, with the upper bits being arbitrary, and it maps _Bool/bool
> to unsigned char, which covers bits [7:0].

> So a bool false in a register is not guaranteed to be a 64-bit zero. But
> since it *is* guarnateed to be either 0 or 1, we can use TBZ/TBNZ
> instead of CBZ/CBNZ. Either that, or extend it to a wider type in the
> function prototype.

I'll change it to tbz - if we use a wider type then people will notice
using true/false with it in the code.

--cON5Kj0vMEV+sjrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFu5MEACgkQJNaLcl1U
h9CofggAgEbAKeDJFRcqMaNvwA/sOFpCIrmniB3gUgQExwulsuB9WHnX0itM8Ayu
hdiUpKt7H5bWN5cqR9Bhir1hD+LtUaXh5SqtR0bAVOMcahp8TjpNdfAlNCLEE3AL
lgw86omBDXoWSUOowr76jRKvNW748jgY63oOaJjlc2dkYWRoe6zOK5ThLC/DW3dZ
TtTybnxd8dHZPbx+sbNAM635mWpH8oi5YB6pHxy6JqzWagtrsqaSDi943E/rKwDv
EZhcXLw1QlXuaw5Wu0ZSyxxnB52nGqrVbRqe0S90u1DkIcfQkuHxqVnR6FaXcSNR
CTj1jBcRGS2DoooduFizhxjD2VdPfQ==
=kFg1
-----END PGP SIGNATURE-----

--cON5Kj0vMEV+sjrd--
