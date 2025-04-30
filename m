Return-Path: <linux-kselftest+bounces-32010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31770AA429A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 07:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8260F4A3459
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 05:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291311DFDA5;
	Wed, 30 Apr 2025 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U0WCWih2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3571DE3BE;
	Wed, 30 Apr 2025 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992100; cv=fail; b=YB5pfIMz2d1oceTL5s5qiDC6AklyKKFT8wSrQgjrn/xRPc9vtJL/TMRz6AmKB6zEV5wDFjj0umNxSre4a7OCQ/H+th1fZ2PGY/TGV9tjytXXKmQwRTUKK76AogBkEAcHD2j2xvdQWXB/xyH9JOWANI4ROdQA8Y11yFf2rTUyTRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992100; c=relaxed/simple;
	bh=BLhufPOWBg6iRCrfywlbq9EivH4OpdhCHf0r3U4LPc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QycEjGt1A5SPzPGCIuTELRGY6ETGyOkvzTTFCW8047uhz0y2xI2fEQCWowb2iC/cTetus3IZO2nbEuWXXwnqXxX5Pl9DJfjT3sDq7zApmgtNMxTL7DNXJoBCgo8M8AZAyQux13HHBulIMosu37ZzpE/UzM/Q8GDw7zUDMRCZNb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U0WCWih2; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4NkNz8JCS2bbrbxiKp4/7PLxgZgXAEllcLVx7p6X93NnPBVdQvAhfM5QbpP1yDq79W4eDNO/zwZ2X+kQLkfZSGbZFJuG/WQzPMOJx8tg0Vot8OH8+5SUpjer/WLBkxfvTdK5+Gnf3NFFLT9ix7h7K4+moh2o9G1dJviNyJmSr0T8bOF5Xt4PJmeZtoeO4s4x5Hh7DaOrxOf0wkGs8qZYd1isG75ed1xKH7gq7IF1RC9vxoo6j7yn4rcMHKB+/Qt+Vav3dufc5k7Nlvarihd8WWRakuVUFCRQc4uBZx3EV/TcvoCyiDIWw498YqJPOJvW/smVjYP7zmE4XO6kbonWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kj1KF1fv0nSUs91JFiqyJWHSQeKJjYmuS7r92ZwFdiU=;
 b=PvHBABWSOZnIAZBAE++1pHF9yEgwGJZerCAjsuY+jY5mB4INdIbybA62vZ7I+q0QXgTzd4q9ScdnI4S3Ss5nL7bWsBHsaEn5JUcW8KiIfIz9RM3v+Uiy+FE1ycnkR9Hp063IQTY47U1rhBmFNTcd6mVS/0d+Y95ZA+tlLztfPE/OcaQhOK6FhzSLkK34wgh15xuBLYSQZMgqby81SLGZFWXH6ilUzCn9nVzKja0sU24S0B0QklU5vAx5qOdo4Gc0/iTcGsUZqEsTjqnQjNozbTK0tNAjMWev/Cc0ExL3SwsSHjCy/lck21/MWHSxdTnzEQwB6b4mGF8h3+rn0yp2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kj1KF1fv0nSUs91JFiqyJWHSQeKJjYmuS7r92ZwFdiU=;
 b=U0WCWih22IC30/fGIzRaxekunQ/XLsV6ZL21iZJhEMpCYhhxe+PzLIT/MImxLD/zdSXicfvkNLfJtUCeY/DWscKYaS3d0Pm6xMfZvf/NTPAPIIMzW5vzxszpMUsAhgdU7J6fdmyymUcGEuY3zcnZg/i37o1M++DAPGFjyYxEUhOmk856QPh0EzoPGFeCALRVUV1KAFYtowzZe19R/ghNjtoXgW3Qy6dv4MycBQ0zV3+PtAGN7CYk0+Ia61Q+Blzbw2j4EHy0CWPdPoUbb5zpN7Kf9ZrCDOwQ7toKRREUuzcE6Ze2g+5VHrt5290lT3Qer4U+W+yzS2PfXp9XQ3jY6A==
Received: from PH1PEPF000132EA.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2e)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 05:48:13 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF000132EA.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Wed,
 30 Apr 2025 05:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 05:48:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Apr
 2025 22:47:54 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 29 Apr
 2025 22:47:53 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 29
 Apr 2025 22:47:51 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net-next v2] selftests: drv-net: rss_input_xfrm: Check test prerequisites before running
