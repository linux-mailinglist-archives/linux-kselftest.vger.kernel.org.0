Return-Path: <linux-kselftest+bounces-3998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA1C846AC5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 09:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCEEF1F25EE4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 08:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A7017C91;
	Fri,  2 Feb 2024 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VST3IWA3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84EF1862B
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862858; cv=none; b=PU5E1nOFu7ruWxARIkbIaN1YhKxS8V5LrcnJaEBZ5I75X66/tQPXL9+mBNnoG4SbktQwjSHUW3UstEO19vIu1D2OhrlAmcPOlA/w68+nr0YZC9YwqzHtJiSsTVfN0kUIgi75y+Zm8JfBAoqwib8Z5+QGCJ1VuZTjmYBVjY+mLE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862858; c=relaxed/simple;
	bh=UG/Eg2KNFEypP8SbxOTMPXJKuFQl4CYNnNyoaMhrLP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWVrkgQkqAzqPdXWbrsrFW/xGwO6mNN+bw4/8bQiEXoBukpehNiuvGMDr9kjSWTjFymuChVkJQDFr2O1SFJqh684aum2+oBIOTj8nzqBzhtm2PyNX+/gJ220y/d9tcw1oZomkwpt60oFL59/Ztk8nVRTKQ9wHhY4OJRH2v6u8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VST3IWA3; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 2 Feb 2024 08:34:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706862853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/kyJRNE++srYfi1Xk96zVfKuuYgRgfbW3SWtrqXmKA=;
	b=VST3IWA3E/x9VszHqTKNa7OFua4Qq6KbI2kgO6Sn4mu7PDugFyCKpKsSU7weu/rSwcjcKp
	AJ4im9obGLkt7SQfqNuFx6EJw/IBwkDncDQxeZDvA6r5SX3jWcl7zlPSgg/DCG4yesQW0t
	0HkTey1MpWqLutQyzgHU2h8Z2kIlGQo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
	Eric Auger <eauger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/5] KVM: selftests: aarch64: Introduce
 pmu_event_filter_test
Message-ID: <ZbypAAFEHweTDUJK@linux.dev>
References: <20240202025659.5065-1-shahuang@redhat.com>
 <20240202025659.5065-5-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202025659.5065-5-shahuang@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 01, 2024 at 09:56:53PM -0500, Shaoqin Huang wrote:
> Introduce pmu_event_filter_test for arm64 platforms. The test configures
> PMUv3 for a vCPU, and sets different pmu event filters for the vCPU, and
> check if the guest can see those events which user allow and can't use
> those events which use deny.
> 
> This test refactor the create_vpmu_vm() and make it a wrapper for
> __create_vpmu_vm(), which allows some extra init code before
> KVM_ARM_VCPU_PMU_V3_INIT.
> 
> And this test use the KVM_ARM_VCPU_PMU_V3_FILTER attribute to set the
> pmu event filter in KVM. And choose to filter two common event
> branches_retired and instructions_retired, and let the guest to check if
> it see the right pmceid register.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../kvm/aarch64/pmu_event_filter_test.c       | 219 ++++++++++++++++++
>  .../selftests/kvm/include/aarch64/vpmu.h      |   4 +
>  .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  14 +-
>  4 files changed, 236 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 709a70b31ca2..733ec86a3385 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -148,6 +148,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
>  TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>  TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
>  TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
> +TEST_GEN_PROGS_aarch64 += aarch64/pmu_event_filter_test
>  TEST_GEN_PROGS_aarch64 += aarch64/psci_test
>  TEST_GEN_PROGS_aarch64 += aarch64/set_id_regs
>  TEST_GEN_PROGS_aarch64 += aarch64/smccc_filter
> diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> new file mode 100644
> index 000000000000..d280382f362f
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pmu_event_filter_test - Test user limit pmu event for guest.
> + *
> + * Copyright (c) 2023 Red Hat, Inc.
> + *
> + * This test checks if the guest only see the limited pmu event that userspace
> + * sets, if the guest can use those events which user allow, and if the guest
> + * can't use those events which user deny.
> + * This test runs only when KVM_CAP_ARM_PMU_V3, KVM_ARM_VCPU_PMU_V3_FILTER
> + * is supported on the host.
> + */
> +#include <kvm_util.h>
> +#include <processor.h>
> +#include <vgic.h>
> +#include <vpmu.h>
> +#include <test_util.h>
> +#include <perf/arm_pmuv3.h>
> +
> +struct pmce{

Missing whitespace before curly brace.

Also -- pmce is an odd name. Maybe common_event_ids or pmu_id_regs.

> +	uint64_t pmceid0;
> +	uint64_t pmceid1;
> +} supported_pmce, guest_pmce;

maybe "max_*" and "expected_*". It took me a bit to understand that
guest_pmce feeds in your expected PMCEID values.

