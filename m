Return-Path: <linux-kselftest+bounces-27552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46272A4530D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 03:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214AC17B4AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 02:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F83521ADC1;
	Wed, 26 Feb 2025 02:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pppI9/Jt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47321A928;
	Wed, 26 Feb 2025 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536750; cv=fail; b=XMRqvHulLuFpx7CSygPBiW0TFWiNzOfcOoXGqhkwzhd1NkFtP9f213zxm7QKctBYby+3xS0BwSQGNqJQURtX/8MsILC4W+QQNPHweNaZ0TvT81JchID01m6T6tmQafr0mDQ2TM7+TQq2P/3X3BBFrhR6AhAgu6YFXWQzryV52gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536750; c=relaxed/simple;
	bh=TF/ar12C+1Qi0qIy2OEVQYtdpFLhTbxOik+EGfHvdto=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0RHE3J3Ev5rdn1UbrvX02p2ofr1UEVck+qpyMeA2MFkThG5yTXyOuU7MYCzZMPTatK+bPf49i/z5DM7DbPxsjyaxdINpZvtl3lG663B1Yw5RLd3jDC9SmKWt2VV7DwgDLjdrzwaNRCKYMjJR693IHkB3jyQMx0MUo2qzZVePsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pppI9/Jt; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpWhlsuyvEdqnsqoI8C8BaU3+nsPBRkoEY2et5bthb87Rihzf8XrrTYg+oZAdOH8Mvk4X03McbsTiZNLKf3xSYU0AehrFSLdjw8Wzb/ZMkZJenQcvgNd6WrZwncqE5GfMSdU0RMD0SSUw9MARonLoT1DUIzMubKFwB46HBCjX43Adb9AIqcdQouiAdTpQcSRJh+9222lgulnt1LJWaX/smXgwwBP7jno6jOXNnU6XhIhyUo2umkANejeth66JBeYfWYCrWVcz1tkXLllmY3kViBseKhwuGjisw8v1Y+SQgYktNmAkX7tjFkGeOcsCvFQv5YeOe8xxp3nFkecR/r9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDqJ1fA5a5mP/9+4Npmc7qDJwFIdVVri27VpbcmjQng=;
 b=A7sEzmJz7KRecr+y6Sfm2TaWuC+dRwkahvrnfLutWFu1sRHJtrqvITNyUG7YDJQAHDC4YqucFqllJZdMn4R8AuBHGdD3G/Bp5EF2T3yGoL02AL4VHi+I2Wo8hAuJJ642gZkQfGQ2XTZEHtpPDUaqyz0eYCmm7yueJdysyVpQqjHke6hRWszYLWom6txRNJSZK9N/QljzAND8QoXJyGc0z9s7THig8f9GI+Gq33dVWxm5MZVSknTTIY5vbrq24Zu7feANpiqqY+9gCTyA/6UDvPszr8oMTBZpEstzL++SggsqTy5H3DaIQyL/yXcJ9649tsIGLgKADLnstYHCBqhfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDqJ1fA5a5mP/9+4Npmc7qDJwFIdVVri27VpbcmjQng=;
 b=pppI9/JtfArEl8LHhhf6Pp+SpJ2RB9dD4+fN9YTgKlgM7J++Yph/gNWr9QQm82EY1CjOM55ovjdcxaUFesBtITXpttwUuDNs1ZLrXtzgTce3o1RZ0Qi761gMm9A9rdYNEiTPQJl1N01kzUQjSX9LEIPWJhGY8l/EZbEbLFtkeSsEaSHP5N5Ew/Xdj9Zz3iRdb4jp+Et9N1XHA9wBi2M2WUBbWer7+4XHZK9KPguWggYqfr+/6cmCyj4Gwm6CSDJ7ZbkhFtYU0tCnMY/peKhDU84ZLKWiWkcRaQM8cgUQw/C/41Xv3F9owA3oOuFCHDiqeklHSRrNy6KxHu0xu0pxgw==
