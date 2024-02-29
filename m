Return-Path: <linux-kselftest+bounces-5638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99786CA1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 14:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFAE01F22FB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 13:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548C57E561;
	Thu, 29 Feb 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lw+5Xmlm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF227E111;
	Thu, 29 Feb 2024 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212859; cv=none; b=TBWkHKHiB7LrIvIK2B7UceFWrCOph4w2YoTNQmNFYVWAxNfxTCEUAgW2+mbNGwsM+fdtDY1ew3WfHi3k9gXjVBtHs0zXlwEaFgA5QL+E+PKHWBDeBE2isRCuIA3sk8te/fy5RdSUTsuftJf8GNMELASvvrY3cXnOW163mE9Ubjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212859; c=relaxed/simple;
	bh=tTL87iMGZEk33vzaUvdAz+e1baooBztQzpXVo3p2Pbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVXnM7KDgXiJRo4/vNu8X180zIreModvrj7eLExhx5Hny2TB+rKw+wVTBsF8ObW3R447keVUkPwa4kJj03wWKywy+cA6rNDz05Xxk74Ztgr3vPjfgrOOTCuZ/3oavhdADgfe8BYnc0wvc3B29AtPWTDa68vnDG3X39ir3rs12AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lw+5Xmlm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709212858; x=1740748858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tTL87iMGZEk33vzaUvdAz+e1baooBztQzpXVo3p2Pbg=;
  b=lw+5Xmlmz7QirCTcP2FY1YK+kJeGJUqpCplFfYRolMZ3ojM2KOAiJZxy
   yfIG0ZTnbOcIy+UliJ0cC90h8uvU1tLbzQOWfPMwCtTB/Ol4uuRWD+PDn
   p9sXBoOWplE1tMZDMa8z3I1CH11fpg3N3tsVdvLmYY+eD9WrFP50kXkwr
   vqwclJuvfKPLNSErN6vHyMOVp9zsVKnFAaxqLqYtKZ5z7cNPe2EFCJIeW
   Eu41zBZiyeNZl89fCgUF/SR0HwEE0scWn4/YgZldXkojkvUJ3A6iED2Xw
   G2KI208ueti/okAQemMIMvjWXO3+mrWUlnS8cSL+aDFGkzKvQgYVUvCLA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3845283"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3845283"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 05:20:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="12437975"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.225.159]) ([10.124.225.159])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 05:20:50 -0800
Message-ID: <1334f23c-2d9d-4d89-8b8e-98cf8d712daf@linux.intel.com>
Date: Thu, 29 Feb 2024 21:20:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 10/29] KVM: selftests: TDX: Adding test case for
 TDX port IO
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
 <20231212204647.2170650-11-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-11-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> From: Erdem Aktas <erdemaktas@google.com>
>
> Verifies TDVMCALL<INSTRUCTION.IO> READ and WRITE operations.
>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> ---
>   .../kvm/include/x86_64/tdx/test_util.h        | 34 ++++++++
>   .../selftests/kvm/x86_64/tdx_vm_tests.c       | 82 +++++++++++++++++++
>   2 files changed, 116 insertions(+)

