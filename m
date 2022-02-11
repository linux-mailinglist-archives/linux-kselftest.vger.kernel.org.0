Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921394B1E9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 07:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbiBKGfS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 01:35:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiBKGfS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 01:35:18 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3550E56
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 22:35:17 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21B6PJJD011241;
        Fri, 11 Feb 2022 06:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SWc9HmSHc793CMFIC2l4bwVO7HD12ma7vyanF9gnhcM=;
 b=pQKc8/LOC3p2DkWRpXR2OhsWuoiT4HzgcOQQIRjVUEp03TRGJP/q4ZNxJBcXm7mMjWpU
 WgsE4CH06nG2GfJm+3dI3jhwvWpy3NK5yTPCxQnx01VIbTkyhuy8Bc6vPOzNxRhuOR49
 o8+YLKv5K10yjFVUMFoBFpcE05FNNGrcTzDuV/k9NxCTUPBbuJNCA3ktOYJpAB7vXudH
 TuyHAKfr5biXLA0j+54amjgA0FwytQcbumpefSqccnVGp0zEcrXSMITxBAwt/Spppzbt
 DTd1o9ifxrtIfL31wk9YtRElocjx1WfaUeBtL+tM43+c1kcERAFT55G2pGJtHPBgbZ7K kg== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e5b38q8ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 06:35:01 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21B6XQpT014417;
        Fri, 11 Feb 2022 06:35:01 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 3e3gq1nqyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 06:35:01 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21B6Z0nq32964884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 06:35:00 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED01C13605E;
        Fri, 11 Feb 2022 06:34:59 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D558136053;
        Fri, 11 Feb 2022 06:34:57 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.41.36])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 11 Feb 2022 06:34:57 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/2] selftest/vm: Add util.h and and move helper functions there
Date:   Fri, 11 Feb 2022 12:03:29 +0530
Message-Id: <20220211063330.99648-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211063330.99648-1-aneesh.kumar@linux.ibm.com>
References: <20220211063330.99648-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H6QsVuT_qpeFL_jvK7a5VVGJZPAAHqNW
X-Proofpoint-ORIG-GUID: H6QsVuT_qpeFL_jvK7a5VVGJZPAAHqNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_02,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Avoid code duplication by adding util.h

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 tools/testing/selftests/vm/ksm_tests.c        | 45 +---------------
 tools/testing/selftests/vm/transhuge-stress.c | 49 ++---------------
 tools/testing/selftests/vm/util.h             | 54 +++++++++++++++++++
 3 files changed, 58 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/vm/util.h

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index cae72872152b..fd85f15869d1 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -12,6 +12,7 @@
 
 #include "../kselftest.h"
 #include "../../../../include/vdso/time64.h"
+#include "util.h"
 
 #define KSM_SYSFS_PATH "/sys/kernel/mm/ksm/"
 #define KSM_FP(s) (KSM_SYSFS_PATH s)
@@ -22,22 +23,6 @@
 #define KSM_MERGE_ACROSS_NODES_DEFAULT true
 #define MB (1ul << 20)
 
