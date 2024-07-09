Return-Path: <linux-kselftest+bounces-13386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78F692C23F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F1CB2AB70
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FF718D4DF;
	Tue,  9 Jul 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="biRahps0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3718D4BD;
	Tue,  9 Jul 2024 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544879; cv=none; b=fkNT9nhKshZkBan+1cXDzfM6hEZJWvyw9PJuNuNVu8AFwA3fKfnW2IzfkIc9Z0OUnF5DumR8BLdV8xrQU/uChyAiy6DlAzhTCErZ/LT+CDc9olek06zBFX2mVG1XxXhdonoNYRo+TQyk42Dgho0tQZRxVEWSSNsUZ0fLAc4SDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544879; c=relaxed/simple;
	bh=uDs037Vz6DarHg35IqgXtnw2INLTrOe+yze7ePGX9eA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3rDfKcprZqF2Oomrdpp6b/5Vex2IW2GmRhQ0zdCDNo4w+BDAfFJwtN54leT/wkh273T/RH6hR3mQ4rhEMVTKfXok7WV+50Jrm5kCFAnDDJJPX1Z3gr1WpxwXBwozojpIMCrV+8waNucXYvK5WKnNPAEhVdV4U5o5p1RAJhorlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=biRahps0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469ASnWK002110;
	Tue, 9 Jul 2024 17:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	t3T9a3IVK5f8HTywJmt/L/1gD6yR3HE4H5AoYHbEpvI=; b=biRahps0drRYMA2c
	2hrWCPCCc/v0zHQiPTG7lh64Ve+cKnCg7juFbdlWrf7P7PqctljcWymQfIoT9dg9
	Fih+ZP9eR9zFAVjZkNKfQvYP8gHOXB0DNb8C1saNfUt+FVeY9N8xuU+CPXmZj/Cq
	kUrIwWZV56zYLWq2rOL3y3I6fGRfRlCpz+RIlBLgnWkUpVTpLZlSWh7We/rkZgPo
	0jAy9wZ1auuSUmk2ZpCB5f/E3pIjhhceRMl2IfxUKXbMnFTAC8hbEIW9dVpgSseu
	x/PreIXfddfjtPPzAsg514/xa3O9i2Bx4LZWAwAg9NQDwaKHxPNa3zgNGw0gWXzZ
	70/Kww==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4090ug1p68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469H7rHP024253;
	Tue, 9 Jul 2024 17:07:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4090ug1p65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469F7W6f014043;
	Tue, 9 Jul 2024 17:07:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407h8pnq85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469H7kjF57737484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 17:07:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BE342004D;
	Tue,  9 Jul 2024 17:07:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FC1320040;
	Tue,  9 Jul 2024 17:07:46 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 17:07:46 +0000 (GMT)
Date: Tue, 9 Jul 2024 17:08:23 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah
 Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand
 <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v1 1/9] selftests: kvm: s390: Define page sizes in
 shared header
Message-ID: <20240709170823.6a2c2107@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240709125704.61312-2-schlameuss@linux.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
	<20240709125704.61312-2-schlameuss@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8eP6WblnaXkYVOdirSWQD8k8xMCQUQY9
X-Proofpoint-ORIG-GUID: S1e7EDcaWQ9B7oKl8IyreL2XqFhbSqA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=926
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090112

