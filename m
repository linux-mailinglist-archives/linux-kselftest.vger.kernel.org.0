Return-Path: <linux-kselftest+bounces-20836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A239B3AE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5230AB206B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 19:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37D1DF97C;
	Mon, 28 Oct 2024 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUK/BsV/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CB51DF74C;
	Mon, 28 Oct 2024 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145534; cv=none; b=g8AHmNVCudfqbpq5clE1BIW1LKQ0nYm9O7kfgRiDdFoW58/rz3G/qL70IQprVqXJpLjozNW833BWuPT8flg5BCS5X+a7Lm4kY5jjB46jV8kGsX9KFNnmkW6jmcB5pfUmY8ufQXabnbURw32pyH5J6qGt2695yyU/5W93P3dUwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145534; c=relaxed/simple;
	bh=yi5GD//oyGJgqQTF4vZx4zIWoIkEhZQZC+WnPRbK328=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvD8iUWQ5w8gfm0Q+0md2pvDxoq/hwxZfdT+dovUPQhtuYO4eBzIo9b8eb8/u/PzZtp8d1FwOLw4yXasGsvcN3pI4eKW3AajXNiiZF9yyzG+P4Rl+W+A7I9pDspnPc8WFVyMR7apftSu1ISOqhAK2jP4tc7D+FiAZ6vM8ytEoMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUK/BsV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64E6C4CEC3;
	Mon, 28 Oct 2024 19:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730145533;
	bh=yi5GD//oyGJgqQTF4vZx4zIWoIkEhZQZC+WnPRbK328=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUK/BsV/WXBkBPAlgv8OjGtRLG/wsaeYi8b8A/1AdjLoUbH20vYH4Zi7P/E2+g+am
	 fKUQbqz8uukGzNeumWYxps1Lc15jPo1IXkhT1Pl0egDPFNgQSuXeyeOwi1izYQ62Nw
	 u6Bwkn33lIu7Uk+26KWVAtyZubkizMGKfsYHwwZlmCQ1dYJ2QmuKVSH53dEsUgINKQ
	 FTSwmg4qDxYAE3Bmar1YEYYQXkW6beleFOQQLQ80iBgZAQX2uaLPLmdQMQ+d8G6Nmd
	 Zi2qE3TpJwWJtgcup9Why9IDPIMHl+tT8aM22eJqbIpzGPcEOFM5ncWQqQw8dpXRgQ
	 zshpDQE4OprPw==
Date: Mon, 28 Oct 2024 19:58:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	lkft-triage@lists.linaro.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: kselftest:arm64/FVP: arm64_check_buffer_fill - failed on Linux
 next-20241025
Message-ID: <c9980897-7b7a-47ec-a2d3-1410083f4d08@sirena.org.uk>
References: <CA+G9fYt0pqM_f-uiK=xH0RWrhfABdjy743yyxu4CLtb+kkS6-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B2ij6K8NYtCweVVO"
Content-Disposition: inline
In-Reply-To: <CA+G9fYt0pqM_f-uiK=xH0RWrhfABdjy743yyxu4CLtb+kkS6-w@mail.gmail.com>
X-Cookie: Remember the... the... uhh.....


--B2ij6K8NYtCweVVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 01:16:32AM +0530, Naresh Kamboju wrote:
> The following kselftest arm64 and FVP failed with Linux next-20241025 on
>   - Qemu-arm64
>   - FVP
>=20
> running Linux next-20241025 kernel.
>=20
> First seen on next-20241025
>   Good: next-20241024
>   BAD:  next-20241025
>=20
>  kselftest-arm64, FVP
>     * arm64_check_buffer_fill
>     * arm64_check_mmap_options
>     * arm64_check_child_memory
>=20
> Anyone have seen these failures ?

Already reported here:

   https://lore.kernel.org/r/61461dcc-e455-450d-9c01-5465003fc31c@sirena.or=
g.uk

--B2ij6K8NYtCweVVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcf7PcACgkQJNaLcl1U
h9CkLQf9Fc2xP/RalLbR8qhm8sehoQq6vMBzDovEbDMB6k1Tk4MKwpIxpSlQphnI
YbcEVLgQ9G0bbEIqqJWYAJIl5rgoTNvpSe20WctUPjCPD+uz3zMhEScKO7A2/gYH
Jp9y35VbKkfJEIiOfibFMef+o6cYcqQp4XxpDTbrPuIs7I3UsKtlIZKctLJW54ff
93hMnpctARzoMUX5w1ykX4pTPZVc4ovfo7UnyiKvJvq1x7jkR3jk1WuuXzN0w58+
a8bcB6U9qzhs8TDcvkog47kTRWtjDdkYtq3XzMTAg3HCM3vOWMYiTy2iLLvuKEG9
cc/QVGZoz1GuMaZhCDD/lHsDWvT4Jw==
=vRao
-----END PGP SIGNATURE-----

--B2ij6K8NYtCweVVO--

