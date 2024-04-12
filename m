Return-Path: <linux-kselftest+bounces-7850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098718A3503
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7591C21389
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED1314D70F;
	Fri, 12 Apr 2024 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VREmx/I4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946314D457
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943788; cv=none; b=JJ60UuevEDca+jN40sQdoBVUzDibAKxZk1eROpwNLiuFTQ2O19teRffWkNRwQ85W85CPkBD72H0ATT+Ey4Rahyj2ftENHlxMZvA3i5OIaM9QntXRsxbLIzygTSZfBNnCF34ir+pZTH7vJ+mqq3NS9D8XXZTRoUhnHMuuPQ4ob5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943788; c=relaxed/simple;
	bh=398UBf0wjuXyW1KRcz0N92ExG8gOAwZvnLb+5hA8430=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufdj6tSsLSIM07yNZE1iUGG0RM/aG/Tq9BRvOGp0gmaONXWyusHOdL4sVyh0NBU3UH2X7IpKM+76xNBAvG2VzQBiUrTYB0JMC/h6TOZWzPVy90HAl4bBrx6zh7ZPf0Ha62zFTImZBpEKb5yV2LZvDjInIdy83nGM3tgkFDJb3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VREmx/I4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e2bbc2048eso10108275ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 10:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712943786; x=1713548586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8YRvEt+OTF00KrpCNHpUGlZ7toxHUQ85PqnBkH5iiOI=;
        b=VREmx/I4Bl8fL+erIIvIEgsEoPlqugBORJ930NOMVQeeB8gjpQm0aFTE3G73Jvtrgx
         B1rAIbF3LXz5Mdnck0/OYdjc3aLIYWNlMq9S7+w8lXvp7DGbceXEfM47U0o1+4wQ6kuo
         rEB5HpjVvcbkb8hrDI4vcHc0CcMKQxvF8VGrgAZyHrC0zFs4BLnJ4xZNwHZWENg03/Sd
         lLPrOe7tstnqZZ8p3E0QTAaCoYg+5GlDjhoZr3on5BpjgnnZOru3nbH82Y6WaK/H3P/6
         kdySzfhHxh8ZGab/OalYe9YkNBc6SdlT6XRz4xPlCBezUQ718IoXkN5Tkm4B/cFyuuzb
         hLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712943786; x=1713548586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YRvEt+OTF00KrpCNHpUGlZ7toxHUQ85PqnBkH5iiOI=;
        b=VPPP8kbA/oLkhk3IcSplhlA5h3wo6pVsG2fyForwnRP0y+IJ75FUfzfoT7RTeB6838
         +AMHtbDLcNAPkdHFBvjvl5uZqosHS1n3OzT4P8jzsRvmIklmkpTNiTknv2INs8/cfuKE
         Fd0ClXqvDsXpyXi25k8RkszQnpMwP75T6XyoDU8O0K7gLpxHxxxBwhFDosnYjwbKR4A3
         gKlSOEijSNvUEOxHc/VaNY1RpNubc4xgHhE+27+C0qOCk7xHaz2EpIXU3J2droS5HWgT
         IKFc2hajjgd9ugt+aYTS52Tmnuwv/bQFMmRGzLm2Kp/HlKAvNRIQQkKO2glh5mxXIaD6
         mV+A==
X-Forwarded-Encrypted: i=1; AJvYcCWLUpznd0V9km3zcnsxnkQ2k1jVfEEtjNSX3Qxc6dcNSQTG3SZjcOD+Wv3MOxNX1SFTe+bn9puDyki/pcTA1jgtTHm1fP6gUxGuMPpNKHIa
X-Gm-Message-State: AOJu0YwMWv0GMAeySKEUGVDc/SSLi/btch6tEsg1tw19Q9Qn78cqKZtK
	/pRtnqHCtMPdziCQda7fStdbONR8D39jymuytG4w9LrUe5rqXryh7kEf6jA4eS8=
X-Google-Smtp-Source: AGHT+IE1KS+cgoHgP39ECdNzoJBDC8vTl8/0G5V7240HCpKQkDUzHJq76jMWfkj5KFoeGRTzjJqSZQ==
X-Received: by 2002:a17:902:d303:b0:1e0:bae4:48f9 with SMTP id b3-20020a170902d30300b001e0bae448f9mr3205407plc.32.1712943785937;
        Fri, 12 Apr 2024 10:43:05 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:121b:da6b:94f1:304])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f2c900b001e0e5722788sm3287804plc.17.2024.04.12.10.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 10:43:05 -0700 (PDT)
Date: Fri, 12 Apr 2024 10:43:02 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 08/19] riscv: Introduce vendor variants of extension
 helpers
Message-ID: <ZhlypvTdsFPZBr08@ghost>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-8-4af9815ec746@rivosinc.com>
 <20240412-dwarf-shower-5a7300fcd283@wendy>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412-dwarf-shower-5a7300fcd283@wendy>

