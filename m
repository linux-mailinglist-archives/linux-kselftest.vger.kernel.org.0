Return-Path: <linux-kselftest+bounces-38929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D08D5B259CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 05:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0592D6871E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 03:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37923ABA7;
	Thu, 14 Aug 2025 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGivc6y7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5302FF65E;
	Thu, 14 Aug 2025 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141851; cv=none; b=nrZjGEKu6ViZz4rbIf38oq+yht5fBwBWCi7SbwucL+/2PyxlJHkneT6apUQIdXT0vjRoNjNGGwc6T6Ujx3EvyAX6QY2Lv7bZjb3gpG2vdd3iWNyLwzO+r8MN8yWtDEQ7SMh/Lm8bG/T2p+5Lb9RJQGHCtwptrHhMDPPGv5hFXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141851; c=relaxed/simple;
	bh=4THZIfgDYIgbaBQu5Q+kcCrH/ehvQ/jbsk2mCLf/DMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCyQdTlQ0t4pI2pxUcKKAEmk04HCHqKHVtHsyWX8vESLS39QkQZeNCIIvLQenwbIAmr+f9w46AibcqdeYQQ5o/JXY8Qi6riI4ee8IZTePf6aW4UDWk5aI4aMHvssxsybBOjI7mTXYnQqnwRenOl/CAvduVR2AHzZCAis3tO0plM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGivc6y7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755141849; x=1786677849;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4THZIfgDYIgbaBQu5Q+kcCrH/ehvQ/jbsk2mCLf/DMs=;
  b=XGivc6y7tcr7Pz0AsNm1giPmgYIqg+/CbEeHm8Gm0UU4W35hIOpzZVv4
   d3gkJWeqm/rARnhX/6ztSQzH0sbu1BxHj61c2nxVAxEGXCSElPJH7VuO3
   KZ2bG35nI3WKZbMujnmhCnKjJDAPVDq188nApysm24bwurdF0d+k6ppOA
   pRUYMXM+4+/l18vUS+ELIUrJstJd+YLJhPsJd0gDy25c1e4UcRIRjhfrh
   XK2weO62HoxCpNpF/zBIHD+I08L7VtRDm19lJ/E2PxO+27tp01iTTpeTl
   GU8c+Snq9XCufdtBQNpKNExP0BQ37n9pop4fhJkOUwfALEPBUo8uDgaDU
   Q==;
X-CSE-ConnectionGUID: 3RLcp5VWTGyiMFk+jhb8hQ==
X-CSE-MsgGUID: LP4v0Q4jSzKqNGAhPXT1PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61254329"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61254329"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 20:24:08 -0700
X-CSE-ConnectionGUID: rGuHvHPrS8evz3mw/+y8EA==
X-CSE-MsgGUID: sG/OWt6STeeHP++lKhPLEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="167447816"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 20:24:04 -0700
Message-ID: <6aa15d1d-b67a-4c94-b6f0-674531ba7a63@linux.intel.com>
Date: Thu, 14 Aug 2025 11:24:02 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/30] KVM: selftests: TDX: Adding test case for TDX
 port IO
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
 <20250807201628.1185915-12-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250807201628.1185915-12-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> Verifies TDVMCALL<INSTRUCTION.IO> READ and WRITE operations.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/include/x86/tdx/test_util.h | 20 +++++
>   .../selftests/kvm/lib/x86/tdx/test_util.c     | 35 +++++++++
>   tools/testing/selftests/kvm/x86/tdx_vm_test.c | 78 ++++++++++++++++++-
>   3 files changed, 130 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> index dafeee9af1dc..cf11955d56d6 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> @@ -13,6 +13,19 @@
>   #define PORT_READ	0
>   #define PORT_WRITE	1
>   
> +/*
> + * Assert that some IO operation involving tdg_vp_vmcall_instruction_io() was
> + * called in the guest.
> + */
> +void tdx_test_assert_io(struct kvm_vcpu *vcpu, uint16_t port, uint8_t size,
> +			uint8_t direction);
> +
> +/*
> + * Run the tdx vcpu and check if there was some failure in the guest, either
> + * an exception like a triple fault,

Only "KVM_EXIT_SYSTEM_EVENT" is checked in the implementation.

> or if a tdx_test_fatal() was hit.
> + */
> +void tdx_run(struct kvm_vcpu *vcpu);
> +
>   /*
>    * Run a test in a new process.
>    *
> @@ -57,4 +70,11 @@ void tdx_test_fatal(uint64_t error_code);
>    */
>   void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
>   
> +/*
> + * Assert on @error and report the @error to userspace.
> + * Return value from tdg_vp_vmcall_report_fatal_error() is ignored since execution
> + * is not expected to continue beyond this point.
> + */
> +void tdx_assert_error(uint64_t error);
> +
>   #endif // SELFTEST_TDX_TEST_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> index 6c82a0c3bd37..4ccc5298ba25 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> @@ -8,8 +8,37 @@
>   
>   #include "kvm_util.h"
>   #include "tdx/tdx.h"
> +#include "tdx/tdx_util.h"
>   #include "tdx/test_util.h"
>   
> +void tdx_test_assert_io(struct kvm_vcpu *vcpu, uint16_t port, uint8_t size,
> +			uint8_t direction)
> +{
> +	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_IO,
> +		    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
> +		    vcpu->run->exit_reason,
> +		    exit_reason_str(vcpu->run->exit_reason));
> +
> +	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_IO &&

