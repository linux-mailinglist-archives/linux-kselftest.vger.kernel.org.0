Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D22D79DBA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 00:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbjILWKB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 18:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbjILWJ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 18:09:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91911728;
        Tue, 12 Sep 2023 15:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694556592; x=1726092592;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5NgFuBi0grMJByv+WMk3aDhPrPW3qn0LknZEcOD8NGQ=;
  b=i9rz2OHKDcvuZaJnbhXr/rmJ0QaAAfxWjSkr1fuXnnbZX5VvI9BL2phK
   hTqGHHE1ESMCeTnMjyIwWQFBb4wbiG265M0sXrF8eltalh5kiKE0/mNXl
   CUza7sufwqDWzHKi4lIh4aBEgNVgvE6a/Yz6DucdflyHyw2HADdMoH8Pf
   8KPRLOsh0X9qgbofKnWybvIdaZNxZ1WvPwKPWeYWvGafhnmgALgt2xHbo
   P3a9I7p9RQ+ekhrPF3+4u4STDw2pSVRYUGIRtP1jLHgi4V/kZ2nXznt6H
   dVn7c5zSszKh8wmuOlavGKqmqngp0PAhB1YPiVToAdkMsBAfdzd8E+TuG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368771173"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="368771173"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 15:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773206653"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="773206653"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 15:09:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 15:09:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 15:09:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 15:09:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 15:09:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbOlIZBONt5XjA4jdhJcd1xusTaJ/suF6tSD4juM5H2Gb/5Opq21DvOB4kinR+AOT6bfLcUANGMtjj3bpQgDRnvLXWOb+Arnf0btcMN01P3hghmXSzYlp47DMKeAZMaZwd8Jvn9YOEA6FLZAFwqpJtuiPzMPW/lOjPDm1v8X/qOdQtL3KlEoUsOkReQtwJ8wL9u4OUswGdtn5O0bBTnaOgB8CdiRjKzN6lNV1/MXDx++g0Vwb13oJXXl1xk2YmXmZPlzvdJ89IWZSxTxpSaq/x3SR2UZO4QU2VHQOFvYxzBUH2+BYSRU5NVfUtSrSIVp4Y5fYzdu4xlV+WO7v7Gq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLySuDW8gDPugdKIUKxa+7O3sTq/hQry6MtBAWD4UXQ=;
 b=gw+qgmDpjsrj5BNPFD40Yu3hoX5uX46piBWSwtBeNTOpR0ljehvBCi0VoevVp69/z6VXrJ98BcpbMDtzWnDaRPUCJEHSFlaeEBDU6MrRTcqknRvjQiWk3VUdy4WZtnpyP8YlJKitjwx+Nxo3/yHPM7AZE+BrowdU5gW+EEzvSfU03JYtOHEPFQk/iVbLMgheWz8c3VjnKQSUfmwsZ7AdXk0sZECJbPNJYBw49RGRBDjhkpc625KpiZ7cDw6Ay66oAIDVOsqHz6NIrNi0lG2BA4CiKJO2/n6X4IudsFPHoKDZxgc6GTxbgo5pt1COgaNzi7E1QVzaHQ0fnUhdCqNlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6029.namprd11.prod.outlook.com (2603:10b6:510:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 22:09:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 22:09:36 +0000
Message-ID: <b5a36b8a-c5c7-84a9-270e-bef4478d4bff@intel.com>
Date:   Tue, 12 Sep 2023 15:09:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 3/5] selftests/resctrl: Refactor feature check to use
 resource and feature name
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
 <20230911111930.16088-4-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230911111930.16088-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:303:84::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 5191a4b1-f8ed-44f9-a154-08dbb3dcf398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ye5drV+fRy2taeYMN8lDqUYmak5zd5UQcEhPdygzIlejMVTxbhtpGDZNqsy+1tj/4lrOpavYl01RjpXMzXbuKXsLlp4YoBjA81W8OXDqooqTuRwSJ7APzCFEpoAKwt7V8vx6rbOJ2SOcgKsU8sbr/2oCjU8WGtGPHPpq9Wr20vdCFc/NgWjbOud7sJ4leKNAyeYDs0vM4ka3POcCAqjdqTIVrf69jgeSZtiiqXb1xvW1ooUkenylZp3h5QSPWhJpNdiL+M3gNRiAa+i7gt2vNo/6HKM/3x0vvGTD3i7RVzQqcCr4YLd2t/9SroFO9lV4ix993yTZfViLmv82lpVUzmZf18GaKxJDyYCh+EuSf7L6lQ3CFdRK+E2xEebfkMvHGqYQ8Hl5ARAFE/KHiIUoGPo21yrRtnpXshIexUa6ZK60TOy0YeiGWIoMURc+oblbcKQfH/HlnysY/2e2q5SV6QEFQ4A93rs48iz/DSccNjbLMnOAlnpHwXBEu/1z41H42HUc5+UT6/LgFXNGJ+S8y3sWqfv5IfaYjJpyquF70BM+9j7IGtnw0vOyAxzqRTyAZe/iwfiulRrf0qAV2FAtEWZT4ueXkSlMo0c6qP0hcVWrDXLbrJ8hRA1UhZSmVohpnq2/d0BrwIdQQoSZaP+T3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199024)(1800799009)(186009)(4326008)(2616005)(8936002)(8676002)(478600001)(6506007)(66946007)(316002)(53546011)(6636002)(6486002)(41300700001)(6512007)(110136005)(26005)(5660300002)(44832011)(6666004)(66476007)(31686004)(66556008)(66574015)(2906002)(83380400001)(86362001)(36756003)(82960400001)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFocE8wZ1VUQktNdlBYUlJ5b0ZEVzVCbVVHOVdUSmhxQW9DSk1Cc3JmLysw?=
 =?utf-8?B?Y1B6RWJFVFdSdXFacExqTHBwc1VSMUI4VHcrdjhyU1pGWE1LSWM3OXhqcWJl?=
 =?utf-8?B?VFh6cDNWL0hNc2xmRThleVhKWTNHNUNieExxejhPeGxiTzRsd2tVWUlkejR1?=
 =?utf-8?B?U2k5K0lOWmVmdDR5Y2ttM29hZkVhbWF1RENFQ2UzeWtKdXJGSmRoQ0hSZnIx?=
 =?utf-8?B?WHlhQmtnVzJFK29NcXFzU0R6TG5jaHVJTXpKbFBIVTM4ZFV3ZThQZGQ3bXRO?=
 =?utf-8?B?MG8yRVFETmVSZHNGa2lDdUdGTnhpRzlWQzV1blRaTGhHMCtkdWcrSWlBQ3Fz?=
 =?utf-8?B?ZVdWR2NabEtmcTcwbFBYZzRldC9ORElIUTkwaklFTUMxTUdOODE2Q3VRc3R6?=
 =?utf-8?B?K3hYMGJSaUdDVEc2Ty9qLzRQTlpDa0I3clhlOU14Z3UxQlJaOVZYN2kzTG5H?=
 =?utf-8?B?Tk50Y0hwenhYMHcyY2VETmFLYzNHMjVjTjFCdjdsamRYZlFNTVczNDJmZ29D?=
 =?utf-8?B?MlNmNVJsd3A1S0NMVzFoL2d3ZTZKaVdTR25HUkhFcGNoempKcGlJNjlPblda?=
 =?utf-8?B?ekp4WThIQStib29VZVk2OGhxbkN1YmpVa055WXV1TUsyNlVGT0U4V1ZxQ0p4?=
 =?utf-8?B?UEJsVE1YSGszTVh5QVdDNFZ1Mk5FMWt3ZVRwdSt4QlMvRCtrbTcrbGlmQzNh?=
 =?utf-8?B?S2NDb2NsYjBScXhSUkR0b216c0szYnVrbVl2VEJGUityT1hQUHp2WWlJZ1cw?=
 =?utf-8?B?TnBHRWlpSERuYm9NWUdRdXJQNEVKOUVjb25uRVZmcjQyUjhWTExzM2pkZXRr?=
 =?utf-8?B?LzhoSUVVMjErOGVCT1J0OEZzMFZCMlNuYVFPZ0MxWkYxbzFITUtKelZubVUw?=
 =?utf-8?B?d0xVdTdwS0VISkc3am5hNGovRjNPbHJ5NjRsTGRIYUx1cWhKdDRRSU1oRG1N?=
 =?utf-8?B?eERDckFyRlRDOVpuV0dDbURJL2cyL2d0ekpUc2UrNVJlZUs0aWd3NjZVd0ls?=
 =?utf-8?B?Q2szMWN0L1Vac0FOQStETjhxZ3NHWG1GcVJpd3B2U29oQXRBdCtJNE0rcXhE?=
 =?utf-8?B?UnkvM1pUdTBwSzEwbnFHL3NTcWhZQ2ZFVkVNU2xFSG5CN3lsbzhUbGpBWGZU?=
 =?utf-8?B?LzF5N2xYU2xBNHFaejNvSWFGRk9Ed0ZuOTgybUxSMWtqYmI3L0t2bDQ0TjUw?=
 =?utf-8?B?bFBCYXdwSG9mRU15ZjZJZHM5V3JYY0xDNmJkbWQxaFpNV1V6blh6L2dqOVZ5?=
 =?utf-8?B?ZnNOV3UzNzRLemxwN05HRHVUYlAyTWFudWlPTDczMHowVTBRL0RGWTFnY1hJ?=
 =?utf-8?B?SloyRVVtWDNNbXUyNjdhcWNwZjB0amVsMEx4QjB0QVdFY0M5eGZUZGpMK0VI?=
 =?utf-8?B?UHFrb3Y0cFVYOWNDM2RQbnZiaElNVVUrK3FrWVFCR2Nyd0RUOTdLSEVvTEFa?=
 =?utf-8?B?ZUZGL1hIeHp6MDJZaFFSQXJreEttZnpvWnRndWszdXZnbUdJMlpkU285c3Rn?=
 =?utf-8?B?UHhVZ05sS1p2eFVyNVBqbjZmMTlOUDBYcUhKOXBkU1ZHdnpCeUNwZ1JXYzJy?=
 =?utf-8?B?bUcrRXF0KzhmUHhZWHV5UW5YcTJEa1lSUVRya2hDRjdmMTJpcVl2Sjl3YVBl?=
 =?utf-8?B?Z0tWWXNDTUhWQXZXbjN0allyYk4zSzlxSWxyVkNsR01ZRkU2dHlXQ0RYS2dK?=
 =?utf-8?B?VisyT0JVRUxGSVVrWmFLVXNLaGtJUXFISzVoVzdwRCtxS2NwLy9mOEt4Q29T?=
 =?utf-8?B?bXBCd2hvbmxqaGZjQVUrRzY4SVg0MVhCeEprNGE5eXh3ZVY0M3hnVUcvMzNk?=
 =?utf-8?B?SnVYZE5pWG1heS9yZURsQ1hXZ0t3WGlkd2QrTWdjREdCQmVUT0dkK09GR05O?=
 =?utf-8?B?ZjNzN0JIbXRFL3VBVTdFYTRSSnhuNmVsYUF5WWNNKy92TUhTZitVMUNJMS9S?=
 =?utf-8?B?d0gxRTMyUFBjNUJITkVncUI0R0JjN0loOHlqRnZCTStxN0d3KzljWnM2ZStB?=
 =?utf-8?B?WG12a1R1NlZJazlMVW5lR0RTSGQ2Q29OWUIxWDZzd3BGWnZJMUxFNnhJTmJr?=
 =?utf-8?B?THY2MWhZWTFQNUVkZXhkbTFVQlN6bE5mcFY2cWlRVFBGb3dEdEw4QXFzQnh1?=
 =?utf-8?B?bFZyOHRRakZuRGdvSEtEUWV0MExzMDdHSm9KM0QwRDFhck9XRndwTGErVkFy?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5191a4b1-f8ed-44f9-a154-08dbb3dcf398
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 22:09:36.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09/GD/hxGsSb01frnz45XSByuIUrc94k3EBBMlNceIhNXow9VYzZGDfNkRwpx2rYGDqSmIc5ZTv1Ag6b7KF+S8qmhhJ2TT/++8eK8IsiFpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6029
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
> Feature check in validate_resctrl_feature_request() takes in the test
> name string and maps that to what to check per test.
> 
> Pass resource and feature names to validate_resctrl_feature_request()
> directly rather than deriving them from the test name inside the
> function which makes the feature check easier to extend for new test
> cases.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org>

