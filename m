Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF406C6B39
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 15:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCWOiw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 10:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjCWOiu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 10:38:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE585F761;
        Thu, 23 Mar 2023 07:38:46 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NENjG9021773;
        Thu, 23 Mar 2023 14:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dckj90EQwZPTxzA+muHcM3u+e9GkaRmp0TBCXNoP7FU=;
 b=lIXXBSypv7RYcGzwXmVZkUhqidCERIFMzFeJX0jHAxmzsP8YMCtB84RhJTzf7dhekUK2
 9sCewgb7lXzgKNiNmvQB82CTzGdzujUiVfm96LLCdDcXNIBfRzkwtCPfo1U1IPc1MZZ7
 8Oo/vKaDmSqrhAg4Xc4P14g5sLzOZYIet048doACP4CD4WaNaQwf/XnV4+JELKNU+mf/
 Tgn2b7Oya7pVBGOMN4aE3hpDkPMV+fUSEHxSNiO5jRnCH2MYd578Gffxte/ZcBT3QP6i
 3CEwcjAHgTVuskONHYFnTBSsJ8harWxP4on+X9JwqD9JR9aR+FHwBpU4oOg5ZO2lM+rd rQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgj6wjs8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 14:38:41 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32NCBPuI018062;
        Thu, 23 Mar 2023 14:38:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3pd4jfeaa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 14:38:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NEcaPE30147138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 14:38:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3DD02004B;
        Thu, 23 Mar 2023 14:38:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6964820040;
        Thu, 23 Mar 2023 14:38:35 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.56])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Mar 2023 14:38:35 +0000 (GMT)
Date:   Thu, 23 Mar 2023 15:36:44 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     borntraeger@linux.ibm.com, frankja@linux.ibm.com, shuah@kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 1/2] KVM: s390: selftests: add selftest for CMMA
 migration
Message-ID: <20230323153644.0ece796f@p-imbrenda>
In-Reply-To: <20230208144827.131300-3-nrb@linux.ibm.com>
References: <20230208144827.131300-1-nrb@linux.ibm.com>
        <20230208144827.131300-3-nrb@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UaL9B8w5XgjAAct0CP3XUNLpJuieWeTC
X-Proofpoint-ORIG-GUID: UaL9B8w5XgjAAct0CP3XUNLpJuieWeTC
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230109
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed,  8 Feb 2023 15:48:27 +0100
Nico Boehr <nrb@linux.ibm.com> wrote:

