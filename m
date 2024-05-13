Return-Path: <linux-kselftest+bounces-10141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E238C456C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 18:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D7BB22CD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 16:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5901B18C3D;
	Mon, 13 May 2024 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hcTDf93o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E480621362
	for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619401; cv=none; b=pRuTj3DHpqtzZTOjADHrq6XLYx8a8vo9iBIMG6YiZPqktty14Ds7zM7UkWsoVtwOVHvro6CFhwjzCYp/yQpMjTR4MJ/rwtjhC3Yfz4yAZVqsCmpk7IbNraD11vhCTSLIncFl9IdeCEPzpYfS48k6WfHHr0NeEYo7aULVEXng3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619401; c=relaxed/simple;
	bh=DGcXKTxrE/8EcGRNkXE90qCzUbC3/CI6HD/dP8pZ0UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5bcXFeLYyVdesuT4CtCpsim/51QmLWhSL2chM4E257iOCyAn6q+jQdvi3dY/YSR2oh19N4ayGffa/gKbAV96I+QskTyHh/pw4l5OHBVFv9oCX3pBSHfoj4Buw0Yt4+CAUXe7Hy2HTpT80g0k/xVlZLQXSnBLubFRJJqOslc3rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hcTDf93o; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f44ed6e82fso4099850b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715619398; x=1716224198; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VK8vYit8+gdtU6flQEkqpwhK6a5E14jjPOZSmkE0mPU=;
        b=hcTDf93ogUg/bzGeX7rgLqSmN0+VB/We1A2bE1FguXPfyhAIwLhuIvtUvmls9kwry1
         bj6GgkFmdF8m48uSz5X62K1EtRaUh6aC7qV7sz6gn16QSnNfwVStjQUi9GW3d3Ut/mFr
         hguZzIY3zyW4mBCFngemrbfbx2gQnO4Cuq7l6uvX40vqL4AHPAqQupJzYWrYnLLJM2in
         y4znldI9Lk4IPmtISks2x65fp6IEckG0ko9pDW7oycM0IIrN0FkE4nYlk6QQTbp0VIjN
         0ENiucpy7v5kwws2h3SZnhw3iFnRYfnlSNoW08mwZLQ7KvwTS+Yhrr9aKEJ3fyag9OeP
         jgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715619398; x=1716224198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VK8vYit8+gdtU6flQEkqpwhK6a5E14jjPOZSmkE0mPU=;
        b=e5TT9toyQSNswSbmarwUWiieOCV810aT2hRufFL+rYUIMUhCBMwPgOm1wQu+pgv4G6
         N4Jm7oPuDhNTMjVyeM5p8EDpHYUaEqd3AkF7Lf4W5c3pMoJddf5R/1/j9K/daZl+E/Sp
         e5EwPBUmEwF+fugcVRRkrkTlF6bai3wv6ziDcn1pYq0acZgsnU2QsZukB6wVBQozs+dZ
         1jmns51d4sEWzWw/4HW12DFiEfDgqCeoUTOM6Cl1aScGcsNCqldEJMOtfRvYJC2NtgrC
         /gVzhYrr+6uyEP8XtvUmD3fuLOZ5Jm5grvFFeSD8bAgCmUryhmiiFiMAPUkGH4RyQ9JQ
         bm2A==
X-Forwarded-Encrypted: i=1; AJvYcCUa7520089yjOcONklnTLbapdahuLe6Bn9m5tI8fqoBMxHNRo2pwks63OKqcp354jicMEpi3IHkdNobVs3MeA4Z3qY2avEYgMZAwqxQhQRq
X-Gm-Message-State: AOJu0YzEHwBNrRcigfMbdLPUxHG52KiJyFs5EQLvXZF6mWzNn1mTYb3J
	yCao7LuAalt7LugtsZBuDGLtqFcNDhg/VrNC5VLfY01/r77t+1i+3WyLhb0cou8=
X-Google-Smtp-Source: AGHT+IHajz6ulNGvu1i/yT1eA7FdMl4NaAuxDNWOd+7lvJAt6WrPn9Bnm6rDLbkRgAASe47XyhLGBg==
X-Received: by 2002:a05:6a20:7350:b0:1af:a72e:8b7e with SMTP id adf61e73a8af0-1afde1b6f32mr13102711637.50.1715619397966;
        Mon, 13 May 2024 09:56:37 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:3a68:91f5:da04:ef09])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a87bb1sm7592789b3a.87.2024.05.13.09.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 09:56:37 -0700 (PDT)
