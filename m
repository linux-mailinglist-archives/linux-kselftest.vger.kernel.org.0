Return-Path: <linux-kselftest+bounces-20229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 767F49A5935
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 05:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86B4B2193E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 03:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4D042A8B;
	Mon, 21 Oct 2024 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cIQxkgo6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE575A41;
	Mon, 21 Oct 2024 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729480953; cv=fail; b=dtrVxCdg/2cCukaOPNnXvwrIc2CWh7LAh4Gkx4cstDbFe/sp9Kp9eHS53Y0IS8PZ5hQvfMekB1rZkJfZM0LMvY/b1eJuCDtUbD1i03yLe350gzDd8QX6Nbo4J6p7g+dMJf4P686QVQF3pK327hExoeD42aMBQvlh23w6p4x1VuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729480953; c=relaxed/simple;
	bh=EZwGNkejqfaeCmT600uJDovchmHTGIC5N963pSnIDtQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e3oFklDmFicwy8hlWMhBN98HvhH7U/fgQ02eou1kdAiMBeAYgnbVJE8iqmpvOKnRqAUwDUygTEmrM+AAMegImGCquflLVN2OGzubdk/K6YLX3o+7LJJeO9F9x/L+pa0oMTZDZQu8LQTXrsIofVg5eT0sAOfETVklklcHyMp6hlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cIQxkgo6; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JodJR1kqMKI296TWSYuBvyYd3K0Ib/jRWPz9q64Ox4pja0xK7soFVcJb2Q4mU63KDwjJ8NtC/GHj4er93KPA7XcXm2KqMFn0FY60QuYgvHWQ7WQSIE/pgNwpoiH8k9M6szMRjDhjv4hk0ewWdn522rsST29jpSAjv9SyhhTfoFzJ116JmJV4s5ZB/BqHcdI3c8Iqkp6RzcagrAX1FmWoPD2zWrUmu7jDMtbEyZNLSxOKcsa0Egoe6yeP6PVZ+XPoqIiut5vXk0Z0bmJoCyKsckbhUYloFpVfqV/Vl28PCtWd6TM9Nx3KHvmO4ivSww2p/GrfI3TBb8U8TprkLH/vaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMwRTI0AEy9dhZt36gXBmoWSTVSJIJTFp/R5jsdpdZM=;
 b=gIVFM1RPSuHQrIQYSh5f09fmJGwPNrG89Zz9D9qp9Wh5DyaxXNJdwNOLbEYRxOkF5wOefKwdweyBpjPS5sEUFtUGwxZbKkJNs4hYbIQfd6Z8hEY3AV6ViBSbTGbkeD+v6gHR65r9MM21g5HbKR9j1SMeR8S+x2Ll/x8bu8AdG3HXsIPktoD9l4LgQ9pd9nxD1ti3HMPTdA3VKgRUM0qgYomwbNf1OVnvkFqtqgd/H81YLBZqRWGMPVBIV32MmgRNiMS1M+Wep1pA94Yip7xXaDXrwiDhCsydPGT9smoRbH0riB9dS8rR9snhfq+/Pyf3V51PEC3WiHB/WmH3xk8TJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMwRTI0AEy9dhZt36gXBmoWSTVSJIJTFp/R5jsdpdZM=;
 b=cIQxkgo6SwLJ1zTeRSbYoFqS//a55U9IvAQz4Zor4ZA+fV3MbPHk+nw8rFgG+5Zk0qwo0Uwp7S/YYM94hzTk6vt/wd7pT6UlQVNQAyF8Dzg/wnLI1JPjLmdnVuvpw+nLTklgBY8/TkSKB/Re6ruTgSqF35xOSmXhWkgMOoi79AkvnPV11dGB5ilhaiWGhYro8fg9VaOj97aUy08sBaMLJaezZjLFlvBypY7f2maqUU8zEioh6SkQXA/P5AK1R0jU6vfZJTyp4GU05ftWGlHNLmpVsejStrPlAFNbQRbrk69a6T4vUolJf2UP0KVyZiO+2/T7ZgVfEK9XnBo7VFZeYA==
