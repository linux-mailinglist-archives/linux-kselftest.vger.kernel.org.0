Return-Path: <linux-kselftest+bounces-21003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064339B52C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 20:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771CA1F21701
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADBE2076C3;
	Tue, 29 Oct 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3uMw54C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31592076C1;
	Tue, 29 Oct 2024 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230232; cv=fail; b=Xk3z4rOs/2OrUlAsTPoz6tV7GJRqudBBYgBlW4l5t8MAdlJLztXbhnqmbE1Zj8VSx8qwAC6Co1WRke3QH5FiaL2e0KBBft4bT4cABHTP5V9XxC09V3duA++ufgHrYGPtjvwfn/315gr4q5jpu2gVbE4EGLPtSYC5N0tEFAzGO80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230232; c=relaxed/simple;
	bh=dG35fjSdC3JZGkSV3wgUtf72cut/TDmmIf6UhyzwkAs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2u+0j+HW+85BpG/Tg8YTLCjpKLs3lSOTrDBW+NQTLzpV8OrYAmn4lJTkjjqngu01lG3eHzI5SYzeVMGbBT91bRiq/Gmq5R094Kz0QuaK2oIWUOWforNaZVIzURhHIa+nWTyQHlkpc9IS2Q1pWDFKoYDLRFGvVuxvJf/Tab8qWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3uMw54C; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZAxRPpSOfApRF13Lpotv75fFk6AoJaZ48k/uOu8G2ia6ucYN6NsGunUkY+neodCD0EyGQz8mWRtH423YnXfcpQeDffwf8yfi1gOUqeznN4PlrXIhLyfTskv/B8OzAZnrOumJauhhHiHEskfmbgRQ02462TVHcQzPrXOhEr5rvLhu0AhWogQ9rf1fm4GS2fAihUNArQC8jPagxdqh1TBrrz9mihNVS9HLdlMokdteDD97KfFO0M8sOvsAckpps/3l87uL4VR8l71zTuXC4ZeoNP2zIcN2omoXODEKSLqWNY4KkdYy+X/7dwCN5vlUs5nKod/2ndFxuQtBjherP/y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gukfndwFmD9F+9DE6hGzZTWVgqXV8rnM9fr+XRV217A=;
 b=YkVrTEUAgms2h1SmlUeKAQOVZhkBs1KBPfMsWse00GWW/YEriLVzTVmN37qIoMj47MQyRExDL7IognzNqRZs/RnaNhN0xlfrjhRzcpMdRvpCj1/PFR79zJ5kFXYd3yEaeOAldlDRnfUTPARTlDFlkpUNUqLHaQaYVA+AntQw7R42dEyw6JTduoa5DRMZhDESm/kU0uBw3GwVMngfZXZuU8mFIle7dyR6V1n4k+kHyHkP75MTHBPv2ly+8U9hg2XV10LRaTYED+0Am6hKysxxsnCP/yIfF8wQTRrC6JpYmaghsxzcgakCzPZIOPJCAS0aFJ5ihqwxMB8SUSFpAZ6ttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gukfndwFmD9F+9DE6hGzZTWVgqXV8rnM9fr+XRV217A=;
 b=q3uMw54C+jLWLjQ1RUVOEZPvgTl0ofrHA89MHk6ilzZlN2fYnkFvZOsoUiTb4sNOuQCZJPzZYh6XYAQJ36rZJ5w6UPIzEs2HFVQnGc5RNuj2NeV7nZOspAXT9LksKnpMHUii2j6nQMieKy4qYmd9ZORoJowtcz7TI8ni8Jo5NvVA0gS10NjrHJsrD15aLHyYA0/dTjyZhVSKdTF4SYxwJ82LK24xmcsVCESYNNomB5G9FDH9MkeKdXDaHDwxD3Fz1yS9ka6bM1zJt+udMJfQkrqNb2PSx89xq4vcTCJrOUgCi+u2wy0U1EI1b1CC5GQavsBILddKmOGkw3ONs50a9g==
