Return-Path: <linux-kselftest+bounces-35686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B385AE6508
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 14:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF1F4A4ED6
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB7291C31;
	Tue, 24 Jun 2025 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu9htEvB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9F289E1B;
	Tue, 24 Jun 2025 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768286; cv=none; b=CF91aJM9eoAtj7S5DwK8poP9aWiO2G0Jm2Eo1n2OGwAZKgtCaggTejQ5IVRhQRQVrC0CI/bRs/uPlwM45xhdre195LNxAyHYJ1r4zuZcSpPrT8H++5Xg6B0eaNVpt2yFUbz9JJwwM3XLSgtEuo215tDsMwKoYHqKSpRzYGhR990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768286; c=relaxed/simple;
	bh=A1vlO/L1VKH8WOeSv/ouj3ncracjwzpEiurRYiS/ALg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHpbbJp1/bWy7Kw08U3o1KmEOGioMOByrf7E1WLg1Mnk327tQ2rRBfuuW2Qn7vTzcdO2oFn7NUucwjZdiAtkbsGKy3JgE0OO8lS5l7wLL6zbirQaV3HUYtHxH+MooueTQBBst0HzFOIxujZiYMqvOz8s5zsZXTXx+3e6vEBCCNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu9htEvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B39C4CEF3;
	Tue, 24 Jun 2025 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750768286;
	bh=A1vlO/L1VKH8WOeSv/ouj3ncracjwzpEiurRYiS/ALg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eu9htEvBiVbL44j/hDA/XL5IHMVRkTjREoK+yoJofVs3i2H7zYeWM4nuOEa8lvA1q
	 draOJBWRmasaODlA4846qtfnrHoWcfrlpN7SdkOAt9CRDuKgz+Jijdfb0hME3v4zjT
	 vySbdesGJCidQHCf0M229vamBtjKXpnwatmAh49jUKp+nVNq+/QlhEUFGI/3hC6dpM
	 MBpiZpEieyvMUEHttV5HVCNFcwOz97BYbHpUnESxPT0XUV2ac4VY/kC4HNi3iT2U1C
	 nndDqpkUc6Rj2nldXF12iLWnmS6e5StbWpsEaS9jarXC/+el4cuLLpnkbs9yytEYsC
	 jjsFUJ19nZmUg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso769442a12.1;
        Tue, 24 Jun 2025 05:31:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIcBidubsUjr6GvP7f8421F8eC99nNi6qungSKTQM8pINmHk0ZFQw9RZuYj1FBx0HXJrFF3WY3Rotkx7e7@vger.kernel.org, AJvYcCUQZWnOTjCK2ItJvAeXFGpEn1wxgj+j7S3FaXb6FQWYwU4dhdbpvxOzHlLl1i2fpKNkBz0CHKkYXuM=@vger.kernel.org, AJvYcCVSnuJEYLz/GTL/Zt2wX6i8PbgDhcFQMKVvxqYQ9uKexcFTe4i2J5X9OE+QgjnqUXcCZ4Kr6BRLz/+w@vger.kernel.org, AJvYcCWfiTkex+f0MQn2Z3APHWJVp4HQPyHwHt4AGxv8/eCTD/Wh1tFfHarKKtWaIToUdgxBNH2xPZeVU+3DSQ==@vger.kernel.org, AJvYcCWioFj6dnpN+JivFYoas3pOlccQAJKDOtuz5crs2yTlM1t+seJTOz1ZTStM7uqQuJe3SwUJfStDO/trpVnwdOVG@vger.kernel.org, AJvYcCWjTrlomDwlBvZDpD+VWRgwmHhauJOez08kLDWR4/qlguDkO5nrNIV/nfXepGNh0ToK7Hez1v1ORB4YQQ==@vger.kernel.org, AJvYcCWkytK29gf2ZbYEOocH8bXuAPQ/UqBhE3WfKgyHkJCw6Bx1pmxGYIRJmSGiOfFXKWjatwVCMqjN1iruvkoSA2qz@vger.kernel.org, AJvYcCWwjMBDeub9j3awBbNGpJtyGIYzMVCfPwbN2Qb/7+cx5Pr16kamrB+C4ldq33XDCUihDqLrQVsWyCfqWvHQ@vger.kernel.org, AJvYcCXeEP3m9siA10DxTLOpTz8vc5wuJKop878SjR+iKM+WruZTu8Go8JcteBM33w5C6Oj8RMYc8u0iVfd4p07d+JQLfF/WEmsR@vger.kernel.org
X-Gm-Message-State: AOJu0YwpG8YkBHYF8id6pnhc+2Rp05WERXknvveD5uYetID7V6bxhC+N
	Ua0WPE2J9qre0HTAgZiSjYgdnmdP8M5x1lTQ9Vh5Rd6razi/cuq/AcCKQfndyTcPCVm7Il4K96q
	gutnGDt0/tyS+RYnSVUVTaKVcGSIANGE=
