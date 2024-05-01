Return-Path: <linux-kselftest+bounces-9195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB398B895B
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 13:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB791C22F66
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049037710B;
	Wed,  1 May 2024 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2BuQ5e0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322051005;
	Wed,  1 May 2024 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563519; cv=none; b=V1x4go22hLi41FcuEFdWcVshOVAYZod06kDHgBU8tnWc5Mr+b6jIrBW9fs/kHkoSGyGYKmgOW8Bfq4+BWNcyHH3w76N3CbtRHleyzd91RJ4ZKD61zWH76ifKlax7f3nAVH82jN1eKgcDmb8OSvYgQvC/hwa0NVskeQ8xV+yxdzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563519; c=relaxed/simple;
	bh=/55ONdJEW2X9oAD5btDemF//yv3ORl2OA+oFizHG6JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SN5sYWjcVCmSNqG/w+avYnB1OyVIpocvHLSSU/ke23SZflbC++PLhFvdqK5tsADif9wyMf6IdIIbPGrH18hRaNXnBfAAUXhnrdfVM5isEDp8PM212cQuVAPGl6cNKx77oNKXPC5/HPi2Xjv1iiT+G0FWeCWat5VZhEr2xrIcl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2BuQ5e0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90A0C113CC;
	Wed,  1 May 2024 11:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714563519;
	bh=/55ONdJEW2X9oAD5btDemF//yv3ORl2OA+oFizHG6JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2BuQ5e0a9DNCCo7tCuthfljUqfNLkwUuryqnm5IHklymdW/O2lg27ffqur72AwGL
	 6lEnMwE2Zz+uQOdE9Jjz1wCVBu/gM7yXU2Gs7uXtsd0BGmi6n5fHXgnDcHZycOmwg4
	 iyHn8HcHUtsPtAoCcMT+n+/OHC1pyK83mQMJQYLlj9PnsCNoXB2aMTOjVex0Sy39aN
	 tSRyUMCcCFEyjNO8q7N6MW8Zst4EBw4LJ96OR2ASLglldzHrpwbBdZKTLZjdbnrXao
	 9wPulaWHo6iGAgJXCAg7NeUH3b0WNzk6jW0/Kg/27SYF8Vi3lrqioebfEvQ3gYRpmG
	 G7ASKIWm1GKHA==
Date: Wed, 1 May 2024 12:38:32 +0100
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
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 08/16] riscv: Convert xandespmu to use the vendor
 extension framework
Message-ID: <20240501-delay-ferret-e026ef351cf3@spud>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-8-b692f3c516ec@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ocThCKwZewsPkwD9"
Content-Disposition: inline
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-8-b692f3c516ec@rivosinc.com>


--ocThCKwZewsPkwD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2024 at 02:29:22PM -0700, Charlie Jenkins wrote:
> Migrate xandespmu out of riscv_isa_ext and into a new Andes-specific
> vendor namespace.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--ocThCKwZewsPkwD9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjIpuAAKCRB4tDGHoIJi
0oyTAQCiGsBokvzqKTzrHPoRR7fnwiqQeIuvwafaOFH8XRia6QD9HWIP9f2o2O5W
1rqoWHA0c7U10muh1gRmeqbHG3IRoQI=
=shDB
-----END PGP SIGNATURE-----

--ocThCKwZewsPkwD9--

