Return-Path: <linux-kselftest+bounces-9194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255DB8B8955
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 13:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91701F23E63
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 11:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA93584D09;
	Wed,  1 May 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beA3KVgr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8937983CDF;
	Wed,  1 May 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563441; cv=none; b=XQN0VuqoV3Py/vnRkUKuv5y+LQre031YlqGIRhhBatRrSLYb5BETMC5+cECZDGV0qGQcZBQsGiIPMldfCHJghAyxIbthV2vSGQSTf6A+wz6jA1XWLeNaRw8kVWIwUjXhoJZEsiHIQ/KllfagfYpKVB1QbStDuyyDu+e0FnmZ7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563441; c=relaxed/simple;
	bh=MP62atQMR9QZoG0+ZlmS5Hnq2cah7KkCkJlRp2jaF4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4UMUTh7RZZz7tqbAqFcCqwzVPLC2IzmVg1SF6qXDa2go3OhOizeMkyrZY3tfWj5XDBNEb1gN/w1uHsQb5gQhqlTZyojH2zSGncMspCZV9ZzsTz4WfLn+4VRo7EQSNKXeoaRejE5x8Oa0Oa9C/+nCImwkHmbVFwrS5yMuceaRhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beA3KVgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDF8C32789;
	Wed,  1 May 2024 11:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714563441;
	bh=MP62atQMR9QZoG0+ZlmS5Hnq2cah7KkCkJlRp2jaF4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=beA3KVgrsWenCerL/qvg7nGJ1js6iXuqGs3AptzAocKB/boxOcYGnp3XkmaF/2oAO
	 oX/IKgwc3iepDK0HUg4Io2c4i03pdfDpZgk1kcov4Ai/aBxurHiyiAX6HmVvpU/2SO
	 NUgp2LZev45f9DvID3VJ/ctqV7scYd+UBaa9jEA43ipsr+v4I9z5uvqE1vmo0LXCpJ
	 qbaaeWs//uQyrcYV7j53qJtIC7z+cFGAY0qdpMGpg3dAbcmAZGjn0tM0K556QYzqkQ
	 0hJcGqFhq9jdyXi0dahmnkLEGQ+9rxMrR1yFQRySAqIuiMalxkuwm595dFktELebK8
	 aVetVR6dPCr+Q==
Date: Wed, 1 May 2024 12:37:14 +0100
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
Subject: Re: [PATCH v4 07/16] riscv: cpufeature: Extract common elements from
 extension checking
Message-ID: <20240501-probable-unfunded-746ef6ae1853@spud>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-7-b692f3c516ec@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4cVAmCcvx4abtooG"
Content-Disposition: inline
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-7-b692f3c516ec@rivosinc.com>


--4cVAmCcvx4abtooG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 02:29:21PM -0700, Charlie Jenkins wrote:
> The __riscv_has_extension_likely() and __riscv_has_extension_unlikely()
> functions from the vendor_extensions.h can be used to simplify the
> standard extension checking code as well. Migrate those functions to
> cpufeature.h and reorganize the code in the file to use the functions.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h        | 78 +++++++++++++++++-------=
------
>  arch/riscv/include/asm/vendor_extensions.h | 28 -----------
>  2 files changed, 44 insertions(+), 62 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index fedd479ccfd1..17896ec9ec11 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -98,59 +98,66 @@ extern bool riscv_isa_fallback;
> =20
>  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
> =20
> +#define EXT_ALL_VENDORS		0

It's not really "all vendors", it's standard. Otherwise, this seems all
grand to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--4cVAmCcvx4abtooG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjIpagAKCRB4tDGHoIJi
0nqbAQDotPME6y45R4f68eXuCnbyY4XAOyDUzD3fL8AW4YgGDAD/VCUttdmY/5WW
rxMqmWx1QCw9yGME4Abt8BHVFnG4ZgI=
=cdZM
-----END PGP SIGNATURE-----

--4cVAmCcvx4abtooG--

