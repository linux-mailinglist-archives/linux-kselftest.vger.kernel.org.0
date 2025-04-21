Return-Path: <linux-kselftest+bounces-31263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84856A95580
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 19:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62173B4ACD
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4126F1E5B9B;
	Mon, 21 Apr 2025 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LBQMEaTi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D751E5B7E;
	Mon, 21 Apr 2025 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257642; cv=fail; b=FxIvKmejrOBN1b9tD5XyEqs9vVoQzRgb45kTsHpXvk8HpL8ZMWs+sYj/Bl9eThPyJZBN3GzrUd3SO2nKUhPY3e+MM/5qF8WNCzT4N1Vgp8zkuj+DgzyoU+OnXlrvC0TbN7w4pgDCKA0gOIpsHjgR8Fo8/imvNdFO7Ds6cNPNfvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257642; c=relaxed/simple;
	bh=0Tj0dE6AM4EBR7kSoue+eV89+aGm4FIT03zM9rMelj8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU9k0F75Opun9DrEtbXJvmf49fvPKjBe5dSfypapm6rdMfkbRCgjfkC106AGBVx04uAhZGTPZXf4azAuSghyHgsdCXMyfRSZ9nbZ9rLrmEF9i9pUkxFDwQ9HEWz/CbsUTSNcKzgPQvUyVOWImMWen3ji3r9+EM53FCPSYTrESds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LBQMEaTi; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEWKSbVBLw3ncmqtTyrw38CRhFICZnW/RfWJFsOg229jZccC5K0vwkvYgz+ik9d9hWxzOqzqeBHDmd+xQt7DRMaVElg25ptahSX40kqP/uTk9kdE1n/XXsu+oj4/NihaUn1Tcd61F6NTXy41N8mAYQ3iYWkQgF7bmTdCh49G1BNdTEY4/6LdhUdV6eAg7KwNMtEfqvqFzrRzLMnBMdli3LITgclYmOH7ZeWqQh4ZMTQy3i0H4zazxk4bnDgeCxi/vf9P5GBcKfU19lK8HWrjJG3x36R9zFV8qyiebC3RZTfBbk/5ik5kxVW96KpZlfl1yk3vpOzHSzSC9h6N3Vqfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e98enXbaWTywM17hyvp86Z3eTyXxGBbdPRvTwYsCHiI=;
 b=zDZVri3CEO94tzXya7FCzLkT+4x4EDaGyB98w9tPz8aoEUDNOFSQkD6YTA76A+TLKiYRjIwVs8E3FLTc1mKqvGqof5S0fv6k7SP0w+LEkS+qIuXWP+OLK3qnOIBBNLrTNwlVIdf6yzQcGTAh57gBA+PXac3YE2ZOCU4ZkzsHzw+S5rfbp0x03tTBl+L83HOfBzmR5PP+AoVibuS5vtGNv3rMQ+EzD407bUsBPB3OczAQQgHL9Z0RCfR0v1EY+wlM7LgvR/TAkH/HtXTTn6ejsDrfahdasSTKBCtSWVcqPxHAEHqtwxMkTIJtkdlefWwbmPM6m+9C8dUtQh8CqDvR4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e98enXbaWTywM17hyvp86Z3eTyXxGBbdPRvTwYsCHiI=;
 b=LBQMEaTi5Aq1NIxliGHfsTcwYNDMR/wg3EP3OLJU389NGXgLl70bMoqhECniyhpSEBBmWOlDHgpkSrUeTSUwzcBzR69rgdf5OvYB55SzumkuxvLQ79H+epBrML/fVgLp/xhvdvBRfqJA6BfWCrIvNfBKgIGMmZ5oGl73B+x2kDyIx6P3G0uum7TNuFlmMbCoT8FK1XbXVCq68pzmiElK6YcVcc8H4sH2eNgKsT5kdgm25cjmAwC6mIdb1bPLwURm7Erqt76jdUbiAFWO9qKQc7wB7Opyfc+Q6fzbaJENA40kNPneaPYJOxBnDdHh60F5lhzQOQmrthPUfRdt7gae4A==
Received: from MW4PR03CA0036.namprd03.prod.outlook.com (2603:10b6:303:8e::11)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 21 Apr
 2025 17:47:14 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::82) by MW4PR03CA0036.outlook.office365.com
 (2603:10b6:303:8e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 21 Apr 2025 17:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 17:47:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Apr
 2025 10:47:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 10:47:03 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Apr 2025 10:47:01 -0700
Date: Mon, 21 Apr 2025 10:47:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "mshavit@google.com"
	<mshavit@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 14/16] iommu/arm-smmu-v3: Add vsmmu_alloc impl op
