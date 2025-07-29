Return-Path: <linux-kselftest+bounces-38042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1E3B147A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 07:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2387A173450
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 05:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA4D23ABA1;
	Tue, 29 Jul 2025 05:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q68OZh1w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A764239E7A;
	Tue, 29 Jul 2025 05:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767291; cv=none; b=qxrJ0GePLq7eBOY3NYkAurLGTgQOz+BVsty1jwSPRD6XxvBF80a5addgFy5/hPZKh0N/uVN/UbwM1CuI10xlTg7AoGzar3ZgWC1BHycPi0ihPyV2jchPAXlVlez2Six0F/Zboks7gbr2kkiMjomIldrcpsX1HP3cVDuC8p2KJdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767291; c=relaxed/simple;
	bh=VCtfHOKtSIRreCzxYZiwIQIEBffyPQdWdSpB3O7Tzgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ou0gzf7mQY4cElY9PQglAbgmCpkrF27z7IG/aD0rGIw2eZkMtWVppnDXvYoPyyjUOX/t1MG8/BTflWD1a0FGWAWpfbJIY+jsQbi9hYvobj34mfUQIE8pVehwHY06x75baylwsVMGy2egU4+50cpU6jb6B791TgfLFMnnnjnQOvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q68OZh1w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T4YtD2015088;
	Tue, 29 Jul 2025 05:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=m/9NlFppnJk2tWCD6
	FCj3HKItXmcD1EstRYDoEPYzi0=; b=Q68OZh1wC33E9a38wgn99yqSskAitgjh5
	+BBYyIAREXCuqc2hSEEV51oV/6zGsrRS2Wk4dAmk0Ri73EVBVupyHr88mAT1IHDN
	+U/GfVNXji3NnMloxMqVMCvCIAwcO/s4kp4weBww+T5iY17O5Q4UFayQLcu9iWL9
	jPzAAZfCNs+4qDMcQb2sySF3cqJYJqGN3bFDacLfybiX+DcHucKHdZ6F2iWt86B9
	DLELSWhisJwwhPI6/hDcZXierCAVjxtmDUrticn8kYqZBQEXVO1QfyKOTlyXikvx
	Ru4DP3VCDPOnoat+O8F6puLbmVqPQu5WWa0zTt67/EG2D9+yx2vIA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqmqax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56T5PRxo014173;
	Tue, 29 Jul 2025 05:34:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqmqan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56T3A7uI017969;
	Tue, 29 Jul 2025 05:34:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4859bth6bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56T5YScm42991964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 05:34:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D74320043;
	Tue, 29 Jul 2025 05:34:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A9C520040;
	Tue, 29 Jul 2025 05:34:23 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.150.11.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Jul 2025 05:34:23 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v3 3/7] selftest/mm: Fix ksm_funtional_test failures
Date: Tue, 29 Jul 2025 11:03:59 +0530
Message-ID: <20250729053403.1071807-4-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
References: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAzOCBTYWx0ZWRfX+eP0V8wOhiu9
 C2imVp9UuAmGYTMlNnrjaYv6OOk7L8cUXY7cX81F+YbBwnPAZZVhWofnerO5LciDZO2/mGPAqS6
 Y0VDZijUJwLHiJ50ETGFbXiyl9uqU0dibDIDpT/T2ufSKIgwAVPmoOZDM2oWcLxUacn6dUFc7kj
 uFjCVvEwpOwl7DsEDqGqMDdKRCUlGMUCATscilxSYaviLSkM/QLoJg+5x5luDuPliG1L41zDiVq
 ApyCPAutQxHDQ+aDYAEa3svRsJ/DxlNHdwLdYDIyiqCVdneoPvf4T4AZKCNa+NivLiXOtKMLxej
 A2ulfvsLhZdq59eH6UEPxk2cY+kE6bKNsTv15Yjv5xpKbQPUM+HE+6mG0aMXwBXXD2aVNph/ihN
 36Iqvxe5V4BwilRWvXifMtY7Qt/sNms9ptgVxp6TTyjS/5wqWWqytd2u7EirkJNG3snsmIDJ
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=68885d6a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=yVrA2fujCtLeWmk1P3cA:9
X-Proofpoint-GUID: UlgNgExj7kwVKrdBWYwQ9zAe9iZ_73nb
X-Proofpoint-ORIG-GUID: Dk8DjZlnOnRS8AQEl4JAYMObPGNLId59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290038

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
tests, it is better to call ksm_unmerge during the test cleanup phase.

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


