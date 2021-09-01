Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8CD3FD927
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Sep 2021 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbhIAMDa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Sep 2021 08:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243901AbhIAMD1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Sep 2021 08:03:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC3BC6101B;
        Wed,  1 Sep 2021 12:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630497750;
        bh=PZUBxYDRnOVPYWSHFQRrdCVWytJpgNo7LuOxHkoA64E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUvNuv02XEXCsWS+AA6bHQ7GjQ57uNzp1oufsP6yqHbKlrXuBWGHvin1vF6an90ec
         shcCf+JdUKIGCrtP76xFFY7UpSuNQ/gledBS2GszKgHlDHcKSbxdw5OF+plGbsbqQA
         K3dQFpHJWvivh+MHaoPYjNAzrzJwEdaa3llO/YaZgeLKR28qqKhe9ZMgRwVCnXltkq
         dl4FjWjSVK5vyBkpQApfUL0ufUsacDcte7RniXFfSzOcPzwkcqdKOP3Mx1TO8RtHJH
         vGw6XuWplv97KE4Ul+HQwWbl50EXgtX5V47onH3tB/7hVE11ApbcBoGZIB39d70jIF
         N3OKaBZbvtP/A==
Date:   Wed, 1 Sep 2021 13:01:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kernelci@groups.io, Tim.Bird@sony.com
Cc:     keescook@chromium.org, rmoar@google.com, brendanhiggins@google.com,
        davidgow@google.com, shuah@kernel.org, dlatypov@google.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, guillaume.tucker@collabora.com
Subject: Re: RFC - kernel test result specification (KTAP)
Message-ID: <20210901120155.GA5976@sirena.org.uk>
References: <CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com>
 <202108272330.AE55FCD@keescook>
 <BYAPR13MB2503A4B79074D8ED5579345DFDCB9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <202108301226.800F3D6D4@keescook>
 <BYAPR13MB25037E7EE38DE8717DC7D254FDCB9@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <BYAPR13MB25037E7EE38DE8717DC7D254FDCB9@BYAPR13MB2503.namprd13.prod.outlook.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 30, 2021 at 10:04:24PM +0000, Tim.Bird@sony.com wrote:
> > -----Original Message-----
> > From: Kees Cook <keescook@chromium.org>
> > On Mon, Aug 30, 2021 at 05:48:07PM +0000, Tim.Bird@sony.com wrote:
> > > From: Kees Cook <keescook@chromium.org>

> > XFAIL capture the condition of the test logic in that a test for
> > something arm64-specific on a non-arm64 machine is _not_ a "pass". It
> > will fail. But it's an expected failure. And, as a directive, must come
> > with the evidence bit:

> > not ok 1 PAN catches bad accessg # XFAIL PAN CPU feature is arm64 only

> > As a test author, I want to see this as distinct from failure and
> > success.

> I agree that this case is different from a normal failure.

> In the example you provide of a feature that applies to only specific
> architectures, I would use a SKIP instead.  It's not that the testcase fa=
iled.
> It's that it does not even make sense for the device under test.

That's what all the arm64 tests are doing at the minute - they're
skipping tests on systems where the feature being tested isn't
supported.  We've determined that the test can't meaningfully be run so
we're going to skip it.  We also don't use XFAIL for tests that are
checking that an error of some kind is generated, the test is formulated
as "error is reported when we do X" meaning that PASS/FAIL makes sense
directly.

There's a couple of XFAIL uses in other selftests but it's pretty
infrequent.

> > This is what we have now except basically just replacing "# $name" with
> > "test $num $name"

> Actually, I like this idea.  Including the number is a nice touch.
> I think that will help to distinguish such a line from other 'unknown lin=
e' output.
> I don't know if I'd leave the description off of the result line, though.=
=20
> A lot of parsers are looking for that.

It's also important that humans are able to understand the output and
the descriptions do help with that.

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEva7IACgkQJNaLcl1U
h9DAIwf/cJy2JDXJtSeQXblw3OFFnLEGSHyJYlnjSPFNerdt+bf6i2jQRAd5B+KF
fYh48HdgeWjBbVMl+55efWYM/mwdzCsBokD4drmlGXxftSaNvIHWYWcH8HAbeyl5
ZoFRhrKUxrcbGcmgF/Ki3H8pUzyihXnVONbdkUA76VXdV8OdwULJ1qUDcGoX20iC
MxN/lrhf9+nzVIyAziTxYCPlFWmISpgsDiKmB/RrbpP6bV5fqI+Wjlz6LRye0plb
724w1E5aahM4VIH6m5TkWNyMcOL27TshqUwIn56yviDEt33FTB1r+ZL50BC6nj4m
kX+36Vdpn/s0iN9+oWpHTVSegdLxFw==
=+z4Y
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
