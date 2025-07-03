Return-Path: <linux-kselftest+bounces-36393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6EAAF6A10
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4EF1BC7865
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 06:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938D5292B35;
	Thu,  3 Jul 2025 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qUoZ6nbT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA074292906;
	Thu,  3 Jul 2025 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751522864; cv=none; b=BPrwP6M44SkottmZBIAagD/NRCPFwg4sDeILYtUlfSi/zU/uqHblVSUaDHQq4KANqCjvtNXYAQB/pSkP/0sAAwUV4XngnGcs312w9Dz8BdoJtwAH08vOfkd9kwULSkQes+p1uE77529xKp9pPsj1K0cmq5pvWxlGJVhmKooZw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751522864; c=relaxed/simple;
	bh=st9AZr9FBinirERjQRkt+KuQ/Y60pXmEZ5EyAPLbcck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHaglP5dbuuB9Q8ZYQz0aSYsmS/WdMDAO5SWLajeKiFheOkmyBN/1wD+gXvZ3uXAEIiwICtxI4Egfe5D/4Fb+bfk2kDcw20KVumXzcwtU9XbTtUIbA4WE7J09Xoyow/p9AuHGyLh8x8D7rGODcLZrnm7Y9+acGtmH+eFkyu1R0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qUoZ6nbT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Mwk9t019240;
	Thu, 3 Jul 2025 06:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8SoKOth7WukoanuC5
	O8znHCvWYLEtx3ySqY/SXhmPsc=; b=qUoZ6nbTkVEHuNHsJ4uNSxVHKTpOBe+w3
	0viuNxBR1aS2lpyqgvBM8FO7i02DRr+FkLR+eutqc8kIpsQbwzYAhMQhyhMaSIYx
	TYM6Sk2eZplVo0BsaqQASbV8eYUlrk2l3DvnXIMrRngA2KxvjQgGc6iBt6skkpw/
	refxTesizxL5iYAK3ESnTBSKamywRvHU7d9UwCOLWBYkA80gZrEVCBxNSKa3kT/S
	bD63U0QgBG/G/cXEB42xVuUeU6hgx1giB/U7Mi4WC++xFVbzrw2UZJzO3DhMhWAA
	fMi3pLqmXQsyKx9yHyU92t2Ymr/zvXYCSJ+wWtrFD3aJpXuvePE2w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u21f0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56367Sr2006803;
	Thu, 3 Jul 2025 06:07:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u21f0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56326sO0021914;
	Thu, 3 Jul 2025 06:07:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpuan5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56367Nvt29425938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 06:07:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F3D12004B;
	Thu,  3 Jul 2025 06:07:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E20220043;
	Thu,  3 Jul 2025 06:07:18 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.39.26.205])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 06:07:17 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v2 3/7] selftest/mm: Fix ksm_funtional_test failures
Date: Thu,  3 Jul 2025 11:36:52 +0530
Message-ID: <20250703060656.54345-4-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703060656.54345-1-aboorvad@linux.ibm.com>
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iTBI4fHhg2lWJeei_9P1gtvuTVqJHSRz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA0MCBTYWx0ZWRfXwcuLCf7j22UF 1REt/gZaGtXFFER7Wobn/ZSktMfbDYvvaXy6UDEGk28U/l9HqEZhfrbSwfbtQIRrsqr/D6s9fPw UUl7YJjwRcRdm83SZ/gEielaGEDdlHQMCzQdIIcwhhUr1MJt326i4ygak9Yx0xIJg2VFpDoUTew
 slftQ1CfIEcfcJDdH5xBBjVaOpZFHYnG3Xz+NE9019iThJPnl/NHozl7/kOv1TRPQgyMHRXAJr5 bOYD5DAJhjg1Unc+Yyy+aKr0nsolwKRNdnxgiQsk/AzlMd3cWu1Rg+48unvUMJgbagv7lNG+Hpy gtUtMMKHoq2a3/R2TYdyRj3iqwYtooXMXviXuaJt462clxQBC00T+GOBu+ukjt5wspM8iSBlsxE
 TrIevu5+p3DzOJClOMvnFW+HBG6Gu/8oLWAAhqltkzfXQzvjEJ1O/dTJmmL5PZYMQQSunhQi
