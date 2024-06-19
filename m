Return-Path: <linux-kselftest+bounces-12259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B7090F519
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 19:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981801C225A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 17:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FF654673;
	Wed, 19 Jun 2024 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/dk1rhZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07901465BD;
	Wed, 19 Jun 2024 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818288; cv=none; b=dC5UwffGDhAEUVBNJyTOyVzRDIpC4srVcJ9xoRxbQh8wnnxP/SCAP9lmOf9Pf8A2cmdOWbJg4/VTjP2sJcbfqMyNyzFbpTVfX9xyouuG3LLDgAj+DTyFurDx5eBjVGnJQapBul1SJfBNST8VyDX6+IdWVi4A6O0qf/JWfxX9HKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818288; c=relaxed/simple;
	bh=bNbJpcBWGT1xRYaIE35wecL9KukS5Hjd/5wYjRFLVDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwgeROUMDX1u6bf+dCCXSe931eE1m1+hSKUKZJYEPyI/E2CxvlSZNbWzwNWh0zot0FYIv5MlVBoKJCFvXFZeEBZSvqjzK82GtkYHvqdz/IgjDtQ0yxvKYIT8sCsnw6ZsqNAiW2MLlGQSZj5KYAO755R1B9aKxKVA78SqL/ajqjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/dk1rhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D67C2BBFC;
	Wed, 19 Jun 2024 17:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818288;
	bh=bNbJpcBWGT1xRYaIE35wecL9KukS5Hjd/5wYjRFLVDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/dk1rhZzghzcx6W6HS5oz93Kqa4dMi2OYt+yM6S0XEkYVXSE4FZ67++6tZx2Xib6
	 mrLh+FWQq1HlVHuVcDGcvjTFjYCaPARhrozQvfYDNCQO+tOJh5CxIihZd58SgSWjm9
	 57hYB+/S0mZ9NAxVOFG02hWPuuI7LRDEjwYco2Iawrafnq2MDYXOROUH3jl/r9bNnM
	 wqaCNfVrKcqxe4r75eWtwhEMkTW9wlMFo0SzkuPCjTipDzNsb4dCcY0a92c+E3VDyP
	 UpEacnPakVuls+rlMulsWZr1FB5junWyt2wjRlNEMd1D516NfWFuPj/TxuAvBdpoHE
	 WLL7Xj+igijfw==
Date: Wed, 19 Jun 2024 18:31:22 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/5] riscv: add parsing for Zaamo and Zalrsc extensions
Message-ID: <20240619-fernlike-pang-b7e589a9c342@spud>
References: <20240619153913.867263-1-cleger@rivosinc.com>
 <20240619153913.867263-3-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iV+yM3vkV0Ir3FfM"
Content-Disposition: inline
In-Reply-To: <20240619153913.867263-3-cleger@rivosinc.com>


--iV+yM3vkV0Ir3FfM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 05:39:09PM +0200, Cl=E9ment L=E9ger wrote:
> These 2 new extensions are actually a subset of the A extension which
> provides atomic memory operations and load-reserved/store-conditional
> instructions.

I wish this silly degree of fragmentation didn't exist.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--iV+yM3vkV0Ir3FfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnMV6gAKCRB4tDGHoIJi
0qAUAQDw/gNvekOwsKBLPCVUvdyo5mT7zMA99GfeGa8SdS1l7AD/TOVlB4vJ/kdJ
lM7BcEX02d9bYhknwsJvyV68q9DzfQI=
=PfOT
-----END PGP SIGNATURE-----

--iV+yM3vkV0Ir3FfM--

