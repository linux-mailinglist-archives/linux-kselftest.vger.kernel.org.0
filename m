Return-Path: <linux-kselftest+bounces-8935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1D78B3ECC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 20:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4941C21B21
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B729116C44D;
	Fri, 26 Apr 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PBInLd1M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D073116190A
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154428; cv=none; b=j6ZhRgpgjWVHUelFfyy/0PUeWgm5bIWs8u1uqTZG0yNtflqzlEyGKQxYa57QDiVqSS8G5ZztkhNYgssyKlGiltDoWHhjRPTtvONMWOQTQdlK6yygLf4Do2W0iNhLGh3qXsnkrTQhltLsYm14gT7QXkBBwl1feGAHZW7oAtYV1CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154428; c=relaxed/simple;
	bh=P6eYzko4VaPs6W10KnYtq4BUZdBeGoDwOJYD9bFKqok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDNz6yDhX1fDirXqrEzzlj0G77kfrIdp44rtyVCRBOItbJdIchcEUPtnvvKUEJbFfp5sfjYAE/T4cyhfWPkz9wxWSCZBszW8cK/yasADqu8/c6uPJcS7wL7MXmsQYbCn7cPj8AWXsH8FIjh1F7fEf0mQ+HZ0TuECrJ4g1qao0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PBInLd1M; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed627829e6so2906865b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 11:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714154426; x=1714759226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tn4hIIaFDO89bEhYdNGg8VnD0i4DoKPoq4DbLbPR41Y=;
        b=PBInLd1M/BercN2/tiU2roRi6u8D80rNplWAcGKNQJF0O9iktKjj5BHLeSF2BVdgdF
         IKOChs3D8JSonq0yW2NhEN74At9ic0hdLvlptiligEhxUrshYGBpUbajEWm2nmh97hPW
         xPfL2Qddm6L0cFx4UIKBZB1XK3336gXtOBno/oAy5x/wyRyQKxRhImJU4sNPwbiIXh8N
         c30b11e+k/6v0h073wyt9I9wwnc65qicBXS/omwiUXMnjZANjt0zqALi1vEWPOI80rlz
         GqZogmYHnMAeDj/F8qsc08/tAi2yIgOo4nG0fGhRJXCG51nMQjBOkCJ+t3/8vdhjLIXW
         KuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714154426; x=1714759226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tn4hIIaFDO89bEhYdNGg8VnD0i4DoKPoq4DbLbPR41Y=;
        b=A5naC3qgEVnrWXpPAHyKqMTgpxlW4FvGQkqiy/98eLMhx+H4YOK9sx1v6wPR9YAX4E
         0AyDlFV2srzICkzEhqSfmnZ5JNtth3Ca/gNM/oqldZNd5qt04DviEVnfw2ppd33PapMv
         a3XmKXDlrk5WMGxCgZTX6M8CK5g35dTyuVqo/b3x4jYzvdpMou33SYaKH/1zD1ZUe2bd
         aNGzA/rkbxGx1fqTkklDqewhX8MKwEKTRhVSkYfE+gyinKazi0UAQapFg8lwlDYSg2iS
         pst2ItiGyjgo+Yj5a7nAAjalYYCOhTLGEoOt0ehbbWfnXQIsZuJ3dugk1eijjpKaNhqj
         ccWA==
X-Forwarded-Encrypted: i=1; AJvYcCVcWlDnIIqi801mrYOKxxzO4iGbfSPxk+7jBErLMvgtcdMAPXmzEvUi0N7B6N+vTxcj5eF9tw2sUaO9XObEVDs9IdXrc6iVi9OuNr5tQhyb
X-Gm-Message-State: AOJu0Yz/0qCL1RTN06PlQ462QwBLmrJKfEQ5P+mQJYi4znx4/ra530wH
	NNLNHkveodAv+piI2KebMqQldVETGiO85JE3jH1pvsE8d44pvOl06KElCr+QSx8=
