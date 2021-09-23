Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1140541607E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Sep 2021 16:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbhIWOHS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Sep 2021 10:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241501AbhIWOHR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Sep 2021 10:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632405946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cX47g2TKWyTcGZ3lLgtM2l5RhRkt4502e9pXcwjNvzg=;
        b=ICRruicQCHG7K6C+Dta46uH9yB8PmQyJVgBa34K2pyIQ8QEvdHcDx3uzHy0GbdnJmgUkwG
        4BjqjdplQ45Exf8zunxvc52iPqVHy7L7VmiIs8ng1GyicftGT07iCZew2FTbR6vOHB+pgd
        6LYibdGNt+UH7RscZwtinEgIV09BXFQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-yIm5IfwsPBGNACHoOtbIgw-1; Thu, 23 Sep 2021 10:05:44 -0400
X-MC-Unique: yIm5IfwsPBGNACHoOtbIgw-1
Received: by mail-wr1-f69.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso5247417wra.3
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Sep 2021 07:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cX47g2TKWyTcGZ3lLgtM2l5RhRkt4502e9pXcwjNvzg=;
        b=LXLoyk5YI+3/yqVmyE+NjBrdxI5opuMtpPp3iklAa+sbcamp3A32TkUqn3Zv1fOxpa
         QglTBrgou9a/U2dHSOEagHp+UR53Xahd0T8pcinxrd6czlqylJZnkb5rAsSG5J5gv5Jp
         bUfLk3FZMdUYVAPyQYJ9RxGY9AcgQRnn/LAcshaVRSgyaOYaUOR0e/6TihQjmW46LXNc
         hvqP81aUO8W4QW2zhjtnZIXinUmztZ8vThxwGXqXqazytFQ02uG+2wk9Hzl0zpnz3J6c
         k9GO3t6hZsJPWeSdYTt+RBFLmLVk7qJj33Qtc89Kz6Wl1XktX8zlThWoNEZsbGXKr7GJ
         PL1g==
X-Gm-Message-State: AOAM5319B8xXtJ4smO8BsyGBS4EpkgNHDDQElRvq15tC8/E/GoVCDwjX
        XD3zHGIe69ZEeebBvHuD+oQGuP+1BCfgRKXzutkoX1jl/Oivo6YgUDljmfaKojnSYsI3illJ8w9
        BFIjvI3OJcCGSpcUKkv1mULt0pE08
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr4627412wmb.112.1632405943376;
        Thu, 23 Sep 2021 07:05:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiAa96ENorZQvlWHjdYI1iE16TzOB++hfYYtVRSw05S7pz1fhbwi0pzRTTTE6avMtpDpwtVg==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr4627392wmb.112.1632405943132;
        Thu, 23 Sep 2021 07:05:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c7sm5745201wmq.13.2021.09.23.07.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 07:05:42 -0700 (PDT)
Subject: Re: [PATCH 02/14] KVM: x86: selftests: test simultaneous uses of
 V_IRQ from L1 and L0
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Bandan Das <bsd@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Wei Huang <wei.huang2@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
 <20210914154825.104886-3-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee791308-bc84-7765-1949-e7422de2ddb0@redhat.com>
