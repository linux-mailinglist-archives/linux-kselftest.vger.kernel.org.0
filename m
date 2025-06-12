Return-Path: <linux-kselftest+bounces-34796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 442DCAD68D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 09:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A46E1BC3E3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 07:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E7A21FF2B;
	Thu, 12 Jun 2025 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ry5PTKOr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C251DAC95;
	Thu, 12 Jun 2025 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712808; cv=fail; b=Vb10l/ZSG8r5EBu2IyNNuKmoRmZ85OLwB/aLvN4S+yfbMmjUrL5M38juilUr7VeLThBhqjFJoZDv28fkCWWvu7ZEpth6QHIusEjdDVNSV99oceWasbuR5a4za7WJE2bYwK6hnHaL5+jGVCl8JlmWD+u6rIC4w2e9EXOYjwTaXoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712808; c=relaxed/simple;
	bh=GspBPNFcM4jieS7oHtzWu2PrAZ7nv8ftpwrQ+2NKzTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhE1mIV7cffZ6gyVIT7RiiRHw3uMMDFCBik/mGAt1rrgjz2rJXVtDsjl4pQs5TTQO7Nrgm8zRYGKNWd/KdoFRrLUem5su+weVB4WU10p33/TLwpTynmX6kqZIV9Qf1DmRfAAcZS9BH7O6QzU39o0mHKsdeYC9V6NzOsY5SpmO5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ry5PTKOr; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjD+Ef2UgZyxlkrZKroXBDvIB76lD7AoqEcXCp8MdUwdS7OD4D/w7+KVOX5x9CvHDgbPRmJASsljf4pVgKB8SmKaJo/cxUgIRciTXsSuvR4wwE2NjEYJTw7xKl37oOxTt7bGbfM+mLE37LFKjIb2SmoTGlqUJQTcc7CQEMVDzsU84Qxm0PkAnVCBTv2I+otnbj/m25ZfF0VNkpcz40smc7oyNRvvlHZid7vnh4DSEyLKoc9t/rZqr7HRx2R6fuWlKZk32S9ae9ocqAKb8VXylkQOvgkMa0jYLvpmRhPgUIKZvwNcdqZxN5I0PblyrYcRB57Vfom8tFH16dgxaLnttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mW7hqKxxV+UKz6XZ8jUrYYx4A0T/LmkrZ4gttM3UBI=;
 b=FFsU+Ieer+PEWBprRIjOdMT9ReQDt1/w5reARvMbeuhdqTJW46Fgkywr0a1irGM34cREr8XQxPdYQ9eGM1aYmFeT6DkH5iHYT250YyHhVv2Qd3NrBI+Qg4pGzac0POOB9HVw/nwsscaZbyJxWPW5C6BXZNNCidX8+2LMN5Zjej+3RJ4DC7R66h4PUWZlUbWh6LUY3uLeDywXNWpTxVH4yugD5wDv0Hxdgc++z0Ysz51xHJxxw+EAQ7eJXH9brQolbjTCHW2/V0rfb7yO7oCC1sJN9ZosodUQmcZZ+nyiklhNlYWK47zZybErOq8PxEQJXZkzX4MGtZzrp9ABmpkhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mW7hqKxxV+UKz6XZ8jUrYYx4A0T/LmkrZ4gttM3UBI=;
 b=Ry5PTKOrNk4zdW2vGY1G8vIibkIYERZqnGPSFmhoZI0v2KiXJQI0INp82aefT+X7LJBMXYfM01qvz/jD05I9JK3SIUM1+yrECMjqljxCUjVb6bJz+G4ApmNlSgiGr5Ai+IWPM8gUhmxCk5iyQ9cgy+6jKeIW5niqTciV9g5aIc+y9Iug+aHgyJOes8Y6ac//ZIYp2QHaC9aM8IxaYEAiykTbs3iKL414eXzN3SkfLKVZmwegrTSBpSJjmEhjSn002qPrkku1WtZUjxj0Eod9eVyerx12UidMyS+y1OPbJoQwGEiBkrIzlT5KEifXWXQvKxB+kZkxI3FEqyGK8N713w==
Received: from DM6PR18CA0027.namprd18.prod.outlook.com (2603:10b6:5:15b::40)
 by CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Thu, 12 Jun
 2025 07:20:00 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::dc) by DM6PR18CA0027.outlook.office365.com
 (2603:10b6:5:15b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Thu,
 12 Jun 2025 07:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 07:19:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 00:19:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 12 Jun 2025 00:19:45 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 12 Jun 2025 00:19:42 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net v3 2/2] selftests: drv-net: rss_ctx: Add test for ntuple rules targeting default RSS context