X-Google-Smtp-Source: AGHT+IHFaHUfzIdsVON10udpj4k0R6AShmNjpmsi2MAp0VzVt+P/lJBmSb+0VE4ppsKqIVOLpXhhJw==
X-Received: by 2002:a05:6a00:1311:b0:6f0:c214:7974 with SMTP id j17-20020a056a00131100b006f0c2147974mr4612048pfu.12.1714154424601;
        Fri, 26 Apr 2024 11:00:24 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:4d29:d34e:e48:a550])
        by smtp.gmail.com with ESMTPSA id c6-20020a633506000000b005f034b4d123sm12849740pga.24.2024.04.26.11.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 11:00:24 -0700 (PDT)
Date: Fri, 26 Apr 2024 11:00:20 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
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
Message-ID: <ZivrtDIooQKXobsw@ghost>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
 <20240420-dev-charlie-support_thead_vector_6_9-v3-7-67cff4271d1d@rivosinc.com>
 <20240426-blank-venus-3c902a2a0843@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426-blank-venus-3c902a2a0843@spud>

On Fri, Apr 26, 2024 at 05:00:36PM +0100, Conor Dooley wrote:
> On Sat, Apr 20, 2024 at 06:04:39PM -0700, Charlie Jenkins wrote:
> > Separate vendor extensions out into one struct per vendor
> > instead of adding vendor extensions onto riscv_isa_ext.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig                               |  2 +
> >  arch/riscv/Kconfig.vendor                        |  9 +++
> >  arch/riscv/include/asm/cpufeature.h              | 18 ++++++
> >  arch/riscv/include/asm/vendor_extensions.h       | 26 ++++++++
> >  arch/riscv/include/asm/vendor_extensions/thead.h | 19 ++++++
> >  arch/riscv/kernel/Makefile                       |  2 +
> >  arch/riscv/kernel/cpufeature.c                   | 75 +++++++++++++++++-------
> >  arch/riscv/kernel/vendor_extensions.c            | 18 ++++++
> >  arch/riscv/kernel/vendor_extensions/Makefile     |  3 +
> >  arch/riscv/kernel/vendor_extensions/thead.c      | 36 ++++++++++++
> >  10 files changed, 188 insertions(+), 20 deletions(-)
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
> > index 000000000000..d57254f28ea6
> > --- /dev/null
> > +++ b/arch/riscv/Kconfig.vendor
> > @@ -0,0 +1,9 @@
> > +config RISCV_ISA_VENDOR_EXT_THEAD
> > +	bool "T-Head vendor extension support"
> > +	default y
> > +	help
> > +	  Say N here if you want to disable all T-Head vendor extension
> > +	  support. This will cause any T-Head vendor extensions that are
> > +	  requested by hardware probing to be ignored.
> > +
> > +	  If you don't know what to do here, say Y.
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > index 809f61ffb667..db6a6d7d6b2e 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -35,6 +35,24 @@ extern u32 riscv_vlenb_dt[NR_CPUS];
> >  
> >  void riscv_user_isa_enable(void);
> >  
> > +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {	\
> > +	.name = #_name,								\
> > +	.property = #_name,							\
> > +	.id = _id,								\
> > +	.subset_ext_ids = _subset_exts,						\
> > +	.subset_ext_size = _subset_exts_size					\
> > +}
> > +
> > +#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
> > +
> > +/* Used to declare pure "lasso" extension (Zk for instance) */
> > +#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> > +	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
> > +
> > +/* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
> > +#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> > +	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
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
> > +	const struct riscv_isa_ext_data *ext_data;
> > +	struct riscv_isainfo *per_hart_vendor_bitmap;
> > +	unsigned long *vendor_bitmap;
> > +	const size_t ext_data_count;
> > +	const size_t bitmap_size;
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
> > +#define RISCV_ISA_VENDOR_EXT_XTHEADVECTOR		0
> > +
> > +/*
> > + * Extension keys should be strictly less than max.
> > + * It is safe to increment this when necessary.
> > + */
> > +#define RISCV_ISA_VENDOR_EXT_MAX_THEAD			32
> > +
> > +extern const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead;
> > +
> > +#endif
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 81d94a8ee10f..53361c50fb46 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -58,6 +58,8 @@ obj-y	+= riscv_ksyms.o
> >  obj-y	+= stacktrace.o
> >  obj-y	+= cacheinfo.o
> >  obj-y	+= patch.o
> > +obj-y	+= vendor_extensions.o
> > +obj-y	+= vendor_extensions/
> >  obj-y	+= probes/
> >  obj-y	+= tests/
> >  obj-$(CONFIG_MMU) += vdso.o vdso/
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index b537731cadef..c9f36822e337 100644
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
> >  	return true;
> >  }
> >  
> > -#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {	\
> > -	.name = #_name,								\
> > -	.property = #_name,							\
> > -	.id = _id,								\
> > -	.subset_ext_ids = _subset_exts,						\
> > -	.subset_ext_size = _subset_exts_size					\
> > -}
> > -
> > -#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
> > -
> > -/* Used to declare pure "lasso" extension (Zk for instance) */
> > -#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> > -	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
> > -
> > -/* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
> > -#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> > -	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
> > -
> >  static const unsigned int riscv_zk_bundled_exts[] = {
> >  	RISCV_ISA_EXT_ZBKB,
> >  	RISCV_ISA_EXT_ZBKC,
> > @@ -353,6 +336,14 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
> >  		bool ext_long = false, ext_err = false;
> >  
> >  		switch (*ext) {
> > +		case 'x':
> > +		case 'X':
> > +			pr_warn("Vendor extensions are ignored in riscv,isa. Use riscv,isa-extensions instead.");
> 
> I think I pointed out before that this should only really warn once, not
> once per extension per cpu. pr_warn_once() please.
> 

Yes that slipped my mind, thank you for reminding me.

> > +			/*
> > +			 * In canonical order, the remaining extensions in the
> > +			 * isa string will be vendor extensions so exit.
> > +			 */
> 
> Yeah, but the binding doesn't require canonical order, so please don't
> exit & just move along to the next extension.
> 

