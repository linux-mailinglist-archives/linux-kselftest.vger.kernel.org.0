Return-Path: <linux-kselftest+bounces-36076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CFBAECDDD
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 16:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEA016A456
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 14:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16E22836C;
	Sun, 29 Jun 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AMSmXJK8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38E6230BF6;
	Sun, 29 Jun 2025 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751206990; cv=fail; b=Oy378M4ke5bMhvdjGpngCKFhYX2+6ycMKXImUz2tw7wgh/HzdMqbePdjKTrY5QaO9wvDea/JOcnUMnrds6f2GBCHVzsUTQJytmf7mjtRgc84axgVXzUvZvIG5GycYC7Ke54t833ajJAcWENvJHqtY4DOENxQXNNSG9kJHyN+6Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751206990; c=relaxed/simple;
	bh=e/MIf0qW0lH/UaWW9vXpjq5AP16KmJl2TjvYh6d05fU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6n8XbVqfGQG0TXv9XqMQ3WtXvyAXxziwD/IkFjGjrJPM85kiqgP5Aogp+Gu6IrWnqYNZKHoYAqGijJiFhJfNZs8Jd6Vnsz+tik/Vw4yx6gxoY7DZqh8mJ/KUROd2dNpr5Tk4+dpj2R1ZPPOeUG5PgLopFvRUYbO43W65s1k58o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AMSmXJK8; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6wxmlwbr4q7wGIBaM7NQLjv3FwFYhJG57XCQPPKGQXctZHP9Zxsq/dV0yrZbFJqRB2eJSBqSqx7RCPr5EkY0BEquw+VolEVoUucvUgPUqZps/FmA81LTj2JwAW8PZYiEyBITt3OfQH6wNBGlYg9vt/2+Y5SvR6hk7zD4bNVXZ1sw2OhMZN38ExobTUCM6DBdC41bn6uc4pK+18LzjWi/RYyhvzhuRzHwnOkSkKz1B/Yms83FkSp1FJcCktcJqF/0nz3UAidPs019MWoBnLvxvoxYyJIbs/+9lxwpHPByJW39G4oOA+yWwZwQ0NIpC/CBF44h7lA/LpXeQXJrVLkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyzYuDRrG8etvNB+V7kh342MiaK1T2ZXQuYhkOfcqmA=;
 b=gxWlPAK6xoJWM0jpC/uOxjWd6BpOxZi1oTuGVULYMZmueE5lRgBsC0OWKa+srDeuenMSh2p3O5s9e+zQDc60nCL8iW+/4J9EgmOLkd69ooUouqkkUgdUavmfEiUY3MACPtaJBgpZ/Y7cIvpNCRo8NG/70pTyBEegLkumh6sF9B6VP5ETyeUIPo5jLURKPrxsxpUhjQ15idgsWyGmzxd5+e2aqVYDKUABAjH/NYUPH/oqPHSygwrRaXxQGFdBzoV7ew1DAFSqK7faYTLkZgfyt+pGRy+3bH2tZlQitd5Djcia4Cq5dyPLoyvwPFsDdyEVEHfbbatwlkmC3uFTF9A7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyzYuDRrG8etvNB+V7kh342MiaK1T2ZXQuYhkOfcqmA=;
 b=AMSmXJK895uzxU/JpWvHiNFblz+qzBxQ3hUuWr3lRxsUSQQqP4lvQLaYZStd8JJi76i1LA2v+vqafgyNb3NlhyqboE5q3Fp72SWkzLZlM6RpNUNDI3+02rCU9xOA9ARrxVl24lKNa6QfnROQUJ+gmC9w6WFZ/f5BfZ/RYVVA125SF6DuLjFds4kWTDU1qC0WPhr8wS0ye4aELCqo3Ox2rHkpTVgt8WckzzTorv1fsK1nYNFHxsikXgJHfCnaYgLMsqlVPppdHY7KOS0TIr3y3Q92o9STlc+Ky9hQKlw1sHgOM5A5hJXLVcymj8YqoUXP7yoL3MesaxPQZ8um9gI0XA==
