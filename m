Return-Path: <linux-kselftest+bounces-19085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122D099146D
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 07:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D60B22C15
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 05:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BCC381BA;
	Sat,  5 Oct 2024 05:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WmSb3mfK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCDE231C96;
	Sat,  5 Oct 2024 05:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728105598; cv=fail; b=mwMTxhlRsOOJ/g9uNJCH1lseJ+66954wZ7HwnacJbrIk2TVFSVZ9SuKBpfNDvqB6eKABxNJsN0PcJN/ZYKTpJhNbsMifVcDtJMqkbIzOFOH0xU2LDURvzom9+Hod9kxHNIQO/OdMFv/0e7JBASG4TGBGRkmGZSB/imZzsVPA8v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728105598; c=relaxed/simple;
	bh=8MejqAD1cgaJuYBSi5R9Qkx45foB5oGYxzS0fwP7PYE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhvfPQWecxcFGqEzA2nu8VNZJM1/k5YvVuA0Nrz4wPaQStsN0i+lBUKCI6rsZy3uTK6qT7kvzg8qjVGxQWxVssNp9Aop1m5yhQbWO+n/OYRYE9aTALqeUL2TaO9FI2T+6MI8z/4In87FGJNom9SU5odB4VERzsGKkw54SbEQL+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WmSb3mfK; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4kYUuE/9d42gtjov85hhMU3Bk0MXOJ65uaY/TUYc1FxmlvzdqfIeRzInJhBf4+822b1PKBK0+/+hFftV0DxQ5vM9YCKE00KNi+x/kHf0LcUy9OqzpSxy5x2qroxZYsvFALVqeC/mn5wG2xd5oAUVZ/0XczykBkaLnhpVal0pCfTO79ewyxlAGLtkZFuL5cAo4BLUjdYrCN46m20HL3bn/RK+MJPiPWgc4l1jAsPewRUrNlATiM0m8eIDsY9Vd+hHVCiWU4CikrT45A3k+ERGV6nQQdzDQGVMQe276Oa6fb+gYfUVRtgwRU/dG0ixCG4I/5Zx2ASYftzu0B504B5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d8129+O9M+81Xp2K2eWCNB2YicHw6rcQ0VAu1Kx5jI=;
 b=K6yXJx0ECWotz3lEFWVBaB34i2Bhh2YVpBgnKF3lvfHk6Ib975rFOvC5ZHSiWS19u1YYXChI8k5OuIXs8qsEsE9S+ZVFnWpGtBDefPpJaw+l2Y7M/I9as0qQzlhBC0P/UdoX6NCpUT1xAsXXSoeKWdMFAglfDMby6MwrFJkKwXoLd62jW1Dth+P+0JaTA1oaU6z36AY7SizHqS87lSZcBNULOfsXybxlKy89Hk8NFFpq9ZQG+X/VrnLu2Vt9O4Mx8JxnmQINNlPAt89cd+/sO97OSgXcVNNuUH04VTEmts7PZlC8syoQZQuas0nDw70/MuPd/h6hmK6LiSExxdUwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d8129+O9M+81Xp2K2eWCNB2YicHw6rcQ0VAu1Kx5jI=;
 b=WmSb3mfKjYCUuXiVTBAsfwduRn2ASq2s8VV8bNZehtq9Ie7tUR3luMI4Nu5g0GNwewQq0ctlKF4R4Z4mB7ZiR4worV2zb+W/p6xnknqBxsnNlDckmiBIcvwAclTf1CxOoqEDxpd7fYZLsXFkQqDVDbjsyCs7iE9eSjSZZndce+aDj1S8Fm+yOtjVti1+akheP6/vonFXYR4b2CXAwzankplw8kx0u/r5i5KrQXO4c9nRU2vzCSEUW/oR1jfAZAzOUzF5VE5Y2edzKbpEI6od9rQxiPxMnKXwBPRhilVzfFbo7ppT3OJT3762sARxxnEgX4cOBluUNBypVfF8yOjwkg==