> Add a selftest for CMMA migration on s390.
> 
> The tests cover:
> - interaction of dirty tracking and migration mode, see my recent patch
>   "KVM: s390: disable migration mode when dirty tracking is disabled" [1],
> - several invalid calls of KVM_S390_GET_CMMA_BITS, for example: invalid
>   flags, CMMA support off, with/without peeking
> - ensure KVM_S390_GET_CMMA_BITS initally reports all pages as dirty,
> - ensure KVM_S390_GET_CMMA_BITS properly skips over holes in memslots, but
>   also non-dirty pages
> 
> Note that without the patch at [1] and the small fix in this series, the
> selftests will fail.
> 
> [1] https://lore.kernel.org/all/20230127140532.230651-2-nrb@linux.ibm.com/
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  tools/testing/selftests/kvm/s390x/cmma_test.c | 679 ++++++++++++++++++
>  2 files changed, 680 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390x/cmma_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 1750f91dd936..fc9223b04d5f 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -160,6 +160,7 @@ TEST_GEN_PROGS_s390x = s390x/memop
>  TEST_GEN_PROGS_s390x += s390x/resets
>  TEST_GEN_PROGS_s390x += s390x/sync_regs_test
>  TEST_GEN_PROGS_s390x += s390x/tprot
> +TEST_GEN_PROGS_s390x += s390x/cmma_test
>  TEST_GEN_PROGS_s390x += demand_paging_test
>  TEST_GEN_PROGS_s390x += dirty_log_test
>  TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
> diff --git a/tools/testing/selftests/kvm/s390x/cmma_test.c b/tools/testing/selftests/kvm/s390x/cmma_test.c
> new file mode 100644
> index 000000000000..76751abf2331
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/s390x/cmma_test.c
> @@ -0,0 +1,679 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test for s390x CMMA migration
> + *
> + * Copyright IBM Corp. 2023
> + *
> + * Authors:
> + *  Nico Boehr <nrb@linux.ibm.com>
> + */
> +
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "kselftest.h"
> +
> +#define MAIN_PAGE_COUNT 512
> +
> +#define TEST_DATA_PAGE_COUNT 512
> +#define TEST_DATA_MEMSLOT 1
> +#define TEST_DATA_START_GFN 4096
> +
> +#define TEST_DATA_TWO_PAGE_COUNT 256
> +#define TEST_DATA_TWO_MEMSLOT 2
> +#define TEST_DATA_TWO_START_GFN 8192
> +
> +static char cmma_value_buf[MAIN_PAGE_COUNT + TEST_DATA_PAGE_COUNT];
> +
> +/**
> + * Dirty CMMA attributes of exactly one page in the TEST_DATA memslot,
> + * so use_cmma goes on and the CMMA related ioctls do something.
> + */
> +static void guest_do_one_essa(void)
> +{
> +	asm volatile(
> +		/* load TEST_DATA_START_GFN into r1 */
> +		"	llilf 1,%[start_gfn]\n"
> +		/* calculate the address from the gfn */
> +		"	sllg 1,1,12(0)\n"
> +		/* set the first page in TEST_DATA memslot to STABLE */
> +		"	.insn rrf,0xb9ab0000,2,1,1,0\n"
> +		/* hypercall */
> +		"	diag 0,0,0x501\n"
> +		"0:	j 0b"
> +		:
> +		: [start_gfn] "L"(TEST_DATA_START_GFN)
> +		: "r1", "r2", "memory", "cc"
> +	);
> +}
> +
> +/**
> + * Touch CMMA attributes of all pages in TEST_DATA memslot. Set them to stable
> + * state.
> + */
> +static void guest_dirty_test_data(void)
> +{
> +	asm volatile(
> +		/* r1 = TEST_DATA_START_GFN */
> +		"	xgr 1,1\n"
> +		"	llilf 1,%[start_gfn]\n"
> +		/* r5 = TEST_DATA_PAGE_COUNT */
> +		"	lghi 5,%[page_count]\n"
> +		/* r5 += r1 */
> +		"2:	agfr 5,1\n"
> +		/* r2 = r1 << 12 */
> +		"1:	sllg 2,1,12(0)\n"
> +		/* essa(r4, r2, SET_STABLE) */
> +		"	.insn rrf,0xb9ab0000,4,2,1,0\n"
> +		/* i++ */
> +		"	agfi 1,1\n"
> +		/* if r1 < r5 goto 1 */
> +		"	cgrjl 1,5,1b\n"
> +		/* hypercall */
> +		"	diag 0,0,0x501\n"
> +		"0:	j 0b"
> +		:
> +		: [start_gfn] "L"(TEST_DATA_START_GFN),
> +		  [page_count] "L"(TEST_DATA_PAGE_COUNT)
> +		:
> +			/* the counter in our loop over the pages */
> +			"r1",
> +			/* the calculated page physical address */
> +			"r2",
> +			/* ESSA output register */
> +			"r4",
> +			/* last page */
> +			"r5",
> +			"cc", "memory"
> +	);
> +}
> +
> +static struct kvm_vm *create_vm(void)
> +{
> +	return ____vm_create(VM_MODE_DEFAULT);
> +}
> +
> +static void create_main_memslot(struct kvm_vm *vm)
> +{
> +	int i;
> +
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, MAIN_PAGE_COUNT, 0);
> +	for (i = 0; i < NR_MEM_REGIONS; i++)
> +		vm->memslots[i] = 0;

can you explain why you are zeroing all memslots?

