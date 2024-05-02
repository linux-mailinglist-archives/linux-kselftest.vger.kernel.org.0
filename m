Return-Path: <linux-kselftest+bounces-9292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C738BA32A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 00:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C33828301B
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 22:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A517DDA1;
	Thu,  2 May 2024 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cGQb62gF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28B57C94
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689086; cv=none; b=RtI+BuYkfRU782m1vzwL/cUKDhpZusz3BNNTsx+zR8UdSNvDiwbZP+WYaAMkM5Fu3gafm4AFMvJ+gj/RUTST8tbpiW75f8yYmL+EFq+qhngjQh7xD/CjQJkkG1UwzyQpfEmIdU2tQBnnwxOYnp+424qNXM8A9HM/QzASuN2ko7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689086; c=relaxed/simple;
	bh=f82peEUjrrTIPyTLZwB1hItFW5o9yEFomHOt1jtuqEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRM2FWowHzS7sb2WYCbAibTzsp7HhBptKsT/6Aw3zgDrNHlHKkFNyvu0hBzJFbYD6el1naXFDZsyxr3bpAJEdPxsQ6bua+QY10zsAE+p3RVv1yTkm8nC1bM/tEMwz5VkSrnAJk6awcLBw0MSiAv0In2Hrc94Okx1y5VJhwXlpCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cGQb62gF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ec5387aed9so30713115ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 15:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714689083; x=1715293883; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jyw7zxfMEtfqyw3yPaaOuPprN3b7DB1YugAVazrGrkk=;
        b=cGQb62gFbFeL04pZkWu00KsobaiEO+ScW4VM1V0cOD0OY8iFPkQdWhyCYgzFIKV9H1
         D8mAil92WthL7p1ZvNPejdvY8NulvaLcmp61UxO+NxkWhKu30/6/67+aUQ9fyWmVTiAT
         MvwXyeXWqmLUff5gk0aCK2r88hcZAu89jQU8r9ad2zYc44Vzk8MbLvay7A9cpgWBV4Oj
         4kO/ixtEXQRfSJuEkOkXnM8O5hVGoFDID1EBU7nx/aDzNtinMjAK/lpo+BA5BRNnSNYp
         v1RPfOH8CBLOBMClNKRtJFITpNrVHqVamBUc4SIuOxn972l583QJCEWi/NBDui0J83fw
         i7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689083; x=1715293883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jyw7zxfMEtfqyw3yPaaOuPprN3b7DB1YugAVazrGrkk=;
        b=kZhpIU2gNwbAq+wOgLbTV+w5JXausdncR/EaEyIo8r0VnQlUr8hSJf1yLh4KALklMa
         wwNLLF+f2KCv/K2dQgQDaNU1RhS/AH9EjhHQstbymAMfBP3JFztdfIDCMXKTQ7oJBJ4u
         rvdLGwNPqID3nB++FzSQDtsroBZ8lzAvFfSXXVcwwZgPXeJws07Nf63QmlIftbZdkK/d
         UquXo666PWBk0Xd2Gptqsz+vDkEdyKX2cxS7hfSJMhBOGSYfitU+UesSzd2+eA+qh4JP
         02MVJMccK1Te201Mw4ICc8wcH3RUG03uXGtsAysaz4bwIQgJ/AjQ5BsryPSDhhPTZxx+
         1LTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnho54vk/psIdWheoUP+F1JD/4a1vze7GoP7gUpsOpvMXGSMcd3ngukfJJqo0pHZi3BEuz+JslWAktTAtwzlj7Jd7aQ63QHvAuIn6Txv3G
X-Gm-Message-State: AOJu0YzC7L6IzmgnnNOEt7nFIIlFl2++VdkASglo6mXy8tM7mkRe/8Rv
	IZOFuUoUAyvDCDAfJ0Mni2aRXc7hixtpz2NN5w82NvMBy0MEcMh7tjj9cJ9zO8M=
X-Google-Smtp-Source: AGHT+IFB+rtKMcM3DQ0bkb6f6tzj/9Q4q165q3JA8fWP2cX4VeLL+YWsW17aB2bGX2oOxX/u+yG8AQ==
X-Received: by 2002:a17:902:f685:b0:1e4:9c2f:d343 with SMTP id l5-20020a170902f68500b001e49c2fd343mr1287136plg.7.1714689082510;
        Thu, 02 May 2024 15:31:22 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903244900b001e3e13781c4sm1867363pls.54.2024.05.02.15.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:31:21 -0700 (PDT)
Date: Thu, 2 May 2024 15:31:17 -0700
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
Message-ID: <ZjQUNXlZgW0ZN8if@ghost>
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
> 

After looking into this a bit more, I am not sure there is a "clean" way
of doing this. Kees wrote an interesting article about an adjacent
problem [1], and my takeaway was that there are some people working to
improve situations like this. This pattern is very close to the standard
struct with the length of the array as one element and the array itself
as another element. There are two major differences though, one being
that the count is put through a simple macro BITS_TO_LONGS to calculate
the size of the array. The other is that count is a compile time
constant that should be populated into all structs of the type, since we
have arrays of riscv_isainfo that should be allocated at compile time to
all have the same count. Ideally what I would want is something like:

struct riscv_thead_isainfo {
     int count = RISCV_ISA_VENDOR_EXT_MAX_THEAD;
     DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
}

Otherwise we need to populate count at runtime and that defeats the
point in my opinion since this is currently known by accessing
the "bitmap_size" of the statically allocated struct:

const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead

This also has the downside of having the same "count" repeated across
all of the instances of riscv_thead_isainfo of which there are by
default 65 (one for each of the CPUs configured with NR_CPUS which
defaults to 64 plus an additional for the least-common-denominator
across all CPUs). It's a relatively large amount of bits that gets
"wasted".

Just for some background here, the purpose here is to be able to have a
standardized "struct riscv_isa_vendor_ext_data_list" that each vendor
will be able to populate with their vendor extensions. The thought was
that each vendor will have a different number of extensions so each
vendor doesn't need to reserve the same amount of space in their
statically allocated bitmap. vendorA may be able to fit their extensions
in 64 bits but vendorB may need 128. We're talking about a small amount
of space savings here. We could forego this casting entirely and say
each vendor will need a maximum of X bits. It may be unlikely for any
vendor to ever end up with more than 64 vendor extensions that they want
exposed to the kernel. But if any vendor ever does end up with more than
64, all of the vendors end up needing to have to allocate 128 bits in
their bitmask that is allocated for each possible CPU.

[1] https://people.kernel.org/kees/bounded-flexible-arrays-in-c

- Charlie

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

