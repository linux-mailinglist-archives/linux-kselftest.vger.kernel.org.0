Return-Path: <linux-kselftest+bounces-20206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEA59A51F1
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 03:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F541C21355
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 01:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC07263D;
	Sun, 20 Oct 2024 01:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V5IUMy6e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7583232;
	Sun, 20 Oct 2024 01:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729388560; cv=fail; b=J9uZNv2asuBJPY+NM7YBO1iR3Qef+TmtmTqS84CHqqz38Gp/RE1OashCBlMiv3/uca9qI0Pv5D3NwWPsA/+rWFOc5zq9fe1Nn7tKnMZLSp7Fw+nxtE6sycTOQqj8CKlD56cxORTg9lmi4w4SKey7l9DIXx1oxSAzU9dHVwBlWfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729388560; c=relaxed/simple;
	bh=YwxYCTtZJ7zdIeWy9R6N4E2Tv5YBdYEwQD6Z7gLA76s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxBiCDUXcqyDXe7+QY8fDwCDVO9+E4+OSfSj7FrMWpiStxCXV25JLQgC8SRkecRdePMguC/S0xSW7/IU5ZP7L5IujlwzMINOt7zTrDlhvmm9mO+aRb0u+k9I3Y6miAnOkGQLiXeQ9xXWBu7BlFBemWixWJKxTAsWoEbTynuLCcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V5IUMy6e; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFF6S+smRBEQss4FuTX4CSB3rdEaSvExLHRdTF5/KuF8rAmW6IXM3bKUJig0pd9s6cNK4xBh3oP0ts2WtkqJKWQ56DgjB2O8RW7qy80nf+fzWcg94Y+LikfTp/xsiwl7C7drGkLlp4loIMl8NtTvzov00jwCTh/TcNJBMk7UW5g3cP4sRk/YurTOWTdnFRO97xF0vyOganc+EUCbSEXhBICMII9DORqjlvf+mAaTa122M31Dhcnn7DksuHqd+gJKG4//0AvP2rcfRVw93goud1w3DYRA3/dTl9xLw23MAlzul7xGrd9HUDSXLLtXvpENppOZSkyM9Pw6WY1aRtG7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWiZbkWmdu8MT73103i1Awce8BjSeBiSTkmYi6mkycU=;
 b=MJPNvwuy0xfKsZWMUfKTtYhnyfkwNyWEv95xdpVkitOXgvfXlfLBfIypD3yTqngh5TDYtmjmFkBjyMdztAHmhLgcELVdvTzbeHET0xa0LE0/B2dpjI6HUPCVdcdFVLFA1bM3MRtjiM63fVSo+dsWqRBxUQsiz6mqVUFKCN7fDxXoSVlWe79pRsuoYw+AJABIXSBwVexUXDCKrCcgiubLMnoJ9i1WAjY6PS1fZ5HGKyBVFNnsRgWsrAgDzpu7hnvKXYklFrdcgvyCT0gpp9ImawU692kByKmUHYZUzd/vnRy7Cd+VB4I/JG0LaOduNkrKr03UaoSeyrELVfidyOqF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWiZbkWmdu8MT73103i1Awce8BjSeBiSTkmYi6mkycU=;
 b=V5IUMy6egUuc3yzgVLWFjb2hr0aoTOM+gtg5PZQ91Jp2gkfwsd8GxeTpiVHb5EKAp5o2Isa2MgzXfV7zYNUUzC76ifgIwIBoQ6vMAEuJ05T8wad8mLx8FLDgSfR4y8aO1IMqdMZBrcysUkdWAxRyrlpMg4s/qUCqlJUuOsc/QUFipxxVmQ7AqW1brcJrUOQ3SwYgX6Bl9ZWqAE1oojAlEDsQR87Tg97B7obF6Jyr7rNakJRbk5Z9iMYteJuHuM8xNrdkzXT7JNvc3EQF6TQVTbhWueT29OhJdenrX0y2zN5vO7+ae39EdDzU4Ic0fkhYKCTLc5CTvJsCesJIIU8snQ==
