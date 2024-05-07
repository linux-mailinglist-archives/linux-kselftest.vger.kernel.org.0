Return-Path: <linux-kselftest+bounces-9581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E738BDD70
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 10:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213F21F2186F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 08:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C4314D44D;
	Tue,  7 May 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJdMyWKK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E914D2BD
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071535; cv=none; b=mlFEq6aZ3329CpkTuU1l+upDXokM0DuRk+diuKKD4maMUXT2JGlCcAq4jmckRHv+e6vHh/sbPmhL8lnUcEJCn7thIu5bee/DtGyNXvDrHJOQL9gZoBFcFv8K2CZig+vJRPEsUJYN8+SNZD2BAuWOvwIBE/2GNy1waj3CEpUtW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071535; c=relaxed/simple;
	bh=Wd/DgNGPbiMtBuAX7H5j/Z8F2ILgRj3NdeU/NgDMW2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvGXy8DZsyieJUEHmmEKrr2Z4g3MFjQcRif2Pzm2ev3gJqoa38O4O+vXrfBASVxNYcb7o3u2VKRk3c54QjDMj+BqCkQZBRJcJN09GOHgYVg+HuJx6PDPKxBx+qDWwneS9R6aRutHHBI0JMBCi2nWkDifXjnhnSBvMJCuACZLcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJdMyWKK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715071532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrNg/I73qStEB69VLnS4sHpoJ+U3TC5N5tjxufpLDoc=;
	b=BJdMyWKKE5dhLESMnlCgL9aoADTezM4iCsqEhhlyygYafDxG4fQMlla1geqzqmUeazOgTu
	aqzK6gTXQw/RyCQ1LjmIy5SKX5Fdj+xlt6YEbvmllS+T5zG2d28NZ3pD+MI8KVoLEPBOHE
	/qANLVnkboIpS/30Lhc18f9alVpodug=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-klWgOVjXPPWQkeDffNw97w-1; Tue, 07 May 2024 04:45:30 -0400
X-MC-Unique: klWgOVjXPPWQkeDffNw97w-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79299e0c059so243917185a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 May 2024 01:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715071529; x=1715676329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrNg/I73qStEB69VLnS4sHpoJ+U3TC5N5tjxufpLDoc=;
        b=DWqWUFF4JyBik6gm4FrjAP/NpZF20cMA+T6DkzJZRlEdiypCnhl7/kIZc5CHTxCeGJ
         1UwDpvqoeAqrtbhteo+nQ7mNHI0dc3bCReQRh+hpR4YIKoLpWbZ+hnk9G+UI1ob/KOSB
         0+of1aZWVoCA+lT1IghAiyyLKGnd+7rQf3kCTLKxHvqlR8mxLTNWqTez8J7XUMmywg4l
         Hp+kxEjG0nOpnZLKhCyjE4vypiHS3wLRg3Znmk+7OT01HrxkTTzbBYySIw2F4BbXTxnh
         GOoj02dt2Ms317FpvxgKbH5MCLooOGhc6QtOQlZkkn9mDbmFd862sMZTPZ+ypk3jlh9n
         Kzzg==
X-Forwarded-Encrypted: i=1; AJvYcCXHtUmP2YU/CZoPk3IhglQVu8DAPUnQOnaz6/wmMFHbt6gx/UCoHTpPx7176viey4ZpBEMO+ow8FzK9UlBX8c3tXInonGhpi++mWc0Dhl9q
X-Gm-Message-State: AOJu0YwCrMc88R+VAt4woVlZAWcD0UXuaydp6YSgz8JSsr3bKZh971dp
	xstaAxjJHYtrlU3fUTloylgGovdUgfF2VtnZ/PqEj55FI3RkIDK81lxbnKyPO6wp5/Yhv7h7INh
	8ldLd1HweMPz4MYpJDCVLovHmKfwMl/gDQHQI/G7i2p/7jxy8Ksv5cM9QW/bdqd1lRA==
X-Received: by 2002:a05:620a:13ec:b0:792:9d45:e2f9 with SMTP id h12-20020a05620a13ec00b007929d45e2f9mr3727006qkl.32.1715071529382;
        Tue, 07 May 2024 01:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExnBUzVZEURtv9sE2D6uzisLrJGEfFs4dgUGwPTPMI+pElwNSM9WbHpiBi4QYcpxxfv4vMbg==
X-Received: by 2002:a05:620a:13ec:b0:792:9d45:e2f9 with SMTP id h12-20020a05620a13ec00b007929d45e2f9mr3726994qkl.32.1715071529009;
        Tue, 07 May 2024 01:45:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id l26-20020a05620a0c1a00b007929535435bsm2151439qki.110.2024.05.07.01.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 01:45:28 -0700 (PDT)
Message-ID: <acbc717e-5f7b-405b-9674-e03d315726cb@redhat.com>
Date: Tue, 7 May 2024 10:45:24 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] KVM: selftests: aarch64: Introduce
 pmu_event_filter_test
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, Oliver Upton
 <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.linux.dev
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240409030320.182591-1-shahuang@redhat.com>
 <20240409030320.182591-3-shahuang@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240409030320.182591-3-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaoqin,

