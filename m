Return-Path: <linux-kselftest+bounces-40375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEE5B3D150
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 10:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93D17A2C2C
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEAA24676E;
	Sun, 31 Aug 2025 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BBPzs65e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B7EFC0A;
	Sun, 31 Aug 2025 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756627667; cv=fail; b=O5OqdNySRFMAhSdhLoe1fDjCHv/Qj7aZRMzarr3hYQNrtA2liDyBw3bFuQCMqduPuukyWH8COjXBjXrlpE2KOhx8eBlcrv0LNYfMqT96mnG4iqr08qIMI8YxAfy4U72+ML7pyXBgsR78Ehb/78VHDoDP88jLuHNyxorjqp8rLvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756627667; c=relaxed/simple;
	bh=6wgXxMCvlabAWX0/oBrp4/JIfgN/fpkbock5Gs8RVYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQTp71L5qkA70eSlKALqOB34+/ZWrqmCL5V9m+TCUpq2Czjki5dAVM70DUsv7DIzQEZ3nB+HL4Bs70brMVh7ZZ113gDlPPj190/yyXZx6A1L989RfTA0m9+3iJJ+fe1mCNHcgXc1nNP6j9e9XzdXQ1tfIFyz6XxHGjAmLG+KwK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BBPzs65e; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSNbMiSQgLMMMB7jT8TXQuz6Aa2mVeVJS/cN3ubBoQIO6FzoHR082zMhiLEIBt+kAtIF601zQEMu2PIlN93G9i+z46jaXJcx+5GGuEXCMyfw7TO/nfeyUwm1UOQuEhkBk04HXdfuykrVJQqNVocMazJz5CS95v/TXH8FH5il0I2FtZ2zsYaxhA9e31tXzjACJJlVtCF/UAAHrQYsbeamrLgD8qlTUyU5YPbqNSFm1B6an/HKO9IlB/dG5sFH+SCGGtR9zn+uO6O2uQ+Jy48aYJsD7K5oq4ZE6RWxv3JTRDrgR4vRf94wpnsPVQHPnmqfbuhy2t7wXEqWQQG19Hqc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhH2r5Hbo3r/Gql8G3xXzWnV/+gRk8rWCHIHFCtTZmA=;
 b=VQBsxyhXG1NWWdT8WYtEuRocKHAqtmq2p3PRczNk7mzosSloG3RCo/SwnYPNTlu2tl6tyXO1LshSVdzx4N9eAIt1wmPne4neP5CKCRJ18lrLZojJbvsB6MqLiTwHliC8p4z+rV+5cEo4NIOyygypB+x21A3cgkIa/fyUOdpx8z1RsRlq1MWFbHlOX1dUuZ9PVvuRVMQu6ursje0madP4IMLgciMmPomwhx71ZoqlDFyuYFULiRMABA/3MY6LJOq8ckOuQ/tpWd8X0yS3QxuDObLsDm+lOudV/vaC7JhUEXyfMZXH2jFezPZvxHr3V0yXB//KdZIupDyB+QqOF/eJzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhH2r5Hbo3r/Gql8G3xXzWnV/+gRk8rWCHIHFCtTZmA=;
 b=BBPzs65esa8FoYySURU9Axi0twps22yYki9qmNobJ3JpUiJeUpD4WBolNLI/c29cujgvlaCHZLX9kso8dV5Vcj4aycdwPl0tU6mlvtQTjO9qoZ3W3j4JfFbRxN96oyNCWx1V88OfqucvrX0xwfx87m8ht05XC2RBfmRbVFHDDJsMfkn1l49XQswcGygLLDsLhy6HARXh8LE6R39mxyl1Bs1Hq6e2VoncZHPqDB2EQGpajmtZUk7YpRpXmyMlKxLkcsq+gax3yGIpwll2+8BTOe6+FaQ+8jxB39wl3Mc23LGHmRsy8pSGzvaC61c4J4ax/Prx6glwxqgKQqaLNybF8w==
Received: from BN9PR03CA0383.namprd03.prod.outlook.com (2603:10b6:408:f7::28)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Sun, 31 Aug
 2025 08:07:41 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::b2) by BN9PR03CA0383.outlook.office365.com
 (2603:10b6:408:f7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Sun,
 31 Aug 2025 08:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Sun, 31 Aug 2025 08:07:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 01:07:11 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 01:07:10 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 31 Aug 2025 01:07:06 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH 1/3] selftests: drv-net: Fix and clarify TC bandwidth split in devlink_rate_tc_bw.py
