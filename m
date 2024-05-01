Return-Path: <linux-kselftest+bounces-9190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92548B891F
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 13:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3241F22B44
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE357318;
	Wed,  1 May 2024 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1GBh8g1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22956B63;
	Wed,  1 May 2024 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714562382; cv=none; b=t7CUtKKlXNBhNYmkLSlDkg61GlD5YorA2/b+6mP3rnPpnCPatbgu2BZbIWkG+NybqMOzC9VrE3z6tCUnNWm8IClBDZnjGkPqrDIJKxq3avx7z0HltR8Wn+ErDMdwQqqSjtTpJ/i2mrtOX+rYvmmdusFXilQtC5+Dx87a5Z32ZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714562382; c=relaxed/simple;
	bh=NdA764WJcGvt8lXly8jeVIEutQMXNgk81JN1Ta7vWVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTobHv7krHL4IgXAorK98I/fq4rOC7gkVISaSelsjLXvoCt9TEX8jqlpvppeAqQD+e5xtX4mIYTRXOV8qB1yDq7eCjCyBFxa8Ed0RBAQkYCuvS3qTLTDw/rBP4l5qfsKPuF02XefkTpaids+yIKCgWgtDgRdkQwyYwW2DecfoHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1GBh8g1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7021C113CC;
	Wed,  1 May 2024 11:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714562381;
	bh=NdA764WJcGvt8lXly8jeVIEutQMXNgk81JN1Ta7vWVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1GBh8g178zlWYlSPyVe2IH0YcLY8mAJwRU9UH6hXxlYt1gtua7k+rREM54kTau8v
	 Y7H5zBcJuIl+SZda1BS1vSVtZAvg3vHs7pYF6qdrJGk5t2JULK+jPJSDUbfF/lFJnH
	 mMet8WFbpQw6okf2wyuvVSnse3Sy2Je/ak+0cQNHc1F2ZLmFtcIkEnjQMc3awKM1RT
	 oo9KexsvtcE8/ZSxRErW4WHCu/GL31Ut8GKqV/Ce4A1OlM4v/AttF/xsFREivm2Y6/
	 d2oip2TN9cSMH8U+W9EJskrejkG8sx4vcgkggrLIEBTr5l8AiJx7BN4XblhE8sNr8g
	 yR40X/LPEX0Ig==
Date: Wed, 1 May 2024 12:19:34 +0100
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
Subject: Re: [PATCH v4 05/16] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <20240501-pelican-throwaway-da84be7dac30@spud>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p3ofyY8PZFrt+4od"
Content-Disposition: inline
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>


--p3ofyY8PZFrt+4od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 02:29:19PM -0700, Charlie Jenkins wrote:
> @@ -353,6 +336,10 @@ static void __init riscv_parse_isa_string(unsigned l=
ong *this_hwcap, struct risc
>  		bool ext_long =3D false, ext_err =3D false;
> =20
>  		switch (*ext) {
> +		case 'x':
> +		case 'X':
> +			pr_warn_once("Vendor extensions are ignored in riscv,isa. Use riscv,i=
sa-extensions instead.");
> +			continue;

Yeah, so this is not right - you need to find the end of the extension
before containing - for example if I had a system with
rv64imafdcxconorkwe, you get something like:
[    0.000000] CPU with hartid=3D0 is not available
[    0.000000] Falling back to deprecated "riscv,isa"
[    0.000000] Vendor extensions are ignored in riscv,isa. Use riscv,isa-ex=
tensions instead.
[    0.000000] riscv: base ISA extensions acdefikmnorw
[    0.000000] riscv: ELF capabilities acdfim

kwe are all pretty safe letters, but suppose one was a v..
I think you can just yoink the code from the s/z case:

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 20bc9ba6b7a2..4daedba7961f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -338,8 +338,19 @@ static void __init riscv_parse_isa_string(unsigned lon=
g *this_hwcap, struct risc
 		switch (*ext) {
 		case 'x':
 		case 'X':
-			pr_warn_once("Vendor extensions are ignored in riscv,isa. Use riscv,isa=
-extensions instead.");
-			continue;
+			if (acpi_disabled)
+				pr_warn_once("Vendor extensions are ignored in riscv,isa. Use riscv,is=
a-extensions instead.");
+			/*
+			 * To skip an extension, we find its end.
+			 * As multi-letter extensions must be split from other multi-letter
+			 * extensions with an "_", the end of a multi-letter extension will
+			 * either be the null character or the "_" at the start of the next
+			 * multi-letter extension.
+			 */
+			for (; *isa && *isa !=3D '_'; ++isa)
+				;
+			ext_err =3D true;
+			break;
 		case 's':
 			/*
 			 * Workaround for invalid single-letter 's' & 'u' (QEMU).

You'll note that I made the dt property error dt only, this function
gets called for ACPI too. I think the skip is pretty safe there though
at the moment, we've not established any meanings yet for vendor stuff
on ACPI.
I think breaking is probably better than using continue - we get the _
skip from outside the switch statement out of that. And ye, I am lazy
so I kept it as a for loop.

Cheers,
Conor.

--p3ofyY8PZFrt+4od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjIlRgAKCRB4tDGHoIJi
0ugAAPoDPa6ArkzDoKOdltjV690jUcxJanZcOTddmqK/7OVlEQEAxQBqLmw0FIrU
vufC89X3QQxXx0ONQsmNnf3NeXJ//QU=
=Ec6E
-----END PGP SIGNATURE-----

--p3ofyY8PZFrt+4od--

