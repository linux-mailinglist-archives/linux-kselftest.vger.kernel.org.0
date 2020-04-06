Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC53C19FB0D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Apr 2020 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgDFRLI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Apr 2020 13:11:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29178 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726512AbgDFRLH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Apr 2020 13:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586193065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+sqWo/TjFzm8Hn0zNEDNsba3wfUK+bDLDnQzQjnVZQE=;
        b=OfBuP9zPa1PBaeljz3MXXhZgmAxlfwl1IE3rFdoFR3Czoykv8XH0TH70v989PuK7YxQWbu
        8Dx62oHPwe6nZR1Oe/QmQsJO4HyCmHFYQvYqKUJgngL3jBXmZWwDDreDm7feDlzyE+RjFw
        4i9OW0Oy+B1C+1HH9O/64cSq1NiRB2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-J9HE1_lmO-O1xrwmkUOtSg-1; Mon, 06 Apr 2020 13:11:03 -0400
X-MC-Unique: J9HE1_lmO-O1xrwmkUOtSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24DA6107ACC7;
        Mon,  6 Apr 2020 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B362E60BE0;
        Mon,  6 Apr 2020 17:10:55 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] selftests: kvm: Add mem_slot_test test
To:     Andrew Jones <drjones@redhat.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20200403172428.15574-1-wainersm@redhat.com>
 <20200403172428.15574-3-wainersm@redhat.com>
 <20200404073240.grcsylznemd3pmxz@kamzik.brq.redhat.com>
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <64a47faa-74f5-60ad-9b74-8c295072c719@redhat.com>
Date:   Mon, 6 Apr 2020 14:10:53 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200404073240.grcsylznemd3pmxz@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/4/20 4:32 AM, Andrew Jones wrote:
> On Fri, Apr 03, 2020 at 02:24:28PM -0300, Wainer dos Santos Moschetta wrote:
>> This patch introduces the mem_slot_test test which checks
>> an VM can have added memory slots up to the limit defined in
>> KVM_CAP_NR_MEMSLOTS. Then attempt to add one more slot to
>> verify it fails as expected.
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> ---
>>   tools/testing/selftests/kvm/.gitignore      |  1 +
>>   tools/testing/selftests/kvm/Makefile        |  3 +
>>   tools/testing/selftests/kvm/mem_slot_test.c | 85 +++++++++++++++++++++
>>   3 files changed, 89 insertions(+)
>>   create mode 100644 tools/testing/selftests/kvm/mem_slot_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
>> index 16877c3daabf..232f24d6931a 100644
>> --- a/tools/testing/selftests/kvm/.gitignore
>> +++ b/tools/testing/selftests/kvm/.gitignore
>> @@ -22,3 +22,4 @@
>>   /dirty_log_test
>>   /kvm_create_max_vcpus
>>   /steal_time
>> +/mem_slot_test
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index 712a2ddd2a27..69b44178f48b 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -33,12 +33,14 @@ TEST_GEN_PROGS_x86_64 += demand_paging_test
>>   TEST_GEN_PROGS_x86_64 += dirty_log_test
>>   TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
>>   TEST_GEN_PROGS_x86_64 += steal_time
>> +TEST_GEN_PROGS_x86_64 += mem_slot_test
>>   
>>   TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
>>   TEST_GEN_PROGS_aarch64 += demand_paging_test
>>   TEST_GEN_PROGS_aarch64 += dirty_log_test
>>   TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
>>   TEST_GEN_PROGS_aarch64 += steal_time
>> +TEST_GEN_PROGS_aarch64 += mem_slot_test
>>   
> kvm selftests has a bad case of OCD when it comes to lists of tests. In
> the .gitignore and the Makefile we keep our tests in alphabetical order.
> Maybe we should stop, because it's a bit annoying to maintain, but my
> personal OCD won't allow it to be on my watch. Please fix the above
> three lists.

I will fix it on v3.

Kind of related... has ever been discussed a naming convention for kvm 
selftests? It would allow the use of regex on both .gitignore and 
Makefile...and bye-bye those sorted lists.


