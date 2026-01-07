Return-Path: <linux-kselftest+bounces-48375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46507CFBF8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 05:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B427130031B5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 04:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8B5258CED;
	Wed,  7 Jan 2026 04:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQK9mRP1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDEE24E4A8
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767760373; cv=none; b=QbpNflUHsQQ8etVE08UEiLJLC9whcNz+rBMhwbtLpRq3WtnClW+aeDDNzRBD+hhvmWDbMXwf3A6ueSyHeXWUhx3n43ODOEFTW1lfNj/CQ+TGmaSwzdN2bNM4YBcMZVrFGRssuGrtlqao1cdZcgG3WEAWtMpJ7+1orJtErvd91w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767760373; c=relaxed/simple;
	bh=2ZQQ2eV9pwvbyxmdMEmXgSajm6ZkIJojQ0GMr51zRKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OU+e7dDYJvwcyp8Bsb+EyBxeCWF5fYw+pqaM7N03PUuY3nC6r16Dk6LNxHYTYx4PqSmCoyzOaph6szcQUS7zo/kaOEqhqyAfQZ6DR/OwEfMGLiVuNvyX5CXqWDkjeKR0mLsBm9lETyL0Lk5lttOwDKPKeO7JHGSRRLw2jd3cL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQK9mRP1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc544b09so1077936f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 20:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767760367; x=1768365167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JTi/8ELG11Hb4yi59ff6qjjj9/T0Wy5reGa6dNTAQyY=;
        b=eQK9mRP1P7nx+PhltTSf0L9GafXsykxUPSRFKKTukJUUj+3deiP8ThbI5m1UP5k5md
         3jY+I5bR6M57Quy5HALvGbna3CwGGySydPtkqxsslUaUYRXsYVgjpZTPzhcnRa2VoPpc
         ptz+9oLQIbgf2+iFWjPrEnlfSiLchAATkJ/KqtWxEFeStQgM4TPUIqQKBbE9aWjIprWQ
         fgZ6RIEdHwiq4Uy+0qpV99zAIC+SuCx7pifQHuWcDkSLIvCjD6j7KwzKRCAstgkVFAPg
         QFNyHHAzcf/IKEXUyjo7T1ZFsVmNM0MxCq2n71OL9oAjzy8bedaSK55IAAxDHtwGZYzn
         iGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767760367; x=1768365167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTi/8ELG11Hb4yi59ff6qjjj9/T0Wy5reGa6dNTAQyY=;
        b=Bt3TLVPR91l/ggBqrC9r4o/ioPIQHBMiZ+bAMWhUoZEq84qiHoFs8cG9MDqIQeFdk/
         eEVx6LTdBMe9kzaQNJQSmQTbAOd3PRKUES5YfUwjnconimXTJhaIKUEzPO4BvPr46OOd
         XL+TaxtTEf1RuNDdrjmvu1QC6YM6dt00LsEs0qf3B+6qrRVMZ4OWDl36BQOPhcjw2nFE
         YVIQGXe52lZ7jRg86Lkz1eTqk/l6J5x5M7seHXAy2trsplMATMnUf90donsWi0ORxJq7
         JZGlZYBDGpbYHF3fsdR+8a/N1Smu6R7eemEvKgELlEwvc+zY82788H+P/Bipdz4iEPkA
         SlXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcdUKRoKzDchS8CmT7IhwH2THHitmvT8M2KPY4w5m0BXM0x+Z+S4UVlXgmA/1rDwgox98fb1CUR+MgDZ4XNJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlrTWgKBGIEqu2GcObFQphPnnD0LEy9FwdaHQR4Xte58DcEbRk
	XpBE2TcIFGtFxCI/03zyt84wKa49WS+zWJ4nzLXqkA6t1w/GShjsmjBdSEUxylJVUulzevJnOs0
	Xiuq+9AScIpPGJgoKB8eZQDAYBXcIvi9BCEvBDrJc
