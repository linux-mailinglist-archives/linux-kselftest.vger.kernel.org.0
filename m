Return-Path: <linux-kselftest+bounces-38467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70236B1D73B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 14:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC2E583CF4
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 12:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE8241114;
	Thu,  7 Aug 2025 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAkok6Dq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83B43AA4;
	Thu,  7 Aug 2025 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568470; cv=none; b=txceKFaTKrrVpT50+DLoBQ7xt04h5q1BPPbSjFJZsq0EZbTWxB1JSQxQnAOYEOKtmaDahRfdftVzc9YFsWNubRHt870/fOlMI8EsTVj8O03vu+I467LeY52z68954FGMyDyySKKkPe6W75R3NDD3QNX7CHYBfBqECmq5XhoCar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568470; c=relaxed/simple;
	bh=ti6x8EpGqyahCD+Y3Mih/DY0CCuqQoST2D+YWQjTsq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHAHmuhTK0TPkc0xfNkPtMMyBCuGe7UJ3sg9arMKbqD9g3KWlRfD7SC+C0/oNK2zbdqWekK/Ia9THe2j13tR95ISVjYs5+WMvnZRqUMjLgs878+iPe77Bs0Yqv7VLzKEuHKTDRX9GP1bl9s6sbevabXOHDRwmXZ7s7rHe7nh23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAkok6Dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243A1C4CEF1;
	Thu,  7 Aug 2025 12:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754568470;
	bh=ti6x8EpGqyahCD+Y3Mih/DY0CCuqQoST2D+YWQjTsq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAkok6Dqgk+74pz/Hwby/2HFzHr3w8rBkiC2KCgO6KRbqmr6ioxzHTbOoTb/byURW
	 J+irFprCwTtl6ENUGKa1MJY1suoq/Rk+4ndfNj2HyjkzLdywuFSBxADG4w60N/ijYo
	 gbqYGBJPeLyW9++948pB3sT9Qw18Z0DM8PUEXlB3WNhLnke0RQzu1dCJg68AS+3Eph
	 IgHuAw1gutqNm+3UzGGCX1smiQZaWPhohTxssJ+XISk7ABLvrr2UtSikMryqkC4hXr
	 1HiyJqL5oPCD6pla2vrxYE8PmWsrMJfSNeVwhVR/R5aAjpIHyYAtxqi2wBeCtClOqf
	 H4sbCYxcD5U/w==
Date: Thu, 7 Aug 2025 13:07:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
	yeoreum.yun@arm.com
Subject: Re: [PATCH v2] selftests: arm64: Fix -Waddress warning in tpidr2 test
Message-ID: <be484cf9-6f29-4102-9f4e-81fde0b752c4@sirena.org.uk>
References: <005af416-66fa-4222-964d-e20bd2eccb7f@arm.com>
 <20250807114247.5915-1-reddybalavignesh9979@gmail.com>
 <20250807114247.5915-2-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1FKV4TcAe1AUa26M"
Content-Disposition: inline
In-Reply-To: <20250807114247.5915-2-reddybalavignesh9979@gmail.com>
X-Cookie: Real Users hate Real Programmers.


--1FKV4TcAe1AUa26M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 05:12:29PM +0530, Bala-Vignesh-Reddy wrote:
> Resolve compiler warning about always true condition in ksft_test_result
> in tpidr2, passing actual function.
>=20
> This silences -Waddress warning while maintaining test functionality.

Not just maintaining, it fixes it.

Reviewed-by: Mark Brown <broonie@kernel.org>

--1FKV4TcAe1AUa26M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiUlxAACgkQJNaLcl1U
h9AKWwf/dZAkEEAu46CJ1Sa8y3a7MXpx6X7UAuRiB31klZ2zW9tH4Wo8HBfI2+a1
eVGbKUqf2N9n+J2cQ5YHkIeMDsWsl4gMq0QjXoA6nBcrMf8jSs80ADn/EXBi20ND
HoxcWz3XKmwNkQAkOg2F1QW0W4UQvWoKPPdIuN9sWIV8lq2EknEjwz/ln22r7Ny/
/N4QLDKh5Wnv1lNoyjkM7YA+UgiLT3acNTuwzjcAXiLovCP0Dimd3PMMpbZ2/UA5
KgcUS0fAwYkQsMgETs7Ruqbrkkynd4+sK554mvYLBNZExcpcKSADfa4dE8hEQM6o
hS6rJPP7iTOhAjZlMhcdq7bBswi7Tw==
=nkHy
-----END PGP SIGNATURE-----

--1FKV4TcAe1AUa26M--

