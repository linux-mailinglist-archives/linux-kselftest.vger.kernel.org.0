Return-Path: <linux-kselftest+bounces-4755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F73856624
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B05282BDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E263A132474;
	Thu, 15 Feb 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjHd0ltX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF2132493
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Feb 2024 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008134; cv=none; b=hYioyui3MsBF2mTav80itDd75IlKF7NZtbX3VoKnreQ46jprI79aYBohd2jrANxblvsznlzo79cgrrrXqR5WrWeFy9MwNmvbxM9y78avj8a3S2oxLUM/ApkdTYfaEcufe1deEPmGmTWBrPfNKBpSo08l0Fjvalc5aoIkdRXObcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008134; c=relaxed/simple;
	bh=KVQXyddDCqFOkaQkPG/3aBE9fjuhRZsKr40SbrA8X64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5NrvShl+/Ph0hD8oxYqBQS+mufKIh4/p5/XAnqFcNxNMYi642h9IOM9WE1gbUtQ/BBcEh5RcYmI2k/skXWpkjPTvPKnCEruCRtzjxaqTqWpBDr2fJjwWHWQD+4gleXurNKK4Q/oGG2m5qLQmwr3YjYowL3qeNXAdZK6+HME8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjHd0ltX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708008131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DU/I58QZ3iymbaVm/jdmROBBRbIzgpeEc0Gm3Gdul0M=;
	b=ZjHd0ltXAz6JknKtesqoCXtJ4AUY7477St8W1zc1QgSr6AUDlQvPGmpArioT/2IEVX03RO
	ttxjkfuHcOLmb39Ry7koGN7Ajzq4MxtLLX7SLyAoKuO1gHID4x1IvRicnLyui02ZKC4C8D
	y6AjKHLSt7v4cGAsTzNoNQzblTx7lfI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-H7N6gGFEO62s8oJVNPMqrA-1; Thu, 15 Feb 2024 09:42:10 -0500
X-MC-Unique: H7N6gGFEO62s8oJVNPMqrA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78732274d13so99812285a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Feb 2024 06:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008130; x=1708612930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DU/I58QZ3iymbaVm/jdmROBBRbIzgpeEc0Gm3Gdul0M=;
        b=U61XwDfTLcYsHVO6zQrgy/4xXP70HGedygneq3kFGoLvwTOU4UkmFuIiCeHlGwXe38
         A2QY5HBrLVCcCgPcH4lJLF3lOlWP7xikiZRQgeRpEsrksb6P1QBybQtqF9Yz2NUsXENQ
         Tgov+/bFFKqr6JyJQloRM/0Mk1X+sr0kZYu0rr4Wz1HbV9P3FlVUI+uiThc+eL3Hbf9v
         acmzuEknUVstQTEe4dE0I58bJ76OHdM5eG6ifveVnq8Lv0JCB6LPdV+5u6s2PcNTh0eQ
         DL/XfXzXnl+UFZORPI5v38migS0cxazkmAo4YB+7LqbGom8XTBB+f6tWhwcN0ZETzlH8
         azUA==
X-Forwarded-Encrypted: i=1; AJvYcCXEG8EV0rTgMK1g+iOPIGGIjRswfCiE3zpPCcOiaHlu4gsRtOwAUYn5Ipq5iAgLYcj2x+zfk2Os8pHKZhNv2Gqw3lAKs6v23/b8PzK/GQk2
X-Gm-Message-State: AOJu0YzcpiYWzwWz0FWN4pdMbBkXU7lgloe5SNlLzLhRpTG8jQs4UkMq
	BVxSkgAjmvjdV8m5Pz7QK+UUPeFzB2bnZDjLwKkXbpzvbpLWKJWI9LOTed2NVBZkTeMPVZfrz+M
	MvDdkfIH4ulc7JkYBoquFWlkdDJ8Q+Is+DBwIpxPbpVUsVuW7qy/6c+hyAl3bsaqkUA==
X-Received: by 2002:a05:620a:13e4:b0:785:c28b:d86c with SMTP id h4-20020a05620a13e400b00785c28bd86cmr2100288qkl.66.1708008129712;
        Thu, 15 Feb 2024 06:42:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvzVNXhi8rT3Pn+sH7a3Nu8FXV4LGRfEWLSlX73VFVdckv4Ow3Ck6pFZ7Hck6w0K2drJHXMA==
X-Received: by 2002:a05:620a:13e4:b0:785:c28b:d86c with SMTP id h4-20020a05620a13e400b00785c28bd86cmr2100269qkl.66.1708008129385;
        Thu, 15 Feb 2024 06:42:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id p21-20020a05620a113500b00783f77b968fsm636620qkk.109.2024.02.15.06.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 06:42:08 -0800 (PST)
