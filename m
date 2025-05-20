Return-Path: <linux-kselftest+bounces-33419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF0ABE2F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 20:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184164C4A6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 18:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594C8283FC0;
	Tue, 20 May 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jybB3m81"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270002836A5;
	Tue, 20 May 2025 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766417; cv=fail; b=SFGeh7QsnA/XQfulXGxY6T/5BYI5H8HpHs9BMGRWzEHuEBaK9JOMxmbn2mScHCvFByu0auLfeZA9YUHNZ2XdzwWA6J8V/qu57ZuvX4+6Zyfhp3IPmHO8I0chZcggCVRRtu34qC7NR+9p9DOTFnNzRJ8jMgN68weXuenDGuZUE5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766417; c=relaxed/simple;
	bh=Wvs9F6wn99YpZQrMegFW6AXz/ErQ/lGVTJ1jkM+wY70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFWVq+7yhbjqD+E2ApxH044pE2L14mD8wn8ew/SZLwCuQ7VMwhSY+SdcIINcMWY7OdDscMv7jq4Z/E13Pyf7OZFmptyc+Ntr7fK7E5Go1jPjVHrFCKkyJyRNDlAaKucJqa+ydTbID4TygiFKhs9kTlahqgvZwhNAdJIgOXqRO3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jybB3m81; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PY6NfLFEPECidky5E7+2h/QwKnyJ3qYJU4ImqzyFeP+q+LFrmrdikKYDgEAmp0qoYHG526FY3Spd3WQZFw8tD1HOrhEV+FvHlbmXj4MGgSvKj4mmqB9T2jYXSuesqq5h1AsNQchvMEsZhQ4+9eRTOE7YdMZmeNQe+OEj+BW3BT9z65tZ5naFfkMF/hDAN5raunfp29822Bt7eFcUrmZBDIsIUDHm3AdgFggPeVvIG1IfsRvo30hxlNIENMfub8kAc+STWAHHu5uVNHlhJ4gUmbETQ2xrvhmSgp85t6yAgh1+OAGei/gV+cagMeYXrye9g0wsprmVfaXJJANfvLA+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caQoorjCVhwmBFU5JFHozJBPBDsCzGqL7fnrtTloMHY=;
 b=FO64b/HYro5k008I3Bmbt9Z8eTyYJEw4q4XpfcnpqCCDvpKTL+0oFW0fFh1JCT4e9jEMKcAyItqq3Jpt4194LINN98De/Vc/+HJRl34jO4MVLG1qKPKp0RXbEALbXQlmHFmitBB1AliHQL3Cuhz+6onsNCaIIxeMcamGaLlivh5PGrUHdK09LDwWs5eL+XQpGObkJvjr9SYRhVR6Aweywr0YSSKxLmSm536MoE/sSM2ChbEwSd79+z2QJZr4XEDpMA/ZR9m7n2YR8xa6LuoEUBIFeLkqA1ofacWQdSFi6TE445Cz5IHEfphMCftkSG2SKvuZVkFfj97rHo1zQ+9y1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caQoorjCVhwmBFU5JFHozJBPBDsCzGqL7fnrtTloMHY=;
 b=jybB3m81F1PWNOm4oQayS3cuL0pc1H/Z7lkjLy2kVGyW7kFdCjXQXaI8D4WhdCGfznh91cO5UfIbyScDauGZbNtrceg3W1RgKKGrwOgQuDqnMuUepYLcLOj5MHlebIudiJ/EfthMuLzO6/71PRB3tBbmN0QsCj8bnrwNiFaib5WLoY4fazhreyotkOPtNdPA5F7EtMMohGVJW8TNR4hRh8njg1ZjMsmhvRPNuMA75TLskrliYweX9TSavW4b7aAOzQljo4wocNHdssVoBO+qA9o/rU+bZvaAqn0Pkd4/D9NW1lWxWUVAqgcGoKAammqWICbesD0mygtOVaTbXh/mQQ==
