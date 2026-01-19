Return-Path: <linux-kselftest+bounces-49340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF5D3A2A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 10:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBB0430671FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 09:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39195352F8C;
	Mon, 19 Jan 2026 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tz1HIGz9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D297829BD95;
	Mon, 19 Jan 2026 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814004; cv=fail; b=nzrimfjA1mAYi1k5IZrfTcJjtbc2Kipp3SqI4Ort1Uv0RNXYKslOqlglX5HLFLv0dy6pol/pqugtlFn5r+R8krjBg2w5yg9I3Kb6zgpbEBvGN0Jv4CPgCl+AVch4L+BHKEK2Po1q5Uw+Q10ZotstOPHM7QcvwzuY1s2fS+x2jTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814004; c=relaxed/simple;
	bh=UeTlN08C3PeNg1Hg8QxM+JGhIYFM3UEUKMIiIF/lNHg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ga4ajv8fVvlRMwa8bLrHoEUloGgbds8TtO3aC2D0cu2L08oJXyvLhHWD+N0T+4RK4IXfitJlTABIvu8ps/ogL4GyVO5yiSI6jK3LBhEzejxyH6Ejla9GACH/LhObpr3bhuezMj+phgYYwDWlPhe+mowbs6JaQO5U1zdDpuGUh1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tz1HIGz9; arc=fail smtp.client-ip=40.93.198.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psGGlsmzem+6TwWmP+6A2qMj2l932/u7gPcgnDEoegHIRUrBdoIepKCDWLZv45jNuV7GWmkyttTt64lHqykc9u8fHTsf4G3js17oX68TLNW1rcm6TY1E65vKmP4t1h/iuiS3y3h6Js6lPHQqwGF5I5ob2WWnkklOcVnYv37QTTadthtt52cvT+qrr4EFelpvrG0KqWvhfYq63LQ4je894yW+iL5MW+nDeL7Ef3bDHCfAAwRvyi+QQixdf/EK7o2Bn5xUEB1VQksGMcilF/yVuRNiUWiURM98Wq8tbnSVuS9Vuu7LkEgaspoTMzOl0DgekHyifrnvquQYZJp9cQTuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TB8N2uB1IsjoFk9C4EZMURhVO8+WqkLUWpkc8wqEZRY=;
 b=idcW1cahtSS2FOVd/1k3ZMBNLtkxo9NujP8jCUUnEwcHDW/0OcDgAVX2njwRD5k2a6+YNzpLBOjZTdHjMovTJYmjc849qKPhP4ts2NyUjrXoyT88hC4H+CzaqpmVVSJW+lP4rzpKGOHNQ4Qk18HNykk0nvoKsimZVS0Doa026w/pSU20m8XjsJAiEheg5NmwPTi9zr/6543div6/HyVcuUrNRtflJYX7C0qe/6nTlVMmibQiY3eT/3DFqOw25cItLvA/DqWONRcduqwRD08GiocIOa3wdbKq0QJtpPSwqdF2bAVerNGKNNS47LvmdWlu8+EVnxC6BwfnMFZ90DtUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TB8N2uB1IsjoFk9C4EZMURhVO8+WqkLUWpkc8wqEZRY=;
 b=tz1HIGz9uYJOQNpDm6qrhwZmCTlzdjnWOikglmv4RxW73NM4rXG8yoT/YIIA21o02zhplTVGjkNqYNLn1XDHlYNE2tFCvKYpdNp/HftUpffx1jytNCQDZJMt2FGyo+dJSJFX0NsMxUqAWcrqyBgXEOYP3a2BWQdo0JX8R503ZjeFAaX11Q0Nab5Ye644vCD41SWCMJFlxQyS8j8mFwE7OxHeGa1wr8e7MhWwquwfqa1nU1vnWjD8dOc+UZVy0eRo6YB02VMvmQsqfFDHHQ/dLrFmsZw2WRL/cwBZvVQXXYcUgEV1ch/oCJnegaMZJNp7o+JilYH8990927l90Zv+iQ==
Received: from BN0PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:ea::9)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 09:13:17 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:ea:cafe::15) by BN0PR04CA0064.outlook.office365.com
 (2603:10b6:408:ea::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 09:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 09:13:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 01:13:00 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 01:13:00 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 19
 Jan 2026 01:12:56 -0800
From: Nimrod Oren <noren@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Joe Damato <joe@dama.to>, Willem de Bruijn
	<willemb@google.com>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Nimrod Oren <noren@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net] selftests: drv-net: fix skip for unsupported devices
