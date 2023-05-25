Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E927112BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 19:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjEYRpP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 13:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEYRpN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 13:45:13 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BA8E41
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 10:44:50 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64d67a12befso1869b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685036688; x=1687628688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVNh1yXMsN281mBb6w94lafEabd4mOK2QKbd1sHJfl4=;
        b=p8KaIrh+UCQFnZTnDN+Bas1firuchJYBCJUKlm2YmY2WPWEOnHA7kkHWpdfWo9J3WV
         mwiztowBqT0cSlilPC33NqfY0ZCckU5L0YkdEvgdZXR8SjwJTpMOmkdbTi2VCxMm4eCH
         e+VZjyKG897JBCoLMbgkqBAkid9ArdUi3tPP7QFy+3CUXzo2rBRKpCN6ThOsusRRDZ5E
         xT+QfGfKXM5Ho90YEvOMijXo0f/y16f0yqq0rG8Ze7i7YB7ytkRFrNTeXU7uAqo6xFu/
         6xK5pYQP8+GXeQU0tgus26TcYSGQH9qwo9EHpqApZuvkYfbPdeYgBjwgHnZhQS9P/tUO
         aG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685036688; x=1687628688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVNh1yXMsN281mBb6w94lafEabd4mOK2QKbd1sHJfl4=;
        b=E/LYW3cCgBaM8XpMDEc4oc/yG10764hdtH30vRZOyTSzG6gTG2vXms/VnB6aQc/U2w
         p85cquj9jrHUkVbjuHB0tELujIzBqaQRiunO2+ak4NVl9+5adGROSHdM1araaOjEoMXD
         yhVby8yFTPUBnpL1BOP0mVmTtYqGpY7nvOhr96BYXR9eYTca8mUfJRJT81fzcXFkl29R
         UpuWuea3KQEaBVA2I4b+roa96AL9UDnqljCPjrQ/etYHwi0AGqR0nVgRy031NuiImA2b
         bmJ88oCvoDWlzxSOYlCGE8FHsJutlNOgRSv2IOqodBiCQuIQQLufhb/GhtCtPLrcUgEl
         SiOQ==
X-Gm-Message-State: AC+VfDwPCv5ZgelMam6RzMbcAST5FauljpnrymfxNqVU2QSxe1JYnz4a
        7Arb9fJBCi4xk+y5XiZktWx75sQQTrQ=
X-Google-Smtp-Source: ACHHUZ4NpqhQsPDd+bl5joFUpRNxaYtbOQR64xjJXyjuoYTY7LHaX5XxBb2CPdsBHKICixQobX0dAiQa5fo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d27:b0:643:92c0:5dd6 with SMTP id
 fa39-20020a056a002d2700b0064392c05dd6mr2755477pfb.6.1685036688266; Thu, 25
 May 2023 10:44:48 -0700 (PDT)
Date:   Thu, 25 May 2023 10:44:46 -0700
In-Reply-To: <20230420104622.12504-3-ljrcore@126.com>
Mime-Version: 1.0
References: <20230420104622.12504-1-ljrcore@126.com> <20230420104622.12504-3-ljrcore@126.com>
Message-ID: <ZG+ejm+Ta9p+2UaY@google.com>
Subject: Re: [PATCH v2 2/7] KVM: selftests: Apply create_pmu_event_filter() to
 fixed ctrs
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 20, 2023, Jinrong Liang wrote:
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> Add fixed_counter_bitmap to the create_pmu_event_filter() to
> support the use of the same creator to control the use of guest
> fixed counters.
> 
> No functional change intended.
> 
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  .../kvm/x86_64/pmu_event_filter_test.c        | 31 ++++++++++++-------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> index c0521fc9e8f6..4e87eea6986b 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> @@ -192,19 +192,22 @@ static struct kvm_pmu_event_filter *alloc_pmu_event_filter(uint32_t nevents)
>  	return f;
>  }
>  
> -
>  static struct kvm_pmu_event_filter *
>  create_pmu_event_filter(const uint64_t event_list[], uint32_t nevents,
> -			uint32_t action, uint32_t flags)
> +			uint32_t action, uint32_t flags,
> +			uint32_t fixed_counter_bitmap)

Rather than force callers to pass in every field, often with '0', what about adding
an overlay struct similar to what selftests do for MSR arrays?

Ugh, and "event_filter()" uses dynamic allocation for a statically sized array.
Even worse, it does ugly variable shadowing of "event_list".

E.g. if we define an overlay, then we can also define a "base" filter to use as
the reference.  Copying the base filter will be somewhat expensive, but probably
no more than dynamic allocation, and all but guaranteed to be meaningless in both
cases.

struct __kvm_pmu_event_filter {
	__u32 action;
	__u32 nevents;
	__u32 fixed_counter_bitmap;
	__u32 flags;
	__u32 pad[4];
	__u64 events[MAX_FILTER_EVENTS];
};

/*
 * The events in the base filter comprises Intel's eight architectural events
 * plus AMD's "retired branch instructions" for Zen[123] (and possibly other
 * AMD CPUs).
 */
