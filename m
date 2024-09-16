Return-Path: <linux-kselftest+bounces-18043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A6A97A763
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 20:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530F91C208A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 18:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E0115ADAF;
	Mon, 16 Sep 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0GnU0Vd9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6FD4594D
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512253; cv=none; b=bxvgTdAQmK2kWb9SQJ36lmsCyBoTGsZYpW9sN3A74oiwTKjmeXMW5eBxMx1F8tvqb2C19crdoAZnt1oSyGfnLQpD/9yYQfYA4Wzr6J2Acm+7UlNW6/PQB6wWgHIFUMIR6Udwm5z5W7DrOnYKBYpiJ0yl5y5vYVkULcdhXGbrzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512253; c=relaxed/simple;
	bh=H3HlwZCZEQDhvatizrRzbggWa+HA/p1z1pp/lBdDDYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkXPmX0qwXjlWYBdewMKqESHJtyGqKe8YNQ09VERoYahH9UvrBamwOGlemEWKLTqwmfBSDi//iDtgLc9niydDkO/+8RY0D+ZFuvWpdIq5M8Vd6SEfqimBSYuydluz7Crupr/iWq89d1MBN+BIcxHdYvL/aB7b1dw3w67pOU6GUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0GnU0Vd9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2053525bd90so31445105ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726512250; x=1727117050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JWRt0WDZ9DWFdEsHGfP3sRZRYldXkufLSIbgP8dWZKY=;
        b=0GnU0Vd9IvsLq94GTOgkoUy/5qRtZMpyL18oo23qu3bQ79cZ6fWjGIoEoAAVuFiXNC
         OHOBE1ctDOV4RMzLzfZJzwrLSJG5435Ld4xGk0J8QXYNH1pR7zVjzCCTl4Baj2+x8y5X
         +ZrbJHqCLpJvrDf1ZVAIPqXIeuDRXcV5ntLSmaICB77uFlTHD7tmpPTwAQFjFMHbfBXq
         Vd6j5ppm6yG3bsOUIwRWnKEXocHD+bb569/cKNH2Y2Q+zYYUiRR7e5bFESK+77M42rww
         5vTTA5gAFvqsTLFhwTm70AgAjhC4vmk/NF63pxJq00LR1dvEfw6i1p0pNFgeJluRK+PF
         J4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726512250; x=1727117050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWRt0WDZ9DWFdEsHGfP3sRZRYldXkufLSIbgP8dWZKY=;
        b=Vf6gG/68x1KoztctjXb41Fa9FHYN9N94LOP63MklvkYuafPOfH+mcnigPEsmTW5UwL
         rwhh/ksJ96v1mUscVPubJWHGYBlRv9fiPUCOOrWg+VzPXQztA04gZ+DOo0rYf488sW3P
         qavhoer9EZ5lv6wRt+IykthhA+mccWaGd9utF6P93iYPmUID57XaEeRSOjuLyMKY7CC8
         wgg8XK3YAFuB32uXE3oyJYed4UTmyB/EBGgIWgUQwz28mE3Re34pNeJX19cBHIa7KLPW
         iXZIOvYuJqXbk52ck+LUMBh7ztD55BlOh+mAZgbawgORip0ucyIO+qvOfrlciemOMKn9
         CdKw==
X-Forwarded-Encrypted: i=1; AJvYcCXm0MEZ/D81LHIwNmmj9k+JU7Y47eb7wPXhJt+H6en/FrtfhZLRSzY4K714/xifflzBOzE/Mk6gJDaWyKhZHL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVdmuzTZr9QHd19DOerCsVBJCgcAm0PZZb2YkNpFNrOx33p/0j
	eSyMIU90AYor4+gsx7/nSbDfRhKcpwxFrH1kNGgh3IWWeDLHGwj2NewVyS8A45U=
X-Google-Smtp-Source: AGHT+IF8dispIWAu4SBpBRXvJsNyO6F3tbYcZrnsVzU7MIvT/flk7KgGQY9i8SqZ41S7cO9LZnYSGg==
X-Received: by 2002:a17:90b:1c81:b0:2d8:7307:3f74 with SMTP id 98e67ed59e1d1-2dbb9f31cf2mr13931669a91.27.1726512250018;
        Mon, 16 Sep 2024 11:44:10 -0700 (PDT)
