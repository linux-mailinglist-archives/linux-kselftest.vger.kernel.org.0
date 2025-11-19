Return-Path: <linux-kselftest+bounces-46007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05CC7026B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB9233C5B2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF5233C19E;
	Wed, 19 Nov 2025 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t8xLRByW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB3327C0C;
	Wed, 19 Nov 2025 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569975; cv=fail; b=sZQ5rCSxHiwPoaH02ZiVd5k7QkSOVSdHddYZpYWdRD64WMbVdNYsT3nGjtFTXVyjfalX53/GlDO/AsLoKmeNWtoaP9QFCO7EG0N3KS6owj1TuoIo+w2QogOy88Z6S1yBAsCBkGYQHoIYOzb6W85xylPqGFTQZ4kj+hNrQhSd21Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569975; c=relaxed/simple;
	bh=tPbW9Qm1JFJxkheYagrb1gm1JpphiLR0ExEh6p4BXps=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=J5SOhnbtQ3dO6ivqHH/FNGNxHgdPecgf/dQ1CfNMJlr35OHGWsKl2JKoS8CwpHRTChb7jwvJivD4VKpTqbtrp8mfV/DrVV61HcbX8nm3lujMOkznDiF57E3u+U9QqIlEA24aKSU/S//y9rmfvx5DTNowBcGtTMcbEpHnZYXKGhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t8xLRByW; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AylL4qymTbAv4SWoCGxTtcH/aKwt6I5gRmMsXf/RtUcnaNzzB3oK98WMKmpnMeijMe27RzjlHz1A696rxs5rsTbr5CrPybckVba6NUuWFlezZpGuqys5maTkSbeX+1hlhnx3JaHrt5TUMsD/W1LyEyrQ8jOxcw4wPKfYsP7Pq0ObhwfR/KgirZIbLAgvpyPWgn0jnmYX651LsU0oL+KG08/5SuVTowKRrXJRhQBe509eis0+k6oVNMwVhT5brEEPdBAxSO4f6g5zRUMeaGNzUxOpY39oqMlgB8cLJOHIHJjHkpnw8pIZ9tthFKBI6d2vWu9zLeF3Zzuts8J2JPZfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPbW9Qm1JFJxkheYagrb1gm1JpphiLR0ExEh6p4BXps=;
 b=EMcu+H5xi01+fLU/XOwBoI8v+bbwrBqtsgbOyyQNUTsg/qo9BdaGrBU765BASLT4KczPybF2cWktfqYt+RptgY+G63BYd2cY7hxFYNOPqB7x54aT6eWnEUcQDfzbG9W48n2PDJL/ThVZoiz1b5oacYqZLzhS2ZYvAz59TxjmsZGT0sLZkd9Kcu3dUacPttynA1Sfof419wr3JMbGut71aKf4IGfbvuPGcrcwu/EOG/U0wCL/oe8OJa9RO7w/1OZ39oHu4Mb6DRP+tEgxKmX+jjlD/1Q/uvs8svsesTW6PtEaWVxylU47eB/no8BA2gAPFHx88zFQ67N1zlt5z0paXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPbW9Qm1JFJxkheYagrb1gm1JpphiLR0ExEh6p4BXps=;
 b=t8xLRByW+XF7ZGDaNVOfbFlAN98U3myNm6u95LH3hZVQo1B/3QvlHA9Fk6NV+oi2qh/YEcdL1WXLS8HAaaiQLNjLb6VO6mLZ0xVAP8eVVGoe5HLqa7M60wiVScCWgSJFqWlNd3gg2EK+/F6P2XAsoVoW0M8ropGP1a5ESusYxDLfGVb5+79M1Fu0TFbavwn9GY2w5SRSqW5fFCXDPDRkscJiAp8gLdlrvnjHqvv4DADacoaPlmF/6n8fuAgo8FLsLWXy9QkcYueQwETGYhhNUl6kuSP4DWje8ADJG+0YUyi4Q6l6p0t4xtscKcyGzMbewgFkFS/1ILgvJBUTZHK/iQ==
Received: from SJ0PR13CA0135.namprd13.prod.outlook.com (2603:10b6:a03:2c6::20)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:32:50 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::c) by SJ0PR13CA0135.outlook.office365.com
 (2603:10b6:a03:2c6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 16:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 16:32:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 08:32:28 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 08:32:22 -0800
References: <20251118215126.2225826-1-kuba@kernel.org>
 <20251118215126.2225826-7-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 06/12] selftests: net: py: support ksft
 ready without wait
