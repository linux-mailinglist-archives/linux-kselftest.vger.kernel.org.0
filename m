Return-Path: <linux-kselftest+bounces-6061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D31875608
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 19:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD311C2074B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584FC131E2E;
	Thu,  7 Mar 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KJzvlxKJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186371332A7
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Mar 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835743; cv=none; b=LCoAOJP2PiKVm8B2ByxJRQOPkv3uPG+tyLKIOXMyU6mW9BLKF4qhiL+Oqa/bQFu6bmKpbFqFYjDAkE+aDnSB8p3ponMU2lm86+4HRIXZrxQByNveIVtN3GHBI8E9T+1yT/Z9oqXK3qrEuBoDSxOCp2lm7YatmN6wxKoJNE0kYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835743; c=relaxed/simple;
	bh=MvIahTrTqjQbnEWZDHoAYa0jlgqVtVHddDlO3dnhGkY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=swLHWuGhvAIB0MsuPL6pkfzCj0VrmMoD8LTEd9B0eySL0/6a+JUO8QRwjuKZaWQ/C+24UhdRhQnJ+BwffYhiun+x7kUstI0lHkF0a/1S7rV9JuAdte40FSci6rePZDLGK3Zl75X/o13MaT5pmiSkEJPF7+uzHr/n3wvigmDiBvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KJzvlxKJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso2502708276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Mar 2024 10:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709835740; x=1710440540; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYhTYHOXWFkjcmXmPD3zJwyk7pg1G0PQhE3XitSL9PI=;
        b=KJzvlxKJXp/22fcR0Qywv82yRjZ/KGS5C6iO/55H6hVsYl3AfeRBR8KQRWoX3LxmcV
         Bd1wI0WDWx3AyT0HFbdVfi3+urD13wu6wt2trvQe1n4qawxHahz7Uvdwpg6PcmfYVmrl
         1KKeoqXjjwGaesL1STknpgKCDCvCrXFjEMFcLyaNC0BzW7knYtaUi4brjQGmEHW5HYm3
         cjq35d9TSqcJTm6eHGurWPPfennrR+PmaxgUhY68+3DSRaapFocvs6Oe/xJulqa6vJvM
         qZw/4fHEAPvms0tF7qs9G+706/xlzAbcwjMptaQrMuqJXAWWnyK2oiAd8FBz/+iDyiX6
         BwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709835740; x=1710440540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYhTYHOXWFkjcmXmPD3zJwyk7pg1G0PQhE3XitSL9PI=;
        b=OdW0Xh46znR06HEvQZqjUauqcAMvyEWpd36wgV87uROVuF64amHkTojoLWgfLJpe07
         1Bszf17YoBHVGDGaOQ7jDFmG3IT4HShCjEN340WXEwk4larHJZsOAICzJcEADU3uBsmh
         diNmKX3EAK5MC+I7G7kTSZuFPl0Cb/1T0DorveL4Fm/FD+NFoRaj+7X61Qjdxzleu5Ua
         8cmOf+ROB8v7PeSQA/0NUlW47oFsQyy1Ow6ELR/krzjywbUmwveyzOWxd7Ldrl9DxWwD
         FP0RnYJ2EJ243Xjq2MhrO8rTCFzDb5BIw8gSqjaYGiThaEA6auRMs1csh5/nOVpC9LyU
         4fsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBZhRnLKKqgf6GSRzKwIQYAxriYS7SJWuA1ZKxJCh1LZ0/wI8xD7+WQ9N+q6BoLeQx1aKbsh3oxYOKsrQ8dLksmotAAOL12ADv5mx593HW
X-Gm-Message-State: AOJu0Yy8PlX1BbyjxAIP4ipOpDkgNSdX6bQLErdDgZ0TPwCLZ6GhGl6C
	+ysJ6ssD+U/HDCEHoC4VmyK2g6yHOPVfOoRBNURcYaeTqVoTDro14749P8xLBhC0NNsVvLHU3ir
	tmQ==
X-Google-Smtp-Source: AGHT+IFOk/vATsBgFrLrqHusHv7BoqhVAzQX4Yy8Wy1PMD2ERk7ncQYT/cH5zg79Q6A+cEqrjhsEiXK8Szc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:9c5:0:b0:dcc:2267:796e with SMTP id
 y5-20020a5b09c5000000b00dcc2267796emr46265ybq.2.1709835740049; Thu, 07 Mar
 2024 10:22:20 -0800 (PST)
