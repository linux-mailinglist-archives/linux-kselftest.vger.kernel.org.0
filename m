Return-Path: <linux-kselftest+bounces-33418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D547ABE2FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 20:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E848A0464
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 18:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDEA288C93;
	Tue, 20 May 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uUXYevsB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11F3283143;
	Tue, 20 May 2025 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766402; cv=fail; b=twAlzl4LLdVdAZwSob1oqybfAbTblYjXTibi4lX02nsWOBVHREdddxo195Nyg8DinrHi92N8PrzhgLXp8+/jOsjL6aO3lxC1JY6/yabA7bcj7+c8BChwyHaCnb0CxMiC3DFXR6N6TaENrun8CNAUO/MYafy1vJU5p4CCVV2uCAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766402; c=relaxed/simple;
	bh=QbAPYdinVWbi3XXtdhznrwpKyIXwwhUt2rACrNs8bIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfkEvhV54gpUdbPl9Gbg6bkIU2W4+CGng4xUlCOxnovViLzvrSEHRKNA0ltrBdHOyS+EYr0cDHMrOaHojoA2IxftiS5d7HXIthhiJw8GMvlS0E7W+VY3YkKZHU60T4CndgVH9EtdgbCDMUMY+QrSLvQA2kZVT5xGtdIvj1XzZSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uUXYevsB; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHI9VQH9owrvTj/Op5Jz7M37pudgFuDCC8gyVf1KHbgxpsC7x5qRDLS/R0F1xlbmQDUEqexIsO7sFnbnq1jVu9SsTdUn2Dcg6LpiFl69s8Wekpgw8/5jJ0AE93n1G2pUyzTKStexQ6qaSJ21kpysCvrGktarueokoJ4fm0vbHLEGB5XRmg1ZT6iG38gXa5LImvNP4nloKnau7RoZV/+FMriclRu1yAfqSbXFJhG/xDD/b0tbar0G2nfTWAwMA2jU6ElEXx+ug/sdy/j3QQGXfmVrPIrepollLdsEiWCg5E7+lILIwE6oxKhjwnLbCuuJWqxd8Jf1uSbspD3NFCmtyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQOpHjhhjgC5vAEBkkrCB+8r8M63mcDrsMSPDsK9LXI=;
 b=DVG0nUvABrACJxhIm4A+sz5Iw+3u9KlaJs6Z4Jv8u5IT7duljRklis2r7Sg0DBV2KkwnKeND3Z7GSlHPQwShjoZdRp6RgCQLFTNQ2Y7sXo8uhbAUlOpklejgVSDu8tHSqItnyHXfTlmi1xUMMFS6o9e25yWzgkIpSmV1B3zJU8Y9j7TUue9UAKq1OXty6pX5z6Fg21PSCt7AsGCCVw6RLJiB+51agML9lHqUeX2xHwVtHJwPDihl58qS73Ir800bYKd/QtOCg1+7R+3PTNxHl2q9w6TTfkieqHLwk4d42D6UJnXaZYBnap405x3/Qt7zfzPh+Qd3fmuAjLci4yZTFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQOpHjhhjgC5vAEBkkrCB+8r8M63mcDrsMSPDsK9LXI=;
 b=uUXYevsBHX7LQuBJpjZ85cVuc8FGt3fDekTxUUlaYbWD9qBxN/Ln0nx2fndhF42ngMZW7ndYI/xWK1gd6HwbJ/lr3NteRWU5b0f9UJBZYXDaJmOIaeuj2lDaGhvgvCi8173LzBkDeA/OKqqKM5zh9Zk9Xo1hxHGAmc/K8TpLZCHyGHNGfyZG1j293rmZD45Fmr+hzM0z1XDZFdXA+/yw2MAc1c3fARGgcHhAsiaIzWhnOwBV/2E4R3nupyY7X00e3bIYSISuWV2bVK1ubnEbMIe91ba2HoflK44KL+p6Lw2FEiWiwCYzUQy8iu6JdCRIKKMl3dugedLLpFp88IdrBQ==
