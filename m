Return-Path: <linux-kselftest+bounces-40377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CF7B3D156
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 10:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81E5189CAC5
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 08:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5585824E4C4;
	Sun, 31 Aug 2025 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pcnnpoa1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727E248880;
	Sun, 31 Aug 2025 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756627679; cv=fail; b=KwBiRggwaqumbDrxUFeKLAtcLan+nNCmbq5vXifRpaFe+V6pBh1iWpwDg9qvECzrSoCt4P8wzI5W5JIqRHXShKpT/xLwR02/8eqFcDQpaClAgNnFszCJihOeXFTlCH3XHkeTTuqZl2QXvcQ1dY5cPWjA/XBUXOGpXv/TwuPPQSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756627679; c=relaxed/simple;
	bh=zEJ3JHhdcxuQShcGuyV3o0r2tRO1/JYD1+NnlwHRhlc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGW3VaGAWoPYTdrG9y+5Alk2heI9zJR7FNUIUjqsVSJwEwTZ6xNsJfkMi2N2tu4pyFsldrFdLJzkV/23kPgSBoDagVPlqisGWUoOjD1n39bBOZNVaGERCXseA7XbWOAxgFEooNSt5bFcdh7i9aGMMVKhX9bRV8cYMkOR7nMSxOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pcnnpoa1; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlGc2QAN9HHthzTahHkFbfKeYAXuEE1fH3akin5KTAvyPJybAdfTo5uOX4vNqYwO0kn5jRqq2eUoTwMDP8G1RwOBWtoVzzo9LycNbJn1bpHAj8rM2BTmckviw2rVNoRV5sjOCyfyeZ5gFaMygvBVzRvNSD3RTvAWd96YlC1aOPjaQXxeIgDmkrthzqPYR1af9s4k6hOtqkEnT8eKp6J6j4tykViAdT9QOI4bWa4CspCdz6YcJyUbE28I5xZ6ALQUoxXbGj7Ev6uYiX4KaSqDtj1yjEbPztfoGNZdpPnkrGwh4o0Q9z8f5CZ6nUcwEYY1vtBPZtk2AlwkPXsnLUwIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1swz+pzGnE/jiOIg4m/DnGcNreJD88amwOC2eX85r5c=;
 b=OJR27ywebi+1ilZ9np6ATtIMm6Q5slatApxoWBgmux+xVZm646Kst2+0vDqMwvJDX3S+Bzc0B1oS4pmgclQH9YopHJ44JrSKkiDCcg7ArDCFiCN3rSBNCb05lBuYqNVDO9FxySEHXWs90134lc8cP8vwEvStJNr9sbw8624AGgmCog+egNzR40SUh4uB2ut1KvFrsBb4Iqx7kYdbjX5kyD2NFIoqNaw08y8yjJJz/201RTBnzrn/bkRWBcBMqiBut4Q0ll5W+XCp4ZEA24LepJ0SknhSTgpArpMibdi6AqX/XxFxLXKha6OcTaPOH59GDiNsGW9DAjNJr6lRdoR+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1swz+pzGnE/jiOIg4m/DnGcNreJD88amwOC2eX85r5c=;
 b=Pcnnpoa12Zoud7JBmch9MjrzNI4iWOzaNARTviLzW81ktgO3wPotMp0EgJWnSXD8z3f+/4nkpfUFWLv7Od5q55VgJN4jrUwEVWWxWgmj3Qws0ao21YZQiNMP5GyXpvtng6geMCQAWqkhijfPikqNWCYpcREOFvGzXkH9dZDqUXW6Ws6E0E117MyVX0bx2Durh6NJRbxG9w3aAOWcqCew4wf5QyoGtTyyRIG/3UuSiJhZS4r0BpnP6wnM6AWUf9KSm5N1RnYaRnqSKTkQRUCyHdgw76495ch1wfhv4IIPguVIahaeymhRYOHqiz93Hqmj5SchaNuBEQdO/Lt1mYLLkQ==
Received: from BN0PR02CA0048.namprd02.prod.outlook.com (2603:10b6:408:e5::23)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Sun, 31 Aug
 2025 08:07:51 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::91) by BN0PR02CA0048.outlook.office365.com
 (2603:10b6:408:e5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.27 via Frontend Transport; Sun,
 31 Aug 2025 08:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Sun, 31 Aug 2025 08:07:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 01:07:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 01:07:21 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 31 Aug 2025 01:07:17 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH 3/3] selftests: drv-net: Relax total BW check in devlink_rate_tc_bw.py
