Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E2C7E524F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 10:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjKHJB5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 04:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbjKHJBv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 04:01:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9F71730;
        Wed,  8 Nov 2023 01:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699434109; x=1730970109;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JrKd/FpYYdxtRgSOfkdwfAITwFk9FYcdWxpQYPKkCSI=;
  b=aO4FP1SHBe7+kFZU/dgwnk9GZQIbWNuJsZGrV5EFj4X7sc6S0Qflu1Jo
   2sBJnDgTazVDPjC1N86ZacfiNFcYirr8roREu98uu0NJmtVKIox6so34q
   v5HVqjZNSYAXTBmHb0VsqoW5HzMK1gee/VbOeY2bxYQj0JCil2yzT6b65
   3dkwU7laMQ7/E/Qv595UIiqui7krX/xC2pBZm0KUJuoOWMFVFeV+ZYnMV
   higTckHbq6xX1jgzQ/GEeUyKqCSE7Euw6S+vtE+XLxbRcvBlE/DsZUU1m
   Kg+QkzZ25X9+YN3m+ErKgeOqEtVOE2GY/CruwP5eYE8tqeEsTD7c9Qc60
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="369925996"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="369925996"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 01:01:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="11124743"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 01:01:30 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 01:01:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 01:01:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 01:01:30 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 01:01:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crsk3O94y5KwBSJJdNW7nPFm8Kju0PLpnFnVnBjxYTIuUUxnNsnQJaL4KnYWwBINr+JDr1JQbDadRU9s4fekfeY2VB0lf0Cvq4RDAhyAd3hsByWIiaeIhv2dkFxstJUjKAI3X7RsOv4pDSoid/Qa/xzmqB6AxqFOEEEwjmgWaY/PgprCVogA52Y3xbmx8o4fmJ2zzxetEtJrN6ORJLWCFpFbJ/FI6tdbmpDy3achdvgHBFDp0GIeloDDHk5ooloUij8HSQuqjDFAjwXVcHRkmAfOoiJc0lpBHNipQqlMy0cqIoGJdbMTPPG1lagI9gXz7lgX8FcWs9W0a8eAGW3Pew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMA2lIXg8511KNRRObnvfdydJiBlSLzUuINzr+tLvgg=;
 b=lpBQGKtYw1Ze3y0/iDWojpJ2qrAcwErOxJIFBfCKnevAfmbJNLkz182TKwCdTKlpI4tARP9Z8L8Iowh45T2ADHRcjpUDhMX8xW1sh7+alQLEaNNUhHMDyZTJcGk15nnxiEUAh2IMGumOJ/pZqVkOhfpo1mZwEsUMvjMPWlCGegW5iHhwe+yCx9Wb+EQYLVtLHO8bBFnLDRU2Umw+ZwOUyTdwStYc4jh5i/XX6lS+QOjalGOaJj1Lwg2bxsomo1aQjN+LiC6N4pnovF3vU0y5X1PhxbTFYOeqJjfxGbdvqpmdc7roJ6ZCuX94wuIeIm6d4vvuBnV6GjU85W4uB5ayiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH8PR11MB7118.namprd11.prod.outlook.com (2603:10b6:510:216::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 09:01:27 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%4]) with mapi id 15.20.6954.024; Wed, 8 Nov 2023
 09:01:27 +0000
