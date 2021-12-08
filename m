Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AC646D7B5
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 17:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhLHQKz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 11:10:55 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41986 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhLHQKz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 11:10:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5AD0ACE2206
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 16:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AD4C00446;
        Wed,  8 Dec 2021 16:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638979640;
        bh=ucd29oGSTKXWWFO3cCmFVHP7SHwSna+LAEgaxzI8ATg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOY6FnjiHNkbQ76spg+A5AWKfn7V1kaSbtUIV6yyNMIdGdLU1Ulw/ADcN0Pa5zS7c
         XSWj90Py3VFh4j+BSq9Jh50ODgzD/xqt0Dzg1J6BGFN/yutTjGK6VC7MRJk94XYaUZ
         uPEsy3HWKTOTqW+KXaG1mwdQnA25hXzR2fI1P9GrwkXXY/WNwD7/1my3o9CHIhQHkH
         sl3W2dqxtxVzqjdaA11ye1huA69U41dR4nAUL94rNU8/XT0TQGzEWXcU5hHiGpqfI3
         VRZzVHDSxuui+q8xmo//zqUVZRTT+hXcvz3sI3a9L4vbupW0OOpMdcUzgI8p20rRPZ
         lBrf5GsvGMg4A==
Date:   Wed, 8 Dec 2021 16:07:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
Message-ID: <YbDYM084JDKQn0Jv@sirena.org.uk>
References: <20211206160305.194011-1-broonie@kernel.org>
 <Ya7TAHdMe9i41bsC@workstation>
 <Ya9uvPx37AcOdwLK@sirena.org.uk>
 <85e0af0d-6f7e-47b0-b09c-c6006ee50662@www.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ySXaIdAa5skuYhCk"
Content-Disposition: inline
In-Reply-To: <85e0af0d-6f7e-47b0-b09c-c6006ee50662@www.fastmail.com>
X-Cookie: Alex Haley was adopted!
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ySXaIdAa5skuYhCk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 08, 2021 at 11:26:59PM +0900, Takashi Sakamoto wrote:
> On Tue, Dec 7, 2021, at 23:25, Mark Brown wrote:

> > I do think there's an advantage for test comprehensibility in having the
> > test written in terms of similar APIs to a normal userspace application
> > - it makes it easier to relate what the test is doing to normal usage
> > which is helpful when trying to understand what the test is trying to
> > tell you.

> In my opinion, test is merely test. It's not a sample program.

> What important is what is tested. and how to assist developers if failed.
> If more suitable for the direction, we should do it, even if using raw ioctl
> in the case.

Sure, but it's also important that if someone sees a test failure they
can figure out what was being tested and if the test makes sense - there
are plenty of testsuites out there with tests where what the problems
are in the test, or it's hard to tell what the test is even supposed to
be verifying.  Putting barriers in the way of understanding the test
means it's that bit harder to get people to put in the work required to
figure out what the test is trying to tell them and pay attention to it.

> For your information, `check_event()` in `test/user-ctl-element-set.c`, my
> rough implementation of test for event triggered by tlv operation, might
> be helpful to you or start point t to discuss about event check.

Thanks.  The main issue here is finding time to look at stuff rather
than figuring out the APIs, they're reasonably easy to work with
fortunately.

--ySXaIdAa5skuYhCk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGw2DIACgkQJNaLcl1U
h9C+Zgf/S8f4rY4+y4WmFzac9ggepM8sxPn8GNOzVK28R2Y5SnY6vUEOV1RNyypC
mu5e1oWtP1B3GqlUsDW91y4n1DPUHiQS9N+SQrHaEFB6xdjTs2h8U672HrChTcJ7
qCwVnBK+rM8CAFDocEUkXlRDCKsdrihIpA8cXT6N+Iemx4gvLGb9w1ndUtXe9N3h
JX02o9JGMR0zAKtU5ESELYD5tPs7g+CqMhCnLT+Oy3fyeiMGte6mK6uz2aD4IPqj
EdqbY/2Q213UQIiDfY0Gi0PtLCadBI8o+O1gZVIbls8dLWGisKxnMEMBWnPDokSf
tmcHOXNXWCD9WyzUxgcsFf6rQXjYJA==
=4MfK
-----END PGP SIGNATURE-----

--ySXaIdAa5skuYhCk--
