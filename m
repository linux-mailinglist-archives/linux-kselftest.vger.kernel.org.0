Return-Path: <linux-kselftest+bounces-20991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6759B51A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C681F24015
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5301D1DD546;
	Tue, 29 Oct 2024 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kDzdEMgG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129941DC739;
	Tue, 29 Oct 2024 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225645; cv=none; b=EA5qkZKQJj9ycd+eU5URskj8CxuyrLTh55S4wA+WOs+Edovrx4Fgn6nqVfKjUlqlXZaJt1PgVlduHO9SpbrO9aG6uYcd/SNDEyD1NfhjfcJbGHR6T3IwyyZKPm9+ScHkRXELI1kkyHgUVS93NEQFJuhEKztbrnDmMCdzpRnTcUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225645; c=relaxed/simple;
	bh=QCT6puWGo6Vk4tKrB2zmhFnVH4w2WVXlwIuR/KWT7pE=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=nL0grMn6PVWQ8Mkr1iy4VWZENAU09Ke4jeKPa7LtCUqr6zLtUToz8WSLp2ntJzhT1s36qUkVK7vQVv/8wPT6h84OfgBgbBDuCZuERrkhOhAU1jBt3P40sLPN7qrH4Y/wRJ1cb3mOY8o/eT6DcQHCEpo4RdBmbaujvmcwp1n/IvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kDzdEMgG; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730225635; bh=BoW6s+rUCxUCpZyfIxwEwxTIMi7q9DopWXIdFHkjBrE=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=kDzdEMgGLnGudJ4p2qDlXaP2aa74LsuU/PtvOR3MdxaAmgPsgS+7CZ4Q2R/ybiBE4
	 V2ivEza5MJdDE0zyBN5MCTQ5In2lpZ/JKQQz1piZlOL3pKesDcT8qPRkn/xpgGbZsl
	 xb4agPsU0POL5fKLjhS/EzkfwiwPTfUR/PJel5zU=
Received: from smtpclient.apple ([2408:8207:18a1:fd20:752a:71a:7814:8c66])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id 250884F; Wed, 30 Oct 2024 02:00:37 +0800
X-QQ-mid: xmsmtpt1730224837t1sqy8vre
Message-ID: <tencent_B953631642161A5BF9B004D1B4931C2D7109@qq.com>
X-QQ-XMAILINFO: M3cUO7vMX4chu1q7adTHRfrbAh6OiaqnsY91xlCkkq6QmsjwEojYKsEQB+6Ory
	 FWqX+3YSQqfTF1NE6Dr3UxffZuUlExaE/jTqRIUSVh6b834awdrxZAlCBkWN9WmSLfo85eoDPNua
	 xSvN1Uc71y6MIwlLQUDdJechzgXcBLF4SpehjEbgSTSG/nv2jk3fgjEJUBBt6RPxkO9UulvQ9d23
	 hTP53I6auLoCc2J3gNvOhGksS9+IScNYIVuZQJMwe9tnxssqE1YUnLh2KiHfYDzFmTPxzRijTQeX
	 7q4AHZsaYZD1q0Kt+4b2VmHNY8yQRx9SEXWGBce2Klqs77m3p6A7oCUPFZbUfHJD87shOsE5orhV
	 dVkdufvv61ZK5lfmAGSgUG/p2uogr4xDySgMZGh/41qVzAwVgyGE7Smu0OkG6z8NGWOM6JgrK4dd
	 TM7YU78HSogBmdMvRFG1TIrIl17UE090SMQHwJZPpHDfWbc3qCupVcZ8HTZoc6N281DTA2FuTeII
	 /gWijiIp6mx+K1RrOnvOD3SqYu8gYXq1u4BmYLbHAzEfc2Otr+fls8bEzHbWPavqtDIl+v2uv7eP
	 PI/f7zbvnpEmy7FRARb0V72PC+F+jLxInhkjZwU3/JgZfOAlbYFrZxXRQniZZ6yAdDBhI11KMGy6
	 Tk8ayl6U9z5Sfk8aGp/IbVobm9SifxFnDa56qS5sOc2VCUxjgCSpe2S89rpQSjiG90IHzhZPqnry
	 AjWdVwSHgF2qIk7gzdvxs1ed2rGxBRG5Lm63ZEYOzCVMrJYfqiIrSOkLnK9iuoneWJoyufZ7riHs
	 fL6U4QK/0fPv9ktofUkzKYumo2Lzp99bzKcQV1GxnIKfQSxBSlk3uuxZXTZlgcNZ0Y2r/Gg8bPkJ
	 PMZYvfA8k1bQFneDMIIEKAvKOzfpSfRY3o4XVYK5U80dWRB6pgyMkTNoDfkCgY06mp6wY8QT7Bx+
	 /zQCC9fVTmJKwelKTpUGELPaQx2xqGrJ+rXuSN0+43GyOTYOFtQj0JtmbO+kohwxdxe6BCFSRKrx
	 PzIKir29jqrNXU7ZfA
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v10 10/14] riscv: hwprobe: Add thead vendor extension
 probing
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240911-xtheadvector-v10-10-8d3930091246@rivosinc.com>
Date: Wed, 30 Oct 2024 02:00:26 +0800
Cc: linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev,
 linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <F7EC0D4B-419A-400B-BB28-CB0CC709DB6C@cyyself.name>
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
 <20240911-xtheadvector-v10-10-8d3930091246@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>,
 Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Samuel Holland <samuel.holland@sifive.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Evan Green <evan@rivosinc.com>,
 Andy Chiu <andy.chiu@sifive.com>,
 Jessica Clarke <jrtc27@jrtc27.com>,
 Andrew Jones <ajones@ventanamicro.com>
