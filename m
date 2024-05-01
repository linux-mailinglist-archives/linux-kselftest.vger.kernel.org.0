Return-Path: <linux-kselftest+bounces-9219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E30E8B8E67
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 18:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265EDB20C41
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BE7E554;
	Wed,  1 May 2024 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rVdd41fB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1D8DDC3
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581897; cv=none; b=W0lGYa22lWCw6Zo25Hk/1JcWxa1v2xxPRJLSPGeEv/Y+BJ+DuSUhG2hdkwv1PnOFAanB4WudUnMrw2+RhKaTnnPaf09/PAap/lO95hexjpJG/FUaWkFK++Uz5MlXDE1BVbVCxLosunwfr3s/g3A8L0nblIDNk5jUCrBC5eVXhp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581897; c=relaxed/simple;
	bh=ZU1Y1IkYSP6w7StVTrBck8oe3WqI+kbnV6UZ9dW1yqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nE++9C8arPW1ALg4STWWnZFpWcpTm6HFiHneOsFX2/DhVpXwMPp9iDVuvqpe2DhNN95BxVzNlJRF0loEhA6Li30IIpzWHHFu8dUv0Jn338lYrM3D7UxmDtfmour8v8z8hpQovzgOZQNqAbX2CSaTM0MCc4yAAY1O/utkjTIk1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rVdd41fB; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e1a02af4aaso7465731fa.0
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714581892; x=1715186692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIWMmqnTjgErL9OLwt3NQMkkU2mTDcp42sUE4KhYx8k=;
        b=rVdd41fBQDiJpS4ocxAy1MJx12ZMpNZCsZ4eY8NS7+AeLinOE38WwkZjRqdP6GMMuw
         Yua36H+YMuhLh67XW70NRft4A+y707MsXelJfv9ZAmQRGxfISmnpUO39F+hdw080E/U7
         jiGKwq4n5OPljLDr9BkQJF6P+FZPO6VcmNsumABXnXF+q4XfnVq8l6f1Tx8+W0dp9Rlq
         OAMVXff4c/NLtJCHEvSKcS8UxOH22gI/h/akHfHVPcw2tl7wXcTZkjsctEXNIeNknShQ
         ORg/y9aSY3sfanJUMO3qyEdV7Rh3Rfw3fLnFDrjDu/gg4v8wfLq0y+jS6sFNHNx1pBXM
         cYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714581892; x=1715186692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIWMmqnTjgErL9OLwt3NQMkkU2mTDcp42sUE4KhYx8k=;
        b=KLizADdXxAWo39nS/C3cWZvC0KwH1sk4XwBS02A6GQXkGLSz+8oamutbBTkZPV0cMx
         3mRXt4g4WBe9nw8XvzrmY3uT+w3iMr46Z3JHDUW7/XP5shtJdiA2VH0tS1spKi4PmkI4
         2v6Sv/ctkx2yMHhbsYezhbQASA66DX2jPC9ID6lJrOhUo1PyTVSlSvukOKCxzjNwqs6B
         K9Tzu8nPyBdKuYCpd0TzhwVaIrvVydBjmzDE1GHJIQTrdQFIK1t25SOugDG8pRCgEBdJ
         nrdEWDpaBeT1fBHe79nMQ7ZrhvBgoRB9t+eTJfiakEO+1LdngHEYAgz9tl93CK+bnHVY
         Z7jw==
X-Forwarded-Encrypted: i=1; AJvYcCVLEhIZ4ZBdvOygoSPx/uD6VkWvYpC7Xrx7ArMqUNkcaM5e8dfZO9M7uP7HJM0OH+EuR/aMGhbGDpWvu7O7tcMpzWs7S2Ejox2SPN3xS/vL
X-Gm-Message-State: AOJu0YydG4XgITTMtiMK8gY2YNg98yxp4OeyDqcIuWSIaWDNzmt6yw9S
	fwQp7zG0vppHHdu57CzVDvwO7zdtdo4ykVUh7dKJU5QxAggp10j6BE26foRExc0ghXyQUmD4Th0
	t2gp4w/1J62oUERVoKE4vRoQgETmBhPrXYAvu3A==