This does not seem to be stable material.

> ---
>  tools/testing/selftests/resctrl/resctrl.h     |  6 +-
>  .../testing/selftests/resctrl/resctrl_tests.c | 10 +--
>  tools/testing/selftests/resctrl/resctrlfs.c   | 69 ++++++++-----------
>  3 files changed, 34 insertions(+), 51 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index dd07463cdf48..89ced4152933 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -28,10 +28,6 @@
>  #define RESCTRL_PATH		"/sys/fs/resctrl"
>  #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
>  #define INFO_PATH		"/sys/fs/resctrl/info"
> -#define L3_PATH			"/sys/fs/resctrl/info/L3"
> -#define MB_PATH			"/sys/fs/resctrl/info/MB"
> -#define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
> -#define L3_MON_FEATURES_PATH	"/sys/fs/resctrl/info/L3_MON/mon_features"
>  
>  #define ARCH_INTEL     1
>  #define ARCH_AMD       2
> @@ -88,7 +84,7 @@ int get_resource_id(int cpu_no, int *resource_id);
>  int mount_resctrlfs(void);
>  int umount_resctrlfs(void);
>  int validate_bw_report_request(char *bw_report);
> -bool validate_resctrl_feature_request(const char *resctrl_val);
> +bool validate_resctrl_feature_request(const char *resource, const char *feature);
>  char *fgrep(FILE *inf, const char *str);
>  int taskset_benchmark(pid_t bm_pid, int cpu_no);
>  void run_benchmark(int signum, siginfo_t *info, void *ucontext);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 3d66fbdc2df3..3052394ca884 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -84,7 +84,9 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>  		return;
>  	}
>  
> -	if (!validate_resctrl_feature_request(MBM_STR) || (get_vendor() != ARCH_INTEL)) {
> +	if (!validate_resctrl_feature_request("L3_MON", "mbm_total_bytes") ||
> +	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
> +	    (get_vendor() != ARCH_INTEL)) {
>  		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
>  		goto umount;
>  	}
> @@ -116,7 +118,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>  		return;
>  	}
>  
> -	if (!validate_resctrl_feature_request(MBA_STR) || (get_vendor() != ARCH_INTEL)) {
> +	if (!validate_resctrl_feature_request("MB", NULL) || (get_vendor() != ARCH_INTEL)) {
>  		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
>  		goto umount;
>  	}
> @@ -146,7 +148,7 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
>  		return;
>  	}
>  
> -	if (!validate_resctrl_feature_request(CMT_STR)) {
> +	if (!validate_resctrl_feature_request("L3_MON", "llc_occupancy")) {
>  		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
>  		goto umount;
>  	}
> @@ -178,7 +180,7 @@ static void run_cat_test(int cpu_no, int no_of_bits)
>  		return;
>  	}
>  
> -	if (!validate_resctrl_feature_request(CAT_STR)) {
> +	if (!validate_resctrl_feature_request("L3", NULL)) {
>  		ksft_test_result_skip("Hardware does not support CAT or CAT is disabled\n");
>  		goto umount;
>  	}
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index bd36ee206602..bd547a10791c 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -10,6 +10,8 @@
>   */
>  #include "resctrl.h"
>  
> +#include <limits.h>
> +

Could you please include <limits.h> before the local resctrl.h?

>  static int find_resctrl_mount(char *buffer)
>  {
>  	FILE *mounts;
> @@ -604,63 +606,46 @@ char *fgrep(FILE *inf, const char *str)
>  
>  /*
>   * validate_resctrl_feature_request - Check if requested feature is valid.
> - * @resctrl_val:	Requested feature
> + * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)
> + * @feature:	Feature to be checked under resource (can be NULL). This path
> + *		is relative to the resource path.

I do not think "this path" is accurate. @feature is not a path but an entry
within the mon_features file.

Also please note that mon_features only exists for L3_MON, none of the other
listed resources have an associated mon_features file in resctrl. This
function is created to be generic has specific requirements on what
valid (never checked) parameters should be. This may be ok with the usage
but it should not pretend to be generic.

>   *
> - * Return: True if the feature is supported, else false. False is also
> - *         returned if resctrl FS is not mounted.
> + * Return: True if the resource/feature is supported, else false. False is
> + *         also returned if resctrl FS is not mounted.
>   */
> -bool validate_resctrl_feature_request(const char *resctrl_val)
> +bool validate_resctrl_feature_request(const char *resource, const char *feature)
>  {
>  	struct stat statbuf;
> -	bool found = false;
> +	char res_path[PATH_MAX];

Please maintain reverse fir order.

>  	char *res;
>  	FILE *inf;
>  	int ret;
>  
> -	if (!resctrl_val)
> +	if (!resource)
>  		return false;
>  
>  	ret = find_resctrl_mount(NULL);
>  	if (ret)
>  		return false;
>  
> -	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
> -		if (!stat(L3_PATH, &statbuf))
> -			return true;
> -	} else if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
> -		if (!stat(MB_PATH, &statbuf))
> -			return true;
> -	} else if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
> -		   !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
> -		if (!stat(L3_MON_PATH, &statbuf)) {
> -			inf = fopen(L3_MON_FEATURES_PATH, "r");
> -			if (!inf)
> -				return false;
> -
> -			if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
> -				res = fgrep(inf, "llc_occupancy");
> -				if (res) {
> -					found = true;
> -					free(res);
> -				}
> -			}
> -
> -			if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
> -				res = fgrep(inf, "mbm_total_bytes");
> -				if (res) {
> -					free(res);
> -					res = fgrep(inf, "mbm_local_bytes");
> -					if (res) {
> -						found = true;
> -						free(res);
> -					}
> -				}
> -			}
> -			fclose(inf);
> -		}
> -	}
> +	snprintf(res_path, sizeof(res_path), "%s/%s", INFO_PATH, resource);
> +
> +	if (stat(res_path, &statbuf))
> +		return false;
> +
> +	if (!feature)
> +		return true;
> +
> +	snprintf(res_path, sizeof(res_path), "%s/%s/mon_features", INFO_PATH, resource);
> +	inf = fopen(res_path, "r");
> +	if (!inf)
> +		return false;
> +
> +	res = fgrep(inf, feature);
> +	free(res);
> +	fclose(inf);
>  
> -	return found;
> +	return res;

This is unexpected. Function should return bool but instead returns a char * that
has been freed?

>  }
>  
>  int filter_dmesg(void)


Reinette