Received: from MW4PR04CA0126.namprd04.prod.outlook.com (2603:10b6:303:84::11)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 19:30:22 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::99) by MW4PR04CA0126.outlook.office365.com
 (2603:10b6:303:84::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 19:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 19:30:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 12:30:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 29 Oct 2024 12:30:02 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Oct 2024 12:30:01 -0700
Date: Tue, 29 Oct 2024 12:30:00 -0700
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
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 01/13] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <ZyE3uGyVx9ivJeHI@Asurada-Nvidia>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com>
 <20241029155824.GJ209124@nvidia.com>
 <ZyEblBMkvuq2rPAT@Asurada-Nvidia>
 <20241029184801.GW6956@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241029184801.GW6956@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: f80b0d6e-afe3-4b65-c77d-08dcf8502197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?whUwxOhcZPicdokGI+8kTmsrsrQms1QWFUzUaiuQYWhYCtqg1QlH56u20T/n?=
 =?us-ascii?Q?MEn8BIwM/+u6gNB333iDvQLv/PW8jsvfs02HvV6PbbJiSllPJLwcenK3AEeW?=
 =?us-ascii?Q?dQbpv0TlempSh53yuBt1l+/70Mz6gU8GsUxQwlGg+3Y+Cp0ZT11MByOckg7S?=
 =?us-ascii?Q?Fgc/iocTBURqM2S8lNpk0QsWFx6+ocLXsUdj7eFrxmgYku095xe3OOD1I2Xc?=
 =?us-ascii?Q?SfdRycVqWV+ZK+uQ0Yld0a2Jyg4uzkEMHaQgSlEX8phY2cEvwcubN52IIXb2?=
 =?us-ascii?Q?MbpT40TPty+rxzPOZ63jjTWUnCN1ZCrjQe/MymjYlAAbIseqOg5KJSLSYQ2H?=
 =?us-ascii?Q?VyQceq/9dVSDHz7TOHkPdUFmUP19HVsCmpFaovB0+MbwPRm7Q6H0Oz2aPMkR?=
 =?us-ascii?Q?ghIjiq/g2Vdiis7HZ3EgOezmpF9lIi84XQMe42nxSnqyzzOTmWDNGzuyH3AJ?=
 =?us-ascii?Q?yZ00VWs9dJcwWZF2R/vE9sOIFx98GOCMyGW5rDo//xyLDRad2mlM/PZek6Dk?=
 =?us-ascii?Q?+a7HUmPPeaKxkBZb4aZHI1j+ei2mk4wc5qc2DpY0frEFdDOuiy7fH+MgJeIz?=
 =?us-ascii?Q?Os+JaMb8FhWLawcW0YdNmGmL2mMSCj1RJQinfjId/wn6mTn6OKOJrNnCPDP/?=
 =?us-ascii?Q?VIKOhv8PnklkZEgZFuGSrAhWdssI1qoldtqcwj5KeAMGcl6iVT5BOkkUtd4J?=
 =?us-ascii?Q?ZU/GH0ftTmoVlKxHLJjljtO9FzKMM7frcs5OsSGVpsKdx29R2XMNv+raFRyZ?=
 =?us-ascii?Q?GZ89QczaAFLGhVJn/qdWSioLaLpH3LC3NnR8CeYjy8bjsP1FhqAkuzFQ+nRj?=
 =?us-ascii?Q?geUJv8lR8ZSGcQbmspHYd01plkekt+PzoszAIaQ327aN5TO0EfYmtIjhd/Jc?=
 =?us-ascii?Q?GguigWITx3oYvnxd5B/+VARCXfbfDhiZWopsERg0xIMstYXD3UtqPcK+sIyx?=
 =?us-ascii?Q?bMIzqnXyrtEXO+VscXFs7gbu57q3/xU5T47pX61COypFHG6YaDdR7z33Km8r?=
 =?us-ascii?Q?7EoxlFydFwTC5iz11wvVskBVS2YzcD90GhX+GteHHmO5qa/Efw++kupwDZyw?=
 =?us-ascii?Q?xEeOepgEzzV0D6tAf1AYjTfI/Y4yezZzE4zdmxxLVdKO9CAbHCJvZcBFq4q9?=
 =?us-ascii?Q?7r71nV+WrWLwvdnVpapR/11G6i/T9V0caDYEHFLcxubjyUh178ySHSdGsWeR?=
 =?us-ascii?Q?b0z5nShweGiWwn79Ik65FWwGeuNBl7j//8A4jBGFytFUGA0TOLpMKvawBW8V?=
 =?us-ascii?Q?Vx7YSQkdYp9/sjP5Gi6fzwKVcG+6CjrEHddcZ0kGyOF/+vEFbhCwdeHx+KMo?=
 =?us-ascii?Q?x1odcj9gXezxADitTIt4y+s4YkexWitXd0TbuevYoPPdBq9QkWN0SNGsZrb1?=
 =?us-ascii?Q?oXQU4Yt6wqyJdUZHo64mCjwRzGEWEF2hYyGfwCu1kMLQw37sPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 19:30:22.2403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80b0d6e-afe3-4b65-c77d-08dcf8502197
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873

