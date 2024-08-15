Return-Path: <linux-kselftest+bounces-15446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0520953B1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 21:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17B81C24694
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 19:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE3782876;
	Thu, 15 Aug 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MHA0wBSq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A757CA7;
	Thu, 15 Aug 2024 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751598; cv=fail; b=gFbYKPz/TGHvWs2Pj6x9Fq14oUz4cADTSd1OYqi1Cza9XbK6aQaLtN4hqxovQQdOKRiCGirbhl+32LCcV/p27UeNcoyoWIkt7WOmuPZCF6usG8s4m1GGFJ62ol62Zuw/mpo6m0ZwxQkjFjXUDdJrdZo4zLBJuIKsD5T+TjOa+r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751598; c=relaxed/simple;
	bh=BE2uGLxG705Gk2dYBhqQJEjMKpNbGRZh6Ke59Gpeb5Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYMljr5yV3DCTcePS3Ly/Fnvt63W69GQsBMbWX51Zj3RQfd5CvmzZFEp2Dq5cNJKOQUK1dfyopEmS0Gx0h9Ux+SZ87HubP5M3XFXcfaY3rwMqfR43WMuaaq7tNsaPIK/PhThH+H0fzdSubAVh738XMd22TWRuMa7VDhHrvys4/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MHA0wBSq; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dx0aR4F0HVCGZvCgLrzGisFZvCJO1UkYGOIQTin64aX413XxeyXjNmOe3x7ZvSeIyukuGJR4Oeb1imi9Fawkdfo95LiIAawHIf1gtvdyUYkPgBefP+HQ/g/kSO3T59VzTYe+DXaD8zEM4PW+T1qrMAXlGf401SHUpqSabrg5zTGG5wYeeBqDL2DIZFrPXYlnraEZW6vYrJ5Z18x+2h4kwdIfbFvwuOdBlFI1mkJyPz4MfOZOKFzZ+AeGv1J5LQScYAJOqpnE3wj6/fDB/VmM4WuXYWWrKuCxqatUyFTH4pO9RuNEe9LH83DPjIsQgLWM1GVh8rlxp0lFs2RhU8z86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSlj4B9V7CXp7a3yeu+bc+Drt/hj2jA9ioL2qIyHoDg=;
 b=Xni7wj1TZfHMA0FI+LpIjvYq+VwCwnAOlyb7gRQcNstndwRJ7rHAiVjgwOAzYwgn+KyD8c7/mwF3muTOdrhAKmp9O4FEq+CKhOTThbiEfR4JIqB548q4B12k/bUY2UWqJyF1g0EWJ2zOwbXZMu0QM0QxLkV/+MAgjhbhoCHd+syQTkg0PnEs9YNq9qcCTEMYE6yYWKI1AsLIYQWXL/4xsx+xavwDF1YQUX03cnROsNhSgzCBwdv8fjzRKW8trdrsddt0hVnsSyQPUuqsIG3BwP6byQZGG6Udt9T0pVY8RSbLNUG5msWWH/du8qk2fo2qcNzirCi/HcfVB0XsaE+iVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSlj4B9V7CXp7a3yeu+bc+Drt/hj2jA9ioL2qIyHoDg=;
 b=MHA0wBSqHMyt0lzB5aKMh5xy2/KfMXE2QazqOp4wjO61zFfQ2ur6dYalcL6Bn0eRHimbb2cOW4Z7SArUgbns81AlY7EEJzozu5pPsGHtOPJIrik+esb/fDm5xMUSOrZdI+kTY9cMlWOcko0MKfwrWadUypjEyRPqAPOCmbUQuyxnhl6OGtsuOmZwJSqk+04uRdrU1CCe8rFeU9epNwpfwrsx0YHUCsRlBZKQ4Dfqix/W6CYFxHiDto7ytUm2JcELbP7Oaxl65KktTYx3umo8nW8UAUunv9c4Ekz99Xahd1oZeD1E57Sprc98uVWz1y7BcHiD809MkTTfNOeOjm3I7A==
