Return-Path: <linux-kselftest+bounces-16149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AAC95CD69
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 15:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156041F22ABB
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1E3188A09;
	Fri, 23 Aug 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E3LknZCA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B771E18890F;
	Fri, 23 Aug 2024 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418611; cv=none; b=eLpp6BMB/GlKpdXycYVOElNQ/0BcQqHsnGaUrk/4bx71obVMeOsl0ZsdVS+TuLbNT2/zLvlQR/+1/YhQFU0kGUrzcgPNQehMylW+GX4akgvQP4YyrODne1IfKLFT7WxU3t2/N87ykVWCimCsPCBoC1uzTGhPa9mh781mBuqx2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418611; c=relaxed/simple;
	bh=u+Nefqa4u82mmufHxwR9xyw0SPmSHCztQ67AlSiT00Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKOiHRLCcizmV2nsKfQLX/Pq+s1a/1AEBe2UHslTidN3ZjVnxe9HqUQtYybDP/YFZfsynN19EZTiZayU1erGN4eyaapOth7sm/9NSalP/5tKmm4gZLic2EfT/UC+Kq4pPjS7+MFuPhFRftWhQHTTZcFewrOKCimtc/Bag7vQ88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E3LknZCA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N8Jq8h014038;
	Fri, 23 Aug 2024 13:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=F8wuGovUtKO9/
	/Tw8ra0KBaKLfiCX72VZz/XrPTI78I=; b=E3LknZCAwlQWIy1FAKLrWPjot5Me/
	1r7G07HekzRPB+1vdn8C111Ws5id1dt/waQdCRdzY6L7qq7dlDEZsj4b5H+FG56B
	ac/TIaXBV39PwgsuilMBT69swfoLZAvO/9v955EHNiLYdnAqVKO1NU40LjLSHodf
	DvwAfoK8X/0wwJcUwO1vT5laG5iTl8xI3GBdODom+idt/XMURDoQdt40co1IpW+i
	otu7GjA73wLS8NSMs4cyWOiUHaZygsIhEweqDCYZ4lQmvw9lJw3aqx5cUqU0tV/a
	S/2Oll6/pzejjcHtazc/BbpFkbo1GYXXixXmJErJ7LqSwB0MHD/6btlig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mcyv2y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:10:04 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47NDA45d019429;
	Fri, 23 Aug 2024 13:10:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mcyv2xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:10:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47NAlkZ0014181;
	Fri, 23 Aug 2024 13:10:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4137pn9us3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:10:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47ND9wh646661932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:10:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1253720049;
	Fri, 23 Aug 2024 13:09:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF7F920040;
	Fri, 23 Aug 2024 13:09:57 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 13:09:57 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        schlameuss@linux.ibm.com
Subject: [PATCH v3 4/5] KVM: s390: selftests: Add regression tests for KMAC, KMC, KM, KIMD and KLMD crypto subfunctions
Date: Fri, 23 Aug 2024 15:05:07 +0200
Message-ID: <20240823130947.38323-5-hari55@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 36pDvz1efd0MdGkqU8sBR4MXQndAn5P1
X-Proofpoint-GUID: bfm4khpKvCOxkmdHm57a4MQrbU4elwsc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408230095

Extend the existing regression test framework for s390x CPU subfunctions
to include tests for the KMAC (Compute Message Authentication Code),
KMC (Cipher Message with Chaining), KM (Cipher Message) KIMD (Compute
Intermediate Message Digest) and KLMD (Compute Last Message Digest)
crypto functions.

The test procedure follows the established pattern.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Hariharan Mari <hari55@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../kvm/s390x/cpumodel_subfuncs_test.c        | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
index 28faceeaf089..fe45fb131583 100644
--- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
+++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
@@ -33,6 +33,61 @@ static void get_cpu_machine_subfuntions(struct kvm_vm *vm,
 	TEST_ASSERT(!r, "Get cpu subfunctions failed r=%d errno=%d", r, errno);
 }
 
+/* Testing Crypto Compute Message Authentication Code (KMAC) CPU subfunction's ASM block */
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
+/* Testing Crypto Cipher Message with Chaining (KMC) CPU subfunction's ASM block */
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
+/* Testing Crypto Cipher Message (KM) CPU subfunction's ASM block */
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
+/* Testing Crypto Compute Intermediate Message Digest (KIMD) CPU subfunction's ASM block */
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
+/* Testing Crypto Compute Last Message Digest (KLMD) CPU subfunction's ASM block */
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
 /* Testing Crypto Cipher Message with Counter (KMCTR) CPU subfunction's ASM block */
 static void test_kmctr_asm_block(u8 (*query)[16])
 {
@@ -141,6 +196,12 @@ struct testdef {
 	testfunc_t test;
 	int facility_bit;
 } testlist[] = {
+	/* MSA - Facility bit 17 */
+	{ "KMAC", cpu_subfunc.kmac, sizeof(cpu_subfunc.kmac), test_kmac_asm_block, 17 },
+	{ "KMC", cpu_subfunc.kmc, sizeof(cpu_subfunc.kmc), test_kmc_asm_block, 17 },
+	{ "KM", cpu_subfunc.km, sizeof(cpu_subfunc.km), test_km_asm_block, 17 },
+	{ "KIMD", cpu_subfunc.kimd, sizeof(cpu_subfunc.kimd), test_kimd_asm_block, 17 },
+	{ "KLMD", cpu_subfunc.klmd, sizeof(cpu_subfunc.klmd), test_klmd_asm_block, 17 },
 	/* MSA - Facility bit 77 */
 	{ "KMCTR", cpu_subfunc.kmctr, sizeof(cpu_subfunc.kmctr), test_kmctr_asm_block, 77 },
 	{ "KMF", cpu_subfunc.kmf, sizeof(cpu_subfunc.kmf), test_kmf_asm_block, 77 },
-- 
2.45.2