X-Google-Smtp-Source: AGHT+IGNGr0Vfi7RwQP0lbA1+oJdc24tg9zNJVwzmKVPGSBxaExuuL+ZMNuz9kr2WrI5dHDiuXPyNIqhejqVg5SfIfg=
X-Received: by 2002:a05:6512:1388:b0:51d:9291:6945 with SMTP id
 fc8-20020a056512138800b0051d92916945mr3097857lfb.44.1714581892127; Wed, 01
 May 2024 09:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Wed, 1 May 2024 09:44:15 -0700
Message-ID: <CALs-HstM64Hy_=XVz=0sWQt=8j1u+bq6RhthUuD3P0E4=HyvcA@mail.gmail.com>
Subject: Re: [PATCH v4 05/16] riscv: Extend cpufeature.c to detect vendor extensions
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:29=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Separate vendor extensions out into one struct per vendor
> instead of adding vendor extensions onto riscv_isa_ext.
>
> Add a hidden config RISCV_ISA_VENDOR_EXT to conditionally include this
> code.
>
> The xtheadvector vendor extension is added using these changes.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig                               |  2 +
>  arch/riscv/Kconfig.vendor                        | 19 ++++++
>  arch/riscv/include/asm/cpufeature.h              | 18 ++++++
>  arch/riscv/include/asm/vendor_extensions.h       | 26 ++++++++
>  arch/riscv/include/asm/vendor_extensions/thead.h | 19 ++++++
>  arch/riscv/kernel/Makefile                       |  2 +
>  arch/riscv/kernel/cpufeature.c                   | 77 ++++++++++++++++++=
------
>  arch/riscv/kernel/vendor_extensions.c            | 18 ++++++
>  arch/riscv/kernel/vendor_extensions/Makefile     |  3 +
>  arch/riscv/kernel/vendor_extensions/thead.c      | 36 +++++++++++
>  10 files changed, 200 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index be09c8836d56..fec86fba3acd 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -759,6 +759,8 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
>
>  endchoice
>
> +source "arch/riscv/Kconfig.vendor"
> +
>  endmenu # "Platform type"
>
>  menu "Kernel features"
> diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> new file mode 100644
> index 000000000000..4fc86810af1d
> --- /dev/null
> +++ b/arch/riscv/Kconfig.vendor
> @@ -0,0 +1,19 @@
> +menu "Vendor extensions"
> +
> +config RISCV_ISA_VENDOR_EXT
> +       bool
> +
> +menu "T-Head"
> +config RISCV_ISA_VENDOR_EXT_THEAD
> +       bool "T-Head vendor extension support"
> +       select RISCV_ISA_VENDOR_EXT
> +       default y
> +       help
> +         Say N here if you want to disable all T-Head vendor extension
> +         support. This will cause any T-Head vendor extensions that are
> +         requested to be ignored.
> +
> +         If you don't know what to do here, say Y.
> +endmenu
> +
> +endmenu
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 0c4f08577015..fedd479ccfd1 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -35,6 +35,24 @@ extern u32 riscv_vlenb_of;
>
>  void riscv_user_isa_enable(void);
>
> +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size)=
 {     \
> +       .name =3D #_name,                                                =
         \
> +       .property =3D #_name,                                            =
         \
> +       .id =3D _id,                                                     =
         \
> +       .subset_ext_ids =3D _subset_exts,                                =
         \
> +       .subset_ext_size =3D _subset_exts_size                           =
         \
> +}
> +
> +#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id,=
 NULL, 0)
> +
> +/* Used to declare pure "lasso" extension (Zk for instance) */
> +#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> +       _RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, =
ARRAY_SIZE(_bundled_exts))
> +
> +/* Used to declare extensions that are a superset of other extensions (Z=
vbb for instance) */
> +#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> +       _RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
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
> +       const struct riscv_isa_ext_data *ext_data;
> +       struct riscv_isainfo *per_hart_vendor_bitmap;
> +       unsigned long *vendor_bitmap;

It took a lot of digging for me to understand this was the set of
vendor extensions supported on all harts. Can we add that to the name,
maybe something like isa_bitmap_all_harts? (I wonder if we could drop
the vendor part of the name since we already know we're in a
vendor_ext_data_list structure).

