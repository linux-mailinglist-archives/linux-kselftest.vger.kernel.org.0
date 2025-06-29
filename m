Return-Path: <linux-kselftest+bounces-36077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E893AECDE1
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 16:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3F63B263F
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 14:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A7A233735;
	Sun, 29 Jun 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mA7xU6n7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70233233707;
	Sun, 29 Jun 2025 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751206995; cv=fail; b=HnZi7Dm5Wnx4jGGFMy0rTD0aF2MoBvZbWlTTmO6sgPwOZLggIjOxelxrZNRT8nHtjsWs3PtkwJUpGnrP4+24OqTZJzBdLG4IUvxuj7VHoDXvj+ok3j8dm0JtuaFKbagzerzKHHAxwIn5mQ1haUilv+L6NPBba67ioBerNnsUze0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751206995; c=relaxed/simple;
	bh=MFsNjyRi5nF6NnjA8Nix9+V9IfdsYzMDKjal3ubkh5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phwWXx19QI/ayoF5dU86CfPjLq3PFmnhjP6VYG/lLlRCdcKFU0yo10DfwPUf0IoLPMtB3HbDqvF1WcFLHAvRHKOzg2UWuZk/EZP8kcu+HqxB//AEabAWu04yDCvTXyKfP72DOIvqTBuqqYEZee4J+W7CKi27WFLQeh34bhCbNrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mA7xU6n7; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAjslwo6klmUnsMaprwaDR9o783R9bpiLmNOWCNAU4qNrqaf2HJruC+EcSeV06N2lS6NDmjclFUf4R0+Uw1wPiyUyqC1PVaGvQEBfIw7C2MbrPI38oZ4ZofgfUkSMJfkQi44IdoDkU5T83dZmBeyxpgwILTJ2agitHi9+JEprjjBBJIufgLIqYwurV00fWhbe3+RpTrJux5Z04XnBuHmi05Y3UkBmeKxpZrl2L4ZwwQ9u9HvHRN5vr4X048v4LSGtjD6NYqdv3b6KODjGQcKg9NBh1XS1xKOWKT3pkJ8LvcQtzebUvuARHaziR+W24pwdpKO0laylMNfsPZkp0jYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psGtrQZSNqIuTjwMI6w1BKfzwlY0y2cYqDKOJzEadPc=;
 b=FCSdzI33OpVCDz3/JaqGxuM6rxcKUyo4FvGddOlnwO1UwZozfT153FfTrHSDcZiqwA7Hrp+QHhYrSWIM01GztGN9o1v8blpSQUqPxzI3VNdpNQsz/FlabCh0grDGzYk0E4o69TB432ZZdU2YPM4yJiy1qBTSlKeG/kFjoved+GcEFmlwiSYGWlbuBsDF7ESBrAHuTHnLiv1CamibCmpNlJEK4de8W9fPJbeW81mTXq9GZx06D3MQRSK+AqC73ZDbRR1BxL6Pbiaexpf7mZHRqh9ZjoctP6rvBwHG8SOmePN+IpwlokN3TFX+rcD3YeX3fTuxpc+L3IQvmCsRIVeS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psGtrQZSNqIuTjwMI6w1BKfzwlY0y2cYqDKOJzEadPc=;
 b=mA7xU6n7UIHa00DqZXqvczZWRz8hWtynkoJRTsoaPP9Tevj9rng+dCuXPQzHEiskMIPtgfD+psxK2K6fkDKakH764j8kKCJ878WbpGI3lui+pQRBAZUR7FVaQcNQsSB0afoycixiZUiuR11aMN5KU8xvWNGklG8thi5bD114p+ZQ7FdRRaw/lzHYuDPYDU0/REsBHlECV4BAFlPwnPCcCKrcANcAkelFlzPpt30K+WjQA7cr1V7muzUbOfDu/hTtPreXGzNybZREwmEB93pcIK0hEQyeFgnrgVFyIvqnzwuX+gEjCJclM2u3Jmk69292R46c+vfQjZA7heS93CIRsw==
