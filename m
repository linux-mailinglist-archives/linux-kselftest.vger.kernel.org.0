Return-Path: <linux-kselftest+bounces-37879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A71B0F49C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 15:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F71562330
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8876D2EE267;
	Wed, 23 Jul 2025 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yy9PAROC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A662ED874;
	Wed, 23 Jul 2025 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278931; cv=fail; b=hk4PMVAWUUh2fFs3urLAgiJSaCQpd8i1P5Oq+BFyAfDU7S1u2brkhvdp3yMBdC5kmqCGJ4ggYKF78DaZiBeGQ0mUwCZfUyk6f4ar+cap+i3qomvXD/lU+hiz6B74Yvafur5UJaAoTEeW+83E8lEyjeeHkbP4Eq2VQCwDAd6fYSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278931; c=relaxed/simple;
	bh=CdyQ2J5gMQHRAhlvy94P9uyXciuW9PmgnZHDXhsPG5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/IEQGXiHDuOdyz7iTT+fZJuI23jMbCwocMU6SttPGj2SPUKoPZl98eWofdrYVct7iTjaJ2cGtmWERzZ0avlmeRZROHdXMygEvf6jCzaP+r1hsuuo0P3WFUtNDVmjN4GO+5ILXfglnFG2BeoWQ+4fjc+Xredhl+UGzK5tqtdl0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yy9PAROC; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNQ8gPCJUuPwEJL1ffiJz31rbpDDlE67NKwNcQTZuPEaKHglGATrWjJh/o6Rz71akE4AvOUDjZd4IWa2nvoHhLtyd12My+Xt1LocKgWe/BGF/+leR2YW8VZkV1Vzm80CMc3xj/w0DpA0mioBdcgM+4XWlMPBBNdexHmaX6HMmg/cJLmtCHOWyhW+LPlL8eFC+8qrp8Xjbz+G51T4ikkk2lCgVufLlkYx8nH1I9pM0d20TNlFvd/MlloNmkMnoE0X84+yUd28V+A53O9MQxXEAs0YUJ0+eWXkSi4t2BaHharQ5Ew5aITP2DhRM9HBi8N+mt8gTQKsPjGmYyAGnC8GSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIPzahQUtan3JKEI8gIXqlJ61+2BOYtC33XIdBPHfcA=;
 b=Q4FQsl8WPPALz3x4eGNWFIZSDKf14vicn6BLhSJ0Wy1UIF72iUGB6Bdat0LQTNKdx7S9PX+0DKgf8Lt2Xf5z2botz6IAJ1jbM5Yf/ht8pO0/oSFFpeWFDPj4AE6xAT8+iHTCzNh9kZtA9R/Prl1EEM+BDSkPRbWziza7pHy470nPlUUSR6Vf9d/wmFwasUVZ705FMkA/ecp+4SlIE5SY6hmUgDxTgPxDNYFd1kfeDtBdAh/rmD/zlDJGIg7K2j53WCX5FZjYJFZzx4S+dSNa8xeRr11Rg3LnVj0luZua1Y/hlYyWj7cZh4i6S8Q/Kt+1Ug25/l2OQVTbMVGhauOwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIPzahQUtan3JKEI8gIXqlJ61+2BOYtC33XIdBPHfcA=;
 b=Yy9PAROC0iblfO+ySgvQDvju2xOZhIKSILiQx5luhFIkYBY2oG0CqHKkKr6vEhMgELtVFcgP6eWeu6vDSM4MazWh9dVpvTnP9kLMUeaOq4eiL17YPT3FgMWjDJZgaNRJ6gDzcS4NvxSgZ71mbZaXDdozfwR926J4of9cXXw+zzYsGxO3XN6JogQcG6eXeJlLZdfLBwKBRZCy5nxDo9+1oyWaa9mRlxEnuXadOsIGgAhI0M8adbsSUn5TtcsXrI99sE2YTbmFNoTVSCwRUw1Me9FLsiS1DLrxFs0zfCTHUjVUN9G3elBh7OBNGWR05ISFeqJim58CJsNfQC1DUwUyUQ==
Received: from BN9PR03CA0709.namprd03.prod.outlook.com (2603:10b6:408:ef::24)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 23 Jul
 2025 13:55:26 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::cf) by BN9PR03CA0709.outlook.office365.com
 (2603:10b6:408:ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Wed,
 23 Jul 2025 13:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 13:55:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Jul
 2025 06:55:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Jul 2025 06:55:08 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Jul 2025 06:55:06 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Nimrod Oren <noren@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 1/2] selftests: drv-net: Fix remote command checking in require_cmd()
