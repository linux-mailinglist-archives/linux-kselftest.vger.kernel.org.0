Return-Path: <linux-kselftest+bounces-9228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0907C8B8F38
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 19:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC11B28375D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D60F13BAFF;
	Wed,  1 May 2024 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Fr50RsrE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106411386A6
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585907; cv=none; b=oyW82Zpv/Gn7R6DtfZC/9M8ZxcWy45pLL2hAanPao4kIL6wqwSFFMgFBpos6aKNvvg1IY4Ac0tTeZrb8lQ4WZQaXLTR27tkRLkH5MVhIuUULzlBLgOKGLeBTJeVeJc2NHIbKHUyZzIUOSbYk7fNOkM271D0h/UvVYn8jcw5pFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585907; c=relaxed/simple;
	bh=1U6T0CadzQ+9ePXePWrADCu4URJF58MVOTY3ZQIPBEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RI58eBEeAk7510GmceV6sPdheFxdegpDBWa2dZ3/MQKp0l9AqdaTsnrInGHCXHaNfMTx1jzN6C52omFRDU+SGRR9t914IHG5CL+vu/k/B8YHTXM/QAX+91As2jMjfuHK8BCPffJcMRc+IaX/QfNtahcMBWVPKNN+YX4Tc7BICdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Fr50RsrE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a526803fccso4739133a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714585903; x=1715190703; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3RALqxCSkSlQbzmGw9Y0NWOsTUNS2E24pfqr2Ji/S+Y=;
        b=Fr50RsrEnOfPO/j+TPVcF058LJ6JS8792okx3zCVSWb803IE6ZSUULrSweDvecVgHE
         g3c2GQympoVbsPrqERPFJ8cqZKOlTlt+CIhJ9VXuOFsOWT2WjlhyrdFxHkyGba1MsaHC
         6LZpQLfozRltT6EqaUlEb1bI19SP+JhR8oNHZAl1QMMtvfULokKnwTXuNZ/ZZJagwX1y
         eUZsS+uQf5Q3adRk6AeyQHNdYYaHA04o3f+CLL8Gs7TZ6ylHrxhMwpsakhIkjfTmYGcC
         g3NL5y6GV7C3HZhyJlDQE1ZLZqdAqXcOJLTM8XB7t197VVPwbQVjyaP6Dp2SL9Bsx0JI
         YXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714585903; x=1715190703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RALqxCSkSlQbzmGw9Y0NWOsTUNS2E24pfqr2Ji/S+Y=;
        b=PGmKmcK8mCvm3Vga7iTXp+ugkH7KfJTHCUgnGjZ66K5bXdO2YKboPi6D/AVaSX68Fu
         RIdsQKMBf0R98JmCsEMU/So6lpmva0QAsuGtg4FZFqnppEnrjHWvha5j8bB0kwDY6c6I
         AZemL25aKwaFrsPOlhSGSE0oxutxfguo4cUZ4dJo2eEykUX1vqmbAbRCfahMpatdLgG0
         4UgzpIhqv7psIneGtDZjRd3RWTOXe7JtVyCzlzfJ0mRoLzypTWDmsneT8PoqiRC0mo67
         MxKoQqH4ZG6mJFVRAftvyVFmaGBZqFxZhiIw7pAJ7iJRpkdN30y1HHGAgLJb48REn/aD
         ch3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+7nG+lnpmKXF/I/rGcWw8IPTVSwBZI+5rJ4EshLRKY4XwzdC9VgXA1+VmlIRQ4Ruw7eBhQRpyTcEB+SeV5DFYN0JJNgNhAPHqHhOkP0mu
X-Gm-Message-State: AOJu0YzwUupZXE/+e5VoA9LyONmNBENKjN4NhMxknvMCWnMtJgRB42/S
	vBopeGjslHAFe8jHFkZNPT2VdFnw3wBheGqulzNdZZWhCj0H8dGs7bp5QNFl2GM=
X-Google-Smtp-Source: AGHT+IFC1xS3t+cfPvpoJ1bOx+L15dNw65VBtNOj9azcp0luCYYZjvxDfsR38dTeBbBhWhSZKKAf+g==
X-Received: by 2002:a17:90b:4f8b:b0:2af:2be3:89c5 with SMTP id qe11-20020a17090b4f8b00b002af2be389c5mr3400264pjb.29.1714585903096;
        Wed, 01 May 2024 10:51:43 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:1dcc:e03e:dc61:895d])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090276c900b001e26ba8882fsm24363346plt.287.2024.05.01.10.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:51:42 -0700 (PDT)
