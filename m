Return-Path: <linux-kselftest+bounces-35347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C774BAE0098
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 10:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662494A06BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA34B26563C;
	Thu, 19 Jun 2025 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiG8+DpI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2825D549;
	Thu, 19 Jun 2025 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323361; cv=none; b=jpvVQa36m73X6ttdAygDSK9MyuABNQWLlGSw1A8SPGqq1S9i7iA72rC5CtNSX/QfnUhGYBm54BHKX+l/txjkch8d8ydKvBpVCV5hR5uudRJJ5UwLabG/xvQ6W+Dj9CIPORQdAiRrPwox3BdVZ9HowhOSImqcrpGlVMgwoAgR1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323361; c=relaxed/simple;
	bh=GY39qewCO8ZjeGeZxUohtkWS54SrNUfyybjbm7an5Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqnBAczf8osqgsPn2gKeN69wArhh2/+PZ1oQQxjivitUnqx9BszsRQu8FD+z2DvRQn6WbuOT+1HmZgCWRQMUBbJ+s/reZkEAVEGKqi95s8wk94H3876qqo8tUayQQ4kNlvLP3j+lc0COe3Lm7IE2AeM41t2NiSn2rNgs9GHUUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiG8+DpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A744C4CEEA;
	Thu, 19 Jun 2025 08:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323361;
	bh=GY39qewCO8ZjeGeZxUohtkWS54SrNUfyybjbm7an5Kw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BiG8+DpI8qK/7ehh9mHlWcIBDcd2aW6L5zsdQwFfDHxAQzkw3wpYWGPQ6B8QAPH9D
	 y3g3vBeuapW2jbg7F3C0+1XUsLnDTo/NVZBstotfSykAdmedcEkBtU7uK0/NAe+wSt
	 Kc+Lun055qORQz7b1mmMomPpcYDq76KH/YewkrSM0s4AR/fntnE2c+ZQiv3ylk6uFy
	 YMe89/7ZUy5WBvyLmptPtHixT5axCELqsF3d08SoPQsMs39mRobfTX8/5lFJkTd5Ag
	 2mulMGlFaIN9bMOa0eo2qBME6/JU5n//r22rEhdAHA56YcfKfLRjdPIb6YPhoPnwm1
	 xxs6mMfeLDs3A==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6071ac9dc3eso846001a12.1;
        Thu, 19 Jun 2025 01:56:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHCkYMNw1BRTfnipAKau+57hCg6VfNnm33RULilbHOelSimGu7C9uEGZUW2F0Eig/ZlLAQWRqoKCI=@vger.kernel.org, AJvYcCUYHQlwDv8Nw267gHoMyU7XzCZhrLMQzn2w/rbH8ds2fDjD5Pg0r8zhJVp+qANqGJKqtfuT0yrDhLyOW+Fz@vger.kernel.org, AJvYcCUhtcaV4+1E5jIngF99oZe9W29MGgHZoXmUhueWcLZ1ZJF75rni+ODJrcJ3KGZcSXJpmbmc9aQQFYLHtF6CEaRH@vger.kernel.org, AJvYcCV87h/6ovZXIboDRd1TZGf7nsv2rvalW35DkYiOnJX1ExUtp89Ks28GnBoVf5JRM/5ZG7Gs9VuNiqva@vger.kernel.org, AJvYcCVpqGrCnN/Ti5ysP1DaXikAUo0fh4ZDjMhj92i1QKnT/fbTrHo/3jIwg9dVyUuzGH9LHMRqcf9WY9udF09gjLsn@vger.kernel.org, AJvYcCVveexRyt7YB4FS4dPVQBYx+13Q7Y/NXwxofIhpfCWkK9zPdDCkSPyI+VSaa8wDeRlhAYiWpq4TvRnaKw==@vger.kernel.org, AJvYcCWIJtizXqVvcHCLgTkPfLGLYrNsCghzr8Bw9/P/WuMYoYLLdu1XbSUkFx1h7cirlFB4eZ5Q81j9NVpOHdfc3L1J+AeFsDCi@vger.kernel.org, AJvYcCXVK4NWJfsCLMaDacHwC5WyphIGb+/LH3IW+23ZmVzPhFaTneUrchaHKSPRG2OCSKuVQ7065Wfoodf71XJd@vger.kernel.org, AJvYcCXkwwwKsfiJaidb2cWHNVl4pV/FAyLTI+QymCdkzLzDJi2sG7WpbJUpFVPRVtOzU2ay6wr4KJGPq0+IXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvWPy9Wk0XYWzxt5k5naeASDm6On/ZbhdW+OkvGHt/iSB7Az9o
	0xu+ZuaByB6Y65eZ4CiyNH15EcM3SmWkIjJyDxjlUwbN7lzcL7dqtoV078TkRBD0nuqPhUe815o
	ksPFrkWRk4H5O7hUGvFw0iBi/nw7yfNA=
