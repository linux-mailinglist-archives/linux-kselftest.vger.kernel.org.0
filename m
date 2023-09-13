Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD05C79F354
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 22:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjIMU6X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 16:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjIMU6X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 16:58:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BE91999;
        Wed, 13 Sep 2023 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694638699; x=1726174699;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T3XP6jsOiiK0ZYQcqHEJeUjQU5UAf2j404hnKyMuUdU=;
  b=NQ6g7sDlCetM5UfH/yewb6mByXSDrOpCs/cK7lz6UJeWBPeK2VniGVCk
   BpC80CPOsFkZdsOEoGOVnV63DJwE8SsUyCsKah+SLsZwTIWH+qaB0YZHv
   npxjcn4FE0pb6hT/A2oRGKniLJuAqobBBXjk9cGQxISWSsXr0szvKqIeW
   5fSWgnWMr/aVaUF4VnSXNqv5dUqaCt0NXmqZgwI4Bl5qd7DHNULXAYhg8
   V4/ih23KHkYoc3ApZYdH8LEyoZ3B8QRNuGE4u+W9GQqUMbbt6beDUVvL3
   YJ55teFYToF2n+AfIkX2AQ6DIgiOtWD40XoP6dKFQFY+BmM4qfIuI/Bj9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="445217891"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="445217891"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 13:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814406235"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="814406235"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 13:58:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 13:58:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 13:58:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 13:58:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 13:58:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5MBuDagegBBORNlXmLKQl4qHKV6dA7RvUa0iEJAkLCmKIeQx4gWCI0lbfDKU/eoDJeSPWc9chnGY5WlDE878aipg6JC3vZdgDYhsFt4qNQD/g9ABlKBiRGZP79+zBZbNAo3XarjeIYcK1d+naj4Rus9P1pgoaDtmEIX/XCDD4XmNUPXbK85c8SwtGOsCzznNsN4K7ZN3oQjicByrTCuY2A+5seBoO8cYsaAtmFDZYeEMFiqr7miE+6H71fmkvMQGrzED5yVI7/WY9OkuWjEA7lIUofjJYDKYs2/e+efp050bmMUYcDfN6mO9Um/g+C9UsvnoT+S9dvaYM9OOj23VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyR9XurXQxKJzDtmzPIQ9wEu9GOiDoimldF958c4k+M=;
 b=VW9BddlOOT2AoZ7ulb7QMPvCzaqDt3Qr2+UOjosoFhzVMsKH1S4Myn8jZcysvvS/IwXsydnhLqpWzx/uzkWSxzeMGVufUl3PRBslJDq7XaxNA7Z/gsq9oWxx3NI9uEwd8xGWPAleH1b9B5A1DMwmUFrzFnivYfC8x2L2f4wB2BflBYMK7I5fgng5KACpmq8fZWevurqq1oKmicztxJOPGPCm3xYsj/xI5KjSHooMoiE2jB03VPJG7O+iePtJ88P/HNHbkthjs2plED5w/+GRLH77oTmGZ4cu2kO+TFFBLbA6e5w5w8o0VLUvQOXHaYgrS2g+BPNqMlrR1m2rJJX6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5350.namprd11.prod.outlook.com (2603:10b6:208:31c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Wed, 13 Sep
 2023 20:58:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 20:58:14 +0000
Message-ID: <d6cc3829-9b7d-6a0b-c734-c33f6a66959c@intel.com>
Date:   Wed, 13 Sep 2023 13:58:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 1/5] selftests/resctrl: Extend signal handler coverage to
 unmount on receiving signal
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
 <20230911111930.16088-2-ilpo.jarvinen@linux.intel.com>
 <4176a620-4cec-5d57-42a3-a15c0fe3eb73@intel.com>
 <aab4b1cc-6eb5-c324-e97e-c6699e2d165@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <aab4b1cc-6eb5-c324-e97e-c6699e2d165@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0258.namprd04.prod.outlook.com
 (2603:10b6:303:88::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: 57be3e02-4d61-4daf-ac31-08dbb49c2575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTfMaqTEmbANDbkZBvqEOV8Aw99oYgcvAhJyzCPEFQHrDZWpy76qGhsQLW+KHZvVxxpfcXpx5leO9Ug/VSswZaRF5ZL/JHMqjI8R80P+uuMS44cnDq1/xzrzq13EmeH6DabY35i2YXC5UBpGWc/KH//CTNXc52plVV9CX0C15F+tpGiNe/0Fo3VnxyLAYNP5tEDolxTfc+t7Sx1QImfljwHmHZSs4ROPedETUl0636oj+FF2IxUXTe22l/You7uWx6JYHGK5fLe2ApJy7IR7LnqXyH1k7MaTJ1JTc7XFQKR6Y8ERpIq73N8kr9Lhj/YuDaPWw58fqlWpLwkd3b/Vkk95GGVL/S3Z3gEO6PkSE+KOaexK0d3sdvIATQWeaAHMcX5FLLl/InzWBGwDlfotSCejkB3raZxrVF49+nETzq3/RPgDF8jMsbQ8fvf+f5CMf9FteS0gKJ3RG3Rpy/lV8hIgJLFp8KkSjDMaNOOReQ6KyPP0i29xaoX6KYEDH3w5zvJTEoxXgf8uGdYsIhsv/fbI99VpVLUM4mXAz7gCncavT3Y/GC5pIzpwrFdC3/O6izg1wniq6oeEuqt3vBjBArZtJ0cPRe7kpV9RoXKzvokbglZr0DOOO68l5VFJ3mtMXnMZ8IexuusRd+HwNnt6eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199024)(1800799009)(186009)(31696002)(8676002)(86362001)(8936002)(4326008)(5660300002)(44832011)(2906002)(36756003)(6666004)(38100700002)(83380400001)(82960400001)(53546011)(6506007)(6512007)(6486002)(26005)(478600001)(2616005)(66946007)(66556008)(66476007)(6916009)(54906003)(316002)(31686004)(41300700001)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9uTmtVYjJQVURkcWhsWDNVUzBDMHNTK3p5cGhETDZvODVkd05pVGc1UHhH?=
 =?utf-8?B?UUhibkdZUWtyRDQzTEp4TkxTT1BZdzVvM2Fwc1FON2V4TWxOU2krZXoycS9C?=
 =?utf-8?B?dTNiamJFZWFzYk5aWGpmTC9UTm5lTDNUY3dZUDVqRFlja0V5eHlZckNTMzNJ?=
 =?utf-8?B?M1NaNVVQRHQrNGhNM1RycU5zcUwzMGcyV0FUQnhwVnJaZElQM0Nla1FFY25V?=
 =?utf-8?B?Q2xXQUk3QWE1SDRDMHVDM09icHFFakpvK2hSbDZQOVliQ3BvTnV0TFFWTUNS?=
 =?utf-8?B?QmFoaU5MVHVSZ2FKQ0ZteVlyaklmMy9JYWw2SldCbFZsRTRmYWlTZmxhdTVF?=
 =?utf-8?B?THRmY2RrMHVQVVlFMjVuSjRqbmg4dGZzMVN1V0RsY3MwM0h3RzB1djM2RFgw?=
 =?utf-8?B?WmJzbmtuTW9XMXZUbU9ObjlIY3hZdTJvWHU5SlBPS1RLUjZNUFArcXlCb2gw?=
 =?utf-8?B?R2p4OEtyMkhmd0UyS3hKM1hWa1IxRENmK2xoTkloOExOZUZoaTZ2YThPV2p5?=
 =?utf-8?B?NHR2VllzQjdJZTlMaFdlR2h2QU8yemdLVTNsQVJQNVJsYnNmZUVGMEU3cDFz?=
 =?utf-8?B?Z3J3YWNnNHY0Q0NQb2Y1MUdvTEV1WFA1YzZwdElXbFpDbVJFTWJLajZCemg1?=
 =?utf-8?B?Y1p4QUU2bE1EV29OOC9BSHgwY0tGREZ6MUhpMXNNT1JFb2k4YVF4VENHVmtP?=
 =?utf-8?B?R2ttdW1pNWx0YXEwdVpWWDlqUGEvU0JKalhrTnRsdHZyOXlXOEp4aVZXdnFq?=
 =?utf-8?B?TmJaWDJia0UrV0ErT0o1aExJUzZ5NnJudVZCbVZ0bkNkaHpEZjNvY0VXL1FF?=
 =?utf-8?B?T3ZHQnJBc0VHQVlrMSsrU0dxN3N5RjRILzR0bnMxYTc3RkV6eldiYUIxOTVz?=
 =?utf-8?B?ZkxBUHFhMytnb0JIRytldk00THVKUzRYcjFNZmxZUnI1aGdFdkV5MlN3VkRm?=
 =?utf-8?B?VE1IQXJkTjJucHVnY2ZBYjJ5U1lJSHlMMVZ5WkxJQUpqU0lpVEt2ZFNkeURJ?=
 =?utf-8?B?dVRlTkZlL2tINEFKZk5KVE9GamZnZW8xdC9kOHpkTkVzNCtDRzhEakJUNlY3?=
 =?utf-8?B?TXpPUGZ3c0RWZ0diK1ZyQmUxcC9WSHZWcUhhRDNxS1IzSVlOVVZyalJJOVRp?=
 =?utf-8?B?WVh3L1cwM2pJUExVY0ZubWlsdnFrMWM3VDM0emRRQlZpd25uTVlac2tER2V0?=
 =?utf-8?B?M2NaeVBkV1pPWHdFemNYOE9OZENMcFNraU9ybVZEUk5MQ2FSNXFNNm9XYkx4?=
 =?utf-8?B?WHFHdWNVaVMxUmdMMnJpQTVuZjliOENuL0pseGJlekkyYitDL3BDR1BLZ3Ji?=
 =?utf-8?B?ekVXZG81cW5Jdm9qR2drZTczYjVPNXREQVZKVy9KVk5KejJ4emoxYSt2NzVT?=
 =?utf-8?B?dTQwdWg5enFjcjZOUHpHc0x4bEVwUEx3WnlkTUY5VVdOWjhoeXZHbnNHeTNa?=
 =?utf-8?B?bzBSd2JlRjAzaTJZSEh2aDVVL3UrcncyY090RjJLdC9RaFJXdklQNERqUklo?=
 =?utf-8?B?ZkpDakVqRy9xM0tpVk5VZksvU0xUTFl2UU1NelQySGN1bUVkbUtwRktrVlIy?=
 =?utf-8?B?bXlRVDhIWmwwdU52Zy91Q3FERStEdVBPNlpGS1BxdEJtQ3Q3YStXVFVGSVFG?=
 =?utf-8?B?N05HM0hTWU5TQmVaZ2t6TmpwUllQUjFVMnViM1l3cXNPVmZydndQZTl6Qndx?=
 =?utf-8?B?N0tBcVhrQ0RTMXgxM1h2SkRIM1pxWE1SSEg0OUpFSDVyS2s3MUMxNjhiYnRU?=
 =?utf-8?B?c2hCTWxEcWxsOWFrNUs1MjNpUGJkY01wS0RlVlh2ak9nbDQwMWZ0SnBjNE5x?=
 =?utf-8?B?NWNyeWFTZ3ljdjcvMmlCbTRSaFVnRnFrUHJTNFhWMlBwMzd4V01keHpTSFNM?=
 =?utf-8?B?Rm9FVkx6QU5IVDcyeCszRjJOcWw2WXo5MngrSnlnenc4bWRUQ3JaU2ZabGd5?=
 =?utf-8?B?b3hSdkRRUlg4RGNPS3JaRjJNelhuZlBvTHJiNkhGNmZXdVFNbnJjd29CeUVX?=
 =?utf-8?B?eTE2STJBcWh6aDM0UUljQkk3Ymwrc25IcWlOUmM3S0grUkRFY3FBRkNqc3hL?=
 =?utf-8?B?aU5jY1M4VDY5Z05xUmR3SXdseXk3TU9aaGw3cFE2NnZ5YmJ2bDB4ajdRbXpq?=
 =?utf-8?B?akRHQi9UWCtycWVFTk5KOThwSHBYR2FDemt5eVBvbXJVUVBZbU4vd21HUzFv?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57be3e02-4d61-4daf-ac31-08dbb49c2575
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 20:58:14.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwhzmTKljE0ZbMYA9QM8iVk7XD/Pi3sDKJD0K/SNO+3FibvFBI2F874/pagf5ZRS6KX4rtyORWVZI+n9XAfzAtbNtlC5dMPheTPqJBtZndE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5350
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/13/2023 3:01 AM, Ilpo Järvinen wrote:
> On Tue, 12 Sep 2023, Reinette Chatre wrote:
>> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
>>> Unmounting resctrl FS has been moved into the per test functions in
>>> resctrl_tests.c by commit caddc0fbe495 ("selftests/resctrl: Move
>>> resctrl FS mount/umount to higher level"). In case a signal (SIGINT,
>>> SIGTERM, or SIGHUP) is received, the running selftest is aborted by
>>> ctrlc_handler() which then unmounts resctrl fs before exiting. The
>>> current section between signal_handler_register() and
>>> signal_handler_unregister(), however, does not cover the entire
>>> duration when resctrl FS is mounted.
>>>
>>> Move signal_handler_register() and signal_handler_unregister() call
>>> into the test functions in resctrl_tests.c to properly unmount resctrl
>>> fs. Adjust child process kill() call in ctrlc_handler() to only be
>>> invoked if the child was already forked.
>>
>> Thank you for catching this.
>>
>>>
>>> Fixes: caddc0fbe495 ("selftests/resctrl: Move resctrl FS mount/umount to higher level")
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>  tools/testing/selftests/resctrl/cat_test.c    |  8 -------
>>>  .../testing/selftests/resctrl/resctrl_tests.c | 24 +++++++++++++++++++
>>>  tools/testing/selftests/resctrl/resctrl_val.c | 22 ++++++++---------
>>>  3 files changed, 34 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>>> index 97b87285ab2a..224ba8544d8a 100644
>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>> @@ -167,12 +167,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>>>  		strcpy(param.filename, RESULT_FILE_NAME1);
>>>  		param.num_of_runs = 0;
>>>  		param.cpu_no = sibling_cpu_no;
>>> -	} else {
>>> -		ret = signal_handler_register();
>>> -		if (ret) {
>>> -			kill(bm_pid, SIGKILL);
>>> -			goto out;
>>> -		}
>>>  	}
>>>  
>>>  	remove(param.filename);
>>> @@ -209,10 +203,8 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>>>  		}
>>>  		close(pipefd[0]);
>>>  		kill(bm_pid, SIGKILL);
>>> -		signal_handler_unregister();
>>>  	}
>>>  
>>> -out:
>>>  	cat_test_cleanup();
>>>  
>>>  	return ret;
>>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>>> index 823672a20a43..3d66fbdc2df3 100644
>>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>>> @@ -73,8 +73,13 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>>>  
>>>  	ksft_print_msg("Starting MBM BW change ...\n");
>>>  
>>> +	res = signal_handler_register();
>>> +	if (res)
>>> +		return;
>>> +
>>>  	res = mount_resctrlfs();
>>>  	if (res) {
>>> +		signal_handler_unregister();
>>>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>>>  		return;
>>>  	}
>>> @@ -91,6 +96,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>>>  
>>>  umount:
>>>  	umount_resctrlfs();
>>> +	signal_handler_unregister();
>>>  }
>>>  
>>>  static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>> @@ -99,8 +105,13 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>>  
>>>  	ksft_print_msg("Starting MBA Schemata change ...\n");
>>>  
>>> +	res = signal_handler_register();
>>> +	if (res)
>>> +		return;
>>> +
>>>  	res = mount_resctrlfs();
>>>  	if (res) {
>>> +		signal_handler_unregister();
>>>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>>>  		return;
>>>  	}
>>> @@ -115,6 +126,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>>  
>>>  umount:
>>>  	umount_resctrlfs();
>>> +	signal_handler_unregister();
>>>  }
>>>  
>>
>> This adds more duplicated code for every test. Have you considered a
>> single test setup function that can be used to mount resctrl FS and setup
>> the signal handler paired with a single test teardown function?
> 
> Yes. Consolidating all these is among my not-yet submitted patches.
> I just had to do a backport-friendly Fixes patch first for this.
> 

Could you please help me understand how the duplicate calls are more
backport friendly?

Reinette
