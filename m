Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8B146F40E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Dec 2021 20:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhLITkN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Dec 2021 14:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhLITkM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Dec 2021 14:40:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DD1C061746
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 11:36:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A17D8B82614
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 19:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DF2C004DD;
        Thu,  9 Dec 2021 19:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639078596;
        bh=qnW/0fZKZPLZGRENdVqRUeULxK089W6WEiNlSncEHRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AcQU2hSXY3fGRiajjJIYdM9Z0esO8tCko6D9mNqZA+6DaOdyqDUl34uGUEx7xysVU
         XfJYBtSZBUfJ2Coni5c9QFEN+ZziCHIDWgY3OcURtY7XG0K7WFWFYgITOCxTux9CM8
         bWL5/5Za6C2DXjkUR2MZ9JYHBoQz6jEojYDt8CewpiBr39QZyMPJTEBUNmP1eo4InP
         8OwtDkXViDRwMauKNefkVTk8hPXPseTotiSLX8x3oFVlP2AuCRb6HVMmGDwJS/hD4W
         r7Q1v7wsA8sj6tCQ5PuWnq2yj3zzaYotPEsx29LPzykmEcK43/oH1kNai3blTekOTo
         C7OybkGsWCxgA==
Date:   Thu, 9 Dec 2021 19:36:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 00/37] arm64/sme: Initial support for the Scalable
 Matrix Extension
Message-ID: <YbJav0ffe+GCs9p1@sirena.org.uk>
References: <20211115152835.3212149-1-broonie@kernel.org>
 <YbJQG/V7wHohpX2x@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ALhnXHHprfpEjnfj"
Content-Disposition: inline
In-Reply-To: <YbJQG/V7wHohpX2x@arm.com>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ALhnXHHprfpEjnfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 09, 2021 at 06:51:07PM +0000, Catalin Marinas wrote:

> I had a quick look through this series and made some minor comments but
> I need to dig deeper into the SME ABI. Ideally someone (Szabolcs?) from
> the toolchain/libc side should confirm that they are happy with it. In
> the meantime I can queue the first 6 patches once updated.

It'd also be good to get confirmation from someone like Luis or Alan
that the ptrace interface looks OK for debuggers, I think I've addressed
all the issues they found on earlier versions.

--ALhnXHHprfpEjnfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGyWr4ACgkQJNaLcl1U
h9BSvAf/V9L0woOJ5RWNfNVWteEw1C4cfUJ9YZWXaIG6yauB9jw18AmO9+Fj9tiH
Ngug5vObAXwaI3spsUs7gPjUlgBOgkHPgi3MImhDm+eFvFaM2GSgG122Sh0PTmxI
evQwz6XBddObUUBuTjAG/FrMsSg+5f/KeGUIe4i8lFp9VhEqMr3iNDLDOQ/hkEw5
caW9Duz0Ehb5pwzGkMYMLo7X6hhVanEFdZBTdeiZo2yy5OHTWhIoit22fyF/icyy
93Q9wV1oIbtk6bCgvEfzb8zs7DU8TNSltj99PI+k/z9fjB82vs9Q+lPhieZflaN0
HsB7b1aEnxwyO6ykZwyCSATv6RkMQA==
=D+Lp
-----END PGP SIGNATURE-----

--ALhnXHHprfpEjnfj--
