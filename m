Return-Path: <linux-kselftest+bounces-21587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB589BFC45
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 03:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DF31F238C7
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA13817548;
	Thu,  7 Nov 2024 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hyAIBR3b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3221917543;
	Thu,  7 Nov 2024 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945050; cv=fail; b=RbS9I1eIUxhZCWBO0SES3e9FEeQsrbNCIaUgFCM+W1/cpSR4ZPXWO7fpKXfto8e87+9dgnEm6QPl+ZisZgXFGBv5EuL9Pzn0c4yuXwYIaTT1nYtdQQMoosiPJ46VZcDEEfrNKuYuGLDqzj4TSDg9qE+qyq6JC9pvG16G31gGKkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945050; c=relaxed/simple;
	bh=Xhiaz+LpQKUhoWfAqFTEXDXz+kW3EG1tqV/BBwXvnt8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUupyhUW2UtmT8l07W087IZdQwVLrbcasTSg1BpvUBpjSP3FpH8SHDK+yIdOhZtAKjwzGjycj6WOLbAk9jm+4CuKlaHjt8bv0HzrM+9Fz7C0QGIOSuvqrKGFe4c/CTn4bX/QdmluLBhrN/Dnk/3LN5yje3knbxRVpGLQ3FIMl9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hyAIBR3b; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtjPUnVrNUiiJl3y1dMdiCT5Zfem62gaLc8xDWDJzmgYsV+GYKO0gXMzC+xS+8MiDYupW8VZMgdRscJrdTjRQR77hT7OwTcth0G44aYsogz0y5m9tsUVy4Gz0oSrUp+Y9RF8sn6onfoxw4BG0afq8COwtGgJskyVyWnREZID1Yt8CkKLQcA3aLiqYDD8G3xv1VKSukYe+RASpqLimDQ6Sw+6bxnQ9GMaipoW9MUONc+v+04tvJ8I5asRZ5/7nC0TzSGrQkQeXU0fHpwOMDfjZQRmzWWbYwJFTfjj1wCVWS6ApsbFZQB6yRdzwilzdkaG4l46714BdwnKS13yZDuQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldrTXPp60r4e5hy1bxsuE0mX7WgDFfm0ch2UWXjVKZY=;
 b=nClEPHkjRQMU6oE6PDT855FwY368BGaxDQEtLi9k0hXdnSLY/yZHlYGhgsKbGJrIDuTW/NqxAWa9/bxnnfDeZJmWeTADKrUoqNxSFhYr1jpVrBb4H7Gwwn3plNbqEvL1VjdycYUAPohin0TYYWU7Kme7v70jV/k5tx9y4j8hUdusyBLqGtqsR5osUeV3X6gYq4dWI18RAah/a+/+GzXB0jpnzM5QJZ445bUycf4oM5QndUivHwq0BuPniWcxk9pfCP8PWDnLiJqs9s2WeWcY7VIQEaz9S86utaaoi+Pq7hgg8w7Y3XbRcsrXthhfNwi0ClVA68QGDgg7Mez4BjIbOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldrTXPp60r4e5hy1bxsuE0mX7WgDFfm0ch2UWXjVKZY=;
 b=hyAIBR3bguA/NOSu4+3GIM8G+Fj9IC25HFdUetnLBmFzByJLlypjTiws9l3sU1nqilPMWbquAD6CClfc4qP/hpjw3V8jGIevLGPDK/r/oMl95M251s+h/YmBhtBNs+YMrjENxhPAUBW6XaetMbOoXC0aMF00X63mBLFTKAzqkWkuMcuBAaiYHDs4F/NF1vKUcvB8Ff4SD8hDg1FAl9mKfORqWMuVozEIrADWI8WxxpEpHk5z8bkz5yKtKEf5Wv5dxyt4KirVf22V8z/RKuRyhQKxpJmAkwDSZ1JEWhP7R7p5jYfLs7jXQq0Fd5yURNW/7TyijhWrEOrCB3HqKI6HrA==
