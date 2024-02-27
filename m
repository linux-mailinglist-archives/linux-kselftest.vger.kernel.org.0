Return-Path: <linux-kselftest+bounces-5470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ADF868831
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 05:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE5B1C21123
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 04:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42374D5A3;
	Tue, 27 Feb 2024 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5jM9w59"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54B4CDE5
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 04:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709007899; cv=none; b=DynNiRwSlN0hYtMjiK+dxyAx4YVUqBGi9xq5N01gSRvAlZHZ3PJWkMCnOcaDi6qthWCTFR6bpRLyvQq2vLJ34HohXu8cQ50xbtx4/L5dee4X5Skap/wXkDg1ttpDs4f1wZVxxA4E9F58ZoLuqCHEnpr/XMREpPcFUtlG1kytUHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709007899; c=relaxed/simple;
	bh=SAGkTvFc9MFPIj1FbE0nWxUs9VOcspJm0tS+h6honf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZggYDfhK+EqqKH7jh660euH0tVcvGNLlXD+2AxdYr/WesYA+VMx4PYFc1IssRzz7od6ozybYjoF2Qm1zsDVtme/yVAPw5eElZZVOxdSxnNtVSSOYINtIaJQKcKw/LQm5OtpOIFry7A7N4JbwGLYJ0zPpXivSbGtMcjM/fD9RQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5jM9w59; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709007896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wocaQci0H8ZTuqRVNTzwftkHm1yC6L2JcX2khIjUmVo=;
	b=O5jM9w599xNjmsV7Cb5Yv7X9l4b7S/ZV33Nz7SSQ4TqY/MprsxRgHr8b0ZXjv2Xhho26Hr
	ZzAHf4qxX8H5DMtP2HxydtKkWQ1e+1vzoSg16gDht4Ikrwm2mFojU5eDZKLU4B+pqPim2P
	s+YQKgBZWRr23zXec3B3VMyQ//DNRrk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-PxQW6LrxOt6EvPMeoi1hEQ-1; Mon, 26 Feb 2024 23:24:54 -0500
X-MC-Unique: PxQW6LrxOt6EvPMeoi1hEQ-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6dde25ac92fso1944753a34.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 20:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709007894; x=1709612694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wocaQci0H8ZTuqRVNTzwftkHm1yC6L2JcX2khIjUmVo=;
        b=D1MmectzaY8xrGUZyyMzcafImt23mJSQnWGVMqbptIKAkoELYs9jK0ThA+HyyMVh08
         9xCi4AqoocIJy71WoK1psoJaei3C84qtUm9aMTFoRVQuBWQ/fWJzmNwldV64eVc1es0g
         GGcI3Sa/kAyuZfInKkCd+vsbj7gs91vFMkA54um7CELdxeOX1p+43NMJ7WnuDjosmpK1
         KpVFLwxI1dLORkr6ilHoQdtqpOuaGhj9OHQz4biBTnN3klE3DL0bwjvujm04jTL8udhL
         hPgWHxfenzKejNNiLAzGZb7MCM5VQ0hBM87lGc0kSMieXdwRBGpszNe6RtXr9mExnoyV
         o1dw==
X-Forwarded-Encrypted: i=1; AJvYcCXAOoct3JSszpN8AC5wejbnqEXXHjhLx83F47nX3wYLegraevb7wLPFM5BmhdVvJMql3ytVuzae2cr0UEshGLjRJ+3boMf5zq+oD2FcOmqc
X-Gm-Message-State: AOJu0YxvHWbT9JfXcZL8AGEqaDUoW3yI4rhNI3ZI7zxZIcJtygVlMwIt
	R3UzL0HOOxqf9kOcO6nyeYO2FKP7x69zVV9gzSS5I6ynvjwhpnjpRWxB/mK8yWfUTFT6wDXx4O6
	nazbqFrcTql0no1JutLI4PomK7CrjlyragdpAgFd/93QWpHCtXZ6HJfA6uDUol75CDg==
X-Received: by 2002:a05:6830:1082:b0:6e4:9608:2236 with SMTP id y2-20020a056830108200b006e496082236mr6681885oto.2.1709007893802;
        Mon, 26 Feb 2024 20:24:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHj2Y8QFwZ4y+Zg/vr5e2fqBG+8Xmu2RKbf/1cLf+wVGRrCuhPJDudzJ7btoYWGhLeDdJSdg==
