Return-Path: <linux-kselftest+bounces-8922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F79F8B3B18
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 17:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2651B289FBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 15:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159171494B2;
	Fri, 26 Apr 2024 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8EO8pjG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396214885A;
	Fri, 26 Apr 2024 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144679; cv=none; b=ffmI1f6syOOBMW9PFBfnGxZiiMqxKcBCQSAWk+mN/U287IFPXUvxXJQFEQHnJDWwesEFe2IigiiGAnRrfIjDuqEOudrYQiTeR0xE3TcX/j+auq7NjXrTePzY91s7Q7Tb0ols1aSdwj9X62mpfTIhVdAggVt4is/pBGM9UZfEAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144679; c=relaxed/simple;
	bh=+/fENaK5cFg3kscakPUFAoJIJiT0bv1e6mPEpyZqBr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IL4Nt4afOKo6tps3zKxNVeZ1YsAcocj2J+Lx9e2YcYGzxvk5V9sxyX2p5m8Jeb/cA7W0YNFMASpJiMtEVRbv2xw8FnH+oaFNbMOJr160rDVhxNKoMxISnfm5coX3m6qykocon0/OuXjh83MlpQfjhC6ygCi7U86xip5AxdQNJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8EO8pjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F55C113CD;
	Fri, 26 Apr 2024 15:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144678;
	bh=+/fENaK5cFg3kscakPUFAoJIJiT0bv1e6mPEpyZqBr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8EO8pjGnbGSXuuL1OtXwdhfm6ZO1hYNJiCIWrOD5+TidBHDEMBP2H0XXK6sAx1Gh
	 WRzI/hZ/FmVRPe+Wkqh/qUndVxQzUVqVpFJoqgLl8wcBGuIDpLpR3eby3yVgqBIFyM
	 kW0vR+6LUOdFfT1y7Gkf4pCcLS7IU3WoiNzYs7YI12ZnvE7+EyNhL1szux/vBuPkuP
	 JAU3Di1GeehfGa6RK3a/MEoOkxTSzZ26u5+DN9ywvyA8fPJ5gjQ/mFK0ItEa/toO6w
	 EgMH3tl6aH9y931UT5HWsC9po8EpwU0UPR8QdZzH/XrnEq+5ufni1qcQzAfzDSXyFc
	 8Ml/rFYdMuJ+Q==
Date: Fri, 26 Apr 2024 16:17:52 +0100
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
Subject: Re: [PATCH v3 04/17] riscv: vector: Use vlenb from DT
Message-ID: <20240426-unfocused-amount-e4e74e66962f@spud>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
 <20240420-dev-charlie-support_thead_vector_6_9-v3-4-67cff4271d1d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/f82oMmmh2jh87go"
Content-Disposition: inline
In-Reply-To: <20240420-dev-charlie-support_thead_vector_6_9-v3-4-67cff4271d1d@rivosinc.com>


--/f82oMmmh2jh87go
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 06:04:36PM -0700, Charlie Jenkins wrote:
> If vlenb is provided in the device tree, prefer that over reading the
> vlenb csr.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h |  2 ++
>  arch/riscv/kernel/cpufeature.c      | 26 ++++++++++++++++++++++++++
>  arch/riscv/kernel/vector.c          | 13 +++++++++----
>  3 files changed, 37 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 347805446151..809f61ffb667 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -31,6 +31,8 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>  /* Per-cpu ISA extensions. */
>  extern struct riscv_isainfo hart_isa[NR_CPUS];
> =20
> +extern u32 riscv_vlenb_dt[NR_CPUS];
> +
>  void riscv_user_isa_enable(void);
> =20
>  #if defined(CONFIG_RISCV_MISALIGNED)
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index c6e27b45e192..48874aac4871 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -35,6 +35,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __r=
ead_mostly;
>  /* Per-cpu ISA extensions. */
>  struct riscv_isainfo hart_isa[NR_CPUS];
> =20
> +u32 riscv_vlenb_dt[NR_CPUS];
> +
>  /**
>   * riscv_isa_extension_base() - Get base extension word
>   *
> @@ -656,6 +658,28 @@ static int __init riscv_isa_fallback_setup(char *__u=
nused)
>  early_param("riscv_isa_fallback", riscv_isa_fallback_setup);
>  #endif
> =20
> +static void riscv_set_vlenb_from_dt(void)

I'd expect to see a name here that had "of" in it, not "dt".

> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct device_node *cpu_node;
> +
> +		cpu_node =3D of_cpu_device_node_get(cpu);
> +		if (!cpu_node) {
> +			pr_warn("Unable to find cpu node\n");
> +			continue;
> +		}
> +
> +		if (!of_property_read_u32(cpu_node, "riscv,vlenb", &riscv_vlenb_dt[cpu=
])) {
> +			of_node_put(cpu_node);
> +			continue;
> +		}
> +
> +		of_node_put(cpu_node);
> +	}
> +}
> +
>  void __init riscv_fill_hwcap(void)
>  {
>  	char print_str[NUM_ALPHA_EXTS + 1];
> @@ -675,6 +699,8 @@ void __init riscv_fill_hwcap(void)
>  	} else {
>  		int ret =3D riscv_fill_hwcap_from_ext_list(isa2hwcap);
> =20
> +		riscv_set_vlenb_from_dt();

Hmm, I think we can go a step further here. We know all of the CPUs
widths by the time we get to the first call to riscv_v_setup_vsize(), can
we examine the whole list and decide not to enable vector if they do
not match, rather than continuing and failing to online CPUs that having
the mismatched size?

I guess that can go into the `if (elf_hwcap & COMPAT_HWCAP_ISA_V)`
condition we already have, and would require clearing the bit from the
mask we have at the moment.

Cheers,
Conor.

> +
>  		if (ret && riscv_isa_fallback) {
>  			pr_info("Falling back to deprecated \"riscv,isa\"\n");
>  			riscv_fill_hwcap_from_isa_string(isa2hwcap);
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 6727d1d3b8f2..fb7f3ca80d9e 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -32,11 +32,16 @@ EXPORT_SYMBOL_GPL(riscv_v_vsize);
>  int riscv_v_setup_vsize(void)
>  {
>  	unsigned long this_vsize;
> +	int cpu =3D smp_processor_id();
> =20
> -	/* There are 32 vector registers with vlenb length. */
> -	riscv_v_enable();
> -	this_vsize =3D csr_read(CSR_VLENB) * 32;
> -	riscv_v_disable();
> +	if (riscv_vlenb_dt[cpu]) {
> +		this_vsize =3D riscv_vlenb_dt[cpu];

> +	} else {
> +		/* There are 32 vector registers with vlenb length. */
> +		riscv_v_enable();
> +		this_vsize =3D csr_read(CSR_VLENB) * 32;
> +		riscv_v_disable();
> +	}
> =20
>  	if (!riscv_v_vsize) {
>  		riscv_v_vsize =3D this_vsize;
>=20
> --=20
> 2.44.0
>=20

--/f82oMmmh2jh87go
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZivFoAAKCRB4tDGHoIJi
0lF6AP0ehEsfxARMlCxOz5UMGtGRXyOJbr5gWiVUL5P1faiZAQD+NLZW+R2Tboo5
nIrNrSxgWYbJVCV/sCH9Gny0THVwGg0=
=jRyL
-----END PGP SIGNATURE-----

--/f82oMmmh2jh87go--