static const struct __kvm_pmu_event_filter base_event_filter = {
	.nevents = ARRAY_SIZE,
	.events = {
		EVENT(0x3c, 0),
		EVENT(0xc0, 0),
		EVENT(0x3c, 1),
		EVENT(0x2e, 0x4f),
		EVENT(0x2e, 0x41),
		EVENT(0xc4, 0),
		EVENT(0xc5, 0),
		EVENT(0xa4, 1),
		AMD_ZEN_BR_RETIRED,
	},
};

>  {
>  	struct kvm_pmu_event_filter *f;
>  	int i;
>  
>  	f = alloc_pmu_event_filter(nevents);
>  	f->action = action;
> +	f->fixed_counter_bitmap = fixed_counter_bitmap;
>  	f->flags = flags;
> -	for (i = 0; i < nevents; i++)
> -		f->events[i] = event_list[i];
> +	if (f->nevents) {
> +		for (i = 0; i < f->nevents; i++)

This is an unrelated, pointless change.  The body of the loop will never execute
if f->nevents is 0.

> +			f->events[i] = event_list[i];
> +	}
>  
>  	return f;
>  }
> @@ -213,7 +216,7 @@ static struct kvm_pmu_event_filter *event_filter(uint32_t action)
>  {
>  	return create_pmu_event_filter(event_list,
>  				       ARRAY_SIZE(event_list),
> -				       action, 0);
> +				       action, 0, 0);
>  }
>  
>  /*
> @@ -260,7 +263,7 @@ static void test_amd_deny_list(struct kvm_vcpu *vcpu)
>  	struct kvm_pmu_event_filter *f;
>  	uint64_t count;
>  
> -	f = create_pmu_event_filter(&event, 1, KVM_PMU_EVENT_DENY, 0);
> +	f = create_pmu_event_filter(&event, 1, KVM_PMU_EVENT_DENY, 0, 0);
>  	count = test_with_filter(vcpu, f);
>  
>  	free(f);
> @@ -544,7 +547,7 @@ static struct perf_counter run_masked_events_test(struct kvm_vcpu *vcpu,
>  
>  	f = create_pmu_event_filter(masked_events, nmasked_events,
>  				    KVM_PMU_EVENT_ALLOW,
> -				    KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
> +				    KVM_PMU_EVENT_FLAG_MASKED_EVENTS, 0);
>  	r.raw = test_with_filter(vcpu, f);
>  	free(f);
>  
> @@ -726,12 +729,14 @@ static void test_masked_events(struct kvm_vcpu *vcpu)
>  }
>  
>  static int run_filter_test(struct kvm_vcpu *vcpu, const uint64_t *events,
> -			   uint32_t nevents, uint32_t flags)

Blech, this helper is very poorly named.  "run" strongly suggests running the vCPU.
This should really be something like set_pmu_event_filter().  And for the common
case of setting a single event, provide a wrapper for that too. 

> +			   uint32_t nevents, uint32_t flags, uint32_t action,
> +			   uint32_t fixed_counter_bitmap)

Forcing common users to pass two hardcoded params just to reuse a few lines of
code is not a good tradeoff.  With all of the above refactoring, the new test can
be done in a few lines of code without needing to update a bunch of callers.  Of
course, the rework will mean updating all callers,

	f = base_event_filter;
	f.fixed_counter_bitmap = ~GENMASK_ULL(nr_fixed_counters, 0);
	r = set_pmu_event_filter(vcpu, &f);
	TEST_ASSERT(!r, "Set invalid or non-exist fixed cunters in the fixed bitmap fail.");

Also, I've lost the context, but please add a property for the number of fixed
counters, e.g. to be able to do:

	uint32_t nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);

That won't be totally sufficient when KVM gains support for the bitmaks CPUID
leaf, but it won't become totally invalid either.

Something like this as an end result, spread over multiple patches.  Completely
untested and most definitely won't compile, but it should provide the general idea.

// SPDX-License-Identifier: GPL-2.0
/*
 * Test for x86 KVM_SET_PMU_EVENT_FILTER.
 *
 * Copyright (C) 2022, Google LLC.
 *
 * This work is licensed under the terms of the GNU GPL, version 2.
 *
 * Verifies the expected behavior of allow lists and deny lists for
 * virtual PMU events.
 */

#define _GNU_SOURCE /* for program_invocation_short_name */
#include "test_util.h"
#include "kvm_util.h"
#include "processor.h"

/*
 * In lieu of copying perf_event.h into tools...
 */
#define ARCH_PERFMON_EVENTSEL_OS			(1ULL << 17)
#define ARCH_PERFMON_EVENTSEL_ENABLE			(1ULL << 22)

/* End of stuff taken from perf_event.h. */

/* Oddly, this isn't in perf_event.h. */
#define ARCH_PERFMON_BRANCHES_RETIRED		5

