Return-Path: <linux-kselftest+bounces-8925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D418B3CA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 18:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4645F1C21AC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF529155A4D;
	Fri, 26 Apr 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DprtpMxP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6DA152DED;
	Fri, 26 Apr 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148407; cv=none; b=OFMl1G0iLydeRBz9gKcUwVucJrMAZkLz37SEEEGM5scKru4eSCx0Y3h7Xu0ae/GXZNglLViMtyK6qseCIaU8VckLQHJDD2CFuoYN7TQi9oEhT3OpNZs5hEiiQJ7UO9NQCESSj9ZDVMEXA+2FyNy08nLeqfBJMIuaGhqA9Mbb5aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148407; c=relaxed/simple;
	bh=56WtMGJIJ3UiLYSPbEWuCS3RnlwoCWtrcwQxOAteTrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPRDSZ4660hwZjG8MohhJEoDUsEXRyB3VLaeyAoujIx11l0VdKe1tyHGxyBpEaXIgHoLTn8MLyqB9pbBLDaErrTiUYGHV1l02rD9djHftYoJ3ZhQV4/zMChGC5kA/ihKJ0tIhR4meZzsAtqXw/5lpeCKCS1AyG+bwrEIHX7/1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DprtpMxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1ABC113CD;
	Fri, 26 Apr 2024 16:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714148406;
	bh=56WtMGJIJ3UiLYSPbEWuCS3RnlwoCWtrcwQxOAteTrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DprtpMxPygU6R7BOsk2YdZI27XPNWjnfXegOoEGNNlvmV5p5CczZ20ydwv0I0Wn+E
	 Miq1qmoQXUV6UXpQ2j+qfK/eIx5NbnX2uI1c3xFrBaJN1gic3VA2L1fGS7dUcnoxXr
	 xgUXfnibUDEFmawZ3BQHQJMFPWC586yQkKIKqYlaZP4pccOiQX8y5jxvQQ5O9HrPT2
	 e+LKmYPHdv9/SpZSY8VQfxbkOS/0ZMhk3Sb0RGImN6heeOF9WOwHjFYlk5A+wVkHGy
	 1xWjUPHHxTHyRylskSCuE9/YFTPAPaTR6BC+2fRER1cklgJ6r8h1kZ5oFvKAA91ilQ
	 MSvSZ/nFsXkSA==
Date: Fri, 26 Apr 2024 17:19:59 +0100
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
Subject: Re: [PATCH v3 08/17] riscv: Introduce vendor variants of extension
 helpers
Message-ID: <20240426-myself-crowbar-99dc0a080cd9@spud>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
 <20240420-dev-charlie-support_thead_vector_6_9-v3-8-67cff4271d1d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jv693WyFbu4Wa/qC"
Content-Disposition: inline
In-Reply-To: <20240420-dev-charlie-support_thead_vector_6_9-v3-8-67cff4271d1d@rivosinc.com>


--jv693WyFbu4Wa/qC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 06:04:40PM -0700, Charlie Jenkins wrote:
> Vendor extensions are maintained in per-vendor structs (separate from
> standard extensions which live in riscv_isa). Create vendor variants for
> the existing extension helpers to interface with the riscv_isa_vendor
> bitmaps.

> There is a good amount of overlap between these functions, so
> the alternative checking code can be factored out.

Can you please split this out?

