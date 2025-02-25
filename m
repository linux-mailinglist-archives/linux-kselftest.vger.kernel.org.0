Return-Path: <linux-kselftest+bounces-27530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7DDA44C07
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 21:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D4A189E24E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 20:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764A20FAB0;
	Tue, 25 Feb 2025 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hj+G5pO8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312C664C6;
	Tue, 25 Feb 2025 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514178; cv=none; b=qkGmEhtXeu2yGUWhgheVw6gZAk4C5zAnJIZof0JNlfgjisAafWh7ZjasTMPlSE2IPrvkNrrOWJZxgLYjniTHC/6esAh+p7U4yD7KRH8n1thBW7mExg9MKTWv4AwiInaZuh7fMIDJ76/WkcHVFIHOadF1gR89wfCqsn/TT+W/KGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514178; c=relaxed/simple;
	bh=t6FX7aiyLcuF+EBK+sm1jtBKgO+cgZnG8RW8hEwGgJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=todJmOQUUeX4oPFpt4Z8Js+a4F7dco1GEheGxyA6Vpr4KnI2MV64Ypv7pMUSlKBLd8cN8dt0j6EZpZfazQG+T2SGGeUwPRWIFKNa/kOwRSanijCmR6zV8wxFhNmiQCj9j9SUqS2SD+dAL8ABPq209p8EskzrMSwD15NxAiMvWeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hj+G5pO8; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PIXkB3026181;
	Tue, 25 Feb 2025 20:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=n1mC9
	zPGNwKL8lTZ1e+ewcz0xtS8oHnw63G64cKjM/E=; b=Hj+G5pO8RPeVhQmd7dMVg
	79DHldrCHw0P0Anm1xqB8okLq5TXn9u0xqvvBj6zQOisVMJ5saWv6PWAHJghioA5
	sz6L/o7hrCsklLGQvpmRNWUFrP1x/C38EpiFg8BnUp3t//WBg8KlhSxjEkFxK2Ja
	/FXpSHRwKE/OxDi0d3J1fP8TnhMP/srl6ns0VX8wrMsYo8miLdX2UTsmIQHmOXuq
	xf7IAbBTcq0eJG+A2QnTwoKY1me8BmNqgOhCd29qVGGzPRXPV/Gqan0EbC6L7lrm
	HeDxDW12kPA5zVyj0i5JphMM6nFxIcSBIOYSUHh92O1W3bIZu5z1fd+Ock3JfBY9
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y56067uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 20:09:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PJ4E2s025528;
	Tue, 25 Feb 2025 20:09:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51g9yum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 20:09:30 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51PK9QpX011891;
	Tue, 25 Feb 2025 20:09:30 GMT
Received: from sishan-generic.osdevelopmeniad.oraclevcn.com (sishan-generic.appad1iad.osdevelopmeniad.oraclevcn.com [100.100.231.227])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44y51g9yrn-3;
	Tue, 25 Feb 2025 20:09:30 +0000
From: Sinadin Shan <sinadin.shan@oracle.com>
To: shuah@kernel.org, sshegde@linux.ibm.com, chris.hyser@oracle.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sinadin Shan <sinadin.shan@oracle.com>
Subject: [PATCH v3 2/2] selftests: sched: skip cs_prctl_test for systems with core scheduling disabled
Date: Tue, 25 Feb 2025 20:09:10 +0000
Message-ID: <20250225200910.260569-3-sinadin.shan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250225200910.260569-1-sinadin.shan@oracle.com>
References: <20250225200910.260569-1-sinadin.shan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_06,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250122
X-Proofpoint-GUID: EfVJsXmgymTraPvFSI5KDg5oUxi4oLKQ
X-Proofpoint-ORIG-GUID: EfVJsXmgymTraPvFSI5KDg5oUxi4oLKQ

For kernels with CONFIG_SCHED_CORE=n, the sched selftest cs_prctl_test
fails with "Not a core sched system" error. Change this to gracefully
skip the test for systems with core scheduling disabled. Exiting early
would also ensure failures reported in obtaining cookie are valid
failures and not because core scheduling isn't supported.

Skip cs_prctl_test for systems with CONFIG_SCHED_CORE=n

Signed-off-by: Sinadin Shan <sinadin.shan@oracle.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 52d97fae4dbd8..5b0047b50e640 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -109,6 +109,36 @@ static void handle_usage(int rc, char *msg)
 	exit(rc);
 }
 
+static void check_core_sched(void)
+{
+	unsigned long long cookie;
+	int ret, num_max_process;
+	char buffer[32];
+
+	FILE *fp = fopen("/proc/sys/kernel/pid_max", "r");
+
+	if (fp == NULL) {
+		perror("Failed to obtain max process number");
+		exit(EXIT_FAILURE);
+	}
+
+	if (fgets(buffer, sizeof(buffer), fp) == NULL) {
+		fclose(fp);
+		exit(EXIT_FAILURE);
+	}
+
+	num_max_process = atoi(buffer);
+	fclose(fp);
+
+	ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, num_max_process+1, PIDTYPE_PID,
+			(unsigned long)&cookie);
+	if (ret == -1 && errno != ESRCH) {
+		perror("prctl failed");
+		printf("Core sched not supported, hence skipping tests\n");
+		exit(4);
+	}
+}
+
 static unsigned long get_cs_cookie(int pid)
 {
 	unsigned long long cookie;
@@ -117,7 +147,7 @@ static unsigned long get_cs_cookie(int pid)
 	ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid, PIDTYPE_PID,
 		    (unsigned long)&cookie);
 	if (ret) {
-		printf("Not a core sched system\n");
+		printf("Failed to get cookie\n");
 		return -1UL;
 	}
 
@@ -270,6 +300,8 @@ int main(int argc, char *argv[])
 	if (keypress)
 		delay = -1;
 
+	check_core_sched();
+
 	srand(time(NULL));
 
 	/* put into separate process group */
-- 
2.43.5


