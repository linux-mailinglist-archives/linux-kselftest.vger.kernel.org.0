Return-Path: <linux-kselftest+bounces-27793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3227FA486ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 18:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF37188B451
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 17:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A351E51EF;
	Thu, 27 Feb 2025 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GmGH923o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD941B424D;
	Thu, 27 Feb 2025 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678445; cv=fail; b=X0rGswpeMdme1rIzItvh58c0nCEvXjkmEvDI+VbI7Vnjii0F+UgUzU2hXnEQmlJGz0B4eHO7xWCmur9Aex8tyvlEzPPr1c1sqIDoldxNnpstCvk5oqgvgwQAcbmyrqtpnVRGOsSyLZHgFZQBBD5vtlGTDkHcU9Zqn/ltdVh0Zsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678445; c=relaxed/simple;
	bh=u27K6VXdEbDTmY/cbzR62bNtS3/82VnSAAhGbmpYlJ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLb8mk9KcMnktxgJr+i4I2h/fgaXJDTtDFnSBCET5e9HuLztOycnXs8+Kl/xI5LJBmREhN6Fu5Vflfedsvu5NyejaELOr/GZORVP55JvmF/TfPfw7FPwyEPRFWMq5mBk1pMJn3M0mn9oeLl1o9kCpXIQ0tP12VT2dc7mj4wVPmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GmGH923o; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTPRCgvZB8olkWghbvpNKTXf4F0s5arL8v0u6K758Ewe8t8CNDyXTrRayFiRQI00g2nLJ7vyy0sweM9Mel6fUBGs4dm5d0Ui1WbFbpvKfPdwM3bNRaNNaF8c2GFO1bgnigiNc28rQC582Isi8e3fYUBbJiZh+7yWzKEYso5G1DUgDCMneRRtZ3/2YUenEtzYPY/mwpqJdcfXPgh85FW+/fdm5d7MCRJqSRCMjvEQtkWNtNy49CUrUjsWdRkbJl/4PWk7yecP2DVqZjmipFoQjXkhWRxHcDAiaWuiWfjNAPdJ6ca9RL1p/Kf6Bt+AFGr2eUB4AI2ed85wEVjaKZ8EvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bWoknXiyduvcXpNpYIUL3dOOVAOiZ5FAl0OB00x/Tc=;
 b=uG7kkv35Zed6cV9DgY7VXXCHZS+VOBL6ER1rQMcaWQkhnvscRX7t34Nr7Wv/5j0fBjfjS/1xAjYITwF4qeMDkltPsDvIzxpk5yfWErA5H2mp48745MSqYpJu5uuIIc1QqR1NMH9qufrk35GMrpXKNKsBxtXFp12BVA0KAzv2btWeI1B3IV9wWrT39kOJl1723RVA/hpaA1bX1RVDya4xxhuoAoawBHv9FRKT6jP0eCUJ2QSfI41rzYtAE4nkqgV5Q8nZRSM4XGHxiIQeCUo7ve99SAWkE2Z6qmx0B6b3dIrWuoMiE/MgYsnV+OtH++d9lY25u39Ut30bKip3SRbVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bWoknXiyduvcXpNpYIUL3dOOVAOiZ5FAl0OB00x/Tc=;
 b=GmGH923oSBLHugiBNe0r3KS2KqQ5TxBC8S2tIc3GH13o5DCq0LehkpaY7Z0kbfqyS1rKSwVdEqmewsaStSd5a6BlDdHNeCQNXNWOe0MDZteL8TSyjKG42+6OBzARE5XqbZ2nU4EGnSZDTolyDCNCYTaRp4CKORFXFj/ghxQNxS4/+tjIVaj5snoEJWiKNGXwPct00APMTsJkXukYno8SVXnAX4/36vmp0rX/H3u1oOy3ri64ckYnuHrNjmTdHfQcIND8zdV5dz8iw2J0WBeBjPzd2JsitESb8p0JoTVNFbZ3haosTGJYMkiJWYNweqK88NUHFkzcTz9a750NHKHw4g==
Received: from PH1PEPF000132F0.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::33)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 17:47:19 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH1PEPF000132F0.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Thu,
 27 Feb 2025 17:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 17:47:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 09:46:58 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 09:46:58 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 09:46:57 -0800
Date: Thu, 27 Feb 2025 09:46:55 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<tglx@linutronix.de>, <maz@kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v2 3/7] iommu: Make iommu_dma_prepare_msi() into a
 generic operation
