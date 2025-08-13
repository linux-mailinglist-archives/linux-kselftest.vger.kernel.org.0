Return-Path: <linux-kselftest+bounces-38846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7253BB247C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 12:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6B016F768
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 10:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D59B2F5499;
	Wed, 13 Aug 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P38m1KXr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E192D12E7;
	Wed, 13 Aug 2025 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082704; cv=none; b=iE1JYR8LeDP71NQzaGx0UKuzZ+BVQznqHBsy6EYHXfdpQUbZsLXe/uDgOWhymXENmPwl4NGa/ercr6XUqQJnZ82aTgzRrOnHhB/AlDjvpeKB11G8C+UvKLTav85ijYgEXAB3O//2MGXWXVfmwIFYh7Fiklbh3A1NuUbQoagJA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082704; c=relaxed/simple;
	bh=bWP5Ub5r0IQfPymsY+FHOTe4vBqnjir1TntxCYnqjj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqIyTwPD4G+t1Iip9FMbKEQR239NvSLsk2wRlXFz0Eekbso/dHaLoddcjbkUTxARwb/oaQKwXdlOVhPmiDxR0ve/Go4RVDLkp/zXt27EJnSXtz0F3KiJI/YiugNtemLj99sPGmyArY9cKUsGRLIcP7rV0m9uLV96V3gyJZ5/Xv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P38m1KXr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755082702; x=1786618702;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bWP5Ub5r0IQfPymsY+FHOTe4vBqnjir1TntxCYnqjj4=;
  b=P38m1KXrpSAO03vIKRKgOwqteMm+g84pPfCA4D8WH8D/G2mvE6MXVRi4
   UJceLAdgSv7++ZG7aJoamLVA6aXcbBaz5MwZy9lEZZIK6UaYkIamCv3zX
   FZM2ioWcH1/pJjPsvTohbIunfG0JeabVletFVW+X3tdoynqpTEaSvxTat
   MzAMLEvbhGhfj3mvJZY6uIOihx8ykquCmF6W7phbUPWhjKP4Qzw5B6u4t
   cvrME+MFo8BmPI+m/QyF6+NMFqgfHj3mx3DLfX3q1pJ3pKmbIL26O2hBA
   zZa3MwDnRIvgm8zqO5CO4jFHvOKl3zZNoZIbHZy/MflsnrUzhv3S3djt8
   g==;
X-CSE-ConnectionGUID: AtleROW5Tnu+2uMS3UtJbA==
X-CSE-MsgGUID: R3N9hso6SZG6yBMofTE6YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57450603"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57450603"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 03:58:22 -0700
X-CSE-ConnectionGUID: xK4cDpJYRsmEjHvBC9B8Dg==
X-CSE-MsgGUID: g3XgIGcGTSKoqAUgnV6ljw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166070360"
Received: from unknown (HELO [10.238.11.25]) ([10.238.11.25])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 03:58:18 -0700
Message-ID: <ef499c6e-d62c-450e-982b-82c53054ea53@linux.intel.com>
Date: Wed, 13 Aug 2025 18:58:15 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/30] KVM: selftests: TDX: Add report_fatal_error test
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
 <20250807201628.1185915-11-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250807201628.1185915-11-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> The test checks report_fatal_error functionality.
>
> TD guest can use TDG.VP.VMCALL<ReportFatalError> to report the fatal error
> it has experienced. TD guest is requesting a termination with the error
> information that include 16 general-purpose registers.

I think it's worth to mention that KVM converts TDG.VP.VMCALL<ReportFatalError>
to KVM_EXIT_SYSTEM_EVENT with the type KVM_SYSTEM_EVENT_TDX_FATAL.

