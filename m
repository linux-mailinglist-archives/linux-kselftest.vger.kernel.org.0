Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68D74173B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjF1RdE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 13:33:04 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:46904 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjF1RdD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 13:33:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 280D861408
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 17:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EFEC433C0;
        Wed, 28 Jun 2023 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687973582;
        bh=HvL6f4w/uJsRZu1rYe5dmMVp6jxsC66F1x3J6d3MDcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=heFz6NKiTMFv3a1lwRG5B3AH+Jh1/8dvtCQjzzjQmbkDigLSTi1uMr6fHz43zXgeh
         8aEPmzX4n/3upH7GP70vXx3hQf1CANobXGsHGoWS3GZ+Zi4q8KYrF6DY2/ttHR1Ut+
         rs63En1N7nIEFZ3hif9PUcNTpzHScsmnfQ+E75SI0PZNR7CebKiv7ngt1rQ9Q91RUB
         HMSiTNDoBmda+xhKHcn6YopiYosEK2r1289ZoSZdBQy41ZAIWK7JfRWT4xtYHzoWOd
         A6ZX53I8FjY0rbUblsgNUW/kNvknDTzeByBYWbVl/pWp25KZssSWJNDAEgfr1f/pr4
         y3pmwUsQgX4cw==
Date:   Wed, 28 Jun 2023 18:32:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, shuah@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: SSVE selftests failing unexpectedly
Message-ID: <6680a055-7cb1-48ea-914e-410426220ed9@sirena.org.uk>
References: <20230628155633.GA22275@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ztj5UgH7l4e45+iP"
Content-Disposition: inline
In-Reply-To: <20230628155633.GA22275@willie-the-truck>
X-Cookie: HELLO, everybody, I'm a HUMAN!!
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ztj5UgH7l4e45+iP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2023 at 04:56:35PM +0100, Will Deacon wrote:

> I did a bit of digging and it looks like this is my libc using a vector
> DUP instruction in memset:

> #0  __memset_generic () at ../sysdeps/aarch64/memset.S:37

> Dump of assembler code for function __memset_generic:
> => 0x0000fffff7edfb00 <+0>:	dup	v0.16b, w1

> The easy option would be to require FA64 for these tests, but I guess it
> would be better to exit streaming mode.

We can't exit streaming mode here since the memset() is done *before* we
collect the signal context, exiting streaming mode would destroy the
context we're trying to collect.  We can, however, open code the
memset() and try to prevent the compiler optimising it I think.  None of
the toolchains/systems I'm using are generating FP instructions though
so can't 100% confirm.

--ztj5UgH7l4e45+iP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmScbskACgkQJNaLcl1U
h9C9GQgAgrEq1cC1uprdIsUgPDtmADkcjjzmGpO9Bg0MrScjFoMJEnruz4ulhdel
h74KE6Wvh2+m7fkoyPJnK/w0owQ2clWRmIkIodKLOjaZQG9WqRrGgHC4G5zyzSga
OWcMv+k0XGLKcNar4xOX4gpeoDD53dX3om+43L5I9MyyrBDm01A4VTq54TiTJzMh
jBFGTbJk2kha1WbNUy/n6229tMt1h3e7lndf1k7OdRPOErGW00QuvoXw6+KXcsLW
R3wmYmbD+zkG8zHFiGHYxG6IUJLwh8xs7UFpywIhIBIZ016EMhWup0uYDNbReGnf
eTFifMNjUPHmv943FC2ZGDCgmH0YMQ==
=+R/j
-----END PGP SIGNATURE-----

--ztj5UgH7l4e45+iP--
