Return-Path: <linux-kselftest+bounces-27642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05043A46A4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 19:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050573AD4F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 18:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70FC236A99;
	Wed, 26 Feb 2025 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iJw6MHIJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776723536A;
	Wed, 26 Feb 2025 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596244; cv=fail; b=sd0dA2fXD9pY0iq7a3pMCWmilrLZ+pXAADMo/tiV5INfBExcOsUehoQjktnhiGKj7riMd5VjeSwmjvJRrRVuPTwQfR6m1pxEI0PxLr1xkWLMuSFmQy8B5Ac3sX9G6E5NE0YMpS/mLcfLQ1bDYsECUv0Ioj1dgLEz6EWpbZ4ldd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596244; c=relaxed/simple;
	bh=cuf1hqCypr+hVYDCz5HRhc+9lhiSVvsprMUkTj0BAOs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4qTayq/8/6X97YifeYyG+9DOsDsNgPQ/qWt7RiXYzyPLUxGQ+IktzZ/nAwMVzKS+LFzUM0LYTcVK4M8oaGCzab4ev7MxzmHmPswUh3h2eZDnKcYf/F1085bt0CUmwoqpxxJI5JGgkqiguYNqDyDvoSKND4Z91jSvq0+DkEiWx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iJw6MHIJ; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+uFE1D4M2lOxVPfFXRrBPh/agdDyBXuQz97KBlk0qPmO0EItUFBVXPR3l8rd+tcsLuEOGedlnIqoWGN45R6vZls+r51Rgo3aKO8hqpKmXfQ4YBHZKzSXpjWEED/6NA67hYhF7pOL1gUrkf9C+X/1vG2N6F5oVpCM6Ceb8maZUrJxUHz6azSWnSvrgmgNM+0IBLicgdfZWH/3I2dX1kJYYR0a+B4/uiG3IcT89STCrCFZA2nwdWHHFjAUctktY5YDvxFXYfZNmLCvVGNGrJTJFydh7Y2Gfo9iJKC5oyMPZ8enKOn3b3wPjG7bRQUAGx/eQ9m+2BHrr2bVuvPM4dw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxAxXw/7LlHwDuyLWdUAuIPiJid9ZZBU/iEH2WYWVF0=;
 b=E2hIS3ujayNgPyPbRHNNs3oKt69ybFPSXuR77mkNEsGO+9VWTw3c7EBEj5tBGlRJaHjbWfiLhg+D30RnTHUktx213+XmXzweYEE1Sb4Bem8P4zHDaQTn2crD/GcwBj+i52iX+rdouh0spJ6Y0uUKzav8VxsQ8CrOApnZFyv5xbkk/S7vVuCxgTYMqkjvujglK6fEPme6CI4C8xN0NO3aYcmtmq+mZwUlNot0ZhkiRbMORoPMAIgfatWEBwUCGICSgtkXqsORaYsbZU3F8S247UhXFb0R5ZCbkdYs1YBLg4VRi6APyIRPPhUUJFnSWQfJ+lknmBlAF8Fto1P90oLFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxAxXw/7LlHwDuyLWdUAuIPiJid9ZZBU/iEH2WYWVF0=;
 b=iJw6MHIJ736kXtVsWGZqez3/dZVZRRMQHxqUyaU4mxI+FKfWbA/uk2YraX8CiF0bfEnuBa2sT/9pCPgZGGznriDFK+iVL/FdHgNTavVGE93AYiMx3eU+WseguNy/HgB4tXwpwfZPBPiI551J9Yl2HLeJqFbEQQX7714G/0HzdOr3zSl6o9EuPLOd9uEEVK+zpIyRNFDA2GLdM+8WbaQoksqpkpTI3m5yxDcPsA9oC1IqgfjRFS6A2oAdLaoNJuNoIk8QUG1N9nKU5V5U6ekmLGWU+2cREHbutIp9iGmNvP0+mMRe2gMr7FvQXLEuyagt/pJbN/EggW/awM8YZqLzxA==
Received: from CH0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:610:11a::35)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 18:57:16 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::e7) by CH0PR03CA0344.outlook.office365.com
 (2603:10b6:610:11a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Wed,
 26 Feb 2025 18:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 18:57:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 10:57:02 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 10:57:02 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 10:57:01 -0800
Date: Wed, 26 Feb 2025 10:57:00 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v2 7/7] iommu: Turn iova_cookie to dma-iommu private
 pointer
