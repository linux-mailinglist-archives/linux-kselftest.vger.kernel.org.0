Return-Path: <linux-kselftest+bounces-15767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 889E2957ECF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 08:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA4D2B23C92
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 06:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC2918C029;
	Tue, 20 Aug 2024 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eKMoGsUT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4014A0A8;
	Tue, 20 Aug 2024 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137046; cv=none; b=OlRsPHlK2NnqfZAgK1GU5F9R+8GZYy5GZC9H/rQ2qq+quxbGaFaFKi9SxYo7U0pNUoSEriRbWgXgxdQ/0mpn3h4423EXpiBL/7TMNFNflzTTpOcs+Mpydiy6kSN1orkjAx3uwlge/RURWwfSqRtoGKs1wEiQkW49iT1imGaFtdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137046; c=relaxed/simple;
	bh=/3QiCfWzXD0JuQ07E2OaHg1/GNJknXvBDnczYuoIrjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4GanzHtkACH11Eh7K+e3LUSBHBI1gMPYwqdXd2JREKctsqTfWnDrtlVCx3F6nlLSNgYyVtRTzl4ofSAx81qqRGjbNNAecGvz3PndNZgiQVbuQ0nFelOgrDIYNy9v1U665lELuEmE/bEjywqywfd+NUbIvo95n1SKcRS9OD318g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eKMoGsUT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JKwsYZ001579;
	Tue, 20 Aug 2024 06:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=HGts0Gt6y5L7e
	vdYkmU46zedS1a2zP/etggf7yDsHbE=; b=eKMoGsUTID4dRxN5YXeUVolO8b74s
	89ZMEDkovM62YabXWw3s6kxon4hTuo34Y69Od03TyqsyMFy0ybRYG0tCiG1Xw+KD
	07/WYH4DF5O+B22Yj+VoUo4z+4mWsIB4BoijaL8AMgzbkeyVH2ixDUsiPHd6fDhi
	iw9hki1lq67lVonNGek47uRKRZqHq2zhhmT/4dzoL5E81FWaCrlCE43zT1ybB+Zr
	gaxg9lpSzoPy3wAgde4vgfE7S09GwM02L+RZc4BSYGYARmqM4LbEFnrjLoWV2teD
	CVqs7lL38udRfv37o2qfVOHMplEoO5qu/sBLTuX1qQzIPvzEDnh3up6bQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma04e4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:22 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47K6vM2m014080;
	Tue, 20 Aug 2024 06:57:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma04e4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K5VGPM013089;
	Tue, 20 Aug 2024 06:57:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41366u1wm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K6vF9E47645140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 06:57:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F3C42005A;
	Tue, 20 Aug 2024 06:57:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69EE720043;
	Tue, 20 Aug 2024 06:57:15 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 06:57:15 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        schlameuss@linux.ibm.com
Subject: [PATCH v2 5/5] KVM: s390: selftests: Add regression tests for PLO subfunctions
Date: Tue, 20 Aug 2024 08:48:37 +0200
Message-ID: <20240820065623.1140399-6-hari55@linux.ibm.com>
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
X-Proofpoint-GUID: bX9kmX9Mfc5okd500TIAlUobm1B42jTW
X-Proofpoint-ORIG-GUID: wwc8znrCMXOxjBPDM8BH-QDkN8ewa4Cz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408200048

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
 .../kvm/s390x/cpumodel_subfuncs_test.c        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
index c31f445c6f03..255984a52365 100644
--- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
+++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
@@ -20,6 +20,8 @@
 
 #include "kvm_util.h"
 
+#define U8_MAX  ((u8)~0U)
+
 /**
  * Query available CPU subfunctions
  */
@@ -37,6 +39,33 @@ static void get_cpu_machine_subfuntions(struct kvm_vm *vm,
 	TEST_ASSERT(!r, "Get cpu subfunctions failed r=%d errno=%d", r, errno);
 }
 
+static inline int plo_test_bit(unsigned char nr)
+{
+	unsigned long function = (unsigned long)nr | 0x100;
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
+/*
+ * Testing Perform Locked Operation (PLO) CPU subfunction's ASM block
+ */
+static void test_plo_asm_block(u8 (*query)[32])
+{
+	for (int i = 0; i <= U8_MAX; ++i) {
+		if (plo_test_bit(i))
+			(*query)[i >> 3] |= 0x80 >> (i & 7);
+	}
+}
+
 /*
  * Testing Crypto Compute Message Authentication Code (KMAC) CPU subfunction's
  * ASM block
@@ -237,6 +266,11 @@ struct testdef {
 	testfunc_t test;
 	int facility_bit;
 } testlist[] = {
+	/*  PLO was introduced in the very first 64-bit machine generation.
+	 *  Hence it is assumed PLO is always installed in Z Arch .
+	 */
+	{ "PLO", cpu_subfunc.plo, sizeof(cpu_subfunc.plo),
+		test_plo_asm_block, 1 },
 	/* MSA - Facility bit 17 */
 	{ "KMAC", cpu_subfunc.kmac, sizeof(cpu_subfunc.kmac),
 		test_kmac_asm_block, 17 },
-- 
2.45.2


