Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9641E2902E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 12:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394396AbgJPKiu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 06:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394356AbgJPKiu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 06:38:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6364207F7;
        Fri, 16 Oct 2020 10:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602844729;
        bh=SVQmX2FRt+0DPB++BCHp2hugUtCUk/NsIDRTP016eCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/Y6udnwNX0J+aKAt9Ggz3+hdqQ+L2iIbQLYpbhI4s8oW9yJKQRkGSq55kPq9XZNR
         RDdbbaR0e4mUhlkylqpXiJsZXzvN21uEiOw8Mo2AfgtX4FpJSJGmLKps+dL2Pku3np
         JiljbRBrSnOxBTxeBbptN2FafYjRW6B+S7ZZgGZ0=
Date:   Fri, 16 Oct 2020 11:38:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v2 2/3] lib/linear_ranges_kunit: Follow new file name
 convention for KUnit tests
Message-ID: <20201016103841.GA5274@sirena.org.uk>
References: <20201015184416.38999-1-andriy.shevchenko@linux.intel.com>
 <20201015184416.38999-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20201015184416.38999-2-andriy.shevchenko@linux.intel.com>
X-Cookie: Pournelle must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2020 at 09:44:15PM +0300, Andy Shevchenko wrote:
> Follow new file name convention for the KUnit tests.
> Since we have lib/*test*.c in a few variations,
> use 'kunit' suffix to distinguish usual test cases
> with KUnit-based ones.

I'm missing the rest of this series - what's the story with dependencies
here?

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+JeCwACgkQJNaLcl1U
h9D/bwf/Yws4UPsJufuVL3X9itk8GXBZ8I2fhXafXIEiDCqQkkkbtUtkF28FqiLv
I97P+q2sAx0yYCMNC8vm7GanBIG2piIDQWiqG3nTfO87J8oLHaAdIvHkp4mFZHs1
leBvlBPhr+UOYWVzuns3C7jO1Hyd1t2+NZykA3xZAiJDuDYzmYpyI0mbxqpa93Ht
mY4/yRTODpSrree3xA3tD3hBOTV7VTsbJP+wCgj0DSg6SBVyx1FN/4Zh8qk1ix9K
A6Ffk4FVaEoMhicXWMa8nYtm48rGef6G1Wad9h37PkznFocDBJgoii3VakarBYkG
7dZSpDPAIWgYrYGQ3wdiI8fu099Ekg==
=dL1g
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
