Return-Path: <linux-kselftest+bounces-11964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEAE908F70
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 17:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09511C20F25
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CBE16B73D;
	Fri, 14 Jun 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6ZRRHbe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E4107B6;
	Fri, 14 Jun 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380661; cv=none; b=aAD/W/V+BmG6/kFZFSjAR61xE96Dg8oivZSCgkUMVqL/nRHLzJQeDqxYdAGTGb+7OqtFzTy4oFWh4o7A9CBFL2VzJMG7ums9e6IE8MoV67lL3bewKEcjlgk0VIjU/2KkT/YfXIYY+fRrvYMJlqDkJikF4b/hAWO3b3+EQmz+zmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380661; c=relaxed/simple;
	bh=9YJYmb9k4JoqDgBM8JJj+jJ2jfNrAsNN6SQIUgFMFpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+OmeqmzEGSnKf5ASCGs7XnQE6FC5bjgl3rea55jqPW+t5nmnbzQtfQZsY07u/mA4lWtnMcTD7uO6+gTm03fBlag4WIEo8HUYoa6uw8R9VTqd/D2g7Ah/QbnhS0m0yvMhBGjQfVATs4tMnTbmhym5LsP3qIMYQJLyF/i54FNVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6ZRRHbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1726DC2BD10;
	Fri, 14 Jun 2024 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718380660;
	bh=9YJYmb9k4JoqDgBM8JJj+jJ2jfNrAsNN6SQIUgFMFpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6ZRRHbeqLglw1oXpRGVTkqYOe/I0EoClygByyBeEbRraSicNgDTZaTPpRRY8RIw6
	 zbUQg3aCBTceX3/zQo6L0isFC0czwxF6cjkwA56Q7/++0lSR3LSnFVd98Z7hCTarxt
	 GdYQBdBkb/OYuKEYOZu++Ub2a6ZDsOf5DVGMFtomHl57lBTH16jsON/lg9WjiDiQrN
	 9Ok3cJJqF1Kut4ZOC7ZEywMU2JWdMUPC7pwRYFnMYCY6M+9HODRG4ocYJu3V+AhsQ+
	 ue2ZHwA/ITeo+/ZXwHpV//y9Lz5A5IXKn8SBzzcLfOvT72zbZDCIjmYmIG/hxp+bnm
	 5ZRFb5/PJHJeQ==
Date: Fri, 14 Jun 2024 16:57:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/6] kselftest/alsa: mixer-test: Skip write
 verification for volatile controls
Message-ID: <ZmxoaWvgZk7tJq-7@finisterre.sirena.org.uk>
References: <20240614153717.30143-1-tiwai@suse.de>
 <20240614153717.30143-5-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nr+j0G+JQmyq4+xh"
Content-Disposition: inline
In-Reply-To: <20240614153717.30143-5-tiwai@suse.de>
X-Cookie: Your love life will be... interesting.


--Nr+j0G+JQmyq4+xh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 05:37:13PM +0200, Takashi Iwai wrote:

> @@ -616,6 +616,10 @@ static int write_and_verify(struct ctl_data *ctl,
>  	if (!snd_ctl_elem_info_is_readable(ctl->info))
>  		return err;
> =20
> +	/* Skip the verification for volatile controls, too */
> +	if (snd_ctl_elem_info_is_volatile(ctl->info))
> +		return err;
> +

I think we should do the checks in test_ctl_get_value() still - a read
and then ctl_value_is_valid() on whatever we read.  It doesn't need to
match the value we wrote but it should still be valid for the control.

--Nr+j0G+JQmyq4+xh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZsaHAACgkQJNaLcl1U
h9BKzwf/R2dp2R60nNffDBdIguuAggJLN2JnTKeCLy/B5SED/FfsdkFE8LuoM5Vg
Fbf2yiskFuPzWbBSGrsb17ArZ7mquTaHF9N5YBzVy7w9uGb+4sybFszK7rDCbVsv
VtkHc+EtGS0CyrcNxWp3R5Kz79fV0gk8M3BZQjlvwHBlmk+f6rSEcnFLYdl//1gl
ARO3fvahYCPuz/9ek1C1RZvRPlx/FIprPWxhjmFwaqXwEirKtWa+TLfBIYvi4tQ/
aNruC5X8B6YDZomEmROi2+zb1EZHOw8GmiOQ1pNKs0IlCXNNFsOK2DKaTA4b4JJk
eCZH5OQpWxlw+3ZsFHSDIJEw4zeV8A==
=WmBJ
-----END PGP SIGNATURE-----

--Nr+j0G+JQmyq4+xh--

