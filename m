Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D73934178E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 09:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhCSIfu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 04:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234225AbhCSIfX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 04:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616142923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+QMJk0xgpg3V22PAHodfaQYWUflqcQBZtDZTxUZTHuk=;
        b=Gr8OqUrKAZhquXnUMFtzoY5KUKScIzBacnuxfyGEHEabomp0g/ezOer/wCW1wpHOD5rvqS
        bKqZ/NgIRaX56GPo1C1JiJyQ/PZqIo/MXqxISkIa0e9wobiBL6VYs78WPG7QoQ4ch2NKdZ
        Q+ZRKidh1BFs7ZaRQCbsfaS/Gm8N9ws=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-j7OWICg6MHaO9Af0xjGDQw-1; Fri, 19 Mar 2021 04:35:21 -0400
X-MC-Unique: j7OWICg6MHaO9Af0xjGDQw-1
Received: by mail-ej1-f69.google.com with SMTP id 11so17879818ejz.20
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 01:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+QMJk0xgpg3V22PAHodfaQYWUflqcQBZtDZTxUZTHuk=;
        b=oKvP1FzdoGTmklYOQEy0byN8zK0PguTi9okqRqEM27VDJi/NSxwf7y6SSec1RDg/41
         B1XsHT7mmcN0sR5ipXiniLFoWYea2dqYArPXuBNPskkuR0gTUni9NPlOCsAcoyUy4IZB
         F931cH+XpQqm23LtnD654oY8cQ8NL72TovnAeqeGxwq1lXUfEpce7ZyTe3oCh0u537V4
         7lnX2JloYcuqIP4qkzkOO21EdqmFLF/FA+Ez1rnT8rKaPcg0RwdV0x1VmyqVIJRqsjcN
         /ePZZNUbmwFL6q3/1bvNhkmPK2O6bB3JxAQiUfqtru95OGVRUw10xga0ueGxwRFusutg
         rHRg==
X-Gm-Message-State: AOAM533hi/wNuQUVUxvLIgmaU3MdxW57HJSMUGm1RpAtCSS1E/cUG7AB
        Dq02R0EJizvCHoWimegrckwp5/IrEmLLqCBC3vMfccxzhH5jlbicQkImgk/bBuZ4aSld5XysFR2
        +0NpWBKKhKGJ47lzoY9T+TfozFf5J
X-Received: by 2002:aa7:c3c1:: with SMTP id l1mr8284846edr.208.1616142920565;
        Fri, 19 Mar 2021 01:35:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDxmUWVwsC44ioClgn8Ff3bGZXB3ot3x/r/wYXMKPZjfZw0XThD6htydxrQJ+sGSY24K1ITg==
X-Received: by 2002:aa7:c3c1:: with SMTP id l1mr8284833edr.208.1616142920417;
        Fri, 19 Mar 2021 01:35:20 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.135])
        by smtp.gmail.com with ESMTPSA id v8sm3609424edx.38.2021.03.19.01.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 01:35:19 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] selftests/kvm: add set_boot_cpu_id test
To:     Andrew Jones <drjones@redhat.com>
Cc:     linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210318151624.490861-1-eesposit@redhat.com>
 <20210318151624.490861-2-eesposit@redhat.com>
 <20210318162036.sf6vgq2ntbgulpzb@kamzik.brq.redhat.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <a81f1f39-8ff0-4fd9-d859-57569c437f39@redhat.com>
Date:   Fri, 19 Mar 2021 09:34:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318162036.sf6vgq2ntbgulpzb@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 18/03/2021 17:20, Andrew Jones wrote:
> On Thu, Mar 18, 2021 at 04:16:24PM +0100, Emanuele Giuseppe Esposito wrote:
>> Test for the KVM_SET_BOOT_CPU_ID ioctl.
>> Check that it correctly allows to change the BSP vcpu.
>>
>> v1 -> v2:
>> - remove unnecessary printf
>> - move stage for loop inside run_vcpu
>> - test EBUSY when calling KVM_SET_BOOT_CPU_ID after vcpu
>>    creation and execution
>> - introduce _vm_ioctl
> 
> This information should be in the cover-letter. Or, for a single patch (no
> cover-letter needed submission), then it should go below the '---' under
> your s-o-b.
> 
>>

