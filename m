Return-Path: <linux-kselftest+bounces-23425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB889F353B
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 17:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB64188A38C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919BF1494D4;
	Mon, 16 Dec 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Raj1khFM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC443137750
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365023; cv=none; b=ihUpWV9Ap07qW8/Jy70/+/Yw1bvBH+1oXpT996G5SNed7n0pYZeUHKIZ99jstUvcBHmh+nUE6PWR6L0q6gDWxf30PXc55EUNqk/cY7CnMFSDtQ04mAft1rIERvl44bXrNGILkEOFmo+h+nYO8q1FjQchEec3BsenoD7RGMIJ+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365023; c=relaxed/simple;
	bh=29hEdNDTva91Lqd5u7UDg1JTuqOwMhR2hkxCClYT6tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOrEZxy0hvGhPl1aCPo3TLtURkyl8mgI277uWRHEOOLlrA7aiJgXNu1m7aVBi8w60vVtO+PnF53QU3GrYwJ48l7TJ0wC4jrSwGW85wKiPlGVXtpJFEIYSba8P0V2uR+nQduuaG0D73yTXHbm1lt7a59Sjp8xSptCM6wdoMXdhiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Raj1khFM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGCVa6s021475;
	Mon, 16 Dec 2024 16:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8pjw3Qa0Bp7zw06a8
	nTmhYIZV+qhxPVsPbu+Aqtp8Ao=; b=Raj1khFMffwmvsDNNaVFz4IHtrtjqnyjp
	uIwy2YKRNC83iCLu2wVvPFYBprpv3q04l80S57xqWEyi73dTfmR7zkf46FY5XdLC
	MNBtXwiKlb5PR44RnXnGWEgqNn/bhj7kBb88166Qys33rS40oCreNy3VXMzlkrPb
	Yhu6t/7clkJ3QOjs0dH7o+gEKtky7SOGOOToX09LKuHNgcHPXuMh3LhrhCMQsd/O
	sKJgd3wUqQpR3SPnqRNAueRlgQmUFjld6wlcMy48dMUuZmOzKJnW8JuGcKDSoI18
	EcI+ukE0jysRLOkDISA+Jhkgh1c3WW86oRySu7/GTEeDWUDbTx79Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j8xaksmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:03:27 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BGFiTu6005272;
	Mon, 16 Dec 2024 16:03:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j8xaksmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:03:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEGZLI024015;
	Mon, 16 Dec 2024 16:03:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnuk6h9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:03:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BGG3O3N56558070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 16:03:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65C8D20040;
	Mon, 16 Dec 2024 16:03:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C45F620043;
	Mon, 16 Dec 2024 16:03:19 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.70.111])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 16:03:19 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 2/3] selftest/powerpc/ptrace/ptrace-pkey: Remove duplicate macros
Date: Mon, 16 Dec 2024 21:32:56 +0530
Message-ID: <20241216160257.87252-2-maddy@linux.ibm.com>
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
X-Proofpoint-GUID: mVmwIwWHL3sNC6hcYpKyx0FODVtoW8OB
X-Proofpoint-ORIG-GUID: 7dQ864CrCqKZ__wlvCpT4uy1JWZ7ghpL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160133

./powerpc/ptrace/Makefile includes flags.mk.
In flags.mk, -I$(selfdir)/powerpc/include is
always included as part of CFLAGS. So it will
pick up the "pkeys.h" defined in powerpc/include.

ptrace-pkey.c test has macros defined which
are part of "pkeys.h" header file. Remove those
duplicates and include "pkeys.h"

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
Changelog v1:
 - Added Reviewed-by tag
 - made changes to commit message 

 .../testing/selftests/powerpc/ptrace/ptrace-pkey.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
index d89474377f11..6893ed096457 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
@@ -7,14 +7,7 @@
  */
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
@@ -61,11 +54,6 @@ struct shared_info {
 	unsigned long invalid_uamor;
 };
 
-static int sys_pkey_alloc(unsigned long flags, unsigned long init_access_rights)
-{
-	return syscall(__NR_pkey_alloc, flags, init_access_rights);
-}
-
 static int child(struct shared_info *info)
 {
 	unsigned long reg;
-- 
2.47.0


