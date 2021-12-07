Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263AE46BE27
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 15:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhLGOxP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 09:53:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49838 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLGOxP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 09:53:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 002F4B80782
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 14:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841E6C341C1;
        Tue,  7 Dec 2021 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638888582;
        bh=ZATyNf3WVgMhUzhfPCepXLkcN7ZvjmNcmN0PLGupu68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeZmnTtRrtKhAhZlTIwlwjqlzmNGARIY0Rk7c0M9IKN/2Y0DjX4oZ2wt/1fxlRX0i
         I1yzzieRBl+BZKAc0Wb16Ap/hiRE0rBHsqnd5JsfSg3t+4wE26UwMUO6rtS7dg9sXE
         Cl6Z4vOJzgnI0VQ+3yLdnUEnKFTv68L8unRWYc2Mm0RSuBGvs5uHXEiq1FQbBF7X+w
         XRnoP50l0qpsEUVwn7tUu2EU6K7pvJ13wCg4AWX6l2Y6uEjHUb89rUHIKlI6MibGdD
         mU6U1rAmcXveM6KMdLjlx2JpmH/6UJPYjOB+3cqua53F3vFWyrHU+vYVtcvRI6rLoo
         gEYGUXiH0jQxA==
Date:   Tue, 7 Dec 2021 14:49:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Shuah Khan <shuah@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
Message-ID: <Ya90gtjsjiQOxa6A@sirena.org.uk>
References: <20211206160305.194011-1-broonie@kernel.org>
 <Ya7TAHdMe9i41bsC@workstation>
 <Ya9uvPx37AcOdwLK@sirena.org.uk>
 <s5hwnkgmqhv.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1j0ZY8kvyLv+ERCp"
Content-Disposition: inline
In-Reply-To: <s5hwnkgmqhv.wl-tiwai@suse.de>
X-Cookie: Only God can make random selections.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--1j0ZY8kvyLv+ERCp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 07, 2021 at 03:36:12PM +0100, Takashi Iwai wrote:

> I'd like to get a comment from kselftest people about this addition
> with the external alsa-lib.  Shua, what do you think?

Probably worth pointing out that there's quite a few selftests linking
with external libraries already (grep for -l in the kselftest Makefiles)
- eg, memfd wants libfuse, netfilter wants libmnl, clone3 wants libcap,
capabilities wants libcap-ng and there's others, plus the ambitious
requirements that the bpf selftests have.

--1j0ZY8kvyLv+ERCp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGvdIEACgkQJNaLcl1U
h9AupQf+LqSbj7LSvBK0arD4RQ213M46bkg0SE2sdRV8GgYOa93UGIy/0Fne+poO
3yIEdVUpia0maoXWOn1r3n7vmGfp5nilQxHUffrDrAQaajtleA7tTBK09cJqVFx7
V6i8E3KzRIiNLrKGy2RFqYet9gnfL9iw8PB7OsAtHvWPOJ2RZ/idbmOd+RDVvbUS
C+DD4byZzfSYwi91gShTM/Pi92k0XKQOux8rlV7ffreaOqCYScnHBPnzB2NZe/gJ
OiawGeobGfK9rkjz3YiNBfBFTCJ1AdlzGq55GpchYxV6vzVoQ+5uhhFK9UTqlFL5
qJUBGeUsJZiC3XdD03urIwt8EHo84w==
=/36Q
-----END PGP SIGNATURE-----

--1j0ZY8kvyLv+ERCp--
