Return-Path: <linux-kselftest+bounces-8923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209D78B3C2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 18:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1291F224CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 16:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F284414A60A;
	Fri, 26 Apr 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdhps90n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA06149C4B;
	Fri, 26 Apr 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147243; cv=none; b=XT6Vn2vJ0kgmLbpLtroIEmCTMf1WowI7JqUk5q0TT6GRK3WYw3itOFIGPXSF/cruzDZDNt8HloALn+Af0o/VX1EdMOZYJAGsOjBjRCjk89g/erFJH0r1Isi0cmCEuXAOAoveLDaiOv47W96+AyjDvGNhoM3pH1/0Y2vLkIjP6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147243; c=relaxed/simple;
	bh=UKvN2wqdYwQy09pu/qhnWflqex3IoAGs2WJzELlg6Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRI8dJs8SyvzDwThS+yMwc0p5XBxUR7PJjQCY3VJOriNEs3RcQiWhX7yYQZIbEnZu8bZExk6rfiGuaX8Qw03hj4bRPeYCwteqWVMN+4g5W0tG8zWU/Dfkg52BNrld6XTEudyR/4B8M/c+7vlOs/SALXzzLJ1SrCMrS2qD6kBs+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdhps90n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B07C113CD;
	Fri, 26 Apr 2024 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714147243;
	bh=UKvN2wqdYwQy09pu/qhnWflqex3IoAGs2WJzELlg6Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rdhps90nAvGB15Gl4zA0ihH/VZEzcpCpWyY3F2ToaDPEHEWvP0XSf462JNhwxd8sj
	 Iw4HYtt4AUvR321Pq8F+imU0pGuLjOrjvbAIO+qCE5+i/a3t/n+DRuZlX5dQBG7KWu
	 IeOqCFOSdtv5hzi1xkTIvq1XX6bJfAHxMBfi2kuwKjF2qjEsIBWCfhOxUm+XBRi7Lw
	 PXb03SL4tJ+dyhFCLfkE7yzYWW2muGW/cSs8NWxPLDBt1cKZfE2dd2Ma/IHDImgkUv
	 gREzezAZzBRLsvOd/heCl3/7HVn+0Bx/DNJLICNCtymDJ5Ru7tzM9BXB7DRX4zAGI7
	 1Ap9aT6BmGxsg==
Date: Fri, 26 Apr 2024 17:00:36 +0100
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
Subject: Re: [PATCH v3 07/17] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <20240426-blank-venus-3c902a2a0843@spud>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
 <20240420-dev-charlie-support_thead_vector_6_9-v3-7-67cff4271d1d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2rtR2VBIdFcn7ltG"
Content-Disposition: inline
In-Reply-To: <20240420-dev-charlie-support_thead_vector_6_9-v3-7-67cff4271d1d@rivosinc.com>


--2rtR2VBIdFcn7ltG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 06:04:39PM -0700, Charlie Jenkins wrote:
> Separate vendor extensions out into one struct per vendor
> instead of adding vendor extensions onto riscv_isa_ext.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig                               |  2 +
>  arch/riscv/Kconfig.vendor                        |  9 +++
>  arch/riscv/include/asm/cpufeature.h              | 18 ++++++
>  arch/riscv/include/asm/vendor_extensions.h       | 26 ++++++++
>  arch/riscv/include/asm/vendor_extensions/thead.h | 19 ++++++
>  arch/riscv/kernel/Makefile                       |  2 +
>  arch/riscv/kernel/cpufeature.c                   | 75 +++++++++++++++++-=
------
>  arch/riscv/kernel/vendor_extensions.c            | 18 ++++++
>  arch/riscv/kernel/vendor_extensions/Makefile     |  3 +
>  arch/riscv/kernel/vendor_extensions/thead.c      | 36 ++++++++++++
>  10 files changed, 188 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index be09c8836d56..fec86fba3acd 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -759,6 +759,8 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
> =20
>  endchoice
> =20
> +source "arch/riscv/Kconfig.vendor"
> +
>  endmenu # "Platform type"
> =20
>  menu "Kernel features"
> diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> new file mode 100644
> index 000000000000..d57254f28ea6
> --- /dev/null
> +++ b/arch/riscv/Kconfig.vendor
> @@ -0,0 +1,9 @@
> +config RISCV_ISA_VENDOR_EXT_THEAD
> +	bool "T-Head vendor extension support"
> +	default y
> +	help
> +	  Say N here if you want to disable all T-Head vendor extension
> +	  support. This will cause any T-Head vendor extensions that are
> +	  requested by hardware probing to be ignored.
> +
> +	  If you don't know what to do here, say Y.
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 809f61ffb667..db6a6d7d6b2e 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -35,6 +35,24 @@ extern u32 riscv_vlenb_dt[NR_CPUS];
> =20
>  void riscv_user_isa_enable(void);
> =20
> +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size)=
 {	\
> +	.name =3D #_name,								\
> +	.property =3D #_name,							\
> +	.id =3D _id,								\
> +	.subset_ext_ids =3D _subset_exts,						\
> +	.subset_ext_size =3D _subset_exts_size					\
> +}
> +
> +#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id,=
 NULL, 0)
