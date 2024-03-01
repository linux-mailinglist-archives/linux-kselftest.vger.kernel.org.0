Return-Path: <linux-kselftest+bounces-5691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD6D86DBAE
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 07:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1369D1F22CB5
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 06:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942D767E9D;
	Fri,  1 Mar 2024 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7IoLJHO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE167C6B;
	Fri,  1 Mar 2024 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275967; cv=none; b=acBExd7gEsQxkACcal0MrtWyL6LC4mrvf9dsLUtu8ieNHCnM216GqjJZLVkJ9EGZLQEQfQm6Wmz0V03kpG91OSiV/Yh6/mo+tEgPYVkO+Q8nzuRFhI2Tru5vHZLLwpcul7nQ2O6OCwxSWByumkoNgjS42HJP5zfZpU2siT9vZiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275967; c=relaxed/simple;
	bh=PZcAanboKcUp2tLccdXfkXE1+xs/N+nzxRhzAH5IS9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULPCcn5oTcl/Soy0anoDQYPrCz1eciRWF1DJ/wzutz3zrzWDYjTjNzXN7dy//ka3aQAGCcZhUp4LSj4HuTTeMnqbbzY/xwVR4LqZgCL+xVlByJm2erYP3eZPy3o+7bvIfdOfR4sWrD9W1QkV2Hp/qa3BcC8azFFPzIqWzsQq5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7IoLJHO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709275965; x=1740811965;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PZcAanboKcUp2tLccdXfkXE1+xs/N+nzxRhzAH5IS9w=;
  b=n7IoLJHOmuYkbcUqOPJv1/IeV+2FWXoWGgspUWPgIc/BcmIs7LQWj0G0
   AQc5EoLx+6YDAK+AF1eVPS1It0tdt/X+SImWi1nDUWYmhYpvOuGadMAEt
   q61tVdbAkC0OlXX3oqB9NV01J7tIw7bgrEt1u9Fhp9kimM4bL+E2aNyWX
   j1o5qPzvZNSzE1624r1cRxOTreEsM1CKjEuWjwi/KPgI9DkWh2u8jSh6H
   9rmPxD3ZEkn7P5C9MT3QvxIhBnnnv+0IK5lJ6XOrK1yS404CE4f4wK+1V
   7TzjsOR0rX/3UPRF9GJejH4q6EVSi+ewgv8HFJfyOG8kPoUisitTKx3il
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3957530"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="3957530"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 22:52:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8035272"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.125.242.247]) ([10.125.242.247])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 22:52:40 -0800
Message-ID: <704b58a8-2893-4fdb-8171-395bcd7166a7@linux.intel.com>
Date: Fri, 1 Mar 2024 14:52:36 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 09/29] KVM: selftests: TDX: Add report_fatal_error
 test
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
 <20231212204647.2170650-10-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-10-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> The test checks report_fatal_error functionality.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> ---
