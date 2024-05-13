Return-Path: <linux-kselftest+bounces-10135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 340618C3D7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 10:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46111F22126
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE42D1482EB;
	Mon, 13 May 2024 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LdmiXlMa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD78146D4D
	for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589933; cv=none; b=uUyKhsCObuLOjbAzbvM9L8oM1te6HN3hH0AHLvY+71G0mcK24Z4aj0L7R86utm69GVxD7P4mYD4nlyasuZTnhlWyj/BlJUUtGBZ13erCweVT7+MCpPpeBK+ZE3li57VjjYamA3T6bL/Ry5zpW3MolBFEGaajX6AKUWPV+MJBDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589933; c=relaxed/simple;
	bh=t9B6PGb5qBLbhtEQThWWPBAUkBUONTNLxQ9X0tPf2Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPZZzz7qP22UZBJ2iopcVw0e8cMJdCsxFtw0NUmZ0Kq0Awcz8iw2hmP8DzhsU0tllPdi2rP4/06dXjG2gVHKlaEalfSXkHtfB4FJB1RYThgW3kkG3oUZrruxMVOADh3+rE5gP9EysnqkEtNCQNOhbBn9/ie5WNS6JWr3JNv/LRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=LdmiXlMa; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-620390308e5so36327637b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715589930; x=1716194730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdBEm+7Bzyf8ybTn28Qe65zyFvN0QEjy08+SqQ/NGoI=;
        b=LdmiXlMaZuIGpUkElXgUgykzCX0nX8SAkiSOdxa25Tnt7HzUIf/vOGUkFIkllsZIKJ
         wreRO1xk5FPl6rBxMX23aj4/O7fJu9nmj4ngXAF2yrpiVJrdmSANqY0uudbYJmzDJRdf
         M12gWm9ImKNVAJW8EIMKf/vc9Npne38HKVU23Pd0S811Bx855RMSZGyqC+cBrEmIefVd
         gC/38madTYtYprZCQpdgOimRQSHavbK3Ew+ScAkJczE3aB1vrRoIUfRhCDP7m1tyALTc
         Tkhhx9mrbxPR3LCyTIAEt7uiqI/Ih24Fbgk+azv25l2UBAD6jyxaYcPb9aP26ZSBsfOl
         ylAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715589930; x=1716194730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdBEm+7Bzyf8ybTn28Qe65zyFvN0QEjy08+SqQ/NGoI=;
        b=W4fsjNq+Bz4k4CkjD6IWeOUs0pxGFTUkhFjU5L6nEZfHN9DCFQLMjkeMn3rq0EJ5tH
         IIWhBXXm5G5I+TqE+wz7sHjsKZBHqonrYs5VM20ey3FIJulCrWk4t8CjLkiBH8dNTPJm
         aFKF16DDsKK4jd+4/P+fZ90VziQIePBEPXVGPzwrfEEAKphIiJLWAIlPVPVg3kXRDsbb
         W4c0Cx3OWFk7KXknmBrmezYK72z92HaHy/9mqNuti2C/KlA2JQMa6DBMOo+hEqsaeHca
         OsGPDtP2jKL8AobAZlLI6p+YfTx5hk3CgcCqhi+7EPEFcWiG67yQYpOFUnnsVG3inYbu
         tzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbEsg0Mc+FJYMPFtnXc+AbfnZBNzwfb6yBR46wReLxEHs8Bpb2i45ZEWAe+362CAeDopbV0qg20SjROZzMZRUxL+z6k5LmcOHzZExjkVeK
X-Gm-Message-State: AOJu0Yy7UAoML8q88J9QkLVtIJU4mE1cl9s3aGJ3muK8q4CffMzPjecA
	YJIqRQHqIrsKnYyYaFZJVAOiGAZN1lBYuaHL3PjeZuSR1/rqwkPXxtLqIjIfcyx+6YSi9NEeWIf
	vkD5IwBBob3p9icnqGEvHmzVfVCut5nsjPZHbkA==
