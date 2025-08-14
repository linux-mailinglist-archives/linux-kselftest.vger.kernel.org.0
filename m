Return-Path: <linux-kselftest+bounces-38960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0C2B26400
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 13:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F251720CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB2264614;
	Thu, 14 Aug 2025 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6mr9Ymj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623071474CC;
	Thu, 14 Aug 2025 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170235; cv=none; b=AGqXFQCfrWtw+r4TCPGz4+M8GMXa7tthgPneofWfwZ7DwrRTgnNfv5rIl8hNcawyUwcbtifyLtwqYU0q5lKXXIMTvjthD2o6t+qin1QaiTFVtks3l2P9E2URpEiaYIsfleoURZ8XUfQXWFNRCcq3uYZe1M2lYBr6SZPKdWzdtXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170235; c=relaxed/simple;
	bh=TL2DIflxlb+3IICNHLU8/yPYEmvqO6pplGEDMmxOSnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdVKh1y2Mb76xszzAVdhqqVKp5SfwziQxpdqniuIxO2adWG2TIUKiYaH926nxw2d/XmWPdMRr8RQdBVfyw68P0OsYUnw9ymBLGxy0LipcubeNerPGTKfbSudh63jY7H2GXRaDze6L0KwvnJsC5AUVmL9Zz0P+NpNkP2HpV8W/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6mr9Ymj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755170233; x=1786706233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TL2DIflxlb+3IICNHLU8/yPYEmvqO6pplGEDMmxOSnk=;
  b=J6mr9YmjRpl1r1xxrdoD33tLOaTRViFnf7JKV1/VwJ3X17lb0vqy6o33
   cBFC13jNkSlnY5JldALqydhBvFUpshIpy3d1sX9uWmOja7oqF0e3sWQjL
   1QXXiKS2zfPB9TmjGMoDKVJgAz7C/RZ3vVdWGTrw59rz7jGczk6EoAJbE
   X/EdSmuCLpv329o3aV/YJg7pEQdkC+5XrhcNihr4UEWLXhEU7EtC5Y1fI
   ofXpOxpOJfD2qhNi1su/wqoMFqIA/Qc9b56d9cD+xhK13KwHrHeVzWalC
   ApTW0xiY8sY7P1rZQ+njPOHveIZpe+SbWk2Ns4kbAhap2Y+E02REBxXgf
   g==;
X-CSE-ConnectionGUID: ITh7pIRpTnOTV8MLzkmCOA==
X-CSE-MsgGUID: QNMSZgNWQOCdzVM3TOaHnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57404831"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57404831"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 04:17:12 -0700
X-CSE-ConnectionGUID: NW122BnVRuOjHQPb4R6/EA==
X-CSE-MsgGUID: pefCXJucQIKTQSomNpdWEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166228833"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 04:17:09 -0700
Message-ID: <fa61f808-ffd0-46cd-9e59-1a4e743bea24@linux.intel.com>
Date: Thu, 14 Aug 2025 19:17:06 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 21/30] KVM: selftests: TDX: Verify the behavior when
 host consumes a TD private memory
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
 <20250807201628.1185915-22-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250807201628.1185915-22-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> From: Ryan Afranji <afranji@google.com>
>
> The test checks that host can only read fixed values when trying to
> access the guest's private memory.
>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   tools/testing/selftests/kvm/x86/tdx_vm_test.c | 83 ++++++++++++++++++-
>   1 file changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> index 2f75f12d2a44..b6ef0348746c 100644
> --- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> +++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> @@ -959,6 +959,85 @@ void verify_td_cpuid_tdcall(void)
>   	printf("\t ... PASSED\n");
>   }
>   
> +/*
> + * Shared variables between guest and host for host reading private mem test
> + */
> +static uint64_t tdx_test_host_read_private_mem_addr;
> +#define TDX_HOST_READ_PRIVATE_MEM_PORT_TEST 0x53
> +
> +void guest_host_read_priv_mem(void)
> +{
> +	uint64_t placeholder = 0;
> +	uint64_t ret;
> +
> +	/* Set value */
> +	*((uint32_t *)tdx_test_host_read_private_mem_addr) = 0xABCD;
> +
> +	/* Exit so host can read value */
> +	ret = tdg_vp_vmcall_instruction_io(TDX_HOST_READ_PRIVATE_MEM_PORT_TEST,
> +					   4, PORT_WRITE, &placeholder);
> +	tdx_assert_error(ret);
> +
> +	/* Update guest_var's value and have host reread it. */
> +	*((uint32_t *)tdx_test_host_read_private_mem_addr) = 0xFEDC;
> +
> +	tdx_test_success();
> +}
> +
> +void verify_host_reading_private_mem(void)
> +{
> +	uint64_t second_host_read;
> +	uint64_t first_host_read;
> +	struct kvm_vcpu *vcpu;
> +	vm_vaddr_t test_page;
> +	uint64_t *host_virt;
> +	struct kvm_vm *vm;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_host_read_priv_mem);
> +
> +	test_page = vm_vaddr_alloc_page(vm);
> +	TEST_ASSERT(test_page < BIT_ULL(32),
> +		    "Test address should fit in 32 bits so it can be sent to the guest");

I didn't understand it.
Could you elaborate a bit?

> +
> +	host_virt = addr_gva2hva(vm, test_page);
> +	TEST_ASSERT(host_virt,
> +		    "Guest address not found in guest memory regions\n");
> +
> +	tdx_test_host_read_private_mem_addr = test_page;
> +	sync_global_to_guest(vm, tdx_test_host_read_private_mem_addr);
> +
> +	td_finalize(vm);
> +
> +	printf("Verifying host's behavior when reading TD private memory:\n");

When the host accesses host_virt, it's not accessing the same page of the
private page of the TD, so it's not accurate to say the host is reading or
consuming TD private memory.

> +
> +	tdx_run(vcpu);
> +	tdx_test_assert_io(vcpu, TDX_HOST_READ_PRIVATE_MEM_PORT_TEST,
> +			   4, PORT_WRITE);
> +	printf("\t ... Guest's variable contains 0xABCD\n");
> +
> +	/* Host reads guest's variable. */
> +	first_host_read = *host_virt;
> +	printf("\t ... Host's read attempt value: %lu\n", first_host_read);
> +
> +	/* Guest updates variable and host rereads it. */
> +	tdx_run(vcpu);
> +	printf("\t ... Guest's variable updated to 0xFEDC\n");
> +
> +	second_host_read = *host_virt;
> +	printf("\t ... Host's second read attempt value: %lu\n",
> +	       second_host_read);
> +
> +	TEST_ASSERT(first_host_read == second_host_read,
> +		    "Host did not read a fixed pattern\n");
> +
> +	printf("\t ... Fixed pattern was returned to the host\n");
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	ksft_print_header();
> @@ -966,7 +1045,7 @@ int main(int argc, char **argv)
>   	if (!is_tdx_enabled())
>   		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
>   
> -	ksft_set_plan(13);
> +	ksft_set_plan(14);
>   	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
>   			 "verify_td_lifecycle\n");
>   	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
> @@ -993,6 +1072,8 @@ int main(int argc, char **argv)
>   			 "verify_mmio_writes\n");
>   	ksft_test_result(!run_in_new_process(&verify_td_cpuid_tdcall),
>   			 "verify_td_cpuid_tdcall\n");
> +	ksft_test_result(!run_in_new_process(&verify_host_reading_private_mem),
> +			 "verify_host_reading_private_mem\n");
>   
>   	ksft_finished();
>   	return 0;