Received: from CH2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:20::28)
 by PH8PR12MB7352.namprd12.prod.outlook.com (2603:10b6:510:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Tue, 20 May
 2025 18:39:55 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::83) by CH2PR07CA0015.outlook.office365.com
 (2603:10b6:610:20::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Tue,
 20 May 2025 18:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 18:39:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 May
 2025 11:39:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 20 May
 2025 11:39:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 20
 May 2025 11:39:36 -0700
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
Subject: [PATCH net-next V10 4/6] net/mlx5: Add support for setting tc-bw on nodes
Date: Tue, 20 May 2025 21:38:05 +0300
Message-ID: <1747766287-950144-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
References: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|PH8PR12MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: b89a1887-e46a-4025-c417-08dd97cdb6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWk3RHJYV3Vhb0ZtbzdaVXQ2RGE2NURXUnJyOU5RejhLVnBmOElkUEtrY1F4?=
 =?utf-8?B?NnBwdEtyRUJ1RTM4MDRETSt5VlZKbnkrbk9HK29uSHBiZm5DbkU2Rk9pbi9G?=
 =?utf-8?B?ZTNyVWttODk0SG1xc2w2SWU4WnkrT3B2VEZKTHc2WW1mbVdyVjVZaVFMb1NI?=
 =?utf-8?B?UTZnUU1mM2NqenBCb3ErV0RURkJzUWhsK3VicGR4YXc2Qlc5R09Rek9aUTBy?=
 =?utf-8?B?QkZxSE42Y01qLzhWVXpSU094eHVySi9kWG5yR3JQc1dCQk9Jc0xLbVl0bDNM?=
 =?utf-8?B?K1NhTW9MeXN3L1VXQUxiMWVFYmNkOUlYQmVCaFhSTG1rVzVtVURPZi9iRkty?=
 =?utf-8?B?d24wUXg3MjBERXd0UDloVC9sanZpM0c0NkVrcEJncTVnU09tS05WeVVwOFRN?=
 =?utf-8?B?Q1Nra1lpcjBBWXZCdDF3RjRoYjVCTWRJd1FsNFRxWENWYUNDTVFuS2Q5RlJy?=
 =?utf-8?B?U2paT05OYUc3Mlk2cy9oQjZCQ1VPbm9icEd1bnRESG1RWGhGb1JMclducHdq?=
 =?utf-8?B?Vjk5eElDMnl1dVpKd2U3SEZLY2NGNklLeENCblB6NTM4OXhRL0FiT0I5a0ZB?=
 =?utf-8?B?c3NyM1VXazJHbTJjZUpudk9yZHRmVDNEY1N3dUF1SjdQb1lHbFBCZitIRENN?=
 =?utf-8?B?bDh2TGlRMElSaTZnb3JSOUp4UGIvNlQvQVBhQjlyc3ltY0JYTWVmVTVibUd2?=
 =?utf-8?B?dHFzbmlIOVFlR2ZVc2I0dEZpaWZLWkFZTUZ5aFltUkhlVEY3OG1pTWo4S09X?=
 =?utf-8?B?S3BNSXZ5T2ppQzMycXNVRjNiK0pqZWJyc1VzaUtrR1pmSmpMdC9BcHpDUEZa?=
 =?utf-8?B?OXFwUTFUSE1OYTVpMHRmVFFBK0NOWmdqNGpOblFjbWFWd1cvOUY3MlhaUmFx?=
 =?utf-8?B?N3kwLzczcEU1UTJMY0U2QnVOMER5YWw4d25wK3ZtWC9RSW1LbnR3UHFTRU11?=
 =?utf-8?B?Yy9vV0gwYk9Qd0I5Vi9ITHpVWlNhOVJzL1FZYitxVmN2dmY2bDZDS1VxbUsy?=
 =?utf-8?B?OFo1Ukk1L1JkMWkvNGFrcWJmYU5aV1YzZzJEZ3Vnd3Z4VlU5Rnd3ZEZxT1E1?=
 =?utf-8?B?blN2QjVRWE1Bb0lJQW5obXRYdU4yWEVCdDNWeTcrV29td2tDZ2tieEE4SkFP?=
 =?utf-8?B?WGM5VEVONkpZSTdQQzVIMUxwZzhHV2tuSGxFelhXcG95cktnWk8yVlEyVy9L?=
 =?utf-8?B?aG1udUFLOUdRQlV2a3IrdG04L2R1UXlWT28vM0pJMFdJZStPN2JrNXA1b3Zs?=
 =?utf-8?B?Y2QyeVVjUDBlcXFmOW1ReG1mbVplWWV4NDVJNWlBUEpxR3RubURUTEdjS1Zm?=
 =?utf-8?B?SUVGUTE0S0tKY1FvUHNnVmZDck5xd2gvQ0g5Mm54bkVuWDVLNktFSE1qUE9Q?=
 =?utf-8?B?aG5lbWYzQVlCMXRFaCtMVERYN0NyZlBSU1YweDd1YTdmN094SjRwaWJjSnE0?=
 =?utf-8?B?NjB6cVpzSklkSUFsaktwNFEreVNLVm95RjhROWZCUDRER0tkQjgwTmN1UzJD?=
 =?utf-8?B?UUVISFgrNUZDZ2J6L3FEcU9NdWdabTA0eWdvMWlDYWorTmhzS0t3bFBwRCtZ?=
 =?utf-8?B?U3ZFOGN5S1VDK3dhMGdkMGtiZWtNU1lteEdXV0JsVHgvQTF0YjdvcEZEVHF6?=
 =?utf-8?B?eGhDWFUvSFJpUEVmUjJRcDlvakpmaWw3VHdVQS83cXdXdDVEUm1HRnRIUW15?=
 =?utf-8?B?ZE10bHg1TmtlNFB2WUFQUm9qaWgzZ0g5ZW1mM1JSb3d5WUVaT2FvZURPOWtW?=
 =?utf-8?B?OVdJWS95aXZPN3BsaWZ4d2NxWkdyR3JlamRpZGFDQUdUa0VxT1BIRVdZN0lJ?=
 =?utf-8?B?Ri83bmI4ZnVKZ2FXZ3YwVEd0UnBJQlNCd3F2NU1zNXBTc2FjVXJxVUdRcmd0?=
 =?utf-8?B?V0p0aWdNMjRHUEJEcGtUU1hqWUUwNDVWRUZueHRRMzBQbStTK0Izbit3ZlZZ?=
 =?utf-8?B?Z3VZTldFQ3VPWERabmtOZkNoMVlTSk1LcTc0M0paVkhmcml5bmFNV2dEMnlV?=
 =?utf-8?B?M0E1eEViTGZxOHUzWUZCd0FJYnA1SkdLcXJmTzA3WFpteC9aK3BabG1ucDNo?=
 =?utf-8?Q?p4ITvz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 18:39:54.5693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89a1887-e46a-4025-c417-08dd97cdb6c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7352

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for enabling and disabling Traffic Class (TC)
arbitration for existing devlink rate nodes. This patch adds support
for a new scheduling node type, `SCHED_NODE_TYPE_TC_ARBITER_TSAR`.

Key changes include:

- New helper functions for transitioning existing rate nodes to TC
  arbiter nodes and vice versa. These functions handle the allocation
  of TC arbiter nodes, copying of child nodes, and restoring vport QoS
  settings when TC arbitration is disabled.

- Implementation of `mlx5_esw_devlink_rate_node_tc_bw_set()` to manage
  tc-bw configuration on nodes.

- Introduced stubs for `esw_qos_tc_arbiter_scheduling_setup()` and
  `esw_qos_tc_arbiter_scheduling_teardown()`, which will be extended in
  future patches to provide full support for tc-bw on devlink rate
  objects.

- Validation functions for tc-bw settings, allowing graceful handling
  of unsupported traffic class bandwidth configurations.

- Updated `__esw_qos_alloc_node()` to insert the new node into the
  parent’s children list only if the parent is not NULL. For the root
  TSAR, the new node is inserted directly after the allocation call.

- Don't allow `tc-bw` configuration for nodes containing non-leaf
  children.

This patch lays the groundwork for future support for configuring tc-bw
on devlink rate nodes. Although the infrastructure is in place, full
support for tc-bw is not yet implemented; attempts to set tc-bw on
nodes will return `-EOPNOTSUPP`.

No functional changes are introduced at this stage.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 313 +++++++++++++++++-
 1 file changed, 304 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index ec706e9352e1..1066992c1503 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -64,11 +64,13 @@ static void esw_qos_domain_release(struct mlx5_eswitch *esw)
 enum sched_node_type {
 	SCHED_NODE_TYPE_VPORTS_TSAR,
 	SCHED_NODE_TYPE_VPORT,
+	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
 };
 
 static const char * const sched_node_type_str[] = {
 	[SCHED_NODE_TYPE_VPORTS_TSAR] = "vports TSAR",
 	[SCHED_NODE_TYPE_VPORT] = "vport",
+	[SCHED_NODE_TYPE_TC_ARBITER_TSAR] = "TC Arbiter TSAR",
 };
 
 struct mlx5_esw_sched_node {
@@ -106,6 +108,13 @@ static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *node)
 	}
 }
 