X-Mailer: Apple Mail (2.3826.200.121)


On 9/12/24 13:55, Charlie Jenkins wrote:
> Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0" which
> allows userspace to probe for the new =
RISCV_ISA_VENDOR_EXT_XTHEADVECTOR
> vendor extension.

I believe it's more advantageous to use RISCV_HWPROBE_KEY_VENDOR_EXT_0
to ensure that this key is shared with all vendors. Subsequently,
mhartid can select the specific vendor. Each vendor can allocate
its own extension space within the bitmask.

Therefore, we won't require the addition of a new hardware probe
key for a new vendor in the future.

RISC-V C-API chooses a similar design.

Link: =
https://github.com/riscv-non-isa/riscv-c-api-doc/blob/main/src/c-api.adoc#=
extension-bitmask

> This new key will allow userspace code to probe for which thead vendor
> extensions are supported. This API is modeled to be consistent with
> RISCV_HWPROBE_KEY_IMA_EXT_0. The bitmask returned will have each bit
> corresponding to a supported thead vendor extension of the cpumask =
set.
> Just like RISCV_HWPROBE_KEY_IMA_EXT_0, this allows a userspace program
> to determine all of the supported thead vendor extensions in one call.
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Evan Green <evan@rivosinc.com>
> ---
>  arch/riscv/include/asm/hwprobe.h                   |  3 +-
>  .../include/asm/vendor_extensions/thead_hwprobe.h  | 19 +++++++++++
>  .../include/asm/vendor_extensions/vendor_hwprobe.h | 37 =
++++++++++++++++++++++
>  arch/riscv/include/uapi/asm/hwprobe.h              |  3 +-
>  arch/riscv/include/uapi/asm/vendor/thead.h         |  3 ++
>  arch/riscv/kernel/sys_hwprobe.c                    |  5 +++
>  arch/riscv/kernel/vendor_extensions/Makefile       |  1 +
>  .../riscv/kernel/vendor_extensions/thead_hwprobe.c | 19 +++++++++++
>  8 files changed, 88 insertions(+), 2 deletions(-)
> diff --git a/arch/riscv/include/asm/hwprobe.h =
b/arch/riscv/include/asm/hwprobe.h
> index ef01c182af2b..6148e1eab64c 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>  /*
> - * Copyright 2023 Rivos, Inc
> + * Copyright 2023-2024 Rivos, Inc
>   */
>    #ifndef _ASM_HWPROBE_H
> @@ -21,6 +21,7 @@ static inline bool hwprobe_key_is_bitmask(__s64 key)
>  	case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
>  	case RISCV_HWPROBE_KEY_IMA_EXT_0:
>  	case RISCV_HWPROBE_KEY_CPUPERF_0:
> +	case RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0:
>  		return true;
>  	}
>  diff --git a/arch/riscv/include/asm/vendor_extensions/thead_hwprobe.h =
b/arch/riscv/include/asm/vendor_extensions/thead_hwprobe.h
> new file mode 100644
> index 000000000000..65a9c5612466
> --- /dev/null
> +++ b/arch/riscv/include/asm/vendor_extensions/thead_hwprobe.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_HWPROBE_H
> +#define _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_HWPROBE_H
> +
> +#include <linux/cpumask.h>
> +
> +#include <uapi/asm/hwprobe.h>
> +
> +#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
> +void hwprobe_isa_vendor_ext_thead_0(struct riscv_hwprobe *pair, const =
struct cpumask *cpus);
> +#else
> +static inline void hwprobe_isa_vendor_ext_thead_0(struct =
riscv_hwprobe *pair,
> +						  const struct cpumask =
*cpus)
> +{
> +	pair->value =3D 0;
> +}
> +#endif
> +
> +#endif
> diff --git a/arch/riscv/include/asm/vendor_extensions/vendor_hwprobe.h =
b/arch/riscv/include/asm/vendor_extensions/vendor_hwprobe.h
> new file mode 100644
> index 000000000000..6b9293e984a9
> --- /dev/null
> +++ b/arch/riscv/include/asm/vendor_extensions/vendor_hwprobe.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2024 Rivos, Inc
> + */
> +
> +#ifndef _ASM_RISCV_SYS_HWPROBE_H
> +#define _ASM_RISCV_SYS_HWPROBE_H
> +
> +#include <asm/cpufeature.h>
> +
> +#define VENDOR_EXT_KEY(ext)							=
	\
