Return-Path: <linux-kselftest+bounces-46747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCEBC94CF7
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 10:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5A774E181F
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB402820A0;
	Sun, 30 Nov 2025 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gmoHmBDW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2605281357;
	Sun, 30 Nov 2025 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764494495; cv=fail; b=nnRyljqiLqwM21oBXhe5RhMlQvDfn6DVZ+dotvdcwxy0r3fgu71CrYQKKSO62BbcWgnv02iQAQc8EfpiI6Dk5y1EF3FIhuLB9D4N3wHX8anKb6MtREwbqu+SeOL9DylsyIaSRXgWScFsQl6vESg+3pRxuOAqMezgHWJwKO0YDhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764494495; c=relaxed/simple;
	bh=KKQ1JdB766Z0RW8iGCM9uuc8ApWgBosEm3U0GDr9ZiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nl/GqEh2kkVvLyTzlDESwtZFJMUqHyoPbejD+EDma+OjLpCoOy/vhoXvmoNrIsXItb3q1klpvfbnzSdSDd+AkWrNPR9VtvVXG2TbH8vcLROduNlrNFSJJ4V/4R4GmP2g7GHlEq78ouXBzm7l8dLqcvzrMzNQ2yA5QoltWuS2YhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gmoHmBDW; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGpwtnsXCetmOM+Xv1BYBvGFd0PZRttwpkvskoPmBgVtrRCqUe5A7u1zUAq8x/e7i0RI+CDlA4DUpZZxCtJedhTI9wSGS//9joEx+5sSCsase/84LKdNnmsqUhEYDrvwRvB9m7F/M0NqJDYO1Az9HAWnd3Mm8FR8DO73twbETOPvj3E5xJmcVytE0iP0A5hlRuzoS0RE9FProapCHV0CAgGHyK71nhO4uyU0Smddh3wryiwp/JMQI14a/hKYmVhzJPcxW+9770/hsmZ4cHAoWG8g19Joz+mLqavCHVowSMrlvRjisiQN04ezPfaDziBncK/qNixN7criCQq6DDL61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq73WCFQcHW8vNNIoGzrZSMw0q1uTO4dGi94yMScElQ=;
 b=E1ypCn/aj4DJC5cyDJlCwzVukhbMn/Ri4zzWz4M9byUXjzsrTfb9k7ZDDvbdUaE2Xl0qbTpVw2io1mjGvxZYA+J+bLfoWDu/cNTxhiCdg9lvG9JLWxS9rvAMZCnwt6S2gTC9PzmoE6SvwRJFWsTI+p97kXUf5BUEnJdsvvYyPjTWM6+1yJx/XNymu/n96Pd+eORfbk1rFKOgCCllNzOVCS+K6RxpbdCHa0F+kzyMXE0H//6i/5RGdCxt0eJKlfbb+3gkQmPfIpuL6blebztVAKnS8sr4gVFALqJb6U0V+NSsxQGmmkChTbL2Wzo1E1yl5qzXXrUSlJbCTdwr1C3nPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq73WCFQcHW8vNNIoGzrZSMw0q1uTO4dGi94yMScElQ=;
 b=gmoHmBDWT8ULA/WkkxoQczd/9kcBjQA59BIxNL8fLGfo+g7pOHSntJ666e+N3S80FyTlprB1KXHxu17MAOMLZJjA0e394sLe3hZ0DD9Z7zrnG/In41PU4pRMVN4X8axvxbLgWZIOf55nHBdLfiK5HhOZfnB9LWmVL5cxTYrMZ5O0LRVrsjRO0yKFEK7jFk8v1L+75Z22P57dlxNSlaEGdsaf9FDCKrX2vid5zQnRJY4G7Aq41Lh02Pz/yAinzuS76iTTWSfnSSVYo7KYtnmx1Qxx/Hu2LwKxppQ5G4FNA68YcQq9E0iC2fIvvpMp9jTobvS7NReI2Rwn6bRyMFnozg==
Received: from BYAPR05CA0091.namprd05.prod.outlook.com (2603:10b6:a03:e0::32)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 09:21:30 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::c3) by BYAPR05CA0091.outlook.office365.com
 (2603:10b6:a03:e0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Sun,
 30 Nov 2025 09:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 09:21:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 01:21:23 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 30 Nov 2025 01:21:22 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 30 Nov 2025 01:21:19 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V3 5/6] selftests: drv-net: Fix and clarify TC bandwidth split in devlink_rate_tc_bw.py