> +       const size_t ext_data_count;
> +       const size_t bitmap_size;
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
> +#define RISCV_ISA_VENDOR_EXT_XTHEADVECTOR              0
> +
> +/*
> + * Extension keys should be strictly less than max.
> + * It is safe to increment this when necessary.
> + */
> +#define RISCV_ISA_VENDOR_EXT_MAX_THEAD                 32
> +
> +extern const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_=
list_thead;
> +
> +#endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 81d94a8ee10f..53361c50fb46 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -58,6 +58,8 @@ obj-y +=3D riscv_ksyms.o
>  obj-y  +=3D stacktrace.o
>  obj-y  +=3D cacheinfo.o
>  obj-y  +=3D patch.o
> +obj-y  +=3D vendor_extensions.o
> +obj-y  +=3D vendor_extensions/
>  obj-y  +=3D probes/
>  obj-y  +=3D tests/
>  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 8158f34c3e36..c073494519eb 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -24,6 +24,7 @@
>  #include <asm/processor.h>
>  #include <asm/sbi.h>
>  #include <asm/vector.h>
> +#include <asm/vendor_extensions.h>
>
>  #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
>
> @@ -102,24 +103,6 @@ static bool riscv_isa_extension_check(int id)
>         return true;
>  }
>
> -#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size)=
 {     \
> -       .name =3D #_name,                                                =
         \
> -       .property =3D #_name,                                            =
         \
> -       .id =3D _id,                                                     =
         \
> -       .subset_ext_ids =3D _subset_exts,                                =
         \
> -       .subset_ext_size =3D _subset_exts_size                           =
         \
> -}
> -
> -#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id,=
 NULL, 0)
