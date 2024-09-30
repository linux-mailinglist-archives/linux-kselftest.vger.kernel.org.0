Return-Path: <linux-kselftest+bounces-18689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B305498AE7B
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 22:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F306282B6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 20:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A6A1A0BE3;
	Mon, 30 Sep 2024 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IE2Jypug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF51A0AFA
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728579; cv=none; b=TXE6cSfmHcy+MI0gtMJd6jQ0Wa4KqBWA9X0gBmRD59WCUGChuOeHXGFy2DYIUnOWwjK0+eUccTNGfnhA/oVu3vD2DEYBlpwMBrLgC+KM+obGLKERxuQo6l3JfcoDF8fbQWP1IQ94NRiJsoxnnqZ2tB2b8GZ0n33F8lGnsgQ+axg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728579; c=relaxed/simple;
	bh=fjj+H27SITZvSaj8uGxIke26HuuV0UX+i0tHiqKA1HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPKCZfNwE36XlIhKK4Rcmsrwl32HE03hs7OZrbrm98hImO7BWjaPfYf/2PhQ2PuhoVLIJ1lX8Lmrw28apkEobkB4+LyjiXeNQ5jFdcME6kM3PnfWsdnep+2TJzHPFkLdBkgXZU4KF+JMaQ3vMyIdrg16PL1IRWMLV1JePuVhCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IE2Jypug; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UJu9jE011794;
	Mon, 30 Sep 2024 20:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=r+ilioLAvtY+bb
	JQnjK0k/pzRXX3F2cw6gF7/DU2S84=; b=IE2JypugdxzZCxaviSRyaECVGNh8Gb
	WsO8LdU2tKDFi/ecSdesbqihciB0Ge4DYXU7M8BWDTLPT3VnL91HXhjGORGGjOhj
	ImmyZ6D2Qh8QhuGP9X2quDxJtTb0SrKZXxee7NBViGs7AOWW34jCbBLfl2dmuell
	IfeHoAjucReO0m4iibII9Y2i/2QgYSmIlBJR1t1E+BxgliKSNM5A0OdP1F8Q1QHW
	CIrQejvjzxy8/Aj+H7W1qYAX34S0X6q/veSBets434ANjY2E20qXXKJQhFpALNuV
	IkoGkbJwFbEuO7H45j0KtPlfXVGrgqwhHadkVJzsG21VriXqQ2tdRh4Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87d4qpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 20:36:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UKDvMH028553;
	Mon, 30 Sep 2024 20:36:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x886tmnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 20:36:12 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48UKaBbO007150;
	Mon, 30 Sep 2024 20:36:11 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x886tmmt-1;
	Mon, 30 Sep 2024 20:36:11 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: shuah@kernel.org
Cc: yifei.l.liu@oracle.com, linux-kselftest@vger.kernel.org,
        ramanan.govindarajan@oracle.com, sinadin.shan@oracle.com
Subject: [PATCH v4 v6.11 v5.15 v5.4 v4.19 1/1] selftests: breakpoints: use remaining time to check if suspend succeed
Date: Mon, 30 Sep 2024 13:36:03 -0700
Message-ID: <20240930203603.2854629-1-yifei.l.liu@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_20,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300148
X-Proofpoint-GUID: iQlEZR4InHlOZGWUpGzJbTkd7PcoRpIf
X-Proofpoint-ORIG-GUID: iQlEZR4InHlOZGWUpGzJbTkd7PcoRpIf

"step_after_suspend_test fails with device busy error while
writing to /sys/power/state to start suspend."  The test believes
it failed to enter suspend state with

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

After investigation, I noticed that for the code block
if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
	ksft_exit_fail_msg("Failed to enter Suspend state\n");

The write will return -1 and errno is set to 16 (device busy).
It should be caused by the write function is not successfully returned
before the system suspend and the return value get messed when waking up.
As a result, It may be better to check the time passed of those few 
instructions to determine whether the suspend is executed correctly for
it is pretty hard to execute those few lines for 5 seconds.

The timer to wake up the system is set to expire after 5 seconds and 
no re-arm. If the timer remaining time is 0 second and 0 nano secomd,
it means the timer expired and wake the system up. Otherwise, the system
could be considered to enter the suspend state failed if there is any
remaining time.

After appling this patch, the test would not fail for it believes the
system does not go to suspend by mistake. It now could continue to the
rest part of the test after suspend.

Fixes: bfd092b8c272 ("selftests: breakpoint: add step_after_suspend_test")
Reported-by: Sinadin Shan <sinadin.shan@oracle.com>
Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
---
 .../testing/selftests/breakpoints/step_after_suspend_test.c  | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index dfec31fb9b30d..8d275f03e977f 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -152,7 +152,10 @@ void suspend(void)
 	if (err < 0)
 		ksft_exit_fail_msg("timerfd_settime() failed\n");
 
-	if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
+	system("(echo mem > /sys/power/state) 2> /dev/null");
+
+	timerfd_gettime(timerfd, &spec);
+	if (spec.it_value.tv_sec != 0 || spec.it_value.tv_nsec != 0)
 		ksft_exit_fail_msg("Failed to enter Suspend state\n");
 
 	close(timerfd);
-- 
2.46.0


