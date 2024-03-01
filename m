Return-Path: <linux-kselftest+bounces-5692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0276B86DBBA
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 07:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D551C22ECD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 06:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1783692FC;
	Fri,  1 Mar 2024 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5Xw8gC0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1904E612E1;
	Fri,  1 Mar 2024 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276139; cv=none; b=Okb3H5FD049wHB02KvJXU1/YCvbACZVR501J6L0ZCJ4Bz5S8ouRODKsGyTe3CQXZVVOSwvwD0u+NZVbR+KwllqGyANuC0I2mYWfIKFW07BiJEs2IUshbu73SfCNZXm1dSIaKhMdKty6pzWA36M1XkeX+XtXVoPaQSusUH9rJuNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276139; c=relaxed/simple;
	bh=GkEyFblwb+TyBXjYkykuu/UF12VLxplAcoYBbKh21OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfJzeOW34ywpD3Iye4c4iO3nyxTDhETLsY9vgHAk5En7+4r2iz9phPZg45xI/sz852UvMkR7iRZ5EtOm8rXfiJOhu/mAxZURT3bhucb+DXvXfJKh0ORRmu6Y7Tu03lpsHt1MG0sTKPY5dZzcu31JE472EPLVbI1+3QrcIFv2eCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5Xw8gC0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709276138; x=1740812138;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GkEyFblwb+TyBXjYkykuu/UF12VLxplAcoYBbKh21OU=;
  b=P5Xw8gC0cQJC4tN8dn1nLnaaN0GRKzzsQ3UapxZteWf+7ifYuBYo+UUX
   WEvAuL/aEwrrtHrZpO2MMsJfKZamWovRciXqEBdRe/LkFV/db/Um9YjzW
   MdX8KlsexOdagF3Irc4Ws0y6bY0wgFJPYdu4vqpTVk57+uNxFAeOk1/F2
   NS0hqoKRUAocqTV+r9TBTSAJPjS6Cm5U9Xt674QL/b7g6SMKb/8HIUNg8
   MO202UNLNaN5DcyFqNpCSx2x5S4jB60Kvdk8A8Yc90CtQQpxJeWfOTTH6
   poFqBu8j0yD7V3zH4+gdhper/kA/edHUvNhAT1Thf7A6YL//Bsn8emMrK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="14504697"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="14504697"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 22:55:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="12791235"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.125.242.247]) ([10.125.242.247])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 22:55:32 -0800
Message-ID: <fbd6ebaf-c722-41d2-9587-45b12bc74ce5@linux.intel.com>
Date: Fri, 1 Mar 2024 14:55:29 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 13/29] KVM: selftests: TDX: Add TDX IO writes test
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
 <20231212204647.2170650-14-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-14-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> The test verifies IO writes of various sizes from the guest to the host.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> ---
>   .../selftests/kvm/include/x86_64/tdx/tdcall.h |  3 +
>   .../selftests/kvm/x86_64/tdx_vm_tests.c       | 91 +++++++++++++++++++
>   2 files changed, 94 insertions(+)

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
> index 78001bfec9c8..b5e94b7c48fa 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
> @@ -10,6 +10,9 @@
>   #define TDG_VP_VMCALL_INSTRUCTION_IO_READ 0
>   #define TDG_VP_VMCALL_INSTRUCTION_IO_WRITE 1
>   
> +#define TDG_VP_VMCALL_SUCCESS 0x0000000000000000
> +#define TDG_VP_VMCALL_INVALID_OPERAND 0x8000000000000000
> +
>   #define TDX_HCALL_HAS_OUTPUT BIT(0)
>   
>   #define TDX_HYPERCALL_STANDARD 0
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> index 569c8fb0a59f..a2b3e1aef151 100644
> --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> @@ -339,6 +339,96 @@ void verify_get_td_vmcall_info(void)
>   	printf("\t ... PASSED\n");
>   }
>   
> +#define TDX_IO_WRITES_TEST_PORT 0x51
> +
> +/*
> + * Verifies IO functionality by writing values of different sizes
> + * to the host.
> + */
> +void guest_io_writes(void)
> +{
> +	uint64_t byte_1 = 0xAB;
> +	uint64_t byte_2 = 0xABCD;
> +	uint64_t byte_4 = 0xFFABCDEF;
> +	uint64_t ret;
> +
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 1,
> +					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> +					&byte_1);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 2,
> +					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> +					&byte_2);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 4,
> +					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> +					&byte_4);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	// Write an invalid number of bytes.
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 5,
> +					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> +					&byte_4);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	tdx_test_success();
> +}
> +
> +void verify_guest_writes(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	uint8_t byte_1;
> +	uint16_t byte_2;
> +	uint32_t byte_4;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_io_writes);
> +	td_finalize(vm);
> +
> +	printf("Verifying guest writes:\n");
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_WRITES_TEST_PORT, 1,
> +			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	byte_1 = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_WRITES_TEST_PORT, 2,
> +			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	byte_2 = *(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_WRITES_TEST_PORT, 4,
> +			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	byte_4 = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
> +
> +	TEST_ASSERT_EQ(byte_1, 0xAB);
> +	TEST_ASSERT_EQ(byte_2, 0xABCD);
> +	TEST_ASSERT_EQ(byte_4, 0xFFABCDEF);
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
> @@ -353,6 +443,7 @@ int main(int argc, char **argv)
>   	run_in_new_process(&verify_td_ioexit);
>   	run_in_new_process(&verify_td_cpuid);
>   	run_in_new_process(&verify_get_td_vmcall_info);
> +	run_in_new_process(&verify_guest_writes);
>   
>   	return 0;
>   }


