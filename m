Return-Path: <linux-kselftest+bounces-10323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BFD8C7FE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 04:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7C71C20F4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 02:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547FE4C6E;
	Fri, 17 May 2024 02:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tDmk9a2R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280234C69;
	Fri, 17 May 2024 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715912952; cv=fail; b=OnFNGjPrI1yX7ylcjQ8DbWQVRWUrCQI6X1lDuOlf595eUWQ+J+EHUYTXzVwwIoXPA89etPjg4YmPfwIJ1Y0LqhV91/v9BIQc132N4knjEAj9fLqiC1MOokPTmpMHE6hRXpF2wE6Qr4PL9ArXSMjk6PtLdkqidfOekddmWoXF65Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715912952; c=relaxed/simple;
	bh=iVeckCrz9wx4B/iNYMquEQI+UKZo+viljmgf0EIzlns=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h2Z0JN6ux/iqGrpKGIxt/FX7DQrGHwEVRkvfZ8XTTd8xj8SmO8MEqzoRfxfvl3ZnQff14t86fTwZBpxDqG4x8xgB8g/MvKW5DQdSvfAN3pGHjommAJ4nECKXDq+/Fcv2gwIRyE9Yg0sk6MHkkknaMqGa4dIqcgUPdSRCDdOqQZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tDmk9a2R; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KA925Vr7Ha+R6zP1tHWFmCp526q9TNMeTZuLwB3CNYBhvpZ/UcXIIXGe7TyzMgr/WeOU8FDX5EHN+Axk7OcGeFn0ToK0pDaJBAQ6A2AI88spYPuL+LBTfdXG9Ppb65qhqjEDZ6/kFhrlGNAqF2XV8gBuaNFlyx3MDc2W5aCgCahqSQxJeGMRQVRQeAnjLM+OwQbFpNbLHeMwu973EybU+X0Jg4vjYeZTvaoSm20QsCx9g2LbUZ5rj3jY3j4RRkTZfkWqfrlPpqCDhVsLuKNloeXeG7bOdUn38Cx8pBbhop3NAXWRyUuWDsjm1y3OkhSspZ7cuVqkqmheau59w3M1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/FwjHpSnA2BxQLK7KBOKHljoABJta8/kVCJTSfpUW0=;
 b=Nx6z0m61dykjoozEEHG/pqd34gcokyEvR6QBsqR78BT2p1fPGRETWhrnhDH9cpSCu7hlxCkTF57YXPHZlky0IT2A8IpK4UFy0E3NnGOd4SFAzIa9WiaHluXLhuGds2Hz7A3ptMpOWAg1FjVwTuQWmT4OvNOQbUIqAMABtXp0PYTibJ5E8iyT2m+qZYcKFNHEUqfGMllj7/BVLMCAn/oKeatax3/C9kxujg/Gtb7iI3lmXGiQ6WgFc5lM7H/GhwftowddYbSX5DlfWESa1G16/N0CHo5eVtHHA+bPMsK/HG6Gec6gfXf5Fj4THqH0OclF8ztA4E3KPIfpfbCJLYW1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/FwjHpSnA2BxQLK7KBOKHljoABJta8/kVCJTSfpUW0=;
 b=tDmk9a2RXq3LbB1ptVujpuKIQGicmcRfcuxvfP96P2c3axb78O/ycit2IkMvgqKrb5/5eNcA5qQ0O0C32aoUQSGgtxquk0bktZyD7Fw7lUSSj+XquX2iUiQIidOFKC0wHlykMGGrNDIbtpXhXth0JnibHe+x77sklvapmhBI4C6wdYgw8h15S71y1KB2BIQ15w6BpfWgofriw6RMpBJ935Srp/QQVet4OyoeFar5+IngK7pJTxV4l2pckvNTjHnk7CAEPL/oEaXmVrqKMplcCXiL5ULfUOpEujHupZbsD/UUAKvbmvxyd5r+NXgv5FwJNzg8tiQ3x5w2MjfQ3VsLSA==
