Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8072903D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 13:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406803AbgJPLMn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 07:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406802AbgJPLMn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 07:12:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E1D7207F7;
        Fri, 16 Oct 2020 11:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602846763;
        bh=vD+hWuFYQbpI7FKukNRvn0j/lyn5YOtPaoQa962+vnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgt/3hc7y1lFGQ41t+tvn286Rhm+urshXXkvkSwBjOG0L+A1KVzpsXyKZQd4CaFAw
         /8HfJcQYu39qUsJyPxjCMbSHqNPMVwPZ6d9BCMlSWCn7JGebuw1YO1QGCftYhHxm7n
         CGEm5VouerIc13+EELsoIdlCt4g4dkC5RYSvGzQ8=
Date:   Fri, 16 Oct 2020 12:12:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v2 2/3] lib/linear_ranges_kunit: Follow new file name
 convention for KUnit tests
Message-ID: <20201016111234.GB5274@sirena.org.uk>
References: <20201015184416.38999-1-andriy.shevchenko@linux.intel.com>
 <20201015184416.38999-2-andriy.shevchenko@linux.intel.com>
 <20201016103841.GA5274@sirena.org.uk>
 <20201016110344.GJ4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20201016110344.GJ4077@smile.fi.intel.com>
X-Cookie: Pournelle must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2020 at 02:03:44PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 16, 2020 at 11:38:41AM +0100, Mark Brown wrote:

> > I'm missing the rest of this series - what's the story with dependencies
> > here?

> There is a dependency in Makefile. Do you want me to send a new version with
> Cc'ing you all?

It's fine this time but please don't do this in future, people need at
least a cover letter so they know how things rae related to each other.

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+JgCEACgkQJNaLcl1U
h9BxbQf/ZyruSpx9Kqb2YFF3YMHqT/BPqeTFtkDNxoFmwH5eDLkJGlo2V1obbEO/
XPjZ5vmSTG5yhWV2bc3nmU6qiGZZfY4GI8SjY6CCzCPIQr0rjdVHr9cWX248KvLp
+xN1DAfLGXuE8cmnRXPARXH9wUKzsYy3YkRPTnAmxJ24umzSFEyOaiVG+g7OEsTp
ODOo9IE8gq77CjQjEY6BWF5ekalmIfJqKtx16vEQr4tlhw7WgKc0jVyJAAaBT4bw
9KQouHB1PTd6VyHvLFjqRQOGVjBpxSakCSUs+89sKIdtdAFFxDL8xGjwNzfd/W41
ir3/3G7VndovWbdSJKTubFyiLOhkTw==
=S9jZ
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
