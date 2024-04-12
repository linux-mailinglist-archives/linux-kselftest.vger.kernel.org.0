Return-Path: <linux-kselftest+bounces-7878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4158A380B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 23:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12399B22100
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 21:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809815218A;
	Fri, 12 Apr 2024 21:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wo7hYiVs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB5225D7
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712958222; cv=none; b=iNCo2+aEGTgY2O7LNoohTUDnrob5/DZ3rXb6gb4ZiMhMTf7LXNOmdtW2/qZ1hFAc0DD6DQnwVGoq3QwuiMxt7cpR5bEo5M/RD0dRpD9+MJa8TWAX9N773q7L887VSNDVrmpk6nsY+nWsdaXnjHdSuzjeZOaJNNC3L6/VbqaGMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712958222; c=relaxed/simple;
	bh=W5flOzUs9hCgNtSsncoT/3wpdKFgVE5/nt0SDyojtsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTizRR0spUYjN6vW3J8GoaBYPmKQ5MXzxk0GXMDP++BrmR0L3SxkKXoBYChTU8wUKzMQtUNXsZoIrR6QPL6gjOt4eqj452RiLN+m6p5wEDqB3PrY6rzmkE4pIzr/ZFGnMiF68I0XhxuzSJdW9HmKW96vV2EfMIPTu3rv1WSGiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wo7hYiVs; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso16457041fa.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 14:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712958217; x=1713563017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZqnpoJrYnyKUwwBneXw4v4bZBhm4v+etrm4n/HZz3w=;
        b=wo7hYiVsCfmLKSjGzY0aoJ8kpfZwg2CnMHwKBzVcXdWe66+Z2nh4p+5A38If74Tpy1
         ckAVp5wamnpUUD5zHZio1Vvd2Xu3mXArBZgsA0xHX3s70T8FpmjbNBW/KGkQnqfKxBhP
         gy6J+FjvFyJCfuC0yROpV274CR93StzN8tfp3YLX1PzpjDD46zPlvVvoVL71yFd25icP
         WuzORvFzyB4sWHPgQmBW5eVZ3p/HjmZ67T1335VheMzwLdaim6MJASSZfO/ovA+RnR0o
         uk2/b/stJ/X3HM1Ncd5sugC6F1DYqb28AHVQ0tEkaF8AGu9N7lvEgqgeYmVlYwjbIIcT
         z3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712958217; x=1713563017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZqnpoJrYnyKUwwBneXw4v4bZBhm4v+etrm4n/HZz3w=;
        b=pN1vRkdyeZBSQ213bfCO94hCqFw1ep3YkszS44afltaWgdoJHAMAywMNAw9Otd9c7h
         NrGvBuwsF7Cxpdg/JwLkhsX5XjHY89YzfMCbK7aS/HYPHOHh4+KcONG1XFjJBnDgMvDD
         0wSf8xifYm8+pG8LgMTjHKybZDe5WnTTXjFrpTleUEo3+7UDsV7Q/Yz6G0QBVDGS7oD+
         9Pkes+05xmlQ4AQNr4lQRA0u65mUdHbUVUFVDExqrsJFuCgU1DQAuu7fPh9yMsSixgRf
         7JCcPXiBGLcAOkwJq8SC/hgkZdqJIvi1gcw2fpfD89D7dlaXoUrjFZKDtViYPaMPhh3D
         atFA==
X-Forwarded-Encrypted: i=1; AJvYcCVuHN7MePtkz7a/2ZVM8vj7ab92l33lIxnhEHUO9c0fKCB8tAVz8UaGCPR4fohB8fL4r/tr2cCGckNMSI+BxORy+oaNQkL8DmQHOKuNUoU/
X-Gm-Message-State: AOJu0YyS3S+ab4YV6SCtQQ0AOdKr+6R+GozNhoYMT2Xttp32YaCrTAWL
	eiyKVQCbOElJHZ3FXW/pAdVa/aRBxbuXuXy4IMAyDemBaMI0XywBmzrvCzYM2U8Si9U7zfh43CT
	w2VMo+y/FsGiOg8vOUekr55o7gTVrEM2HA6DkWA==