Date: Sun, 31 Aug 2025 11:06:39 +0300
Message-ID: <20250831080641.1828455-2-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250831080641.1828455-1-cjubran@nvidia.com>
References: <20250831080641.1828455-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a221243-aa94-42ae-8a0b-08dde8657555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zB8FCmo2K2Ao0gAAKaxadw0EHakyJR55RpBF5WsyMmiVjQOcuDHvDjtKUWbC?=
 =?us-ascii?Q?4g4oYBctbvnKx/RcycNK/3zafOmn6HEENGniyZeRSlxU6WAZuyl4Y/6GgftN?=
 =?us-ascii?Q?WaL/d7UtkFgs8/7AGOysLpNMQoXh3EpjV26NQniXEvRskPWO3K9i0rULazHg?=
 =?us-ascii?Q?2BZ+IyKcOUrzVLIbXNlZZ/Li0YdI+eexk7c22hmTfa+sS/5/vuHsPOYZpbJn?=
 =?us-ascii?Q?gJF3L6084dKAsIgdWIN4Z1TNe0zuW+BIoAYuOr3dvZMnfcvBkGZdYcQ04Gt2?=
 =?us-ascii?Q?fON2wLFQJClBZCIkW8OqNvnNrvh9Ucnj8zM1Y82D/x48vgs9VsJaTDf3R4ph?=
 =?us-ascii?Q?Xew3dnk8AtHzmagiCFcJ1QTUJt+WH9lBU3o0H0GLnT8VeulKMARtPfLmpKpx?=
 =?us-ascii?Q?YQyg0x4M4eFbiSvoRPnc41QKhrFM9SdlvzgJt+KwMBdXs3aY4gpumYrJZeNq?=
 =?us-ascii?Q?tXzBTfANu7GMYwR4vAvgHXYDZKWsOH93vM8GTzpHeyasEubzMejwVT7RKytF?=
 =?us-ascii?Q?UZyNWC7XozEJXfGlvRtonqqlXn8eKuVzkuUG4o8jORQ+Nm57NScHUlx6URkG?=
 =?us-ascii?Q?Qz4Nh4xhmyMQSaF3V0NnSdrmCekE2c8Mb7H0NGQOfPabG0mA7Wg3KIoIM+N0?=
 =?us-ascii?Q?+HqvbJgIPwxIb4hiLjKVaLLztz4co/MJRhrutGLWUV/bOtzHUVatabUEghtq?=
 =?us-ascii?Q?PCgbWId9Z80xeWtHHprEb/QiwVWW3R0SBhf4TTiLuO9aj2Jomce7MmKOfZH5?=
 =?us-ascii?Q?eUH3tr8LIM6VCFq062mApvb1qrJIad/OAEMJa4OkLfJZOz8jmwTgrNzZw0nj?=
 =?us-ascii?Q?kw3h/v0HskrJDiCGhV4vH4CL79I0gINwTtYlWc8phqbwNUT+phPkkTuUCI/a?=
 =?us-ascii?Q?rImS1xE7+q3CFmywMZkSJ+qZQD4SvVk223WVshJ87n+tfL3ok7CNdb2ybxZS?=
 =?us-ascii?Q?Ql27lyvYl2ffAGHuhMzEAQRum+Z+XBe/kYEwlksZJ7nrZFNj/r+Ju64PU1rI?=
 =?us-ascii?Q?Yikq7LnE3sqkn8m6AOw2yaANIk3+u/EniNr2e8v6n9VrN5mE+KuNmMgJ09zU?=
 =?us-ascii?Q?hgehk/RP9qPsGriQpz3MURs+qZLwRXLvtbt59+QAPmE15SyOkk88ijimnRFe?=
 =?us-ascii?Q?JiCY3cm5OJSeilJ1G/NSN9T2M15OvQ9wiXZFv9ddlqcsv8TySVL47Frb/DZb?=
 =?us-ascii?Q?zyrTBOxzEt62x1vJYUcbd41C+Lyp6wXq8V3hZi7V/Ddl0XdtlmUEPVowE4rJ?=
 =?us-ascii?Q?4KqJSj5So74mF8xgWTQt9yqcPlLZVJB+0GQEh4/4jlq1nI0pqFx0GK1YYwb4?=
 =?us-ascii?Q?XuNnC0bZ0bLSuQokCPidFCUnEogxFx3C9MYqhHoipWfLhN2zz9tBTQbQrLyF?=
 =?us-ascii?Q?dMSEfC5yH30/2Y0jGB3EXK+Ez/9CXLwhAR6Ut3L2Ze88ituiYmWLgnIaPLny?=
 =?us-ascii?Q?fiLAcjGT9inqvWZQbCvuwSA6eDmDDXy0DIHelApoxjkoS/8M7v0OjwTE1CDI?=
 =?us-ascii?Q?ms0uHTr/zO8ErxssNgxKZ5HvpEWKGg7SMAiB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 08:07:41.1753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a221243-aa94-42ae-8a0b-08dde8657555
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195

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


