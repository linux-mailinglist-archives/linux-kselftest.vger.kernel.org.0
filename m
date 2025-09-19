Return-Path: <linux-kselftest+bounces-41954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1CB89A37
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208FF1883744
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 13:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBCC226D02;
	Fri, 19 Sep 2025 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FJ5SMBs1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A701B21BD;
	Fri, 19 Sep 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287991; cv=fail; b=RvT23YTyNrQxOYhNq+yGqh1Xf3blNp8375BONg4nCIkVpk3HCvf/vfp/RhQ9/PZ/CH9r/KUFJD3FSUch4+9uYT7dPqwwTFdMECvM+0xmWfthXqIwch+qytRxwhlfgXQSSyVKla00TXeS3qQj26Le+GYAQsQY0CQ/fz/rOv8tlrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287991; c=relaxed/simple;
	bh=c7ZdBa5zG2/z1CEWIB6S4nDfQ7RB5pQAj+OH6EWvw/Q=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nOsRkZ9hoIUoNcfg8Leu0KfxyotCIE56GHMALPgPt35hka5meMlT8XW2Xnopp6hdY+DthBk5Fglikl8V18EMCun+Sfi5L3O2rSFb23hk0yC1e0p/3nKW5TLR8o3eO7IBOAvoI7Yd0T2MHbPrjCbwCeeg0oVrQO0zhGbzf7C+Fcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FJ5SMBs1; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6PLxXFGvYWWvwP/NTev5ddBZOK9VqB3ydBwydxrdqDGXGEt2OwSFzqnYS5fjcNPQsAHwG2t9VK6oDb9+xMx4lq5sRjET6pUkIO5MlI/XesXmWPqXCLbhTTmERev+jfuM1YuvcMa/CSs6TqlExsYWAUodHw2FIuKymP2DRpFEAD1LPCH4seNhQQy9G3rXmn2NKCvK1YCc5W6+rhUrNCu1joPY9XuHw5YGF3dY6xqBXl7gikuv6/hbmAMuf2qrvcmmOGluznI38a4oj2433bL1c9Yo9ug9nb4w8w3zt4+zpk0jZD3IO529e3h94cbaz9kRVHCDJLsvWho1I0TaNHvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhrG/XxFULHvRu6Rscg6wc07Ge1sytNunEl+X0lP4gY=;
 b=U0KeyGTGWSSH+uXkab/JfEUI80sEKhBGjS7rAzS8BWaceD8mUOrUX2tgogZLhTKllGQf8Cbi5fEsJRNjFQr5lZChmthmOu9cMorWgFZB4CnSoD/ZJKy41PJcBZ5c2/HgaOAOU8GOgfd9Iun1PxSOoZoCw0QFuh1chltYpLGKjjTsbgOfvm/3X0CY5+hOmHIxMRwTlRStbQfcIiQ9xzJEaix+edCEclGThDV5OE4mcd3ylvvCkvIofVZwtSG7ovNwltnKZfhzp/oYl0frjLp4qKHqF9AZeBljcSWI0FudgOMWC7rLPkGsSHECakhcmxdFT/6MEFMkFFAaA8J/iNwvjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhrG/XxFULHvRu6Rscg6wc07Ge1sytNunEl+X0lP4gY=;
 b=FJ5SMBs1lNi+kR43UqRtr2N78y5y4xucI1lvVZ2qSSw3UnojI9bIF5KiuaG2jrG/ookCsUxECM0JnOe5dLE/k/FZfTKPuBkR5XoVqoatcnna8x/FUGLgV4cIAQu1HWjDak0XjMzvVknsxCHHkYSI1SFnnjPzFpZDwPB8gwPAkb410iw9MXlfNWKFZZz3L27HlFYFDek8JjjJ5s6C/ySS95DklFX0Ud28AaWNkas86OTi6zFWRmcbZnloqStgh0/si4h0VYjOnOjCGWjXGvCRa4Z61vxU1J3IWRsXTHFj2wpC4VapR8x9OQ810BZId7uUR2AOQfxy7d1RcVEGnGoNdg==
Received: from BN1PR14CA0016.namprd14.prod.outlook.com (2603:10b6:408:e3::21)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 13:19:44 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::1e) by BN1PR14CA0016.outlook.office365.com
 (2603:10b6:408:e3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 13:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 13:19:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Fri, 19 Sep
 2025 06:19:29 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Fri, 19 Sep
 2025 06:19:22 -0700
References: <20250919053538.1106753-1-mmyangfl@gmail.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: David Yang <mmyangfl@gmail.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Petr Machata <petrm@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, Li Shuang <shuali@redhat.com>, Alessandro Zanni
	<alessandro.zanni87@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] selftests: forwarding: Reorder (ar)ping
 arguments to obey POSIX getopt
