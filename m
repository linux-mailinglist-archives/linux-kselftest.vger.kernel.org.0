Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895467ACFE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 08:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjIYGPp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 02:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjIYGPo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 02:15:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450B1C5;
        Sun, 24 Sep 2023 23:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622537; x=1727158537;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1RFs13/2evvW0GEUFrpNdg22op40mOaiWlGjnlygTZI=;
  b=oA++gC6fTElzfzelXZ1aLsOhtbdjWXK2ocZeXvomy+KBuoc3F10JOaED
   /LVEah0ud/5VON/+ZHdLmy64F+WWYspDyZiGEVq0nZzOOZ9uO3p5d3tAB
   O31+8S/6VqljtM10Vvg4sh++c+xeSBxAsoCl6Lw8JNKtnu4xMXplIrOpf
   mMzpNAlyDEozGPDD31OdnOk44U5ZmrQ+807PRy/Za2ZVa3B22g87ohasb
   8fm4l2aC7HGlG3pv4JpHnEhOeYafnIUMSoTvqofSSZGEQSDdxQBb/Tn+l
   wWTywgFzdM00h5Yk8NOHHcGBwYt81POLrL1ufRajy6gcsuRhO9vK4GItA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="383934501"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="383934501"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="783350457"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="783350457"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2023 23:15:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 23:15:26 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 23:15:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 24 Sep 2023 23:15:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 24 Sep 2023 23:15:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYktEagej6vHhae6RBDVolUptrDi2Myq7tfR6YbhBWPOT7QYBWEYnuTQnwkwZE5+C2Tx7YPSLATTruTqu1bauiVIbYzSvoLtmnMdglpK0mrozSBZQRDVCl5AVbsc21SX/yHeEijcMX46gQKRiSWu9lSXaYS/Ypwyg39GbwbAvxe4hB3CnZAB348cdTv4pZ6OOVf3fTktY2kTlN0xXaGKJDgslRXk7r9CfCRQM45w3ijBPUbWJSejvs1QvIDu3x6F0JvpQjhItTE1kGBSTORVEI+EbgIrXUU0pKu/SVFghGHjBVSyow+hdeUIZYP90ZXyPEwVlkmOtLpR31VRNHSDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXXmybq6dYQ/Q3KypcNhar7qEhw5HU5VN3NZgCBpquk=;
 b=TX8JbREMa1n+q/UKnlCBfU55bHF5QpqAVkqEacnh0bDh8ShiWyOSmTtBVft78MXk3/iRcJIa8ojiGH19WBN6Plf6ttcLNqAwJfgr6EzdGPqX2a0shkDbjB2WJUr4nMogLj8IH/WBFWGQQCQFPx0p4tghgtYFYXiutQw5hDo/KjpOZeEiq9AhhYjKpu6MrRN4aM+2wJUOm0HQJRaxfTvgn3/PO50opG53hsakZCgUdxuIJoEOc5zbGoNMeDpi060emqbO9teDRqG4OqrAQCf5mzsWNeBVz9YbGyxTNAyhx/Y5PEJrx+r6McfMtC/6DrfR5uTLPMxvcqAvt+NAjuUtPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Mon, 25 Sep
 2023 06:15:23 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 06:15:23 +0000
Message-ID: <94004987-3cab-9fde-a231-7c63ac88a866@intel.com>
Date:   Mon, 25 Sep 2023 14:17:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
To:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>,
        <kevin.tian@intel.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <0d37a1b1-e7ef-fa73-d17c-629cd254ae75@linux.intel.com>
 <20230921164447.GQ13733@nvidia.com>
 <dcde6757-8d14-6460-c75e-c30d69219e4b@arm.com>