Received: from PH0PR07CA0039.namprd07.prod.outlook.com (2603:10b6:510:e::14)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 18:40:11 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::d7) by PH0PR07CA0039.outlook.office365.com
 (2603:10b6:510:e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 20 May 2025 18:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 18:40:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 May
 2025 11:39:55 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 20 May
 2025 11:39:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 20
 May 2025 11:39:48 -0700
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
Subject: [PATCH net-next V10 6/6] net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw
Date: Tue, 20 May 2025 21:38:07 +0300
Message-ID: <1747766287-950144-7-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1342dc-c68e-41e7-113d-08dd97cdc081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z1pSNpfGfGpSrco7Sj3bgi5LlPftgSPkRDVWRG7w9+P/+E9q74orvQkUf+/Y?=
 =?us-ascii?Q?F3m6maleAFW56AqOVA5PfjT6GzyAN/sbJJsaw+wLBMhSoDFQcWr4/n4+gX5K?=
 =?us-ascii?Q?7S/Kcab8xVObEpVVzjJXtBzlyoZA8oZb2B5+HLso1I1cGzO3FKkZryxc74F0?=
 =?us-ascii?Q?M9BHhwjwOgOrPFxx+sInSl4nYGXz7wNdPgAc5yoKV2BnAF8/XWytGHJbkuz+?=
 =?us-ascii?Q?8iksjx96vUU7GwItI2MwL3Sn2d8p7711jCZzpz+1t40Z0qRVuLCoKXbXR2oC?=
 =?us-ascii?Q?Fdv/HWHy2n9jADSWqEOHBhKa6Ud8kZ2TE4CLaX/AQj9T1rTX3OuUYatoI2rI?=
 =?us-ascii?Q?OFJap9AxSgTkMECkbGCgHhN+5KGkh90JajLDLFKSfvJLnHIhkGFr4fPGt1f5?=
 =?us-ascii?Q?BzwvYutF+7QyHN6QFkgObnAvGWzfIreuAVvlCNiJCw+mpkg6vgtdEyLnGHlw?=
 =?us-ascii?Q?Za77AEQpUueWQJ3wNxr6EnKaRRg685nNwDPHUL03cNAWYA8Sx7NZc8rzZf8l?=
 =?us-ascii?Q?vf0URl2lW556LsKH2eYY4+io3uRiUXZuZj6tC8HAcQlmCyl/mwhZ7X0ai0Jo?=
 =?us-ascii?Q?k0QB37DlAP+hq8SzYUgtdgCGlpbfyVg7d0X5v2MgoJGoXjq1tWTdmWAyOCP+?=
 =?us-ascii?Q?jXfcagNmO520yXHsEfA8HfT5jE83ZfMs7CXDIDCKeEjNW5F9X/8xV8nLpk7+?=
 =?us-ascii?Q?wVhlnJlrpFHDRF/GKtyItXC126UqCvYk4TmKsqe3zQbYrF3HUthAeY7YraI5?=
 =?us-ascii?Q?dPQz+5uoyImUNur87+T4nZm/UF9DHBa1F6OXD7fkYexdbF3LmBOwZS8YdIHM?=
 =?us-ascii?Q?TeROiqQ2QQPDrs/oKuFa2pVakUocCU+44u81TfdTQ55A+uygoof6TlvXc7OM?=
 =?us-ascii?Q?5m3aLOOWW3Jl7juQSknyT8DKFSCw7ZfAcjLotsBM4Aig4gan1ef9QgquEE+E?=
 =?us-ascii?Q?RBLt3CHph2g1Ql+DlXkoNBRpLk1xh5JjO0UgIvFIDmfX4GtY6CINdL8lzw9w?=
 =?us-ascii?Q?h4dYK/uEIygA1uUYSUthine0b4yMs9B/qlZE5nDr5H/pV2YKHA/Ysyl0wXnj?=
 =?us-ascii?Q?C9c9L0X2bTdty6YdEt3njP8fZp/pR2hmf7R2VAEYcMmi9u0Tqb0UFewsE1dB?=
 =?us-ascii?Q?Wf5HYUMKxHT6b2K1htOSfiNd+WCnF3DOMmrA7AQIcvguT1AlbabcQyilvw7K?=
 =?us-ascii?Q?vvSI2eRXF2xTPb7Nqfis1tZ0dF0XelinJ7a/Z8riZsWk1idKNagMYhO6rC0Y?=
 =?us-ascii?Q?xZHk46r1TD1rQpIVtHVn6C9xjHOzS1qwP3/ii8Vpv3fhox+GkdMihlOSj0vd?=
 =?us-ascii?Q?8FS7IzmrvHZDxJIR1Ndg9mo6k42dSqYgOCG+xVtAzcNiRXK5YYZ4yiyMpjBI?=
 =?us-ascii?Q?eX2xrlx7UOMqTgRIHIbED5aCweRTCW7DgXzwedM6HUwaUqcbHcoVN+gGtVZ0?=
 =?us-ascii?Q?n2phsvMCe+zv00iymYVFsNgv2QxDzegqf71hQjMD31NNQImanUFwdPXhtuLU?=
 =?us-ascii?Q?m3gxhwPcQnKb5dGoAamrR0xYtoYGsCMVpt1v?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 18:40:10.9349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1342dc-c68e-41e7-113d-08dd97cdc081
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for managing Traffic Class (TC) arbiter nodes and
associated vports TC nodes within the E-Switch QoS hierarchy. This
patch adds support for the new scheduling node type,
`SCHED_NODE_TYPE_VPORTS_TC_TSAR`, and implements full support for
setting tc-bw on both vports and nodes.

Key changes include:

- Introduced the new scheduling node type,
  `SCHED_NODE_TYPE_VPORTS_TC_TSAR`, for managing vports within the TC
  arbiter node.

- New helper functions for creating and destroying vports TC nodes
  under the TC arbiter.

- Updated the minimum rate normalization function to skip nodes of type
  `SCHED_NODE_TYPE_VPORTS_TC_TSAR`. Vports TC TSARs have bandwidth
  shares configured on them but not minimum rates, so their `min_rate`
  cannot be normalized.

- Implementation of `esw_qos_tc_arbiter_scheduling_setup()` and
  `esw_qos_tc_arbiter_scheduling_teardown()` for initializing and
  cleaning up TC arbiter scheduling elements. These functions now fully
  support tc-bw configuration on TC arbiter nodes.

- Added `esw_qos_tc_arbiter_get_bw_shares()` and
  `esw_qos_set_tc_arbiter_bw_shares()` to handle the settings of
  bandwidth shares for vports traffic class TSARs.

- Refactored `mlx5_esw_devlink_rate_node_tc_bw_set()` and
  `mlx5_esw_devlink_rate_leaf_tc_bw_set()` to fully support configuring
  tc-bw on devlink rate nodes and vports, respectively.

- Refactored `mlx5_esw_qos_node_update_parent()` to ensure that tc-bw
  configuration remains compatible with setting a parent on a rate
  node, preserving level hierarchy functionality.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 264 +++++++++++++++++-
 1 file changed, 257 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index dec3bed682b7..14aeb1999044 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -67,6 +67,7 @@ enum sched_node_type {
 	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
 	SCHED_NODE_TYPE_RATE_LIMITER,
 	SCHED_NODE_TYPE_VPORT_TC,
+	SCHED_NODE_TYPE_VPORTS_TC_TSAR,
 };
 
 static const char * const sched_node_type_str[] = {
@@ -75,6 +76,7 @@ static const char * const sched_node_type_str[] = {
 	[SCHED_NODE_TYPE_TC_ARBITER_TSAR] = "TC Arbiter TSAR",
 	[SCHED_NODE_TYPE_RATE_LIMITER] = "Rate Limiter",
 	[SCHED_NODE_TYPE_VPORT_TC] = "vport TC",
+	[SCHED_NODE_TYPE_VPORTS_TC_TSAR] = "vports TC TSAR",
 };
 
 struct mlx5_esw_sched_node {
@@ -187,6 +189,11 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 static void esw_qos_sched_elem_warn(struct mlx5_esw_sched_node *node, int err, const char *op)
 {
 	switch (node->type) {
+	case SCHED_NODE_TYPE_VPORTS_TC_TSAR:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s %s scheduling element failed (tc=%d,err=%d)\n",
+			 op, sched_node_type_str[node->type], node->tc, err);
+		break;
 	case SCHED_NODE_TYPE_VPORT_TC:
 		esw_warn(node->esw->dev,
 			 "E-Switch %s %s scheduling element failed (vport=%d,tc=%d,err=%d)\n",
@@ -376,7 +383,13 @@ static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
 		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
 			continue;
 
-		esw_qos_update_sched_node_bw_share(node, divider, extack);
+		/* Vports TC TSARs don't have a minimum rate configured,
+		 * so there's no need to update the bw_share on them.
+		 */
+		if (node->type != SCHED_NODE_TYPE_VPORTS_TC_TSAR) {
+			esw_qos_update_sched_node_bw_share(node, divider,
+							   extack);
+		}
 
 		if (list_empty(&node->children))
 			continue;
@@ -527,6 +540,144 @@ static void esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netlin
 	__esw_qos_free_node(node);
 }
 
+static int esw_qos_create_vports_tc_node(struct mlx5_esw_sched_node *parent,
+					 u8 tc, struct netlink_ext_ack *extack)
+{
+	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	struct mlx5_core_dev *dev = parent->esw->dev;
+	struct mlx5_esw_sched_node *vports_tc_node;
+	void *attr;
+	int err;
+
+	if (!mlx5_qos_element_type_supported(
+		dev,
+		SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
+		SCHEDULING_HIERARCHY_E_SWITCH) ||
+	    !mlx5_qos_tsar_type_supported(dev,
+					  TSAR_ELEMENT_TSAR_TYPE_DWRR,
+					  SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	vports_tc_node = __esw_qos_alloc_node(parent->esw, 0,
+					      SCHED_NODE_TYPE_VPORTS_TC_TSAR,
+					      parent);
+	if (!vports_tc_node) {
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc node failed");
+		esw_warn(dev, "Failed to alloc vports TC node (tc=%d)\n", tc);
+		return -ENOMEM;
+	}
+
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
+	MLX5_SET(tsar_element, attr, traffic_class, tc);
+	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id, parent->ix);
+	MLX5_SET(scheduling_context, tsar_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+
+	err = esw_qos_node_create_sched_element(vports_tc_node, tsar_ctx,
+						extack);
+	if (err)
+		goto err_create_sched_element;
+
+	vports_tc_node->tc = tc;
+
+	return 0;
+
+err_create_sched_element:
+	__esw_qos_free_node(vports_tc_node);
+	return err;
+}
+
+static void
+esw_qos_tc_arbiter_get_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node,
+				 u32 *tc_bw)
+{
+	struct mlx5_esw_sched_node *vports_tc_node;
+
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry)
+		tc_bw[vports_tc_node->tc] = vports_tc_node->bw_share;
+}
+
+static void
+esw_qos_set_tc_arbiter_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node,
+				 u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vports_tc_node;
+
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry) {
+		u32 bw_share;
+		u8 tc;
+
+		tc = vports_tc_node->tc;
+		bw_share = tc_bw[tc] ?: MLX5_MIN_BW_SHARE;
+		esw_qos_sched_elem_config(vports_tc_node, 0, bw_share, extack);
+	}
+}
+
+static void
+esw_qos_destroy_vports_tc_nodes(struct mlx5_esw_sched_node *tc_arbiter_node,
+				struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vports_tc_node, *tmp;
+
+	list_for_each_entry_safe(vports_tc_node, tmp,
+				 &tc_arbiter_node->children, entry)
+		esw_qos_destroy_node(vports_tc_node, extack);
+}
+
+static int
+esw_qos_create_vports_tc_nodes(struct mlx5_esw_sched_node *tc_arbiter_node,
+			       struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw = tc_arbiter_node->esw;
+	int err, i, num_tcs = esw_qos_num_tcs(esw->dev);
+
+	for (i = 0; i < num_tcs; i++) {
+		err = esw_qos_create_vports_tc_node(tc_arbiter_node, i, extack);
+		if (err)
+			goto err_tc_node_create;
+	}
+
+	return 0;
+
+err_tc_node_create:
+	esw_qos_destroy_vports_tc_nodes(tc_arbiter_node, NULL);
+	return err;
+}
+
+static int esw_qos_create_tc_arbiter_sched_elem(
+		struct mlx5_esw_sched_node *tc_arbiter_node,
+		struct netlink_ext_ack *extack)
+{
+	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	u32 tsar_parent_ix;
+	void *attr;
+
+	if (!mlx5_qos_tsar_type_supported(tc_arbiter_node->esw->dev,
+					  TSAR_ELEMENT_TSAR_TYPE_TC_ARB,
+					  SCHEDULING_HIERARCHY_E_SWITCH)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "E-Switch TC Arbiter scheduling element is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_TC_ARB);
+	tsar_parent_ix = tc_arbiter_node->parent ? tc_arbiter_node->parent->ix :
+			 tc_arbiter_node->esw->qos.root_tsar_ix;
+	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
+		 tsar_parent_ix);
+	MLX5_SET(scheduling_context, tsar_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+	MLX5_SET(scheduling_context, tsar_ctx, max_average_bw,
+		 tc_arbiter_node->max_rate);
+	MLX5_SET(scheduling_context, tsar_ctx, bw_share,
+		 tc_arbiter_node->bw_share);
+
+	return esw_qos_node_create_sched_element(tc_arbiter_node, tsar_ctx,
+						 extack);
+}
+
 static struct mlx5_esw_sched_node *
 __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sched_node *parent,
 				   struct netlink_ext_ack *extack)
@@ -591,6 +742,9 @@ static void __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netl
 {
 	struct mlx5_eswitch *esw = node->esw;
 
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		esw_qos_destroy_vports_tc_nodes(node, extack);
+
 	trace_mlx5_esw_node_qos_destroy(esw->dev, node, node->ix);
 	esw_qos_destroy_node(node, extack);
 	esw_qos_normalize_min_rate(esw, NULL, extack);
@@ -685,13 +839,38 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
 static void
 esw_qos_tc_arbiter_scheduling_teardown(struct mlx5_esw_sched_node *node,
 				       struct netlink_ext_ack *extack)
-{}
+{
+	/* Clean up all Vports TC nodes within the TC arbiter node. */
+	esw_qos_destroy_vports_tc_nodes(node, extack);
+	/* Destroy the scheduling element for the TC arbiter node itself. */
+	esw_qos_node_destroy_sched_element(node, extack);
+}
 
 static int esw_qos_tc_arbiter_scheduling_setup(struct mlx5_esw_sched_node *node,
 					       struct netlink_ext_ack *extack)
 {
-	NL_SET_ERR_MSG_MOD(extack, "TC arbiter elements are not supported.");
-	return -EOPNOTSUPP;
+	u32 curr_ix = node->ix;
+	int err;
+
+	err = esw_qos_create_tc_arbiter_sched_elem(node, extack);
+	if (err)
+		return err;
+	/* Initialize the vports TC nodes within created TC arbiter TSAR. */
+	err = esw_qos_create_vports_tc_nodes(node, extack);
+	if (err)
+		goto err_vports_tc_nodes;
+
+	node->type = SCHED_NODE_TYPE_TC_ARBITER_TSAR;
+
+	return 0;
+
+err_vports_tc_nodes:
+	/* If initialization fails, clean up the scheduling element
+	 * for the TC arbiter node.
+	 */
+	esw_qos_node_destroy_sched_element(node, NULL);
+	node->ix = curr_ix;
+	return err;
 }
 
 static int
@@ -1064,6 +1243,7 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 {
 	struct mlx5_esw_sched_node *curr_parent = vport->qos.sched_node->parent;
 	enum sched_node_type curr_type = vport->qos.sched_node->type;
+	u32 curr_tc_bw[DEVLINK_RATE_TCS_MAX] = {0};
 	int err;
 
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
@@ -1075,11 +1255,23 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
+		esw_qos_tc_arbiter_get_bw_shares(vport->qos.sched_node,
+						 curr_tc_bw);
+	}
+
 	esw_qos_vport_disable(vport, extack);
 
 	err = esw_qos_vport_enable(vport, type, parent, extack);
-	if (err)
+	if (err) {
 		esw_qos_vport_enable(vport, curr_type, curr_parent, NULL);
+		extack = NULL;
+	}
+
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
+		esw_qos_set_tc_arbiter_bw_shares(vport->qos.sched_node,
+						 curr_tc_bw, extack);
+	}
 
 	return err;
 }
@@ -1563,6 +1755,8 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 					   SCHED_NODE_TYPE_TC_ARBITER_TSAR,
 					   NULL, extack);
 	}
