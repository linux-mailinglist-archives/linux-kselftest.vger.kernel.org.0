Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6754336C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 15:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJSNTk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 09:19:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSNTk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 09:19:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E55160F8F;
        Tue, 19 Oct 2021 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634649447;
        bh=AO1utIzn3HlksXxw/tPApGLTScmglkP/vy4c3NTf1kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUky2395LRvtYFkpjsYIyuYo+aiYWORW3h8WGFESGk2bJd+ugnMojwAMhN43GoIhE
         aHDFBfHL/FGQclgKpe+9OfpIGe2yHqcVoJKuszPLmKmeHlas3RK+gMrePTWjLVmUXz
         Xqg/cHbjOChLRwZUs8SmVzOvviisfqU1/OaGjE/IVBDf9noyHdlV/igrmDtu3A5FJW
         LH5Gy8bLE6fzotlGR8K89h8ZITMBgHVUJhJqJd7fN2ZI2atnmmvPXA2VMv9+7zV3sJ
         OmeK+85e1xFbriZ50H2buIoPw/ljo4wN5EbKRLBcP6MfGj71WmlIe7VTFhHElvh743
         dYvPX9LL5bVwQ==
Date:   Tue, 19 Oct 2021 14:17:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <YW7FZf5FxGJJV2XY@sirena.org.uk>
References: <20211018190858.2119209-1-broonie@kernel.org>
 <20211018190858.2119209-5-broonie@kernel.org>
 <20211019101447.GA13251@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4JynMv7lS+7bIYBb"
Content-Disposition: inline
In-Reply-To: <20211019101447.GA13251@willie-the-truck>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--4JynMv7lS+7bIYBb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 19, 2021 at 11:14:47AM +0100, Will Deacon wrote:

> > -1:	sve_flush_p_ffr
> > +1:	cbz		x0, 2f
> > +	sve_flush_p
> > +2:	sve_flush_ffr
> >  	ret

> I'm confused by this -- x0 seems to control whether or not we flush the
> predicate registers rather then ffr.

Yes, that's buggy - it got broken with rebasing for skipping the Z
register flush.  Thanks for spotting, sorry about that.

--4JynMv7lS+7bIYBb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFuxWQACgkQJNaLcl1U
h9BnTwf+LwKtrqWdF9opVZuivEWDjISRuGNlA41n3FjVZdGc2P8FQKn9MWoNpN5V
ybAf8ooy+tPwsqy7HbZNIlgvnGMOkZcl6NegKBv2YoeyNgqHMiEvCuDvvld7axgS
IdP0V0VwdIWd4ODT+ZATgbSobSbyMCIhGhOkVI7Z1OG/3e1yU3QOD6BvAYn+WzJw
rt+OqKQl7T1QOmBfbE00Bl7fcZbPDYytd7xKejk/tX+QEN32QSr/1L7k5VHbYFam
KU7B0hpq6W5y3U5fTj6+zryPBXYQCGdLZUeKnm0oaaAB4mi8VX1DxlkjHUj2DeZm
4uzC8O4XSI6mNiCCcTweBwkB8bRq+g==
=Gqkr
-----END PGP SIGNATURE-----

--4JynMv7lS+7bIYBb--
