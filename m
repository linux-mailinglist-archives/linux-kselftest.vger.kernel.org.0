Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C704402CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 21:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhJ2TGK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 15:06:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:1351 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhJ2TGJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 15:06:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="230995184"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="230995184"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="448213391"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 29 Oct 2021 12:03:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 29 Oct 2021 12:03:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 29 Oct 2021 12:03:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 29 Oct 2021 12:03:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQQLwbOmbsG0ZOydGYPKxK/CE/OJZjh92y21YE6+YdVFc9V7Qe/uxlXWz/uGyfGcVKg8m8OL7QE2NJADOWqMrfCnd81RqiVhh7upiYTzIT+JkZJONU5wtjJDfYI9C8NDO3XTXsi/rCYWjDtOoL9J6FOMHWaW/xrg5oqxBs2gSe3NPZmliTw7hqk1y5KG9nHAx9EVgesSrdQF/2/w7k4YoRq5MrwEloAojy+KhVVqSOo6Uzqiy0eo1W7vggg5F/MovXitPMHr3GL+DcuLMM9q8A+r/pI1kaAMUu1EuPqPKPfz48v47ArLpmiQGiTGRmIT2xqXoyFaMEzPVV+VJoIOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fi2Dqdhq4b88fLa63Hf57LjTt2o52PO8b47VNcp9FJI=;
 b=mxF/vFuAmL5TpQek47JnA7Y9mFNSvk1S2pZmHgPzNuVPaDJoh/5X9/4eECmHQMetpNqs96SBXxL6bdCWws+T+hRUG2odTAqWEy3fjiGucuofPPPluwjpjPqNcMzcA84j1/TgLT3kME7u9vBoWysxzLshvFhRPFie6KnOKfIVtPN24uC6OX6zdMZ3b8BluGlDTviMckbE0yjEmD5XFfwP5CpsKGXvcZUD33CdmOUnawm9/2U847l/eL1uQhc/C2dB/FOpnj+xG4YkT8asr++GULeoLNhLFl4StKyctA/0oNTB7mNY6rIL0gXp1LeMm2VEL9vzjyGReav1YtLxAv9Edw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fi2Dqdhq4b88fLa63Hf57LjTt2o52PO8b47VNcp9FJI=;
 b=lOQSP4Egh+Bbuf3SPoXIgKQ03mrlsAzPwfJ0Vi3Um/tCPpoz5AWK367GxZOWrG66MtUaPi6FFy30fTZBhQVXr99qZPYD32gr0yYn8pM2L8oTxcwLmJFp570Bujf/0pVMGWnyVw1zRa08Ebw4uFtY+KaZwqpbnyj4TZqjng6klAI=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2529.namprd11.prod.outlook.com (2603:10b6:406:b3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 19:03:37 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::494d:4194:b64e:c672]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::494d:4194:b64e:c672%7]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 19:03:37 +0000
Message-ID: <78a1bdf6-a5f0-0305-5e43-c1f9290d9b79@intel.com>
Date:   Fri, 29 Oct 2021 12:03:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.1
Subject: Re: [PATCH V2 03/15] x86/sgx: Add an attribute for the amount of SGX
 memory in a NUMA node
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, <jarkko@kernel.org>,
        <linux-sgx@vger.kernel.org>, <shuah@kernel.org>,
        <dave.hansen@linux.intel.com>
