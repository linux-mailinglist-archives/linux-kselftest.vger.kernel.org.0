Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4296DCADF
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Apr 2023 20:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDJSjv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Apr 2023 14:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDJSjn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Apr 2023 14:39:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECB2E63
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681151983; x=1712687983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=plNvtzx65522+OO3zDbWSuZabTA12LEuJDYFNOv0PqM=;
  b=i+oSA4yoV7c9NbFYgWr/XF+nzyxmaElvH5kkoR2K2I6n8J/cUBZGanC8
   9jjXGqxaugPfq6Ln1w1WOzCR219cr3+Fwc8HJgm8zJ6AN4VqkkyXRd7Ma
   1c9rTw5c++9lGr9lAl2AdZHz5fndTR+vAuOcIVRTB7kPHyV+5eibzBAb4
   DhegSO5+5qbiLxFORtdl47aYEwBZ0MGKxQyOLfBlx8guGsmJFBNSvS+oF
   RwWvwnZLFZpH35jshMdcZiQ6hMeYlQ+IaG9N3Z7HcY5N4ADi1csK9dNko
   iIETowUHFYV9UyfCkIAxPMvzrsNpR/KJU2ZkL7N7zna8oLgDQKZ+aSzlp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="346092681"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="346092681"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 11:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="934446272"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="934446272"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 10 Apr 2023 11:39:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 11:39:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 11:39:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 10 Apr 2023 11:39:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 10 Apr 2023 11:39:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utez73uOKlymk2u6gk7bvahZye9hIFzUJsAduvGLRJlVHAWKrQjlwrlN6VsZPIkfgK3v6g3rrfMJkGUrl/QOG5ctlCiDS1xhDn7j9RYFwqIkAoAXWG/SyTHEYX/5pFTG3jjiYP0oEpG13hrNCthQMg8Re6rC0hCe/RMYNUBPw8W1uAVF5EdRJfWvCsu8/H/PWV0wQqU+AzYY36c0TMDOCIniIadla1lh3qFS1XioWXjMCWhVoT6ziv/BPrA2wT4ns8xLl6MmwR7tyWnxbZFdf+cppvYAGjBFbfX9vWiWaWlRNjozz9/eV0deUEyY/ZF3aEgX/Gw8jGF/zdNDipUgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JW5AwLvb5NBR2qAwcIdng1cGOnorvykNePiBvCG9E4=;
 b=RlEeejS5Ood0XH1IAtaR8DBiI7Yvn5s+nQJWcDHWMYj8HYZ0lLSDmfnHb5oZpLm5/2cb+UzC/HiBjTIMZ9UVc+7YY6pTIBSsI21u3Ns8GIuS+fNRpe1PakP84mC4zr59j7YWkhYaU/uQ1vTpZEFDH+45nxdB3w77a11PomP9/QUr9m5tcPnmmGBGtjRtPrrg9T1bDuNQy7eIOkyHKJUdwOmg2dnYDqTsEpALp4+br7gFsBX4d6KlXndh9H1/eQGd7qwsfX4qDKpoIXmIvSftGYvVSpONgLdvpOKe5JZBglyZpN3+pv4rK0ZsOIdFxy0GhQjxNan1LyjVuRsyHDzSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 18:39:39 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6277.038; Mon, 10 Apr
 2023 18:39:39 +0000
