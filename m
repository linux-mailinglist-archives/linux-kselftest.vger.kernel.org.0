Return-Path: <linux-kselftest+bounces-23384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFC39F1E72
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 13:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A2F18887DC
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 12:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D347E18FC72;
	Sat, 14 Dec 2024 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOEF4f06"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3614F155A2F;
	Sat, 14 Dec 2024 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734177930; cv=none; b=DZe+4cnwEv0fgJykE/ruH8MpykC8JnoqUnir/T0Z7WNrGOQujnRWIR2347PZm6pkw0zOIGzVb+rzY/qh82A3g4Q6ZrQuw1V75eOHneLRAEZn5oujaQCmJj5w8wTw4FbzCDAV9Qpnz95DHoB0OZHWB6YgrZ5rRkvJpN37A2+wxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734177930; c=relaxed/simple;
	bh=uX6YhkiCmepIGaM3RedGBgiedu7trgobYfPE4mkRYbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYHP0yqhDeb8ggiDxA7QAVHuHUp3avsXxm/zFJgZRz/rrzm2vOfGUVvTqm/1f0MRffhcoez7tXtEKvltMl4bdIUPCtkGbH+4j2S8WIVGw4bIIcCxKI66Nua7Vg1LnnBrDyOQWHMSy19deqJaClCwy5MOlrgn9HIxXvB8lq5+7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOEF4f06; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72764c995e5so1605904b3a.2;
        Sat, 14 Dec 2024 04:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734177928; x=1734782728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ef+KnOlI3Lc8v/jEZGInz0a4NzqY0JpgG6ovL4bxVRk=;
        b=JOEF4f06ga//D4V19UCH3dPTZCM70lb2EVdrD/ND0HRwo/U65dNvXa1ufgIrzLZqUz
         34HKDqOWeg2H1P8nmrjbvk/OkiWjlBsAsH6B2y23YVY6CZZrOJJCNQCW8uaAWBxD3c0/
         fkv1pQbA+yOCK2f1GwPTqswUiYCMwuz3F4sEl3ojDhQWKtPPvFR7wb7OUQWzpuaUmok0
         66pv8wHgeVPC+gpSBzrF7+xVQS4CcDQ9RvvTnFjFKiX2uAlRqbUHhEETx8QuPnuDAB/b
         jCMsQMAejUwH/10tZnTbd0/MVHUIaDKiVZO44j28FBh1bN9pe7+G33E9WgkTlQqdeLCU
         W4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734177928; x=1734782728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef+KnOlI3Lc8v/jEZGInz0a4NzqY0JpgG6ovL4bxVRk=;
        b=vdP+jt1GLzUk0AuPhofPPiaSaONUMizZZ3Nnmnj8NtBFheFHQ/qrrwv1/RF2Du8hl1
         4q8/rkKuqukwOPcf7TSWz+8SDcYpS8HLflni191SKVYo7YtlgSQ+vsiR0cmXivu1if87
         Ik5zIZQ3pszhsj9/3VOgXlZhh/teJuYRY9CDe1/uFmuZxk1eg9vMbn3S05Tdq5sBL26N
         8rhNId+I9UjTMZAiW36oQvGLweClhZql31q8Z2RDcWk2Yhvt2jBFj+0n4QAcp0tkAUpD
         C1jzQUnBPFiEEkEtCn+Va/gK/2xVqO5LlNfgcBL4HdwbXy/rSi4u+HzXrpqE18gNqAGB
         E7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUNmgKH3pgoq+4qMYi3Z98QAPIhGPrgehd4klfWzMke6ogzZrO248eLfmIEMr6mVNWHsoKlqg8Ht/KE5ZU=@vger.kernel.org, AJvYcCVm6yx/qqpbaaVygnFxod+sHui08LMtZnfAd+Jcy5MngcN5sS8EYmzFJt5WB10ZVIiO/6hF7BRqHmIQ1/d+HfIe@vger.kernel.org
X-Gm-Message-State: AOJu0YwTt6kFbqGWzSRhKn8dq2swEDOKm99bGEPjkKrgzWlrgMUsLjlC
	J/hvDVdCSIR0gDTh2rSeo1h9+zA4Cm0NmVtgv8wMEbXNtNf5MsH/
X-Gm-Gg: ASbGncsR8RvcDBLNrb+3khaJR+Os9r7U6rzhEj3TYWnzXuokaJTrAgLH0m52qUZncA5
	GNIFDJ27oD0/lVcLxUbw7F0nsVcSmWJ2/7HMh0Y1mZ9QBMxIo+ja6iy6Hx627Nibh4R0taMKcJh
	AKOBWia9N1OpDk8SQPaAyRZo3f0Be+wC5D8iQpnX21mFM1SHx25eNFEBJAz5qJTnf+gbgwg1PKo
	BqsrZIsXV31Qonbxpgo3oAthUlNebYSblN6BYe0xieVMhO3bpD1yphLrc7t8C4Qr/uIqeF5f/J0
	/By/6TfE
