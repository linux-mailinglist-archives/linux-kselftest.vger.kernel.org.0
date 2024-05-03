Return-Path: <linux-kselftest+bounces-9383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66D08BB18A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057CA1C21CB3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 17:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706EC157E76;
	Fri,  3 May 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nxG27aE4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CF878276
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756454; cv=none; b=mq0+aGDI3pjMZQ6orbVtEFLtSkhheHqqda9avvmYhuEqMmJZ7BZuUKEfha3hnmKRi5QRzBYNlKWqa+ysXAU3Pch+B1qx5Tib7RaVzrqctCt5ZtYlPYlxLdEPKcmGukEIxLWT9FyoKZ1OLniPY5IW/sFwW/hqLPCZHCVTH3gfL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756454; c=relaxed/simple;
	bh=VqbxuL2baLIzYbfrTAmNijHnc1t1VmGpQcMxmdDkW7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWi5tCEAtbHlzPY4xgIckD8JrJiUuWcwXRdpDbTUo1kjKvlEfq4GRN/Gcn5P9eCZcbyOBrjQbxlO4nci1mA1mgxell/tA0Hu18MyOwKazUmy13nOx9rRrrXQm3q5xqInjM87Jy05/xGnCG2b+Q4NULB9D0V27bAkl/OVj1JkDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nxG27aE4; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e27277d2c1so8919921fa.2
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714756450; x=1715361250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NpJ72optyz8G7Vg8pem5t6PFMRwMWBPMKGxGrVBieY=;
        b=nxG27aE4dJYC96U2dYH/hOU1YLsTRoeIohSfYE+Jg/1608L1WA7IUr40q3FTVIMv0n
         qLoieL7NVdL5+9BLF2keX/plzYm+yV1Lf5finMYyBh/2LB8Wyotuhdh9rq1k/9UOkMWA
         N7lpELqgtRm5jMGouORneaw9+36dpTOZ50qaPeNMgiX0hGFzA4VUesAjdlGzGKRSTau9
         uwKjCPFAqwt3NkBnkqz8yzDXgdBvADKAp8dSv8K3VNmswYv4XwJ2xam9ynf39V+Nj0Yl
         7dROr7R6iPic8pSd041yQrhTpZ86m0TcGIMiTZ5MpCjUUIRhCk5AgXy+yNXukmS0NZT/
         uY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714756450; x=1715361250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NpJ72optyz8G7Vg8pem5t6PFMRwMWBPMKGxGrVBieY=;
        b=cPsjxKGCqxFylO1vguNAh16AmyId1GS8Mq6a9jHILB0TVDlStyDWqXZDNn1dkYxp30
         zw9ukGfVZbuCKEtpBHKi9EKirx9Ebm7SKaj2nTIH6ZP0P1cqlhOxWauRnGkZhSn3mFwb
         MeK4O45ZlsFKZbK9pK+33Y3XkoihFbPNU+4JUMfkC+0nuQdD+dkcG8HJ3eDBRTcro+mX
         tgP4RqR0kqXyzJVW/98aWNdk3G+lE+JdZt2mAD/MNIawgJR8C0TNb5LC5Tw2cRx0Ktft
         HtzpVrTKDiPQrd00VyHvCUjJU5hFs9nMUHLnkq/X0XPf00Zt51bahPzmK2MqVkU25U2A
         ruDA==
X-Forwarded-Encrypted: i=1; AJvYcCV3BOLVc6hyC2rMEXtX08TMTFc5o1fDSft49qJmuX8Qitm/f8r2KVOiR5Bll6m+1I7DRDGe9eNmiVY5THSXOOfJQvDwiqddjlEajMUMyjtr
X-Gm-Message-State: AOJu0YxjOtCa735RsWNpoGxvScZolmowwHqN7khXJYaoenQ2cLPcxIZY
	mOU2ajeydsO5yK6BAwjCctWbuNBxUxc3h0A0PhBVZlEupt+tIFyjukRdlWwmnc6pCD++QJjiIye
	05AjSVgqCCtBJ8FON+/z+x6ua0E39A5b0NuAOeg==