X-Google-Smtp-Source: AGHT+IG78TOJtNBgPo6KUbppTtQyUVPXosqjkC+mjKzFM6GuMzZpIE/4mn6DMDsxVG8gc/mo29CZZDSg4K3moyGLako=
X-Received: by 2002:a50:9e07:0:b0:607:5987:5ba1 with SMTP id
 4fb4d7f45d1cf-60a1d1676eamr10402408a12.20.1750768284578; Tue, 24 Jun 2025
 05:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523043251.it.550-kees@kernel.org> <20250523043935.2009972-10-kees@kernel.org>
 <CAAhV-H4WxAwXTYVFOnphgHN80-_6jt77YZ_rw-sOBoBjjiN-yQ@mail.gmail.com>
In-Reply-To: <CAAhV-H4WxAwXTYVFOnphgHN80-_6jt77YZ_rw-sOBoBjjiN-yQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 24 Jun 2025 20:31:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5oHPG+etNawAmVwyDtg80iKUrAM_m3Vj57bBO0scHqvQ@mail.gmail.com>
X-Gm-Features: AX0GCFsgXJm0uAqj4ZcBCmgCp5XFBS8cfA5fjKZVFWrLP2ySZYpAIUKeGDxIJgs
Message-ID: <CAAhV-H5oHPG+etNawAmVwyDtg80iKUrAM_m3Vj57bBO0scHqvQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] loongarch: Handle KCOV __init vs inline mismatches
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Gleixner <tglx@linutronix.de>, Tianyang Zhang <zhangtianyang@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christoph Hellwig <hch@lst.de>, Marco Elver <elver@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Kees,

On Thu, Jun 19, 2025 at 4:55=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Kees,
>
> On Fri, May 23, 2025 at 12:39=E2=80=AFPM Kees Cook <kees@kernel.org> wrot=
e:
> >
> > When KCOV is enabled all functions get instrumented, unless
> > the __no_sanitize_coverage attribute is used. To prepare for
> > __no_sanitize_coverage being applied to __init functions, we have to
> > handle differences in how GCC's inline optimizations get resolved. For
> > loongarch this exposed several places where __init annotations were
> > missing but ended up being "accidentally correct". Fix these cases and
> > force one function to be inline with __always_inline.
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Huacai Chen <chenhuacai@kernel.org>
> > Cc: WANG Xuerui <kernel@xen0n.name>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Tianyang Zhang <zhangtianyang@loongson.cn>
> > Cc: Bibo Mao <maobibo@loongson.cn>
> > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Cc: <loongarch@lists.linux.dev>
> > ---
> >  arch/loongarch/include/asm/smp.h | 2 +-
> >  arch/loongarch/kernel/time.c     | 2 +-
> >  arch/loongarch/mm/ioremap.c      | 4 ++--
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/=
asm/smp.h
> > index ad0bd234a0f1..88e19d8a11f4 100644
> > --- a/arch/loongarch/include/asm/smp.h
> > +++ b/arch/loongarch/include/asm/smp.h
> > @@ -39,7 +39,7 @@ int loongson_cpu_disable(void);
> >  void loongson_cpu_die(unsigned int cpu);
> >  #endif
> >
> > -static inline void plat_smp_setup(void)
> > +static __always_inline void plat_smp_setup(void)
> Similar to x86 and arm, I prefer to mark it as __init rather than
> __always_inline.
If you have no objections, I will apply this patch with the above modificat=
ion.


Huacai

>
> Huacai
>
> >  {
> >         loongson_smp_setup();
> >  }
> > diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.=
c
> > index bc75a3a69fc8..367906b10f81 100644
> > --- a/arch/loongarch/kernel/time.c
> > +++ b/arch/loongarch/kernel/time.c
> > @@ -102,7 +102,7 @@ static int constant_timer_next_event(unsigned long =
delta, struct clock_event_dev
> >         return 0;
> >  }
> >
> > -static unsigned long __init get_loops_per_jiffy(void)
> > +static unsigned long get_loops_per_jiffy(void)
> >  {
> >         unsigned long lpj =3D (unsigned long)const_clock_freq;
> >
> > diff --git a/arch/loongarch/mm/ioremap.c b/arch/loongarch/mm/ioremap.c
> > index 70ca73019811..df949a3d0f34 100644
> > --- a/arch/loongarch/mm/ioremap.c
> > +++ b/arch/loongarch/mm/ioremap.c
> > @@ -16,12 +16,12 @@ void __init early_iounmap(void __iomem *addr, unsig=
ned long size)
> >
> >  }
> >
> > -void *early_memremap_ro(resource_size_t phys_addr, unsigned long size)
> > +void * __init early_memremap_ro(resource_size_t phys_addr, unsigned lo=
ng size)
> >  {
> >         return early_memremap(phys_addr, size);
> >  }
> >
> > -void *early_memremap_prot(resource_size_t phys_addr, unsigned long siz=
e,
> > +void * __init early_memremap_prot(resource_size_t phys_addr, unsigned =
long size,
> >                     unsigned long prot_val)
> >  {
> >         return early_memremap(phys_addr, size);
> > --
> > 2.34.1
> >