Message-ID: <aAaElAdVObJdK64d@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <c5193cce7c23590b54e6d03e77fedfcb02037cef.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C09E05B9BE8BC66ACE058CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276C09E05B9BE8BC66ACE058CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe043e1-ccd0-4419-66a0-08dd80fc8c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YJQrLOC25oxXHAZwtKBcavQrYVlx51AzxBsLLA9jufrOmidqVT/q16C7XHk8?=
 =?us-ascii?Q?h3M6sUzue7rVVJk7QHHXSWi9vtZMKp1Z0Ju3yDnUeVMUl6J6UV5+n4KeqAY6?=
 =?us-ascii?Q?+3eO+6bZfNZ1u+Vc8jD+Q8GwxJ3O59s9ORUat50dfMoBH8/gnL0pz6LEqpk7?=
 =?us-ascii?Q?a9c4YpzdkcVZAr92iCarbk9JZx8Hsdu4e09+6DWZ9yDKB5OmX7DkVdTBZDc9?=
 =?us-ascii?Q?j+VVTQlh9alyP8YSD0tiOtzkdbiMsJ3mPlB26ENyblNiJ/mLknySnylzh2dQ?=
 =?us-ascii?Q?KjY5xIs8IPh6lQGg7JI8J9gkUB3hmxD79/gbsH2esSnHRcKRPpPQRpqtysXR?=
 =?us-ascii?Q?n9KBHW1XheAkrQyJPRd778y6yY6lgbFxkmAjdIjoqCGBvmk3qb94vUCptn6Q?=
 =?us-ascii?Q?V6vxf5py0brm5HVfwAe+elxOVcWm/DcJnpWzeLXvA2K8khOftEMIc/T2aTQl?=
 =?us-ascii?Q?JpISohp+MNCVMEGpH2Js/LJWm/E790elKYVrVSoQ0qjjSM0esytBBp+n1TkP?=
 =?us-ascii?Q?T+t2yJcP78weRduZMvptmX6FD1aTUAQhHOFCQzw6DaYwv/DHLz3BEJQRCLAU?=
 =?us-ascii?Q?Nx53DUOEShiBsKBIOFyaNMFvjiOg9SqwloalmOFnBTesF6SxBHLsa/CqbiiP?=
 =?us-ascii?Q?Z64mBDLMxPkKpF8693IrlAljK0Jy6ScRFhDGGf8jr1eYhS6jlv79EuaMd5ZE?=
 =?us-ascii?Q?HRksDZrvN9XcGWMcOZ/B0z9CDjkf8g/Sz+Gd/OyYjWHmMtIGm6J7kfJyPZkK?=
 =?us-ascii?Q?IEOuoLuS0KJ0VGxGlo/xTyuRh+3eH8gcHnItNfiOyscoW9wZSryfBETgZAnS?=
 =?us-ascii?Q?TIqXFvT8agVyfGMFbVIgAWG9av77QO0xOujstXkrO4rFgLvhlxgNtC0P0RIy?=
 =?us-ascii?Q?NKSAF1YOR+LozG7XiMnrgU7aMFhnDXW7QOKjkk4ac0D0nDae7dkrdtL5SG5n?=
 =?us-ascii?Q?dggOeRBJsWJmqXTj7uN143crgrwI6eTnEQuPMzVItUPPOBQGPbQr6e1figQa?=
 =?us-ascii?Q?c/uYWzvbkYAhDnhSqdLCTjryuf5puAcsoa2p5f3s/qGNq0SQ/zY9i7MxUeti?=
 =?us-ascii?Q?+HHMoOIEYnUKO3An3szBL98KRuVgR5bSNuFVPm6oDuJUkvMmaYb5+dBh637d?=
 =?us-ascii?Q?mUNP6whffeU7ReYACaQ647RraPeCcCO7xiPT/lPryQYS7AT9cY/XRcYORV/o?=
 =?us-ascii?Q?fucwZEp52yhZ1hucrMHDBFC5+jE/0UoGzDRr7OlUOjjBXukAfltZqo+XrUC9?=
 =?us-ascii?Q?vIeK7Gx6h1SfYaTZkyaZHVMuA1lw4bh6A4/hbXQ4k3dHLXo+rgHmhwuB/CSp?=
 =?us-ascii?Q?4XvPinlrLTN7a9QBSGY4ucmDrgX3DbEDg1mSgWm2H1NDoJHmrmtwxHHiBx+u?=
 =?us-ascii?Q?kV/DsjLfD4o80uf0hIGINuJ8QAKsrztDFawlc1P85ekjNez5vhHuvF26ERX7?=
 =?us-ascii?Q?xDYqNeFz0/xfcXjZ2nmb2ON8xeQEudiASCkI8qpWLmEeLH0/ulFP7bGvpVDm?=
 =?us-ascii?Q?gF3Br06ngDLBF9dOzOmUj2mjs9RFJa49s36M?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 17:47:13.1962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe043e1-ccd0-4419-66a0-08dd80fc8c72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099

On Mon, Apr 21, 2025 at 08:23:50AM +0000, Tian, Kevin wrote:
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > index 66855cae775e..aa8653af50f2 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > @@ -392,10 +392,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct
> > device *dev,
> >  		iommu_get_iommu_dev(dev, struct arm_smmu_device,
> > iommu);
> >  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> >  	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
> > -	struct arm_vsmmu *vsmmu;
> > -
> > -	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> > -		return ERR_PTR(-EOPNOTSUPP);
> > +	struct arm_vsmmu *vsmmu = NULL;
> > 
> >  	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
> >  		return ERR_PTR(-EOPNOTSUPP);
> > @@ -423,8 +420,16 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct
> > device *dev,
> >  	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
> >  		return ERR_PTR(-EOPNOTSUPP);
> > 
> > -	vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
> > -				     &arm_vsmmu_ops);
> > +	if (master->smmu->impl_ops && master->smmu->impl_ops-
> > >vsmmu_alloc)
> > +		vsmmu = master->smmu->impl_ops->vsmmu_alloc(
> > +			master->smmu, s2_parent, ictx, viommu_type,
> > user_data);
> > +	if (PTR_ERR(vsmmu) == -EOPNOTSUPP) {
> 
> did it work on standard SMMUv3 when there is no @vsmmu_alloc()
> and the variable 'vsmmu' is initialized to NULL?

You are right. We should do:

-	struct arm_vsmmu *vsmmu = NULL;
+	struct arm_vsmmu *vsmmu = ERR_PTR(-EOPNOTSUPP);

Thanks!
Nicolin