Date: Thu, 12 Jun 2025 10:19:58 +0300
Message-ID: <20250612071958.1696361-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250612071958.1696361-1-gal@nvidia.com>
References: <20250612071958.1696361-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH2PR12MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: 495eacef-9ee6-4e5b-bf84-08dda9818a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pb99IUWvDVxurN0ydX9bn9RGswoenORLcEa1zJdWZFrMuZe3P6q0HctUqdb7?=
 =?us-ascii?Q?bomHgQYnzdwRoOfsWWjvT9yWxSxFIas7b1VGZAxvbaLxLq77/8EjgRHjKsvm?=
 =?us-ascii?Q?F2RsvnJ3BaqALvCpwvAFJdCMKYBX49RTBRPVo5cemNlsdYF7oM9evllVpFAR?=
 =?us-ascii?Q?5V7TQQ+5+mHatkawV6o3KGB5SHAuKTbXS4kos4FV7mipomxG6fcqpZA29w1E?=
 =?us-ascii?Q?mF63p66L+X9OreViYb1eoSiw+GwfdYOPOOkG35zGwJaur78HwTuchrIlNhOL?=
 =?us-ascii?Q?urqxW9jj1Xcb7hfNsNewoA4mD5lrh/6f+xN3UaLayL+gk6k92dj+3PSDN6q3?=
 =?us-ascii?Q?4zbPMVMl/EqTusAFH4hQhwIZNe8tJqCtLHVQdEnLHZYpHTC+iYB67DAa5V/N?=
 =?us-ascii?Q?3Jd0uiJqY/qQ+fgQlQOwYyvV1rPxGTWxmhAtAzkdcoCLmVEMcqvSxacgDfKa?=
 =?us-ascii?Q?nAKTD/d+KdN3CtFVOLAV/Zqo466At0DanLpNXg6iPULX8K8fAt+7YbvM7sfk?=
 =?us-ascii?Q?hkdEsXPZRTGbFdz/HFA/GcPWfXaLWpq9PPITOeEoSO4YX3MoblY/3dHeVs+i?=
 =?us-ascii?Q?DaRwRPN6wVVhWazJKHQ924OhrFGQPhP3PlZlqC3Q3oG0gKurd9+gg+p8wsjQ?=
 =?us-ascii?Q?/O3Oj7o46OfN9NIl8kAvpRpV0Bn+54yKUr57JRnAxM9j3OlWJJAIGr9GjxNL?=
 =?us-ascii?Q?/+stMAOFUSjB2mvd8trrjmZeEWQUWXksl7jnryM4DclNNg5nMmbpGZhNBqpw?=
 =?us-ascii?Q?enjpK8i4Oxk+YkI2e286tqVmshOuYPQKDwZh73de0LHvQjv1jeYQIAoWy40G?=
 =?us-ascii?Q?aNkJu490xU6y+KkITa+emjh7bpnxIrcdkV0WGx4xTmOFbTL8d5Nl7y0LgUuc?=
 =?us-ascii?Q?z0vf6jd3WCcc1lStUeFOxNnCnLeEJXqZswBBIcTGPwpJZrTWUz/CZzZcYUmX?=
 =?us-ascii?Q?/eIpMwtn/I4MwH2GJ7hIcqjhGVvCJNPL657f3zi3msfR0VDkx3feVwPLDeSa?=
 =?us-ascii?Q?PAjqOQcHGjBWhdmwB1R3m6G2c9463Bg2FxMD/OglW3ayfA+0shILRjd0m9dH?=
 =?us-ascii?Q?EX6LoypNmomtlKxrPATPZEjI4KQ0yWs5lpJxKZZN8kDf1mi4MKOcqy8LC/Fh?=
 =?us-ascii?Q?+Md1d1pRbaMW0BFqZyVrp4G2kG6AaxVuBRdyd6N56EEScXMXB+S1PviRxEXv?=
 =?us-ascii?Q?wZtGH9byWPIrzU4oq28zWxZFCpZ+2XnXaSqYsaWYVCaMkg5BWmH5Tau0WweJ?=
 =?us-ascii?Q?/c+QNVK8i+O4bYqZ4kCb/9Itf0VYd/rTbexVCuWvSx27uLpUEqO9j7wW5P8e?=
 =?us-ascii?Q?Oj731nGiJaH91YJV+n3jdpRg7lxFPlmpZd7AV9nLY1cm3tvNwip2tTYHbtfz?=
 =?us-ascii?Q?3e+txnXgOm1PE+7VSjOxr8uRSjNjbAE0PzpMBSO/YA9Ao4nwP7/ETsoKh62i?=
 =?us-ascii?Q?QYN4vxPJoOeSzr+BgxurODcKuluOtxJ4ZIQ9HWzwV5Ywg09dvO3PV5nxeK7W?=
 =?us-ascii?Q?laNppRBUadI8KF/Y4YaZCwpyMslh/DxeV1ae?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 07:19:59.5717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495eacef-9ee6-4e5b-bf84-08dda9818a90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543

