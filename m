Return-Path: <linux-kselftest+bounces-46354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 365A3C7E4EA
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 18:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BAE434A155
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363CF2DC772;
	Sun, 23 Nov 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PTKR5OrV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760E32DC765;
	Sun, 23 Nov 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763917937; cv=fail; b=iH/QzMrJp2VrfD3mNklGQmN8YDDm6+AhgwqaBP8EdDNTDAPHX3oHJnvk4Qdn3pWa4fLwKEyAlaLSSCmSbzQoLt8E3Hp3ZbeBmlU8o9q5wGqHbks4I7XhxN73VkCUrFUefF6GIi9C5jqNgwiRiPiTMkz+vX+LWeTwrFmuNgRt6OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763917937; c=relaxed/simple;
	bh=KKQ1JdB766Z0RW8iGCM9uuc8ApWgBosEm3U0GDr9ZiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFbvHq759tiT+AbNBVDI1OvDWJHNaB6HqSDftnHGr9JDVFwMS+dHssuuWz/G5RluEeBndTljcyIbLj7XDOAHAr9dEM9xSfASpM3YZw7lJaLtok029g4Q8WF+dXmZ/q1lHojfEZ5ROh4dAyiVBxYVNq0WaXXDSYpFvKIEyVnWkbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PTKR5OrV; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZa6dzs5pfflrO8adKwKvt4qSG7BFotAd5lkru19CVlw4l3maqe8JCzy8ToQ+n0ca1JfqdNAQ0K6/M9v1ER/1+VxiqyKRYSwbVS5ZDqw/tB3Xqdy8cerzlG/TpWcGhnn2FmVTqhuE5Qy0+CdIrSw1wy21ltsIUASZZiMJJS0waRWiv8AT8HPXx9MpSjMYlLP0jwLsO88/Nwfb+IDqpRMiIauLkbid/J/3AuHfYc9nJP2qYO7R3dCtuNBK7a/gd4+EUsrWpy4rvjKO/Cc5k2j2jE5ZnPkFoCSn1T9jer9lB3EhKNO2AVy36zA0JMMqXezDbUBfmML1tzZruAw+/F3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq73WCFQcHW8vNNIoGzrZSMw0q1uTO4dGi94yMScElQ=;
 b=DA5QVrc+5ye3rymfRVXDwK3IrqMorb4p44xDGY9tNhx7W/zhC8iZHCvvEEuF/m8CEVI9hiQC1PPBBRDdxOSsNKDX+rXaQdZbHw22PspUNnvnFe9wqalAm5IAQPlQSmqQdEQ+mtRhrnedeCjOdUVPiaRhJ36iO4a87h+FVOSWfgHTwDzE6BmbcVtMfsVry5ALa3NzPTdGCx5BV5BCTe/lRMv4MLFOVhcJPAIKULcJ/EWntirFPNyrwUuFVPFxuiTXBGHTojK37l6CGKLgqND1jp0+lznXb5wQM0ifTaep11itafs9aXMLUALON77sx5M3+8Kd4dmt6EcvwXe9hAdGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq73WCFQcHW8vNNIoGzrZSMw0q1uTO4dGi94yMScElQ=;
 b=PTKR5OrVQFZB1/Spl7hGSK/5J3xwgxLwMbUfmudvKoFtOCUer3y4bj6zArsAAA4Na2z/0CkCvgmua09bVLhe1N7RJTbKqxoEEtY9xZQ9/WEMOn7vdUpuNIMViSifBHTEGm/+5S/o4AaGgjvqTOwprMiHWit5lR6aY7hjmNNF3hkFWTgNhNAUO+5T3yUwvU2M5Adess1r/x2Oxv0hpRDYgN8zR3Hnzl2xNOQSlpMUHniGmRpeCvXevSzk8g3ZR4LR8guDN214K5/uIhzNIQkZOyzmnqp4fvwImBPXyvTfa0FxJwbpq8tVwIEoNO67wNtoyv8TQZV0DuEvj/oy0wcLwA==
Received: from BN9PR03CA0661.namprd03.prod.outlook.com (2603:10b6:408:10e::6)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Sun, 23 Nov
 2025 17:12:12 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::37) by BN9PR03CA0661.outlook.office365.com
 (2603:10b6:408:10e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.16 via Frontend Transport; Sun,
 23 Nov 2025 17:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 17:12:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:11:57 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:11:57 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 09:11:53 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V2 5/6] selftests: drv-net: Fix and clarify TC bandwidth split in devlink_rate_tc_bw.py
