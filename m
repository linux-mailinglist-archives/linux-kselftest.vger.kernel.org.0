Return-Path: <linux-kselftest+bounces-13439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFE092CBAE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 09:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68A0282B9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 07:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AB48172D;
	Wed, 10 Jul 2024 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTmO8E+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701F823C3;
	Wed, 10 Jul 2024 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595500; cv=none; b=MwYEVQ9oM2jyd0Nv2sGtdiozSAi1aLlEVmvX2GxqHHVA8H5K57+buHE+pOR91WYO78xTsT5EHlB/diGZVUfbPYSj8C/Jkr03JGnue9t5HNlKrUkqqFtjkes5y7duuHQ5lQoHexGvby5P+b58SvUD+/UJkTR2mwisDL6A4QQa9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595500; c=relaxed/simple;
	bh=yRGnsgGlGwr5grPehw5y2cKQYkE2B7D3quzhosQ5QRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaIa4fHSNdkZBRs46sq4oV/nnA2mKr190gF9er7Spdh8OYPhEnpOIOY18ifx84t5V0WBCwA4AYEQAbb631c2nLj/VwmXaZ5VivO/vaNhGSIcSAFTseacwILd1DKDWT9WfkrqYJx6LIkhsnz0PJ1nbhykig8H1kjo7Nrg/olW5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTmO8E+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD7BC4AF12;
	Wed, 10 Jul 2024 07:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720595500;
	bh=yRGnsgGlGwr5grPehw5y2cKQYkE2B7D3quzhosQ5QRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HTmO8E+F8eose52/VnA/B0vmpjX9ymccYf6jHURxa/cwWqbcKY1pwUBErJriDAWxL
	 ccuTwsM8pBwWhlEU1jsC9Lno19lIKOuuO8ckSAzbmSsCDbWLDLjHp5dvGp0T08pyw2
	 CSihJe+CRobM4xiHozvntm+D9urrj1SXB33cE2PCNkAqMh0kBI8mKm8FJtKP8+i7eh
	 DyR76B1Llvo5yz1tr55Rq02lmpLR32C+tIkGMQh7fliPvQ2/NwMsHOD9kNAsggJvQM
	 g19lhnGDGyiVX5GQ53AR4vpKVCZ2X6pr36iiSR+OqDV6974ETZqew55iwT5lhI4OmC
	 ftY/AO2RszF5Q==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77c349bb81so538597566b.3;
        Wed, 10 Jul 2024 00:11:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjeBTPPeQGOVcdqZHoM71ISnluEV2t9/nbe11apDBMJ1NdBOQ2lmy/edk2O7fI55lH/fbaHw3ve2du36PhbsgyF5ubDalqaGZHTjZ9Uj86WJVPsZgYWO2HqggO7YU3lyl0VBcK5wQkcXK1k033XsWix1lemoEKeo7yQowCge3Y2wroMgw2rVmHzYtxrV8VVPZYYcDQXA5GGmo0hkqyYiy6SVyxPQ==
X-Gm-Message-State: AOJu0YxJ5yPePFDv0JQ8EJQjKFUMzuDHrefGXP30/fQqzn4ZFqvySwUt
	Wu522K3d5QiPZiN4KBNQ2eAvaOot3I8N3szlvIkvXI41XnGzK60ELtHhcwRJCB66ZGvj+ivb5dT
	AS7bBv6gfKpbqzncT8HQIAcW3ZNk=
X-Google-Smtp-Source: AGHT+IFW/4IhCaqk+cMkQ0EHa+zFblHpkhI9EPOEKdDUo/9mDGAR8HGdktmPIDk+sr/xPlO+uLv+eef+gW+ddkeQnWc=
X-Received: by 2002:a17:907:20f1:b0:a75:25ff:550d with SMTP id
 a640c23a62f3a-a780b6b361cmr259682466b.26.1720595498854; Wed, 10 Jul 2024
 00:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com> <20240619-xtheadvector-v3-5-bff39eb9668e@rivosinc.com>
In-Reply-To: <20240619-xtheadvector-v3-5-bff39eb9668e@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 10 Jul 2024 15:11:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQdjDouYTC9+kq-TdXhQch50p121yq8mTwXsGd6g_TSVA@mail.gmail.com>
Message-ID: <CAJF2gTQdjDouYTC9+kq-TdXhQch50p121yq8mTwXsGd6g_TSVA@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] riscv: vector: Use vlenb from DT for thead
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Evan Green <evan@rivosinc.com>, 
	Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 7:57=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> If thead,vlenb is provided in the device tree, prefer that over reading
> the vlenb csr.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig.vendor           | 13 ++++++++++
>  arch/riscv/include/asm/cpufeature.h |  2 ++
>  arch/riscv/kernel/cpufeature.c      | 48 +++++++++++++++++++++++++++++++=
++++++
>  arch/riscv/kernel/vector.c          | 12 +++++++++-
>  4 files changed, 74 insertions(+), 1 deletion(-)
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
> index b029ca72cebc..e0a3164c7a06 100644
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
>  #define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size)=
 {     \
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 2107c59575dd..077be4ab1f9a 100644
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
> @@ -625,6 +627,46 @@ static void __init riscv_fill_vendor_ext_list(int cp=
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
> @@ -689,6 +731,12 @@ static int __init riscv_fill_hwcap_from_ext_list(uns=
igned long *isa2hwcap)
>                 riscv_fill_vendor_ext_list(cpu);
>         }
>
> +       if (riscv_isa_vendor_extension_available(THEAD_VENDOR_ID, XTHEADV=
ECTOR) &&
> +           has_thead_homogeneous_vlenb() < 0) {
> +               pr_warn("Unsupported heterogeneous vlenb detected, vector=
 extension disabled.\n");
> +               elf_hwcap &=3D ~COMPAT_HWCAP_ISA_V;
> +       }
> +
XTHEADVECTOR is 0.7.1 for old XuanTie processors; we only have
homogeneous vlenb=3D128 chips.

So:

Acked-by: Guo Ren <guoren@kernel.org>

>         if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
>                 return -ENOENT;
>
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 6727d1d3b8f2..3ba2f2432483 100644
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
>
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren

