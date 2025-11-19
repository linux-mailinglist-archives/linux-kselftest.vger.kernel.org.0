Return-Path: <linux-kselftest+bounces-46002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38139C6FFC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B29233C011D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F691327BF4;
	Wed, 19 Nov 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IgQTxxRJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B972E8B75;
	Wed, 19 Nov 2025 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568100; cv=fail; b=AuHpK5Y7JqNQTvFooLv+QC8LE+qbcRHiaoVuxvAriV89gHUhB7iwiWJ6qJ0bYG9DUDtg2drujQqGXQUXR02vdqWblcdfrJzMJgaMNwHV7fuW4QDj9cIbV8srAt2OYh04EzualHsK4Vx0TEHJyN981U9cDqIvyIDXc3iCxs+VUck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568100; c=relaxed/simple;
	bh=2W95H3dXO9Baq3GKNU0sKdx5XY04n0vxgemA6KwaTy4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UAbg+eZSEGB5mm1BWv5BsOMp1RewRuZcuz+7xYPvl/tT2kqD3OA9MJCrKVg3tbxs06+PuRsAybtZ5BhSI7SMOaoywvskK1aNHSr8R4mej8k8MtDte/1XUeli6508yCB9nE+EgL1py2YEVfomqrxHI0ivkUYOToLY48a5bezEW/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IgQTxxRJ; arc=fail smtp.client-ip=40.93.196.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U08aK0XL9tol9NVaYYOJMrgawaq2BkuhtnJ6+9s3+lKGqSn305Uj7NJ++j2kddItsb/u8wJKAyQfwgq3ya2DFfYmeW6FhwsNi8DfV/TIaDXiRiW81fwvKPGyz5pSEkfA49jjh61a+J5zMc26q8KxrMcN2catcJ/4c6EErZF7ihk7K8jEWMobFq/sOa7MPaDooIxm9sUBomq4rccP2PrlLMViXCKdVeUdSTZbxYfcecTf3nGzJ3sHE9dltgfJ6n1zk/jgzq8prPuo/+bo8jo8KdfFWpPhzLYXndxKHwSJ+iCip2ex/UZGT0hM6pDioWZguowFvataskbHZYZViHgP0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W95H3dXO9Baq3GKNU0sKdx5XY04n0vxgemA6KwaTy4=;
 b=rSqhu1tRqqV9WBIkbq/6Ae8v78YIUGJiC9rwuxc636LrvfG0dC7mHPqQ1djTQrIusA0M2k1nPf3dqxyymEhMlKbnDHWJLJ3XVaeHS4Q5HjbSKBCDkdiLRj6OcCgRFgP9AnkyNI1Y1p5S/1qXQubITp/focyvj0suttDid187cAYynnsfJSYfKTZyVZzAipkhXe2jcz3w1Nj+9MSURl8eUU+T1ffFIiropeEwDukRtHaBuULsCmRmfwCCelP3MKp+Pj4VWuQMHwGFXlx45AbWNs/YS/VDmCWC5E0modSVNEufYtMFUCy3DDJn1y2jCSz6EYUrthqvkIjoYizJON49sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W95H3dXO9Baq3GKNU0sKdx5XY04n0vxgemA6KwaTy4=;
 b=IgQTxxRJr8hsoPqmogL0YIg8P2/7/+yu0BTJqkhsNomxXagKtMb35T9ciM4lnTesv6Ikr2r4NSKKY1Xri39ZwCscUiFPmYfGa8LZAYuWIgKkYQQRpAdRjE3/9WYIYGWhYgp4t17iTHbDY0rNV0tHTAsOtf9kvD9ukDjhUrEQPgsIaaH4f9SwCsrk9ZD7GWhwpGFAJUCRXF1DvfuaH58ytWbWQBXXS0/hXRnEsdjbBsLqG+SuH8CdnSn9Q3KGwwtynG2Xso4mCsTxcnwNzB4kVZTGzhrYZKJtOnCzvJWEb6PSKYWjSPnCznt31AJYJKKcWZUFDhCAQfLD4qBDvx72Bw==
Received: from BYAPR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:e0::45)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:01:35 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::9c) by BYAPR05CA0104.outlook.office365.com
 (2603:10b6:a03:e0::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Wed,
 19 Nov 2025 16:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 16:01:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 08:01:03 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 08:00:58 -0800
References: <20251118215126.2225826-1-kuba@kernel.org>
 <20251118215126.2225826-8-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 07/12] selftests: net: py: read ip link info
 about remote dev
