Return-Path: <linux-kselftest+bounces-11025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD708D6642
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86DF29092B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 16:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D313FD69;
	Fri, 31 May 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlGQi4Y9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87F57CA7;
	Fri, 31 May 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717171437; cv=none; b=b8m//3xzHZSSRdIIAUKSrAFDfxVrYAn6hq3tUr3nlsWZWvNW+dQVrGfz6Jn49mziCT0r4BF8B0jB+7ijy9gVrnxZ5z4FP9chZgXhJNb+4HBobdBWHZcWJTJWar8UOAdbgkkf/JAxm3a7EM1LDCA6+I7OENHdqELG1Jan7gId408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717171437; c=relaxed/simple;
	bh=mmdoU1qVhQtqdD4ii+PbVIJT2Sg+supVPQjHAGQV3GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOOfgH7pr7hUNNIHEPITJtUSHPT8E7NFfqOEZ60fh+WTpshHqyNNOsp8EYE4h7s0pbbs4vV47NK86mwHDogy1DDoCryPU/6rt7ajhba2EpgIGoJRLVcg7kSiX1FFhsE/f3YADqamBNnblzFzyvgxbveb2DJZDo3MFFkPk4FNpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlGQi4Y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D25AC116B1;
	Fri, 31 May 2024 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717171436;
	bh=mmdoU1qVhQtqdD4ii+PbVIJT2Sg+supVPQjHAGQV3GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlGQi4Y9G9zIoL3xuOxdmczwOGbYFxnURjA2JDIEGA6KwUtu+c4TSRrl7n2fcPlLp
	 hXE6qGif1xMPji2fWyRhxYNbo2dsFkuJNxJFeg8lHo7LPD0f7qP8uRYB33XbSOqakV
	 XLJO5MnmcAz6Ae+yl8LhlbDCTcOnjiLY4OPT2QznavIl0qFJ0rHwSj2sfXj8RoaLjd
	 DsrQnV2Ur84OdWdLC2gDUYxjODwm+bTjkSYt8YvVP0GkPvggik88tVFmjFEBSXUi0w
	 vL+aE44eJYYZcmVaqwMcaLqD1q508KQ66vWc8+Pm0rsKL3/gnqIa4dlCFw0dB8Ls42
	 fWvtXQ/wVNx5w==
Date: Fri, 31 May 2024 17:03:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: testing/selftests/alsa/mixer-test: 10 failures on Dell XPS 13
 9360
Message-ID: <21f73368-5db6-49a1-b8b7-9b06e698327a@sirena.org.uk>
References: <1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de>
 <87cyp280yw.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jLxaXCXOci4dLgUt"
Content-Disposition: inline
In-Reply-To: <87cyp280yw.wl-tiwai@suse.de>
X-Cookie: Serving suggestion.


--jLxaXCXOci4dLgUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 31, 2024 at 05:17:43PM +0200, Takashi Iwai wrote:
> On Fri, 31 May 2024 07:50:33 +0200,

> >     not ok 5 write_invalid.0.40
> >     not ok 201 write_invalid.0.12
> >     not ok 208 write_invalid.0.11
> >     not ok 264 write_invalid.0.3
> >     not ok 271 write_invalid.0.2
> >     not ok 278 write_invalid.0.1
> >     not ok 285 write_invalid.0.0

> Through a quick look, those are no real "failures".  It'd be more
> preferable if the driver returns an error for invalid values, but
> currently it's up to drivers how to deal with them, and some accept as
> is but with correction of the values internally.  They are shown as
> "skips" in the summary above you showed, after all.

I would say these are all bugs, they show the driver not correcting the
value and allowing users to read back out of range values that were
written.  Even if the driver is accepting out of range values I'd expect
it to transform them somehow when storing, the program will accept a
mismatched read when testing this case but it will complain if the read
value is not valid according to the control's info.

--jLxaXCXOci4dLgUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZZ9OcACgkQJNaLcl1U
h9BPOwf8CK99y4J2OESAMIAnKoTjj7aT9gisEHT9YPaqLHRfamBxvQAAA82KM1im
i7Db99K5p6+dVe06uCjER7QwX5nte6GWBptskKcEc5zCmSILDbxdaLLzMu+qKqj8
qKtx2ibYH4QH93vlPadQAtclILxrL/LiMs/+5ywMnwNqYqIjAfhC3BS+uh6snj7z
txV45Mso7Y5XdiSYiDywDvM6m9Ynj3dYX35w7NWBQ+9u3f7WhEZCgGoGItmrfKhN
rB8T1JvfSWgHJ3j1ShyCDmlUQvHhsb+2MNI4BJHr6U9POYaeKy7t4iXt17+NvOF1
xhacPn9zAzkqQUz7J1wY6raO+OgzNw==
=vfA/
-----END PGP SIGNATURE-----

--jLxaXCXOci4dLgUt--

