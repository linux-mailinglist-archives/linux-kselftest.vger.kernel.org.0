Return-Path: <linux-kselftest+bounces-7884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D878A38A8
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 00:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A258CB217D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 22:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F83C15099C;
	Fri, 12 Apr 2024 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="myJvXmC4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBFC84DF6
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712962246; cv=none; b=UB4YLK0sap3p+RmZTpxwqZDl8mvgw5ywHch72AkLp5crMTLmf71LRb5W4mQ0CgwSR2bfSLQsoGrESyK/lEe+q2hI/Qll/arapnjcNDxzX5PmGGwulTVsk6ZIgua2TjYbH7xaCxygzvtBFD3YCsu/6MEPzW5YPL6vWFaAM9dZpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712962246; c=relaxed/simple;
	bh=8oIqJ98k5RxGUjTqi3muEImqLT32RRrM3A+tiZf0t7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUpwq1Acq3GKxGWHyjainA4aZ0sFbGP1Vrx3BemA3fBSrP/JCq/WPNDpC9fARbZ86lRJvdJDyPHOpbLg/GSdfycAos+RNJmWF71Ltq/oXpTZj2JiORIDDCAis0r3NjKCcJmJXQOmECVkZerCi0R86H/zn3keSH+aZg4zffe5V/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=myJvXmC4; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so20166771fa.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 15:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712962242; x=1713567042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMsCtRxa3tw9lfURs3uHsBM7KEusWInjgfJxTxdOMic=;
        b=myJvXmC4drVtZjgTHvutmXWDYMjw0OKdEPo0eZPBV5WojORgHpSmWULzlue79AEWva
         bmz1gVhdvpGhP5gTgSrjMQC77LxmCVbi4/7zGGSyewL62f7aeFip/4txa7P775RoHo/b
         JCjQ5epojdfG3WRKibTZgz+n3eYAPpDw/HYt0E6keDFDbUfGgM8hD9wGok1P4oxLqg12
         btOgqA9Ak80HTwsGGufgBoKkAdD3QFvHIIjWMWbAz0r6CvvX4FfL2P5Bi9GaofGR9LpI
         E/f6on808j4Bi2PQFkC3egTOns+wESgvfFbmNnhExeWhnMmvveLu+nnox6ij74u4BLIS
         1cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712962242; x=1713567042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMsCtRxa3tw9lfURs3uHsBM7KEusWInjgfJxTxdOMic=;
        b=m+Y+6i9w32VKuQoLmH+VwpRix6n6KSqWggQilB7hfvo5BGzycfEr71w/25tM5xGyKc
         NjJ56RIaubuFiTQNEpsF7vKGlFUb59K7ftYNbcV/0frivlA3Pjswv7rsYiKp74I2APsA
         Oc/Mjuw/mj7nfK/GMDjRAnqfckBSuDO1/QllwN4FNksQjVu833txQEXRD8UuzEAaTcmr
         6y2Bgpjr5TzRNYH1VzSrql1oStZUuqaBJOCNnPUvUZcm5K3nLoWC45zPrLUZdbetnIvQ
         jowknjHPMlpFYrPhANN+Pz7rEAkurhyGObSnNBHB6P5NoGCkvTo8sF3JkR/8oK7cPPZC
         gDnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2V1Dxc24QAX+xPySnMNTOLbksb3So/NYjR6kPXY2YY3CQUDlhHGVqmu1URNca1rYvnHqsASqZp9RZr3L0ykuMNLEukKPq3G7CoSX0V/qi
X-Gm-Message-State: AOJu0YwChSwltiQtTNk5ce7YfVYJgNqtTiUof1VZom84DZU7ssDXaO06
	oyXrDbLrQzeOo4nhcqFTzSkf1aUIfhtfPxITtfyIATu6u+ZH1GyZghaweSFu8mrpFCIwt2UopNU
	UG2xeBJksh6prt6ETgNBcAt3smI2U2dZ8fIdyzg==
