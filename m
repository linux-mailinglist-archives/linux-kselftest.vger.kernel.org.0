Return-Path: <linux-kselftest+bounces-32513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C267AAC7C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 16:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3DF1C05A07
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4F82820D9;
	Tue,  6 May 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rZhHKmXd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F06281504;
	Tue,  6 May 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541326; cv=fail; b=miFCD7/myyqkIpD9jmwnF8S8onMy5z9hHCcjzS/NDF8zRP3QkIh4od/dtClzYSDdrNOQ84k5VQHF8/SxbzrLIM6dx1ZradPmsal5reh38J+kYmgLzN8Xlb2rRte9g/TW2wJ0Sb5QCKBDjJvx0LArS3ES/1WdgfCW7dZkoE+WpM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541326; c=relaxed/simple;
	bh=Nx+NNYyhI2gYLvohp+BFWKjqF2i0J+SVCRBkWbAi1Kw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Atz9nqvZ0OjZmZgYBbO04BFEwllr4FLEdjlHzwas9QAJ5YTxLv8tN28zcSNee9lkb8ZzA5MCw7GKjaR4TPUd/hbLzcWX+RB4/ebzWoG1aA8OwkkyheHW3164QXO9hGlw+Rv4h9/ZBfO5zFq0tAf7b26SVEZUI2l2Ab/WsFdLyZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rZhHKmXd; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go36BgCAZw6BVRz+jAQrSTYQB5TBLjZkFPXe6O0q1Gxj6pOUdHwVtcmCWn/UV0UUU606YuNlTZLQWBdQD9XHI6KeuCzc/bcgTXA1+BbVx1zbV5YFWxj9BKjwdaNs2R1uayTiSOlMHHUDb0/c8twIYSXaMZS+9TDdIqI5+h8o3A7PmTUS3monAu+i+swCis4ykKXwv2I9jMJl+0y57L94O5jepOPDwQJW37ihcHXlVxNGbdZL2s6gbn8yDGNqF7Oezp5n3wwhMS21TUx8vcOQQTzfO7pRxDrZuoauSw//Krkiz5GuFZXQtPgyaUgCEM+HjRgmqMQcimbJADs7e/q6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l27FuLtmkeXJHsSl3QMZhkCebup9lF3ghNDOQBcnIBg=;
 b=mg34603VfRCosDSMjNi0k/x9qMc7BoKJ+lSBX2JoDW8l598VAJzLuJko634oUfh3zwErkQZ0UE0oMk2IbWcb5v+cp5oCAMRMm68r+QNos/aUPQxD+6m3XkyhU4Wn+D+eNxg90UO/wFv42MJSTXOaCHr0g0r/5MEdTMnfp6qrBmDWMQ1hdoVS9UUKjUMXTf9lXliH47YM6ubQ4c1MyNd/033LMmGHKbytKMxBLLmW5NUt6lkIluJSlBsLfZBI1h1aS7dKiNLFRCwUI+ra1oLFrM+waWUU3jh34Tp/1avRJy5B16wtyZe4tiDy49IO19VO0w1fd50r+X4BhQ+JF2Lgkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l27FuLtmkeXJHsSl3QMZhkCebup9lF3ghNDOQBcnIBg=;
 b=rZhHKmXdthRDy8gtG+CxBhp3aOOxWn/M2VjIzKX3mAW6Yx/B8UO2Zl5lJBHvsqjI8uH7X20HNFGm+VLPRk+CR/fOP0ZMpxX97diFm7IdJRZz+oV0EFg2wdPs3e8DTDJhnDRQEYDCgUcE27YIR2u56+KGKG9OBh2WpQpuEYckK9tyjrvGNU2VdD3IA9fqLOVwhjCSxgNpolYdMGa97wab0eaSFqS4e4vtzB2VS11JGICJv12h/Svi9jIufaYLiG2+Sks2yhdmzuWTkUDIOQidcmEX0R9Ae4Fdw7F6/0CZ+hCdjk4trjBJb8yqPR/2GHzrhlBcw8lcEdtI4h+tCtoFag==