Received: from BN8PR07CA0004.namprd07.prod.outlook.com (2603:10b6:408:ac::17)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Sun, 29 Jun
 2025 14:22:58 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:ac:cafe::dd) by BN8PR07CA0004.outlook.office365.com
 (2603:10b6:408:ac::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Sun,
 29 Jun 2025 14:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 14:22:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 07:22:46 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 07:22:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 29
 Jun 2025 07:22:39 -0700
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
Subject: [PATCH net-next v12 6/8] net/mlx5: Add traffic class scheduling support for vport QoS
Date: Sun, 29 Jun 2025 17:21:36 +0300
Message-ID: <20250629142138.361537-7-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f71b356-149c-4ec6-7d3d-08ddb718720a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Z47n8ajY0q2uD7dQaWaokjW5M+V2uNXI6V1Eu7lKg53qF4ZS2V7Dy9yck5I?=
 =?us-ascii?Q?pcBaMM5VBOROpcvDJpmD4l8EYpHOSYGfJHaBqsVxVPg8+U16Ytf0hqGS1v/E?=
 =?us-ascii?Q?iH0ou2ZmEed7xoYdgQvcFQeDmYfBXl7bARuS39ZoSlDX5+DsQa0WPgOO8W9J?=
 =?us-ascii?Q?Oem+ICdLt7c4SyWgwdA2wYeNtb6O8SZ8l+aoJ1doYEmEnr0ZQuK2e5pp7SPU?=
 =?us-ascii?Q?QaRW2r64A0KozHvBhT0b/1IwWxKya85rC0Lg8t9Lak/PEzk8Ao2AT/7pmnAk?=
 =?us-ascii?Q?UR00kPVky1MqBiE5LK1S3QHp04jxwandOr0to/csBXpm6vUZbIi2Zc0LHFuz?=
 =?us-ascii?Q?ImaVv608jRVDLlvcSbPYJ4qvN0ANEIzszXF8gJiasXVs3NFbt3tg6nBQQBWp?=
 =?us-ascii?Q?UYNfOK3mmT/FUabpE9oyGx4qBnBaSOIdRRpHFwe5AvPiCAKMUYgasYTa3uoa?=
 =?us-ascii?Q?J5vUMMm1vF3bq9v0ybLO1YzgcYW+C4kvM6bWd/KXcVFycpaHHKQ0s3haNijs?=
 =?us-ascii?Q?gFOzjfa6OLVRywIMe0QlB6f3a2e237X5I7BHPOsKOPEtP/J7tcNmwWjUxAdS?=
 =?us-ascii?Q?Yrj1XSqzEGgnFcZo6MD13LCNW0Wj9UC21Hx6ouYz38Hw0sQE4F90zlfSm1gB?=
 =?us-ascii?Q?DAdLvs2gptA7Gw5hAy4HceUF1GzTTAic7kO82i/WDmN3Clo+gx6zrrkT/hYy?=
 =?us-ascii?Q?QAQWIXGw6hLFOt+vWAtFzRWUN7GZXogvajoHunhNteVa11nAG25Wux3b7Asv?=
 =?us-ascii?Q?EY51/88DSinqpJQVvsWpkRP2dU1qofnyPCisQpHikZw87TnIumYZZMmmdkjQ?=
 =?us-ascii?Q?Yo7DSDUTPMVDO9g1AFFV805bYknaDvNoJu9WhZq+zmk/j8wWvuRu2TPjd93N?=
 =?us-ascii?Q?SuRM8EAAqX6u1o9giau7aovUPtJUtk/vN5qvrMdr4w7aJ3x1oR3Llr5OTRe4?=
 =?us-ascii?Q?AnVQN8Xi6W9d3kLZGhb6SYdu5m8uLWTd10kD5MBpZMemhGMbRknUviESfBum?=
 =?us-ascii?Q?enB02qEqyZGchJENXbPkA3ntHEMz2EBAKtPM1OVvIeAXYmMAhQ25tmavdEdf?=
 =?us-ascii?Q?gEZFzv/0i8LwIyp+q/km1krsylFCM67GuyH7VAxB7mrJY565WgWaOspMlQBh?=
 =?us-ascii?Q?0YXtZMVws4gmIJpkYXFWNRZX8uuClb+xZ0IqOc774e4QKbv/iYT6wXHElcXG?=
 =?us-ascii?Q?LswlCZQ2R4N0jME2ZS3hRdHfL5D01Tt0ZWkaSqbnwK9+n6Zcs/BnvXh8tj0d?=
 =?us-ascii?Q?HnqESbAZRL1G2vc5BS6f+A9pp/SJXZj/1oRXtJiv7XpIy46vXQwDHS1G5ITI?=
 =?us-ascii?Q?OstMol2TPEoYueeisKulDz584AsQqF113eX195w8zsL95fDTO6nTNjtJxtMp?=
 =?us-ascii?Q?6Tl1eXw51Yn3iws/yw7lXkr7m/VpjZFkmAyxx9aXByWFGA0wLi61oUYZGNFX?=
 =?us-ascii?Q?eUNEMtuVpN1JmBXcPIzoUwZMd5VnES28KVotcChJBj3Gw4HWUJ9MAAPE131G?=
 =?us-ascii?Q?DlSsexvL4TQEeo6YWKF4ivHuTfvTT0O1kFFk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 14:22:57.5126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f71b356-149c-4ec6-7d3d-08ddb718720a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for traffic class (TC) scheduling on vports by
allowing the vport to own multiple TC scheduling nodes. This patch
enables more granular control of QoS by defining three distinct QoS
states for vports, each providing unique scheduling behavior:

1. Regular QoS: The `sched_node` represents the vport directly,
   handling QoS as a single scheduling entity.
2. TC QoS on the vport: The `sched_node` acts as a TC arbiter, enabling
   TC scheduling directly on the vport.
3. TC QoS on the parent node: The `sched_node` functions as a rate
   limiter, with TC arbitration enabled at the parent level, associating
   multiple scheduling nodes with each vport.

Key changes include:

- Added support for new scheduling elements, vport traffic class and
  rate limiter.

- New helper functions for creating, destroying, and restoring vport TC
  scheduling nodes, handling transitions between regular QoS and TC
  arbitration states.

- Updated `esw_qos_vport_enable()` and `esw_qos_vport_disable()` to
  support both regular QoS and TC arbitration states, ensuring consistent
  transitions between scheduling modes.

- Introduced a `sched_nodes` array under `vport->qos` to store multiple
  TC scheduling nodes per vport, enabling finer control over per-TC QoS.

- Enhanced `esw_qos_vport_update_parent()` to handle transitions between
  the three QoS states based on the current and new parent node types.

This patch lays the groundwork for future support for configuring tc-bw
on vports. Although the infrastructure is in place, full support for
tc-bw is not yet implemented; attempts to set tc-bw on vports will
return `-EOPNOTSUPP`.

No functional changes are introduced at this stage.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 438 ++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  14 +-
 2 files changed, 422 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 1066992c1503..dec3bed682b7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -65,12 +65,16 @@ enum sched_node_type {
 	SCHED_NODE_TYPE_VPORTS_TSAR,
 	SCHED_NODE_TYPE_VPORT,
 	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
+	SCHED_NODE_TYPE_RATE_LIMITER,
+	SCHED_NODE_TYPE_VPORT_TC,
 };
 
 static const char * const sched_node_type_str[] = {
 	[SCHED_NODE_TYPE_VPORTS_TSAR] = "vports TSAR",
 	[SCHED_NODE_TYPE_VPORT] = "vport",
 	[SCHED_NODE_TYPE_TC_ARBITER_TSAR] = "TC Arbiter TSAR",
+	[SCHED_NODE_TYPE_RATE_LIMITER] = "Rate Limiter",
+	[SCHED_NODE_TYPE_VPORT_TC] = "vport TC",
 };
 
 struct mlx5_esw_sched_node {
@@ -94,6 +98,8 @@ struct mlx5_esw_sched_node {
 	struct mlx5_vport *vport;
 	/* Level in the hierarchy. The root node level is 1. */
 	u8 level;
+	/* Valid only when this node represents a traffic class. */
+	u8 tc;
 };
 
 static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *node)
@@ -148,6 +154,15 @@ static void esw_qos_nodes_set_parent(struct list_head *nodes,
 
 void mlx5_esw_qos_vport_qos_free(struct mlx5_vport *vport)
 {
+	if (vport->qos.sched_nodes) {
+		int num_tcs = esw_qos_num_tcs(vport->qos.sched_node->esw->dev);
+		int i;
+
+		for (i = 0; i < num_tcs; i++)
+			kfree(vport->qos.sched_nodes[i]);
+		kfree(vport->qos.sched_nodes);
+	}
+
 	kfree(vport->qos.sched_node);
 	memset(&vport->qos, 0, sizeof(vport->qos));
 }
@@ -172,11 +187,19 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 static void esw_qos_sched_elem_warn(struct mlx5_esw_sched_node *node, int err, const char *op)
 {
 	switch (node->type) {
+	case SCHED_NODE_TYPE_VPORT_TC:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s %s scheduling element failed (vport=%d,tc=%d,err=%d)\n",
+			 op,
+			 sched_node_type_str[node->type],
+			 node->vport->vport, node->tc, err);
+		break;
 	case SCHED_NODE_TYPE_VPORT:
 		esw_warn(node->esw->dev,
 			 "E-Switch %s %s scheduling element failed (vport=%d,err=%d)\n",
 			 op, sched_node_type_str[node->type], node->vport->vport, err);
 		break;
+	case SCHED_NODE_TYPE_RATE_LIMITER:
 	case SCHED_NODE_TYPE_TC_ARBITER_TSAR:
 	case SCHED_NODE_TYPE_VPORTS_TSAR:
 		esw_warn(node->esw->dev,
@@ -271,6 +294,24 @@ static int esw_qos_sched_elem_config(struct mlx5_esw_sched_node *node, u32 max_r
 	return 0;
 }
 
+static int esw_qos_create_rate_limit_element(struct mlx5_esw_sched_node *node,
+					     struct netlink_ext_ack *extack)
+{
+	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+
+	if (!mlx5_qos_element_type_supported(
+		node->esw->dev,
+		SCHEDULING_CONTEXT_ELEMENT_TYPE_RATE_LIMIT,
+		SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, node->max_rate);
+	MLX5_SET(scheduling_context, sched_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_RATE_LIMIT);
+
+	return esw_qos_node_create_sched_element(node, sched_ctx, extack);
+}
+
 static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
 					      struct mlx5_esw_sched_node *parent)
 {
@@ -388,28 +429,64 @@ esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_element_id,
 						  tsar_ix);
 }
 
-static int esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
-					      struct netlink_ext_ack *extack)
+static int
+esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
+				   struct netlink_ext_ack *extack)
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_node->esw->dev;
 	void *attr;
 
-	if (!mlx5_qos_element_type_supported(dev,
-					     SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT,
-					     SCHEDULING_HIERARCHY_E_SWITCH))
+	if (!mlx5_qos_element_type_supported(
+		dev,
+		SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT,
+		SCHEDULING_HIERARCHY_E_SWITCH))
 		return -EOPNOTSUPP;
 
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
 	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
-	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, vport_node->parent->ix);
-	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, vport_node->max_rate);
+	MLX5_SET(scheduling_context, sched_ctx, parent_element_id,
+		 vport_node->parent->ix);
+	MLX5_SET(scheduling_context, sched_ctx, max_average_bw,
+		 vport_node->max_rate);
 
 	return esw_qos_node_create_sched_element(vport_node, sched_ctx, extack);
 }
 
