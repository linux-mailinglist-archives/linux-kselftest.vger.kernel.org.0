Return-Path: <linux-kselftest+bounces-48737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F38CFD11F26
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 11:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7A7E3015EF4
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3BC2C21C3;
	Mon, 12 Jan 2026 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G3yWAltw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED290264609;
	Mon, 12 Jan 2026 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214290; cv=fail; b=niVfGMvWsmAZWE0d3tcqN6BRAEYSgK61foZkzQp+ckUDfurYMXiJHGzRzsnpftgZUunRwgeJwIWrjUNgpK+i84TLn7vLy3DJs59xreUYUFQNOt1JM/jEz5/6yn6PbaewuVuw0ujQux3ZVO2z4PduQdaCxO4sy9c98z81lajdkZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214290; c=relaxed/simple;
	bh=y9he46J2Y2zYxZG1o2RMKaKDidVwaUtdrvy3Md0km+U=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DeprHJ9dgiPLwNsh4Q/NZf04FiF4Ddcc/IngvHmUDUEX7AigQEqSiYjPNIkjauLZ8ck/NtxUmAr99iM0urSyyJHgF40G70iO8ubItmRotq80IputZYtFEGo1VJocmSzN7u0BE5A/pkInd5hpeBRvYLnxSFnmnjevFVjHkUVPNOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G3yWAltw; arc=fail smtp.client-ip=40.93.194.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nK/kCupe+c/IhFpdtiux6IxJHTr54jmqYHKVsZkhgAhu6kCwS5ay4qE0NEME1Rf63WBeK+G2oRfa53xLsVrKefkmKgsXi4RPE/jJq+TuQoUOMNVEADSs1oNgYD/I6miyoAcO5gFBYDhuXmb7nc4jHPB1x5jGKMYCgMGpLA2LiQrdMJQLcFz0B1hMfmJUyTHvsZjvZ4qUTLXlLg+ob9XkyT1WMnBlPElepnN1yGewBQFBao2oki+srtlAsMsRJGR5gG3eLx4utbGlFXDlCf9je705q3NfOTvFzAasb8HzdRvAJQ0g/i4VUNCU+ixQ+cckBzzoGw/LdfYGNe8uauYvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7z2VmVT4+M3pkmFklMKsbekKsZLHwPBtjbGbI16z34=;
 b=QTBXma9aFgP286RfOUv1dLit4f0/vgRyvmnOnKt4bd/dbXGle+zrl47ZqQsdST5DUAljM69Swsij9GCRMkU0mbc1hnMISl7Q9heZjMkbZeot6vgu1EdwBLKjhADKhA/h/duYMfGKL9NY+T/zGkPFHapilOHIg1qI8llU31lcT8hZ0PnqOxidTQzN5jKFtVXVZLSz4TTxScAac51elGsISKKrcQ/eW7Aj/SkaLtGEA1cK2+unm9dLpXlQWd1jsweqV2JIh0od4Eq+AWQBkAoI3dHS1xrqFQBIrc6h50S9JYE64c729bMc8fsZanivRPwq82swl5frnaG/IWnFRI/zOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7z2VmVT4+M3pkmFklMKsbekKsZLHwPBtjbGbI16z34=;
 b=G3yWAltwvcY0EViGLvQQYlMUC9zCNMWRBvggJvyC7jOycc73LWBAP/om1kIZM7YG8q3LjOubh5W9UZD7p7jU+m/mAuAsjv7qCE7Yk9MjuiEbimkbb7HrJDXVNGzSSX/c29gaa/aNJgb4TO1Q5QT24zLfhQimIyNxm7x5pUNt4Fzpk2v49hSx4ICVygnVPx8Ghu8ShWe+sgGzDgPoIGpgh2UoXcgxnxshqgLChXXethOPzV4IY53S/oQfuJ5vleAdfBv9yatP5qf8EN52E9cgM55WKjQtm7Fda7OGjGoIZGz780wirZ7bNL2TY7tB2PGw2Owp26XO/m8JD13ItA2EjQ==
Received: from SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::14)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 10:38:05 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::a8) by SA1P222CA0046.outlook.office365.com
 (2603:10b6:806:2d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 10:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 10:38:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 02:37:52 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 02:37:47 -0800
References: <20260110005121.3561437-1-kuba@kernel.org>
 <20260110005121.3561437-3-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, <sdf@fomichev.me>,
	<willemb@google.com>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next v2 2/6] selftests: net: py: teach cmd() how to
 print itself
