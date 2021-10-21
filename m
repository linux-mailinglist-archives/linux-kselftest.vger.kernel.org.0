Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB75A43612A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 14:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhJUMRz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 08:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230231AbhJUMRy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 08:17:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A90166120F;
        Thu, 21 Oct 2021 12:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634818539;
        bh=G9Fyn+LXoWKA+dJXkGbE/r3nlPUNszZi5Xifq7aBcs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+XN+IKTW8mMDKiQknDVE/GjUOi8ZFe8YM6VSwOo00MupvnhUh9NWggpyAxnMzIgA
         HsJezYF4ECzVSCc1AvUFJEjnqGXhivPp7aO6F384SE/4BKYsDdAqSpIH8ThrF9ZWQ3
         8Xe4v25f+YPtKxZEa+mUDw//5Obi6dt39+HbXKew2qMAmitwvMkNCqDJq8I1aZy0ww
         anG4Hwda4MEoUbAyyCNYZ+75Fr67RZwCfkbb7vUHMOqLrab0AZVvMoxBdBU8jEhpSg
         ZuFEyaAjh4xpukw/pau4M3QTamiYSNkwKgvWlZbN6bNhYtgdzJ1xpt7PDwd8n9gCF7
         HI613S/nSxkbA==
Date:   Thu, 21 Oct 2021 13:15:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 10/42] arm64/sve: Make sysctl interface for SVE
 reusable by SME
Message-ID: <YXFZ6EdBklN4W1sU@sirena.org.uk>
References: <20211019172247.3045838-1-broonie@kernel.org>
 <20211019172247.3045838-11-broonie@kernel.org>
 <20211021095550.GA16377@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KZ0sz92NMjGU1gkP"
Content-Disposition: inline
In-Reply-To: <20211021095550.GA16377@willie-the-truck>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--KZ0sz92NMjGU1gkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 21, 2021 at 10:55:51AM +0100, Will Deacon wrote:
> On Tue, Oct 19, 2021 at 06:22:15PM +0100, Mark Brown wrote:

> > +	if (!info)
> > +		return -EINVAL;

> Is this check actually needed? If so, you've already dereferenced the
> pointer.

It's redundant, just defensiveness.

--KZ0sz92NMjGU1gkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFxWecACgkQJNaLcl1U
h9A5Kgf/a7iis1Wb8eZkh4Uz3o9Y8YEpVhnS1QtF5DTOfG6KpoAo4zh5hSkOlul0
vI84jzx/ltUVbn3hk8goBqF6rt07EWOyd5K74lP6TBDvTKZMnv3SRI4qEKGAmUky
zlN3BzihaiqwcKWx6l2Iuy6WGU4I4DY/gnPnE5mehryLWyHyfpdRSAXJbMGS9Qeb
rJK+0JAm+A4atkqZ2i5Jlt9ESdA2AX4Y0TiuSXw7Aw6ZLZO5SpkcihKCwN/LHGVD
rzvQcWkCQubW900zvPL19VZd8WbmvCGN0gdP3YBKpJUI3t/p1HmVZSItsmiYGlfw
JCHjxSJKBz9angq9DPK7Zt9Uc6Gu2Q==
=DLJo
-----END PGP SIGNATURE-----

--KZ0sz92NMjGU1gkP--
