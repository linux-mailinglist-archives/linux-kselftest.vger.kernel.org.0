Return-Path: <linux-kselftest+bounces-1560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D03280CA7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 14:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8838B20D9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FCD3D965;
	Mon, 11 Dec 2023 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nsnHUrFi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E48AF;
	Mon, 11 Dec 2023 05:06:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuq0ZOObye35+XdpRiIZ/G6fZav3de//EMf4M0EVBotrTaUrWXzMd9ZP1zTn7Ml3JysGGqzCypUHwqnfCmYuQQBV1DCJkg8OIambU218cOLR6SVcGvrnAVwW0Wvv2rH3RR0E4JEAXaKg49QEe2I7Zoy6buQUgANlAKRXPciCRqlLBVrnAY/QN3l/jA36iWNhCYlOLisJuWDVsJOF7tZve60Jp8v9siXU6VSl7AyB6ZZUMmclDHfPZhF1/dXCSm5MjlN2QaT3lNyTG7FwjkvMmcXwCpKWWmjasziaUYj2zajXnx7WCP1BgVsuOHgx9nVui+8WnTO/z3PoPlvUWhhbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eexZsGLLWhl9epWzQL//FryeGQEyaWIzA07/2Zp95F4=;
 b=DcmlUuJF+9KLOMPni9pQjwKEOb/N1j2B6gIIkrgCVOT6EejttB4Wuy3pu5dMXb4LfT6gOQc1ZV9GqGzGeYlNil5FJlt/nngUuTfTiIdUXbYdEWtVCDq00EfYG6IV13N77c8NNfWDTIyEx9fEP8+C7wJILdQLMzo0DTtsoTR59Oj7kzRD21uS3hnaWcuKqxcq3W7X1SG3MqcT7j/0gjSfTjXpJXtoEYmbl7nGIGTekT/3pZ7yibCKZh8SgKcTdA5AdIE3X3iREn1RFmJCZk7J5MFeNzPNKKHg0XbjBqHSZ/G8mxBMBrM3vH+au10iYql4Ag3oG6I3f72jEWXtZGdQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eexZsGLLWhl9epWzQL//FryeGQEyaWIzA07/2Zp95F4=;
 b=nsnHUrFi7gMUJIHajq75VbiBkwc9TAiTTXxDKXoUxuoBLqIAqvcQtiYX97FmndCqDZSIw/fsOdgoCIRvxXQW+oO+b1I2thKhBdh8121aNnWLzlrJ5j62nhyQ10Qd52j8Jo835eczakiZFHxIAWqFQlc7x65QEh/pfQ8yvukdngM3IHtefY2KsX+PuHQb6GCMo6V8ll532ExvFh0k9taYPI4wS85Kb6n3hWQvglhUMBxK4cecQWI9FvRYOFnLk/xBO0gpO8PEDXazBrMd9vQJ5OK283eftADFd2tdWPoZSVazXrZfhbzmZK+7BlJqnaieAD6LsWaHvKr+UsUmCnFhUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5135.namprd12.prod.outlook.com (2603:10b6:5:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:06:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:06:51 +0000
Date: Mon, 11 Dec 2023 09:06:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
	yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
	xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH v6 6/6] iommufd/selftest: Add coverage for
 IOMMU_HWPT_INVALIDATE ioctl
Message-ID: <20231211130651.GC2944114@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-7-yi.l.liu@intel.com>
 <20231206181951.GY2692119@nvidia.com>
 <a3a2cf6f-8af4-4753-9c36-788d72c8092b@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a2cf6f-8af4-4753-9c36-788d72c8092b@intel.com>