Date: Sun, 23 Nov 2025 19:10:14 +0200
Message-ID: <20251123171015.3188514-6-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251123171015.3188514-1-cjubran@nvidia.com>
References: <20251123171015.3188514-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 1045882d-70d4-4c38-375b-08de2ab3713e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ldh0fawRHxGjNvMiw10FlaI41XTkiVpuuMnRPub8DDdsJD47wQM2R8lszJLN?=
 =?us-ascii?Q?8pJJy4oEEW5ziE/JeVHo19oxZPk01ruLHgD6/4RS3Zc3+ddDq057SLpKRBoB?=
 =?us-ascii?Q?2OEpE5fS+HA1WZu1X8FyJoNI36RShRnZOFHDSXxmkd8M3O0TTHqHLC4hFFu4?=
 =?us-ascii?Q?tGlnRVa0JGdRq5dEeURbiYho/v5vZbL/s7OxBogrI6q9Q0lL/ep2DIIZaF2n?=
 =?us-ascii?Q?2vbfHDAfDL/h4RlgXOzRmtSkALxNCJCNrqZwXsZy/WfsTC4PfX49q/JIUqQE?=
 =?us-ascii?Q?FXliTFWkMz59yZeyYFLRBwhsqC/q9ywv+1aNQfF+OtHvGNqjic4V1XFRaVs+?=
 =?us-ascii?Q?SYxc/KEJThC1MCLBJX4TQ/KQTSjK18BLmKYUUCsqLXlUgHGpWDsDPcn9aVTE?=
 =?us-ascii?Q?bzYuP1X7NAh38Jc4PGy1mv/X08FIhZBfVJVS214QDomKMPeGy8Lrpj3ZssJs?=
 =?us-ascii?Q?XvoZSFYx/QvxclK1n9W2qeP97IwXetzHRPAN91QIS75T6VRYWF2jDo1il7OO?=
 =?us-ascii?Q?RFTDFWX6cSMR5A+sXEvsZV9BpC5d7Vz1GuqqgRPsRypzi+xI73R+uZ/0SDdJ?=
 =?us-ascii?Q?nleFjKiTrIAeGrg5ZzgcJOeJjMqsu1phIHCQI1O7GUtDgnutiyBHp7NftuSb?=
 =?us-ascii?Q?7tMbFwEiFOCHFwKAPYjAM1BC/9g/KWb/YI22K0KAhFK5mA5CVkYlpduxifLo?=
 =?us-ascii?Q?00imCnHOmaGwwcFZrYq/B+0KJ+41+Zk/0mULv0oI1tB0Wa5XFI4mb8/QHVz9?=
 =?us-ascii?Q?k8Fs7oB0v1LfixG3DsSCruLYQV5c/vSrUF3GpGl4lTYa2A5B8JxK3a6flqSN?=
 =?us-ascii?Q?qrrvAMpKvccc/LIT0Tr5Wb2azQ8a0V6IplHFMSc+CStLiB4jIrzXbTHuWT7/?=
 =?us-ascii?Q?w7bzUaLg4bHQWY97MO6s+Q2Obr0dZl+Y35U5sWXZELJH4GwEmyfX/vkKKA8i?=
 =?us-ascii?Q?l+EbgsBwSwKlZaX2ZypndxX6j7K3jr8JGR3xssOmmtiEE7uOmyag3nVFgwXA?=
 =?us-ascii?Q?9Zyyj/HLkagNMZ9M/WDfiaHezmYNSXOtrpDHMgw8yFr5i0w8DH66cx+O6NmH?=
 =?us-ascii?Q?GEXIZsi6vM3r06yyIGItxYABxlyCIE6hpAfMsUkWGmAp5PdZdsjhb+P2vgis?=
 =?us-ascii?Q?U04pnn7O5Kv0VC08u4h8U+pfsaAdYyg9UOH8wRh7xQ3Gzn/joKxruArI2jJn?=
 =?us-ascii?Q?hUXxhGesUVKWBGuFSH1MfppyduPGGvkvDOVHBdeAkA0C5gbCzW6GW7J35xAX?=
 =?us-ascii?Q?YELp+yiHbTBxvvYZK+q+VNLFVfAEmtMb5SkkKfFlnmw9viifikVXyecryAts?=
 =?us-ascii?Q?hF8E6ERQBaj/uhgTDoZ+TioNxN/uCxyhS209KCrjuRVqT7Ou1dXzbMQPCAyX?=
 =?us-ascii?Q?UHkJK1IAQB1q1N2/YFhGCHxagW02fiDO60NG48EwujAbQdro2clO+XQ+E8Th?=
 =?us-ascii?Q?jEkf1aPdXxRuKYHatQcn4jI9iS0s037k3401jDWi6JvQk97QBWDumaFfzbnP?=
 =?us-ascii?Q?rz06bmMDHYl9lTGP8sUaaiiMsuRDMlqRZtW+xvcqdUqBsV9OUlg4GHym/a//?=
 =?us-ascii?Q?kmaApT64Mc0wIjxNAA8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 17:12:11.8807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1045882d-70d4-4c38-375b-08de2ab3713e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716

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


