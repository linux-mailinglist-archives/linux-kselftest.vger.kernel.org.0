Return-Path: <linux-kselftest+bounces-7851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5404A8A357A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 20:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4562856E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC0114E2F4;
	Fri, 12 Apr 2024 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mKj82HQ5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C9114E2DA
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945824; cv=none; b=SdBeCJWekkVvK/LdFX0VTlaSlmFCukLF/XNs+rVRzq/gJwe7dcUtB07fbNfdrDlwkVhRccVtAvVONqPxkevam110XJ3m6yXxbjTQp8rJTFTh7S/yIMchoZb+tZVZ7oQpYp2yJw3xR78BrOg7q3hSFyw0S3w8hq1VbToJZIHQtfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945824; c=relaxed/simple;
	bh=/MGnUUIFV/PfbJzx4J6fZpaWxaKzHgtnIopUoSjHKuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msoDgHl0J03qv+Iroprp5b2wZHOd9hgnSojzV2+i2bHjQFlJaPTKDxB0J7wA2/xi/He3foiEmXEXIUrzICcoZKA9D/ozXFWJxTfTJwH5ghNY+KRrkxc3FiApmlbZ1aTQleZ3W+FKlocivkUDJ8o4BbhHuIt9AoYaUc4diPsPQos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mKj82HQ5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ead4093f85so1052316b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712945822; x=1713550622; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fwRQcSH3hoRqkz4lFFtuwqCwddU8BwqxVywbCJRklZ0=;
        b=mKj82HQ5l2LxWX9PjeQnzoHJfW4ypXE+8m1/kKRG6p985cZlzvOImli4V9B/V/DLuq
         hvPYVZK60Ldb0okn66pCvxpEde/9aYDHhXataXpndBwg94VTrDbZBElM6jXpWSGAcaLk
         /W6kTmp+d31v08y90dDCoAS5F9QALEKVQtHC03Cqwfc7vSxSVDWaooNXDOno1QErCnNb
         vJjtkOHtYM8OZ0Xbf0hLR+pKufr5NuAQzKS+omNAdZSqBMVOy6qDwnESdWfp2YEcLuJc
         EA8i+VHDBRP784WxB6lR2VGh24ZRzF+wfwdPpY/kv3lTs+Sb2LJgzQS3lBiYRWlqN+Vp
         tJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712945822; x=1713550622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwRQcSH3hoRqkz4lFFtuwqCwddU8BwqxVywbCJRklZ0=;
        b=qwQkAQwi0bbIqbZtG7JDqV2wpFZ3xHH6KQTj5TDNewYQLPTWiFcrjB49tWOz7YI6Xe
         Nuozc6wxzqOBFkVfAKIcPC0r+FduMHe8zX3YggHsTOpgrPS670Av6J09nnMci7zsMzwX
         SnDExNZrCt1nI/aKp+OZ7y3yXLVthXG7pjwzCkEIQbykixjHux7dzfdHg12GqzvaQCcB
         FhbF/1rDxFGVrgraxT8SMLVK0auZ9bYaZOo9Ft9l/3rVbVu4dupJ95k/+rVzWb//hwXl
         uwSikmsTq2pLHLlEhwby7g2+MQo1jD21L3iHZfBwRL9rbcN99myQlaPAlZLPMxLj8Evs
         Fdow==
X-Forwarded-Encrypted: i=1; AJvYcCXkyRuvvts6oRLOwyYFFdx+5OYrWsqlA72Yeww3WBhuQgEU9SpW6ld49KD3QsE5Mu3qnOfVaznQYfEjg3v0/tRyoHcnLFH8LGeaSTMouPSE
X-Gm-Message-State: AOJu0YzDLzgZDmzRTTnl6J7fL4YZMuor4ASgBMvHE5xA6A0NB6XaI2h4
	E0ASQzosGUKw6Eno6gCYGKx0iHeIQkrMd9oZqEgOVcG6UamzbhoqexlAJKIAoj4=
