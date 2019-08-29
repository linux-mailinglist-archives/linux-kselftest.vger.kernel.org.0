Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E230A1647
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfH2Kfs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Aug 2019 06:35:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726379AbfH2Kfr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Aug 2019 06:35:47 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7TAWhsh078486
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2019 06:35:46 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upbd63s83-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2019 06:35:46 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 29 Aug 2019 11:35:44 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 29 Aug 2019 11:35:41 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7TAZeQk41025990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 10:35:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38B6511C04C;
        Thu, 29 Aug 2019 10:35:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC7BA11C052;
        Thu, 29 Aug 2019 10:35:39 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.51])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Aug 2019 10:35:39 +0000 (GMT)
Subject: Re: [PATCH] KVM: selftests: Add a test for the KVM_S390_MEM_OP ioctl
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20190829102050.26703-1-thuth@redhat.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Thu, 29 Aug 2019 12:35:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829102050.26703-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19082910-0028-0000-0000-000003953752
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082910-0029-0000-0000-00002457772F
Message-Id: <5b624c57-f4ee-323c-79db-97b6dd898702@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290116
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 29.08.19 12:20, Thomas Huth wrote:
> Check that we can write and read the guest memory with this s390x
> ioctl, and that some error cases are handled correctly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  This test uses the ucall() interface, so this patch needs to be applied
>  on top of my "Implement ucall() for s390x" patch (which is not merged to
>  master yet)

Looks good and tested. Will apply to kvms390/next after some more testing.
> 
>  tools/testing/selftests/kvm/Makefile      |   1 +
>  tools/testing/selftests/kvm/s390x/memop.c | 155 ++++++++++++++++++++++
>  2 files changed, 156 insertions(+)
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
> index 000000000000..25b100d9fdda
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -0,0 +1,155 @@
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

