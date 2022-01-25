Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3CE49BA3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 18:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588120AbiAYRVy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 12:21:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:17780 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1587749AbiAYRTt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 12:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643131188; x=1674667188;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BsnRubx22Fj8/0L7Xi2Yv1yTm/yYFRW0ChfpI3cXlWc=;
  b=YoSZImemxuylRCxIIdpi1UCis7cUwPF/FEmDMlyukS9JNqa4F2N+23cN
   lr1KdfQVaqWBMbxzmaeo7Cc4OlmUxQxFHyG+GXwGOTSZVgPvRiK2cHrCF
   h0R2A03x7G2xK647NDngtIrtcri0a08AAOqd3beGzO6XAPCneOblvV65h
   +4Xa3iWzsfLgKQDZKEh81Z0rZtCMGe3o07456U5vkcCzLNfLlRdVA8dpR
   sKgrM9Eh3wdwu7/36lCnp8cZhTyCxnfFYINBJooteUZp5pAtnr/onYksS
   MxS0yRBuN5w4qdfT4teXduZqpZeRrd0vcpbmlX8gt+1iuEtm3ZA6fvkJg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="245188789"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="245188789"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 09:15:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="597190313"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2022 09:15:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 25 Jan 2022 09:15:24 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 25 Jan 2022 09:15:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 25 Jan 2022 09:15:24 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 25 Jan 2022 09:15:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAfQdsc16UIOYLqj5/qfW6VR8sbGkewB98ir1zNEIwXAqIMqyni1jeKJRIwFMcciI0QZyBeu3qehpEcGy4Olnss9oqF0RwzA52PWtfTfRLr0OZPIeKQVNOlEQle6nK/wdXOoBHINkNVFOBwTzSpyxJ5o9cFDEozZF+kwzRCfWRRG+BXxRxbgpU6ZWkGhpghvpxuNrylTuiow7OI7xQ7gD3Wopb198IJXw6zyldfqHYzGI2TQ1YHUvYaoX8VPv60AYfgOSDOPblhhGyZUmf0tGclV7VMH5lj1A5bcTjogQU68UOQ/soMLWpN5JFsYtfVotOQHt4B2yn94CR8WLfD8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F80bt9ZNg7rv/UsKr4rY67TbizsTXhhNB8f0+Br5S6E=;
 b=NsyEZGSWtAM7dbs6J6fxIG/Jbx0hHgZCQZCIYGUtCX4nMjsElaA650ymwkZgjb1ALFjB3mt+0T6lq7faq4DifOJT0ec6T5QlZyY+dK+UQmnoLWBrDn3ydYfzKcDeUbV2gSnkCp4/hQCLmsUPeYCxBt6o71Ql9CxgppWBFjCA6b7G4aF1iq7Gn7akXM+crQsa5CT+R3BPEoaT7v0s3fEV/CSsKDbk2esYJRxjIQgjrCniCHaFIPlxX6XAWaC9r8Yqry8VlKT2pORq1UMn9JtTD5aPB5TpHck52cvA7DrGnbv50XvDsrK9vTD2fP9sd6rA1jRUne7dwcHG4fWGG30RFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 25 Jan
 2022 17:15:22 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 17:15:21 +0000
Message-ID: <4705cb4d-e1e7-cd95-4119-0d27255168b0@intel.com>
Date:   Tue, 25 Jan 2022 09:15:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2] selftests/resctrl: Print a message if the result of
 MBM&CMT tests is failed when Intel Sub-NUMA is enabled
Content-Language: en-US
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20211213100321.181408-1-tan.shaopeng@jp.fujitsu.com>
 <b05d487e-bb8b-56df-8304-6e91323e9d83@intel.com>
 <TYAPR01MB633065A420048BC4A2161ADB8B5B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB633065A420048BC4A2161ADB8B5B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR12CA0071.namprd12.prod.outlook.com
 (2603:10b6:300:103::33) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b340845-30ab-4410-3565-08d9e0264481
