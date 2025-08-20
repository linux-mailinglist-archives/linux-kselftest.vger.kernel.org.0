Return-Path: <linux-kselftest+bounces-39368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF1EB2DA97
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 13:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624775C5389
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 11:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D5F2E2DF5;
	Wed, 20 Aug 2025 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjoMgF9t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A939EEDE;
	Wed, 20 Aug 2025 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688323; cv=none; b=uyrMPCZ/QG+yW0lzfUeSLp8jLlUpkTssQLjVoraa8AJHF12wBGt1b1DOBniKXjZ9qTRl9qJf7+7e1+aqbUWaH9EFvtOLlGxZdQ8uHgqT5/w4snRd/kj6EYxcNz665dIc6II99jfZzpxIn6zUIK1OkvhSQWfiKBnZxPJPtqJQ9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688323; c=relaxed/simple;
	bh=uelpzfAus7T4cNwWxHRNcaR1zhmvwzv3JA5pkiDgjpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2PA7NmsmzUCYElIgdqQfPd0hHO8KpPNLfFTi7fESMktKq5Yw5KisKZjM1i4Er6qaI1eN3sC8Q95tzLB8ACs+b30E9Fq9s+EbR5AwBJVlCrGM4V0YNNDFH09JhdefdSMfm6d42mgEj5Vh+K/eb9yz3iisrZgMun5SkaWekJKTqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjoMgF9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D809C4CEEB;
	Wed, 20 Aug 2025 11:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755688323;
	bh=uelpzfAus7T4cNwWxHRNcaR1zhmvwzv3JA5pkiDgjpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JjoMgF9tPfHSUiTAV/IcbrA/yawyIpFAe+2SsSiISdtotHcnCFH4c4CiNFym6lneT
	 oTdTjGTxdHr8cMKNUDizoVdMuf2DkO0qvvT9mzyyBgVVUPaLxK5x2kMhkS21IkOOXm
	 10Qhbh567qWy/86BaItBpag9ZB+JFlAUMVu7O8e+STAuK4zRmZXuc6KbqzVSblP19l
	 p086ezKSfXxmPpoPI5nYAyIXeFbVUgYRcG9wv/ggj7Pjat2M3A6BVnqappVfmAGp2V
	 Wc6lqe9YozLQXnIjFMRt+0ynUMJhaC0DPXBMZZXjppGGGhFkV0tbx83MKJAawBNuke
	 vIIsu+WI8FW4Q==
Date: Wed, 20 Aug 2025 12:11:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] selftests: harness: Rework is_signed_type() to avoid
 collision with overflow.h
Message-ID: <18f2ea68-0f7c-465e-917e-e079335995c1@sirena.org.uk>
References: <20250624231930.583689-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2aT/0UNAiNyFJt+8"
Content-Disposition: inline
In-Reply-To: <20250624231930.583689-1-seanjc@google.com>
X-Cookie: divorce, n:


--2aT/0UNAiNyFJt+8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 24, 2025 at 04:19:30PM -0700, Sean Christopherson wrote:
> Rename is_signed_type() to is_signed_var() to avoid colliding with a macro
> of the same name defined by linux/overflow.h.  Note, overflow.h's version
> takes a type as the input, whereas the harness's version takes a variable!

This patch is in -next and is causing widespread breakage in the
selftests -next on at least arm and arm64 due to:

make --silent --keep-going --jobs=15 O=/build/stage/build-work INSTALL_PATH=/build/stage/build-work/kselftest_install ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- kselftest-install

...

In file included from test-pcmtest-driver.c:10:
../kselftest_harness.h:59:10: fatal error: linux/overflow.h: No such file or directory
   59 | #include <linux/overflow.h>
      |          ^~~~~~~~~~~~~~~~~~
compilation terminated.

Sample build log:

   https://builds.sirena.org.uk/5303936d609e09665deda94eaedf26a0e5c3a087/arm64/defconfig/build.log

--2aT/0UNAiNyFJt+8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmilrX0ACgkQJNaLcl1U
h9BLSwf/cRKn3J4t1uI3cNNpE0JKxWL7PcQdUsrNQToHFdHdVi7hAzmnWghZ/vo3
px0Yka/MhLQGJaiW0MZpMgxzu0ZuYnvZVpjT0eOnRqJHPG4JdbP/D+1A9YRa0Mjc
hkEZoJJ6o6BqV3Izlr8j4ny3w+WAGgacBTSw5EZ0jCl/aNNqkyDhNmfUJOrJ05v+
0B1dLXsr+O+TxN+NsoUUhshVnXaBcA3teQbZjo6BgjGsUKjNg/HBHt32ejOa3Nnx
ydzG/2cNrt+YIGX3hUB7p4rQ23SisUZ9XhpwrzDr3mU+pyLaS9m6vptW7GSmSksZ
DcUDq5p3R5FmmwRMMEHRw4vLQUncrA==
=h8CZ
-----END PGP SIGNATURE-----

--2aT/0UNAiNyFJt+8--

