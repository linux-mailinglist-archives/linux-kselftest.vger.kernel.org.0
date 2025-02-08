Return-Path: <linux-kselftest+bounces-26097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CB8A2D525
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EF616B042
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0499A1AC884;
	Sat,  8 Feb 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McbPXjdE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241A1AF0CE
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Feb 2025 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005647; cv=none; b=nKRJtT1svPz9+vnaotvfX+gcppk+7DiRgfPms+A7zT4kQF/bi3c4UZsCRyyDWHB2POyghdqxXCpLzES4qCXJcdHZMH05MTEnaypIfnpqEqF9lGp4KRPMUgSIsFZKXLp4rG6vfcvgNxUgPxfTfDbuGkGpdz2xwE8UhthhRH+fG3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005647; c=relaxed/simple;
	bh=/jOLD95wKVsEVVysTK5IjhYChF/5L/q1fnFxDxBMtlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhOoY+JFZxtqckaG2mgSHoIVdB1iLq2x4wLnQgetAiUhatnA8b3YJmhMjvsV42YNio76s60GtA4MgETmmGV9FfsSXlBE3bKyheYO0M6075epeFF4pN/v1BxMHWZvETw4833wZxKh2QdecY1hrcf6ttlAo2ucYhcfzFBB8j/R2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=McbPXjdE; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e4562aa221so918586d6.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Feb 2025 01:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739005644; x=1739610444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AxcpvFLt+acbpVZhJ8iMPdN0HCxZmep95lwkOlM0ZfY=;
        b=McbPXjdEX4xUd0wS4kNMahJTvbxx4TcOzHKD+bhVwi4Oi8u0MpAehjTQ5F5jzShOA1
         K2MLxshLrYej/pj6U6lcF1cSwzhN88wvTsNd1kQxR4xgracxWo+d0RPpXdTxafxubdnz
         70HIIcyIn++c5SHJi4OlRfhCqeXkaFBMCK0oEpHI+Xjo9+UzUWcy+Rt9NeqdHykV6l/m
         yROTtzqNan8ha4jzsxjeoCejDvyVN0G2zD91WcpVqOhKrOmF0iEfRPj1y8XlIocKYSJx
         j6wBE5w0Iw4yEj3wceV5+2tzo2E3iVSIcAjpjBQKGMUXcRi0sSA+FS369W8ZvYfaXt8e
         QWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739005644; x=1739610444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxcpvFLt+acbpVZhJ8iMPdN0HCxZmep95lwkOlM0ZfY=;
        b=wruDcdWEJ9ytjctpuSzkc0BpsgaChO8leTnndNAxRMxJ80XJ11/d93gbhXSfFiXGNR
         fS+nuSzdZYxEDLMY0LDgQNltJiZGcAWotwbsaSfZgjOtgOIH11Mxmszbf6Yk4Jwqq5U5
         CRNyet74hoHEU35eIvFd8TG8KgqgMkqJ0jH1Wf9WqoHKWu0i4Lqm1F7wsiO6dMdGx8iR
         HLVwe24Udamgimlyzx3wk2FXh+YhWshSPaSMN6+5URnTw8YIZHHcMLbTeem77bj8Coqu
         8z8rMmrB/YRWdGz/4i03OuXd01EU/B/ggXg977vwAMCGSxiiaZcMR9WNx02Yrxv9wM0H
         lmhg==
X-Forwarded-Encrypted: i=1; AJvYcCVlcVHqo3OiH69t3rb/ZTr1ojkZ6w3yJZoHzMOLIoQKFVSpDdR4Ybchf1KzSLzJIYTENUCLcYGdFA4Ip19yjHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB6nSlXCnpY1fA+nX1tAs3fctPNC6N4lfXL4efdkK4NgTaM+b2
	aIY1MvdUpKFniU/mA5KzUPnYE5sYLvi8Zxtfp4Z/yVzu44Dp/UC1eFtrLhRMGuN6HZzU2LetXEG
	ga/VA0Dvpa7wqlhox1XkJDa17dgabV5A8aFXv
X-Gm-Gg: ASbGncvartEjt1EYcLcVpJUiWaf7pDYfGWTLaYnHBa2bZqTE4QNP4hlJKWTFjyKO8YY
	cq4UivoLIbkx5NPCYpa49MElyfBj5k2Kl+061HZX8uCSluFo1IgdRUkXTX8IX2AvxYduFsnI5WA
	==
X-Google-Smtp-Source: AGHT+IGMirxJprnSp1/JHzDFjZL39vUk9TNQSaCziz5JARWFZijm+XHQsud6Nt4i0zKatHuTKPWkgSIVn+o/yNljJU4=
X-Received: by 2002:ad4:4eea:0:b0:6e4:3459:de83 with SMTP id
 6a1803df08f44-6e4455c1c01mr85715816d6.2.1739005643194; Sat, 08 Feb 2025
 01:07:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com> <20250207-bitmap-kunit-convert-v1-2-c520675343b6@gmail.com>
In-Reply-To: <20250207-bitmap-kunit-convert-v1-2-c520675343b6@gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 8 Feb 2025 17:07:11 +0800
X-Gm-Features: AWEUYZlfeqWE36Y2hhulY9PX9XsP4kOsOff91V4HebYNfKgvXl-Q48NuwGQto84
Message-ID: <CABVgOS=ZzdAGOdN1etgKV=9_kWtxAfjmo7vyCUV3AK-CxM081Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] bitmap: convert self-test to KUnit
To: Tamir Duberstein <tamird@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000acec14062d9dcd2b"

--000000000000acec14062d9dcd2b
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Feb 2025 at 04:14, Tamir Duberstein <tamird@gmail.com> wrote:
>
> Convert the bitmap() self-test to a KUnit test.
>
> In the interest of keeping the patch reasonably-sized this doesn't
> refactor the tests into proper parameterized tests - it's all one big
> test case.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

Thanks very much for picking this up.