Message-ID: <Z79j/DblkTGNRDg+@Asurada-Nvidia>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <949e28875e01646feac5c4951b63723579d29b36.1740014950.git.nicolinc@nvidia.com>
 <20250221143959.GA272220@nvidia.com>
 <Z757lz6ucDE6Otix@Asurada-Nvidia>
 <20250226173610.GE28425@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226173610.GE28425@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: a4558011-5267-4504-4f27-08dd56976366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/vLBkQJVDRG3BonkgmTTplGY/+8SAaPtedJNYVVRXXW1BM5bwdq0ubc4exn9?=
 =?us-ascii?Q?nh044CtXX1w1jQx1zajj/q1Tyc86FyTaxxN8nAi+qIA/rxpkz6trQiz4lfVL?=
 =?us-ascii?Q?WIW2ctm03EwS+fUdr1syF76EdHlmxORofZS0+o3ZmDVZmOz1bfkOLf8hiJ8t?=
 =?us-ascii?Q?sM0zpBQWy93CmTLeUx/iwJnh/2Z0E6EnQ2w2cKK2qXpUEHuoeI+dwjIUt7kX?=
 =?us-ascii?Q?iGQH1r9cy2PScs6Flvmx302MMW7fQbyAkrpksq7wLSQwi23DqYQhYz5qI72F?=
 =?us-ascii?Q?brEEzziPHWslPuXcLRvHokhEmBb8hc61jGGKyvliokUIFWu3VUgcq0q/VpSC?=
 =?us-ascii?Q?z5YPwuzlx+O2InjWrlSra2NK7SzpcHI47ECnYdrf5mgiZjknG/UYyF6T+y+n?=
 =?us-ascii?Q?YQmtl+JTdjWQJXqhUN9rwPYbhc7WrGEr/u9f+xqO1yhihp1HNPW8pO30zoFl?=
 =?us-ascii?Q?d7pis7LVAMjaOAfvOgxqgMZg4+y/cZ1pe4IJadjxnq/r9mWXyz2Ugu1LcWnW?=
 =?us-ascii?Q?rci5XBFNREM0TZBBuybKinGtvwRTS6VrF3fq7fts6t+QguRa4h14BLJpoNar?=
 =?us-ascii?Q?Sbru33ZIdlSO1O67QHUOmmucoPYEwwzL/CeGHtme3MbI+3PieRrpvzPBEAap?=
 =?us-ascii?Q?l5nuXbsIdfw7COf26S/N+QgHejAq5ABzX6+rAXB3gdFjvd7SNg10hPLn5dQY?=
 =?us-ascii?Q?fOb0vMG+8c9OTvNCJamng5MGYuH/689RMYXDffZccZDyiz7RlDR58rBpBMsB?=
 =?us-ascii?Q?4alJPKh4SFH9WanEqTdC7lou65ECOzwkOCtHipihAcZJd6ewbQcq6iZJnhzd?=
 =?us-ascii?Q?cXK9o0UpcBM9rQpRhWdDH0eYAR3QQYKE2Vt66A+pl5melSssh4bU6+Cky7Nk?=
 =?us-ascii?Q?3NhZy7h2nkgp0qLqXn7oKwM8bElY6HpdyaTqEe/U7jQV8xvPIeNpTDB+dHQr?=
 =?us-ascii?Q?5iTKQiK8xoXxwW2GfxSVgXSePBJcXRNReA1Vm+7zjGCcFrep9R6eMLW6Bibw?=
 =?us-ascii?Q?ksMCujOQthuNJYveTqHOMJbR01B0E4AvWYdjJw66lE8nMZxXIdNSrydy/5WD?=
 =?us-ascii?Q?Elpmsb66oqVbAcp7MpGqRnm0pNGkORLPq7ieshwlJfLIzkb20CvyB71DBzGg?=
 =?us-ascii?Q?7V7wIsFaHcmYtDhU49wnQrtJFN1pcNlCajZ8bN8TA+mwLXuSxPUeMce4DJjP?=
 =?us-ascii?Q?dj23FrKvAqiQGUz8OvhlOGoJqTo/ee6FuBa2+Gny3rbwp6VtARurMC+Rdun2?=
 =?us-ascii?Q?eNMxRf2bdZrzeKd3Zymfx5QZs0VGGnys07qrJ1rwww9ugRhyj8qp/9k7PxNt?=
 =?us-ascii?Q?k+wwhSt8/5Eqr/m0I7AYLFZb/s5rkxsJkKti/NDDDQn11tauHDW81sVfI6Xa?=
 =?us-ascii?Q?JmmK40opIltWYsnw4qhu1Cd/NMAbKU2JcijNwwEm2YASEaHY/49KTPzplMgN?=
 =?us-ascii?Q?R3vTcA9djkMk2Q5U2wMkiwsRhzOgBjt/fbM3BMPRhzEzPlToLR/T5Vm9n+zU?=
 =?us-ascii?Q?yj9y4pLaxVGeqnA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 18:57:16.2459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4558011-5267-4504-4f27-08dd56976366
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202

On Wed, Feb 26, 2025 at 01:36:10PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 25, 2025 at 06:25:27PM -0800, Nicolin Chen wrote:
> > On Fri, Feb 21, 2025 at 10:39:59AM -0400, Jason Gunthorpe wrote:
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index 99dd72998cb7f7..082274e8ba6a3d 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -1534,12 +1534,16 @@ void iommu_debugfs_setup(void);
> > >  static inline void iommu_debugfs_setup(void) {}
> > >  #endif
> > >  
> > > -#ifdef CONFIG_IOMMU_DMA
> > > +#if defined(CONFIG_IOMMU_DMA) && IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> > >  int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
> > > +void iommu_put_msi_cookie(struct iommu_domain *domain);
> > >  #else /* CONFIG_IOMMU_DMA */
> > >  static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
> > >  {
> > > -	return -ENODEV;
> > > +	return 0;
> > 
> > Should we keep the -ENODEV here for !CONFIG_IOMMU_DMA?
> 
> My feeling was if the system doesn't have an IRQ driver that needs
> MSI_IOMMU but does have a IOMMU driver that reports SW_MSI reserved
> regions then iommufd/vfio should not fail.

OK, I see. But we are also changing the behavior for the
!CONFIG_IOMMU_DMA configuration, in which case all other iommu
functions seem to return -ENODEV. And I assume we would need a
justification for such a change?

Perhaps, this can be explicit, just to keep the consistency:
	/* NOP if IOMMU driver reports SW_MSI reserved regions */
	return IS_ENABLED(CONFIG_IOMMU_DMA) ? 0 : -ENODEV;

> I don't think it is realistic that we'd ever hit this return.

Yea, the only caller is VFIO, where there are quite a few IOMMU
functions calls before reaching to this one. So, it would have
been just returned with any -ENODEV prior.

Thanks
Nicolin

