Return-Path: <linux-kselftest+bounces-36074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB61AECDD3
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 16:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E31F7A300C
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39AC22B8B3;
	Sun, 29 Jun 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LEfOuooK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11222B5B1;
	Sun, 29 Jun 2025 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751206969; cv=fail; b=TmSBdicq9umUoze+XS8T+e0DFleTDt9D3M2itS5csRYkCOLm82aUXT9wcyk9BBD+2quW8I8RQp1Kw5SBAg6tknHpSxshHJeWwOnJSkSoj8d0dUIlUw6jzhHKb6xx2iC/5fATyNoKNV4xWWjkLQqVT6kZhGPlAWpY9VT4axLFDDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751206969; c=relaxed/simple;
	bh=vtykJ9np3DmGO++zuGWsTO1qTzdcAcWKzSKkAWs6p8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDM25pActQq6E9/UKgrRu4M0640KAD9fwH9lOxyAT20KzcGv4rLoInmbUEGEkwelSD3enML8LOaQ2N8/1I8DslrEuF9ja89pJuODIN6OCWC+umenGDY3r/ZWkaSQggz+p2VZlkfuTjeTy2iloI2mqQFiGHi0ZyFnRo4TQSsdOAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LEfOuooK; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMETLrWsUmGBHea/uVyI0ITRJGSNkrgsYi0fbDNm2vHqCyK7pO7TmjG3CcFMTVbfUkDhInmII4V0a6IlDGtXccJinfcyxjlSlAXRBcTMgvtxMPxpZVuvkmc9DJ+511eJRO0eGzOljnGsOgLjN5LAJ958HF7uXGqtv8UqTo8+3/bZ+4eRnJgOpUamubaWFA25r780AQQAT8VzNHx1vJEuW2Ly0BfGkb4zHeRerjNxqdz0DOpQG3Yk7V6g1dkVpE/vINAwI0VEgNjmxANwH5Jg6todwwD+HHQlxzZaOL5kPKDMJeStUy3MxR+tlIqK7+udUBKSvxHS0rErcXSlpirU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpA/Y268254Bf0I9+ncWce71GQ7cUuxwYjE+5noH+ls=;
 b=iArTxm1kxDnQisLexej0ciJo7UwT67MwzGMOfnaBUU+jQ18YczTEJ7U+9WGOqKsuiuRjZPXLhLGC3vgqqCVdEYurPEO3raMKvWotgPKYnfVc24Poz/DE8hbgSvmY83u526EFVebfffHxv4mPiwrx4HzBmQWJdkDEh1pP/o5D6dtXvfd0IplmP/zt/yvEmHear81xgWUDibZAh4Awfi6WvwoHJzQ8OB0QVniKcWvGt0dE8AGSLZQcAWU2IeJ80pj6Q+cTW7oxLiiWq6f2M7xLlr6MwXJHFa0qFFzz/4X03pXGdxc+lNYJmV89tv9JKlDXsGwrpQoztxEntoiVbnx+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpA/Y268254Bf0I9+ncWce71GQ7cUuxwYjE+5noH+ls=;
 b=LEfOuooKCnik7x7LzmweExbeO8IzMZqu1LD7lmdDVmTwkJXraAJFAxwLvIoBsyVvii0GqOgZdSwiB0QUqPgK8u2DzFMrvV7TCRZgUQ+0/c7o+COrbUFyeZsAN3+EkTsjMj1RiGQv0ZoH+d9lg1B2eNZkDj1BBHPHJo/Z+EkeBWP863CL4GKAiNJHLKdk7yk9nR7T1ZQKcurLILECtqO29tB29/OUJ7w3T5901OG6OVbQUXzvVvfkA1Bw+3S8w/8SddA+yO8l8F0P3Sz21JeTrN4NE+g0A8JFzOPe7DtYr2Z0Wlb7FoZ5hE2iuYjjuMdsQMDLTvbFJVNof5YGV8BKZg==
Received: from MN2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:208:234::10)
 by BL4PR12MB9483.namprd12.prod.outlook.com (2603:10b6:208:590::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Sun, 29 Jun
 2025 14:22:45 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::39) by MN2PR16CA0041.outlook.office365.com
 (2603:10b6:208:234::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.27 via Frontend Transport; Sun,
 29 Jun 2025 14:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 14:22:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 07:22:31 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 07:22:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 29
 Jun 2025 07:22:24 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky
	<leon@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
	<jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
	<okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v12 4/8] net/mlx5: Add no-op implementation for setting tc-bw on rate objects