Date:   Thu, 23 Sep 2021 16:05:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914154825.104886-3-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14/09/21 17:48, Maxim Levitsky wrote:
> Test that if:
> 
> * L1 disables virtual interrupt masking, and INTR intercept.
> 
> * L1 setups a virtual interrupt to be injected to L2 and enters L2 with
>    interrupts disabled, thus the virtual interrupt is pending.
> 
> * Now an external interrupt arrives in L1 and since
>    L1 doesn't intercept it, it should be delivered to L2 when
>    it enables interrupts.
> 
>    to do this L0 (abuses) V_IRQ to setup an
>    interrupt window, and returns to L2.
> 
> * L2 enables interrupts.
>    This should trigger the interrupt window,
>    injection of the external interrupt and delivery
>    of the virtual interrupt that can now be done.
> 
> * Test that now L2 gets those interrupts.
> 
> This is the test that demonstrates the issue that was
> fixed in the previous patch.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../selftests/kvm/x86_64/svm_int_ctl_test.c   | 128 ++++++++++++++++++
>   3 files changed, 130 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 36896d251977..eb98958b15e4 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -23,6 +23,7 @@
>   /x86_64/smm_test
>   /x86_64/state_test
>   /x86_64/svm_vmcall_test
> +/x86_64/svm_int_ctl_test
>   /x86_64/sync_regs_test
>   /x86_64/tsc_msrs_test
>   /x86_64/userspace_msr_exit_test
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index c103873531e0..3b8b143daecc 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -56,6 +56,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/smm_test
>   TEST_GEN_PROGS_x86_64 += x86_64/state_test
>   TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
>   TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
> +TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
>   TEST_GEN_PROGS_x86_64 += x86_64/sync_regs_test
>   TEST_GEN_PROGS_x86_64 += x86_64/userspace_msr_exit_test
>   TEST_GEN_PROGS_x86_64 += x86_64/vmx_apic_access_test
> diff --git a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
> new file mode 100644
> index 000000000000..df04f56ce859
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * svm_int_ctl_test
> + *
> + * Copyright (C) 2021, Red Hat, Inc.
> + *
> + * Nested SVM testing: test simultaneous use of V_IRQ from L1 and L0.
> + */
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "svm_util.h"
> +#include "apic.h"
> +
> +#define VCPU_ID		0
> +
> +static struct kvm_vm *vm;
> +
> +bool vintr_irq_called;
> +bool intr_irq_called;
> +
> +#define VINTR_IRQ_NUMBER 0x20
> +#define INTR_IRQ_NUMBER 0x30
> +
> +static void vintr_irq_handler(struct ex_regs *regs)
> +{
> +	vintr_irq_called = true;
> +}
> +
> +static void intr_irq_handler(struct ex_regs *regs)
> +{
> +	x2apic_write_reg(APIC_EOI, 0x00);
> +	intr_irq_called = true;
> +}
> +
> +static void l2_guest_code(struct svm_test_data *svm)
> +{
> +	/* This code raises interrupt INTR_IRQ_NUMBER in the L1's LAPIC,
> +	 * and since L1 didn't enable virtual interrupt masking,
> +	 * L2 should receive it and not L1.
> +	 *
> +	 * L2 also has virtual interrupt 'VINTR_IRQ_NUMBER' pending in V_IRQ
> +	 * so it should also receive it after the following 'sti'.
> +	 */
> +	x2apic_write_reg(APIC_ICR,
> +		APIC_DEST_SELF | APIC_INT_ASSERT | INTR_IRQ_NUMBER);
> +
> +	__asm__ __volatile__(
> +		"sti\n"
> +		"nop\n"
> +	);
> +
> +	GUEST_ASSERT(vintr_irq_called);
> +	GUEST_ASSERT(intr_irq_called);
> +
> +	__asm__ __volatile__(
> +		"vmcall\n"
> +	);
> +}
> +
> +static void l1_guest_code(struct svm_test_data *svm)
> +{
> +	#define L2_GUEST_STACK_SIZE 64
> +	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> +	struct vmcb *vmcb = svm->vmcb;
> +
> +	x2apic_enable();
> +
> +	/* Prepare for L2 execution. */
> +	generic_svm_setup(svm, l2_guest_code,
> +			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
> +
> +	/* No virtual interrupt masking */
> +	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
> +
> +	/* No intercepts for real and virtual interrupts */
> +	vmcb->control.intercept &= ~(1ULL << INTERCEPT_INTR | INTERCEPT_VINTR);
> +
> +	/* Make a virtual interrupt VINTR_IRQ_NUMBER pending */
> +	vmcb->control.int_ctl |= V_IRQ_MASK | (0x1 << V_INTR_PRIO_SHIFT);
> +	vmcb->control.int_vector = VINTR_IRQ_NUMBER;
> +
> +	run_guest(vmcb, svm->vmcb_gpa);
> +	GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_VMMCALL);
> +	GUEST_DONE();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	vm_vaddr_t svm_gva;
> +
> +	nested_svm_check_supported();
> +
> +	vm = vm_create_default(VCPU_ID, 0, (void *) l1_guest_code);
> +
> +	vm_init_descriptor_tables(vm);
> +	vcpu_init_descriptor_tables(vm, VCPU_ID);
> +
> +	vm_install_exception_handler(vm, VINTR_IRQ_NUMBER, vintr_irq_handler);
> +	vm_install_exception_handler(vm, INTR_IRQ_NUMBER, intr_irq_handler);
> +
> +	vcpu_alloc_svm(vm, &svm_gva);
> +	vcpu_args_set(vm, VCPU_ID, 1, svm_gva);
> +
> +	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
> +	struct ucall uc;
> +
> +	vcpu_run(vm, VCPU_ID);
> +	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
> +		    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
> +		    run->exit_reason,
> +		    exit_reason_str(run->exit_reason));
> +
> +	switch (get_ucall(vm, VCPU_ID, &uc)) {
> +	case UCALL_ABORT:
> +		TEST_FAIL("%s", (const char *)uc.args[0]);
> +		break;
> +		/* NOT REACHED */
> +	case UCALL_DONE:
> +		goto done;
> +	default:
> +		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
> +	}
> +done:
> +	kvm_vm_free(vm);
> +	return 0;
> +}
> 

Queued, thanks.

Paolo

