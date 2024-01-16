Return-Path: <linux-kselftest+bounces-3074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B23482EF44
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 13:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA101C23395
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 12:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603CA1BC31;
	Tue, 16 Jan 2024 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aR9pf9wt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A71B812;
	Tue, 16 Jan 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4vD7fM+szRx2HBEA3gOsiQObdwEREWz3UBf3iHOmSxYUl5DPSt3KH7Nd4EdZdb7YW19dKBjEz2bSt6t4YGUs0HeJAjbyRC/Mewyyn9PkhxD0w26pFVdHv6/jrpCpTd3SVd8XAQ50mDxokwO9UEVFmBR3kdWjADyamdG4QIvUUGILILGJukKx9Bc/GlpzRZkO7015fnYx8c3HPA//sdepSeVbIBVPLWAb+T7wUx3IBnOlIUZYkihWnVJU8Ip61j+2eXGKyH7g+Bjv6Zw0wV2Z3OwmDubMn7mo4maVzxN/h0UEhoojY9j7TT52YqllQrKrfYyBkESJaV3eIV8ROsJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJryo901OVUYVE1iLubqTySfQ0/uh8NQafygJGsNZm8=;
 b=S5Ws1xFEkYPEegD39kyXLnTzPnOn5VKCZg2LyFA3lH7GrndvB8YOW01fZlCTnohTdLkPL41YVyWnkv2Y9carjdDNUtdeLG3qkL9B35x2Bu7zJKz4pcgUXbu4sVWyFQs713R7AhR3O+U1cN39VZRbflBlznqwleMLiIjHLV7UtyXHu+o5yBaRq/U3zVf8HiuT04IYQ1w7CgEYPnM9NBLpqxPpC/3of2qRPB6Z4IywEybUYClBDghHa8Kks+aOCTx+NFkpqc73ZJHu0DPjPf9wFnYAMw4tgLCuzcMh6YnzZTbRilqZMa0zrw3EqMOP0Sn9pHqcDeJYk1ABkfn4PIpj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJryo901OVUYVE1iLubqTySfQ0/uh8NQafygJGsNZm8=;
 b=aR9pf9wty+d5lXwclYs13Fl2SAfc6mlbk6kzoOBVpd0HoNvTKc9OtFXMxqwOb6+rWN1tJgRo8iT16Ct4xRmCsFiuxwY/gYD1jFs+vYmMJAlXrYKbSL4EJQ1lNAPtL/NblJlb/gR5U+isa+XdkV4vPPAgzRsPkCdpcKx2+GCA+57sWKFJ41ksHvRhf/nUpsV0QWFkTR9L7rQZ5W00rxvlygdyCO2t1rE8/H+G6NjivOtZjXDhNf4R3vDAE8yYyo0AySlMSrXeTVxwwVViFqm/2GvUT2NVU4lMuwRe9iKHOteWULfkTxK++bKk9hKaSZWuml3EZNgTEAaH78lhdK2P7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:6e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 12:57:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Tue, 16 Jan 2024
 12:57:57 +0000
