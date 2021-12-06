Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2002469763
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 14:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244720AbhLFNr4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 08:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244726AbhLFNrz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 08:47:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08194C061746
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 05:44:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5BBEB810BC
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 13:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126ABC341C1;
        Mon,  6 Dec 2021 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638798264;
        bh=DH/1E2aEG+DDCn10mi2ptuhKAVdBQHO6wYJ3zjF+k+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9Iu9ds9WgpqIffhqbQmtsvewqlLWpG+Vcxp3BtCsKJoh7MIgb4nujTnIL56gpiho
         l4Us0fI/Q7bElG/D2aQP9kzrTduP1XGxjea5MCwcOjv+VZCNRJMGl7XVJh+wKCTF2R
         7TC7mHyxWGvicYC4sYa4STZdav9wTU6JFpRU+PxCckja88RbbJAHuxE4f7n1ruGumR
         4a/DjOdzCH2GIInEI56gk9XODHrsvr42Al+12TLiBtKK2Djrk6G+BnGzZ41o8Jjjfg
         LhSee6xn/jbOEtUcDEkTpf2ZNUSquQvhMvxZTpIu350zAosrqZqJPr/D+aWjFjAp7t
         GJVn74iXvVo5w==
Date:   Mon, 6 Dec 2021 13:44:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Shuah Khan <shuah@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kselftest@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
Message-ID: <Ya4Ts7t2xFbgkvJq@sirena.org.uk>
References: <20211203193311.211400-1-broonie@kernel.org>
 <s5hlf0yqelf.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iAbjRbCp6ILDN069"
Content-Disposition: inline
In-Reply-To: <s5hlf0yqelf.wl-tiwai@suse.de>
X-Cookie: You will soon forget this.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--iAbjRbCp6ILDN069
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 06, 2021 at 10:15:08AM +0100, Takashi Iwai wrote:

> Thanks for the patch!  That's one of my long-standing TODO, and you
> solved it :)

Well, not quite scratched my own itch yet - testing that events are
generated would do most of that for me, the events just aren't used for
a lot of users so easy to miss.

> Through a quick glance, the code looks fine.  But a general question
> is how to deal with the external library setup for kselftest.  Ideally
> speaking, the include and the library paths should be managed via
> pkgconfig, but it'll make things a bit more complicated, of course.
> And what if the system has no libasound?  Will we make it mandatory?

This is already an issue for other kselftests - the expectation is that
the users will figure out how to install whatever the dependencies are,
or if they don't want to build a given kselftest for whatever reason
will skip it (there's options for that in the kselftest build setup
stuff, it skips BPF since it requires really bleeding edge stuff so it's
not like you can install a distro package).  From that point of view
it's probably better to error out so people see that there's a test they
could be running.  Unlike with Kconfig symbols there's no way to
programatically specify what's needed (I didn't add any Kconfig
dependency since alsa-lib works fine on systems without ALSA and really
it's a system specific driver that's needed for this to be useful).

I can add pkg-config usage in there easily enough, though I'm not sure
I've ever seen alsa-lib installed anywhere other than the default system
path.

--iAbjRbCp6ILDN069
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGuE7MACgkQJNaLcl1U
h9DR5gf9H2EprYp+yVwhbVQYrj3tEJiN2ghTbXYDXR3i4izpwYkVTigu0bqdqEU3
Woa0cQo/Ds/19IR8f5FVPJJ5jSSUrT0Kd9UKBgm/ww0SEhjGXMhL1XJUAkeuhG3E
c9M3vePuMbyZfQya40wTLFRy/kuX1L4yjc2iYYJawudzTbojULcTH26XTGqpz4uU
pa6QrAArwBLkoy5qPFEJn0BzdiQzJ0FWOyyFkEAaydzGyQ2yV9xZeCTUq8aURZXW
6QjYc2xT3ZZs/lNDJ8DAwF8UTw36oSFzeYUqsmayUD87vN7MchR3GD1qD1z5q1Ny
pwK9Le8zmIhyWKNVlngXA2BZ+5Uj4w==
=T1Af
-----END PGP SIGNATURE-----

--iAbjRbCp6ILDN069--
