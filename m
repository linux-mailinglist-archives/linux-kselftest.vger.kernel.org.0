Return-Path: <linux-kselftest+bounces-23049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE39E9A23
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 16:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47DB1887097
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5748C1BEF64;
	Mon,  9 Dec 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ERsbdre/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4F2233133
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757291; cv=none; b=UUYQ7qdyUnZhZd6OJR6jo9FQ/FDRjEiaiiNdmOIYg4uYCe8WQYp8FQufBPFPHz4bCNXosrjn+qAFGwpOW9INFlepuuRYp1PIJN3brH790wIKzy1Yt5CmtpACDop1yjXo5ZGZBn+MBjU5clp2O2wVsTcOJCaFI/7tF/m5In4uBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757291; c=relaxed/simple;
	bh=SD+3D/wKkQoadRyru3KOAHIsyFroSyAUfI1+LxydrcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dd6srm4LiaRjqFptVAiDpo1KX3NYU9rr7MYT6qLNgN+gY7EeWdmDl5D05IFFMkBF/fccJoZoTwN8N43fSGiCmjr1uAgLChWxoTwR9TGLnTqWTaDELtpnFTrOwR9q0cl6ihFFWUEEiYX7YfHfxLjyVyjV6JxrnrnvwLyPKPpxYLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ERsbdre/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99RQvD001930;
	Mon, 9 Dec 2024 15:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Jf1DnB1tSe8lT308i
	ZmGeXnhbDqfZIragnRW7aWxZlY=; b=ERsbdre/qxblOqQjFLYpCs4jT6i/KSNkz
	pBfJrTlcETrqAunBPpVjwBefnXADW3jyYnUff53wzJkhe9CumQzyQyymsKIQg1y2
	HE53RpfoJY+0rPCbVNdy0EgmBGKjva6BGu4Fwme4H7rhyDM/iSsgHDr6iH3dwXmG
	GxLAnvsnd0BtkWOx0jiLcWZSQMjUhLrsz4t8yetYfMNdotfLlbuHWDdGaz2HaDEk
	TJl4iZsRHoRzT/y/OxrU2lNF45RVjHNcrn0hW0j249FRJa11bNbpPXO6ji/k3A2b
	1J4Q8VLRsLEbZH5u9+Hi5acnK6WA+8PAJlCp/9CqHJBv3gE9VEzmw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq1djs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:14:31 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B9F8iie032663;
	Mon, 9 Dec 2024 15:14:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq1djn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:14:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9DTqP2032727;
	Mon, 9 Dec 2024 15:14:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps7des-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:14:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9FESWO49479938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 15:14:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDA8A20040;
	Mon,  9 Dec 2024 15:14:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBCE520043;
	Mon,  9 Dec 2024 15:14:26 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.38.185])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 15:14:26 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 2/3] selftest/powerpc/ptrace/ptrace-pkey: Remove duplicate macros
Date: Mon,  9 Dec 2024 20:44:17 +0530
Message-ID: <20241209151418.348085-2-maddy@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: U8u_uvfXx34om2SxO6ddW6d7mtOzVadS
X-Proofpoint-GUID: Np7d7_hTcoh8-L7qtazuNgbDHoKACHRt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=835 adultscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090117

ptrace-pkey.c test has macros defined which
are part of "pkeys.h" header file. Remove those
duplicates and include "pkeys.h"

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
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


