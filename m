Return-Path: <linux-kselftest+bounces-35096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D762ADB639
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E08E3B8035
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1862868A5;
	Mon, 16 Jun 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XtWjUl0r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F51128641F;
	Mon, 16 Jun 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090056; cv=none; b=R1umfLe6pt+DhnGJSuh36vyKt79AnzJoHD1TngFRVgtvkSzS309L9kePLo/dYDlb6Tzzl3/nr54UFWumulhcDhdZn2e5p4Na6xA5UPCzJx9G9wBVszsKun3rn/2gNI3kPy7wRH2B6Moau8zGEvoNOMv9Nmxnwq7kp71hQg70rMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090056; c=relaxed/simple;
	bh=Ja0mSxvul1qAPjO3+U+wyJO9DIdCThtiADXRlbc9cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCefhQzjdMyR6iGGVkR/mpZV0diSTS48IiDQkHqZK9ZL3O+u++q15lcK5jPvB2L5HoLCd/VdxbKz1vhxO10t8efjx9hTHzw7ZVyx0orSrlaJ9e1SyrhK6Gv0P08v1cD1wMprPkvEIE/cuWRtOOmrVy/U+0Zd0RM4ZEWYCwE8aIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XtWjUl0r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8IfSg022514;
	Mon, 16 Jun 2025 16:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HTcV/GTHirCIHdbLS
	qr3LUlvn8RXjF12dUqklXWyiKE=; b=XtWjUl0rUDJlQiCic7wYwcoiZRfUviJHB
	yVY1KlXjcNObWpOBDQeF4CWR29dCJGZ4RVnTSCbZR6qXdGBO6WHJkj6LGmlt7r6G
	LNbuh/j5TR9wRaxNgv259N/TLSQw6CWqxjnyrRC1J3wZCM7yUANP140ojlloDB/S
	D72ws14gD93eAnZc0YJKgBwS5xgyK8Tqf658AQXF4v9/Ctp5VX+CBCRMMQLhV/CF
	8RVigu7NvlpMDvPD2v/ZcvwFknck8ou7cV/K9pP2oGc+aHdZX1AAu+cvWV8WwV3k
	gMiNVilOfCPITg9qIMefee9QHNlzFgLpExrB2hg7tvs87KvxMhoVw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790s4axm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:07:11 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55GFv3An001705;
	Mon, 16 Jun 2025 16:07:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790s4axkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:07:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GDEcE2025763;
	Mon, 16 Jun 2025 16:07:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 479xy5n0nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:07:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GG75YM53084520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 16:07:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D20FF20043;
	Mon, 16 Jun 2025 16:07:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B67220040;
	Mon, 16 Jun 2025 16:07:00 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com.com (unknown [9.43.33.110])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Jun 2025 16:06:59 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH 4/6] mm/selftests: Fix split_huge_page_test failure on systems with 64KB page size
Date: Mon, 16 Jun 2025 21:36:30 +0530
Message-ID: <20250616160632.35250-5-aboorvad@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEwMiBTYWx0ZWRfX7dhMgrcoztq8 VAUyHH/b2nTlwCVpK0BzP3SGBZrmTLJeWLn+c05yjZMMMBW+K0tKHGVkJA/0LE7w8SrNAXX90U+ kxakpQP01uOyEhlhtiYz5x5T59X/yJulV/QiYhd1lUPo1eyTC+dqPyrTs025giJqKByjfatiAOu
 CB79FGmTeUe/PN4pPQV9F/vW5IH7832DEnr6Qq1+fvyTaS5etYd5Z83vSpTbBf/BOcnyaKEQA6U m36tbjhu0cfR8CzkgrCOmtRR/AvHrJaW1NziX2nbVl5mFaXwsI6S2AfaB7Po152Nu8Dt0+O95iN Sp3LUt87czNMhExTdP8iYWW6AeU4+MxP4dFq5N5mz1aFrOyHlkj4pggffx97ZEaHqWPFwg0gt2w
 LBnVBj2HESUflNr1IW8d0sP60rtziW41gXPmuXp0tkshHgPdQXvHPmvNss860Oqbfg+dY41s
X-Proofpoint-ORIG-GUID: X3VKnlnOrk1z4Z50R-aErujIVFdVNSrn
X-Authority-Analysis: v=2.4 cv=Qc9mvtbv c=1 sm=1 tr=0 ts=6850412f cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=tuUElCKEKN7k3CmPoYkA:9
X-Proofpoint-GUID: s_E1h5Ed_1QzAb0WKlS1LVDaA9tCsvUg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160102

From: Donet Tom <donettom@linux.ibm.com>

The split_huge_page_test fails on systems with a 64KB base page size.
This is because the order of a 2MB huge page is different:

On 64KB systems, the order is 5.

On 4KB systems, it's 9.

The test currently assumes a maximum huge page order of 9, which is only
valid for 4KB base page systems. On systems with 64KB pages, attempting
to split huge pages beyond their actual order (5) causes the test to fail.

In this patch, we calculate the huge page order based on the system's base
page size. With this change, the tests now run successfully on both 64KB
and 4KB page size systems.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 .../selftests/mm/split_huge_page_test.c       | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index aa7400ed0e99..16f3e5b9ce6d 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -514,6 +514,15 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
 	}
 }
 
+static unsigned int get_order(unsigned int pages)
+{
+	unsigned int order = 0;
+
+	while ((1U << order) < pages)
+		order++;
+	return order;
+}
+
 int main(int argc, char **argv)
 {
 	int i;
@@ -523,6 +532,7 @@ int main(int argc, char **argv)
 	const char *fs_loc;
 	bool created_tmp;
 	int offset;
+	unsigned int max_order;
 
 	ksft_print_header();
 
@@ -534,11 +544,14 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(1+8+1+9+9+8*4+2);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
 	pmd_pagesize = read_pmd_pagesize();
+	max_order = get_order(pmd_pagesize/pagesize);
+
+	ksft_set_plan(1+(max_order-1)+1+max_order+max_order+(max_order-1)*4+2);
+
 	if (!pmd_pagesize)
 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 
@@ -546,20 +559,20 @@ int main(int argc, char **argv)
 
 	split_pmd_zero_pages();
 
-	for (i = 0; i < 9; i++)
+	for (i = 0; i < max_order; i++)
 		if (i != 1)
 			split_pmd_thp_to_order(i);
 
 	split_pte_mapped_thp();
-	for (i = 0; i < 9; i++)
+	for (i = 0; i < max_order; i++)
 		split_file_backed_thp(i);
 
 	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
 			&fs_loc);
-	for (i = 8; i >= 0; i--)
+	for (i = (max_order-1); i >= 0; i--)
 		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
 
-	for (i = 0; i < 9; i++)
+	for (i = 0; i < max_order; i++)
 		for (offset = 0;
 		     offset < pmd_pagesize / pagesize;
 		     offset += MAX(pmd_pagesize / pagesize / 4, 1 << i))
-- 
2.43.5