Oh! I will remove that then.

> > +			break;
> >  		case 's':
> >  			/*
> >  			 * Workaround for invalid single-letter 's' & 'u' (QEMU).
> > @@ -368,8 +359,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
> >  			}
> >  			fallthrough;
> >  		case 'S':
> > -		case 'x':
> > -		case 'X':
> >  		case 'z':
> >  		case 'Z':
> >  			/*
> > @@ -580,6 +569,48 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
> >  		acpi_put_table((struct acpi_table_header *)rhct);
> >  }
> >  
> > +static void __init riscv_add_cpu_vendor_ext(struct device_node *cpu_node, int cpu)
> 
> Can we have a consistent naming here? The other functions are using
> "fill".

I will rename it "riscv_fill_cpu_vendor_ext"

> 
> > +{
> > +	for (int i = 0; i < riscv_isa_vendor_ext_list_size; i++) {
> > +		const struct riscv_isa_vendor_ext_data_list *ext_list = riscv_isa_vendor_ext_list[i];
> > +
> > +		for (int j = 0; j < ext_list->ext_data_count; j++) {
> > +			const struct riscv_isa_ext_data ext = ext_list->ext_data[j];
> > +			struct riscv_isainfo *isavendorinfo = &ext_list->per_hart_vendor_bitmap[cpu];
> > +
> > +			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
> > +						     ext.property) < 0)
> > +				continue;
> > +
> > +			/*
> > +			 * Assume that subset extensions are all members of the
> > +			 * same vendor.
> > +			 */
> > +			if (ext.subset_ext_size)
> > +				for (int k = 0; k < ext.subset_ext_size; k++)
> > +					set_bit(ext.subset_ext_ids[k], isavendorinfo->isa);
> > +
> > +			set_bit(ext.id, isavendorinfo->isa);
> > +		}
> > +	}
> > +}
> > +
> > +static void __init set_riscv_isa_vendor(int cpu)
> 
> Again, consistent naming here would have riscv_isa_set...
> And it's not setting a vendor, can you pick a name that matches the
> action that the function is actually taking please?
> riscv_isa_set_vendor_bitmask() or w/e.
> 

