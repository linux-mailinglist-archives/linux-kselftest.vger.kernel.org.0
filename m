Return-Path: <linux-kselftest+bounces-35793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE30AE8C75
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 20:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC464A5112
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 18:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99372DA767;
	Wed, 25 Jun 2025 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o9AiRMW0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C022DA755;
	Wed, 25 Jun 2025 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876282; cv=fail; b=qdhWXvN7szMd7jEMlZZCdqDra9Y5/xEWfs4IldsUbDP3qc3mMIvDFcZfnTN4LX2Vps1BiKdJBrarvBCoOL6TTFkvztZfNn1r2iE4d7GNeTVoN6aFhbUwIRjA/anUvMeKiTW5UTOhaYPzRnn/xW6v5e5DYhmlMAnxZKj3AEXrKx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876282; c=relaxed/simple;
	bh=vtykJ9np3DmGO++zuGWsTO1qTzdcAcWKzSKkAWs6p8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dbj2lx97wq2Yl/l7c2wjZ5o/OPrebWRrtRT9eHWYp2BiZ6aiuLbwqjQhU9w9djcVGEx2/EKqwVUkt9EKll2Da6QqkKeZTO8p1ihTilW182NNHsOsvo6pKW0D16S8T8zHpxdemCtVt443jFgRAj2ZWr0GeHTnGUTUA6Zp6rnHwrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o9AiRMW0; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbicMcEpnesU1anM0LjkdHwqt39aA3mWeHujj/k1GebChVp3e/Oiy4YfvEIJMMruWI9Hpxx6Zyqzg/IX4BTfptHvYIr1M3i1RE3PA1S4Ar+Ga+lnlqBeKtDjFI+45jmfpPVcsDRSWn65BL92kj3q7kdOCMGFBetj0JEhY/gj2056bQ1A50/7JChbgUFdLDhTMlnjmdvkE2Ih2oH6RZzUZiQpbA4/weKpvOYDs2+RpBA1bIcumh+D+ilsLfb/9/wlbLCuymQv/spdUeW0hvUOJfdsmbD6x/iMVcJeS4wVqLrVbg1LiyC6OdDW3xkyKdQtKgFOI8A+FjgXz69uZs5jAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpA/Y268254Bf0I9+ncWce71GQ7cUuxwYjE+5noH+ls=;
 b=ExinoInGD6t/8zhiubGY0CwISD9imeNSgmuEf10pxdpGtjoqEbM1NTNASrnDB8aE728K7PElwsYRoJNgxyGM2ivypThNL6EaOO7PHckx6DgHbA+K+kIjUtvwrG7MIfKpEAmlTKjLfFmZbvc1fKjhJ3I09obPQAAw3j77G/U+N1a6Hvq8mkF7zfaATFCpfTXQxwuiQ9PrGp5LSlbiT4Z1r0j9mAEIIJVjsV9OLLT5e9ZWGD24Ao3cMCf60W/UbOmI/90GDYbDaOaSRX029KYDV7lYhtwisbW93YBx5hTEowMQ0VNl/bTyWFo8X8DbH0u4EYefMWL0GGcDLySijNL5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpA/Y268254Bf0I9+ncWce71GQ7cUuxwYjE+5noH+ls=;
 b=o9AiRMW0BS0oinE/MsWD6t8KNdhtRkwtoarwCmH/u5m5ctxraniiCuY33M7rZs14NuF10NQd97ZoVcVk3yTSENVgGMnZxTyvejbA7xPZoF/KDTsSwfSCHClr34eaxuKtTsm4dTXpKmUdm8GzJO9YYhu2CvFwogd9wmcE6KOeupf6B1x5Iw+WkYO5bX4wm1EKEsHUL0W20l8L9rU4RTS82WPQecesvgt5cHeItc9Ayt2PsQQeUy6esHacFIBL5xwDn1NvUp83WMezs8mrNB9HYRk2Xil4Gg+WSN106ioaTfvmnW6dDTFw/MNa8r4gIN0OB80iSF600l71LtcG47jzaw==