+static int esw_qos_num_tcs(struct mlx5_core_dev *dev)
+{
+	int num_tcs = mlx5_max_tc(dev) + 1;
+
+	return num_tcs < DEVLINK_RATE_TCS_MAX ? num_tcs : DEVLINK_RATE_TCS_MAX;
+}
+
 static void
 esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_node *parent)
 {
@@ -116,6 +125,27 @@ esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_
 	esw_qos_node_attach_to_parent(node);
 }
 
+static void esw_qos_nodes_set_parent(struct list_head *nodes,
+				     struct mlx5_esw_sched_node *parent)
+{
+	struct mlx5_esw_sched_node *node, *tmp;
+
+	list_for_each_entry_safe(node, tmp, nodes, entry) {
+		esw_qos_node_set_parent(node, parent);
+		if (!list_empty(&node->children) &&
+		    parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+			struct mlx5_esw_sched_node *child;
+
+			list_for_each_entry(child, &node->children, entry) {
+				struct mlx5_vport *vport = child->vport;
+
+				if (vport)
+					vport->qos.sched_node->parent = parent;
+			}
+		}
+	}
+}
+
 void mlx5_esw_qos_vport_qos_free(struct mlx5_vport *vport)
 {
 	kfree(vport->qos.sched_node);
@@ -141,16 +171,24 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 
 static void esw_qos_sched_elem_warn(struct mlx5_esw_sched_node *node, int err, const char *op)
 {
-	if (node->vport) {
+	switch (node->type) {
+	case SCHED_NODE_TYPE_VPORT:
 		esw_warn(node->esw->dev,
 			 "E-Switch %s %s scheduling element failed (vport=%d,err=%d)\n",
 			 op, sched_node_type_str[node->type], node->vport->vport, err);
-		return;
+		break;
+	case SCHED_NODE_TYPE_TC_ARBITER_TSAR:
+	case SCHED_NODE_TYPE_VPORTS_TSAR:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s %s scheduling element failed (err=%d)\n",
+			 op, sched_node_type_str[node->type], err);
+		break;
+	default:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s scheduling element failed (err=%d)\n",
+			 op, err);
+		break;
 	}
-
-	esw_warn(node->esw->dev,
-		 "E-Switch %s %s scheduling element failed (err=%d)\n",
-		 op, sched_node_type_str[node->type], err);
 }
 
 static int esw_qos_node_create_sched_element(struct mlx5_esw_sched_node *node, void *ctx,
@@ -388,6 +426,14 @@ __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type
 	node->parent = parent;
 	INIT_LIST_HEAD(&node->children);
 	esw_qos_node_attach_to_parent(node);
+	if (!parent) {
+		/* The caller is responsible for inserting the node into the
+		 * parent list if necessary. This function can also be used with
+		 * a NULL parent, which doesn't necessarily indicate that it
+		 * refers to the root scheduling element.
+		 */
+		list_del_init(&node->entry);
+	}
 
 	return node;
 }
