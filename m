Return-Path: <linux-kselftest+bounces-6936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076808939A4
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADA01C20FA8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B41078F;
	Mon,  1 Apr 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UiwlZdnz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3210A11;
	Mon,  1 Apr 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964649; cv=none; b=qWt6FCFi3Va5yn41Eb8w5AeT6Z+rJQxo5Ywcqk8iUlzAtj7PtrlbD0fcafEd7a6FXKb1cp5+wL/+nnrHspve2M0Xwlnzyy4qEMQK01VBG7MUNCyZ9Mgr4jrJ46hePARS/D2mQ0YUA2SrMijfEO+7xguOId8QbMps6SnpfEYX8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964649; c=relaxed/simple;
	bh=B4rIpTmUjg9j2qff3gHUT9sWnc6MSWWI4r1UzmPXbFI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NDEmGKx8kIKpBsXsvDjS2GCo9czOJSkmmniy8KU8X4+xwKh+V3WOS7LcMs+D8FEdzpoW+/RrmqDkqFccZW7oxvYQNucGEH+OdmtGtY/4C3VudWAiOKjOmDcjBDRKD995wOgVxuOX8cuGPuxqMpOk0WXdru4PKE+pqB6JC0l3V9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UiwlZdnz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711964645;
	bh=B4rIpTmUjg9j2qff3gHUT9sWnc6MSWWI4r1UzmPXbFI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UiwlZdnzsIsJo9/MsBqbv/PXEH9C5l/ri0QkFm+9h089XGKLgGV08+j/C4JkIBiUD
	 LksWymBQQbfZd/bkEh9AGgl1y6VK1cB211LXUbDUQsh2cNUAZLQ56r2sCzybAg2fJX
	 o4GuKSEHenjbVIkgS9G6rs4UfZ/Vat/mHpQ2zH/TdYpUYVTBzifNlTBmuPVGCXd2WO
	 eexwGZul2YuuXk0gDGt20z4WfgJH7D9UDytZsGv4dBjwBHamUtYl7xIJw6WiTU5dGL
	 0AnpRd5lHZMb1JIAuebI1WDuVLLByRubJq/CDxs556WaUGTlW4PtGggy94BYFRJC24
	 Fp/6Ok7R4UAvA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CDB80378148F;
	Mon,  1 Apr 2024 09:41:31 +0000 (UTC)
Message-ID: <de7835fe-0f60-451c-9f7b-b380e1c65273@collabora.com>
Date: Mon, 1 Apr 2024 14:41:26 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kvm@vger.kernel.org,
 pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 3/3] KVM: selftests: Add a test case for
 KVM_X86_DISABLE_EXITS_HLT
To: Manali Shukla <manali.shukla@amd.com>
References: <20240327054255.24626-1-manali.shukla@amd.com>
 <20240327054255.24626-4-manali.shukla@amd.com>
 <7e093e45-9349-4cfd-a0ad-78ae66edda90@collabora.com>
 <5d667c81-56a8-95bd-4aa1-4df16c42dabf@amd.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <5d667c81-56a8-95bd-4aa1-4df16c42dabf@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/24 10:28 AM, Manali Shukla wrote:
> Hi Muhammad Usama Anjum,
> 
> Thank you for reviewing my patch.
> 
> On 3/30/2024 1:43 AM, Muhammad Usama Anjum wrote:
>> On 3/27/24 10:42 AM, Manali Shukla wrote:
>>> By default, HLT instruction executed by guest is intercepted by hypervisor.
>>> However, KVM_CAP_X86_DISABLE_EXITS capability can be used to not intercept
>>> HLT by setting KVM_X86_DISABLE_EXITS_HLT.
>>>
>>> Add a test case to test KVM_X86_DISABLE_EXITS_HLT functionality.
>>>
>>> Suggested-by: Sean Christopherson <seanjc@google.com>
>>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> Thank you for the new test patch. We have been trying to ensure TAP
>> conformance for tests which cannot be achieved if new tests aren't using
>> TAP already. Please make your test TAP compliant.
> 
> As per my understanding about TAP interface, kvm_test_harness.h file includes a MACRO,
> which is used to create VM with one vcpu using vm_create_with_one_vcpu(), but
> halt_disable_exit_test creates a customized VM with KVM_CAP_X86_DISABLE_EXITS
> capability set and different vm_shape parameters to start a VM without in-kernel
> APIC support. AFAIU, I won't be able to use KVM_ONE_VCPU_TEST_SUITE MACRO as is.
> How do you suggest to proceed with this issue? 
TAP interface is just a way to print logs which are machine readable for
CIs. So log messages, test pass or fail should be marked by
tools/testing/selftests/kselftest.h or
tools/testing/selftests/kselftest_harness.h. It depends on the design of
your test that which would be suitable.

It seems that most tests in KVM suite aren't TAP compliant. In this case,
I'm okay with non-TAP compliant test as the whole suite is far from compliance.

