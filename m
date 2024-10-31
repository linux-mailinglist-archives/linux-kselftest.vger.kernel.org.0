Return-Path: <linux-kselftest+bounces-21239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C499B818B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 18:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CD01F22143
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D61BE841;
	Thu, 31 Oct 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EELGg3Vv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09A12D1EA
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397021; cv=none; b=ZTJZt45ZuwqjB0ToJx0y/AVFZg9hljIre9u5qcu37LKfv+qTon2Jjd0IZwAjUPX7PkvEQMcaR9Jl/1uWSck24RKA7qhCubPn7BoF4k2yWnwTtVhQ1jQyCHM7mrzuHZ5VW2M5GmbAFVpwzuqWzG3Yp9BlmJXwHpp9fQdPSej/P6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397021; c=relaxed/simple;
	bh=Cid9ROItRKXLZZjdnCAthIFePfZgwypYYIG6++KIyzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+cEAfQ2GHV+VkztBMQZLSpKtBhQzY7AR89/C7/Tzkc9vvmvvugwHfmmMI+tcoed6RVzD7kmBYNIBGSKxibK8LHTJ07I2we5eSqBMRhP/RsdHrqvcp9KV449fvGF7wYC1haq2IhDi6+X70z3tdh6Bqs5hHZNxNisMz/E3oCHQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EELGg3Vv; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a6af694220so1529035ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730397018; x=1731001818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xC4vkldRolMu21cOPAce+B0rfpRA2uz37L8SiUvk1VI=;
        b=EELGg3VvKEiLlKlduAym7DzEQ40iKWqKAAAEv3qGmrm27YYcMaROUWkslV1MNYPs2F
         WDh8t3koFLLFqcs7uWFVe3YG6rk6rwqwc6sFdCLTvG8G1rt7HgWWWYgiwaWkBDLtdQWk
         REyBv4wHSJklNBMvK7MjPDLN/ePEbyB0eUimw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730397018; x=1731001818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xC4vkldRolMu21cOPAce+B0rfpRA2uz37L8SiUvk1VI=;
        b=GIHwMBWfty6Z6dqX8YgHV4J20IBvT6NROPpf4lZdqob4KPfgNRitWubKlYE+tj00up
         MDjxFx/hvIT7r3+NrEP2UzUTlE9rvy/wtDr9HxdrZoOXeNJ+SFB7NnhTJv16rfqYBeMp
         8UrDjtZjLRLtaLXM4eccJXTkIwulMtRNdURXtr6/Xi0dKtLP6XahwOfwK2ZK00w9c09p
         UIi4AKAYdNznDidsBQa6w7eWSJEgQ53ME/fdDWKIu8ot3Mb6opKBXj1M/7Iwu1ZUTJLc
         yU3NDM8E1EfchnupdmjGqFPiHEKsMW2YbNX6530UHRhBUjDD/AOleYoLXJq0EOByvHpH
         UC0A==
X-Gm-Message-State: AOJu0YztCKva+8PFWSwJWj9+/YGwlO3N3xajxyIeCvTbVWMd6FlQNFP8
	a7V7BiHCQLFjXMVGHlUN9zNygcCOho6JJcCMCubI0r7wKJLONsbNKDD1MQefFMQ=
X-Google-Smtp-Source: AGHT+IGCY2u74W6Dg7fUsZXYdVQ9xGrG2GieyrJ3jHn3rX/8ubkMuH/Wz5tbby+Qwl+McvfYYVRvAQ==
X-Received: by 2002:a92:cd86:0:b0:3a3:35f0:4c19 with SMTP id e9e14a558f8ab-3a6b03b0cd2mr7711765ab.21.1730397018007;
        Thu, 31 Oct 2024 10:50:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04aca6d3sm375994173.176.2024.10.31.10.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:50:17 -0700 (PDT)
Message-ID: <c213dbcb-35de-4afd-9d4b-f42f6a9e3de6@linuxfoundation.org>
Date: Thu, 31 Oct 2024 11:50:16 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib/math: Add int_sqrt test suite
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 brendan.higgins@linux.dev, davidgow@google.com,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 ricardo@marliere.net, linux-kernel-mentees@lists.linuxfoundation.org,
 andriy.shevchenko@linux.intel.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20241030134355.14294-1-luis.hernandez093@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241030134355.14294-1-luis.hernandez093@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/24 07:43, Luis Felipe Hernandez wrote:
