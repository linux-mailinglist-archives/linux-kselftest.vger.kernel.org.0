Return-Path: <linux-kselftest+bounces-47659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97672CC71E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 11:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E557C301A947
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 10:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754DE34A3C4;
	Wed, 17 Dec 2025 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5oLTjIW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30733B95E;
	Wed, 17 Dec 2025 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965894; cv=none; b=jN72ATLHIZHP6fgN8LwMswoBcBjRzlrAKqKdONAuzadiG2Me9vf4y+31raQZwHvjcldvvMCgdXCX171rjCw7Z8JtCYRCvjtgNAUGT/juEDVUaSzkBg43cea/c2gA43ExuQyxY8OL/MFA+8mHlMmiFWnA4c8lVBBzu6HxB+9ilNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965894; c=relaxed/simple;
	bh=tA+l5ZvTNSZEoLf3HNvvydxy6XUSRTEcyheH1Q9bNsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFvjBRx0yNsqT+3VfsShT4ZZJtaC983h9/yAQJF0athSZXYdEJDLwBNW/4Q1lVWp5W1m1qfGlLQN/FvBpwMNnJQx7o9Ul677sPkANHHfvi3ly2w5PP9ym7frUJatnxGWlt6LQLlm9CZhDSzmWodDGNiXDlhTiIvzNBHoNkfebsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5oLTjIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1D3C4CEF5;
	Wed, 17 Dec 2025 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765965893;
	bh=tA+l5ZvTNSZEoLf3HNvvydxy6XUSRTEcyheH1Q9bNsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5oLTjIW/KPuHmkT+AHgfTV2N7jXScGL6NQg+whZ+vEqIhGoujrZ/gV/Iun1BhbeI
	 4okqWYyOcR3kifBbbiapTMdXdNgpHWB7NK4wbj9nHLHns8i8DeiLi1EenvyzCa00gC
	 Rpx92w6IdxyTPci1H8+YSBwRmbfDyTeAsR+KFVBZcbS95zCtb7TuuBtlddXWEhW/ay
	 sCC1mK/2qMcmVW+ZJ2UBuDBWJvqIkLzXjXrS9dN9Ysmh55nPcIkNullxZKR9ZUkNyM
	 VRIFetSbMC+Ry/4m8cWmhgyLW80+1Q24vUjBBWrPf+1S6cFapVi27BrIEceWyVO9hi
	 +2+QCwrNPr55Q==
Date: Wed, 17 Dec 2025 10:04:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH 1/4] selftests/mm: remove flaky header check
Message-ID: <5f866c1a-c8cd-4dc6-b312-9017cef89920@sirena.org.uk>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-2-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ujw+qSJhd0QmRzk5"
Content-Disposition: inline
In-Reply-To: <20251216142633.2401447-2-kevin.brodsky@arm.com>
X-Cookie: To err is human, to moo bovine.


--ujw+qSJhd0QmRzk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 02:26:30PM +0000, Kevin Brodsky wrote:
> Commit 96ed62ea0298 ("mm: page_frag: fix a compile error when kernel
> is not compiled") introduced a check to avoid attempting to build
> the page_frag module if <linux/page_frag_cache.h> is missing.
>=20
> Unfortunately this check only works if KDIR points to
> /lib/modules/... or an in-tree kernel build. It always fails if KDIR
> points to an out-of-tree build (i.e. when the kernel was built with
> O=3D$KDIR make) because only generated headers are present under
> $KDIR/include/ in that case.
>=20
> <linux/page_frag_cache.h> was added more than a year ago (v6.13) so
> we can probably live without that check.

More generally building selftests with random older kernel versions
isn't really something that's expected to be robust:

Reviewed-by: Mark Brown <broonie@kernel.org>

--ujw+qSJhd0QmRzk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCgD4ACgkQJNaLcl1U
h9A3sAf/aeiWVqvFAVMGUs8KbXmHp6QAZpFsA51N/Ga9olp7RBTZYAaZzoNKWK3L
uTgwaiDSVDODV8AO8B5zYuaAaf36Oe7OL88CAWU5Z7RqQlFdfnnf42gkeI3TjuqZ
OyDA3n640Kpsk08sZzuzTHtwD9x3rVMtoJZs52QNYel8v09Dn8I3rWrU/6H59wBH
B0Ca5jJDLhsAghMC6ZQ27Ryv4jRWSsKIODiLioPPPBdsHrfA2h+PbyIHVFHtnYsg
rykbRI8jXUGRHpBKeSNH+GiD/o2w8gUaLHCyY5LwvMgxBz1+CnGOjGEzXyPv9B5e
rcT6rYEPIp6jodvF8vnl6mXvGsgTxg==
=3Vbm
-----END PGP SIGNATURE-----

--ujw+qSJhd0QmRzk5--