Date: Thu, 7 Mar 2024 10:22:18 -0800
In-Reply-To: <20240307054623.13632-6-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307054623.13632-1-manali.shukla@amd.com> <20240307054623.13632-6-manali.shukla@amd.com>
Message-ID: <ZeoF2vfrUMCja0x7@google.com>
Subject: Re: [PATCH v1 5/5] selftests: KVM: SVM: Add Idle HLT intercept test
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024, Manali Shukla wrote:
> From: Manali Shukla <Manali.Shukla@amd.com>
> 
> The Execution of the HLT instruction results in a VMEXIT. Hypervisor
> observes pending V_INTR and V_NMI events just after the VMEXIT
> generated by the HLT for the vCPU and causes VM entry to service the
> pending events.  The Idle HLT intercept feature avoids the wasteful
> VMEXIT during the halt if there are pending V_INTR and V_NMI events
> for the vCPU.
> 
> The selftest for the Idle HLT intercept instruments the above-mentioned
> scenario.
> 
> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/x86_64/svm_idlehlt_test.c   | 118 ++++++++++++++++++
>  2 files changed, 119 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idlehlt_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 492e937fab00..7ad03dc4f35e 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -89,6 +89,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
>  TEST_GEN_PROGS_x86_64 += x86_64/smm_test
>  TEST_GEN_PROGS_x86_64 += x86_64/state_test
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
> +TEST_GEN_PROGS_x86_64 += x86_64/svm_idlehlt_test

Uber nit, maybe svm_idle_hlt_test?  I find "idlehlt" hard to parse.

>  TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>  TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
>  TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_shutdown_test
> diff --git a/tools/testing/selftests/kvm/x86_64/svm_idlehlt_test.c b/tools/testing/selftests/kvm/x86_64/svm_idlehlt_test.c
> new file mode 100644
> index 000000000000..1564511799d4
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/svm_idlehlt_test.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  svm_idlehalt_test
> + *

Please omit this, file comments that state the name of the test inevitably
become stale (see above).

> + *  Copyright (C) 2024 Advanced Micro Devices, Inc.
> + *
> + *  For licencing details see kernel-base/COPYING

This seems gratuitous, doesn't the SPDX stuff take care this?

> + *
> + *  Author:
> + *  Manali Shukla  <manali.shukla@amd.com>
> + */
> +#include "kvm_util.h"
> +#include "svm_util.h"
> +#include "processor.h"
> +#include "test_util.h"
> +#include "apic.h"
> +
> +#define VINTR_VECTOR     0x30
> +#define NUM_ITERATIONS 100000

What's the runtime?  If it's less than a second, then whatever, but if it's at
all longer than that, then I'd prefer to use a lower default and make this user-
configurable.

> +/*
> + * Incremented in the VINTR handler. Provides evidence to the sender that the
> + * VINR is arrived at the destination.

Evidence is useless if there's no detective looking for it.  Yeah, it gets
printed out in the end, but in reality, no one is going to look at that.

Rather than read this from the host, just make it a non-volatile bool and assert
that it set after every 

> + */
> +static volatile uint64_t vintr_rcvd;
> +
> +void verify_apic_base_addr(void)
> +{
> +	uint64_t msr = rdmsr(MSR_IA32_APICBASE);
> +	uint64_t base = GET_APIC_BASE(msr);
> +
> +	GUEST_ASSERT(base == APIC_DEFAULT_GPA);
> +}
> +
> +/*
> + * The halting guest code instruments the scenario where there is a V_INTR pending
> + * event available while hlt instruction is executed. The HLT VM Exit doesn't
> + * occur in above-mentioned scenario if the Idle HLT intercept feature is enabled.
> + */
> +
> +static void halter_guest_code(void)

Just "guest_code()".  Yeah, it's a weird generic name, but at this point it's so
ubiquitous that it's analogous to main(), i.e. readers know that guest_code() is
the entry point.  And deviating from that suggests that there is a second vCPU
running _other_ guest code (otherwise, why differentiate?), which isn't the case.

