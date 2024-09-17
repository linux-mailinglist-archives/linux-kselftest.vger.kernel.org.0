Return-Path: <linux-kselftest+bounces-18090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B96397B5E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 00:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD731F22679
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 22:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB6715C137;
	Tue, 17 Sep 2024 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GInociCv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2886208D0
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Sep 2024 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726613336; cv=none; b=qxLW+ZQwJyvJcqk1XoNCqYnf60d0eXnnp112Um+ZrvE8dFUJzdPV9lOh2kHFAfI+LKkjRiRFyCzY4GigBWLo844F7n1fJamkLHOndLSxYWpC+K98DZOUKJVe7H9Pp5Zc2Gd3vCbMrbKXs8BvidkqG9czdy2dtjb3tgTtb7HJq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726613336; c=relaxed/simple;
	bh=AriLwkpfoyFT/IKHXxvVR0BtaWOSLp9aj1aMh+7jQNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxAgp2dWKPUZiAswRKUnFt1LYEs23KmGgS3fMKuVhAiO2/TLLFF+KuscHEWwh0T4uSTcYIq7kjkHCmuBjjxiBCFzJxwPPhzhK8ntqURuLp012zMp1tm//3GFIdgxvOXVKpbnrczu2nMK8eiYKKS+Zt1aPxtbSUHMkJ+Iaq4LrpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GInociCv; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HLfvbO017200;
	Tue, 17 Sep 2024 22:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=1KSYt8eGi1E0/k
	2Di3Dx7xQRYNNgQ1OkwzLRcWyA14w=; b=GInociCvyNacoleYOzcWAPyHb5ZHOR
	cKjiKiR/c+CSyVm9c0vph3+Z+STVSiGgZRNw0fCGVTE6nkZufy4EIteLRkDy+YI1
	+T4O3IrIhnPgKEZwcGb9aQrr6GRj2vi5BVU7OdpjN6yasGFn7DxboulRcmngjz5K
	mp40qhoEhk1gwJ85aLpDTWg0tfMaSu/9jXI2GAJVz1J8fhoww2MXfSNFkgzyDfXB
	WNu8ShpciCfhZmA4KTPinkzxEWAgiIq/Dk11NyGDllUm7gVC3bqi82A+raCiJyKU
	NbrYsSDD0PXmRBLcSHAsr5+gR5Cgqdx47xeAmqAhfX8poMn6++m4RtEA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3pdq9tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 22:48:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48HLwddK017845;
	Tue, 17 Sep 2024 22:48:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycx7qvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 22:48:49 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48HMmm8c033446;
	Tue, 17 Sep 2024 22:48:48 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nycx7qtr-1;
	Tue, 17 Sep 2024 22:48:48 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: shuah@kernel.org
Cc: yifei.l.liu@oracle.com, linux-kselftest@vger.kernel.org,
        ramanan.govindarajan@oracle.com, sinadin.shan@oracle.com
Subject: [PATCH v6.11 v5.15 v5.4 v4.19 1/1] selftests: breakpoints: use time passed to check if suspend succeed
Date: Tue, 17 Sep 2024 15:48:37 -0700
Message-ID: <20240917224837.478684-1-yifei.l.liu@oracle.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_12,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409170162
X-Proofpoint-GUID: atSex7f4MYXe9WHlIzd_jwcwcrpg1H_7
X-Proofpoint-ORIG-GUID: atSex7f4MYXe9WHlIzd_jwcwcrpg1H_7

We recently notice that the step_after_suspend_test would
fail on our plenty devices.  The test believesit failed to
enter suspend state with

$ sudo ./step_after_suspend_test
TAP version 13
Bail out! Failed to enter Suspend state

However, in the kernel message, I indeed see the system get
suspended and then wake up later.

[611172.033108] PM: suspend entry (s2idle)
[611172.044940] Filesystems sync: 0.006 seconds
[611172.052254] Freezing user space processes
[611172.059319] Freezing user space processes completed (elapsed 0.001 seconds)
[611172.067920] OOM killer disabled.
[611172.072465] Freezing remaining freezable tasks
[611172.080332] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[611172.089724] printk: Suspending console(s) (use no_console_suspend to debug)
[611172.117126] serial 00:03: disabled
--- some other hardware get reconnected ---
[611203.136277] OOM killer enabled.
[611203.140637] Restarting tasks ...
[611203.141135] usb 1-8.1: USB disconnect, device number 7
[611203.141755] done.
[611203.155268] random: crng reseeded on system resumption
[611203.162059] PM: suspend exit

After investigation, I notice that for the code block
if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
	ksft_exit_fail_msg("Failed to enter Suspend state\n");

The write will return -1 and errno is set to 16 (device busy).
It should be caused by the write function is not successfully returned
before the system suspend and the return value get messed when waking up.
As a result, It may be better to check the time passed of those few instructions
to determine whether the suspend is executed correctly for it is pretty hard to
execute those few lines for 4 seconds, or even more if it is not long enough.

Fixes: bfd092b8c2728 ("selftests: breakpoint: add step_after_suspend_test")
Reported-by: Sinadin Shan <sinadin.shan@oracle.com>
Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
---
 .../selftests/breakpoints/step_after_suspend_test.c      | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index dfec31fb9b30d..d615f091e5bae 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -18,6 +18,7 @@
 #include <sys/timerfd.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <time.h>
 
 #include "../kselftest.h"
 
@@ -133,6 +134,7 @@ void suspend(void)
 	int timerfd;
 	int err;
 	struct itimerspec spec = {};
+	clock_t t;
 
 	if (getuid() != 0)
 		ksft_exit_skip("Please run the test as root - Exiting.\n");
@@ -152,8 +154,11 @@ void suspend(void)
 	if (err < 0)
 		ksft_exit_fail_msg("timerfd_settime() failed\n");
 
-	if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
-		ksft_exit_fail_msg("Failed to enter Suspend state\n");
+	t = clock();
+	write(power_state_fd, "mem", strlen("mem"));
+	t = clock()-t;
+	if ((int)(t) < 4)
+			ksft_exit_fail_msg("Failed to enter Suspend state %d\n",errno);
 
 	close(timerfd);
 	close(power_state_fd);
-- 
2.45.2


