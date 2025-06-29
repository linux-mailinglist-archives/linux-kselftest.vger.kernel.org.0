Return-Path: <linux-kselftest+bounces-36075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2109CAECDD8
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 16:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794E216D67B
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 14:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE12226CE8;
	Sun, 29 Jun 2025 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ey98bGS1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA022688B;
	Sun, 29 Jun 2025 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751206981; cv=fail; b=rt4I6UEPuv2z7wkGnNy8aGrK3pfB/c0//1ZxKufGThD62U+YucecJwv5Cgq2tBDa/8xK3Bq6BbpqfXOSAATSrquQAUCdNUF7GoMhQpKs1jq7lYf/8CxoymEkpDaexjjhpX1RNpEq9b4pINlwrITIqwCVHhGIm7EygXbJ6Ua3XyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751206981; c=relaxed/simple;
	bh=07icHJFNHAK8DmD+WXGILARG7G6PFrQmZZdb6b70Lho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkF6sPVCvICg2Wf2R91AGjlGKRRbaJXQWpYoiXLdRRJOy508ljkvbJDn61Ht+KdZ0puSheYGRs+kkc9ezT6mcOYtwjXIquf2NttbXvV289DOJGkDmO4oJMYKnRu6xNUSPuKSOkOwRs+XL0K/rKBYtfsT0ZmpWBxG5k5dWDG/z8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ey98bGS1; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxX6Y7Mr1YaifpTJixKX9aX1VPtduWaYTveHqI34bohyMkByceESnL2pnn44vemjd40qMD0GnGimIhVi8OwdqwtdHD/DOwYfBiNOI3J84NyYZdf9t8oZzkB3+sVhxiZ+fMWrbGXj61wJ6fhRw/sKjs1GD1vvvTMKndW8zfyLs3HgWFFUk4geonvvEntK9bRbprl7k+UGRpNsrDt7rc5tR8OyGMySF8O1OFZMjBruY2yfq8qC5OfsSdZsr5GLT32hhGWC1ceR0YqHIUBWRofRNPufc6egS2mCmx8+jLkTZN+W+74Svd7MchZMAz+rKHwP4bok8fekTYdp4N3uFMz3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfMjXJlJrJGxq42fhApV5hxlmr6cjKQq4G/WQSzruNU=;
 b=QJkKPoxDL+6zdJiOZNYPVIJJrKLSNcsRdUXISh647tqqosMOIVN62WkOs6g0N3SRZ/oSQpoDxu4cJc4QqDrvPEJAk+ow29uK77/VaYd6D9Ibabz9rsu7865ZfBV4lbQJ6VqVUFcf3AuTvW/YqjSArIU41Smy3YPpLVh9MmF8rh9yC1+VRSRt/UD1ZSdiqoekonAT3z9JX86lXwvYgJLVXST6i4rLVWOJuP1ANYiga3JuVXg0Sm97YcNj1Osa1yVG23T4243OUuuxGkUA6oIUBcYNJYirEGGwUleKZZ09qYEcrHD7TbzSfs+zlKigAuvSNarBAz8Ziq4TZlNT/T9yOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfMjXJlJrJGxq42fhApV5hxlmr6cjKQq4G/WQSzruNU=;
 b=Ey98bGS1z90I6RrQxWxastdz4SM6ygeHHE83K451eG4Zw6bwLuztLd8B/2mYtjfOP748nQJv3mNHNU+exiTPvY098N0MIif/O1lZxhsl8pmPSxZncGtRxf5bTQViTbcWhr0w+v/gln2VYjnYXGjkVxCgINtLDKtC0A/hrJmjRdVDraoNQxfeq6fJQ3WZqc/HKp1y2x2lOU50y5lsMueDT8fJ96Jdwllz/LQ+gie8zZBYwylYtJ275CpXd6vBNNQJ7+i9CH+bgEy3IcJ9iA4JuF96qYlqUrQAcX0l1cvrV2XNuC7WPE/G8ViI5kaTvEejy4BW/9+UFEdnpMXhR5EQog==
