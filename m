Return-Path: <linux-kselftest+bounces-9381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421C38BB14E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE962837ED
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDD6157A54;
	Fri,  3 May 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSZFWd59"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D54157A4F;
	Fri,  3 May 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755580; cv=none; b=Ju7EKA/KDCIyeLhciAMnui4RlVlc3Qo2qXPY+QhbQgtXK3qqg+fTd3sF7wSIam4FhDrSzrBMCtyAznlF10DkEywZr0G2loyi7zu3nMmsMFjlNDZjYo6Cr29DaLb+N2NcI+SAaODWNDk8HfyhCZE2NUwSpeCDLVgwBfA7zf84xdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755580; c=relaxed/simple;
	bh=vvcBvT6k7MW9lcqkcTuHTUlXRCysGywOkQMNFUqI1HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYNi/fey5p6lBiSY3e873qiz5YA59e03nQI+wjS3n3n0jdwHH8sFZJzUq9ggQDNfswHB2nFzM987Xl3FIn91x/4v4EEjhAYGWQ96W5rghjrCRb0/yDESyApfeUnCsHivljadneC6a8e1mFtxjWV9dJboaGIeRM62Z7lcNTUf648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSZFWd59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628B6C116B1;
	Fri,  3 May 2024 16:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714755579;
	bh=vvcBvT6k7MW9lcqkcTuHTUlXRCysGywOkQMNFUqI1HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSZFWd59XXPmDZD6g5k7lZqj9fhC5u3o0luW/c5v43i4PLwlWbXjXuiY7N/3Fvkza
	 yiQ37uooXGmhvimq+ipEQWfK3NPQfx/1/tD4/5/ogAOlsLqeUlrpsHPE6dANieeQFC
	 cge9SuF/YFnaDxfmcjxIXZJwozDA3V84vpeebfsY8I1LS3xbISHfZ/gRHKADcqGQh9
	 u9WMYt2Ddy2vLdxSJddz61dweY5vVxx5LBfKA88HfgdsszY8mhgovfZGHgBBbsD229
	 THtCmjgqQ7EmoIuIH2J/WBAM39ocQQ2jpO73EWTR7nmDgZuqhvw6UWwiBT7RfznI2N
	 6p8Gzjc+xmlug==
Date: Fri, 3 May 2024 17:59:33 +0100
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
Subject: Re: [PATCH v5 03/17] riscv: vector: Use vlenb from DT
Message-ID: <20240503-zippy-skeletal-e5f63c9f17c1@spud>
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
 <20240502-dev-charlie-support_thead_vector_6_9-v5-3-d1b5c013a966@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Jm1skXhSfPF6Cfdj"
Content-Disposition: inline
In-Reply-To: <20240502-dev-charlie-support_thead_vector_6_9-v5-3-d1b5c013a966@rivosinc.com>


--Jm1skXhSfPF6Cfdj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 09:46:38PM -0700, Charlie Jenkins wrote:
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
> index 3ed2359eae35..12c79db0b0bb 100644
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
> +static int has_riscv_homogeneous_vlenb(void)
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
> +			return -ENOENT;
> +		}
> +
> +		if (of_property_read_u32(cpu_node, "riscv,vlenb", &vlenb)) {
> +			of_node_put(cpu_node);
> +
> +			if (prev_vlenb)
> +				return -ENOENT;
> +			continue;
> +		}
> +
> +		if (prev_vlenb && vlenb !=3D prev_vlenb) {
> +			of_node_put(cpu_node);
> +			return -ENOENT;
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
> +		if (elf_hwcap & COMPAT_HWCAP_ISA_V && has_riscv_homogeneous_vlenb() < =
0) {

I still think this isn't quite right, as it will emit a warning when
RISCV_ISA_V is disabled. The simplest thing to do probably is just
add an `if (IS_ENABLED(CONFIG_RISCV_ISA_V) return 0` shortcut the to
function? It'll get disabled a few lines later so I think a zero is
safe.

> +			pr_warn("Unsupported heterogeneous vlen detected, vector extension di=
sabled.\n");
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

--Jm1skXhSfPF6Cfdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjUX9QAKCRB4tDGHoIJi
0rXxAQDDUnlsnbkBc4xorvMXBorwh8UuxTwps60RTP8U5kKaKwD/RTwTniatfEGc
LN74K3N4cTgYcOwsuNu6rNRBb5lk5Ao=
=d5rs
-----END PGP SIGNATURE-----

--Jm1skXhSfPF6Cfdj--