Add test_rss_default_context_rule() to verify that ntuple rules can
correctly direct traffic to the default RSS context (context 0).

The test creates two ntuple rules with explicit location priorities:
- A high-priority rule (loc 0) directing specific port traffic to
  context 0.
- A low-priority rule (loc 1) directing all other TCP traffic to context
  1.

This validates that:
1. Rules targeting the default context function properly.
2. Traffic steering works as expected when mixing default and
   additional RSS contexts.

The test was written by AI, and reviewed by humans.

Cc: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 59 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index ca60ae325c22..7bb552f8b182 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -747,6 +747,62 @@ def test_rss_ntuple_addition(cfg):
                                                           'noise' : (0,) })
 
 
+def test_rss_default_context_rule(cfg):
+    """
+    Allocate a port, direct this port to context 0, then create a new RSS
+    context and steer all TCP traffic to it (context 1).  Verify that:
+      * Traffic to the specific port continues to use queues of the main
+        context (0/1).
+      * Traffic to any other TCP port is redirected to the new context
+        (queues 2/3).
+    """
+
+    require_ntuple(cfg)
+
+    queue_cnt = len(_get_rx_cnts(cfg))
+    if queue_cnt < 4:
+        try:
+            ksft_pr(f"Increasing queue count {queue_cnt} -> 4")
+            ethtool(f"-L {cfg.ifname} combined 4")
+            defer(ethtool, f"-L {cfg.ifname} combined {queue_cnt}")
+        except Exception as exc:
+            raise KsftSkipEx("Not enough queues for the test") from exc
+
+    # Use queues 0 and 1 for the main context
+    ethtool(f"-X {cfg.ifname} equal 2")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    # Create a new RSS context that uses queues 2 and 3
+    ctx_id = ethtool_create(cfg, "-X", "context new start 2 equal 2")
+    defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
+
+    # Generic low-priority rule: redirect all TCP traffic to the new context.
+    # Give it an explicit higher location number (lower priority).
+    flow_generic = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} context {ctx_id} loc 1"
+    ethtool(f"-N {cfg.ifname} {flow_generic}")
+    defer(ethtool, f"-N {cfg.ifname} delete 1")
+
+    # Specific high-priority rule for a random port that should stay on context 0.
+    # Assign loc 0 so it is evaluated before the generic rule.
+    port_main = rand_port()
+    flow_main = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port_main} context 0 loc 0"
+    ethtool(f"-N {cfg.ifname} {flow_main}")
+    defer(ethtool, f"-N {cfg.ifname} delete 0")
+
+    _ntuple_rule_check(cfg, 1, ctx_id)
+
+    # Verify that traffic matching the specific rule still goes to queues 0/1
+    _send_traffic_check(cfg, port_main, "context 0",
+                        { 'target': (0, 1),
+                          'empty' : (2, 3) })
+
+    # And that traffic for any other port is steered to the new context
+    port_other = rand_port()
+    _send_traffic_check(cfg, port_other, f"context {ctx_id}",
+                        { 'target': (2, 3),
+                          'noise' : (0, 1) })
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         cfg.context_cnt = None
@@ -760,7 +816,8 @@ def main() -> None:
                   test_rss_context_overlap, test_rss_context_overlap2,
                   test_rss_context_out_of_order, test_rss_context4_create_with_cfg,
                   test_flow_add_context_missing,
-                  test_delete_rss_context_busy, test_rss_ntuple_addition],
+                  test_delete_rss_context_busy, test_rss_ntuple_addition,
+                  test_rss_default_context_rule],
                  args=(cfg, ))
     ksft_exit()
 
-- 
2.40.1


