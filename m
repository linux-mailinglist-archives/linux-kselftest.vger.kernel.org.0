Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11FF40F6FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 14:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243045AbhIQMDI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 08:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242369AbhIQMDI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 08:03:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B635460F13;
        Fri, 17 Sep 2021 12:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631880106;
        bh=RUT7ASpTn+2Nlyt32wE4o7/1gEeSD9PAcRoDCAHRIqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/WOyfERNJ0MCc1Z7ev9QD/maAOYM3+00NzEoI02QJrJz37tLj3GpI/p56cHD8NRb
         r+llgNQp1LsuScwJv6q+l0ylzup5j+17fLnF6ENqohmDXtThi7EhzRGPz1lh50ezmS
         gM2NV190g8nLp3s2/04Y8Ngd0Ru4km1e/FeNJvAZoisVtrMF2QCn2FDFIMV8AZrl3s
         sOE+vEiawpEtOKJMyXoRZgc/JXAVgIRa9xk5E2DmHMC5cEdW+ULgHkyKRbZ+qPauJb
         luizesG935mPWAbQpTaan5NcwR2oJ8mBlMg7akFmV017sMQ2qsRYD2Qjvv+I8d0kxG
         iRWbHxgnbeLvA==
Date:   Fri, 17 Sep 2021 13:01:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] selftests: arm64: Verify that all possible vector
 lengths are handled
Message-ID: <20210917120103.GA4700@sirena.org.uk>
References: <20210913123711.51274-1-broonie@kernel.org>
 <20210913123711.51274-5-broonie@kernel.org>
 <TYCPR01MB69937F4D2E0C9542ADB18194E5DD9@TYCPR01MB6993.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB69937F4D2E0C9542ADB18194E5DD9@TYCPR01MB6993.jpnprd01.prod.outlook.com>
X-Cookie: A man's house is his hassle.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 17, 2021 at 09:27:04AM +0000, misono.tomohiro@fujitsu.com wrote:

> Actually I tried to run these sve tests update on A64FX and got the above error:

>   # # SVE VL 48 returned 32 test logic failure

> but returning 32 is expected behavior as A64FX's supported VL lens are 16, 32, 64.

Right, I see.  That's not triggering on the virtual platforms since they
just support all the VLs.  Your fix looks right, it was supposed to be
an assert in case of logic failures but that doesn't actually work out.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFEg34ACgkQJNaLcl1U
h9DlJgf/SyWVcB5RFF24Ofe+NVhYP3UsnKuPoG1OaeOnTd78YiBO92ziMCTTqFCw
fjFd3PKEfd/NtxQKp10ZOd49VPja89wi8IICCdh44XKU7H3znqG2ytQfmWjuMFMB
33Y+vz2BIL7/gKhqjSXWD9eZuPXsB3k8UrmppwjglTKdC1Uld50eagREZ3TuSldI
czjH2jiE5uL6xuXe/HQ+tZkId8ubnIR0+LENsjx+8VkpEA3R645dMzsYuM32lHEv
WuE1pPwjmdaaJELkqJCqn3dSn9VwQJYW4vVFm2fuTtLiQRpslqS9V6hPCVsgELia
aN4EjbQUeBkWCVmg/7OtBAOEbNV1ag==
=Fo2P
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
