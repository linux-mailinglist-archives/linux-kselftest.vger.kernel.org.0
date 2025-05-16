Return-Path: <linux-kselftest+bounces-33224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2A0ABA3C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3EA168271
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7559226D00;
	Fri, 16 May 2025 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VelvmmjH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46854225787
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423709; cv=none; b=HgbCfwZqusDltCcVPyFRaX0AKB6L8aNlpiB+LtirhFNS0BrP5iSITMdba5JPO+FzkbdOEosaSnDOgkO9cLJTvlXtgSeuOOBh5a7LVUz0KhO5NsCbHCi+DOf/hOY364FzGfLzUE20tHfnASsE2nuGTCfN9aa9oyR13067To1hTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423709; c=relaxed/simple;
	bh=TJ3c9l4pdDm97mcloPavrFSmJivYWHpes/mnfR0ofnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nhvZVyjsQ3MT/lPgqzR1IW4K5TfACK9LCXmISZCcj4nNPoQEJu8Ymk6/NeKionWO/ZOYll+XZet04QoRvpk44rO96fAOW6/2K0DmMN/5CcNDTfY0gesCDYlveBclvRJ2sOIpTXUzb0mi4t3zE/nKBAJajvkP2hGKFz5abe0kvl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VelvmmjH; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74299055c3dso3170455b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747423707; x=1748028507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4SuDgnPpkaah3slF5YunYH8RTWaJ6H4jJOeD+ScylJY=;
        b=VelvmmjHy01Y0SepF+9uG2jqfqO2EiRq6QuqGkvQp3NMpetwbkoc0eRhntgZdP+yVz
         oAAgVfyCGyfm49fjQWs0N1nGsEI1qYeAxa7CDa0dn9yAeiCs9VUyHVHFDVweqildWXKa
         G8y8oU5awbp3LF1FfHpzLPkWWcEZCAyPgweP4mKSdOYZVuKwChh1NRZE6QNfpW2s4LCQ
         hOUvfuAHoxHaLX2HODNag1mEdBLB8PMH/ckTnXOPidtlyrQhdHbGity1d50fa5bUH4vW
         ey6zVk8bgbkHBJzIJna/or4nv07hyvwrWj9XD9tefSb6VGntNdJerEHKCJ+POjb4e7mx
         wCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423707; x=1748028507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SuDgnPpkaah3slF5YunYH8RTWaJ6H4jJOeD+ScylJY=;
        b=m7ALAV2x7KCUTaUARpZZ+IaG3LYD3hEvc0gnd0RQVuRqFodwHw8gnP34XZuRGGTfCc
         uKHWp2tVrvEupNcNfqC2ND1xV4/k45R3PmpJnwnnaqtXi97UHwSV5OBSIgR0J+JZDRpv
         A+hBFGxxtbooA3sWJqkgOH2dWPvVX6Kq2nH2vTg8bwsYeeJS6SHbTtJLgoj1vN6R+joc
         A5M1igwyD0sTj4Yod4UV4GBdafpIORTo+P/+whdxjm3iYW9VbRZJiMlXZeqsB+fWLw9h
         3kjtLEEcWl9Vnv9Ce7zqgIKVQUgjX3A2Ggfu//Nc9VVs6YA1fybpN731N7QAkSe+XDl0
         /DHw==
X-Forwarded-Encrypted: i=1; AJvYcCU0N0o3EiNVr+LxoMXr1ICv3kmOQ4Kibf529HpRSmwETRsAB8HkOo/3QOGZO116oXkZfHPEHaNrXX0yovn4goY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/gVFRYBMG87KPTCFZ0Shh+tFNLWJrKJpxmEcyqPQDWUUES0lQ
	5nM5OeNqKQUbksze7jnGWozGlwRyrDtL2ZXEBk57jxnV9Q9BBULLi1NxUMWA2Lwv2m4lKm0KtLs
	5T0wdeA==
X-Google-Smtp-Source: AGHT+IHXzW2hkrzTBIe3eiFxBkJs41fk/sX0hV5YrOzJFA+YwLSyxJbf5aJqKWTCqRwGNGNz0qnN8aD/Wps=
X-Received: from pfbei22.prod.google.com ([2002:a05:6a00:80d6:b0:736:415f:3d45])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a06:b0:72d:9cbc:730d
 with SMTP id d2e1a72fcca58-742a97d4650mr5732591b3a.11.1747423707415; Fri, 16
 May 2025 12:28:27 -0700 (PDT)
