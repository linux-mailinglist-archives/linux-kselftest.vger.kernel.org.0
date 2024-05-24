Return-Path: <linux-kselftest+bounces-10643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3663C8CDF3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 03:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B941C21838
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 01:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD6B328DB;
	Fri, 24 May 2024 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OmOhoV8+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0B3D29B;
	Fri, 24 May 2024 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716514703; cv=fail; b=tbMEwL4U9QfKSH5aKrp+qW+Zg+wkI09oXi31jxVy65SPvEoTh1jTjviga/cLBIvOkGHmgGmYegwg3g2zsfTMtPAnL/Psnnt6yaGaCsod+xfellgcTJyPjeGAy/iv5jNRC6iV/1HgdwbSrfEi9eTPtQfaMULdoTN1616YNhI70tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716514703; c=relaxed/simple;
	bh=FwXPb7KnxEpk4lVNg/ws7cDNtEZpw5n2ORauLQgBvxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWH9JGrnjUj+h0d4qLtdfiJZH1xRvAedRQWzri3NuN+e4lMdSqTb7HFYkvi7O40fOKZ6v+Md72c9e+HuhUDRNopc+IfwbnH2izBQWEWW217k+DyeSkhCDM+vW+IZoL5R+iHqneK3F6ruTIWsCtx/kRqoUPJ+VeBx3QntNqZwuc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OmOhoV8+; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvQ8TOo41jIv8ETMAR9fycO06FYT3lYQ3auonS8MTQRvdFTUklQqcTgLFj42tCtsZBTi0GGiEd6eA/T4+hnn8euNmWbN/8NGqTGVJOlmJfj01RUKEwti3NJTUnIX4wbzIHVqSMHXZ1o/0vmOnuFP143MhWxpyA29SGreHkE7TKjmOz8kFLmMQ9kMnJwEqYbRdUHF4qvvGZQGTKceKa9IQZGaMH5bleDvj8Tu9H9SGXL/ZOh6m1QR2fosUuUXOUphTedr6osilglKxS8V3GIXStXC4zwcRYIi6ogaAWnCW37ecaa3mB/gaYugpJ6OvquOSbUQZM/fGhSSBmjswfKvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz6F3eR7gDQth75ur2+PzGUdVWxOAWjdvi7TVJ65/XQ=;
 b=VWkIIIk7kIM9jNroadw3clEji9j6kQPdS6YJjecaonWxLt0y1IxLf4tuM72F7SrOu9tGUb6e2mirPAa4gXifx8n0c7gzOxvXW8kNvx5v5bU6UVmGrktmz5MK3gHtRYyLrcGdepx35bPeqAcz5NlNrvB5IizI8OTTUI8093H/bkUu/JYcWrpVWccngC6v0UPqxGQosc9jvI4JWT+zPRnA1RNccW1Wg6tLQlbzFN+s3Ut0IvqxiXDUsxBLos+f4x1YgaZ/oadrI45kw1o6dFT7pdNDmVgXddZ/OTb+WzMV11sXrFIY3QvqNuER5I1ANxgn/wYh3MV4sRKGAhtE+InA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz6F3eR7gDQth75ur2+PzGUdVWxOAWjdvi7TVJ65/XQ=;
 b=OmOhoV8+mC5jxSwrzJoEzSXnX+c0bAGG7HN78dtoHnBl/rS/9K9V3wiPhMCg8PTUja8dOoVkjpCBuCQS16fWTYLEoZYVWMPez3Kxu8GX1d1BVr9jtmIZTl3xk+tvzf799d4hp9HjNJkCLd62EWpFvdWxdY7oa28tivxO3j1p3CoPsotE2/XLG7AjYAEqnhSvJhSOyfQCARKcYn+o9XdeyKyYauitrBg5hlrwaL0EQ7GD153fOstxcVhqLIo8y4wFNkFv85OnRAchDKvL0Q6a4oCdHMX9UFjbZ3GeuhcRUvcR4qkxMroqa1oOjl4cVTYAzs44GslZpmMtxpVUFOdCsA==
