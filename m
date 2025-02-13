Return-Path: <linux-kselftest+bounces-26590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74451A35009
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 22:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F613AAB32
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 21:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D3A210F58;
	Thu, 13 Feb 2025 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hLg7Y3mO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91728A2C5;
	Thu, 13 Feb 2025 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480577; cv=fail; b=SeLGIeirM5KVc0A+XANlmn5oZeW8u5yL/KDRIUr/ODwMSfZCjAXovS399Tjb3TPpg7wYDXyRS+vfd5aLT06DwxuIRccxu9WJ9hyGgUZfn+t+zqTl8bnhL6sOQPiWwqMFhrrGFbldPON9f4tpl42ENZ4vMWYWxQMdedF/tfKnECY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480577; c=relaxed/simple;
	bh=J1aGq63zdH+drcxu3AFrkVZo0PZyXypFnYtQi3cQMc8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7mc4VyWlsLJS0rpFWSyI/+U0fSpoXbE5NQz4sq+YzPIu8zM68a3J1DWATbMj5BBAvySrNR1VmuLo/Rfr5jG9VAoVBEaGKKe30F/wcZcvDaoO4O2Q4egDR9XmPQ0Q5McoGz97OIhoqT+foPa91V0maqIbVBUFYOAWevJB6epBq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hLg7Y3mO; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jspbEy92RilIjawsSOdY1gAFc4YbmVoPGzrg4ZzbFkZwLQOG/pqgx+m+IV0tKj2sIX80RIf1xWA6r729jR8U9u5sOEUwEmmnn6rOOspf5Gvnp8cvV/T5QMb1F1DGn0BTgg8UniFGiLt3eN/lnbDk126iAt/dR2IKmTYxNTnApymqW/aoZ1nN6TIhot+EVsEwrcZi91Plb2HiDkDkzNnK9sddKkjzE5shiM+MPm182LkLdjSNpsCMLON0E5wSa4crwLDsWiGtk/0/Pg6t9VtzcMypdXdhRMxr55Y8Fbyeqn6jkhPvGK0bdae/xhkCSwdvb3F5tdf8wypbterBSOONTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csu4DBoxjv5W4UWravDcA7OClxfI0xlplNq9iKu0sEY=;
 b=dNvYlaEQc8rAFP5xXy1Ra2/8u+Y2ZFX84IRisNEUd0aOaaTkPKhQ0Zj6IkrJA8BSmWytsjoPc8vhQ0HBs7OyAgxmTwXDYTkO1IAi3SFErsnqt5qCFMLMFXEPBXw0XGr0NmpXPjFB3ReNJCchReJqlO+ZY0EvOtRhtcH7PSykR5edwAfXOH4ay7pdadfC16uGKwb3JpeI2WzK2Q9MN9iw94+CJWNTiHL8xWcmgvbCzfdtLBoJAe54PShH0NztClTA+5EFcIAPO+m5C8YzOUrlGqq93sfKw1LLEhJUiEddbNaFpBZhXWUrrmly1s0mchp0P0gtupTbEBJVQFDVc5MKIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csu4DBoxjv5W4UWravDcA7OClxfI0xlplNq9iKu0sEY=;
 b=hLg7Y3mOR7x9l13tFa79DNyi/JB/1Q+zMShG4I7tWPzesDPBM6aM9QW1SopwAx/8ergv9rRUXhMCZ2/rTI+Fwh1R55kkz3pT/oIGDHtiWCvnhY4Ap+QxyuDe6XybnN4sWOmURRaBi9Rj/MtZz630O0JF+JRsOI9S1Wu3WvFp1+rRufFf8n40QgUFUYQhbPfUpShbzyLEg1p5iEfElB6/5M5Uk6QLgJknWViQtS3rChRyHHq6qgS83Zl3WSowK9a9j7a1nefSfVTwD8/fR/0aqwPSDywRFOWtHZoTHN0D157FTPZ0XPupBwlU+AUyq2VfMfFQO8B9gf3iCvQ7g5Qf3w==
Received: from LV3P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::8)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.23; Thu, 13 Feb 2025 21:02:50 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::e6) by LV3P220CA0029.outlook.office365.com
 (2603:10b6:408:234::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Thu,
 13 Feb 2025 21:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 21:02:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 13:02:30 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 13:02:29 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 13:02:28 -0800
Date: Thu, 13 Feb 2025 13:02:27 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kselftest@vger.kernel.org>, <eric.auger@redhat.com>,
	<baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>, <yury.norov@gmail.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 01/13] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
