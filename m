Return-Path: <linux-kselftest+bounces-15764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0E5957EC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 08:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7574E2826CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 06:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9A171E43;
	Tue, 20 Aug 2024 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iL0XAbyH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5199316B723;
	Tue, 20 Aug 2024 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137030; cv=none; b=WRDFGXErcOkC4RIk2Y4dDy//EEbneGfm7AQx6Wp1ZFmGAHAu36Yq/t0thLZ6KX1w/p5EdaFZKMlDmaH5CsSR5TEk1kbi4ZVZe+xlT24gug6Y64qDfNM6g4l6rLlcuy9+vryuI+plEH8Hu8y+2ndrt30cIV2SOu7FuSDC/5GMLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137030; c=relaxed/simple;
	bh=uGC8eH+nvpSCL8X0XxjHekVnZtSDJq084AA/YpfRLIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pw87B+aapuLY//fD+3WmkVmuFrO5bnVGO00QIUqTFoHhggTXkVUMAwPKPGVPywu3aAd4N6fPQ9nuqHbnZ6+8nsd3m5V8BS2ROI1GqMCFyJKzuffssPRJ1EmWseCzWjfE4JPoRtXvB1HiEAM8ANhO2vkJPoHg6XoDjrwN1nqOmDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iL0XAbyH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JIB4ng004379;
	Tue, 20 Aug 2024 06:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=vs10LzB98qLWP
	gzOTp2VuGi5TwVwxvFYh3ORcBYx2wk=; b=iL0XAbyHV4ZczIxecs55nlhauTu4A
	sHdDjKYc1sURnv9hHkrCWKX9yQgtJt367Z5kWcs08RfFYBFsBveqKzeL74rVRV1F
	/phb8mU+KrCAI+LBySlT3bx0ed2JcSb0bFUAKT/QM756Svryz/mGMh7v81E3hJXr
	PVGEj6B/dCCfhEFAcK9aOHRghUkMITEezZeZqdR8NxQemxpczIMCOD/V9192OaHm
	y306Bvj0/AKo+A+ocsRd4Ekx0djQCqkmgVSTiX//02TUFMJpXqSqOg4sHEMkTYCH
	uvDY3WlNo83ADYlXAawQMezMzT6flicVAJxTekc9lQt4ZV0VOU3b3VdPA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1msud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:05 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47K6sSS8024022;
	Tue, 20 Aug 2024 06:57:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1msua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K4AUOC017698;
	Tue, 20 Aug 2024 06:57:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w31bg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K6ux7d55247310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 06:57:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EC9920043;
	Tue, 20 Aug 2024 06:56:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDCDE20040;
	Tue, 20 Aug 2024 06:56:58 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 06:56:58 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        schlameuss@linux.ibm.com
Subject: [PATCH v2 2/5] KVM: s390: selftests: Add regression tests for PRNO, KDSA and KMA crypto subfunctions
Date: Tue, 20 Aug 2024 08:48:34 +0200
Message-ID: <20240820065623.1140399-3-hari55@linux.ibm.com>
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
X-Proofpoint-GUID: kgTQNxUedXq0v2KYi63Zlj2UCCu4FJft
X-Proofpoint-ORIG-GUID: GiP6h0AVTJtCaPiHm84QDS5r7iA-B2pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200048

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
index ea03ce2010bb..2489e10d3cc2 100644
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
 	int facility_bit;
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


