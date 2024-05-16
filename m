Return-Path: <linux-kselftest+bounces-10287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7863F8C7488
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 12:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AE91F247D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A96143894;
	Thu, 16 May 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DBpCHYFY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A2143882;
	Thu, 16 May 2024 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854799; cv=none; b=Gty0EZg1c5dWMtFYUQDQXUhWM4tc3jOXC4OYzcHFxAqLk24mW+l9GqUWz036+ZdQiW2GzQiCobLXeutG79oGhtAhSvmgygkHsc5RKaMA3ynHE9XFHpmfPMHgr0s7utMthkDPpBN/DNlVioKPLv3RHcyPQsKzyyWNznJS1ahB4pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854799; c=relaxed/simple;
	bh=Fw7IjFe4M6KrJDw62K6ANnETEPQsg7M8pG6Bolv6SLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dte/bvAQjPUr5a90hOyfzepGXSnWdVdHCCySEtA4L0bAy/6PdmmetCCawlnj/9ocYzq341E+uFFdSRpRbBTsXwws4lPejCWDVvinfADUma5HgCs5BrfwmFkBshPFhU7eCi86cQ/WlbtfGTscB7QqMO8OmbODJfLf2V9lLW8cv+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DBpCHYFY; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44GAJmfj076754;
	Thu, 16 May 2024 05:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715854788;
	bh=TL8ALtHjiWPiEXzAwdW5HYYCfVeWNtircvbwti0fXt8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=DBpCHYFYwv9XZeERhUtQD7YylNIua2pgCd3KYP5R6SwH42L/l8ctoZ1jDuCAWMq1x
	 VAsa6kXnyZ8Jq9WA3GeWzM+gkWVIxijCnWw/aViR4jESwjGsRhCno0Xohz4eeCGQTV
	 mU9QpC0ur2Ymwg2zV066Tic/dVa9lCJIGFo1snSw=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44GAJmYp008879
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 May 2024 05:19:48 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 May 2024 05:19:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 May 2024 05:19:48 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44GAJifm124010;
	Thu, 16 May 2024 05:19:45 -0500
Message-ID: <b7155efb-e99c-f385-3bf3-3ffcdefd1260@ti.com>
Date: Thu, 16 May 2024 15:49:44 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6] lib: add basic KUnit test for lib/math
To: Daniel Latypov <dlatypov@google.com>, <andriy.shevchenko@linux.intel.com>
CC: <brendanhiggins@google.com>, <davidgow@google.com>,
        <linux-kernel@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kselftest@vger.kernel.org>, <skhan@linuxfoundation.org>,
        Linux Media
 Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>
References: <20210416180427.1545645-1-dlatypov@google.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20210416180427.1545645-1-dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Daniel, Andy,