+static int
+esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
+				      u32 rate_limit_elem_ix,
+				      struct netlink_ext_ack *extack)
+{
+	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	struct mlx5_core_dev *dev = vport_tc_node->esw->dev;
+	void *attr;
+
+	if (!mlx5_qos_element_type_supported(
+		dev,
+		SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC,
+		SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(scheduling_context, sched_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC);
+	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
+	MLX5_SET(vport_tc_element, attr, vport_number,
+		 vport_tc_node->vport->vport);
+	MLX5_SET(vport_tc_element, attr, traffic_class, vport_tc_node->tc);
+	MLX5_SET(scheduling_context, sched_ctx, max_bw_obj_id,
+		 rate_limit_elem_ix);
+	MLX5_SET(scheduling_context, sched_ctx, parent_element_id,
+		 vport_tc_node->parent->ix);
+	MLX5_SET(scheduling_context, sched_ctx, bw_share,
+		 vport_tc_node->bw_share);
+
+	return esw_qos_node_create_sched_element(vport_tc_node, sched_ctx,
+						 extack);
+}
+
 static struct mlx5_esw_sched_node *
 __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
 		     struct mlx5_esw_sched_node *parent)
@@ -617,12 +694,202 @@ static int esw_qos_tc_arbiter_scheduling_setup(struct mlx5_esw_sched_node *node,
 	return -EOPNOTSUPP;
 }
 
+static int
+esw_qos_create_vport_tc_sched_node(struct mlx5_vport *vport,
+				   u32 rate_limit_elem_ix,
+				   struct mlx5_esw_sched_node *vports_tc_node,
+				   struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	struct mlx5_esw_sched_node *vport_tc_node;
+	u8 tc = vports_tc_node->tc;
+	int err;
+
+	vport_tc_node = __esw_qos_alloc_node(vport_node->esw, 0,
+					     SCHED_NODE_TYPE_VPORT_TC,
+					     vports_tc_node);
+	if (!vport_tc_node)
+		return -ENOMEM;
+
+	vport_tc_node->min_rate = vport_node->min_rate;
+	vport_tc_node->tc = tc;
+	vport_tc_node->vport = vport;
+	err = esw_qos_vport_tc_create_sched_element(vport_tc_node,
+						    rate_limit_elem_ix,
+						    extack);
+	if (err)
+		goto err_out;
+
+	vport->qos.sched_nodes[tc] = vport_tc_node;
+
+	return 0;
+err_out:
+	__esw_qos_free_node(vport_tc_node);
+	return err;
+}
+
+static void
+esw_qos_destroy_vport_tc_sched_elements(struct mlx5_vport *vport,
+					struct netlink_ext_ack *extack)
+{
+	int i, num_tcs = esw_qos_num_tcs(vport->qos.sched_node->esw->dev);
+
+	for (i = 0; i < num_tcs; i++) {
+		if (vport->qos.sched_nodes[i]) {
+			__esw_qos_destroy_node(vport->qos.sched_nodes[i],
+					       extack);
+		}
+	}
+
+	kfree(vport->qos.sched_nodes);
+	vport->qos.sched_nodes = NULL;
+}
+
+static int
+esw_qos_create_vport_tc_sched_elements(struct mlx5_vport *vport,
+				       enum sched_node_type type,
+				       struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	struct mlx5_esw_sched_node *tc_arbiter_node, *vports_tc_node;
+	int err, num_tcs = esw_qos_num_tcs(vport_node->esw->dev);
+	u32 rate_limit_elem_ix;
+
+	vport->qos.sched_nodes = kcalloc(num_tcs,
+					 sizeof(struct mlx5_esw_sched_node *),
+					 GFP_KERNEL);
+	if (!vport->qos.sched_nodes) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Allocating the vport TC scheduling elements failed.");
+		return -ENOMEM;
+	}
+
+	rate_limit_elem_ix = type == SCHED_NODE_TYPE_RATE_LIMITER ?
+			     vport_node->ix : 0;
+	tc_arbiter_node = type == SCHED_NODE_TYPE_RATE_LIMITER ?
+			   vport_node->parent : vport_node;
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry) {
+		err = esw_qos_create_vport_tc_sched_node(vport,
+							 rate_limit_elem_ix,
+							 vports_tc_node,
+							 extack);
+		if (err)
+			goto err_create_vport_tc;
+	}
+
+	return 0;
+
+err_create_vport_tc:
+	esw_qos_destroy_vport_tc_sched_elements(vport, NULL);
+
+	return err;
+}
+
+static int
+esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
+			struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	int err, new_level, max_level;
+
+	if (type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+		/* Increase the parent's level by 2 to account for both the
+		 * TC arbiter and the vports TC scheduling element.
+		 */
+		new_level = vport_node->parent->level + 2;
+		max_level = 1 << MLX5_CAP_QOS(vport_node->esw->dev,
+					      log_esw_max_sched_depth);
+		if (new_level > max_level) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "TC arbitration on leafs is not supported beyond max scheduling depth");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+
+	if (type == SCHED_NODE_TYPE_RATE_LIMITER)
+		err = esw_qos_create_rate_limit_element(vport_node, extack);
+	else
+		err = esw_qos_tc_arbiter_scheduling_setup(vport_node, extack);
+	if (err)
+		return err;
+
+	/* Rate limiters impact multiple nodes not directly connected to them
+	 * and are not direct members of the QoS hierarchy.
+	 * Unlink it from the parent to reflect that.
+	 */
+	if (type == SCHED_NODE_TYPE_RATE_LIMITER) {
+		list_del_init(&vport_node->entry);
+		vport_node->level = 0;
+	}
+
+	err  = esw_qos_create_vport_tc_sched_elements(vport, type, extack);
+	if (err)
+		goto err_sched_nodes;
+
+	return 0;
+
+err_sched_nodes:
+	if (type == SCHED_NODE_TYPE_RATE_LIMITER) {
+		esw_qos_node_destroy_sched_element(vport_node, NULL);
+		list_add_tail(&vport_node->entry,
+			      &vport_node->parent->children);
+		vport_node->level = vport_node->parent->level + 1;
+	} else {
+		esw_qos_tc_arbiter_scheduling_teardown(vport_node, NULL);
+	}
+	return err;
+}
+
+static void esw_qos_vport_tc_disable(struct mlx5_vport *vport,
+				     struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	enum sched_node_type curr_type = vport_node->type;
+
+	esw_qos_destroy_vport_tc_sched_elements(vport, extack);
+
+	if (curr_type == SCHED_NODE_TYPE_RATE_LIMITER)
+		esw_qos_node_destroy_sched_element(vport_node, extack);
+	else
+		esw_qos_tc_arbiter_scheduling_teardown(vport_node, extack);
+}
+
+static int esw_qos_set_vport_tcs_min_rate(struct mlx5_vport *vport,
+					  u32 min_rate,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	int err, i, num_tcs = esw_qos_num_tcs(vport_node->esw->dev);
+
+	for (i = 0; i < num_tcs; i++) {
+		err = esw_qos_set_node_min_rate(vport->qos.sched_nodes[i],
+						min_rate, extack);
+		if (err)
+			goto err_out;
+	}
+	vport_node->min_rate = min_rate;
+
+	return 0;
+err_out:
+	for (--i; i >= 0; i--) {
+		esw_qos_set_node_min_rate(vport->qos.sched_nodes[i],
+					  vport_node->min_rate, extack);
+	}
+	return err;
+}
+
 static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	struct mlx5_esw_sched_node *parent = vport_node->parent;
