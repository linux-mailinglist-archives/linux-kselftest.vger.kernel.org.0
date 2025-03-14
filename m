Return-Path: <linux-kselftest+bounces-29000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10130A60A28
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 08:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB28175024
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 07:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45D18A6DE;
	Fri, 14 Mar 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JAfWBBAP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5A1158870
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741937896; cv=none; b=Hg35MuxaDZbdwO/X0jnX6P0NxPnuyCLdL+BjsUY0++PiCo+0YLc3NRbNZMGpm0Znso1WupGhe7EeNqU6xYgFbXHPoEQ5dJ9vIi81+3J/dYtlcUIN51a4PECvch8iFdUp7BH9yZeDM0noEPmIE86BgvxDQXDDMksQj3KAjrW2ips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741937896; c=relaxed/simple;
	bh=06qpn+VXc/7DV39BF58QleNxqzv6HoU8lFClzZLzhPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAI0mTC+u8oSQDtXEUlQ5D74tiQ2P3Fd6UbzguxSxH6C+KE6zQVCaat2tHBn9GJFCOnGIaGPYgeDGCKszQg79qhUeLCewCvGZC8ubycbddwYZju9OIVrO5bVQcbGpF8RP8+RhDOsvTCtxDRvMUcl5LCholHEBpelnUiviGWYyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JAfWBBAP; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d46fddf43aso14586465ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 00:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741937892; x=1742542692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P83z22nVsy0TdwN/y1tzBRhznwCiNekdo216cawsLo=;
        b=JAfWBBAPHQnjjILhVo7wiOsqh3MCrHPzfCRfQbgbne8adWijl+qt5Rgz361PzYOA07
         ls0ntB5kDP5ZFUwlQLlr0Zs9KCXWVNhksSDky5X2uHwvYi584+/7fK72FXMRL085qPEV
         A+javSvC6b2QQmO9gGuqZb3nnpwckT+qJBfmvHErjFX/GSjzvxV1lB28uw5DqytkXKC3
         vSk7fJwy7kt20upFk5saWzAQwTfyyeJF9ImNkKSPNzIy1lx0QMSRbX5DzZhiDk6AAYPD
         9/mkjJnBdSvcSrec7Wqfa09ChUu19xen16Obr4U9hNNWYNme9ZdDAB1cSIkmKj3sGtfD
         mXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741937892; x=1742542692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P83z22nVsy0TdwN/y1tzBRhznwCiNekdo216cawsLo=;
        b=XSnYhHkPOKXpsTZERy06VMPDlxjiKX7QCYEjb+ZnyDBgDvhAa9Sxv2kG/DBpw+i3NN
         lCoHgmDXguwbHMfTE2BPIqn6mifzcFn8YuaxnwkVnVVnEvMN2GHN6aIzOZWq28fKURps
         WWDoz1QcPvCw3MjwjmhjaDhiAPsoHAojSiVL5BWMjg+4au1bA3yATSrMClZ6MohN9RND
         2B5AS11m2smaJT1JF7mL7ZggYz7uR3xwx/XBTQZAh+MPQzOij/uAa5mQe2guFmUPF2N+
         J5WjKa2Lf1/F5N4B/Owt8oEDgE3jNCy9MtXfRbcZZFZoamRiI/uRZZLlqRJbC6JJl6X2
         Vumg==
X-Forwarded-Encrypted: i=1; AJvYcCV/hWpxyE+gdsrN3Qs8kOJfdFxBy+TTRY0xaPZsq6aF/UBDhy/CNdfope4Uy/Xn5H/8iOFId6JtAM9ncoUF9uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Vw7B9LMoEHYfj/nuw/9epDwpDyGEdhF19ag+hj9fbNTf19/u
	SEnA2N6ptge8hsstxsh318XYS9MQomgBQI/GebqtTxqDqyEOtAuq3v6wF5o2u5QP2jOGa/ditlc
	FnnVsNdBo39n18/MwA0Q2C3Kgicy1vbIr7HFOlQ==
X-Gm-Gg: ASbGncumW65sMOMOrz3nrcQMzkzC3wuThOCYuBKmImJMIyNsLOZLNF9zsYW14LDg4ot
	EFek8JA2qQW0N2rKY7LsG/OkPpUncPfqHxMFUnRU3JeK2THyB9zOIgJLUS9mP6sRZ5feOWN5lEz
	HH8OjvA/jqH/Ec4O/bSfpWyRerMxGTsoRul2CpGuQ=
X-Google-Smtp-Source: AGHT+IFyvkT12+i013M0vxzjGYoHvGKmiPNTdSQO7eiKOWYYyKKOPLHni3BWX5f++FKmCcCNeYHl2rGHeIQykLNckAU=
X-Received: by 2002:a05:6e02:1aa8:b0:3d3:f4fc:a291 with SMTP id
 e9e14a558f8ab-3d483a8dc2amr13220485ab.19.1741937892021; Fri, 14 Mar 2025
 00:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-23-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-23-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 15:37:58 +0800
