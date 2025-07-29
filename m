Return-Path: <linux-kselftest+bounces-38043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D3B147A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 07:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DA21AA0312
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 05:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1375C23BCED;
	Tue, 29 Jul 2025 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qVoTHgmh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D490238C03;
	Tue, 29 Jul 2025 05:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767299; cv=none; b=RYfz3TUkG4drT4nlKw9lY5AY+K+iirdbn71VW3TGyvbhOLFwwJ3aWMq0xyRbtE5wZb8QakHPwtPsUjx1m3m/ISxtKXTBYlVm4/1G94FlPu8zCcIc0kjGBpTkFklluXxCDT5slG2ytqoc7GgY+dAwAB/GgsDIdxPY/02tp5BpODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767299; c=relaxed/simple;
	bh=AC1UHEw7emc6yBJaz7owQGrbbZFPRP5+rXFWKOuy92s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tibKvRJiJk8vIIUMscRlL3Uy36BCoPczVuzg0/mHJn7tYvZuq1B482od2/zRwPJW/7PLOltvyxj3WEjBXcQS/Ep5d0KD4pVgrUi6yH/KDFFOmWI9uIv2N5D+Ok+Qt20/P5aIj7XFBOsdnjMoUd/pi4QYjduym8Se9NXqRTGvh5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qVoTHgmh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T4Yu13015119;
	Tue, 29 Jul 2025 05:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bKyTR1Ot8Jfwt64IZ
	+xNyXdgQMQnjFx/c4VyQqIovVU=; b=qVoTHgmhCn23HihT5A/LE26/xHgSQ0LjT
	34FsssChvQh+gvSIrwLaxgoguRtNnSFhVp7pcytxBd/lyGLrAg7aU8+Ko83UzWlb
	B2KRKtS3LUObWqlevA5+Pn5RCm24hzKRigfzOawrsubvUFdTVjus/w7r6Ptb7Tk6
	QmgXWembKDw/rqt0tdcti4iKZZjRk43YPV2nbkq4Mb1TKX4deHo7UIWpviXEqgHR
	Cg7w0OYVxsHSeQgWgqa1SggNEmn/aV8P66SnAYStWeypPVoJ0MaPiHVzBF9KD0nU
	NTDGGexg7tmcvWQZcExJF6ZpRRwXJhyRVLLcsgSpKkfUTiN6I0HIQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqmqbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:40 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56T5Vbnl028107;
	Tue, 29 Jul 2025 05:34:39 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqmqbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56T0njE8006209;
	Tue, 29 Jul 2025 05:34:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjm0tvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56T5YZ7U28836224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 05:34:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE03B20043;
	Tue, 29 Jul 2025 05:34:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BDD320040;
	Tue, 29 Jul 2025 05:34:29 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.150.11.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Jul 2025 05:34:28 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v3 4/7] mm/selftests: Fix split_huge_page_test failure on systems with 64KB page size
Date: Tue, 29 Jul 2025 11:04:00 +0530
Message-ID: <20250729053403.1071807-5-aboorvad@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAzOCBTYWx0ZWRfX637bIYXNeM05
 pAG9qIgL8I5hR2z9PYYuxX9uON9jcIy9j81sV7Hw1bBKiZyl7i85Y8krj+VDNtkPA7lLihp7Lli
 nMosgvuBiLTxnxPXyE5REA1s5pOE736j/2SP5GZufr5x2sWK/EEBSzWh1l2oPjSTO8fTpxMPi3P
 +Ea/P7o4CfWiKnDyJv8ooDNRMqRa5ILUkbuCTvsC36nT5Rv55v4bsSkm2/4KHc93tJGTVYJAjJ+
 pL6UQt3hx7e+7R2XTBkLTDRR4VBM/arsmZ4z7JTStSGInf2UA0ie6Yy0oxLdzqUlS5viQkAWtGt
 kKM69Mspx7vkJ3LA/FZOV0fqmTyobvo7YyAT+kiOAt9nCXhEtXX9QAz9mG5TJzi35kV78O+47K/
 uZzl1+cjEWLGTTsm4j0BBflASGICRGVP/zrJsxWsNNcWqf1ilauOMLya6a9PA0S7httcPzZ8
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=68885d70 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=Ikd4Dj_1AAAA:8
 a=Ru4QYyaz7G1s0NU_3jQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: NjWfK-2Nnucekirter-ZB5ogg10fyL8I
X-Proofpoint-ORIG-GUID: 1u_ZU51q9Vw5TIEhIXZSaKBNfmrphp30
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

Fixes: fa6c02315f745 ("mm: huge_memory: a new debugfs interface for splitting THP tests")
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Co-developed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 .../selftests/mm/split_huge_page_test.c       | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 05de1fc0005b..718daceb5282 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -36,6 +36,7 @@ uint64_t pmd_pagesize;
 
 #define PFN_MASK     ((1UL<<55)-1)
 #define KPF_THP      (1UL<<22)
+#define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
 
 int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
 {
@@ -522,6 +523,9 @@ int main(int argc, char **argv)
 	const char *fs_loc;
 	bool created_tmp;
 	int offset;
+	unsigned int max_order;
+	unsigned int nr_pages;
+	unsigned int tests;
 
 	ksft_print_header();
 
@@ -533,35 +537,38 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(1+8+1+9+9+8*4+2);
-
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
 	pmd_pagesize = read_pmd_pagesize();
 	if (!pmd_pagesize)
 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 
+	nr_pages = pmd_pagesize / pagesize;
+	max_order = GET_ORDER(nr_pages);
+	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
+	ksft_set_plan(tests);
+
 	fd_size = 2 * pmd_pagesize;
 
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
+	for (i = max_order - 1; i >= 0; i--)
 		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
 
-	for (i = 0; i < 9; i++)
+	for (i = 0; i < max_order; i++)
 		for (offset = 0;
-		     offset < pmd_pagesize / pagesize;
-		     offset += MAX(pmd_pagesize / pagesize / 4, 1 << i))
+		     offset < nr_pages;
+		     offset += MAX(nr_pages / 4, 1 << i))
 			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
 	cleanup_thp_fs(fs_loc, created_tmp);
 
-- 
2.47.1


