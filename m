Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7931B7CA006
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 09:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjJPHBE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 03:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjJPHBC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 03:01:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05AF97;
        Mon, 16 Oct 2023 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697439659; x=1728975659;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lJ+NH7MFyJ3i4OSx30eWWuR5k5tk4/Gbf1I4I5BOT/A=;
  b=NOh0jWs3HaItdjiJ9VVZlWnzmK8HFUWrFUetsixCx4pElzU18RwzESyH
   9WFw/8hxU4EYcCpYF+H2MbvrqYeEVkVeHvL4V0bEQIlY5FDRiRbjCi+rf
   WbVITYBWfKS7t9OgdM5p1dyYdAtmUpzHhK2MwOo2wdKXwKVjp02nhWDf4
   Z1i+f445EKbIUsf34OZvxwRQAgaUW1u7eh5wlen937lSv6kuo32W9pYsk
   2BhFbNhH6OlzoNyF5E6+oE05+Eb2dsyh0hOtPCzlVlPRLjK/S/qQ6/Wc5
   8rDm/o9mhT1HLDK/DbhxZzS7NYQgnJxj16AGAj6LKwur8J/O2WInkD652
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389319171"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389319171"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 00:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="755582753"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="755582753"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 00:00:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 00:00:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 00:00:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 00:00:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/R+tFDSTaw/vcUREmGuehqhhbcs+sEsd+0w8Z31oVnnNGvWJvCJFsVf/qZ0BV8l7RcpZwrjazZiowBS62/lLzhqMUqPkhC689IqsdoeViAmTItcvhnB7zvj/BAkStCq4zPpNA0OSIA2fSU0+nw/TMX4zQNyCW67omTN6UGGkXx6C9lcbllbZz4ZQhlneUktwa+pdtO01EsP54rEnMsLeMKiTNDQXjUPgZnP7TWZt2dtnSTt+7UDGgxin11AVs6xCn+xJv8SD7j2tcRmCdpB+kxKbvh+TCg2kPQi1HW1YLHvafoWtB6M4qPADc/pGzgf8+W4oLJh8hRQ2xJq8vJB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scZNw/76PvruPW00lDUKup0DvyZ2e2YSvpMT3oKiRR0=;
 b=ZuFlLl9BprYr/JQgc7zMS/A3+jX+SSWbPJginxscVfLWvMwMqKT+Ah/u50rk7f6Q07tEYBFyEre8PNZJZSWwJpOcxkO36iVaq4/OgSDEK/jl0xBIIKNtmajsNneB0aFMJormwjvwjlVVln8U9RBQgzkjKNFDnhomnhQAxQoPBORkNz3g/eDDY7KYsmTNE+q0YjUbCjg30vyJ4tXrJs6a191kE9pV93mDxuJLFQrmBt/3xPJTa4w+/OdDheXHp7bebYJwdmnzKSu2ZDj1GVszPiS7hdX8PB+sYklKsnd9IV68iRUSi8rSJqoWKd7FANKAqQIJ1gbghCUXRSxWTzM14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 07:00:48 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 07:00:48 +0000