Received: from ghost ([216.9.110.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfcf7f3fsm5689098a91.14.2024.09.16.11.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 11:44:09 -0700 (PDT)
Date: Mon, 16 Sep 2024 11:44:04 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 14/14] riscv: Add ghostwrite vulnerability
Message-ID: <Zuh8dLsA50IHXymz@ghost>
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
 <20240911-xtheadvector-v10-14-8d3930091246@rivosinc.com>
 <20240916-pretext-freehand-20dca1376cd4@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916-pretext-freehand-20dca1376cd4@spud>

On Mon, Sep 16, 2024 at 06:12:04PM +0100, Conor Dooley wrote:
> On Wed, Sep 11, 2024 at 10:55:22PM -0700, Charlie Jenkins wrote:
> > Follow the patterns of the other architectures that use
> > GENERIC_CPU_VULNERABILITIES for riscv to introduce the ghostwrite
> > vulnerability and mitigation. The mitigation is to disable all vector
> > which is accomplished by clearing the bit from the cpufeature field.
> > 
> > Ghostwrite only affects thead c9xx CPUs that impelment xtheadvector, so
> > the vulerability will only be mitigated on these CPUs.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig.errata            | 11 ++++++++
> >  arch/riscv/errata/thead/errata.c     | 28 ++++++++++++++++++
> >  arch/riscv/include/asm/bugs.h        | 22 +++++++++++++++
> >  arch/riscv/include/asm/errata_list.h |  3 +-
> >  arch/riscv/kernel/Makefile           |  2 ++
> >  arch/riscv/kernel/bugs.c             | 55 ++++++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/cpufeature.c       |  9 +++++-
> >  drivers/base/cpu.c                   |  3 ++
> >  include/linux/cpu.h                  |  1 +
> >  9 files changed, 132 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> > index 2acc7d876e1f..e318119d570d 100644
> > --- a/arch/riscv/Kconfig.errata
> > +++ b/arch/riscv/Kconfig.errata
> > @@ -119,4 +119,15 @@ config ERRATA_THEAD_PMU
> >  
> >  	  If you don't know what to do here, say "Y".
> >  
> > +config ERRATA_THEAD_GHOSTWRITE
> > +	bool "Apply T-Head Ghostwrite errata"
> > +	depends on ERRATA_THEAD && RISCV_ISA_XTHEADVECTOR
> > +	default y
> > +	help
> > +	  The T-Head C9xx cores have a vulnerability in the xtheadvector
> > +	  instruction set. When this errata is enabled, the CPUs will be probed
> > +	  to determine if they are vulnerable and disable xtheadvector.
> > +
> > +	  If you don't know what to do here, say "Y".
> > +
> >  endmenu # "CPU errata selection"
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> > index f5120e07c318..5cc008ab41a8 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/string.h>
> >  #include <linux/uaccess.h>
> >  #include <asm/alternative.h>
> > +#include <asm/bugs.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/dma-noncoherent.h>
> > @@ -142,6 +143,31 @@ static bool errata_probe_pmu(unsigned int stage,
> >  	return true;
> >  }
> >  
> > +static bool errata_probe_ghostwrite(unsigned int stage,
> > +				    unsigned long arch_id, unsigned long impid)
> > +{
> > +	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_GHOSTWRITE))
> > +		return false;
> > +
> > +	/*
> > +	 * target-c9xx cores report arch_id and impid as 0
> > +	 *
> > +	 * While ghostwrite may not affect all c9xx cores that implement
> > +	 * xtheadvector, there is no futher granularity than c9xx. Assume
> > +	 * vulnerable for this entire class of processors when xtheadvector is
> > +	 * enabled.
> > +	 */
> 
> Is it not possible to use the cpu compatible string for this? Given that
> we only know if xtheadvector is enabled once we are already parsing the
> cpu node devicetree, it seems, to me, as if it should be possible to be
> more granular. AFAIU, some T-Head c900 series devices are not venerable.

