Return-Path: <linux-kselftest+bounces-37553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37796B09F09
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 11:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C089C1C47F96
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8F1295D96;
	Fri, 18 Jul 2025 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upUCLIdr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A111E5B78;
	Fri, 18 Jul 2025 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830296; cv=none; b=ueIBKhxETet13/O0JaXx4rHoN6bhxSBHQeuE1fVw2qkgikiwlL7Zp3UQHUdjnHzgSaGDaXmWDBQ+N9p9EAEnDKE4/ikJS/sekO3Iybw2GnNJjnch8DEE5fvCCuId1nbxhv8mIja29JFJ4s1q+NkBDHLxjrLEeG2IZ72W+3AdZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830296; c=relaxed/simple;
	bh=iN0MjV8lG6vlPY6QKWEDWqXP3y58juMGr+peNv9I/+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYWM+8wuerHdH4uclnn1P1V5B4lZzQfsfVzWPL2PAAUp0bevycDJ0BfbUxPdhLOH2vsQY9xeX3tR5m4Fu9z+H+Lv+GF9K3uWkRaULer50Q9VxA97mpxISj78zZsqA1VxBaZJlx+hY5d9f9Z/2Lgbw+1REBz49VboqjwgiFtneMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upUCLIdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191D5C4CEF0;
	Fri, 18 Jul 2025 09:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752830296;
	bh=iN0MjV8lG6vlPY6QKWEDWqXP3y58juMGr+peNv9I/+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=upUCLIdrbbvEbKjUsZgTdUEGyRbXXPVKgUMJXI8oVEu7IuCo+NlAr8pZ3hP/3OpCS
	 z+m8WoLkMvYdx42mseDFgent82TIUAOPaXDuO0MHrSBPWaortApspXcggf+7lhNmY8
	 tOaGg0j7eaXiZqMy8OhhL3BAvuI4qqptGCOW5qdmQyljlx4c3DuNukqLAdC4airAsq
	 nJKi0Be3SrrR2xHh9RGmjhMqPl6sRDW75QEF/7Lu21+PwIinNh5ZPzzmyUHWJMe6cp
	 dzghcLYsnfaa3tVtbk0VeArOxbSMW6EX7TzfWbBD0ifZlVbF7q2+xGG6ugEJd7zFXx
	 5DD1NmgbOVSgg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso3330368a12.0;
        Fri, 18 Jul 2025 02:18:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0AKoUIuonJeWHXWR2Cf7jQZCRjErGiIBNVCjuW0tpqJD3VWWQANTownXAYV244/9x+GvGSnXz7RM=@vger.kernel.org, AJvYcCV1TzUiHaDkQFdVridp0GhxD2QtBGx6xg0Lr3SAHadBj8NveE8r0J+4KYw8N9NpbhNp0K9s8iPNyi/xFTtJ@vger.kernel.org, AJvYcCV2RECSTJAxpYbYkY1rF1Lmt4kB3iosuDgXE19K1ASc8SE6fNRcv92tm/AHUzPKsA8+5FB65qL3NxnsoeKoZUx8@vger.kernel.org, AJvYcCV2fhkW998v5WZH4nLwEFwnzJO9W7r645GdDIgGB3cHzpXmDvZBGe03Upj0r4vlUbk44Oh0fDx97PlMAQ==@vger.kernel.org, AJvYcCVHdEZ8u7svwgKUodrkLtM/yJIIvU6xWOJc2TZJBZxyOX9PxZcyAJ0FmM5nCiAGOa7F1nRqPsmDjedv@vger.kernel.org, AJvYcCW4IDaSJazeWSwFFgACWN7b69epSroBWv2UjtCV4FoSmmVDdLNrz0ZML2pgVp0fPyOFulXTEhsYGbk7yA==@vger.kernel.org, AJvYcCX54pACOS+AT+fpvWNPmgl03ntroAgVDVSeFEZLJCxJoA7bevDnRDhIiCiI4qh+bhZoOHbq223hNnGkOq8KPjz3@vger.kernel.org, AJvYcCXI1xdPeZEbwcZTymERqI5WYVZVnRug5O0uQP3+54Ly+XPRoFapANuj6cb7nMIR75kkF9JyOiLz3rlpclN5@vger.kernel.org, AJvYcCXWHCcRsafKEhSZun1fPA+F8bDs0z7gysLDMQj5i4bfYF4K6fFmjSEG068g/vYSBMUDDLQC77HKfITkIj956HRV8Rob5ZLW@vger.kernel.org, AJvY
 cCXqNg6XyAk9/D4vsEBX1q7rzepaXITLUvpATBsxMYuqEQPgjantjzmPcNjOZr6xYNATsfGYAM5TpRD2rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJwdOXXj+QpoI1AL07zJBq6cn8RioZhFakuWRHcCYSS299SHg
	B6dE6nWhyVZBwFGCBr4SkKevZyzO9uT19Cf5S5TC1wdpfbrwO03biextpt0qsRIGo2Dz+QevQ2k
	y2LtfM2znofuQa60xHNXrOK5iQYEJz44=
X-Google-Smtp-Source: AGHT+IH+CR6kK9khsoUi4kQxVa0vWTn3qqM4Z4G6WAw+0g0YyuRvDHP3ooIXGfMWBaXJUiPtMEtFUptkHeWtXN/zID4=
X-Received: by 2002:a05:6402:26d5:b0:60c:6a48:8047 with SMTP id
 4fb4d7f45d1cf-612d456bb15mr803449a12.11.1752830294637; Fri, 18 Jul 2025
 02:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717231756.make.423-kees@kernel.org> <20250717232519.2984886-9-kees@kernel.org>
In-Reply-To: <20250717232519.2984886-9-kees@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 18 Jul 2025 17:18:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4RyZQTak5AgYj6TaXHyEefgw+wmXs9Gi8jUJWrUV5HQw@mail.gmail.com>
X-Gm-Features: Ac12FXyrA9A9-rpLV3MB79YH2kXhj6f2Fk9F6HAlk-0emUPTHthuyPP3lR9zQXg
Message-ID: <CAAhV-H4RyZQTak5AgYj6TaXHyEefgw+wmXs9Gi8jUJWrUV5HQw@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] mips: Handle KCOV __init vs inline mismatch
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Christoph Hellwig <hch@lst.de>, 
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

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Fri, Jul 18, 2025 at 7:26=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> When KCOV is enabled all functions get instrumented, unless
> the __no_sanitize_coverage attribute is used. To prepare for
> __no_sanitize_coverage being applied to __init functions, we
> have to handle differences in how GCC's inline optimizations get
> resolved. For mips this requires adding the __init annotation on
> init_mips_clocksource().
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
> index e855a3611d92..5e7193b759f3 100644
> --- a/arch/mips/include/asm/time.h
> +++ b/arch/mips/include/asm/time.h
> @@ -55,7 +55,7 @@ static inline int mips_clockevent_init(void)
>   */
>  extern int init_r4k_clocksource(void);
>
> -static inline int init_mips_clocksource(void)
> +static inline __init int init_mips_clocksource(void)
>  {
>  #ifdef CONFIG_CSRC_R4K
>         return init_r4k_clocksource();
> --
> 2.34.1
>
>

