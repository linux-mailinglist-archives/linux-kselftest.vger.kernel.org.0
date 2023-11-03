Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01217E0B46
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 23:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjKCWu0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjKCWuZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 18:50:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D6CD6D;
        Fri,  3 Nov 2023 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699051821; x=1730587821;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L5BWVGgaKhpha9GI97iGHRLAuScp9GYKTfMvRiYNgVk=;
  b=PSHznvR/eZcuU0q7qoRqdakQ1ffPTW4H6QsbiTq6Q4BOtR7V/jduRSdl
   /anYsdpLo3a//e/j4efGq/t5HiT8dZNhUEZ52G62d5lgatLMbhJFBWVBn
   90IigjG9ibmXvK+IvIegcKCjWzEMswcuCmh57PD9ZXtvNu2I9oRrTdX4T
   CDxGAMbKdQ9cDPJZBm2WAWiCVwcUubewRNU5HYyD4sb1EqUwnZ+WXWgZ2
   4vF6NKD4Gm4n+SJb2/Y/cdeY9GvYslzN2Mj2InqkbCAPpTKMkYKwYdK/J
   vtNho75poT1nyDD4NL3ZSIl8r5iFrMaKVFx/lGgCb2X05U/N6Vne5GltZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="379430883"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="379430883"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 15:50:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1008957431"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1008957431"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 15:50:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 15:50:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 15:50:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 15:50:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5SQBlVbaoSapvLQkS5iDst+gGU/bt3N/IK2W5C3ib91pfRCdHGu7fAFvuH6QnyJlwRVX8B6lRJJl3UxK94U7yYRNhlISedTyt15ezbU9PSBUFZjPulrRPRdVl9sX5Gyn8K+TW6oy4Z5riT64M+MsOJOdRKtyqiUMfz9FOwS+JSz5xrcFoLVS+VoKpDO66Re3wbP8Bdwgdfvk5cxueksPrSYSawiW3BINijUj07KywemD+E+m5x550qDVGSz70KYBWh9qAc9hricsVroTgy+i1OB/a5zntZeuVzn1Lp1BYlt5swkjosteOZlUiM0Hl2y5F4kb+ZShID8b0qqUOuI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkCoXZQ0yh/0ihuYB4HnPw9v2yA6ewl45EGGhgsJnQg=;
 b=AxO3Zsi91Vv92+RX8hg53e9ZbxVOtq78XT3acUbiAu/kYjwZDs028eVNWk0Ib002EmDZTKlB+bd/CubrRDnMAccBzTI2b32Y9lhXvwr7BAYNfUFCMFoTSzo1bmCjEHFogjSHAU1Jt6ZfEoEF/fPowzibNZ0tAIzhGWvFMBKvGKkuKF/1xtK0onzvSUmjCbdFxj1RUTsXTT2iO0Dw6S0vB5O9zjmwpsIbT68239qxfeg0RV9tlSxTHODY43KQZJwWifxVP885KiPUjnjzqJ5TQmziTOOuCdFc2PSabSgNHexcjyFHfssw0IHu1NJ/4OvLlq1uEZgeNuAG2hRWT5k3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8723.namprd11.prod.outlook.com (2603:10b6:408:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 22:50:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 22:50:14 +0000
Message-ID: <9f324d21-2db2-40aa-b4ff-6063e6390c18@intel.com>
Date:   Fri, 3 Nov 2023 15:50:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-17-ilpo.jarvinen@linux.intel.com>
 <fe5284f7-c27a-4ec3-b12f-f3556a9bb456@intel.com>
 <86c11925-8c3f-3974-7d5d-8df9e6cc1b2c@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <86c11925-8c3f-3974-7d5d-8df9e6cc1b2c@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0f1bcb-ab33-4419-0bbc-08dbdcbf3e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vraEdsIDiZTJspi+/NunBk27H2u7b8qqFizzEOYGndp3Euzr0+hZxtM5qzPdPgYH8iBKWikeijm94JwyN86Yv9SGKJE2Ii0eOw8KIgO9ZNJdRqFUNkG40bPQjXKjw/fMkLfsZeDNld7ow6LwC6cLQNSmrloQyNBnix1KfSiNiEv9MRx1SEkWBkjdC6RIvOe3R32GX8eemfmGc3QQX5iJud+fropjqk88PRHPyP/CZvoAfe4bevtWzyXiKWGZ4PUw/fQDKf1Kiss/D1WIbFZ+I5PJmK6PWNo/u64/zwADGA/E2pi20QRsuwcnyXGrfTuIQD9dTVPJ2hvgkoJFe2d911T9HxU3M6tnHNfOrU5IKkU27LgHi//Z9XWL1cz18OKGZIGxO9yRLFWIh87DAAKNFtOQMKYDaykubhW0RBndd7FBwHEW2ClMNkMq17msuLyI5QbI1SZ9QzMZn/kWHHqashySVrypdlRE1WRNsXhaia4BbP3UDwyy0QfZAbZHPTqyDgDbSktU5Z6juJoyrFOAP8IEk9q1hcAthh8XBYPMqU4DJKD0C2cxTkbBgrzqzVynYNiFnWrgoTZNp5RshlM6XH5MEwp88DTl8m4w1ESST7iH4W0slFXFPb4uvG3E531BJK3r1pX57w5Jw/JfK/lSuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(53546011)(6506007)(478600001)(54906003)(26005)(6486002)(31696002)(2906002)(66556008)(66946007)(66476007)(2616005)(31686004)(82960400001)(36756003)(6512007)(38100700002)(66574015)(41300700001)(316002)(44832011)(5660300002)(6916009)(83380400001)(86362001)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzRIc1kxb245L3J2L2VhaUxhTnE3TXdmaVVaVHozV1dZRU1LVU9zZUhvd0pk?=
 =?utf-8?B?UEtBZnUxUUMrWWhwVmFTK0dISXBMNnJwdTBlNkxYaWdVSFkwa1RBZUg3N0g0?=
 =?utf-8?B?R2lDU2M1UDhNdHA5ZUc4c21SVjMybW81NXhMUmg2dmh2MUludXA2aG16b0hL?=
 =?utf-8?B?T1FXRHBVaGdlMHFGK09OaE9xNkM1QjRBa2t0alpoU1BVY25vVmFpTGZBSnBB?=
 =?utf-8?B?VnF3cDdJRkUvRFhkdEJ5RzA5b3VpejRZYUdZSkpHbjJlQzRPNFc4NDBtVzRp?=
 =?utf-8?B?eHZpQ3QxQURsTEtzZlhuRU1WWE1NK0Q1T09QeUV0UkV2OGNtQmdKdjE2MmpQ?=
 =?utf-8?B?VVFxRmVLMENTbWhZSnFrNW1TRjduWEhaR0lnZzRmci9PM2Yzczl1Qk5Yb0ZF?=
 =?utf-8?B?WlVVSDAvRUJBTExnRWFheTE2cDRtUzYxV1JYT1lIL3lXWW9kMEhEaXh2YlI5?=
 =?utf-8?B?bEQ5YzhzTlYydGdLOFpBV2Q3ZlJ1M2dnMDI2QVpiQ2ZyeXNON0VPQVhmSkNO?=
 =?utf-8?B?M24wQ1FSS21UdFk0S3FVcFhxZXRHcHFDNldSY3R4b0R5WUNpZmhLNmwyMlRj?=
 =?utf-8?B?OXdQMjNlakl1cGhlWGx2UExReHBZNEZocFlnWG9iRWZYTEFSRHN1VUI3bURI?=
 =?utf-8?B?bWNjZkpNMUNSZDlrUmM1YnMwSWFMVzZ2bHRRRDBKK2ZJUFlNQWNhTWp4UWhk?=
 =?utf-8?B?QWRqdUI4MG03SHUrSXV0cjg4ZjVER0tDRThQTEdWRjNqS2RmK3ZHcHMxRStI?=
 =?utf-8?B?SDR4NVdpb25LZzdJYWVlTHRQcDRtaFhyZlZ2amtCeXMydzU1Ui8vbVBSMytn?=
 =?utf-8?B?T0lESXFIeFREZEcvMTIzT0tMVFVJemNWdmhOM0NKOVV6SkJPU1lSQmtlWUU5?=
 =?utf-8?B?SHU1d21EcVBzSG1oeHoraUhrakpRZGJoNTladHJVVGt6Y0MrODlNcW1KanY2?=
 =?utf-8?B?UkpYMFVLcTZpKzlnaW1ZSFIzV243c1FrV0lVZDgzUUxWMFp6bXVvRGJTMDl5?=
 =?utf-8?B?aGRQeWdEQitDb1dMRlhoVlpwN2k0QkxEdXk4K0lHMVo5SENsMmtBWnNDaExP?=
 =?utf-8?B?UDdMQzkyYjM5NVh2VmFVcWRPdFp5dGlQKzZuK0FPdGJNby9xaEhOY09VTSti?=
 =?utf-8?B?ZkZHc25WUkRvUG9UaHdqOXlXRkdtMTZhdTZCc2RITFY2dEsyT21rSVp4QjdP?=
 =?utf-8?B?MXdnZkZOVVBpWVFvcTlpektoYW5EVXIzMEdnRVpQZXU4bzlzWmp3R3dZd3E0?=
 =?utf-8?B?bjZGSncwdC9GdjRIay9lWGNobG9TU09oQmJpeVBZT1NpVWhlYUQ1VlZYU3FJ?=
 =?utf-8?B?OTh2UXFHZUdrTXhpUkZTZzNadDNJVlQ5OWxVZDM3ekMyK2pDVG5mdjltNmFm?=
 =?utf-8?B?QUlOUUxPUVl5S1gzbDcxemhZV2lzYXI5ZW1PS1VQV3JsbnRGSG8zeFZFSk9v?=
 =?utf-8?B?L0dnbmgrd3FQNHNzNmpxSU9IT3J3LzBIR3ZRa01BT2pHSit1bHZ1OGE3Qmxo?=
 =?utf-8?B?Um5tNnlqWi92TVFXSXlSNS8zazFyR1AyaGNzYk5OODRDUlFFNjRTMi9Tc09J?=
 =?utf-8?B?d21NNjlLbG9SQjNyai9JUlYybmZnamFNRFhVMlhaaVF4d0VLYnA5cWROR1lL?=
 =?utf-8?B?WjFiY3A1bHVXOWVzbnJ5MDdpWHp1d0xIK1Yvb3UrNjZxeGZOS2hWaU5mbFZw?=
 =?utf-8?B?R2hEWmY4ak1rVldTK2JhOWoyZDd5SDI1MXd6dGs1VisyMGR1Vm94NE9hWksv?=
 =?utf-8?B?WTNQcTBlNkdBRjhkbXV0bFY1V1M3UDZ2K3UrMitnZ3Z0NmVYaDVQU1FEZTJT?=
 =?utf-8?B?Wm53L1p1eGowODJBaG9vbmVlQTBWcUFlT1Vjdk5lTlRJeGVweUZwcEpnZFgz?=
 =?utf-8?B?eFRlNk1xZ0pvUi9WU1RTMFpoQlppYjZ3aktGS014dCs3Nkk5RG9iZ3dSalYw?=
 =?utf-8?B?ZDFIdWJsdkFXeGtlbGNKRklLS2Z3bi81MkQ2eDFIZEtrQXJTTndqUm85U1dD?=
 =?utf-8?B?b0ZTZyt5dFpoT0Rhem1BWGRscnlhcG40MlNoenkxV25CUW9taE5uVU9KU0ZO?=
 =?utf-8?B?U1FGMmFhd1ZoZ1NoT08wMTV5d3RlNFoxeWE4cVJ0RDZTVVNra2VQZXk2NHk5?=
 =?utf-8?B?Zk1Vc2NTUUMrNlRLT0FKS1U4Q25SVHdWQXNlczhxMG5IMjBuczFwOC9FdXZx?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0f1bcb-ab33-4419-0bbc-08dbdcbf3e2b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 22:50:14.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6ZtPDfSeP3zCCPWcyhGV7VRX0CtbvbG9xBluIaEuOylk52UC1zE98YRfMlqhQeqGOc0S7xyuPJRPXffrBxOTomT0udEtJiuAHkaArdR+nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8723
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 11/3/2023 3:57 AM, Ilpo Järvinen wrote:
> On Thu, 2 Nov 2023, Reinette Chatre wrote:
>> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:

...

>>>  /*
>>> - * Change schemata. Write schemata to specified
>>> - * con_mon grp, mon_grp in resctrl FS.
>>> - * Run 5 times in order to get average values.
>>> + * Minimum difference in LLC misses between a test with n+1 bits CBM mask to
>>> + * the test with n bits. With e.g. 5 vs 4 bits in the CBM mask, the minimum
>>> + * difference must be at least MIN_DIFF_PERCENT_PER_BIT * (4 - 1) = 3 percent.
>>
>> This formula is not clear to me. In the code the formula is always:
>> MIN_DIFF_PERCENT_PER_BIT * (bits - 1) ... is the "-1" because it always
>> decrements the number of bits tested by one?
> 
> No, -1 is not related to decrementing bits by one, but setting a boundary 
> which workds for 1 bit masks. In general,  the smaller the number of bits 
> in the allocation mask is, less change there will be between n+1 -> n bits
> results. When n is 1, the result with some platforms is close to zero so I 
> just had to make the min diff to allow it. Thus, n-1 to set the failure 
> threshold at 0%.
> 
>> So, for example, if testing
>> 5 then 3 bits it would be  MIN_DIFF_PERCENT_PER_BIT * (3 - 2)?
>> Would above example thus be:
>> MIN_DIFF_PERCENT_PER_BIT * (4 - (5 - 4)) = 3 ?
> 
> I suspect you're overthinking it here. The CAT selftest currently doesn't 
> jump from 5 to 3 bits so I don't know what you're trying to calculate 
> here.

I was trying to understand the formula. The example starts with "e.g 5 vs 4 bits
in the CBM mask ..." and then jumps to "MIN_DIFF_PERCENT_PER_BIT * (4 - 1) = 3"
It is not obvious to me where the "5" and "4" from the example produces the
resulting formula.

Perhaps it would be simpler (to me) to say something like 

	Minimum difference in LLC misses between a test with n+1 bits CBM mask to
	the test with n bits is MIN_DIFF_PERCENT_PER_BIT * (n - 1). With e.g. 5 vs 4
	bits in the CBM mask, the minimum difference must be at least
	MIN_DIFF_PERCENT_PER_BIT * (4 - 1) = 3 percent.

> 
>>> - * Return:	0 on success. non-zero on failure.
>>> + * Return:		0 on success. non-zero on failure.
>>
>> Is non-zero specific enough? Does that mean that <0 and >0 are failure?
> 
> I suspect it is, after all the cleanups and fixes that have been done.
> The wording is from the original though.
> 
>>>   */
>>> -static int cat_test(struct resctrl_val_param *param, size_t span)
>>> +static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long current_mask)
>>>  {
>>> -	int memflush = 1, operation = 0, ret = 0;
>>>  	char *resctrl_val = param->resctrl_val;
>>>  	static struct perf_event_read pe_read;
>>>  	struct perf_event_attr pea;
>>> +	unsigned char *buf;
>>> +	char schemata[64];
>>> +	int ret, i, pe_fd;
>>>  	pid_t bm_pid;
>>> -	int pe_fd;
>>>  
>>>  	if (strcmp(param->filename, "") == 0)
>>>  		sprintf(param->filename, "stdio");
>>> @@ -143,54 +168,64 @@ static int cat_test(struct resctrl_val_param *param, size_t span)
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> +	buf = alloc_buffer(span, 1);
>>> +	if (buf == NULL)
>>> +		return -1;
>>> +
>>>  	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
>>>  	perf_event_initialize_read_format(&pe_read);
>>>  
>>> -	/* Test runs until the callback setup() tells the test to stop. */
>>> -	while (1) {
>>> -		ret = param->setup(param);
>>> -		if (ret == END_OF_TESTS) {
>>> -			ret = 0;
>>> -			break;
>>> -		}
>>> -		if (ret < 0)
>>> -			break;
>>> -		pe_fd = perf_event_reset_enable(&pea, bm_pid, param->cpu_no);
>>> -		if (pe_fd < 0) {
>>> -			ret = -1;
>>> -			break;
>>> -		}
>>> +	while (current_mask) {
>>> +		snprintf(schemata, sizeof(schemata), "%lx", param->mask & ~current_mask);
>>> +		ret = write_schemata("", schemata, param->cpu_no, param->resctrl_val);
>>> +		if (ret)
>>> +			goto free_buf;
>>> +		snprintf(schemata, sizeof(schemata), "%lx", current_mask);
>>> +		ret = write_schemata(param->ctrlgrp, schemata, param->cpu_no, param->resctrl_val);
>>> +		if (ret)
>>> +			goto free_buf;
>>> +
>>> +		for (i = 0; i < NUM_OF_RUNS; i++) {
>>> +			mem_flush(buf, span);
>>> +			ret = fill_cache_read(buf, span, true);
>>> +			if (ret)
>>> +				goto free_buf;
>>> +
>>> +			pe_fd = perf_event_reset_enable(&pea, bm_pid, param->cpu_no);
>>> +			if (pe_fd < 0) {
>>> +				ret = -1;
>>> +				goto free_buf;
>>> +			}
>>
>> It seems to me that the perf counters are reconfigured at every iteration.
>> Can it not just be configured once and then the counters just reset and
>> enabled at each iteration? I'd expect this additional work to impact
>> values measured.
> 
> So you suggest I undo one of the changes made in 10/24 and just call the 
> function which does only the ioctl() calls? I don't know why it has been 
> done the way it has been, I can try to change it and see what happens.

The relationships between the functions are not as obvious to me but as
far as execution is concerned I am indeed suggesting that only the ioctl()s
to reset and enable counters are repeated in the loop. From what I understand
the counters need only be configured once.

Reinette
 
