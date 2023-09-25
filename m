Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FE47AD04C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 08:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjIYGhp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 02:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjIYGho (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 02:37:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8C1180;
        Sun, 24 Sep 2023 23:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695623855; x=1727159855;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jKJ8V362BQdHWqFbTznKMcA1eRLGZdTPHqIMHIbNdt4=;
  b=C0rI1InHdab7PrsMV/dodtGK+OsqPvA0e64O91l3qtbz5241E94p4r4P
   +E0obHys9LtJA8mII/I+ClHWNaaA4D7O9IiQWEkiZmp2RGMYEh0C8ZB7A
   rBWRMZUfbOfFt4+pbHtNF/i88zFFsRYnmizdMhRsMApP44mP98pOq/PJa
   ilruUB5VGlBv0AKR3+mfIcxFYDPZogoi16srSW7oTnGit5x9AwvxPzA0Y
   rH1ciTyi5GGDK9TshNVZdfNuo9S1YuqFuJ03FkelVZ1EouMiXXpREhT+0
   aImXntO2bW0ENmIIfNcY6rFblyYZeRqlyk/Y2qMrK6MXN/8tqBjUE/sdK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447664731"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="447664731"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748246909"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="748246909"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2023 23:37:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 23:37:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 23:37:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 24 Sep 2023 23:37:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 24 Sep 2023 23:37:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Swd2q0+QVExZUHmiUIz784mTT9N7a1YBOFvHGtdKZ42yazJSf0Q0A/2na7YZFpFmlJb4j1AFJxuZywRJBdmKZz6gioZbZuZ6CZHAIb0/94xSOK7lW2HGbvD1ihYITjgGWIe5AbHnXVxhrk/xL2psEMRamP5qM8HzyrM1dbML4Lyi6s27RA4U+7HDi+21cPlHp02jsWxNvhv/QFzzSeOYDA9QplwgOGTsNAbKSXUdqUEGyDchVb1UBlYT5Yz7Lu+x6YTc/Z05/YFfJL6zFgQui7tTMFK10Y3XfIcJsfkzc1911cqAKfu23CohjIgmjS63ZZdnmbKA6N3qJtXdD/Zo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mZTRiTgrzdELmEk+ek/5ictgxweyoh7+BEkMNx/iuQ=;
 b=cJEZczaUmltm2vXLUwGqvg41unq67wJmLml3QlqlNl/9kv1MyZ7Dae1S7f86wK7284GpKr4t73yRNxQvP62T7Jcr/kqcD0Adz+VQXzIzdz+u29Nkn7yGy/KHh6baHgLYGmFkBYJNZVbLAShgTI/ygEsc38PGoFqfY0DFLDLZwhKodoK+L1+yinvyWu+1ZvYCYef8DTSf+zBn+WKt8w726FvEqAcU+7LLE3H7nP9OAgIv9+6mjRmp8Mm6rocfylgmQM77xQJBSR75asr2GESzVjppzOri/0NSZOV3KNFV8i5BEMfCX35yi1sk5XPozlBnW7eq2mYf201ieGjaQ9OWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6090.namprd11.prod.outlook.com (2603:10b6:930:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Mon, 25 Sep
 2023 06:37:30 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 06:37:30 +0000
Message-ID: <740a4ede-4eaa-2775-ac31-3fa7c905e201@intel.com>
Date:   Mon, 25 Sep 2023 14:39:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] iommufd/hw_pagetable: Support allocating nested
 parent domain
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>
CC:     <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
        <joao.m.martins@oracle.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-5-yi.l.liu@intel.com>
 <7d07bea9-02a5-7113-8cc1-f7aed073cf96@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <7d07bea9-02a5-7113-8cc1-f7aed073cf96@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY5PR11MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ffbd7a-8d60-445f-c766-08dbbd91e43a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6eIaf/Fp+fh85K5cId8knpsFttCKn5RV7qTPbYqE573cxNYfPplfyRxzkzq+sKPTd3fSnZV3qK2q+Zod1lpkyu166G570PP06NLwwJjP82QTUXJNxL2eBMsz/2Hv7hp8dPrXJpqpiw08zZB2lMepPyjv6p1dH/F+BqUD7r5cnvd5kSRdiSVUXXls+hC+JQPIGx3OmR1YglZIfp+1VavFIs7Eus6RI6Ca9d8sxtEKlXqJa5pRStita5a3fYDJy6F2KZBtTGbZvM1t3E3Gyfg+YmKoPyhrmRPKT0YkNByXsgSZm35GRUhoEhSdCbdmaBmePOBslXGH5ANssP7y/wpTPZHXONMZAVUx22lpnXBpPqCdyOz8/1gnVuHccxAQ26DfrPma9S5lrMeV/7I7dnkeToK/YWF3OWx8YRd8N6V4D4OHg8oT7MLKweCpkRJbTX0g2YondfbHIcaWrSNrLEyk/o4Rm/JcyhdQ6PFQwFnbhoBOZihz1jMhLO9Es+r65BT+nDcS4wqe8ZW7jYgjkGkSmv8ZPVDav649/l+41GLjhrakbaTGylX3pM32cmrOPVQbx3yiE2xpa14OrbWry02eUEPng7EAhNpNKNepEzrOtKngtIu/FKWFayT4P94qS5Eg7+mBEl2vaolGyy4wMvmyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(6506007)(6666004)(6512007)(53546011)(6486002)(36756003)(478600001)(5660300002)(8936002)(2616005)(66556008)(66946007)(316002)(7416002)(2906002)(26005)(8676002)(4326008)(66476007)(31696002)(41300700001)(38100700002)(82960400001)(86362001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpMNm5rOEZ3UEVkNmNoeUxLZVFOUnB2a3pZa2Y0WTFvZ3kzU1FCcHZlZ3Zt?=
 =?utf-8?B?ZHQwdTZsN01LYjg1K3V6NkUycjd5WmFYaWw1RGdqa29Hc3dkUjczeWJCRnY1?=
 =?utf-8?B?R2dJRk50SVB4YUR0UCtaMmFYUnJXYnJjSUZDYWhpSEIxd3lYYXlYRG0vUHlW?=
 =?utf-8?B?YmhuMDhQODlnY3J1QStBNCtZcHplb1pKU2NYSzZrWDlwMDkza3hkSFR5UW9j?=
 =?utf-8?B?TDM0ZDUyNHFCOWVteWdZOWQvcDZabkNCMFg5RlF4enRpKzdydHhoa2tWUzRv?=
 =?utf-8?B?WVR5Ni90STcrSWpYTFVYVzAzRVlvbjI1YVZtQldUYnZ5SWtla25YalF5Uy9I?=
 =?utf-8?B?aC9ERHpOR1hYRHN6dmR1bjFmLzQ0a3pGM00vamlVZkpJcnRpU3I5ZkpOcGk0?=
 =?utf-8?B?Wjl4V2lPOXZjMnZ5SjRwQ29HZitEdXo4SVJacEVCVVpMOGxKdm8raVhLSlhx?=
 =?utf-8?B?S2ZrTWlVR0Z3L2RZa3RQeVR4OTl5cEJSRkI4UzF0b29KWnloTkRRS1psb0lR?=
 =?utf-8?B?VURyaXdya1ZpdVd2YnNnTFV4bllpc0tFaXNkVVRlM0Y3cXBjU3IwVG9JSlNa?=
 =?utf-8?B?STN3dmpCYm91Znc5SUJYcUJ1SU8xY3F2Q0pza3lpUGozamZPaHFlVDNwV3px?=
 =?utf-8?B?TDBUSGEyQTlISk56KzByZ0h6bFBTclk1S0lOeTVDc2F1U0pRL3hZK1g4SDB6?=
 =?utf-8?B?Yk01MWRrd1dBamcyTTVLOFkwSEFCM0szZFNzaHhXbTRRZ3AwZ1VKNUJnaTdC?=
 =?utf-8?B?b0x2Yy9VaU1zVWdIdWsva1d1TGh4eGZpSU9Yd1dQUld1NXh4VW1tMFdQOGQ0?=
 =?utf-8?B?NlBqTTh0UEUza1dObzB5bzRveE5MWWppN3F3T2ZMRnJCdXkvUjBZWU42Nm1i?=
 =?utf-8?B?eTRpdWxGRmV6YXFDaFRaZzBqUm5aUEZBdHlEcDRNZnUwVHdQVTBZZUVESit3?=
 =?utf-8?B?ckRQV3Jqb21XZjJqZ2dHdUJBajI3djhYcW9vUmExaDU0UzBUci96OHhtWk9p?=
 =?utf-8?B?ZUJCS2lvejd2VmVsRjlOR2pLbTVMTmpVVmV6NTJMb21wUXBOM1NEbW41cTZ2?=
 =?utf-8?B?LzhMbG5XRDQreDFMVHNHcmJQYTBCM1RhdGU3NnNzcEJkbTF3bXl4Ly9SUFgv?=
 =?utf-8?B?dkdHL2dTSWI0TXhPTmY1QlF0bHJJNVNkRWFFcndPZHdhdkhRY2ZPNSs4czBU?=
 =?utf-8?B?azdqQ3VLbnZtb2NNZGU4ZGZXY3h0SWx4UUNSMzVzWlpVRmF1L2wxOUl1UWR1?=
 =?utf-8?B?endYY1pId3NqWDFFbFZieEVQYzIrWXBrbmNPREJad3FvT3VNZ0M5c1FtVGx2?=
 =?utf-8?B?RUdzMFFGdm1jejU2bDVVdEVpdXNKK0VkaVJsck9iQ2dhT3hqenVhUjh1bVBF?=
 =?utf-8?B?My9oTUdPUzNaMC9Jc0E2TUFmTHowb25nSzNxbmVvYTl1MnN2MDYvZzVBV3ZI?=
 =?utf-8?B?L3oyTzZ5elRFTmVuSGZaMTI0ZkRSTzNWc2VXaUU0ZHVTRjM2a0wvbEtob2xO?=
 =?utf-8?B?UjFvempaZnBCbXA5TG9OT0R4OEFrQnRrSW5OUmRmVVczaTJwRFJ0TDNYQXVs?=
 =?utf-8?B?K2U2NGM2QmxzenBTV1lQZmVONWttSEtHVDhHd0M5VEowREtzREZaSWwwQ01p?=
 =?utf-8?B?T3Z5dXBTaXhCaGVFMUxkdE1HektMSEZYMEFWbmJidlRCTEtaVjVYdzRrVjgv?=
 =?utf-8?B?Wm5zUStEWkhGcHkxTGt0RFFJY082Mk5RY05Remx5Qkk4L0hKY3NQTDcvMzFn?=
 =?utf-8?B?ZjArSWc0bnZoNm5zYXF3cFlBcEsrVW5sZEo2ZWF3S2hwcVV5UjQrR3JoSWkx?=
 =?utf-8?B?Z0xTOU9lUUp6bzZhVmQvYnd2dmU0ODFTVllxSjIvL0ZRQXR3S2ZEbVV5Z0xK?=
 =?utf-8?B?NkpkQkxRR1I1Q2UrN2lrc3c2SFpIYUJFV01MazZaWlJVd1hxbGtOeWxsOGJI?=
 =?utf-8?B?SjVUNjE4WnFlTG9hZCtLV2xRNU5adURZaytWNWR5NzNTdW5SdDMzRGlsSXRV?=
 =?utf-8?B?MlRZc2ZYS0prd1FmSUVHcXowT2wzdUdsSVdTd0tzM05SQkhSRGQ3V0I0RWJK?=
 =?utf-8?B?bUg1dlpxeHN4NkhKQ2ZXamNpU0pvOXIrQ1VEUUpCTEQ5Uy9tR1NiUmEvTVoy?=
 =?utf-8?Q?lGnNrLlw37ncbDH0x7mchRH+l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ffbd7a-8d60-445f-c766-08dbbd91e43a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 06:37:30.3087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZetsmvOt1frGe+8vW+L5LoUswYpQ2Vxq2/qYjleYNhN1vXq9fsvxEiI9BSbWz0EFfeZb/CNWB0aSlX5G7Ov6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6090
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

On 2023/9/20 13:05, Baolu Lu wrote:
> On 9/19/23 5:25 PM, Yi Liu wrote:
>> This extends IOMMU_HWPT_ALLOC to allocate domains used as parent (stage-2)
>> in nested translation.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommufd/hw_pagetable.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommufd/hw_pagetable.c 
>> b/drivers/iommu/iommufd/hw_pagetable.c
>> index 5be7a31cbd9c..26a8a818ffa3 100644
>> --- a/drivers/iommu/iommufd/hw_pagetable.c
>> +++ b/drivers/iommu/iommufd/hw_pagetable.c
>> @@ -83,6 +83,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, 
>> struct iommufd_ioas *ioas,
>>       lockdep_assert_held(&ioas->mutex);
>> +    if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ops->domain_alloc_user)
>> +        return ERR_PTR(-EOPNOTSUPP);
>> +
>>       hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
>>       if (IS_ERR(hwpt))
>>           return hwpt;
>> @@ -154,7 +157,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>>       struct iommufd_ioas *ioas;
>>       int rc;
>> -    if (cmd->flags || cmd->__reserved)
>> +    if (cmd->flags & ~IOMMU_HWPT_ALLOC_NEST_PARENT || cmd->__reserved)
>>           return -EOPNOTSUPP;
> 
> Need a parenthesis here, otherwise the compiler will interpret it as a
> different condition.
> 
>      if ((cmd->flags & ~IOMMU_HWPT_ALLOC_NEST_PARENT) || cmd->__reserved)
>          return -EOPNOTSUPP;

ok.

-- 
Regards,
Yi Liu
