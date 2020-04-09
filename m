Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEE791A397F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Apr 2020 20:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgDISC3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Apr 2020 14:02:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42312 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDISC3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Apr 2020 14:02:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039Hvq6B143624;
        Thu, 9 Apr 2020 18:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=QbwlsHF1UsuyjY4wVgTLpeTk28enRWpT5FLMPFAsIQk=;
 b=gaavZG8Kn1bmygvqBR8y+LTQKEoF8ktlc3FN0uzxoP3XVDoTDtAI6BvUDhjwbUnth8te
 unF8nBNmA+dyw4IGi73UwG+IWTTc9XhKbmnjixZ9uwtoua74dci3kHQWBUqkLhoevIoh
 IyO9RWl6EroNcTKWLLjknvCWJ8xDFXZKqJicOTsXahF2Fc41RsOps+uUq4WxZh6evYWG
 D+R7qG4iDcEzEgohiqnPe0dC/HmEjKvf0k6XAiy4ZTqS/WviUFby/KP7f77RnZN1biHx
 8Vfn4RkAUzv8Pn9QT0cQ4BygcnJbhCeW2VHGbt3GR5vtprxINLlsHRCUrrYx8JHNAPHF jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3091m131mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 18:02:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039HudaO048465;
        Thu, 9 Apr 2020 18:02:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 309gdccxsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 18:02:24 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 039I2NRN006673;
        Thu, 9 Apr 2020 18:02:23 GMT