On 4/9/24 05:03, Shaoqin Huang wrote:
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
>  .../kvm/aarch64/pmu_event_filter_test.c       | 298 ++++++++++++++++++
>  2 files changed, 299 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 741c7dc16afc..9745be534df3 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -151,6 +151,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/aarch32_id_regs
>  TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>  TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
>  TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
> +TEST_GEN_PROGS_aarch64 += aarch64/pmu_event_filter_test
>  TEST_GEN_PROGS_aarch64 += aarch64/psci_test
>  TEST_GEN_PROGS_aarch64 += aarch64/set_id_regs
>  TEST_GEN_PROGS_aarch64 += aarch64/smccc_filter
> diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> new file mode 100644
> index 000000000000..972384e81067
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> @@ -0,0 +1,298 @@
> +
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pmu_event_filter_test - Test user limit pmu event for guest.
> + *
> + * Copyright (c) 2023 Red Hat, Inc.> + *
> + * This test checks if the guest only see the limited pmu event that userspace> + * sets, if the guest can use those events which user allow, and if
the guest
> + * can't use those events which user deny.
> + * This test runs only when KVM_CAP_ARM_PMU_V3, KVM_ARM_VCPU_PMU_V3_FILTER> + * is supported on the host.
> + */
> +#include <kvm_util.h>
> +#include <processor.h>
> +#include <vgic.h>
> +#include <vpmu.h>
> +#include <test_util.h>
> +#include <perf/arm_pmuv3.h>
> +
> +struct pmu_common_event_ids {
> +	uint64_t pmceid0;
> +	uint64_t pmceid1;
> +} max_pmce, expected_pmce;
> +
> +struct vpmu_vm {
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +	int gic_fd;
> +};
> +
> +static struct vpmu_vm vpmu_vm;
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
> +static void guest_code(void)
> +{
> +	uint64_t pmceid0 = read_sysreg(pmceid0_el0);
> +	uint64_t pmceid1 = read_sysreg(pmceid1_el0);
> +
> +	GUEST_ASSERT_EQ(expected_pmce.pmceid0, pmceid0);
> +	GUEST_ASSERT_EQ(expected_pmce.pmceid1, pmceid1);
> +
> +	GUEST_DONE();
> +}
> +
> +static void guest_get_pmceid(void)
> +{
> +	max_pmce.pmceid0 = read_sysreg(pmceid0_el0);
> +	max_pmce.pmceid1 = read_sysreg(pmceid1_el0);
> +
> +	GUEST_DONE();
> +}
> +
> +static void run_vcpu(struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +
> +	while (1) {
> +		vcpu_run(vcpu);
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_DONE:
> +			return;
> +		case UCALL_ABORT:
> +			REPORT_GUEST_ASSERT(uc);
> +			break;
> +		default:
> +			TEST_FAIL("Unknown ucall %lu", uc.cmd);
> +		}
> +	}
> +}
> +
> +static void set_pmce(struct pmu_common_event_ids *pmce, int action, int event)
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
> +static void prepare_expected_pmce(struct kvm_pmu_event_filter *filter)
> +{
> +	struct pmu_common_event_ids pmce_mask = { ~0, ~0 };
> +	bool first_filter = true;
> +	int i;
> +
> +	while (filter && filter->nevents != 0) {
> +		if (first_filter) {
> +			if (filter->action == KVM_PMU_EVENT_ALLOW)
> +				memset(&pmce_mask, 0, sizeof(pmce_mask));
> +			first_filter = false;
> +		}
> +
> +		for (i = 0; i < filter->nevents; i++)
> +			set_pmce(&pmce_mask, filter->action,
> +				 filter->base_event + i);
> +
> +		filter++;
> +	}
> +
> +	expected_pmce.pmceid0 = max_pmce.pmceid0 & pmce_mask.pmceid0;
> +	expected_pmce.pmceid1 = max_pmce.pmceid1 & pmce_mask.pmceid1;
> +}
> +
> +static void pmu_event_filter_init(struct kvm_pmu_event_filter *filter)
> +{
> +	while (filter && filter->nevents != 0) {
> +		kvm_device_attr_set(vpmu_vm.vcpu->fd,
> +				    KVM_ARM_VCPU_PMU_V3_CTRL,
> +				    KVM_ARM_VCPU_PMU_V3_FILTER,
> +				    filter);
> +		filter++;
> +	}
> +}
> +
> +#define GICD_BASE_GPA	0x8000000ULL
> +#define GICR_BASE_GPA	0x80A0000ULL
in v4 Oliver suggested "Shouldn't a standardized layout of the GIC
frames go with the rest of the GIC stuff?"