> +static struct vpmu_vm *vpmu_vm;
> +
> +#define FILTER_NR 10
> +
> +struct test_desc {
> +	const char *name;
> +	struct kvm_pmu_event_filter filter[FILTER_NR];
> +};
> +
> +#define __DEFINE_FILTER(base, num, act)		\
> +	((struct kvm_pmu_event_filter) {	\
> +		.base_event	= base,		\
> +		.nevents	= num,		\
> +		.action		= act,		\
> +	})
> +
> +#define DEFINE_FILTER(base, act) __DEFINE_FILTER(base, 1, act)
> +
> +#define EMPTY_FILTER	{ 0 }
> +
> +#define SW_INCR		0x0
> +#define INST_RETIRED	0x8
> +#define BR_RETIRED	0x21

These event numbers are already defined in tools/include/perf/arm_pmuv3.h,
use those instead.

> +static void guest_code(void)
> +{
> +	uint64_t pmceid0 = read_sysreg(pmceid0_el0);
> +	uint64_t pmceid1 = read_sysreg(pmceid1_el0);
> +
> +	GUEST_ASSERT_EQ(guest_pmce.pmceid0, pmceid0);
> +	GUEST_ASSERT_EQ(guest_pmce.pmceid1, pmceid1);
> +
> +	GUEST_DONE();
> +}
> +
> +static void guest_get_pmceid(void)
> +{
> +	supported_pmce.pmceid0 = read_sysreg(pmceid0_el0);
> +	supported_pmce.pmceid1 = read_sysreg(pmceid1_el0);
> +
> +	GUEST_DONE();
> +}
> +
> +static void pmu_event_filter_init(struct vpmu_vm *vm, void *arg)

Why are you obfuscating the pointer to the filter array?

