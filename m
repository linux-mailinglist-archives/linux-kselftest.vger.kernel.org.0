Return-Path: <linux-kselftest+bounces-18913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4296B98E0F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 18:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E2C281173
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 16:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835A1D0BAC;
	Wed,  2 Oct 2024 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ3lgpg3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A028D16419;
	Wed,  2 Oct 2024 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886876; cv=none; b=tWg1VZ9YSN74NUdnS+YoBzfsh9jOkCtgb1IFmENHuSShR/US6+OKv02S/53kQYTDQ1kAv18gNJyJd8iJ9vvA//8/deG6DD+tQWny2fnu3e8YiEzNpcNMGANJ1wF2n32RbiJgkQSBpB0jVzcLQeEJ+MK8YZxZX7Xoi6fRQ5XcPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886876; c=relaxed/simple;
	bh=NnwQ7LAGAxixEU4C57nqV40K8xhTnDxUSYDnZ+6Jx4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZ222diKHM5FkLXsc7EsSGRORNRAdAE+6zFZLLSHJZCE+uUbiKvdBqn061oW6aGPmX5ItJf8mh7IlxIUWaXTlr0Is5EjybPAykgfcgBgNL6h77krhQ/T7u4RDFKcxk/GlrX56zDH0IIcucgpd2RVlELHcaHbetfuECFZQQZtExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQ3lgpg3; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso872175276.1;
        Wed, 02 Oct 2024 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727886873; x=1728491673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQVXcgcWb3+JCHYIMAuGzo6fMmStxHBjGOXfuvL8Pek=;
        b=kQ3lgpg3V7aNFkb9NMZU4R1fxxqXO9znU00/E44VX6NLQXdSXaf3ZzqUawvFcBTj5P
         UUXo4fRueqUD6HyidAd6SHnlG8ZxNKavRwf54iIjTnanT01h4vBstWTX0l99EjGY24PA
         4+tixGmAqNyk/15YnAt2lNgbhX2KZ/3j5E2p9O/upsNVNb2xBxETurRkEsfDkEfm3j/V
         iTUbKxrMQL4+529vQ9Qzksj8a5AN6aMuZ6AYJIVdHNALuZvgV4Q0H1o5RJyqkOXc50q+
         cuxfEA180wB9ZsyX6KeZ1NK6vMgDymlVvWqngFcLjLpPguPIHwu9olWRiXCeWsE1fwXv
         KX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727886873; x=1728491673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQVXcgcWb3+JCHYIMAuGzo6fMmStxHBjGOXfuvL8Pek=;
        b=a3mpvBn8gQ6Ye9qxT7Svosk1EpUyl67mW5RjgQLpD3JsOcSvbVN0VdUu9J1stm6CH0
         B9Ke8DL1ZEree3n5eALqv9RA8G8DCNUq8VyN+VAa9DqzEM2tsbkilT0C0lQ40weQw/mV
         f6Es6iqn0iQvFa5uE7TablHdpPs4WZ+uTfbNnSqfNZHzvFDx58E2S4vx7Olo58c34zXy
         0sgFyL8MdxMM36nmIv5NR6ptzYANl1mLqwRujkUuoI4e6NGb9KLivkJq/WRRS7Ryf5Rb
         nWR3LhDGeIZngIBKtOzxPyAjPadLi+otCEe1cMi9aYTWPfUPdKRgEsNy2tO9pOP4EvtU
         gIsg==
X-Forwarded-Encrypted: i=1; AJvYcCVOagkV4Qdx0FFqPR59P5QnxjmMrFSgf01G2d1OdFOPcFckN0i1e+Wt41sujntZjV8IKB9OCIX/DVfikuRv@vger.kernel.org, AJvYcCVmV7MMXLwM7DvQK+9+zyZTv4L53CsEJvHXbTN8Hca3p2WzfVrFLl2k/R2JcIIlylMkChs1RpyV4/X6@vger.kernel.org, AJvYcCWCUsjA+9h+XSOacHZvjuclJG3+ydqgVDdg+MK7d92h1Dwj/CqfqxPlgjz0Fu9Pyn5xqJHlsF7ZQPjw@vger.kernel.org, AJvYcCXyb9ndd0pwKZUEodQx0Mow+D5xjIPQk8L3pbdiwc6pSJmpIsqYQCodVYJ/OGrNbgVpmDb7fBEXUWc/M7ozk4uK@vger.kernel.org
X-Gm-Message-State: AOJu0YwRoGFew2MmB/av/aD3Gp/kwrfZwe4slFCWinJewEDMcCGtf6iN
	AP8B76fPj52GANZlUkL1KldCl5igZURJVjVM0p7IoFJ/yzbSGuO9woYZyctYxK1sbXDeE/M5obb
	9+6ZVFaGq1pgfK32ZIxFbZ/8Dv1Q=
