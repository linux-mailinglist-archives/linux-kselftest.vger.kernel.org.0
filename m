Return-Path: <linux-kselftest+bounces-34464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAB1AD1CD0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 14:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7853188B919
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 12:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CF9253F2A;
	Mon,  9 Jun 2025 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e50ypU98"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D311AA782;
	Mon,  9 Jun 2025 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749470578; cv=fail; b=NS2j2dUtPMLZXPwkfLglujr8LOonWFosw6rlaG3C8vZKQoJ9d81IH8dmpz4CqEqHYoju+2lQWv4m7ZG9g9nJulCWNtwYjsjIkECbx+18UeC8H90u5zC3/rjrHM8XC5cyuKp3hI1KZJ60PR5IF3hlGmbRVONhjzr8h7Rvnl/XIeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749470578; c=relaxed/simple;
	bh=pk+DPlsBSyNDH4EY4bzXGjfLK++65aVAuoCBidSuuBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtP+BoECtYla8wy/js6ki5bx7bCCIuRXyVRBbDZ9GzVSJtzuh4QbqRDyp0G5gQLfuDnfJ916GzocD0RXNG00IbIzvgEmmInw9LkpNydWFeqebE7tgW2mkHM9JJKd8O8Qnq9Sl13HiQAZAaU1bw2Qdxz5Cunqw5WO5oTfKRH9NOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e50ypU98; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNWuXB3zdtdlbhrVqLAn79lCvS3E2N8Lk4oJiAl3wy3+/pn+xfh/Tk7AO8AOBXgx6aA7kXSIgT44Et+3cSBU+Ht2xnJMQUSeTaj4uft6seHaC3sbCthVyWDnOXW6yab9IHCVkDRyQsS2+hJ9oUe444ihUOKcSCmXZEp8sOo6z4ooJ1EI6Sph50v12wJ2R3ke6GDw+KPKr3TuIEQ3sxmexrH5gDpb3k0nIkpioFLE9QXXGCAvG8c2AgGkv5+VrmEj4fVKBIb2qu6qpR5JgTecjWTlNKlvY+4+qxKUYwB/m9fO4nF6ByQEYKDxivWFdmXpuaDAjjGQKhWneujE+OpRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECbrWh4QaDlKkuwAJf+SRDC152gWAYNQtFcM70b80AU=;
 b=b+hPE8fD0qNfHcNnOVWKb+EwWwldBrbP0Z2hbPSjAF9j8Ztm/5UMqa+0Uv4W9Eg5mJaT/N95wpXo7lEznvmrzQkk+1spP4EpMN1sOB+Wq//i38Hv0rJ1wYXnZzotYb7JljXAs3mL/sb6QOE/yQqsG+EiWo+RX/kPfM+RGfrdl9ZMyERrow6WFE2OaJVM2FZLM9F1iifWYEBCB1usZs8TsGAuUI+Yaf69l+VIFV8XqbKje2yXGkRxBVj1nodV/5FlHqk06WheRIIMjBvEaRbObJ0T8+5sP2A3OE/0IKj5R5iXt6XmWjFl9aPGBOM78Ub3GktVXlb3IVsJ3oduB6T03w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECbrWh4QaDlKkuwAJf+SRDC152gWAYNQtFcM70b80AU=;
 b=e50ypU9801IiXYcNF/mPa6QDIuu3/2jKfqIkwM1XlAnykz6sA1Nz0qVL7qPC5srtneTfmktYlG5nWddXL4Q+IPTXfmy2et/NBsiygrJziDtwv0H5965+YGFf09n9+PiTPNNcxBGLVjObNcOKJP/14ghdaPqYnozNIyf6/Cq4Uik/kqFxK4fjzB92Wl43WUspRx5R3Y5hKpmSnnBfPumYIgeu37T42/gKCzVfQVn1Hd3ktdb/tGEHIUZlLxd3tmgX9Lx1mkW/EBj+Vg5S1eBGjZbYtcINc4OBI5CBFyDsuq+688ZqIeAmZNAH7qRNrj75PjvRgAelQnvYXVsabHiEvA==
Received: from DS7PR05CA0052.namprd05.prod.outlook.com (2603:10b6:8:2f::30) by
 BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 12:02:53 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::6) by DS7PR05CA0052.outlook.office365.com
 (2603:10b6:8:2f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Mon, 9
 Jun 2025 12:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 12:02:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 05:02:40 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 05:02:40 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 05:02:36 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net v2 2/2] selftests: drv-net: rss_ctx: Add test for ntuple rules targeting default RSS context
