Return-Path: <linux-kselftest+bounces-8941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7638B40DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 22:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B0AB22D62
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 20:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CC62745D;
	Fri, 26 Apr 2024 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HMYw0pFh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A62C69B
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163665; cv=none; b=pxaj3Vhrl6Bqo7eYFaKhgeoPAViZHBEfyl2NhsPhdUXhwfrsnXgQEGutdYkEapS/2QDOPgKDd2YGMQ7qSMGb3lnC0Q9nBEtnXIBbaVP2xULtLg0DmKbrKejRAuGd7jtbq0OUfd2BC0afG4sbmof/ohb04CbbUAtAx5JsORgq1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163665; c=relaxed/simple;
	bh=kGfuIZLHk+e3pUxdjC/sJns0MXdNPwUjbXYjG5JbMvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmqc0UHNrf5EFTiWv4AmkoCs9wzFUiva8xcto0n3G3nOXtUd/qut3qtU43H6vDG041dfAhC1J/oi3Y8PO5PQl9/r7KXAZSIjtKs0tbBzmoORuLS6cwryGnxvf9TDL472mMexHCSazIn2/1ASrbhjla856wiw9NkGNSwiO1gmdBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HMYw0pFh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so2507342b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714163663; x=1714768463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RkjMMC1FpMNzMmAfWu9fZYy+vsjEC1qcX67/IWoyWAU=;
        b=HMYw0pFhej/LhXTOuh4XIbN7LuW7qi0Orzyc4KiYDUiPA2iiGAEsHJfI1fNVXDc3jD
         hkuDQMxZ6xeRltxQo/X7FzsUIFTbDWzIvN5sQPRqZnaEEG4nP6IR/XHvCTcBP47qrZ+F
         UIONlfZR2k49fE1ahg8WTa7YWZmpCwn6PA+NnWs+8RGPH08DC5Ws982MiottusE5n6pC
         PzzsNVtkJ5z6OBQYI1nKIn/BToEeje7kdjNUUaKKvIedfs6+hLfCnim9CK6rIHfSAe2P
         uGwLBFUY7vLqISI7O3VfGzHp/d8HCKl+kHMBGtFMh8+LgeYxo8r6KbBLQocbCtU9n5Ca
         n7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714163663; x=1714768463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkjMMC1FpMNzMmAfWu9fZYy+vsjEC1qcX67/IWoyWAU=;
        b=WSwzzOAo5oJ2FWLepGlIj6NLqTDyhD5FEeFI7t+UFnnyz6GHEgCjf/Wixn3sqK1Zk8
         fNT1a1UjWs8p6fh06ol2iePqy1V62ptud8KOcqnKUR8dnXnZO3WAchNsh8JuK5ulhC3v
         UCE6aYIMxWQvE+MVWol2Chi7b5CY8hZhfRPYskOSVA6jEcensmUemgmedAcRtN26CRFM
         evzrv1u8KJv4j03o9JyrLOqhqDeIQz2KhxoDcgm4JOgZYqo/bNm8tvTKvG0Rg5GNpTfs
         oN5gWolGrwgNFYFp2Fth6rN0aG+gzclpddHa8LivAZ6Ly4AJYAWkiMJEY37izTj0Mwiz
         qwsg==
X-Forwarded-Encrypted: i=1; AJvYcCUteYnAiRmBd8j8shVawhOpOkawLOZX0wnM/5ILS1hUa2jUgTLP5NsLFJysxz0ufEpr1Fo7Zpye0yCofJISm7SQtQqLwsMWpTkBYEofwQEX
X-Gm-Message-State: AOJu0YyJF1wjnuNyfEdWN1ZdQ1/DaziMDneXYh6H7fsdiIzKTN6vzi/6
	TnKobRbd6wrC/Xs0exLKt+pACFAWM7Ii/PFGHHX5nY18g6QFwkMAAx6BXFDU0lWg4iQvJi+uwLb
	P