Message-ID: <168d8f63-3d42-96e4-e8b1-89f92fb8cf36@intel.com>
Date:   Mon, 10 Apr 2023 11:39:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: resctrl selftest patches
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
References: <eaf96617-2f3e-b573-8990-6e9e6b0cb6fd@intel.com>
 <71b769fd-6cde-0ccc-ca41-c94d4737b596@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <71b769fd-6cde-0ccc-ca41-c94d4737b596@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ1PR11MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 553d6de5-a4b2-4ef5-f2bc-08db39f2f0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FK6j6r5M5VKfllT5RxQKF+JLMbita8JgDOO9zoXtn2ju7hpKuiJW3u0uY5o3ssCB7S+BoOj/byxmR6ccevoVV6Se4ya0NB8kHOm9ryOdQJeLZhS2FWfZbw6ueS3NPUsPXsN/sd/e0yZoPxUyDPRFMEcxnc5CvS+KQP/c92C47WGuChE1T6Qw8vvjTT7DCBtX+krda9x3LN9hCZ4KwnoyLXiUfmvjhYiXIGy0C9p3fFHXqCroRWsrYhLirpT4CUVQ8lH3OoctQQEMbI/eiM3L7PN/YQ55COql3kx+H6Jp0byQ80GvAQI4ElXoaBDoKX4oMlccoG1vTwIOPRSsmy7ydJjtMDXUBFRsuCOTwRjabwK2Q9z3pHeIVxNcfRFm9cohu6het1xwKoXM1Sn00HFuq6FkGG94JZ3/txuUxSYAojg2PZtGe1+nmjXlAcryVJ5Np6SX6rtCgbn95o9P+piVwusCCOL5kvNutnZrq3MDeKdPFCtLchnVzd578Kl+3+enHVA1B7TQ5S0p2WaU6ogikPHxJ+wt6SrO3dr+sJoRzdvOwr29aILLi8ykvpJLyYSxjVzFPqOA8Uay+mAPuhlQg2J1qmE5gn5e+NIfLfKwsTw2fJPSySs/CdY2oA58yrlM196o3O2PpIjEa3l0V7w2dz9osS0LJkljxubGo0vXomRdRSmFzX6f7ICLtl5cW8I2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(5660300002)(41300700001)(107886003)(478600001)(38100700002)(2616005)(8936002)(8676002)(82960400001)(31686004)(44832011)(2906002)(7116003)(31696002)(186003)(86362001)(4326008)(26005)(66946007)(53546011)(66556008)(110136005)(316002)(66476007)(6512007)(6506007)(54906003)(36756003)(6666004)(3480700007)(966005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTRIbE1TOVN2VlZJUTYwaThVZXNjaGorN01hRWk3ZzZYVERzMWc0L05ZaWxw?=
 =?utf-8?B?c1hmaW5Gd01BNUE3ZDlTdHZsVUExWTEyVjZyQTQ5ZlM0emtqWG1ORE1Ua0pD?=
 =?utf-8?B?TXVBUTBQN3NueDVBMlhNakQwWU9PMUVxSktxTjhQOFBxQ3ZYL3ZmdXB5dmdJ?=
 =?utf-8?B?TndBZXMxZk41cUQyZy9tY1RTbytQbmlJZGNkUkh4bVgxK25MMkZ1SWFDMDdJ?=
 =?utf-8?B?QTE1NU5HOXZKVkNMTkxDYVoxY0xyYWhwT3hVYkVtdktvTG1uNTdWa3psNlZR?=
 =?utf-8?B?TE9Jb2IzZWVaY2FicFJiYm4vOUkxMWc1R0Y0Y2NYSzIyMzhRMjU1MldXRUVN?=
 =?utf-8?B?QmRQbjZCYkd6ZTM0S0hUZ1VJUU1taG41enlQUFQzTXNZNXZQL2d0VkVxbjFh?=
 =?utf-8?B?b0x1UnU3NlpNcHlZV0YyT2lFVStzZnZmdHNvNWx5K1Q3dmdZRXgxTUxPZTdV?=
 =?utf-8?B?RG8vdkFHVVMxV0F4NEd2UTU4dElGYjFodHVmVnZYUmcvTXJPc1hRV0s2RUkv?=
 =?utf-8?B?L3dWM3FZQkVzaDcvQ25wWDhtZElpMlYwU3IvZWhsbkFUZ3JocUtXZUp3OWRE?=
 =?utf-8?B?blp1MVg3V3pHM09uZzVCWFVMOXdBd1NtcVJMTXorWW5wM1o1em42ZkM0TWMx?=
 =?utf-8?B?Ukc3b2lNWUl5YTkwVEpBdTg5N2xGWEVSZHptNjZrU2t1emUyT0FyeFZsdWZD?=
 =?utf-8?B?RE5pSzdDSFhSODJFRlo4SXNLYXV6NHBwY1M2bzAySWsrd0RCeEFhL3d3all6?=
 =?utf-8?B?WS9Ebzk5ZHRVeUIxSVh0Tmp5bnZYNzkvaE8rbzA3bndRcXptMXhqbW1Yc21M?=
 =?utf-8?B?cGNlWnkwVWF4ZGJ0WHEyQUI2S3k5WVB4bDRwRDdqU0pzcnRFN016bFN6WU5w?=
 =?utf-8?B?UU0wRGRUUjdITmdKRmdEZ2owcVdqWVgweVp4V295NDR3eUQ1VHNvU09yNTZr?=
 =?utf-8?B?bmViRFhPNWdyQk93elNDZlc4bG1IMml5UnM2c0I3dW1WQmROTjVXeDZTUkV0?=
 =?utf-8?B?a2hxN1JSYVJ2U1ZISVJ2eDVrQXRrMmNpM2ZGS2x1MERpS2lNVGNjWldsSHJV?=
 =?utf-8?B?OC9yV0c5TTMvcWptcEYvcXdzdU5rUFlPQmk1ZGFYUnYreE83QytFYXFmZDUx?=
 =?utf-8?B?VFc3Z0daR1dHQVBEVlM3eGNIeExaRldvYmR6QTJVRmVLWHlXeUd1c1NSSHZS?=
 =?utf-8?B?aFdrd0NYRnE3NEF3cU05TU5BYzA3aFRpa0NrR3ZuRGNqekdUYVNVcGFQZEdQ?=
 =?utf-8?B?YmFEbS9md2s2S3VKZERhaXE2L3Z3eVF3UGtVcEpVNUNtM2RMVEZRb1hZUTBw?=
 =?utf-8?B?N3lzc1F0aFE0d2wyNVZGVkN5UlJVREVtV3pGL0k3ZjRLYUpwNytuTmczOW0w?=
 =?utf-8?B?YXNwSWpnbm5kZVlVRGdtbmFsMW5sUW1aall3UklEUVJLZWM2K2QyNkV6ajdt?=
 =?utf-8?B?Y084NUhpQlRKNEZuOEVna0lNeU92d1Bxd3FsY0Y1ZG5QbXVKNEh2SFBPWUxR?=
 =?utf-8?B?UGtlcERHT1JlK1lKeThqajN1Mkp4YlNSVjRlcVZRSHNmQmFnT0I4emFaQ1Jx?=
 =?utf-8?B?YnQzZFo1bG51amVCNmJMUUtvN0Z5UWdPTTg1UFBWcllyOEM4VGZ5dzJudlJk?=
 =?utf-8?B?Rk1TSnBWQVVLMEw0RjBIVnhQZ1g3ZHRRWGdzaHNKdEFLblI2UG1EYVBISUFZ?=
 =?utf-8?B?TXR2Ykw2OHdHMW0rcmpzUmUrTCtScUdLa1dFTlhjMDVCMXo1V1puZGgxU29p?=
 =?utf-8?B?MEdWNDRORVFZVVAzaTZ5TEgyNWpydENEOWdHMVdSWW9XeVY0VHY0YUk3dzAy?=
 =?utf-8?B?ZHpGUGhSaUVOZU5mVi83MlVzTFdZN08rdUZhczlpQUNISVZiTkFIYUxSYXdt?=
 =?utf-8?B?NXEyKzRQdWtKd3o2ZnprVndYaWpYY3k5SjVvekwzTTJQYVBWaDB0UldjdWFz?=
 =?utf-8?B?QTZwZWp5a29jSTBpVXVDQWJUcktjYm1HTVQwWEMvMTJXSzVFM3o1V0l0Vjh3?=
 =?utf-8?B?ZjVaQVUrdmk2WmJPdE85cGFTT2tzTVFkV2xGTjFQRHlpQnZ0Z2J0aXRrbDRJ?=
 =?utf-8?B?VkorUDEwMnp4ZFZGUWlCMUZ6ZmFYSFpCbmNJbmZ0Z3o4eWE5YXJDVnBUWDZO?=
 =?utf-8?B?YTMwNGhKUTEvNnYyWFpxakpqaGlJUUJiZTk1YXpRM3k1dWNwVjJ6M0lvalU5?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 553d6de5-a4b2-4ef5-f2bc-08db39f2f0d5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:39:39.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MEkpdhBjYkHwGQuauI85YaW3SjgHikf5gNg3V/Jyi94vn0edxHbvKsRwrtbFi7FQ1eqRmPEYhBV5ZYRZs3YcehwuNc8IPpJHxj/m5sVito=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6129
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 4/10/2023 11:25 AM, Shuah Khan wrote:
> On 4/10/23 10:43, Reinette Chatre wrote:
>> Hi Shuah and kselftest team,
>>
>> There are a couple of resctrl selftest patches that are ready for
>> inclusion. They have been percolating on the list for a while
>> without expecting more feedback. All have "Reviewed-by" tags from
>> at least one reviewer. Could you please consider including them
>> into the kselftest repo? There is one minor merge conflict between
>> two of the series for which the snippet below shows resolution.
>> [PATCH v8 0/6] Some improvements of resctrl selftest
>> https://lore.kernel.org/lkml/20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com/
>>
>> [PATCH v2 0/9] selftests/resctrl: Fixes to error handling logic and cleanups
>> https://lore.kernel.org/lkml/20230215130605.31583-1-ilpo.jarvinen@linux.intel.com/
>>
> 
> I was waiting for another ack from x86, don't see one.

I see. What are your expectations for resctrl patches to be considered
ready for inclusion?

> I just applied them all.
> 
> v9 patches are now in linux-kselftest next for Linux 6.4
> 

Thank you very much for picking up Ilpo's series.

Would you be ok to also pick up Shaopeng and Peter's contributions?

These are the following (nothing new, just copied from previous email):

[PATCH v8 0/6] Some improvements of resctrl selftest
https://lore.kernel.org/lkml/20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com/

[PATCH] selftests/resctrl: Use correct exit code when tests fail
https://lore.kernel.org/lkml/20230309145757.2280518-1-peternewman@google.com/

Thank you very much

Reinette
