Return-Path: <linux-kselftest+bounces-9377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96C8BB0E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2328D1F21B9C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E00156647;
	Fri,  3 May 2024 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TKfvy8u8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1054C155396
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753745; cv=none; b=FNueRGjK4U+S7YnnqoPwd+rJF5lx6f+tgX3b3iPin89rFizB4Nv0Jrh81iUhBt+bOUXNeHJcEa2lLR9L9toLW9aSrMzMlUS9OvEo39USKNzF5Reu3h0jx31C+ADwpGm+e28qws3i6KKVCS9RYq91nlk99M7QZNeb7lIubZjruWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753745; c=relaxed/simple;
	bh=+gJrURUGg8vTjavvnvTV30xxUQYc3d46PCw+cBhsEmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktWjEi9nPg/O7MqT2Flit7RTZfAicdZZK0brBRnv4PqENjaLOZNBmGW+RKiE3wJHZtCRxDtF1sGN7U6shB6mH8szafryHfapheGJY4QZPDQ+B1yJYkCTNpwqiEJMrK+RyEQ7904A6sDbGU0WS2Q+ClXsnHfnlxKgA+1tJf7ifPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TKfvy8u8; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f57713684so2136781e87.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714753741; x=1715358541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcJ+k0H6/m0Cv9X3Vbvj6SbMtSmOhVR/JgA1iQ66e10=;
        b=TKfvy8u82Aoba8D9OUVpQeWI3aGDz46ehlGm4H5xtSrbq2aDsDuGv6dlx/WLX2sIRk
         BS+91Abf3LMJCwmL2aOCQh4VTkF2K3zvV1TihwXD/dpuaeIlXJULDApdD/io7eq21Tl6
         tLMQdSUU0v8GFK3v+7VEuT4qHnc6ydBbHxtNElBCobJFldXqL0uO6bm0ghE+iTVFA6I7
         fqqPIZs3YW7RshvjbOFWiBTYgQmcqoQK7Ddk5qBfuVkNg28udBG+QbIdAp6JNlVkqjCV
         DL/y0WU4dxQfwrKTLaR80LG9hXmXd+Ev9OddgGtrRmJJxag6+vW66CoFslSrhDgJgxbf
         790A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714753741; x=1715358541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcJ+k0H6/m0Cv9X3Vbvj6SbMtSmOhVR/JgA1iQ66e10=;
        b=pLxawoi6MJb4YiftyQ+YbRflTzVi0gjHA0NkqBulHCnHbofZSZysSrYxQNm9X4LfsM
         V70z3XY2jNBSIN5m2zDFsQgbNMcRBjchcNRKce8/vXPnNiG+tnkkGyM7XKyAGcziAp5B
         2eF61sDGd8H69cT6vOyKxyKN/5GUz9lZ1chjTfMgJd9rpzNmu29Q/ZNTAZTIToJQYloe
         YdX64cDZ/PWw6aslTlZoVZMQsXKPEyrdbhiZtcx6VitPzB/ISFwNY3Azzose+nz1ckjL
         Jif/r5pqSxQWHftsJsz/CCLbmrzDwPLYXUrhde7MnccGjbxUt5qXYxOpo4yESGgKQJrK
         mxeg==
X-Forwarded-Encrypted: i=1; AJvYcCWW/m3oh2nnmoKtcOJ+7wV2r3EzRd+SG0pmmyKzMfTwvfDNz6ZIFCOQ8xGxmD01aXEWc8jO/GTq6zo/yM/TOoPcu3z9YCTf0g9yp1GMLZZI
X-Gm-Message-State: AOJu0YyWZ+2I1XUycweW9j/t+LWMVLV7NrZ87u7cUeFDkF146lhcAtez
	nhudxMCnSMyZrT7ppa0DVBOGEZuluKsF/0rmRYIiLa2CxkjneZ/kKr5T1umlU/EmvsZg4/iALpY
	PFGKfDs8fWxOa/nRmXpWB2a6/vKPCQrEFCDGP/w==
X-Google-Smtp-Source: AGHT+IFtdP67COLORBthU+58PbG7sbgN360zM6O7Llu9lr3w+NSo/oXEx4BQXw+Mu92MLwTVGUQE6PDxBjuL9iQgMRY=
X-Received: by 2002:ac2:4959:0:b0:51d:abb3:d701 with SMTP id
 o25-20020ac24959000000b0051dabb3d701mr2283308lfi.5.1714753740901; Fri, 03 May
 2024 09:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
 <20240502-dev-charlie-support_thead_vector_6_9-v5-5-d1b5c013a966@rivosinc.com>
In-Reply-To: <20240502-dev-charlie-support_thead_vector_6_9-v5-5-d1b5c013a966@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 3 May 2024 09:28:24 -0700
Message-ID: <CALs-Hsvt4f4hP--6Wb8QAYM20dPFegRj-GeaD7hoJiW1ZY+w4Q@mail.gmail.com>
Subject: Re: [PATCH v5 05/17] riscv: Extend cpufeature.c to detect vendor extensions
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

