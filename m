Return-Path: <linux-kselftest+bounces-19988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBDB9A2954
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94AD1C259BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABDE1DFDA8;
	Thu, 17 Oct 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tMk/o7wA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31EA1DF978;
	Thu, 17 Oct 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183431; cv=fail; b=ky0iAwPiLE9LPYfsPBwTN5aMfWTlqR8da/vvb+3DwUHPqoPWSKvXc4CpudgBROmUJfTJwGNrlKaYW9lPtvpFJ1qKMomDCPHZipABUPbm+wJl+VO5oEB93MjFxvy/3vFE14sbiZdBBx5tShuKMKAdtUoNZtFQ6i1QpvN9RCXPxT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183431; c=relaxed/simple;
	bh=oxCY/BQMYRi/O0sBmCXS6cG0x4ES9YapVKIfwyK2dKs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjhtwC/NyokjXbTMt350GvkDX1/xdaOJaOewNjgw3J1Ja3vD9lf8UXSZgX5W5M7R4b1KID5rIBTlhjpNG+wu5ouxYOvzsx76FA4RQ4iLLqr4mwHtjdh5wcifn8pWA0TVocHCrqXy3tooOCYX6Wg8CfN/277E3xxg1cJZgtCF/AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tMk/o7wA; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGYxr+qVI0V2+HDbulcoN+JI3zAyhBpeJ87ZIAlLrouuogliw6Vv2sGy0FIsTj0x8XFEpo2Lj5Y9UH62tSc6xF75XFtKBKXJXjS4DhQVsrnLfgW1+CmnDXD6yH8e/ryWSnMSf85qBoUVsFQTLDNBhSFsI22NjGwNMsrz1Db/K/enymbhNXB3Bs4ohSrsiqSLTxNpVIoRFu0R0TBsOnMVaBU8frPsamSDfpNfA2foxmukG7kPYO+xU/flMcl4EcCJq5I1+mrzk2oGYJUIdhpk+Jcr2Y821+OrkJ53FSbPztLQ/cRr344HW0MEXJxTCJsVzPoJn0UkncaBN226wSRW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJmJu7J+ZNwsOabcwQwnphFDrJ4rIZ5bWIZpvUa1FIg=;
 b=TUiuZSSMTvgg03aN2Qe76hVgxJLmknlodCeg7FTTwwxMUnmXlX1vsNNl1bQXevmj63P6cExsu+oeKua3uy9TDxMNNAXoToxyZMKEqjLFIQsfdqaa8M6q6brx0C7V6typxURDka1h2u2R1bhKOgCKdJkCT7kLvmobfFvbz110DxFyKxoDgeJAarUEbwCXFEWE84uQEVEZgycFRd+M49CS/Ws6OcWQTf6I1tZO2iAaxCiuEXGSDfgA+GdNKiPmO50SvhJvy5qwC14oxLuk83q4gujwLGBMvvtWuRY3ZWtVtCwl0DEEfIqhgJ0FrEKC4QgfO33IGxRGoABDOG8xfxLXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJmJu7J+ZNwsOabcwQwnphFDrJ4rIZ5bWIZpvUa1FIg=;
 b=tMk/o7wAh/7Tcgwu2BjUks4Ojrzi6PPwIBkaNH+oF5VOGrcxA1zyBrdBntN1j3RyNpjK5IHF51kIhL+w7eRwrE94qArzip0V9zrbRsAvEOD8wm0O0pRsO3FSmAqU/mPD/VbdQLBgiq7aASJMHOlWLQtl4vBdRAmfvlgVc7X9VeHS1ttC3NB6q0cTMlw+SVnfbcjsQoO+O2oAp57Bfhr7JhirH6gw+8FSWM32YxDuYAH0ESkZyAjbHLGMWkOiB1du8tR1EbGq0r3n1fs6Q9RyHDZlp8Eot9MwmvtdK9jhobjDc22O+H2cCWSQQZqMZx9P/c9WSn4jrv2u9kA/dNDQBQ==