Date: Mon, 19 Jan 2026 11:13:03 +0200
Message-ID: <20260119091303.3524210-1-noren@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9619e3-55ef-4a38-2515-08de573afade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SNbfjNZlDzYni4JQIQ3oViF2+EI7DxV+ANUB5CKnC7sqi52s/8eARLYitRd1?=
 =?us-ascii?Q?IsVSNmX4joV8TVSONNJYITHFSMeavD6tGVJnFxYPN7R9uzPc+hlNgTHTlt2Q?=
 =?us-ascii?Q?bxdGqHUFj5BDX0XiXJGiGS1Npeo77SMqHKEC2WaRlt/4SIUsEUJNiAtb35gl?=
 =?us-ascii?Q?Io7sn0iqEFEaCcB6DPE+7J/kYUmNvqHjR1qBYfZkAsZblmWq8DfM8bP/DPCL?=
 =?us-ascii?Q?gWkTUXrSV/fDdKiMvgt21Go3AB35VX/harzuUJcpXObwF6GsYvUi6MSryW1k?=
 =?us-ascii?Q?HFVIdgeX1SloKeEX9eXbP8moCLAIobKeeqB/p7OfBa+aUY5XFNwHFA8MqW7k?=
 =?us-ascii?Q?pf4ZXjoHVTh64T3kYf1P4wC5SP3JMAbSvraNR6M42FtIoeZtCeRfiKSN3M0Z?=
 =?us-ascii?Q?KVJ6PD6k5tpfrZfy3knqCixWulR3qFA+hVWYnu0zXHtNLcDqA9l1A7Titdyu?=
 =?us-ascii?Q?hdtA3CM0MZU9/wOdAhLU25+msHsIMW7spcQOciooMllQZEfSNjb3yFoUST01?=
 =?us-ascii?Q?6ccKygiOX99kph2hvY7+zNkFrHBMf5M9+lsnwb3X2B3CJh8nyvdUMz8b+MgR?=
 =?us-ascii?Q?7ZZ879YvMs9w0wRwkLkM3W4jCyL7W5X6D4+rCQ/MI45T68O/Sg97Xt+Cu37r?=
 =?us-ascii?Q?4pUOLdMeI4I6BGmMGx8cNpUHXavqpaD+RDSoPHukG7Rga5Ho52pM+TNRkftV?=
 =?us-ascii?Q?J0B06ntOf4V/gm/kO1UEcqjW/unDy0xPyJWzpm3UyCGg2LZXGXNOGxcLGRXS?=
 =?us-ascii?Q?JaAh8l/QVOezm58SMPso9sconBWdsoJisdTbMwPqyY9J9neiaUM3UzwYKF6y?=
 =?us-ascii?Q?BQl6SD+tcILh/5rn/42z6gyBldGur5iFJrt4xhTnOQgQMePNyp7niIIEK0t+?=
 =?us-ascii?Q?aTpNpRzZT+CFLI/aI7o2+hejxYK7/5MjYjD568nUDJfIcN3zreo3TYcz5twj?=
 =?us-ascii?Q?UqhgKYmkkXdseWWQTL9bmVEOBVVE5goGC+VO3jWJznT4rRaS/FHVPVlzFMTH?=
 =?us-ascii?Q?Q6anoEGzC6Qew8/uZH+SdxLvuWbMhnqWC5uL7U11CKqj9yUj9KwyiVm7BbS4?=
 =?us-ascii?Q?2iAy0wdRyQuqU/owDJcVlhrcgkaJmBV+1nK/QevXoMLVmYvyBDVPetzNBjVC?=
 =?us-ascii?Q?WyHGRUU5WgakjUgrb47pdOwqFCCKRPePh4wyNHLe4sYMrbqDB/2T5VkKOlJs?=
 =?us-ascii?Q?+5d/WQOE1EHn6RcKiQzrmvjga2Fr+3W9Ma6DepkVpFODLnZa7nB5+sTBYkpC?=
 =?us-ascii?Q?ominurP7YEFQNLkKztKtuQvKTK8H/vRO2m/viLSbEIObXVB3F/gJxdZvKQLO?=
 =?us-ascii?Q?/OUGRg8dVv3fz7rq1CEjyrQaZ00wNx/QjBggY22l79YMLujwZieB4ef/cveO?=
 =?us-ascii?Q?toY6QHMBR8F+9zefqgre+wpTvCRXaoVhTb1vXwRSFdyf//LZzc1CcBQMof2N?=
 =?us-ascii?Q?DwuSYFOTIxZJ0mD3xJEtJLEFx5PbBBOI9xV/9i3U5Ii0Q/IuSkJX5zcy09dF?=
 =?us-ascii?Q?9lj+M3knki3TySab8AGQ6xr3ufnPbZIIL17HEiHmu/7FRj0D90803k9IbUcY?=
 =?us-ascii?Q?gWHV9KhBhrPbSFCT6FhRuYMQvyL9q2Zhn4gUlzLlyr+rX9L0LY55xWR7Py6j?=
 =?us-ascii?Q?NFPpMHALr6/y9G6KIk+AgFwwLP0OfwOXfgUPeOWl9xXSYZylCcGbZdbP9Aa4?=
 =?us-ascii?Q?BpwQJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:13:15.9963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9619e3-55ef-4a38-2515-08de573afade
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350

The test_rss_flow_label_6only test case fails instead of skipping on
devices that don't support IPv6 flow label hashing.
While test_rss_flow_label properly checks for flow label support and
raises KsftSkipEx, test_rss_flow_label_6only was missing this check.

Fixes: 26dbe030ff08 ("selftests: drv-net: add test for RSS on flow label")
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Nimrod Oren <noren@nvidia.com>
---
 .../selftests/drivers/net/hw/rss_flow_label.py        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_flow_label.py b/tools/testing/selftests/drivers/net/hw/rss_flow_label.py
index 6fa95fe27c47..7dc80070884a 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_flow_label.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_flow_label.py
@@ -145,9 +145,14 @@ def test_rss_flow_label_6only(cfg):
 
     # Try to enable Flow Labels and check again, in case it leaks thru
     initial = _ethtool_get_cfg(cfg, "udp6")
-    changed = initial.replace("l", "") if "l" in initial else initial + "l"
-
-    cmd(f"ethtool -N {cfg.ifname} rx-flow-hash udp6 {changed}")
+    no_lbl = initial.replace("l", "")
+    if "l" not in initial:
+        try:
+            cmd(f"ethtool -N {cfg.ifname} rx-flow-hash udp6 l{no_lbl}")
+        except CmdExitFailure as exc:
+            raise KsftSkipEx("Device doesn't support Flow Label for UDP6") from exc
+    else:
+        cmd(f"ethtool -N {cfg.ifname} rx-flow-hash udp6 {no_lbl}")
     restore = defer(cmd, f"ethtool -N {cfg.ifname} rx-flow-hash udp6 {initial}")
 
     _check_v4_flow_types(cfg)
-- 
2.45.0


