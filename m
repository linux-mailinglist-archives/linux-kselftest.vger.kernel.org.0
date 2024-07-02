Return-Path: <linux-kselftest+bounces-13033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478ED91EE8C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 07:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D282844BC
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 05:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30CB54916;
	Tue,  2 Jul 2024 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JQ4e330f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2951004
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719899475; cv=none; b=USo7aMgWoa5XZW94DiRB4WvFkbJH9ckfm2Gl8odDOXZhwSYwfM6o1ndZoEnH0QShJptQdRw9w+lex40L/9umaGKfTxHbgyHrQV1kfU/5FxPh15xsuA8tAOZfzSgTxs3fBr6Mv57ExnkyeugpdwZXujNYzfzGnW3Tnn6k9+wPbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719899475; c=relaxed/simple;
	bh=4Kef8Il7QEsC9ZcZ1GJk9uknnnz3qNjSfQIhjhVxOsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlm1NwV1eW3CdTWYxdVvTeSllTlW+rUMBk2hbL7RKAOc82nUNwqQJVaOhpNsykhsOmCWELN94+jRo+i1W8cOxzl2o8HhoZBfKJkt0J2/fbFK4phhrJOPQZaJIqpsC2OX4TkK++TZsDfPfGK2fw084iXa/q/MNu0fnD0/JO5BDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JQ4e330f; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70683d96d0eso2211807b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Jul 2024 22:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719899473; x=1720504273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb7CkJpuNNXMkliIVX0CGzZEQ2k/xjIs5z0U5UpJyC4=;
        b=JQ4e330fbn34waQO+6AanVv7iDBGX8g6nDtx0YkrG0SLOm+tAKo1QJ+cGnA5TKiU3/
         9RVYzPdxnZII8PwANmkjUgYjQVIHd6Api32lkcWefRFJSj7cuVqaKJesbxtUZQM6BldY
         t9mV9uKUEVWHK08vwt2lw54FHAU5mgnqDHB8EZvFbmjq0vkPPIRpK8QolOX8Scc4sKhE
         /lOw/620kG/6gwdGYV1DbOX5P6Mbaw/Ja947kMhRK944+t0DCmKbJGcY9plkP3+0kvLQ
         Z27zTdZ+vgGE/IBXf/MLYO2gbis5jD8a02G8G9kmmZrsykw0OZ93pOFQw+SvyJ+URZGD
         bBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719899473; x=1720504273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb7CkJpuNNXMkliIVX0CGzZEQ2k/xjIs5z0U5UpJyC4=;
        b=vnj3zPIM7z9Nwf4IvxYoUbSu5gyW741FMEG7bGALi4S0/f5qDZtvY0S1dSenCVkTpa
         L+TYykPTCiFiscwFOuDz4QozuU/feRPJnszKIANdb0q2sXzUSbXvLtVYxQGE4WVtvYfx
         YdR/rJjkaf69wLp7dothMotgKfmjZMoW1m2OJeOnv2PJeQfMfmiXobf1O/XfZHO97IWW
         nzpcDfg0OWAJ1QCFh51cD94U/Q0TzEVZroI8+hWj42OGHrpbZ7snNzJ+oVszdCP04vxU
         qvM7o0EmjqfrGwbB4JHaneKZCdUXTvjyMO9r2g66bvGXmnauF+GK4lwpVmcyVzojdpHm
         0b5g==
X-Forwarded-Encrypted: i=1; AJvYcCXIM76jKMhQNsy2VLOtGy8cfae/3Laz9vOCEvSzgkP6MdAiohIzsR67QijBueK8SjnNbOk8H0OZEmls+9sBys33OcZZ5loHXjASigSrQR5g
X-Gm-Message-State: AOJu0Yzd6ftJBRSHlKjVA9/EBjUVFh6XtUBEVgDzBUAmXF4HJ2vOK3GL
	u5w4YzJ5fnWzdvvKugv69qmvNbZHf0LzApaO+m2leaAZc3mDkfzvyGWyoN7eJsE=
X-Google-Smtp-Source: AGHT+IEkBMlUapIWyjryZj8i4PHItT+grMuJOUd01nmfHInhPxCc1nVKxLdWDgPrT1kee19dPIY9RQ==
X-Received: by 2002:a05:6a20:c4a7:b0:1bd:2d0b:e143 with SMTP id adf61e73a8af0-1bef626e94dmr5507606637.52.1719899472778;
        Mon, 01 Jul 2024 22:51:12 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:a569:328b:99ad:ce17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15693e8sm74671455ad.217.2024.07.01.22.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 22:51:12 -0700 (PDT)