Personally, I'm very much in favour of this, particularly once the
refactor in the next patch lands.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  MAINTAINERS                           |   2 +-
>  arch/m68k/configs/amiga_defconfig     |   1 -
>  arch/m68k/configs/apollo_defconfig    |   1 -
>  arch/m68k/configs/atari_defconfig     |   1 -
>  arch/m68k/configs/bvme6000_defconfig  |   1 -
>  arch/m68k/configs/hp300_defconfig     |   1 -
>  arch/m68k/configs/mac_defconfig       |   1 -
>  arch/m68k/configs/multi_defconfig     |   1 -
>  arch/m68k/configs/mvme147_defconfig   |   1 -
>  arch/m68k/configs/mvme16x_defconfig   |   1 -
>  arch/m68k/configs/q40_defconfig       |   1 -
>  arch/m68k/configs/sun3_defconfig      |   1 -
>  arch/m68k/configs/sun3x_defconfig     |   1 -
>  arch/powerpc/configs/ppc64_defconfig  |   1 -
>  lib/Kconfig.debug                     |  24 ++-
>  lib/Makefile                          |   2 +-
>  lib/{test_bitmap.c => bitmap_kunit.c} | 322 +++++++++++++---------------------
>  tools/testing/selftests/lib/bitmap.sh |   3 -
>  tools/testing/selftests/lib/config    |   1 -
>  19 files changed, 145 insertions(+), 222 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..9824d4053748 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4016,11 +4016,11 @@ F:      include/linux/nodemask_types.h
>  F:     include/vdso/bits.h
>  F:     lib/bitmap-str.c
>  F:     lib/bitmap.c
> +F:     lib/bitmap_kunit.c
>  F:     lib/cpumask.c
>  F:     lib/cpumask_kunit.c
>  F:     lib/find_bit.c
>  F:     lib/find_bit_benchmark.c
> -F:     lib/test_bitmap.c
>  F:     tools/include/linux/bitfield.h
>  F:     tools/include/linux/bitmap.h
>  F:     tools/include/linux/bits.h
> diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
> index dbf2ea561c85..3c9d7b58cb8a 100644
> --- a/arch/m68k/configs/amiga_defconfig
> +++ b/arch/m68k/configs/amiga_defconfig
> @@ -624,7 +624,6 @@ CONFIG_TEST_HEXDUMP=m
>  CONFIG_TEST_KSTRTOX=m
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m
>  CONFIG_TEST_XARRAY=m
>  CONFIG_TEST_MAPLE_TREE=m
> diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
> index b0fd199cc0a4..b94c87a7cbdb 100644
> --- a/arch/m68k/configs/apollo_defconfig
> +++ b/arch/m68k/configs/apollo_defconfig
> @@ -581,7 +581,6 @@ CONFIG_TEST_HEXDUMP=m
>  CONFIG_TEST_KSTRTOX=m
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m
>  CONFIG_TEST_XARRAY=m
>  CONFIG_TEST_MAPLE_TREE=m
> diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
> index bb5b2d3b6c10..823ba96c4486 100644
> --- a/arch/m68k/configs/atari_defconfig
> +++ b/arch/m68k/configs/atari_defconfig
> @@ -601,7 +601,6 @@ CONFIG_TEST_HEXDUMP=m
>  CONFIG_TEST_KSTRTOX=m
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m
>  CONFIG_TEST_XARRAY=m
>  CONFIG_TEST_MAPLE_TREE=m
> diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
> index 8315a13bab73..0fa985129200 100644
> --- a/arch/m68k/configs/bvme6000_defconfig
> +++ b/arch/m68k/configs/bvme6000_defconfig
> @@ -573,7 +573,6 @@ CONFIG_TEST_HEXDUMP=m
>  CONFIG_TEST_KSTRTOX=m
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m
>  CONFIG_TEST_XARRAY=m
>  CONFIG_TEST_MAPLE_TREE=m
> diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
> index 350370657e5f..75ed6eb547c6 100644
> --- a/arch/m68k/configs/hp300_defconfig
> +++ b/arch/m68k/configs/hp300_defconfig
> @@ -583,7 +583,6 @@ CONFIG_TEST_HEXDUMP=m
>  CONFIG_TEST_KSTRTOX=m
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m
>  CONFIG_TEST_XARRAY=m
>  CONFIG_TEST_MAPLE_TREE=m
> diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
> index f942b4755702..149c398f80a8 100644
> --- a/arch/m68k/configs/mac_defconfig
> +++ b/arch/m68k/configs/mac_defconfig
> @@ -600,7 +600,6 @@ CONFIG_TEST_HEXDUMP=m
>  CONFIG_TEST_KSTRTOX=m
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m
>  CONFIG_TEST_XARRAY=m
>  CONFIG_TEST_MAPLE_TREE=m
> diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
> index b1eaad02efab..34e6eaa47a18 100644
> --- a/arch/m68k/configs/multi_defconfig
> +++ b/arch/m68k/configs/multi_defconfig
> @@ -687,7 +687,6 @@ CONFIG_TEST_HEXDUMP=m
>  CONFIG_TEST_KSTRTOX=m
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m
>  CONFIG_TEST_XARRAY=m
>  CONFIG_TEST_MAPLE_TREE=m
> diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
> index 6309a4442bb3..9e9f8883b38d 100644
> --- a/arch/m68k/configs/mvme147_defconfig
> +++ b/arch/m68k/configs/mvme147_defconfig
> @@ -573,7 +573,6 @@ CONFIG_TEST_HEXDUMP=m
>  CONFIG_TEST_KSTRTOX=m
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m
>  CONFIG_TEST_XARRAY=m
>  CONFIG_TEST_MAPLE_TREE=m
> diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
> index 3feb0731f814..5ed08e78c4fd 100644
> --- a/arch/m68k/configs/mvme16x_defconfig
> +++ b/arch/m68k/configs/mvme16x_defconfig
> @@ -574,7 +574,6 @@ CONFIG_TEST_HEXDUMP=m
>  CONFIG_TEST_KSTRTOX=m
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m
>  CONFIG_TEST_XARRAY=m
>  CONFIG_TEST_MAPLE_TREE=m
> diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
> index ea04b1b0da7d..4e0eea94a6a0 100644
> --- a/arch/m68k/configs/q40_defconfig
> +++ b/arch/m68k/configs/q40_defconfig
> @@ -590,7 +590,6 @@ CONFIG_TEST_HEXDUMP=m
>  CONFIG_TEST_KSTRTOX=m
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m
>  CONFIG_TEST_XARRAY=m
>  CONFIG_TEST_MAPLE_TREE=m
> diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
> index f52d9af92153..690e2156b5f7 100644
> --- a/arch/m68k/configs/sun3_defconfig
> +++ b/arch/m68k/configs/sun3_defconfig
> @@ -570,7 +570,6 @@ CONFIG_TEST_HEXDUMP=m
>  CONFIG_TEST_KSTRTOX=m
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m
>  CONFIG_TEST_XARRAY=m
>  CONFIG_TEST_MAPLE_TREE=m
> diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
> index f348447824da..71486fd428da 100644
> --- a/arch/m68k/configs/sun3x_defconfig
> +++ b/arch/m68k/configs/sun3x_defconfig
> @@ -571,7 +571,6 @@ CONFIG_TEST_HEXDUMP=m
>  CONFIG_TEST_KSTRTOX=m
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m
>  CONFIG_TEST_XARRAY=m
>  CONFIG_TEST_MAPLE_TREE=m
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
> index 465eb96c755e..cfd235d90c95 100644
> --- a/arch/powerpc/configs/ppc64_defconfig
> +++ b/arch/powerpc/configs/ppc64_defconfig
> @@ -446,7 +446,6 @@ CONFIG_TEST_STRING_HELPERS=m
>  CONFIG_TEST_KSTRTOX=m
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m
>  CONFIG_TEST_XARRAY=m
>  CONFIG_TEST_MAPLE_TREE=m
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1af972a92d06..fd3dcb0677b5 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2427,6 +2427,23 @@ config ASYNC_RAID6_TEST
>  config TEST_HEXDUMP
>         tristate "Test functions located in the hexdump module at runtime"
>
> +config BITMAP_KUNIT_TEST
> +       tristate "KUnit test bitmap_*() family of functions at runtime" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         Enable this option to test the bitmap functions at boot.
> +
> +         KUnit tests run during boot and output the results to the debug log
> +         in TAP format (http://testanything.org/). Only useful for kernel devs
> +         running the KUnit test harness, and not intended for inclusion into a
> +         production build.
> +
> +         For more information on KUnit and unit tests in general please refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config STRING_KUNIT_TEST
>         tristate "KUnit test string functions at runtime" if !KUNIT_ALL_TESTS
>         depends on KUNIT
> @@ -2446,13 +2463,6 @@ config TEST_PRINTF
>  config TEST_SCANF
>         tristate "Test scanf() family of functions at runtime"
>
> -config TEST_BITMAP
> -       tristate "Test bitmap_*() family of functions at runtime"
> -       help
> -         Enable this option to test the bitmap functions at boot.
> -
> -         If unsure, say N.
> -
>  config TEST_UUID
>         tristate "Test functions located in the uuid module at runtime"
>
> diff --git a/lib/Makefile b/lib/Makefile
> index d5cfc7afbbb8..d735e1b70606 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -87,7 +87,7 @@ obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
>  obj-$(CONFIG_TEST_PRINTF) += test_printf.o
>  obj-$(CONFIG_TEST_SCANF) += test_scanf.o
>
> -obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
> +obj-$(CONFIG_BITMAP_KUNIT_TEST) += bitmap_kunit.o
>  ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
>  # FIXME: Clang breaks test_bitmap_const_eval when KASAN and GCOV are enabled
>  GCOV_PROFILE_test_bitmap.o := n
> diff --git a/lib/test_bitmap.c b/lib/bitmap_kunit.c
> similarity index 83%
> rename from lib/test_bitmap.c
> rename to lib/bitmap_kunit.c
> index c83829ef557f..0605228288d6 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/bitmap_kunit.c
> @@ -3,10 +3,8 @@
>   * Test cases for bitmap API.
>   */
>
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> +#include <kunit/test.h>
>  #include <linux/bitmap.h>
> -#include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/printk.h>
> @@ -14,16 +12,17 @@
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
>
> -#include "../tools/testing/selftests/kselftest_module.h"
> -
>  #define EXP1_IN_BITS   (sizeof(exp1) * 8)
>
> -KSTM_MODULE_GLOBALS();
> +static char pbl_buffer[PAGE_SIZE];
> +static char print_buf[PAGE_SIZE * 2];
> +
> +static struct kunit *kunittest;
>
> -static char pbl_buffer[PAGE_SIZE] __initdata;
> -static char print_buf[PAGE_SIZE * 2] __initdata;
> +#define tc_err(fmt, ...) \
> +       KUNIT_FAIL(kunittest, fmt, ##__VA_ARGS__)
>
> -static const unsigned long exp1[] __initconst = {
> +static const unsigned long exp1[] = {
>         BITMAP_FROM_U64(1),
>         BITMAP_FROM_U64(2),
>         BITMAP_FROM_U64(0x0000ffff),
> @@ -41,130 +40,63 @@ static const unsigned long exp1[] __initconst = {
>         BITMAP_FROM_U64(0x80000000),
>  };
>
> -static const unsigned long exp2[] __initconst = {
> +static const unsigned long exp2[] = {
>         BITMAP_FROM_U64(0x3333333311111111ULL),
>         BITMAP_FROM_U64(0xffffffff77777777ULL),
>  };
>
>  /* Fibonacci sequence */
> -static const unsigned long exp2_to_exp3_mask[] __initconst = {
> +static const unsigned long exp2_to_exp3_mask[] = {
>         BITMAP_FROM_U64(0x008000020020212eULL),
>  };
>  /* exp3_0_1 = (exp2[0] & ~exp2_to_exp3_mask) | (exp2[1] & exp2_to_exp3_mask) */
> -static const unsigned long exp3_0_1[] __initconst = {
> +static const unsigned long exp3_0_1[] = {
>         BITMAP_FROM_U64(0x33b3333311313137ULL),
>  };
>  /* exp3_1_0 = (exp2[1] & ~exp2_to_exp3_mask) | (exp2[0] & exp2_to_exp3_mask) */
> -static const unsigned long exp3_1_0[] __initconst = {
> +static const unsigned long exp3_1_0[] = {
>         BITMAP_FROM_U64(0xff7fffff77575751ULL),
>  };
>
> -static bool __init
> -__check_eq_ulong(const char *srcfile, unsigned int line,
> -                const unsigned long exp_ulong, unsigned long x)
> -{
> -       if (exp_ulong != x) {
> -               pr_err("[%s:%u] expected %lu, got %lu\n",
> -                       srcfile, line, exp_ulong, x);
> -               return false;
> -       }
> -       return true;
> -}
> -
> -static bool __init
> -__check_eq_bitmap(const char *srcfile, unsigned int line,
> -                 const unsigned long *exp_bmap, const unsigned long *bmap,
> -                 unsigned int nbits)
> -{
> -       if (!bitmap_equal(exp_bmap, bmap, nbits)) {
> -               pr_warn("[%s:%u] bitmaps contents differ: expected \"%*pbl\", got \"%*pbl\"\n",
> -                       srcfile, line,
> -                       nbits, exp_bmap, nbits, bmap);
> -               return false;
> -       }
> -       return true;
> -}
> -
> -static bool __init
> -__check_eq_pbl(const char *srcfile, unsigned int line,
> -              const char *expected_pbl,
> -              const unsigned long *bitmap, unsigned int nbits)
> -{
> -       snprintf(pbl_buffer, sizeof(pbl_buffer), "%*pbl", nbits, bitmap);
> -       if (strcmp(expected_pbl, pbl_buffer)) {
> -               pr_warn("[%s:%u] expected \"%s\", got \"%s\"\n",
> -                       srcfile, line,
> -                       expected_pbl, pbl_buffer);
> -               return false;
> -       }
> -       return true;
> -}
> -
> -static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
> -                                   const unsigned int offset,
> -                                   const unsigned int size,
> -                                   const unsigned char *const clump_exp,
> -                                   const unsigned long *const clump)
> -{
> -       unsigned long exp;
> -
> -       if (offset >= size) {
> -               pr_warn("[%s:%u] bit offset for clump out-of-bounds: expected less than %u, got %u\n",
> -                       srcfile, line, size, offset);
> -               return false;
> -       }
> -
> -       exp = clump_exp[offset / 8];
> -       if (!exp) {
> -               pr_warn("[%s:%u] bit offset for zero clump: expected nonzero clump, got bit offset %u with clump value 0",
> -                       srcfile, line, offset);
> -               return false;
> -       }
> -
> -       if (*clump != exp) {
> -               pr_warn("[%s:%u] expected clump value of 0x%lX, got clump value of 0x%lX",
> -                       srcfile, line, exp, *clump);
> -               return false;
> -       }
> -
> -       return true;
> -}
> -
> -static bool __init
> -__check_eq_str(const char *srcfile, unsigned int line,
> -               const char *exp_str, const char *str,
> -               unsigned int len)
> -{
> -       bool eq;
> -
> -       eq = strncmp(exp_str, str, len) == 0;
> -       if (!eq)
> -               pr_err("[%s:%u] expected %s, got %s\n", srcfile, line, exp_str, str);
> -
> -       return eq;
> -}
> -
> -#define __expect_eq(suffix, ...)                                       \
> -       ({                                                              \
> -               int result = 0;                                         \
> -               total_tests++;                                          \
> -               if (!__check_eq_ ## suffix(__FILE__, __LINE__,          \
> -                                          ##__VA_ARGS__)) {            \
> -                       failed_tests++;                                 \
> -                       result = 1;                                     \
> +#define expect_eq_ulong(exp_ulong, x)  KUNIT_EXPECT_EQ(kunittest, exp_ulong, x)
> +
> +#define expect_eq_bitmap(exp_bmap, bmap, nbits)                                                        \
> +       KUNIT_EXPECT_TRUE_MSG(kunittest, bitmap_equal(exp_bmap, bmap, nbits),                   \
> +                             "bitmaps contents differ: expected \"%*pbl\", got \"%*pbl\"",     \
> +                                       nbits, exp_bmap, nbits, bmap)
> +
> +#define expect_eq_pbl(expected_pbl, bitmap, nbits) do {                                                \
> +               {                                                                               \
> +                       snprintf(pbl_buffer, sizeof(pbl_buffer), "%*pbl", nbits, bitmap);       \
> +                       KUNIT_EXPECT_STREQ(kunittest, expected_pbl, pbl_buffer);                \
> +               }                                                                               \
> +       } while (0)
> +
> +#define expect_eq_clump8(offset, size, clump_exp, clump) do {                          \
> +               {                                                                       \
> +                       unsigned long exp;                                              \
> +                                                                                       \
> +                       KUNIT_EXPECT_LT_MSG(kunittest, offset, size,                    \
> +                                           "bit offset for clump out-of-bounds");      \
> +                                                                                       \
> +                       exp = clump_exp[offset / 8];                                    \
> +                       KUNIT_EXPECT_NE_MSG(kunittest, exp, 0,                          \
> +                                           "bit offset %u for zero clump", offset);    \
> +                                                                                       \
> +                       KUNIT_EXPECT_EQ(kunittest, *clump, exp);                        \
> +               }                                                                       \
> +       } while (0)
> +
> +#define expect_eq_str(exp_str, str, len)                               \
> +       {                                                               \
> +               if (strncmp(exp_str, str, len) != 0) {                  \
> +                       tc_err("expected %s, got %s", exp_str, str);    \
>                 }                                                       \
> -               result;                                                 \
> -       })
> +       }
>
> -#define expect_eq_ulong(...)           __expect_eq(ulong, ##__VA_ARGS__)
>  #define expect_eq_uint(x, y)           expect_eq_ulong((unsigned int)(x), (unsigned int)(y))
> -#define expect_eq_bitmap(...)          __expect_eq(bitmap, ##__VA_ARGS__)
> -#define expect_eq_pbl(...)             __expect_eq(pbl, ##__VA_ARGS__)
> -#define expect_eq_u32_array(...)       __expect_eq(u32_array, ##__VA_ARGS__)
> -#define expect_eq_clump8(...)          __expect_eq(clump8, ##__VA_ARGS__)
> -#define expect_eq_str(...)             __expect_eq(str, ##__VA_ARGS__)
>
> -static void __init test_zero_clear(void)
> +static void test_zero_clear(void)
>  {
>         DECLARE_BITMAP(bmap, 1024);
>
> @@ -193,7 +125,7 @@ static void __init test_zero_clear(void)
>         expect_eq_pbl("", bmap, 1024);
>  }
>
> -static void __init test_find_nth_bit(void)
> +static void test_find_nth_bit(void)
>  {
>         unsigned long b, bit, cnt = 0;
>         DECLARE_BITMAP(bmap, 64 * 3);
> @@ -234,7 +166,7 @@ static void __init test_find_nth_bit(void)
>         }
>  }
>
> -static void __init test_fill_set(void)
> +static void test_fill_set(void)
>  {
>         DECLARE_BITMAP(bmap, 1024);
>
> @@ -263,7 +195,7 @@ static void __init test_fill_set(void)
>         expect_eq_pbl("0-1023", bmap, 1024);
>  }
>
> -static void __init test_copy(void)
> +static void test_copy(void)
>  {
>         DECLARE_BITMAP(bmap1, 1024);
>         DECLARE_BITMAP(bmap2, 1024);
> @@ -302,7 +234,7 @@ static void __init test_copy(void)
>         expect_eq_pbl("0-108,128-1023", bmap2, 1024);
>  }
>
> -static void __init test_bitmap_region(void)
> +static void test_bitmap_region(void)
>  {
>         int pos, order;
>
> @@ -327,7 +259,7 @@ static void __init test_bitmap_region(void)
>
>  #define EXP2_IN_BITS   (sizeof(exp2) * 8)
>
> -static void __init test_replace(void)
> +static void test_replace(void)
>  {
>         unsigned int nbits = 64;
>         unsigned int nlongs = DIV_ROUND_UP(nbits, BITS_PER_LONG);
> @@ -352,23 +284,23 @@ static void __init test_replace(void)
>         expect_eq_bitmap(bmap, exp3_1_0, nbits);
>  }
>
> -static const unsigned long sg_mask[] __initconst = {
> +static const unsigned long sg_mask[] = {
>         BITMAP_FROM_U64(0x000000000000035aULL),
>  };
>
> -static const unsigned long sg_src[] __initconst = {
> +static const unsigned long sg_src[] = {
>         BITMAP_FROM_U64(0x0000000000000667ULL),
>  };
>
> -static const unsigned long sg_gather_exp[] __initconst = {
> +static const unsigned long sg_gather_exp[] = {
>         BITMAP_FROM_U64(0x0000000000000029ULL),
>  };
>
> -static const unsigned long sg_scatter_exp[] __initconst = {
> +static const unsigned long sg_scatter_exp[] = {
>         BITMAP_FROM_U64(0x000000000000021aULL),
>  };
>
> -static void __init test_bitmap_sg(void)
> +static void test_bitmap_sg(void)
>  {
>         unsigned int nbits = 64;
>         DECLARE_BITMAP(bmap_gather, 100);
> @@ -404,7 +336,7 @@ struct test_bitmap_parselist{
>         const int flags;
>  };
>
> -static const struct test_bitmap_parselist parselist_tests[] __initconst = {
> +static const struct test_bitmap_parselist parselist_tests[] = {
>  #define step (sizeof(u64) / sizeof(unsigned long))
>
>         {0, "0",                        &exp1[0], 8, 0},
> @@ -489,7 +421,7 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
>
>  };
>
> -static void __init test_bitmap_parselist(void)
> +static void test_bitmap_parselist(void)
>  {
>         int i;
>         int err;
> @@ -504,30 +436,28 @@ static void __init test_bitmap_parselist(void)
>                 time = ktime_get() - time;
>
>                 if (err != ptest.errno) {
> -                       pr_err("parselist: %d: input is %s, errno is %d, expected %d\n",
> +                       tc_err("parselist: %d: input is %s, errno is %d, expected %d",
>                                         i, ptest.in, err, ptest.errno);
> -                       failed_tests++;
>                         continue;
>                 }
>
>                 if (!err && ptest.expected
>                          && !__bitmap_equal(bmap, ptest.expected, ptest.nbits)) {
> -                       pr_err("parselist: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
> +                       tc_err("parselist: %d: input is %s, result is 0x%lx, expected 0x%lx",
>                                         i, ptest.in, bmap[0],
>                                         *ptest.expected);
> -                       failed_tests++;
>                         continue;
>                 }
>
>                 if (ptest.flags & PARSE_TIME)
> -                       pr_info("parselist: %d: input is '%s' OK, Time: %llu\n",
> +                       kunit_info(kunittest, "parselist: %d: input is '%s' OK, Time: %llu",
>                                         i, ptest.in, time);
>
>  #undef ptest
>         }
>  }
>
> -static void __init test_bitmap_printlist(void)
> +static void test_bitmap_printlist(void)
>  {
>         unsigned long *bmap = kmalloc(PAGE_SIZE, GFP_KERNEL);
>         char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> @@ -548,37 +478,35 @@ static void __init test_bitmap_printlist(void)
>         time = ktime_get() - time;
>
>         if (ret != slen + 1) {
> -               pr_err("bitmap_print_to_pagebuf: result is %d, expected %d\n", ret, slen);
> -               failed_tests++;
> +               tc_err("bitmap_print_to_pagebuf: result is %d, expected %d", ret, slen);
>                 goto out;
>         }
>
>         if (strncmp(buf, expected, slen)) {
> -               pr_err("bitmap_print_to_pagebuf: result is %s, expected %s\n", buf, expected);
> -               failed_tests++;
> +               tc_err("bitmap_print_to_pagebuf: result is %s, expected %s", buf, expected);
>                 goto out;
>         }
>
> -       pr_info("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
> +       kunit_info(kunittest, "bitmap_print_to_pagebuf: input is '%s', Time: %llu", buf, time);
>  out:
>         kfree(buf);
>         kfree(bmap);
>  }
>
> -static const unsigned long parse_test[] __initconst = {
> +static const unsigned long parse_test[] = {
>         BITMAP_FROM_U64(0),
>         BITMAP_FROM_U64(1),
>         BITMAP_FROM_U64(0xdeadbeef),
>         BITMAP_FROM_U64(0x100000000ULL),
>  };
>
> -static const unsigned long parse_test2[] __initconst = {
> +static const unsigned long parse_test2[] = {
>         BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0xdeadbeef),
>         BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0xbaadf00ddeadbeef),
>         BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0x0badf00ddeadbeef),
>  };
>
> -static const struct test_bitmap_parselist parse_tests[] __initconst = {
> +static const struct test_bitmap_parselist parse_tests[] = {
>         {0, "",                         &parse_test[0 * step], 32, 0},
>         {0, " ",                        &parse_test[0 * step], 32, 0},
>         {0, "0",                        &parse_test[0 * step], 32, 0},
> @@ -605,7 +533,7 @@ static const struct test_bitmap_parselist parse_tests[] __initconst = {
>  #undef step
>  };
>
> -static void __init test_bitmap_parse(void)
> +static void test_bitmap_parse(void)
>  {
>         int i;
>         int err;
> @@ -621,28 +549,26 @@ static void __init test_bitmap_parse(void)
>                 time = ktime_get() - time;
>
>                 if (err != test.errno) {
> -                       pr_err("parse: %d: input is %s, errno is %d, expected %d\n",
> +                       tc_err("parse: %d: input is %s, errno is %d, expected %d",
>                                         i, test.in, err, test.errno);
> -                       failed_tests++;
>                         continue;
>                 }
>
>                 if (!err && test.expected
>                          && !__bitmap_equal(bmap, test.expected, test.nbits)) {
> -                       pr_err("parse: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
> +                       tc_err("parse: %d: input is %s, result is 0x%lx, expected 0x%lx",
>                                         i, test.in, bmap[0],
>                                         *test.expected);
> -                       failed_tests++;
>                         continue;
>                 }
>
>                 if (test.flags & PARSE_TIME)
> -                       pr_info("parse: %d: input is '%s' OK, Time: %llu\n",
> +                       kunit_info(kunittest, "parse: %d: input is '%s' OK, Time: %llu",
>                                         i, test.in, time);
>         }
>  }
>
> -static void __init test_bitmap_arr32(void)
> +static void test_bitmap_arr32(void)
>  {
>         unsigned int nbits, next_bit;
>         u32 arr[EXP1_IN_BITS / 32];
> @@ -658,10 +584,8 @@ static void __init test_bitmap_arr32(void)
>                 next_bit = find_next_bit(bmap2,
>                                 round_up(nbits, BITS_PER_LONG), nbits);
>                 if (next_bit < round_up(nbits, BITS_PER_LONG)) {
> -                       pr_err("bitmap_copy_arr32(nbits == %d:"
> -                               " tail is not safely cleared: %d\n",
> +                       tc_err("bitmap_copy_arr32(nbits == %d: tail is not safely cleared: %d",
>                                 nbits, next_bit);
> -                       failed_tests++;
>                 }
>
>                 if (nbits < EXP1_IN_BITS - 32)
> @@ -670,7 +594,7 @@ static void __init test_bitmap_arr32(void)
>         }
>  }
>
> -static void __init test_bitmap_arr64(void)
> +static void test_bitmap_arr64(void)
>  {
>         unsigned int nbits, next_bit;
>         u64 arr[EXP1_IN_BITS / 64];
> @@ -686,17 +610,15 @@ static void __init test_bitmap_arr64(void)
>
>                 next_bit = find_next_bit(bmap2, round_up(nbits, BITS_PER_LONG), nbits);
>                 if (next_bit < round_up(nbits, BITS_PER_LONG)) {
> -                       pr_err("bitmap_copy_arr64(nbits == %d:"
> -                               " tail is not safely cleared: %d\n", nbits, next_bit);
> -                       failed_tests++;
> +                       tc_err("bitmap_copy_arr64(nbits == %d: tail is not safely cleared: %d",
> +                               nbits, next_bit);
>                 }
>
>                 if ((nbits % 64) &&
>                     (arr[(nbits - 1) / 64] & ~GENMASK_ULL((nbits - 1) % 64, 0))) {
> -                       pr_err("bitmap_to_arr64(nbits == %d): tail is not safely cleared: 0x%016llx (must be 0x%016llx)\n",
> +                       tc_err("bitmap_to_arr64(nbits == %d): tail is not safely cleared: 0x%016llx (must be 0x%016llx)",
>                                nbits, arr[(nbits - 1) / 64],
>                                GENMASK_ULL((nbits - 1) % 64, 0));
> -                       failed_tests++;
>                 }
>
>                 if (nbits < EXP1_IN_BITS - 64)
> @@ -704,7 +626,7 @@ static void __init test_bitmap_arr64(void)
>         }
>  }
>
> -static void noinline __init test_mem_optimisations(void)
> +static noinline void test_mem_optimisations(void)
>  {
>         DECLARE_BITMAP(bmap1, 1024);
>         DECLARE_BITMAP(bmap2, 1024);
> @@ -718,30 +640,25 @@ static void noinline __init test_mem_optimisations(void)
>                         bitmap_set(bmap1, start, nbits);
>                         __bitmap_set(bmap2, start, nbits);
>                         if (!bitmap_equal(bmap1, bmap2, 1024)) {
> -                               printk("set not equal %d %d\n", start, nbits);
> -                               failed_tests++;
> +                               tc_err("set not equal %d %d", start, nbits);
>                         }
>                         if (!__bitmap_equal(bmap1, bmap2, 1024)) {
> -                               printk("set not __equal %d %d\n", start, nbits);
> -                               failed_tests++;
> +                               tc_err("set not __equal %d %d", start, nbits);
>                         }
>
>                         bitmap_clear(bmap1, start, nbits);
>                         __bitmap_clear(bmap2, start, nbits);
>                         if (!bitmap_equal(bmap1, bmap2, 1024)) {
> -                               printk("clear not equal %d %d\n", start, nbits);
> -                               failed_tests++;
> +                               tc_err("clear not equal %d %d", start, nbits);
>                         }
>                         if (!__bitmap_equal(bmap1, bmap2, 1024)) {
> -                               printk("clear not __equal %d %d\n", start,
> -                                                                       nbits);
> -                               failed_tests++;
> +                               tc_err("clear not __equal %d %d", start, nbits);
>                         }
>                 }
>         }
>  }
>
> -static const unsigned char clump_exp[] __initconst = {
> +static const unsigned char clump_exp[] = {
>         0x01,   /* 1 bit set */
>         0x02,   /* non-edge 1 bit set */
>         0x00,   /* zero bits set */
> @@ -752,7 +669,7 @@ static const unsigned char clump_exp[] __initconst = {
>         0x05,   /* non-adjacent 2 bits set */
>  };
>
> -static void __init test_for_each_set_clump8(void)
> +static void test_for_each_set_clump8(void)
>  {
>  #define CLUMP_EXP_NUMBITS 64
>         DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS);
> @@ -774,7 +691,7 @@ static void __init test_for_each_set_clump8(void)
>                 expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
>  }
>
> -static void __init test_for_each_set_bit_wrap(void)
> +static void test_for_each_set_bit_wrap(void)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -799,7 +716,7 @@ static void __init test_for_each_set_bit_wrap(void)
>         }
>  }
>
> -static void __init test_for_each_set_bit(void)
> +static void test_for_each_set_bit(void)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -821,7 +738,7 @@ static void __init test_for_each_set_bit(void)
>         expect_eq_bitmap(orig, copy, 500);
>  }
>
> -static void __init test_for_each_set_bit_from(void)
> +static void test_for_each_set_bit_from(void)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -851,7 +768,7 @@ static void __init test_for_each_set_bit_from(void)
>         }
>  }
>
> -static void __init test_for_each_clear_bit(void)
> +static void test_for_each_clear_bit(void)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -873,7 +790,7 @@ static void __init test_for_each_clear_bit(void)
>         expect_eq_bitmap(orig, copy, 500);
>  }
>
> -static void __init test_for_each_clear_bit_from(void)
> +static void test_for_each_clear_bit_from(void)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -903,7 +820,7 @@ static void __init test_for_each_clear_bit_from(void)
>         }
>  }
>
> -static void __init test_for_each_set_bitrange(void)
> +static void test_for_each_set_bitrange(void)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -925,7 +842,7 @@ static void __init test_for_each_set_bitrange(void)
>         expect_eq_bitmap(orig, copy, 500);
>  }
>
> -static void __init test_for_each_clear_bitrange(void)
> +static void test_for_each_clear_bitrange(void)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -947,7 +864,7 @@ static void __init test_for_each_clear_bitrange(void)
>         expect_eq_bitmap(orig, copy, 500);
>  }
>
> -static void __init test_for_each_set_bitrange_from(void)
> +static void test_for_each_set_bitrange_from(void)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -977,7 +894,7 @@ static void __init test_for_each_set_bitrange_from(void)
>         }
>  }
>
> -static void __init test_for_each_clear_bitrange_from(void)
> +static void test_for_each_clear_bitrange_from(void)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -1048,7 +965,7 @@ static struct test_bitmap_cut test_cut[] = {
>         },
>  };
>
> -static void __init test_bitmap_cut(void)
> +static void test_bitmap_cut(void)
>  {
>         unsigned long b[5], *in = &b[1], *out = &b[0];  /* Partial overlap */
>         int i;
> @@ -1071,14 +988,14 @@ struct test_bitmap_print {
>         const char *list;
>  };
>
> -static const unsigned long small_bitmap[] __initconst = {
> +static const unsigned long small_bitmap[] = {
>         BITMAP_FROM_U64(0x3333333311111111ULL),
>  };
>
> -static const char small_mask[] __initconst = "33333333,11111111\n";
> -static const char small_list[] __initconst = "0,4,8,12,16,20,24,28,32-33,36-37,40-41,44-45,48-49,52-53,56-57,60-61\n";
> +static const char small_mask[] = "33333333,11111111\n";
> +static const char small_list[] = "0,4,8,12,16,20,24,28,32-33,36-37,40-41,44-45,48-49,52-53,56-57,60-61\n";
>
> -static const unsigned long large_bitmap[] __initconst = {
> +static const unsigned long large_bitmap[] = {
>         BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
>         BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
>         BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
> @@ -1101,7 +1018,7 @@ static const unsigned long large_bitmap[] __initconst = {
>         BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
>  };
>
> -static const char large_mask[] __initconst = "33333333,11111111,33333333,11111111,"
> +static const char large_mask[] = "33333333,11111111,33333333,11111111,"
>                                         "33333333,11111111,33333333,11111111,"
>                                         "33333333,11111111,33333333,11111111,"
>                                         "33333333,11111111,33333333,11111111,"
> @@ -1122,7 +1039,7 @@ static const char large_mask[] __initconst = "33333333,11111111,33333333,1111111
>                                         "33333333,11111111,33333333,11111111,"
>                                         "33333333,11111111,33333333,11111111\n";
>
> -static const char large_list[] __initconst = /* more than 4KB */
> +static const char large_list[] = /* more than 4KB */
>         "0,4,8,12,16,20,24,28,32-33,36-37,40-41,44-45,48-49,52-53,56-57,60-61,64,68,72,76,80,84,88,92,96-97,100-101,104-1"
>         "05,108-109,112-113,116-117,120-121,124-125,128,132,136,140,144,148,152,156,160-161,164-165,168-169,172-173,176-1"
>         "77,180-181,184-185,188-189,192,196,200,204,208,212,216,220,224-225,228-229,232-233,236-237,240-241,244-245,248-2"
> @@ -1164,12 +1081,12 @@ static const char large_list[] __initconst = /* more than 4KB */
>         "2489,2492-2493,2496,2500,2504,2508,2512,2516,2520,2524,2528-2529,2532-2533,2536-2537,2540-2541,2544-2545,2548-25"
>         "49,2552-2553,2556-2557\n";
>
> -static const struct test_bitmap_print test_print[] __initconst = {
> +static const struct test_bitmap_print test_print[] = {
>         { small_bitmap, sizeof(small_bitmap) * BITS_PER_BYTE, small_mask, small_list },
>         { large_bitmap, sizeof(large_bitmap) * BITS_PER_BYTE, large_mask, large_list },
>  };
>
> -static void __init test_bitmap_print_buf(void)
> +static void test_bitmap_print_buf(void)
>  {
>         int i;
>
> @@ -1201,7 +1118,7 @@ static void __init test_bitmap_print_buf(void)
>   * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
>   * To workaround it, GCOV is force-disabled in Makefile for this configuration.
>   */
> -static void __init test_bitmap_const_eval(void)
> +static void test_bitmap_const_eval(void)
>  {
>         DECLARE_BITMAP(bitmap, BITS_PER_LONG);
>         unsigned long initvar = BIT(2);
> @@ -1269,7 +1186,7 @@ static void __init test_bitmap_const_eval(void)
>  /*
>   * Helper function to test bitmap_write() overwriting the chosen byte pattern.
>   */
> -static void __init test_bitmap_write_helper(const char *pattern)
> +static void test_bitmap_write_helper(const char *pattern)
>  {
>         DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
>         DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
> @@ -1323,7 +1240,7 @@ static void __init test_bitmap_write_helper(const char *pattern)
>         }
>  }
>
> -static void __init test_bitmap_read_write(void)
> +static void test_bitmap_read_write(void)
>  {
>         unsigned char *pattern[3] = {"", "all:1/2", "all"};
>         DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
> @@ -1372,7 +1289,7 @@ static void __init test_bitmap_read_write(void)
>                 test_bitmap_write_helper(pattern[pi]);
>  }
>
> -static void __init test_bitmap_read_perf(void)
> +static void test_bitmap_read_perf(void)
>  {
>         DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
>         unsigned int cnt, nbits, i;
> @@ -1395,10 +1312,10 @@ static void __init test_bitmap_read_perf(void)
>                 }
>         }
>         time = ktime_get() - time;
> -       pr_info("Time spent in %s:\t%llu\n", __func__, time);
> +       kunit_info(kunittest, "Time spent in %s:\t%llu\n", __func__, time);
>  }
>
> -static void __init test_bitmap_write_perf(void)
> +static void test_bitmap_write_perf(void)
>  {
>         DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
>         unsigned int cnt, nbits, i;
> @@ -1417,13 +1334,15 @@ static void __init test_bitmap_write_perf(void)
>                 }
>         }
>         time = ktime_get() - time;
> -       pr_info("Time spent in %s:\t%llu\n", __func__, time);
> +       kunit_info(kunittest, "Time spent in %s:\t%llu\n", __func__, time);
>  }
>
>  #undef TEST_BIT_LEN
>
> -static void __init selftest(void)
> +static void bitmap_test(struct kunit *test)
>  {
> +       kunittest = test;
> +
>         test_zero_clear();
>         test_fill_set();
>         test_copy();
> @@ -1456,7 +1375,18 @@ static void __init selftest(void)
>         test_for_each_set_bit_wrap();
>  }
>
> -KSTM_MODULE_LOADERS(test_bitmap);
> +static struct kunit_case bitmap_test_cases[] = {
> +       KUNIT_CASE(bitmap_test),
> +       {}
> +};
> +
> +static struct kunit_suite bitmap_test_suite = {
> +       .name = "bitmap",
> +       .test_cases = bitmap_test_cases,
> +};
> +
> +kunit_test_suite(bitmap_test_suite);
> +
>  MODULE_AUTHOR("david decotigny <david.decotigny@googlers.com>");
>  MODULE_DESCRIPTION("Test cases for bitmap API");
>  MODULE_LICENSE("GPL");
> diff --git a/tools/testing/selftests/lib/bitmap.sh b/tools/testing/selftests/lib/bitmap.sh
> deleted file mode 100755
> index 00a416fbc0ef..000000000000
> --- a/tools/testing/selftests/lib/bitmap.sh
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -$(dirname $0)/../kselftest/module.sh "bitmap" test_bitmap

If getting rid of this is going to seriously inconvenience anyone,
there's no fundamental reason why we can't provide a replacement
wrapper script with the same name, which modprobes the new module. The
output should be largely compatible, and the only real issue is that
CONFIG_KUNIT is required.


> diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
> index dc15aba8d0a3..8817520d1f42 100644
> --- a/tools/testing/selftests/lib/config
> +++ b/tools/testing/selftests/lib/config
> @@ -1,5 +1,4 @@
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_TEST_BITOPS=m
>
> --
> 2.48.1
>

--000000000000acec14062d9dcd2b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
NjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xNDEyMTAwMDAw
MDBaFw0zNDEyMTAwMDAwMDBaMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMw
EQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMIICIjANBgkqhkiG9w0BAQEF
AAOCAg8AMIICCgKCAgEAlQfoc8pm+ewUyns89w0I8bRFCyyCtEjG61s8roO4QZIzFKRvf+kqzMaw
iGvFtonRxrL/FM5RFCHsSt0bWsbWh+5NOhUG7WRmC5KAykTec5RO86eJf094YwjIElBtQmYvTbl5
KE1SGooagLcZgQ5+xIq8ZEwhHENo1z08isWyZtWQmrcxBsW+4m0yBqYe+bnrqqO4v76CY1DQ8BiJ
3+QPefXqoh8q0nAue+e8k7ttU+JIfIwQBzj/ZrJ3YX7g6ow8qrSk9vOVShIHbf2MsonP0KBhd8hY
dLDUIzr3XTrKotudCd5dRC2Q8YHNV5L6frxQBGM032uTGL5rNrI55KwkNrfw77YcE1eTtt6y+OKF
t3OiuDWqRfLgnTahb1SK8XJWbi6IxVFCRBWU7qPFOJabTk5aC0fzBjZJdzC8cTflpuwhCHX85mEW
P3fV2ZGXhAps1AJNdMAU7f05+4PyXhShBLAL6f7uj+FuC7IIs2FmCWqxBjplllnA8DX9ydoojRoR
h3CBCqiadR2eOoYFAJ7bgNYl+dwFnidZTHY5W+r5paHYgw/R/98wEfmFzzNI9cptZBQselhP00sI
ScWVZBpjDnk99bOMylitnEJFeW4OhxlcVLFltr+Mm9wT6Q1vuC7cZ27JixG1hBSKABlwg3mRl5HU
Gie/Nx4yB9gUYzwoTK8CAwEAAaNjMGEwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFK5sBaOTE+Ki5+LXHNbH8H/IZ1OgMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH
8H/IZ1OgMA0GCSqGSIb3DQEBDAUAA4ICAQCDJe3o0f2VUs2ewASgkWnmXNCE3tytok/oR3jWZZip
W6g8h3wCitFutxZz5l/AVJjVdL7BzeIRka0jGD3d4XJElrSVXsB7jpl4FkMTVlezorM7tXfcQHKs
o+ubNT6xCCGh58RDN3kyvrXnnCxMvEMpmY4w06wh4OMd+tgHM3ZUACIquU0gLnBo2uVT/INc053y
/0QMRGby0uO9RgAabQK6JV2NoTFR3VRGHE3bmZbvGhwEXKYV73jgef5d2z6qTFX9mhWpb+Gm+99w
MOnD7kJG7cKTBYn6fWN7P9BxgXwA6JiuDng0wyX7rwqfIGvdOxOPEoziQRpIenOgd2nHtlx/gsge
/lgbKCuobK1ebcAF0nu364D+JTf+AptorEJdw+71zNzwUHXSNmmc5nsE324GabbeCglIWYfrexRg
emSqaUPvkcdM7BjdbO9TLYyZ4V7ycj7PVMi9Z+ykD0xF/9O5MCMHTI8Qv4aW2ZlatJlXHKTMuxWJ
U7osBQ/kxJ4ZsRg01Uyduu33H68klQR4qAO77oHl2l98i0qhkHQlp7M+S8gsVr3HyO844lyS8Hn3
nIS6dC1hASB+ftHyTwdZX4stQ1LrRgyU4fVmR3l31VRbH60kN8tFWk6gREjI2LCZxRWECfbWSUnA
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAHAzCnLVtRkCgyqhFEoeKYw
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNTAxMTAxODI1
MTFaFw0yNTA3MDkxODI1MTFaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCoH0MspP58MiGTPha+mn1WzCI23OgX5wLB
sXU0Br/FkQPM9EXOhArvxMOyFi0Sfz0HX20qlaIHxviaVNYpVMgmQO8x3Ww9zBVF9wpTnF6HSZ8s
ZK7KHZhg43rwOEmRoA+3JXcgbmZqmZvLQwkGMld+HnQzJrvuFwXPlQt38yzNtRjWR2JmNn19OnEH
uBaFE7b0Pl93kJE60o561TAoFS8AoP4rZFUSqtCL7LD2JseW1+SaJcUhJzLxStodIIc6hQbzOQ/f
EvWDWbXF7nZWcQ5RDe7KgHIqwT8/8zsdCNiB2WW7SyjRRVL1CuoqCbhtervvgZmB3EXbLpXyNsoW
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgh77JjFqgH4xKTtIt5F0dwlldr1LZ
Twp6YzpIHAvsOHQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjA4MDkwNzI0WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBABmxGQymQyecL+k8l2d5bDdQ2vfqyydsoN6cAEiRyBpT1OpY
y2Y1h6IFfO/z7XetzmgwOEmJjE6DYD+6OtIhfKHDKv7K6Tz0A80Q7s3AEhROpmzl9v0vwZ9iwhaj
sw792gbLEHMksu+/wSrWd/2FGdTBMK73PDo1ij1JYCMWP/P/6sOB1kbrwfg6vQi62h0TJrYuAIoB
5fZTNbzMPP8sUTXpuvsADqD+u2NCo5rmUxxtq6VyTbaXtFrD3HsRqd6qshUoCSfamhNuKoLYLd0h
IntiS3QOTkvFw4zHIlbiXe2KvXNrxa0dQuf4CIZpduyHEG6vALWywfNR0SrduZGHDDo=
--000000000000acec14062d9dcd2b--

