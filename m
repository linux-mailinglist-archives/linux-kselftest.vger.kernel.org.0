Return-Path: <linux-kselftest+bounces-17310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C9E96E161
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 19:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8051F24E16
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF6315350B;
	Thu,  5 Sep 2024 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K8PL37Hg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961EF184E;
	Thu,  5 Sep 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558854; cv=fail; b=uO7QGjJfP3RH40e+Ab0mBz6vtjtPxaNcF37A6uc+OJN8P2M42fUVjTBpFag7UC/ipKg+YYbo2AoxS1Ag4rHY6f9wQ43eQm95kclYqGhSxkw0JIKdXhAfOtoAF/jxvGdseDh5aCTpbzzIIqDSyZQp8DW/KyLvK8p43OWjr89THAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558854; c=relaxed/simple;
	bh=SAxFuJV0tRiDMGznsDfS+G/kCBHtWsESuHTUqrCrSCk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvdHD38TScVIl5uTWLFRDJk3Qfzz78j4Y5RBbnCZRmXEokmTAtFKjUPp/8n+//YmScG1Wr+gX3QlI14kXvumNOY5kP/Ql2Gw95fsiglzPeDqUJtA944NZYmgTQcQueDkD4Y/7+Sf3vPH9QOPK79GgGjwLPj2EY8g98m0lXeDEa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K8PL37Hg; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bM6S0qc0URtaJqObc45JetO5RfTIY0B2lNRi6aXc0z2hOLqc7PrOKpgwbm+B2h+7ypzfkb3nM6/480Sq6xUByIp4h7r69brhQaNsR65cSvXzz9/yEXr7wparxYlBjJrcLye52NVTwXCfdgOIDKp4ReXI1058DUHkDK+/9FQgDWQq6+cWlPZugoqIycKsJ8wDz9l3GdgdiiPum96A9kx9qmvhdCtWLOzDGl8qFX+QPQaJIV3qIMYkjAtysdKkI5BXkSPhYOO1OcfIozQ+3P+OASTBFA8To7iqI9nMT3tKAA23ilHlMH1Lj11K+cb1xwHSh4zT/Bd9LHfiRtxTwD6hcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5ARga6JXdPQRLyhWoajLA2IzsFfPt0BkzwlKA3PnC0=;
 b=K+AC2hVdsfc1zEP5mwj0RcFPu/n5XcavUbPExN+qpQD/PeT/tzGFEXrR/XOpnj05RLt/DA+yyLwbKzUVk4wb5E8iNTwJwmXW98uk6iKeklgv432JIXCaZuKDLCyVW/vNDb/EbQM87RojRHacVlb3mHZzVI00ZxnxHq1kN9uose3QQwr0Uq0FNrk7XsebfgEWs3vQQ+4aIokwJ3oFlcleLVXAv6CL5/Yua4b7PVT581wjAHpG0tvazhB61PagK2JmEUe/sBrccWWc0JquR9WL/htMwFxCy9RvISObPm/Z9zWUbXJ5qHQYxJICXB7kRc/K8fXDhJkGVkq0KNiOnZNTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5ARga6JXdPQRLyhWoajLA2IzsFfPt0BkzwlKA3PnC0=;
 b=K8PL37HgZg3XdJUuWMErzimOcuddJsf+sV9fp8d0jQhMlku9I6E2ckDE12b++tuCUF1mcsrVvd0FC/LaxJKkcvo3eAsObAgd59zyYcj0PrglRG54N3VRkoSX+Wf8VU6r+0GfO2L/wwDek+g6hVrLRTKnR4c32HTdcTawzomBg8uKSuqONrSyfl5AeH+9DcHWTfrXrPASL9bjCqiR5H6OTfDaWdoa4rsdnwxpYlkiAa0xNccGb+8ZNtTt0OR71ytn+xCzdzff7F7yKHnbnBw3Iz2jb+QsBxiv+pGnxbpiqgwE7CQP0sqqUSt0gl/RvB7eBijEg6DeskXILR+Sk1vguw==
Received: from CH0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:610:b1::21)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 17:54:08 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::95) by CH0PR13CA0016.outlook.office365.com
 (2603:10b6:610:b1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Thu, 5 Sep 2024 17:54:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 17:54:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 10:53:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Sep 2024 10:53:53 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 10:53:37 -0700
Date: Thu, 5 Sep 2024 10:53:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 10/19] iommufd/viommu: Add vdev_id helpers for IOMMU
 drivers
