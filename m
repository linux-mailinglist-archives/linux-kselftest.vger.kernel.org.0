Return-Path: <linux-kselftest+bounces-9771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC54E8C0C01
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 09:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA801C213DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 07:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF7013CF8A;
	Thu,  9 May 2024 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZ1PPmmd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED0D1487C4
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240077; cv=none; b=XTSy1wMErglrqNtN/H+PM7AGt+CbtMq/SG8rdzgGBMhUPV2XBMEvWFT6iM5VmhWlZAHI473GtAc7dkXFlzHP6ILv6Ki+VAStPDUJJhqzXG8fbMCRSmmM/tiMazoveFVwsaJAiYs6kd1oHTCLpwnnyeJxQ5kCzFcUNUsJLFhGa2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240077; c=relaxed/simple;
	bh=Ql073AT/LBTOS6xuC597/sHYu6Z8Z1Jwpgk46IvSu0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2GkwgVo29NaDNGnyZvO+5NqN0HJojnsW8HY8JxAYupSS3nraoSMO8CwgvvAvYRBSYgle7fz08C94UwoGYQ7ABx6LU9kTCAlEFhUr7VrfhxP+r2GBFWzFDHKFinmnpEUUG9fy0oAIyOYHL58OBkVoiS8houb4q2zT+FcU6cVVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZ1PPmmd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715240074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZzTdtZTg4X5rVAi3OPHx73IgpVVyO5kzJim7kMw5CM=;
	b=cZ1PPmmdZUE9sbHnGxxccczZ6hsrFWMICsn/Qy+b2LJer/5/O9ojIEyLvsryLpWz62BWv8
	vDdMXDPoaY0Oy8xee0OECYFbcnc1MRj0EYdXYS+jpr1mwudSdV25oWXkS2UBF6B3kgJq7r
	X8LwxaorXYnR4tU9npGqPFgoR7lvvhY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-_gTxEKONN5Kp7EmrSKOEAQ-1; Thu, 09 May 2024 03:34:32 -0400
X-MC-Unique: _gTxEKONN5Kp7EmrSKOEAQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b52fdaf766so214571a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 00:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715240071; x=1715844871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZzTdtZTg4X5rVAi3OPHx73IgpVVyO5kzJim7kMw5CM=;
        b=Tk+RtCKMd5cBKURF2duPVZbhCx/6n2RjAEBeqWvRIwVSvLoz4mURYWTp8Ns/m4zlyF
         IkxONm1Alq/vpZVAl8uRcg8rwZ4ax5S8ByBr7WcyhQWjUAV7lCmeFyKkwHIfcSP9/Yl1
         d7HcjBVmevbMFmBy6qe8m8d9/8AmgxlxS/REtg+owRNci3+NcBHOe1ZuYJxC6i3TVSHr
         avcSdmpz7o1mxk6vLOOYheZWNzyuoZjOFzXzpVsRirCcPXQqqaBaXTNNmXN3/dmbbQ1z
         p0tyy8Q0mHPwAa9MjBSaU2FMEDGSAWCmZXemy6GnOeKI5TZkWNkYMT0mFLn+sVVkibxM
         oFig==
X-Forwarded-Encrypted: i=1; AJvYcCVv32eEvjq0WzS65eka2ted8hKD7lAUqcKcUQAlMu4GJHtSR9ZFmEDBdSDOhywxwh/BdWbI6zl8vHg1Mt0xgknIF8EpegJENqhiQzfltDje
X-Gm-Message-State: AOJu0YybGDL57giyJe6xg9XHXV8sCykFVqlmemtZIwUbQ5LKVPfTFglp
	kg0INXawT2eMngWV32H3qmL8vNAX6LQyDPCKD84+e//x1nae2R3gdHrsHGC76ZOkO42J+n0LQ+q
	nNGwRJ4PPQOZinA2lPScFfHHaXmXOVbGzsJ6g1assjOOVp2ZRz+wXKuuRc42vGXNYAA==
X-Received: by 2002:a05:6a00:660f:b0:6ed:6944:b170 with SMTP id d2e1a72fcca58-6f49c1f4789mr5056171b3a.1.1715240071248;
        Thu, 09 May 2024 00:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETnKbEhQdah6mLAjO98A7KonaR0MZRYHoP3BQ3HzQIKW7cXeV9np1lDS1+HQQm51z1azrEww==
