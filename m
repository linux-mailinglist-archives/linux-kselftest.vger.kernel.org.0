Return-Path: <linux-kselftest+bounces-20503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317519AD451
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 20:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CF01F22420
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D951D12EC;
	Wed, 23 Oct 2024 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QoFnBqqt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546781BD039;
	Wed, 23 Oct 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709717; cv=fail; b=RjRCqt0IsblSYh1NUXx2jY+AqYC0O+K27jGtDpsJtp1PIDXvLtW/UkzxSiuWRUDgrxEDn1VR9H6RhCQxjrDZxCNXI3JNHPY3rIVukAbrCyMWW7Z3P8RX9+Hey1pbP0J93OBencI/+uRh6PkrMlgd00IbFHGGavheKs3zsdpkfyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709717; c=relaxed/simple;
	bh=XjXTyiJoDKUJSHOXpJjVILuw5qG4HXRy0vL+2kkpuSg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhO4PdnNb8Nzto6wTWCZ4hNb+p9XDKtyzZ7MblpD1deyHFjaG0tjcV06qwX08XT8kERO3gft+qkfEub14mU7QAVUM+2Hfzw4WJoCOUV2Xz6h4RHvq2LKdOJ9+JQsAmVAWCESGcpKnq7o0T/a3RBAwvEAQH8s7W1GTJb87Xu0I+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QoFnBqqt; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xO1bNrCVzTzV29z888HcaCAx4r0Ix9o78pI7ofpBKbGcwIX2iF3fqi2V+/Vhy7pvvDQrcXVE/M0+xmAq8ZQB5iekgsmUBn+U/mKHY5APVJIKNAS7RZyPV6f4KT2OgMIlNpayd+lwfMzGq7QkNjX9zRQO+ai6kBkvxAEA+0oOlbj+HI8Mxz1bCEiSUOI4cMc+JWG6yp8b9KGZuoJdHhG3gHicBmD8FPUi3KGybHY+jjFfQwrK0CXUcVFDTQHcrAdy6gf4CoHyxQnjY3bSxdqUOJ6ss+2YBuYbSpoPhAREAEz5vmBEytrTjya+WHWoQ0u62yxySrHxZMzk2HmAhwcYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPamb8NoaSYTPyoUyrz+w19zaZyFL5jlFdMWnPBxUso=;
 b=UJm9KXTdLrPjY1+WVF/BY7rsTnnirIy5M6k9C2T2Yn3jadg8DbwXfO7d8vUCxPm0nWEo1CGhHl1eAZGdRUmGFeWVcq8AYKivKttwTleIa+Tvy14XOTPHeLSD97IAsvspdrVNri2ddJliKIKVjK1CBN/PMEAIumi77LOMvYNGfiKOCUi39MuD+JeSKavc5JvXvH0hn/XLKOQdR2ISc7an5q5d6F+rtNTgZ+9TGNQMvpG/5QclEQsOMpSEYD37U2nvICyRAX8tkIlnHFsnDFSSbdLfyuVcV2DS8zZPYVSK7cxhFN6z6HM48NlT/6bQU7zLRsOZ/EcfYVhqsUB+sGDzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPamb8NoaSYTPyoUyrz+w19zaZyFL5jlFdMWnPBxUso=;
 b=QoFnBqqtDrHzQ7GXPZ6jJW3XfgpGp/Jw54xH2hLOZi1TQ2QYclP0XGEsTcks5xLZVgYK9hJTJistp1CqPpkIDSzfSeh1g7Kux/UqQsnrPrQQaLxt7pQCT/47u/WuD7yWMoptg87QMW2wXu2j+I+nzFTvk7ZSig5suHF7OMaNJHpJpY7GTuNVJrvnBJO2gtr8iCiYPQ6SRG2+GftU3yn7BQhYbzi1Pd52P24IUu5O2c0KYLWjbxJXvJCXwBXgmUSX9oA9otaJAoPQTyK+rYzlFfE5wu9sfUu+UdAhc5hLErUNmO7xLCCVrodk8jNoKnM2nj7bOyXyqUkpS+/pS4MUVg==
