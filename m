Return-Path: <linux-kselftest+bounces-32389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812FEAA9843
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4728D3BA7F9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590BA26656F;
	Mon,  5 May 2025 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YGbG8EjQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D754115AF6;
	Mon,  5 May 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461036; cv=fail; b=dPAbCrlsAvSfAsukP+dAeQnNuuzFVjceCm5a04dahwma2tchG0xNExTw3+5OZ+Yn6l0Eo05k+rgqKX75KEEv4Brx/vgr5TkNJNw2zf7WwT6qr9C+ZNYhHFKosMvz8u66JNQb+E2eEO4BA2dwHtL80bhsgeccgJckhzEP9Soh0+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461036; c=relaxed/simple;
	bh=9An6i5/MejYYRf2dhUXbXoy50EwK0cgvX3r19lAv6x4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNE1ZoNrp2k2ZVm2+kMUwuAq3rXkfO+3LW/cGE19V/MDpk+Ged9HAW6g40mCRHGdy0e1nf6eFgtJcx4Y8B4QyeB8hPksIE2D78kpy6ditm4qMX601W+XWOIeIgYc9ImzfSHyDiVq6lW7qqnNtar7StNM3T/3szP02yb+kIJhyMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YGbG8EjQ; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWxZqHBuiSQ7vX625WFQ5m+bkHecGqD02MeF4OB4SQ1TXZNQmajl7j5C0apgsYj3Kh+yBGDPgCXe95pvU6y6YzcS/zDrrhmr0bb7iXoCFSuMu9Ny2wCV1ueWb1QuxuE9MFpEXrjo1mWjteWzpMKkgbNQUlIfdJYZmRrhrFZdtaTOE37NvueHizjsrmN1HGZhMp9RWM0Akc0kn/QZnsDfuPsmIH75WV/5lMuvs7ZK7k2/J0P/A2eu9iOJp4x8iJmqWini02QaqrS2DLifFspV29luqvZssPz0ZR2AB77eLyU42kVl6Z1shCbm8Zvkjy31szSXKpobBTmhQo07m4f5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRR02i5sGEtnT4LUMeqX3/cI9rqLXxA6jtAJ3K0tNE8=;
 b=Emn/vzccXQGVTlzhz6wjjdUPsF+0H9cyQ3jrspu1Z2VdDRFlmq79NpMLy+4vC8XicxF4/etUmtLIc7onHrzLsRpu+LL+UJm5M7tV8/o7SBuCcEkZuzOaW6yXQYTIDZmOEm1D3rpYLo9ZtE6iMibiW6JZn/E8Ujk6UdT+kRKBeS1zUAa2D5yrSQhse2v2Cn9oP50vPPEB735TW9x2CiUy7vQAaQSqeMqbqsvBAUriLX2dA71qyELY5E52dVxvrlqZNKc8LQuCsbW+tsYt6+CFW56crAJiOrFzh+DH2BOWwPztcJxB9vHHRj3BZeDKP+o8avT5kEbD0OAgdJeYgPlolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRR02i5sGEtnT4LUMeqX3/cI9rqLXxA6jtAJ3K0tNE8=;
 b=YGbG8EjQTH0FueRTqhnDznzMprYJNMBGEqoKym3zSq9dTjDupAb6ofp2EDFiI0UaHLiRAaHEQTY3hCL+8X+ZVx/uHR7vSSVcQXM2c+cci5T5D1gnrrG0IaW0B+GQvtbpRtdLUzymB3DVD8Y4yDeu2dyuXycW9vh5W1CFzGBQqI94aI66lCLKBwelvw4Uyeeubw9C96KM1QCnTmg3+WxQhcRp08bDr0R6MpRgXaO/cj2v4Glbnkb62a/71Bl+X0Ay3uEURAxBIlPAJMNnJPVhcoDr4vnNDwYFdpfJ3NW4qg3lkhJHOr+8c3/uHiEBTGsYv85J7/210CAYHhuwBSHTKA==