Date: Mon, 1 Jul 2024 22:51:09 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH v3 09/13] riscv: vector: Support xtheadvector save/restore
Message-ID: <ZoOVTUzyFBz/1R2m@ghost>
References: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
 <20240619-xtheadvector-v3-9-bff39eb9668e@rivosinc.com>
 <68f0c506-8b1f-4de7-a92e-fbc6bce0919b@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68f0c506-8b1f-4de7-a92e-fbc6bce0919b@sifive.com>

On Mon, Jul 01, 2024 at 11:20:24AM -0500, Samuel Holland wrote:
> Hi Charlie,
> 
> A couple of suggestions for simplification below.
> 
> On 2024-06-19 6:57 PM, Charlie Jenkins wrote:
> > Use alternatives to add support for xtheadvector vector save/restore
> > routines.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/include/asm/csr.h           |   6 +
> >  arch/riscv/include/asm/switch_to.h     |   2 +-
> >  arch/riscv/include/asm/vector.h        | 249 ++++++++++++++++++++++++++-------
> >  arch/riscv/kernel/cpufeature.c         |   2 +-
> >  arch/riscv/kernel/kernel_mode_vector.c |   8 +-
> >  arch/riscv/kernel/process.c            |   4 +-
> >  arch/riscv/kernel/signal.c             |   6 +-
> >  arch/riscv/kernel/vector.c             |  13 +-
> >  8 files changed, 222 insertions(+), 68 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> > index 9086639a3dde..407d4a5687f5 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -30,6 +30,12 @@
> >  #define SR_VS_CLEAN	_AC(0x00000400, UL)
> >  #define SR_VS_DIRTY	_AC(0x00000600, UL)
> >  
> > +#define SR_VS_THEAD		_AC(0x01800000, UL) /* xtheadvector Status */
> > +#define SR_VS_OFF_THEAD		_AC(0x00000000, UL)
> > +#define SR_VS_INITIAL_THEAD	_AC(0x00800000, UL)
> > +#define SR_VS_CLEAN_THEAD	_AC(0x01000000, UL)
> > +#define SR_VS_DIRTY_THEAD	_AC(0x01800000, UL)
> > +
> >  #define SR_XS		_AC(0x00018000, UL) /* Extension Status */
> >  #define SR_XS_OFF	_AC(0x00000000, UL)
> >  #define SR_XS_INITIAL	_AC(0x00008000, UL)
> > diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> > index 7594df37cc9f..f9cbebe372b8 100644
> > --- a/arch/riscv/include/asm/switch_to.h
> > +++ b/arch/riscv/include/asm/switch_to.h
> > @@ -99,7 +99,7 @@ do {							\
> >  	__set_prev_cpu(__prev->thread);			\
> >  	if (has_fpu())					\
> >  		__switch_to_fpu(__prev, __next);	\
> > -	if (has_vector())					\
> > +	if (has_vector() || has_xtheadvector())		\
> >  		__switch_to_vector(__prev, __next);	\
> >  	if (switch_to_should_flush_icache(__next))	\
> >  		local_flush_icache_all();		\
> > diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
> > index 731dcd0ed4de..6294dcaabc6a 100644
> > --- a/arch/riscv/include/asm/vector.h
> > +++ b/arch/riscv/include/asm/vector.h
> > @@ -18,6 +18,27 @@
> >  #include <asm/cpufeature.h>
> >  #include <asm/csr.h>
> >  #include <asm/asm.h>
> > +#include <asm/vendorid_list.h>
> > +#include <asm/vendor_extensions.h>
> > +#include <asm/vendor_extensions/thead.h>
> > +
> > +#define __riscv_v_vstate_or(_val, TYPE) ({				\
> > +	typeof(_val) _res = _val;					\
> > +	if (has_xtheadvector()) \
> > +		_res = (_res & ~SR_VS_THEAD) | SR_VS_##TYPE##_THEAD;	\
> > +	else								\
> > +		_res = (_res & ~SR_VS) | SR_VS_##TYPE;			\
> > +	_res;								\
> > +})
> > +
> > +#define __riscv_v_vstate_check(_val, TYPE) ({				\
> > +	bool _res;							\
> > +	if (has_xtheadvector()) \
> > +		_res = ((_val) & SR_VS_THEAD) == SR_VS_##TYPE##_THEAD;	\
> > +	else								\
> > +		_res = ((_val) & SR_VS) == SR_VS_##TYPE;		\
> > +	_res;								\
> > +})
> >  
> >  extern unsigned long riscv_v_vsize;
> >  int riscv_v_setup_vsize(void);
> > @@ -40,39 +61,62 @@ static __always_inline bool has_vector(void)
> >  	return riscv_has_extension_unlikely(RISCV_ISA_EXT_v);
> >  }
> >  
> > +static __always_inline bool has_xtheadvector_no_alternatives(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR))
> > +		return riscv_isa_vendor_extension_available(THEAD_VENDOR_ID, XTHEADVECTOR);
> > +	else
> > +		return false;
> > +}
> > +
> > +static __always_inline bool has_xtheadvector(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR))
> > +		return riscv_has_vendor_extension_unlikely(THEAD_VENDOR_ID,
> > +							   RISCV_ISA_VENDOR_EXT_XTHEADVECTOR);
> > +	else
> > +		return false;
> > +}
> > +
> >  static inline void __riscv_v_vstate_clean(struct pt_regs *regs)
> >  {
> > -	regs->status = (regs->status & ~SR_VS) | SR_VS_CLEAN;
> > +	regs->status = __riscv_v_vstate_or(regs->status, CLEAN);
> >  }
> >  
> >  static inline void __riscv_v_vstate_dirty(struct pt_regs *regs)
> >  {
> > -	regs->status = (regs->status & ~SR_VS) | SR_VS_DIRTY;
> > +	regs->status = __riscv_v_vstate_or(regs->status, DIRTY);
> >  }
> >  
> >  static inline void riscv_v_vstate_off(struct pt_regs *regs)
> >  {
> > -	regs->status = (regs->status & ~SR_VS) | SR_VS_OFF;
> > +	regs->status = __riscv_v_vstate_or(regs->status, OFF);
> >  }
> >  
> >  static inline void riscv_v_vstate_on(struct pt_regs *regs)
> >  {
> > -	regs->status = (regs->status & ~SR_VS) | SR_VS_INITIAL;
> > +	regs->status = __riscv_v_vstate_or(regs->status, INITIAL);
> >  }
> >  
> >  static inline bool riscv_v_vstate_query(struct pt_regs *regs)
> >  {
> > -	return (regs->status & SR_VS) != 0;
> > +	return !__riscv_v_vstate_check(regs->status, OFF);
> >  }
> >  
> >  static __always_inline void riscv_v_enable(void)
> >  {
> > -	csr_set(CSR_SSTATUS, SR_VS);
> > +	if (has_xtheadvector())
> > +		csr_set(CSR_SSTATUS, SR_VS_THEAD);
> > +	else
> > +		csr_set(CSR_SSTATUS, SR_VS);
> >  }
> >  
> >  static __always_inline void riscv_v_disable(void)
> >  {
> > -	csr_clear(CSR_SSTATUS, SR_VS);
> > +	if (has_xtheadvector())
> > +		csr_clear(CSR_SSTATUS, SR_VS_THEAD);
> > +	else
> > +		csr_clear(CSR_SSTATUS, SR_VS);
> >  }
> >  
> >  static __always_inline void __vstate_csr_save(struct __riscv_v_ext_state *dest)
> > @@ -81,10 +125,49 @@ static __always_inline void __vstate_csr_save(struct __riscv_v_ext_state *dest)
> >  		"csrr	%0, " __stringify(CSR_VSTART) "\n\t"
> >  		"csrr	%1, " __stringify(CSR_VTYPE) "\n\t"
> >  		"csrr	%2, " __stringify(CSR_VL) "\n\t"
> > -		"csrr	%3, " __stringify(CSR_VCSR) "\n\t"
> > -		"csrr	%4, " __stringify(CSR_VLENB) "\n\t"
> >  		: "=r" (dest->vstart), "=r" (dest->vtype), "=r" (dest->vl),
> > -		  "=r" (dest->vcsr), "=r" (dest->vlenb) : :);
> > +		"=r" (dest->vcsr) : :);
> > +
> > +	if (has_xtheadvector()) {
> > +		u32 tmp_vcsr;
> > +		bool restore_fpu = false;
> > +		unsigned long status = csr_read(CSR_SSTATUS);
> > +
> > +		/*
> > +		 * CSR_VCSR is defined as
> > +		 * [2:1] - vxrm[1:0]
> > +		 * [0] - vxsat
> > +		 * The earlier vector spec implemented by T-Head uses separate
> > +		 * registers for the same bit-elements, so just combine those
> > +		 * into the existing output field.
> > +		 *
> > +		 * Additionally T-Head cores need FS to be enabled when accessing
> > +		 * the VXRM and VXSAT CSRs, otherwise ending in illegal instructions.
> > +		 * Though the cores do not implement the VXRM and VXSAT fields in the
> > +		 * FCSR CSR that vector-0.7.1 specifies.
> > +		 */
> > +		if ((status & SR_FS) == SR_FS_OFF) {
> > +			csr_set(CSR_SSTATUS, (status & ~SR_FS) | SR_FS_CLEAN);
> > +			restore_fpu = true;
> > +		}
> 
> This simplifies to:
> 
> 	unsigned long status = csr_read_set(CSR_STATUS, SR_FS_DIRTY);
> 
> and then below:
> 
> 	if ((status & SR_FS) != SR_FS_DIRTY)
> 		csr_write(CSR_STATUS, status);
> 

Great suggestions, thank you!

> > +
> > +		asm volatile (
> > +			"csrr	%[tmp_vcsr], " __stringify(VCSR_VXRM) "\n\t"
> > +			"slliw	%[vcsr], %[tmp_vcsr], " __stringify(VCSR_VXRM_SHIFT) "\n\t"
> > +			"csrr	%[tmp_vcsr], " __stringify(VCSR_VXSAT) "\n\t"
> > +			"or	%[vcsr], %[vcsr], %[tmp_vcsr]\n\t"
> > +			: [vcsr] "=r" (dest->vcsr), [tmp_vcsr] "=&r" (tmp_vcsr));
> 
> None of this needs to be inline assembly. I think the only reason that
> __vstate_csr_save() uses inline assembly is to match __vstate_csr_restore(),
> which needs it to execute a vsetvl instruction. This would be easier to parse if
> it used csr_read().

You are totally right! Converting this to C will make the code much easier to follow.

> 
> > +
> > +		dest->vlenb = riscv_v_vsize / 32;
> 
> This value can't change at runtime (for either standard V or Xtheadvector), so
> we don't need to save it every time. So (possibly as a future optimization) this
> could be saved only once when the context is first initialized.

Yes that is something that should be optimized. I can optimize this in a
follow up patch so this series doesn't grow any more.

> 
> > +
> > +		if (restore_fpu)
> > +			csr_set(CSR_SSTATUS, status);
> > +	} else {
> > +		asm volatile (
> > +			"csrr	%[vcsr], " __stringify(CSR_VCSR) "\n\t"
> > +			"csrr	%[vlenb], " __stringify(CSR_VLENB) "\n\t"
> > +			: [vcsr] "=r" (dest->vcsr), [vlenb] "=r" (dest->vlenb));
> > +	}
> >  }
> >  
> >  static __always_inline void __vstate_csr_restore(struct __riscv_v_ext_state *src)
> > @@ -95,9 +178,37 @@ static __always_inline void __vstate_csr_restore(struct __riscv_v_ext_state *src
> >  		"vsetvl	 x0, %2, %1\n\t"
> >  		".option pop\n\t"
> >  		"csrw	" __stringify(CSR_VSTART) ", %0\n\t"
> > -		"csrw	" __stringify(CSR_VCSR) ", %3\n\t"
> > -		: : "r" (src->vstart), "r" (src->vtype), "r" (src->vl),
> > -		    "r" (src->vcsr) :);
> > +		: : "r" (src->vstart), "r" (src->vtype), "r" (src->vl));
> > +
> > +	if (has_xtheadvector()) {
> > +		u32 tmp_vcsr;
> > +		bool restore_fpu = false;
> > +		unsigned long status = csr_read(CSR_SSTATUS);
> > +
> > +		/*
> > +		 * Similar to __vstate_csr_save above, restore values for the
> > +		 * separate VXRM and VXSAT CSRs from the vcsr variable.
> > +		 */
> > +		if ((status & SR_FS) == SR_FS_OFF) {
> > +			csr_set(CSR_SSTATUS, (status & ~SR_FS) | SR_FS_CLEAN);
> > +			restore_fpu = true;
> > +		}
> > +
> > +		asm volatile (
> > +			"srliw	%[tmp_vcsr], %[vcsr], " __stringify(VCSR_VXRM_SHIFT) "\n\t"
> > +			"andi	%[tmp_vcsr], %[tmp_vcsr], " __stringify(VCSR_VXRM_MASK) "\n\t"
> > +			"csrw	" __stringify(VCSR_VXRM) ", %[tmp_vcsr]\n\t"
> > +			"andi	%[tmp_vcsr], %[vcsr], " __stringify(VCSR_VXSAT_MASK) "\n\t"
> > +			"csrw	" __stringify(VCSR_VXSAT) ", %[tmp_vcsr]\n\t"
> > +			: [tmp_vcsr] "=&r" (tmp_vcsr) : [vcsr] "r" (src->vcsr));
> 
> Similarly, this would be a lot easier to parse with csr_write() instead of
> inline assembly.

Will do, thank you!

- Charlie

> 
> Regards,
> Samuel
> 
> > +
> > +		if (restore_fpu)
> > +			csr_set(CSR_SSTATUS, status);
> > +	} else {
> > +		asm volatile (
> > +			"csrw	" __stringify(CSR_VCSR) ", %[vcsr]\n\t"
> > +			: : [vcsr] "r" (src->vcsr));
> > +	}
> >  }
> >  
> >  static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *save_to,
> > @@ -107,19 +218,33 @@ static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *save_to,
> >  
> >  	riscv_v_enable();
> >  	__vstate_csr_save(save_to);
> > -	asm volatile (
> > -		".option push\n\t"
> > -		".option arch, +v\n\t"
> > -		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
> > -		"vse8.v		v0, (%1)\n\t"
> > -		"add		%1, %1, %0\n\t"
> > -		"vse8.v		v8, (%1)\n\t"
> > -		"add		%1, %1, %0\n\t"
> > -		"vse8.v		v16, (%1)\n\t"
> > -		"add		%1, %1, %0\n\t"
> > -		"vse8.v		v24, (%1)\n\t"
> > -		".option pop\n\t"
> > -		: "=&r" (vl) : "r" (datap) : "memory");
> > +	if (has_xtheadvector()) {
> > +		asm volatile (
> > +			"mv t0, %0\n\t"
> > +			THEAD_VSETVLI_T4X0E8M8D1
> > +			THEAD_VSB_V_V0T0
> > +			"add		t0, t0, t4\n\t"
> > +			THEAD_VSB_V_V0T0
> > +			"add		t0, t0, t4\n\t"
> > +			THEAD_VSB_V_V0T0
> > +			"add		t0, t0, t4\n\t"
> > +			THEAD_VSB_V_V0T0
> > +			: : "r" (datap) : "memory", "t0", "t4");
> > +	} else {
> > +		asm volatile (
> > +			".option push\n\t"
> > +			".option arch, +v\n\t"
> > +			"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
> > +			"vse8.v		v0, (%1)\n\t"
> > +			"add		%1, %1, %0\n\t"
> > +			"vse8.v		v8, (%1)\n\t"
> > +			"add		%1, %1, %0\n\t"
> > +			"vse8.v		v16, (%1)\n\t"
> > +			"add		%1, %1, %0\n\t"
> > +			"vse8.v		v24, (%1)\n\t"
> > +			".option pop\n\t"
> > +			: "=&r" (vl) : "r" (datap) : "memory");
> > +	}
> >  	riscv_v_disable();
> >  }
> >  
> > @@ -129,55 +254,77 @@ static inline void __riscv_v_vstate_restore(struct __riscv_v_ext_state *restore_
> >  	unsigned long vl;
> >  
> >  	riscv_v_enable();
> > -	asm volatile (
> > -		".option push\n\t"
> > -		".option arch, +v\n\t"
> > -		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
> > -		"vle8.v		v0, (%1)\n\t"
> > -		"add		%1, %1, %0\n\t"
> > -		"vle8.v		v8, (%1)\n\t"
> > -		"add		%1, %1, %0\n\t"
> > -		"vle8.v		v16, (%1)\n\t"
> > -		"add		%1, %1, %0\n\t"
> > -		"vle8.v		v24, (%1)\n\t"
> > -		".option pop\n\t"
> > -		: "=&r" (vl) : "r" (datap) : "memory");
> > +	if (has_xtheadvector()) {
> > +		asm volatile (
> > +			"mv t0, %0\n\t"
> > +			THEAD_VSETVLI_T4X0E8M8D1
> > +			THEAD_VLB_V_V0T0
> > +			"add		t0, t0, t4\n\t"
> > +			THEAD_VLB_V_V0T0
> > +			"add		t0, t0, t4\n\t"
> > +			THEAD_VLB_V_V0T0
> > +			"add		t0, t0, t4\n\t"
> > +			THEAD_VLB_V_V0T0
> > +			: : "r" (datap) : "memory", "t0", "t4");
> > +	} else {
> > +		asm volatile (
> > +			".option push\n\t"
> > +			".option arch, +v\n\t"
> > +			"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
> > +			"vle8.v		v0, (%1)\n\t"
> > +			"add		%1, %1, %0\n\t"
> > +			"vle8.v		v8, (%1)\n\t"
> > +			"add		%1, %1, %0\n\t"
> > +			"vle8.v		v16, (%1)\n\t"
> > +			"add		%1, %1, %0\n\t"
> > +			"vle8.v		v24, (%1)\n\t"
> > +			".option pop\n\t"
> > +			: "=&r" (vl) : "r" (datap) : "memory");
> > +	}
> >  	__vstate_csr_restore(restore_from);
> >  	riscv_v_disable();
> >  }
> >  
> >  static inline void __riscv_v_vstate_discard(void)
> >  {
> > -	unsigned long vl, vtype_inval = 1UL << (BITS_PER_LONG - 1);
> > +	unsigned long vtype_inval = 1UL << (BITS_PER_LONG - 1);
> >  
> >  	riscv_v_enable();
> > +	if (has_xtheadvector())
> > +		asm volatile (THEAD_VSETVLI_X0X0E8M8D1);
> > +	else
> > +		asm volatile (
> > +			".option push\n\t"
> > +			".option arch, +v\n\t"
> > +			"vsetvli	x0, x0, e8, m8, ta, ma\n\t"
> > +			".option pop\n\t");
> > +
> >  	asm volatile (
> >  		".option push\n\t"
> >  		".option arch, +v\n\t"
> > -		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
> >  		"vmv.v.i	v0, -1\n\t"
> >  		"vmv.v.i	v8, -1\n\t"
> >  		"vmv.v.i	v16, -1\n\t"
> >  		"vmv.v.i	v24, -1\n\t"
> > -		"vsetvl		%0, x0, %1\n\t"
> > +		"vsetvl		x0, x0, %0\n\t"
> >  		".option pop\n\t"
> > -		: "=&r" (vl) : "r" (vtype_inval) : "memory");
> > +		: : "r" (vtype_inval));
> > +
> >  	riscv_v_disable();
> >  }
> >  
> >  static inline void riscv_v_vstate_discard(struct pt_regs *regs)
> >  {
> > -	if ((regs->status & SR_VS) == SR_VS_OFF)
> > -		return;
> > -
> > -	__riscv_v_vstate_discard();
> > -	__riscv_v_vstate_dirty(regs);
> > +	if (riscv_v_vstate_query(regs)) {
> > +		__riscv_v_vstate_discard();
> > +		__riscv_v_vstate_dirty(regs);
> > +	}
> >  }
> >  
> >  static inline void riscv_v_vstate_save(struct __riscv_v_ext_state *vstate,
> >  				       struct pt_regs *regs)
> >  {
> > -	if ((regs->status & SR_VS) == SR_VS_DIRTY) {
> > +	if (__riscv_v_vstate_check(regs->status, DIRTY)) {
> >  		__riscv_v_vstate_save(vstate, vstate->datap);
> >  		__riscv_v_vstate_clean(regs);
> >  	}
> > @@ -186,7 +333,7 @@ static inline void riscv_v_vstate_save(struct __riscv_v_ext_state *vstate,
> >  static inline void riscv_v_vstate_restore(struct __riscv_v_ext_state *vstate,
> >  					  struct pt_regs *regs)
> >  {
> > -	if ((regs->status & SR_VS) != SR_VS_OFF) {
> > +	if (riscv_v_vstate_query(regs)) {
> >  		__riscv_v_vstate_restore(vstate, vstate->datap);
> >  		__riscv_v_vstate_clean(regs);
> >  	}
> > @@ -195,7 +342,7 @@ static inline void riscv_v_vstate_restore(struct __riscv_v_ext_state *vstate,
> >  static inline void riscv_v_vstate_set_restore(struct task_struct *task,
> >  					      struct pt_regs *regs)
> >  {
> > -	if ((regs->status & SR_VS) != SR_VS_OFF) {
> > +	if (riscv_v_vstate_query(regs)) {
> >  		set_tsk_thread_flag(task, TIF_RISCV_V_DEFER_RESTORE);
> >  		riscv_v_vstate_on(regs);
> >  	}
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 077be4ab1f9a..180f7eae9086 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -789,7 +789,7 @@ void __init riscv_fill_hwcap(void)
> >  		elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
> >  	}
> >  
> > -	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> > +	if (elf_hwcap & COMPAT_HWCAP_ISA_V || has_xtheadvector_no_alternatives()) {
> >  		riscv_v_setup_vsize();
> >  		/*
> >  		 * ISA string in device tree might have 'v' flag, but
> > diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
> > index 6afe80c7f03a..99972a48e86b 100644
> > --- a/arch/riscv/kernel/kernel_mode_vector.c
> > +++ b/arch/riscv/kernel/kernel_mode_vector.c
> > @@ -143,7 +143,7 @@ static int riscv_v_start_kernel_context(bool *is_nested)
> >  
> >  	/* Transfer the ownership of V from user to kernel, then save */
> >  	riscv_v_start(RISCV_PREEMPT_V | RISCV_PREEMPT_V_DIRTY);
> > -	if ((task_pt_regs(current)->status & SR_VS) == SR_VS_DIRTY) {
> > +	if (__riscv_v_vstate_check(task_pt_regs(current)->status, DIRTY)) {
> >  		uvstate = &current->thread.vstate;
> >  		__riscv_v_vstate_save(uvstate, uvstate->datap);
> >  	}
> > @@ -160,7 +160,7 @@ asmlinkage void riscv_v_context_nesting_start(struct pt_regs *regs)
> >  		return;
> >  
> >  	depth = riscv_v_ctx_get_depth();
> > -	if (depth == 0 && (regs->status & SR_VS) == SR_VS_DIRTY)
> > +	if (depth == 0 && __riscv_v_vstate_check(regs->status, DIRTY))
> >  		riscv_preempt_v_set_dirty();
> >  
> >  	riscv_v_ctx_depth_inc();
> > @@ -208,7 +208,7 @@ void kernel_vector_begin(void)
> >  {
> >  	bool nested = false;
> >  
> > -	if (WARN_ON(!has_vector()))
> > +	if (WARN_ON(!(has_vector() || has_xtheadvector())))
> >  		return;
> >  
> >  	BUG_ON(!may_use_simd());
> > @@ -236,7 +236,7 @@ EXPORT_SYMBOL_GPL(kernel_vector_begin);
> >   */
> >  void kernel_vector_end(void)
> >  {
> > -	if (WARN_ON(!has_vector()))
> > +	if (WARN_ON(!(has_vector() || has_xtheadvector())))
> >  		return;
> >  
> >  	riscv_v_disable();
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index e4bc61c4e58a..191023decd16 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -176,7 +176,7 @@ void flush_thread(void)
> >  void arch_release_task_struct(struct task_struct *tsk)
> >  {
> >  	/* Free the vector context of datap. */
> > -	if (has_vector())
> > +	if (has_vector() || has_xtheadvector())
> >  		riscv_v_thread_free(tsk);
> >  }
> >  
> > @@ -222,7 +222,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
> >  		p->thread.s[0] = 0;
> >  	}
> >  	p->thread.riscv_v_flags = 0;
> > -	if (has_vector())
> > +	if (has_vector() || has_xtheadvector())
> >  		riscv_v_thread_alloc(p);
> >  	p->thread.ra = (unsigned long)ret_from_fork;
> >  	p->thread.sp = (unsigned long)childregs; /* kernel sp */
> > diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> > index 5a2edd7f027e..1d5e4b3ca9e1 100644
> > --- a/arch/riscv/kernel/signal.c
> > +++ b/arch/riscv/kernel/signal.c
> > @@ -189,7 +189,7 @@ static long restore_sigcontext(struct pt_regs *regs,
> >  
> >  			return 0;
> >  		case RISCV_V_MAGIC:
> > -			if (!has_vector() || !riscv_v_vstate_query(regs) ||
> > +			if (!(has_vector() || has_xtheadvector()) || !riscv_v_vstate_query(regs) ||
> >  			    size != riscv_v_sc_size)
> >  				return -EINVAL;
> >  
> > @@ -211,7 +211,7 @@ static size_t get_rt_frame_size(bool cal_all)
> >  
> >  	frame_size = sizeof(*frame);
> >  
> > -	if (has_vector()) {
> > +	if (has_vector() || has_xtheadvector()) {
> >  		if (cal_all || riscv_v_vstate_query(task_pt_regs(current)))
> >  			total_context_size += riscv_v_sc_size;
> >  	}
> > @@ -284,7 +284,7 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
> >  	if (has_fpu())
> >  		err |= save_fp_state(regs, &sc->sc_fpregs);
> >  	/* Save the vector state. */
> > -	if (has_vector() && riscv_v_vstate_query(regs))
> > +	if ((has_vector() || has_xtheadvector()) && riscv_v_vstate_query(regs))
> >  		err |= save_v_state(regs, (void __user **)&sc_ext_ptr);
> >  	/* Write zero to fp-reserved space and check it on restore_sigcontext */
> >  	err |= __put_user(0, &sc->sc_extdesc.reserved);
> > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> > index 3ba2f2432483..83126995f61a 100644
> > --- a/arch/riscv/kernel/vector.c
> > +++ b/arch/riscv/kernel/vector.c
> > @@ -63,7 +63,7 @@ int riscv_v_setup_vsize(void)
> >  
> >  void __init riscv_v_setup_ctx_cache(void)
> >  {
> > -	if (!has_vector())
> > +	if (!(has_vector() || has_xtheadvector()))
> >  		return;
> >  
> >  	riscv_v_user_cachep = kmem_cache_create_usercopy("riscv_vector_ctx",
> > @@ -184,7 +184,8 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
> >  	u32 insn = (u32)regs->badaddr;
> >  
> >  	/* Do not handle if V is not supported, or disabled */
> > -	if (!(ELF_HWCAP & COMPAT_HWCAP_ISA_V))
> > +	if (!(ELF_HWCAP & COMPAT_HWCAP_ISA_V) &&
> > +	    !(has_xtheadvector() && riscv_v_vstate_ctrl_user_allowed()))
> >  		return false;
> >  
> >  	/* If V has been enabled then it is not the first-use trap */
> > @@ -223,7 +224,7 @@ void riscv_v_vstate_ctrl_init(struct task_struct *tsk)
> >  	bool inherit;
> >  	int cur, next;
> >  
> > -	if (!has_vector())
> > +	if (!(has_vector() || has_xtheadvector()))
> >  		return;
> >  
> >  	next = riscv_v_ctrl_get_next(tsk);
> > @@ -245,7 +246,7 @@ void riscv_v_vstate_ctrl_init(struct task_struct *tsk)
> >  
> >  long riscv_v_vstate_ctrl_get_current(void)
> >  {
> > -	if (!has_vector())
> > +	if (!(has_vector() || has_xtheadvector()))
> >  		return -EINVAL;
> >  
> >  	return current->thread.vstate_ctrl & PR_RISCV_V_VSTATE_CTRL_MASK;
> > @@ -256,7 +257,7 @@ long riscv_v_vstate_ctrl_set_current(unsigned long arg)
> >  	bool inherit;
> >  	int cur, next;
> >  
> > -	if (!has_vector())
> > +	if (!(has_vector() || has_xtheadvector()))
> >  		return -EINVAL;
> >  
> >  	if (arg & ~PR_RISCV_V_VSTATE_CTRL_MASK)
> > @@ -306,7 +307,7 @@ static struct ctl_table riscv_v_default_vstate_table[] = {
> >  
> >  static int __init riscv_v_sysctl_init(void)
> >  {
> > -	if (has_vector())
> > +	if (has_vector() || has_xtheadvector())
> >  		if (!register_sysctl("abi", riscv_v_default_vstate_table))
> >  			return -EINVAL;
> >  	return 0;
> > 
> 