Received: from SJ0PR13CA0199.namprd13.prod.outlook.com (2603:10b6:a03:2c3::24)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Sun, 29 Jun
 2025 14:23:06 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::f) by SJ0PR13CA0199.outlook.office365.com
 (2603:10b6:a03:2c3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.13 via Frontend Transport; Sun,
 29 Jun 2025 14:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 14:23:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 07:22:53 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 07:22:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 29
 Jun 2025 07:22:46 -0700
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
Subject: [PATCH net-next v12 7/8] net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw
Date: Sun, 29 Jun 2025 17:21:37 +0300
Message-ID: <20250629142138.361537-8-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: e9040edf-e46d-498b-a3c5-08ddb7187748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3hOWuLI5v3rAjwakkwPkNinSdLxk+GaAAcO/PRm5il/UnOY6rF8xwaNC6ef2?=
 =?us-ascii?Q?kWOhwDfY6H37sVQv01JzrWL600EA7OjUr91gDWglndh2y1+rcZ861GloutSg?=
 =?us-ascii?Q?aCs/aiPdEeAbLow0GFbCznb2GJpDws/i7xWonLuvgVUocBLEPpH7tkPhXWCE?=
 =?us-ascii?Q?R/CJdd+GLo+0TKtzJW213rtxVX3paVXzXn4EZnWrX5c6jFlOrcmUk+XdIzvc?=
 =?us-ascii?Q?jvzsO55oZi6Wbssom0K4wW8YINRWgQ+uUdsXGpGed7UzeaUd1+FApjJgxsRi?=
 =?us-ascii?Q?gsw+FgbTIGooeDXYkpJwSUnD4jI0NTKFek/e2qffmZJJwqGT77VQWybtQE4g?=
 =?us-ascii?Q?+xjeEOEbK1PHN8FFr4jxtY844wwe/61R+9rFEduUXnieuyU1i5qtDw3w25D/?=
 =?us-ascii?Q?sLjAGg3gPHUcLlQHePwXloSl/W/jkq+MfiReEC4aUB4TmzrwGQmXUERMLm52?=
 =?us-ascii?Q?FSbsvp2Z1CPHATymo+GPVsRiOnLuDvKfMGK6Y3AMt1mN8xsb2s63vC2WhY5N?=
 =?us-ascii?Q?PnIAficPQCvZHxyGptNS1PRLzhfRoP3Uly+7Fve6ngcqehZcHF1UvQmqulUT?=
 =?us-ascii?Q?GoNs7BwKLX40+ptEUKRkNzC+aAqxvZLQg6BvvPYgiD8nR9jfDl9bh83LoXC9?=
 =?us-ascii?Q?DDsLGJoGEJhhjVq9oFf+5t/tXnYcayJzdH51hpJ8hFqbP1hr8+oOnTwVasu5?=
 =?us-ascii?Q?4JW7IRVV0rS3P191lGsubm+sDvKD6S+4DhB8cJRtzgshV2RofDOSnf6i2L/B?=
 =?us-ascii?Q?Mdip2v/h9XlsqAUoHSBMbeO7tohJDUZbOJsStiZHj0VErr5/oZeCJGYUb/QP?=
 =?us-ascii?Q?oiUehZ4/DPyEAWplioAOAYumMJoFfj/mcjMMWN/ytzoK9F/j7YDZ7+yLu/mr?=
 =?us-ascii?Q?xsdu+BDNRKNWrthrZcRmkguthAgDs9ok34cL6+Psy4ymXYuC3UPtYL+yg90L?=
 =?us-ascii?Q?97RVV1NtLcY2MJUOKtDJtg2lN/iEttmMz31g3R7r21CMV6Trj1GwMj0B3vn5?=
 =?us-ascii?Q?szeqH6/764P1v+RxECqqC6h6xDk3oxGgiaacYw4CryWL5S1/DkHkGiR2VdGM?=
 =?us-ascii?Q?cUJlFpssFfz4H5HQFSm7BNF6NPwc6ZbwK56YzOpx2CtudxVPT7wyGEdQDJlX?=
 =?us-ascii?Q?ZijHnbmwisNfHYcWOkBw11n6E0qh/qtED1ufARTWURHSFyt7jn5IFVcM4nN9?=
 =?us-ascii?Q?hiF49wczBPaWlC799BxJjO9Wv0W0Ry5zDIhZDcMzI+HXkWSsaYMepfFeJYoK?=
 =?us-ascii?Q?nNI+Zy+/8l6OdR5rl5ROp1kt/9ke12+qGW2Cc+u2Ac0dUt6INGJD5QnVvMA6?=
 =?us-ascii?Q?ok94cA+udQwlUF+mz8Q16gATBN68kNQzQ34HKD5YxijysbFfXWPJzv64mosh?=
 =?us-ascii?Q?U27bfPGE78PkzS3ZykbqT8Oy0bWwj9yFFqI22x/B2d3XduHAGkMr9B4mqWZt?=
 =?us-ascii?Q?lwHRPWpeeto3VrMqX7ZGvy1y3VaeQ/Np9SR4qOsKLF7Kjzfw2gYNw09tjwJV?=
 =?us-ascii?Q?xX3eE0h8iIoJmEv+7CuZnA+WVHBBjMXW1ezd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 14:23:06.3865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9040edf-e46d-498b-a3c5-08ddb7187748
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051

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

- Introduced a new helper `esw_qos_calculate_tc_bw_divider()` to
  compute the total TC bandwidth share, which is used as a divider for
  normalizing each TC's share.

- Added `esw_qos_tc_arbiter_get_bw_shares()` and
  `esw_qos_set_tc_arbiter_bw_shares()` to handle the settings of
  bandwidth shares for vports traffic class TSARs.

- `esw_qos_set_tc_arbiter_bw_shares()` normalizes  each TC share based
  on the total and the firmware's maximum allowed TSAR bandwidth share.

- Refactored `mlx5_esw_devlink_rate_node_tc_bw_set()` and
  `mlx5_esw_devlink_rate_leaf_tc_bw_set()` to fully support configuring
  tc-bw on devlink rate nodes and vports, respectively.

- Refactored `mlx5_esw_qos_node_update_parent()` to ensure that tc-bw
  configuration remains compatible with setting a parent on a rate
  node, preserving level hierarchy functionality.

- Refactored `esw_qos_calc_bw_share()` to generalize its input so it
  can be used for both minimum rate and bandwidth share calculations.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 294 +++++++++++++++++-
 1 file changed, 285 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index dec3bed682b7..154bbb17ec0e 100644
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
@@ -345,11 +352,13 @@ static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
 	return 0;
 }
 
