Return-Path: <linux-kselftest+bounces-9232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C8A8B8F5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 20:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB9EB20EB9
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBE91474B1;
	Wed,  1 May 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nO6lUNjo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B8146D7E
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586752; cv=none; b=kdMZayAmeoM9gMxJ+B+kaBc3PXt5t/oQWhI5jWcA+AQmIZy2MkEw1fn70Yd76re3S9W7lU29spEU9eTYGmrAwWMGOwK0e4GJ7cC/QyVW//BaSZNuorHQvqKYdX5itHc6bCPFqPulVZWQvFOUnl+NOwFWFrL7hRhXNOz5/NX+JEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586752; c=relaxed/simple;
	bh=w8Rj1BhyqEydEv6JCfeBcl5BaJZdvCZo61P16SRZ3Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWukeFSNdqB6Qq7gom288omTMGpfUjmZ8ESJZ4NqqmixhWQc7sYAaCMzSclB+9+rDLFrHTwT37GOYcWLc81KlIeGcFLHUS5n+5ZWKASoeu07xoXqhNGFCguK/6GpSzRbGxom3mMe2KSBGkrrrWx53nlQR4nGkiJcCTrG1xWr3j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nO6lUNjo; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51e75e7a267so2000062e87.2
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714586748; x=1715191548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VahwDwqTPr6lw4jebHGEssYhZLJmVZQjghg0WnawSuQ=;
        b=nO6lUNjoVMSfS27fxtghtnx7C15JB9nrFXZv8UTynGIwJPmEjgtuPl64pIrlnKLYgY
         NrnKgqLEp0RnDbDQ6SNzzIsOYtcylCvCvptJ4r8jjZv5GiNhuu3U1VgfHu0jkgkGedDT
         DThkM6ult7YQ9iXItuVPdd4KSr7oyRcfxGLoxOOT0KqVdr2v40VyCwjsTW0MSlAh1Hg9
         wUyPR8XbnZrKyahMKIFc6ZZ9346XT/Ix849R5w1NqDPrjlSLUPiPIhg9Dbg/GI4UODe8
         9BRF/ARCmU44ry/UaLAjjT4rwRZOQIN2nbalCilZk0ZO+0NLI1MKLOO2dhxOiLgPraBb
         24ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714586748; x=1715191548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VahwDwqTPr6lw4jebHGEssYhZLJmVZQjghg0WnawSuQ=;
        b=lYkRg8li1VBdaETg7MaGpb5I/FYYjMGXDw1RTI1X2v+9cO8JdjqXeE0DylAcBCN8V0
         VJHDmdCrEysUdCVl67Ym3xcMW6KLEMSsxT911pkHCm5WUVQ4n/EOrEqvCtn5w5xQE4TU
         r7wKOJFKAqN3K8/C/vALkBVhsMX85oyrbdToxlaEhwK/yPoXvq+qoOUVdHJIAFXiRuhf
         moyV/wiGWh4Hg8JsYdII2snKq88FfBV81To24/y93vcNtOTtoFjOiFLeMfx+EKt1uhPZ
         X1NRNrcHknqVOLBBh0UUTUAL+sUXbTQZauqFXyHODWiT2GRO0yyk/ejOHYMqnpium5EB
         Otkw==
X-Forwarded-Encrypted: i=1; AJvYcCWHyGuFCexIQaMA67EX7w9RtKSlZBMfHCUEJlB1naIKy7fyS/xt1vxrBcpkG5H7d/nj50N9Qo0ktNqg15uOnhgSKE+TXrsoXGJrPcYKef40
X-Gm-Message-State: AOJu0YyLQqLbqIP6YA13itY25SXE/htSy3a+GYjo6faZ6OgnefrxVw/B
	AGMDhLvJ1YqLDAN/oTpL2QsLJ3ilPEej2qZM/ptnLYFOj7rc5RGMeAF6q4SljsYCWuG2DJh0gLg
	oqjFFd/Ikmcyt//sza0dYUU5zcamG+PxlW2Kbdw==