X-Gm-Features: AQ5f1JrlSOfjsucljdPYnudPUFm9fomUfZIh4MbxfMyusAcNQh-nryqNstYXxqM
Message-ID: <CANXhq0rsMGx_MXfss+RROHip0VLxmsWevvY0ukpRqyqscEthdw@mail.gmail.com>
Subject: Re: [PATCH v11 23/27] arch/riscv: compile vdso with landing pad
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:44=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> From: Jim Shu <jim.shu@sifive.com>
>
> user mode tasks compiled with zicfilp may call indirectly into vdso (like
> hwprobe indirect calls). Add landing pad compile support in vdso. vdso
> with landing pad in it will be nop for tasks which have not enabled
> landing pad.
> This patch allows to run user mode tasks with cfi eanbled and do no harm.
>
> Future work can be done on this to do below
>  - labeled landing pad on vdso functions (whenever labeling support shows
>    up in gnu-toolchain)
>  - emit shadow stack instructions only in vdso compiled objects as part o=
f
>    kernel compile.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/Makefile                   |  7 +++++-
>  arch/riscv/include/asm/assembler.h    | 44 +++++++++++++++++++++++++++++=
++++++
>  arch/riscv/kernel/vdso/Makefile       | 12 ++++++++++
>  arch/riscv/kernel/vdso/flush_icache.S |  4 ++++
>  arch/riscv/kernel/vdso/getcpu.S       |  4 ++++
>  arch/riscv/kernel/vdso/rt_sigreturn.S |  4 ++++
>  arch/riscv/kernel/vdso/sys_hwprobe.S  |  4 ++++
>  7 files changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 13fbc0f94238..ea9468af2cb4 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -87,10 +87,15 @@ riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) :=3D $(risc=
v-march-y)_zacas
>
>  # Check if the toolchain supports Zabha
>  riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) :=3D $(riscv-march-y)_zabha
> +# Check if the toolchain supports Zihintpause extension
> +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) :=3D $(riscv-march-y)_zi=
hintpause

I think we don't need this, it has removed by the '6da111574baf
("riscv: Provide a definition for 'pause'")'. Apart from that, this
patch looks good to me.

Reviewed-by: Zong Li <zong.li@sifive.com>