X-Google-Smtp-Source: AGHT+IGaZUEXMvTlEpC5KgtprvlDwVJ9WAEdlOXiw8m+HJgqK595JEoS941wL7UxTUrbblhalItxVVjQmbvrEP4613I=
X-Received: by 2002:a05:651c:102a:b0:2d4:514b:428 with SMTP id
 w10-20020a05651c102a00b002d4514b0428mr2242711ljm.6.1712962241205; Fri, 12 Apr
 2024 15:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-16-4af9815ec746@rivosinc.com>
 <CALs-Hss=vuNgq-8bVL1DOR431qFpn-D13yFGn6yf_2saZO0FVQ@mail.gmail.com>
 <Zhl6lvZzUrCoAB8N@ghost> <CALs-Hsu=SLnTJ+gsGZmv7C=K8WGHRiFCn3Q=isE9+QhawcrqCw@mail.gmail.com>
 <ZhmXnUj2B1hD5QiX@ghost> <CALs-Hsu4m0y2zSvpZwn2znyxNMfJ5f0NpYOh9TNYB4u5=GUKxw@mail.gmail.com>
 <Zhmzzq3oedZ1LozW@ghost>
In-Reply-To: <Zhmzzq3oedZ1LozW@ghost>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 12 Apr 2024 15:50:05 -0700
Message-ID: <CALs-HssuhXr-mRui7KujqAwCU-=O+udrJ4cp-be=sFbCL0ADrA@mail.gmail.com>
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