Message-ID: <Z65d4wr1D3F5bBeC@Asurada-Nvidia>
References: <cover.1739005085.git.nicolinc@nvidia.com>
 <a580069c5e494ffffa668218b6fe3a207b01efec.1739005085.git.nicolinc@nvidia.com>
 <20250213122849.34f5d1cb@DESKTOP-0403QTC.>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250213122849.34f5d1cb@DESKTOP-0403QTC.>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a71bca-89e4-452c-f5c9-08dd4c71c661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uCTdVZQcuLvYhnZrPKtWrSk5jNiW0i6mB8xpEwtf7LXR55Mk0v/lipevwjTC?=
 =?us-ascii?Q?1FPy3f4gFfc1zv6IXJNsZbQXJHYyh7wLTBSOYPWWNUO99DF5N2jmoc/rLIIb?=
 =?us-ascii?Q?4CBpB5wiyG+mkrIJze0Fm8j1KjKL+KyRSHMO08r2e7tAsIvyQu4gM8x+Czfb?=
 =?us-ascii?Q?G8XyqLZa3289t0vW24YYa9B1KnhfazbmQNArwDut2Xy5Gr43Lf55w7U5NJlv?=
 =?us-ascii?Q?tKb8FcX7qQEMNDBgS8YxgUtfBf15pAe0yyE9lHHOjIfGNMVybJXpgEiuYDsT?=
 =?us-ascii?Q?gieWqZYOAgQ4dygW59+k3oYMLcZ0i5uuEZ10Ft7FkV9TUlTcl0ZQ+vxmjhEB?=
 =?us-ascii?Q?0rKSvc37ixlb1C0Xp/U5JN5lT5Kv5qhQwSj9wSRnaYX2VjEBYCiZvAlA/aJf?=
 =?us-ascii?Q?7nLgWnH2Dy3bBQQ9atVelRbHW0akzV6584HTww+qXVh5a//t2Hg/THDb19xr?=
 =?us-ascii?Q?tKoLNEwc9/UYB+cNYZXe54WXErTS4dXfYkZoJ4CyLgZaqA7fRqjZyu3ulzof?=
 =?us-ascii?Q?i06cgF3oBecQZYF9ag4DhZZ4SG8nEZ2fL2kypnlJjSqYXn5Nr2En25DZeDeG?=
 =?us-ascii?Q?Qo3AeBIKyH58U0b9T/tJMKd+3NGRxi7a2YcFqy+AHiSyFlpKHo6EbulmD/YP?=
 =?us-ascii?Q?3uiOYXgMW/gkC2FGDNhA1VEoa2Y1Isdb/IqQAjL74TaSUY4nUuGHrJLzk3J7?=
 =?us-ascii?Q?Locskwrtcq+RnqZTAU26O4BqN9wP7hHj7QxOOFm3d+vvq1Sxerva8hWQI1VT?=
 =?us-ascii?Q?hkdPByFWAsjVUniADsN/85uqfDfq0z3edP6sRVpg6RGF2t/FXL37DyWNkM97?=
 =?us-ascii?Q?3Kp7jGkNj92Z3zfx9BRDnSj3jH0ntc1nZNXsSqk5o35MsDuH0Bfje1BMZITF?=
 =?us-ascii?Q?4/q8KFtOIfK2I3x08O22kd17TZdDimGQNH5NyjC8Kby3ASOWL3pApndqu0RD?=
 =?us-ascii?Q?Nxw33dXC3iGlS7Av0IPWhpWMtIOVz5kRKj8vqsZG9am6kjjliZGob10i0iX8?=
 =?us-ascii?Q?gGGQRxQhMUtehjDWEuSY5Vfcs6aZrlRv7L3DRrf3Mgf6vGRUAxj7mhk4YKK8?=
 =?us-ascii?Q?1y5/HNfXuLTRulD/bLriBLbHAOx8+XWFkv557ny00FHpfW26LYtYOZ3H4d/0?=
 =?us-ascii?Q?sEY1t10frYM7GAoV3eK3urgmsiy9HS2Xd9Xf0ChbjIS7xK+2zRQiGu/Ux5ws?=
 =?us-ascii?Q?tfn9t6fm5gmEjGgE5K8NAmr2SNB0H9Zxdok6pr8uckskSHTzW4vUM/EOEaZC?=
 =?us-ascii?Q?x15EXp0Azo7KELzJr8zM3LKv18cdtvFYEAalXW3N4UDq2zloYjwrpnX12BSo?=
 =?us-ascii?Q?oZJ22JjVBqaFrKTjrbLOB6MgOuvt86nTHkkt5EB9iZO1AvLEVYjy2K15JGeU?=
 =?us-ascii?Q?0+lzFN/gMNyp44XuSoYDUMg6xT80qmns06mu2O6AQtYxVyw/pNEW5Fcuv68H?=
 =?us-ascii?Q?JQl8dh4ZrBx1uKB3P8OTjT3uXahmYldb+BO44BhPUwdqKM5shXag/DU2+H+l?=
 =?us-ascii?Q?c7uYVdLYxKNCFpc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 21:02:49.7771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a71bca-89e4-452c-f5c9-08dd4c71c661
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

On Thu, Feb 13, 2025 at 12:28:49PM -0800, Jacob Pan wrote:
> Hi Nicolin,
> 
> On Sat, 8 Feb 2025 01:02:34 -0800
> Nicolin Chen <nicolinc@nvidia.com> wrote:
> 
> > -static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
> > -					     const void
> > *iommu_cookie) +/**
> > + * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
> > + * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
> > + * @msg: MSI message containing target physical address
> > + */
> Is it IOVA not PA?

This is moved from dma-iommu.c so we didn't change that.

And I think it's correct to say "target physical address" as the
irqchip driver does pass in a PA via @msg.

Then iommu_dma_compose_msi_msg() kind of reverse-translates that,
overwriting the msg with the "IOVA" from @desc.

Thanks
Nicolin

> > +static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
> > +					     struct msi_msg *msg)
> >  {
> > -}
> > +#ifdef CONFIG_IRQ_MSI_IOMMU
> > +	if (desc->iommu_msi_page_shift) {
> > +		u64 msi_iova = desc->iommu_msi_iova
> > +			       << desc->iommu_msi_page_shift;
> > +
> > +		msg->address_hi = upper_32_bits(msi_iova);
> > +		msg->address_lo = lower_32_bits(msi_iova) |
> > +				  (msg->address_lo &
> > +				   ((1 <<
> > desc->iommu_msi_page_shift) - 1));
> > +	}
> >  #endif
> > +}