Received: from MW4PR03CA0122.namprd03.prod.outlook.com (2603:10b6:303:8c::7)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 03:22:26 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::b0) by MW4PR03CA0122.outlook.office365.com
 (2603:10b6:303:8c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 03:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 03:22:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 20 Oct
 2024 20:22:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 20 Oct 2024 20:22:15 -0700
Received: from jjang.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 20 Oct 2024 20:22:15 -0700
From: Joseph Jang <jjang@nvidia.com>
To: <shuah@kernel.org>, <alexandre.belloni@bootlin.com>, <avagin@google.com>,
	<jjang@nvidia.com>, <amir73il@gmail.com>, <brauner@kernel.org>,
	<mochs@nvidia.com>, <kobak@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>
Subject: [PATCH v2 1/2] selftest: rtc: Add to check rtc alarm status for alarm related test
Date: Sun, 20 Oct 2024 20:22:13 -0700
Message-ID: <20241021032213.1915224-1-jjang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8b86da-7a26-4582-ed5c-08dcf17f95f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3I2uRPzI5Hc3X/+o/PPYt8dtDo2sb5QIIeJ5hp+0d3I1u7FSC2NIy8lpJJE2?=
 =?us-ascii?Q?cuCrepALCRZENGpXepbO1K2ZE3N/GuSk2FfGooZ5aTyZD9LhinwDQnU4XDWi?=
 =?us-ascii?Q?5Ep24znfDgVEukPa7Bz8YWUsmh5MLTl10HmczcxrBWMnwqtftQjraisod1yd?=
 =?us-ascii?Q?6/zl8UOJckmxaFOisMXz7GuDlDFvbiYw1b4jViT7VTc4UjtzExxYPM4lpB75?=
 =?us-ascii?Q?VsCy8Q25zPLDsRKbCC8VRqnSfxjcr1oqYf20LINbbJDX3GSfaI4AvI1jXYsr?=
 =?us-ascii?Q?zd0h0nang83XYK5bGMAMxLmCYpWUErsFC5cM1e3o/M8JjiQ5lS3IMa4N4ExH?=
 =?us-ascii?Q?ci2o2qJq3TyeWma7yLKS7W0r0u9hbcSbx+3DIjVakhh5h+SxF79iGfp+uYKb?=
 =?us-ascii?Q?UXa/HDfJXFDCaJIz6N4ARZ8hHyn6RmUzLiL93lCoxrbilRHSdEawofu0jB8Z?=
 =?us-ascii?Q?pPwTMlkpMW/6+D5qCwhwAjkcD96HQYJX0Z96JymmNe5WVcEZSD2hsCioi4Zy?=
 =?us-ascii?Q?CeADOUljT9qIrPxC3zQKxLvXQjotUj4ujOPIJbOawpemh96wgbXXziIeAU1+?=
 =?us-ascii?Q?7MJ6mdvbQ2/aoAuJDAYILSDT9DN/BRJEh+tfmaaWKX3kGQXs2ka6ylYU26D+?=
 =?us-ascii?Q?zJZjUvu+Yt5v6ieAndzPgAs58bb34zttL51EGU7y/AXQ3Ym+chRYb5FSJFKY?=
 =?us-ascii?Q?plYrqCIonnSNh9/n9rbshu7pYExst33leJWvSjXSLNmCgKAKyOpERg1k3ZAc?=
 =?us-ascii?Q?0pLG1zNefipA7xVDlN94j/+dqEXYJ+0v4D1u3RS/LwkMGOQOrpU0+BsmX1Wk?=
 =?us-ascii?Q?ee/JM6tpgb8IRXrMaidbnlkVXVhA1ropq3meUKdSM8b9ykGdZl4aM3GTOD0q?=
 =?us-ascii?Q?MQEeziVsELnmtrcNDL5Sn3BTpo2vAG3jzR2jckMSUPIHushioAaR4MgUrPE6?=
 =?us-ascii?Q?VPgRtQ1kvsfnt/sVMaPfEQC6bc2+rNGYMRGJP7aUYQzYnOyu4Y0qE5qNMwO5?=
 =?us-ascii?Q?b7OYMFRJaG+H7OtX3NbnzKTmAPELfk/iV2+ZifP1thSsRMZpixbIzhbathHw?=
 =?us-ascii?Q?yF4vd8lmAgYiooXaL+xTfO7nUHR+i4hNpTkD6KoFumpsCENH2e6RHqfi6M1B?=
 =?us-ascii?Q?xy+LkDm++LcAeHI542y5ZnXCGwhTMAC+X+opNwI20XoyaMIs2akPQlWU3PPH?=
 =?us-ascii?Q?+vhFnbS09ufLMDNDx3VkEENA+lH0HN7v6wJclScWgchnLjdVt43U5noyX3tR?=
 =?us-ascii?Q?ZwYn1SyQy2xTf1E8RDDnOP2BQNFnaic5HRXcrzkR8y2JgrogB05eaUUBwBLz?=
 =?us-ascii?Q?BiSUmFHSE5w7K3bYDrgPm4991E+G5k/6l4j4FWR5jf7eJo+Sab5Fkq5E3H/d?=
 =?us-ascii?Q?UbJVf9LCf0ZCnwvDPeTf7DAMd3/jpE0nfmNECG3Y9ZfJpbkVFFHhWs1Va1Ku?=
 =?us-ascii?Q?9WjXjI2neKU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 03:22:25.8034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8b86da-7a26-4582-ed5c-08dcf17f95f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260

In alarm_wkalm_set and alarm_wkalm_set_minute test, they use different
ioctl (RTC_ALM_SET/RTC_WKALM_SET) for alarm feature detection. They will
skip testing if RTC_ALM_SET/RTC_WKALM_SET ioctl returns an EINVAL error
code. This design may miss detecting real problems when the
efi.set_wakeup_time() return errors and then RTC_ALM_SET/RTC_WKALM_SET
ioctl returns an EINVAL error code with RTC_FEATURE_ALARM enabled.

In order to make rtctest more explicit and robust, we propose to use
RTC_PARAM_GET ioctl interface to check rtc alarm feature state before
running alarm related tests. If the kernel does not support RTC_PARAM_GET
ioctl interface, we will fallback to check the error number of
(RTC_ALM_SET/RTC_WKALM_SET) ioctl call for alarm feature detection.

Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
as optional")

Reviewed-by: Koba Ko <kobak@nvidia.com>
Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
Signed-off-by: Joseph Jang <jjang@nvidia.com>
---
Changes in v2:
- Changed to use $(top_srcdir) instead of hardcoding the path.

 tools/testing/selftests/rtc/Makefile  |  2 +-
 tools/testing/selftests/rtc/rtctest.c | 64 +++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
index 55198ecc04db..6e3a98fb24ba 100644
--- a/tools/testing/selftests/rtc/Makefile
+++ b/tools/testing/selftests/rtc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -O3 -Wl,-no-as-needed -Wall
+CFLAGS += -O3 -Wl,-no-as-needed -Wall -I$(top_srcdir)/usr/include
 LDLIBS += -lrt -lpthread -lm
 
 TEST_GEN_PROGS = rtctest
diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 63ce02d1d5cc..2b12497eb30d 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -25,6 +25,12 @@
 
 static char *rtc_file = "/dev/rtc0";
 
+enum rtc_alarm_state {
+	RTC_ALARM_UNKNOWN,
+	RTC_ALARM_ENABLED,
+	RTC_ALARM_DISABLED,
+};
+
 FIXTURE(rtc) {
 	int fd;
 };
@@ -82,6 +88,24 @@ static void nanosleep_with_retries(long ns)
 	}
 }
 