Date: Wed, 30 Apr 2025 08:48:01 +0300
Message-ID: <20250430054801.750646-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 577d1f2c-b928-4309-fc26-08dd87aa984c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xt6ZQNDc4Oe9YbGNEaJ3M3RZhRawXwtE3fNXfX0k0xgK/VUL+w2pEUtn9XuW?=
 =?us-ascii?Q?qFY0jcV4ywWaEHsF5oyN5UqLzxp0S8UDHHiV7ptU8xk42n+3NaEHiKXZVQPh?=
 =?us-ascii?Q?BHeM6yHMNC/lH3SMskEve5iwzIcilYUbkKCEqL7lfTUUyE9+e6u/jo0cRib0?=
 =?us-ascii?Q?O0U/JPkO/r9QaL8xvRusJ96uE75D5XDDY2e90rbpDoRGMC/KbSjTERimesOn?=
 =?us-ascii?Q?tTbB8kAOyXPjcQmx4qsH03U+uYn+EdICjHGCdcYhaGcE7QA7Z9fvDaVIcyKd?=
 =?us-ascii?Q?PfcE4kIebsP23wTbGMBW/3fzATyv4GG+2LqA2oPhJR4dMwER9dCnqQ1TYUO+?=
 =?us-ascii?Q?imGtdXx2Dh6L4XJxult1iClWkEWHqymMDeQsdh1sT0kDwW4o3KUTHEgvRBq5?=
 =?us-ascii?Q?5rngsX+CyCVb7k/lEuTyLcdohZHOcRS+pfbkNyg0Y6MLmYqw0stJh7+P9fOK?=
 =?us-ascii?Q?ra/9FAjLQHlG3e3ZfM6uoCx9N9r19vQlZrM1dEhrot9UE5Qunf/LBgVEi3tv?=
 =?us-ascii?Q?3KbFxFJdEsPtDaURSEkFeLxP7a3jtkSPBQrWB06g0JHmHLdYgfsZnV9a62Nn?=
 =?us-ascii?Q?Y3kdSgUn0JhkK4NS5L8zPIOZxmSy/dufhRdcZWLr/bFePyI+4Kpjmr+vVh63?=
 =?us-ascii?Q?2vRj2E5Js1RgNkaCEBkZVyU3qm+P9+gRf6iQn/G74563eTsAsCwDnLEmoWfQ?=
 =?us-ascii?Q?4P4owEf4SE5dY3X+wfDEIRevOz3DRc4VgJ09RcEHp2qGVFqOS2VAsM6iWNyw?=
 =?us-ascii?Q?162z+OTwSi1wm95WOwbuUmDpjzSxct1fHhU1bCkYHTduu/7qhVpgyg7IvhuF?=
 =?us-ascii?Q?bzK/dZcEzSvdpjCN7QZ2hVEAthXULFB7N6ExZih5RwA5JRVbddEFyiod6dVq?=
 =?us-ascii?Q?Wwb5QLIsy4KbqJRCMKCNmR3Npbs3k7UiOsYbi6XlwNcnFapVcPS6az/VSf1l?=
 =?us-ascii?Q?42nVJZ57ITOOIf0Pn1YAeYlIbVgE8sF1+2udP92A5SfANYiJ2qTCYgGNPl7R?=
 =?us-ascii?Q?ngCZXrSL9fHIr1ZDRRxdsz6n1c4Rfkg2m2B5XocAq8cPJEsaZDRJ94nK7v4o?=
 =?us-ascii?Q?v5He+ChiOuNZpbnSMavj+BqRSNLFXt3OrdALuW7LLz/pxdoqcnnuhsMVrB/B?=
 =?us-ascii?Q?vl0pgB6KzREF/LAHAQtq2K4sHe51TWnEJG0EnfYXgesJP6GpYAOyIEwhVSeA?=
 =?us-ascii?Q?4urOOwXkMOv4KvEczeMhQLsq6puOr4+6BxxHdM0zE9sJHYI9QBBepOSb59zG?=
 =?us-ascii?Q?p8vfFkrCX8CQ7SxPDBk9ApvmjaqrAkvovHX5/Qo4xEYM4EGwXrv75W/oqCVa?=
 =?us-ascii?Q?QYzZuE8YNv/FgyzU6ottLysEAnroAQdlf+gv6YjSf6mhIPSS8n7CLpvU7h/d?=
 =?us-ascii?Q?nZl5098X9NLwBct5Zrxu1oIF9sjf1h8V1QsqZ1FneAjLaFCBKt2aYggqtjBK?=
 =?us-ascii?Q?+QBx1Gx6aq0Bsi3nu+/b1BDCLErHPzpsnBATfiTSPGho0incSJUiTa6nC1Uw?=
 =?us-ascii?Q?XQh+983nzEXqay0JF4QCS383naZhyaRqqgUYJQZQtj+9stpPDwTU6+NZOQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 05:48:12.4370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577d1f2c-b928-4309-fc26-08dd87aa984c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316

Ensure the following prerequisites before executing the test:
1. 'socat' is installed on the remote host.
2. Python version supports socket.SO_INCOMING_CPU (available since v3.11).

Skip the test if either prerequisite is not met.

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
Changelog -
v1->v2: https://lore.kernel.org/netdev/20250317123149.364565-1-gal@nvidia.com/
* Use require_cmd() helper (Jakub).
---
 tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
index 53bb08cc29ec..f439c434ba36 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
@@ -32,6 +32,11 @@ def test_rss_input_xfrm(cfg, ipver):
     if multiprocessing.cpu_count() < 2:
         raise KsftSkipEx("Need at least two CPUs to test symmetric RSS hash")
 
+    cfg.require_cmd("socat", remote=True)
+
+    if not hasattr(socket, "SO_INCOMING_CPU"):
+        raise KsftSkipEx("socket.SO_INCOMING_CPU was added in Python 3.11")
+
     input_xfrm = cfg.ethnl.rss_get(
         {'header': {'dev-name': cfg.ifname}}).get('input_xfrm')
 
-- 
2.40.1


