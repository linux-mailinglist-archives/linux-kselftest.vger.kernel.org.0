Return-Path: <linux-kselftest+bounces-17345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BFC96E7AF
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 04:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCE328689A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 02:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F871E49E;
	Fri,  6 Sep 2024 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQX/zHkB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C71CA94
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725589553; cv=none; b=thDuwJ4t7jvnTUE85K2HrbiGq87lCrFWTQq/vlltG9bPZyquOG7VJj7ibi+d82fnOM0jRvTLrx3PmiAdxAmljglC2fx9mTh4gm84y5Z4cjj9Gak1qiE1r5dvAYgda8z6NqyXe/VY6jigDytuhGsPO/Cvh8dVGyUOM1Jwz56hfRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725589553; c=relaxed/simple;
	bh=bYqsyNImX0kS0x0V4a+sK9wyAsIIJTEFlHvuPswADq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+XFF8MEJIq0fns90CxNjbLVraKAzPaMBZW06P5cL32EdNQCqH45tmvG/Ff7kQTNc5lsGjb/Cs9fV6+MbVtpsPBH1IJE9ya+ng/l1y6sikUz7hYuhPyKswUmx6HzzpfDDjXTPjr+LFZLbKx3oTWFZVhzoJ9QvNPbwyrUvCOLN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQX/zHkB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7143165f23fso1236044b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Sep 2024 19:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725589551; x=1726194351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B+HxUQPAa/P5HF11Doufo57xzvVyp0BQJrhqhyT7Zco=;
        b=kQX/zHkByQGmCWHbY5Bc7XaxZNL/tAA7E7sD/3Ou5GdFbENYuSMZ+b99S9W4Kch0Cj
         bR78WeO3ZxWMGMLjiLVLpwCodXEzB+fNPuzedCp3FpHq77GAePlA+h9HewyoU+/9OeXD
         T1uRdebF+v1Mt6sGglGP3tx4PRJNd0PD43yaWMmO8m0utUz7a480wmntO3c0y+hyZ3Hb
         PFiBE+TuFfAWGF5KmLxkn4IuKswl/+nhjRAWOL2SR7TQ0JlGMCNld7P4voo1B9GPTM5W
         7cICZfZPAO+U+6YBbp3e+ePiQ7DRO1yfbT1a6Mrc5VL4T5cz/xX0D140t2qNK+YeHiZY
         hcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725589551; x=1726194351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+HxUQPAa/P5HF11Doufo57xzvVyp0BQJrhqhyT7Zco=;
        b=EoSrLqQn8YuH/yC1ANwWAB79EVfLWaM09d1f0NcXr9nioF7ijm49n52zqn5FSefjh4
         J6HL6YKJlLW4a3JBohDiK7xl/942EhVhENDzhjWbLtyAu3XAFeTm1RXp7F7S2Gj/SWWC
         ZIU992uBgIkV6EA8bGPQu5YH0O/fFzywY5OrrvE+ZMyxXcSSLrQfl1c6PMquU3God5eF
         UMJF6FOBrkf3yVcerSzwaJLvm8EZOJVzEjxyXcBWBggftxHH5Oy4/Scut7GjQ4/0xyww
         xZ3N5RpQhe8kcHQg2NuBnqJDe6HdA06ozrSUGnDDr3APelEsbz1suF4seOlNR07Zh8Qy
         aKBA==
X-Gm-Message-State: AOJu0Ywu9HRUs4hRyAo3j5/N7jhR+pbbzXboreBjG+C3jU6+kowARxWe
	KMzQKxxVCshrSXKXv5rYtXSmi3JFNRrulcwsAOEdNRb/W86/g5U/neSgvjPw10vjkpcm0vRbB5L
	0q/jffWwfIS0rhSYlJ92ovFsX08o=
X-Google-Smtp-Source: AGHT+IHutXntPLuAG6CbX6MNPC5vSB4gy81LLShP5F3TNraZc6eOc+l/rSF0XlnWCMQnBJWCD1BmSOfI2ifu64Mrkng=
X-Received: by 2002:a05:6a20:ac44:b0:1ca:ccd1:281e with SMTP id
 adf61e73a8af0-1cf1d05a9demr1052853637.7.1725589550733; Thu, 05 Sep 2024
 19:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820010353.7533-1-luis.hernandez093@gmail.com>
