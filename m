Return-Path: <linux-kselftest+bounces-17778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D63A3975FCF
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 05:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A09B22B30
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAC516C6A6;
	Thu, 12 Sep 2024 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZL8hRSRq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD7166F28;
	Thu, 12 Sep 2024 03:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726112421; cv=fail; b=QNnL7DCsGKKvSU1HDBgdjlKX8O+MaCddecAO70+Mwn+6BKCLoQpz+7YZZkb4+AyZhvngW/u1z1QB0ZpqZFcz34VG8fBVUstAtvvrPwim12xmX0HAphZ9drSuAVvbD53wi7NE04l5pbOU/o5WplPpBi4pewaQAT3/BESWGZhrJD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726112421; c=relaxed/simple;
	bh=4mZexQO99vqKwryE43m2KdTl5UEfBJve8Dx/v2KMCd4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgn5cvwVLpugsC6gX79YlFfE0L54QO4t5TkhXDtImfoyfI+Atrfc1jVnzEAX1wA9JPGAXAs/kjSWlO49QgljrNtrSQmzBbdqvp4zaPCjWehYcwS6hIYmUte1BASPvKQW2IYwrBBwO8r3G/JZpsyW+aU/YZmG5WdgIwxBnVTzrB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZL8hRSRq; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoeIXFk2o9TcxYBtWRabpO9RnemkSGZEgX0wyeq76iQd0eEt4+EiE/7Ocx6NsV+AunLtvDOwfBMOS2hq/qWDDCkz6jHOcD5Qib2FMOl/4lV4bcUE6JxPj7mK/zNgZyw5/51oCfHmV+/s8at8rZR5lDelggBZfVHExj9uYP/3beZlqz4CbhxQtQorrj5moOBEkz0sTAIoog7t1+rrLnNWTCdoyd0CtzkV/HytQHUxMfYNCmqFBu8YC4dZlvQHVdoAc9xhBxxkSYlEi0QPxqaSW4rMjWhsBQ7wBAtqFzgveGkyLN/cFS0xkLgoD0EexZFMIr6UVEbftGB7jGCIvhHooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29GdTI0ZLVzaJ+kKMQZvLj5cbs4TENGVdC5WxNaWeVQ=;
 b=OASlOXGT0Hjvh/wfeiC8dEYirTxJf3yfFetw+615zvDhlVeiDhJ+bAXwn33ImkjAHY8G7P3GVNoQ5dJSdKQmVczcFvS7yU47r/x6tYnrHzFs7XUoHVkvJxlTgWV2vnH0XPj9c7G9lqIzYUdyCk510Tujb7NvFoGQ1VfM7qXyKc7wbjBZwBwyQX/pWJEHl/SNTmUexsU4Qr+pZoFDi1lTt5QVsyZJqyYqjNI+aASXCOg87/Lrx0owSYpS2q9SfcCusn9VUKQuqIXTJRwSQtosmQ0wrGq+mur17UnXBlsEfhKy2LpnFQfkTyVGRK/Y6JeUhDmB25IUr19kK7QbMRXBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29GdTI0ZLVzaJ+kKMQZvLj5cbs4TENGVdC5WxNaWeVQ=;
 b=ZL8hRSRqNuyXGx3NxgUB/H7K3lxuIwa/KVdH29ZM35QA567JBukaqB/fW3HlzyU16lNtxOUMk2jo+ShzUX6VZlGE7V5DOte4zAScGLhqkxT4LIEbs/3YmHIiq4/uI6o1NwMdHf9H1Xq/jJ8j0+FGdWOLhin5Mo+ISGTz9CD9x9nJOkQG0IGa9ng6qWmnEsqQSNbbmNco6UzA9Db0AMzuPNkbaoFf+s4A2+dUz9SlO2U8WCmEc5RG7H0EBulwgbK5cY2dMWZaqCM5NJJNgpDDRf4/xvUGPtlaVytAqGtjJCDyxiOHvDIed3KI47O2/NzoDAqnqDa0+QCezblUuVQhmA==
