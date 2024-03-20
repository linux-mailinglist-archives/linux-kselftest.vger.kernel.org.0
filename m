Return-Path: <linux-kselftest+bounces-6450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA638811BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 13:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E98285D19
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 12:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7D53FE20;
	Wed, 20 Mar 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G0TcdP2N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359493D0C6;
	Wed, 20 Mar 2024 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938292; cv=fail; b=SArYNEfOipHMl/NA4EB/DZ8fR4LueSb3rPICNwc8H+925Q1HqOCqMzhjBvhNFl2PdfsBWxUfA44zZ9Avk+jPZiztfv376n1QDC901Ga2LU0huetFisyispEsCNZ42Jc30j9o4mKcDR4PYM9R/eigjweqX5FHCHP46K7J+O6VQNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938292; c=relaxed/simple;
	bh=C0kBFmVUujqE12/oEPIgYkZL64YrA4LQZOg/So6OUSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a2G3EJ01IWXfBx7g/1yzbdToKVa6GQdxcvMfmimDN9jsxvDFoeDXfGbsCubiVV5NjRP/aS1TqjgrOoHH3XzITofRnR2SJ3t8jcTCJMxudoB4K2y9o5GjfP+CAV9Hy3yX0+1I/OjhQeuKvdHAferLBlN9UTmVb6tQ9+TSAqEElyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G0TcdP2N; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SccO8RquxielaDe66sX3Sg2JZoutQSDrSDejbDwyA5DlPdnJBDRNS337yOZmngCnqtLRKaTESGzvOPSyA1Oc4vgbqvAco3pVQmZZQN8X0ffsnJhLNscfYwzYbIuTrvZX9evEvNW6z42yF1mfwMfzfmbwEixITCW4cyOTy7oNuJC0BWbdJ5iLZo+wn+EBzHrYx/MOLJLrtuzlFgTBJJprRsEjvsyiSkJ2wIFlOJMpJVdlIawMJ9JFqCux8JmlxHPKo5Kz6ELvXI1RSSO//Nxu3TbTCdzOC0+6Zrz7VxzKwrpTVBCqUwo5s7BGI80IpkAt4ZBMq24CaTQ5dTFQjedEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tbl8ZLN1yhsCNubCrNcVTxdgSTn2XynH/s3BLtUMZL0=;
 b=NDgO4i4nfKdZGFTEww58zTHIkDi902WsWkjkByjblT+nOd0+Y6K2gbO9+uj22g0ckUQvQJ+jsDVkQeSN1d8VFjxFpTlq6EH+tWC9t4tWIJHAdvJmZE6nbv0uooqIuhSBWWiN3rMrm0YRjFebPzdnLP6B+8I0fQk/HhXSU/+rg3SODNl6VO98GyCFT9kL0gHkZlUU+4QdizZKE+fMJrzkrrgpi/fdOVCvCOAzKPVtl5Ui4MwBYFsLJ5zz9lnJNp44/nNJqiJziYNiBoN6zxaLKyslKB6+wIET4zU7l3DQVr3cWHCq+SWbJ7Thiaj73xncR3Zr1Gf/rMoqSXrcEtHSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tbl8ZLN1yhsCNubCrNcVTxdgSTn2XynH/s3BLtUMZL0=;
 b=G0TcdP2N5QYiojFybUm9XJKEWwQ1xFlmYN22vQqG5Jk3EM+PhB3z+N0sJkMkeIJ6Pe4cywlG7jDa4HAs+TGQldS3ygs3uSSEeq7vccAEFVLEAsoavfO8Resyd4GAuwvHgAp7VuRgHTfHqBvJLDPVCsrVUBhKomXEJXdHqNW0jswkUT8z4C2LA95dKpee+5Xa9MlcoHOca4Nv2l64DdicuqmG/Irqtl4rqz77PXnH+FL733f4rWNKqb6afrsUKoTCbQLN8al4WdL0dW0rPl1Xc2TJ5fWcpddgOqiUCHyZMvMSZ9xK80v+t1KWXroLs+53j3xKB47zMSiwqaznow49vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 12:38:05 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 12:38:05 +0000
Date: Wed, 20 Mar 2024 09:38:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Message-ID: <20240320123803.GD159172@nvidia.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-2-yi.l.liu@intel.com>
 <20240115171950.GL734935@nvidia.com>
 <c831bf5e-f623-402d-9347-8718987d1610@intel.com>
 <BN9PR11MB52766161477C2540969C83568C242@BN9PR11MB5276.namprd11.prod.outlook.com>
 <585423de-9173-4c97-b596-71e1564d8b4e@intel.com>
 <87a2be0d-6a24-4ca8-be30-35287072dda4@linux.intel.com>
 <749b23c7-ab0e-42b4-9992-e1867fc7d4d7@intel.com>
 <20240318165247.GD5825@nvidia.com>
 <13645a9f-239a-46c9-bde2-a1d5c365df4f@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13645a9f-239a-46c9-bde2-a1d5c365df4f@intel.com>