Date: Sun, 31 Aug 2025 11:06:41 +0300
Message-ID: <20250831080641.1828455-4-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: e3465e6a-06a1-4c3c-9966-08dde8657b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5VxCpqCB15mtcAzGGCGEnkdR0jcRAoEsLk3clYEupHHynBMrb+E7PfTQzTJf?=
 =?us-ascii?Q?4M/XUQ76qL2bJ8As3pgome9AkYhHHCt21Q0BwL9wB+dWSS1bNeNAe4aL/bjZ?=
 =?us-ascii?Q?8GZtZoMHu0kMF4wopj3H3UtAjLQZtXLDYCcWervkEqn0NkG86xQR8X3ejHPN?=
 =?us-ascii?Q?XD5bBgAW17Nrv3pTc0dxotSWOnCEVcBjCTcWFP7tTHw9/mqBIGdC9ns24V8+?=
 =?us-ascii?Q?XwB3X7+TIDwwJKPEVllMSRMdhxOjBpEGk+jIWyeQs0sE7qH4wMi+7bfFbT16?=
 =?us-ascii?Q?DenS7wSJ9P/Hd/Urhf0MYXPZJfbLW/xa0cT+W9r1CfR3ndn+k24ds6gpHVv6?=
 =?us-ascii?Q?Z4/wx8lJ16ob8JqJXu16UEl5gDioSibyTXnYeztrVIzj1VEPE2VdKMUFE3qO?=
 =?us-ascii?Q?xOGWduARFgjszAwX2oQDpz6Ka7Qgu4UGnZcF9C0N2wUyOoTDih42RUVtxiIR?=
 =?us-ascii?Q?jDE+v5KVSDo1uI4wT7e4BBgBIivRO53NrD+/4brvpb2hi249zR1xFbx6WxVD?=
 =?us-ascii?Q?Ak7ZOr9aB2rFwejTG0bM8SLFROSUgyb8DduAAVRQsaMhJYflt6fWCmcLcy7k?=
 =?us-ascii?Q?8taOezZFkbCUIVQceu/ykHzjnmF4OmioPZhkbbQI3DVGOUlQ0FOJDxKp7MTO?=
 =?us-ascii?Q?HFtBNlze+G8uEc74dcL1NEPBYiz4Cn595VfyqcgDyqYE9xtTRngbnDdRicva?=
 =?us-ascii?Q?YPK1HDOPe67f7HATVJNhm0tjEzdCn0GUHYaXJhiNpPp1d2cZb+SbBfQdFfKV?=
 =?us-ascii?Q?FC75peAG04AljXwJy0R4GFi9xjojjuvE9/1PcaemYrZQvAhtpS5e49AjmnZy?=
 =?us-ascii?Q?TtCuJ8A+lkprEZeDMQfmHA8wKOKOIIZM7a/wJJLXGGfhhb0E1wUQQlGsBdaq?=
 =?us-ascii?Q?snaM6tYUmGhIRfHUesSYXdnRqbP+szO+hrdv6Ab0S4x3PWAeQyW8CAZ8VGPo?=
 =?us-ascii?Q?Uc1sNK7LUNsP4OV5VAv2m2St3RobNsURdT0N3NPEQrZdoQIA8GWJ42xuaB30?=
 =?us-ascii?Q?kaIn+WlyMNRvU/hFeTfnEyw5LBe61Q+xFiOJKyNGvXC9Wc/WWeloF/q8euyE?=
 =?us-ascii?Q?7arsRc/DeyQqu4nwSUBaod2LnjbDtVT9Zvjnq986RCFVNdQjB9vwu6ukV3LH?=
 =?us-ascii?Q?xXBP6zI0MTwKN3NGZ/sI2Ktcw3lXqgYalVTFhSutGNForzzq5KxoB6umQXik?=
 =?us-ascii?Q?7xCuitKyunUDgGQe4hETIRl2eDRwZvpVTMam0mtC715zFy1VQWoyuvCF4j/1?=
 =?us-ascii?Q?bZk84yPpuW+ey1XnCTn7zgSOru/qTXlDmnmQ9C3SLmdtQtZ8B7cHWDqLdyeZ?=
 =?us-ascii?Q?jW0WcuFb0bO7FXiZTe6amlvbrxoTKO+Zhi3tp3jYXlbd10dzCuaC8BpaIPSA?=
 =?us-ascii?Q?y4SiSptkziarssd5Iw6GtTpHnEYlFdgYHXdPA8/zMtvfDSmlTvTOC+FuUfVF?=
 =?us-ascii?Q?Ux0oMaSAQTduR3y1CrPXk/k/vG46KCH7LnTgnC3uTSfeiOYS4PLVKkyA8RKJ?=
 =?us-ascii?Q?+G9JhNXT1rbNeYiKjCD5P98FhTYGfxqFKSPs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 08:07:50.7219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3465e6a-06a1-4c3c-9966-08dde8657b18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816

This test is meant to check TC bandwidth distribution, not the tx_max
of the VF. The total bandwidth check is only there to make sure that FW
tokens limit traffic, because the per-TC share is only meaningful when
the link is fully saturated.

Because the measured total is the sum of two iperf3 streams that do not
always start or stop at the same time, using a strict 1 Gbps target
caused random failures. This change adds a tolerance parameter to
BandwidthValidator, keeps per-TC checks tight at +-12%, and relaxes the
total bandwidth check to +-25% around 1 Gbps.

This avoids false failures while still confirming that the TC share
validation is meaningful.

Fixes: 23ca32e4ead4 ("selftests: drv-net: Add test for devlink-rate traffic class bandwidth distribution")
Tested-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
---
 .../selftests/drivers/net/hw/devlink_rate_tc_bw.py        | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
index abc20bc4a34a..1713ca11f845 100755
--- a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
+++ b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
@@ -72,8 +72,8 @@ class BandwidthValidator:
     relative to the overall total.
     """
 
-    def __init__(self, shares):
-        self.tolerance_percent = 12
+    def __init__(self, shares, tolerance):
+        self.tolerance_percent = tolerance
         self.expected_total = sum(shares.values())
         self.bounds = {}
 
@@ -438,8 +438,8 @@ def main() -> None:
             raise KsftSkipEx("Could not get PCI address of the interface")
         cfg.require_cmd("iperf3", local=True, remote=True)
 
-        cfg.traffic_bw_validator = BandwidthValidator({"total": 1})
-        cfg.tc_bw_validator = BandwidthValidator({"tc3": 20, "tc4": 80})
+        cfg.traffic_bw_validator = BandwidthValidator({"total": 1}, 25)
+        cfg.tc_bw_validator = BandwidthValidator({"tc3": 20, "tc4": 80}, 12)
 
         cases = [test_no_tc_mapping_bandwidth, test_tc_mapping_bandwidth]
 
-- 
2.38.1


