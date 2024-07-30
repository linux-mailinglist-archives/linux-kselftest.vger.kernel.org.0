Return-Path: <linux-kselftest+bounces-14448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE889409D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 09:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF311F220E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 07:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDBE1922E5;
	Tue, 30 Jul 2024 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tqkSvqXR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A2190485;
	Tue, 30 Jul 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324280; cv=none; b=ApxKmeoUYRHkYzcb+mBt7657lQl4lwTc4iCypaojJbajbhf51TRKnrn4R5M2V56tc7ClEAsE57vjcpPbX19CgAAhoSqix5NwFXs3ATU2HUeHnG9mtL68kTMCycowCN6M9aUFfQ3OMQz4bDNwzfP9n5JT2BXv8rV1YCaxxtvSL+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324280; c=relaxed/simple;
	bh=zF9Ax6J2pD0ZDQvgYG0AF30ZJ1Btq3zA+3UPU7Sn4mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu9+XvFyM8t2YtI2nZLoDoC5go26FykeZUQ/M5dRGxTJfaFHLD1MaatiIz9JYt3fTzmM8g/9ludvB0iXPs6/5m1JVgJaSk0cPOEJJ6zT5zDHd9+eqNLEL5V/AWS2GyONyZzo3CLTXQqr2+bx2/TGEeROenkCgXXQwzXil1DAtOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tqkSvqXR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U6TEeH027811;
	Tue, 30 Jul 2024 07:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=5zXee325HnKhf
	TJHb2YBUoMhvsdztLd+e4qRNc6Yz6Q=; b=tqkSvqXRB1xVoLyU9+dqnshjn/QaQ
	5ZXQf1b+8nt6ZexkTQA7IzAp4D7K0K1tMqsHKTk8ol6BstV8DOdvlplY3JXLae/j
	G9hWl2SUAT7uCAeNkO52WcWnWxrNsx/yN33AMKrZAYYJOmh9VGyO8W8uZbwcOnLs
	S3QsoxEnbvtHg8QZpS9McMeO3VYtcPMNOkEiwvJLfXGBgO5wWfLqZbRpT8NtilnD
	xd8i58WoygocL7KM6jPNQMq4oqi/m6m3PU4G5rHAGZh4nHYM/uTtDHe+1BWsNEG0
	+xExFZFL3HmYIynaYzAVhfsYZ9EHPcT1V5aSVCNgXwURxGfI+l6XDpENw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ptxcr6kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:28 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46U7ORVB003303;
	Tue, 30 Jul 2024 07:24:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ptxcr6kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46U5b9NR009176;
	Tue, 30 Jul 2024 07:24:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx2u41f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46U7OLRF51511662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 07:24:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A0D920043;
	Tue, 30 Jul 2024 07:24:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C951B20040;
	Tue, 30 Jul 2024 07:24:20 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.13.169])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jul 2024 07:24:20 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v3 01/10] selftests: kvm: s390: Define page sizes in shared header
Date: Tue, 30 Jul 2024 09:24:04 +0200
Message-ID: <20240730072413.143556-2-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730072413.143556-1-schlameuss@linux.ibm.com>
References: <20240730072413.143556-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yl7O3KQ31hxRbJx5hMNInms3-7Vwvpxq
X-Proofpoint-ORIG-GUID: malnXfdMDBnIaIAb69zVW4k2z8tXK2Gm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_07,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 mlxlogscore=780 clxscore=1015 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300054

Multiple test cases need page size and shift definitions.
By moving the definitions to a single architecture specific header we
limit the repetition.

Make use of PAGE_SIZE, PAGE_SHIFT and PAGE_MASK defines in existing
code.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
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


