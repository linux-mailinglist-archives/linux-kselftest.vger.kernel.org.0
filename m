Return-Path: <linux-kselftest+bounces-9188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E708B889B
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 12:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455B21C21703
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 10:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD35336A;
	Wed,  1 May 2024 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5ee8bwg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930CED520;
	Wed,  1 May 2024 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714559512; cv=none; b=lsIPGrcB8Njd/R8HOWAI4UPSiKPauaEKhAf9wiSkycgbNpk4qBttjBQrK7XNUlNk16qv/AQ2dtGkajwLmrjFKnAtVgoxUxYHc74hXGo5xJ3CQIrHRjTcGyHCCI7C94/RRvmKIPZvvwfuprftmSFxNUrPTIMmDanufhELaIWOPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714559512; c=relaxed/simple;
	bh=6DBbHrkfxS0tiwHrPZgT+bjTP/LQ6KTVWXOSl9oS0uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKJbMJNsr0yj38pAKqBpiKs5xQVbQQcuAfZ1cZgyJeNFz6vZH5R1M1Bjg5cJ+u7FfyeUlomXxchX8lZcMhZpVaiiviHdvt9yA2Ram5bt/8vSvcWnLcGFiQxSk12Dog9QMSSBUec2cKXbCUBHjyemEprVjYo07NmYuDdmpflJsZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5ee8bwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87259C113CC;
	Wed,  1 May 2024 10:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714559512;
	bh=6DBbHrkfxS0tiwHrPZgT+bjTP/LQ6KTVWXOSl9oS0uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5ee8bwgBLBCu4DumpOEAERsjw3ZbAP1XblSkz9aVFKZGtMgCFTiA0pxj3GXTowo2
	 7ckb1Z6BdjEoy5msRFbdI7BAYmKf3htSei2B1D+T+yu7FP0PpQaNy/3aUaePzp97sH
	 cKmbeqTesHi0Ye71vJBxFoyAGSy1+14roh4mNDgO4HIUFKck3ZWyiaPStY1bnoEVLR
	 X+s8MeH8GU3OZ/Bbz6IXbIwrDt+H/pAnwRuBeq5KVjdgFCzLaJJOUDaF7GmMYbxq0+
	 c/FTazQwk1znasxvU2OYJorZPiHHCvI29cVf3yfADDUqbsf5qSiQcr3P/qB1DuRqmk
	 iHHbtFC1LN2rw==
Date: Wed, 1 May 2024 11:31:45 +0100
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
Subject: Re: [PATCH v4 03/16] riscv: vector: Use vlenb from DT
Message-ID: <20240501-showroom-rephrase-66c0929011b3@spud>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-3-b692f3c516ec@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SnPvkgTlHmJo6buD"
Content-Disposition: inline
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-3-b692f3c516ec@rivosinc.com>


