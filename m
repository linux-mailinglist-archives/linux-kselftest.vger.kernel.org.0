Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB21D46A190
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 17:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhLFQnA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 11:43:00 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59572 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbhLFQm7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 11:42:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 88EAACE16C5
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 16:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D7DC341C2;
        Mon,  6 Dec 2021 16:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638808767;
        bh=LCXcChvr0AeOJPtSkeNtOPUaD6QgKLC0oPv7MRncYFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lpqYkzQvcKjkGRub0G5/DUHQncJMLVxJlwTebmZIRMf3mtOWGnAQXdNjnBpaWdFnq
         +2N9Mm1unnenob8Lu2uXJuL/gFKfqFrdXcFk0vBQahfLB/CpyxAYASfSRaIHtTkyQN
         /oFsSXFX6ZmQQg++U2zbc6wRJOrnqP2DgDyzkL44Q+thNuZZFoFVOmGKwgVBbfxL7t
         wpptJvEfLvqli21w1foY1qJTdX8fj/FqOzj1qZF3tYWdb9Vcve5Ff31CdKMAIjckhG
         f4q9Ps5kNlHnhdM18ENMsfwCWFxcPLzKJbI8JZzPV1WXZScqIGI54u9bTSLWkmZNii
         CE0vK8q55XD2Q==
Date:   Mon, 6 Dec 2021 16:39:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
Message-ID: <Ya48u+Wx+ZZyfYIO@sirena.org.uk>
References: <20211206160305.194011-1-broonie@kernel.org>
 <33692870-fccc-6d63-2c95-056a21fff791@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cc7zcVw8/hFRex4a"
Content-Disposition: inline
In-Reply-To: <33692870-fccc-6d63-2c95-056a21fff791@linux.intel.com>
X-Cookie: You will soon forget this.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--cc7zcVw8/hFRex4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 10:27:26AM -0600, Pierre-Louis Bossart wrote:

> > This is added as a kselftest since unlike other ALSA test programs it d=
oes
> > not require either physical setup of the device or interactive monitori=
ng

> what did you mean by 'not require physical setup of the device'?

You don't need for example a loopback cable plugging in.

> > +// This test will iterate over all cards detected in the system, exerc=
ising

> would it make sense to test only specific cards? People doing automated
> tests might have a USB device for capture of analog loopbacks, or
> injection of specific streams for capture, and usually care about
> testing such devices - which do need manual setups and wiring btw.

It's not really idiomatic for kselftest to require any per system
configuration by default - half the thing is that you can just run it
and it should do as much as it can sensibly on the system.  You could
definitely add some command line options for development or manual usage
though.

> > +		    snd_ctl_elem_info_get_step64(ctl->info)) {
> > +			ksft_print_msg("%s value %lld invalid for step %lld minimum %lld\n",
> > +				       ctl->name, int64_val,
> > +				       snd_ctl_elem_info_get_step64(ctl->info),
> > +				       snd_ctl_elem_info_get_min64(ctl->info));
> > +			err =3D -1;
> > +		}
> > +		break;
> > +
> > +	default:
> > +		/* No tests for other types */

> these types include ENUMERATED, BYTES and IEC958, but see below for
> ENUMERATED...

These are tests that the information returned when we query the card
status is coherent, we're not doing any validation at present that the
enumeration's return value was sensible.

> > +	case SND_CTL_ELEM_TYPE_ENUMERATED:
>=20
> ... here you are handling ENUMERATED types?
>=20

This is a different test, that we can write all valid values.=20

--cc7zcVw8/hFRex4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGuPLoACgkQJNaLcl1U
h9ChFgf+OqiL9LUTGCZicKoiCRADcu9TRdfoxPCcW2xJrlkzYKyZh4uXW/elrQ2N
W+sQIwZfOhACSDLagAp+bmg3RGe0i1nSpd69dXIec2xVdzvktLnvZt8TRMYVtuFQ
fTp6GPBv+ANsUjFPU70UFXX3ri6T3GwmmDm7i0r4ACWzj4z0knPrhXVNI6sE7gC3
02KRgFGUVW5HC8M9fl79w6GXRQjDnlUHciMcRAqyo1Fei8RFCacGtza961sUwgqi
Vib5+nvG4NeJ6+mpMWMofJPfKY/5NB+I+9fekb8kUX3DAxRHXlVzDZUnsDXxow66
UFNGGkNiPZO7iJM6xyKvBW9GDcWetg==
=RkwC
-----END PGP SIGNATURE-----

--cc7zcVw8/hFRex4a--