Received: from SA1P222CA0055.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::7)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 02:04:06 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::38) by SA1P222CA0055.outlook.office365.com
 (2603:10b6:806:2c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Thu, 7 Nov 2024 02:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 02:04:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Nov 2024
 18:03:54 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Nov 2024
 18:03:53 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 6 Nov 2024 18:03:52 -0800
Date: Wed, 6 Nov 2024 18:03:50 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v6 05/13] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZywgBswnOahnFATB@Asurada-Nvidia>
References: <cover.1730313237.git.nicolinc@nvidia.com>
 <5d2efe229821f5db7a832d9d6be84217289ac3f4.1730313237.git.nicolinc@nvidia.com>
 <40c1587f-a6af-4851-8632-cb02adece66b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <40c1587f-a6af-4851-8632-cb02adece66b@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f458d30-a3fc-45fe-8bcb-08dcfed075f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GSxZi/ylwCc0uYVqM/eObdFyuom8SibsM9pHJFQbwJB1fDDNXxGNdy8w/ZCp?=
 =?us-ascii?Q?m1h4LXwA1ByoDFqHsM+VHhFOGr+zopSjdnDBSkbauxOlcis0Rqrjd5PtCQ8c?=
 =?us-ascii?Q?BMpVf6ug134CEkvdoy+T/igWrcDL2JhDlfvX6dc0rVhzoOrMhgZgqYHA9Kvh?=
 =?us-ascii?Q?mRqeTCHRCp5YmnWBJXjFI5Jc5/GvFEiU/LoTCu9mzMyeYhkl3fab/CzRJrMl?=
 =?us-ascii?Q?mGC35A8kyeu6eg+ySC4mVS3Dd7qDUtnhB/kjb3Kgb+JcVcxZwnEaTbDlbN8q?=
 =?us-ascii?Q?3dL9Ph2Ex06HuAsorcrKX+wuIpouQ9JunGoEbqJc7GSa3r+4brARCXmOxNPb?=
 =?us-ascii?Q?NO6T6YzI66YdGFEtE+3CDq1UJSyZpe5FBwXlGRIGfMSEXoL+64HL0e3C/zZy?=
 =?us-ascii?Q?iNk0LL8T3W2pHvalR2RDIfz142AN8QoYravQb/QBmRtQx31zcuxlIqj9URg5?=
 =?us-ascii?Q?Vym1k8pBofo1EgfWz9tcnoqa1FiY2yYYiew5yAiwiLJc9iwvD8F9Xf91YZpj?=
 =?us-ascii?Q?9Yp+vTl8pkggOXNIMTyxqEjMS5imnmGKyEGnrKXh2P3U3AfTPu8/T5G50ZQb?=
 =?us-ascii?Q?lCXBe3o2E/nc3GN0Coi8y6JIpSUzpa+erKQUWS9+UcOmxdboNllr+dyyfMCp?=
 =?us-ascii?Q?03uh3l/L7285GV5vt0vbydukyeqsYQ5SHPFWiJjd6KrgMGVgMDNNJve7YEFh?=
 =?us-ascii?Q?z5pJak4Uk/idpzIBRVyOnbksz1xyH4i+9S1WRq5Npi6f380opN+FGkKJFas8?=
 =?us-ascii?Q?gNVClzyqMNJz14Ldx12xrxA2af7fAN6ePUym3ekwZ+Fk1VDxRUH8UPD6qQXq?=
 =?us-ascii?Q?cfj5pfJm7xtvhrqvahuCoaOQrP4mQ2y5kO1YN8Xyf+fMWP0yToYfu2P4eKMr?=
 =?us-ascii?Q?jBwLp4IwWlF+IRgzZSbQJKI9Wy/sAFJ/BKr9wl9FcQooRBx1Fe3qSCkaVmKA?=
 =?us-ascii?Q?gohgX4ccBKZUvVTGOdKTEDV3N0Vfd9OWDgtVPU02RSqDndxDhzQEYKjuObP3?=
 =?us-ascii?Q?rN7qrQUePM6dmvf33H+1PObRHFvEVHgwiKOfKiynKUBQPSd7HxXFiSzKOk1e?=
 =?us-ascii?Q?wKvMnd4q3hVoPeJm+04Jcv1h+GhR/oWdYhnSJ81a13aQJS+rg8HU5hu/huzk?=
 =?us-ascii?Q?8RcYDFCi8eRn4RsmNb7FgUjk1NZTAi67EQeyyRL/YFiJs8Nb6skax2h16ZCG?=
 =?us-ascii?Q?9Ib2A/Cvl3cnEElYOuIp9+3n45hM9dMpmzc4mx3JZXu+KcNXrvi8V5QUgOhp?=
 =?us-ascii?Q?rnORh3nLkgzULsHKm6kUlEC9P4H1HE94bTIwIHdCPBdkmzv0gdXBSAbMnk3g?=
 =?us-ascii?Q?n5HXefMSCd+Q09KnOMlBJ99Lj18ugaCa+0Seleu0a2ONSCjijguoOySaK6Wb?=
 =?us-ascii?Q?DGGVs4lokyjh7stEF9dgCv8c5fd56sAD0RuretrfqQSDFV3Meg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 02:04:06.3818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f458d30-a3fc-45fe-8bcb-08dcfed075f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179

