Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EBD7AF272
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 20:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjIZSJu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 14:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbjIZSJn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 14:09:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A906DE;
        Tue, 26 Sep 2023 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695751776; x=1727287776;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9keuvwCFiGjObWXw0yjQgNs3dV60WnyT+k3ujQ1CXU8=;
  b=L3hJFRxwQnIyMkDrHnL2zf4d9fU+CJ79JAuFsZdjyvQ1JUD5pbyIwxiV
   1/lFv4EISP8VA5H1csiaR/MGduhoEWpVzB77Fo0VXjwuZqVh3dy65v+4k
   i7nYIfrNfq5EF1T+FKNSmqA20x4uoeWNiRU6h9nfkUOY4Nuq0jdBDNE7d
   rCAZigMV3rYe4zoxxWuYzfNLrU0aqgWNqO3TQb48sclS8VDq+554+scKN
   KztShiHtg6nbqn8+Ybgm5oI8gDK1H4YAPPr/eogF6feNCmzEIXsVfBAnW
   Z5hsH+qlYdIsRY7uYoFr+f5lo8rf2aXYM8ez/w8RZS3t3eARM6WB7kbIW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378911592"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378911592"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="778223582"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="778223582"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 11:09:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 11:09:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 11:09:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 11:09:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 11:09:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEe4awsWqkcwVCnf9ovFchNcKersjBMIOJX1AVqYnj+WRKK8jY9TldEwbTCAx9gdwFLxvJrgg5zR/8oLrFTwP2o+MKNnA40f56qKLkvnzeWh5K8pYLnF8vCd5C2XK8rkMxfznd5TFvJymMhSHYGgS+00UhbhHzw99kMqlohArrbO7OCgAIQLLh3MaqZJv5ZljuUYAUuPD0Zi0xhu2X7JvE972Pyyi4GEFSTRa83Wy0oSulHTZVLH2UZB6fLyQZL8xISM8BFbfAIdIMSkx5l40O1Frf3IKwxRVl6eGpi87rxLBORVe56I4l7IOjOdAwH9oWTUVNcWBUIo4Uka3rW0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrkVJT663zUFInwgh5K0McA4uGU0hJSAal1+PxE4rws=;
 b=CzR1w26C1Y26639AFW78wwXTrKGkBeIofYy9KQFCYMlUgfCOvLluy/N9Hrwiohl413B7+6z1Rq1zuS/PoeFGyNOO0RhweKdBm1OI1S/PJaqc6DG+fV0S1TwtMiTsN/m++xcV0jrlG1wJ/cmdikrmT6pP5wfhUcs716xGTkB7PeP4/mShsC33Y7pa9GwXY3La69Nbc/F7OErzu/3khBYxQhxuVgmZWhJYyB3Jl92TGO4zs7hDhSOT0UcNuWU8FhkLAFm3PgUGBXdgkqWoyiZVW564r7EQhDUTab1Vzt2b77KfRTyNeEBnH5LAATI1dNvny0DKL/zoyHVedi/Rc1V8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5417.namprd11.prod.outlook.com (2603:10b6:408:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 18:09:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 18:09:30 +0000
Message-ID: <3d5554d7-5909-b851-bbd4-6b58a79b7cbd@intel.com>
Date:   Tue, 26 Sep 2023 11:09:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 0/8] selftests/resctrl: Rework benchmark command
 handling
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:303:b9::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab7f07c-c4a5-4235-506d-08dbbebbba74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMsknkQj/3ABUbw4z7NTMT4SPUh2T0bxG0Putxu+3Pp3hVyo0mAI6HNVsLuEPxBpVPaUAl11uVdxQT7fhuU+TPf3yzWOZKa0zgDdgcKaXK90E+UkAjAfpnqJznHqDA1xhqAod7WHLY3t4/Qw0/Z7uW8vEZ0jQs3sgkY5sVzqqfGZqnumqOBGGLbCy/jrJi9547/m7/JhkQIdf2WVBd+sdzpDBkMY0E5bmVuIBZf61u3x5DcfLSd3k6gmhOiVOOcXRW64dscHpWqTUEg02lSyTwEfphu0pSs+yWTTJF8begpWwy/Ep8dmG/tdVJxKkSRMyAdKucZAplgKR238FbZj7NToo+6mSJPMqqEfxHP+HI2GOQp9Oeoz2C0hYjphmTn03ZrgynmKDRAOnGyG+fKshPprvCo4WCY2EN1V4DMi8+QBvzdseG1JFy9088GHO/kJyioE9FatbaU6LGsMFk/bb/YFo3n5nXMUNzfKMjNxA9xceo47EvJExFrIDveMk4ZXZyrLDDsyPyz5oG5sdxlU8vJlu9bs+23ZSujZGlT76R3wxSTSUkwYsb5hdy4jgQEEXESpKfsZ0cIiAa0G1ZW+l8sGc8t/SZD8JmueNi3TRH69aDotY/BqDPF+NIkGndp6bTn2gLc/82Ck+YDXXSQ2qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(6486002)(53546011)(6506007)(6666004)(5660300002)(478600001)(2616005)(2906002)(4326008)(44832011)(83380400001)(26005)(6512007)(8936002)(66946007)(6636002)(54906003)(66476007)(316002)(8676002)(66556008)(41300700001)(110136005)(36756003)(86362001)(82960400001)(31696002)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzVSdkVQaHpINnNubGEwSFdPbEpIb1FTNVJJOXJyc1RWamhGaEQwZDVsVXNt?=
 =?utf-8?B?aExlRGp6VDlvaGhBMnA0WGh5QWU1aEUybWlxYTRwblRsemxVb0MxREFtNEpm?=
 =?utf-8?B?S1BRbVQrQjFGUU44WWR0LzdPVktLbkxOcCtqTHVHTlRGTjJ0VGZxOGxJUjdK?=
 =?utf-8?B?T3B2N0NyM0VYZmxGQ1hETVZZTDNiN250ZUdGdzB1U3BJeVk4amgxM2RMK1Bi?=
 =?utf-8?B?K3dHbDZhcDNCWXp4dEhMMDNXYWowOHM5UXNQZFNBYWpKS0dkZW9UQ2ZQQW53?=
 =?utf-8?B?UWQ1SUZZbXphdndRck5xWGpUMVVmbmtlTTRFQ1F6YnVmRDNnQ0VNR3NmWjZo?=
 =?utf-8?B?eTNFNGVUaDFhK2dBKzRTWFZ6dTlqMmtlcnR6SWtTSWpIaG5WOUVyTWJYVTdh?=
 =?utf-8?B?V0pKenAzZzdCalNZQVJkRy9icnU1RWFWSG5QL00xOWI1WUtqR1E1VlIvQm1k?=
 =?utf-8?B?M2VPNTAvdzJ1V1prYlQ0Z1FzZHZJSytMN1EvNVlMc1dNNUI0d1Q5bkJGZlY1?=
 =?utf-8?B?UTRTSDljUjRYRDlKV2NobjVnK2tnaWY1MFczOFd6U1pvLzZHTG45Vlp6Y1Zs?=
 =?utf-8?B?RFFsell3dklLYTVOKzFCS1RmbFFXWkdHQVU4c21JdTA1eXA2REZzbzJmREpx?=
 =?utf-8?B?akRWV1dhQ3p4a0NJeUk3cVh4eXU5RE9RcjJYTGxERG56OWduYkdDcUc2NjNB?=
 =?utf-8?B?TW9OSzQySjNwdG5pTXA2OUlZeWNtQkdhRDEwMWZQWjlpTXorYVdwR2ZDTEpw?=
 =?utf-8?B?WHhCdTBpVFQ3RGY2SHE5MzB1N3kwVXZGOUFSVU9ITUJhNGl5ZVVkRUI4Z0xG?=
 =?utf-8?B?VDNLcEVIRk91aVdybzh2djA2em9XTW1ZT2U2d2tlLzR3UmhjY3RuL3QvcE1S?=
 =?utf-8?B?NzVSVkVSQXptSXUwMitVVXNpOHhnM2xqV085dExoQmZFN0dFYlhLSzFBNTZP?=
 =?utf-8?B?MnZ1YVY5UHkxejVlYTcvT1Y4LzNUVUVlUG5CNFpMNUZNb3U1MXFjREZsbjB6?=
 =?utf-8?B?T09CWDZPVGVrL3F3TDQ3WGovVGRjNmN2VU5NQmxpY3VNWDNwMVNCRlY1bXNY?=
 =?utf-8?B?R2MwTHdpUGNhS1gweGVrUDhqVHh0cXl2ckpKN2RnUis1ZnhmNmpVR05FV3BQ?=
 =?utf-8?B?aHZ6V244cmZYeER4NlVUVko5R2QwK1AzZFhTV0xiREo2dSsvbXViMjVSYjRC?=
 =?utf-8?B?Z1l6RENzeDN4L0dvMnJPbWNqYUQ0cFM3NTdlZ1ViTU1NVnZCT0ZrR3JNUWlk?=
 =?utf-8?B?UXhzVU81aTFhcW5kZWlGc2N6eGthbFd6bnFiVmtVLzJySnZ4cm5WeGlTbEJ3?=
 =?utf-8?B?cTUvUGdkd1JlTitSVEI2b2M4UENNYk4vanVVWG1oZXUzMVEyZGJhek9BS3VS?=
 =?utf-8?B?eENGL3pKTlJMUGtLMFNrbUNxb1NrcmUvaXhVYUF0MGlJSGJIREMrK09sRjYw?=
 =?utf-8?B?dDM3MXZMMlhUNU4wQWFmNlNKa0NWTkVpckw5ZTFvRGJ4d2p2VWw2YkxaQUx1?=
 =?utf-8?B?VjZCcEJydVY0cmV1N21uQktpNm0yMjk0NkcvZlVDMDZmemgyWHNHaHBDL0xi?=
 =?utf-8?B?TG1ITWMyWllUT3ZralZ0UTBHcnhPQnY4aWVyYzhETXVGZG9kelNUTzZVTlJS?=
 =?utf-8?B?NHdNN1o1Uys1QjVrem1TalU4R0oyQlY2Qm9LOFFmSnVCN3FJQ0JRckVqalZR?=
 =?utf-8?B?TnpSd2xQdDY1SjY1bFNrMDcyRVhtejFQbEhld1VyTmZXWEhSRzBuNk1Vcm5Y?=
 =?utf-8?B?NW52d1hlUGczUDYyVGVzYVF6akhCVWNPK0VFaE5MQ2JCSDQ4M3FwMUNiMlZ3?=
 =?utf-8?B?M29sYkxzMm9GempmTGRKcWhGa2Z4TWJkQ0ZZbk9LWVpvUHBUZXNRZWZXMUUx?=
 =?utf-8?B?bmxVQkM1WEVvTzFXVFZkTzNXSHBjeFd6VCtkWUFIaGtBYzQwZGV5bW5sam5o?=
 =?utf-8?B?YVZsYUd3WFVjK3E2RkZBMWtHTVZyMnVBaW1kSjVyNDhhdk1PbHNBdGd1TFpX?=
 =?utf-8?B?UmxpVHp3YUp5Smp5YTlsWWJ2bWdsb1p1WlFTM3FKQURnUG5zeFFTQWlDQWIy?=
 =?utf-8?B?Rkdld21NaFJEN1lqSzBFaGNqUk9oWWZQOTNRNkhMdG42cDMxbTlUUXVhbkd6?=
 =?utf-8?B?a1RaMnBEcU0zWm5JczFEdEIybGtYWERBd2kzYXhUZXY4RENwTnVRU25EM1Iw?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab7f07c-c4a5-4235-506d-08dbbebbba74
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 18:09:30.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zxma3/Qxy7KUO4BijbtctREjx55CwRNRM3VDqYy+BvMi0CEXiqcNC//5v0GZpH9plaiQJRAG4xZOlam6XmE3KiAcY1yINfcJzBKq6krvQFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5417
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

