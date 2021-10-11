Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F32428DC0
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 15:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhJKN0K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 09:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236878AbhJKN0A (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 09:26:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C7DD60E8B;
        Mon, 11 Oct 2021 13:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633958640;
        bh=EijPaM9W0mPwUpENKtNwymqqsbdHgGtGwRe7gpMLQZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oM6k9c/csPucnurJrkStvKun3lcgd3+zxj1xlB6m3rS1+34OfS29lJBspH2nBd7qF
         pAz/ttsqgvkugTpAlZE5Okeamp6dPh36DiswpUy1uLM/U6lxFKPNYY+5npIOOFolZa
         8C6AI1WtZ5WtWU8g1Vwg5fD5mdKF85zm//SIPRNgoSi/qsZiMmzb478zSxlYjDKd50
         3NRatgp53aL035bnjTVuAeWXxJCfpxzgxgKeyXT5Fp//9gldLidUZfg7lmJTSlHqS6
         MAdt+1S/dQodoAHkVMZDMro4dvH8bcwE+/2srYYETs83s4z+CyWSUV1Ixgc3lz8O7G
         VHUAKTC+TILGQ==
Date:   Mon, 11 Oct 2021 14:23:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 12/38] arm64/sme: Provide ABI documentation for SME
Message-ID: <YWQ67ad5wfRgp9l7@sirena.org.uk>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-13-broonie@kernel.org>
 <20211011131730.GL2700@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e+dWKRrS7L0NT8W4"
Content-Disposition: inline
In-Reply-To: <20211011131730.GL2700@arm.com>
X-Cookie: Your ignorance cramps my conversation.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--e+dWKRrS7L0NT8W4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 11, 2021 at 02:17:30PM +0100, Szabolcs Nagy wrote:

> > +* PSTATE.SM and PSTATE.ZA, the streaming mode vector length and the ZA
> > +  register state are tracked per thread.

> can you add a note that there is a new TPIDR2_EL0
> per thread and on thread creation it's 0 (and i
> guess unchanged on fork).

Sure.  It's actually reset to 0 on fork() - would that be a problem?

> at least this abi makes most sense to me.

OK, thanks.

--e+dWKRrS7L0NT8W4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkOuwACgkQJNaLcl1U
h9BxqAf/d5GNqu04NDiHgeqYqUhItUF5yqFeSuZg+vOGYKIIyq9DETys3ZJVb/2+
3gniHrj4ntOnQPBA3IHbxGnAH2oZ1y8b7UNBAoyV3oy+q44/N6Phvay0AJ+GKkld
oLh4SYj0jetMOMLPiNB/6RO3H/pDYK0JxIztzDDAb2DvfU/ATOuTaj55HBf9bxED
S2yVABPUpFOWsNJujg0684V4xx/WQyS/Atx0rpQeisiFOssGgqdr4Q+A1cxTxQJ6
4L7HELBpLHRh+Jajtx4Ho9RXc9RDq+6NE33FoWyfJ6qRBbYxgBpO/8fdxr0CzjRZ
zVgzHFlyfXjdGnmufJgjM/edzCjgiQ==
=OQA0
-----END PGP SIGNATURE-----

--e+dWKRrS7L0NT8W4--
