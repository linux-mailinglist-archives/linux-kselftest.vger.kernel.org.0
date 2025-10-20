Return-Path: <linux-kselftest+bounces-43573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D8BBF31E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 21:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C71B40046B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 19:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAD624729A;
	Mon, 20 Oct 2025 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J1KvD47Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E95A926;
	Mon, 20 Oct 2025 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987506; cv=none; b=SKnjiOush79qWHKFYYd0tmM8nBM36LyH7JZWqN7n1PwATYT3B8kybwZ+AY1+ZAPbhcGpIBZIixF16GiJ9Fb6EbUccVHytpFDwyumRno1GC3kN77heGAlNinM9fxoGTULBcMBMNI9gavOdU7lH7E3OJwGQ+/nEH3JlfC7Ey+1vaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987506; c=relaxed/simple;
	bh=O1Qi6nhG/zHyyZZ5m3S3q50NgcDPuwBjbUjZcPeZgGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5eQ5lIO5TqDTPcDyOMRsj36wvSjKsYZxvg9p36rPwLkTV7lP984L4ER8WAuPnTuy21vijacDp9KSfBAFinAmE56knFNquc22n+3FxxKQ4SHt35R/8UOwynLde/aer8yukvzMMC0h03nZwGmcqKyLznbmp6s+j1dN2xxy9zKMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J1KvD47Y; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFk1Ip011392;
	Mon, 20 Oct 2025 19:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=RsElIDttcWvAo74H8bTGmkSCUHxJ8
	gnNR8dvyyJmZ8w=; b=J1KvD47YbOn0PZY60UxRZGljB3j4wGqNTlycvKghbw/rO
	RjWLC+NgDQKK7GMlrGxVA1svoZgpdwv6pux+YUtm6dxilv/8Uz2S+FXrqdhgiuAw
	pj22G/by16TcKfJhh8UsXaBJE6IsxEJIbq0uVIQaEZpOVHSRy3rRZPWYofUyygdM
	Ja6Y411NnwCmpSl8wY6OuOYOcYTx8SPlEzML+yElEbMKlZwUqzUmGujoE66fLNse
	Kchd+rXvmMbR3sVUy20EVRUnB46l6jIRc+UsefqLQIWY4oHd3pycii14ikhJdQ0Y
	o9Nw6qM1AHfB9GUNbijIv4NKkG8/qxhWb+/hoL/mQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2yptwft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 19:11:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KI1cm2025438;
	Mon, 20 Oct 2025 19:11:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bb1y8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 19:11:40 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59KJBenh030711;
	Mon, 20 Oct 2025 19:11:40 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49v1bb1y8f-1;
	Mon, 20 Oct 2025 19:11:40 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: mingo@kernel.org, shuah@kernel.org
Cc: yifei.l.liu@oracle.com, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 1/1] selftest/sched: skip the test if smt is not enabled
Date: Mon, 20 Oct 2025 12:11:07 -0700
Message-ID: <20251020191107.714245-1-yifei.l.liu@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510200159
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX8yyhV4cedz3X
 xV9CBD5dLMslu33FPdp+yhe8GwI5C9NkmWyf/ibqISJTj0LtwQUNJFbn+OcZM7ycHyhcE+pkFUL
 5YwD1NTTd5kWiDf++XkbOgXR22uUZ4OCydpLU3lI7UqAGQ6ER/KRoiV/g9+Lr9QiMJ4CMyRcKpC
 VsLOTjDSpUM9yv8oYo14iiZmCgjlGru3MaJmXQSBqddFnlr51QlJ2BRV7Fk/i/z3L7dlxHbOEBA
 M0Vnor+W8OJQ/5igosRfpsTu/1Jh9iStNPPwm/MFu2QHvkT2zir5K5HlmvbdLV/6WlTYHutvNj8
 vLDq+cwNDaHhNTEoRXUtzsf83q8YgByJVU4+3s39mQsJqD8bLgGyXWhHPiAa4JoY8EKRucPWF0h
 eNcV770QvKGYGkKI56yF7fDugxTXjA==
X-Proofpoint-GUID: clhdCPniDogBct12OO7Qj1YuEQqpEERW
X-Authority-Analysis: v=2.4 cv=Db8aa/tW c=1 sm=1 tr=0 ts=68f6896d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=S9UabVrJeSShYSHE:21 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=NSVNPXkua3VteFUyN44A:9
X-Proofpoint-ORIG-GUID: clhdCPniDogBct12OO7Qj1YuEQqpEERW

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