Date: Fri, 16 May 2025 12:28:25 -0700
In-Reply-To: <20250502050346.14274-6-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250502050346.14274-1-manali.shukla@amd.com> <20250502050346.14274-6-manali.shukla@amd.com>
Message-ID: <aCeR2TjPzC_OYBfG@google.com>
Subject: Re: [PATCH v5 5/5] KVM: selftests: Add bus lock exit test
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	nikunj@amd.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"

On Fri, May 02, 2025, Manali Shukla wrote:
> diff --git a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
> new file mode 100644
> index 000000000000..9c081525ac2a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Advanced Micro Devices, Inc.
> + */
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "svm_util.h"
> +#include "vmx.h"
> +
> +#define NR_ITERATIONS 100
> +#define L2_GUEST_STACK_SIZE 64
> +
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Waddress-of-packed-member"

Eww.

> +
> +struct buslock_test {
> +	unsigned char pad[PAGE_SIZE - 2];
> +	atomic_long_t val;
> +} __packed;

You don't need an entire page to generate a bus lock, two cache lines will do
nicely.  And there's certain no need for __packed.

> +struct buslock_test test __aligned(PAGE_SIZE);
> +
> +static __always_inline void buslock_atomic_add(int i, atomic_long_t *v)
> +{
> +	asm volatile(LOCK_PREFIX "addl %1,%0"
> +		     : "+m" (v->counter)
> +		     : "ir" (i) : "memory");
> +}

If only there were utilities for atomics...

> +static void buslock_add(void)

guest_generate_buslocks()

> +{
> +	/*
> +	 * Increment a page unaligned variable atomically.
> +	 * This should generate a bus lock exit.

Not should, will.

> +	 */
> +	for (int i = 0; i < NR_ITERATIONS; i++)
> +		buslock_atomic_add(2, &test.val);

Don't do weird and completely arbitrary things like adding '2' instead of '1',
it makes readers look for intent and purpose that doesn't exist.

> +}

...

> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_run *run;
> +	struct kvm_vm *vm;
> +	vm_vaddr_t nested_test_data_gva;
> +
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));

There's no reason to make nested support a hard dependency, it's just as easy to
make it conditional.

> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_BUS_LOCK_EXIT));
> +
> +	vm = vm_create(1);
> +	vm_enable_cap(vm, KVM_CAP_X86_BUS_LOCK_EXIT, KVM_BUS_LOCK_DETECTION_EXIT);
> +	vcpu = vm_vcpu_add(vm, 0, guest_code);
> +
> +	if (kvm_cpu_has(X86_FEATURE_SVM))
> +		vcpu_alloc_svm(vm, &nested_test_data_gva);
> +	else
> +		vcpu_alloc_vmx(vm, &nested_test_data_gva);
> +
> +	vcpu_args_set(vcpu, 1, nested_test_data_gva);
> +
> +	run = vcpu->run;
> +
> +	for (;;) {
> +		struct ucall uc;
> +
> +		vcpu_run(vcpu);
> +
> +		if (run->exit_reason == KVM_EXIT_IO) {
> +			switch (get_ucall(vcpu, &uc)) {
> +			case UCALL_ABORT:
> +				REPORT_GUEST_ASSERT(uc);
> +				/* NOT REACHED */
> +			case UCALL_SYNC:
> +				continue;
> +			case UCALL_DONE:
> +				goto done;
> +			default:
> +				TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
> +			}
> +		}
> +
> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_X86_BUS_LOCK);
> +	}

*sigh*

This doesn't actually ****VERIFY**** that the expected number of bus lock exits
were generated.  KVM could literally do nothing and the test will pass.  E.g. the
test passes if I do this:

diff --git a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
index 9c081525ac2a..aa65d6be0f13 100644
--- a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
+++ b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
@@ -93,10 +93,10 @@ int main(int argc, char *argv[])
        vm_vaddr_t nested_test_data_gva;
 
        TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
-       TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_BUS_LOCK_EXIT));
+//     TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_BUS_LOCK_EXIT));
 
        vm = vm_create(1);
-       vm_enable_cap(vm, KVM_CAP_X86_BUS_LOCK_EXIT, KVM_BUS_LOCK_DETECTION_EXIT);
+//     vm_enable_cap(vm, KVM_CAP_X86_BUS_LOCK_EXIT, KVM_BUS_LOCK_DETECTION_EXIT);
        vcpu = vm_vcpu_add(vm, 0, guest_code);
 
        if (kvm_cpu_has(X86_FEATURE_SVM))
--

The test would also fail to detect if KVM completely skipped the instruction.

This is not rocket science.  If you can't make your test fail by introducing bugs
in what you're testing, then your test is worthless.

No need for a v6, I'm going to do surgery when I apply, this series has dragged
on for far too long.