Received: from MN2PR19CA0054.namprd19.prod.outlook.com (2603:10b6:208:19b::31)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Fri, 17 May
 2024 02:29:06 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::bb) by MN2PR19CA0054.outlook.office365.com
 (2603:10b6:208:19b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Fri, 17 May 2024 02:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 02:29:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 May
 2024 19:28:50 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 May
 2024 19:28:49 -0700
Received: from jjang.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 16 May
 2024 19:28:49 -0700
From: Joseph Jang <jjang@nvidia.com>
To: <shuah@kernel.org>, <alexandre.belloni@bootlin.com>, <avagin@google.com>,
	<jjang@nvidia.com>, <amir73il@gmail.com>, <brauner@kernel.org>,
	<mochs@nvidia.com>, <jszu@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>
Subject: [PATCH] selftest: rtc: Add to check rtc alarm status for alarm related test
Date: Thu, 16 May 2024 19:28:47 -0700
Message-ID: <20240517022847.4094731-1-jjang@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c48c816-1edb-4fdb-332c-08dc76191fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|82310400017|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7hjjmt90gjULxT+EKyuujiTlh1qDcYvWTixfateAYk+IYrctbXWsn/xXT3hF?=
 =?us-ascii?Q?OBQqh7syEbZogzTAZqb/sGLfHU79egJOUiw4mMY7JucilN+Yf9neewBZlY/K?=
 =?us-ascii?Q?eFxOyruX0ElTqBiD/OP+G85eS+CkgNsuxaXJXXMtvj3uPhjCumdjmw4L6Aii?=
 =?us-ascii?Q?1y7BovAA2FAbhNG6O4vT0o+sB/I1eFsQJmjf70BOo/x4xafbQQmn840TGCYL?=
 =?us-ascii?Q?5BL8wIn1axDNnqemx0PNOUyRZVnKUS4pHKf5sdzUVdGeKgf0HdQWH8eARaYC?=
 =?us-ascii?Q?SDhoGWzkJ8mO8dVoYH//w4RJxp8sGCm8i9Y4oG8qVLITks0xCf/dc7zSMNoC?=
 =?us-ascii?Q?AKqe26pIJzWD2nVrNESVFP4mmCcbcChCv6pOofqNXZANhu3tg4UaSLZhtB9R?=
 =?us-ascii?Q?/0ScrdeX1HAHkXos8cj5OvI3faLklYl9n++LvhLoEWh/wNba4Qcij0nx9pqC?=
 =?us-ascii?Q?AoTaqRNJuVwW2Mz/0Z/g5TO21rpDJx3YZBAmuqRpEBhBQdJrmvDLo2ejq2iU?=
 =?us-ascii?Q?2UfdVLL3KOaKBwIpdjsr7a+b9MulHI5huNof2t58h1909F1Z2O7OkNR/E074?=
 =?us-ascii?Q?gn3hihBEz2SgUg9StuAzczYDLgoZuuU26SKOQjapZo6zVyC3MhoMKV8yL2lZ?=
 =?us-ascii?Q?qNvUlHAY6DZ8bVkfrVkCrI+7LoZyEIn7fDyosJS8dEY/Zzx/L7ZeH4Py2wwG?=
 =?us-ascii?Q?BOoS2kWU0ssHmIkKZWp4ygq+I67UKULPk8uMI4pBxYe3UddW9PgvTTZhrSXC?=
 =?us-ascii?Q?nQilB71CfCOEOv/7d2/ktV7BLu9N+h33WFOep5j2YrvHcnzCLlQpKrENBnsz?=
 =?us-ascii?Q?GZaPaiIPuxizdclhXU361YNFtHMSSXFlgfxV7DkWwm3WGWD2dRfXY17X0uwg?=
 =?us-ascii?Q?my3BecmVau5pdC/L5q6cd7/r2F8uc5FMZVasEGhD74ELr+qe5tj/cPV899RH?=
 =?us-ascii?Q?7omaAryvsulL5IRy8NZwzyU8KDWcV3z8lAYWzp1i21/hGXF0s0blhRaDmKfH?=
 =?us-ascii?Q?KyvF1m4CgQchcpwIR+V+j0LEhckK8Ag/+ko0dkFsJ8CWbHFs4V91zzErBWnD?=
 =?us-ascii?Q?65OwYc+8m7ZqLF+Ycm1ANf61zk+SHmRQPdiGLK5oTFqSDRh0JYUDmNzGFxtW?=
 =?us-ascii?Q?XU1fawAwq5XMHyTLK7lXA+j1csgV9pFxOhVfhT4iGHeYQ0V0TujNp2VsgmBJ?=
 =?us-ascii?Q?LTKvGd0h5gNb5XIY2ySBMBfrU+IeguVX0eMj7LLNAaa/RC+s84HQ+iP7cFzW?=
 =?us-ascii?Q?qkGExH07XrGaVPzRO4q9mlxTXN4tBqs2wVDMZWLgB+UL6LKZo2dDAlnkV8z8?=
 =?us-ascii?Q?y5mIZIP86C4k82RkPe6vG7JLrEkMAT1d3jv3Lbh0oZyJTDM+X6xZiP2MMpFP?=
 =?us-ascii?Q?17PuCtG22TzeAt09o7c8Qj9chnOx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 02:29:05.8324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c48c816-1edb-4fdb-332c-08dc76191fd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349

In alarm_wkalm_set and alarm_wkalm_set_minute test, they use different
ioctl (RTC_ALM_SET/RTC_WKALM_SET) for alarm feature detection. They will
skip testing if RTC_ALM_SET/RTC_WKALM_SET ioctl returns an EINVAL error
code. This design may miss detecting real problems when the
efi.set_wakeup_time() return errors and then RTC_ALM_SET/RTC_WKALM_SET
ioctl returns an EINVAL error code with RTC_FEATURE_ALARM enabled.

In order to make rtctest more explicit and robust, we propose to use
RTC_PARAM_GET ioctl interface to check rtc alarm feature state before
running alarm related tests. If the kernel does not support RTC_PARAM_GET
ioctl interface, we will fallback to check the presence of "alarm" in
/proc/driver/rtc.

The rtctest requires the read permission on /dev/rtc0. The rtctest will
be skipped if the /dev/rtc0 is not readable.

Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
as optional")

Reviewed-by: Jeremy Szu <jszu@nvidia.com>
Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
Signed-off-by: Joseph Jang <jjang@nvidia.com>
---
 tools/testing/selftests/rtc/Makefile  |  2 +-
 tools/testing/selftests/rtc/rtctest.c | 72 +++++++++++++++++++--------
 2 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
index 55198ecc04db..6e3a98fb24ba 100644
--- a/tools/testing/selftests/rtc/Makefile
+++ b/tools/testing/selftests/rtc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -O3 -Wl,-no-as-needed -Wall
+CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/
 LDLIBS += -lrt -lpthread -lm
 
 TEST_GEN_PROGS = rtctest
diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 63ce02d1d5cc..aa47b17fbd1a 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/rtc.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/ioctl.h>
@@ -24,12 +25,17 @@
 #define READ_LOOP_SLEEP_MS 11
 
 static char *rtc_file = "/dev/rtc0";
+static char *rtc_procfs = "/proc/driver/rtc";
 
 FIXTURE(rtc) {
 	int fd;
 };
 
 FIXTURE_SETUP(rtc) {
+	if (access(rtc_file, R_OK) != 0)
+		SKIP(return, "Skipping test since cannot access %s, perhaps miss sudo",
+			 rtc_file);
+
 	self->fd = open(rtc_file, O_RDONLY);
 }
 
@@ -82,6 +88,36 @@ static void nanosleep_with_retries(long ns)
 	}
 }
 