Date: Wed, 1 May 2024 10:51:38 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 05/16] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <ZjKBKg5zzikR5ngl@ghost>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
 <CALs-HstM64Hy_=XVz=0sWQt=8j1u+bq6RhthUuD3P0E4=HyvcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HstM64Hy_=XVz=0sWQt=8j1u+bq6RhthUuD3P0E4=HyvcA@mail.gmail.com>

On Wed, May 01, 2024 at 09:44:15AM -0700, Evan Green wrote:
> On Fri, Apr 26, 2024 at 2:29 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Separate vendor extensions out into one struct per vendor
> > instead of adding vendor extensions onto riscv_isa_ext.
> >
> > Add a hidden config RISCV_ISA_VENDOR_EXT to conditionally include this
> > code.
> >
> > The xtheadvector vendor extension is added using these changes.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig                               |  2 +
> >  arch/riscv/Kconfig.vendor                        | 19 ++++++
> >  arch/riscv/include/asm/cpufeature.h              | 18 ++++++
> >  arch/riscv/include/asm/vendor_extensions.h       | 26 ++++++++
> >  arch/riscv/include/asm/vendor_extensions/thead.h | 19 ++++++
> >  arch/riscv/kernel/Makefile                       |  2 +
> >  arch/riscv/kernel/cpufeature.c                   | 77 ++++++++++++++++++------
> >  arch/riscv/kernel/vendor_extensions.c            | 18 ++++++
> >  arch/riscv/kernel/vendor_extensions/Makefile     |  3 +
> >  arch/riscv/kernel/vendor_extensions/thead.c      | 36 +++++++++++
> >  10 files changed, 200 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index be09c8836d56..fec86fba3acd 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -759,6 +759,8 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
> >
> >  endchoice
> >
> > +source "arch/riscv/Kconfig.vendor"
> > +
> >  endmenu # "Platform type"
> >
> >  menu "Kernel features"
> > diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> > new file mode 100644
> > index 000000000000..4fc86810af1d
> > --- /dev/null
> > +++ b/arch/riscv/Kconfig.vendor
> > @@ -0,0 +1,19 @@
> > +menu "Vendor extensions"
> > +
> > +config RISCV_ISA_VENDOR_EXT
> > +       bool
> > +
> > +menu "T-Head"
> > +config RISCV_ISA_VENDOR_EXT_THEAD
> > +       bool "T-Head vendor extension support"
> > +       select RISCV_ISA_VENDOR_EXT
> > +       default y
> > +       help
> > +         Say N here if you want to disable all T-Head vendor extension
> > +         support. This will cause any T-Head vendor extensions that are
> > +         requested to be ignored.
> > +
> > +         If you don't know what to do here, say Y.
> > +endmenu
> > +
> > +endmenu
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > index 0c4f08577015..fedd479ccfd1 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -35,6 +35,24 @@ extern u32 riscv_vlenb_of;
> >
> >  void riscv_user_isa_enable(void);
> >
> > +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {     \
> > +       .name = #_name,                                                         \
> > +       .property = #_name,                                                     \
> > +       .id = _id,                                                              \
> > +       .subset_ext_ids = _subset_exts,                                         \
> > +       .subset_ext_size = _subset_exts_size                                    \
> > +}
> > +
> > +#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
> > +
> > +/* Used to declare pure "lasso" extension (Zk for instance) */
> > +#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> > +       _RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
> > +
> > +/* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
> > +#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> > +       _RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
> > +
> >  #if defined(CONFIG_RISCV_MISALIGNED)
> >  bool check_unaligned_access_emulated_all_cpus(void);
> >  void unaligned_emulation_finish(void);
> > diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/include/asm/vendor_extensions.h
> > new file mode 100644
> > index 000000000000..0af1ddd0af70
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/vendor_extensions.h
> > @@ -0,0 +1,26 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright 2024 Rivos, Inc
> > + */
> > +
> > +#ifndef _ASM_VENDOR_EXTENSIONS_H
> > +#define _ASM_VENDOR_EXTENSIONS_H
> > +
> > +#include <asm/cpufeature.h>
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/types.h>
> > +
> > +struct riscv_isa_vendor_ext_data_list {
> > +       const struct riscv_isa_ext_data *ext_data;
> > +       struct riscv_isainfo *per_hart_vendor_bitmap;
> > +       unsigned long *vendor_bitmap;
> 
> It took a lot of digging for me to understand this was the set of
> vendor extensions supported on all harts. Can we add that to the name,
> maybe something like isa_bitmap_all_harts? (I wonder if we could drop
> the vendor part of the name since we already know we're in a
> vendor_ext_data_list structure).

Sure, I figured it was implied since the other bitmap says "per_hart",
but I can see how it could be confusing.

> 
> > +       const size_t ext_data_count;
> > +       const size_t bitmap_size;
> > +};
> > +
> > +extern const struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[];
> > +
> > +extern const size_t riscv_isa_vendor_ext_list_size;
> > +
> > +#endif /* _ASM_VENDOR_EXTENSIONS_H */
> > diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/riscv/include/asm/vendor_extensions/thead.h
> > new file mode 100644
> > index 000000000000..92eec729888d
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/vendor_extensions/thead.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
> > +#define _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
> > +
> > +#include <asm/vendor_extensions.h>
> > +
> > +#include <linux/types.h>
> > +
> > +#define RISCV_ISA_VENDOR_EXT_XTHEADVECTOR              0
> > +
> > +/*
> > + * Extension keys should be strictly less than max.
> > + * It is safe to increment this when necessary.
> > + */
> > +#define RISCV_ISA_VENDOR_EXT_MAX_THEAD                 32
> > +
> > +extern const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead;
> > +
> > +#endif
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 81d94a8ee10f..53361c50fb46 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -58,6 +58,8 @@ obj-y += riscv_ksyms.o
> >  obj-y  += stacktrace.o
> >  obj-y  += cacheinfo.o
> >  obj-y  += patch.o
> > +obj-y  += vendor_extensions.o
> > +obj-y  += vendor_extensions/
> >  obj-y  += probes/
> >  obj-y  += tests/
> >  obj-$(CONFIG_MMU) += vdso.o vdso/
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 8158f34c3e36..c073494519eb 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -24,6 +24,7 @@
> >  #include <asm/processor.h>
> >  #include <asm/sbi.h>
> >  #include <asm/vector.h>
> > +#include <asm/vendor_extensions.h>
> >
> >  #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
> >
> > @@ -102,24 +103,6 @@ static bool riscv_isa_extension_check(int id)
> >         return true;
> >  }
> >
> > -#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {     \
> > -       .name = #_name,                                                         \
> > -       .property = #_name,                                                     \
> > -       .id = _id,                                                              \
> > -       .subset_ext_ids = _subset_exts,                                         \
> > -       .subset_ext_size = _subset_exts_size                                    \
> > -}
> > -
> > -#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
> > -
> > -/* Used to declare pure "lasso" extension (Zk for instance) */
> > -#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> > -       _RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
> > -
> > -/* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
> > -#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> > -       _RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
> > -
> >  static const unsigned int riscv_zk_bundled_exts[] = {
> >         RISCV_ISA_EXT_ZBKB,
> >         RISCV_ISA_EXT_ZBKC,
> > @@ -353,6 +336,10 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
> >                 bool ext_long = false, ext_err = false;
> >
> >                 switch (*ext) {
> > +               case 'x':
> > +               case 'X':
> > +                       pr_warn_once("Vendor extensions are ignored in riscv,isa. Use riscv,isa-extensions instead.");
> > +                       continue;
> >                 case 's':
> >                         /*
> >                          * Workaround for invalid single-letter 's' & 'u' (QEMU).
> > @@ -368,8 +355,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
> >                         }
> >                         fallthrough;
> >                 case 'S':
> > -               case 'x':
> > -               case 'X':
> >                 case 'z':
> >                 case 'Z':
> >                         /*
> > @@ -572,6 +557,54 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
> >                 acpi_put_table((struct acpi_table_header *)rhct);
> >  }
> >
> > +static void __init riscv_fill_cpu_vendor_ext(struct device_node *cpu_node, int cpu)
> > +{
> > +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> > +               return;
> > +
> > +       for (int i = 0; i < riscv_isa_vendor_ext_list_size; i++) {
> > +               const struct riscv_isa_vendor_ext_data_list *ext_list = riscv_isa_vendor_ext_list[i];
> > +
> > +               for (int j = 0; j < ext_list->ext_data_count; j++) {
> > +                       const struct riscv_isa_ext_data ext = ext_list->ext_data[j];
> > +                       struct riscv_isainfo *isavendorinfo = &ext_list->per_hart_vendor_bitmap[cpu];
> > +
> > +                       if (of_property_match_string(cpu_node, "riscv,isa-extensions",
> > +                                                    ext.property) < 0)
> > +                               continue;
> > +
> > +                       /*
> > +                        * Assume that subset extensions are all members of the
> > +                        * same vendor.
> > +                        */
> > +                       if (ext.subset_ext_size)
> > +                               for (int k = 0; k < ext.subset_ext_size; k++)
> > +                                       set_bit(ext.subset_ext_ids[k], isavendorinfo->isa);
> > +
> > +                       set_bit(ext.id, isavendorinfo->isa);
> > +               }
> 
> This loop seems super similar to the regular one (in
> riscv_fill_hwcap_from_ext_list() in the random, possibly old, kernel I
> have open). Could we refactor these together into a common helper? The
> other loop has an extra stanza for riscv_isa_extension_check(), so
> we'd have to add an extra condition there, but otherwise it looks
> pretty compatible?
> 

