Return-Path: <linux-kselftest+bounces-6603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F3F88B7F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 04:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172432C68CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 03:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E82712882E;
	Tue, 26 Mar 2024 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caqx9N2y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DC9128387
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422426; cv=none; b=qqC6iY9W4uazBvuN6CWDGBw8Hb4i/+hRXG3FAYpXGVH44M2gIFTIOejQdjXyyjLI0D3N9HVOEKBTkm2JRD5tdgh9HqiGgq/vXmirUjNMe3FWLXMlir0I6B/qJNYQKlg9s7ajcWL8rkrsHntCpx5D38po5ZwBowRl+AfbECXuRo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422426; c=relaxed/simple;
	bh=h7tTHEqM/oZJa3VtPDp2V0DRXCezN13ovLSpp9qki5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/aswqf8FEzoyVgyaM8VEJqdk9mTaQhFVc5FDJ9n6+VnpusSs35yzKH2b6AHOTWoFISM8IR9A5swmRmFxcI1pyVYV/ARJE6X+TRQLKVyEmB3mjW9OE0H2lptOdaJS9jU7D9riBGzUGLv0gqGzm1/qP5+MmRT/hAvgGx8YbS6P4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=caqx9N2y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711422423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67Jo/lgPJUa+zA9HXgb7lc+DG5Sux8xUHa8dy/dKtZo=;
	b=caqx9N2yox8CsP+G7OweQk2V4xdhFNmgP2imqndXRRvUOaxvZpkiP1bySUlVuhAQmPPBkS
	dvVSg+QpsYrQyU4HyuOtukpdxESijhhAEhSmXL9qbDefoEx2l7wyVqAU/NPpH4v826DkA3
	Q+DaYOxs96IA4AKN1ZKyLo0/p9GRvaQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-UVyaUB1OOUGUHj4MBiupzQ-1; Mon, 25 Mar 2024 23:06:59 -0400
X-MC-Unique: UVyaUB1OOUGUHj4MBiupzQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e05294f153so15531915ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 20:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711422418; x=1712027218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67Jo/lgPJUa+zA9HXgb7lc+DG5Sux8xUHa8dy/dKtZo=;
        b=omRTNnYz+bl00wEmRJZ6fQP3SWahDLhguUFLY25E0kM7P4oUgCEl9SK7CxZTWOlGmb
         8zZKrsJaKvm3dvTN1AWXlbx4vTNe+wcGPktyeMCKtD/I+14bIkrEQxadYxML2+4luTEr
         /V56rQ6aywnwnaP861pry2Ck/fV6/nEiUMaYYAhOaHeIda/OIIqhD74B41+XZR77Dqmf
         6WlKEvC28qx4qdR3neCmRqVAIN+G37VafhMxfwkyy/NFeKg2wvgyyTBU8tjbJwunM4Vf
         /yF5DOlL1cRaMzw5k8p+cQWEPy7bx0yIlBsrF25sRM519Bar6+3cNCHUA8xFg+i+ZL1+
         ULGg==
X-Forwarded-Encrypted: i=1; AJvYcCVxO1UpWJv1nQGVvgzsIqwcfmGTShUItGqHCansxOCaNRqoIi89i8GwTeMuTYBzyo5lLpfPC03GHN5sxfoogo9wNQP9SBTN8J9YjKhQjENM
X-Gm-Message-State: AOJu0Yx74yiSeNsCISFgTFMPI+5sIbXhrnbU1H1GSxX+5KL7skT4eccB
	r1bz/kfkbnntD7QQG1ruyUSkvYX1/vEChB7TiYl1H6NO9P2IV4relL8fBy4s6JABEH9/3Yq51Zf
	mpkNbfE4TOjn49HZslaWZhmYEPbqKpsY9GvD2vzgwSkKJIqi2AkI/gMzRcwWXbFKELQ==
X-Received: by 2002:a17:90a:9f8b:b0:29b:fab2:8a24 with SMTP id o11-20020a17090a9f8b00b0029bfab28a24mr7545247pjp.3.1711422418568;
        Mon, 25 Mar 2024 20:06:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzYPE154TnKQjG+5j2iS6oEUoJWuB0IZJ5Nz8JUCsS7TLN7g5GhLLlgtwKCR9abpPqQIGuNw==
X-Received: by 2002:a17:90a:9f8b:b0:29b:fab2:8a24 with SMTP id o11-20020a17090a9f8b00b0029bfab28a24mr7545230pjp.3.1711422418118;
        Mon, 25 Mar 2024 20:06:58 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090ab38c00b0029c2a7e8338sm7126238pjr.31.2024.03.25.20.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 20:06:57 -0700 (PDT)
Message-ID: <76f1e34b-be89-490f-beab-998e5c20a0e2@redhat.com>
Date: Tue, 26 Mar 2024 11:06:53 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] KVM: selftests: aarch64: Introduce
 pmu_event_filter_test