Received: from SJ0PR05CA0113.namprd05.prod.outlook.com (2603:10b6:a03:334::28)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 19:53:13 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::a2) by SJ0PR05CA0113.outlook.office365.com
 (2603:10b6:a03:334::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10 via Frontend
 Transport; Thu, 15 Aug 2024 19:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 19:53:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 12:53:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 Aug 2024 12:53:06 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 12:53:05 -0700
Date: Thu, 15 Aug 2024 12:53:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 05/16] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <Zr5coJScB7AM76Wi@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
 <20240815190848.GP2032816@nvidia.com>
 <Zr5bENKAYJTvwEBJ@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zr5bENKAYJTvwEBJ@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 5027e89b-c9de-48e2-d889-08dcbd63e5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LqOIVKWitqqgb7qppLiuv2j87bzIDxkmwhCiqTCKO/7bXCWOkcTxLezlCnHX?=
 =?us-ascii?Q?sU5/+RqippxP6a30bWwIgZBVx494cXD7u3zfwrlRatjS6XQVoCEde0B5omRi?=
 =?us-ascii?Q?2BIMxSQn39P5gpFHxlW5dxz4MTEFdMCBWWP1M1fusa607CtBp2QLNjO9I1QE?=
 =?us-ascii?Q?YE8Yb6D+bDwBg9rMWinTb4+q0CChhnebyrrreJdJfR1dq1M1XpifhxOxFZbM?=
 =?us-ascii?Q?N0Pi+9QEV/CIaFchCMd4wl13dCt6vDhWlvgje6w1xfXyBzPICIvG9haon1ae?=
 =?us-ascii?Q?D608XaanIBf/D2h3z2pr6No+9hy9uRS1DXDQK8bmN2qzM/EbgDfGmWaLynGx?=
 =?us-ascii?Q?8ByWzheD0d27Zg3HAsr0gadHouekj5I/HoAaejx0fMeyPhY/NLk7qdplH7/e?=
 =?us-ascii?Q?Jm73w+Q9SqX333tkHKafVpIlQFA1P1N3eLRG/oUznhAm0yoOvpwMKDBRtGPg?=
 =?us-ascii?Q?uFasaIgdyZE12+KPTWeC2bSNy1S027Qz4p/+PkDHY6ojHYZKOypVe73duAXh?=
 =?us-ascii?Q?pPKg4VEQmOkRpIslNa3b0S9bCqfoyXH3fwO4sdzZX8+X4SkZtHb1GdAQm3kE?=
 =?us-ascii?Q?rbGUqPMCD1Fy4iu5rjsb1Cu4qrGeWi/pTn1lDagAhpq6zvhEVIwco+Jbw1x2?=
 =?us-ascii?Q?qTo15aujaWyu87yZn/OsKn2lEEXCGRTnqLSgp8xMHZZl6tTtkmv+rhMPvxga?=
 =?us-ascii?Q?5Ew2ntmH9vOb7THrDNBLAH1TLaW1bEJyRRiy3J6DR3KkYm2knDB4tRvItsu0?=
 =?us-ascii?Q?Bfrvi3XP1K7LznMvaMUZGAH83OeZgYxMqj6L7oKUEoMcFUS0aCL/JLgmlyu1?=
 =?us-ascii?Q?BsWhba7abeAOS9/HhTDO7bVdsM0kEtLnqzZTHprzXdJA8MgO2zoadoaN4fDO?=
 =?us-ascii?Q?QJcJ3RrBT30AgUpcoZdAqEdwWNnPaT0p2HHBKGFuT0KgcJBGzCwK9Yx0GF5P?=
 =?us-ascii?Q?UW3qqBO3b9MBDyzLmV3aQbnpxHSjtWoz8NpQwV75i9DbYC8y/WUKaQUNdZFZ?=
 =?us-ascii?Q?De6e56anUgZjFjJXfJeYpDNgmPMWO/YbWHOJznZiN9Q7BibVeY92BOf+Vx3g?=
 =?us-ascii?Q?DSkQk8myj3tLY3TmYlHIK83pOWgPXzSJ5e3DrMfJkVwThA3wDKin3aCQH8hr?=
 =?us-ascii?Q?akatzTp91v2djqhqAcHowpK5SG57XoDvDgn8cvHIoEPb18xXjJ8b/T8k/fRm?=
 =?us-ascii?Q?YWLozzm2p8AmTCF9GuAASBVb+y4V8VFAr7SactuhAHwfs04xdQuJunL+NUM4?=
 =?us-ascii?Q?Ke+MrjyvShk23kB7bmgVIdpmByF9aZ8/04CTgzOFBhAnN+/YDm5ehpgq5j9b?=
 =?us-ascii?Q?R6hjB5gpXp2m5ctYA64+acLDiaC9YQ0BUyIzcK1RaUgfpVYpuI3zs+y2aqL5?=
 =?us-ascii?Q?i7xSwwbQgoLOXuEXM+/9UqoM6nheXh4zWVFRO2eSDteyL3oP3CibWlTgehrn?=
 =?us-ascii?Q?89xXawWyLUdI1a/zDtmGlTCL7v0J+S/T?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 19:53:13.5781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5027e89b-c9de-48e2-d889-08dcbd63e5e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283

On Thu, Aug 15, 2024 at 12:46:29PM -0700, Nicolin Chen wrote:
> > > +static struct device *
> > > +iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id)
> > > +{
> > > +	struct iommufd_vdev_id *vdev_id;
> > > +
> > > +	xa_lock(&viommu->vdev_ids);
> > > +	vdev_id = xa_load(&viommu->vdev_ids, (unsigned long)id);
> > > +	xa_unlock(&viommu->vdev_ids);
> > 
> > This lock doesn't do anything
> > 
> > > +	if (!vdev_id || vdev_id->vdev_id != id)
> > > +		return NULL;
> > 
> > And this is unlocked
> > 
> > > +	return vdev_id->dev;
> > > +}
> > 
> > This isn't good.. We can't return the struct device pointer here as
> > there is no locking for it anymore. We can't even know it is still
> > probed to VFIO anymore.
> > 
> > It has to work by having the iommu driver directly access the xarray
> > and the entirely under the spinlock the iommu driver can translate the
> > vSID to the pSID and the let go and push the invalidation to HW. No
> > races.
> 
> Maybe the iommufd_viommu_invalidate ioctl handler should hold that
> xa_lock around the viommu->ops->cache_invalidate, and then add lock
> assert in iommufd_viommu_find_device?

xa_lock/spinlock might be too heavy. We can have a mutex to wrap
around viommu ioctl handlers..

