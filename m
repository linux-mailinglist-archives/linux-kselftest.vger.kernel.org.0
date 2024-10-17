Return-Path: <linux-kselftest+bounces-20006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CB99A2AC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D692F282D39
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6C31DF993;
	Thu, 17 Oct 2024 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WNYBFXbM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB161D95BE;
	Thu, 17 Oct 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185726; cv=fail; b=Fd174aSCh3grxLakr82N0/C4IzL0oNxQANAJXzdAyMG7zSBCkHrzfe56BoI21eakZBch2RfuByaOVr8PGV2mUj0V/gIFhr+0tf0QSZtgQqbXb0OUCPjy/byOGVKNYymhVSip03DpdmjRTv90yjKBxWPHX3o3U5qxC35n7nNjKkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185726; c=relaxed/simple;
	bh=aZrRupmESj62XFJM/j6Hph1SfHs6PuZRWVaAzGVdFws=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7TUz2ufvIrLGg2DaHNQBsA7R26vPLwDDH/XZ6OphqOj1SfaQ9G2D8eVdlQ1WMq5HcB9O6C8dc2PR//uPhaJPjk4utdNV2F2A5y7wa6iUrjs2S/qzROF47DLJy16l2Gndui2qx+eTNmuf4U2UtNA3iupQC7KGX1hkBe9VXfY+rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WNYBFXbM; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjR9T3oky39kkJn/4sCGFJXhLsxZeUI1BhBcbKh9KLeuOy1FXy7j0pQgYbF1Iro/1nJE2s4N1RvZ4g143/fEUUCwx0FUiZf2kyNUXxz2l4YUjkg0NsD/csk6Tm5PUqZJ40035Pb+KNOFQ2LVS4BmwY0jFKl/NqUTcz5IPMrAX5DaVsTvtgrHpfagila9dnvTglLG07+QkQcvYSKdXzeGEBMvVYoGmsY3O+AxyvCOYkhkUnC3bfv7n6qzt4ZxoTNTvUy2PHQ+9sVjiUExlCWRmRM5+685Mv1H1t5Sq8Sg3Xmx2JzlR/DukMl4vVG3kuKvhovbMuwihn+agfly4Wf9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfvCuBQEPLR0RSnvgPPxifuC9sqAldr4err/t7ip2sA=;
 b=IVysQxFvdzc4kufEH4CPJkmdKOHPEXeZGGhcd0XAjNYsRhAQQjMpw7rl4FIQkJjmpE5qeOfIWgjut0E2IF1xHOnqFUwhIITLODr6tuySkO7v8btEwhRW584524DnHNgIEKKtyFTENBKgxMXsknQ71pPmRZ89dlT/o2+dd3FnhyWzkwRAeqOY4+XItcFAwaooeJy9imsjLjeCvBkHTRJLEzanatBj3vKpMReX8P/9R5CXfMRIOL0OZUN3w4h2ZnyS+TzPynjc88QhLd35Fade8jIS8KhtMh5yV92C46edMOC3I7VJvUd1u5L4unHe49S7e4CQSyBxOehVd1CLSOkolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfvCuBQEPLR0RSnvgPPxifuC9sqAldr4err/t7ip2sA=;
 b=WNYBFXbMu0Z1o2omikenfOtGKxwzpJ0Qn8fsk2OqKQkN2KvVuKZ2qYCjmaif/z7U/AehDNdYDpgDkhzbkGJhXg0y06lEbtLfanKRFudgazOzpMD8ARqwmVK0/aEN3iMixzrQvPC22unkJ9bfdtqKjiVqTy/D2P6tvgG22cXt6bIy2dhxobCN1JSttrKIoyi6LHFqKjqT6RjQNtddIV10oyhQc1tgg1ZnFfbz6rOx3rDa1HoXmVnzhVoxeQaSF+3W1jjLu/CpM3CXTL/C/P4594YX65LngGk0fI+cY8BF6BAEZjiEeC9qJ+gy44u42Qkb2lmscVulQBTZZpMk5bo4rg==
