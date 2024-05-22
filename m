Return-Path: <linux-kselftest+bounces-10578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717D88CC01C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 13:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC6F2812DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 11:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13535824AA;
	Wed, 22 May 2024 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqoFvCWh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44B7BB17;
	Wed, 22 May 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376884; cv=none; b=TvLAslyCFTCo8dvVguiaRJEIkMaLUbHmsQ+gfp7jSUOOSelEHTjHrLUHHBILFwSF8aMj/cyMXdI0WH+hR5BUEwvlpPsQ3QaQrPmxSHkdNHMv971h30AaKMltHiYwrREtYY3AD4rzhLb9SjBBr9UYO15ebhD7ZHV9nqzY2cesFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376884; c=relaxed/simple;
	bh=6LFpisAJ3P2zL/wDbYfaPPwjur7WX2IAIulJ4g4PAAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz5THzjwdF61xfazNIQ31tJw8M5E9l/0U5gw6Xt4p1p96CfOLQDXijUBs/Ur8uMPGSRGZLWT9VJgbmFA4xpiQz0AuyNrKlarpichlDBFrl10+kEMWV5NrN0A2ysLxxy19TQrp7eQ+MLGFiQaFhdimIXrc8ZikNWo4WPixondnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqoFvCWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68AEC2BD11;
	Wed, 22 May 2024 11:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716376883;
	bh=6LFpisAJ3P2zL/wDbYfaPPwjur7WX2IAIulJ4g4PAAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqoFvCWhL06a+t3NwIiHw7f7YkYWr6An8TRv4o2dAlkTeFZh0noWkl8eHYPTJ7/L2
	 TbYkFtaSP/IxDAkggFuA7DKY5bcZ8xT8qT4RVKbVJ9gdUQj9VrIdQqwiwRrEXLsqdA
	 wwyDT+5UTEQj/NZLNW0BfAxrgiC0oXA0JtJYoD5IWAvOZ+Hm7CWjxwkEJtxqrBYgLo
	 nWePa0mTUVjoCIZAWcNj7VvrxBbLdGB0OYgAeCBR/quUErwE7SWWeoscdX0UkNVTGN
	 z6woD/4Ji2GtDcuFgtx1+D7X5zz1NYYsVcAVcd8paZo/ykOopjL94IV7OfzK2D7O37
	 7LyBbaoe1ptyA==
Date: Wed, 22 May 2024 12:21:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 02/68] kselftest: Desecalate reporting of missing
 _GNU_SOURCE
Message-ID: <94b73291-5b8a-480d-942d-cfc72971c2f5@sirena.org.uk>
References: <20240522005913.3540131-1-edliaw@google.com>
 <20240522005913.3540131-3-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WIFHs1Yh6LyJ3Qfq"
Content-Disposition: inline
In-Reply-To: <20240522005913.3540131-3-edliaw@google.com>
X-Cookie: Bridge ahead.  Pay troll.


--WIFHs1Yh6LyJ3Qfq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 12:56:48AM +0000, Edward Liaw wrote:

> to make stopping builds early replace the static_assert() with a
> missing without making the error more severe than it already was.  This
> will be moot once the issue is fixed properly but reduces the disruption
> while that happens.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/kselftest_harness.h | 2 +-

You've not provided a Signed-off-by for this so people can't do anything
with it, please see Documentation/process/submitting-patches.rst for
details on what this is and why it's important.

--WIFHs1Yh6LyJ3Qfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZN1SkACgkQJNaLcl1U
h9ALrgf/W2wyJyKvxhDmFrYgFJhxqTL7kAvJooFztcjGspGzZ11XMWpg5qCx0HHS
CMQ056M6KjXP56PoyIJZUlgKZS/iTbNbN16CdgfzNjmm+bVoyI7RnHG5VU5ynmuC
BgqlUZvPgjjEyxrdq3VZTEnGRMkOhSyGofvXfHkmTyxG6iPMEQP7oBAiYyKitqw1
p16mfKVsFOWMVIa4Pz7N6DrB/DYMdLs+nmaueOfuqShFo4LwGkaP5f0ey5OFLqk4
RSB8dbe74T8sqtlAiC+2eAHk4PIT7tsmiyAK1n80aE2bf+JBR4hWjhrniS1JKSoW
znqrGa5yeQ/laQLifd57Xg0iW8mesw==
=umSn
-----END PGP SIGNATURE-----

--WIFHs1Yh6LyJ3Qfq--