X-Google-Smtp-Source: AGHT+IHMhnjkhkHrTxzo6/PdIiXDd9RSIY4h3/0PZg4IcBtGb4IBV56EytQMBYCxP7Y5GU0s/7TMt+PmaBPJ+MsqBVg=
X-Received: by 2002:a2e:a696:0:b0:2d8:c151:80ec with SMTP id
 q22-20020a2ea696000000b002d8c15180ecmr1868287lje.52.1712958217206; Fri, 12
 Apr 2024 14:43:37 -0700 (PDT)
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
 <ZhmXnUj2B1hD5QiX@ghost>
In-Reply-To: <ZhmXnUj2B1hD5QiX@ghost>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 12 Apr 2024 14:43:01 -0700
Message-ID: <CALs-Hsu4m0y2zSvpZwn2znyxNMfJ5f0NpYOh9TNYB4u5=GUKxw@mail.gmail.com>
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

On Fri, Apr 12, 2024 at 1:20=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Fri, Apr 12, 2024 at 12:07:46PM -0700, Evan Green wrote:
> > On Fri, Apr 12, 2024 at 11:17=E2=80=AFAM Charlie Jenkins <charlie@rivos=
inc.com> wrote:
> > >
> > > On Fri, Apr 12, 2024 at 10:05:21AM -0700, Evan Green wrote:
> > > > On Thu, Apr 11, 2024 at 9:12=E2=80=AFPM Charlie Jenkins <charlie@ri=
vosinc.com> wrote:
> > > > >
> > > > > Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_0" which allo=
ws
> > > > > userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR =
vendor
> > > > > extension.
> > > > >
> > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > ---
> > > > >  arch/riscv/include/asm/hwprobe.h      |  4 +--
> > > > >  arch/riscv/include/uapi/asm/hwprobe.h | 10 +++++-
> > > > >  arch/riscv/kernel/sys_hwprobe.c       | 59 +++++++++++++++++++++=
++++++++++++--
> > > > >  3 files changed, 68 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/includ=
e/asm/hwprobe.h
> > > > > index 630507dff5ea..e68496b4f8de 100644
> > > > > --- a/arch/riscv/include/asm/hwprobe.h
> > > > > +++ b/arch/riscv/include/asm/hwprobe.h
> > > > > @@ -1,6 +1,6 @@
> > > > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > >  /*
> > > > > - * Copyright 2023 Rivos, Inc
> > > > > + * Copyright 2023-2024 Rivos, Inc
> > > > >   */
> > > > >
> > > > >  #ifndef _ASM_HWPROBE_H
> > > > > @@ -8,7 +8,7 @@
> > > > >
> > > > >  #include <uapi/asm/hwprobe.h>
> > > > >
> > > > > -#define RISCV_HWPROBE_MAX_KEY 6
> > > > > +#define RISCV_HWPROBE_MAX_KEY 7
> > > > >
> > > > >  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> > > > >  {
> > > > > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/i=
nclude/uapi/asm/hwprobe.h
> > > > > index 9f2a8e3ff204..6614d3adfc75 100644
> > > > > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > > > > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > > > > @@ -1,6 +1,6 @@
> > > > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > >  /*
> > > > > - * Copyright 2023 Rivos, Inc
> > > > > + * Copyright 2023-2024 Rivos, Inc
> > > > >   */
> > > > >
> > > > >  #ifndef _UAPI_ASM_HWPROBE_H
> > > > > @@ -67,6 +67,14 @@ struct riscv_hwprobe {
> > > > >  #define                RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    (=
4 << 0)
> > > > >  #define                RISCV_HWPROBE_MISALIGNED_MASK           (=
7 << 0)
> > > > >  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> > > > > +/*
> > > > > + * It is not possible for one CPU to have multiple vendor ids, s=
o each vendor
> > > > > + * has its own vendor extension "namespace". The keys for each v=
endor starts
> > > > > + * at zero.
> > > > > + */
> > > > > +#define RISCV_HWPROBE_KEY_VENDOR_EXT_0 7
> > > > > + /* T-Head */
> > > > > +#define                RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR   (=
1 << 0)
> > > > >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> > > > >
> > > > >  /* Flags */
> > > > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/=
sys_hwprobe.c
> > > > > index e0a42c851511..365ce7380443 100644
> > > > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > > > @@ -69,7 +69,8 @@ static void hwprobe_isa_ext0(struct riscv_hwpro=
be *pair,
> > > > >         if (riscv_isa_extension_available(NULL, c))
> > > > >                 pair->value |=3D RISCV_HWPROBE_IMA_C;
> > > > >
> > > > > -       if (has_vector() && !riscv_has_vendor_extension_unlikely(=
RISCV_ISA_VENDOR_EXT_XTHEADVECTOR))
> > > > > +       if (has_vector() &&
> > > > > +           !__riscv_isa_vendor_extension_available(NULL, RISCV_I=
SA_VENDOR_EXT_XTHEADVECTOR))
> > > > >                 pair->value |=3D RISCV_HWPROBE_IMA_V;
> > > > >
> > > > >         /*
> > > > > @@ -112,7 +113,8 @@ static void hwprobe_isa_ext0(struct riscv_hwp=
robe *pair,
> > > > >                 EXT_KEY(ZACAS);
> > > > >                 EXT_KEY(ZICOND);
> > > > >
> > > > > -               if (has_vector() && !riscv_has_vendor_extension_u=
nlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> > > > > +               if (has_vector() &&
> > > > > +                   !riscv_has_vendor_extension_unlikely(RISCV_IS=
A_VENDOR_EXT_XTHEADVECTOR)) {
> > > > >                         EXT_KEY(ZVBB);
> > > > >                         EXT_KEY(ZVBC);
> > > > >                         EXT_KEY(ZVKB);
> > > > > @@ -139,6 +141,55 @@ static void hwprobe_isa_ext0(struct riscv_hw=
probe *pair,
> > > > >         pair->value &=3D ~missing;
> > > > >  }
> > > > >
> > > > > +static void hwprobe_isa_vendor_ext0(struct riscv_hwprobe *pair,
> > > > > +                                   const struct cpumask *cpus)
> > > > > +{
> > > > > +       int cpu;
> > > > > +       u64 missing =3D 0;
> > > > > +
> > > > > +       pair->value =3D 0;
> > > > > +
> > > > > +       struct riscv_hwprobe mvendorid =3D {
> > > > > +               .key =3D RISCV_HWPROBE_KEY_MVENDORID,
> > > > > +               .value =3D 0
> > > > > +       };
> > > > > +
> > > > > +       hwprobe_arch_id(&mvendorid, cpus);
> > > > > +
> > > > > +       /* Set value to zero if CPUs in the set do not have the s=
ame vendor. */
> > > > > +       if (mvendorid.value =3D=3D -1ULL)
> > > > > +               return;
> > > > > +
> > > > > +       /*
> > > > > +        * Loop through and record vendor extensions that 1) anyo=
ne has, and
> > > > > +        * 2) anyone doesn't have.
> > > > > +        */
> > > > > +       for_each_cpu(cpu, cpus) {
> > > > > +               struct riscv_isainfo *isavendorinfo =3D &hart_isa=
_vendor[cpu];
> > > > > +
> > > > > +#define VENDOR_EXT_KEY(ext)                                     =
                       \
> > > > > +       do {                                                     =
                       \
> > > > > +               if (__riscv_isa_vendor_extension_available(isaven=
dorinfo->isa,          \
> > > > > +                                                        RISCV_IS=
A_VENDOR_EXT_##ext))   \
> > > > > +                       pair->value |=3D RISCV_HWPROBE_VENDOR_EXT=
_##ext;                  \
> > > > > +               else                                             =
                       \
> > > > > +                       missing |=3D RISCV_HWPROBE_VENDOR_EXT_##e=
xt;                      \
> > > > > +       } while (false)
> > > > > +
> > > > > +       /*
> > > > > +        * Only use VENDOR_EXT_KEY() for extensions which can be =
exposed to userspace,
> > > > > +        * regardless of the kernel's configuration, as no other =
checks, besides
> > > > > +        * presence in the hart_vendor_isa bitmap, are made.
> > > > > +        */
> > > > > +       VENDOR_EXT_KEY(XTHEADVECTOR);
> > > > > +
> > > > > +#undef VENDOR_EXT_KEY
> > > >
> > > > Hey Charlie,
> > > > Thanks for writing this up! At the very least I think the
> > > > THEAD-specific stuff should probably end up in its own file, otherw=
ise
> > > > it'll get chaotic with vendors clamoring to add stuff right here.
> > >
> > > Great idea!
> > >
> > > > What do you think about this approach:
> > > >  * We leave RISCV_HWPROBE_MAX_KEY as the max key for the "generic
> > > > world", eg 6-ish
> > > >  * We define that any key above 0x8000000000000000 is in the vendor
> > > > space, so the meaning of the keys depends first on the mvendorid
> > > > value.
> > > >  * In the kernel code, each new vendor adds on to a global struct,
> > > > which might look something like:
> > > > struct hwprobe_vendor_space vendor_space[] =3D {
> > > >         {
> > > >                 .mvendorid =3D VENDOR_THEAD,
> > > >                 .max_hwprobe_key =3D THEAD_MAX_HWPROBE_KEY, // curr=
ently
> > > > 1 or 0x8000000000000001 with what you've got.
> > > >                 .hwprobe_fn =3D thead_hwprobe
> > > >         },
> > > >         ...
> > > > };
> > > >
> > > >  * A hwprobe_thead.c implements thead_hwprobe(), and is called
> > > > whenever the generic hwprobe encounters a key >=3D0x800000000000000=
0.
> > > >  * Generic code for setting up the VDSO can then still call the
> > > > vendor-specific hwprobe_fn() repeatedly with an "all CPUs" mask fro=
m
> > > > the base to max_hwprobe_key and set up the cached tables in userspa=
ce.
> > > >  * Since the VDSO data has limited space we may have to cap the num=
ber
> > > > of vendor keys we cache to be lower than max_hwprobe_key. Since the
> > > > data itself is not exposed to usermode we can raise this cap later =
if
> > > > needed.
> > >
> > > I know vendor extensions are kind of the "wild west" of riscv, but in
> > > spite of that I want to design a consistent API. The issue I had with
> > > having this "vendor space" for exposing vendor extensions was that th=
is
> > > is something that is inherently the same for all vendors. I see a ven=
dor
> > > space like this more applicable for something like
> > > "RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE" where a vendor has a specific
> > > value they would like to expose. I do agree that having a vendor spac=
e
> > > is a good design choice, but I am not convinced that vendor extension=
s
> > > are the proper use-case.
> > >
> > > By having RISCV_HWPROBE_KEY_VENDOR_EXT_0 we can expose the vendor
> > > extensions in the same way that standard extensions are exposed, with=
 a
> > > bitmask representing each extension. If these are instead in the vend=
or
> > > space, each vendor would probably be inclined to introduce a key like
> > > RISCV_HWPROBE_KEY_THEAD_EXT_0 that returns a bitmask of all of the th=
ead
> > > vendor extensions. This duplicated effort is what I am trying to avoi=
d.
> > > The alternative would be that vendors have a separate key for each
> > > vendor extension they would like to expose, but that is strictly less
> > > efficient than the existing bitmask probing.
> > >
> > > Do you think that having the vendor space is appropriate for vendor
> > > extensions given my concerns?
> >
> > I do see what you're going for. It's tidy for a bitmask to just let
> > anyone allocate the next bit, but leaves you with the same problem
> > when a vendor decides they want to expose an enum, or decides they
> > want to expose a bazillion things. I think a generalized version of
>
> This patch is strictly to expose if a vendor extension is supported,
> how does exposing enums factor in here?
>
> > the approach you've written would be: simply let vendors allocate keys
> > from the same global space we're already using. My worry was that it
>
> I am missing how my proposal suggests allowing vendors to allocate keys
> in a global space.
>
> > would turn into an expansive suburban sprawl of mostly dead bits, or
> > in the case of vendor-specific keys, full of "if (mvendor_id() !=3D
> > MINE) return 0;". My hope with the vendored keyspace is it would keep
>
> An application will always need to check vendorid before calling hwprobe
> with a vendor-specific feature? If that hwprobe support is a key above
> 1<<63, then the application will need to pass that vendor-specific key
> and interpret the vendor-specific value. If that hwprobe support is what
> I have proposed here, then the user calls the standardized vendor
> extension hwprobe endpoint and then needs to interpret the result based
> on the vendor of the cpumask. In both cases they need to check the
> vendorid of the cpumask. In the test case I added I failed to check the
> vendorid but I should have had that.
>
> > the sprawl from polluting the general array of (hopefully valuable)
> > info with stuff that's likely to become less relevant as time passes.
> > It also lowers the bar a bit to make it easier for vendors to expose
> > bits, as they don't consume global space for everyone for all of time,
> > just themselves.
>
> The vendor keys are tied directly to the vendor. So as it grows we would
> have something like:
>
> #define RISCV_HWPROBE_KEY_VENDOR_EXT_0  7
> /* T-Head */
> #define         RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR   (1 << 0)
> #define         RISCV_HWPROBE_VENDOR_EXT_XTHEAD2        (2 << 0)
> #define         RISCV_HWPROBE_VENDOR_EXT_XTHEAD3        (3 << 0)
> /* Vendor 2 */
> #define         RISCV_HWPROBE_VENDOR_EXT_XVENDOR1       (1 << 0)
> #define         RISCV_HWPROBE_VENDOR_EXT_XVENDOR2       (2 << 0)
> /* Vendor 3 */
> ...
>
> The keys overlap between vendors. To determine which extension a vendor
> supports, hwprobe gets data from hart_isa_vendor[cpu]. If the vendor is
> vendor 2, it is not possible for a vendor extension from vendor 3 to end
> up in there. Only the extensions from that vendor can be supported by
> that vendor's hardware.

Gotcha. You're right I had misinterpreted this, thinking XTHEADVECTOR
was a valid bit regardless of mvendorid, and that other vendors would
have to choose new bits for their features and always return 0 for
XTHEADVECTOR. With your explanation, it seems like you're allocating
keys (in no particular order) whose meaning will change based on
mvendorid.

I guess I'm still not convinced that saving each vendor from having to
add a VENDOR_EXT key in their keyspace is worth the sacrifice of
spraying the vendor-specific keys across the generic keyspace. Are
there advantages to having a single key whose category is similar but
whose bits are entirely vendor-defined? Maybe if I were userspace and
my feature could be satisfied equivalently by XTHEADVECTOR or
XRIVOSOTHERTHING, then I could do one hwprobe call instead of two? But
I don't think the vendors are going to be consistent enough for that
equivalency to ever prove useful. The advantages in my head of the
separate vendor keyspace are:
 * Keeps the kernel code simple: if key >=3D (1 >> 63)
vendor_config->do_hwprobe(), rather than having all these little calls
in each specific switch case for vendor_config->do_vendor_ext0(),
vendor_config->do_vendor_ext1(), etc.
 * It extends easily into passing other forms of vendor hwprobe info
later, rather than solving only the case of risc-v extensions now, and
then having to do this all again for each additional category of
vendor data.
 * Similarly, it discourages future vendors from trying to squint and
find a way to make a vaguely generic sounding category for their own
hwprobe key which will ultimately only ever be filled in by them
anyway.

-Evan