X-Proofpoint-GUID: n5Fw5RbeIM-J-jusQvgRtsy7Mlpx99nO
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=68661e21 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=yVrA2fujCtLeWmk1P3cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030040

From: Donet Tom <donettom@linux.ibm.com>

This patch fixed 2 issues.

1)After fork() in test_prctl_fork, the child process uses the file
descriptors from the parent process to read ksm_stat and
ksm_merging_pages. This results in incorrect values being read (parent
process ksm_stat and ksm_merge_pages will be read in child), causing
the test to fail.

This patch calls init_global_file_handles() in the child process to
ensure that the current process's file descriptors are used to read
ksm_stat and ksm_merging_pages.

2) All tests currently call ksm_merge to trigger page merging.
To ensure the system remains in a consistent state for subsequent
tests, it is better to call ksm_unmerge during the test cleanup phase

In the test_prctl_fork test, after a fork(), reading ksm_merging_pages
in the child process returns a non-zero value because a previous test
performed a merge, and the child's memory state is inherited from the
parent.

Although the child process calls ksm_unmerge, the ksm_merging_pages
counter in the parent is reset to zero, while the child's counter
remains unchanged. This discrepancy causes the test to fail.

To avoid this issue, each test should call ksm_unmerge during cleanup
to ensure the counter is reset and the system is in a clean state for
subsequent tests.

execv argument is an array of pointers to null-terminated strings.
In this patch we also added NULL in the execv argument.

Fixes: 6c47de3be3a0 ("selftest/mm: ksm_functional_tests: extend test case for ksm fork/exec")
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 tools/testing/selftests/mm/ksm_functional_tests.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index d8bd1911dfc0..996dc6645570 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -46,6 +46,8 @@ static int ksm_use_zero_pages_fd;
 static int pagemap_fd;
 static size_t pagesize;
 
+static void init_global_file_handles(void);
+
 static bool range_maps_duplicates(char *addr, unsigned long size)
 {
 	unsigned long offs_a, offs_b, pfn_a, pfn_b;
@@ -274,6 +276,7 @@ static void test_unmerge(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			 "Pages were unmerged\n");
 unmap:
+	ksm_unmerge();
 	munmap(map, size);
 }
 
@@ -338,6 +341,7 @@ static void test_unmerge_zero_pages(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			"KSM zero pages were unmerged\n");
 unmap:
+	ksm_unmerge();
 	munmap(map, size);
 }
 
@@ -366,6 +370,7 @@ static void test_unmerge_discarded(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			 "Pages were unmerged\n");
 unmap:
+	ksm_unmerge();
 	munmap(map, size);
 }
 
@@ -452,6 +457,7 @@ static void test_unmerge_uffd_wp(void)
 close_uffd:
 	close(uffd);
 unmap:
+	ksm_unmerge();
 	munmap(map, size);
 }
 #endif
@@ -515,6 +521,7 @@ static int test_child_ksm(void)
 	else if (map == MAP_MERGE_SKIP)
 		return -3;
 
+	ksm_unmerge();
 	munmap(map, size);
 	return 0;
 }
@@ -548,6 +555,7 @@ static void test_prctl_fork(void)
 
 	child_pid = fork();
 	if (!child_pid) {
+		init_global_file_handles();
 		exit(test_child_ksm());
 	} else if (child_pid < 0) {
 		ksft_test_result_fail("fork() failed\n");
@@ -595,7 +603,7 @@ static void test_prctl_fork_exec(void)
 		return;
 	} else if (child_pid == 0) {
 		char *prg_name = "./ksm_functional_tests";
-		char *argv_for_program[] = { prg_name, FORK_EXEC_CHILD_PRG_NAME };
+		char *argv_for_program[] = { prg_name, FORK_EXEC_CHILD_PRG_NAME, NULL };
 
 		execv(prg_name, argv_for_program);
 		return;
@@ -644,6 +652,7 @@ static void test_prctl_unmerge(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			 "Pages were unmerged\n");
 unmap:
+	ksm_unmerge();
 	munmap(map, size);
 }
 
@@ -677,6 +686,7 @@ static void test_prot_none(void)
 	ksft_test_result(!range_maps_duplicates(map, size),
 			 "Pages were unmerged\n");
 unmap:
+	ksm_unmerge();
 	munmap(map, size);
 }
 
-- 
2.43.5