X-Gm-Gg: AY/fxX5tXV4fjC+b4H/XBVZ1q3LOcFBn6lpUeU9oQbrMDI9YrbS+CbSAbvuwLBTIQ2D
	/FvBMCuztxFIk2V0e2c0xRRT4xQOWvEdBwZwZWyNJHN5zfqPegvTBocAuIwfKX7OGC/m852sHsG
	7OaSDVp0QPKQPkx4NOmisAfMl8rgCQEvbF0QE88akGVKmVeKAXdTD1WU+tnEx3ZHpHQHxrXPRTU
	+hxF4n/ys2IwWNw4z2Dw5YGuBmn4w9e0XAtLBsgsp09+NMcTVr/3x7/Ukndzy49LYR2PMWyjBAS
	aZo5
X-Google-Smtp-Source: AGHT+IEhwOG7aqS7A+r1lY5NQ6GnTS8UGRXoSu6vyhdcJS84BBE8ZUDE1h6jdra6Cp7vUsFlt8AlWyclnCHP+MpCA78=
X-Received: by 2002:a05:6000:208a:b0:431:92e:1d44 with SMTP id
 ffacd0b85a97d-432c3790c02mr1370216f8f.20.1767760366724; Tue, 06 Jan 2026
 20:32:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106141057.91203-1-note351@hotmail.com>
In-Reply-To: <20260106141057.91203-1-note351@hotmail.com>
From: David Gow <davidgow@google.com>
Date: Wed, 7 Jan 2026 12:32:35 +0800
X-Gm-Features: AQt7F2p-PAJOnRo2m7ItQ_ClNmZL0g3rvi-FzO6KUKgwGLhvY1QzX4pUWkJ4KDs
Message-ID: <CABVgOSk+4YC_0h533uSYif+aKuFFgVGk7Ni30u2drw_UXnOreQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib/glob: convert selftest to KUnit
To: Kir Chou <note351@hotmail.com>
Cc: akpm@linux-foundation.org, geert@linux-m68k.org, 
	linux-kernel@vger.kernel.org, brendan.higgins@linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kirchou@google.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c056360647c4c883"

--000000000000c056360647c4c883
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Jan 2026 at 22:11, Kir Chou <note351@hotmail.com> wrote:
>
> This patch converts the existing glob selftest (lib/globtest.c) to use
> the KUnit framework (lib/glob_kunit.c).
>
> The new test:
>
> - Migrates all 64 test cases from the original test to the KUnit suite.
> - Removes the custom 'verbose' module parameter as KUnit handles logging.
> - Updates Kconfig.debug and Makefile to support the new KUnit test.
> - Updates Kconfig and Makefile to remove the original selftest.
> - Updates GLOB_SELFTEST to GLOB_KUNIT_TEST for arch/m68k/configs.
>
> This commit is verified by `./tools/testing/kunit/kunit.py run`
> with the .kunit/.kunitconfig:
>
> ```
> CONFIG_KUNIT=y
> CONFIG_GLOB_KUNIT_TEST=y
> ```
>
> Signed-off-by: Kir Chou <note351@hotmail.com>
> ---
> v2:
>  - Remove CONFIG_GLOB_KUNIT_TEST from defconfigs as it's implicitly enabled
>    by CONFIG_KUNIT_ALL_TESTS. (Suggested by Geert)
> ---

Thanks -- this works well here.

One suggestion would be to move the test file into lib/tests/ -- this
is where we're keeping most of the KUnit tests for lib/ in order to
avoid cluttering up lib/ and to make it possible to tab complete all
of lib/glob.c. (Since the old file already started with lib/glob, this
wouldn't be a regression, though, so if there's a particularly good
reason to keep it there, it'd be okay. But otherwise, putting it in
lib/tests/ would be best.)

