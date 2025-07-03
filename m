Return-Path: <linux-kselftest+bounces-36396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17747AF6A15
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C061BC8119
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 06:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6E6292B42;
	Thu,  3 Jul 2025 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dPr3KBWh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E0292B25;
	Thu,  3 Jul 2025 06:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751522884; cv=none; b=jbEdDCrg5khpmxBdnhO6Dyx0WngxntkGT5PL2bvMvyxsDt27HycEBkGtUNj51iwGHDTJBAE/4Fp6AxKhevVvXvadwlgjRb+vBQOWYrrBzGa/YaAxAFKP0D1uDtj3KfU/MhA8fqMNrSFLMZUDo2yE78eryLzTwERMwJhtNhKCA3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751522884; c=relaxed/simple;
	bh=z1qzz8+R3VoVACXFDdDoVSGUO1vQcDjCZIwcpRkIyY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miL1pLumsunxZ3guc46lDqCQO6H+OBOg8UicqbQqFFbB5JxpLJTQYmKTnV4tv9bRmXtoBHoTX787K7o1z0IIzP1IQlASwS6KNVFPvkTMi7NWJG1/ZuUS1N115vfnipukKJAMtsVyFInuK/VCLZ2hjKLncyW5TpOkxNwNLJHgxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dPr3KBWh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562KmGFh017644;
	Thu, 3 Jul 2025 06:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+thMMYZJsoVCkLewq
	kMGLHl3RouhJPJEcXLypUADols=; b=dPr3KBWh8J2wNWTIafTwBiBTxIXp4OUe7
	83IkCQQCkFZH/ajWuuVWTRu2ZQuIxpx/lfE1g7yiB51a7zAzv4XljF/Ba+iEGHDf
	mUX0UFXxHtauOjyFxX6vUIyQAvyzckachpMpo3phT/W3gN88H/ice9mx6XIo5WQy
	1V/dqC2zWOkp1t5/iNosb01GBozKwlzlDQ8ITukiLID+Kt+yU57vwKLo/VedBymm
	x9ysSLuc65QbQsAjdTeT02gh1oEQA++BIY2w4naaLPWG9B8jUudSNf8ZIN+jcvzR
	Dm/rNIcOWMYCFCRmWo1jISZuW83FYwYx8CXmlij1VJvOI1YENfhhg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrsv2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:46 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56365Cp1032752;
	Thu, 3 Jul 2025 06:07:46 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrsv2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5632qaKF006830;
	Thu, 3 Jul 2025 06:07:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxmk4mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56367f0M54985064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 06:07:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D37D2004B;
	Thu,  3 Jul 2025 06:07:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F0E620040;
	Thu,  3 Jul 2025 06:07:35 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.39.26.205])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 06:07:35 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v2 6/7] selftests/mm: Skip thuge-gen if shmmax is too small or no 1G huge pages
Date: Thu,  3 Jul 2025 11:36:55 +0530
Message-ID: <20250703060656.54345-7-aboorvad@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E/PNpbdl c=1 sm=1 tr=0 ts=68661e32 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=BKkNsC1I8dDgxTX2b6sA:9
X-Proofpoint-GUID: 6cRWN5sxyD1J_BU62QiHXTuM9wTEW7VZ
X-Proofpoint-ORIG-GUID: -8nq2TMwybS7ZxSThzCAy9Da_wZA018D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA0NCBTYWx0ZWRfX9UBQpkPhDpPk EkwgaEFTCXSCOHzq2gpMjkhdTfBNdZC/a2un5+jY5REjVSAz/UvylEkNEpgnZMdT2vwikLQj/4i 3/fwX9s79V1W43eJ68PCjPkQiAHgR533BNJyE4HI80wQDPi1QRBVILJn+0ti3KnJIrcKWKmVbaH
 PMYcEezUdGJyh0qM9Gw9aV9w3Z0WtYU1fFfUrrM0uMmPHB8d0PXs5bYj7mtlwMPdvMdQwqQjdyA 47UFkaBf8dkRDPwOlhIlyzceSR8lS5Lmv3xwdR8A3W6QEjd4/VOLUp78gXtsKVqO9kbG4cegC5t qlJBTIc/ToQCIVnetXycEyBpbfvn9vDI2BXSMNyeJA7VyaHqNpugLgqI39tAeRIMZxq9QU9Fwbf
 hoczPnwtFW3qpyJxQXfUkPA/sJFtsxKOcZk3ecjO/zj05CqZDCgnehCXRQq63JkVp+9w6dSh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030044

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
2.43.5


