Return-Path: <linux-kselftest+bounces-34794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3FBAD68D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 09:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736371BC4047
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 07:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14A2221FDD;
	Thu, 12 Jun 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dx3ocwqD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45E221FD0;
	Thu, 12 Jun 2025 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712792; cv=fail; b=C6ZvnRKdpkS5b5D19SCdVP440xczMC55A9eEnr2wFQf557+36tamQ45p2C754NeQkLQpLKuAstI5hwurIYR0WNnUnNojq4eIbiRzIYg5rEjdXcxYdghLjARHRI8XOd/uD7d0f6vZ2+zrIICGyTBqJ9wygDvMURJ0F+QIN2OHX00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712792; c=relaxed/simple;
	bh=uoPRFHkmDWR8DcrSD9Nr3nbqY8PhYYQDhceo9AhUEfs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EVbDQwj84Zh4dJRVLbxZ3ZaVJ+0W/MC7qveP9Z9Rh+GgZ6Q41V2ez/RCYR2kyS0xouzumdpDJwVSufrjIxdoapy3234puZr5t0lnpTe416CWCI4tkMX3l+I4QuCNegdOZ5+0/ZT04k2twNIec1tY0EpcT0k9uVhbZJQdOlBgAqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dx3ocwqD; arc=fail smtp.client-ip=40.107.102.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJoItlwhhuTczWSAWbpqfBuM+YoCkuYPScFZWztujXBQJPv3qoSzveR5IdR45Z24/82hzqmexQyy9zqcADcBFWOTYghcAouNsAuGoHoHTmDmjXoPA7YjOjPgWP/oGNt+dArhjRsquD2DHFgWxbJFiClGECAE21H6GVv/kSmHzT7tzFTcDTyDXCBxjS5JcknbEO2X7FmpJMmq+TeldO9wbu8G7ufL97HTm2G1AeXnNH87xzzw2L5jq17mvm+N8m7j7joI02T/TfHrEwPUhmTp5drxSp6e24P/j9NYe2DcOu4OMhAW4XBNIkus69PJev6yB03xykibZDpmGa97BZI6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgWe6+oeXrgE6x87j81MMayCFrqD1A4dDHOolClPz4k=;
 b=PFt2Muwn74foR9MVhmyHfOau6/Sc6P5CwdK/bKQ523yxmkJnZd6Z8m6q8CXNfbRt0n5L7FKq9ljWTlzU5HCtBlC25Aq9k7eif1i/BMqQDhi7z2X4BBFuIM4JhnMihrK88BPVl8732pc9/QfaGNYgoqx8EtEenetoBw6//ptLwABNLuActlZlDwKR3wrZAAlr/2fL2Mdr9Ki6oLLLZ+AZ2UW7+V3Dz3W0WBlYXph/3RT5KWkY5A4B3XOVwVXjLFAaT7it1d5Dd49iHLuNwxyrfCpcpGM+eyBWvTxi7eAMnYbUpy07XC1oqeDy+vmjUoFus8w+N34Zv21erILyqyufzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgWe6+oeXrgE6x87j81MMayCFrqD1A4dDHOolClPz4k=;
 b=Dx3ocwqD3B3/xvE6K7SGFfr76vRXn8SEaKVv8mTua7uUsD6jabJmV+hukOxDxenOvw3NoxSFvFs2JrUso5ib/ZqQj1IKOmFQFvIC2XnRyj31buOPj+451XeePdtkK229S/2MDQhmusTdIcZKj9nO/UMb07pgz+wgURKTGVeJOGrBUbXs983XlZwa/bJ3a3/5aU4/nGFkEHmMfgNQwYeugHosePs3zQtgWJMwseo6uLVUv37HUXG1K8YOOjSiRhJkR7QD6j6ZcdEf7TISR67fqneLLSwkijjoEdeP/BA5OT0dJZ8novadSShC5X/nLL/N1ukq//bI/lfIHNJcf3TCwg==
Received: from DS7P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::9) by
 CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.41; Thu, 12 Jun 2025 07:19:48 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::71) by DS7P222CA0023.outlook.office365.com
 (2603:10b6:8:2e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Thu,
 12 Jun 2025 07:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 07:19:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 00:19:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 12 Jun 2025 00:19:37 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 12 Jun 2025 00:19:35 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net v3 0/2] Fix ntuple rules targeting default RSS