#define NUM_BRANCHES 42
#define FIXED_CTR_NUM_MASK				GENMASK_ULL(4, 0)
#define PMU_EVENT_FILTER_INVALID_ACTION		(KVM_PMU_EVENT_DENY + 1)
#define PMU_EVENT_FILTER_INVALID_FLAGS			(KVM_PMU_EVENT_FLAG_MASKED_EVENTS + 1)
#define PMU_EVENT_FILTER_INVALID_NEVENTS		(MAX_FILTER_EVENTS + 1)

/*
 * This is how the event selector and unit mask are stored in an AMD
 * core performance event-select register. Intel's format is similar,
 * but the event selector is only 8 bits.
 */
#define EVENT(select, umask) ((select & 0xf00UL) << 24 | (select & 0xff) | \
			      (umask & 0xff) << 8)

/*
 * "Branch instructions retired", from the Intel SDM, volume 3,
 * "Pre-defined Architectural Performance Events."
 */

#define INTEL_BR_RETIRED EVENT(0xc4, 0)

/*
 * "Retired branch instructions", from Processor Programming Reference
 * (PPR) for AMD Family 17h Model 01h, Revision B1 Processors,
 * Preliminary Processor Programming Reference (PPR) for AMD Family
 * 17h Model 31h, Revision B0 Processors, and Preliminary Processor
 * Programming Reference (PPR) for AMD Family 19h Model 01h, Revision
 * B1 Processors Volume 1 of 2.
 */

#define AMD_ZEN_BR_RETIRED EVENT(0xc2, 0)

struct __kvm_pmu_event_filter {
	__u32 action;
	__u32 nevents;
	__u32 fixed_counter_bitmap;
	__u32 flags;
	__u32 pad[4];
	__u64 events[MAX_FILTER_EVENTS];
};

/*
 * The events in the base filter comprises Intel's eight architectural events
 * plus AMD's "retired branch instructions" for Zen[123] (and possibly other
 * AMD CPUs).
 */
static const struct __kvm_pmu_event_filter base_event_filter = {
	.nevents = ARRAY_SIZE,
	.events = {
		EVENT(0x3c, 0),
		EVENT(0xc0, 0),
		EVENT(0x3c, 1),
		EVENT(0x2e, 0x4f),
		EVENT(0x2e, 0x41),
		EVENT(0xc4, 0),
		EVENT(0xc5, 0),
		EVENT(0xa4, 1),
		AMD_ZEN_BR_RETIRED,
	},
};

/*
 * If we encounter a #GP during the guest PMU sanity check, then the guest
 * PMU is not functional. Inform the hypervisor via GUEST_SYNC(0).
 */
static void guest_gp_handler(struct ex_regs *regs)
{
	GUEST_SYNC(0);
}

/*
 * Check that we can write a new value to the given MSR and read it back.
 * The caller should provide a non-empty set of bits that are safe to flip.
 *
 * Return on success. GUEST_SYNC(0) on error.
 */
static void check_msr(uint32_t msr, uint64_t bits_to_flip)
{
	uint64_t v = rdmsr(msr) ^ bits_to_flip;

	wrmsr(msr, v);
	if (rdmsr(msr) != v)
		GUEST_SYNC(0);

	v ^= bits_to_flip;
	wrmsr(msr, v);
	if (rdmsr(msr) != v)
		GUEST_SYNC(0);
}

static void intel_guest_code(void)
{
	check_msr(MSR_CORE_PERF_GLOBAL_CTRL, 1);
	check_msr(MSR_P6_EVNTSEL0, 0xffff);
	check_msr(MSR_IA32_PMC0, 0xffff);
	GUEST_SYNC(1);

	for (;;) {
		uint64_t br0, br1;

		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
		wrmsr(MSR_P6_EVNTSEL0, ARCH_PERFMON_EVENTSEL_ENABLE |
		      ARCH_PERFMON_EVENTSEL_OS | INTEL_BR_RETIRED);
		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 1);
		br0 = rdmsr(MSR_IA32_PMC0);
		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
		br1 = rdmsr(MSR_IA32_PMC0);
		GUEST_SYNC(br1 - br0);
	}
}

/*
 * To avoid needing a check for CPUID.80000001:ECX.PerfCtrExtCore[bit 23],
 * this code uses the always-available, legacy K7 PMU MSRs, which alias to
 * the first four of the six extended core PMU MSRs.
 */
static void amd_guest_code(void)
{
	check_msr(MSR_K7_EVNTSEL0, 0xffff);
	check_msr(MSR_K7_PERFCTR0, 0xffff);
	GUEST_SYNC(1);

	for (;;) {
		uint64_t br0, br1;

		wrmsr(MSR_K7_EVNTSEL0, 0);
		wrmsr(MSR_K7_EVNTSEL0, ARCH_PERFMON_EVENTSEL_ENABLE |
		      ARCH_PERFMON_EVENTSEL_OS | AMD_ZEN_BR_RETIRED);
		br0 = rdmsr(MSR_K7_PERFCTR0);
		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
		br1 = rdmsr(MSR_K7_PERFCTR0);
		GUEST_SYNC(br1 - br0);
	}
}

