Return-Path: <linux-kselftest+bounces-8166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1129D8A6F45
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2842BB25D06
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B812F5A6;
	Tue, 16 Apr 2024 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1EqWvM4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B212C47A;
	Tue, 16 Apr 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279808; cv=none; b=KPNA/zk5UcfMaSaPnr8cB/Np2gpqC9pvjstoJ9nFmgcg9c/ROw+QpjrwmfjDkjHk8zw5csA+gJFawI5xfxdeTTyOReBKqyhOUAnMbMSeGUkBLJayk/qUNrxQSHC2YFHsZEzXk5F/zN2dlAeiaPpgqHea3IZ8zKsFq/3OSLU2gA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279808; c=relaxed/simple;
	bh=0dFehR7bAofXvwdhbQHUWpVwxNS4jlbytNrjxajS/Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hs5MoXZHwUfWUwQj15pwRco7LA3j6dTuBf5CqMZ9YERMPKwc//W3NFqHf8SJ3L0WPOvI4zCxKisHt2fVQK3K51iU+6weopSu3AsEhVirFte9CzpgrJEKp1O9LThMk757OCHESk3Z3K3SH7/93aqsqUk+DGcwyzu1bJGtnB5qcWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1EqWvM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA14C113CE;
	Tue, 16 Apr 2024 15:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713279807;
	bh=0dFehR7bAofXvwdhbQHUWpVwxNS4jlbytNrjxajS/Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d1EqWvM4R01QG++RsWmY7K55v0olQvvgXIenexsbrc4JKA4nwVfDNHbXnpJ2hODiu
	 uKXP42Z5t3X8ceOGrFIX++T91LRgNZrljeuacqKst+uLTaMHaV99gERfLC1bHjBbod
	 uCrU9jKaCvpAs4YTPg8bY4yfClF1wx8tsQqjMthQc5BA0EToSY6K1fPSqef/N+PSro
	 ozaY5pPAqJBmIuxx6sHAeyRk60Mr9DyVOlmvpu+y3z4jVI9aHvcO3wiChQu9vPek6+
	 ANtnjbfUJ/4nZQqhFLpPwXnHN61iI1y9UYuY2KOIzVPTHSIbTmXWfY9vUYJGk1R2cL
	 GwKYqAUJQnPDg==
Date: Tue, 16 Apr 2024 16:03:20 +0100
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
Subject: Re: [PATCH v2 01/17] riscv: cpufeature: Fix thead vector hwcap
 removal
Message-ID: <20240416-swipe-flattered-7cdccc01f0fe@spud>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
 <20240415-dev-charlie-support_thead_vector_6_9-v2-1-c7d68c603268@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RbQjJEERG41bUbGr"
Content-Disposition: inline
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-1-c7d68c603268@rivosinc.com>


--RbQjJEERG41bUbGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 09:11:58PM -0700, Charlie Jenkins wrote:
> The riscv_cpuinfo struct that contains mvendorid and marchid is not
> populated until all harts are booted which happens after the DT parsing.
> Use the vendorid/archid values from the DT if available or assume all
> harts have the same values as the boot hart as a fallback.
>=20
> Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property on =
older T-Head CPUs")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h   |  2 ++
>  arch/riscv/kernel/cpu.c        | 36 ++++++++++++++++++++++++++++++++----
>  arch/riscv/kernel/cpufeature.c | 12 ++++++++++--
>  3 files changed, 44 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 6e68f8dff76b..0fab508a65b3 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -370,6 +370,8 @@ static inline int sbi_remote_fence_i(const struct cpu=
mask *cpu_mask) { return -1
>  static inline void sbi_init(void) {}
>  #endif /* CONFIG_RISCV_SBI */
> =20
> +unsigned long riscv_get_mvendorid(void);
> +unsigned long riscv_get_marchid(void);
>  unsigned long riscv_cached_mvendorid(unsigned int cpu_id);
>  unsigned long riscv_cached_marchid(unsigned int cpu_id);
>  unsigned long riscv_cached_mimpid(unsigned int cpu_id);
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index d11d6320fb0d..8c8250b98752 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -139,6 +139,34 @@ int riscv_of_parent_hartid(struct device_node *node,=
 unsigned long *hartid)
>  	return -1;
>  }
> =20
> +unsigned long __init riscv_get_marchid(void)
> +{
> +	struct riscv_cpuinfo *ci =3D this_cpu_ptr(&riscv_cpuinfo);
> +
> +#if IS_ENABLED(CONFIG_RISCV_SBI)
> +	ci->marchid =3D sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> +	ci->marchid =3D csr_read(CSR_MARCHID);
> +#else
> +	ci->marchid =3D 0;
> +#endif
> +	return ci->marchid;
> +}
> +
> +unsigned long __init riscv_get_mvendorid(void)
> +{
> +	struct riscv_cpuinfo *ci =3D this_cpu_ptr(&riscv_cpuinfo);
> +
> +#if IS_ENABLED(CONFIG_RISCV_SBI)
> +	ci->mvendorid =3D sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> +	ci->mvendorid =3D csr_read(CSR_MVENDORID);
> +#else
> +	ci->mvendorid =3D 0;
> +#endif
> +	return ci->mvendorid;
> +}
> +
>  DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> =20
>  unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
> @@ -170,12 +198,12 @@ static int riscv_cpuinfo_starting(unsigned int cpu)
>  	struct riscv_cpuinfo *ci =3D this_cpu_ptr(&riscv_cpuinfo);
> =20
>  #if IS_ENABLED(CONFIG_RISCV_SBI)
> -	ci->mvendorid =3D sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> -	ci->marchid =3D sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> +	ci->mvendorid =3D ci->mvendorid ? ci->mvendorid : sbi_spec_is_0_1() ? 0=
 : sbi_get_mvendorid();
