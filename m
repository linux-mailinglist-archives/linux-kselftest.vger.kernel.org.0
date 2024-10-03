Return-Path: <linux-kselftest+bounces-18950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3864198E9C5
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 08:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26541F24573
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 06:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA0120328;
	Thu,  3 Oct 2024 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3zYgXOo0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F7182BD
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938122; cv=none; b=jHw6mIEX2oicaHpNKNKo6jBGzP94dpCdkzGaToh3ur+LbVDoWJamIn2/lhuiPayo1pnIB3591Gdi1wyrF3Tq2vGawJ53TpqOOpg+ZBzCwwX6XQs/6gMrjw/JFs61dVQLTIznIFkwAoFkpU0vkFAN96qrHMPf8AiOGTa0NpO5Ywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938122; c=relaxed/simple;
	bh=gjApARdj0a8PtTTfQgMcS0LsTXR2Q/pQbIfhDBdrROc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDCVJHAosawpzm1jA079ZS4Vgn5W1zcJDMPaGjrqVKKHt4fZBLZ7b5aaaRgWAc/Hy9xjSh+l7Tu3+h5wjM9WdZphS1Hqo+G1FqYo3kMn0oSv6J88YDN2SJBfTaBBYznqjU21yha+WacvS8Jw12QmaMFSo5JY0nn3cFff/hiJ/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3zYgXOo0; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb37b34a87so4560026d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 23:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727938120; x=1728542920; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+crW1PtuEkoBdQfWB5amn17bFVWM5eGXkJquHcLgjk0=;
        b=3zYgXOo03OzFgBTBa/b6eo56peb0FRUnIplZBXdbG5a3kapD/zl0Xmf3CVgASDjf9r
         BVpyKPjY8t82l9v7jCC0GFPkmewE8d+M0TANV99Zos0pkeJu4uwbscv+NTgfd8r6G/x0
         rUAPMdXBxliTAR5MXyLNRIj4GG/RMb9ojJfMYwORGxJY38N4upSnqTX1n7Tl+aM+Zibn
         pL2pmELg29W9M2e+pIpFj7fyKJdLXJSQ3m+g0+l/EEvYFnEZkjazO2kanFepQuObTSw4
         S0V/Cihbf07DqY/qipyKQ11Nrwpn6G322EaNsR3KudSFAxuy5qKSnhQ1URRr/4IjSNNQ
         L2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938120; x=1728542920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+crW1PtuEkoBdQfWB5amn17bFVWM5eGXkJquHcLgjk0=;
        b=LMGdenTtdm1yyU3b6sz9K+q3XqMaLeVqqvbzgtea0d+6pxGF+eju+bAQVg2moW752a
         pDg9RA/P7ZD/GO4ehwOOCU1ES7N2vBTBOsKfGQuegSfs0GRY1ICHUduVgJ2uf6jnoDU+
         k97lFKk30ha1MeRthDXkHJCbRPOZAkt1ZUN8Drgo/eLmIfEbE55YXxfq20PmREVJtS39
         Fc7WPSRoNLYQKsAIcHjxdxl5mc+E0zkn+9G5TZXBLaHthipxPis6EoRw8T46eMgm9O6B
         kmJD9cyqKMmPjN/LkFmRXBbkPQJ6ATdwbsLESvWhaw/u5oN8Qyh2RjQTMktoRoWpI2rT
         wohA==
X-Forwarded-Encrypted: i=1; AJvYcCXy759Jo1N4Dy4G0e76OTcbaEa0wuIdLnDZFTgbRIgdYq4tJ1n9xHDQSGj2z6kheMB5rdC0cv6VMYZAnGHnkFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZHvNm5M+RBvzstCHtErkWrSK0n5ZwVMeeR4jPoCWD5pW/tj4s
	0jYv2DQUuBSOFzLhQqmEsNI3hbIZWMkRPD7cgvoFiq6383FZgQQpyXU2F7juFChuyfavUhDJhRn
	lWlxGPRdfUAFdnUBn+DdSaYAQZtww1Kz9UAwS
X-Google-Smtp-Source: AGHT+IGSqdXXe75v4+xTGyV/JDSqYD50j3BQC0pmgmr2oNXtlvLuEfIMpcNO6cTxYyKJNBhSnNy+vGlzNwYinGH+3Ys=
X-Received: by 2002:a05:6214:490a:b0:6cb:6187:7c93 with SMTP id
 6a1803df08f44-6cb819af788mr61866566d6.8.1727938119718; Wed, 02 Oct 2024
 23:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924032200.167622-1-luis.hernandez093@gmail.com>