Date: Tue, 16 Jan 2024 08:57:56 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
Subject: Re: [PATCH 3/8] iommufd: Support attach/replace hwpt per pasid
Message-ID: <20240116125756.GB734935@nvidia.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-4-yi.l.liu@intel.com>
 <20240115172430.GN734935@nvidia.com>
 <BN9PR11MB52761349DFB5DAD2797C3EBF8C732@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761349DFB5DAD2797C3EBF8C732@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:32d::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 735883be-f44a-40c7-eccb-08dc1692c351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3gaaSPlPBEOwJf3b3Drg7xHZiwXDqb4+6lSRWdi9a4/adzyjIe1ACc69BOXw06n17aHt3bqI5VmwNITxgoN72gs+Cs30Y7VkCG4QEZiN1+cHWeKLBSkzadVPVAr5pxaOQMYUMbkRIz1g6FLmrCZwPVBOHEac3iyja/N/L0gIRgOY22m5PCb3VD4V2C57q52pLYe/ukBYOTiHVSY1wl9KE1SEKaUqxU1MsJwQ3sIsF4qOiNvCSENe6jj9PVd/qA0ci957f3Mo1KEWUdarREdO4VoVYF5hhhNRGLZGz3VpXICmA64tUdJhCV5Tdo1q8QvYwTAc9orLo17eDQtZ6ZoFtCR1XPlPUSA2P0esBYaTV15wu7XbwmY3FQG2B1n1GdCzpa94YihiIfzh0ZFNGV8JEyh4K/TLXTCDfjPSkIzjGto9fj6GOHLCrm4az1IhVfksJEx9U6iPvZmv6XVaBwXz0GZfKrih9KvMnGcFZ+WxN02N1Lb3qUBijPscTaE5tKFAlVwcuBYe5IytQMZGpooj69AHHq1S5p40c1zEfXMSSBcihdxqmFxiScfU/eoCa5GMPVw/F7mhdGZDLqcMWqI9CqvcuZfYs32drgmUDla+o3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(33656002)(36756003)(41300700001)(86362001)(38100700002)(8936002)(54906003)(66946007)(6512007)(6916009)(8676002)(6506007)(316002)(6486002)(66476007)(66556008)(7416002)(83380400001)(5660300002)(4326008)(1076003)(2616005)(26005)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e3RfVj6HVioK6FxITrwVwVcwBi7kVZ5VP7w/s6APblmIXXPCUBsB8RNxdjgP?=
 =?us-ascii?Q?QFURSCFgDl6MOhNAkwjo1Tjo7Pce58ZWgA6mCG6/00z+06p/OfJ4vVR1ie3/?=
 =?us-ascii?Q?nmTRni5EgIZv/xQafFtTsp8QwPNweh1+utnbb1++74h09gEjs69Qzjp/A7qF?=
 =?us-ascii?Q?r8zGygKMJoYNF3dCjlBzp/P0y2o9+zkkPatRfXVi3i7g22WFOX90Cqrr8Zdi?=
 =?us-ascii?Q?GtZFlI4tWP9Ie4WOUlI9FpaQGEVofJgHQPjbwn+S6u7ZJ0ofe4e6wwZGEIvg?=
 =?us-ascii?Q?wl4XOX0Mxf3Q498c3IWuvaEews+qQHJB55jlqpi5kCQ2JQY2fzRDhzNGOQKr?=
 =?us-ascii?Q?XJiztz3rVYAJLyOyYD4eVYKIsQfA1UnbL9kKie2cn4yOZSfHa4VRURFBPAb2?=
 =?us-ascii?Q?gR/0tCs9+9ND0N4TKgHN869SIgjhwHU3c9Sn4qFoOUNpSv5h9uflsTlCdffo?=
 =?us-ascii?Q?9c+7FS4+xcSjxAAj/J1NH4bbo57i3znKYU+xf1yo6nzIagLWfV/aDO2MOAfX?=
 =?us-ascii?Q?1UIjsm+I1Kufh/eoceKKmvsbGe7sSsx78YUZyN2TLOHIREJEUNNPpbe0bvwT?=
 =?us-ascii?Q?a2aqzNrurxxlEWCX3x5/N9ZQX3E87G0pcfdnJ28XEzPVjbTign4j09EcSLOl?=
 =?us-ascii?Q?2LmwHApE1h9eqrrGQpu1cq84Gm61fe/sz9ogzoNjy0iFBpJwWSnkKYdzoY9D?=
 =?us-ascii?Q?KJmdhb4zkUaL8fgaeAT2gDt/x+sua2zZ1eSFUn4K5k6uu2rQTnz82nte1VI6?=
 =?us-ascii?Q?H2/a88dgyPEqOsoG+17OfpUGPVprfarBQJZ2iLWA57o3cPaQ43uIHkXN3u4/?=
 =?us-ascii?Q?bjpx7XZMTa2dFwy4BTWAmReT2DBJZxUMn1C5mutSvLRVctEvnoFcJZNYv1z7?=
 =?us-ascii?Q?hJ0QdDZkQ+low7mutC5g++Vb8q2HhjCSBPDKhgubMPwn1etU/luVtx6+J7Vo?=
 =?us-ascii?Q?QImhnGhvUHV2jg+LO/wsMi8H0qsoskXEbbBE/CmJtNPwFU2k7hntH2SVIfJW?=
 =?us-ascii?Q?A5hxEEL1JEWJJMOxTJfGUFcSVkBehRhyJxJ78+aosNlCwDBmsSlaG7C1EJMF?=
 =?us-ascii?Q?o0609ND+hdYu8BKW0ImYBzATIx6m+PHs7ssFZDQ8VbbttfVXAdxOn77DNnsR?=
 =?us-ascii?Q?nGlzpJqzIpUyQ8VO4xLxZuWD8w6Au4fXYq744YYPJr/g0F3iYnK8Li3idnF3?=
 =?us-ascii?Q?s8c1FvAiWZf4EWWm1jIq6RYbVzlCFimZE0bK+3pygA83yzPlnK0uXs9cRkRE?=
 =?us-ascii?Q?37xIrKwCfKtU9+Re+kleTzp2m4KJpt6YaAsZ8m/Qw5EMdduGHjx/tunlPr1v?=
 =?us-ascii?Q?uA1ylgDcdwBNZay0ERuPTyXRZbAXl52UUPKEi0/UrAB9XI229tyCtZOBF8/S?=
 =?us-ascii?Q?045LdncVA42kYSLhhliYIoFLYX1YdnfXh+H0I1zqGYPAGrugVQPSxo7+zTqF?=
 =?us-ascii?Q?aq5ka6dBYUFjun9Tk63Bc0l8g8NA50X6EhsGBiR7B6BQsapBv3Iek094Kyr3?=
 =?us-ascii?Q?NxcA2sDc8V1b4tgV/HpM/zBZOTyn/sSCW2hoXSNtY6za+lmXxCIcjj8AcTLu?=
 =?us-ascii?Q?45/FeXWv6jd1GrlmIKXcZ0mC9mYElcdEL9l6Uvvf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735883be-f44a-40c7-eccb-08dc1692c351
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 12:57:57.9065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTmoybUVVfN2aQOnQMJXuKDbxgQwWILi4HvodTF1VpLHhZ8sCaRbw3aZiZovvFIL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018

