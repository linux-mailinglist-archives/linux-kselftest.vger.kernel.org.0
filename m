Return-Path: <linux-kselftest+bounces-15157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAF394EA20
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 11:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438CD1C20BD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8769C16DC24;
	Mon, 12 Aug 2024 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G8nE2qNm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85DC16D4FC
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Aug 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455751; cv=none; b=FV+2+pegxcVJHh+3XFu07yUXI5LJm/3nQFPFrACQ+EQYAbFhRu37OWYsBpk6CcJzSP91y3+L2Vt7+th4+x1l0Qbp46h5tECUo/P3Mt/CyZefBjBUeiiB9ukRkNyhB1XJTU4PqNES9kTIOO03RXg+oA7xWxkAVhcDg73i+T6TGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455751; c=relaxed/simple;
	bh=uOYHILE8vEftIZDeMsR9Cpt5EGjdl2Emw3OSBMJX5iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G++hMSMfeHgNS72rfGvUukLSqg/obn4dasNfFIoLNuT+Oy8dib2kU1daGonRY0XUAofwmgUe7CgCLIwqecE5cUFzYk/u+BRvUKaeaO0lrUeivIYMxckonDW8Dj9N/BdGsFyZt0pY6w6yR9NKb3AVp3MFwxFml1ERSXd1VNX0K9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G8nE2qNm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C4akWi025491;
	Mon, 12 Aug 2024 09:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=jMyQHgS/ARMULcqGzPivRhrrVb
	x/CVj4cEmhJf7UgdE=; b=G8nE2qNmqlD7ty4ryYdX9Fgm1W8UGwKK4kuU/WUsDE
	giKWUTooOv3G/jXfsXYm7H6K+QocaVylPx1pBPpVspQ992Sk7TrFkv3cKCSFMA6P
	Atq+x1bkTMy00v55a2/LMG0+Xnpz29gy74LKfCQ4E2A1yS6xPPt/2S6UIDDGen3P
	H66RBKoAjnWX3c7GbR75kKybp0ZC3BoeM43opEyBCWjUSMl6LRusXewYFQFVkIIC
	i+qAy1xOB7UdEFiMqcjE2jjht1PaWATx5nuKyxxaO0Wh9L5S3AlJoOsXpCGqzZvt
	0bYvSaP3GxMBKpIEb3PjS5OOECd/nEfcPTt/VT49sI2w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyq8mgav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 09:42:14 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47C9gEb9032437;
	Mon, 12 Aug 2024 09:42:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyq8mgat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 09:42:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47C7eD0b015571;
	Mon, 12 Aug 2024 09:42:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xm1mdpry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 09:42:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47C9g8jB54854080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 09:42:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C70A92004B;
	Mon, 12 Aug 2024 09:42:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C48920040;
	Mon, 12 Aug 2024 09:42:06 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.61.128])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Aug 2024 09:42:05 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v2] selftest/powerpc/benchmark: remove requirement libc-dev
Date: Mon, 12 Aug 2024 15:11:52 +0530
Message-ID: <20240812094152.418586-1-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: afWA52iJvVeHVwNyq0Zacm3cd2C6rY-H
X-Proofpoint-ORIG-GUID: 643BMJGiJqfGfOOJMBRWiiyTzJ5sdWLt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408120072

Currently exec-target.c file is linked as static and this
post a requirement to install libc dev package to build.
Without it, build-break when compiling selftest/powerpc/benchmark.

  CC       exec_target
/usr/bin/ld: cannot find -lc: No such file or directory
collect2: error: ld returned 1 exit status

exec_target.c is using "syscall" library function which
could be replaced with a inline assembly and the same is
proposed as a fix here.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
Chnagelog v1:
- Add comment for clobber register and proper list of
  clobber registers as suggested by Michael Ellerman and
  Christophe Leroy

 .../selftests/powerpc/benchmarks/Makefile        |  2 +-
 .../selftests/powerpc/benchmarks/exec_target.c   | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
index 1321922038d0..ca4483c238b9 100644
--- a/tools/testing/selftests/powerpc/benchmarks/Makefile
+++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
@@ -18,4 +18,4 @@ $(OUTPUT)/context_switch: LDLIBS += -lpthread
 
 $(OUTPUT)/fork: LDLIBS += -lpthread
 
-$(OUTPUT)/exec_target: CFLAGS += -static -nostartfiles
+$(OUTPUT)/exec_target: CFLAGS += -nostartfiles
diff --git a/tools/testing/selftests/powerpc/benchmarks/exec_target.c b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
index c14b0fc1edde..a6408d3f26cd 100644
--- a/tools/testing/selftests/powerpc/benchmarks/exec_target.c
+++ b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
@@ -7,10 +7,22 @@
  */
 
 #define _GNU_SOURCE
-#include <unistd.h>
 #include <sys/syscall.h>
 
 void _start(void)
 {
-	syscall(SYS_exit, 0);
+	asm volatile (
+		"li %%r0, %[sys_exit];"
+		"li %%r3, 0;"
+		"sc;"
+		:
+		: [sys_exit] "i" (SYS_exit)
+		/*
+		 * "sc" will clobber r0, r3-r13, cr0, ctr, xer and memory.
+		 * Even though sys_exit never returns, handle clobber
+		 * registers.
+		 */
+		: "r0", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
+		  "r11", "r12", "r13", "cr0", "ctr", "xer", "memory"
+	);
 }
-- 
2.45.2