Message-ID: <ZtnwG/Kmaf+fZFAv@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6ccdfb27c7aa5a5bb7e153165cf90114cae4687c.1724776335.git.nicolinc@nvidia.com>
 <20240905161415.GS1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905161415.GS1358970@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: dbcc66d1-b66b-4b45-1d9d-08dccdd3bd8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3orwDgkpaEfMmszrdk6AERWpaNHVuIXcssW+U5KRz0dTRE3mTLNU1rk99uD/?=
 =?us-ascii?Q?6sw6WVZlFEaWl782A4CDHWzKTZm5xuirZ6wBjYiBBUyUITyuIH6YRPgcsSVr?=
 =?us-ascii?Q?Ic8MzdpoMdJjI7PuFNarobULm3KWZE5vGSA+1oLixMRRSWTaKjsRZKl15deO?=
 =?us-ascii?Q?xyzpmwUUfOI5Sqlnpxn92JI05ccEQDiUF3zmLo2rTIlHmltxWslRI4H+JA0V?=
 =?us-ascii?Q?RWv5yn50NHVvXwBTd7iGIrFGpc3RhSeRZTvziWwJ4DkJ3lGpZTtmbuFfIQHm?=
 =?us-ascii?Q?Q4j+jYrAHIpEnp0K7Wz3sp34Y8Eg0EJnP9/fGgMUw7ZXDIwZpdShDiGryArO?=
 =?us-ascii?Q?9qx4ixlrv5zF/METGvr/gxMOkyeH+Qc1haVPrmjKroOU0h8/KTMKj1TurA18?=
 =?us-ascii?Q?aj2UPE7l1BzhEkL7acnxah2X9sCUzN41f+kRPqoe69/RucrZZuuYTPRINoqG?=
 =?us-ascii?Q?7bCNNgOpR5gyfs2YolawFRYDyXjlscdksCJZQsgKqVO02exQbUpQsImduGBE?=
 =?us-ascii?Q?xEoCllzW7WW6JGZ615k2HZ/9EpmfRW1QBm0iTKUhoC7RBR4VRQrbbfM3l0nV?=
 =?us-ascii?Q?fWZe0o8p2foM2qhUStQVs1mvnBoyuhOA2fg87TNBdfvwM1DpW6DdVBIgNyXT?=
 =?us-ascii?Q?7qsl7otZ1ywaf3Bl3aAIoRo78orKhZcv+OmZadkdgApffQ9qXq2Pd/ZGbkXf?=
 =?us-ascii?Q?nh2hSIw7w47TmyW6vyD+y8Az6L6JTUrIiwgjXQKPhPU9fg6TaOGPeTs1JQli?=
 =?us-ascii?Q?jG0vg5J3Slx0esWmHx9GF7UC5WDwax7LK7CVFC0NaNWRgTQsYscNXUhq/zQU?=
 =?us-ascii?Q?uem4pVNB2H/D8pLr3CmvykFNz4exP38fi+4v74+5PCp22PIuspMz12kBnvAO?=
 =?us-ascii?Q?Kh8TKoFkjLiKPmv+FqLHy5MXfy5xvIM/J4ZzwFFuiTHC0HyiPWdZrsMjJg5x?=
 =?us-ascii?Q?oaaATc2bcyB9xS/7l6u/dRhJ2p+ICqJttrWJwEi91cDLundkX9xmyVx/0fpL?=
 =?us-ascii?Q?bA2sFTDiCMckwwsRnQU2xgeKGyMGHLgDbplS7cmfHGqPp3JFehUXdxWZU+x5?=
 =?us-ascii?Q?MWIqtlRtpQsrIHhxfhYB8lZh1srk6lfXA9mEpVxh5yTFmLIlmtSBmDmfUxdh?=
 =?us-ascii?Q?iGZC7/3LwLDrx8E7V16yhfdbRnC5/n1HXV4ZdFQpMsavDlG8SzXTYvb201d2?=
 =?us-ascii?Q?bpfUsgA8XquBZTaVXrkPK1rLhXVDDSR1mGjIw8YCfPFPPPzlgdxTeR+Bc/xb?=
 =?us-ascii?Q?vmwf9WxKqwgY0fpEw39kYX+JL790nOWklFeKsLVcZarlP0ng+VX9flS4Cs/x?=
 =?us-ascii?Q?Lb1fgSttN6dWjsvxOWJCsKGGLpvWGWP1Db4bliGNgV6dvpEQrqqKaaGIdf//?=
 =?us-ascii?Q?0UKk4tOdjnnMeKBlZ152thcMnMgTKig8x0QozGWxdfjNE6lwl+N2k32I8fr3?=
 =?us-ascii?Q?o23OtNBkOL+3H0oeDrF39Tu1wD0gJh91?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 17:54:08.0297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcc66d1-b66b-4b45-1d9d-08dccdd3bd8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

On Thu, Sep 05, 2024 at 01:14:15PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2024 at 09:59:47AM -0700, Nicolin Chen wrote:
> > Driver can call the iommufd_viommu_find_device() to find a device pointer
> > using its per-viommu virtual ID. The returned device must be protected by
> > the pair of iommufd_viommu_lock/unlock_vdev_id() function.
> > 
> > Put these three functions into a new viommu_api file, to build it with the
> > IOMMUFD_DRIVER config.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/Makefile     |  2 +-
> >  drivers/iommu/iommufd/viommu_api.c | 39 ++++++++++++++++++++++++++++++
> >  include/linux/iommufd.h            | 16 ++++++++++++
> >  3 files changed, 56 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/iommu/iommufd/viommu_api.c
> 
> I still think this is better to just share the struct content with the
> driver, eventually we want to do this anyhow as the driver will
> want to use container_of() techniques to reach its private data.

In my mind, exposing everything to the driver is something that
we have to (for driver-managed structures) v.s. we want to...
Even in that case, a driver actually only need to know the size
of the core structure, without touching what's inside(?).

I am a bit worried that drivers would abuse the content in the
core-level structure.. Providing a set of API would encourage
them to keep the core structure intact, hopefully..

> > +/*
> > + * Find a device attached to an VIOMMU object using a virtual device ID that was
> > + * set via an IOMMUFD_CMD_VIOMMU_SET_VDEV_ID. Callers of this function must call
> > + * iommufd_viommu_lock_vdev_id() prior and iommufd_viommu_unlock_vdev_id() after
> > + *
> > + * Return device or NULL.
> > + */
> > +struct device *iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id)
> > +{
> > +	struct iommufd_vdev_id *vdev_id;
> > +
> > +	lockdep_assert_held(&viommu->vdev_ids_rwsem);
> > +
> > +	xa_lock(&viommu->vdev_ids);
> > +	vdev_id = xa_load(&viommu->vdev_ids, (unsigned long)id);
> > +	xa_unlock(&viommu->vdev_ids);
> 
> No need for this lock, xa_load is rcu safe against concurrent writer

I see iommufd's device.c and main.c grab xa_lock before xa_load?

Thanks
Nicolin