> +}
> +
> +static void create_test_memslot(struct kvm_vm *vm)
> +{
> +	vm_userspace_mem_region_add(vm,
> +				    VM_MEM_SRC_ANONYMOUS,
> +				    TEST_DATA_START_GFN << vm->page_shift,
> +				    TEST_DATA_MEMSLOT,
> +				    TEST_DATA_PAGE_COUNT,
> +				    0
> +				   );
> +	vm->memslots[MEM_REGION_TEST_DATA] = TEST_DATA_MEMSLOT;
> +}
> +
> +static void create_memslots(struct kvm_vm *vm)
> +{
> +	/*
> +	 * Our VM has the following memory layout:
> +	 * +------+---------------------------+
> +	 * | GFN  | Memslot                   |
> +	 * +------+---------------------------+
> +	 * | 0    |                           |
> +	 * | ...  | MAIN (Code, Stack, ...)   |
> +	 * | 511  |                           |
> +	 * +------+---------------------------+
> +	 * | 4096 |                           |
> +	 * | ...  | TEST_DATA                 |
> +	 * | 4607 |                           |
> +	 * +------+---------------------------+
> +	 */
> +	create_main_memslot(vm);
> +	create_test_memslot(vm);
> +}
> +
> +static void finish_vm_setup(struct kvm_vm *vm)
> +{
> +	struct userspace_mem_region *slot0;
> +
> +	kvm_vm_elf_load(vm, program_invocation_name);
> +
> +	slot0 = memslot2region(vm, 0);
> +	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_size);
> +
> +	kvm_arch_vm_post_create(vm);
> +}
> +
> +static struct kvm_vm *create_vm_two_memslots(void)
> +{
> +	struct kvm_vm *vm;
> +
> +	vm = create_vm();
> +
> +	create_memslots(vm);
> +
> +	finish_vm_setup(vm);
> +
> +	return vm;
> +}
> +
> +static void enable_cmma(struct kvm_vm *vm)
> +{
> +	int r;
> +
> +	r = __kvm_device_attr_set(vm->fd, KVM_S390_VM_MEM_CTRL, KVM_S390_VM_MEM_ENABLE_CMMA, NULL);
> +	TEST_ASSERT(!r, "enabling cmma failed r=%d errno=%d", r, errno);
> +}
> +
> +static void enable_dirty_tracking(struct kvm_vm *vm)
> +{
> +	vm_mem_region_set_flags(vm, 0, KVM_MEM_LOG_DIRTY_PAGES);
> +	vm_mem_region_set_flags(vm, TEST_DATA_MEMSLOT, KVM_MEM_LOG_DIRTY_PAGES);
> +}
> +
> +static int __enable_migration_mode(struct kvm_vm *vm)
> +{
> +	return __kvm_device_attr_set(vm->fd,
> +				     KVM_S390_VM_MIGRATION,
> +				     KVM_S390_VM_MIGRATION_START,
> +				     NULL
> +				    );
> +}
> +
> +static void enable_migration_mode(struct kvm_vm *vm)
> +{
> +	int r = __enable_migration_mode(vm);
> +
> +	TEST_ASSERT(!r, "enabling migration mode failed r=%d errno=%d", r, errno);
> +}
> +
> +static bool is_migration_mode_on(struct kvm_vm *vm)
> +{
> +	u64 out;
> +	int r;
> +
> +	r = __kvm_device_attr_get(vm->fd,
> +				  KVM_S390_VM_MIGRATION,
> +				  KVM_S390_VM_MIGRATION_STATUS,
> +				  &out
> +				 );
> +	TEST_ASSERT(!r, "getting migration mode status failed r=%d errno=%d", r, errno);
> +	return out;
> +}
> +
> +static int vm_get_cmma_bits(struct kvm_vm *vm, u64 flags, int *errno_out)
> +{
> +	struct kvm_s390_cmma_log args;
> +	int rc;
> +
> +	errno = 0;
> +
> +	args = (struct kvm_s390_cmma_log){
> +		.start_gfn = 0,
> +		.count = sizeof(cmma_value_buf),
> +		.flags = flags,
> +		.values = (__u64)&cmma_value_buf[0]
> +	};
> +	rc = __vm_ioctl(vm, KVM_S390_GET_CMMA_BITS, &args);
> +
> +	*errno_out = errno;
> +	return rc;
> +}
> +
> +static void test_get_cmma_basic(void)
> +{
> +	struct kvm_vm *vm = create_vm_two_memslots();
> +	struct kvm_vcpu *vcpu;
> +	int rc, errno_out;
> +
> +	/* GET_CMMA_BITS without CMMA enabled should fail */
> +	rc = vm_get_cmma_bits(vm, 0, &errno_out);
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_out, ENXIO);
> +
> +	enable_cmma(vm);
> +	vcpu = vm_vcpu_add(vm, 1, guest_do_one_essa);
> +
> +	vcpu_run(vcpu);
> +
> +	/* GET_CMMA_BITS without migration mode and without peeking should fail */
> +	rc = vm_get_cmma_bits(vm, 0, &errno_out);
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_out, EINVAL);
> +
> +	/* GET_CMMA_BITS without migration mode and with peeking should work */
> +	rc = vm_get_cmma_bits(vm, KVM_S390_CMMA_PEEK, &errno_out);
> +	ASSERT_EQ(rc, 0);
> +	ASSERT_EQ(errno_out, 0);
> +
> +	enable_dirty_tracking(vm);
> +	enable_migration_mode(vm);
> +
> +	/* GET_CMMA_BITS with invalid flags */
> +	rc = vm_get_cmma_bits(vm, 0xfeedc0fe, &errno_out);
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno_out, EINVAL);
> +
> +	kvm_vm_free(vm);
> +}
> +
> +static void assert_exit_was_hypercall(struct kvm_vcpu *vcpu)
> +{
> +	ASSERT_EQ(vcpu->run->exit_reason, 13);
> +	ASSERT_EQ(vcpu->run->s390_sieic.icptcode, 4);
> +	ASSERT_EQ(vcpu->run->s390_sieic.ipa, 0x8300);
> +	ASSERT_EQ(vcpu->run->s390_sieic.ipb, 0x5010000);
> +}
> +
> +static void test_migration_mode(void)
> +{
> +	struct kvm_vm *vm = create_vm();
> +	struct kvm_vcpu *vcpu;
> +	u64 orig_psw;
> +	int rc;
> +
> +	/* enabling migration mode on a VM without memory should fail */
> +	rc = __enable_migration_mode(vm);
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +	TEST_ASSERT(!is_migration_mode_on(vm), "migration mode should still be off");
> +	errno = 0;
> +
> +	create_memslots(vm);
> +	finish_vm_setup(vm);
> +
> +	enable_cmma(vm);
> +	vcpu = vm_vcpu_add(vm, 1, guest_do_one_essa);
> +	orig_psw = vcpu->run->psw_addr;
> +
> +	/*
> +	 * Execute one essa instruction in the guest. Otherwise the guest will
> +	 * not have use_cmm enabled and GET_CMMA_BITS will return no pages.
> +	 */
> +	vcpu_run(vcpu);
> +	assert_exit_was_hypercall(vcpu);
> +
> +	/* migration mode when memslots have dirty tracking off should fail */
> +	rc = __enable_migration_mode(vm);
> +	ASSERT_EQ(rc, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +	TEST_ASSERT(!is_migration_mode_on(vm), "migration mode should still be off");
> +	errno = 0;
> +
> +	/* enable dirty tracking */
> +	enable_dirty_tracking(vm);
> +
> +	/* enabling migration mode should work now */
> +	rc = __enable_migration_mode(vm);
> +	ASSERT_EQ(rc, 0);
> +	TEST_ASSERT(is_migration_mode_on(vm), "migration mode should be on");
> +	errno = 0;
> +
> +	/* execute another ESSA instruction to see this goes fine */
> +	vcpu->run->psw_addr = orig_psw;
> +	vcpu_run(vcpu);
> +	assert_exit_was_hypercall(vcpu);
> +
> +	/*
> +	 * With migration mode on, create a new memslot with dirty tracking off.
> +	 * This should turn off migration mode.
> +	 */
> +	TEST_ASSERT(is_migration_mode_on(vm), "migration mode should be on");
> +	vm_userspace_mem_region_add(vm,
> +				    VM_MEM_SRC_ANONYMOUS,
> +				    TEST_DATA_TWO_START_GFN << vm->page_shift,
> +				    TEST_DATA_TWO_MEMSLOT,
> +				    TEST_DATA_TWO_PAGE_COUNT,
> +				    0
> +				   );
> +	TEST_ASSERT(!is_migration_mode_on(vm),
> +		    "creating memslot without dirty tracking turns off migration mode"
> +		   );
> +
> +	/* ESSA instructions should still execute fine */
> +	vcpu->run->psw_addr = orig_psw;
> +	vcpu_run(vcpu);
> +	assert_exit_was_hypercall(vcpu);
> +
> +	/*
> +	 * Turn on dirty tracking on the new memslot.
> +	 * It should be possible to turn migration mode back on again.
> +	 */
> +	vm_mem_region_set_flags(vm, TEST_DATA_TWO_MEMSLOT, KVM_MEM_LOG_DIRTY_PAGES);
> +	rc = __enable_migration_mode(vm);
> +	ASSERT_EQ(rc, 0);
> +	TEST_ASSERT(is_migration_mode_on(vm), "migration mode should be on");
> +	errno = 0;
> +
> +	/*
> +	 * Turn off dirty tracking again, this time with just a flag change.
> +	 * Again, migration mode should turn off.
> +	 */
> +	TEST_ASSERT(is_migration_mode_on(vm), "migration mode should be on");
> +	vm_mem_region_set_flags(vm, TEST_DATA_TWO_MEMSLOT, 0);
> +	TEST_ASSERT(!is_migration_mode_on(vm),
> +		    "disabling dirty tracking should turn off migration mode"
> +		   );
> +
> +	/* ESSA instructions should still execute fine */
> +	vcpu->run->psw_addr = orig_psw;
> +	vcpu_run(vcpu);
> +	assert_exit_was_hypercall(vcpu);
> +
> +	kvm_vm_free(vm);
> +}
> +
> +/**
> + * Given a VM with the MAIN and TEST_DATA memslot, assert that both slots have
> + * CMMA attributes of all pages in both memslots and nothing more dirty.
> + * This has the useful side effect of ensuring nothing is CMMA dirty after this
> + * function.
> + */
> +static void assert_all_slots_cmma_dirty(struct kvm_vm *vm)
> +{
> +	struct kvm_s390_cmma_log args;
> +
> +	/*
> +	 * First iteration - everything should be dirty.
> +	 * Start at the main memslot...
> +	 */
> +	args = (struct kvm_s390_cmma_log){
> +		.start_gfn = 0,
> +		.count = sizeof(cmma_value_buf),
> +		.flags = 0,
> +		.values = (__u64)&cmma_value_buf[0]
> +	};
> +	memset(cmma_value_buf, 0xff, sizeof(cmma_value_buf));
> +	vm_ioctl(vm, KVM_S390_GET_CMMA_BITS, &args);
> +	ASSERT_EQ(args.count, MAIN_PAGE_COUNT);
> +	ASSERT_EQ(args.remaining, TEST_DATA_PAGE_COUNT);
> +	ASSERT_EQ(args.start_gfn, 0);
> +
> +	/* ...and then - after a hole - the TEST_DATA memslot should follow */
> +	args = (struct kvm_s390_cmma_log){
> +		.start_gfn = MAIN_PAGE_COUNT,
> +		.count = sizeof(cmma_value_buf),
> +		.flags = 0,
> +		.values = (__u64)&cmma_value_buf[0]
> +	};
> +	memset(cmma_value_buf, 0xff, sizeof(cmma_value_buf));
> +	vm_ioctl(vm, KVM_S390_GET_CMMA_BITS, &args);
> +	ASSERT_EQ(args.count, TEST_DATA_PAGE_COUNT);
> +	ASSERT_EQ(args.start_gfn, TEST_DATA_START_GFN);
> +	ASSERT_EQ(args.remaining, 0);
> +
> +	/* ...and nothing else should be there */
> +	args = (struct kvm_s390_cmma_log){
> +		.start_gfn = TEST_DATA_START_GFN + TEST_DATA_PAGE_COUNT,
> +		.count = sizeof(cmma_value_buf),
> +		.flags = 0,
> +		.values = (__u64)&cmma_value_buf[0]
> +	};
> +	memset(cmma_value_buf, 0xff, sizeof(cmma_value_buf));
> +	vm_ioctl(vm, KVM_S390_GET_CMMA_BITS, &args);
> +	ASSERT_EQ(args.count, 0);
> +	ASSERT_EQ(args.start_gfn, 0);
> +	ASSERT_EQ(args.remaining, 0);
> +}
> +
> +/**
> + * Given a VM, assert no pages are CMMA dirty.
> + */
> +static void assert_no_pages_cmma_dirty(struct kvm_vm *vm)
> +{
> +	struct kvm_s390_cmma_log args;
> +
> +	/* If we start from GFN 0 again, nothing should be dirty. */
> +	args = (struct kvm_s390_cmma_log){
> +		.start_gfn = 0,
> +		.count = sizeof(cmma_value_buf),
> +		.flags = 0,
> +		.values = (__u64)&cmma_value_buf[0]
> +	};
> +	memset(cmma_value_buf, 0xff, sizeof(cmma_value_buf));
> +	vm_ioctl(vm, KVM_S390_GET_CMMA_BITS, &args);
> +	if (args.count || args.remaining || args.start_gfn)
> +		TEST_FAIL("pages are still dirty start_gfn=0x%llx count=%u remaining=%llu",
> +			  args.start_gfn,
> +			  args.count,
> +			  args.remaining
> +			 );
> +}
> +
> +static void test_get_inital_dirty(void)
> +{
> +	struct kvm_vm *vm = create_vm_two_memslots();
> +	struct kvm_vcpu *vcpu;
> +
> +	enable_cmma(vm);
> +	vcpu = vm_vcpu_add(vm, 1, guest_do_one_essa);
> +
> +	/*
> +	 * Execute one essa instruction in the guest. Otherwise the guest will
> +	 * not have use_cmm enabled and GET_CMMA_BITS will return no pages.
> +	 */
> +	vcpu_run(vcpu);
> +	assert_exit_was_hypercall(vcpu);
> +
> +	enable_dirty_tracking(vm);
> +	enable_migration_mode(vm);
> +
> +	assert_all_slots_cmma_dirty(vm);
> +
> +	/* Start from the beginning again and make sure nothing else is dirty */
> +	assert_no_pages_cmma_dirty(vm);
> +
> +	kvm_vm_free(vm);
> +}
> +
> +static void query_cmma_range(struct kvm_vm *vm,
> +			     u64 start_gfn, u64 gfn_count,
> +			     struct kvm_s390_cmma_log *res_out)
> +{
> +	*res_out = (struct kvm_s390_cmma_log){
> +		.start_gfn = start_gfn,
> +		.count = gfn_count,
> +		.flags = 0,
> +		.values = (__u64)&cmma_value_buf[0]
> +	};
> +	memset(cmma_value_buf, 0xff, sizeof(cmma_value_buf));
> +	vm_ioctl(vm, KVM_S390_GET_CMMA_BITS, res_out);
> +}
> +
> +/**
> + * Assert the given cmma_log struct that was executed by query_cmma_range()
> + * indicates the first dirty gfn is at first_dirty_gfn and contains exactly
> + * dirty_gfn_count CMMA values.
> + */
> +static void assert_cmma_dirty(u64 first_dirty_gfn,
> +			      u64 dirty_gfn_count,
> +			      const struct kvm_s390_cmma_log *res)
> +{
> +	ASSERT_EQ(res->start_gfn, first_dirty_gfn);
> +	ASSERT_EQ(res->count, dirty_gfn_count);
> +	for (size_t i = 0; i < dirty_gfn_count; i++)
> +		ASSERT_EQ(cmma_value_buf[0], 0x0); /* stable state */
> +	ASSERT_EQ(cmma_value_buf[dirty_gfn_count], 0xff); /* not touched */
> +}
> +
> +static void test_get_skip_holes(void)
> +{
> +	size_t gfn_offset;
> +	struct kvm_vm *vm = create_vm_two_memslots();
> +	struct kvm_s390_cmma_log log;
> +	struct kvm_vcpu *vcpu;
> +	u64 orig_psw;
> +
> +	enable_cmma(vm);
> +	vcpu = vm_vcpu_add(vm, 1, guest_dirty_test_data);
> +
> +	orig_psw = vcpu->run->psw_addr;
> +
> +	/*
> +	 * Execute some essa instructions in the guest. Otherwise the guest will
> +	 * not have use_cmm enabled and GET_CMMA_BITS will return no pages.
> +	 */
> +	vcpu_run(vcpu);
> +	assert_exit_was_hypercall(vcpu);
> +
> +	enable_dirty_tracking(vm);
> +	enable_migration_mode(vm);
> +
> +	/* un-dirty all pages */
> +	assert_all_slots_cmma_dirty(vm);
> +
> +	/* Then, dirty just the TEST_DATA memslot */
> +	vcpu->run->psw_addr = orig_psw;
> +	vcpu_run(vcpu);
> +
> +	gfn_offset = TEST_DATA_START_GFN;
> +	/**
> +	 * Query CMMA attributes of one page, starting at page 0. Since the
> +	 * main memslot was not touched by the VM, this should yield the first
> +	 * page of the TEST_DATA memslot.
> +	 * The dirty bitmap should now look like this:
> +	 * 0: not dirty
> +	 * [0x1, 0x200): dirty
> +	 */
> +	query_cmma_range(vm, 0, 1, &log);
> +	assert_cmma_dirty(gfn_offset, 1, &log);
> +	gfn_offset++;
> +
> +	/**
> +	 * Query CMMA attributes of 32 (0x20) pages past the end of the TEST_DATA
> +	 * memslot. This should wrap back to the beginning of the TEST_DATA
> +	 * memslot, page 1.
> +	 * The dirty bitmap should now look like this:
> +	 * [0, 0x21): not dirty
> +	 * [0x21, 0x200): dirty
> +	 */
> +	query_cmma_range(vm, TEST_DATA_START_GFN + TEST_DATA_PAGE_COUNT, 0x20, &log);
> +	assert_cmma_dirty(gfn_offset, 0x20, &log);
> +	gfn_offset += 0x20;
> +
> +	/* Skip 32 pages */
> +	gfn_offset += 0x20;
> +
> +	/**
> +	 * After skipping 32 pages, query the next 32 (0x20) pages.
> +	 * The dirty bitmap should now look like this:
> +	 * [0, 0x21): not dirty
> +	 * [0x21, 0x41): dirty
> +	 * [0x41, 0x61): not dirty
> +	 * [0x61, 0x200): dirty
> +	 */
> +	query_cmma_range(vm, gfn_offset, 0x20, &log);
> +	assert_cmma_dirty(gfn_offset, 0x20, &log);
> +	gfn_offset += 0x20;
> +
> +	/**
> +	 * Query 1 page from the beginning of the TEST_DATA memslot. This should
> +	 * yield page 0x21.
> +	 * The dirty bitmap should now look like this:
> +	 * [0, 0x22): not dirty
> +	 * [0x22, 0x41): dirty
> +	 * [0x41, 0x61): not dirty
> +	 * [0x61, 0x200): dirty
> +	 */
> +	query_cmma_range(vm, TEST_DATA_START_GFN, 1, &log);
> +	assert_cmma_dirty(TEST_DATA_START_GFN + 0x21, 1, &log);
> +	gfn_offset++;
> +
> +	/**
> +	 * Query 15 (0xF) pages from page 0x23 in TEST_DATA memslot.
> +	 * This should yield pages [0x23, 0x33).
> +	 * The dirty bitmap should now look like this:
> +	 * [0, 0x22): not dirty
> +	 * 0x22: dirty
> +	 * [0x23, 0x33): not dirty
> +	 * [0x33, 0x41): dirty
> +	 * [0x41, 0x61): not dirty
> +	 * [0x61, 0x200): dirty
> +	 */
> +	gfn_offset = TEST_DATA_START_GFN + 0x23;
> +	query_cmma_range(vm, gfn_offset, 15, &log);
> +	assert_cmma_dirty(gfn_offset, 15, &log);
> +
> +	/**
> +	 * Query 17 (0x11) pages from page 0x22 in TEST_DATA memslot.
> +	 * This should yield page [0x22, 0x33)
> +	 * The dirty bitmap should now look like this:
> +	 * [0, 0x33): not dirty
> +	 * [0x33, 0x41): dirty
> +	 * [0x41, 0x61): not dirty
> +	 * [0x61, 0x200): dirty
> +	 */
> +	gfn_offset = TEST_DATA_START_GFN + 0x22;
> +	query_cmma_range(vm, gfn_offset, 17, &log);
> +	assert_cmma_dirty(gfn_offset, 17, &log);
> +
> +	/**
> +	 * Query 25 (0x19) pages from page 0x40 in TEST_DATA memslot.
> +	 * This should yield page 0x40 and nothing more, since there are more
> +	 * than 16 non-dirty pages after page 0x40.
> +	 * The dirty bitmap should now look like this:
> +	 * [0, 0x33): not dirty
> +	 * [0x33, 0x40): dirty
> +	 * [0x40, 0x61): not dirty
> +	 * [0x61, 0x200): dirty
> +	 */
> +	gfn_offset = TEST_DATA_START_GFN + 0x40;
> +	query_cmma_range(vm, gfn_offset, 25, &log);
> +	assert_cmma_dirty(gfn_offset, 1, &log);
> +
> +	/**
> +	 * Query pages [0x33, 0x40).
> +	 * The dirty bitmap should now look like this:
> +	 * [0, 0x61): not dirty
> +	 * [0x61, 0x200): dirty
> +	 */
> +	gfn_offset = TEST_DATA_START_GFN + 0x33;
> +	query_cmma_range(vm, gfn_offset, 0x40 - 0x33, &log);
> +	assert_cmma_dirty(gfn_offset, 0x40 - 0x33, &log);
> +
> +	/**
> +	 * Query the remaining pages [0x61, 0x200).
> +	 */
> +	gfn_offset = TEST_DATA_START_GFN;
> +	query_cmma_range(vm, gfn_offset, TEST_DATA_PAGE_COUNT - 0x61, &log);
> +	assert_cmma_dirty(TEST_DATA_START_GFN + 0x61, TEST_DATA_PAGE_COUNT - 0x61, &log);
> +
> +	assert_no_pages_cmma_dirty(vm);
> +}
> +
> +struct testdef {
> +	const char *name;
> +	void (*test)(void);
> +} testlist[] = {
> +	{ "migration mode and dirty tracking", test_migration_mode },
> +	{ "GET_CMMA_BITS: basic calls", test_get_cmma_basic },
> +	{ "GET_CMMA_BITS: all pages are dirty initally", test_get_inital_dirty },
> +	{ "GET_CMMA_BITS: holes are skipped", test_get_skip_holes },
> +};
> +
> +int main(int argc, char *argv[])
> +{
> +	int idx;
> +
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SYNC_REGS));
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_CMMA_MIGRATION));
> +
> +	ksft_print_header();
> +
> +	ksft_set_plan(ARRAY_SIZE(testlist));
> +
> +	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
> +		testlist[idx].test();
> +		ksft_test_result_pass("%s\n", testlist[idx].name);
> +	}
> +
> +	ksft_finished();	/* Print results and exit() accordingly */
> +}