/*
 * Run the VM to the next GUEST_SYNC(value), and return the value passed
 * to the sync. Any other exit from the guest is fatal.
 */
static uint64_t run_vcpu_to_sync(struct kvm_vcpu *vcpu)
{
	struct ucall uc;

	vcpu_run(vcpu);
	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
	get_ucall(vcpu, &uc);
	TEST_ASSERT(uc.cmd == UCALL_SYNC,
		    "Received ucall other than UCALL_SYNC: %lu", uc.cmd);
	return uc.args[1];
}

/*
 * In a nested environment or if the vPMU is disabled, the guest PMU
 * might not work as architected (accessing the PMU MSRs may raise
 * #GP, or writes could simply be discarded). In those situations,
 * there is no point in running these tests. The guest code will perform
 * a sanity check and then GUEST_SYNC(success). In the case of failure,
 * the behavior of the guest on resumption is undefined.
 */
static bool sanity_check_pmu(struct kvm_vcpu *vcpu)
{
	bool success;

	vm_install_exception_handler(vcpu->vm, GP_VECTOR, guest_gp_handler);
	success = run_vcpu_to_sync(vcpu);
	vm_install_exception_handler(vcpu->vm, GP_VECTOR, NULL);

	return success;
}

/*
 * Remove the first occurrence of 'event' (if any) from the filter's
 * event list.
 */
static struct kvm_pmu_event_filter *remove_event(struct kvm_pmu_event_filter *f,
						 uint64_t event)
{
	bool found = false;
	int i;

	for (i = 0; i < f->nevents; i++) {
		if (found)
			f->events[i - 1] = f->events[i];
		else
			found = f->events[i] == event;
	}
	if (found)
		f->nevents--;
	return f;
}

static void test_without_filter(struct kvm_vcpu *vcpu)
{
	uint64_t count = run_vcpu_to_sync(vcpu);

	if (count != NUM_BRANCHES)
		pr_info("%s: Branch instructions retired = %lu (expected %u)\n",
			__func__, count, NUM_BRANCHES);
	TEST_ASSERT(count, "Allowed PMU event is not counting");
}

static uint64_t test_with_filter(struct kvm_vcpu *vcpu,
				 struct __kvm_pmu_event_filter *__f)
{
	struct kvm_pmu_event_filter *f = (void *)__f;

	vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER, f);
	return run_vcpu_to_sync(vcpu);
}

static uint64_t test_with_base_filter(struct kvm_vcpu *vcpu, uint32_t action)
{
	struct __kvm_pmu_event_filter f = base_event_filter;

	f.action = action;
	return test_with_filter(vcpu, &f);
}

static void test_amd_deny_list(struct kvm_vcpu *vcpu)
{
	struct __kvm_pmu_event_filter f = base_event_filter;

	f.nevents = 1;
	f.events[0] = EVENT(0x1C2, 0);
	count = test_with_filter(vcpu, f);
	if (count != NUM_BRANCHES)
		pr_info("%s: Branch instructions retired = %lu (expected %u)\n",
			__func__, count, NUM_BRANCHES);
	TEST_ASSERT(count, "Allowed PMU event is not counting");
}

static void test_member_deny_list(struct kvm_vcpu *vcpu)
{
	uint64_t count = test_with_base_filter(vcpu, KVM_PMU_EVENT_DENY);

	if (count)
		pr_info("%s: Branch instructions retired = %lu (expected 0)\n",
			__func__, count);
	TEST_ASSERT(!count, "Disallowed PMU Event is counting");
}

static void test_member_allow_list(struct kvm_vcpu *vcpu)
{
	uint64_t count = test_with_base_filter(vcpu, KVM_PMU_EVENT_ALLOW);

	if (count != NUM_BRANCHES)
		pr_info("%s: Branch instructions retired = %lu (expected %u)\n",
			__func__, count, NUM_BRANCHES);
	TEST_ASSERT(count, "Allowed PMU event is not counting");
}

static void test_not_member_deny_list(struct kvm_vcpu *vcpu)
{
	struct __kvm_pmu_event_filter f = base_event_filter;

	f.action = KVM_PMU_EVENT_DENY;
	remove_event(&f, INTEL_BR_RETIRED);
	remove_event(&f, AMD_ZEN_BR_RETIRED);

	count = test_with_filter(vcpu, f);
	if (count != NUM_BRANCHES)
		pr_info("%s: Branch instructions retired = %lu (expected %u)\n",
			__func__, count, NUM_BRANCHES);
	TEST_ASSERT(count, "Allowed PMU event is not counting");
}

static void test_not_member_allow_list(struct kvm_vcpu *vcpu)
{
	struct __kvm_pmu_event_filter f = base_event_filter;
	uint64_t count;

	f.action = KVM_PMU_EVENT_ALLOW;
	remove_event(f, INTEL_BR_RETIRED);
	remove_event(f, AMD_ZEN_BR_RETIRED);

	count = test_with_filter(vcpu, &f);
	if (count)
		pr_info("%s: Branch instructions retired = %lu (expected 0)\n",
			__func__, count);
	TEST_ASSERT(!count, "Disallowed PMU Event is counting");
}

