Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0D9A345D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 11:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfH3JpJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 05:45:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfH3JpJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 05:45:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C72385545;
        Fri, 30 Aug 2019 09:45:08 +0000 (UTC)
Received: from [10.36.117.243] (ovpn-117-243.ams2.redhat.com [10.36.117.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 554E660872;
        Fri, 30 Aug 2019 09:45:05 +0000 (UTC)
Subject: Re: [PATCH v2] KVM: selftests: Add a test for the KVM_S390_MEM_OP
 ioctl
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20190829121412.30194-1-thuth@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <c015592c-34f9-b940-b10d-56e4b201c7ae@redhat.com>
Date:   Fri, 30 Aug 2019 11:45:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829121412.30194-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 30 Aug 2019 09:45:08 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 29.08.19 14:14, Thomas Huth wrote:
> Check that we can write and read the guest memory with this s390x
> ioctl, and that some error cases are handled correctly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Check the ioctl also with "size" set to 0
> 
>  tools/testing/selftests/kvm/Makefile      |   1 +
>  tools/testing/selftests/kvm/s390x/memop.c | 165 ++++++++++++++++++++++
>  2 files changed, 166 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390x/memop.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 1b48a94b4350..62c591f87dab 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -32,6 +32,7 @@ TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
>  TEST_GEN_PROGS_aarch64 += dirty_log_test
>  TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
>  
> +TEST_GEN_PROGS_s390x = s390x/memop
>  TEST_GEN_PROGS_s390x += s390x/sync_regs_test
>  TEST_GEN_PROGS_s390x += dirty_log_test
>  TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> new file mode 100644
> index 000000000000..e6a65f9e48ca
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Test for s390x KVM_S390_MEM_OP
> + *
> + * Copyright (C) 2019, Red Hat, Inc.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +
> +#define VCPU_ID 1
> +
> +static uint8_t mem1[65536];
> +static uint8_t mem2[65536];
> +
> +static void guest_code(void)
> +{
> +	int i;
> +
> +	for (;;) {
> +		for (i = 0; i < sizeof(mem2); i++)
> +			mem2[i] = mem1[i];
> +		GUEST_SYNC(0);
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_run *run;
> +	struct kvm_s390_mem_op ksmo;
> +	int rv, i, maxsize;
> +
> +	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
> +
> +	maxsize = kvm_check_cap(KVM_CAP_S390_MEM_OP);
> +	if (!maxsize) {
> +		fprintf(stderr, "CAP_S390_MEM_OP not supported -> skip test\n");
> +		exit(KSFT_SKIP);
> +	}
> +	if (maxsize > sizeof(mem1))
> +		maxsize = sizeof(mem1);
> +
> +	/* Create VM */
> +	vm = vm_create_default(VCPU_ID, 0, guest_code);
> +	run = vcpu_state(vm, VCPU_ID);
> +
> +	for (i = 0; i < sizeof(mem1); i++)
> +		mem1[i] = i * i + i;
> +
> +	/* Set the first array */
> +	ksmo.gaddr = addr_gva2gpa(vm, (uintptr_t)mem1);
> +	ksmo.flags = 0;
> +	ksmo.size = maxsize;
> +	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
> +	ksmo.buf = (uintptr_t)mem1;
> +	ksmo.ar = 0;
> +	vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +
> +	/* Let the guest code copy the first array to the second */
> +	vcpu_run(vm, VCPU_ID);
> +	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
> +		    "Unexpected exit reason: %u (%s)\n",
> +		    run->exit_reason,
> +		    exit_reason_str(run->exit_reason));
> +
> +	memset(mem2, 0xaa, sizeof(mem2));
> +
> +	/* Get the second array */
> +	ksmo.gaddr = (uintptr_t)mem2;
> +	ksmo.flags = 0;
> +	ksmo.size = maxsize;
> +	ksmo.op = KVM_S390_MEMOP_LOGICAL_READ;
> +	ksmo.buf = (uintptr_t)mem2;
> +	ksmo.ar = 0;
> +	vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +
> +	TEST_ASSERT(!memcmp(mem1, mem2, maxsize),
> +		    "Memory contents do not match!");
> +
> +	/* Check error conditions - first bad size: */
> +	ksmo.gaddr = (uintptr_t)mem1;
> +	ksmo.flags = 0;
> +	ksmo.size = -1;
> +	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
> +	ksmo.buf = (uintptr_t)mem1;
> +	ksmo.ar = 0;
> +	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv == -1 && errno == E2BIG, "ioctl allows insane sizes");
> +
> +	/* Zero size: */
> +	ksmo.gaddr = (uintptr_t)mem1;
> +	ksmo.flags = 0;
> +	ksmo.size = 0;
> +	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
> +	ksmo.buf = (uintptr_t)mem1;
> +	ksmo.ar = 0;
> +	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv == -1, "ioctl allows 0 as size");
> +
> +	/* Bad flags: */
> +	ksmo.gaddr = (uintptr_t)mem1;
> +	ksmo.flags = -1;
> +	ksmo.size = maxsize;
> +	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
> +	ksmo.buf = (uintptr_t)mem1;
> +	ksmo.ar = 0;
> +	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows all flags?");
> +
> +	/* Bad operation: */
> +	ksmo.gaddr = (uintptr_t)mem1;
> +	ksmo.flags = 0;
> +	ksmo.size = maxsize;
> +	ksmo.op = -1;
> +	ksmo.buf = (uintptr_t)mem1;
> +	ksmo.ar = 0;
> +	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows all flags?");
> +
> +	/* Bad guest address: */
> +	ksmo.gaddr = ~0xfffUL;
> +	ksmo.flags = KVM_S390_MEMOP_F_CHECK_ONLY;
> +	ksmo.size = maxsize;
> +	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
> +	ksmo.buf = (uintptr_t)mem1;
> +	ksmo.ar = 0;
> +	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory access");
> +
> +	/* Bad host address: */
> +	ksmo.gaddr = (uintptr_t)mem1;
> +	ksmo.flags = 0;
> +	ksmo.size = maxsize;
> +	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
> +	ksmo.buf = 0;
> +	ksmo.ar = 0;
> +	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv == -1 && errno == EFAULT,
> +		    "ioctl does not report bad host memory address");
> +
> +	/* Bad access register: */
> +	run->psw_mask &= ~(3UL << (63 - 17));
> +	run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
> +	vcpu_run(vm, VCPU_ID);              /* To sync new state to SIE block */
> +	ksmo.gaddr = (uintptr_t)mem1;
> +	ksmo.flags = 0;
> +	ksmo.size = maxsize;
> +	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
> +	ksmo.buf = (uintptr_t)mem1;
> +	ksmo.ar = 17;
> +	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows ARs > 15");
> +	run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
> +	vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
> +
> +	kvm_vm_free(vm);
> +
> +	return 0;
> +}
> 

Had a quick glimpse and besides the two things Janosch mentioned,
nothing jumped at me.

-- 

Thanks,

David / dhildenb
