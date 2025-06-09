Return-Path: <linux-kselftest+bounces-34462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC0BAD1CCD
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 14:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEFA188B1DD
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 12:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD5D211276;
	Mon,  9 Jun 2025 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uF0fuR68"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D71172A;
	Mon,  9 Jun 2025 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749470570; cv=fail; b=Lelef16/oP3WZizfTnlgsQykPEJsl5ibJNVjs4vLaKcXHl6mvrTv62EdfIJhHcQPWzieqeiw14cbTxotC3KpBg+assuzQ9mRwUl/Y/2F/EnYFUCe5Im5ZmKhH/UGe8qVxO+WcgBZrkyogVUzn64r0wFXi4QJNQKkgSdPw5xgfOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749470570; c=relaxed/simple;
	bh=qx5Gwh5VYGEm4DyIQAt1Eh+sTxntrRZytJlud9lKbKo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QsEXOONRpb71HWJ56e7KR/kkwbqrc1Id9oyDeIJOdRdg/jcoHznRzGNkok9xJWFJKZq+iyQsekS+Ft9ULzZqe7OlLruC3i6fLKQki7tK1Rn8gDBaFg+3JkNsHfDOSdBS3Omal3n4NN8mk1cEM3kcjPTdy05T8dqJoNRhrNI7iEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uF0fuR68; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwfXucXy+R1AW8B4KGbbjWqN9WAa0ti+T24YiFkCV1io79OxCQRiv2naXMBLwkpPHjqxXqBBNF1ZMExpSV3j5/IUhM5uuG/vEkAhELibyUFWhK70rFVdPHzXPh8I5TWWArimoNZZTPJumiuzdhduQ+ZDTjhjQKbZML7Yd8n2r79t1Zew6doNTiyphVoCrjwiiXBQo8asKsEuNJhVU6ENC3PWtRR4X/Ls8WbyDwHpr4ujZWpCnkYWDNrtF54thF3z8EZMc7HkUO1GyVBgsxRK3/BmqyuvAXZPYclpuaIiX5HMT6E9TSOtDNScZ0OMuJf2MXCR4I6mhkWBWjrUJ5MNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBmmznA2ir8UVvDOCM68vsTohlD4nshNv5esk58vHBQ=;
 b=Ya2nBPZGJdYMQ7TIn9WQWCTon0H6Z+fsO594TVSXXEHfC6VdOiIf5JWuiyXg3NQA84s3SYaGaPgAUctHdx4WJ9hjrJtQ0nKydYtIFMRRfJMmReTr/Q5L1dx/sG2mejmEsuXf+opucJyErMh06VjE6Z1PKRMmpDIKzXnrGoH3psprZ2ZvhgTXvt/IDjw8w9xsnhinqpVhfwlogiq3K6EzQUkyY0jzhEecd4OwLQ1NHnI2ohdugyd4bv1Z/X6L/NprlrLzzKhfPq26fTo14WhEFJSfRWFmH0/hacue7zwtHdesc7bC25FNeFQyVKeSeQMnPQCQQxs1uaqC1hBltzyrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBmmznA2ir8UVvDOCM68vsTohlD4nshNv5esk58vHBQ=;
 b=uF0fuR68oA6mcLGvPJWzbgi7ZHe5V9dKqoYFGrjwV/ArDytfSJFVeg5w7Gl89DU7AqD4Sg/aGk1kH19+WqR5z5E3+1oJxVtdPr7rNJXtGBzm7GWF+AbfEBxe+HJaOoMRXHL8mNSoO+g3n4mZ3s36Jt6SdXRtz44sFCBr/p76ckb8BHYLDUv20CCSn5P0JU41Lt6UDCWCxx2bv37WWI/C2/urYjsbiRQygo/a+MfK3PMKgRah937xMBT6Cey4QyuI/1tI7RiUibvE6ekm2GTFekMMU2u1qjv5fQ8hct5RbTCe5ilncZMrS4ofQLxdwWhm61zFEPXOiyY9urJtM+xMOQ==
Received: from DS7PR03CA0228.namprd03.prod.outlook.com (2603:10b6:5:3ba::23)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 12:02:44 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::b5) by DS7PR03CA0228.outlook.office365.com
 (2603:10b6:5:3ba::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 12:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 12:02:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 05:02:32 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 05:02:31 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 05:02:28 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net v2 0/2] Fix ntuple rules targeting default RSS
