Return-Path: <linux-kselftest+bounces-694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907077FB193
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 06:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E4D281D7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 05:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF140107B3;
	Tue, 28 Nov 2023 05:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKZaWj+l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C723D6;
	Mon, 27 Nov 2023 21:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701150742; x=1732686742;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2mexHAnFtnwA4SsG+ihTgBCBbtpMn7NyXEvIaPrTjmI=;
  b=UKZaWj+lv1seNfGyev6AMBpG/QOuu9Rf3C6cAJjCszChwnSdwGhi7ty1
   locQdprHhA6gp5xygZZiiNAa7nLn1jxKLwiJZZjD7Yr+S0xalZB372rcz
   IUmuijNDVQ8WD57wo4rgHwDECZMz3Qz6RqMhVIBGge3OSrddvTEMS/i7W
   dm80pToVCZVpfcbJ//TniDQaCh+AlqAkuVBi740mmlDlXXbCYXba9TtJP
   6MMFr5udl/6D6ZmqlbJ1OkvwcLRQVPO7Id3CZXNw0/zfPpAt1tpNoczbu
   dmSV1/Xebz1eOK1ZFHjbIOa0Y6xtgNtzNmvSIvhD6gR6dg5PjwnvzST3Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="395673342"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="395673342"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 21:52:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="761841847"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="761841847"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 21:52:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 21:52:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 21:52:21 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 21:52:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5y4Mvn2eKdqtxGbU1R/vPLohgb00YS0EboDqzKS+p6zRu4Y/HJFoIyXlx2Smnx+iv70i8zX0A0gEiqhfLJYiCCHF9WJTkiguTHyKmcBjau13M8YKvK3wxKaA7eCfsOQZiuyUbkhT1sXr7mdhyajFydxtHdWPR1CuPE3EqhYvnlFi5gT0fP8GyYng4l+4ZWroqJpw72WqkBAzsRvBSosjVFu6h0PMgwft2/gVHpvdFDzo52sqWUuisj+PqPWre+/QJrZm6mB5dKwz1dx7NW+N61Gvb5nFCFveRVByhE6ZFqK4/xYp3knDajLA94o3HkNzDWNDRDvGJcaMg/FppomFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0trd4/q6A7d688ailtZXNWP/8R+FNg5P8/1q6wrcJY=;
 b=hwMoblepIOW9R1xQFJ5+H1cxluXkCnBM5x1brqZBV3cozZyarrPDQGfRMMQRdu5tTI4/UfNvoJfGBXYwkygJxA/nUF48RVCUzzb2R2jLQ273wmQjkL+pcezLnjIh+zKBImg+SW1JuOBqsQJcJrqsnkECrEoZEkEakWSB36zRfU2/CTccKQQRoLNApW1JjsEq4SuvFO486PeM9JRV9KVbFEBxY5n+9Lo0DrAbaphmb44pQBwttARMhEtgM5p6P/9pde6Nnims4kCJlpoCN1P1TUbiC5E/UxCj2Uh6yF2dL84LnRGY29suYCF5Kg4/4qhJV29/D8h86GZJ4nRQADcyCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB6838.namprd11.prod.outlook.com (2603:10b6:303:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 05:52:18 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 05:52:18 +0000
Message-ID: <91e61165-6695-4948-9a38-79c1b1e6305c@intel.com>
Date: Tue, 28 Nov 2023 13:54:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <robin.murphy@arm.com>, <cohuck@redhat.com>,
	<eric.auger@redhat.com>, <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <e36e856a-8d4c-4cc2-a5db-cf00673a9bf7@linux.intel.com>
 <ZVw90r3/dvgMg94Z@Asurada-Nvidia>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZVw90r3/dvgMg94Z@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db3ceb9-6125-4307-081c-08dbefd62d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhsnjNmoBNyL30yPMm2juNZHg8Z9NFEk3QhUC5TuXHux3DI/cwwIXDroWvqhVpirCDcJQq+OqjEcJ/lLturm1GXPi3kC4yPaOE3jeTx9aTY4liFuMzGwBmfyZWpIV1J0WYhf00wRrlf16fhQaCJjObCniX3BrrRI/3zOJ9TdkxzNH2D5FVZFvh4L1/u6mclOb8bdg0Ul7p++lPLrDe6rDu0scpJNXKnU1sGVSuyE5vlt7SOXl0dsstmstT5j4NwMNFUhO1UfNOBxyB1EkzVxsJk7nrvLXeQ9s9QkDaolrdqcPTFObDpyvsKroOsfO2G+wQ1pMOLfLjUtE6S9NG+yxRitoM6dZIQTJrktDmJCHRHF3CDzAKhqxhYBZcn8E7pmVMGky8Kg/Pe/XR2fzuHXnexugCaeuUv362wiSCu6FIJFm/N0vjyFB0kJvP7pcyqbUf5aWc/wmoQNVjQ4tn3xaSijmy/Z2YACnp4SnAED6JILUyPd6IwMf+0hX8yCSAjrpsbn0v2F+3b3z+z2LTnDLEulmj2B4KpTiq4O2f1mmYSBeN8F8/5kqyLoc6Xxpq4UelBz7CtmawZ2L/bqCsARp82enn0O88MKoCfTxQ3v8iU2vRkCdx6dhYB/QdPraoJBoUadnK6CYcuUF2i7IrBXPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(36756003)(83380400001)(31696002)(86362001)(38100700002)(66476007)(66556008)(110136005)(66946007)(6486002)(316002)(478600001)(5660300002)(41300700001)(4326008)(8676002)(8936002)(2906002)(31686004)(7416002)(26005)(2616005)(6506007)(6666004)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alFETTRhYksxKy80RjhpQWFHRTdPaG55Mzg5ZnNKR280cUMyMmdUVnFlNHA3?=
 =?utf-8?B?ajZoWVVhWitDZnJwZXEyZlp2ckcrNzB3TGpYVHpRL2ZEODlCK2wrWkJabVN0?=
 =?utf-8?B?cGlTZlE1bENuTE03ajhRTVk0SGxRTG41Qm1vQkhOWVY4TVVack5Odi9xcnhk?=
 =?utf-8?B?cGFNWlNiaVF2clpxbzZPQ3pKb1BDZEFVdHBGc3FZVld2cXRhTFR2R21pc1BZ?=
 =?utf-8?B?WFdvRlY4TmRBR2NiODVNQzlxMWFjQkVqQkxsbDFOQ21BMEtOU3ZwQVkyY2Ri?=
 =?utf-8?B?czVHMTZ2MlExK2RIR2kwejkzRkNlczdnT1YyZVpTL1dTYzliTG0wZStVcGpS?=
 =?utf-8?B?SDJyZDFPc0J0OCtRbGdXK0lUWmluYXR3VTdMSHZWN1NmbFoxaysxWWRoRi9U?=
 =?utf-8?B?a1dIcStYNEY0U1RBSmtld0FNMlJuYndQUUVXaUpISTFsUnNFWG9BYjh1UStQ?=
 =?utf-8?B?emdGVTlBTGtabTlmaHNMZFlnSEVsTHFZZCtmcnkwK0JZaGdsb1UvYy9JUHpO?=
 =?utf-8?B?aHlnYnVRZkNhdEFUdnBoNkVlUHVYS042cWc5b25uM1FLYjEwWWxDaEJuK2xI?=
 =?utf-8?B?SDlmUzJzQTFYbUdjUE5acm5BV2JYSnlTZVlQUTJqNG1WZGE0cGRYZGo5KzBh?=
 =?utf-8?B?MEM2WHZFcW5mWmdaWGVTcmhyK2ZOdVhTc1d1RUlPTnhnS2dzcGYxbFZLWEpm?=
 =?utf-8?B?ZVZ0R3RTdHhIdnBLNU5QVnNldC83RzNpWUxkMnJIbnZaMyswV1pvTUZFdnB0?=
 =?utf-8?B?VzE1QS9SVW1nSUlEL3FvZmlFZGtaQ3NDRlAwMFZGRzBJaTYxYnVuZEhhRWhj?=
 =?utf-8?B?V2xKSzVWOWxwTFFMa05KczluYi9ESjczNGI2K083dFd2UThNL1VBNmNERC9R?=
 =?utf-8?B?U3JLL2pBNDJUNVRjbEQvczN1Q0NrS2l4d0xNbjVQTFZCYzRVTU1vUjBpZyt1?=
 =?utf-8?B?L3RQQzRJVVNESGtPdE0xT3NDNmYrcUpJVmUyejVtVFNyZUZ0QmlGNFJhTFlP?=
 =?utf-8?B?UmJmbEJONHhkMDFkN1BFYXhUSlpPc1RFcGE5OU80bkIrVkp6S0NOT3hZUTJ1?=
 =?utf-8?B?UTR1QzdCaFFoeG5ER2ZGeTAzN3dFdmhuSlEybE53clBYWndJTnpvNnJ0a2Vo?=
 =?utf-8?B?eUk5REVYN0piMkFqSkhEbE92Q1RyWnowVXM1TVlsdi9KNG1HOS80ajRDbW9G?=
 =?utf-8?B?bjNuZnhXQmMwNHBKbEsxTkJZQW5aMzYyUjBVbGRTL1NHODFIUk15cUt4eFBi?=
 =?utf-8?B?ZDdHQnlHcVJGZTdzTmtIeG1mWHA0ZjJDdnhEYlpDdkxUaXNBd2RoZElpNVB0?=
 =?utf-8?B?Ym1GL0F3N0cxTVVEb1J2ejZlVnFSRHlNVHhkTkxMYzQyY1dFU2pOMmF3VkRY?=
 =?utf-8?B?L1hJK1ZSMk1ZdWNkTlRUdlZWQklQN2djZDJQdVpJdnZJMG9nS0kwWndKVnAr?=
 =?utf-8?B?ZDBzcXROTXJUZ3Bzc0RJZEl0Q09HOWtoUUJkOEgva044VGVJZW1WSjNCbEJ4?=
 =?utf-8?B?TnRoQ21uRSs2VUxNZVA2YXh6blFCVmVFdVY5NzFidkRON2UzVk9qTTkrWU5I?=
 =?utf-8?B?aDdmZ0VvT3VGZVlvUENoc2VOWUdsdjJDVnRuR1BHZlBIRUpSWERoMW1XRFI5?=
 =?utf-8?B?TTBMdUR0Znl4Rm1Pb0hxdW1hckZoaFprdFF2b3BhMjVvYlIraVRMNWJmbWVP?=
 =?utf-8?B?dzdTckpzaFp0WTdOb2YwZzV1c1JTTThDZEhuakhrZ2xacDhGUjhDSmYzZ0w1?=
 =?utf-8?B?ak9pNWg3UUpKbWJYaG52VzBxSmcwU001Uit2RVpvWTlJVlNHTmZkVTFRc1VL?=
 =?utf-8?B?REd4UTBzRllGNUxyMWZCRWQ5R3ZFRWlNV3c1dmM2M1BOTTM4bmFCa0RaREFE?=
 =?utf-8?B?ektkZE1SMTlMeHY5R1YyclZmMVVlTzkxQVk3dkt0YWw0N3N1TndaQnJNcmlm?=
 =?utf-8?B?NXlDTW9pS2dXejVxWmVCTEhZTWpFRldVcjhvYTdHN0w3NHBRbC9EM091a1pQ?=
 =?utf-8?B?L2ZRa3k3QkY0YzNBR01sVmg2Yi91VW9IOUM1dXI2cmdKY21TMUN0d09jQklY?=
 =?utf-8?B?TzZFRW01V3ZHNWI2NVRrWG1GRStiRFpoMEdMVEtiM0JHK092UWxBQmdUcGh1?=
 =?utf-8?Q?RgSavYj6KPANaqXG3rDV7nrlo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db3ceb9-6125-4307-081c-08dbefd62d4f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 05:52:17.9336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMl0E317DecJm1XrBGZBS3u/vwEntmzzJo1IC430sp00zwjOBNskPEgzAv36AyM3eatg+WqPC2/TV12dGP3tEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6838
X-OriginatorOrg: intel.com

On 2023/11/21 13:19, Nicolin Chen wrote:
> On Tue, Nov 21, 2023 at 01:02:49PM +0800, Baolu Lu wrote:
>> On 11/17/23 9:07 PM, Yi Liu wrote:
>>> In nested translation, the stage-1 page table is user-managed but cached
>>> by the IOMMU hardware, so an update on present page table entries in the
>>> stage-1 page table should be followed with a cache invalidation.
>>>
>>> Add an IOMMU_HWPT_INVALIDATE ioctl to support such a cache invalidation.
>>> It takes hwpt_id to specify the iommu_domain, and a multi-entry array to
>>> support multiple invalidation requests in one ioctl.
>>>
>>> Check cache_invalidate_user op in the iommufd_hw_pagetable_alloc_nested,
>>> since all nested domains need that.
>>>
>>> Co-developed-by: Nicolin Chen<nicolinc@nvidia.com>
>>> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
>>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>>> ---
>>>    drivers/iommu/iommufd/hw_pagetable.c    | 35 +++++++++++++++++++++++++
>>>    drivers/iommu/iommufd/iommufd_private.h |  9 +++++++
>>>    drivers/iommu/iommufd/main.c            |  3 +++
>>>    include/uapi/linux/iommufd.h            | 35 +++++++++++++++++++++++++
>>>    4 files changed, 82 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
>>> index 2abbeafdbd22..367459d92f69 100644
>>> --- a/drivers/iommu/iommufd/hw_pagetable.c
>>> +++ b/drivers/iommu/iommufd/hw_pagetable.c
>>> @@ -238,6 +238,11 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>>>                rc = -EINVAL;
>>>                goto out_abort;
>>>        }
>>> +     /* Driver is buggy by missing cache_invalidate_user in domain_ops */
>>> +     if (WARN_ON_ONCE(!hwpt->domain->ops->cache_invalidate_user)) {
>>> +             rc = -EINVAL;
>>> +             goto out_abort;
>>> +     }
>>>        return hwpt_nested;
>>
>> The WARN message here may cause kernel regression when users bisect
>> issues. Till this patch, there are no drivers support the
>> cache_invalidation_user callback yet.
> 
> Ah, this is an unintended consequence from our uAPI bisect to
> merge the nesting alloc first...
> 
> Would removing the WARN_ON_ONCE be okay? Although having this
> WARN is actually the point here...

seems like we may need to remove it. how about your opinion, @Jason?

> Thanks
> Nic

-- 
Regards,
Yi Liu

