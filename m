Return-Path: <linux-kselftest+bounces-8940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997A8B409A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 22:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D690B28B7A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 20:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B9C28377;
	Fri, 26 Apr 2024 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zvxPcDlj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12DB1CFBC
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161680; cv=none; b=NUlCTKefS5UwKSnOkEdVEvPonjE5EuFuHK+gEW9wURx3+S7QF8gfMYRHdI0OVPbIcba3pOTYeHV6xJ3fLt1JBG2gibDqcovxotbzdDwfKOyibVNa8y/iJFMWsnZ6XPOINxlF3Ol7hw0iEwPCQx4nhvfqTNvmZFmW/lPLfjb0eZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161680; c=relaxed/simple;
	bh=JacmjHIRjJ44cx4iSMHTqqEgRw8n5VJ8ckvrEsjcarw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCsj9DWhV+jWmNPMQlFvHU3pimv8LqlN1ZlM3gamC6iKEq9QeaJC9AM2hBmJPNKFoEbyTEJRDcaUp6zsdh/f0XYDtZsfqapUWbEBYXfu6EFAxx79G5lfMRHke6gUDqUy8fx1+f6j+rYtsqCqorJnd3H0sHMVCmwqabPaO80mt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zvxPcDlj; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso2139793a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714161676; x=1714766476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=raghWWuWmM/5TZJC4kDKpgJQ4hXCQAZ4Q/dcRR9ZX90=;
        b=zvxPcDlj1Ba9Bo5d5oM4IL9seunvfqUktYh6uCp92TKNbNv+aQkAa5R1ddK8nUUr63
         4Pb34ccaeW/fC0wDU/FA0ks9vCacL3n98gHSOyGAqBP3nNxY80MELtRtVEoDMTeG+oN+
         5rRvhCWy9nc27pKY5iG7gB5hkSHwYLA8ltVPGnCgre6MtYWpcMPk5BdNR7y47Om5GATr
         2SEAekt487Qw6VNkgYvWK1tj+TFKhlIEHRHV0w1Xqbe+6GlSW+ZxSCrtDesTmURqCqgO
         dEbpmdyvv1TdjgSGUFDFNmArM4dezh3yw7Tn9Mz4e37dacRDhQ+u/K7k62Cu1PctVk1Z
         MPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714161676; x=1714766476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raghWWuWmM/5TZJC4kDKpgJQ4hXCQAZ4Q/dcRR9ZX90=;
        b=oZtfFrEVZmnGpjx3f2NT5QUE4CE0XHVofmbISjxnXUnGwqqUpKAYclBpnynU3d17ms
         bCoqUgeihEyWGu7Eb940qj3UIirrgbUpmu0MxgVQ9Yp1Fe4KJhiiKWPa8a12kBZS4nKn
         XcE/Em5U3520s5B9mZ1GIRzPxzwpjXLQZVAhOXu4BCf2/8HLyySroCp9hBDadv3kH18Z
         z6meyLxgNK0dgLJFkxBsE1VdP31CZ8wPAOGeM9qZZfTs8X9s5Dtt6PbAUpsNDi6rX20X
         BqqPTN2yptTAeidlvskvqM4XqxdpS8pMQIWJEEzAFP6dzEAgD+6GRQGuz1K0wrCK5k1+
         wCgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn9sMHbFinknONGzyzFVQwr7P+hzwCGun96g9AhumhUzv/5xFRjKn7aksdiSlF+JmjAlGUYJfnSCiwdIgn3mPKuZ+QvC/TGrcakUYPeoDg
X-Gm-Message-State: AOJu0YwmrzLvTx0gdQWfj56kv8xdmZhQM5lBLrNAL0Rp19b5eYN63Ubi
	Qj/SPGyvszFlYLL2yqJHusE1sTh0U1xUy5EQYk7pWDOOhiqwoX8dpJLmv8Urnzw=