X-Google-Smtp-Source: AGHT+IEAA1SdXJJ9JaBE0uNqu1IjKHNyvp0QURZDSkRyrJGkvMsb68Cr5A+LNkkLoKuuki78cgNyYA==
X-Received: by 2002:a05:6a20:9c90:b0:1a9:c757:a22d with SMTP id mj16-20020a056a209c9000b001a9c757a22dmr336085pzb.14.1712945821769;
        Fri, 12 Apr 2024 11:17:01 -0700 (PDT)
Received: from ghost (mobile-166-137-160-039.mycingular.net. [166.137.160.39])
        by smtp.gmail.com with ESMTPSA id d3-20020a056a00198300b006e6c6a50e5esm3162896pfl.34.2024.04.12.11.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:17:01 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:16:54 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 16/19] riscv: hwprobe: Add vendor extension probing
Message-ID: <Zhl6lvZzUrCoAB8N@ghost>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-16-4af9815ec746@rivosinc.com>
 <CALs-Hss=vuNgq-8bVL1DOR431qFpn-D13yFGn6yf_2saZO0FVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-Hss=vuNgq-8bVL1DOR431qFpn-D13yFGn6yf_2saZO0FVQ@mail.gmail.com>

On Fri, Apr 12, 2024 at 10:05:21AM -0700, Evan Green wrote:
> On Thu, Apr 11, 2024 at 9:12 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_0" which allows
> > userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR vendor
> > extension.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/hwprobe.h      |  4 +--
> >  arch/riscv/include/uapi/asm/hwprobe.h | 10 +++++-
> >  arch/riscv/kernel/sys_hwprobe.c       | 59 +++++++++++++++++++++++++++++++++--
> >  3 files changed, 68 insertions(+), 5 deletions(-)
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
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> > index 9f2a8e3ff204..6614d3adfc75 100644
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
> > @@ -67,6 +67,14 @@ struct riscv_hwprobe {
> >  #define                RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    (4 << 0)
> >  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)
> >  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> > +/*
> > + * It is not possible for one CPU to have multiple vendor ids, so each vendor
> > + * has its own vendor extension "namespace". The keys for each vendor starts
> > + * at zero.
> > + */
> > +#define RISCV_HWPROBE_KEY_VENDOR_EXT_0 7
> > + /* T-Head */
> > +#define                RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR   (1 << 0)
> >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> >
> >  /* Flags */
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > index e0a42c851511..365ce7380443 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -69,7 +69,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> >         if (riscv_isa_extension_available(NULL, c))
> >                 pair->value |= RISCV_HWPROBE_IMA_C;
> >
> > -       if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR))
> > +       if (has_vector() &&
> > +           !__riscv_isa_vendor_extension_available(NULL, RISCV_ISA_VENDOR_EXT_XTHEADVECTOR))
> >                 pair->value |= RISCV_HWPROBE_IMA_V;
> >
> >         /*
> > @@ -112,7 +113,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> >                 EXT_KEY(ZACAS);
> >                 EXT_KEY(ZICOND);
> >
> > -               if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> > +               if (has_vector() &&
> > +                   !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> >                         EXT_KEY(ZVBB);
> >                         EXT_KEY(ZVBC);
> >                         EXT_KEY(ZVKB);
> > @@ -139,6 +141,55 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> >         pair->value &= ~missing;
> >  }
> >
> > +static void hwprobe_isa_vendor_ext0(struct riscv_hwprobe *pair,
> > +                                   const struct cpumask *cpus)
> > +{
> > +       int cpu;
> > +       u64 missing = 0;
> > +
> > +       pair->value = 0;
> > +
> > +       struct riscv_hwprobe mvendorid = {
> > +               .key = RISCV_HWPROBE_KEY_MVENDORID,
> > +               .value = 0
> > +       };
> > +
> > +       hwprobe_arch_id(&mvendorid, cpus);
> > +
> > +       /* Set value to zero if CPUs in the set do not have the same vendor. */
> > +       if (mvendorid.value == -1ULL)
> > +               return;
> > +
> > +       /*
> > +        * Loop through and record vendor extensions that 1) anyone has, and
> > +        * 2) anyone doesn't have.
> > +        */
> > +       for_each_cpu(cpu, cpus) {
> > +               struct riscv_isainfo *isavendorinfo = &hart_isa_vendor[cpu];
> > +
> > +#define VENDOR_EXT_KEY(ext)                                                            \
> > +       do {                                                                            \
> > +               if (__riscv_isa_vendor_extension_available(isavendorinfo->isa,          \
> > +                                                        RISCV_ISA_VENDOR_EXT_##ext))   \
> > +                       pair->value |= RISCV_HWPROBE_VENDOR_EXT_##ext;                  \
> > +               else                                                                    \
> > +                       missing |= RISCV_HWPROBE_VENDOR_EXT_##ext;                      \
> > +       } while (false)
> > +
> > +       /*
> > +        * Only use VENDOR_EXT_KEY() for extensions which can be exposed to userspace,
> > +        * regardless of the kernel's configuration, as no other checks, besides
> > +        * presence in the hart_vendor_isa bitmap, are made.
> > +        */
> > +       VENDOR_EXT_KEY(XTHEADVECTOR);
> > +
> > +#undef VENDOR_EXT_KEY
> 
> Hey Charlie,
> Thanks for writing this up! At the very least I think the
> THEAD-specific stuff should probably end up in its own file, otherwise
> it'll get chaotic with vendors clamoring to add stuff right here.

Great idea!

> What do you think about this approach:
>  * We leave RISCV_HWPROBE_MAX_KEY as the max key for the "generic
> world", eg 6-ish
>  * We define that any key above 0x8000000000000000 is in the vendor
> space, so the meaning of the keys depends first on the mvendorid
> value.
>  * In the kernel code, each new vendor adds on to a global struct,
> which might look something like:
> struct hwprobe_vendor_space vendor_space[] = {
>         {
>                 .mvendorid = VENDOR_THEAD,
>                 .max_hwprobe_key = THEAD_MAX_HWPROBE_KEY, // currently
> 1 or 0x8000000000000001 with what you've got.
>                 .hwprobe_fn = thead_hwprobe
>         },
>         ...
> };
> 
>  * A hwprobe_thead.c implements thead_hwprobe(), and is called
> whenever the generic hwprobe encounters a key >=0x8000000000000000.
>  * Generic code for setting up the VDSO can then still call the
> vendor-specific hwprobe_fn() repeatedly with an "all CPUs" mask from
> the base to max_hwprobe_key and set up the cached tables in userspace.
>  * Since the VDSO data has limited space we may have to cap the number
> of vendor keys we cache to be lower than max_hwprobe_key. Since the
> data itself is not exposed to usermode we can raise this cap later if
> needed.

I know vendor extensions are kind of the "wild west" of riscv, but in
spite of that I want to design a consistent API. The issue I had with
having this "vendor space" for exposing vendor extensions was that this
is something that is inherently the same for all vendors. I see a vendor
space like this more applicable for something like
"RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE" where a vendor has a specific
value they would like to expose. I do agree that having a vendor space
is a good design choice, but I am not convinced that vendor extensions
are the proper use-case.

By having RISCV_HWPROBE_KEY_VENDOR_EXT_0 we can expose the vendor
extensions in the same way that standard extensions are exposed, with a
bitmask representing each extension. If these are instead in the vendor
space, each vendor would probably be inclined to introduce a key like
RISCV_HWPROBE_KEY_THEAD_EXT_0 that returns a bitmask of all of the thead
vendor extensions. This duplicated effort is what I am trying to avoid.
The alternative would be that vendors have a separate key for each
vendor extension they would like to expose, but that is strictly less
efficient than the existing bitmask probing.

Do you think that having the vendor space is appropriate for vendor
extensions given my concerns?

- Charlie

> 
> 
> -Evan
> 
> > +       }
> > +
> > +       /* Now turn off reporting features if any CPU is missing it. */
> > +       pair->value &= ~missing;
> > +}
> > +
> >  static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
> >  {
> >         struct riscv_hwprobe pair;
> > @@ -216,6 +267,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> >                         pair->value = riscv_cboz_block_size;
> >                 break;
> >
> > +       case RISCV_HWPROBE_KEY_VENDOR_EXT_0:
> > +               hwprobe_isa_vendor_ext0(pair, cpus);
> > +               break;
> > +
> >         /*
> >          * For forward compatibility, unknown keys don't fail the whole
> >          * call, but get their element key set to -1 and value set to 0
> >
> > --
> > 2.44.0
> >

