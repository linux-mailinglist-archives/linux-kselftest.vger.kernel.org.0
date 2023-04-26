Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F2E6EFE0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 01:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbjDZXff (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 19:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242559AbjDZXfa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 19:35:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2435C10D;
        Wed, 26 Apr 2023 16:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682552125; x=1714088125;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xe5tSSreKKOtQY8Pr5n2k9/knawkTpC1tubzlIZvd6w=;
  b=RPCc70cxM6LwzFHMuMHsnocFh0+xn9GvIhh3aXBDxdStyCoalq0cRPgK
   YMEVMqPMRmmUrU+a519JPrf8y5iKT1qEDdeMl6raPROFOrKU48JEKLx2x
   RIkwViy1QOk77F73bJWHR6jruC4BmrwsN3md1f0cN+28kUrY2qi6C1nd/
   QVdrA3lqiWZvFfGAoNMzsfk5M2KD/Xcuzug3jOw+QTwh7I/599sfRmWCk
   +l3KXvcN4KI3LNXAzYHPRl0a6qE1V6XDGz5NJgHzHShZRmsT3Cm8JXUVf
   6IjeKaRASediwna9AQ8GT2nRGarVqGPVsO0e6bPkaXjcuHtNU23F127UZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="349214010"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="349214010"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 16:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="783507432"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="783507432"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Apr 2023 16:35:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 16:35:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 16:35:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 16:35:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 16:35:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEqwR5MPIC/haBsY2uct0i9BpDmG5upA2fawR4D53c6cqRUXbVUDhgcZadglP9NmCwRRKxYZ19yryy59/qeKe+yhVm5/Kxxw2Rbs6BoY1/1TimvCRkG3d4SU/9mF3yurmmLL3BKQmYjxZvXoJA77u4oN7AY4V1tee+4Ha5mkR7Gzhh4wmZVcQbJfXzOHO2kag/t02BkklcEwn/e5RwUwzzJkcjRr9VIEgeEa7Wm1s0T2VRVoY+pmwD69JmzM7e7gxNS3QdPW7KkbKJ04ngrmcLy03WMaV9CaFymVwe4Ly3cEo6HUj90elZK/2vq8MrGFXb8SwcVq3z6FEXKULijBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+l4XLeuJaobxODBvuR11DeWcxePnbQrzwvi1yugYuk=;
 b=mAhU5o61snIYqjk9QWjGebus3czsEJ28O/eiQFYzrlKJvhk5FtYEWEsUnnBACYYCjIbeWPG9y85BnMgDIj6XlPd3iRLdM+rx6Nu+uHmWWI12PKoffWhihdsYa53emqjgJCYk14EPP3NBnb+OtjDEO9Fks45w0L8CVlqSXGpToF7GW1WJeilkY6yEyTRLj8/XTdqoD5RFtFo5QHtJ40oK2UI6ZAlZR5CSPRmEONPJXL/1L1XjqnQjm71C+XWWWM9IxPpQSnZuTuRjsGIpxWOipnSIiRStUmOpFVP8PJGoX1hy1Y9Cfz70/Lm9HDYi+/sgl/0T7JBCmZseUFr979a6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4818.namprd11.prod.outlook.com (2603:10b6:303:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 23:35:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6319.020; Wed, 26 Apr 2023
 23:35:18 +0000
Message-ID: <ff2b3b61-57d2-04da-a719-c72d8bfd49eb@intel.com>
Date:   Wed, 26 Apr 2023 16:35:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 24/24] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-25-ilpo.jarvinen@linux.intel.com>
 <eac72c7b-bd01-084e-cf23-ec5e8e0e3cf3@intel.com>
 <b2f72637-5c16-d25b-8a0-3fee4ca9ec7e@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b2f72637-5c16-d25b-8a0-3fee4ca9ec7e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: 597a34e3-d5e7-4284-10be-08db46aee4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6GWIXPtQDyCWaPuE0r1EVc3WuVKupVngmgGCy1iwMcYvPIARbPNs2hqNHLJr1MKB6oedmiAoF6+CbE86inse50GLrzzCPZYOo/LbzpbGArZPJBjiTIcaoQK1ZgPoXEoAgcS2XOu4lhh+UbB176j+m0BVC5xJazSVIZpdmWGR9dWNrM/gBO7ZlaeHijNgf/qEpL4MXJXJxBtcAkaT5zWlthfEHvmrlE+HVr6EVvazk6X4A3iWRfxZlMN2wZo7ctRJMXaRMXomlCc8XG4/7a+BynC76VFkmHzw8e9f+pJAK1lR27BOh5NxZGsOKAw/lLMJkaWOsv7HIdC92XC2jvoxx3u5NgMawxgTzRlHx0Bp53yAY0ALkHEhixZP8Bg05KiD8iolksXfQXPHGeL7ylDaJdsFW1NeQwZyvB8WVja6dO5fPvFWcC9meCYeCcUWh4u5n40nUJvV9bfzNI2EUwtvTuotRzBXfDM6droMi+hIH9VSX3jhXdkbSXIqT/ZCLzB91niNthYPeb5T+oNDQHmkxX5pjZtICOf568+WFVSvRlJjE7JV1XEuWEu7SNcX13p/Zr8Kfx5H2i+j+IwiNAK5/lx3IiajVXazgaF+HERWZ23d74vTH23TADuRtQDvgP3ENT0V8lsmix0xJN7whnfEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(86362001)(26005)(2616005)(31686004)(53546011)(6512007)(6506007)(31696002)(38100700002)(5660300002)(186003)(66574015)(83380400001)(6486002)(6666004)(66899021)(478600001)(54906003)(36756003)(44832011)(41300700001)(8676002)(8936002)(82960400001)(66946007)(6916009)(2906002)(66556008)(4326008)(66476007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTVxRjg1TzRPbnJlekNocVhCNGpqVlkxTlRpYUxiQ2NQOUVaWG1CbDhNM0Vj?=
 =?utf-8?B?QW1lenJ0R3MrWG4rQ1E2b0tEL0kxMitoMmpkdlBSbExLSXVpdXUvbTJvVExq?=
 =?utf-8?B?WEpGQWZuY3Azd1htNy9WRVA2UVZEc0Z2cDlsK0FwTmpWTzlRSHBvNEdyelZ2?=
 =?utf-8?B?azhxdmRDTWVnMm40cGRQbm1GS3k4bit2RWlSVTI3SUtjd1pKRm5GbHFscTFH?=
 =?utf-8?B?eXd3R0h0cTM4TVdvLzBneFlOSGNzbGNVOVR3dzNnU1ZkSnhSRldiVlNNcDlJ?=
 =?utf-8?B?aVlwK0Zhbms2SERYc0R4RG55ZEg2dWpGVlM0cWFDalh5STFuRC91bmt4elU5?=
 =?utf-8?B?V3lRZGg1QngvTGFEampnTFdIVXdoSURuWkRSR1VLeFUrcGprMUhtUDRhTTE1?=
 =?utf-8?B?MmUxM042bnFXWVlWSmVMdkdwNU1kWGtQT2xqWWxzeWxVSGxQNEdTUXpNWDYx?=
 =?utf-8?B?NmdMRmhMcjJiM012RXMvcHF5TmJxR2tobU1IVmlkSlpYdHJHRW5OWjVsVVFN?=
 =?utf-8?B?WkRFY1FSREIvRWJjdHJyYnZQVE9sVEJiR1NEYXZmTXgvTkozaHA5b00vMzBk?=
 =?utf-8?B?OW5XOHNLYUovMXg3dXVBQURPTGQzSkRXMWExcGtCV1FJcTBVcUREOUdhWVcw?=
 =?utf-8?B?cEg5QlZmbWVVeUdQUjVzWTcwdkNwK1V5akZnQWtrR3J6aUdramhtV3Y5VXFl?=
 =?utf-8?B?V3BkbnVvZW80VnRWSlNpMkYwbGdaWXpOb0ZlWnBUWTl6NkExanMxWnhWUy92?=
 =?utf-8?B?aVd0SmhOODN0Z21QeUIzSXUxc2tlcWh3bFAzMi9VNkdUVUUzNDc5SnpkQkRF?=
 =?utf-8?B?ZVVxZUwxajdyUldReDFSQW1EWmxaZkVxVkNUSXFJOFplM0EzOHpNbHFGZkJk?=
 =?utf-8?B?eVdYNkFiM2lvWkdNcVZpd2pGUnBjV3kwUzlsMUt2T2ZXWDJWNkFFQ2dkTERv?=
 =?utf-8?B?K1QzZnpNT0pwa0VkdkxNUkRha1FXSmhNblZIOHVoOTJGWmpjcjdFbjRHYUd2?=
 =?utf-8?B?NDQ4M2tGVWs3K1VHaExCUEh1UWprRjhPc25BRjIwRHJMU091QWw3dzN4eDNr?=
 =?utf-8?B?bWtBT2orNlJDNVJ6K3lYd050Mm00OS9DTVJyQ01CYzUyWTd1OFllYVpQTUN4?=
 =?utf-8?B?TnhOaGpNZU5OS3hKdGdhTjliMU5UMGxWMkE2WUZWbTVXcjg4QnhMaHczbjZR?=
 =?utf-8?B?Qjh5Wi8vMFcxQ2l4cS92QVVPaVJqTWg0N0RHMlI1d2J5NzRiS2U5VFJDM3oz?=
 =?utf-8?B?a3M3a1ZoVnI4OTNQME1ORGJKbTJCb1hZQTF3MDVJais2a1pWUng1SDdzOHhr?=
 =?utf-8?B?RVdBM2c2T0NrMmlQOVVoYU9tcFc2RzRIRVpPcGYyOWhNelhYNlFmdlF3eUF4?=
 =?utf-8?B?eW4rM1NDN0NmaldCb2N4Uzlzb1YrbnRUd3B1M24wZWFGR0lZeSs2a1NKNllQ?=
 =?utf-8?B?akVOY0N0My9MWWRGT0xaSXBrb3JsWnlEU2tscG00SGVibE54VFVLQXFCRERH?=
 =?utf-8?B?MDMxOE1scmUxWWsyTXNkaFR2NnhKQzRWT1dyMVovZDlhU21sZ3hHREdLU3R4?=
 =?utf-8?B?L29wQXlEYzZLemtzY0tVdTZLbUI2RmhIRldtYTI1akpNeGdPc1F3UHhVcGRQ?=
 =?utf-8?B?NTIwMXQ3OWZTR1VvMmVlS3Vud0JFZTl3ZW4raUVBZkhaR21TVnhMakZMbjk5?=
 =?utf-8?B?RkNlMzd1Ynd1OTczV1U0SjNDT2U5aXBTdUw3ak9WelRYMVpIQkVFVysxMmVR?=
 =?utf-8?B?UUZhKy9FWE5VRVBQVHcxcng4UURZa25IeGpPc3hXRHZGOVcxOHB6bldwc0FQ?=
 =?utf-8?B?RUhyaS9JQllmTmlGWEJWcTNBSzB6cWtvenhEcGxiL2lVOEN3NEVxSVFGdm12?=
 =?utf-8?B?RUpjOGVEOUQyUVg3MkQ3OFk0eGUyM0RXQU9LS3dyU0xiRTNaaDlnQVR6a3lP?=
 =?utf-8?B?NjFVWHJ4RFBZbm5jc3phZnM0VlpvQlVhdm1VazJJQUQxZkhKSzRWeURQckg0?=
 =?utf-8?B?OWcxYVp6eEprbVk1SEp2VFNRTExaclRXNnZOdnlETUVKTTVjMHcyUjdCNEhP?=
 =?utf-8?B?U1gxKzRhaVBJcjE5ZWlKblpMZGZOMzRjU200M2prdk9JU2JDVjRHZ2ZFaVRN?=
 =?utf-8?B?QWJiUXNVMmdxVTJlZkt1V1ZjTWl1Zk5HWnhlaWF3b3kvT0FEV1UyVmxDTmdr?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 597a34e3-d5e7-4284-10be-08db46aee4d0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 23:35:18.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8FXlYzcJVUOE2BoTVdTNZUwwIGhGDue2vhOT38uekO9NViCIZku22/Ln4cr9+m5cBeHl2T8fanBSw6K0BduxF1tstt7Yv6RUQ0sNzahDIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4818
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/26/2023 6:58 AM, Ilpo Järvinen wrote:
> On Fri, 21 Apr 2023, Reinette Chatre wrote:
>> On 4/18/2023 4:45 AM, Ilpo Järvinen wrote:

...

>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>>> index 4b505fdb35d7..85053829b9c5 100644
>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>> @@ -11,11 +11,12 @@
>>>  #include "resctrl.h"
>>>  #include <unistd.h>
>>>  
>>> -#define RESULT_FILE_NAME1	"result_cat1"
>>> -#define RESULT_FILE_NAME2	"result_cat2"
>>> -#define NUM_OF_RUNS		5
>>> -#define MAX_DIFF_PERCENT	4
>>> -#define MAX_DIFF		1000000
>>> +#define RESULT_FILE_NAME		"result_cat"
>>> +#define NUM_OF_RUNS			5
>>> +#define MIN_DIFF_PERCENT_PER_BIT	2
>>
>> Could you please start a new trend that adds documentation
>> that explains what this constant means and how it was chosen?
> 
> I can try although that particular 2 was a bit handwavy that just seems to 
> work with the tests I performed.

The changelog claims that the existing CAT test does not work with
this new test offered as replacement. Considering that I do think it
is important to have confidence that this test is able to test CAT.
The words "handwave" and "seems to work" are red flags to me.
When merged, these tests will be run on a variety of platforms with
various configurations. Using test criteria based on measurements
from one particular system may work but there needs to be confidence
that the criteria maps to all systems these tests will be run on.

> 
>>> +static unsigned long current_mask;
>>> +static long prev_avg_llc_val;
>>>  
>>>  /*
>>>   * Change schemata. Write schemata to specified
>>> @@ -28,13 +29,24 @@ static int cat_setup(struct resctrl_val_param *p)
>>>  	int ret = 0;
>>>  
>>>  	/* Run NUM_OF_RUNS times */
>>> -	if (p->num_of_runs >= NUM_OF_RUNS)
>>> -		return END_OF_TESTS;
>>> +	if (p->num_of_runs >= NUM_OF_RUNS) {
>>> +		/* Remove one bit from the consecutive block */
>>> +		current_mask &= current_mask >> 1;
>>> +		if (!current_mask)
>>> +			return END_OF_TESTS;
>>> +
>>> +		p->num_of_runs = 0;
>>
>> This seems like a workaround to get the schemata to be written. It is
>> problematic since now p->num_of_runs no longer accurately reflects the
>> number of test runs.
> 
> This is already the case. MBA test works around this very same problem by 
> using a custom static variable (runs_per_allocation) which is reset to 0 
> every NUM_OF_RUNS tests and not keeping ->num_of_runs at all. If MBA test 
> would replace runs_per_allocation with use of ->num_of_runs, it would 
> match what the new CAT test does.
> 
> Nothing currently relies on ->num_of_runs counting across the different 
> "tests" that are run inside CAT and MBA tests. And I don't have anything 
> immediately around the corner that would require ->num_of_runs to count 
> total number of repetitions that were ran.
> 
> I guess it would be possible to attempt to consolidate that second layer
> MBA and the rewritten CAT tests need somehow into resctrl_val_param. But 
> IMHO that too is low-prio refactor as nothing is broken as is.

I do not think that I would use any of the other tests as reference
since all the other tests rely on the same wrapper (resctrl_val())
by providing it their own customization (via aptly named ... struct
resctrl_val_param). 
The CAT test is already unique by _not_ using resctrl_val() but its
own test. I do not see why those resctrl_val() customization need to
propagate to the CAT test if it is not using the wrapper to begin with.

> 
>> I was expecting this mask manipulation to be
>> in cat_val() so that it is clear how test works instead of part
>> of the logic handled here.
> 
> That seems to be moving into opposite direction from how things are 
> currently handled. Doing it in cat_val() would be relying less on 
> ->setup(). If that's the preferred direction, then the question becomes, 
> should CAT test do anything in ->setup() because also the schemata 
> writing could be done in directly cat_val().
> 
> What I would prefer not to do is to have a rule which says: if there's a 
> test-specific function, don't use ->setup() but do any setup directly 
> in the test-specific function but, otherwise use ->setup(). Such an
> inconsistency would make things hard to track.

The test specific function can still call a setup function but it
can be done directly instead of via "struct resctrl_val_param". The
test specific function already transitioned away from using resctrl_val(),
it is not clear to me why there should be rules about how
function pointers within "struct resctrl_val_param" should be used or
indeed why "struct resctrl_val_param" should be used at all.

Reinette
