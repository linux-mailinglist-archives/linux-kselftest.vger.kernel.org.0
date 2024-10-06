Return-Path: <linux-kselftest+bounces-19128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D677F991E73
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 15:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0650A1C20619
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41430175D38;
	Sun,  6 Oct 2024 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cld0LxQR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F7EC5
	for <linux-kselftest@vger.kernel.org>; Sun,  6 Oct 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728220694; cv=none; b=RG/X1XmEB+GphD48Q4VRmydC07lAm1NuhEsDrObzV4jMzvXrdi2Ymwq72KBsRVcwNQH7QPhNTqmAGzzFP80wjQ0yALyQbFp0dvJrIEUDkwOX2F8sMduppZ+hmXntc0Ov7wxjYm/q9NpJo4SD7CNy3DJDsTTuiAVazvuIfnCGoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728220694; c=relaxed/simple;
	bh=Hp4/99Nug2oU1/XkcYrBQYH1XahWruSKp2vh6ow9FPk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Mr5QQbGerDLCidXsEKlNQa+Ng0HnKm3PP4/r3kLUBA3mmQ4+dZlg5f/Aifn1IaVZ0+MbcfI42EahmrcvLjE7nCfmw7nEyTp3+feg6ZNcFu5NEjLSsPVYXvutF4aSiBHKh0GxWFIWc747dPjnGgWPOSWlCGVBaZvjrMDct9gb3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cld0LxQR; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cb27e974ceso25362936d6.1
        for <linux-kselftest@vger.kernel.org>; Sun, 06 Oct 2024 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728220689; x=1728825489; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4B6iwwlt1XcfrAu2uR5h4j7IP3dNe1xODabG6PfX40=;
        b=Cld0LxQRAgnJl/r1WO1xCBRZETgsfVUnJYrx/8ZMZa+7qNm+9FQmAkIQwzpfJSW5vY
         BRL6oWnnBnsI7ybS7JYkK2y+MNP1GUxX3g1+FGdxGHGXr9bG9sPlsXcwVP5zGjK5MrOy
         pb3qPlHFTVF7Kpzgglvwvs5lpybXDTIQ6ZmgL3/lPbDeDZw4XRNZqPGS9EXyc4xHVtLG
         Yahxlt7LFO6v2NdGZju96aYLNlZ3JYjztOIKCR4z08hG596GtxRrOd7+6doDxMg2XzAc
         FkhgMaYm2LOgZq3ujYsmXlKj4WFH0WdYpGJ156oqjvAYSJF6emJFDn4cGc0wAuBAz3sD
         xY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728220689; x=1728825489;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4B6iwwlt1XcfrAu2uR5h4j7IP3dNe1xODabG6PfX40=;
        b=JKsw25FMsEVXcfSLsf2WX5zdi9ZCBHJLi42l4pENz+UNviYUdk75ZJKHc7OXebfF0w
         Wvf6Vbpv1J5wlN+HJSB9z4dZI3uS8rXbKIGhoYD0wm9B8dP0dvIxKIPQr+lz1Ts+ilzP
         SeyNGNWSDO5vRqY2wi51L2Ac8a+GAaxau02CmbJH2Aa6bTiotOkFvnxrUI9wSD9ryDZM
         b4Dy7VeHw/oRTTkdPsBJJv/JvF9YNnXaa2M8XCRZ3WPcNR0ZsmeJh9c2ZMPbRe2ds0ye
         dnfucBJXknkQgPg83dLiMGnX+pxgjREjrvwK9/KsValFyc+QERdBUpICVl0thL3OFLxS
         DkZg==
X-Forwarded-Encrypted: i=1; AJvYcCU4UiAQCS8dwzcJAITjdLJcX7mnGVBMwhk7ldpVXR9MYWMQuIvCyl5qm+X06c3jPrEMo+c/fvawPebNkFg1mMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAPgDMFrBJWmbohtADHIOHrDoLj3tsz2K4KMf6AKgziZX37MS1
	LgvkTMXIk8YZQm21/IL7TXgainm5iNj0UDhGAt3RZQXlQzz5SHoNbCiX9bu9g70=