Date: Sun, 30 Nov 2025 11:19:37 +0200
Message-ID: <20251130091938.4109055-6-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251130091938.4109055-1-cjubran@nvidia.com>
References: <20251130091938.4109055-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 76241e59-689c-4002-5300-08de2ff1d8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fl887wF14VbVt1oGSNoKiECFRL/yDtMxn+ZoUjtzvdrG3lFdtCxZJgwsOGuU?=
 =?us-ascii?Q?42MegUcdcUOdvSECDu7MWTQLg8c2m1bYJhDCwOgjyyAlK5fyi/EPlDALspFO?=
 =?us-ascii?Q?xjLCjtHdmZCwVtprZ2UUt0/1ap3sYUy+wS5sNvgBI9KoJYHYrz8bjbvtQGo2?=
 =?us-ascii?Q?EZ8k1PrhYZAv32i+flAyxJU7qpsd02uACkDXl+ioNzAi1sFaacoIyk56Y7or?=
 =?us-ascii?Q?jtKmvZewp5o2UtQb3E5RBreWre5RzI5nP1rBzTgrmZTZQkyH79exxcwY6GkL?=
 =?us-ascii?Q?Aaai68Qyp+rGoProZ0o/eLkc89A87eIDIZeiE6B/FlsaYtaHOPKnQM+1R9BP?=
 =?us-ascii?Q?a0Wdhhtr+N8GKKaPVWqn1x0myGlZw+X9yl5v37hqi9KkhPnZAqb33EpT1X71?=
 =?us-ascii?Q?intI1RnCY4YOoUBhM8k1S99YPsEseQ4pSJD7Mh4OpopyyH0XzmGrDqyg5IvJ?=
 =?us-ascii?Q?RGjthmoNX9QhANqKIahzeYGEsxv/sq3AEDp5NHL48Z2KXCC8a5xFxE6uWvuG?=
 =?us-ascii?Q?uwyXNf9gBA20IkTwPg5RWzoeNIYwnQQfm0ZaKwUGyZxR7eC0RqOOlNxeIb1q?=
 =?us-ascii?Q?HvgD9BTvAsuit04NlNKWJRm2MQa9LJkRwz7fPB6pksilBJyjioChh7Z6P44v?=
 =?us-ascii?Q?pneT33UBUots97fRpRQVrKINfpZ3tF9Ehn4s4Ub8/PvyR2ZrwxWO8gAnt36Z?=
 =?us-ascii?Q?k8CnOGpK9fX5ux30+bg3HSn4tMFfk/zFq1d1/uWkcRHoVYg1r1bLNrP6k5um?=
 =?us-ascii?Q?Y33Y9jWiEhM7If+/gac3xztI0bUG9HwlVwO/2Ke5IdYxIK/g0c/dPZ2ZqgSz?=
 =?us-ascii?Q?6lhRCd25THtPKDKbZb4C4f20gTSjQprRWLUDnqo2+G9sVOl7xNCk9kM+zBrI?=
 =?us-ascii?Q?fKiB81swtEMa+CkfCldUsqRzKw1z4kCyFR3fPxSBVGcCiISAEjLxNWyeCsso?=
 =?us-ascii?Q?AWFkJY7W/xQjgJhJT8U5k1XpSXLGsQTT3WaxzBPF68MBnhEntL9SZcP4DOTB?=
 =?us-ascii?Q?KEAsmv/5zb7zoWFJ9sVsK+qS42KGtNv0ySJ86ySKGBWSm1ebUWDDI/W9DzNn?=
 =?us-ascii?Q?iUSgEAhpY6YFKdvzEr8YvfXjVIiJV+5jPVE45yPlaz5QlB7FpEZmMcyEqJR3?=
 =?us-ascii?Q?o+iUlu0HOp9S52W00d6BqFJ1Y1rt4UEQIlek+jWzr8KoQpaGfOkSPhkSpAfj?=
 =?us-ascii?Q?JMkH3mreKZRWj6ES7BmPH41paVfsY5NTf+3GMjRtWYad2dI0p4drg8YNTOxm?=
 =?us-ascii?Q?cCn4UuWoWwF2PwfE6nyGFqZI7K/D+ckr4BLbAvy0Jub1oJMuIu6WedKABPQN?=
 =?us-ascii?Q?CyWDURETQDlBVk5muOVO8EFT4THZfaVqWBtBcT83Ek9t1YPx/+ZbhbBUCB99?=
 =?us-ascii?Q?OYSymDqHB/jbJfStHGLaM6WhiBFu0RW5TbvQNiSxCgK3+ona/RkL0r2k5GS+?=
 =?us-ascii?Q?LIwFLhSTVxDWFS5yTZUwg3RCviC+ilerxO14PjN6lpq3f5WNTvtHjVZv4DPx?=
 =?us-ascii?Q?p9dM/R2/VXjUzXT3+uM1DCwCfiIe2d+WMH1TuUUdUpuQKpyK63+Sdd3af2Fh?=
 =?us-ascii?Q?BHXp55fOip2dLjjYfEc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 09:21:30.6814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76241e59-689c-4002-5300-08de2ff1d8f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320

