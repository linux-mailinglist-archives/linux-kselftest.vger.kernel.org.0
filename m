Return-Path: <linux-kselftest+bounces-7866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9044A8A36F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 22:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE921C220EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 20:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F52714EC40;
	Fri, 12 Apr 2024 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QFRcz+Ed"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714521509B6
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953252; cv=none; b=XySp6fXN0Lky1Ali5Asw3TTNS9omi0uePNeNVKLlSwSQc6feH2LbdL0QcwJhpL5bMg+mDh3Y4iADG53RAQ6pHCI2/dIdI5evTVgj8eO8iNuXglvC/bPisa9jUgoxh2k8bBlc/68zkBqSluup0cHMNOjVbzo1AERibt0L2j8F4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953252; c=relaxed/simple;
	bh=rhC/i0iadwEL7dTRicBlO/h67qbFEWpJbLwK1NO3meo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMK26dixf9gNzoFOBnaFV8sRY0QgtcCJmPTobBeUO2xHNqiG2aNkZgCNaZsZgdCO0aeNyFn99bxvhEEx8ps19m26NGKYydricT43ImvVh4APypICkRvd0ZleOBdkAY5XyfXvgmae5rMrDf4Hvi1f+NH5lrLpc/9MjagIYvZhCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QFRcz+Ed; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36afd2f8388so5050445ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712953248; x=1713558048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G4g0asrIwIh0jCELCnJaY/AHU8getaccX1K08gj5vk8=;
        b=QFRcz+EdW4orrkGttpb70v1AenoRf5hHbOjSEzSneKf7kXobdukBi91dUhwTLxuePs
         Lw0XXYzTuFf8RuwoL5nmkUjVCDapsaN+kO46ln5g3arbyVQdpgdSzbo2V9w1ASqjh5AN
         NRqmvlxHn+UswtqMKQVxDFyyyYZtgXSu2j8p3sHkP+TZ4VDzg1IxEoYW5iFTYWyflOHo
         RzHN0YDsfT68erppBJG+3uGPHuxOUUkgjAzKhbAI4m5vrnOYz7vearMEtgtVS+QyuO8b
         CDqKQ1HWdQsvAiDECh+xvyMWc5A/D2eYMMjt9P+LTSmkieRSJfNEE5Z6S9vDJt9vuT5s
         17NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712953248; x=1713558048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4g0asrIwIh0jCELCnJaY/AHU8getaccX1K08gj5vk8=;
        b=Sz6RSQOs4kwA5evIZzsvIvvlAiX0skcc9WSQSAk+2mh58vPaRloiTgTn2VJnsc39Vf
         9fys1ulLqli1EpziINlzaktadskXoK+++/t1EtHQG1Pjw3jcYDvDvZS9oiIKiulZfWOI
         a9jds3xfALRCrkiTxmVOMVW/w9cKY34XMu0BvvLVq7TN90IRrujMSLz6uEcEH7y37p5K
         NhQJ2UeRo0PIhk1PI2xOqQQ5TR0w/x6t0dFjqmZQFvzTbQM6wErs0vRyMrOSn4RMB5X8
         0cUuy8UQAIaWkzxLmbKnVP2kVjGbjBZ/pq8EmtAJCtxm8d7r4qfEoux+wEyjP/W09XPH
         qqpg==
X-Forwarded-Encrypted: i=1; AJvYcCVtl1xU/5kXSbGBEjvF9gfHoY2s0zBAENsSk+6X7rv/Zm8/Gxojc2/P4Au5nabMKi2TgsI/Hy27DIsEtXylYvNu8j15Ueu+DgFF39QRyVOX
X-Gm-Message-State: AOJu0YyQNfMXd+l27o1dogncMzMXCdCHudjljBr+KJ49P7RaIQ8MHnZ9
	SryoICYYmiv90iUQ8Cm3znQVsa7C7C4xwIKLZrRKssSmiH6KnWS+UkaFumtSRNw=
