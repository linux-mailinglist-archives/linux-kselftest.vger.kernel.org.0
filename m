Return-Path: <linux-kselftest+bounces-7833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB85C8A3459
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE8F1C23038
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7037614D6F5;
	Fri, 12 Apr 2024 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WxJt3yaj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC514D2AA
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941561; cv=none; b=M+zolwSEEL5F992jrbyYxnH1U/6TpL7I6nrb3az5qep2J73sfM0xiXLUXJKJcmeeHDL67eIJzPz5Wdvx3F2nWEf6kK/pem11I6t81MwXD54cC61yPlLs0J87DojmVvXaiji/l/YyWVgs2jtwihlJkOUlYhpFoEJG4UNKYONSiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941561; c=relaxed/simple;
	bh=j3u4Pfc/DXRoTLtIqFpIe/08sKRybrTTrcMzZ99pca4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRMya2s7f4eB6vkRh1dctC+YsUBT4GIy5hEQri8fvEzGJa1SB9O+nx/SvgRKYWh6JP3/3AW6JNS9YO7Az5Rvg31KHRkpQ28D/9O4cR2KLobGCqlN3Q0rogROW1oqdDV9TLi5uykGgSyKwkmUAWui/U98s7LQ4phkXPl5i40wLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WxJt3yaj; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d715638540so12986391fa.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 10:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712941558; x=1713546358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vu6rgY+yqOGOmOLw32t5d3GS611sOvqhECdZtjPZOA=;
        b=WxJt3yajC3VWoWICwC0AiS1S8yKAce2dlQd3xqDY7gNy+H8lzoMqZgSJOXiDcwcBvz
         WlUH60ecRuw39M1oleeVGzYZ5DVCsGRNO0hKaL/6jzwLPJVKsQEXjv4myrhwK9WfDdfC
         ohR2g+E0grqq5yy19rGWdq6xPZ1n0p9CH0xMMX8mN1NyR10VZijRiovoC44xfLLDYz3z
         HqtnOg7vHVok7wKHrE0jGrjtAb9it1K95uKkMQFMR33cl8KJLVVevv+xGNDk1FJDq6ah
         rh3HWbE2lqyOCtynXaNIPLiG4WyRu0S21YPyD+gql44hqPMp/U6mcf/IGP1N31ankdUA
         YFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941558; x=1713546358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Vu6rgY+yqOGOmOLw32t5d3GS611sOvqhECdZtjPZOA=;
        b=oQOAmv4HYxDMJNzCQDSTj6AjxUp+hPFqDmOttTkzlWGCNHcb8bvyxufFzAn3rhdPXs
         5nBaFlgl7Aepp0SJigo4mM9z9olR9euIsPGcSctxdHor1gBgUFq3Rx00tWZFcCxxY94Y
         x86bADkNV5+nuu1KpWVxhxPLiT/fqsbzQMlap//ywDM7dX2dUxgMFXDi2MGNoijq1wHx
         aj0dYWLx/yGxHEeaVRPq5uGpLimmzkq+dwil++MHDRH8dGCczyWYPjCmXTHTq9aufYM1
         9LxBIGGHWvCU59Rspcv7EQI+QgG5Ptc6cwOqVQ/L421t0G6li7JsMKYBHkQVL11sjPcl
         JeBw==
X-Forwarded-Encrypted: i=1; AJvYcCUgBsR+zvm1hrddd7JXvLL3N8kJsJavOkfMnjl6sK2XEYAzJD6PoloVawO5QV4NCQ5KuSnE5I6a6QXsHelb96wcvNrJzQwAy4zMNz3C8qDq
X-Gm-Message-State: AOJu0Yz+OKr8I57T7InROg12OVtNIVsiHHWfg79pnJvKna9f4YTXTsvi
	bzkUrpWKP+Xckr9wg6FgXgEAHv5rBwn9UHnSScvXpySUFea3YeRPgapTiVAZN5Y7vjOGG4R1D2/
	CB8AKfHY6JCHdqcmSWdFFoqE8/E8ted6meRmurA==
