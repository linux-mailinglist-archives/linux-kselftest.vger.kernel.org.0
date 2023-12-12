Return-Path: <linux-kselftest+bounces-1705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46180F64A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C871F21569
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 19:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACFF81E32;
	Tue, 12 Dec 2023 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GeoufRPj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7620E9;
	Tue, 12 Dec 2023 11:13:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RucWxNhADZcyCzzTNOnynGaQk+9VzqRsef2RBA5IavVsa2fh+tZhonq6CmKmWhLwaomxeii7GKBChXwaPx1gxwpNlGplgXznXMq8Ki0VqIUpO69aUTBXWYp1APqw2uE2BL8uVxfR0ACn86d6BHDvLPkU3SCUrcRY4C8+8JZolO+H4TWbtZGfYw2DnTrNEVG974zfjgWUrT44YFwIYON/JjPYPpNnso9p2IZnuY4DCs4BwGWX80fht5tEUZO0/hkvWmjLMUK+PI3djqgwK3LYej7QvSrx1f9jcCUNbYiUhUvQQy2g/fXKyO64x/YxxO1dcuzcLypdSUCwvREuhBZ/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxIgn78l9TA3zeCregDIFyA6a17B6JaYjp616ND6rLA=;
 b=kmksvYvqyPlkZvINzNH0mTTYHNwmUGgvEJ8eNDUWYbVEyJth/MNifPwx/VhRi8D8x1CyqGF3qcFpxb7E8XR70eg8VMkOf3PSI7B6Ct8otm1cUzSBj9Xj53huUjxxjNMZs4cmixl+g9iLTVc3EDqCXkK5L0o7aWIOmm/HZsBtJeyCaPRzKWpmsXG3XOdtRbK+NIoy4F9+ZS7grshkQZbxSpQvYgd56mciuF7tHpIoEuPfliGJZGGDylapGZc3KSasa0hZkm7lam6KxmAat+hU5GkR/uUmGp6w4m7Xomuw/CWkeElWO+VPK+31e3URQhqNcVBaoFcUKBVo6jTsJwajwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxIgn78l9TA3zeCregDIFyA6a17B6JaYjp616ND6rLA=;
 b=GeoufRPjvyvlMzDrLYU2tHmWhKw285rMEryx2chPg8CIffCs4Onb8QvYdZRmOkynm/IH78Zb9YY+TC+kb18ikpctD2sOugM2A/Se4OJ7p+tuDC8NUKpoyxcjM8BOFC68xb5EYPwC1uEva9NDRYX6z9fYigcZgI4a9qU3MHP9HtkXWl7cvO7h3CT9v2g03YuebaXYL1Kp4nNBmsor1Et7OSru2JRpe/r6HfSLxFKf3c69zE6T52SBhWCf+wZ1umOv8tHLywbIJ2Stgs3EZja/ItWM/90I81D9vN4tCfkModolMKnu2NOZS5dKqCye3WCtH6tbxt8ZyxiECQ4eroO2xQ==