Date: Mon, 13 May 2024 09:56:31 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v6 13/17] riscv: vector: Support xtheadvector save/restore
Message-ID: <ZkJGP2ilt0x23MaE@ghost>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-13-cb7624e65d82@rivosinc.com>
 <CABgGipUMtgQxYx1mUBojtCSh7kwAco=P_NYuWp=QtLBFSziT_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgGipUMtgQxYx1mUBojtCSh7kwAco=P_NYuWp=QtLBFSziT_A@mail.gmail.com>

On Mon, May 13, 2024 at 04:45:18PM +0800, Andy Chiu wrote:
> Hi Charlie,
> 
> Sorry, I am late on this. I haven't looked through the entire series
> yet, but here is something that I thought worth bringing up sooner.
> 
> On Sat, May 4, 2024 at 2:22 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Use alternatives to add support for xtheadvector vector save/restore
> > routines.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig.vendor              |  13 ++
> >  arch/riscv/include/asm/csr.h           |   6 +
> >  arch/riscv/include/asm/switch_to.h     |   2 +-
> >  arch/riscv/include/asm/vector.h        | 247 ++++++++++++++++++++++++++-------
> >  arch/riscv/kernel/cpufeature.c         |   2 +-
> >  arch/riscv/kernel/kernel_mode_vector.c |   8 +-
> >  arch/riscv/kernel/process.c            |   4 +-
> >  arch/riscv/kernel/signal.c             |   6 +-
> >  arch/riscv/kernel/vector.c             |  13 +-
> >  9 files changed, 233 insertions(+), 68 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> > index aa5a191e659e..edf49f3065ac 100644
> > --- a/arch/riscv/Kconfig.vendor
> > +++ b/arch/riscv/Kconfig.vendor
> > @@ -13,6 +13,19 @@ config RISCV_ISA_VENDOR_EXT_THEAD
> >           extensions. Without this option enabled, T-Head vendor extensions will
> >           not be detected at boot and their presence not reported to userspace.
> >
> > +         If you don't know what to do here, say Y.
> > +
> > +config RISCV_ISA_XTHEADVECTOR
> > +       bool "xtheadvector extension support"
> > +       depends on RISCV_ISA_VENDOR_EXT_THEAD
> > +       depends on RISCV_ISA_V
> > +       depends on FPU
> > +       default y
> > +       help
> > +         Say N here if you want to disable all xtheadvector related procedure
> > +         in the kernel. This will disable vector for any T-Head board that
> > +         contains xtheadvector rather than the standard vector.
> > +
> >           If you don't know what to do here, say Y.
> >  endmenu
> >
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> > index e5a35efd56e0..13657d096e7d 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -30,6 +30,12 @@
> >  #define SR_VS_CLEAN    _AC(0x00000400, UL)
> >  #define SR_VS_DIRTY    _AC(0x00000600, UL)
> >
> > +#define SR_VS_THEAD            _AC(0x01800000, UL) /* xtheadvector Status */
> > +#define SR_VS_OFF_THEAD                _AC(0x00000000, UL)
> > +#define SR_VS_INITIAL_THEAD    _AC(0x00800000, UL)
> > +#define SR_VS_CLEAN_THEAD      _AC(0x01000000, UL)
> > +#define SR_VS_DIRTY_THEAD      _AC(0x01800000, UL)
> > +
> >  #define SR_XS          _AC(0x00018000, UL) /* Extension Status */
> >  #define SR_XS_OFF      _AC(0x00000000, UL)
> >  #define SR_XS_INITIAL  _AC(0x00008000, UL)
> > diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> > index 7efdb0584d47..ada6b5cf2d94 100644
> > --- a/arch/riscv/include/asm/switch_to.h
> > +++ b/arch/riscv/include/asm/switch_to.h
> > @@ -78,7 +78,7 @@ do {                                                  \
> >         struct task_struct *__next = (next);            \
> >         if (has_fpu())                                  \
> >                 __switch_to_fpu(__prev, __next);        \
> > -       if (has_vector())                                       \
> > +       if (has_vector() || has_xtheadvector())         \
> >                 __switch_to_vector(__prev, __next);     \
> >         ((last) = __switch_to(__prev, __next));         \
> >  } while (0)
> > diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
> > index 731dcd0ed4de..db851dc81870 100644
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
> > +#define __riscv_v_vstate_or(_val, TYPE) ({                             \
> > +       typeof(_val) _res = _val;                                       \
> > +       if (has_xtheadvector()) \
> > +               _res = (_res & ~SR_VS_THEAD) | SR_VS_##TYPE##_THEAD;    \
> > +       else                                                            \
> > +               _res = (_res & ~SR_VS) | SR_VS_##TYPE;                  \
> > +       _res;                                                           \
> > +})
> > +
> > +#define __riscv_v_vstate_check(_val, TYPE) ({                          \
> > +       bool _res;                                                      \
> > +       if (has_xtheadvector()) \
> > +               _res = ((_val) & SR_VS_THEAD) == SR_VS_##TYPE##_THEAD;  \
> > +       else                                                            \
> > +               _res = ((_val) & SR_VS) == SR_VS_##TYPE;                \
> > +       _res;                                                           \
> > +})
> >
> >  extern unsigned long riscv_v_vsize;
> >  int riscv_v_setup_vsize(void);
> > @@ -40,39 +61,62 @@ static __always_inline bool has_vector(void)
> >         return riscv_has_extension_unlikely(RISCV_ISA_EXT_v);
> >  }
> >
> > +static __always_inline bool has_xtheadvector_no_alternatives(void)
> > +{
> > +       if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR))
> > +               return riscv_isa_vendor_extension_available(THEAD_VENDOR_ID, XTHEADVECTOR);
> > +       else
> > +               return false;
> > +}
> > +
> > +static __always_inline bool has_xtheadvector(void)
> > +{
> > +       if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR))
> > +               return riscv_has_vendor_extension_unlikely(THEAD_VENDOR_ID,
> > +                                                          RISCV_ISA_VENDOR_EXT_XTHEADVECTOR);
> > +       else
> > +               return false;
> > +}
> > +
> >  static inline void __riscv_v_vstate_clean(struct pt_regs *regs)
> >  {
> > -       regs->status = (regs->status & ~SR_VS) | SR_VS_CLEAN;
> > +       regs->status = __riscv_v_vstate_or(regs->status, CLEAN);
> >  }
> >
> >  static inline void __riscv_v_vstate_dirty(struct pt_regs *regs)
> >  {
> > -       regs->status = (regs->status & ~SR_VS) | SR_VS_DIRTY;
> > +       regs->status = __riscv_v_vstate_or(regs->status, DIRTY);
> >  }
> >
> >  static inline void riscv_v_vstate_off(struct pt_regs *regs)
> >  {
> > -       regs->status = (regs->status & ~SR_VS) | SR_VS_OFF;
> > +       regs->status = __riscv_v_vstate_or(regs->status, OFF);
> >  }
> >
> >  static inline void riscv_v_vstate_on(struct pt_regs *regs)
> >  {
> > -       regs->status = (regs->status & ~SR_VS) | SR_VS_INITIAL;
> > +       regs->status = __riscv_v_vstate_or(regs->status, INITIAL);
> >  }
> >
> >  static inline bool riscv_v_vstate_query(struct pt_regs *regs)
> >  {
> > -       return (regs->status & SR_VS) != 0;
> > +       return !__riscv_v_vstate_check(regs->status, OFF);
> >  }
> >
> >  static __always_inline void riscv_v_enable(void)
> >  {
> > -       csr_set(CSR_SSTATUS, SR_VS);
> > +       if (has_xtheadvector())
> > +               csr_set(CSR_SSTATUS, SR_VS_THEAD);
> > +       else
> > +               csr_set(CSR_SSTATUS, SR_VS);
> >  }
> >
> >  static __always_inline void riscv_v_disable(void)
> >  {
> > -       csr_clear(CSR_SSTATUS, SR_VS);
> > +       if (has_xtheadvector())
> > +               csr_clear(CSR_SSTATUS, SR_VS_THEAD);
> > +       else
> > +               csr_clear(CSR_SSTATUS, SR_VS);
> >  }
> >
> >  static __always_inline void __vstate_csr_save(struct __riscv_v_ext_state *dest)
> > @@ -81,10 +125,47 @@ static __always_inline void __vstate_csr_save(struct __riscv_v_ext_state *dest)
> >                 "csrr   %0, " __stringify(CSR_VSTART) "\n\t"
> >                 "csrr   %1, " __stringify(CSR_VTYPE) "\n\t"
> >                 "csrr   %2, " __stringify(CSR_VL) "\n\t"
> > -               "csrr   %3, " __stringify(CSR_VCSR) "\n\t"
> > -               "csrr   %4, " __stringify(CSR_VLENB) "\n\t"
> >                 : "=r" (dest->vstart), "=r" (dest->vtype), "=r" (dest->vl),
> > -                 "=r" (dest->vcsr), "=r" (dest->vlenb) : :);
> > +               "=r" (dest->vcsr) : :);
> > +
> > +       if (has_xtheadvector()) {
> > +               u32 tmp_vcsr;
> > +               bool restore_fpu = false;
> > +               unsigned long status = csr_read(CSR_SSTATUS);
> > +
> > +               /*
> > +                * CSR_VCSR is defined as
> > +                * [2:1] - vxrm[1:0]
> > +                * [0] - vxsat
> > +                * The earlier vector spec implemented by T-Head uses separate
> > +                * registers for the same bit-elements, so just combine those
> > +                * into the existing output field.
> > +                *
> > +                * Additionally T-Head cores need FS to be enabled when accessing
> > +                * the VXRM and VXSAT CSRs, otherwise ending in illegal instructions.
> > +                * Though the cores do not implement the VXRM and VXSAT fields in the
> > +                * FCSR CSR that vector-0.7.1 specifies.
> > +                */
> > +               if ((status & SR_FS) == SR_FS_OFF) {
> > +                       csr_set(CSR_SSTATUS, (status & ~SR_FS) | SR_FS_CLEAN);
> > +                       restore_fpu = true;
> > +               }
> > +
> > +               asm volatile (
> > +                       "csrr   %[tmp_vcsr], " __stringify(VCSR_VXRM) "\n\t"
> > +                       "slliw  %[vcsr], %[tmp_vcsr], " __stringify(VCSR_VXRM_SHIFT) "\n\t"
> > +                       "csrr   %[tmp_vcsr], " __stringify(VCSR_VXSAT) "\n\t"
> > +                       "or     %[vcsr], %[vcsr], %[tmp_vcsr]\n\t"
> > +                       : [vcsr] "=r" (dest->vcsr), [tmp_vcsr] "=&r" (tmp_vcsr));
> > +
> > +               if (restore_fpu)
> > +                       csr_set(CSR_SSTATUS, status);
> 
> vlenb is on ABI and ptrace needs that to recover the width of the
> register. So we should probably save Xtheadvector's vlenb into vstate
> if we meant to maintain ABI compatibility between V and Xtheadvector
> from the kernel.

We can pull the vlenb from riscv_v_vsize which gets populated from the
devicetree for xtheadvector. I will change that in the next version!

- Charlie

> 
> > +       } else {
> > +               asm volatile (
> > +                       "csrr   %[vcsr], " __stringify(CSR_VCSR) "\n\t"
> > +                       "csrr   %[vlenb], " __stringify(CSR_VLENB) "\n\t"
> > +                       : [vcsr] "=r" (dest->vcsr), [vlenb] "=r" (dest->vlenb));
> > +       }
> >  }
> >
> >  static __always_inline void __vstate_csr_restore(struct __riscv_v_ext_state *src)
> > @@ -95,9 +176,37 @@ static __always_inline void __vstate_csr_restore(struct __riscv_v_ext_state *src
> >                 "vsetvl  x0, %2, %1\n\t"
> >                 ".option pop\n\t"
> >                 "csrw   " __stringify(CSR_VSTART) ", %0\n\t"
> > -               "csrw   " __stringify(CSR_VCSR) ", %3\n\t"
> > -               : : "r" (src->vstart), "r" (src->vtype), "r" (src->vl),
> > -                   "r" (src->vcsr) :);
> > +               : : "r" (src->vstart), "r" (src->vtype), "r" (src->vl));
> > +
> > +       if (has_xtheadvector()) {
> > +               u32 tmp_vcsr;
> > +               bool restore_fpu = false;
> > +               unsigned long status = csr_read(CSR_SSTATUS);
> > +
> > +               /*
> > +                * Similar to __vstate_csr_save above, restore values for the
> > +                * separate VXRM and VXSAT CSRs from the vcsr variable.
> > +                */
> > +               if ((status & SR_FS) == SR_FS_OFF) {
> > +                       csr_set(CSR_SSTATUS, (status & ~SR_FS) | SR_FS_CLEAN);
> > +                       restore_fpu = true;
> > +               }
> > +
> > +               asm volatile (
> > +                       "srliw  %[tmp_vcsr], %[vcsr], " __stringify(VCSR_VXRM_SHIFT) "\n\t"
> > +                       "andi   %[tmp_vcsr], %[tmp_vcsr], " __stringify(VCSR_VXRM_MASK) "\n\t"
> > +                       "csrw   " __stringify(VCSR_VXRM) ", %[tmp_vcsr]\n\t"
> > +                       "andi   %[tmp_vcsr], %[vcsr], " __stringify(VCSR_VXSAT_MASK) "\n\t"
> > +                       "csrw   " __stringify(VCSR_VXSAT) ", %[tmp_vcsr]\n\t"
> > +                       : [tmp_vcsr] "=&r" (tmp_vcsr) : [vcsr] "r" (src->vcsr));
> > +
> > +               if (restore_fpu)
> > +                       csr_set(CSR_SSTATUS, status);
> > +       } else {
> > +               asm volatile (
> > +                       "csrw   " __stringify(CSR_VCSR) ", %[vcsr]\n\t"
> > +                       : : [vcsr] "r" (src->vcsr));
> > +       }
> >  }
> >
> >  static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *save_to,
> > @@ -107,19 +216,33 @@ static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *save_to,
> >
> >         riscv_v_enable();
> >         __vstate_csr_save(save_to);
> > -       asm volatile (
> > -               ".option push\n\t"
> > -               ".option arch, +v\n\t"
> > -               "vsetvli        %0, x0, e8, m8, ta, ma\n\t"
> > -               "vse8.v         v0, (%1)\n\t"
> > -               "add            %1, %1, %0\n\t"
> > -               "vse8.v         v8, (%1)\n\t"
> > -               "add            %1, %1, %0\n\t"
> > -               "vse8.v         v16, (%1)\n\t"
> > -               "add            %1, %1, %0\n\t"
> > -               "vse8.v         v24, (%1)\n\t"
> > -               ".option pop\n\t"
> > -               : "=&r" (vl) : "r" (datap) : "memory");
> > +       if (has_xtheadvector()) {
> > +               asm volatile (
> > +                       "mv t0, %0\n\t"
> > +                       THEAD_VSETVLI_T4X0E8M8D1
> > +                       THEAD_VSB_V_V0T0
> > +                       "add            t0, t0, t4\n\t"
> > +                       THEAD_VSB_V_V0T0
> > +                       "add            t0, t0, t4\n\t"
> > +                       THEAD_VSB_V_V0T0
> > +                       "add            t0, t0, t4\n\t"
> > +                       THEAD_VSB_V_V0T0
> > +                       : : "r" (datap) : "memory", "t0", "t4");
> > +       } else {
> > +               asm volatile (
> > +                       ".option push\n\t"
> > +                       ".option arch, +v\n\t"
> > +                       "vsetvli        %0, x0, e8, m8, ta, ma\n\t"
> > +                       "vse8.v         v0, (%1)\n\t"
> > +                       "add            %1, %1, %0\n\t"
> > +                       "vse8.v         v8, (%1)\n\t"
> > +                       "add            %1, %1, %0\n\t"
> > +                       "vse8.v         v16, (%1)\n\t"
> > +                       "add            %1, %1, %0\n\t"
> > +                       "vse8.v         v24, (%1)\n\t"
> > +                       ".option pop\n\t"
> > +                       : "=&r" (vl) : "r" (datap) : "memory");
> > +       }
> >         riscv_v_disable();
> >  }
> >
> > @@ -129,55 +252,77 @@ static inline void __riscv_v_vstate_restore(struct __riscv_v_ext_state *restore_
> >         unsigned long vl;
> >
> >         riscv_v_enable();
> > -       asm volatile (
> > -               ".option push\n\t"
> > -               ".option arch, +v\n\t"
> > -               "vsetvli        %0, x0, e8, m8, ta, ma\n\t"
> > -               "vle8.v         v0, (%1)\n\t"
> > -               "add            %1, %1, %0\n\t"
> > -               "vle8.v         v8, (%1)\n\t"
> > -               "add            %1, %1, %0\n\t"
> > -               "vle8.v         v16, (%1)\n\t"
> > -               "add            %1, %1, %0\n\t"
> > -               "vle8.v         v24, (%1)\n\t"
> > -               ".option pop\n\t"
> > -               : "=&r" (vl) : "r" (datap) : "memory");
> > +       if (has_xtheadvector()) {
> > +               asm volatile (
> > +                       "mv t0, %0\n\t"
> > +                       THEAD_VSETVLI_T4X0E8M8D1
> > +                       THEAD_VLB_V_V0T0
> > +                       "add            t0, t0, t4\n\t"
> > +                       THEAD_VLB_V_V0T0
> > +                       "add            t0, t0, t4\n\t"
> > +                       THEAD_VLB_V_V0T0
> > +                       "add            t0, t0, t4\n\t"
> > +                       THEAD_VLB_V_V0T0
> > +                       : : "r" (datap) : "memory", "t0", "t4");
> > +       } else {
> > +               asm volatile (
> > +                       ".option push\n\t"
> > +                       ".option arch, +v\n\t"
> > +                       "vsetvli        %0, x0, e8, m8, ta, ma\n\t"
> > +                       "vle8.v         v0, (%1)\n\t"
> > +                       "add            %1, %1, %0\n\t"
> > +                       "vle8.v         v8, (%1)\n\t"
> > +                       "add            %1, %1, %0\n\t"
> > +                       "vle8.v         v16, (%1)\n\t"
> > +                       "add            %1, %1, %0\n\t"
> > +                       "vle8.v         v24, (%1)\n\t"
> > +                       ".option pop\n\t"
> > +                       : "=&r" (vl) : "r" (datap) : "memory");
> > +       }
> >         __vstate_csr_restore(restore_from);
> >         riscv_v_disable();
> >  }
> >
> >  static inline void __riscv_v_vstate_discard(void)
> >  {
> > -       unsigned long vl, vtype_inval = 1UL << (BITS_PER_LONG - 1);
> > +       unsigned long vtype_inval = 1UL << (BITS_PER_LONG - 1);
> >
> >         riscv_v_enable();
> > +       if (has_xtheadvector())
> > +               asm volatile (THEAD_VSETVLI_X0X0E8M8D1);
> > +       else
> > +               asm volatile (
> > +                       ".option push\n\t"
> > +                       ".option arch, +v\n\t"
> > +                       "vsetvli        x0, x0, e8, m8, ta, ma\n\t"
> > +                       ".option pop\n\t");
> > +
> >         asm volatile (
> >                 ".option push\n\t"
> >                 ".option arch, +v\n\t"
> > -               "vsetvli        %0, x0, e8, m8, ta, ma\n\t"
> >                 "vmv.v.i        v0, -1\n\t"
> >                 "vmv.v.i        v8, -1\n\t"
> >                 "vmv.v.i        v16, -1\n\t"
> >                 "vmv.v.i        v24, -1\n\t"
> > -               "vsetvl         %0, x0, %1\n\t"
> > +               "vsetvl         x0, x0, %0\n\t"
> >                 ".option pop\n\t"
> > -               : "=&r" (vl) : "r" (vtype_inval) : "memory");
> > +               : : "r" (vtype_inval));
> > +
> >         riscv_v_disable();
> >  }
> >
> >  static inline void riscv_v_vstate_discard(struct pt_regs *regs)
> >  {
> > -       if ((regs->status & SR_VS) == SR_VS_OFF)
> > -               return;
> > -
> > -       __riscv_v_vstate_discard();
> > -       __riscv_v_vstate_dirty(regs);
> > +       if (riscv_v_vstate_query(regs)) {
> > +               __riscv_v_vstate_discard();
> > +               __riscv_v_vstate_dirty(regs);
> > +       }
> >  }
> >
> >  static inline void riscv_v_vstate_save(struct __riscv_v_ext_state *vstate,
> >                                        struct pt_regs *regs)
> >  {
> > -       if ((regs->status & SR_VS) == SR_VS_DIRTY) {
> > +       if (__riscv_v_vstate_check(regs->status, DIRTY)) {
> >                 __riscv_v_vstate_save(vstate, vstate->datap);
> >                 __riscv_v_vstate_clean(regs);
> >         }
> > @@ -186,7 +331,7 @@ static inline void riscv_v_vstate_save(struct __riscv_v_ext_state *vstate,
> >  static inline void riscv_v_vstate_restore(struct __riscv_v_ext_state *vstate,
> >                                           struct pt_regs *regs)
> >  {
> > -       if ((regs->status & SR_VS) != SR_VS_OFF) {
> > +       if (riscv_v_vstate_query(regs)) {
> >                 __riscv_v_vstate_restore(vstate, vstate->datap);
> >                 __riscv_v_vstate_clean(regs);
> >         }
> > @@ -195,7 +340,7 @@ static inline void riscv_v_vstate_restore(struct __riscv_v_ext_state *vstate,
> >  static inline void riscv_v_vstate_set_restore(struct task_struct *task,
> >                                               struct pt_regs *regs)
> >  {
> > -       if ((regs->status & SR_VS) != SR_VS_OFF) {
> > +       if (riscv_v_vstate_query(regs)) {
> >                 set_tsk_thread_flag(task, TIF_RISCV_V_DEFER_RESTORE);
> >                 riscv_v_vstate_on(regs);
> >         }
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 2993318b8ea2..44f0017a98d5 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -781,7 +781,7 @@ void __init riscv_fill_hwcap(void)
> >                 elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
> >         }
> >
> > -       if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> > +       if (elf_hwcap & COMPAT_HWCAP_ISA_V || has_xtheadvector_no_alternatives()) {
> >                 riscv_v_setup_vsize();
> >                 /*
> >                  * ISA string in device tree might have 'v' flag, but
> > diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
> > index 6afe80c7f03a..99972a48e86b 100644
> > --- a/arch/riscv/kernel/kernel_mode_vector.c
> > +++ b/arch/riscv/kernel/kernel_mode_vector.c
> > @@ -143,7 +143,7 @@ static int riscv_v_start_kernel_context(bool *is_nested)
> >
> >         /* Transfer the ownership of V from user to kernel, then save */
> >         riscv_v_start(RISCV_PREEMPT_V | RISCV_PREEMPT_V_DIRTY);
> > -       if ((task_pt_regs(current)->status & SR_VS) == SR_VS_DIRTY) {
> > +       if (__riscv_v_vstate_check(task_pt_regs(current)->status, DIRTY)) {
> >                 uvstate = &current->thread.vstate;
> >                 __riscv_v_vstate_save(uvstate, uvstate->datap);
> >         }
> > @@ -160,7 +160,7 @@ asmlinkage void riscv_v_context_nesting_start(struct pt_regs *regs)
> >                 return;
> >
> >         depth = riscv_v_ctx_get_depth();
> > -       if (depth == 0 && (regs->status & SR_VS) == SR_VS_DIRTY)
> > +       if (depth == 0 && __riscv_v_vstate_check(regs->status, DIRTY))
> >                 riscv_preempt_v_set_dirty();
> >
> >         riscv_v_ctx_depth_inc();
> > @@ -208,7 +208,7 @@ void kernel_vector_begin(void)
> >  {
> >         bool nested = false;
> >
> > -       if (WARN_ON(!has_vector()))
> > +       if (WARN_ON(!(has_vector() || has_xtheadvector())))
> >                 return;
> >
> >         BUG_ON(!may_use_simd());
> > @@ -236,7 +236,7 @@ EXPORT_SYMBOL_GPL(kernel_vector_begin);
> >   */
> >  void kernel_vector_end(void)
> >  {
> > -       if (WARN_ON(!has_vector()))
> > +       if (WARN_ON(!(has_vector() || has_xtheadvector())))
> >                 return;
> >
> >         riscv_v_disable();
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index 92922dbd5b5c..eabca86fc3c0 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -178,7 +178,7 @@ void flush_thread(void)
> >  void arch_release_task_struct(struct task_struct *tsk)
> >  {
> >         /* Free the vector context of datap. */
> > -       if (has_vector())
> > +       if (has_vector() || has_xtheadvector())
> >                 riscv_v_thread_free(tsk);
> >  }
> >
> > @@ -225,7 +225,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
> >                 p->thread.s[0] = 0;
> >         }
> >         p->thread.riscv_v_flags = 0;
> > -       if (has_vector())
> > +       if (has_vector() || has_xtheadvector())
> >                 riscv_v_thread_alloc(p);
> >         p->thread.ra = (unsigned long)ret_from_fork;
> >         p->thread.sp = (unsigned long)childregs; /* kernel sp */
> > diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> > index 501e66debf69..5d3ba8e46807 100644
> > --- a/arch/riscv/kernel/signal.c
> > +++ b/arch/riscv/kernel/signal.c
> > @@ -188,7 +188,7 @@ static long restore_sigcontext(struct pt_regs *regs,
> >
> >                         return 0;
> >                 case RISCV_V_MAGIC:
> > -                       if (!has_vector() || !riscv_v_vstate_query(regs) ||
> > +                       if (!(has_vector() || has_xtheadvector()) || !riscv_v_vstate_query(regs) ||
> >                             size != riscv_v_sc_size)
> >                                 return -EINVAL;
> >
> > @@ -210,7 +210,7 @@ static size_t get_rt_frame_size(bool cal_all)
> >
> >         frame_size = sizeof(*frame);
> >
> > -       if (has_vector()) {
> > +       if (has_vector() || has_xtheadvector()) {
> >                 if (cal_all || riscv_v_vstate_query(task_pt_regs(current)))
> >                         total_context_size += riscv_v_sc_size;
> >         }
> > @@ -283,7 +283,7 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
> >         if (has_fpu())
> >                 err |= save_fp_state(regs, &sc->sc_fpregs);
> >         /* Save the vector state. */
> > -       if (has_vector() && riscv_v_vstate_query(regs))
> > +       if ((has_vector() || has_xtheadvector()) && riscv_v_vstate_query(regs))
> >                 err |= save_v_state(regs, (void __user **)&sc_ext_ptr);
> >         /* Write zero to fp-reserved space and check it on restore_sigcontext */
> >         err |= __put_user(0, &sc->sc_extdesc.reserved);
> > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> > index e04586cdb7f0..c12ea4547da6 100644
> > --- a/arch/riscv/kernel/vector.c
> > +++ b/arch/riscv/kernel/vector.c
> > @@ -63,7 +63,7 @@ int riscv_v_setup_vsize(void)
> >
> >  void __init riscv_v_setup_ctx_cache(void)
> >  {
> > -       if (!has_vector())
> > +       if (!(has_vector() || has_xtheadvector()))
> >                 return;
> >
> >         riscv_v_user_cachep = kmem_cache_create_usercopy("riscv_vector_ctx",
> > @@ -184,7 +184,8 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
> >         u32 insn = (u32)regs->badaddr;
> >
> >         /* Do not handle if V is not supported, or disabled */
> > -       if (!(ELF_HWCAP & COMPAT_HWCAP_ISA_V))
> > +       if (!(ELF_HWCAP & COMPAT_HWCAP_ISA_V) &&
> > +           !(has_xtheadvector() && riscv_v_vstate_ctrl_user_allowed()))
> >                 return false;
> >
> >         /* If V has been enabled then it is not the first-use trap */
> > @@ -223,7 +224,7 @@ void riscv_v_vstate_ctrl_init(struct task_struct *tsk)
> >         bool inherit;
> >         int cur, next;
> >
> > -       if (!has_vector())
> > +       if (!(has_vector() || has_xtheadvector()))
> >                 return;
> >
> >         next = riscv_v_ctrl_get_next(tsk);
> > @@ -245,7 +246,7 @@ void riscv_v_vstate_ctrl_init(struct task_struct *tsk)
> >
> >  long riscv_v_vstate_ctrl_get_current(void)
> >  {
> > -       if (!has_vector())
> > +       if (!(has_vector() || has_xtheadvector()))
> >                 return -EINVAL;
> >
> >         return current->thread.vstate_ctrl & PR_RISCV_V_VSTATE_CTRL_MASK;
> > @@ -256,7 +257,7 @@ long riscv_v_vstate_ctrl_set_current(unsigned long arg)
> >         bool inherit;
> >         int cur, next;
> >
> > -       if (!has_vector())
> > +       if (!(has_vector() || has_xtheadvector()))
> >                 return -EINVAL;
> >
> >         if (arg & ~PR_RISCV_V_VSTATE_CTRL_MASK)
> > @@ -306,7 +307,7 @@ static struct ctl_table riscv_v_default_vstate_table[] = {
> >
> >  static int __init riscv_v_sysctl_init(void)
> >  {
> > -       if (has_vector())
> > +       if (has_vector() || has_xtheadvector())
> >                 if (!register_sysctl("abi", riscv_v_default_vstate_table))
> >                         return -EINVAL;
> >         return 0;
> >
> > --
> > 2.44.0
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> Cheers,
> Andy

