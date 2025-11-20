Return-Path: <linux-kselftest+bounces-46090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 64224C735F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 11:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D18C35E7CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 10:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208713168FA;
	Thu, 20 Nov 2025 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DdK27l30"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D2293B75;
	Thu, 20 Nov 2025 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632878; cv=fail; b=C8tHa0Ckg0pIG/FaLL0JKeqyMHJSzv3S0eq2vygcC2dwC0cTEwMrHvDVzLTNGssa1qq+tv7GUcFu2csmWSut/9HFLC09/cKu/5tptEGcCrVYVR+O1E9HMSx4kfQEEcZcR/7Q5EtX8vdd2NRgJp9xfsqy59kuzevNu598uVeyOSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632878; c=relaxed/simple;
	bh=KKQ1JdB766Z0RW8iGCM9uuc8ApWgBosEm3U0GDr9ZiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOh6Lnc6DN7VeemtiB09RtanO4ic3nOd4Y8edg6ASNSRuydNncwhI4g8k7mF2h8Z0bUffsQz5qyi0Dbe7D+aBWb8x6CkRgNTHaltD5+RL65NzZklEbxs1AEbjg/Wny5WImY0TawVCCW2SliECAQuu+wQEkbOAbFojv1nUBB/ZYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DdK27l30; arc=fail smtp.client-ip=52.101.62.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg3mHygqQy/943wA75xHlcz0sRIA12Gv1gflzn+ePbHioHJZjKzdILPV/btI7uzYwuBO4TGRalUBXQ8zQqWqZN3FDvNLofhPPxiDp3zDsM00fq70im9mo+p2i6vSoMaKz7r4wn7Q5Vokotz7ZitBF/hnM+P5FF06+mBF3j2X4tqMXNAZRo1qC3UmlvJM706ZTE8WKvrmJLeKE+K3jbygM1LdykNcs4d1JDAFo+ooO2qsVUpSXtD8eAF2NMO1aS9YalNSLddIAwUwDcgcD77A5/vviiys8a85vXXd1nxW0pUqeybM+Gdxpp/cbsDLRygveuKJ5pZyjh1kZFGBD1Rclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq73WCFQcHW8vNNIoGzrZSMw0q1uTO4dGi94yMScElQ=;
 b=qaMcG6k/JQQzsMMlVKbs6Nr/0ULq3WQYeYZJgjuwwQeebRdhHHeWS493scwdMSk6ch61xDGnWzW8YRT7vOWCpcchHWwbGog6joUJ1XDJlGmxrS7ymCxKcpqvLGxf95F35I+ZSvtHbdOj13cy4uLqzh356vyAZVSAV2MO2D11KjBdOQ2YdSv9n5Sjj1jZFCnUxD/4s0QsE2GKTBNYkPrgI4YtTnExtp45j4PCbDu+0DP91m+R57ZDhkYQWrYhnGick9bjLB8TvigqtBkHZcf/8KWfDDFEQnUvu5wy8wzfMBR277tSqAdNaoV5y331mhhgWn3hBbPhJLBKZdR35dhPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq73WCFQcHW8vNNIoGzrZSMw0q1uTO4dGi94yMScElQ=;
 b=DdK27l30kaQOPEanJeugN6HavtXK5GvOLWc5LSSAtYFrydfYBoiDanJmewRO6gndd31M4VpcYXcirX19YQ6QVDwEFhfnUupuMvnltvhpTL+iFGcGqYyVACzh05hW862bREUgSWi3XesUlRyZVlCy65evfPphiKb7u6wvWVH7bmfroId5YLiCFG3ZlehnjJ92yQ0FnhzbDxFUp7CysqCl6TSEEow1oPY9Db3niYojXNmuFA2YuQqcOBdJeUZD+G8RTqvTAi9+YSKgqiBthEDgG8Qq4aL5CiQiu61MuR/UzecwMXiHHJgoN8GbRy2FDZLnk7kRkNM7+1ypZYUNMvXXsQ==
Received: from SJ0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:33b::14)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 10:01:05 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::ed) by SJ0PR05CA0009.outlook.office365.com
 (2603:10b6:a03:33b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Thu,
 20 Nov 2025 10:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 10:01:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:44 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:44 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 02:00:40 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 5/6] selftests: drv-net: Fix and clarify TC bandwidth split in devlink_rate_tc_bw.py
