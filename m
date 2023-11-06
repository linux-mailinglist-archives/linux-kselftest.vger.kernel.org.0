Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A7D7E2A93
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 18:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjKFRE0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 12:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjKFREZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 12:04:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED4C191;
        Mon,  6 Nov 2023 09:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699290262; x=1730826262;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AFhd0H1Z99WCIs9OOUwwrGEMPYjPKg3yorZl/36vNXg=;
  b=JYrRnTxPDYSWr7Oeuxhf4w1mWupXpdFXHuesfnutN63rnSsrd1EHhEeh
   82lqmuTMVTBSUIJriP+xA54qDhQascf6fyjdBKZRE18emQp2WbNf7PADk
   TImNIVedZWMFPBptoYbj98Qh4exOZecwZpQMdsIPNGZmVilmXJdVlWSpA
   m4PjRXjEJAAglmCLWS8Pkj37+UvGAyUeWx+PJJ+Rl+ZhfhuasDInjxvRh
   cMTedbz5aVQzFpwlgEi4xsIjs40p3FRgJBWl08V01QM2mKZg57q8vH93w
   vChyrd+inhgoosz2nDLXMDymQsvWB00N4K+I7GQczCUenU6vIGllpOGn0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="379712492"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="379712492"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 09:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="3675639"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 09:03:33 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 09:03:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 09:03:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 09:03:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqqqcz5qE6ouSxsd8iEEioFcAOmq2Iuv5R+kweOuvpb3Bh1SYNP5rsz15KaANa1ZSqcSl9oF3gMG16af27CWGFkw/vzI4hhnSlh3EqFIkIvUqVjRF0sAzc2eKQdgDBZ4eFnMfQ3I1aTbdSwn5WpRYri80PvaLON3U4QCssZYXEXW3dezBB6cZBb7EcHRAujT1fe2J+yVjn0ibPbNXGPf8Ig9eh6xiHOA91n0tuXj1PxBBNbc2jvufV2aSFbPVMLJP/jX6lDMRAA3Qk+13Hv+QzTDa3E5iPAgBQ7ulJiPgKGTK/0TP0kKJPRS2OErhnOi+e6PygfAiKBfh1aqlyJNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK+taGT9yIYT2xEbW4I0y/GxS/B6fksZkhLiIDK6Ow4=;
 b=emsWu3TVQv7nbFm8agJU3GCreD46AHYisuzRBgRyXWMLqmconrphTHjJp1DumLtWA4PPqzOwf8NxGz7pq8kJMYEaydyHW5xb3wEE3DGoZBrkIdOY0hvUuTeYSSa3L6Q/SyhHQUqrBHpa/rj7LeXRcHs7pblBPgheur8Qc/zR1nJGHDAJaW5YZlWVx3+2CafQdhdGrqZQ7Jm1vfjrqFk4yCVR9QSnBLD6XC85n2GKb2CG3tMbe4gU1jbpnzv6GGKYJ7I4ktcz3uGZpcbe3/dVAhkzBEB+nuvbCpHGyKX+iNeD40aCVnlUakYv8VQy/vB+zAm03Hu4D7DHQhasPbsAvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW5PR11MB5788.namprd11.prod.outlook.com (2603:10b6:303:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 17:03:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 17:03:26 +0000
Message-ID: <755ed028-f73a-47ed-a58a-65f4f48eaee3@intel.com>
Date:   Mon, 6 Nov 2023 09:03:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] selftests/resctrl: Add L2 CAT test
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-24-ilpo.jarvinen@linux.intel.com>
 <8051f3ef-1126-41fb-b6cc-f48441936dd7@intel.com>
 <2514e73e-2419-7c88-3f22-469db4b2fa25@linux.intel.com>
 <48c6795b-554a-4019-bb8d-a2ca0f6fbb2b@intel.com>
 <4008929-d12b-793e-dce8-eb5ba03b4ebb@linux.intel.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4008929-d12b-793e-dce8-eb5ba03b4ebb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:303:2b::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW5PR11MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ecac54-f35a-4f18-e2e4-08dbdeea4ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wo8eRo4kuH4BGhrZ6G0EcfIYw13td2tbFhNnDi1UZ2WWOUvoIgYQL+LELJcwgf8uNCeC7/A1aQKmTTrDl090ch4KjfycxSUnSus3zyWmf4UB3stK7qa3QxbMrNOwHraqtclG45CwK0RUoCnN1XwKeuBi5oEOqztnf+9j1Cf3AAeoNtf/aPpLT4sb0qrMKVujZ7chWys9PzJXCzZwZ4WryIZmsdPiyCXIcYJKemsAwU8PdrGY1p8S2zjNHoiVQjTnYBaqQeFqFWfwUEFEqZkf7tQEjdAPtFHfU1bN8dbRkep3KnhXkQ5LfVPKT5UuXnZn5v3VeCCyn+FKZZvi+AqYKl3xpwtQIwtXbg49zhbrzbvue93LP7JKqKVbRiMiXH3N+fsALffBuUuYAPQLSpFhnJMwqhS3ltXe1PRrWD9kZMjKxW5PlfAguij6WUhYlHIXkPP8eC0W8vlDk9edfkaUPS+hIUVOG0NumgfJ0uAYVdEtEnxY2Yd5Ep0UHPt9TgboyB3ECMXxJp9q3DHSF9JQ2C6oLdm4ohsyV5V7M9vMNu9kP4VtUA7PL0HYHLitFGkcBNWCxtJAiDKxd8ZR2QsAFqRHZh94m7k1yVHasBCQhxw1XROBqMse8CL6riQlTls7hYSMdwriIpXH6qOLJ8nR5FrcU6ClPAzAgIfF7TQX0YDPnb4yiF8K0hUNWUEocyv8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799009)(64100799003)(451199024)(44832011)(6506007)(6512007)(2616005)(478600001)(6486002)(53546011)(83380400001)(2906002)(26005)(66574015)(66946007)(5660300002)(66556008)(66476007)(41300700001)(316002)(8676002)(4326008)(8936002)(6916009)(54906003)(38100700002)(36756003)(82960400001)(31696002)(86362001)(66899024)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDFWR1pmd1dzMUF3UHpYdlU2NnA0eXZXM0luZlpPZUpyRFFmbElub29xcEtr?=
 =?utf-8?B?dEdldXROSkZIc2pEZDFtY240RUVoVWZlNy9acUpXc3ZBTzlJN2puZEtNTVk4?=
 =?utf-8?B?VDJwNUpEelNraWtPbVJoMGVYOVlZL3dSdlREZ29BTWlmcTZjbzEya2hGN1Rt?=
 =?utf-8?B?VS8xeGFOYmhZSjBKZUkxTjhTa3VkOURYRitqdnhkd0xVa1N3cUxuSjRMN2dI?=
 =?utf-8?B?OE5SWW1WYlRDalE0RnJCNXF5Uk12M3FSVFhVSC9Td3drcTNycU4zSVcvNVV5?=
 =?utf-8?B?QlorMklJY0J6WndJVTlKK2hYa3M3WVdPUTRXL05nUUwzbStaVGJDekc4cldO?=
 =?utf-8?B?OEZqYjRkQktoMjA3MWhnRjd2U1JiMXpVTTVlMnBRdzdybzBHYnlTVUNGVzlv?=
 =?utf-8?B?SVJkVzRZWFJMQmVwK2dSczN0d2JKZzl1Q3RmVUhiWmlrMys0VmJwOVc3c2pV?=
 =?utf-8?B?SWZCNnpyMWJSZi9zMXh3RDV1ZDdLODFXNTR0bmVoM3BkNzJqUVhVZzIrOXUw?=
 =?utf-8?B?YVlhT3BPamtaTkw0UGFLdzUvSmhXSXZPK2I1NGhrUG05MUxjZEZuZTlFQWdp?=
 =?utf-8?B?UUNzNUFISFhrLy9kYkNwS1picS81RU5yWUV5aUgxTEpLakQwbkVRUklnSGFw?=
 =?utf-8?B?a28ySkhJMGhwajZZQllPNS9BMno5bTdvQjNZV3lTNTBKMGFuWm42NDJVUDls?=
 =?utf-8?B?aWtRYlR3dTJMclFkUlpiYWhNU3lhRWE3SkNXanFhdHJEd2xpYVZWTnQwYmMw?=
 =?utf-8?B?cUxNWnpTU29yUXFuNEFQd1V3RE1Qa2pKeFNYL1NrenpUUUdqREE3YTZpQnpN?=
 =?utf-8?B?N1ZNTkhnU2FZYmcrTVQxQnI1OXZzUzhFd3dBd29pVkdhWlZkb05Dc0pJRSsr?=
 =?utf-8?B?aUZhY1JUSlhLNVNoUUJ2cjZJenNrRE45NHEzZ1pqaEo4L1hjL0R3WGtDcXBQ?=
 =?utf-8?B?enh6VUYybjZWNFIwWmdLeUNjT1ZWbGNETjBja2NkbXA0a0N2bmsva2gzRWEv?=
 =?utf-8?B?NUVUcGpKbVlma2lsUTM4eUczVWR1cnBYRU5vMGwwbkxIRjU5eU1kdXE0TmNP?=
 =?utf-8?B?SjlLTXk5WDV1cC8zM2hQeU9yV1RWZkNuYU45clJFTW5YN3RkbkwrcUgzeXd2?=
 =?utf-8?B?SzhIVmV5WjdBTldncFFJN1NHbHhaME1MTTQvNXZtMWVOcFFzN1FhQmpaVmpF?=
 =?utf-8?B?VHNBYkRxc003cWhWNUQ3U05tME9ySEtqemJxcjk2d0RPc3RSOHU2UUk3MlJi?=
 =?utf-8?B?MFdyMmF2Mk0zWERYd3VLSVlYYVhxTUpoSGZUVzdSMjVYNytpR0ZoYnZIUFNO?=
 =?utf-8?B?eFJVR25UQ3l1Y0ZHVEFFdjFkTythT1hXc3NEVHBwWXVMQ0hXdmNpTkkrT0NB?=
 =?utf-8?B?akprOENZekZjdWRYZC9lWnpROTRBQ1JpRDRBYXFCdjJBYVNXb25QMGhJQU44?=
 =?utf-8?B?cGcrcTBXTjRTK3luSUxrUy9uWnNLN2tIQmNoUzJkTzJ0UUdwV2Zqb09MVGVM?=
 =?utf-8?B?aG9zM3oyNDcwWXBJUzRTUTFtS1pqWG1UeGNSdldvM1hweGxLMnRMU2NvSmVT?=
 =?utf-8?B?R3A2ODBsZ2w5VUJhV1VzYXJ4d0xaVzBpWWc0UjAvY0ZOUmdiSk9RNTNBVm1S?=
 =?utf-8?B?dTdYVmpPNUlkTEEyTnA0N01FVjNUV1hmZVI1MDNtUlQ2YkV1Z0ZkQXZYVDZN?=
 =?utf-8?B?Y0lwUTZpVm1JOXcyekptSlFUWEoxMHJmaEF4RlNoaEtxY0QrNmFSeXRNcGpw?=
 =?utf-8?B?dE9rOXBPaHNmMWxrc3ZMMHA0QjdBK1FheFkvRmNpTWh6TXFrMzJQREQwNUVY?=
 =?utf-8?B?K3VsZjhJZDF0dzd2QWJ2UnNMNlR1Zi8xREhLU3J0c1l4VFhZWG9Ma2huaElO?=
 =?utf-8?B?TEpOQkpOQ3ZEQVEzM1dESHRpdjg2YWgrekVSVy9RcXpKSUJweW11L1RPZkFs?=
 =?utf-8?B?ZkYxNjZIclMwWEhlNGFjbGx5RFg3SnJTUVAyT3R6UVA0Rnh1SFBOU2RVUlQ4?=
 =?utf-8?B?QmRuMm1TbVRldlBrR0d0YitOaGJFdnZYclpxKzZIT2RLbFdiSm5qNTZ5dTVB?=
 =?utf-8?B?Q3dYRzNCa0UzNGpDUnRGZHhMOFhLc2FmS3EyZjk5am9ua0JVM3oxendrOTZE?=
 =?utf-8?B?R1Z4VldtY3R4S21HMXdWQXdCVmhiTllVM3diTW9VMWp6SEN0cmdUV1RhbHE4?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ecac54-f35a-4f18-e2e4-08dbdeea4ab5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 17:03:26.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5d40XEmSDN04zS2CcGaTBaxOa7LMHhKXyXhZ1JycHyZqSLKUszowaidfXwSfKPHHGArITVZNyOXh8pCoPLunPcYqpKP/APQDmc6/qsm8bzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5788
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 11/6/2023 1:53 AM, Ilpo Järvinen wrote:
> On Fri, 3 Nov 2023, Reinette Chatre wrote:
>> On 11/3/2023 3:39 AM, Ilpo Järvinen wrote:
>>> On Thu, 2 Nov 2023, Reinette Chatre wrote:
>>>> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
>>>
>>>>> Add L2 CAT selftest. As measuring L2 misses is not easily available
>>>>> with perf, use L3 accesses as a proxy for L2 CAT working or not.
>>>>
>>>> I understand the exact measurement is not available but I do notice some
>>>> L2 related symbolic counters when I run "perf list". l2_rqsts.all_demand_miss
>>>> looks promising.
>>>
>>> Okay, I was under impression that L2 misses are not available. Both based 
>>> on what you mentioned to me half an year ago and because of what flags I 
>>> found from the header. But I'll take another look into it.
>>
>> You are correct that when I did L2 testing a long time ago I used
>> the model specific L2 miss counts. I was hoping that things have improved
>> so that model specific counters are not needed, as you have tried here.
>> I found the l2_rqsts symbol while looking for alternatives but I am not
>> familiar enough with perf to know how these symbolic names are mapped.
>> I was hoping that they could be a simple drop-in replacement to
>> experiment with.
> 
> According to perf_event_open() manpage, mapping those symbolic names 
> requires libpfm so this would add a library dependency?

