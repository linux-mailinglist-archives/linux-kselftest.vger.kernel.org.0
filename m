Return-Path: <linux-kselftest+bounces-15442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3009A9539D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 20:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E4F1C23479
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 18:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D0F53E24;
	Thu, 15 Aug 2024 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jzqft+8a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B39481A3;
	Thu, 15 Aug 2024 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746072; cv=fail; b=GCAoML3J10vVu9SpXUrmLg5Jck+j3iyiB7+o729t1bIQ9MraX+yRUHpirA5xVov8y9ppAqmMyQMv2mKfJdPqyhLpT3Pj7C1CQeUgt3l0V+M2ddmf61YBZmRJGN1Oz4Ewod2RwwSqNY5Y6GzxYuSbS5LYHzyYlzdhxPkFBkRK5Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746072; c=relaxed/simple;
	bh=EtxKTkJrhWIXWsoyex2KlcYMN07qLmhdQKLhLjfTRqo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAQ/Pt2hWyyLt7imvf/Km4fKAV4CV6e22aPWoZ+G1SrYLKLa2xMHByuBRaTs7lmkR/d5fiXxDaxHr3DY/15KLGjufTvqcmPWMmq8vU/ZOP8LA4YnyxcOS1OC/AgKk4TzwmngXV1oyrpudBbRezI+AIxxKormHdDZdv7RPPpAubI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jzqft+8a; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6pd7oXOCNlB/B/lrMea+e5x6KJ4I+b+4bm6On+ElLjTyJRViop2BrYbHxFnzqvYouByQwlb5A+vOt0tMIdqs3YMif5mUffQsHAQxf4eb4ST+5rspLX2mXoGDYmi8ff3/IM5C+ZZlWkeh4pIagkCAiHXG1DKkBBMvfz9xS+9V+zYHkF6WZ7h2c3/Rdc39hYfVdhVfcPHBMqbIop6anB0WSzQH2CwRiYPPbyoNqnA84Hm1DGKBhf74xlajVos+RcqUeHWL7HaF80wzNEMxV0+ArSumuFuxw2WxmpBq5nzcaSFPWyy/yCO3R0gyhA1LJyHyg8OEYTw3avCD0dABJeiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEX45kc5VAo4Y7JqdR0EkQK6qSCrMn0gPS3wL9dw7cU=;
 b=n8QSoG1y4R5M5LBHqi59vk2d/br7+fVhmH4HPAO5aBtVs1i67UO5UYjw9cMJmXTC6Nkd7tIz7UU2vg7oM34+hPPWpA1cYxFB1a3PZFBQGkuYSuVAqRF0ciBv5S2iTYVbTd6Yz5RjMRssh6hyxZONcv+8OybPHX6j18gete457z9b1y6Xhw18Bf8DHAIYyu3moeKGakfqUr3f3vlx/VGBYNdxxt6/Lgp/3VoyN+YqjRbuIsYC1CQM0y8bPHG8vmA9p/L7X32CES2mOkV9LUWuD9m6CWgVeEyMG/7tM83LEjEZSQkleCTHXmuZ6hxLe5G+fdh4NCuOeZ4IOYFEV7qtvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEX45kc5VAo4Y7JqdR0EkQK6qSCrMn0gPS3wL9dw7cU=;
 b=jzqft+8ardv2VkJA/bKOtlSvaS18DkPU8pPmEAITkGLb/CBzkwAQnpwW+JDPycFyy+o73p4ORvqWP5rqQUXqjT9jTQdeQoNQ3I7TNxtBkK2R7jJyZgiv8CdhR0d0mg1RCdZ59NnwOl46xzHTnE1z0cA7J2yhtxPUNiA1VG6ZVot1hj/NQH2R7VavunkWO/QgSIPyx42tfjIYAUg9gmtcdKZbU4yT2qqMPBsGR0DTJppPcMwb1a/JIj8jQb4ozCcgcqWfL7l5bJTLmm6e8JA3GmxI1eKbGc/EHpLpiZQDFqdJa3ffkYu6uAbHjZSlC2OJxTwVbMl5nlFMhSYzVZwkUg==
