Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47FF3DAA6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhG2Rj7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 13:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhG2Rj7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 13:39:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F47360524;
        Thu, 29 Jul 2021 17:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627580395;
        bh=mmDY8AS4v+vHibyzVuquOCu8O3tMgQ5dby/SCQ3rQsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IdzwUXFeCxedTiudYkaeT+iVhRAiRPGdOsVybFeq12V9P8DSZW1U3YaPOQ+8qUf6E
         1hzW5OPh2YgH+Akgi7hzJI/jGCfmZFP9LRXoxVKBoiZF4dykC2dqtmymUagWS0q/vQ
         onhZKMhhIJP4ZbRua3kuO9qgxS0+5KblA4SwryZ6i7wdXL8iDcdt2M6ZxNhIpt3ad7
         0Iv5kD0t9JX1LBSnrkkebnXA2+rjFJWVls9TX9+bBO33+kl4Hb7zsvIZSqpohhGm5L
         9flotTi30CUORGYIy67qapG65j9k++6VP44ozmuCMJZhMt93uGeRY3Ta8kp9E6onwz
         CIl/e7cNSof1Q==
Date:   Thu, 29 Jul 2021 18:39:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/4] kselftest/arm64: Vector length configuration tests
Message-ID: <20210729173945.GU4670@sirena.org.uk>
References: <20210729173713.4534-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ff5AkW+g6+eEohN"
Content-Disposition: inline
In-Reply-To: <20210729173713.4534-1-broonie@kernel.org>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--7ff5AkW+g6+eEohN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 29, 2021 at 06:37:09PM +0100, Mark Brown wrote:

> v3:
>  - Add BTI landing pads to the asm helper functions.

Sorry, forgot to hit save before I sent: the v4 changelog is:

v4:
 - Fix fscanf() format string handling to properly confirm the newline.
 - Pull fclose() out of stdio read helper.
 - Change style of child monitoring loop.

--7ff5AkW+g6+eEohN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEC5+AACgkQJNaLcl1U
h9COIAgAhs7FWWI8Rbge4SvxGRpRz0x8Y1Ib9YgFvsLXn9rgBQBJVrOi3xG36yYi
aryBADNtfCXrenvABEYJg9wWGWE1CxOx+Ku49/5BrZD+RYRXRhJOtdRBfbP04MFO
kvenAyQeNWCo38TKikDzQN2KkgeNFbn3O7UwsVKbC/HvNZkjN/H30ocknONMYj+w
VAABWzLDFZGa1NAD47zzsYu4ptjPQzZrBdSBjUYQl+iRnAS3+YBs9zHmlVL/5sB2
J0l+A4bpsfWbmySy0gWVulsoByNGs0gfBX7b/JRqXP4ZdFQZT8eS0hYOCBHCqhn6
COBH1RuGEs3T6ABcytwWlZU2G/B0dQ==
=10Wh
-----END PGP SIGNATURE-----

--7ff5AkW+g6+eEohN--