/*
 * Verify that setting KVM_PMU_CAP_DISABLE prevents the use of the PMU.
 *
 * Note that KVM_CAP_PMU_CAPABILITY must be invoked prior to creating VCPUs.
 */
static void test_pmu_config_disable(void (*guest_code)(void))
{
	struct kvm_vcpu *vcpu;
	int r;
	struct kvm_vm *vm;

	r = kvm_check_cap(KVM_CAP_PMU_CAPABILITY);
	if (!(r & KVM_PMU_CAP_DISABLE))
		return;

	vm = vm_create(1);

	vm_enable_cap(vm, KVM_CAP_PMU_CAPABILITY, KVM_PMU_CAP_DISABLE);

	vcpu = vm_vcpu_add(vm, 0, guest_code);
	vm_init_descriptor_tables(vm);
	vcpu_init_descriptor_tables(vcpu);

	TEST_ASSERT(!sanity_check_pmu(vcpu),
		    "Guest should not be able to use disabled PMU.");

	kvm_vm_free(vm);
}

/*
 * On Intel, check for a non-zero PMU version, at least one general-purpose
 * counter per logical processor, and support for counting the number of branch
 * instructions retired.
 */
static bool use_intel_pmu(void)
{
	return host_cpu_is_intel &&
	       kvm_cpu_property(X86_PROPERTY_PMU_VERSION) &&
	       kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS) &&
	       kvm_pmu_has(X86_PMU_FEATURE_BRANCH_INSNS_RETIRED);
}

static bool is_zen1(uint32_t family, uint32_t model)
{
	return family == 0x17 && model <= 0x0f;
}

static bool is_zen2(uint32_t family, uint32_t model)
{
	return family == 0x17 && model >= 0x30 && model <= 0x3f;
}

static bool is_zen3(uint32_t family, uint32_t model)
{
	return family == 0x19 && model <= 0x0f;
}

/*
 * Determining AMD support for a PMU event requires consulting the AMD
 * PPR for the CPU or reference material derived therefrom. The AMD
 * test code herein has been verified to work on Zen1, Zen2, and Zen3.
 *
 * Feel free to add more AMD CPUs that are documented to support event
 * select 0xc2 umask 0 as "retired branch instructions."
 */
static bool use_amd_pmu(void)
{
	uint32_t family = kvm_cpu_family();
	uint32_t model = kvm_cpu_model();

	return host_cpu_is_amd &&
		(is_zen1(family, model) ||
		 is_zen2(family, model) ||
		 is_zen3(family, model));
}

/*
 * "MEM_INST_RETIRED.ALL_LOADS", "MEM_INST_RETIRED.ALL_STORES", and
 * "MEM_INST_RETIRED.ANY" from https://perfmon-events.intel.com/
 * supported on Intel Xeon processors:
 *  - Sapphire Rapids, Ice Lake, Cascade Lake, Skylake.
 */
#define MEM_INST_RETIRED		0xD0
#define MEM_INST_RETIRED_LOAD		EVENT(MEM_INST_RETIRED, 0x81)
#define MEM_INST_RETIRED_STORE		EVENT(MEM_INST_RETIRED, 0x82)
#define MEM_INST_RETIRED_LOAD_STORE	EVENT(MEM_INST_RETIRED, 0x83)

static bool supports_event_mem_inst_retired(void)
{
	uint32_t eax, ebx, ecx, edx;

	cpuid(1, &eax, &ebx, &ecx, &edx);
	if (x86_family(eax) == 0x6) {
		switch (x86_model(eax)) {
		/* Sapphire Rapids */
		case 0x8F:
		/* Ice Lake */
		case 0x6A:
		/* Skylake */
		/* Cascade Lake */
		case 0x55:
			return true;
		}
	}

	return false;
}

/*
 * "LS Dispatch", from Processor Programming Reference
 * (PPR) for AMD Family 17h Model 01h, Revision B1 Processors,
 * Preliminary Processor Programming Reference (PPR) for AMD Family
 * 17h Model 31h, Revision B0 Processors, and Preliminary Processor
 * Programming Reference (PPR) for AMD Family 19h Model 01h, Revision
 * B1 Processors Volume 1 of 2.
 */
#define LS_DISPATCH		0x29
#define LS_DISPATCH_LOAD	EVENT(LS_DISPATCH, BIT(0))
#define LS_DISPATCH_STORE	EVENT(LS_DISPATCH, BIT(1))
#define LS_DISPATCH_LOAD_STORE	EVENT(LS_DISPATCH, BIT(2))

#define INCLUDE_MASKED_ENTRY(event_select, mask, match) \
	KVM_PMU_ENCODE_MASKED_ENTRY(event_select, mask, match, false)
#define EXCLUDE_MASKED_ENTRY(event_select, mask, match) \
	KVM_PMU_ENCODE_MASKED_ENTRY(event_select, mask, match, true)