Date: Mon, 9 Jun 2025 15:02:48 +0300
Message-ID: <20250609120250.1630125-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: f01c6e2f-4b9c-43cc-be86-08dda74d8ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BRCyi8j91KeZYXNRozbEYORYDxWqWL4DU7I71/k4wGx8VpbJJwaPyCByz4PM?=
 =?us-ascii?Q?QNeoO9p9Kxx+C8ReeGtM2Q+jlOdJnVA0YZRXqaHha9bi/qD+G/8O8rtU1oWW?=
 =?us-ascii?Q?jTL7/BkIfJglaGMWP2+DlNL7wkwqhQSmI13l9cuW6LFfBJc90eGzUK1bkwS1?=
 =?us-ascii?Q?SN/9iCVX/o3oHdpuIteqmVc7AVEwjTmXb5Jl5jC4B1lDoBBpYkg5QPcvGSCa?=
 =?us-ascii?Q?4Wjdv/BawXb9d9CguJ3XIgPzSKeGeNbBdjqKGgQwF3kGXZMkbAMnhAfSiPkv?=
 =?us-ascii?Q?EVjH0J3jM/EwvqoOMcUZ0KJFv4JnjK/edOlXCN5CNJ6HBc/j/qPHLPUuunxw?=
 =?us-ascii?Q?hs0Stnmh7ptv3GbYdAIASI3DdoEJ9cbBFTrCpKVzCrCo3RpsJ6g+NIMGE5PV?=
 =?us-ascii?Q?uMwhiiGzfik7a/zLFXAjK+kY4XL1fLzCogsLzef1k4SQS08DsvKzCsHysFvJ?=
 =?us-ascii?Q?H9mUInkBFSsLWjMBChoNMlMgvM/nolzwalRhgBkqOWrhDA6dm6HKfDA4OPsK?=
 =?us-ascii?Q?vOHlab9eeHhlWr3R+o//GEgtzqaC5N3GX/5Y1yFKlFUA3Iwh9Wv7RPD67sRy?=
 =?us-ascii?Q?nUeP6rxgr7XS9ECl7mlA4EuR/+TiXwsYFa8zPn1prxZ6Oa7z6FEeaIncbgwM?=
 =?us-ascii?Q?HD8kOToLkUzNnRmVrCrNcogiQCOUG48vt7M8CXyrLPrSCNh5IlYMs4zqJe82?=
 =?us-ascii?Q?KiBbmQaQjsFmkGuPsrKdjmWBH1LYwXURR69hs5HGpny7w925ekSoe4a0FR7H?=
 =?us-ascii?Q?rd1JxTzswAjXtfBplS8LpiDxoblXsHriB+ihIaE5pe+VISL9hYV8YyT3r0gN?=
 =?us-ascii?Q?dw3Wozb8B5SF9Ezm/sIPIW54qtgM3OdTKJj5jUU+4xsJMxGeHWXeN4zLLS9c?=
 =?us-ascii?Q?LOhDxZLQpsM5hn9xnat8MoEdDW1QRKENyDXF0g1InPgv6IgJzm18FdzmlELD?=
 =?us-ascii?Q?+OLVNxjKHAxZslOksc4B/R0ZjP5JyViQI3ENs+Q1BXHO5LdzNX73C0zv7d4K?=
 =?us-ascii?Q?ZLK12TScCg4pnEfu/FMOl3lGArvWHk7O59KIBZSAnQJAshVYJdS9aKABJIif?=
 =?us-ascii?Q?W4qFG5GG9sLABlfS7HMGVLXpOHo/lV4hIrem57VKCIpHfNuFxwuCI5r+rOIX?=
 =?us-ascii?Q?dWysoM+uipg7rVq74GCsg7Oooi3YmYVpdh+PabqEvlu4FLPGYMHrlMJ5mXi9?=
 =?us-ascii?Q?arulkMXcWIct2Xk40h8We4aLWvI6i1ddMXiFa1D71yIW6jM6TQISS+NBdy04?=
 =?us-ascii?Q?Lj5Yz53OYeaa22CHi1s3ysoxYAZo8UL/NHy5JzHrNlZTZsBX0RXH0bGTatC0?=
 =?us-ascii?Q?4cXdCTYuKMkyWu0cvB9mlKv92dH0kM9MOv023gTA3Kuoz5CUUeA6atXIntgU?=
 =?us-ascii?Q?2D/YczpW7M0vmGR8ee2qK0SPb4QgGGaBMpWagfS+CxObL2dB4yK35HE0Lde8?=
 =?us-ascii?Q?29jRU80aFrK1w54gld3dR6n24+FgNIovvP7anR2sV1HhBnenlHNE3MlQf0+P?=
 =?us-ascii?Q?mLUOjF8lwW7BuKqlk1iUZ8Rao6a8LwSC9UqMCyWf2g627Xgbzx0N+nINIA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 12:02:43.9346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f01c6e2f-4b9c-43cc-be86-08dda74d8ae1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

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


