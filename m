Return-Path: <linux-kselftest+bounces-5690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B75C86DB54
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 07:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8ED1C21C5A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 06:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD6651C5E;
	Fri,  1 Mar 2024 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a48fCJk7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0D5026E;
	Fri,  1 Mar 2024 06:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709273033; cv=none; b=IISZtTKN5lx6pCZRMT7b1Zs/c36NFow4MeWoeoVU8pM306HJ8Mtfss1Mr10gQ8YaxzA032TCY6TA0m+YB2I+LLgezj2IOrgYQOLxXrkvlpC4Ipafq6flZOC1ON+r3hYC8VhRPmBEWoJC9j5GQepBffbqfd4OuwptXTdqNWB0cqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709273033; c=relaxed/simple;
	bh=WiOE6B/1DjVmqpfsFWJaZBJmng/+ZV5XML+tT/5b928=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKdKFdJi+/zWzzxQiTDkqG0T7jF0GWoqLm94S3+T4jZmXs+0CDJyaoJKIClmTRl9aSQZxUnytdFXPupa0xScyABm202OrsaaIF4EcHiLduf7yhRvsGENkMeaDb1A+LUUWSeNhFK7/215JgsgcqbzG/8vVlSmfCQSeYFVuWwnsxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a48fCJk7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709273032; x=1740809032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WiOE6B/1DjVmqpfsFWJaZBJmng/+ZV5XML+tT/5b928=;
  b=a48fCJk7NY+4RnsZ1+K8wpfHNT4F4xfrKU9BMK28ImuGCZ4/XmtU/4xw
   cprYwqWddJS+LpOgnakqyoLRU1gpblwdFiDC6uXFZD6ywqKGIKjHDXT4d
   v13gRGZdQLASSL0Z+gcfA2CL8uOq5ACuqDgqj0FVtHjaXdXGbQaoCJm0C
   ay7TmW7xHrzT9BojKCvAPabZJOHhCITd4p2rlic9juaVjCDTkCcV5q1xA
   WilQU8Zpe7j3sZypHp3xvbIog9BnNsKfjQqUZrDbWGMRVUUXHYuuZtp7W
   0CmA8QfTwFqraKVJFdnv2a2gZK8+TPAm1+7Fji1oZbdn5HqVbrqj8BjFi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3966832"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="3966832"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 22:03:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8023261"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.125.242.247]) ([10.125.242.247])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 22:03:47 -0800
Message-ID: <be592452-be8f-4cb5-b751-b9328c19dee6@linux.intel.com>
Date: Fri, 1 Mar 2024 14:03:43 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 12/29] KVM: selftests: TDX: Add basic
 get_td_vmcall_info test
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
 <20231212204647.2170650-13-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-13-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> The test calls get_td_vmcall_info from the guest and verifies the
> expected returned values.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> ---
>   .../selftests/kvm/include/x86_64/tdx/tdx.h    |  3 +
>   .../kvm/include/x86_64/tdx/test_util.h        | 27 +++++++
>   .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 23 ++++++
>   .../selftests/kvm/lib/x86_64/tdx/test_util.c  | 46 +++++++++++
>   .../selftests/kvm/x86_64/tdx_vm_tests.c       | 80 +++++++++++++++++++
>   5 files changed, 179 insertions(+)

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Also, does it need to add another case for the non-zero value of r12 to
test the VMCALL_INVALID_OPERAND path?

