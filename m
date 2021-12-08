Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCA946D562
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 15:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhLHOSP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 09:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhLHOSO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 09:18:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5077C061746
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 06:14:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7DB1B82107
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 14:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF211C00446;
        Wed,  8 Dec 2021 14:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638972880;
        bh=7z26PP8HWRt0fOrNVLCcjPbHQ+P6Gq9iCx6EvNvW9uE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRcSQ5WBM6hJOzvvxxdbxN1DlvZVQMwISH1hzyyD49pWpAi+5YLUCfbPbCJhV8V0a
         4wFR16pPbbEKWupPJ9tw5rgaYc0/oLTQ6VCCsE4ub/SoP2E0JYzvfe+eL1wu6QNyP1
         UQpy2W4KTwoDDJoUYCvmSD+8sjtIzJD9Zja3KBYk10QRj+G+/pAxOWizFztqjh2JCQ
         8xZp4tC/o5EbX8XHzJcWrydLyJGeeFOB7DUb1AOXoJrgTVW8p7tyHXuMmb7rmg+Cf8
         Y+MP1XtSWAUWkesDrXmCEt5Lh3ujHQrlzuSojit0OaYT/9WD12BjLzK8MZnzLIsHxn
         k9XM3rU+LWANA==
Date:   Wed, 8 Dec 2021 14:14:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        ALSA development <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest: alsa: Use private alsa-lib configuration in
 mixer test
Message-ID: <YbC9yxBeYdcQ9j9d@sirena.org.uk>
References: <20211208095209.1772296-1-perex@perex.cz>
 <76f28e78-0e9d-45ce-96a3-5c36f880ea6b@www.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y6EQkDWcLeAjBQmy"
Content-Disposition: inline
In-Reply-To: <76f28e78-0e9d-45ce-96a3-5c36f880ea6b@www.fastmail.com>
X-Cookie: Alex Haley was adopted!
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--Y6EQkDWcLeAjBQmy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 08, 2021 at 10:55:41PM +0900, Takashi Sakamoto wrote:

> I'm not positively for the patch since it can take developers puzzled due=
 to
> the symbol dependency newly introduced in unreleased version of alsa-lib.

Shouldn't the version check and local definition avoid that issue - if
the version of alsa-lib doesn't have snd_config_load_string() then we'll
use a locally defined version of snd_config_load_string() and not depend
on the alsa-lib symbol?

> It's better to check the version of alsa-lib in Makefile to avoid develop=
ers=E2=80=99dole
> if we have enough respect to embedded developers, especially forced to wo=
rk
> with legacy userspace. (and it often occurs).

Or just avoid using fancy new library features - if we need to limit the
test to only building with bleeding edge versions that gets restrictive.
TBH this is probably even more painful for people working with
enterprise distros than embedded systems, if you're building everything
for your target it's not usually too bad to drop in an updated version
of something like alsa-lib but if you're using disro binaries it's less
idiomatic.  Either way it's a barrier though.

--Y6EQkDWcLeAjBQmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGwvcsACgkQJNaLcl1U
h9CFZAf/XW0hzolZYnySr7GSN/hpeVNw7U7OKtr+UuctxVrwP5IfoKXYC904Exi0
ysElgzTGbSlLNEHplU7xFncFtbxD3u9Fjo9xnHjX5WImozSXB/d0FeeeV4p8ZOqV
AWgtPtc32Xu8q8LOGyKSz8KTCjQ3N+4qM6Y0Of4wMFMdiBbUcd70MWwPcbqaZGWo
XA1eRj0DwVZA8+j87QXeab2gYcFMexW0bHN0i6k/v+sQDinivAA/M5xrBvThLTC1
eCCuAHgh/6ljblVDnK0DZ2VLqMrfDDf5CKxe5XYGxND/39tiUgAy3EpV2HNYUHWA
ZDokZipm9yQWSCOOHl9pn9cS8xgBrw==
=uxt+
-----END PGP SIGNATURE-----

--Y6EQkDWcLeAjBQmy--
