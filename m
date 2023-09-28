Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB07B2768
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 23:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjI1VZj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 17:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjI1VZh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 17:25:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54801F3;
        Thu, 28 Sep 2023 14:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695936334; x=1727472334;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z2ENonV4eCBD2UWcPugTitfOMs9XQe7eYQ+gOv4J2SQ=;
  b=Uspnk1AZ+8Jh41JnK6v+KVNsGz0h7Ben9cPRPnhJEC+pvSyRmb2yhz/4
   71PBmdAvpeRrra+zEWvIPzWam+Lk7kEIQZjuJEGOyPZQJtRoAG1Jx6iAN
   Ufb1kUU+/33Aw+t2IMoHi2YChv/jFnkrV7LxPBh+rQWrA0kq6CgS0s8BW
   BxVv1LiQ/XKichNzYb10Z43u3/LD8Wk3rT7HjENlfyEfaWGMakPSEJVaG
   ZecWuuHtX1hKLDwPOkWnLEJLyS+kk9H1GLBzIiyyN0WXjezEkL+DLsFT4
   XLDEI/REJWEm3zhbEHms6bJVDIOEQheYxzAvT5oqrWN9F3M7ge1uFrrXr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="379451640"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="379451640"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 14:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="784875836"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="784875836"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 14:25:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 14:25:33 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 14:25:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 14:25:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 14:25:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxuUP3kbMPhpI3y8awK4Z3JNVwllAwsBOGlN4RUhEpYEysuckdRRnCjzrc3w950UTMzk58DcDzNSRCRA5RwlHYBAPJs2rB5onG+XBW5fszgi/KRJgKpzVX+HTYyYsLBk3OBMTH3n0Cqxnx9pTkiLzATnNDxwE74IwtLR0iWiqwITKxsCmDfLprjRjEDEj8Wb4zVKKB3n2Q20t9IluPxnd5SykWdfRiZ+Vj4/XNchsj9f8lp4cTBAQKTcSHyIAyv5elMXzdiAF33+wkPJx9Qoz1aL2KCuTFQ08TYBKA9pbxV3ytJw83FBVYcNQ1yLyN3IEXliR3YxIvgJ7oaGgJFYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8gd2mwHbSEwMDXbtxrPgPFfqzKDEbPD8Irhs/a+7Uo=;
 b=O+55KY5RIo7bYDJanHPjtAPgcOoCIfOyAl6aFHHTnceZzAhQT0ck+nbSd3XJcuc5bJju6kV2ZmcTSd4TEcGy9NlCFzKKGovtYB6wMI8DJBUCFFqmVUOEigR+VYAhcFXYow9mopcLUf8SFzgTvOpgQWWeIG5D+ssenB93ksJ6LohlKnrJdOlp6mxnAzkdIJrw9iei7+0R7Qd3a4/O+mTdYoM7rSoqKfEBkuv3NSa2lOAYsM6P5sk8tp8m2U+nuVlh5Y5dxdyt/5rQt3JaPReTYLJcIX5q8a3iKaghk9hbzk+AbPq9AsEFKofqEnwOUjsTaMxE284/3eFWFq670OWFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5616.namprd11.prod.outlook.com (2603:10b6:a03:3aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 21:25:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 21:25:26 +0000
Message-ID: <efcfa0a3-3350-74af-5aa7-8306ab206b56@intel.com>
Date:   Thu, 28 Sep 2023 14:25:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/2] selftests/resctrl: Fix schemata write error check
Content-Language: en-US
To:     =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <cover.1695369120.git.maciej.wieczor-retman@intel.com>
 <5e17ed39ffb8d6bd530c057aa04e3ffb997573a9.1695369120.git.maciej.wieczor-retman@intel.com>
 <322fb9ff-f3f4-45df-9b3f-524125ca6101@intel.com>
 <mrhrlwtpquqqyzznzqru2m5tfbz7cmtk76zxtamq76ssqthz6g@njfi4qvjclih>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <mrhrlwtpquqqyzznzqru2m5tfbz7cmtk76zxtamq76ssqthz6g@njfi4qvjclih>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0220.namprd04.prod.outlook.com
 (2603:10b6:303:87::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c28517-d619-420a-406e-08dbc0696eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nuDHw65+/HsyB4HUxXF8MsVtLIFRgl8XJxAkOg5/hpdhtblLMlazlQAJceApLN9VEPG9tu3PXqHjnN0DqFJJFEO2ILjnhsr/KM8xOF7bbRnqrpzGXZatPHJKJVLTLpK3sSs++tpwAKsli9c7oZfwKTUP86ynAXCMSsjsK96PX0O3nwtQWbPI3zyoS0tCqDhugBvbAE1lTbCpkJ9FgZ+cgnQmC3Q0P+9e6/Ppmf96829UC0PK26/732Ct1/HDXa2myUIZMi7+psjEmguZMGdn7Fpc4KSSKMkhCugkMx4fcp+jxWYFWWmzae+w08C3gl9JrEBOOLG7hVUhJMxuIx52nnJZcaC4OOtNORr2GWGAVnGVzzKNgyjiKUpdnr9hZPA2YX66v18pEETDBuvB0oanHNCMy/8UUdtaqwTukpa0shuUAH9Bjs4tdXBqjkUMl7XRYxkP907T5VDHzpO97MRwTYM4uW1sGLOiuTEnV6xX9hJP2tmmngatgFgT9i/AB5Hlp5fdfJVeLlBDZ/0lnVwLil20U5+Tdumy2zrPfvQp58fF7W67Hddk7AyVttVL5/hErBpSUKcrhe/mYxG6iMF6OXyycKNnAJdpTA1lzmLufVuNR0lLIhJ5TL6NuFAIrzwvyJ3Co7qLENSyDmLTvJd0eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(6486002)(83380400001)(66574015)(86362001)(36756003)(6666004)(26005)(82960400001)(38100700002)(2616005)(53546011)(31696002)(6506007)(6512007)(41300700001)(8936002)(8676002)(4326008)(316002)(44832011)(5660300002)(66946007)(478600001)(31686004)(6636002)(37006003)(6862004)(66476007)(54906003)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0ZxcmFmVFE2SFlmdEw2Z0psN0JETys3ZE00QkNuZEtDeGZwSkFuaUYvd3ZJ?=
 =?utf-8?B?V01TbWk0R1I0b1IrYUF2RTBYalhBRjhHM1c3MGcvUDRJVXNHTlRHYmNoM0xh?=
 =?utf-8?B?T3B0amxuKy9aMWlia1Z2Nk5mOUt3bmNhRWl6MldOM3BjbGZQMWEvdWIxSFZm?=
 =?utf-8?B?ODVFQy8yczJpajA2WC9rYXQxQis1dENocGE5NCsyMDhkMEtDdEJyTUxsTWhz?=
 =?utf-8?B?QUpGTi9hd21mMUI0T1E0SmdaU3FpTFpoYm9mckpnWVRjbHQ0SU53Zy9kSXZr?=
 =?utf-8?B?T1dKRkdtVGh1SkFSekZ4QUQ0S0xMeFdZQ25uNnQ2d2x1bTdZNElkNEtuSlIx?=
 =?utf-8?B?aE1BUklsK3JoYU9wTlpxSFo0TWErUnRONG1vcEpuSGdHc1VONnFNYzA5VG1i?=
 =?utf-8?B?R3JWMkRjSE1TZ1MxRm9RQmpqM3g1SjFhdzlCNXVNVXZDVmMxUEpwUks2dk9M?=
 =?utf-8?B?T2RvRVBIajVhN1k1UHZibk94SUkySmd1d2lnak5vN045ZXdhZjhlRHlCS25p?=
 =?utf-8?B?d0RmY2pKRUdwVzRLWGZUeCtKM3NJbjhoUUN6V3VOdzYwMFlveDhiME5QOWVO?=
 =?utf-8?B?RUt5UVRSM2F2bFN2RmtIT0FQeUtmYk4rcmU4Y0NicW83My96cGRjbFJvNXpr?=
 =?utf-8?B?S2QzMTMzdi84WVFhYy9OYkhmazBld2d1NitENVYzenh3K3h0anNXMTNEZit3?=
 =?utf-8?B?OXNzanJ0YUsxenNpWXVWbmZ0L1BNVUxXcmd0cGRENzNObUtTZFd1Zlo0SU4x?=
 =?utf-8?B?TVIyRUtZblBBZ09QNmM0SFFRYWl0MXFlUThHc2tqUzhSN3h5dTVVcnRJbTlS?=
 =?utf-8?B?VDJ1VTNrdGNmR3VLbVJuTWNlMExDZVZDNWt5aVo4QmljMnA5VEV5YlZXQ3FE?=
 =?utf-8?B?RXVya0YyKzBKQ05ER2gvRnNhL0haamRJelU2ZG13RHFjZzNTQ3ZrMGZDRG5R?=
 =?utf-8?B?VlN0UDRROEJNNEtHVE43d3BZUXpSZ2pLODltT1VabVZVTzQ4R0hnTUh1STdn?=
 =?utf-8?B?RUtLKzllRHZOUndBaUNPeTVDcnIxYURHUVkxSUdDY1pjYUdnYzRHZlZackNp?=
 =?utf-8?B?WCtnREpVNjV2ZFNYTE9OTmx6NDB6eGJCMjEyL2h6MHJRT0Z4WGdCNG90NzFi?=
 =?utf-8?B?VkdEcDZvczA0UVNQVnZEUG8rUllFWERvOFFYZERIQzE0L25BTDV6YUM1WHN1?=
 =?utf-8?B?ekpZVm0zUjM2a2xlb1BGaEtSRWJXNm8zeUttMWJtVXhnbktyL24rSm45SnFN?=
 =?utf-8?B?OXlCMk1sREJXS0lXLzdkZWo3amtKTlZuN1hwOTJnMm9TS1lSTXM4SFZwNlVZ?=
 =?utf-8?B?SmpvamVJNG5meElKVDk5NVlzVEd6WDE0TUFaTlFWdmpxTzRNQm9GOXczV2gz?=
 =?utf-8?B?alR6VUFoNjhQYURUY2c3UXV3TWVPcXZEZm92M05MQ0NsanB1R2doWmQxaDJm?=
 =?utf-8?B?bmtIcGUwVTB2cUNjU0ExYWkwZFhuVmhyT25HSURDaFRpUmkzQjR6WE1OSnRS?=
 =?utf-8?B?OTdWQU52elo3Q3ZjN1JnNkVnb21USXl1WkZxY081TVRTQkl1NDMydlpPazZq?=
 =?utf-8?B?d25WWmFKa2VoQmQ5TGdiN25ML0JDOWtmSXI0R3I4NGEzdVNCVHB6YUJnRUdm?=
 =?utf-8?B?MlBFWEVROWtYTkJXUmk1Z3BDWjlvd1pINlZ3UTUxWXdSQzVXVlFtNWlCMW85?=
 =?utf-8?B?QmZJVEZwSVAwQksvdG9iYTdhNzR5ZDFES3pkVjZNV0VQcktCeUJvK21XSDRC?=
 =?utf-8?B?eHphd1Z5ZlczaEFmU1lpTlZYN3RNSUJTekdYeFkyandKYkg5aXA5Tm5udHdD?=
 =?utf-8?B?bGk0TUdOVTI3MzkxUEd2dVFtNmtNS2xMUXBLWUQwcVpzVEYreDZEcXdzV081?=
 =?utf-8?B?Z1luak9nK1BCdFJEODFYYVJNYWZNWVhqc0hydmhqREVCZGVGSzRWL3lRS2p0?=
 =?utf-8?B?RHRNM1QzTGZhN0FQdjUwOFNMTGsxZ2ZEbk4rT3E5SCtFZStva2pXY0t4dTJH?=
 =?utf-8?B?U0sweXlPRzRWWHI2ck52aHpGQVFKaTVlRStUbEk0K0h0bjIzeklXNUg2TVpl?=
 =?utf-8?B?WnRvU2VHcVN3bDdWSnVpaWc2bHByeG9pK3lvS2VzQnNsQUtHSkRlM2lTbTB6?=
 =?utf-8?B?UWM0ajZzazRmYW5mTDJ5WENweVpUQUU4M0x4VXBCOFJjWnEzM2JnWUxVK1VG?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c28517-d619-420a-406e-08dbc0696eaa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 21:25:26.5313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPITkrLKFIwAikqciFfQ9N+gHoc/ebeylcxp8cBhkYMf437GC7ymkUc3z/59w31cN5lnKDZQnCeKdgZLycTsQzOuIsHY2ovHfxHEeIP6Hdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5616
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 9/27/2023 11:46 PM, Maciej Wieczór-Retman wrote:
> On 2023-09-27 at 15:15:06 -0700, Reinette Chatre wrote:
>> On 9/22/2023 1:10 AM, Maciej Wieczor-Retman wrote:

>>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>>> index 3a8111362d26..edc8fc6e44b0 100644
>>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>>> @@ -8,6 +8,7 @@
>>>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>>>   *    Fenghua Yu <fenghua.yu@intel.com>
>>>   */
>>> +#include <fcntl.h>
>>>  #include <limits.h>
>>>  
>>>  #include "resctrl.h"
>>> @@ -490,9 +491,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>>>   */
>>>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>>>  {
>>> -	char controlgroup[1024], schema[1024], reason[64];
>>> -	int resource_id, ret = 0;
>>> -	FILE *fp;
>>> +	char controlgroup[1024], schema[1024], reason[128];
>>> +	int resource_id, fd, schema_len = -1, ret = 0;
>>
>> I am trying to understand the schema_len initialization. Could
>> you please elaborate why you chose -1? I'm a bit concerned with
>> the robustness here with it being used as an unsigned integer
>> in write() and also the negative array index later.
> 
> My idea was that if the initial value for schema_len was 0, then if
> resctrl_val wouldn't equal any of MBA_STR, MBM_STR, CAT_STR, CMT_STR

Ensuring that resctrl_val is equal to one of these seems to be the
first thing write_schemata() does.

> values schema_len would stay zero and write nothing.

Your alternative writes "-1". write() is declared as:
	ssize_t write(int fd, const void *buf, size_t count);

note that "count" is size_t, which is an unsigned value. Providing
it -1 is thus a very large number and likely to cause overflow. In fact
if I even try to compile a program where the compiler can figure out
count will be -1 it fails the compile (stringop-overflow).
 
> I think it would be difficult to debug such an error because even later
> in ksft_print_msg the requested schema would get printed as if there was
> no error. In the case I mentioned above the function will just error out
> which I assume could be helpful.

You seem to rely on write() to cleanly catch giving it bad data.

> Other solutions that can accomplish the same goal would be checking
> write() not only for negative values but also for zero (since in
> here this is pretty much an error). Or checking schema_len for only
> positive values after the block of code where it gets assigned a
> value from sprintf.
> 
> Are any of the above safer or more logical in your opinion?

There is no error checking on schema_len. After it has been initialized it
can be checked for errors and write_schemata() can be exited immediately if
an error was encountered without attempting the write().

Reinette