Received: from MW2PR2101CA0012.namprd21.prod.outlook.com (2603:10b6:302:1::25)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 01:38:17 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:302:1:cafe::93) by MW2PR2101CA0012.outlook.office365.com
 (2603:10b6:302:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9 via Frontend
 Transport; Fri, 24 May 2024 01:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 01:38:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 18:38:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 18:38:10 -0700
Received: from jjang.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 23 May
 2024 18:38:10 -0700
From: Joseph Jang <jjang@nvidia.com>
To: <shuah@kernel.org>, <alexandre.belloni@bootlin.com>, <avagin@google.com>,
	<jjang@nvidia.com>, <amir73il@gmail.com>, <brauner@kernel.org>,
	<mochs@nvidia.com>, <kobak@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>
Subject: [PATCH 1/2] selftest: rtc: Add to check rtc alarm status for alarm related test
Date: Thu, 23 May 2024 18:38:06 -0700
Message-ID: <20240524013807.154338-2-jjang@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524013807.154338-1-jjang@nvidia.com>
References: <20240524013807.154338-1-jjang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: f28705f0-23fb-4be1-8a30-08dc7b922fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v1W1ZytIEkR9QMl/IUnHLwoHmRzcuVTZ+biXPonaaBO0cNUWtkju9mWYtYZT?=
 =?us-ascii?Q?182r/JIvFF6PTUTDpAd0va5QskiWOeDhFWwpfciUYkZJWFXNJUnA0aSJShGQ?=
 =?us-ascii?Q?k17pkMX+vc8w8yeh9G9OHtChomPTzuzZP+tLEFPrkRZNnzsBhh3zChgo/j0k?=
 =?us-ascii?Q?wHdMUhAf0VBb9ad8gov8adbt7J6/RdmqeRvGMWuST/Sog2uWVfLLHjl6ThDE?=
 =?us-ascii?Q?NMWTIhpEc147WJH205BMPqfDiDI1B9IoqnfgNWfMePK1MXMaQ89ite21PNAw?=
 =?us-ascii?Q?7aaBqRahAKYRJDd/e6R+jtZ2axNFHMzScwzwkXNLX16hPjIR7Aek7eDTOvxn?=
 =?us-ascii?Q?cRxChRl4L6zpm8iq82d0esV4bb1S4ErzL5EetaGipntKxBIARcRBZnWjHO/X?=
 =?us-ascii?Q?Uq2gt7GOoY2mJXNdNltrRnNCZQJHy7JGd9e32MzofXbTDS4SqDTrojkw3Cln?=
 =?us-ascii?Q?zv9gbSBFnnrH82i3DvNCI4jxtTVTAR9jm1N5JgROgseMC6RBlOVDy870q8wT?=
 =?us-ascii?Q?1END3EcDv4RPRn1bfuMYVTddjk6cGDa077aaMAs5diuf81j7/LHSYlbwut99?=
 =?us-ascii?Q?D5WHaU0aYZOuxtk3TJZXuhfOkae+Kn+wI2fGk0HKkm730s7KrmuHVVsiKD1k?=
 =?us-ascii?Q?CVGGeBXBiygrmEMCebYKPd15dQ9QaaJNzD4rsbZeXtwYi4chVyhiHnfdTpOQ?=
 =?us-ascii?Q?Ci993R/7DywiTeL6Kdbp8BTiPmCkE0+MemD3umXAFQL7ih8XxkeQsoJBDliV?=
 =?us-ascii?Q?AcaY88YtefsQd8YCtJ+YcRfS6jxFrmx2WksxHsooDRGsL3rTiiYpvs91Wxnn?=
 =?us-ascii?Q?VRg6SAUFbW+tg/dL7oywMO2OZUMeqSOy9sdd48lZv1EdqLW+UB6n2GrLmehE?=
 =?us-ascii?Q?30gEp+NsqkAqRCzDn8TJEDzsSvU61J+0fRYS+64KnxQGPjHlykXjD5XOJ5q3?=
 =?us-ascii?Q?y+CUkC61CRNQ8tkmwO3SRmoO7V/Z14/0OOXy59yG6FwtR0oGovoKf5Nsd/EB?=
 =?us-ascii?Q?eTGW17DNnj1HmJCYqi+xO6p1D0JNF63hMDNqs+uuhD24LJvo8yTeEcfXSuBO?=
 =?us-ascii?Q?Oq9MIhwKp/hoYLvMtPfOL5zLB35rSrvr2AbmgMKbDFqIKy/4T4SChtwOBOWz?=
 =?us-ascii?Q?EBDHRY8qUxz2xjCWkfMjjENjnmQTBX39GXfLAH0CSFXQqhwBd1uLbrhtt6Jo?=
 =?us-ascii?Q?0JjCCne3nwYAEHPj+6L+YOLALE9eg3wxZE4X0Hv9+6wDXESK+x6Itx23Qbk3?=
 =?us-ascii?Q?CymMppGRcIdLe07ab0jaRiYQk+N0rNDnzx+MloDVgxjtgUkBQ3WcfE3kJotl?=
 =?us-ascii?Q?amlDTDx/TFyFQDnukgWxirz/SJdLVYASjW7l+C64w+Z3ML68I2UVCHox+/dH?=
 =?us-ascii?Q?Ct8apqpGyZa03ey0BB/x4YptP/lf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 01:38:17.6664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f28705f0-23fb-4be1-8a30-08dc7b922fd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426

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
+CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/
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