Date: Thu, 20 Nov 2025 11:58:58 +0200
Message-ID: <20251120095859.2951339-6-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251120095859.2951339-1-cjubran@nvidia.com>
References: <20251120095859.2951339-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 7203c175-748c-4e8c-2bcd-08de281bb846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D/oPUbKj+wWU/sKpYjbVLqeLM0tESpS2iJdPC/hz6slQwyhWRIHYsb6Xww39?=
 =?us-ascii?Q?INtXrRSl8fZKWJC02KM0BhBk2SqzikHlZRByhCxHgtbank8SAAKUtz9PuudH?=
 =?us-ascii?Q?PSUw2CY0TxWbrjUXeLvKtWw56tLVLubgLWyBACLvzZPMuAnMGEojeIazP1x+?=
 =?us-ascii?Q?4THnWAwgjB9gmxg3ktibatV2PBLdlANOH4vahVf2AUuEtKSosKFgA0AMD+GG?=
 =?us-ascii?Q?2NQiysCZY/RftXswbxaNHY9Ula4scRoS0TPZpBhNovHJmAL3Sx1bVl6S2owY?=
 =?us-ascii?Q?qblgVCNaSXicW/UhULtkSajdk64RGsAaU8Uz0T+xX/slpBnA30vyIpPH/s8r?=
 =?us-ascii?Q?lQNg63T+KUq3wkxzIIumKz5M4T4RUJIostj3xsj8nVMzkhOJJK0VVeIFbPUN?=
 =?us-ascii?Q?pHg1++XRI6Cx0i3zN+R6CMPags4TlZrjXFu/v5wQ3hYA53yuNLcTZIOz4d8/?=
 =?us-ascii?Q?rQuOduRparQCdorgqjK7Frnnjf9yg/XS5EwlcOKOfu01GOckhMQDzLh9hXP2?=
 =?us-ascii?Q?miODnzrjVnr5p/zyAQtRS7Tmm+ai+0l87325SjgurWTPU8KLtaOgWGaQmd0e?=
 =?us-ascii?Q?rPtFtpG4PXZ/n4KHs8XPz2RWQdELXYVomr+vANIcWydxQ57SuhzYR3ToJW3k?=
 =?us-ascii?Q?i4kLbVLcRVXuy1mzU92pizXcgZ6sOHjdIsDvv08Eg2Y3ulDaJ4EPH+JbHxEg?=
 =?us-ascii?Q?++s7JeBOYrmMi+YjTCGs/iB1vCyLgkAlN/i1U+60p3m97DH2Qsy4Exx++4lW?=
 =?us-ascii?Q?6Odecf4mC9vZFV1F1UURxZVY3+Cy9rY5GyKgpkVVsvHNYc1fBHv57zNjXxQk?=
 =?us-ascii?Q?W/3iBpeZukHxm+yyDKjNuy8ZPk+QvJ3l4EVLJAmplTnYfvCfAhhutkhAweOy?=
 =?us-ascii?Q?Rkq4YJhVIaYKpZ0KfwaUIaLntOb7eB+odQnE/wbGZkXy6jTtkNwqzJILonSU?=
 =?us-ascii?Q?E9/emKP8PZJDRtZM0581NYUDRtnC56BBRFWgil5lwaBWwPa+U4JvHhkK+IwK?=
 =?us-ascii?Q?vBhC5Tx8iLRdwJeAVp8PHbzNyXLpLcx2WNtuSca/QawO+/Yv+aGhhrlNvriF?=
 =?us-ascii?Q?4FFGwmA+O5jssNOd+MPeo1KDr3JLRVBPLLmopRHy6OZWVrQaggEB1ELKaHfb?=
 =?us-ascii?Q?0Ox68uatmKnTR68Y1bm1GsIi2HaZb4Zr03LIE8xSx4RQwXI6RnkidDW/0dmJ?=
 =?us-ascii?Q?8dz81851yZ30R287+PfcabKBBT4lLRbZPKDnYfCbakuhbN2dlpD84K0C1MaS?=
 =?us-ascii?Q?h6iHoKAaSbcGUd+Br4RMqSfD4kPKDbHxqC3MqBVLzltBVz4m8KZxbovLu5Wx?=
 =?us-ascii?Q?NNiTi9aN8Uhqt3ixTXSW/C9O8f81brijGFnBzs89x46tIKXYaQyVk4F56GTy?=
 =?us-ascii?Q?9nJaZ3j1F/kzFQAQ0GGjIIOX3k7QdH3Oyoj5mNE4+tTF1HpQ6BISPZ9/pJMf?=
 =?us-ascii?Q?VVvHkKrNZm1lfNxqz4PB9o3BuDhts6wGULO3NttMLYT143zMrtjGsQ82dOF/?=
 =?us-ascii?Q?N3gbPKR0T9P6A8Mi3sSp3PeYPSK22yY6eEZ5A+otLkx1UdXwdCu41FRgdNfj?=
 =?us-ascii?Q?1XRCCjGRAYzec2Gt9qM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 10:01:05.2687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7203c175-748c-4e8c-2bcd-08de281bb846
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168

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