X-Google-Smtp-Source: AGHT+IHshgFBjrE/bznWO4e6lyy0nq5bnj0JFcjbPNAIZZpdv6svyHpe5+Z0ZAFZ4cpQ+FvgAbwAckAC6VQE1xAS01s=
X-Received: by 2002:a05:6402:26cc:b0:607:16b1:7489 with SMTP id
 4fb4d7f45d1cf-608d094801bmr19223662a12.20.1750323359751; Thu, 19 Jun 2025
 01:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523043251.it.550-kees@kernel.org> <20250523043935.2009972-10-kees@kernel.org>
In-Reply-To: <20250523043935.2009972-10-kees@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 19 Jun 2025 16:55:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4WxAwXTYVFOnphgHN80-_6jt77YZ_rw-sOBoBjjiN-yQ@mail.gmail.com>
X-Gm-Features: AX0GCFvInY5DbmRkbwxLo6Cb2clGLakUsQ51xQCaa7Coc4b_DkkyTMX5tkJkYVA
Message-ID: <CAAhV-H4WxAwXTYVFOnphgHN80-_6jt77YZ_rw-sOBoBjjiN-yQ@mail.gmail.com>
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

On Fri, May 23, 2025 at 12:39=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> When KCOV is enabled all functions get instrumented, unless
> the __no_sanitize_coverage attribute is used. To prepare for
> __no_sanitize_coverage being applied to __init functions, we have to
> handle differences in how GCC's inline optimizations get resolved. For
> loongarch this exposed several places where __init annotations were
> missing but ended up being "accidentally correct". Fix these cases and
> force one function to be inline with __always_inline.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tianyang Zhang <zhangtianyang@loongson.cn>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: <loongarch@lists.linux.dev>
> ---
>  arch/loongarch/include/asm/smp.h | 2 +-
>  arch/loongarch/kernel/time.c     | 2 +-
>  arch/loongarch/mm/ioremap.c      | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/as=
m/smp.h
> index ad0bd234a0f1..88e19d8a11f4 100644
> --- a/arch/loongarch/include/asm/smp.h
> +++ b/arch/loongarch/include/asm/smp.h
> @@ -39,7 +39,7 @@ int loongson_cpu_disable(void);
>  void loongson_cpu_die(unsigned int cpu);
>  #endif
>
> -static inline void plat_smp_setup(void)
> +static __always_inline void plat_smp_setup(void)
Similar to x86 and arm, I prefer to mark it as __init rather than
__always_inline.

Huacai

>  {
>         loongson_smp_setup();
>  }
> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
> index bc75a3a69fc8..367906b10f81 100644
> --- a/arch/loongarch/kernel/time.c
> +++ b/arch/loongarch/kernel/time.c
> @@ -102,7 +102,7 @@ static int constant_timer_next_event(unsigned long de=
lta, struct clock_event_dev
>         return 0;
>  }
>
> -static unsigned long __init get_loops_per_jiffy(void)
> +static unsigned long get_loops_per_jiffy(void)
>  {
>         unsigned long lpj =3D (unsigned long)const_clock_freq;
>
> diff --git a/arch/loongarch/mm/ioremap.c b/arch/loongarch/mm/ioremap.c
> index 70ca73019811..df949a3d0f34 100644
> --- a/arch/loongarch/mm/ioremap.c
> +++ b/arch/loongarch/mm/ioremap.c
> @@ -16,12 +16,12 @@ void __init early_iounmap(void __iomem *addr, unsigne=
d long size)
>
>  }
>
> -void *early_memremap_ro(resource_size_t phys_addr, unsigned long size)
> +void * __init early_memremap_ro(resource_size_t phys_addr, unsigned long=
 size)
>  {
>         return early_memremap(phys_addr, size);
>  }
>
> -void *early_memremap_prot(resource_size_t phys_addr, unsigned long size,
> +void * __init early_memremap_prot(resource_size_t phys_addr, unsigned lo=
ng size,
>                     unsigned long prot_val)
>  {
>         return early_memremap(phys_addr, size);
> --
> 2.34.1
>