On Thu, May 2, 2024 at 9:46=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
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
>  arch/riscv/Kconfig.vendor                        | 19 +++++
>  arch/riscv/include/asm/cpufeature.h              | 18 +++++
>  arch/riscv/include/asm/vendor_extensions.h       | 34 +++++++++
>  arch/riscv/include/asm/vendor_extensions/thead.h | 16 ++++
>  arch/riscv/kernel/Makefile                       |  2 +
>  arch/riscv/kernel/cpufeature.c                   | 93 ++++++++++++++++++=
+-----
>  arch/riscv/kernel/vendor_extensions.c            | 18 +++++
>  arch/riscv/kernel/vendor_extensions/Makefile     |  3 +
>  arch/riscv/kernel/vendor_extensions/thead.c      | 18 +++++
>  10 files changed, 203 insertions(+), 20 deletions(-)
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
> index 000000000000..85ac30496b0e
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
> +         Say N here to disable detection of and support for all T-Head v=
endor
> +         extensions. Without this option enabled, T-Head vendor extensio=
ns will
> +         not be detected at boot and their presence not reported to user=
space.
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
> index 000000000000..bf4dac66e6e6
> --- /dev/null
> +++ b/arch/riscv/include/asm/vendor_extensions.h
> @@ -0,0 +1,34 @@
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
> +/*
> + * The extension keys of each vendor must be strictly less than this val=
ue.
> + */
> +#define RISCV_ISA_VENDOR_EXT_MAX 32
> +
> +struct riscv_isavendorinfo {
> +       DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX);
> +};

Nice, I think this was a good compromise: being honest with the
compiler about the fixed array sizes, with the tradeoff that all
vendors have to use the same ceiling for the number of bits. If one
vendor raises this ceiling absurdly and starts creating huge amounts
of waste we can revisit.

> +
> +struct riscv_isa_vendor_ext_data_list {
> +       const size_t ext_data_count;
> +       const struct riscv_isa_ext_data *ext_data;
> +       struct riscv_isavendorinfo per_hart_isa_bitmap[NR_CPUS];
> +       struct riscv_isavendorinfo all_harts_isa_bitmap;
> +};
> +
> +extern struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[=
];
> +
> +extern const size_t riscv_isa_vendor_ext_list_size;
> +
> +#endif /* _ASM_VENDOR_EXTENSIONS_H */
> diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/risc=
v/include/asm/vendor_extensions/thead.h
> new file mode 100644
> index 000000000000..48421d1553ad
> --- /dev/null
> +++ b/arch/riscv/include/asm/vendor_extensions/thead.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
> +#define _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
> +
> +#include <asm/vendor_extensions.h>
> +
> +#include <linux/types.h>
> +
> +/*
> + * Extension keys must be strictly less than RISCV_ISA_VENDOR_EXT_MAX.
> + */
> +#define RISCV_ISA_VENDOR_EXT_XTHEADVECTOR              0
> +
> +extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_t=
head;
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
> index 12c79db0b0bb..cc9ec393c8f6 100644
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
> @@ -353,6 +336,21 @@ static void __init riscv_parse_isa_string(unsigned l=
ong *this_hwcap, struct risc
>                 bool ext_long =3D false, ext_err =3D false;
>
>                 switch (*ext) {
> +               case 'x':
> +               case 'X':
> +                       if (acpi_disabled)
> +                               pr_warn_once("Vendor extensions are ignor=
ed in riscv,isa. Use riscv,isa-extensions instead.");
> +                       /*
> +                        * To skip an extension, we find its end.
> +                        * As multi-letter extensions must be split from =
other multi-letter
> +                        * extensions with an "_", the end of a multi-let=
ter extension will
> +                        * either be the null character or the "_" at the=
 start of the next
> +                        * multi-letter extension.
> +                        */
> +                       for (; *isa && *isa !=3D '_'; ++isa)
> +                               ;
> +                       ext_err =3D true;
> +                       break;
>                 case 's':
>                         /*
>                          * Workaround for invalid single-letter 's' & 'u'=
 (QEMU).
> @@ -368,8 +366,6 @@ static void __init riscv_parse_isa_string(unsigned lo=
ng *this_hwcap, struct risc
>                         }
>                         fallthrough;
>                 case 'S':
> -               case 'x':
> -               case 'X':
>                 case 'z':
>                 case 'Z':
>                         /*
> @@ -572,6 +568,59 @@ static void __init riscv_fill_hwcap_from_isa_string(=
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
> +               struct riscv_isa_vendor_ext_data_list *ext_list =3D riscv=
_isa_vendor_ext_list[i];
> +
> +               for (int j =3D 0; j < ext_list->ext_data_count; j++) {
> +                       const struct riscv_isa_ext_data ext =3D ext_list-=
>ext_data[j];
> +                       struct riscv_isavendorinfo *isavendorinfo =3D &ex=
t_list->per_hart_isa_bitmap[cpu];
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
> +       }
> +}
> +
> +static void __init riscv_fill_vendor_ext_list(int cpu)
> +{
> +       bool first =3D true;
> +
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> +               return;
> +
> +       for (int i =3D 0; i < riscv_isa_vendor_ext_list_size; i++) {
> +               struct riscv_isa_vendor_ext_data_list *ext_list =3D riscv=
_isa_vendor_ext_list[i];
> +
> +               if (first) {
> +                       bitmap_copy(ext_list->all_harts_isa_bitmap.isa,
> +                                   ext_list->per_hart_isa_bitmap[cpu].is=
a,
> +                                   RISCV_ISA_VENDOR_EXT_MAX);
> +                       first =3D false;

I think this is still not quite right. This behaves properly when
called on the first cpu (let's say 0), but then we call it again with
cpu 1, first gets set to true, and we clobber the old work we did for
cpu 0. If we knew that cpu 0 was always called first (this looks true
since both calls are within a for_each_possible_cpu() loop), and that
this was only called once at boot for cpu 0 (looks true, and
riscv_fill_hwcap() is __init), then it could be bool first =3D cpu =3D=3D 0=
.

