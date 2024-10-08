Return-Path: <linux-kselftest+bounces-19251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC729955C6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 19:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F15B28A05
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2288420ADE4;
	Tue,  8 Oct 2024 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ2hOhC1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA4420ADC1;
	Tue,  8 Oct 2024 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408905; cv=none; b=XaDb5WM/waoe+dckdvMSmrHJcg2tRTc+tf+IClH/FZB4xRPaPuWe8Z8X6Odcpkf8boNmV2KPilwYxsBbEZMy1a1VYaRZolQY34tdlCmuyRGktukFZvm1lSdtVJTmCQiKhaO32nctQtlAoL7gWzNjvt0GXaNmXLkRAo/pWfi4zzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408905; c=relaxed/simple;
	bh=C0RGFrBZLycC0Vkl/8oPoU2BH9v7ZVuEArGIZId8opU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2DpvZELTmccMnwxQvqSUKi64HPuZ5Ws9/a3KYOXTPltP3cb6y8uqPcsWZvCzTzsBBe/bmB94ScMNoEf0LhBUiXo+Y2SqLq4hiVtGnevynsbOpmJm3805q9SHw/WaqOwgiFBJQ7ol37Jh8pcV8FN5MhZwW8N++Pq0Vv+W86mbKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ2hOhC1; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6de14e0f050so46040967b3.0;
        Tue, 08 Oct 2024 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728408902; x=1729013702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bl1FGmjaQlO0RghiZxostY/Ro9bNqr7H5RQN/T58C3U=;
        b=TZ2hOhC1QbSv++LmQhp4HjIRyjCY7ziX73Les2vGOAbU8oCX5FdigNKOvIiUBCAjLQ
         rKIzEgCAxZz1Q3CfdpfjbnGRSK8J9Yrv4j1SbloPsMD9P/sI1olJPybb5ZWE60JowHCi
         /Dbj9h2exOUk2E8+QeP1LtIO3y9YsAqod4Pqa3RrXBEVCV1vbcK8DqbNlh+7MFEVXNmM
         Me63W4i+I4BxWx4IhnQ6HCqjohXPnh+ZjMSAL4Qqmy8bOzRjT4ArVHdFGmLKebs4Vakg
         EqHRV1DNPVq5Q1lbOUvEeDH8g3M0xXAmbFJPZETw0sf2qqhvDe6Iu93jBRnC+V8LEvwx
         LD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728408902; x=1729013702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bl1FGmjaQlO0RghiZxostY/Ro9bNqr7H5RQN/T58C3U=;
        b=kkBpOgjxOLe2awnzLo2cHS4QSdcxsxqdeZbsHmPsHsNkdC41GDAQu6pJ85qFl6Nl1U
         XaoiixnXZmjjTzM8HTFsjdTceBTcaZHOCyW5ACRa/Y63JUjqTO2ifb1IZWQ9n/MTHYeZ
         rK8rrW+7mWCRdS3Lz7rVFErqVnkYscBRHWh/mkEFZCDEEWtyTwl1e+YJVFV6ZLQXbFRD
         sKdE8pOGw/EabGBYqJ6AXXBPKGAOTyTG3rbXDyHnpwjVOHLd2xKu460x3+oxxyq3Swyo
         9P1ZejP2HkSDczziPMHYLt2vfBei5h1XY0t5R0jpiA0KBdW7nY9XQzqVPCLGlMDWyoem
         y56g==
X-Forwarded-Encrypted: i=1; AJvYcCVY0AJu8O6XxO5dI9H/zQZ1fm6cYLBlRWrRcoUeDAzf5bC31xlOzFIXnG082GjSgj0qVOriL9c72yGh7geV@vger.kernel.org, AJvYcCVzQXr+/zy8/B8emlsYAIn2joJHX9E02uexeiREhf8/p2QbEJg2fmB5BmoZTgvKpHRcnCO+B9rWvlyq@vger.kernel.org, AJvYcCWb7F8Xa0Ji52Z9dVrdm5WrFqfM43TYXRc79QuPb/nS+ArSSL0RXEb2GcCsi/45Vjto0ck06oYqCSkU@vger.kernel.org, AJvYcCXBIKqSfgPPN+xT3napAensfaE8HqArTGsfjuB478oCPHtU41a41nf54wui7ftXZedfgKWRRrMcPVbdPdKu8wJc@vger.kernel.org
X-Gm-Message-State: AOJu0YxTdJX0YiA+GycMYfKoLMcQTEDdltwraHJsZ2JwryJ5L6372gGF
	r1/ZLPqLPqlq1y79Ld+3znynWor07DCWjbZZ9H3PTr/wdYIlxCP5VHYNrWyviiaweF9GQ8hc6gh
	V0LoK/3r+w6Sm3/K8kau1Oq8AFmY=
