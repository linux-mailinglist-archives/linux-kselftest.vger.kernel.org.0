Return-Path: <linux-kselftest+bounces-20682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DFE9B09C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 18:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB442843DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237D1885B7;
	Fri, 25 Oct 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bs58LzIj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C8188583;
	Fri, 25 Oct 2024 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873362; cv=fail; b=c+TxZP4OqnqekRnNkn2Uq7vdxZbdimnYo0Q46Opx8t747s2y2aRr3XgghFxbYwawL79ZMCw1L2DdY6W5Fe0ckCtm3Li6KzG+y4z4u9L4kOOk+KPDSClOlCBx/uPFiB8AQeG9b3JUFu91ExbNjCbO05Ue940f+IskjXT5uvnBuzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873362; c=relaxed/simple;
	bh=oFi7z5IM30gp71ZXImuYcREfZudTKdpcghdRPz1x8GQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fd2JYnfE8f1a/dua3oflZNLLhRDNbVTH0ENUyjVw+sSLNumvKb2No9yOh+PCFhD/TG4ue/JdMafHoNdaxTc0SIsj5/AayQDC0WTRNwTVwJUIHzVZ6O7mHvlU9WV7+mCNKQYec+FJsfDCM2iRTGkSC3OeRsLMLZgf5Kf6nHL5md8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bs58LzIj; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvqd+frGUHhu752Bl9fB8Y+jihpSDHDV+N4mvkOWI7LolM289ArXyJMljtl3VjiDLGYBXWst3UaydGy2Vkv60XXzfmRMbAFLh/zYPFuRiQ6znigtfPNSkYpnLzFjaHxKuC3VWIMo9MZpn2Mw0SexYl7pznqe5icnuC7dJ7Jm2UlPDrErQc4+fvT2ClxlXTqIFqAgS5KjzLHbhO60A131v4LUlADjAXfHe7xybtrn4OQAcK0ylX27O+JmvVWvSU7CvGbvU3oaGxUVmfFMKQQqWjDqiTRlv1NP6jJNI6bsJ9aHswCowtGRj9DgTUrXRnx6WjLoqobYy3GOdlfN4YTC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJdq6qPeaBnkDGwbdq0Do4c4lAgregInf92suqQvNEY=;
 b=HjYCG7/Sn81hlmV6XmNHXOG0mLLUJ+Jj1mp+6IPzqXHJAvmYjmV0wQHCwwr6hgNEZTNJQIDC7geFOfQIqrWy42zh52V+KOlF+6+JCMw08wP71ku9Rwx0ooOrKstyp+2xqLqDT6pKNiNHwQnozSLSkUvNMPXDx4S63KSjPQV/rWTgx4N5Dy0WkcrO6te9C8Q4nZFi6Vl5Zpd9QbsdCLqnvXggUoiLbZhARR5h622rfubR3884ky5xaw/1m417+1wuqchon49eLW3NGHIsOvCt6+5qf3wz6f1iNVUoo73uGpflZ9mEZ96Y2yOw4D8yRAW1d+htyydHK5sUXV9NFJrzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJdq6qPeaBnkDGwbdq0Do4c4lAgregInf92suqQvNEY=;
 b=Bs58LzIjR+DvF9KeNPe01IkBtpkzHsg6LwhGacgFw4m+zwbxkUND7pTGq466qLE+wJFb+Yg3+yfL2km28z5h2/TTPCwva/wZYQVMQ9RZzxTAqakiRjx0f8PgCxQYm2Yd8uzH8Br+mFu0H9w2eSDz1YFvnX43yOh1WaI70JgZcZ0iJv+u+uilOIzIGzo20H+JxHPyhWgdLcWZtrepFEy0KImhsH1ayUxIvl6ck8J+n9aEV5KTtrKfE9opDT6LycGg3t728dEL1bQ+b34zu5nJAmviqAzJOqCZIKniEUY56mwXw6k7nsEvydWLsv11c/7UDfy7qiC6e3+76/HsIY8EmQ==