Date: Wed, 19 Nov 2025 16:33:30 +0100
In-Reply-To: <20251118215126.2225826-8-kuba@kernel.org>
Message-ID: <87seeaau6h.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c6b362-33e7-4ea6-531f-08de2784e9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FXmMe8XAoONuHxX4K3t+DzecN1V8BOeb6S1JT+2zFwW5nSmkCYY8LM6I2hx8?=
 =?us-ascii?Q?DhbJ3rO9rT48V10X8PwgC2OBMxcnWNr/LL51WztjpT+8R6If2IwctN2FpDc7?=
 =?us-ascii?Q?6amTMJMcRSz3MiJWrvKMGeLti0IStrLHjLyi1b9WEKAESFpToKjwWDR/M0vu?=
 =?us-ascii?Q?x0uYdihon7Fqm2TiwdO4mr6mVFXs+1poV7BHaExybB90BriPYm5C9Dtwjy46?=
 =?us-ascii?Q?m5r6F3p59GFL4mzawv2VSMPauStg/dYmZggVGo3CEimr5LdZ6oodibK//U0j?=
 =?us-ascii?Q?D/tY58t00CR3JaHUPtrKjdLH2a/YIi6jop7Z2tSUkgoTPjtGC9uyKDSwNoAf?=
 =?us-ascii?Q?1ur0cb4Vj0wek/it8ilPncz+WODKCkIrNelImKvYEKzBkSknNP6m0kxjBwJ0?=
 =?us-ascii?Q?MR16cIw9espSnWt1oCX/KzK4MRrr9CwfY0VbDIPLPzuxsUiXubP0JJcedrnH?=
 =?us-ascii?Q?LJgUfim9ij0YpvPJ2WGYH5wXNnnEnTd4aHpF7JyD1yFi+ZIrz6sy1KmlrLb7?=
 =?us-ascii?Q?2sp3M7mxNDWrQOVSCLsolfuawJwh1SYyKsODYsnLsqTYsnoDbUgYLowczD86?=
 =?us-ascii?Q?8LQcIhhH2RuY10Piorgs2oNnvsB5/DKKLVh1yBSSwtwi90XsQy8mqtNyBJ4O?=
 =?us-ascii?Q?29wAFxYFJLZsCKSGWlNWbz+9n0gHB579QV2yZWQQgJRv7KPGd0omWj/hipmc?=
 =?us-ascii?Q?yEg1QTK5Nsn+dtBXG2SFBXqllfgFsnNr08vwydzTr+LM+iohHofDHRhiRxmY?=
 =?us-ascii?Q?N3qnT5G1Z+r1r7GUgxKQkIKQuaZJXl4rp4ZDTHM8Fxps6+9Km8yxddHN1Ml7?=
 =?us-ascii?Q?06AYADMgQwXjodSSqaYqr9gv4HKcGHl1h5jG5OqNBOlXI5TCuugUmfwkw5MS?=
 =?us-ascii?Q?xDNrLiFSP857tE4uGvnLn7AcnV9DFQTAgRwcqa+E0VhV6MYEJNN2TsietDq8?=
 =?us-ascii?Q?OmOBcb9vhHM2/treMvHpm5VfzkEkt0hqhVo2Twv6XSXKWpMhpuzn72DqPWA0?=
 =?us-ascii?Q?BuQYsPvHIYqe04qqAerySruSftmmKNOED2WF3LpqiTvH7cqKHpPIZj4bIx9K?=
 =?us-ascii?Q?vH9hsqt6oC3RCByO10VUJRXMNvvp+4s6nmLL6vH0QSibUbUSJYqTyhjCyhVx?=
 =?us-ascii?Q?KpZChtYn8jtGspJ2VzNjbVy1+L+DBVU3lhYlZLYjTgnUgMT2X0a7UrU+O6M9?=
 =?us-ascii?Q?5MNkCJ9xXqgT93SeJWrjFuN7ld2oYPPhZxL8sTrHUFmtK7PNIp71UtE29wt3?=
 =?us-ascii?Q?zH5cfIV7SkuX14julrpbSrEloyZ/LQNgg/HH5ghokcBJaMLjU2jIyAsQiSgd?=
 =?us-ascii?Q?CO7SXyP+WyT6kqsPCD+N5eQHJc08cesO1Pojshd6XZObDPKMbFCspArlBCfd?=
 =?us-ascii?Q?99LJPznkBAckexPjYf8VTD8usXg/RdhRMUfs9iLNk4RWt3V4XvaC5SwFkAGn?=
 =?us-ascii?Q?GhzCqB3Yls0gJfrcOjI9ZHKXvRW4KWpsBuIZ6e1b0dlwA3umv+jxUsiclK81?=
 =?us-ascii?Q?qxEvYjCb6tBMxUaO58ck4VkId2qjaavguTlSQznWsnfYsFQ+88VHiE5Kdn8m?=
 =?us-ascii?Q?Y0TwhyZSypeQKya3D+4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:01:34.3591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c6b362-33e7-4ea6-531f-08de2784e9be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392


Jakub Kicinski <kuba@kernel.org> writes:

> We're already saving the info about the local dev in env.dev
> for the tests, save remote dev as well. This is more symmetric,
> env generally provides the same info for local and remote end.
>
> While at it make sure that we reliably get the detailed info
> about the local dev. nsim used to read the dev info without -d.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