X-Google-Smtp-Source: AGHT+IFq4Yv+/rwyBZNeMdMYgWJckamTzyfvI81iBuITZN8sw70w3LDbQOBp9vf/LsPHIodtMOAQKBYwqFKSxUjsSu4=
X-Received: by 2002:a05:690c:6209:b0:61a:e947:550d with SMTP id
 00721157ae682-622b013826fmr109570167b3.44.1715589929689; Mon, 13 May 2024
 01:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-13-cb7624e65d82@rivosinc.com>
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-13-cb7624e65d82@rivosinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Mon, 13 May 2024 16:45:18 +0800
Message-ID: <CABgGipUMtgQxYx1mUBojtCSh7kwAco=P_NYuWp=QtLBFSziT_A@mail.gmail.com>
Subject: Re: [PATCH v6 13/17] riscv: vector: Support xtheadvector save/restore
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Charlie,

Sorry, I am late on this. I haven't looked through the entire series
yet, but here is something that I thought worth bringing up sooner.

On Sat, May 4, 2024 at 2:22=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> Use alternatives to add support for xtheadvector vector save/restore
> routines.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig.vendor              |  13 ++
>  arch/riscv/include/asm/csr.h           |   6 +
>  arch/riscv/include/asm/switch_to.h     |   2 +-
>  arch/riscv/include/asm/vector.h        | 247 ++++++++++++++++++++++++++-=
------
>  arch/riscv/kernel/cpufeature.c         |   2 +-
>  arch/riscv/kernel/kernel_mode_vector.c |   8 +-
>  arch/riscv/kernel/process.c            |   4 +-
>  arch/riscv/kernel/signal.c             |   6 +-
>  arch/riscv/kernel/vector.c             |  13 +-
>  9 files changed, 233 insertions(+), 68 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> index aa5a191e659e..edf49f3065ac 100644
> --- a/arch/riscv/Kconfig.vendor
> +++ b/arch/riscv/Kconfig.vendor
> @@ -13,6 +13,19 @@ config RISCV_ISA_VENDOR_EXT_THEAD
>           extensions. Without this option enabled, T-Head vendor extensio=
ns will
>           not be detected at boot and their presence not reported to user=
space.
>
> +         If you don't know what to do here, say Y.
> +
> +config RISCV_ISA_XTHEADVECTOR
> +       bool "xtheadvector extension support"
> +       depends on RISCV_ISA_VENDOR_EXT_THEAD
> +       depends on RISCV_ISA_V
> +       depends on FPU
> +       default y
> +       help
> +         Say N here if you want to disable all xtheadvector related proc=
edure
> +         in the kernel. This will disable vector for any T-Head board th=
at
> +         contains xtheadvector rather than the standard vector.
> +
>           If you don't know what to do here, say Y.
>  endmenu
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index e5a35efd56e0..13657d096e7d 100644
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
> index 7efdb0584d47..ada6b5cf2d94 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -78,7 +78,7 @@ do {                                                  \
>         struct task_struct *__next =3D (next);            \
>         if (has_fpu())                                  \
>                 __switch_to_fpu(__prev, __next);        \
> -       if (has_vector())                                       \
> +       if (has_vector() || has_xtheadvector())         \
>                 __switch_to_vector(__prev, __next);     \
>         ((last) =3D __switch_to(__prev, __next));         \
>  } while (0)
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index 731dcd0ed4de..db851dc81870 100644
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
>         return riscv_has_extension_unlikely(RISCV_ISA_EXT_v);
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
> @@ -81,10 +125,47 @@ static __always_inline void __vstate_csr_save(struct=
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
> +               u32 tmp_vcsr;
> +               bool restore_fpu =3D false;
> +               unsigned long status =3D csr_read(CSR_SSTATUS);
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
> +               if ((status & SR_FS) =3D=3D SR_FS_OFF) {
> +                       csr_set(CSR_SSTATUS, (status & ~SR_FS) | SR_FS_CL=
EAN);
> +                       restore_fpu =3D true;
> +               }
> +
> +               asm volatile (
> +                       "csrr   %[tmp_vcsr], " __stringify(VCSR_VXRM) "\n=
\t"
> +                       "slliw  %[vcsr], %[tmp_vcsr], " __stringify(VCSR_=
VXRM_SHIFT) "\n\t"
> +                       "csrr   %[tmp_vcsr], " __stringify(VCSR_VXSAT) "\=
n\t"
> +                       "or     %[vcsr], %[vcsr], %[tmp_vcsr]\n\t"
> +                       : [vcsr] "=3Dr" (dest->vcsr), [tmp_vcsr] "=3D&r" =
(tmp_vcsr));
> +
> +               if (restore_fpu)
> +                       csr_set(CSR_SSTATUS, status);

vlenb is on ABI and ptrace needs that to recover the width of the
register. So we should probably save Xtheadvector's vlenb into vstate
if we meant to maintain ABI compatibility between V and Xtheadvector
from the kernel.

> +       } else {
> +               asm volatile (
> +                       "csrr   %[vcsr], " __stringify(CSR_VCSR) "\n\t"
> +                       "csrr   %[vlenb], " __stringify(CSR_VLENB) "\n\t"
> +                       : [vcsr] "=3Dr" (dest->vcsr), [vlenb] "=3Dr" (des=
t->vlenb));
> +       }
>  }
>
>  static __always_inline void __vstate_csr_restore(struct __riscv_v_ext_st=
ate *src)
> @@ -95,9 +176,37 @@ static __always_inline void __vstate_csr_restore(stru=
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
> +               u32 tmp_vcsr;
> +               bool restore_fpu =3D false;
> +               unsigned long status =3D csr_read(CSR_SSTATUS);
> +
> +               /*
> +                * Similar to __vstate_csr_save above, restore values for=
 the
> +                * separate VXRM and VXSAT CSRs from the vcsr variable.
> +                */
> +               if ((status & SR_FS) =3D=3D SR_FS_OFF) {
> +                       csr_set(CSR_SSTATUS, (status & ~SR_FS) | SR_FS_CL=
EAN);
> +                       restore_fpu =3D true;
> +               }
> +
> +               asm volatile (
> +                       "srliw  %[tmp_vcsr], %[vcsr], " __stringify(VCSR_=
VXRM_SHIFT) "\n\t"
> +                       "andi   %[tmp_vcsr], %[tmp_vcsr], " __stringify(V=
CSR_VXRM_MASK) "\n\t"
> +                       "csrw   " __stringify(VCSR_VXRM) ", %[tmp_vcsr]\n=
\t"
> +                       "andi   %[tmp_vcsr], %[vcsr], " __stringify(VCSR_=
VXSAT_MASK) "\n\t"
> +                       "csrw   " __stringify(VCSR_VXSAT) ", %[tmp_vcsr]\=
n\t"
> +                       : [tmp_vcsr] "=3D&r" (tmp_vcsr) : [vcsr] "r" (src=
->vcsr));
> +
> +               if (restore_fpu)
> +                       csr_set(CSR_SSTATUS, status);
> +       } else {
> +               asm volatile (
> +                       "csrw   " __stringify(CSR_VCSR) ", %[vcsr]\n\t"
> +                       : : [vcsr] "r" (src->vcsr));
> +       }
>  }
>
>  static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *sav=
e_to,
> @@ -107,19 +216,33 @@ static inline void __riscv_v_vstate_save(struct __r=
iscv_v_ext_state *save_to,
>
>         riscv_v_enable();
>         __vstate_csr_save(save_to);
> -       asm volatile (
> -               ".option push\n\t"
> -               ".option arch, +v\n\t"
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
> +                       ".option arch, +v\n\t"
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
> @@ -129,55 +252,77 @@ static inline void __riscv_v_vstate_restore(struct =
__riscv_v_ext_state *restore_
>         unsigned long vl;
>
>         riscv_v_enable();
> -       asm volatile (
> -               ".option push\n\t"
> -               ".option arch, +v\n\t"
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
> +                       ".option arch, +v\n\t"
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
>                 ".option arch, +v\n\t"
> -               "vsetvli        %0, x0, e8, m8, ta, ma\n\t"
>                 "vmv.v.i        v0, -1\n\t"
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
> @@ -186,7 +331,7 @@ static inline void riscv_v_vstate_save(struct __riscv=
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
> @@ -195,7 +340,7 @@ static inline void riscv_v_vstate_restore(struct __ri=
scv_v_ext_state *vstate,
>  static inline void riscv_v_vstate_set_restore(struct task_struct *task,
>                                               struct pt_regs *regs)
>  {
> -       if ((regs->status & SR_VS) !=3D SR_VS_OFF) {
> +       if (riscv_v_vstate_query(regs)) {
>                 set_tsk_thread_flag(task, TIF_RISCV_V_DEFER_RESTORE);
>                 riscv_v_vstate_on(regs);
>         }
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 2993318b8ea2..44f0017a98d5 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -781,7 +781,7 @@ void __init riscv_fill_hwcap(void)
>                 elf_hwcap &=3D ~COMPAT_HWCAP_ISA_F;
>         }
>
> -       if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> +       if (elf_hwcap & COMPAT_HWCAP_ISA_V || has_xtheadvector_no_alterna=
tives()) {
>                 riscv_v_setup_vsize();
>                 /*
>                  * ISA string in device tree might have 'v' flag, but
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
> index 92922dbd5b5c..eabca86fc3c0 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -178,7 +178,7 @@ void flush_thread(void)
>  void arch_release_task_struct(struct task_struct *tsk)
>  {
>         /* Free the vector context of datap. */
> -       if (has_vector())
> +       if (has_vector() || has_xtheadvector())
>                 riscv_v_thread_free(tsk);
>  }
>
> @@ -225,7 +225,7 @@ int copy_thread(struct task_struct *p, const struct k=
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
> index 501e66debf69..5d3ba8e46807 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -188,7 +188,7 @@ static long restore_sigcontext(struct pt_regs *regs,
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
> @@ -210,7 +210,7 @@ static size_t get_rt_frame_size(bool cal_all)
>
>         frame_size =3D sizeof(*frame);
>
> -       if (has_vector()) {
> +       if (has_vector() || has_xtheadvector()) {
>                 if (cal_all || riscv_v_vstate_query(task_pt_regs(current)=
))
>                         total_context_size +=3D riscv_v_sc_size;
>         }
> @@ -283,7 +283,7 @@ static long setup_sigcontext(struct rt_sigframe __use=
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
> index e04586cdb7f0..c12ea4547da6 100644
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
> @@ -184,7 +184,8 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
>         u32 insn =3D (u32)regs->badaddr;
>
>         /* Do not handle if V is not supported, or disabled */
> -       if (!(ELF_HWCAP & COMPAT_HWCAP_ISA_V))
> +       if (!(ELF_HWCAP & COMPAT_HWCAP_ISA_V) &&
> +           !(has_xtheadvector() && riscv_v_vstate_ctrl_user_allowed()))
>                 return false;
>
>         /* If V has been enabled then it is not the first-use trap */
> @@ -223,7 +224,7 @@ void riscv_v_vstate_ctrl_init(struct task_struct *tsk=
)
>         bool inherit;
>         int cur, next;
>
> -       if (!has_vector())
> +       if (!(has_vector() || has_xtheadvector()))
>                 return;
>
>         next =3D riscv_v_ctrl_get_next(tsk);
> @@ -245,7 +246,7 @@ void riscv_v_vstate_ctrl_init(struct task_struct *tsk=
)
>
>  long riscv_v_vstate_ctrl_get_current(void)
>  {
> -       if (!has_vector())
> +       if (!(has_vector() || has_xtheadvector()))
>                 return -EINVAL;
>
>         return current->thread.vstate_ctrl & PR_RISCV_V_VSTATE_CTRL_MASK;
> @@ -256,7 +257,7 @@ long riscv_v_vstate_ctrl_set_current(unsigned long ar=
g)
>         bool inherit;
>         int cur, next;
>
> -       if (!has_vector())
> +       if (!(has_vector() || has_xtheadvector()))
>                 return -EINVAL;
>
>         if (arg & ~PR_RISCV_V_VSTATE_CTRL_MASK)
> @@ -306,7 +307,7 @@ static struct ctl_table riscv_v_default_vstate_table[=
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
> 2.44.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Cheers,
Andy

