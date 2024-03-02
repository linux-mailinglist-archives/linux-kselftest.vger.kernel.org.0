Return-Path: <linux-kselftest+bounces-5779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A715886EF65
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 08:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28551C215E2
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 07:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACCF11C92;
	Sat,  2 Mar 2024 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mb9qIeS4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882512E42;
	Sat,  2 Mar 2024 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709366297; cv=none; b=U4dkgZT/Bg5LfSOMkfuI3tTv50OVuCIujivHhqpM1Ao+iXu71H3OsyQmjyDclIe+ZrM038frY99/WomHsPI2s6iZZhjKWbcg3nMHRIALzonlzg6H8qODR9G/DzoB4UWU31Jyg7AMjO5rPqhVvmQApp9X1joiE6GoaLuwVqkusr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709366297; c=relaxed/simple;
	bh=vZbc6IDCxYIzD6imxHYIKCytFzfBvyP0Kq3E+nLkKjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0kkJz0eMv5HvJqqntk5IbENbh0hgvBUedbJCGql2rWf5ZYwsRbbCT8hD0v2tPcvCq7jrhrCmyasaRNoQPolBufVLXAItFEoX15EYLJDWYfypDXa3+w2iC2g4gGDmv6ZQEuZOMP/PnwKHNpjNyQSoBW5Ro5Pw39OF4kV9NWWbJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mb9qIeS4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709366295; x=1740902295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vZbc6IDCxYIzD6imxHYIKCytFzfBvyP0Kq3E+nLkKjQ=;
  b=Mb9qIeS4LhhIWw9I5Dox1Z4swtZnIbAHB0yZkXcwhye0WLZITq0Mb509
   z2vwMRFW6WvZtM/tFF4A8v8cc/ORbbbAlWqQtjYARxkw0+jDdv3CzhG9n
   FcWcRYKAasPK0AQWzER0vPRtbNo/2Byy9Kt1YTzbdKNGoHomSCO2D7PE9
   cZPcwzaVWe0L/ibYJASp3HtNcx4D3c4s8dcEUdOjEgN0oD0R8ZG7AtL9R
   xx1ORiBE6Bzhl6mVXJW6e5FumGeKsTt06H6xYk/dvFJnUeXzpAeg7y/24
   OrDrrt2fNpXsITUsL27W2HFzgIBIagcANgF1eB6jlmpZDUxJjwAIBuPew
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3797732"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="3797732"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 23:58:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8367762"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.125.242.247]) ([10.125.242.247])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 23:58:10 -0800
Message-ID: <f634eee0-d81f-496d-b138-73b44b2bfa5d@linux.intel.com>
Date: Sat, 2 Mar 2024 15:58:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 18/29] KVM: selftests: TDX: Add TDX MMIO writes
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
 <20231212204647.2170650-19-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-19-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> The test verifies MMIO writes of various sizes from the guest to the host.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>

Patch 17 and 18 test the part that guest has received the #VE caused by
MMIO access, so calls the td vmcall to kvm to do the emulation.

Should the generation of #VE due to MMIO access be covered as well?

> ---
>   .../selftests/kvm/include/x86_64/tdx/tdx.h    |  2 +
>   .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 14 +++
>   .../selftests/kvm/x86_64/tdx_vm_tests.c       | 85 +++++++++++++++++++
>   3 files changed, 101 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> index 13ce60df5684..502b670ea699 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> @@ -25,5 +25,7 @@ uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
>   uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
>   uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
>   					uint64_t *data_out);
> +uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
> +					uint64_t data_in);
>   
>   #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> index b19f07ebc0e7..f4afa09f7e3d 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> @@ -143,3 +143,17 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
>   
>   	return ret;
>   }
> +
> +uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
> +					uint64_t data_in)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r11 = TDG_VP_VMCALL_VE_REQUEST_MMIO,
> +		.r12 = size,
> +		.r13 = TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE,
> +		.r14 = address,
> +		.r15 = data_in,
> +	};
> +
> +	return __tdx_hypercall(&args, 0);
> +}
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> index 48902b69d13e..5e28ba828a92 100644
> --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> @@ -885,6 +885,90 @@ void verify_mmio_reads(void)
>   	printf("\t ... PASSED\n");
>   }
>   
> +void guest_mmio_writes(void)
> +{
> +	uint64_t ret;
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 1, 0x12);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 2, 0x1234);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 4, 0x12345678);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 8, 0x1234567890ABCDEF);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	// Write across page boundary.
> +	ret = tdg_vp_vmcall_ve_request_mmio_write(PAGE_SIZE - 1, 8, 0);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	tdx_test_success();
> +}
> +
> +/*
> + * Varifies guest MMIO writes.
> + */
> +void verify_mmio_writes(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	uint8_t byte_1;
> +	uint16_t byte_2;
> +	uint32_t byte_4;
> +	uint64_t byte_8;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_mmio_writes);
> +	td_finalize(vm);
> +
> +	printf("Verifying TD MMIO writes:\n");
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 1, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
> +	byte_1 = *(uint8_t *)(vcpu->run->mmio.data);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 2, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
> +	byte_2 = *(uint16_t *)(vcpu->run->mmio.data);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 4, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
> +	byte_4 = *(uint32_t *)(vcpu->run->mmio.data);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 8, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
> +	byte_8 = *(uint64_t *)(vcpu->run->mmio.data);
> +
> +	TEST_ASSERT_EQ(byte_1, 0x12);
> +	TEST_ASSERT_EQ(byte_2, 0x1234);
> +	TEST_ASSERT_EQ(byte_4, 0x12345678);
> +	TEST_ASSERT_EQ(byte_8, 0x1234567890ABCDEF);
> +
> +	td_vcpu_run(vcpu);
> +	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.data[1], TDG_VP_VMCALL_INVALID_OPERAND);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	setbuf(stdout, NULL);
> @@ -905,6 +989,7 @@ int main(int argc, char **argv)
>   	run_in_new_process(&verify_guest_msr_reads);
>   	run_in_new_process(&verify_guest_hlt);
>   	run_in_new_process(&verify_mmio_reads);
> +	run_in_new_process(&verify_mmio_writes);
>   
>   	return 0;
>   }