On Tue,  9 Jul 2024 14:56:56 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Multiple test cases need page size and shift definitions.
> By moving the definitions to a single architecture specific header we
> limit the repetition.
> 
> Make use of PAGE_SIZE, PAGE_SHIFT and PAGE_MASK defines in existing
> code.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  tools/testing/selftests/kvm/include/s390x/processor.h |  5 +++++
>  tools/testing/selftests/kvm/lib/s390x/processor.c     | 10 +++++-----
>  tools/testing/selftests/kvm/s390x/cmma_test.c         |  7 ++++---
>  tools/testing/selftests/kvm/s390x/memop.c             |  4 +---
>  tools/testing/selftests/kvm/s390x/tprot.c             |  5 ++---
>  5 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/s390x/processor.h b/tools/testing/selftests/kvm/include/s390x/processor.h
> index 255c9b990f4c..481bd2fd6a32 100644
> --- a/tools/testing/selftests/kvm/include/s390x/processor.h
> +++ b/tools/testing/selftests/kvm/include/s390x/processor.h
> @@ -21,6 +21,11 @@
>  #define PAGE_PROTECT	0x200		/* HW read-only bit  */
>  #define PAGE_NOEXEC	0x100		/* HW no-execute bit */
>  
> +/* Page size definitions */
> +#define PAGE_SHIFT 12
> +#define PAGE_SIZE BIT_ULL(PAGE_SHIFT)
> +#define PAGE_MASK (~(PAGE_SIZE - 1))
> +
>  /* Is there a portable way to do this? */
>  static inline void cpu_relax(void)
>  {
> diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
> index 4ad4492eea1d..20cfe970e3e3 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/processor.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
> @@ -14,7 +14,7 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
>  {
>  	vm_paddr_t paddr;
>  
> -	TEST_ASSERT(vm->page_size == 4096, "Unsupported page size: 0x%x",
> +	TEST_ASSERT(vm->page_size == PAGE_SIZE, "Unsupported page size: 0x%x",
>  		    vm->page_size);
>  
>  	if (vm->pgd_created)
> @@ -79,7 +79,7 @@ void virt_arch_pg_map(struct kvm_vm *vm, uint64_t gva, uint64_t gpa)
>  	}
>  
>  	/* Fill in page table entry */
> -	idx = (gva >> 12) & 0x0ffu;		/* page index */
> +	idx = (gva >> PAGE_SHIFT) & 0x0ffu;		/* page index */
>  	if (!(entry[idx] & PAGE_INVALID))
>  		fprintf(stderr,
>  			"WARNING: PTE for gpa=0x%"PRIx64" already set!\n", gpa);
> @@ -91,7 +91,7 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
>  	int ri, idx;
>  	uint64_t *entry;
>  
> -	TEST_ASSERT(vm->page_size == 4096, "Unsupported page size: 0x%x",
> +	TEST_ASSERT(vm->page_size == PAGE_SIZE, "Unsupported page size: 0x%x",
>  		    vm->page_size);
>  
>  	entry = addr_gpa2hva(vm, vm->pgd);
> @@ -103,7 +103,7 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
>  		entry = addr_gpa2hva(vm, entry[idx] & REGION_ENTRY_ORIGIN);
>  	}
>  
> -	idx = (gva >> 12) & 0x0ffu;		/* page index */
> +	idx = (gva >> PAGE_SHIFT) & 0x0ffu;		/* page index */
>  
>  	TEST_ASSERT(!(entry[idx] & PAGE_INVALID),
>  		    "No page mapping for vm virtual address 0x%lx", gva);
> @@ -168,7 +168,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>  	struct kvm_sregs sregs;
>  	struct kvm_vcpu *vcpu;
>  
> -	TEST_ASSERT(vm->page_size == 4096, "Unsupported page size: 0x%x",
> +	TEST_ASSERT(vm->page_size == PAGE_SIZE, "Unsupported page size: 0x%x",
>  		    vm->page_size);
>  
>  	stack_vaddr = __vm_vaddr_alloc(vm, stack_size,
> diff --git a/tools/testing/selftests/kvm/s390x/cmma_test.c b/tools/testing/selftests/kvm/s390x/cmma_test.c
> index b39033844756..e32dd59703a0 100644
> --- a/tools/testing/selftests/kvm/s390x/cmma_test.c
> +++ b/tools/testing/selftests/kvm/s390x/cmma_test.c
> @@ -17,16 +17,17 @@
>  #include "kvm_util.h"
>  #include "kselftest.h"
>  #include "ucall_common.h"
> +#include "processor.h"
>  
>  #define MAIN_PAGE_COUNT 512
>  
>  #define TEST_DATA_PAGE_COUNT 512
>  #define TEST_DATA_MEMSLOT 1
> -#define TEST_DATA_START_GFN 4096
> +#define TEST_DATA_START_GFN PAGE_SIZE
>  
>  #define TEST_DATA_TWO_PAGE_COUNT 256
>  #define TEST_DATA_TWO_MEMSLOT 2
> -#define TEST_DATA_TWO_START_GFN 8192
> +#define TEST_DATA_TWO_START_GFN (2 * PAGE_SIZE)
>  
>  static char cmma_value_buf[MAIN_PAGE_COUNT + TEST_DATA_PAGE_COUNT];
>  
> @@ -66,7 +67,7 @@ static void guest_dirty_test_data(void)
>  		"	lghi 5,%[page_count]\n"
>  		/* r5 += r1 */
>  		"2:	agfr 5,1\n"
> -		/* r2 = r1 << 12 */
> +		/* r2 = r1 << PAGE_SHIFT */
>  		"1:	sllg 2,1,12(0)\n"
>  		/* essa(r4, r2, SET_STABLE) */
>  		"	.insn rrf,0xb9ab0000,4,2,1,0\n"
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index f2df7416be84..4374b4cd2a80 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -16,6 +16,7 @@
>  #include "kvm_util.h"
>  #include "kselftest.h"
>  #include "ucall_common.h"
> +#include "processor.h"
>  
>  enum mop_target {
>  	LOGICAL,
> @@ -226,9 +227,6 @@ static void memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo,
>  
>  #define CHECK_N_DO(f, ...) ({ f(__VA_ARGS__, CHECK_ONLY); f(__VA_ARGS__); })
>  
> -#define PAGE_SHIFT 12
> -#define PAGE_SIZE (1ULL << PAGE_SHIFT)
> -#define PAGE_MASK (~(PAGE_SIZE - 1))
>  #define CR0_FETCH_PROTECTION_OVERRIDE	(1UL << (63 - 38))
>  #define CR0_STORAGE_PROTECTION_OVERRIDE	(1UL << (63 - 39))
>  
> diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
> index 7a742a673b7c..12d5e1cb62e3 100644
> --- a/tools/testing/selftests/kvm/s390x/tprot.c
> +++ b/tools/testing/selftests/kvm/s390x/tprot.c
> @@ -9,9 +9,8 @@
>  #include "kvm_util.h"
>  #include "kselftest.h"
>  #include "ucall_common.h"
> +#include "processor.h"
>  
> -#define PAGE_SHIFT 12
> -#define PAGE_SIZE (1 << PAGE_SHIFT)
>  #define CR0_FETCH_PROTECTION_OVERRIDE	(1UL << (63 - 38))
>  #define CR0_STORAGE_PROTECTION_OVERRIDE	(1UL << (63 - 39))
>  
> @@ -151,7 +150,7 @@ static enum stage perform_next_stage(int *i, bool mapped_0)
>  		 * instead.
>  		 * In order to skip these tests we detect this inside the guest
>  		 */
> -		skip = tests[*i].addr < (void *)4096 &&
> +		skip = tests[*i].addr < (void *)PAGE_SIZE &&
>  		       tests[*i].expected != TRANSL_UNAVAIL &&
>  		       !mapped_0;
>  		if (!skip) {


