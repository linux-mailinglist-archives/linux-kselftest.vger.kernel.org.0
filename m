Return-Path: <linux-kselftest+bounces-14931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E2D94AD48
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 17:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D038B280257
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F013B588;
	Wed,  7 Aug 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GveSNWMY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500F136664;
	Wed,  7 Aug 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045555; cv=none; b=gvUUcdfXxnTQ2QbF7XJjv6Tca2ew8cI3k66pcM7VM24WAxNn57b5AAIjyaEhmJcs2wewZFej82ECToiPUvLFh28q96ECV8ZWZ+Io3IVME6xQAe8jR4AdFPuxousJ1L2Wtzl32prneywgMhKyoQggoKn3RE/Vhluz9l1DkK91ZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045555; c=relaxed/simple;
	bh=zF9Ax6J2pD0ZDQvgYG0AF30ZJ1Btq3zA+3UPU7Sn4mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXSmdEVJocqsjQs1Ts75NbvoTfh5TUYFvUyzV6+aEybBkSVmTmi0f1LUqRgMHWuJ4wM4Lb247YBGNQ+utWffIbFyCoTNaBHj9SeFC+/Me2Is0wtdGb5sQyz+4dxnPM5yBKheGadAKxVi8jmcVWDruuDZooWD8z1EQ5a2Os0mAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GveSNWMY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4772POuF000814;
	Wed, 7 Aug 2024 15:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=5zXee325HnKhf
	TJHb2YBUoMhvsdztLd+e4qRNc6Yz6Q=; b=GveSNWMYA5YoWCA4jpObxNvI8g4FI
	1X9GcllcG15BWwOODYg7eJ3chIJmGNUQso0hd0u30uE5m7K3GKkIgciVJXRcA2y5
	24buUCGwO8rE/uLDLuo/E61AkpFyeLn4cgcVh0bIjDtXhVXM5fqa9TABeWM0XGle
	Eui2KLaI281IowukQGyQd0PqtP0mBOtUuu+O6OTL7dU0ZFEy44u4dtgjqSnwgVYa
	nC1miZ/TWcEM/OBODHQExqBqo9cxK3EGX3ckRLvqPGu2iKmhsAnWlgiebPJsAErk
	qUrLKgouyX3LrUJM36k47aGf1Ci7oM0cpsbUYp9k9+4nO2ps45fBaFwWw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40upxjtr8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 15:45:43 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 477Fjhd6019460;
	Wed, 7 Aug 2024 15:45:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40upxjtr8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 15:45:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 477FZ0PN024136;
	Wed, 7 Aug 2024 15:45:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40syvphqmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 15:45:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477FjZAG42598882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 15:45:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B949320040;
	Wed,  7 Aug 2024 15:45:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57FBA2004D;
	Wed,  7 Aug 2024 15:45:35 +0000 (GMT)
Received: from darkmoore.boeblingen.de.ibm.com (unknown [9.155.210.150])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 15:45:35 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, schlameuss@linux.ibm.com
Subject: [PATCH v5 01/10] selftests: kvm: s390: Define page sizes in shared header
Date: Wed,  7 Aug 2024 17:45:03 +0200
Message-ID: <20240807154512.316936-2-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807154512.316936-1-schlameuss@linux.ibm.com>
References: <20240807154512.316936-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yllwfEb6Z49xB8hKr2U91jCWajJJrHYD
X-Proofpoint-GUID: QN1wdiO1SxIRl9osIEtmx5Rk33B90e3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=779
 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408070107

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