> +
> +KBUILD_BASE_ISA =3D -march=3D$(shell echo $(riscv-march-y) | sed -E 's/(=
rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> +export KBUILD_BASE_ISA
>
>  # Remove F,D,V from isa string for all. Keep extensions between "fd" and=
 "v" by
>  # matching non-v and non-multi-letter extensions out with the filter ([^=
v_]*)
> -KBUILD_CFLAGS +=3D -march=3D$(shell echo $(riscv-march-y) | sed -E 's/(r=
v32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> +KBUILD_CFLAGS +=3D $(KBUILD_BASE_ISA)
>
>  KBUILD_AFLAGS +=3D -march=3D$(riscv-march-y)
>
> diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/=
assembler.h
> index 44b1457d3e95..a058ea5e9c58 100644
> --- a/arch/riscv/include/asm/assembler.h
> +++ b/arch/riscv/include/asm/assembler.h
> @@ -80,3 +80,47 @@
>         .endm
>
>  #endif /* __ASM_ASSEMBLER_H */
> +
> +#if defined(CONFIG_RISCV_USER_CFI) && (__riscv_xlen =3D=3D 64)
> +.macro vdso_lpad
> +lpad 0
> +.endm
> +#else
> +.macro vdso_lpad
> +.endm
> +#endif
> +
> +/*
> + * This macro emits a program property note section identifying
> + * architecture features which require special handling, mainly for
> + * use in assembly files included in the VDSO.
> + */
> +#define NT_GNU_PROPERTY_TYPE_0  5
> +#define GNU_PROPERTY_RISCV_FEATURE_1_AND 0xc0000000
> +
> +#define GNU_PROPERTY_RISCV_FEATURE_1_ZICFILP      (1U << 0)
> +#define GNU_PROPERTY_RISCV_FEATURE_1_ZICFISS      (1U << 1)
> +
> +#if defined(CONFIG_RISCV_USER_CFI) && (__riscv_xlen =3D=3D 64)
> +#define GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT \
> +       (GNU_PROPERTY_RISCV_FEATURE_1_ZICFILP)
> +#endif
> +
> +#ifdef GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT
> +.macro emit_riscv_feature_1_and, feat =3D GNU_PROPERTY_RISCV_FEATURE_1_D=
EFAULT
> +       .pushsection .note.gnu.property, "a"
> +       .p2align        3
> +       .word           4
> +       .word           16
> +       .word           NT_GNU_PROPERTY_TYPE_0
> +       .asciz          "GNU"
> +       .word           GNU_PROPERTY_RISCV_FEATURE_1_AND
> +       .word           4
> +       .word           \feat
> +       .word           0
> +       .popsection
> +.endm
> +#else
> +.macro emit_riscv_feature_1_and, feat =3D 0
> +.endm
> +#endif
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Mak=
efile
> index 9a1b555e8733..daa10c2b0dd1 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -13,12 +13,18 @@ vdso-syms +=3D flush_icache
>  vdso-syms +=3D hwprobe
>  vdso-syms +=3D sys_hwprobe
>
> +ifdef CONFIG_RISCV_USER_CFI
> +LPAD_MARCH =3D _zicfilp
> +endif
> +
>  # Files to link into the vdso
>  obj-vdso =3D $(patsubst %, %.o, $(vdso-syms)) note.o
>
>  ccflags-y :=3D -fno-stack-protector
>  ccflags-y +=3D -DDISABLE_BRANCH_PROFILING
>  ccflags-y +=3D -fno-builtin
> +ccflags-y +=3D $(KBUILD_BASE_ISA)$(LPAD_MARCH)
> +asflags-y +=3D $(KBUILD_BASE_ISA)$(LPAD_MARCH)
>
>  ifneq ($(c-gettimeofday-y),)
>    CFLAGS_vgettimeofday.o +=3D -fPIC -include $(c-gettimeofday-y)
> @@ -40,6 +46,12 @@ endif
>  CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
>  CFLAGS_REMOVE_hwprobe.o =3D $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
>
> +# Disable profiling and instrumentation for VDSO code
> +GCOV_PROFILE :=3D n
> +KCOV_INSTRUMENT :=3D n
> +KASAN_SANITIZE :=3D n
> +UBSAN_SANITIZE :=3D n
> +
>  # Force dependency
>  $(obj)/vdso.o: $(obj)/vdso.so
>
> diff --git a/arch/riscv/kernel/vdso/flush_icache.S b/arch/riscv/kernel/vd=
so/flush_icache.S
> index 8f884227e8bc..e4c56970905e 100644
> --- a/arch/riscv/kernel/vdso/flush_icache.S
> +++ b/arch/riscv/kernel/vdso/flush_icache.S
> @@ -5,11 +5,13 @@
>
>  #include <linux/linkage.h>
>  #include <asm/unistd.h>
> +#include <asm/assembler.h>
>
>         .text
>  /* int __vdso_flush_icache(void *start, void *end, unsigned long flags);=
 */
>  SYM_FUNC_START(__vdso_flush_icache)
>         .cfi_startproc
> +       vdso_lpad
>  #ifdef CONFIG_SMP
>         li a7, __NR_riscv_flush_icache
>         ecall
> @@ -20,3 +22,5 @@ SYM_FUNC_START(__vdso_flush_icache)
>         ret
>         .cfi_endproc
>  SYM_FUNC_END(__vdso_flush_icache)
> +
> +emit_riscv_feature_1_and
> diff --git a/arch/riscv/kernel/vdso/getcpu.S b/arch/riscv/kernel/vdso/get=
cpu.S
> index 9c1bd531907f..5c1ecc4e1465 100644
> --- a/arch/riscv/kernel/vdso/getcpu.S
> +++ b/arch/riscv/kernel/vdso/getcpu.S
> @@ -5,14 +5,18 @@
>
>  #include <linux/linkage.h>
>  #include <asm/unistd.h>
> +#include <asm/assembler.h>
>
>         .text
>  /* int __vdso_getcpu(unsigned *cpu, unsigned *node, void *unused); */
>  SYM_FUNC_START(__vdso_getcpu)
>         .cfi_startproc
> +       vdso_lpad
>         /* For now, just do the syscall. */
>         li a7, __NR_getcpu
>         ecall
>         ret
>         .cfi_endproc
>  SYM_FUNC_END(__vdso_getcpu)
> +
> +emit_riscv_feature_1_and
> diff --git a/arch/riscv/kernel/vdso/rt_sigreturn.S b/arch/riscv/kernel/vd=
so/rt_sigreturn.S
> index 3dc022aa8931..e82987dc3739 100644
> --- a/arch/riscv/kernel/vdso/rt_sigreturn.S
> +++ b/arch/riscv/kernel/vdso/rt_sigreturn.S
> @@ -5,12 +5,16 @@
>
>  #include <linux/linkage.h>
>  #include <asm/unistd.h>
> +#include <asm/assembler.h>
>
>         .text
>  SYM_FUNC_START(__vdso_rt_sigreturn)
>         .cfi_startproc
>         .cfi_signal_frame
> +       vdso_lpad
>         li a7, __NR_rt_sigreturn
>         ecall
>         .cfi_endproc
>  SYM_FUNC_END(__vdso_rt_sigreturn)
> +
> +emit_riscv_feature_1_and
> diff --git a/arch/riscv/kernel/vdso/sys_hwprobe.S b/arch/riscv/kernel/vds=
o/sys_hwprobe.S
> index 77e57f830521..f1694451a60c 100644
> --- a/arch/riscv/kernel/vdso/sys_hwprobe.S
> +++ b/arch/riscv/kernel/vdso/sys_hwprobe.S
> @@ -3,13 +3,17 @@
>
>  #include <linux/linkage.h>
>  #include <asm/unistd.h>
> +#include <asm/assembler.h>
>
>  .text
>  SYM_FUNC_START(riscv_hwprobe)
>         .cfi_startproc
> +       vdso_lpad
>         li a7, __NR_riscv_hwprobe
>         ecall
>         ret
>
>         .cfi_endproc
>  SYM_FUNC_END(riscv_hwprobe)
> +
> +emit_riscv_feature_1_and
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

