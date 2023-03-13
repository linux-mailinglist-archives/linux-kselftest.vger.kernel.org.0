Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A06B7979
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 14:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCMNvw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 09:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCMNvv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 09:51:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56207457C3;
        Mon, 13 Mar 2023 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678715510; x=1710251510;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WttRwC4OjNwMb4RzD6+UwanNL1dPaREcuSpHGIFPSrg=;
  b=JM+jMrWatKyJ1K+99zMWIrhzTZ5kbJtF+JiD/FARk8ql8hKmnmynQ1CA
   h5ZuIj72YuGxaniXyrA2O+rB6GjytUZKRTSmwGQVpotofQaO5FSSoh4BA
   9Z0gdc78y6Mbc/ljEbXk0+j9ioGdVp0Q9fH7+StrlYBP1dOHU7iJdOjgT
   JbXBRHf9L8rZ40yFp7JCCYZC5OW2Ug5ruCaRxk3B7OxNe/vxq2/zcHsP4
   OqCM3Qrg0rQgwAHqXwZ7TmNNMV/P73dfOVj13hzDgTU8Q7eX5fhhTFiPB
   Z1OMXWOHH6Bf/rq3Pog1XiKS732TQQnl6OOsIOnJkp0swj92JuaFycR02
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="325509244"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="325509244"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 06:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="628644130"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="628644130"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 13 Mar 2023 06:51:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 06:51:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 06:51:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 06:51:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 06:51:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFObjHAGo4U0Rio6fJ6vAGERFiYI8wZjthMasZ3RSTYHJp+PODk4AgXZPXhIf6Nuw+Ssu/aYReh1owkMLqheF33m3kU0HkVsbuUqqJP3tc1PTBrq5ZKPyD7pOujnHNF2wwksEW0hKOjoAYnLO1o0U+c2A0cMQLPHTX6d+ZCK/c8Ljf6AHeDaUpfNBpqANIWgL5ib0P9RT9TeYvhIVmdToQ8X691HGCkPahtVtUhHZ2Rf2b9Q63JSQAKL1SjTZlwkKQCoemZ+DimyII/Vmh3ujQ97tvIFwVphU4htvC3oOf69jC4ff/OMwc0B9pT4+ef+HNxW07HaSy83jGqi+c2iaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tsNZ7ugMp97Ngy3LyEC917KPpCffCYL0vO5TckKV5o=;
 b=WzcOSsOWkx6Euleo8thlUf1Vx70g0IvFWN8G1wyiFtfuCijD9FzFd4x4Ewg7j3nfilbDI7oXHiQaP5ZIb7uYMGDD/5TrUKkzoHthpUfKSevi98e3003k/GeVyeeiVAvRQgoNJBb1pMoAdibAOhi55KvPj/z8rLGjR5Dokn6A98B/PFLV+ZQNLb5TZOSB3XgNpAssz2JCqckHC6+yFlxcVgdyeJXSYjDBBFlEX8eZS7REtPUYFYARgX0Si+belIi6C+GYVQ6pABP6AvVUYy4Tjurluyd0cR8oikvOU8NDBX5NJUoF0ScCxXStRaZN5a7jHF+FgP5iuodK+zPqDKSuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:51:42 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::aa1a:2927:42ee:41c2]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::aa1a:2927:42ee:41c2%4]) with mapi id 15.20.6178.025; Mon, 13 Mar 2023
 13:51:42 +0000
