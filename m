Return-Path: <linux-kselftest+bounces-1307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB03980776C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D94281F0C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D576EB45;
	Wed,  6 Dec 2023 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k4yXgQG9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71B4122;
	Wed,  6 Dec 2023 10:19:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt2EXdn7nyfoJzBXgFa7vJP5sBddTTDLDh1z9tJHZMXXq0kGDoArw9DWBQOlt9HT6Wp1wrOc9zElgtHY/xOB4dJJWFNMKrrqGaMpHGbwXam8HtAve0iVQakd2NmU3eBhkxeJJSD+vZxDvqntoC65cea5bFE+fZHLzBfTsl0zvhws/TbePM8gTdUJcfS147FHr765oTqlicg5DlSVjeSyai5ruTWEAFDbvPMh6zakbfkdMDrbp/VIwFIeFzONGeBXmRec6s/SYbNF+4DjPUUZZy67IKKKz+CQcX5to+xl+j5mf1YdAUIg4vj37ccASKaiSuwVqhHgF3ddENn3FXCMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO+58erhbBYxrLQHIaZ457duZVd6Pw1HE/pMaAvlZwA=;
 b=dE/O5H0x0MXmJmzat1hOgaf5djj87Pv07nCMDNMt5BrP3ab55/Wnss+smChVcTx26jMceJYFqRHIiZEuRESJW/9PprzlaZGOQo3cKspnEjmx25zj6pA0EsmzCBN06cQTTbZWFLTNRkc0pH/5SgDYNRtURWlKtbAUQPdqCnju9w/I1B6LBmz3BUCXWD5DJgL2ZHITofVEvgRv6erKP8dmqEthqGMlCxZog+1F14XKUGQLctzl0p8oNUnJ8BBpctswFsW2qv6rXdZ+/8qgwq6IpD48tJoxMAmYwY7ay+Rr7vGNfKn1awo6lxtV7D0mh0HOW8edB7vSqTbD8eD0dSs+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO+58erhbBYxrLQHIaZ457duZVd6Pw1HE/pMaAvlZwA=;
 b=k4yXgQG99MhelVQ6DnSpZSuGLlcNzLuos0IRH2PwL8jQimKVF3tD0Mdbbu6dx1QxaSvvFeq+Bs4dL7RdYI41BbjFTG217dXDcNZ+x8wreoSCgUtz3aB6dQRtmwerDeqcHSlkLVtaAZLveeMl+hXj3Hrub/melpauBnxJ+R10ljiURnJPIkMrXFZ1F45BZRIkY+5VUvtSSdrwWqtEDAeHbumW7TzUg1M+nkAK726iW5yBCr2DpElqrG6wjozVMnKSBPbSYClpVQel3yJwGCK/dEI0v2GFSdjSGgYlmS3pH416FY4U7AQrWK7PWUMAyZwdwFBbGeVNyp7O8RYvMu+9mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 18:19:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 18:19:52 +0000
