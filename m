Return-Path: <linux-kselftest+bounces-4195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F120D84B806
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 15:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0121F26CA4
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E544C3D6;
	Tue,  6 Feb 2024 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmH2IHuv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52451E869;
	Tue,  6 Feb 2024 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230097; cv=none; b=BJVT+jRd0JNa7fSTKugLxvf1JvEZmsTiVrJ5Q06VXPT5iXMpb6/iL3Jvk77ls1vLvywO0Xs5MY/95WmkdkvsWdnDMPhL4g7JXrp/jE1KkWMCxC0Ffh4dbOcgLmoMfiBcjmks70JFqpD0FkCSmeJcY1MI1rbLC2KbqU8R3wX3hmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230097; c=relaxed/simple;
	bh=pGOJX9sGR/tZtTMlvuy5y7jlJSC9YMDndeZJL99ifbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFzXtLHX7JCiQdrxZolRb2eqnfY7lMq+NsVYXzuLB/x7UjJTAbp1EjxOKmOIglZvDZLY4qhxuMMypwlba2lp5HAzw+0lmCzRk68KKTIKwLJtD7K1tA2EsSz7eOWR/UZnC/UzTR0gaA4rx6xNhwGOAtd/7IItNJLKYswh/0GJyYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmH2IHuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7568C433F1;
	Tue,  6 Feb 2024 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707230097;
	bh=pGOJX9sGR/tZtTMlvuy5y7jlJSC9YMDndeZJL99ifbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmH2IHuv4WqwcROHd34tjmNiC8cYhdJqG2h2BMIGnyz8a/NAnYhEx8MjjT2bYnL7E
	 7r0kBN5FBWezD5fHlwn/AMucQM/cHMdK31iK9spWwn3BghVvBH9GQXJion9gAJL5xM
	 /9f5iTJ3Ycao+kF6Qlcqb5ZlTr6F8JkliiJwnRTyDILnSRZidOFpxAhRbxcSXK1IZs
	 8lU14UxOSYU9B5pA8QsgfXD1wLKmlwjS9UGjFPMJjq1MBPjFxl+RYFWqPZhm8UUc4r
	 WVXE7HQS5SaNRRqg3nsyh1BISUCqfmYOrBC+uGeMyh9rMRiZFcCSzPdeYwcKCIvxvk
	 plHzzbyYcEEZQ==
Date: Tue, 6 Feb 2024 14:34:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] selftests/seccomp: Pin benchmark to single CPU
Message-ID: <ZcJDjohKwXdWkABw@finisterre.sirena.org.uk>
References: <20240206141234.it.656-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QNlKs+3Im2pOVIx5"
Content-Disposition: inline
In-Reply-To: <20240206141234.it.656-kees@kernel.org>
X-Cookie: You might have mail.


--QNlKs+3Im2pOVIx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 06:12:38AM -0800, Kees Cook wrote:
> The seccomp benchmark test (for validating the benefit of bitmaps) can
> be sensitive to scheduling speed, so pin the process to a single CPU,
> which appears to significantly improve reliability, and loosen the
> "close enough" checking to allow up to 10% variance instead of 1%.

Reviewed-by: Mark Brown <broonie@kernel.org>

--QNlKs+3Im2pOVIx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCQ40ACgkQJNaLcl1U
h9CQ9gf/Wcm+g3m+XVIHObi/0gY3HZCpJsSH2qg9U7m820Z4DCwxxerfVrqhNoHP
caJqE4h4dnm3B8SvMmEqdALSFlHVAzJCzBlhXPtSb1mrYEbJtYh/Di7v/nDL8DYJ
ryemJdAWzXRpO4prNbNaRkiKS06nV982GTqF3TcITI9p+hY6sDSiFWaZtkeTo0Aj
/gJAgU/k3Keji40F9dSICO/1Aik+fohcxEF35uC6tH47oi/6NgPaOvgG6bVrvduK
ZI5Sq+5XfvwxymnNZjjefHaJNGdNnp4jwMZdW7ZKstkjH600xepBcMQZFPPgKzmZ
ALc0QvDdfj0jhyHj5jOcdTo098BwYw==
=evRD
-----END PGP SIGNATURE-----

--QNlKs+3Im2pOVIx5--