struct perf_counter {
	union {
		uint64_t raw;
		struct {
			uint64_t loads:22;
			uint64_t stores:22;
			uint64_t loads_stores:20;
		};
	};
};

static uint64_t masked_events_guest_test(uint32_t msr_base)
{
	uint64_t ld0, ld1, st0, st1, ls0, ls1;
	struct perf_counter c;
	int val;

	/*
	 * The acutal value of the counters don't determine the outcome of
	 * the test.  Only that they are zero or non-zero.
	 */
	ld0 = rdmsr(msr_base + 0);
	st0 = rdmsr(msr_base + 1);
	ls0 = rdmsr(msr_base + 2);

	__asm__ __volatile__("movl $0, %[v];"
			     "movl %[v], %%eax;"
			     "incl %[v];"
			     : [v]"+m"(val) :: "eax");

	ld1 = rdmsr(msr_base + 0);
	st1 = rdmsr(msr_base + 1);
	ls1 = rdmsr(msr_base + 2);

	c.loads = ld1 - ld0;
	c.stores = st1 - st0;
	c.loads_stores = ls1 - ls0;

	return c.raw;
}

static void intel_masked_events_guest_code(void)
{
	uint64_t r;

	for (;;) {
		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);

		wrmsr(MSR_P6_EVNTSEL0 + 0, ARCH_PERFMON_EVENTSEL_ENABLE |
		      ARCH_PERFMON_EVENTSEL_OS | MEM_INST_RETIRED_LOAD);
		wrmsr(MSR_P6_EVNTSEL0 + 1, ARCH_PERFMON_EVENTSEL_ENABLE |
		      ARCH_PERFMON_EVENTSEL_OS | MEM_INST_RETIRED_STORE);
		wrmsr(MSR_P6_EVNTSEL0 + 2, ARCH_PERFMON_EVENTSEL_ENABLE |
		      ARCH_PERFMON_EVENTSEL_OS | MEM_INST_RETIRED_LOAD_STORE);

		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0x7);

		r = masked_events_guest_test(MSR_IA32_PMC0);

		GUEST_SYNC(r);
	}
}

static void amd_masked_events_guest_code(void)
{
	uint64_t r;

	for (;;) {
		wrmsr(MSR_K7_EVNTSEL0, 0);
		wrmsr(MSR_K7_EVNTSEL1, 0);
		wrmsr(MSR_K7_EVNTSEL2, 0);

		wrmsr(MSR_K7_EVNTSEL0, ARCH_PERFMON_EVENTSEL_ENABLE |
		      ARCH_PERFMON_EVENTSEL_OS | LS_DISPATCH_LOAD);
		wrmsr(MSR_K7_EVNTSEL1, ARCH_PERFMON_EVENTSEL_ENABLE |
		      ARCH_PERFMON_EVENTSEL_OS | LS_DISPATCH_STORE);
		wrmsr(MSR_K7_EVNTSEL2, ARCH_PERFMON_EVENTSEL_ENABLE |
		      ARCH_PERFMON_EVENTSEL_OS | LS_DISPATCH_LOAD_STORE);

		r = masked_events_guest_test(MSR_K7_PERFCTR0);

		GUEST_SYNC(r);
	}
}

static struct perf_counter run_masked_events_test(struct kvm_vcpu *vcpu,
						 const uint64_t masked_events[],
						 const int nmasked_events)
{
	struct __kvm_pmu_event_filter f = {
		.nevents = nmasked_events,
		.action = KVM_PMU_EVENT_ALLOW,
		.flags = KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
	};
	struct perf_counter r;

	memcpy(f.events, masked_events, sizeof(uint64_t) * nmasked_events);
	r.raw = test_with_filter(vcpu, f);
	return r;
}

/* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
#define MAX_FILTER_EVENTS	300
#define MAX_TEST_EVENTS		10

#define ALLOW_LOADS		BIT(0)
#define ALLOW_STORES		BIT(1)
#define ALLOW_LOADS_STORES	BIT(2)

struct masked_events_test {
	uint64_t intel_events[MAX_TEST_EVENTS];
	uint64_t intel_event_end;
	uint64_t amd_events[MAX_TEST_EVENTS];
	uint64_t amd_event_end;
	const char *msg;
	uint32_t flags;
};

/*
 * These are the test cases for the masked events tests.
 *
 * For each test, the guest enables 3 PMU counters (loads, stores,
 * loads + stores).  The filter is then set in KVM with the masked events
 * provided.  The test then verifies that the counters agree with which
 * ones should be counting and which ones should be filtered.
 */
