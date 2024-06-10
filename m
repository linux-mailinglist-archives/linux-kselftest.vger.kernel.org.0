Return-Path: <linux-kselftest+bounces-11584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3719027DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 19:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E1D1C21915
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F329C14EC73;
	Mon, 10 Jun 2024 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uadFo88C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305F14E2E3
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040998; cv=none; b=BPCHsKUMkcdCwQn8MxGymmPU1Ttc9KerO/Ja5REx99fnbsBjjJadafw4GMK4uMDG3RyVst7JjXL/+GHMWO38fAa7Gff/zfDm8LbQTCkJA0yuVz8DBJxL74wRWXJVf9f6jLerHW2rWje6M+0tkNaFf2gJ/Pe4XCJ1XBAoijYAI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040998; c=relaxed/simple;
	bh=MEux8hW1IzQP+vSFqvxXuRVrGvLzW+AOnKRudC/tFLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW1Ex2/5jHfh0brvux7P/OfzecUzu+METUVk66zBu3CVPW3EqkyDGw17u/ilkPUupv+QQj7n5GMuEdPena2+a+h8fJYgYtaVUwR8C3qmyE08kPwnCz9jw8+xkJGvGSI2vc9K31DkTWgJ413tgfBoLvpK4qRd1btadw3muTDzDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uadFo88C; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f7274a453bso870345ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 10:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718040996; x=1718645796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KXgZ3ggH8b+eYhTnO3zngpv+hfCwQEQd/vqBJQsKmFg=;
        b=uadFo88C9qjvF7LTv/HY3Rrr8GbuSIzl1mup9oWc1BfOXX1wdN2ZmFylVUrsFTZIWV
         hh5lmeFhn+2f/U8+hNcSlwFrvMAItDSpaT1M1IPfBmeh/TNd9XoXV5DSLaKDHJtZZnAY
         CKAl5mq1bA3RBVrX7ktEIMSX9r+2p1wySu1BQlw/I/kzbhcLjiPabomt0BXvuEBupPmU
         WxpYaRRWmNhEwlqhzNzCWi0K5+rpHLOcSwxyekogaCHftzF1dlu/2LtZcUyqtyM9gxRv
         t0yBH4BENhwxuQ47mALjjZjyOgsyFnL9SwshaiEY7Oc88q7Sv0784/scGCWiwGSjJPRE
         FrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718040996; x=1718645796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXgZ3ggH8b+eYhTnO3zngpv+hfCwQEQd/vqBJQsKmFg=;
        b=LTDRuvVF/t9VTUlLjA9hEvhnon7lzt52E7aTmIIEe/WUu9bDz/u2+dvYBshe//rN1X
         JkAH8SPzXcT0Byn7IGqNaKiW4ZsP/BQkBUxXBSreI/M7hke+P0e45eaQyfBP/wiBTEIq
         AFZRYwQ6BnXCMg2jmz6ObRpSlM42T0Az9ZLn4u0yT42H+1CbKWRg5I7qDyMF/yRIkGHS
         pDhpv5w6BLb369VIpeK8BTpGfvDzGuaKb3Y10dZ/PEjw4c5fEs1PCxZjrtDgiL7LVi7+
         lliRHXOO1ti6sZTa6wi8wj3CZX9Gu1wsJx9x5Ox2FMHuA42jSkogGtMqTSGpRF5jrfas
         5zlw==
X-Forwarded-Encrypted: i=1; AJvYcCV/s2VX3duHlekFvcMI60NzLwyCEsL0ntAtwBUSNLlgdkTBxkWlYy7Z7X/ahGAEQg7GtJF17VeCMa1bxYg2OeW0rKzSP0qxKgdy2QKXUoe4
X-Gm-Message-State: AOJu0YyJwdcZN9yamml0V1Sx7p6gf37ZiTjzLzvbMlofzwDjUdK3GLXV
	KhwpBHZSMiyODrudmXHFoOlJ/DOEoGaj4OPfUzBjvCPcud8knFh0XJPATvc/XiY=
X-Google-Smtp-Source: AGHT+IGkWzxznE9Jlab3s6h48WYrJSCUOQhos16Xu9eqWFR7iZZlKnSnnMYuh0c/JkqvN4t4SCD5ww==
X-Received: by 2002:a17:902:e544:b0:1f6:8157:b52f with SMTP id d9443c01a7336-1f6d02c068cmr122398615ad.8.1718040995983;
        Mon, 10 Jun 2024 10:36:35 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:129d:83bc:830b:8292])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f708e8a6f5sm30483415ad.209.2024.06.10.10.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 10:36:35 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:36:32 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 10/13] riscv: hwprobe: Add thead vendor extension probing
