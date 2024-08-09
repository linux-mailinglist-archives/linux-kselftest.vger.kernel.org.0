Return-Path: <linux-kselftest+bounces-15096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D558F94D8C0
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 00:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E433281783
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 22:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E0916728B;
	Fri,  9 Aug 2024 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdfNHUFS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6BC8D1;
	Fri,  9 Aug 2024 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242683; cv=none; b=JZTG/exRkOu0hAcOTgYIQPp2bHuw+SHlzH7zNAySKSgE7ZrPEeSE0PB3QphJCucP0xkcUi/neiRFDZdvVbhhmvlgGfRRUTcwpbLmNUBRbKvvGX1u3NMl79l5gfdwZnnso49BOCROqrQpauZipKZrF4pIJ+f2n45hO91eb0JJcN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242683; c=relaxed/simple;
	bh=ST2yZJ1z3NPLh4z1Z9oZd5wDiM05Ls+yHvSmTrATXTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAnXjmF5LNwXE7YdYLaY3BWD4El+SOuFzhkasv2P0557ram4o9VZ+Wv9U7ohPjcbc961AU7KvLlQhiBOgP0GV1huva0wAlU8O9u7CQHykRH8IgEz9WWW/W97anzfZ3q10/qbMH/cMoUyPFzyDdBuInjKvvYamufs+SDW0i7s4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdfNHUFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7583BC32782;
	Fri,  9 Aug 2024 22:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723242682;
	bh=ST2yZJ1z3NPLh4z1Z9oZd5wDiM05Ls+yHvSmTrATXTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IdfNHUFSCvgO3CKBq6FBAR2WeVIHxj1nhcVXFpM90cS4e3R4lvmJlY0jAlCdyiao7
	 bTvJg/0lzSHLV2vMiVmamYiBijYQA7Pk2WZwG1Oz99TlRYq9G0qi36ZCnWiBELc8Yk
	 GfwK3agTSeyPYjBV0GypsBfN0gzSVGty7jXfSJzACMBD9gTH0M3QegApEtBVPfkeux
	 ELsWhY/ZLNszj9JXhqp/fWzZ4s8WZOi84U2YqzhC8CkAd4vT5rzdhPbDvI2X1azdyS
	 PC+9Lmwr28VwuRYElgTjS2Anp0/hkhMnQK7CtWsea9xdVT0ZwIV1fR9oepAD0hYJq3
	 lvy0RwPbyqe6w==
Date: Fri, 9 Aug 2024 23:31:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v9 00/13] riscv: Add support for xtheadvector
Message-ID: <20240809-slapping-graph-461287bac506@spud>
References: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UxYzrmqfRoz1zos6"
Content-Disposition: inline
In-Reply-To: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>


--UxYzrmqfRoz1zos6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 05:31:36PM -0700, Charlie Jenkins wrote:
> xtheadvector is a custom extension that is based upon riscv vector
> version 0.7.1 [1]. All of the vector routines have been modified to
> support this alternative vector version based upon whether xtheadvector
> was determined to be supported at boot.
>=20
> vlenb is not supported on the existing xtheadvector hardware, so a
> devicetree property thead,vlenb is added to provide the vlenb to Linux.
>=20
> There is a new hwprobe key RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 that is
> used to request which thead vendor extensions are supported on the
> current platform. This allows future vendors to allocate hwprobe keys
> for their vendor.
>=20
> Support for xtheadvector is also added to the vector kselftests.

So uh, since noone seems to have brought it up, in the light of the issues
with thead's vector implementation, (https://ghostwriteattack.com/) do we
want to enable it at all?

--UxYzrmqfRoz1zos6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZraYswAKCRB4tDGHoIJi
0tonAQDXX0xZWgDaeNkL+G/im0IoleTzmXCNVYAibHmhnDOBLQEAu5Jwr4Jh84y8
So09QD8P3MlYkua1tqt96HA8i7/76ws=
=PJBU
-----END PGP SIGNATURE-----

--UxYzrmqfRoz1zos6--