Received: from localhost.localdomain (/10.159.147.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 11:02:23 -0700
Subject: Re: [PATCH v4 2/2] selftests: kvm: Add mem_slot_test test
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        pbonzini@redhat.com, kvm@vger.kernel.org
Cc:     drjones@redhat.com, david@redhat.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200408220818.4306-1-wainersm@redhat.com>
 <20200408220818.4306-3-wainersm@redhat.com>
 <0009f75a-4c09-139e-c793-574291ad20dc@oracle.com>
 <2fa07481-effb-788d-89d2-0b54842cbd4b@redhat.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <7273e4d4-49d0-829b-630a-273bda29ef7e@oracle.com>
Date:   Thu, 9 Apr 2020 11:02:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2fa07481-effb-788d-89d2-0b54842cbd4b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=2 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090130
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/8/20 8:01 PM, Wainer dos Santos Moschetta wrote:
>
> On 4/8/20 10:31 PM, Krish Sadhukhan wrote:
>>
>> On 4/8/20 3:08 PM, Wainer dos Santos Moschetta wrote:
>>> This patch introduces the mem_slot_test test which checks
>>> an VM can have added memory slots up to the limit defined in
>>> KVM_CAP_NR_MEMSLOTS. Then attempt to add one more slot to
>>> verify it fails as expected.
>>>
>>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>> ---
>>>   tools/testing/selftests/kvm/.gitignore      |  1 +
>>>   tools/testing/selftests/kvm/Makefile        |  3 +
>>>   tools/testing/selftests/kvm/mem_slot_test.c | 76 
>>> +++++++++++++++++++++
>>>   3 files changed, 80 insertions(+)
>>>   create mode 100644 tools/testing/selftests/kvm/mem_slot_test.c
>>>
>>> diff --git a/tools/testing/selftests/kvm/.gitignore 
>>> b/tools/testing/selftests/kvm/.gitignore
>>> index 16877c3daabf..127d27188427 100644
>>> --- a/tools/testing/selftests/kvm/.gitignore
>>> +++ b/tools/testing/selftests/kvm/.gitignore
>>> @@ -21,4 +21,5 @@
>>>   /demand_paging_test
>>>   /dirty_log_test
>>>   /kvm_create_max_vcpus
>>> +/mem_slot_test
>>>   /steal_time
>>> diff --git a/tools/testing/selftests/kvm/Makefile 
>>> b/tools/testing/selftests/kvm/Makefile
>>> index 712a2ddd2a27..338b6cdce1a0 100644
>>> --- a/tools/testing/selftests/kvm/Makefile
>>> +++ b/tools/testing/selftests/kvm/Makefile
>>> @@ -32,12 +32,14 @@ TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
>>>   TEST_GEN_PROGS_x86_64 += demand_paging_test
>>>   TEST_GEN_PROGS_x86_64 += dirty_log_test
>>>   TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
>>> +TEST_GEN_PROGS_x86_64 += mem_slot_test
>>>   TEST_GEN_PROGS_x86_64 += steal_time
>>>     TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
>>>   TEST_GEN_PROGS_aarch64 += demand_paging_test
>>>   TEST_GEN_PROGS_aarch64 += dirty_log_test
>>>   TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
>>> +TEST_GEN_PROGS_aarch64 += mem_slot_test
>>>   TEST_GEN_PROGS_aarch64 += steal_time
>>>     TEST_GEN_PROGS_s390x = s390x/memop
>>> @@ -46,6 +48,7 @@ TEST_GEN_PROGS_s390x += s390x/sync_regs_test
>>>   TEST_GEN_PROGS_s390x += demand_paging_test
>>>   TEST_GEN_PROGS_s390x += dirty_log_test
>>>   TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
>>> +TEST_GEN_PROGS_s390x += mem_slot_test
>>>     TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
>>>   LIBKVM += $(LIBKVM_$(UNAME_M))
>>> diff --git a/tools/testing/selftests/kvm/mem_slot_test.c 
>>> b/tools/testing/selftests/kvm/mem_slot_test.c
>>> new file mode 100644
>>> index 000000000000..7c1009f0bc07
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/kvm/mem_slot_test.c
>>> @@ -0,0 +1,76 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * mem_slot_test
>>> + *
>>> + * Copyright (C) 2020, Red Hat, Inc.
>>> + *
>>> + * Test suite for memory region operations.
>>> + */
>>> +#define _GNU_SOURCE /* for program_invocation_short_name */
>>> +#include <linux/kvm.h>
>>> +#include <sys/mman.h>
>>> +
>>> +#include "test_util.h"
>>> +#include "kvm_util.h"
>>> +
>>> +/*
>>> + * Test it can be added memory slots up to KVM_CAP_NR_MEMSLOTS, 
>>> then any
>>> + * tentative to add further slots should fail.
>>> + */
>>> +static void test_add_max_slots(void)
>>> +{
>>> +    int ret;
>>> +    struct kvm_vm *vm;
>>> +    uint32_t max_mem_slots;
>>> +    uint32_t slot;
>>> +    uint64_t guest_addr;
>>> +    uint64_t mem_reg_npages;
>>> +    uint64_t mem_reg_size;
>>> +    void *mem;
>>> +
>>> +    max_mem_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
>>> +    TEST_ASSERT(max_mem_slots > 0,
>>> +            "KVM_CAP_NR_MEMSLOTS should be greater than 0");
>>> +    pr_info("Allowed number of memory slots: %i\n", max_mem_slots);
>>> +
>>> +    vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
>>> +
>>> +    /*
>>> +     * Uses 1MB sized/aligned memory region since this is the minimal
>>> +     * required on s390x.
>>> +     */
>>> +    mem_reg_size = 0x100000;
>>> +    mem_reg_npages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, 
>>> mem_reg_size);
>>> +
>>> +    guest_addr = 0x0;
>>
>>
>> Nit: Can't this be initialized where it's defined above ?
>
>
> I don't have a strong preference. Is it generally initialized on 
> definition on kvm (selftests or not) code?
>
>

Some places do it where the variable is defined. For example, in smm_test.c,

         vm_vaddr_t vmx_pages_gva = 0;


It reduces an extra line.

>>
>>
>>> +
>>> +    /* Check it can be added memory slots up to the maximum allowed */
>>> +    pr_info("Adding slots 0..%i, each memory region with %ldK size\n",
>>> +        (max_mem_slots - 1), mem_reg_size >> 10);
>>> +    for (slot = 0; slot < max_mem_slots; slot++) {
>>> +        vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
>>> +                        guest_addr, slot, mem_reg_npages,
>>> +                        0);
>>> +        guest_addr += mem_reg_size;
>>> +    }
>>> +
>>> +    /* Check it cannot be added memory slots beyond the limit */
>>> +    mem = mmap(NULL, mem_reg_size, PROT_READ | PROT_WRITE,
>>> +           MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>> +    TEST_ASSERT(mem != MAP_FAILED, "Failed to mmap() host");
>>> +
>>> +    ret = ioctl(vm_get_fd(vm), KVM_SET_USER_MEMORY_REGION,
>>> +            &(struct kvm_userspace_memory_region) {slot, 0, 
>>> guest_addr,
>>> +            mem_reg_size, (uint64_t) mem});
>>> +    TEST_ASSERT(ret == -1 && errno == EINVAL,
>>> +            "Adding one more memory slot should fail with EINVAL");
>>
>>
>> Why not add a test here for adding memory at an existing slot ?
>
> Good question.
>
> I'm working on another test which should check it cannot be added 
> overlapping slots. I will send it in a separate patch series, 
> depending on the fate of this one. :)
>
> More precisely, those are the cases I will cover on this new test:
>
>
>                 0x100000  0x300000
>           0x0         0x200000 0x400000
>  slot0 |              |---2MB--|                         (SUCCESS)
>  slot1       |---2MB--|                                  (FAIL)
>  slot2 |---2MB--|                                        (SUCCESS)
>  slot3                |---2MB--|                         (FAIL)
>  slot4                         |---2MB--|                (FAIL)
>  slot5                               |---2MB--|          (SUCCESS)
>
> Thanks!
>
> Wainer


OK.

Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>

>
>>
>>
>>> +
>>> +    munmap(mem, mem_reg_size);
>>> +    kvm_vm_free(vm);
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +    test_add_max_slots();
>>> +    return 0;
>>> +}
>>
>