Received: from DS7PR03CA0190.namprd03.prod.outlook.com (2603:10b6:5:3b6::15)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Sat, 5 Oct
 2024 05:19:54 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::d6) by DS7PR03CA0190.outlook.office365.com
 (2603:10b6:5:3b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Sat, 5 Oct 2024 05:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Sat, 5 Oct 2024 05:19:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Oct 2024
 22:19:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Oct 2024
 22:19:45 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 4 Oct 2024 22:19:44 -0700
Date: Fri, 4 Oct 2024 22:19:43 -0700
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
Message-ID: <ZwDMb3F8/cCFhwcQ@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6ccdfb27c7aa5a5bb7e153165cf90114cae4687c.1724776335.git.nicolinc@nvidia.com>
 <20240905161415.GS1358970@nvidia.com>
 <ZtnwG/Kmaf+fZFAv@nvidia.com>
 <20240911231103.GR58321@nvidia.com>
 <ZuJdPHRbMeYFATT7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZuJdPHRbMeYFATT7@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c456b7-0b41-412e-98c0-08dce4fd57af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QWwXvkYtS5Y0G7URwFQxyrUNiYyeqdfpzlGxWqf+KyGiDESarSSoA8VwJeQj?=
 =?us-ascii?Q?tPgmoBvJ+4lGvCRwigQS4kcGQdo0ONuXvvHkRTbw1COG/rDV8gQaHr5OWAhe?=
 =?us-ascii?Q?4s06D59dX4to3JGQ3pxUJXKBJFNSVSdQ7OhvKisIETDvl1fwchgXO2YHJtOQ?=
 =?us-ascii?Q?e2TMoDKYOlNuJHQYhuQsWJAusIr9GMng8/cZ5QhlS6os9ULeaZ2UnJ+dFB6Y?=
 =?us-ascii?Q?L+Ois/xoUM1hXXfn9Pbg12Udo0I5fbxyFATOEvUa0443J+SCvrg02hAntGUW?=
 =?us-ascii?Q?dgyQojmT37C2waTm582XvpqnrkDg+zNSXJUgTdw783bE8dbluMjG7aqQHGYJ?=
 =?us-ascii?Q?B41g/WH2xRw199uRB84Q5aswy4V4tp6W61eFHD6/iFmYjWtJ3Z/IF8Drs+kH?=
 =?us-ascii?Q?BlCxDESLxlAgN4xJHWgAk91z0/a5wvFVEVf6V1IqDB35hjOPLSIah4lw9W5J?=
 =?us-ascii?Q?aGp+vomcq6HJplXkY7M2MZosdsVqG97jCRgOuMOiDpo9334vpvoK9bL5VKKB?=
 =?us-ascii?Q?twUkBPjopUcLDvRK+DEnDTvzqqzD6kInKGQycAiRv9EJTqDVf+/UjtKvOof9?=
 =?us-ascii?Q?xdy71TVPeAWcgWlpyrdvoc+LL0TOCUVKCSZUOUMvqqI3x/WvWGTjT41Yq9oe?=
 =?us-ascii?Q?RlQYsCVauFjYSfBViO7HDD9+JHQ4eFKiOkEL8AGgAfUJFr2n8LhwYaX0HXyc?=
 =?us-ascii?Q?9H26daeXEIhHjZM6SijpQ9jWkQWM7pqPWjnjIIuMp/DPOV313Xh2oBBhgP4y?=
 =?us-ascii?Q?C+qsXmZ6y40Fc3tJBASMA+N5GHcDkVGLRH5vouVYPngYRSaFYWAIUieQ5JwC?=
 =?us-ascii?Q?LnlzGuBJYXJM9SAkjjs+JRVpSyE0JKugpEhfLW83T+6OgMp0iohY9TfaYDxa?=
 =?us-ascii?Q?xoIg6a3omJe7WwiTJ4HmMQ8+CxaAK4ct6jGbfSkoepzEBokZA1GsyThisSAy?=
 =?us-ascii?Q?8qWXmQDIQfCD0Zrg6CP0pMKAZZoRBdesruH87D9bvOrmETDeq3I2MPVwcSze?=
 =?us-ascii?Q?dBTOdBK2eeg9X+ITn5BOXwKFux6Gbz5aU78IfJTwQgQ8QM3ayXHFDySwz0UV?=
 =?us-ascii?Q?VqwTj4FQOs17B4oaNwZvMV1Yu9p8uS3FhLGYJ3WVyvnXFmAi6vYdRB9M/g/A?=
 =?us-ascii?Q?H8Z7jPLStlZLPyDs776nL7cShgUTr/JUDF6cFGZP+0x6ZI8eJdk0z7CZgcsS?=
 =?us-ascii?Q?XE2JUfidCPiTl/sk8xXz6/mR1Ufwln87UWEHn/Mv7s+ilgAHQb+ArAomIQGu?=
 =?us-ascii?Q?d8wxwrBqK+Dy3BYviyFSHSknh/ao18DuuiUc2RvzCcCx2oIaVSeVQjMSAqaH?=
 =?us-ascii?Q?lyGOFyUW7fl5agtpQFL90dkF9pEEolQ61nuJS868cyo8WrTopHFNKANbIbdW?=
 =?us-ascii?Q?CPs3qI8+IB72IEExPrJDAoiEosoQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 05:19:52.7814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c456b7-0b41-412e-98c0-08dce4fd57af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218

On Wed, Sep 11, 2024 at 08:17:22PM -0700, Nicolin Chen wrote:
> On Wed, Sep 11, 2024 at 08:11:03PM -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 05, 2024 at 10:53:31AM -0700, Nicolin Chen wrote:
> > > On Thu, Sep 05, 2024 at 01:14:15PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Aug 27, 2024 at 09:59:47AM -0700, Nicolin Chen wrote:
> > > > > Driver can call the iommufd_viommu_find_device() to find a device pointer
> > > > > using its per-viommu virtual ID. The returned device must be protected by
> > > > > the pair of iommufd_viommu_lock/unlock_vdev_id() function.
> > > > > 
> > > > > Put these three functions into a new viommu_api file, to build it with the
> > > > > IOMMUFD_DRIVER config.
> > > > > 
> > > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > > ---
> > > > >  drivers/iommu/iommufd/Makefile     |  2 +-
> > > > >  drivers/iommu/iommufd/viommu_api.c | 39 ++++++++++++++++++++++++++++++
> > > > >  include/linux/iommufd.h            | 16 ++++++++++++
> > > > >  3 files changed, 56 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 drivers/iommu/iommufd/viommu_api.c
> > > > 
> > > > I still think this is better to just share the struct content with the
> > > > driver, eventually we want to do this anyhow as the driver will
> > > > want to use container_of() techniques to reach its private data.
> > > 
> > > In my mind, exposing everything to the driver is something that
> > > we have to (for driver-managed structures) v.s. we want to...
> > > Even in that case, a driver actually only need to know the size
> > > of the core structure, without touching what's inside(?).
> > > 
> > > I am a bit worried that drivers would abuse the content in the
> > > core-level structure.. Providing a set of API would encourage
> > > them to keep the core structure intact, hopefully..
> > 
> > This is always a tension in the kernel. If the core apis can be nice
> > and tidy then it is a reasonable direction
> > 
> > But here I think we've cross some threshold where the APIs are
> > complex, want to be inlined and really we just want to expose data not
> > APIs to drivers.
> 
> OK. I'll think of a rework. And might need another justification
> for a DEFAULT type of vIOMMU object to fit in.

I tried exposing the struct iommufd_viommu to drivers, and was
able to drop a couple of helpers, except these two:

struct device *vdev_to_dev(struct iommufd_vdevice *vdev)
{
	return vdev ? vdev->idev->dev : NULL;
} // Without it, we need to expose struct iommufd_device.

struct iommu_domain *
iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu)
{
	if (!viommu || !viommu->hwpt)
		return NULL;
	return viommu->hwpt->common.domain;
} // Without it, we need to expose struct iommufd_hwpt_page.

Thanks
Nicolin

