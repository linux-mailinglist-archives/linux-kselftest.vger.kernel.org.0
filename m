Return-Path: <linux-kselftest+bounces-39066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D06B2798C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 09:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A211C20E92
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 07:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933FF21C9F2;
	Fri, 15 Aug 2025 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVEZioDm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90990319863;
	Fri, 15 Aug 2025 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241418; cv=none; b=e5nXj8q5+4dVlpS+lpicwzpshLYH07jMHkhr8tIcplRZh4KLnE4Xuyzv5/PcxIcoUWBXomP7F9/1BkTU4Ny9BrIZYFFNhcV1hc6rPlnyLVFLebMFhs2f0k3tFJSyAgF6gYSsw6eFkm9knj1t+bVr3x526EKOt5FHCrFw9fMn++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241418; c=relaxed/simple;
	bh=uyQ8TqPrv9XTdBRGBX6VcARllMEFKO8Lsx+niwWXvnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snxOLYXwv3/wxjM4SNnSJTZus4LDTt4Dwjbz3iCWz2h24hwsdi9A2O+CT4pjJfvGP3jPqCStpe6Qdeh0ug6friUBTupBx7SYzsJ/xRwTAT5a4CxFdDGnQjL/CQejqtcWaP8IBHocl1CW6GbOm471bUZkUjCL1hzAcqSsFKRyJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVEZioDm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755241416; x=1786777416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uyQ8TqPrv9XTdBRGBX6VcARllMEFKO8Lsx+niwWXvnA=;
  b=SVEZioDmJddqGHJWBkKX1pdHvd/v6RLruzJ5/jJ+RgGuzse3ZYsfolJR
   bpFYRd85EK1RLX1471dEFRpPJAHkvm/TXF/+fAxkdPVTKjREaqiMnWaGm
   aLguXUQbf8u6akYRtDWzr0cLWgW30BIWIztcFGtF1tnyEIQG16AEPHs44
   UdLnKOQICsMgltTiKrLF/k1NCkVKa+HQ0gi+GGUdS+zwI/T7uLiVUF+72
   z6HJ2vQedY6xyUXtvjqIaeivrJIA9QFImwfixBVnO/2jMlb7cL/Rmua4A
   reQ6gf238713+J5/J6AL8tqHeYpBM85ChTbqJ1ubdOjLBavG/O6i61TTX
   A==;
X-CSE-ConnectionGUID: K4Td4ksyQVa9jsBlXobOvw==
X-CSE-MsgGUID: tSYuZL24SVC7DlmCUh1/QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57476468"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57476468"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 00:03:35 -0700
X-CSE-ConnectionGUID: eXUjp7qJQHCi/qN2FlywHA==
X-CSE-MsgGUID: C5inRS7+TXmQgRlBU77KQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167762943"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 00:03:31 -0700
Message-ID: <12621c4e-d092-49a2-9d02-e045c5e519a7@linux.intel.com>
Date: Fri, 15 Aug 2025 15:03:29 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 28/30] KVM: selftests: TDX: Add TDX UPM selftest
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny
 <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-29-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250807201628.1185915-29-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> This tests the use of guest memory with explicit TDG.VP.VMCALL<MapGPA>
> calls.
>
> Provide a 2MB memory region to the TDX guest with a 40KB focus area at
> offset 1MB intended to be shared between host and guest. The entire 2MB
> region starts out as private with the guest filling it with a pattern and
> a check from the host to ensure the host is not able to see the pattern.
> The guest then requests via TDG.VP.VMCALL<MapGPA> that the 40KB focus area
> be shared with checks that the host and guest has the same view of the
> memory. Finally the guest requests the 40KB memory to be private again
> with checks to confirm this is the case.
>
> Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>   .../testing/selftests/kvm/x86/tdx_upm_test.c  | 397 ++++++++++++++++++
>   2 files changed, 398 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/x86/tdx_upm_test.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index bdeb40a258e1..191fc5dad854 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -153,6 +153,7 @@ TEST_GEN_PROGS_x86 += system_counter_offset_test
>   TEST_GEN_PROGS_x86 += pre_fault_memory_test
>   TEST_GEN_PROGS_x86 += x86/tdx_vm_test
>   TEST_GEN_PROGS_x86 += x86/tdx_shared_mem_test
> +TEST_GEN_PROGS_x86 += x86/tdx_upm_test
>   
>   # Compiled outputs used by test targets
>   TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
> diff --git a/tools/testing/selftests/kvm/x86/tdx_upm_test.c b/tools/testing/selftests/kvm/x86/tdx_upm_test.c
> new file mode 100644
> index 000000000000..387258ab1a62
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/tdx_upm_test.c
> @@ -0,0 +1,397 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <asm/kvm.h>
> +#include <asm/vmx.h>
> +#include <linux/kvm.h>
> +#include <linux/sizes.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +
> +#include "kvm_util.h"
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
It sounds not accurate.

