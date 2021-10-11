Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC8B428C58
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 13:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhJKLum (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 07:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236114AbhJKLum (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 07:50:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF39060E0C;
        Mon, 11 Oct 2021 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633952922;
        bh=Z1/JhxxEatT+l2NqNuffCCtFx2fY6SMTSZ9VwNJdlFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSEL6Y5FvTC7jFnEaXT5jMyBdAGK7dV3+aeP6Jg5KmH3Oh9SlxaqQMxXLsrvsjXXf
         55pxBu4ja90fq+ruvavx7yZlYoQs7OuxnCKkRJ5V6f/b/SX805suGscqUplucklBqx
         7GqjrZi4NnLG27CKab16cUQRmjjUZL58xETuUwIJui+dwxNp5dHhBGW9P9Ev3p1j6P
         cstCT/4/rdQHRkzFU3XbWyFnZStXxiwhZ30wrpReJ3kLIZL85eAUADSc05IU+8fNUw
         Y3u4axrlhJ2xSgQFxv6A0MII1F/Krq9e0hdBp2icVI21iviJkSYtdpyN9I+cGERBPo
         qq3oXJHgC9yyw==
Date:   Mon, 11 Oct 2021 12:48:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alan Hayward <Alan.Hayward@arm.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Luis Machado <Luis.Machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant KumarDwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v1 12/38] arm64/sme: Provide ABI documentation for SME
Message-ID: <YWQkmBpnFFiROFeA@sirena.org.uk>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-13-broonie@kernel.org>
 <59675B79-E426-4177-8A4E-43026E42B9E3@arm.com>
 <YWBjp8UnkMaHsZRA@sirena.org.uk>
 <0749CCC0-CCEF-4869-9F55-FD9AC97CBA67@arm.com>
 <YWB6KmvHGfYBBoxK@sirena.org.uk>
 <78C51A1B-DF42-463B-9B1D-AE96756C5854@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YByx5LhWlp99fXXV"
Content-Disposition: inline
In-Reply-To: <78C51A1B-DF42-463B-9B1D-AE96756C5854@arm.com>
X-Cookie: Your ignorance cramps my conversation.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--YByx5LhWlp99fXXV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 11, 2021 at 11:15:09AM +0000, Alan Hayward wrote:
> > On 8 Oct 2021, at 18:04, Mark Brown <broonie@kernel.org> wrote:

> > I will if/when it gets fixed that way.  Actually, while looking
> > at that code I was tempted to remove the support for returning
> > FPSIMD only registers via NT_ARM_SVE entirely and just always
> > convert to SVE format - I'm not sure what the use case was there?
> > It's not a pressing thing but it seemed like it was a bit of an
> > implementation detail that we were revealing.

> What about in the write registers case?

Both register sets accept FPSIMD registers for writes - we can't remove
that for the SVE register set given that it's ABI.

> With the existing code:
> Read SVE registers with ptrace. Get FPSIMD. Update FPSIMD with new values=
=2E Write back to ptrace.
> In that scenario, the internal SVE states stays =E2=80=9Cinactive=E2=80=
=9D in the kernel.

Right.

> If ptrace always returned an SVE structure, then writing back with the sa=
me structure would cause the
> SVE state to become active. It=E2=80=99s a small difference, but we reall=
y don=E2=80=99t want the debugger to effect things.

With the existing code - with the wider availability of SVE hardware
we'll see soon we might be looking at changing how the kernel handles
enabling and disabling SVE which might mean we want to change how that
looks internally anyway.  Part of what has me thinking about this is
that what we've got at the minute is quite tied to the implementation
and we might want to change that.

--YByx5LhWlp99fXXV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkJJcACgkQJNaLcl1U
h9BHqgf/bX8EzVZFKTIoBVOMUJIlFJ9rtZwWjw6JQkjf525ToIDJQORSPghVbO23
RMPHuwLkkyJ6kmIOo35wDG6A4u+mDloEGokvmtfuAHdAIdFQbNDvnMUCfZWRpRz4
LMFoxwqu/iyFsuHB0e+/H/BN1Ac4HBWSGKFG2JSiivzqJQOpS3CMFUscI+T16bRI
dwnXmEz0/CRoiqtQmLje7M/nvSoy4AKk4sY+TFREi+jvD6To+ynrWx/5eVvk/i8d
lwPNreWw1oMCNjW/8ZLH2FkhzXdj8usuw+pYnm7TYJlyfvBySLYlTEJL2bUN13/n
sAz+pXFplABmLPYbNUIStBDTc5gM5w==
=Uo00
-----END PGP SIGNATURE-----

--YByx5LhWlp99fXXV--