On Fri, Apr 12, 2024 at 12:49:57PM +0100, Conor Dooley wrote:
> On Thu, Apr 11, 2024 at 09:11:14PM -0700, Charlie Jenkins wrote:
> > Create vendor variants of the existing extension helpers. If the
> > existing functions were instead modified to support vendor extensions, a
> > branch based on the ext value being greater than
> > RISCV_ISA_VENDOR_EXT_BASE would have to be introduced. This additional
> > branch would have an unnecessary performance impact.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> I've not looked at the "main" patch in the series that adds all of the
> probing and structures for representing this info yet beyond a cursory
> glance, but it feels like we're duplicating a bunch of infrastructure
> here before it is necessary. The IDs are all internal to Linux, so I'd
> rather we kept everything in the same structure until we have more than
> a handful of vendor extensions. With this patch (and the theadpmu stuff)
> we will have three vendor extensions which feels like a drop in the
> bucket compared to the standard ones.

It is not duplicating infrastructure. If we merge this into the existing
infrastructure, we would be littering if (ext > RISCV_ISA_VENDOR_EXT_BASE)
in __riscv_isa_extension_available. This is particularily important
exactly because we have so few vendor extensions currently so this check
would be irrelevant in the vast majority of cases.

It is also unecessary to push off the refactoring until we have some
"sufficient" amount of vendor extensions to deem changing the
infrastructure when I already have the patch available here. This does
not introduce any extra overhead to existing functions and will be able
to support vendors into the future.

- Charlie

> 
> 
> > ---
> >  arch/riscv/include/asm/cpufeature.h | 54 +++++++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/cpufeature.c      | 34 ++++++++++++++++++++---
> >  2 files changed, 84 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > index db2ab037843a..8f19e3681b4f 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -89,6 +89,10 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
> >  #define riscv_isa_extension_available(isa_bitmap, ext)	\
> >  	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
> >  
> > +bool __riscv_isa_vendor_extension_available(const unsigned long *vendor_isa_bitmap, unsigned int bit);
> > +#define riscv_isa_vendor_extension_available(isa_bitmap, ext)	\
> > +	__riscv_isa_vendor_extension_available(isa_bitmap, RISCV_ISA_VENDOR_EXT_##ext)
> > +
> >  static __always_inline bool
> >  __riscv_has_extension_likely_alternatives(const unsigned long ext)
> >  {
> > @@ -117,6 +121,8 @@ __riscv_has_extension_unlikely_alternatives(const unsigned long ext)
> >  	return true;
> >  }
> >  
> > +/* Standard extension helpers */
> > +
> >  static __always_inline bool
> >  riscv_has_extension_likely(const unsigned long ext)
> >  {
> > @@ -163,4 +169,52 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
> >  		return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> >  }
> >  
> > +/* Vendor extension helpers */
> > +
> > +static __always_inline bool
> > +riscv_has_vendor_extension_likely(const unsigned long ext)
> > +{
> > +	compiletime_assert(ext < RISCV_ISA_VENDOR_EXT_MAX,
> > +			   "ext must be < RISCV_ISA_VENDOR_EXT_MAX");
> > +
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> > +		return __riscv_has_extension_likely_alternatives(ext);
> > +	else
> > +		return __riscv_isa_vendor_extension_available(NULL, ext);
> > +}
> > +
> > +static __always_inline bool
> > +riscv_has_vendor_extension_unlikely(const unsigned long ext)
> > +{
> > +	compiletime_assert(ext < RISCV_ISA_VENDOR_EXT_MAX,
> > +			   "ext must be < RISCV_ISA_VENDOR_EXT_MAX");
> > +
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> > +		return __riscv_has_extension_unlikely_alternatives(ext);
> > +	else
> > +		return __riscv_isa_vendor_extension_available(NULL, ext);
> > +}
> > +
> > +static __always_inline bool riscv_cpu_has_vendor_extension_likely(int cpu, const unsigned long ext)
> > +{
> > +	compiletime_assert(ext < RISCV_ISA_VENDOR_EXT_MAX,
> > +			   "ext must be < RISCV_ISA_VENDOR_EXT_MAX");
> > +
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> > +		return __riscv_has_extension_likely_alternatives(ext);
> > +	else
> > +		return __riscv_isa_vendor_extension_available(hart_isa_vendor[cpu].isa, ext);
> > +}
> > +
> > +static __always_inline bool riscv_cpu_has_vendor_extension_unlikely(int cpu, const unsigned long ext)
> > +{
> > +	compiletime_assert(ext < RISCV_ISA_VENDOR_EXT_MAX,
> > +			   "ext must be < RISCV_ISA_VENDOR_EXT_MAX");
> > +
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> > +		return __riscv_has_extension_unlikely_alternatives(ext);
> > +	else
> > +		return __riscv_isa_vendor_extension_available(hart_isa_vendor[cpu].isa, ext);
> > +}
> 
> Same stuff about constant folding applies to these, I think these should
> just mirror the existing functions (if needed at all).
> 
> Cheers,
> Conor.



