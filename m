Return-Path: <linux-kselftest+bounces-39139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C55B28A77
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 06:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DAAAE80E4
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 04:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EDD1D90C8;
	Sat, 16 Aug 2025 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cX3gpkWm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D61DDC07;
	Sat, 16 Aug 2025 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755316969; cv=none; b=Ko6suO+qcNdg0KjRIWtwcgpmKk7YrL1MFt6KauzCZ/K1wYpTKnfUHXcUePSifk23fhd4lG7aXwgiG6XdnhafNHXJP0gVsw3NPrND0IOWxCYTtFd/8U8HVvRvzNzIJ+BB/CBzzAJYFYD8ANo5LJBJrreQrgD25cKoDQMsgh6OpQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755316969; c=relaxed/simple;
	bh=zbbVKHlNtdGb4++SbkoTm6z+ngeScGYPfvfvaNeu+nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/aHwTAWA44Z07UYoVgYP9097TBCIsmtP4d0UnnAba2Q+S4FIR/+NJzBGX5D41E+YK1r+fF2xPYm7MLrZaJ9Mc7pw3KJz5Xp2N1mteQ8kNxsHSzjgPCaBq2CTWGbbvtvL0B4VUmUn6i1WnfUeAd2fXrxiwYmLIVVBy3YEVXHnGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cX3gpkWm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G2xJ8F018155;
	Sat, 16 Aug 2025 04:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nHo2SN3gcGzUExjzy
	KYW/0FDFz7FrPaEIlRYkrngvPI=; b=cX3gpkWmwyOa3UaZ7FdMsc/g5S/kPaE3K
	aGotc2tFLjsNpp1PElaPZG+ELj18BtiHiTNYhlOJPxdvG0k4/JXfye2GCX91R7Tk
	pNNgog1oX5vzpO4Qy7UfIw9s8mNQinYZ5TR1dMADVk9EmVVDbriNgAnj9jaqHqhc
	dVt9pV7NPrWx+hiZa7+4vYtAS+hO9t9/HdquO08R0/1KoPSlZ4IwpJq5dMpMA7lq
	k+bSl/1OncLeMdALlNtq+BkjJS5iuAsGA1ItlZBCKfgUB21kNu927KxLB/rIP8qx
	uYX5mnCvXMOlSJSpX1g9iOnOOzzrTHI/+IjhZAiBhfiyFFEbMuqYQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jfdrgf99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:02:33 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57G42XFB000377;
	Sat, 16 Aug 2025 04:02:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jfdrgf96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:02:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57G20xAS028585;
	Sat, 16 Aug 2025 04:02:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5nkqsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:02:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57G42S3053150096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Aug 2025 04:02:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 314C520040;
	Sat, 16 Aug 2025 04:02:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD89820043;
	Sat, 16 Aug 2025 04:02:16 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.36.5.210])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 Aug 2025 04:02:16 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, richard.weiyang@gmail.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v4 5/7] selftests/mm: fix child process exit codes in ksm_functional_tests
Date: Sat, 16 Aug 2025 09:31:11 +0530
Message-ID: <20250816040113.760010-6-aboorvad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: TmCRbYxGb0dZO1krQqFm6IMPizm63qOO
X-Proofpoint-GUID: Wi2bis6C76syRZp2ba6H0tsiN2ypFzRn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwMSBTYWx0ZWRfX+Oe+LBRxCe3d
 1r8z+4/YjhBB3hzbFvUSXxKzOAQPEn6Djp1CtS450SPUoJglpwbEd1uIrGC4+7ojwI043ubwXTA
 NKStX7qWPTQMKBi134X+mHO34xJf27UE4pQCLXhlr7ryrKp5aiTyoVoX0xMPrUNryeT8bYXQm19
 eKplf56tSqQoJuhTZI3abCdgpBM2Lep07Pi1VnIV8qgihhisR0tQ3mw4qA4P1D3XFBgetarAKUu
 4XsP89Gm5cKnbNHekB97h3Z38aOvvH/vS+oQvstYvToXA2bq8tTWivCdUJcyymL2bnGQmRB1A/w
 HsrVvyXgDi9Z+ER85d2aDkTqv84cAoUzL9fP20bCwSgus+m3vhZtXzM0D9sH9aqdisQEn/UK70F
 NUuDDoU6