TDX_UPM_TEST_AREA_GVA_SHARED is used to map the the shared GPA
TDX_UPM_TEST_AREA_GVA_PRIVATE is used to map the private GPA.

(of course, the use of term "UPM" should also be fixed.)

> +#define TDX_UPM_TEST_AREA_GVA_SHARED				\
> +	(TDX_UPM_TEST_AREA_GVA_PRIVATE |			\
> +		BIT_ULL(TDX_UPM_TEST_AREA_GVA_SHARED_BIT))
> +
> +/* The test area is 2MB in size */
> +#define TDX_UPM_TEST_AREA_SIZE SZ_2M
> +/* 0th general area is 1MB in size */
> +#define TDX_UPM_GENERAL_AREA_0_SIZE SZ_1M
> +/* Focus area is 40KB in size */
> +#define TDX_UPM_FOCUS_AREA_SIZE (SZ_32K + SZ_8K)

Any specific reason for the size?


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

permission -> attribute
(here and below)



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
> +			   uint8_t pattern)
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

The helpers seem not necessary.

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
> +/*
> + * Does vcpu_run, and also manages memory conversions if requested by the TD.
> + */
> +void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
> +					    struct kvm_vcpu *vcpu)
> +{
> +	for (;;) {
> +		vcpu_run(vcpu);
> +		if (vcpu->run->exit_reason == KVM_EXIT_HYPERCALL &&
> +		    vcpu->run->hypercall.nr == KVM_HC_MAP_GPA_RANGE) {
> +			uint64_t gpa = vcpu->run->hypercall.args[0];
> +
> +			handle_memory_conversion(vm, vcpu->id, gpa,
> +						 vcpu->run->hypercall.args[1] << 12,
> +						 vcpu->run->hypercall.args[2] &
> +						  KVM_MAP_GPA_RANGE_ENCRYPTED);
> +			vcpu->run->hypercall.ret = 0;
> +			continue;
> +		} else if (vcpu->run->exit_reason == KVM_EXIT_IO &&
> +			   vcpu->run->io.port == TDX_UPM_TEST_ACCEPT_PRINT_PORT) {
> +			uint64_t gpa = tdx_test_read_64bit(vcpu,
> +							   TDX_UPM_TEST_ACCEPT_PRINT_PORT);
> +
> +			printf("\t ... guest accepting 1 page at GPA: 0x%lx\n",
> +			       gpa);
Turn it to debug info?

> +			continue;
> +		} else if (vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT) {
> +			TEST_FAIL("Guest reported error. error code: %lld (0x%llx)\n",
> +				  vcpu->run->system_event.data[12],
> +				  vcpu->run->system_event.data[13]);
> +		}
> +		break;
> +	}
> +}
> +
> +static void guest_upm_explicit(void)
> +{
> +	struct tdx_upm_test_area *test_area_gva_private =
> +		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_PRIVATE;
> +	struct tdx_upm_test_area *test_area_gva_shared =
> +		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_SHARED;
> +	uint64_t failed_gpa;
> +	uint64_t ret = 0;
> +
> +	/* Check: host reading private memory does not modify guest's view */
> +	fill_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL);
> +
> +	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
> +
> +	TDX_UPM_TEST_ASSERT(check_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL));
> +
> +	/* Remap focus area as shared */

Better to use convert instead of remap?
(here and others in the patch)

