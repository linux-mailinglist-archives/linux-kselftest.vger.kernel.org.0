Return-Path: <linux-kselftest+bounces-1960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1EC813ABF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 20:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE53D1C20C1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 19:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F3697AF;
	Thu, 14 Dec 2023 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9+zi497"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86BF69790
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702582174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUk3eG+68EZSTIrjQkfVQpGuO5D5nt4u7CUzC6kn+ms=;
	b=f9+zi497kqaCK6AR+NYF5YU+dCcJL4Uhcqg9ibZm/eLVcYXGnCNtK7+YJMe00ua92Ftzo4
	gX25CO0wSjlo9vj0p2LeERh5g2FKgUo3o7Q8u3rPwjm7CMRL20C2LZdoGRcsuljc/4TUb1
	Vh4ZXny5xaWXf12ygqpcgSrk1Wnq3HY=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-WRcP18JFMfuDGTyA1YA5dA-1; Thu, 14 Dec 2023 14:29:31 -0500
X-MC-Unique: WRcP18JFMfuDGTyA1YA5dA-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4b4d91b71e5so1344918e0c.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 11:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582170; x=1703186970;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUk3eG+68EZSTIrjQkfVQpGuO5D5nt4u7CUzC6kn+ms=;
        b=qcfKN9efiDtGQFQc0hADKX2afOXpDr+PLjuEXP9OJME4dNO6A0cPa2uTQEdex5NDoW
         hOun7fNmRCSanXf4gl1POXw235FY3z6sO2qF4g9fajfLQlVLs46xu4fnpMMP0+mHVEE2
         T1hIXY3oTccENdkglwHTyMoEzrJwyc98bOlnyOI2MG09LoWkcfcwdjgCfRhCpbpo4AWK
         2ZgU4V5cSUQB6EVTm6sLUeEfTkMNHzfryLixRw+vM0fpVnHuyUP79hX6SDpbH99oFBAl
         qCrijHWZlBTEpMDnydscMGaQ/ufg6BNaqJsUOA/f9PVqvZYQEX8uJDFUz3d+2f61bDQ+
         wtiA==
X-Gm-Message-State: AOJu0YzH0cXJp+dCDSET08HgmoB+akJgzwou9UleHI0FSxGLqhdOpznG
	dRMocjB0u92iSKKOqgamQ8GdmBuEf3H8XEIgaDBG++QCCUrq7l5gqOCoIibcP5U4seW1UDhe6Qn
	q0r5gjNA+va+OTBu1x892nWctyLeq
X-Received: by 2002:ac5:c38f:0:b0:4b2:956e:f651 with SMTP id s15-20020ac5c38f000000b004b2956ef651mr6137825vkk.0.1702582170617;
        Thu, 14 Dec 2023 11:29:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE51zbBMPgEBfDxOsVJeFCrbH7TB4ZBojjQo3bgaphGVUfxRbU+URMAd9Lv4bepko/KkIfhQg==
X-Received: by 2002:ac5:c38f:0:b0:4b2:956e:f651 with SMTP id s15-20020ac5c38f000000b004b2956ef651mr6137817vkk.0.1702582170275;
        Thu, 14 Dec 2023 11:29:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id dv4-20020a05620a1b8400b0077da476d403sm5498175qkb.58.2023.12.14.11.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 11:29:29 -0800 (PST)
Message-ID: <e14dcae7-db8c-4a82-a829-b783e754163b@redhat.com>
Date: Thu, 14 Dec 2023 20:29:25 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] KVM: selftests: aarch64: Introduce
 pmu_event_filter_test
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231129072712.2667337-1-shahuang@redhat.com>
 <20231129072712.2667337-5-shahuang@redhat.com>
 <72c68db7-3de0-4517-9410-fd19d4564fea@redhat.com>
In-Reply-To: <72c68db7-3de0-4517-9410-fd19d4564fea@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaoqin,

