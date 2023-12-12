Return-Path: <linux-kselftest+bounces-1708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0927380F67D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C81E1C20A89
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 19:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8363C81E3B;
	Tue, 12 Dec 2023 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y3EiW9bO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C909F;
	Tue, 12 Dec 2023 11:21:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6X859voliJfChrWaCn3TlmV9BlwHyGKQsTNFwiJSw7Gu+5bV9+2y74y13+6ZPJlaF5ERKjxUURLiEMlQldpmaYG9kPVr+tNvdCUtOVZini4f2atX2vu6nAxEo2flNydPgwn79f+kwVInrAAoTCWIUXys2BMncLx0YJKQdU9yf+6A1EtV+IS71R1JqqkCxp3wV4dD7elT63r1CiO28z9SPS9Vw3M+d/mOAXHInE6exmNTob0r2oNjL1prZM986coh+5iAa2vLF8Cx6D1n+mvT2BpsCgxNpWbmNABn8xwq1l/aXCKAjGtnQ+zAl01/4GzZQ/GoTP0MB/kNRRk6V1SEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vvaH62ZuLn29zoShfj2213HgEBdguv0Lpw5AY6dsjs=;
 b=UnD24DjiMQPfRlfSBNdmFuL1205yTG00DPE06VUpzeT+qYb6yjkS2bZLtXenGKLo5mNCZ99xgxcIa9Ulo0pqiojEKrz27Gww1DqjmCFsk7FZbHIh2HmsHmpMj37EHSZ61ZJ6YXN1lXeiAVY3GT1ZcpB+jDGK3NRAYBThtcBCHVwLDnmHbrA6Qt8zHe5jYMyMLoL12F5rV2GuCHQbeaKSlxI4GKhZwzdwe0qbCjs6oY0gW3yamUiatwUJVcQwiHTL4FRJQQYk5sqYagvdpwXMheQW7ktxG0KY+ju+AcI9nbFdxZejnWuevhZSjutu+8QW1AINtrkemvf3WNN2xzEINQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vvaH62ZuLn29zoShfj2213HgEBdguv0Lpw5AY6dsjs=;
 b=Y3EiW9bOWDwmzgaz34K4MSBanrRYh/3+ndtGBhqmW/fVfSoXPKPVpcVm/Dyw2prXqd1BVkiYdkA7EXyq6KKq3oOir2vHv/mTjXKfwlSBi1Qtc1AEx5MVQbVOnUMoWS5rHufInUhgkxNjP9UQkS0Sz3H8Z1qTAVUk8KUHpOV+YeMkdRYlIgNKRNhHOf7Rj4g3tmUEemC+JkZLUiAib+kJsZ+HJhCez/ttOFXvLPL5w9XmoCHXXAB5yLXtxAkSrKDtvCcLtSkTddPxLniaWZ2vFOi+IP5mV+GfMUxM1u4BjZIxNeBUfhv/Ap6h548qLDBcsuH6v+PUul7sWMDBcx7Ubw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 19:21:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 19:21:01 +0000
