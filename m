Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B3346DDC7
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 22:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhLHVsL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 16:48:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55938 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhLHVsL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 16:48:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24639B822DB
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 21:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E196C00446;
        Wed,  8 Dec 2021 21:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638999876;
        bh=0XzRtB1TY1B+QnDrlGDnlJEQ2jJumnQIfLZjoX0LP5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oemDuXHj0+rmtsA9sHFzZIxRbiypNW5fjtAGq0edymKDDOt4OOXpCL0SFCi3Pjg9S
         5sk9ygS+lKu1dpnVYf0Bp2PPlMB2vOPFyk+Y0ktxQ0b08yxmxETQpgZD0RQmeRSuQd
         wQ9/LYu1jxYlwcQO0AABGD/cge3sW5oVYbPR1YEuG77vA5D9MhVcR//GNKtnqU5QEO
         O6CDirwIO6c4lQNc7PIHNvZz6alDknBXO48i4S0sU8gcwkyXveFV0COw/bbNZxBxuh
         tQ97AtM41DjaPGUdoxOO+IjU1UmdqBl3v/Wi04uXCalKm7NIZUJbW0atR/mGk7iPOk
         Z8e8LJe+XIQVw==
Date:   Wed, 8 Dec 2021 21:44:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/3] kselftest: alsa: Use private alsa-lib
 configuration in mixer test
Message-ID: <YbEnPzSO0HKHd8uX@sirena.org.uk>
References: <20211208211745.533603-1-broonie@kernel.org>
 <20211208211745.533603-4-broonie@kernel.org>
 <b76dd5e0-56ba-79f4-21c2-ac5455d7fd65@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H5rKt0R94ftG66mp"
Content-Disposition: inline
In-Reply-To: <b76dd5e0-56ba-79f4-21c2-ac5455d7fd65@linuxfoundation.org>
X-Cookie: Alex Haley was adopted!
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--H5rKt0R94ftG66mp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 08, 2021 at 02:27:34PM -0700, Shuah Khan wrote:

> >   		}
> >   	}
> > +
> > +	snd_config_delete(config);
> >   }
> >   /*

> This open comment at the end of the patch looks odd. Does this compile?

Yes, it's the start of the comment describing the next function, more
complete context is:

		}

		snd_config_delete(config);
	}

	/*
	 * Check that we can read the default value and it is valid. Write
	 * tests use the read value to restore the default.
	 */
	void test_ctl_get_value(struct ctl_data *ctl)
	{

--H5rKt0R94ftG66mp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGxJz8ACgkQJNaLcl1U
h9AjQAf/bJU4kSWBW6O/E5xIfDqZBeKu8sT2OqdTagdrbAos99Ph2xcdRgC8dgqG
OWCxbyF2OGGMRWRaMY7aluNIQeDyWIO4UYr84gVns3dpzx08iuIsXTmcCZ4w2S3Y
M3Amd4dnGJTz2DoASLeca6eGAply638RYIv3HwW9G1uelOmC+JKT0G4TdO2WJHN1
IBItLrGNCcu7Qrq9s2f8k+MWcROd8ezumzV4+pIKOWuL0GjyDzLWAMBpNvRaginL
XLuYvIqv+oA1OdSyra/q9DuftLLg2g4oZqiuMnAy4WFE7CofemAowR/AHyYyQiuz
GcT9xi+/0HJYkG/phNQoe+VnXQougg==
=Z71+
-----END PGP SIGNATURE-----

--H5rKt0R94ftG66mp--
