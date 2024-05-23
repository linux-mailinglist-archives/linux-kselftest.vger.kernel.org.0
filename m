Return-Path: <linux-kselftest+bounces-10602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B888CCC5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 08:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF681F22E6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 06:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D878613C672;
	Thu, 23 May 2024 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hDXU5vDA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9B02D05E;
	Thu, 23 May 2024 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446388; cv=none; b=kb3e7iz4Fqf7XX74vxLO0KXQJvI/jMXFYfjR14xEUSG8z2PmVD1rGdz873IHQJy00p3KBEVaozgw+n5Ysz22Ss1a/6DwCDNX7tHGILrlwvy4qXy5br+m7TkW1lkHKpP4D7yllqiFHx3XjOHzuPR6NZNjtp1erZfoBt2v2h6mIu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446388; c=relaxed/simple;
	bh=1SHWak6NpxZvRy4JJY7ngfTdxhrfgQj+uET7woZ0lUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y8o8Dhg5clCgzv1LhPHrMp1L6Ev3cfkPPtjv0+PHI+kuocyZlOTxW6uU+eRU9TxkP5j+U3vHOxQKB0R6BaFXd31iK6spzfYtGa7CfzATmlXL4XI+/yzTY9B1UI2d08oe6+ITi5pT0sS6Z0GBMwMg2j8pm/EG0YIjNt5db644Yac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hDXU5vDA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44N6QAUW010835;
	Thu, 23 May 2024 06:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Thk8rNquzcEN0pZulHeg/jOPCh54cDBsgkzDBaidssc=;
 b=hDXU5vDApGo1eYJiPQrJtS7JssTTZjCq1eKlkRpj/r4lgmFfWveBdzYxCwkmc7sw/hlZ
 NgTpD+DKBHa53xNQAAF0Ofr7ejiNmWLp3fkkQXVro9G9GZ1foZXsQ8IB94wok2S1RGS8
 Z4phB8djBAYn/Y+dX3rxfE7KX0DQxuae6J2FUxxwEy8nrq3f3U+o9rvzLfQamcrkuctk
 /eEV4ZtgWbcSZga3VForJpBSYnHOjlRYyMINRuUfiutKTC9J7V5lYM6v/RVmcF+ABoq4
 HPTvIt2PxY8HFCHB/syCVPiEG7mwr6tzFD/reuhsILxZseUjIa7FpJWYUZ0sATNj3YSQ ew== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya03r03cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 06:39:13 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44N6dC0W002051;
	Thu, 23 May 2024 06:39:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya03r03cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 06:39:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44N6Tecm022086;
	Thu, 23 May 2024 06:39:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y76nu0r1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 06:39:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44N6d7QA51315030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 06:39:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5C8A20043;
	Thu, 23 May 2024 06:39:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D923A20040;
	Thu, 23 May 2024 06:39:05 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.53.171.174])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 May 2024 06:39:05 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] selftest: mm: Test if hugepage does not get leaked during __bio_release_pages()
Date: Thu, 23 May 2024 01:39:05 -0500
Message-Id: <20240523063905.3173-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w3bomp1Ygh6fVGcOAxb--U1SDV0WWeHP
X-Proofpoint-ORIG-GUID: 7yDoZyQskpGg9ex2I-WMIaZwP8-soNWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_03,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230043