X-Google-Smtp-Source: AGHT+IEaydwyQCvkW5SfAVWHUAvlqVH7s6r0MAbgSuA4mMKIyfeH7uNF9mBDYdWRYCRUsIQOKFgodQTGbf8wnPENJUU=
X-Received: by 2002:a05:690c:fcf:b0:6dd:d2c5:b2c with SMTP id
 00721157ae682-6e2c6ff685cmr156212107b3.4.1728408901622; Tue, 08 Oct 2024
 10:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com> <20240911-xtheadvector-v10-9-8d3930091246@rivosinc.com>
In-Reply-To: <20240911-xtheadvector-v10-9-8d3930091246@rivosinc.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 9 Oct 2024 01:34:50 +0800
Message-ID: <CAFTtA3P0UMbg957MR4qni=gEX52haaNcZc-pTJrmu0_4zWrZmw@mail.gmail.com>
Subject: Re: [PATCH v10 09/14] riscv: vector: Support xtheadvector save/restore
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
	Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Charlie,

Charlie Jenkins <charlie@rivosinc.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=8812=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:57=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Use alternatives to add support for xtheadvector vector save/restore
> routines.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/csr.h           |   6 +
>  arch/riscv/include/asm/switch_to.h     |   2 +-
>  arch/riscv/include/asm/vector.h        | 225 +++++++++++++++++++++++++--=
------
>  arch/riscv/kernel/cpufeature.c         |   6 +-
>  arch/riscv/kernel/kernel_mode_vector.c |   8 +-
>  arch/riscv/kernel/process.c            |   4 +-
>  arch/riscv/kernel/signal.c             |   6 +-
>  arch/riscv/kernel/vector.c             |  12 +-
>  8 files changed, 200 insertions(+), 69 deletions(-)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index c0a60c4ed911..b4b3fcb1d142 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -30,6 +30,12 @@
>  #define SR_VS_CLEAN    _AC(0x00000400, UL)
>  #define SR_VS_DIRTY    _AC(0x00000600, UL)
>
> +#define SR_VS_THEAD            _AC(0x01800000, UL) /* xtheadvector Statu=
s */
> +#define SR_VS_OFF_THEAD                _AC(0x00000000, UL)
> +#define SR_VS_INITIAL_THEAD    _AC(0x00800000, UL)
> +#define SR_VS_CLEAN_THEAD      _AC(0x01000000, UL)
> +#define SR_VS_DIRTY_THEAD      _AC(0x01800000, UL)
> +
>  #define SR_XS          _AC(0x00018000, UL) /* Extension Status */
>  #define SR_XS_OFF      _AC(0x00000000, UL)
>  #define SR_XS_INITIAL  _AC(0x00008000, UL)
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/=
switch_to.h
> index 7594df37cc9f..f9cbebe372b8 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -99,7 +99,7 @@ do {                                                  \
>         __set_prev_cpu(__prev->thread);                 \
>         if (has_fpu())                                  \
>                 __switch_to_fpu(__prev, __next);        \
> -       if (has_vector())                                       \
> +       if (has_vector() || has_xtheadvector())         \
>                 __switch_to_vector(__prev, __next);     \
>         if (switch_to_should_flush_icache(__next))      \
>                 local_flush_icache_all();               \
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index be7d309cca8a..6fd05efc6837 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -18,6 +18,27 @@
>  #include <asm/cpufeature.h>
>  #include <asm/csr.h>
>  #include <asm/asm.h>
> +#include <asm/vendorid_list.h>
> +#include <asm/vendor_extensions.h>
> +#include <asm/vendor_extensions/thead.h>
> +
> +#define __riscv_v_vstate_or(_val, TYPE) ({                             \

Rather than __riscv_v_vstate_or, shouldn't  __riscv_v_vstate_set() or
__riscv_v_vstate_assign better suit the semantic below?

> +       typeof(_val) _res =3D _val;                                      =
 \
> +       if (has_xtheadvector()) \
> +               _res =3D (_res & ~SR_VS_THEAD) | SR_VS_##TYPE##_THEAD;   =
 \
> +       else                                                            \
> +               _res =3D (_res & ~SR_VS) | SR_VS_##TYPE;                 =
 \
> +       _res;                                                           \
> +})
> +
> +#define __riscv_v_vstate_check(_val, TYPE) ({                          \
> +       bool _res;                                                      \
> +       if (has_xtheadvector()) \
> +               _res =3D ((_val) & SR_VS_THEAD) =3D=3D SR_VS_##TYPE##_THE=
AD;  \
> +       else                                                            \
> +               _res =3D ((_val) & SR_VS) =3D=3D SR_VS_##TYPE;           =
     \