X-Google-Smtp-Source: AGHT+IG+nVH0UCyIn9op79QdDJ6K16iCWB2RQioTCyq5A2338sDdsx8RJE7NE8jnhFdnNrvDho28pmGcBF6R98nLwis=
X-Received: by 2002:a19:ca53:0:b0:51b:396e:2880 with SMTP id
 h19-20020a19ca53000000b0051b396e2880mr1910884lfj.63.1714586747664; Wed, 01
 May 2024 11:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
 <CALs-HstM64Hy_=XVz=0sWQt=8j1u+bq6RhthUuD3P0E4=HyvcA@mail.gmail.com> <ZjKBKg5zzikR5ngl@ghost>
In-Reply-To: <ZjKBKg5zzikR5ngl@ghost>
From: Evan Green <evan@rivosinc.com>
Date: Wed, 1 May 2024 11:05:11 -0700
Message-ID: <CALs-Hst77M4DBDdrNh5P733bVpKwHSf38P=UU0NVadA8X7xTkA@mail.gmail.com>
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

On Wed, May 1, 2024 at 10:51=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Wed, May 01, 2024 at 09:44:15AM -0700, Evan Green wrote:
> > On Fri, Apr 26, 2024 at 2:29=E2=80=AFPM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > >
> > > Separate vendor extensions out into one struct per vendor
> > > instead of adding vendor extensions onto riscv_isa_ext.
> > >
> > > Add a hidden config RISCV_ISA_VENDOR_EXT to conditionally include thi=
s
> > > code.
> > >
> > > The xtheadvector vendor extension is added using these changes.
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/Kconfig                               |  2 +
> > >  arch/riscv/Kconfig.vendor                        | 19 ++++++
> > >  arch/riscv/include/asm/cpufeature.h              | 18 ++++++
> > >  arch/riscv/include/asm/vendor_extensions.h       | 26 ++++++++
> > >  arch/riscv/include/asm/vendor_extensions/thead.h | 19 ++++++
> > >  arch/riscv/kernel/Makefile                       |  2 +
> > >  arch/riscv/kernel/cpufeature.c                   | 77 ++++++++++++++=
++++------
> > >  arch/riscv/kernel/vendor_extensions.c            | 18 ++++++
> > >  arch/riscv/kernel/vendor_extensions/Makefile     |  3 +
> > >  arch/riscv/kernel/vendor_extensions/thead.c      | 36 +++++++++++
> > >  10 files changed, 200 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index be09c8836d56..fec86fba3acd 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -759,6 +759,8 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > >
> > >  endchoice
> > >
> > > +source "arch/riscv/Kconfig.vendor"
> > > +
> > >  endmenu # "Platform type"
> > >
> > >  menu "Kernel features"
> > > diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> > > new file mode 100644
> > > index 000000000000..4fc86810af1d
> > > --- /dev/null
> > > +++ b/arch/riscv/Kconfig.vendor
> > > @@ -0,0 +1,19 @@
> > > +menu "Vendor extensions"
> > > +
> > > +config RISCV_ISA_VENDOR_EXT
> > > +       bool
> > > +
> > > +menu "T-Head"
> > > +config RISCV_ISA_VENDOR_EXT_THEAD
> > > +       bool "T-Head vendor extension support"
> > > +       select RISCV_ISA_VENDOR_EXT
> > > +       default y
> > > +       help
> > > +         Say N here if you want to disable all T-Head vendor extensi=
on
> > > +         support. This will cause any T-Head vendor extensions that =
are
> > > +         requested to be ignored.
> > > +
> > > +         If you don't know what to do here, say Y.
> > > +endmenu
> > > +
> > > +endmenu
> > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include=
/asm/cpufeature.h
> > > index 0c4f08577015..fedd479ccfd1 100644
> > > --- a/arch/riscv/include/asm/cpufeature.h
> > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > @@ -35,6 +35,24 @@ extern u32 riscv_vlenb_of;
> > >
> > >  void riscv_user_isa_enable(void);
> > >
> > > +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_s=
ize) {     \
> > > +       .name =3D #_name,                                            =
             \
> > > +       .property =3D #_name,                                        =
             \
> > > +       .id =3D _id,                                                 =
             \
> > > +       .subset_ext_ids =3D _subset_exts,                            =
             \
> > > +       .subset_ext_size =3D _subset_exts_size                       =
             \
> > > +}
> > > +
> > > +#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, =
_id, NULL, 0)
> > > +
> > > +/* Used to declare pure "lasso" extension (Zk for instance) */
> > > +#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> > > +       _RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_ex=
ts, ARRAY_SIZE(_bundled_exts))
> > > +
> > > +/* Used to declare extensions that are a superset of other extension=
s (Zvbb for instance) */
> > > +#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> > > +       _RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_ex=
ts))
> > > +
> > >  #if defined(CONFIG_RISCV_MISALIGNED)
> > >  bool check_unaligned_access_emulated_all_cpus(void);
> > >  void unaligned_emulation_finish(void);
> > > diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/=
include/asm/vendor_extensions.h
> > > new file mode 100644
> > > index 000000000000..0af1ddd0af70
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/vendor_extensions.h
> > > @@ -0,0 +1,26 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright 2024 Rivos, Inc
> > > + */
> > > +
> > > +#ifndef _ASM_VENDOR_EXTENSIONS_H
> > > +#define _ASM_VENDOR_EXTENSIONS_H
> > > +
> > > +#include <asm/cpufeature.h>
> > > +
> > > +#include <linux/array_size.h>
> > > +#include <linux/types.h>
> > > +
> > > +struct riscv_isa_vendor_ext_data_list {
> > > +       const struct riscv_isa_ext_data *ext_data;
> > > +       struct riscv_isainfo *per_hart_vendor_bitmap;
> > > +       unsigned long *vendor_bitmap;
> >
> > It took a lot of digging for me to understand this was the set of
> > vendor extensions supported on all harts. Can we add that to the name,
> > maybe something like isa_bitmap_all_harts? (I wonder if we could drop
> > the vendor part of the name since we already know we're in a
> > vendor_ext_data_list structure).
>
> Sure, I figured it was implied since the other bitmap says "per_hart",
> but I can see how it could be confusing.
>
> >
> > > +       const size_t ext_data_count;
> > > +       const size_t bitmap_size;
> > > +};
> > > +
> > > +extern const struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor=
_ext_list[];
> > > +
> > > +extern const size_t riscv_isa_vendor_ext_list_size;
> > > +
> > > +#endif /* _ASM_VENDOR_EXTENSIONS_H */
> > > diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/=
riscv/include/asm/vendor_extensions/thead.h
> > > new file mode 100644
> > > index 000000000000..92eec729888d
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/vendor_extensions/thead.h
> > > @@ -0,0 +1,19 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
> > > +#define _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
> > > +
> > > +#include <asm/vendor_extensions.h>
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +#define RISCV_ISA_VENDOR_EXT_XTHEADVECTOR              0
> > > +
> > > +/*
> > > + * Extension keys should be strictly less than max.
> > > + * It is safe to increment this when necessary.
> > > + */
> > > +#define RISCV_ISA_VENDOR_EXT_MAX_THEAD                 32
> > > +
> > > +extern const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_=
ext_list_thead;
> > > +
> > > +#endif
> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index 81d94a8ee10f..53361c50fb46 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -58,6 +58,8 @@ obj-y +=3D riscv_ksyms.o
> > >  obj-y  +=3D stacktrace.o
> > >  obj-y  +=3D cacheinfo.o
> > >  obj-y  +=3D patch.o
> > > +obj-y  +=3D vendor_extensions.o
> > > +obj-y  +=3D vendor_extensions/
> > >  obj-y  +=3D probes/
> > >  obj-y  +=3D tests/
> > >  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufe=
ature.c
> > > index 8158f34c3e36..c073494519eb 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -24,6 +24,7 @@
> > >  #include <asm/processor.h>
> > >  #include <asm/sbi.h>
> > >  #include <asm/vector.h>
> > > +#include <asm/vendor_extensions.h>
> > >
> > >  #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
> > >
> > > @@ -102,24 +103,6 @@ static bool riscv_isa_extension_check(int id)
> > >         return true;
> > >  }
> > >
> > > -#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_s=
ize) {     \
> > > -       .name =3D #_name,                                            =
             \
> > > -       .property =3D #_name,                                        =
             \
> > > -       .id =3D _id,                                                 =
             \
> > > -       .subset_ext_ids =3D _subset_exts,                            =
             \
> > > -       .subset_ext_size =3D _subset_exts_size                       =
             \
> > > -}
> > > -
> > > -#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, =
_id, NULL, 0)
> > > -
> > > -/* Used to declare pure "lasso" extension (Zk for instance) */
> > > -#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> > > -       _RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_ex=
ts, ARRAY_SIZE(_bundled_exts))
> > > -
> > > -/* Used to declare extensions that are a superset of other extension=
s (Zvbb for instance) */
> > > -#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> > > -       _RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_ex=
ts))
> > > -
> > >  static const unsigned int riscv_zk_bundled_exts[] =3D {
> > >         RISCV_ISA_EXT_ZBKB,
> > >         RISCV_ISA_EXT_ZBKC,
> > > @@ -353,6 +336,10 @@ static void __init riscv_parse_isa_string(unsign=
ed long *this_hwcap, struct risc
> > >                 bool ext_long =3D false, ext_err =3D false;
> > >
> > >                 switch (*ext) {
> > > +               case 'x':
> > > +               case 'X':
> > > +                       pr_warn_once("Vendor extensions are ignored i=
n riscv,isa. Use riscv,isa-extensions instead.");
> > > +                       continue;
> > >                 case 's':
> > >                         /*
> > >                          * Workaround for invalid single-letter 's' &=
 'u' (QEMU).
> > > @@ -368,8 +355,6 @@ static void __init riscv_parse_isa_string(unsigne=
d long *this_hwcap, struct risc
> > >                         }
> > >                         fallthrough;
> > >                 case 'S':
> > > -               case 'x':
> > > -               case 'X':
> > >                 case 'z':
> > >                 case 'Z':
> > >                         /*
> > > @@ -572,6 +557,54 @@ static void __init riscv_fill_hwcap_from_isa_str=
ing(unsigned long *isa2hwcap)
> > >                 acpi_put_table((struct acpi_table_header *)rhct);
> > >  }
> > >
> > > +static void __init riscv_fill_cpu_vendor_ext(struct device_node *cpu=
_node, int cpu)
> > > +{
> > > +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> > > +               return;
> > > +
> > > +       for (int i =3D 0; i < riscv_isa_vendor_ext_list_size; i++) {
> > > +               const struct riscv_isa_vendor_ext_data_list *ext_list=
 =3D riscv_isa_vendor_ext_list[i];
> > > +
> > > +               for (int j =3D 0; j < ext_list->ext_data_count; j++) =
{
> > > +                       const struct riscv_isa_ext_data ext =3D ext_l=
ist->ext_data[j];
> > > +                       struct riscv_isainfo *isavendorinfo =3D &ext_=
list->per_hart_vendor_bitmap[cpu];
> > > +
> > > +                       if (of_property_match_string(cpu_node, "riscv=
,isa-extensions",
> > > +                                                    ext.property) < =
0)
> > > +                               continue;
> > > +
> > > +                       /*
> > > +                        * Assume that subset extensions are all memb=
ers of the
> > > +                        * same vendor.
> > > +                        */
> > > +                       if (ext.subset_ext_size)
> > > +                               for (int k =3D 0; k < ext.subset_ext_=
size; k++)
> > > +                                       set_bit(ext.subset_ext_ids[k]=
, isavendorinfo->isa);
> > > +
> > > +                       set_bit(ext.id, isavendorinfo->isa);
> > > +               }
> >
> > This loop seems super similar to the regular one (in
> > riscv_fill_hwcap_from_ext_list() in the random, possibly old, kernel I
> > have open). Could we refactor these together into a common helper? The
> > other loop has an extra stanza for riscv_isa_extension_check(), so
> > we'd have to add an extra condition there, but otherwise it looks
> > pretty compatible?
> >
>
> I actually did have this refactored into a single function in a previous
> version but broke it back up since I felt there just wasn't enough
> overlap. The one for standard extensions is:
>
>         for (int i =3D 0; i < riscv_isa_ext_count; i++) {
>                 const struct riscv_isa_ext_data *ext =3D &riscv_isa_ext[i=
];
>
>                 if (of_property_match_string(cpu_node, "riscv,isa-extensi=
ons",
>                                              ext->property) < 0)
>                         continue;
>
>                 if (ext->subset_ext_size) {
>                         for (int j =3D 0; j < ext->subset_ext_size; j++) =
{
>                                 if (riscv_isa_extension_check(ext->subset=
_ext_ids[i]))
>                                         set_bit(ext->subset_ext_ids[j], i=
sainfo->isa);
>                         }
>                 }
>
>                 if (riscv_isa_extension_check(ext->id)) {
>                         set_bit(ext->id, isainfo->isa);
>
>                         /* Only single letter extensions get set in hwcap=
 */
>                         if (strnlen(riscv_isa_ext[i].name, 2) =3D=3D 1)
>                                 this_hwcap |=3D isa2hwcap[riscv_isa_ext[i=
].id];
>                 }
>         }
>
> The motivating reason why I didn't combine them was the additional
> `struct riscv_isa_vendor_ext_data_list *` data type for the vendor
> version which contains ext and isainfo. This can probably be combined in
> a straight-forward way though.

I see what you mean. There might be a way to reconfigure the structs
to make this work better, but yeah, those slight differences make it
hard to extract a common bit.

>
> > > +       }
> > > +}
> > > +
> > > +static void __init riscv_fill_vendor_ext_list(int cpu)
> > > +{
> > > +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> > > +               return;
> > > +
> > > +       for (int i =3D 0; i < riscv_isa_vendor_ext_list_size; i++) {
> > > +               const struct riscv_isa_vendor_ext_data_list *ext_list=
 =3D riscv_isa_vendor_ext_list[i];
> > > +
> > > +               if (bitmap_empty(ext_list->vendor_bitmap, ext_list->b=
itmap_size))
> > > +                       bitmap_copy(ext_list->vendor_bitmap,
> > > +                                   ext_list->per_hart_vendor_bitmap[=
cpu].isa,
> > > +                                   ext_list->bitmap_size);
> >
> > Could you get into trouble here if the set of vendor extensions
> > reduces to zero, and then becomes non-zero? To illustrate, consider
> > these masks:
> > cpu 0: 0x0000C000
> > cpu 1: 0x00000003 <<< vendor_bitmap ANDs out to 0
> > cpu 2: 0x00000010 <<< oops, we end up copying this into vendor_bitmap
> >
>
> Huh that's a good point. The standard extensions have that same bug too?
>
>         if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
>                 bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
>         else
>                 bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_=
EXT_MAX);
>

Ah crap you're right. What clown introduced that code? Oh,  me. I'm
not aware of anything heterogenous yet, so hopefully we can just
quietly fix it.

>
> > > +               else
> > > +                       bitmap_and(ext_list->vendor_bitmap, ext_list-=
>vendor_bitmap,
> > > +                                  ext_list->per_hart_vendor_bitmap[c=
pu].isa,
> > > +                                  ext_list->bitmap_size);
> > > +       }
> > > +}
> > > +
> > >  static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2=
hwcap)
> > >  {
> > >         unsigned int cpu;
> > > @@ -615,6 +648,8 @@ static int __init riscv_fill_hwcap_from_ext_list(=
unsigned long *isa2hwcap)
> > >                         }
> > >                 }
> > >
> > > +               riscv_fill_cpu_vendor_ext(cpu_node, cpu);
> > > +
> > >                 of_node_put(cpu_node);
> > >
> > >                 /*
> > > @@ -630,6 +665,8 @@ static int __init riscv_fill_hwcap_from_ext_list(=
unsigned long *isa2hwcap)
> > >                         bitmap_copy(riscv_isa, isainfo->isa, RISCV_IS=
A_EXT_MAX);
> > >                 else
> > >                         bitmap_and(riscv_isa, riscv_isa, isainfo->isa=
, RISCV_ISA_EXT_MAX);
> > > +
> > > +               riscv_fill_vendor_ext_list(cpu);
> > >         }
> > >
> > >         if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
> > > diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kerne=
l/vendor_extensions.c
> > > new file mode 100644
> > > index 000000000000..f76cb3013c2d
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/vendor_extensions.c
> > > @@ -0,0 +1,18 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright 2024 Rivos, Inc
> > > + */
> > > +
> > > +#include <asm/vendor_extensions.h>
> > > +#include <asm/vendor_extensions/thead.h>
> > > +
> > > +#include <linux/array_size.h>
> > > +#include <linux/types.h>
> > > +
> > > +const struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_li=
st[] =3D {
> > > +#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
> > > +       &riscv_isa_vendor_ext_list_thead,
> > > +#endif
> > > +};
> > > +
> > > +const size_t riscv_isa_vendor_ext_list_size =3D ARRAY_SIZE(riscv_isa=
_vendor_ext_list);
> > > diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/risc=
v/kernel/vendor_extensions/Makefile
> > > new file mode 100644
> > > index 000000000000..3383066baaab
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/vendor_extensions/Makefile
> > > @@ -0,0 +1,3 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)       +=3D thead.o
> > > diff --git a/arch/riscv/kernel/vendor_extensions/thead.c b/arch/riscv=
/kernel/vendor_extensions/thead.c
> > > new file mode 100644
> > > index 000000000000..edb20b928c0c
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/vendor_extensions/thead.c
> > > @@ -0,0 +1,36 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +#include <asm/cpufeature.h>
> > > +#include <asm/vendor_extensions.h>
> > > +#include <asm/vendor_extensions/thead.h>
> > > +
> > > +#include <linux/array_size.h>
> > > +#include <linux/types.h>
> > > +
> > > +/* All T-Head vendor extensions supported in Linux */
> > > +const struct riscv_isa_ext_data riscv_isa_vendor_ext_thead[] =3D {
> > > +       __RISCV_ISA_EXT_DATA(xtheadvector, RISCV_ISA_VENDOR_EXT_XTHEA=
DVECTOR),
> > > +};
> > > +
> > > +/*
> > > + * The first member of this struct must be a bitmap named isa so it =
can be
> > > + * compatible with riscv_isainfo even though the sizes of the bitmap=
s may be
> > > + * different.
> > This is kinda yucky, as you're casting a bitmap of a different size
> > into a struct riscv_isainfo *, which has a known size. I don't
> > necessarily have a fabulous suggestion to fix though. The best I can
> > come up with is refactor struct riscv_isainfo to be:
> > struct riscv_isainfo {
> >     int count;
> >     unsigned long isa[0];
> > };
> >
> > then declare a standard one (for hart_isa, which is statically allocate=
d):
> > struct riscv_std_isainfo {
> >     int count;
> >     DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
> > }
> >
> > and a thead one
> > struct riscv_thead_isainfo {
> >     int count;
> >     DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
> > }
> >
> > But there's still a cast in there, as you'd cast the specialized
> > structs to struct riscv_isainfo *. But at least the size is in there
> > to be enforced at runtime, rather than a compile-time check that's
> > wrong.  So I'll just leave this half baked thought here, and maybe you
> > can think of a cleaner way, or ignore it :).
>
> Yes perhaps this is a better way of doing it.
>
> - Charlie
>
> >
> >
> > > + */
> > > +struct riscv_isavendorinfo_thead {
> > > +       DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
> > > +};
> > > +
> > > +/* Hart specific T-Head vendor extension support */
> > > +static struct riscv_isavendorinfo_thead hart_vendorinfo_thead[NR_CPU=
S];
> > > +
> > > +/* Set of T-Head vendor extensions supported on all harts */
> > > +DECLARE_BITMAP(vendorinfo_thead, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
> > > +
> > > +const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_lis=
t_thead =3D {
> > > +       .ext_data =3D riscv_isa_vendor_ext_thead,
> > > +       .per_hart_vendor_bitmap =3D (struct riscv_isainfo *)hart_vend=
orinfo_thead,
> > > +       .vendor_bitmap =3D vendorinfo_thead,
> > > +       .ext_data_count =3D ARRAY_SIZE(riscv_isa_vendor_ext_thead),
> > > +       .bitmap_size =3D RISCV_ISA_VENDOR_EXT_MAX_THEAD
> > > +};
> > >
> > > --
> > > 2.44.0
> > >