-#ifdef __powerpc64__
-#define PAGE_SHIFT	16
-#else
-#define PAGE_SHIFT	12
-#endif
-/*
- * On ppc64 this will only work with radix 2M hugepage size
- */
-#define HPAGE_SHIFT 21
-
-#define PAGE_SIZE (1 << PAGE_SHIFT)
-#define HPAGE_SIZE (1 << HPAGE_SHIFT)
-
-#define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
-#define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
-
 struct ksm_sysfs {
 	unsigned long max_page_sharing;
 	unsigned long merge_across_nodes;
@@ -463,34 +448,6 @@ static int check_ksm_numa_merge(int mapping, int prot, int timeout, bool merge_a
 	return KSFT_FAIL;
 }
 
-int64_t allocate_transhuge(void *ptr, int pagemap_fd)
-{
-	uint64_t ent[2];
-
-	/* drop pmd */
-	if (mmap(ptr, HPAGE_SIZE, PROT_READ | PROT_WRITE,
-				MAP_FIXED | MAP_ANONYMOUS |
-				MAP_NORESERVE | MAP_PRIVATE, -1, 0) != ptr)
-		errx(2, "mmap transhuge");
-
-	if (madvise(ptr, HPAGE_SIZE, MADV_HUGEPAGE))
-		err(2, "MADV_HUGEPAGE");
-
-	/* allocate transparent huge page */
-	*(volatile void **)ptr = ptr;
-
-	if (pread(pagemap_fd, ent, sizeof(ent),
-			(uintptr_t)ptr >> (PAGE_SHIFT - 3)) != sizeof(ent))
-		err(2, "read pagemap");
-
-	if (PAGEMAP_PRESENT(ent[0]) && PAGEMAP_PRESENT(ent[1]) &&
-	    PAGEMAP_PFN(ent[0]) + 1 == PAGEMAP_PFN(ent[1]) &&
-	    !(PAGEMAP_PFN(ent[0]) & ((1 << (HPAGE_SHIFT - PAGE_SHIFT)) - 1)))
-		return PAGEMAP_PFN(ent[0]);
-
-	return -1;
-}
-
 static int ksm_merge_hugepages_time(int mapping, int prot, int timeout, size_t map_size)
 {
 	void *map_ptr, *map_ptr_orig;
diff --git a/tools/testing/selftests/vm/transhuge-stress.c b/tools/testing/selftests/vm/transhuge-stress.c
index b1f8d98355c5..0da4aa10746a 100644
--- a/tools/testing/selftests/vm/transhuge-stress.c
+++ b/tools/testing/selftests/vm/transhuge-stress.c
@@ -16,51 +16,7 @@
 #include <string.h>
 #include <sys/mman.h>
 
-#ifdef __powerpc64__
-#define PAGE_SHIFT	16
-#else
-#define PAGE_SHIFT	12
-#endif
-/*
- * On ppc64 this will only work with radix 2M hugepage size
- */
-#define HPAGE_SHIFT 21
-
-#define PAGE_SIZE (1 << PAGE_SHIFT)
-#define HPAGE_SIZE (1 << HPAGE_SHIFT)
-
-#define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
-#define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
-
-int pagemap_fd;
-
-int64_t allocate_transhuge(void *ptr)
-{
-	uint64_t ent[2];
-
-	/* drop pmd */
-	if (mmap(ptr, HPAGE_SIZE, PROT_READ | PROT_WRITE,
-				MAP_FIXED | MAP_ANONYMOUS |
-				MAP_NORESERVE | MAP_PRIVATE, -1, 0) != ptr)
-		errx(2, "mmap transhuge");
-
-	if (madvise(ptr, HPAGE_SIZE, MADV_HUGEPAGE))
-		err(2, "MADV_HUGEPAGE");
-
-	/* allocate transparent huge page */
-	*(volatile void **)ptr = ptr;
-
-	if (pread(pagemap_fd, ent, sizeof(ent),
-			(uintptr_t)ptr >> (PAGE_SHIFT - 3)) != sizeof(ent))
-		err(2, "read pagemap");
-
-	if (PAGEMAP_PRESENT(ent[0]) && PAGEMAP_PRESENT(ent[1]) &&
-	    PAGEMAP_PFN(ent[0]) + 1 == PAGEMAP_PFN(ent[1]) &&
-	    !(PAGEMAP_PFN(ent[0]) & ((1 << (HPAGE_SHIFT - PAGE_SHIFT)) - 1)))
-		return PAGEMAP_PFN(ent[0]);
-
-	return -1;
-}
+#include "util.h"
 
 int main(int argc, char **argv)
 {
@@ -70,6 +26,7 @@ int main(int argc, char **argv)
 	double s;
 	uint8_t *map;
 	size_t map_len;
+	int pagemap_fd;
 
 	ram = sysconf(_SC_PHYS_PAGES);
 	if (ram > SIZE_MAX / sysconf(_SC_PAGESIZE) / 4)
@@ -116,7 +73,7 @@ int main(int argc, char **argv)
 		for (p = ptr; p < ptr + len; p += HPAGE_SIZE) {
 			int64_t pfn;
 
-			pfn = allocate_transhuge(p);
+			pfn = allocate_transhuge(p, pagemap_fd);
 
 			if (pfn < 0) {
 				nr_failed++;
diff --git a/tools/testing/selftests/vm/util.h b/tools/testing/selftests/vm/util.h
new file mode 100644
index 000000000000..8ec94940371f
--- /dev/null
+++ b/tools/testing/selftests/vm/util.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __KSELFTEST_VM_UTIL_H
+#define __KSELFTEST_VM_UTIL_H
+
+#include <sys/mman.h>
+#include <err.h>
+
+#ifdef __powerpc64__
+#define PAGE_SHIFT	16
+#else
+#define PAGE_SHIFT	12
+#endif
+/*
+ * On ppc64 this will only work with radix 2M hugepage size
+ */
+#define HPAGE_SHIFT 21
+
+#define PAGE_SIZE (1 << PAGE_SHIFT)
+#define HPAGE_SIZE (1 << HPAGE_SHIFT)
+
+#define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
+#define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
+
+
+static inline int64_t allocate_transhuge(void *ptr, int pagemap_fd)
+{
+	uint64_t ent[2];
+
+	/* drop pmd */
+	if (mmap(ptr, HPAGE_SIZE, PROT_READ | PROT_WRITE,
+		 MAP_FIXED | MAP_ANONYMOUS |
+		 MAP_NORESERVE | MAP_PRIVATE, -1, 0) != ptr)
+		errx(2, "mmap transhuge");
+
+	if (madvise(ptr, HPAGE_SIZE, MADV_HUGEPAGE))
+		err(2, "MADV_HUGEPAGE");
+
+	/* allocate transparent huge page */
+	*(volatile void **)ptr = ptr;
+
+	if (pread(pagemap_fd, ent, sizeof(ent),
+		  (uintptr_t)ptr >> (PAGE_SHIFT - 3)) != sizeof(ent))
+		err(2, "read pagemap");
+
+	if (PAGEMAP_PRESENT(ent[0]) && PAGEMAP_PRESENT(ent[1]) &&
+	    PAGEMAP_PFN(ent[0]) + 1 == PAGEMAP_PFN(ent[1]) &&
+	    !(PAGEMAP_PFN(ent[0]) & ((1 << (HPAGE_SHIFT - PAGE_SHIFT)) - 1)))
+		return PAGEMAP_PFN(ent[0]);
+
+	return -1;
+}
+
+#endif
-- 
2.34.1