On Fri, Apr 12, 2024 at 3:21=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Fri, Apr 12, 2024 at 02:43:01PM -0700, Evan Green wrote:
> > On Fri, Apr 12, 2024 at 1:20=E2=80=AFPM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > >
> > > On Fri, Apr 12, 2024 at 12:07:46PM -0700, Evan Green wrote:
> > > > On Fri, Apr 12, 2024 at 11:17=E2=80=AFAM Charlie Jenkins <charlie@r=
ivosinc.com> wrote:
> > > > >
> > > > > On Fri, Apr 12, 2024 at 10:05:21AM -0700, Evan Green wrote:
> > > > > > On Thu, Apr 11, 2024 at 9:12=E2=80=AFPM Charlie Jenkins <charli=
e@rivosinc.com> wrote:
> > > > > > >
> > > > > > > Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_0" which =
allows
> > > > > > > userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVEC=
TOR vendor
> > > > > > > extension.
> > > > > > >
> > > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > > ---
> > > > > > >  arch/riscv/include/asm/hwprobe.h      |  4 +--
> > > > > > >  arch/riscv/include/uapi/asm/hwprobe.h | 10 +++++-
> > > > > > >  arch/riscv/kernel/sys_hwprobe.c       | 59 +++++++++++++++++=
++++++++++++++++--
> > > > > > >  3 files changed, 68 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/in=
clude/asm/hwprobe.h
> > > > > > > index 630507dff5ea..e68496b4f8de 100644
> > > > > > > --- a/arch/riscv/include/asm/hwprobe.h
> > > > > > > +++ b/arch/riscv/include/asm/hwprobe.h
> > > > > > > @@ -1,6 +1,6 @@
> > > > > > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note =
*/
> > > > > > >  /*
> > > > > > > - * Copyright 2023 Rivos, Inc
> > > > > > > + * Copyright 2023-2024 Rivos, Inc
> > > > > > >   */
> > > > > > >
> > > > > > >  #ifndef _ASM_HWPROBE_H
> > > > > > > @@ -8,7 +8,7 @@
> > > > > > >
> > > > > > >  #include <uapi/asm/hwprobe.h>
> > > > > > >
> > > > > > > -#define RISCV_HWPROBE_MAX_KEY 6
> > > > > > > +#define RISCV_HWPROBE_MAX_KEY 7
> > > > > > >
> > > > > > >  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> > > > > > >  {
> > > > > > > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/ris=
cv/include/uapi/asm/hwprobe.h
> > > > > > > index 9f2a8e3ff204..6614d3adfc75 100644
> > > > > > > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > > > > > > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > > > > > > @@ -1,6 +1,6 @@
> > > > > > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note =
*/
> > > > > > >  /*
> > > > > > > - * Copyright 2023 Rivos, Inc
> > > > > > > + * Copyright 2023-2024 Rivos, Inc
> > > > > > >   */
> > > > > > >
> > > > > > >  #ifndef _UAPI_ASM_HWPROBE_H
> > > > > > > @@ -67,6 +67,14 @@ struct riscv_hwprobe {
> > > > > > >  #define                RISCV_HWPROBE_MISALIGNED_UNSUPPORTED =
   (4 << 0)
> > > > > > >  #define                RISCV_HWPROBE_MISALIGNED_MASK        =
   (7 << 0)
> > > > > > >  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> > > > > > > +/*
> > > > > > > + * It is not possible for one CPU to have multiple vendor id=
s, so each vendor
> > > > > > > + * has its own vendor extension "namespace". The keys for ea=
ch vendor starts
> > > > > > > + * at zero.
> > > > > > > + */
> > > > > > > +#define RISCV_HWPROBE_KEY_VENDOR_EXT_0 7
> > > > > > > + /* T-Head */
> > > > > > > +#define                RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR=
   (1 << 0)
> > > > > > >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> > > > > > >
> > > > > > >  /* Flags */
> > > > > > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/ker=
nel/sys_hwprobe.c
> > > > > > > index e0a42c851511..365ce7380443 100644
> > > > > > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > > > > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > > > > > @@ -69,7 +69,8 @@ static void hwprobe_isa_ext0(struct riscv_h=
wprobe *pair,
> > > > > > >         if (riscv_isa_extension_available(NULL, c))
> > > > > > >                 pair->value |=3D RISCV_HWPROBE_IMA_C;
> > > > > > >
> > > > > > > -       if (has_vector() && !riscv_has_vendor_extension_unlik=
ely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR))
> > > > > > > +       if (has_vector() &&
> > > > > > > +           !__riscv_isa_vendor_extension_available(NULL, RIS=
CV_ISA_VENDOR_EXT_XTHEADVECTOR))
> > > > > > >                 pair->value |=3D RISCV_HWPROBE_IMA_V;
> > > > > > >
> > > > > > >         /*
> > > > > > > @@ -112,7 +113,8 @@ static void hwprobe_isa_ext0(struct riscv=
_hwprobe *pair,
> > > > > > >                 EXT_KEY(ZACAS);
> > > > > > >                 EXT_KEY(ZICOND);
> > > > > > >
> > > > > > > -               if (has_vector() && !riscv_has_vendor_extensi=
on_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> > > > > > > +               if (has_vector() &&
> > > > > > > +                   !riscv_has_vendor_extension_unlikely(RISC=
V_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> > > > > > >                         EXT_KEY(ZVBB);
> > > > > > >                         EXT_KEY(ZVBC);
> > > > > > >                         EXT_KEY(ZVKB);
> > > > > > > @@ -139,6 +141,55 @@ static void hwprobe_isa_ext0(struct risc=
v_hwprobe *pair,
> > > > > > >         pair->value &=3D ~missing;
> > > > > > >  }
> > > > > > >
> > > > > > > +static void hwprobe_isa_vendor_ext0(struct riscv_hwprobe *pa=
ir,
> > > > > > > +                                   const struct cpumask *cpu=
s)
> > > > > > > +{
> > > > > > > +       int cpu;
> > > > > > > +       u64 missing =3D 0;
> > > > > > > +
> > > > > > > +       pair->value =3D 0;
> > > > > > > +
> > > > > > > +       struct riscv_hwprobe mvendorid =3D {
> > > > > > > +               .key =3D RISCV_HWPROBE_KEY_MVENDORID,
> > > > > > > +               .value =3D 0
> > > > > > > +       };
> > > > > > > +
> > > > > > > +       hwprobe_arch_id(&mvendorid, cpus);
> > > > > > > +
> > > > > > > +       /* Set value to zero if CPUs in the set do not have t=
he same vendor. */
> > > > > > > +       if (mvendorid.value =3D=3D -1ULL)
> > > > > > > +               return;
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * Loop through and record vendor extensions that 1) =
anyone has, and
> > > > > > > +        * 2) anyone doesn't have.
> > > > > > > +        */
> > > > > > > +       for_each_cpu(cpu, cpus) {
> > > > > > > +               struct riscv_isainfo *isavendorinfo =3D &hart=
_isa_vendor[cpu];
> > > > > > > +
> > > > > > > +#define VENDOR_EXT_KEY(ext)                                 =
                           \
> > > > > > > +       do {                                                 =
                           \
> > > > > > > +               if (__riscv_isa_vendor_extension_available(is=
avendorinfo->isa,          \
> > > > > > > +                                                        RISC=
V_ISA_VENDOR_EXT_##ext))   \
> > > > > > > +                       pair->value |=3D RISCV_HWPROBE_VENDOR=
_EXT_##ext;                  \
> > > > > > > +               else                                         =
                           \
> > > > > > > +                       missing |=3D RISCV_HWPROBE_VENDOR_EXT=
_##ext;                      \
> > > > > > > +       } while (false)
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * Only use VENDOR_EXT_KEY() for extensions which can=
 be exposed to userspace,
> > > > > > > +        * regardless of the kernel's configuration, as no ot=
her checks, besides
> > > > > > > +        * presence in the hart_vendor_isa bitmap, are made.
> > > > > > > +        */
> > > > > > > +       VENDOR_EXT_KEY(XTHEADVECTOR);
> > > > > > > +
> > > > > > > +#undef VENDOR_EXT_KEY
> > > > > >
> > > > > > Hey Charlie,
> > > > > > Thanks for writing this up! At the very least I think the
> > > > > > THEAD-specific stuff should probably end up in its own file, ot=
herwise
> > > > > > it'll get chaotic with vendors clamoring to add stuff right her=
e.
> > > > >
> > > > > Great idea!
> > > > >
> > > > > > What do you think about this approach:
> > > > > >  * We leave RISCV_HWPROBE_MAX_KEY as the max key for the "gener=
ic
> > > > > > world", eg 6-ish
> > > > > >  * We define that any key above 0x8000000000000000 is in the ve=
ndor
> > > > > > space, so the meaning of the keys depends first on the mvendori=
d
> > > > > > value.
> > > > > >  * In the kernel code, each new vendor adds on to a global stru=
ct,
> > > > > > which might look something like:
> > > > > > struct hwprobe_vendor_space vendor_space[] =3D {
> > > > > >         {
> > > > > >                 .mvendorid =3D VENDOR_THEAD,
> > > > > >                 .max_hwprobe_key =3D THEAD_MAX_HWPROBE_KEY, // =
currently
> > > > > > 1 or 0x8000000000000001 with what you've got.
> > > > > >                 .hwprobe_fn =3D thead_hwprobe
> > > > > >         },
> > > > > >         ...
> > > > > > };
> > > > > >
> > > > > >  * A hwprobe_thead.c implements thead_hwprobe(), and is called
> > > > > > whenever the generic hwprobe encounters a key >=3D0x80000000000=
00000.
> > > > > >  * Generic code for setting up the VDSO can then still call the
> > > > > > vendor-specific hwprobe_fn() repeatedly with an "all CPUs" mask=
 from
> > > > > > the base to max_hwprobe_key and set up the cached tables in use=
rspace.
> > > > > >  * Since the VDSO data has limited space we may have to cap the=
 number
> > > > > > of vendor keys we cache to be lower than max_hwprobe_key. Since=
 the
> > > > > > data itself is not exposed to usermode we can raise this cap la=
ter if
> > > > > > needed.
> > > > >
> > > > > I know vendor extensions are kind of the "wild west" of riscv, bu=
t in
> > > > > spite of that I want to design a consistent API. The issue I had =
with
> > > > > having this "vendor space" for exposing vendor extensions was tha=
t this
> > > > > is something that is inherently the same for all vendors. I see a=
 vendor
> > > > > space like this more applicable for something like
> > > > > "RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE" where a vendor has a specif=
ic
> > > > > value they would like to expose. I do agree that having a vendor =
space
> > > > > is a good design choice, but I am not convinced that vendor exten=
sions
> > > > > are the proper use-case.
> > > > >
> > > > > By having RISCV_HWPROBE_KEY_VENDOR_EXT_0 we can expose the vendor
> > > > > extensions in the same way that standard extensions are exposed, =
with a
> > > > > bitmask representing each extension. If these are instead in the =
vendor
> > > > > space, each vendor would probably be inclined to introduce a key =
like
> > > > > RISCV_HWPROBE_KEY_THEAD_EXT_0 that returns a bitmask of all of th=
e thead
> > > > > vendor extensions. This duplicated effort is what I am trying to =
avoid.
> > > > > The alternative would be that vendors have a separate key for eac=
h
> > > > > vendor extension they would like to expose, but that is strictly =
less
> > > > > efficient than the existing bitmask probing.
> > > > >
> > > > > Do you think that having the vendor space is appropriate for vend=
or
> > > > > extensions given my concerns?
> > > >
> > > > I do see what you're going for. It's tidy for a bitmask to just let
> > > > anyone allocate the next bit, but leaves you with the same problem
> > > > when a vendor decides they want to expose an enum, or decides they
> > > > want to expose a bazillion things. I think a generalized version of
> > >
> > > This patch is strictly to expose if a vendor extension is supported,
> > > how does exposing enums factor in here?
> > >
> > > > the approach you've written would be: simply let vendors allocate k=
eys
> > > > from the same global space we're already using. My worry was that i=
t
> > >
> > > I am missing how my proposal suggests allowing vendors to allocate ke=
ys
> > > in a global space.
> > >
> > > > would turn into an expansive suburban sprawl of mostly dead bits, o=
r
> > > > in the case of vendor-specific keys, full of "if (mvendor_id() !=3D
> > > > MINE) return 0;". My hope with the vendored keyspace is it would ke=
ep
> > >
> > > An application will always need to check vendorid before calling hwpr=
obe
> > > with a vendor-specific feature? If that hwprobe support is a key abov=
e
> > > 1<<63, then the application will need to pass that vendor-specific ke=
y
> > > and interpret the vendor-specific value. If that hwprobe support is w=
hat
> > > I have proposed here, then the user calls the standardized vendor
> > > extension hwprobe endpoint and then needs to interpret the result bas=
ed
> > > on the vendor of the cpumask. In both cases they need to check the
> > > vendorid of the cpumask. In the test case I added I failed to check t=
he
> > > vendorid but I should have had that.
> > >
> > > > the sprawl from polluting the general array of (hopefully valuable)
> > > > info with stuff that's likely to become less relevant as time passe=
s.
> > > > It also lowers the bar a bit to make it easier for vendors to expos=
e
> > > > bits, as they don't consume global space for everyone for all of ti=
me,
> > > > just themselves.
> > >
> > > The vendor keys are tied directly to the vendor. So as it grows we wo=
uld
> > > have something like:
> > >
> > > #define RISCV_HWPROBE_KEY_VENDOR_EXT_0  7
> > > /* T-Head */
> > > #define         RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR   (1 << 0)
> > > #define         RISCV_HWPROBE_VENDOR_EXT_XTHEAD2        (2 << 0)
> > > #define         RISCV_HWPROBE_VENDOR_EXT_XTHEAD3        (3 << 0)
> > > /* Vendor 2 */
> > > #define         RISCV_HWPROBE_VENDOR_EXT_XVENDOR1       (1 << 0)
> > > #define         RISCV_HWPROBE_VENDOR_EXT_XVENDOR2       (2 << 0)
> > > /* Vendor 3 */
> > > ...
> > >
> > > The keys overlap between vendors. To determine which extension a vend=
or
> > > supports, hwprobe gets data from hart_isa_vendor[cpu]. If the vendor =
is
> > > vendor 2, it is not possible for a vendor extension from vendor 3 to =
end
> > > up in there. Only the extensions from that vendor can be supported by
> > > that vendor's hardware.
> >
> > Gotcha. You're right I had misinterpreted this, thinking XTHEADVECTOR
> > was a valid bit regardless of mvendorid, and that other vendors would
> > have to choose new bits for their features and always return 0 for
> > XTHEADVECTOR. With your explanation, it seems like you're allocating
> > keys (in no particular order) whose meaning will change based on
> > mvendorid.
> >
> > I guess I'm still not convinced that saving each vendor from having to
> > add a VENDOR_EXT key in their keyspace is worth the sacrifice of
> > spraying the vendor-specific keys across the generic keyspace. Are
> > there advantages to having a single key whose category is similar but
> > whose bits are entirely vendor-defined? Maybe if I were userspace and
> > my feature could be satisfied equivalently by XTHEADVECTOR or
> > XRIVOSOTHERTHING, then I could do one hwprobe call instead of two? But
> > I don't think the vendors are going to be consistent enough for that
> > equivalency to ever prove useful. The advantages in my head of the
> > separate vendor keyspace are:
> >  * Keeps the kernel code simple: if key >=3D (1 >> 63)
> > vendor_config->do_hwprobe(), rather than having all these little calls
> > in each specific switch case for vendor_config->do_vendor_ext0(),
> > vendor_config->do_vendor_ext1(), etc.
>
> The consistency between vendors is guaranteed in this scheme. They just
> add the extension to hwprobe_isa_vendor_ext0. The following code is the
> critical code from the kernel:
>
>         for_each_cpu(cpu, cpus) {
>                 struct riscv_isainfo *isavendorinfo =3D &hart_isa_vendor[=
cpu];
>
> #define VENDOR_EXT_KEY(ext)                                              =
               \
>         do {                                                             =
               \
>                 if (__riscv_isa_vendor_extension_available(isavendorinfo-=
>isa,          \
>                                                          RISCV_ISA_VENDOR=
_EXT_##ext))   \
>                         pair->value |=3D RISCV_HWPROBE_VENDOR_EXT_##ext; =
                 \
>                 else                                                     =
               \
>                         missing |=3D RISCV_HWPROBE_VENDOR_EXT_##ext;     =
                 \
>         } while (false)
>
>         /*
>          * Only use VENDOR_EXT_KEY() for extensions which can be exposed =
to userspace,
>          * regardless of the kernel's configuration, as no other checks, =
besides
>          * presence in the hart_vendor_isa bitmap, are made.
>          */
>         VENDOR_EXT_KEY(XTHEADVECTOR);
>
> #undef VENDOR_EXT_KEY
>         }
>
>         /* Now turn off reporting features if any CPU is missing it. */
>         pair->value &=3D ~missing;
>
> The only thing a vendor will have to do is add an entry below
> VENDOR_EXT_KEY(XTHEADVECTOR) with their extension name (of course
> populating a value for the key as well). This existing code will then
> check if the extension is compatible with the hardware and appropriate
> populate the bitmask. All vendors get this functionality for "free"
> without needing to write the boilerplate code to expose vendor
> extensions through hwprobe.
>
> Now that I write this out I do see that I overlooked that this code
> needs to check the vendorid to ensure that the given extension is
> actually associated with the vendorid. This would make this more
> complicated but still seems like a low barrier to entry for a new
> vendor, as well as a standard API for getting all vendor extensions that
> are available on the platform regardless of which platform is being
> used.
>

Maybe I'll reserve judgment until I see the next spin, since we need
both the "conditionalize on mvendorid" part, and to move the vendor
stuff into a thead-specific file as discussed earlier. I'll be trying
to picture how this looks 10 years from now, when a bunch of vendors
have added dozens of extensions, and 75% of them are at that point
defunct baggage.

> >  * It extends easily into passing other forms of vendor hwprobe info
> > later, rather than solving only the case of risc-v extensions now, and
> > then having to do this all again for each additional category of
> > vendor data.
>
> This is a great point. I do agree that a different solution will be
> necessary for arbitrary vendor data and I am all for making something
> future compatible. At the same time I don't want to get trapped into
> something that is suboptimal for the sake of doing less work later.
> There is no chance of any compatibility once we leave the realm of
> riscv extensions, so once a vendor needs something exported I would be
> happy to write the code to support that.
>
> >  * Similarly, it discourages future vendors from trying to squint and
> > find a way to make a vaguely generic sounding category for their own
> > hwprobe key which will ultimately only ever be filled in by them
> > anyway.
>
> What do you mean by this? There are no "categories" here, the vendor
> just writes out their extension VENDOR_EXT_KEY(XVENDOREXTENSION) and it
> gets shuttled to userspace on the hwprobe vendor call.

The category in this case is RISC-V extensions, since you've defined a
key whose contents are vendor-specific, but whose bits must all fit
the category of being a risc-v vendor extension.

To frame it in another light, one equivalent version from an ABI
perspective would be to say ok, let's put this key up into the 1<<63
range, but carve out a "common key" range where all vendors implement
the same key definitions, like this VENDOR_EXT_0 key. Is that useful,
or is it unnecessary structure? I think I'm of the opinion it's
unnecessary structure, but I'm still open to being convinced.
-Evan

>
> - Charlie
>
> >
> > -Evan

