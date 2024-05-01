Return-Path: <linux-kselftest+bounces-9237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB18B9011
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 21:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4101F224C0
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 19:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418DD16132C;
	Wed,  1 May 2024 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ldwMNYUg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315B412FB21
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714591883; cv=none; b=ksKQBfxxJqjuOgedpCllE3bjlaDJwcTMYhtpGG/PgX+xK9XvMBvsKkP6MbdcYISaLn/Cyx0oVmHq+5tAzebShNVt9zYhDGh8mssGW1KaNGGs+Ek2gmQl9b2qvHb8bPqoGsmW6I++Ync3Zfd2fTfJLvPmvUxTTAA+GkaNwylQHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714591883; c=relaxed/simple;
	bh=4V4nOXAJK4lEKU8JJiUWuMjaMfSMrqSP/Y1lsJzv9Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhV/tFVq7inSdWFiyC73hioCusfODVpfaTt25HdU3z0j95HrRk9cJhmy4DVQzuMHPGZIfd/UraQmJlYAY8uxQHjQTscufos4MaSdtQoZ9p6sNZ5ykYom6A0MEhWbvHCYqh//Pr+viczVoZCwZYgYg4xGqPtDGBthhCxVHQpryFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ldwMNYUg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3c3aa8938so47247435ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714591879; x=1715196679; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yCUZ0lJZi4XrPs9F0orCitlVzShTGN4BIsUI0TAYPxE=;
        b=ldwMNYUgSs7H4c9TGKR+qfFgDhUhfLTyyjQVlrL7GT64BlKCY3LU4HO+7RhUlyEarR
         XbVJxjp6a0ekBb7WTR2FUG44YFjIiHS/Y8zKrqZ3Ze6k+CaqHAMuyWwVP8AAX6bBYVfS
         jJIo6VEvQcoTROIxNuEgxBk4PRiEOOvrrvXVdV5Kn3UTK1Y7dXkBmjcNn/mJhtJy6Weu
         dcfaCm4iaFsHuUIY+aXN+gTe8+N5prOOtrqzG9e84fkkcWNxUZrK/KxSVTtxBw1NAdUJ
         rLyNnEEmE7CLXV9BkBfNRfCxivPhlSX7SBMg/pDgx5g1BHGs0PvraZyCxMabOdA3IERZ
         OKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714591879; x=1715196679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCUZ0lJZi4XrPs9F0orCitlVzShTGN4BIsUI0TAYPxE=;
        b=pXPOracMuSh7mQdUInTvN0gaZNwrVO6nClcASoiuvjyAOvAt2dojGa//BoGqWWuFz8
         3q4PTfYcPWAcSfL5EVn+xYM4WMEtSX/0w9xSc2k2O9DkW7fPnqo3hZCc9vhc2CbWF0L4
         v7qmAx0mb6u8gM8AdAw0iy5LA6A+4lVYV/a0F0ayGmXY/SvUbcv7VAQhbj8PmTBOubn4
         rOK91E9hLBDj0WbhUOfbhLVWSOYpE9rL0+/aNlA9ET1CVSTHDR8yQgos4VTLI/OIaGjR
         jdKYD6Ri9hwX4p+isHZ2aXdOhVqSl7rz/2BXC1waaAg/SYgyVVu6pIiZOxu+IPQPvpzB
         VjPg==
X-Forwarded-Encrypted: i=1; AJvYcCXteAa8dcixOl22BW7y1fC+X2O0fYKs5bmiJOscPw1OaYv4gQTnPs9hfl3LWrtTwr5Vx4nWIA0cGQdlxZc55RXwcsORlf0DL1CQt3r/XJwh
X-Gm-Message-State: AOJu0Yx1o34QgRQJWNojczZ/tHIVBajwwJe3ZPVCLAq3md0fK8Mh+IYk
	HgPpsHOxIxTfmxFAXzKwdEf9W9obsCCelscXLIQiREWCFenbrSQ3i0g+3PzEp0s=
X-Google-Smtp-Source: AGHT+IF+r6LzNom8uhqtQWXEjd5uhhgWb7qm6I7GST1rhNDBMa9dUd0xMpP2FPO8ekUjklgZmgxoeQ==
X-Received: by 2002:a17:902:aa01:b0:1eb:49cb:bf70 with SMTP id be1-20020a170902aa0100b001eb49cbbf70mr3274061plb.62.1714591879439;
        Wed, 01 May 2024 12:31:19 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:1dcc:e03e:dc61:895d])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f7c400b001ec76a2303bsm2192009plw.175.2024.05.01.12.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:31:18 -0700 (PDT)
Date: Wed, 1 May 2024 12:31:15 -0700
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
Subject: Re: [PATCH v4 13/16] riscv: hwprobe: Add thead vendor extension
 probing
Message-ID: <ZjKYg0EGKq4nwSnp@ghost>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-5cf53b5bc492@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-13-5cf53b5bc492@rivosinc.com>
 <CALs-HsuPXhc93jqs==-Gq5Os701jxmzjxg82EHdOFHn+H-9Jdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HsuPXhc93jqs==-Gq5Os701jxmzjxg82EHdOFHn+H-9Jdg@mail.gmail.com>