@@ -426,6 +472,7 @@ __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sch
 		goto err_alloc_node;
 	}
 
+	list_add_tail(&node->entry, &esw->qos.domain->nodes);
 	esw_qos_normalize_min_rate(esw, NULL, extack);
 	trace_mlx5_esw_node_qos_create(esw->dev, node, node->ix);
 
@@ -498,6 +545,9 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 					  SCHED_NODE_TYPE_VPORTS_TSAR,
 					  NULL))
 			esw->qos.node0 = ERR_PTR(-ENOMEM);
+		else
+			list_add_tail(&esw->qos.node0->entry,
+				      &esw->qos.domain->nodes);
 	}
 	if (IS_ERR(esw->qos.node0)) {
 		err = PTR_ERR(esw->qos.node0);
@@ -555,6 +605,18 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
 		esw_qos_destroy(esw);
 }
 
+static void
+esw_qos_tc_arbiter_scheduling_teardown(struct mlx5_esw_sched_node *node,
+				       struct netlink_ext_ack *extack)
+{}
+
+static int esw_qos_tc_arbiter_scheduling_setup(struct mlx5_esw_sched_node *node,
+					       struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC arbiter elements are not supported.");
+	return -EOPNOTSUPP;
+}
+
 static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
@@ -723,6 +785,195 @@ static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw
 	return err;
 }
 
