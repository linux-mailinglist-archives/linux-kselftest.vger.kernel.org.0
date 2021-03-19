Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24853341C66
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 13:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhCSMUn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 08:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhCSMUc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 08:20:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF41A64F65;
        Fri, 19 Mar 2021 12:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616156432;
        bh=rn6jAzbbP50GmkDgKobeZZgcZxTcfVZQtfs6uQ0Stig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jREiiNaKerIggmPBkuAnhIrycchDeAAv+I8ZcRc9EahNlkqzJmVgWt0oBkhrUGxiY
         wro+HmZ3UiRkHI2ecIu5kS1tcd288JPvg6hTEUL72Eut6adOb7TXUWdbmGKZfuBzpI
         fTfJl5SVgqv3tSxhfkVaHMlXQfBYIjj99TnNdQcLmu5GVH7leievdKxWb22d2ynRFB
         i3ms50RhfM9KKk5HLaW+iIeC+xc7cM4nplOgpLvJNYugSNYIGzHHPoXiccg6h2kKnB
         IimrbJfqYnuKkgDzVWLpCKI0CxdqnN2h2O10yVAMxMqGIEt7Nnkl0jnGK+EpxJsaDE
         W0ymoN++gA+MQ==
Date:   Fri, 19 Mar 2021 12:20:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Martin <dave.martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: sve: Do not use non-canonical FFR
 register value
Message-ID: <20210319122028.GA5619@sirena.org.uk>
References: <20210319120128.29452-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20210319120128.29452-1-andre.przywara@arm.com>
X-Cookie: No purchase necessary.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 19, 2021 at 12:01:28PM +0000, Andre Przywara wrote:
> The "First Fault Register" (FFR) is an SVE register that mimics a
> predicate register, but clears bits when a load or store fails to handle
> an element of a vector. The supposed usage scenario is to initialise

Reviwed-by: Mark Brown <broonie@kernel.org>

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBUlwsACgkQJNaLcl1U
h9BRzQf/Spgqn2QBohXUfHZRk0bbIUR37vOlDcs33ImzdCDuA1VpECOCMjIpLfmZ
/+R1eOB4KQtG79ZoTg9TFPysIwzLflnuqgOKKuF4gphIiyWyIYwdhQiRHyXv+YD+
IziwV6AhY2sGjeBx5NikHkLN6aCFdTD5epyIkDTQg0Vg6plYje77CWyn2PgAIUjE
NVQz/IAuB2TwIUqOBOzTPXFdO4hKuTgpaWlRfDiMHwcgdyLMqu0A9+TJWYv+dWnl
rotZECh+NIoHsweH+dNEMJGDSn6qanuyp5Z9xanGXWASVK78bkXsBa4VUjdUdiC7
zOAKKL/nopwrCEdKMFEt5H2tIK09Nw==
=AfJ2
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
