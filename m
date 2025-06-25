Return-Path: <linux-kselftest+bounces-35723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DECAE7413
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 03:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD857A9648
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 01:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CB713D53B;
	Wed, 25 Jun 2025 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="si3Mv9bY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2472AD58;
	Wed, 25 Jun 2025 01:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750813757; cv=none; b=YfbjfnCbhUHL5kQrj8xgS5x0DIyWhhVbGI2r48aDF1QWXvRfaBJLE0qhdJIHzpY1Ica2isWjyiCNOUxbTdtAAdFoXfyg8LqaCiQdSc/pwwiJQ2W/L19BiKYTUQYfqH3hOo0TL2nci6Wwv+KMH2xdNSelMezmrMaAo7jMYJNd1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750813757; c=relaxed/simple;
	bh=ar+M7uOS6NGMBXnGsSfhmdY2/NIrFzzFwB2vQ2UdzzU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Lqkw544z7nEnHYzbIOoMDtLajewAAV6RVrA7tDGQIOxWtcHK+kuLIn2j5w49sDUwlY2fCCaAkXRrufDWM5+1fUlgrmkCoJAkav6C/qgM142QAEVwLSQ9P9He8RAMJBXXqkUtLot5U/m+ZfFjCq/TFqEb325RvAZrTecsNXhdw7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=si3Mv9bY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5E3C4CEE3;
	Wed, 25 Jun 2025 01:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750813756;
	bh=ar+M7uOS6NGMBXnGsSfhmdY2/NIrFzzFwB2vQ2UdzzU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=si3Mv9bYY/8kBwTkVAcQqZoJK6oPCfQbERzoeHQNnnjouaaju9cDPj5M/XH+LGCGf
	 sutZ2TLPTDRMtEiUcTLAfcucjlB1tBOK027s1ZYe+qpQm8YtBXVVCggwf2H8yIixe+
	 IDVtaRLnE7OYk8omFmO1wVvMArdpG+qU6ghcCXqwDH3eSeR/zt8PJr47crwpodU4K/
	 +SdYth5GpIqN7Rkz05vHh/vtCMrcnD2wmTD+63kR8qXgeUEYggdfeNmyLdKPgxxZY0
	 Z7hF7LuReE6Xw0PlrdhJ4M022p1QhH6fci9WuRh8Uql2D6xK1hPUmyC7uoJ+Q8UvXd
	 gbu4rtou3gcJw==
Date: Tue, 24 Jun 2025 18:09:18 -0700
From: Kees Cook <kees@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Gleixner <tglx@linutronix.de>,
 Tianyang Zhang <zhangtianyang@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 sparclinux@vger.kernel.org, llvm@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_10/14=5D_loongarch=3A_Han?=
 =?US-ASCII?Q?dle_KCOV_=5F=5Finit_vs_inline_mismatches?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAAhV-H5oHPG+etNawAmVwyDtg80iKUrAM_m3Vj57bBO0scHqvQ@mail.gmail.com>
