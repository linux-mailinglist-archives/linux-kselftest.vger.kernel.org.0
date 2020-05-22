Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156FC1DEB8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 17:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgEVPMZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 11:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729929AbgEVPMZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 11:12:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A18C4205CB;
        Fri, 22 May 2020 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590160345;
        bh=nS0h4RozeqQ2zDT71/b8HIMFM/1uZWrd6rex05YnTj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sY558fodh/SGqJTWRlnQq3JYI5dRHMV1MoEJNk/S989jp6HWgrNsREbRSFe2aTuxB
         bMR7hBan+N2rk4xcNKv7mH/sfCbQXcnBUxUfcPppUYJ1oCrRsU6hv0XkYniQdx3mcZ
         oKD065rICV/tvZ/KylRYjYy4A1m4yUV+N0O7zcLY=
Date:   Fri, 22 May 2020 16:12:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: vdso: Add a selftest for vDSO getcpu()
Message-ID: <20200522151222.GJ5801@sirena.org.uk>
References: <20200505174728.46594-1-broonie@kernel.org>
 <20200505174728.46594-4-broonie@kernel.org>
 <dff4dfbd-f3f1-d683-5dac-4404e9023b2e@kernel.org>
 <20200519174452.GR4611@sirena.org.uk>
 <0f1a7c29-340d-f61b-b102-d300932dc92c@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Content-Disposition: inline
In-Reply-To: <0f1a7c29-340d-f61b-b102-d300932dc92c@kernel.org>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2020 at 08:55:50AM -0600, shuah wrote:
> On 5/19/20 11:44 AM, Mark Brown wrote:

> > > WARNING: Missing a blank line after declarations
> > > WARNING: Missing a blank line after declarations
> > > #135: FILE: tools/testing/selftests/vDSO/vdso_test_getcpu.c:27:
> > > +	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);

> A blank line after declarations here just like what checkpatch
> suggests. It makes it readable.

That doesn't match the idiom used by any of the surrounding code :(

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7H69UACgkQJNaLcl1U
h9CYvAf+Oop8av99Ht92WyMXd28H0tQSfKAthADXU3g0Gr/J9LiaWJcY0xxlsOQZ
RkDr5YaYBi2Sy3Hq+W+cIekf52aFNIB/z1f18r8Nlsf4BbhrktPRj/jL7auo90vL
PckxqeCOTpYxL+Pd+WsjZWj8ow82l76fQGBDFAX1ycNsbLt4xHw6iHqrShKZnYGc
ZMe/Ky0Y6HqLYAoZA9q+AsDOlSajH+Qx6FnNc6t90tmrmY0WRVHCWgj2f8K7eVlN
6bQR8ZFiI3uSzMdO9PdUFIWyVEIbAI6jxYNFroALJfxeyz0MIkcQpYQfMwKUgxEs
U7rCjlgnhEUd5GmTPuIs8OmCZc4mGA==
=549M
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
