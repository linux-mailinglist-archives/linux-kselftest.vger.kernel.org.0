Return-Path: <linux-kselftest+bounces-20012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CE39A2B2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6011C21D56
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA791DFDB4;
	Thu, 17 Oct 2024 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fQcLNjZX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E18B1DF97B;
	Thu, 17 Oct 2024 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186890; cv=fail; b=V3ztc0NTYehdC16hXJYz8k3uvESSVyxwGBizGuO44zmc1Qn5Ugmx7fuXq7bGjJBYrF5chabrbx4aQq0fu6HS3WAZoln6U3jtqIgyPAW6WOJENcmb5DFQwABWuI5Au/094YsTJ2vVJsfxwS/hTv1YBCCCoBCb2IxnPqfY0TIX9Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186890; c=relaxed/simple;
	bh=Qmf2NPVYGmdHNLelOgpi8XMDTg7+c0yzn/THdIj4/lU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YY/JM+YQk3pEMKMdgcBbkk72SAC0ilFQY/dmQ62bvXgPKQS8c2bGx/qRUoUkltTMh3yDGwfsW1i0saleF44D88XiAJIfkPO8qzZWpIoFFuUrSP6eEttVj2yEY4Y6vXrGxN17L5/waBnbOc+BVt7C6NZqXrOuJolq1plIWNpKfwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fQcLNjZX; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDhvByHhiAwqggKQj3g8447E3nt2SUNSuS1Qm1mi/FgIGQZcV2B5PM3h7waogw4VcBh8ZMpTVrnWTj8g0VfD4E1P0srWv91bhAkPB4gieYlyerifSBC87M5HUkkZQZOn7PZHIg8cBCyk68yiHf73oJoQrzd83e63Obj+AHeqI3RX+EUWi0XMjglDHBbsr3OC2jzlRE93fdSDTCHCZ+hKwgcaNPcT1irg1TYEs0zKaGKz846p5Vw/1rXFv1qIUZ0Qw/P8bnZyp/UFiuOkwHDnd1RvGW8EIeX2s8E6grxEld6J9pet/lKDD5hvmtxgJFAHRd4Ay1Xs28qWKveVBeRXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhYm8JCZz3vYd2wQn/8V4DR61Lg2kFpL88k417yBy80=;
 b=W9FIk2sLSJepplWxq6hoSr5fctwVb2MkorDMl5N5a0dkz1r64nQbiA+A+ZtfQ4aaCKkSu2Q46je6HcCTsdl1v9E6PZLGuDWB5qvTobCeq915ZCJgd2FR+41AA3mt2zsUqo79FH6D/9V4mQcmlFIaHjECiPlitsFa7WLSJPTm7/p7lyu+onCeyE3aKEEwzH7MZpLItW5lfe+tO5L9ekydzuaEMBCyRe904T6INd70FxmgaFZ0f+DemN0Sgmj19MCqrj3LZhWriY9ECaZ/sPozQDgqKG38UkNpoyNPUWqGmy4mUy/oazXACPJLSBTiKG7tHidZ1n7XdP9YXMNi4v/img==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhYm8JCZz3vYd2wQn/8V4DR61Lg2kFpL88k417yBy80=;
 b=fQcLNjZXELr5HocdSOXtMUhdLzoqH9bJR+KFODN/LaOvTDTiiQNgJ4c5UexdGfv4IwuD0JG2ADh3FsNPAJU45G1W9lP2k5AzZSkUQ4SonT8i2ZV+am6aEaGTRc/JlQfAOXORU3qIKzUW0qTzcpIp4dt0jXWaSpfOzBMiYBcGLh+tISBDugCQN9tajs5OIulVmHWS4KSZfd4FroWur/044MwopZmTXiGRRAcwyVuquQEkVGyCD9t8uEKv3dKG81RUA+8KjoWKjop77tC/SLR6GwNSqzOYybRpSVkmsLkQVKk1nOPuZfVbYD4hPnBl/ndZShzbT7gkcirgy/mi8QGoLg==
