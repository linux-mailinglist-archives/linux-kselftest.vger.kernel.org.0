Return-Path: <linux-kselftest+bounces-33417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFBCABE2F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 20:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD8E7B4E44
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F8288C1A;
	Tue, 20 May 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NoqRCJWB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2BD2820D5;
	Tue, 20 May 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766400; cv=fail; b=q+bbS3I25a2kCYupz9+7fapb9Cm5y9HHUqBqKorNWOwhE9t5gTam6UIitzOaLz5roo6H47aV3GIj6Vo7S25V9gasv+tmfY6ai8HD3If3i/+gqlFeqAyfeul4xY4Ap7VwY0lqd5Qh6A1V6VRtlkRtArfi4Zur3Dqx9W1a2DJx+To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766400; c=relaxed/simple;
	bh=Te1qEdlgvowDoGwvowaLWk6OdMjCp6ayGmekHU/Q+oo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQBy0Ku8XHKcmNS7h64TqVUuCSJgNKTCviHxAl5BwtengAqQCIshqvlzPfMnIICVgkZk5yk0HHc7ogG9TYEvBk675d2f79bQbMbeB28P3erwv+g6Fa4Wl0DTgSMy+FNjq9Z1LEB/MPUdD+iQDfRZHtbadKity306QXKvzLlb0fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NoqRCJWB; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TObw7UKKNLMbMn/2V2yCaGKZLerzk/bpAwqcaBayadzMsThnVeQ/fiG6BnqXhhBq5AcnRe1K/C3kXScsS9zuuSdBEp8qBik3bapEO8fjy25xFZyrgqrsgiHRQYPdWbtTxkoJsTbNk66uGZR/ZAIP66ACHNvbLTVW/kbmSP7GlR45kt8yxs0hdZizGo1cvXFu02srvFjdEFwZ++k2QCzk0+SC22EaZSdqTmfGmQE44PsCGYMEDy1+ubit4k0L2uLB3AMRXAY0RYVY006423bILR9Bn9D/rTU5C+FZvniH8zlweFrogEgLMpNHYLLzlixcX8lzUBxQlJvMsMivmBv9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/Cc1Ca5Hd2X09GMSLP3D3QneVtydXPAbWn22kqPAiw=;
 b=tw7f6asum7AKOpvrAQdVOrADHRW03ch8i7gmU98e5U+F5C1Y7MyqOGd+XAKtiLheS/+lAvXX/FQEbt+3m22GGGWIKTXts44+hNQaGzITvp09SrV+afHbRFYNfNnoEE3pKJnUTcz2ZQ+fRyzNSiYJI/lIf818vojV2xcQbtOFjw7MPI3b3nmqO7r69pZLnjGbRQNb72EFDiREdEoV6/RV8a42q4V3WdgqUl5ru2i0Atunwij/FjsjxHKdwrD9jdglsocHclrikEKTUsxcWQQRU7RA2iJDlzSIU/T2ZNNvv+XEV1bN2m82K3eHWk9/9Xuji/cMItbhVLCbUQeg394p1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/Cc1Ca5Hd2X09GMSLP3D3QneVtydXPAbWn22kqPAiw=;
 b=NoqRCJWBB8cTVz0/eAISZWgF19wemVQrZSbGVb7Bh2dbleLr0/lDFNxDed2sGzltcn1ApPUTkMMX7zxar56LcKWR+8qkJMKFI8YXxbkGZWLn7ZOaWDKb+42cnJ3DPlH7kvBVMTL/v0CGbVGCXRhQD8060FEZdrXxYICAMo+7QXY4eHkqCp/Xvt3LLHnO1ssa+NeybxMORF4MaAY780VMjJO1A7aDW2Y4KQ0l+poS+m245/Om4EUGHChtLGl5Vd9vnWHvkk0SeE7UQwiiDf/Kr2AQBuEWunJ+vfo+uz5kNjvduKLUXtfjjp1Os2OBKYc7AAsjKKOiyTV5B1zlyqEIdg==