I do not see perf list using this library to determine the event and
umask but I am in unfamiliar territory. I'll have to spend some more
time here to determine options.

> 
>>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>>> ---
>>>>>  tools/testing/selftests/resctrl/cat_test.c    | 68 +++++++++++++++++--
>>>>>  tools/testing/selftests/resctrl/resctrl.h     |  1 +
>>>>>  .../testing/selftests/resctrl/resctrl_tests.c |  1 +
>>>>>  3 files changed, 63 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>>>>> index 48a96acd9e31..a9c72022bb5a 100644
>>>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>>>> @@ -131,8 +131,47 @@ void cat_test_cleanup(void)
>>>>>  	remove(RESULT_FILE_NAME);
>>>>>  }
>>>>>  
>>>>> +/*
>>>>> + * L2 CAT test measures L2 misses indirectly using L3 accesses as a proxy
>>>>> + * because perf cannot directly provide the number of L2 misses (there are
>>>>> + * only platform specific ways to get the number of L2 misses).
>>>>> + *
>>>>> + * This function sets up L3 CAT to reduce noise from other processes during
>>>>> + * L2 CAT test.
>>>>
>>>> This motivation is not clear to me. Does the same isolation used during 
>>>> L3 CAT testing not work? I expected it to follow the same idea with the 
>>>> L2 cache split in two, the test using one part and the rest of the 
>>>> system using the other. Is that not enough isolation?
>>>
>>> Isolation for L2 is done very same way as with L3 and I think it itself 
>>> works just fine.
>>>
>>> However, because L2 CAT selftest as is measures L3 accesses that in ideal 
>>> world equals to L2 misses, isolating selftest related L3 accesses from the 
>>> rest of the system should reduce noise in the # of L3 accesses. It's not 
>>> mandatory though so if L3 CAT is not available the function just prints a 
>>> warning about the potential noise and does setup nothing for L3.
>>
>> This is not clear to me. If the read misses L2 and then accesses L3 then
>> it should not matter which part of L3 cache the work is isolated to. 
>> What noise do you have in mind?
> 
> The way it is currently done is to measure L3 accesses. If something else 
> runs at the same time as the CAT selftest, it can do mem accesses that 
> cause L3 accesses which is noise in the # of L3 accesses number since 
> those accesses were unrelated to the L2 CAT selftest.
> 

Creating a CAT allocation sets aside a portion of cache where a task/cpu
can allocation into cache, it does not prevent one task from accessing
the cache concurrently with another.

Reinette

