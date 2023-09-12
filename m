Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA90A79DB95
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 00:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjILWGp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 18:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjILWGo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 18:06:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E1710DF;
        Tue, 12 Sep 2023 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694556400; x=1726092400;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5FaLV5UUrfwMy6QoqnWsm1hDDhXmlv5vZ26wJXcQOH0=;
  b=a0EzO46Z9ohq3c2/ZyHZ/BUMT1ndnyHO5s+WgpMWb7yuofhR03zYR6VU
   7be7rUdrnSj/pMB2SE/hNF36CuLRHjmXZwBEkwRlRD6oWKnON3qV6iyq6
   QtHge8dWjzNdZ37l5RJY+x4M3vkWMDVS+rIR1hlSeR0c8+kElAQ8TWFbX
   //5iPshvJxRPD1OMZgISVUpK0MBM7rFrkfrNlQp8cyemCAOrhBDWVeg4S
   bJOPxfZawXU6I8jkzAOuyWS/KuhAOqppaYkNjYDSHO4Op343mQ5FZpriu
   o4N/Spn6QmYzE0SEJx0AnMW+NMyWNsw+Om3+Y+pHR0Cbz+s0qB1qa2Sss
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="381203045"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="381203045"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 15:06:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867525410"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="867525410"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 15:06:22 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 15:06:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 15:06:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 15:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liJIaSPEaFIoewLnWCL5oItP6Hjm1LcoXr3xDfAiGXhOqvIXHrWylOCXWPj1YxQOQTINzcdcHKzW1OnJA9jSIbCv3WjXSCykO17BqmpvzH2j/RG3OEDFdbSbpmEHR5XlR+mRr5wo3RAxe9InIr+4Iig8dOCDQU3Syspuve13puYpnQ8Jp0lm24kihSwOGHYcW/BREbqH473EzHcR57W8ttpBuVSa1rEGKQwjkp21SuLejvbv42tYQYJ+jo6iZ0uT6Kzwc7WHLV8Lrnxd2YBZwLEhs4T+H/82Rw97ndFDNbY+klyzowMVx1SZz62vBZqiTPvkVAYPtjVanyXDMqYp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dag4uOsupye0C6qkNXSFSxIbBsHfBSPaLoQecv5mF0=;
 b=S8tkzUdywX0rQOvbU4CZjt7pt6x1ulMurQEIcs4I7S6Go6OZJf326WMX2AJE48s8SEYByZ/KPGrGqQjGIPtJAXP635964lQ8NXVYOkgGqX8RTBLYu6NovWpOUo0uvhQzsPjgAFg5EZ332gb3LSrpmSMDHWrflJQe0uLM8Q6a0aveyrDIn2E4eEU4pzkhvO1ATuNkshzbkpK8oVznPjLEDvI71JVIXx3F8ImuG04NQucaBGeUKSdgqhQ94+aWtznbyyaXYaSyMBEfr8hsJTu0kq6jwVA31S8WS/Top49hxgSRXAFqTkW+0eNBbjuKQLPMMiyg1wPV2asSnBLNe9ifuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6516.namprd11.prod.outlook.com (2603:10b6:208:3a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 22:06:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 22:06:20 +0000
Message-ID: <4176a620-4cec-5d57-42a3-a15c0fe3eb73@intel.com>
Date:   Tue, 12 Sep 2023 15:06:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 1/5] selftests/resctrl: Extend signal handler coverage to
 unmount on receiving signal
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
 <20230911111930.16088-2-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230911111930.16088-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c88d1a-6b87-4005-d1d6-08dbb3dc7ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ci8n1gj8RlguUZT6L7pQXS6GCSmIamC0WOGfJStBpsIsEaslVWvp5cvxRLYOaXl+sPeOBwFITr0jOhcYoS9lrWwkioX9rGW4K05q0FU6ZlgTnm9dbCT++YFsdCHlMcx6jq+4eXlaI1yKToiq6OXP20iw7XKWs9ceeA0MqwXkFjgfRAw5Jc7qEDQSGV0aZDMdQS+UUedes3ku3ILgUbck5FGQlvUMZ6ErtTZxnLB3UZyMqsgEDBCf2mAJ4z5XYh6RU1ywo+TybTkczgAsLOn8OSKemd3cg8QYeetUy0xkrRedXdtjQPXSRrhMrYEVOl2ytk3KiVothiRicTupD0H6SxA0nM7yqmrDI42ZU6NPQftTH7f6iXAv3tbZ7FH07NYVzWfjCOPd8KW9z1WKAHEJC8cTdOShwxhG9Xv4udbaXDsLahC4/30rk1CBsJqbtBHJd2/WMjfljXhwxp44uhnDQzRvFPFfcc+EZY82Y9Yrnu0z2CpQ45746l5SJm/2Twgc6cYsxskQ/bV3V9VvzIIoGp0jyC3YCSLfSW/J0OAXjTmwv4mCjCcrdeld+bBakj2OlPSFlWuVT+v/mhClJZUXAQT1liVBSbPuok/5iZB0Dsb1Twrhofv9HOqVGftOZmNZZ5DRiMXhBO/zKF+0RoTOKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199024)(186009)(1800799009)(110136005)(31686004)(53546011)(6506007)(6666004)(6486002)(31696002)(82960400001)(38100700002)(86362001)(36756003)(26005)(2906002)(66574015)(6512007)(83380400001)(478600001)(2616005)(8676002)(4326008)(8936002)(41300700001)(5660300002)(66476007)(66946007)(44832011)(316002)(6636002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG1idXVyVDkzbmkzaWJiV1dNbElTbVdRSUhFM2lSeEJxR3RqMEJTRDlZNUxj?=
 =?utf-8?B?bjZlcXV6QzBBdDRYZ0l0NmZSK0kwRVpRakw2YWRGd0RlNFNBKzFvcWRpMGZD?=
 =?utf-8?B?Q1BvTXhWa3dvZmhlbHRucStXUUFXUmx4WFcreHB1cFQvR2NzK3M3T2VmSEhH?=
 =?utf-8?B?anQxTWtBQzZyMTB0RjhSY0lIYUIwalArbzdVbllSM0hVZDRUUzA2TWMvNWdw?=
 =?utf-8?B?RW14VWc4WFZDTTExa0ZmcGlQeDcvWUhGQ2dKaEFYV3FjRWVWaU80LzlJVFVj?=
 =?utf-8?B?bCs4VEU4bmRVSVk1UUpmYlNMakc5Y1ZoTlFBeUpVSExWTUFPczJrNlo0VjhR?=
 =?utf-8?B?R3p5U1NPbHVPdkJFYjZpSHZtN0x0aHlaTjl2Qm11MENCMXEwN2dYci9yNTla?=
 =?utf-8?B?RXByK1J3NzlSMnpIMkRJOUpYUUtHdWVPUDhvR0h1YUYwak1EZEIyMGV0a1BB?=
 =?utf-8?B?ZzhweWw0c2dyUlBSY1JCdUhVVTZYRFFsVUNDNkRZRExJVnVDd0hYNXRkQm1x?=
 =?utf-8?B?TlRsMVNyRm9qVkpKUW5RN2NqMVNEVEN4bE1SSmx0VFAxVG9TZGtTLzVhdG5L?=
 =?utf-8?B?TmJCanBneVkxTzR6UUZPVkFWOE5abDFXYm9Id3ZGSG9NaUl0Yjk1dnV3V21p?=
 =?utf-8?B?YXdpWFdFakNjTzROUitPS003L2tiYTVmdEdwbUEyZUV0dG50SC9xOUxDYktF?=
 =?utf-8?B?NjNpR09hK2t4OXl5ZVhTUmpxcEZscExPVHpYRFNQL21pcGhJemlJTHNkbU5u?=
 =?utf-8?B?Qk1GU2d2TzJiTDU3TVlPVGd4c21WSEJsWTJHWnFWeHZmeXErU091Z21EeFph?=
 =?utf-8?B?dklIRDJFc1phYTJSOUVDK1oyTW9qKzJsalJOOElNY1QwWFIvcmphMEt0cTIx?=
 =?utf-8?B?aDR1V2UxOG9YS3ZSSitsUFV4Y01JYzRvczRoSy9KSnlDeStFaGlSVmtycUV6?=
 =?utf-8?B?elkvQXhndXFOUUlaWnpNVis3My9mOUpaa29KdEt2OXBERUtiMlBOeGxvWmRB?=
 =?utf-8?B?bTJkQ3I1eWpTWnRSRkM5T05jRGo2Rmg0Q0RkRHFTaVVYZkxVYzlRbFdYWHhP?=
 =?utf-8?B?bktDQnNsZ1VrOHl3MFIvbWdiL1pXV2QyeTE5TDZ5eWZvY1huQ1ppb1BYQ0Iv?=
 =?utf-8?B?VzFIUWpHRmFRVG1nVHJNRDZqYlJQSkg3VHJCRVpKbFh4elBnZ1N3d21Jd3l4?=
 =?utf-8?B?enNhaFJ1TTJ5R0o0bGU3dDM3NEowNmFPT05SUjRheDUrSm9TOWxZbjRHT3Rh?=
 =?utf-8?B?SDNJZGlQcStCb1UraGR1ZGRFR2d1eGFhU3Q5eDMwK2V2TysrdkZBd28zd2xI?=
 =?utf-8?B?T1VsN0x2ZjJjNCtlcDF3K0MxL052Z1JhV2VrWmNQNEQvWXR6RzBDbThRTUVo?=
 =?utf-8?B?dzZ4NTVzWVpMN0xacHFKTUpSaExra09GRWxkSEQ1TkFZcjJOWWJXbUgwSUxs?=
 =?utf-8?B?NmRlQS9URjkxRXlxT0ZlR1dadDcrek9qUmVNNGtLSlZCNnJreXRjMTAyMktq?=
 =?utf-8?B?N2s1NEhnOHZQY1FRTVFRd0ZocGo3T0pMeTd4bE5NaWRPWTZKY20yaEM4Y0t1?=
 =?utf-8?B?b1NuMmJ6SnNjTFpjK2tlWk03ZFhSNFBjU2VwTVErWE5LZW16QTh2SDhoOGlY?=
 =?utf-8?B?aXhsYnllVTVJS2owWFBmZWxzcmxld0kxdkd1MU53U3dhakhKUEJ2TWFVWDRl?=
 =?utf-8?B?NnhBb2svcWFkaFQ1QmcxeUVQSlJJOHAwYmNOTzJXaEJETTQ5TEc5cWQ1K0NE?=
 =?utf-8?B?Wk5WV0d4ZWJONVBpakd5ZW85eEhpZmxIOG5MdU1WZmRzaDdTUTVCUTladXhT?=
 =?utf-8?B?RkY2VmQrUmJBcjdtbUo1OXNkTzNiNlZEM0ZXS0lZYU1adjhlVUdMc2xCMkhy?=
 =?utf-8?B?aWExQ2k5bkVqNzB4bFJDZWVML2N5RFNBKzlDL3ZibmFIdEFsS0xydkYvdXc1?=
 =?utf-8?B?WFpZUDBOVXp1ZFJFUE1La1RtUUdubms1ejNLNU1jUElRZVgrcTZ2aThreGJn?=
 =?utf-8?B?TlU4Y3I3alB4UXhKZ0p6OUUwemswbThWaDAwTy9SUjBldElWVlY1S0RoaEw0?=
 =?utf-8?B?b3gxalFqSGpNdnZjUmk3b2MvUmtzZzkyRjlONWVqcFkvSjczUlAwRHUrWjAx?=
 =?utf-8?B?dHRxdjVPaWRoTGx0SWU2OHR5cWl6ZDdWbHdGWm44UTZXaUF0anNmaUNvbXVR?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c88d1a-6b87-4005-d1d6-08dbb3dc7ea4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 22:06:20.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEcgMLmo78k9m1QdXKgFi6/pF/iJ3KdO8EDkUesHQExwizbeJei3cZyk58IA/5d0m+NIEvOs/CjCsAYEF0ugHRCPugXV81BPJc417dfrEXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6516
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
> Unmounting resctrl FS has been moved into the per test functions in
> resctrl_tests.c by commit caddc0fbe495 ("selftests/resctrl: Move
> resctrl FS mount/umount to higher level"). In case a signal (SIGINT,
> SIGTERM, or SIGHUP) is received, the running selftest is aborted by
> ctrlc_handler() which then unmounts resctrl fs before exiting. The
> current section between signal_handler_register() and
> signal_handler_unregister(), however, does not cover the entire
> duration when resctrl FS is mounted.
> 
> Move signal_handler_register() and signal_handler_unregister() call
> into the test functions in resctrl_tests.c to properly unmount resctrl
> fs. Adjust child process kill() call in ctrlc_handler() to only be
> invoked if the child was already forked.

Thank you for catching this.

> 
> Fixes: caddc0fbe495 ("selftests/resctrl: Move resctrl FS mount/umount to higher level")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> ---
>  tools/testing/selftests/resctrl/cat_test.c    |  8 -------
>  .../testing/selftests/resctrl/resctrl_tests.c | 24 +++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrl_val.c | 22 ++++++++---------
>  3 files changed, 34 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 97b87285ab2a..224ba8544d8a 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -167,12 +167,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		strcpy(param.filename, RESULT_FILE_NAME1);
>  		param.num_of_runs = 0;
>  		param.cpu_no = sibling_cpu_no;
> -	} else {
> -		ret = signal_handler_register();
> -		if (ret) {
> -			kill(bm_pid, SIGKILL);
> -			goto out;
> -		}
>  	}
>  
>  	remove(param.filename);
> @@ -209,10 +203,8 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		}
>  		close(pipefd[0]);
>  		kill(bm_pid, SIGKILL);
> -		signal_handler_unregister();
>  	}
>  
> -out:
>  	cat_test_cleanup();
>  
>  	return ret;
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 823672a20a43..3d66fbdc2df3 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -73,8 +73,13 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>  
>  	ksft_print_msg("Starting MBM BW change ...\n");
>  
> +	res = signal_handler_register();
> +	if (res)
> +		return;
> +
>  	res = mount_resctrlfs();
>  	if (res) {
> +		signal_handler_unregister();
>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>  		return;
>  	}
> @@ -91,6 +96,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>  
>  umount:
>  	umount_resctrlfs();
> +	signal_handler_unregister();
>  }
>  
>  static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
> @@ -99,8 +105,13 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>  
>  	ksft_print_msg("Starting MBA Schemata change ...\n");
>  
> +	res = signal_handler_register();
> +	if (res)
> +		return;
> +
>  	res = mount_resctrlfs();
>  	if (res) {
> +		signal_handler_unregister();
>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>  		return;
>  	}
> @@ -115,6 +126,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>  
>  umount:
>  	umount_resctrlfs();
> +	signal_handler_unregister();
>  }
>  

This adds more duplicated code for every test. Have you considered a
single test setup function that can be used to mount resctrl FS and setup
the signal handler paired with a single test teardown function?

Reinette
