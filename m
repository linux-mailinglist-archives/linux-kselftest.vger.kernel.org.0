Return-Path: <linux-kselftest+bounces-15644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01F8956C8C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 16:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C104284B80
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163F416D306;
	Mon, 19 Aug 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="He2Rej/S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB81EB35;
	Mon, 19 Aug 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076059; cv=none; b=QZT0nN/fkOdEq3fULf1qcywJqu8M1EWdK2OUtt7jgkgef0NOPfC8TQ6cVvcw4PkV+C9+b41n/JrPz6hCCldKhUfa9HlKrC1YD+CpsugwhTysW+056jiDlfKIyDYU8QzfP2rS2wr9MV5070bO7o8v/TrL/nv96dnASSCoBre6odM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076059; c=relaxed/simple;
	bh=99YTwNx3Ircl0pcKPo6DUFHvOqmIICGUok5HJMaJwf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDjjT8+XGKIfZ088Rb9dlTCrZEQCsu3Ok7WiMsjMUN2bMVAM8kIyROfUvpNDlDY64WhATQXEH+3PGwFylhAJbaJYeRSqZLbwc3npDo2m0EfjJRpH6oMVXe3C8uzPNfa335hXp/7A7tPLSgDEzp/KcTXf70Ae0+95hKKIU4qP4cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=He2Rej/S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J8pTFU010622;
	Mon, 19 Aug 2024 14:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=eIFZBZjBe5x1d
	k7WDORYCs5xSswWGzIz+ui7GbpBcJs=; b=He2Rej/SK96s2Krp86SddumnhOzQB
	xDAmVyZFKFkJHLutHtQTw9xqQLw3/xWfhEhmv7P6agRhH4m2BnSvc4s7pC3wn5dT
	oUjMiD4zpjlA2X4pbshtdjR3fhRBFpobXAM1ebRaR41bkkdOAOzJ5yE5dl/wXd39
	0RaqVybezczmqk029dAXq5VYR8ubC0IZv/7AN5r7Kja//fcHPrFTIHJ4g2JSeXkg
	sVSSrBquKr4QwkxRUWGmbsZS4lz196tX03dRs7AZO4tRbptAnhiuEZiwPyEn1ziB
	JpMRS1RLv9K9PezTYru7j7sylHbIUV/o7Gdc/HsAPiN7ckj2Yb0Lbv0kQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5h2cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:00:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47JE0qGk024757;
	Mon, 19 Aug 2024 14:00:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5h2c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:00:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JDAAx6014176;
	Mon, 19 Aug 2024 14:00:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4137pmpa5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:00:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47JE0jjr51446078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:00:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A3962004B;
	Mon, 19 Aug 2024 14:00:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77D8620043;
	Mon, 19 Aug 2024 14:00:45 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Aug 2024 14:00:45 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com
Subject: [PATCH v1 2/5] KVM: s390: selftests: Add regression tests for PRNO, KDSA and KMA crypto subfunctions
Date: Mon, 19 Aug 2024 15:54:23 +0200
Message-ID: <20240819140040.1087552-3-hari55@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 3gD_IJhZGzQx7qMGzvb-oO3KcwpjUwmU
X-Proofpoint-GUID: jAukbrI3Y9hXAHN50M61Nfe-PQfd6kt2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_11,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408190090

Extend the existing regression test framework for s390x CPU subfunctions
to include tests for the PRNO (Perform Random Number Operation), KDSA
(Compute Digital Signature Authentication) and KMA (Cipher Message with
Authentication) crypto functions.

The test procedure follows the established pattern:

1. Obtain KVM_S390_VM_CPU_MACHINE_SUBFUNC attribute for the VM.
2. Execute PRNO, KDSA and KMA instructions.
3. Compare KVM-reported results with direct instruction execution results.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Hariharan Mari <hari55@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 .../kvm/s390x/cpumodel_subfuncs_test.c        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
index 45add61cba91..c2ae5b270f50 100644
--- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
+++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
@@ -37,6 +37,48 @@ static void get_cpu_machine_subfuntions(struct kvm_vm *vm,
 	TEST_ASSERT(!r, "Get cpu subfunctions failed r=%d errno=%d", r, errno);
 }
 
+/*
+ * Testing Crypto Perform Random Number Operation (PRNO) CPU subfunction's
+ * ASM block
+ */
+static void test_prno_asm_block(u8 (*query)[16])
+{
+	asm volatile("	la	%%r1,%[query]\n"
+			"	xgr	%%r0,%%r0\n"
+			"	.insn	rre,0xb93c0000,2,4\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "r0", "r1");
+}
+
+/*
+ * Testing Crypto Cipher Message with Authentication (KMA) CPU subfunction's
+ * ASM block
+ */
+static void test_kma_asm_block(u8 (*query)[16])
+{
+	asm volatile("	la	%%r1,%[query]\n"
+			"	xgr	%%r0,%%r0\n"
+			"	.insn	rrf,0xb9290000,2,4,6,0\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "r0", "r1");
+}
+
+/*
+ * Testing Crypto Compute Digital Signature Authentication (KDSA) CPU
+ * subfunction's ASM block
+ */
+static void test_kdsa_asm_block(u8 (*query)[16])
+{
+	asm volatile("	la	%%r1,%[query]\n"
+			"	xgr	%%r0,%%r0\n"
+			"	.insn	rre,0xb93a0000,0,2\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "r0", "r1");
+}
+
 /*
  * Testing Sort Lists (SORTL) CPU subfunction's ASM block
  */
@@ -72,6 +114,15 @@ struct testdef {
 	testfunc_t test;
 	bool facility_bit;
 } testlist[] = {
+	/* MSA5 - Facility bit 57 */
+	{ "PPNO", cpu_subfunc.ppno, sizeof(cpu_subfunc.ppno),
+		test_prno_asm_block, 57 },
+	/* MSA8 - Facility bit 146 */
+	{ "KMA", cpu_subfunc.kma, sizeof(cpu_subfunc.kma),
+		test_kma_asm_block, 146 },
+	/* MSA9 - Facility bit 155 */
+	{ "KDSA", cpu_subfunc.kdsa, sizeof(cpu_subfunc.kdsa),
+		test_kdsa_asm_block, 155 },
 	/* SORTL - Facility bit 150 */
 	{ "SORTL", cpu_subfunc.sortl, sizeof(cpu_subfunc.sortl),
 		test_sortl_asm_block, 150 },
-- 
2.45.2