X-Received: by 2002:a05:6830:1082:b0:6e4:9608:2236 with SMTP id y2-20020a056830108200b006e496082236mr6681869oto.2.1709007893401;
        Mon, 26 Feb 2024 20:24:53 -0800 (PST)
Received: from [10.72.116.113] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d18-20020a639752000000b005d8e30897e4sm4006713pgo.69.2024.02.26.20.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 20:24:52 -0800 (PST)
Message-ID: <25ecc166-44be-40fb-b676-767d6da020aa@redhat.com>
Date: Tue, 27 Feb 2024 12:24:46 +0800
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
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
 Eric Auger <eauger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240202025659.5065-1-shahuang@redhat.com>
 <20240202025659.5065-5-shahuang@redhat.com> <ZbypAAFEHweTDUJK@linux.dev>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ZbypAAFEHweTDUJK@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 2/2/24 16:34, Oliver Upton wrote:
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
>>   tools/testing/selftests/kvm/Makefile          |   1 +
>>   .../kvm/aarch64/pmu_event_filter_test.c       | 219 ++++++++++++++++++
>>   .../selftests/kvm/include/aarch64/vpmu.h      |   4 +
>>   .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  14 +-
>>   4 files changed, 236 insertions(+), 2 deletions(-)
>>   create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index 709a70b31ca2..733ec86a3385 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -148,6 +148,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
>>   TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>>   TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
>>   TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
>> +TEST_GEN_PROGS_aarch64 += aarch64/pmu_event_filter_test
>>   TEST_GEN_PROGS_aarch64 += aarch64/psci_test
>>   TEST_GEN_PROGS_aarch64 += aarch64/set_id_regs
>>   TEST_GEN_PROGS_aarch64 += aarch64/smccc_filter
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

Thanks for pointing this out. I would choose pmu_common_event_ids as its 
name.

> 
>> +	uint64_t pmceid0;
>> +	uint64_t pmceid1;
>> +} supported_pmce, guest_pmce;
> 
> maybe "max_*" and "expected_*". It took me a bit to understand that
> guest_pmce feeds in your expected PMCEID values.
> 

The "max_* and "expected_*" is more clear, I would use it.

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

Sure. I would use those defined macro.

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

At here, I prepare the pmceid value which the guest should see, and pass 
it to the guest by sync the global variable. And guest compare this 
value with the value it read through pmu common event register.

Why I don't put the process of generating expected_pmce into the guest 
code is that I want to make sure this value computed in host is totally 
correct, so the guest code is pretty simple, it only needs to compare 
the two value.

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

Ok. I can change it to pr_info().

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

It's more clear and readable, thanks for your advice. I will change the 
array definition to the beautiful format.

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

Ok. Will call it run_tests().

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

If no one cares it, I will delete this function.

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

It should call kvm_pmu_support_events, because I want to get the default 
pmce without any filter in the kvm. So I run a guest and get that value 
in the guest.

I've tried get the pmceid0 through the

vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_PMCEID0_EL0), &val);

But it always return the -ENOENT, I'm not sure if this is expected. 
Could I can use the KVM interface to get the pmceid0?

> 
>> diff --git a/tools/testing/selftests/kvm/lib/aarch64/vpmu.c b/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
>> index b3de8fdc555e..76ea03d607f1 100644
>> --- a/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
>> +++ b/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
>> @@ -7,8 +7,9 @@
>>   #include <vpmu.h>
>>   #include <perf/arm_pmuv3.h>
>>   
>> -/* Create a VM that has one vCPU with PMUv3 configured. */
>> -struct vpmu_vm *create_vpmu_vm(void *guest_code)
>> +struct vpmu_vm *__create_vpmu_vm(void *guest_code,
>> +				 void (*init_pmu)(struct vpmu_vm *vm, void *arg),
>> +				 void *arg)
>>   {
>>   	struct kvm_vcpu_init init;
>>   	uint8_t pmuver;
>> @@ -50,12 +51,21 @@ struct vpmu_vm *create_vpmu_vm(void *guest_code)
>>   		    "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pmuver);
>>   
>>   	/* Initialize vPMU */
>> +	if (init_pmu)
>> +		init_pmu(vpmu_vm, arg);
>> +
>>   	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
>>   	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
>>   
>>   	return vpmu_vm;
>>   }
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

Thanks for your opinion. I'm thinking about refactor the helper to make 
it can be reuseable by further tests.

Thanks,
Shaoqin

> 

-- 
Shaoqin