> +
> +/* Create a VM that has one vCPU with PMUv3 configured. */
> +static void create_vpmu_vm_with_filter(void *guest_code,
> +				       struct kvm_pmu_event_filter *filter)
> +{
> +	uint64_t irq = 23;
> +
> +	/* The test creates the vpmu_vm multiple times. Ensure a clean state */
> +	memset(&vpmu_vm, 0, sizeof(vpmu_vm));
> +
> +	vpmu_vm.vm = vm_create(1);
> +	vpmu_vm.vcpu = vm_vcpu_add_with_vpmu(vpmu_vm.vm, 0, guest_code);
> +	vpmu_vm.gic_fd = vgic_v3_setup(vpmu_vm.vm, 1, 64,
> +					GICD_BASE_GPA, GICR_BASE_GPA);
> +	__TEST_REQUIRE(vpmu_vm.gic_fd >= 0,
> +		       "Failed to create vgic-v3, skipping");
> +
> +	pmu_event_filter_init(filter);
> +
> +	/* Initialize vPMU */
> +	vpmu_set_irq(vpmu_vm.vcpu, irq);
> +	vpmu_init(vpmu_vm.vcpu);
> +}
> +
> +static void create_vpmu_vm(void *guest_code)
> +{
> +	create_vpmu_vm_with_filter(guest_code, NULL);
> +}
> +
> +static void destroy_vpmu_vm(void)
> +{
> +	close(vpmu_vm.gic_fd);
> +	kvm_vm_free(vpmu_vm.vm);
> +}
> +
> +static void run_test(struct test_desc *t)
> +{
> +	pr_info("Test: %s\n", t->name);
> +
> +	create_vpmu_vm_with_filter(guest_code, t->filter);
> +	prepare_expected_pmce(t->filter);
> +	sync_global_to_guest(vpmu_vm.vm, expected_pmce);
> +
> +	run_vcpu(vpmu_vm.vcpu);
> +
> +	destroy_vpmu_vm();
> +}
> +
> +static struct test_desc tests[] = {
> +	{
> +		.name = "without_filter",
> +		.filter = {
> +			{ 0 }
> +		},
> +	},
> +	{
> +		.name = "member_allow_filter",
> +		.filter = {
> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 0),
> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_INST_RETIRED, 0),
> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_BR_RETIRED, 0),
> +			{ 0 },
> +		},
> +	},
> +	{
> +		.name = "member_deny_filter",
> +		.filter = {
> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 1),
> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_INST_RETIRED, 1),
> +			DEFINE_FILTERShouldn't a standardized layout of the GIC frames go with the rest of
the GIC stuff?(ARMV8_PMUV3_PERFCTR_BR_RETIRED, 1),
> +			{ 0 },
> +		},
> +	},
> +	{
> +		.name = "not_member_deny_filter",
> +		.filter = {
> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 1),
> +			{ 0 },
> +		},
> +	},
> +	{
> +		.name = "not_member_allow_filter",
> +		.filter = {
> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 0),
> +			{ 0 },
> +		},
> +	},
> +	{
> +		.name = "deny_chain_filter",
> +		.filter = {
> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CHAIN, 1),
> +			{ 0 },
> +		},
> +	},
> +	{
> +		.name = "deny_cpu_cycles_filter",
> +		.filter = {
> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 1),
> +			{ 0 },
> +		},
> +	},
> +	{
> +		.name = "cancel_filter",
> +		.filter = {
> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 0),
> +			DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 1),
> +		},
> +	},
> +	{
> +		.name = "multiple_filter",
> +		.filter = {
> +			__DEFINE_FILTER(0x0, 0x10, 0),
> +			__DEFINE_FILTER(0x6, 0x3, 1),
> +		},
> +	},
> +	{ 0 }
> +};
> +
> +static void run_tests(void)
> +{
> +	struct test_desc *t;
> +
> +	for (t = &tests[0]; t->name; t++)
> +		run_test(t);
> +}
> +
> +static bool kvm_pmu_support_events(void)
> +{
> +	create_vpmu_vm(guest_get_pmceid);
> +
> +	memset(&max_pmce, 0, sizeof(max_pmce));
> +	sync_global_to_guest(vpmu_vm.vm, max_pmce);
> +	run_vcpu(vpmu_vm.vcpu);
> +	sync_global_from_guest(vpmu_vm.vm, max_pmce);
> +	destroy_vpmu_vm();
> +
> +	return max_pmce.pmceid0 &
> +	       (ARMV8_PMUV3_PERFCTR_BR_RETIRED |
> +	       ARMV8_PMUV3_PERFCTR_INST_RETIRED |
> +	       ARMV8_PMUV3_PERFCTR_CHAIN);
those are not bit masks but bit shifts. Also don't you want to test that
all of them are supported?

BR_RETIRED is 0x21 so doesn't it belong to pmceid1?


in v4 Oliver suggested to use sysfs instead of spawning a scratch VM.
> +}
> +
> +int main(void)
> +{
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
> +	TEST_REQUIRE(kvm_pmu_support_events());
> +
> +	run_tests();
> +}
Eric


