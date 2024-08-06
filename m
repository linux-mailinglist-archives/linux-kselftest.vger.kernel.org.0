Return-Path: <linux-kselftest+bounces-14855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64F948FF8
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 15:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAB228343B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFFD1C9ECC;
	Tue,  6 Aug 2024 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOHrafx4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429441C579A;
	Tue,  6 Aug 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949462; cv=none; b=L7w5dV2fLLBMO1Zgcj0Cwk8vrQns4VY0O4f5gwUmL3kMPJP8nVjgGPlIqFaAXyAEWuK4E5BPlbVPhMVI+BlclzTSIJJyJ0UnoKVmMSW+CbVOeQVOy+fxaQCWvB2E81u0WUcn8hEbQQ9N68/lwzsTMXC0h5w0zRQnVadouSagvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949462; c=relaxed/simple;
	bh=3fm4dJikrDQXPdImpdjzGgIkMNn1BpK3X8FtFGLW8fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaYt+LkcJnpBjWlPE/OPlaHbCwt/YcHV9omBPj/N7MrZHDiHQx8pcrDx1oJ1T48yXBQJiBi3Xr7dXNmWVzIjVfMgSfkLUmPrt+98kVDtKE3uQYuigQrINnNldaIOLanOkRgeH5X2yW9VwAErXT5Ctnenb+Bfl9CWYz9wL8BCF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOHrafx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79977C4AF09;
	Tue,  6 Aug 2024 13:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722949461;
	bh=3fm4dJikrDQXPdImpdjzGgIkMNn1BpK3X8FtFGLW8fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOHrafx4C5f4gjmBQTbibSHhrcs80YWJeUPw4gRrtYNRVU2c6ioEsSGLTacTiaF8x
	 LIrY8c0Wnyn6RpAWKcaEDwu+siPiP0M9VdpUMeer307YPUvYEJWdW0NN3eMKM8F7uY
	 Kc/vAqHSh6C2Xj3ELbd9aOOwocSPreUm9hYEJQhjki5nFro8L/QY+TePRMYOJoew6V
	 9M4auph7/2oM5hkQ19bGlR/KNsyCX2s+cWPxwnRacOtTBu3nnWkIx6Uk/P7Ak/1hCn
	 m/490guar2k+8+DEeDXhHtKl+TsyRVW2JPwvSeMFVl1prirwTaI1HYrvHEffK+hORQ
	 U16E10B/LEuXg==
Date: Tue, 6 Aug 2024 14:04:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, corbet@lwn.net, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr, aholzinger@gmx.de
Subject: Re: [PATCH v3 4/4] selftests: ALSA: Cover userspace-driven timers
 with test
Message-ID: <038cb9ff-4028-4179-9722-df324e29c73d@sirena.org.uk>
References: <20240806125243.449959-1-ivan.orlov0322@gmail.com>
 <20240806125243.449959-5-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RMCFLusiTb812Ih/"
Content-Disposition: inline
In-Reply-To: <20240806125243.449959-5-ivan.orlov0322@gmail.com>
X-Cookie: One picture is worth 128K words.


--RMCFLusiTb812Ih/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2024 at 01:52:43PM +0100, Ivan Orlov wrote:

> -TEST_GEN_PROGS := mixer-test pcm-test test-pcmtest-driver
> +TEST_GEN_PROGS := mixer-test pcm-test utimer-test test-pcmtest-driver global-timer

This is adding the timer timer tests as standard kselftests to be run by
the wrapper script...

> index 000000000000..c15ec0ba851a
> --- /dev/null
> +++ b/tools/testing/selftests/alsa/global-timer.c

> +int main(int argc, char *argv[])
> +{
> +	int device, subdevice, timeout;
> +
> +	if (argc < 4) {
> +		perror("Usage: %s <device> <subdevice> <timeout>");
> +		return EXIT_FAILURE;
> +	}

...but this requires specific arguments to be run which the kselftest
runner won't supply.  I'd expect it to be a good default to enumerate
and test every possible device and generate a test for each.  However it
looks like this is really intended not as a standalone test but rather
as something run from within utimer-test, in that case it should be a
TEST_GEN_PROGS_EXTENDED.

--RMCFLusiTb812Ih/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmayH08ACgkQJNaLcl1U
h9DVfwf/a9QwUeXEBDc36TW+3+RklKKoqRdN88NVI10XuBsSFPzPFxw4GgVsNWP2
eX1PLdmNPmQb6nFxHfmgXpFpURjZt/jl6ylMzfi+haDgorIQwerh8lcDrz89rWCV
4ckzPWX9+5VMA7zc0xC8qj59JlJFIVAZ2aCG33DochRL88PQpNeDtvt8SV4mzuyf
bnrdslJmgrbS+YYqfUjJ/egEe689AtQTnaWPFVSn4eZk7oLUX06g/4wpU6t3MquT
RGusbsQDrAPc/kEyCe3dBXfkIwhEQtaUiGf6L4urncjxuKLhd1VSkiT2KG9kG6wa
5cx9r/wWC9/EAAwJydZ5NXgUl65JxQ==
=Wsrf
-----END PGP SIGNATURE-----

--RMCFLusiTb812Ih/--

