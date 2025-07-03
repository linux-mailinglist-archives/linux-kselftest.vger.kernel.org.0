Return-Path: <linux-kselftest+bounces-36395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66191AF6A13
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F154E313D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 06:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0928291C3C;
	Thu,  3 Jul 2025 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XAsR6yuP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8BD2900AA;
	Thu,  3 Jul 2025 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751522878; cv=none; b=Ye3rdc+eJmQ7upSrMyNNUihOBrBMmWbevx4Jp36BrCewbSD2/99zp88pHpHpHVce2fUDO88Tga5J5rTEOT4rd0PCAHAtUzHx4qzTSCoc5JneGzNPN7ZCy6P67ts+jDhx2mAOoGSv62YfnZjdw0eeEbC3qfjUjBYOX5Fah7JoNf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751522878; c=relaxed/simple;
	bh=xffQR6XtmI/H8A1ynAKKmbQlZwiRQq3VZ+lSMaP4An4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ezbn/a4hTLllrJKO4sKLAOYBOPT3eT5Id4fznzwcb/EvGbcJVGO+8HjvSKSlAu4Y+6nvAEcuwBTujfvF/t6zVRXLdmEt4ZEnTRz6xUWfTgj+pMb/dnOlpwtj2EKgnvyQ1Cs9n8QvSedLQUWwVffn0gZp2XSAEJ4e3lAoOkvn2NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XAsR6yuP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562IopE6006998;
	Thu, 3 Jul 2025 06:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VDWyXk2omXrjUS99H
	db3lCXn8WFctyIkgn3MVqYwmnk=; b=XAsR6yuPgYoD20HyVM5AFFL9zrrrlCYZS
	xc+G2RtSDKwf762xgoqOJZEiEMyWE5eiFIG+JS8lDHAP16mGPkxy20LIRW9JcPgt
	t5RbOPEco68CunqFkmRF6Y/IXJeK5TCqU0HIbrlaDWYFg7pDuu5erbiw3ZzbqRRQ
	PZ04QEk/z3H5+yWt0LniakPvTcESanmZ91roKBQ0SNoRnVfnXUZzKQy3c30c6GGB
	VMnYk2aKQB31PYAJIKj1R3ZvYyetDQ3iz1EMdUz2KbS4MZQUkCyqobR/i0Zs5rZV
	typF0fYYTOQu53TMM4wsOataRW7W8wwqzEWFQfVdi+1OrwtqICzSw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dhtg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:40 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5635swDI002744;
	Thu, 3 Jul 2025 06:07:39 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dhtg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5634Tn5V021112;
	Thu, 3 Jul 2025 06:07:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtqukgkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56367Z2Q35652126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 06:07:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 184F420043;
	Thu,  3 Jul 2025 06:07:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAA1120040;
	Thu,  3 Jul 2025 06:07:29 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.39.26.205])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 06:07:29 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v2 5/7] selftests/mm: Fix child process exit codes in ksm_functional_tests
Date: Thu,  3 Jul 2025 11:36:54 +0530
Message-ID: <20250703060656.54345-6-aboorvad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 3U-eNkLO9m5wqYelp7ePBLIn-dt9sL5B
X-Proofpoint-GUID: ipEo3pKlPSd_UHlIWwQZyB_HGuBjTw3x
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=68661e2c cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=LodmC_IXZg0r39vkjIAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA0NCBTYWx0ZWRfX/jvABfPkIcvQ f8i3H01IqT6gKUS5hk44lSMHZ5ga2kOtAAJdia+g2BA4z8ftDxhWTGY+joYvy4fNbOYPynTI7F0 J3+sSzkP89ofob7lmKE0i+KG1/UUX34GoUA+lhyEkdKwBOpvnELx25EToqpNVthzI9bZMe4siQN
 vjEBRrwzgivtRo1/YQqZF0nKWauGSVwd3UGJjKmEqC0DM2kHIt9kJrALVf4jec5a41h1L0CX7Bc 2ShSHCuBeNe/ivMRmImGeGls5/s+oz/m/kS3aparJDCwMbIIkafX4Tz15A6g605H5Kz8WQH18Fy LNOICMoi+xdIwJvtjJUroMU2OFlQxJTX81Jt5WSDpL3Z7UQ7gobGD6WxOnMSXSQzO4TnHu0p3rG
 XeeiBQTKwJhVPtra+qV9mfO+xqIFHIHvYgEe6VtSJ0j318oh0KJGafKMRYrvtPlZhnlM8WiY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030044

In ksm_functional_tests, test_child_ksm() returned negative values
to indicate errors. However, when passed to exit(), these were
interpreted as large unsigned values (e.g, -2 became 254), leading to
incorrect handling in the parent process. As a result, some tests
appeared to be skipped or silently failed.

This patch changes test_child_ksm() to return positive error codes
(1, 2, 3) and updates test_child_ksm_err() to interpret them correctly.
This ensures the parent accurately detects and reports child process
failures.

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
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 tools/testing/selftests/mm/ksm_functional_tests.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 996dc6645570..b080d591d984 100644
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
@@ -528,11 +528,11 @@ static int test_child_ksm(void)
 
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
 }
 
-- 
2.43.5