X-Google-Smtp-Source: AGHT+IFpjh0cclgh6ATH3N1bYJeehFia9hHxmNB9H0B6FBqe3hOIKZovvCJzuOOC0WQ06VxvLw7Jfw==
X-Received: by 2002:a05:6e02:20e5:b0:36a:daf:533f with SMTP id q5-20020a056e0220e500b0036a0daf533fmr4183114ilv.0.1712953248485;
        Fri, 12 Apr 2024 13:20:48 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id f13-20020a63100d000000b005f41aeec262sm3127345pgl.44.2024.04.12.13.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:20:47 -0700 (PDT)
Date: Fri, 12 Apr 2024 13:20:45 -0700
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
Message-ID: <ZhmXnUj2B1hD5QiX@ghost>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-16-4af9815ec746@rivosinc.com>
 <CALs-Hss=vuNgq-8bVL1DOR431qFpn-D13yFGn6yf_2saZO0FVQ@mail.gmail.com>
 <Zhl6lvZzUrCoAB8N@ghost>
 <CALs-Hsu=SLnTJ+gsGZmv7C=K8WGHRiFCn3Q=isE9+QhawcrqCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-Hsu=SLnTJ+gsGZmv7C=K8WGHRiFCn3Q=isE9+QhawcrqCw@mail.gmail.com>

