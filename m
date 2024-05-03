Return-Path: <linux-kselftest+bounces-9304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0EB8BA504
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140401C21ED3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 01:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6F011CA9;
	Fri,  3 May 2024 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mjPDc+N4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0338101F2;
	Fri,  3 May 2024 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700490; cv=fail; b=K/zNPOWqTf1Y4MEh/dWsBZSEka0823/Qhbe/VJUGeUL+IJSr+v8Mjq5BWnh1uIpKKGn339IU2y+PJ0rtbfku2C1trr2/AOq3tuSxhdKHeCyb3IS3MBzoaiQJ8X0mvM6SMAwA8cKELHlU7aBY9s4Rm4l55vXhA4X9T3ihuoIelPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700490; c=relaxed/simple;
	bh=4l3xkcD1caPDxCyWRL3tPe5FK9CqLpweGdbyFIOYZuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsjwDzQp/7jCzF0EXj1sHrL2KuTI1LYTVzZEXbVPjlios3omvaCzTuvBhWBYm780OKKBU0w5q6NmMN3bB8XToAYQcih/L5P9n2Xu6gzeN/IOwAAo01TvHjryXJ7YUUHXFz7MMpa9392i1kUh22VcSy14EEU1My0yNdaDr1OtTgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mjPDc+N4; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv1CFWy1khJNXWAOuobGvTCgUpY03KdyQefJ6RDESj8x1yTSstqz12ho466PRAscTlDj17Qpe6zZXuDXD/jwpk+WYSMqT9SHLJLKGmvEqc7Pgyr1pY+jaW8eRhwG6brUPTP0WKkoeCFh/Hnv6D50mGb1blw0puXkLD76SfqbUelTH8c+zEDSRO4ODlz5Hn9jDDiaWs4NhxgkTXINcy0/Khw8nh4kjBhqpwfQUMR7wiNAHv1JswIDjgPJiSrfY57rmRlwG+y4Syn49yuUtccEZzlxHVZ9rIqxJdYoZm+th9XvCEH/KNSsq52e49QVlwrkiOz2Yj8zIu7F/SyiJHxCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbiOKEBQoR2Hat3wTb0V4CqW2uDZVItbne0hOqpr4HQ=;
 b=J/K3EpzBsWU9vQYSeXAMVkLMo94DRIl7hOdb8L+MIYifspDN1M4fkaAH0MMewJlWxuo0Pc2A5CGXoFGpWBMWLsdrd62LGghACThvWopye3aAh6gBfGeS3Yd1y3ykdWZBj3aDEZYJvnbKE9HgR0K7xywoYk/zwPuDRsh9djTj2Xk+IqrgE+nBNN/WPCeYzfqSnBByBSa+zpXCzNdt0mIqsnTqdz8HX6xbF3Gc9XTYypsJzfPbRzPf+/H3ZW+WWmY5tlI2VqdXccINGPDI2LuecD25+istBJhpngjs9OZMlvKncc76GLtBytLp/vtxA7DE4MXZ7Ww9K6kZRRsLpVF0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbiOKEBQoR2Hat3wTb0V4CqW2uDZVItbne0hOqpr4HQ=;
 b=mjPDc+N4LuwtxLVXOkhemdGXv6iRYnacMeChLT789KXil3CUwcij8nuQM7KDTjiCyIYbJvQNHd4HnUYW3RFWJOyt4sQpq4GROdBOn5XXZQy288T5O3RPfcR9nfrxOys3kZfeVfTmF3KUQU5EYjWiIw1Cd6ElIMNj7s+ci69BLi5D+coD087AoVozE/yD8rSbsLZLL2Nn5lvT2Y23Ul0QD6OIPFViET/xJos6B7gAKMMXuSyNd/QF3/KjbRkXh8gtbOTJ0NfboesiD4wAzs9N3faTPnPDeiUKOCKc3hZuj2ktIWhG0LctAPzkeKUEADj9o9ahTFppjKvZFTGqga9zCw==