X-Google-Smtp-Source: AGHT+IEvgUD/PdkO6EG/DCqCKciIHZlITQ+dtQj+SWgo8Fagf2mpBkl6Knmfmn7mLkCXbfb7r7pDbw==
X-Received: by 2002:a05:6a20:3ca3:b0:1a9:b3e9:a62c with SMTP id b35-20020a056a203ca300b001a9b3e9a62cmr4797475pzj.48.1714163663081;
        Fri, 26 Apr 2024 13:34:23 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:3b15:3aba:70a1:7ce9])
        by smtp.gmail.com with ESMTPSA id fv3-20020a056a00618300b006eb3c3db4afsm15223011pfb.186.2024.04.26.13.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 13:34:22 -0700 (PDT)
Date: Fri, 26 Apr 2024 13:34:19 -0700
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
Subject: Re: [PATCH v3 09/17] riscv: drivers: Convert xandespmu to use the
 vendor extension framework
Message-ID: <ZiwPyyBK2br8yKei@ghost>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
 <20240420-dev-charlie-support_thead_vector_6_9-v3-9-67cff4271d1d@rivosinc.com>
 <20240426-venue-maximum-f78ac451b146@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426-venue-maximum-f78ac451b146@spud>

On Fri, Apr 26, 2024 at 05:25:20PM +0100, Conor Dooley wrote:
> On Sat, Apr 20, 2024 at 06:04:41PM -0700, Charlie Jenkins wrote:
> > Migrate xandespmu out of riscv_isa_ext and into a new Andes-specific
> > vendor namespace.
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> > index 8cbe6e5f9c39..84760ce61e03 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -24,6 +24,8 @@
> >  #include <asm/errata_list.h>
> >  #include <asm/sbi.h>
> >  #include <asm/cpufeature.h>
> > +#include <asm/vendorid_list.h>
> > +#include <asm/vendor_extensions/andes.h>
> >  
> >  #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
> >  asm volatile(ALTERNATIVE_2(						\
> > @@ -32,7 +34,7 @@ asm volatile(ALTERNATIVE_2(						\
> >  		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
> >  		CONFIG_ERRATA_THEAD_PMU,				\
> >  	"csrr %0, " __stringify(ANDES_CSR_SCOUNTEROF),			\
> > -		0, RISCV_ISA_EXT_XANDESPMU,				\
> > +		ANDES_VENDOR_ID, RISCV_ISA_VENDOR_EXT_XANDESPMU,	\
> >  		CONFIG_ANDES_CUSTOM_PMU)				\
> >  	: "=r" (__ovl) :						\
> >  	: "memory")
> > @@ -41,7 +43,7 @@ asm volatile(ALTERNATIVE_2(						\
> >  asm volatile(ALTERNATIVE(						\
> >  	"csrc " __stringify(CSR_IP) ", %0\n\t",				\
> >  	"csrc " __stringify(ANDES_CSR_SLIP) ", %0\n\t",			\
> > -		0, RISCV_ISA_EXT_XANDESPMU,				\
> > +		ANDES_VENDOR_ID, RISCV_ISA_VENDOR_EXT_XANDESPMU,	\
> >  		CONFIG_ANDES_CUSTOM_PMU)				\
> >  	: : "r"(__irq_mask)						\
> >  	: "memory")
> > @@ -837,7 +839,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
> >  		   riscv_cached_mimpid(0) == 0) {
> >  		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
> >  		riscv_pmu_use_irq = true;
> > -	} else if (riscv_isa_extension_available(NULL, XANDESPMU) &&
> > +	} else if (riscv_isa_vendor_extension_available(-1, XANDESPMU) &&
> 
> What's the rationale for this not using riscv_has_extension_unlikely()?
> Happens once in probe so don't bother? I forget if we discussed it when
> the code was added, but it would save us from the NULL/-1 syntax,
> neither of which I think is a good interface.

Doesn't look like something that was ever commented on in the series,
but I may have missed it. I can change this to use the alternatives.

This also wasn't supposed to be -1, it's supposed to be the id of the
vendor.

> 
> Also, I'd prob drop the "drivers" from $subject.
> 
> I'll come back and look at the rest of this Monday, it's a sunny Friday
> here and I've still got my devicetree patch queue to clear..
> 

- Charlie

> Cheers,
> Conor.
> 
> >  		   IS_ENABLED(CONFIG_ANDES_CUSTOM_PMU)) {
> >  		riscv_pmu_irq_num = ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ_PMOVI;
> >  		riscv_pmu_use_irq = true;
> > 
> > -- 
> > 2.44.0
> > 



