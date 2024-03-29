Return-Path: <linux-kselftest+bounces-6901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A9D892516
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 21:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C67C1C210BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6933E13BAC4;
	Fri, 29 Mar 2024 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L2zt8eif"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4699D13BAD1;
	Fri, 29 Mar 2024 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711743514; cv=none; b=j2hUMl9NyGzSDJP9D+OX7+sbNQl02uJeOwLiIYfS7ZIoMaBPLsqmW/jyWFUtGqZN4jPEzBxKaNM7IowzhVMslqTg+//xfLymH6hV62MaIaGnIgOuOii5e9xzwtIRkH5HWMjNpof2iW7QWN7Tcw8zkKXKTjtgqP9CWAgXF8imcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711743514; c=relaxed/simple;
	bh=M1bVLI2QVrqN4cSmcZhh5HNh6nWGHhPJEonGQgPvO00=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q8XWirNIrCY/iG2sgaBNL9z10ipPNp8KvMULAgzBLiQ3oxYnUsFdhW++cX5jhVlGbpdAUnZG20D2pnBZ2mgswRNCJhh4m1A3AuXfmG60vYtoGDkDdiVVeJcQA7IKbu/UkeUEIi7tV7upwlWyDD7BLzxzw0IOs1hlQVJFBV1BUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L2zt8eif; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711743510;
	bh=M1bVLI2QVrqN4cSmcZhh5HNh6nWGHhPJEonGQgPvO00=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=L2zt8eif9xbOYilCC0YsH5YJqm0E16o6ScfkTW8PJ/tzy1yVnA9m7MIrFJkygElI4
	 9hCl+N3ah/v40+3Yx+05eCqrFqcX/Awpvn4TAeuhHQOQ+2N0rNKzn/gOCGMxoZr/Gq
	 DF/h2vk8S2rZYUfUNjluciLLrYgJv+amN4UxvGROCmzTJmOZ+DVJJnw3K4pPOUc4TY
	 i/xNMJah3fDLREZOStrAZWyACogXW5CaWGDtRv5u0TLiGFA9n0LpoIpiTsYcr08Jxl
	 b7svNLTCyPu+7BoeuNWz0Bky0Jlr+lhnkzgi3pd6Fh/OFrM5fTlRMzBRvyWIRIa/JA
	 +luzgRZU3AZeg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9C34B3780C21;
	Fri, 29 Mar 2024 20:18:23 +0000 (UTC)
Message-ID: <42ca1da5-445b-47ca-a952-444eaa921360@collabora.com>
Date: Sat, 30 Mar 2024 01:18:54 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, seanjc@google.com,
 pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org,
 ravi.v.shankar@intel.com, xin@zytor.com
Subject: Re: [PATCH v2 25/25] KVM: selftests: Add fred exception tests
To: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-26-xin3.li@intel.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240207172646.3981-26-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/24 10:26 PM, Xin Li wrote:
> Add tests for FRED event data and VMX nested-exception.
> 
> FRED is designed to save a complete event context in its stack frame,
> e.g., FRED saves the faulting linear address of a #PF into a 64-bit
> event data field defined in FRED stack frame.  As such, FRED VMX adds
> event data handling during VMX transitions.
> 
> Besides, FRED introduces event stack levels to dispatch an event handler
> onto a stack baesd on current stack level and stack levels defined in
> IA32_FRED_STKLVLS MSR for each exception vector.  VMX nested-exception
> support ensures a correct event stack level is chosen when a VM entry
> injects a nested exception, which is regarded as occurred in ring 0.
> 
> To fully test the underlying FRED VMX code, this test should be run one
> more round with EPT disabled to inject page faults as nested exceptions.
> 
> Originally-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
Thank you for the new test patch. We have been trying to ensure TAP
conformance for tests which cannot be achieved if new tests aren't using
TAP already. Please make your test TAP compliant.

> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/include/x86_64/processor.h  |  32 ++
>  .../testing/selftests/kvm/x86_64/fred_test.c  | 297 ++++++++++++++++++
Add generated binary object to .gitignore.