+static enum rtc_alarm_state get_rtc_alarm_state(int fd)
+{
+	struct rtc_param param = { 0 };
+	int rc;
+
+	/* Validate kernel reflects unsupported RTC alarm state */
+	param.param = RTC_PARAM_FEATURES;
+	param.index = 0;
+	rc = ioctl(fd, RTC_PARAM_GET, &param);
+	if (rc < 0)
+		return RTC_ALARM_UNKNOWN;
+
+	if ((param.uvalue & _BITUL(RTC_FEATURE_ALARM)) == 0)
+		return RTC_ALARM_DISABLED;
+
+	return RTC_ALARM_ENABLED;
+}
+
 TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
 	int rc;
 	long iter_count = 0;
@@ -197,11 +221,16 @@ TEST_F(rtc, alarm_alm_set) {
 	fd_set readfds;
 	time_t secs, new;
 	int rc;
+	enum rtc_alarm_state alarm_state = RTC_ALARM_UNKNOWN;
 
 	if (self->fd == -1 && errno == ENOENT)
 		SKIP(return, "Skipping test since %s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
+	alarm_state = get_rtc_alarm_state(self->fd);
+	if (alarm_state == RTC_ALARM_DISABLED)
+		SKIP(return, "Skipping test since alarms are not supported.");
+
 	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
 	ASSERT_NE(-1, rc);
 
@@ -210,6 +239,11 @@ TEST_F(rtc, alarm_alm_set) {
 
 	rc = ioctl(self->fd, RTC_ALM_SET, &tm);
 	if (rc == -1) {
+		/*
+		 * Report error if rtc alarm was enabled. Fallback to check ioctl
+		 * error number if rtc alarm state is unknown.
+		 */
+		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
 		ASSERT_EQ(EINVAL, errno);
 		TH_LOG("skip alarms are not supported.");
 		return;
@@ -255,11 +289,16 @@ TEST_F(rtc, alarm_wkalm_set) {
 	fd_set readfds;
 	time_t secs, new;
 	int rc;
+	enum rtc_alarm_state alarm_state = RTC_ALARM_UNKNOWN;
 
 	if (self->fd == -1 && errno == ENOENT)
 		SKIP(return, "Skipping test since %s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
+	alarm_state = get_rtc_alarm_state(self->fd);
+	if (alarm_state == RTC_ALARM_DISABLED)
+		SKIP(return, "Skipping test since alarms are not supported.");
+
 	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
 	ASSERT_NE(-1, rc);
 
@@ -270,6 +309,11 @@ TEST_F(rtc, alarm_wkalm_set) {
 
 	rc = ioctl(self->fd, RTC_WKALM_SET, &alarm);
 	if (rc == -1) {
+		/*
+		 * Report error if rtc alarm was enabled. Fallback to check ioctl
+		 * error number if rtc alarm state is unknown.
+		 */
+		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
 		ASSERT_EQ(EINVAL, errno);
 		TH_LOG("skip alarms are not supported.");
 		return;
@@ -307,11 +351,16 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
 	fd_set readfds;
 	time_t secs, new;
 	int rc;
+	enum rtc_alarm_state alarm_state = RTC_ALARM_UNKNOWN;
 
 	if (self->fd == -1 && errno == ENOENT)
 		SKIP(return, "Skipping test since %s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
+	alarm_state = get_rtc_alarm_state(self->fd);
+	if (alarm_state == RTC_ALARM_DISABLED)
+		SKIP(return, "Skipping test since alarms are not supported.");
+
 	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
 	ASSERT_NE(-1, rc);
 
@@ -320,6 +369,11 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
 
 	rc = ioctl(self->fd, RTC_ALM_SET, &tm);
 	if (rc == -1) {
+		/*
+		 * Report error if rtc alarm was enabled. Fallback to check ioctl
+		 * error number if rtc alarm state is unknown.
+		 */
+		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
 		ASSERT_EQ(EINVAL, errno);
 		TH_LOG("skip alarms are not supported.");
 		return;
@@ -365,11 +419,16 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
 	fd_set readfds;
 	time_t secs, new;
 	int rc;
+	enum rtc_alarm_state alarm_state = RTC_ALARM_UNKNOWN;
 
 	if (self->fd == -1 && errno == ENOENT)
 		SKIP(return, "Skipping test since %s does not exist", rtc_file);
 	ASSERT_NE(-1, self->fd);
 
+	alarm_state = get_rtc_alarm_state(self->fd);
+	if (alarm_state == RTC_ALARM_DISABLED)
+		SKIP(return, "Skipping test since alarms are not supported.");
+
 	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
 	ASSERT_NE(-1, rc);
 
@@ -380,6 +439,11 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
 
 	rc = ioctl(self->fd, RTC_WKALM_SET, &alarm);
 	if (rc == -1) {
+		/*
+		 * Report error if rtc alarm was enabled. Fallback to check ioctl
+		 * error number if rtc alarm state is unknown.
+		 */
+		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
 		ASSERT_EQ(EINVAL, errno);
 		TH_LOG("skip alarms are not supported.");
 		return;
-- 
2.34.1


