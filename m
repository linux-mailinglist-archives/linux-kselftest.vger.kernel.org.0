Return-Path: <linux-kselftest+bounces-23426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 832F09F353C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 17:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505431886CBC
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21711465A1;
	Mon, 16 Dec 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T968UMGg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5723F53E23
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365031; cv=none; b=GyDhZz+UcakuLlFBFtXaMD1gBONxGOQgTiCQHwkS4Ljj7QQGEO1I8ome9sWBnGmxCSFJRXVsozxDtQUldW9taAaBqEyr2zZjVdtIiv6Der5KcRdxhzUvrFrRsYGx+jSv7RZg/Es5i5preKVO5PnWEu9+y0qCWFt+BuAM8iYnz38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365031; c=relaxed/simple;
	bh=4ElTjVDbGUQmiRjXyvHnqvalfySMcyrzAwbBl3gNkJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=th3qAu1y/mpTz9nv5l76HwdidQho4rRviP3z3N6b4nG/rZFn8aA2jij6wrUXuRcfvqxvm13DbvQkCLvdZoVbnGTfZH9u7piQNLplCOEWaLVcfsP9lam7jpdgh0/0rsMK6SC6AyE7WilMTeZpU6sLeDIx7XbUZyh7ZvoADHdy7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T968UMGg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGCtF4v009108;
	Mon, 16 Dec 2024 16:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qWrWP29wqKFHLLKF2
	sOgSyYt3Ljp5XDmh5aF1EScO3I=; b=T968UMGghSJXj6k4Zm9si5HiRKryS6Mc0
	dc7mYxrfFi5MLzHj6vxnjnmFf1bFs83udI/npItHgcoLkk9RIV5EqbqPKPCeCPzr
	cZ+GQ3R2XfscE/MYmrbI2sMwArIxkojKm3XN8JGRNQ5715TmS8b21HB5MTxwCrM8
	B2cfhvjtdLMpZK7AN1Ig6nmp8RyoWwPnjT4MrLld9OorK2EDlqaX8Krgwcpd6Pd1
	qxDrIfaw9PYb3oayG0dZWQJ7k1AUAgcfyGfN/7wICAn5UObvWWy2guEjSTASBGFR
	hPcwDBmqsg90A/qajQJ9JAGGtrV2ZaR1LlpJ3CDTlKaiMxY1XYg4g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j98h3yrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:03:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BGFdmue025077;
	Mon, 16 Dec 2024 16:03:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j98h3yrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:03:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGDGd2R014335;
	Mon, 16 Dec 2024 16:03:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqxxqxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:03:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BGG3WYH21037362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 16:03:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F134D2004D;
	Mon, 16 Dec 2024 16:03:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C06DA20043;
	Mon, 16 Dec 2024 16:03:27 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.70.111])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 16:03:27 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v2 3/3] selftest/powerpc/ptrace: Cleanup duplicate macro definitions
Date: Mon, 16 Dec 2024 21:32:57 +0530
Message-ID: <20241216160257.87252-3-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216160257.87252-1-maddy@linux.ibm.com>
References: <20241216160257.87252-1-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CaL2mTjAe4Q65c47NgpxxXJJrO92w-lC
X-Proofpoint-GUID: WWlbwlNSNedLMkS3byKv0IW08V-OvhDs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=848 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160133

Both core-pkey.c and ptrace-pkey.c tests have
similar macro definitions, move them to "pkeys.h"
and remove the macro definitions from the C file.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
Changelog v1:
 - Removed additional macros pointed out by Ritesh
   which are duplicates and are avilable in "pkeys.h"

 tools/testing/selftests/powerpc/include/pkeys.h      |  8 ++++++++
 tools/testing/selftests/powerpc/ptrace/core-pkey.c   | 12 ------------
 tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c | 12 ------------
 3 files changed, 8 insertions(+), 24 deletions(-)

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
index 31c9bf6d95db..f061434af452 100644
--- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
@@ -18,18 +18,6 @@
 #include "child.h"
 #include "pkeys.h"
 
-#ifndef NT_PPC_PKEY
-#define NT_PPC_PKEY		0x110
-#endif
-
-#ifndef PKEY_DISABLE_EXECUTE
-#define PKEY_DISABLE_EXECUTE	0x4
-#endif
-
-#define AMR_BITS_PER_PKEY 2
-#define PKEY_REG_BITS (sizeof(u64) * 8)
-#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
-
 #define CORE_FILE_LIMIT	(5 * 1024 * 1024)	/* 5 MB should be enough */
 
 static const char core_pattern_file[] = "/proc/sys/kernel/core_pattern";
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
index 6893ed096457..fc633014424f 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
@@ -9,18 +9,6 @@
 #include "child.h"
 #include "pkeys.h"
 
-#ifndef NT_PPC_PKEY
-#define NT_PPC_PKEY		0x110
-#endif
-
-#ifndef PKEY_DISABLE_EXECUTE
-#define PKEY_DISABLE_EXECUTE	0x4
-#endif
-
-#define AMR_BITS_PER_PKEY 2
-#define PKEY_REG_BITS (sizeof(u64) * 8)
-#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
-
 static const char user_read[] = "[User Read (Running)]";
 static const char user_write[] = "[User Write (Running)]";
 static const char ptrace_read_running[] = "[Ptrace Read (Running)]";
-- 
2.47.0


