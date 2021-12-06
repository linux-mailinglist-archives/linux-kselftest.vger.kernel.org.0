Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DA446A3D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 19:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhLFSUo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 13:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbhLFSUn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 13:20:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA698C061746
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 10:17:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B460FB811A1
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 18:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6F8C341C2;
        Mon,  6 Dec 2021 18:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638814632;
        bh=jVQAq6v9Zp6REwi45gUn5OX7ldbi2oDXqegJJ+/tvco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XFGIwvdo+FGIkmo4gBVSkeeps5trKpbiUPpokZgcgvArkzDtFRzj8dW7pTLD+bSVY
         sAIaaN+e1j+nHKc6eSG3GRbTAMo2g0OHJ2tcg+/w9uh4l+OUxN+SWyaw9YC1ODlWnD
         fE37AjZQNPWE+qHXZSEEFdW7MTrgh6qO9tKzPkX4/y0Fz3eJ37ELwHCBxE3M60cQU6
         HQCXJf+owEWhXB0+CqbLvulSjI5CIHlAW/76bCi6dzjWXnzpkPe7QONLUXjPxo8/H1
         4feYGrewJf3OJWlRKuhZsQtvNY2i7HTCcJZzx1TfR3KMsANoJ51g3jRCUQCsD7ucgD
         gTMjJhErwDaeQ==
Date:   Mon, 6 Dec 2021 18:17:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
Message-ID: <Ya5TpDyUBH0pImY1@sirena.org.uk>
References: <20211206160305.194011-1-broonie@kernel.org>
 <33692870-fccc-6d63-2c95-056a21fff791@linux.intel.com>
 <Ya48u+Wx+ZZyfYIO@sirena.org.uk>
 <b2972e61-e6c2-9f60-6242-3762c88efe0a@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q5ZH9q4735TdaOoh"
Content-Disposition: inline
In-Reply-To: <b2972e61-e6c2-9f60-6242-3762c88efe0a@linux.intel.com>
X-Cookie: You will soon forget this.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--q5ZH9q4735TdaOoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 06, 2021 at 11:01:25AM -0600, Pierre-Louis Bossart wrote:

> > It's not really idiomatic for kselftest to require any per system
> > configuration by default - half the thing is that you can just run it
> > and it should do as much as it can sensibly on the system.  You could
> > definitely add some command line options for development or manual usage
> > though.

> I was thinking of adding this test to our CI, it's a bit orthogonal to
> self-tests indeed. IIRC we check that we can modify all the PGA settings

I do think it's useful to run there, it'd give coverage for all the
CODEC drivers in your systems and of course for controls added for the
DSPs.

> for volume control but this test is a lot more generic.

It should be fine to run in your CI as it is - assuming there's no bugs
it finds in the USB cards anyway.  It tries to leave the card in the
state it found it in so providing we can read and write whatever the
current settings are it should leave things configured as they were.
I'm not against adding an option to run on specific cards, you'd have to
run it outside of the kselftest harness for that but that's more of a
thing for your CI anyway.

--q5ZH9q4735TdaOoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGuU6MACgkQJNaLcl1U
h9A4cwf8CyKz10tT2kUBl+JPcdcjlrCo4OXD/Ef2KiarVE+hyjUBDPUlakykh5iB
yEki4lagBIzwsoX3783jWIoi1SA+aaClVl7LzgTbB3I23wATbQQi7M0OzrnAMvYE
ScLKTBe6aabEM9gHAlSurfO0qwRZjxDP3dOFmsfay2hTcWyuhCHpsforbGAVJtFU
PVcYwdSW23h5y7U444GH8zKdtPtNAkSRbStm237L6ALPy+8yV1i6aTJ1+3hUL+pi
bQa7VmeNQB5ih1pfKQ6u67otTcIw6GXw3IJaPxkeQ8V5BH30fEdRVMznBDYcWCOn
QPp3c6/WGIAhzaR6zJ/rGA/R0jS+2A==
=o3yk
-----END PGP SIGNATURE-----

--q5ZH9q4735TdaOoh--
