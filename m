Return-Path: <linux-kselftest+bounces-39137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC129B28A72
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 06:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2A85C8439
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 04:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913101D5CFB;
	Sat, 16 Aug 2025 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PBWlJ1n7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66121B85F8;
	Sat, 16 Aug 2025 04:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755316948; cv=none; b=jjkAE1uWf71+nxRdaF50NOTUk1ATybESZz7NKIbYwkCpIu+Q41mXc6ZLPbKVqTmzckBZwPefe+ph8sICPTIXFDR2MRd4xeHYW39CXucAbk59YbDb8EpthNu1QksdBJypK9CP1PywgNTiA3dDIupVXlrqp9CtD9CnQXCIvZ2I0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755316948; c=relaxed/simple;
	bh=45Ac5AFN9w0PK17yUgtcNfFXcPMDW8RsXyoGxeqx0rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b43wq01RkhEhED/SJnjGSTFi/H6yld2eM/IHKBUL/7GgI77i/GbQ48up2BlL1aJYc6oSoXdczKVVG5Buv0lfaRc/hrPeVCGEmiam4jRCLtwBked9H5VIdfVi/UPP9OvU764peh2IOTXRkYRm/uK2OZYh9HPn8ZtHb2ld4rxQTCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PBWlJ1n7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G3fHa5002575;
	Sat, 16 Aug 2025 04:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eGzWIZiqMaWv4GVzO
	QCi1nMNGqm4yh5E7Pden64lkc4=; b=PBWlJ1n7VktRBBpUGfghIB9xKv/FHKpXP
	ivQnJpUCE9yA7GSm30HXF6o2DrT1X4BtPziOKwi21O/9RXrMdb41h6R0VJIT4JQa
	EijBt7iRsd6s0/gCWqhSqYS6hRR/7w1d/KBsBKemwsi6iaEjUIWnr2bWtkbyRCpV
	V46qp/f4/PAktduhYR8zR9UMujQY+kaYh9HgZ4iG5dAQ2N+ugOdqdW/t0lP7pe+q
	JUBWiWyaBer0HAqdIw7eYotLJ0DqozY+jxKSc6y64nwZrxPggqL3qpilZDkxBX/O
	9OsPuVgGhba2KHRJvF5OLo2e2Hty7khjcGsjzmMH0DoSHU9ib+3dw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhq9g442-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:02:10 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57G40Oi1003065;
	Sat, 16 Aug 2025 04:02:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhq9g43y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:02:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57G1hKqI028582;
	Sat, 16 Aug 2025 04:02:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5nkqqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:02:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57G4244H20775218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Aug 2025 04:02:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 371DD20040;
	Sat, 16 Aug 2025 04:02:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CE9220043;
	Sat, 16 Aug 2025 04:01:53 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.36.5.210])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 Aug 2025 04:01:52 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, richard.weiyang@gmail.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v4 3/7] selftest/mm: Fix ksm_funtional_test failures
Date: Sat, 16 Aug 2025 09:31:09 +0530
Message-ID: <20250816040113.760010-4-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816040113.760010-1-aboorvad@linux.ibm.com>
References: <20250816040113.760010-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N50pF39B c=1 sm=1 tr=0 ts=68a002c2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=yVrA2fujCtLeWmk1P3cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX8pCM/R0SBNnt
 82cyqeqxyMUvnDqpC6Wlz9ftzCjaRXh07IcDhBimcwdlQuUKYEcOawUciRCacNFmuPeZN3AfP/I
 XTARpWxPQA+apLotgcp60tGEucV2cd97RTOOZ19h/xrlmwWWEmNN1+dhmqCXq2jxLD/w8VuyGtj
 2a0zvK2ScMHcpl9HZVlDwDY2iSKMhiFyavxbyeRnLZ9jmUI1iTu2gc2PYb/p1B3OXDU3JpLYUu0
 iqMyH7A/yJdXc1wKbKBYJF5How9/Rk9VOR+51A70ePlmD+xrT03YG7cC2Mw8TCSb6IrGvOx+TDE
 KMzrVOcvEwacjchXe0s09QMTkVrzZfcn1G9iISEvB4AZbLeC9ihR4A1iEccZZ0olJis8H78sn+f
 DwrehoNc
X-Proofpoint-GUID: 4-QCN-rltZBnaB5UUevzv8HjYHCMBP0U
X-Proofpoint-ORIG-GUID: iADUmERIIYRuRT5DyeVXIzSWCbExzVxC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027

From: Donet Tom <donettom@linux.ibm.com>

This patch fixed 2 issues.

1) After fork() in test_prctl_fork, the child process uses the file
descriptors from the parent process to read ksm_stat and
ksm_merging_pages. This results in incorrect values being read (parent
process ksm_stat and ksm_merging_pages will be read in child), causing
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
Co-developed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
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
2.47.1


