Return-Path: <linux-kselftest+bounces-1522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A00E80C7EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C29B20F06
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E75B36AFC;
	Mon, 11 Dec 2023 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqRkI+fP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6249DB0;
	Mon, 11 Dec 2023 03:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702293997; x=1733829997;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YUb1h1FfGABms4t+mv+ykMr/6/+6NhxDZz1zJU87ui8=;
  b=EqRkI+fP/bcc6O+pUj0ge8Uz5aLvLVSxAN5wh+yI8J5tJ4eeS5IycSNz
   RmYq/PnyUklN3aA9G++H7U/rB7tPFy2vO95fv2cYOeTocl4TY0d6NHzW0
   I10a4DXHTM94vQvfKDWZsAyvzx/9Cae+ywk6AiwZbRih7nCdnkSLcM4/K
   ZSPaSg9+VINnHX1vWoKNeF1Wlp/xCgj9B14hqk8HeOvRBL1DpBScbNoGn
   ZnrZ5LTb+zJZR7u/aF/1KAtG3Ei53wJAxDJJBJIGTNkkEoTWQwiGETN3u
   IwWE2xH0E7fqLS2vc1uZETpudYFPngo/EmF3dK2P+jVDym1tefGEyYAP9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1761433"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1761433"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 03:26:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1104443456"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1104443456"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 03:26:16 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 03:26:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 03:26:16 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 03:26:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkq6edMLTe9A2+4L3lLQPXlAynmVZX9EtB6+JScH0HDBmZD6imOp+gG+36Ph9zjs/gNIcflpR4EkeM88prA30qze0CuXgHrccvUequSoUXcMGUCp9wmVqCSjALJQZ0ujo/BAj9cMbpmlZzT7n6Hf/ym2sVF5wuGkEUBDlSTBWARXD4obArkv8WVrb5QDCTsY7+Qp5ZI2i2s33mZF0MpqRRlEMg8uxHaVxBCSNmEepnXFS4EAekBtzs7h1Wh4RGoO0VHKIcP5Oh1EEl619mD6XpeOM7WbD39A0umEjR3GW3dtCa7J1AqpU9LJoh1vVhuBAt1fdliWqrkO1ct8Zyi59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDrSDsj1cw2eY8N0U4/PO7+1wRiBMTzPts7alx56Tmo=;
 b=PKIjigs4JG6sUyoUgPC4trrChv2iQOBlnKPQK8KAzvp1S6DxIDZcB+3qM9rXlj4gSDQCjpU0kJ+K6Or2fVRTl1kLE9viFcI1elN80PUb4taGHYWJmfQxSr6ddh5aBVJCiFJX30MwxLB3nw7uBBsBN9BWwYMkX2Y66IYBlOm61w9RATHcmkT6jS7mKDMdUZcvGlmpW2UCs7GKUOGcyAAK5kVd8gpSr5z9UDPQcNu6oJLvzfieod+V7pS0vM/ZmkLCzCYmGoxcMRkqGCapyGHtoyR8+k8wE6huBvbLF+7eazyi4VD+JrkjoORVs3LF80qoRhcbaJL1IYr6HgOWEruwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 11:26:13 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 11:26:13 +0000