> 
>>
>>> ---
>>>  tools/testing/selftests/kvm/Makefile          |   1 +
>>>  .../kvm/x86_64/halt_disable_exit_test.c       | 113 ++++++++++++++++++
>> Add generated object to .gitignore file.
> 
> Sure. I will do it.
>>
>>>  2 files changed, 114 insertions(+)
>>>  create mode 100644 tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>>>
>>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>>> index c75251d5c97c..9f72abb95d2e 100644
>>> --- a/tools/testing/selftests/kvm/Makefile
>>> +++ b/tools/testing/selftests/kvm/Makefile
>>> @@ -89,6 +89,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/smm_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/state_test
>>> +TEST_GEN_PROGS_x86_64 += x86_64/halt_disable_exit_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
>>> diff --git a/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>>> new file mode 100644
>>> index 000000000000..b7279dd0eaff
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
>>> @@ -0,0 +1,113 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * KVM disable halt exit test
>>> + *
>>> + *  Copyright (C) 2024 Advanced Micro Devices, Inc.
>>> + */
>>> +#include <pthread.h>
>>> +#include <signal.h>
>>> +#include "kvm_util.h"
>>> +#include "svm_util.h"
>>> +#include "processor.h"
>>> +#include "test_util.h"
>>> +
>>> +pthread_t task_thread, vcpu_thread;
>>> +#define SIG_IPI SIGUSR1
>>> +
>>> +static void guest_code(uint8_t is_hlt_exec)
>>> +{
>>> +	while (!READ_ONCE(is_hlt_exec))
>>> +		;
>>> +
>>> +	safe_halt();
>>> +	GUEST_DONE();
>>> +}
>>> +
>>> +static void *task_worker(void *arg)
>>> +{
>>> +	uint8_t *is_hlt_exec = (uint8_t *)arg;
>>> +
>>> +	usleep(1000);
>>> +	WRITE_ONCE(*is_hlt_exec, 1);
>>> +	pthread_kill(vcpu_thread, SIG_IPI);
>>> +	return 0;
>>> +}
>>> +
>>> +static void *vcpu_worker(void *arg)
>>> +{
>>> +	int ret;
>>> +	int sig = -1;
>>> +	uint8_t *is_hlt_exec = (uint8_t *)arg;
>>> +	struct kvm_vm *vm;
>>> +	struct kvm_run *run;
>>> +	struct kvm_vcpu *vcpu;
>>> +	struct kvm_signal_mask *sigmask = alloca(offsetof(struct kvm_signal_mask, sigset)
>>> +						 + sizeof(sigset_t));
>>> +	sigset_t *sigset = (sigset_t *) &sigmask->sigset;
>>> +
>>> +	/* Create a VM without in kernel APIC support */
>>> +	vm = __vm_create(VM_SHAPE_DEFAULT, 1, 0, false);
>>> +	vm_enable_cap(vm, KVM_CAP_X86_DISABLE_EXITS, KVM_X86_DISABLE_EXITS_HLT);
>>> +	vcpu = vm_vcpu_add(vm, 0, guest_code);
>>> +	vcpu_args_set(vcpu, 1, *is_hlt_exec);
>>> +
>>> +	/*
>>> +	 * SIG_IPI is unblocked atomically while in KVM_RUN.  It causes the
>>> +	 * ioctl to return with -EINTR, but it is still pending and we need
>>> +	 * to accept it with the sigwait.
>>> +	 */
>>> +	sigmask->len = 8;
>>> +	pthread_sigmask(0, NULL, sigset);
>>> +	sigdelset(sigset, SIG_IPI);
>>> +	vcpu_ioctl(vcpu, KVM_SET_SIGNAL_MASK, sigmask);
>>> +	sigemptyset(sigset);
>>> +	sigaddset(sigset, SIG_IPI);
>>> +	run = vcpu->run;
>>> +
>>> +again:
>>> +	ret = __vcpu_run(vcpu);
>>> +	TEST_ASSERT_EQ(errno, EINTR);
>>> +
>>> +	if (ret == -1 && errno == EINTR) {
>>> +		sigwait(sigset, &sig);
>>> +		assert(sig == SIG_IPI);
>>> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_INTR);
>>> +		goto again;
>>> +	}
>>> +
>>> +	if (run->exit_reason == KVM_EXIT_HLT)
>>> +		TEST_FAIL("Expected KVM_EXIT_INTR, got KVM_EXIT_HLT");
>>> +
>>> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>>> +	kvm_vm_free(vm);
>>> +	return 0;
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +	int ret;
>>> +	void *retval;
>>> +	uint8_t is_halt_exec;
>>> +	sigset_t sigset;
>>> +
>>> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_DISABLE_EXITS));
>>> +
>>> +	/* Ensure that vCPU threads start with SIG_IPI blocked.  */
>>> +	sigemptyset(&sigset);
>>> +	sigaddset(&sigset, SIG_IPI);
>>> +	pthread_sigmask(SIG_BLOCK, &sigset, NULL);
>>> +
>>> +	ret = pthread_create(&vcpu_thread, NULL, vcpu_worker, &is_halt_exec);
>>> +	TEST_ASSERT(ret == 0, "pthread_create vcpu thread failed errno=%d", errno);
>>> +
>>> +	ret = pthread_create(&task_thread, NULL, task_worker, &is_halt_exec);
>>> +	TEST_ASSERT(ret == 0, "pthread_create task thread failed errno=%d", errno);
>>> +
>>> +	pthread_join(vcpu_thread, &retval);
>>> +	TEST_ASSERT(ret == 0, "pthread_join on vcpu thread failed with errno=%d", ret);
>>> +
>>> +	pthread_join(task_thread, &retval);
>>> +	TEST_ASSERT(ret == 0, "pthread_join on task thread failed with errno=%d", ret);
>>> +
>>> +	return 0;
>>> +}
>>
> - Manali
> 

-- 
BR,
Muhammad Usama Anjum