X-Google-Smtp-Source: AGHT+IFM4dIYBNQf4JurGGagqRKaLYl/JFqkWOrQ+J3zx2IbxbisDwaY6BCs2hFxIrq/bKrbFWZykw==
X-Received: by 2002:a05:6214:440c:b0:6cb:27e6:393f with SMTP id 6a1803df08f44-6cb9a4ea384mr120414406d6.36.1728220688872;
        Sun, 06 Oct 2024 06:18:08 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46cced5sm16756606d6.7.2024.10.06.06.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 06:18:07 -0700 (PDT)
Date: Sun, 6 Oct 2024 09:18:05 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
cc: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com, 
    quic_jjohnson@quicinc.com, macro@orcam.me.uk, tpiepho@gmail.com, 
    linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
    skhan@linuxfoundation.org, ricardo@marliere.net, 
    linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] lib: math: Move kunit tests into tests/ subdir
In-Reply-To: <20241005222446.10471-1-luis.hernandez093@gmail.com>
Message-ID: <97324415-r1q5-04op-3364-rnr2q3618oo1@onlyvoer.pbz>
References: <20241005222446.10471-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 5 Oct 2024, Luis Felipe Hernandez wrote:

> This patch is a follow-up task from a discussion stemming from point 3
> in a recent patch introducing the int_pow kunit test [1] and
> documentation regarding kunit test style and nomenclature [2].
> 
> Colocate all kunit test suites in lib/math/tests/ and
> follow recommended naming convention for files <suite>_kunit.c
> and kconfig entries CONFIG_<name>_KUNIT_TEST.
> 
> Link: https://lore.kernel.org/all/CABVgOS=-vh5TqHFCq_jo=ffq8v_nGgr6JsPnOZag3e6+19ysxQ@mail.gmail.com/ [1]
> Link: https://docs.kernel.org/dev-tools/kunit/style.html [2]
> 
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>

For the mul_u64_u64_div_u64 part:

Acked-by: Nicolas Pitre <npitre@baylibre.com>

