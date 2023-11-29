Return-Path: <linux-kselftest+bounces-790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751007FCD73
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 04:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9856F1C20A68
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 03:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF5523D;
	Wed, 29 Nov 2023 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pa3cDWVK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D41D1AD
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 19:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701228233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TTJ58KWC2SZoPUwO7tW+JHkCgszqWXiNIUMSYVObDXQ=;
	b=Pa3cDWVK+kWd8xQ5Uk3JLUZ4TBfOVFkfVLzm4wwais5S1JRqz9GmzljpJdmTRXVC7khH0h
	3LTmAgIcO1n/XPssd1hJhxgsyBSRKO0CxYWMOOOqb+2MbmXTsD8xbT0esdO/Afof604iWA
	g52D8/6UXpVAZ/aYYO4ikdXiSLQVkgA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-MWn8e40BN2-W7Aq9H0sEZw-1; Tue, 28 Nov 2023 22:23:51 -0500
X-MC-Unique: MWn8e40BN2-W7Aq9H0sEZw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5bdb39cd60dso967278a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 19:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701228230; x=1701833030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTJ58KWC2SZoPUwO7tW+JHkCgszqWXiNIUMSYVObDXQ=;
        b=LCAdLhEX2ZxBqjdUqj9Xr/ZkZ01IgU3+HmoFl8MI6ivkCyLmNC4S3bw79Lo25VTidg
         GImFjbHrArra01zntFmrAn6CqCm37n+7ko9q633ajfBukFVbp2/Qp/S1W37lqzA3lG4o
         2yZayMxRM6HplVqsUBfvb1WoaekI217TEiPGXbEhWYj+10NT6iuxLWqBqSSSKs2MpSOo
         l4PymYoQ0xRdBJ3IYrSJTpViV2QCc7M4lp57I1jL47IPiLsr53ndMnwfLsq/tsF4KUSo
         Yqh74cxd7rmWll+z1WC90Kq/Hkv68JDNJ65DTDRwcZJMx7izDpDne1RpFVPwWJ1g6/KU
         GdGw==
X-Gm-Message-State: AOJu0YyihKZvEIf2MiaRM715OPPrv8KWOG8xDOj+6Cxpm9ukF5x3F4UO
	G5CpADxFrTVB7n02ZP/tP4t8hXh+7P5ito0ITIoUxefDQtO+UFMvH98W2F0F0xIr5pTa3PndHpp
	oaflztFeCzQlZSkImgsEMCjnWvH2H
X-Received: by 2002:a05:6a00:2d97:b0:6cb:a2fa:1dcf with SMTP id fb23-20020a056a002d9700b006cba2fa1dcfmr20981601pfb.3.1701228230438;
        Tue, 28 Nov 2023 19:23:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2/weQ3/ZNAUk0tAZFn32jYCU5C4JXvLSgsGNRm6c/f4w/5oaIV6W4zscTeDRKtGtPs6T3dw==
X-Received: by 2002:a05:6a00:2d97:b0:6cb:a2fa:1dcf with SMTP id fb23-20020a056a002d9700b006cba2fa1dcfmr20981589pfb.3.1701228230002;
        Tue, 28 Nov 2023 19:23:50 -0800 (PST)
Received: from [10.72.112.34] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bj6-20020a056a02018600b005c5e1f3ec8bsm2087054pgb.41.2023.11.28.19.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 19:23:49 -0800 (PST)
Message-ID: <a3ece21f-71fd-ebb8-3d89-b3f0cdb6b9e0@redhat.com>
Date: Wed, 29 Nov 2023 11:23:44 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/3] KVM: selftests: aarch64: Make the
 [create|destroy]_vpmu_vm() can be reused
Content-Language: en-US
To: Eric Auger <eauger@redhat.com>, Oliver Upton <oliver.upton@linux.dev>,
 Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231123063750.2176250-1-shahuang@redhat.com>
 <20231123063750.2176250-2-shahuang@redhat.com>
 <63c97950-2c12-4ee1-b8d1-0794e7603b25@redhat.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <63c97950-2c12-4ee1-b8d1-0794e7603b25@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eric,

On 11/25/23 02:14, Eric Auger wrote:
> Hi Shaoqin,
> 
> On 11/23/23 07:37, Shaoqin Huang wrote:
>> Move the [create|destroy]_vpmu_vm() into the lib/, which makes those
> some wording suggestions below:
> 
> Move the implementation of .. into lib/aarch64/pmu.c and export their
> declaration in a header so that they can be reused by other tests. Also
> the title may be renamed: Make [create|destroy]_vpmu_vm() public
>> function can be used by other tests. Install the handler is specific to
> the sync exception handler install is test specific so we move it out of
> the helper function.
>> the vpmu_counter_access test, so create a wrapper function for it, and
>> only move the common part.
>>
>> No functional change.
> intended ;-)