X-Google-Smtp-Source: AGHT+IFaurByFKQGb+Ek8BjD7IiDaNQu0XiestB8fze0pRLRSvBSEGmbKq6ZzNot0XGsSfWE0DJmHLynAXQkW4fMBb0=
X-Received: by 2002:a05:6902:cc8:b0:e26:2863:403e with SMTP id
 3f1490d57ef6-e286fa8c623mr188070276.22.1727886873449; Wed, 02 Oct 2024
 09:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com> <20240911-xtheadvector-v10-5-8d3930091246@rivosinc.com>
In-Reply-To: <20240911-xtheadvector-v10-5-8d3930091246@rivosinc.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Thu, 3 Oct 2024 00:34:22 +0800
Message-ID: <CAFTtA3O1Kb=DGVbyaz0bfP76mQCGxawq=rtW__TB_3Ubx6AobA@mail.gmail.com>
Subject: Re: [PATCH v10 05/14] riscv: vector: Use vlenb from DT for thead
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

Charlie Jenkins <charlie@rivosinc.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=8812=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:57=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> If thead,vlenb is provided in the device tree, prefer that over reading
> the vlenb csr.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/Kconfig.vendor                        | 13 +++++++
>  arch/riscv/include/asm/cpufeature.h              |  2 +
>  arch/riscv/include/asm/vendor_extensions/thead.h |  6 +++
>  arch/riscv/kernel/cpufeature.c                   | 48 ++++++++++++++++++=
++++++
>  arch/riscv/kernel/vector.c                       | 12 +++++-
>  arch/riscv/kernel/vendor_extensions/thead.c      | 11 ++++++
>  6 files changed, 91 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> index 9897442bd44f..b096548fe0ff 100644
> --- a/arch/riscv/Kconfig.vendor
> +++ b/arch/riscv/Kconfig.vendor
> @@ -26,6 +26,19 @@ config RISCV_ISA_VENDOR_EXT_THEAD
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
edures
> +         in the kernel. This will disable vector for any T-Head board th=
at
> +         contains xtheadvector rather than the standard vector.
> +
>           If you don't know what to do here, say Y.
>  endmenu
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 45f9c1171a48..28bdeb1005e0 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -31,6 +31,8 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>  /* Per-cpu ISA extensions. */
>  extern struct riscv_isainfo hart_isa[NR_CPUS];
>
> +extern u32 thead_vlenb_of;
> +
>  void riscv_user_isa_enable(void);
>
>  #define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size,=
 _validate) {  \
> diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/risc=
v/include/asm/vendor_extensions/thead.h
> index 48421d1553ad..190c91e37e95 100644
> --- a/arch/riscv/include/asm/vendor_extensions/thead.h
> +++ b/arch/riscv/include/asm/vendor_extensions/thead.h
> @@ -13,4 +13,10 @@
>
>  extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_t=
head;
>
> +#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
> +void disable_xtheadvector(void);
> +#else
> +void disable_xtheadvector(void) { }
> +#endif
> +
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 46e69b9d66a7..9340efd79af9 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -37,6 +37,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __r=
ead_mostly;
>  /* Per-cpu ISA extensions. */
>  struct riscv_isainfo hart_isa[NR_CPUS];
>
> +u32 thead_vlenb_of;
> +
>  /**
>   * riscv_isa_extension_base() - Get base extension word
>   *
> @@ -772,6 +774,46 @@ static void __init riscv_fill_vendor_ext_list(int cp=
u)
>         }
>  }
>
> +static int has_thead_homogeneous_vlenb(void)
> +{
> +       int cpu;
> +       u32 prev_vlenb =3D 0;
> +       u32 vlenb;
> +
> +       /* Ignore thead,vlenb property if xtheavector is not enabled in t=
he kernel */
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR))
> +               return 0;
> +
> +       for_each_possible_cpu(cpu) {
> +               struct device_node *cpu_node;
> +
> +               cpu_node =3D of_cpu_device_node_get(cpu);
> +               if (!cpu_node) {
> +                       pr_warn("Unable to find cpu node\n");
> +                       return -ENOENT;
> +               }
> +
> +               if (of_property_read_u32(cpu_node, "thead,vlenb", &vlenb)=
) {
> +                       of_node_put(cpu_node);
> +
> +                       if (prev_vlenb)
> +                               return -ENOENT;
> +                       continue;
> +               }
> +
> +               if (prev_vlenb && vlenb !=3D prev_vlenb) {
> +                       of_node_put(cpu_node);
> +                       return -ENOENT;
> +               }
> +
> +               prev_vlenb =3D vlenb;
> +               of_node_put(cpu_node);
> +       }
> +
> +       thead_vlenb_of =3D vlenb;
> +       return 0;
> +}
> +
>  static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwca=
p)
>  {
>         unsigned int cpu;
> @@ -825,6 +867,12 @@ static int __init riscv_fill_hwcap_from_ext_list(uns=
igned long *isa2hwcap)
>                 riscv_fill_vendor_ext_list(cpu);
>         }
>
> +       if (riscv_isa_vendor_extension_available(THEAD_VENDOR_ID, XTHEADV=
ECTOR) &&
> +           has_thead_homogeneous_vlenb() < 0) {
> +               pr_warn("Unsupported heterogeneous vlenb detected, vector=
 extension disabled.\n");
> +               disable_xtheadvector();
> +       }
> +
>         if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
>                 return -ENOENT;
>
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 682b3feee451..9775d6a9c8ee 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -33,7 +33,17 @@ int riscv_v_setup_vsize(void)
>  {
>         unsigned long this_vsize;
>
> -       /* There are 32 vector registers with vlenb length. */
> +       /*
> +        * There are 32 vector registers with vlenb length.
> +        *
> +        * If the thead,vlenb property was provided by the firmware, use =
that
> +        * instead of probing the CSRs.
> +        */
> +       if (thead_vlenb_of) {
> +               this_vsize =3D thead_vlenb_of * 32;
> +               return 0;
> +       }
> +
>         riscv_v_enable();
>         this_vsize =3D csr_read(CSR_VLENB) * 32;
>         riscv_v_disable();
> diff --git a/arch/riscv/kernel/vendor_extensions/thead.c b/arch/riscv/ker=
nel/vendor_extensions/thead.c
> index 0f27baf8d245..519dbf70710a 100644
> --- a/arch/riscv/kernel/vendor_extensions/thead.c
> +++ b/arch/riscv/kernel/vendor_extensions/thead.c
> @@ -5,6 +5,7 @@
>  #include <asm/vendor_extensions/thead.h>
>
>  #include <linux/array_size.h>
> +#include <linux/cpumask.h>
>  #include <linux/types.h>
>
>  /* All T-Head vendor extensions supported in Linux */
> @@ -16,3 +17,13 @@ struct riscv_isa_vendor_ext_data_list riscv_isa_vendor=
_ext_list_thead =3D {
>         .ext_data_count =3D ARRAY_SIZE(riscv_isa_vendor_ext_thead),
>         .ext_data =3D riscv_isa_vendor_ext_thead,
>  };
> +
> +void disable_xtheadvector(void)
> +{
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu)
> +               clear_bit(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, riscv_isa_ve=
ndor_ext_list_thead.per_hart_isa_bitmap[cpu].isa);
> +
> +       clear_bit(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, riscv_isa_vendor_ext=
_list_thead.all_harts_isa_bitmap.isa);
> +}

Given that we already have an infra to resolve and validate isa, with
riscv_resolve_isa(), shouldn't we reuse that part of the code and
assign "has_thead_homogeneous_vlenb()" as a validate function? I know
it would need some modifications because it seems like
riscv_resolve_isa is not there for vendor extensions yet.

Sorry I am late on reviewing this series. I think we can refactor it
as follow up patches if we want to keep up development.

Thanks,
Andy

