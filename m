Return-Path: <linux-kselftest+bounces-16148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3340195CD62
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 15:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885D4B23D11
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75973188596;
	Fri, 23 Aug 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CNQXlNco"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73561187329;
	Fri, 23 Aug 2024 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418607; cv=none; b=qMtbOHpe+gDU3Edsk4Gylr4T4qaw6LwtEWczrcALSv1QK2iXywl2D4/HtAUi6IXvY4/Y+0u3IPfceLzFrg4EOcQlOVx0zOm/sD3DXJjOn+0xznJQdkTAbz0dRRIDpeItyVbjnQa5NsNm52cQP7XALlWZyX3j/TZb9KcNF0VdPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418607; c=relaxed/simple;
	bh=GnWAfk0fCFkksaIL8c6nCscgYwhdx18KWfaQQlVxY9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT27Yrum7VQ/GqudZrrV1mncJi4NvYLhdx6QrqxBQxQ2Lun5IiPsneCWBOvcxTf3I/hE+DYY5VwLCvMC3vt900vcVileysFmAey1JDncwGJwePXXJFM6+K+pASVvxbgBErUYE5ROGB0f590UpUdRcqZG7l2FsVLCptMODgModuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CNQXlNco; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N7iQLq005275;
	Fri, 23 Aug 2024 13:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=BcMNCtSltgEav
	UtNz7kniajcI2bX0aAS3QEJZLfpjK4=; b=CNQXlNco3OoxIg8+gh6+8HQDK//dc
	jI2M4fd4nIr/2oaDK/1LhbI0/w5l/cGrBsxs+VL4tAflCXHK3RwwOvTvKYzmSrRU
	bTuxnBV+hHIsS4BPyFzjP3gGINUCIX/VQDLudnv4vaxX40VMD0Pwg9g3GC6EMPEn
	puxf5rF+L9cyjU5Y4QTHIz2k5mU9Ua88M+2FM0NcOVnBguKgbQGD09oy4059wq/q
	fa7OWq+zIba3gOs6xVOPXMY423lp+oUYQPqcrAm8HRjwJZ7FlI/T+ujDfi4SVaIn
	JGfNbVXghjvWneKPakGZhThdf17GYMnzrwdZjpTrRxpZ5fgBeMYeu1/ZQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb650eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:10:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47NDA1lI016515;
	Fri, 23 Aug 2024 13:10:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb650ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:10:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47ND4ogJ017649;
	Fri, 23 Aug 2024 13:10:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w3hky8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:10:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47ND9tuJ54264156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:09:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 455742004D;
	Fri, 23 Aug 2024 13:09:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0CAA2004B;
	Fri, 23 Aug 2024 13:09:54 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 13:09:54 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        schlameuss@linux.ibm.com
Subject: [PATCH v3 3/5] KVM: s390: selftests: Add regression tests for KMCTR, KMF, KMO and PCC crypto subfunctions
Date: Fri, 23 Aug 2024 15:05:06 +0200
Message-ID: <20240823130947.38323-4-hari55@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823130947.38323-1-hari55@linux.ibm.com>
References: <20240823130947.38323-1-hari55@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g7DnWmNULCBAxyIEmMNWep7TgezVaaIl
X-Proofpoint-GUID: R_07YZ36YkBsPiU-Byt1XE3kENSsEO8R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230095

Extend the existing regression test framework for s390x CPU subfunctions
to include tests for the KMCTR (Cipher Message with Counter) KMO
(Cipher Message with Output Feedback), KMF (Cipher Message with Cipher
Feedback) and PCC (Perform Cryptographic Computation) crypto functions.

The test procedure follows the established pattern.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Hariharan Mari <hari55@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../kvm/s390x/cpumodel_subfuncs_test.c        | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
index 96e7ca07220f..28faceeaf089 100644
--- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
+++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
@@ -33,6 +33,50 @@ static void get_cpu_machine_subfuntions(struct kvm_vm *vm,
 	TEST_ASSERT(!r, "Get cpu subfunctions failed r=%d errno=%d", r, errno);
 }
 
+/* Testing Crypto Cipher Message with Counter (KMCTR) CPU subfunction's ASM block */
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
+/* Testing Crypto Cipher Message with Cipher Feedback (KMF) CPU subfunction's ASM block */
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
+/* Testing Crypto Cipher Message with Output Feedback (KMO) CPU subfunction's ASM block */
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
+/* Testing Crypto Perform Cryptographic Computation (PCC) CPU subfunction's ASM block */
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
 /* Testing Crypto Perform Random Number Operation (PRNO) CPU subfunction's ASM block */
 static void test_prno_asm_block(u8 (*query)[16])
 {
@@ -97,6 +141,11 @@ struct testdef {
 	testfunc_t test;
 	int facility_bit;
 } testlist[] = {
+	/* MSA - Facility bit 77 */
+	{ "KMCTR", cpu_subfunc.kmctr, sizeof(cpu_subfunc.kmctr), test_kmctr_asm_block, 77 },
+	{ "KMF", cpu_subfunc.kmf, sizeof(cpu_subfunc.kmf), test_kmf_asm_block, 77 },
+	{ "KMO", cpu_subfunc.kmo, sizeof(cpu_subfunc.kmo), test_kmo_asm_block, 77 },
+	{ "PCC", cpu_subfunc.pcc, sizeof(cpu_subfunc.pcc), test_pcc_asm_block, 77 },
 	/* MSA5 - Facility bit 57 */
 	{ "PPNO", cpu_subfunc.ppno, sizeof(cpu_subfunc.ppno), test_prno_asm_block, 57 },
 	/* MSA8 - Facility bit 146 */
-- 
2.45.2