-static u32 esw_qos_calc_bw_share(u32 min_rate, u32 divider, u32 fw_max)
+static u32 esw_qos_calc_bw_share(u32 value, u32 divider, u32 fw_max)
 {
 	if (!divider)
 		return 0;
-	return min_t(u32, max_t(u32, DIV_ROUND_UP(min_rate, divider), MLX5_MIN_BW_SHARE), fw_max);
+	return min_t(u32, fw_max,
+		     max_t(u32,
+			   DIV_ROUND_UP(value, divider), MLX5_MIN_BW_SHARE));
 }
 
 static void esw_qos_update_sched_node_bw_share(struct mlx5_esw_sched_node *node,
@@ -376,7 +385,13 @@ static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
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
@@ -385,6 +400,20 @@ static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
 	}
 }
 
+static u32 esw_qos_calculate_tc_bw_divider(u32 *tc_bw)
+{
+	u32 total = 0;
+	int i;
+
+	for (i = 0; i < DEVLINK_RATE_TCS_MAX; i++)
+		total += tc_bw[i];
+
+	/* If total is zero, tc-bw config is disabled and we shouldn't reach
+	 * here.
+	 */
+	return WARN_ON(!total) ? 1 : total;
+}
+
 static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 				     u32 min_rate, struct netlink_ext_ack *extack)
 {
@@ -527,6 +556,149 @@ static void esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netlin
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
+	struct mlx5_eswitch *esw = tc_arbiter_node->esw;
+	struct mlx5_esw_sched_node *vports_tc_node;
+	u32 divider, fw_max_bw_share;
+
+	fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
+	divider = esw_qos_calculate_tc_bw_divider(tc_bw);
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry) {
+		u8 tc = vports_tc_node->tc;
+		u32 bw_share;
+
+		bw_share = tc_bw[tc] * fw_max_bw_share;
+		bw_share = esw_qos_calc_bw_share(bw_share, divider,
+						 fw_max_bw_share);
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
@@ -591,6 +763,9 @@ static void __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netl
 {
 	struct mlx5_eswitch *esw = node->esw;
 
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		esw_qos_destroy_vports_tc_nodes(node, extack);
+
 	trace_mlx5_esw_node_qos_destroy(esw->dev, node, node->ix);
 	esw_qos_destroy_node(node, extack);
 	esw_qos_normalize_min_rate(esw, NULL, extack);
@@ -685,13 +860,38 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
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
@@ -1064,6 +1264,7 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 {
 	struct mlx5_esw_sched_node *curr_parent = vport->qos.sched_node->parent;
 	enum sched_node_type curr_type = vport->qos.sched_node->type;
+	u32 curr_tc_bw[DEVLINK_RATE_TCS_MAX] = {0};
 	int err;
 
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
@@ -1075,11 +1276,23 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
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
@@ -1563,6 +1776,8 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 					   SCHED_NODE_TYPE_TC_ARBITER_TSAR,
 					   NULL, extack);
 	}
+	if (!err)
+		esw_qos_set_tc_arbiter_bw_shares(vport_node, tc_bw, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -1592,6 +1807,8 @@ int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
 	}
 
 	err = esw_qos_node_enable_tc_arbitration(node, extack);
+	if (!err)
+		esw_qos_set_tc_arbiter_bw_shares(node, tc_bw, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -1716,6 +1933,20 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 	return mlx5_esw_qos_vport_update_parent(vport, node, extack);
 }
 
+static bool esw_qos_is_node_empty(struct mlx5_esw_sched_node *node)
+{
+	if (list_empty(&node->children))
+		return true;
+
+	if (node->type != SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		return false;
+
+	node = list_first_entry(&node->children, struct mlx5_esw_sched_node,
+				entry);
+
+	return esw_qos_is_node_empty(node);
+}
+
 static int
 mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 				      struct mlx5_esw_sched_node *parent,
@@ -1729,13 +1960,26 @@ mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
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
@@ -1746,6 +1990,32 @@ mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
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
@@ -1791,7 +2061,13 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 
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
2.34.1