On Tue, Oct 29, 2024 at 03:48:01PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 29, 2024 at 10:29:56AM -0700, Nicolin Chen wrote:
> > On Tue, Oct 29, 2024 at 12:58:24PM -0300, Jason Gunthorpe wrote:
> > > On Fri, Oct 25, 2024 at 04:50:30PM -0700, Nicolin Chen wrote:
> > > > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > > > index 5fd3dd420290..e50113305a9c 100644
> > > > --- a/drivers/iommu/iommufd/device.c
> > > > +++ b/drivers/iommu/iommufd/device.c
> > > > @@ -277,6 +277,17 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, IOMMUFD);
> > > >   */
> > > >  void iommufd_device_unbind(struct iommufd_device *idev)
> > > >  {
> > > > +	u32 vdev_id = 0;
> > > > +
> > > > +	/* idev->vdev object should be destroyed prior, yet just in case.. */
> > > > +	mutex_lock(&idev->igroup->lock);
> > > > +	if (idev->vdev)
> > > 
> > > Then should it have a WARN_ON here?
> > 
> > It'd be a user space mistake that forgot to call the destroy ioctl
> > to the object, in which case I recall kernel shouldn't WARN_ON?
> 
> But you can't get here because:
> 
>  	refcount_inc(&idev->obj.users);
> 
> And kernel doesn't destroy objects with elevated ref counts?

Hmm, this is not a ->destroy() but iommufd_device_unbind called
by VFIO. And we actually ran into this routine when QEMU didn't
destroy vdev. So, I added this chunk.

The iommufd_object_remove(vdev_id) here would destroy the vdev
where its destroy() does refcount_dec(&idev->obj.users). Then,
the following iommufd_object_destroy_user(.., &idev->obj) will
succeed.

With that said, let's just mandate userspace to destroy vdev.

> > > > +		vdev_id = idev->vdev->obj.id;
> > > > +	mutex_unlock(&idev->igroup->lock);
> > > > +	/* Relying on xa_lock against a race with iommufd_destroy() */
> > > > +	if (vdev_id)
> > > > +		iommufd_object_remove(idev->ictx, NULL, vdev_id, 0);
> > > 
> > > That doesn't seem right, iommufd_object_remove() should never be used
> > > to destroy an object that userspace created with an IOCTL, in fact
> > > that just isn't allowed.
> > 
> > It was for our auto destroy feature. 
> 
> auto domains are "hidden" hwpts that are kernel managed. They are not
> "userspace created".
> 
> "Usespace created" objects are ones that userspace is expected to call
> destroy on.

OK. I misunderstood that.

> If you destroy them behind the scenes in the kerenl then the objecd ID
> can be reallocated for something else and when userspace does DESTROY
> on the ID it thought was still allocated it will malfunction.
> 
> So, only userspace can destroy objects that userspace created.

I see. That makes sense.

> > If user space forgot to destroy the object while trying to unplug
> > the device from VM. This saves the day.
> 
> No, it should/does fail destroy of the VIOMMU object because the users
> refcount is elevated.

The vIOMMU object is refcount_dec also from the unbind() calling
remove(). But anyway, we aligned that userspace should destroy it
explicitly.

> > > Ugh, there is worse here, we can't hold a long term reference on a
> > > kernel owned object:
> > > 
> > > 	idev->vdev = vdev;
> > > 	refcount_inc(&idev->obj.users);
> > > 
> > > As it prevents the kernel from disconnecting it.
> > 
> > Hmm, mind elaborating? I think the iommufd_fops_release() would
> > xa_for_each the object list that destroys the vdev object first
> > then this idev (and viommu too)?
> 
> iommufd_device_unbind() can't fail, and if the object can't be
> destroyed because it has an elevated long term refcount it WARN's:
> 
> 
> 	ret = iommufd_object_remove(ictx, obj, obj->id, REMOVE_WAIT_SHORTTERM);
> 
> 	/*
> 	 * If there is a bug and we couldn't destroy the object then we did put
> 	 * back the caller's users refcount and will eventually try to free it
> 	 * again during close.
> 	 */
> 	WARN_ON(ret);
> 
> So you cannot take long term references on kernel owned objects. Only
> userspace owned objects.

OK. I think I had got this part. Gao ran into this WARN_ON at v3,
so I added iommufd_object_remove(vdev_id) in unbind() prior to
this iommufd_object_destroy_user(idev->ictx, &idev->obj).

> > OK. If user space forgot to destroy its vdev while unplugging the
> > device, it would not be allowed to hotplug another device (or the
> > same device) back to the same slot having the same RID, since the
> > RID on the vIOMMU would be occupied by the undestroyed vdev.
> 
> Yes, that seems correct and obvious to me. Until the vdev is
> explicitly destroyed the ID is in-use.
> 
> Good userspace should destroy the iommufd vDEVICE object before
> closing the VFIO file descriptor.
> 
> If it doesn't, then the VDEVICE object remains even though the VFIO it
> was linked to is gone.

I see.

Thanks
Nicolin

