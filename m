Return-Path: <linux-kselftest+bounces-35099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5231EADB646
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A211756E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDC0286885;
	Mon, 16 Jun 2025 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="do2b2KRj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A821E216E26;
	Mon, 16 Jun 2025 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090073; cv=none; b=ftSMAS46fmoUS/MMf/iU/sxS+iM0gAycWtPb1yFkaKOpg86dhS27Yu/Ml/Z7/ntERAbHQKn1LYlU78Afx71l+ulik5qnKLWDYkhrzvtOm5TuQLt0R0i4OhBRK0WQR5eD3pd4eIi1+KH3amS50ZDMxzamMmP6ZugUW3XbNSwgS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090073; c=relaxed/simple;
	bh=em+SN0x1mC+IqmsH8A16eJyQWpa6/HJZkosxlgqRp/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8bWpC5Tq5VYAUNhFKn7EbYEEjGH+QaZv57x9xvK7GMFla3G0jtxix6U1Y8ZD131mOWC5cvoyqJQzGfMxV6anZx0z701eAPhaYvUU0MvC3c+1iA/ReZ2rR/X5q0yhK9fArNBKTOqcVQMZL4EG+7MfTocVJDgT6ocaeWFit8zsMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=do2b2KRj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GE1un6015418;
	Mon, 16 Jun 2025 16:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=972LgufYEMp1H43lu
	pR25PdynFvVC6p4emQMxZaEsyg=; b=do2b2KRjGv/Slm6ARz4Xb5dNsrHQFZ6sn
	dAtKcFneef+GVVO4PZVzGhq1UWr6e5N8beuBygUqAfODLDWB0lppOfiiORYksEhu
	lBgwnfb0RXARnhAqFvd9EhJgNFGm2POZq27atDHCU8nbkHVKQulsn+NuPQegCzgK
	VvMlmq9z5G614yjJLInVxtc5kBPhl2uBk1SJ6N6UU/Wdq3RHwQCzCVQ1yUVDqdjg
	L9YuPNcpA6wbyDaKYissrbNAPwEWsTvJiDe5HLPbY/k7wpwbH0mG0Sui5SU97/fV
	MfS8ZOvHeOkkag+HbdkqtsWkySbmSvUIPgrQZHH6+NtEHAWIFcKTA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ktb17n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:07:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55GG7Lis009511;
	Mon, 16 Jun 2025 16:07:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ktb17e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:07:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GCjXvx000752;
	Mon, 16 Jun 2025 16:07:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdnxw7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:07:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GG7IY627198186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 16:07:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BE1B20043;
	Mon, 16 Jun 2025 16:07:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CED520040;
	Mon, 16 Jun 2025 16:07:12 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com.com (unknown [9.43.33.110])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Jun 2025 16:07:12 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH 6/6] selftests/mm: Mark thuge-gen as skipped if shmmax is too small or no 1G pages
Date: Mon, 16 Jun 2025 21:36:32 +0530
Message-ID: <20250616160632.35250-7-aboorvad@linux.ibm.com>
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
X-Proofpoint-GUID: iSOFNF05E8fwKEhb6Rcw-TdIR6yvrmMU
X-Proofpoint-ORIG-GUID: nTHQStWhUi2UJJGFRutxY286VuQT9UkH
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=6850413c cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=zAPJwtp4Tg_ksFu_fawA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEwMiBTYWx0ZWRfX9KS4gU9f3qax fUOP5ygceKQs+cFoLkGjIGhNYPQ1AB60e+jKYcc8ZGzGtrBsFHactIsk4k1+rMOCd9RF3gGRNAg GUsy/SRxSf7ys/5cqFJPJtISxQupD6YdCWlXvqymCeamdEtm9FMmn8rdWtpThOIqGVEiUBIUn1i
 ahG98JwFm702+NND+NA7SX4Atu/nsT9rNGy9pTu+m7UVYoGmG9xwIsv25h7REfBiGmff3nR554K npoBuJLM99k/1WYE9okrY1/0PaByuSdzwKHd7Tpy+vlZEes+xkBz9s9YmDQLgaroAx9EOf3clY1 Uez8R3wwn63hILLXWCzzmr3VgtW2zKA2G0Egnr52Prpcbq4r6YS7WSnY6Osa8VlZ55A0zSeJjfT
 LhvxJVDLA5Joxe2jmBxWpGeTIFV1tmu4hsG/7je2nzfKFYcMxhkV9L2QYprP9B+dvmovYjmr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160102

Make thuge-gen skip instead of fail when it can't run due to system
settings. If shmmax is too small or no 1G huge pages are available,
the test now prints a warning and is marked as skipped.

Before Patch:
-------------------
~ running ./thuge-gen
-------------------
~ TAP version 13
~ Bail out! Please do echo 262144 > /proc/sys/kernel/shmmax
~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
~ [FAIL]
not ok 28 thuge-gen ~ exit=1

After Patch:
-------------------
~ running ./thuge-gen
-------------------
~ TAP version 13
~ ~ WARNING: shmmax is too small to run this test.
~ ~ Please run the following command to increase shmmax:
~ ~ echo 262144 > /proc/sys/kernel/shmmax
~ 1..0 ~ SKIP Test skipped due to insufficient shmmax value.
~ [SKIP]
ok 29 thuge-gen ~ SKIP

Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 tools/testing/selftests/mm/thuge-gen.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index 95b6f043a3cb..cc302a29d485 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -195,13 +195,16 @@ void find_pagesizes(void)
 	}
 	globfree(&g);
 
-	if (thuge_read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
-		ksft_exit_fail_msg("Please do echo %lu > /proc/sys/kernel/shmmax",
-				   largest * NUM_PAGES);
+	if (thuge_read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest) {
+		ksft_print_msg("WARNING: shmmax is too small to run this test.\n");
+		ksft_print_msg("Please run the following command to increase shmmax:\n");
+		ksft_print_msg("echo %lu > /proc/sys/kernel/shmmax\n", largest * NUM_PAGES);
+		ksft_exit_skip("Test skipped due to insufficient shmmax value.\n");
+	}
 
 #if defined(__x86_64__)
 	if (largest != 1U<<30) {
-		ksft_exit_fail_msg("No GB pages available on x86-64\n"
+		ksft_exit_skip("No GB pages available on x86-64\n"
 				   "Please boot with hugepagesz=1G hugepages=%d\n", NUM_PAGES);
 	}
 #endif
-- 
2.43.5