On Thu, Nov 07, 2024 at 12:37:59PM +1100, Alexey Kardashevskiy wrote:
> On 31/10/24 08:34, Nicolin Chen wrote:
> > +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > +{
> > +     struct iommu_viommu_alloc *cmd = ucmd->cmd;
> > +     struct iommufd_hwpt_paging *hwpt_paging;
> > +     struct iommufd_viommu *viommu;
> > +     struct iommufd_device *idev;
> > +     const struct iommu_ops *ops;
> > +     int rc;
> > +
> > +     if (cmd->flags || cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT)
> > +             return -EOPNOTSUPP;
> > +
> > +     idev = iommufd_get_device(ucmd, cmd->dev_id);
> > +     if (IS_ERR(idev))
> > +             return PTR_ERR(idev);
> > +
> > +     ops = dev_iommu_ops(idev->dev);
> > +     if (!ops->viommu_alloc) {
> > +             rc = -EOPNOTSUPP;
> > +             goto out_put_idev;
> > +     }
> > +
> > +     hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> > +     if (IS_ERR(hwpt_paging)) {
> > +             rc = PTR_ERR(hwpt_paging);
> > +             goto out_put_idev;
> > +     }
> > +
> > +     if (!hwpt_paging->nest_parent) {
> 
> 
> I am trying to use this for my so-called viommu which does not have this
> so this fails. My viommu is only visible to the VM via paravirt
> interface to populate sDTE (secure device table) so no viommu device in
> the guest or nested paging, nothing like this just yet.
> 
> Is there a writeup somewhere about possible uses of this
> IOMMU_HWPT_ALLOC_NEST_PARENT? I'd think one pass through device equals 1
> IOAS, 1 HWPT, 1 domain, 1 viommu, even with guest visible vIOMMU but it
> is not the case, is it?

So far, the vIOMMU is exclusively designed for nesting, with the
only use case of ARM SMMUv3. So, a nesting parent HWPT/domain is
a must. So long as your use case is a good fit, we can drop this
when adding support for your case, assuming there would be some
new iommufd patches.

For nesting, there will be at least two HWPTs (i.e. two domains)
for 2 stages. And stage-2 HWPT/domain is the nesting parent one.

> btw is there a way to get a snapshot of all current objects in iommufd?
> They all use "dev_id" and not file descriptors so cannot look at
> /proc/><pid>/fd, and there is nothing in debugfs either.

I am not aware of anything like that. How would you like to use
it if there was one?

> For my current hack, I can pass IOMMU_HWPT_ALLOC_NEST_PARENT to QEMU's
> iommufd_backend_alloc_hwpt() but it is... meh. Thanks,
 
Again, assuming you have some other iommufd patches, I think you
could have a small patch dropping this check -- we might need an
additional flag or another HWPT type, but we can discuss later.

Thanks
Nicolin