On 12/14/23 14:45, Eric Auger wrote:
> Hi Shaoqin,
> 
> On 11/29/23 08:27, Shaoqin Huang wrote:
>> Introduce pmu_event_filter_test for arm64 platforms. The test configures
>> PMUv3 for a vCPU, and sets different pmu event filters for the vCPU, and
>> check if the guest can use those events which user allow and can't use
>> those events which use deny.
>>
>> This test refactor the create_vpmu_vm() and make it a wrapper for
>> __create_vpmu_vm(), which allows some extra init code before
>> KVM_ARM_VCPU_PMU_V3_INIT.
>>
>> And this test use the KVM_ARM_VCPU_PMU_V3_FILTER attribute to set the
>> pmu event filter in KVM. And choose to filter two common event
>> branches_retired and instructions_retired, and let guest use the two
>> events in pmu. And check if the result is expected.
>>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
>>  tools/testing/selftests/kvm/Makefile          |   1 +
>>  .../kvm/aarch64/pmu_event_filter_test.c       | 231 ++++++++++++++++++
>>  .../selftests/kvm/include/aarch64/vpmu.h      |   4 +
>>  .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  14 +-
>>  4 files changed, 248 insertions(+), 2 deletions(-)
>>  create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index b60852c222ac..5f126e1a1dbf 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -155,6 +155,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
>>  TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>>  TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
>>  TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
>> +TEST_GEN_PROGS_aarch64 += aarch64/pmu_event_filter_test
>>  TEST_GEN_PROGS_aarch64 += aarch64/psci_test
>>  TEST_GEN_PROGS_aarch64 += aarch64/set_id_regs
>>  TEST_GEN_PROGS_aarch64 += aarch64/smccc_filter
>> diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>> new file mode 100644
>> index 000000000000..0e652fbdb37a
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>> @@ -0,0 +1,231 @@
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
>> +struct {
>> +	uint64_t branches_retired;
>> +	uint64_t instructions_retired;
>> +} pmc_results;
>> +
>> +static struct vpmu_vm *vpmu_vm;
>> +static uint64_t pmceid0;
>> +
>> +#define FILTER_NR 10
>> +
>> +struct test_desc {
>> +	const char *name;
>> +	void (*check_result)(void);
>> +	struct kvm_pmu_event_filter filter[FILTER_NR];
>> +};
>> +> +#define __DEFINE_FILTER(base, num, act)		\
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
>> +
>> +#define NUM_BRANCHES	10
>> +
>> +static void run_and_measure_loop(void)
>> +{
>> +	asm volatile(
>> +		"	mov	x10, %[loop]\n"
>> +		"1:	sub	x10, x10, #1\n"
>> +		"	cmp	x10, #0x0\n"
>> +		"	b.gt	1b\n"
>> +		:
>> +		: [loop] "r" (NUM_BRANCHES)
>> +		: "x10", "cc");
>> +}
>> +
>> +static void guest_code(void)
>> +{
>> +	uint64_t pmcr = read_sysreg(pmcr_el0);
>> +
>> +	pmu_disable_reset();
>> +
>> +	write_pmevtypern(0, BR_RETIRED);
>> +	write_pmevtypern(1, INST_RETIRED);
>> +	enable_counter(0);
>> +	enable_counter(1);
>> +	write_sysreg(pmcr | ARMV8_PMU_PMCR_E, pmcr_el0);
>> +
>> +	run_and_measure_loop();
>> +
>> +	write_sysreg(pmcr, pmcr_el0);
>> +
>> +	pmc_results.branches_retired = read_sysreg(pmevcntr0_el0);
>> +	pmc_results.instructions_retired = read_sysreg(pmevcntr1_el0);
>> +
>> +	GUEST_DONE();
>> +}
>> +
>> +static void guest_get_pmceid0(void)
>> +{
>> +	uint64_t pmceid0 = read_sysreg(pmceid0_el0);
>> +
>> +	GUEST_PRINTF("%lx\n", pmceid0);
>> +
>> +	GUEST_DONE();
>> +}
>> +
>> +static void pmu_event_filter_init(struct vpmu_vm *vm, void *arg)
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
>> +		filter++;
>> +	}
>> +}
>> +
>> +static void create_vpmu_vm_with_filter(void *guest_code,
>> +				       struct kvm_pmu_event_filter *filter)
>> +{
>> +	vpmu_vm = __create_vpmu_vm(guest_code, pmu_event_filter_init, filter);
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
>> +		case UCALL_PRINTF:
>> +			pmceid0 = strtoll(uc.buffer, NULL, 16);
>> +			break;
>> +		default:
>> +			TEST_FAIL("Unknown ucall %lu", uc.cmd);
>> +		}
>> +	}
>> +}
>> +
>> +static void check_pmc_counting(void)
>> +{
>> +	uint64_t br = pmc_results.branches_retired;
>> +	uint64_t ir = pmc_results.instructions_retired;
>> +
>> +	TEST_ASSERT(br && br == NUM_BRANCHES, "Branch instructions retired = "
>> +		    "%lu (expected %u)", br, NUM_BRANCHES);
> have you tested on several machines? My experience with some events
> (MEM_ACCESS for instance) is that you have variance (sometimes
> significant) on some event count. I am a little bit scared that having
> this br == NUM_BRANCHES check without taking into account some margin
> will cause failures on some HW.

I confirm the usual suspect, Amberwing, does not like this check ;-)

augere@qualcomm-amberwing-rep-06:~/UPSTREAM/linux/tools/testing/selftests/kvm/aarch64#
./pmu_event_filter_test
==== Test Assertion Failure ====
  aarch64/pmu_event_filter_test.c:141: br && br == NUM_BRANCHES
  pid=7750 tid=7750 errno=4 - Interrupted system call
     1	0x0000000000401d6b: check_pmc_counting at pmu_event_filter_test.c:141
     2	0x0000000000401967: run_test at pmu_event_filter_test.c:173
     3	 (inlined by) for_each_test at pmu_event_filter_test.c:198
     4	 (inlined by) main at pmu_event_filter_test.c:264
     5	0x0000ffffaaa6c79b: ?? ??:0
     6	0x0000ffffaaa6c86b: ?? ??:0
     7	0x0000000000401aaf: _start at ??:?
  Branch instructions retired = 15 (expected 10)

