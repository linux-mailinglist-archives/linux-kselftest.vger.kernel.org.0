Return-Path: <linux-kselftest+bounces-15548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF1B954FAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636121F22ACF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570401BF33D;
	Fri, 16 Aug 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sm08pVfo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32522558A5
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828339; cv=none; b=fVW2fm4FNu2SY9zncSIyucsyDRl6FrOksbvReTxs2FphdZFJpsSuwCFPyYEFOXD+KCRRhma8jVeIVz8MFo0ZCHU2rQZvT/qUYqVMAycVPY3zSquGPkRSmdlUfjdYXgRvHcUFdw9FLfdMa+z2b8u31IpefS715KmXpFTO1qPI428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828339; c=relaxed/simple;
	bh=ad0fB7IUBvhF2W9AX0bap4K1snotd7N34LZQvP74vGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/b6hxImjLWm1XKPUJYzpUxmz54F/Fc+Hgzvc/osLebxYZjeXI02ZqdTsdKKXyLfYYiM2d0UM4qKTrWzaj6SPkGefVRjoqynhcMxWSt+M4n3jSYpvepNJYNznaGYvjZW5XwgU0K3P7xsFNDRxTKPul0vZNXYaW9tx9rBnw/29R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sm08pVfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68D2C4AF0E;
	Fri, 16 Aug 2024 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723828338;
	bh=ad0fB7IUBvhF2W9AX0bap4K1snotd7N34LZQvP74vGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sm08pVfoExik2qygiItyNcXTpAEOjrIHJ3OWrhEl9o5QuezjpD8AyyWMRMcRHZuRp
	 dRa9/hZRoXpkKWxMAESwTKLJIHiyJzMsN174EbGXkxOfQrFv3NcDt0LfMz2oViRhpX
	 7MlzZD8NQLARk4C8Iv7uyd2BFvo0SjGUuN/ClgnwAWR+9Ow3N7rKc8ukY/NaQkf9zI
	 B/Zt460rUkFcf8b+AqvyZeN40abNM3a4v2aLB7hY9YLJiUpT5vo9Qd1iEfvT9slMng
	 RIC+T5NajKFmbUdoJl3sERpFQ8BsDGxoePrzH15AaHBo/sOK1Zcosl8cNEiUTWfOGC
	 v5ZSEAIoMG3Ew==
Date: Fri, 16 Aug 2024 18:12:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 7/8] kselftest/arm64: mte: fix printf type warnings about
 pointers
Message-ID: <5630828b-4ff9-4326-937b-162162934875@sirena.org.uk>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
 <20240816153251.2833702-8-andre.przywara@arm.com>
 <f7d77597-cba6-42ee-9b50-ac4b7984aff8@sirena.org.uk>
 <20240816175908.5f4721eb@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6EsIT99GvxrpIgwt"
Content-Disposition: inline
In-Reply-To: <20240816175908.5f4721eb@donnerap.manchester.arm.com>
X-Cookie: A Smith & Wesson beats four aces.


--6EsIT99GvxrpIgwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 05:59:08PM +0100, Andre Przywara wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Aug 16, 2024 at 04:32:50PM +0100, Andre Przywara wrote:

> > > Fixes: e9b60476bea0 ("kselftest/arm64: Add utilities and a test to va=
lidate mte memory") =20

> > This is another one where calling it a fix seems like it's pushing it,
> > it's a modernisation rather than a correctness thing.

> Well, I get compiler warnings, so I thought "fix" would be adequate. But
> in general this confusion between pointers and integers sounds not good,
> and not using %p looks like a genuine bug to me (though it's admittedly
> working fine (TM) for now).

Those compiler warnings are a relatively new thing - they won't have
been triggered when the code was written, and practically speaking on
arm64 it's more of a C language correctness thing than a meaningful
change.

--6EsIT99GvxrpIgwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/iGwACgkQJNaLcl1U
h9CL0Qf8CdYriSVRUPcjIsFV7DrpxzjvWR4B7uFbkn1gsyoTtSivZLYlVdQpV2LE
UFC1vVJLMBRHQvE8u3gzSuIhiwmq7YSVu5Nom5F9H5MBMJ0siWgCzzFDQywzdAax
9PGO9iAQ0eyxiDvNO2BQZsf8s9brJtqZSllz83JYGtOMT6yTzKqjrjSMeB5TBxP6
8bN0ARFGW0hTkpyLNXbjWPnRp6pXp6EVI1sZIdOCbIkwpHJoFw0Rqn+PUJgLQKgp
3YcMc0F4vW/7bTRUtnvmv/UGlY7BhOXYEThRS0XOcfP8zQC+/cQQ39sectFqs/eg
D65rpVXouxjr4zB+eY/Rp9CbRNuUEw==
=XBGa
-----END PGP SIGNATURE-----

--6EsIT99GvxrpIgwt--