X-Authority-Analysis: v=2.4 cv=GotC+l1C c=1 sm=1 tr=0 ts=68a002d9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=1sOJkUf8yoZECTHbNm8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160001

In ksm_functional_tests, test_child_ksm() returned negative values to
indicate errors.  However, when passed to exit(), these were interpreted
as large unsigned values (e.g, -2 became 254), leading to incorrect
handling in the parent process.  As a result, some tests appeared to be
skipped or silently failed.

This patch changes test_child_ksm() to return positive error codes (1, 2,
3) and updates test_child_ksm_err() to interpret them correctly.
Additionally, test_prctl_fork_exec() now uses exit(4) after a failed
execv() to clearly signal exec failures.  This ensures the parent
accurately detects and reports child process failures.

--------------
Before patch:
--------------
- [RUN] test_unmerge
ok 1 Pages were unmerged
...
- [RUN] test_prctl_fork
- No pages got merged
- [RUN] test_prctl_fork_exec
ok 7 PR_SET_MEMORY_MERGE value is inherited
...
Bail out! 1 out of 8 tests failed
- Planned tests != run tests (9 != 8)
- Totals: pass:7 fail:1 xfail:0 xpass:0 skip:0 error:0

--------------
After patch:
--------------
- [RUN] test_unmerge
ok 1 Pages were unmerged
...
- [RUN] test_prctl_fork
- No pages got merged
not ok 7 Merge in child failed
- [RUN] test_prctl_fork_exec
ok 8 PR_SET_MEMORY_MERGE value is inherited
...
Bail out! 2 out of 9 tests failed
- Totals: pass:7 fail:2 xfail:0 xpass:0 skip:0 error:0

Fixes: 6c47de3be3a0 ("selftest/mm: ksm_functional_tests: extend test case for ksm fork/exec")
Co-developed-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 .../testing/selftests/mm/ksm_functional_tests.c  | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 996dc6645570..534aa405cac7 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -512,14 +512,14 @@ static int test_child_ksm(void)
 
 	/* Test if KSM is enabled for the process. */
 	if (prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0) != 1)
-		return -1;
+		return 1;
 
 	/* Test if merge could really happen. */
 	map = __mmap_and_merge_range(0xcf, size, PROT_READ | PROT_WRITE, KSM_MERGE_NONE);
 	if (map == MAP_MERGE_FAIL)
-		return -2;
+		return 2;
 	else if (map == MAP_MERGE_SKIP)
-		return -3;
+		return 3;
 
 	ksm_unmerge();
 	munmap(map, size);
@@ -528,12 +528,14 @@ static int test_child_ksm(void)
 
 static void test_child_ksm_err(int status)
 {
-	if (status == -1)
+	if (status == 1)
 		ksft_test_result_fail("unexpected PR_GET_MEMORY_MERGE result in child\n");
-	else if (status == -2)
+	else if (status == 2)
 		ksft_test_result_fail("Merge in child failed\n");
-	else if (status == -3)
+	else if (status == 3)
 		ksft_test_result_skip("Merge in child skipped\n");
+	else if (status == 4)
+		ksft_test_result_fail("Binary not found\n");
 }
 
 /* Verify that prctl ksm flag is inherited. */
@@ -606,7 +608,7 @@ static void test_prctl_fork_exec(void)
 		char *argv_for_program[] = { prg_name, FORK_EXEC_CHILD_PRG_NAME, NULL };
 
 		execv(prg_name, argv_for_program);
-		return;
+		exit(4);
 	}
 
 	if (waitpid(child_pid, &status, 0) > 0) {
-- 
2.47.1