> +{
> +	struct kvm_device_attr attr = {
> +		.group	= KVM_ARM_VCPU_PMU_V3_CTRL,
> +		.attr	= KVM_ARM_VCPU_PMU_V3_FILTER,
> +	};
> +	struct kvm_pmu_event_filter *filter = (struct kvm_pmu_event_filter *)arg;
> +
> +	while (filter && filter->nevents != 0) {
> +		attr.addr = (uint64_t)filter;
> +		vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);

Again, kvm_device_attr_set() the right helper to use.

> +static void set_pmce(struct pmce *pmce, int action, int event)
> +{
> +	int base = 0;
> +	uint64_t *pmceid = NULL;
> +
> +	if (event >= 0x4000) {
> +		event -= 0x4000;
> +		base = 32;
> +	}
> +
> +	if (event >= 0 && event <= 0x1F) {
> +		pmceid = &pmce->pmceid0;
> +	} else if (event >= 0x20 && event <= 0x3F) {
> +		event -= 0x20;
> +		pmceid = &pmce->pmceid1;
> +	} else {
> +		return;
> +	}
> +
> +	event += base;
> +	if (action == KVM_PMU_EVENT_ALLOW)
> +		*pmceid |= BIT(event);
> +	else
> +		*pmceid &= ~BIT(event);
> +}
> +
> +static void prepare_guest_pmce(struct kvm_pmu_event_filter *filter)
> +{
> +	struct pmce pmce_mask = { ~0, ~0 };
> +	bool first_filter = true;
> +
> +	while (filter && filter->nevents != 0) {
> +		if (first_filter) {
> +			if (filter->action == KVM_PMU_EVENT_ALLOW)
> +				memset(&pmce_mask, 0, sizeof(pmce_mask));
> +			first_filter = false;
> +		}
> +
> +		set_pmce(&pmce_mask, filter->action, filter->base_event);
> +		filter++;
> +	}
> +
> +	guest_pmce.pmceid0 = supported_pmce.pmceid0 & pmce_mask.pmceid0;
> +	guest_pmce.pmceid1 = supported_pmce.pmceid1 & pmce_mask.pmceid1;
> +}

Why do you need to do this? Can't you tell the guests what events to
expect and have it make sense of the PMCEID values it sees?

You could, for example, pass in a pointer to the test descriptor as an
argument.

> +static void run_test(struct test_desc *t)
> +{
> +	pr_debug("Test: %s\n", t->name);

You may as well just pr_info() this thing.

> +	create_vpmu_vm_with_filter(guest_code, t->filter);
> +	prepare_guest_pmce(t->filter);
> +	sync_global_to_guest(vpmu_vm->vm, guest_pmce);
> +
> +	run_vcpu(vpmu_vm->vcpu);
> +
> +	destroy_vpmu_vm(vpmu_vm);
> +}
> +
> +static struct test_desc tests[] = {
> +	{"without_filter", { EMPTY_FILTER }},
> +	{"member_allow_filter",
> +	 {DEFINE_FILTER(SW_INCR, 0), DEFINE_FILTER(INST_RETIRED, 0),
> +	  DEFINE_FILTER(BR_RETIRED, 0), EMPTY_FILTER}},
> +	{"member_deny_filter",
> +	 {DEFINE_FILTER(SW_INCR, 1), DEFINE_FILTER(INST_RETIRED, 1),
> +	  DEFINE_FILTER(BR_RETIRED, 1), EMPTY_FILTER}},
> +	{"not_member_deny_filter",
> +	 {DEFINE_FILTER(SW_INCR, 1), EMPTY_FILTER}},
> +	{"not_member_allow_filter",
> +	 {DEFINE_FILTER(SW_INCR, 0), EMPTY_FILTER}},

Why is the filter array special enough to get its own sentinel macro
but...

> +	{ 0 }

... the test descriptor array is okay to use a 'raw' initialization. My
vote is to drop the macro, zero-initializing a struct in an array is an
extremely common pattern in the kernel.

Also, these descriptors are dense and hard to read. Working with an
example:

	{
		.name = "member_allow_filter",
		.filter = {
			DEFINE_FILTER(SW_INCR, 0),
			DEFINE_FILTER(INST_RETIRED, 0),
			DEFINE_FILTER(BR_RETIRED, 0),
			{ 0 }
		},
	}

See how much more readable that is?

> +};
> +
> +static void for_each_test(void)
> +{
> +	struct test_desc *t;
> +
> +	for (t = &tests[0]; t->name; t++)
> +		run_test(t);
> +}

for_each_test() sounds like an iterator, but this is not. Call it
run_tests()

> +static bool kvm_supports_pmu_event_filter(void)
> +{
> +	int r;
> +
> +	vpmu_vm = create_vpmu_vm(guest_code);
> +
> +	r = __kvm_has_device_attr(vpmu_vm->vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
> +				  KVM_ARM_VCPU_PMU_V3_FILTER);
> +
> +	destroy_vpmu_vm(vpmu_vm);
> +	return !r;
> +}

TBH, I don't really care much about the test probing for the event
filter UAPI. It has been upstream for a while, and if folks are trying
to run selftests at HEAD on an old kernel then that's their business.

The other prerequisites make more sense since they actually check if HW
features are present.

> +static bool host_pmu_supports_events(void)
> +{
> +	vpmu_vm = create_vpmu_vm(guest_get_pmceid);
> +
> +	memset(&supported_pmce, 0, sizeof(supported_pmce));
> +	sync_global_to_guest(vpmu_vm->vm, supported_pmce);
> +	run_vcpu(vpmu_vm->vcpu);
> +	sync_global_from_guest(vpmu_vm->vm, supported_pmce);
> +	destroy_vpmu_vm(vpmu_vm);
> +
> +	return supported_pmce.pmceid0 & (BR_RETIRED | INST_RETIRED);
> +}

This helper says its probing the host PMU, but you're actually firing up a
VM to do it.

The events supported by a particular PMU instance are readily available
in sysfs. Furthermore, you can tell KVM to select the exact host PMU
instance you probe.

> diff --git a/tools/testing/selftests/kvm/lib/aarch64/vpmu.c b/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
> index b3de8fdc555e..76ea03d607f1 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
> @@ -7,8 +7,9 @@
>  #include <vpmu.h>
>  #include <perf/arm_pmuv3.h>
>  
> -/* Create a VM that has one vCPU with PMUv3 configured. */
> -struct vpmu_vm *create_vpmu_vm(void *guest_code)
> +struct vpmu_vm *__create_vpmu_vm(void *guest_code,
> +				 void (*init_pmu)(struct vpmu_vm *vm, void *arg),
> +				 void *arg)
>  {
>  	struct kvm_vcpu_init init;
>  	uint8_t pmuver;
> @@ -50,12 +51,21 @@ struct vpmu_vm *create_vpmu_vm(void *guest_code)
>  		    "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pmuver);
>  
>  	/* Initialize vPMU */
> +	if (init_pmu)
> +		init_pmu(vpmu_vm, arg);
> +
>  	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
>  	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
>  
>  	return vpmu_vm;
>  }
>  
> +/* Create a VM that has one vCPU with PMUv3 configured. */
> +struct vpmu_vm *create_vpmu_vm(void *guest_code)
> +{
> +	return __create_vpmu_vm(guest_code, NULL, NULL);
> +}
> +

Ok. This completely proves my point in the other patch. You already need
to refactor this helper to cram in what you're trying to do. Think of
ways to move the code that is actually common into libraries and leave
the rest to the tests themselves.

Some slight code duplication isn't the end of the world if it avoids
churning libraries every time someone wants to add a widget.

-- 
Thanks,
Oliver

