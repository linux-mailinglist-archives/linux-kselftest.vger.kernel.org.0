Return-Path: <linux-kselftest+bounces-8905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AB08B321D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 10:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF111C21625
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9570B13C9AF;
	Fri, 26 Apr 2024 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8BJ/5Su"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547BE1E885;
	Fri, 26 Apr 2024 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119339; cv=none; b=EOsW5Wcyd07day8nWD/cG5glZU15QOu+gXnqZtu7LSz9c65FKSUyFeqLiu+wcA9xMbQjiUU1Ns9NVkZzoyL8KMuUgwMqc+687AtAexVUhdNW7yKJhpNh6bnJRUx7lMDwA3p5i6BLJ+kXzB1LHXOECM5RV+4UD+B7jC7ymJQcRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119339; c=relaxed/simple;
	bh=1yC+gB+RH39a11ZICGlu8ThPKI65Pnf3tzMu4N3kPwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6PyBXqNw32aZlJDj2UmiaUo05RYg6YidFN3zOWjFSsMM13zSRNwIqWRX632+CbIWCkV11OamtJ56eAYW86rfAkxG3z+lnOLgw1R267yzSUljHse1PCd4FTrTx/uuV6TjuFZGVkmotvRVcfhlcBYwwfH1TvsaukaI8wRAYjupFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8BJ/5Su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD633C4AF08;
	Fri, 26 Apr 2024 08:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714119338;
	bh=1yC+gB+RH39a11ZICGlu8ThPKI65Pnf3tzMu4N3kPwg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a8BJ/5SucEzuTdrZqKCG21lvJi6LtydPBKHQyO2DEukgWJy5HlA/UJSlxqazfk/43
	 U6am5yWh6X1UqC5Q6dcn4wxluaIrZyify2W50hZ2XOf7vEwsvqufhDZcSR2eC9KLXe
	 959zTu6qscNiUWLet+jJaLJ9b9OFKhs5F9pmGt5OVz8OVPr3j+gfcEQF9uYlJLQeSs
	 CG7a2XjGU5p8751sD7i0M5uxo993BU3sqOcaVePnrqvXXn7EPKXL+uRUmvUu9kJoE3
	 M5MpXo+WR/+VyaBwYNvw3/+o7+qQSvjx9hrAAvq4l0/U8Yr+CMjvQtd5/NkC7SpPj8
	 IbauGQRZVS/PQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5725cfa2434so81436a12.2;
        Fri, 26 Apr 2024 01:15:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2peKlD0BC4adYUoDwIM3tyMv8l9DagYNfbJA/6yMsbheCAdhxV05rnNG3D47qBGmZDJw//AFqTPe2vsdkf2ogNLM78Hab8VLjV+lkRKOvzWm5BG6QUJRJHTYzqVHiiypCw7rikajLnOxg0aX8rONeTmjC/f0BfOKBc9AVFJwSqKrX4UU7nvcLwF//L7iwJS7mccGTt/WMhcYVDS1pVfLTStg1fg==
X-Gm-Message-State: AOJu0YwGYQkBGiTU6qJCtNGn1Smb2Xjjwc21Se9MFmSzi0aHfKOPHwDt
	WiqYt/i02t7CsxWy4nU5NpbK8TYHgN5xhxTYf1k0axBoAjygVVKbvbu8rY3E7VpJGFEnfYC95LM
	Vpf5BhDCaSMlT0WRPoKGqmG1vYck=
X-Google-Smtp-Source: AGHT+IFdWL+1rtvTdjZLYM58Wr/hUAPW6s+thTjch0dqfysVmrhP+T23KFGnV1/pBKaELJeFZArRbXJifhaQCJxXF9c=
X-Received: by 2002:a50:99c7:0:b0:572:3f41:25aa with SMTP id
 n7-20020a5099c7000000b005723f4125aamr1644329edb.11.1714119337224; Fri, 26 Apr
 2024 01:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
 <20240420-dev-charlie-support_thead_vector_6_9-v3-1-67cff4271d1d@rivosinc.com>
