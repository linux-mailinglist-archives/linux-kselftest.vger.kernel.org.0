Return-Path: <linux-kselftest+bounces-23424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18009F353A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 17:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8BD1884D85
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BE814A095;
	Mon, 16 Dec 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HpfnXVhQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A787F1494D4
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365017; cv=none; b=c88Klbye87yq9rZKlC5jZYkiB3EcBYVFEmlGxx3sB3bOjcezYzi3FDDa7cZYo0Ke0VrMG+2WwgRZTF9VAFQJ1b+y/UDr3jvQjMzHsGiXrVosvErfy1F1gg1O8T383Lt9v4Fj3CSP9k/9FtOP1QzcViYgqWI/goxLnntwTefnPwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365017; c=relaxed/simple;
	bh=5JS2Y8X/wXgFLZXSNEQSP0twWKMYbtLfcH70TlG/pIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4ujzUZqNWxA/sC/nrOHD/326ZIEkprAoujWTt4ARTbckJnM/VddKd31HZH8bmyfjyNhiAcpsjYQw53UOT9fQssShIU4sqqI9MZZ5EGGtgeus1cpArBhi5q9SQP5oWIEM9YP6G4HQiA3YZLGvVE+Vq8ePzgoR5k4zSANgyOGqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HpfnXVhQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG85ZAR027025;
	Mon, 16 Dec 2024 16:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RCVLKfhWJCbjaMmnXe6N2Zyz7tcxzv6poeIYndSnn
	rY=; b=HpfnXVhQgfPVWU71I7K7DK+MVz0iF2CwAPTDZcVfFwFPXcA6LgCx8mbTx
	gFTnMbcZDxKjtbT+0fCIgeRxhiYjh3bvJwNUxE/DQoEoLD6cLPdGmAJg63YYOo+m
	M4mXl8vldFWqAjwkAZHmuh5oM/hEqhSAjLxohFQMMHxkyXVII/4nikrm8MDUk6OT
	3sQ8Xs/iObcZHrkT5Udq8iiK7gNPwFyXqVdLGpV7alCABhGmozictDzT0HaUecpd
	SsDCJV7e3n6hfYzxT2O5uqfM60MXTlki6Iq3j9jO7HSU53HLzXPrp3RaGeXOb/FE
	VXjh8z8JN7Ib4ep+5f/SrWFmM/nxw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd2a6uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:03:16 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BGFvOar002125;
	Mon, 16 Dec 2024 16:03:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd2a6ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:03:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGDGd2J014335;
	Mon, 16 Dec 2024 16:03:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqxxqvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:03:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BGG3CwO56557832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 16:03:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE7B020043;
	Mon, 16 Dec 2024 16:03:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5257F20040;
	Mon, 16 Dec 2024 16:03:08 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.70.111])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 16:03:07 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 1/3] selftest/powerpc/ptrace/core-pkey: Remove duplicate macros
Date: Mon, 16 Dec 2024 21:32:55 +0530
Message-ID: <20241216160257.87252-1-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FqP9MSwlZrjK36Tm0lLUCbHYkzUOpM49
X-Proofpoint-GUID: iZYQ-MdNYGFseBY_YtM2APteLGAeyohr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160133

./powerpc/ptrace/Makefile includes flags.mk. In flags.mk,
-I$(selfdir)/powerpc/include is always included as part of
CFLAGS. So it will pick up the "pkeys.h" defined in
powerpc/include.

core-pkey.c test has couple of macros defined which
are part of "pkeys.h" header file. Remove those
duplicates and include "pkeys.h"

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
Changelog v1:
 - Added Reviewed-by tag
 - made changes to commit message

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


