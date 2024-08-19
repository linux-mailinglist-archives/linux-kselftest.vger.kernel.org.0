Return-Path: <linux-kselftest+bounces-15646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0BD956C93
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 16:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608BC2850CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D9316C86A;
	Mon, 19 Aug 2024 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EEfU3MDP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B116E880;
	Mon, 19 Aug 2024 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076065; cv=none; b=dQHCeJ39ShYZWoM3bm4P4L+U5fmxAEizBy8jyje9IoiMC1tiaPna5O0bZkhnX8hnXyFiuCTkdxT8OUFUjgsotvWEd921mBkOAxmrCgGA4lDsgbJvgIylUOnS1+JCHW8/y9b3nEdLlZanNBrgR3sEb1aInJ8Als1dD6QTyLFAh1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076065; c=relaxed/simple;
	bh=38Jism4CMzxZTpIBDKXs5a7YLsLnU973xC31PAejdm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrFf7yHM7ar6YfxAyCi9LetJDhLoAbN77A/mpfdl496GgEQ4qy/fFUJx7Sg6Z9sGQNoFhFluMD0RSAjvnTFXibhGqslb4ooq86zXKd66zfkYHUSbcaQ/YH0QTF2Bcjlw/2/ylRu61LgfBFhK0Sgq+q4t5oXzv8ZgGUc/MGkY5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EEfU3MDP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J7lWEE005127;
	Mon, 19 Aug 2024 14:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=VcrnPicQkIcMf
	u24zjtVylD6ADago3bumk2oQzLD6WU=; b=EEfU3MDPXCXgfRIZkmO1R7N4fp5eu
	lMxM+fjGx1bQ5PVGYSjhCZUNQMwVUZVspy2MdKcVGt429wIEZ2T6lwZaoDpgWdpe
	EDIWuLsLHZ4j2bzInLq16zLwY+0x/3xIUMT+jg1huC1HH/yFdhw4j+D58mYvPhzZ
	OEDVgcgYWCr8II6YE00vmGpMP3d0d/b0sU94rRDTOVE6XejOTfPMdFlK0isa65ag
	5JZeKfInoFztHSBXwJdNUDLVhg7l8J9AC3ga0MSwZsAmH+irOf9DFsvSOwVah6+q
	wgNdGOhSXBVy3Mn9iozMANfTy7qluMO3hK+fuCQtv2nGnNTA2C0v+IjAQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1hewc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:01:00 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47JDvlAB012994;
	Mon, 19 Aug 2024 14:00:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1hew8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:00:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD9s4p018968;
	Mon, 19 Aug 2024 14:00:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376ppcs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:00:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47JE0qFf54067670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:00:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 921E02004D;
	Mon, 19 Aug 2024 14:00:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ECE42004B;
	Mon, 19 Aug 2024 14:00:52 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Aug 2024 14:00:52 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com
Subject: [PATCH v1 4/5] KVM: s390: selftests: Add regression tests for KMAC, KMC, KM, KIMD and KLMD crypto subfunctions
Date: Mon, 19 Aug 2024 15:54:25 +0200
Message-ID: <20240819140040.1087552-5-hari55@linux.ibm.com>
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
X-Proofpoint-GUID: kFAfBYpjLoqs0nThuYAOoroAJIFqGaT8
X-Proofpoint-ORIG-GUID: X6snyb8si999joGGd6wME9vxHOttQ1UA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_11,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190090

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
index 6ef9e855ac65..901c99fe79d9 100644
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
 	bool facility_bit;
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


