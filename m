Return-Path: <linux-kselftest+bounces-21891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BF59C641C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 23:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FB83B632CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 18:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99392144DF;
	Tue, 12 Nov 2024 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLOottUA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8E214431;
	Tue, 12 Nov 2024 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434638; cv=none; b=ZqbmSJdQgCEoa2jsg8sMiYctpvY6rUko9XAayPa9DODuYu0pbQZx2H9eHBnXhZ3x9N4qhfNf9RCuv0FGXXFUMTky17g08ABs37WOeSBx6XAAbz0Fqsmlm/48XtpiN2BPQbr8mfPjpgc+jetcPvMrVW7YU2o9lAKJApHRIpQ9ju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434638; c=relaxed/simple;
	bh=kqF92FnpSa2OXbqzYAFWSrZYSfupDZ8zTDehmduwQM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ece+b9jv7dgRW3NJ9NrVwY0y3ZysVQmcOD2uGqVgpTRYa7Jctgveurj4fMbnOBgvi6kGKi/H+8S1k+Wz1R0Xr5nXfAJa4R57eJg3XEIK96rVx3e/Pt7SS5NFEWW6PDJGEzGJMEvV2Cfg7YSOG9l6exgF6/XsaSs1+hd8euhzzU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLOottUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD84CC4CECD;
	Tue, 12 Nov 2024 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731434638;
	bh=kqF92FnpSa2OXbqzYAFWSrZYSfupDZ8zTDehmduwQM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLOottUAHgXyuaS5FZ7OFzdzu2OTg/oAzzpsqUYRe679Go3sEJL3g7LL3TvuXKQuk
	 kJLtqwgjzF4IRoHXQ/ovpRcMp9KVydXxhdY+BDVMmeAUTwui5EJbJh+73Q9Dk/bSsT
	 L3K5KjlKOKuIXuyz1MsPurXFFMgUBf0liqQJjIf4FpHhxhw+Tq6XoerTiuWe59eA7b
	 7aNPWrwpUH9saLrfUwsTao0yghQeqUECpbPEDYKdUKDkxj8J2lKO4knfMx1mIv7Fg3
	 BuGXXqqCkzwQI3PqJ/NXxmQu9skJgUekwOpP/ePQyLJiTqmtxXjwe96kUeZAhD3O+R
	 8Z2SQdJHdisEw==
Date: Tue, 12 Nov 2024 18:03:51 +0000
From: Conor Dooley <conor@kernel.org>
To: h1k0n <ybzjyhk@gmail.com>
Cc: charlie@rivosinc.com, ajones@ventanamicro.com, andy.chiu@sifive.com,
	aou@eecs.berkeley.edu, conor.dooley@microchip.com, corbet@lwn.net,
	devicetree@vger.kernel.org, evan@rivosinc.com, guoren@kernel.org,
	jernej.skrabec@gmail.com, jrtc27@jrtc27.com, jszhang@kernel.org,
	krzk+dt@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
	palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org,
	samuel.holland@sifive.com, samuel@sholland.org, shuah@kernel.org,
	wens@csie.org
Subject: Re: D1 vlenb
Message-ID: <20241112-blooming-reheat-d9a23401f6d6@spud>
References: <20240911-xtheadvector-v10-3-8d3930091246@rivosinc.com>
 <20241112021227.357-1-ybzjyhk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3sbg3BDZLVHaW7eG"
Content-Disposition: inline
In-Reply-To: <20241112021227.357-1-ybzjyhk@gmail.com>


--3sbg3BDZLVHaW7eG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2024 at 10:12:26AM +0800, h1k0n wrote:

This message is entirely empty FYI

--3sbg3BDZLVHaW7eG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzOYhwAKCRB4tDGHoIJi
0hjfAQCqq2U6n0j4CEI1t2O0Z7i8ABrvQx9u4Yq+TaBYhwtgLAEArAZcyVMA30do
BQbGW+93CZzpOrFMDM6b5Zs06UPQUgE=
=yLsb
-----END PGP SIGNATURE-----

--3sbg3BDZLVHaW7eG--

