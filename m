Return-Path: <linux-kselftest+bounces-27157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5828A3F394
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 12:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 090A77A7CDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 11:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899EF209F42;
	Fri, 21 Feb 2025 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UE6Jw2pK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE7C20ADFE;
	Fri, 21 Feb 2025 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139110; cv=none; b=lP3uWf0/1vLIukMiqkUiTgx1lAzWIG3rIV0BXXSclxt8AzeZtbkAVAd7HYdYOh5QHvHg0YwXv5dD0HPqZYn7gh/UPQ2htmyIUeHcbsT6rmLBh7U+zOjSLyHpGq5/O8FQYdZfgW3VOyG69wOlJguaPVqGAumlnrEDEMaZryIcPL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139110; c=relaxed/simple;
	bh=evbJe7R8esv335XEyu6cJsBot0ywjESiPOxZmU2lAfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPmMcyGA94/Uc7FgAkaFhlFVkr9T/0TPI4wuzH6N1nzb7kivQpCLqLzlCyBp4aBC/rEPt0R/yCcjRayFp7bhEOFP6nxwfDg7pLahiUFXZXRIlaXg5fRtgjFxSiAzrwzMTR6OGiC+aHB03P0TbAPojn8u0EyvBJANTAuUhpTCOrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UE6Jw2pK; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8faq7002297;
	Fri, 21 Feb 2025 11:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=9uhCK
	v5D2kVNL+//YA3nKHRImLpCzpU+kAkU6nfgUe8=; b=UE6Jw2pKINdf21G6TypwJ
	tfHbaDBxbVGSi1NxzIJYAXSm4Z7dZqrrC02Eiatugi9ZAnsHiyxI3GTQeZToQfrS
	3Lw1Dt21cB8rScMmEXexyBd5qCvsuRUGJk6o9S7/sAB/QKBUEHwwur0sb0en26Lm
	wdJgIi9gIzfo2ZP2nNHG2ivCH7kd+kgEGdCghCcQwEiHvV5rq6mFQCi0ysQYhFwb
	x3ILV5RMzaPoor5DVJl41r4kBWdR0/8TZ65ZMYkuOyS43JGvU67fN3EY5/loCZVv
	ySTLnfoEv30hm3HBUoCUeZ3jiK5WY+PYNmXFoIsuJda6XHsxZtdAAfylKtiOm7Qw
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00m67cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 11:58:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LBSs6i025265;
	Fri, 21 Feb 2025 11:58:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w090fsug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 11:58:22 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51LBwE9B029660;
	Fri, 21 Feb 2025 11:58:22 GMT
Received: from sishan-bugs.osdevelopmeniad.oraclevcn.com (sishan-bug36880967.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.109])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44w090fsnx-3;
	Fri, 21 Feb 2025 11:58:22 +0000
From: Sinadin Shan <sinadin.shan@oracle.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.hyser@oracle.com, sshegde@linux.ibm.com,
        Sinadin Shan <sinadin.shan@oracle.com>
Subject: [PATCH v2 2/2] selftests: sched: skip cs_prctl_test for systems with core scheduling disabled
Date: Fri, 21 Feb 2025 11:57:50 +0000
Message-ID: <20250221115750.631990-3-sinadin.shan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250221115750.631990-1-sinadin.shan@oracle.com>
References: <20250221115750.631990-1-sinadin.shan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210088
X-Proofpoint-ORIG-GUID: PUZk4VcSkA_FBp8vns6gieOHfAnLG-5d
X-Proofpoint-GUID: PUZk4VcSkA_FBp8vns6gieOHfAnLG-5d

For kernels with CONFIG_SCHED_CORE=n, the sched selftest cs_prctl_test
fails with "Not a core sched system" error. Change this to gracefully
skip the test for systems with core scheduling disabled. Exiting early
would also ensure failures reported in obtaining cookie are valid
failures and not due to the config.

Skip cs_prctl_test for systems with CONFIG_SCHED_CORE=n

Signed-off-by: Sinadin Shan <sinadin.shan@oracle.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 52d97fae4dbd8..60fd657b56c84 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -23,6 +23,7 @@
 #include <sys/eventfd.h>
 #include <sys/wait.h>
 #include <sys/types.h>
+#include <sys/utsname.h>
 #include <sched.h>
 #include <sys/prctl.h>
 #include <unistd.h>
@@ -109,6 +110,30 @@ static void handle_usage(int rc, char *msg)
 	exit(rc);
 }
 
+static void check_core_sched_support(void)
+{
+	char config[128] = "/proc/config.gz";
+	char cmd[128];
+	struct utsname kernel;
+
+	printf("## Checking for CONFIG_SCHED_CORE support\n");
+
+	if (access(config, F_OK) != 0)
+		if (uname(&kernel) == 0)
+			snprintf(config, sizeof(config), "/boot/config-%s", kernel.release);
+
+	if (access(config, F_OK) != 0) {
+		printf("Cannot find kernel config in /proc or /boot\n");
+		exit(EXIT_FAILURE);
+	}
+
+	snprintf(cmd, sizeof(cmd), "zgrep CONFIG_SCHED_CORE=[ym] %s", config);
+	if (system(cmd)) {
+		printf("Core scheduling not enabled in kernel, hence skipping tests\n");
+		exit(4);
+	}
+}
+
 static unsigned long get_cs_cookie(int pid)
 {
 	unsigned long long cookie;
@@ -117,7 +142,7 @@ static unsigned long get_cs_cookie(int pid)
 	ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid, PIDTYPE_PID,
 		    (unsigned long)&cookie);
 	if (ret) {
-		printf("Not a core sched system\n");
+		printf("Failed to get cookie\n");
 		return -1UL;
 	}
 
@@ -270,6 +295,8 @@ int main(int argc, char *argv[])
 	if (keypress)
 		delay = -1;
 
+	check_core_sched_support();
+
 	srand(time(NULL));
 
 	/* put into separate process group */
-- 
2.43.5