+	if (!err)
+		esw_qos_set_tc_arbiter_bw_shares(vport_node, tc_bw, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -1592,6 +1786,8 @@ int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
 	}
 
 	err = esw_qos_node_enable_tc_arbitration(node, extack);
+	if (!err)
+		esw_qos_set_tc_arbiter_bw_shares(node, tc_bw, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -1716,6 +1912,15 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 	return mlx5_esw_qos_vport_update_parent(vport, node, extack);
 }
 
+static bool esw_qos_is_node_empty(struct mlx5_esw_sched_node *node)
+{
+	return list_empty(&node->children) ||
+	       (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR &&
+		esw_qos_is_node_empty(
+			list_first_entry(&node->children,
+					 struct mlx5_esw_sched_node, entry)));
+}
+
 static int
 mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 				      struct mlx5_esw_sched_node *parent,
@@ -1729,13 +1934,26 @@ mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 		return -EOPNOTSUPP;
 	}
 
-	if (!list_empty(&node->children)) {
+	if (!esw_qos_is_node_empty(node)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Cannot reassign a node that contains rate objects");
 		return -EOPNOTSUPP;
 	}
 
+	if (parent && parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot attach a node to a parent with TC bandwidth configured");
+		return -EOPNOTSUPP;
+	}
+
 	new_level = parent ? parent->level + 1 : 2;
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+		/* Increase by one to account for the vports TC scheduling
+		 * element.
+		 */
+		new_level += 1;
+	}
+
 	max_level = 1 << MLX5_CAP_QOS(node->esw->dev, log_esw_max_sched_depth);
 	if (new_level > max_level) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -1746,6 +1964,32 @@ mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 	return 0;
 }
 