KVM_EXIT_IO has been checked above already.


> +		    vcpu->run->io.port == port &&
> +		    vcpu->run->io.size == size &&
> +		    vcpu->run->io.direction == direction,
> +		    "Got unexpected IO exit values: %u (%s) %u %u %u\n",
> +		    vcpu->run->exit_reason,
> +		    exit_reason_str(vcpu->run->exit_reason),

the exit reason info could be removed since it is redundant
> +		    vcpu->run->io.port, vcpu->run->io.size,
> +		    vcpu->run->io.direction);
> +}
> +
> +void tdx_run(struct kvm_vcpu *vcpu)
> +{
> +	td_vcpu_run(vcpu);
> +	if (vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT)
> +		TEST_FAIL("Guest reported error. error code: %lld (0x%llx)\n",
> +			  vcpu->run->system_event.data[12],
> +			  vcpu->run->system_event.data[13]);
> +}
> +
>   int run_in_new_process(void (*func)(void))
>   {
>   	int wstatus;
> @@ -69,3 +98,9 @@ void tdx_test_fatal(uint64_t error_code)
>   {
>   	tdx_test_fatal_with_data(error_code, 0);
>   }
> +
> +void tdx_assert_error(uint64_t error)
> +{
> +	if (error)
> +		tdx_test_fatal(error);
> +}
> diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> index 7d6d71602761..97330e28f236 100644
> --- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> +++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> @@ -3,6 +3,7 @@
>   #include <signal.h>
>   
>   #include "kvm_util.h"
> +#include "tdx/tdcall.h"
>   #include "tdx/tdx.h"
>   #include "tdx/tdx_util.h"
>   #include "tdx/test_util.h"
> @@ -25,7 +26,7 @@ static void verify_td_lifecycle(void)
>   
>   	printf("Verifying TD lifecycle:\n");
>   
> -	td_vcpu_run(vcpu);
> +	tdx_run(vcpu);
>   	tdx_test_assert_success(vcpu);
>   
>   	kvm_vm_free(vm);
> @@ -69,9 +70,78 @@ void verify_report_fatal_error(void)
>   	TEST_ASSERT_EQ(vcpu->run->system_event.data[12], 0x0BAAAAAD00000000);
>   	TEST_ASSERT_EQ(vcpu->run->system_event.data[13], 0);
>   
> -	td_vcpu_run(vcpu);
> +	tdx_run(vcpu);
> +	tdx_test_assert_success(vcpu);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
> +#define TDX_IOEXIT_TEST_PORT 0x50
> +
> +/*
> + * Verifies IO functionality by writing a |value| to a predefined port.
> + * Verifies that the read value is |value| + 1 from the same port.
> + * If all the tests are passed then write a value to port TDX_TEST_PORT
TDX_TEST_PORT should be TDX_TEST_SUCCESS_PORT?

> + */
> +void guest_ioexit(void)
> +{
> +	uint64_t data_out, data_in;
> +	uint64_t ret;
> +
> +	data_out = 0xAB;
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
> +					   PORT_WRITE, &data_out);
> +	tdx_assert_error(ret);

Is it better to move the tdx_assert_error() inside
tdg_vp_vmcall_instruction_io()? So that the callers can skip the check for each
call to tdg_vp_vmcall_instruction_io().

> +
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
> +					   PORT_READ, &data_in);
> +	tdx_assert_error(ret);
> +
> +	if (data_in != 0xAC)
> +		tdx_test_fatal(data_in);
> +
> +	tdx_test_success();
> +}
> +
> +void verify_td_ioexit(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	uint32_t port_data;
> +	struct kvm_vm *vm;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_ioexit);
> +	td_finalize(vm);
> +
> +	printf("Verifying TD IO Exit:\n");
> +
> +	/* Wait for guest to do a IO write */
> +	tdx_run(vcpu);
> +	tdx_test_assert_io(vcpu, TDX_IOEXIT_TEST_PORT, 1, PORT_WRITE);
> +	port_data = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
> +
> +	printf("\t ... IO WRITE: DONE\n");
> +
> +	/*
> +	 * Wait for the guest to do a IO read. Provide the previous written data
> +	 * + 1 back to the guest
> +	 */
> +	tdx_run(vcpu);
> +	tdx_test_assert_io(vcpu, TDX_IOEXIT_TEST_PORT, 1, PORT_READ);
> +	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = port_data + 1;
> +
> +	printf("\t ... IO READ: DONE\n");
> +
> +	/*
> +	 * Wait for the guest to complete execution successfully. The read
> +	 * value is checked within the guest.
> +	 */
> +	tdx_run(vcpu);
>   	tdx_test_assert_success(vcpu);
>   
> +	printf("\t ... IO verify read/write values: OK\n");
>   	kvm_vm_free(vm);
>   	printf("\t ... PASSED\n");
>   }
> @@ -83,11 +153,13 @@ int main(int argc, char **argv)
>   	if (!is_tdx_enabled())
>   		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
>   
> -	ksft_set_plan(2);
> +	ksft_set_plan(3);
>   	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
>   			 "verify_td_lifecycle\n");
>   	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
>   			 "verify_report_fatal_error\n");
> +	ksft_test_result(!run_in_new_process(&verify_td_ioexit),
> +			 "verify_td_ioexit\n");
>   
>   	ksft_finished();
>   	return 0;


