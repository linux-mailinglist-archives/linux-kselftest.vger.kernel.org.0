Return-Path: <linux-kselftest+bounces-16150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6723D95CD6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 15:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5F92849BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A41E188A19;
	Fri, 23 Aug 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kedIkQi+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02F9188905;
	Fri, 23 Aug 2024 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418611; cv=none; b=krxQU39q6LDN2CpyvSrUAkOi3/Dj/wf/Ys6awfDlV3zM4OEf28+DaEMJIm7xLdo8UX4VW+tg00GboK2OykldE/Jv3hxx/CttaOE2GLUxqhJ/ISESWe5F/r5uiM7Ktul6w6zO0SV80HnufCuhCt6AP2xuSyqr//UdzfDbdQol06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418611; c=relaxed/simple;
	bh=wznO/uHzp07GwjLCy/T67HdeBwaNbaL4D0O7BIfErvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUEnvFOL19sFocPjIN3sH0t4S2XVWXB0Zo4uqXutw2ndW9BOHUZ9YBxRW/jvYqUymkx3eTNN7M8ar+SpX3gK/ONySSudgH4iZ14ipu/X4lNTp224QhljDqk6aig/YtZGJkgOJSlfxhPwjtWxs2c89vGpoAQCRBwPcis5GDuv6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kedIkQi+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N8vtdX005375;
	Fri, 23 Aug 2024 13:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=vGA4guXkyUMpC
	/+TGE5IkXahUomFPrZKZRJG1zd//I0=; b=kedIkQi+aLzcYcDnTmFfp3KBntySC
	ufuOSQyIUSvf3t5HKt3uZb+6lmqIfjKyFeRgTJMVmxhm+9L+1Xl4k2EMliEqP4LT
	EmM5tbUqPdyYOPA0Y8EmhkgJkYefrg1ZxjW2lpu+wjOetA6zIlelyhEz/Ck/S9uU
	Z2AH1lfHSQmlWVE0qGPMkjEr/jyXeR8DOEsUEZO4J+Qz0NMxgp7jGsv+Xx4+S1cT
	smZYRb80ytSc4twkks4Pa6OawBaqIvbXYWqQ8SExCT+7PkGpIUwFGDuoWsjnrTgu
	zE/NmTxXmO/xEgyJAmnbv6w9R4Q2hFsWMviuc6kSL1ZCmywppN5Yjoa8g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb650ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:10:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47NDA5Tk016651;
	Fri, 23 Aug 2024 13:10:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb650f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:10:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47ND0T9J017684;
	Fri, 23 Aug 2024 13:10:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w3hkyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:10:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47ND9xPx25362926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:10:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8357E2004B;
	Fri, 23 Aug 2024 13:09:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B31420040;
	Fri, 23 Aug 2024 13:09:59 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 13:09:59 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        schlameuss@linux.ibm.com
Subject: [PATCH v3 5/5] KVM: s390: selftests: Add regression tests for PLO subfunctions
Date: Fri, 23 Aug 2024 15:05:08 +0200
Message-ID: <20240823130947.38323-6-hari55@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: FeLCjR6ocRS4a9W_tisGtJhn8EXGdMZu
X-Proofpoint-GUID: JVcfZFOhSEqQuL-7LwW7iDrUVRkXKu4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230095

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
 .../kvm/s390x/cpumodel_subfuncs_test.c        | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
index fe45fb131583..222ba1cc3cac 100644
--- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
+++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
@@ -19,6 +19,8 @@
 
 #include "kvm_util.h"
 
+#define PLO_FUNCTION_MAX 256
+
 /* Query available CPU subfunctions */
 struct kvm_s390_vm_cpu_subfunc cpu_subfunc;
 
@@ -33,6 +35,31 @@ static void get_cpu_machine_subfuntions(struct kvm_vm *vm,
 	TEST_ASSERT(!r, "Get cpu subfunctions failed r=%d errno=%d", r, errno);
 }
 
+static inline int plo_test_bit(unsigned char nr)
+{
+	unsigned long function = nr | 0x100;
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
+/* Testing Perform Locked Operation (PLO) CPU subfunction's ASM block */
+static void test_plo_asm_block(u8 (*query)[32])
+{
+	for (int i = 0; i < PLO_FUNCTION_MAX; ++i) {
+		if (plo_test_bit(i))
+			(*query)[i >> 3] |= 0x80 >> (i & 7);
+	}
+}
+
 /* Testing Crypto Compute Message Authentication Code (KMAC) CPU subfunction's ASM block */
 static void test_kmac_asm_block(u8 (*query)[16])
 {
@@ -196,6 +223,11 @@ struct testdef {
 	testfunc_t test;
 	int facility_bit;
 } testlist[] = {
+	/*
+	 * PLO was introduced in the very first 64-bit machine generation.
+	 * Hence it is assumed PLO is always installed in Z Arch.
+	 */
+	{ "PLO", cpu_subfunc.plo, sizeof(cpu_subfunc.plo), test_plo_asm_block, 1 },
 	/* MSA - Facility bit 17 */
 	{ "KMAC", cpu_subfunc.kmac, sizeof(cpu_subfunc.kmac), test_kmac_asm_block, 17 },
 	{ "KMC", cpu_subfunc.kmc, sizeof(cpu_subfunc.kmc), test_kmc_asm_block, 17 },
-- 
2.45.2


