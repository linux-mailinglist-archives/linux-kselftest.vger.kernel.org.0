Return-Path: <linux-kselftest+bounces-16147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B03595CD5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 15:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA762846B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F3A188005;
	Fri, 23 Aug 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DtyKw7t0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3A186600;
	Fri, 23 Aug 2024 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418606; cv=none; b=R7iBCNFBcrxhCD3IwuXvl7YsTYN0xZlW4555LvGp3SEsmX1KM3OF5q/w54dcDAIkCbMEhT+cF0bXKu06UaDjcLfg2WgIaigAkdfkH2sB/G4vzyFKs8hkIyh6mnzY2A9Bl8ckdA84SSFm7tsFn+2NRhX/D4/NNaU3GFHIHTq9gtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418606; c=relaxed/simple;
	bh=3SySZNlK9VlAXg756Q80hrkQ+VsKOVx004ue7lZwNzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaipPjyDXwqTrqyKwsC0FJgVeS3QkBXpHORmmT+wy5kXafu2rW7a2B9e8ibNnuOmGoRkGR41g3HOUcruV6Kd/5QI8Uwg25t3ELCjSCz8Sx3PlWjdonYG5HZX1xtr/zMNz+NQ+6YNuMDqo69q3hy1RT5WqWlLQNF6FjzKULZOJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DtyKw7t0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N40nXV005441;
	Fri, 23 Aug 2024 13:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=56yfp8w+DcsyE
	rThynTt1IWFdlUF7m9wslgd8pjwUiU=; b=DtyKw7t0EAFIpjW+byOq25D43QReI
	yYMcoyMxvfhkwQ22HysoDVGoq9b3ahxN2K0lq/zyqzrYwvoGU06UZWtiHVFINzXm
	JvkWevJQZUag+9/vEtw2okMHK1jvJLn/iNsRTCPNAQKu7FkR6qqutKqRp+0/HElb
	S00e7BNx5GrGj9yP7UFqcfbNgGji7sHwUqztkvKRGscDtQsr9ldMDsKt+OL979Er
	Z4ReiBrIFqgwxGy1Mwsq6BwF5I8i7lGGCi1ABR/Z21ydKf9f53FRWYq6XqTn6n7s
	GAqOS9nQ4s/FhrsA1j+CvRWGzr5ZrYPQDyYNlHvlhvsPfx7sVOMtxSyCA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb650em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:10:01 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47NDA15B016410;
	Fri, 23 Aug 2024 13:10:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb650ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:10:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47NAPLNH002215;
	Fri, 23 Aug 2024 13:09:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k1252j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:09:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47ND9rMH54788404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:09:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC73320049;
	Fri, 23 Aug 2024 13:09:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91D9B20040;
	Fri, 23 Aug 2024 13:09:53 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 13:09:53 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        schlameuss@linux.ibm.com
Subject: [PATCH v3 2/5] KVM: s390: selftests: Add regression tests for PRNO, KDSA and KMA crypto subfunctions
Date: Fri, 23 Aug 2024 15:05:05 +0200
Message-ID: <20240823130947.38323-3-hari55@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: -ZCUtB6Ebqk7eOUgGxT92eHuKuht0cWU
X-Proofpoint-GUID: JbLtS5HnD-gMZ2mlmQRJhVL0uvGHuzKk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230095

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
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../kvm/s390x/cpumodel_subfuncs_test.c        | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
index ee525c841767..96e7ca07220f 100644
--- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
+++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
@@ -33,6 +33,39 @@ static void get_cpu_machine_subfuntions(struct kvm_vm *vm,
 	TEST_ASSERT(!r, "Get cpu subfunctions failed r=%d errno=%d", r, errno);
 }
 
+/* Testing Crypto Perform Random Number Operation (PRNO) CPU subfunction's ASM block */
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
+/* Testing Crypto Cipher Message with Authentication (KMA) CPU subfunction's ASM block */
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
+/* Testing Crypto Compute Digital Signature Authentication (KDSA) CPU subfunction's ASM block */
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
 /* Testing Sort Lists (SORTL) CPU subfunction's ASM block */
 static void test_sortl_asm_block(u8 (*query)[32])
 {
@@ -64,6 +97,12 @@ struct testdef {
 	testfunc_t test;
 	int facility_bit;
 } testlist[] = {
+	/* MSA5 - Facility bit 57 */
+	{ "PPNO", cpu_subfunc.ppno, sizeof(cpu_subfunc.ppno), test_prno_asm_block, 57 },
+	/* MSA8 - Facility bit 146 */
+	{ "KMA", cpu_subfunc.kma, sizeof(cpu_subfunc.kma), test_kma_asm_block, 146 },
+	/* MSA9 - Facility bit 155 */
+	{ "KDSA", cpu_subfunc.kdsa, sizeof(cpu_subfunc.kdsa), test_kdsa_asm_block, 155 },
 	/* SORTL - Facility bit 150 */
 	{ "SORTL", cpu_subfunc.sortl, sizeof(cpu_subfunc.sortl), test_sortl_asm_block, 150 },
 	/* DFLTCC - Facility bit 151 */
-- 
2.45.2


