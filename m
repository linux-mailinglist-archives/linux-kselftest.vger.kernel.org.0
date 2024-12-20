Return-Path: <linux-kselftest+bounces-23638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639239F8962
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 02:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4D81655B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 01:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0BFC148;
	Fri, 20 Dec 2024 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfp6YqhT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F13259488
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734657848; cv=none; b=c5SQhzm+uVZdxck0HQd+NzKNgXCz9auuFIJF+RgP+5wIFY/2TbM7vll1y1+0Gn0YuPb8CzVAWDVABitLVv44JQrodPNmp/iaeTYSb4Orpnx9g3OlvM5HQ34Jebevj5pT57KeiwQa2snXjlB+qTNof2C1ImEVf/wfjjtbtp/AOgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734657848; c=relaxed/simple;
	bh=8GnVLy3WxH8MHh61XU+uwkJIUpoe1l+BMa19fC/TvVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PuCsqqA42mpkcB16GJJSXyLVxKzNb1ZkBHM4xEkppy156m/9f6Zk8oJrRRXzNfKGZ7VgX8Er4q9jHt6Lp7ETwNu1CNBQBpHULVBa8uavfVmQz0vHbOOry/I5mzuhPhvMzyx5ICPkIGpipDw5o2xhvaxllAvQxT8pFKOx5xHvNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfp6YqhT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-728e4bdd69eso2034978b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 17:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734657846; x=1735262646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tk4j8JTVHQOiMaCDiVYlXhwVvvaes6nEmniuo7V7flw=;
        b=lfp6YqhT4WcaepQPmFRLvh4JdNRMGLPKYdMMfRYqRmfLLDrZFUNQQxqWE1t8GsvC96
         NYT4+2meiijB4WE56dyUVbx63BwFK7l+WHW5YvbEP6XUY938ZAorSYqgPXBjhBB+D2ft
         hKdGQlgN9Xes27xH7IMBYAPiB/XDyw50L8fFOSj5uAUfJ1IyP+BIHY53iAVYbWgGnno9
         1HL/1OqP1g4R/in+Ud9QKf+Mq7gE3nnVLadT+4k88TruaOFKyydGXgN7DTjPcWHhAd1L
         3ksjaoAjFu2nLvqIy167mKBnwptRzT6AvHdi39Mr6Ma1jA5/8D5BCr34g0GjZ+shf1zN
         qkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734657846; x=1735262646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tk4j8JTVHQOiMaCDiVYlXhwVvvaes6nEmniuo7V7flw=;
        b=AD7p2i42XqcZKqGa2mFaKKkjNybc4NdDp3iGscu7xP7ZTnqvgR1L+yRRubUHWV9/DN
         /EDH1j48gQGtYrOSIWytsYnu36AdJlOaSf2wV4C9BZmoHe1RRuHkbqmpuQqXZ43aacW2
         z9Ic2q9eDxPYM37hiFC8CZobHUHdGDv+RkyCnf2gCeAG3KHL+DTUFENKDnNURnzIo+az
         40i2LBsc6ya4oOnDgLJo5xWo/RP+363WxBl5X9L+MprffQIRoQLPTUPanqQZ1BDD1U8+
         6z/uXj76UnZcmeD+EdDL8m0HZ4+/maEyFSc7rj5nqccsp4ou/EhKs11j3bMoA9RBnh7r
         aEOA==
X-Forwarded-Encrypted: i=1; AJvYcCVBpc+gO/Zj+yxfzw5KDqjFNXJZXABVM5sETgDqVqKSteutjRR28F7DrquuJV4x+oJoLs5bv1fE18Inj8mUnh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHixZDhVR4IzOEvGH6IM/oiiB76KsTTGXWzf/Mkno/MdzP7PK9
	xYL5rii4PwNX4fuLG3Y4r/87f4DbZb/yDmOy4VtMPfzue7nAJq8QPok2UdUhNZOxDDiXBcT5cPs
	5pw==