Received: from DS7PR03CA0176.namprd03.prod.outlook.com (2603:10b6:5:3b2::31)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Mon, 5 May
 2025 16:03:48 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::86) by DS7PR03CA0176.outlook.office365.com
 (2603:10b6:5:3b2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Mon,
 5 May 2025 16:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 16:03:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 May 2025
 09:03:34 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by drhqmail202.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 09:03:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 09:03:31 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 5 May 2025 09:03:29 -0700
Date: Mon, 5 May 2025 09:03:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <praan@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <aBjhUL5/n79cJ17f@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
 <376566b4-6c13-45ad-b1e5-8cfe2de437bc@linux.intel.com>
 <aA+92fNNbDI3Qowk@Asurada-Nvidia>
 <20250505150109.GH2260709@nvidia.com>
 <aBjc1ny0Zs7K7gDX@nvidia.com>
 <20250505155505.GK2260709@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250505155505.GK2260709@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 53636b5f-8fb1-45e1-3fc6-08dd8bee6b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?is8I0J/EZ1Lwv/kXB+BvnVNcJcHRBJx3YZu1xJ3DWNYSEvnsZWnjfi6AShAH?=
 =?us-ascii?Q?kRrSHBxxXJ00i2AB37BF7iaVCOz7CzW8imEkXcw/OFqB5nKqrJp0Y9oT+4vP?=
 =?us-ascii?Q?cAOgPaYQ9FkDi/tgesLBqK6PkxUnmZDkJ7BFRJZ1lVywaX6XWU4BBNYwDpuU?=
 =?us-ascii?Q?AV6I4wd4e7GZDUaJv+DcKREKEl7LtbLmaYdbEaREsieafIyUIdkm2S80hWyF?=
 =?us-ascii?Q?UXC97ksKmyAbxa2ZobgorM9thWABk2Ix3WpyZ0AUw5qGSl6AirCwqO+OydyG?=
 =?us-ascii?Q?zPIJzhT4wYnmP/F0AwTHV6nPOJ8cl5x6fEYGfA+jvr49ohSsA8KPnfytsKN8?=
 =?us-ascii?Q?zNI4GyGch6lvUBMHtZt5FiGDyyzkLvgohsmvMm4d8PUhmzbnuLWPceWCqN86?=
 =?us-ascii?Q?x07CbzRoXwG4HRVE2ObYHsSkyw+KHk7Jy+tvn5dtV6rkDYgB+t+5O7NemYWj?=
 =?us-ascii?Q?7f2Jd/fefcBRce9rQmEgG6htG8E9cWiqt2HCWS31Y1FPJcE6EYuBEDIMQyDS?=
 =?us-ascii?Q?qDGJyHvjyALDZ+Izx7RNLM0m5NZo/Ba6AZDpydPvjgDjGR7FXIcLdUHD8Ba9?=
 =?us-ascii?Q?9Yta+Xp7gXQYY1oRqaI7N/oGSV5DvWyWOh/UVx/vaeH/R9lVa8o7MM98z9Ed?=
 =?us-ascii?Q?rJFbqaJ3iWuXeNmVfkNDrZlEZIHMj5itGKlEpDANbmJMeQ21RwDTuE47S7Lq?=
 =?us-ascii?Q?Oavunk71XNs/9491w85h1DdVz4iWZCrFWBnhsT+YgnCbyYdkN6gHC237LNnE?=
 =?us-ascii?Q?kqnJgTYZOMmo3TCixXAd7l5exQrvIMKkro45j7FTr6Hfzlpgcwud6/wRPGdl?=
 =?us-ascii?Q?R70TCwGFzG4myW2pvDQU+URkF7CUWWe1OR3EoYG3QcyZS2SJBN/hCsarGSds?=
 =?us-ascii?Q?Gk4mWxLZvuhORw7dbJvEu9XGS52rAPUzBB7hyfobSrnLMWNNW6wW1MFG93Ts?=
 =?us-ascii?Q?XqpdkE8OJUBUiQuySfYNTwjh4o5Rcg/K9gJQuUvDkGtdd5BZ0m6YomEeGo9i?=
 =?us-ascii?Q?oFZmXI7bYVljRsd/WVys7gOu5jKXeubYA1YevJn6UmAB4jR9jlxvtIxL3QTc?=
 =?us-ascii?Q?RpqiwybX/3UQR6HxQORUcdwI5XbI7qzkN0JdrLLhOidCT7GoDuOMx6WWEOxV?=
 =?us-ascii?Q?jRH/h9PxtvRzIcKruIIIM6vBtobBO0DAmV6MEanTO54eC2tl4U/kLJ/q36i6?=
 =?us-ascii?Q?d7dOo3/I7Sy5RtT67sBgeC9UqIt8oKjM5ABldNxI7uW6+Xc2L6AfS0aYV/lC?=
 =?us-ascii?Q?E3BY18GCtDL4Vkrmi49W/pScSts/cnK811d5MPHbpj/xKL2Tt4j89DW2nSi2?=
 =?us-ascii?Q?Jr2hVdfRQSS8QQ4KZNJ42AexTv/4j8M4m1HuS9m33AgCoca1SQwN1DKB/rVx?=
 =?us-ascii?Q?BhKpL1fckyEe2PvhyvrokdBBmktXpae/8mxQE1i6osFyMgsiUfKe3ndJQ5cC?=
 =?us-ascii?Q?TpzYIwq377dpf3oPb+FFCZxGJFtji/6Eye1kzyeRDw+qjWDmUq4FL8Pje6ZL?=
 =?us-ascii?Q?gQfXie+QpiQuITcZJ7I+lgOowA5POHwmvM29?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 16:03:47.3062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53636b5f-8fb1-45e1-3fc6-08dd8bee6b4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673

On Mon, May 05, 2025 at 12:55:05PM -0300, Jason Gunthorpe wrote:
> On Mon, May 05, 2025 at 08:44:22AM -0700, Nicolin Chen wrote:
> > On Mon, May 05, 2025 at 12:01:09PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Apr 28, 2025 at 10:41:45AM -0700, Nicolin Chen wrote:
> > > > > I'm uncertain, but perhaps pr_warn_ratelimited() would be a better
> > > > > alternative to WARN_ON() here? WARN_ON_ONCE() generates warning messages
> > > > > with kernel call traces in the kernel messages, which might lead users
> > > > > to believe that something serious has happened in the kernel.
> > > > 
> > > > We already have similar practice, e.g. iommufd_hwpt_nested_alloc.
> > > > 
> > > > In my review, a WARN_ON/WARN_ON_ONCE means there is a kernel bug,
> > > > which shouldn't occur in the first place and isn't something that
> > > 
> > > Right, so it should never happen from any ioctl path and syzkaller
> > > should never trigger it based on system call randomization
> > > 
> > > Is that what this achieves?
> > 
> > The functions would be still used in the kernel path. So, I think
> > we need to retain these warnings for that. But given that an ioctl
> > could trigger a series of WARN_ONs, WARN_ON_ONCE is something that
> > wouldn't bother user space a lot while it provides the kernel path
> > enough info to debug.
> 
> No, it does bother userspace, we must not have ioctl triggerable
> WARN_ON at all.

You mean we have to eliminate any WARN_ON in a call path of an
ioctl? We can drop them, just that would mute any kernel bug.

Btw, IIRC, the destroy ioctl could trigger some WARN_ON in the
remove() when the object's refcount isn't correctly decreased.
Should that be a problem too?

Thanks
Nicolin

