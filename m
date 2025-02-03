Return-Path: <linux-kselftest+bounces-25622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 111DCA267EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 00:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98862164D9F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 23:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4261FFC73;
	Mon,  3 Feb 2025 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FEVVgcM4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13221E7C19;
	Mon,  3 Feb 2025 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738625699; cv=none; b=t+P3wKEsEm031zO9s4LUFNIBAQ8J5hiwFFmCwji0CMdBK+dqgBx2CnqovUBmckG3MxTDIaZ0szR7RcLu1Bo/2L3i8fDLk1OZm2O9KTrKgDub8BZEwBqFitVpivf1x/bWrADtvD0HGaByBxWO1vQju5qF9ICdfg/GynjNKjHEdxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738625699; c=relaxed/simple;
	bh=Vg73nH8RurlRZHXDRzWEAZt1britzIMXAQ9pdHhGnvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/xJfVGngSgtZT4tCqA5MBMyQnnd0rGX+UArXT6v26/NECcyPfqDFp632Y4AbeDjguzviSdUXeHATEWg81RFXcQWojvbin4Ve2luUliMelVcKzdKjY4wVSOYNBlJ1a/ACbqeF8ND6l9/HyrhodpOc9np2XRferVBZ6AHN5hIRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FEVVgcM4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JMsMO001589;
	Mon, 3 Feb 2025 23:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=2QBCebSBE+pFbANYL47TiwglN3Emj
	NdNI3873/la3KQ=; b=FEVVgcM4SJIDNKZhvrG4IDZ4+p7KPosG+3wEqJG55epAx
	mmuGVyyH0MUywwlF18g0rPjpXLD8EkSCTqySqpBpag1goAjGtZg9qFWXl+ynHUxT
	iirAsC3TB7U6kD4HAd9JYBeEOK+XYzxO24T9N1W5HzSE1AY8BVbrumaXNWPDVK+e
	OwfhzzADFssS3mHJvMkm4pr3E9b7gi1hB2kD07AzAuKLH9CHdWMkQX1NqOHr721y
	ZQtBlOspkGPO/5igfEfyzIlVIhWeoXiYkfdv5ALRxBXk4EayGa0Gcdhq8OcJ8PHk
	i4uIrAzztEkyQESYuThZ6iutqLSmFyMc+AID191HQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfcguwwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 23:34:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 513NWEeW036229;
	Mon, 3 Feb 2025 23:34:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fkhay7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 23:34:51 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 513NYo8O016962;
	Mon, 3 Feb 2025 23:34:50 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44j8fkhay1-1;
	Mon, 03 Feb 2025 23:34:50 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: kpm@linux-foundation.org, shuah@kernel.org, kevin.brodsky@arm.com
Cc: yifei.l.liu@oracle.com, stable@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH Linux-6.12.y 1/1] selftests/mm: build with -O2
Date: Mon,  3 Feb 2025 15:33:42 -0800
Message-ID: <20250203233342.51041-1-yifei.l.liu@oracle.com>
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
 definitions=2025-02-03_10,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502030172
X-Proofpoint-GUID: 3eg4j6BaGbnZJQxRao_hCbNYEfxUuHpj
X-Proofpoint-ORIG-GUID: 3eg4j6BaGbnZJQxRao_hCbNYEfxUuHpj

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
which is also in linux-6.12.y, thus backport this commit]
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