Message-ID: <c6e7e0b6-454b-c4c9-e21b-dab68db00b21@intel.com>
Date:   Mon, 13 Mar 2023 21:51:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 5/5] iommu/vt-d: Add nested domain support
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>
CC:     <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230309082207.612346-1-yi.l.liu@intel.com>
 <20230309082207.612346-6-yi.l.liu@intel.com>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <20230309082207.612346-6-yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::33)
 To DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|SN7PR11MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc3f52d-f5f4-4519-134c-08db23ca139e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhK9+7C27QtGX6tokIs4GOC9eg6rzbN1QY1WriJ5A0I3k8wTb6b1uj/LNojA1Ju5O3Q6BYxF45bE+OM0FqVIz47NZNVC2LKTxIQU9LdNMDbBQl6ZVtxSS3oZ8AybXut60AAyvR+HkM/dlIcJ5UgBoM1aJzxBoyjVdrYkvJRNKAHMEYasYEaLVJpOwYd4mmootPu+0njTGXZ7aNZtdx4MD+5YCey+cpU1dzVjdtCc2Tpp5xvh76ah05Xbtj8IxkC8MvYQtOij0lwQgOLTDP9S6JxhzqggfusHLcTP6XRBsKLMtje7TgdNuV2a4/QVB42hMWOF7LqvfJ3BkVw+ELJ/oRUE2kYaL3W+334WFkEAUEGlixaH9A/M5tRlKEsyfGRHuyeRp9md43htF6xgJOb816nQNsmhzoR7Nrffe8G4FHLQGHTzBrApRzXUFc5suWUq7NIsz3nqD96UlOPwch6WXdqW9JMJWVf31zXSlN+nkKBSuucud11wApaHJSK2WjQHa4X10/giN6u64KWI2NzjoPTrveRfpNS/tQke17pJMzYEHzQy40ZtqkGojbZb5NKI+CnYZs7pms+r/AvfDX2L3oqtP46yH5F3TY25fUy7T5hkQRsYD6GoeDHpQsuDxthvRP5k4eF6XQTfkJxyxBB3uzQjrXcy2BPtdnFBfcxUHAH+CqcNlxOxQzxsPHvmdauHKEkjrpYUTjsOvi0l2NBdv1+tj+c0RGbwPr1E/muwF98=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199018)(31686004)(41300700001)(478600001)(8676002)(4326008)(66556008)(66476007)(66946007)(8936002)(36756003)(31696002)(86362001)(38100700002)(82960400001)(53546011)(6512007)(26005)(6486002)(6666004)(186003)(5660300002)(7416002)(2906002)(316002)(6506007)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHZnVHU2YTgrbTZDMlV0amRiZ3lOMGplZ0lpajhDbGNDRXBIYWtQUy9kTEc3?=
 =?utf-8?B?Q1RVNlo3TyttM3hWQWlIZXhEbmhNN2JaNkNCNXFCcTQ0bnMvU3ZmZ2sxUmJ6?=
 =?utf-8?B?N3JwRGFSRFpNMDVOUjY4b21IdE8vNjNaNEVqSFgwaTFBU3JMSVJMVmJ3bUhv?=
 =?utf-8?B?S0JTUjQ3Tlk1cFJ0ci9VWlF5dVZ3UzEzbDhBcGdBb2FyQWJNVTRVVlRJbmNk?=
 =?utf-8?B?OU51Q0ZhVHdWUEFsTklBa01rd3luM1ZWck0zRE80ZU83dG9wWWtwWVBTamt5?=
 =?utf-8?B?UkFIbjl0TDRNRW1KOXV1amF4QUVyeXJsbzVwMDJxN25kbkxRZ214c3ZXaUFC?=
 =?utf-8?B?Y3BhcExvNHEycTZQTWY3SnVKRXZEQm4wOUN4SkU5T1JOdWQ1YWprQlZiakho?=
 =?utf-8?B?dDlxaVN3eWY3N1YzYm5rYzZXRU1yeDB6NFZTZ1BXQTVJSFBTWmdUMDJRMUdu?=
 =?utf-8?B?N3BYWmdZZExlNkE1MXZleTg2b3ZnWHhPZ0EzL1VFNitYQ0RINWlYVWZPMkdi?=
 =?utf-8?B?UWt3RjhwOWl0UENjT2d5WEp4eVd4Yk5LZmVZT1Q2SkRWMXVIYVM5aVVXbTlY?=
 =?utf-8?B?NUt4QzFsSmNpbFNIcjRCOW1kcVFmeGtjRDh1eGw4ZmRPaW5CTzZaRWZ0WWVV?=
 =?utf-8?B?U1lMNHBYSGdpOTBnSjA0emZXYzFiU2pFSmJ1WUJwV2MxYzBpZDFsZThuYmdY?=
 =?utf-8?B?S2QxTyt2dkRMeVpCUE82VEw1QkxDVjVxOUZ6b0o2bC9mRGNVYVZiN0FidEZn?=
 =?utf-8?B?cjdtZGNlV0xXMFlYcjhrVFlBWktOZXFXcVZZYUUxVXAyUWduaGE4NlJKdi9Z?=
 =?utf-8?B?MDVwT09JNVFIdjhhYjVHMWRFckNsLzhmOXFoZUxQWDl0ajd1RmNGcjBSOFl4?=
 =?utf-8?B?TEdzKzc2MHNhK1p0aWpxQUtNWWVkMWtFNS9QTWlKN1EzYW1CdWFlRFVzSjJX?=
 =?utf-8?B?OWZjUmhsUjJDM0tERUFJTUROMk0zd0xSUlI2bkFGUUFwYXN1SENMYzZRdUND?=
 =?utf-8?B?aDR5OVNTa0VsMWYyYUJLV0VuQnhXUG96eWxwUE0zUkhOVktUeDRPSWVrYXNF?=
 =?utf-8?B?dU5rV0RPU2VVaUZsaHo5ZmMrTERKOXZaZThyZkIzd3RndTM3ZUFUNWIvUWxX?=
 =?utf-8?B?NVAvalZqVUxha1RTUEI1V2lTR1AwRXJycGJrM1VOQWVUZ2taSlFQZTkzcFNi?=
 =?utf-8?B?RXFzc04rZUYzSVV1RGF6eFVWSEpsT2tpSnJaa0wza29iZ3FWcGNKZWhxZ0p6?=
 =?utf-8?B?WmtxdWIwZUM3U2RoK1ZILy9IOGp0eUIvVEwvQm1jZ05NU1h2Z25jNUFubHRk?=
 =?utf-8?B?WUx6S0RDYTZpb3J3RDVSc20rbWZLeis1QlVyZ3ZNK2hDMSt6MHhuZEhzaG93?=
 =?utf-8?B?OXp2RXhOa2FKYmRvTzd3OVpzMlZEbEtoSVZDUHpldzV1cWtYS01JUkVWMC91?=
 =?utf-8?B?STdXSU0rQXcvODlWUVZqYjNPZll6VERRZ0ttcitFRzJaT0lUM0Y5MXc5T3pM?=
 =?utf-8?B?N0xRNkkzT3QzZUx1Q2VYRTdyK2l4L2NRSDFsZHp6VnpiWFN0Q3EwSkxxRW5J?=
 =?utf-8?B?eWZGZFA4K3R5K2xGUDRjUzUrZ1Zmd0FMSExJM0tWRzY2L2NXckpKNVdxS2NV?=
 =?utf-8?B?NlNjTEE1QytYeDFWNm0wVW1DdlRER2VHMThNRm9JdzIrTG5LUmhpc2RkS2lq?=
 =?utf-8?B?QmlYdElqdzFBdG9pVXQxN3JETUh5cTJyZkVYR01pSko1ZUpGRzdTeTBwTFAw?=
 =?utf-8?B?OCt0SnRqbEgvRnErZXR4aS9KZTM4OHZLMXprdG5xa1VsVHJkTWNTUGlwc21Y?=
 =?utf-8?B?QmQ3UWQ2YWNZRmVEZ3pKZXdMeTFiWit1MkNGRDJQV1preTd2UTlOdmFJZldL?=
 =?utf-8?B?RGpZeG5DNHY2WG8wU1ZmdXlES2dzRVhXSC9zM21sTjVrRExyTEtYZkFPdW9R?=
 =?utf-8?B?Z0Y1VjYxZ3BHbXIzWE4wd1dZWmpIelp1RTg3OENUaHB5VVVDam9ZN3kvbEVm?=
 =?utf-8?B?ZkFXUTQvN3JYWWltdmNYdTVaeFE3VGZHaFRhZ0N4Z200KzFXWmZ3QUpSS3U0?=
 =?utf-8?B?WlZ0RnRGY2EzRVY5QUJ6K1dMdVFCeW9yREFnSWE1THRxVnNsYVJGZVN3R0xS?=
 =?utf-8?B?Uk1ERC91c3MvTFdjRkZoNCs5VkhLUDB5QUJuaXprZFJwczlId1MvZ0RBa3RW?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc3f52d-f5f4-4519-134c-08db23ca139e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:51:42.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtOf9M+jgfYMkpkArccjWntzF4Q9CkUgUFVQ7cMHIPixFmpMQuB58LqlYfN344ujC9AZj3pnh/bgvwsJehTRbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 3/9/2023 4:22 PM, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