X-Google-Smtp-Source: AGHT+IE11Aj7IoplDRwG4H2peO9aIht5R4MJfLCRSrr7R5tCASKDGbadiWctiBzePtGnjsIZaySDeUGW2pc=
X-Received: from pfba9.prod.google.com ([2002:a05:6a00:ac09:b0:728:aad0:33a4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3382:b0:1e1:9e9f:ae4
 with SMTP id adf61e73a8af0-1e5e1e87c5bmr1223977637.13.1734657846090; Thu, 19
 Dec 2024 17:24:06 -0800 (PST)
Date: Thu, 19 Dec 2024 17:24:04 -0800
In-Reply-To: <20241022054810.23369-5-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022054810.23369-1-manali.shukla@amd.com> <20241022054810.23369-5-manali.shukla@amd.com>
Message-ID: <Z2THNLATHFyEw01j@google.com>
Subject: Re: [PATCH v4 4/4] KVM: selftests: KVM: SVM: Add Idle HLT intercept test
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 22, 2024, Manali Shukla wrote:
> diff --git a/tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c b/tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c
> new file mode 100644
> index 000000000000..fe2ea96695e4
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Copyright (C) 2024 Advanced Micro Devices, Inc.
> + *
> + */
> +#include <kvm_util.h>
> +#include <processor.h>
> +#include <test_util.h>
> +#include "svm_util.h"
> +#include "apic.h"
> +
> +#define VINTR_VECTOR     0x30

Drop the "V".  From the guest's perspective, it's simply the interrupt vector.
The "V" suggests there's nested SVM stuff going on, e.g. to virtualize an interrupt
for L2 or something.

> +#define NUM_ITERATIONS   1000
> +
> +static bool irq_received;
> +
> +/*
> + * The guest code instruments the scenario where there is a V_INTR pending
> + * event available while hlt instruction is executed. The HLT VM Exit doesn't
> + * occur in above-mentioned scenario if Idle HLT intercept feature is enabled.
> + */

So the only thing thing that is idle-HLT specific in this test is that final
TEST_ASSERT_EQ().  Rather than make this test depend on idle-HLT, we should
tweak it run on all hardware, and then:

	if (kvm_cpu_has(X86_FEATURE_IDLE_HLT))
		TEST_ASSERT_EQ(halt_exits, 0);
	else
		TEST_ASSERT_EQ(halt_exits, NUM_ITERATIONS);

Not sure about the name.  Maybe hlt_ipi_test or ipi_hlt_test?

> +static void guest_code(void)
> +{
> +	uint32_t icr_val;
> +	int i;
> +
> +	xapic_enable();

Hmm, I think we should have this test force x2APIC mode.  KVM emulates x2APIC
in software (if it's not accerlated by APICv), i.e. it's always available.  That
will allow using this test to do performance testing of KVM's fastpath handling
of handle_fastpath_set_x2apic_icr_irqoff().

Of course, KVM only uses the fastpath for non-shorthand IPIs, and any setup that
can do self-IPI fully in the fastpath (via virtual interrupt delivery) won't exit
in the first place (virtualized by hardware), i.e. there's probably no point in
adding self-IPIs to the fastpath.

But maybe in the future I can convince someone to enhance this test to do
cross-vCPU IPI testing.

> +
> +	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | VINTR_VECTOR);
> +
> +	for (i = 0; i < NUM_ITERATIONS; i++) {
> +		cli();
> +		xapic_write_reg(APIC_ICR, icr_val);
> +		safe_halt();
> +		GUEST_ASSERT(READ_ONCE(irq_received));
> +		WRITE_ONCE(irq_received, false);
> +	}
> +	GUEST_DONE();
> +}
> +
> +static void guest_vintr_handler(struct ex_regs *regs)
> +{
> +	WRITE_ONCE(irq_received, true);
> +	xapic_write_reg(APIC_EOI, 0x00);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +	struct ucall uc;
> +	uint64_t  halt_exits, vintr_exits;
> +
> +	/* Check the extension for binary stats */

Pointless comment, the code below is self-explanatory.

> +	TEST_REQUIRE(this_cpu_has(X86_FEATURE_IDLE_HLT));

This needs to check *KVM* support.  I.e. kvm_cpu_has().

> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_BINARY_STATS_FD));
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +
> +	vm_install_exception_handler(vm, VINTR_VECTOR, guest_vintr_handler);
> +	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
> +
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> +	halt_exits = vcpu_get_stat(vcpu, halt_exits);
> +	vintr_exits = vcpu_get_stat(vcpu, irq_window_exits);
> +
> +	switch (get_ucall(vcpu, &uc)) {
> +	case UCALL_ABORT:
> +		REPORT_GUEST_ASSERT(uc);
> +		/* NOT REACHED */
> +	case UCALL_DONE:
> +		break;
> +
> +	default:
> +		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
> +	}
> +
> +	TEST_ASSERT_EQ(halt_exits, 0);
> +	pr_debug("Guest executed VINTR followed by halts: %d times.\n"
> +		 "The guest exited due to halt: %ld times and number\n"
> +		 "of vintr exits: %ld.\n",
> +		 NUM_ITERATIONS, halt_exits, vintr_exits);

halt_exits obviously is '0' at this point, so I don't see any point in printing
it out.

As for vintr_exits, I vote to drop it, for now at least.  At some point in the
future, I would like to expand this test so that it can be used for a rudimentary
IPI+HLT perf test.  But for now, I think it makes sense to keep it simple, e.g.
so that nothing needs to be unwound if improvements are made in the future.

> +
> +	kvm_vm_free(vm);
> +	return 0;
> +}
> -- 
> 2.34.1
> 

