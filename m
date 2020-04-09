Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 338731A2DCE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Apr 2020 05:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDIDBo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Apr 2020 23:01:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44872 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726523AbgDIDBo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Apr 2020 23:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586401303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WO6th5iglO/vCpRCjBIVJY71pAHVzermG4zRkNZ/5uI=;
        b=eiGr5pq1mIzPGhud3o+b8fmYEEI/AQwI6NSDy5i4bfYGmi1sQL5M1nZ3j+2k1ZpLrA6w7z
        ExjclHe8alnVBNlB3LRAE9W4GilKF0EVPRjXqAavQEevrLxCiGVmWVFCys7kdiqoPlbPiJ
        /YU2vWn1DNUccUZqRae78ExIIoR149U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-kVoCApZRO16ZWYNbhbPj6Q-1; Wed, 08 Apr 2020 23:01:41 -0400
X-MC-Unique: kVoCApZRO16ZWYNbhbPj6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B5718018A8;
        Thu,  9 Apr 2020 03:01:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 024965D9C9;
        Thu,  9 Apr 2020 03:01:35 +0000 (UTC)
Subject: Re: [PATCH v4 2/2] selftests: kvm: Add mem_slot_test test
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org
Cc:     drjones@redhat.com, david@redhat.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200408220818.4306-1-wainersm@redhat.com>
 <20200408220818.4306-3-wainersm@redhat.com>
 <0009f75a-4c09-139e-c793-574291ad20dc@oracle.com>
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <2fa07481-effb-788d-89d2-0b54842cbd4b@redhat.com>
Date:   Thu, 9 Apr 2020 00:01:33 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0009f75a-4c09-139e-c793-574291ad20dc@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/8/20 10:31 PM, Krish Sadhukhan wrote:
>
> On 4/8/20 3:08 PM, Wainer dos Santos Moschetta wrote:
>> This patch introduces the mem_slot_test test which checks
>> an VM can have added memory slots up to the limit defined in
>> KVM_CAP_NR_MEMSLOTS. Then attempt to add one more slot to
>> verify it fails as expected.
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> ---
>> =C2=A0 tools/testing/selftests/kvm/.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
>> =C2=A0 tools/testing/selftests/kvm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 +
>> =C2=A0 tools/testing/selftests/kvm/mem_slot_test.c | 76 ++++++++++++++=
+++++++
>> =C2=A0 3 files changed, 80 insertions(+)
>> =C2=A0 create mode 100644 tools/testing/selftests/kvm/mem_slot_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/.gitignore=20
>> b/tools/testing/selftests/kvm/.gitignore
>> index 16877c3daabf..127d27188427 100644
>> --- a/tools/testing/selftests/kvm/.gitignore
>> +++ b/tools/testing/selftests/kvm/.gitignore
>> @@ -21,4 +21,5 @@
>> =C2=A0 /demand_paging_test
>> =C2=A0 /dirty_log_test
>> =C2=A0 /kvm_create_max_vcpus
>> +/mem_slot_test
>> =C2=A0 /steal_time
>> diff --git a/tools/testing/selftests/kvm/Makefile=20
>> b/tools/testing/selftests/kvm/Makefile
>> index 712a2ddd2a27..338b6cdce1a0 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -32,12 +32,14 @@ TEST_GEN_PROGS_x86_64 +=3D clear_dirty_log_test
>> =C2=A0 TEST_GEN_PROGS_x86_64 +=3D demand_paging_test
>> =C2=A0 TEST_GEN_PROGS_x86_64 +=3D dirty_log_test
>> =C2=A0 TEST_GEN_PROGS_x86_64 +=3D kvm_create_max_vcpus
>> +TEST_GEN_PROGS_x86_64 +=3D mem_slot_test
>> =C2=A0 TEST_GEN_PROGS_x86_64 +=3D steal_time
>> =C2=A0 =C2=A0 TEST_GEN_PROGS_aarch64 +=3D clear_dirty_log_test
>> =C2=A0 TEST_GEN_PROGS_aarch64 +=3D demand_paging_test
>> =C2=A0 TEST_GEN_PROGS_aarch64 +=3D dirty_log_test
>> =C2=A0 TEST_GEN_PROGS_aarch64 +=3D kvm_create_max_vcpus
>> +TEST_GEN_PROGS_aarch64 +=3D mem_slot_test
>> =C2=A0 TEST_GEN_PROGS_aarch64 +=3D steal_time
>> =C2=A0 =C2=A0 TEST_GEN_PROGS_s390x =3D s390x/memop
>> @@ -46,6 +48,7 @@ TEST_GEN_PROGS_s390x +=3D s390x/sync_regs_test
>> =C2=A0 TEST_GEN_PROGS_s390x +=3D demand_paging_test
>> =C2=A0 TEST_GEN_PROGS_s390x +=3D dirty_log_test
>> =C2=A0 TEST_GEN_PROGS_s390x +=3D kvm_create_max_vcpus
>> +TEST_GEN_PROGS_s390x +=3D mem_slot_test
>> =C2=A0 =C2=A0 TEST_GEN_PROGS +=3D $(TEST_GEN_PROGS_$(UNAME_M))
>> =C2=A0 LIBKVM +=3D $(LIBKVM_$(UNAME_M))
>> diff --git a/tools/testing/selftests/kvm/mem_slot_test.c=20
>> b/tools/testing/selftests/kvm/mem_slot_test.c
>> new file mode 100644
>> index 000000000000..7c1009f0bc07
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/mem_slot_test.c
>> @@ -0,0 +1,76 @@
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
>> + * Test it can be added memory slots up to KVM_CAP_NR_MEMSLOTS, then=20
>> any
>> + * tentative to add further slots should fail.
>> + */
>> +static void test_add_max_slots(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 struct kvm_vm *vm;
>> +=C2=A0=C2=A0=C2=A0 uint32_t max_mem_slots;
>> +=C2=A0=C2=A0=C2=A0 uint32_t slot;
>> +=C2=A0=C2=A0=C2=A0 uint64_t guest_addr;
>> +=C2=A0=C2=A0=C2=A0 uint64_t mem_reg_npages;
>> +=C2=A0=C2=A0=C2=A0 uint64_t mem_reg_size;
>> +=C2=A0=C2=A0=C2=A0 void *mem;
>> +
>> +=C2=A0=C2=A0=C2=A0 max_mem_slots =3D kvm_check_cap(KVM_CAP_NR_MEMSLOT=
S);
>> +=C2=A0=C2=A0=C2=A0 TEST_ASSERT(max_mem_slots > 0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "K=
VM_CAP_NR_MEMSLOTS should be greater than 0");
>> +=C2=A0=C2=A0=C2=A0 pr_info("Allowed number of memory slots: %i\n", ma=
x_mem_slots);
>> +
>> +=C2=A0=C2=A0=C2=A0 vm =3D vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Uses 1MB sized/aligned memory region since=
 this is the minimal
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * required on s390x.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 mem_reg_size =3D 0x100000;
>> +=C2=A0=C2=A0=C2=A0 mem_reg_npages =3D vm_calc_num_guest_pages(VM_MODE=
_DEFAULT,=20
>> mem_reg_size);
>> +
>> +=C2=A0=C2=A0=C2=A0 guest_addr =3D 0x0;
>
>
> Nit: Can't this be initialized where it's defined above ?


I don't have a strong preference. Is it generally initialized on=20
definition on kvm (selftests or not) code?


>
>
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Check it can be added memory slots up to the ma=
ximum allowed */
>> +=C2=A0=C2=A0=C2=A0 pr_info("Adding slots 0..%i, each memory region wi=
th %ldK size\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (max_mem_slots - 1), mem_r=
eg_size >> 10);
>> +=C2=A0=C2=A0=C2=A0 for (slot =3D 0; slot < max_mem_slots; slot++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm_userspace_mem_region_ad=
d(vm, VM_MEM_SRC_ANONYMOUS,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gue=
st_addr, slot, mem_reg_npages,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guest_addr +=3D mem_reg_si=
ze;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Check it cannot be added memory slots beyond th=
e limit */
>> +=C2=A0=C2=A0=C2=A0 mem =3D mmap(NULL, mem_reg_size, PROT_READ | PROT_=
WRITE,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAP_PRIV=
ATE | MAP_ANONYMOUS, -1, 0);
>> +=C2=A0=C2=A0=C2=A0 TEST_ASSERT(mem !=3D MAP_FAILED, "Failed to mmap()=
 host");
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D ioctl(vm_get_fd(vm), KVM_SET_USER_MEMORY_R=
EGION,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &(=
struct kvm_userspace_memory_region) {slot, 0, guest_addr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 me=
m_reg_size, (uint64_t) mem});
>> +=C2=A0=C2=A0=C2=A0 TEST_ASSERT(ret =3D=3D -1 && errno =3D=3D EINVAL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "A=
dding one more memory slot should fail with EINVAL");
>
>
> Why not add a test here for adding memory at an existing slot ?

Good question.

I'm working on another test which should check it cannot be added=20
overlapping slots. I will send it in a separate patch series, depending=20
on the fate of this one. :)

More precisely, those are the cases I will cover on this new test:


 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x100000=C2=A0 0x300000
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x200000 0x400000
 =C2=A0slot0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |---2MB--|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (SUCCESS)
 =C2=A0slot1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |---2MB--|=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (FAIL)
 =C2=A0slot2 |---2MB--|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (SUCCESS)
 =C2=A0slot3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |---2MB--|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (FAIL)
 =C2=A0slot4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |---2MB--|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (FAIL)
 =C2=A0slot5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |---2MB--|=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (SUCCESS)

Thanks!

Wainer

>
>
>> +
>> +=C2=A0=C2=A0=C2=A0 munmap(mem, mem_reg_size);
>> +=C2=A0=C2=A0=C2=A0 kvm_vm_free(vm);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +=C2=A0=C2=A0=C2=A0 test_add_max_slots();
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>

