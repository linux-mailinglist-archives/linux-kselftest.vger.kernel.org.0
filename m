Return-Path: <linux-kselftest+bounces-11966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDD0909038
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 18:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D881C22DD3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 16:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4093716F0D1;
	Fri, 14 Jun 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAOAwyQ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507DD52A;
	Fri, 14 Jun 2024 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382489; cv=none; b=X1bh8y9WgH3xEf+T5RLmLRdK/G8+ZCoBG4GWSpg5WXqdU3unWv7q4z+bF+k1dcUDesaxDaPdFxkjOGeCwVCgBownIF5x2pOXDr0pB5z7YGWCULoDh3ESnstTbj/SsJJCO47UCcgJoydfrS9Qdm+gI7qJOmbpTi2B+X/LHEE+4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382489; c=relaxed/simple;
	bh=QI+0pqh/e8QHx+kHgLMvlIb4qjVYZac+w+6+cANvQCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7+pzpr26lPNu9t7RGdzFhIUK9pTxAVplOS7/kDO4ZvRTwMaXqQJsftPJyohIiXu4dC9lVq0pvUdHAJS5eu9JoC5a8bnuKx9f8on69sb/QaY/jgcAL8k19BjMiL2AzEh4sq2zxeYgXL8iT1QfogxaHCTszFO9VInJDsTOvTjCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAOAwyQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085B7C2BD10;
	Fri, 14 Jun 2024 16:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718382488;
	bh=QI+0pqh/e8QHx+kHgLMvlIb4qjVYZac+w+6+cANvQCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAOAwyQ3sfeft3ny8ev/TTcgCMMy0wVsz/dHya3rTFtMkAfkfFG1Zv0+fgwaugSVy
	 l+mhcsoHlkJVz0Cu62+uNPrpjyR69X4UUAKoSndHKJyeNITQgsZ8te47rj5CKv9BXJ
	 0QFYzdK+xUJ35JivFSI982ZCm6olQzMLENi82veRVRwpIP54651RKUsLfLLhxKfJTg
	 0y2EknPoFpLETvukV33LiPC5FwVgTdbYReKJ04fR3iW5S1/RkTWUp+Ct7qcb9z6Jp9
	 hwud1uO6NOU0JWz9hwKhCFKqVDVdEluKZiEWoUlOVx3yoBsxDgkM6lyTekDbPGpMzV
	 6ZB+bj6bgGl7g==
Date: Fri, 14 Jun 2024 17:28:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/6] kselftest/alsa: mixer-test: Skip write
 verification for volatile controls
Message-ID: <ZmxvkbDfmhRbBjeB@finisterre.sirena.org.uk>
References: <20240614153717.30143-1-tiwai@suse.de>
 <20240614153717.30143-5-tiwai@suse.de>
 <ZmxoaWvgZk7tJq-7@finisterre.sirena.org.uk>
 <878qz77bir.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7B4kLaNoyow4NhAp"
Content-Disposition: inline
In-Reply-To: <878qz77bir.wl-tiwai@suse.de>
X-Cookie: Your love life will be... interesting.


--7B4kLaNoyow4NhAp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 06:08:12PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> +++ b/tools/testing/selftests/alsa/mixer-test.c
> @@ -668,6 +668,10 @@ static int write_and_verify(struct ctl_data *ctl,
>  		ksft_print_msg("%s read and written values differ\n",
>  			       ctl->name);
> =20
> +	/* Allow difference for volatile controls */
> +	if (snd_ctl_elem_info_is_volatile(ctl->info))
> +		return 0;
> +
>  	return -1;
>  }

That'll still print the warnings about the values differing and won't
check the values are in range...  I'll send a patch.

--7B4kLaNoyow4NhAp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZsb5AACgkQJNaLcl1U
h9D6Hgf/a3aDEKiEQ2av0+lon8wKIUAaihFEAWq6gO0z60krt5pwwMgorX5OIYZq
NzeFv31MLwky1ukCc02EuaR66obdsSGQtW65K5B030bOlSXdrvHVv6UpAyKsi/R4
jC85kXAUtEtC8EhbTbju4j2PgVC6c0F4EHB4isJiih6tglS+lhaoyoO29eHEYDGM
t06OYLYr8pNe+HqUdyNfTB/cK9cw/cG3EaPczEwXNlXpBJ5vzPUWN6ZSUxCtJiJ+
sv7QD+OlP3r8vaOeo447ZUh94A5EDeDxb621XO/7+ZBoZf2LKB2YRZfPRmjqvBy9
dPNEsXvPKExqQIMvT0A8Dh6tqpj4hg==
=CvJD
-----END PGP SIGNATURE-----

--7B4kLaNoyow4NhAp--