>
>>   TEST_GEN_PROGS_s390x = s390x/memop
>>   TEST_GEN_PROGS_s390x += s390x/resets
>> @@ -46,6 +48,7 @@ TEST_GEN_PROGS_s390x += s390x/sync_regs_test
>>   TEST_GEN_PROGS_s390x += demand_paging_test
>>   TEST_GEN_PROGS_s390x += dirty_log_test
>>   TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
>> +TEST_GEN_PROGS_s390x += mem_slot_test
>>   
>>   TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
>>   LIBKVM += $(LIBKVM_$(UNAME_M))
>> diff --git a/tools/testing/selftests/kvm/mem_slot_test.c b/tools/testing/selftests/kvm/mem_slot_test.c
>> new file mode 100644
>> index 000000000000..eef6f506f41d
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/mem_slot_test.c
>> @@ -0,0 +1,85 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * mem_slot_test
>> + *
>> + * Copyright (C) 2020, Red Hat, Inc.
>> + *
>> + * Test suite for memory region operations.
>> + */
>> +#define _GNU_SOURCE /* for program_invocation_short_name */
>> +#include <linux/kvm.h>
>> +#include <sys/mman.h>
>> +
>> +#include "test_util.h"
>> +#include "kvm_util.h"
>> +
>> +/*
>> + * Test it can be added memory slots up to KVM_CAP_NR_MEMSLOTS, then any
>> + * tentative to add further slots should fail.
>> + */
>> +static void test_add_max_slots(void)
>> +{
>> +	struct kvm_vm *vm;
>> +	uint32_t max_mem_slots;
>> +	uint32_t slot;
>> +	uint64_t mem_reg_npages;
>> +	uint64_t mem_reg_size;
>> +	uint32_t mem_reg_flags;
>> +	uint64_t guest_addr;
>> +	int ret;
>> +
>> +	max_mem_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
>> +	TEST_ASSERT(max_mem_slots > 0,
>> +		    "KVM_CAP_NR_MEMSLOTS should be greater than 0");
>> +	pr_info("Allowed number of memory slots: %i\n", max_mem_slots);
>> +
>> +	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
>> +
>> +	/*
>> +	 * Uses 1MB sized/aligned memory region since this is the minimal
>> +	 * required on s390x.
>> +	 */
>> +	mem_reg_size = 0x100000;
>> +	mem_reg_npages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, mem_reg_size);
>> +
>> +	mem_reg_flags = kvm_check_cap(KVM_CAP_READONLY_MEM) ? KVM_MEM_READONLY :
>> +		KVM_MEM_LOG_DIRTY_PAGES;
> I still don't see why we're setting a flag at all, and now we're setting
> different flags depending on what's available, so the test isn't the
> same for every environment. I would just have mem->flags = 0 for this
> test.
I thought I had to set a memory flag always. If mem->flags = 0 works 
across the arches, then I change this on v3.
>
>> +
>> +	guest_addr = 0x0;
>> +
>> +	/* Check it can be added memory slots up to the maximum allowed */
>> +	pr_info("Adding slots 0..%i, each memory region with %ldK size\n",
>> +		(max_mem_slots - 1), mem_reg_size >> 10);
>> +	for (slot = 0; slot < max_mem_slots; slot++) {
>> +		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
>> +					    guest_addr, slot, mem_reg_npages,
>> +					    mem_reg_flags);
>> +		guest_addr += mem_reg_size;
>> +	}
>> +
>> +	/* Check it cannot be added memory slots beyond the limit */
>> +	void *mem = mmap(NULL, mem_reg_size, PROT_READ | PROT_WRITE,
>> +			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> +	TEST_ASSERT(mem != NULL, "Failed to mmap() host");
> This should be testing mem != MAP_FAILED

Ok.

>
>> +
>> +	struct kvm_userspace_memory_region kvm_region = {
>> +		.slot = slot,
>> +		.flags = mem_reg_flags,
>> +		.guest_phys_addr = guest_addr,
>> +		.memory_size = mem_reg_size,
>> +		.userspace_addr = (uint64_t) mem,
>> +	};
> Declaring kvm_region in the middle of the block. I don't really care
> myself, but it's inconsistent with all the other variables which are
> declared at the top.

Makes sense.

>
>> +
>> +	ret = ioctl(vm_get_fd(vm), KVM_SET_USER_MEMORY_REGION, &kvm_region);
>> +	TEST_ASSERT(ret == -1, "Adding one more memory slot should fail");
>> +	TEST_ASSERT(errno == EINVAL, "Should return EINVAL errno");
> Please make the second assert message more specific. Or better would be
> to combine the asserts
>
>    TEST_ASSERT(ret == -1 && errno == EINVAL, "Adding one more memory slot should fail with EINVAL");

Yeah, I was unsure about and'ing the checks. I will change it on v3.

Thanks!

Wainer

>
>> +
>> +	munmap(mem, mem_reg_size);
>> +	kvm_vm_free(vm);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	test_add_max_slots();
>> +	return 0;
>> +}
>> -- 
>> 2.17.2
>>
> Thanks,
> drew