Content-Language: en-US
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <dcde6757-8d14-6460-c75e-c30d69219e4b@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 6262718a-fb85-4c31-2c14-08dbbd8ecd12
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BywFCGd/33qLlHA0DMaHzRtD10msPb0YJU9+x6ANwba5sqZYz+7o3XxzKfeLIV03Xi/FWinzW62nJJ5d2o/X46/w8O3TXWWY3utls3Hqp6UH8D6I52oX7A+dYCUR+Wtu4gc30li2Rz32HDc7g5yjWJ8kmXqFCbJWe5yk0xuELRSxDnQau4JUPdt9vU7z/SBrbnBbm/pTlNz50NQuD/rmeEOc1t5wpm++vaDrXBgDS2HKRkM4dNWs1QE5GYG1tEVqdNuhXyTRqnX2SvLpAhGwGAYRQmqrt+eMrRAz7vhcFvRUymhNXNXFXYs1MSK5h2LBjKoGjfkHGJDOYGB6A19WiFN/aQeapiQvIR0TxTrjul9DOpoMgj/StXOldCIXyHklSQopmryjKgWsiGsDrd/J6Rxi9ubEZEwFjCEhXhPJu3ungZ95iGIjC31IyqaWNp/RnUEwQo2q40xngJoRu1jnUEdfE/9RdTQjpXpNOr8T4S201iIKQX8cPnmwA3b6M7Iv0oc/P/Q49/W+54lkhtF7MBA6DvR8rfre+F+NmX49ZVWI6BiKYNlw1v1Xhu6xX6o4XhPR1QzQSmu6fwR7GK4B+uHlljbAwwMidR6kTNtbK66yvy33bqXRXNpr1q9/AHxnaZDQ6Ob2oYXHXmNmKG+eWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(31686004)(6666004)(6486002)(53546011)(6506007)(4326008)(66556008)(7416002)(82960400001)(86362001)(38100700002)(2906002)(41300700001)(2616005)(31696002)(66476007)(6512007)(26005)(36756003)(83380400001)(316002)(5660300002)(478600001)(8936002)(8676002)(110136005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWJRbWdXalBUbU12VkhOL3dtUlNwdjFseFBmb1FCN2RGVXBScEo4amZ5Q3NM?=
 =?utf-8?B?ODJWdWJOL3NYd1ByMlg1RWJFSU5xVzhYdkVJbmwwZlJKREJ6VmlKYmNycnVZ?=
 =?utf-8?B?NUpPMDBIWnJZM1pLT29hVjZWczhVM0JIT3h0TWhnZHVIWFZuOVZSWFdDMDlG?=
 =?utf-8?B?Q0JqNFZiL1ZjM0pNUVI0TmZmd2hzMVo1TEJwdlkxM2Zwd3llTEw3SnozZ0JO?=
 =?utf-8?B?ZUZpUC85OW5SSmcxVHJBZWtiblo1N3E2dE9xQVRhWEhMc0lSeE9KdEF2K0RS?=
 =?utf-8?B?V2tqTGhRMjRrRVVQTXlyMWlsQnRtNFYwRGlpeTljTVlGQjN2MjZXSnRzYmp2?=
 =?utf-8?B?aVE5TTZrRktLeWhjUWhPbHo4QThJK01OQllWTk9mUk9meGcyMHozSzZlMTJ2?=
 =?utf-8?B?Vk5mdWY5b1lTM0pZOWF1MEpsQ2kzVzhlYW4yMFlXNUFqbXlWRysyT1RMZGwv?=
 =?utf-8?B?Z29tcFhMRGw0akdJbUpiZWtYL01VUUs0VlF1cGtJdStuRm1QYmNjcUlqYVJG?=
 =?utf-8?B?MXRlWDhuZmdwdGdWeWFMME9uZlg1VUtZNllCWEN3NU1XL2dzRUkzZi9DaVdV?=
 =?utf-8?B?aFB6cUpJanJBZjdXSERiUlE4VlF4K21CaWFiMFJaVmFXYndHd0NJZGJKME5u?=
 =?utf-8?B?djVwSFE1NkwyUzJ2ZnhuYlR6amhQNTFnUEZJaUFKU0JCeFpNMGNVUEsvQldM?=
 =?utf-8?B?cGx6T3VhRFlwY1NQcGlDclhJVTVwZU5HVEVnMFhlY2F3N3lYNW5UUGVtRU9M?=
 =?utf-8?B?ZFprMXpMY2JCL1ZtRmFEN1lGRTZidndSSjhOczRpa1Nib1pYaFhHalRrWVRu?=
 =?utf-8?B?d3RSaU1jNmc1cEhqbGVtTExob0JKOUxFYlB4OUZpZHNXTHZZd1hQKzRaNEo1?=
 =?utf-8?B?WUNCM01RdjBzQ1RCL2cxVHpNQnpGMitVUjFBRHNwbXNnQ2xEWjJOY1ZReU04?=
 =?utf-8?B?VjZOZk1KT1pzYUYrTjd2cTU4R0ZWdU8rSzcvMXlLakJBSTJWUURWOGhWaTZp?=
 =?utf-8?B?b01IM0JweTZ6UDY4NUNpTHJ6RHM4QzVReG5YTDQ2NXplTkhZcmxYZ2JlbXQy?=
 =?utf-8?B?bzNrMFB0VVdibFhkQ0hoL2d6VHlTMUNtbHpscDlnM2c1b3hjd2pkaDIya2F3?=
 =?utf-8?B?b0x0Q3JmN3Nkd1phMllDUXpVWXVMenRrTjZnNktIdTErWlRDY0w2YWtQWS9s?=
 =?utf-8?B?MzlxdHVzR3FqeitoUDVsVVgvUlBCWjJjQnpZSHFWcGF5ZGozaTJsS0MySVd2?=
 =?utf-8?B?cUwzbnc1c0xhbkZiSVcvbnB3SW92MGxqQmhYMGNFMjYyZHM2Rk5UZk5oN3hD?=
 =?utf-8?B?dStubjJZM3VlYzc0aTl1dGdLNzIzK0kvQnR1Nk56RHQzZVN4S1JYVGdEZHFE?=
 =?utf-8?B?d1NhWGVxU3NvUms3SlNkb0hMWVZxUmthNnF1YjVNenN6OGRTa1NCWnJ3dk0r?=
 =?utf-8?B?STZuRTBIcHB4KzRDSmRubmxSb29VTWR6L25FOEJLVFE4S1hmSHh3UlBwb3Bl?=
 =?utf-8?B?a3ArcHY1SFlhWStGNDNic2c2Ym02NGorSWRZRlF5eVE3MDZ5Y1ZSNlA0S3Mw?=
 =?utf-8?B?Y2VBUkpSM3pwNVpXMVJLR2FoUXZvb0FFVThicExlRjRQMXArUnlLUHRpRWdr?=
 =?utf-8?B?MDIzN0ZrWXpxcDVxeHdIOUVYSFJLWGF1S3JsYlFyeEhiQW9wa09pSVY5cVoz?=
 =?utf-8?B?cGtHTklOUmFDY1hET3EwUzMwdVhaTytmZ1BuQlhUMVJOUVI0VU9rdUVqdThJ?=
 =?utf-8?B?aGtxV2lFUkpYVjFzZ3drUTdCSE16dXdrN1dRT0ZzRE1mWjREdlN1ZWg4YUpi?=
 =?utf-8?B?alZudkdGUmxPb2dBWnRrMHllTk96WHN5c3d5Zk9rTXlRcFh3eTljUGl5eEls?=
 =?utf-8?B?R2JBaEc3NWhoc015ZmlLTjl5cUFjR1VKb0JVZTlrZjJXbFdIeEV4QmVXbE85?=
 =?utf-8?B?KzVpYnUvNHg2LzlucC8zSHRuK0RhVHFZY040VHp2cFRpWGpwVWpjck5uQnBE?=
 =?utf-8?B?VWg5V1BKSGZkSzcyZXhkTWZZVUUyWjBnN3ZBVmRZMEpwZVp5Qmx4dUJjdXB6?=
 =?utf-8?B?MEZCRWdxSlNFNi9SRW9vYmdkR2VyaG1vRUJtcjRJb1B4ekJSdDNudWlyWDJo?=
 =?utf-8?Q?FK3FYVr2IJqMA6QzyErJDJ8zu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6262718a-fb85-4c31-2c14-08dbbd8ecd12
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 06:15:22.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8YXp5cpcNTyje9SKd/MAC5lQ7RCu7E993I3E8bHIGHhHQX17YVIzv+j+er46EiNDsaHzg1V5tOmBpdb5NXlzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8441
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/22 17:47, Robin Murphy wrote:
> On 2023-09-21 17:44, Jason Gunthorpe wrote:
>> On Thu, Sep 21, 2023 at 08:12:03PM +0800, Baolu Lu wrote:
>>> On 2023/9/21 15:51, Yi Liu wrote:
>>>> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>>>> index 4a7c5c8fdbb4..3c8660fe9bb1 100644
>>>> --- a/include/uapi/linux/iommufd.h
>>>> +++ b/include/uapi/linux/iommufd.h
>>>> @@ -357,6 +357,14 @@ enum iommufd_hwpt_alloc_flags {
>>>>        IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
>>>>    };
>>>> +/**
>>>> + * enum iommu_hwpt_type - IOMMU HWPT Type
>>>> + * @IOMMU_HWPT_TYPE_DEFAULT: default
>>>
>>> How about s/default/vendor agnostic/ ?
>>
>> Please don't use the word vendor :)
>>
>> IOMMU_HWPT_TYPE_GENERIC perhaps if we don't like default
> 
> Ah yes, a default domain type, not to be confused with any default domain 
> type, including the default default domain type. Just in case anyone had 
> forgotten how gleefully fun this is :D
> 
> I particularly like the bit where we end up with this construct later:
> 
>      switch (hwpt_type) {
>      case IOMMU_HWPT_TYPE_DEFAULT:
>          /* allocate a domain */
>      default:
>          /* allocate a different domain */
>      }
> 
> But of course neither case allocates a *default* domain, because it's quite 
> obviously the wrong place to be doing that.
> 
> I could go on enjoying myself, but basically yeah, "default" can't be a 
> type in itself (at best it would be a meta-type which could be requested, 
> such that it resolves to some real type to actually allocate), so a good 
> name should reflect what the type functionally *means* to the user. IIUC 
> the important distinction is that it's an abstract kernel-owned pagetable 
> for the user to indirectly control via the API, rather than one it owns and 
> writes directly (and thus has to be in a specific agreed format).

yes. It is just what the existing domain_alloc_user op does. Here we add
a hwpt_type as the type can be given by user, so we need to define a 
specific type for it.

Perhaps we can also name it as IOMMU_HWPT_TYPE_UNMANAGED to be aligned with
the domain type naming. IOMMU_HWPT_TYPE_GENERIC is also a good choice.
Please feel free let me know your preference.

-- 
Regards,
Yi Liu
