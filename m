Return-Path: <linux-kselftest+bounces-25075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBFEA1B1C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 09:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A29816D34B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 08:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867231DAC9F;
	Fri, 24 Jan 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LLJ4PaFw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A7B166F32;
	Fri, 24 Jan 2025 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737707735; cv=fail; b=VLQML8l196QwrFh/zrrKlwqnEmKLZEJYOzV8csKvD1pTv7SQcM+jeo4aIH76R6cn2PbbW6SXn4ikE9IIzRp7sRGoke9zfwmrDW7OwB+KDsQb4/jIDEESlp/h4X8WDkTkJYH8s3w57f/uDVHEJx4sjk154hTHeKHza66xmr80/wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737707735; c=relaxed/simple;
	bh=ZOkkM9k/6QE3ChdgYNkpSCENTtous2nkvSkDMthDYy0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YEZCtaM6EdNb1Tg1SwgPBkItENSH1z/zjXYIondlhAerSiijf9sf0HSWLl08iRB3OTcPBWK3uDXpx+0IUL2qzHMiff9l3fa5EyYP87bUrbQ7TzfLQYKbrNqNEsSyIC0fYOwwMFqZn9y2inVgpTI7s5mwrn99U044L4fEbu5oaug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LLJ4PaFw; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCd9DDi+kRndNdqO2C/qTr1jlqxW78uaqvuqo3fUSzEgYMlQ3Off6/EhN6tjhgTMMi6mVIk6WeevXC6bPwYNmVG1jnQP008WmdizIjyzwD3825uEHydbxIWJ2GZjYuXRKMPjJ2tvuRpyG/0l0Lr1nbkMfGXEDzwE6QZ5aqcw9r8ywBDbVqFQr68rewM4GIGZlO/cJAU7wU7ERmOfcpMoQUBONzQImtohTjmtd+L5hJzRMWUeyG3/dRsUjqkdBlv8M9QD07fkoKi42ujISULTHtvhnbjYcxNe4rOlVyJznU7A/nI/C7lV4dF/DpZMQfbHLSCIdHHPQAAZpgoBUp/d9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOkkM9k/6QE3ChdgYNkpSCENTtous2nkvSkDMthDYy0=;
 b=KtMSYug7pvhK6C8PgJbWD8++Ad8Tr/WAD90wMTgbJLIU3Gd2Wo7YxKetoV+YuFRuohXdAbPlbyGisDhYuJv5tCIcmSV7tXGpHqLXxSOwP+GHu9QkjD846jSGH8SY+28ioWxcA7hlX/XmFh+g8v9cfvjSOI+hZJGNz0lARIi0TsijqlUDbX1t/PdkZYD1UsOmQLTSO0V5P/+q8hqxeX2cLitKCwkOsZHSQvg2OPRrWB4EFV2t2e0dzASM4hU1qZ2NmBwEDhsOzcJFoyK/E4hLqhYjm3hagrYH/86PsCnygtoCu0qQUxritg109chr77LcXuF6uND5rMAh/vceozmyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOkkM9k/6QE3ChdgYNkpSCENTtous2nkvSkDMthDYy0=;
 b=LLJ4PaFwBGyuWS8F8ICwzS+WLE12vd9uMygiEkp5jGJYNrifj5cRcjAUzqnpUAALq2/seSeYmWNBzRUZsUcC0aTvX9W+rdc0VJi0hOJL+EOmURQwZE18UVwUTNYrcn8CbPP2tNBkbb/SI/+4ert2CpSyYhlnLm8s73E0CYFEiSD46uyBXCksAju7B4lggITW/xGhfaouuXQwsKBr4ZfpYTve1YTN7VpfQ2waWkgGWIEcmgbROZLVx19F0ATPgLZ+Lt9jvIcgsNC+C5KiQB5JUpDx1oqqYc7KaRjXUnXHhtJ/+Zc1HVkWIuI7Yd6m8P28cN9LewAg0JI2KFK0Gmlyfw==