Will take your advice at the next version.

>>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
>>   tools/testing/selftests/kvm/Makefile          |   1 +
>>   .../kvm/aarch64/vpmu_counter_access.c         | 100 +++++-------------
>>   .../selftests/kvm/include/aarch64/vpmu.h      |  16 +++
>>   .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  64 +++++++++++
>>   4 files changed, 105 insertions(+), 76 deletions(-)
>>   create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h
>>   create mode 100644 tools/testing/selftests/kvm/lib/aarch64/vpmu.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index a5963ab9215b..b60852c222ac 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -57,6 +57,7 @@ LIBKVM_aarch64 += lib/aarch64/processor.c
>>   LIBKVM_aarch64 += lib/aarch64/spinlock.c
>>   LIBKVM_aarch64 += lib/aarch64/ucall.c
>>   LIBKVM_aarch64 += lib/aarch64/vgic.c
>> +LIBKVM_aarch64 += lib/aarch64/vpmu.c
>>   
>>   LIBKVM_s390x += lib/s390x/diag318_test_handler.c
>>   LIBKVM_s390x += lib/s390x/processor.c
>> diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
>> index 5ea78986e665..17305408a334 100644
>> --- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
>> +++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
>> @@ -16,6 +16,7 @@
>>   #include <processor.h>
>>   #include <test_util.h>
>>   #include <vgic.h>
>> +#include <vpmu.h>
>>   #include <perf/arm_pmuv3.h>
>>   #include <linux/bitfield.h>
>>   
>> @@ -25,13 +26,7 @@
>>   /* The cycle counter bit position that's common among the PMU registers */
>>   #define ARMV8_PMU_CYCLE_IDX		31
>>   
>> -struct vpmu_vm {
>> -	struct kvm_vm *vm;
>> -	struct kvm_vcpu *vcpu;
>> -	int gic_fd;
>> -};
>> -
>> -static struct vpmu_vm vpmu_vm;
>> +static struct vpmu_vm *vpmu_vm;
>>   
>>   struct pmreg_sets {
>>   	uint64_t set_reg_id;
>> @@ -421,64 +416,6 @@ static void guest_code(uint64_t expected_pmcr_n)
>>   	GUEST_DONE();
>>   }
>>   
>> -#define GICD_BASE_GPA	0x8000000ULL
>> -#define GICR_BASE_GPA	0x80A0000ULL
>> -
>> -/* Create a VM that has one vCPU with PMUv3 configured. */
>> -static void create_vpmu_vm(void *guest_code)
>> -{
>> -	struct kvm_vcpu_init init;
>> -	uint8_t pmuver, ec;
>> -	uint64_t dfr0, irq = 23;
>> -	struct kvm_device_attr irq_attr = {
>> -		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
>> -		.attr = KVM_ARM_VCPU_PMU_V3_IRQ,
>> -		.addr = (uint64_t)&irq,
>> -	};
>> -	struct kvm_device_attr init_attr = {
>> -		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
>> -		.attr = KVM_ARM_VCPU_PMU_V3_INIT,
>> -	};
>> -
>> -	/* The test creates the vpmu_vm multiple times. Ensure a clean state */
>> -	memset(&vpmu_vm, 0, sizeof(vpmu_vm));
>> -
>> -	vpmu_vm.vm = vm_create(1);
>> -	vm_init_descriptor_tables(vpmu_vm.vm);
>> -	for (ec = 0; ec < ESR_EC_NUM; ec++) {
>> -		vm_install_sync_handler(vpmu_vm.vm, VECTOR_SYNC_CURRENT, ec,
>> -					guest_sync_handler);
>> -	}
>> -
>> -	/* Create vCPU with PMUv3 */
>> -	vm_ioctl(vpmu_vm.vm, KVM_ARM_PREFERRED_TARGET, &init);
>> -	init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
>> -	vpmu_vm.vcpu = aarch64_vcpu_add(vpmu_vm.vm, 0, &init, guest_code);
>> -	vcpu_init_descriptor_tables(vpmu_vm.vcpu);
>> -	vpmu_vm.gic_fd = vgic_v3_setup(vpmu_vm.vm, 1, 64,
>> -					GICD_BASE_GPA, GICR_BASE_GPA);
>> -	__TEST_REQUIRE(vpmu_vm.gic_fd >= 0,
>> -		       "Failed to create vgic-v3, skipping");
>> -
>> -	/* Make sure that PMUv3 support is indicated in the ID register */
>> -	vcpu_get_reg(vpmu_vm.vcpu,
>> -		     KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &dfr0);
>> -	pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), dfr0);
>> -	TEST_ASSERT(pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF &&
>> -		    pmuver >= ID_AA64DFR0_EL1_PMUVer_IMP,
>> -		    "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pmuver);
>> -
>> -	/* Initialize vPMU */
>> -	vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
>> -	vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
>> -}
>> -
>> -static void destroy_vpmu_vm(void)
>> -{
>> -	close(vpmu_vm.gic_fd);
>> -	kvm_vm_free(vpmu_vm.vm);
>> -}
>> -
>>   static void run_vcpu(struct kvm_vcpu *vcpu, uint64_t pmcr_n)
>>   {
>>   	struct ucall uc;
>> @@ -497,13 +434,24 @@ static void run_vcpu(struct kvm_vcpu *vcpu, uint64_t pmcr_n)
>>   	}
>>   }
>>   
>> +static void create_vpmu_vm_with_handler(void *guest_code)
>> +{
>> +	uint8_t ec;
>> +	vpmu_vm = create_vpmu_vm(guest_code);
>> +
>> +	for (ec = 0; ec < ESR_EC_NUM; ec++) {
>> +		vm_install_sync_handler(vpmu_vm->vm, VECTOR_SYNC_CURRENT, ec,
>> +					guest_sync_handler);
>> +	}
>> +}
>> +
>>   static void test_create_vpmu_vm_with_pmcr_n(uint64_t pmcr_n, bool expect_fail)
>>   {
>>   	struct kvm_vcpu *vcpu;
>>   	uint64_t pmcr, pmcr_orig;
>>   
>> -	create_vpmu_vm(guest_code);
>> -	vcpu = vpmu_vm.vcpu;
>> +	create_vpmu_vm_with_handler(guest_code);
>> +	vcpu = vpmu_vm->vcpu;
>>   
>>   	vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_PMCR_EL0), &pmcr_orig);
>>   	pmcr = pmcr_orig;
>> @@ -539,7 +487,7 @@ static void run_access_test(uint64_t pmcr_n)
>>   	pr_debug("Test with pmcr_n %lu\n", pmcr_n);
>>   
>>   	test_create_vpmu_vm_with_pmcr_n(pmcr_n, false);
>> -	vcpu = vpmu_vm.vcpu;
>> +	vcpu = vpmu_vm->vcpu;
>>   
>>   	/* Save the initial sp to restore them later to run the guest again */
>>   	vcpu_get_reg(vcpu, ARM64_CORE_REG(sp_el1), &sp);
>> @@ -550,7 +498,7 @@ static void run_access_test(uint64_t pmcr_n)
>>   	 * Reset and re-initialize the vCPU, and run the guest code again to
>>   	 * check if PMCR_EL0.N is preserved.
>>   	 */
>> -	vm_ioctl(vpmu_vm.vm, KVM_ARM_PREFERRED_TARGET, &init);
>> +	vm_ioctl(vpmu_vm->vm, KVM_ARM_PREFERRED_TARGET, &init);
>>   	init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
>>   	aarch64_vcpu_setup(vcpu, &init);
>>   	vcpu_init_descriptor_tables(vcpu);
>> @@ -559,7 +507,7 @@ static void run_access_test(uint64_t pmcr_n)
>>   
>>   	run_vcpu(vcpu, pmcr_n);
>>   
>> -	destroy_vpmu_vm();
>> +	destroy_vpmu_vm(vpmu_vm);
>>   }
>>   
>>   static struct pmreg_sets validity_check_reg_sets[] = {
>> @@ -580,7 +528,7 @@ static void run_pmregs_validity_test(uint64_t pmcr_n)
>>   	uint64_t valid_counters_mask, max_counters_mask;
>>   
>>   	test_create_vpmu_vm_with_pmcr_n(pmcr_n, false);
>> -	vcpu = vpmu_vm.vcpu;
>> +	vcpu = vpmu_vm->vcpu;
>>   
>>   	valid_counters_mask = get_counters_mask(pmcr_n);
>>   	max_counters_mask = get_counters_mask(ARMV8_PMU_MAX_COUNTERS);
>> @@ -621,7 +569,7 @@ static void run_pmregs_validity_test(uint64_t pmcr_n)
>>   			    KVM_ARM64_SYS_REG(clr_reg_id), reg_val);
>>   	}
>>   
>> -	destroy_vpmu_vm();
>> +	destroy_vpmu_vm(vpmu_vm);
>>   }
>>   
>>   /*
>> @@ -634,7 +582,7 @@ static void run_error_test(uint64_t pmcr_n)
>>   	pr_debug("Error test with pmcr_n %lu (larger than the host)\n", pmcr_n);
>>   
>>   	test_create_vpmu_vm_with_pmcr_n(pmcr_n, true);
>> -	destroy_vpmu_vm();
>> +	destroy_vpmu_vm(vpmu_vm);
>>   }
>>   
>>   /*
>> @@ -645,9 +593,9 @@ static uint64_t get_pmcr_n_limit(void)
>>   {
>>   	uint64_t pmcr;
>>   
>> -	create_vpmu_vm(guest_code);
>> -	vcpu_get_reg(vpmu_vm.vcpu, KVM_ARM64_SYS_REG(SYS_PMCR_EL0), &pmcr);
>> -	destroy_vpmu_vm();
>> +	create_vpmu_vm_with_handler(guest_code);
>> +	vcpu_get_reg(vpmu_vm->vcpu, KVM_ARM64_SYS_REG(SYS_PMCR_EL0), &pmcr);
>> +	destroy_vpmu_vm(vpmu_vm);
>>   	return get_pmcr_n(pmcr);
>>   }
>>   
>> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>> new file mode 100644
>> index 000000000000..0a56183644ee
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#include <kvm_util.h>
>> +
>> +#define GICD_BASE_GPA	0x8000000ULL
>> +#define GICR_BASE_GPA	0x80A0000ULL
>> +
>> +struct vpmu_vm {
>> +	struct kvm_vm *vm;
>> +	struct kvm_vcpu *vcpu;
>> +	int gic_fd;
>> +};
>> +
>> +struct vpmu_vm *create_vpmu_vm(void *guest_code);
>> +
>> +void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm);
>> diff --git a/tools/testing/selftests/kvm/lib/aarch64/vpmu.c b/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
>> new file mode 100644
>> index 000000000000..b3de8fdc555e
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
>> @@ -0,0 +1,64 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <kvm_util.h>
>> +#include <processor.h>
>> +#include <test_util.h>
>> +#include <vgic.h>
>> +#include <vpmu.h>
>> +#include <perf/arm_pmuv3.h>
>> +
>> +/* Create a VM that has one vCPU with PMUv3 configured. */
>> +struct vpmu_vm *create_vpmu_vm(void *guest_code)
>> +{
>> +	struct kvm_vcpu_init init;
>> +	uint8_t pmuver;
>> +	uint64_t dfr0, irq = 23;
>> +	struct kvm_device_attr irq_attr = {
>> +		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
>> +		.attr = KVM_ARM_VCPU_PMU_V3_IRQ,
>> +		.addr = (uint64_t)&irq,
>> +	};
>> +	struct kvm_device_attr init_attr = {
>> +		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
>> +		.attr = KVM_ARM_VCPU_PMU_V3_INIT,
>> +	};
>> +	struct vpmu_vm *vpmu_vm;
>> +
>> +	vpmu_vm = calloc(1, sizeof(*vpmu_vm));
>> +	TEST_ASSERT(vpmu_vm != NULL, "Insufficient Memory");
>> +	memset(vpmu_vm, 0, sizeof(vpmu_vm));
>> +
>> +	vpmu_vm->vm = vm_create(1);
>> +	vm_init_descriptor_tables(vpmu_vm->vm);
>> +
>> +	/* Create vCPU with PMUv3 */
>> +	vm_ioctl(vpmu_vm->vm, KVM_ARM_PREFERRED_TARGET, &init);
>> +	init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
>> +	vpmu_vm->vcpu = aarch64_vcpu_add(vpmu_vm->vm, 0, &init, guest_code);
>> +	vcpu_init_descriptor_tables(vpmu_vm->vcpu);
>> +	vpmu_vm->gic_fd = vgic_v3_setup(vpmu_vm->vm, 1, 64,
>> +					GICD_BASE_GPA, GICR_BASE_GPA);
>> +	__TEST_REQUIRE(vpmu_vm->gic_fd >= 0,
>> +		       "Failed to create vgic-v3, skipping");
>> +
>> +	/* Make sure that PMUv3 support is indicated in the ID register */
>> +	vcpu_get_reg(vpmu_vm->vcpu,
>> +		     KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &dfr0);
>> +	pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), dfr0);
>> +	TEST_ASSERT(pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF &&
>> +		    pmuver >= ID_AA64DFR0_EL1_PMUVer_IMP,
>> +		    "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pmuver);
>> +
>> +	/* Initialize vPMU */
>> +	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
>> +	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
>> +
>> +	return vpmu_vm;
>> +}
>> +
>> +void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm)
>> +{
>> +	close(vpmu_vm->gic_fd);
>> +	kvm_vm_free(vpmu_vm->vm);
>> +	free(vpmu_vm);
>> +}
> Besides looks good to me
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks for your review. :)

> 
> Eric
> 
> 

-- 
Shaoqin


