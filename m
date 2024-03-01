Return-Path: <linux-kselftest+bounces-5695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C186DCF2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 09:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1702C1F26624
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 08:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE3969DF4;
	Fri,  1 Mar 2024 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPHk29tH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0206B69DE3;
	Fri,  1 Mar 2024 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281336; cv=none; b=IUpmIMyArekwuneFlbf6ezxmG009NaPsyJRA9tOypbs2M28PdJ6SKi8EZ0tHmSbjeGUvndxdXULqz9UJJRfn6oWD6b+0b+1OK+S7P0qmiHXmT8J9vWUJRC2V6KIjI+jZOnNCzbfrj2idJGzpsdR2eS3GNdtweZPRZM698zXWic0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281336; c=relaxed/simple;
	bh=L/oHwYBp57m19z3C6RvcmW7hmp890HYZJEwOnFdlmj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ka5J86z4qwcnMXkZ59gVB73MrdA0ffc6T6KJTXXiPwFHNt3wsaYCpr4PJ1qPfAKN4jQRamwGMYWMzavQj8x9zW9ycccM7lxMeV1xmN5iKzzCVbhNJ7pwK7Dhgxo1FA4FD98970E1yNyQkGNjvVH6cQH3CNyADeGnCiT4D6xHgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPHk29tH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709281335; x=1740817335;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L/oHwYBp57m19z3C6RvcmW7hmp890HYZJEwOnFdlmj0=;
  b=HPHk29tH3MheYgb4ZtMyNosD1hKH/+JV/0FhFQ1/kpfCzx6/TrF823u8
   37XPlgQw3XhwIFwlZc/iZGbw0C+2CT6ME0pQ7+IFz2xJXsDuWgsUvPJID
   j7Rqqu9W0E9Y9VCBnET5vvQs7WqVEx1XuVEipNoxnMVfd2yQWI9RSLqvI
   ePUWlqVJ0RCJDoqYZfpaxMkFw69b5rr4mHtnvOitZ2HPyl5UUbHeQ5z+2
   wMLEhZrWGZW/z8VRRuW2krxtinoR4zdaEKNsSQC6Dh9BPigBmchge3Yb2
   BcoIUJuElvGqD1HUhCJhhhh9bedp81I/ynRbkMVKTuUC6uM4pA8eSq/cU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3656743"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="3656743"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:22:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8047412"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.125.242.247]) ([10.125.242.247])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:22:09 -0800
Message-ID: <7a90438a-6bb3-4e95-86a2-9ba199827675@linux.intel.com>
Date: Fri, 1 Mar 2024 16:22:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 14/29] KVM: selftests: TDX: Add TDX IO reads test
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
 <20231212204647.2170650-15-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-15-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> The test verifies IO reads of various sizes from the host to the guest.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> ---
>   .../selftests/kvm/x86_64/tdx_vm_tests.c       | 87 +++++++++++++++++++
>   1 file changed, 87 insertions(+)

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

>
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> index a2b3e1aef151..699cba36e9ce 100644
> --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> @@ -429,6 +429,92 @@ void verify_guest_writes(void)
>   	printf("\t ... PASSED\n");
>   }
>   
> +#define TDX_IO_READS_TEST_PORT 0x52
> +
> +/*
> + * Verifies IO functionality by reading values of different sizes
> + * from the host.
> + */
> +void guest_io_reads(void)
> +{
> +	uint64_t data;
> +	uint64_t ret;
> +
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 1,
> +					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
> +					&data);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +	if (data != 0xAB)
> +		tdx_test_fatal(1);
> +
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 2,
> +					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
> +					&data);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +	if (data != 0xABCD)
> +		tdx_test_fatal(2);
> +
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 4,
> +					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
> +					&data);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +	if (data != 0xFFABCDEF)
> +		tdx_test_fatal(4);
> +
> +	// Read an invalid number of bytes.
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 5,
> +					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
> +					&data);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	tdx_test_success();
> +}
> +
> +void verify_guest_reads(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_io_reads);
> +	td_finalize(vm);
> +
> +	printf("Verifying guest reads:\n");
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_READS_TEST_PORT, 1,
> +			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
> +	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xAB;
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_READS_TEST_PORT, 2,
> +			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
> +	*(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xABCD;
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_READS_TEST_PORT, 4,
> +			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
> +	*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xFFABCDEF;
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
> @@ -444,6 +530,7 @@ int main(int argc, char **argv)
>   	run_in_new_process(&verify_td_cpuid);
>   	run_in_new_process(&verify_get_td_vmcall_info);
>   	run_in_new_process(&verify_guest_writes);
> +	run_in_new_process(&verify_guest_reads);
>   
>   	return 0;
>   }


