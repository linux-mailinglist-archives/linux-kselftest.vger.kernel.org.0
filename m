Return-Path: <linux-kselftest+bounces-27022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11980A3CEA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCBD3BC6DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 01:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C150192B82;
	Thu, 20 Feb 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cP6GnRiD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ECC3C0C;
	Thu, 20 Feb 2025 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014579; cv=none; b=EdnC466MsXIAx5HqcLNlOSQDO1pHcGDty4TnH9xqHfPvuXB7dMU40htXRSl0EFk0hn0aP+0GLYX9CLDpWcF2b+RWIFhXTIP4qBOCP6t4gfumMGFL06PdnikjJhwLTFAU4jeSjN083jjT1GEZOqqwEo1Uhc95XRKF9bTJLiTvPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014579; c=relaxed/simple;
	bh=F8pOXCmMq8U/32hHJyoHy6pH+LT4dwl0p0EPIInztVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AdseDYpwD8lsVbMfz5RPgRYdX67Xxez9cNLdHNSGn8iCd1aHN6xh2E1ZrpqH7qlzxR8dMb4PuyFX9KvbaUSRDZUSVlqOyEEQFx4eT9KJpoeo8lsHW1pCwUTR4T1x43D1YEXY+/sZOi2PlGsbWivNN7ZBns/+j7klRm6SoqcKkQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cP6GnRiD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JMZiPP024432;
	Thu, 20 Feb 2025 01:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=sVO3dN/k8Gv/mIaOGPguZlutQG60w
	YLU5gwhTiEZqB0=; b=cP6GnRiDgFOYzycfzYHRomfcSE2vXTftUzbXN07npwHNo
	Q5BZZ/JDYiTR5iUu3sZNfMaVbyJW+XieJDjLLlFAQmVzMjPJ0b8wBhf9Mnw3E4hz
	K9h8ZCeJxlxsouZHQ/lSmxZ9FUFeQCNVoiU58WV9dk82sgS4ZflYoGiuAAyQ94Ab
	SSDA7InU7KxKILaDZ9Y/UZmWoOqTDQo5Hjomx+56cm1lVwycPLVAEl4/IfF4jmMT
	ppsMhXkbQk6/8V10c4JKjfHTxatHechj4oulcab7G12k2KEtiPGGmJAbSHDpBpRU
	04zE1CxBE3wENUzInU3iVHymbls08RzbLeKdDB4XQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nk3em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 01:22:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JNb9oU009776;
	Thu, 20 Feb 2025 01:22:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w09d8wsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 01:22:51 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51K1MoTD012639;
	Thu, 20 Feb 2025 01:22:50 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44w09d8wsb-1;
	Thu, 20 Feb 2025 01:22:50 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: shuah@kernel.org, kevin.brodsky@arm.com
Cc: yifei.l.liu@oracle.com, stable@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 Linux-6.12.y 1/1] selftests/mm: build with -O2
Date: Wed, 19 Feb 2025 17:22:17 -0800
Message-ID: <20250220012217.1091146-1-yifei.l.liu@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_11,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502200008
X-Proofpoint-ORIG-GUID: oOk66EPKErYLLs5mzIB7vaIBcqpsu7xJ
X-Proofpoint-GUID: oOk66EPKErYLLs5mzIB7vaIBcqpsu7xJ

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit 46036188ea1f5266df23a6149dea0df1c77cd1c7 ]

The mm kselftests are currently built with no optimisation (-O0).  It's
unclear why, and besides being obviously suboptimal, this also prevents
the pkeys tests from working as intended.  Let's build all the tests with
-O2.

[kevin.brodsky@arm.com: silence unused-result warnings]
  Link: https://lkml.kernel.org/r/20250107170110.2819685-1-kevin.brodsky@arm.com
Link: https://lkml.kernel.org/r/20241209095019.1732120-6-kevin.brodsky@arm.com
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 46036188ea1f5266df23a6149dea0df1c77cd1c7)
[Yifei: This commit also fix the failure of pkey_sighandler_tests_64,
which is also in linux-6.12.y, thus backport this commit. It is already
backported to linux-6.13.y by commit d9eb5a1e76f56]
Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
---
 tools/testing/selftests/mm/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 02e1204971b0..c0138cb19705 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -33,9 +33,16 @@ endif
 # LDLIBS.
 MAKEFLAGS += --no-builtin-rules
 
-CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS = -lrt -lpthread -lm
 
+# Some distributions (such as Ubuntu) configure GCC so that _FORTIFY_SOURCE is
+# automatically enabled at -O1 or above. This triggers various unused-result
+# warnings where functions such as read() or write() are called and their
+# return value is not checked. Disable _FORTIFY_SOURCE to silence those
+# warnings.
+CFLAGS += -U_FORTIFY_SOURCE
+
 TEST_GEN_FILES = cow
 TEST_GEN_FILES += compaction_test
 TEST_GEN_FILES += gup_longterm
-- 
2.46.0