Received: from BY5PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:1e0::40)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 18:21:03 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::6b) by BY5PR03CA0030.outlook.office365.com
 (2603:10b6:a03:1e0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 18:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 15 Aug 2024 18:21:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 11:20:37 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 11:20:37 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 11:20:36 -0700
Date: Thu, 15 Aug 2024 11:20:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 01/16] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <Zr5G86A2OwjAl/JI@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <536c5e908af3847649d1f4b7050af17d77d8b524.1723061378.git.nicolinc@nvidia.com>
 <20240815181117.GN2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240815181117.GN2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|DM6PR12MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fd37d6-95e9-4929-132a-08dcbd5705b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WA6B+PYXfVmMYY1/CA2aziBRCkp9LGAhbUDPOhAHx8yrkeuxuS/xo7jC97nM?=
 =?us-ascii?Q?fYQeMK/SgXUEeOhP538k5bASCeGUlfsIxd59OFLPG7wyfAqE2pWUCxGG/d1h?=
 =?us-ascii?Q?4sqUaGuvD4jG9UpJcS91sPfveMzdDQWLDLkMphBl6iASQvTP4i7KnnCnIjnf?=
 =?us-ascii?Q?/GU8iUbrvO8JUKLYbLXQNNTvUg1xKKFuzUNPXRFg8d3NNfMq38uo+BPq+45n?=
 =?us-ascii?Q?7HTS1Cox37LC2iOdZE18t/GOAROKmP5Cvt7KBZFOBa4l323AK6EQLzBPvrjS?=
 =?us-ascii?Q?e6G5R89I3hzKlY+2AXciwM0XTA05bhJt+1QquvYv2fvreuheMYF9I3A8xHRD?=
 =?us-ascii?Q?pvi7+pF1QyWr5LMaJbOijVDNWccMj5WuCnRKACqj1QTt59O766+L9dHyJT7j?=
 =?us-ascii?Q?kzPRSKXI3EjChIvWJU/NozMB5iIhXnbZ7wvE2wmj/nTA/5KpZE0+1ePHiwWT?=
 =?us-ascii?Q?zB+WBn7mes7nBH4IFdV2xk/A48eTNMOvsYYVG77luttuPTeYlqQg8tE/oplg?=
 =?us-ascii?Q?0aXcNycxjNPu49H3CDc6BRvfrxfqN5x8s/A1NxchtKCQ9HdMKHHNPgov90yP?=
 =?us-ascii?Q?F5PF9deLMBoyXceQI+2jkE4AfhXJGVb6bQIWdHgJCSBhAov/8SkYu99uD+aY?=
 =?us-ascii?Q?fd1rkbUo2PZ1Rmxnh8fW6ZABKsyQ0Z36S9AuBAqDFj98S2+ObGBDiiQGf9mw?=
 =?us-ascii?Q?O+76pUvp/45AC+Hd/QKVea5M/qobsCN28pUjBkQfazbslpDSvtMTK+C7i1Aj?=
 =?us-ascii?Q?oQtt61TY+Hy+OK9hzdC+gCuspFJPPRxMU6+5YNi/+v1gvmVThRsOnLJ+rLXn?=
 =?us-ascii?Q?/n2MQWx49rs0YOLrQLRb3/WfpUanbC6Ui2xiOSN3f3LWXYeZV2BX1PGbb9wd?=
 =?us-ascii?Q?n2HXEjUl+jgxm2DNhz2Oy8Dw0+VLcnTHBw58a/NxW0VvwyYV4zlpZNFd3CUE?=
 =?us-ascii?Q?wUmk8CKyR+dlSJdRN8a3A9BsgurT088oGY1ty+35EYkvww3QUg+Rg4NVDJZ2?=
 =?us-ascii?Q?y0HOERVdTtZnyV9I2HnjRc9UakimSued7RNFT0TSL6n/CIHDTYpoa94kiPZQ?=
 =?us-ascii?Q?BR4Bx2/Lpso/bWH/isAp3P75p3I1nK3G91ZNMCAWFKB51+yN1dYSjcIqwMt3?=
 =?us-ascii?Q?KJxCNw043hMyGg1sXWxXADafOMfy105zH09zmk2tU5fyxpIx/HHaECEUpKus?=
 =?us-ascii?Q?WfkladZwjQoXvY0eRdx8yIa8BaeQKbkoSkGm90OFKXLglyTO/cHNteQXZG5Q?=
 =?us-ascii?Q?29F+4lt0R3L41MZjkbAMQPoJYw1g57KseIqRBocTd+0mNfsFrR/Qj7fcl+1/?=
 =?us-ascii?Q?yFhJLgJ3OZ6+Mm0rsx4Gvirsotif4+SJUoU3PRCL5SRBbsXeODbbYxL5pGJ3?=
 =?us-ascii?Q?ABqndSX1hF98Q16I5GM3HydBKCsUy6yMaYGrEr3yLuUt9x1zuD6yKqcE2rJC?=
 =?us-ascii?Q?lHAMtV1+WYImyXJCm2CKXHJ7wmnpeSsC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 18:21:03.3893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fd37d6-95e9-4929-132a-08dcbd5705b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339

On Thu, Aug 15, 2024 at 03:11:17PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2024 at 01:10:42PM -0700, Nicolin Chen wrote:
> 
> > +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_viommu_alloc *cmd = ucmd->cmd;
> > +	struct iommufd_hwpt_paging *hwpt_paging;
> > +	struct iommufd_viommu *viommu;
> > +	struct iommufd_device *idev;
> > +	int rc;
> > +
> > +	if (cmd->flags)
> > +		return -EOPNOTSUPP;
> > +
> > +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> > +	if (IS_ERR(idev))
> > +		return PTR_ERR(idev);
> > +
> > +	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> > +	if (IS_ERR(hwpt_paging)) {
> > +		rc = PTR_ERR(hwpt_paging);
> > +		goto out_put_idev;
> > +	}
> > +
> > +	if (!hwpt_paging->nest_parent) {
> > +		rc = -EINVAL;
> > +		goto out_put_hwpt;
> > +	}
> > +
> > +	if (cmd->type != IOMMU_VIOMMU_TYPE_DEFAULT) {
> > +		rc = -EOPNOTSUPP;
> > +		goto out_put_hwpt;
> > +	}
> > +
> > +	viommu = iommufd_object_alloc(ucmd->ictx, viommu, IOMMUFD_OBJ_VIOMMU);
> > +	if (IS_ERR(viommu)) {
> > +		rc = PTR_ERR(viommu);
> > +		goto out_put_hwpt;
> > +	}
> > +
> > +	viommu->type = cmd->type;
> > +	viommu->ictx = ucmd->ictx;
> > +	viommu->hwpt = hwpt_paging;
> > +	viommu->iommu_dev = idev->dev->iommu->iommu_dev;
> 
> Pedantically this is troublesome because we don't have any lifetime
> control on this pointer. 
> 
> iommu unplug is fairly troubled on real HW, but the selftest does do
> it.
> 
> At least for this series the value isn't used so lets remove it.

I recall one of my local versions had a validation using that, but
not that crucial either. Will drop it.

> I don't have an easy solution in mind though later as surely we will
> need this when we start to create more iommu bound objects. I'm pretty
> sure syzkaller would eventually find such a UAF using the iommufd
> selftest framework.

Would adding a user count in struct iommu_device help?

Thanks
Nicolin