> +       _res;                                                           \
> +})
>
>  extern unsigned long riscv_v_vsize;
>  int riscv_v_setup_vsize(void);
> @@ -40,39 +61,62 @@ static __always_inline bool has_vector(void)
>         return riscv_has_extension_unlikely(RISCV_ISA_EXT_ZVE32X);
>  }
>
> +static __always_inline bool has_xtheadvector_no_alternatives(void)
> +{
> +       if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR))
> +               return riscv_isa_vendor_extension_available(THEAD_VENDOR_=
ID, XTHEADVECTOR);
> +       else
> +               return false;
> +}
> +
> +static __always_inline bool has_xtheadvector(void)
> +{
> +       if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR))
> +               return riscv_has_vendor_extension_unlikely(THEAD_VENDOR_I=
D,
> +                                                          RISCV_ISA_VEND=
OR_EXT_XTHEADVECTOR);
> +       else
> +               return false;
> +}
> +
>  static inline void __riscv_v_vstate_clean(struct pt_regs *regs)
>  {
> -       regs->status =3D (regs->status & ~SR_VS) | SR_VS_CLEAN;
> +       regs->status =3D __riscv_v_vstate_or(regs->status, CLEAN);
>  }
>
>  static inline void __riscv_v_vstate_dirty(struct pt_regs *regs)
>  {
> -       regs->status =3D (regs->status & ~SR_VS) | SR_VS_DIRTY;
> +       regs->status =3D __riscv_v_vstate_or(regs->status, DIRTY);
>  }
>
>  static inline void riscv_v_vstate_off(struct pt_regs *regs)
>  {
> -       regs->status =3D (regs->status & ~SR_VS) | SR_VS_OFF;
> +       regs->status =3D __riscv_v_vstate_or(regs->status, OFF);
>  }
>
>  static inline void riscv_v_vstate_on(struct pt_regs *regs)
>  {
> -       regs->status =3D (regs->status & ~SR_VS) | SR_VS_INITIAL;
> +       regs->status =3D __riscv_v_vstate_or(regs->status, INITIAL);
>  }
>
>  static inline bool riscv_v_vstate_query(struct pt_regs *regs)
>  {
> -       return (regs->status & SR_VS) !=3D 0;
> +       return !__riscv_v_vstate_check(regs->status, OFF);
>  }
>
>  static __always_inline void riscv_v_enable(void)
>  {
> -       csr_set(CSR_SSTATUS, SR_VS);
> +       if (has_xtheadvector())
> +               csr_set(CSR_SSTATUS, SR_VS_THEAD);
> +       else
> +               csr_set(CSR_SSTATUS, SR_VS);
>  }
>
>  static __always_inline void riscv_v_disable(void)
>  {
> -       csr_clear(CSR_SSTATUS, SR_VS);
> +       if (has_xtheadvector())
> +               csr_clear(CSR_SSTATUS, SR_VS_THEAD);
> +       else
> +               csr_clear(CSR_SSTATUS, SR_VS);
>  }
>
>  static __always_inline void __vstate_csr_save(struct __riscv_v_ext_state=
 *dest)