Date: Wed, 19 Nov 2025 17:31:58 +0100
In-Reply-To: <20251118215126.2225826-7-kuba@kernel.org>
Message-ID: <87jyzmasqa.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d530fc-ea41-4378-bdca-08de27894835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qmAIwH3HrzQ6FN9D9cRcfuEv2gUZm9xA49cu5YYtRE4Puf8GU/PZNAhmcmmZ?=
 =?us-ascii?Q?/WPZFux7GV3JjunzBiCQrgBI+Q/PL9Vi5KMk3+YieNqOpxBr0MTFLmidGsye?=
 =?us-ascii?Q?c+VhEYuMWBfWVWk34s8XkltBmxq8pEV+EsG95ORsowaYEqKBR4bFh25tmFpM?=
 =?us-ascii?Q?EymE/wYX0MZVqrXYWYAXg5H69s4LnS/4Co6h4hlUgbQ7aZDcfXeWcMxE1xmb?=
 =?us-ascii?Q?+62tmsDCJo97szgH6snVsX1k08bOoSVeNSu6S4SIaHgK/43NgX23ZB2zKS/G?=
 =?us-ascii?Q?QB90Pwlb7PwUf0T7cu0gh9gq0y5EunabXye63GUBeMMBPb5/84tUjHe61fhs?=
 =?us-ascii?Q?sRAE5ZyLOphFporzw9WgnocyqQkZwXJyGZdPIcF90gnJCTUziasESY238F6i?=
 =?us-ascii?Q?/+W//4TGXhWcJuH3sJDiGm987VYA91as4FmGXAUH7L/VpDf7yROYpjBPln98?=
 =?us-ascii?Q?xVoOIm9Nqw6K7YwOwiOSaTqzqH0y1AQytGuU8kinbiBJiR5tlVWju/jsAmGD?=
 =?us-ascii?Q?st3VZDy93ZbrUzu0bz9lVmqvyi9+tG5+0TUbsncBWaNNnNB0ZLMdw523+0Mc?=
 =?us-ascii?Q?wb46Evowgvx3ysDe54AJS3aceegtUnMw59nqZUukifG7vlfJ3xdbiwTOTlkb?=
 =?us-ascii?Q?IZC302br+4WHQbICFx+irlRLcAi5Ku4OL1kz+0o91LmQ9lxNdJ8InpaT1blZ?=
 =?us-ascii?Q?hJ2Rs9Pby5yjXvK9hqWhy2xU9kUfoeBRDOmoDP6Z7ovWS74H2UxMCYhLSIWI?=
 =?us-ascii?Q?BI2mPwK9TB8F5f4FCs5sXlFZ+f/CFXh//of8+IIvfWTDcze4eW1rArUvLuXI?=
 =?us-ascii?Q?HjpX9S25Lef9VT7ECGbBLD+0MFZspmjcTAYofTxt1kLGpZp7OKfc6afsG5Xn?=
 =?us-ascii?Q?Y66LRWulSAElHpoNI/EfWOJnfRbgTIr8QLtPMy8kbKqPg2+19Ry1H2dISJhP?=
 =?us-ascii?Q?IC0cSI4M3pzK94TQu80PyCx4+EtYIjwG8K3/Wvyz8wXWFu6VNLpJGCmVFLhJ?=
 =?us-ascii?Q?wPT0AW1Q4u1HnX8qNSkNZ+g+Q3hUAuimo6W2g30foloFjKgu6lqy3otrr+f5?=
 =?us-ascii?Q?+9adN96dJJAdVbPksI80mtAz+1CdgBOrYZYDUp+RZuQTYsN9hCKijrvXaljL?=
 =?us-ascii?Q?5jcvfs2nBWJDhIlOmbgMqvTGf9aW2+2fe45kOpKmztuk3ojRQwyBynzXmSz5?=
 =?us-ascii?Q?jcNNdD8NT1XmLOyGsUCG5Hr1MjTvE5Cmn87iYl9t92yNICPQqX2VbiRyq2Jp?=
 =?us-ascii?Q?OaVmqiaB45U5JAMeuUZClPOSjyC9pgxL5dxhyOd3e8xpTRCwimy84gZi9BBG?=
 =?us-ascii?Q?S9vC847e+RVVgqWUDb8yigk6wlyS2mJLl5+dqFHGT6iTqaoxqCGlEKjUZiVR?=
 =?us-ascii?Q?5l8MvAEwDzqX6aXIw8wCKDKB5XcoorJ/17hsbTmRPprVlJ6BKpf97mDmsMrH?=
 =?us-ascii?Q?qd4DysFcIOSKYSldyXL0i0zQJOsnoR7lQue7l1Vv8mTH290odQKnujwwFFEO?=
 =?us-ascii?Q?IBfgXUkSfyyFg6W6lU8W4E4pquQh0Esi5te44n3NUAg0wQXjfMd+JLzyHylp?=
 =?us-ascii?Q?2vy58jAy3fiARy0D580=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:32:50.7376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d530fc-ea41-4378-bdca-08de27894835
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039


Jakub Kicinski <kuba@kernel.org> writes:

> There's a common synchronization problem when a script (Python test)
> uses a C program to set up some state (usually start a receiving
> process for traffic). The script needs to know when the process
> has fully initialized. The inverse of the problem exists for shutting
> the process down - we need a reliable way to tell the process to exit.
>
> We added helpers to do this safely in
> commit 71477137994f ("selftests: drv-net: add a way to wait for a local process")
> unfortunately the two operations (wait for init, and shutdown) are
> controlled by a single parameter (ksft_wait). Add support for using
> ksft_ready without using the second fd for exit.
>
> This is useful for programs which wait for a specific number of packets
> to rx so exit_wait is a good match, but we still need to wait for init.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