Message-ID: <8aa35b4e-6bf1-461b-8d7a-5331dfdc3934@intel.com>
Date:   Wed, 8 Nov 2023 17:03:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/7] iommufd: Add iommufd_device_bind_pasid()
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
References: <20231009085123.463179-1-yi.l.liu@intel.com>
 <20231009085123.463179-4-yi.l.liu@intel.com>
 <BN9PR11MB5276BCF486E9E4F24913883E8CCDA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <0ea819d9-1169-48b1-8579-3a054a0bd077@intel.com>
 <BN9PR11MB5276A47616E386F00AC50D728CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276A47616E386F00AC50D728CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH8PR11MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c55044-e394-4175-29b2-08dbe0394a43
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjIpLP0lfOsHPtgzyGo7hNSnKUVxOv953Fa8eobJI1ssf72lwYmRg9vG8hFFcBOw5WwwxG1RoKKht69x7iN5JgPYOxHHkt9s/rjOYFbXMqlMVyHnQAReL2w/s1vyMBPywyGrYlX+yE8P3Kcr93gdkGDnjibxklTkVUfeWgMtdc0MAVIAM2gAlqC0VskiaZpI8QYt5/w1FE7uDDUAWl90dAavBM62REtC2p93lc7PN1JaLIeKy+72C/zwFQQen4YRlO58zLaUnpLr/mxMFsagUrWb3Xytw4aB+WCIJh5NJUWww9iw0Q0S5YMb8d1voAs+DO04NihWgbpIRnosVIq9KQIXpcB47WeUmg1aT3V1kA2pmeLO7QAgqMFyfPfoHSG9WKFXqvKahVNhwo/txe3HRACgFZE+twge8SBoasXEP3+IHEOPy38MaDPJROExdm7UGRSDJXdTjAN8+iKbh0RH0LR/1BRBy8Kw0GVoltw2gwcvXvUL4j/X8y9/eH1KF4ZplaW16p8u1eBopFS8j2iIobMirjowzMhkyhX3YuNl6l45clIFKWANrUSKmTUHHpojJo/aWY6a2FegEiAgdUqGE+XLUac444MDVht+HX+EF9++18Hy7QB53mAXGncEd65CN9swx8R/oskVwKBiD1Q7uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6666004)(6486002)(6506007)(53546011)(6512007)(83380400001)(2616005)(26005)(2906002)(7416002)(5660300002)(66556008)(66946007)(41300700001)(8936002)(66476007)(316002)(478600001)(54906003)(110136005)(4326008)(8676002)(31696002)(38100700002)(36756003)(86362001)(82960400001)(66899024)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEMzWnQxd2NwQnlkTmF5cERXS1B4UWJDekIzNnRHS3JtL2g3bmdMQUFkNEk0?=
 =?utf-8?B?YVdwd056Q0dPRWdaUWtKaXlyc3cyclJSRkdWTWJOQWtadFFMNjlmNXRDTkdJ?=
 =?utf-8?B?aVpocitqaHkwQ1ozZTVuZHd2NDBGbWFFZmd4ZFArcXN6MkF6K2lPT1YwL01O?=
 =?utf-8?B?ODVPQm51bTAwTmJUd08wKzRYVTk3ckFKS2wyeDZLK3g2ZE8xZExiMEFVVWp3?=
 =?utf-8?B?eUVsSWRFOG1JeVBOSHI1YitpQTBBTXJLcGY0KzBZb3QweWh3MVplZWFEanFS?=
 =?utf-8?B?VDgyS0lPRmJsSzNoMi96NXBqRFArem0rcEtUVmkwZ0hGQjc2bGxabzdKaS9G?=
 =?utf-8?B?Z3Z4b25MUzdIOWVFTTJMZUY2eTBwSnExU3ZtRUV4N2l2TU8wMWoxYk1lYzJk?=
 =?utf-8?B?Ry9qSXFvT2pDbmpuSHdVWGQxeFRCcUlTSE1aQlAwaS9BaHl2ZjhaUGxpM3NP?=
 =?utf-8?B?VHdDUTR1Mmk4WjBLUmdEdDRGb1hKSm4wcFJIcjFWVHlGM09ZS3RWTGdzM2lp?=
 =?utf-8?B?blZQNDZyd1VGeEQvUHB0dHlXMDAwU1Blcm9sVy9VcXVFak1Ubmh4YXAvUGhy?=
 =?utf-8?B?VDkxUE9yMUd0SUV5SmtFWkxKMjFXem5tc3VIZW81WXk3MHpJU09GZnBuZm84?=
 =?utf-8?B?MFFYbjhJbHZnT0wrbzFNbklyWmhBWFpvVkN1eGJmVkk5MFFybFRBLytrL2tt?=
 =?utf-8?B?WHdaeGRETmVQQ0hnL3dpSUZ6cDhVK0VTSFl1N1NpMm9EaVBTa2JMc3VkOWF5?=
 =?utf-8?B?VGxCeHNrZGJBeTdhM25abUtrRVBSV3Z6L3FORlVGQlRPMmlCbVQxVnNnWHVn?=
 =?utf-8?B?RDhzQUpHT3dQYnBSbVFBdVNWNlpSV3EyQ0lBVFlXM09vL3RBSFphK2Z1b3I3?=
 =?utf-8?B?NVhaYnpab2lxd0hWU1E5YkZjbmlNWlhucWh6QTBQYllSYjBRUXlsM0hLc3BQ?=
 =?utf-8?B?MkRjUjR2MVhScE9JY3V1MjN4M2hpaWdEMGRRNjgvYzBXQU1JRTdQRmRwMWRa?=
 =?utf-8?B?aU1SbVFrMmZvbm4rL0tQVTFUcTZWSUhiVGxUZEpEUzlUTEJQVlJmREZsRW9Z?=
 =?utf-8?B?NFQwMHIvVVdIZTRLU3c2TFBDOXFiZGpPV2UvejF6dmdBYTNZbTJOYUxUL25Q?=
 =?utf-8?B?NHVmRjBRa01mUUJqcnNab1BYekdxYjI4NVVUMW5oL1VIanh2MHpLRXN3YzFS?=
 =?utf-8?B?WDcvTno1ZnY5ZHQzN3VDWlpRaFpqUzEvSUt5U0dLWUVYYis4cHd6UHFTdjRv?=
 =?utf-8?B?Lys5Sk4zbTBnQTVVQ29zOEV3THlSbDRZc0t5Q3B0dGNod3ZsY0txV0FyL3lV?=
 =?utf-8?B?bzJqV05XSThVM1lGSjFtRVlEREtZU0oxQW1WY2FDTjZBNk5RdE9oZ3dyMzNQ?=
 =?utf-8?B?MDJ4ZmtIZlVMY2tscFl6bDlrNmxNUEFUL0g5cm1HbjZYZ1NXelUwZnJwNVor?=
 =?utf-8?B?ZEk3VVBBRmxLZkNxWXBKb29MZXdMdUxEc0pJMEFic01qOGRWY01pSHpoZTFr?=
 =?utf-8?B?NjFoRjBoUnRiWnVkQjczSlQwT21VdDFBZkh0WDZ5ZjMzZUQ1S3RmVkVPdjhM?=
 =?utf-8?B?MXREZE9NTkNCTm8xN3dkdndUdnIycHgrZEhHRlYxWEJhdTFLUkZjUmVTWXZD?=
 =?utf-8?B?MlptNFpobXNZSW1EL2kvV3dDSWdVUFBCL1Bad01MZXYyYk5WcmtiWnRsSHBY?=
 =?utf-8?B?aER5cFZxTVpSRkZGWjFhWFRUSEFoRWVVeTFZNXlJcFhySjlCeXJVR3JVRFJi?=
 =?utf-8?B?YmpIVnhtUXdZOGd5VDN6L24xdW5rcmdtTlZiRmhndm9Od0lmY0xBcnB1b0sv?=
 =?utf-8?B?Q2NqK1M3eGlGTHY4K1lNZXdSbEF2S2l0c3plUG55djlzdzBkTlRtV05sdXNR?=
 =?utf-8?B?VnUyVXNralI1TUFoY1BFaGt6bzFVanZLd1V5bnJmajZPNHZJM0ZDbUxBZGl6?=
 =?utf-8?B?QUNjejIyWU1lQzVNQ0dKeXpkU0YyRVVHMWV5allrQUU1TFFoTlArNHROKzNM?=
 =?utf-8?B?TFBudVJqTXpablR1elVsaHRqNVlMSWhmb1grZDRyaEk5UmVXeDQ2em9mN1cw?=
 =?utf-8?B?UWRDM21rRGFPMThpZUpxVWNPTU1GZWk5TUpjRi80ZmY0amNNUnVLd2xVWGFP?=
 =?utf-8?Q?F/t/mTzCoqYHoB3N96Wwg/AY9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c55044-e394-4175-29b2-08dbe0394a43
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 09:01:26.9837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prWrS1vKi6NKdXO1NkZhGN4fs/lTkPpdia/74JFTycIK4XNxN4P/9Lq/usVFLgqZvIzwRAgTt/5d0D4mxHFkLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7118
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/11/8 16:46, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Wednesday, November 8, 2023 3:45 PM
>>
>> On 2023/10/10 16:19, Tian, Kevin wrote:
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Sent: Monday, October 9, 2023 4:51 PM
>>>>
>>>> +struct iommufd_device *iommufd_device_bind_pasid(struct
>> iommufd_ctx
>>>> *ictx,
>>>> +						 struct device *dev,
>>>> +						 u32 pasid, u32 *id)
>>>> +{
>>>> +	struct iommufd_device *idev;
>>>> +	int rc;
>>>> +
>>>> +	/*
>>>> +	 * iommufd always sets IOMMU_CACHE because we offer no way for
>>>> userspace
>>>> +	 * to restore cache coherency.
>>>> +	 */
>>>> +	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	/*
>>>> +	 * No iommu supports pasid-granular msi message today. Here we
>>>> +	 * just check whether the parent device can do safe interrupts.
>>>> +	 * Isolation between virtual devices within the parent device
>>>> +	 * relies on the parent driver to enforce.
>>>> +	 */
>>>> +	if (!iommufd_selftest_is_mock_dev(dev) &&
>>>> +	    !msi_device_has_isolated_msi(dev)) {
>>>> +		rc = iommufd_allow_unsafe_interrupts(dev);
>>>> +		if (rc)
>>>> +			return ERR_PTR(rc);
>>>> +	}
>>>> +
>>>
>>> Only MemWr w/o pasid can be interpreted as an interrupt message
>>> then we need msi isolation to protect.
>>
>> yes.
>>
>>>
>>> But for SIOV all MemWr's are tagged with a pasid hence can never
>>> trigger an interrupt. From this angle looks this check is unnecessary.
>>
>> But the interrupts out from a SIOV virtual device do not have pasid (at
>> least today). Seems still need a check here if we consider this bind for
>> a SIOV virtual device just like binding a physical device.
>>
> 
> this check assumes the device is trusted. as long as there is no way
> for malicious guest to generate arbitrary interrupt messages then
> it's fine.
> 
> for physical device a MemWr can be interpreted as interrupt so
> we need msi isolation.
> 
> for SIOV all MemWr has pasid then we don't have such worry.
> IMS is under host's control so interrupt messages are already
> sanitized.

sure. this makes sense to me now.:)

-- 
Regards,
Yi Liu