Date: Tue, 12 Dec 2023 15:21:00 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, "Giani, Dhaval" <Dhaval.Giani@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
	peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com, xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Message-ID: <20231212192100.GP3014157@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <ZXd+1UVrcAQePjnD@Asurada-Nvidia>
 <20231211215738.GB3014157@nvidia.com>
 <ZXgL+GCGPgH+hlXo@Asurada-Nvidia>
 <20231212144421.GH3014157@nvidia.com>
 <ZXiw4XK/1+ZdsFV1@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXiw4XK/1+ZdsFV1@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:208:fc::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c5dc20-3c2e-49e4-89b9-08dbfb477a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wULEmtN+I3GhVpnYMx/1C5nW0AeB70eC4Z3WVGS0uah0ASy7+xWaGOtEem6mhuJJ/c1IRPOs740NVncNofkEocpMsusIaPVbZLLUszEWyRQCK0co2tpJiw193JKqhhB402azSO2IbVHzFaEo8gkTCleQbQ801TLBmXwaxGQ0H8DpScU+at80W5WE2oRSWUPgX4BqagLa4K1FasydxHy37J0UKM/1WKWx/M+67YyU5DbExPHQb3Tlc+oOJUJwfZK+GjbuIkWV5E1UVH1SWq3BHePkOShPJWnIcnX3CaO8QX4002xFf9YKS7CKC0jfVmsRIOJ0U5OP/rD7uaRkubq2FzGzdwqIseloosnSiRXExECgwWJBBUzn8Cchd5KO2ZVStbnSIEF/TvN5p7mheYLnFZOUmzA+oDm+mjdEOhkTau17hiEM8DVPHsMdAIbRLM5Z+uUmL3pzu2FJ8c9Q7iMlkm+pRmAPF4+mhumB7TgZB3pXta5uMdEeh1ZIDzPxCbiGOpu7yVo+ji+sRtFw+DppeKQ3TvIggrJ4/sxLCexuCcuwsulLS35ht/+1DqOWiw6w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(2616005)(1076003)(26005)(83380400001)(33656002)(36756003)(38100700002)(5660300002)(8676002)(316002)(8936002)(6862004)(4326008)(2906002)(7416002)(86362001)(6512007)(6506007)(6636002)(66476007)(54906003)(66556008)(66946007)(37006003)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIgobnsPTqBMGevWjo84aIsBHHRgXmjbWZuMQjHHXmhX5FmQvr+n+cDMNEs9?=
 =?us-ascii?Q?NGy9mC5gzUkLk/aPrid9yR7aYAWxtavfFds9wrtsw8OMxjayqS958UyvmBds?=
 =?us-ascii?Q?K0yfTwNzRM1C7ZZho4hUWr5hNS5QqG4kTGhmik5p6d+HOFGFOXF+dnCfYKwA?=
 =?us-ascii?Q?0CnGELzF0ODcxOohwTZjxBS0pongC+xklF0ffxAkmD+PSP/BIurT6IAnf9xZ?=
 =?us-ascii?Q?k27Oe4YNr1SzoeILUqnVaIqtYqRYMT/QZnlFtZLGmxe+Vi6UtEQz+y0SkUOi?=
 =?us-ascii?Q?Gq4lQXWqdhb6aO+gxo5WEAPgxQl9XJzgTtyOcO/THfnc7/FZbUsrPiayDIOm?=
 =?us-ascii?Q?mzImkidN4RaTVyhXLytMZj4sydr6jXZZUtootPj8VMnmJS/pSNWlAobXvfHm?=
 =?us-ascii?Q?qtj+4VSLMkJ1ENAcXUL1nCCPr75NfOgdpjPemyW08Uhn+XolaOyLXZaswjFx?=
 =?us-ascii?Q?hRma5mP159RlJpagByPyfBCClYJKLM9ajqK2UC/w9bzK22IgQ93X1ao91z6Q?=
 =?us-ascii?Q?fRCZRdh4mRVr50TqvjP5v+JE1tVLBBQj3tnRCem7n0OdZWT3OSMPugdZmtbc?=
 =?us-ascii?Q?VXUlwGbHgCiwIUTYKws7GWhfmdE38yQ2IXWhoK5cC9JAB0nGNzulWjtq6klw?=
 =?us-ascii?Q?B/6CXzdm587h5AFG79Z7sF+mBk+Af6q54MiKqTUH3mxBFVhvFgci7fwYAx3/?=
 =?us-ascii?Q?k9/yjkehgncbaY6Mq/YmbtzmHy1rvIJOpA0kEBeGaQbCcynA1faURSSBVgd0?=
 =?us-ascii?Q?wd3q78XU8E8BScG9iqQvhHp8XBWAVYuH+9pYDLSYe3NZBhyNrRmof91nk2AM?=
 =?us-ascii?Q?n8V7cH4+QY9Gje8Ijd3cPbznXL9RPi6/gabnTboYJI+dv3I7QbjDuXMSWlF1?=
 =?us-ascii?Q?cTOIkYOiUgVByRk30r0HiAimElsbVFtfkgyB/sKhLxFxhrN4d58Jw8Tp17yB?=
 =?us-ascii?Q?RNkEb38NpGEVP61CLhY7xOcToOV0tnFffqa0r0ifN6mXlHb56zQKukUGuKwd?=
 =?us-ascii?Q?S9+g/x1pU7SuGYfI+SmT8Rr2SbhObCI9m11sZDZVr+/Gd59PPCaJMWIXVYKK?=
 =?us-ascii?Q?TrWJWUq2NlHgn7An033pEeCNS1tP/3QJT02rOjpyaKL4pRktZj+tT0OSzNSz?=
 =?us-ascii?Q?lEdQdEw+LKaWz1PXd2Du4qID4Lt88Mlma29ZNkMSAaQ+wwI9mQ1XGB+4Dacp?=
 =?us-ascii?Q?f4eF+07XDkMgVHkP7xDf1e9j5Y3TkLkjtti2Mc/5SHHPSyB672frsyD7Cb0o?=
 =?us-ascii?Q?mNObj4gK2Q4KkJiAyHoY/ql23cPsz0fi3uFGldiJvxkE6pHGRd2VNmULzLTS?=
 =?us-ascii?Q?DX3D7Q/PmIZ4BKBUgPUn4SHry3Q1a60Sc4DrfAUOBxkrKelPNDou519AfL6j?=
 =?us-ascii?Q?n66aSamAM2nmNu7qVnRgUvzklkh9Q5/w58up0sq1saL2YknAD/qz4uQslyja?=
 =?us-ascii?Q?O9E38eBQ91bLHsrysfH6fNGDWRwhZqTvPjFGWZx3SZAlj7jA7B/M7SN10OE1?=
 =?us-ascii?Q?kU/fhF7LwykrBEHtFfRS3sP1yvaWP7BBzj/5YT3NkhFgx1dm8U3odyn8er6A?=
 =?us-ascii?Q?9cT54JdMgaxSE7WJANwPz2j/RRi6U9GSE4JHbVA6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c5dc20-3c2e-49e4-89b9-08dbfb477a25
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:21:01.5403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47I/lRRI5uDYpHc31hPszL2x0ZOfp8uTIKW+kB05eNeuHcYTepMDT3zaYNv/22KQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125

