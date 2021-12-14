Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD567474DE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 23:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhLNW1c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 17:27:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:32508 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhLNW1c (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 17:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639520852; x=1671056852;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qqc2YRHhpCu7jPwRWQXc224LKSTEnW/iDSzBdhPhXgE=;
  b=I1KvsE1eseP9Gt4A/hwkupRcTSM/RP92/dkeN3MvcduTQREjURn42ksI
   q20KGpyA33Kg6b1PBQrmGeC35HT8BO21o2upV6cPyCvEIGbKGz0iZ/EsW
   fNaj2nizvrbPPVFnOxbw34ffbTxjI4ll1x7y6wh9X00hq+m5enVqU8WLF
   s4RqT6VtKnLLWuVhS4srIMcx7xqj9aGX+Q+r/N52NMswoqpRegsCMZSL4
   ApOqOuCf7VAwkU4c/quH6kpDzxSW8wd54K7oAmmxKQcmiwWHbpoey5dTY
   dmtIfVsae6932yGbtslPrh/DBz5aMvbB0OixWZBKOXjdRSGJyqpAytQ1V
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="219113418"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="219113418"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 14:27:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="482146526"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2021 14:27:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 14:27:30 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 14:27:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 14 Dec 2021 14:27:30 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 14 Dec 2021 14:27:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgwKT4n76JfjlrUjgzsyVunlvVCVmjg3lsRCv7l1TAVCVhzLPXS8bxqbOl8hVEDCkPaq2TdG2kUsXn05e79X/vGvG5C544UFCJIWN4VvBSyPjaa20wdBsnouMleZ3ZIEgUDs8DySQZwznNU3ovfuxIhv9mGDeSZsMv3VbuXAaySv08i4KUAAvzf7VmPcY+E6aWbU+P1bAxVbk4LPKqITU01FbH4CbTXBJOF4rPXff+qUDV87LMK5OFqa/OSYV7l7duecm5nmk6dehZ+rnIWEFQuuEzKajwyTASpGGEW/t3IDLlOyII8vXiXhz7Gao9qRolYDsrupY84Bdk7vZH2nsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF5Wi9hFi4ICpEJcFAHLFxJhX/BOtPk5vhtqDYtsbmI=;
 b=duZhHVtQs82ZlRCSXrj3wB0M15Ql88ZAk/gjXPZWCgSHaygawMOmM/ASJ94u9Q9rBwTtZcmhWDrmM0+nJNWn0oZ1tXqDaxUt/4X2+OiJFCfHgI1OukHwCqKv0tezsFusVJH8M4nO1Qar3CwyIhYCsCCjYx12QfRukKBbsQ5yIBOSvCAAElw2Aqc3eNLbuo+Otd2kAIPeRy8npJxLSeUyhduDxixq9yr+limPu3i3Zi6ScNcLN/hbf9PyMQwmavWrP1yBvWOyA5FZ6ZBj2siUJmwZRdmzsGYrCdM0IzwUVUd7f3VhvcB2xG+39tMk9zqmVSrdA/98M32VqiDAQ72JxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF5Wi9hFi4ICpEJcFAHLFxJhX/BOtPk5vhtqDYtsbmI=;
 b=W/zOwgrjBn4t7QE709lJpHNYJAwDcSJ0A9lj4hN++PcfdkxKL53fS4lnXfZlMA1032QntQMAdlCAaCcUZ4bMLgXbXuY9tbiVJp18NQWN8FIjK4WwTM66XhBreuSRVowLqu1A4nrfJnlqTxgJQv6LR4y9f/VqFqfoigR1/7J36v0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB3923.namprd11.prod.outlook.com (2603:10b6:405:78::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 22:27:28 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 22:27:28 +0000
Message-ID: <2269d5a5-f388-773f-c6ec-758003ae2e59@intel.com>
Date:   Tue, 14 Dec 2021 14:27:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH V2] selftests/sgx: Fix build error caused by missing
 dependency
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        <dave.hansen@linux.intel.com>, <jarkko@kernel.org>,
        <linux-sgx@vger.kernel.org>, <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>
References: <de2a262e97e7b173548b909a608e9e99aab38e9d.1639509500.git.reinette.chatre@intel.com>
 <8b7c98f4-f050-bc1c-5699-fa598ecc66a2@linuxfoundation.org>
 <4dc1dd00-320b-e625-83db-70184141e9c9@intel.com>
 <b64a7830-d21a-fc61-b5ef-8938a97ce878@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b64a7830-d21a-fc61-b5ef-8938a97ce878@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0072.namprd15.prod.outlook.com
 (2603:10b6:301:4c::34) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b11004cf-9348-43d9-3db8-08d9bf50e943
X-MS-TrafficTypeDiagnostic: BN6PR11MB3923:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB392395A2A2ABA608EA532B77F8759@BN6PR11MB3923.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+h3/eF59JmrG9f/ZHh67NvzCwSdB3KXtS8zdAeFAZMWFFlcgtqOqb5hKlm8XPH3SomNQpJLPTjkjQmlNKWZP3FOUjVGV6P4eAjGLSqKk2dEc+E94E4ywTawhw4434WhbMIjO9HfgTNYen2cE/XK4s0/t1ojiMQcoJYW0JF3zvenpa3SROc7CO2lThwHlAIqe/jlMZkuXADjEL3ikuxg20oPhnjoqTDHerBmUzoOqvOa/f1L7u7fkTWXsYYLEJ9jMW9KS2tSVP6L5qlt7CQMFy3D+Bt4e4A2a6tbxJo7lwx/dPwi/OUwxdllZ9ktXX1FWMjHw1gccEzNm5pKBQXGTMER8NwFdcrMXZZwatoKjcWgCbZbtP1up1gBlrIN5EqGXQFax2q4bjF3FQHePASNuP5mtJrNEiabEMNZjZpao8chlTNjX8SMZL+I3kknSi92RTiIUyrB7k9Nlmt/wrmMv+K7CLkP+E8ZfcB6Y9oQdzHcXxuEDib0m5VcFD3psZlM+HA4U3fP0skrLHa4XnBmrKDEwQnXCv0YBgednJOL0tPCPXfPOxiCHLtx0DW4WYxYVl4yQTp9islKqFO4AALi+A19HstZ3Z8N5x+eaGEkG6i5fhGEkeRmyaqNc9OPSHlyvT0UTiCtHCsxblkIUby7KgW+EBaRQaUYDidDcwXFq+79K8EOD9YVpRynYN59nRQjXUDzH9LxzW2IvZ1bA2HGZZS1fKEYRj3MQbpVShieTVM6XdUHtXVEPNrvH2VeT88x8T8OHKTXIhKkwa9StPiDNinJYJZmoKvphvFzdbQfnUVgtMGHX/U4cHvctpYL1qJX6P5ZfpYht9BcV1wjAlbyqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(36756003)(6512007)(26005)(86362001)(8936002)(6666004)(31686004)(31696002)(8676002)(2906002)(53546011)(6506007)(5660300002)(4326008)(316002)(6486002)(508600001)(966005)(82960400001)(66556008)(66946007)(66476007)(44832011)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGlzemRBSkVwVlBxbGxBV1JhUFM5Umk1SjdBSk5MYW1rMzlyZEFxVDZ2Sjhu?=
 =?utf-8?B?enVJSEJDTVJaRVVQaDFSdDFWRDNldDdFRFBLR0lQQTB3dFZWV2ZHSldOckJB?=
 =?utf-8?B?bS9HVS8raGtoN016akE4YW9iNG9HbkQwSTYyNWxyVHhSOC9zbEk3UkJuTnZP?=
 =?utf-8?B?UStFc2Q2QVF1Z2hyTkpRaUxsSFZjcnhIR2Q1cnZWcG1zdUN5UzRnMWFrRDNa?=
 =?utf-8?B?RTQyaSttaGNjWkwrM0lqQlVvTVNXanpxRDNRTXZ2WGx2aU5uY0s4Yko5Wk9Y?=
 =?utf-8?B?OTAwcjlMTHdFeW4rMTI5OUJIeWI3U1R1b0FkYUxXUlMyVU5BYWwzbXJwUGoz?=
 =?utf-8?B?bGgxQW9hU1V5NnhxZXdlUmt2Yk9jYUlIb2RqK0pLUUppVWtBYy9LZjBUVEhH?=
 =?utf-8?B?WW91dTdXSmlWRzJtUU4zN040RmRGNWlndFRpNnlzdUt3RDlMQ3RJa2pjVG91?=
 =?utf-8?B?VjFHa29GZFNaWElDeTFWNi9iWTB6bkFFazFEazBvRU5EVHI0ZkNKMGRHMmho?=
 =?utf-8?B?QnE4SE9KaytWVWdFOWVDL0dLdWhsZU1tZW9VL3BGK1NCTXcwYWpkVk8vVHFP?=
 =?utf-8?B?bzVRSjBVcUZub0ZRN0xNbnBMMk1rYndYSldOR2h4TmFkczRMMks2dFVDeWY1?=
 =?utf-8?B?NEtHL2l4Q0Z0aGRPd2I5MUR3dG5uVlFia212cU5Wc3dRRng5aXF3VkJ6S21W?=
 =?utf-8?B?OUtwQlJGVm9BSmp1VzZOa1gyYk5zM1M2dG9ET3c1VHFzYUdjS3paVWdINFZG?=
 =?utf-8?B?cUpnYlhvSjZ4dGVPYzkrSWJ3Yi8vS3Z6MUFmZERkc1J0UmI4WDRORFFRN0NB?=
 =?utf-8?B?c2R4c3BEQ1VRbkM5RUI0V1o4a2ZpZVlpNEZ5bTgyQ2hUR3U0ZS8xaWZBK0ky?=
 =?utf-8?B?RjF3QVBpcDErMnljc1k2dTBOTHV3L2Z0cHljZjVNcUVHSklkUUIwa1NzS2xT?=
 =?utf-8?B?bm9SRVJnRU9uU0IzUVlzVyt1T2p5OVlLS1dTcEZtVitVb0pQaWZqUmtDVng4?=
 =?utf-8?B?U0FiSGVyczZTc01PdGZCMjBodjUrMHNJTTdMcWw3SUVVcW5MVExTVEN4MTFE?=
 =?utf-8?B?MnVkTWVYcHpHSm5xdmNzQm4yR1RxK1MweExLdnlTL29wWitoVndwV3B4ZjBJ?=
 =?utf-8?B?WEtxT3VGamtEZnVzcDBJU1NVY2RNb0wyclVDVUhEZVZIKzRNdnd2S24rUUlr?=
 =?utf-8?B?SU4wL1ZEVmRFQ2pIS0NjLzdoZDY2U1pRTzd5OEtkSnhrY1VOa3p4Y2RGcVc2?=
 =?utf-8?B?b29lQS9ybFN0bjlnWTluVGd1T2FxV09TVlRpN2hweUVSejJScjRsZzRaTGd5?=
 =?utf-8?B?a3dUQjhkaytzd1pCcmpsSk90ekNDanFMeHg5amxKTWlRZFByS3ZmODVxWWgz?=
 =?utf-8?B?Y005c3JZWTVYYklPK3VvaWRKd2xVWTZzMGJ2cXptS0VJcWVCbitsMHRVdzN0?=
 =?utf-8?B?cnZkbkl1MTc1anBBaDZBNlY3Mld1U0QrK1hNd1NJcmJXdlJHVW1NNDlZdXVn?=
 =?utf-8?B?cG5XdTVIMTh4QnhtK3ZQMG82VE1iemtndWJvZVcxcWd0VWFlQkFhZWRnQSt2?=
 =?utf-8?B?dmFrdUsrZHpQQ1FaSUU4djF1R2NaUW5hcXJlT0h1M0hoSFRLYzVCLzlCMDhS?=
 =?utf-8?B?am9qdURwYTU4SndMVFRkemlLNmxXOXJaeGhpOXZXVmNwbXJvMFpkOTZMNGFi?=
 =?utf-8?B?RExtS3FrUXpOM0lsUHRxQS91VzFqeDFqQjdESnJIVUhGdmRybWQvdy8zZGJ0?=
 =?utf-8?B?VzJ1ZzdpSmRRd2xKVmp1VjNHTW1MSjZHbmtRWmpOYythSzVoL2l2MGtjVnBS?=
 =?utf-8?B?dVhzMzI2ZFp3NXE4K2U0MHBUMlcybkIyTDF1dFM1ckJRUlp4OHViN1MyY1Q1?=
 =?utf-8?B?d2dmUlROT0hDbytTWmxEYTB4N2lkUDJ3TDVBOVVjbTc5bHhKbXRubGVIS2RW?=
 =?utf-8?B?VXlnMU9Sem1Ud2Y4TmI5ODlqdW5BTTV6WEw1N0lXZzJFMUtUWUJweGpSWWhT?=
 =?utf-8?B?U1ZaL016WWtRNFNKTG5WTnhWSksrTGZxRUNWSm55azlldTkxdVViVXEraXQ0?=
 =?utf-8?B?RHRhMnJ0OHRVUGp0SFNPVk1ablJjaUpPb0FSdmg3V1dSN0Y4WnhiV2VaMUhj?=
 =?utf-8?B?MXNEQnFpVlRrR0t4VDRaVFJlMDlXRXJCSm1VZXZHZ0pRWjNZNmxYVFFDeEx4?=
 =?utf-8?B?dkhxNGxEMmM5QzkzbnZRakdxTHdhL3U4NEZtK3h2WkRnTktKd0p5SjVRNEFY?=
 =?utf-8?Q?aq85bs6wtNnbZhrdSNUFzWv7nL1DdJRQyZJDsznvFk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b11004cf-9348-43d9-3db8-08d9bf50e943
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 22:27:28.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFP6wsLiLNVATuC31/Tn4EN6Zh51tuFGEr5arhDLbCOyHhwU84jNDBXmcRKlQMiErnmYzB8idlBN/EqEa5379EkaVy/cVdfcs4Getyw0arY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3923
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 12/14/2021 1:55 PM, Shuah Khan wrote:
> On 12/14/21 2:28 PM, Reinette Chatre wrote:
>> Hi Shuah,
>>
>> On 12/14/2021 12:10 PM, Shuah Khan wrote:
>>
>>>
>>> Let's not add one more __cpuid() define to the individual tests.
>>> We so far have:
>>>
>>> tools/testing/selftests/vm/pkey-x86.h
>>> selftests/x86/corrupt_xstate_header.c
>>>
>>> Let's move the defines to kselftest.h and remove all these duplicate
>>> defines.
>>>
>>> For now you could include vm/pkey-x86.h just to fix the build error
>>> and do the proper cleanup.
>>
>> Thank you so much for taking a look. We actually do have an 
>> alternative fix that could be considered for the other users of 
>> __cpuid(). Instead of another clone of the kernel's __cpuid() the fix 
>> includes cpuid.h and uses the existing __cpuid_count() from it.
>>
>> Please see:
>> https://lore.kernel.org/linux-sgx/20211204202355.23005-1-jarkko@kernel.org/ 
>>
>>
> 
> This looks good to me.

Thank you very much for taking a look.

> 
>> We decided against the above fix using __cpuid_count() because we 
>> could not explain why all the existing users of __cpuid() implement 
>> their own and decided to follow the custom instead ...
>>
> 
> Most likely, copy and paste and taking the easy route. I looked at a 
> couple of
> defines and I dont't see a difference. If there are differences, that 
> would be
> a bigger concern. The whole idea of not having duplicates is that we 
> don't have
> bugs in these duplicates.
> 
>> Do you see any problem with including cpuid.h into a selftest? If not, 
>> then we can go back to our original fix of this issue and I could also 
>> submit a change to remove all the __cpuid() clones and replace them 
>> with the library's __cpuid_count().
>>
> 
> There are no problems including cpuid.h - where is this though. I 
> couldn't find
> it in my cscope search?

On my system it arrived via user space's libgcc-dev package. This does 
not seem to be the first time including files from this source - I did a 
quick check and from what I can tell existing includes like stdarg.h, 
stdbool.h, stdatomic.h, unwind.h, x86intrin.h ... arrive via libgcc-dev.

Do you still find that cpuid.h is ok to include?

Reinette