Received: from MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::28)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 16:22:35 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::db) by MW4P221CA0023.outlook.office365.com
 (2603:10b6:303:8b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Fri, 25 Oct 2024 16:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 16:22:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 09:22:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 09:22:24 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 09:22:23 -0700
Date: Fri, 25 Oct 2024 09:22:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v4 04/11] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZxvFvjRiqNd7Oc4v@Asurada-Nvidia>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <9da2cf334a182ced4d4ffa578b87889e9c0856f3.1729553811.git.nicolinc@nvidia.com>
 <BN9PR11MB5276BC711E46B073AF8846048C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276BC711E46B073AF8846048C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 18bba775-6530-48c5-63fd-08dcf5113bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qchBOWBcVkktMsQxxefgUOBw59ITuCegWzWb/ZAfc0RRto0g6q19sUe6UyKo?=
 =?us-ascii?Q?ZPB26FKo3qEPMd20yi5A2gvFFDv8SG90Nel8tRiWkTug01Cx0iaa/mU81VNv?=
 =?us-ascii?Q?zRPcLTYUEGkTlih5XWPYkGy2L5hplXHt6eOy5h/q2LmJNEh6yb4KTG2PFleo?=
 =?us-ascii?Q?9kDSfq6vEj1YKsNk+sGcIoB7LE+vpSkqvm1miESR4dpvjeeFsVhIAvBf2Y/d?=
 =?us-ascii?Q?gClctotRV5uWfSyHZ5+muwfA0Eo9p3ohH3B9ysALFZn2AH0txJ8FNaknNaJf?=
 =?us-ascii?Q?+xOoGBGNR/UfIW1v8j3MN1liz2KdzAftK3Mu0uMPLJ3OCHjLCGgk1TLngmZ0?=
 =?us-ascii?Q?CefP8obynNKgM4r/uQzrAFv3kxfg1to8RC8xSqP7AlZFK7C7zoejIVieaB4f?=
 =?us-ascii?Q?lcHGp5bhEHzEsZo9/JuK+afInPdYKZnoR3d9Laf33o5W5w4NurMu+gEQVCQc?=
 =?us-ascii?Q?86coH3v5NUV1bgSLIzCqjT73DvrBOLPMnfbHboBYXrqMxJzy3V147XEuPvsj?=
 =?us-ascii?Q?9IkmBzWZLPDT5+waATgwxg6Rbf5ZgV1offDQ+btVfgw5MC2K2YuGeH6p1pcK?=
 =?us-ascii?Q?6rfZk+P8BijwaAHKBvVGL0HsNO9cVPJ/xDR3sI4etOADwutVPBkvInnsct3c?=
 =?us-ascii?Q?cHEsYHxrOIfAdVzHoV0tFptImnbAscVxGo02St/c0lXOCfmS3vyvTz9jH9TF?=
 =?us-ascii?Q?ShvnSOAv/hblBYv1ao1EPDl6UxYiaAzMeWFWIwte5fO1pFQ95GYNgsJFtrI9?=
 =?us-ascii?Q?PNzpoeFiaTgSsYf+y1gy5k4LsqIKPWAdxWvaYPJVVgh3kgS4IdCzAh7Lppdp?=
 =?us-ascii?Q?mtfmcXCaA3rABFVcIJ0bMpKNFlzhKSTqPCfmQ/wbEEcs+V2yOdSiuCC6OKiH?=
 =?us-ascii?Q?w3HJGUQGGA41xNc+pXlQacu7KFuUpbinT+T8xQwjvUJ/bRv4Csc7FsnPSh93?=
 =?us-ascii?Q?hxTblWqtHvTKDZsGUdJtvru7nw3ijxnGgVd2P+MppYO5yiDK6X8wn4BC0Rkv?=
 =?us-ascii?Q?uOE8coCm/NRdT0d1uQucWd+c3eIfBEWMGcWrm7NArB6EqltIk2oR5fL98KlH?=
 =?us-ascii?Q?cybUc0KvBL46+nmrTAHvim21a82WieEO4OMW9QT3Fvmy/3fvnFwY7NGwyG4E?=
 =?us-ascii?Q?jVXyq0QlkWYcyNknTj16YCMIDZJexVvci7uFgKPHNVtIe0XdKKhTLeeiO92R?=
 =?us-ascii?Q?C+EpGJUjWvQg+SMYKKmSgxf7yoZCbElreWMpzjPwLmAUMSU0fy3LaJrbTjF5?=
 =?us-ascii?Q?nqDk1kirqmM0welXoLIb1j1mgx/OXFNCCpkOXEgSjdOSNN4x1J0wIKV3e5sk?=
 =?us-ascii?Q?MfTepC5og1mwQqcLQTrxFvI9nQhKmjs78a289dqnYmjH+IHs6HZjPCLseRks?=
 =?us-ascii?Q?XQim+okpE3lTOQRYH0lhSrPd8Va3ya+yoVgVwqcNCCYWHS5ouQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 16:22:34.5330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bba775-6530-48c5-63fd-08dcf5113bcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124

On Fri, Oct 25, 2024 at 08:59:11AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, October 22, 2024 8:19 AM
> >
> > Add a new ioctl for user space to do a vIOMMU allocation. It must be based
> > on a nesting parent HWPT, so take its refcount.
> >
> > If an IOMMU driver supports a driver-managed vIOMMU object, it must
> > define
> 
> why highlight 'driver-managed', implying a core-managed vIOMMU
> object some day?

Oh, core-managed vIOMMU is gone since this version. I should have
updated the commit message here too.

> > +/**
> > + * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
> > + * @size: sizeof(struct iommu_viommu_alloc)
> > + * @flags: Must be 0
> > + * @type: Type of the virtual IOMMU. Must be defined in enum
> > iommu_viommu_type
> > + * @dev_id: The device's physical IOMMU will be used to back the virtual
> > IOMMU
> > + * @hwpt_id: ID of a nesting parent HWPT to associate to
> > + * @out_viommu_id: Output virtual IOMMU ID for the allocated object
> > + *
> > + * Allocate a virtual IOMMU object that represents the underlying physical
> > + * IOMMU's virtualization support. The vIOMMU object is a security-isolated
> > + * slice of the physical IOMMU HW that is unique to a specific VM.
> 
> the object itself is a software abstraction, while a 'slice' is a set of
> real hw resources.

Yea, let's do this:
 * Allocate a virtual IOMMU object, representing the underlying physical IOMMU's
 * virtualization support that is a security-isolated slice of the real IOMMU HW
 * that is unique to a specific VM.

Thanks
Nicolin