With that changed, this is:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  arch/m68k/configs/amiga_defconfig    |   1 -
>  arch/m68k/configs/apollo_defconfig   |   1 -
>  arch/m68k/configs/atari_defconfig    |   1 -
>  arch/m68k/configs/bvme6000_defconfig |   1 -
>  arch/m68k/configs/hp300_defconfig    |   1 -
>  arch/m68k/configs/mac_defconfig      |   1 -
>  arch/m68k/configs/multi_defconfig    |   1 -
>  arch/m68k/configs/mvme147_defconfig  |   1 -
>  arch/m68k/configs/mvme16x_defconfig  |   1 -
>  arch/m68k/configs/q40_defconfig      |   1 -
>  arch/m68k/configs/sun3_defconfig     |   1 -
>  arch/m68k/configs/sun3x_defconfig    |   1 -
>  lib/Kconfig                          |  13 ---
>  lib/Kconfig.debug                    |  13 +++
>  lib/Makefile                         |   2 +-
>  lib/glob_kunit.c                     | 122 +++++++++++++++++++
>  lib/globtest.c                       | 167 ---------------------------
>  17 files changed, 136 insertions(+), 193 deletions(-)
>  create mode 100644 lib/glob_kunit.c
>  delete mode 100644 lib/globtest.c
>
> diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
> index bfc1ee7c8..b51e22dea 100644
> --- a/arch/m68k/configs/amiga_defconfig
> +++ b/arch/m68k/configs/amiga_defconfig
> @@ -600,7 +600,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_CRC_BENCHMARK=y
>  CONFIG_XZ_DEC_TEST=m
> -CONFIG_GLOB_SELFTEST=m
>  # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TEST_LOCKUP=m
> diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
> index d9d1f3c4c..bb326aabe 100644
> --- a/arch/m68k/configs/apollo_defconfig
> +++ b/arch/m68k/configs/apollo_defconfig
> @@ -557,7 +557,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_CRC_BENCHMARK=y
>  CONFIG_XZ_DEC_TEST=m
> -CONFIG_GLOB_SELFTEST=m
>  # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TEST_LOCKUP=m
> diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
> index 523205adc..66af496e0 100644
> --- a/arch/m68k/configs/atari_defconfig
> +++ b/arch/m68k/configs/atari_defconfig
> @@ -577,7 +577,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_CRC_BENCHMARK=y
>  CONFIG_XZ_DEC_TEST=m
> -CONFIG_GLOB_SELFTEST=m
>  # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TEST_LOCKUP=m
> diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
> index 7b0a4ef0b..935282b27 100644
> --- a/arch/m68k/configs/bvme6000_defconfig
> +++ b/arch/m68k/configs/bvme6000_defconfig
> @@ -549,7 +549,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_CRC_BENCHMARK=y
>  CONFIG_XZ_DEC_TEST=m
> -CONFIG_GLOB_SELFTEST=m
>  # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TEST_LOCKUP=m
> diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
> index 089c5c394..31f5220be 100644
> --- a/arch/m68k/configs/hp300_defconfig
> +++ b/arch/m68k/configs/hp300_defconfig
> @@ -559,7 +559,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_CRC_BENCHMARK=y
>  CONFIG_XZ_DEC_TEST=m
> -CONFIG_GLOB_SELFTEST=m
>  # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TEST_LOCKUP=m
> diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
> index 5f2484c36..99fa2286a 100644
> --- a/arch/m68k/configs/mac_defconfig
> +++ b/arch/m68k/configs/mac_defconfig
> @@ -576,7 +576,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_CRC_BENCHMARK=y
>  CONFIG_XZ_DEC_TEST=m
> -CONFIG_GLOB_SELFTEST=m
>  # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TEST_LOCKUP=m
> diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
> index 74f0a1f6d..9332c00bc 100644
> --- a/arch/m68k/configs/multi_defconfig
> +++ b/arch/m68k/configs/multi_defconfig
> @@ -663,7 +663,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_CRC_BENCHMARK=y
>  CONFIG_XZ_DEC_TEST=m
> -CONFIG_GLOB_SELFTEST=m
>  # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TEST_LOCKUP=m
> diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
> index 4bee18c82..e5ba3e899 100644
> --- a/arch/m68k/configs/mvme147_defconfig
> +++ b/arch/m68k/configs/mvme147_defconfig
> @@ -549,7 +549,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_CRC_BENCHMARK=y
>  CONFIG_XZ_DEC_TEST=m
> -CONFIG_GLOB_SELFTEST=m
>  # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TEST_LOCKUP=m
> diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
> index 322c17e55..282900b7e 100644
> --- a/arch/m68k/configs/mvme16x_defconfig
> +++ b/arch/m68k/configs/mvme16x_defconfig
> @@ -550,7 +550,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_CRC_BENCHMARK=y
>  CONFIG_XZ_DEC_TEST=m
> -CONFIG_GLOB_SELFTEST=m
>  # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TEST_LOCKUP=m
> diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
> index 82f9baab8..e572c7df1 100644
> --- a/arch/m68k/configs/q40_defconfig
> +++ b/arch/m68k/configs/q40_defconfig
> @@ -566,7 +566,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_CRC_BENCHMARK=y
>  CONFIG_XZ_DEC_TEST=m
> -CONFIG_GLOB_SELFTEST=m
>  # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TEST_LOCKUP=m
> diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
> index f94ad226c..03bd60c5b 100644
> --- a/arch/m68k/configs/sun3_defconfig
> +++ b/arch/m68k/configs/sun3_defconfig
> @@ -547,7 +547,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_CRC_BENCHMARK=y
>  CONFIG_XZ_DEC_TEST=m
> -CONFIG_GLOB_SELFTEST=m
>  # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TEST_LOCKUP=m
> diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
> index a5ecfc505..0fba766ce 100644
> --- a/arch/m68k/configs/sun3x_defconfig
> +++ b/arch/m68k/configs/sun3x_defconfig
> @@ -547,7 +547,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_CRC_BENCHMARK=y
>  CONFIG_XZ_DEC_TEST=m
> -CONFIG_GLOB_SELFTEST=m
>  # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TEST_LOCKUP=m
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 2923924be..0f2fb9610 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -430,19 +430,6 @@ config GLOB
>           are compiling an out-of tree driver which tells you that it
>           depends on this.
>
> -config GLOB_SELFTEST
> -       tristate "glob self-test on init"
> -       depends on GLOB
> -       help
> -         This option enables a simple self-test of the glob_match
> -         function on startup.  It is primarily useful for people
> -         working on the code to ensure they haven't introduced any
> -         regressions.
> -
> -         It only adds a little bit of code and slows kernel boot (or
> -         module load) by a small amount, so you're welcome to play with
> -         it, but you probably don't need it.
> -
>  #
>  # Netlink attribute parsing support is select'ed if needed
>  #
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ba36939fd..e4347e145 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -3354,6 +3354,19 @@ config PRIME_NUMBERS_KUNIT_TEST
>
>           If unsure, say N
>
> +config GLOB_KUNIT_TEST
> +       tristate "Glob matching test" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       select GLOB
> +       help
> +         Enable this option to test the glob functions at runtime.
> +
> +         This test suite verifies the correctness of glob_match() across various
> +         scenarios, including edge cases.
> +
> +         If unsure, say N
> +
>  endif # RUNTIME_TESTING_MENU
>
>  config ARCH_USE_MEMTEST
> diff --git a/lib/Makefile b/lib/Makefile
> index aaf677cf4..78d7deabe 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -226,7 +226,7 @@ obj-$(CONFIG_CLOSURES) += closure.o
>  obj-$(CONFIG_DQL) += dynamic_queue_limits.o
>
>  obj-$(CONFIG_GLOB) += glob.o
> -obj-$(CONFIG_GLOB_SELFTEST) += globtest.o
> +obj-$(CONFIG_GLOB_KUNIT_TEST) += glob_kunit.o
>
>  obj-$(CONFIG_DIMLIB) += dim/
>  obj-$(CONFIG_SIGNATURE) += digsig.o
> diff --git a/lib/glob_kunit.c b/lib/glob_kunit.c
> new file mode 100644
> index 000000000..797e32a8c
> --- /dev/null
> +++ b/lib/glob_kunit.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test cases for glob functions.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/glob.h>
> +#include <linux/module.h>
> +
> +struct glob_test_case {
> +       // Pattern to match.
> +       const char *pat;
> +       // String to match against.
> +       const char *str;
> +       // Expected glob_match result, true is matched.
> +       bool expected;
> +};
> +
> +static const struct glob_test_case glob_test_cases[] = {
> +       /* Some basic tests */
> +       { .pat = "a", .str = "a", .expected = true },
> +       { .pat = "a", .str = "b", .expected = false },
> +       { .pat = "a", .str = "aa", .expected = false },
> +       { .pat = "a", .str = "", .expected = false },
> +       { .pat = "", .str = "", .expected = true },
> +       { .pat = "", .str = "a", .expected = false },
> +       /* Simple character class tests */
> +       { .pat = "[a]", .str = "a", .expected = true },
> +       { .pat = "[a]", .str = "b", .expected = false },
> +       { .pat = "[!a]", .str = "a", .expected = false },
> +       { .pat = "[!a]", .str = "b", .expected = true },
> +       { .pat = "[ab]", .str = "a", .expected = true },
> +       { .pat = "[ab]", .str = "b", .expected = true },
> +       { .pat = "[ab]", .str = "c", .expected = false },
> +       { .pat = "[!ab]", .str = "c", .expected = true },
> +       { .pat = "[a-c]", .str = "b", .expected = true },
> +       { .pat = "[a-c]", .str = "d", .expected = false },
> +       /* Corner cases in character class parsing */
> +       { .pat = "[a-c-e-g]", .str = "-", .expected = true },
> +       { .pat = "[a-c-e-g]", .str = "d", .expected = false },
> +       { .pat = "[a-c-e-g]", .str = "f", .expected = true },
> +       { .pat = "[]a-ceg-ik[]", .str = "a", .expected = true },
> +       { .pat = "[]a-ceg-ik[]", .str = "]", .expected = true },
> +       { .pat = "[]a-ceg-ik[]", .str = "[", .expected = true },
> +       { .pat = "[]a-ceg-ik[]", .str = "h", .expected = true },
> +       { .pat = "[]a-ceg-ik[]", .str = "f", .expected = false },
> +       { .pat = "[!]a-ceg-ik[]", .str = "h", .expected = false },
> +       { .pat = "[!]a-ceg-ik[]", .str = "]", .expected = false },
> +       { .pat = "[!]a-ceg-ik[]", .str = "f", .expected = true },
> +       /* Simple wild cards */
> +       { .pat = "?", .str = "a", .expected = true },
> +       { .pat = "?", .str = "aa", .expected = false },
> +       { .pat = "??", .str = "a", .expected = false },
> +       { .pat = "?x?", .str = "axb", .expected = true },
> +       { .pat = "?x?", .str = "abx", .expected = false },
> +       { .pat = "?x?", .str = "xab", .expected = false },
> +       /* Asterisk wild cards (backtracking) */
> +       { .pat = "*??", .str = "a", .expected = false },
> +       { .pat = "*??", .str = "ab", .expected = true },
> +       { .pat = "*??", .str = "abc", .expected = true },
> +       { .pat = "*??", .str = "abcd", .expected = true },
> +       { .pat = "??*", .str = "a", .expected = false },
> +       { .pat = "??*", .str = "ab", .expected = true },
> +       { .pat = "??*", .str = "abc", .expected = true },
> +       { .pat = "??*", .str = "abcd", .expected = true },
> +       { .pat = "?*?", .str = "a", .expected = false },
> +       { .pat = "?*?", .str = "ab", .expected = true },
> +       { .pat = "?*?", .str = "abc", .expected = true },
> +       { .pat = "?*?", .str = "abcd", .expected = true },
> +       { .pat = "*b", .str = "b", .expected = true },
> +       { .pat = "*b", .str = "ab", .expected = true },
> +       { .pat = "*b", .str = "ba", .expected = false },
> +       { .pat = "*b", .str = "bb", .expected = true },
> +       { .pat = "*b", .str = "abb", .expected = true },
> +       { .pat = "*b", .str = "bab", .expected = true },
> +       { .pat = "*bc", .str = "abbc", .expected = true },
> +       { .pat = "*bc", .str = "bc", .expected = true },
> +       { .pat = "*bc", .str = "bbc", .expected = true },
> +       { .pat = "*bc", .str = "bcbc", .expected = true },
> +       /* Multiple asterisks (complex backtracking) */
> +       { .pat = "*ac*", .str = "abacadaeafag", .expected = true },
> +       { .pat = "*ac*ae*ag*", .str = "abacadaeafag", .expected = true },
> +       { .pat = "*a*b*[bc]*[ef]*g*", .str = "abacadaeafag", .expected = true },
> +       { .pat = "*a*b*[ef]*[cd]*g*", .str = "abacadaeafag", .expected = false },
> +       { .pat = "*abcd*", .str = "abcabcabcabcdefg", .expected = true },
> +       { .pat = "*ab*cd*", .str = "abcabcabcabcdefg", .expected = true },
> +       { .pat = "*abcd*abcdef*", .str = "abcabcdabcdeabcdefg", .expected = true },
> +       { .pat = "*abcd*", .str = "abcabcabcabcefg", .expected = false },
> +       { .pat = "*ab*cd*", .str = "abcabcabcabcefg", .expected = false },
> +};
> +
> +static void glob_case_to_desc(const struct glob_test_case *t, char *desc)
> +{
> +       snprintf(desc, KUNIT_PARAM_DESC_SIZE, "pat:\"%s\" str:\"%s\"", t->pat, t->str);
> +}
> +
> +KUNIT_ARRAY_PARAM(glob, glob_test_cases, glob_case_to_desc);
> +
> +static void glob_test_match(struct kunit *test)
> +{
> +       const struct glob_test_case *params = test->param_value;
> +
> +       KUNIT_EXPECT_EQ_MSG(test,
> +               glob_match(params->pat, params->str),
> +               params->expected,
> +               "Pattern: \"%s\", String: \"%s\", Expected: %d",
> +               params->pat, params->str, params->expected);
> +}
> +
> +static struct kunit_case glob_kunit_test_cases[] = {
> +       KUNIT_CASE_PARAM(glob_test_match, glob_gen_params),
> +       {}
> +};
> +
> +static struct kunit_suite glob_test_suite = {
> +       .name = "glob",
> +       .test_cases = glob_kunit_test_cases,
> +};
> +
> +kunit_test_suite(glob_test_suite);
> +MODULE_DESCRIPTION("Test cases for glob functions");
> +MODULE_LICENSE("Dual MIT/GPL");
> diff --git a/lib/globtest.c b/lib/globtest.c
> deleted file mode 100644
> index d8e97d43b..000000000
> --- a/lib/globtest.c
> +++ /dev/null
> @@ -1,167 +0,0 @@
> -/*
> - * Extracted fronm glob.c
> - */
> -
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/glob.h>
> -#include <linux/printk.h>
> -
> -/* Boot with "glob.verbose=1" to show successful tests, too */
> -static bool verbose = false;
> -module_param(verbose, bool, 0);
> -
> -struct glob_test {
> -       char const *pat, *str;
> -       bool expected;
> -};
> -
> -static bool __pure __init test(char const *pat, char const *str, bool expected)
> -{
> -       bool match = glob_match(pat, str);
> -       bool success = match == expected;
> -
> -       /* Can't get string literals into a particular section, so... */
> -       static char const msg_error[] __initconst =
> -               KERN_ERR "glob: \"%s\" vs. \"%s\": %s *** ERROR ***\n";
> -       static char const msg_ok[] __initconst =
> -               KERN_DEBUG "glob: \"%s\" vs. \"%s\": %s OK\n";
> -       static char const mismatch[] __initconst = "mismatch";
> -       char const *message;
> -
> -       if (!success)
> -               message = msg_error;
> -       else if (verbose)
> -               message = msg_ok;
> -       else
> -               return success;
> -
> -       printk(message, pat, str, mismatch + 3*match);
> -       return success;
> -}
> -
> -/*
> - * The tests are all jammed together in one array to make it simpler
> - * to place that array in the .init.rodata section.  The obvious
> - * "array of structures containing char *" has no way to force the
> - * pointed-to strings to be in a particular section.
> - *
> - * Anyway, a test consists of:
> - * 1. Expected glob_match result: '1' or '0'.
> - * 2. Pattern to match: null-terminated string
> - * 3. String to match against: null-terminated string
> - *
> - * The list of tests is terminated with a final '\0' instead of
> - * a glob_match result character.
> - */
> -static char const glob_tests[] __initconst =
> -       /* Some basic tests */
> -       "1" "a\0" "a\0"
> -       "0" "a\0" "b\0"
> -       "0" "a\0" "aa\0"
> -       "0" "a\0" "\0"
> -       "1" "\0" "\0"
> -       "0" "\0" "a\0"
> -       /* Simple character class tests */
> -       "1" "[a]\0" "a\0"
> -       "0" "[a]\0" "b\0"
> -       "0" "[!a]\0" "a\0"
> -       "1" "[!a]\0" "b\0"
> -       "1" "[ab]\0" "a\0"
> -       "1" "[ab]\0" "b\0"
> -       "0" "[ab]\0" "c\0"
> -       "1" "[!ab]\0" "c\0"
> -       "1" "[a-c]\0" "b\0"
> -       "0" "[a-c]\0" "d\0"
> -       /* Corner cases in character class parsing */
> -       "1" "[a-c-e-g]\0" "-\0"
> -       "0" "[a-c-e-g]\0" "d\0"
> -       "1" "[a-c-e-g]\0" "f\0"
> -       "1" "[]a-ceg-ik[]\0" "a\0"
> -       "1" "[]a-ceg-ik[]\0" "]\0"
> -       "1" "[]a-ceg-ik[]\0" "[\0"
> -       "1" "[]a-ceg-ik[]\0" "h\0"
> -       "0" "[]a-ceg-ik[]\0" "f\0"
> -       "0" "[!]a-ceg-ik[]\0" "h\0"
> -       "0" "[!]a-ceg-ik[]\0" "]\0"
> -       "1" "[!]a-ceg-ik[]\0" "f\0"
> -       /* Simple wild cards */
> -       "1" "?\0" "a\0"
> -       "0" "?\0" "aa\0"
> -       "0" "??\0" "a\0"
> -       "1" "?x?\0" "axb\0"
> -       "0" "?x?\0" "abx\0"
> -       "0" "?x?\0" "xab\0"
> -       /* Asterisk wild cards (backtracking) */
> -       "0" "*??\0" "a\0"
> -       "1" "*??\0" "ab\0"
> -       "1" "*??\0" "abc\0"
> -       "1" "*??\0" "abcd\0"
> -       "0" "??*\0" "a\0"
> -       "1" "??*\0" "ab\0"
> -       "1" "??*\0" "abc\0"
> -       "1" "??*\0" "abcd\0"
> -       "0" "?*?\0" "a\0"
> -       "1" "?*?\0" "ab\0"
> -       "1" "?*?\0" "abc\0"
> -       "1" "?*?\0" "abcd\0"
> -       "1" "*b\0" "b\0"
> -       "1" "*b\0" "ab\0"
> -       "0" "*b\0" "ba\0"
> -       "1" "*b\0" "bb\0"
> -       "1" "*b\0" "abb\0"
> -       "1" "*b\0" "bab\0"
> -       "1" "*bc\0" "abbc\0"
> -       "1" "*bc\0" "bc\0"
> -       "1" "*bc\0" "bbc\0"
> -       "1" "*bc\0" "bcbc\0"
> -       /* Multiple asterisks (complex backtracking) */
> -       "1" "*ac*\0" "abacadaeafag\0"
> -       "1" "*ac*ae*ag*\0" "abacadaeafag\0"
> -       "1" "*a*b*[bc]*[ef]*g*\0" "abacadaeafag\0"
> -       "0" "*a*b*[ef]*[cd]*g*\0" "abacadaeafag\0"
> -       "1" "*abcd*\0" "abcabcabcabcdefg\0"
> -       "1" "*ab*cd*\0" "abcabcabcabcdefg\0"
> -       "1" "*abcd*abcdef*\0" "abcabcdabcdeabcdefg\0"
> -       "0" "*abcd*\0" "abcabcabcabcefg\0"
> -       "0" "*ab*cd*\0" "abcabcabcabcefg\0";
> -
> -static int __init glob_init(void)
> -{
> -       unsigned successes = 0;
> -       unsigned n = 0;
> -       char const *p = glob_tests;
> -       static char const message[] __initconst =
> -               KERN_INFO "glob: %u self-tests passed, %u failed\n";
> -
> -       /*
> -        * Tests are jammed together in a string.  The first byte is '1'
> -        * or '0' to indicate the expected outcome, or '\0' to indicate the
> -        * end of the tests.  Then come two null-terminated strings: the
> -        * pattern and the string to match it against.
> -        */
> -       while (*p) {
> -               bool expected = *p++ & 1;
> -               char const *pat = p;
> -
> -               p += strlen(p) + 1;
> -               successes += test(pat, p, expected);
> -               p += strlen(p) + 1;
> -               n++;
> -       }
> -
> -       n -= successes;
> -       printk(message, successes, n);
> -
> -       /* What's the errno for "kernel bug detected"?  Guess... */
> -       return n ? -ECANCELED : 0;
> -}
> -
> -/* We need a dummy exit function to allow unload */
> -static void __exit glob_fini(void) { }
> -
> -module_init(glob_init);
> -module_exit(glob_fini);
> -
> -MODULE_DESCRIPTION("glob(7) matching tests");
> -MODULE_LICENSE("Dual MIT/GPL");
> --
> 2.52.0.351.gbe84eed79e-goog
>