One nit comment below.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> index 6d69921136bd..95a5d5be7f0b 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> @@ -9,6 +9,40 @@
>   #define TDX_TEST_SUCCESS_PORT 0x30
>   #define TDX_TEST_SUCCESS_SIZE 4
>   
> +/**
> + * Assert that some IO operation involving tdg_vp_vmcall_instruction_io() was
> + * called in the guest.
> + */
> +#define TDX_TEST_ASSERT_IO(VCPU, PORT, SIZE, DIR)			\
> +	do {								\
> +		TEST_ASSERT((VCPU)->run->exit_reason == KVM_EXIT_IO,	\
> +			"Got exit_reason other than KVM_EXIT_IO: %u (%s)\n", \
> +			(VCPU)->run->exit_reason,			\
> +			exit_reason_str((VCPU)->run->exit_reason));	\
> +									\
> +		TEST_ASSERT(((VCPU)->run->exit_reason == KVM_EXIT_IO) && \
> +			((VCPU)->run->io.port == (PORT)) &&		\
> +			((VCPU)->run->io.size == (SIZE)) &&		\
> +			((VCPU)->run->io.direction == (DIR)),		\
> +			"Got unexpected IO exit values: %u (%s) %d %d %d\n", \
> +			(VCPU)->run->exit_reason,			\
> +			exit_reason_str((VCPU)->run->exit_reason),	\
> +			(VCPU)->run->io.port, (VCPU)->run->io.size,	\
> +			(VCPU)->run->io.direction);			\
> +	} while (0)
> +
> +/**
> + * Check and report if there was some failure in the guest, either an exception
> + * like a triple fault, or if a tdx_test_fatal() was hit.
> + */
> +#define TDX_TEST_CHECK_GUEST_FAILURE(VCPU)				\
> +	do {								\
> +		if ((VCPU)->run->exit_reason == KVM_EXIT_SYSTEM_EVENT)	\
> +			TEST_FAIL("Guest reported error. error code: %lld (0x%llx)\n", \
> +				(VCPU)->run->system_event.data[1],	\
> +				(VCPU)->run->system_event.data[1]);	\
> +	} while (0)
> +
>   /**
>    * Assert that tdx_test_success() was called in the guest.
>    */
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> index 8638c7bbedaa..75467c407ca7 100644
> --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> @@ -2,6 +2,7 @@
>   
>   #include <signal.h>
>   #include "kvm_util_base.h"
> +#include "tdx/tdcall.h"
>   #include "tdx/tdx.h"
>   #include "tdx/tdx_util.h"
>   #include "tdx/test_util.h"
> @@ -74,6 +75,86 @@ void verify_report_fatal_error(void)
>   	printf("\t ... PASSED\n");
>   }
>   
> +#define TDX_IOEXIT_TEST_PORT 0x50
> +
> +/*
> + * Verifies IO functionality by writing a |value| to a predefined port.
> + * Verifies that the read value is |value| + 1 from the same port.
> + * If all the tests are passed then write a value to port TDX_TEST_PORT
> + */
> +void guest_ioexit(void)
> +{
> +	uint64_t data_out, data_in, delta;
> +	uint64_t ret;
> +
> +	data_out = 0xAB;
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
> +					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> +					&data_out);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
> +					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
> +					&data_in);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	delta = data_in - data_out;
> +	if (delta != 1)

Nit: Is it more direct to compare data_in with 0xAC?

> +		tdx_test_fatal(ret);
> +
> +	tdx_test_success();
> +}
> +
> +void verify_td_ioexit(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	uint32_t port_data;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_ioexit);
> +	td_finalize(vm);
> +
> +	printf("Verifying TD IO Exit:\n");
> +
> +	/* Wait for guest to do a IO write */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_IOEXIT_TEST_PORT, 1,
> +			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	port_data = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
> +
> +	printf("\t ... IO WRITE: OK\n");
> +
> +	/*
> +	 * Wait for the guest to do a IO read. Provide the previous written data
> +	 * + 1 back to the guest
> +	 */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_IOEXIT_TEST_PORT, 1,
> +			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
> +	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = port_data + 1;
> +
> +	printf("\t ... IO READ: OK\n");
> +
> +	/*
> +	 * Wait for the guest to complete execution successfully. The read
> +	 * value is checked within the guest.
> +	 */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +	printf("\t ... IO verify read/write values: OK\n");
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	setbuf(stdout, NULL);
> @@ -85,6 +166,7 @@ int main(int argc, char **argv)
>   
>   	run_in_new_process(&verify_td_lifecycle);
>   	run_in_new_process(&verify_report_fatal_error);
> +	run_in_new_process(&verify_td_ioexit);
>   
>   	return 0;
>   }