Message-ID: <bd6c6a0f-3b7e-ca7c-468f-d8fe7fb382fb@intel.com>
Date:   Mon, 16 Oct 2023 15:03:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/17] iommufd: Support IOMMU_HWPT_ALLOC allocation
 with user data
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
        <joao.m.martins@oracle.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-11-yi.l.liu@intel.com>
 <20231013151923.GV3952@nvidia.com> <ZSmvkxuEq7M13KYE@Asurada-Nvidia>
 <20231014000709.GL3952@nvidia.com> <ZSnmId5g2m/UnxKY@Asurada-Nvidia>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZSnmId5g2m/UnxKY@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 7037a016-7eec-4cfd-82f6-08dbce159fa6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOeAuE9mfw9ApuKfn2vT61YX/FWD8yTg0QFA7pf19Kz92xtU9+slsv8q655yJthfWoH/5C0zF1JFcNx74R/7WVFFj+Hi6qNjjdOpQbaXNVUjpVuzsKVZyiOhHbnO1HtNiIZWvzCmN5vv4kUeZzUNHwX5QTlmGBWTW+LpUDT4+ZVsnpfx8eiSSXavA0yLeERSMH0ZBX+o9B+TiMSo8mhPpSJdnCxo2KPCuVN0L+9+CboR7xFJQzwMTs0dRx3JyPVSUNkVA3W1yQkR4as6Jej7J8OwISHjTxGODe8WNWkrN3DRkjPtHmnob1/pxPgd/mXitLXLiD+fRaz8EO/pCSxiTVYc38Vtczx1a9qfmuabYsAjLGnUCC1XzUlJqs/7GavYTTPw0znxmgTz/YF7mGHqdARWzFzI9Gh+ny+exBom2iD7+unRYxHT1vjlkUC1T9sh9IYECar8fJDtCLvEMJ7+Uw4h53FUSfLlb9HImItLqwN047dvm7Wd6OFSWRom2ekwWYhh0Axm1Pa/sbXbkvZw37Cia7QTRxa/6HQ11t/sueqkOGdFyJWwBetmFRmY1viWDMFwMMSChO26lkL8QfOMhJNaQI3tIusbpL6VvptM6iB4N9GLxFEbqANqPdF0ZgcCSzmjF+AaDIvm26PJJYjWXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(478600001)(6486002)(6666004)(66946007)(110136005)(66556008)(66476007)(26005)(2616005)(6506007)(53546011)(6512007)(316002)(4326008)(8676002)(8936002)(7416002)(2906002)(5660300002)(41300700001)(36756003)(31696002)(86362001)(83380400001)(82960400001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3JVRytucHMrNTliMUxDZ2prMG1VUWsrNVVRUWhlZTFYdVQ3NEsycTd3Sndq?=
 =?utf-8?B?ZWxQOEdRVThxRElOaHZvQ3pkZHM1MVQzc1gwNGptdXJnRDJ4Zmh1NzR1Mmw4?=
 =?utf-8?B?b1BWK29aUWd0d2VIQjF4allvb1g3KzQ2T0NXdHR1QmdhTEI4QmZGbE1IekM5?=
 =?utf-8?B?SmNMYmFlVXdDekF3RXE3TmdkeDkrWk5YSTNodklRVHN1TmsxdVowYmdCOVNY?=
 =?utf-8?B?RWtzMlpOa1Y3b1VYdXlCSndyREhZMXJpd2VFV2FKdytTZ3MydVB4dlIwRlBG?=
 =?utf-8?B?ckZPNjFaNzJtRCtHRFVWaGdscklIOEhQeis2RHV2QmFNbDUrWnp1YTlFZXg3?=
 =?utf-8?B?OHNWb3lGdWZDd0Y0R1VoNk9Zdnp6WHhCbnQ5Sytjb2oyTmcrZVpDSm9JUUg1?=
 =?utf-8?B?aHhHYTJidHlsV09FSmh2R2J5WlhLc0R1bEw1eTdDRUxYRENFZUtQRld1REdB?=
 =?utf-8?B?WTI0MUpESDk5ZkplZnhXU0x4bWZtR0s4d3drMkdyZjhwc05Mbm9vNlBWdEhq?=
 =?utf-8?B?WlpNRS9sWFlsalN0TEN2VlVmMkp5ejhORjdOcHRSaXRIVXdrMklpckxBUGRK?=
 =?utf-8?B?bUZCbHFLQTdPa3pVVmJkSzJPdHRyZExycTZ3VGdSbllQTVFReDM3TEUyVDZF?=
 =?utf-8?B?VzZtYVgvVVdrNXdkSjEwaUx2SXZrcVV4R0xYR1ZjSHJJVXhzR3FsN1NzNEYv?=
 =?utf-8?B?VjluM2RrUk9NNUdxKzlhdXFjcW4ybE1BWFNSeGZ4UXJsRGs5SDFaRFV3SHJ2?=
 =?utf-8?B?amFIMHQ1MXBVa05IK0I5dmVpSEp2YVY5RlViRzZhQ3VtU2Z4SWdVV0p5aGJO?=
 =?utf-8?B?OGNkWE1ySzhKNnBlRmtFL29sdUsvOVZtOFVmTFpmRVhxdEtnZzdPTnFTWmRR?=
 =?utf-8?B?bkZadmg4ZGZ5UjJtbU1EaGpYdG9idEVYL2k5bTFjQ1VRT0xDRUVEcjZmcGNa?=
 =?utf-8?B?Y3kzRXkxU1JVSGpqaEtPbFlxR1JDVXJ6Nm43WUNoQ21ZdVhHdmZsYnNjUDlm?=
 =?utf-8?B?MzNRVWYyK0c0bG11bXF2bWY3MDRYMzIwdDZoaXVPWVM1Q1ZkaUs4UmVMaUtj?=
 =?utf-8?B?aFMyNlpONXFFQThmazhQRlJCZlBuaXFFSzZlWHYvd2szbVU1c3dNbUpFWFdQ?=
 =?utf-8?B?NnpCQjZxSFlkMFM2M3RhZnlib1g1eHNuRit0MFFMaEVlYjRWMFFQTzJxWE1a?=
 =?utf-8?B?SFBWTHBHbW1DcUZkc2pPM0VpZENRTkNMOURkdE9YdnZVZnNjd0ErVlZoR1JM?=
 =?utf-8?B?VUZFUHBhNkRHSHY1NWpqS0dWdEZyekRJWnd6UjZpNVluTi8zL1NQWVBHVVZh?=
 =?utf-8?B?Wit3cmx5WUNZejArcTV0VVV6TDE4eHFRNjdFSWcwNEF4ckMxdFpOOE1zZzRR?=
 =?utf-8?B?ZWJHY3p2dXFxTTBMaVBUWGtIUGRCdFdUUlZuQ01ySEYvL290NzhMbzBYVVZ0?=
 =?utf-8?B?UUNUVjRuSWVnT284YUlKTHVFVm1HQ0oyNWpjc2ZHZHVNUjFaQVZHZnZZMWtO?=
 =?utf-8?B?MGtTbllJSmtCdzlVQjBkaWU0dzFkTk1PR2E2MmdLd2xVTVVkaXJoZHQ2MmNh?=
 =?utf-8?B?ZzNKcHQrdWVEVW1rV1B6OXFUeUs2V0tqYmlBaXFvOFlwUWo3bzI2RlFJT3ZZ?=
 =?utf-8?B?aWRtMURqN3M2V1d4ZEkzQlVoQ1hpd1pOZHFybHhwZGlpMmRRcDdzNTJtaUJJ?=
 =?utf-8?B?SFNkdGh5OEhIT3haUlAxUEFKVXdQeVgrYjlIRy9xZmN3aGpUOEZ5NlVTMFlU?=
 =?utf-8?B?Z0Y3R0VXTVJaeThWRklpanBVOGViMlVsVFZGTDZML1NKRnZ1VW1WTmdodWs4?=
 =?utf-8?B?SDJjSUxBYTErSmRKa2praDlDb1dBZFBzeTlxbXlRNTlibDQ5SjExUWxrbkFY?=
 =?utf-8?B?RUlMMUdENE1IQ1dkbkttK2ZaengvWkQycm1JdWc0c2lGUURXYUF0RWM4bXda?=
 =?utf-8?B?dUo4cWMzSG12NVpnL0IzSkVTN3V5LzJyMGZOaXZ4bGhpWHlpc1NnMEhkWnVk?=
 =?utf-8?B?b1BWektSSGRSQmpQQVpHRFJsMjV2NmJOM2pwdXovVXVmZEg1YkNyQk13VW5P?=
 =?utf-8?B?ZEd3MUszYnd4K3Y3L2dGZFJQNXdMNHYxd3c1amFaczAyWk5SUWZoQllJL1Fh?=
 =?utf-8?Q?ZzZvaFxEh8RNNHu4m8suC+494?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7037a016-7eec-4cfd-82f6-08dbce159fa6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 07:00:48.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/D/pA2LUcLPosc43lRBqozIpEpxXYeXg2BGz8rSOMfaA5Jm0NipHVyE2DHF1YlRq7mqQQl9dGoAP5TqyUP8HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8208
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/14 08:51, Nicolin Chen wrote:
> On Fri, Oct 13, 2023 at 09:07:09PM -0300, Jason Gunthorpe wrote:
>> On Fri, Oct 13, 2023 at 01:58:59PM -0700, Nicolin Chen wrote:
>>> On Fri, Oct 13, 2023 at 12:19:23PM -0300, Jason Gunthorpe wrote:
>>>> On Thu, Sep 21, 2023 at 12:51:31AM -0700, Yi Liu wrote:
>>>>> IOMMU_HWPT_ALLOC already supports iommu_domain allocation for usersapce.
>>>>> But it can only allocate a hw_pagetable that associates to a given IOAS,
>>>>> i.e. only a kernel-managed hw_pagetable of IOMMU_HWPT_TYPE_DEFAULT type.
>>>>>
>>>>> IOMMU drivers can now support user-managed hw_pagetables, for two-stage
>>>>> translation use cases, that require user data input from the user space.
>>>>>
>>>>> Extend the IOMMU_HWPT_ALLOC ioctl to accept non-default hwpt_type with a
>>>>> type specified user data. Also, update the @pt_id to accept hwpt_id too
>>>>> besides an ioas_id. Then, pass them to the downstream alloc_fn().
>>>>>
>>>>> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
>>>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>> ---
>>>>>   drivers/iommu/iommufd/hw_pagetable.c | 19 ++++++++++++++++++-
>>>>>   include/uapi/linux/iommufd.h         | 23 +++++++++++++++++++++--
>>>>>   2 files changed, 39 insertions(+), 3 deletions(-)
>>>>
>>>> Can we also come with a small vt-d patch that does implement an op for
>>>> this? Or is it too big?
>>>>
>>>> It would be nice if we could wrap IOMMU_HWPT_ALLOC into one
>>>> self-contained series and another series for invalidate.
>>>
>>> We now only use IOMMU_HWPT_ALLOC for nested domain allocations,
>>> which won't be supported until the cache_invalidate_user ops is
>>> preset?
>>>
>>> /* e.g. the following piece is in iommufd_user_managed_hwpt_alloc */
>>>
>>> +       /* Driver is buggy by missing cache_invalidate_user in domain_ops */
>>> +       if (WARN_ON_ONCE(!hwpt->domain->ops->cache_invalidate_user)) {
>>> +               rc = -EINVAL;
>>> +               goto out_abort;
>>> +       }
>>>
>>
>> Hm. That hunk could migrate to the invalidate series.
>>
>> I'm just leeary of doing the invalidation too considering how
>> complicated it is
> 
> OK. Let's see how Yi/Kevin/Baolu reply about the feasibility
> with the VT-d driver. Then Yi and I can accordingly separate
> the allocation part into a smaller series.

Current nesting series actually extends HWPT_ALLOC ioctl to accept user
data for allocating domain with vendor specific data. Nested translation
happens to be the usage of it. But nesting requires invalidation. If we
want to do further split, then this new series would be just "extending
HWPT_ALLOC to accept vendor specific data from userspace". But it will
lack of a user if nesting is separated. Is this acceptable? @Jason

BTW. Do we still have unsolved issue on the invalidation path?

-- 
Regards,
Yi Liu
