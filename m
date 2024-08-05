Return-Path: <linux-kselftest+bounces-14787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E5947754
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 10:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CB1281AD5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917B16BFB5;
	Mon,  5 Aug 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ojXCZUqa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252D1494D7
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Aug 2024 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846645; cv=none; b=ZmlKXLTNaOpXxu3sjoZY+8RcHch9BpwJdZJ0voONNnqCwxIWTp0e0sBEw6XNpVNYeCk6RSNGznyC6qVvfKbVFvZduwNSaOzoDIN0fuP2qtG31Nec64LW7+yrsxz4UZzIT/fgWNJY3mysO3BgsEcjpfkGDxd4MdDdcRiX98yGlP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846645; c=relaxed/simple;
	bh=vh6m3DXlOSTU9mE/qg80HwyKoygyyyjNi2pjGAL7FHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5R2ZcMt4wZkrD4tobtDvQPEFX+kkkIeGqc6wXkUUMrBxJMEjoh1phF/M3PGFWSeB2H/FPouejl8OTA1/3t+4v3pv8a8/ojPpOswsYOkxxM1JoTN+NONkq8EkHu7gGerdvw6KLRtYYw0lGXU0MfdISYy2NGlzRGW/IcNF2dCE7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ojXCZUqa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4757QvH0019471;
	Mon, 5 Aug 2024 08:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=aU1juYkRWLxHWYuhJnl41ZEMkN
	6C7AcnKWhOslnC960=; b=ojXCZUqaHb16zvJyMYZAwiSJ71d22TKVCig7Kr5JR0
	PRO9q0780GmvRzXrrmwlXK9TKYi8DnMK4xLmXbhWhNc0kWuk8lV9DhW+Q0YBTWQg
	6ASr7TEt12ywKoqEk3oEZn3Ev1ZliPyKLgdLkHWlVFX/9mm0KfVi4HRrkPkNSsJE
	bYHekVl2F4RGfoSCjlvyJUU/mW+eKFThhdwbqEfhOsHg5a8VSaesD0K5RJi20ebA
	8VKg4cmOx4LP5iW88jX8AUBSec3gNbZtUyzSX2uYwxpFL6SKLMKkW/2SqrphiT0P
	TfPmvMkHzUfWU5N0SYhq/asJomg3iDRxOvt1jp6gNqZA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40tqr6rebw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 08:30:27 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4758URQa027719;
	Mon, 5 Aug 2024 08:30:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40tqr6rebt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 08:30:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47571VfY024333;
	Mon, 5 Aug 2024 08:30:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy90dmj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 08:30:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4758UMmo34406930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Aug 2024 08:30:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A08BB20063;
	Mon,  5 Aug 2024 08:30:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31C4F2004E;
	Mon,  5 Aug 2024 08:30:20 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.50.105])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Aug 2024 08:30:19 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH] selftest/powerpc/benchmark: remove requirement libc-dev
Date: Mon,  5 Aug 2024 14:00:08 +0530
Message-ID: <20240805083008.1300853-1-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UcCnTbyK5E7krc1rj4KnJDBa9WzhoXKR
X-Proofpoint-ORIG-GUID: InY13efj-2sAbO-N9ep6oEVo7VPdG_GP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050059

Currently exec-target.c file is linked as static and this
post a requirement to install libc dev package to build.
Without it, build-breaks when compiling selftest/powerpc/benchmark.

  CC       exec_target
/usr/bin/ld: cannot find -lc: No such file or directory
collect2: error: ld returned 1 exit status

exec_target.c is using "syscall" library function which
could be replaced with a inline assembly and the same is
proposed as a fix here.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 tools/testing/selftests/powerpc/benchmarks/Makefile    |  2 +-
 .../testing/selftests/powerpc/benchmarks/exec_target.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
index 1321922038d0..ca4483c238b9 100644
--- a/tools/testing/selftests/powerpc/benchmarks/Makefile
+++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
@@ -18,4 +18,4 @@ $(OUTPUT)/context_switch: LDLIBS += -lpthread
 
 $(OUTPUT)/fork: LDLIBS += -lpthread
 
-$(OUTPUT)/exec_target: CFLAGS += -static -nostartfiles
+$(OUTPUT)/exec_target: CFLAGS += -nostartfiles
diff --git a/tools/testing/selftests/powerpc/benchmarks/exec_target.c b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
index c14b0fc1edde..20027a23b594 100644
--- a/tools/testing/selftests/powerpc/benchmarks/exec_target.c
+++ b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
@@ -7,10 +7,16 @@
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
+		: "r0", "r3"
+	);
 }
-- 
2.45.2