In-Reply-To: <20240420-dev-charlie-support_thead_vector_6_9-v3-1-67cff4271d1d@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 26 Apr 2024 16:15:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTeGBuL4S3cKV87w-TJTa+ZmOaPiT=+uor-PzL9jYTWAg@mail.gmail.com>
Message-ID: <CAJF2gTTeGBuL4S3cKV87w-TJTa+ZmOaPiT=+uor-PzL9jYTWAg@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] riscv: cpufeature: Fix thead vector hwcap removal
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Evan Green <evan@rivosinc.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 9:04=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> The riscv_cpuinfo struct that contains mvendorid and marchid is not
> populated until all harts are booted which happens after the DT parsing.
> Use the vendorid/archid values from the DT if available or assume all
> harts have the same values as the boot hart as a fallback.
>
> Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property on =
older T-Head CPUs")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/sbi.h   |  2 ++
>  arch/riscv/kernel/cpu.c        | 40 ++++++++++++++++++++++++++++++++++++=
----
>  arch/riscv/kernel/cpufeature.c | 12 ++++++++++--
>  3 files changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 6e68f8dff76b..0fab508a65b3 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -370,6 +370,8 @@ static inline int sbi_remote_fence_i(const struct cpu=
mask *cpu_mask) { return -1
>  static inline void sbi_init(void) {}
>  #endif /* CONFIG_RISCV_SBI */
>
> +unsigned long riscv_get_mvendorid(void);
> +unsigned long riscv_get_marchid(void);
>  unsigned long riscv_cached_mvendorid(unsigned int cpu_id);
>  unsigned long riscv_cached_marchid(unsigned int cpu_id);
>  unsigned long riscv_cached_mimpid(unsigned int cpu_id);
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index d11d6320fb0d..c1f3655238fd 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -139,6 +139,34 @@ int riscv_of_parent_hartid(struct device_node *node,=
 unsigned long *hartid)
>         return -1;
>  }
>
> +unsigned long __init riscv_get_marchid(void)
> +{
> +       struct riscv_cpuinfo *ci =3D this_cpu_ptr(&riscv_cpuinfo);
> +
> +#if IS_ENABLED(CONFIG_RISCV_SBI)
> +       ci->marchid =3D sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> +       ci->marchid =3D csr_read(CSR_MARCHID);
> +#else
> +       ci->marchid =3D 0;
> +#endif
> +       return ci->marchid;
> +}
> +
> +unsigned long __init riscv_get_mvendorid(void)
> +{
> +       struct riscv_cpuinfo *ci =3D this_cpu_ptr(&riscv_cpuinfo);
> +
> +#if IS_ENABLED(CONFIG_RISCV_SBI)
> +       ci->mvendorid =3D sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> +       ci->mvendorid =3D csr_read(CSR_MVENDORID);
> +#else
> +       ci->mvendorid =3D 0;
> +#endif
> +       return ci->mvendorid;
> +}
> +
>  DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>
>  unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
> @@ -170,12 +198,16 @@ static int riscv_cpuinfo_starting(unsigned int cpu)
>         struct riscv_cpuinfo *ci =3D this_cpu_ptr(&riscv_cpuinfo);
>
>  #if IS_ENABLED(CONFIG_RISCV_SBI)
> -       ci->mvendorid =3D sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> -       ci->marchid =3D sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> +       if (!ci->mvendorid)
> +               ci->mvendorid =3D sbi_spec_is_0_1() ? 0 : sbi_get_mvendor=
id();
> +       if (!ci->marchid)
> +               ci->marchid =3D sbi_spec_is_0_1() ? 0 : sbi_get_marchid()=
;
>         ci->mimpid =3D sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
>  #elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> -       ci->mvendorid =3D csr_read(CSR_MVENDORID);
> -       ci->marchid =3D csr_read(CSR_MARCHID);
> +       if (!ci->mvendorid)
> +               ci->mvendorid =3D csr_read(CSR_MVENDORID);
> +       if (!ci->marchid)
> +               ci->marchid =3D csr_read(CSR_MARCHID);
>         ci->mimpid =3D csr_read(CSR_MIMPID);
>  #else
>         ci->mvendorid =3D 0;
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 3ed2359eae35..c6e27b45e192 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -490,6 +490,8 @@ static void __init riscv_fill_hwcap_from_isa_string(u=
nsigned long *isa2hwcap)
>         struct acpi_table_header *rhct;
>         acpi_status status;
>         unsigned int cpu;
> +       u64 boot_vendorid;
> +       u64 boot_archid;
>
>         if (!acpi_disabled) {
>                 status =3D acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> @@ -497,6 +499,13 @@ static void __init riscv_fill_hwcap_from_isa_string(=
unsigned long *isa2hwcap)
>                         return;
>         }
>
> +       /*
> +        * Naively assume that all harts have the same mvendorid/marchid =
as the
> +        * boot hart.
> +        */
> +       boot_vendorid =3D riscv_get_mvendorid();
> +       boot_archid =3D riscv_get_marchid();
> +
>         for_each_possible_cpu(cpu) {
>                 struct riscv_isainfo *isainfo =3D &hart_isa[cpu];
>                 unsigned long this_hwcap =3D 0;
> @@ -544,8 +553,7 @@ static void __init riscv_fill_hwcap_from_isa_string(u=
nsigned long *isa2hwcap)
>                  * CPU cores with the ratified spec will contain non-zero
>                  * marchid.
>                  */
> -               if (acpi_disabled && riscv_cached_mvendorid(cpu) =3D=3D T=
HEAD_VENDOR_ID &&
> -                   riscv_cached_marchid(cpu) =3D=3D 0x0) {
> +               if (acpi_disabled && boot_vendorid =3D=3D THEAD_VENDOR_ID=
 && boot_archid =3D=3D 0x0) {
LGTM!
Reviewed-by: Guo Ren <guoren@kernel.org>

>                         this_hwcap &=3D ~isa2hwcap[RISCV_ISA_EXT_v];
>                         clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
>                 }
>
> --
> 2.44.0
>


--=20
Best Regards
 Guo Ren