>  3 files changed, 330 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/fred_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 492e937fab00..eaac13a605f2 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -67,6 +67,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
>  TEST_GEN_PROGS_x86_64 += x86_64/exit_on_emulation_failure_test
>  TEST_GEN_PROGS_x86_64 += x86_64/fix_hypercall_test
>  TEST_GEN_PROGS_x86_64 += x86_64/hwcr_msr_test
> +TEST_GEN_PROGS_x86_64 += x86_64/fred_test
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_clock
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_evmcs
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index bc5cd8628a20..ef7aaab790e0 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -1275,4 +1275,36 @@ void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>  #define PFERR_GUEST_PAGE_MASK	BIT_ULL(PFERR_GUEST_PAGE_BIT)
>  #define PFERR_IMPLICIT_ACCESS	BIT_ULL(PFERR_IMPLICIT_ACCESS_BIT)
>  
> +/*
> + * FRED related data structures and functions
> + */
> +
> +#define FRED_SSX_NMI		BIT_ULL(18)
> +
> +struct fred_stack {
> +	u64 r15;
> +	u64 r14;
> +	u64 r13;
> +	u64 r12;
> +	u64 bp;
> +	u64 bx;
> +	u64 r11;
> +	u64 r10;
> +	u64 r9;
> +	u64 r8;
> +	u64 ax;
> +	u64 cx;
> +	u64 dx;
> +	u64 si;
> +	u64 di;
> +	u64 error_code;
> +	u64 ip;
> +	u64 csx;
> +	u64 flags;
> +	u64 sp;
> +	u64 ssx;
> +	u64 event_data;
> +	u64 reserved;
> +};
> +
>  #endif /* SELFTEST_KVM_PROCESSOR_H */
> diff --git a/tools/testing/selftests/kvm/x86_64/fred_test.c b/tools/testing/selftests/kvm/x86_64/fred_test.c
> new file mode 100644
> index 000000000000..412afa919568
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/fred_test.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * FRED nested exception tests
> + *
> + * Copyright (C) 2023, Intel, Inc.
> + */
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <asm/msr-index.h>
> +
> +#include "apic.h"
> +#include "kvm_util.h"
> +#include "test_util.h"
> +#include "guest_modes.h"
> +#include "processor.h"
> +
> +#define IRQ_VECTOR 0xAA
> +
> +#define FRED_STKLVL(v,l)		(_AT(unsigned long, l) << (2 * (v)))
> +#define FRED_CONFIG_ENTRYPOINT(p)	_AT(unsigned long, (p))
> +
> +/* This address is already mapped in guest page table. */
> +#define FRED_VALID_RSP			0x8000
> +
> +/*
> + * The following addresses are not yet mapped in both EPT and guest page
> + * tables at the beginning.  As a result, it causes an EPT violation VM
> + * exit with an original guest #PF to access any of them for the first
> + * time.
> + *
> + * Use these addresses as guest FRED RSP0 to generate nested #PFs to test
> + * if event data are properly virtualized.
> + */
> +static unsigned long fred_invalid_rsp[4] = {
> +	0x0,
> +	0xf0000000,
> +	0xe0000000,
> +	0xd0000000,
> +};
> +
> +extern char asm_user_nop[];
> +extern char asm_user_ud[];
> +extern char asm_done_fault[];
> +
> +extern void asm_test_fault(int test);
> +
> +/*
> + * user level code for triggering faults.
> + */
> +asm(".pushsection .text\n"
> +    ".align 4096\n"
> +
> +    ".type asm_user_nop, @function\n"
> +    "asm_user_nop:\n"
> +    "1: .byte 0x90\n"
> +    "jmp 1b\n"
> +
> +    ".fill asm_user_ud - ., 1, 0xcc\n"
> +
> +    ".type asm_user_ud, @function\n"
> +    ".org asm_user_nop + 16\n"
> +    "asm_user_ud:\n"
> +    /* Trigger a #UD */
> +    "ud2\n"
> +
> +    ".align 4096, 0xcc\n"
> +    ".popsection");
> +
> +/* Send current stack level and #PF address */
> +#define GUEST_SYNC_CSL_FA(__stage, __pf_address)		\
> +	GUEST_SYNC_ARGS(__stage, __pf_address, 0, 0, 0)
> +
> +void fred_entry_from_user(struct fred_stack *stack)
> +{
> +	u32 current_stack_level = rdmsr(MSR_IA32_FRED_CONFIG) & 0x3;
> +
> +	GUEST_SYNC_CSL_FA(current_stack_level, stack->event_data);
> +
> +	/* Do NOT go back to user level, continue the next test instead */
> +	stack->ssx = 0x18;
> +	stack->csx = 0x10;
> +	stack->ip = (u64)&asm_done_fault;
> +}
> +
> +void fred_entry_from_kernel(struct fred_stack *stack)
> +{
> +	/*
> +	 * Keep NMI blocked to delay the delivery of the next NMI until
> +	 * returning to user level.
> +	 * */
> +	stack->ssx &= ~FRED_SSX_NMI;
> +}
> +
> +#define PUSH_REGS	\
> +	"push %rdi\n"	\
> +	"push %rsi\n"	\
> +	"push %rdx\n"	\
> +	"push %rcx\n"	\
> +	"push %rax\n"	\
> +	"push %r8\n"	\
> +	"push %r9\n"	\
> +	"push %r10\n"	\
> +	"push %r11\n"	\
> +	"push %rbx\n"	\
> +	"push %rbp\n"	\
> +	"push %r12\n"	\
> +	"push %r13\n"	\
> +	"push %r14\n"	\
> +	"push %r15\n"
> +
> +#define POP_REGS	\
> +	"pop %r15\n"	\
> +	"pop %r14\n"	\
> +	"pop %r13\n"	\
> +	"pop %r12\n"	\
> +	"pop %rbp\n"	\
> +	"pop %rbx\n"	\
> +	"pop %r11\n"	\
> +	"pop %r10\n"	\
> +	"pop %r9\n"	\
> +	"pop %r8\n"	\
> +	"pop %rax\n"	\
> +	"pop %rcx\n"	\
> +	"pop %rdx\n"	\
> +	"pop %rsi\n"	\
> +	"pop %rdi\n"
> +
> +/*
> + * FRED entry points.
> + */
> +asm(".pushsection .text\n"
> +    ".type asm_fred_entrypoint_user, @function\n"
> +    ".align 4096\n"
> +    "asm_fred_entrypoint_user:\n"
> +    "endbr64\n"
> +    PUSH_REGS
> +    "movq %rsp, %rdi\n"
> +    "call fred_entry_from_user\n"
> +    POP_REGS
> +    /* Do NOT go back to user level, continue the next test instead */
> +    ".byte 0xf2,0x0f,0x01,0xca\n"	/* ERETS */
> +
> +    ".fill asm_fred_entrypoint_kernel - ., 1, 0xcc\n"
> +
> +    ".type asm_fred_entrypoint_kernel, @function\n"
> +    ".org asm_fred_entrypoint_user + 256\n"
> +    "asm_fred_entrypoint_kernel:\n"
> +    "endbr64\n"
> +    PUSH_REGS
> +    "movq %rsp, %rdi\n"
> +    "call fred_entry_from_kernel\n"
> +    POP_REGS
> +    ".byte 0xf2,0x0f,0x01,0xca\n"	/* ERETS */
> +    ".align 4096, 0xcc\n"
> +    ".popsection");
> +
> +extern char asm_fred_entrypoint_user[];
> +
> +/*
> + * Prepare a FRED stack frame for ERETU to return to user level code,
> + * nop or ud2.
> + *
> + * Because FRED RSP0 is deliberately not mapped in guest page table,
> + * the delivery of interrupt/NMI or #UD from ring 3 causes a nested
> + * #PF, which is then delivered on FRED RSPx (x is 1, 2 or 3,
> + * determinated by MSR FRED_STKLVL[PF_VECTOR]).
> + */
> +asm(".pushsection .text\n"
> +    ".type asm_test_fault, @function\n"
> +    ".align 4096\n"
> +    "asm_test_fault:\n"
> +    "endbr64\n"
> +    "push %rbp\n"
> +    "mov %rsp, %rbp\n"
> +    "and $(~0x3f), %rsp\n"
> +    "push $0\n"
> +    "push $0\n"
> +    "mov $0x2b, %rax\n"
> +    /* Unblock NMI */
> +    "bts $18, %rax\n"
> +    /* Set long mode bit */
> +    "bts $57, %rax\n"
> +    "push %rax\n"
> +    /* No stack required for the FRED user level test code */
> +    "push $0\n"
> +    "pushf\n"
> +    "pop %rax\n"
> +    /* Allow external interrupts */
> +    "bts $9, %rax\n"
> +    "push %rax\n"
> +    "mov $0x33, %rax\n"
> +    "push %rax\n"
> +    "cmp $0, %edi\n"
> +    "jne 1f\n"
> +    "lea asm_user_nop(%rip), %rax\n"
> +    "jmp 2f\n"
> +    "1: lea asm_user_ud(%rip), %rax\n"
> +    "2: push %rax\n"
> +    "push $0\n"
> +    /* ERETU to user level code to allow event delivery immediately */
> +    ".byte 0xf3,0x0f,0x01,0xca\n"
> +    "asm_done_fault:\n"
> +    "mov %rbp, %rsp\n"
> +    "pop %rbp\n"
> +    "ret\n"
> +    ".align 4096, 0xcc\n"
> +    ".popsection");
> +
> +/*
> + * To fully test the underlying FRED VMX code, this test should be run one
> + * more round with EPT disabled to inject page faults as nested exceptions.
> + */
> +static void guest_code(void)
> +{
> +	wrmsr(MSR_IA32_FRED_CONFIG,
> +	      FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
> +
> +	wrmsr(MSR_IA32_FRED_RSP1, FRED_VALID_RSP);
> +	wrmsr(MSR_IA32_FRED_RSP2, FRED_VALID_RSP);
> +	wrmsr(MSR_IA32_FRED_RSP3, FRED_VALID_RSP);
> +
> +	/* Enable FRED */
> +	set_cr4(get_cr4() | X86_CR4_FRED);
> +
> +	x2apic_enable();
> +
> +	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 1));
> +	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[1]);
> +	/* 1: ud2 to generate #UD */
> +	asm_test_fault(1);
> +
> +	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 2));
> +	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[2]);
> +	asm volatile("cli");
> +	/* Create a pending interrupt on current vCPU */
> +	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
> +			 APIC_DM_FIXED | IRQ_VECTOR);
> +	/* Return to ring 3 */
> +	asm_test_fault(0);
> +	x2apic_write_reg(APIC_EOI, 0);
> +
> +	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 3));
> +	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[3]);
> +	/*
> +	 * The first NMI is just to have NMI blocked in ring 0, because
> +	 * fred_entry_from_kernel() deliberately clears the NMI bit in
> +	 * FRED stack frame.
> +	 */
> +	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
> +			 APIC_DM_NMI | NMI_VECTOR);
> +	/* The second NMI will be delivered after returning to ring 3 */
> +	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
> +			 APIC_DM_NMI | NMI_VECTOR);
> +	/* Return to ring 3 */
> +	asm_test_fault(0);
> +
> +	GUEST_DONE();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	uint64_t expected_current_stack_level = 1;
> +
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_FRED));
> +
> +	vm = __vm_create_with_vcpus(VM_SHAPE(VM_MODE_PXXV48_4K_USER), 1, 0,
> +				    guest_code, &vcpu);
> +
> +	while (true) {
> +		uint64_t r;
> +
> +		vcpu_run(vcpu);
> +
> +		r = get_ucall(vcpu, &uc);
> +
> +		if (r == UCALL_DONE)
> +			break;
> +
> +		if (r == UCALL_SYNC) {
> +			TEST_ASSERT((uc.args[1] == expected_current_stack_level) &&
> +				    (uc.args[2] == fred_invalid_rsp[expected_current_stack_level] - 1),
> +				    "Incorrect stack level %lx and #PF address %lx\n",
> +				    uc.args[1], uc.args[2]);
> +			expected_current_stack_level++;
> +		}
> +	}
> +
> +	kvm_vm_free(vm);
> +	return 0;
> +}

-- 
BR,
Muhammad Usama Anjum