>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/errata/sifive/errata.c          |  3 ++
>  arch/riscv/errata/thead/errata.c           |  3 ++
>  arch/riscv/include/asm/cpufeature.h        | 86 +++++++++++++++++-------=
------
>  arch/riscv/include/asm/vendor_extensions.h | 56 +++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c             | 20 ++++---
>  arch/riscv/kernel/vendor_extensions.c      | 40 ++++++++++++++
>  6 files changed, 164 insertions(+), 44 deletions(-)
>=20
> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive=
/errata.c
> index 3d9a32d791f7..b29b6e405ff2 100644
> --- a/arch/riscv/errata/sifive/errata.c
> +++ b/arch/riscv/errata/sifive/errata.c
> @@ -12,6 +12,7 @@
>  #include <asm/alternative.h>
>  #include <asm/vendorid_list.h>
>  #include <asm/errata_list.h>
> +#include <asm/vendor_extensions.h>
> =20
>  struct errata_info_t {
>  	char name[32];
> @@ -99,6 +100,8 @@ void sifive_errata_patch_func(struct alt_entry *begin,=
 struct alt_entry *end,
>  	for (alt =3D begin; alt < end; alt++) {
>  		if (alt->vendor_id !=3D SIFIVE_VENDOR_ID)
>  			continue;
> +		if (alt->patch_id >=3D RISCV_VENDOR_EXT_ALTERNATIVES_BASE)
> +			continue;
>  		if (alt->patch_id >=3D ERRATA_SIFIVE_NUMBER) {
>  			WARN(1, "This errata id:%d is not in kernel errata list", alt->patch_=
id);
>  			continue;
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index b1c410bbc1ae..d8e78cc687bc 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -18,6 +18,7 @@
>  #include <asm/io.h>
>  #include <asm/patch.h>
>  #include <asm/vendorid_list.h>
> +#include <asm/vendor_extensions.h>
> =20
>  static bool errata_probe_pbmt(unsigned int stage,
>  			      unsigned long arch_id, unsigned long impid)
> @@ -163,6 +164,8 @@ void thead_errata_patch_func(struct alt_entry *begin,=
 struct alt_entry *end,
>  	for (alt =3D begin; alt < end; alt++) {
>  		if (alt->vendor_id !=3D THEAD_VENDOR_ID)
>  			continue;
> +		if (alt->patch_id >=3D RISCV_VENDOR_EXT_ALTERNATIVES_BASE)
> +			continue;

>  		if (alt->patch_id >=3D ERRATA_THEAD_NUMBER)

This number is 2, how does the patching actually work for vendor stuff
when the base is always greater than 2?

>  			continue;
> =20
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index db6a6d7d6b2e..83e1143db9ad 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -103,22 +103,13 @@ bool __riscv_isa_extension_available(const unsigned=
 long *isa_bitmap, unsigned i
>  	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
> =20
>  static __always_inline bool
> -riscv_has_extension_likely(const unsigned long ext)
> +__riscv_has_extension_likely_alternatives(const unsigned long vendor, co=
nst unsigned long ext)
>  {
> -	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> -			   "ext must be < RISCV_ISA_EXT_MAX");
> -
> -	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> -		asm goto(
> -		ALTERNATIVE("j	%l[l_no]", "nop", 0, %[ext], 1)
> -		:
> -		: [ext] "i" (ext)
> -		:
> -		: l_no);
> -	} else {
> -		if (!__riscv_isa_extension_available(NULL, ext))
> -			goto l_no;
> -	}
> +	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
> +	:
> +	: [vendor] "i" (vendor), [ext] "i" (ext)
> +	:
> +	: l_no);
> =20
>  	return true;
>  l_no:
> @@ -126,42 +117,65 @@ riscv_has_extension_likely(const unsigned long ext)
>  }
> =20
>  static __always_inline bool
> -riscv_has_extension_unlikely(const unsigned long ext)
> +__riscv_has_extension_unlikely_alternatives(const unsigned long vendor, =
const unsigned long ext)

ngl, I think you could drop the _alternatives from these - the
likely/unlikely is only actually a thing because of the alternatives in
the first place & just retain the __ as a differentiator. That'd help
you with some of the long-line wrangling you've been doing below.

>  {
> -	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> -			   "ext must be < RISCV_ISA_EXT_MAX");
> -
> -	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> -		asm goto(
> -		ALTERNATIVE("nop", "j	%l[l_yes]", 0, %[ext], 1)
> -		:
> -		: [ext] "i" (ext)
> -		:
> -		: l_yes);
> -	} else {
> -		if (__riscv_isa_extension_available(NULL, ext))
> -			goto l_yes;
> -	}
> +	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
> +	:
> +	: [vendor] "i" (vendor), [ext] "i" (ext)
> +	:
> +	: l_yes);
> =20
>  	return false;
>  l_yes:
>  	return true;
>  }
> =20
> +static __always_inline bool
> +riscv_has_extension_likely(const unsigned long ext)

Can you format this so that its on one line & wrap the arguments if
needs be?

> +{
> +	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> +			   "ext must be < RISCV_ISA_EXT_MAX");
> +
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> +		return __riscv_has_extension_likely_alternatives(0, ext);
> +	else

I'm almost certain I said this before, but none of the else branches are
needed here, there's a return in the if branch, so the remainder of the
function becomes unconditionally executed.

> +		return __riscv_isa_extension_available(NULL, ext);
> +}
> +
> +static __always_inline bool
> +riscv_has_extension_unlikely(const unsigned long ext)
> +{
> +	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> +			   "ext must be < RISCV_ISA_EXT_MAX");
> +
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> +		return __riscv_has_extension_unlikely_alternatives(0, ext);
> +	else
> +		return __riscv_isa_extension_available(NULL, ext);
> +}
> +
>  static __always_inline bool riscv_cpu_has_extension_likely(int cpu, cons=
t unsigned long ext)
>  {
> -	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_likely(=
ext))
> -		return true;
> +	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> +			   "ext must be < RISCV_ISA_EXT_MAX");
> =20
> -	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
> +	    __riscv_has_extension_likely_alternatives(0, ext))