>
> This adds nested domain support in the Intel IOMMU driver. It allows to
> allocate and free a nested domain, set the nested domain to a device,
> and synchronize the caches when the userspace managed page tables are
> updated.
>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/Makefile |   2 +-
>   drivers/iommu/intel/iommu.c  |  38 ++++++----
>   drivers/iommu/intel/iommu.h  |  15 ++++
>   drivers/iommu/intel/nested.c | 143 +++++++++++++++++++++++++++++++++++
>   4 files changed, 182 insertions(+), 16 deletions(-)
>   create mode 100644 drivers/iommu/intel/nested.c
[...]

> +
> +struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
> +					       const void *user_data)
> +{
> +	const struct iommu_hwpt_intel_vtd *vtd = user_data;
> +	struct dmar_domain *domain;
> +

Would it be better to add the following check ?

     	if (WARN_ON(!user_data))
		return NULL;

> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL_ACCOUNT);
> +	if (!domain)
> +		return NULL;
> +
> +	domain->use_first_level = true;
> +	domain->s2_domain = to_dmar_domain(s2_domain);
> +	domain->s1_pgtbl = vtd->pgtbl_addr;
> +	domain->s1_cfg = *vtd;
> +	domain->domain.ops = &intel_nested_domain_ops;
> +	domain->domain.type = IOMMU_DOMAIN_NESTED;
> +	INIT_LIST_HEAD(&domain->devices);
> +	spin_lock_init(&domain->lock);
> +	xa_init(&domain->iommu_array);
> +
> +	return &domain->domain;
> +}

Thanks,

Jingqi