>> +static void add_x86_vcpu(struct kvm_vm *vm, uint32_t vcpuid, bool bsp_code)
>> +{
>> +	if (bsp_code)
>> +		vm_vcpu_add_default(vm, vcpuid, guest_bsp_vcpu);
>> +	else
>> +		vm_vcpu_add_default(vm, vcpuid, guest_not_bsp_vcpu);
>> +
>> +	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
>> +}
>> +
>> +static void run_vm_bsp(uint32_t bsp_vcpu)
> 
> I think the 'bsp' suffixes and prefixes make the purpose of this function
> and its argument more confusing. Just
> 
>   static void run_vm(uint32_t vcpu)
> 
> would be more clear to me.

The idea here was "run vm with this vcpu as BSP", implicitly assuming 
that there are alwasy 2 vcpu inside, so we are picking one as BSP.

Maybe

run_vm_2_vcpu(uint32_t bsp_vcpid)

is better?

> 
>> +{
>> +	struct kvm_vm *vm;
>> +	bool is_bsp_vcpu1 = bsp_vcpu == VCPU_ID1;
> 
> Could add another define
> 
>   #define BSP_VCPU VCPU_ID1
> 
> And then instead of creating the above bool, just do
> 
>   if (vcpu == BSP_VCPU)

I think it will be even more confusing to have BSP_VCPU fixed to 
VCPU_ID1, because in the tests before and after I use VCPU_ID0 as BSP.

	run_vm_bsp(VCPU_ID0);
	run_vm_bsp(VCPU_ID1);
	run_vm_bsp(VCPU_ID0);

> 
>> +
>> +	vm = create_vm();
>> +
>> +	if (is_bsp_vcpu1)
>> +		vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
> 
> Does this ioctl need to be called before creating the vcpus? The
> documentation in Documentation/virt/kvm/api.rst doesn't say that.

Yes, it has to be called before creating the vcpus, as also shown in the 
test function "check_set_bsp_busy". KVM checks that created_vcpus is 0 
before setting the bsp field.

arch/x86/kvm/x86.c
		case KVM_SET_BOOT_CPU_ID:
		...
		if (kvm->created_vcpus)
			r = -EBUSY;
		else
			kvm->arch.bsp_vcpu_id = arg;

I will update the documentation to include also this information.

> If it can be called after creating the vcpus, then
> vm_create_default_with_vcpus() can be used and there's no need
> for the create_vm() and add_x86_vcpu() functions.

Just use the
> same guest code for both, but pass the cpu index to the guest
> code function allowing something like
> 
>     if (cpu == BSP_VCPU)
> 	GUEST_ASSERT(get_bsp_flag() != 0);
>     else
> 	GUEST_ASSERT(get_bsp_flag() == 0);
> 
I might be wrong, but there seems not to be an easy way to pass 
arguments to the guest function.

Thank you,
Emanuele
> 
>> +
>> +	add_x86_vcpu(vm, VCPU_ID0, !is_bsp_vcpu1);
>> +	add_x86_vcpu(vm, VCPU_ID1, is_bsp_vcpu1);
>> +
>> +	run_vcpu(vm, VCPU_ID0);
>> +	run_vcpu(vm, VCPU_ID1);
>> +
>> +	kvm_vm_free(vm);
>> +}
>> +
>> +static void check_set_bsp_busy(void)
>> +{
>> +	struct kvm_vm *vm;
>> +	int res;
>> +
>> +	vm = create_vm();
>> +
>> +	add_x86_vcpu(vm, VCPU_ID0, true);
>> +	add_x86_vcpu(vm, VCPU_ID1, false);
>> +
>> +	res = _vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
>> +	TEST_ASSERT(res == -1 && errno == EBUSY, "KVM_SET_BOOT_CPU_ID set after adding vcpu");
>> +
>> +	run_vcpu(vm, VCPU_ID0);
>> +	run_vcpu(vm, VCPU_ID1);
>> +
>> +	res = _vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
>> +	TEST_ASSERT(res == -1 && errno == EBUSY, "KVM_SET_BOOT_CPU_ID set to a terminated vcpu");
>> +
>> +	kvm_vm_free(vm);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	if (!kvm_check_cap(KVM_CAP_SET_BOOT_CPU_ID)) {
>> +		print_skip("set_boot_cpu_id not available");
>> +		return 0;
> 
> Should be exit(KSFT_SKIP);
> 
>> +	}
>> +
>> +	run_vm_bsp(VCPU_ID0);
>> +	run_vm_bsp(VCPU_ID1);
>> +	run_vm_bsp(VCPU_ID0);
>> +
>> +	check_set_bsp_busy();
> 
> Don't you get a compiler warning here saying there's no return from a
> function that returns int?
> 
>> +}
>> -- 
>> 2.29.2
>>
> 
> Thanks,
> drew
> 