Received: from BN9PR03CA0754.namprd03.prod.outlook.com (2603:10b6:408:13a::9)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 16:43:39 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::15) by BN9PR03CA0754.outlook.office365.com
 (2603:10b6:408:13a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 16:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:43:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 09:43:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Oct 2024 09:43:24 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 09:43:23 -0700
Date: Thu, 17 Oct 2024 09:43:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 11/11] iommu/arm-smmu-v3: Add
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Message-ID: <ZxE+qhw2PDCv8zuM@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <562f2bfae1661e6ff6abdb280faa0dd49df9fbdc.1728491453.git.nicolinc@nvidia.com>
 <ZxE7ILug+SL5eMsl@Asurada-Nvidia>
 <20241017164123.GE3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017164123.GE3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: c5dab642-90c6-4017-fefe-08dceecada07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XDRCG+tRx0OBHOVQM2rEXpPfK1aTzxf3AOW+TJVwla7R61DtkzqgGqfv37n4?=
 =?us-ascii?Q?QdBxqzwDaOLENVkQpKDkc6zbTjydDK2feURf5S9RaNU5JQKytPG91O4x8kWy?=
 =?us-ascii?Q?/hLn/06SG3rXtUPD6cGQYx08gxpD++dbeXIcRX730G45RzQ8qgSMj84oc0A+?=
 =?us-ascii?Q?Xx7mrhCz47jxYLSUpnq/FgM03hv1e14kAZ0lE5VPpRx495h2qHtm/yIAo0+y?=
 =?us-ascii?Q?4QhGDNar/rVyUBJEEcv0BT1j20XmlpfyrI9b5mQG4Nl/EEYeslMu10s8WQTj?=
 =?us-ascii?Q?Lj3AKX+BbseEqOT57GaINZ0oOoyihi12b8qWKgH0P+25OW4/3qzSGNEbX4Nh?=
 =?us-ascii?Q?s0VFFfzk2LkanQqU/iUGA/GTOIivBUO2uORRZDCkH8pLxzHAes2GqBnnHC+S?=
 =?us-ascii?Q?uRn4CCfPxnQo2XWECjWNbgiQjar0TW37GVHHeqQtA/SnnwgSh8xxWXXc51/T?=
 =?us-ascii?Q?sCNHn3uqY+ql/BotxBnzBHfIyEgbOsHzOCkNrRBkXdHvMmucb5H8vafO0RJw?=
 =?us-ascii?Q?ZSGWYir/bSauHqeih2IGPLqPWhy3Iv1T73XDXkMHsqOzzN3FD8WiyY1F6t3r?=
 =?us-ascii?Q?FYMTC+AsaikYwqcaCycshfqw8CuJsEYjKcIyB80qjsTncKDu9wzxfkfXpLu0?=
 =?us-ascii?Q?r6UDY6Ji0qjOy3LkCDWetZh0kfc0xbgmj3alY3rHJOzfypWrjxkfcH1LGK6B?=
 =?us-ascii?Q?lQL9TbRSLyQ2vjtzBJafcqEmFI/+pVn7skPPlN2/o+cOCT2TY1U3tF8SCR1s?=
 =?us-ascii?Q?xcI6lQkkfeWcZkodIJrJw098PRCRw/aPN7/1qXuXjsibwDHZn63Uvt+CeruS?=
 =?us-ascii?Q?Zm+j5Q9KRSOqQergmTNDWhXdG2uFVJ9i+WdnVhG8/Hvhf5eeg+NMolMM6Mc/?=
 =?us-ascii?Q?/p5zirRaT3c2sOGJzvNq6PDbeky206NjKVhrYogRxyWHcnAcyjy6FCWteNHc?=
 =?us-ascii?Q?ECNwc2ltHUAjLsPkzjfWJ+V/eEHZrrLBTfAT51jCf3TtK2nMtowZswXlxBsa?=
 =?us-ascii?Q?efubcwFDJLfy0cny/3b+hMlZ3HdHfcGQewjY0hap7WkD4f9XhGytWKEjbgil?=
 =?us-ascii?Q?u4KZEsigjtJ63kBovLFbAg2iuZQ2KNtqFwi5r5imTEwh1Od/vP7kYLdlGGax?=
 =?us-ascii?Q?4RWROeQ32xLmqFGjo3A8/XzBEiY1Llzt9SgeS6sj88KwR27Pw/AO2tTFSM4r?=
 =?us-ascii?Q?D50i/MQ9uzhoQCsJ2Yl86qFizVbqRAAlr5xCUK+0gTnN7ktcoo3SHrhWkmFD?=
 =?us-ascii?Q?VrKyP4I2a2wQdk9B2Ci0W74B9QyaejHFWSfI/8jUQjO1X4KAVQ7e69VQxLaU?=
 =?us-ascii?Q?KM3Hv7KpLhU8F9/piuTwSpB3vsB3ujqKA5q4Oz3AZAqVs8XXGdljXKTxA0LF?=
 =?us-ascii?Q?nyZjIJkEIpaJHl+roRIAaVOUDZeefPEZWqP+3H5VhcF36GZcVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:43:38.6810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dab642-90c6-4017-fefe-08dceecada07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376

On Thu, Oct 17, 2024 at 01:41:23PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 09:28:16AM -0700, Nicolin Chen wrote:
> > On Wed, Oct 09, 2024 at 09:38:11AM -0700, Nicolin Chen wrote:
> > > Add a new driver-type for ARM SMMUv3 to enum iommu_viommu_type. Implement
> > > the viommu_alloc op with an arm_vsmmu_alloc function. As an initial step,
> > > copy the VMID from s2_parent. A later cleanup series is required to move
> > > the VMID allocation out of the stage-2 domain allocation routine to this.
> > > 
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 18 ++++++++++++++
> > >  include/uapi/linux/iommufd.h                  |  2 ++
> > >  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 24 +++++++++++++++++++
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 +
> > >  4 files changed, 45 insertions(+)
> > 
> > I squashed the following changes to this commit (will be in v4).
> > It replaces nested_domain->s2_parent with nested_domain->vsmmu
> 
> Err, do we want to make a viommu a hard requirement to use nesting? Is
> that what is happening here?

For SMMUv3 driver, we have to make it a hard requirement since the
invalidation can be only done with a vIOMMU, right?

Nicolin