Received: from CH2PR17CA0015.namprd17.prod.outlook.com (2603:10b6:610:53::25)
 by DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 02:25:46 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::20) by CH2PR17CA0015.outlook.office365.com
 (2603:10b6:610:53::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 02:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 02:25:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 18:25:30 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 18:25:29 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 18:25:28 -0800
Date: Tue, 25 Feb 2025 18:25:27 -0800
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
Message-ID: <Z757lz6ucDE6Otix@Asurada-Nvidia>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <949e28875e01646feac5c4951b63723579d29b36.1740014950.git.nicolinc@nvidia.com>
 <20250221143959.GA272220@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250221143959.GA272220@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd18569-a9a0-49e3-f5b2-08dd560ce06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5UVfllaPRPtMhKNJroY4eszeeB2fkMXaK5URiTb9NqqK8nNM1DoUZfPiAqdN?=
 =?us-ascii?Q?SslHAEkwRi58ZB+N9gPha3rRCtYgbaxPEIxlUkHHdVIAryxxAKRdFq6E1TLh?=
 =?us-ascii?Q?skZtz/4KiPBogiJwNXiEY7KK2m9E8QhR6ach1FNC2acPvKRCytkgV6/hbvoN?=
 =?us-ascii?Q?yc4UnZDxjrvrNkgtfBsi/BcnLNvO0qmRtQVI88v8ZFzpejOeFBLXQEJxHQfc?=
 =?us-ascii?Q?IH140l2andnHampIoGSFp88Yhnu62WIVyUbwxsSkd1zk74pV9yHtTb1YOB7r?=
 =?us-ascii?Q?jbJgyWNsikS/QM59vczrX7cEZJLEYVzi+1XuGHNmAaHOUelo1MjQ9F9kfDgz?=
 =?us-ascii?Q?S0ibSRB9dyvm7F8E+Ng3A3UDlHnbPp15rXZ/ELQ0/8A3kBEWPBX7IRllmHwP?=
 =?us-ascii?Q?FMEJLyikoXv7IvPjqjqm3kRQAg9FLqX5rfaKyCLdcURHUbkbfUM80mjx4iQT?=
 =?us-ascii?Q?6LwMNfDoKEdpdmP0X7o699iQgPL211XMFY6h/uiymRzA4whhuH29i72srPF9?=
 =?us-ascii?Q?oOq98RUzOQZvZvIf1e/tTCGQ2VWrRFD4y1vtz2GkYuON/71+Zkpjavodvod6?=
 =?us-ascii?Q?28DI9VkUjmkPi0VZ29yJPTyPrlzMhDCNnJd1TkdZHzv2TxLJl6WWTsG2YMaF?=
 =?us-ascii?Q?Ad7QM3ekYlj8iTXaqc5JHBolkY3Lk5aeg71mSAnMoYljGcIq9HBJ+EYR5c50?=
 =?us-ascii?Q?aKvaXkYuLw0buJOVNjFbV46EEOjzqX/esBSm1WXGtdQMLHCovck6ZjcY9tBD?=
 =?us-ascii?Q?nTpaw9Cj39nx5qnlNyEcUznKxhpQqawa75dHm+EtPVq3vQ3kb/fzery33igU?=
 =?us-ascii?Q?C1XpsS92D1ir81OQUpFzl8S8YfC6+GSVzv/Scp1P7EWUxPiMcUvRnlpWvWQo?=
 =?us-ascii?Q?KS2EOPt7vnUw/jvtaHCF2ow+iE4Pm2O9r2SH3MAFhb7dX7f7UESpEnUXixJx?=
 =?us-ascii?Q?3zKrC3ShPVPWDhLsjv5J/CEnoFNzsnld7zxh3Gi+ao65OL10/PX1xo6Ntgiq?=
 =?us-ascii?Q?tbxURNFCoGUyQQrjY4vAItLn9qRHbPQW7D7fdIPRSfnkGnpF/+EFZqOx2C34?=
 =?us-ascii?Q?sZq2OXGkSe2ptEcBFkVC/bR7KaYhBEYYpTh1Wcjv60PAwvjiCZWK5aUJHQ+R?=
 =?us-ascii?Q?FTjQXxuew+DrkPa9qijq07jsyoPjj5DoCz1l2+SqbEefOPJKULZCKxG44Z8P?=
 =?us-ascii?Q?Yx2YQBchwSzxCVy+9z4HqwQivTRYlHm+xjdb+d+MasK6xekQVieDFpjiN+m6?=
 =?us-ascii?Q?L/kRNCJvecE/mR/kkiNlx08LiS3AMC8G9htPDOLi1wbsKmb3kioMe8qpMlW+?=
 =?us-ascii?Q?hltQuq5u89GFVhfCNrM/ZLEqnfo4Hm0LCa15wOeU52Cd3w+d6dfh8/9L/Gzt?=
 =?us-ascii?Q?VDqsoJMvfxagdEVNM4n8QK1tZTSPpzz0SIaiJMqTMLuywys68GTgwh5k9r7i?=
 =?us-ascii?Q?sc0JH+CrzgehXJzw8b2lykLoKHTu8OgVoViagie6ZE9CxKpgQUm5OL9ZePyP?=
 =?us-ascii?Q?tX4TYA9F7kUKg/4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 02:25:45.9971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd18569-a9a0-49e3-f5b2-08dd560ce06d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680

On Fri, Feb 21, 2025 at 10:39:59AM -0400, Jason Gunthorpe wrote:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 99dd72998cb7f7..082274e8ba6a3d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1534,12 +1534,16 @@ void iommu_debugfs_setup(void);
>  static inline void iommu_debugfs_setup(void) {}
>  #endif
>  
> -#ifdef CONFIG_IOMMU_DMA
> +#if defined(CONFIG_IOMMU_DMA) && IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
>  int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
> +void iommu_put_msi_cookie(struct iommu_domain *domain);
>  #else /* CONFIG_IOMMU_DMA */
>  static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>  {
> -	return -ENODEV;
> +	return 0;

Should we keep the -ENODEV here for !CONFIG_IOMMU_DMA?

Nicolin