+static void
+esw_qos_switch_vport_tcs_to_vport(struct mlx5_esw_sched_node *tc_arbiter_node,
+				  struct mlx5_esw_sched_node *node,
+				  struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vports_tc_node, *vport_tc_node, *tmp;
+
+	vports_tc_node = list_first_entry(&tc_arbiter_node->children,
+					  struct mlx5_esw_sched_node,
+					  entry);
+
+	list_for_each_entry_safe(vport_tc_node, tmp, &vports_tc_node->children,
+				 entry)
+		esw_qos_vport_update_parent(vport_tc_node->vport, node, extack);
+}
+
+static int esw_qos_switch_tc_arbiter_node_to_vports(
+	struct mlx5_esw_sched_node *tc_arbiter_node,
+	struct mlx5_esw_sched_node *node,
+	struct netlink_ext_ack *extack)
+{
+	u32 parent_tsar_ix = node->parent ?
+			     node->parent->ix : node->esw->qos.root_tsar_ix;
+	int err;
+
+	err = esw_qos_create_node_sched_elem(node->esw->dev, parent_tsar_ix,
+					     node->max_rate, node->bw_share,
+					     &node->ix);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to create scheduling element for vports node when disabliing vports TC QoS");
+		return err;
+	}
+
+	node->type = SCHED_NODE_TYPE_VPORTS_TSAR;
+
+	/* Disable TC QoS for vports in the arbiter node. */
+	esw_qos_switch_vport_tcs_to_vport(tc_arbiter_node, node, extack);
+
+	return 0;
+}
+
+static int esw_qos_switch_vports_node_to_tc_arbiter(
+	struct mlx5_esw_sched_node *node,
+	struct mlx5_esw_sched_node *tc_arbiter_node,
+	struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node, *tmp;
+	struct mlx5_vport *vport;
+	int err;
+
+	/* Enable TC QoS for each vport in the node. */
+	list_for_each_entry_safe(vport_node, tmp, &node->children, entry) {
+		vport = vport_node->vport;
+		err = esw_qos_vport_update_parent(vport, tc_arbiter_node,
+						  extack);
+		if  (err)
+			goto err_out;
+	}
+
+	/* Destroy the current vports node TSAR. */
+	err = mlx5_destroy_scheduling_element_cmd(node->esw->dev,
+						  SCHEDULING_HIERARCHY_E_SWITCH,
+						  node->ix);
+	if (err)
+		goto err_out;
+
+	return 0;
+err_out:
+	/* Restore vports back into the node if an error occurs. */
+	esw_qos_switch_vport_tcs_to_vport(tc_arbiter_node, node, NULL);
+
+	return err;
+}
+
+static struct mlx5_esw_sched_node *
+esw_qos_move_node(struct mlx5_esw_sched_node *curr_node)
+{
+	struct mlx5_esw_sched_node *new_node;
+
+	new_node = __esw_qos_alloc_node(curr_node->esw, curr_node->ix,
+					curr_node->type, NULL);
+	if (!IS_ERR(new_node))
+		esw_qos_nodes_set_parent(&curr_node->children, new_node);
+
+	return new_node;
+}
+
+static int esw_qos_node_disable_tc_arbitration(struct mlx5_esw_sched_node *node,
+					       struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_node;
+	int err;
+
+	if (node->type != SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		return 0;
+
+	/* Allocate a new rate node to hold the current state, which will allow
+	 * for restoring the vports back to this node after disabling TC
+	 * arbitration.
+	 */
+	curr_node = esw_qos_move_node(node);
+	if (IS_ERR(curr_node)) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed setting up vports node");
+		return PTR_ERR(curr_node);
+	}
+
+	/* Disable TC QoS for all vports, and assign them back to the node. */
+	err = esw_qos_switch_tc_arbiter_node_to_vports(curr_node, node, extack);
+	if (err)
+		goto err_out;
+
+	/* Clean up the TC arbiter node after disabling TC QoS for vports. */
+	esw_qos_tc_arbiter_scheduling_teardown(curr_node, extack);
+	goto out;
+err_out:
+	esw_qos_nodes_set_parent(&curr_node->children, node);
+out:
+	__esw_qos_free_node(curr_node);
+	return err;
+}
+
+static int esw_qos_node_enable_tc_arbitration(struct mlx5_esw_sched_node *node,
+					      struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_node, *child;
+	int err, new_level, max_level;
+
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		return 0;
+
+	/* Increase the hierarchy level by one to account for the additional
+	 * vports TC scheduling node, and verify that the new level does not
+	 * exceed the maximum allowed depth.
+	 */
+	new_level = node->level + 1;
+	max_level = 1 << MLX5_CAP_QOS(node->esw->dev, log_esw_max_sched_depth);
+	if (new_level > max_level) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "TC arbitration on nodes is not supported beyond max scheduling depth");
+		return -EOPNOTSUPP;
+	}
+
+	/* Ensure the node does not contain non-leaf children before assigning
+	 * TC bandwidth.
+	 */
+	if (!list_empty(&node->children)) {
+		list_for_each_entry(child, &node->children, entry) {
+			if (!child->vport) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Cannot configure TC bandwidth on a node with non-leaf children");
+				return -EOPNOTSUPP;
+			}
+		}
+	}
+
+	/* Allocate a new node that will store the information of the current
+	 * node. This will be used later to restore the node if necessary.
+	 */
+	curr_node = esw_qos_move_node(node);
+	if (IS_ERR(curr_node)) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed setting up node TC QoS");
+		return PTR_ERR(curr_node);
+	}
+
+	/* Initialize the TC arbiter node for QoS management.
+	 * This step prepares the node for handling Traffic Class arbitration.
+	 */
+	err = esw_qos_tc_arbiter_scheduling_setup(node, extack);
+	if (err)
+		goto err_setup;
+
+	/* Enable TC QoS for each vport within the current node. */
+	err = esw_qos_switch_vports_node_to_tc_arbiter(curr_node, node, extack);
+	if (err)
+		goto err_switch_vports;
+	goto out;
+
+err_switch_vports:
+	esw_qos_tc_arbiter_scheduling_teardown(node, NULL);
+	node->ix = curr_node->ix;
+	node->type = curr_node->type;
+err_setup:
+	esw_qos_nodes_set_parent(&curr_node->children, node);
+out:
+	__esw_qos_free_node(curr_node);
+	return err;
+}
+
 static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
 {
 	struct ethtool_link_ksettings lksettings;
@@ -848,6 +1099,31 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 	return 0;
 }
 
