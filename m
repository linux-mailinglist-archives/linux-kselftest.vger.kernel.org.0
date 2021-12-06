Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DEE46AE80
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 00:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377360AbhLFXgL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 18:36:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:48179 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377357AbhLFXgK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 18:36:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237377514"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237377514"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 15:32:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="679191407"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2021 15:32:41 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 15:32:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 15:32:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 15:32:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ70i5YwP2LA8tM/IkKAxgEES9SvGPQ8Kc+GkHyGsoMt33Jz/t1DEI37APpicW1crOOesOvLhS1e5Em0alFLyqG7uDVS0jbMNLaAdZkTFrh5e9Jxlb1ptL1r9rcV19lvo9TlWM4XGMuLMjII7bvzVSQQSrpIp/2/r8mKVQspsmhoFz7m+mm6Crv+JE5KNt6MnjwQ56nC8JugpQHbEodMtx0ynkhVcBtjKtAdmoA3l5xIv0kfvu9dgvbvTjb7Y1XZEjr4QtY2g0tMTRp5KpkEEooWaQzoPmYvWrqZNWvnJdC1RLqJigJsn4iT4s+ZAr16xmb1rXU5fSHdc4SNY4mp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGmVAzjwmEOMB6ukoKdf18hcd5v0GSF2CJyamm592Ec=;
 b=V3FwpcJIJuJqtTQS1MM7GgfR5BN/ySlLNdbpreDLORXP7zUxkZARDjOcwKIf2M/0cF5JSf08cWkArR77bNH02ABxVHGgvOjsVH9vcq/4AL7a7ygw/8vci+axjFn58pGV9EvNMrLKQP7XJIcpbSz8rGkIV85XSYX5hJNoJwyz6FlBHwFBm+/05PtHfXhIdXfGomJSmh7Ws+DcnUhab8JGuyaXaE//ZkzXKJM7yMpDOPyrv+dAoy5glozD6kqkiv5mmiQrKappcm0y8QZSYVNttjxeYswMOh12pkU+yThYEvrzYJuVWD2sud5mvd3/5M5zys8r8I43mGDwav7qjLdoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGmVAzjwmEOMB6ukoKdf18hcd5v0GSF2CJyamm592Ec=;
 b=ia8bcd85NdFZHNHiaOnCe78wZHztXwc3TQzStrnO4VJNh+GoLJ10oGBAWPQqdostui35uOCs9sqOWOc12z8l2MtYk8R6RWARVtZbY7jvUcp1EJ1cOgtjeuk6vLpDolzrPA8WmvRGqd+XQmcYk786TDztxE2qpdvULTChOW49Qr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2675.namprd11.prod.outlook.com (2603:10b6:406:ab::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 23:32:34 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 23:32:33 +0000
Message-ID: <c4257eaf-ecf8-ed35-aa67-5594005aa68c@intel.com>
Date:   Mon, 6 Dec 2021 15:32:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH] selftests/sgx: Fix corrupted cpuid macro invocation
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-sgx@vger.kernel.org>
References: <20211204202355.23005-1-jarkko@kernel.org>
 <c5792b66-4a27-0a62-bb75-6cc0c4219002@intel.com>
 <eb4a5d7a-64f4-bdf3-2d12-879607f914c3@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <eb4a5d7a-64f4-bdf3-2d12-879607f914c3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:104:7::17) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by CO2PR04CA0115.namprd04.prod.outlook.com (2603:10b6:104:7::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 23:32:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8930fd2-9a9f-45c6-731f-08d9b910adc7
X-MS-TrafficTypeDiagnostic: BN7PR11MB2675:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB26759D79DD69F27E49B1D81BF86D9@BN7PR11MB2675.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apMEX+Eg7jfUKcu1Ro/WOKwgh4t/luIKWcLbgIWAGbFbIUV9mkjzss8Y1Aky2+YZB07Qot/p3ycO8mPOgKUAqRSRatAVRNasATxEmX16DNrSyKz87rpoNBXdhMcH3rrL786GcaaKY1x9L74DAMwDdccaf04LU2B43J3AX3d3RmQmXb+K/g3wY8G4MhgBs4m4HTSbiExv2eRSGfdUJAwddKS9GvZsCf84VcNIorfW/s/mUMFc/s5I3GOq+Od6h1+4IvZutyXRq1QKOiAIZQcLiMJ1I3Ann9gIxOy1pY8aSUs+eu3u2AQbsfGFEIFP9T6YI9NyuZFxVuu6wA/nUSM2ijabeNjwuvR5cTVJyp/FbY/yM1wwP8si+iGMm0y1GT7rImotTR4hP7m0Udf8xZCNUuq2HZW0btWTsEIZuoDtnxIEy21v89Apxw860mmBIjlSKhsjxc7COQTzCbPxapBYoiXvkf0nTSTZBVsoWB/jrgb8Z+MT+rlDUaHh1UlKdoZOzZGyo6+3JRFDp+8FUPQI9+//yy//tc0wVmSEqPMUEKfW+teQNDDBauC1yz5ZuLaxqfVfvWDpdghpMFnwiO4Yt1Sba+UkHYF5+hWHjyiK204qCaJJcpcnRUAnsrMBMuSkxCISeZsuXrdP1woCUKD6M7jHmcFwWRuGvI8FyUBgKnE0hPihWwzCUjo2l4IdnBiPR+mQR1ZuEktnHAxMgnMAVyXdIXSMu5u9siI5jOrgWoYnTA413gHc/+BzlVNjpfHQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(86362001)(38100700002)(31696002)(8936002)(31686004)(6666004)(66946007)(2616005)(956004)(44832011)(186003)(66556008)(4326008)(66476007)(82960400001)(36756003)(6486002)(2906002)(508600001)(26005)(53546011)(316002)(16576012)(5660300002)(83380400001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzlxaWUyLzRyQzlkNXNIY1dCeDRXdzFLQ2hockdWcytMOVJnMnozYzhLL0pM?=
 =?utf-8?B?R1d3UnpINTJEWUdQcU1rb1kzUFRTc1hwbmJ5R1lWb1dNVW9nSHpMREh4RXRB?=
 =?utf-8?B?a0MvQnJjNFNSS1psTUFIbU4vdTZPK05RTTVHR0V1bi9lMUo0SzAraTBZYnFM?=
 =?utf-8?B?WEk2bHdjazVvR3pGVytHT2JvdTBENStuYjhyb1JiRDgxQ3VxOHV0dHVranYw?=
 =?utf-8?B?aEJFRHJsZVRVOXpIUlVGY1kwR3FiNzJ5cldmQXJ1RkY2SlpoazZ2RWdJNTVT?=
 =?utf-8?B?UDkwNUNzR0JUMUllVnBxeGVHRzNvTzYrNVFwMXlmNkE1QWRWUmpqS3BxOUlQ?=
 =?utf-8?B?bExFVGFxRWFta3BPemQ0NVN2a3hJWWp3OVJrTzBvNkd6bkZ5ODRBbVhzTnFx?=
 =?utf-8?B?VzhFenJEYXBBYlpxL3pxN05tNkhSR09FeGVubmcrQ1M5SUlwd0llT0dQSlp4?=
 =?utf-8?B?Tm5adFhpZ0tmdGlSSFVETktoeVA0bDZLVWlhWWtqTE5lUFhncU15eGc2R0JW?=
 =?utf-8?B?RGNCZW9RR2JLNmNUVU5MKzFGcEo0RTJSaDhuYXk1a241U0FTb2hZTlpFRjBP?=
 =?utf-8?B?UVZvZ2l4eUZNUXlraW5Kc01pRUppWGdTUHBLMUJUcTVOVFpCY3BiRG5lTHFs?=
 =?utf-8?B?NnZFUysvR0U5OVRxdXFtMkNkWFBNM2RDT0VabXhPdTRPWjdXZVVqK1FOcG5h?=
 =?utf-8?B?T0VnSUdJMXNoTWtjeHYyRklCU0F0U25DTXhMQ01peTcxd1U0T0RDYkRvUnB2?=
 =?utf-8?B?N2srbE9LSnpzUzdsNnQvTFhtYjRrOXB4SlprKzFQbm5lRkE4a2s5VVRpb1Qy?=
 =?utf-8?B?K0Y4R1hwTTZaMm1LeXVQb2dWVHJwRTZab2sxRUs4SjFEelM2VlV4Q3piVCtH?=
 =?utf-8?B?NmphSFg5dXBNYzB1d243Qm5FUWtmZzA0Z0JBdFY2aVJwT0c4U0FVelMxUmJI?=
 =?utf-8?B?VXZwRnRwU2ZicXhaQ3VvNURUU2lsWksyTTRHVDhhbitBR0YyZHNHc000ZnpU?=
 =?utf-8?B?ZmJpVEM4NUV4Y2pIL1YyMUxyTDNYQ3NURXE1TjBqaUtJQWo0dEVielppQWIx?=
 =?utf-8?B?MFVQOXN3V2hPNC8xbitzMVdvcTNVS3JDUVMybjZWdFJuYmE4WEZ3TlpTbzVm?=
 =?utf-8?B?TmhzN2VZYkc4U2xtTFNpU2lxTlRnOHpMTDdUYTY0L1VzZzB6dHVnUEt1TjFL?=
 =?utf-8?B?blpKVGZ3YUtnK3FoRW5Ldmd1ME9TTk5FWVFjRHFuK2ZzaWQ5VDdCMWFzUWly?=
 =?utf-8?B?bXdPVGQ2VUpvbEpXbEhpSnhqR2t0Yjc1cVYyeWs2TFQxRnE2akltZnZJWTlB?=
 =?utf-8?B?cEhBM1FENFpFVnFNei9jUVl0U05Xb2NIUUQ4aDltcE5IU3QyeWRjb0NpRk44?=
 =?utf-8?B?QndVTUNMWk5wZG5tZUJUUXdYMWRnOFpKZGtOTnFuengrMjV2RG1mYWFLclVI?=
 =?utf-8?B?WnhvU1pIejc4am9LZnp0QXMzc0VGbFVER1ZPTjhhRWhJVHZVRlhYVmxSWEI0?=
 =?utf-8?B?WWNtT0xQS0k4amlrL3poSkJUUTRWL0NMd1FDQ29YS1RSbmJOR01KQnVYbTBJ?=
 =?utf-8?B?bDczL0xVOTIwb1kvSXJLd2ZSM0ZJTlZJQnpnUzV6bW0rNi9hUmRkYkJ6NEZa?=
 =?utf-8?B?V3R5MUh3L2FER3UrK1dMU3RDejRqeFphSW1tU3AySGY2OXRBNFJGRzBwa0p3?=
 =?utf-8?B?OEluSlY3cjJCVU5SWjNyVHVPTlJkc0FGZTZWcGJzWll0cVVVYXJYVHdkRGN1?=
 =?utf-8?B?cUxudnBkZWdGckF5TGp0aHFRMFVKN2ZLdlZIdFRqeXJXWGRWVlQzOEhvMWxn?=
 =?utf-8?B?UzJuRjd1SUFWcjhUaUtmMFM0RnBHMXh2TmNFVzJXcW5jTDFvbm1nUE5rT2Ix?=
 =?utf-8?B?YzBNTE1peFQwL3luMGo3SFFNSStOdXQ1L01KMDVzSXI0bVZkZzJIeDU0R3V1?=
 =?utf-8?B?VUhCUE5wUEZEc0xrR2hmSEFMZzMyeDJRTSt4WnBoaWhCZ2Mvb0pFVVYza1dF?=
 =?utf-8?B?MytFZDJkSm1zaUZhc2htUXFoa3U0VFNYdHh4eTUvVEJyOFI0ZXlwc1NrKzAw?=
 =?utf-8?B?M2JQajZ4QkRjVVd1aysvVWVvYWUvQXVLNVlRc09YZHB2NnZYS1J6by9nOHov?=
 =?utf-8?B?cEkwclJuYkEydDB4aFlnRGx2QWJaTlloMnRiditJajdUcTQrcTNYZ1ZzQlNM?=
 =?utf-8?B?cjYvRXdCZUh3eWxqUUJtd0U1dE5mUlA3WmhSOGtWeEovbXdvWkdkTjYyN2VE?=
 =?utf-8?Q?6FOaD/LQFGEeac/varRVcvxYtBy6FdjRp+OK4X+bdM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8930fd2-9a9f-45c6-731f-08d9b910adc7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 23:32:33.7911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uS6n+iqBzoa5o3VPWdlPLsq3H8dOf2xxIeU+9BGWC6pElUsTW0saUt8V9n7BqfCxsKDX/ViAlvUI3VxmDLzfoQN15inCmL2RHUMsqDDh4IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2675
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 12/6/2021 2:54 PM, Dave Hansen wrote:
> On 12/4/21 4:32 PM, Reinette Chatre wrote:
>> I am not sure what the right way is to fix it though - my original
>> intention, what the code uses, was to add a snippet as below as is the
>> custom for all tests needing to run cpuid. There are many usages of
>> cpuid among the selftests but none rely on the cpuid.h to bring in
>> __cpuid_count. I do not know the motivation for this but preferred to
>> stick with the custom for my implementation.
>>
>> +static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
>> +               unsigned int *ecx, unsigned int *edx)
>> +{
>> +    asm volatile("cpuid"
>> +        : "=a" (*eax),
>> +          "=b" (*ebx),
>> +          "=c" (*ecx),
>> +          "=d" (*edx)
>> +        : "0" (*eax), "2" (*ecx)
>> +        : "memory");
>> +}
> 
> Reinette, is there some reason using __cpuid_count() won't work for the
> SGX test?  Or is your concern that it _might_ break something because
> you haven't tested it?

As a sanity check I tested with __cpuid_count() and it works.

My concern is actually about the kselftest framework where I could not 
answer the following question with certainty: why are there so many 
usages of cpuid but everybody writes their own instead of including 
cpuid.h? I am concerned that there are some environment constraints that 
I am not familiar with and thus decided to follow the custom.

One speculation is that since cpuid.h arrives with libgcc's dev package 
instead of the regular libc dev package there may now be a new 
dependency on what users need to have on their systems to run these tests.

Reinette