Date: Mon, 9 Jun 2025 15:02:50 +0300
Message-ID: <20250609120250.1630125-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250609120250.1630125-1-gal@nvidia.com>
References: <20250609120250.1630125-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: ae81ed1d-b50d-4e3f-19fd-08dda74d901c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MjfDbJKddUpYSmlz3n66JHXZMb9DbcW1PhqwCF3lcgZt2uA61OJyVQpQzhxK?=
 =?us-ascii?Q?4yZTsq8j+wYynnV1ag7IOl8OQHZrJThIMRen7tAz18eq2tAU6xuYtyihhq+z?=
 =?us-ascii?Q?FOHIIykSUnaiwadcArIFP3DqiYHJew/RmBnphUZCnpvXUuZsTdZk/hegl+TF?=
 =?us-ascii?Q?KkmeSkkOWAonNMSCZTsqHUhMmquNymCGIQsUXEhZSJqeA5WKId5dQkfUU/NN?=
 =?us-ascii?Q?koI6mz/5mSaeIxf1U8c0n7oQ+2q/Wl1AaKLOnJlHByIRDfYQrYxLvoXbu9WG?=
 =?us-ascii?Q?9WufxBqvF7ad5Bye7m9zpW0JPg+YQdYVGAKg0iSO2mEszwRpYYMsDIJTS7UJ?=
 =?us-ascii?Q?g4MvLq6j/zS6c2aRBPbzOTjNJgk+iX8aCHuioOk1zBGnf9jsfYvM2YxMUDVn?=
 =?us-ascii?Q?IEHAV80ILqUu5PyX4+w60O4OsGAHt4/VRJxd8o+4JDeGtHSOyEj81LHSEatk?=
 =?us-ascii?Q?Qem/2RqHL37gPTZAFrgbc08QIrp2vV59QXPtRwKJtdlJSZA094+8CZQeQtJB?=
 =?us-ascii?Q?BmvbuCz/Nso6avbmk8NCVpFyNTZFtO8SP2wwSFvkKhrDQbE4FmO96i+IiDTM?=
 =?us-ascii?Q?fo7O2ab1xfKLRomYmNFaNGrFH8tuMimppYNzgb7+KdZ2faLa7sB/vwiQDDED?=
 =?us-ascii?Q?g6P3iZxf4/syisNPm6K8D7feVhIlmFvKXbv0LI3tZukt0hS7CbhigHKwuVfc?=
 =?us-ascii?Q?h2Y0CSHceW+G8oP9SVrijKzS8e6+KdquW+sN/ZqQM8XkFlpaOKwdszPsY8wq?=
 =?us-ascii?Q?G8yEVDAjvn4UkopR8K1/lfN1EGm/yJw0XxYFb06hWNnMh/BOyC/HekoGRkws?=
 =?us-ascii?Q?3ylxWOjz5OB3ql81MpXypknuvrkDolmEvQtCJQu5tm9JhmmECFAjYTRnxRpw?=
 =?us-ascii?Q?4JIj+sKLfroGJXJl51QAs9L+vuxHecWEpJsjgqsd+tYR+VlicK1vcyQven7T?=
 =?us-ascii?Q?H/EZO2EkBGMsJeh+wCaT7xhlK3IP4+WLdO9epiFwDrizD96WgXpIqnaWEs2o?=
 =?us-ascii?Q?qG7uki0qTHps/dZbcEo4bh3yrW34Dd9hUc0G4mIb+ToO+Hc/kJLR+pP6A/uD?=
 =?us-ascii?Q?HaoXYoeLgdIvBrAbUoMpg4PTAB5uiImz7wwdXhcJckFf08xucyxCr3SxImQP?=
 =?us-ascii?Q?8y9OG3aCD69ul3V5kkQSDmXESD7M325DxTiBGeZem/IGfKqrkubWZKVanC9T?=
 =?us-ascii?Q?HEAONkkmjxMKy/qmEbycNYc9kGAIjOepR0w2g7P04vYs7BuyQnQwq3PnM6bU?=
 =?us-ascii?Q?t6dB7P97Ar0MueI/C2y5DZIJRUwggQL+lC4pv/H0s8RbaqeZcPamGraQ5mNt?=
 =?us-ascii?Q?ddwX/lQZJDCWR8eaWkQpvToR/nZU9JP5AoNkROnxViSl+AkbEtDC5gbkJpxe?=
 =?us-ascii?Q?REn7i1zls3mlV0GpikagO3Ybd1wX3QJMUR0k2rK2bKqEPyIZ76tIfkyBQOdV?=
 =?us-ascii?Q?nl6PmP4iem0CXjcJgnksNwxDuFz8Q8dHXqa7+w+/p0M9jLEU2l8mMZjtQKR8?=
 =?us-ascii?Q?q0xcxXh3FkAphnQBgUB6RzbFY/de8VhAhMV4?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 12:02:52.7228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae81ed1d-b50d-4e3f-19fd-08dda74d901c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292

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
index ca60ae325c22..6aef8f643ca4 100755
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
+        except:
+            raise KsftSkipEx("Not enough queues for the test")
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


