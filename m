Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD3643CFEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 19:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbhJ0RpE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 13:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231531AbhJ0RpE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 13:45:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FA8A60E74;
        Wed, 27 Oct 2021 17:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635356558;
        bh=G28LP4FpAjV76xVDoqM2dpg9SxGNL9WwxyAJI8eDUe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfqAgtnf73Vu1lnN2ujL1Ilzo9jCELjAm6aYkyf5vq6kh7h3CEEYeHLohjwqKICLW
         HOyX4ILfGOHf/cwh5MjUQPQL9FuRzEaP3g2WTLtW4eHB7QRdYR/esyqoEcT3gBuhWM
         dqaf/SJSDfSdwACzUIG5ymREv5hamznoCWWuKCTyaak2yZC7Bns8DjiziC5jTUr5cg
         KAT1MY1NE6wuGvbfc6jYOOUpHbDCoUohqrfN9ady2/ggD0rUiGVt4LvWvpkKz3cOck
         QRCDW93qO0cAubIxqU2AVKYRyGNvJUOW+ko0MpGttrY0WlK2jHmrio1BxQXxJScVaH
         TQWYmhMa01hzA==
Date:   Wed, 27 Oct 2021 18:42:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Add a test program to exercise the
 syscall ABI
Message-ID: <YXmPihH8pV4Wbbj1@sirena.org.uk>
References: <20211021183032.3853413-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CncfXxajlbp2N2k/"
Content-Disposition: inline
In-Reply-To: <20211021183032.3853413-1-broonie@kernel.org>
X-Cookie: (null cookie
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--CncfXxajlbp2N2k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 21, 2021 at 07:30:32PM +0100, Mark Brown wrote:
> Currently we don't have any coverage of the syscall ABI so let's add a very
> dumb test program which sets up register patterns, does a sysscall and then
> checks that the register state after the syscall matches what we expect.
> The program is written in an extremely simplistic fashion with the goal of
> making it easy to verify that it's doing what it thinks it's doing, it is
> not a model of how one should write actual code.

I've pulled this into my SME series with some improvements and an
additional patch on top to extend it to cover the SME ABI, I'll send the
new version shortly as part of my v5 SME series - please don't apply
this version.

--CncfXxajlbp2N2k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF5j4kACgkQJNaLcl1U
h9AsLwf/f5cHxzIcKFo+wr/cTheNnk3dOoZGAOfUt4C257+UU6Vr5pfYkmH0yoAL
IPGF1ApRjMEyqW83TNEbXypEkbwF/VAY1+gJace8HwxNGkCeeVhpqFa3So2+sCJ/
MmmoIZj/N7zTG7YnpPUpXLAk8GRjbFjyVdF7D+yV1OHMBQ/r7K7oR8bkJVniG+3l
kOrqA/KLAuwTn6cvHp3eAcsXqISudb9jTJ6IMXZZm0Q7CHYfX5Faqd9yJDjR0T0k
ctiqc2zUe6NaPSMkAHy0Adyw/8hEjHJEwM1Dgu7V7+0FLpA9kbcKuKYYOuJK9JBN
1aKNF66zN2JUJAZSM2uva01zfDPDbA==
=nNwn
-----END PGP SIGNATURE-----

--CncfXxajlbp2N2k/--