Date: Wed, 6 Dec 2023 14:19:51 -0400
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
Message-ID: <20231206181951.GY2692119@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117130717.19875-7-yi.l.liu@intel.com>
X-ClientProxiedBy: BL1PR13CA0422.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 3848a7f4-7d69-471a-f2e6-08dbf687f0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qfLEajnSzxaS7ewReB3OwHH+QgtgNy5mz0VwmMvudU8BId77uKWY8QxXLqZcDCsRplvxtJYAzvOcRMG1Rl6YpQf89wC9/aExmmfMLSHiYEpEpNyn73grjZ8e0YKsF7tNNIQ3wOE8YNplLR709EosNcoxpkugG97MEzxzePIaBI03pcd55iY8HbFwP6b4IA708BhCPKdcwCpyHhEBNhK+GFlhbQFPY8ya6pvwwOrPps3bYmbZSS10mBHPXZVw92CtFP7Ka0/V719RUaUmL3vhZ2pD8kQ/eviz3BbQJxhgr0LNArr1rUjqYoNPTvUS+R7pQ4+9YINWmtaAVtPn7eBpzb69+OJNHMuLwYI3ULj5e0ucd0LO558HeUEPnDM8ZGU0GYX07JXy9wMq/cMCniVDeXiTziKTvyI0q61rf+LgZc+EqI8ct3v8uQpkBA/0AUkN/r9E6YFPO4LjrDhCjbODp8m0UH6G0qmgjklIInNz24FHmbV8dkiHcxnanjPI+6ASwHDs75dk7AVUo9asfewGCmjZE32ONtIwqqlg+oivdbfDBw5tC2R7083iKIWMawVG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(33656002)(2906002)(7416002)(5660300002)(36756003)(41300700001)(86362001)(4326008)(8676002)(8936002)(316002)(6916009)(66476007)(66556008)(66946007)(38100700002)(6486002)(478600001)(1076003)(83380400001)(6506007)(26005)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eQFM8SrSNvLZOWTs76uflzWHuUoAegVIyg8NLQ2q/mdH0+Iuk/qWhU4m6otD?=
 =?us-ascii?Q?leJZIyzfTP/iZ7p8mw8TPHgS6EUHerV/Y0PS5bgfDQZtwsrqaZKHgv0Qm2X9?=
 =?us-ascii?Q?hBD9Wg9v2IfF31tppo0qb0RZMhykeD5IeGBts+jOr69tynqCjLAdasMXRAOL?=
 =?us-ascii?Q?CuziWfqxY7ju0VlmN32etHTP8PM3mFzTJ/Tretv9/0TsZFQanzOtxONooLUc?=
 =?us-ascii?Q?U5v7FOw+T2LFTqeDlBiLcWcx+XTEJdOvuyhaAuFS/4FIRkDIT7SI+fkXFh/Y?=
 =?us-ascii?Q?KDZePa8hnFGXjcxDfG7Gv0pOFV2cK/x73qaDd9NSBq5G7+5dMjiQHR33J2bY?=
 =?us-ascii?Q?r6Nx5McKme5Xgsnu7M3BK7J40ap+F3c1roBjcWMk8TTWX+A2sX/jO+IUQQLO?=
 =?us-ascii?Q?+0tp7Z5SWf2Syvf30v6pXSy6KkAuJ2yd4MHU9isEKqegfjae0hhu6KbFUT1q?=
 =?us-ascii?Q?WO15yXeWdbWVEWHje/yGru/JhJxEvxj5MA33CU0TTp9C9WuBKygu1Aft730t?=
 =?us-ascii?Q?YgvtXcH+TlItidxI1M7uDlD+jXQP/m4hCib9CaN/WLemPz2oM2gz1kc2L7Q5?=
 =?us-ascii?Q?sFEj6pSOPKrOowuJ2h82a26duqDLzcwmIZvUdg5Oly/vzQ4PcrS/PAj2PkAU?=
 =?us-ascii?Q?tQ4wWx8l+gx+Il+7DVAnfweQqzBMaU+Uz2xUi9uzaW8CXFyWVm2BOyfo7Gdn?=
 =?us-ascii?Q?lFExHpzk5Gnnvmogqsz/R+cfK5KSKAP7apBslDSVJQRpUNJOHML/NP0M97Xq?=
 =?us-ascii?Q?syFl2ULMNdRtVO/sUz6CWc32tIu9xLXSMU4vIb/MQSs5ak8ompcsoYss3j/f?=
 =?us-ascii?Q?kdHys5/pGd2SebRVZDLUnIalpawZ+pdhyptaU09qhz9UpHccvYzofhfVmUJ/?=
 =?us-ascii?Q?b7BuDxUZp03Xh8eRxMcQGiKxGVMtuKhLS1gvcSYSz5bf6dG4WdtvN3HuXbyy?=
 =?us-ascii?Q?5brJRoXkCj/+J+d1IHU3IHj1Tc0vNLvo1/fVJDggINTTol5g9L1wLUJ71/vs?=
 =?us-ascii?Q?uXBsayGijuqe2N+rGZuDWwyHevisYE0NjSDpuinDZa3FPcD8w6kDP101Bn3k?=
 =?us-ascii?Q?r7lgYvoC5xw2KCJmdG/Skkm1n+vDeVRbSpmBAbL4kz6WCL6WP49aE1+tt2AI?=
 =?us-ascii?Q?It0TNhH0TKCjSIytDtVUFE6zyHViGTseSHylCu/BKdyPhud4oPsTOh0jT6O3?=
 =?us-ascii?Q?F5PfX80embjdOdIuRST8QPMEGzdxGip/fvauof4GT9MMFpwBpOgAfoejJxSQ?=
 =?us-ascii?Q?ZV7z/HnsJ7IDYPXi4mFEzWKGCZMoSpD15VlduJEhrTlZXfqTgIYMIzj7SLaw?=
 =?us-ascii?Q?0zT6XCu7Ik4j3zC+rJyy5hveg0dyJ6n2dFSE6RYbF6MeS4CWWX+24iyAe3xP?=
 =?us-ascii?Q?GZ4u+MaUgtXiF2VuzGCEWFvV4Sji992Lc9ivyYCT4Fer75T1BZUlsauTJsmq?=
 =?us-ascii?Q?cWiQ54ArJ3mG2uFNvFVfRSc0Lskl6eO42gURcmTojPk6RVoShdUAwS8rGXqz?=
 =?us-ascii?Q?MGRtdKn9lSrbxhQ3St4cNHgw+qqnEaPF1sEk4KSzmJUQznd1KKu0EE9EN1zV?=
 =?us-ascii?Q?EvLEkoMCBZOvCO+R324l6A0o/Qtl9edbE2vOlEQy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3848a7f4-7d69-471a-f2e6-08dbf687f0dc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 18:19:52.6916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuQfz676IBYvEA/JJ/t9Yix/BvskQQRAPKwqQFzeUf3wcbZ8Nwyc49Zk9RY0welQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725

On Fri, Nov 17, 2023 at 05:07:17AM -0800, Yi Liu wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Add test cases for the IOMMU_HWPT_INVALIDATE ioctl and verify it by using
> the new IOMMU_TEST_OP_MD_CHECK_IOTLB.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  tools/testing/selftests/iommu/iommufd.c       | 71 +++++++++++++++++++
>  tools/testing/selftests/iommu/iommufd_utils.h | 39 ++++++++++
>  2 files changed, 110 insertions(+)
> 
> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> index c8763b880a16..2781d5bc6309 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -116,6 +116,7 @@ TEST_F(iommufd, cmd_length)
>  	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY, id);
>  	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO, __reserved);
>  	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC, __reserved);
> +	TEST_LENGTH(iommu_hwpt_invalidate, IOMMU_HWPT_INVALIDATE, out_driver_error_code);
>  	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC, out_ioas_id);
>  	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES,
>  		    out_iova_alignment);
> @@ -271,7 +272,9 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
>  	struct iommu_hwpt_selftest data = {
>  		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
>  	};
> +	struct iommu_hwpt_invalidate_selftest inv_reqs[2] = {0};

Don't use {0}

Jason