Received: from PH8PR15CA0022.namprd15.prod.outlook.com (2603:10b6:510:2d2::19)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 20 May
 2025 18:39:53 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:510:2d2:cafe::56) by PH8PR15CA0022.outlook.office365.com
 (2603:10b6:510:2d2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Tue,
 20 May 2025 18:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 18:39:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 May
 2025 11:39:39 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 20 May
 2025 11:39:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 20
 May 2025 11:39:30 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Jiri Pirko <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
	"Jiri Pirko" <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Moshe
 Shemesh" <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next V10 3/6] net/mlx5: Add no-op implementation for setting tc-bw on rate objects
Date: Tue, 20 May 2025 21:38:04 +0300
Message-ID: <1747766287-950144-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
References: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 4917352e-fe11-4354-b5e3-08dd97cdb5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qJkGZtsRBRgQhX/ogtzrIIhTYAlFACrQEWgJ9gDWqK41IookVWd3IgAUH5OC?=
 =?us-ascii?Q?M0IKQS4OaXqCQwKmTHwsFQWl5bIHycdUcG9CIIv9fHMRK/sTK5ad6z5/CKAF?=
 =?us-ascii?Q?kmhXFejrPvcL6YWLijZQBfTuVb2P7vQ/WvXMEhqFypvOODF1oMvYLldOUoZj?=
 =?us-ascii?Q?M7h594UwosrslKwtH0k0ctxNyL66owIK4kcJghXETn1p/GgiPVXJu1pL4wIT?=
 =?us-ascii?Q?wKDAvSzBicnXzJtvszYwJijWLo0meNyVL1FMhm9GR/sY3se0qGJusmwhZpGH?=
 =?us-ascii?Q?6fNmAT2rygpM7YkfzRMrKI8pBxa8es3nB43gONM5x2Vhgak6zBLbw+AYHvYy?=
 =?us-ascii?Q?TLvY4t57oD0pHeLzqZYZ7zshf3E8WTyUPiuWoQjLszNcF6P6nEowIk3EtxQh?=
 =?us-ascii?Q?ao//gTuu9g2lgl+j1mvHpgwjU/xEW0WmLcZgUifV20P0ecuRmQ/op5/1ZHE5?=
 =?us-ascii?Q?k+fjduimvjT8L7uEa7EPasU+yvfKJWOWv0hg0xNrvEqGgvtMkqtav49nUNje?=
 =?us-ascii?Q?nNgpLd0yImLMtAvAFy39nX8glSxQDDb70GQFyWt3X1MUYqWunY1ne28wXJL4?=
 =?us-ascii?Q?UrpHj9DLmUNDdgnMWGOW4NW210NG2EAfZ21nfolx6qhfItLJkxPV2AQcSdVa?=
 =?us-ascii?Q?KeCMEdzWzjDZYo4SAnYdkmHzmkEm/hAV/JHRsCBI+it1jjLSUP/FNI/OmaEe?=
 =?us-ascii?Q?CdBDcKmX9CFswYSXnHdSEfAQ/lYRkRLXGwoF351m7lN2doasH3vtyNuDAdu+?=
 =?us-ascii?Q?Wb0eajxzNKHbv1vBVtsXIRqYsJux15fw21EeQCSGEBHfroz3/e5YUn9PGng0?=
 =?us-ascii?Q?XXNPePnT84ts5/E3tfCRif2Z1RcYvWxJnIq+buUqZWkonjkh6Sb5/UW6oWEa?=
 =?us-ascii?Q?TC4gqH+O8zfTgGyYcl+H3Jalpjl+SMIcsf60+TTH1JzM+eajpFVL3qUR/DWB?=
 =?us-ascii?Q?aZRk089wuulDZ3lAoHdSdZy8+9tSH18ya+yoVf3Nxq8Z9ZqfAyMcfsd8ZgHH?=
 =?us-ascii?Q?E7CYyrxLlZsGGe1CqCT4NqXRwMKyHxE4zgkTBKbGyjA59SA6/VycOG+OaJK2?=
 =?us-ascii?Q?bQmyAtzuIv12Ltwid81B/hjIUfLt0NiBbbSVgwPVFeIYOYhC0v22IHwLhyo2?=
 =?us-ascii?Q?7uAKkmXQe+6Z2y+6t+9qPTNlsF6cGnQckH0tVKkm8Nv3JN7zF35OUhtG1mqi?=
 =?us-ascii?Q?ehQvXKLLP1sdyFLg57XpZeT/1167Ob1/pif21ctjjKqKBMI42mXusy7qZF+v?=
 =?us-ascii?Q?Gs24FUNCuIK1yjp6zE7JGCTaXB6lJJigDYsjKTTtkxl7Ak/pU8zb7SXC82vY?=
 =?us-ascii?Q?A8OJ7l08Nlp9d6IDzfO6tXh7AYDbChB4gE2xm21baz+isI+ApPbjG6B70hdI?=
 =?us-ascii?Q?z5JkrdKufG/6c8E385srIauDnST+fB3LSNwRlA9sMgrxR6aN5HS/oXapG/4K?=
 =?us-ascii?Q?fLCZOPMnpi4mo/4sf86YI6Y8AMNf1FJ8G3HiUFKd9JTA6aNQeua3562ewDES?=
 =?us-ascii?Q?GHq728x+/O6vGr2a8RVnjhW3iCW53aJgJ/vX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 18:39:52.6990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4917352e-fe11-4354-b5e3-08dd97cdb5a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470

From: Carolina Jubran <cjubran@nvidia.com>

Introduce `mlx5_esw_devlink_rate_node_tc_bw_set()` and
`mlx5_esw_devlink_rate_leaf_tc_bw_set()` with no-op logic.

Future patches will add support for setting traffic class bandwidth
on rate objects.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  2 ++
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 20 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |  8 ++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 73cd74644378..47d3acd011cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -323,6 +323,8 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.eswitch_encap_mode_get = mlx5_devlink_eswitch_encap_mode_get,
 	.rate_leaf_tx_share_set = mlx5_esw_devlink_rate_leaf_tx_share_set,
 	.rate_leaf_tx_max_set = mlx5_esw_devlink_rate_leaf_tx_max_set,
+	.rate_leaf_tc_bw_set = mlx5_esw_devlink_rate_leaf_tc_bw_set,
+	.rate_node_tc_bw_set = mlx5_esw_devlink_rate_node_tc_bw_set,
 	.rate_node_tx_share_set = mlx5_esw_devlink_rate_node_tx_share_set,
 	.rate_node_tx_max_set = mlx5_esw_devlink_rate_node_tx_max_set,
 	.rate_node_new = mlx5_esw_devlink_rate_node_new,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index b6ae384396b3..ec706e9352e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -906,6 +906,26 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 	return err;
 }
 
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
+					 void *priv,
+					 u32 *tc_bw,
+					 struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack,
+			   "TC bandwidth shares are not supported on leafs");
+	return -EOPNOTSUPP;
+}
+
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
+					 void *priv,
+					 u32 *tc_bw,
+					 struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack,
+			   "TC bandwidth shares are not supported on nodes");
+	return -EOPNOTSUPP;
+}
+
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index ed40ec8f027e..0a50982b0e27 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -21,6 +21,14 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *priv,
 					  u64 tx_max, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_node,
+					 void *priv,
+					 u32 *tc_bw,
+					 struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
+					 void *priv,
+					 u32 *tc_bw,
+					 struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
-- 
2.31.1


