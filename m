Return-Path: <linux-kselftest+bounces-9092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 372AD8B655B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 00:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35012832BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 22:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F28019069A;
	Mon, 29 Apr 2024 22:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQvD37S0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF317798F;
	Mon, 29 Apr 2024 22:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714428961; cv=none; b=FwvkonT3CSZ8KxOJbsoDkABaE6RbQ0AFsyHdmGrrEOfQP7gSLWE5xfFIAmDJZTzFPAVz1nDYe3ZWjGcvOshKXXaxGUjRzeTpuq5RoHNsxxK1zWPQCE9WfZS+vdKYadxiGIyHtAnOGbx2SrlEw4o7rcVh1G/dQvbbjbTgCfZYbjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714428961; c=relaxed/simple;
	bh=kI6j9LvXJei+paKWCFq45W4DHlVh8To1UON+IuKXPAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFUBPKtparEa29kd2H5omitqqDOlpFRgsw8/y1+EQT+CY8OqQfI7YOxIaHSqCwiIbG86F/tftHa4IdhJwSLv0eCA0x2SMXeNuts688QGJNXEggFILhqjifA326hWZG/JJhv7FVDi2KXMOYA5y32z4RsT14GpebwfCQ4aLcbERQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQvD37S0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B773C113CD;
	Mon, 29 Apr 2024 22:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714428960;
	bh=kI6j9LvXJei+paKWCFq45W4DHlVh8To1UON+IuKXPAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQvD37S0sU34ym3B+9iPpcfQINjMBdg9SrZXZM3G3UHvK+h5Q2OXGYQQtA/FB4ZlS
	 ShbaqtPWoD/OpXsnAUvbWydtIsIapxmXZnzVe9ChRXpj6tDpMS9f0pgJTHNDuaXW6R
	 O3NVFycd+Ud4PJbZmnmfliONIb/DRB7S+1+2C1Q7YGTD0dhCpuB6MTItqRCK8VKfIV
	 BkhPlb75uAW03eC63BX0L88ebk6S96d/LA+Tn74knpew+mjSHrzz8u+Ti3Kjgjx+Vx
	 IhOwrFV8hFP9vozQ6W7ZOO0UuN26irkaJ+8DouoPe52vtuniTEqrjojydITjK2VGru
	 LcMZR7/oHxHnA==
Date: Mon, 29 Apr 2024 23:15:55 +0100
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
Subject: Re: [PATCH v4 02/11] riscv: add ISA extensions validation
Message-ID: <20240429-subtext-tabby-3a1532f058a5@spud>
References: <20240429150553.625165-1-cleger@rivosinc.com>
 <20240429150553.625165-3-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gd7/nk5BpVfZAZKi"
Content-Disposition: inline
In-Reply-To: <20240429150553.625165-3-cleger@rivosinc.com>


--gd7/nk5BpVfZAZKi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 05:04:55PM +0200, Cl=E9ment L=E9ger wrote:
> Since a few extensions (Zicbom/Zicboz) already needs validation and
> future ones will need it as well (Zc*) add a validate() callback to
> struct riscv_isa_ext_data. This require to rework the way extensions are
> parsed and split it in two phases. First phase is isa string or isa
> extension list parsing and consists in enabling all the extensions in a
> temporary bitmask without any validation. The second step "resolves" the
> final isa bitmap, handling potential missing dependencies. The mechanism
> is quite simple and simply validate each extension described in the
> temporary bitmap before enabling it in the final isa bitmap. validate()
> callbacks can return either 0 for success, -EPROBEDEFER if extension
> needs to be validated again at next loop. A previous ISA bitmap is kept
> to avoid looping mutliple times if an extension dependencies are never
> satisfied until we reach a stable state. In order to avoid any potential
> infinite looping, allow looping a maximum of the number of extension we
> handle. Zicboz and Zicbom extensions are modified to use this validation
> mechanism.

Your reply to my last review only talked about part of my comments,
which is usually what you do when you're gonna implement the rest, but
you haven't.
I like the change you've made to shorten looping, but I'd at least like
a response to why a split is not worth doing :)

