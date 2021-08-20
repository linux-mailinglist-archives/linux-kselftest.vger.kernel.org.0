Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3442C3F2A69
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 12:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhHTK4f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 06:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236704AbhHTK4e (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 06:56:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44CB3600D4;
        Fri, 20 Aug 2021 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629456956;
        bh=pNzeo+dC7F7C0L5UHKn08ojv7QJsY+Okrc8M70gIj6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FtvXGPRgKN4WCosxAJDe+/2HWIXHIn5APAAXtAr08xshkwmcUeWTqu/uMhnSUY42g
         CGYxZXcnGZMfHSDAcCmK3iL8v7a1hk4jEwQomgQguah+i/HOyJeLsY5ZkTpf+fsMEq
         znwx+rgYAYw0vuvHoZ0GH1zQbO8rFEXtyZ3zRziM1BoyDzjMIrIVHEjqG+xaHJuu7k
         BjMBha/8ptyYBd6Jmz6PYhFzPcaN0x9APyQ/SjB/nImgdm4W3xa8swfUv7pBpDElsX
         jhTv/vn5oMPl1RUvUxLWn5QCdntcfeweVRxhejvaKDfj4RHaukfHX7Lge/m7lUk8E/
         dPJeXwbtiwGOw==
Date:   Fri, 20 Aug 2021 11:55:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kachhap <amit.kachhap@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Boyan Karatotev <boyan.karatotev@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: pac: Fix skipping of tests on systems
 without PAC
Message-ID: <20210820105531.GP4177@sirena.org.uk>
References: <20210819165723.43903-1-broonie@kernel.org>
 <a988b3e2-5f88-fbd5-99da-2066a65a17b2@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wg9FEZT+WCTrEXgJ"
Content-Disposition: inline
In-Reply-To: <a988b3e2-5f88-fbd5-99da-2066a65a17b2@arm.com>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--wg9FEZT+WCTrEXgJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 20, 2021 at 12:39:39PM +0530, Amit Kachhap wrote:
> On 8/19/21 10:27 PM, Mark Brown wrote:

> > -	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled"); \
> > +	if (!(hwcaps & HWCAP_PACA))					\
> > +		SKIP(return, "PAUTH not enabled"); \
> >   } while (0)
> >   #define ASSERT_GENERIC_PAUTH_ENABLED() \

> May be ASSERT_GENERIC_PAUTH_ENABLED can be replaced with
> something like VERIFY_GENERIC_PAUTH_ENABLED

I thought briefly about bikeshedding the name but didn't come up with
anything that was sufficiently better/clearer.

> or can be modified like below and instead of failing it skips with a
> message

>   -	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled"); \
>   +	ASSERT_NE(0, hwcaps & HWCAP_PACA) SKIP(return, "PAUTH not enabled");

That's what the patch does?

--wg9FEZT+WCTrEXgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEfiiMACgkQJNaLcl1U
h9ABjAf+P9BQBCTfU+zANNleFksY6DTxTrpNu2uac7qzh/ZU5EFPu6wgnmAPKwn8
CrFhDsS6ma49q7ySDQQVBrI0DJGho5lvepnQHHrm/SlHjOuc7PRfPRThthc6XJU+
FulLKJBf6t+VsPY14/rd7bBSpJMmxFZ/sG1chl2zY/a/qzdCiZvPZaIKuwttOjCu
4vahoTEK6TAJKNuvmwPcxvEPxvaLKBAhGLcZySaYqTvUOd+c7OHGHFgs363gfQmt
0RPRPGAjN4L7rV74HtIIyFE69AOXK3GdKnp+/mKDVMZcFnW+zCoZN7c1cyXCHcSx
28kAuWh5hVY4bVN2+nSKkQxmcinBoQ==
=kaQv
-----END PGP SIGNATURE-----

--wg9FEZT+WCTrEXgJ--
