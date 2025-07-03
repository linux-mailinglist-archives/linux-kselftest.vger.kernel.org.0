Return-Path: <linux-kselftest+bounces-36394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D36EAF6A12
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15D64E31DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 06:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7366E291C0B;
	Thu,  3 Jul 2025 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="grsplI4s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E463D2918EB;
	Thu,  3 Jul 2025 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751522872; cv=none; b=M7DiF0cjv7eu68hMFerqxVMxq8qQAVw5j8qm6IuiDpkdLFNn6BEKRRe6Mfy/0T5SBuUVBlVrm3QPjJwRQQc5Jr6zXwBX0PTtbOP7EEwuWdA1gt2pLtLDZuzI+w1C6sYuEdg11iXSOBz7mCFw1/s2dLx6LNTJczIkvmbCrTvbuIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751522872; c=relaxed/simple;
	bh=IzapdKV2obfkfdZJHCbc1SXKfkHoI0pRVCX+FcVFCf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1Nm1FMXR8uvFb/3SKgK262wkBb4AOEHkWZT0VVIUthQEKTCMRGqOEzaeFeTyMYXLa5PDXR6SWAloYkUHG4YB6yu/kxt8AYc2jTBglsRvXKAwci6KPqL4UY+fB9jQIUveMtxB2RlAasB/s21vS/ZNnJvl5ymTOgYhwJcGPt/PAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=grsplI4s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562JEAHr003793;
	Thu, 3 Jul 2025 06:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WzwP+9sDG+i2wV/yf
	iWzzrWqUy0HiJfsMxt3u5SMiHM=; b=grsplI4sPtuCgzQzjOnxpH7J/4193ic7S
	IsakgE5U/17WwIVXQ+NfmhprlfrUSNKGUmii6T3iqGAfeG69jvdyvjo0OHS/uL++
	oQFVdNkhmyIpPysh9IuqJzLbMyqSVtONo9jwgGDT6LAmMa/H2zbquNSTXjCZtw6E
	8OPDlWLu0No3AETxS/ManvTTjg1rXMZ8NCQu3vc9zJ1kQrlkJobyxjqTtOH49r4A
	12tABR0ncry2/35CXCfKMhHsxvW3wSjTYna9vl7D4Znwd4XYIlc+ezKtFfzBi/6Z
	Cm+WMUyd+xNrpJCcn8OsnJEn4O/UOOA7E9d/prfDeeD1mY+GqLNMw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dhtg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:35 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56360Cc3013739;
	Thu, 3 Jul 2025 06:07:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dhtfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5631n6Fa021928;
	Thu, 3 Jul 2025 06:07:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpuann-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56367TON52953554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 06:07:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CE342004B;
	Thu,  3 Jul 2025 06:07:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0354220043;
	Thu,  3 Jul 2025 06:07:24 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.39.26.205])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 06:07:23 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v2 4/7] mm/selftests: Fix split_huge_page_test failure on systems with 64KB page size
Date: Thu,  3 Jul 2025 11:36:53 +0530
Message-ID: <20250703060656.54345-5-aboorvad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 19o7swHgACqwZUkAOzAHQED58QoBmdqU
X-Proofpoint-GUID: AvOPteWKimfxn-Tf9hFtUKVKH109_3uN
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=68661e27 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=v8RjUI9D9iq2XQVy_EMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA0NCBTYWx0ZWRfX5RsdTM/QzZ7u 8+IpWqxfj9Pzy1qW4rPzKxIJHBH/S3UHSEpa/g+uL4tpYRm5R4UnK53lI3tgjixzxYhfndMeB/h DPW8PKYgDj++nROqEj8X9GH4dw5LKvgmS+UhZPrPFa2AFqxnAgE0m674M/W2uiubmzHBLAr7eDQ
 C7JPVU9NxbmqvxNJDKXEdH3SmHuWzd/jw/fgZlC0lL1dPSLA+3fB5M6WknSTXbb33sZhYn91C9S 0jwQRd8O18cR7F+AgmUDsMjvpfhI0bRp7XDRXcK06TTLFYBH0g0pAgN8AqpBNf35EijkNYnFPkY 8RGDzYZy9sQXvMooSUBpw8Y8aj6HFbvEiJHp0zE4CrmAWAZu/kA0jl23Vj8HZltm1rWwczk2n08
 JK38MsydOXg1lYnUf5qn/4VJlmICitIE4X8WlC2fCLtMbfu456P7x4oQWG7VlBzJY6eI3BmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030044

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
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 .../selftests/mm/split_huge_page_test.c       | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index aa7400ed0e99..38296a758330 100644
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
 
@@ -534,32 +544,33 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(1+8+1+9+9+8*4+2);
-
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
 	pmd_pagesize = read_pmd_pagesize();
 	if (!pmd_pagesize)
 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 
+	max_order = get_order(pmd_pagesize/pagesize);
+	ksft_set_plan(1+(max_order-1)+1+max_order+max_order+(max_order-1)*4+2);
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
+	for (i = (max_order-1); i >= 0; i--)
 		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
 
-	for (i = 0; i < 9; i++)
+	for (i = 0; i < max_order; i++)
 		for (offset = 0;
 		     offset < pmd_pagesize / pagesize;
 		     offset += MAX(pmd_pagesize / pagesize / 4, 1 << i))
-- 
2.43.5