X-Google-Smtp-Source: AGHT+IGZxLUwYQbkZfhTACgCMYLPnuJOtrr+IfS6fDS+sMRgvJF5Hn9EpqDDgcmVhTluvK+/7Qvf6w==
X-Received: by 2002:a17:90b:3741:b0:2a5:395e:8673 with SMTP id ne1-20020a17090b374100b002a5395e8673mr674149pjb.5.1714161675889;
        Fri, 26 Apr 2024 13:01:15 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:3b15:3aba:70a1:7ce9])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a5e4600b002a5d71d48e8sm16583852pji.39.2024.04.26.13.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 13:01:14 -0700 (PDT)
Date: Fri, 26 Apr 2024 13:01:10 -0700
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
Subject: Re: [PATCH v3 08/17] riscv: Introduce vendor variants of extension
 helpers
Message-ID: <ZiwIBmlaDbYdmv8f@ghost>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
 <20240420-dev-charlie-support_thead_vector_6_9-v3-8-67cff4271d1d@rivosinc.com>
 <20240426-myself-crowbar-99dc0a080cd9@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426-myself-crowbar-99dc0a080cd9@spud>

On Fri, Apr 26, 2024 at 05:19:59PM +0100, Conor Dooley wrote:
> On Sat, Apr 20, 2024 at 06:04:40PM -0700, Charlie Jenkins wrote:
> > Vendor extensions are maintained in per-vendor structs (separate from
> > standard extensions which live in riscv_isa). Create vendor variants for
> > the existing extension helpers to interface with the riscv_isa_vendor
> > bitmaps.
> 
> > There is a good amount of overlap between these functions, so
> > the alternative checking code can be factored out.
> 
> Can you please split this out?

Sure.