Received: from SJ0PR03CA0290.namprd03.prod.outlook.com (2603:10b6:a03:39e::25)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Fri, 24 Jan
 2025 08:35:30 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::96) by SJ0PR03CA0290.outlook.office365.com
 (2603:10b6:a03:39e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Fri,
 24 Jan 2025 08:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Fri, 24 Jan 2025 08:35:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 00:35:18 -0800
Received: from hive.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 00:35:14 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Jay Vosburgh <jv@jvosburgh.net>, Nikolay Aleksandrov
	<razor@blackwall.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jianbo Liu
	<jianbol@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, <linux-kselftest@vger.kernel.org>, Hangbin Liu
	<liuhangbin@gmail.com>, Liang Li <liali@redhat.com>
Subject: [PATCH net v2] bonding: Correctly support GSO ESP offload
Date: Fri, 24 Jan 2025 10:33:12 +0200
Message-ID: <20250124083426.434648-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: c42c147f-e3cb-40f3-3e56-08dd3c520fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BQGKrjfuZ37ivb3tPZ0M/V1ZEQVFZsdJWSNLymFtgbJ5GV8curJZVFXD6YBH?=
 =?us-ascii?Q?/h/0h/F+iM+J96IeYrYMfIQJwXcsIGOxsIos2f+5zAU6TLcYB0MtRqF6xyBM?=
 =?us-ascii?Q?U6bMD6/IAZXkISUwynGiJI10tgNegmSk5yTliA2mXQL4kiwQaZTvA5ruMn9E?=
 =?us-ascii?Q?2oA9UYKiKUmpazG34jwkRy8o7/6kUMDbC/el5YwFA1U1uvrW4gv25fr1fS3d?=
 =?us-ascii?Q?Sl9tfGVKAvhv6fci/rPd6VxB9evyP/jXsk0ez4SbVaW5F8mEm0WsBjCCIy76?=
 =?us-ascii?Q?8JL3K6TpAKrxVbGmCqfX27s32HY4/WdIf4eDJWLo4FsFXwRxHhLhSpPcaddW?=
 =?us-ascii?Q?dchBFp58OV5R+NhATd9hrp3bNpvxiC0GIWqozQ+J3r81ap1XhGRc9E4dcXtx?=
 =?us-ascii?Q?rnSph07wSaF1FPWVf3CxQ6HEClrBT+hYGuHQkYhGKwEpZtRPKMl96GioMifx?=
 =?us-ascii?Q?hnToNDxsXo+NGC7YowdwFsjh+pOXCgYiISyVX+zTAr3bmnMIpvdxe92PkDYT?=
 =?us-ascii?Q?UPWM2owFgA/XU0NYpGF2lsW/pAQEq2Pv+ceBAQuqyhmm9BTW7PKpIJvcMtAP?=
 =?us-ascii?Q?7QvHSWSZfMn34nJHnhyLM6OdDbvcjEEbaE6Mj4jDVLTfInrgrx2VA+WGk1WR?=
 =?us-ascii?Q?yChjLcAE7bfMOSKXVfOWis5gjq1EF9pzEjitbHC7G78Jz9Ijg8vMFerliZHU?=
 =?us-ascii?Q?Yk7NpYdw/oRcn88Qx/ThJ2mzzPXbrtyP46Nmymik7dhzWCXkccnnSyaLotEb?=
 =?us-ascii?Q?5YMKGhljGdCiUFidtokegsIRGbbGEQW+H4ypuKw9U8MdcIbBzSPhpKdHXx9t?=
 =?us-ascii?Q?HJVLDvKYjqE95ngdZnjJ8EYBMiZ3BVoSRFoCC7F/2mIVm9GG7dQlvFCYjYNS?=
 =?us-ascii?Q?Mo+Dkt3vNkIbuBRHEjd9YTJMtMmWhNk1zBbw5Hj9Kj34gFBXN/lRdCkWrVZs?=
 =?us-ascii?Q?rL55w1+EuXsCkjCIFcfcWFZsEQ7W+8GdqWSfuDklJ6003sZrIO31es/FNMYd?=
 =?us-ascii?Q?v+j9NBSctAuu0l0+3TSrZv98SlKtpAZ+dE8kGgLUqPASaihd7tQrRALQ8MOO?=
 =?us-ascii?Q?//+eHDp+oaAcch4vMtdEtO73NZvkYLFXypIggaMh91nZ6uPPGkYhMAdl1+my?=
 =?us-ascii?Q?y9zrSnAINlUm+D+CeWb+nyQbRoYAxbDqNspC+eQ2VIUpDNcSAcORCZaUoGHb?=
 =?us-ascii?Q?8fptDiRZzqbixj+b6tj90HSPyBmUnTmUE1g4iNdr0zy/mox5wcgPpoNTUEsa?=
 =?us-ascii?Q?KdfkFSe5Sqt/FPPI5Xo9y0HsLhxxErYdO6WMlJqsqfwrP/FgQED7JESu2Sg1?=
 =?us-ascii?Q?UQGDgSMzK+f1HTqXGhoWwlgl3zn5XXz3FbPNt3X1/3ZC7wstYNgLs8gnWyGh?=
 =?us-ascii?Q?n4pYANquv9ZPGSaZrltI/Dsvas8xWVq/pGac62781DKsOV+3YDBTZ4DpsjcU?=
 =?us-ascii?Q?oU/MwUznXHtjMbKEtqvokgQc3uRFe7Y8E8bahAdKLel6jsyZ3O1bDcOc4Vi1?=
 =?us-ascii?Q?wjLmvam6rdgyTug=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 08:35:30.3376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c42c147f-e3cb-40f3-3e56-08dd3c520fa1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170

V2:
Removed unnecessary Change-Id
Changed "bond->features" to "bond_dev->features" in commit message.