X-Google-Smtp-Source: AGHT+IHvzcNTUqoyCtnbQdcp35YCsUI0XyNH3LwqNAe54gEFhN/bp6EYFbVghSaJbTr8Z08v7Yy6BQ==
X-Received: by 2002:a05:6a00:4645:b0:725:f4c6:6b72 with SMTP id d2e1a72fcca58-7290c264663mr8773714b3a.25.1734177928187;
        Sat, 14 Dec 2024 04:05:28 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bad6a8sm1282944b3a.159.2024.12.14.04.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 04:05:27 -0800 (PST)
Date: Sat, 14 Dec 2024 20:05:23 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: davidgow@google.com, akpm@linux-foundation.org,
	skhan@linuxfoundation.org, rbm@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] lib/math: Add int_sqrt test suite
Message-ID: <Z110g9txzLJvZ7EM@visitorckw-System-Product-Name>
References: <20241213042701.1037467-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213042701.1037467-1-luis.hernandez093@gmail.com>

On Thu, Dec 12, 2024 at 11:26:50PM -0500, Luis Felipe Hernandez wrote:
> Adds test suite for integer based square root function.
> 
> The test suite is designed to verify the correctness of the int_sqrt()
> math library function.
> 
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>

LGTM. Feel free to add:

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
>  lib/Kconfig.debug               | 15 ++++++++
>  lib/math/Makefile               |  1 +
>  lib/math/tests/Makefile         |  1 +
>  lib/math/tests/int_sqrt_kunit.c | 66 +++++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+)
>  create mode 100644 lib/math/tests/int_sqrt_kunit.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f3d723705879..147d9fef42e7 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -3161,6 +3161,21 @@ config INT_POW_TEST
>  
>  	  If unsure, say N
>  
> +config INT_SQRT_KUNIT_TEST
> +	tristate "Integer square root test" if !KUNIT_ALL_TESTS
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
>  endif # RUNTIME_TESTING_MENU
>  
>  config ARCH_USE_MEMTEST
> diff --git a/lib/math/Makefile b/lib/math/Makefile
> index 3ef11305f8d2..853f023ae537 100644
> --- a/lib/math/Makefile
> +++ b/lib/math/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
>  obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
>  obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
>  obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
> +obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += tests/int_sqrt_kunit.o
> \ No newline at end of file
> diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
> index 6a169123320a..e1a79f093b2d 100644
> --- a/lib/math/tests/Makefile
> +++ b/lib/math/tests/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
>  obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
> +obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += int_sqrt_kunit.o
> diff --git a/lib/math/tests/int_sqrt_kunit.c b/lib/math/tests/int_sqrt_kunit.c
> new file mode 100644
> index 000000000000..1798e1312eb7
> --- /dev/null
> +++ b/lib/math/tests/int_sqrt_kunit.c
> @@ -0,0 +1,66 @@
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
> +	{ 0, 0, "edge case: square root of 0" },
> +	{ 1, 1, "perfect square: square root of 1" },
> +	{ 2, 1, "non-perfect square: square root of 2" },
> +	{ 3, 1, "non-perfect square: square root of 3" },
> +	{ 4, 2, "perfect square: square root of 4" },
> +	{ 5, 2, "non-perfect square: square root of 5" },
> +	{ 6, 2, "non-perfect square: square root of 6" },
> +	{ 7, 2, "non-perfect square: square root of 7" },
> +	{ 8, 2, "non-perfect square: square root of 8" },
> +	{ 9, 3, "perfect square: square root of 9" },
> +	{ 15, 3, "non-perfect square: square root of 15 (N-1 from 16)" },
> +	{ 16, 4, "perfect square: square root of 16" },
> +	{ 17, 4, "non-perfect square: square root of 17 (N+1 from 16)" },
> +	{ 80, 8, "non-perfect square: square root of 80 (N-1 from 81)" },
> +	{ 81, 9, "perfect square: square root of 81" },
> +	{ 82, 9, "non-perfect square: square root of 82 (N+1 from 81)" },
> +	{ 255, 15, "non-perfect square: square root of 255 (N-1 from 256)" },
> +	{ 256, 16, "perfect square: square root of 256" },
> +	{ 257, 16, "non-perfect square: square root of 257 (N+1 from 256)" },
> +	{ 2147483648, 46340, "large input: square root of 2147483648" },
> +	{ 4294967295, 65535, "edge case: ULONG_MAX for 32-bit" },
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
> -- 
> 2.47.1
> 
> 