>   .../selftests/kvm/include/x86_64/tdx/tdx.h    |  6 ++-
>   .../kvm/include/x86_64/tdx/tdx_util.h         |  1 +
>   .../kvm/include/x86_64/tdx/test_util.h        | 19 ++++++++
>   .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 39 ++++++++++++++++
>   .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   | 12 +++++
>   .../selftests/kvm/lib/x86_64/tdx/test_util.c  | 10 +++++
>   .../selftests/kvm/x86_64/tdx_vm_tests.c       | 45 +++++++++++++++++++
>   7 files changed, 131 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> index a7161efe4ee2..1340c1070002 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> @@ -3,10 +3,14 @@
>   #define SELFTEST_TDX_TDX_H
>   
>   #include <stdint.h>
> +#include "kvm_util_base.h"
>   
> -#define TDG_VP_VMCALL_INSTRUCTION_IO 30
> +#define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
>   
> +#define TDG_VP_VMCALL_INSTRUCTION_IO 30
> +void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu);
>   uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>   				      uint64_t write, uint64_t *data);
> +void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
>   
>   #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
> index 274b245f200b..32dd6b8fda46 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
> @@ -12,5 +12,6 @@ struct kvm_vm *td_create(void);
>   void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>   		   uint64_t attributes);
>   void td_finalize(struct kvm_vm *vm);
> +void td_vcpu_run(struct kvm_vcpu *vcpu);
>   
>   #endif // SELFTESTS_TDX_KVM_UTIL_H
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> index b570b6d978ff..6d69921136bd 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> @@ -49,4 +49,23 @@ bool is_tdx_enabled(void);
>    */
>   void tdx_test_success(void);
>   
> +/**
> + * Report an error with @error_code to userspace.
> + *
> + * Return value from tdg_vp_vmcall_report_fatal_error is ignored since execution
> + * is not expected to continue beyond this point.
> + */
> +void tdx_test_fatal(uint64_t error_code);
> +
> +/**
> + * Report an error with @error_code to userspace.
> + *
> + * @data_gpa may point to an optional shared guest memory holding the error
> + * string.
> + *
> + * Return value from tdg_vp_vmcall_report_fatal_error is ignored since execution
> + * is not expected to continue beyond this point.
> + */
> +void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
> +
>   #endif // SELFTEST_TDX_TEST_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> index c2414523487a..b854c3aa34ff 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> @@ -1,8 +1,31 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   
> +#include <string.h>
> +
>   #include "tdx/tdcall.h"
>   #include "tdx/tdx.h"
>   
> +void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_tdx_vmcall *vmcall_info = &vcpu->run->tdx.u.vmcall;
> +	uint64_t vmcall_subfunction = vmcall_info->subfunction;
> +
> +	switch (vmcall_subfunction) {
> +	case TDG_VP_VMCALL_REPORT_FATAL_ERROR:
> +		vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
> +		vcpu->run->system_event.ndata = 3;
> +		vcpu->run->system_event.data[0] =
> +			TDG_VP_VMCALL_REPORT_FATAL_ERROR;
> +		vcpu->run->system_event.data[1] = vmcall_info->in_r12;
> +		vcpu->run->system_event.data[2] = vmcall_info->in_r13;
> +		vmcall_info->status_code = 0;
> +		break;
> +	default:
> +		TEST_FAIL("TD VMCALL subfunction %lu is unsupported.\n",
> +			  vmcall_subfunction);
> +	}
> +}
> +
>   uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>   				      uint64_t write, uint64_t *data)
>   {
> @@ -25,3 +48,19 @@ uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
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
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> index b302060049d5..d745bb6287c1 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> @@ -10,6 +10,7 @@
>   
>   #include "kvm_util.h"
>   #include "test_util.h"
> +#include "tdx/tdx.h"
>   #include "tdx/td_boot.h"
>   #include "kvm_util_base.h"
>   #include "processor.h"
> @@ -519,3 +520,14 @@ void td_finalize(struct kvm_vm *vm)
>   
>   	tdx_td_finalizemr(vm);
>   }
> +
> +void td_vcpu_run(struct kvm_vcpu *vcpu)
> +{
> +	vcpu_run(vcpu);
> +
> +	/* Handle TD VMCALLs that require userspace handling. */
> +	if (vcpu->run->exit_reason == KVM_EXIT_TDX &&
> +	    vcpu->run->tdx.type == KVM_EXIT_TDX_VMCALL) {
> +		handle_userspace_tdg_vp_vmcall_exit(vcpu);
> +	}
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> index 6905d0ca3877..7f3cd8089cea 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> @@ -32,3 +32,13 @@ void tdx_test_success(void)
>   				     TDX_TEST_SUCCESS_SIZE,
>   				     TDG_VP_VMCALL_INSTRUCTION_IO_WRITE, &code);
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
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> index a18d1c9d6026..8638c7bbedaa 100644
> --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> @@ -2,6 +2,7 @@
>   
>   #include <signal.h>
>   #include "kvm_util_base.h"
> +#include "tdx/tdx.h"
>   #include "tdx/tdx_util.h"
>   #include "tdx/test_util.h"
>   #include "test_util.h"
> @@ -30,6 +31,49 @@ void verify_td_lifecycle(void)
>   	printf("\t ... PASSED\n");
>   }
>   
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
> +	if (err)
> +		tdx_test_fatal(err);

I find tdx_test_fatal() is called a lot and each call site checks the err
before calling it. Is it simpler to move the check of err inside of
tdx_test_fatal() so that the callers just call it without check it every 
time?


> +
> +	tdx_test_success();
> +}
> +void verify_report_fatal_error(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
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
> +	TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 3);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.data[0], TDG_VP_VMCALL_REPORT_FATAL_ERROR);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.data[1], 0x0BAAAAAD00000000);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.data[2], 0);
> +
> +	vcpu_run(vcpu);
> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	setbuf(stdout, NULL);
> @@ -40,6 +84,7 @@ int main(int argc, char **argv)
>   	}
>   
>   	run_in_new_process(&verify_td_lifecycle);
> +	run_in_new_process(&verify_report_fatal_error);
>   
>   	return 0;
>   }


