Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12347CB14D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 19:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjJPR1T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjJPR1S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 13:27:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADD3A2;
        Mon, 16 Oct 2023 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697477237; x=1729013237;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FLb/iaBsDgmtPKRnNCTcAPNw9W60fhMt+PB23hULpi8=;
  b=ifJCNV9sc7WAHA2pWJFUCpZ/Bz26wgbWBBHNAbaOA/hAip9A4Yk9rAdz
   Yi7Rf9LxUwOcgxEDEv6ckOGB1cOSQAESAX3xSIX9tN/rwTiWQcr/dDpPV
   NGpINEhvOivpVfPRcOnMzBOHmvMkkTnfn22w6KNC6eX76txSiFQxueNdc
   noMkAbiINVuUkDEZeOJqI4JstVJ5JcLzKAcbJMJnnaTshD7DXmr4RbacZ
   7a8jT1w4z1Hzmaj7HV8E6QtT2VxbSv0t2ReHZrg1naVBouagS1s2W3TND
   PK9LZDbxLorhpYKueSsOwhAaGZDvXBgYDsNIaccg4rSesRMFThaXk9mDf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="7163216"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="7163216"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:27:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="821647830"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="821647830"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 10:27:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 10:27:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 10:27:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 10:27:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 10:27:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfC3NNC6297nqqedtvpjKoTZCCe+K7a3HOO+lEr4/2UFVF2WyOKrZLqgopgKtpzHKWAhEq5j1X6WE/YD9gieLk6FftQ8IRfN29/iEtc1kksNuqFhfHWOjpuIsEp0bp8MggWoBTyucoLx0Yr3efiC/7SMEiZit7vBaElq7R5aJo96JAWaSocRH6T5bVx5G5sfipj5FFgdQUgkYUYflx5IoZ/Ce9FxZ7WaupstoV1U2N+eS7KAgvB1oyYA+Juwr8j6OADoD6NcNJKHpojM9qhrIzKEMD8wOV2wrQ5bm1jZWCi4MKNXopGQ2/BdZMJ90wUYoGw4uy7UkkPF3EbZst5zWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzkO46YvHGWdujnr43Gw5LuPBto2TBqZe84AnZwXrPo=;
 b=On+fGsvP4rMyDY3wMrf+tRtk5BuPzbrK5BffBU/UuF2xtkCT/JfcK48k5fq+oTnU2eYQes7kwM2uy0ExR+2UQ5JABrKp1nuX2zcTYlf3gxVct/lnKSa5ERiQCdQPXHFVf40yIofzUGsPcHLn7SFFrtxWMyX8RSIfBYrEQWhCHA13RpU7+q9JE0qiE/zqHnimyJQtj8evRj9TVU4k8/o2lDCghv9Eww8jDl4IMklwAy+nlpSrwSHo6V98XGCp69TFArQxwKjicvsIpLoVIv23RbEHUBjpGtt0QzqPNRoFKG/qSW+mJ35HRvRXVQYKOiw5rLmoCUmKmOj0RHWf7LsI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BL1PR11MB6027.namprd11.prod.outlook.com (2603:10b6:208:392::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 17:27:11 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::e420:d67c:ef82:cb64]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::e420:d67c:ef82:cb64%4]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 17:27:11 +0000