Message-ID: <a456cae7-037a-4e11-979b-a7bacc0fe850@redhat.com>
Date: Thu, 15 Feb 2024 15:42:05 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] KVM: selftests: aarch64: Introduce
 pmu_event_filter_test
Content-Language: en-US
To: Oliver Upton <oliver.upton@linux.dev>, Shaoqin Huang <shahuang@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240202025659.5065-1-shahuang@redhat.com>
 <20240202025659.5065-5-shahuang@redhat.com> <ZbypAAFEHweTDUJK@linux.dev>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <ZbypAAFEHweTDUJK@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaoqin,

On 2/2/24 09:34, Oliver Upton wrote:
> On Thu, Feb 01, 2024 at 09:56:53PM -0500, Shaoqin Huang wrote:
>> Introduce pmu_event_filter_test for arm64 platforms. The test configures
>> PMUv3 for a vCPU, and sets different pmu event filters for the vCPU, and
>> check if the guest can see those events which user allow and can't use
>> those events which use deny.
>>
>> This test refactor the create_vpmu_vm() and make it a wrapper for
>> __create_vpmu_vm(), which allows some extra init code before
>> KVM_ARM_VCPU_PMU_V3_INIT.
>>
>> And this test use the KVM_ARM_VCPU_PMU_V3_FILTER attribute to set the
>> pmu event filter in KVM. And choose to filter two common event
>> branches_retired and instructions_retired, and let the guest to check if
>> it see the right pmceid register.
>>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
>>  tools/testing/selftests/kvm/Makefile          |   1 +
>>  .../kvm/aarch64/pmu_event_filter_test.c       | 219 ++++++++++++++++++
>>  .../selftests/kvm/include/aarch64/vpmu.h      |   4 +
>>  .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  14 +-
>>  4 files changed, 236 insertions(+), 2 deletions(-)
>>  create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index 709a70b31ca2..733ec86a3385 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -148,6 +148,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
>>  TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>>  TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
>>  TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
>> +TEST_GEN_PROGS_aarch64 += aarch64/pmu_event_filter_test
>>  TEST_GEN_PROGS_aarch64 += aarch64/psci_test
>>  TEST_GEN_PROGS_aarch64 += aarch64/set_id_regs
>>  TEST_GEN_PROGS_aarch64 += aarch64/smccc_filter
>> diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>> new file mode 100644
>> index 000000000000..d280382f362f
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>> @@ -0,0 +1,219 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * pmu_event_filter_test - Test user limit pmu event for guest.
>> + *
>> + * Copyright (c) 2023 Red Hat, Inc.
>> + *
>> + * This test checks if the guest only see the limited pmu event that userspace
>> + * sets, if the guest can use those events which user allow, and if the guest
>> + * can't use those events which user deny.
>> + * This test runs only when KVM_CAP_ARM_PMU_V3, KVM_ARM_VCPU_PMU_V3_FILTER
>> + * is supported on the host.
>> + */
>> +#include <kvm_util.h>
>> +#include <processor.h>
>> +#include <vgic.h>
>> +#include <vpmu.h>
>> +#include <test_util.h>
>> +#include <perf/arm_pmuv3.h>
>> +
>> +struct pmce{
> 
> Missing whitespace before curly brace.
> 
> Also -- pmce is an odd name. Maybe common_event_ids or pmu_id_regs.
> 
>> +	uint64_t pmceid0;
>> +	uint64_t pmceid1;
>> +} supported_pmce, guest_pmce;
> 
> maybe "max_*" and "expected_*". It took me a bit to understand that
> guest_pmce feeds in your expected PMCEID values.
> 
>> +static struct vpmu_vm *vpmu_vm;
>> +
>> +#define FILTER_NR 10
>> +
>> +struct test_desc {
>> +	const char *name;
>> +	struct kvm_pmu_event_filter filter[FILTER_NR];
>> +};
>> +
>> +#define __DEFINE_FILTER(base, num, act)		\
>> +	((struct kvm_pmu_event_filter) {	\
>> +		.base_event	= base,		\
>> +		.nevents	= num,		\
>> +		.action		= act,		\
>> +	})
>> +
>> +#define DEFINE_FILTER(base, act) __DEFINE_FILTER(base, 1, act)
>> +
>> +#define EMPTY_FILTER	{ 0 }
>> +
>> +#define SW_INCR		0x0
>> +#define INST_RETIRED	0x8
>> +#define BR_RETIRED	0x21
> 
> These event numbers are already defined in tools/include/perf/arm_pmuv3.h,
> use those instead.
> 
>> +static void guest_code(void)
>> +{
>> +	uint64_t pmceid0 = read_sysreg(pmceid0_el0);
>> +	uint64_t pmceid1 = read_sysreg(pmceid1_el0);
>> +
>> +	GUEST_ASSERT_EQ(guest_pmce.pmceid0, pmceid0);
>> +	GUEST_ASSERT_EQ(guest_pmce.pmceid1, pmceid1);
>> +
>> +	GUEST_DONE();
>> +}
>> +
>> +static void guest_get_pmceid(void)
>> +{
>> +	supported_pmce.pmceid0 = read_sysreg(pmceid0_el0);
>> +	supported_pmce.pmceid1 = read_sysreg(pmceid1_el0);
>> +
>> +	GUEST_DONE();
>> +}
>> +
>> +static void pmu_event_filter_init(struct vpmu_vm *vm, void *arg)
> 
> Why are you obfuscating the pointer to the filter array?
> 
>> +{
>> +	struct kvm_device_attr attr = {
>> +		.group	= KVM_ARM_VCPU_PMU_V3_CTRL,
>> +		.attr	= KVM_ARM_VCPU_PMU_V3_FILTER,
>> +	};
>> +	struct kvm_pmu_event_filter *filter = (struct kvm_pmu_event_filter *)arg;
>> +
>> +	while (filter && filter->nevents != 0) {
>> +		attr.addr = (uint64_t)filter;
>> +		vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);
> 
> Again, kvm_device_attr_set() the right helper to use.
> 
>> +static void set_pmce(struct pmce *pmce, int action, int event)
>> +{
>> +	int base = 0;
>> +	uint64_t *pmceid = NULL;
>> +
>> +	if (event >= 0x4000) {
>> +		event -= 0x4000;
>> +		base = 32;
>> +	}
>> +
>> +	if (event >= 0 && event <= 0x1F) {
>> +		pmceid = &pmce->pmceid0;
>> +	} else if (event >= 0x20 && event <= 0x3F) {
>> +		event -= 0x20;
>> +		pmceid = &pmce->pmceid1;
>> +	} else {
>> +		return;
>> +	}
>> +
>> +	event += base;
>> +	if (action == KVM_PMU_EVENT_ALLOW)
>> +		*pmceid |= BIT(event);
>> +	else
>> +		*pmceid &= ~BIT(event);
>> +}
>> +
>> +static void prepare_guest_pmce(struct kvm_pmu_event_filter *filter)
>> +{
>> +	struct pmce pmce_mask = { ~0, ~0 };
>> +	bool first_filter = true;
>> +
>> +	while (filter && filter->nevents != 0) {
>> +		if (first_filter) {
>> +			if (filter->action == KVM_PMU_EVENT_ALLOW)
>> +				memset(&pmce_mask, 0, sizeof(pmce_mask));
>> +			first_filter = false;
>> +		}
>> +
>> +		set_pmce(&pmce_mask, filter->action, filter->base_event);
>> +		filter++;
>> +	}
>> +
>> +	guest_pmce.pmceid0 = supported_pmce.pmceid0 & pmce_mask.pmceid0;
>> +	guest_pmce.pmceid1 = supported_pmce.pmceid1 & pmce_mask.pmceid1;
>> +}
> 
> Why do you need to do this? Can't you tell the guests what events to
> expect and have it make sense of the PMCEID values it sees?
> 
> You could, for example, pass in a pointer to the test descriptor as an
> argument.
> 
>> +static void run_test(struct test_desc *t)
>> +{
>> +	pr_debug("Test: %s\n", t->name);
> 
> You may as well just pr_info() this thing.
> 
>> +	create_vpmu_vm_with_filter(guest_code, t->filter);
>> +	prepare_guest_pmce(t->filter);
>> +	sync_global_to_guest(vpmu_vm->vm, guest_pmce);
>> +
>> +	run_vcpu(vpmu_vm->vcpu);
>> +
>> +	destroy_vpmu_vm(vpmu_vm);
>> +}
>> +
>> +static struct test_desc tests[] = {
>> +	{"without_filter", { EMPTY_FILTER }},
>> +	{"member_allow_filter",
>> +	 {DEFINE_FILTER(SW_INCR, 0), DEFINE_FILTER(INST_RETIRED, 0),
>> +	  DEFINE_FILTER(BR_RETIRED, 0), EMPTY_FILTER}},
>> +	{"member_deny_filter",
>> +	 {DEFINE_FILTER(SW_INCR, 1), DEFINE_FILTER(INST_RETIRED, 1),
>> +	  DEFINE_FILTER(BR_RETIRED, 1), EMPTY_FILTER}},
>> +	{"not_member_deny_filter",
>> +	 {DEFINE_FILTER(SW_INCR, 1), EMPTY_FILTER}},
>> +	{"not_member_allow_filter",
>> +	 {DEFINE_FILTER(SW_INCR, 0), EMPTY_FILTER}},
from a strict uapi testing you are not testing
- "Cancelling" a filter by registering the opposite action for the same
range doesn't change the default action.
- Event 0 (SW_INCR)
- Filtering event 0x1E (CHAIN) has no effect either
- Filtering the cycle counter is possible using event 0x11 (CPU_CYCLES).

Documentation/virt/kvm/devices/vcpu.rst

Then it obviously depends on how much coverage of the API you want/can
afford to reach.

Eric

> 
> Why is the filter array special enough to get its own sentinel macro
> but...
> 
>> +	{ 0 }
> 
> ... the test descriptor array is okay to use a 'raw' initialization. My
> vote is to drop the macro, zero-initializing a struct in an array is an
> extremely common pattern in the kernel.
> 
> Also, these descriptors are dense and hard to read. Working with an
> example:
> 
> 	{
> 		.name = "member_allow_filter",
> 		.filter = {
> 			DEFINE_FILTER(SW_INCR, 0),
> 			DEFINE_FILTER(INST_RETIRED, 0),
> 			DEFINE_FILTER(BR_RETIRED, 0),
> 			{ 0 }
> 		},
> 	}
> 
> See how much more readable that is?
> 
>> +};
>> +
>> +static void for_each_test(void)
>> +{
>> +	struct test_desc *t;
>> +
>> +	for (t = &tests[0]; t->name; t++)
>> +		run_test(t);
>> +}
> 
> for_each_test() sounds like an iterator, but this is not. Call it
> run_tests()
> 
>> +static bool kvm_supports_pmu_event_filter(void)
>> +{
>> +	int r;
>> +
>> +	vpmu_vm = create_vpmu_vm(guest_code);
>> +
>> +	r = __kvm_has_device_attr(vpmu_vm->vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
>> +				  KVM_ARM_VCPU_PMU_V3_FILTER);
>> +
>> +	destroy_vpmu_vm(vpmu_vm);
>> +	return !r;
>> +}
> 
> TBH, I don't really care much about the test probing for the event
> filter UAPI. It has been upstream for a while, and if folks are trying
> to run selftests at HEAD on an old kernel then that's their business.
> 
> The other prerequisites make more sense since they actually check if HW
> features are present.
> 
>> +static bool host_pmu_supports_events(void)
>> +{
>> +	vpmu_vm = create_vpmu_vm(guest_get_pmceid);
>> +
>> +	memset(&supported_pmce, 0, sizeof(supported_pmce));
>> +	sync_global_to_guest(vpmu_vm->vm, supported_pmce);
>> +	run_vcpu(vpmu_vm->vcpu);
>> +	sync_global_from_guest(vpmu_vm->vm, supported_pmce);
>> +	destroy_vpmu_vm(vpmu_vm);
>> +
>> +	return supported_pmce.pmceid0 & (BR_RETIRED | INST_RETIRED);
>> +}
> 
> This helper says its probing the host PMU, but you're actually firing up a
> VM to do it.
> 
> The events supported by a particular PMU instance are readily available
> in sysfs. Furthermore, you can tell KVM to select the exact host PMU
> instance you probe.
> 
>> diff --git a/tools/testing/selftests/kvm/lib/aarch64/vpmu.c b/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
>> index b3de8fdc555e..76ea03d607f1 100644
>> --- a/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
>> +++ b/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
>> @@ -7,8 +7,9 @@
>>  #include <vpmu.h>
>>  #include <perf/arm_pmuv3.h>
>>  
>> -/* Create a VM that has one vCPU with PMUv3 configured. */
>> -struct vpmu_vm *create_vpmu_vm(void *guest_code)
>> +struct vpmu_vm *__create_vpmu_vm(void *guest_code,
>> +				 void (*init_pmu)(struct vpmu_vm *vm, void *arg),
>> +				 void *arg)
>>  {
>>  	struct kvm_vcpu_init init;
>>  	uint8_t pmuver;
>> @@ -50,12 +51,21 @@ struct vpmu_vm *create_vpmu_vm(void *guest_code)
>>  		    "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pmuver);
>>  
>>  	/* Initialize vPMU */
>> +	if (init_pmu)
>> +		init_pmu(vpmu_vm, arg);
>> +
>>  	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
>>  	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
>>  
>>  	return vpmu_vm;
>>  }
>>  
>> +/* Create a VM that has one vCPU with PMUv3 configured. */
>> +struct vpmu_vm *create_vpmu_vm(void *guest_code)
>> +{
>> +	return __create_vpmu_vm(guest_code, NULL, NULL);
>> +}
>> +
> 
> Ok. This completely proves my point in the other patch. You already need
> to refactor this helper to cram in what you're trying to do. Think of
> ways to move the code that is actually common into libraries and leave
> the rest to the tests themselves.
> 
> Some slight code duplication isn't the end of the world if it avoids
> churning libraries every time someone wants to add a widget.
> 

Eric


