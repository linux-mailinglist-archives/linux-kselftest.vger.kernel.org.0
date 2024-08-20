Return-Path: <linux-kselftest+bounces-15765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81298957EC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 08:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65D61C21347
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 06:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC6016C696;
	Tue, 20 Aug 2024 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UANEtyxJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7173F16B723;
	Tue, 20 Aug 2024 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137037; cv=none; b=rOfutUmofNZu6ZG82zBQanMqbOqZc1XCZCGMfI4MWpbKuH5KiuVxxkCV4lVzi8H2bZDTQFVeG5yXGdnlMpWj1De8PRVn3hhIqdA3ekb8zIMk561LWWLiY+W4CG0cWpYwdBEm4nE97DQyklCw14XYocf7nKKPSmLBU4RxGtV0ONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137037; c=relaxed/simple;
	bh=Hyf7NFwnQiuV74pTeTGpVdJ34mxXozCveBFgWOgZshg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNE0p5d4zuYj+FH+FBhktw1Vl/Bd+7/VbIiJs/by4QAP4m/iAgQ2CspxUPVF3YcPXzBvjN36LuQ0XXQ1xWeLbsgMdi8K13EUzxK3Az27G5zMyyB5wUr2P16LxMxWMqw16tTvl24S3OTbHwzU48fDDRXMaZQX6cDveArg9GtYVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UANEtyxJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JJnDEt005649;
	Tue, 20 Aug 2024 06:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=PjHukbbZ4L7/l
	YM28u/GL7cF5/olDZgt7o8CQ4u6IcM=; b=UANEtyxJ8XuuHncM2umceaAWb8pp1
	PMbK8CYcJPLPC5FguPBmgzbswfPsxbOfeLVjnkOOz2kgrCxI5nHZ2dqZQN456Ufh
	VjcNK6LCDgtOLEDnUq8a5UewnJYXxpQrgP8BSjwGrF4/xnAa19PynY9fB6aUrXts
	hGJXTjSno54ykgCISIrzolDhCyUqwGKjzwt5UKHy87IV/Gq2rGvBaDiQTM96FnVx
	47PhHjHDjyEhXK6pGbpIbpsg/KvLTUXHMPALsFl3f4F19WtX/GCUrs3Zq7zLTH+h
	/pFhqHFH//8DQN40wfLJ3zTlH1meGUUN6mhF8tliR+YtDKKHcpeH6CdQg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1msut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47K6vCuQ029256;
	Tue, 20 Aug 2024 06:57:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1msup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K2rRFj014245;
	Tue, 20 Aug 2024 06:57:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4137pmskc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K6v5HA32703052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 06:57:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A71FB2004B;
	Tue, 20 Aug 2024 06:57:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82D8320040;
	Tue, 20 Aug 2024 06:57:05 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 06:57:05 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        schlameuss@linux.ibm.com
Subject: [PATCH v2 3/5] KVM: s390: selftests: Add regression tests for KMCTR, KMF, KMO and PCC crypto subfunctions
Date: Tue, 20 Aug 2024 08:48:35 +0200
Message-ID: <20240820065623.1140399-4-hari55@linux.ibm.com>
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
X-Proofpoint-GUID: 9-brJXED-monfAv1pq5C7hN2zlWq1nEM
X-Proofpoint-ORIG-GUID: qkpSVh1SWkeEazNpL1-YEosHB6o58WN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200048

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
index 2489e10d3cc2..1fe4fc709afc 100644
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
 	int facility_bit;
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