Received: from BY3PR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:217::7)
 by PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 01:41:25 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::ab) by BY3PR04CA0002.outlook.office365.com
 (2603:10b6:a03:217::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Fri, 3 May 2024 01:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 01:41:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 May 2024
 18:41:07 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 May 2024
 18:41:06 -0700
Received: from jjang.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 May
 2024 18:41:06 -0700
From: Joseph Jang <jjang@nvidia.com>
To: <shuah@kernel.org>, <alexandre.belloni@bootlin.com>, <avagin@google.com>,
	<jjang@nvidia.com>, <amir73il@gmail.com>, <brauner@kernel.org>,
	<mochs@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <sdonthineni@nvidia.com>, <treding@nvidia.com>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH 1/1] selftest: rtc: Add support rtc alarm content check
Date: Thu, 2 May 2024 18:41:02 -0700
Message-ID: <20240503014102.3568130-2-jjang@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503014102.3568130-1-jjang@nvidia.com>
References: <20240503014102.3568130-1-jjang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a14529-bbc5-475e-2d7e-08dc6b1224f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?02OfKI3AV/0Nki5pAaOjnofonDZ+4+8lfXWqjm8Erf9yv9UjiJnutVS7LIJX?=
 =?us-ascii?Q?1J14KbugMfIENbcWTM9R/9QuEK0v8PoKZh8TZbX6SP0uclxZd4jhV1tXndcQ?=
 =?us-ascii?Q?En+VZWiG7He7cqCo7Xha7CNYxy6jk3L8mQ8PcTKZcyynlSJjSCNWI8BrdXuI?=
 =?us-ascii?Q?6uX0nTzJmyKTKGTkPlCq9gsi7yCpbKvB1veCSpVacrYlhT0e2OdBx2A/nQ0f?=
 =?us-ascii?Q?kZS27s0zDTqMsCRNKRTwp6O5OU6eRrQgNP7kHKArGzgl0L8cKuPJ5RradZCE?=
 =?us-ascii?Q?X1rqb8w4bNyABOWTjzuPXQjfxBz5ECUFUB1v+PMZhIc+cP3OlIGwulNhGAtW?=
 =?us-ascii?Q?Dt1A2eWBl0WP7hCWsQ1XBViTr30hBHeMpt/aWYKMi8czskbnUM1cn0qinhKn?=
 =?us-ascii?Q?Tyh+q/IHK2Euzj7L8uPhBh3U46UP1fSGO1H0dXsMBcYe7eOlFZ4yXej/s6qz?=
 =?us-ascii?Q?frdqwHnA4xz5yGXQO8EJKRn3S5FNCkevJ79d47Hd3uRzldfje2cVH3U2poXT?=
 =?us-ascii?Q?WKx80hIk7zteFM+aFbo/iumV62uESbuv96WJd+vAorMFN5ZZvw5lS2Z/eag4?=
 =?us-ascii?Q?5ZBDIv/zz9G2mqFQO0Fx7CVhM3u5ZBTzqbQADfFJJTO2JvPIpk2b10taIvUw?=
 =?us-ascii?Q?CCBdIniqbBJTkiXyrirAHEnlRvcDH+krJBXFZyqSOZMxGlS8LXJYF9sriDWQ?=
 =?us-ascii?Q?AMfxJaSFgifkTaMVh7m27nWdln6io2WNJWkzsnjrQvBgpbgdwShPqwBFn3N6?=
 =?us-ascii?Q?iPcE9m+xVKUGYs9O/KQRLH7T5ow9BBFNOKPWHA39UaxPFc0cAZOtxDT2DRBD?=
 =?us-ascii?Q?q8jQdgdrXKvH3XY/b5BZgy1YozvdmRS10M/7tKHG1GJDeFG+2jer0+/iajNM?=
 =?us-ascii?Q?KwoL8uPHFer9ialjcscrZtD8Yk9sKL/kq1wfOH5jUebAx5D2k5lON3JKhGOf?=
 =?us-ascii?Q?E5sV3n9SYA5xWVS3+DrT+M472BBjKLN7k2mE7D0XFQ2x3+HP98V+4mToUF0Q?=
 =?us-ascii?Q?26Qz6j5S4rXxvP28DDG6dnGU68622FSBe/U7mWyGMgDLFQuItT9OYFCB2h/h?=
 =?us-ascii?Q?/gMc+epwBzijNCdm7SC8g2p0o6AmyIfvQCJYCTxHIjSHMTjuuguA1ae07b83?=
 =?us-ascii?Q?9sd3WeWXW/Ll7u0GhkUkBYAncwSxV4OtGPYuBlTh2/YrUmpqoxw8JsVtyM8R?=
 =?us-ascii?Q?e3X2W6GqIR+hrl9HjmXbWpNJvcyPzJ0MpNCHWTABMVMrfIEnMgEae1MOFscg?=
 =?us-ascii?Q?uwRGWPM4/dKvUb9m6h3wNhuiTcuFEcqbQ4GZhYWJSTQqClTHoVetWhykyZel?=
 =?us-ascii?Q?pmt3LO5E3MSyAVjDYhuNwLF+WWlE4HalRH4PAbAS1kKFvVvgrL3nBjtjr5a6?=
 =?us-ascii?Q?Hp1sYfEQ0JeRaZpzkUmiYraf8NkY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 01:41:25.1342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a14529-bbc5-475e-2d7e-08dc6b1224f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201