X-Google-Smtp-Source: AGHT+IFYpm5VEIsLiYtOAsbNkvaiNNs0hgQdNZZaIKndtEvsgJfqKFi9pXG7Zi0EdKs2kJFE7fs5OvqkFRBwjf5hH7M=
X-Received: by 2002:a2e:be04:0:b0:2d8:da4c:5909 with SMTP id
 z4-20020a2ebe04000000b002d8da4c5909mr2118700ljq.51.1712941557792; Fri, 12 Apr
 2024 10:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-16-4af9815ec746@rivosinc.com>
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-16-4af9815ec746@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 12 Apr 2024 10:05:21 -0700
Message-ID: <CALs-Hss=vuNgq-8bVL1DOR431qFpn-D13yFGn6yf_2saZO0FVQ@mail.gmail.com>
Subject: Re: [PATCH 16/19] riscv: hwprobe: Add vendor extension probing
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 9:12=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_0" which allows
> userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR vendor
> extension.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/hwprobe.h      |  4 +--
>  arch/riscv/include/uapi/asm/hwprobe.h | 10 +++++-
>  arch/riscv/kernel/sys_hwprobe.c       | 59 +++++++++++++++++++++++++++++=
++++--
>  3 files changed, 68 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hw=
probe.h
> index 630507dff5ea..e68496b4f8de 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>  /*
> - * Copyright 2023 Rivos, Inc
> + * Copyright 2023-2024 Rivos, Inc
>   */
>
>  #ifndef _ASM_HWPROBE_H
> @@ -8,7 +8,7 @@
>
>  #include <uapi/asm/hwprobe.h>
>
> -#define RISCV_HWPROBE_MAX_KEY 6
> +#define RISCV_HWPROBE_MAX_KEY 7
>
>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>  {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index 9f2a8e3ff204..6614d3adfc75 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>  /*
> - * Copyright 2023 Rivos, Inc
> + * Copyright 2023-2024 Rivos, Inc
>   */
>
>  #ifndef _UAPI_ASM_HWPROBE_H
> @@ -67,6 +67,14 @@ struct riscv_hwprobe {
>  #define                RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    (4 << 0)
>  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> +/*
> + * It is not possible for one CPU to have multiple vendor ids, so each v=
endor
> + * has its own vendor extension "namespace". The keys for each vendor st=
arts
> + * at zero.
> + */
> +#define RISCV_HWPROBE_KEY_VENDOR_EXT_0 7
> + /* T-Head */
> +#define                RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR   (1 << 0)
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>
>  /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index e0a42c851511..365ce7380443 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -69,7 +69,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair=
,
>         if (riscv_isa_extension_available(NULL, c))
>                 pair->value |=3D RISCV_HWPROBE_IMA_C;
>
> -       if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_IS=
A_VENDOR_EXT_XTHEADVECTOR))
> +       if (has_vector() &&
> +           !__riscv_isa_vendor_extension_available(NULL, RISCV_ISA_VENDO=
R_EXT_XTHEADVECTOR))
>                 pair->value |=3D RISCV_HWPROBE_IMA_V;
>
>         /*
> @@ -112,7 +113,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pa=
ir,
>                 EXT_KEY(ZACAS);
>                 EXT_KEY(ZICOND);
>
> -               if (has_vector() && !riscv_has_vendor_extension_unlikely(=
RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> +               if (has_vector() &&
> +                   !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR=
_EXT_XTHEADVECTOR)) {
>                         EXT_KEY(ZVBB);
>                         EXT_KEY(ZVBC);
>                         EXT_KEY(ZVKB);
> @@ -139,6 +141,55 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *p=
air,
>         pair->value &=3D ~missing;
>  }
>
> +static void hwprobe_isa_vendor_ext0(struct riscv_hwprobe *pair,
> +                                   const struct cpumask *cpus)
> +{
> +       int cpu;
> +       u64 missing =3D 0;
> +
> +       pair->value =3D 0;
> +
> +       struct riscv_hwprobe mvendorid =3D {
> +               .key =3D RISCV_HWPROBE_KEY_MVENDORID,
> +               .value =3D 0
> +       };
> +
> +       hwprobe_arch_id(&mvendorid, cpus);
> +
> +       /* Set value to zero if CPUs in the set do not have the same vend=
or. */
> +       if (mvendorid.value =3D=3D -1ULL)
> +               return;
> +
> +       /*
> +        * Loop through and record vendor extensions that 1) anyone has, =
and
> +        * 2) anyone doesn't have.
> +        */
> +       for_each_cpu(cpu, cpus) {
> +               struct riscv_isainfo *isavendorinfo =3D &hart_isa_vendor[=
cpu];
> +
> +#define VENDOR_EXT_KEY(ext)                                             =
               \
> +       do {                                                             =
               \
> +               if (__riscv_isa_vendor_extension_available(isavendorinfo-=
>isa,          \
> +                                                        RISCV_ISA_VENDOR=
_EXT_##ext))   \
> +                       pair->value |=3D RISCV_HWPROBE_VENDOR_EXT_##ext; =
                 \
> +               else                                                     =
               \
> +                       missing |=3D RISCV_HWPROBE_VENDOR_EXT_##ext;     =
                 \
> +       } while (false)
> +
> +       /*
> +        * Only use VENDOR_EXT_KEY() for extensions which can be exposed =
to userspace,
> +        * regardless of the kernel's configuration, as no other checks, =
besides
> +        * presence in the hart_vendor_isa bitmap, are made.
> +        */
> +       VENDOR_EXT_KEY(XTHEADVECTOR);
> +
> +#undef VENDOR_EXT_KEY

Hey Charlie,
Thanks for writing this up! At the very least I think the
THEAD-specific stuff should probably end up in its own file, otherwise
it'll get chaotic with vendors clamoring to add stuff right here.
What do you think about this approach:
 * We leave RISCV_HWPROBE_MAX_KEY as the max key for the "generic
world", eg 6-ish
 * We define that any key above 0x8000000000000000 is in the vendor
space, so the meaning of the keys depends first on the mvendorid
value.
 * In the kernel code, each new vendor adds on to a global struct,
which might look something like:
struct hwprobe_vendor_space vendor_space[] =3D {
        {
                .mvendorid =3D VENDOR_THEAD,
                .max_hwprobe_key =3D THEAD_MAX_HWPROBE_KEY, // currently
1 or 0x8000000000000001 with what you've got.
                .hwprobe_fn =3D thead_hwprobe
        },
        ...
};

 * A hwprobe_thead.c implements thead_hwprobe(), and is called
whenever the generic hwprobe encounters a key >=3D0x8000000000000000.
 * Generic code for setting up the VDSO can then still call the
vendor-specific hwprobe_fn() repeatedly with an "all CPUs" mask from
the base to max_hwprobe_key and set up the cached tables in userspace.
 * Since the VDSO data has limited space we may have to cap the number
of vendor keys we cache to be lower than max_hwprobe_key. Since the
data itself is not exposed to usermode we can raise this cap later if
needed.


-Evan

> +       }
> +
> +       /* Now turn off reporting features if any CPU is missing it. */
> +       pair->value &=3D ~missing;
> +}
> +
>  static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long e=
xt)
>  {
>         struct riscv_hwprobe pair;
> @@ -216,6 +267,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *p=
air,
>                         pair->value =3D riscv_cboz_block_size;
>                 break;
>
> +       case RISCV_HWPROBE_KEY_VENDOR_EXT_0:
> +               hwprobe_isa_vendor_ext0(pair, cpus);
> +               break;
> +
>         /*
>          * For forward compatibility, unknown keys don't fail the whole
>          * call, but get their element key set to -1 and value set to 0
>
> --
> 2.44.0
>

