Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE527A087D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 17:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbjINPGA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 11:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbjINPF7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 11:05:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89EB1FC9;
        Thu, 14 Sep 2023 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694703954; x=1726239954;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N40LAg1wlLmKW+lOQ01N04uLTP54XZKU7GcMa9BXZDs=;
  b=gJfILab+wLgzICgHM7w4trGIzpCNwUF3NRgcXC0r4VOGJ3X135bwNIk+
   1cbK1RpTJmdkJBFdM7NV9aB3D613tNMBVCFl+WctlZ9kwM+/eLj+tX5f2
   3lKQWHQktkeHuocYJGzMI3cu9S0K4rj0uX1BZPnO4AcH95YBEqFcsQBFx
   /qmQy/rgBFrz649KciP5NOAHm4+CNUvcHYV/amH/bLI12DZttRTdALcYZ
   ln2RauOta9K3TLjiAABHvM7Nkc2xPuL+EmAE7BMSqGvdmIlHfJPQVdAzK
   K5MHjo2itTrkW8DY96wkB0UpthxHrWwY9SPZruvAP7lzaX9Fa34hmY5b4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="443025749"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="443025749"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 08:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="721311239"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="721311239"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 08:04:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 08:04:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 08:04:41 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 08:04:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY9DXe7lno6Sw1qnX98qcsOdwxGlha7Hl/NHQPTHNefFMGlWd4MutT7SOxfHVcyhg5hSYQkHoXjSbtTLS6ik1rKaEm2ZvcxsVqmGpqqgLNj+YlzbM7TpSdDSQ9G/QXGerJOfvKBMhyaOwfX7YC0hM1HhZhswHWyUKvtGYdVx4xcRNIslKhTQlyY1PXNhepCWoBzTzJMvgwBd3YRHWaR2d/tKNrUkWvvFGMeSzZQf54lgz/GBVKV9xgZN6i8/EChatuzxPK6o9aE1V1xd0UBFgm0UTF3ewGei5K9jjrHNKZSqCEq8T1hw+SvkjEsdfI8qLnix74/YyVrohtGCw7+ibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpenYihuNStMZd4fVZarF0PMWaP4Ug/a/2VVtpig3M4=;
 b=bRjWw2Lr5BuL6/KhqPAZuif0M0CgT3ULXuSWcmm8BnjiBjBKDAVBkmjkcNoFPaytIaf933kfyzBjoprE5nspKk2GUD8ngHyNJ2YfnaI+OVHXm3a/0GnXjUVsGGX1A1vxse3VP5+l17oBacQWegGgBjnErUfRWMsy/LmbFCcXSrcFMtq2AvNS8k5aFng7bNrexFuMc6Uvg+oTwKX9VKPgNA+n/WsLXo+VFC4TpyATXsPE1rOOH8sIU/S9yj/8RZHTJOkBK3GgKdE7U8A8K64jS7hR96aTEm04FkQ0rzABn04BQiLDY+P4ZaxujlftMura4OBbaRd6JM4TKnraGMv86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB7087.namprd11.prod.outlook.com (2603:10b6:806:2b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.39; Thu, 14 Sep
 2023 15:04:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 15:04:39 +0000
Message-ID: <b32f4bd1-9e99-3daa-9d39-8f241b41170c@intel.com>
Date:   Thu, 14 Sep 2023 08:04:36 -0700
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
 <d6cc3829-9b7d-6a0b-c734-c33f6a66959c@intel.com>
 <9dfe761f-6779-44c6-c227-5175d53ac25@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9dfe761f-6779-44c6-c227-5175d53ac25@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:303:16d::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: e271e54f-590a-45ca-2963-08dbb533eada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXd1GcAEgaDKPH+oALJJy3QkmgBwP59wWvJ2TjKxwNdeuruGkZ27QsfECgDkl9ft66/v/hAa9BMw1wESxNQ2gkO6woTEV4k3B46QCD6vMM1IKgLS4lLjoA5BM1s+d60jSyWDBZvoQQzxJx9i/Su6Cgvlk8NxiXp9VaO9NSZRrcBxlFB3w1PdyH9qRIyxnWCUI++/LOR5Y3rs36yquV766HQLvm4QqGootALUfZZFsIIERDz0LZG/m8ZQ5czf6fK4175mVDu/vGC70oUJy6kxnDPCBXLXM1UwI/eOixNteYxyUIyAawdcPSDTlRiSXdvYAucPbgcw1gCncISqT+OyWP0eLQ1ZYlwsGGLng/XzSimBa6/e/DJ6IwzEV2G44lHCXDcJhFqZ4OuiFteDFxgPVutfgR96nMyFFKwJ96D+SIodv5H23vVSfn+bna6GmvSb43OGYeWDshCpvIitoF7TaXq2htEsotfYganol9moF9QJbSgkFAHlODKqSwsFZOif5NM4umqZSo0BWkKPE4GxVQNuxaMdsreqi8mJ3rhztKkyA1lbJxspEmlFVwSt/n6StEEK8yGqx/pAUNuemqoH+MnqQIzt6HC1IjB1CnDZl2b2N7YXgiQ81x4bTzejCgV3br4wh7UAtMdi57h89bX5vA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(1800799009)(451199024)(186009)(66946007)(31686004)(31696002)(36756003)(86362001)(478600001)(38100700002)(82960400001)(316002)(66574015)(26005)(2616005)(83380400001)(2906002)(6512007)(6666004)(5660300002)(41300700001)(53546011)(6506007)(6486002)(44832011)(66556008)(66476007)(54906003)(4326008)(6916009)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnU4Y054VW1WYmhWNjJ0bFprbDE1Mjh5YmVwejJiQktsTFl6cTBYQUp3b1hQ?=
 =?utf-8?B?dFlMSUlQVm90MTdwZjRIVEhCNXFVTXVJNDNNcVd2WTh6NmpGblNoNGNSYXFZ?=
 =?utf-8?B?dmJxN2psMEYzRE9JRG92a2NCUURaUHhBSUxReFlNTS91cG02UXdTbkhGNmhX?=
 =?utf-8?B?VFdUOTZwV29zZHdxdCsyQ3RaNFNIQUdmTXlVRnFmN0g0RlhDSWx5TzBSQ0p6?=
 =?utf-8?B?bEo3eXNkenZTdTY0dlpzQUZ6SGdEbGdVcFpBZ1FWZEdsbXlqL2owcmxUQUd4?=
 =?utf-8?B?amJ4V1UvUWUvOVQrUXk4aGd5VGtnOExBMStYckJzME8xWEZZcFVhckUvWEhH?=
 =?utf-8?B?L01KMk5SK0lWZXlzNjNOSFFvdXpJY1ZFR3BQSTQ3dUlmRFd4Q1pnRXV5Y3lN?=
 =?utf-8?B?MkZEKzcwL2xLNk1kWi9Gdm1Id1M5SVNhbW5jdWlJNFl2emxlSG9GdExvMVo4?=
 =?utf-8?B?UnpGU0lzNWlTRG91dWZ4S2RWeGVyWmg5SW9rckh0TEVNTjhWRGUwQlA0RWJY?=
 =?utf-8?B?SElxWkRKYmFyRGdEd013MS9uRU1JVGlpOEZiaXlhNG0rYXFmZGZyaTBwUG9P?=
 =?utf-8?B?UXE2MU9VU1RZeDdmQTRiR1o5UDdKbDNwQ3c1SERrZ0FNYjg5ZnVNbnVNbkdz?=
 =?utf-8?B?UXlaRFkzWGhqSHlaQTY2d2E1cTI1WllkR1NuTFBZVzdmOC9VR2szLzkyODVv?=
 =?utf-8?B?TklEaE9vYlpXVlF3YWZWM0RqWEV0Z0N6ZzZwVlgwcGMvbkI3RkV0cjIvdGJK?=
 =?utf-8?B?VzZZL2czSzh1L2RUTmRRR3czSFN5T0I0SXlqd0N6TWd4ck91WHRNdDBqL1FL?=
 =?utf-8?B?d3RJNDRrd20xbUF6SzZlRjJ4emY5Sk1EdHJ1WWdTSGtmam1mbFBkak5ML2VN?=
 =?utf-8?B?RUxkSldwbmRmR0JScmQxUlZDb2RiUll5Unk0RFhIcnNhVWlQTy8xK3VXTGN5?=
 =?utf-8?B?VzJwNDZjS1I3cEhCVmdwVEwweVV0MVpiWnF3RkpiZHZSTGs3QUFQaG84a21h?=
 =?utf-8?B?bEtvMGF6MnZFN3hLcWRYanEzSHlSSWxoODMyVSt5TWJMTUEyN1phUVpMVXNC?=
 =?utf-8?B?eElEOUpycE93bG8vdTd3TXlZeW1GNmg3TXBXb1RNeGNiRmo1Szh3R0hKWjVx?=
 =?utf-8?B?SSsvbXhQR21oQk8vbDJaR0M3UHYxNVJPUTFKRFFybENYdE9SMTJDbkhJd2Mr?=
 =?utf-8?B?QTdGQkJKNnNJSTRzUjRLZEovMGlETkIxaVVONXg0c1M0aGhsV0FodzdxTG9Q?=
 =?utf-8?B?NGxqcmY5SnZzZzZYQkZnN0s4VDBidHJhOUdrY3BJWFZ2OW9sQVFkUGFEQ0Fr?=
 =?utf-8?B?c1BNbllVNXBHYkRIRk9nbjFGZmtKN09Yc2NnQk11TFY4L28yZUpmcFlqeG9C?=
 =?utf-8?B?NkdQZXJyaUQ0S1gvWG0zOVNQZzFnLzdiMU1YczZOdlpZQlBiRWl6OHpGazFh?=
 =?utf-8?B?VU9Ya01yRExyTEhScHhBUVRJbnFlWGpkQnFZeklrYkxiRlIwdmNQamYyWXVt?=
 =?utf-8?B?VktQb1lQaUg3U21qdkdncHE5THFhUWJWaG1TdnZ4RzRvMFlJQWpuOW9va2JM?=
 =?utf-8?B?U0RzdWtMb1JVMFVvbU1xRkRlNWlHcGErK3BFOW5wWVM0aVJjYnduemtGbW5H?=
 =?utf-8?B?eXVwV1N6NWtJOFZMKzZwci9JWlgwMFFVcFc1enI4dTNMWGdRSXRvZTFFcEIw?=
 =?utf-8?B?RUU1TGlsOEtnSnpTZ0Q3NFJpZHo4Z3loMTFzTnl6K25lTWo0RE1qWXI3RU9Z?=
 =?utf-8?B?aWlYdHR3MGpNVTB2YlVWbHQxaUlvRjRRaG80UEJUaXQzWmxiUGhseUEyUFJV?=
 =?utf-8?B?eFFaMklzZHFkaHNUT3AzT2tmR1p0S3pWZUR1ckxjeklhb25lUmczZ3pzVlpz?=
 =?utf-8?B?ZGtvNGZlZlMvS0JtQnBXdFcwS3E2STRCaHRTUUx5aGoyYkxxUGp2UzRIa2Vi?=
 =?utf-8?B?UW9kQzFxNnFpNVZ0Nm91Y1UrSi85VEU1cVRmM05HdTRxNHl6UnFXMFZDU3pj?=
 =?utf-8?B?cXFZQUNhSU9SVGVnWUtzek9ZQkQydk5Lci9leHFpbDY4ZSsrUVZTY0IzYUVK?=
 =?utf-8?B?ejBiakhtWWpmLzQ5V29jbTBiRmhXem1PdXFLRkd1TlhId1Jiai9VWjN3RGJ0?=
 =?utf-8?B?Zkthcm51VmhKaGFwMEE1NDRQQWVpcFI1aERTTW54aEFSNUdMWnc1WFllaThT?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e271e54f-590a-45ca-2963-08dbb533eada
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 15:04:39.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzLTya+P4kunXhL8KddcbiT2GSHYMVStOZo3v8kDQKTu4MjIGno6yvT4IqnV9qIFf+/ISM01RsAp7Zpu7hGA2I5B+swmgwRKHvPXbR335W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7087
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/14/2023 3:16 AM, Ilpo Järvinen wrote:
> On Wed, 13 Sep 2023, Reinette Chatre wrote:
>> On 9/13/2023 3:01 AM, Ilpo Järvinen wrote:
>>> On Tue, 12 Sep 2023, Reinette Chatre wrote:
>>>> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
>>>>> Unmounting resctrl FS has been moved into the per test functions in
>>>>> resctrl_tests.c by commit caddc0fbe495 ("selftests/resctrl: Move
>>>>> resctrl FS mount/umount to higher level"). In case a signal (SIGINT,
>>>>> SIGTERM, or SIGHUP) is received, the running selftest is aborted by
>>>>> ctrlc_handler() which then unmounts resctrl fs before exiting. The
>>>>> current section between signal_handler_register() and
>>>>> signal_handler_unregister(), however, does not cover the entire
>>>>> duration when resctrl FS is mounted.
>>>>>
>>>>> Move signal_handler_register() and signal_handler_unregister() call
>>>>> into the test functions in resctrl_tests.c to properly unmount resctrl
>>>>> fs. Adjust child process kill() call in ctrlc_handler() to only be
>>>>> invoked if the child was already forked.
>>>>
>>>> Thank you for catching this.
>>>>
>>>>>
>>>>> Fixes: caddc0fbe495 ("selftests/resctrl: Move resctrl FS mount/umount to higher level")
>>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>>> Cc: <stable@vger.kernel.org>
>>>>> ---
>>>>>  tools/testing/selftests/resctrl/cat_test.c    |  8 -------
>>>>>  .../testing/selftests/resctrl/resctrl_tests.c | 24 +++++++++++++++++++
>>>>>  tools/testing/selftests/resctrl/resctrl_val.c | 22 ++++++++---------
>>>>>  3 files changed, 34 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>>>>> index 97b87285ab2a..224ba8544d8a 100644
>>>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>>>> @@ -167,12 +167,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>>>>>  		strcpy(param.filename, RESULT_FILE_NAME1);
>>>>>  		param.num_of_runs = 0;
>>>>>  		param.cpu_no = sibling_cpu_no;
>>>>> -	} else {
>>>>> -		ret = signal_handler_register();
>>>>> -		if (ret) {
>>>>> -			kill(bm_pid, SIGKILL);
>>>>> -			goto out;
>>>>> -		}
>>>>>  	}
>>>>>  
>>>>>  	remove(param.filename);
>>>>> @@ -209,10 +203,8 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>>>>>  		}
>>>>>  		close(pipefd[0]);
>>>>>  		kill(bm_pid, SIGKILL);
>>>>> -		signal_handler_unregister();
>>>>>  	}
>>>>>  
>>>>> -out:
>>>>>  	cat_test_cleanup();
>>>>>  
>>>>>  	return ret;
>>>>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>>>>> index 823672a20a43..3d66fbdc2df3 100644
>>>>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>>>>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>>>>> @@ -73,8 +73,13 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>>>>>  
>>>>>  	ksft_print_msg("Starting MBM BW change ...\n");
>>>>>  
>>>>> +	res = signal_handler_register();
>>>>> +	if (res)
>>>>> +		return;
>>>>> +
>>>>>  	res = mount_resctrlfs();
>>>>>  	if (res) {
>>>>> +		signal_handler_unregister();
>>>>>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>>>>>  		return;
>>>>>  	}
>>>>> @@ -91,6 +96,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>>>>>  
>>>>>  umount:
>>>>>  	umount_resctrlfs();
>>>>> +	signal_handler_unregister();
>>>>>  }
>>>>>  
>>>>>  static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>>>> @@ -99,8 +105,13 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>>>>  
>>>>>  	ksft_print_msg("Starting MBA Schemata change ...\n");
>>>>>  
>>>>> +	res = signal_handler_register();
>>>>> +	if (res)
>>>>> +		return;
>>>>> +
>>>>>  	res = mount_resctrlfs();
>>>>>  	if (res) {
>>>>> +		signal_handler_unregister();
>>>>>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>>>>>  		return;
>>>>>  	}
>>>>> @@ -115,6 +126,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>>>>  
>>>>>  umount:
>>>>>  	umount_resctrlfs();
>>>>> +	signal_handler_unregister();
>>>>>  }
>>>>>  
>>>>
>>>> This adds more duplicated code for every test. Have you considered a
>>>> single test setup function that can be used to mount resctrl FS and setup
>>>> the signal handler paired with a single test teardown function?
>>>
>>> Yes. Consolidating all these is among my not-yet submitted patches.
>>> I just had to do a backport-friendly Fixes patch first for this.
>>>
>>
>> Could you please help me understand how the duplicate calls are more
>> backport friendly?
> 
> Hi,
> 
> It's simply because the refactoring that has to be done to be able to 
> introduce the generalized test framework is much more invasive and far 
> reaching than this patch. Essentially, all the call signatures of the test 
> functions need to match and the feature checks need to be done in new per 
> test functions too. This is the diffstat of those changes alone:
> 
>  tools/testing/selftests/resctrl/cat_test.c      |  21 +++--
>  tools/testing/selftests/resctrl/cmt_test.c      |  26 +++--
>  tools/testing/selftests/resctrl/mba_test.c      |  20 +++-
>  tools/testing/selftests/resctrl/mbm_test.c      |  20 +++-
>  tools/testing/selftests/resctrl/resctrl.h       |  43 ++++++++-
>  tools/testing/selftests/resctrl/resctrl_tests.c | 220 +++++++++++++++----------------------------
>  tools/testing/selftests/resctrl/resctrlfs.c     |   5 +
> 
> (tools/testing/selftests/resctrl/resctrl_tests.c --- part would 
> be slightly less if I'd reorder this patch but that only 24 lines off as 
> per diffstat of this patch).
> 
> But that's not all.... To be able to push the generalized test framework 
> to stable, you need to also count in the benchmark cmd changes which 
> worked towards making the call signatures identical. So here's the 
> diffstat for that series for quick reference:
> 
>  tools/testing/selftests/resctrl/cache.c       |   5 +-
>  tools/testing/selftests/resctrl/cat_test.c    |  13 +--
>  tools/testing/selftests/resctrl/cmt_test.c    |  34 ++++--
>  tools/testing/selftests/resctrl/mba_test.c    |   4 +-
>  tools/testing/selftests/resctrl/mbm_test.c    |   7 +-
>  tools/testing/selftests/resctrl/resctrl.h     |  16 +--
>  .../testing/selftests/resctrl/resctrl_tests.c | 100 ++++++++----------
>  tools/testing/selftests/resctrl/resctrl_val.c |  10 +-
> 
> That's ~500 lines changed vs ~50 so it's a magnitude worse and much less 
> localized.
> 
> And rest assured, I did not like introducing the duplicated calls any more 
> than you do (I did not write the generalized test framework for nothing, 
> after all) but the way taken in this patch seemed the most reasonable 
> option under these circumstances.
> 

hmmm ... I did not expect that a total refactoring would be needed.

I was thinking about a change from this:


	testX(...) 
	{
	
		res = signal_handler_register();
		/* error handling */
		res = mount_resctrlfs();
		/* error handling */
		
		/* test */

		unmount_resctrlfs();
		signal_handler_register();

	}


to this:


	int test_setup(...)
	{
		res = signal_handler_register();
		/* error handling */
		res = mount_resctrlfs();
		/* error handling */
	}


	void test_cleanup(...)
	{
		unmount_resctrlfs();
		signal_handler_register();
	}


	testX(...)
	{

		res = test_setup(..);
		/* error handling */

		/* test */

		test_cleanup();
	}

I expect this to also support the bigger refactoring.

Reinette