Message-ID: <e82fc689-5cc3-d799-6e5f-a9e4ac98e26f@intel.com>
Date:   Mon, 16 Oct 2023 19:27:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH V9 3/7] cpufreq: amd-pstate: Enable amd-pstate
 preferred core supporting.
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     "Huang, Ray" <Ray.Huang@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "Oleksandr Natalenko" <oleksandr@natalenko.name>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
References: <20231013033118.3759311-1-li.meng@amd.com>
 <20231013033118.3759311-4-li.meng@amd.com>
 <20231013160128.GB36211@noisy.programming.kicks-ass.net>
 <DM4PR12MB6351E2E9504B57BD40DAE985F7D7A@DM4PR12MB6351.namprd12.prod.outlook.com>
 <20231016105845.GA33217@noisy.programming.kicks-ass.net>
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20231016105845.GA33217@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::27) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|BL1PR11MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 86243206-5069-4e18-7e11-08dbce6d2179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGbw8wvQvXOHLgqb58ufbsl4j2pxsxmCL8VS1lEV+DdTq6tlFqGd8rvihsctrGOsz3vKE7VYvJT4NBaVJjuEYcL30We1z5QsE1sVixs+/NgQzgrTOEESDLfk4ruTaNNFKEH6Phn446utGpwXva7j2EOpWzbGt/P+cOZqT7gz7j6EVV+/XAJOmz4r22RZe9wjb0Gq1fy1sLzuTa6sY0Wnzivaj8AK1TFXRrzbuYjzaim385HlpWhO1MG43ODEnw+T8CPmMYk+Cp0vqlB2Wg6rnaMxdoiBeP3Ebt7OynHOZXZJ3Eube9j1EO3Z9cEUvpx5NovLmEHFBwL2agRkZ4A3QC0XbBmKG/bhtuF+kjuzVhIBv0NZalfIAMh4LEtPjbDm2ve+TCqqFhe7YUOv04xDGFXYin/JX0FfrIi2HaANc3leCCcZE+lse7FhBhwhotJdAmS2YyimsI7WrkbfTQbN/ly9sTaAK19jUvehpXyITuo0ZVHaEZwTUv+WBUAQEGfucAnKrgsPQFn4MnQ38xmU56/byAnfBpLS3kcqRjCcxb51vsiGgrsC5nzz5nzc7bYBo0+D90/cWjmFGL8i1m0Zs/CwO8PEjSUKQS7xxkVRevSglrgEWI9PCg4AGyktqBF/CKJXmNv+e1Xv2O0iD5W7BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(316002)(66476007)(66556008)(54906003)(110136005)(66946007)(2906002)(36756003)(38100700002)(7416002)(86362001)(31696002)(82960400001)(41300700001)(4326008)(8936002)(5660300002)(8676002)(6512007)(2616005)(6666004)(6506007)(53546011)(26005)(31686004)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qzl1VE00UzFKeXRtdU00L3J3MjduK0gvTTlpSm5aL1plL2VmTjY1U1lISHQ5?=
 =?utf-8?B?NjFadDN4aWRYQUNQQ3VwRzkycEVaS3lZWjExUHhrWmtIaTlLSjEyRzJRcjRi?=
 =?utf-8?B?akF2dkhNajc5aDVOM2pPdU5aN25kaGJPMGwvc0FqWTJZUjRIbG15Y3I0aTlE?=
 =?utf-8?B?bFd1Z0orcFB0d0UwTEVKdExJc1lBRVo2ZGJ6VFQySi9GRlJvZEN1ZUZYdS9P?=
 =?utf-8?B?cjlSUkg2WEsyWTBRNlZzUEZhWWxEa0dxRkZNSXhmcjd2TEQzdkJIWVJRVzA3?=
 =?utf-8?B?R3NSNno1NFJPVlgwNTcwaEF0ZVREeldVcktSL2xOSDNpMEdPQm9Cc2t5U0pZ?=
 =?utf-8?B?Rk5nczE4STJERm12N2YydDMrTWxKNzVzUlF6Wnh3Mk5iclEwc25La01oQ0Rj?=
 =?utf-8?B?cUJ1QktEb0NxM0E4ekh6dlhMMGczUkxvUkRBRTF6Z3VrYThMdkE0YW9WWWJm?=
 =?utf-8?B?dEV0K0ZaV3F4dHo1ZzFvU3VVblpUQmRBNEtzT2tweVRaQytWU09qZ1poak5t?=
 =?utf-8?B?aGNSczErOVI3elk2dmdiZzluQWtHb1hlelVhYTI5WXVTT25weEdrNThHTnhV?=
 =?utf-8?B?RjBoRE1oTCswZENiaW92aFkxRm1SdmtzejRXNjdRZCsyeXRFd1E5WktsS2dG?=
 =?utf-8?B?OFhoamFpenpwaTVKKzBmMi9iRUZRTzBvNlkxclkzejNLRm4wYi9QN2labldr?=
 =?utf-8?B?dE1WTEgyMWNlWUw0Z2prTzhZdnVXR0lFMnhGRXp4TFdadVltaitrZHJCVlBo?=
 =?utf-8?B?K1hoRzBwT0h4bGp5MUR5TVhNb205TVhxc0tTRWZUSHZYUUNtdVdwSzR4SUEx?=
 =?utf-8?B?blBCQk1tL3dtTDVaMk9CclhhRUdaN0x4OCt4em84d3ZnczREd2ZMYjE3SW9h?=
 =?utf-8?B?ZGdwMlZjdWF3TE5hQXlPYVVlR294b3Q2M0Q2Vm43WFF4bHl6YUVLWmY4K292?=
 =?utf-8?B?NllFWXRUR2F5OFJ1ZTg3OWo1RTF1YTkxQWFnbnNDOE1odEpuWHc2WHlpLzVr?=
 =?utf-8?B?bDdPQlNTS2hZVGdKdjNrZ3RVTVQ5bWxZUElCampydnAyWlVqRXlqUFpBM3hh?=
 =?utf-8?B?ODRPckN2NVdyazZDMlJ6T0QwUFhWRGpzelA0Q2h0WDRodndLemZXNHJQM2lK?=
 =?utf-8?B?Y1ptNW9BLytGZEplTHFqRmp4YTIwZXZoM1VzemNWa2NMdDdTenE2OWdDNFM1?=
 =?utf-8?B?eW5KWU9BbzRlYU1WL29JbUZPL1R4enVzN0dpSG4zYUF5VEpBM3JmeHBrc093?=
 =?utf-8?B?RTV6OFowTDRHZDE5NDNpOHpLZHUreHZIZkprU3Fsem9sWHM4QVJyZkVlUHZ4?=
 =?utf-8?B?SXFwMEVESWQrVmJ0ajg2VUt1ZDhWMjE5TDFzSDMyNm5sM0E1dVhaaDJvK3lG?=
 =?utf-8?B?a1d2dGx4NFdIUEdWc1Bwa3RHNFZrMmlWbEpVNWxIWHIvaG96Vm9BQ3hqenBP?=
 =?utf-8?B?QzNGYkRuc2w1QktNajN5M1B1Qjh1bjY4R0EraWwyY0liNklyQnpyWndHVG5k?=
 =?utf-8?B?MXdEeW5VUFo3Nm5hNndvMFZHT0ZWeUZPQm5kUzZSMTNUK2JBZlBCRjh1dnFC?=
 =?utf-8?B?ZFd4WC9hNTU2M09SMTVhdjVVM29WZDlMQlpkRGYxd3N2SlJSc1RYbnhWR1F4?=
 =?utf-8?B?Q0s1a3ZOL3IzVEZicUlMRjFQK05oMDBUQ3BZWlNNbE9CSFVUcHpXWHJPVGdW?=
 =?utf-8?B?QzZUc1RzMWY3K1RXS0Zmam1ySU4yQWpoU1NGTDFIcmwrRmxwZ3dOQzFzenIz?=
 =?utf-8?B?eVBFRy9FbUlVTUhKZnRxdWFuWlZhNHJtRW85RWFpVWpMUUgrL1h6eWtRVWZK?=
 =?utf-8?B?QWNtY3AxSkFvVGJyWlFLRXpndnlLZ1o5cnZhZzlNU1RrbE5ZUWJ5cjV0bUtD?=
 =?utf-8?B?SXlEVzhGYzFVLzJzcm04blFmMENHUk5FSUY1RWRGYkQ0K0p4NnpyQU5hRmZ6?=
 =?utf-8?B?cDhSaG90YitoY2xwdzFBTFJoTzFYMHFRaU1nVlo0VzFtZTZzd2ZhUzBpYUN3?=
 =?utf-8?B?d0dzdHZKOEhhN3VDOWVrOTg1UXYxQTVRUnhnQ052VnNZNlZOdmNITXJ4bDRl?=
 =?utf-8?B?TlVJWUNLdTVwd05uTmQzb0VUYmFJYlIvSnlZWXV5ckRMaWhJcDg0TWQxOFJs?=
 =?utf-8?B?NTYvc2plT3hHbnBDZWs1VkdZV0hlMUNCY3RhQmZDTkx6Y3dZMlNndEpDTHpU?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86243206-5069-4e18-7e11-08dbce6d2179
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 17:27:11.4062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eTYn9fFAa7Ho1BShqUDYB/7sZLJANQzse8ADU1C/bDdw4+QUTTl3He4U17EyWxd+V+iGdqwUlsbyvoZplgtwG5wBkrkA33ocJn5UtcJaSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6027
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/2023 12:58 PM, Peter Zijlstra wrote:
> On Mon, Oct 16, 2023 at 06:20:53AM +0000, Meng, Li (Jassmine) wrote:
>>>> +static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata) {
>>>> +     int ret, prio;
>>>> +     u32 highest_perf;
>>>> +     static u32 max_highest_perf = 0, min_highest_perf = U32_MAX;
>>> What serializes these things?
>>>
>>> Also, *why* are you using u32 here, what's wrong with something like:
>>>
>>>          int max_hp = INT_MIN, min_hp = INT_MAX;
>>>
>> [Meng, Li (Jassmine)]
>> We use ITMT architecture to utilize preferred core features.
>> Therefore, we need to try to be consistent with Intel's implementation
>> as much as possible.  For details, please refer to the
>> intel_pstate_set_itmt_prio function in file intel_pstate.c. (Line 355)
>>
>> I think using the data type of u32 is consistent with the data
>> structures of cppc_perf_ctrls and amd_cpudata etc.
> Rafael, should we fix intel_pstate too?

Srinivas should be more familiar with this code than I am, so adding him.


> The point is, that sched_asym_prefer(), the final consumer of these
> values uses int and thus an explicitly signed compare.
>
> Using u32 and U32_MAX anywhere near the setting the priority makes
> absolutely no sense.
>
> If you were to have the high bit set, things do not behave as expected.

Right, but in practice these values are always between 0 and 255 
inclusive AFAICS.

It would have been better to use u8 I suppose.


> Also, same question as to the amd folks; what serializes those static
> variables?

That's a good one.


