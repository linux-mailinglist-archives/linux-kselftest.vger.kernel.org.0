Return-Path: <linux-kselftest+bounces-6482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34219886411
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 00:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBCD1F210A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 23:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9388A1E51D;
	Thu, 21 Mar 2024 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTRD+iss"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDAAF516;
	Thu, 21 Mar 2024 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711064803; cv=none; b=pIj7hwB2+avjxVcNON2Lxz7F70t7WRj0VjaoTEGqR7RquGM8QKnhHsCNM6D564gHJIx4OMfzvm6gVx6x42gNEVR5qJe/i5D1qRf1A+wSIGRfpTERyHYdVPQIQx1rG+6lvVpSl0RdhYyEwLCc9X4Dx/m3CVii8t/PDEGIK+zsiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711064803; c=relaxed/simple;
	bh=Rf0D+K+jXTiwLuIvY9ASPK++sStp3YNUIenDwHbEEGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbZnHa2XLULXBSqeuNEVO/Cv2f5vXW7Pd1jH4774Wruhhpc3d3RFVZ8nwRC3LMETfyp+ReIDzbSaaZ+hedSV6ixVutMsQUvJCTrTctaY1lFjYEEyIrUdGmbzPMvuE1VOYHDtHDcX3CU3fRSgtT3vx+GBDx9Dp4IRRY/+IsqHfC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTRD+iss; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711064802; x=1742600802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rf0D+K+jXTiwLuIvY9ASPK++sStp3YNUIenDwHbEEGc=;
  b=mTRD+issoPwPt62huIs+jmt09WPGAJ1SqJZyQ9mJfH57D1df0ps4LzaM
   iouJRINmqh/TsLWtvmcUYifID4AfsOWwcsTy4uVE7is0uZ9sEv8m4zSYb
   uCm3va9/fbutRq1zQ8v856Vh5eSTkRwUZWiPiVgEpSC07JLq0FJV2BfwJ
   wqG7U3LemYbCPrNthnMVtk0JotoaAKjBT+gZ5O6oNABTQpC60TOBVWie9
   TEjM9U4sHmYl1fXuklGMpsk4hbaeeMeja0xEwbfE7NpoNovahC2v87ve4
   muD2o2PX1GFSm+U8GrayiFyhVeW6G8iHTkts7uAn1cLJVzBbzAtoQY6jf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="17246134"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="17246134"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 16:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="15107183"
Received: from dongshen-mobl1.amr.corp.intel.com (HELO [10.212.116.150]) ([10.212.116.150])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 16:46:40 -0700
Message-ID: <4e93f167-8a90-4046-9f43-2366556b1e89@intel.com>
Date: Thu, 21 Mar 2024 16:46:39 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 18/29] KVM: selftests: TDX: Add TDX MMIO writes
 test
To: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org,
 Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>,
 Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-19-sagis@google.com>
Content-Language: en-US
From: "Zhang, Dongsheng X" <dongsheng.x.zhang@intel.com>
In-Reply-To: <20231212204647.2170650-19-sagis@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/2023 12:46 PM, Sagi Shahar wrote:
> The test verifies MMIO writes of various sizes from the guest to the host.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> ---
>  .../selftests/kvm/include/x86_64/tdx/tdx.h    |  2 +
>  .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 14 +++
>  .../selftests/kvm/x86_64/tdx_vm_tests.c       | 85 +++++++++++++++++++
>  3 files changed, 101 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> index 13ce60df5684..502b670ea699 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> @@ -25,5 +25,7 @@ uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
>  uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
>  uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
>  					uint64_t *data_out);
> +uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
> +					uint64_t data_in);
>  
>  #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> index b19f07ebc0e7..f4afa09f7e3d 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> @@ -143,3 +143,17 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
>  
>  	return ret;
>  }
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
>  	printf("\t ... PASSED\n");
>  }
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

Nit: typo?  Varifies ==> Verifies

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
>  int main(int argc, char **argv)
>  {
>  	setbuf(stdout, NULL);
> @@ -905,6 +989,7 @@ int main(int argc, char **argv)
>  	run_in_new_process(&verify_guest_msr_reads);
>  	run_in_new_process(&verify_guest_hlt);
>  	run_in_new_process(&verify_mmio_reads);
> +	run_in_new_process(&verify_mmio_writes);
>  
>  	return 0;
>  }

