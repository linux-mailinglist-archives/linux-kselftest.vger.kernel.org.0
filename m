Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC847A723A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 07:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjITFlk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 01:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjITFli (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 01:41:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475EE8F;
        Tue, 19 Sep 2023 22:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695188492; x=1726724492;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2w3CXv16jh/HeLZ2b8RizYCEaY8sdsLRpWeMt5tRBxM=;
  b=ZbAh41I4RHEQu5CiUwWpFC4Rq9ZPUaojGbnAq2G++g0+FiC+8xrqidgA
   yRoXrttzXplw3xnfwJAvoXkxigvx9eOAPcxbVEdisR1RA/602bUki9Y1a
   q6d6ARkR3afCZtIldlJwMTVH8HHijrAob3A2rvHOHGh4yXQWb0g7cyAV1
   PgA/zDTT+lesH3IQx8Zhe7bgJcAk4WnVWbxeIBeef0ud2jdwMoem8leo0
   fKchCHEYD7b1mioDrc6ubCjneMCAe/Syu3PmYMs0OhscY6Rix01NNl8RS
   QebsKZ8kZsuM2q02HDuuEITqgHLmWMTOzgbqdC9SixG9iFXfN4h8OCYTp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="444224174"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="444224174"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 22:41:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="920145390"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="920145390"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 22:41:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 22:41:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 22:41:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 22:41:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 22:41:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F10j0F/gnzqQmE5yAJ8E1gJ3Um6bTKeUMh7JwgbiwvzLFlE0P+5anxwiLwSqM5epHyFTrk8paUZFBpVMGY35xOanE9GosAqtMbE4nQx35ngqrnK7vevhr13Vv52Bfn8z/Rz28Pj/aenkrEVI6f9zPlaUBn5KYvj2xmqdGY/yLzSg7ghH8WBMHW5d25s7ItnnUBN+oJcfZq2O/uEQz7P67uXiXbh2N3Soa5+CjNpbfh3gF0r86t7YaVPbzuHovOG3+7aLuR0YGaLt7UPvWFmIOrAiG2sxEFRqIMZysOfxjFjn+lF8/xyAarza453TJTx6z814f8jdCilPtdlkeSqdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pP2dI0ru7CTFHmTlRaccfgPZMzozAFI+dCUPYMEX+8=;
 b=dTLEjSqGdinI+w26/N3r8iSPG8ilrnuRyxwKw63OJjOBhV90zS3XnLlup9+rnTXApr9Ja10TY5hfpBBPY1d/fZSFfpj/JWczDUQEb8aIyty4/ds1z7CPTsyDzZtTV4WK79l4X4/4PjPIldbYPViPBn63Mk94TQWzYRsVW/b/5Mk6R06VSDtxBwq+uiXYy861KFs8GNDHZuyhmM2RwCZicWlVMSJkT+HKlU1XL7ho5QA5FRjrStV6s1C5Pq8Gdc9oOejmrH03vkGnIWazV/8plWLSQ8dm16FBeDzLz5xd34wJTqmZOUzk7xxeXqcOVKoAdD45tB+eF+CQUsbBYPhlGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7)
 by SA1PR11MB6846.namprd11.prod.outlook.com (2603:10b6:806:2b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 05:41:26 +0000
Received: from PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::a64d:9793:1235:dd90]) by PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::a64d:9793:1235:dd90%7]) with mapi id 15.20.6813.018; Wed, 20 Sep 2023
 05:41:26 +0000