--000000000000c056360647c4c883
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
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
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
Dxz3AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHZtY3XkWtC2
e2Idfk+0JyK7BLzzMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBo
hqjbVaHxZoT6HHUuwQcTlbgXpuVi59bQPrSwb/6Pn1t3h3SLeuUCvOYpoQjxlWy/FexsPW+nWS0I
PUmWpt6sxbIRTKPfb7cPk32XezfnA0jexucybiXzkZKTrbI7zoMOzDIWpTKYZAonB9Zzi7Dso4An
ZOtz/E3yhdR/q1MK30d5fiCS0vorEd0Oy8Jzcc7TJ2HGMzEEXiFFvVrJYJHvfYOeXE4ywAG6YWO0
x78+bXeB9vkeWHhOYKyYXuAXrnHASddEICg1QlJCHDAISMC1Wn/tjqTMTt3sDAe+dhi9V1FEGTbG
g9PxPVP4huJEMIBu/MWNMzHfiW4E7eCHVPrmtX7CFDlMik7qsgQBbO5h6EcxBamhIflfMgoISsRJ
Vyll2E5BNVwkNstMgU3WMg5yIaQcuGFgFnMTrQcaLEEFPV3cCP9pgXovYDirnB7FKNdCZNHfeBY1
HEXJ2jIPDP6nWSbYoRry0TvPgxh5ZeM5+sc1L7kY75C8U4FV3t4qdC+p7rgqfAggdvDPa5BJbTRg
KAzwyf3z7XUrYp38pXybmDnsEcRNBIOEqBXoiBxZXaKQqaY921nWAroMM/6I6CVpTnu6JEeQkoi4
IgGIEaTFPcgAjvpDQ8waLJL84EP6rbLW6dop+97BXbeO9L/fFf40kBhve6IggpJSeU9RdCQ5czGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAYQLf/BIzLow9kWqD8My
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgykF1rPSr9Cwi0ycC/Bh84lwSLkH1
BrHZSIYL3FzY6BIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTA3MDQzMjQ3WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAELr4YzOmPBMI/D4Y1gRN1G1xdcRP5qSVu6ReUG2fwldUkoQ2R60zlEi5/R/clPcS
9QeokrVubZP5uO3ob9Ac2WVOmFEZQs/ROsItboUsCPOHUm7bAiFyC1tGuFc/9SyqgqM/z2KTO0zu
zaBSLU1dt034uoFUua9Y6cFv/XYOxpNvVuHLYliZCbkGF3FETDrmoDIRZxiYIVQdd9jHKw6BD5MM
TLlmfy5G6LaJ9ap+qBShVQr3YI/Nl2syihUKGJ220KPm8jO5dQj9H5x2ZfcxzFu2Iyk0ur0YJrt5
INC0mEBSpD8GS0p7j2xadnTNZXvaLXzByJ3Q6ZUpU4hGkrg7Pw==
--000000000000c056360647c4c883--