> @@ -81,10 +125,36 @@ static __always_inline void __vstate_csr_save(struct=
 __riscv_v_ext_state *dest)
>                 "csrr   %0, " __stringify(CSR_VSTART) "\n\t"
>                 "csrr   %1, " __stringify(CSR_VTYPE) "\n\t"
>                 "csrr   %2, " __stringify(CSR_VL) "\n\t"
> -               "csrr   %3, " __stringify(CSR_VCSR) "\n\t"
> -               "csrr   %4, " __stringify(CSR_VLENB) "\n\t"
>                 : "=3Dr" (dest->vstart), "=3Dr" (dest->vtype), "=3Dr" (de=
st->vl),
> -                 "=3Dr" (dest->vcsr), "=3Dr" (dest->vlenb) : :);
> +               "=3Dr" (dest->vcsr) : :);
> +
> +       if (has_xtheadvector()) {
> +               unsigned long status;
> +
> +               /*
> +                * CSR_VCSR is defined as
> +                * [2:1] - vxrm[1:0]
> +                * [0] - vxsat
> +                * The earlier vector spec implemented by T-Head uses sep=
arate
> +                * registers for the same bit-elements, so just combine t=
hose
> +                * into the existing output field.
> +                *
> +                * Additionally T-Head cores need FS to be enabled when a=
ccessing
> +                * the VXRM and VXSAT CSRs, otherwise ending in illegal i=
nstructions.
> +                * Though the cores do not implement the VXRM and VXSAT f=
ields in the
> +                * FCSR CSR that vector-0.7.1 specifies.
> +                */
> +               status =3D csr_read_set(CSR_STATUS, SR_FS_DIRTY);
> +               dest->vcsr =3D csr_read(CSR_VXSAT) | csr_read(CSR_VXRM) <=
< CSR_VXRM_SHIFT;
> +
> +               dest->vlenb =3D riscv_v_vsize / 32;
> +
> +               if ((status & SR_FS) !=3D SR_FS_DIRTY)
> +                       csr_write(CSR_STATUS, status);
> +       } else {
> +               dest->vcsr =3D csr_read(CSR_VCSR);
> +               dest->vlenb =3D csr_read(CSR_VLENB);
> +       }
>  }
>
>  static __always_inline void __vstate_csr_restore(struct __riscv_v_ext_st=
ate *src)
> @@ -95,9 +165,25 @@ static __always_inline void __vstate_csr_restore(stru=
ct __riscv_v_ext_state *src
>                 "vsetvl  x0, %2, %1\n\t"
>                 ".option pop\n\t"
>                 "csrw   " __stringify(CSR_VSTART) ", %0\n\t"
> -               "csrw   " __stringify(CSR_VCSR) ", %3\n\t"
> -               : : "r" (src->vstart), "r" (src->vtype), "r" (src->vl),
> -                   "r" (src->vcsr) :);
> +               : : "r" (src->vstart), "r" (src->vtype), "r" (src->vl));
> +
> +       if (has_xtheadvector()) {
> +               unsigned long status =3D csr_read(CSR_SSTATUS);
> +
> +               /*
> +                * Similar to __vstate_csr_save above, restore values for=
 the
> +                * separate VXRM and VXSAT CSRs from the vcsr variable.
> +                */
> +               status =3D csr_read_set(CSR_STATUS, SR_FS_DIRTY);
> +
> +               csr_write(CSR_VXRM, (src->vcsr >> CSR_VXRM_SHIFT) & CSR_V=
XRM_MASK);
> +               csr_write(CSR_VXSAT, src->vcsr & CSR_VXSAT_MASK);
> +
> +               if ((status & SR_FS) !=3D SR_FS_DIRTY)
> +                       csr_write(CSR_STATUS, status);
> +       } else {
> +               csr_write(CSR_VCSR, src->vcsr);
> +       }
>  }
>
>  static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *sav=
e_to,
> @@ -107,19 +193,33 @@ static inline void __riscv_v_vstate_save(struct __r=
iscv_v_ext_state *save_to,
>
>         riscv_v_enable();
>         __vstate_csr_save(save_to);
> -       asm volatile (
> -               ".option push\n\t"
> -               ".option arch, +zve32x\n\t"
> -               "vsetvli        %0, x0, e8, m8, ta, ma\n\t"
> -               "vse8.v         v0, (%1)\n\t"
> -               "add            %1, %1, %0\n\t"
> -               "vse8.v         v8, (%1)\n\t"
> -               "add            %1, %1, %0\n\t"
> -               "vse8.v         v16, (%1)\n\t"
> -               "add            %1, %1, %0\n\t"
> -               "vse8.v         v24, (%1)\n\t"
> -               ".option pop\n\t"
> -               : "=3D&r" (vl) : "r" (datap) : "memory");
> +       if (has_xtheadvector()) {
> +               asm volatile (
> +                       "mv t0, %0\n\t"
> +                       THEAD_VSETVLI_T4X0E8M8D1
> +                       THEAD_VSB_V_V0T0
> +                       "add            t0, t0, t4\n\t"
> +                       THEAD_VSB_V_V0T0
> +                       "add            t0, t0, t4\n\t"
> +                       THEAD_VSB_V_V0T0
> +                       "add            t0, t0, t4\n\t"
> +                       THEAD_VSB_V_V0T0
> +                       : : "r" (datap) : "memory", "t0", "t4");
> +       } else {
> +               asm volatile (
> +                       ".option push\n\t"
> +                       ".option arch, +zve32x\n\t"
> +                       "vsetvli        %0, x0, e8, m8, ta, ma\n\t"
> +                       "vse8.v         v0, (%1)\n\t"
> +                       "add            %1, %1, %0\n\t"
> +                       "vse8.v         v8, (%1)\n\t"
> +                       "add            %1, %1, %0\n\t"
> +                       "vse8.v         v16, (%1)\n\t"
> +                       "add            %1, %1, %0\n\t"
> +                       "vse8.v         v24, (%1)\n\t"
> +                       ".option pop\n\t"
> +                       : "=3D&r" (vl) : "r" (datap) : "memory");
> +       }
>         riscv_v_disable();
>  }
>
> @@ -129,28 +229,51 @@ static inline void __riscv_v_vstate_restore(struct =
__riscv_v_ext_state *restore_
>         unsigned long vl;
>
>         riscv_v_enable();
> -       asm volatile (
> -               ".option push\n\t"
> -               ".option arch, +zve32x\n\t"
> -               "vsetvli        %0, x0, e8, m8, ta, ma\n\t"
> -               "vle8.v         v0, (%1)\n\t"
> -               "add            %1, %1, %0\n\t"
> -               "vle8.v         v8, (%1)\n\t"
> -               "add            %1, %1, %0\n\t"
> -               "vle8.v         v16, (%1)\n\t"
> -               "add            %1, %1, %0\n\t"
> -               "vle8.v         v24, (%1)\n\t"
> -               ".option pop\n\t"
> -               : "=3D&r" (vl) : "r" (datap) : "memory");
> +       if (has_xtheadvector()) {
> +               asm volatile (
> +                       "mv t0, %0\n\t"
> +                       THEAD_VSETVLI_T4X0E8M8D1
> +                       THEAD_VLB_V_V0T0
> +                       "add            t0, t0, t4\n\t"
> +                       THEAD_VLB_V_V0T0
> +                       "add            t0, t0, t4\n\t"
> +                       THEAD_VLB_V_V0T0
> +                       "add            t0, t0, t4\n\t"
> +                       THEAD_VLB_V_V0T0
> +                       : : "r" (datap) : "memory", "t0", "t4");
> +       } else {
> +               asm volatile (
> +                       ".option push\n\t"
> +                       ".option arch, +zve32x\n\t"
> +                       "vsetvli        %0, x0, e8, m8, ta, ma\n\t"
> +                       "vle8.v         v0, (%1)\n\t"
> +                       "add            %1, %1, %0\n\t"
> +                       "vle8.v         v8, (%1)\n\t"
> +                       "add            %1, %1, %0\n\t"
> +                       "vle8.v         v16, (%1)\n\t"
> +                       "add            %1, %1, %0\n\t"
> +                       "vle8.v         v24, (%1)\n\t"
> +                       ".option pop\n\t"
> +                       : "=3D&r" (vl) : "r" (datap) : "memory");
> +       }
>         __vstate_csr_restore(restore_from);
>         riscv_v_disable();
>  }
>
>  static inline void __riscv_v_vstate_discard(void)
>  {
> -       unsigned long vl, vtype_inval =3D 1UL << (BITS_PER_LONG - 1);
> +       unsigned long vtype_inval =3D 1UL << (BITS_PER_LONG - 1);
>
>         riscv_v_enable();
> +       if (has_xtheadvector())
> +               asm volatile (THEAD_VSETVLI_X0X0E8M8D1);
> +       else
> +               asm volatile (
> +                       ".option push\n\t"
> +                       ".option arch, +v\n\t"
> +                       "vsetvli        x0, x0, e8, m8, ta, ma\n\t"
> +                       ".option pop\n\t");
> +
>         asm volatile (
>                 ".option push\n\t"
>                 ".option arch, +zve32x\n\t"
> @@ -159,25 +282,25 @@ static inline void __riscv_v_vstate_discard(void)
>                 "vmv.v.i        v8, -1\n\t"
>                 "vmv.v.i        v16, -1\n\t"
>                 "vmv.v.i        v24, -1\n\t"
> -               "vsetvl         %0, x0, %1\n\t"
> +               "vsetvl         x0, x0, %0\n\t"
>                 ".option pop\n\t"
> -               : "=3D&r" (vl) : "r" (vtype_inval) : "memory");
> +               : : "r" (vtype_inval));
> +
>         riscv_v_disable();
>  }
>
>  static inline void riscv_v_vstate_discard(struct pt_regs *regs)
>  {
> -       if ((regs->status & SR_VS) =3D=3D SR_VS_OFF)
> -               return;
> -
> -       __riscv_v_vstate_discard();
> -       __riscv_v_vstate_dirty(regs);
> +       if (riscv_v_vstate_query(regs)) {
> +               __riscv_v_vstate_discard();
> +               __riscv_v_vstate_dirty(regs);
> +       }
>  }
>
>  static inline void riscv_v_vstate_save(struct __riscv_v_ext_state *vstat=
e,
>                                        struct pt_regs *regs)
>  {
> -       if ((regs->status & SR_VS) =3D=3D SR_VS_DIRTY) {
> +       if (__riscv_v_vstate_check(regs->status, DIRTY)) {
>                 __riscv_v_vstate_save(vstate, vstate->datap);
>                 __riscv_v_vstate_clean(regs);
>         }
> @@ -186,7 +309,7 @@ static inline void riscv_v_vstate_save(struct __riscv=
_v_ext_state *vstate,
>  static inline void riscv_v_vstate_restore(struct __riscv_v_ext_state *vs=
tate,
>                                           struct pt_regs *regs)
>  {
> -       if ((regs->status & SR_VS) !=3D SR_VS_OFF) {
> +       if (riscv_v_vstate_query(regs)) {
>                 __riscv_v_vstate_restore(vstate, vstate->datap);
>                 __riscv_v_vstate_clean(regs);
>         }
> @@ -195,7 +318,7 @@ static inline void riscv_v_vstate_restore(struct __ri=
scv_v_ext_state *vstate,
>  static inline void riscv_v_vstate_set_restore(struct task_struct *task,
>                                               struct pt_regs *regs)
>  {
> -       if ((regs->status & SR_VS) !=3D SR_VS_OFF) {
> +       if (riscv_v_vstate_query(regs)) {
>                 set_tsk_thread_flag(task, TIF_RISCV_V_DEFER_RESTORE);
>                 riscv_v_vstate_on(regs);
>         }
> @@ -268,6 +391,8 @@ struct pt_regs;
>
>  static inline int riscv_v_setup_vsize(void) { return -EOPNOTSUPP; }
>  static __always_inline bool has_vector(void) { return false; }
> +static __always_inline bool has_xtheadvector_no_alternatives(void) { ret=
urn false; }
> +static __always_inline bool has_xtheadvector(void) { return false; }
>  static inline bool riscv_v_first_use_handler(struct pt_regs *regs) { ret=
urn false; }
>  static inline bool riscv_v_vstate_query(struct pt_regs *regs) { return f=
alse; }
>  static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false=
; }
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 9340efd79af9..56b5054b8f86 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -867,8 +867,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsi=
gned long *isa2hwcap)
>                 riscv_fill_vendor_ext_list(cpu);
>         }
>
> -       if (riscv_isa_vendor_extension_available(THEAD_VENDOR_ID, XTHEADV=
ECTOR) &&
> -           has_thead_homogeneous_vlenb() < 0) {
> +       if (has_xtheadvector_no_alternatives() && has_thead_homogeneous_v=
lenb() < 0) {
>                 pr_warn("Unsupported heterogeneous vlenb detected, vector=
 extension disabled.\n");
>                 disable_xtheadvector();
>         }
> @@ -925,7 +924,8 @@ void __init riscv_fill_hwcap(void)
>                 elf_hwcap &=3D ~COMPAT_HWCAP_ISA_F;
>         }
>
> -       if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_ZVE32X)) =
{
> +       if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_ZVE32X) |=
|
> +           has_xtheadvector_no_alternatives()) {
>                 /*
>                  * This cannot fail when called on the boot hart
>                  */
> diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/k=
ernel_mode_vector.c
> index 6afe80c7f03a..99972a48e86b 100644
> --- a/arch/riscv/kernel/kernel_mode_vector.c
> +++ b/arch/riscv/kernel/kernel_mode_vector.c
> @@ -143,7 +143,7 @@ static int riscv_v_start_kernel_context(bool *is_nest=
ed)
>
>         /* Transfer the ownership of V from user to kernel, then save */
>         riscv_v_start(RISCV_PREEMPT_V | RISCV_PREEMPT_V_DIRTY);
> -       if ((task_pt_regs(current)->status & SR_VS) =3D=3D SR_VS_DIRTY) {
> +       if (__riscv_v_vstate_check(task_pt_regs(current)->status, DIRTY))=
 {
>                 uvstate =3D &current->thread.vstate;
>                 __riscv_v_vstate_save(uvstate, uvstate->datap);
>         }
> @@ -160,7 +160,7 @@ asmlinkage void riscv_v_context_nesting_start(struct =
pt_regs *regs)
>                 return;
>
>         depth =3D riscv_v_ctx_get_depth();
> -       if (depth =3D=3D 0 && (regs->status & SR_VS) =3D=3D SR_VS_DIRTY)
> +       if (depth =3D=3D 0 && __riscv_v_vstate_check(regs->status, DIRTY)=
)
>                 riscv_preempt_v_set_dirty();
>
>         riscv_v_ctx_depth_inc();
> @@ -208,7 +208,7 @@ void kernel_vector_begin(void)
>  {
>         bool nested =3D false;
>
> -       if (WARN_ON(!has_vector()))
> +       if (WARN_ON(!(has_vector() || has_xtheadvector())))
>                 return;
>
>         BUG_ON(!may_use_simd());
> @@ -236,7 +236,7 @@ EXPORT_SYMBOL_GPL(kernel_vector_begin);
>   */
>  void kernel_vector_end(void)
>  {
> -       if (WARN_ON(!has_vector()))
> +       if (WARN_ON(!(has_vector() || has_xtheadvector())))
>                 return;
>
>         riscv_v_disable();
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index e4bc61c4e58a..191023decd16 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -176,7 +176,7 @@ void flush_thread(void)
>  void arch_release_task_struct(struct task_struct *tsk)
>  {
>         /* Free the vector context of datap. */
> -       if (has_vector())
> +       if (has_vector() || has_xtheadvector())
>                 riscv_v_thread_free(tsk);
>  }
>
> @@ -222,7 +222,7 @@ int copy_thread(struct task_struct *p, const struct k=
ernel_clone_args *args)
>                 p->thread.s[0] =3D 0;
>         }
>         p->thread.riscv_v_flags =3D 0;
> -       if (has_vector())
> +       if (has_vector() || has_xtheadvector())
>                 riscv_v_thread_alloc(p);
>         p->thread.ra =3D (unsigned long)ret_from_fork;
>         p->thread.sp =3D (unsigned long)childregs; /* kernel sp */
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index dcd282419456..94e905eea1de 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -189,7 +189,7 @@ static long restore_sigcontext(struct pt_regs *regs,
>
>                         return 0;
>                 case RISCV_V_MAGIC:
> -                       if (!has_vector() || !riscv_v_vstate_query(regs) =
||
> +                       if (!(has_vector() || has_xtheadvector()) || !ris=
cv_v_vstate_query(regs) ||
>                             size !=3D riscv_v_sc_size)
>                                 return -EINVAL;
>
> @@ -211,7 +211,7 @@ static size_t get_rt_frame_size(bool cal_all)
>
>         frame_size =3D sizeof(*frame);
>
> -       if (has_vector()) {
> +       if (has_vector() || has_xtheadvector()) {
>                 if (cal_all || riscv_v_vstate_query(task_pt_regs(current)=
))
>                         total_context_size +=3D riscv_v_sc_size;
>         }
> @@ -284,7 +284,7 @@ static long setup_sigcontext(struct rt_sigframe __use=
r *frame,
>         if (has_fpu())
>                 err |=3D save_fp_state(regs, &sc->sc_fpregs);
>         /* Save the vector state. */
> -       if (has_vector() && riscv_v_vstate_query(regs))
> +       if ((has_vector() || has_xtheadvector()) && riscv_v_vstate_query(=
regs))
>                 err |=3D save_v_state(regs, (void __user **)&sc_ext_ptr);
>         /* Write zero to fp-reserved space and check it on restore_sigcon=
text */
>         err |=3D __put_user(0, &sc->sc_extdesc.reserved);
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 9775d6a9c8ee..f3e1de574050 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -63,7 +63,7 @@ int riscv_v_setup_vsize(void)
>
>  void __init riscv_v_setup_ctx_cache(void)
>  {
> -       if (!has_vector())
> +       if (!(has_vector() || has_xtheadvector()))
>                 return;
>
>         riscv_v_user_cachep =3D kmem_cache_create_usercopy("riscv_vector_=
ctx",
> @@ -183,7 +183,7 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
>         u32 __user *epc =3D (u32 __user *)regs->epc;
>         u32 insn =3D (u32)regs->badaddr;
>
> -       if (!has_vector())
> +       if (!(has_vector() || has_xtheadvector()))
>                 return false;
>
>         /* Do not handle if V is not supported, or disabled */
> @@ -226,7 +226,7 @@ void riscv_v_vstate_ctrl_init(struct task_struct *tsk=
)
>         bool inherit;
>         int cur, next;
>
> -       if (!has_vector())
> +       if (!(has_vector() || has_xtheadvector()))
>                 return;
>
>         next =3D riscv_v_ctrl_get_next(tsk);
> @@ -248,7 +248,7 @@ void riscv_v_vstate_ctrl_init(struct task_struct *tsk=
)
>
>  long riscv_v_vstate_ctrl_get_current(void)
>  {
> -       if (!has_vector())
> +       if (!(has_vector() || has_xtheadvector()))
>                 return -EINVAL;
>
>         return current->thread.vstate_ctrl & PR_RISCV_V_VSTATE_CTRL_MASK;
> @@ -259,7 +259,7 @@ long riscv_v_vstate_ctrl_set_current(unsigned long ar=
g)
>         bool inherit;
>         int cur, next;
>
> -       if (!has_vector())
> +       if (!(has_vector() || has_xtheadvector()))
>                 return -EINVAL;
>
>         if (arg & ~PR_RISCV_V_VSTATE_CTRL_MASK)
> @@ -309,7 +309,7 @@ static struct ctl_table riscv_v_default_vstate_table[=
] =3D {
>
>  static int __init riscv_v_sysctl_init(void)
>  {
> -       if (has_vector())
> +       if (has_vector() || has_xtheadvector())
>                 if (!register_sysctl("abi", riscv_v_default_vstate_table)=
)
>                         return -EINVAL;
>         return 0;
>
> --
> 2.45.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

For the rest of this patch:

Reviewed-by: Andy Chiu <andybnac@gmail.com>

Thanks,
Andy