On Wed, May 01, 2024 at 09:46:00AM -0700, Evan Green wrote:
> On Fri, Apr 26, 2024 at 2:37 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
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
> > ---
> >  arch/riscv/include/asm/hwprobe.h                   |  4 +--
> >  .../include/asm/vendor_extensions/thead_hwprobe.h  | 11 ++++++
> >  arch/riscv/include/uapi/asm/hwprobe.h              |  3 +-
> >  arch/riscv/include/uapi/asm/vendor/thead.h         |  3 ++
> >  arch/riscv/kernel/sys_hwprobe.c                    |  9 +++++
> >  arch/riscv/kernel/vendor_extensions/Makefile       |  1 +
> >  .../riscv/kernel/vendor_extensions/thead_hwprobe.c | 42 ++++++++++++++++++++++
> >  7 files changed, 70 insertions(+), 3 deletions(-)
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
> > index 000000000000..907cfc4eb4dc
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/vendor_extensions/thead_hwprobe.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_HWPROBE_H
> > +#define _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_HWPROBE_H
> > +
> > +#include <linux/cpumask.h>
> > +
> > +#include <uapi/asm/hwprobe.h>
> > +
> > +void hwprobe_isa_vendor_ext_thead_0(struct riscv_hwprobe *pair, const struct cpumask *cpus);
> > +
> > +#endif
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> > index 9f2a8e3ff204..21e96a63f9ea 100644
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
> > @@ -67,6 +67,7 @@ struct riscv_hwprobe {
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
> > index 8cae41a502dd..e59cac545df5 100644
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
> > @@ -216,6 +217,14 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> >                         pair->value = riscv_cboz_block_size;
> >                 break;
> >
> > +       case RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0:
> > +#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
> > +               hwprobe_isa_vendor_ext_thead_0(pair, cpus);
> > +#else
> > +               pair->value = 0;
> > +#endif
> 
> Could we move this ifdef into the header by declaring a dummy
> hwprobe_isa_vendor_ext_thead_0() in the header for the !ENABLED case?
> 
> > +               break;
> > +
> >         /*
> >          * For forward compatibility, unknown keys don't fail the whole
> >          * call, but get their element key set to -1 and value set to 0
> > diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/kernel/vendor_extensions/Makefile
> > index 8f1c5a4dc38f..f511fd269e8a 100644
> > --- a/arch/riscv/kernel/vendor_extensions/Makefile
> > +++ b/arch/riscv/kernel/vendor_extensions/Makefile
> > @@ -1,4 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >
> >  obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)       += thead.o
> > +obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)       += thead_hwprobe.o
> >  obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_ANDES)       += andes.o
> > diff --git a/arch/riscv/kernel/vendor_extensions/thead_hwprobe.c b/arch/riscv/kernel/vendor_extensions/thead_hwprobe.c
> > new file mode 100644
> > index 000000000000..e8e2de292032
> > --- /dev/null
> > +++ b/arch/riscv/kernel/vendor_extensions/thead_hwprobe.c
> > @@ -0,0 +1,42 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <asm/vector.h>
> > +#include <asm/vendor_extensions/thead.h>
> > +#include <asm/vendor_extensions/thead_hwprobe.h>
> > +
> > +#include <linux/cpumask.h>
> > +#include <linux/types.h>
> > +
> > +#include <uapi/asm/hwprobe.h>
> > +#include <uapi/asm/vendor/thead.h>
> > +
> > +void hwprobe_isa_vendor_ext_thead_0(struct riscv_hwprobe *pair, const struct cpumask *cpus)
> > +{
> > +       /*
> > +        * Loop through and record extensions that 1) anyone has, and 2) anyone
> > +        * doesn't have.
> > +        */
> > +
> > +       struct riscv_isainfo *per_hart_thead_bitmap = riscv_isa_vendor_ext_list_thead.per_hart_vendor_bitmap;
> > +       int cpu;
> > +       u64 missing;
> > +
> > +       for_each_cpu(cpu, cpus) {
> > +               struct riscv_isainfo *isainfo = &per_hart_thead_bitmap[cpu];
> > +
> > +#define EXT_KEY(ext)                                                                   \
> > +       do {                                                                            \
> > +               if (__riscv_isa_extension_available(isainfo->isa, RISCV_ISA_VENDOR_EXT_##ext)) \
> > +                       pair->value |= RISCV_HWPROBE_VENDOR_EXT_##ext;                  \
> > +               else                                                                    \
> > +                       missing |= RISCV_HWPROBE_VENDOR_EXT_##ext;                      \
> > +       } while (false)
> > +
> > +       EXT_KEY(XTHEADVECTOR);
> > +
> > +#undef EXT_KEY
> > +       }
> > +
> > +       /* Now turn off reporting features if any CPU is missing it. */> +       pair->value &= ~missing;
> > +}
> 
> Something to consider, perhaps when there's a second vendor, is how we
> might reduce this boilerplate on the second vendor. Probably best to
> wait though until we know exactly what the commonalities are. This
> looks good for now.
> 

Yes it should be mostly identical on second vendor. I think the only
difference would be "per_hart_thead_bitmap" and the list of extensions.
I can probably factor this out a bit.

- Charlie

> 
> >
> > --
> > 2.44.0
> >