+	enum sched_node_type curr_type = vport_node->type;
 
-	esw_qos_node_destroy_sched_element(vport_node, extack);
+	if (curr_type == SCHED_NODE_TYPE_VPORT)
+		esw_qos_node_destroy_sched_element(vport_node, extack);
+	else
+		esw_qos_vport_tc_disable(vport, extack);
 
 	vport_node->bw_share = 0;
 	list_del_init(&vport_node->entry);
@@ -631,7 +898,9 @@ static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_a
 	trace_mlx5_esw_vport_qos_destroy(vport_node->esw->dev, vport);
 }
 
-static int esw_qos_vport_enable(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
+static int esw_qos_vport_enable(struct mlx5_vport *vport,
+				enum sched_node_type type,
+				struct mlx5_esw_sched_node *parent,
 				struct netlink_ext_ack *extack)
 {
 	int err;
@@ -639,10 +908,16 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport, struct mlx5_esw_sched_
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
 
 	esw_qos_node_set_parent(vport->qos.sched_node, parent);
-	err = esw_qos_vport_create_sched_element(vport->qos.sched_node, extack);
+	if (type == SCHED_NODE_TYPE_VPORT) {
+		err = esw_qos_vport_create_sched_element(vport->qos.sched_node,
+							 extack);
+	} else {
+		err = esw_qos_vport_tc_enable(vport, type, extack);
+	}
 	if (err)
 		return err;
 
+	vport->qos.sched_node->type = type;
 	esw_qos_normalize_min_rate(parent->esw, parent, extack);
 	trace_mlx5_esw_vport_qos_create(vport->dev, vport,
 					vport->qos.sched_node->max_rate,
@@ -673,9 +948,8 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	sched_node->min_rate = min_rate;
 	sched_node->vport = vport;
 	vport->qos.sched_node = sched_node;
-	err = esw_qos_vport_enable(vport, parent, extack);
+	err = esw_qos_vport_enable(vport, type, parent, extack);
 	if (err) {
-		__esw_qos_free_node(sched_node);
 		esw_qos_put(esw);
 		vport->qos.sched_node = NULL;
 	}
@@ -728,6 +1002,8 @@ static int mlx5_esw_qos_set_vport_min_rate(struct mlx5_vport *vport, u32 min_rat
 	if (!vport_node)
 		return mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_VPORT, NULL, 0, min_rate,
 						 extack);
+	else if (vport_node->type == SCHED_NODE_TYPE_RATE_LIMITER)
+		return esw_qos_set_vport_tcs_min_rate(vport, min_rate, extack);
 	else
 		return esw_qos_set_node_min_rate(vport_node, min_rate, extack);
 }
@@ -760,12 +1036,60 @@ bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *m
 	return enabled;
 }
 
+static int esw_qos_vport_tc_check_type(enum sched_node_type curr_type,
+				       enum sched_node_type new_type,
+				       struct netlink_ext_ack *extack)
+{
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR &&
+	    new_type == SCHED_NODE_TYPE_RATE_LIMITER) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot switch from vport-level TC arbitration to node-level TC arbitration");
+		return -EOPNOTSUPP;
+	}
+
+	if (curr_type == SCHED_NODE_TYPE_RATE_LIMITER &&
+	    new_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot switch from node-level TC arbitration to vport-level TC arbitration");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int esw_qos_vport_update(struct mlx5_vport *vport,
+				enum sched_node_type type,
+				struct mlx5_esw_sched_node *parent,
+				struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_parent = vport->qos.sched_node->parent;
+	enum sched_node_type curr_type = vport->qos.sched_node->type;
+	int err;
+
+	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+	parent = parent ?: curr_parent;
+	if (curr_type == type && curr_parent == parent)
+		return 0;
+
+	err = esw_qos_vport_tc_check_type(curr_type, type, extack);
+	if (err)
+		return err;
+
+	esw_qos_vport_disable(vport, extack);
+
+	err = esw_qos_vport_enable(vport, type, parent, extack);
+	if (err)
+		esw_qos_vport_enable(vport, curr_type, curr_parent, NULL);
+
+	return err;
+}
+
 static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
 				       struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_esw_sched_node *curr_parent;