> ---
> Changes in v2: Fix cc recipient list inclusion in cover letter
> Changes in v3: Update mul_u64_u64_div_u64_kunit.c path in comment describing shell script
> ---
>  arch/m68k/configs/amiga_defconfig                           | 2 +-
>  arch/m68k/configs/apollo_defconfig                          | 2 +-
>  arch/m68k/configs/atari_defconfig                           | 2 +-
>  arch/m68k/configs/bvme6000_defconfig                        | 2 +-
>  arch/m68k/configs/hp300_defconfig                           | 2 +-
>  arch/m68k/configs/mac_defconfig                             | 2 +-
>  arch/m68k/configs/multi_defconfig                           | 2 +-
>  arch/m68k/configs/mvme147_defconfig                         | 2 +-
>  arch/m68k/configs/mvme16x_defconfig                         | 2 +-
>  arch/m68k/configs/q40_defconfig                             | 2 +-
>  arch/m68k/configs/sun3_defconfig                            | 2 +-
>  arch/m68k/configs/sun3x_defconfig                           | 2 +-
>  arch/powerpc/configs/ppc64_defconfig                        | 2 +-
>  lib/Kconfig.debug                                           | 6 +++---
>  lib/math/Makefile                                           | 5 +----
>  lib/math/tests/Makefile                                     | 5 ++++-
>  lib/math/{test_div64.c => tests/div64_kunit.c}              | 0
>  .../mul_u64_u64_div_u64_kunit.c}                            | 2 +-
>  lib/math/{rational-test.c => tests/rational_kunit.c}        | 0
>  19 files changed, 22 insertions(+), 22 deletions(-)
>  rename lib/math/{test_div64.c => tests/div64_kunit.c} (100%)
>  rename lib/math/{test_mul_u64_u64_div_u64.c => tests/mul_u64_u64_div_u64_kunit.c} (98%)
>  rename lib/math/{rational-test.c => tests/rational_kunit.c} (100%)
> 
> diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
> index d01dc47d52ea..7ba9311c084c 100644
> --- a/arch/m68k/configs/amiga_defconfig
> +++ b/arch/m68k/configs/amiga_defconfig
> @@ -619,7 +619,7 @@ CONFIG_KUNIT=m
>  CONFIG_KUNIT_ALL_TESTS=m
>  CONFIG_TEST_DHRY=m
>  CONFIG_TEST_MIN_HEAP=m
> -CONFIG_TEST_DIV64=m
> +CONFIG_DIV64_KUNIT_TEST=m
>  CONFIG_REED_SOLOMON_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=m
>  CONFIG_ASYNC_RAID6_TEST=m
> diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
> index 46808e581d7b..273fe4032b85 100644
> --- a/arch/m68k/configs/apollo_defconfig
> +++ b/arch/m68k/configs/apollo_defconfig
> @@ -576,7 +576,7 @@ CONFIG_KUNIT=m
>  CONFIG_KUNIT_ALL_TESTS=m
>  CONFIG_TEST_DHRY=m
>  CONFIG_TEST_MIN_HEAP=m
> -CONFIG_TEST_DIV64=m
> +CONFIG_DIV64_KUNIT_TEST=m
>  CONFIG_REED_SOLOMON_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=m
>  CONFIG_ASYNC_RAID6_TEST=m
> diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
> index 4469a7839c9d..9976cda99fc1 100644
> --- a/arch/m68k/configs/atari_defconfig
> +++ b/arch/m68k/configs/atari_defconfig
> @@ -596,7 +596,7 @@ CONFIG_KUNIT=m
>  CONFIG_KUNIT_ALL_TESTS=m
>  CONFIG_TEST_DHRY=m
>  CONFIG_TEST_MIN_HEAP=m
> -CONFIG_TEST_DIV64=m
> +CONFIG_DIV64_KUNIT_TEST=m
>  CONFIG_REED_SOLOMON_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=m
>  CONFIG_ASYNC_RAID6_TEST=m
> diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
> index c0719322c028..f59082c8fe06 100644
> --- a/arch/m68k/configs/bvme6000_defconfig
> +++ b/arch/m68k/configs/bvme6000_defconfig
> @@ -568,7 +568,7 @@ CONFIG_KUNIT=m
>  CONFIG_KUNIT_ALL_TESTS=m
>  CONFIG_TEST_DHRY=m
>  CONFIG_TEST_MIN_HEAP=m
> -CONFIG_TEST_DIV64=m
> +CONFIG_DIV64_KUNIT_TEST=m
>  CONFIG_REED_SOLOMON_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=m
>  CONFIG_ASYNC_RAID6_TEST=m
> diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
> index 8d429e63f8f2..6db3556da9ac 100644
> --- a/arch/m68k/configs/hp300_defconfig
> +++ b/arch/m68k/configs/hp300_defconfig
> @@ -578,7 +578,7 @@ CONFIG_KUNIT=m
>  CONFIG_KUNIT_ALL_TESTS=m
>  CONFIG_TEST_DHRY=m
>  CONFIG_TEST_MIN_HEAP=m
> -CONFIG_TEST_DIV64=m
> +CONFIG_DIV64_KUNIT_TEST=m
>  CONFIG_REED_SOLOMON_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=m
>  CONFIG_ASYNC_RAID6_TEST=m
> diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
> index bafd33da27c1..25c06b5c83ee 100644
> --- a/arch/m68k/configs/mac_defconfig
> +++ b/arch/m68k/configs/mac_defconfig
> @@ -595,7 +595,7 @@ CONFIG_KUNIT=m
>  CONFIG_KUNIT_ALL_TESTS=m
>  CONFIG_TEST_DHRY=m
>  CONFIG_TEST_MIN_HEAP=m
> -CONFIG_TEST_DIV64=m
> +CONFIG_DIV64_KUNIT_TEST=m
>  CONFIG_REED_SOLOMON_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=m
>  CONFIG_ASYNC_RAID6_TEST=m
> diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
> index 6f5ca3f85ea1..35e57e0ee139 100644
> --- a/arch/m68k/configs/multi_defconfig
> +++ b/arch/m68k/configs/multi_defconfig
> @@ -681,7 +681,7 @@ CONFIG_KUNIT=m
>  CONFIG_KUNIT_ALL_TESTS=m
>  CONFIG_TEST_DHRY=m
>  CONFIG_TEST_MIN_HEAP=m
> -CONFIG_TEST_DIV64=m
> +CONFIG_DIV64_KUNIT_TEST=m
>  CONFIG_REED_SOLOMON_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=m
>  CONFIG_ASYNC_RAID6_TEST=m
> diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
> index d16b328c7136..d253b686119a 100644
> --- a/arch/m68k/configs/mvme147_defconfig
> +++ b/arch/m68k/configs/mvme147_defconfig
> @@ -567,7 +567,7 @@ CONFIG_KUNIT=m
>  CONFIG_KUNIT_ALL_TESTS=m
>  CONFIG_TEST_DHRY=m
>  CONFIG_TEST_MIN_HEAP=m
> -CONFIG_TEST_DIV64=m
> +CONFIG_DIV64_KUNIT_TEST=m
>  CONFIG_REED_SOLOMON_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=m
>  CONFIG_ASYNC_RAID6_TEST=m
> diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
> index 80f6c15a5ed5..62bc6ad63783 100644
> --- a/arch/m68k/configs/mvme16x_defconfig
> +++ b/arch/m68k/configs/mvme16x_defconfig
> @@ -568,7 +568,7 @@ CONFIG_KUNIT=m
>  CONFIG_KUNIT_ALL_TESTS=m
>  CONFIG_TEST_DHRY=m
>  CONFIG_TEST_MIN_HEAP=m
> -CONFIG_TEST_DIV64=m
> +CONFIG_DIV64_KUNIT_TEST=m
>  CONFIG_REED_SOLOMON_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=m
>  CONFIG_ASYNC_RAID6_TEST=m
> diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
> index 0e81589f0ee2..caba39c61bac 100644
> --- a/arch/m68k/configs/q40_defconfig
> +++ b/arch/m68k/configs/q40_defconfig
> @@ -585,7 +585,7 @@ CONFIG_KUNIT=m
>  CONFIG_KUNIT_ALL_TESTS=m
>  CONFIG_TEST_DHRY=m
>  CONFIG_TEST_MIN_HEAP=m
> -CONFIG_TEST_DIV64=m
> +CONFIG_DIV64_KUNIT_TEST=m
>  CONFIG_REED_SOLOMON_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=m
>  CONFIG_ASYNC_RAID6_TEST=m
> diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
> index 8cd785290339..a348f645ed55 100644
> --- a/arch/m68k/configs/sun3_defconfig
> +++ b/arch/m68k/configs/sun3_defconfig
> @@ -565,7 +565,7 @@ CONFIG_KUNIT=m
>  CONFIG_KUNIT_ALL_TESTS=m
>  CONFIG_TEST_DHRY=m
>  CONFIG_TEST_MIN_HEAP=m
> -CONFIG_TEST_DIV64=m
> +CONFIG_DIV64_KUNIT_TEST=m
>  CONFIG_REED_SOLOMON_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=m
>  CONFIG_ASYNC_RAID6_TEST=m
> diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
> index 78035369f60f..f8b3cfc3275b 100644
> --- a/arch/m68k/configs/sun3x_defconfig
> +++ b/arch/m68k/configs/sun3x_defconfig
> @@ -566,7 +566,7 @@ CONFIG_KUNIT=m
>  CONFIG_KUNIT_ALL_TESTS=m
>  CONFIG_TEST_DHRY=m
>  CONFIG_TEST_MIN_HEAP=m
> -CONFIG_TEST_DIV64=m
> +CONFIG_DIV64_KUNIT_TEST=m
>  CONFIG_REED_SOLOMON_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=m
>  CONFIG_ASYNC_RAID6_TEST=m
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
> index a5e3e7f97f4d..f1f21765c0c1 100644
> --- a/arch/powerpc/configs/ppc64_defconfig
> +++ b/arch/powerpc/configs/ppc64_defconfig
> @@ -435,7 +435,7 @@ CONFIG_KUNIT=m
>  CONFIG_KUNIT_ALL_TESTS=m
>  CONFIG_LKDTM=m
>  CONFIG_TEST_MIN_HEAP=m
> -CONFIG_TEST_DIV64=m
> +CONFIG_DIV64_KUNIT_TEST=m
>  CONFIG_BACKTRACE_SELF_TEST=m
>  CONFIG_TEST_REF_TRACKER=m
>  CONFIG_RBTREE_TEST=m
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 7315f643817a..0d6c979f0bfd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2296,7 +2296,7 @@ config TEST_SORT
>  
>  	  If unsure, say N.
>  
> -config TEST_DIV64
> +config DIV64_KUNIT_TEST
>  	tristate "64bit/32bit division and modulo test"
>  	depends on DEBUG_KERNEL || m
>  	help
> @@ -2306,7 +2306,7 @@ config TEST_DIV64
>  
>  	  If unsure, say N.
>  
> -config TEST_MULDIV64
> +config MULDIV64_KUNIT_TEST
>  	tristate "mul_u64_u64_div_u64() test"
>  	depends on DEBUG_KERNEL || m
>  	help
> @@ -3089,7 +3089,7 @@ endmenu # "Rust"
>  
>  endmenu # Kernel hacking
>  
> -config INT_POW_TEST
> +config INT_POW_KUNIT_TEST
>  	tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
>  	default KUNIT_ALL_TESTS
> diff --git a/lib/math/Makefile b/lib/math/Makefile
> index 3ef11305f8d2..1c489501ff57 100644
> --- a/lib/math/Makefile
> +++ b/lib/math/Makefile
> @@ -5,7 +5,4 @@ obj-$(CONFIG_CORDIC)		+= cordic.o
>  obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
>  obj-$(CONFIG_RATIONAL)		+= rational.o
>  
> -obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
> -obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
> -obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
> -obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
> +obj-y  += tests/
> diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
> index 6a169123320a..f9a0a0e6b73a 100644
> --- a/lib/math/tests/Makefile
> +++ b/lib/math/tests/Makefile
> @@ -1,3 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
> -obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
> +obj-$(CONFIG_DIV64_KUNIT_TEST)    += div64_kunit.o
> +obj-$(CONFIG_INT_POW_KUNIT_TEST)  += int_pow_kunit.o
> +obj-$(CONFIG_MULDIV64_KUNIT_TEST) += mul_u64_u64_div_u64_kunit.o
> +obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational_kunit.o
> diff --git a/lib/math/test_div64.c b/lib/math/tests/div64_kunit.c
> similarity index 100%
> rename from lib/math/test_div64.c
> rename to lib/math/tests/div64_kunit.c
> diff --git a/lib/math/test_mul_u64_u64_div_u64.c b/lib/math/tests/mul_u64_u64_div_u64_kunit.c
> similarity index 98%
> rename from lib/math/test_mul_u64_u64_div_u64.c
> rename to lib/math/tests/mul_u64_u64_div_u64_kunit.c
> index 58d058de4e73..f61f571a0a2e 100644
> --- a/lib/math/test_mul_u64_u64_div_u64.c
> +++ b/lib/math/tests/mul_u64_u64_div_u64_kunit.c
> @@ -49,7 +49,7 @@ static test_params test_values[] = {
>   *
>   * #!/bin/sh
>   * sed -ne 's/^{ \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\) },$/\1 \2 \3 \4/p' \
> - *     lib/math/test_mul_u64_u64_div_u64.c |
> + *     lib/math/tests/mul_u64_u64_div_u64_kunit.c |
>   * while read a b c r; do
>   *   expected=$( printf "obase=16; ibase=16; %X * %X / %X\n" $a $b $c | bc )
>   *   given=$( printf "%X\n" $r )
> diff --git a/lib/math/rational-test.c b/lib/math/tests/rational_kunit.c
> similarity index 100%
> rename from lib/math/rational-test.c
> rename to lib/math/tests/rational_kunit.c
> -- 
> 2.46.2
> 
> 