Received: from BN9P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::17)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 14:21:57 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:10b:cafe::f5) by BN9P223CA0012.outlook.office365.com
 (2603:10b6:408:10b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 14:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.3 via Frontend Transport; Tue, 6 May 2025 14:21:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 07:21:41 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 07:21:30 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>, <cratiu@nvidia.com>
CC: Stanislav Fomichev <sdf@fomichev.me>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "jiri @ resnulli . us"
	<jiri@resnulli.us>, Saeed Mahameed <saeedm@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net] net: Lock lower level devices when updating features
Date: Tue, 6 May 2025 17:21:17 +0300
Message-ID: <20250506142117.1883598-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4871a8-dcad-473b-6c8c-08dd8ca95b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gu0lC9Rx87dR/vANKR9SWr3i+1sAG66fn3TX3iE+Tvbg9FLHplGHyLbTOntp?=
 =?us-ascii?Q?ahLENbJQxwpVPbOHuMUEOp7LHKmDvITlB4Gq4tlYzLfgSEVfmW+Kq3eNrB4w?=
 =?us-ascii?Q?K4PD2Ro/3vORtpf7ap/6yeVqGNU7jE4S7t2sIoMtzrwYr3TP8iLCafSQLjHy?=
 =?us-ascii?Q?w2TlN4IMfHqKzp7y2gnm+8VJQUln+Pyp6bdoWn+XvUr5z5rBrZhZl08V5uKc?=
 =?us-ascii?Q?jeyEFBEoTRXR6hcNQP+dGfHOCQ5cQMFVfiX5M8vhM8uuPWgYIigDPdYUskWn?=
 =?us-ascii?Q?Aq/jZfbOSX1V+E6mbiHenLCPlGCfC+eiP8qEyd51dh57r53bKFElnf7n9NWC?=
 =?us-ascii?Q?3hC6fs3fwD6Lf5DtxL7bhtbXCKSY7IrtuPM6C8cO/cNEFX+f9Cvb1x5IIubk?=
 =?us-ascii?Q?n4z9ImMf3saPKkFMMaKRyxRHLg8e22GPTj5V7CcpapOydGICGRTLvg6dZf6U?=
 =?us-ascii?Q?5vo9fPObMW3ttCK0v2nom7feGPD8VkUlQlsUtiuvZqCAEPu9rmLMcAdmJwxS?=
 =?us-ascii?Q?ifCr6SB42Rleerf/x+ztosv7zJ9xPjsUAMS3zx+1JC6LnHFedkSsyszKcJcy?=
 =?us-ascii?Q?yvuuQWVtzFn1w8vPTNrNATpVrPqdlJ+kzf8kZJO9bYx4t22dwCQ30r8PWhvy?=
 =?us-ascii?Q?NhH8Z9fHkd4WDX8isAkNQdc+qYA0vsr1u4fiibWYP3t85UoYZO+IFa4wUGgu?=
 =?us-ascii?Q?+7i4932V6EgccCre+ZXtgLax3o3NkLtZzj8cdT184XigY4PEC9pP8jORmGJd?=
 =?us-ascii?Q?+ylbEW2IYB6zgGwrWQ8FkpcOkPVQ/uK9pTvGNR8S5hzP8TkfxCaAmbWdKccw?=
 =?us-ascii?Q?1eXSsjddnT4Vx+1xPWkRBO4uvxxm3PNrG+BPc4bLbmk7JImnjZlEN9k2/Al8?=
 =?us-ascii?Q?IxOuic/hGQ+uNyumsbS2ydOGtF5ahVBIF16YZveqYPzVEFpysmXzFUFPeVjj?=
 =?us-ascii?Q?gd4DBZMOKlkkDyYyyu8INDWWTkwN1E/1jiqaoVIDPZXU/cGovs4zOdCxCpdr?=
 =?us-ascii?Q?OVvaAyawEfZAFN4HZBlVpnycowugiZOwmLTux2igXPitCeByFRep3nPe/ZEc?=
 =?us-ascii?Q?rhRD16uPx70hrG5vCSA8ROOvHMs2IIE941Wpv7vSxIQoktUL/jA5oSqyB8WF?=
 =?us-ascii?Q?T1VleyWN7147AKz5CLqjf2uaqBYkda7+hE8XHGzwyalVwhQeKlCkEicOS9Xq?=
 =?us-ascii?Q?O15Px7wXIuusw6XbGuO0wUmy0YWmJnoBNHGDZ8N+7jaTuHMEZxZy92tj6rLH?=
 =?us-ascii?Q?QDH4YzG3mUNnNlWG4il9HEQzwzc+HoEUc87FTmEgRSIO9VGJVw/D8IEV/kIu?=
 =?us-ascii?Q?CCZtmlfCIUSUuIk6grm1cGpa8J0Jv/73tbzy2JJmLROLC4p0LJC2egz6xQiC?=
 =?us-ascii?Q?TBRhPieFcWXueNAHhrhQ1M35VtpGjghQlB+xMr6VRAabDlrbUDcl44pdZBMG?=
 =?us-ascii?Q?+jbZeVUguCKsTJWyYtHUC1S8/ah/VA6gHt7RbttpU4Sye+YnO2bz6xvr4NYp?=
 =?us-ascii?Q?3AArzk53efVMS9ypFTDKsRfC39ENqJ5SZaX7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:21:56.8949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4871a8-dcad-473b-6c8c-08dd8ca95b98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738

