Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BC741C89A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345343AbhI2Pl3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 11:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345252AbhI2Pl2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 11:41:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51A18613A5;
        Wed, 29 Sep 2021 15:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632929986;
        bh=qHbby43WT8vun50V4wF3dKjqQBrAQVLtfy1zBjAty/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0ufdfuWMMSK0ExgOnUX+cfBcmYjaL4Wln0GMEt4xaW4KBtCMKDId8qb8V832CE1J
         1gLojeUc9Qy0UA2YSdH/ZP8i9eerAyN40PddjnyjlAoQqQUawXGId+WmrrcZb7cc09
         kqJEg1WEsszwe96UHUOb/jvtyUp2+QTbZ/TBh8s88qPHPn7L0sqgLmlsAZAK4t7FsE
         hTvJifoKb8mcU5fj04tffL1iPHs+TFt3lRxnzT9sXfiWSADZt+nYz5KsgVKgBTN80U
         IOljXpWjbFVf7SGR9vMmSVVIAVnhVOiSDs6zJcn3JsE54Rblpl0HeRGKjWU4OdWXlE
         bV7ffFGWZy5XA==
Date:   Wed, 29 Sep 2021 16:38:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com
Subject: Re: [PATCH v2 0/4] selftests: arm64: vec-syscfg updates
Message-ID: <20210929153856.GS4199@sirena.org.uk>
References: <20210917120855.13858-1-broonie@kernel.org>
 <20210929143113.GA22029@willie-the-truck>
 <20210929144323.GQ4199@sirena.org.uk>
 <20210929153511.GB22029@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bk6L21jbBNK7V1Rv"
Content-Disposition: inline
In-Reply-To: <20210929153511.GB22029@willie-the-truck>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--Bk6L21jbBNK7V1Rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 29, 2021 at 04:35:12PM +0100, Will Deacon wrote:
> On Wed, Sep 29, 2021 at 03:43:23PM +0100, Mark Brown wrote:

> > I'm not sure it's a particularly good idea to run kselftest as a
> > non-root user TBH, it's going to cause you to skip a lot of tests.

> Ah, thanks for pointing that out. It would probably be better to skip the
> tests rather than fail them if they're not running with sufficient
> permissions, but I'll go ahead and queue your v3 for now.

Yes, that's what my v3 does - it skips the new test if it failed to
enumerate minimum and maximum vector lengths, like the other tests do.

--Bk6L21jbBNK7V1Rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFUiJAACgkQJNaLcl1U
h9CBCQf/TN+OHR1Z95f2g3NHDJptUsPJrgz+YxxJ4slWiSpphlPROU6fVAsR881i
HB404gCk79NI+y39YzJwkBR7dVyELvNN7tzyJLT8ikpQGnOiNwhhd/MePDIwBXKn
pzXhB7ts8DcHzGX0kLUMwjf3wze1P3svN1OKmnH4l38JJUkIS7K28sWE2wmnKpRx
1610P8QT2N4jUhczO81Bx0ZJhZVsVcpfAybOAfQ0vUBRfpsM2XNg2UiGpcFLU6Iy
GdszIjlCV+BvTSpPRv+w8tTCBXd98VF9iE+Z5LwLzCuQycD803iCakHa4g3SNcfe
ZP4Vf1H911OLDcaXTOhrGFJezNyc7Q==
=Y2dZ
-----END PGP SIGNATURE-----

--Bk6L21jbBNK7V1Rv--