+static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw,
+					       u32 *tc_bw)
+{
+	int i, num_tcs = esw_qos_num_tcs(esw->dev);
+
+	for (i = num_tcs; i < DEVLINK_RATE_TCS_MAX; i++) {
+		if (tc_bw[i])
+			return false;
+	}
+
+	return true;
+}
+
+static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
+{
+	int i;
+
+	for (i = 0; i < DEVLINK_RATE_TCS_MAX; i++) {
+		if (tc_bw[i])
+			return false;
+	}
+
+	return true;
+}
+
 int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
 {
 	if (esw->qos.domain)
@@ -921,9 +1197,28 @@ int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
 					 u32 *tc_bw,
 					 struct netlink_ext_ack *extack)
 {
-	NL_SET_ERR_MSG_MOD(extack,
-			   "TC bandwidth shares are not supported on nodes");
-	return -EOPNOTSUPP;
+	struct mlx5_esw_sched_node *node = priv;
+	struct mlx5_eswitch *esw = node->esw;
+	bool disable;
+	int err;
+
+	if (!esw_qos_validate_unsupported_tc_bw(esw, tc_bw)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "E-Switch traffic classes number is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	disable = esw_qos_tc_bw_disabled(tc_bw);
+	esw_qos_lock(esw);
+	if (disable) {
+		err = esw_qos_node_disable_tc_arbitration(node, extack);
+		goto unlock;
+	}
+
+	err = esw_qos_node_enable_tc_arbitration(node, extack);
+unlock:
+	esw_qos_unlock(esw);
+	return err;
 }
 
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
-- 
2.31.1