X-ClientProxiedBy: BL1PR13CA0309.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb02f2d-9294-42c8-013a-08dbfa4a0aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V3a37tb2Iguyrh3ZlTf33SJCd7K5ZHGHFnCIYbaufFjdX0TomBBCtEtMRQSJdvdDjv3mK+MYd/AWtwaRCtB3O28zU2uWt7Aqg2EZy3KCg/qIdKsUc0XsqgL39myi5vK+nQvzz3B/vIv20O0HEnr4c1RB0uruxpcQ4W7Z0sdKiWwdYuly17JBGcSQgXBAKlbL/x9rxot30HgYXSb3IX3RgNVyhUo2aQJ5b5sIoaK9d381ModRcdRN3qiY47m8ENfyXvAvh+CY/LHMo2LOW3FwVp9UmHqlqnyg/GJtlVVoojgQk5uCZnRAwvLj9BedGOsSqmgqyg0cIGgtODHWbie2O27vg5Q/7k3Qv55Rt/VCPEso8ac7Yut0UkMHZDkQ7PgQdfCBVB61T1PTf0Dtd1mH5eaPbISOCqrslZd1MqMiwJBhUOB94RQ/9F8qzgF0zL+ep4gBKZeRmcTpX7VDZhICMT5h5soA5I6uEhs7fEqq1rCej0gHW3+prccgCF8ekXYVDYzlH5H5J6QnUaJ0T1SaDx8w162h8Cd2BBWuekXgWbH5Zbz0GIwHMowqmhGJfoEO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6506007)(6512007)(53546011)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(4326008)(478600001)(6486002)(66946007)(8936002)(8676002)(316002)(66476007)(6916009)(66556008)(33656002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+7qHzEyOegkn/i5gRNhKt0J+o975cpls3KWbToc2OmO5q1C9RU6kEtJQTVha?=
 =?us-ascii?Q?8FWs1LNaWHedOUYmPNGARB3TsS+9pUU0MQwn3KeXZtbNPuOoSiKFWkv9PL6v?=
 =?us-ascii?Q?/hpy6vBwuUg4H4J1Jv4bbwdWgdDeRqaIAphdlQsuZwv5EW1PKkW7jhWYPcHe?=
 =?us-ascii?Q?Olq2VPqlWcijAVWDQWJDHgxx+KZL8LMK6lyG4919whPIifMs2Xl9VPfRPsKw?=
 =?us-ascii?Q?0yjjybb3ypVkF39+pYif895wndLuBrS6/5j4vXzPiHyYvATRQf7fbNl9rq2D?=
 =?us-ascii?Q?+nPpXr/YhViEwsctY1kmPi3bo6smkcm1ZqUOPjcXzdgiuq2Z5sAGBK4EWeHZ?=
 =?us-ascii?Q?Bdq+drjPvdvSwqTKyXbfYOQ5WtSp6ERGxhm8dZrDqhdq8UnJVlcOKsO7TMip?=
 =?us-ascii?Q?A9u0aFl4a7XSYZWw8Az8ZA2/kRX+AqywsfcB3dwkxVV7myoSJFlkFrH655oB?=
 =?us-ascii?Q?hxQFTDvys4patjQUelmmrPY16BUmzaxX/vFRr5m4ewuOFplFKAVOdexuRznj?=
 =?us-ascii?Q?uii3wEZ1hndJb+RbuSz0U+2cQ3luzow//8jzgJlGx7+OPB1T1t141bumpHYZ?=
 =?us-ascii?Q?fJ7eqEMmj4tkonP2jy5ZL8tQw44EsBBIg7tabariXgWFnDRZtJFtHlrG/Bty?=
 =?us-ascii?Q?fl3qa1NipZuzV7sPNdOejdH4Zux4JRY04b2pYt8aTUoK0263RnfOH2b8Vz7U?=
 =?us-ascii?Q?K5cmpD216LNpiBSka9rTBT4F+NBxAx6GBwK++MEylfJQ6jiXVMsPaF2s+o8f?=
 =?us-ascii?Q?o7OLtCYIjW9s3I77+175zmC7VypOvXq3liF0aB2XWakESKk51StMDGWS7eWd?=
 =?us-ascii?Q?m+xr+ZNo+ddpy9mQxTixbvxZWFcR5ZRBFcShlz1T16iVMwzTfnN9xmbnrIz5?=
 =?us-ascii?Q?i0SdHGhPwT/OqOpQyKQO2FzxvZyxfye12LIwdOTuJwkh9rcWa24n130bmQ9e?=
 =?us-ascii?Q?T8Pjy7T4psmG2J/nGIKhUm3uAQY7Igc11gdVPOQ2BbCoWT9BSboVnS+vgt+/?=
 =?us-ascii?Q?yd0CGLzV9SGVYtDNG3P58hNiiH22kxjqkAEC7EVtfB5KP1bt2JtZoTuvEm9y?=
 =?us-ascii?Q?KHBX6DPY1ZgQcnksbcAJgZc1ylz/oWQQIdcgf2EeTeWmOUhHDq8svDRm+41H?=
 =?us-ascii?Q?GX0m8erEMo/ys+lshSnKbRKCtGu/gcwa8p8n8TvtajtM/a7tvxxjj9ldlYjV?=
 =?us-ascii?Q?pdHbKrC0YVb4++Gz7NRFjqZoTe1EqbBFPQg3BCa0rorm7CB7vRD0jhzUAYGL?=
 =?us-ascii?Q?bBkQh8X0Tg1G82m0Z3a1tlWulY6YgxV983xptA+7IZEGxLLHRUNiUmxGblK/?=
 =?us-ascii?Q?IPZi4/87nKV7Q7K00s0RR1Jop86X6+aVgF6XHoIq/aPXJ855lxedBVXpOc9P?=
 =?us-ascii?Q?CZ2KfyTR2Owltwv0GT+B4INuiw77gwmteyYUkpWw0NZFjk3pEOn2bhvIXWrm?=
 =?us-ascii?Q?3x1kDgoOFm3ZVwN/L2kBAqydKmt3BmaZKl5mk7cFZcS5XPnvMM0KxRd1OBcC?=
 =?us-ascii?Q?ZzC1YZRvcNR1pWK1wQauuYJ6AgG3HuS6jRoFQ6FYGTIQPBoAKgIXFWBJdpmL?=
 =?us-ascii?Q?ZyD/VpbTVfcnxQcCgtSpbMzOHCmEp67qTLaftXOY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb02f2d-9294-42c8-013a-08dbfa4a0aa8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:06:51.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTtLuemeqYvHVhdM2K8TWV7W5Wxi3S+qYN7Ovkp75tq6Bxt1ElNvw4/MHj6KHPeO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5135

On Mon, Dec 11, 2023 at 07:28:42PM +0800, Yi Liu wrote:
> On 2023/12/7 02:19, Jason Gunthorpe wrote:
> > On Fri, Nov 17, 2023 at 05:07:17AM -0800, Yi Liu wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > 
> > > Add test cases for the IOMMU_HWPT_INVALIDATE ioctl and verify it by using
> > > the new IOMMU_TEST_OP_MD_CHECK_IOTLB.
> > > 
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > ---
> > >   tools/testing/selftests/iommu/iommufd.c       | 71 +++++++++++++++++++
> > >   tools/testing/selftests/iommu/iommufd_utils.h | 39 ++++++++++
> > >   2 files changed, 110 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> > > index c8763b880a16..2781d5bc6309 100644
> > > --- a/tools/testing/selftests/iommu/iommufd.c
> > > +++ b/tools/testing/selftests/iommu/iommufd.c
> > > @@ -116,6 +116,7 @@ TEST_F(iommufd, cmd_length)
> > >   	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY, id);
> > >   	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO, __reserved);
> > >   	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC, __reserved);
> > > +	TEST_LENGTH(iommu_hwpt_invalidate, IOMMU_HWPT_INVALIDATE, out_driver_error_code);
> > >   	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC, out_ioas_id);
> > >   	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES,
> > >   		    out_iova_alignment);
> > > @@ -271,7 +272,9 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
> > >   	struct iommu_hwpt_selftest data = {
> > >   		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
> > >   	};
> > > +	struct iommu_hwpt_invalidate_selftest inv_reqs[2] = {0};
> > 
> > Don't use {0}
> 
> sure. I'll use memset then.

Just use = {}

Jason 

