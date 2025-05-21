Return-Path: <linux-kselftest+bounces-33480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECC7ABFD03
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 20:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D91F3BCD62
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E2A265607;
	Wed, 21 May 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hlw6QwHX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46C234966;
	Wed, 21 May 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747853383; cv=none; b=DpaJYxG007OMl9wQ6c49ftgr7uy7j+Ze+EVRvTLTvP9gvAIdQ4bhF6LZbZZ7NRcac96iTOyjhbu+5LKMgG8LanEFKLuDbuy9/j3mv0TT3jDr7ahmj9bd98drUCjOfiu8epOv5zd2YrJ/qQ8WMl/VoF6polpEut8bt6sslutrrHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747853383; c=relaxed/simple;
	bh=IMq9nfW8HsQwncGqiX9E6lz4FwMzx6mYREOfYHX1eio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP6t5rHDH4sHyR50EHtqPFI/CkBL0RhpSZG4krkQyIOrtthoholBV83pRNCjfCImsYLxn4W+/zVu662kDV+XPzMf9mOJtztUdUF6mwYY4+V3UGa9dcqWVff2Acs86Sp5Rc1x1mjwD6FqBFseVpEjG0pCKNDo1+vVJ7SwlLE41kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hlw6QwHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74BFC4CEE4;
	Wed, 21 May 2025 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747853383;
	bh=IMq9nfW8HsQwncGqiX9E6lz4FwMzx6mYREOfYHX1eio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hlw6QwHXZoDWGF9UhIsMlw2m28hE8LDttCV1UqAqMZZrnkPo2XDCzsFaiulgww14t
	 xHxsycQMJwRVfmOuvXWSRB/kDHNncf7NlgzXYmn456cLmGZxWW99/bojw5jajoYigd
	 t5I71C+NjD7uBtiM1tKWmmm531cyk74pEHXGzi/NSdilIeYbMGrRgebRCZJDYnzCyk
	 9VaSpF1F5CMu1GFHcLz4IwaORCoKEZ/zXhPGbEf6NstdIwuBa9TtdXn3VaZEP20jOt
	 25NOpFmYE/hc2tH8amOWwGqYK+mJ/DOs59oqGxZf47ZUHHlSfk15+sr4auDU54cqkT
	 8oZ4zhEcIsnmw==
Date: Wed, 21 May 2025 19:49:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/9] tools/nolibc: move ioctl() to sys/ioctl.h
Message-ID: <ccc18ae8-80e5-471e-b1ef-da132b13b27c@sirena.org.uk>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
 <20250515-nolibc-sys-v1-1-74f82eea3b59@weissschuh.net>
 <eda3af4a-8dfe-4f82-a934-2d0256b754e2@sirena.org.uk>
 <89bb5a3e-dd6c-475d-9c5d-0bd1595be735@t-8ch.de>
 <744a1aa8-1efc-4c20-b45e-070fc038f6e8@sirena.org.uk>
 <198bf1a8-98d0-4693-a4cf-234cad728c9b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cXi9NBIssmtNxLQa"
Content-Disposition: inline
In-Reply-To: <198bf1a8-98d0-4693-a4cf-234cad728c9b@t-8ch.de>
X-Cookie: 42


--cXi9NBIssmtNxLQa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 03:45:42PM +0200, Thomas Wei=DFschuh wrote:

> Or you could run your testsuite with the new nolibc for-next branch
> which should be fixed now.

That seems to build with 869c788909b93a78ead1ca28c42b95eeb0779215 which
is the current HEAD of:

  git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git for=
-next

--cXi9NBIssmtNxLQa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmguIEIACgkQJNaLcl1U
h9B1Mwf/fr9vilzSS2UINyADwkicrOK6YKNXByxHydqukjnrjvmREnuEyWIGbWdm
aaXAcTk/BIL56KUYNZzT10LdcARo1awOjBkvByxyUfcVyuzzxYlZGxQrkdf3fkif
JG6xBi1HbkkCpB4VDI9CQnBaZ2yeb7ozeVyYSYyelS507/WVJPuseqr6dSnOIfQW
5UkfVUXF7rcz6uRL5zuQV+NRi+z2y8u35VsqBUVvbw00WqET7E5DS6BuX3az8oON
Cbehf52bKh0CoZIxaCMuKJeiu/Vk+otCiTtqnNKS3kpn0umsFoDj4rfH/ccj5qV+
ptfCS8730VjULFesybpXpXjhzBnbUg==
=f5MH
-----END PGP SIGNATURE-----

--cXi9NBIssmtNxLQa--

