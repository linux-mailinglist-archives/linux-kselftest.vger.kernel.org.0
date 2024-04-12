Return-Path: <linux-kselftest+bounces-7886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0358A38D3
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251A61F2351E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 23:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305FC152516;
	Fri, 12 Apr 2024 23:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="k1pGz0pO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8DA152196
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712963531; cv=none; b=ElgqVM/PA8G2iijAElNnU+K1g02MjelvHDYe+J17qiBp662O4LCQU80VHNj+mZTu3f7P+a9xpGNLkMTz1ei4HNLv7KdLtkMa8MBu79tdsgGUbgZc7gWuqfUTnHg3vOO6z6tAi4Xj23UoDraHUiL0E6r294n3bcIQrhJ+BPYxi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712963531; c=relaxed/simple;
	bh=6eD6soiH6MUPGUd8I4Mvj85EeM2plyQ/Tb+rZ1+4kHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJc5KfLwLFmVuECq6zG2m9N9SuancAYW2hW8UD6IVOzYFdeCkkUeA09ktlnD6tKW2IDKQ1+f9cmCWj2mrmP/dTHBo2xiBePDDB4DdHr4nAYa/3cuB28Us3c52P32OB8qUv/jlrWpxzI+/EOsbjv3r60YGR80OStLhVN7VS9tYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=k1pGz0pO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ef9bd94d81so298038b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 16:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712963528; x=1713568328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1caGThvMfvJPzIUlHYiufetvZDoAxWNNIAzMtHKofHU=;
        b=k1pGz0pOR6hfUW4VGMyQkMRYj6dwrypaJ/356xKak9QyiKr2Z+9yRyW+DIiC4ymOew
         941/BhtDZDdgRbfE8hR7iRJjLKUP6xlIV30xo7ns+aL6hXUeDhBoAzUrPYUgz4CH2rWZ
         ihxW6MzVfIjcrqRlbqfLr/Vi1iBVPig9QGALEDPsgbEp6F0sDIDDU9x5ZqrbDI3q4Rf1
         eLdDlDP/P1rPN0TBATENFRjZSd873hrqXf/FGXsFqxjeByq6xEd9yiChK8kd2XrMr0A3
         t5IJSjJsXuS2cpD3Qlh0hVvfMinS8m1gV4K90miFgjVGZwDQz3d2tiJ7vu06qPPkiAL/
         SxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712963528; x=1713568328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1caGThvMfvJPzIUlHYiufetvZDoAxWNNIAzMtHKofHU=;
        b=tICr085aXmenWATC1pHL8cMEIdKf9Anp4bBmIokotWs5DeteQ0lWjegQnNJMxugbco
         QUlNYoMuZhsHncyRGUbe8gqzpCFrMFVBj+O0Vt+amNjUW24MRGpuHo5OZ9hXBEVFpY/U
         GRdLL7EM3VNfNLFdibNxfgElUuJULKttYrBBA9ooy9BetKdw/6ODse9+GGW/umcoxbxw
         HNNx9UZ+D9iKCLTemCDF1OIySl+DsBrl9PhE3Bfhf17SOmUFYCsEjEw/nZFT8BZfj76c
         pJplOztG5FA5U99AJLjmahFWHYcHHfHXEqmV3QTrwZHK4V0f8LZhoLUmrKdLe1ux1I7Y
         sWbw==
X-Forwarded-Encrypted: i=1; AJvYcCXsKK867ZULMbGyICnB9UQVUhO0ENq+++SC0CV2O97eQfzTTyneNbYtZCbZ98UhG95MSShaKnrR55ZF3RGUaXna1/j9GFdthT2V1GW27wc1
X-Gm-Message-State: AOJu0YxG0vnqaZguOAtgyYPgoo4WQAJkL3hFIkz9IiMBsJPHfWEEThLt
	GIN5I8bKBDPwba5NXndBDDC8+ioFppdnZtB7e3o22XF4qL8VZRpfSydaSoYM64Y=
