Return-Path: <linux-kselftest+bounces-31825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD3DA9FD3E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 00:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C3B46736B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 22:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138BD213228;
	Mon, 28 Apr 2025 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gbk/utjp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9070C212D7C
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745880492; cv=none; b=FrbblviA2krTkT6y6m4H6fuuKPwrdUbnBaNufVwTBF7yEYUk7jkYdSBDhE1iSOhM7STY654EYmTtJXFdSEmYyS0p4Twe8lZwPsgSao7Yp46+FMmQjZ7QdLZP6j0s/tZbbHNcZl9FvPjysW3CSJ8SnnAporkQLIaS4Ila7Q0BabA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745880492; c=relaxed/simple;
	bh=61hw2WjKWqr8vrs64icdWDbWk2Ur0bzT3WBhvqAtzOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K08IsB6cIYFctTzTfql1SwUi63xM92rHtumCRDalkS9cbQ7KtAqmmroMVfDC2LCSTQHOE3OyK5A81XPyZw4ghFBNMEoY55kp64IzdIDNLt54gX8nW4uWc9APi+tJJdud2jx6ojifwKouRb274TQnJDZPQXU3BBhxhVRuDQltNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gbk/utjp; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3b05d1a0-c873-4e61-b98c-b725d0dbb350@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745880477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcxC+Ay3y++e8Uv8HSaPaQbT8svhorPAd8NEoyT9pQI=;
	b=gbk/utjp8SkhpN2UgzGCFAPMbnS1Kbgb7ZVz2I/t/rMrQETR+n3GqokpmvE7WiWgDWPYPX
	/JeD4wVWLBC8aDNWmBSoea57Ec18zpj6W9h3E9HYcwQZvFizVSfbmwAyLRp+a26L8Ukoq9
	YUvPHUR6+gr98+SWOqpUx33iB6ZR1/A=
Date: Mon, 28 Apr 2025 15:47:47 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] KVM: riscv: selftests: Add stval to exception
 handling
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com>
 <20250324-kvm_selftest_improve-v1-1-583620219d4f@rivosinc.com>
 <20250425-dc44cb547ab5e2f994c94e80@orel>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250425-dc44cb547ab5e2f994c94e80@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/25/25 6:50 AM, Andrew Jones wrote:
> On Mon, Mar 24, 2025 at 05:40:29PM -0700, Atish Patra wrote:
>> Save stval during exception handling so that it can be decoded to
>> figure out the details of exception type.
>>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   tools/testing/selftests/kvm/include/riscv/processor.h | 1 +
>>   tools/testing/selftests/kvm/lib/riscv/handlers.S      | 2 ++
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
>> index 5f389166338c..f4a7d64fbe9a 100644
>> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
>> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
>> @@ -95,6 +95,7 @@ struct ex_regs {
>>   	unsigned long epc;
>>   	unsigned long status;
>>   	unsigned long cause;
>> +	unsigned long stval;
>>   };
>>   
>>   #define NR_VECTORS  2
>> diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/testing/selftests/kvm/lib/riscv/handlers.S
>> index aa0abd3f35bb..2884c1e8939b 100644
>> --- a/tools/testing/selftests/kvm/lib/riscv/handlers.S
>> +++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
>> @@ -45,9 +45,11 @@
>>   	csrr  s0, CSR_SEPC
>>   	csrr  s1, CSR_SSTATUS
>>   	csrr  s2, CSR_SCAUSE
>> +	csrr  s3, CSR_STVAL
>>   	sd    s0, 248(sp)
>>   	sd    s1, 256(sp)
>>   	sd    s2, 264(sp)
>> +	sd    s3, 272(sp)
> We can't add stval without also changing how much stack we allocate at the
> top of this macro, but since we need to keep sp 16-byte aligned in order
> to call C code (route_exception()) we'll need to decrement -8*36, not

Yes. Thanks for catching that.

> -8*35. Or, we could just switch struct ex_regs to be the kernel's struct
> pt_regs which has 36 unsigned longs. The 'badaddr' member is for stval and
> the additional long is orig_a0.

I think switching to pt_regs is better in terms of maintainability in 
the future.
I will do that.

>>   .endm
>>   
>>   .macro restore_context
> I guess we should restore stval too.

Do we ?  stval is written by hardware and doesn't contain any state of 
the interrupted program.
Once, the trap handler processes the trap using stval information, there 
is no need to restore it.

Am I missing something ?

> Thanks,
> drew
>
>> -- 
>> 2.43.0
>>
>>
>> -- 
>> kvm-riscv mailing list
>> kvm-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kvm-riscv

