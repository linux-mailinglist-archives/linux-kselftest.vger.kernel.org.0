Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D770259528
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 17:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgIAPrs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 11:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbgIAPrn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 11:47:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45AB62064B;
        Tue,  1 Sep 2020 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975261;
        bh=wZ40JS7xLSSO+Ut7d7BH2aOC5S6WcYBuAIRDCX598kY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkZjEHmA4Pr7w3n4h7U0lnjIfep6RFKViwQaU8rx/LO0XeldKSLHKDiRDpd+6Zn2z
         edcu1Gm32AMeGqFsgCQYTMUGZpplO7nekLX00gmlanFl92hIDs3wjFVWE2e/Je15B4
         3B2CqvkF0ATJo7gySEHxG8GYjskmf5E9FRJCQIUs=
Date:   Tue, 1 Sep 2020 16:47:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 6/6] selftests: arm64: Add build and documentation for
 FP tests
Message-ID: <20200901154702.GF6262@sirena.org.uk>
References: <20200819114837.51466-1-broonie@kernel.org>
 <20200819114837.51466-7-broonie@kernel.org>
 <20200901153840.GA6642@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline
In-Reply-To: <20200901153840.GA6642@arm.com>
X-Cookie: Equal bytes for women.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2020 at 04:38:42PM +0100, Dave Martin wrote:

> I don't know whether this is worth following up with a TODO?

> Some things I was aware of:

Well volunteered :P

>  * The sve-test/fpsimd-test programs contain a lot of common
>    boilerplate and could probably be merged together.

>  * A fair amount of the asm in sve-test/fpsimd-test could be converted
>    to C, with -fgeneral-regs-only.  This would be helpful since the
>    code is highly unmaintainable in its current form (I know, I've
>    tried).  Calling library functions would still be a problem, but we
>    might be able to lift a printf implementation and some basic syscall
>    wrappers from elsewhere rather than reimplementing everything from
>    scratch.

Or just keep the existing asm for the syscall/print wrappers.

>  * The sve-stress/fpsimd-stress scripts could likewise be merged.
>    Also, doing the required process management from the shell seems a
>    doomed enterprise and it never really worked 100% right.  Eventually
>    it might be worth rewriting a common test driver for these in a real
>    language.

>  * While the tests confirm that basic aspects of the SVE support don't
>    explode, there is not a lot of checking that the kernel does the
>    _correct_ thing -- so there's scope for improvement here if somebody
>    gets around to it.

Yeah, more errors get trapped by the kernel's own internal checking than
by the tests themselves.

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9ObPUACgkQJNaLcl1U
h9Cvuwf/R1UBXD+QP1E1jLFwSRnJwpYDDt/d0h+GDjSDoI8DXJWXyW7+h9ZHvHpA
uwi6ACpK4R1PZp/45X5y4dvC7WRpf+uPlbMclsqQ+TbIlp2tiLjAc2srQxPRtFTK
LBmMagr4iY2iuc6ejhhY5OPJc/GGr5QehSlmwFgfUFVoCs8zMrsFkkW1LHf1F0oY
2aPmg9Z67Q31yofc1bzdLcILW/P6SCarRPMi3pTCpb0BC829K6top1ywxkxUxXAi
NBEqttGtF+s/cUtEGgi/PDimQd1nUznZ0xl8WJOJrwWBdS7S8uiaLepVSraETcLP
loPrpQPyiBoVpHi5SEEvuL8+5lUWcA==
=2l/a
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