CC:     <seanjc@google.com>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1635447301.git.reinette.chatre@intel.com>
 <6df03c54cc8b533de4389b663ec9e4803ced1beb.1635447301.git.reinette.chatre@intel.com>
 <eb41bbbe-8563-7b6d-3883-61ab43b0b10f@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <eb41bbbe-8563-7b6d-3883-61ab43b0b10f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0128.namprd04.prod.outlook.com
 (2603:10b6:104:7::30) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by CO2PR04CA0128.namprd04.prod.outlook.com (2603:10b6:104:7::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 19:03:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2265b073-af28-4a1c-d526-08d99b0ed006
X-MS-TrafficTypeDiagnostic: BN7PR11MB2529:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB252975A85801712A78D6D483F8879@BN7PR11MB2529.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1475IZ7qquxAwOxX33q4vBzENwliItKpSVwg547e9Kywkco/hUhbPOq878aS1TgjfdIhgJwiawoApby0vCJmbO82jdez/na2WXF0y+HvsF6s6MGo25egCAswMY+TLo96E7AHi93o/bSmZCrvyg7tHC1ZHHuYq8uOvWidWpeCVHXTyfvX+MBfVUbRbEBkUenIfYLm5uMlQMpup/RraEPctRaDm/bG2sfQNX05j9eAWRrvwobmA3vl7+a41Z/XOBfO/mGSdw23fFslglw5FBfGRGdP5Loh+YlddNBXznpwYQOlNVzp40s+dKqnWmiJYFFIF+xXQw9VvQxpIr75+f0BdFLBtd32GWZeu/IZOdVZV2l8EV6bwNXojYWoBCFot9ul+FRmg1ffvSHTdrUx7hTW3isSi7wfS13Hss3aNdAdxD6ICE4pMNSzzKGzmJsN1P7Au4Q5/jal0g4iHw3nLK9gFWCMZhsi7NhPUGymf7UXQPIlUhSj+bKHZOvQFf+nKuiFXxuTJNzNk6PuP5k55sMLfF7W/egRnNoMrAujYhp7AYJUtasAzXzKZGUEIzYkRGmdPPfl2MQ5uSOFUSgEa3F+pLmWAToWqNQ2JLW9lsV6vialYgeT4Xf8X7rS9nIXJCD0FMpfFaOkvzG9K3a7ChVVuGSnXcigPczs/M+6PH10ViPiRHgE1Se1P5Oyw0KXnfntNuisvnV8wztwmfdlTqg9ZLUjTriELSLEkLsCjAf1OA0VEEMlgtwCOs6DPX9b4lgNacV9PzGMa7q4KYlfvrWPoaYyv6gsJd1UPZe5rTQLROfULnyULNLsK+URWngrQILgL52kQh5XUUJfX94EvUtnqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(16576012)(26005)(82960400001)(36756003)(31696002)(6666004)(66476007)(38100700002)(186003)(508600001)(316002)(956004)(2906002)(8936002)(6486002)(86362001)(5660300002)(53546011)(8676002)(2616005)(44832011)(66946007)(66556008)(31686004)(966005)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3FRa1ArNHFZWkZ6SCsxZ3dncC85a3BaaGJIUTJWdVFEOHFoNHFCN0g3SzZ2?=
 =?utf-8?B?WUdnQk5KSnBzNjI1emc2b3FUYU1JazJUY1FNK3pKMFN6bFhFSVc3U0JWYmRF?=
 =?utf-8?B?N045bFFIRXlrbDREMWsvYlpDSGNOVHllb2c3MklLUlBHak5vZG5IbUNuMUNq?=
 =?utf-8?B?T2FVQnFpNG92OFBuK0pzcE5JZGhKMTdxQklRQ0RlVVZaNHFsd3NteUxGT2Vl?=
 =?utf-8?B?djFaRnRmcWlrY2dpNXJ6Q2l3MlUyYlBqWDBoUkdaVVUySlZ0Sk5ZbmV2NERk?=
 =?utf-8?B?YlJhRmhzUlA0ZDJ0djBXQXFLWlp4a0ZHcWxGekc3TldDMmcrc0pmV09lMThW?=
 =?utf-8?B?U0NlcmN5UFFrRVZXUTBBZGJDWUxFWnpzUVUvZ1RzNndYSFgxVk9OYUR3azAz?=
 =?utf-8?B?U2IrNXNnYVBPaWYzdk55TU8yNGVXc1loTS9IYnZwRkZpSFQrZnJBRFQvT29V?=
 =?utf-8?B?Z1A4YTZ2NzR4TVB0aUlBTEFuTHZnT0UxQStDQ0hkNW9nTnBUenY0bGVGdDRF?=
 =?utf-8?B?UEwzdWNQcEdYWXVBM3QydWxmenpZT3ViRGhXT1hJc2F4ZC9HUHlQN1BkZmIy?=
 =?utf-8?B?OUtST25Ud2VVYXhNckZFeTQybUtmQ09xWng4ZStxS0plbW9pcHBEOEphTk1p?=
 =?utf-8?B?NTVobnN2WEFJVmRwcEE2OTRkeldYQy84anFtS3J5VmwrTlU3RzJqdmxWbFRK?=
 =?utf-8?B?cTlpSk82UjhkM1lXRUZtNjZjR0lzdENkZExqR1oxeWhsOVVSZUdvclhZSlZr?=
 =?utf-8?B?KzJTb211VkdQbXM5OHk0VFlNVE1JeUhHdzRRRUp2V0oxYlRESTgvMGJiTkh3?=
 =?utf-8?B?VE03ZVlTNitLdUZGc0NrZUJCZHpQc2JmQ3FVblR0R2ppVEp4bGRSY2JrUHB0?=
 =?utf-8?B?VFhhc3JMdWEvNzd4L0c0OWpPVlQrOU1la3JnUm8xMnJxMDI3amhaWS9haWZ4?=
 =?utf-8?B?a0Q1ZHJRbkh5ZUtqR0ZGQ2MvTk04UHBqeXJESW9jeDgxZGJ1b1lhMnFRWGJ2?=
 =?utf-8?B?NTlmWGduNUNKVmpaWlV5Y21TSW1SSCtKd2ZsOUFDMmUrVGZRMkZCV0ZhZ2dV?=
 =?utf-8?B?U1lmQ1ltM1F6NGNtcWdCbS9hSWJRZ0k3OHMyL0JXQWxvU2tTQXJFL0VJZ1JH?=
 =?utf-8?B?MldVeE9JaERMNDZqc3RkcTdkTGl1MlhZV08zTEdqK0pKM1pWS3hWM1RMcTRP?=
 =?utf-8?B?bnVNVTRuUFJQNWpxdXpLTUcrTWtJSXJnbVpIaEhFVHNML1hWa3V3RmZLU1dq?=
 =?utf-8?B?MmJDMnZlcEVtWkdoL1dNTVlRaXE1SFkraC9uZ0FqcWRmNGZNV3ZZbmJpN2Rq?=
 =?utf-8?B?blo3cnkwME9aNEdJTmdsdVlmdEhPTThpenBxeStyNTk5NzNucjVpeDdXUVRx?=
 =?utf-8?B?a1FWWGhmc0xOdFFxNmhGTnVEZ2RZeG5pYW9uVkI1emNyTk1NdVVRTmcrNXNS?=
 =?utf-8?B?N2xlVFJXczcyNlB6L3pYN3NZbXBjL0pHYmxPYTdscDFvWGxqeE9GczByZldK?=
 =?utf-8?B?UnNBemNNb3V1VkhNVnpvbmJrYjR1V1dkd00yOVBtSFIyOG9MbWNPek1kdFNK?=
 =?utf-8?B?VW4zVjYyU0l6L0txSnlaUUhaQ3IxTlVzV05aTHFvNkdFYit6QnR0MmJGdTEv?=
 =?utf-8?B?K3VWNSt5bk15S3VoZVpmTzJDT2luYXpRSHZWYkFMT2p1ZysraWJGbUJNWkFs?=
 =?utf-8?B?RkR0ZWNhanQ2MlkrcDNnam42aTRpdDQ5LzdQa2FqdTFQN25LbEVleGRCYzdv?=
 =?utf-8?B?UWdoZm5WTHVwZ3NMN1UvNkRMTVBDK0lXdTZENVlvWXVrU2VxN3IwRGtMWGFp?=
 =?utf-8?B?UnJxNnQ5b0YvYkw0SUs5SnV4NkhoRDdHUm5CSGs1RmQ3emtCL29mOFY1MWdT?=
 =?utf-8?B?YlhxeXVUQXc2Q0N3TFdkOUhkdThSc0w4cHNEdzBsNURkWFZ4VHozbVNsWXBq?=
 =?utf-8?B?QXBXeWRjS2FvOGFpdmNMRFJHMGFneTRVWkhXZkhvTG03aEdEOW1PcCt3NHc1?=
 =?utf-8?B?MHJiekkya3V5RDNrSWdsalFmbFhmSFNCRzVyUU1PeFkvWlphNnNZenZ6Witv?=
 =?utf-8?B?ZXFqVFAvVW4xKzJITUdHSDdWUEZibFJvVmFqTnpoRjRqTUIzVHZNNTJwNFg2?=
 =?utf-8?B?cU1EL3p4WDJrbm5DbWVzUTFzTDdGMHVScjJEbVFQcTdyN2tlZG04T01md3pw?=
 =?utf-8?B?Q0h2Q3A5Szd5UWdTMHoxZWdnd1MxbUs4b0hCSHdVU09LOXN4dElTeU1WVzN3?=
 =?utf-8?Q?LOiDyWSuIKvyLZtesd3FF9dS71VGsBKB4P/QflkQTc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2265b073-af28-4a1c-d526-08d99b0ed006
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 19:03:37.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yePbo90+RkeWvmc10Zmhqk2B7HQL5DPo/LZjVBYBVRsQYHFchp0WztPdQHPhll4dy9eOpaXiU2veRqsDb/u/H5UHD6dyfrNfcZM0xZa6xYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2529
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 10/29/2021 11:06 AM, Dave Hansen wrote:
> On 10/28/21 1:37 PM, Reinette Chatre wrote:
>> The amount of SGX memory on the system is determined by the BIOS and it
>> varies wildly between systems.  It can be from dozens of MB's on desktops
>> or VM's, up to many GB's on servers.  Just like for regular memory, it is
>> sometimes useful to know the amount of usable SGX memory in the system.
>>
>> Add an attribute for the amount of SGX memory in bytes to each NUMA
>> node. The path is /sys/devices/system/node/node[0-9]*/sgx/size.
>> Calculate these values by summing up EPC section sizes for each node
>> during the driver initalization.
> 
> For now, can we just make the selftests read the SGX CPUID section
> leaves?  It's not as precise as knowing how much the kernel actually
> decided to use, but it's good enough for a selftest.  It also means we
> can merge something without having to worry about long-term ABI.

Yes, we can do that.

> 
> This is also why I once suggested that we first make the selftests
> depend on some debugfs file that would be short-lived.  But, if we use
> CPUID, we don't even need to mess with debugfs.

My apologies, this was not intended to avoid your suggestion. V1 did use 
the debugfs solution as you suggested as placeholder but after the 
debufs solution evolved the tests were adapted to follow those changes 
instead of sticking with the debugfs solution as proposed in
https://lore.kernel.org/lkml/6f3cc681e10877e639b882eaabf1a5e21bd2fc94.camel@kernel.org/

> You can even just steal the code from sgx_page_cache_init() to do it.
> 
> Would that work, or am I missing something?
> 

I do think that will work. The selftests are only interested in the 
total SGX memory (as opposed to memory per numa node as exposed with the 
current interface) and that can be obtained via CPUID. I will adapt the 
oversubscription test case to obtain its needed info via CPUID.

Thank you very much

Reinette