Message-ID: <Zmc5oH3qxQYaH6Nl@ghost>
References: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
 <20240609-xtheadvector-v1-10-3fe591d7f109@rivosinc.com>
 <CALs-HssK3p7yiOg1P_f+xw_b2kFtMX8wQRkM1-RMOTdsgh9zKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HssK3p7yiOg1P_f+xw_b2kFtMX8wQRkM1-RMOTdsgh9zKQ@mail.gmail.com>

On Mon, Jun 10, 2024 at 09:50:16AM -0700, Evan Green wrote:
> On Sun, Jun 9, 2024 at 9:45 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0" which
> > allows userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR
> > vendor extension.
> >
> > This new key will allow userspace code to probe for which thead vendor
> > extensions are supported. This API is modeled to be consistent with
> > RISCV_HWPROBE_KEY_IMA_EXT_0. The bitmask returned will have each bit
> > corresponding to a supported thead vendor extension of the cpumask set.
> > Just like RISCV_HWPROBE_KEY_IMA_EXT_0, this allows a userspace program
> > to determine all of the supported thead vendor extensions in one call.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Evan Green <evan@rivosinc.com>
> 
> You can continue to keep my tag, but I came up with some nits to pick anyway.
> 
> > ---
> >  arch/riscv/include/asm/hwprobe.h                   |  4 +--
> >  .../include/asm/vendor_extensions/thead_hwprobe.h  | 18 +++++++++++
> >  .../include/asm/vendor_extensions/vendor_hwprobe.h | 37 ++++++++++++++++++++++
> >  arch/riscv/include/uapi/asm/hwprobe.h              |  3 +-
> >  arch/riscv/include/uapi/asm/vendor/thead.h         |  3 ++
> >  arch/riscv/kernel/sys_hwprobe.c                    |  5 +++
> >  arch/riscv/kernel/vendor_extensions/Makefile       |  1 +
> >  .../riscv/kernel/vendor_extensions/thead_hwprobe.c | 19 +++++++++++
> >  8 files changed, 87 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> > index 630507dff5ea..e68496b4f8de 100644
> > --- a/arch/riscv/include/asm/hwprobe.h
> > +++ b/arch/riscv/include/asm/hwprobe.h
> > @@ -1,6 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> >  /*
> > - * Copyright 2023 Rivos, Inc
> > + * Copyright 2023-2024 Rivos, Inc
> >   */
> >
> >  #ifndef _ASM_HWPROBE_H
> > @@ -8,7 +8,7 @@
> >
> >  #include <uapi/asm/hwprobe.h>
> >
> > -#define RISCV_HWPROBE_MAX_KEY 6
> > +#define RISCV_HWPROBE_MAX_KEY 7
> >
> >  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> >  {
> > diff --git a/arch/riscv/include/asm/vendor_extensions/thead_hwprobe.h b/arch/riscv/include/asm/vendor_extensions/thead_hwprobe.h
> > new file mode 100644
> > index 000000000000..925fef39a2c0
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/vendor_extensions/thead_hwprobe.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_HWPROBE_H
> > +#define _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_HWPROBE_H
> > +
> > +#include <linux/cpumask.h>
> > +
> > +#include <uapi/asm/hwprobe.h>
> > +
> > +#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
> > +void hwprobe_isa_vendor_ext_thead_0(struct riscv_hwprobe *pair, const struct cpumask *cpus);
> > +#else
> > +static inline void hwprobe_isa_vendor_ext_thead_0(struct riscv_hwprobe *pair, const struct cpumask *cpus)
> > +{
> > +       pair->value = 0;
> > +}
> > +#endif
> > +
> > +#endif
> > diff --git a/arch/riscv/include/asm/vendor_extensions/vendor_hwprobe.h b/arch/riscv/include/asm/vendor_extensions/vendor_hwprobe.h
> > new file mode 100644
> > index 000000000000..b6222e7b519e
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/vendor_extensions/vendor_hwprobe.h
> > @@ -0,0 +1,37 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright 2024 Rivos, Inc
> > + */
> > +
> > +#ifndef _ASM_RISCV_SYS_HWPROBE_H
> > +#define _ASM_RISCV_SYS_HWPROBE_H
> > +
> > +#include <asm/cpufeature.h>
> > +
> > +#define EXT_KEY(ext)                                                                   \
> 
> Nit: Do you think it should be VENDOR_EXT_KEY? I had a slight ping of
> worry that the identifier sounds so generic it might conflict with
> something later, but meh maybe it's fine.

That's a good point, I will change.

> 
> 
> > +       do {                                                                            \
> > +               if (__riscv_isa_extension_available(isainfo->isa, RISCV_ISA_VENDOR_EXT_##ext)) \
> > +                       pair->value |= RISCV_HWPROBE_VENDOR_EXT_##ext;                  \
> > +               else                                                                    \
> > +                       missing |= RISCV_HWPROBE_VENDOR_EXT_##ext;                      \
> > +       } while (false)
> > +
> > +/*
> > + * Loop through and record extensions that 1) anyone has, and 2) anyone
> > + * doesn't have.
> > + *
> > + * _extension_checks is an arbitrary C block to set the values of pair->value
> > + * and missing. It should be filled with EXT_KEY expressions.
> > + */
> > +#define VENDOR_EXTENSION_SUPPORTED(pair, cpus, per_hart_thead_bitmap, _extension_checks)       \
> 
> Nit: This macro was meant to be generic for all vendors, but you've
> named one of the parameters per_hart_thead_bitmap. :)

Whoops, thank you!

- Charlie

> 
> > +       do {                                                                                    \
> > +               int cpu;                                                                        \
> > +               u64 missing;                                                                    \
> > +               for_each_cpu(cpu, (cpus)) {                                                     \
> > +                       struct riscv_isavendorinfo *isainfo = &(per_hart_thead_bitmap)[cpu];    \
> > +                       _extension_checks                                                       \
> > +               }                                                                               \
> > +               (pair)->value &= ~missing;                                                      \
> > +       } while (false)                                                                         \
> > +
> > +#endif /* _ASM_RISCV_SYS_HWPROBE_H */
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> > index dda76a05420b..155a83dd1cdf 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -1,6 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> >  /*
> > - * Copyright 2023 Rivos, Inc
> > + * Copyright 2023-2024 Rivos, Inc
> >   */
> >
> >  #ifndef _UAPI_ASM_HWPROBE_H
> > @@ -68,6 +68,7 @@ struct riscv_hwprobe {
> >  #define                RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    (4 << 0)
> >  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)
> >  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> > +#define RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0   7
> >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> >
> >  /* Flags */
> > diff --git a/arch/riscv/include/uapi/asm/vendor/thead.h b/arch/riscv/include/uapi/asm/vendor/thead.h
> > new file mode 100644
> > index 000000000000..43790ebe5faf
> > --- /dev/null
> > +++ b/arch/riscv/include/uapi/asm/vendor/thead.h
> > @@ -0,0 +1,3 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +
> > +#define                RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR   (1 << 0)
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > index 969ef3d59dbe..e39fa70083d3 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -13,6 +13,7 @@
> >  #include <asm/uaccess.h>
> >  #include <asm/unistd.h>
> >  #include <asm/vector.h>
> > +#include <asm/vendor_extensions/thead_hwprobe.h>
> >  #include <vdso/vsyscall.h>
> >
> >
> > @@ -217,6 +218,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> >                         pair->value = riscv_cboz_block_size;
> >                 break;
> >
> > +       case RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0:
> > +               hwprobe_isa_vendor_ext_thead_0(pair, cpus);
> > +               break;
> > +
> >         /*
> >          * For forward compatibility, unknown keys don't fail the whole
> >          * call, but get their element key set to -1 and value set to 0
> > diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/kernel/vendor_extensions/Makefile
> > index 353522cb3bf0..866414c81a9f 100644
> > --- a/arch/riscv/kernel/vendor_extensions/Makefile
> > +++ b/arch/riscv/kernel/vendor_extensions/Makefile
> > @@ -2,3 +2,4 @@
> >
> >  obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_ANDES)       += andes.o
> >  obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)       += thead.o
> > +obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)       += thead_hwprobe.o
> > diff --git a/arch/riscv/kernel/vendor_extensions/thead_hwprobe.c b/arch/riscv/kernel/vendor_extensions/thead_hwprobe.c
> > new file mode 100644
> > index 000000000000..53f65942f7e8
> > --- /dev/null
> > +++ b/arch/riscv/kernel/vendor_extensions/thead_hwprobe.c
> > @@ -0,0 +1,19 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <asm/vendor_extensions/thead.h>
> > +#include <asm/vendor_extensions/thead_hwprobe.h>
> > +#include <asm/vendor_extensions/vendor_hwprobe.h>
> > +
> > +#include <linux/cpumask.h>
> > +#include <linux/types.h>
> > +
> > +#include <uapi/asm/hwprobe.h>
> > +#include <uapi/asm/vendor/thead.h>
> > +
> > +void hwprobe_isa_vendor_ext_thead_0(struct riscv_hwprobe *pair, const struct cpumask *cpus)
> > +{
> > +       VENDOR_EXTENSION_SUPPORTED(pair, cpus,
> > +                                  riscv_isa_vendor_ext_list_thead.per_hart_isa_bitmap, {
> > +               EXT_KEY(XTHEADVECTOR);
> > +       });
> > +}
> >
> > --
> > 2.44.0
> >