How about "riscv_fill_vendor_ext_list"

> Also, you've added Kconfig options for the different vendors but this
> code is unconditionally compiled. Do we need to have a hidden Kconfig
> option that all of the vendor options select that gets all of this new
> code culled when none of them are enabled? Could just be as simple as
> if (!IS_ENABLED(CONFIG_FOO))
> 	return;
> in these functions in cpufeature.c?

That is a good idea, I can add that.

- Charlie

> 
> > +{
> > +	for (int i = 0; i < riscv_isa_vendor_ext_list_size; i++) {
> > +		const struct riscv_isa_vendor_ext_data_list *ext_list = riscv_isa_vendor_ext_list[i];
> > +
> > +		if (bitmap_empty(ext_list->vendor_bitmap, ext_list->bitmap_size))
> > +			bitmap_copy(ext_list->vendor_bitmap,
> > +				    ext_list->per_hart_vendor_bitmap[cpu].isa,
> > +				    ext_list->bitmap_size);
> > +		else
> > +			bitmap_and(ext_list->vendor_bitmap, ext_list->vendor_bitmap,
> > +				   ext_list->per_hart_vendor_bitmap[cpu].isa,
> > +				   ext_list->bitmap_size);
> > +	}
> > +}
> > +
> >  static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
> >  {
> >  	unsigned int cpu;
> > @@ -623,6 +654,8 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
> >  			}
> >  		}
> >  
> > +		riscv_add_cpu_vendor_ext(cpu_node, cpu);
> > +
> >  		of_node_put(cpu_node);
> >  
> >  		/*
> > @@ -638,6 +671,8 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
> >  			bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
> >  		else
> >  			bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
> > +
> > +		set_riscv_isa_vendor(cpu);
> >  	}
> >  
> >  	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
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
> > +	&riscv_isa_vendor_ext_list_thead,
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
> > +obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)	+= thead.o
> > diff --git a/arch/riscv/kernel/vendor_extensions/thead.c b/arch/riscv/kernel/vendor_extensions/thead.c
> > new file mode 100644
> > index 000000000000..a0a47414ed22
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
> > +	_RISCV_ISA_EXT_DATA(xtheadvector, RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, NULL, 0),
> > +};
> > +
> > +/*
> > + * The first member of this struct must be a bitmap named isa so it can be
> > + * compatible with riscv_isainfo even though the sizes of the bitmaps may be
> > + * different.
> > + */
> > +struct riscv_isavendorinfo_thead {
> > +	DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
> > +};
> > +
> > +/* Hart specific T-Head vendor extension support */
> > +static struct riscv_isavendorinfo_thead hart_vendorinfo_thead[NR_CPUS];
> > +
> > +/* Set of T-Head vendor extensions supported on all harts */
> > +DECLARE_BITMAP(vendorinfo_thead, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
> > +
> > +const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead = {
> > +	.ext_data = riscv_isa_vendor_ext_thead,
> > +	.per_hart_vendor_bitmap = (struct riscv_isainfo *)hart_vendorinfo_thead,
> > +	.vendor_bitmap = vendorinfo_thead,
> > +	.ext_data_count = ARRAY_SIZE(riscv_isa_vendor_ext_thead),
> > +	.bitmap_size = RISCV_ISA_VENDOR_EXT_MAX_THEAD
> > +};
> > 
> > -- 
> > 2.44.0
> > 



