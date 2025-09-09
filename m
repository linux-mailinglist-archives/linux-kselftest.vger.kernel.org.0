Return-Path: <linux-kselftest+bounces-41049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1F3B4AA35
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 12:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69076340694
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28EA326D70;
	Tue,  9 Sep 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bs6AewBv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56E326D62;
	Tue,  9 Sep 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412932; cv=fail; b=HmAERiFHczhVDiAMUd1Yq8ELFc1wdBxqHo3XwNqpxdHWJaD+w3OP3sPwKS03R/8OIQ46BPFmmvpnxuqolSZhO+chdS33BjBzSOEhRjwiZCNX8cSjPdIv5+5wZhCvWkEl4k1ARUkoXdZsqdQbdEQpt1MfUt5FskQuHeQQPoEcK5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412932; c=relaxed/simple;
	bh=6wgXxMCvlabAWX0/oBrp4/JIfgN/fpkbock5Gs8RVYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbERHzU2hR2GYd7REgCF+kDGqh+DS/f18oURg1Mzorl0uS8vS3e5/leMfKhitNSkZqwUbUs0HfMCT4pTvJmyFEEv13X6s1ORgt2jtGrw2StGVqRYVFOIlUvuJpvS5CyIE2Jsr0kgTar4nC9YgMSh1lTJS0Y7VI0Q4TMrkIrXFEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bs6AewBv; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQyARyhZBVA7RDsc1DNTcEeCM3jfBJiTU3uzmhtfJ2yUh1EyGM1WWcRDuWPiOhfOteKS1q5yQ/hmezvHxeA8fL32hOFlRWVVODOhvwdZp7mOBx3JvIeKdnaFUrEkjVSZstKBiQQZQBucWXSbn9eeG73BH0/hzc5gpKpdHfSbBf47Wx7Gdq9vZ8q4dIOcZ+yxMN0XTjaZ9guFyq+LEQaG1Rwf9WOrHwzptagczmfuS47y1B7WGGdORqKXHXkWn121yAquM/+0FCbOWaJFq8K2p4e6MxDixCMjuzWaDTfepgJPjS559+7knOwhz7UuT7bab1PuYurZ2U1lpECXfmGLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhH2r5Hbo3r/Gql8G3xXzWnV/+gRk8rWCHIHFCtTZmA=;
 b=xU6vvjt+97643gL7Q4V2BYNxjcoEfO0oaBxrdBCxxaNVqxRQKZ3vIrI7RGrymQpncgxerivdyFUwxhd2/+FhD6zkPlFVxbMKRH64VfiFtKO16n4O9OW/I4Eb8MVJBU6bFqnlcPbZzZI797JbywNGzWZxZ4FIWdQgtqnKxvjCc9/mNG7+u6eVoIXx/Q1eOkLZDGjMszWnIUYd7HTsQtthcWuM406Ug2TPnfSMg5adWiJ+b7wED/VWwS4lMOIntMXcc84rhBrF7RJqRQ+0zSPxcOwogpuvYXjskQ8oDeIdlDA8F583BHElsvI+/0nNHRnpuGpkv8Nvcxfej70TUXm8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhH2r5Hbo3r/Gql8G3xXzWnV/+gRk8rWCHIHFCtTZmA=;
 b=bs6AewBvjtUzUNcqjjr6xDSMW4H3xAiwjj/iJTsnRvGi7uX+WW/SVx6Ih6d02Rn1Jm6pkKzGBzVP6/mCYga6Sz/euqyHskNx2tKJ44kA8DiBRjGCjqKS+kAvhKRFGH91W97k4RQEYizvP4BtwG2qR8UErwWyxKjc8vVkakwps/AgwhkwX9YPuRAD8rg5gXH+KnLWlXVpnDvNnKGa66BClpwduPfE7FAQfrUTi5OiZAWT8UqH5n5JWah5ryHL0BKnaR5S5NtLyDiJa3sD8Ou7KZmqNaP9tQjtQmyQevdLfm2vF1pJ3ckMxP7EtnCAo223KkbMSHJoudeiohypKd4plQ==
Received: from BL0PR0102CA0003.prod.exchangelabs.com (2603:10b6:207:18::16) by
 PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Tue, 9 Sep 2025 10:15:24 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::f7) by BL0PR0102CA0003.outlook.office365.com
 (2603:10b6:207:18::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 10:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 10:15:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 03:15:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 03:14:59 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 9 Sep 2025 03:14:55 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 1/2] selftests: drv-net: Fix and clarify TC bandwidth split in devlink_rate_tc_bw.py
