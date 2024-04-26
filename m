Return-Path: <linux-kselftest+bounces-8927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C808B3CBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 18:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F601F22D09
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F533155A56;
	Fri, 26 Apr 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrysoNhZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD2E1DFED;
	Fri, 26 Apr 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148727; cv=none; b=nyr7EuHB5Cep3knjhPyXp7OGH4miYGBk7JsvzNIxi9j2gEd5a3iru56xXpGhwCF8/FIp92zFUwNnlm+zACChYrdLmNHtyQfRnLQIsmwK+zTElNzol/4aUlTPgaUZv6EBWwp4BCqF+CNQlWBSCUTTiE6ZBGuVoPX5uU16f93QEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148727; c=relaxed/simple;
	bh=115os4ZbmsDyr8IcVI++ZT4rfl/lG18N3YGeEEwRbs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwL90AxiWVOwbYq5V2bEe0FOzG0wAvCi4fR0eNjJ/taCDMmh8ulhPvvZwC9O9JZjjjCE34Ty+74xchF48zf+uF6WVTWKHGol26hb2U/GxYu21uhWbU7kaHYw7PKrMgtAle3lkZ7gohV5VvsQXJ12KOnTnDvpartVlXZH7wVQy+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrysoNhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673CCC113CD;
	Fri, 26 Apr 2024 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714148726;
	bh=115os4ZbmsDyr8IcVI++ZT4rfl/lG18N3YGeEEwRbs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrysoNhZl/2rj5EmyPUxvne4oOcCBvgT7FwXv0B4qEZLA2jUuBiMT+Pr00XjxUudr
	 F73EfI2exm1yIlq/9kiwYzitcBk7FA3SkwYa2biMKrRLz2jye0hyB9NYWeRpCYleRh
	 7GgXwMDopM+45H9xSM766w80njApyOPHcaI0cHzOShkgg3VlHCxI3FhBNJOovBhe5T
	 p9A0WrvyAlgEFfURIKB8i21Dp5vQInsmtbx5lL85VD9p1B18Gr8aJ38hhZRA0PAbcs
	 rHk6vG45aPqXMmgHMq2QPlbfRr35oW4Yyjz8iUe2m4aSNwzMQOKtoQZkg51qF6vK7B
	 rW4xYAn2q2gVA==
Date: Fri, 26 Apr 2024 17:25:20 +0100
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
Subject: Re: [PATCH v3 09/17] riscv: drivers: Convert xandespmu to use the
 vendor extension framework
Message-ID: <20240426-venue-maximum-f78ac451b146@spud>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
 <20240420-dev-charlie-support_thead_vector_6_9-v3-9-67cff4271d1d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yY5dZCAicSqxniow"
Content-Disposition: inline
In-Reply-To: <20240420-dev-charlie-support_thead_vector_6_9-v3-9-67cff4271d1d@rivosinc.com>


--yY5dZCAicSqxniow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 06:04:41PM -0700, Charlie Jenkins wrote:
> Migrate xandespmu out of riscv_isa_ext and into a new Andes-specific
> vendor namespace.
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 8cbe6e5f9c39..84760ce61e03 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -24,6 +24,8 @@
>  #include <asm/errata_list.h>
>  #include <asm/sbi.h>
>  #include <asm/cpufeature.h>
> +#include <asm/vendorid_list.h>
> +#include <asm/vendor_extensions/andes.h>
> =20
>  #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
>  asm volatile(ALTERNATIVE_2(						\
> @@ -32,7 +34,7 @@ asm volatile(ALTERNATIVE_2(						\
>  		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
>  		CONFIG_ERRATA_THEAD_PMU,				\
>  	"csrr %0, " __stringify(ANDES_CSR_SCOUNTEROF),			\
> -		0, RISCV_ISA_EXT_XANDESPMU,				\
> +		ANDES_VENDOR_ID, RISCV_ISA_VENDOR_EXT_XANDESPMU,	\
>  		CONFIG_ANDES_CUSTOM_PMU)				\
>  	: "=3Dr" (__ovl) :						\
>  	: "memory")
> @@ -41,7 +43,7 @@ asm volatile(ALTERNATIVE_2(						\
>  asm volatile(ALTERNATIVE(						\
>  	"csrc " __stringify(CSR_IP) ", %0\n\t",				\
>  	"csrc " __stringify(ANDES_CSR_SLIP) ", %0\n\t",			\
> -		0, RISCV_ISA_EXT_XANDESPMU,				\
> +		ANDES_VENDOR_ID, RISCV_ISA_VENDOR_EXT_XANDESPMU,	\
>  		CONFIG_ANDES_CUSTOM_PMU)				\
>  	: : "r"(__irq_mask)						\
>  	: "memory")
> @@ -837,7 +839,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, =
struct platform_device *pde
>  		   riscv_cached_mimpid(0) =3D=3D 0) {
>  		riscv_pmu_irq_num =3D THEAD_C9XX_RV_IRQ_PMU;
>  		riscv_pmu_use_irq =3D true;
> -	} else if (riscv_isa_extension_available(NULL, XANDESPMU) &&
> +	} else if (riscv_isa_vendor_extension_available(-1, XANDESPMU) &&

What's the rationale for this not using riscv_has_extension_unlikely()?
Happens once in probe so don't bother? I forget if we discussed it when
the code was added, but it would save us from the NULL/-1 syntax,
neither of which I think is a good interface.

Also, I'd prob drop the "drivers" from $subject.

I'll come back and look at the rest of this Monday, it's a sunny Friday
here and I've still got my devicetree patch queue to clear..

Cheers,
Conor.

>  		   IS_ENABLED(CONFIG_ANDES_CUSTOM_PMU)) {
>  		riscv_pmu_irq_num =3D ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ_PMOVI;
>  		riscv_pmu_use_irq =3D true;
>=20
> --=20
> 2.44.0
>=20

--yY5dZCAicSqxniow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZivVcAAKCRB4tDGHoIJi
0q5xAQCe2FA1+i41mmMJDi5wo0K0launNVhNkUuTkEaiFR0IhAD/Ym63WbkJOpJ0
Y1cgyr29/q9i4AU76MmaZX7FfGD9pAU=
=pgke
-----END PGP SIGNATURE-----

--yY5dZCAicSqxniow--

