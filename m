Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8160879F35E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 22:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjIMU7h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 16:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjIMU7g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 16:59:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E0A1999;
        Wed, 13 Sep 2023 13:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694638772; x=1726174772;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fruEsGAgCmcF4MlOS/I6nrNd+N/OiQ3f13+JecBoGJo=;
  b=HjsJCx4gECRXwvrCy+xc3peNnAJwteDMBs6wth6iLC0C/M0UhEC5VLIW
   DZ31S/qhMSAJt2kyN3XxCtcmXIxhWGVaFFaRMoZ6FNNnu+TPottpfqWtJ
   tJKgJFQUkiCJVD/DR5ALNWkV27EpYzf8reTJjwBNiQROhxeY0c55KcyRV
   Gbs01hwiB3z8m70aisaVR5h8FMWcGmWif3aGHAJzopb4DQpv4Wdi609Uu
   CuZsuA0wFtHZQe88N3uyarNXTWB1UUeBD8EVLEiCSSORy73cgH5D5m7jX
   ayOwk0Y5QPD9JFvLFYnQKkv4GCpJCP6P7sutD7QxG9ZK2ULsMZyjgBDGL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378707764"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="378707764"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 13:59:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="867962687"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="867962687"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 13:59:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 13:59:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 13:59:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 13:59:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4MCluWlm3NZcgALO35VTKkwe1oMIdn3EPWJaf97onNQOZ1Wktn2/u/iEDtcR3T/r4pMwkfpcmq4k3JpiGjiJVa8VA+YfY/SPnHl9mwOM3xDsouRyQzoveGb0b3P7DR38o9xG/CT6d6ZHBY+8RuCYPFiEHy7KYhTHMWRZVyCxw1yQQn+EQVNeVII8ecxEhGwFf1yONVfG8Rd/xTK6AmPTvL+APv7OwwJjPpgBJDarBGKyKerPzo6nKvNMQus0YL6C983Lv/KqCOi4qCDfS6OcMaAO6jRATCG4rLYBc3/7E5LnrVESkJ/vR9BPQ3yYGHCXG49fNpF2y3rVjwRIWoukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmgjgU85fZvLBt8uqGZeqvjlIVVIKcwvj8Z2Kj+DeCU=;
 b=ni6mqWE5Y/MfWvoRNSP1WQNAq4bJgDJtLKfvKOsHhI2S03sqfEI70qx5epopvelOpieIMYA9/krnM1ku06p8FTD6P/Fv3ZE6zF3W1xZcLHZ0CorPFLIwSXbwkgpxP+giub7SlzTajndj5jBujnYgvZxiQ0OJ8XojdfXWZPepJjYHcTO1/HlJI3ZXHkMTArgdwW7Vr+AiEXLlpf0tj5q3epZlqoM/Li1dpuTH/6Kp3p30Eo2AdvxeoghGIRddQfvtKgXLQ87E90J+h24mvHlhrbkpBYOths5G50SYVPaStrPWMcxL1SS1Uv8RL+wLXYyCTiATStF0g6lZseWvwL2ThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7811.namprd11.prod.outlook.com (2603:10b6:208:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Wed, 13 Sep
 2023 20:59:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 20:59:28 +0000
Message-ID: <8eb32195-102b-cbf5-3ea0-88550cc81de6@intel.com>
Date:   Wed, 13 Sep 2023 13:59:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 3/5] selftests/resctrl: Refactor feature check to use
 resource and feature name
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
 <20230911111930.16088-4-ilpo.jarvinen@linux.intel.com>
 <b5a36b8a-c5c7-84a9-270e-bef4478d4bff@intel.com>
 <eac7deb6-3593-7a59-7df8-208392254f7@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <eac7deb6-3593-7a59-7df8-208392254f7@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWH0EPF00056D06.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf085a5-dd76-4b06-8615-08dbb49c5198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JHhqtw96N3QPADek1VeUDAK8cQp6+1b7IkzVPXJwY/Zn4NL7Tb57ypF3q0qw/lXrhPb2fprm9oFbzjAIwhtOBlmjt6xjP+lKp7EPSPlN2FWdeQBjkZ+VbURYuCNmPc5G1npFcU8D/99Q5Idnwp2fgdsO7b8gtP5lek9p9nLHQF6UlsFyTxnOh7cRU2PQ71ivUaIstamwdxsM+8B6dcQNMFOrXLqG+pm7Os9Dncatr6B5A0/ltMo5RaMGRoZJgPoDZzuyg3qpFkDb6y+zFKRWJkVnyXBV5XqCryBDuyb2u1QpT6XmIU/TJPeX0xyQekJsLFPrEwWipx0V/Foyrf+7Y40Cgdkc8S0pjTtgGI4AYiaeF5flsM/2LKz6WQI6TTWF8zKgu62AG4L/4fxMx9/83hmVXr+YMOf2JkEn320BbaBqh4iQrBi2oQYNBZWW/wFl+OqI4xOqLiPf272t9CR9WU3GMDMrX/kSZ7id5MYvvoyEXIg8qFd7JJoSmP3O5wXDlUNF6ChIH44wpNjradBqT+q7DI8l+dUPWrO4Zto/SVqDTNoNIqZ5XuOFIIApylLKGe4dPjb05e+pATSHL/Xb7COVf5GRwkBRJ3MdIvZiNReBUSeZGCZNNYfLsA+IpbaVQMRey82+H778kvPYHlJylWy1u2Ka2A2vTUXt3NMRxFk9bokCDy51+lnDepYjbsq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(4326008)(66946007)(66556008)(66476007)(8936002)(8676002)(478600001)(2616005)(82960400001)(41300700001)(316002)(6916009)(6506007)(53546011)(6486002)(6512007)(54906003)(83380400001)(5660300002)(26005)(44832011)(31686004)(66574015)(2906002)(86362001)(31696002)(36756003)(38100700002)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SiswZU51S2ZaQ2s1MXNNVmh5aVdQM1U4Q0ZFdHowUy8xMXVLQy9NOEswQndu?=
 =?utf-8?B?UDhYNTcwUE13UGViN3BXRUVmOWJYWTMvc0FCS2tTWm9SN0ViRXV5Uk5WZ200?=
 =?utf-8?B?UEd4RDNaYWsyTzl1ZUdIWFRFVkp2U1YwL0Z1WVh1amErdFp2Wld5UDNjUFdV?=
 =?utf-8?B?RHJrVFg1SHg1SDdXdzY0aFR6ZGNzVkxzYmJzSkJGYzZuWGw5bktEQTkxOHRN?=
 =?utf-8?B?TC9DY3RSRkhqT1ZCMDVPR3czL3M0QVc1R2svVXhPT1NyYjRDenV2M2VneS9l?=
 =?utf-8?B?c1pDVWZ4OUJKd2IvM2Y1eEF0OTRGTWxlMU9iN0JlWXBzZnJBZkxuQzY1eVFY?=
 =?utf-8?B?M21wbGErYS9paUY5SlV5a3l3MldEcnMxQUVMVDBsS1hRdkpsU05VS0gvTVJR?=
 =?utf-8?B?ei9TandSMTBhcDZSS3drS2VlUWVnSy9aSmE5c0xzdGFxeVhFYU5IL3dMaVZK?=
 =?utf-8?B?cmI1SEY3UVRIZ2t0d3VzamVPbHNWanNNclZtb243QnRDVk1Da1JTdlNvaVNo?=
 =?utf-8?B?QUNGb2p2TWhqL3BKWjR0MjduTGk3bTRGRkp5cWlIbDR6QTdtampsVXZvV05V?=
 =?utf-8?B?SC9qc2IweHJYVm9Ob2pVTFJFODZhenFkUWZwVmtKbENXUkJKSjlKbXlnVVFr?=
 =?utf-8?B?Z3pVZklkTkFwSitOUnZpMjZqTFVseEpweWdzZHczc3FFYWRFNWNrL3NESmkw?=
 =?utf-8?B?N1NVa1N0S2NqYTBUdkFuN0NsK3VPaFhPM1BYZVF5eHNheHdiNTdhUW9LcXhH?=
 =?utf-8?B?LzJ4YVk2Ni9ZK0c1OEZ5dDI3OHU2MzhlbzVmdFVBT0prQmRXd1pPVTErTzZY?=
 =?utf-8?B?bHd6UjBwRUlMdzVUdFZKRFRtUXp0aHFBRGVaZ1dpR2Y5SkJUdDlXN2t6Tndr?=
 =?utf-8?B?SXpkOVRXMDl1TlVBNndmTkQzVTZZdEZBL2pLOTliMXJZWUNTWUVrWTRSektH?=
 =?utf-8?B?SDcrWmtscGtjcVV3bjJOOGlqL1hpcExrV21QbFVUSG92R012ZnN3WTBUTm0v?=
 =?utf-8?B?Tm9CT2kzTXlrajNkQk1GaExjWmI3eW1yRW9mS1RCcisxYjVXQzFOa3JzYVZX?=
 =?utf-8?B?b0twQVdua05JUmFEVjVBRkZUUHllY1dTRGhwKy9WekljQlFMYUdOdWdyUVFT?=
 =?utf-8?B?UTVUZzE2ODRzK1EwQWFpWS9RYjE1cWxIeHR3Rm9OaGtaOWY2ZzdtNmtaQXlZ?=
 =?utf-8?B?TTEwMGFXV0pzS3NtNEZWYmlwSXpRTE9oQXcyRVMzNzFJTDZBeDY2UnFQWXpP?=
 =?utf-8?B?TmZ3dXhiSzVBcGMvb0N1dHc1VnNpemd0dzNpc3hvWW04ZjJRclEyRkxFRFdK?=
 =?utf-8?B?dVlEWHR3NWNTNk9SNHFRWm1DeTBCSm1ZQ04weG40QWIyMzdkU1VaZXFjUDlP?=
 =?utf-8?B?djJySjdnRFJHSXJuMjJaZE5mOHpkQU1nSHlhMGNlSDNwbDU2aWhKenl3VjNJ?=
 =?utf-8?B?dS9UYVlDNC9xUjJMUzArOWtYKzl4aWo2TXlkL1lmcm81NmZjQ0IxeitWdm1Q?=
 =?utf-8?B?NzF3SlFUZ0RzUE1XZy9PSElNZ1JSbXVZVS9yMnJBZ2NmNEZkQkhsNDdLZytS?=
 =?utf-8?B?VWJZVWxDSVpDNG42S1NpSmJiYlp4c2F3c2hJQzZ1VGtiYW9TTkNYL2JzR2Y0?=
 =?utf-8?B?V1pRbHAwRmVtWVc2cFdueTdUY1pibFkreDZ5d2NyUzY5QVFLb090RVdtQlJI?=
 =?utf-8?B?MzA3eXJUdXhvT1VEYzVGajViWnppLzR5QVZMNVlHQUxsOFdleklmYVdiRjcr?=
 =?utf-8?B?OWJVeXVITHdqc0FBN1owb3ZJZDRBQjRnZFNHK0t3NDFQRFlBRFZ4MEZOUTcy?=
 =?utf-8?B?UTZBZW5wVmdQNEtzV3JFakpKa2Q3TENtMWJWWHhQdnFiMmhxRGw2TXE2VGZX?=
 =?utf-8?B?b2o0SEgvRkxxc3YvNW1BcHlCWU9Jd3kvcUs1REZjZS96Nzc1WWtyNmxodnQ0?=
 =?utf-8?B?NjVXWndSa1IzRzhVemE2ZWw0YU1KYTJwakxtRmx3NXVuSWJpRFlDSTc0bGkr?=
 =?utf-8?B?VVMwamVrOVNKSFZBYVkrbUQxY1V4dkwvYTN0U1VCa3gyQmYzeDZWcmFnbFo1?=
 =?utf-8?B?OWpRakhzTlFDOWVaM3p4ZEkvN2RIOGZLb251RGRhNkI2R0ZUalhoTmlKczFE?=
 =?utf-8?B?dU9jVjJLcEJDMUl5d3lXdmVsZEY3eXVNRVV4K0pZMVB5eHFabWxmRmMwTkdR?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf085a5-dd76-4b06-8615-08dbb49c5198
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 20:59:28.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbZ6z6wpGA7F51TYILg1u2nfVxrLWsiepUCEMwXwocTkXudSOogBXnmmCYddSN/CxhfcdqQcgVo4FJCKxhfxESVufAtrNYdhUbQCpNsLjbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7811
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/13/2023 4:02 AM, Ilpo Järvinen wrote:
> On Tue, 12 Sep 2023, Reinette Chatre wrote:
>> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
>>> Feature check in validate_resctrl_feature_request() takes in the test
>>> name string and maps that to what to check per test.
>>>
>>> Pass resource and feature names to validate_resctrl_feature_request()
>>> directly rather than deriving them from the test name inside the
>>> function which makes the feature check easier to extend for new test
>>> cases.
>>>
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> Cc: <stable@vger.kernel.org>
>>
>> This does not seem to be stable material.
> 
> Alone it isn't, but both 2/5 and this 3/5 are prerequisites for 4/5 as 
> shown by the tags there.
> 
>>> ---
>>>  tools/testing/selftests/resctrl/resctrl.h     |  6 +-
>>>  .../testing/selftests/resctrl/resctrl_tests.c | 10 +--
>>>  tools/testing/selftests/resctrl/resctrlfs.c   | 69 ++++++++-----------
>>>  3 files changed, 34 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>>> index dd07463cdf48..89ced4152933 100644
>>> --- a/tools/testing/selftests/resctrl/resctrl.h
>>> +++ b/tools/testing/selftests/resctrl/resctrl.h
> 
>>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>>> index bd36ee206602..bd547a10791c 100644
>>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>>> @@ -10,6 +10,8 @@
>>>   */
>>>  #include "resctrl.h"
>>>  
>>> +#include <limits.h>
>>> +
>>
>> Could you please include <limits.h> before the local resctrl.h?
> 
> Believe me I tried that first but it did not work. So this intentionally 
> in the current order as resctrl.h defines _GNU_SOURCE which is among 
> things that tends to alter many things. If I reorder them, the build gives 
> me these issues:
> 
> resctrlfs.c: In function ‘taskset_benchmark’:
> resctrlfs.c:284:2: warning: implicit declaration of function ‘CPU_ZERO’; 
> did you mean ‘FP_ZERO’? [-Wimplicit-function-declaration]
>   284 |  CPU_ZERO(&my_set);
>       |  ^~~~~~~~
>       |  FP_ZERO
> resctrlfs.c:285:2: warning: implicit declaration of function ‘CPU_SET’ 
> [-Wimplicit-function-declaration]
>   285 |  CPU_SET(cpu_no, &my_set);
>       |  ^~~~~~~
> resctrlfs.c:287:6: warning: implicit declaration of function 
> ‘sched_setaffinity’ [-Wimplicit-function-declaration]
>   287 |  if (sched_setaffinity(bm_pid, sizeof(cpu_set_t), &my_set)) {
>       |      ^~~~~~~~~~~~~~~~~
> 
> It might be useful to move _GNU_SOURCE define into Makefile though to 
> avoid these kind of issues (but that's not material for this patch).

How about a #define _GNU_SOURCE in this file as an intermediate step?
I did see your patch making this change but cannot see how it is
coordinated with fixing the include order in this file.

> 
>>>  static int find_resctrl_mount(char *buffer)
>>>  {
>>>  	FILE *mounts;
>>> @@ -604,63 +606,46 @@ char *fgrep(FILE *inf, const char *str)
>>>  
>>>  /*
>>>   * validate_resctrl_feature_request - Check if requested feature is valid.
>>> - * @resctrl_val:	Requested feature
>>> + * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)
>>> + * @feature:	Feature to be checked under resource (can be NULL). This path
>>> + *		is relative to the resource path.
>>
>> I do not think "this path" is accurate. @feature is not a path but an entry
>> within the mon_features file.
> 
> Yes, agreed.
> 
>> Also please note that mon_features only exists for L3_MON, none of the other
>> listed resources have an associated mon_features file in resctrl. This
>> function is created to be generic has specific requirements on what
>> valid (never checked) parameters should be. This may be ok with the usage
>> but it should not pretend to be generic.
> 
> So are you recommending I split this function into two where the new one 
> would do the mon_features check?

No need to split the function. That seems overkill considering its
captive usage. I think a snippet making its usage clear will be helpful.
Something like:

	@feature: <description>. Can only be set for L3_MON. Must be
		  NULL for all other resources.

Please feel free to improve.


> 
>>>  	char *res;
>>>  	FILE *inf;
>>>  	int ret;
>>>  
>>> -	if (!resctrl_val)
>>> +	if (!resource)
>>>  		return false;
>>>  
>>>  	ret = find_resctrl_mount(NULL);
>>>  	if (ret)
>>>  		return false;
>>>  
>>> -	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
>>> -		if (!stat(L3_PATH, &statbuf))
>>> -			return true;
>>> -	} else if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
>>> -		if (!stat(MB_PATH, &statbuf))
>>> -			return true;
>>> -	} else if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
>>> -		   !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
>>> -		if (!stat(L3_MON_PATH, &statbuf)) {
>>> -			inf = fopen(L3_MON_FEATURES_PATH, "r");
>>> -			if (!inf)
>>> -				return false;
>>> -
>>> -			if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
>>> -				res = fgrep(inf, "llc_occupancy");
>>> -				if (res) {
>>> -					found = true;
>>> -					free(res);
>>> -				}
>>> -			}
>>> -
>>> -			if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
>>> -				res = fgrep(inf, "mbm_total_bytes");
>>> -				if (res) {
>>> -					free(res);
>>> -					res = fgrep(inf, "mbm_local_bytes");
>>> -					if (res) {
>>> -						found = true;
>>> -						free(res);
>>> -					}
>>> -				}
>>> -			}
>>> -			fclose(inf);
>>> -		}
>>> -	}
>>> +	snprintf(res_path, sizeof(res_path), "%s/%s", INFO_PATH, resource);
>>> +
>>> +	if (stat(res_path, &statbuf))
>>> +		return false;
>>> +
>>> +	if (!feature)
>>> +		return true;
>>> +
>>> +	snprintf(res_path, sizeof(res_path), "%s/%s/mon_features", INFO_PATH, resource);
>>> +	inf = fopen(res_path, "r");
>>> +	if (!inf)
>>> +		return false;
>>> +
>>> +	res = fgrep(inf, feature);
>>> +	free(res);
>>> +	fclose(inf);
>>>  
>>> -	return found;
>>> +	return res;
>>
>> This is unexpected. Function should return bool but instead returns a char * that
>> has been freed?
> 
> Okay, I understand it looks confusing when relying on implicit conversion 
> to boolean (despite being functionally correct).
> 
> I can do this instead to make it more obvious the intention is to convert 
> the result to boolean and not return a pointer:
> 	return !!res;
> 

Looks good to me. 

Reinette