> 
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/errata/sifive/errata.c          |  3 ++
> >  arch/riscv/errata/thead/errata.c           |  3 ++
> >  arch/riscv/include/asm/cpufeature.h        | 86 +++++++++++++++++-------------
> >  arch/riscv/include/asm/vendor_extensions.h | 56 +++++++++++++++++++
> >  arch/riscv/kernel/cpufeature.c             | 20 ++++---
> >  arch/riscv/kernel/vendor_extensions.c      | 40 ++++++++++++++
> >  6 files changed, 164 insertions(+), 44 deletions(-)
> > 
> > diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
> > index 3d9a32d791f7..b29b6e405ff2 100644
> > --- a/arch/riscv/errata/sifive/errata.c
> > +++ b/arch/riscv/errata/sifive/errata.c
> > @@ -12,6 +12,7 @@
> >  #include <asm/alternative.h>
> >  #include <asm/vendorid_list.h>
> >  #include <asm/errata_list.h>
> > +#include <asm/vendor_extensions.h>
> >  
> >  struct errata_info_t {
> >  	char name[32];
> > @@ -99,6 +100,8 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> >  	for (alt = begin; alt < end; alt++) {
> >  		if (alt->vendor_id != SIFIVE_VENDOR_ID)
> >  			continue;
> > +		if (alt->patch_id >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE)
> > +			continue;
> >  		if (alt->patch_id >= ERRATA_SIFIVE_NUMBER) {
> >  			WARN(1, "This errata id:%d is not in kernel errata list", alt->patch_id);
> >  			continue;
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> > index b1c410bbc1ae..d8e78cc687bc 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -18,6 +18,7 @@
> >  #include <asm/io.h>
> >  #include <asm/patch.h>
> >  #include <asm/vendorid_list.h>
> > +#include <asm/vendor_extensions.h>
> >  
> >  static bool errata_probe_pbmt(unsigned int stage,
> >  			      unsigned long arch_id, unsigned long impid)
> > @@ -163,6 +164,8 @@ void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> >  	for (alt = begin; alt < end; alt++) {
> >  		if (alt->vendor_id != THEAD_VENDOR_ID)
> >  			continue;
> > +		if (alt->patch_id >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE)
> > +			continue;
> 
> >  		if (alt->patch_id >= ERRATA_THEAD_NUMBER)
> 
> This number is 2, how does the patching actually work for vendor stuff
> when the base is always greater than 2?
> 

Patching is handled through the patcher at the end of cpufeature.c. The
vendor_id field is set in the alternatives for errata and now also for
vendor extensions. The vendor extension patching is all handled
generically.

This is distinguished by the patch_id being greater than
RISCV_VENDOR_EXT_ALTERNATIVES_BASE, which should leave way more than
enough room for errata ids. Since the code already checks if the
patch_id is greater than the errata number, I can drop the
"if (alt->patch_id >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE)" check.

> >  			continue;
> >  
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > index db6a6d7d6b2e..83e1143db9ad 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -103,22 +103,13 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
> >  	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
> >  
> >  static __always_inline bool
> > -riscv_has_extension_likely(const unsigned long ext)
> > +__riscv_has_extension_likely_alternatives(const unsigned long vendor, const unsigned long ext)
> >  {
> > -	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> > -			   "ext must be < RISCV_ISA_EXT_MAX");
> > -
> > -	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > -		asm goto(
> > -		ALTERNATIVE("j	%l[l_no]", "nop", 0, %[ext], 1)
> > -		:
> > -		: [ext] "i" (ext)
> > -		:
> > -		: l_no);
> > -	} else {
> > -		if (!__riscv_isa_extension_available(NULL, ext))
> > -			goto l_no;
> > -	}
> > +	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
> > +	:
> > +	: [vendor] "i" (vendor), [ext] "i" (ext)
> > +	:
> > +	: l_no);
> >  
> >  	return true;
> >  l_no:
> > @@ -126,42 +117,65 @@ riscv_has_extension_likely(const unsigned long ext)
> >  }
> >  
> >  static __always_inline bool
> > -riscv_has_extension_unlikely(const unsigned long ext)
> > +__riscv_has_extension_unlikely_alternatives(const unsigned long vendor, const unsigned long ext)
> 
> ngl, I think you could drop the _alternatives from these - the
> likely/unlikely is only actually a thing because of the alternatives in
> the first place & just retain the __ as a differentiator. That'd help
> you with some of the long-line wrangling you've been doing below.
> 

Sounds good.

> >  {
> > -	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> > -			   "ext must be < RISCV_ISA_EXT_MAX");
> > -
> > -	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > -		asm goto(
> > -		ALTERNATIVE("nop", "j	%l[l_yes]", 0, %[ext], 1)
> > -		:
> > -		: [ext] "i" (ext)
> > -		:
> > -		: l_yes);
> > -	} else {
> > -		if (__riscv_isa_extension_available(NULL, ext))
> > -			goto l_yes;
> > -	}
> > +	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
> > +	:
> > +	: [vendor] "i" (vendor), [ext] "i" (ext)
> > +	:
> > +	: l_yes);
> >  
> >  	return false;
> >  l_yes:
> >  	return true;
> >  }
> >  
> > +static __always_inline bool
> > +riscv_has_extension_likely(const unsigned long ext)
> 
> Can you format this so that its on one line & wrap the arguments if
> needs be?
> 
> > +{
> > +	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> > +			   "ext must be < RISCV_ISA_EXT_MAX");
> > +
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> > +		return __riscv_has_extension_likely_alternatives(0, ext);
> > +	else
> 
> I'm almost certain I said this before, but none of the else branches are
> needed here, there's a return in the if branch, so the remainder of the
> function becomes unconditionally executed.

Will fix.

> 
> > +		return __riscv_isa_extension_available(NULL, ext);
> > +}
> > +
> > +static __always_inline bool
> > +riscv_has_extension_unlikely(const unsigned long ext)
> > +{
> > +	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> > +			   "ext must be < RISCV_ISA_EXT_MAX");
> > +
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> > +		return __riscv_has_extension_unlikely_alternatives(0, ext);
> > +	else
> > +		return __riscv_isa_extension_available(NULL, ext);
> > +}
> > +
> >  static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const unsigned long ext)
> >  {
> > -	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_likely(ext))
> > -		return true;
> > +	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> > +			   "ext must be < RISCV_ISA_EXT_MAX");
> >  
> > -	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
> > +	    __riscv_has_extension_likely_alternatives(0, ext))
> 
> 0 is meaningless, please make this more understandable using a define of
> some sort.