> +{
> +	uint32_t icr_val;
> +	int i;
> +
> +	verify_apic_base_addr();

Why?  The test will fail if the APIC is borked, this is just unnecessary noise
that distracts readers.


> +	xapic_enable();
> +
> +	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | VINTR_VECTOR);
> +
> +	for (i = 0; i < NUM_ITERATIONS; i++) {
> +		xapic_write_reg(APIC_ICR, icr_val);
> +		asm volatile("sti; hlt; cli");

Please add safe_halt() and cli() helpers in processor.h.  And then do:

		cli();
		xapic_write_reg(APIC_ICR, icr_val);
		safe_halt();

to guarantee that interrupts are disabled when the IPI is sent.  And as above,

		GUEST_ASSERT(READ_ONCE(irq_received));
		WRITE_ONCE(irq_received, false);

> +	}
> +	GUEST_DONE();
> +}
> +
> +static void guest_vintr_handler(struct ex_regs *regs)
> +{
> +	vintr_rcvd++;
> +	xapic_write_reg(APIC_EOI, 0x30);

EOI is typically written with '0', not the vector, because the legacy EOI register
clears the highest ISR vector, not whatever is specified.  IIRC, one of the Intel
or AMD specs even says to use '0'.

AMD's Specific EOI register does allow targeting a specific vector, but that's
not what's being used here.

> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +	struct ucall uc;
> +	uint64_t  halt_exits, vintr_exits;
> +	uint64_t *pvintr_rcvd;
> +
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));

No, this test doesn't require SVM, which is KVM advertising *nested* SVM.  This
test does require idle-hlt support though...

> +	/* Check the extension for binary stats */
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_BINARY_STATS_FD));
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, halter_guest_code);
> +
> +	vm_init_descriptor_tables(vm);
> +	vcpu_init_descriptor_tables(vcpu);
> +	vm_install_exception_handler(vm, VINTR_VECTOR, guest_vintr_handler);
> +	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
> +
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> +	halt_exits = vcpu_get_stat(vcpu, "halt_exits");

Is there really no way to get binary stats without having to pass in strings?

> +	vintr_exits = vcpu_get_stat(vcpu, "irq_window_exits");
> +	pvintr_rcvd = (uint64_t *)addr_gva2hva(vm, (uint64_t)&vintr_rcvd);
> +
> +	switch (get_ucall(vcpu, &uc)) {
> +	case UCALL_ABORT:
> +		REPORT_GUEST_ASSERT(uc);
> +		/* NOT REACHED */

Eh, just put a "break;" here and drop the comment.

> +	case UCALL_DONE:
> +		goto done;

break;

> +	default:
> +		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
> +	}
> +
> +done:
> +	TEST_ASSERT(halt_exits == 0,

So in all honesty, this isn't a very interesting test.  It's more of a CPU test
than a KVM test.  I do think it's worth adding, because why not.

But I'd also like to see a testcase for KVM_X86_DISABLE_EXITS_HLT.  It would be
a generic test, i.e. not specific to idle-hlt since there is no dependency and
the test shouldn't care.  I _think_ it would be fairly straightforward: create
a VM without an in-kernel APIC (so that HLT exits to userspace), disable HLT
interception, send a signal from a different task after some delay, and execute
HLT in the guest.  Then verify the vCPU exited because of -EINTR and not HLT.

> +		    "Test Failed:\n"
> +		    "Guest executed VINTR followed by halts: %d times\n"
> +		    "The guest exited due to halt: %ld times and number\n"
> +		    "of vintr exits: %ld and vintr got re-injected: %ld times\n",
> +		    NUM_ITERATIONS, halt_exits, vintr_exits, *pvintr_rcvd);

I appreciate the effort to provide more info, but this is way too noisy.  If
anything, print gory details in a pr_debug() *before* the assert (see below),
and then simply do:

	TEST_ASSERT_EQ(halt_exits, 0);

> +	fprintf(stderr,
> +		"Test Successful:\n"
> +		"Guest executed VINTR followed by halts: %d times\n"
> +		"The guest exited due to halt: %ld times and number\n"
> +		"of vintr exits: %ld and vintr got re-injected: %ld times\n",
> +		NUM_ITERATIONS, halt_exits, vintr_exits, *pvintr_rcvd);

And this should be pr_debug(), because no human is going to look at this except
when the test isn't working correctly.

> +
> +	kvm_vm_free(vm);
> +	return 0;
> +}
> -- 
> 2.34.1
> /pvintr_rcvd


