Return-Path: <linux-kselftest+bounces-25825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C6A28A61
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E651674FD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 12:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EBD2288ED;
	Wed,  5 Feb 2025 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHd0rkUa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B5151987;
	Wed,  5 Feb 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759017; cv=none; b=FNN0rZA+lUPvrR5Gv082Kmw9h0qTlceVbCOBHOcTks/eLdaY4UVCIyBt6LAce+VQnwbynKLpMqTGID3FPD1VT/V5BinV4r253BacfmRruS91whm9EDLZsoCGSjVLD6zCD4EK5jUAmZLOpy1FllkpT3sXmKtWai4ZSV979ExsTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759017; c=relaxed/simple;
	bh=bT13ceI3nBdf366hlvkA+wI359VrXnZYEbnwGN3H3B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pkd5fbPEihO/a9omfey7OO9iYTUiuEjr5i5DHU89I/Iyd613lIkdbZy1+QwyP3Iaj7Jvcgx0Ey9MzMjE3Idm2sR4B02+glwRRDCzPjOLIbgXEmXXVIil2pLC+aLHsYrBzocxh3ZFaocV870L4/7rlnKlvYjIK3SLK217qb6gruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHd0rkUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C0AC4CED1;
	Wed,  5 Feb 2025 12:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738759016;
	bh=bT13ceI3nBdf366hlvkA+wI359VrXnZYEbnwGN3H3B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHd0rkUat8o2yGWTupAAiw2MNyZpiVSZPY4+wqupePCJWnkfoad6RsQR3UFw6OmiF
	 O/x3S4agJTObZGY99Ivghcy0mLjLm0uZX33AlGivEmLntnVWjI11HSLrCTpuIcmgto
	 XhSZpVJByGXfvaPvHeGcfDETpAEe/rZ25VD6Fu+98nOc1a5wqMwD5XH/AlQ2iZv3Kq
	 PHltZ92u2KyvLefpawaYUt3npBaKYKCiqyho5c53uj05YEqRB+/F7HKZJjSKYFb9dC
	 rDKbFgUoX4t9CvXelPGDq4AErLwseeFUMJ5fv+JJnIr+w1iCZEZwuwHOwG65+Qs7ti
	 ntXCjoGVOAZEQ==
Date: Wed, 5 Feb 2025 12:36:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Fix thuge-gen test name uniqueness
Message-ID: <a4798a92-098d-4c95-86dc-760171365d49@sirena.org.uk>
References: <20250204-kselftest-mm-fix-dups-v1-1-6afe417ef4bb@kernel.org>
 <2e160343-8420-4f55-86b1-128676cf75d3@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1mL/Scwyn0KiF9/v"
Content-Disposition: inline
In-Reply-To: <2e160343-8420-4f55-86b1-128676cf75d3@arm.com>
X-Cookie: Earth is a beta site.


--1mL/Scwyn0KiF9/v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 05, 2025 at 08:22:04AM +0530, Anshuman Khandual wrote:
> On 2/5/25 04:23, Mark Brown wrote:

> > Fixes: b38bd9b2c448 ("selftests/mm: thuge-gen: conform to TAP format output")

> Just wondering how this fixes anything ? This seems like an improvement to
> the current behaviour.

My test automation was getting pretty confused about what was going on
so I'd say so - the test names are a pretty important external
interface.

--1mL/Scwyn0KiF9/v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmejW2MACgkQJNaLcl1U
h9Dozwf/XUDm+mbCcPeu3uNyCi/BytEd7NKmO1kyTYc/v6fF65OJB7jD9HfPQlzB
mD06VAQ110zk+dnkvdpkEw2qB9jgOldkuoSySBVfaDTzt7YSk6HRnR3GzXsX4ExQ
Y5ej9j0TcSFPFjw9zw39iC+t7E7mAm8gTYTpLjnZdGHbWM1REzIrdR3rNqrPVmVv
NIAxtDY8f4+tUyBG22wKI70spNBz5nG1H+IwZQrpltxT9XNI4uf45o3gvryIOr06
psSzIRnOrY56eKyAU8xZc9H1/aU70zHODKIgHyn3nGmoZ9wWkb9A5da7+lSlxlYK
ii+dFyrxJDo7gCSvB+pTji28aOMKDA==
=gvhZ
-----END PGP SIGNATURE-----

--1mL/Scwyn0KiF9/v--

