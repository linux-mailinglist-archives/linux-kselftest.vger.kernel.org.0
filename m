Return-Path: <linux-kselftest+bounces-21921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8F9C6EE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917521F221BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 12:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A211FF7A4;
	Wed, 13 Nov 2024 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O3ZRxL52"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE805200C86;
	Wed, 13 Nov 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500132; cv=fail; b=VvgXvakwNghTA2+0ERUwWqxadtDjOzNO+N6s152kYtdKm65chJbwDGxZIcX5PTGUGv15meB4L+vpQNnHngNGSgZkn9k2O3he3IAZZbtcHQkYPiqJTfiHBk/85NQmDrqSZbIbb6/g5032ZusB+lT/HbGSsEGwUyzlgftPXb3A1aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500132; c=relaxed/simple;
	bh=yyaFvETY31j/Tj0x88Lr2K4RxaOrsbBsyqLP6i8uK6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IW3HATGw8pXE87pTtqm/gMaIG+lXg4hFNYILsreCV266GFyM+wEKnBqymkjYA+ZqG23mH3NCGJv0rC5oUM1jCLkyl/Ow3iIQLoVCVblIeEqemLYSu280xpG6dOLHzM4S00zEJPTa6Z8GQeEIzW3Wixg8a3izK3bLwfkHXlNqLgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O3ZRxL52; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8AbhAeCrz7ZKNNw2hcmwOZxVMRKS39Or6iR5gmX+keyM/S/HDI0V4NzuJT7O96PLaq2BwXlAHtf3J0XGsJ+JhX7zJdBbCAV43ywtizN+3NYLFiu0HJDEo8a63E3fbTyvqgo3kP2jBaF0hZ7yLBX4Tx984KAB4BPOQcthcgF7jUkO6nWjO8X3ShGe58XFlxymzn4J15Vl9+Hqi/jYdLUZ3X8ThEEUB+Q4tonz9lFuv6ZiPNrercHMwAK0fJOqUIseTC1YB5ivMvNoB4WqRgqsAnY8CnYOeCZVfyIlDQwEyBXuj3Y9RF+FArdbKbVEYHAtTQTVnM8bUe8H862em4UYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXnOQQixjOTI3P6ivrB8t7H4/wpb/9uqua9OWD8DVxU=;
 b=iBawIO2XbUI7bBtyWhjEkLpHlOw3doiiLgB+v2vPOBOxZH74qyhgmP0hm4PEHTFuFyci863OWchlRnjtOsOy/Qpin29q1n1A1NgMKVBkl48IUbd4/nm9c71XbcpEQLKyXfmDNs5zl+hKeEgekKx9Wsjc/7tEE1opxYJyaomBS7HwoMbJV+EeGTBkwX3yqRaHP8IdvKLJdNTTqfgZHQT1kvYnPDbUcQEkWxurF5p1bonOiI5naMXfg7T+dis8iF6kGfpsL8EK5UCFdpfEjkN9lpLd0BT5WjqhSHH27P6mDpvU9VbMeMRy59qla2lTS4cFemRxJlJurcb8yG1rowdtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXnOQQixjOTI3P6ivrB8t7H4/wpb/9uqua9OWD8DVxU=;
 b=O3ZRxL52xum2ESVnb5UICTs0tiaE+3kCK8WVxe1cCnF77jgnbKWeruQAIShAmNh3kRmVHuzNvIaxCkXGOviLFsMLPbG86Vhg6MuVGLvDuFL6pzo9METpBXi9WEdpGmUTbtss+ZsMH/bP7ttcgwXRfGvxO0cdW1/tpGDDBhr9tYI=
