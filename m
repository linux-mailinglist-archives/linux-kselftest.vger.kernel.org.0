Return-Path: <linux-kselftest+bounces-35794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044E7AE8C7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 20:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37097AFFBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E892DFA5F;
	Wed, 25 Jun 2025 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nqeu9XdV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46B2DFA55;
	Wed, 25 Jun 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876288; cv=fail; b=IEUw95g/0fWv/wcLF+XdlAvaPlWacv3nCgRU6lRuH7G+6DBlIb3pLQ/zdaSi/tkPYPDvmbgNxGtFj7X5JbiLiVkJDxiAsJrY64/VqBWwg8A9xbSo0qBsOv02YYvgGCRKUQoR3AVirOzqlkRhwjkh/KXlnB97bewEHuEo0BcnOD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876288; c=relaxed/simple;
	bh=07icHJFNHAK8DmD+WXGILARG7G6PFrQmZZdb6b70Lho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UglfNOoeA8W+IdReqHn4gkGh2jbpVnSQ2tEOPLZgf1mADXVTHpvZPxH/lvf3g95oQ9NnAB2ZF9ikYQ5aVYvR1uUnS79+52CDIhWMGD5Rbaob54myV/OD9rZJ+RY0ij2ryAcfOYM62rEOxNRvcmpxjjAhEXVH5ud0DRwH+j/h/N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nqeu9XdV; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNf5Ui+zp7HRALitfj/81vHfBlIiM9zyHbGQlhy59ZdWoPIRVlkX8Ck+SZ8ZJo8S/sJTSs/pXn4zWYSttVhx39TaPeVNmN4waaV/tn6doIofKWtHjqiiDqqBomvsxa7FPAf0r1lPVGhzDEP1GQ7HBWKVJtTDuX5WQh+Cxl5v/cGI2mnr2Ykzg5E6G9KM0EW6TpwWHKCCSHYupAPe/Fzjx3/xcrDi00rHB0HMiKW1ILRMt2+G+sPzFHYIEKkpN1CWZW6dI77uNRWKJcziK8fxkatKl/YTbhSY/BS/tLbQ+O6E0m18WDAQZhEDlTdCA/ID/nZwf8ALGVPtEi0Vi7oXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfMjXJlJrJGxq42fhApV5hxlmr6cjKQq4G/WQSzruNU=;
 b=sknoJWCaE0VbJlxIDwYFqMjHUTUYMTephF8PAxF/xC1iNvTM2egsB3YRsUfqe9F0wDpF9HANxZA/VYRoeYDOFFcAcejRGvaCLTAwByBZywuItF1I82DDAuqqMrm2zMLW0JFVFORFsnCHG3B2ON5LF28OtABRdlvG8kiQ1RvhlMguG7miaN3QS8mGtXWsBBjqsTtJA82kPPyy49QKDKsJKqv4zGhA1RH29gBfp9KNnGlye7cQFcqhepfUaGlny7tZ+p3rlVu8cRTxwikPHcv6qFm4dRpjaEJZHpQ/f1+Zfz1p8dM4tr4ZSl6kBGdVgeqz3UGh0HEucJaGt8E3shgzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfMjXJlJrJGxq42fhApV5hxlmr6cjKQq4G/WQSzruNU=;
 b=Nqeu9XdVp5VrBQ8rSv1CFis+VRIA7cayXmzlMZkZHXnw8xlQ1YoOLU7QVkPAQ/AckLkG3sR12J/jptWHDxFt5Id4d4xG+A9beDLHsRyO6Xdgz9BB3L99frwBOzOBqE7XF35RdOgkzBFa2PZbGsfdlAC97iMQF9jhwOANM4g0IMQqyaAiJ+As+WMAS0ndp9EjOE9WbKs38EJpNioVd8BFWHqv48CZtRki0GeigWPjINcBpdYaq5wlkkC4FrNMsrun1qzbo88yYzZgbp8sCg8sfhOuWcsOKzvI8XsPs7A5xztdth86Q7VHEw3xchZ0EnTEjVB53MMH5oGNkU/zopSKRA==