>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> index 1340c1070002..63788012bf94 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> @@ -5,6 +5,7 @@
>   #include <stdint.h>
>   #include "kvm_util_base.h"
>   
> +#define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
>   #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
>   
>   #define TDG_VP_VMCALL_INSTRUCTION_IO 30
> @@ -12,5 +13,7 @@ void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu);
>   uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>   				      uint64_t write, uint64_t *data);
>   void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
> +uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
> +					uint64_t *r13, uint64_t *r14);
>   
>   #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> index af0ddbfe8d71..8a9b6a1bec3e 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> @@ -4,6 +4,7 @@
>   
>   #include <stdbool.h>
>   
> +#include "kvm_util_base.h"
>   #include "tdcall.h"
>   
>   #define TDX_TEST_SUCCESS_PORT 0x30
> @@ -111,4 +112,30 @@ void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
>    */
>   uint64_t tdx_test_report_to_user_space(uint32_t data);
>   
> +/**
> + * Report a 64 bit value from the guest to user space using TDG.VP.VMCALL
> + * <Instruction.IO> call.
> + *
> + * Data is sent to host in 2 calls. LSB is sent (and needs to be read) first.
> + */
> +uint64_t tdx_test_send_64bit(uint64_t port, uint64_t data);
> +
> +/**
> + * Report a 64 bit value from the guest to user space using TDG.VP.VMCALL
> + * <Instruction.IO> call. Data is reported on port TDX_TEST_REPORT_PORT.
> + */
> +uint64_t tdx_test_report_64bit_to_user_space(uint64_t data);
> +
> +/**
> + * Read a 64 bit value from the guest in user space, sent using
> + * tdx_test_send_64bit().
> + */
> +uint64_t tdx_test_read_64bit(struct kvm_vcpu *vcpu, uint64_t port);
> +
> +/**
> + * Read a 64 bit value from the guest in user space, sent using
> + * tdx_test_report_64bit_to_user_space.
> + */
> +uint64_t tdx_test_read_64bit_report_from_guest(struct kvm_vcpu *vcpu);
> +
>   #endif // SELFTEST_TDX_TEST_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> index b854c3aa34ff..e5a9e13c62e2 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> @@ -64,3 +64,26 @@ void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa)
>   
>   	__tdx_hypercall(&args, 0);
>   }
> +
> +uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
> +					uint64_t *r13, uint64_t *r14)
> +{
> +	uint64_t ret;
> +	struct tdx_hypercall_args args = {
> +		.r11 = TDG_VP_VMCALL_GET_TD_VM_CALL_INFO,
> +		.r12 = 0,
> +	};
> +
> +	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
> +
> +	if (r11)
> +		*r11 = args.r11;
> +	if (r12)
> +		*r12 = args.r12;
> +	if (r13)
> +		*r13 = args.r13;
> +	if (r14)
> +		*r14 = args.r14;
> +
> +	return ret;
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> index 55c5a1e634df..3ae651cd5fac 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> @@ -7,6 +7,7 @@
>   #include <unistd.h>
>   
>   #include "kvm_util_base.h"
> +#include "tdx/tdcall.h"
>   #include "tdx/tdx.h"
>   #include "tdx/test_util.h"
>   
> @@ -53,3 +54,48 @@ uint64_t tdx_test_report_to_user_space(uint32_t data)
>   					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
>   					&data_64);
>   }
> +
> +uint64_t tdx_test_send_64bit(uint64_t port, uint64_t data)
> +{
> +	uint64_t err;
> +	uint64_t data_lo = data & 0xFFFFFFFF;
> +	uint64_t data_hi = (data >> 32) & 0xFFFFFFFF;
> +
> +	err = tdg_vp_vmcall_instruction_io(port, 4,
> +					   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> +					   &data_lo);
> +	if (err)
> +		return err;
> +
> +	return tdg_vp_vmcall_instruction_io(port, 4,
> +					    TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> +					    &data_hi);
> +}
> +
> +uint64_t tdx_test_report_64bit_to_user_space(uint64_t data)
> +{
> +	return tdx_test_send_64bit(TDX_TEST_REPORT_PORT, data);
> +}
> +
> +uint64_t tdx_test_read_64bit(struct kvm_vcpu *vcpu, uint64_t port)
> +{
> +	uint32_t lo, hi;
> +	uint64_t res;
> +
> +	TDX_TEST_ASSERT_IO(vcpu, port, 4, TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	lo = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
> +
> +	vcpu_run(vcpu);
> +
> +	TDX_TEST_ASSERT_IO(vcpu, port, 4, TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	hi = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
> +
> +	res = hi;
> +	res = (res << 32) | lo;
> +	return res;
> +}
> +
> +uint64_t tdx_test_read_64bit_report_from_guest(struct kvm_vcpu *vcpu)
> +{
> +	return tdx_test_read_64bit(vcpu, TDX_TEST_REPORT_PORT);
> +}
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> index 1b30e6f5a569..569c8fb0a59f 100644
> --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> @@ -260,6 +260,85 @@ void verify_td_cpuid(void)
>   	printf("\t ... PASSED\n");
>   }
>   
> +/*
> + * Verifies get_td_vmcall_info functionality.
> + */
> +void guest_code_get_td_vmcall_info(void)
> +{
> +	uint64_t err;
> +	uint64_t r11, r12, r13, r14;
> +
> +	err = tdg_vp_vmcall_get_td_vmcall_info(&r11, &r12, &r13, &r14);
> +	if (err)
> +		tdx_test_fatal(err);
> +
> +	err = tdx_test_report_64bit_to_user_space(r11);
> +	if (err)
> +		tdx_test_fatal(err);
> +
> +	err = tdx_test_report_64bit_to_user_space(r12);
> +	if (err)
> +		tdx_test_fatal(err);
> +
> +	err = tdx_test_report_64bit_to_user_space(r13);
> +	if (err)
> +		tdx_test_fatal(err);
> +
> +	err = tdx_test_report_64bit_to_user_space(r14);
> +	if (err)
> +		tdx_test_fatal(err);
> +
> +	tdx_test_success();
> +}
> +
> +void verify_get_td_vmcall_info(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	uint64_t r11, r12, r13, r14;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_code_get_td_vmcall_info);
> +	td_finalize(vm);
> +
> +	printf("Verifying TD get vmcall info:\n");
> +
> +	/* Wait for guest to report r11 value */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	r11 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +	/* Wait for guest to report r12 value */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	r12 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +	/* Wait for guest to report r13 value */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	r13 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +	/* Wait for guest to report r14 value */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	r14 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +	TEST_ASSERT_EQ(r11, 0);
> +	TEST_ASSERT_EQ(r12, 0);
> +	TEST_ASSERT_EQ(r13, 0);
> +	TEST_ASSERT_EQ(r14, 0);
> +
> +	/* Wait for guest to complete execution */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	setbuf(stdout, NULL);
> @@ -273,6 +352,7 @@ int main(int argc, char **argv)
>   	run_in_new_process(&verify_report_fatal_error);
>   	run_in_new_process(&verify_td_ioexit);
>   	run_in_new_process(&verify_td_cpuid);
> +	run_in_new_process(&verify_get_td_vmcall_info);
>   
>   	return 0;
>   }