+static bool is_rtc_alarm_supported(int fd)
+{
+	struct rtc_param param = { 0 };
+	int rc;
+	char buf[1024] = { 0 };
+
+	/* Validate kernel reflects unsupported RTC alarm state */
+	param.param = RTC_PARAM_FEATURES;
+	param.index = 0;
+	rc = ioctl(fd, RTC_PARAM_GET, &param);
+	if (rc < 0) {
+		/* Fallback to read rtc procfs */
+		fd = open(rtc_procfs, O_RDONLY);
+		if (fd != -1) {
+			rc = read(fd, buf, sizeof(buf));
+			close(fd);
+
+			/* Check for the presence of "alarm" in the buf */
+			if (strstr(buf, "alarm") == NULL)
+				return false;
+		} else
+			return false;
+	} else {
+		if ((param.uvalue & _BITUL(RTC_FEATURE_ALARM)) == 0)
+			return false;
+	}
+
+	return true;
+}
+
 TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
 	int rc;
 	long iter_count = 0;
@@ -202,6 +238,9 @@ TEST_F(rtc, alarm_alm_set) {
 		SKIP(return, "Skipping test since %s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
+	if (!is_rtc_alarm_supported(self->fd))
+		SKIP(return, "Skipping test since alarms are not supported.");
+
 	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
 	ASSERT_NE(-1, rc);
 
@@ -209,11 +248,7 @@ TEST_F(rtc, alarm_alm_set) {
 	gmtime_r(&secs, (struct tm *)&tm);
 
 	rc = ioctl(self->fd, RTC_ALM_SET, &tm);
-	if (rc == -1) {
-		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip alarms are not supported.");
-		return;
-	}
+	ASSERT_NE(-1, rc);
 
 	rc = ioctl(self->fd, RTC_ALM_READ, &tm);
 	ASSERT_NE(-1, rc);
@@ -260,6 +295,9 @@ TEST_F(rtc, alarm_wkalm_set) {
 		SKIP(return, "Skipping test since %s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
+	if (!is_rtc_alarm_supported(self->fd))
+		SKIP(return, "Skipping test since alarms are not supported.");
+
 	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
 	ASSERT_NE(-1, rc);
 
@@ -269,11 +307,7 @@ TEST_F(rtc, alarm_wkalm_set) {
 	alarm.enabled = 1;
 
 	rc = ioctl(self->fd, RTC_WKALM_SET, &alarm);
-	if (rc == -1) {
-		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip alarms are not supported.");
-		return;
-	}
+	ASSERT_NE(-1, rc);
 
 	rc = ioctl(self->fd, RTC_WKALM_RD, &alarm);
 	ASSERT_NE(-1, rc);
@@ -312,6 +346,9 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
 		SKIP(return, "Skipping test since %s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
+	if (!is_rtc_alarm_supported(self->fd))
+		SKIP(return, "Skipping test since alarms are not supported.");
+
 	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
 	ASSERT_NE(-1, rc);
 
@@ -319,11 +356,7 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
 	gmtime_r(&secs, (struct tm *)&tm);
 
 	rc = ioctl(self->fd, RTC_ALM_SET, &tm);
-	if (rc == -1) {
-		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip alarms are not supported.");
-		return;
-	}
+	ASSERT_NE(-1, rc);
 
 	rc = ioctl(self->fd, RTC_ALM_READ, &tm);
 	ASSERT_NE(-1, rc);
@@ -370,6 +403,9 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
 		SKIP(return, "Skipping test since %s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
+	if (!is_rtc_alarm_supported(self->fd))
+		SKIP(return, "Skipping test since alarms are not supported.");
+
 	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
 	ASSERT_NE(-1, rc);
 
@@ -379,11 +415,7 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
 	alarm.enabled = 1;
 
 	rc = ioctl(self->fd, RTC_WKALM_SET, &alarm);
-	if (rc == -1) {
-		ASSERT_EQ(EINVAL, errno);
-		TH_LOG("skip alarms are not supported.");
-		return;
-	}
+	ASSERT_NE(-1, rc);
 
 	rc = ioctl(self->fd, RTC_WKALM_RD, &alarm);
 	ASSERT_NE(-1, rc);
-- 
2.34.1