Commit 1b151e2435fc ("block: Remove special-casing of compound
pages") caused a change in behaviour when releasing the pages
if the buffer does not start at the beginning of the page. This
was because the calculation of the number of pages to release
was incorrect.
This was fixed by commit 38b43539d64b ("block: Fix page refcounts
for unaligned buffers in __bio_release_pages()").

We pin the user buffer during direct I/O writes. If this buffer is a
hugepage, bio_release_page() will unpin it and decrement all references
and pin counts at ->bi_end_io. However, if any references to the hugepage
remain post-I/O, the hugepage will not be freed upon unmap, leading
to a memory leak.

This patch verifies that a hugepage, used as a user buffer for DIO
operations, is correctly freed upon unmapping, regardless of whether
the offsets are aligned or unaligned w.r.t page boundary.

Test Result  Fail Scenario (Without the fix)
--------------------------------------------------------
[]# ./hugetlb_dio
TAP version 13
1..4
No. Free pages before allocation : 7
No. Free pages after munmap : 7
ok 1 : Huge pages freed successfully !
No. Free pages before allocation : 7
No. Free pages after munmap : 7
ok 2 : Huge pages freed successfully !
No. Free pages before allocation : 7
No. Free pages after munmap : 7
ok 3 : Huge pages freed successfully !
No. Free pages before allocation : 7
No. Free pages after munmap : 6
not ok 4 : Huge pages not freed!
Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0

Test Result  PASS Scenario (With the fix)
---------------------------------------------------------
[]#./hugetlb_dio
TAP version 13
1..4
No. Free pages before allocation : 7
No. Free pages after munmap : 7
ok 1 : Huge pages freed successfully !
No. Free pages before allocation : 7
No. Free pages after munmap : 7
ok 2 : Huge pages freed successfully !
No. Free pages before allocation : 7
No. Free pages after munmap : 7
ok 3 : Huge pages freed successfully !
No. Free pages before allocation : 7
No. Free pages after munmap : 7
ok 4 : Huge pages freed successfully !
Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/mm/Makefile      |   1 +
 tools/testing/selftests/mm/hugetlb_dio.c | 118 +++++++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/mm/hugetlb_dio.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index eb5f39a2668b..87d8130b3376 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -71,6 +71,7 @@ TEST_GEN_FILES += ksm_functional_tests
 TEST_GEN_FILES += mdwe_test
 TEST_GEN_FILES += hugetlb_fault_after_madv
 TEST_GEN_FILES += hugetlb_madv_vs_map
+TEST_GEN_FILES += hugetlb_dio
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
new file mode 100644
index 000000000000..6f6587c7913c
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb_dio.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This program tests for hugepage leaks after DIO writes to a file using a
+ * hugepage as the user buffer. During DIO, the user buffer is pinned and
+ * should be properly unpinned upon completion. This patch verifies that the
+ * kernel correctly unpins the buffer at DIO completion for both aligned and
+ * unaligned user buffer offsets (w.r.t page boundary), ensuring the hugepage
+ * is freed upon unmapping.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/stat.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/mman.h>
+#include "vm_util.h"
+#include "../kselftest.h"
+
+void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
+{
+	int fd;
+	char *buffer =  NULL;
+	char *orig_buffer = NULL;
+	size_t h_pagesize = 0;
+	size_t writesize;
+	int free_hpage_b = 0;
+	int free_hpage_a = 0;
+
+	writesize = end_off - start_off;
+
+	/* Get the default huge page size */
+	h_pagesize = default_huge_page_size();
+	if (!h_pagesize)
+		ksft_exit_fail_msg("Unable to determine huge page size\n");
+
+	/* Open the file to DIO */
+	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT);
+	if (fd < 0)
+		ksft_exit_fail_msg("Error opening file");
+
+	/* Get the free huge pages before allocation */
+	free_hpage_b = get_free_hugepages();
+	if (free_hpage_b == 0) {
+		close(fd);
+		ksft_exit_skip("No free hugepage, exiting!\n");
+	}
+
+	/* Allocate a hugetlb page */
+	orig_buffer = mmap(NULL, h_pagesize, PROT_READ | PROT_WRITE, MAP_PRIVATE
+			| MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+	if (orig_buffer == MAP_FAILED) {
+		close(fd);
+		ksft_exit_fail_msg("Error mapping memory");
+	}
+	buffer = orig_buffer;
+	buffer += start_off;
+
+	memset(buffer, 'A', writesize);
+
+	/* Write the buffer to the file */
+	if (write(fd, buffer, writesize) != (writesize)) {
+		munmap(orig_buffer, h_pagesize);
+		close(fd);
+		ksft_exit_fail_msg("Error writing to file");
+	}
+
+	/* unmap the huge page */
+	munmap(orig_buffer, h_pagesize);
+	close(fd);
+
+	/* Get the free huge pages after unmap*/
+	free_hpage_a = get_free_hugepages();
+
+	/*
+	 * If the no. of free hugepages before allocation and after unmap does
+	 * not match - that means there could still be a page which is pinned.
+	 */
+	if (free_hpage_a != free_hpage_b) {
+		printf("No. Free pages before allocation : %d\n", free_hpage_b);
+		printf("No. Free pages after munmap : %d\n", free_hpage_a);
+		ksft_test_result_fail(": Huge pages not freed!\n");
+	} else {
+		printf("No. Free pages before allocation : %d\n", free_hpage_b);
+		printf("No. Free pages after munmap : %d\n", free_hpage_a);
+		ksft_test_result_pass(": Huge pages freed successfully !\n");
+	}
+}
+
+int main(void)
+{
+	size_t pagesize = 0;
+
+	ksft_print_header();
+	ksft_set_plan(4);
+
+	/* Get base page size */
+	pagesize  = psize();
+
+	/* start and end is aligned to pagesize */
+	run_dio_using_hugetlb(0, (pagesize * 3));
+
+	/* start is aligned but end is not aligned */
+	run_dio_using_hugetlb(0, (pagesize * 3) - (pagesize / 2));
+
+	/* start is unaligned and end is aligned */
+	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3));
+
+	/* both start and end are unaligned */
+	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3) + (pagesize / 2));
+
+	ksft_finished();
+	return 0;
+}
+
-- 
2.39.3


