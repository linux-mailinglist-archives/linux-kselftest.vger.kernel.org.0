Return-Path: <linux-kselftest+bounces-15766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61487957ECA
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 08:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865971C23BEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F4A158A08;
	Tue, 20 Aug 2024 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sJkLOtIX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ECF1586C7;
	Tue, 20 Aug 2024 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137045; cv=none; b=iBp0UVsoOlO+YKW1skJwzHT7LR4MgjooR/Pj23L5JvfAKkiIl39JNWRpZFrShTwm0+PEBPcKwJhX7unvW/YdPvG2l4+jfB4Qk/DN543GMbgp9cDTdZfb4FrI9XPZPH1l5CUFIEFQkA0y05DLnsWaln6mOluyhG3MulHoHAzPAh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137045; c=relaxed/simple;
	bh=hbTwBp53C/Y/ePd7d0MLCwlub95LcuokPBYtFkfj98Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4Ede4/q9/r84Ok5v+6xkVYz27N3RUFdBe/qQddhs+w+sDDQKgfbiLI9VHUTY3xuh+wipgOnkViS+SO+3sLXdEu02F4UW8yp7Q2dcwxX6A6+ZO0imo+spmkO+8gEQ7ItYqaJhrYIWU6Rn8ostYraSPIvn4ggwW6jC5+CqykSSTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sJkLOtIX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JGYPR3013248;
	Tue, 20 Aug 2024 06:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=LJklnqv4LQ+Ch
	TCM7ljrx+rd9Bw9TxrahIKmswxBBtE=; b=sJkLOtIXLIcLSQ33KcwoONFNT++d2
	zXo3hYrlQIOeWFbSFZSGmpeKYe5zl0ZdUvMaK3b5mzvM832dJWv0PxzBGsSK4U3m
	KlcvcHQraHSy4cPPEbdGXViFB/o2mOFK/OklC25ZJ56WCm2LeiYazSxQWuApF7+E
	xOhFJx2TEpR5NMyvG8miUmJk6w+TrsyL0BTiyr0jSqeT5WpU3nGLEV4sD2ZQyKRj
	lwYrWmfk9r6IiVQOrnK4p8Tu6VBaweCGLvayFgDmg7NWExXegMSLcwbQyF0R3ZWd
	441LQarpw1dwHsfHQX/1UvZjp482gefuypCR7HNcyq3SOYwuj9TQpdq8w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbfuud9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:20 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47K6vKVi007123;
	Tue, 20 Aug 2024 06:57:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbfuud6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K2BWg5014176;
	Tue, 20 Aug 2024 06:57:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4137pmskck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:19 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K6vDN555050578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 06:57:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B41762004B;
	Tue, 20 Aug 2024 06:57:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FC8820040;
	Tue, 20 Aug 2024 06:57:13 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 06:57:13 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        schlameuss@linux.ibm.com
Subject: [PATCH v2 4/5] KVM: s390: selftests: Add regression tests for KMAC, KMC, KM, KIMD and KLMD crypto subfunctions
Date: Tue, 20 Aug 2024 08:48:36 +0200
Message-ID: <20240820065623.1140399-5-hari55@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820065623.1140399-1-hari55@linux.ibm.com>
References: <20240820065623.1140399-1-hari55@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jM3G0_Gf3yfG7w0ENMq0Q57ORpb8YUjc
X-Proofpoint-ORIG-GUID: zA-8FOkJ77jbkm1rW-OwLlZdOdI0OHDP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200048

Extend the existing regression test framework for s390x CPU subfunctions
to include tests for the KMAC (Compute Message Authentication Code),
KMC (Cipher Message with Chaining), KM (Cipher Message) KIMD (Compute
Intermediate Message Digest) and KLMD (Compute Last Message Digest)
crypto functions.

The test procedure follows the established pattern.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Hariharan Mari <hari55@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 .../kvm/s390x/cpumodel_subfuncs_test.c        | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
index 1fe4fc709afc..c31f445c6f03 100644
--- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
+++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
@@ -37,6 +37,73 @@ static void get_cpu_machine_subfuntions(struct kvm_vm *vm,
 	TEST_ASSERT(!r, "Get cpu subfunctions failed r=%d errno=%d", r, errno);
 }
 
+/*
+ * Testing Crypto Compute Message Authentication Code (KMAC) CPU subfunction's
+ * ASM block
+ */
+static void test_kmac_asm_block(u8 (*query)[16])
+{
+	asm volatile("	la	%%r1,%[query]\n"
+			"	xgr	%%r0,%%r0\n"
+			"	.insn	rre,0xb91e0000,0,2\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "r0", "r1");
+}
+
+/*
+ * Testing Crypto Cipher Message with Chaining (KMC) CPU subfunction's ASM block
+ */
+static void test_kmc_asm_block(u8 (*query)[16])
+{
+	asm volatile("	la	%%r1,%[query]\n"
+			"	xgr	%%r0,%%r0\n"
+			"	.insn	rre,0xb92f0000,2,4\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "r0", "r1");
+}
+
+/*
+ * Testing Crypto Cipher Message (KM) CPU subfunction's ASM block
+ */
+static void test_km_asm_block(u8 (*query)[16])
+{
+	asm volatile("	la	%%r1,%[query]\n"
+			"	xgr	%%r0,%%r0\n"
+			"	.insn	rre,0xb92e0000,2,4\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "r0", "r1");
+}
+
+/*
+ * Testing Crypto Compute Intermediate Message Digest (KIMD) CPU subfunction's
+ * ASM block
+ */
+static void test_kimd_asm_block(u8 (*query)[16])
+{
+	asm volatile("	la	%%r1,%[query]\n"
+			"	xgr	%%r0,%%r0\n"
+			"	.insn	rre,0xb93e0000,0,2\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "r0", "r1");
+}
+
+/*
+ * Testing Crypto Compute Last Message Digest (KLMD) CPU subfunction's ASM block
+ */
+static void test_klmd_asm_block(u8 (*query)[16])
+{
+	asm volatile("	la	%%r1,%[query]\n"
+			"	xgr	%%r0,%%r0\n"
+			"	.insn	rre,0xb93f0000,0,2\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "r0", "r1");
+}
+
 /*
  * Testing Crypto Cipher Message with Counter (KMCTR) CPU subfunction's ASM
  * block
@@ -170,6 +237,17 @@ struct testdef {
 	testfunc_t test;
 	int facility_bit;
 } testlist[] = {
+	/* MSA - Facility bit 17 */
+	{ "KMAC", cpu_subfunc.kmac, sizeof(cpu_subfunc.kmac),
+		test_kmac_asm_block, 17 },
+	{ "KMC", cpu_subfunc.kmc, sizeof(cpu_subfunc.kmc),
+		test_kmc_asm_block, 17 },
+	{ "KM", cpu_subfunc.km, sizeof(cpu_subfunc.km),
+		test_km_asm_block, 17 },
+	{ "KIMD", cpu_subfunc.kimd, sizeof(cpu_subfunc.kimd),
+		test_kimd_asm_block, 17 },
+	{ "KLMD", cpu_subfunc.klmd, sizeof(cpu_subfunc.klmd),
+		test_klmd_asm_block, 17 },
 	/* MSA - Facility bit 77 */
 	{ "KMCTR", cpu_subfunc.kmctr, sizeof(cpu_subfunc.kmctr),
 		test_kmctr_asm_block, 77 },
-- 
2.45.2