Received: from SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Sun, 29 Jun
 2025 14:22:52 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::90) by SJ0PR05CA0007.outlook.office365.com
 (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15 via Frontend Transport; Sun,
 29 Jun 2025 14:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 14:22:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 07:22:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 07:22:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 29
 Jun 2025 07:22:31 -0700
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
Subject: [PATCH net-next v12 5/8] net/mlx5: Add support for setting tc-bw on nodes
Date: Sun, 29 Jun 2025 17:21:35 +0300
Message-ID: <20250629142138.361537-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629142138.361537-1-mbloch@nvidia.com>
References: <20250629142138.361537-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea34801-49ce-4e5f-5376-08ddb7186ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnVQQ0ExeklRcGdhakFSdTRqSVVTcnIvUGtyUjF3S24rcGNZckRZWU5DZmtF?=
 =?utf-8?B?WWd0bWE1VWNUSUd2dUREVXM5aGNPZFdCR2dkZ0ZSZGN4dEZhT0RkK1hlVVlr?=
 =?utf-8?B?Z1ZIV01xUU1jOUE5bkh5OVM1dVA1cGpOL21adFpLOVp4ZDQrYm5QQURZN0x5?=
 =?utf-8?B?MTRIOGNpdzNUeDg3VnBNMUtoS3ZyZ1JFWkMycEQ3OFFSOG9lWEp2OHBXdFRI?=
 =?utf-8?B?UVpsTjB2bE9iYjQ2N2RqOUp1citpVDMwTy9RVm5HdURoQzRYNFpkb1YzbFM4?=
 =?utf-8?B?NUtQdnhXNnYzZkVndStuNjJabmhHcnFEMTQ2ZzFsUTJxRVMwVW41ZFYzQ0hi?=
 =?utf-8?B?bmZzVjNnakxxeU4xWEJQeHNFQ2VGWDcwSmlDblJFbUlpaUdBNG4rY2o0aGdV?=
 =?utf-8?B?K3c1Mm1oOGFwem9OVTR2L2NCOUV4M3dPMUV2emtPOXdsa1B0dFNIcnVtM0J6?=
 =?utf-8?B?c2VXWmhWamVRVnd2VThwY0QvNlY0N24vajhwN0czcDNaeVdKWmhpWVNBYmx4?=
 =?utf-8?B?QWVrN1VVUUpOVVJJRkRtbkpvcjFVbGFybFl3ZEpGN05oWThOM3Yrb3RjYzJo?=
 =?utf-8?B?dVpDOWlKMDVrcHFaVUZObVMxbFVyUHM0dlB0RzA0WFFmZWdoaVZVWlpsTjZY?=
 =?utf-8?B?OHp4L0F3L2k5eDBrZFp3c3FjM1YydFlGbVhZcUtqQlhEdUdNVlQ4OHNUb21l?=
 =?utf-8?B?bk0rNTF0Z0pSbi90QXcxYVhwUFdPbkt5Y0txSDJmZlJydzczdDNXREJyU3Ri?=
 =?utf-8?B?Y3hDTHg5eUhGNzRpTWVETmVidXFYbDVGZmh3c3JyelR4NE9WK3FkV3BSWk81?=
 =?utf-8?B?eStGYVkyTzZZRUVGN2tNQUhWZGNJRkc3RHdXbEFSK29WbEtnRkV2MkRJaFVq?=
 =?utf-8?B?SHBGbFlmRHI5RWR6TTRkUy9veG5JK2JpN2tIQnQ1YUlUbXBmV0xqWTVZczVD?=
 =?utf-8?B?eWdORHRyS29kVFdhU0VKbVVVbUs2SlNBOFpzcUhxL1YvTldBRVFXQlNNVzhI?=
 =?utf-8?B?S1VXZjJzMlordjNuQXhUeFZoOHpacGswU25YeXorck02cVE1LzEvai9WblNa?=
 =?utf-8?B?bWl3N2VRanUvWU5zUnR2L0YyVDVBN0lvVXFzUkRycGU0c3g4ZnYxc0JIMEwy?=
 =?utf-8?B?YVBTWTBIWmttUWtEQ0NmaVFXc0N0d2x6MmlXaUY4dGZ3NzlNdGR4UnY5YkNI?=
 =?utf-8?B?L1lCWXdmZTVieXVQa3QrNnFHY2dvSU9yczcydlFtWGpFK2hwUVZ2UjdTL254?=
 =?utf-8?B?UHdsR1VQYlR2QkYwa1IvM2JvbTRYSVVJSytaczNwR0FWVTVpM3FuSk9XOVM5?=
 =?utf-8?B?K3hjb0ZtMmI1MHFFanM3V2ltc1ZuZWRkeXg3dFR1V0dWelVYRFVKTEM0RGEv?=
 =?utf-8?B?aktvckJkc3BVNG1kNVZ3SlhHRzY3cCtXdXc1UU14MUoyb3ltblZTQjJxSnhH?=
 =?utf-8?B?cmJjbitpZStDYkprMEtGWU50bTVvWE5BMDF0dmZPR3VQd0svN2pkaVh3SWlV?=
 =?utf-8?B?Wjc1MzQ2S0Nsa3pTYVJ6aERHTDNnMDVuRmFQMm8vdFVQS3l6K3J0SjNEZ1dl?=
 =?utf-8?B?N0I1Y2RVb01RVFp3ay9tSk53Q0FncnhTWmV0WW9HdmZXS295KzNEUkRjMkdE?=
 =?utf-8?B?L3IrdnhnM3JaTEtsN1A3VW5QV0lKL3RKbnNpdVJkN0VneHFteUtTd0NSMHBw?=
 =?utf-8?B?YTM3dTRGTlRoaWk4dHVPWktnK3dhQzRFbHdlRkZVSVp4SWZiZEdOU3BZS3lE?=
 =?utf-8?B?WkxlRzV2cjNjeTFZdHB6cCtpMWtzQkJHUUpOaUhSWVZCYWh2L3pKYkFEUFlH?=
 =?utf-8?B?YVBJcjU2Mi8wRHc5YXFObnltdExZS1pjeWVZdTJqbEpCL3Z3bGpJU0FUaUFa?=
 =?utf-8?B?cFlZWjMwSnlHWUVudWxhQ2wrK2h5Z1hMMnd3WTFBNUVDdjVWZUxJbG50eG1a?=
 =?utf-8?B?RWJzT2prQll2LzF6emw1VGZDOTgrWU5rT2JkUEtvbHRLc0VONUxUMmd6aWFh?=
 =?utf-8?B?UDgwZEdDdnJmRE0vN3JTb0pVRDhiakZsakpvK09UVjVtVktCOCtncWJnaERi?=
 =?utf-8?Q?jBwi7Q?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 14:22:51.8790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea34801-49ce-4e5f-5376-08ddb7186ea4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

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
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
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
2.34.1


