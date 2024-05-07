Return-Path: <linux-kselftest+bounces-9635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17308BEA67
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 19:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C14E28315D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A25916C44E;
	Tue,  7 May 2024 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHpaEv2j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06D21607B3;
	Tue,  7 May 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102490; cv=none; b=GvkdfiMAw4r7OMvYmtFWCCSd+suQmHQpIFsNT9a4PYgo3ArjzapL7oEBWQq2zAevijPQZdMbtN+KzruSGG2PYFXeFNfgxfdw15S7ohnp8Xv5QNCfhFhz8XAtAhdmLqtvhz3qBGv3UfOKnTqxSAdT0kZDY5NlevcU/1to8EREcYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102490; c=relaxed/simple;
	bh=IDMR67aL+FJpg70JOZa/YqXPWKIXWABsZiy55mqfzgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcYt4MjxOk/FMEWAlX+pPPsDZ2gba1aL5LiIIsExwoRJLR82nHHZgg0Lis0gao+Se6TyOfuUKtq08BX7vgc0y3hL11fz69JgDgPH1frnQGiXUxnRlRerDI5YDYt+cj1oonQpcEkLoxjdLUMCUiLQPN//q1WwJpBefq+V3GmiTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHpaEv2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75529C4AF66;
	Tue,  7 May 2024 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715102490;
	bh=IDMR67aL+FJpg70JOZa/YqXPWKIXWABsZiy55mqfzgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHpaEv2jt8RdYDITiy9cW34apA5GulWZo2VGWPOY6kGTB/MLm0oZRf9vNRf+yh1t0
	 nnLFMUAroOpck8gryD83BDIOqV5B1JNQSOHDEgBHku2e0v6SzhePDRTyap9EHC0c0t
	 GLri1U62zVHUBw5Pk+C1zOD3GHkzQWJ63cFDa6XaovjXV/JtqfJCFND6TXfwjy//iX
	 NnB/0+FdFpHCosbJlZsey2qMVPWvlegX/tZ/k9kWNqjSZAbrOQzZ2UMJyxvM4iGfV5
	 LgZ7lVefiDXtvO/aRum2TckSTKmJkPwiSjVXVKOaNrjhjkbeEo/bfNLouO1uapMu4q
	 iSiielqQjuNmw==
Date: Tue, 7 May 2024 18:21:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>, Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v6 00/17] riscv: Support vendor extensions and
 xtheadvector
Message-ID: <20240507-rising-ricotta-1be648c095ed@spud>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vh6wbBhSwXsR2Sa9"
Content-Disposition: inline
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>


--vh6wbBhSwXsR2Sa9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2024 at 11:18:15AM -0700, Charlie Jenkins wrote:
> This patch series ended up much larger than expected, please bear with
> me! The goal here is to support vendor extensions, starting at probing
> the device tree and ending with reporting to userspace.

I think I've reviewed all the bits I care about, so thanks for all of
your updates. It'd be nice if Andy could look at the actual vector parts
of it, so I'm adding him to CC.

Cheers,
Conor.


--vh6wbBhSwXsR2Sa9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjpjEwAKCRB4tDGHoIJi
0szIAQDf5iSG/bM8HfBvrIsA44lVF79BoLK1Zcf3ndnVkXn1hQEA42EjkAPJta9g
WY59vTOFOsAcXRSCDp9JbTmwIoNyvwM=
=UC2O
-----END PGP SIGNATURE-----

--vh6wbBhSwXsR2Sa9--