Received: from BN9PR03CA0147.namprd03.prod.outlook.com (2603:10b6:408:fe::32)
 by SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 18:55:11 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::13) by BN9PR03CA0147.outlook.office365.com
 (2603:10b6:408:fe::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 18:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 18:55:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Oct
 2024 11:54:57 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Oct
 2024 11:54:57 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 23 Oct 2024 11:54:55 -0700
Date: Wed, 23 Oct 2024 11:54:54 -0700
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
Subject: Re: [PATCH v1 04/10] iommufd/viommu: Allow drivers to control
 vdev_id lifecycle
Message-ID: <ZxlGfgfwrGZGIbeF@Asurada-Nvidia>
References: <cover.1724777091.git.nicolinc@nvidia.com>
 <3ab48d4978318938911d91833654b296947668ad.1724777091.git.nicolinc@nvidia.com>
 <20240905180119.GY1358970@nvidia.com>
 <ZxikJwzq8rLPgtmS@Asurada-Nvidia>
 <20241023165905.GI864191@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241023165905.GI864191@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SA1PR12MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9c44f8-6b44-4480-5986-08dcf39438bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BTJEaWeGCIrbsr1Ue0YltfUHie92/h6wtttAxAtvRYkRdlYILzmoyXdrepgL?=
 =?us-ascii?Q?N4iASwzRdWCGrdyLFXFXwWrvhtw5ZkC67Zx3R8W2eFHgbi61y8Tti5AEyRsE?=
 =?us-ascii?Q?jxEos//xb4+Sj6zvUfAikI2GcESCLDyY4hADQKuQqiOuYvJa9FIu4Mh/DDT8?=
 =?us-ascii?Q?yUhkepF7cuG7+wRhnPnbNRFokxj97ITM5TGoG9JjEy8vQul1HyCyetklkgSu?=
 =?us-ascii?Q?3BmnaKOoE6IdMAWptM6oceu9yy3Vhj6bJJOdtPKng5zl4V8rTdijwAXi6/QH?=
 =?us-ascii?Q?AjV/QDRpnBc9z3kQCkzMOSMeVzRPO8Fh352DdGFixoSvTYz317JANp8HDFUt?=
 =?us-ascii?Q?vyRcReoWNkXq87vQotl5k48RIeeYQn1ETVKTJkV43xJPqYe2Tse4v4PsEx4P?=
 =?us-ascii?Q?gWMUBdPAPehH8URGP3Tc0E8YNmwvC82qpvfrzOz/sQ8+7Ny4rqbsd51kcs3/?=
 =?us-ascii?Q?5gi1DUV1F6j+sJZzSEFxkMXklhZlahbaDh8s48UJlkWeo1kqa2QGjUTUpfD+?=
 =?us-ascii?Q?DF4GaU00PmNarM2WrA+u7pgePStCS0+PkIT9EJvUl64VAgZo6DJahXKeok2e?=
 =?us-ascii?Q?c6Ps6G80JA359CwIZ2/S27IlUSNgdzqhHbiFOF5GLmgm7LSkwgiI3ncryrF2?=
 =?us-ascii?Q?sJq2/GbvOJ3RrKTaM+pyWSHxm7V/RALvGXgvRMP4HYNypJGURnFEbqG7nTvu?=
 =?us-ascii?Q?fdqK2I4Iqii88SJiu8rrRVrA553AVzrHX1uwN8CRSuO+CfN0m1K0bz+DbOjd?=
 =?us-ascii?Q?hd1B7Ij0CmYyWvHKXK3flA1VGqg9wZevdXMzvYPUQ4jovZio6Snw5o2nzEIo?=
 =?us-ascii?Q?hXjbxjIFiDG0/BFpstK2Py7OSPIx7ofACg2A06kQ748Zic3umUJ5ziqLZENB?=
 =?us-ascii?Q?KwOVYnny5KCI5zUrLueADxCQrb3LOYQhXa6uEKtQGiOthokvoB8Ie2/+6ElS?=
 =?us-ascii?Q?UP/PDDoXipmk98FicSA8tJqNBRa0lshrIYlM/AlHJpoesbg5XTZ+N81LRQOE?=
 =?us-ascii?Q?QEDxwgkF3r8N8DOavJO0/lRRQOPm8WwNCEHnk3pWKJCrUUeni+o2cVhVwRgB?=
 =?us-ascii?Q?3DMdLUYSoNpP2afeYdpP69vTzACjGPGR9UyAbH2x8bwdc0HwwpEuHjlucvMm?=
 =?us-ascii?Q?vLM0+JkZVW5MLc1ARfD4RHV5xFrTvaU3nLA9+5lfUPyiaBDjmxKOyAtg9YGb?=
 =?us-ascii?Q?GegSv6eQOIWFRGZ0mjlbkyJ/TtwpR/vBC6zYpvfP/pHNJxyBSuCMuCiCJ7oF?=
 =?us-ascii?Q?PgUS/qCanGdDWV/eUPfzvKoRuVd/zLe0yNUAfWCDTnRE6QUeY9vxgbslzei8?=
 =?us-ascii?Q?q3JhJxyRJx7jmM611zBmJZnJ6OgKwYqbKkY17W0SYhzt0gsN1c22ENBmHp6Q?=
 =?us-ascii?Q?XSHyhvGObg9as46zW9h8+gHqztVNLU3FtdajBV5O+PQjtpsAtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:55:11.0222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9c44f8-6b44-4480-5986-08dcf39438bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701

On Wed, Oct 23, 2024 at 01:59:05PM -0300, Jason Gunthorpe wrote:
> > [Comparison]      | This v1                 | Draft
> > 1. Adds to master | A lock and vdev ptr     | A lock and viommu ptr
> > 2. Set/unset ptr  | In ->vdevice_alloc/free | In all ->attach_dev
> > 3. Do dev_to_vdev | master->vdev->id        | attach_handle?
> 
> The set/unset ops have the major issue that they can get out of sync
> with the domain. The only time things should be routed to the viommu
> is when a viommu related domain is attached.

Ah, I missed that point.

> The lock on attach can be reduced:
> 
>   iommu_group_mutex_assert(dev)
>   if (domain->type == IOMMU_DOMAIN_NESTED)
>  		new_vsmmu = to_smmu_domain(domain)->vsmmu;
>   else
>  		new_vsmmu = NULL;
>   if (new_vsmmu != master->vsmmu) {
>  	down_write(&master->lock);
> 	master->vsmmu = new_vsmmu;
> 	up_write(&master->lock);
>   }
> 
> And you'd stick this in prepare or commit..

Ack.

> > Both solutions needs a driver-level lock and an extra pointer in
> > the master structure. And both ISR routines require that driver-
> > level lock to avoid race against attach_dev v.s. vdev alloc/free.
> > Overall, taking step.3 into consideration, it seems that letting
> > master lock&hold the vdev pointer (i.e. this v1) is simpler?
> 
> I'm not sure the vdev pointer should even be visible to the drivers..

With the iommufd_vdevice_alloc allocator, we already expose the
vdevice structure to the drivers, along with the vdevice_alloc
vdevice_free ops, which would be easier for the vCMDQ driver to
allocate and hold its own pSID/vSID structure.

And vsid_to_psid() requires to look up the viommu->vdevs xarray.
If we hid the vDEVICE structure, we'd need something else than
the vdev_to_dev(). Maybe iommufd_viommu_find_dev_by_virt_id()?

> > As for the implementation of iommufd_viommu_dev_to_vdev(), I read
> > the attach_handle part in the PRI code, yet I don't see the lock
> > that protects the handle returned by iommu_attach_handle_get() in
> > iommu_report_device_fault/find_fault_handler().
> 
> It is the xa_lock and some rules about flushing irqs and work queues
> before allowing the dev to disappear:
> 
> >   "Callers are required to synchronize the call of
> >    iommu_attach_handle_get() with domain attachment
> >    and detachment. The attach handle can only be used
> >    during its life cycle."
> 
> > But the caller iommu_report_device_fault() is an async event that
> > cannot guarantee the lifecycle. Would you please shed some light?
> 
> The iopf detatch function will act as a barrirer to ensure that all
> the async work has completed, sort of like how RCU works.

The xa_lock(&group->pasid_array) is released once the handle is
returned to the iommu_attach_handle_get callers, so it protects
only for a very short window (T0 below). What if:
   | detach()                       | isr=>iommu_report_device_fault()
T0 | Get attach_handle [xa_lock]    | Get attach_handle [xa_lock]
T1 | Clean deliver Q [fault->mutex] | Waiting for fault->mutex
T2 | iommufd_eventq_iopf_disable()  | Add new fault to the deliver Q
T3 | kfree(handle)                  | ?? 

> But here, I think it is pretty simple, isn't it?
> 
> When you update the master->vsmmu you can query the vsmmu to get the
> vdev id of that master, then store it in the master struct and forward
> it to the iommufd_viommu_report_irq(). That could even search the
> xarray since attach is not a performance path.
> 
> Then it is locked under the master->lock

Yes! I didn't see that coming. vdev->id must be set before the
attach to a nested domain, and can be cleaned after the device
detaches. Maybe an attach to vIOMMU-based nested domain should
just fail if idev->vdev isn't ready?

Then perhaps we can have a struct arm_smmu_vstream to hold all
the things, such as vsmmu pointer and vdev->id. If vCMDQ needs
an extra structure, it can be stored there too.

Thanks!
Nicolin