X-Google-Smtp-Source: AGHT+IHRSKv1KFWQfNLPwdryry6UpW3xo9x3BUUWYGDGKVu4lSSBw5AToNYIatXs3aj0DmNbqezqMw==
X-Received: by 2002:a05:6a00:cd3:b0:6ed:2f52:9acd with SMTP id b19-20020a056a000cd300b006ed2f529acdmr5187064pfv.24.1712963527557;
        Fri, 12 Apr 2024 16:12:07 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id c21-20020a62e815000000b006ed0199bd57sm3494303pfi.177.2024.04.12.16.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 16:12:06 -0700 (PDT)
Date: Fri, 12 Apr 2024 16:12:04 -0700
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
Message-ID: <Zhm/xFBcRqSDxId+@ghost>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-16-4af9815ec746@rivosinc.com>
 <CALs-Hss=vuNgq-8bVL1DOR431qFpn-D13yFGn6yf_2saZO0FVQ@mail.gmail.com>
 <Zhl6lvZzUrCoAB8N@ghost>
 <CALs-Hsu=SLnTJ+gsGZmv7C=K8WGHRiFCn3Q=isE9+QhawcrqCw@mail.gmail.com>
 <ZhmXnUj2B1hD5QiX@ghost>
 <CALs-Hsu4m0y2zSvpZwn2znyxNMfJ5f0NpYOh9TNYB4u5=GUKxw@mail.gmail.com>
 <Zhmzzq3oedZ1LozW@ghost>
 <CALs-HssuhXr-mRui7KujqAwCU-=O+udrJ4cp-be=sFbCL0ADrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HssuhXr-mRui7KujqAwCU-=O+udrJ4cp-be=sFbCL0ADrA@mail.gmail.com>

