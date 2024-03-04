Return-Path: <linux-kselftest+bounces-5818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E34786FCF8
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 10:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3232F1C22173
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D0D20DC5;
	Mon,  4 Mar 2024 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LaQ3zIxK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE020B27;
	Mon,  4 Mar 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543824; cv=none; b=u/6KofVU4dyZkkhZssmIU0DqRrDppaTFJ8QAqcRRNYFlJM8oeQnTS+6jqTRuLMRJDk3jmDRNLxUzsaavYcBUTG9mrrT1JeFlhBzuJo62ktf2/1P0f6icg6XOURSVTzrgmr/tPSa8miXTNzYBn3vcheovAz97+vOtGpn+b1UVQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543824; c=relaxed/simple;
	bh=3DwW30fbFMvQ2ySHnVA3fgbqopvn+6yGmMXD+bUNixc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrCHK9l8VtNLsWJUBs7uBT2CKds1hQq+mdADzBNmoV2TNGty6+wcVHhtEIxExGTrqoyJiI5EgZFRBs6p9x48HIDnlXrzY+QqCm5q+qODAk6y0pZOOVTYvIw7H20GgnaINGFX8e0a17KpXU5OyONfHK/4+1MvzfOMQq/f2MiatJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LaQ3zIxK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709543823; x=1741079823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3DwW30fbFMvQ2ySHnVA3fgbqopvn+6yGmMXD+bUNixc=;
  b=LaQ3zIxKeub5ytSP8j+O1NMnmwULvEEXZijLRekAF9RY5cWXa3+i+CFf
   LllY/VoUtUtIulX2unkXnezgNXz2YuDKr8Mp9xhnvJ0mrKL8nQgrR0Ilq
   IkAvM9tmWZJTt2QEdKY7BUodtJN9yeVYUVeMMa/4aXRbJSKoufLI0eMN5
   RK6GRtr4OfIhDhJqqRF9ZEL8ZRl+ewm5VL0gGEVGMy1VCBX5ltqa+4vbD
   2cA6LAfNx6SJwGCAvZpL0aRez6kJq5+bbsitWEwWBnq/PoSx2PI4LjpMh
   lAS615xi0qYirc4ltD1SquJFTw90Xnzau0SoKXzpZqwnT/dYMn9F61GpK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7833985"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7833985"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:17:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8838530"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.8.218]) ([10.238.8.218])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:16:55 -0800
Message-ID: <0344d85f-d6ab-4d78-abac-d0293d71ef91@linux.intel.com>
Date: Mon, 4 Mar 2024 17:16:53 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 10/29] KVM: selftests: TDX: Adding test case for
 TDX port IO
To: Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>
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
 <ZeUvtzHmMo9jdMnu@yzhao56-desk.sh.intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <ZeUvtzHmMo9jdMnu@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/4/2024 10:19 AM, Yan Zhao wrote:
