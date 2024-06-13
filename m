Return-Path: <linux-kselftest+bounces-11865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B94B0907576
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 16:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627671F23135
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736E14601C;
	Thu, 13 Jun 2024 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvNk+DeK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0A145A12;
	Thu, 13 Jun 2024 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289662; cv=none; b=ZSCdmdNN2JxfzP+hDDZ4PDqd1BVFFEV9wgTJpR03fn5FSe7LFrvm5eVlOtHdbgrG4c3IGAmZULDVG3WNasg57mO3eZTb+Ga4+EWfTweQjKZ4/3sFW56+vYx4OU5VmfgPV9hFOx3WRClLMcK7uEhlQFg9PkwdaRbEUEizedc+I8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289662; c=relaxed/simple;
	bh=QudiikszfuUSRm1JTVmyxQn35gCQ8PIjI8z2PL0Fa5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqxjyt5aOGXf4Nkf22zYxjIEjPlSgCzDF+OzAldg6Vq3nBlpqn5cNrahzXmc58RnT+rdqqOrlC0NpfLLmZLJ599cTj89JNHwkz/NkysH5LcmHN6jlSQND5BKm4SdYMq+zDZXT6i5Sdy6lYIEuzcPMdkjY7yG+VJoaleb9EXBzNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvNk+DeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BFEC2BBFC;
	Thu, 13 Jun 2024 14:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289662;
	bh=QudiikszfuUSRm1JTVmyxQn35gCQ8PIjI8z2PL0Fa5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvNk+DeKUwohEXf2HcghJVK2ISwGC59Kg2oUR4L6l2e34a/gOul8aSiTPUqfoAgFW
	 f8apKbdebeXia2nTHIAgeqQldDjToUDPysl5NEr0d3VTNCcFu5mp0A5rFo8Gn/GoaM
	 nVDG9tRVhcn8fn//ryWad9iYqNZBwJpRtSL1udNk7ii0tMocXltDecJXku6yaoS1Cg
	 /Bl7HfJENXroP0zuSjzEBE7iYKPVCMmUI7srqojPT05SiDrGRz7Pn7uMYQwlRPOZbx
	 vIp0TDf9Vw3Z8NpEzrjqKNGmq9Dsv7J3UBRT/atm9bPaE1QJTljvaYy9yrlYLTDrF0
	 6Dka+8PRkVCdQ==
Date: Thu, 13 Jun 2024 15:40:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 04/13] riscv: Add thead and xtheadvector as a vendor
 extension
Message-ID: <20240613-cofounder-curator-81e53a35dcbc@spud>
References: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
 <20240610-xtheadvector-v2-4-97a48613ad64@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aZez57M5EwwC5uBl"
Content-Disposition: inline
In-Reply-To: <20240610-xtheadvector-v2-4-97a48613ad64@rivosinc.com>


--aZez57M5EwwC5uBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 03:56:41PM -0700, Charlie Jenkins wrote:
> Add support to the kernel for THead vendor extensions with the target of
> the new extension xtheadvector.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--aZez57M5EwwC5uBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmsE9wAKCRB4tDGHoIJi
0sX3AQCV0JAgjlWHnjFIW32EH6kLNRxnf0K4C7KXnfzG3XGQOQEAp2wE6MnRyV//
+GtJNdRRVkKDTjAnuHMpsdBXy6n+kQQ=
=VC5A
-----END PGP SIGNATURE-----

--aZez57M5EwwC5uBl--

