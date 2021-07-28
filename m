Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67E63D933D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhG1QaF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 12:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhG1QaF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 12:30:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDB9860F23;
        Wed, 28 Jul 2021 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627489803;
        bh=i2hvBXytdS2nZ3PdreajTt9YLOk1rxdVddLFQI0dwCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IhOnth2bU9L8dCa558prbHZRW/qMjWC9O6gpFNwd/eskuEsiQD6owtv/WpBKGyhmi
         3CObMliugw/0ikAqBnuCKk3r1wtBdJoZHOPB9mHXDwk+2HKagfMrqxqrI5NVWhfp/c
         KYyPDZfiyBWUtcjt8l3qsrgmz+RIgW7EbgA2HGUW3PBsmLzDM6DrWTJnHlGMGqHr77
         XKV8q0eu4GAv6jQCGBcv+PDy6tx9NdBl2nB34FU2kpyj2gdPyx2QLzFrdIy0oBrUoP
         Jq465YES8ix6JHOv4dPNtxABb5ImkzgA/PBZW6BHZ6HI6B69vY6dADtbMXBceB3I50
         5Z5AqoVthaLwA==
Date:   Wed, 28 Jul 2021 17:29:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 3/3] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210728162953.GF4670@sirena.org.uk>
References: <20210727180649.12943-1-broonie@kernel.org>
 <20210727180649.12943-4-broonie@kernel.org>
 <20210728094158.GC1724@arm.com>
 <20210728125918.GD4670@sirena.org.uk>
 <20210728134405.GF1724@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s5wWjIzCVkCTLRpN"
Content-Disposition: inline
In-Reply-To: <20210728134405.GF1724@arm.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--s5wWjIzCVkCTLRpN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 28, 2021 at 02:44:07PM +0100, Dave Martin wrote:

> This might be a bit clearer if the setup code was clearly separate from
> the tests, but so long as the ordering requirements are clearly
> documented that seems reasonably OK.

We can't really split the setup code out since the setup code would have
to rely on one of the ABIs we're trying to test which is all fine and
good until the tests actually help us catch something, we have to build
up knowledge of the values as we go and hope that the cross checking we
end up with helps us at least catch inconsistencies.

--s5wWjIzCVkCTLRpN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEBhgAACgkQJNaLcl1U
h9B/Egf/aHn8F/j7H8PIKwJWvggrQNUkM5kOU3pYPk4A1GT5wFf522pAG3UKTcOa
G+mG/HoNT7tETgQCHP9NGQO0kGx94DAXQP18uL8RkInYRiWcMPa5PkYckMx6vcUG
YxO2DWdKsUvO3cGhQHRhFasgO4SCiZ87IWn8PYDSOlMDNYsatrrWXLHlsnysxJ9D
CB8T514c8V9gm9wdM3L2G56ycg0SENTzV2mcACHGrq3XgQiMDPmOYMb0d57UOjiF
m3GFqI29iXZWNlxXq4opWCsKwZcZo/LA9rmE8rHqXXlF5O1iUaHeSJ4mJApPY4/z
oPPWMByXue0ZbV54/8S62R4Z0cruxQ==
=CeDa
-----END PGP SIGNATURE-----

--s5wWjIzCVkCTLRpN--