Received: from SJ0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:a03:39f::35)
 by DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 12:15:07 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::e6) by SJ0PR03CA0240.outlook.office365.com
 (2603:10b6:a03:39f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 12:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:15:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:15:06 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Nov 2024 06:15:04 -0600
From: <edward.cree@amd.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 4/5] selftest: validate RSS+ntuple filters with nonzero ring_cookie
Date: Wed, 13 Nov 2024 12:13:12 +0000
Message-ID: <114afdf4d2867f72ed27751e8e08fe8b128a8529.1731499022.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1731499021.git.ecree.xilinx@gmail.com>
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: a5acfda1-dee4-4e42-056e-08dd03dccfd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ijBl8p5zzixa6hKIy7XJmwnsBdgOB0vfaLu1j3sB9CkzXkbtBiOAyjZHecC?=
 =?us-ascii?Q?ILmjRIJwvrzjK5Rdz8ZfHR+loVGao4yLLDWG7IwdIokA8dr5wCxlf6gfaADH?=
 =?us-ascii?Q?nlkTHNoaNyzFPaLtCNjDtrt2CqT7rK+/lD/HIc3z5F4pZiGub+uHQ2fyMRZw?=
 =?us-ascii?Q?/QeK9S/Teq8X3qGKI7iPRFwnJPTGU36WTpDDXRFx8HzOyVd1r2uKngJij710?=
 =?us-ascii?Q?SxSiMqfam4iGpfU7eDjN1+4Ex6qVM/vI/H4j8BIYz/l3DB3PnmiOwqUGRvkh?=
 =?us-ascii?Q?8hGdfMUoD/zZkjg6J8oyxnJDf00M6fqdhf7mhwxZdpbkKpcJUVohJrkyz5jg?=
 =?us-ascii?Q?USTNiuk4Na9noR3iYESLJhVCbZCm5vgGbiJylTv2L86NWSv2Y/Vyuq6taxvD?=
 =?us-ascii?Q?VSQWrNFm/vLywWw7Cmo2hKNk6rX5dA1jaEV3995iANBjqScS5r+usagMYH9Z?=
 =?us-ascii?Q?w+qSxwV30YQ7QtR/QPdVJjMnKzmoNX9CNmRjE6esnB3EUxJt7Mr5zszfcpN7?=
 =?us-ascii?Q?Hxj2x+XZOQx6mUhtts4J42r1MYX3G0z1wjhfXSKpiFTyM/w6iaqTJXLzKe2P?=
 =?us-ascii?Q?/Op4K7lOUFSu/x4zua6ZgSpLcvo50OD9GCcoTnKVw8CjkCcMmaggguNV5bOu?=
 =?us-ascii?Q?VmaOAAo+DJcohwYPur8hBQDMAOvYQ+o1Ar8TjHY7XcEG6DdI5I200FQX4dvc?=
 =?us-ascii?Q?Bdw78gHzVWeb9w8u5PF0d9X4kcjMWxCWAAfs0ih1vq688y6jE3ly5tKgGLmf?=
 =?us-ascii?Q?6zEF7pkYoVk2rlwxOM0qKmFaGURncrlgsb3K+xnj3eZqYa0XQR3N5ZK2YMVr?=
 =?us-ascii?Q?GC/QzwZPhlZJMY1XEk4PhAMIhyY5h3JoqAI7UBbZw/OPThwe9W43xtZYSnws?=
 =?us-ascii?Q?txLPIuGlx7YCPMqnXRWOuzcKLGxIGmaJ3vlaJqqZCKDC5v+ubVs3uiVWryPn?=
 =?us-ascii?Q?ev4ce9j55eqWLk8KPnxYWkWJsXYQQhk6UQ4RgCithnNNv7IwZ9cWRilzaigr?=
 =?us-ascii?Q?smdQAPGfaHN2D3nnJfYDNzGdKGg1NGiiAZ64WBHf7EagrAoxZqtDYEIgCgZm?=
 =?us-ascii?Q?iPWR4Dy+h//QWdASSJPRzkr7vDUB/bPCwucSYK0pGsA9ttcoKRAvl7Oo2JA/?=
 =?us-ascii?Q?ZYbx/lCY1l+RQTtnVJJ4p8aQF9ueIpb4p3DFUHE5+dXLp9sP+FTZhH5CAdc3?=
 =?us-ascii?Q?oAUi0/+U2YkoC/+2UWwT9gVNLNwyB+b9n7df4NRAsvTpHSdIFjF/d/VrYW3K?=
 =?us-ascii?Q?eZfw/w7o9ncKCWjtQDBCSLXkhmdbUNfjVUuBqFlpR969C8aRAhwTTRW6zPnV?=
 =?us-ascii?Q?WE52RZez9QKMgdc7bPUvg6sPvoJbIPQIZFOBV/XRgPPJyVVw1lFnwgF4xldc?=
 =?us-ascii?Q?0aTxK11OG/gqvJuMzusry9kRILVb0w7E13+40dapRRHn93swWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:15:06.8561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5acfda1-dee4-4e42-056e-08dd03dccfd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559

From: Edward Cree <ecree.xilinx@gmail.com>

Test creates an ntuple filter with 'action 2' and an RSS context whose
 indirection table has entries 0 and 1.  Resulting traffic should go to
 queues 2 and 3; verify that it never hits queues 0 and 1.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 41 ++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index fb61dae20fd8..8f62dc29bd26 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -633,6 +633,45 @@ def test_delete_rss_context_busy(cfg):
         pass
 
 
+def test_rss_ntuple_addition(cfg):
+    """
+    Test that the queue offset (ring_cookie) of an ntuple rule is added
+    to the queue number read from the indirection table.
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
+    # Use queue 0 for normal traffic
+    ethtool(f"-X {cfg.ifname} equal 1")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    # create additional rss context
+    ctx_id = ethtool_create(cfg, "-X", "context new equal 2")
+    defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
+
+    # utilize context from ntuple filter
+    port = rand_port()
+    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} context {ctx_id} action 2"
+    try:
+        ntuple_id = ethtool_create(cfg, "-N", flow)
+    except CmdExitFailure:
+        raise KsftSkipEx("Ntuple filter with RSS and nonzero action not supported")
+    defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
+
+    _send_traffic_check(cfg, port, f"context {ctx_id}", { 'target': (2, 3),
+                                                          'empty' : (1,),
+                                                          'noise' : (0,) })
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         cfg.ethnl = EthtoolFamily()
@@ -644,7 +683,7 @@ def main() -> None:
                   test_rss_context_dump, test_rss_context_queue_reconfigure,
                   test_rss_context_overlap, test_rss_context_overlap2,
                   test_rss_context_out_of_order, test_rss_context4_create_with_cfg,
-                  test_delete_rss_context_busy],
+                  test_delete_rss_context_busy, test_rss_ntuple_addition],
                  args=(cfg, ))
     ksft_exit()
 

