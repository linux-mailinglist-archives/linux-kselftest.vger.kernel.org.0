Return-Path: <linux-kselftest+bounces-8252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174D88A840F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 15:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C30DB253A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 13:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EBB13D60E;
	Wed, 17 Apr 2024 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqLKBuk1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703B13C9AD;
	Wed, 17 Apr 2024 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359835; cv=none; b=czmQyiN4YNlIXR9QYP+cHsHCqJHBLI71203R25DeqwL1ZzilRejrIyCPg3lRtFMpsW7mxTgzBvLCtTU53pcvBo2Nv3L1fTSh40jox2v6QEzjwO64isYMb8N3GTLPqfd9Fdc58CK8b0ZvrOAB0bFujtHuuEPJBJanN9XsdBSr9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359835; c=relaxed/simple;
	bh=alhGN+BKV7wgbVup4sXt3hrvumvenMTPAR+TvP2En3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI5QAsARPPV0bN4BfxuYZTjmlYUMzFOLIeLGd5awA/KKALvZmuCFh4+9AkEfjVFjCa4CsDYvgRG6SbUtHiPbarmY1dgWNvxXQBzTQ0iRuiJipNapx46odEqtj4IPpNjmh2JEQa1HZ1yj9WFn8XEG9JMybAsOJFLaucuEzoeP4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqLKBuk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E54BC072AA;
	Wed, 17 Apr 2024 13:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713359834;
	bh=alhGN+BKV7wgbVup4sXt3hrvumvenMTPAR+TvP2En3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqLKBuk1m5MKL9KVN45H3pwRnjDOdWra/5JlEDljYsjkHbjtEluLcRSZBvoTD4uG5
	 yqoGOZx3DST5aACiilAzj5Ee05RFDVT0orpP3CQDULHkWy/EJkytIowN71HyADeZyX
	 2ozOcx2clYuILK7rSdtJ8mFAo4ZyyL9LsFG4/gGPZdNVnEhSdG2n/bkZ7khozcTb9x
	 ts0aVnzhznRHNSuoxk48yCiB1y8DEOnN1t8VldlHNMk1wzwJRhZri6sw5mNlcEhR3E
	 unRMZMrSMeEt6G+OSSmOnGFKgDQhwi+EcxX5QhwO4RMbJ1x8wpCnHzvg0XacSVmIWH
	 rs08zpsoxouUw==
Date: Wed, 17 Apr 2024 14:17:08 +0100
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
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 00/17] riscv: Support vendor extensions and
 xtheadvector
Message-ID: <20240417-rubdown-ferment-c07abead4edc@spud>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YH2gLI+t3mGjNp/D"
Content-Disposition: inline
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>


--YH2gLI+t3mGjNp/D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2024 at 09:11:57PM -0700, Charlie Jenkins wrote:
> This patch series ended up much larger than expected, please bear with
> me! The goal here is to support vendor extensions, starting at probing
> the device tree and ending with reporting to userspace.

btw, patches 7 to 13 (inclusive) have compilation issues, eg:
  ../arch/riscv/kernel/sys_hwprobe.c:16:10: fatal error: 'asm/vendor/thead.h' file not found


--YH2gLI+t3mGjNp/D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh/L1AAKCRB4tDGHoIJi
0siXAQDBDEKygyQs+AVjskeLlKrUS4PfJcdGnHVWOEesZlMVawEAx9vUmP2ewJ52
ZeM2jwhjqH1xTmob4w9HdNOB+io3vgM=
=p6Hb
-----END PGP SIGNATURE-----

--YH2gLI+t3mGjNp/D--

