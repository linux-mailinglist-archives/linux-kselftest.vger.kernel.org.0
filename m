Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6D428DB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 15:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhJKNUL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 09:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231392AbhJKNUL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 09:20:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0708A60F23;
        Mon, 11 Oct 2021 13:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633958291;
        bh=rdHCT/yf1NuYYpIhO1/KL29JDCvdQcG2Q+tlFqrPW0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVir+opPBXYUnAhRrXS0w1uk52YHx7CfzROMLLD2YYVm8wH9dENp/hlH+t8NfHguF
         DFEpqe5n7h3+w+aP5L5aR9YwPBMoX9K0B/mnnDWIfkYTNdBgc/SX9JBLjJe4rlWUOr
         DuSDbg7K9KHaInUSy9vzzDu4deaEuU2YtZUYb1o0/gWKL5cbZvWRaRE32pEMioCtPa
         HJttj1fsr/ikKn7z8jhNpCwVxiu00sE102fv5mEJIzuW7w3RqioxoRpZuzHM0ITtYh
         uCf3jNLmWGCh8ICCyV3aTyONKtd19m/Lx3k9OEzWEYvjyYbS1/V5/JYYcNUM2Rpa+Z
         74DI1T0g0W2Cw==
Date:   Mon, 11 Oct 2021 14:18:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 10/38] arm64/sve: Generalise vector length
 configuration prctl() for SME
Message-ID: <YWQ5kIsc9A3Sgcm+@sirena.org.uk>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-11-broonie@kernel.org>
 <20211011112750.00004066@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C6KrJVARtSiWrDNu"
Content-Disposition: inline
In-Reply-To: <20211011112750.00004066@Huawei.com>
X-Cookie: Your ignorance cramps my conversation.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--C6KrJVARtSiWrDNu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 11, 2021 at 11:27:50AM +0100, Jonathan Cameron wrote:
> Mark Brown <broonie@kernel.org> wrote:

> >  	/*
> > -	 * Clamp to the maximum vector length that VL-agnostic SVE code can
> > -	 * work with.  A flag may be assigned in the future to allow setting
> > -	 * of larger vector lengths without confusing older software.
> > +	 * Clamp to the maximum vector length that VL-agnostic code
> > +	 * can work with.  A flag may be assigned in the future to
> > +	 * allow setting of larger vector lengths without confusing
> > +	 * older software.

> Why the oddly short wrapping at sub 70 chars?

This is the default for my editor in Linux kernel style, I guess among
other things it keeps things readable even when they're quoted several
times during review.  If there is a particular magic number that Catalin
and Will have in mind I can go through and reflow to that.

--C6KrJVARtSiWrDNu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkOZAACgkQJNaLcl1U
h9AW9Af/WZg3w6b719MVG6bSXJRG7JVKYTUVmrTj5EJMg6YuTUdM5zHEu4U4hJY5
pZ5CoK992P1eQKPR6aibBXfhxnJvit1kDu3v87OFlnBBMAfDWKJIWjlhGHEw/r9B
avWUrLK8m4Jb+/ruuxNl1mxtvOgMbokPaOTpF21/3M2XXixRpi+YNBGeaqUGX2G8
EylSxYcb0JRaEur9jHGxPBvlxJbK3tKauBZDwto+0ZQRw0WDv/lHIdZolmiKWl2r
d+fbO+dQcqPedggYNgAUYrqwi65OgoKoCeU9XQxYwmKBd121YN9jPsQomInTWKm5
TIf0hlG8iMXuDWlRMZRtP5by7KrsZg==
=mzO8
-----END PGP SIGNATURE-----

--C6KrJVARtSiWrDNu--