X-MS-TrafficTypeDiagnostic: SA2PR11MB5212:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA2PR11MB521296009D138716C512980BF85F9@SA2PR11MB5212.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTzaXk6obszPt+QWy7e2BWnFKB/Aa1Xmapd/aqf+XZZhUQmNDD3koTYYOV3zyZ4NGJV9PlRzifsJpUtpSSUcifZ4UXBwfs88Y214VfcVfKULVl5wVss8sGZaJENsl6Mmc1vI90YWO8bdyP0Ga5xSF7Hw0xUFP/CQn3CAUEtxqy9XqzyskYq3+doMZzfVUhJFg/ygzNQKIs1pMJf9toMiTNFko3PNe3+ucvNeHMmuCEcELF+tc/coSoWw8sQ3ZIpbbtEl5cyIEhFm5yzFhnvAJ2sjfEXvlDWIz14u/zOMugeuGFau6ooqttmmx/u00NuLJmCe8PSb6VjAbovN4Gum4NPNx+XOdBSqR/xD4LjWOxAcu9uijAUG6FVhbx1Mo48psPjlYXf6gjeOAtFYyQWDFe0IVS6nZt9K9cEcojVWMd5noV27GGDa51oMp42NcK+pscPxfguFRhyZoISxFY/tNAmhkpavnBE87h8/YEjg3YLyQP0CJKNqhV7cfeYt5tnYES/Bydekxs9Ozz27+4KOT80bYtBkjAxXHDDNl4rID+VRY2ArBJHhW3lTyRsYBovmvGy+JtXgJZPp6OeGL201g9/ix3AsRxFrDPAVsabWYtEZ5fgN2gCgJiNufkS5u7Cr929HvJgYymiCUe4+Wseq9zyWdQifCVVivU/7EicIjVDokVOgQQ/mGMXAKgPz6b9pw7fEN2W63LPavSgFYoUkzYOJuaF/vaq3mHsd2Odggts=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(2906002)(110136005)(508600001)(316002)(36756003)(15650500001)(6486002)(2616005)(86362001)(5660300002)(54906003)(6512007)(4326008)(8676002)(66476007)(44832011)(31686004)(53546011)(6506007)(82960400001)(6666004)(26005)(83380400001)(31696002)(38100700002)(66556008)(66946007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmF2MXdRN2ptaFBpU0c5VEJRSHNLSU05RXNQbUMzTlQwNVQ0eHc0OUY2eVAx?=
 =?utf-8?B?MXR2QzQ5VXUrRE9ZZWZuTHJlYSsxUjQyMVNPVlBudEQrM0l1VHZkcjBia0FJ?=
 =?utf-8?B?RkNsOXl0NSt1UWlJUmN1WXQ3K3RydW1VR0VEckU4VHhYK3ZPcEpSN3VqRWpu?=
 =?utf-8?B?U1BRTnpGUGQ5dmlqNkNXZ3kzdHQydHBHbGQzYXA3QWJ0Q09sSEl3NFRFbWpq?=
 =?utf-8?B?eHFHS0RmY2tzQ2djNjlmS2pLSUh4b1FyKy82dEZtUjdxbnB2dHd3RGZrRE5D?=
 =?utf-8?B?QytRc3VKVUdTS0ZUYytldWtDdjFRQTFTNXdqaHVFbU5VMHBVdE1Gd2c1SE84?=
 =?utf-8?B?N1N0MkRXaGtPWlRLd1VYQ0QxZFpYUm5FWEhEVnJCeEJMYjBSeERIb2hKOSt3?=
 =?utf-8?B?TG93Rm4rclJUeS9XekM4UmRXdk5KdmNKbE94cmwyZkdTU2VDMVNQeTN5VkVK?=
 =?utf-8?B?M3J6WkpBSHBGWFl6NEFCdGJKc0NNS1g1WlJ4dHF0bFdLaXFpcjhYQWxYU2Rj?=
 =?utf-8?B?ZEJHc2h3blROTVJmZlBKaUdwRDdGVFUxS3ZzOWZaL2VjQXZoM3lpcDVWRC9E?=
 =?utf-8?B?UXd4UnYzVG42SFNnTHA5VGNnMGNZWWYwQzNXZGtObEpUZnAvdnlRL3RsRXlH?=
 =?utf-8?B?ejJXcTNCNnllNlQ3NUNMY0hWeC9LRFJWaXZOdVIwMm9UcmhRdFQyVjk4UWxh?=
 =?utf-8?B?TjFlRzJ5bnlZRXZaZm5lTE9uWC9FT1A1SDNPU1FMc3RibzJwZHp3Qk91aXN1?=
 =?utf-8?B?OVhiRldWbllHdHJRQ2VDUDdWWWVmK2Q2VzZUS1FRaFNhMHppWEN3RU13WDlj?=
 =?utf-8?B?TEJ0N05NZ3NoZC9YY216RUtMVVQ4cUZGZzZvK2dDejhNZXlVT3NmRGV1L3E0?=
 =?utf-8?B?V3d1V1NtcENjZVdSNFVSSVg3aDVVTXdLcFJnSVNsQlQ2LzduL29OaWpicTBk?=
 =?utf-8?B?dFB4TTh4ZWlweVdBT0JWajlJV1dYYldiWE9BUHdHaDBtWllLZUErN2VWRHBk?=
 =?utf-8?B?OUptZm9TbjJJUm9tZWJCcnBDNWdwbyt4b1hKRHQ5NnpySW5jd2c3ODVVTzBt?=
 =?utf-8?B?RFRtdEV3RUNEZklZSHhtYXJkcUhjc3V1U2NRN1J2SHc2b0NweHU1MVdRV1dX?=
 =?utf-8?B?M2MxYkdLNk9mU1NzejJhb05vdVJNK1Exa3Z0NnUxN3BTS3ZsU2I0Ry9TRlo5?=
 =?utf-8?B?LzZhODJjTXJLS2RDMzBMVWk0R3dadUNyTlhmUkpobnNJeElzMk5GRkJDTVMz?=
 =?utf-8?B?Mjh5Z1JTQUVSdzArTzlJd282c0RMaC92L2hSY2kwT09LQTdJOGRUWlpUYXY4?=
 =?utf-8?B?LzhjV2tYUCtpZktFRUNzREJveFJDS2JtU01WLzVzbjJwZTduYTArZmEzQS9J?=
 =?utf-8?B?QXc5ZGdsUmxOTDRBeTEvNkdSZWRqZFlBN1A4ZEQrbURjN1cvOWVuU3JzNWsx?=
 =?utf-8?B?RkdRZ1dnbUtPMlQ3aVZyWXMyN2k3b0RxZGdDSDllam9aQ1VyVlpGWHdkMUpQ?=
 =?utf-8?B?QXZ3NzM5TFcvaG4zN1VsWXNocklORnNrd2hkcEl3dWhkaHFIVkhIa05hUFZq?=
 =?utf-8?B?UDJIUmRWZndGZ2JXb3lYVG9rM1dxY2FuVlJ3Ukt4ZTduOE8yc1BQU1VvZTMv?=
 =?utf-8?B?OHdDeFBxRkt2T0hsdHNJS1ZYOHpsejVaQ0thWWRvS1l4RnkzMVY5YmNid3M0?=
 =?utf-8?B?NjFGVkQrb09OM2ZYZnpObnkzdzc1NS9vUklWSEFVdHdiSjBWeTFaNTMzSXp2?=
 =?utf-8?B?aEpGeVhydndGdzBnbjFUYzhHVDZ4Rk9WYnRrYnFudDZENldZTlJnNjQ4Zkx2?=
 =?utf-8?B?UXZYQ25objZXakFQL21BQ0tqWFBvcStydENSRTFYNlhLeHRiSkNYSzJhTThm?=
 =?utf-8?B?Z3pReUdmb3dpdnFualZQNndQZHdSS1BXQitKMEpPMTBRN2lYN1pTb1crMWxz?=
 =?utf-8?B?Y2toWjhrMys0NW5JR2ZHU1h3Yllva1pKY1Zmdm1UemNhdXJ5d0Y1cWh5YjdL?=
 =?utf-8?B?Ny8wNWdNMDU3cUc2ZFFGSUtpZmFHS0x6U0FUblgzL1JZR0lmQnR1dUpXbmRQ?=
 =?utf-8?B?Y25UaGlkaEJkNnVza3BqaDE2bHdpWFIyTk5JcFhYckVqQXdETWMrcHgrVlln?=
 =?utf-8?B?VmE5TjUwVXBqZVZnMngzbk04ZEYxQjFUcjJDN0hieGxVaFljYmJVS3NuVm1C?=
 =?utf-8?B?SStoUTdvSmZuakhMdlR2UjY1ajE1NUVONWZRUTNVcllIQmJlL0YyZ3BtcjhF?=
 =?utf-8?B?Z0NjejdCbXZGeFJ5OHVMM1BlM05RPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b340845-30ab-4410-3565-08d9e0264481
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 17:15:21.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4hXGSulBf+wEzvHSgOZ3OZ92XaT65Zs/aD1C/gevcLDEe3VjyZWjGuforrFkQi5oz8G1NNoyE+DrG4kBqr95QgLXwFYX2YnTcvuuoBqYqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Tan Shaopeng,

On 1/21/2022 12:00 AM, tan.shaopeng@fujitsu.com wrote:
> Hi Reinette,
> 
>> On 12/13/2021 2:03 AM, Shaopeng Tan wrote:
>>> If the result of MBM&CMT tests is failed when Intel Sub-NUMA is
>>> enabled, print a possible causes of failure.
>>> Since when the Intel Sub-NUMA Clustering(SNC) feature is enabled, the
>>> CMT and MBM counters may not be accurate.
>>>
>>> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>>> ---
>>> Hello,
>>>
>>> According to the Intel RDT reference Manual, when the sub-numa
>>> clustering feature is enabled, the CMT and MBM counters may not be
>>> accurate.
>>> When running CMT tests and MBM tests on 2nd Generation Intel Xeon
>>> Scalable Processor, the result may be "not ok".
>>> If result of MBM&CMT tests is failed when Intel Sub-NUMA is enabled,
>>> fix it to print a possible cause of failure, instead of SKIP these
>>> tests in v1.
>>>
>>> Thanks,
>>>
>>>  tools/testing/selftests/resctrl/Makefile      |  1 +
>>>  tools/testing/selftests/resctrl/cmt_test.c    |  5 ++-
>>>  tools/testing/selftests/resctrl/mbm_test.c    |  5 ++-
>>>  tools/testing/selftests/resctrl/resctrl.h     |  2 ++
>>>  .../testing/selftests/resctrl/resctrl_tests.c | 36
>> +++++++++++++++++++
>>>  tools/testing/selftests/resctrl/resctrlfs.c   | 26 ++++++++++++++
>>>  6 files changed, 73 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/Makefile
>>> b/tools/testing/selftests/resctrl/Makefile
>>> index adfd92145e12..6d257f40e6ac 100644
>>> --- a/tools/testing/selftests/resctrl/Makefile
>>> +++ b/tools/testing/selftests/resctrl/Makefile
>>> @@ -1,6 +1,7 @@
>>>  #SPDX-License-Identifier: GPL-2.0
>>>
>>>  CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
>>> +LDLIBS += -lnuma
>>>
>>>  TEST_GEN_PROGS := resctrl_tests
>>>  EXTRA_SOURCES := $(wildcard *.c)
>>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c
>>> b/tools/testing/selftests/resctrl/cmt_test.c
>>> index 8968e36db99d..c5a49444c5a0 100644
>>> --- a/tools/testing/selftests/resctrl/cmt_test.c
>>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
>>> @@ -136,8 +136,11 @@ int cmt_resctrl_val(int cpu_no, int n, char
>> **benchmark_cmd)
>>>  		return ret;
>>>
>>>  	ret = check_results(&param, n);
>>> -	if (ret)
>>> +	if (ret) {
>>> +		if (sub_numa_cluster_enable)
>>> +			ksft_print_msg("Sub-NUMA Clustering(SNC) feature
>> is enabled, the
>>> +CMT counters may not be accurate.\n");
>>>  		return ret;
>>> +	}
>>>
>>>  	cmt_test_cleanup();
>>>
>>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c
>>> b/tools/testing/selftests/resctrl/mbm_test.c
>>> index 8392e5c55ed0..7dc1bdf2d0b8 100644
>>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>>> @@ -136,8 +136,11 @@ int mbm_bw_change(int span, int cpu_no, char
>> *bw_report, char **benchmark_cmd)
>>>  		return ret;
>>>
>>>  	ret = check_results(span);
>>> -	if (ret)
>>> +	if (ret) {
>>> +		if (sub_numa_cluster_enable)
>>> +			ksft_print_msg("Sub-NUMA Clustering(SNC) feature
>> is enabled, the
>>> +MBM counters may not be accurate.\n");
>>>  		return ret;
>>> +	}
>>>
>>>  	mbm_test_cleanup();
>>>
>>> diff --git a/tools/testing/selftests/resctrl/resctrl.h
>>> b/tools/testing/selftests/resctrl/resctrl.h
>>> index 1ad10c47e31d..4b8ad4fbd016 100644
>>> --- a/tools/testing/selftests/resctrl/resctrl.h
>>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>>> @@ -76,6 +76,7 @@ extern pid_t bm_pid, ppid;
>>>
>>>  extern char llc_occup_path[1024];
>>>  extern bool is_amd;
>>> +extern bool sub_numa_cluster_enable;
>>>
>>>  bool check_resctrlfs_support(void);
>>>  int filter_dmesg(void);
>>> @@ -85,6 +86,7 @@ int umount_resctrlfs(void);  int
>>> validate_bw_report_request(char *bw_report);  bool
>>> validate_resctrl_feature_request(const char *resctrl_val);  char
>>> *fgrep(FILE *inf, const char *str);
>>> +char *fgrep_last_match_line(FILE *inf, const char *str);
>>>  int taskset_benchmark(pid_t bm_pid, int cpu_no);  void
>>> run_benchmark(int signum, siginfo_t *info, void *ucontext);  int
>>> write_schemata(char *ctrlgrp, char *schemata, int cpu_no, diff --git
>>> a/tools/testing/selftests/resctrl/resctrl_tests.c
>>> b/tools/testing/selftests/resctrl/resctrl_tests.c
>>> index 3be0895c492b..bbab4a7f37ed 100644
>>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>>> @@ -8,12 +8,15 @@
>>>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>>>   *    Fenghua Yu <fenghua.yu@intel.com>
>>>   */
>>> +#include <numa.h>
>>> +#include <string.h>
>>>  #include "resctrl.h"
>>>
>>>  #define BENCHMARK_ARGS		64
>>>  #define BENCHMARK_ARG_SIZE	64
>>>
>>>  bool is_amd;
>>> +bool sub_numa_cluster_enable;
>>>
>>>  void detect_amd(void)
>>>  {
>>> @@ -34,6 +37,35 @@ void detect_amd(void)
>>>  	fclose(inf);
>>>  }
>>>
>>> +void check_sub_numa_cluster(void)
>>> +{
>>> +	FILE *inf = fopen("/proc/cpuinfo", "r");
>>> +	char *res, *s;
>>> +	int socket_num = 0;
>>> +	int numa_nodes = 0;
>>> +
>>> +	if (!inf)
>>> +		return;
>>> +
>>> +	res = fgrep_last_match_line(inf, "physical id");
>>> +
>>> +	if (res) {
>>> +		s = strpbrk(res, "1234567890");
>>> +		socket_num = atoi(s) + 1;
>>> +		free(res);
>>> +	}
>>> +	fclose(inf);
>>> +
>>> +	numa_nodes = numa_max_node() + 1;
>>> +
>>> +	/*
>>> +	 * when the Sub-NUMA Clustering(SNC) feature is enabled,
>>> +	 * the number of numa nodes is twice the number of sockets.
>>> +	 */
>>> +	if (numa_nodes == (2 * socket_num))
>>> +		sub_numa_cluster_enable = true;
>>> +}
>>
>>
>> Unfortunately there does not seem to be an architectural way to detect if SNC
>> has been enabled and the above test is fragile wrt the assumptions about the
>> topology of the system. What we need is a reliable and future-proof test but I do
>> not know what that should be.
> 
> I understand your concerns.
> At least I know SNC affects on the 2nd Generation Intel Xeon.
> So, how about just printing information when the test is running on 2nd Generation Intel Xeon?
> That is, when the result of MBM&CMT test is "not ok"
> and if running cpu model is 2nd Generation Intel Xeon, 
> then print information about the possibility of failure (SNC may be enabled).
> How about this idea?

I think that making this model specific would be hard to get right for all systems
and hard to maintain. Perhaps we could just print a generic message on failure? Something
like: "Intel CMT and MBM counters may be inaccurate when Sub-NUMA Clustering (SNC) is
enabled. Ensure SNC is disabled in the BIOS if this system supports SNC." I'd be the first
to admit that this is not ideal and would appreciate suggestions for improvement. Unfortunately
we seem to lack a reliable and future proof way to detect if SNC is enabled but I do look
forward to being corrected.

Reinette

> Or, do you think we should drop this patch at all?
> 
> Best regards,
> Tan Shaopeng