Could you please consider this series for inclusion?

Thank you very much

Reinette

On 9/4/2023 2:53 AM, Ilpo Järvinen wrote:
> The benchmark command handling (-b) in resctrl selftests is overly
> complicated code. This series turns the benchmark command immutable to
> preserve it for all selftests and improves benchmark command related
> error handling.
> 
> This series also ends up removing the strcpy() calls which were pointed
> out earlier.
> 
> v5:
> - Fix another off-by-one error
> - Reorder local var declarations in main() to follow rev. xmas tree
> 
> v4:
> - Correct off-by-one error in -b processing
> - Reordered code in main() to make freeing span_str simpler (in new patch)
> - Use consistent style for const char * const *
> 
> v3:
> - Removed DEFAULT_SPAN_STR for real and the duplicated copy of defines
>   that made to v2 likely due to my incorrect conflict resolutions
> 
> v2:
> - Added argument length check into patch 1/7
> - Updated also -b line in help message.
> - Document -b argument related "algorithm"
> - Use asprintf() to convert defined constant int to string
> - Improved changelog texts
> - Added \n to ksft_exit_fail_msg() call messages.
> - Print DEFAULT_SPAN with %u instead of %zu to avoid need to cast it
> 
> Ilpo Järvinen (8):
>   selftests/resctrl: Ensure the benchmark commands fits to its array
>   selftests/resctrl: Correct benchmark command help
>   selftests/resctrl: Remove bw_report and bm_type from main()
>   selftests/resctrl: Simplify span lifetime
>   selftests/resctrl: Reorder resctrl FS prep code and benchmark_cmd init
>   selftests/resctrl: Make benchmark command const and build it with
>     pointers
>   selftests/resctrl: Remove ben_count variable
>   selftests/resctrl: Cleanup benchmark argument parsing
> 
>  tools/testing/selftests/resctrl/cache.c       |   5 +-
>  tools/testing/selftests/resctrl/cat_test.c    |  13 +--
>  tools/testing/selftests/resctrl/cmt_test.c    |  34 ++++--
>  tools/testing/selftests/resctrl/mba_test.c    |   4 +-
>  tools/testing/selftests/resctrl/mbm_test.c    |   7 +-
>  tools/testing/selftests/resctrl/resctrl.h     |  16 +--
>  .../testing/selftests/resctrl/resctrl_tests.c | 100 ++++++++----------
>  tools/testing/selftests/resctrl/resctrl_val.c |  10 +-
>  8 files changed, 104 insertions(+), 85 deletions(-)
> 
