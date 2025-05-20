Return-Path: <linux-kselftest+bounces-33414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A133ABE2DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 20:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1911BC0BDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 18:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6127280010;
	Tue, 20 May 2025 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NBLcvbhN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36EA2627E9;
	Tue, 20 May 2025 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766378; cv=fail; b=N+NfVlJNRk45vAcfuk/ksWVUBGnl0X2nWEMf3QXcyOiPQRd2sdbUSZNSPnDibPpWeq5phAE0iV4x4hgww7rbHjl9HJSEvN+L+hLgwmHElbRAkiTmeihcxAYECvjMqb8W674WLaAoJpCdsP0zVbzI5ytgE4ec1OiahKbF5HSeCQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766378; c=relaxed/simple;
	bh=oWmQibJk/KR7o27nJ/82FMpIKYNQEI8XRmJ51x1IWKA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ewJU1LqvdsgY52Y4P4xzL0HYAk/GrjfBur4sMOADvyxwHwbBwU9eujtue7COKHVKXiiEdFB2OVivytnWg3plnOIAMgVaXRUtKbzqstm/2rR27Zkv5DPOO7AgqmhLJMnYSbRWC/Ti7Yi7AiJ/aW0aOwui7Wl5kbjub3XHTLOMePM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NBLcvbhN; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGwTu8YaDpmyEXBAohguJSNTR9KAPoQn1wxrRQctHbiHd1YLVS8dHPHJLbQsGuVTgVLm9YiFgiAc0AhdIyAH1hJUzFHRxWigpxhlFgwwd8accZ4IldCLqyMsncMh1HbNqD4bjRSoZCfxG9J87M/oZDbEqtXCdNF2/R85yxNj7W+z/oSyv60F8GhrAYqh6Lhx6ybIra2B8WeQyyNFxz3mzul0X6I8HvdaQsL/+kaTwWV0XYhPuWjth0ZGfvW8YYghaTulr3eCFril3nyvrcelDMnj6vmYWbw76pJtvgG4ontieqGxk4uGYEuHZc73njU5pGVbrh+QWVrEenqFmE3Dtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S08MoZoETre68c6k1VgZZpEet407UhUzcHdX7CsqzSc=;
 b=j555MsQE+/u4JNoRIvkD9mFOhvQ+fOEjDY9NdkUnWYOzLO2T8065dVbV5otHefakUsOcqPbkjrpL+p8XGEeT7p+alYtnTf3xJ2Q8YvH+aJfIbbeMtwRQ77WYdJBJQlsKGkgBsjldSpUW5GFBCC0LKPMfLnEuyM5A/Y9tSP+jhdq1EMYYyvP1IJmczwk95hveHL30/EEASdwZVc49orAwG1fMKBKBip+AaU59ADWOkPq006iL1UoYfNi8GLU7icxc9Ytm7amtjRpXO2X24JWywOwBexwjK0kZKLRss3B4rXMCF8T0mf7JL4izyr2nlJ92QrN1SeQgFrEJY/AsXFu5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S08MoZoETre68c6k1VgZZpEet407UhUzcHdX7CsqzSc=;
 b=NBLcvbhNmg9FgzJmHxUiAdQD03lxKWWonFgqrE7nal4bNyjzR1AnciQoLxfSJUKKnmhVXmjoE7PvMGYAsh3aw9IsswCBjRBOn7Ur1GK5BW8vVQsPXTN35Z+fOB+lrwpT0y2NsczbfWt/o9i2XToBSb5PrCfdjhp1gC0WMwq+qCyxKZXwa+6FCYwByBvNP7s/ZPuHBQruERx/CamK5EodrqLJzb/6VW+xOhp9akyqukBVftv+ik1omgY2aJOS6gePu3+cmp6ZjnFS2dtGWlaJ6Q2KRS5E0LzPUUXHwTJlammOZnP582RZ58BJ2+QVL5abUxa/Ru2QDsR8dkZ3lXZtqg==
