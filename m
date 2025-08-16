Return-Path: <linux-kselftest+bounces-39140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39545B28A7A
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 06:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B20AA558A
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 04:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A244B1D86FF;
	Sat, 16 Aug 2025 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rXqJDm6B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C171D90C8;
	Sat, 16 Aug 2025 04:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755316987; cv=none; b=ScM3MN5+YZ9xqxbrS/P5ByQHhutSAOB/Urw6fY2gUm501UMYhjz890PTs1H9khBefMNBHhvW2wv87lozADHaLhf34mooMeMFf3dyslmTh3FvhiAddaxraC8HwK0et6kRpZa6fc5e9Mvgub4jiN0kyZbDDkGz24LQB4//A2aFVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755316987; c=relaxed/simple;
	bh=pVcIhpvJYfVILv4WzC4yMiaLnCC2bnXyMnH6Y2HtHBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhdE0EpsvRE7NGHzIu0fsl6QO/lx5F+5Z08enshZuWgSe8M1ftiEr7L9URWp3hihc1Q56NlZucGEDGO92wdAgQeiAbOKZMbhfIS6m/Q3h5qhVu4AAUz/TRXVd75p7KADU6hgOqvUakeEAfotUiXnJ+nT3zlWiUdKXm/e2YWvidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rXqJDm6B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G2n380021873;
	Sat, 16 Aug 2025 04:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/aBl03vFCknkuawje
	8hxVJ4OWCSUgh09Oa3cpvTw+uE=; b=rXqJDm6BI1Pw/Ulov/hRwro6SJSwOzwBW
	3v3wVJnKSxhuFxt4L0hSkxe6rQW4a/5qUXJionz+6wU91GeFoR2XWj7FdUZBQM4A
	4kXtP3cDUHMhrMSRG3VyVZqzvlfVKlojnsgfrqHA/ELgZM7QrAKjXcHcsAiYbLCQ
	WfTAGfqHMeUTthzSZnGD+/c+4OUJUlGOvdcxkqTnkKVwG6ALOBDLrQoNediImGID
	mPNgKLl64ssC8D03a9DUS6apPfYW0UD/fhJlE0GWkjV+iYQkTRkwU/ca1jpe4fe9
	Qxs6/ypWGQ3eUbwlTo7Kj+ebcdltoipvDZ3K491UjmFViNdE00/iw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhggg4m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:02:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57G42j4G019883;
	Sat, 16 Aug 2025 04:02:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhggg4m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:02:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57G0Yx8K026279;
	Sat, 16 Aug 2025 04:02:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh21kxtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:02:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57G42eHI51446244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Aug 2025 04:02:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F0E820043;
	Sat, 16 Aug 2025 04:02:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 182B920040;
	Sat, 16 Aug 2025 04:02:29 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.36.5.210])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 Aug 2025 04:02:28 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, richard.weiyang@gmail.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v4 6/7] selftests/mm: skip thuge-gen test if system is not setup properly
Date: Sat, 16 Aug 2025 09:31:12 +0530
Message-ID: <20250816040113.760010-7-aboorvad@linux.ibm.com>
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
X-Proofpoint-GUID: a6MP_xSG01_aDuXWt6yFXE7qgCrF2ULW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMiBTYWx0ZWRfX53U75hp/N0hN
 W4VGKczjEXDi1QJ1kq+bJq8dfeFPwJBIQvJkw1cdVub+G4g6S5IyeD5TIRCrx71D3Mv3KKSrMSA
 hANkhXytBT1f75SG2A48QngNFpX3HIWbXUJ4u6eY4XsYA0j7VGzV06dB9bSgG1XN11RtcApEyXb
 wduOaQaIeQ/HrmGGlibV8lv0ZA7i9wES5c6CBhde2GHMIRdZeEIIt4c4Z9tv+WeugSRTvLMDnVr
 +jqLGVELocPkAC67JeVIb8hHwFeY4GNHzSBORQVG5rFeilsWHeBRS70pUEqkyQpQFpLiqtCiaio
 vzsOIHYToDIQ7d3eZ7MsWbV9Q5PUJKudVAlhJqSPeqVKTfnAL2StwjjzU6dzOtgZqo8ztCPpgBM
 LVykbSKX
X-Authority-Analysis: v=2.4 cv=XOUwSRhE c=1 sm=1 tr=0 ts=68a002e5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=9-ECl0np4EkliaZUNCgA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: if8lV-oYGlA0Z2T0D5dhKpwFf_cTXoTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160022

Make thuge-gen skip instead of fail when it can't run due to system
settings.  If shmmax is too small or no 1G huge pages are available, the
test now prints a warning and is marked as skipped.

-------------------
Before Patch:
-------------------
~ running ./thuge-gen
~ Bail out! Please do echo 262144 > /proc/sys/kernel/shmmax
~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
~ [FAIL]
not ok 28 thuge-gen ~ exit=1

-------------------
After Patch:
-------------------
~ running ./thuge-gen
~ ~ WARNING: shmmax is too small to run this test.
~ ~ Please run the following command to increase shmmax:
~ ~ echo 262144 > /proc/sys/kernel/shmmax
~ 1..0 ~ SKIP Test skipped due to insufficient shmmax value.
~ [SKIP]
ok 29 thuge-gen ~ SKIP

Co-developed-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 tools/testing/selftests/mm/thuge-gen.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index 8e2b08dc5762..4f5e290ff1a6 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -177,13 +177,16 @@ void find_pagesizes(void)
 	globfree(&g);
 
 	read_sysfs("/proc/sys/kernel/shmmax", &shmmax_val);
-	if (shmmax_val < NUM_PAGES * largest)
-		ksft_exit_fail_msg("Please do echo %lu > /proc/sys/kernel/shmmax",
-				   largest * NUM_PAGES);
+	if (shmmax_val < NUM_PAGES * largest) {
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
2.47.1


