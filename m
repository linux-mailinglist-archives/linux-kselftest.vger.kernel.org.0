Return-Path: <linux-kselftest+bounces-9628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE2F8BEA43
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 19:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA484B26208
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 17:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D2E54BD7;
	Tue,  7 May 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdK4PMDE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108138F72;
	Tue,  7 May 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101406; cv=none; b=enNs/rgcs9fhOYbzgaG3skxyzrIyr81XcgUQLFwAR4A/GXBDY/qbFL5BfGsGTZbivSLqrnYhYKox3d0SDtfOTeT9OijPqFdYw+vWaCyWo/kxAiLaMSQt1g+l/28d20RN7xoK/GQvsZ1tGZ468vOUUy+4rg6Mawqz0gVzw0+rYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101406; c=relaxed/simple;
	bh=ArnZiiYUYEC1mlgNlltHqQrIthtsLHuxUJszJP2E6B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEm0Q2xKdntd7UM+j+XXET8Zq2/94n5VFyYOCJ4j/9iCdKeSIKyw1HNWukJ3QaWXtk+OpTBHW/5D214VJ+6wqBMJupcMH4ZqTrhOhAAqQG+J6NcF22npOdYjFQ6nkCPQfqY4WOVHPEqL3exhe13lGoSSTILajV5bbZ+kA6F892g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdK4PMDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21011C4AF18;
	Tue,  7 May 2024 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715101405;
	bh=ArnZiiYUYEC1mlgNlltHqQrIthtsLHuxUJszJP2E6B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdK4PMDEapvW9NTJXzT+WrquyPt48Xws4KlkNo6FE7oktoOyUznLn8rIfaY6gM5Py
	 Ai35goUtcDFnF1eqKMnmFSxGY1D73HWtQGjNE8sykSzf0CZi28QTnln4GQgINr0NNn
	 MVVU89di3/rcQCu3cNK0iN0vLEvN54C17y6RYuIy06eftd4Pl771u4fatHSH/Scdcl
	 z+F3JNuaby4oqQCcoGC/zcW8bsYatn7vphQQFiGJC9GU7PJN9kjk/4mj1flIUqMZWn
	 5tX8+QDQSmk0TREMTmvmgCun34E0SCm65hXXDVQIn2W/KQeDcpJRUO4mlFGbAt8v63
	 FuDt59RvNRyOw==
Date: Tue, 7 May 2024 18:03:19 +0100
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
Subject: Re: [PATCH v6 06/17] riscv: Add vendor extensions to /proc/cpuinfo
Message-ID: <20240507-divisive-swoop-c2737a2d9a9f@spud>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-6-cb7624e65d82@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DjOV1yEKcl4Dfmqk"
Content-Disposition: inline
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-6-cb7624e65d82@rivosinc.com>


--DjOV1yEKcl4Dfmqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 11:18:21AM -0700, Charlie Jenkins wrote:
> All of the supported vendor extensions that have been listed in
> riscv_isa_vendor_ext_list can be exported through /proc/cpuinfo.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

This seems fine, thanks for updating this interface :)

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--DjOV1yEKcl4Dfmqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjpe1gAKCRB4tDGHoIJi
0gm2AQCLHpjv3WhE7hyAxrtcfZiN9zHtIaysFDZBciMppAkHSwD/YTCG+52INlpy
VoV7MjpQnmLGSVLjs8FDGFXVJUEjfQI=
=g03H
-----END PGP SIGNATURE-----

--DjOV1yEKcl4Dfmqk--