-	int err;
+	enum sched_node_type type;
 
 	esw_assert_qos_lock_held(esw);
 	curr_parent = vport->qos.sched_node->parent;
@@ -773,16 +1097,17 @@ static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw
 	if (curr_parent == parent)
 		return 0;
 
-	esw_qos_vport_disable(vport, extack);
-
-	err = esw_qos_vport_enable(vport, parent, extack);
-	if (err) {
-		if (esw_qos_vport_enable(vport, curr_parent, NULL))
-			esw_warn(parent->esw->dev, "vport restore QoS failed (vport=%d)\n",
-				 vport->vport);
-	}
+	/* Set vport QoS type based on parent node type if different from
+	 * default QoS; otherwise, use the vport's current QoS type.
+	 */
+	if (parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		type = SCHED_NODE_TYPE_RATE_LIMITER;
+	else if (curr_parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		type = SCHED_NODE_TYPE_VPORT;
+	else
+		type = vport->qos.sched_node->type;
 
-	return err;
+	return esw_qos_vport_update(vport, type, parent, extack);
 }
 
 static void
@@ -1112,6 +1437,16 @@ static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw,
 	return true;
 }
 
+static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport,
+						     u32 *tc_bw)
+{
+	struct mlx5_eswitch *esw = vport->qos.sched_node ?
+				   vport->qos.sched_node->parent->esw :
+				   vport->dev->priv.eswitch;
+
+	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
+}
+
 static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
 {
 	int i;
@@ -1187,9 +1522,50 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 					 u32 *tc_bw,
 					 struct netlink_ext_ack *extack)
 {
-	NL_SET_ERR_MSG_MOD(extack,
-			   "TC bandwidth shares are not supported on leafs");
-	return -EOPNOTSUPP;
+	struct mlx5_esw_sched_node *vport_node;
+	struct mlx5_vport *vport = priv;
+	struct mlx5_eswitch *esw;
+	bool disable;
+	int err = 0;
+
+	esw = vport->dev->priv.eswitch;
+	if (!mlx5_esw_allowed(esw))
+		return -EPERM;
+
+	disable = esw_qos_tc_bw_disabled(tc_bw);
+	esw_qos_lock(esw);
+
+	if (!esw_qos_vport_validate_unsupported_tc_bw(vport, tc_bw)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "E-Switch traffic classes number is not supported");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	vport_node = vport->qos.sched_node;
+	if (disable && !vport_node)
+		goto unlock;
+
+	if (disable) {
+		if (vport_node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+			err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_VPORT,
+						   NULL, extack);
+		goto unlock;
+	}
+
+	if (!vport_node) {
+		err = mlx5_esw_qos_vport_enable(vport,
+						SCHED_NODE_TYPE_TC_ARBITER_TSAR,
+						NULL, 0, 0, extack);
+		vport_node = vport->qos.sched_node;
+	} else {
+		err = esw_qos_vport_update(vport,
+					   SCHED_NODE_TYPE_TC_ARBITER_TSAR,
+					   NULL, extack);
+	}
+unlock:
+	esw_qos_unlock(esw);
+	return err;
 }
 
 int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