> +	do {									=
	\
> +		if (__riscv_isa_extension_available(isainfo->isa, =
RISCV_ISA_VENDOR_EXT_##ext)) \
> +			pair->value |=3D RISCV_HWPROBE_VENDOR_EXT_##ext;	=
		\
> +		else								=
	\
> +			missing |=3D RISCV_HWPROBE_VENDOR_EXT_##ext;		=
	\
> +	} while (false)
> +
> +/*
> + * Loop through and record extensions that 1) anyone has, and 2) =
anyone
> + * doesn't have.
> + *
> + * _extension_checks is an arbitrary C block to set the values of =
pair->value
> + * and missing. It should be filled with VENDOR_EXT_KEY expressions.
> + */
> +#define VENDOR_EXTENSION_SUPPORTED(pair, cpus, =
per_hart_vendor_bitmap, _extension_checks)	\
> +	do {									=
		\
> +		int cpu;							=
		\
> +		u64 missing =3D 0;						=
		\
> +		for_each_cpu(cpu, (cpus)) {					=
		\
> +			struct riscv_isavendorinfo *isainfo =3D =
&(per_hart_vendor_bitmap)[cpu];	\
> +			_extension_checks					=
		\
> +		}								=
		\
> +		(pair)->value &=3D ~missing;					=
		\
> +	} while (false)								=
		\
> +
> +#endif /* _ASM_RISCV_SYS_HWPROBE_H */
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h =
b/arch/riscv/include/uapi/asm/hwprobe.h
> index b706c8e47b02..452d0b84f17f 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>  /*
> - * Copyright 2023 Rivos, Inc
> + * Copyright 2023-2024 Rivos, Inc
>   */
>    #ifndef _UAPI_ASM_HWPROBE_H
> @@ -82,6 +82,7 @@ struct riscv_hwprobe {
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
>  #define RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS	7
>  #define RISCV_HWPROBE_KEY_TIME_CSR_FREQ	8
> +#define RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0	9
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>    /* Flags */
> diff --git a/arch/riscv/include/uapi/asm/vendor/thead.h =
b/arch/riscv/include/uapi/asm/vendor/thead.h
> new file mode 100644
> index 000000000000..43790ebe5faf
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/vendor/thead.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
> +#define		RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR	(1 << 0)
> diff --git a/arch/riscv/kernel/sys_hwprobe.c =
b/arch/riscv/kernel/sys_hwprobe.c
> index 8d1b5c35d2a7..5a3dc8e66c85 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -15,6 +15,7 @@
>  #include <asm/uaccess.h>
>  #include <asm/unistd.h>
>  #include <asm/vector.h>
> +#include <asm/vendor_extensions/thead_hwprobe.h>
>  #include <vdso/vsyscall.h>
>    @@ -241,6 +242,10 @@ static void hwprobe_one_pair(struct =
riscv_hwprobe *pair,
>  		pair->value =3D riscv_timebase;
>  		break;
>  +	case RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0:
> +		hwprobe_isa_vendor_ext_thead_0(pair, cpus);
> +		break;
> +
>  	/*
>  	 * For forward compatibility, unknown keys don't fail the whole
>  	 * call, but get their element key set to -1 and value set to 0
> diff --git a/arch/riscv/kernel/vendor_extensions/Makefile =
b/arch/riscv/kernel/vendor_extensions/Makefile
> index 353522cb3bf0..866414c81a9f 100644
> --- a/arch/riscv/kernel/vendor_extensions/Makefile
> +++ b/arch/riscv/kernel/vendor_extensions/Makefile
> @@ -2,3 +2,4 @@
>    obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_ANDES)	+=3D andes.o
>  obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)	+=3D thead.o
> +obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)	+=3D thead_hwprobe.o
> diff --git a/arch/riscv/kernel/vendor_extensions/thead_hwprobe.c =
b/arch/riscv/kernel/vendor_extensions/thead_hwprobe.c
> new file mode 100644
> index 000000000000..2eba34011786
> --- /dev/null
> +++ b/arch/riscv/kernel/vendor_extensions/thead_hwprobe.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <asm/vendor_extensions/thead.h>
> +#include <asm/vendor_extensions/thead_hwprobe.h>
> +#include <asm/vendor_extensions/vendor_hwprobe.h>
> +
> +#include <linux/cpumask.h>
> +#include <linux/types.h>
> +
> +#include <uapi/asm/hwprobe.h>
> +#include <uapi/asm/vendor/thead.h>
> +
> +void hwprobe_isa_vendor_ext_thead_0(struct riscv_hwprobe *pair, const =
struct cpumask *cpus)
> +{
> +	VENDOR_EXTENSION_SUPPORTED(pair, cpus,
> +				   =
riscv_isa_vendor_ext_list_thead.per_hart_isa_bitmap, {
> +		VENDOR_EXT_KEY(XTHEADVECTOR);
> +	});
> +}