On 16/04/21 23:34, Daniel Latypov wrote:
> Add basic test coverage for files that don't require any config options:
> * part of math.h (what seem to be the most commonly used macros)
> * gcd.c
> * lcm.c
> * int_sqrt.c
> * reciprocal_div.c
> (Ignored int_pow.c since it's a simple textbook algorithm.)
> 
> These tests aren't particularly interesting, but they
> * provide short and simple examples of parameterized tests
> * provide a place to add tests for any new files in this dir
> * are written so adding new test cases to cover edge cases should be easy
>   * looking at code coverage, we hit all the branches in the .c files
> 
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Just checking if something else was pending on this patch-set for this not
getting merged?

I needed this patch-set for adding tests for new macros I am adding in math.h
as suggested in this thread [1], so wanted to pull this in my series and add
changes on top of that for new macros.

Kindly let me know your thoughts on this.

[1]: https://lore.kernel.org/all/ZkIG0-01pz632l4R@smile.fi.intel.com/#t

Regards
Devarsh
> ---
> Changes since v5:
> * add in test cases for roundup/rounddown
> * address misc comments from David
> 
> Changes since v4:
> * add in test cases for some math.h macros (abs, round_up/round_down,
>   div_round_down/closest)
> * use parameterized testing less to keep things terser
> 
> Changes since v3:
> * fix `checkpatch.pl --strict` warnings
> * add test cases for gcd(0,0) and lcm(0,0)
> * minor: don't test both gcd(a,b) and gcd(b,a) when a == b
> 
> Changes since v2: mv math_test.c => math_kunit.c
> 
> Changes since v1:
> * Rebase and rewrite to use the new parameterized testing support.
> * misc: fix overflow in literal and inline int_sqrt format string.
> * related: commit 1f0e943df68a ("Documentation: kunit: provide guidance
> for testing many inputs") was merged explaining the patterns shown here.
>   * there's an in-flight patch to update it for parameterized testing.
> ---
>  lib/math/Kconfig      |  12 ++
>  lib/math/Makefile     |   2 +
>  lib/math/math_kunit.c | 291 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 305 insertions(+)
>  create mode 100644 lib/math/math_kunit.c
> 
> diff --git a/lib/math/Kconfig b/lib/math/Kconfig
> index f19bc9734fa7..a974d4db0f9c 100644
> --- a/lib/math/Kconfig
> +++ b/lib/math/Kconfig
> @@ -15,3 +15,15 @@ config PRIME_NUMBERS
>  
>  config RATIONAL
>  	bool
> +
> +config MATH_KUNIT_TEST
> +	tristate "KUnit test for lib/math and math.h" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +		This builds unit tests for lib/math and math.h.
> +
> +		For more information on KUnit and unit tests in general, please refer
> +		to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +		If unsure, say N.
> diff --git a/lib/math/Makefile b/lib/math/Makefile
> index be6909e943bd..30abb7a8d564 100644
> --- a/lib/math/Makefile
> +++ b/lib/math/Makefile
> @@ -4,3 +4,5 @@ obj-y += div64.o gcd.o lcm.o int_pow.o int_sqrt.o reciprocal_div.o
>  obj-$(CONFIG_CORDIC)		+= cordic.o
>  obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
>  obj-$(CONFIG_RATIONAL)		+= rational.o
> +
> +obj-$(CONFIG_MATH_KUNIT_TEST)	+= math_kunit.o
> diff --git a/lib/math/math_kunit.c b/lib/math/math_kunit.c
> new file mode 100644
> index 000000000000..556c23b17c3c
> --- /dev/null
> +++ b/lib/math/math_kunit.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Simple KUnit suite for math helper funcs that are always enabled.
> + *
> + * Copyright (C) 2020, Google LLC.
> + * Author: Daniel Latypov <dlatypov@google.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/gcd.h>
> +#include <linux/kernel.h>
> +#include <linux/lcm.h>
> +#include <linux/reciprocal_div.h>
> +
> +static void abs_test(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, abs((char)0), (char)0);
> +	KUNIT_EXPECT_EQ(test, abs((char)42), (char)42);
> +	KUNIT_EXPECT_EQ(test, abs((char)-42), (char)42);
> +
> +	/* The expression in the macro is actually promoted to an int. */
> +	KUNIT_EXPECT_EQ(test, abs((short)0),  0);
> +	KUNIT_EXPECT_EQ(test, abs((short)42),  42);
> +	KUNIT_EXPECT_EQ(test, abs((short)-42),  42);
> +
> +	KUNIT_EXPECT_EQ(test, abs(0),  0);
> +	KUNIT_EXPECT_EQ(test, abs(42),  42);
> +	KUNIT_EXPECT_EQ(test, abs(-42),  42);
> +
> +	KUNIT_EXPECT_EQ(test, abs(0L), 0L);
> +	KUNIT_EXPECT_EQ(test, abs(42L), 42L);
> +	KUNIT_EXPECT_EQ(test, abs(-42L), 42L);
> +
> +	KUNIT_EXPECT_EQ(test, abs(0LL), 0LL);
> +	KUNIT_EXPECT_EQ(test, abs(42LL), 42LL);
> +	KUNIT_EXPECT_EQ(test, abs(-42LL), 42LL);
> +
> +	/* Unsigned types get casted to signed. */
> +	KUNIT_EXPECT_EQ(test, abs(0ULL), 0LL);
> +	KUNIT_EXPECT_EQ(test, abs(42ULL), 42LL);
> +}
> +
> +static void int_sqrt_test(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, int_sqrt(0UL), 0UL);
> +	KUNIT_EXPECT_EQ(test, int_sqrt(1UL), 1UL);
> +	KUNIT_EXPECT_EQ(test, int_sqrt(4UL), 2UL);
> +	KUNIT_EXPECT_EQ(test, int_sqrt(5UL), 2UL);
> +	KUNIT_EXPECT_EQ(test, int_sqrt(8UL), 2UL);
> +	KUNIT_EXPECT_EQ(test, int_sqrt(1UL << 30), 1UL << 15);
> +}
> +
> +static void round_up_test(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, round_up(0, 1), 0);
> +	KUNIT_EXPECT_EQ(test, round_up(1, 2), 2);
> +	KUNIT_EXPECT_EQ(test, round_up(3, 2), 4);
> +	KUNIT_EXPECT_EQ(test, round_up((1 << 30) - 1, 2), 1 << 30);
> +	KUNIT_EXPECT_EQ(test, round_up((1 << 30) - 1, 1 << 29), 1 << 30);
> +}
> +
> +static void round_down_test(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, round_down(0, 1), 0);
> +	KUNIT_EXPECT_EQ(test, round_down(1, 2), 0);
> +	KUNIT_EXPECT_EQ(test, round_down(3, 2), 2);
> +	KUNIT_EXPECT_EQ(test, round_down((1 << 30) - 1, 2), (1 << 30) - 2);
> +	KUNIT_EXPECT_EQ(test, round_down((1 << 30) - 1, 1 << 29), 1 << 29);
> +}
> +
> +/* These versions can round to numbers that aren't a power of two */
> +static void roundup_test(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, roundup(0, 1), 0);
> +	KUNIT_EXPECT_EQ(test, roundup(1, 2), 2);
> +	KUNIT_EXPECT_EQ(test, roundup(3, 2), 4);
> +	KUNIT_EXPECT_EQ(test, roundup((1 << 30) - 1, 2), 1 << 30);
> +	KUNIT_EXPECT_EQ(test, roundup((1 << 30) - 1, 1 << 29), 1 << 30);
> +
> +	KUNIT_EXPECT_EQ(test, roundup(3, 2), 4);
> +	KUNIT_EXPECT_EQ(test, roundup(4, 3), 6);
> +}
> +
> +static void rounddown_test(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, rounddown(0, 1), 0);
> +	KUNIT_EXPECT_EQ(test, rounddown(1, 2), 0);
> +	KUNIT_EXPECT_EQ(test, rounddown(3, 2), 2);
> +	KUNIT_EXPECT_EQ(test, rounddown((1 << 30) - 1, 2), (1 << 30) - 2);
> +	KUNIT_EXPECT_EQ(test, rounddown((1 << 30) - 1, 1 << 29), 1 << 29);
> +
> +	KUNIT_EXPECT_EQ(test, rounddown(3, 2), 2);
> +	KUNIT_EXPECT_EQ(test, rounddown(4, 3), 3);
> +}
> +
> +static void div_round_up_test(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(0, 1), 0);
> +	KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(20, 10), 2);
> +	KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(21, 10), 3);
> +	KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(21, 20), 2);
> +	KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(21, 99), 1);
> +}
> +
> +static void div_round_closest_test(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(0, 1), 0);
> +	KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(20, 10), 2);
> +	KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(21, 10), 2);
> +	KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(25, 10), 3);
> +}
> +
> +/* Generic test case for unsigned long inputs. */
> +struct test_case {
> +	unsigned long a, b;
> +	unsigned long result;
> +};
> +
> +static struct test_case gcd_cases[] = {
> +	{
> +		.a = 0, .b = 0,
> +		.result = 0,
> +	},
> +	{
> +		.a = 0, .b = 1,
> +		.result = 1,
> +	},
> +	{
> +		.a = 2, .b = 2,
> +		.result = 2,
> +	},
> +	{
> +		.a = 2, .b = 4,
> +		.result = 2,
> +	},
> +	{
> +		.a = 3, .b = 5,
> +		.result = 1,
> +	},
> +	{
> +		.a = 3 * 9, .b = 3 * 5,
> +		.result = 3,
> +	},
> +	{
> +		.a = 3 * 5 * 7, .b = 3 * 5 * 11,
> +		.result = 15,
> +	},
> +	{
> +		.a = 1 << 21,
> +		.b = (1 << 21) - 1,
> +		.result = 1,
> +	},
> +};
> +
> +KUNIT_ARRAY_PARAM(gcd, gcd_cases, NULL);
> +
> +static void gcd_test(struct kunit *test)
> +{
> +	const char *message_fmt = "gcd(%lu, %lu)";
> +	const struct test_case *test_param = test->param_value;
> +
> +	KUNIT_EXPECT_EQ_MSG(test, test_param->result,
> +			    gcd(test_param->a, test_param->b),
> +			    message_fmt, test_param->a,
> +			    test_param->b);
> +
> +	if (test_param->a == test_param->b)
> +		return;
> +
> +	/* gcd(a,b) == gcd(b,a) */
> +	KUNIT_EXPECT_EQ_MSG(test, test_param->result,
> +			    gcd(test_param->b, test_param->a),
> +			    message_fmt, test_param->b,
> +			    test_param->a);
> +}
> +
> +static struct test_case lcm_cases[] = {
> +	{
> +		.a = 0, .b = 0,
> +		.result = 0,
> +	},
> +	{
> +		.a = 0, .b = 1,
> +		.result = 0,
> +	},
> +	{
> +		.a = 1, .b = 2,
> +		.result = 2,
> +	},
> +	{
> +		.a = 2, .b = 2,
> +		.result = 2,
> +	},
> +	{
> +		.a = 3 * 5, .b = 3 * 7,
> +		.result = 3 * 5 * 7,
> +	},
> +};
> +
> +KUNIT_ARRAY_PARAM(lcm, lcm_cases, NULL);
> +
> +static void lcm_test(struct kunit *test)
> +{
> +	const char *message_fmt = "lcm(%lu, %lu)";
> +	const struct test_case *test_param = test->param_value;
> +
> +	KUNIT_EXPECT_EQ_MSG(test, test_param->result,
> +			    lcm(test_param->a, test_param->b),
> +			    message_fmt, test_param->a,
> +			    test_param->b);
> +
> +	if (test_param->a == test_param->b)
> +		return;
> +
> +	/* lcm(a,b) == lcm(b,a) */
> +	KUNIT_EXPECT_EQ_MSG(test, test_param->result,
> +			    lcm(test_param->b, test_param->a),
> +			    message_fmt, test_param->b,
> +			    test_param->a);
> +}
> +
> +struct u32_test_case {
> +	u32 a, b;
> +	u32 result;
> +};
> +
> +static struct u32_test_case reciprocal_div_cases[] = {
> +	{
> +		.a = 0, .b = 1,
> +		.result = 0,
> +	},
> +	{
> +		.a = 42, .b = 20,
> +		.result = 2,
> +	},
> +	{
> +		.a = 42, .b = 9999,
> +		.result = 0,
> +	},
> +	{
> +		.a = (1 << 16), .b = (1 << 14),
> +		.result = 1 << 2,
> +	},
> +};
> +
> +KUNIT_ARRAY_PARAM(reciprocal_div, reciprocal_div_cases, NULL);
> +
> +static void reciprocal_div_test(struct kunit *test)
> +{
> +	const struct u32_test_case *test_param = test->param_value;
> +	struct reciprocal_value rv = reciprocal_value(test_param->b);
> +
> +	KUNIT_EXPECT_EQ_MSG(test, test_param->result,
> +			    reciprocal_divide(test_param->a, rv),
> +			    "reciprocal_divide(%u, %u)",
> +			    test_param->a, test_param->b);
> +}
> +
> +static void reciprocal_scale_test(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, reciprocal_scale(0u, 100), 0u);
> +	KUNIT_EXPECT_EQ(test, reciprocal_scale(1u, 100), 0u);
> +	KUNIT_EXPECT_EQ(test, reciprocal_scale(1u << 4, 1 << 28), 1u);
> +	KUNIT_EXPECT_EQ(test, reciprocal_scale(1u << 16, 1 << 28), 1u << 12);
> +	KUNIT_EXPECT_EQ(test, reciprocal_scale(~0u, 1 << 28), (1u << 28) - 1);
> +}
> +
> +static struct kunit_case math_test_cases[] = {
> +	KUNIT_CASE(abs_test),
> +	KUNIT_CASE(int_sqrt_test),
> +	KUNIT_CASE(round_up_test),
> +	KUNIT_CASE(round_down_test),
> +	KUNIT_CASE(roundup_test),
> +	KUNIT_CASE(rounddown_test),
> +	KUNIT_CASE(div_round_up_test),
> +	KUNIT_CASE(div_round_closest_test),
> +	KUNIT_CASE_PARAM(gcd_test, gcd_gen_params),
> +	KUNIT_CASE_PARAM(lcm_test, lcm_gen_params),
> +	KUNIT_CASE_PARAM(reciprocal_div_test, reciprocal_div_gen_params),
> +	KUNIT_CASE(reciprocal_scale_test),
> +	{}
> +};
> +
> +static struct kunit_suite math_test_suite = {
> +	.name = "lib-math",
> +	.test_cases = math_test_cases,
> +};
> +
> +kunit_test_suites(&math_test_suite);
> +
> +MODULE_LICENSE("GPL v2");
> 
> base-commit: 7e25f40eab52c57ff6772d27d2aef3640a3237d7

