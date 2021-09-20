Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1EA411484
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Sep 2021 14:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbhITMd1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Sep 2021 08:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238218AbhITMd0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Sep 2021 08:33:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 778E960F4B;
        Mon, 20 Sep 2021 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632141120;
        bh=Uux/2Cc70BUzmHbCJBRHEOFQH+Jr1wcoLMV9FMrSuPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/9kWfLMyj0Zzz/+7NKVDzT2gOyL10S0dNKxxwayJjpiDJfSa8PsJHMiOoHH9np/7
         fFNRmGtNlNk31MgWVPFpmCJtab87j20z0ACPus+NL8npAYW9GlvIEW8sDC/kz3NYgW
         D51fnwr5dPxhXu7ykHOsFFt74ATB8A+S7koDqqDsMXb9uQJW6f37/dxYrum7LB64E4
         0IBQhmQut7QjEHc/CdB19zA1PNdNt7gqkp217bCa4IWCXvNAKQ7+r2cBJSTylSvfWJ
         ZEvU7JSKxCnuFAFR36l4Sl+3F38tL12lDm0X9+adm/3BQfD5HNn4fcZU3wG7+nXSQ1
         qIFKls9Zm6ANQ==
Date:   Mon, 20 Sep 2021 13:31:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] kselftest/arm64: signal: Skip tests if required features
 are missing
Message-ID: <20210920123116.GF4192@sirena.org.uk>
References: <20210920121228.35368-1-cristian.marussi@arm.com>
 <20210920122240.GE4192@sirena.org.uk>
 <20210920123014.GA6510@e120937-lin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <20210920123014.GA6510@e120937-lin>
X-Cookie: diplomacy, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 20, 2021 at 01:30:14PM +0100, Cristian Marussi wrote:
> On Mon, Sep 20, 2021 at 01:22:40PM +0100, Mark Brown wrote:
> > On Mon, Sep 20, 2021 at 01:12:28PM +0100, Cristian Marussi wrote:
> > > During initialization of a signal testcase, features declared as required
> > > are properly checked against the running system but no action is then taken
> > > to effectively skip such a testcase.

> > Reviwed-by: Mark Brown <broonie@kernel.org>

> > I have a version of this locally which I thought I'd sent out already
> > among all the in flight patches I've got for kseltest but it looks like
> > it didn't make it.

> Ah ok sorry, I did not know. Pick either as you wish.

No, please use this one - like I say I thought I'd sent mine out but it
looks like I didn't.

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFIfxMACgkQJNaLcl1U
h9C1wgf+NQ/8kb/cwNhHFV2OhVXQa5JedDzJWq9DtdVu2IHM5+f6F4j2xC3eWS0E
KZ/07GGv3NxfmI1FvwmqS1miDzPZ2SH8NoIPwuPAGu/PAcfukFV7maUFZXEYzGsq
UdJ2jf5QJ/8p9QQqPdutUeY0+E1Re4nQ5T7oMEf6p0ObXCZImHNEg0Qg1+AzyYCV
Fq29DGGHTlUxE3jWGXGlbjHLYrMleQfsznViuvQQoBj0qBCUUgaiQVfmgKxUTsMh
cAMTrhP7TFPwcYYli8Efm6eLrvka+eAdYS+oh+hkBgWvCXlppUJCw60uJwAviSky
INh2idtsuqBwYIferxOOVhH6CPzEvw==
=5o6W
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