On Tue, Jan 16, 2024 at 01:18:12AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, January 16, 2024 1:25 AM
> > 
> > On Sun, Nov 26, 2023 at 10:34:23PM -0800, Yi Liu wrote:
> > > +/**
> > > + * iommufd_device_pasid_detach - Disconnect a {device, pasid} to an
> > iommu_domain
> > > + * @idev: device to detach
> > > + * @pasid: pasid to detach
> > > + *
> > > + * Undo iommufd_device_pasid_attach(). This disconnects the idev/pasid
> > from
> > > + * the previously attached pt_id.
> > > + */
> > > +void iommufd_device_pasid_detach(struct iommufd_device *idev, u32
> > pasid)
> > > +{
> > > +	struct iommufd_hw_pagetable *hwpt;
> > > +
> > > +	hwpt = xa_load(&idev->pasid_hwpts, pasid);
> > > +	if (!hwpt)
> > > +		return;
> > > +	xa_erase(&idev->pasid_hwpts, pasid);
> > > +	iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
> > > +	iommufd_hw_pagetable_put(idev->ictx, hwpt);
> > > +}
> > 
> > None of this xarray stuff looks locked properly
> > 
> 
> I had an impression from past discussions that the caller should not
> race attach/detach/replace on same device or pasid, otherwise it is
> already a problem in a higher level.

I thought that was just at the iommu layer? We want VFIO to do the
same? Then why do we need the dual xarrays?

Still, it looks really wrong to have code like this, we don't need to
- it can be locked properly, it isn't a performance path..

> and the original intention of the group lock was to ensure all devices
> in the group have a same view. Not exactly to guard concurrent
> attach/detach.

We don't have a group lock here, this is in iommufd.

Use the xarray lock..

eg 

hwpt = xa_erase(&idev->pasid_hwpts, pasid);
if (WARN_ON(!hwpt))
   return

xa_erase is atomic.

Jason