@@ -1311,10 +1687,16 @@ int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_s
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.sched_node && parent)
-		err = mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_VPORT, parent, 0, 0, extack);
-	else if (vport->qos.sched_node)
+	if (!vport->qos.sched_node && parent) {
+		enum sched_node_type type;
+
+		type = parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR ?
+		       SCHED_NODE_TYPE_RATE_LIMITER : SCHED_NODE_TYPE_VPORT;
+		err = mlx5_esw_qos_vport_enable(vport, type, parent, 0, 0,
+						extack);
+	} else if (vport->qos.sched_node) {
 		err = esw_qos_vport_update_parent(vport, parent, extack);
+	}
 	esw_qos_unlock(esw);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 8573d36785f4..d59fdcb29cb8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -212,10 +212,20 @@ struct mlx5_vport {
 
 	struct mlx5_vport_info  info;
 
-	/* Protected with the E-Switch qos domain lock. */
+	/* Protected with the E-Switch qos domain lock. The Vport QoS can
+	 * either be disabled (sched_node is NULL) or in one of three states:
+	 * 1. Regular QoS (sched_node is a vport node).
+	 * 2. TC QoS enabled on the vport (sched_node is a TC arbiter).
+	 * 3. TC QoS enabled on the vport's parent node
+	 *    (sched_node is a rate limit node).
+	 * When TC is enabled in either mode, the vport owns vport TC scheduling
+	 * nodes.
+	 */
 	struct {
-		/* Vport scheduling element node. */
+		/* Vport scheduling node. */
 		struct mlx5_esw_sched_node *sched_node;
+		/* Array of vport traffic class scheduling nodes. */
+		struct mlx5_esw_sched_node **sched_nodes;
 	} qos;
 
 	u16 vport;
-- 
2.34.1