Received: from MW4PR04CA0387.namprd04.prod.outlook.com (2603:10b6:303:81::32)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Sun, 20 Oct
 2024 01:42:35 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::87) by MW4PR04CA0387.outlook.office365.com
 (2603:10b6:303:81::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Sun, 20 Oct 2024 01:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Sun, 20 Oct 2024 01:42:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 19 Oct
 2024 18:42:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 19 Oct 2024 18:42:32 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sat, 19 Oct 2024 18:42:31 -0700
Date: Sat, 19 Oct 2024 18:42:30 -0700
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
Subject: Re: [PATCH v3 03/16] iommufd/viommu: Add IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <ZxRgBq3wPy6xHUbb@Asurada-Nvidia>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <df942c216c0e5d1740ba5add73375becf0713dfd.1728491532.git.nicolinc@nvidia.com>
 <20241017185230.GS3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017185230.GS3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcf9822-7226-491c-8f92-08dcf0a87872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iwff4q/yJaIMonKoUd/ZK2XU/F03vVtXDt9VJhGxpJUk9LNJ21Xkke2jWrMF?=
 =?us-ascii?Q?6x/MvSJbBv+2M75if5BowAE+DUFUmoUwmlR9/IHjYDaidNxvQYZShUmes+qZ?=
 =?us-ascii?Q?au4I4HDJYmFEPzt1OJBL4vdMpVcXBhstneUqgfXfLEGu/HArTObt9QiEupNO?=
 =?us-ascii?Q?3o7EGy6FXDkcURH1VE3oGZb1KS6ADsMHqd8MwQmzLaXNw7nlLM8OMnyuA/A5?=
 =?us-ascii?Q?Pz3oiRL0o2D8XOyHmufiV5IrW5HBvaabNqK3quwl/jMkLItN9nIqecAK+ysF?=
 =?us-ascii?Q?CqoLGcPjkOsfA0WQ6Nz2JPYvfAIv/dKhxa5gEBG0Zr08+SJGBFdiRwKmmalM?=
 =?us-ascii?Q?uQRfmZ8jjpwwuQ+TPIFUOHEseQhsev62GgevdOlMMSn0RZY7+Dj9k4htEhLx?=
 =?us-ascii?Q?Coxp6ZyTUnuPTBlXnPjAOHzMvE/1NVESHtv7O81KnZ43L0Ydo3afxMZJTRAF?=
 =?us-ascii?Q?aJaNNtCQhnzJwHyOfo/UVdfUPikzYH5oDdS3EbeqtpWy0+QXB7KwGOqtL2vA?=
 =?us-ascii?Q?DRDnqs0maVIXuHDJWTJqQrITszbECxvO/YoWVGER2u/XpQIEI6kUgKZFk1Jw?=
 =?us-ascii?Q?Ryupbz65LIDOCtM1x0uil5NWs02JxwPsat6GzvwZv0nme4LhJLW3weJsM9mv?=
 =?us-ascii?Q?5EVbnbzPK+jd9K32ugqbIo9CUashYiDb7Ods59VFQkbF7sFqHz1Blx9PLcjX?=
 =?us-ascii?Q?/lmYI6fa3Hyjgc9d2RYQphCguj0vFiyJ7V04VaxavDF5HGvx/z4+hcL+ZmtJ?=
 =?us-ascii?Q?y9TSrzftaopIRqnu2gDpJhBQhAkAeASgJbQAHzh6Xb0Yw7bAmLo3b46UDv3X?=
 =?us-ascii?Q?9ewykSfdxmKGsvhjBPWLcfBwoTtyERbU8JMuyP/m/gDqJd0kEKMcfQgod2zi?=
 =?us-ascii?Q?40GXmwFGHOuyUaJ68AMFSLW846KHDeBqXT55odTeGn+lTLQROMRzFsAJDgpg?=
 =?us-ascii?Q?G8f6TJLybfU3PWpg0S5c+akGbOJ/yiuAXTyDF9XfNvxHICDIpF4sQTPx2+rF?=
 =?us-ascii?Q?5k2mFk8lgcpeh98ShYFtY6VJud3xtZGzyBOfAc9+EAXntucqhLk4cHqfQFuc?=
 =?us-ascii?Q?phrUSivcvbkSg9Bt7byHrRPa+iz+WiWkKQybz91VbNuoCHGBMBw7BYTYbVYn?=
 =?us-ascii?Q?g74wnywatSOye0U5AW2HI/TNvWCLwe6OgKJp0/lsSZFbsz0dOFODOjIbhpbu?=
 =?us-ascii?Q?kPQZAYM4KPLWImSLh2ooqbX2H7iYzVSHbd7O3xhJVFs6uApWO2roN5BlJxRg?=
 =?us-ascii?Q?rlGuXfbwnwW7tId7m+BQlhUlQYmKJ6ioIoDMBOqR5O+SQhRv9A1gox0npdYi?=
 =?us-ascii?Q?gSNN4q83SaKqjMgSOUs7O1RVCqTVXnJXGjIAlkgByZh9czW2brHfj9YEQlCz?=
 =?us-ascii?Q?M19+APR7d+eaTDAO9Bp0epsF8v8PlqJKlGlQVYavY3gSg13R5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 01:42:34.4619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcf9822-7226-491c-8f92-08dcf0a87872
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370

On Thu, Oct 17, 2024 at 03:52:30PM -0300, Jason Gunthorpe wrote:
> > +	if (viommu->ops && viommu->ops->vdevice_alloc)
> > +		vdev = viommu->ops->vdevice_alloc(viommu, idev->dev, virt_id);
> > +	else
> > +		vdev = __iommufd_vdevice_alloc(ucmd->ictx, sizeof(*vdev));
> > +	if (IS_ERR(vdev)) {
> > +		rc = PTR_ERR(vdev);
> > +		goto out_unlock_igroup;
> > +	}
> > +
> > +	vdev->idev = idev;
> > +	vdev->id = virt_id;
> > +	vdev->viommu = viommu;
> > +
> > +	idev->vdev = vdev;
> > +	refcount_inc(&idev->obj.users);
> > +	refcount_inc(&viommu->obj.users);
> > +
> > +	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
> > +	if (curr) {
> > +		rc = xa_err(curr) ? : -EBUSY;
> > +		goto out_abort;
> > +	}
> > +
> > +	cmd->out_vdevice_id = vdev->obj.id;
> > +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> > +	if (rc)
> > +		goto out_abort;
> > +	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
> > +	goto out_unlock_igroup;
> > +
> > +out_abort:
> > +	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
> 
> But be mindful of this abort, it doesn't want to be inside the lock if
> it also gets the lock.. fail_nth should be updated to cover these new
> ioctls to look for tricky things like that

I added an abort() beside destroy():

+void iommufd_vdevice_abort(struct iommufd_object *obj)
+{
+       struct iommufd_vdevice *old, *vdev =
+               container_of(obj, struct iommufd_vdevice, obj);
+       struct iommufd_viommu *viommu = vdev->viommu;
+       struct iommufd_device *idev = vdev->idev;
+
+       lockdep_assert_not_held(&idev->igroup->lock);
+
+       if (viommu->ops && viommu->ops->vdevice_free)
+               viommu->ops->vdevice_free(vdev);
+
+       old = xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
+       if (old)
+               WARN_ON(old != vdev);
+
+       refcount_dec(&viommu->obj.users);
+       refcount_dec(&idev->obj.users);
+       idev->vdev = NULL;
+}
+
+void iommufd_vdevice_destroy(struct iommufd_object *obj)
+{
+       struct iommufd_vdevice *vdev =
+               container_of(obj, struct iommufd_vdevice, obj);
+
+       mutex_lock(&vdev->idev->igroup->lock);
+       iommufd_vdevice_abort(obj);
+       mutex_unlock(&vdev->idev->igroup->lock);
+}
----------------------------------------------------------

And I added fail_nth coverage for IOMMU_VIOMMU/VDEVICE_ALLOC cmds.

Thanks
Nicolin