I'll add a define.

> 
> > +		return true;
> > +	else
> > +		return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> >  }
> >  
> >  static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsigned long ext)
> >  {
> > -	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_unlikely(ext))
> > -		return true;
> > +	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> > +			   "ext must be < RISCV_ISA_EXT_MAX");
> >  
> > -	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
> > +	    __riscv_has_extension_unlikely_alternatives(0, ext))
> > +		return true;
> > +	else
> > +		return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> >  }
> >  
> >  #endif
> > diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/include/asm/vendor_extensions.h
> > index 0af1ddd0af70..3e676a96016e 100644
> > --- a/arch/riscv/include/asm/vendor_extensions.h
> > +++ b/arch/riscv/include/asm/vendor_extensions.h
> > @@ -23,4 +23,60 @@ extern const struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[];
> >  
> >  extern const size_t riscv_isa_vendor_ext_list_size;
> >  
> > +/*
> > + * The alternatives need some way of distinguishing between vendor extensions
> > + * and errata. Incrementing all of the vendor extension keys so they are at
> > + * least 0x8000 accomplishes that.
> > + */
> > +#define RISCV_VENDOR_EXT_ALTERNATIVES_BASE	0x8000
> > +
> > +bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsigned int bit);
> > +#define riscv_cpu_isa_vendor_extension_available(cpu, vendor, ext)	\
> > +	__riscv_isa_vendor_extension_available(cpu, vendor, RISCV_ISA_VENDOR_EXT_##ext)
> > +#define riscv_isa_vendor_extension_available(vendor, ext)	\
> > +	__riscv_isa_vendor_extension_available(-1, vendor, RISCV_ISA_VENDOR_EXT_##ext)
> > +
> > +static __always_inline bool
> > +riscv_has_vendor_extension_likely(const unsigned long vendor, const unsigned long ext)
> > +{
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> > +		return __riscv_has_extension_likely_alternatives(vendor,
> > +								 ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
> > +	else
> > +		return __riscv_isa_vendor_extension_available(-1, vendor, ext);
> > +}
> > +
> > +static __always_inline bool
> > +riscv_has_vendor_extension_unlikely(const unsigned long vendor, const unsigned long ext)
> > +{
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> > +		return __riscv_has_extension_unlikely_alternatives(vendor,
> > +								   ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
> > +	else
> > +		return __riscv_isa_vendor_extension_available(-1, vendor, ext);
> > +}
> > +
> > +static __always_inline bool riscv_cpu_has_vendor_extension_likely(const unsigned long vendor,
> > +								  int cpu, const unsigned long ext)
> > +{
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
> > +	    __riscv_has_extension_likely_alternatives(vendor,
> > +						      ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE))
> > +		return true;
> > +	else
> > +		return __riscv_isa_vendor_extension_available(cpu, vendor, ext);
> > +}
> > +
> > +static __always_inline bool riscv_cpu_has_vendor_extension_unlikely(const unsigned long vendor,
> > +								    int cpu,
> > +								    const unsigned long ext)
> > +{
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
> > +	    __riscv_has_extension_unlikely_alternatives(vendor,
> > +							ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE))
> > +		return true;
> > +	else
> > +		return __riscv_isa_vendor_extension_available(cpu, vendor, ext);
> > +}
> > +
> >  #endif /* _ASM_VENDOR_EXTENSIONS_H */
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index c9f36822e337..17371887abcc 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -833,25 +833,29 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
> >  {
> >  	struct alt_entry *alt;
> >  	void *oldptr, *altptr;
> > -	u16 id, value;
> > +	u16 id, value, vendor;
> >  
> >  	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> >  		return;
> >  
> >  	for (alt = begin; alt < end; alt++) {
> > -		if (alt->vendor_id != 0)
> > -			continue;
> > -
> >  		id = PATCH_ID_CPUFEATURE_ID(alt->patch_id);
> > +		vendor = PATCH_ID_CPUFEATURE_ID(alt->vendor_id);
> >  
> > -		if (id >= RISCV_ISA_EXT_MAX) {
> > +		if (id < RISCV_ISA_EXT_MAX) {
> 
> I think any reliance on the standard ext max requires a comment
> explaining what the interaction is between it and the vendor stuff.
>

I'll add a comment describing that anything with an id below
RISCV_ISA_EXT_MAX is interpreted as a standard extension and anything
with an id above RISCV_VENDOR_EXT_ALTERNATIVES_BASE will be interpreted
as a vendor extension.

> > +			if (alt->vendor_id != 0)
> > +				continue;
> 
> If this happens, it's a bug, should we be continuing silently?
> 

This indicates that the patch should be treated as errata and that's why
it silently continues. I can add a comment that says that.

- Charlie

> Cheers,
> Conor.
> 
> > +
> > +			if (!__riscv_isa_extension_available(NULL, id))
> > +				continue;
> > +		} else if (id >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE) {
> > +			if (!__riscv_isa_vendor_extension_available(-1, vendor, id))
> > +				continue;
> > +		} else {
> >  			WARN(1, "This extension id:%d is not in ISA extension list", id);
> >  			continue;
> >  		}
> >  
> > -		if (!__riscv_isa_extension_available(NULL, id))
> > -			continue;
> > -
> >  		value = PATCH_ID_CPUFEATURE_VALUE(alt->patch_id);
> >  		if (!riscv_cpufeature_patch_check(id, value))
> >  			continue;
> > diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
> > index f76cb3013c2d..eced93eec5a6 100644
> > --- a/arch/riscv/kernel/vendor_extensions.c
> > +++ b/arch/riscv/kernel/vendor_extensions.c
> > @@ -3,6 +3,7 @@
> >   * Copyright 2024 Rivos, Inc
> >   */
> >  
> > +#include <asm/vendorid_list.h>
> >  #include <asm/vendor_extensions.h>
> >  #include <asm/vendor_extensions/thead.h>
> >  
> > @@ -16,3 +17,42 @@ const struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[] = {
> >  };
> >  
> >  const size_t riscv_isa_vendor_ext_list_size = ARRAY_SIZE(riscv_isa_vendor_ext_list);
> > +
> > +/**
> > + * __riscv_isa_vendor_extension_available() - Check whether given vendor
> > + * extension is available or not.
> > + *
> > + * @cpu: check if extension is available on this cpu
> > + * @vendor: vendor that the extension is a member of
> > + * @bit: bit position of the desired extension
> > + * Return: true or false
> > + *
> > + * NOTE: When cpu is -1, will check if extension is available on all cpus
> > + */
> > +bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsigned int bit)
> > +{
> > +	unsigned long *bmap;
> > +	struct riscv_isainfo *cpu_bmap;
> > +	size_t bmap_size;
> > +
> > +	switch (vendor) {
> > +#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
> > +	case THEAD_VENDOR_ID:
> > +		bmap = riscv_isa_vendor_ext_list_thead.vendor_bitmap;
> > +		cpu_bmap = riscv_isa_vendor_ext_list_thead.per_hart_vendor_bitmap;
> > +		bmap_size = riscv_isa_vendor_ext_list_thead.bitmap_size;
> > +		break;
> > +#endif
> > +	default:
> > +		return false;
> > +	}
> > +
> > +	if (cpu != -1)
> > +		bmap = cpu_bmap[cpu].isa;
> > +
> > +	if (bit >= bmap_size)
> > +		return false;
> > +
> > +	return test_bit(bit, bmap) ? true : false;
> > +}
> > +EXPORT_SYMBOL_GPL(__riscv_isa_vendor_extension_available);
> > 
> > -- 
> > 2.44.0
> > 



