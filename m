Return-Path: <linux-kselftest+bounces-46143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A97AC76919
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 00:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4DB24E2422
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 23:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFFE2DD5EF;
	Thu, 20 Nov 2025 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QG6h9CE+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE118A956;
	Thu, 20 Nov 2025 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763679790; cv=none; b=l4UiudASGuPsJxqtJz/zeu54cEVjw9t0bNCo9JvqpcKXH4WW0qdOGpv9fWt9d9ITljI0hJtTw/pxfHgIH13q+hzfoBMLCcjdtTEBo1FJSpZOf1zambZkGyQxX4WBssHCN1ttEKipdDDrSLuxirfgltB+RLyovKgw7oGIGTipOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763679790; c=relaxed/simple;
	bh=O1Qi6nhG/zHyyZZ5m3S3q50NgcDPuwBjbUjZcPeZgGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TE6zaHfnAHOJCZqeHJegMNRul4Cba4hKKLHf+g9NjQ8F0UGM1CdGUmT1iRPvcBBQ6GrYWH2PP5DtNsY54A3flsLp6ZEuF9+U40DtYaCw6opwlV0nhSZfsNFABllZTZpWYSAhyhiRdwNk3Ewc/sT9Gb66rhw+RZ1r4yaEALQb/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QG6h9CE+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKJgJvB026338;
	Thu, 20 Nov 2025 23:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=RsElIDttcWvAo74H8bTGmkSCUHxJ8
	gnNR8dvyyJmZ8w=; b=QG6h9CE+/8jnys2cz1Q732FDXgWe34RpMFRra6oJp1M/v
	EtkuvhWfVfb23C58VDczyHvDvRdEPL9qf2UPhxRYT6p9XcLDTungOXFWBEUI1oZE
	lFPMGg5p/GM5awQCPd2EPSJm9BCfAzDAGhukKhEedOmfq8POcPe5Off0TZtEQTcL
	8WqCOWzIjQ30E9mpU0XahYzCBwdQptDGJTrMn5axCJscVC9exOkIkEdeLy1tA7M2
	OD9mewDgtQLHFguAv28OAKqv4iOrwatCCN4QSt4PguTiSE8F2Nqhak0d9qcuaBCi
	RbxEO3QcO6UYBitqu97gs2H6kRrooqpqaCqTL6o5A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej90a7vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 23:03:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKMWcxm039958;
	Thu, 20 Nov 2025 23:03:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyq5au1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 23:03:04 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AKN34pW037023;
	Thu, 20 Nov 2025 23:03:04 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4aefyq5atm-1;
	Thu, 20 Nov 2025 23:03:04 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: shuah@kernel.org
Cc: yifei.l.liu@oracle.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 1/1] selftest/sched: skip the test if smt is not enabled
Date: Thu, 20 Nov 2025 15:02:35 -0800
Message-ID: <20251120230235.2857291-1-yifei.l.liu@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_09,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511200163
X-Authority-Analysis: v=2.4 cv=OMAqHCaB c=1 sm=1 tr=0 ts=691f9e29 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=S9UabVrJeSShYSHE:21 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=NSVNPXkua3VteFUyN44A:9 cc=ntf
 awl=host:12099
X-Proofpoint-ORIG-GUID: 8xTikaGVylB1xWtipBRNP_l9OkOfsobA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX1r7NqTz2GOOb
 rmi82ENp99pfk14yrjmat3/Vyx1OVSOyqv4uwarF+zm/RDlVVCUoPM2GP46NRHhzQ7DrWiCUWWI
 +JqEgRCypg/OeqKSY4ESvhdMDnsN7/Ss0Qxu5ZHV75Ot1EbsIKlbHYPeJ9wRjRJgBkaCjvKZNsS
 vcIy8t9Yb5FBNHLKSPUBoKfo1TlSy/39nxny2z/QHTs+aIJ6EOa6UuF9a+77L4QyA3dOHzlQ1RF
 6CbP8mINCTE59vPbBoFUJRcAN6FqByKxeNDn7Ma/Kd3gpThnbOlWcsAP89NJx24QR8z5GG2KYz2
 p8Jii7GB8S+yHYQarZE8wg1s3oldq2CGmG4r76sPxIRDkp7eQfbTC/Iyu8S0Q+h56XvK3aONOpV
 aOsBa3qFn81iy8M7U5xp0s04S6z7FpiacIbM2nX/PyDsZoukWKs=
X-Proofpoint-GUID: 8xTikaGVylB1xWtipBRNP_l9OkOfsobA

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

Cc: stable@vger.kernel.org
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


