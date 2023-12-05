Return-Path: <linux-kselftest+bounces-1137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 346BB805563
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AE82817CF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066465B1E8;
	Tue,  5 Dec 2023 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCO+MuX9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB556473;
	Tue,  5 Dec 2023 13:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FD0C433C7;
	Tue,  5 Dec 2023 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701781393;
	bh=lF8CK0pjxX1D/FyHV6Cs2V2LUREtHoin87SU5A8Sn8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCO+MuX9IqRUeFUsTVhQJejeyXrzVCd+kEm4LgiPHU8s69Nw+YR618LGg9+qlNS7c
	 sLVK55XJwmhb5po6/dgV0Z1cbYd4P+83djx/DTAqVlKiMXUjnplB+rGo1n9kFrWEPS
	 Z+Hbb5KJEEEYsLhjRGdwky+wMVNlmn7gpsJmJz5Xz5iXlqLGNagLQt/g/U3t+SXdOH
	 KVYX1hJ+58f0kXmjHX6YX64DlniWZ0L1IgeQoGBcp0Y7SbAnSes2EGSmcOhSHq6xz4
	 tVAGey996XRnYj5VwKpWWBvObuK6BuQlDq4EbUwQsBoG2bf/P28z7Fbw8hAqhWpxGS
	 wxGAaA74Q1BHQ==
Date: Tue, 5 Dec 2023 13:03:06 +0000
From: Mark Brown <broonie@kernel.org>
To: davidgow@google.com
Cc: Rae Moar <rmoar@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Maxime Ripard <mripard@kernel.org>, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 4/4] ASoC: topology: Replace fake root_device with
 kunit_device in tests
Message-ID: <feb6b3d9-8a56-4193-a45b-30e2ab0e3b53@sirena.org.uk>
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
 <20231205-kunit_bus-v1-4-635036d3bc13@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KyBf/qGc1XRWqySF"
Content-Disposition: inline
In-Reply-To: <20231205-kunit_bus-v1-4-635036d3bc13@google.com>
X-Cookie: I've Been Moved!


--KyBf/qGc1XRWqySF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2023 at 03:31:36PM +0800, davidgow@google.com wrote:
> Using struct root_device to create fake devices for tests is something
> of a hack. The new struct kunit_device is meant for this purpose, so use
> it instead.

Acked-by: Mark Brown <broonie@kernel.org>

--KyBf/qGc1XRWqySF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVvH4kACgkQJNaLcl1U
h9AFbgf/bgK9XVnQoAUMv87Z1CQnQuPpp0QhnCmWZFdGZ4GjvHke057jzsTnJ8h6
3ScpMXqmMUVbccALtmJOUePEtoRQo5JQkv8TZG/vSoNorkXCGlhZAW8yFrPwo5n7
2h0Cxx9voKORC48sOz+N6e9EkaDTGlULV+jZf5OdI6lY3GQeSjLQ1UxL8+1IINyX
UghWoJI8ieTf/IVd4r6jRQ6yEoJxyKyZhQyB/tuHyKbS6vwhR2qpctRfM7Ojaxsb
UyQXCP2eusxkBn5HWe20YI94dce0y4PJyi7zSXi+X09X41I8HHKQFUhYD+3V2aYF
zaD+g7IpnmuPIVm1ktzDR/o1blYjOg==
=Vsiy
-----END PGP SIGNATURE-----

--KyBf/qGc1XRWqySF--