Date: Tue, 9 Sep 2025 13:13:52 +0300
Message-ID: <20250909101353.3778751-2-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250909101353.3778751-1-cjubran@nvidia.com>
References: <20250909101353.3778751-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: fa719e32-7c5a-4ac7-e535-08ddef89ca67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+dLF+ujQaVAfgmsql4HjJKYXEaXcYVWpquxxVeof3Ero+eVm8r2jVcMyOr5C?=
 =?us-ascii?Q?46yowEuD6cHtftxQzWPjI0oQU+Ql1zEzRXaeFin+ZtleaTINP7VfTrL0t3ev?=
 =?us-ascii?Q?NH0Tr7caTqhfZ53YuREZYVGHRouGuT348U4Xr0GJ9Uj6gChd4KsOSxfR8Lka?=
 =?us-ascii?Q?ndQzI+GJTrQa61MSUlcQUAY354P/zkoxGFPYpUMQDTyvnbp2EMvOfPLy/69J?=
 =?us-ascii?Q?aMnpWTuz1PrkvSl8FD5Z9yHaNr4kgAvTd1k17RpmlIN/9t/zq/GEOsc6q96a?=
 =?us-ascii?Q?TtM7JdRWCeUikH/0IJALg+OLznLjsUOAUgr/eeXSmMRWRLFO3DkhZK7E13/E?=
 =?us-ascii?Q?LPcYtzNIE+/SgNzgsFE3HicLHq6X9ZdO1bDoNt9wxumKislrrUKyw1ObrfvL?=
 =?us-ascii?Q?gEo0u+O2BJN2rflIvXV0JLB5l5RMDGaLNoMTLTYHNDjaGYiLmnFUclHL8Cvt?=
 =?us-ascii?Q?Uhdnit0rbTlCcElcwFH+ls+WVxQLQKGKduFP7SELbvMDArMr4l9EpzWVEPoX?=
 =?us-ascii?Q?IZ4NE3Aj1m6lXjVa/obcl3NAaE7KieVxIJU4mSxIXI4QQ2Wwd5iR8YimckS0?=
 =?us-ascii?Q?xdbtb+if7eNpgevIA3oBF/GIhyQRJI6sadqo+2Wmv4APKuhnFje6RipD0Zye?=
 =?us-ascii?Q?jxaX0+W5cPVCGtDSSAS+ZHsHlSrRdSRuZbTpFPwrbpXTeL4j/L7guXAuf8UW?=
 =?us-ascii?Q?namLlp5LgXZB65ZDPP/txOen5l8M+ovDEmyJjs0zu78OvgQW3wAhk9L9MKc9?=
 =?us-ascii?Q?ajI5ZPAPwA2t73Lx3+GT/rXrtVj+7N/s7ruwQ5nBhNVpUZRq+7zeKRIJmQ/B?=
 =?us-ascii?Q?j+0bcGuMZ3hRWyuj5vVQAH3rSd8iEWq9cAy+0x8l87y3qUTzW+hLDKRLpFnj?=
 =?us-ascii?Q?/0iTlGnhqqP76dQ9Ca4tro8n5IdP3EZLNidhONHMqwVIVPq8hhnAJd446gbU?=
 =?us-ascii?Q?0MHqvkEp1ePaPepFyF75vmWEILBIq2RuY/7DrbrasLJYH4f+lj8cVTy5pE//?=
 =?us-ascii?Q?+df5xUsd6N8TThC3le/APlkOQ578260hjrWzZcUg2lMP6QIK8wKDa3BCvTyz?=
 =?us-ascii?Q?tGidJ2pVRR2Vh7hj3hmAPTRHruzUwDPo0WLOeVVrpE0hy8pNq9Crzl74hJ28?=
 =?us-ascii?Q?ECi8mw49SUCA1dX0pS4GcB1ThlPZYpJ4qUhmohwRPDSkh/cnfPKjydaLGVQy?=
 =?us-ascii?Q?/VcZ5Kc5Us5gXcF1QV1BZRT53txGYsyqUJlgbvdu6qbjUzNgffTphxRGnArW?=
 =?us-ascii?Q?G268B9BQMJwlbQ6Oh4MkZg3mL/CmrbE8UmKvopvJ246ab+ocfHEzi3qHmeiC?=
 =?us-ascii?Q?xlzlI2nY+2f1YL1Lzkn+sh4D0NIvk+80vEokut7gaPAXeQTnvySDTbGDo3V5?=
 =?us-ascii?Q?9mJdfw/tQ5GLfSILTLQWKETEmtB9qXd5UCOmGbO0pxv9inBJ5g28FawWASGV?=
 =?us-ascii?Q?KCBc+RdHOLAnu+k+OEBe0kkP9dDfxZKSkftF/ZtOnRmDPCu7QOW7b/1RNyo4?=
 =?us-ascii?Q?Et1G9R2I+oWLWYc7OxDNKGf8YinpfzOWmm5V?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 10:15:24.0590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa719e32-7c5a-4ac7-e535-08ddef89ca67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647

Correct the documented bandwidth distribution between TC3 and TC4
from 80/20 to 20/80. Update test descriptions and printed messages
to consistently reflect the intended split.

Fixes: 23ca32e4ead4 ("selftests: drv-net: Add test for devlink-rate traffic class bandwidth distribution")
Tested-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
---
 .../drivers/net/hw/devlink_rate_tc_bw.py      | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
index ead6784d1910..4da91e3292bf 100755
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
 
@@ -413,10 +413,10 @@ def run_bandwidth_distribution_test(cfg, set_tc_mapping):
 
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
@@ -430,13 +430,13 @@ def test_no_tc_mapping_bandwidth(cfg):
 
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