References: <20250523043251.it.550-kees@kernel.org> <20250523043935.2009972-10-kees@kernel.org> <CAAhV-H4WxAwXTYVFOnphgHN80-_6jt77YZ_rw-sOBoBjjiN-yQ@mail.gmail.com> <CAAhV-H5oHPG+etNawAmVwyDtg80iKUrAM_m3Vj57bBO0scHqvQ@mail.gmail.com>
Message-ID: <B5A11282-CB0E-46E0-A5D7-EF4D8BFC23B4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 24, 2025 5:31:12 AM PDT, Huacai Chen <chenhuacai@kernel=2Eorg> wro=
te:
>Hi, Kees,
>
>On Thu, Jun 19, 2025 at 4:55=E2=80=AFPM Huacai Chen <chenhuacai@kernel=2E=
org> wrote:
>>
>> Hi, Kees,
>>
>> On Fri, May 23, 2025 at 12:39=E2=80=AFPM Kees Cook <kees@kernel=2Eorg> =
wrote:
>> >
>> > When KCOV is enabled all functions get instrumented, unless
>> > the __no_sanitize_coverage attribute is used=2E To prepare for
>> > __no_sanitize_coverage being applied to __init functions, we have to
>> > handle differences in how GCC's inline optimizations get resolved=2E =
For
>> > loongarch this exposed several places where __init annotations were
>> > missing but ended up being "accidentally correct"=2E Fix these cases =
and
>> > force one function to be inline with __always_inline=2E
>> >
>> > Signed-off-by: Kees Cook <kees@kernel=2Eorg>
>> > ---
>> > Cc: Huacai Chen <chenhuacai@kernel=2Eorg>
>> > Cc: WANG Xuerui <kernel@xen0n=2Ename>
>> > Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>> > Cc: Tianyang Zhang <zhangtianyang@loongson=2Ecn>
>> > Cc: Bibo Mao <maobibo@loongson=2Ecn>
>> > Cc: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>> > Cc: <loongarch@lists=2Elinux=2Edev>
>> > ---
>> >  arch/loongarch/include/asm/smp=2Eh | 2 +-
>> >  arch/loongarch/kernel/time=2Ec     | 2 +-
>> >  arch/loongarch/mm/ioremap=2Ec      | 4 ++--
>> >  3 files changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/loongarch/include/asm/smp=2Eh b/arch/loongarch/incl=
ude/asm/smp=2Eh
>> > index ad0bd234a0f1=2E=2E88e19d8a11f4 100644
>> > --- a/arch/loongarch/include/asm/smp=2Eh
>> > +++ b/arch/loongarch/include/asm/smp=2Eh
>> > @@ -39,7 +39,7 @@ int loongson_cpu_disable(void);
>> >  void loongson_cpu_die(unsigned int cpu);
>> >  #endif
>> >
>> > -static inline void plat_smp_setup(void)
>> > +static __always_inline void plat_smp_setup(void)
>> Similar to x86 and arm, I prefer to mark it as __init rather than
>> __always_inline=2E
>If you have no objections, I will apply this patch with the above modific=
ation=2E

That's fine by me; thank you! I didn't have a chance yet to verify that it=
 actually fixes the mismatches I saw, but if it looks good to you, yes plea=
se=2E :)

-Kees

>
>
>Huacai
>
>>
>> Huacai
>>
>> >  {
>> >         loongson_smp_setup();
>> >  }
>> > diff --git a/arch/loongarch/kernel/time=2Ec b/arch/loongarch/kernel/t=
ime=2Ec
>> > index bc75a3a69fc8=2E=2E367906b10f81 100644
>> > --- a/arch/loongarch/kernel/time=2Ec
>> > +++ b/arch/loongarch/kernel/time=2Ec
>> > @@ -102,7 +102,7 @@ static int constant_timer_next_event(unsigned lon=
g delta, struct clock_event_dev
>> >         return 0;
>> >  }
>> >
>> > -static unsigned long __init get_loops_per_jiffy(void)
>> > +static unsigned long get_loops_per_jiffy(void)
>> >  {
>> >         unsigned long lpj =3D (unsigned long)const_clock_freq;
>> >
>> > diff --git a/arch/loongarch/mm/ioremap=2Ec b/arch/loongarch/mm/iorema=
p=2Ec
>> > index 70ca73019811=2E=2Edf949a3d0f34 100644
>> > --- a/arch/loongarch/mm/ioremap=2Ec
>> > +++ b/arch/loongarch/mm/ioremap=2Ec
>> > @@ -16,12 +16,12 @@ void __init early_iounmap(void __iomem *addr, uns=
igned long size)
>> >
>> >  }
>> >
>> > -void *early_memremap_ro(resource_size_t phys_addr, unsigned long siz=
e)
>> > +void * __init early_memremap_ro(resource_size_t phys_addr, unsigned =
long size)
>> >  {
>> >         return early_memremap(phys_addr, size);
>> >  }
>> >
>> > -void *early_memremap_prot(resource_size_t phys_addr, unsigned long s=
ize,
>> > +void * __init early_memremap_prot(resource_size_t phys_addr, unsigne=
d long size,
>> >                     unsigned long prot_val)
>> >  {
>> >         return early_memremap(phys_addr, size);
>> > --
>> > 2=2E34=2E1
>> >

--=20
Kees Cook

