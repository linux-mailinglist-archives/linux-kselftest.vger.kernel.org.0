Return-Path: <linux-kselftest+bounces-33459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C96ABF55D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 15:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CBE188D111
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 13:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E5E272E63;
	Wed, 21 May 2025 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPTrN2Jp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C142D613;
	Wed, 21 May 2025 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832621; cv=none; b=QdbC4SyJ6gbZ8JJBFVHs32sRKfC7Jgv4YFfasAhl8Oh0gXGAh+pRBo7t7UmLp/aeU1rpNjpEieNfSzdWQcsTm7ZhJaSjUk1p/QzJBYWit01PM4xcDueXRhj/m1/EVl3JKjzYB/CXohIk9fE1PAH3HEgnwWnPxnzjezkIiumYJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832621; c=relaxed/simple;
	bh=Qbn7PRSdI6A1vFXmvZ3FylGRMq8wFbpdqz6uoGJ1KTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH1ee7gWaqyljVv2MnMY1R8CsB4L529lL303Y8q9bLak8Da3SfhB0CnWFsNKvv67ZWueGihkyLyAkewtNhc3iJ357/iiNcDm1reqsgYdpC0g2jQiXoeGlm1/aNyyJai/1mdMKt+6sAei0O2y4Kf07ehT3ZR93tpmEEqO3q8ndx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPTrN2Jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C29C4CEE7;
	Wed, 21 May 2025 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747832621;
	bh=Qbn7PRSdI6A1vFXmvZ3FylGRMq8wFbpdqz6uoGJ1KTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPTrN2JpL+5ssHyulU38iilerOyjb74mQlk2LvwX5/ybdDb5OXBd6GjUwBq49NZtI
	 SRdftiDutw8Zb1SOaGM6Qd9HDSK2dQV1Pv4NE3sTgM7DeL8abyWOw2XekpHKyK7Ey8
	 7Dkmm5oPcKdZNcG31Ot3biWo9Y/sOrFiGxQHr3tb4vxYnTYVRdl0UQB4JoUzpRtoA5
	 ZGza6qn7Rl/l2iS3Y7cR/bmVvP8evv92wDse2aM/Y+9zxYEgQWQUJe83iT94tXim89
	 5tipJx89Jl3SPqSS2H0Af9/Evi3G5geCAx8tppJTpB2nAwlBYlhs+aAQte3c2JW4FD
	 +uiC6O63YzT7A==
Date: Wed, 21 May 2025 14:03:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/9] tools/nolibc: move ioctl() to sys/ioctl.h
Message-ID: <eda3af4a-8dfe-4f82-a934-2d0256b754e2@sirena.org.uk>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
 <20250515-nolibc-sys-v1-1-74f82eea3b59@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qmCeH574rrIaZhHB"
Content-Disposition: inline
In-Reply-To: <20250515-nolibc-sys-v1-1-74f82eea3b59@weissschuh.net>
X-Cookie: You need not be present to win.


--qmCeH574rrIaZhHB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 09:57:47PM +0200, Thomas Wei=DFschuh wrote:
> This is the location regular userspace expects this definition.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>

This is in -next as b8c436bbef0f2a and breaks the build of all the arm64
selftests using nolibc:=20

clang --target=3Daarch64-linux-gnu -fintegrated-as -fno-asynchronous-unwind=
-tables -fno-ident -s -Os -nostdlib \
	-static -include ../../../../include/nolibc/nolibc.h \
	-ffreestanding -Wall tpidr2.c -o /home/broonie/git/bisect/tools/testing/se=
lftests/arm64/abi/tpidr2 -lgcc
In file included from <built-in>:1:
In file included from ./../../../../include/nolibc/nolibc.h:100:
=2E/../../../../include/nolibc/sys/ioctl.h:8:10: fatal error: 'nolibc.h' fi=
le not found
    8 | #include "nolibc.h"
      |          ^~~~~~~~~~
1 error generated.

This happens because:

> +++ b/tools/include/nolibc/sys/ioctl.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * Ioctl definitions for NOLIBC
> + * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
> + */
> +
> +/* make sure to include all global symbols */
> +#include "nolibc.h"

assumes that the nolibc include directory is in the include path, or
otherwise set up with a -I path, previously you just had to include
nolibc.h with the includes that are there working due to being relative
to nolibc.h.  I'll send a patch for the arm64 tests.

It looks like the RISC-V selftests are also impacted, I didn't spot any
other users that didn't already have an -I.

--qmCeH574rrIaZhHB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgtzygACgkQJNaLcl1U
h9DhQgf+JgacUZkzi23s2F8G/UznZcACYtRmlTDLwYsVcgns91u9TYZ9CvpFHkVb
B477GNwDzt6lZeEgS26QWH5rnf+j/596lvIOS+FnsYIutEnoyyGxDKySN/9QxTgm
H+j7MJV5CsOgE5SEJpdPus+jiuFcqesuubgOx1Jx1UlluZLfUOrSL9q4mWkbcIu+
FD/421e+mtTQqgxS9JNkn9JcGXaZVITc193UGNFNEPeLBK+doMbxUjE2M45UXttC
ZZg8EZRJ3J0ndGc2YXZ459olXkF+d9SAg4w9ELIfASUlV0DkZHu/3du8fiQngUtK
daXVnzFHpb93bTyjZoe2Dat4HarlcA==
=W+G+
-----END PGP SIGNATURE-----

--qmCeH574rrIaZhHB--

