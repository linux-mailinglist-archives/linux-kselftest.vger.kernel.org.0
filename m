Return-Path: <linux-kselftest+bounces-25266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67A8A201D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 00:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556433A449B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 23:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031A71DAC88;
	Mon, 27 Jan 2025 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YPAFvuuu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCBC1DA10C
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021541; cv=none; b=moIWIJwPdRthKUrPqFIxjyXErJfUGbBZ/33d7Ke329I0vvHYqKYlgooTUxE87iDNlXyoZpWKw2zJPHCadxC71qW6JtUZuW8YfwoBNmATtQOpYIw/a9XA2SzAUf3+HkQDEpzvHlCVY9ZsukQeCjjj6ZsCEKb/Iy0HSKvdX2/nRlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021541; c=relaxed/simple;
	bh=Vg73nH8RurlRZHXDRzWEAZt1britzIMXAQ9pdHhGnvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rgeof7iI9RRv9vM2F3bE4gH1gUSkI8/VM8igvizOA2x35MtVjRPdMO2dFeoou1kvm+Oe/Z8Agg/ySDAjldD0P0hHuJL9DqijM4dMMRObcvZRJSzRT1WHM8M3qsq/2TyN5ibbihUL1T7bKVVa5IG+B8RdVmCIRr8FEIoW8hLpgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YPAFvuuu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RMW2ww027780;
	Mon, 27 Jan 2025 23:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=2QBCebSBE+pFbANYL47TiwglN3Emj
	NdNI3873/la3KQ=; b=YPAFvuuuoaj8aE4TuLgzE9SkP3gFf9FreJfcX6Z5B7sc3
	+u2Bxpyl/vjRB46Mw/x14mP/21O7DTB+yh5wL3sj6NMlIqMEpl5EHk73d8vyh/1R
	rD4nal7NB7+nOg9mjbz22xAQ8eTrEnr3EG9uVmguqxb9GdjMsQvWcWe7AbQSAbdK
	CUigz1vZhB1rQpXj7o0YoTir38HJRWu4lkKoAEbB618qmNK11iFXfa0BN215Zp8S
	KZ2OD7USs+++fw+AJu+00gYAV1GSaUHIbW3FvTB6JTz7mc3BqQQFEcUwYuCDUZQC
	qowfiOxaeUVgsADH0299UKj8UCOX1TBXdmbxZ+YIQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ehww89tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 23:45:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50RMQA6W034141;
	Mon, 27 Jan 2025 23:45:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd7n7vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 23:45:33 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50RNjHR1040353;
	Mon, 27 Jan 2025 23:45:32 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44cpd7n7v5-1;
	Mon, 27 Jan 2025 23:45:32 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: kpm@linux-foundation.org, shuah@kernel.org, kevin.brodsky@arm.com
Cc: yifei.l.liu@oracle.com, linux-kselftest@vger.kernel.org
Subject: [PATCH Linux-6.12.y 1/1] selftests/mm: build with -O2
Date: Mon, 27 Jan 2025 15:45:21 -0800
Message-ID: <20250127234521.3820666-1-yifei.l.liu@oracle.com>
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
 definitions=2025-01-27_11,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270186
X-Proofpoint-GUID: 9INxnUYoa26gQLMGY4zMYWqLgh6Wj3zG
X-Proofpoint-ORIG-GUID: 9INxnUYoa26gQLMGY4zMYWqLgh6Wj3zG

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


