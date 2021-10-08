Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27368426F54
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Oct 2021 19:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhJHRGl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Oct 2021 13:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhJHRGk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Oct 2021 13:06:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA12960F92;
        Fri,  8 Oct 2021 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633712685;
        bh=ey0+fvC8gw7nNOGdfUzLmhoCou8ipC700hyDU1beplA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5z9KvJftZ7a3eU/aUtnC1DKy2H52FI6ikomoNAn5Xhq6pA7ueCGvzMaAEwnDuKVI
         Feau0ddPYzpFlKr0L55BO6rNMOs94fTNaKvW8iHhRRHXYrBlCg9DeAiNvU4BmJlYU1
         A99Slog9pDLEd2C+qH/k2FVAtAU3EejK2YFLgxbQjveCBSpXYrB9daCcLQ8P8avAiJ
         pt2XcSjW4hUv+a99CBGl2mpWhhV9SlXK1PEnOJZw5nsYychRKZq1QyJBeBQ0RlGE9T
         A9wS7o56HhzW45XccFGSb+bepp5RjxEotMUYIzmoffSl/tWa1hL/EZ/Z0Rls6UiIZL
         pdircUUk3jzxA==
Date:   Fri, 8 Oct 2021 18:04:42 +0100
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
Message-ID: <YWB6KmvHGfYBBoxK@sirena.org.uk>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-13-broonie@kernel.org>
 <59675B79-E426-4177-8A4E-43026E42B9E3@arm.com>
 <YWBjp8UnkMaHsZRA@sirena.org.uk>
 <0749CCC0-CCEF-4869-9F55-FD9AC97CBA67@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BKj2P4dn8TtsdD27"
Content-Disposition: inline
In-Reply-To: <0749CCC0-CCEF-4869-9F55-FD9AC97CBA67@arm.com>
X-Cookie: When your memory goes, forget it!
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--BKj2P4dn8TtsdD27
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 08, 2021 at 04:45:44PM +0000, Alan Hayward wrote:
> > On 8 Oct 2021, at 16:28, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Oct 08, 2021 at 02:11:46PM +0000, Alan Hayward wrote:

> >> Can NT_ARM_SSVE return a fpsimd?

> > It's documented that way for simplicity but in the current
> > implementation it won't ever actually do so in practice.  The
> > only case where I could see that it might happen would be if we
> > change the syscalls to stay in streaming mode over syscall, in
> > that case we could do as we do for SVE and preserve FPSIMD
> > registers only.  At present we drop out of streaming mode if we
> > get a syscall with it enabled so it's a non-issue, if people
> > agree that that's the right thing for the syscalls then we should
> > update the documentation to specify this since otherwise we'll
> > doubtless catch someone by surprise if we ever manage to start
> > doing it in the future.

> =E2=80=A6.or it=E2=80=99ll end up executing some code that was written to=
 cope with fpsimd, but has never been
> run. Might be worth making it explicit in the documentation.

I will if/when it gets fixed that way.  Actually, while looking
at that code I was tempted to remove the support for returning
FPSIMD only registers via NT_ARM_SVE entirely and just always
convert to SVE format - I'm not sure what the use case was there?
It's not a pressing thing but it seemed like it was a bit of an
implementation detail that we were revealing.

--BKj2P4dn8TtsdD27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFgeiMACgkQJNaLcl1U
h9Cbqgf/e7ugNRolFF/zV8GbCQvMPXqGFVIhJSaC5StLrcUz0hvBZD8HI5P1ZUhZ
Vuk+EXKd8Zj/sVzhpegJbKG8Fb10A5XXWzDnsYVaa8rZol3fSgYwzsnlhTr1Rd/D
4/hiah5A3DiAq32n4pJXrmvtHDhux8d7I5kHURsTsWsB2x0KXJwYisX3Evyeuh0W
9xQ/MmdjdEaNffXpzQDB83MhYAgGGE8pr9AFhjKUz4TN1lAxW5/XtZ8dOL519PmE
B6pvVhhTWyWfyQ5yEILCmJKZ7DTOge6VsHWHhQl+EUOakXe2SyivQZ+NJszHvKVO
g3FXZQiCGX7PltUOHxWAbhwqzkwlRw==
=68ex
-----END PGP SIGNATURE-----

--BKj2P4dn8TtsdD27--