> +	ci->marchid =3D ci->marchid ? ci->marchid : sbi_spec_is_0_1() ? 0 : sbi=
_get_marchid();

Can we please not have double ternary stuff? This is awful to grok :(
Can you do
if (!ci->m*id)
	sbi_spec_is_0_1() ? 0 : sbi_get_m*id();
instead? I think that is much easier to understand.
Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>  	ci->mimpid =3D sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
>  #elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> -	ci->mvendorid =3D csr_read(CSR_MVENDORID);
> -	ci->marchid =3D csr_read(CSR_MARCHID);
> +	ci->mvendorid =3D ci->mvendorid ? ci->mvendorid : csr_read(CSR_MVENDORI=
D);
> +	ci->marchid =3D ci->marchid ? ci->marchid : csr_read(CSR_MARCHID);
>  	ci->mimpid =3D csr_read(CSR_MIMPID);
>  #else
>  	ci->mvendorid =3D 0;
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 3ed2359eae35..c6e27b45e192 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -490,6 +490,8 @@ static void __init riscv_fill_hwcap_from_isa_string(u=
nsigned long *isa2hwcap)
>  	struct acpi_table_header *rhct;
>  	acpi_status status;
>  	unsigned int cpu;
> +	u64 boot_vendorid;
> +	u64 boot_archid;
> =20
>  	if (!acpi_disabled) {
>  		status =3D acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> @@ -497,6 +499,13 @@ static void __init riscv_fill_hwcap_from_isa_string(=
unsigned long *isa2hwcap)
>  			return;
>  	}
> =20
> +	/*
> +	 * Naively assume that all harts have the same mvendorid/marchid as the
> +	 * boot hart.
> +	 */
> +	boot_vendorid =3D riscv_get_mvendorid();
> +	boot_archid =3D riscv_get_marchid();
> +
>  	for_each_possible_cpu(cpu) {
>  		struct riscv_isainfo *isainfo =3D &hart_isa[cpu];
>  		unsigned long this_hwcap =3D 0;
> @@ -544,8 +553,7 @@ static void __init riscv_fill_hwcap_from_isa_string(u=
nsigned long *isa2hwcap)
>  		 * CPU cores with the ratified spec will contain non-zero
>  		 * marchid.
>  		 */
> -		if (acpi_disabled && riscv_cached_mvendorid(cpu) =3D=3D THEAD_VENDOR_I=
D &&
> -		    riscv_cached_marchid(cpu) =3D=3D 0x0) {
> +		if (acpi_disabled && boot_vendorid =3D=3D THEAD_VENDOR_ID && boot_arch=
id =3D=3D 0x0) {
>  			this_hwcap &=3D ~isa2hwcap[RISCV_ISA_EXT_v];
>  			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
>  		}
>=20
> --=20
> 2.44.0
>=20

--RbQjJEERG41bUbGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh6TOAAKCRB4tDGHoIJi
0ugHAP9wq53A/rRMZA7YNcwk3t+YkspiOROzoX/lB6mQceQcywEA6kOQ31DLs19U
K7NuAGuzzBkZ9AZreTReZw47pw/tXwo=
=YaUr
-----END PGP SIGNATURE-----

--RbQjJEERG41bUbGr--