Received: from CYZPR11CA0014.namprd11.prod.outlook.com (2603:10b6:930:8d::24)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 19:13:43 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::62) by CYZPR11CA0014.outlook.office365.com
 (2603:10b6:930:8d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 19:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 19:13:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 11:13:40 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 12 Dec 2023 11:13:39 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 12 Dec 2023 11:13:38 -0800
Date: Tue, 12 Dec 2023 11:13:37 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Yi Liu <yi.l.liu@intel.com>, "Giani, Dhaval" <Dhaval.Giani@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<alex.williamson@redhat.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <cohuck@redhat.com>, <eric.auger@redhat.com>,
	<kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
	<joao.m.martins@oracle.com>, <xin.zeng@intel.com>, <yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Message-ID: <ZXiw4XK/1+ZdsFV1@Asurada-Nvidia>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <ZXd+1UVrcAQePjnD@Asurada-Nvidia>
 <20231211215738.GB3014157@nvidia.com>
 <ZXgL+GCGPgH+hlXo@Asurada-Nvidia>
 <20231212144421.GH3014157@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212144421.GH3014157@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ed9ee7-b978-417e-b5e1-08dbfb4673dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wqwPhiEjfLhOGTQ3FQn3n80PbFLpzpHEX2G41Bk1AKj5TiZwlAL1f7Hm/oI1q34U9pNiQfFRUNiERJxkNNliaubjidSF7eM4fbNWloz4csqACwrReNn++r0d8kJG58rAupO0P9CX95Sk4cph2QBTDc/aVHy9qi4VjJRFd8IGfQpJTUWyB933XYCcRoGFHgo5QtwrHnD2EPNjG4204P+7hFYYjQOWl88XOMmRkVuio9Xs/HfgqBLKdmXTTb7iGlJiLT4WhQe9Rq8h+sDL7bzHWpI6qk5kSjZckLc0C/qJM+5J//fxXCfCRNNu1n+WwWix++55gEowEgG+Q04JX3mLNNKtvUBr/G90xz9a8Z/ju8v13n40dh7cTYwDwyNZxV02+yM4E5lLgbj8i6UH/VDIxoam01HfojsK5vkBLbEU8B1N+9OCLj0fCn2EpEIzL0vTgYicBOd2oTUTaLqRAxIwssXYSpVJy2NONNkzEPdhIIRjd2cucvUzemeZvycV2EpGIP5PxEdGD8Nm/KfZVUIvBr/Qe/Fejyx21KxFS3rKcaL88wyiVDuWn14zvwO1HQhwhhixvijeBNegtynEQv/NuZ68cDUmcizU8AocIiWNTfnr0JNA9DswctDWfuPZhY/NXOAfBvIUeisBgu8qWNEt9DWZK4lB85rbWKbJSUONtSjdEHSpDWekAUZWh7btQP8AKZQubRc29OkFc3Vb4tZcKCsazZ48sXpXvIXrx5I3KLVlJNNvCEr0SeGBILFrbjcw
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(82740400003)(41300700001)(8676002)(7636003)(356005)(316002)(8936002)(6636002)(70586007)(70206006)(478600001)(33716001)(7416002)(86362001)(54906003)(26005)(5660300002)(9686003)(336012)(426003)(36860700001)(6862004)(83380400001)(2906002)(4326008)(47076005)(40480700001)(55016003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:13:41.2155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ed9ee7-b978-417e-b5e1-08dbfb4673dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111

On Tue, Dec 12, 2023 at 10:44:21AM -0400, Jason Gunthorpe wrote:
> On Mon, Dec 11, 2023 at 11:30:00PM -0800, Nicolin Chen wrote:
> 
> > > > Could the structure just look like this?
> > > > struct iommu_dev_assign_virtual_id {
> > > >        __u32 size;
> > > >        __u32 dev_id;
> > > >        __u32 id_type;
> > > >        __u32 id;
> > > > };
> > > 
> > > It needs to take in the viommu_id also, and I'd make the id 64 bits
> > > just for good luck.
> > 
> > What is viommu_id required for in this context? I thought we
> > already know which SMMU instance to issue commands via dev_id?
> 
> The viommu_id would be the container that holds the xarray that maps
> the vRID to pRID
> 
> Logically we could have multiple mappings per iommufd as we could have
> multiple iommu instances working here.

I see. This is the object to hold a shared stage-2 HWPT/domain then.

// iommufd_private.h

enum iommufd_object_type {
	...
+	IOMMUFD_OBJ_VIOMMU,
	...
};

+struct iommufd_viommu {
+	struct iommufd_object obj;
+	struct iommufd_hwpt_paging *hwpt;
+	struct xarray devices;
+};

struct iommufd_hwpt_paging hwpt {
	...
+	struct list_head viommu_list;
	...
};

struct iommufd_group {
	...
+	struct iommufd_viommu *viommu; // should we attach to viommu instead of hwpt?
	...
};

Question to finalize how we maps vRID-pRID in the xarray:
how should IOMMUFD_DEV_INVALIDATE work? The ioctl structure has
a dev_id and a list of commands that belongs to the device. So,
it forwards the struct device pointer to the driver along with
the commands. Then, doesn't the driver already know the pRID 
from the dev pointer without looking up a vRID-pRID table?

// uapi/linux/iommufd.h

struct iommu_hwpt_alloc {
	...
+	__u32 viommu_id;
};

+enum iommu_dev_virtual_id_type {
+	IOMMU_DEV_VIRTUAL_ID_TYPE_AMD_VIOMMU_DID, // not sure how this fits the xarray in viommu obj.
+	IOMMU_DEV_VIRTUAL_ID_TYPE_AMD_VIOMMU_RID,
+	IOMMU_DEV_VIRTUAL_ID_TYPE_ARM_SMMU_SID,
+};
+
+struct iommu_dev_assign_virtual_id {
+	__u32 size;
+	__u32 dev_id;
+	__u32 viommu_id;
+	__u32 id_type;
+	__aligned_u64 id;
+};

Then, I think that we also need an iommu_viommu_alloc structure
and ioctl to allocate an object, and that VMM should know if it
needs to allocate multiple viommu objects -- this probably needs
the hw_info ioctl to return a piommu_id so VMM gets the list of
piommus from the attached devices?

Another question, introducing the viommu obj complicates things
a lot. Do we want it to come with iommu_dev_assign_virtual_id,
or maybe put in a later series? We could stage the xarray in the
iommu_hwpt_paging struct for now, so a single-IOMMU system could
still work with that.

> > > > > IOMMUFD_DEV_INVALIDATE should be introduced with the same design as
> > > > > HWPT invalidate. This would be used for AMD/ARM's ATC invalidation
> > > > > (and just force the stream ID, userspace must direct the vRID to the
> > > > > correct dev_id).
> > > > 
> > > > SMMU's CD invalidations could fall into this category too.
> > 
> > Do we need a different iommu API for this ioctl? We currently
> > have the cache_invalidate_user as a domain op. The new device
> > op will be an iommu op?
> 
> Yes

OK. FWIW, I think either VMM or iommufd core knows which nested
HWPT the device is attached to. If we ever wanted to keep it in
the domain op list, we could still do that by passing in extra
domain pointer to the driver.

> > And should we rename the "cache_invalidate_user"? Would VT-d
> > still uses it for device cache?
> 
> I think vt-d will not implement it

Then should we "s/cache_invalidate_user/iotlb_sync_user"?

Thanks
Nicolin