Received: from CH0PR07CA0006.namprd07.prod.outlook.com (2603:10b6:610:32::11)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 17 Oct
 2024 17:41:19 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::8a) by CH0PR07CA0006.outlook.office365.com
 (2603:10b6:610:32::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 17:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 17:41:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 10:40:59 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 10:40:59 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 10:40:57 -0700
Date: Thu, 17 Oct 2024 10:40:56 -0700
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
Message-ID: <ZxFMKIiFqvydsIzZ@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <781b5bddb195bffa2ba80e5a04cb10336db74c03.1728491453.git.nicolinc@nvidia.com>
 <20241017165151.GH3559746@nvidia.com>
 <ZxFHmyxflzO2cyB6@Asurada-Nvidia>
 <20241017173855.GO3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017173855.GO3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|BY5PR12MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: 20aa9eeb-367a-4093-9528-08dceed2e73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1f+JOdep8DCewiOtcDkHFXye7wzV+MZov9dY1q5xhcE51mLNXSxGupLMH9IG?=
 =?us-ascii?Q?ajL4eyq1wnG3zmqRXTBy1FQ+OzarRmT+sAUvEFv5JznXBQbY71hZTG9o9NZB?=
 =?us-ascii?Q?DZSXA+aWJG5uuf0DGGqi9ecimabm9HDAIqYQ9mZMkXUStF3mEyYbugd7InDa?=
 =?us-ascii?Q?OpSC3kwrIdiHiKHEIzmhV2wdKkpC5gGa92xaH4Q3rya75Hja1V7beisnTlHK?=
 =?us-ascii?Q?wh8SyiMq9d2dhBHsJBoBQI90F7nQT23JTpmF8RBSDny7U7HbmsP+FxZXuRMH?=
 =?us-ascii?Q?wtmb4wWwzhJ4o7x08QVl/SnHwDoDUWLETXaL4WIG2ePRQM/KM8WFrLBIZrAN?=
 =?us-ascii?Q?OAHA+1THi1XEKC/hMB+0WI0Cnph64dNSZHo4/k90jCACz8CGYTVVo7snGjTV?=
 =?us-ascii?Q?4SmgOzB193Xmyp8o4xpZXfzYydaXReVD8imXzykABwAWh3rwnOHCmJK+lDCq?=
 =?us-ascii?Q?SIyqFA2lIDOf63iF2VkVUvBPjmWTnyKtv2qRwo23nzirafQkx8SpQZhpAAQX?=
 =?us-ascii?Q?6LzSLVMnVSBc9mg93OiFFGWUYfhKGis1vch138rnFzarbMhk2u+A+eXPgy6+?=
 =?us-ascii?Q?mc7hb+nSh2LCh59F8xFKbTIKlBOGsVIahJLjJ6eKwiRLRcY6PqpbY3AmBDVG?=
 =?us-ascii?Q?0f9C7f8bsWM2m8midCrPNbaBJyEDfe+qSGbGmPOgRKH7fv+Hcp4aMk9NOu1x?=
 =?us-ascii?Q?1Zu1JbkTnPM/gB2/oQBuM78NN00UBbG42hfHMvX8UqCJ1KDe39EXZHLHk6oz?=
 =?us-ascii?Q?jBmE5l6FJHmxvU/gkPArp/IhsMNnYx85UIe60e6tUxkMaWvD5QQUmyqxkUut?=
 =?us-ascii?Q?VVThhcmz6s51UHsyXQURB+NJqwBIXrJE/o+fqk72nZlqbOemzDBU6AWT5Rqq?=
 =?us-ascii?Q?zx4Si01BruTIowEJFcGKlej5XODFT2t4325ptCGrgRGsRoAbr7nSKdHGw+eK?=
 =?us-ascii?Q?rD1+jmJayR1rrA8AN3KaLiqKLtZXgKC3fRKN5nTUCaAAq/fFmpUyCtdxX+jg?=
 =?us-ascii?Q?RbemZHaiYPxEzmgbSvaI/Ik5IswNvfBloMQTefAao1awlbwtOoI8MqoYA/AS?=
 =?us-ascii?Q?2QhAdWfuZjmhAGpqO9/oVQqUGSrs6JZjEKVReUQua9Ye2D7iWz/Yxt41Wutz?=
 =?us-ascii?Q?00Xrzwu/jGQxbkWUp9TYpuN5RJMtkAPjk2W+1V3Exk7GUaqjvv00nqWyCrB4?=
 =?us-ascii?Q?rZeeCOx9Cc8P/6nYZ5Wcvhg0hOay9qiVEEOifmurqmIFiuC2rgukQj36EFX0?=
 =?us-ascii?Q?wIrRhCUlnWnrhXC1gY9CO9UUNALK/PiAc+7NOPrck31z+FW+19UXqisq1IV7?=
 =?us-ascii?Q?FhCqgjZ4XZySszRJHvpli7LwaOzQCufy25v8QcuCAxo3s3jP2vy/uQ7S18q+?=
 =?us-ascii?Q?M2RLUKDO3hKIX6G+/cjFNF0FDul7VJ7us7x4uv8X/clCeZhhsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:41:16.8099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20aa9eeb-367a-4093-9528-08dceed2e73c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034

On Thu, Oct 17, 2024 at 02:38:55PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 10:21:31AM -0700, Nicolin Chen wrote:
> > On Thu, Oct 17, 2024 at 01:51:51PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Oct 09, 2024 at 09:38:05AM -0700, Nicolin Chen wrote:
> > > > With a viommu object wrapping a potentially shareable S2 domain, a nested
> > > > domain should be allocated by associating to a viommu instead.
> > > > 
> > > > For drivers without a viommu support, keep the parent domain input, which
> > > > should be just viommu->hwpt->common.domain otherwise.
> > > > 
> > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > ---
> > > >  include/linux/iommu.h                       | 1 +
> > > >  drivers/iommu/amd/iommu.c                   | 1 +
> > > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
> > > >  drivers/iommu/intel/iommu.c                 | 1 +
> > > >  drivers/iommu/iommufd/hw_pagetable.c        | 5 +++--
> > > >  drivers/iommu/iommufd/selftest.c            | 1 +
> > > >  6 files changed, 8 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > > index 3a50f57b0861..9105478bdbcd 100644
> > > > --- a/include/linux/iommu.h
> > > > +++ b/include/linux/iommu.h
> > > > @@ -573,6 +573,7 @@ struct iommu_ops {
> > > >  	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
> > > >  	struct iommu_domain *(*domain_alloc_user)(
> > > >  		struct device *dev, u32 flags, struct iommu_domain *parent,
> > > > +		struct iommufd_viommu *viommu,
> > > >  		const struct iommu_user_data *user_data);
> > > 
> > > This re-enforces my feeling we should have made a
> > > domain_alloc_nested()..
> > 
> > That could make these changes slightly cleaner. Maybe adding a
> > small series prior to your initial nesting, and get it merged
> > quickly?
> 
> Maybe we should put an op on the viommu_ops to allocate a nested
> domain?
> 
> It make some sense and resolves my worries about checking for
> driver ownership.

Yea, that sounds a smart move to me! Will give it a try.

Nicolin

