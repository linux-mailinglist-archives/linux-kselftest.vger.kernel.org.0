Return-Path: <linux-kselftest+bounces-15672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B25089572BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D08EB220D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A58188CC8;
	Mon, 19 Aug 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ONZzdeg3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04949188CD6;
	Mon, 19 Aug 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091030; cv=fail; b=B8CbplL9m6yiEwL1SP+S9kWa5Fz0ynPMEJdKpjpEbTOVnHF96N7DDgrTPB/Vz5GdjYUFsUE+vkFVPZDmVcXa4XHyjrQSQEqjlONTBq3PNGo0teCm/0iRXAHwFNsFSDhQ2kXcKP4fWarvDqzqXTk0MNXyf1A5lG4tSJ848M7/poE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091030; c=relaxed/simple;
	bh=w+U6nTOG5gkmiuuMQksn1Z3OwiPvDxOGSocq0th6IKU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bn7TKBIW1xzylAGftyeisgBaTSh0S/P06UNKoi1hcmziV0T6iuqoU1aweXm3us0cvedmkwGGiWZn+GzHFKSGdUMmFfO+0Ba66smHI7Q8H0cKFD2yvzMPueKU83e8p9tQbIBgz+atPrpZWl2Csr4ECYQ8Ohqd+N1qBE/NY4ItSEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ONZzdeg3; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzMJsI/nWcaYtvmwMYMuybnD3rxUf8xQkj1GtqE0pHOETcAtAB/W2M3Or5A0peVWy6Iqg14tfa3JCCvjV0vziUyQ7ybVxSlNZxm+ayc+5dhKF3lMCtLwo0ncjg/XK7+mJT72GalMvLc7AyandpZX4jQddAtIcg0Qd5qwp/vk+V72dyRH/elkipKI7UO+yHXzmUuJUo7xu9YhXppueLQJNblbEd2UaGDDmbrmkCZbLYG60okx7SeP6CUU9nXVyh5puk/362N+K0MOlPDs5LtoR1nKbX6zv/iIzo0Urq4HaNR17Ixqjedzn+NncuhfVPZsacdL31ZM6fX4SK0mJLmQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22UEQFifMCEm98Pi3r1RYxdv1gHlQ8zWLPvsOEs5GgQ=;
 b=EnrYJOzPC0eCU2iSuX0eQFCDQQYS/lwoGDgt7FPKKRiKIqLr4aNoihsjzXj9SrcvycFATT+rGlcMDXfkLespsgkOxhU89pVjUcCdHSJRm6MBKw8FnwxUKPvYu4IAkH39B5Ul5bgH8s0Kyv8mtftAOF3EdUljfTUvcyqquT4VEv9RIqNGb/gaRw3Tx7whjrPn3dXGrOU8YxheGNZZ4mwGxNo5ocm7b+W9CU9Yf6Q/hf58br85XWbit+cMJW5PINz2UIlo9w1fXbBMDyGIvXeYCztklHZ7VYkXEc6jwxgcK7/4Z2PFcF1i9+/6RpnFUHl37+XFM6ULsdaMzNvK5Uk3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22UEQFifMCEm98Pi3r1RYxdv1gHlQ8zWLPvsOEs5GgQ=;
 b=ONZzdeg3P282/PqjwZDgnucdygn9megCtFvmR4Lydd5ixQXi6Z8HcdRt/OYnpCLk7PZZsHrfq12gMLwGhgVb+nw9oTXMkb4ov7G7qL7BSfCpOtX9b95gPgPWLZwh2fKViZK9Il0Iaa3vAsZdJAMQ12gopM7LlQtpbF5CZMVdcD3JWrz+omMvOsVDqCeItDZDLDxip1+8VmY/c4R0SNIx/US8225nEWMU832+XlFfW0SWqaLyXPCItGSo4DMYQbramqw46RT3MEycjFGxSquO6+vDPdLz5zKE2nRAnmqOBsiGCcv+ffEVT3bE4IxHwkqcNCFWNTVWYyVBMoy+ykO39g==