X-Google-Smtp-Source: AGHT+IFLlSgSvu4FKt4sQWvT+XWxVuZ49YKqpR25n2BvOQ9SG8anUerTK+/vJSnMQpZUSPGM3P7xPAkuzJFe2+SlZw0=
X-Received: by 2002:a2e:818f:0:b0:2df:9c94:150e with SMTP id
 e15-20020a2e818f000000b002df9c94150emr2107286ljg.25.1714756450296; Fri, 03
 May 2024 10:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
 <20240502-dev-charlie-support_thead_vector_6_9-v5-5-d1b5c013a966@rivosinc.com>
 <CALs-Hsvt4f4hP--6Wb8QAYM20dPFegRj-GeaD7hoJiW1ZY+w4Q@mail.gmail.com> <ZjUaGKhXaanBkHCY@ghost>
In-Reply-To: <ZjUaGKhXaanBkHCY@ghost>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 3 May 2024 10:13:33 -0700
Message-ID: <CALs-Hsu+idi7HsQA9cpXwhkByh6B5CzwwSQY+aTc6F=ntD1Kfw@mail.gmail.com>
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

On Fri, May 3, 2024 at 10:08=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Fri, May 03, 2024 at 09:28:24AM -0700, Evan Green wrote:
> > On Thu, May 2, 2024 at 9:46=E2=80=AFPM Charlie Jenkins <charlie@rivosin=
c.com> wrote:
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
> > >  arch/riscv/Kconfig.vendor                        | 19 +++++
> > >  arch/riscv/include/asm/cpufeature.h              | 18 +++++
> > >  arch/riscv/include/asm/vendor_extensions.h       | 34 +++++++++
> > >  arch/riscv/include/asm/vendor_extensions/thead.h | 16 ++++
> > >  arch/riscv/kernel/Makefile                       |  2 +
> > >  arch/riscv/kernel/cpufeature.c                   | 93 ++++++++++++++=
+++++-----
> > >  arch/riscv/kernel/vendor_extensions.c            | 18 +++++
> > >  arch/riscv/kernel/vendor_extensions/Makefile     |  3 +
> > >  arch/riscv/kernel/vendor_extensions/thead.c      | 18 +++++
> > >  10 files changed, 203 insertions(+), 20 deletions(-)
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
> > > index 000000000000..85ac30496b0e
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
> > > +         Say N here to disable detection of and support for all T-He=
ad vendor
> > > +         extensions. Without this option enabled, T-Head vendor exte=
nsions will
> > > +         not be detected at boot and their presence not reported to =
userspace.
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
> > > index 000000000000..bf4dac66e6e6
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/vendor_extensions.h
> > > @@ -0,0 +1,34 @@
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
> > > +/*
> > > + * The extension keys of each vendor must be strictly less than this=
 value.
> > > + */
> > > +#define RISCV_ISA_VENDOR_EXT_MAX 32
> > > +
> > > +struct riscv_isavendorinfo {
> > > +       DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX);
> > > +};
> >
> > Nice, I think this was a good compromise: being honest with the
> > compiler about the fixed array sizes, with the tradeoff that all
> > vendors have to use the same ceiling for the number of bits. If one
> > vendor raises this ceiling absurdly and starts creating huge amounts
> > of waste we can revisit.
> >
> > > +
> > > +struct riscv_isa_vendor_ext_data_list {
> > > +       const size_t ext_data_count;
> > > +       const struct riscv_isa_ext_data *ext_data;
> > > +       struct riscv_isavendorinfo per_hart_isa_bitmap[NR_CPUS];
> > > +       struct riscv_isavendorinfo all_harts_isa_bitmap;
> > > +};
> > > +
> > > +extern struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_l=
ist[];
> > > +
> > > +extern const size_t riscv_isa_vendor_ext_list_size;
> > > +
> > > +#endif /* _ASM_VENDOR_EXTENSIONS_H */
> > > diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/=
riscv/include/asm/vendor_extensions/thead.h
> > > new file mode 100644
> > > index 000000000000..48421d1553ad
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/vendor_extensions/thead.h
> > > @@ -0,0 +1,16 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
> > > +#define _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
> > > +
> > > +#include <asm/vendor_extensions.h>
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +/*
> > > + * Extension keys must be strictly less than RISCV_ISA_VENDOR_EXT_MA=
X.
> > > + */
> > > +#define RISCV_ISA_VENDOR_EXT_XTHEADVECTOR              0
> > > +
> > > +extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_li=
st_thead;
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
> > > index 12c79db0b0bb..cc9ec393c8f6 100644
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
> > > @@ -353,6 +336,21 @@ static void __init riscv_parse_isa_string(unsign=
ed long *this_hwcap, struct risc
> > >                 bool ext_long =3D false, ext_err =3D false;
> > >
> > >                 switch (*ext) {
> > > +               case 'x':
> > > +               case 'X':
> > > +                       if (acpi_disabled)
> > > +                               pr_warn_once("Vendor extensions are i=
gnored in riscv,isa. Use riscv,isa-extensions instead.");
> > > +                       /*
> > > +                        * To skip an extension, we find its end.
> > > +                        * As multi-letter extensions must be split f=
rom other multi-letter
> > > +                        * extensions with an "_", the end of a multi=
-letter extension will
> > > +                        * either be the null character or the "_" at=
 the start of the next
> > > +                        * multi-letter extension.
> > > +                        */
> > > +                       for (; *isa && *isa !=3D '_'; ++isa)
> > > +                               ;
> > > +                       ext_err =3D true;
> > > +                       break;
> > >                 case 's':
> > >                         /*
> > >                          * Workaround for invalid single-letter 's' &=
 'u' (QEMU).
> > > @@ -368,8 +366,6 @@ static void __init riscv_parse_isa_string(unsigne=
d long *this_hwcap, struct risc
> > >                         }
> > >                         fallthrough;
> > >                 case 'S':
> > > -               case 'x':
> > > -               case 'X':
> > >                 case 'z':
> > >                 case 'Z':
> > >                         /*
> > > @@ -572,6 +568,59 @@ static void __init riscv_fill_hwcap_from_isa_str=
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
> > > +               struct riscv_isa_vendor_ext_data_list *ext_list =3D r=
iscv_isa_vendor_ext_list[i];
> > > +
> > > +               for (int j =3D 0; j < ext_list->ext_data_count; j++) =
{
> > > +                       const struct riscv_isa_ext_data ext =3D ext_l=
ist->ext_data[j];
> > > +                       struct riscv_isavendorinfo *isavendorinfo =3D=
 &ext_list->per_hart_isa_bitmap[cpu];
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
> > > +       }
> > > +}
> > > +
> > > +static void __init riscv_fill_vendor_ext_list(int cpu)
> > > +{
> > > +       bool first =3D true;
> > > +
> > > +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> > > +               return;
> > > +
> > > +       for (int i =3D 0; i < riscv_isa_vendor_ext_list_size; i++) {
> > > +               struct riscv_isa_vendor_ext_data_list *ext_list =3D r=
iscv_isa_vendor_ext_list[i];
> > > +
> > > +               if (first) {
> > > +                       bitmap_copy(ext_list->all_harts_isa_bitmap.is=
a,
> > > +                                   ext_list->per_hart_isa_bitmap[cpu=
].isa,
> > > +                                   RISCV_ISA_VENDOR_EXT_MAX);
> > > +                       first =3D false;
> >
> > I think this is still not quite right. This behaves properly when
> > called on the first cpu (let's say 0), but then we call it again with
> > cpu 1, first gets set to true, and we clobber the old work we did for
> > cpu 0. If we knew that cpu 0 was always called first (this looks true
> > since both calls are within a for_each_possible_cpu() loop), and that
> > this was only called once at boot for cpu 0 (looks true, and
> > riscv_fill_hwcap() is __init), then it could be bool first =3D cpu =3D=
=3D 0.
>
> Assuming that the first cpu is 0 should be safe, but to eliminate that
> assumption we can pass in a "first" parameter into this function that
> will only be true the first time this function is called. We also keep
> "first =3D false" in this function so the copy only happens on the first
> iteration of the first cpu.

Yeah, though then you still have to maintain that the function passing
true as the first parameter really is the first invocation.

static bool first =3D true would also fix it, maybe more reliably. Are
static locals allowed in the kernel?

>
> - Charlie
>