Some platforms do not support WAKEUP service by default, we use a shell
script to check the absence of alarm content in /proc/driver/rtc.

The script will validate /proc/driver/rtc when it is not empty and then
check if could find alarm content in it according to the rtc wakealarm
is supported or not.

Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
as optional")

Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
Signed-off-by: Joseph Jang <jjang@nvidia.com>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/rtc/property/Makefile |  5 ++++
 .../selftests/rtc/property/rtc-alarm-test.sh  | 27 +++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/rtc/property/Makefile
 create mode 100755 tools/testing/selftests/rtc/property/rtc-alarm-test.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index e1504833654d..f5d43e2132e8 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -80,6 +80,7 @@ TARGETS += riscv
 TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
+TARGETS += rtc/property
 TARGETS += rust
 TARGETS += seccomp
 TARGETS += sgx
diff --git a/tools/testing/selftests/rtc/property/Makefile b/tools/testing/selftests/rtc/property/Makefile
new file mode 100644
index 000000000000..c6f7aa4f0e29
--- /dev/null
+++ b/tools/testing/selftests/rtc/property/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_PROGS := rtc-alarm-test.sh
+
+include ../../lib.mk
+
diff --git a/tools/testing/selftests/rtc/property/rtc-alarm-test.sh b/tools/testing/selftests/rtc/property/rtc-alarm-test.sh
new file mode 100755
index 000000000000..3bee1dd5fbd0
--- /dev/null
+++ b/tools/testing/selftests/rtc/property/rtc-alarm-test.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+if [ ! -f /proc/driver/rtc ]; then
+	echo "SKIP: the /proc/driver/rtc is empty."
+	exit 4
+fi
+
+# Check if could find alarm content in /proc/driver/rtc according to
+# the rtc wakealarm is supported or not.
+if [ -n "$(ls /sys/class/rtc/rtc* | grep -i wakealarm)" ]; then
+	if [ -n "$(grep -i alarm /proc/driver/rtc)" ]; then
+		exit 0
+	else
+		echo "ERROR: The alarm content is not found."
+		cat /proc/driver/rtc
+		exit 1
+	fi
+else
+	if [ -n "$(grep -i alarm /proc/driver/rtc)" ]; then
+		echo "ERROR: The alarm content is found."
+		cat /proc/driver/rtc
+		exit 1
+	else
+		exit 0
+	fi
+fi
-- 
2.34.1