0 is meaningless, please make this more understandable using a define of
some sort.

> +		return true;
> +	else
> +		return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>  }
> =20
>  static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, co=
nst unsigned long ext)
>  {
> -	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_unlikel=
y(ext))
> -		return true;
> +	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> +			   "ext must be < RISCV_ISA_EXT_MAX");
> =20
> -	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
> +	    __riscv_has_extension_unlikely_alternatives(0, ext))
> +		return true;
> +	else
> +		return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>  }
> =20
>  #endif
> diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/incl=
ude/asm/vendor_extensions.h
> index 0af1ddd0af70..3e676a96016e 100644
> --- a/arch/riscv/include/asm/vendor_extensions.h
> +++ b/arch/riscv/include/asm/vendor_extensions.h
> @@ -23,4 +23,60 @@ extern const struct riscv_isa_vendor_ext_data_list *ri=
scv_isa_vendor_ext_list[];
> =20
>  extern const size_t riscv_isa_vendor_ext_list_size;
> =20
> +/*
> + * The alternatives need some way of distinguishing between vendor exten=
sions
> + * and errata. Incrementing all of the vendor extension keys so they are=
 at
> + * least 0x8000 accomplishes that.
> + */
> +#define RISCV_VENDOR_EXT_ALTERNATIVES_BASE	0x8000
> +
> +bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendo=
r, unsigned int bit);
> +#define riscv_cpu_isa_vendor_extension_available(cpu, vendor, ext)	\
> +	__riscv_isa_vendor_extension_available(cpu, vendor, RISCV_ISA_VENDOR_EX=
T_##ext)
> +#define riscv_isa_vendor_extension_available(vendor, ext)	\
> +	__riscv_isa_vendor_extension_available(-1, vendor, RISCV_ISA_VENDOR_EXT=
_##ext)
> +
> +static __always_inline bool
> +riscv_has_vendor_extension_likely(const unsigned long vendor, const unsi=
gned long ext)
> +{
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> +		return __riscv_has_extension_likely_alternatives(vendor,
> +								 ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
> +	else
> +		return __riscv_isa_vendor_extension_available(-1, vendor, ext);
> +}
> +
> +static __always_inline bool
> +riscv_has_vendor_extension_unlikely(const unsigned long vendor, const un=
signed long ext)
> +{
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> +		return __riscv_has_extension_unlikely_alternatives(vendor,
> +								   ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
> +	else
> +		return __riscv_isa_vendor_extension_available(-1, vendor, ext);
> +}
> +
> +static __always_inline bool riscv_cpu_has_vendor_extension_likely(const =
unsigned long vendor,
> +								  int cpu, const unsigned long ext)
> +{
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
> +	    __riscv_has_extension_likely_alternatives(vendor,
> +						      ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE))
> +		return true;
> +	else
> +		return __riscv_isa_vendor_extension_available(cpu, vendor, ext);
> +}
> +
> +static __always_inline bool riscv_cpu_has_vendor_extension_unlikely(cons=
t unsigned long vendor,
> +								    int cpu,
> +								    const unsigned long ext)
> +{
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
> +	    __riscv_has_extension_unlikely_alternatives(vendor,
> +							ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE))
> +		return true;
> +	else
> +		return __riscv_isa_vendor_extension_available(cpu, vendor, ext);
> +}
> +
>  #endif /* _ASM_VENDOR_EXTENSIONS_H */
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index c9f36822e337..17371887abcc 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -833,25 +833,29 @@ void __init_or_module riscv_cpufeature_patch_func(s=
truct alt_entry *begin,
>  {
>  	struct alt_entry *alt;
>  	void *oldptr, *altptr;
> -	u16 id, value;
> +	u16 id, value, vendor;
> =20
>  	if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
>  		return;
> =20
>  	for (alt =3D begin; alt < end; alt++) {
> -		if (alt->vendor_id !=3D 0)
> -			continue;
> -
>  		id =3D PATCH_ID_CPUFEATURE_ID(alt->patch_id);
> +		vendor =3D PATCH_ID_CPUFEATURE_ID(alt->vendor_id);
> =20
> -		if (id >=3D RISCV_ISA_EXT_MAX) {
> +		if (id < RISCV_ISA_EXT_MAX) {

I think any reliance on the standard ext max requires a comment
explaining what the interaction is between it and the vendor stuff.

> +			if (alt->vendor_id !=3D 0)
> +				continue;

If this happens, it's a bug, should we be continuing silently?

Cheers,
Conor.

> +
> +			if (!__riscv_isa_extension_available(NULL, id))
> +				continue;
> +		} else if (id >=3D RISCV_VENDOR_EXT_ALTERNATIVES_BASE) {
> +			if (!__riscv_isa_vendor_extension_available(-1, vendor, id))
> +				continue;
> +		} else {
>  			WARN(1, "This extension id:%d is not in ISA extension list", id);
>  			continue;
>  		}
> =20
> -		if (!__riscv_isa_extension_available(NULL, id))
> -			continue;
> -
>  		value =3D PATCH_ID_CPUFEATURE_VALUE(alt->patch_id);
>  		if (!riscv_cpufeature_patch_check(id, value))
>  			continue;
> diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/ve=
ndor_extensions.c
> index f76cb3013c2d..eced93eec5a6 100644
> --- a/arch/riscv/kernel/vendor_extensions.c
> +++ b/arch/riscv/kernel/vendor_extensions.c
> @@ -3,6 +3,7 @@
>   * Copyright 2024 Rivos, Inc
>   */
> =20
> +#include <asm/vendorid_list.h>
>  #include <asm/vendor_extensions.h>
>  #include <asm/vendor_extensions/thead.h>
> =20
> @@ -16,3 +17,42 @@ const struct riscv_isa_vendor_ext_data_list *riscv_isa=
_vendor_ext_list[] =3D {
>  };
> =20
>  const size_t riscv_isa_vendor_ext_list_size =3D ARRAY_SIZE(riscv_isa_ven=
dor_ext_list);
> +
> +/**
> + * __riscv_isa_vendor_extension_available() - Check whether given vendor
> + * extension is available or not.
> + *
> + * @cpu: check if extension is available on this cpu
> + * @vendor: vendor that the extension is a member of
> + * @bit: bit position of the desired extension
> + * Return: true or false
> + *
> + * NOTE: When cpu is -1, will check if extension is available on all cpus
> + */
> +bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendo=
r, unsigned int bit)
> +{
> +	unsigned long *bmap;
> +	struct riscv_isainfo *cpu_bmap;
> +	size_t bmap_size;
> +
> +	switch (vendor) {
> +#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
> +	case THEAD_VENDOR_ID:
> +		bmap =3D riscv_isa_vendor_ext_list_thead.vendor_bitmap;
> +		cpu_bmap =3D riscv_isa_vendor_ext_list_thead.per_hart_vendor_bitmap;
> +		bmap_size =3D riscv_isa_vendor_ext_list_thead.bitmap_size;
> +		break;
> +#endif
> +	default:
> +		return false;
> +	}
> +
> +	if (cpu !=3D -1)
> +		bmap =3D cpu_bmap[cpu].isa;
> +
> +	if (bit >=3D bmap_size)
> +		return false;
> +
> +	return test_bit(bit, bmap) ? true : false;
> +}
> +EXPORT_SYMBOL_GPL(__riscv_isa_vendor_extension_available);
>=20
> --=20
> 2.44.0
>=20

--jv693WyFbu4Wa/qC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZivULwAKCRB4tDGHoIJi
0rmCAQDxNUjTxzCWO2yTbBkX3ka4wFcFw+0BDHYBrwHlnxqvlQD9FA7aNnLm2V74
TE1rCjoHG207NtXTni6g+A9QL2Ua8AA=
=JuwY
-----END PGP SIGNATURE-----

--jv693WyFbu4Wa/qC--

