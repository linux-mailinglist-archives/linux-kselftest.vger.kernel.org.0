Return-Path: <linux-kselftest+bounces-20616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8939AFC8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 10:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1882280E32
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 08:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD01B6CE4;
	Fri, 25 Oct 2024 08:31:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED66318BC06
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845104; cv=none; b=u1vFwRok05EGrzTnyI8QAKc/CWdmWNqiOZE32BNonVafpC9pdMS+ZS6MzGn40A9A8dT0AI6vUv/pVcXWoksyBX8+3/MnDNt+0toWIitqvF8Za4has8LkEd5IcKAkx3lkZSUfNRxQLFxNGLjaQ8CgeSTvi+qx5RfDg9mjPWPTN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845104; c=relaxed/simple;
	bh=/+Bd05Dzqi3BFxoRn9lH6U5ajGPwYwF94sxaDyJKxrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqxInLkebbAe4yk1xa3Spt3SSIPa8dP/icNiYavhlZ0VTB13/itTAQNfwF84ro8NaCitpTxoPo6f81EtXDgV2KaGmq+xOPQuwnkMOvShb5lZHcTJQ7NUoFHnI7UOD0pZRXelKF0h/tA2Cfw4+VDH+oNW032pSifSKtraG2nR4zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 287DA339;
	Fri, 25 Oct 2024 01:32:10 -0700 (PDT)
