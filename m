Return-Path: <linux-kselftest+bounces-13370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D03592BA0F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 14:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557351C22535
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E115D5C4;
	Tue,  9 Jul 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="svxJNUsI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3EF15B147;
	Tue,  9 Jul 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529848; cv=none; b=Fz99N00gSXPKOjN8x6BhW786d0kK622y7qOC3KzSjjRA3fKBAdVXBmF6hKVN21vrNL+c+UX6rMM1w6oaAyql01j5Sy9ziINQNCNYB8uSXFEjLEnIy3dwxSlw6nBBiJYBqwvwC9inOT8OGtveUkvMRYNaxd3Fky54VWL6wTEa9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529848; c=relaxed/simple;
	bh=LnWQ04E1kQMHESunUZ446dGQcIg+akhsBeXQFcz80k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AROhOIMwmtUnxbeT9+Vtht991Q2DVI7VYf8+Vi3BLSXNM/Qn8uQsgmCW0HD38nNq8BPMbotfTfXNAuiv1MRfaiwQ/U6w0IFgiYxRk3gBk8I2PDXRyXUeF8dHRNywIxVzm7Cvt3wa83yl5moWWs2j5+jKeiVgNKqgW9eu8CkzV5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=svxJNUsI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4698wb0V009365;
	Tue, 9 Jul 2024 12:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=eB1C3a3HYZaa2
	3Z1RfEy3luPnp1BWoOgwx2bJyzz7HI=; b=svxJNUsIpKnb51H/t8khok2fMRa72
	PL7A+elA1KCeXg9PwL4egXtKSoOh/hK67beBf1lJLZ27AC+VjytqLlTjy/RvdND4
	SI0o0f5V9JkpE/vudkcirni+vmIqL2ND7uqewGn8LOZHWR274mK9Ke5DVaDk83Ne
	bKOmCE8KJxBnjw4v06qiUsAGjcswyXA9/Z+5mxEyYfScmBaU0L11zsrLIA7HTUG4
	iTOw93AD/t3fV/wfLC/R8sua0yN9ZFRz2j+2Zn3ikq1DW5PNm8s4+KDUyehuS6tw
	Em9qt2R/Cm7P8xQbeZDfQ6LqBhh0/gRYn91yAyErrWyth8449HUA+vK9w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40925q0jkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:23 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469CsU2u011243;
	Tue, 9 Jul 2024 12:57:22 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40925q0jkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4699t6Rs013974;
	Tue, 9 Jul 2024 12:57:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jy345sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469CvG4I39584250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 12:57:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40E962004B;
	Tue,  9 Jul 2024 12:57:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A76D520040;
	Tue,  9 Jul 2024 12:57:15 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.6.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 12:57:15 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v1 1/9] selftests: kvm: s390: Define page sizes in shared header
Date: Tue,  9 Jul 2024 14:56:56 +0200
Message-ID: <20240709125704.61312-2-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709125704.61312-1-schlameuss@linux.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9ELLi_ODn55-K67Fltf6vWyE8k3O53EK
X-Proofpoint-GUID: gCZIFdChxS-O2qiENuyEYeB4lfiDabU5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=672 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090082

Multiple test cases need page size and shift definitions.
By moving the definitions to a single architecture specific header we
limit the repetition.

Make use of PAGE_SIZE, PAGE_SHIFT and PAGE_MASK defines in existing
code.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 tools/testing/selftests/kvm/include/s390x/processor.h |  5 +++++
 tools/testing/selftests/kvm/lib/s390x/processor.c     | 10 +++++-----
 tools/testing/selftests/kvm/s390x/cmma_test.c         |  7 ++++---
 tools/testing/selftests/kvm/s390x/memop.c             |  4 +---
 tools/testing/selftests/kvm/s390x/tprot.c             |  5 ++---
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/s390x/processor.h b/tools/testing/selftests/kvm/include/s390x/processor.h
index 255c9b990f4c..481bd2fd6a32 100644
--- a/tools/testing/selftests/kvm/include/s390x/processor.h
+++ b/tools/testing/selftests/kvm/include/s390x/processor.h
@@ -21,6 +21,11 @@
 #define PAGE_PROTECT	0x200		/* HW read-only bit  */
 #define PAGE_NOEXEC	0x100		/* HW no-execute bit */
 