Date: Wed, 23 Jul 2025 16:54:53 +0300
Message-ID: <20250723135454.649342-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250723135454.649342-1-gal@nvidia.com>
References: <20250723135454.649342-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbcd80d-8c6d-4040-06d7-08ddc9f0931a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Auz8SOsTiF+7ptyrqGYIo4MeAhpzIoBpfQJKgDsYMh1au/H5uFWcZkOIe+IR?=
 =?us-ascii?Q?cLbzsLKgyqGH+xdHd4BvuHDIzX94hyyOXEFL/dItvT58m+/bYvUQJZYLSWm+?=
 =?us-ascii?Q?JiuRHvswoM6YS/Zihrj11RvPc6WtgFh9cbo/WSv2OsbjPFNTIYHGjIk/5raX?=
 =?us-ascii?Q?2+TC15zHLekXRAUM4K+pCLAzxktJgmQ8Oii3nO3BSW7wWHv9VI+gn1cuMDkU?=
 =?us-ascii?Q?fgYgRKMoeNqUah9PkiwU9vOqAzS6Wk0yjeidlvG+kOs63I0Ra1Lu6cCe/Sib?=
 =?us-ascii?Q?cZPd9XEnkaOoJdO3nGIga/4A93oumpxyXcDh1j/CfxSBgZM9VlaQ1p67j7Lz?=
 =?us-ascii?Q?MpxAcDov0a/bxf+qCv6la6nftmC1E9+1gFAVav8OkeFepp3QYfBgwxCMOsSN?=
 =?us-ascii?Q?QtxSk54Um27aBtCM8PnHZwV9y+0IrF6A0J0HgtXAUhp9mqOnp7rPX3KAv4Uc?=
 =?us-ascii?Q?mG734kwbPebROhOv2/scv/Y55m5pENoQyB2/ZtqnGPJvrdZfy3kT6k2vaGKg?=
 =?us-ascii?Q?h0zJntVwqy6gbATjwEcTXYiHitpCl6eW/nXIdQAlcz3UTAZdYk6njsUPPnnj?=
 =?us-ascii?Q?K7kyJu8Om9zaX1EjRTRrRMNVQfaVePCgQvxjKz5gjy9uRBkBwjybF6G2/jKD?=
 =?us-ascii?Q?w8JPtTXFMtQvKL9bvTgLC/YW0UkBRAD1r1MRzsJL129zkjK2n4GzZ3upUWKi?=
 =?us-ascii?Q?XQ1gyRo4Wh0QfiuWk3ws06OnmIQpuucb+feC/7vRRtNypWKLbwQ+H1yc6qFo?=
 =?us-ascii?Q?3w1YKYu/e67nLaPtTPlzZyY0s6X2N4j4mDpSS9jNqkVbB/RDMyCNq9SG2uel?=
 =?us-ascii?Q?9TsIQliV+jdUubc2xYi7tWMrkg5dPFirCe+Nvg3nJATd+U5ejLOWz+Y7GDZ0?=
 =?us-ascii?Q?uyJAPOaOqU3EAsSBK3WIw0HeokZqQzDmNB1QG3ovAPvKuPGK5ProA7R7CPsr?=
 =?us-ascii?Q?7kwPtMo5n40vcfMapVz1U6iDZjh9KA4RMvdwy4Pa6SZUxS+NjL273p15lN4/?=
 =?us-ascii?Q?83h241qqTvR2TSVlsDa4tCwd6MohPMr+psTVL5IS+pPIhVqvWhrrQp249SI6?=
 =?us-ascii?Q?PhwMgSHGnbE8rHWOhlafy/Msf8UbN/6OPdaYogi34wLDflwDxOQr6vPe1ObJ?=
 =?us-ascii?Q?OMry9IiTYDGdR4+2c3AtIwPBSuA3xPpxy6QvO/SgMQI+KZYPeSmci6YhPdxX?=
 =?us-ascii?Q?HQJpmedSk9vNzEJlQrcq3ukwizcL3N8zEln4a7qzFpOysZ6chp6IE4b01eqv?=
 =?us-ascii?Q?eAL8NYvYmxSxOXLI6iTIBCU9hYeO6FUHKuqh3Ec/PJn/gVqVyfmc97KCJ8WJ?=
 =?us-ascii?Q?B3WrkTWlmcxhixQm4hOiJ6sMv5a/Vm9A5EnAIqwUxXYKvYIJlQB9KC7nVtzb?=
 =?us-ascii?Q?SGGQoveJnOfQwC/DR4Vm08RDotXjhzSOOpBb9330BldD7jk24nHh3t1s1n1L?=
 =?us-ascii?Q?50fUbWBGkF3bYrjfsyn0S2t16pm+C/ZOVMaVIQ+7PgjBR/xda9wsd0zRYVOk?=
 =?us-ascii?Q?JPAViL3x/acZUTorruCJCHknT0GZJUtsKs7l?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 13:55:25.1919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbcd80d-8c6d-4040-06d7-08ddc9f0931a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237

The require_cmd() method was checking for command availability locally
even when remote=True was specified, due to a missing host parameter.

Fix by passing host=self.remote when checking remote command
availability, ensuring commands are verified on the correct host.

Fixes: f1e68a1a4a40 ("selftests: drv-net: add require_XYZ() helpers for validating env")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/testing/selftests/drivers/net/lib/py/env.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 3bccddf8cbc5..1b8bd648048f 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -259,7 +259,7 @@ class NetDrvEpEnv(NetDrvEnvBase):
             if not self._require_cmd(comm, "local"):
                 raise KsftSkipEx("Test requires command: " + comm)
         if remote:
-            if not self._require_cmd(comm, "remote"):
+            if not self._require_cmd(comm, "remote", host=self.remote):
                 raise KsftSkipEx("Test requires (remote) command: " + comm)
 
     def wait_hw_stats_settle(self):
-- 
2.40.1


