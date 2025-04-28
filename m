Return-Path: <linux-kselftest+bounces-31826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A53EA9FD40
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 00:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A10466F7B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 22:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1F7212D7C;
	Mon, 28 Apr 2025 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kr0+CrOq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94B20B7FD
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745880526; cv=none; b=gMmM0A/+U3htaUwDiTYHINueC7ACDyetqhHWYBwgRtmKiN7vJZqo9ckLKwLvFh5ADU45viNpnfM0yJsGx7RBHBNvROQG0L1/bZATmMq0RT3pXXrR51umtY5XVfyf/N/xhgYsb8IpcBl2wyItMw+9EjS8T3oScz2HV/q7jt4d51Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745880526; c=relaxed/simple;
	bh=3KezIHks5DFTdggB/bwppiff9TnoCs9sC1waoLEwHjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXOtNswDCbBNFQ0OPs8B3vRtvQGDrZMWuRk+PPS0brO6tjt2Lk+8/1aMjwtGq+8pCJt4x+w9uiESaELih3l+37dUnsqURdF6S+WsZZBQDGxeTHh4i1FGhldAYUHer6/mTlKOCBBUj5bHh9N+MIxAPn+WmFfFsLyT+7+MtkevkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kr0+CrOq; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7f84de30-80db-492a-adde-1f29d69da240@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745880522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Af90aGrC2fXAsIAg/iqopX2dqetTTJsU459B5Sz2Uc=;
	b=kr0+CrOqqJGG1pjipZbprnsXdDL6NdYRS4iHHbqyrB3DYBuIR4qpd7CBo+UQPc6uVbun1L
	yeY0lB/i17viQCICOibcVYCReswttjPAWNoVeBeAwek3wSgxYS2K1YyoCe3YdhU193OvNl
	G4CW3yygzDw3rSvTjNNuvGHvVh6u0bY=
Date: Mon, 28 Apr 2025 15:48:37 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] KVM: riscv: selftests: Decode stval to identify exact
 exception type
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com>
 <20250324-kvm_selftest_improve-v1-2-583620219d4f@rivosinc.com>
 <20250425-f458b9801a83cc35bda55c74@orel>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250425-f458b9801a83cc35bda55c74@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/25/25 6:33 AM, Andrew Jones wrote:
> On Mon, Mar 24, 2025 at 05:40:30PM -0700, Atish Patra wrote:
>> Currently, the sbi_pmu_test continues if the exception type is illegal
>> instruction because access to hpmcounter will generate that. However, we
>> may get illegal for other reasons as well which should result in test
>> assertion.
>>
>> Use the stval to decode the exact type of instructions and which csrs are
>> being accessed if it is csr access instructions. Assert in all cases
>> except if it is a csr access instructions that access valid PMU related
>> registers.
>>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 32 ++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> index 03406de4989d..11bde69b5238 100644
>> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> @@ -128,11 +128,43 @@ static void stop_counter(unsigned long counter, unsigned long stop_flags)
>>   		       "Unable to stop counter %ld error %ld\n", counter, ret.error);
>>   }
>>   
>> +#define INSN_OPCODE_MASK	0x007c
>> +#define INSN_OPCODE_SHIFT	2
>> +#define INSN_OPCODE_SYSTEM	28
>> +
>> +#define INSN_MASK_FUNCT3	0x7000
>> +#define INSN_SHIFT_FUNCT3	12
>> +
>> +#define INSN_CSR_MASK		0xfff00000
>> +#define INSN_CSR_SHIFT		20
>> +
>> +#define GET_RM(insn)            (((insn) & INSN_MASK_FUNCT3) >> INSN_SHIFT_FUNCT3)
>> +#define GET_CSR_NUM(insn)       (((insn) & INSN_CSR_MASK) >> INSN_CSR_SHIFT)
> It'd be good to put these macros in include/riscv/processor.h or some new
> include/riscv/ header to be shared with other tests that may want to
> decode stval.

Sure. I will move it to include/riscv/processor.h

> Thanks,
> drew
>
>> +
>>   static void guest_illegal_exception_handler(struct ex_regs *regs)
>>   {
>> +	unsigned long insn;
>> +	int opcode, csr_num, funct3;
>> +
>>   	__GUEST_ASSERT(regs->cause == EXC_INST_ILLEGAL,
>>   		       "Unexpected exception handler %lx\n", regs->cause);
>>   
>> +	insn = regs->stval;
>> +	opcode = (insn & INSN_OPCODE_MASK) >> INSN_OPCODE_SHIFT;
>> +	__GUEST_ASSERT(opcode == INSN_OPCODE_SYSTEM,
>> +		       "Unexpected instruction with opcode 0x%x insn 0x%lx\n", opcode, insn);
>> +
>> +	csr_num = GET_CSR_NUM(insn);
>> +	funct3 = GET_RM(insn);
>> +	/* Validate if it is a CSR read/write operation */
>> +	__GUEST_ASSERT(funct3 <= 7 && (funct3 != 0 || funct3 != 4),
>> +		       "Unexpected system opcode with funct3 0x%x csr_num 0x%x\n",
>> +		       funct3, csr_num);
>> +
>> +	/* Validate if it is a HPMCOUNTER CSR operation */
>> +	__GUEST_ASSERT(csr_num == CSR_CYCLE || csr_num <= CSR_HPMCOUNTER31,
>> +		       "Unexpected csr_num 0x%x\n", csr_num);
>> +
>>   	illegal_handler_invoked = true;
>>   	/* skip the trapping instruction */
>>   	regs->epc += 4;
>>
>> -- 
>> 2.43.0
>>
>>
>> -- 
>> kvm-riscv mailing list
>> kvm-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kvm-riscv

