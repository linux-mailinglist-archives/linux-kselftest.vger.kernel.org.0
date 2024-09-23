Return-Path: <linux-kselftest+bounces-18255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6857597F1C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 22:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4121C20B98
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 20:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48FB2E419;
	Mon, 23 Sep 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="duV7iq52"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07A114A85
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727124464; cv=none; b=Ir8Vi37rGuauffX77ZbY6dbnIuyWSu6ajQrgHn5mWCJR5S6rTQGO9RXT3/svL5T6cpZ58xztFh9ONugfN36C/wQLrc71r6XNrrZpUghc1SjHKnLxiZlz+SzA2wQUwmPmjVvwCOz76eFXGGvyYf9KH8JIry4oNijs+D0gfF8k4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727124464; c=relaxed/simple;
	bh=TzDKGgO6LPsZchkz40skAqRjNMNkz2CE8RoLCbQIesg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1mIby7Hh6o0maHRKzh7jnJamcyEhElhIcSrouIbiePIFTOgTMOarj0stBuz60PuH4iOuuvXoz84tJV4pxtQHPqIyA2HcDr0BGZd2Fx41qY8QHYdgL+o4yZI8Gy4uE9wz/xpYS7Ya86vXosp84OQeeCUeZXrVKivgIy8uM9wbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=duV7iq52; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NIMWTu004194;
	Mon, 23 Sep 2024 20:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=9Bl0YNzjl6AjdS
	LmwVbXCZAk4F2bRbW7r2paRHvtXe0=; b=duV7iq52lm2IeHE5V8C7hXmXOZ4lDB
	z4TQGYDLNMZq6+J5VOxKmjiSCo0UXKLWoJ0QSxOk9GLc75qpUZq0d5aqWiSatAQ/
	ErOQ9SIxn3skF4PD7Myfs2M0duKsV12yehzhfWHDqrZhXj8Adxtac/052jHamoFG
	TfTLlXBGyEO2xb83OrobHwdE34Gc9SSj+Fnp7ftrL6HG08O2LR5DnQKSbT9HSNj+
	1jaCGZ5jjL5G17WNM8U5B4xuhdrD94B2eIbYrJhi33ahL2psEbmTERFo0c+ThnR3
	Nxviv5kdplzn6TLzXFfGxto+qyiIMN1/JXvNnBOI85/TZcjFkiMj+Rrg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp6cbcv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 20:47:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NK816O029610;
	Mon, 23 Sep 2024 20:47:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk8ajmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 20:47:32 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48NKfxVi012099;
	Mon, 23 Sep 2024 20:47:31 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41smk8ajkv-1;
	Mon, 23 Sep 2024 20:47:31 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: shuah@kernel.org
Cc: yifei.l.liu@oracle.com, linux-kselftest@vger.kernel.org,
        ramanan.govindarajan@oracle.com, sinadin.shan@oracle.com
Subject: [PATCH v6.11 v5.15 v5.4 v4.19 1/1] selftests: breakpoints: use remaining time to check if suspend succeed
Date: Mon, 23 Sep 2024 13:47:18 -0700
Message-ID: <20240923204718.1862074-1-yifei.l.liu@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_15,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230150
X-Proofpoint-GUID: HkPvu-qWwD-f63w9eqtbA3O8BhqUb_I7
X-Proofpoint-ORIG-GUID: HkPvu-qWwD-f63w9eqtbA3O8BhqUb_I7

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
execute those few lines for 5 seconds.

The timer to wake up the system is set to expired after 5 seconds and no-rearm.
If the timer remaining time is 0 second and 0 nano secomd, it means the timer
expired and wake the system up. Otherwise, the system could be considered to
enter the suspend state failed if there is any remaining time.

Fixes: bfd092b8c2728 ("selftests: breakpoint: add step_after_suspend_test")
Reported-by: Sinadin Shan <sinadin.shan@oracle.com>
Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
---
 .../testing/selftests/breakpoints/step_after_suspend_test.c  | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index dfec31fb9b30d..33f5542bf741d 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -152,7 +152,10 @@ void suspend(void)
 	if (err < 0)
 		ksft_exit_fail_msg("timerfd_settime() failed\n");
 
-	if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
+	system("(echo mem > /sys/power/state) 2> /dev/null");
+
+	timerfd_gettime(timerfd,&spec);
+	if (spec.it_value.tv_sec != 0 || spec.it_value.tv_nsec != 0)
 		ksft_exit_fail_msg("Failed to enter Suspend state\n");
 
 	close(timerfd);
-- 
2.46.0