Received: from CH2PR02CA0024.namprd02.prod.outlook.com (2603:10b6:610:4e::34)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.30; Thu, 17 Oct
 2024 17:21:54 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::5e) by CH2PR02CA0024.outlook.office365.com
 (2603:10b6:610:4e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 17:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 17:21:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 10:21:34 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 10:21:34 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 10:21:33 -0700
Date: Thu, 17 Oct 2024 10:21:31 -0700
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
Subject: Re: [PATCH v3 05/11] iommu: Pass in a viommu pointer to
 domain_alloc_user op
Message-ID: <ZxFHmyxflzO2cyB6@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <781b5bddb195bffa2ba80e5a04cb10336db74c03.1728491453.git.nicolinc@nvidia.com>
 <20241017165151.GH3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017165151.GH3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff8f584-614e-4397-da33-08dceed02f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I8jz7b/NbtC09U7AWhaJ07ngHOIpbZ+ttjvQ0SnalCbPNHJiJvChemVQEAR8?=
 =?us-ascii?Q?C4EZKJkJJrVPjwzraECLDYwvNNNTdOXA3RQaknlAdg806fNtminzE2yl3ODO?=
 =?us-ascii?Q?By00EWcHrOTYzebd6k65S+ZL/QzlG8JGZfEJFm0yF2HZ9ADyv7PIiMLUkRt2?=
 =?us-ascii?Q?ePAeq0t9sOkQxqLWB6YGdxU07/VfUCmHBxwpR0tqlqF2kIUYm6bFs/KG2RhY?=
 =?us-ascii?Q?vr1Kc8sa9l57Jq4FH386Ro2BzpTW+NnCJ2UzYYQONBonl1GkC2tX7K442HD2?=
 =?us-ascii?Q?r60IVUUhgT9YzEB4m0XMiHs6DQvCM4nk2OLxVihrVcKuH/CAJdkU8IwiMaf1?=
 =?us-ascii?Q?2CdkU0NCoqDY9jUKqfrZ4MmzJ60XT+fI/flhKA20hXQ/cCyXbug76OTGEbGp?=
 =?us-ascii?Q?NWYYW2FCUG51GRLLKLS/3nP5S+j94E5AxxdpkCVyariotb7NcXgXOFwvNX95?=
 =?us-ascii?Q?l+92QT/HGmR7Lqw6gmgaiL8uaLa/lBoJ2vLZqL/dl4KTeVRLrgif6c5ZftSO?=
 =?us-ascii?Q?DYiv+1ytEuN5ueaBICHd5vQl+nIDeGMt2EEvj1ed9yZmmcD72PrfGbPG6XGQ?=
 =?us-ascii?Q?RSUNRRSjsB3c3Q88i3Zj4LEmBnrT/odW9Ikq9nyEqmXMJNrboemBAhPRm+Il?=
 =?us-ascii?Q?P/OkagZcth6+CB6cE3rvLgdmJW8xH5hwRsboF0GGK4psQmPkQEG8dmE27hHF?=
 =?us-ascii?Q?hZ2g3ghzu2UjnOS/PAjPi4qvpvdvw6VGdKM2UlkKBEq5s24pjJ7WfsM94Rl+?=
 =?us-ascii?Q?qoTE6RjPkC7TsUZu1vaHJimfEiZWtps4a/aO5FGRpTZ6WtxC/wHjWGt/KNBE?=
 =?us-ascii?Q?VHjwx3C44P2XEuG8AOEFnKQkHzZXqApR/4B6vLfkVXnty8k6L9XeVCADm5k6?=
 =?us-ascii?Q?Z+v1MlArfHKKeinXQSbqgj4vJrEBNzmINnf9ZLmju4RyGSuWruLRrCE/Nso+?=
 =?us-ascii?Q?5KPUjG0R9yrsg9+8T3RKFR+XPYC9pU09PBanwrzSmtJkc0fsYSrW8/3NLuXk?=
 =?us-ascii?Q?sRXk5jHOiaRT/8aA64Yb6IdwihcUYTWHGh2GNovfMptf/LFTZva2M9DpLT/Y?=
 =?us-ascii?Q?VY514z0VlU2vBYcFlXyIKulmoNWVHkV/zPMuBjx3rWlLVi1yWJ8XKQBTM7Pg?=
 =?us-ascii?Q?jXGb6b/EhqScy8RP2PYK3EICUyZ2C+Z7pJBL+Nwbps/zxqxgLQh93upgguMD?=
 =?us-ascii?Q?F3k0ur8J5XLxRbYETCFjA/HPdN8knxg5PZW8L3agu7wuWKEocg/mVqNnUKx8?=
 =?us-ascii?Q?SxW4+0zGm5yYh19gr7HPB2xWgv5QWX2iQJCd8v9VmXdUmjdlc9QKGZgyN+hw?=
 =?us-ascii?Q?mCL1yKJwlbGSygT+ARYuHaA2/T6Wee/MraKU79VOe4giX90/j/iQSkmE7Q43?=
 =?us-ascii?Q?gOzHwtXnv1MXVqJYKqL2CAK9TV+Orfq+nUT6oHKa3VIJsJB8bQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:21:49.7425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff8f584-614e-4397-da33-08dceed02f99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790

On Thu, Oct 17, 2024 at 01:51:51PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 09, 2024 at 09:38:05AM -0700, Nicolin Chen wrote:
> > With a viommu object wrapping a potentially shareable S2 domain, a nested
> > domain should be allocated by associating to a viommu instead.
> > 
> > For drivers without a viommu support, keep the parent domain input, which
> > should be just viommu->hwpt->common.domain otherwise.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  include/linux/iommu.h                       | 1 +
> >  drivers/iommu/amd/iommu.c                   | 1 +
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
> >  drivers/iommu/intel/iommu.c                 | 1 +
> >  drivers/iommu/iommufd/hw_pagetable.c        | 5 +++--
> >  drivers/iommu/iommufd/selftest.c            | 1 +
> >  6 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 3a50f57b0861..9105478bdbcd 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -573,6 +573,7 @@ struct iommu_ops {
> >  	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
> >  	struct iommu_domain *(*domain_alloc_user)(
> >  		struct device *dev, u32 flags, struct iommu_domain *parent,
> > +		struct iommufd_viommu *viommu,
> >  		const struct iommu_user_data *user_data);
> 
> This re-enforces my feeling we should have made a
> domain_alloc_nested()..

That could make these changes slightly cleaner. Maybe adding a
small series prior to your initial nesting, and get it merged
quickly?

Assuming these nesting series can make it to this cycle, that
would be in the late rc stage anyway.

> >  	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
> >  	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index 8364cd6fa47d..3100ddcaf62e 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -2394,6 +2394,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
> >  static struct iommu_domain *
> >  amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
> >  			    struct iommu_domain *parent,
> > +			    struct iommufd_viommu *viommu,
> >  			    const struct iommu_user_data *user_data)
> >  
> >  {
> 
> Do these all need to check for NULL viommu now too? Something is
> needed at least, only valid viommus should be accepted here. Like you
> can't pass an ARM viommu to AMD or something silly.

These drivers don't have iommu_ops->viommu_alloc, so a viommu
(!TYPE_DEFAULT) object won't reach to here.

Perhaps we should block IOMMU_VIOMMU_TYPE_DEFAULT allocations
if !iommu_ops->default_viommu_ops, in the core.

> Should drivers accept the default viommu?

Yes, driver can use default_viommu_ops.

Thanks
Nicolin