Received: from [10.57.66.80] (unknown [10.57.66.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C29B3F73B;
	Fri, 25 Oct 2024 01:31:36 -0700 (PDT)
Message-ID: <c35d8783-c754-4864-b964-4a3bfaa4cd11@arm.com>
Date: Fri, 25 Oct 2024 10:31:33 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] selftests/mm: Use generic pkey register
 manipulation
To: Dave Hansen <dave.hansen@intel.com>, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, anshuman.khandual@arm.com,
 aruna.ramakrishna@oracle.com, broonie@kernel.org, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, dave.martin@arm.com, jeffxu@chromium.org,
 joey.gouly@arm.com, pierre.langlois@arm.com, shuah@kernel.org,
 sroettger@google.com, will@kernel.org, linux-kselftest@vger.kernel.org,
 x86@kernel.org, Yury Khrustalev <Yury.Khrustalev@arm.com>
References: <20241023150511.3923558-1-kevin.brodsky@arm.com>
 <20241023150511.3923558-5-kevin.brodsky@arm.com>
 <6b575236-7e4e-4128-9ab6-7ecec7b81428@intel.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <6b575236-7e4e-4128-9ab6-7ecec7b81428@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/10/2024 18:51, Dave Hansen wrote:
> On 10/23/24 08:05, Kevin Brodsky wrote:
> ...> diff --git a/tools/testing/selftests/mm/pkey-x86.h
> b/tools/testing/selftests/mm/pkey-x86.h
>> index 5f28e26a2511..53ed9a336ffe 100644
>> --- a/tools/testing/selftests/mm/pkey-x86.h
>> +++ b/tools/testing/selftests/mm/pkey-x86.h
>> @@ -34,6 +34,8 @@
>>  #define PAGE_SIZE		4096
>>  #define MB			(1<<20)
>>  
>> +#define PKEY_ALLOW_NONE		0x55555555
> Hi Kevin,
>
> Looking at this in context, I think "PKEY_ALLOW_NONE" is not a great
> name.  On one hand, we have:
>
> 	PKEY_DISABLE_ACCESS
> 	PKEY_DISABLE_WRITE
>
> which are values for *A* pkey.
>
> But PKEY_ALLOW_NONE is a whole register value and spans permissions for
> many keys.  We don't want folks trying to do something like:
>
> 	pkey_alloc(flags, PKEY_ALLOW_NONE);
>
> If I were naming it in x86 code, I'd probably call it:
>
> 	PKRU_ALLOW_NONE
>
> or something.

I agree, the naming is not ideal, I lacked inspiration! Maybe
PKEY_REG_ALLOW_NONE to remain generic?

>
>>  static inline void __page_o_noops(void)
>>  {
>>  	/* 8-bytes of instruction * 512 bytes = 1 page */
>> diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
>> index a8088b645ad6..b5e1767ee5d9 100644
>> --- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
>> +++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
>> @@ -37,6 +37,8 @@ pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
>>  pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
>>  siginfo_t siginfo = {0};
>>  
>> +static u64 pkey_reg_no_access;
> Ideally, this would be a real const or a #define because it really is
> static.  Right?  Or is there something dynamic about the ARM
> implementation's value?

It isn't dynamic no, the issue is that on architectures where pkeys
restrict execution we need to allow X for pkey 0. Of course it would be
possible to define PKEY_REG_ALLOW_ALL in such a way that X is allowed
for pkey 0, but I was concerned this might be misleading. No strong
opinion either way, happy to make it purely a macro, maybe with a better
name?

> ...
>>  	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
>> @@ -142,7 +145,8 @@ static void *thread_segv_maperr_ptr(void *ptr)
>>  	syscall_raw(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
>>  
>>  	/* Disable MPK 0.  Only MPK 1 is enabled. */
>> -	__write_pkey_reg(0x55555551);
>> +	pkey_reg = set_pkey_bits(pkey_reg_no_access, 1, 0);
>> +	__write_pkey_reg(pkey_reg);
> The existing magic numbers are not great, but could we do:
>
> #define PKEY_ALLOW_ALL 0x0
>
> So that this can be written like this:
>
> 	pkey_reg = PKRU_ALLOW_NONE;
> 	pkey_reg = set_pkey_bits(pkey_reg, 1, PKEY_ALLOW_ALL);
>
> That would get rid of the magic '0'.

Definitely better yes. But how about using Yury's uapi addition,
PKEY_UNRESTRICTED [1]?

[1]
https://lore.kernel.org/all/20241022120128.359652-1-yury.khrustalev@arm.com/

>
>>  	/* Segfault */
>>  	*bad = 1;
>> @@ -240,6 +244,7 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
>>  	int pkey;
>>  	int parent_pid = 0;
>>  	int child_pid = 0;
>> +	u64 pkey_reg;
>>  
>>  	sa.sa_flags = SA_SIGINFO | SA_ONSTACK;
>>  
>> @@ -257,7 +262,9 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
>>  	assert(stack != MAP_FAILED);
>>  
>>  	/* Allow access to MPK 0 and MPK 1 */
>> -	__write_pkey_reg(0x55555550);
>> +	pkey_reg = set_pkey_bits(pkey_reg_no_access, 0, 0);
>> +	pkey_reg = set_pkey_bits(pkey_reg, 1, 0);
>> +	__write_pkey_reg(pkey_reg);
> ... and using the pattern from above, this is quite a bit more readable:
>
> 	pkey_reg = PKRU_ALLOW_NONE;
> 	pkey_reg = set_pkey_bits(pkey_reg, 0, PKEY_ALLOW_ALL);
> 	pkey_reg = set_pkey_bits(pkey_reg, 1, PKEY_ALLOW_ALL);
>
> ...
>> +	/* Only allow X for MPK 0 and nothing for other keys */
>> +	pkey_reg_no_access = set_pkey_bits(PKEY_ALLOW_NONE, 0,
>> +					   PKEY_DISABLE_ACCESS);
> If the comment says "only allow X", then I'd expect the code to say:
>
> 	pkey_reg_no_access = set_pkey_bits(PKEY_ALLOW_NONE, 0, PKEY_X);
>
> ... or something similar.

I could #define PKEY_X PKEY_DISABLE_ACCESS but is the mixture of
negative and positive polarity really helping? We cannot define PKEY_R
and PKEY_W so that (for instance) PKEY_R | PKEY_X does what it says.
Having to use PKEY_DISABLE_ACCESS to mean "X only" is not ideal, but
this is what userspace already has to do.

Either way if we define PKEY_REG_ALLOW_NONE or similar to allow X for
pkey 0 as suggested then this will go.

Thanks for the review!

Kevin