const struct masked_events_test test_cases[] = {
	{
		.intel_events = {
			INCLUDE_MASKED_ENTRY(MEM_INST_RETIRED, 0xFF, 0x81),
		},
		.amd_events = {
			INCLUDE_MASKED_ENTRY(LS_DISPATCH, 0xFF, BIT(0)),
		},
		.msg = "Only allow loads.",
		.flags = ALLOW_LOADS,
	}, {
		.intel_events = {
			INCLUDE_MASKED_ENTRY(MEM_INST_RETIRED, 0xFF, 0x82),
		},
		.amd_events = {
			INCLUDE_MASKED_ENTRY(LS_DISPATCH, 0xFF, BIT(1)),
		},
		.msg = "Only allow stores.",
		.flags = ALLOW_STORES,
	}, {
		.intel_events = {
			INCLUDE_MASKED_ENTRY(MEM_INST_RETIRED, 0xFF, 0x83),
		},
		.amd_events = {
			INCLUDE_MASKED_ENTRY(LS_DISPATCH, 0xFF, BIT(2)),
		},
		.msg = "Only allow loads + stores.",
		.flags = ALLOW_LOADS_STORES,
	}, {
		.intel_events = {
			INCLUDE_MASKED_ENTRY(MEM_INST_RETIRED, 0x7C, 0),
			EXCLUDE_MASKED_ENTRY(MEM_INST_RETIRED, 0xFF, 0x83),
		},
		.amd_events = {
			INCLUDE_MASKED_ENTRY(LS_DISPATCH, ~(BIT(0) | BIT(1)), 0),
		},
		.msg = "Only allow loads and stores.",
		.flags = ALLOW_LOADS | ALLOW_STORES,
	}, {
		.intel_events = {
			INCLUDE_MASKED_ENTRY(MEM_INST_RETIRED, 0x7C, 0),
			EXCLUDE_MASKED_ENTRY(MEM_INST_RETIRED, 0xFF, 0x82),
		},
		.amd_events = {
			INCLUDE_MASKED_ENTRY(LS_DISPATCH, 0xF8, 0),
			EXCLUDE_MASKED_ENTRY(LS_DISPATCH, 0xFF, BIT(1)),
		},
		.msg = "Only allow loads and loads + stores.",
		.flags = ALLOW_LOADS | ALLOW_LOADS_STORES
	}, {
		.intel_events = {
			INCLUDE_MASKED_ENTRY(MEM_INST_RETIRED, 0xFE, 0x82),
		},
		.amd_events = {
			INCLUDE_MASKED_ENTRY(LS_DISPATCH, 0xF8, 0),
			EXCLUDE_MASKED_ENTRY(LS_DISPATCH, 0xFF, BIT(0)),
		},
		.msg = "Only allow stores and loads + stores.",
		.flags = ALLOW_STORES | ALLOW_LOADS_STORES
	}, {
		.intel_events = {
			INCLUDE_MASKED_ENTRY(MEM_INST_RETIRED, 0x7C, 0),
		},
		.amd_events = {
			INCLUDE_MASKED_ENTRY(LS_DISPATCH, 0xF8, 0),
		},
		.msg = "Only allow loads, stores, and loads + stores.",
		.flags = ALLOW_LOADS | ALLOW_STORES | ALLOW_LOADS_STORES
	},
};

static int append_test_events(const struct masked_events_test *test,
			      uint64_t *events, uint32_t nevents)
{
	const uint64_t *evts;
	int i;

	evts = use_intel_pmu() ? test->intel_events : test->amd_events;
	for (i = 0; i < MAX_TEST_EVENTS; i++) {
		if (evts[i] == 0)
			break;

		events[nevents + i] = evts[i];
	}

	return nevents + i;
}

static bool bool_eq(bool a, bool b)
{
	return a == b;
}

static void run_masked_events_tests(struct kvm_vcpu *vcpu, uint64_t *events,
				    uint32_t nevents)
{
	int ntests = ARRAY_SIZE(test_cases);
	struct perf_counter c;
	int i, n;

	for (i = 0; i < ntests; i++) {
		const struct masked_events_test *test = &test_cases[i];

		/* Do any test case events overflow MAX_TEST_EVENTS? */
		assert(test->intel_event_end == 0);
		assert(test->amd_event_end == 0);

		n = append_test_events(test, events, nevents);

		c = run_masked_events_test(vcpu, events, n);
		TEST_ASSERT(bool_eq(c.loads, test->flags & ALLOW_LOADS) &&
			    bool_eq(c.stores, test->flags & ALLOW_STORES) &&
			    bool_eq(c.loads_stores,
				    test->flags & ALLOW_LOADS_STORES),
			    "%s  loads: %u, stores: %u, loads + stores: %u",
			    test->msg, c.loads, c.stores, c.loads_stores);
	}
}

static void add_dummy_events(uint64_t *events, uint32_t nevents)
{
	int i;

	for (i = 0; i < nevents; i++) {
		int event_select = i % 0xFF;
		bool exclude = ((i % 4) == 0);

		if (event_select == MEM_INST_RETIRED ||
		    event_select == LS_DISPATCH)
			event_select++;

		events[i] = KVM_PMU_ENCODE_MASKED_ENTRY(event_select, 0,
							0, exclude);
	}
}

