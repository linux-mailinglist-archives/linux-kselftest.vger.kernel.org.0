Return-Path: <linux-kselftest+bounces-32015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43081AA43BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 09:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83BB4C5028
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 07:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0C41EF087;
	Wed, 30 Apr 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bPJx5QND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552431DFE09
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997665; cv=none; b=JVMMEZ69YvQSnLvAP1GN/8eqVN0wiXeAyusD2gdAqHzk1wpHaY4kOSMUv5kyYXvOvu+FdM3XFxKUH8KpM/ePqwWDZIa16gkefs2eo5+hAGOUiu21Z9pGXGf7k8MhJNlgi3MkzoetFnU2zU9Q+Be/izcGn7QoxUhSHUcIn8c2Um4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997665; c=relaxed/simple;
	bh=AzrSyuMxDkC5K98zlQAG95tkL/pvPBXmepE6TCRz4Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mkKOBuiBfcRk97VOxt/cMOPW5j4Y30NECrgGetKxB34BeGWF4WKbQC0JLEsN3B0k/1Hdh0N/+eiDsJ0zszF+C0pIoE/v9980yEjkHlPWiMmDcKV2q1OvEa16oxk29YrsJinQ2IINO4DBGnK97z9SsQyUTL68+9Rtqfotv6xEz4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bPJx5QND; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a6cb0396-4bc5-4215-9e2e-a68be83c1c94@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745997661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OuZnX2BRFmICCR806hXS16BUkH/lmlas9chN4sIYfsU=;
	b=bPJx5QNDt0UOh1b+z/teoeW8pSlsLjqvN8xsIZ7LxxCrsjwdSOitJftIIG28PfVJ0lU720
	Kq7KISGQs3uESsgO2qFARs4nDrGziShEw2urNKkH/45pLX6V9hvHF4uNfOHFNdimWASxXn
	WxZsi9Cy1Lkr7N7P2Zm1fFMkaf5y8BI=
Date: Wed, 30 Apr 2025 00:20:48 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] KVM: riscv: selftests: Decode stval to identify
 exact exception type
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250429-kvm_selftest_improve-v2-0-51713f91e04a@rivosinc.com>
 <20250429-kvm_selftest_improve-v2-2-51713f91e04a@rivosinc.com>
 <20250430-b40cd14818cc9264506e61f2@orel>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250430-b40cd14818cc9264506e61f2@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/30/25 12:09 AM, Andrew Jones wrote:
> On Tue, Apr 29, 2025 at 05:18:46PM -0700, Atish Patra wrote:
>> Currently, the sbi_pmu_test continues if the exception type is illegal
>> instruction because access to hpmcounter will generate that. However
>> illegal instruction exception may occur due to the other reasons
>> which should result in test assertion.
>>
>> Use the stval to decode the exact type of instructions and which csrs are
>> being accessed if it is csr access instructions. Assert in all cases
>> except if it is a csr access instructions that access valid PMU related
>> registers.
>>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   .../testing/selftests/kvm/include/riscv/processor.h  | 13 +++++++++++++
>>   tools/testing/selftests/kvm/riscv/sbi_pmu_test.c     | 20 ++++++++++++++++++++
>>   2 files changed, 33 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
>> index 1b5aef87de0f..162f303d9daa 100644
>> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
>> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
>> @@ -11,6 +11,19 @@
>>   #include <asm/csr.h>
>>   #include "kvm_util.h"
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
>> +
>>   static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
>>   				    uint64_t idx, uint64_t size)
>>   {
>> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> index 6e66833e5941..3c47268df262 100644
>> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> @@ -130,9 +130,29 @@ static void stop_counter(unsigned long counter, unsigned long stop_flags)
>>   
>>   static void guest_illegal_exception_handler(struct pt_regs *regs)
>>   {
>> +	unsigned long insn;
>> +	int opcode, csr_num, funct3;
>> +
>>   	__GUEST_ASSERT(regs->cause == EXC_INST_ILLEGAL,
>>   		       "Unexpected exception handler %lx\n", regs->cause);
>>   
>> +	insn = regs->badaddr;
>> +	opcode = (insn & INSN_OPCODE_MASK) >> INSN_OPCODE_SHIFT;
>> +	__GUEST_ASSERT(opcode == INSN_OPCODE_SYSTEM,
>> +		       "Unexpected instruction with opcode 0x%x insn 0x%lx\n", opcode, insn);
>> +
>> +	csr_num = GET_CSR_NUM(insn);
>> +	funct3 = GET_RM(insn);
>> +	/* Validate if it is a CSR read/write operation */
>> +	__GUEST_ASSERT(funct3 <= 7 && (funct3 != 0 && funct3 != 4),
>> +		       "Unexpected system opcode with funct3 0x%x csr_num 0x%x\n",
>> +		       funct3, csr_num);
>> +
>> +	/* Validate if it is a HPMCOUNTER CSR operation */
>> +	__GUEST_ASSERT((csr_num >= CSR_CYCLE && csr_num <= CSR_HPMCOUNTER31) ||
>> +		       (csr_num >= CSR_CYCLEH && csr_num <= CSR_HPMCOUNTER31H),
> We should never get csr accesses to the rv32 high registers since we only
> support 64-bit.

Sure. I will remove that along with CSR_CYCLEH in pmu_csr_read_num.

>> +		       "Unexpected csr_num 0x%x\n", csr_num);
>> +
>>   	illegal_handler_invoked = true;
>>   	/* skip the trapping instruction */
>>   	regs->epc += 4;
>>
>> -- 
>> 2.43.0
>>
> Otherwise,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