Message-ID: <Z8ClD4jMtSH31IqA@Asurada-Nvidia>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <4ca696150d2baee03af27c4ddefdb7b0b0280e7b.1740014950.git.nicolinc@nvidia.com>
 <5b9e15e1-8081-46ef-b9db-3872e98a6f35@arm.com>
 <20250221164400.GN50639@nvidia.com>
 <634c60ea-fec3-43ad-923a-cf9ba5e76065@arm.com>
 <20250227153242.GG39591@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250227153242.GG39591@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: f35b1f64-1728-41bd-f87f-08dd5756c7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h+rJr7CttCa1WgPjropsToQUo/fFqjhJSs4SBwhsAL+OFMUiStTQ9gpdduMu?=
 =?us-ascii?Q?SIvyWummM0r6M8odBGz2vg/AtziVTLMxxQLdrARp9oxICjFOUTPj0ZGIg45K?=
 =?us-ascii?Q?xHqw1350XPG8/k+O+ZH684XUmv8KN3XtK7i7/4lc8T8vHbM7RxO4U8rH8QI5?=
 =?us-ascii?Q?MQgDpPGo5BBnVQLRmvtY15u9z6QWz5zGr/DtUHS3q7ZNtjJCemorho11eIZB?=
 =?us-ascii?Q?0JpAz0KUDdmQThDsZoZGYMpOfca8FcL6E+CBK7WJFUqDfEa4+zQsrgSrqYdn?=
 =?us-ascii?Q?vLuhKaLmWrZTW3TiL5XB5fuDaxNWw4/dMPKseI02j7dLgKv9EvyLSr8Y+tHB?=
 =?us-ascii?Q?UKkJCfXawt43Ih5aUkCWRTdmxrvxuXd8uC6ssfMk6teUdqtAHRyMRrA77FEQ?=
 =?us-ascii?Q?YZPVRSLPI98mV2ehSu3DsXat2c2CxzW00qpZxSFYTSkUB/CPoCxIKJ1C6HHu?=
 =?us-ascii?Q?pUYe+qJKsEN1UrG9THKsmPDf3aGEtNFIO6pMbwLJIMH8FhVGOFi4ww7UJWnw?=
 =?us-ascii?Q?cfQpD++aiN7m6SM/QC/GiBCoKDH9dQpSq08K5N9mMlhjPEjVUuRd5BFsC1Cf?=
 =?us-ascii?Q?sxMA4UjcgBZcfLFDT2luvRp0oDwayjCKL4/6NEDDGrpA9MA+Zpsh3ELzLUYa?=
 =?us-ascii?Q?ehjTog85qQuU7qjjzLsDjirIJos8UeP9EzaxzetfsBjEDiYYgTm3LXCpwUmd?=
 =?us-ascii?Q?7YSAV2twgCF9v/pt+AYZfl38un8jIWiXexQ+G5BpEP8kxzs/OPNgmMvwF0KN?=
 =?us-ascii?Q?eygQ62/hlUO29O9/97i5c+Vyn4/owBOJOPEGTNeH76ZlCNuusUYUQaSn4qlk?=
 =?us-ascii?Q?Ywv3ThDxUARP7252pv0r8fQXOjTffyXeKL0Ortaxn4ndeNbs9d8/viG+X5Mo?=
 =?us-ascii?Q?ytUMK8s9AWhPqqfqLBpe/WHh4QmZx7X/Q6ky0CAPSaBBLzdFd9jejHnFH96q?=
 =?us-ascii?Q?GPfYhuKDYhXoBk1V+KU6s3XbInpd4BWzS9iCoWcPuxxQfJbo/jJ6zaBgn3rX?=
 =?us-ascii?Q?yARQX7Ho5qTpdK6BwUPlyrOp+fBzFnmjmyuUyER4ahOgvZM1W4hBBvi7df+f?=
 =?us-ascii?Q?c9zee7tsN7GXu9IwBk8XjEP4q1EtV3e01y7IKBkyrWLn9CNh/7ee083D+Hu+?=
 =?us-ascii?Q?ucT1eqhJu9QDNb1XQHnYlfae1OKBrhpk/nWLJxeK2uBew30L4nrgUJGNSQwW?=
 =?us-ascii?Q?DhDS+bIxX2KZ/pBXnpUVY6i14QN9vXgdpzjnXw1xMpE7pL6dZL+ty4ueHXo4?=
 =?us-ascii?Q?U4yuM6dWDEf/jVWxinGbF+zuLFWcoBgp98zF8c+dIaLQ0KxEZYa1d4XVAkfx?=
 =?us-ascii?Q?r7sQ2v0M8L5Zn5K6wI6wgF5TN9ilQ+XDtt6hZjpfO82ikM/nE1korKGO4RWV?=
 =?us-ascii?Q?RFIhmVY/6fev6jSY8u1Nm9Dhwxrc+R+Jrh0F68Re/OyidiWvNpCLcnY3wH0o?=
 =?us-ascii?Q?DBCE3C/ycexFPFeP0QI5kJlGYDyrR24Y/XhlpPL6dDaRL11KjOekhcmMWzbu?=
 =?us-ascii?Q?coPcvxhs775cfPw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 17:47:18.9629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f35b1f64-1728-41bd-f87f-08dd5756c7ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605

On Thu, Feb 27, 2025 at 11:32:42AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2025 at 11:21:28AM +0000, Robin Murphy wrote:
> > All I'm saying is to hide the callback detail in the IOMMUFD code because
> > being IOMMUFD modular is unique to IOMMUFD and not the rest of the core
> > code's problem.
> 
> Maybe we could use a global function pointer set/cleared on iommufd
> module load?
> 
> Regardless, we need to first find a way for the core code to tell if
> the domain is iommufd owned or not.
> 
> We should also make it so we can tell if dma-iommu.c is linked to that
> domain (eg vfio or the default_domain), then we can do the iova_cookie
> move without changing the destruction flows. This would be the missing
> union struct tag you mentioned in the other email.
> 
> What I've been thinking of is changing type into flags. I think we
> have now removed type from all drivers so this should be a small
> enough work.
> 
> Nicolin should be able to look into some followup here, it is not a
> small change.
> 
> > And frankly otherwise, what even is the benefit of moving the iova_cookie
> > pointer into the union if we have to replace it with another whole pointer
> > to make it work?
> 
> It makes a lot more semantic sense that the domain owners all share a
> single "private data" pointer.

I found a bit confusing to use "owner" as the domain->owner isn't
the same thing in this context. Maybe it should be "driver_ops"?

Then, "owner" could be another op structure that holds the owner-
specific things, such as:
	enum iommu_domain_owner { DMA/VFIO/IOMMUFD}; // or flag?
	union {
		iova_cookie;  // DMA
		msi_cookie;   // VFIO
		iommufd_hwpt; // IOMMUFD
	}
	(*sw_msi);
?

Thanks
Nicolin