I actually did have this refactored into a single function in a previous
version but broke it back up since I felt there just wasn't enough
overlap. The one for standard extensions is:

	for (int i = 0; i < riscv_isa_ext_count; i++) {
		const struct riscv_isa_ext_data *ext = &riscv_isa_ext[i];

		if (of_property_match_string(cpu_node, "riscv,isa-extensions",
					     ext->property) < 0)
			continue;

		if (ext->subset_ext_size) {
			for (int j = 0; j < ext->subset_ext_size; j++) {
				if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
					set_bit(ext->subset_ext_ids[j], isainfo->isa);
			}
		}

		if (riscv_isa_extension_check(ext->id)) {
			set_bit(ext->id, isainfo->isa);

			/* Only single letter extensions get set in hwcap */
			if (strnlen(riscv_isa_ext[i].name, 2) == 1)
				this_hwcap |= isa2hwcap[riscv_isa_ext[i].id];
		}
	}

The motivating reason why I didn't combine them was the additional
`struct riscv_isa_vendor_ext_data_list *` data type for the vendor
version which contains ext and isainfo. This can probably be combined in
a straight-forward way though.

> > +       }
> > +}
> > +
> > +static void __init riscv_fill_vendor_ext_list(int cpu)
> > +{
> > +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> > +               return;
> > +
> > +       for (int i = 0; i < riscv_isa_vendor_ext_list_size; i++) {
> > +               const struct riscv_isa_vendor_ext_data_list *ext_list = riscv_isa_vendor_ext_list[i];
> > +
> > +               if (bitmap_empty(ext_list->vendor_bitmap, ext_list->bitmap_size))
> > +                       bitmap_copy(ext_list->vendor_bitmap,
> > +                                   ext_list->per_hart_vendor_bitmap[cpu].isa,
> > +                                   ext_list->bitmap_size);
> 
> Could you get into trouble here if the set of vendor extensions
> reduces to zero, and then becomes non-zero? To illustrate, consider
> these masks:
> cpu 0: 0x0000C000
> cpu 1: 0x00000003 <<< vendor_bitmap ANDs out to 0
> cpu 2: 0x00000010 <<< oops, we end up copying this into vendor_bitmap
> 

Huh that's a good point. The standard extensions have that same bug too?

	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
		bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
	else
		bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);


> > +               else
> > +                       bitmap_and(ext_list->vendor_bitmap, ext_list->vendor_bitmap,
> > +                                  ext_list->per_hart_vendor_bitmap[cpu].isa,
> > +                                  ext_list->bitmap_size);
> > +       }
> > +}
> > +
> >  static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
> >  {
> >         unsigned int cpu;
> > @@ -615,6 +648,8 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
> >                         }
> >                 }
> >
> > +               riscv_fill_cpu_vendor_ext(cpu_node, cpu);
> > +
> >                 of_node_put(cpu_node);
> >
> >                 /*
> > @@ -630,6 +665,8 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
> >                         bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
> >                 else
> >                         bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
> > +
> > +               riscv_fill_vendor_ext_list(cpu);
> >         }
> >
> >         if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
> > diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
> > new file mode 100644
> > index 000000000000..f76cb3013c2d
> > --- /dev/null
> > +++ b/arch/riscv/kernel/vendor_extensions.c
> > @@ -0,0 +1,18 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright 2024 Rivos, Inc
> > + */
> > +
> > +#include <asm/vendor_extensions.h>
> > +#include <asm/vendor_extensions/thead.h>
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/types.h>
> > +
> > +const struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[] = {
> > +#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
> > +       &riscv_isa_vendor_ext_list_thead,
> > +#endif
> > +};
> > +
> > +const size_t riscv_isa_vendor_ext_list_size = ARRAY_SIZE(riscv_isa_vendor_ext_list);
> > diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/kernel/vendor_extensions/Makefile
> > new file mode 100644
> > index 000000000000..3383066baaab
> > --- /dev/null
> > +++ b/arch/riscv/kernel/vendor_extensions/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)       += thead.o
> > diff --git a/arch/riscv/kernel/vendor_extensions/thead.c b/arch/riscv/kernel/vendor_extensions/thead.c
> > new file mode 100644
> > index 000000000000..edb20b928c0c
> > --- /dev/null
> > +++ b/arch/riscv/kernel/vendor_extensions/thead.c
> > @@ -0,0 +1,36 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <asm/cpufeature.h>
> > +#include <asm/vendor_extensions.h>
> > +#include <asm/vendor_extensions/thead.h>
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/types.h>
> > +
> > +/* All T-Head vendor extensions supported in Linux */
> > +const struct riscv_isa_ext_data riscv_isa_vendor_ext_thead[] = {
> > +       __RISCV_ISA_EXT_DATA(xtheadvector, RISCV_ISA_VENDOR_EXT_XTHEADVECTOR),
> > +};
> > +
> > +/*
> > + * The first member of this struct must be a bitmap named isa so it can be
> > + * compatible with riscv_isainfo even though the sizes of the bitmaps may be
> > + * different.
> This is kinda yucky, as you're casting a bitmap of a different size
> into a struct riscv_isainfo *, which has a known size. I don't
> necessarily have a fabulous suggestion to fix though. The best I can
> come up with is refactor struct riscv_isainfo to be:
> struct riscv_isainfo {
>     int count;
>     unsigned long isa[0];
> };
> 
> then declare a standard one (for hart_isa, which is statically allocated):
> struct riscv_std_isainfo {
>     int count;
>     DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
> }
> 
> and a thead one
> struct riscv_thead_isainfo {
>     int count;
>     DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
> }
> 
> But there's still a cast in there, as you'd cast the specialized
> structs to struct riscv_isainfo *. But at least the size is in there
> to be enforced at runtime, rather than a compile-time check that's
> wrong.  So I'll just leave this half baked thought here, and maybe you
> can think of a cleaner way, or ignore it :).

Yes perhaps this is a better way of doing it.

- Charlie

> 
> 
> > + */
> > +struct riscv_isavendorinfo_thead {
> > +       DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
> > +};
> > +
> > +/* Hart specific T-Head vendor extension support */
> > +static struct riscv_isavendorinfo_thead hart_vendorinfo_thead[NR_CPUS];
> > +
> > +/* Set of T-Head vendor extensions supported on all harts */
> > +DECLARE_BITMAP(vendorinfo_thead, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
> > +
> > +const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead = {
> > +       .ext_data = riscv_isa_vendor_ext_thead,
> > +       .per_hart_vendor_bitmap = (struct riscv_isainfo *)hart_vendorinfo_thead,
> > +       .vendor_bitmap = vendorinfo_thead,
> > +       .ext_data_count = ARRAY_SIZE(riscv_isa_vendor_ext_thead),
> > +       .bitmap_size = RISCV_ISA_VENDOR_EXT_MAX_THEAD
> > +};
> >
> > --
> > 2.44.0
> >