> On Tue, Dec 12, 2023 at 12:46:25PM -0800, Sagi Shahar wrote:
>> From: Erdem Aktas <erdemaktas@google.com>
>>
>> Verifies TDVMCALL<INSTRUCTION.IO> READ and WRITE operations.
>>
>> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
>> Signed-off-by: Sagi Shahar <sagis@google.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> Signed-off-by: Ryan Afranji <afranji@google.com>
>> ---
>>   .../kvm/include/x86_64/tdx/test_util.h        | 34 ++++++++
>>   .../selftests/kvm/x86_64/tdx_vm_tests.c       | 82 +++++++++++++++++++
>>   2 files changed, 116 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
>> index 6d69921136bd..95a5d5be7f0b 100644
>> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
>> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
>> @@ -9,6 +9,40 @@
>>   #define TDX_TEST_SUCCESS_PORT 0x30
>>   #define TDX_TEST_SUCCESS_SIZE 4
>>   
>> +/**
>> + * Assert that some IO operation involving tdg_vp_vmcall_instruction_io() was
>> + * called in the guest.
>> + */
>> +#define TDX_TEST_ASSERT_IO(VCPU, PORT, SIZE, DIR)			\
>> +	do {								\
>> +		TEST_ASSERT((VCPU)->run->exit_reason == KVM_EXIT_IO,	\
>> +			"Got exit_reason other than KVM_EXIT_IO: %u (%s)\n", \
>> +			(VCPU)->run->exit_reason,			\
>> +			exit_reason_str((VCPU)->run->exit_reason));	\
>> +									\
>> +		TEST_ASSERT(((VCPU)->run->exit_reason == KVM_EXIT_IO) && \
>> +			((VCPU)->run->io.port == (PORT)) &&		\
>> +			((VCPU)->run->io.size == (SIZE)) &&		\
>> +			((VCPU)->run->io.direction == (DIR)),		\
>> +			"Got unexpected IO exit values: %u (%s) %d %d %d\n", \
>> +			(VCPU)->run->exit_reason,			\
>> +			exit_reason_str((VCPU)->run->exit_reason),	\
>> +			(VCPU)->run->io.port, (VCPU)->run->io.size,	\
>> +			(VCPU)->run->io.direction);			\
>> +	} while (0)
>> +
>> +/**
>> + * Check and report if there was some failure in the guest, either an exception
>> + * like a triple fault, or if a tdx_test_fatal() was hit.
>> + */
>> +#define TDX_TEST_CHECK_GUEST_FAILURE(VCPU)				\
>> +	do {								\
>> +		if ((VCPU)->run->exit_reason == KVM_EXIT_SYSTEM_EVENT)	\
>> +			TEST_FAIL("Guest reported error. error code: %lld (0x%llx)\n", \
>> +				(VCPU)->run->system_event.data[1],	\
>> +				(VCPU)->run->system_event.data[1]);	\
>> +	} while (0)
>> +
>>   /**
>>    * Assert that tdx_test_success() was called in the guest.
>>    */
>> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
>> index 8638c7bbedaa..75467c407ca7 100644
>> --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
>> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
>> @@ -2,6 +2,7 @@
>>   
>>   #include <signal.h>
>>   #include "kvm_util_base.h"
>> +#include "tdx/tdcall.h"
>>   #include "tdx/tdx.h"
>>   #include "tdx/tdx_util.h"
>>   #include "tdx/test_util.h"
>> @@ -74,6 +75,86 @@ void verify_report_fatal_error(void)
>>   	printf("\t ... PASSED\n");
>>   }
>>   
>> +#define TDX_IOEXIT_TEST_PORT 0x50
>> +
>> +/*
>> + * Verifies IO functionality by writing a |value| to a predefined port.
>> + * Verifies that the read value is |value| + 1 from the same port.
>> + * If all the tests are passed then write a value to port TDX_TEST_PORT
>> + */
>> +void guest_ioexit(void)
>> +{
>> +	uint64_t data_out, data_in, delta;
>> +	uint64_t ret;
>> +
>> +	data_out = 0xAB;
>> +	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
>> +					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
>> +					&data_out);
>> +	if (ret)
>> +		tdx_test_fatal(ret);
>> +
>> +	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
>> +					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
>> +					&data_in);
>> +	if (ret)
>> +		tdx_test_fatal(ret);
>> +
>> +	delta = data_in - data_out;
>> +	if (delta != 1)
>> +		tdx_test_fatal(ret);
>> +
>> +	tdx_test_success();
>> +}
>> +
>> +void verify_td_ioexit(void)
>> +{
>> +	struct kvm_vm *vm;
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	uint32_t port_data;
>> +
>> +	vm = td_create();
>> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
>> +	vcpu = td_vcpu_add(vm, 0, guest_ioexit);
>> +	td_finalize(vm);
>> +
>> +	printf("Verifying TD IO Exit:\n");
>> +
>> +	/* Wait for guest to do a IO write */
>> +	td_vcpu_run(vcpu);
>> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> This check is a vain, because the first VMExit from vcpu run is always
> KVM_EXIT_IO caused by tdg_vp_vmcall_instruction_io().

I think tdg_vp_vmcall_instruction_io() could fail if RCX (GPR select) 
doesn't
meet the requirement (some bits must be 0).
Although RCX is set by guest code (in selftest, it set in __tdx_hypercall())
and it will not trigger the error, it still can be used as a guard to make
sure guest doesn't pass a invalid RCX.


>
>
>> +	TDX_TEST_ASSERT_IO(vcpu, TDX_IOEXIT_TEST_PORT, 1,
>> +			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
>> +	port_data = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
>> +
>> +	printf("\t ... IO WRITE: OK\n");
> So,  even if there's an error in emulating writing of TDX_IOEXIT_TEST_PORT,
> and guest would then find a failure and trigger tdx_test_fatal(), this line
> will still print "IO WRITE: OK", which is not right.
>
>> +
>> +	/*
>> +	 * Wait for the guest to do a IO read. Provide the previous written data
>> +	 * + 1 back to the guest
>> +	 */
>> +	td_vcpu_run(vcpu);
>> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> This check is a vain, too, as in  write case.
>
>> +	TDX_TEST_ASSERT_IO(vcpu, TDX_IOEXIT_TEST_PORT, 1,
>> +			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
>> +	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = port_data + 1;
>> +
>> +	printf("\t ... IO READ: OK\n");
> Same as in write case, this line should not be printed until after guest
> finishing checking return code.
>
>> +
>> +	/*
>> +	 * Wait for the guest to complete execution successfully. The read
>> +	 * value is checked within the guest.
>> +	 */
>> +	td_vcpu_run(vcpu);
>> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
>> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
>> +
>> +	printf("\t ... IO verify read/write values: OK\n");
>> +	kvm_vm_free(vm);
>> +	printf("\t ... PASSED\n");
>> +}
>> +
>>   int main(int argc, char **argv)
>>   {
>>   	setbuf(stdout, NULL);
>> @@ -85,6 +166,7 @@ int main(int argc, char **argv)
>>   
>>   	run_in_new_process(&verify_td_lifecycle);
>>   	run_in_new_process(&verify_report_fatal_error);
>> +	run_in_new_process(&verify_td_ioexit);
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.43.0.472.g3155946c3a-goog
>>
>>


