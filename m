Return-Path: <linux-kselftest+bounces-25739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F89AA27DC4
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 22:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333681884E8B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 21:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384CA2045B3;
	Tue,  4 Feb 2025 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eEdw9Zmx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076952B9BB;
	Tue,  4 Feb 2025 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738705749; cv=none; b=c7ZtOPAd0nHU17ACEp7D3RMWuPaZS4cHH+ttwHI2DdwBH0S1qvtAL+7doRayZ3yNVfDysYbI0lgLfVV2LIYHLQSn51J88aQBGn4Jq8MzCIKG7rF1Msdds55vO767UC356uaLpwlR6OUQXm6MZM+3t4H/LM9ja0fjCyCLupu8mgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738705749; c=relaxed/simple;
	bh=VoyCxb8UgpFfW2rEKVyKoJLllE4gYUNwv3jtb+2I4zM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOKM2meoJZXkiMmCrS08H2CbDqoOnX7K8D3PwyfaSSRFgIq3wOp50bbIPrDN3aQwg6yl2XiruLUpw5LieKn/1FrOKpDagmg4FS+b3z8EN7bry5W8fmwv1X24X524CtP/ikMhGMuD6N2sujfsJWtHQgtZfHxont7/17UMlfi2hAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eEdw9Zmx; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514HBrOe019488;
	Tue, 4 Feb 2025 21:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=e4yAEXfXvMjf2zgQGoYBh4eCvFiuG
	hEbseuneSaZygo=; b=eEdw9ZmxG0ASo45H9J418giQE2OVQxBBNzJWaJL58z1t6
	GNWP9wuiQ2lZJMY5ilJ6sudgpA7K3NexhRvNmEiYe50hVkFuW55S6dWitqA/Anl5
	dDSXN4cPez16LZYxPrayeddOoVa+WKxlq/MbP0Qasgoztj1aA8D7XePhY0y1mP/8
	d1HtZJ9AGi9RbWoEb9a5ZO1m9d6N3CowQWwLSGgt2p4BjBaF8ceEonX7CQ+/LJhw
	1pkXsvf40nP3Xvd8b6m2p0veKxR5nMWFje9Jm+am9qXSext7ll5WstLgFPOrhKRO
	/MhilGv+cb+1W3FlThuvjQ1i+s76oOcxOjJzR11wg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhsv5xuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 21:48:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514KQnTW036238;
	Tue, 4 Feb 2025 21:48:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fmsw0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 21:48:53 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 514LmqCU023431;
	Tue, 4 Feb 2025 21:48:52 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44j8fmsvmx-1;
	Tue, 04 Feb 2025 21:48:51 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: shuah@kernel.org, kevin.brodsky@arm.com
Cc: yifei.l.liu@oracle.com, stable@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 Linux-6.12.y Linux-6.13.y 1/1] selftests/mm: build with -O2
Date: Tue,  4 Feb 2025 13:47:23 -0800
Message-ID: <20250204214723.1991309-1-yifei.l.liu@oracle.com>
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
 definitions=2025-02-04_09,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040162
X-Proofpoint-GUID: Jd0ZuVI91r_fpfbnJvBUnJGBlO1LJhSa
X-Proofpoint-ORIG-GUID: Jd0ZuVI91r_fpfbnJvBUnJGBlO1LJhSa

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
which is also in linux-6.12.y and linux-6.13.y, thus backport this commit]
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


