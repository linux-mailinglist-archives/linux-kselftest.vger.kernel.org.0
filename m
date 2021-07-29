Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5E33DAA5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 19:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhG2ReZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 13:34:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232030AbhG2ReZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 13:34:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6307460F48;
        Thu, 29 Jul 2021 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627580061;
        bh=1E+ExOsSHvBaVUydI7CteHnpHuaDDAM8YR8rzhzbPQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ys8brWYJ6BxOq+oJA+H0bhsmU89cwJX5IwMidSAntbL8gEBgoQ5lEyam5ofmSTK8R
         hOJiyFwwtSrQFENg2YHGYnll+tlgjmG2UMb30peW0Mp22ZORJIHkA5zX+gQmMyX/ce
         bDGC4wYGiHKMSwKgJJvgVXyW56T6dTUeLSqxGFS1vlQODiQaQhS68HP1vFfJd7mjNh
         X+a2xc9n+FWIxad/+t4ANS1CTcvKZo3dyLK9+H+UwpUdtsEsuCj16HAZ8FuLAzapfZ
         whLl3cK21t8KDQRMmjNJ+RSusVExJ3BxG+Gs0hw9LhSW507rYODJw/mZuV6OV4zplD
         OC54wQbv7Y0MQ==
Date:   Thu, 29 Jul 2021 18:34:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/4] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210729173411.GT4670@sirena.org.uk>
References: <20210729151518.46388-1-broonie@kernel.org>
 <20210729151518.46388-4-broonie@kernel.org>
 <20210729160642.GP1724@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SENi13OXelf/Rv8V"
Content-Disposition: inline
In-Reply-To: <20210729160642.GP1724@arm.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--SENi13OXelf/Rv8V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 29, 2021 at 05:06:42PM +0100, Dave Martin wrote:
> On Thu, Jul 29, 2021 at 04:15:17PM +0100, Mark Brown wrote:

> > +	child = fork();
> > +	if (child == -1) {
> > +		ksft_print_msg("fork() failed: %d (%s)\n",
> > +			       errno, strerror(errno));
> > +		close(pipefd[0]);
> > +		close(pipefd[1]);
> > +		return -1;

> Since nothing reopens pipefd[0] or pipefd[1], you could also follow the
> "goto out" convention and just (re)close both fds at the end, rather
> than having to repeat the close() multiple times.  But it works as-is.

I find that when fork() gets involved that starts to get confusing since
you have multiple contexts/control flows around and working out which
cleanup path goes where is more of the issue.

> > +		if (!WIFEXITED(ret)) {
> > +			ksft_print_msg("child exited abnormally\n");
> > +			close(pipefd[0]);
> > +			return -1;
> > +		}

> The WEXITSTATUS() check could go outside the loop.

OTOH I find that logically it's part of working out what happened with
the child which is what the loop body is doing.  Anyway I changed to the
do/while you suggested.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--SENi13OXelf/Rv8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEC5pIACgkQJNaLcl1U
h9BCPgf/VpGauLjVEBtUcIp/RclJXiLCz7gaNTW1fcBNRXyFZXPQM1uiTRrnjwMQ
dGFI8PQ7Zg+0qTbO+WL96AARBeHp5jwJy1nqJxy1qRbFTlgC6prSONKZOD2tBl5/
uRvGb2DkhDcxaVBcNBQwhqwJVQ6ckr2wscHen3dtMoDJMsMDJZc27/dM0s5Vx3yp
4lMsh6WT9MoZ7vSs8Syh5AmJUJ/qeKX4k4uyuK309bxo+aRa3s5EiO36L0UxFCSp
QXMDpYVJEQ4YqrTEvhEoCfBEMLdj9+8k50NqiSDiM6y6xeL4hYrhuvhvXPh0UVTT
j/0DGhOpI2nGJS4jr1cY7l4EGLyDsw==
=iSBo
-----END PGP SIGNATURE-----

--SENi13OXelf/Rv8V--
