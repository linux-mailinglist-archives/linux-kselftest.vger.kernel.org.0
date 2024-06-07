Return-Path: <linux-kselftest+bounces-11377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBAD9004B0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CBC28ECCB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BCE194129;
	Fri,  7 Jun 2024 13:23:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4F0194089;
	Fri,  7 Jun 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766619; cv=none; b=BNN9blhdBH4/irFiw9sgHkHJHH6vg22R2fXWjVaqnZjBuxdU/SmmmJ/Cmcl+Bc+kJHrKQkAwBP4nnSKyVJIuUBFnjGq9isywv+g16iMAScCJAUhEkEjnJYAkKjpRuk9tlzPDP422Xg/ESrPpAvXqpQFnctpv6Z5V7PTkBzLLgJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766619; c=relaxed/simple;
	bh=sb4DY3sXhdMEEH3Zp9IPlhiSSNzjNB4d8DC6YA/+c1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wyv7yuYHaL0gtCQKizXUiFVautvRuHjgsJKdMWIzK7krqnQ+CNqXO9tCSJxY9+1+asrUwi7O6lYtq5fb2fTsR5xEy8tDwbRU3sNhlIHuoTwRPmNNVH5cIleHNXSy8K4it6tUQzHUoYGYQ8xUhnvzROCsb7F9xh7kkCpHJahrjhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9143F1576;
	Fri,  7 Jun 2024 06:24:01 -0700 (PDT)
Received: from [192.168.0.102] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06D083F762;
	Fri,  7 Jun 2024 06:23:31 -0700 (PDT)
Message-ID: <5d26ac17-a50a-46c4-8fcb-68eaa6d0ce2a@arm.com>
Date: Fri, 7 Jun 2024 18:53:27 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: Add a test mangling with uc_sigmask
To: Mark Brown <broonie@kernel.org>
Cc: shuah@kernel.org, oleg@redhat.com, stsp2@yandex.ru, mingo@kernel.org,
 tglx@linutronix.de, mark.rutland@arm.com, ryan.roberts@arm.com,
 suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
 DeepakKumar.Mishra@arm.com, AneeshKumar.KizhakeVeetil@arm.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240607122319.768640-1-dev.jain@arm.com>
 <20240607122319.768640-3-dev.jain@arm.com>
 <ZmMHNZcYfNMW1Ft7@finisterre.sirena.org.uk>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ZmMHNZcYfNMW1Ft7@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/7/24 18:42, Mark Brown wrote:
> On Fri, Jun 07, 2024 at 05:53:19PM +0530, Dev Jain wrote:
>> This test asserts the relation between blocked signal, delivered signal,
>> and ucontext. The ucontext is mangled with, by adding a signal mask to
>> it; on return from the handler, the thread must block the corresponding
>> signal.
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   sigaltstack
>> +mangle_uc_sigmask
> Please keep these build files sorted alphabetically, this reduces
> spurioius conflicts between serieses.


Sure.

>
>> + * Author: Dev Jain <dev.jain@arm.com>
>> + *
>> + * Test describing a clear distinction between signal states - delivered and
>> + * blocked, and their relation with ucontext.
> This would be clearer if it said more positiviely what the relationship
> between these things is actually expected to be and how they're tested.
> Right now it's a bit hard to tell what the test is actually verifying.


I thought I had described that quite well in the code comments.

Anyways, I shall incorporate some detail into the initial test

description too.

>
>> +void handler_verify_ucontext(int signo, siginfo_t *info, void *uc)
>> +{
>> +	int ret;
>> +
>> +	/* Kernel dumps ucontext with USR2 blocked */
>> +	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGUSR2);
>> +	ksft_test_result(ret == 1, "USR2 in ucontext\n");
> "USR2 blocked in ucontext".
>
>> +
>> +	raise(SIGUSR2);
>> +}
> A comment explaining that we're verifying that the signal is blocked
> might be good (I think that's what this is doing?).  We're also not
> checking the return value of raise() anywhere in the program, this would
> be a useful diagnostic.


Sure.

>
>> +	/* SEGV blocked during handler execution, delivered on return */
>> +	raise(SIGPIPE);
>> +	ksft_print_msg("SEGV bypassed successfully\n");
> SIGPIPE or SIGEGV?
>
>> +	/* SIGPIPE has been blocked in sa_mask, but ucontext is invariant */
>> +	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGPIPE);
>> +	ksft_test_result(ret == 0, "USR1 not in ucontext\n");
> The relationship between the comment and test are not clear here, nor is
> that between the sigismembber() call and the test name we print?
>
>> +	/* SIGUSR1 has been blocked, but ucontext is invariant */
>> +	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGUSR1);
>> +	ksft_test_result(ret == 0, "SEGV not in ucontext\n");
> Similarly here.
>
>> +	/* add SEGV to blocked mask */
>> +	if (sigemptyset(&act.sa_mask) || sigaddset(&act.sa_mask, SIGPIPE)
>> +	    || (sigismember(&act.sa_mask, SIGPIPE) != 1))
>> +		ksft_exit_fail_msg("Cannot add SEGV to blocked mask\n");
> SIGPIPE vs SIGSEGV.


Ah sorry, I was testing out something else, and then I

did something and it partially changed it back to SEGV.

I shall revert all mentions of PIPE with SEGV. Please read

all mentions of pipe, or PIPE, as segv and SEGV.