__netdev_update_features() expects the netdevice to be ops-locked, but
it gets called recursively on the lower level netdevices to sync their
features, and nothing locks those.

This commit fixes that, with the assumption that it shouldn't be possible
for both higher-level and lover-level netdevices to require the instance
lock, because that would lead to lock dependency warnings.

Without this, playing with higher level (e.g. vxlan) netdevices on top
of netdevices with instance locking enabled can run into issues:

WARNING: CPU: 59 PID: 206496 at ./include/net/netdev_lock.h:17 netif_napi_add_weight_locked+0x753/0xa60
[...]
Call Trace:
 <TASK>
 mlx5e_open_channel+0xc09/0x3740 [mlx5_core]
 mlx5e_open_channels+0x1f0/0x770 [mlx5_core]
 mlx5e_safe_switch_params+0x1b5/0x2e0 [mlx5_core]
 set_feature_lro+0x1c2/0x330 [mlx5_core]
 mlx5e_handle_feature+0xc8/0x140 [mlx5_core]
 mlx5e_set_features+0x233/0x2e0 [mlx5_core]
 __netdev_update_features+0x5be/0x1670
 __netdev_update_features+0x71f/0x1670
 dev_ethtool+0x21c5/0x4aa0
 dev_ioctl+0x438/0xae0
 sock_ioctl+0x2ba/0x690
 __x64_sys_ioctl+0xa78/0x1700
 do_syscall_64+0x6d/0x140
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
 </TASK>

Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/core/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1be7cb73a602..77472364225c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10620,8 +10620,11 @@ int __netdev_update_features(struct net_device *dev)
 	/* some features must be disabled on lower devices when disabled
 	 * on an upper device (think: bonding master or bridge)
 	 */
-	netdev_for_each_lower_dev(dev, lower, iter)
+	netdev_for_each_lower_dev(dev, lower, iter) {
+		netdev_lock_ops(lower);
 		netdev_sync_lower_features(dev, lower, features);
+		netdev_unlock_ops(lower);
+	}
 
 	if (!err) {
 		netdev_features_t diff = features ^ dev->features;
-- 
2.45.0