X-ClientProxiedBy: SN6PR01CA0001.prod.exchangelabs.com (2603:10b6:805:b6::14)
 To DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 856eba72-1522-4cc5-aa03-08dc48da9714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KFSDDL1W9WD4KbCuiaZsa4zY6FMmxx631pL4iOkJmJ4GGhHZP0tMcTFLpS8LeMINsDW7taGkea7y0aEVj8nZTBOmpEYH07YzltuICoke4Ws/ehqOiYqVsc38RaG9GCDwqUIwe4Eck7GoedJIQ3uj6VVQOnp1qBWAfBdwgABRAfc5y1SJifn0cfmBllK+EFU8IbH8+J9KUpVa4ASXNMzd6yHsxxxUxM6tgjBj6Bxg2g18kHxx4jWAqgqpU2LEc8NydGO0XvEHqAuO5hiMF4f4waemwEXNQ3IWJHcXWups1qER2pA5dq7H3SyftZY9d21dAgl3tg0czVM3uuyKaCeawuyfshkE7aEvytdThI2Pwr5JwlAesBAEgeO4pLnJjIB5ThD8fLDWjdGfLpK5jXhBAdvqu1sS1eVr3FfkrxBphyvjpQ2G8P/KDlQjOS1+2F47xAHLUn8JvptGkMEOz5qMHH35RVpxLReRL7cWSET3ooIuQdtnIny5t3ns6cvgvNtozGLQmVhsmcCRKFUVJ3ql31ooHstd2mzW05sCHKQliEZAZnwX7Ve/tMmo5JonUbl5DKcIK/xaHlMtiJt2YyxFYHGoEX+KbRVWnnojZU3EtnzdXytLhtYH/YnZZXZoYKZkkp4P1NXueY5akvG0UwBfc2CyC72d8kNLNJ7E5uqkSkA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kv2566qIvFfA0bzgsPQTNIldLhaR5vK2reuSvB5YmD7vf14O0TEEtlHBa0xj?=
 =?us-ascii?Q?jK58aQ0f/aKzwe571jCQ9ijuxL5qf85LDZ4lDqLue2OMzzfKDcQvk8RqlOGL?=
 =?us-ascii?Q?p699nniQP1gIfoUd0S7F6gsIFbv2ORgd3nhc5jwGraNFDgfm3j2n56Ay7VuS?=
 =?us-ascii?Q?QDwETJgA9/JogrvygyIdPaDGj4/rPaxsskGggTMaueOsHvG8+nvC81Jzbxwv?=
 =?us-ascii?Q?n4OffIqsHcKOE1tI28G8CdGNFgEYv2sWDFGE4Df+XqCekE5JsrOlO9ukiasc?=
 =?us-ascii?Q?AHCoOCYLRT5BzGiHjtMPaOEFfEiE3qUXfWbuC/LW9sAvwiVBxhPAoJWemGa0?=
 =?us-ascii?Q?Mc7OFWE6MKH8SEApdjsFOwbjJKFYNCRg/0mARloxDygbTt5TL3P4SLAbMAZR?=
 =?us-ascii?Q?SUD16GfooS5tL4pV7xvnRZj9890sevllh+OHmD1HJy8R5hMrk5ytck0g+0dN?=
 =?us-ascii?Q?DTSRqhuGlBZIh/nYVdbiuSzVkxmkOosCBkoWknjKJIuD+za1+tGk2xLVT+uD?=
 =?us-ascii?Q?6qJG4f/opyA7VG45EkJWKQhWE6cFIpvTbGqwaeRzhHLUZ59loLSc4gxB+KK/?=
 =?us-ascii?Q?w3RscHejAhDMnMixwlS+wOcUmxMHWPHxfBul1rm85Xi+DuzL4iCKDdT4hVWy?=
 =?us-ascii?Q?tvLWPYCJG7gJORDDRbBu/WsU0vqrQWkBGxpKJKoKZz7iIpXR+u5I9Bob10gb?=
 =?us-ascii?Q?8Ju/ewT3Kp/j7/KInUW0e5UrWYNTNq8EMqL3y7PMo0R+cRe4XLWj5Vp1X0pM?=
 =?us-ascii?Q?lChqhwwSQVqXX5toF83aVMYy6NvlL7QPt2XWoeKHEGSbqMjd61PiRkHLs/I9?=
 =?us-ascii?Q?Z6Msxem/qPj7iWXwCBzOX7qzFyqPwPlCqBGN52Ir/DChGrhCJIe8TFHugxXO?=
 =?us-ascii?Q?oVhMqkdQo06mthrMQ1OmLTW+W9+mlHzj3HYSVan77y/gZxmnQTYSgN5p4FsJ?=
 =?us-ascii?Q?L9CyW3azRd4Ps+t5MhcV/9y7BHthYcn/+Z2J9K/yDGdvKOb+hoMXwb6VCuSW?=
 =?us-ascii?Q?/UZDHxcRXxuQ4o+yiACL55YiK+Y9sd6rcWq36ZtSzfm6itr6LQlQZlcEr8T3?=
 =?us-ascii?Q?2xWAlERX48JF4rA1Bx3WLI3R905qUtaKCzXR6+/b+F8+MZc/Z+u5DUpVKfFq?=
 =?us-ascii?Q?aBb9ho02ZwFjekWxjP9a5yb6ODXj6IMPmf2ATlhe7qQQ57zbBek3buGBGBFm?=
 =?us-ascii?Q?AoqCow/pxnl9SZwZGhmpcZoFEQFzzhxwJFYdDb3MzKTfc2LgbKGKo8vLzhbi?=
 =?us-ascii?Q?vFiqQnc5qtaAMDSa5DT4VNG0+Rv8gO/kTyzoOgupwnn0JrN8zQ6qjzVcoSrM?=
 =?us-ascii?Q?JsOQAew1vxwFbGcekxz6G1Qt5dzrXD3tbEwSom4JbAADJY2hFTQXYPLvK2Qt?=
 =?us-ascii?Q?o/EKCv+IK5qElhB06eiIXEvTqJKSaNFPdb06vbMo4HYA1y6prl9+xEmtkm+J?=
 =?us-ascii?Q?fpOfKQ9wCbmKBignl0YNqmcTSGhWCrQv2dQ74sPWjS+67w0wvvB9lLt2LBXO?=
 =?us-ascii?Q?ZnYL654zoqxADMuZAARJhtojKSSOabR+syQiUH38Qad5ij7I5ILEss2PDmhF?=
 =?us-ascii?Q?o0x3Yjb2++Gies5soS9eaEksn9a32CCC60K+c9cp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856eba72-1522-4cc5-aa03-08dc48da9714
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 12:38:05.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xnpicaq+m6RI9bUTgbZo4uwLKrzj+vQHLvHwFLNVpCiNtrO0IFAPsjoNUPJR6+vB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415

