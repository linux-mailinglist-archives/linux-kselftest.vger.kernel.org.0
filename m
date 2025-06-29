Return-Path: <linux-kselftest+bounces-36069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B135BAECC39
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 13:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2119B18973A5
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6281F417E;
	Sun, 29 Jun 2025 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FtM26qEx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDCC7263B;
	Sun, 29 Jun 2025 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751195923; cv=fail; b=p+9MgA49CC184XukulP5jR0YFyXJwaVZF/hldA5mg/LkyMMy1NOqkCmlfa+slLcjYqCPpzJs0umb9eQMT9BxPjM3qM9ZYZILfzCI4ZHXJ4kI0l+cGTzAYAkI2AMKGOyCZjzhnDay3degOm62ONQyyVgveW8HOa872ORW8NcKL0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751195923; c=relaxed/simple;
	bh=Gn7/rcYFJ1FG53sos7I9RciZkI52NthduLh430RJ7T4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h3rL5j4iHbszjK+ZN6dHVCbqRxKqHww8dQeNiHdOEaeEBdxuHf9Y2uK+0ZuIYDbmIUOrQj/CYmfM4501IqpAFDz3IrU5vUkIAf2b4Y9SbYqzhhPL7pwtmaSM4pLagYGKZknmYVGkFvfPuRLsF9vN9PmRYSO+w68qef57A+Ry0L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FtM26qEx; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p51SLEyw5u2aG7oFT3uOXyWZw2qKGzERAKa2ghsbUu3zMQ2oPes8TFHaMzY7Kl/pFusf25ShdWTK6yfXnqBV9kOx6rX64voES6tdYn2Ggj5KnIh4WLWk1yLg/kBYZlWXpNBv8c/mVk1GR4gXUkZG9Ix0y86ZaPTi9YFiSU/NTxev3YVL4F/Q2yYGNzB74ycAFR1KmkiB9Zt29/4HGy0Pm3772CVoGRq6Eg79DrnfkMLfmyhEEJwuGdyRmsppcxE6SOvuHaWgDTANPxcE5UpMVWICMo8waYo4pyIYNLV4tWjNxoi5Fv7LCLNIf3C/FtAVMyemE0XZqjedkg5gdctxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZnZp73qHYZyKMlQSTy3c/51G1Pj+Mbsuk1YXnIiMbk=;
 b=uGQvRF0LP6ue63TiiC96lBi7Fi5zJPTvNGLH/gPfwQ+HZgDWC3lvgLTEHydzF0GFcEmrJvSbQJ9ncI04u+RoeWZoGay5q8qbP1bQKVVOSNiGpL97A9LdRFlRAMquByfVtb552Fjp1i+1KVWP07q5475ii2wN/3l9TKENrjrgxTwpOFp4CORU1j0h/UWB3IU6Hzz3hMNdIvvp/rNfw3m4zqIuyuvRwkBqsqKPQT1d9xtv0mFAI8NZvvSFNr0gNojtXCjb5/T2YNXXi4h03hon6LBVFa7qzCgHnvEEVMwokNDsdB0Of0pYl5Uap9x3z6ucUTpUQDcK2iPPjXZeldrVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZnZp73qHYZyKMlQSTy3c/51G1Pj+Mbsuk1YXnIiMbk=;
 b=FtM26qExnV5aTgQ07NAiJzomv6nJBSxQGAxeqxXURvZ/a+Lka873mHd8GQ8tfQ9Z1hnjuxLXyla6MFQ4VLS/NN26ieUVLc72naP+3mgMabQuDEEcvGWvkLxSlK4Pf8HPHKemxbeWq+SYxXwaV+GUFHp8oBnCOgfdnTL5EfZNum7cLEjYnbjtJYJinJ+1LY28s8PHQnOj/eSidprVKKX9dEjjlt6IjxnvgSGzd01fKqropiAD+J9Gg/RCEEwR8L3hWsCbYd5MfjaVrZfbP55FjiFYZxsZ8c+jIEMOaR0DdTQi1My2jhPZR5us4Csx8glUqzJLlkSHnruFZFSHtuET0g==