> +
> +/* Used to declare pure "lasso" extension (Zk for instance) */
> +#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> +	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_=
SIZE(_bundled_exts))
> +
> +/* Used to declare extensions that are a superset of other extensions (Z=
vbb for instance) */
> +#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> +	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
> +
>  #if defined(CONFIG_RISCV_MISALIGNED)
>  bool check_unaligned_access_emulated_all_cpus(void);
>  void unaligned_emulation_finish(void);
> diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/incl=
ude/asm/vendor_extensions.h
> new file mode 100644
> index 000000000000..0af1ddd0af70
> --- /dev/null
> +++ b/arch/riscv/include/asm/vendor_extensions.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright 2024 Rivos, Inc
> + */
> +
> +#ifndef _ASM_VENDOR_EXTENSIONS_H
> +#define _ASM_VENDOR_EXTENSIONS_H
> +
> +#include <asm/cpufeature.h>
> +
> +#include <linux/array_size.h>
> +#include <linux/types.h>
> +
> +struct riscv_isa_vendor_ext_data_list {
> +	const struct riscv_isa_ext_data *ext_data;
> +	struct riscv_isainfo *per_hart_vendor_bitmap;
> +	unsigned long *vendor_bitmap;
> +	const size_t ext_data_count;
> +	const size_t bitmap_size;
> +};
> +
> +extern const struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext=
_list[];
> +
> +extern const size_t riscv_isa_vendor_ext_list_size;
> +
> +#endif /* _ASM_VENDOR_EXTENSIONS_H */
> diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/risc=
v/include/asm/vendor_extensions/thead.h
> new file mode 100644
> index 000000000000..92eec729888d
> --- /dev/null
> +++ b/arch/riscv/include/asm/vendor_extensions/thead.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
> +#define _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
> +
> +#include <asm/vendor_extensions.h>
> +
> +#include <linux/types.h>
> +
> +#define RISCV_ISA_VENDOR_EXT_XTHEADVECTOR		0
> +
> +/*
> + * Extension keys should be strictly less than max.
> + * It is safe to increment this when necessary.
> + */
> +#define RISCV_ISA_VENDOR_EXT_MAX_THEAD			32
> +
> +extern const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_=
list_thead;
> +
> +#endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 81d94a8ee10f..53361c50fb46 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -58,6 +58,8 @@ obj-y	+=3D riscv_ksyms.o
>  obj-y	+=3D stacktrace.o
>  obj-y	+=3D cacheinfo.o
>  obj-y	+=3D patch.o
> +obj-y	+=3D vendor_extensions.o
> +obj-y	+=3D vendor_extensions/
>  obj-y	+=3D probes/
>  obj-y	+=3D tests/
>  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index b537731cadef..c9f36822e337 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -24,6 +24,7 @@
>  #include <asm/processor.h>
>  #include <asm/sbi.h>
>  #include <asm/vector.h>
> +#include <asm/vendor_extensions.h>
> =20
>  #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
> =20
> @@ -102,24 +103,6 @@ static bool riscv_isa_extension_check(int id)
>  	return true;
>  }
> =20
> -#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size)=
 {	\
> -	.name =3D #_name,								\
> -	.property =3D #_name,							\
> -	.id =3D _id,								\
> -	.subset_ext_ids =3D _subset_exts,						\
> -	.subset_ext_size =3D _subset_exts_size					\
> -}
> -
> -#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id,=
 NULL, 0)