Sure we can do that. I figured that since T-Head didn't feel it was
valuable to change the archid/implid between cores that Linux shouldn't
go out of its way to fix the granularity issue. Since you think it is
worthwhile though, I can try to work around this hardware issue.

- Charlie

> 
> Cheers,
> Conor.
> 
> > +	if (arch_id != 0 || impid != 0)
> > +		return false;
> > +
> > +	if (stage != RISCV_ALTERNATIVES_EARLY_BOOT)
> > +		return false;
> > +
> > +	ghostwrite_set_vulnerable();
> > +
> > +	return true;
> > +}
> > +
> >  static u32 thead_errata_probe(unsigned int stage,
> >  			      unsigned long archid, unsigned long impid)
> >  {
> > @@ -155,6 +181,8 @@ static u32 thead_errata_probe(unsigned int stage,
> >  	if (errata_probe_pmu(stage, archid, impid))
> >  		cpu_req_errata |= BIT(ERRATA_THEAD_PMU);
> >  
> > +	errata_probe_ghostwrite(stage, archid, impid);
> > +
> >  	return cpu_req_errata;
> >  }
> >  
> > diff --git a/arch/riscv/include/asm/bugs.h b/arch/riscv/include/asm/bugs.h
> > new file mode 100644
> > index 000000000000..e294b15bf78e
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/bugs.h
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Interface for managing mitigations for riscv vulnerabilities.
> > + *
> > + * Copyright (C) 2024 Rivos Inc.
> > + */
> > +
> > +#ifndef __ASM_BUGS_H
> > +#define __ASM_BUGS_H
> > +
> > +/* Watch out, ordering is important here. */
> > +enum mitigation_state {
> > +	UNAFFECTED,
> > +	MITIGATED,
> > +	VULNERABLE,
> > +};
> > +
> > +void ghostwrite_set_vulnerable(void);
> > +void ghostwrite_enable_mitigation(void);
> > +enum mitigation_state ghostwrite_get_state(void);
> > +
> > +#endif /* __ASM_BUGS_H */
> > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> > index 7c8a71a526a3..6e426ed7919a 100644
> > --- a/arch/riscv/include/asm/errata_list.h
> > +++ b/arch/riscv/include/asm/errata_list.h
> > @@ -25,7 +25,8 @@
> >  #ifdef CONFIG_ERRATA_THEAD
> >  #define	ERRATA_THEAD_MAE 0
> >  #define	ERRATA_THEAD_PMU 1
> > -#define	ERRATA_THEAD_NUMBER 2
> > +#define	ERRATA_THEAD_GHOSTWRITE 2
> > +#define	ERRATA_THEAD_NUMBER 3
> >  #endif
> >  
> >  #ifdef __ASSEMBLY__
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 06d407f1b30b..d7a54e34178e 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -113,3 +113,5 @@ obj-$(CONFIG_COMPAT)		+= compat_vdso/
> >  obj-$(CONFIG_64BIT)		+= pi/
> >  obj-$(CONFIG_ACPI)		+= acpi.o
> >  obj-$(CONFIG_ACPI_NUMA)	+= acpi_numa.o
> > +
> > +obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) += bugs.o
> > diff --git a/arch/riscv/kernel/bugs.c b/arch/riscv/kernel/bugs.c
> > new file mode 100644
> > index 000000000000..0c19691b4cd5
> > --- /dev/null
> > +++ b/arch/riscv/kernel/bugs.c
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2024 Rivos Inc.
> > + */
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/device.h>
> > +#include <linux/sprintf.h>
> > +
> > +#include <asm/bugs.h>
> > +#include <asm/vendor_extensions/thead.h>
> > +
> > +static enum mitigation_state ghostwrite_state;
> > +
> > +void ghostwrite_set_vulnerable(void)
> > +{
> > +	ghostwrite_state = VULNERABLE;
> > +}
> > +
> > +/*
> > + * Vendor extension alternatives will use the value set at the time of boot
> > + * alternative patching, thus this must be called before boot alternatives are
> > + * patched (and after extension probing) to be effective.
> > + */
> > +void ghostwrite_enable_mitigation(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR) &&
> > +	    ghostwrite_state == VULNERABLE && !cpu_mitigations_off()) {
> > +		disable_xtheadvector();
> > +		ghostwrite_state = MITIGATED;
> > +	}
> > +}
> > +
> > +enum mitigation_state ghostwrite_get_state(void)
> > +{
> > +	return ghostwrite_state;
> > +}
> > +
> > +ssize_t cpu_show_ghostwrite(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR)) {
> > +		switch (ghostwrite_state) {
> > +		case UNAFFECTED:
> > +			return sprintf(buf, "Not affected\n");
> > +		case MITIGATED:
> > +			return sprintf(buf, "Mitigation: xtheadvector disabled\n");
> > +		case VULNERABLE:
> > +			fallthrough;
> > +		default:
> > +			return sprintf(buf, "Vulnerable\n");
> > +		}
> > +	} else {
> > +		return sprintf(buf, "Not affected\n");
> > +	}
> > +}
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 56b5054b8f86..1f4329bb8a9d 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/of.h>
> >  #include <asm/acpi.h>
> >  #include <asm/alternative.h>
> > +#include <asm/bugs.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/hwcap.h>
> > @@ -867,7 +868,13 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
> >  		riscv_fill_vendor_ext_list(cpu);
> >  	}
> >  
> > -	if (has_xtheadvector_no_alternatives() && has_thead_homogeneous_vlenb() < 0) {
> > +	/*
> > +	 * Execute ghostwrite mitigation immediately after detecting extensions
> > +	 * to disable xtheadvector if necessary.
> > +	 */
> > +	if (ghostwrite_get_state() == VULNERABLE) {
> > +		ghostwrite_enable_mitigation();
> > +	} else if (has_xtheadvector_no_alternatives() && has_thead_homogeneous_vlenb() < 0) {
> >  		pr_warn("Unsupported heterogeneous vlenb detected, vector extension disabled.\n");
> >  		disable_xtheadvector();
> >  	}
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index fdaa24bb641a..a7e511849875 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -599,6 +599,7 @@ CPU_SHOW_VULN_FALLBACK(retbleed);
> >  CPU_SHOW_VULN_FALLBACK(spec_rstack_overflow);
> >  CPU_SHOW_VULN_FALLBACK(gds);
> >  CPU_SHOW_VULN_FALLBACK(reg_file_data_sampling);
> > +CPU_SHOW_VULN_FALLBACK(ghostwrite);
> >  
> >  static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
> >  static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
> > @@ -614,6 +615,7 @@ static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
> >  static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
> >  static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
> >  static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
> > +static DEVICE_ATTR(ghostwrite, 0444, cpu_show_ghostwrite, NULL);
> >  
> >  static struct attribute *cpu_root_vulnerabilities_attrs[] = {
> >  	&dev_attr_meltdown.attr,
> > @@ -630,6 +632,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
> >  	&dev_attr_spec_rstack_overflow.attr,
> >  	&dev_attr_gather_data_sampling.attr,
> >  	&dev_attr_reg_file_data_sampling.attr,
> > +	&dev_attr_ghostwrite.attr,
> >  	NULL
> >  };
> >  
> > diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> > index bdcec1732445..6a0a8f1c7c90 100644
> > --- a/include/linux/cpu.h
> > +++ b/include/linux/cpu.h
> > @@ -77,6 +77,7 @@ extern ssize_t cpu_show_gds(struct device *dev,
> >  			    struct device_attribute *attr, char *buf);
> >  extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
> >  					       struct device_attribute *attr, char *buf);
> > +extern ssize_t cpu_show_ghostwrite(struct device *dev, struct device_attribute *attr, char *buf);
> >  
> >  extern __printf(4, 5)
> >  struct device *cpu_device_create(struct device *parent, void *drvdata,
> > 
> > -- 
> > 2.45.0
> > 



