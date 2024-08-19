Return-Path: <linux-kselftest+bounces-15647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DAB956C96
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 16:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886021C22EBB
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800FA16EB61;
	Mon, 19 Aug 2024 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ruW8GVhG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3227516E890;
	Mon, 19 Aug 2024 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076067; cv=none; b=QQY9RbvqHm1HoVPlt4BLhde9qqzATmJ8fVLX/hl4NwAMbQfa20aAbldooDZu3GQ9+OWkY/kT/pWmx6Lwcu3vRHp0B4JTAY40CBpcBvFrIGXnuyqhYvekdLztGXlWjqJlosJacs7WWq/qd0y0MSXxGyMHThPqKEiJ0uyxW86djiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076067; c=relaxed/simple;
	bh=s1iE6xPMzKFRmhLcLWROW0r/llJKq3e5Izp2wphWybI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEVdHMCsC1NLO1o+nFEKjs40vgaJwcsFe21T4HCf+Zi5GnqN6C256HuaDzILcB6eFx2h5SX7t4hmzG6r7QGxbEG1bq8VFYiZ0Z/35bC0JyJ2msxNqP1VUq8/htxJJnbqxkJYd7X3HQkpQ1e8vYk/GagfXYBa/JMBVWgw78iXMa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ruW8GVhG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JE0ThH006794;
	Mon, 19 Aug 2024 14:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=Q7mFDQQWHBgea
	oXEshsA3gFOlZBODJhgzOd/TyK16qM=; b=ruW8GVhGejiYVXw1SasWZeSkonl9a
	GFyVJp8NPYlOkO2MGLhqaHCeNa4rlv6T/F/m7ytvyoVd0tHGtg30jcUyiuPTeQJz
	CfBhBF4k1ZPmB3e/JkpUk5Co/+ybCTzLQVEXqQgtW9lkxbmf7URi0f2eaeBzmcxz
	D1v9hMBs9B9Vv2lEvUbg/AYMHkUEep9NI8n2+eiTAXZeF/xdJAKe5tYKCIOUsrmr
	MN8t+FcwFscUK3tpfF2TTmkZtumlDeBHeSAXTZzwYRVOjTFE1YydCcYcVSQ0FIEG
	CyuOmy5F4yEoQ/vsdfM0hAaZ0aBFPCxq7nLax4pcqoF5Y/x9LKHtv5Gsg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mcy8n7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:01:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47JE11j8031036;
	Mon, 19 Aug 2024 14:01:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mcy8n7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:01:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JCrLjC019105;
	Mon, 19 Aug 2024 14:01:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376ppcsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:01:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47JE0s5147579454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:00:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 522A62004B;
	Mon, 19 Aug 2024 14:00:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ED4620043;
	Mon, 19 Aug 2024 14:00:54 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Aug 2024 14:00:54 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com
Subject: [PATCH v1 5/5] KVM: s390: selftests: Add regression tests for PLO subfunctions
Date: Mon, 19 Aug 2024 15:54:26 +0200
Message-ID: <20240819140040.1087552-6-hari55@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819140040.1087552-1-hari55@linux.ibm.com>
References: <20240819140040.1087552-1-hari55@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: znkhn4mQ0BmSZgUWvl1xAvKRl3kLRiMq
X-Proofpoint-GUID: 3CFScvYy-Bwq1ZUNjm71HJlDcAb8LVep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_11,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408190090

Extend the existing regression test framework for s390x CPU subfunctions
to include tests for the Perform Locked Operation (PLO) subfunction
functions.

PLO was introduced in the very first 64-bit machine generation.
Hence it is assumed PLO is always installed in the Z Arch.
The test procedure follows the established pattern.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Hariharan Mari <hari55@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 .../kvm/s390x/cpumodel_subfuncs_test.c        | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
index 901c99fe79d9..255984a52365 100644
--- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
+++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
@@ -20,6 +20,8 @@
 
 #include "kvm_util.h"
 
+#define U8_MAX  ((u8)~0U)
+
 /**
  * Query available CPU subfunctions
  */
@@ -37,6 +39,33 @@ static void get_cpu_machine_subfuntions(struct kvm_vm *vm,
 	TEST_ASSERT(!r, "Get cpu subfunctions failed r=%d errno=%d", r, errno);
 }
 
+static inline int plo_test_bit(unsigned char nr)
+{
+	unsigned long function = (unsigned long)nr | 0x100;
+	int cc;
+
+	asm volatile("	lgr	0,%[function]\n"
+			/* Parameter registers are ignored for "test bit" */
+			"	plo	0,0,0,0(0)\n"
+			"	ipm	%0\n"
+			"	srl	%0,28\n"
+			: "=d" (cc)
+			: [function] "d" (function)
+			: "cc", "0");
+	return cc == 0;
+}
+
+/*
+ * Testing Perform Locked Operation (PLO) CPU subfunction's ASM block
+ */
+static void test_plo_asm_block(u8 (*query)[32])
+{
+	for (int i = 0; i <= U8_MAX; ++i) {
+		if (plo_test_bit(i))
+			(*query)[i >> 3] |= 0x80 >> (i & 7);
+	}
+}
+
 /*
  * Testing Crypto Compute Message Authentication Code (KMAC) CPU subfunction's
  * ASM block
@@ -235,8 +264,13 @@ struct testdef {
 	u8 *subfunc_array;
 	size_t array_size;
 	testfunc_t test;
-	bool facility_bit;
+	int facility_bit;
 } testlist[] = {
+	/*  PLO was introduced in the very first 64-bit machine generation.
+	 *  Hence it is assumed PLO is always installed in Z Arch .
+	 */
+	{ "PLO", cpu_subfunc.plo, sizeof(cpu_subfunc.plo),
+		test_plo_asm_block, 1 },
 	/* MSA - Facility bit 17 */
 	{ "KMAC", cpu_subfunc.kmac, sizeof(cpu_subfunc.kmac),
 		test_kmac_asm_block, 17 },
-- 
2.45.2