--SnPvkgTlHmJo6buD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 02:29:17PM -0700, Charlie Jenkins wrote:
> If vlenb is provided in the device tree, prefer that over reading the
> vlenb csr.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h |  2 ++
>  arch/riscv/kernel/cpufeature.c      | 43 +++++++++++++++++++++++++++++++=
++++++
>  arch/riscv/kernel/vector.c          | 12 ++++++++++-
>  3 files changed, 56 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 347805446151..0c4f08577015 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -31,6 +31,8 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>  /* Per-cpu ISA extensions. */
>  extern struct riscv_isainfo hart_isa[NR_CPUS];
> =20
> +extern u32 riscv_vlenb_of;
> +
>  void riscv_user_isa_enable(void);
> =20
>  #if defined(CONFIG_RISCV_MISALIGNED)
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 3ed2359eae35..8158f34c3e36 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -35,6 +35,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __r=
ead_mostly;
>  /* Per-cpu ISA extensions. */
>  struct riscv_isainfo hart_isa[NR_CPUS];
> =20
> +u32 riscv_vlenb_of;
> +
>  /**
>   * riscv_isa_extension_base() - Get base extension word
>   *
> @@ -648,6 +650,42 @@ static int __init riscv_isa_fallback_setup(char *__u=
nused)
>  early_param("riscv_isa_fallback", riscv_isa_fallback_setup);
>  #endif
> =20
> +static int riscv_homogeneous_vlenb(void)

Without a verb, this function name is rather odd.

> +{
> +	int cpu;
> +	u32 prev_vlenb =3D 0;
> +	u32 vlenb;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct device_node *cpu_node;
> +
> +		cpu_node =3D of_cpu_device_node_get(cpu);
> +		if (!cpu_node) {
> +			pr_warn("Unable to find cpu node\n");
> +			continue;

Hmm, if we fail to find the cpu node, then shouldn't we be returning an
error?

> +		}
> +
> +		if (of_property_read_u32(cpu_node, "riscv,vlenb", &vlenb)) {
> +			of_node_put(cpu_node);
> +
> +			if (prev_vlenb)
> +				return -1;

Can you return an errno here and below please?

> +			continue;
> +		}
> +
> +		if (prev_vlenb && vlenb !=3D prev_vlenb) {
> +			of_node_put(cpu_node);
> +			return -1;
> +		}
> +
> +		prev_vlenb =3D vlenb;
> +		of_node_put(cpu_node);
> +	}
> +
> +	riscv_vlenb_of =3D vlenb;
> +	return 0;
> +}
> +
>  void __init riscv_fill_hwcap(void)
>  {
>  	char print_str[NUM_ALPHA_EXTS + 1];
> @@ -671,6 +709,11 @@ void __init riscv_fill_hwcap(void)
>  			pr_info("Falling back to deprecated \"riscv,isa\"\n");
>  			riscv_fill_hwcap_from_isa_string(isa2hwcap);
>  		}
> +
> +		if (riscv_homogeneous_vlenb() < 0) {
> +			pr_warn("RISCV_ISA_V only supports one vlenb on SMP systems. Please e=
nsure that the riscv,vlenb devicetree property is the same across all CPUs.=
 Either all CPUs must have the riscv,vlenb property, or none. If no CPUs in=
 the devicetree use riscv,vlenb then vlenb will be probed from the vlenb CS=
R. Disabling vector.\n");

Oh dear, that's a bit unwieldy... I think you could get away with a far
more basic message - and you should be able to break this over lines,
adjacent string literals should get concatenated.
I'd probably say something like "unsupported heterogeneous vlen detected,
vector extension disabled", however we should actually check that the
vector extension has been detected on all CPUs and that kernel support
for vector is enabled before emitting a warning for this.

Cheers,
Conor.

> +			elf_hwcap &=3D ~COMPAT_HWCAP_ISA_V;
> +		}
>  	}
> =20
>  	/*
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 6727d1d3b8f2..e04586cdb7f0 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -33,7 +33,17 @@ int riscv_v_setup_vsize(void)
>  {
>  	unsigned long this_vsize;
> =20
> -	/* There are 32 vector registers with vlenb length. */
> +	/*
> +	 * There are 32 vector registers with vlenb length.
> +	 *
> +	 * If the riscv,vlenb property was provided by the firmware, use that
> +	 * instead of probing the CSRs.
> +	 */
> +	if (riscv_vlenb_of) {
> +		this_vsize =3D riscv_vlenb_of * 32;
> +		return 0;
> +	}
> +
>  	riscv_v_enable();
>  	this_vsize =3D csr_read(CSR_VLENB) * 32;
>  	riscv_v_disable();
>=20
> --=20
> 2.44.0
>=20

--SnPvkgTlHmJo6buD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjIaEQAKCRB4tDGHoIJi
0hNBAP9YH38VakJjIeXqwOnQlJJWTLPRdPDQPf5eTY+Ir67I6QEA8WCxzjgKtaAO
OCpGug+WIcHcZlm8J+isXxxHhyQ9TwQ=
=T1wq
-----END PGP SIGNATURE-----

--SnPvkgTlHmJo6buD--