On Fri, Apr 12, 2024 at 12:07:46PM -0700, Evan Green wrote:
> On Fri, Apr 12, 2024 at 11:17 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Fri, Apr 12, 2024 at 10:05:21AM -0700, Evan Green wrote:
> > > On Thu, Apr 11, 2024 at 9:12 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > >
> > > > Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_0" which allows
> > > > userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR vendor
> > > > extension.
> > > >
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > ---
> > > >  arch/riscv/include/asm/hwprobe.h      |  4 +--
> > > >  arch/riscv/include/uapi/asm/hwprobe.h | 10 +++++-
> > > >  arch/riscv/kernel/sys_hwprobe.c       | 59 +++++++++++++++++++++++++++++++++--
> > > >  3 files changed, 68 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> > > > index 630507dff5ea..e68496b4f8de 100644
> > > > --- a/arch/riscv/include/asm/hwprobe.h
> > > > +++ b/arch/riscv/include/asm/hwprobe.h
> > > > @@ -1,6 +1,6 @@
> > > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > >  /*
> > > > - * Copyright 2023 Rivos, Inc
> > > > + * Copyright 2023-2024 Rivos, Inc
> > > >   */
> > > >
> > > >  #ifndef _ASM_HWPROBE_H
> > > > @@ -8,7 +8,7 @@
> > > >
> > > >  #include <uapi/asm/hwprobe.h>
> > > >
> > > > -#define RISCV_HWPROBE_MAX_KEY 6
> > > > +#define RISCV_HWPROBE_MAX_KEY 7
> > > >
> > > >  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> > > >  {
> > > > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> > > > index 9f2a8e3ff204..6614d3adfc75 100644
> > > > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > > > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > > > @@ -1,6 +1,6 @@
> > > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > >  /*
> > > > - * Copyright 2023 Rivos, Inc
> > > > + * Copyright 2023-2024 Rivos, Inc
> > > >   */
> > > >
> > > >  #ifndef _UAPI_ASM_HWPROBE_H
> > > > @@ -67,6 +67,14 @@ struct riscv_hwprobe {
> > > >  #define                RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    (4 << 0)
> > > >  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)
> > > >  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> > > > +/*
> > > > + * It is not possible for one CPU to have multiple vendor ids, so each vendor
> > > > + * has its own vendor extension "namespace". The keys for each vendor starts
> > > > + * at zero.
> > > > + */
> > > > +#define RISCV_HWPROBE_KEY_VENDOR_EXT_0 7
> > > > + /* T-Head */
> > > > +#define                RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR   (1 << 0)
> > > >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> > > >
> > > >  /* Flags */
> > > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > > > index e0a42c851511..365ce7380443 100644
> > > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > > @@ -69,7 +69,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> > > >         if (riscv_isa_extension_available(NULL, c))
> > > >                 pair->value |= RISCV_HWPROBE_IMA_C;
> > > >
> > > > -       if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR))
> > > > +       if (has_vector() &&
> > > > +           !__riscv_isa_vendor_extension_available(NULL, RISCV_ISA_VENDOR_EXT_XTHEADVECTOR))
> > > >                 pair->value |= RISCV_HWPROBE_IMA_V;
> > > >
> > > >         /*
> > > > @@ -112,7 +113,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> > > >                 EXT_KEY(ZACAS);
> > > >                 EXT_KEY(ZICOND);
> > > >
> > > > -               if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> > > > +               if (has_vector() &&
> > > > +                   !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> > > >                         EXT_KEY(ZVBB);
> > > >                         EXT_KEY(ZVBC);
> > > >                         EXT_KEY(ZVKB);
> > > > @@ -139,6 +141,55 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> > > >         pair->value &= ~missing;
> > > >  }
> > > >
> > > > +static void hwprobe_isa_vendor_ext0(struct riscv_hwprobe *pair,
> > > > +                                   const struct cpumask *cpus)
> > > > +{
> > > > +       int cpu;
> > > > +       u64 missing = 0;
> > > > +
> > > > +       pair->value = 0;
> > > > +
> > > > +       struct riscv_hwprobe mvendorid = {
> > > > +               .key = RISCV_HWPROBE_KEY_MVENDORID,
> > > > +               .value = 0
> > > > +       };
> > > > +
> > > > +       hwprobe_arch_id(&mvendorid, cpus);
> > > > +
> > > > +       /* Set value to zero if CPUs in the set do not have the same vendor. */
> > > > +       if (mvendorid.value == -1ULL)
> > > > +               return;
> > > > +
> > > > +       /*
> > > > +        * Loop through and record vendor extensions that 1) anyone has, and
> > > > +        * 2) anyone doesn't have.
> > > > +        */
> > > > +       for_each_cpu(cpu, cpus) {
> > > > +               struct riscv_isainfo *isavendorinfo = &hart_isa_vendor[cpu];
> > > > +
> > > > +#define VENDOR_EXT_KEY(ext)                                                            \
> > > > +       do {                                                                            \
> > > > +               if (__riscv_isa_vendor_extension_available(isavendorinfo->isa,          \
> > > > +                                                        RISCV_ISA_VENDOR_EXT_##ext))   \
> > > > +                       pair->value |= RISCV_HWPROBE_VENDOR_EXT_##ext;                  \
> > > > +               else                                                                    \
> > > > +                       missing |= RISCV_HWPROBE_VENDOR_EXT_##ext;                      \
> > > > +       } while (false)
> > > > +
> > > > +       /*
> > > > +        * Only use VENDOR_EXT_KEY() for extensions which can be exposed to userspace,
> > > > +        * regardless of the kernel's configuration, as no other checks, besides
> > > > +        * presence in the hart_vendor_isa bitmap, are made.
> > > > +        */
> > > > +       VENDOR_EXT_KEY(XTHEADVECTOR);
> > > > +
> > > > +#undef VENDOR_EXT_KEY
> > >
> > > Hey Charlie,
> > > Thanks for writing this up! At the very least I think the
> > > THEAD-specific stuff should probably end up in its own file, otherwise
> > > it'll get chaotic with vendors clamoring to add stuff right here.
> >
> > Great idea!
> >
> > > What do you think about this approach:
> > >  * We leave RISCV_HWPROBE_MAX_KEY as the max key for the "generic
> > > world", eg 6-ish
> > >  * We define that any key above 0x8000000000000000 is in the vendor
> > > space, so the meaning of the keys depends first on the mvendorid
> > > value.
> > >  * In the kernel code, each new vendor adds on to a global struct,
> > > which might look something like:
> > > struct hwprobe_vendor_space vendor_space[] = {
> > >         {
> > >                 .mvendorid = VENDOR_THEAD,
> > >                 .max_hwprobe_key = THEAD_MAX_HWPROBE_KEY, // currently
> > > 1 or 0x8000000000000001 with what you've got.
> > >                 .hwprobe_fn = thead_hwprobe
> > >         },
> > >         ...
> > > };
> > >
> > >  * A hwprobe_thead.c implements thead_hwprobe(), and is called
> > > whenever the generic hwprobe encounters a key >=0x8000000000000000.
> > >  * Generic code for setting up the VDSO can then still call the
> > > vendor-specific hwprobe_fn() repeatedly with an "all CPUs" mask from
> > > the base to max_hwprobe_key and set up the cached tables in userspace.
> > >  * Since the VDSO data has limited space we may have to cap the number
> > > of vendor keys we cache to be lower than max_hwprobe_key. Since the
> > > data itself is not exposed to usermode we can raise this cap later if
> > > needed.
> >
> > I know vendor extensions are kind of the "wild west" of riscv, but in
> > spite of that I want to design a consistent API. The issue I had with
> > having this "vendor space" for exposing vendor extensions was that this
> > is something that is inherently the same for all vendors. I see a vendor
> > space like this more applicable for something like
> > "RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE" where a vendor has a specific
> > value they would like to expose. I do agree that having a vendor space
> > is a good design choice, but I am not convinced that vendor extensions
> > are the proper use-case.
> >
> > By having RISCV_HWPROBE_KEY_VENDOR_EXT_0 we can expose the vendor
> > extensions in the same way that standard extensions are exposed, with a
> > bitmask representing each extension. If these are instead in the vendor
> > space, each vendor would probably be inclined to introduce a key like
> > RISCV_HWPROBE_KEY_THEAD_EXT_0 that returns a bitmask of all of the thead
> > vendor extensions. This duplicated effort is what I am trying to avoid.
> > The alternative would be that vendors have a separate key for each
> > vendor extension they would like to expose, but that is strictly less
> > efficient than the existing bitmask probing.
> >
> > Do you think that having the vendor space is appropriate for vendor
> > extensions given my concerns?
> 
> I do see what you're going for. It's tidy for a bitmask to just let
> anyone allocate the next bit, but leaves you with the same problem
> when a vendor decides they want to expose an enum, or decides they
> want to expose a bazillion things. I think a generalized version of

This patch is strictly to expose if a vendor extension is supported,
how does exposing enums factor in here?

> the approach you've written would be: simply let vendors allocate keys
> from the same global space we're already using. My worry was that it

I am missing how my proposal suggests allowing vendors to allocate keys
in a global space.

> would turn into an expansive suburban sprawl of mostly dead bits, or
> in the case of vendor-specific keys, full of "if (mvendor_id() !=
> MINE) return 0;". My hope with the vendored keyspace is it would keep

An application will always need to check vendorid before calling hwprobe
with a vendor-specific feature? If that hwprobe support is a key above
1<<63, then the application will need to pass that vendor-specific key
and interpret the vendor-specific value. If that hwprobe support is what
I have proposed here, then the user calls the standardized vendor
extension hwprobe endpoint and then needs to interpret the result based
on the vendor of the cpumask. In both cases they need to check the
vendorid of the cpumask. In the test case I added I failed to check the
vendorid but I should have had that.

> the sprawl from polluting the general array of (hopefully valuable)
> info with stuff that's likely to become less relevant as time passes.
> It also lowers the bar a bit to make it easier for vendors to expose
> bits, as they don't consume global space for everyone for all of time,
> just themselves.

The vendor keys are tied directly to the vendor. So as it grows we would
have something like:

#define RISCV_HWPROBE_KEY_VENDOR_EXT_0	7
/* T-Head */
#define		RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR	(1 << 0)
#define		RISCV_HWPROBE_VENDOR_EXT_XTHEAD2	(2 << 0)
#define		RISCV_HWPROBE_VENDOR_EXT_XTHEAD3	(3 << 0)
/* Vendor 2 */
#define		RISCV_HWPROBE_VENDOR_EXT_XVENDOR1	(1 << 0)
#define		RISCV_HWPROBE_VENDOR_EXT_XVENDOR2	(2 << 0)
/* Vendor 3 */
...

The keys overlap between vendors. To determine which extension a vendor
supports, hwprobe gets data from hart_isa_vendor[cpu]. If the vendor is
vendor 2, it is not possible for a vendor extension from vendor 3 to end
up in there. Only the extensions from that vendor can be supported by
that vendor's hardware. 

> 
> So yes, personally I'm still in the camp of siloing the vendor stuff
> off to its own area.

I don't quite see how what I have proposed doesn't "silo" the extensions
that pertain to each vendor since the keys are specific to each vendor.

- Charlie

> -Evan


