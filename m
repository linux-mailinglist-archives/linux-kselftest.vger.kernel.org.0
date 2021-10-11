Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0757C4297F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 22:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbhJKUMJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 16:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231926AbhJKUMI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 16:12:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8548860E54;
        Mon, 11 Oct 2021 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633983008;
        bh=3ZMlnBCJ9VeMjnrQY1dZrPrVF4Rw56UmLkBkE58B8uE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMap5lamOvxqdl4QOdTgduFOWxtqUlFBbJboVHlitrBbwPGCx6WUaRK8oh+334h+t
         L/QQwEZeCtn1gKmlarui+pg35XaSPvpKSHbUkz5Kr8W2rBKXasYjCYCDzLD29wIcGO
         Nnr/vO8VzxgtnWnOoxJg9u6Luih/2fz2ZlwszghV0hAd90UvCICruefTVkLJbnq6ZO
         LR8O6NRH1BmYdhwJhn98nOxdIDrBj8X6Hq+S2z6ZJ4IjARHKxXcNAwyY/LpZGeKMcE
         w/LLQvcjXXPBH4Z/4jWpJBEZDptGKM3hyfbUtL9V3HDkj9uwwKYnNGtKvYMnhYHirc
         +aW5uhhpPAv2A==
Date:   Mon, 11 Oct 2021 21:10:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Richard Sandiford <Richard.Sandiford@arm.com>
Subject: Re: [PATCH v1 12/38] arm64/sme: Provide ABI documentation for SME
Message-ID: <YWSaHaJOIbEigw4w@sirena.org.uk>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-13-broonie@kernel.org>
 <20211011131730.GL2700@arm.com>
 <YWQ67ad5wfRgp9l7@sirena.org.uk>
 <20211011141937.GM2700@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2Ut2fhagX+Q0sTMt"
Content-Disposition: inline
In-Reply-To: <20211011141937.GM2700@arm.com>
X-Cookie: May contain nuts.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--2Ut2fhagX+Q0sTMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 11, 2021 at 03:19:37PM +0100, Szabolcs Nagy wrote:

> if fork resets tpidr2 then returning to a stack frame
> that set tpidr2 could cause clobbered za state.
> (userspace can fix this up, but if we want this case
> to work then it's better to fix it on the kernel side)

OK, that makes sense.  I've changed the code and the kselftest so that
TPIDR2 is preserved on thread creation.

--2Ut2fhagX+Q0sTMt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkmhwACgkQJNaLcl1U
h9DYIwf/SdjGcrk+B6BeNC/Ct9Vu1tEGt+28v6DFGGo1syrzRhtCaCyW6jZh3oJM
Rz4YRRuVx/eoH7DdB4ReUFQ7gXhONMWsH+8DynWMP6hBd0HB4Rc2rMIsWVwecKQ6
qgGcb93O3bc5IGhzqPNAPcSa49GGAXXZ8ce56LSQcI1Kkh4D5/m8advYBX0TMH+E
DF2xWhvT/VkWDMP8a/VTbVmRgGp399y2gx3/W/wLy0tEmmNt+p3VoQeX4HztOTST
tg9vQgkR3l9obAJdE8VbYU5JOqYmCB8ZmB6L7sjIn0PiqphVpXfWt9SQGnF9bBKW
sTYAOVPir8vBkeQ9ydwmaLDbvBwXFQ==
=xgvx
-----END PGP SIGNATURE-----

--2Ut2fhagX+Q0sTMt--