Received: from SJ0PR05CA0118.namprd05.prod.outlook.com (2603:10b6:a03:334::33)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Wed, 25 Jun
 2025 18:31:17 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::10) by SJ0PR05CA0118.outlook.office365.com
 (2603:10b6:a03:334::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.7 via Frontend Transport; Wed,
 25 Jun 2025 18:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 18:31:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 11:30:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 11:30:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 25
 Jun 2025 11:30:49 -0700
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
Subject: [PATCH net-next v11 4/8] net/mlx5: Add no-op implementation for setting tc-bw on rate objects
Date: Wed, 25 Jun 2025 21:30:14 +0300
Message-ID: <20250625183018.87065-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625183018.87065-1-mbloch@nvidia.com>
References: <20250625183018.87065-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 145ef9d8-6081-40ed-b447-08ddb41678d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zHl7O6XNRvrp8j54230tsKvzCHEPPyxPlCK9u0gdeZednrrV8NHYN4QEZEkO?=
 =?us-ascii?Q?7FAVKKm5+oqLDXDhZ3pV7VOZ+H1//DJGaO37jBy9oXAe3SiYf2lzBPmSlu6L?=
 =?us-ascii?Q?+NC5WbgBdkN4Q+UMXpHI1ehrp8AOMziYQhyTmks1fKNT0He/y8eZa9S1HPlX?=
 =?us-ascii?Q?sKHrBSBWqlggMN+dYqP6Wkjyx6gCa77dNOBylNeqspHdqpFvcGiXbIZpVFWu?=
 =?us-ascii?Q?G5iiOYluWykcjBeSH9tS0YdVng+feMm7D2KdUNEfBIE3RiRZiQf/s4F/QXku?=
 =?us-ascii?Q?fun/EIjT/6vGTNulZl1xlf4ubKrHb9r6gOprc5KHYpdnRD79RyHpSgyyyZ0r?=
 =?us-ascii?Q?li9CHfL4YHinaV9+blvFnX5RdWdJza3t6/e/cDzUFYrATiuMeXpfzkuipMe9?=
 =?us-ascii?Q?GOmETwsNWdgYExiip0NzUFsQni/kNa6J/zYX2ZDFXt8iejnCwXwNIngL9ij8?=
 =?us-ascii?Q?SnB8yZgnfFk91Zh2bKC4c3jp+amQ3S2U0rNsPHfcMfpnrMm61nJbUFtpECjU?=
 =?us-ascii?Q?jGg99qr+QCu3P+9nbvvlvP2JZnbl6JyMOh6zEf/4ujWQa3TLKC5PS4CNwb4M?=
 =?us-ascii?Q?suoE+ea7uVlOmgMjftlEz/s+MAk4piPOVueKtyHVEHTApu9P047NwkHO42ma?=
 =?us-ascii?Q?jWagb4hZzzUe1gXk7iDCJbQSxC1lvfYSsvt4WKC5qk8hqHmpX4Ye/9O/8ZW5?=
 =?us-ascii?Q?Ewp/ba7DlDL2vgD48AyB2Nt/N1HtgRHRnANM/084eG812mFVKt5UU+534RL6?=
 =?us-ascii?Q?64BYWzXdlIFlfUZn7u2j+EIeE+xmgQIW9IXY/z20siaYGlP0lZlcz3lZYCDz?=
 =?us-ascii?Q?Jxq/p/aJj50oA5CEwEkFynLQfLeK8fA5CT4T+vEWFjRJnDt0dJTxnUI7ZYX9?=
 =?us-ascii?Q?ylmZdxwijPzJ+40lvq6BRvtNBq5Oxnxif7aGmuFp/lU82TOCs1nl2gOTSOex?=
 =?us-ascii?Q?CzrVjusemlffVGQcmKR7I8PauZ4DIShcshg8vqP83ZyKSZ1eKZrhKYuZ2wOW?=
 =?us-ascii?Q?xEZ3mqvCIGjFNXsSg5pL8arhKQymLfM5AZKdk5qmScBpxyKQP3JwoTjGmiaG?=
 =?us-ascii?Q?dr+syMHu7iSwu9DZ26aKRJuXJgygMCKRn4ZcIqBuO/dome0hZwtwxCb79kO0?=
 =?us-ascii?Q?NNZefV0m2uEdQ6fGGTqdm/5XOK2Yzx922gx5egY3Nl2/kESuPUhDN+OxuqY5?=
 =?us-ascii?Q?PjL/9DlM+07+qhUZWvC/bYtTRnGhW/vK2j5PLTCi7ZrtaD4IeZpvMzevNbgK?=
 =?us-ascii?Q?oJdeI1RS7cSuggQWbLbga93REXtIQ81BNpoOG7PVIrc1UYUSWY72jsc/XdVy?=
 =?us-ascii?Q?4KBYm2twRmMpTuUbDSF7eyK6RlevhBx79702UnCq7Nbczj0z6TndJZeimYGk?=
 =?us-ascii?Q?qFgDEilQWtJTEJSOA5Wcb4wvyCVtYLJ1eymMRDl/r+vffM9CBIa+XoAcOJF2?=
 =?us-ascii?Q?B1AtgMTJXtC26WpD+YqW0uhREWboQGAe0NgPGwLtrwSwfPLtQhps1rL1VKJC?=
 =?us-ascii?Q?PFS7+iXUyt/PMGLmhd6/bIpDu8+a1y8cU83u?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 18:31:16.4500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145ef9d8-6081-40ed-b447-08ddb41678d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714

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