Received: from CH3P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::16)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 18:39:31 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::62) by CH3P220CA0014.outlook.office365.com
 (2603:10b6:610:1e8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 20 May 2025 18:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 18:39:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 May
 2025 11:39:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 20 May
 2025 11:39:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 20
 May 2025 11:39:12 -0700
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
Subject: [PATCH net-next V10 0/6] Support rate management on traffic classes in devlink and mlx5
Date: Tue, 20 May 2025 21:38:01 +0300
Message-ID: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 067bbb0f-2dee-4a42-0a27-08dd97cda8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ky83YU52ME9EZDlLcTZuM3FxUE5lUnlyNzRZNytId3YyaU5nUHQrZHUyWW5j?=
 =?utf-8?B?NFJ1SjZkdmo4ZlJNV3RwSVJCSklSYXBlcGd1RmZVNHVmaG0vTWhLQjNFRXZh?=
 =?utf-8?B?TDB5bWtxOUZndUJCTXJYWUtYMjU4aUp3c1ZZWTdvZmxWeWU1REdydDlKUmoz?=
 =?utf-8?B?V0kzZkNlMU5TNkh4THFLMzhnYVJzNnBWSUFyb3NnbGVMdGJPbWJjOENodC96?=
 =?utf-8?B?bUJJNDJPOFg1Z0dVWFF0aW5Ed04zRC9vMFRDK3Y5ckk5MlVSdlk4dWZwbTZk?=
 =?utf-8?B?VHV6MzNORE84cnl5T0N2YVNkdkNmQ0JPa3pHTmtHbk1ibXdaelZXYVRoM2hz?=
 =?utf-8?B?QWJ0YndrZTB5TnczMVNuVHoxWjJlOWRUZWg5a3NHWWFidElXQ2VTZHlya1BK?=
 =?utf-8?B?bjl5S2FueERtdG9rT3F3RnNrMnorQVROUmx6a05GSHJXajNxOFRQUWNHSkY1?=
 =?utf-8?B?ckdybXB6aFFDN3lpZXR1dWdmMUNvVzJVcnZSN2o4ZE9Yc0F2REg4czFMTjJy?=
 =?utf-8?B?MG5DUTQ5cGZsNWI0ZXhuYkg4NStmVnRVZkgxMks0cTNxR3VCcEU1Q0Y5UXp1?=
 =?utf-8?B?YnB4NnlscE5FZG83SDBaM2ZnYVFka0IxVTBOUnJQa3J0MUdvWlNuKzJ0b0tP?=
 =?utf-8?B?YU5uTENpdDNNTVhpdU5QZUFqL1lWQUpXRzdHeDJ0WWJJZ1pxcllWaUsySzdy?=
 =?utf-8?B?NVdXM2t0TmxBY1ZST2NacllRbkhKcXdHRWxOcENYSkhrcUpvL3loam5vMlRO?=
 =?utf-8?B?WFRIcEIxNHRidXpTVDhVZ05DUEQyRU9MYWVtbHhQNkIrVDF5c01RRElWR2Rl?=
 =?utf-8?B?ZXMvMVhOYUgzTi93YlI2M3dGWU9ZZkY5K0lJMnVWS2Z6WW5ES3JFS2pod0R0?=
 =?utf-8?B?Qzh0SXVZZkZtZjVDNWsxcTUxcURhajFyc0Z3ZnE2Wmsrc3l0NUVkdnM3cXV5?=
 =?utf-8?B?cFNtcWRDRkR1Tk9LUlJZOG13aytPcFdTMm8xZzEwV0VRN0tOYXlNOTJod3oz?=
 =?utf-8?B?TU9JWDdTS2FRWG4xcnFFRWlwMVZBWFp1TkphK3kzc3lGd2M0VWZCUDRxeVVx?=
 =?utf-8?B?bFdCZmFZZVVyWWliQkZBWGhnNGxqZytFbXIzSmU0czJLK0hJOXhRQ0ltYXB4?=
 =?utf-8?B?UXhLaGRNN3lCbnByQ1djcFJsbFZ3RVArWmxwWGhVbXNxSGlZRjlCYVMybU5o?=
 =?utf-8?B?WjdYTXdUZmNBVEE0MWJ4Yms5cmdwVktJdG93Z0thZjVGbHV4bU9rZk5qN0x0?=
 =?utf-8?B?YWxDODY5Ni9qVkFGNFd5OXNORXQzRnRXbDZhN2MxZnNaR3pWK0luU05nNmNX?=
 =?utf-8?B?YjRnRUc2Q25mZ3h0OVo2dzlDQlZ1YzZTbklsRDNobEdLRG5CN09pNmRJd21L?=
 =?utf-8?B?ZUdEZU5leHQ1WnlvNjhKOXpzMENVUlo0Q1p2KytaKzFWK3N1Um9CL3RBTEFj?=
 =?utf-8?B?WHUva3JKSWowaVdLREdLRVZ0WlpJVHE3czdveGlTRzgyMmZubzFqZFM4T05v?=
 =?utf-8?B?eHNXbG9vZ2NUR3ZCYmZkTTB1RTBIWnJpQkxIQml0eXNCQnFrdTVFVFhiRDZN?=
 =?utf-8?B?UEk5MTNBcVg4NTVtclhmMVZRblYwS0NFYWg0TUpRVFF6R0c5N2o1VFQzRXVI?=
 =?utf-8?B?T3JpZDBKUEFiMGh1cU5ISzVjVTNYOEpMSEFxeWF1LzdFRXpPa1BWd0JUQkNm?=
 =?utf-8?B?Tm92eE92ZWZIdjFYMGgweURONTB6MWJ1TUVPWDFHbi96ZVE2MlY2N2V4QkRS?=
 =?utf-8?B?RHMzaFpxZTJRN3NUdTVLS0FvZCs1OEtnc09zc0dRQ0tKdDZRN3orSEs3YWZP?=
 =?utf-8?B?ZnVuYk8vVXdaVHlEVDMyVTM0elQzYXJ0N1IySFN4cWcyOTZqemxYVW9xVVA0?=
 =?utf-8?B?dERCaHVkWU04OU44bEo1NzlLNFQ4ZDVpNzc4VDdCK3V6OUpBWmVLMFZSeTRT?=
 =?utf-8?B?VUJVTDJqbCtyVjdVOEVOY2hoU1c5MUV4VllWZEtiSDhFL2xkdThCblprZWJS?=
 =?utf-8?B?TWNGR09rekFHdFFuYTlSY3E3bGZZTjhUblc2bW9xQXkyR01BMHhCcDJWMnZT?=
 =?utf-8?B?ZGl0eUFQbEsyWkI3MlVNVlJpV3p3R2c3cjM3UT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 18:39:30.9426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 067bbb0f-2dee-4a42-0a27-08dd97cda8ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269

Hi,

This patch series by Carolina is V10 of the feature that adds rate
management support on traffic classes in devlink and mlx5, see full
description by Carolina below [0].

V10:
- Added netdevsim selftest for tc-bw ops.
- Dropped header: field as it’s unnecessary for local constants in
  devlink.yaml.

Regards,
Tariq

[0]
This patch series extends the devlink-rate API to support traffic class
(TC) bandwidth management, enabling more granular control over traffic
shaping and rate limiting across multiple TCs. The API now allows users
to specify bandwidth proportions for different traffic classes in a
single command. This is particularly useful for managing Enhanced
Transmission Selection (ETS) for groups of Virtual Functions (VFs),
allowing precise bandwidth allocation across traffic classes.

Additionally the series refines the QoS handling in net/mlx5 to support
TC arbitration and bandwidth management on vports and rate nodes.

Discussions on traffic class shaping in net-shapers began in V5 [1],
where we discussed with maintainers whether net-shapers should support
traffic classes and how this could be implemented.

Later, after further conversations with Paolo Abeni and Simon Horman,
Cosmin provided an update [2], confirming that net-shapers' tree-based
hierarchy aligns well with traffic classes when treated as distinct
subsets of netdev queues. Since mlx5 enforces a 1:1 mapping between TX
queues and traffic classes, this approach seems feasible, though some
open questions remain regarding queue reconfiguration and certain mlx5
scheduling behaviors.

Building on that discussion, Cosmin has now shared a concrete
implementation plan on the netdev mailing list [3]. The plan, developed
in collaboration with Paolo and Simon, outlines how net-shapers can be
extended to support the same use cases currently covered by
devlink-rate, with the eventual goal of aligning both and simplifying
the shaping infrastructure in the kernel.

This work was presented at Netdev 0x19 in Zagreb [4].
There we presented how TC scheduling is enforced in mlx5 hardware,
which led to discussions on the mailing list.

A summary of how things work:

Classification means labeling a packet with a traffic class based on the
packet's DSCP or VLAN PCP field, then treating packets with different
traffic classes differently during transmit processing.

In a virtualized setup, VFs are untrusted and do not control
classification or shaping.  Classification is done by the hardware using
a prio-to-TC mapping set by the hypervisor. VFs only select which send
queue to use and are expected to respect the classification logic by
sending each traffic class on its dedicated queue. As stated in the
net-shapers plan [3], each transmit queue should carry only a single
traffic class. Mixing classes in a single queue can lead to HOL
blocking.

In the mlx5 implementation, if the queue used does not match the
classified traffic class, the hardware moves the queue to the correct TC
scheduler. This movement is not a reclassification; it’s a necessary
enforcement step to ensure traffic class isolation is maintained.

Extend devlink-rate API to support rate management on TCs:
- devlink: Extend the devlink rate API to support traffic class
  bandwidth management

Introduce a no-op implementation:
- net/mlx5: Add no-op implementation for setting tc-bw on rate objects

Add support for enabling and disabling TC QoS on vports and nodes:
- net/mlx5: Add support for setting tc-bw on nodes
- net/mlx5: Add traffic class scheduling support for vport QoS

Support for setting tc-bw on rate objects:
- net/mlx5: Manage TC arbiter nodes and implement full support for
  tc-bw

[1]
https://lore.kernel.org/netdev/20241204220931.254964-1-tariqt@nvidia.com/
[2]
https://lore.kernel.org/netdev/67df1a562614b553dcab043f347a0d7c5393ff83.camel@nvidia.com/
[3]
https://lore.kernel.org/netdev/d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com/T/
[4]
https://netdevconf.info/0x19/sessions/talk/optimizing-bandwidth-allocation-with-ets-and-traffic-classes.html

Carolina Jubran (6):
  devlink: Extend devlink rate API with traffic classes bandwidth
    management
  selftest: netdevsim: Add devlink rate tc-bw test
  net/mlx5: Add no-op implementation for setting tc-bw on rate objects
  net/mlx5: Add support for setting tc-bw on nodes
  net/mlx5: Add traffic class scheduling support for vport QoS
  net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw

 Documentation/netlink/specs/devlink.yaml      |   35 +-
 .../networking/devlink/devlink-port.rst       |    7 +
 .../net/ethernet/mellanox/mlx5/core/devlink.c |    2 +
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 1007 ++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |    8 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   14 +-
 drivers/net/netdevsim/dev.c                   |   43 +
 drivers/net/netdevsim/netdevsim.h             |    1 +
 include/net/devlink.h                         |    6 +
 include/uapi/linux/devlink.h                  |    9 +
 net/devlink/netlink_gen.c                     |   15 +-
 net/devlink/netlink_gen.h                     |    1 +
 net/devlink/rate.c                            |  127 +++
 .../drivers/net/netdevsim/devlink.sh          |   51 +
 14 files changed, 1289 insertions(+), 37 deletions(-)


base-commit: f685204c57e87d2a88b159c7525426d70ee745c9
-- 
2.31.1


