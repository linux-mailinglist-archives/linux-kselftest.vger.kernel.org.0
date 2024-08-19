Return-Path: <linux-kselftest+bounces-15645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826EC956C90
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 16:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3841F22448
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C59416D4D1;
	Mon, 19 Aug 2024 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oLawkToS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109C16CD13;
	Mon, 19 Aug 2024 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076060; cv=none; b=kSTfIukrpVTmYpoaadc/yW5eJKjbbXzdvrVj4b+zKawHnmE01Z5qlxqpnMpPuOsUbo5Q3/qpzDlQyYnMn9DKijq8uxmZ/MwDPD02/iSvWdTWXeSfDyBtu4rc/YObz7EtMNDWsSmlkn3qEh/vKFnI8Ind8TEWhp7OLKT/o8124s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076060; c=relaxed/simple;
	bh=RYMgJyAX8d10zP9KDHPgw/anyG5aN3LUAJ4HTsmBg2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJptSURv3gelYjQVnnzLSuad+eQIk+ARgig66mXypesKz+/vv5an+bN3z1OPYn0ZdGvx9OOsABLvQ89yOs6Kp4/QnfWkRT4t4vuu9FsryAvZwlmRFCRY1UsMQHstY/hl4caXowGG/DsnmXpTpKVQYFuVVu6q4dRSzugu1R4lehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oLawkToS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J7kpPD004580;
	Mon, 19 Aug 2024 14:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=w5xiBZc6KFgl9
	V5+6O1ovSS941ZOBbt0WaNb0xQFRbY=; b=oLawkToSnKBMHF/X/5u6uYAPHnMuu
	O3CixJaqAGlwcIJ6IwlRPxKO3bE9/H62g6WYzMLJxle3CP974E4k1T6WLjXW87py
	SlhWUNUamWNh9bW9CU2wodWi/lnM6o5jCFtKWk1sawZ2nXUtOFZlgtSqTZZAZSig
	Zkyo1CALxE6A6DfdHVoZxQGUaBwBY2c611BgZK1g97XQE8wZVjmxdrDothuwxs15
	79ht6IJGOvat3yKh8QZD1kvSr2wyMWrzpCVeNCURoram2lS7TNce9lEK4tMxkY1O
	6FtKTpRkMPck2/dIO+jiqUCPUTCMB1ioKue7zfee6lwAiyUjKsNKXCL+A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1hevw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:00:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47JE0r7B019348;
	Mon, 19 Aug 2024 14:00:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1hevs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:00:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JDJJg2014203;
	Mon, 19 Aug 2024 14:00:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4137pmpa61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:00:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47JE0kSP56623570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:00:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0CD620065;
	Mon, 19 Aug 2024 14:00:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D3082004D;
	Mon, 19 Aug 2024 14:00:46 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Aug 2024 14:00:46 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com
Subject: [PATCH v1 3/5] KVM: s390: selftests: Add regression tests for KMCTR, KMF, KMO and PCC crypto subfunctions
Date: Mon, 19 Aug 2024 15:54:24 +0200
Message-ID: <20240819140040.1087552-4-hari55@linux.ibm.com>
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
X-Proofpoint-GUID: UdF8ayw5MkoT1GjbGJlYQCV0GI9QpbLK
X-Proofpoint-ORIG-GUID: fZFj7OUOdm0TiHg0qnKiywcwTk25m7vt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_11,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190090

Extend the existing regression test framework for s390x CPU subfunctions
to include tests for the KMCTR (Cipher Message with Counter) KMO
(Cipher Message with Output Feedback), KMF (Cipher Message with Cipher
Feedback) and PCC (Perform Cryptographic Computation) crypto functions.

The test procedure follows the established pattern.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Hariharan Mari <hari55@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 .../kvm/s390x/cpumodel_subfuncs_test.c        | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
index c2ae5b270f50..6ef9e855ac65 100644
--- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
+++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
@@ -37,6 +37,62 @@ static void get_cpu_machine_subfuntions(struct kvm_vm *vm,
 	TEST_ASSERT(!r, "Get cpu subfunctions failed r=%d errno=%d", r, errno);
 }
 
+/*
+ * Testing Crypto Cipher Message with Counter (KMCTR) CPU subfunction's ASM
+ * block
+ */
+static void test_kmctr_asm_block(u8 (*query)[16])
+{
+	asm volatile("	la	%%r1,%[query]\n"
+			"	xgr	%%r0,%%r0\n"
+			"	.insn	rrf,0xb92d0000,2,4,6,0\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "r0", "r1");
+}
+
+/*
+ * Testing Crypto Cipher Message with Cipher Feedback (KMF) CPU subfunction's
+ * ASM block
+ */
+static void test_kmf_asm_block(u8 (*query)[16])
+{
+	asm volatile("	la	%%r1,%[query]\n"
+			"	xgr	%%r0,%%r0\n"
+			"	.insn	rre,0xb92a0000,2,4\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "r0", "r1");
+}
+
+/*
+ * Testing Crypto Cipher Message with Output Feedback (KMO) CPU subfunction's
+ * ASM block
+ */
+static void test_kmo_asm_block(u8 (*query)[16])
+{
+	asm volatile("	la	%%r1,%[query]\n"
+			"	xgr	%%r0,%%r0\n"
+			"	.insn	rre,0xb92b0000,2,4\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "r0", "r1");
+}
+
+/*
+ * Testing Crypto Perform Cryptographic Computation (PCC) CPU subfunction's
+ * ASM block
+ */
+static void test_pcc_asm_block(u8 (*query)[16])
+{
+	asm volatile("	la	%%r1,%[query]\n"
+			"	xgr	%%r0,%%r0\n"
+			"	.insn	rre,0xb92c0000,0,0\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "r0", "r1");
+}
+
 /*
  * Testing Crypto Perform Random Number Operation (PRNO) CPU subfunction's
  * ASM block
@@ -114,6 +170,15 @@ struct testdef {
 	testfunc_t test;
 	bool facility_bit;
 } testlist[] = {
+	/* MSA - Facility bit 77 */
+	{ "KMCTR", cpu_subfunc.kmctr, sizeof(cpu_subfunc.kmctr),
+		test_kmctr_asm_block, 77 },
+	{ "KMF", cpu_subfunc.kmf, sizeof(cpu_subfunc.kmf),
+		test_kmf_asm_block, 77 },
+	{ "KMO", cpu_subfunc.kmo, sizeof(cpu_subfunc.kmo),
+		test_kmo_asm_block, 77 },
+	{ "PCC", cpu_subfunc.pcc, sizeof(cpu_subfunc.pcc),
+		test_pcc_asm_block, 77 },
 	/* MSA5 - Facility bit 57 */
 	{ "PPNO", cpu_subfunc.ppno, sizeof(cpu_subfunc.ppno),
 		test_prno_asm_block, 57 },
-- 
2.45.2


