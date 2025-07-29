Return-Path: <linux-kselftest+bounces-38045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BAAB147A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 07:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9498E1AA14D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 05:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007212417FB;
	Tue, 29 Jul 2025 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YG5jNBD+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F723F439;
	Tue, 29 Jul 2025 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767309; cv=none; b=Yy1dDhHxkxqW5rRUtAJk1yVQ6odE9dMtLRPTUKzMuBwX7pQ301NjiySskOVZiaVAz06sBI+PTwmhcbL5/TAAViWV0FpuewdkbwIir+srKl6hml3b3XixhgdzGrnKnH+Edhe30xEDkWPe3+gabm09NnGJI47ndALhepm5Rj8+me4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767309; c=relaxed/simple;
	bh=IfyPx1mzQsb3uICDZEVfxL5ucd++j33JG5nx122uCII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghYMqBt1mo9FkkvglGpwPzzbSzn0NV7JCwY8TwQILvW5XnbFpFw8p1YokHi4mC1MMBw/Pfb/Gs9cSJI3fROoB6ySxaOc/r+1Obr7ry+paTMejAL1Y3QLm3q11+I2eJc3ytLIZFzPPiEdnFGQKTKBiCxJhFVYQ292nQp4nnHUxX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YG5jNBD+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T4Z2fg023071;
	Tue, 29 Jul 2025 05:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=puctAwqoH4VWxfpXZ
	N+AbLrRyBve2Bkehva2Jfypeiw=; b=YG5jNBD+qAllCCb9ayUlxc9LP/SZamInU
	7sa9U72Mpf1s+8LCFACuBULPh0fWRa6uZ5ByPJwPivg5sTyJfLpwLdOnyiG/H7U1
	csLcaWZ3kNjHIOBIahfSF8vy+HVNgCu27qs/7zInSVBAwVpermge71YJ4CqFWZn5
	duTrrBhJJWv+pT3o1ZSbdKMIEZVKQLQgR80YVsgICTc38IY98PV0+5wLcBm7prQ0
	Wm5kcc7fkLSKiW+DiGZQxVox8r72Wj6hrv0HQ4jdIAXRuw5tvvMXwYISgXxpT5ZA
	yi3oKM7kPZTlfbDOuWAbd/mM+GnNGq2PVYp6Y5+0WBjRwLvfoIpOw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd5csvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:52 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56T5NwGV019251;
	Tue, 29 Jul 2025 05:34:51 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd5csvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56T0kdY0006242;
	Tue, 29 Jul 2025 05:34:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjm0twr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56T5YlgL20382006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 05:34:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2782D20043;
	Tue, 29 Jul 2025 05:34:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 674F120040;
	Tue, 29 Jul 2025 05:34:41 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.150.11.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Jul 2025 05:34:41 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v3 6/7] selftests/mm: Skip thuge-gen test if system is not setup properly
Date: Tue, 29 Jul 2025 11:04:02 +0530
Message-ID: <20250729053403.1071807-7-aboorvad@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAzOCBTYWx0ZWRfX9353wI5WPT9p
 0HxgOgUzYLCsRfxNTQ0W04rrUBX8J+IdV+w+scY0HnAUIHbF6CjeI/cTgJaOdXCVuZ43jePd3/U
 nUrriP3j6BKuPwQWS263LxoOSVQRS1+sllaHUmL5GdOKjOLkbDqlr3bBtf1ggcjuDAX898VX+8J
 t3QXKRm8zxp0jsrSgGGUR/njFOBr+DRaSTnW277Jej1oBYpERmcmxaK9vgbwuvKVUymgbZedkI1
 zKRQoLQ/jxfkJZfm6A8RDnLPO/O2PMyYj1VP1iS/zruYAjQgKbwg3aY0kFvMPBAGlMiPwvZKHIk
 2Eg75XtXbsKSU/vHjk4JYr8KoxXggySu24aQUVgrmeMyomakHzlSXHvGUa0mLj/U2BEp3ZDJAbX
 NrDGsBjRStuXP3E2h6hKBNaqoEJtWEDoxZw05RwFm5LifbMUITDfAiDi9cJqD/rwWFXcXBLK
X-Proofpoint-ORIG-GUID: owjdkx3vLbfUBCKN3LeoYoInS9y9NNdw
X-Authority-Analysis: v=2.4 cv=B9q50PtM c=1 sm=1 tr=0 ts=68885d7c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Wb1JkmetP80A:10 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=6zTM3Imc7A7I5ri1M5IA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: uoTHmPnNFgwRGLOFVMlrBynDbJ7dL9bO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290038

Make thuge-gen skip instead of fail when it can't run due to system
settings. If shmmax is too small or no 1G huge pages are available,
the test now prints a warning and is marked as skipped.

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

Reviewed-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Co-developed-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
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