Date: Thu, 12 Jun 2025 10:19:56 +0300
Message-ID: <20250612071958.1696361-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 888172bc-de4e-4432-575a-08dda9818324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wTFjBd6wrIv5wWJzLScrgZai6rDrvmO7zX6VB+kDA/mWc9GcKffRCPNdYcQk?=
 =?us-ascii?Q?Xu01CbqdaQMySFqOTgxVKXolOLL7gYygQJYzED1MYk8d97AYHqnHRHqA9D8V?=
 =?us-ascii?Q?YGs0b4ZIhbY9BVFFJWXoonMkNeSM8gcncujYujtrj4GA5615GfivvZeVorga?=
 =?us-ascii?Q?yShWNKXJowKgayUMWb/Gyue2bhBfsT9G+YED4Xa4pfiIubeMzYWkj6VVFVfx?=
 =?us-ascii?Q?3LTDbZrAxex5TI/bjz4mHAgtKxouIzMvv9v2+Y66RDDphVn/6yOLObY1nwr/?=
 =?us-ascii?Q?TIL9ijjwLjcuM1l4vgPwR9nDuNUpNbmgXFM6NlcftgjjNJZEJDhOCWBW4g5v?=
 =?us-ascii?Q?Csup4nsQiF3B9qlOY21uXdJP5IVqZdnD/apyTfy/KwK68TNtd2AHf7+otAru?=
 =?us-ascii?Q?Yi+OWghHQMODXVQO68ef7pyNkSKVgiTSWDdhD/Cgtqgz3wm84shy5ZBXqST+?=
 =?us-ascii?Q?5cisFcC2aL630zwhkLifgTBp2kvUJhq9E+bsKlbtMu3YMJ1V2by3zP6TCwG+?=
 =?us-ascii?Q?Wsd7053sPEZyMpqlT7I6gub+bwJzd+IxCTKSTrDx5WrctZ87xc6TA1omV2zc?=
 =?us-ascii?Q?7wcXuqe+oaQaywBDT6hJBOeLKDcEWV9Mhhs5qZrMIG/6MjtuHNiu3pQl7rpS?=
 =?us-ascii?Q?vamEKt+7MGLIqpvT2CzPE8PbXFijTBifFzT8RPOL3zkJ5JpcPHN1bSXbWHGh?=
 =?us-ascii?Q?OiM9z88NAV/mkEUJ3+YoV2oUcll9+qETyh8LDij3uu+5rRhRnVWmHQO3oB10?=
 =?us-ascii?Q?jfBh1GfTM61Hy2YN01hiY1e2D6YCrALx1T3bDuZvgqTGCJFaD6PsTSVpR20O?=
 =?us-ascii?Q?62erXZJqLShE66erSlZ3jc9Mdi+0yZriYokUZCzD/TU+xg2aAfZtwfOvhYQm?=
 =?us-ascii?Q?P809WnY0RA/87ziFMKH8ubgYXYbdMDw4xeQdJou314fHbpBWD6ah4LAyt7BE?=
 =?us-ascii?Q?XepcEH8Ld6NGJyzRYSksta9gLmPHtJYKL9w6gi5IoFpjHMpJg594jSJY79l0?=
 =?us-ascii?Q?QuUvHNwzuj6WHf4eB1qUgJlatpG9egfVKqqyE1b6Jq8sbao2MklmbFCJhk+K?=
 =?us-ascii?Q?bWN/KmgIbnxFAXm+aNhVf2ydeIcWRruzztuNMQVnZaphFiKAzhK1zxr888rk?=
 =?us-ascii?Q?ksHU1G4ReQP97KGMKb8o5dzIYaokxaEPHMfW9SPdbVBzFL/2lQjws8I47F2B?=
 =?us-ascii?Q?ZZFWBjPwQ7PkJrD7+6NkkbupSv+gPM6FcN8y5f6GRkLzXKfYqm2feZL2Z7QK?=
 =?us-ascii?Q?0OQWer5WHS/4nFLkodvX9EAq3MlDnUcQeSpn884l7YUgzUF02KHGLkNWYFJ1?=
 =?us-ascii?Q?kRIJAjzqv0Eg/rrRF+wp1mVzXUFKggnjRv+/s9aaqOGkw8q0nbfJ1/EFdoWi?=
 =?us-ascii?Q?q8gsgQWYEA/f524OrmnMCz2VDdnKCaKecdzn2eO/RPdzYIl05f9S8oafdv6P?=
 =?us-ascii?Q?T6be2pbYOOacIr71KZnnv79Dahojd7bcPiEGUeAfBMOEC/0NqPDc5kRzVm4s?=
 =?us-ascii?Q?DPZG+pWmYn6FqMmHN4CRWFgOFPr5MP/Ue7SKiS/f9PqjQTHR48KD239njw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 07:19:47.1192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 888172bc-de4e-4432-575a-08dda9818324
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227

This series addresses a regression in ethtool flow steering where rules
targeting the default RSS context (context 0) were incorrectly rejected.

The default RSS context always exists but is not stored in the rss_ctx
xarray like additional contexts. The current validation logic was
checking for the existence of context 0 in this array, causing valid
flow steering rules to be rejected.

This prevented configurations such as:
- High priority rules directing specific traffic to the default context
- Low priority catch-all rules directing remaining traffic to additional
  contexts

Patch 1 fixes the validation logic to skip the existence check for
context 0.

Patch 2 adds a selftest that verifies this behavior.

Changelog -
v2->v3: https://lore.kernel.org/all/20250609120250.1630125-1-gal@nvidia.com/
* Reworded commit message.
* Fix pylint warning.

v1->v2: https://lore.kernel.org/all/20250225071348.509432-1-gal@nvidia.com/
* Reworded commit message.
* Added a selftest.

Gal Pressman (2):
  net: ethtool: Don't check if RSS context exists in case of context 0
  selftests: drv-net: rss_ctx: Add test for ntuple rules targeting
    default RSS context

 net/ethtool/ioctl.c                           |  3 +-
 .../selftests/drivers/net/hw/rss_ctx.py       | 59 ++++++++++++++++++-
 2 files changed, 60 insertions(+), 2 deletions(-)

-- 
2.40.1