Received: from PH7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::15)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Mon, 19 Aug 2024 18:10:23 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::32) by PH7P222CA0004.outlook.office365.com
 (2603:10b6:510:33a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Mon, 19 Aug 2024 18:10:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 18:10:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 11:10:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 11:10:05 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 19 Aug 2024 11:10:04 -0700
Date: Mon, 19 Aug 2024 11:10:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 05/16] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <ZsOKe10cOTCcHOIP@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
 <20240815190848.GP2032816@nvidia.com>
 <Zr5bENKAYJTvwEBJ@Asurada-Nvidia>
 <20240815234119.GX2032816@nvidia.com>
 <Zr6bpbc0HZ8xLVZw@Asurada-Nvidia>
 <20240819173332.GM2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819173332.GM2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e9e70b-b328-4ace-3856-08dcc07a31c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0B7/lsEt2NUKAQ4Hc0AdfYkgYf/ARCr2Nqv4MgNY4fnNiNjy4ciMQopyF5ET?=
 =?us-ascii?Q?1mTB6dVk3ZJVjUvtv5/bgxipbQnFIHk5yOEgQbLkSuE53/Lsz+ZoI153hp0q?=
 =?us-ascii?Q?HpUIMAH+RBP+CgBIFpmv9c1bnKDLOJiZqk/CTCrUCFpF/97Ki03un+m5BiAV?=
 =?us-ascii?Q?epH2BgcaIgU88o9DKCV9i7756NdAAFhwVls2A0E4HHp+bLL2liI2uvWIYq3S?=
 =?us-ascii?Q?urfsk8vR1HiCmQx6Itmm5w2ZezzmQ/hMjySAV4mORsM5fadoam0Ggzl9/X3W?=
 =?us-ascii?Q?JaRfvSCbhrsaAlE0mjBBKzdF+18QQJI/jaIoU48YX5b8XSWKxK3fFO5T1CnL?=
 =?us-ascii?Q?mQ0Yg2FRIOvmRA1ZH8t68HVGpWqG3fJllB5hQZC+BysWsrZjhdYIDZCEkdgZ?=
 =?us-ascii?Q?bDQVC6hzmsagWutVKdg86Rx98uv5b8jzxLJYlAz0ACvXm058yHC/teTOFTZL?=
 =?us-ascii?Q?lh48jFsY+1/imcXeA9z1+fVvn/w2OcyGH4rDYHgJjBudqppd5MSxi6+CGOKN?=
 =?us-ascii?Q?7ZvFYt9i4YB62pjmyCE0YLwZRVxM6+4ZE1g2tw7RG4DJecbXHbhUNVIYXaeJ?=
 =?us-ascii?Q?h2Y684pHN/D/v+FI23sRY+xbgGotgdsBut5b80uaTUe+8KJp1Zd9X5TIR2Uj?=
 =?us-ascii?Q?zOayZ9lZkY7Gqa5iswWNuxBqzuJXSN37/cl0Pad7kqzS2TuirleYlV+tYoNI?=
 =?us-ascii?Q?4tHGBr8lK1RHDL8MaKSsRn+GlU7jMUCr7oHktR66cdsvQZ0CXROrZhjj37/E?=
 =?us-ascii?Q?7vm8N12J7JkmgDCEqT4eyyCABEysvA3h0MvdBD4thpGaoKJ9Hl403RLlVvsD?=
 =?us-ascii?Q?0MW9hANboiLr6RzevwSZDyPXeRdrLOi8dk5bsgXZ+ZOHFSr07y/tW2DQgKmj?=
 =?us-ascii?Q?f5na2rQx4FcgO8SrXu75ZUEgfpsovQUJczXUn3YLc+r255pRsA0eypb2wsIy?=
 =?us-ascii?Q?FCZhLgV4I+BNZJ/n3S1FSKHjJ2kxsHJyNIHSFRSv+oLeS1NO7ZPwXPAB1Yll?=
 =?us-ascii?Q?We7MS0IgxMiyKc4XYQwdGiTlxAlgo/N5UrfJxCiA4cmFNYsN+6a6Z2i8m9Zf?=
 =?us-ascii?Q?xFBAOqU31QvRAiOf9uBO89pR1XA0g2QBMjGFlW24lCgUInToyvTkpmSdwzsx?=
 =?us-ascii?Q?LBuE8YtNxnUQO78ANNo9pFBvFFYeCSyH5qLVHUPi7vQtc9bJ2LJ0A8kg8b1R?=
 =?us-ascii?Q?puy25CavfafV/SWzY6cZwyt9TRE1XC0FU2E7ORTw78jER0K8MofjA9rWnLji?=
 =?us-ascii?Q?pyfxrFF7P2YJDyMC5torGPrm+u1dy5c0BLRE4E5YVg0eQqWg6yH8NkKxtkCs?=
 =?us-ascii?Q?DnMbR1qro3UbAyXX04MruUYXolclDOh/3CdG82cPTg2QvU9d5REokMkX8uDe?=
 =?us-ascii?Q?R785YXJ2eKRMk/brd3BEGQyZuCxWJjrlYVOu9O+Jwd4J5jqWcFfmwGGvR3l+?=
 =?us-ascii?Q?ZkeBm9S8ZKMhY9dUCWCfQ3NoQ4LTntiA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:10:23.1953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e9e70b-b328-4ace-3856-08dcc07a31c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910

On Mon, Aug 19, 2024 at 02:33:32PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2024 at 05:21:57PM -0700, Nicolin Chen wrote:
> 
> > > Why not? The idev becomes linked to the viommu when the dev id is set
> > 
> > > Unless we are also going to enforce the idev is always attached to a
> > > nested then I don't think we need to check it here.
> > > 
> > > Things will definately not entirely work as expected if the vdev is
> > > directly attached to the s2 or a blocking, but it won't harm anything.
> > 
> > My view is that, the moment there is a VIOMMU object, that must
> > be a nested IOMMU case, so there must be a nested hwpt. Blocking
> > domain would be a hwpt_nested too (vSTE=Abort) as we previously
> > concluded.
> 
> I'm not sure other vendors can do that vSTE=Abort/Bypass thing though
> yet..
> 
> > Then, in a nested case, it feels odd that an idev is attached to
> > an S2 hwpt..
> >
> > That being said, I think we can still do that with validations:
> >  If idev->hwpt is nested, compare input viommu v.s idev->hwpt->viommu.
> >  If idev->hwpt is paging, compare input viommu->hwpt v.s idev->hwpt.
> 
> But again, if you don't contiguously validate those invariants in all
> the other attach paths it is sort of pointless to check them since the
> userspace can still violate things.

Hmm, would that be unsafe? I start to wonder if we should allow an
attach to viommu and put validations on that?

> > This complicates things overall especially with the VIRQ that has
> > involved interrupt context polling vdev_id, where semaphore/mutex
> > won't fit very well. Perhaps it would need a driver-level bottom
> > half routine to call those helpers with locks. I am glad that you
> > noticed the problem early.
> 
> I think you have to show the xarray to the driver and the driver can
> use the spinlock to access it safely. Keeping it hidden in the core
> code is causing all these locking problems.

Yea, I just figured that out... You have been right. I was able to
get rid of the locking problem with invalidation API. But then irq
became a headache as drivers would only know the dev pointer, so
everything that the dev could convert to would be unsafe as it can
not grab the idev/viommu locks until it converts.

Thanks
Nicolin

