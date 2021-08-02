Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32F03DD4B4
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 13:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhHBLdx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 07:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233441AbhHBLdx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 07:33:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E127C60F4B;
        Mon,  2 Aug 2021 11:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627904024;
        bh=ETjiRp4RWcIChldICOLEeBkE1mkefOXseWhHz53/wEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkbylYwpOgZRTiMdfOw02FcXJCXGfJUtI0FdaTayS4jeWoUYde4sKwBhbCVkYKPrR
         7u+pEqLVga05WETtXqnWOBtRDmlNaGgAIL6RIDvxy62k7K1AAfawXEAqXCbzzCL1sx
         TO1dDPbiKsIbxdFfM5SlRKquF3Ryt2Vi3aOJ9qJxMA1nkTULGtGixUE/A1jXzgNCC9
         /IW/ieTiBdld6GjbVICepR3TZvtkvzYPAjQkbRY6iaNe/Rsn85gnNogMUXhe4wlejp
         NbzmiQv/kdcbYYA/FZrtL4p0XPdnHbvCDqlwYpMQS0ye2xT1Y5zWSvV+Cf1O+IMHZF
         sU/WINm0ExigQ==
Date:   Mon, 2 Aug 2021 12:33:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/4] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210802113330.GD4668@sirena.org.uk>
References: <20210729151518.46388-1-broonie@kernel.org>
 <20210729151518.46388-4-broonie@kernel.org>
 <20210729160642.GP1724@arm.com>
 <20210729173411.GT4670@sirena.org.uk>
 <20210802102517.GA25258@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <20210802102517.GA25258@arm.com>
X-Cookie: There's only one everything.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 11:25:29AM +0100, Dave Martin wrote:

> That's a reasonable position, but thinking about it a bit more, there's
> not really any loop at all here.
>=20
> There definitely is an unwaited-for child and we don't pass WHONANG to
> wait(), so it will either return the child pid, or fail.
>=20
> Without WUNTRACED or similar, the child must terminate to wake up the
> wait().

> So is this just a matter of

> 	pid =3D wait(&ret);
> 	if (pid =3D=3D -1) {
> 		/* barf */
> 	}
> 	assert(pid =3D=3D child);
>=20
> 	if (!WIFEXITED(ret)) {
> 		/* barf */
> 	}
>=20
> 	if (WEXITSTATUS(ret) !=3D 0) {
> 		/* barf */
> 	}
>=20
> 	/* parse child's stdout etc. */

That really doesn't seem like a good idea - it's just asking for
fragility if a signal gets delivered to the parent process or something.
Even if almost all the time there will only be one trip through the loop
we should still have the loop there for those few cases where it
triggers.

>=20
> > Please delete unneeded context from mails when replying.  Doing this
> > makes it much easier to find your reply in the message, helping ensure
> > it won't be missed by people scrolling through the irrelevant quoted
> > material.
>=20
> Hmmm, usually I at least try to do that, but I did seem to leave rather
> a lot of trailing junk that time.
>=20
> (Working out which context is relevant is not always an exact science,
> but in this case, it looks like I just forgot.)
>=20
> Cheers
> ---Dave=20

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEH2AoACgkQJNaLcl1U
h9BJRAf8CRjFVPaTCZPv8AagtdjI4pKT8+eIYEgfknVdQLEeS+FN8EYFh/5/9U7/
J7srpYbKLvndRotZE8r8Qx6yeU6WJSkaqYXi2eJbZMlePu3wW3aSkDev7ouCWliQ
E6r09KEbfH3F4RmMMnbN/YpT2hqHXhob3Zuk1vo/Oy0gn3m0Xm+szDlR8Q75Ourh
xNd5XwL/c2Awwko6uphv+pb43FUFCYpaTKSQp+EcCQGHpX21kzCAv7uQykREnABE
8CKYc3cPM6tPggSFMIzZMkzroEiq0Jlmgjlmoj303XH9IP3jivmHbzw0hxH4CKjw
5VfXCwS/MRhCepXYYlYFAS+F1HJUQA==
=6sOp
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
