Return-Path: <linux-kselftest+bounces-5885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE76D871504
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 05:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D84B21C6C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 04:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C98433BA;
	Tue,  5 Mar 2024 04:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJ+Ra+hq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F8611A;
	Tue,  5 Mar 2024 04:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614679; cv=none; b=DR9hmpTQHN0e78ZOaAYrdnQhbuGTslS2hmeFST7x8lpQvM1qa+04y/Sr6+rOv9tZLJdByvdnX42ADsO2Q9dcmAWD04MYtEgRg+SfqMi7FcS48mmsc3UuIUB96ru7zy4HDlw3RRBRG6Ev1lQwPcrhm4bXP2UXAOqnqKY0ln6CJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614679; c=relaxed/simple;
	bh=p9A8AKNT5bWayq85gBPsGYGBp5rt1p2gcZJAx2F3Kio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcIFN8JYR6PAwlRXvRRe8IgDNfn6LpXysgH5liuEmh16Hj8fex+w9U5FYD7uOzoX3mWDGwQ18Uo4gHBsmCiJ053lddHWCBq1laS3FR+0i2Uo64FBBP83HiTYc2sZ/vTuBrzse8FULz3my7nemGydVbcENqELx+6WnFLGPMO9eOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJ+Ra+hq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709614678; x=1741150678;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p9A8AKNT5bWayq85gBPsGYGBp5rt1p2gcZJAx2F3Kio=;
  b=iJ+Ra+hq85nqREJjPIgD0f9ZqWYSb5ZikHjixmJhikijiNWVj/ioEv+V
   JD1w0UhKEHrkolINgnMACk86M0lUGwlzYS2A2SWqpIzzNa4+aLIoHafaR
   xkStbW3t/Iug7CMlxeZcCHmQ2h4BYYa8t5Qwjz0gxKs77URdjZvdoRRLB
   b6bvGEA19G/3zwNVKxPiAgJm43iHOkydYxg4YT05HpYKvzR0s6F4XwsI9
   joHUIE+rtvFaL8/dTXyL8j/ARSScWCl6gexIpYzt5s/mqoCsZcE/1EysF
   qfTyOpk0S+31jVYXYe8Q9jClPaQ8MnCvTgBtlsOavcGWtNZfjmX1BQKkf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7913231"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7913231"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 20:57:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="46775541"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.8.218]) ([10.238.8.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 20:57:51 -0800
Message-ID: <ace89472-2d10-47c3-bf6d-232602b689f6@linux.intel.com>
Date: Tue, 5 Mar 2024 12:57:49 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 28/29] KVM: selftests: TDX: Add TDX UPM selftest
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>,
 Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>,
 Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-29-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-29-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> This tests the use of guest memory with explicit MapGPA calls.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../selftests/kvm/x86_64/tdx_upm_test.c       | 401 ++++++++++++++++++
>   2 files changed, 402 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 8c0a6b395ee5..2f2669af15d6 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -157,6 +157,7 @@ TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
>   TEST_GEN_PROGS_x86_64 += system_counter_offset_test
>   TEST_GEN_PROGS_x86_64 += x86_64/tdx_vm_tests
>   TEST_GEN_PROGS_x86_64 += x86_64/tdx_shared_mem_test
> +TEST_GEN_PROGS_x86_64 += x86_64/tdx_upm_test
>   
>   # Compiled outputs used by test targets
>   TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
> new file mode 100644
> index 000000000000..44671874a4f1
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <asm/kvm.h>
> +#include <asm/vmx.h>
> +#include <linux/kvm.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +
> +#include "kvm_util_base.h"
> +#include "processor.h"
> +#include "tdx/tdcall.h"
> +#include "tdx/tdx.h"
> +#include "tdx/tdx_util.h"
> +#include "tdx/test_util.h"
> +#include "test_util.h"
> +
> +/* TDX UPM test patterns */
> +#define PATTERN_CONFIDENCE_CHECK (0x11)
> +#define PATTERN_HOST_FOCUS (0x22)
> +#define PATTERN_GUEST_GENERAL (0x33)
> +#define PATTERN_GUEST_FOCUS (0x44)
> +
> +/*
> + * 0x80000000 is arbitrarily selected. The selected address need not be the same
> + * as TDX_UPM_TEST_AREA_GVA_PRIVATE, but it should not overlap with selftest
> + * code or boot page.
> + */
> +#define TDX_UPM_TEST_AREA_GPA (0x80000000)
> +/* Test area GPA is arbitrarily selected */
> +#define TDX_UPM_TEST_AREA_GVA_PRIVATE (0x90000000)
> +/* Select any bit that can be used as a flag */
> +#define TDX_UPM_TEST_AREA_GVA_SHARED_BIT (32)
> +/*
> + * TDX_UPM_TEST_AREA_GVA_SHARED is used to map the same GPA twice into the
> + * guest, once as shared and once as private
> + */
> +#define TDX_UPM_TEST_AREA_GVA_SHARED				\
> +	(TDX_UPM_TEST_AREA_GVA_PRIVATE |			\
> +		BIT_ULL(TDX_UPM_TEST_AREA_GVA_SHARED_BIT))
> +
> +/* The test area is 2MB in size */
> +#define TDX_UPM_TEST_AREA_SIZE (2 << 20)
> +/* 0th general area is 1MB in size */
> +#define TDX_UPM_GENERAL_AREA_0_SIZE (1 << 20)
> +/* Focus area is 40KB in size */
> +#define TDX_UPM_FOCUS_AREA_SIZE (40 << 10)
> +/* 1st general area is the rest of the space in the test area */
> +#define TDX_UPM_GENERAL_AREA_1_SIZE				\
> +	(TDX_UPM_TEST_AREA_SIZE - TDX_UPM_GENERAL_AREA_0_SIZE -	\
> +		TDX_UPM_FOCUS_AREA_SIZE)
> +
> +/*
> + * The test memory area is set up as two general areas, sandwiching a focus
> + * area.  The general areas act as control areas. After they are filled, they
> + * are not expected to change throughout the tests. The focus area is memory
> + * permissions change from private to shared and vice-versa.
> + *
> + * The focus area is intentionally small, and sandwiched to test that when the
> + * focus area's permissions change, the other areas' permissions are not
> + * affected.
> + */
> +struct __packed tdx_upm_test_area {
> +	uint8_t general_area_0[TDX_UPM_GENERAL_AREA_0_SIZE];
> +	uint8_t focus_area[TDX_UPM_FOCUS_AREA_SIZE];
> +	uint8_t general_area_1[TDX_UPM_GENERAL_AREA_1_SIZE];
> +};
> +
> +static void fill_test_area(struct tdx_upm_test_area *test_area_base,
> +			uint8_t pattern)
> +{
> +	memset(test_area_base, pattern, sizeof(*test_area_base));
> +}
> +
> +static void fill_focus_area(struct tdx_upm_test_area *test_area_base,
> +			    uint8_t pattern)
> +{
> +	memset(test_area_base->focus_area, pattern,
> +	       sizeof(test_area_base->focus_area));
> +}
> +
> +static bool check_area(uint8_t *base, uint64_t size, uint8_t expected_pattern)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < size; i++) {
> +		if (base[i] != expected_pattern)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool check_general_areas(struct tdx_upm_test_area *test_area_base,
> +				uint8_t expected_pattern)
> +{
> +	return (check_area(test_area_base->general_area_0,
> +			   sizeof(test_area_base->general_area_0),
> +			   expected_pattern) &&
> +		check_area(test_area_base->general_area_1,
> +			   sizeof(test_area_base->general_area_1),
> +			   expected_pattern));
> +}
> +
> +static bool check_focus_area(struct tdx_upm_test_area *test_area_base,
> +			     uint8_t expected_pattern)
> +{
> +	return check_area(test_area_base->focus_area,
> +			  sizeof(test_area_base->focus_area), expected_pattern);
> +}
> +
> +static bool check_test_area(struct tdx_upm_test_area *test_area_base,
> +			    uint8_t expected_pattern)
> +{
> +	return (check_general_areas(test_area_base, expected_pattern) &&
> +		check_focus_area(test_area_base, expected_pattern));
> +}
> +
> +static bool fill_and_check(struct tdx_upm_test_area *test_area_base, uint8_t pattern)
> +{
> +	fill_test_area(test_area_base, pattern);
> +
> +	return check_test_area(test_area_base, pattern);
> +}
> +
> +#define TDX_UPM_TEST_ASSERT(x)				\
> +	do {						\
> +		if (!(x))				\
> +			tdx_test_fatal(__LINE__);	\
> +	} while (0)
> +
> +/*
> + * Shared variables between guest and host
> + */
> +static struct tdx_upm_test_area *test_area_gpa_private;
> +static struct tdx_upm_test_area *test_area_gpa_shared;
> +
> +/*
> + * Test stages for syncing with host
> + */
> +enum {
> +	SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST = 1,
> +	SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST,
> +	SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN,
> +};
> +
> +#define TDX_UPM_TEST_ACCEPT_PRINT_PORT 0x87
> +
> +/**
> + * Does vcpu_run, and also manages memory conversions if requested by the TD.
> + */
> +void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
> +					    struct kvm_vcpu *vcpu)
> +{
> +	for (;;) {
> +		vcpu_run(vcpu);
> +		if (vcpu->run->exit_reason == KVM_EXIT_TDX &&
> +			vcpu->run->tdx.type == KVM_EXIT_TDX_VMCALL &&
> +			vcpu->run->tdx.u.vmcall.subfunction == TDG_VP_VMCALL_MAP_GPA) {
> +			struct kvm_tdx_vmcall *vmcall_info = &vcpu->run->tdx.u.vmcall;
> +			uint64_t gpa = vmcall_info->in_r12 & ~vm->arch.s_bit;
> +
> +			handle_memory_conversion(vm, gpa, vmcall_info->in_r13,
> +				!(vm->arch.s_bit & vmcall_info->in_r12));
> +			vmcall_info->status_code = 0;
> +			continue;
> +		} else if (
> +			vcpu->run->exit_reason == KVM_EXIT_IO &&
> +			vcpu->run->io.port == TDX_UPM_TEST_ACCEPT_PRINT_PORT) {
> +			uint64_t gpa = tdx_test_read_64bit(
> +				vcpu, TDX_UPM_TEST_ACCEPT_PRINT_PORT);
> +			printf("\t ... guest accepting 1 page at GPA: 0x%lx\n", gpa);
> +			continue;
> +		}
> +
> +		break;
> +	}
> +}
> +
> +static void guest_upm_explicit(void)
> +{
> +	uint64_t ret = 0;
> +	uint64_t failed_gpa;
> +
> +	struct tdx_upm_test_area *test_area_gva_private =
> +		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_PRIVATE;
> +	struct tdx_upm_test_area *test_area_gva_shared =
> +		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_SHARED;
> +
> +	/* Check: host reading private memory does not modify guest's view */
> +	fill_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL);
> +
> +	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
> +
> +	TDX_UPM_TEST_ASSERT(
> +		check_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL));
> +
> +	/* Remap focus area as shared */
> +	ret = tdg_vp_vmcall_map_gpa((uint64_t)test_area_gpa_shared->focus_area,
> +				    sizeof(test_area_gpa_shared->focus_area),
> +				    &failed_gpa);
> +	TDX_UPM_TEST_ASSERT(!ret);
> +
> +	/* General areas should be unaffected by remapping */
> +	TDX_UPM_TEST_ASSERT(
> +		check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
> +
> +	/*
> +	 * Use memory contents to confirm that the memory allocated using mmap
> +	 * is used as backing memory for shared memory - PATTERN_CONFIDENCE_CHECK
> +	 * was written by the VMM at the beginning of this test.
> +	 */
> +	TDX_UPM_TEST_ASSERT(
> +		check_focus_area(test_area_gva_shared, PATTERN_CONFIDENCE_CHECK));
> +
> +	/* Guest can use focus area after remapping as shared */
> +	fill_focus_area(test_area_gva_shared, PATTERN_GUEST_FOCUS);
> +
> +	tdx_test_report_to_user_space(SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
> +
> +	/* Check that guest has the same view of shared memory */
> +	TDX_UPM_TEST_ASSERT(
> +		check_focus_area(test_area_gva_shared, PATTERN_HOST_FOCUS));
> +
> +	/* Remap focus area back to private */
> +	ret = tdg_vp_vmcall_map_gpa((uint64_t)test_area_gpa_private->focus_area,
> +				    sizeof(test_area_gpa_private->focus_area),
> +				    &failed_gpa);
> +	TDX_UPM_TEST_ASSERT(!ret);
> +
> +	/* General areas should be unaffected by remapping */
> +	TDX_UPM_TEST_ASSERT(
> +		check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
> +
> +	/* Focus area should be zeroed after remapping */
> +	TDX_UPM_TEST_ASSERT(check_focus_area(test_area_gva_private, 0));
> +
> +	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
> +
> +	/* Check that guest can use private memory after focus area is remapped as private */
> +	TDX_UPM_TEST_ASSERT(
> +		fill_and_check(test_area_gva_private, PATTERN_GUEST_GENERAL));
> +
> +	tdx_test_success();
> +}
> +
> +static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
> +			 struct tdx_upm_test_area *test_area_base_hva)
> +{
> +	vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);

This check seems to be a vain.

> +	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
> +		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
> +		  SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
> +
> +	/*
> +	 * Check that host should read PATTERN_CONFIDENCE_CHECK from guest's
> +	 * private memory.

I think this description is confusing.
It's not actually accessing guest's private memory.


>   This confirms that regular memory (userspace_addr in
> +	 * struct kvm_userspace_memory_region) is used to back the host's view
> +	 * of private memory, since PATTERN_CONFIDENCE_CHECK was written to that
> +	 * memory before starting the guest.
> +	 */
> +	TEST_ASSERT(check_test_area(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
> +		"Host should read PATTERN_CONFIDENCE_CHECK from guest's private memory.");
> +
> +	vcpu_run_and_manage_memory_conversions(vm, vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
> +		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
> +		  SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
> +
> +	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_GUEST_FOCUS),
> +		"Host should have the same view of shared memory as guest.");
> +	TEST_ASSERT(check_general_areas(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
> +		"Host's view of private memory should still be backed by regular memory.");
> +
> +	/* Check that host can use shared memory */
> +	fill_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS);
> +	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
> +		    "Host should be able to use shared memory.");
> +
> +	vcpu_run_and_manage_memory_conversions(vm, vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
> +		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
> +		  SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
> +
> +	TEST_ASSERT(check_general_areas(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
> +		"Host's view of private memory should be backed by regular memory.");
> +	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
> +		"Host's view of private memory should be backed by regular memory.");
> +
> +	vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +	printf("\t ... PASSED\n");
> +}
> +
> +static bool address_between(uint64_t addr, void *lo, void *hi)
> +{
> +	return (uint64_t)lo <= addr && addr < (uint64_t)hi;
> +}
> +
> +static void guest_ve_handler(struct ex_regs *regs)
> +{
> +	uint64_t ret;
> +	struct ve_info ve;
> +
> +	ret = tdg_vp_veinfo_get(&ve);
> +	TDX_UPM_TEST_ASSERT(!ret);
> +
> +	/* For this test, we will only handle EXIT_REASON_EPT_VIOLATION */
> +	TDX_UPM_TEST_ASSERT(ve.exit_reason == EXIT_REASON_EPT_VIOLATION);
> +
> +	/* Validate GPA in fault */
> +	TDX_UPM_TEST_ASSERT(
> +		address_between(ve.gpa,
> +				test_area_gpa_private->focus_area,
> +				test_area_gpa_private->general_area_1));
> +
> +	tdx_test_send_64bit(TDX_UPM_TEST_ACCEPT_PRINT_PORT, ve.gpa);
> +
> +#define MEM_PAGE_ACCEPT_LEVEL_4K 0
> +#define MEM_PAGE_ACCEPT_LEVEL_2M 1
> +	ret = tdg_mem_page_accept(ve.gpa, MEM_PAGE_ACCEPT_LEVEL_4K);
> +	TDX_UPM_TEST_ASSERT(!ret);
> +}
> +
> +static void verify_upm_test(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm_vaddr_t test_area_gva_private;
> +	struct tdx_upm_test_area *test_area_base_hva;
> +	uint64_t test_area_npages;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_upm_explicit);
> +
> +	vm_install_exception_handler(vm, VE_VECTOR, guest_ve_handler);
> +
> +	/*
> +	 * Set up shared memory page for testing by first allocating as private
> +	 * and then mapping the same GPA again as shared. This way, the TD does
> +	 * not have to remap its page tables at runtime.
> +	 */
> +	test_area_npages = TDX_UPM_TEST_AREA_SIZE / vm->page_size;
> +	vm_userspace_mem_region_add(vm,
> +				    VM_MEM_SRC_ANONYMOUS, TDX_UPM_TEST_AREA_GPA,
> +				    3, test_area_npages, KVM_MEM_PRIVATE);
> +
> +	test_area_gva_private = ____vm_vaddr_alloc(
> +		vm, TDX_UPM_TEST_AREA_SIZE, TDX_UPM_TEST_AREA_GVA_PRIVATE,
> +		TDX_UPM_TEST_AREA_GPA, 3, true);
> +	TEST_ASSERT_EQ(test_area_gva_private, TDX_UPM_TEST_AREA_GVA_PRIVATE);
> +
> +	test_area_gpa_private = (struct tdx_upm_test_area *)
> +		addr_gva2gpa(vm, test_area_gva_private);
> +	virt_map_shared(vm, TDX_UPM_TEST_AREA_GVA_SHARED,
> +			(uint64_t)test_area_gpa_private,
> +			test_area_npages);
> +	TEST_ASSERT_EQ(addr_gva2gpa(vm, TDX_UPM_TEST_AREA_GVA_SHARED),
> +		  (vm_paddr_t)test_area_gpa_private);
> +
> +	test_area_base_hva = addr_gva2hva(vm, TDX_UPM_TEST_AREA_GVA_PRIVATE);
> +
> +	TEST_ASSERT(fill_and_check(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
> +		"Failed to mark memory intended as backing memory for TD shared memory");
> +
> +	sync_global_to_guest(vm, test_area_gpa_private);
> +	test_area_gpa_shared = (struct tdx_upm_test_area *)
> +		((uint64_t)test_area_gpa_private | BIT_ULL(vm->pa_bits - 1));
> +	sync_global_to_guest(vm, test_area_gpa_shared);
> +
> +	td_finalize(vm);
> +
> +	printf("Verifying UPM functionality: explicit MapGPA\n");
> +
> +	run_selftest(vm, vcpu, test_area_base_hva);
> +
> +	kvm_vm_free(vm);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	/* Disable stdout buffering */
> +	setbuf(stdout, NULL);
> +
> +	if (!is_tdx_enabled()) {
> +		printf("TDX is not supported by the KVM\n"
> +		       "Skipping the TDX tests.\n");
> +		return 0;
> +	}
> +
> +	run_in_new_process(&verify_upm_test);
> +}


