Return-Path: <linux-kselftest+bounces-26121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF7A2D9F9
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 01:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350B016592B
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 00:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B3C1392;
	Sun,  9 Feb 2025 00:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X04DkEVm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC8A47;
	Sun,  9 Feb 2025 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739060745; cv=none; b=Og01HiYEcwPYKYCKX3Qp1KrK0rRLVQFnBQYCePNP0+tGtcwLzgLQWvhh/fWIY9jOO3VCdlWwhBC6X/FIMzxxAUhdk6I60JjmxUNpE4+kqtj65R6nXoTu0NuipUijOtHDtNzQQ+d4NtNJAKtrZMHuy9esd3TF/rvzjsmYoezCkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739060745; c=relaxed/simple;
	bh=oCX6aimqBVaa4AiH8rlobOBOhEQmULUfTIA6sHLtiyM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tuT/tp3Y+xVhR6n3g2L/qxK2gjTD22Wl2mdLxVw3Cic3UkuZ+t5vZByiTl5+BGQByFlWRzwUVW4KgU4SElmIvKXNzKN2x91T3149gghsPA+DUoQHcvfR0kBfXjZQM+5wmd6bHnGD2IjK+SfWNx7OPzAHNIghi0uPC8HoXuhMhgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X04DkEVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D429AC4CED6;
	Sun,  9 Feb 2025 00:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739060743;
	bh=oCX6aimqBVaa4AiH8rlobOBOhEQmULUfTIA6sHLtiyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X04DkEVmZaNF/+hr64F7L/jKlUnynFPn/aVc8Lgf11ZY2ldv1jvsYMQejlebRm0Qn
	 BsenL7hpRfCNjegU4GSGsChn/P8iHb01DbnvSu5+XhFcfoawqM/0156eCWmV6AAVNq
	 331sx/ym4e92SPSYzd5n1k6TPZ2f3aqp+n5iYfdw=
Date: Sat, 8 Feb 2025 16:25:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v3 0/2] lib/prime_numbers: convert self-test to KUnit
Message-Id: <20250208162542.fba2bdb0051eeab5344d3f82@linux-foundation.org>
In-Reply-To: <20250208-prime_numbers-kunit-convert-v3-0-8ffd5816d8dc@gmail.com>
References: <20250208-prime_numbers-kunit-convert-v3-0-8ffd5816d8dc@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 08 Feb 2025 17:52:28 -0500 Tamir Duberstein <tamird@gmail.com> wrote:

> This is a clear example of a unit test.
> 
> I tested this using:
> 
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 math-prime_numbers
> 
> On success:
> ; [08:51:41] ============== math-prime_numbers (1 subtest) ==============
> ; [08:51:41] [PASSED] prime_numbers_test
> ; [08:51:41] =============== [PASSED] math-prime_numbers ================
> ; [08:51:41] ============================================================
> ; [08:51:41] Testing complete. Ran 1 tests: passed: 1
> 
> On failure:
> ; [08:50:19] ============== math-prime_numbers (1 subtest) ==============
> ; [08:50:19]     # prime_numbers_test: ASSERTION FAILED at lib/math/tests/prime_numbers_kunit.c:28
> ; [08:50:19]     Expected slow == fast, but
> ; [08:50:19]         slow == 0 (0x0)
> ; [08:50:19]         fast == 1 (0x1)
> ; [08:50:19] is-prime(2)
> ; [08:50:19] [FAILED] prime_numbers_test
> ; [08:50:19] # module: prime_numbers_kunit
> ; [08:50:19] # math-prime_numbers: primes.{last=61, .sz=64, .primes[]=...x28208a20a08a28ac} = 2-3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61
> ; [08:50:19] =============== [FAILED] math-prime_numbers ================
> ; [08:50:19] ============================================================
> ; [08:50:19] Testing complete. Ran 1 tests: failed: 1
> 

I resolved this against "lib/math: add Kunit test suite for gcd()"
(https://lkml.kernel.org/r/20250203075400.3431330-1-eleanor15x@gmail.com)
in the obvious fashion then added this fixup:

From: Andrew Morton <akpm@linux-foundation.org>
Subject: lib-math-hook-up-tests-makefile-fix
Date: Sat Feb  8 03:33:59 PM PST 2025

don't link gcd_kunit.o twice

Cc: David Gow <davidgow@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/math/Makefile |    1 -
 1 file changed, 1 deletion(-)

--- a/lib/math/Makefile~lib-math-hook-up-tests-makefile-fix
+++ a/lib/math/Makefile
@@ -8,5 +8,4 @@ obj-$(CONFIG_RATIONAL)		+= rational.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
-obj-$(CONFIG_GCD_KUNIT_TEST) += tests/gcd_kunit.o
 obj-y += tests/
_

and the x86_64 allmodconfig build failed thusly:

lib/math/tests/prime_numbers_kunit.c: In function 'prime_numbers_test':
lib/math/tests/prime_numbers_kunit.c:25:35: error: implicit declaration of function 'slow_is_prime_number'; did you mean 'is_prime_number'? [-Werror=implicit-function-declaration]
   25 |                 const bool slow = slow_is_prime_number(x);
      |                                   ^~~~~~~~~~~~~~~~~~~~
      |                                   is_prime_number


So, please redo against mm.git's mm-everything branch or its
mm-nonmm-unstable branch and retest carefully.