In-Reply-To: <20240924032200.167622-1-luis.hernandez093@gmail.com>
From: David Gow <davidgow@google.com>
Date: Thu, 3 Oct 2024 14:48:26 +0800
Message-ID: <CABVgOS=NPw8GxPRo3vSidm3rrJjEq2jjjFc4SYXknC-dkxoODA@mail.gmail.com>
Subject: Re: [PATCH v2] lib: math: Move kunit tests into tests/ subdir
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, quic_jjohnson@quicinc.com, 
	macro@orcam.me.uk, npitre@baylibre.com, tpiepho@gmail.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	skhan@linuxfoundation.org, ricardo@marliere.net, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000da0acb06238cf142"

--000000000000da0acb06238cf142
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 11:22, Luis Felipe Hernandez
<luis.hernandez093@gmail.com> wrote:
>
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
> ---
> Changes in v2: Fix cc recipient list inclusion in cover letter
> ---

Thanks very much for taking care of this. It looks great to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

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
>  .../mul_u64_u64_div_u64_kunit.c}                            | 0
>  lib/math/{rational-test.c => tests/rational_kunit.c}        | 0
>  19 files changed, 21 insertions(+), 21 deletions(-)
>  rename lib/math/{test_div64.c => tests/div64_kunit.c} (100%)
>  rename lib/math/{test_mul_u64_u64_div_u64.c => tests/mul_u64_u64_div_u64_kunit.c} (100%)
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
> index bc8faa4509e1..49807e18b0fc 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2281,7 +2281,7 @@ config TEST_SORT
>
>           If unsure, say N.
>
> -config TEST_DIV64
> +config DIV64_KUNIT_TEST
>         tristate "64bit/32bit division and modulo test"
>         depends on DEBUG_KERNEL || m
>         help
> @@ -2291,7 +2291,7 @@ config TEST_DIV64
>
>           If unsure, say N.
>
> -config TEST_MULDIV64
> +config MULDIV64_KUNIT_TEST
>         tristate "mul_u64_u64_div_u64() test"
>         depends on DEBUG_KERNEL || m
>         help
> @@ -3074,7 +3074,7 @@ endmenu # "Rust"
>
>  endmenu # Kernel hacking
>
> -config INT_POW_TEST
> +config INT_POW_KUNIT_TEST
>         tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TESTS
>         depends on KUNIT
>         default KUNIT_ALL_TESTS
> diff --git a/lib/math/Makefile b/lib/math/Makefile
> index 3ef11305f8d2..1c489501ff57 100644
> --- a/lib/math/Makefile
> +++ b/lib/math/Makefile
> @@ -5,7 +5,4 @@ obj-$(CONFIG_CORDIC)            += cordic.o
>  obj-$(CONFIG_PRIME_NUMBERS)    += prime_numbers.o
>  obj-$(CONFIG_RATIONAL)         += rational.o
>
> -obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
> -obj-$(CONFIG_TEST_DIV64)       += test_div64.o
> -obj-$(CONFIG_TEST_MULDIV64)    += test_mul_u64_u64_div_u64.o
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
> similarity index 100%
> rename from lib/math/test_mul_u64_u64_div_u64.c
> rename to lib/math/tests/mul_u64_u64_div_u64_kunit.c
> diff --git a/lib/math/rational-test.c b/lib/math/tests/rational_kunit.c
> similarity index 100%
> rename from lib/math/rational-test.c
> rename to lib/math/tests/rational_kunit.c
> --
> 2.46.1
>

--000000000000da0acb06238cf142
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
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgak/A49MJJPWAQfhZ121W9l5Ku0Pq
agn7UGUchWgwULQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDAzMDY0ODQwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAH+BSBedjuaRMgHiqO0YOqVwvJF26NqhMboEIhh8RBZzRiTx
oEaixgqT5U7CciEh2Gr99LUyyr7TwkH5lEjpheE73bh2ILfchh5nP8/1fe3B+4C0hbheimRMO72U
esnKybkHydBhgALuxyA3UxzacIX8KQO4IHPY5D+nQrLUW4NEVrso/fn6GkVFa4zqauKQUVXNa6X1
cScbAF+YNQ/n+ei6Twmzv5b4pFRXdMV250nl2pTDey3BvB1ixShAsCsXlNAzJI+Rfw+cg27WP4pE
z5uSgLOm2pfMwrQAwKLpgkKz7uN5/TB6ZWyNBgtqAsFophongbD9h4VVTHJnS6arkIU=
--000000000000da0acb06238cf142--

