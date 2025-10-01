Return-Path: <linux-kselftest+bounces-42659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32118BB1AE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 01 Oct 2025 22:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD963B497A
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Oct 2025 20:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBB12EB841;
	Wed,  1 Oct 2025 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eel3WWqg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FF12EC572;
	Wed,  1 Oct 2025 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350341; cv=none; b=sSAWXBCbd1lUc7zMdP1Mrv4OG4/0YJFVnztnb6fW4SVvStMEVifWSYoCLJ8dAIQ0mxVEJdLqpdpKwYDIoaSFpsknPYT7O3tviRj0SEP2MN4oZuxy3pzcwtAv171knOSLYGfZXyyOQvl85dOIocAnXrxwxR5+of5Mm/rxNjj0eqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350341; c=relaxed/simple;
	bh=6Wk8CDusyccx2C1wrVeSh/BLA7OD4lsyrC7YyHLQTNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5SJt3r20+2XDLsX120GbIGpV7vNJ4qymKy1D+OsqSSbOSVJbGbYHyBTxrL2U7laEW8SGVoWyhwehj5zycNFJnCxYC3OWL8DxwxzgbiM9cOU1nyExdUsmnTDYSToB3HrqvM2ZAIYOEn4HXECWcACYocLArX+yWXTMw+Qy5AcB/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eel3WWqg; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591KNQEY011562;
	Wed, 1 Oct 2025 20:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=2M7phuZr+IdoaIIbb2Tryyu3n1n0T
	1yNuxMSLp8FCxw=; b=Eel3WWqg2fH+qz9L6BpeF4avOlz9I4oG3PkR7xhBajj6w
	DjyddMfsvHxVXWuyIMhvIlS6wP/PA/ddA/7W+iWRtx7q9LiSKPqZq9lKmzWqLTNS
	FgOHx0WA6v/gz3x9wpUz/P0XsMsr89JMb3VoHu0HUJXeaMRHKvD5FRptLuw1DxLZ
	BnHefiJSbC6sVzLAVWbtkCQGBtEDUAPxWVQh6uRlIc11d18mfz6gryZ9+9xvjkEf
	UwLx9NsfQ6VOwEcvygSmMLImkhOPbQcmH5Js4EXeqsipNPOo2SXywV+8fMFLGuy7
	OnTNKtgpHnYwosYMJb/poPr6NkyD8Jm3+6Y3P0hpw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gkxnj7xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 20:25:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 591Id1Vl000703;
	Wed, 1 Oct 2025 20:25:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6cg69r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 20:25:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591KPUv7026768;
	Wed, 1 Oct 2025 20:25:30 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49e6cg69qf-1;
	Wed, 01 Oct 2025 20:25:30 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: mingo@kernel.org, shuah@kernel.org
Cc: yifei.l.liu@oracle.com, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH  1/1] selftest/sched: skip the test if smt is not enabled
Date: Wed,  1 Oct 2025 13:25:01 -0700
Message-ID: <20251001202501.3238278-1-yifei.l.liu@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010178
X-Proofpoint-GUID: dRa4wllqhzX1szk_wvsuREBidbtvRKhY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MSBTYWx0ZWRfX27TtI/6QB6ue
 QsvkBb6FZSGEZXfXf+m6AZe0r3s2HsU21XDdlJ38lL8kXjIzipP0wOx2rXFmZRJLzWCTvnqA185
 7dO/Vf/x70pTgKdtzzX5W4VbbrYA4xIaqVsZhhFR8v9RkZEhUgRDeV44qSntQljw3udQf5WG4wY
 51Rmihg7RadMImuutcr4qgUbBftk0YVBrp3x200SELnqxUY1DQdo8lGG1JezCmKhX/z5bKhnDQq
 SX77AeALJYVDv4V/wvFbl3ApOhNVbDjcwMg1FgRL/8p5LXJPL++Wy0qrWRYsOxF9KEKyY5ycE6m
 mj1r1Y3ieT/rtFlHJg5STuO7wjYEbidI5kU550+To7HutwoG9xvLZN+yh1rSR1hxoTq8Qbniwc2
 MtdLeffw6FmfU+z3nZhltCz70eObWwZ9QTcXxN1svZDh//uI0PY=
X-Authority-Analysis: v=2.4 cv=RLW+3oi+ c=1 sm=1 tr=0 ts=68dd8e3b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=S9UabVrJeSShYSHE:21 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8
 a=NSVNPXkua3VteFUyN44A:9 cc=ntf awl=host:12089
X-Proofpoint-ORIG-GUID: dRa4wllqhzX1szk_wvsuREBidbtvRKhY

The core scheduling is for smt enabled cpus. It is not returns
failure and gives plenty of error messages and not clearly points
to the smt issue if the smt is disabled. It just mention
"not a core sched system" and many other messages. For example:

Not a core sched system
tid=210574, / tgid=210574 / pgid=210574: ffffffffffffffff
Not a core sched system
    tid=210575, / tgid=210575 / pgid=210574: ffffffffffffffff
Not a core sched system
        tid=210577, / tgid=210575 / pgid=210574: ffffffffffffffff

(similar things many other times)

In this patch, the test will first read /sys/devices/system/cpu/smt/active,
if the file cannot be opened or its value is 0, the test is skipped with
an explanatory message. This helps developers understand why it is skipped
and avoids unnecessary attention when running the full selftest suite.

Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 52d97fae4dbd..7ce8088cde6a 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -32,6 +32,8 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include "../kselftest.h"
+
 #if __GLIBC_PREREQ(2, 30) == 0
 #include <sys/syscall.h>
 static pid_t gettid(void)
@@ -109,6 +111,22 @@ static void handle_usage(int rc, char *msg)
 	exit(rc);
 }
 
+int check_smt(void)
+{
+	int c = 0;
+	FILE *file;
+
+	file = fopen("/sys/devices/system/cpu/smt/active", "r");
+	if (!file)
+		return 0;
+	c = fgetc(file) - 0x30;
+	fclose(file);
+	if (c == 0 || c == 1)
+		return c;
+	//if fgetc returns EOF or -1 for correupted files, return 0.
+	return 0;
+}
+
 static unsigned long get_cs_cookie(int pid)
 {
 	unsigned long long cookie;
@@ -271,7 +289,10 @@ int main(int argc, char *argv[])
 		delay = -1;
 
 	srand(time(NULL));
-
+	if (!check_smt()) {
+		ksft_test_result_skip("smt not enabled\n");
+		return 1;
+	}
 	/* put into separate process group */
 	if (setpgid(0, 0) != 0)
 		handle_error("process group");
-- 
2.50.1


