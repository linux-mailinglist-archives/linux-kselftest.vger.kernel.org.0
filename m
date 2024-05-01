Return-Path: <linux-kselftest+bounces-9241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C450B8B903A
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 21:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D491D1C20924
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB39C161909;
	Wed,  1 May 2024 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="a2GtUskW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59605161319
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593005; cv=none; b=W+GxjBeRQ1VS/I1i5gX9Dr0ke25QjzAjbL4vjQhu/V7sTXx30KbzGgf3EcFERiQ2jFx7WhdNkXwqKjUkYtYAbO99eXVoiSsJSC/i1+Srch9YPrdflf+3IRExZPZSXMWsubAYVgfo5Kln2jSJKVoSfnvxwtsgmMa0s2PIwPqNrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593005; c=relaxed/simple;
	bh=oyZJUusiRyA5GyxmKkv+S7LjsUCEF3Be29K5PtGNulE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7kY65ALtEUFuQ63xDOp6J2Zjorznqo6P5X6xp+Y9TO7f58MXVW0wOuUAZIFD0Kr0SrCHxNRWZ8gWuvLxavTbFzm3WiRBGYjMCZc+QX0zHgGmMNSielvKI9a/dRmxprpNA4wzi5ayJenFHbIEfExr7ZVs/z6wz0m658bsBbWpHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=a2GtUskW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec69e3dbe5so15600525ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714593004; x=1715197804; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kM7igPbGNIJ+0fwn0lbbaNAmJqgtIXaZke4GyfyWn/8=;
        b=a2GtUskWl+1Xd0ob4jUK/pqcjwpFrNKJmaFbGq61ibwBmlnQWMyiLwY/3bo69OsIum
         3HHM+/M0HK/SQobfDB26uVzi9yzj3rTq9PDh1EzF0SnvivugfxzkT30sr1y6QPfps1by
         w6sRK0wOWoNZHGPv+Wyiq+79NPx9L4c7YgjN4ztL6disbzRjtXtmC7P18irCV6PM4+Ob
         GNY0bAlvBrH6rSU9nxwgSJZ9pQV1WBxUY73ZcYK48MwG4aFvZjeyuMUVkcNKqZ8UqwEb
         RvIwO5RHjonc1FnoUvghE6cCPFqUvYIrEDi6sIujIjgHgPZiSt99yBDjNyCa6BmdYgh0
         fqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714593004; x=1715197804;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kM7igPbGNIJ+0fwn0lbbaNAmJqgtIXaZke4GyfyWn/8=;
        b=tnIP1IMzUScyK0yFaugwEDMZAjMakOQXARy24qg+B4FBnL9WdrMqB9q71jgNrvRifZ
         jlWoiir06Ta007ZKG0JgpsS4ZmgOF+DtSaoH1J3z3EUoiTwocUuwbeOT6zjUI/DqhLw1
         RR8NTucktYgl63jv73T9DEf+0drLl2NpNcMlgzD4siWkt2VGVE4cGT15w+9ff6i2q9u7
         RkGBlQ++/y1Z1vrafY8ZMPMTJpWIOoM/LQ7CueMyUbPgWnH3xPj01R+f1UItCeB35Kma
         lRlCf/iCpt/n4nYDSRuYip4OwS2QPxNs6MvBHeWLF5KxWl3NrI4l+QGduTEeT+87o25V
         rZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCV6i8lQVweXbflUSglSET5n8euZhNEKOlOaZPGhFIpkQKFnnJgAsL2K/dXi4NIJrt+1L+LoMpypytb8KykVSoOfRtLngRJyppixY61NCrc6
X-Gm-Message-State: AOJu0YzvQ6tDR/h8n8qowYo9L9iwBbrjYRJlI4G7RQZsfXIIhHDODiS2
	o//4qHK4HEhdwvF93ErrCRNH0qNXP1x5rvND0Bxv3prMLfuHOqCELtv/ZSrXwik=
X-Google-Smtp-Source: AGHT+IEM9fmEb38/w0za+GhL/Bs4gNsrL8TDtcaUQyFaus75t0OZHyuBFHHkotx6pRktXL7bXsD+Pw==
X-Received: by 2002:a17:902:7447:b0:1e9:668d:a446 with SMTP id e7-20020a170902744700b001e9668da446mr2993950plt.20.1714593003680;
        Wed, 01 May 2024 12:50:03 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:1dcc:e03e:dc61:895d])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902728a00b001ecd65e58d2sm220881pll.85.2024.05.01.12.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:50:03 -0700 (PDT)
Date: Wed, 1 May 2024 12:50:00 -0700
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
Message-ID: <ZjKc6I9vf5fYcQZe@ghost>
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

Whoops I didn't respond to this in my last message, this is a good idea,
thanks!

- Charlie

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
> 
> >
> > --
> > 2.44.0
> >