Content-Language: en-US
To: Eric Auger <eauger@redhat.com>, Oliver Upton <oliver.upton@linux.dev>,
 Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240229065625.114207-1-shahuang@redhat.com>
 <20240229065625.114207-3-shahuang@redhat.com>
 <f003ce3e-12d0-42fd-84a9-ebb3baac3860@redhat.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <f003ce3e-12d0-42fd-84a9-ebb3baac3860@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eric,

Thanks for your review.

On 3/20/24 04:58, Eric Auger wrote:
> Hi Shaoqin,
> 
> On 2/29/24 07:56, Shaoqin Huang wrote:
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
>>   .../kvm/aarch64/pmu_event_filter_test.c       | 287 ++++++++++++++++++
>>   2 files changed, 288 insertions(+)
>>   create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index 492e937fab00..732ca5f8bfc0 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -147,6 +147,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
>>   TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>>   TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
>>   TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
>> +TEST_GEN_PROGS_aarch64 += aarch64/pmu_event_filter_test
>>   TEST_GEN_PROGS_aarch64 += aarch64/psci_test
>>   TEST_GEN_PROGS_aarch64 += aarch64/set_id_regs
>>   TEST_GEN_PROGS_aarch64 += aarch64/smccc_filter
>> diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>> new file mode 100644
>> index 000000000000..2dd8ea418f47
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>> @@ -0,0 +1,287 @@
>> +
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
>> +struct pmu_common_event_ids {
>> +	uint64_t pmceid0;
>> +	uint64_t pmceid1;
>> +} max_pmce, expected_pmce;
>> +
>> +struct vpmu_vm {
>> +	struct kvm_vm *vm;
>> +	struct kvm_vcpu *vcpu;
>> +	int gic_fd;
>> +};
>> +
>> +static struct vpmu_vm vpmu_vm;
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
>> +static void guest_code(void)
>> +{
>> +	uint64_t pmceid0 = read_sysreg(pmceid0_el0);
>> +	uint64_t pmceid1 = read_sysreg(pmceid1_el0);
>> +
>> +	GUEST_ASSERT_EQ(expected_pmce.pmceid0, pmceid0);
>> +	GUEST_ASSERT_EQ(expected_pmce.pmceid1, pmceid1);
>> +
>> +	GUEST_DONE();
>> +}
>> +
>> +static void guest_get_pmceid(void)
>> +{
>> +	max_pmce.pmceid0 = read_sysreg(pmceid0_el0);
>> +	max_pmce.pmceid1 = read_sysreg(pmceid1_el0);
>> +
>> +	GUEST_DONE();
>> +}
>> +
>> +static void run_vcpu(struct kvm_vcpu *vcpu)
>> +{
>> +	struct ucall uc;
>> +
>> +	while (1) {
>> +		vcpu_run(vcpu);
>> +		switch (get_ucall(vcpu, &uc)) {
>> +		case UCALL_DONE:
>> +			return;
>> +		case UCALL_ABORT:
>> +			REPORT_GUEST_ASSERT(uc);
>> +			break;
>> +		default:
>> +			TEST_FAIL("Unknown ucall %lu", uc.cmd);
>> +		}
>> +	}
>> +}
>> +
>> +static void set_pmce(struct pmu_common_event_ids *pmce, int action, int event)
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
>> +static void prepare_expected_pmce(struct kvm_pmu_event_filter *filter)
>> +{
>> +	struct pmu_common_event_ids pmce_mask = { ~0, ~0 };
>> +	bool first_filter = true;
>> +
>> +	while (filter && filter->nevents != 0) {
> isn't filter->nevents != 0 sufficient?

No. Because the filter might be NULL.

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
>> +	expected_pmce.pmceid0 = max_pmce.pmceid0 & pmce_mask.pmceid0;
>> +	expected_pmce.pmceid1 = max_pmce.pmceid1 & pmce_mask.pmceid1;
>> +}
>> +
>> +static void pmu_event_filter_init(struct kvm_pmu_event_filter *filter)
>> +{
>> +	while (filter && filter->nevents != 0) {
>> +		kvm_device_attr_set(vpmu_vm.vcpu->fd,
>> +				    KVM_ARM_VCPU_PMU_V3_CTRL,
>> +				    KVM_ARM_VCPU_PMU_V3_FILTER,
>> +				    filter);
>> +		filter++;
>> +	}
>> +}
>> +
>> +#define GICD_BASE_GPA	0x8000000ULL
>> +#define GICR_BASE_GPA	0x80A0000ULL
> I think Oliver suggested to move those defines to GIC headers?

There is another patch[1] which move those definition to the GIC 
headers, but it hasn't been merged.

[1]https://lore.kernel.org/all/20240307183907.1184775-2-coltonlewis@google.com/

>> +
>> +/* Create a VM that has one vCPU with PMUv3 configured. */
>> +static void create_vpmu_vm_with_filter(void *guest_code,
>> +				       struct kvm_pmu_event_filter *filter)
>> +{
>> +	uint64_t irq = 23;
>> +
>> +	/* The test creates the vpmu_vm multiple times. Ensure a clean state */
>> +	memset(&vpmu_vm, 0, sizeof(vpmu_vm));
>> +
>> +	vpmu_vm.vm = vm_create(1);
>> +	vpmu_vm.vcpu = vm_vcpu_add_with_vpmu(vpmu_vm.vm, 0, guest_code);
>> +	vpmu_vm.gic_fd = vgic_v3_setup(vpmu_vm.vm, 1, 64,
>> +					GICD_BASE_GPA, GICR_BASE_GPA);
>> +	__TEST_REQUIRE(vpmu_vm.gic_fd >= 0,
>> +		       "Failed to create vgic-v3, skipping");
>> +
>> +	pmu_event_filter_init(filter);
>> +
>> +	/* Initialize vPMU */
>> +	vpmu_set_irq(vpmu_vm.vcpu, irq);
>> +	vpmu_init(vpmu_vm.vcpu);
>> +}
>> +
>> +static void create_vpmu_vm(void *guest_code)
>> +{
>> +	create_vpmu_vm_with_filter(guest_code, NULL);
>> +}
>> +
>> +static void destroy_vpmu_vm(void)
>> +{
>> +	close(vpmu_vm.gic_fd);
>> +	kvm_vm_free(vpmu_vm.vm);
>> +}
>> +
>> +static void run_test(struct test_desc *t)
>> +{
>> +	pr_info("Test: %s\n", t->name);
>> +
>> +	create_vpmu_vm_with_filter(guest_code, t->filter);
>> +	prepare_expected_pmce(t->filter);
>> +	sync_global_to_guest(vpmu_vm.vm, expected_pmce);
>> +
>> +	run_vcpu(vpmu_vm.vcpu);
>> +
>> +	destroy_vpmu_vm();
>> +}
>> +
>> +static struct test_desc tests[] = {
>> +	{
>> +		.name = "without_filter",
>> +		.filter = {
>> +			{ 0 }
>> +		},
>> +	},
>> +	{
>> +		.name = "member_allow_filter",
>> +		.filter = {
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 0),
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_INST_RETIRED, 0),
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_BR_RETIRED, 0),
>> +			{ 0 },
>> +		},
>> +	},
>> +	{
>> +		.name = "member_deny_filter",
>> +		.filter = {
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 1),
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_INST_RETIRED, 1),
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_BR_RETIRED, 1),
>> +			{ 0 },
>> +		},
>> +	},
>> +	{
>> +		.name = "not_member_deny_filter",
>> +		.filter = {
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 1),
>> +			{ 0 },
>> +		},
>> +	},
>> +	{
>> +		.name = "not_member_allow_filter",
>> +		.filter = {
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 0),
>> +			{ 0 },
>> +		},
>> +	},
>> +	{
>> +		.name = "deny_chain_filter",
>> +		.filter = {
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CHAIN, 1),
>> +			{ 0 },
>> +		},
>> +	},
>> +	{
>> +		.name = "deny_cpu_cycles_filter",
>> +		.filter = {
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 1),
>> +			{ 0 },
>> +		},
>> +	},
>> +	{
>> +		.name = "cancle_filter",
> cancel

Thanks for catching it.

>> +		.filter = {
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 0),
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 1),
>> +		},
>> +	},
>> +	{ 0 }
>> +};
>> +
>> +static void run_tests(void)
>> +{
>> +	struct test_desc *t;
>> +
>> +	for (t = &tests[0]; t->name; t++)
>> +		run_test(t);
>> +}
>> +
>> +static bool kvm_pmu_support_events(void)
>> +{
>> +	create_vpmu_vm(guest_get_pmceid);
>> +
>> +	memset(&max_pmce, 0, sizeof(max_pmce));
>> +	sync_global_to_guest(vpmu_vm.vm, max_pmce);
>> +	run_vcpu(vpmu_vm.vcpu);
>> +	sync_global_from_guest(vpmu_vm.vm, max_pmce);
>> +	destroy_vpmu_vm();
>> +
>> +	return max_pmce.pmceid0 &
>> +	       (ARMV8_PMUV3_PERFCTR_BR_RETIRED |
>> +	       ARMV8_PMUV3_PERFCTR_INST_RETIRED |
>> +	       ARMV8_PMUV3_PERFCTR_CHAIN);
> I understood Oliver suggested to use sysfs to know if te events were
> supported and to use KVM_ARM_VCPU_PMU_V3_SET_PMU. On my end I am fine
> with your method though.
> 

I think get the supported pmu events from KVM is better than get the 
host supported pmu events even they are the same currently.

Thanks,
Shaoqin

> Thanks
> 
> Eric
>> +}
>> +
>> +int main(void)
>> +{
>> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
>> +	TEST_REQUIRE(kvm_pmu_support_events());
>> +
>> +	run_tests();
>> +}
> 

-- 
Shaoqin


