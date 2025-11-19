Return-Path: <linux-kselftest+bounces-46000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A3C6FFBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9D464FCB0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3443B286426;
	Wed, 19 Nov 2025 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JeOXAv92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4415A85A;
	Wed, 19 Nov 2025 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568090; cv=fail; b=SWzfbHn9xfKiX43/I7ZkuF2jKzgy9EYu6MyRwj2r3aFHHh0ceJafVAlyJljHEuMUtsSt1AJON1bXbJdKjB6B+NTqypEGAXpRY7nFeeDNZKbOCifgarljK4gb4RQCzEHg4XBZlEzBdu//1lsA6MSZeDENCT6l7TQAxEEDoOZp2xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568090; c=relaxed/simple;
	bh=bZbjckn7h+Xul6UMA2mDwImYveB+SGaECo9daFpqD3M=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eKq7sLLM2Zl7doxzkSNipcvekq2nvT9J+Butb7CWZhBDBj10YO3tspbL3FOmb3iks5qE3IUaQ1VC/vI9EW+IVVc6eEDQqJZeTXaLMb+G3SXGIDlPsiaQccdvzSAxfS/6PvS3saesBdI867i/zXwReRLHGgUedE0P1MfP9HZ7OcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JeOXAv92; arc=fail smtp.client-ip=52.101.85.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGmd1Yl75+dxEDIFD3XROxgREcFKSldLRAsDAf9cRxFGKYNBApIi7HP6JyaoBJdEYKAzJsh2j94EkrwjXUeI+LpaTezVNUyMlEiZGoEJff5JN9gUITt7CYQ2U52A8UMp/Sb1Q1f3Cofg9BNUCtrWI3w8yBzHuf4K9QelIZ9QdxUDpeCd6bkVvd2AlhHgd7DUka43BQjlGMySRXJ+1nLfkz5H4hTatqC0JJMAtNuGl0v4U1bkOLjBwtXdqpkBvpPenO0TazLLr13kKrwcTC5Ga6h4H0saGWeNC3iQxIsQylJNhsn4iXwZAMXxfwzEj/TMEOiFF4iluxDOERI6b5srOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f04FIWNoOcQldSJtq1npKbzjo89weJ5/FL8koobBaUo=;
 b=zUf/nbsV5I8PvGP8pnDHG0qeXNGjcNljr64plg9g8MiQp1+yhI1sn4arZ7TwVicSPt0bxfiags+NfQlvkv+gzU5ccJj91YAqZ0Pn97g8IhjbMbFxbJI4/Xu3i6OAtf1BeUiaVj4yv/k5KlWtqRwS5YjmjHOWKDIrGUj7v6qNvTADTNF3JRTgBu9ahFweOdeZ07XgaamGiyyVguoYnG8CjbnwuiVZpJTKBIrffZAETkuCJy3GIhmIyRAI/epUFro+NboNl4PuHb98XS0KTwwYL3IgCIzePJ2mq8U8/9nY3+wuWHiM8kROWGrU8+h8RYm4v2cqSYtKJyZAiCdOcLpwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f04FIWNoOcQldSJtq1npKbzjo89weJ5/FL8koobBaUo=;
 b=JeOXAv92fTyVk59JkdMhOeUFChfZRz5HOXrR2zCQXc3KoKkSQKwJfw1iDSElm8V98IjZZdhZ4IeGi53fucvzhjK6AnJZHKjp9gcupQM1Kuu0uhddFGEIGUpFLPFLepWs9z+qYTjDzrXNfCdLkJnNvFGTcicIq9fwaaysgKZR/V8GbpbVIfhwqmsHPswne/s77u77N52kTRC11Ys3kaucK13I+KnSFr7tQez8xmL3UHa9ek2X1e6pK+utefWergboTFox3xuuuGqgnJzd+cEMbmRu9rvXGBtlLVWhV/2gDc8BxlesnwfL2seaSCTfTiiMqDnMDMBaazqumZ5o0m8UZA==
Received: from BN9PR03CA0684.namprd03.prod.outlook.com (2603:10b6:408:10e::29)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:01:19 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::51) by BN9PR03CA0684.outlook.office365.com
 (2603:10b6:408:10e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 16:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 16:01:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 08:00:42 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 08:00:36 -0800
References: <20251118215126.2225826-1-kuba@kernel.org>
 <20251118215126.2225826-10-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 09/12] selftests: drv-net: add a Python
 version of the GRO test