In-Reply-To: <20240820010353.7533-1-luis.hernandez093@gmail.com>
From: Felipe Hernandez <luis.hernandez093@gmail.com>
Date: Thu, 5 Sep 2024 22:25:14 -0400
Message-ID: <CAGRSKZiRP91TSAL1Tdkh91YcG-_ncNdoOySBx4weqZ6e1aVSLg@mail.gmail.com>
Subject: Re: [PATCH v3] lib/math: Add int_pow test suite
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 19, 2024 at 09:03:52PM -0400, Luis Felipe Hernandez wrote:
> Adds test suite for integer based power function.
>
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> ---
> Changes in v3:
> - Fix compiler warning: explicitly define constant as unsigned int
> - Add changes in patch revisions
> Changes in v2:
> - Address review feedback
>   - Add kconfig entry
>   - Use correct dir and file convention for KUnit
>   - Fix typo
>   - Remove unused static_stub header
>   - Refactor test suite to use paramerterized test cases
>   - Add close to max allowable value to in large_result test case
>   - Add test case with non-power of two exponent
>   - Fix module license
> ---
>  lib/Kconfig.debug              |  9 ++++++
>  lib/math/Makefile              |  1 +
>  lib/math/tests/Makefile        |  3 ++
>  lib/math/tests/int_pow_kunit.c | 52 ++++++++++++++++++++++++++++++++++
>  4 files changed, 65 insertions(+)
>  create mode 100644 lib/math/tests/Makefile
>  create mode 100644 lib/math/tests/int_pow_kunit.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a30c03a66172..b0bbd30d4cba 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -3051,3 +3051,12 @@ config RUST_KERNEL_DOCTESTS
>  endmenu # "Rust"
>
>  endmenu # Kernel hacking
> +
> +config INT_POW_TEST
> +       tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         Enable this to test the int_pow maths function KUnit test.
> +
> +         If unsure, say N
> diff --git a/lib/math/Makefile b/lib/math/Makefile
> index 91fcdb0c9efe..3c1f92a7459d 100644
> --- a/lib/math/Makefile
> +++ b/lib/math/Makefile
> @@ -5,5 +5,6 @@ obj-$(CONFIG_CORDIC)          += cordic.o
>  obj-$(CONFIG_PRIME_NUMBERS)  += prime_numbers.o
>  obj-$(CONFIG_RATIONAL)               += rational.o
>
> +obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
>  obj-$(CONFIG_TEST_DIV64)     += test_div64.o
>  obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
> diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
> new file mode 100644
> index 000000000000..6a169123320a
> --- /dev/null
> +++ b/lib/math/tests/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
> diff --git a/lib/math/tests/int_pow_kunit.c b/lib/math/tests/int_pow_kunit.c
> new file mode 100644
> index 000000000000..e04dd73dabd1
> --- /dev/null
> +++ b/lib/math/tests/int_pow_kunit.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <kunit/test.h>
> +#include <linux/math.h>
> +
> +struct test_case_params {
> +     u64 base;
> +     unsigned int exponent;
> +     u64 expected_result;
> +     const char *name;
> +};
> +
> +static const struct test_case_params params[] = {
> +     { 64, 0, 1, "Power of zero" },
> +     { 64, 1, 64, "Power of one"},
> +     { 0, 5, 0, "Base zero" },
> +     { 1, 64, 1, "Base one" },
> +     { 2, 2, 4, "Two squared"},
> +     { 2, 3, 8, "Two cubed"},
> +     { 5, 5, 3125, "Five raised to the fith power" },
> +     { U64_MAX, 1, U64_MAX, "Max base" },
> +     { 2, 63, 9223372036854775808ULL, "Large result"},
> +};
> +
> +static void get_desc(const struct test_case_params *tc, char *desc)
> +{
> +     strscpy(desc, tc->name, KUNIT_PARAM_DESC_SIZE);
> +}
> +
> +KUNIT_ARRAY_PARAM(int_pow, params, get_desc);
> +
> +static void int_pow_test(struct kunit *test)
> +{
> +     const struct test_case_params *tc = (const struct test_case_params *)test->param_value;
> +
> +     KUNIT_EXPECT_EQ(test, tc->expected_result, int_pow(tc->base, tc->exponent));
> +}
> +
> +static struct kunit_case math_int_pow_test_cases[] = {
> +     KUNIT_CASE_PARAM(int_pow_test, int_pow_gen_params),
> +     {}
> +};
> +
> +static struct kunit_suite int_pow_test_suite = {
> +     .name = "math-int_pow",
> +     .test_cases = math_int_pow_test_cases,
> +};
> +
> +kunit_test_suites(&int_pow_test_suite);
> +
> +MODULE_DESCRIPTION("math.int_pow KUnit test suite");
> +MODULE_LICENSE("GPL");
> --
> 2.46.0
>
Hello,

I wanted to follow up on the last patch version (v3) and see if
there is feedback on any areas I can further improve in the test suite
and/or commit message as
well as if there was any further work I could help with regarding the
organization of the other tests located in /lib/math such that they
also live in /lib/math/tests in order to keep consistent.

Thank you,

Felipe