Correct the documented bandwidth distribution between TC3 and TC4
from 80/20 to 20/80. Update test descriptions and printed messages
to consistently reflect the intended split.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
---
 .../drivers/net/hw/devlink_rate_tc_bw.py      | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
index df71936531cf..db24bfc51da4 100755
--- a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
+++ b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
@@ -21,21 +21,21 @@ Test Cases:
 ----------
 1. test_no_tc_mapping_bandwidth:
    - Verifies that without TC mapping, bandwidth is NOT distributed according to
-     the configured 80/20 split between TC4 and TC3
-   - This test should fail if bandwidth matches the 80/20 split without TC
+     the configured 20/80 split between TC3 and TC4
+   - This test should fail if bandwidth matches the 20/80 split without TC
      mapping
-   - Expected: Bandwidth should NOT be distributed as 80/20
+   - Expected: Bandwidth should NOT be distributed as 20/80
 
 2. test_tc_mapping_bandwidth:
    - Configures TC mapping using mqprio qdisc
    - Verifies that with TC mapping, bandwidth IS distributed according to the
-     configured 80/20 split between TC3 and TC4
-   - Expected: Bandwidth should be distributed as 80/20
+     configured 20/80 split between TC3 and TC4
+   - Expected: Bandwidth should be distributed as 20/80
 
 Bandwidth Distribution:
 ----------------------
-- TC3 (VLAN 101): Configured for 80% of total bandwidth
-- TC4 (VLAN 102): Configured for 20% of total bandwidth
+- TC3 (VLAN 101): Configured for 20% of total bandwidth
+- TC4 (VLAN 102): Configured for 80% of total bandwidth
 - Total bandwidth: 1Gbps
 - Tolerance: +-12%
 
@@ -402,10 +402,10 @@ def run_bandwidth_distribution_test(cfg, set_tc_mapping):
 
 def test_no_tc_mapping_bandwidth(cfg):
     """
-    Verifies that bandwidth is not split 80/20 without traffic class mapping.
+    Verifies that bandwidth is not split 20/80 without traffic class mapping.
     """
-    pass_bw_msg = "Bandwidth is NOT distributed as 80/20 without TC mapping"
-    fail_bw_msg = "Bandwidth matched 80/20 split without TC mapping"
+    pass_bw_msg = "Bandwidth is NOT distributed as 20/80 without TC mapping"
+    fail_bw_msg = "Bandwidth matched 20/80 split without TC mapping"
     is_mlx5 = "driver: mlx5" in ethtool(f"-i {cfg.ifname}").stdout
 
     if run_bandwidth_distribution_test(cfg, set_tc_mapping=False):
@@ -419,13 +419,13 @@ def test_no_tc_mapping_bandwidth(cfg):
 
 def test_tc_mapping_bandwidth(cfg):
     """
-    Verifies that bandwidth is correctly split 80/20 between TC3 and TC4
+    Verifies that bandwidth is correctly split 20/80 between TC3 and TC4
     when traffic class mapping is set.
     """
     if run_bandwidth_distribution_test(cfg, set_tc_mapping=True):
-        ksft_pr("Bandwidth is distributed as 80/20 with TC mapping")
+        ksft_pr("Bandwidth is distributed as 20/80 with TC mapping")
     else:
-        raise KsftFailEx("Bandwidth did not match 80/20 split with TC mapping")
+        raise KsftFailEx("Bandwidth did not match 20/80 split with TC mapping")
 
 
 def main() -> None:
-- 
2.38.1