static void test_masked_events(struct kvm_vcpu *vcpu)
{
	uint32_t nevents = MAX_FILTER_EVENTS - MAX_TEST_EVENTS;
	uint64_t events[MAX_FILTER_EVENTS];

	/* Run the test cases against a sparse PMU event filter. */
	run_masked_events_tests(vcpu, events, 0);

	/* Run the test cases against a dense PMU event filter. */
	add_dummy_events(events, MAX_FILTER_EVENTS);
	run_masked_events_tests(vcpu, events, nevents);
}

static int set_pmu_event_filter(struct kvm_vcpu *vcpu,
				struct __kvm_pmu_event_filter *f)
{
	return __vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER,
			  (struct kvm_pmu_event_filter *)&f);
}

static int set_pmu_single_event_filter(struct kvm_vcpu *vcpu, uint64_t event,
				       uint32_t flags, uint32_t action)
{
	struct __kvm_pmu_event_filter f = {
		.nevents = 1,
		.flags = flags,
		.action = action,
		.events = {
			event,
		},
	};
	
	return do_vcpu_set_pmu_event_filter(vcpu, &f);
}

static void test_filter_ioctl(struct kvm_vcpu *vcpu)
{
	uint32_t nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
	struct __kvm_pmu_event_filter f;
	uint64_t e = ~0ul;
	int r;

	/*
	 * Unfortunately having invalid bits set in event data is expected to
	 * pass when flags == 0 (bits other than eventsel+umask).
	 */
	r = set_pmu_single_event_filter(vcpu, e, 0);
	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");


	r = set_pmu_single_event_filter(vcpu, e, KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
	TEST_ASSERT(r != 0, "Invalid PMU Event Filter is expected to fail");

	e = KVM_PMU_ENCODE_MASKED_ENTRY(0xff, 0xff, 0xff, 0xf);
	r = set_pmu_single_event_filter(vcpu, e, KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");

	/*
	 * Test input of unsupported "action" values should return an error.
	 * The only values currently supported are 0 or 1.
	 */
	f = base_event_filter;
	f.action = PMU_EVENT_FILTER_INVALID_ACTION;
	r = set_pmu_event_filter(vcpu, e, 0, PMU_EVENT_FILTER_INVALID_ACTION);
	TEST_ASSERT(r != 0, "Set invalid action is expected to fail.");

	/*
	 * Test input of unsupported "flags" values should return an error.
	 * The only values currently supported are 0 or 1.
	 */
	r = set_pmu_single_event_filter(vcpu, e, PMU_EVENT_FILTER_INVALID_FLAGS);
	TEST_ASSERT(r != 0, "Set invalid flags is expected to fail.");

	/*
	 * Test input of unsupported "nevents" values should return an error.
	 * The only values currently supported are those less than or equal to
	 * MAX_FILTER_EVENTS.
	 */
	f = base_event_filter;
	f.nevents = PMU_EVENT_FILTER_INVALID_NEVENTS;
	r = set_pmu_event_filter(vcpu, &f);
	TEST_ASSERT(r != 0,
		    "Setting PMU event filters that exceeds the maximum supported value should fail");

	/*
	 * In this case, set non-exist fixed counters in the fixed bitmap
	 * doesn't fail.
	 */
	f = base_event_filter;
	f.fixed_counter_bitmap = ~GENMASK_ULL(nr_fixed_counters, 0);
	r = set_pmu_event_filter(vcpu, &f);
	TEST_ASSERT(!r, "Set invalid or non-exist fixed cunters in the fixed bitmap fail.");
}

int main(int argc, char *argv[])
{
	void (*guest_code)(void);
	struct kvm_vcpu *vcpu, *vcpu2 = NULL;
	struct kvm_vm *vm;

	TEST_REQUIRE(get_kvm_param_bool("enable_pmu"));
	TEST_REQUIRE(kvm_has_cap(KVM_CAP_PMU_EVENT_FILTER));
	TEST_REQUIRE(kvm_has_cap(KVM_CAP_PMU_EVENT_MASKED_EVENTS));

	TEST_REQUIRE(use_intel_pmu() || use_amd_pmu());
	guest_code = use_intel_pmu() ? intel_guest_code : amd_guest_code;

	vm = vm_create_with_one_vcpu(&vcpu, guest_code);

	vm_init_descriptor_tables(vm);
	vcpu_init_descriptor_tables(vcpu);

	TEST_REQUIRE(sanity_check_pmu(vcpu));

	if (use_amd_pmu())
		test_amd_deny_list(vcpu);

	test_without_filter(vcpu);
	test_member_deny_list(vcpu);
	test_member_allow_list(vcpu);
	test_not_member_deny_list(vcpu);
	test_not_member_allow_list(vcpu);

	if (use_intel_pmu() &&
	    supports_event_mem_inst_retired() &&
	    kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS) >= 3)
		vcpu2 = vm_vcpu_add(vm, 2, intel_masked_events_guest_code);
	else if (use_amd_pmu())
		vcpu2 = vm_vcpu_add(vm, 2, amd_masked_events_guest_code);

	if (vcpu2)
		test_masked_events(vcpu2);
	test_filter_ioctl(vcpu);

	kvm_vm_free(vm);

	test_pmu_config_disable(guest_code);

	return 0;
}