Eric

> 
> in v1 I suggested to read to PMCEID* in a guest code to check if the
> event is supported. This method would also have the benefice to allow
> testing more complex filter range combinations.
>> +	TEST_ASSERT(ir, "Instructions retired = %lu (expected > 0)", ir);
>> +}
>> +
>> +static void check_pmc_not_counting(void)
>> +{
>> +	uint64_t br = pmc_results.branches_retired;
>> +	uint64_t ir = pmc_results.instructions_retired;
>> +
>> +	TEST_ASSERT(!br, "Branch instructions retired = %lu (expected 0)", br);
>> +	TEST_ASSERT(!ir, "Instructions retired = %lu (expected 0)", ir);
>> +}
>> +
>> +static void run_vcpu_and_sync_pmc_results(void)
>> +{
>> +	memset(&pmc_results, 0, sizeof(pmc_results));
>> +	sync_global_to_guest(vpmu_vm->vm, pmc_results);
>> +
>> +	run_vcpu(vpmu_vm->vcpu);
>> +
>> +	sync_global_from_guest(vpmu_vm->vm, pmc_results);
>> +}
>> +
>> +static void run_test(struct test_desc *t)
>> +{
>> +	pr_debug("Test: %s\n", t->name);
>> +
>> +	create_vpmu_vm_with_filter(guest_code, t->filter);
>> +
>> +	run_vcpu_and_sync_pmc_results();
>> +
>> +	t->check_result();
>> +
>> +	destroy_vpmu_vm(vpmu_vm);
>> +}
>> +
>> +static struct test_desc tests[] = {
>> +	{"without_filter", check_pmc_counting, { EMPTY_FILTER }},
>> +	{"member_allow_filter", check_pmc_counting,
>> +	 {DEFINE_FILTER(SW_INCR, 0), DEFINE_FILTER(INST_RETIRED, 0),
> Note the doc says that Event 0 (SW_INCR) is never filtered, as it
> doesn't count a hardware event
> 
> 
> I would use the defines exposed in the uapi
>> +#define KVM_PMU_EVENT_ALLOW	0
>> +#define KVM_PMU_EVENT_DENY	1
>> +	  DEFINE_FILTER(BR_RETIRED, 0), EMPTY_FILTER}},
>> +	{"member_deny_filter", check_pmc_not_counting,
>> +	 {DEFINE_FILTER(SW_INCR, 1), DEFINE_FILTER(INST_RETIRED, 1),
> what is the purpose of SW_INCR. YOu do not seem to test it anyway?
>> +	  DEFINE_FILTER(BR_RETIRED, 1), EMPTY_FILTER}},
>> +	{"not_member_deny_filter", check_pmc_counting,
>> +	 {DEFINE_FILTER(SW_INCR, 1), EMPTY_FILTER}},
>> +	{"not_member_allow_filter", check_pmc_not_counting,
>> +	 {DEFINE_FILTER(SW_INCR, 0), EMPTY_FILTER}},
>> +	{ 0 }
>> +};
>> +
>> +static void for_each_test(void)
>> +{
>> +	struct test_desc *t;
>> +
>> +	for (t = &tests[0]; t->name; t++)
>> +		run_test(t);
>> +}
>> +
>> +static bool kvm_supports_pmu_event_filter(void)
>> +{
>> +	int r;
>> +
>> +	vpmu_vm = create_vpmu_vm(guest_code);
>> +
>> +	r = __kvm_has_device_attr(vpmu_vm->vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
>> +				  KVM_ARM_VCPU_PMU_V3_FILTER);
> you can use __vcpu_has_device_attr directly
>> +
>> +	destroy_vpmu_vm(vpmu_vm);
>> +	return !r;
>> +}
>> +
>> +static bool host_pmu_supports_events(void)
>> +{
>> +	vpmu_vm = create_vpmu_vm(guest_get_pmceid0);
>> +
>> +	run_vcpu(vpmu_vm->vcpu);
>> +
>> +	destroy_vpmu_vm(vpmu_vm);
>> +
>> +	return pmceid0 & (BR_RETIRED | INST_RETIRED);
> this will return true if either event is supported. I suspect this is
> not what you want.
>> +}
>> +
>> +int main(void)
>> +{
>> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
>> +	TEST_REQUIRE(kvm_supports_pmu_event_filter());
>> +	TEST_REQUIRE(host_pmu_supports_events());
>> +
>> +	for_each_test();
>> +}
>> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>> index 644dae3814b5..f103d0824f8a 100644
>> --- a/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>> @@ -18,6 +18,10 @@ struct vpmu_vm {
>>  	int gic_fd;
>>  };
>>  
>> +struct vpmu_vm *__create_vpmu_vm(void *guest_code,
>> +				 void (*init_pmu)(struct vpmu_vm *vm, void *arg),
>> +				 void *arg);
>> +
>>  struct vpmu_vm *create_vpmu_vm(void *guest_code);
>>  
>>  void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm);
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
>>  void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm)
>>  {
>>  	close(vpmu_vm->gic_fd);
> 
> Thanks
> 
> Eric