On Tue, Mar 19, 2024 at 03:29:39PM +0800, Yi Liu wrote:
> On 2024/3/19 00:52, Jason Gunthorpe wrote:
> > On Wed, Mar 13, 2024 at 04:11:41PM +0800, Yi Liu wrote:
> > 
> > > yes. how about your opinion? @Jason. I noticed the set_dev_pasid callback
> > > and pasid_array update is under the group->lock, so update it should be
> > > fine to adjust the order to update pasid_array after set_dev_pasid returns.
> > 
> > Yes, it makes some sense
> > 
> > But, also I would like it very much if we just have the core pass in
> > the actual old domain as a an addition function argument.
> 
> ok, this works too. For normal attach, just pass in a NULL old domain.
> 
> > I think we have some small mistakes in multi-device group error
> > unwinding for remove because the global xarray can't isn't actually
> > going to be correct in all scenarios.
> 
> do you mean the __iommu_remove_group_pasid() call in the below function?
> Currently, it is called when __iommu_set_group_pasid() failed. However,
> __iommu_set_group_pasid() may need to do remove itself when error happens,
> so the helper can be more self-contained. Or you mean something else?

Yes..

> int iommu_attach_device_pasid(struct iommu_domain *domain,
> 			      struct device *dev, ioasid_t pasid)
> {
> 	/* Caller must be a probed driver on dev */
> 	struct iommu_group *group = dev->iommu_group;
> 	void *curr;
> 	int ret;
> 
> 	if (!domain->ops->set_dev_pasid)
> 		return -EOPNOTSUPP;
> 
> 	if (!group)
> 		return -ENODEV;
> 
> 	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
> 		return -EINVAL;
> 
> 	mutex_lock(&group->mutex);
> 	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
> 	if (curr) {
> 		ret = xa_err(curr) ? : -EBUSY;
> 		goto out_unlock;
> 	}
> 
> 	ret = __iommu_set_group_pasid(domain, group, pasid);

So here we have the xa set to the new domain

> 	if (ret) {
> 		__iommu_remove_group_pasid(group, pasid);

And here we still have it set to the new domain even though some of
the devices within the group failed to attach. The logic needs to be
more like the main domain attach path where iterate and then undo only
what we did

And the whole thing is easier to reason about if an input argument
specifies the current attached domain instead of having the driver
read it from the xarray.

Jason