> -
> -/* Used to declare pure "lasso" extension (Zk for instance) */
> -#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> -       _RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, =
ARRAY_SIZE(_bundled_exts))
> -
> -/* Used to declare extensions that are a superset of other extensions (Z=
vbb for instance) */
> -#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> -       _RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
> -
>  static const unsigned int riscv_zk_bundled_exts[] =3D {
>         RISCV_ISA_EXT_ZBKB,
>         RISCV_ISA_EXT_ZBKC,
> @@ -353,6 +336,10 @@ static void __init riscv_parse_isa_string(unsigned l=
ong *this_hwcap, struct risc
>                 bool ext_long =3D false, ext_err =3D false;
>
>                 switch (*ext) {
> +               case 'x':
> +               case 'X':
> +                       pr_warn_once("Vendor extensions are ignored in ri=
scv,isa. Use riscv,isa-extensions instead.");
> +                       continue;
>                 case 's':
>                         /*
>                          * Workaround for invalid single-letter 's' & 'u'=
 (QEMU).
> @@ -368,8 +355,6 @@ static void __init riscv_parse_isa_string(unsigned lo=
ng *this_hwcap, struct risc
>                         }
>                         fallthrough;
>                 case 'S':
> -               case 'x':
> -               case 'X':
>                 case 'z':
>                 case 'Z':
>                         /*
> @@ -572,6 +557,54 @@ static void __init riscv_fill_hwcap_from_isa_string(=
unsigned long *isa2hwcap)
>                 acpi_put_table((struct acpi_table_header *)rhct);
>  }
>
> +static void __init riscv_fill_cpu_vendor_ext(struct device_node *cpu_nod=
e, int cpu)
> +{
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> +               return;
> +
> +       for (int i =3D 0; i < riscv_isa_vendor_ext_list_size; i++) {
> +               const struct riscv_isa_vendor_ext_data_list *ext_list =3D=
 riscv_isa_vendor_ext_list[i];
> +
> +               for (int j =3D 0; j < ext_list->ext_data_count; j++) {
> +                       const struct riscv_isa_ext_data ext =3D ext_list-=
>ext_data[j];
> +                       struct riscv_isainfo *isavendorinfo =3D &ext_list=
->per_hart_vendor_bitmap[cpu];
> +
> +                       if (of_property_match_string(cpu_node, "riscv,isa=
-extensions",
> +                                                    ext.property) < 0)
> +                               continue;
> +
> +                       /*
> +                        * Assume that subset extensions are all members =
of the
> +                        * same vendor.
> +                        */
> +                       if (ext.subset_ext_size)
> +                               for (int k =3D 0; k < ext.subset_ext_size=
; k++)
> +                                       set_bit(ext.subset_ext_ids[k], is=
avendorinfo->isa);
> +
> +                       set_bit(ext.id, isavendorinfo->isa);
> +               }

This loop seems super similar to the regular one (in
riscv_fill_hwcap_from_ext_list() in the random, possibly old, kernel I
have open). Could we refactor these together into a common helper? The
other loop has an extra stanza for riscv_isa_extension_check(), so
we'd have to add an extra condition there, but otherwise it looks
pretty compatible?

> +       }
> +}
> +
> +static void __init riscv_fill_vendor_ext_list(int cpu)
> +{
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> +               return;
> +
> +       for (int i =3D 0; i < riscv_isa_vendor_ext_list_size; i++) {
> +               const struct riscv_isa_vendor_ext_data_list *ext_list =3D=
 riscv_isa_vendor_ext_list[i];
> +
> +               if (bitmap_empty(ext_list->vendor_bitmap, ext_list->bitma=
p_size))
> +                       bitmap_copy(ext_list->vendor_bitmap,
> +                                   ext_list->per_hart_vendor_bitmap[cpu]=
.isa,
> +                                   ext_list->bitmap_size);

Could you get into trouble here if the set of vendor extensions
reduces to zero, and then becomes non-zero? To illustrate, consider
these masks:
cpu 0: 0x0000C000
cpu 1: 0x00000003 <<< vendor_bitmap ANDs out to 0
cpu 2: 0x00000010 <<< oops, we end up copying this into vendor_bitmap

> +               else
> +                       bitmap_and(ext_list->vendor_bitmap, ext_list->ven=
dor_bitmap,
> +                                  ext_list->per_hart_vendor_bitmap[cpu].=
isa,
> +                                  ext_list->bitmap_size);
> +       }
> +}
> +
>  static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwca=
p)
>  {
>         unsigned int cpu;
> @@ -615,6 +648,8 @@ static int __init riscv_fill_hwcap_from_ext_list(unsi=
gned long *isa2hwcap)
>                         }
>                 }
>
> +               riscv_fill_cpu_vendor_ext(cpu_node, cpu);
> +
>                 of_node_put(cpu_node);
>
>                 /*
> @@ -630,6 +665,8 @@ static int __init riscv_fill_hwcap_from_ext_list(unsi=
gned long *isa2hwcap)
>                         bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EX=
T_MAX);
>                 else
>                         bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RI=
SCV_ISA_EXT_MAX);
> +
> +               riscv_fill_vendor_ext_list(cpu);
>         }
>
>         if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
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
> +       &riscv_isa_vendor_ext_list_thead,
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
> +obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)       +=3D thead.o
> diff --git a/arch/riscv/kernel/vendor_extensions/thead.c b/arch/riscv/ker=
nel/vendor_extensions/thead.c
> new file mode 100644
> index 000000000000..edb20b928c0c
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
> +       __RISCV_ISA_EXT_DATA(xtheadvector, RISCV_ISA_VENDOR_EXT_XTHEADVEC=
TOR),
> +};
> +
> +/*
> + * The first member of this struct must be a bitmap named isa so it can =
be
> + * compatible with riscv_isainfo even though the sizes of the bitmaps ma=
y be
> + * different.
This is kinda yucky, as you're casting a bitmap of a different size
into a struct riscv_isainfo *, which has a known size. I don't
necessarily have a fabulous suggestion to fix though. The best I can
come up with is refactor struct riscv_isainfo to be:
struct riscv_isainfo {
    int count;
    unsigned long isa[0];
};

then declare a standard one (for hart_isa, which is statically allocated):
struct riscv_std_isainfo {
    int count;
    DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
}

and a thead one
struct riscv_thead_isainfo {
    int count;
    DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
}

But there's still a cast in there, as you'd cast the specialized
structs to struct riscv_isainfo *. But at least the size is in there
to be enforced at runtime, rather than a compile-time check that's
wrong.  So I'll just leave this half baked thought here, and maybe you
can think of a cleaner way, or ignore it :).


> + */
> +struct riscv_isavendorinfo_thead {
> +       DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
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
> +       .ext_data =3D riscv_isa_vendor_ext_thead,
> +       .per_hart_vendor_bitmap =3D (struct riscv_isainfo *)hart_vendorin=
fo_thead,
> +       .vendor_bitmap =3D vendorinfo_thead,
> +       .ext_data_count =3D ARRAY_SIZE(riscv_isa_vendor_ext_thead),
> +       .bitmap_size =3D RISCV_ISA_VENDOR_EXT_MAX_THEAD
> +};
>
> --
> 2.44.0
>