Message-ID: <a3a2cf6f-8af4-4753-9c36-788d72c8092b@intel.com>
Date: Mon, 11 Dec 2023 19:28:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] iommufd/selftest: Add coverage for
 IOMMU_HWPT_INVALIDATE ioctl
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
	<robin.murphy@arm.com>, <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
	<mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
	<yi.y.sun@linux.intel.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-7-yi.l.liu@intel.com>
 <20231206181951.GY2692119@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231206181951.GY2692119@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::27) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ2PR11MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd84a38-3f3e-4122-92a7-08dbfa3bfb4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5C2w4Nid2FqUgyf1z1NvEvL98vcaHuLURWWPxQizAWlmUk6wgFzi10s37+1z5P2hZ8ujYEyDXRhkSF0f00diVB1GMJJJzVjWZZgQQh4mxSWx3V2udQJl4DYHZXJlVsfEwZ7VVXmu39kUhrmA8/htOrBre44uGWhRzFOpgirm2Jq1Z2p0z70S2464/SrnxuInHvIxmHswA3o+fh/IWPWCob3b+FGdtc9ar2l53sYj0tLHw8JS3/MiNgw4lQ4qiJmWHPWi49s8bONc6COOzBNeqZKzItoEyq4sfTezWDQheL4phILHIVWrUo55mn3XQpDeY5pliEBIpgVdDPJZOVF0zsdPQnMhmjFi1LNtP6C+AEJbIyWj4M0mYaEbMZIH9aL/jW9VqJoztBPU+rrYNZodelV63PZMj02WAQx2DI4JXjQz+H+xkE0WDAVRKxLe+kWT0TMTDoVeUTgq9lXNtbvnT39MKrvs7/fAiDJIkL8pnCXi8VhVmcItCsyIu61agk52k2zJYGBEIdlkjJ9oW2sOxubgjZngHaiwrcuJUH6kq9ERu9IyhpZyjDoWynIulmElhuT8WttKPEgEMv1ZpwjxQfqqng67EXk/GGDrExJZFXYv7fi8kMWFWNO5yTRBOHKSFUPhfkst4OPLNu2wSKGiDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(5660300002)(7416002)(2906002)(6512007)(53546011)(6506007)(2616005)(31686004)(6666004)(36756003)(478600001)(6486002)(38100700002)(82960400001)(83380400001)(26005)(8936002)(8676002)(86362001)(4326008)(6916009)(66476007)(66556008)(316002)(66946007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWVBdXBoMmdjV3NNODJxb05GK21zOWxvaFFVZVUyOFlwOTZGZ0NKQkxCSmRj?=
 =?utf-8?B?SnFiTklhQ2p1OEhWODNWRTlKN3JPNFhQeEhNcmpzNlFsQ2huN0ppRFIvTTNz?=
 =?utf-8?B?Y3NJc2NqUXE3eGtnZUpzVU1hOXNVR2s0NStkYkVhR2JOdjU4RW1LMG9nK252?=
 =?utf-8?B?TXBKenV2bDRjc3EvMERLWWhpbW1LbmprSHc2R29USmVRcFVOZFgwNURzQmdG?=
 =?utf-8?B?eG9qNlB0cFQxUi9UaUY4T1Iva0tDVlk3ZEJUYnFJTTBJK2RVTURJZVg1bnRY?=
 =?utf-8?B?ZTJOVEhEVTM3U2hodjBlM2dxTTFtdnRXcDFWd29Db3RCRlpNZEc2WFdZdjdl?=
 =?utf-8?B?YTBLc0daZ0lyY3dsNE5hSVZiVUxjS05Sdy85dFBYWS95dzVvWGJUalJxd2tW?=
 =?utf-8?B?MVJwOVlBTkJybkNXL0hPNGFka2I2bkFLUk5qMzc5UHBhdnphMFQ0cFNHRjlJ?=
 =?utf-8?B?bXNCaHVCbTQ4dmh3WmNxdlI2RzJrTFhpNDVjbXAzY0tLcDROaGx0RHUyUVlH?=
 =?utf-8?B?a2g5cHdteS9IZGk5UDcybzBtdkpOdFhlYmFXSFZjRURJOWVGVjQwUzJ3NGhP?=
 =?utf-8?B?RmdyT0FPK1ZIaGhYVGc3WmJFU2l5RHNHYVo2OURDYTR5ZUFWYm1oMVlwVGV0?=
 =?utf-8?B?dG8rQ25nb2Q1TVpDRUppY05KY2g2aWxsVjVhRFpaNDYxMk9oYU1JWDZTbjZG?=
 =?utf-8?B?NWJjUHVHa3l6VkZYbWxlY1A0MXRMOWF4ZUFoTEtxRTJEYjVGVHhWV3o5ajFi?=
 =?utf-8?B?N3FkVVZHblhocGV6OXNGc1pxenNKSTJ1aHl0eEM2NEJvWk53RXdzdVRkTzA5?=
 =?utf-8?B?QW5scCsxYlIxczQ0aC9kMXRoOXozazA2U3JTOTZMekNEV3E0TFdjVmt6a0ZX?=
 =?utf-8?B?SXRlUnZIdzFzY3BXY3UzR2grdm1QZWFmMmNhYjFMSnhTYXVodnBFT0tOK05Q?=
 =?utf-8?B?VytraDZKRmJqZEhrTlcxaTA0L2xMOGZhNVBwL2RnOGNabmZ5S3BCQWMxalVI?=
 =?utf-8?B?Mk8veHllRmR6MTdKQlZ5YXV0WU9NVTBlNWJsM1k5dUFDa3ZlbWd2TTRISlBv?=
 =?utf-8?B?VmxLMXBCMXYwZWRQNjE5MUpxUzRUbjg2NytWTEZFWHhQTlRoM0duMHVrRVZD?=
 =?utf-8?B?SmpaSnM2QW9XaFpaNlZ0bEJqSkhSd1MyN0NsQndhbE8yMEU0OU90MEN4ZXB1?=
 =?utf-8?B?N3B0SDJ4aFZPWUlCSWRETVBlQXhycWRHay95enJxckFSd2ZxWUdINUhFM09n?=
 =?utf-8?B?amU2cnpRZlhzejNleHBNNG9RR1NKT0xDcDlMZ0VQckh2SG9pcnBYL2dLUVU2?=
 =?utf-8?B?OTA5VFpROHJSeGJra01OdjFIMjZ1dGRvYW40MlNhM2FZbEl2aVVNL3lsd0xR?=
 =?utf-8?B?Q1FGc0JoN0hqRU5QeTZIL09kVjRnVTIySmFjcTQ5Z3NIRzJXVCtJRXZ2ZllC?=
 =?utf-8?B?RDV2bFBLbVBnbXJYY3BxZDJIVkU1K3lZcEY3TWRFMm92WmpCaWNjUkozRnBR?=
 =?utf-8?B?U0JyUzRKeHZ5WjR1UVhyc2J3Tmx4bGIveEF0RVp5NEZ2VWNwUVdUNnhPeVc2?=
 =?utf-8?B?Z2pjMm9DZU9WTnFRSFNIWjllY1k4N044K25jbkpHVkY4c3ZPRThyQnZMLzNX?=
 =?utf-8?B?azNuWHkxeUJldEZCSUU0RlRLUjVtMjhBSklzNzYvVnNMcHB2KzBIZHFJS1d6?=
 =?utf-8?B?VEJOZkc2QmZqL084S0dDTXBLRHdKdjIzSUYvWE5GRFhPODVnZU11OW0yaTNp?=
 =?utf-8?B?Y3hRUEZjYlN3UUxxSlkrd3g2NXlDU2ZsL3lXWTlxWDl5bElaU3hmTWx2aFBT?=
 =?utf-8?B?TzRnOEk0UjRnMHBxcGR1UDFIc2VRZTl0bTBza01zTWZ2M09GUlkvbUFrQXBU?=
 =?utf-8?B?UVF4VmxiSld5bTJqNjZzQkIxTXhKRVBDV3k2MGxSOHJidU1kUVRaL3dZMVhK?=
 =?utf-8?B?Qlpoc25GTUMrOTFob1R0a2drMWpha3RiMjh3ZXk4SFhQclhWeWNTWkV1THdq?=
 =?utf-8?B?UEVGbk9zTndGNmE2YkNISnFUT2FEQUNxVjEybEhlZlRQWnpzOXJCOTYyc1V5?=
 =?utf-8?B?U1pXeWcreEs5RWYvOERab3Qwa01jSkxlMy91SDlVOE9JczBGTkUrRzdtOEdz?=
 =?utf-8?Q?bqK+t09TkBHe9fUmA3K/cYMt9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd84a38-3f3e-4122-92a7-08dbfa3bfb4e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 11:26:13.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBjSG08XLQ+reBSlG6rft4dvMNT4wtQ7sO+un/+8XjoaIyerDv3xOMeDY+dDfHaOH4GGvQ8+E+Sx8ogPRYoW7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
X-OriginatorOrg: intel.com

On 2023/12/7 02:19, Jason Gunthorpe wrote:
> On Fri, Nov 17, 2023 at 05:07:17AM -0800, Yi Liu wrote:
>> From: Nicolin Chen <nicolinc@nvidia.com>
>>
>> Add test cases for the IOMMU_HWPT_INVALIDATE ioctl and verify it by using
>> the new IOMMU_TEST_OP_MD_CHECK_IOTLB.
>>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   tools/testing/selftests/iommu/iommufd.c       | 71 +++++++++++++++++++
>>   tools/testing/selftests/iommu/iommufd_utils.h | 39 ++++++++++
>>   2 files changed, 110 insertions(+)
>>
>> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
>> index c8763b880a16..2781d5bc6309 100644
>> --- a/tools/testing/selftests/iommu/iommufd.c
>> +++ b/tools/testing/selftests/iommu/iommufd.c
>> @@ -116,6 +116,7 @@ TEST_F(iommufd, cmd_length)
>>   	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY, id);
>>   	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO, __reserved);
>>   	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC, __reserved);
>> +	TEST_LENGTH(iommu_hwpt_invalidate, IOMMU_HWPT_INVALIDATE, out_driver_error_code);
>>   	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC, out_ioas_id);
>>   	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES,
>>   		    out_iova_alignment);
>> @@ -271,7 +272,9 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
>>   	struct iommu_hwpt_selftest data = {
>>   		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
>>   	};
>> +	struct iommu_hwpt_invalidate_selftest inv_reqs[2] = {0};
> 
> Don't use {0}

sure. I'll use memset then.

-- 
Regards,
Yi Liu

