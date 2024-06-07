Return-Path: <linux-kselftest+bounces-11337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240598FFB80
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 07:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08ED21C23DF3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 05:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C65F14EC76;
	Fri,  7 Jun 2024 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LEeuoacc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33329428;
	Fri,  7 Jun 2024 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717739784; cv=none; b=K0Rplqjb5UidirmGDjzWt+pWU7vpz5aUu+s8eZFz5QtrDvZCyuuSdnxmJWYqlb7aNe5HTvbizkMvtYhzGSf5PegJAK/xrakTBFTP6ftlGtZ1XTuRC3vYkS3C+FFM/tsB3YIH+U2Qd6f9AEYqDUbwkjFxQFMQdEGghI/eGpLPnqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717739784; c=relaxed/simple;
	bh=lxVRTw4RicIX0/jcIPprJcPw5SaFqng9FCtf2gSQu/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tnUe1YFmPdHGxPR9pSebCCo4esMUXO8LR7uijCtHIzXlPOdPfQNb/MNJsF/D3XvoV1qk9+4qxGroF6elS9pZ56GoqogomeYXs5boJ1681453d+6PQEjbVNgoQJxMnZPT2XPtutlRQ225If4jUaWH/9yrdE9opRXY5kLk0DDOvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LEeuoacc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4575lbb6026599;
	Fri, 7 Jun 2024 05:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=pp1; bh=s/ZxUEREZBvYFPPMVO46vfHfETXdOwC+8UzyCRqc+tQ=;
 b=LEeuoacclLHtYvXefeekckYCAwEScQHWSur0XYJ6dMQmeEs4HwgH4PURJ3RHkSptoMtP
 gWz0Uah3xUhjnAHiExrDuq2x+5aH6xWl8Pf2P60XREOZlg73n1GEFT6XrWyKORSc17eq
 5ovmmswGtqRr/3KvUB435+7vh5Yfu9CUiJGPBdXb9GCatEbOPxdFhY66oaRJNQFSA9Cn
 CHJrHUo56TG5WwTlfF2wb5u7YqqHMA1ZnG3NqW5K/ocyUrC2auv3Z/ojfLco7ABFlYyy
 2+e0U5+ajJXMIjA6c6jHZH279Ja6zZDa5JWWedN6FK5qDmV14HuddJQonQSUzQ/J23/b Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykvc6g12k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 05:55:54 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4575trMd006780;
	Fri, 7 Jun 2024 05:55:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykvc6g12e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 05:55:53 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45750A8o008479;
	Fri, 7 Jun 2024 05:50:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygec1742g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 05:50:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4575ommh47972698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jun 2024 05:50:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6EA62004D;
	Fri,  7 Jun 2024 05:50:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9C9420040;
	Fri,  7 Jun 2024 05:50:46 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.40.194.31])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jun 2024 05:50:46 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>, p.raghav@samsung.com,
        usama.anjum@collabora.com
Subject: [PATCH v3] selftest: mm: Test if hugepage does not get leaked during __bio_release_pages()
Date: Fri,  7 Jun 2024 00:50:46 -0500
Message-ID: <20240607055046.138650-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vPHsyOXbzXFfoHSG_KQL33r7eezC1kfl
X-Proofpoint-GUID: 9mF91BYMoBVP-VZu17tOufS3JFPP0Iyk
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070040

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

V3:
- Fixed the build error when it is compiled with _FORTIFY_SOURCE.

V2:
- Addressed all review commets from Muhammad Usama Anjum
https://lore.kernel.org/all/20240604132801.23377-1-donettom@linux.ibm.com/

V1:
https://lore.kernel.org/all/20240523063905.3173-1-donettom@linux.ibm.com/#t

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/mm/Makefile      |   1 +
 tools/testing/selftests/mm/hugetlb_dio.c | 118 +++++++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/mm/hugetlb_dio.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 3b49bc3d0a3b..a1748a4c7df1 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -73,6 +73,7 @@ TEST_GEN_FILES += ksm_functional_tests
 TEST_GEN_FILES += mdwe_test
 TEST_GEN_FILES += hugetlb_fault_after_madv
 TEST_GEN_FILES += hugetlb_madv_vs_map
+TEST_GEN_FILES += hugetlb_dio
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
new file mode 100644
index 000000000000..986f3b6c7f7b
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
+	const int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB;
+	const int mmap_prot  = PROT_READ | PROT_WRITE;
+
+	writesize = end_off - start_off;
+
+	/* Get the default huge page size */
+	h_pagesize = default_huge_page_size();
+	if (!h_pagesize)
+		ksft_exit_fail_msg("Unable to determine huge page size\n");
+
+	/* Open the file to DIO */
+	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
+	if (fd < 0)
+		ksft_exit_fail_perror("Error opening file\n");
+
+	/* Get the free huge pages before allocation */
+	free_hpage_b = get_free_hugepages();
+	if (free_hpage_b == 0) {
+		close(fd);
+		ksft_exit_skip("No free hugepage, exiting!\n");
+	}
+
+	/* Allocate a hugetlb page */
+	orig_buffer = mmap(NULL, h_pagesize, mmap_prot, mmap_flags, -1, 0);
+	if (orig_buffer == MAP_FAILED) {
+		close(fd);
+		ksft_exit_fail_perror("Error mapping memory\n");
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
+		ksft_exit_fail_perror("Error writing to file\n");
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
+		ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
+		ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
+		ksft_test_result_fail(": Huge pages not freed!\n");
+	} else {
+		ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
+		ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
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
+}
+
-- 
2.43.0