+static int
+esw_qos_tc_arbiter_node_update_parent(struct mlx5_esw_sched_node *node,
+				      struct mlx5_esw_sched_node *parent,
+				      struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_parent = node->parent;
+	u32 curr_tc_bw[DEVLINK_RATE_TCS_MAX] = {0};
+	struct mlx5_eswitch *esw = node->esw;
+	int err;
+
+	esw_qos_tc_arbiter_get_bw_shares(node, curr_tc_bw);
+	esw_qos_tc_arbiter_scheduling_teardown(node, extack);
+	esw_qos_node_set_parent(node, parent);
+	err = esw_qos_tc_arbiter_scheduling_setup(node, extack);
+	if (err) {
+		esw_qos_node_set_parent(node, curr_parent);
+		if (esw_qos_tc_arbiter_scheduling_setup(node, extack)) {
+			esw_warn(esw->dev, "Node restore QoS failed\n");
+			return err;
+		}
+	}
+	esw_qos_set_tc_arbiter_bw_shares(node, curr_tc_bw, extack);
+
+	return err;
+}
+
 static int esw_qos_vports_node_update_parent(struct mlx5_esw_sched_node *node,
 					     struct mlx5_esw_sched_node *parent,
 					     struct netlink_ext_ack *extack)
@@ -1791,7 +2035,13 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 
 	esw_qos_lock(esw);
 	curr_parent = node->parent;
-	err = esw_qos_vports_node_update_parent(node, parent, extack);
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+		err = esw_qos_tc_arbiter_node_update_parent(node, parent,
+							    extack);
+	} else {
+		err = esw_qos_vports_node_update_parent(node, parent, extack);
+	}
+
 	if (err)
 		goto out;
 
-- 
2.31.1


