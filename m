Return-Path: <linux-kselftest+bounces-23050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745289E9A24
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 16:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BD41613B2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B925F1B425E;
	Mon,  9 Dec 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TtMmdhRc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1EA1B424E
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757292; cv=none; b=V7iJdtVry1RH3XpTbphQMsRwae7ZVTUhNRvaWX7orTq+5VYUKgNy5/6DuzAQM9g4a2+fWyOxPdPOgjgvsN0QhfDEBu3dUYrta5ayI1cnbJD2NpKW6Pgy+NlErDPB1vQ8/VQpEcjhJulKQd2wtI4S3/46cdfq6PqlxhLD7wjFRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757292; c=relaxed/simple;
	bh=rWpkPpJjnGIoaBlfasc/mIcubPSQmMWDg/04UG54gvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glj0kLAtrjUqwZj3M8+T5joMMcGnDduAORh9NXPh4dL3G6tMGv4bk67VOgX3ZrFbNbTx4DOH8+HK+uFEk7ouBWGA8nRAbTTrByEkf2av8BlSMucF2VxiELn5frx2NeIP/1JrOn7Sxep3EarXZP9UGu2a8ZBvPFT7QHDS1l7pAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TtMmdhRc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99fpie030610;
	Mon, 9 Dec 2024 15:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BH5TwweUkqOnsc172
	vXfteFPatvOsrj0SVX8Z9/kJAI=; b=TtMmdhRcp4DpKeloEAPAS9XbIwC5NpxNj
	Q33Bh9Ck5fchUFp989l/15e8sfNID5VDfWthdO09EPzlltvquVMtFdgkCrCxBjmr
	dUebWdLcowruaB6Y3/rA8SZ/mUBu+j/FpaRgk2K6lyeFqYqC5csurmFHJvt+5rPV
	3ZzME0psc+AwCidq9tLXWsjBO97af1t+TLDrWXAHiclH5V+sJTzx4r4QntGfHAI1
	FsqWY0svkmmhjkjezKwl06ird25O+w4+wx0v0GWjOlC9lgV+yoAiMpHJZpnvn4cv
	QZCzaNH86BuAlTCR2BHoAaIaX8MyNpQCab8rl+YmcsBixe0wKmsEw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8j2cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:14:37 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B9FEbCJ025338;
	Mon, 9 Dec 2024 15:14:37 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8j2cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:14:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9EAMQT000572;
	Mon, 9 Dec 2024 15:14:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pmy66k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:14:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9FEXbq59179342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 15:14:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A11BD20043;
	Mon,  9 Dec 2024 15:14:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9928B2004B;
	Mon,  9 Dec 2024 15:14:31 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.38.185])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 15:14:31 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 3/3] selftest/powerpc/ptrace: Cleanup duplicate macro definitions
Date: Mon,  9 Dec 2024 20:44:18 +0530
Message-ID: <20241209151418.348085-3-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209151418.348085-1-maddy@linux.ibm.com>
References: <20241209151418.348085-1-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7bscHaX4F1XZSuaSPKyuX4qUhvgbviZm
X-Proofpoint-ORIG-GUID: sj-gzOJt_bnju5K1pGraPhwvZ-PPWFnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=904
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090117

Both core-pkey.c and ptrace-pkey.c tests have similar macro
definitions, move them to "pkeys.h" and remove the macro
definitions from the C file.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 tools/testing/selftests/powerpc/include/pkeys.h      | 8 ++++++++
 tools/testing/selftests/powerpc/ptrace/core-pkey.c   | 8 --------
 tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c | 8 --------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/powerpc/include/pkeys.h b/tools/testing/selftests/powerpc/include/pkeys.h
index 51729d9a7111..3a0129467de6 100644
--- a/tools/testing/selftests/powerpc/include/pkeys.h
+++ b/tools/testing/selftests/powerpc/include/pkeys.h
@@ -35,10 +35,18 @@
 #define __NR_pkey_alloc		384
 #define __NR_pkey_free		385
 
+#ifndef NT_PPC_PKEY
+#define NT_PPC_PKEY		0x110
+#endif
+
 #define PKEY_BITS_PER_PKEY	2
 #define NR_PKEYS		32
 #define PKEY_BITS_MASK		((1UL << PKEY_BITS_PER_PKEY) - 1)
 
+#define AMR_BITS_PER_PKEY 2
+#define PKEY_REG_BITS (sizeof(u64) * 8)
+#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
+
 inline unsigned long pkeyreg_get(void)
 {
 	return mfspr(SPRN_AMR);
diff --git a/tools/testing/selftests/powerpc/ptrace/core-pkey.c b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
index 31c9bf6d95db..f8ff05e5bf6e 100644
--- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
@@ -18,18 +18,10 @@
 #include "child.h"
 #include "pkeys.h"
 
-#ifndef NT_PPC_PKEY
-#define NT_PPC_PKEY		0x110
-#endif
-
 #ifndef PKEY_DISABLE_EXECUTE
 #define PKEY_DISABLE_EXECUTE	0x4
 #endif
 
-#define AMR_BITS_PER_PKEY 2
-#define PKEY_REG_BITS (sizeof(u64) * 8)
-#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
-
 #define CORE_FILE_LIMIT	(5 * 1024 * 1024)	/* 5 MB should be enough */
 
 static const char core_pattern_file[] = "/proc/sys/kernel/core_pattern";
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
index 6893ed096457..5d528d0ea9d1 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
@@ -9,18 +9,10 @@
 #include "child.h"
 #include "pkeys.h"
 
-#ifndef NT_PPC_PKEY
-#define NT_PPC_PKEY		0x110
-#endif
-
 #ifndef PKEY_DISABLE_EXECUTE
 #define PKEY_DISABLE_EXECUTE	0x4
 #endif
 
-#define AMR_BITS_PER_PKEY 2
-#define PKEY_REG_BITS (sizeof(u64) * 8)
-#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
-
 static const char user_read[] = "[User Read (Running)]";
 static const char user_write[] = "[User Write (Running)]";
 static const char ptrace_read_running[] = "[Ptrace Read (Running)]";
-- 
2.47.0