Message-ID: <74533792-7dcd-d745-dc07-671260bc9e22@intel.com>
Date:   Wed, 20 Sep 2023 13:41:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
To:     Yi Liu <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-7-yi.l.liu@intel.com>
Content-Language: en-US
From:   "Yang, Weijiang" <weijiang.yang@intel.com>
In-Reply-To: <20230919092523.39286-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To PH0PR11MB4965.namprd11.prod.outlook.com
 (2603:10b6:510:34::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4965:EE_|SA1PR11MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 51dc0fcd-be76-4bd8-7fce-08dbb99c3b11
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Dud2Tb5bnIk5JBCdCmFEwf11rJ3VPCnASI8KvrDLbHGQby7Bu/BsUnLpGd7WjlgStURNclWN4URMg34AJTTdZRi+Q1b6BEYsxCIAsK4n/0cYp4dN5YqpxlUeXeFC1NwZnsDdo6B7IPo1vj9ER9ytYemqw82Le6x/rJX8hfRwkK2ucBPLEifrtUCxLqWe5NP1cPucdyQwWPGc3EXUYC9NRYTowBbnSy4CvK2vRA9JmXyzTGOEGoqVUj81hI1USoDXs1+2T0EKau6MGZcgPpBD6plwoNmF9xBBhr923iVT9AI6rwSZcvh5bPBd0I7+edLdW64Nti80lke/D6gLk+aNiRnt23KX+kCmQhOTxSJXu2Mww0siXLyEgvxwvI1HJdZGGPpQDZ0g9/NzDLguZUlpeRkOlGYYOT2YP2cRZm2tC4EEChg4JTu5wxlAlfes98EoNwMOs+/QCMo0iTrS2zREnQIZfAAiJL+PyMuvWhqLX2D2uOnPbx58WX50B5Fg8jgAPtM7/i+q+wF1U5u5Bn5nc+RyWotTIzYplS1q32b8oK2qfEbl9f586s0bIeSqDSbfe5L0kLLXttTir4Sey1J+TFEw1tvkPiXNZ39JwnCkRnBeeLyhpvhi6blDU5om16zGSLOjUrqIxnzLyo3ZxRPlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(1800799009)(186009)(451199024)(478600001)(6666004)(53546011)(6486002)(6506007)(6512007)(26005)(2616005)(2906002)(4326008)(66476007)(66556008)(66946007)(54906003)(316002)(110136005)(8676002)(5660300002)(41300700001)(8936002)(7416002)(82960400001)(31696002)(36756003)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N29wS2ZyUHBDN1hBbVBONzYwdmVMSEJqc3pCckVqcVBIZGM0QUZrUG1hOUQ1?=
 =?utf-8?B?VDhRMEhQTXlnYkU2anQxSDQ3Ymx2clliUXlCZDlFNisyQXErVEJjeU02WWVK?=
 =?utf-8?B?ZU96ekNnT3pWN0ZDVHNrYjRwWFlkRTZkT2RKd1pnVS90am1QWDJ3b0ExOWVQ?=
 =?utf-8?B?bGlDdFJaY21sT3QrVkdhY0pDZHBEc1k1ZWNCOEtmdU54UGFtU25ablNOLzEz?=
 =?utf-8?B?bFZPbGpMR1RSSlIyN24vaERlb05FTWRocmE4UzgyelZjUFlwa1JNR0tpN2lO?=
 =?utf-8?B?aDI4N3ZpRXJZSVBEenNRdkdkZ0Mxb09BeERMendPN01iUzduY0hNMXZ6R1Bs?=
 =?utf-8?B?WksvYW55cTVRUlNSSFdkUVJxd1NxSy9Tdm9QVzlqTGdiSE1pSkN1SnMwTnk3?=
 =?utf-8?B?bmRuTU1zSGpPQmZCNDArZjZuOTNoaEYzM0tqajFqSHRkUlh3My9PY3hzMklE?=
 =?utf-8?B?R0Q3YWFhZ2NWR20yZFVKV0o4TGYxWUhKTVYxUWdIUUxGa0lvVUt4QzJOV1ln?=
 =?utf-8?B?R2lvZ3ZUblNXSFRxc1BZcUF3bTNTNjEwRm96Rm9ENm5PRFJqc0FLSUdiRVli?=
 =?utf-8?B?UVNKWEc1UFk1QUpzaEtTbnNsUkc1NGhVVmM5bHk4eUMzQnJUWHJ6eWYxdUZl?=
 =?utf-8?B?UHdIZGQyL3RLTHgrTTgyQnI3aWpNRk55bUdZQmVNTTNXSHdHTFdzNmZyWlhj?=
 =?utf-8?B?L2RrczFDbFc0YTBpK1g1OW0vTWJyTFJYSTBkdkRhUjVEaU9wRklwUnBNT24r?=
 =?utf-8?B?YUVGbW9NeHZxTmV0NDh0aWlxUEhYTktkbXBwOGk2MHlIdFlIVDF3MWZLRXo3?=
 =?utf-8?B?b2hTRHBDZGFmeElRSkdFU0Y5VEhmQUxGQTNHYzNVTm80NlZhOGRocG9oM3F3?=
 =?utf-8?B?WURERE9ZKzZ0MFloSFZCUjBwWG5iMmVtL01MTVpMMUFMR2FacHNVeHlYQ2RX?=
 =?utf-8?B?K0d5L0FpVmhoV3NVNEFvTlp3R2EveFRBNXVxMUNSZEF0ZTBFem1iQjRqOTV5?=
 =?utf-8?B?Y29KdnBSZUlLcUhiNkNuUG15VjZ0TGErRk1GSTAzZmVNMy9zTFZnOSt4WUpj?=
 =?utf-8?B?VWpobVU5MEltY0w5ZmRHTk1TRW1CTEZBK2FQNDhQVVV6MUo0RFBhdVZSZkFH?=
 =?utf-8?B?VTVoaS9QYTg5dGZGU0VKRmsrSDBDOWZGNTEyS2NxNjRyd2N3QnRlZENPYWdH?=
 =?utf-8?B?SGRjMGdsTGxHR0JlYmZua09IQU1GMkhwcUhsNUs4ZFNPdVRBUzBhWmdJb0Fx?=
 =?utf-8?B?ckxMMXhZZXhDK3hJQXZWQzZDMmFoWCs5dEJsTTJNMExRbmpaQTJhNXBGaTht?=
 =?utf-8?B?NW1DVERncTFXVS90S25JL21rb1J1UThiUjZlTXl5U0hDUVYwS3RFdGFaWms1?=
 =?utf-8?B?L0E3enl2RENxeGJRS0pIL1ZXN0RvMmRQYmJpRDJad3M4T0RCdzRyOG14RDhC?=
 =?utf-8?B?dEZkcUprRnVxZDdlU0FqTk4ydFZJYVMzQ3FJSVMrVTUzVnpFRGZ0RU9hOGY0?=
 =?utf-8?B?NmVhaWhiK3RGN0NyVmJhclp4RWNGdjU4Z2xDZnVtSGhnWWF6SkN0QTVWQnBs?=
 =?utf-8?B?NlkzMlFHcldmSEp1ZGx3eTFJL3Byek0zUGVZZ2k4UXBWT0ZTOU54cU0vVk1i?=
 =?utf-8?B?c0wvV3dMSlVOeTdVSk90dXIvSys0b3dmMlhTZmtNbVNSK010VXY2S0d5eHRN?=
 =?utf-8?B?Rm9GME1CTTFqeGoyeUJGVDNoSExiS1VBVXJzeGxxdXhVejFIVTVJbGZQK3pX?=
 =?utf-8?B?eU1Md21BMzZJNy9WbEZjeGt0RU84L1BEK2NJNGJGQ3FvdWhOZDB0OTNZeFN1?=
 =?utf-8?B?SkdhVnRIaytlQnUyaXNwL0w5djl1VmNyQWd6WFY4elVmZ09FZDc1WTl2aDAv?=
 =?utf-8?B?YXRJZTl6blZYeGUreVRscW1mMHBBVFVRcnZNd1BkL1EwT205a29LY05ZdFlQ?=
 =?utf-8?B?RUtpNjVYSWt6QnBKQWhxVWJmaTRvakxPdmNqMTBFOHVhcUZtR29MbHgzK0hG?=
 =?utf-8?B?WHhlT1NHUElyelNqNnBrRnBibmMxNkFsRmxCOTBlNjdpQ1hFbU9za0VBS3BM?=
 =?utf-8?B?RU02YzdEOFA0N2NPOEEyZ25NQUVGdjh2R1hSNm02WU5TaGdwMDlBbWZtWXFr?=
 =?utf-8?B?Z0xFdXVOQnR0ejlKUG84d1U0YnpkcWRpWGVsVXo3emk4UVg0YjdRZWRpSENt?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dc0fcd-be76-4bd8-7fce-08dbb99c3b11
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 05:41:26.3146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8tFE/Jm0aESYOK+l+BnxRdfGitbLUstImfGq0NJIPVlzo4iIjnE+1R5wy3cwnwBT6dCDn1MxlLUMGo9Kgybgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6846
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/19/2023 5:25 PM, Yi Liu wrote:
> This adds the domain_alloc_user op implementation. It supports allocating
> domains to be used as parent under nested translation.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5db283c17e0d..491bcde1ff96 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4074,6 +4074,25 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>   	return NULL;
>   }
>   
> +static struct iommu_domain *
> +intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
> +{
> +	struct iommu_domain *domain;
> +	struct intel_iommu *iommu;
> +
> +	iommu = device_to_iommu(dev, NULL, NULL);
> +	if (!iommu)
> +		return ERR_PTR(-ENODEV);
> +
> +	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu->ecap))
> +		return ERR_PTR(-EOPNOTSUPP);

The outer caller has checked (flags & IOMMU_HWPT_ALLOC_NEST_PARENT) before it comes here.
If this callback is dedicated for nested domain allocation, then you may omit the condition here.