Date: Wed, 19 Nov 2025 16:54:45 +0100
In-Reply-To: <20251118215126.2225826-10-kuba@kernel.org>
Message-ID: <871pluc8ro.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 74588090-5daf-477f-07de-08de2784e0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5XZ2uJNs/HtPs37V1cnMOZxEULppkKkHLSKIBMzFkvw4rEUCLdZHo66DXnJJ?=
 =?us-ascii?Q?wM0e4TzWMkEePADjB9LNUFDGw8DFVcp6HTMp3AiOjTE/XitNBGfkKK9McbmI?=
 =?us-ascii?Q?R1f09wEzlo+bf4iuPNEKGf6uwoAXCU2NeiZcrAswbRenYEzT5JkXtZ3Pu5qy?=
 =?us-ascii?Q?HGkEyR9xASgJ19w2LRtXqmG3YZDkHOJ3DDS5CEBY11fo/kSqMKU/sc/es2ra?=
 =?us-ascii?Q?p21tLazCN1WBwbUS7y7RtePqs5Kv7gltqHtsSliutMBG5g/08QkyViEozlBe?=
 =?us-ascii?Q?/d+JdcTjZqb+4kSLDOJv9Wewu0LQsEWQReZaZHVP/L0K/KG3uv4hld7iuIWi?=
 =?us-ascii?Q?2p8V40UI2FAzXdvW1q1tPAshkzPtNlSLI99UaVFK62Ic5kTVbAWNG8XXOV4C?=
 =?us-ascii?Q?9K+uomjliPxSwKwpChC1EX8Zwoj2OaNs+865FHYGbcedTv4EbWSHR5k4iutb?=
 =?us-ascii?Q?b+I7rKAW21/MkdfzFljBc4q29Mmz38l068ynR5gNcqdmXDZRN1W+H6Ug0EQY?=
 =?us-ascii?Q?DbQJ8STVraWf66JA+tuGweO7cUH4VjrBzJODDfRSA6b3yrK7b6KD+gFxzH1h?=
 =?us-ascii?Q?aDzHTwutytO8PtWvJteSud3AdBaTjWD5+BqsAZC2RADGv4VomYZa5MEnWGwV?=
 =?us-ascii?Q?SVFBuWZmzTrrI3aqqzK2HKNU0p+Hxt6tDYnH2VmrUO7g7x/f7E5C2eGHk8yM?=
 =?us-ascii?Q?nEV9p6nP5+kPwLh7Jm1+bbSzXpWt93X+jV+NeO55rD47z4MZPssgYLUu6Ae+?=
 =?us-ascii?Q?Q8ITQgWy6NBjGlLJp1g47pz4WWX8sfhoRCFGGVkcQm1VApwkkrfDdBmz9XeW?=
 =?us-ascii?Q?Ogr2YcuChOYgvp7IsMzIHlcXtKvT0jRv7Q7vx4FCRSli27kJd1STih0vvSxJ?=
 =?us-ascii?Q?v/06Vv4KzEjEKrQdMO8pvupyXeDqe+jSRKJw3knaqrkdN9sIGdMODyfGVymd?=
 =?us-ascii?Q?wz0QDmiull7YifME4dXeX2pW7ap2y1vUAEyTf6Y0BETI92RRb0B+LvCTFnlB?=
 =?us-ascii?Q?+fKKemiZKrkllnTH+EY9qsR8A7ebmiV4AborpVtgqjiaUJ5CVWvXNVyjmJtl?=
 =?us-ascii?Q?iB/rsjFY+VG4YNKJbfZLiC2aH+l89rbWfjQ0PfMqsuW8Swv9RgHfsfMbEl0b?=
 =?us-ascii?Q?OldP7Y8SN071g60y23U+5YiHKkv99jDwM8VG3y0UyYTifhOWlHVE7pAaAA5f?=
 =?us-ascii?Q?UWz0U/gnaKOHHxx1/HS73ybGjXvqIc7vJnSqbqd/92izV3PzYDfw5CC9rjJE?=
 =?us-ascii?Q?ORh1Vdj/1XrI7dQ9u14I/vhFLhx9fm6W+3x/8YzcaLVtQ2HsMj2U1kLskLV6?=
 =?us-ascii?Q?DPspAB/Ol/O75OF8YSgdWQbVhtjr7iJ29BSV6W9T+nsyknH3+ScN56z2l3Bp?=
 =?us-ascii?Q?CaBtKwyFNvWkqUuQ2CMOokickysjYXHRtx+5zKWyWx7RC9ikaIAdZhkPSoqd?=
 =?us-ascii?Q?lpJCk9TqqtAP4OvkqenO5a5GgxpLj6XSOxI+ccV1BmMQ4s2R+Gf6tm2CInHy?=
 =?us-ascii?Q?/Q5rFQ9gjON03AZc+T2J3sTVlHWvgdSGlwDrf+zPqCwNVU5E5pOBdLqxPiik?=
 =?us-ascii?Q?7Ne6FPRP9l55RhHUFro=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:01:19.0023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74588090-5daf-477f-07de-08de2784e0ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421


Jakub Kicinski <kuba@kernel.org> writes:

> Rewrite the existing gro.sh test in Python. The conversion
> not exact, the changes are related to integrating the test
> with our "remote endpoint" paradigm. The test now reads
> the IP addresses from the user config. It resolves the MAC
> address (including running over Layer 3 networks).
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

However:

> +    base_cmd_args = [
> +        f"--{protocol}",
> +        f"--dmac {_resolve_dmac(cfg, ipver)}",
> +        f"--smac {cfg.remote_dev['address']}",
> +        f"--daddr {cfg.addr_v[ipver]}",
> +        f"--saddr {cfg.remote_addr_v[ipver]}",
> +        f"--test {test_name}",
> +        "--verbose"
> +    ]
> +    base_args = " ".join(base_cmd_args)
> +

> +    max_retries = 6
> +    for attempt in range(max_retries):

The original had a comment about flakiness which was IMHO useful. The
"retry failures" paradigm on its own is transparent enough, but the
comment explained why the flakiness comes up.

2c

