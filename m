Return-Path: <linux-kselftest+bounces-35346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D7AE008E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 10:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAED017FD99
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232AD200127;
	Thu, 19 Jun 2025 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2FgroRg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75382580FB;
	Thu, 19 Jun 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323328; cv=none; b=rMiXixkd52jf0WjtiH0PGgedRh1G3m5ilIEJi4kZm0+YH4UkvKmznG69+CHP3He0HOG+svyfyclk6uYNIMZhAW+0VKjSfZBLg+6URNq7T4IDVqVzbUFIhEkIK4SBN2Taj/lHaGI8YaThWniiMVE2UBAQwDUzoAGNMfwDel1j6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323328; c=relaxed/simple;
	bh=eQADuGSiL41NAxGl9NK+UhkSlVn0yTQBhyaUTND5Uzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxrIHLlHwSCL1MSXs+zZ+V6xp2wSUNgOo6rC8sEVFU2vvtfD8wGzidr61eEwNRwEIamLqZet9ug/8YsCqa47t/+oaKRdoAvPukrwJoQ8Kpskk80KnB/EY4VpjoASPGzVRuc9bYtFFGevVM54JyPOW3Gg3UJY1UoM28gEp1wmT1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2FgroRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F51C4CEF3;
	Thu, 19 Jun 2025 08:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323327;
	bh=eQADuGSiL41NAxGl9NK+UhkSlVn0yTQBhyaUTND5Uzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p2FgroRg8XpbJ/VSjtfLXHjJJRjKYpLj2XcaUHKG2xLQ7wfM+Z5n3rCjl6c8Zto5M
	 RSqSwjDobL8Uw3UNbEgelKH8UpaKTaToYX2CC3EHc2vsE2pdmJDyKlBWw+TMDnneAR
	 zMJQDoEg8twbtA3I11UyCenEImVZ9sO7oElSKq/lIdyVHdbSV7Rl1uy4I9OtVCIJ1L
	 xY4b7NmVNhx3/G6psbDY7j5hAeSUhrVg2Gh8rwAs7zI7pjkVGSiXnOiYqIeGf09brb
	 UZTFESwD6c+51mkUr6sZ7eCO2jWacLftMDJ3IO+VCTUTYL9SrpXOCd2q9ivlu3Pq39
	 P3TSZ4nA1tZBA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso962775a12.2;
        Thu, 19 Jun 2025 01:55:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/GY9u/H6VmWYLvDF+tqQ6wvs4cQ80fpYCXLxpaeI3/hKLjPWaslAawPzcZv8FhbhaTHXqy2CVGxgUmg==@vger.kernel.org, AJvYcCUC7SLy1By2jbdrPLjrpds1xYDCeo4uSWgeDuKoCGrFN88IBz0opkL7rgdyTjdu6qVaje0nxVN2pqqP@vger.kernel.org, AJvYcCUa7Efc35Q8WkGsD2U4bCGoecJW/ptZTk39ref5CTSfW++U6zvqcFPlHuJpjvbY/a8eD4oWh3rp/qY7y+OEJxeBctA/Dt2d@vger.kernel.org, AJvYcCVjDX2VwfRuG5SxxnGpf5KC7Th8S4ZkJMhGPKBQqTAOByeqmHLWZvVAEFKQt4ygXHiI8aQ9jG5oWXcrmmuH@vger.kernel.org, AJvYcCW+tx0F01bmFzPlRq1s//0vymuMtR05zWZopJxI/dVAq8QgCfpLxVIDL2fCwcAEz/s21z9kDMM7AodgJA==@vger.kernel.org, AJvYcCWqAx+nfZcjxDIAjro9EdY9VtDv9Vo9k8YxKWYkMQGhLnpFFTQM5aVyNYHvqOxsl0bAya0Smo4HJuA=@vger.kernel.org, AJvYcCX73FZOQpOzdf9Hp5i4AYdcM99rSDTfOkO87rkzetCbweNzxNf3eKMm79ycetHQF9cuKgIQfepr0NTAfQ==@vger.kernel.org, AJvYcCXUjuJgbxjol0jB6YrOeiJbQ/EtotBa3LL1C4QzpqdW1wi+ArpGdxkeNLrBTJtcSjV3blfY5lmHKm8B2CXdAu/j@vger.kernel.org, AJvYcCXwvFMpnHmADqS7bqjBEL0UKfL5f5WhEOrViDiJQ3UB6JKdkqVAiubUnHinNAnpqgbcGOJnQIuV5wnoimDC@vger.kernel.org, AJvYcCXx
 5NT+KRx0hNKE7eB4CPymUiA8EmK/2CrHXe+kQF+v5B+RVODIZVFTK73fUmYhLST2j6NM06Sg4s3i46U7DP/Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxntaGQ75cR2XT/KtiUEmUR6viMHpLHP+8ZBQ7dY8DNbCcsqVrI
	CYr2glOimARwgCo6YYRC0tbgQ26zh/a93zRRAX4O4WnRQgWhdNq0pGl7dr3JC8orL2Cqe4djh5e
	IdJf2tXvt2ESnC34dgslpqJ2En4YygkA=
X-Google-Smtp-Source: AGHT+IFe63NPmdC9P72cDlyX2WP9si/cWhn+2uqDCCs1dQMO/+ouBJs4HCM0Kl1RCgdHuztVjrD3QGSEtvvPoh/cEAU=
X-Received: by 2002:a05:6402:50d2:b0:607:6057:9006 with SMTP id
 4fb4d7f45d1cf-608d08f7a70mr18716524a12.8.1750323325929; Thu, 19 Jun 2025
 01:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523043251.it.550-kees@kernel.org> <20250523043935.2009972-9-kees@kernel.org>
In-Reply-To: <20250523043935.2009972-9-kees@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 19 Jun 2025 16:55:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4rFt3J6hD-eiNN5nihNR0cwMxPJQpq8LQWkx4km428og@mail.gmail.com>
X-Gm-Features: AX0GCFtBM3K8OeK1JL3sld-cpEWi3kLQAET9w-cyksCMv2tJ5SCZdduevj4T0cU
Message-ID: <CAAhV-H4rFt3J6hD-eiNN5nihNR0cwMxPJQpq8LQWkx4km428og@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] mips: Handle KCOV __init vs inline mismatches
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
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

On Fri, May 23, 2025 at 12:41=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> When KCOV is enabled all functions get instrumented, unless
> the __no_sanitize_coverage attribute is used. To prepare for
> __no_sanitize_coverage being applied to __init functions, we have to
> handle differences in how GCC's inline optimizations get resolved. For
> mips this requires forcing a function to be inline with __always_inline.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: <linux-mips@vger.kernel.org>
> ---
>  arch/mips/include/asm/time.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
> index e855a3611d92..044cff0e0764 100644
> --- a/arch/mips/include/asm/time.h
> +++ b/arch/mips/include/asm/time.h
> @@ -55,7 +55,7 @@ static inline int mips_clockevent_init(void)
>   */
>  extern int init_r4k_clocksource(void);
>
> -static inline int init_mips_clocksource(void)
> +static __always_inline int init_mips_clocksource(void)
Similar to x86 and arm, I prefer to mark it as __init rather than
__always_inline.

Huacai

>  {
>  #ifdef CONFIG_CSRC_R4K
>         return init_r4k_clocksource();
> --
> 2.34.1
>
>