On Tue, Dec 12, 2023 at 11:13:37AM -0800, Nicolin Chen wrote:
> On Tue, Dec 12, 2023 at 10:44:21AM -0400, Jason Gunthorpe wrote:
> > On Mon, Dec 11, 2023 at 11:30:00PM -0800, Nicolin Chen wrote:
> > 
> > > > > Could the structure just look like this?
> > > > > struct iommu_dev_assign_virtual_id {
> > > > >        __u32 size;
> > > > >        __u32 dev_id;
> > > > >        __u32 id_type;
> > > > >        __u32 id;
> > > > > };
> > > > 
> > > > It needs to take in the viommu_id also, and I'd make the id 64 bits
> > > > just for good luck.
> > > 
> > > What is viommu_id required for in this context? I thought we
> > > already know which SMMU instance to issue commands via dev_id?
> > 
> > The viommu_id would be the container that holds the xarray that maps
> > the vRID to pRID
> > 
> > Logically we could have multiple mappings per iommufd as we could have
> > multiple iommu instances working here.
> 
> I see. This is the object to hold a shared stage-2 HWPT/domain then.

It could be done like that, yes. I wasn't thinking about linking the
stage two so tightly but perhaps? If we can avoid putting the hwpt
here that might be more general.

> // iommufd_private.h
> 
> enum iommufd_object_type {
> 	...
> +	IOMMUFD_OBJ_VIOMMU,
> 	...
> };
> 
> +struct iommufd_viommu {
> +	struct iommufd_object obj;
> +	struct iommufd_hwpt_paging *hwpt;
> +	struct xarray devices;
> +};
> 
> struct iommufd_hwpt_paging hwpt {
> 	...
> +	struct list_head viommu_list;
> 	...
> };

I'd probably first try to go backwards and link the hwpt to the
viommu.

> struct iommufd_group {
> 	...
> +	struct iommufd_viommu *viommu; // should we attach to viommu instead of hwpt?
> 	...
> };

No. Attach is a statement of translation so you still attach to the HWPT.

 
> Question to finalize how we maps vRID-pRID in the xarray:
> how should IOMMUFD_DEV_INVALIDATE work? The ioctl structure has
> a dev_id and a list of commands that belongs to the device. So,
> it forwards the struct device pointer to the driver along with
> the commands. Then, doesn't the driver already know the pRID 
> from the dev pointer without looking up a vRID-pRID table?

The first version of DEV_INVALIDATE should have no xarray. The
invalidate commands are stripped of the SID and executed on the given
dev_id period. VMM splits up the invalidate command list.

The second version maybe we have the xarray, or maybe we just push the
xarray to the eventual viommu series.

> struct iommu_hwpt_alloc {
> 	...
> +	__u32 viommu_id;
> };
> 
> +enum iommu_dev_virtual_id_type {
> +	IOMMU_DEV_VIRTUAL_ID_TYPE_AMD_VIOMMU_DID, // not sure how this fits the xarray in viommu obj.
> +	IOMMU_DEV_VIRTUAL_ID_TYPE_AMD_VIOMMU_RID,

It is just DID. In both cases the ID is the index to the "STE" radix
tree, whatever the driver happens to call it.

> Then, I think that we also need an iommu_viommu_alloc structure
> and ioctl to allocate an object, and that VMM should know if it
> needs to allocate multiple viommu objects -- this probably needs
> the hw_info ioctl to return a piommu_id so VMM gets the list of
> piommus from the attached devices?

Yes and yes

> Another question, introducing the viommu obj complicates things
> a lot. Do we want it to come with iommu_dev_assign_virtual_id,
> or maybe put in a later series? We could stage the xarray in the
> iommu_hwpt_paging struct for now, so a single-IOMMU system could
> still work with that.

All this would be in its own series to enable HW accelerated viommu
support on ARM & AMD as we've been doing so far.

I imagine it after we get the basic invalidation done

> > > And should we rename the "cache_invalidate_user"? Would VT-d
> > > still uses it for device cache?
> > 
> > I think vt-d will not implement it
> 
> Then should we "s/cache_invalidate_user/iotlb_sync_user"?

I think cache_invalidate is still a fine name.. vt-d will generate ATC
invalidations under that function too.

Jason