> -
> -/* Used to declare pure "lasso" extension (Zk for instance) */
> -#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> -	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_=
SIZE(_bundled_exts))
> -
> -/* Used to declare extensions that are a superset of other extensions (Z=
vbb for instance) */
> -#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> -	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
> -
>  static const unsigned int riscv_zk_bundled_exts[] =3D {
>  	RISCV_ISA_EXT_ZBKB,
>  	RISCV_ISA_EXT_ZBKC,
> @@ -353,6 +336,14 @@ static void __init riscv_parse_isa_string(unsigned l=
ong *this_hwcap, struct risc
>  		bool ext_long =3D false, ext_err =3D false;
> =20
>  		switch (*ext) {
> +		case 'x':
> +		case 'X':
> +			pr_warn("Vendor extensions are ignored in riscv,isa. Use riscv,isa-ex=
tensions instead.");

I think I pointed out before that this should only really warn once, not
once per extension per cpu. pr_warn_once() please.

> +			/*
> +			 * In canonical order, the remaining extensions in the
> +			 * isa string will be vendor extensions so exit.
> +			 */

Yeah, but the binding doesn't require canonical order, so please don't
exit & just move along to the next extension.

> +			break;
>  		case 's':
>  			/*
>  			 * Workaround for invalid single-letter 's' & 'u' (QEMU).
> @@ -368,8 +359,6 @@ static void __init riscv_parse_isa_string(unsigned lo=
ng *this_hwcap, struct risc
>  			}
>  			fallthrough;
>  		case 'S':
> -		case 'x':
> -		case 'X':
>  		case 'z':
>  		case 'Z':
>  			/*
> @@ -580,6 +569,48 @@ static void __init riscv_fill_hwcap_from_isa_string(=
unsigned long *isa2hwcap)
>  		acpi_put_table((struct acpi_table_header *)rhct);
>  }
> =20
> +static void __init riscv_add_cpu_vendor_ext(struct device_node *cpu_node=
, int cpu)

Can we have a consistent naming here? The other functions are using
"fill".

> +{
> +	for (int i =3D 0; i < riscv_isa_vendor_ext_list_size; i++) {
> +		const struct riscv_isa_vendor_ext_data_list *ext_list =3D riscv_isa_ve=
ndor_ext_list[i];
> +
> +		for (int j =3D 0; j < ext_list->ext_data_count; j++) {
> +			const struct riscv_isa_ext_data ext =3D ext_list->ext_data[j];
> +			struct riscv_isainfo *isavendorinfo =3D &ext_list->per_hart_vendor_bi=
tmap[cpu];
> +
> +			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
> +						     ext.property) < 0)
> +				continue;
> +
> +			/*
> +			 * Assume that subset extensions are all members of the
> +			 * same vendor.
> +			 */
> +			if (ext.subset_ext_size)
> +				for (int k =3D 0; k < ext.subset_ext_size; k++)
> +					set_bit(ext.subset_ext_ids[k], isavendorinfo->isa);
> +
> +			set_bit(ext.id, isavendorinfo->isa);
> +		}
> +	}
> +}
> +
> +static void __init set_riscv_isa_vendor(int cpu)

Again, consistent naming here would have riscv_isa_set...
And it's not setting a vendor, can you pick a name that matches the
action that the function is actually taking please?
riscv_isa_set_vendor_bitmask() or w/e.

Also, you've added Kconfig options for the different vendors but this
code is unconditionally compiled. Do we need to have a hidden Kconfig
option that all of the vendor options select that gets all of this new
code culled when none of them are enabled? Could just be as simple as
if (!IS_ENABLED(CONFIG_FOO))
	return;
in these functions in cpufeature.c?

> +{
> +	for (int i =3D 0; i < riscv_isa_vendor_ext_list_size; i++) {
> +		const struct riscv_isa_vendor_ext_data_list *ext_list =3D riscv_isa_ve=
ndor_ext_list[i];
> +
> +		if (bitmap_empty(ext_list->vendor_bitmap, ext_list->bitmap_size))
> +			bitmap_copy(ext_list->vendor_bitmap,
> +				    ext_list->per_hart_vendor_bitmap[cpu].isa,
> +				    ext_list->bitmap_size);
> +		else
> +			bitmap_and(ext_list->vendor_bitmap, ext_list->vendor_bitmap,
> +				   ext_list->per_hart_vendor_bitmap[cpu].isa,
> +				   ext_list->bitmap_size);
> +	}
> +}
> +
>  static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwca=
p)
>  {
>  	unsigned int cpu;
> @@ -623,6 +654,8 @@ static int __init riscv_fill_hwcap_from_ext_list(unsi=
gned long *isa2hwcap)
>  			}
>  		}
> =20
> +		riscv_add_cpu_vendor_ext(cpu_node, cpu);
> +
>  		of_node_put(cpu_node);
> =20
>  		/*
> @@ -638,6 +671,8 @@ static int __init riscv_fill_hwcap_from_ext_list(unsi=
gned long *isa2hwcap)
>  			bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
>  		else
>  			bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
> +
> +		set_riscv_isa_vendor(cpu);
>  	}
> =20
>  	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
> diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/ve=
ndor_extensions.c
> new file mode 100644
> index 000000000000..f76cb3013c2d
> --- /dev/null
> +++ b/arch/riscv/kernel/vendor_extensions.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2024 Rivos, Inc
> + */
> +
> +#include <asm/vendor_extensions.h>
> +#include <asm/vendor_extensions/thead.h>
> +
> +#include <linux/array_size.h>
> +#include <linux/types.h>
> +
> +const struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[]=
 =3D {
> +#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
> +	&riscv_isa_vendor_ext_list_thead,
> +#endif
> +};
> +
> +const size_t riscv_isa_vendor_ext_list_size =3D ARRAY_SIZE(riscv_isa_ven=
dor_ext_list);
> diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/ke=
rnel/vendor_extensions/Makefile
> new file mode 100644
> index 000000000000..3383066baaab
> --- /dev/null
> +++ b/arch/riscv/kernel/vendor_extensions/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)	+=3D thead.o
> diff --git a/arch/riscv/kernel/vendor_extensions/thead.c b/arch/riscv/ker=
nel/vendor_extensions/thead.c
> new file mode 100644
> index 000000000000..a0a47414ed22
> --- /dev/null
> +++ b/arch/riscv/kernel/vendor_extensions/thead.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <asm/cpufeature.h>
> +#include <asm/vendor_extensions.h>
> +#include <asm/vendor_extensions/thead.h>
> +
> +#include <linux/array_size.h>
> +#include <linux/types.h>
> +
> +/* All T-Head vendor extensions supported in Linux */
> +const struct riscv_isa_ext_data riscv_isa_vendor_ext_thead[] =3D {
> +	_RISCV_ISA_EXT_DATA(xtheadvector, RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, NU=
LL, 0),
> +};
> +
> +/*
> + * The first member of this struct must be a bitmap named isa so it can =
be
> + * compatible with riscv_isainfo even though the sizes of the bitmaps ma=
y be
> + * different.
> + */
> +struct riscv_isavendorinfo_thead {
> +	DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
> +};
> +
> +/* Hart specific T-Head vendor extension support */
> +static struct riscv_isavendorinfo_thead hart_vendorinfo_thead[NR_CPUS];
> +
> +/* Set of T-Head vendor extensions supported on all harts */
> +DECLARE_BITMAP(vendorinfo_thead, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
> +
> +const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_th=
ead =3D {
> +	.ext_data =3D riscv_isa_vendor_ext_thead,
> +	.per_hart_vendor_bitmap =3D (struct riscv_isainfo *)hart_vendorinfo_the=
ad,
> +	.vendor_bitmap =3D vendorinfo_thead,
> +	.ext_data_count =3D ARRAY_SIZE(riscv_isa_vendor_ext_thead),
> +	.bitmap_size =3D RISCV_ISA_VENDOR_EXT_MAX_THEAD
> +};
>=20
> --=20
> 2.44.0
>=20

--2rtR2VBIdFcn7ltG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZivPpAAKCRB4tDGHoIJi
0iiIAQDi3Ga8wKhviEiVR066I+z0PpDhTc8XrV9nKF7e8El8wQD+KikaPz7Bg03w
FCxOkfQyWHAZyJPLkbdhGxAa5NObTAk=
=HVWe
-----END PGP SIGNATURE-----

--2rtR2VBIdFcn7ltG--