+/* Page size definitions */
+#define PAGE_SHIFT 12
+#define PAGE_SIZE BIT_ULL(PAGE_SHIFT)
+#define PAGE_MASK (~(PAGE_SIZE - 1))
+
 /* Is there a portable way to do this? */
 static inline void cpu_relax(void)
 {
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index 4ad4492eea1d..20cfe970e3e3 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -14,7 +14,7 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 {
 	vm_paddr_t paddr;
 
-	TEST_ASSERT(vm->page_size == 4096, "Unsupported page size: 0x%x",
+	TEST_ASSERT(vm->page_size == PAGE_SIZE, "Unsupported page size: 0x%x",
 		    vm->page_size);
 
 	if (vm->pgd_created)
@@ -79,7 +79,7 @@ void virt_arch_pg_map(struct kvm_vm *vm, uint64_t gva, uint64_t gpa)
 	}
 
 	/* Fill in page table entry */
-	idx = (gva >> 12) & 0x0ffu;		/* page index */
+	idx = (gva >> PAGE_SHIFT) & 0x0ffu;		/* page index */
 	if (!(entry[idx] & PAGE_INVALID))
 		fprintf(stderr,
 			"WARNING: PTE for gpa=0x%"PRIx64" already set!\n", gpa);
@@ -91,7 +91,7 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 	int ri, idx;
 	uint64_t *entry;
 
-	TEST_ASSERT(vm->page_size == 4096, "Unsupported page size: 0x%x",
+	TEST_ASSERT(vm->page_size == PAGE_SIZE, "Unsupported page size: 0x%x",
 		    vm->page_size);
 
 	entry = addr_gpa2hva(vm, vm->pgd);
@@ -103,7 +103,7 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 		entry = addr_gpa2hva(vm, entry[idx] & REGION_ENTRY_ORIGIN);
 	}
 
-	idx = (gva >> 12) & 0x0ffu;		/* page index */
+	idx = (gva >> PAGE_SHIFT) & 0x0ffu;		/* page index */
 
 	TEST_ASSERT(!(entry[idx] & PAGE_INVALID),
 		    "No page mapping for vm virtual address 0x%lx", gva);
@@ -168,7 +168,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	struct kvm_sregs sregs;
 	struct kvm_vcpu *vcpu;
 
-	TEST_ASSERT(vm->page_size == 4096, "Unsupported page size: 0x%x",
+	TEST_ASSERT(vm->page_size == PAGE_SIZE, "Unsupported page size: 0x%x",
 		    vm->page_size);
 
 	stack_vaddr = __vm_vaddr_alloc(vm, stack_size,
diff --git a/tools/testing/selftests/kvm/s390x/cmma_test.c b/tools/testing/selftests/kvm/s390x/cmma_test.c
index b39033844756..e32dd59703a0 100644
--- a/tools/testing/selftests/kvm/s390x/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390x/cmma_test.c
@@ -17,16 +17,17 @@
 #include "kvm_util.h"
 #include "kselftest.h"
 #include "ucall_common.h"
+#include "processor.h"
 
 #define MAIN_PAGE_COUNT 512
 
 #define TEST_DATA_PAGE_COUNT 512
 #define TEST_DATA_MEMSLOT 1
-#define TEST_DATA_START_GFN 4096
+#define TEST_DATA_START_GFN PAGE_SIZE
 
 #define TEST_DATA_TWO_PAGE_COUNT 256
 #define TEST_DATA_TWO_MEMSLOT 2
-#define TEST_DATA_TWO_START_GFN 8192
+#define TEST_DATA_TWO_START_GFN (2 * PAGE_SIZE)
 
 static char cmma_value_buf[MAIN_PAGE_COUNT + TEST_DATA_PAGE_COUNT];
 
@@ -66,7 +67,7 @@ static void guest_dirty_test_data(void)
 		"	lghi 5,%[page_count]\n"
 		/* r5 += r1 */
 		"2:	agfr 5,1\n"
-		/* r2 = r1 << 12 */
+		/* r2 = r1 << PAGE_SHIFT */
 		"1:	sllg 2,1,12(0)\n"
 		/* essa(r4, r2, SET_STABLE) */
 		"	.insn rrf,0xb9ab0000,4,2,1,0\n"
diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index f2df7416be84..4374b4cd2a80 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -16,6 +16,7 @@
 #include "kvm_util.h"
 #include "kselftest.h"
 #include "ucall_common.h"
+#include "processor.h"
 
 enum mop_target {
 	LOGICAL,
@@ -226,9 +227,6 @@ static void memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo,
 
 #define CHECK_N_DO(f, ...) ({ f(__VA_ARGS__, CHECK_ONLY); f(__VA_ARGS__); })
 
-#define PAGE_SHIFT 12
-#define PAGE_SIZE (1ULL << PAGE_SHIFT)
-#define PAGE_MASK (~(PAGE_SIZE - 1))
 #define CR0_FETCH_PROTECTION_OVERRIDE	(1UL << (63 - 38))
 #define CR0_STORAGE_PROTECTION_OVERRIDE	(1UL << (63 - 39))
 
diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
index 7a742a673b7c..12d5e1cb62e3 100644
--- a/tools/testing/selftests/kvm/s390x/tprot.c
+++ b/tools/testing/selftests/kvm/s390x/tprot.c
@@ -9,9 +9,8 @@
 #include "kvm_util.h"
 #include "kselftest.h"
 #include "ucall_common.h"
+#include "processor.h"
 
-#define PAGE_SHIFT 12
-#define PAGE_SIZE (1 << PAGE_SHIFT)
 #define CR0_FETCH_PROTECTION_OVERRIDE	(1UL << (63 - 38))
 #define CR0_STORAGE_PROTECTION_OVERRIDE	(1UL << (63 - 39))
 
@@ -151,7 +150,7 @@ static enum stage perform_next_stage(int *i, bool mapped_0)
 		 * instead.
 		 * In order to skip these tests we detect this inside the guest
 		 */
-		skip = tests[*i].addr < (void *)4096 &&
+		skip = tests[*i].addr < (void *)PAGE_SIZE &&
 		       tests[*i].expected != TRANSL_UNAVAIL &&
 		       !mapped_0;
 		if (!skip) {
-- 
2.45.2


