Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC26C290953
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405198AbgJPQHw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 12:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395322AbgJPQHv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 12:07:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A657120848;
        Fri, 16 Oct 2020 16:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602864471;
        bh=ZmO/4k2ftZ56y/+lfQGffcep5elGrT8utVwli6+PfH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gx5sqghFnhZAueCtn/mbbWibyetr6KpKIpgTOw99Dj1DKSQxOO0m+g3RIi0nAy0j3
         XLfqFFWDwG8YPyU/HIGizGu5zl64zhwT7wKGsEUlA0HO5LHfLd8bQcabC0tmmBBW8h
         MyQFRDugnhuoX4+UemdIq5Co9usLP10qD5vhJbo0=
Date:   Fri, 16 Oct 2020 17:07:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        David Gow <davidgow@google.com>
Subject: Re: [PATCH v3 2/3] lib/linear_ranges_kunit: Follow new file name
 convention for KUnit tests
Message-ID: <20201016160742.GG5274@sirena.org.uk>
References: <20201016110836.52613-1-andriy.shevchenko@linux.intel.com>
 <20201016110836.52613-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Content-Disposition: inline
In-Reply-To: <20201016110836.52613-2-andriy.shevchenko@linux.intel.com>
X-Cookie: Pournelle must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2020 at 02:08:35PM +0300, Andy Shevchenko wrote:
> Follow new file name convention for the KUnit tests.
> Since we have lib/*test*.c in a few variations,
> use 'kunit' suffix to distinguish usual test cases
> with KUnit-based ones.

Acked-by: Mark Brown <broonie@kernel.org>

--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+JxU4ACgkQJNaLcl1U
h9AHFgf/SXaRSbcsPDiK5DCs859xJdM4QsfNlLoJe6lWbDbDPh8MBfiMZmtZrD+A
/8d9Fg1A2mBRLSDuYJ++DsQTkeET3Oz7NVia8d04JhFg1CGOoaHJJ4kFK17ytc+o
PReWBRKOdAj6l37HMYlHIZagC9aJJtzcPJ+mZciUqsGmTN4K/HB4r8wJbCYhu1Nq
/SAetx7YH7iCCKPYRcZoKTbf6FEhNiW3YNgg8bkLTcvG7YxOT+YXOzCjRTiZY67p
y1BKh4mPjaPSLh01o4ztSO977dkxQbCzItISQ4S9jr6lGUAaG4ycmj4gSNN53gVn
oIySwavyUp2leFMH19I+u0BZ6Uk0Iw==
=21ke
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--
