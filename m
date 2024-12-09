Return-Path: <linux-kselftest+bounces-23048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0629E9A20
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 16:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFB528373E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E471B424E;
	Mon,  9 Dec 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C99Js8t5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FD233133
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757285; cv=none; b=WdRUV/NijWbUyg4C41UBEu8mXFj3YFN632d7qKFbp9jpK/id3LueIX/YKdzibaeinvLdyOTDbE1+6yAHrWrb+3TRV8DwM0y9AFaeAQbkuMr3oXsRvgttYxrwzxkW9AH/6y6P5vHWB7ZTAMD7GOxb5CoPN16eNmyJuyKRZ/5Sjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757285; c=relaxed/simple;
	bh=AxP0ZoQquoHpdN1DjX4Jn/8NqUN81Dn0TMd87V8aTSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BCC16AJumLh/ClU9K42D9fiwfoEW5Y8Q08l923m49XUfJx03gLOZYucVWUs3LFvxly76cH9j9f048zJpyzqBqKRpqcN7BzJiMYh0HVjL2FSi6OpW10uFaZGTjc0Ap8gMpz6lwCKHIuw8xu9TcBXBB0nzYqwptVhfOBeAaxUFIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C99Js8t5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99tMFo012694;
	Mon, 9 Dec 2024 15:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LmIRy0hQyWfVQsj22M6r9H2LJI7thfpO4bx0jVaDu
	TA=; b=C99Js8t5ly1KfohB6u0/aTVf6G4e67ItnWttkqvwKwDhjYGS5oGHwwrCq
	KvoUHVMRprxRQ/HbovHlT7SvnUsnpC3q2r2LjeiOANP8MNJX93nXgIS776SW1KL+
	nc6+8qlSm5/ZnAHFJHdj4hD2RkWShx27UaEaCa2bLoi718bODgx4+ahnw6vfcdQR
	cyCO+6YTUEK03vbUyJTOFz2hUDeKRIzb170lwWs4wKUsfWk3oDb4tStA765r9mny
	izD3lgEdAwaZQAj6Wn3b519bTOYbeysFE/3UkO744hJEQZ4JE4oL8bO+zSPOBhGG
	JrFVvU0CacjBPv3iDjtC5P/94ThUg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vj19p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:14:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B9F4wsw029873;
	Mon, 9 Dec 2024 15:14:27 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vj19j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:14:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9DUd6L032739;
	Mon, 9 Dec 2024 15:14:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps7def-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:14:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9FEORE48431580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 15:14:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA4532004E;
	Mon,  9 Dec 2024 15:14:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B54220043;
	Mon,  9 Dec 2024 15:14:22 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.38.185])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 15:14:22 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 1/3] selftest/powerpc/ptrace/core-pkey: Remove duplicate macros
Date: Mon,  9 Dec 2024 20:44:16 +0530
Message-ID: <20241209151418.348085-1-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZI2SEWgTG1VJinRbLkvfTq-3MbHG4YEl
X-Proofpoint-ORIG-GUID: m5Cn0xHP-2LDINIu4JG_4tN8upeXt_5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0 mlxlogscore=969
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090117

core-pkey.c test has couple of macros defined which
are part of "pkeys.h" header file. Remove those
duplicates and include "pkeys.h"

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 .../selftests/powerpc/ptrace/core-pkey.c      | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/core-pkey.c b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
index f6da4cb30cd6..31c9bf6d95db 100644
--- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
@@ -16,14 +16,7 @@
 #include <unistd.h>
 #include "ptrace.h"
 #include "child.h"
-
-#ifndef __NR_pkey_alloc
-#define __NR_pkey_alloc		384
-#endif
-
-#ifndef __NR_pkey_free
-#define __NR_pkey_free		385
-#endif
+#include "pkeys.h"
 
 #ifndef NT_PPC_PKEY
 #define NT_PPC_PKEY		0x110
@@ -61,16 +54,6 @@ struct shared_info {
 	time_t core_time;
 };
 
-static int sys_pkey_alloc(unsigned long flags, unsigned long init_access_rights)
-{
-	return syscall(__NR_pkey_alloc, flags, init_access_rights);
-}
-
-static int sys_pkey_free(int pkey)
-{
-	return syscall(__NR_pkey_free, pkey);
-}
-
 static int increase_core_file_limit(void)
 {
 	struct rlimit rlim;
-- 
2.47.0