Date: Sun, 29 Jun 2025 17:21:34 +0300
Message-ID: <20250629142138.361537-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629142138.361537-1-mbloch@nvidia.com>
References: <20250629142138.361537-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|BL4PR12MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: 176a9bb6-de9e-430e-b8ad-08ddb7186a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RRQViPF8Ru4mCWy7xYGuqSh44+NluJQ3AlYiti+vLe5ty0hAKf63nxu2McDD?=
 =?us-ascii?Q?XjoaX39deWUvO1WIT9NUBnL3Q+i/VUEKazcxnboLq7rS9exjHyTOdTJvuO4x?=
 =?us-ascii?Q?4T2Hh1mbMMcej8BsDomsQ+ruQPGzBUKnzquwhuIz82QAYYk03bcIVssakCEm?=
 =?us-ascii?Q?D7YcsK0VMrd9GuHi0yw1Nl3cwtEzCE/bEu2I0o5xdsV/OFxFKAUihivfM2tQ?=
 =?us-ascii?Q?+fqykj01yMhm3kFp82ikMKvP57yQSnxE3bwnu7KeLqKybaaA1H9edyq5qBxd?=
 =?us-ascii?Q?xTtVb4mBp6A7ciC0VK4Q8RMff1vHg65faFlfzoVha+n2eZeSuSt9RZg7HpEq?=
 =?us-ascii?Q?xY70Gu3502h+1RvVtQcKvYCNXJx9IsPlXE0qKz0YvZ8QYmjDGxh9e+GSI/yA?=
 =?us-ascii?Q?HxpBLoHFZjyrMobOrSuDJIbK0EdtVnLwZ469alKpgFpJerzph6ptDgy9lYox?=
 =?us-ascii?Q?ACcac85rJyDbljm49bRgLQUbTpMtBewZMFqN5AUf4Hyx4hvRfMIY5JDyKsHV?=
 =?us-ascii?Q?BdqpTY7QYYSYCz3A4GXOKgyobBrvr+JH4Hde7pX1qyVIgG++zfUk0YCLePbg?=
 =?us-ascii?Q?BdkauL73rKmLslpnxSYHj6QCdNara+vyVCtJiLXMIrpKSkQjGTh+1iTHw3RO?=
 =?us-ascii?Q?l1N97ADG3VfDuMYWjo+rj+DOzxD6oVFk2QDqguUsy4IjrAdyopOOBcJUihZq?=
 =?us-ascii?Q?4d87hqWig6Ni04hj0YulyNBuCB82GS272je1wl5JmMPq9BtdrtBklrFavU6K?=
 =?us-ascii?Q?Ir12uF8thz91prBm9bpl0Laj7i1kNnRopFOLL/xXwcW6RmAShrJHD+2ouxkH?=
 =?us-ascii?Q?RK39jChnSaQRDpjqlEYkPBcaNAgkq316Haimb6BwTTevf890/s2SNXIt1MW5?=
 =?us-ascii?Q?nQNAKuyFPhllSrrahina/s6fNR/QBvamGuGdGeNcJ3IAEcFj3JplfAwCTRqS?=
 =?us-ascii?Q?DTmQxm9AOpJGdef9wG6IiR01va6rvWxhwcCtYuKEZw5LpKmumkyqfkYj3lMu?=
 =?us-ascii?Q?+Tu3nvP5fHU1qBvS8VQfCE3p82U2IKWHGSJb6ppJKBGhi7Iadwc+naAyrJUO?=
 =?us-ascii?Q?5MhVKRCbQJZqNjg6WMwqJlvioVTpisTxWzgF3wlI4l/5FQldhHfUqt2uWX1T?=
 =?us-ascii?Q?274uBTCJZwmwrNF4+xIUjY3kwhS5oc3y3BOWompnWAtlZBjYV5zeqz8V1/t5?=
 =?us-ascii?Q?F3oBIwYdaAGYWtjbfdccS9WZ44U5gOCUHyiogDeMVSRgK8CjSS0k3NJmNI6D?=
 =?us-ascii?Q?f5zznobtnpplI1sf25flBq0FGOB11NfU+hPr2b6bDSiwzWIFuy16aPFk8U6N?=
 =?us-ascii?Q?m19VYdIdQ8QbGnpFk0zAfveTxCG1a+LEl7SdX1SjJMd+wD6eShxQpJWyYgud?=
 =?us-ascii?Q?fZfyUM1520C7F2USJIQ9frYg9Fy3OdNrKlXaAU/GGtHDWAJgJPOcCVKP/kzg?=
 =?us-ascii?Q?ZciPeF4rH+XKrfjTLD2mOrUJnO3puuX94ZcCfM4mVHbdBbyA9vLQz6o0IRMF?=
 =?us-ascii?Q?gxkAJKj4laH3UULBnZrgibOe1nASEkAC+Fq3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 14:22:44.2822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176a9bb6-de9e-430e-b8ad-08ddb7186a28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9483

From: Carolina Jubran <cjubran@nvidia.com>

Introduce `mlx5_esw_devlink_rate_node_tc_bw_set()` and
`mlx5_esw_devlink_rate_leaf_tc_bw_set()` with no-op logic.

Future patches will add support for setting traffic class bandwidth
on rate objects.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  2 ++
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 20 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |  8 ++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 42218834183a..3ffa3fbacd16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -376,6 +376,8 @@ static const struct devlink_ops mlx5_devlink_ops = {
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
2.34.1