Thanks,
Conor.

>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h |   1 +
>  arch/riscv/kernel/cpufeature.c      | 211 ++++++++++++++++------------
>  2 files changed, 126 insertions(+), 86 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 347805446151..000796c2d0b1 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -70,6 +70,7 @@ struct riscv_isa_ext_data {
>  	const char *property;
>  	const unsigned int *subset_ext_ids;
>  	const unsigned int subset_ext_size;
> +	int (*validate)(const struct riscv_isa_ext_data *data, const unsigned l=
ong *isa_bitmap);
>  };
> =20
>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 115ba001f1bc..cb2ffa6c8c33 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -72,51 +72,58 @@ bool __riscv_isa_extension_available(const unsigned l=
ong *isa_bitmap, unsigned i
>  }
>  EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
> =20
> -static bool riscv_isa_extension_check(int id)
> +static bool riscv_isa_extension_valid(int id)
>  {
> -	switch (id) {
> -	case RISCV_ISA_EXT_ZICBOM:
> -		if (!riscv_cbom_block_size) {
> -			pr_err("Zicbom detected in ISA string, disabling as no cbom-block-siz=
e found\n");
> -			return false;
> -		} else if (!is_power_of_2(riscv_cbom_block_size)) {
> -			pr_err("Zicbom disabled as cbom-block-size present, but is not a powe=
r-of-2\n");
> -			return false;
> -		}
> -		return true;
> -	case RISCV_ISA_EXT_ZICBOZ:
> -		if (!riscv_cboz_block_size) {
> -			pr_err("Zicboz detected in ISA string, disabling as no cboz-block-siz=
e found\n");
> -			return false;
> -		} else if (!is_power_of_2(riscv_cboz_block_size)) {
> -			pr_err("Zicboz disabled as cboz-block-size present, but is not a powe=
r-of-2\n");
> -			return false;
> -		}
> -		return true;
> -	case RISCV_ISA_EXT_INVALID:
> -		return false;
> +	return id !=3D RISCV_ISA_EXT_INVALID;
> +}
> +
> +static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *da=
ta,
> +				     const unsigned long *isa_bitmap)
> +{
> +	if (!riscv_cbom_block_size) {
> +		pr_err("Zicbom detected in ISA string, disabling as no cbom-block-size=
 found\n");
> +		return -EINVAL;
> +	} else if (!is_power_of_2(riscv_cbom_block_size)) {
> +		pr_err("Zicbom disabled as cbom-block-size present, but is not a power=
-of-2\n");
> +		return -EINVAL;
>  	}
> +	return 0;
> +}
> =20
> -	return true;
> +static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *da=
ta,
> +				     const unsigned long *isa_bitmap)
> +{
> +	if (!riscv_cboz_block_size) {
> +		pr_err("Zicboz detected in ISA string, disabling as no cboz-block-size=
 found\n");
> +		return -EINVAL;
> +	} else if (!is_power_of_2(riscv_cboz_block_size)) {
> +		pr_err("Zicboz disabled as cboz-block-size present, but is not a power=
-of-2\n");
> +		return -EINVAL;
> +	}
> +	return 0;
>  }
> =20
> -#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size)=
 {	\
> -	.name =3D #_name,								\
> -	.property =3D #_name,							\
> -	.id =3D _id,								\
> -	.subset_ext_ids =3D _subset_exts,						\
> -	.subset_ext_size =3D _subset_exts_size					\
> +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size,=
 _validate) {	\
> +	.name =3D #_name,									\
> +	.property =3D #_name,								\
> +	.id =3D _id,									\
> +	.subset_ext_ids =3D _subset_exts,							\
> +	.subset_ext_size =3D _subset_exts_size,						\
> +	.validate =3D _validate								\
>  }
> =20
> -#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id,=
 NULL, 0)
> +#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id,=
 NULL, 0, NULL)
> =20
>  /* Used to declare pure "lasso" extension (Zk for instance) */
>  #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> -	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_=
SIZE(_bundled_exts))
> +	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
> +			    ARRAY_SIZE(_bundled_exts), NULL)
> =20
>  /* Used to declare extensions that are a superset of other extensions (Z=
vbb for instance) */
>  #define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> -	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
> +	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), NULL)
> +#define __RISCV_ISA_EXT_SUPERSET_VALIDATE(_name, _id, _sub_exts, _valida=
te) \
> +	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _vali=
date)
> =20
>  static const unsigned int riscv_zk_bundled_exts[] =3D {
>  	RISCV_ISA_EXT_ZBKB,
> @@ -247,8 +254,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
>  	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
>  	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
> -	__RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvc=
fg_exts),
> -	__RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvc=
fg_exts),
> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_x=
linuxenvcfg_exts,
> +					  riscv_ext_zicbom_validate),
> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_x=
linuxenvcfg_exts,
> +					  riscv_ext_zicboz_validate),
>  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>  	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> @@ -310,33 +319,80 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> =20
>  const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
> =20
> -static void __init match_isa_ext(const struct riscv_isa_ext_data *ext, c=
onst char *name,
> -				 const char *name_end, struct riscv_isainfo *isainfo)
> +static void riscv_isa_set_ext(const struct riscv_isa_ext_data *ext, unsi=
gned long *bitmap)
>  {
> -	if ((name_end - name =3D=3D strlen(ext->name)) &&
> -	     !strncasecmp(name, ext->name, name_end - name)) {
> -		/*
> -		 * If this is a bundle, enable all the ISA extensions that
> -		 * comprise the bundle.
> -		 */
> -		if (ext->subset_ext_size) {
> -			for (int i =3D 0; i < ext->subset_ext_size; i++) {
> -				if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
> -					set_bit(ext->subset_ext_ids[i], isainfo->isa);
> -			}
> +	/*
> +	 * This is valid even for bundle extensions which uses the RISCV_ISA_EX=
T_INVALID id
> +	 * (rejected by riscv_isa_extension_valid()).
> +	 */
> +	if (riscv_isa_extension_valid(ext->id))
> +		set_bit(ext->id, bitmap);
> +
> +	for (int i =3D 0; i < ext->subset_ext_size; i++) {
> +		if (riscv_isa_extension_valid(ext->subset_ext_ids[i]))
> +			set_bit(ext->subset_ext_ids[i], bitmap);
> +	}
> +}
> +
> +static void __init riscv_resolve_isa(unsigned long *isa_bitmap, struct r=
iscv_isainfo *isainfo,
> +				     unsigned long *this_hwcap, unsigned long *isa2hwcap)
> +{
> +	bool loop;
> +	const struct riscv_isa_ext_data *ext;
> +	DECLARE_BITMAP(prev_bitmap, RISCV_ISA_EXT_MAX);
> +	int max_loop_count =3D riscv_isa_ext_count, ret;
> +
> +	do {
> +		loop =3D false;
> +		if (max_loop_count-- < 0) {
> +			pr_err("Failed to reach a stable ISA state\n");
> +			return;
>  		}
> +		memcpy(prev_bitmap, isainfo->isa, sizeof(prev_bitmap));
> +		for (int i =3D 0; i < riscv_isa_ext_count; i++) {
> +			ext =3D &riscv_isa_ext[i];
> +
> +			/* Bundle extensions ids are invalid*/
> +			if (!riscv_isa_extension_valid(ext->id))
> +				continue;
> +
> +			if (!test_bit(ext->id, isa_bitmap) || test_bit(ext->id, isainfo->isa))
> +				continue;
> +
> +			if (ext->validate) {
> +				ret =3D ext->validate(ext, isainfo->isa);
> +				if (ret) {
> +					if (ret =3D=3D -EPROBE_DEFER)
> +						loop =3D true;
> +					else
> +						clear_bit(ext->id, isa_bitmap);
> +					continue;
> +				}
> +			}
> =20
> -		/*
> -		 * This is valid even for bundle extensions which uses the RISCV_ISA_E=
XT_INVALID id
> -		 * (rejected by riscv_isa_extension_check()).
> -		 */
> -		if (riscv_isa_extension_check(ext->id))
>  			set_bit(ext->id, isainfo->isa);
> +
> +			/* Only single letter extensions get set in hwcap */
> +			if (ext->id < RISCV_ISA_EXT_BASE)
> +				*this_hwcap |=3D isa2hwcap[ext->id];
> +		}
> +	} while (loop && memcmp(prev_bitmap, isainfo->isa, sizeof(prev_bitmap))=
);
> +}
> +
> +static void __init match_isa_ext(const char *name, const char *name_end,=
 unsigned long *bitmap)
> +{
> +	for (int i =3D 0; i < riscv_isa_ext_count; i++) {
> +		const struct riscv_isa_ext_data *ext =3D &riscv_isa_ext[i];
> +
> +		if ((name_end - name =3D=3D strlen(ext->name)) &&
> +		    !strncasecmp(name, ext->name, name_end - name)) {
> +			riscv_isa_set_ext(ext, bitmap);
> +			break;
> +		}
>  	}
>  }
> =20
> -static void __init riscv_parse_isa_string(unsigned long *this_hwcap, str=
uct riscv_isainfo *isainfo,
> -					  unsigned long *isa2hwcap, const char *isa)
> +static void __init riscv_resolve_isa_string(const char *isa, unsigned lo=
ng *bitmap)
>  {
>  	/*
>  	 * For all possible cpus, we have already validated in
> @@ -349,7 +405,7 @@ static void __init riscv_parse_isa_string(unsigned lo=
ng *this_hwcap, struct risc
>  	while (*isa) {
>  		const char *ext =3D isa++;
>  		const char *ext_end =3D isa;
> -		bool ext_long =3D false, ext_err =3D false;
> +		bool ext_err =3D false;
> =20
>  		switch (*ext) {
>  		case 's':
> @@ -389,7 +445,6 @@ static void __init riscv_parse_isa_string(unsigned lo=
ng *this_hwcap, struct risc
>  			 * character itself while eliminating the extensions version number.
>  			 * A simple re-increment solves this problem.
>  			 */
> -			ext_long =3D true;
>  			for (; *isa && *isa !=3D '_'; ++isa)
>  				if (unlikely(!isalnum(*isa)))
>  					ext_err =3D true;
> @@ -469,17 +524,8 @@ static void __init riscv_parse_isa_string(unsigned l=
ong *this_hwcap, struct risc
> =20
>  		if (unlikely(ext_err))
>  			continue;
> -		if (!ext_long) {
> -			int nr =3D tolower(*ext) - 'a';
> =20
> -			if (riscv_isa_extension_check(nr)) {
> -				*this_hwcap |=3D isa2hwcap[nr];
> -				set_bit(nr, isainfo->isa);
> -			}
> -		} else {
> -			for (int i =3D 0; i < riscv_isa_ext_count; i++)
> -				match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
> -		}
> +		match_isa_ext(ext, ext_end, bitmap);
>  	}
>  }
> =20
> @@ -501,6 +547,7 @@ static void __init riscv_fill_hwcap_from_isa_string(u=
nsigned long *isa2hwcap)
>  	for_each_possible_cpu(cpu) {
>  		struct riscv_isainfo *isainfo =3D &hart_isa[cpu];
>  		unsigned long this_hwcap =3D 0;
> +		DECLARE_BITMAP(isa_bitmap, RISCV_ISA_EXT_MAX) =3D { 0 };
> =20
>  		if (acpi_disabled) {
>  			node =3D of_cpu_device_node_get(cpu);
> @@ -523,7 +570,7 @@ static void __init riscv_fill_hwcap_from_isa_string(u=
nsigned long *isa2hwcap)
>  			}
>  		}
> =20
> -		riscv_parse_isa_string(&this_hwcap, isainfo, isa2hwcap, isa);
> +		riscv_resolve_isa_string(isa, isa_bitmap);
> =20
>  		/*
>  		 * These ones were as they were part of the base ISA when the
> @@ -531,10 +578,10 @@ static void __init riscv_fill_hwcap_from_isa_string=
(unsigned long *isa2hwcap)
>  		 * unconditionally where `i` is in riscv,isa on DT systems.
>  		 */
>  		if (acpi_disabled) {
> -			set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
> -			set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
> -			set_bit(RISCV_ISA_EXT_ZICNTR, isainfo->isa);
> -			set_bit(RISCV_ISA_EXT_ZIHPM, isainfo->isa);
> +			set_bit(RISCV_ISA_EXT_ZICSR, isa_bitmap);
> +			set_bit(RISCV_ISA_EXT_ZIFENCEI, isa_bitmap);
> +			set_bit(RISCV_ISA_EXT_ZICNTR, isa_bitmap);
> +			set_bit(RISCV_ISA_EXT_ZIHPM, isa_bitmap);
>  		}
> =20
>  		/*
> @@ -548,9 +595,11 @@ static void __init riscv_fill_hwcap_from_isa_string(=
unsigned long *isa2hwcap)
>  		if (acpi_disabled && riscv_cached_mvendorid(cpu) =3D=3D THEAD_VENDOR_I=
D &&
>  		    riscv_cached_marchid(cpu) =3D=3D 0x0) {
>  			this_hwcap &=3D ~isa2hwcap[RISCV_ISA_EXT_v];
> -			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
> +			clear_bit(RISCV_ISA_EXT_v, isa_bitmap);
>  		}
> =20
> +		riscv_resolve_isa(isa_bitmap, isainfo, &this_hwcap, isa2hwcap);
> +
>  		/*
>  		 * All "okay" hart should have same isa. Set HWCAP based on
>  		 * common capabilities of every "okay" hart, in case they don't
> @@ -579,6 +628,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsi=
gned long *isa2hwcap)
>  		unsigned long this_hwcap =3D 0;
>  		struct device_node *cpu_node;
>  		struct riscv_isainfo *isainfo =3D &hart_isa[cpu];
> +		DECLARE_BITMAP(isa_bitmap, RISCV_ISA_EXT_MAX) =3D { 0 };
> =20
>  		cpu_node =3D of_cpu_device_node_get(cpu);
>  		if (!cpu_node) {
> @@ -598,22 +648,11 @@ static int __init riscv_fill_hwcap_from_ext_list(un=
signed long *isa2hwcap)
>  						     ext->property) < 0)
>  				continue;
> =20
> -			if (ext->subset_ext_size) {
> -				for (int j =3D 0; j < ext->subset_ext_size; j++) {
> -					if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
> -						set_bit(ext->subset_ext_ids[j], isainfo->isa);
> -				}
> -			}
> -
> -			if (riscv_isa_extension_check(ext->id)) {
> -				set_bit(ext->id, isainfo->isa);
> -
> -				/* Only single letter extensions get set in hwcap */
> -				if (strnlen(riscv_isa_ext[i].name, 2) =3D=3D 1)
> -					this_hwcap |=3D isa2hwcap[riscv_isa_ext[i].id];
> -			}
> +			riscv_isa_set_ext(ext, isa_bitmap);
>  		}
> =20
> +		riscv_resolve_isa(isa_bitmap, isainfo, &this_hwcap, isa2hwcap);
> +
>  		of_node_put(cpu_node);
> =20
>  		/*
> --=20
> 2.43.0
>=20

--gd7/nk5BpVfZAZKi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjAcGwAKCRB4tDGHoIJi
0pT4AP4kpeAwM643hQaOreeufIP87GLfG2CZSm6TigSWmM7XiQEAj71baUpHBbbR
Wd/42Ew6FGbxhqzfsiMcqhUbQeJTgwk=
=qQwN
-----END PGP SIGNATURE-----

--gd7/nk5BpVfZAZKi--