> Adds test suite for integer based square root function.
> 
> The test suite is designed to verify the correctness of the int_sqrt()
> math library function.
> 
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> ---
> Changes in v2
>    - Add new line at the end of int_sqrt_kunit.c
>    - Add explicit header includes for MODULE_* macros, strscpy, and ULONG_MAX
> 
> Changes in v3
>    - Remove unnecesary new line after Kconfig entry for INT_SQRT_KUNIT_TEST
>    - Correct int_sqrt instances with int_sqrt() in commit message and kconfig
> entry desc
>    - Fix limits.h header include path

Adding Andrew to the thread. I think this depends on the other lib kunit
content that is already in next.

> ---
>   lib/Kconfig.debug               | 15 ++++++++++
>   lib/math/Makefile               |  1 +
>   lib/math/tests/Makefile         |  1 +
>   lib/math/tests/int_sqrt_kunit.c | 51 +++++++++++++++++++++++++++++++++
>   4 files changed, 68 insertions(+)
>   create mode 100644 lib/math/tests/int_sqrt_kunit.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 7312ae7c3cc5..c83f5dc9bb48 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2993,6 +2993,21 @@ config TEST_OBJPOOL
>   
>   	  If unsure, say N.
>   
> +config INT_SQRT_KUNIT_TEST
> +	tristate "Integer square root test test" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This option enables the KUnit test suite for the int_sqrt() function,
> +	  which performs square root calculation. The test suite checks
> +	  various scenarios, including edge cases, to ensure correctness.
> +
> +	  Enabling this option will include tests that check various scenarios
> +	  and edge cases to ensure the accuracy and reliability of the square root
> +	  function.
> +
> +	  If unsure, say N
> +
>   endif # RUNTIME_TESTING_MENU
>   
>   config ARCH_USE_MEMTEST
> diff --git a/lib/math/Makefile b/lib/math/Makefile
> index 3ef11305f8d2..25bcb968b369 100644
> --- a/lib/math/Makefile
> +++ b/lib/math/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
>   obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
>   obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
>   obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
> +obj-y  += tests/
> diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
> index 6a169123320a..e1a79f093b2d 100644
> --- a/lib/math/tests/Makefile
> +++ b/lib/math/tests/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
>   obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
> +obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += int_sqrt_kunit.o
> diff --git a/lib/math/tests/int_sqrt_kunit.c b/lib/math/tests/int_sqrt_kunit.c
> new file mode 100644
> index 000000000000..3590142d2012
> --- /dev/null
> +++ b/lib/math/tests/int_sqrt_kunit.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <kunit/test.h>
> +#include <linux/limits.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +
> +struct test_case_params {
> +	unsigned long x;
> +	unsigned long expected_result;
> +	const char *name;
> +};
> +
> +static const struct test_case_params params[] = {
> +	{ 0, 0, "edge-case: square root of 0" },
> +	{ 4, 2, "perfect square: square root of 4" },
> +	{ 81, 9, "perfect square: square root of 9" },
> +	{ 2, 1, "non-perfect square: square root of 2" },
> +	{ 5, 2, "non-perfect square: square root of 5"},
> +	{ ULONG_MAX, 4294967295, "large input"},
> +};
> +
> +static void get_desc(const struct test_case_params *tc, char *desc)
> +{
> +	strscpy(desc, tc->name, KUNIT_PARAM_DESC_SIZE);
> +}
> +
> +KUNIT_ARRAY_PARAM(int_sqrt, params, get_desc);
> +
> +static void int_sqrt_test(struct kunit *test)
> +{
> +	const struct test_case_params *tc = (const struct test_case_params *)test->param_value;
> +
> +	KUNIT_EXPECT_EQ(test, tc->expected_result, int_sqrt(tc->x));
> +}
> +
> +static struct kunit_case math_int_sqrt_test_cases[] = {
> +	KUNIT_CASE_PARAM(int_sqrt_test, int_sqrt_gen_params),
> +	{}
> +};
> +
> +static struct kunit_suite int_sqrt_test_suite = {
> +	.name = "math-int_sqrt",
> +	.test_cases = math_int_sqrt_test_cases,
> +};
> +
> +kunit_test_suites(&int_sqrt_test_suite);
> +
> +MODULE_DESCRIPTION("math.int_sqrt KUnit test suite");
> +MODULE_LICENSE("GPL");

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

