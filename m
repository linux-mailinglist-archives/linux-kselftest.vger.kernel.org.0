Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD5F3D8E68
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 14:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhG1M7b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 08:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235204AbhG1M7a (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 08:59:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A31160C41;
        Wed, 28 Jul 2021 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627477168;
        bh=kLFFdjELukIaCubYfUjFa4qu5HNl/EGTInlrOnGO7a0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSX9k0Zc6ABD8PEYvyi5FC/VCcTp9fnpsFz7HsuT8svvT/2J6AF3luJQAvErJM287
         rO4zDTU6vaFzqwH3McaDFNILvRB9cCqFKSZSEDGKgvWCLBz6xhlgzCQPUbbD/3CyFL
         m+lTvq1v3jdA94xRF5NBA1AzPfT/RmG/PHw3A5LCr1uedBz38xUYS9PIAIkAQ/E9ja
         VTr2mCe5FrJP058xIINod/t5E5B2DRtuD94zmCevayG2iazBc2bTVIwDj8l7SQNojL
         U3PqbJH/LHkaZuFTWzMM5l58j78kGD9B3LqAUjA6Za2qeIHulhC8GZtcKcLh4c4gri
         0VqbuIvDZ4Sgg==
Date:   Wed, 28 Jul 2021 13:59:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 3/3] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210728125918.GD4670@sirena.org.uk>
References: <20210727180649.12943-1-broonie@kernel.org>
 <20210727180649.12943-4-broonie@kernel.org>
 <20210728094158.GC1724@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dKeYJkA19bNVVKdr"
Content-Disposition: inline
In-Reply-To: <20210728094158.GC1724@arm.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--dKeYJkA19bNVVKdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 28, 2021 at 10:41:58AM +0100, Dave Martin wrote:
> On Tue, Jul 27, 2021 at 07:06:49PM +0100, Mark Brown wrote:

> > We provide interfaces for configuring the SVE vector length seen by
> > processes using prctl and also via /proc for configuring the default
> > values. Provide tests that exercise all these interfaces and verify that
> > they take effect as expected, though at present no test fully enumerates
> > all the possible vector lengths.

> Does "at present" mean that this test doesn't do it either?

> (It doesn't seem to try every VL, unless I've missed something?  Is this
> planned?)

Nothing currently does it, and nor does this patch.  Planned is a strong
term but yes, ideally we should probe all the VLs.

> > +#include <stddef.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
>=20
> Not used? ^

We call exit() which is declared in stdlib.h.

> > +#define MIN_VL 16

> <asm/sigcontext.h> has SVE_MIN_VL.  Maybe we can use that everywhere
> these days?

I partly wanted the vector type neutral name, and I'm considering
modifying the sysfs ABI file to define 0 as a valid vector length for
consistency with accepting -1 as the maximum since SME doesn't have any
architected guarantees as to which particular vector lengths are defined.

> > +/* Verify that we can write a minimum value and have it take effect */
> > +void proc_write_min(struct vec_data *data)

> Could be proc_write_check_min() (though the "check" is a bit more
> redundant here; from "write" it's clear that this function actually
> does something nontrivial).

TBH I'm not sure people will be excssively confused by the idea that a
test would validate the values it was trying to read or write were
accurate.

> > +/* Can we read back a VL from prctl? */
>=20
> It's certainly possible.

The comment is describing what the test is verifying.

> Since this would test different kernel paths from getting the child
> itself to do RVDL / PR_SVE_GET_VL, it would be a different test though.
> I think this diff is still good, but beefing up the ptrace tests to do
> the appropriate checks would be good too (if we don't have that already).

Yes, the ptrace stuff could have a bit more coverage.

> > +	proc_write_min,
> > +	proc_write_max,

> Can we also check what happens when writing unsupported values here?

We could.

> If this patch is more about establishing the framework, these could be
> TODOs for now.

It definitely feels like something we can do incrementally.

> Can we be a good citizen and restore sve_default_vector_length to its
> original value?

We do that in the tests that fiddle with the default vector length, it
seems useful to keep it at a value different from min and max as much as
possible to increase the chance that we notice a failure to set things.

> Also, we should probably disable the default vector length writing tests
> if not running with EUID=3D=3D0.  Verifying that writing the default vect=
or

kselftest in general isn't going to have a great time run as non-root
but yes, it wouldn't hurt to check.

> length fails when non-root would be worth testing.  If running as root,
> a temporary seteuid(nobody_uid) could be used for that.

This feels like another thing that could be done incrementally.

--dKeYJkA19bNVVKdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEBVKUACgkQJNaLcl1U
h9D4lgf+OuvtDdSuhqqxyHhSgte5eo1LcTo/lCNNzyOvTopZ3+onG5rRMG+kEWCD
VgseWb7YWUgN0uFhwaEtwG7bSBP3q2f0/YGGYxpkeMZSl85Btx1v5Mb1vlY3q67f
ehB/B2DbGTPY5qKxTYv/SYjY28kpU8eGokIkCCqV7Q2SeJOBDE5xmkH0Sk/bOC/1
zsCuJbuIWHoKZP/Gf4SLDpoM8sQgRuIzzbLbsIg6MkXQkYY8djCuKEjcJC/CX9eN
4O6Om4x3jWvpIq7vMS176SsqqMOcVK93aAjqY7e60tKX7+cpF3nSkQjuxDqS4GkR
teAUGYwCJQ/kJEJLCuU+yMe1rL/4PA==
=vdbo
-----END PGP SIGNATURE-----

--dKeYJkA19bNVVKdr--
