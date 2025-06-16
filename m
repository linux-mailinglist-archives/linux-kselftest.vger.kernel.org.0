Return-Path: <linux-kselftest+bounces-35097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3B9ADB634
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC171890396
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB640286D52;
	Mon, 16 Jun 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j8XE/fBO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F420216E26;
	Mon, 16 Jun 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090063; cv=none; b=Z0mkIGIAr6+vVjPeUI7Z/JofAlV5NReVkvl701dqgTx0Tfuf4PjoQMJkHtnvtfI7N0FTRF0NwmsN6UpBNBeTYbl2jL4kU0FDs8lYx7e7usvOOuVmM3R8SYXoDQxzQT40B7rBckpKfH5itAG8506TrlY0X3bmYw8cJZI2yTzwR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090063; c=relaxed/simple;
	bh=6oBImwHMBqQcPTOAg9gxezXSgn0/TxHdW1u/XkdravA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/viA4ik3yuILb29KYu4OzukvjEZDj5LDG3uQixiFb7diAWqFfNA8lpaA47Eq92mX8I6paepKuE5FezY2b5GwSXhGbXBTuaS1sQn2Cn8o3FMRPWQ4MDbH1oeC5dJtYR9zZdTBRVoIbvhunqmjJEjyuJnlwDtkb/paOc62cITauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j8XE/fBO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GCW689017455;
	Mon, 16 Jun 2025 16:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nH9dt8z0VyAEMb1Zc
	zxG+YsmobDeOns6AKcYFv+gtvU=; b=j8XE/fBOXpk7jw+yqg8i3YBFb2XWl+hxC
	+E65t/IXuliJbfjb6wW8YGLdNizLNPBFjLkZin+N9b1/OHp5jzZhlclJxJZ7890p
	W6U4SEtv0DJz+cIhdBbXB6Vs0WH+5l6CFxdHstoFr2rlzlXFs1rIbbMZSiIsbLxW
	JQtgBijzy1hCoKTkS1DMXlvtbqqkduDHTLDAHv1V2PU1OLVIyM/HP2lraPhHJaqX
	767c52iTb7+vxAk2IH7E7uKgbnc3Hyio4exX84aFC3b4FkguDLaJu1ycJhcku0+o
	PCIH+8Bbxejsi1SKq61v4VqC1D+p46YgZWKpUiHva2EdR4fyPnFyQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qp1x1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:07:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55GG0BYJ023302;
	Mon, 16 Jun 2025 16:07:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qp1x18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:07:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GEWnwk014115;
	Mon, 16 Jun 2025 16:07:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p426hfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:07:15 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GG7Csq51249434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 16:07:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09DF920040;
	Mon, 16 Jun 2025 16:07:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5306E2004B;
	Mon, 16 Jun 2025 16:07:06 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com.com (unknown [9.43.33.110])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Jun 2025 16:07:06 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH 5/6] selftests/mm: Fix child process exit codes in KSM tests
Date: Mon, 16 Jun 2025 21:36:31 +0530
Message-ID: <20250616160632.35250-6-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616160632.35250-1-aboorvad@linux.ibm.com>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BPObgMJtaOVtje-umRyDLgbspwMrVjKs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEwMiBTYWx0ZWRfX6nTrU1NLvTfU 9FjQwT09hi5sewxcscv1y89bMcsvFk/j0JjTaG9sOUlhAtzy/RYw3L0BfUiVWkjQQ3hwdUa4fuU AAhw7zqzqvc4dgNAf8kNaoRuPez4HlDM1OX7icV6eZfX3rAyhnaIcIKVYOic+688JKVGuez0St0
 iFfoQiCw+EvflimcUrNEP5UQB3rnEN+yVu2A8k1c4fRgmzE0p/DQDItZ1V6fdv1fW9d3OhkQ8Ps sxsy8rxl4c6bjEhRlVb9rrOMResD07P4cOXBXdNipJVLJRMqPbKvI2g0WdtIJsQtBZsHHdBP2QL jVfvzzzkmWh4D+HS1Wcn/rnzdrwQ/1ioOfG3+CoL91QhHDFoAuSz+Yprj5d0vLSNImKuvHb5joc
 SeAgkJLEK5qVCZ/POddfguTYTG2QaaH0GPC35CG8x5IdC5IjPDvtyFqpY/X9Kvg+7fcCz6hI
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=68504135 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=103AOF-ep-hNQpW6YsQA:9
X-Proofpoint-ORIG-GUID: 84_LTdBoX5QKoTcTK_OS2now3pT3bfQg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160102

In the KSM functional tests, test_child_ksm() returned negative values
to indicate errors. However, when passed to exit(), these were
interpreted as large unsigned values (eg, -2 became 254), leading to
incorrect handling in the parent process. As a result, some tests
appeared to be skipped or silently failed.

This patch changes test_child_ksm() to return positive error codes
(1, 2, 3) and updates test_child_ksm_err() to interpret them correctly.
This ensures the parent accurately detects and reports child process
failures.

Before patch:

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

After patch:

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

Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 tools/testing/selftests/mm/ksm_functional_tests.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 6ea50272a0ba..230c21c72f3e 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -488,14 +488,14 @@ static int test_child_ksm(void)
 
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
@@ -504,11 +504,11 @@ static int test_child_ksm(void)
 
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