On Fri, Apr 12, 2024 at 03:50:05PM -0700, Evan Green wrote:
> On Fri, Apr 12, 2024 at 3:21 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Fri, Apr 12, 2024 at 02:43:01PM -0700, Evan Green wrote:
> > > On Fri, Apr 12, 2024 at 1:20 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > >
> > > > On Fri, Apr 12, 2024 at 12:07:46PM -0700, Evan Green wrote:
> > > > > On Fri, Apr 12, 2024 at 11:17 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 12, 2024 at 10:05:21AM -0700, Evan Green wrote:
> > > > > > > On Thu, Apr 11, 2024 at 9:12 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > > > > >
> > > > > > > > Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_0" which allows
> > > > > > > > userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR vendor
> > > > > > > > extension.
> > > > > > > >
> > > > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > > > ---
> > > > > > > >  arch/riscv/include/asm/hwprobe.h      |  4 +--
> > > > > > > >  arch/riscv/include/uapi/asm/hwprobe.h | 10 +++++-
> > > > > > > >  arch/riscv/kernel/sys_hwprobe.c       | 59 +++++++++++++++++++++++++++++++++--
> > > > > > > >  3 files changed, 68 insertions(+), 5 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> > > > > > > > index 630507dff5ea..e68496b4f8de 100644
> > > > > > > > --- a/arch/riscv/include/asm/hwprobe.h
> > > > > > > > +++ b/arch/riscv/include/asm/hwprobe.h
> > > > > > > > @@ -1,6 +1,6 @@
> > > > > > > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > > > > >  /*
> > > > > > > > - * Copyright 2023 Rivos, Inc
> > > > > > > > + * Copyright 2023-2024 Rivos, Inc
> > > > > > > >   */
> > > > > > > >
> > > > > > > >  #ifndef _ASM_HWPROBE_H
> > > > > > > > @@ -8,7 +8,7 @@
> > > > > > > >
> > > > > > > >  #include <uapi/asm/hwprobe.h>
> > > > > > > >
> > > > > > > > -#define RISCV_HWPROBE_MAX_KEY 6
> > > > > > > > +#define RISCV_HWPROBE_MAX_KEY 7
> > > > > > > >
> > > > > > > >  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> > > > > > > >  {
> > > > > > > > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> > > > > > > > index 9f2a8e3ff204..6614d3adfc75 100644
> > > > > > > > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > > > > > > > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > > > > > > > @@ -1,6 +1,6 @@
> > > > > > > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > > > > >  /*
> > > > > > > > - * Copyright 2023 Rivos, Inc
> > > > > > > > + * Copyright 2023-2024 Rivos, Inc
> > > > > > > >   */
> > > > > > > >
> > > > > > > >  #ifndef _UAPI_ASM_HWPROBE_H
> > > > > > > > @@ -67,6 +67,14 @@ struct riscv_hwprobe {
> > > > > > > >  #define                RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    (4 << 0)
> > > > > > > >  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)
> > > > > > > >  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> > > > > > > > +/*
> > > > > > > > + * It is not possible for one CPU to have multiple vendor ids, so each vendor
> > > > > > > > + * has its own vendor extension "namespace". The keys for each vendor starts
> > > > > > > > + * at zero.
> > > > > > > > + */
> > > > > > > > +#define RISCV_HWPROBE_KEY_VENDOR_EXT_0 7
> > > > > > > > + /* T-Head */
> > > > > > > > +#define                RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR   (1 << 0)
> > > > > > > >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> > > > > > > >
> > > > > > > >  /* Flags */
> > > > > > > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > > > > > > > index e0a42c851511..365ce7380443 100644
> > > > > > > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > > > > > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > > > > > > @@ -69,7 +69,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> > > > > > > >         if (riscv_isa_extension_available(NULL, c))
> > > > > > > >                 pair->value |= RISCV_HWPROBE_IMA_C;
> > > > > > > >
> > > > > > > > -       if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR))
> > > > > > > > +       if (has_vector() &&
> > > > > > > > +           !__riscv_isa_vendor_extension_available(NULL, RISCV_ISA_VENDOR_EXT_XTHEADVECTOR))
> > > > > > > >                 pair->value |= RISCV_HWPROBE_IMA_V;
> > > > > > > >
> > > > > > > >         /*
> > > > > > > > @@ -112,7 +113,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> > > > > > > >                 EXT_KEY(ZACAS);
> > > > > > > >                 EXT_KEY(ZICOND);
> > > > > > > >
> > > > > > > > -               if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> > > > > > > > +               if (has_vector() &&
> > > > > > > > +                   !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> > > > > > > >                         EXT_KEY(ZVBB);
> > > > > > > >                         EXT_KEY(ZVBC);
> > > > > > > >                         EXT_KEY(ZVKB);
> > > > > > > > @@ -139,6 +141,55 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> > > > > > > >         pair->value &= ~missing;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static void hwprobe_isa_vendor_ext0(struct riscv_hwprobe *pair,
> > > > > > > > +                                   const struct cpumask *cpus)
> > > > > > > > +{
> > > > > > > > +       int cpu;
> > > > > > > > +       u64 missing = 0;
> > > > > > > > +
> > > > > > > > +       pair->value = 0;
> > > > > > > > +
> > > > > > > > +       struct riscv_hwprobe mvendorid = {
> > > > > > > > +               .key = RISCV_HWPROBE_KEY_MVENDORID,
> > > > > > > > +               .value = 0
> > > > > > > > +       };
> > > > > > > > +
> > > > > > > > +       hwprobe_arch_id(&mvendorid, cpus);
> > > > > > > > +
> > > > > > > > +       /* Set value to zero if CPUs in the set do not have the same vendor. */
> > > > > > > > +       if (mvendorid.value == -1ULL)
> > > > > > > > +               return;
> > > > > > > > +
> > > > > > > > +       /*
> > > > > > > > +        * Loop through and record vendor extensions that 1) anyone has, and
> > > > > > > > +        * 2) anyone doesn't have.
> > > > > > > > +        */
> > > > > > > > +       for_each_cpu(cpu, cpus) {
> > > > > > > > +               struct riscv_isainfo *isavendorinfo = &hart_isa_vendor[cpu];
> > > > > > > > +
> > > > > > > > +#define VENDOR_EXT_KEY(ext)                                                            \
> > > > > > > > +       do {                                                                            \
> > > > > > > > +               if (__riscv_isa_vendor_extension_available(isavendorinfo->isa,          \
> > > > > > > > +                                                        RISCV_ISA_VENDOR_EXT_##ext))   \
> > > > > > > > +                       pair->value |= RISCV_HWPROBE_VENDOR_EXT_##ext;                  \
> > > > > > > > +               else                                                                    \
> > > > > > > > +                       missing |= RISCV_HWPROBE_VENDOR_EXT_##ext;                      \
> > > > > > > > +       } while (false)
> > > > > > > > +
> > > > > > > > +       /*
> > > > > > > > +        * Only use VENDOR_EXT_KEY() for extensions which can be exposed to userspace,
> > > > > > > > +        * regardless of the kernel's configuration, as no other checks, besides
> > > > > > > > +        * presence in the hart_vendor_isa bitmap, are made.
> > > > > > > > +        */
> > > > > > > > +       VENDOR_EXT_KEY(XTHEADVECTOR);
> > > > > > > > +
> > > > > > > > +#undef VENDOR_EXT_KEY
> > > > > > >
> > > > > > > Hey Charlie,
> > > > > > > Thanks for writing this up! At the very least I think the
> > > > > > > THEAD-specific stuff should probably end up in its own file, otherwise
> > > > > > > it'll get chaotic with vendors clamoring to add stuff right here.
> > > > > >
> > > > > > Great idea!
> > > > > >
> > > > > > > What do you think about this approach:
> > > > > > >  * We leave RISCV_HWPROBE_MAX_KEY as the max key for the "generic
> > > > > > > world", eg 6-ish
> > > > > > >  * We define that any key above 0x8000000000000000 is in the vendor
> > > > > > > space, so the meaning of the keys depends first on the mvendorid
> > > > > > > value.
> > > > > > >  * In the kernel code, each new vendor adds on to a global struct,
> > > > > > > which might look something like:
> > > > > > > struct hwprobe_vendor_space vendor_space[] = {
> > > > > > >         {
> > > > > > >                 .mvendorid = VENDOR_THEAD,
> > > > > > >                 .max_hwprobe_key = THEAD_MAX_HWPROBE_KEY, // currently
> > > > > > > 1 or 0x8000000000000001 with what you've got.
> > > > > > >                 .hwprobe_fn = thead_hwprobe
> > > > > > >         },
> > > > > > >         ...
> > > > > > > };
> > > > > > >
> > > > > > >  * A hwprobe_thead.c implements thead_hwprobe(), and is called
> > > > > > > whenever the generic hwprobe encounters a key >=0x8000000000000000.
> > > > > > >  * Generic code for setting up the VDSO can then still call the
> > > > > > > vendor-specific hwprobe_fn() repeatedly with an "all CPUs" mask from
> > > > > > > the base to max_hwprobe_key and set up the cached tables in userspace.
> > > > > > >  * Since the VDSO data has limited space we may have to cap the number
> > > > > > > of vendor keys we cache to be lower than max_hwprobe_key. Since the
> > > > > > > data itself is not exposed to usermode we can raise this cap later if
> > > > > > > needed.
> > > > > >
> > > > > > I know vendor extensions are kind of the "wild west" of riscv, but in
> > > > > > spite of that I want to design a consistent API. The issue I had with
> > > > > > having this "vendor space" for exposing vendor extensions was that this
> > > > > > is something that is inherently the same for all vendors. I see a vendor
> > > > > > space like this more applicable for something like
> > > > > > "RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE" where a vendor has a specific
> > > > > > value they would like to expose. I do agree that having a vendor space
> > > > > > is a good design choice, but I am not convinced that vendor extensions
> > > > > > are the proper use-case.
> > > > > >
> > > > > > By having RISCV_HWPROBE_KEY_VENDOR_EXT_0 we can expose the vendor
> > > > > > extensions in the same way that standard extensions are exposed, with a
> > > > > > bitmask representing each extension. If these are instead in the vendor
> > > > > > space, each vendor would probably be inclined to introduce a key like
> > > > > > RISCV_HWPROBE_KEY_THEAD_EXT_0 that returns a bitmask of all of the thead
> > > > > > vendor extensions. This duplicated effort is what I am trying to avoid.
> > > > > > The alternative would be that vendors have a separate key for each
> > > > > > vendor extension they would like to expose, but that is strictly less
> > > > > > efficient than the existing bitmask probing.
> > > > > >
> > > > > > Do you think that having the vendor space is appropriate for vendor
> > > > > > extensions given my concerns?
> > > > >
> > > > > I do see what you're going for. It's tidy for a bitmask to just let
> > > > > anyone allocate the next bit, but leaves you with the same problem
> > > > > when a vendor decides they want to expose an enum, or decides they
> > > > > want to expose a bazillion things. I think a generalized version of
> > > >
> > > > This patch is strictly to expose if a vendor extension is supported,
> > > > how does exposing enums factor in here?
> > > >
> > > > > the approach you've written would be: simply let vendors allocate keys
> > > > > from the same global space we're already using. My worry was that it
> > > >
> > > > I am missing how my proposal suggests allowing vendors to allocate keys
> > > > in a global space.
> > > >
> > > > > would turn into an expansive suburban sprawl of mostly dead bits, or
> > > > > in the case of vendor-specific keys, full of "if (mvendor_id() !=
> > > > > MINE) return 0;". My hope with the vendored keyspace is it would keep
> > > >
> > > > An application will always need to check vendorid before calling hwprobe
> > > > with a vendor-specific feature? If that hwprobe support is a key above
> > > > 1<<63, then the application will need to pass that vendor-specific key
> > > > and interpret the vendor-specific value. If that hwprobe support is what
> > > > I have proposed here, then the user calls the standardized vendor
> > > > extension hwprobe endpoint and then needs to interpret the result based
> > > > on the vendor of the cpumask. In both cases they need to check the
> > > > vendorid of the cpumask. In the test case I added I failed to check the
> > > > vendorid but I should have had that.
> > > >
> > > > > the sprawl from polluting the general array of (hopefully valuable)
> > > > > info with stuff that's likely to become less relevant as time passes.
> > > > > It also lowers the bar a bit to make it easier for vendors to expose
> > > > > bits, as they don't consume global space for everyone for all of time,
> > > > > just themselves.
> > > >
> > > > The vendor keys are tied directly to the vendor. So as it grows we would
> > > > have something like:
> > > >
> > > > #define RISCV_HWPROBE_KEY_VENDOR_EXT_0  7
> > > > /* T-Head */
> > > > #define         RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR   (1 << 0)
> > > > #define         RISCV_HWPROBE_VENDOR_EXT_XTHEAD2        (2 << 0)
> > > > #define         RISCV_HWPROBE_VENDOR_EXT_XTHEAD3        (3 << 0)
> > > > /* Vendor 2 */
> > > > #define         RISCV_HWPROBE_VENDOR_EXT_XVENDOR1       (1 << 0)
> > > > #define         RISCV_HWPROBE_VENDOR_EXT_XVENDOR2       (2 << 0)
> > > > /* Vendor 3 */
> > > > ...
> > > >
> > > > The keys overlap between vendors. To determine which extension a vendor
> > > > supports, hwprobe gets data from hart_isa_vendor[cpu]. If the vendor is
> > > > vendor 2, it is not possible for a vendor extension from vendor 3 to end
> > > > up in there. Only the extensions from that vendor can be supported by
> > > > that vendor's hardware.
> > >
> > > Gotcha. You're right I had misinterpreted this, thinking XTHEADVECTOR
> > > was a valid bit regardless of mvendorid, and that other vendors would
> > > have to choose new bits for their features and always return 0 for
> > > XTHEADVECTOR. With your explanation, it seems like you're allocating
> > > keys (in no particular order) whose meaning will change based on
> > > mvendorid.
> > >
> > > I guess I'm still not convinced that saving each vendor from having to
> > > add a VENDOR_EXT key in their keyspace is worth the sacrifice of
> > > spraying the vendor-specific keys across the generic keyspace. Are
> > > there advantages to having a single key whose category is similar but
> > > whose bits are entirely vendor-defined? Maybe if I were userspace and
> > > my feature could be satisfied equivalently by XTHEADVECTOR or
> > > XRIVOSOTHERTHING, then I could do one hwprobe call instead of two? But
> > > I don't think the vendors are going to be consistent enough for that
> > > equivalency to ever prove useful. The advantages in my head of the
> > > separate vendor keyspace are:
> > >  * Keeps the kernel code simple: if key >= (1 >> 63)
> > > vendor_config->do_hwprobe(), rather than having all these little calls
> > > in each specific switch case for vendor_config->do_vendor_ext0(),
> > > vendor_config->do_vendor_ext1(), etc.
> >
> > The consistency between vendors is guaranteed in this scheme. They just
> > add the extension to hwprobe_isa_vendor_ext0. The following code is the
> > critical code from the kernel:
> >
> >         for_each_cpu(cpu, cpus) {
> >                 struct riscv_isainfo *isavendorinfo = &hart_isa_vendor[cpu];
> >
> > #define VENDOR_EXT_KEY(ext)                                                             \
> >         do {                                                                            \
> >                 if (__riscv_isa_vendor_extension_available(isavendorinfo->isa,          \
> >                                                          RISCV_ISA_VENDOR_EXT_##ext))   \
> >                         pair->value |= RISCV_HWPROBE_VENDOR_EXT_##ext;                  \
> >                 else                                                                    \
> >                         missing |= RISCV_HWPROBE_VENDOR_EXT_##ext;                      \
> >         } while (false)
> >
> >         /*
> >          * Only use VENDOR_EXT_KEY() for extensions which can be exposed to userspace,
> >          * regardless of the kernel's configuration, as no other checks, besides
> >          * presence in the hart_vendor_isa bitmap, are made.
> >          */
> >         VENDOR_EXT_KEY(XTHEADVECTOR);
> >
> > #undef VENDOR_EXT_KEY
> >         }
> >
> >         /* Now turn off reporting features if any CPU is missing it. */
> >         pair->value &= ~missing;
> >
> > The only thing a vendor will have to do is add an entry below
> > VENDOR_EXT_KEY(XTHEADVECTOR) with their extension name (of course
> > populating a value for the key as well). This existing code will then
> > check if the extension is compatible with the hardware and appropriate
> > populate the bitmask. All vendors get this functionality for "free"
> > without needing to write the boilerplate code to expose vendor
> > extensions through hwprobe.
> >
> > Now that I write this out I do see that I overlooked that this code
> > needs to check the vendorid to ensure that the given extension is
> > actually associated with the vendorid. This would make this more
> > complicated but still seems like a low barrier to entry for a new
> > vendor, as well as a standard API for getting all vendor extensions that
> > are available on the platform regardless of which platform is being
> > used.
> >
> 
> Maybe I'll reserve judgment until I see the next spin, since we need
> both the "conditionalize on mvendorid" part, and to move the vendor
> stuff into a thead-specific file as discussed earlier. I'll be trying
> to picture how this looks 10 years from now, when a bunch of vendors
> have added dozens of extensions, and 75% of them are at that point
> defunct baggage.

Okay I will make some changes here and then we can continue this
conversation :)

> 
> > >  * It extends easily into passing other forms of vendor hwprobe info
> > > later, rather than solving only the case of risc-v extensions now, and
> > > then having to do this all again for each additional category of
> > > vendor data.
> >
> > This is a great point. I do agree that a different solution will be
> > necessary for arbitrary vendor data and I am all for making something
> > future compatible. At the same time I don't want to get trapped into
> > something that is suboptimal for the sake of doing less work later.
> > There is no chance of any compatibility once we leave the realm of
> > riscv extensions, so once a vendor needs something exported I would be
> > happy to write the code to support that.
> >
> > >  * Similarly, it discourages future vendors from trying to squint and
> > > find a way to make a vaguely generic sounding category for their own
> > > hwprobe key which will ultimately only ever be filled in by them
> > > anyway.
> >
> > What do you mean by this? There are no "categories" here, the vendor
> > just writes out their extension VENDOR_EXT_KEY(XVENDOREXTENSION) and it
> > gets shuttled to userspace on the hwprobe vendor call.
> 
> The category in this case is RISC-V extensions, since you've defined a
> key whose contents are vendor-specific, but whose bits must all fit
> the category of being a risc-v vendor extension.
> 
> To frame it in another light, one equivalent version from an ABI
> perspective would be to say ok, let's put this key up into the 1<<63
> range, but carve out a "common key" range where all vendors implement
> the same key definitions, like this VENDOR_EXT_0 key. Is that useful,
> or is it unnecessary structure? I think I'm of the opinion it's
> unnecessary structure, but I'm still open to being convinced.

That makes sense, thank you for clarifying, I appreciate that
perspective. I am coming from the direction that I want to share as much
as possible between vendors to minimize both kernel and userspace code.
In that sense, it is unnecessary. It would be fine to have each vendor
define their own way of probing which vendor extensions are available.
My inclination is that would lead to more verbosity in the
kernel and userspace, but I too am open to be convinced.

- Charlie

> -Evan
> 
> >
> > - Charlie
> >
> > >
> > > -Evan