Received: from BN0PR10CA0012.namprd10.prod.outlook.com (2603:10b6:408:143::10)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Sun, 29 Jun
 2025 11:18:37 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::ad) by BN0PR10CA0012.outlook.office365.com
 (2603:10b6:408:143::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.25 via Frontend Transport; Sun,
 29 Jun 2025 11:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 11:18:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 04:18:27 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 04:18:27 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 29
 Jun 2025 04:18:24 -0700
From: Nimrod Oren <noren@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: Nimrod Oren <noren@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>
Subject: [PATCH net] selftests: drv-net: rss_ctx: Add short delay between per-context traffic checks
Date: Sun, 29 Jun 2025 14:18:12 +0300
Message-ID: <20250629111812.644282-1-noren@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f3afe5-b86f-4c4d-7c9b-08ddb6feb0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e08wAsjDC8GAjNimwz0Qa3iGscqHadvv7Ltmh241169bf1lJ6PyGQAiXUZB7?=
 =?us-ascii?Q?70upwAYQ43P6fJOI/Kt9f2JO5Ttm6doXAgmfhxwCswfN+ZKhCATeX5OtUB2o?=
 =?us-ascii?Q?33Q8574l6y9Yph6E0oKGzb2pIOWAcGecLZcb49AmT/lryUwk1xaH5z3BdYcO?=
 =?us-ascii?Q?K5qFnX/cp1qhqKmPsRYDbLsKkFvKbJLhKP3OAQV9OXiY0poorl/oqY7d1Hwm?=
 =?us-ascii?Q?rH9igO4ejZmi3t6mdaivnEhanZEf+89/828qfMwUerzaAqlLySmA1F1v5s55?=
 =?us-ascii?Q?ReMhBfsz716neuM2FImoQNCmY7i46C5tGiqRY1eAcDa7TpCXWK07Rp93k4EQ?=
 =?us-ascii?Q?OdKY4J3Hqk4TkxtXQJRbqEVqllwqtink4n78OeuS9c5wFUUKoATYlKalFYTr?=
 =?us-ascii?Q?vpO9gZeMkcy3TpydR0AFXDG4Qbn2jS/kR2p97knaBJxUlw0wSUoaSa6NbnzS?=
 =?us-ascii?Q?5u8IM7fCztNyv5Xpjfq8YE6YSAVnETRbmtkqa7R5mMhlK5Xa38u9lslnpxRD?=
 =?us-ascii?Q?RnKAYw0pD94iSDUOG8iyGfTyUOy/x4mR/UdL7E5KNqLy3or4gTWtfR7cV6vU?=
 =?us-ascii?Q?b7XqCmsCwtWA2pawv0vbWu0FlHklbrJ1bgKuXpqPshJVIvtpRNbo0G43vBca?=
 =?us-ascii?Q?jT/t8Xes9g35TTNlgaR2ULxuXfRRNfrIguX4b6Meh7At3kDbqR/r7Fqq9ZJ1?=
 =?us-ascii?Q?cw4Yhn6todPz2UP1jptuUR8nFBNQ2GSbcJCg0c/nPKUSKD5uPFQ7qCrRT+B+?=
 =?us-ascii?Q?SD1AV+W3kZ6/mSInHVye3abjwuDQW5DoFJt0CbSyaaySfQxSCHg0BepJZIxE?=
 =?us-ascii?Q?OkA496TvqIxqEpcQnlumTInqmWQFyzWf/N2jBYhPPRWZ3GiMxCPUh7rna1/a?=
 =?us-ascii?Q?QuI4yyjT5aibMEqyw0Xhx8FhSYc+jnIzgc12V1lCjihJmAa/HJyNqlKz11Qd?=
 =?us-ascii?Q?CihHj1z0CDmUKevxqVzE0AKNuutldndfaJfTvmVGwSmDAJxrF+rkR8d38HBJ?=
 =?us-ascii?Q?ArPbDfoTieJbbLXkKohRmILi82mR3vdASnqOGJj1NRIrDSZeC7pzrRVUe/1a?=
 =?us-ascii?Q?0h/s+S20cYyR0f1Gb5nljWpc1PRPBjAi6V/Ghc/l7SSC0XtLtIeJOGjY7ZGT?=
 =?us-ascii?Q?M4qiE3/6Qm0TGrrGnCFxvvbsIn1LNYNpJU0Glwd8NoAYZrBBOAgD3vNlJPpO?=
 =?us-ascii?Q?qU44dIq5tQqDne/VBdFh1J/hqAT/0Yb8Lyd3plZ8pIUY/iTvHcyJMgV4EUIs?=
 =?us-ascii?Q?u6LCsgp+iDWlH4wLvHGuEAeXXL57L/9vDc3vgN5sezVY4+WpxNYqWHd5koJ6?=
 =?us-ascii?Q?E4xexrqavE8CwMSgY937QkStlYoiquwBtEHsh3H/DgTmMDlmcKfHtvu5xzaR?=
 =?us-ascii?Q?lVvANbD0rf9qmuKUhKqvaXTy2gY1q40x1MG6icb2CdksQgeAejFW8bfyLhOE?=
 =?us-ascii?Q?MK4zgKBtHefZud5/fuQhWZX3xBZ3Py78gwHK2o7c2AIvZT02KbCE6A8Blt7E?=
 =?us-ascii?Q?rOKKiTSYMHHkCh9e0cVAUoYH4FYk+xhenqAX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 11:18:36.0240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f3afe5-b86f-4c4d-7c9b-08ddb6feb0e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772

A few packets may still be sent and received during the termination of
the iperf processes. These late packets cause failures when they arrive
on queues expected to be empty.

Add a one second delay between repeated _send_traffic_check() calls in
rss_ctx tests to ensure such packets are processed before the next
traffic checks are performed.

Example failure observed:

  Check failed 2 != 0 traffic on inactive queues (context 1):
  [0, 0, 1, 1, 386385, 397196, 0, 0, 0, 0, ...]

  Check failed 4 != 0 traffic on inactive queues (context 2):
  [0, 0, 0, 0, 2, 2, 247152, 253013, 0, 0, ...]

  Check failed 2 != 0 traffic on inactive queues (context 3):
  [0, 0, 0, 0, 0, 0, 1, 1, 282434, 283070, ...]

Note: While the `noise` parameter could be used to tolerate these late
packets, it would be inappropriate here. `noise` tolerates far more
traffic than acceptable in this case, risking false positives.
Inactive queues are supposed to see zero traffic.

Fixes: 847aa551fa78 ("selftests: drv-net: rss_ctx: factor out send traffic and check")
Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Nimrod Oren <noren@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 7bb552f8b182..19be69227693 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -4,6 +4,7 @@
 import datetime
 import random
 import re
+import time
 from lib.py import ksft_run, ksft_pr, ksft_exit
 from lib.py import ksft_eq, ksft_ne, ksft_ge, ksft_in, ksft_lt, ksft_true, ksft_raises
 from lib.py import NetDrvEpEnv
@@ -492,6 +493,7 @@ def test_rss_context(cfg, ctx_cnt=1, create_with_cfg=None):
                             { 'target': (2+i*2, 3+i*2),
                               'noise': (0, 1),
                               'empty': list(range(2, 2+i*2)) + list(range(4+i*2, 2+2*ctx_cnt)) })
+        time.sleep(1)
 
     if requested_ctx_cnt != ctx_cnt:
         raise KsftSkipEx(f"Tested only {ctx_cnt} contexts, wanted {requested_ctx_cnt}")
@@ -559,6 +561,7 @@ def test_rss_context_out_of_order(cfg, ctx_cnt=4):
                 }
 
             _send_traffic_check(cfg, ports[i], f"context {i}", expected)
+            time.sleep(1)
 
     # Use queues 0 and 1 for normal traffic
     ethtool(f"-X {cfg.ifname} equal 2")
-- 
2.37.1