Received: from SJ0PR05CA0099.namprd05.prod.outlook.com (2603:10b6:a03:334::14)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Wed, 25 Jun
 2025 18:31:22 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::1) by SJ0PR05CA0099.outlook.office365.com
 (2603:10b6:a03:334::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.6 via Frontend Transport; Wed,
 25 Jun 2025 18:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 18:31:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 11:31:04 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 11:31:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 25
 Jun 2025 11:30:57 -0700
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
Subject: [PATCH net-next v11 5/8] net/mlx5: Add support for setting tc-bw on nodes
Date: Wed, 25 Jun 2025 21:30:15 +0300
Message-ID: <20250625183018.87065-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625183018.87065-1-mbloch@nvidia.com>
References: <20250625183018.87065-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 0282af4d-de4c-440c-6227-08ddb4167c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXpwTlN6S3B4WExxWmovcWxDdTgySUxNWUNLR3lydXFiRGREQmFNR1R0aFFw?=
 =?utf-8?B?VlV5QmVSeWlpTlFmcjUrWUQ2dnBSbk5QSWxtRWZ6b0tvRGN3RS81KzBrdnpP?=
 =?utf-8?B?dE1zcnhLWlk3K3Znd3JyYk96YnFWSzNtM0MwRVlnL1JYcGJZcEJOY2laYW82?=
 =?utf-8?B?S2lndDZzNjRmNFVmR3BQWTlSUjJoalc0NXV1ZGNabGZHN3BSRGhWYTlOT1BP?=
 =?utf-8?B?K3RSR1BhdDByRHdZWVVNUU0vczZZSmhUZnYzWVpZL2hUYzQ5ZUpYV0FzNy90?=
 =?utf-8?B?cWwxSnc2aFVyMzRlZDFwOStnSkpmRzMwNWFocHV0MTJyOXJqU2sxZ1diejVD?=
 =?utf-8?B?YjVLU2tVRU5SSEFZQVlhSHJHcUpVWEwzbWVyT2tubmtzUmVia3FMWkN4YklU?=
 =?utf-8?B?YjBHRllmTWtuTlp2OWozNGJrMnRzMWxGT0lIcHpWcHh1ZlFKVVoyNkp0T0tI?=
 =?utf-8?B?ZCtyQkRTQ0ZRWnNyUWpzc2FNNHpZdmlqeVFOZVVld0NKM1h6YlQrUmsxemJF?=
 =?utf-8?B?MEowOHMwcjViOXRwTGlZUEZMSXhGbGVMNTVUSDdBVjZOS1VKd0dEOHFMUG9E?=
 =?utf-8?B?S3FUdng1TWEwSTdTUC9COGJMbmZ0ZEdwUTBmM0pseEFqV0lQVkhBVXM3SjlI?=
 =?utf-8?B?U2RERlFxbTl4akVBYVhPWVVlYlhGTnJwMDhjZDU5a1lVVmF1UzBHNnVzSzFJ?=
 =?utf-8?B?M3REaVE5TmJwbXZNeHVZamZFeTVSeFhPZEMzeE1aeVhvdUkrUGM5RHNrUVlu?=
 =?utf-8?B?QmVtU2dnUmlOUERzdnNSdTE4b1JtMDRPV3VEU1NmUjIwelRaSlRNREY1K25W?=
 =?utf-8?B?dWZWbHFTWFlkZVRWY1ZzQzZjVGRwZDBjN0tuRkFzOXJNUTFRaU10VXJnZ0cy?=
 =?utf-8?B?WnZVWFFEblJPaG9xT3RtT2k0RUFTcXhDdFIvRWV6Vkx5THl6Y0RDNk1ibWxs?=
 =?utf-8?B?RE9KR00zOEZBL0hrdFlwaTNRRHJNQUpYZ1oxOHdXa3dRY21EWVNLanpFYmRW?=
 =?utf-8?B?b0poblVwdVBaREJBRmlxbnRhYk5ibGJuU0VQU3NEY29LeWowZnIrZGRQaDVl?=
 =?utf-8?B?SmxFOWxyblc3RlFLQTUwWVdrK0hMSzdHQTBYcEZZaVNxSEJsQ1doMk52SVVK?=
 =?utf-8?B?aUlZZSsvS2NacXorMTBqZmRENUwvZytaNU9iWTAzd0RRN1hjdzg3aXI5Nldx?=
 =?utf-8?B?eU81b21ZS2NmcUE0UUQxeEpFVXovTFBENHFVY0lCMzRMbGlreFdsQmhTQS8z?=
 =?utf-8?B?bmdkbm1QRE85Z0p1TlZXZENRWGJKa1g0aVdVbDRXMkt3TXo5SHg4M1dSUTNr?=
 =?utf-8?B?MGhVenZPNCs2c01mZmx0QlV0M0pZbmZhT2pGWnZzeXZBK0x0Y0xhNHlpZWR2?=
 =?utf-8?B?b3daM1dJcm14K1NHT2YwemdFNGxWNUFuMThDSHdaR2UvUnRrWFFsT2ZuZHAy?=
 =?utf-8?B?SUI3ZkhvdVhqQjgyV2NQNW5QQXhuQ3o3NkFnLzdxZG5qSlYwTXgyNGVkSVhX?=
 =?utf-8?B?dFFremg2aGM3OTFPU05jZEp1OGZ5cUdXRTl0b3pDamx2NSt3djdqam4yQjVB?=
 =?utf-8?B?RlFuM2ZvR1NCSlN2SzB5cHB5MGJRNVRMQnU3b053bVBoRnFzMzdrTkdFS0Jn?=
 =?utf-8?B?Q216Qzl5VEtBNGFsZ2lyWVNWQ1ViNkxTNmFKOElxNVdYL0JPSmpSdjRveW02?=
 =?utf-8?B?ck9oUW9FYjdqSE1HdW50V2drRkRvZkhhTTJTRVNDNm1QQ1RlT3RLY3NML2RF?=
 =?utf-8?B?eDUwcWZwbFg5WDFZOGM5SUdBK280UE9UV2Q2N25YUGN4VlhSMzFsZXo5Z1p3?=
 =?utf-8?B?WDhTWWpzeGpjU0NUOFVydEdYMkpxclV2Rms4SlVlSHoyVEFoMzg1ZEZTcXBj?=
 =?utf-8?B?ZWJTQkcvQW12TWFReUxKRzVhNHZHLzM1bU1pY2Jqbmd4RTV4aXNUWVd6RHNp?=
 =?utf-8?B?QXZwZVBRblVRQzlaUmcwempQVUE1WnJkb0FDekk3cG9YRmFHbjNiMHBidHBl?=
 =?utf-8?B?c2FGS3lDd0QxZGRoMlpnazg5N08vQUNBZ0FSVlQraEl3cVhiSzA2RDkvRnNy?=
 =?utf-8?Q?9a2hBU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 18:31:21.9500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0282af4d-de4c-440c-6227-08ddb4167c11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666

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