X-Received: by 2002:a05:6a00:660f:b0:6ed:6944:b170 with SMTP id d2e1a72fcca58-6f49c1f4789mr5056158b3a.1.1715240070786;
        Thu, 09 May 2024 00:34:30 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a828d5sm709849b3a.62.2024.05.09.00.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 00:34:30 -0700 (PDT)
Message-ID: <b468421e-e453-42c7-9fee-21252ceaf4c2@redhat.com>
Date: Thu, 9 May 2024 15:34:25 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] KVM: selftests: aarch64: Introduce
 pmu_event_filter_test
To: Eric Auger <eauger@redhat.com>, Oliver Upton <oliver.upton@linux.dev>,
 Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240409030320.182591-1-shahuang@redhat.com>
 <20240409030320.182591-3-shahuang@redhat.com>
 <acbc717e-5f7b-405b-9674-e03d315726cb@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <acbc717e-5f7b-405b-9674-e03d315726cb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eric,

On 5/7/24 16:45, Eric Auger wrote:
> Hi Shaoqin,
> 
> On 4/9/24 05:03, Shaoqin Huang wrote:
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
>>   .../kvm/aarch64/pmu_event_filter_test.c       | 298 ++++++++++++++++++
>>   2 files changed, 299 insertions(+)
>>   create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index 741c7dc16afc..9745be534df3 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -151,6 +151,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/aarch32_id_regs
>>   TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>>   TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
>>   TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
>> +TEST_GEN_PROGS_aarch64 += aarch64/pmu_event_filter_test
>>   TEST_GEN_PROGS_aarch64 += aarch64/psci_test
>>   TEST_GEN_PROGS_aarch64 += aarch64/set_id_regs
>>   TEST_GEN_PROGS_aarch64 += aarch64/smccc_filter
>> diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>> new file mode 100644
>> index 000000000000..972384e81067
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>> @@ -0,0 +1,298 @@
>> +
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * pmu_event_filter_test - Test user limit pmu event for guest.
>> + *
>> + * Copyright (c) 2023 Red Hat, Inc.> + *
>> + * This test checks if the guest only see the limited pmu event that userspace> + * sets, if the guest can use those events which user allow, and if
> the guest
>> + * can't use those events which user deny.
>> + * This test runs only when KVM_CAP_ARM_PMU_V3, KVM_ARM_VCPU_PMU_V3_FILTER> + * is supported on the host.
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
>> +	int i;
>> +
>> +	while (filter && filter->nevents != 0) {
>> +		if (first_filter) {
>> +			if (filter->action == KVM_PMU_EVENT_ALLOW)
>> +				memset(&pmce_mask, 0, sizeof(pmce_mask));
>> +			first_filter = false;
>> +		}
>> +
>> +		for (i = 0; i < filter->nevents; i++)
>> +			set_pmce(&pmce_mask, filter->action,
>> +				 filter->base_event + i);
>> +
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
> in v4 Oliver suggested "Shouldn't a standardized layout of the GIC
> frames go with the rest of the GIC stuff?"
> 

Oliver replied there is another commits did that, so I will remove them 
when I update it.

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
>> +			DEFINE_FILTERShouldn't a standardized layout of the GIC frames go with the rest of
> the GIC stuff?(ARMV8_PMUV3_PERFCTR_BR_RETIRED, 1),
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
>> +		.name = "cancel_filter",
>> +		.filter = {
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 0),
>> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 1),
>> +		},
>> +	},
>> +	{
>> +		.name = "multiple_filter",
>> +		.filter = {
>> +			__DEFINE_FILTER(0x0, 0x10, 0),
>> +			__DEFINE_FILTER(0x6, 0x3, 1),
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
> those are not bit masks but bit shifts. Also don't you want to test that
> all of them are supported?

Thanks for catching this bug. Yes I want to test all of them are 
supported but wrongly checking the bit masks. I will fix them.

> 
> BR_RETIRED is 0x21 so doesn't it belong to pmceid1?

Yes, it should belong to pmceid1. But my wrong checking didn't help me 
find it. Thanks a lot.

> 
> 
> in v4 Oliver suggested to use sysfs instead of spawning a scratch VM.

In that version I changed to function name to kvm_pmu_support_events, 
which means I want to detect what the KVM supports about the PMU events 
rather than the host supportted PMU events. I think that would be more 
suitable if we test KVM.

Thanks,
Shaoqin

>> +}
>> +
>> +int main(void)
>> +{
>> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
>> +	TEST_REQUIRE(kvm_pmu_support_events());
>> +
>> +	run_tests();
>> +}
> Eric
> 

-- 
Shaoqin