Received: from BN9P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::8)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 03:40:14 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::52) by BN9P220CA0003.outlook.office365.com
 (2603:10b6:408:13e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 03:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 03:40:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 20:40:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 20:40:02 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 20:39:59 -0700
Date: Wed, 11 Sep 2024 20:39:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZuJijT8kcAsw3sn9@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
 <55918c41-65c4-435c-860b-b2a177b0d364@linux.intel.com>
 <ZtVMrXXESy/RfWVi@Asurada-Nvidia>
 <20240904162621.GN3915968@nvidia.com>
 <ZtiY9gE9YDbgJyRN@Asurada-Nvidia>
 <20240904233707.GA1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240904233707.GA1358970@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 44490a42-25d4-4c6e-141e-08dcd2dc9c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sy2LWZarBrohr1OziEEofvl9usuWANLlrosehEkcEpnKfWJsC1oCfsVCQWpU?=
 =?us-ascii?Q?0zymUXBEDSxKk7mfvgXtQOwh/hzcfm33ZW+4okkoGOGKcoyr2/YYmgWIoidW?=
 =?us-ascii?Q?PcQJb5qOp8s15OxXSEqbH1IP7tSENCnMhCAXDedAnmBgVGHRotU1AG8c0FxH?=
 =?us-ascii?Q?mO1q47ClN9o9piA8FBnq51eb1JEXiL/ZEChClCS7jFAQw1DLrMSJLmoTDom1?=
 =?us-ascii?Q?h/6toyrVHJyhW8ZSyQ6pWtz7o8aQIC81HDn6+ht1NFcamy5Ie0cTPXoglzM7?=
 =?us-ascii?Q?7L2RWtl/FR7qD9ivBwkAvAXhUgltscz3maYU7f9Ki39GwEh+oFIVZJ+MOZ/z?=
 =?us-ascii?Q?pZjIGrryPvYXlt8T/crmo/G3/0pBZOMlpu0RxeGbvCI7BAwwFlDqy81F2m/r?=
 =?us-ascii?Q?kWRg2gqKCKN/rSwJPoyAGioT2LK0QsL2RqjKv1iv35NdtgrLjnNnlSLi3eGK?=
 =?us-ascii?Q?BInzUvdkfmPPHk1xp9bGOFvIzJt2lfZ4A/4wq9rsY3y5fMGAvnk/Te6nAVQ0?=
 =?us-ascii?Q?bMJXRN4w1Z17n7/tu/FZWjyKTQB+KKlYOdRJlqFMrOJxfa7zl/iwJUFmUUME?=
 =?us-ascii?Q?wVhDJyasX1TgprTfUShsT61ZTZ3q3USAE5PDDW/PGrHqiTA31NXXlgOYc554?=
 =?us-ascii?Q?/ok/4fESyprmBiI2+M3lzS1nBJ4bhD39FyilW+lYYpOhwyXqr810MMcygZtM?=
 =?us-ascii?Q?5c1nm+viKCgmUeweKt/X1/hAPo8ZL96yjNMwFywwSjP1b8wCQMrDOsgiSCFt?=
 =?us-ascii?Q?nxVstjqtCnKZuZpACN4FAn7Y6kK4f2bWn2xtVW8N8DP/1Nj0vIgB27b8bTtH?=
 =?us-ascii?Q?OPlxoOu8mVK7vme7k7R2w/9NTXJsynA1701Rm//8Jz7gI5+SH+WnieMLdDmV?=
 =?us-ascii?Q?h+nqx8G/BLYiZLAePwV0bGUL/H7vG+yvBvv8+6Juju3x5+qU+UVezmVQCNYi?=
 =?us-ascii?Q?lhmLOosYlOO3+qRxPHIwGGzeClyVIKLghTOgBrVjjPX60pDhOcxeetQnjpMg?=
 =?us-ascii?Q?o4CZ2+bhBvSmWs5OMMGD8BRl9KRNQFtCzD5+GRkherfwqL0odXjC/KXSMjlx?=
 =?us-ascii?Q?hdB02X9hzrdYrFFqenGPipxQ+99oGgAQAnUf2HCYwji2xKc5PEwscmbSf8kA?=
 =?us-ascii?Q?mkKRA9Ujy+tqLRisbQ3doFuB9H4TFcc5QLCHwu5OrOpzwQCOduQ381X8VSiS?=
 =?us-ascii?Q?/+hP64amk4D5vvnBxncEBBkkNLKWNB+2E13lPe0d6BlQD6P/J7unZFU2gLXr?=
 =?us-ascii?Q?Hfir4egGdkaBYCHl/GAvgaPofY4c+59vxwkIp68F4hdvaiGLNejGD6HwYtvU?=
 =?us-ascii?Q?disqWTHn3+hSdnWMbGP1jYx+YUBej2WYDQaCmKzW660hv9jaaLKVHAl3HIKj?=
 =?us-ascii?Q?ghus/1Sb+b87z89RndokmSB89fur3XhsoxieeRSP6TFbgYTGAjRL3bs6bWCx?=
 =?us-ascii?Q?OlTQU7+5gjUKHt0nXCexXPNguPBvEeXk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 03:40:13.2756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44490a42-25d4-4c6e-141e-08dcd2dc9c2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918

On Wed, Sep 04, 2024 at 08:37:07PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 04, 2024 at 10:29:26AM -0700, Nicolin Chen wrote:
> > On Wed, Sep 04, 2024 at 01:26:21PM -0300, Jason Gunthorpe wrote:
> > > On Sun, Sep 01, 2024 at 10:27:09PM -0700, Nicolin Chen wrote:
> > > > On Sun, Sep 01, 2024 at 10:39:17AM +0800, Baolu Lu wrote:
> > > > > On 2024/8/28 0:59, Nicolin Chen wrote:
> > > > > > +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > > > > > +{
> > > > > > +     struct iommu_viommu_alloc *cmd = ucmd->cmd;
> > > > > > +     struct iommufd_hwpt_paging *hwpt_paging;
> > > > > > +     struct iommufd_viommu *viommu;
> > > > > > +     struct iommufd_device *idev;
> > > > > > +     int rc;
> > > > > > +
> > > > > > +     if (cmd->flags)
> > > > > > +             return -EOPNOTSUPP;
> > > > > > +
> > > > > > +     idev = iommufd_get_device(ucmd, cmd->dev_id);
> > > > > 
> > > > > Why does a device reference count is needed here? When is this reference
> > > > > count released after the VIOMMU is allocated?
> > > > 
> > > > Hmm, it was used to get dev->iommu->iommu_dev to pin the VIOMMU to
> > > > a physical IOMMU instance (in v1). Jason suggested to remove that,
> > > > yet I didn't realize that this idev is now completely useless.
> > > > 
> > > > With that being said, a parent HWPT could be shared across VIOMUs
> > > > allocated for the same VM. So, I think we do need a dev pointer to
> > > > know which physical instance the VIOMMU allocates for, especially
> > > > for a driver-managed VIOMMU.
> > > 
> > > Eventually you need a way to pin the physical iommu, without pinning
> > > any idevs. Not sure how best to do that
> > 
> > Just trying to clarify "without pinning any idevs", does it mean
> > we shouldn't pass in an idev_id to get dev->iommu->iommu_dev?
> 
> From userspace we have no choice but to use an idev_id to locate the
> physical iommu
> 
> But since we want to support hotplug it is rather problematic if that
> idev is permanently locked down.
> 
> > Otherwise, iommu_probe_device_lock and iommu_device_lock in the
> > iommu.c are good enough to lock dev->iommu and iommu->list. And
> > I think we just need an iommu helper refcounting the dev_iommu
> > (or iommu_device) as we previously discussed.
> 
> If you have a ref on an idev then the iommu_dev has to be stable, so
> you can just incr some refcount and then drop the idev stuff.

Looks like a refcount could only WARN on an unbalanced iommu_dev in
iommu_device_unregister() and iommu_device_unregister_bus(), either
of which returns void so no way of doing a retry. And their callers
would also likely free the entire memory of the driver-level struct
where iommu_dev usually locates.. I feel it gets less meaningful to
add the refcount if the lifecycle cannot be guaranteed.

You mentioned that actually only the iommufd selftest might hit such
a corner case, so perhaps we should do something in the selftest code
v.s. the iommu core. What do you think?

Thanks
Nicolin