Date: Mon, 12 Jan 2026 11:37:34 +0100
In-Reply-To: <20260110005121.3561437-3-kuba@kernel.org>
Message-ID: <87ldi33ymk.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 3887523d-459e-4133-b19d-08de51c6ab78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9X/BHNGnLPSPTY6iXzldmxAQAjdPI/wKo5Wg0HfSyygL1/t6tuKqGZd97V0S?=
 =?us-ascii?Q?sqkF7DoUecJq9w2tU6T8YKXvQXDIb7HH5iBZYVW8lp8+He+Sr+i+6r6ixET+?=
 =?us-ascii?Q?leII6N4eB1/s2xBqZuL5Q9gOo/LwSCAyUzd56iC/za1jo04dV1bqmFZ/Xn5n?=
 =?us-ascii?Q?bDh41TH1732Zdnr1YGbC8bLUXnEsuAAd6nUcigmyZpp33i99Hay7uK1L9YWB?=
 =?us-ascii?Q?JmD1jU7zOvEu7M9k/meD2CuwhtwRZ5r/4aXOcPbV6IF0FJlL6aeSkA28IMES?=
 =?us-ascii?Q?0ZpeWtN7vACHf7FV/LMsooVWu9yeXd6ndsI6R7rDbgCLXv9UdnDgK5H8hu0M?=
 =?us-ascii?Q?m78uQe9NC9EqGX+ut6FNBbijl9dhXXF1Xb+hLoFPzoPnrij2Zg/rdtXCXfWn?=
 =?us-ascii?Q?4BenJOB2LEdxX8gAztX7E82anHGGfyUeD6MyxeuRnhwP8Benx12RHbDPRWJh?=
 =?us-ascii?Q?dpf6/6k1MIZwazeRhnlA6Wb1TfzhFBbBZc66Mh9K/aGcXP0Q+GQGPigRMHWb?=
 =?us-ascii?Q?F/H0AffoLFEHAcId8CHRAibvuPrVCa9VpJ48fDKRhjkIKEteVbAZWO+5e/iZ?=
 =?us-ascii?Q?MTwWwISV0xixJRL8uizq7gy0JC4492OPfC9BBYBrXSmQJLFqtAWVeDLz9LNP?=
 =?us-ascii?Q?zcxPpcGUevMOfbfzvzizeUTf+gFpsoj6qXiQfeknQThYbCpG1V5VdUTt1iAp?=
 =?us-ascii?Q?YSSkwUAkDPQIXgIl/uy3DVIc7QzMD85dS66Zm2PcJ3QkIzOC7NPLGmsXv3oY?=
 =?us-ascii?Q?MY2QW9NPt+Rma/DUQetki6L57uSM+DEdHu/gpBUHJ5sFbKrMuWkyKSsue195?=
 =?us-ascii?Q?nKNC5C/xexxf7mCP8dVfPLVpvZhY//fU97HwLjiJssYFtWjrEyH7O9UnmmiF?=
 =?us-ascii?Q?aNq4Fw6LSBC47B2ZWfst175SssUNtEkJFSTH6mO9I2iCppR0mUaEPKqm0EsA?=
 =?us-ascii?Q?dcF1dkqHWs4qiHQONOKtKZo6SDmkPc1neTCGZqneIGLnU9D5lzjXa7ZW/1Yb?=
 =?us-ascii?Q?wkOvOFpTGHqRf+vnXrx5p/aQTyM4wUu98iVSwhfbV326lqZ7bn5IINo8NKc9?=
 =?us-ascii?Q?D96LElREys8zhDUNc8RIQAT2A8yrmU7S1ubws8oFtBPjHNQ4IFaQBHcuItzk?=
 =?us-ascii?Q?oAfBoePMduwtluqOxMrrZiBapA5bqYZJVztRMwiegudGo21OZQ3k17XJLiLZ?=
 =?us-ascii?Q?jlAhvyn3Nf8kdyCR6AxwHmMw6rrUw03SEu9Wwmr3IF+NoCwmX9rC23SGH6pi?=
 =?us-ascii?Q?K4tuqnuM2NgmDKiiHBIrdiL2WcZMdN7efhFC0ag1QW7hY7gSx0BrlrR4kGoc?=
 =?us-ascii?Q?fAlGjrTbrZCoK08gcEk/avSYMewzZJn+j1nngd48yRhN8zz6dtetE3sSES+z?=
 =?us-ascii?Q?srG8nLz8dnUlvCk4TzCe7ptUVCasDXKwGAHSUiZBWIXrowv8J1jtL/xqv99m?=
 =?us-ascii?Q?/2SyreqA8yjK466BIyKExHNNh8xFMCQ5B/2ml8AnYjMgVJc4nV12s75tnQSC?=
 =?us-ascii?Q?ttVoZMsssfdeKwWmD+q1Fdj5k7udD41TYbljrXrt1o3HZBVnFDnYoB1Rrzyq?=
 =?us-ascii?Q?rR0xczYOKbdCG0mvGHc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 10:38:05.3771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3887523d-459e-4133-b19d-08de51c6ab78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766


Jakub Kicinski <kuba@kernel.org> writes:

> Teach cmd() how to print itself, to make debug prints easier.
> Example output (leading # due to ksft_pr()):
>
>   # CMD: /root/ksft-net-drv/drivers/net/gro
>   #   EXIT: 1
>   #   STDOUT: ipv6 with ext header does coalesce:
>   #   STDERR: Expected {200 }, Total 1 packets
>   #           Received {100 [!=200]100 [!=0]}, Total 2 packets.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

