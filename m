Return-Path: <linux-kselftest+bounces-1823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 812AF811138
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 13:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFF21F21251
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 12:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBA628E26;
	Wed, 13 Dec 2023 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rKvc4XW2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5023A4;
	Wed, 13 Dec 2023 04:40:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKyHZok/6BBQdFuLD1yj7TgVfozWm3mkNQeE0I2RDsRnkwFe7FLKXR69KcgdIy/vPBE1k8mNzNqBZ30ywCyXBQZzm1YQLpsMyBpHHJ3MhFcc5uCVezSnFZtTxxDdv2uDvQf0MGghYALnLp+pA5goLlhuZZmJaFMsgzYg06NDlAWEX2T2qK3ivg83UUqrLOQgp+wJJ4KgVHjAegz64JYcwegIC467iR5pIGSMp0vdkVqZw8CrO7tKlMV3osICCQ8G20QHeD0vEhh/4OXox16p5nWu5H6wizCdOoxUUflYwOOGgfX5GG/Nem8KR2vrSLAoOcVbm2S7EoIykFHQYzwkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLZ9xL0QBzJC9MFJO8xOvCsmbSFc84iCKEN6UgVS4D4=;
 b=m1tYOv4TjuE8Eh9z81lHCCSPSZaHPygdVbS1V4VOKye4mdeGKbN13Yx6sBxkaOn8QPScln6htELv6fnXnb3dWpbVTc4CU/dCcw8NjEgOK09xmoyu8FCNJN1vpoXdM1/5woQ8lY72e01aJTFQGuX5Mh8DenzmGUvXhV/a5EIVFHDDPxQ6uJsCUBNwq9bm/BYWcn30X3UMFdfHrLdW3rT/9CRvIxP5GwMEWROeSgnK4E/bQH0jtAPwCwR5MpbHUhDBJUknvH00U1sB01xtVU1+lUwxEytFzNMxpEcpqhbBjovOszw/bDp7/LzXx21Q2frQ6kHfAHi434LNmcqpW75Plw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLZ9xL0QBzJC9MFJO8xOvCsmbSFc84iCKEN6UgVS4D4=;
 b=rKvc4XW2LtoE+xbV6sec5TAhlU79fyPd3RRj4+12gEyeRigloniFPsBZ77fz6w83QWa2b4aY19jc2EL015rMIQM04LMRafuUGcriqX+3/lAbXU/MxUwLlS+I5umjQnlkxRuyrMjqhgnv+JIBWVwhswmAM0jmoCb10xSJxWi+zPqGk9rFSCJyhJJmoodM5YtmoguY1HhBp0QCkGp2SfuiXPZTvgJvVWrt3WKHpwj2fhyPr0tseVALsSbEqLQ7UNW3+1st1XrLlUjuJJ7ikzJCJZoCd2wWlqbXHOB3DSkj0sDDDTzioleZivpn+soidwYGwgW8Q6V0L4gY12806PCkDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4924.namprd12.prod.outlook.com (2603:10b6:610:6b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 12:40:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 12:40:55 +0000
Date: Wed, 13 Dec 2023 08:40:55 -0400
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
Message-ID: <20231213124055.GR3014157@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <ZXd+1UVrcAQePjnD@Asurada-Nvidia>
 <20231211215738.GB3014157@nvidia.com>
 <ZXgL+GCGPgH+hlXo@Asurada-Nvidia>
 <20231212144421.GH3014157@nvidia.com>
 <ZXiw4XK/1+ZdsFV1@Asurada-Nvidia>
 <20231212192100.GP3014157@nvidia.com>
 <ZXi9FaPSkHkCm679@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXi9FaPSkHkCm679@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:208:237::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: 01698e76-3d79-407e-a39f-08dbfbd8c01c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dEvGwPxqIQaKgWXd0PArWb+cjxeuY6h0ldpJH9bagYN3wYfE/+j709gZZEqyppxAWb8+L6dGW2VgAL0fYdRp/UC32B/6zJSlpBLtiV2F98Oe7mBRhPJQ7PSAOygFqckY1q9IDgY1RXMB5JNIgtg1/z7K6F3qapXseWuEAD+q0V3JnZyHQZNeMRKj+uuYmF7E0cXgcS68SnMbX6yjSq8f/pws5frC8yFWOe3nziGpOi7F2LvmR6HRbXWIfzQbobuuFAVo2qQnkRRyUQ1C2Wxqo7tLywamTI7jUcrFY/atdrP5edIJEP0WeflS15C/w3zTpjNjxU5/NaQOgle1/mrco9ICfM+cxzPGaKYAbh6Uiy+oOq24dhfJcyF9oBl95lf5T5G882vEC36qvZTcBlzUiZlQluMciroYlVTuTzm1X4MmPs2MQYVV4s0k4FUSl9Cs+5P40pKjXYJuwq+9kGwDaIW0IlWQHharrK342AJG5xsowQbKE0/3B9hIv/EkUHOuJe8+MFNYCSVtardqr1nHGDGo8JGQ4wMI6OEYz1QyhBFxRorD4tfIaQN7yKcnOGxZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(1076003)(2616005)(26005)(6506007)(6512007)(83380400001)(8676002)(5660300002)(7416002)(4326008)(6862004)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(6636002)(66556008)(66946007)(37006003)(66476007)(54906003)(33656002)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DP2bR4cgeaC2N5S9MH2gujs1q8t3CEpnDRUEWsvlsANWtVcnuGY9mGe6XOWy?=
 =?us-ascii?Q?LHjtE0p0ryXsPCuD1T0dk6Z+KD1jVUlUvk5Zg+/9bsqqqg6DRcQq4B1pQZnF?=
 =?us-ascii?Q?MER8gBBkqe24Q/wK8XYIccsyu04DNE/arUMhWR7TMZHaHe/Zv3C1ydC8+rHM?=
 =?us-ascii?Q?G3UMXi2YHvTb7RnQVbJacD4RfbKeiqiymVWyIX2Rvrpg9vVPKI50L34n/Z1Z?=
 =?us-ascii?Q?e21jkRLBRyx/2jw1sx7YJE5/J8qm58xaW9XHhnBadBWl0ARjmTBNX16n0uKh?=
 =?us-ascii?Q?/bUHz58HMHSIHTcbcuHEYJcSVkL5hWVI8/o7uP5SzTsYrkF2HsObiJcYVVU4?=
 =?us-ascii?Q?AdG1wY1G02YzHdNk8nWT6a2Ev0GxJBf7rsxk4C02To2x6WdbLf6n/Lg6cphe?=
 =?us-ascii?Q?FEBtZeQOXuyhcZV/ROdxGWZ4LdJ9ad+hquROvg1TUTNKfxbAtP3TzekhP95f?=
 =?us-ascii?Q?cH5Um+6StEr6aUi9/gmy9ZVJi63/KJI8J9JAd2N9b0iu9Vw4lLIO+PX5jP/7?=
 =?us-ascii?Q?r8uYe/1ntjRHUeIm01QCJUPq8+JTCkwWw14DtP+KiAAXhT6A9cBR7tD7HHl6?=
 =?us-ascii?Q?FQNOv5Ask0gdjMfsZYr19nYc0MbFIteN75nj8IYX0HSKPCP6FbkLqZvwa/3t?=
 =?us-ascii?Q?T4Od83flO2Cn3DP+N+N0JgoH1QTXOAgxS5eexy/pEhAO6FHjLqdZIMFTxl0Y?=
 =?us-ascii?Q?ANFTZFIxoMmZByctd5XXpNvbo0w8dGQ9DCILelAtl/IsK9n8ARKXP944/Vjd?=
 =?us-ascii?Q?qB/HkeLbXaQCG4u+xj3CQXwX19ZYiA37/gxDUER4/rhVr5lI4zokv5UWyT9d?=
 =?us-ascii?Q?vq89xCGcasY6wrxHHp+yLW5jAzQK0FMm9j/wOI37f7wrHXoBhp0MDPan80rV?=
 =?us-ascii?Q?o2UO1cAavaMpSL3YBwHmXuq9wBJReTQuLT0lGdADvYvE/+jdwgue/Ku57qGZ?=
 =?us-ascii?Q?PzItBlm0b04kHE2g69PKYeoCGe1oxedszOKQgKjVaJVyZCzNnrXc9A+GR3Vn?=
 =?us-ascii?Q?EA9PoyDK2unlMvyvNwxvROtiCQM3MVZhpwcXa5kTXlkCGmZu7B4rISMd6zFP?=
 =?us-ascii?Q?crK/3+MN+FDbXZd5Y2XQrX/3mUsIUvjIT5duvLruHjfZC417aq83x0Y5zkH4?=
 =?us-ascii?Q?lZtyrv7xYT+nZmSiQzidhMHinPSffvJhV1LE/YU63Dk9olZFfNbJrvMNEtfY?=
 =?us-ascii?Q?XK6nmb4+1d27BtQi8yhrjDlz99YrUbwrxotX2PNS9scvnpsBoaOwM12u3ewd?=
 =?us-ascii?Q?u6IVGJ1s9PHX3Pb/GxypdJfK8BBru2araJoZ4Kh6ZT+iNImVNkagQ12wKUou?=
 =?us-ascii?Q?wQOwz4ENDnGRmI7mo8ak0IhKIBv+6EPb2c2j7k/VFLKfbAfSa7TT+otYC+XC?=
 =?us-ascii?Q?XBn8Obyr0YM88Yib95GA1k5zf58cRiIFw/AK+7pEXmKEK4vSHG1ebPQqLZMF?=
 =?us-ascii?Q?EtckYRPEbtX3TH+9Lf4fiivipEcjkIR54LLTKrB1o/QKq9aJzlssd6AmTY3k?=
 =?us-ascii?Q?h0gvpmE/2DAKE0F/yxb9G+FomdgAKtRFhfSdKenWP2n8HNqEYw3zSMh9KYfr?=
 =?us-ascii?Q?2lFBTM6RMgCf47ov2dTZ2ah2D8jEb2Ex00s1YEn4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01698e76-3d79-407e-a39f-08dbfbd8c01c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:40:55.8859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YEcw0vehzNfS4sV1UzgqzasM8jBG8977Fof+CnXqylH0hkwr/24PVwhuxh4vjNX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4924

On Tue, Dec 12, 2023 at 12:05:41PM -0800, Nicolin Chen wrote:
> > > // iommufd_private.h
> > > 
> > > enum iommufd_object_type {
> > > 	...
> > > +	IOMMUFD_OBJ_VIOMMU,
> > > 	...
> > > };
> > > 
> > > +struct iommufd_viommu {
> > > +	struct iommufd_object obj;
> > > +	struct iommufd_hwpt_paging *hwpt;
> > > +	struct xarray devices;
> > > +};
> > > 
> > > struct iommufd_hwpt_paging hwpt {
> > > 	...
> > > +	struct list_head viommu_list;
> > > 	...
> > > };
> > 
> > I'd probably first try to go backwards and link the hwpt to the
> > viommu.
> 
> I think a VM should have only one hwpt_paging object while one
> or more viommu objects, so we could do only viommu->hwpt_paging
> and hwpt_paging->viommu_list. How to go backwards?

That is probably how things would work but I don't know if it makes
sense to enforce it in the kernel logic..

Point the S2 to a list of viommu objects it is linked to

> > > struct iommufd_group {
> > > 	...
> > > +	struct iommufd_viommu *viommu; // should we attach to viommu instead of hwpt?
> > > 	...
> > > };
> > 
> > No. Attach is a statement of translation so you still attach to the HWPT.
> 
> OK. It's probably not necessary since we know which piommu the
> device is behind. And we only need to link viommu and piommu,
> right?

Yes

> > The second version maybe we have the xarray, or maybe we just push the
> > xarray to the eventual viommu series.
> 
> I think that I still don't get the purpose of the xarray here.
> It was needed previously because a cache invalidate per hwpt
> doesn't know which device. Now IOMMUFD_DEV_INVALIDATE knows.
> 
> Maybe it's related to that narrative "logically we could have
> multiple mappings per iommufd" that you mentioned above. Mind
> elaborating a bit?
> 
> In my mind, viommu is allocated by VMM per piommu, by detecting
> the piommu_id via hw_info. In that case, viommu can only have
> one unique device list. If IOMMUFD_DEV_INVALIDATE passes in the
> dev_id, we don't really need a mapping of vRID-pRID in a multi-
> viommu case either? In another word, VMM already has a mapping
> from vRID to dev_id, so it could call the DEV_INVALIDATE ioctl
> in the first place?

The xarray exists to optimize the invalidation flow.

For SW you can imagine issuing an invalidation against the viommu
itself and *all* commands, be they ASID or ATC invalidations can be
processed in one shot. The xarray allows converting the vSID to pSID
to process ATC invalidations, and the viommu object forces a single
VMID to handle the ATC invalidations. If we want to do this, I don't
know.

For HW, the xarray holds the vSID to pSID mapping that must be
programmed into the HW operating the dedicated invalidation queue.

Jason