>
> Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/include/x86/tdx/tdx.h       |  6 ++-
>   .../selftests/kvm/include/x86/tdx/tdx_util.h  |  1 +
>   .../selftests/kvm/include/x86/tdx/test_util.h | 19 +++++++
>   tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 18 +++++++
>   .../selftests/kvm/lib/x86/tdx/tdx_util.c      |  6 +++
>   .../selftests/kvm/lib/x86/tdx/test_util.c     | 10 ++++
>   tools/testing/selftests/kvm/x86/tdx_vm_test.c | 51 ++++++++++++++++++-
>   7 files changed, 108 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> index a7161efe4ee2..2acccc9dccf9 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> @@ -4,9 +4,13 @@
>   
>   #include <stdint.h>
>   
> +#include "kvm_util.h"
> +
> +#define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
> +
>   #define TDG_VP_VMCALL_INSTRUCTION_IO 30
>   
>   uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>   				      uint64_t write, uint64_t *data);
> -
> +void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
>   #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index 57a2f5893ffe..d66cf17f03ea 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -15,5 +15,6 @@ struct kvm_vm *td_create(void);
>   void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>   		   uint64_t attributes);
>   void td_finalize(struct kvm_vm *vm);
> +void td_vcpu_run(struct kvm_vcpu *vcpu);
>   
>   #endif // SELFTESTS_TDX_KVM_UTIL_H
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> index 07d63bf1ffe1..dafeee9af1dc 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> @@ -38,4 +38,23 @@ bool is_tdx_enabled(void);
>   void tdx_test_success(void);
>   void tdx_test_assert_success(struct kvm_vcpu *vcpu);
>   
> +/*
> + * Report an error with @error_code to userspace.
> + *
> + * Return value from tdg_vp_vmcall_report_fatal_error() is ignored since
> + * execution is not expected to continue beyond this point.
> + */
> +void tdx_test_fatal(uint64_t error_code);
> +
> +/*
> + * Report an error with @error_code to userspace.
> + *
> + * @data_gpa may point to an optional shared guest memory holding the error
> + * string.

A according to the GHCI spec, this is the optional GPA pointing to a shared guest memory, but in these TDX KVM selftest cases, it may not used that way. It may need some clarification about it. And based on the usage in this patch series, the name data_gpa may be misleading.


> + *
> + * Return value from tdg_vp_vmcall_report_fatal_error() is ignored since
> + * execution is not expected to continue beyond this point.
> + */
> +void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
> +
>   #endif // SELFTEST_TDX_TEST_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> index f417ee75bee2..ba088bfc1e62 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> @@ -1,5 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   
> +#include <string.h>
> +
>   #include "tdx/tdcall.h"
>   #include "tdx/tdx.h"
>   
> @@ -25,3 +27,19 @@ uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>   
>   	return ret;
>   }
> +
> +void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa)
> +{
> +	struct tdx_hypercall_args args;
> +
> +	memset(&args, 0, sizeof(struct tdx_hypercall_args));
> +
> +	if (data_gpa)
> +		error_code |= 0x8000000000000000;
> +
> +	args.r11 = TDG_VP_VMCALL_REPORT_FATAL_ERROR;
> +	args.r12 = error_code;
> +	args.r13 = data_gpa;
> +
> +	__tdx_hypercall(&args, 0);
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index e2bf9766dc03..5e4455be828a 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -9,6 +9,7 @@
>   #include "kvm_util.h"
>   #include "processor.h"
>   #include "tdx/td_boot.h"
> +#include "tdx/tdx.h"
>   #include "test_util.h"
>   
>   uint64_t tdx_s_bit;
> @@ -603,3 +604,8 @@ void td_finalize(struct kvm_vm *vm)
>   
>   	tdx_td_finalize_mr(vm);
>   }
> +
> +void td_vcpu_run(struct kvm_vcpu *vcpu)
> +{
> +	vcpu_run(vcpu);
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> index 7355b213c344..6c82a0c3bd37 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> @@ -59,3 +59,13 @@ void tdx_test_assert_success(struct kvm_vcpu *vcpu)
>   		    vcpu->run->io.port, vcpu->run->io.size,
>   		    vcpu->run->io.direction);
>   }
> +
> +void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa)
> +{
> +	tdg_vp_vmcall_report_fatal_error(error_code, data_gpa);
> +}
> +
> +void tdx_test_fatal(uint64_t error_code)
> +{
> +	tdx_test_fatal_with_data(error_code, 0);
> +}
> diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> index fdb7c40065a6..7d6d71602761 100644
> --- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> +++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> @@ -3,6 +3,7 @@
>   #include <signal.h>
>   
>   #include "kvm_util.h"
> +#include "tdx/tdx.h"
>   #include "tdx/tdx_util.h"
>   #include "tdx/test_util.h"
>   #include "test_util.h"
> @@ -24,7 +25,51 @@ static void verify_td_lifecycle(void)
>   
>   	printf("Verifying TD lifecycle:\n");
>   
> -	vcpu_run(vcpu);
> +	td_vcpu_run(vcpu);
> +	tdx_test_assert_success(vcpu);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
> +void guest_code_report_fatal_error(void)
> +{
> +	uint64_t err;
> +
> +	/*
> +	 * Note: err should follow the GHCI spec definition:
> +	 * bits 31:0 should be set to 0.
> +	 * bits 62:32 are used for TD-specific extended error code.
> +	 * bit 63 is used to mark additional information in shared memory.
> +	 */
> +	err = 0x0BAAAAAD00000000;
> +	tdx_test_fatal(err);
> +
> +	tdx_test_success();
> +}
> +
> +void verify_report_fatal_error(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_code_report_fatal_error);
> +	td_finalize(vm);
> +
> +	printf("Verifying report_fatal_error:\n");
> +
> +	td_vcpu_run(vcpu);
> +
> +	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_TDX_FATAL);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 16);
> +
> +	TEST_ASSERT_EQ(vcpu->run->system_event.data[12], 0x0BAAAAAD00000000);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.data[13], 0);
> +
> +	td_vcpu_run(vcpu);
>   	tdx_test_assert_success(vcpu);
>   
>   	kvm_vm_free(vm);
> @@ -38,9 +83,11 @@ int main(int argc, char **argv)
>   	if (!is_tdx_enabled())
>   		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
>   
> -	ksft_set_plan(1);
> +	ksft_set_plan(2);
>   	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
>   			 "verify_td_lifecycle\n");
> +	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
> +			 "verify_report_fatal_error\n");
>   
>   	ksft_finished();
>   	return 0;