> +	ret = tdg_vp_vmcall_map_gpa((uint64_t)test_area_gpa_shared->focus_area,
> +				    sizeof(test_area_gpa_shared->focus_area),
> +				    &failed_gpa);
> +	TDX_UPM_TEST_ASSERT(!ret);
> +
> +	/* General areas should be unaffected by remapping */
> +	TDX_UPM_TEST_ASSERT(check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
> +
> +	/*
> +	 * Use memory contents to confirm that the memory allocated using mmap
> +	 * is used as backing memory for shared memory - PATTERN_CONFIDENCE_CHECK
> +	 * was written by the VMM at the beginning of this test.
> +	 */
> +	TDX_UPM_TEST_ASSERT(check_focus_area(test_area_gva_shared, PATTERN_CONFIDENCE_CHECK));
> +
> +	/* Guest can use focus area after remapping as shared */
> +	fill_focus_area(test_area_gva_shared, PATTERN_GUEST_FOCUS);
> +
> +	tdx_test_report_to_user_space(SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
> +
> +	/* Check that guest has the same view of shared memory */
> +	TDX_UPM_TEST_ASSERT(check_focus_area(test_area_gva_shared, PATTERN_HOST_FOCUS));
> +
> +	/* Remap focus area back to private */
> +	ret = tdg_vp_vmcall_map_gpa((uint64_t)test_area_gpa_private->focus_area,
> +				    sizeof(test_area_gpa_private->focus_area),
> +				    &failed_gpa);
> +	TDX_UPM_TEST_ASSERT(!ret);
> +
> +	/* General areas should be unaffected by remapping */
> +	TDX_UPM_TEST_ASSERT(check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
> +
> +	/* Focus area should be zeroed after remapping */
> +	TDX_UPM_TEST_ASSERT(check_focus_area(test_area_gva_private, 0));
> +
> +	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
> +
> +	/* Check that guest can use private memory after focus area is remapped as private */
> +	TDX_UPM_TEST_ASSERT(fill_and_check(test_area_gva_private, PATTERN_GUEST_GENERAL));
> +
> +	tdx_test_success();
> +}
> +
> +static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
> +			 struct tdx_upm_test_area *test_area_base_hva)
> +{
> +	tdx_run(vcpu);
> +	tdx_test_assert_io(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
> +			   PORT_WRITE);
> +	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
> +		       SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
> +
> +	/*
> +	 * Check that host sees PATTERN_CONFIDENCE_CHECK when trying to read guest
> +	 * private memory. This confirms that regular memory (userspace_addr in
> +	 * struct kvm_userspace_memory_region) is used to back the host's view
> +	 * of private memory, since PATTERN_CONFIDENCE_CHECK was written to that
> +	 * memory before starting the guest.
> +	 */
> +	TEST_ASSERT(check_test_area(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
> +		    "Host should read PATTERN_CONFIDENCE_CHECK from guest's private memory.");

It's not reading from guest's private memory as what the comments say.

One thing to mention is that when the in-place conversion for guest_memfd is
ready, some of the cases will not be valid.
But I guess it could be future work?


> +
> +	vcpu_run_and_manage_memory_conversions(vm, vcpu);
> +	tdx_test_assert_io(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
> +			   PORT_WRITE);
> +	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
> +		       SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
> +
> +	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_GUEST_FOCUS),
> +		    "Host should have the same view of shared memory as guest.");
> +	TEST_ASSERT(check_general_areas(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
> +		    "Host's view of private memory should still be backed by regular memory.");
> +
> +	/* Check that host can use shared memory */
> +	fill_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS);
> +	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
> +		    "Host should be able to use shared memory.");
> +
> +	vcpu_run_and_manage_memory_conversions(vm, vcpu);
> +	tdx_test_assert_io(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
> +			   PORT_WRITE);
> +	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
> +		       SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
> +
> +	TEST_ASSERT(check_general_areas(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
> +		    "Host's view of private memory should be backed by regular memory.");
> +	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
> +		    "Host's view of private memory should be backed by regular memory.");
> +
> +	tdx_run(vcpu);
> +	tdx_test_assert_success(vcpu);
> +
> +	printf("\t ... PASSED\n");
> +}
> +
>
[...]