Date: Fri, 19 Sep 2025 15:12:08 +0200
In-Reply-To: <20250919053538.1106753-1-mmyangfl@gmail.com>
Message-ID: <87frcimvhg.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 6822f50f-7060-44ee-2ecd-08ddf77f32d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n1j179gzq95/rmCpUDYFNQsGhnWeRUa0oZV9ZyqyqLMpY6tBS+/JSydSVlTz?=
 =?us-ascii?Q?nuyzJ+Sjj4GfhcGgzbMj+8TcpAIOd8S/kIi3igaO0YC1sT9xgCCGLjdwFQ7m?=
 =?us-ascii?Q?gkX2xqOZ74auJXlg68+0CLBRU/epZY3Qlv9xiRHy9deCEZYroNPKjuMJ9meF?=
 =?us-ascii?Q?qL2bjonz4yMotr0sOaB5o1F4xbee303GbYI//bygWHV52f3nWMUNYDK5mWmg?=
 =?us-ascii?Q?6bo7TOWYkoMVFSE8UapnVfg4zu5qpgC9PXd7ib6wV5jogIzjD7TsbBOCTEt0?=
 =?us-ascii?Q?NzE/qOC80dseo5qHxahXahzDyboz5c7/1O0t45VwY6dDsblksmYJY2RWy9hT?=
 =?us-ascii?Q?fKnMfTe7JVnh4+Q3GOuQchm/jMCtY+aFPDC9Fw8oIa89HwJq61Xuvj3AcylD?=
 =?us-ascii?Q?A/sg9kHo0of2lExvpHLeI/WuhPjy/FnFzE11Zi2ltssjMR1BBUGH6td8881R?=
 =?us-ascii?Q?vQYZmadXQ/O7GBXiHLT7Pjoha3EnFSZiPZH1Ii2vgTqqQFkcgIEJfiFAbHFl?=
 =?us-ascii?Q?Qrl3tkvFzaJ1Y9BfIKj9/0MfY8yXDMLHbQHlMWAahW/0DksT+KtgkL/D53hm?=
 =?us-ascii?Q?XVhtlWjIfozunzJed3b/4/cpGZ+FtDNdFDclKm+7F5G9DO+Mub7+6wMl3Vix?=
 =?us-ascii?Q?jISN1GDlXfV/oCa3vfMT7V8+mrI7SkPVmvr4XBakeofrUVCC3RadOCce78+D?=
 =?us-ascii?Q?Hqeyq3RpwGLCc9TSIseha/UAr8MA0knRd+YFuQa+hwQlvOJ4H79xvr/fxbTH?=
 =?us-ascii?Q?Yz50YgkGGabvUZ3RizR+ozuzUqAsqy06WxUIXKlsj6czEZN7RzIV+opUehZg?=
 =?us-ascii?Q?ai8vbC/nzGBEHjN40PdUjUOnW6XK70R2dgesNZLzugYym9xzAfwuEozxO7zb?=
 =?us-ascii?Q?hXs7YCf2soBcrT24q5quBTPwXnedVzFVw9C+OWfH5eQzmBrCGjY+N49phqdH?=
 =?us-ascii?Q?ey/xDrAoG+cIbcw3m+aUY9UWzdGkeBxeeWXnn5Qhx2UVwx+qWRf9Zfa3YGxz?=
 =?us-ascii?Q?7xcNnrcM/12FsZ81/GS5HbesNVwkrXHYTelLdm7+k+fTJ1tQJc45VCIq8NIh?=
 =?us-ascii?Q?110H997zNNmDdDfdkF/pq949sWc0pTkoW3d9aZoUh3rBioZT+gV5K24hh7Id?=
 =?us-ascii?Q?DZKBRsUqPTILF7IOSfp0Ps4eKgwIaXUv0GWgnw+0Mjfu+iLrGcbdXnegvQAZ?=
 =?us-ascii?Q?MGenIWzXN2ZCv0kV8Q4QNolEjNPl67urwi3jsph6lhK6eVhoqfLRQJTlHrUs?=
 =?us-ascii?Q?yilexkz4nYRse/ZnGYL7xl6ChjWGFz5KslQHRug8lXznvqdzAe5xaw17a51v?=
 =?us-ascii?Q?85onogyz6Xvpn0wNwoLQRtM+P17vXiHJ+dAfuKDkosRHD1Q+F+Vx2jLjS93k?=
 =?us-ascii?Q?xEwFbGhfeuheH3DY41T0YFKP1PlsqeWNCzL2thU7keLqGUmUdHNwK+AjcODD?=
 =?us-ascii?Q?GfQKOCmBuiKm9ulaA4rroWRjYeP9MVVj+R/b8IUljRxubylxcxMzu36lVOec?=
 =?us-ascii?Q?OQCFgsR18oF5+8OsbNRSNiQiWSQ9JiKMX78z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 13:19:43.8825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6822f50f-7060-44ee-2ecd-08ddf77f32d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492


David Yang <mmyangfl@gmail.com> writes:

> Quoted from musl wiki:
>
>   GNU getopt permutes argv to pull options to the front, ahead of
>   non-option arguments. musl and the POSIX standard getopt stop
>   processing options at the first non-option argument with no
>   permutation.
>
> Thus these scripts stop working on musl since non-option arguments for
> tools using getopt() (in this case, (ar)ping) do not always come last.
> Fix it by reordering arguments.
>
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

