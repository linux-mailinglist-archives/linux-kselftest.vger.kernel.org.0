Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710AB46D369
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 13:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhLHMkC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 07:40:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39454 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhLHMkB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 07:40:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20A8FB820D9
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 12:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F4DC00446;
        Wed,  8 Dec 2021 12:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638966987;
        bh=znyexa54gmAFMVVPsHGzcNM3jz0mBtEth3Prqq4yswg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KiXnLuIUa9SKtRE5aqsbmgWhNEpm1iougve1JMZhFdRXPMhSXNUC7AxqZo3ByL9tX
         RH3l8g1ybykYS5z4aZO0f0qApLq0hOKmpldDf/Va4v6GTQu7ULFrZS1BChi2PD9oeA
         T2T1u9eXz5S8xIJrkwGa1bj0A4OYiGC1Ac122OFMcFDGURb18VSkKgzS5igjcmsnEc
         PMr81e70XZPP13You5vTaEK68KNjDOgELTcH188hKMt7jXm/l99UcJMVzdMI3O6+NT
         tcyuowbmg9YnvhGXTbVZrzp6lVGEquL7ozp71q1j4QWZ4E19ujRoHVjyhopB+gfV9l
         pHx9pamuvVNAg==
Date:   Wed, 8 Dec 2021 12:36:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest: alsa: Use private alsa-lib configuration in
 mixer test
Message-ID: <YbCmxkGJ+67dMm/R@sirena.org.uk>
References: <20211208095209.1772296-1-perex@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="swPdFJYatFmHaV+0"
Content-Disposition: inline
In-Reply-To: <20211208095209.1772296-1-perex@perex.cz>
X-Cookie: Alex Haley was adopted!
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--swPdFJYatFmHaV+0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 08, 2021 at 10:52:09AM +0100, Jaroslav Kysela wrote:
> As mentined by Takashi Sakamoto, the system-wide alsa-lib configuration
> may override the standard device declarations. This patch use the private
> alsa-lib configuration to set the predictable environment.

Reviewed-by: Mark Brown <broonie@kernel.org>

--swPdFJYatFmHaV+0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGwpsYACgkQJNaLcl1U
h9DEIQf+ISBqvHy8+SsI9Lpj4vpFpC4TexgHDFQoy+54s0JwjOyecOeiXCF24Rdn
sXwD31/K4c9h0HvsMGu+rK9F9xmtEK1Utax79+fYljytVJG8r394WnklN3qjFOtc
+s7JQAFR2Mp0anw15T89KQ4LjLeI7Mv6gQyvg5k0tXbXDd2HIaa/Fe0CUyIB9n+k
XKA2iUy16Hzhnv4meRPlMgdl3KEcOSuDeoNiX0pBz8r0zudhcrAYy+We2R7Ihpev
5DWvpV4ip/wCxm6zqqRiQ/1vg4ikcW4InrZID4b9dn4cW4pPEiMy8bUjBWDXqHIF
HqD25gRMt1JUb8YVTzkz4lC1MyoW5Q==
=1cX4
-----END PGP SIGNATURE-----

--swPdFJYatFmHaV+0--
