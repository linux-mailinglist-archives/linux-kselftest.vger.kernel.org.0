Return-Path: <linux-kselftest+bounces-778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCEC7FC960
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CA1B21333
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD15A481DF;
	Tue, 28 Nov 2023 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRPdnyQv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449BB10D1;
	Tue, 28 Nov 2023 14:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701210062; x=1732746062;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sbgnAbkOe0wuAoGs85gVt0eG8dmT/kTdaKgF6duRm+U=;
  b=ZRPdnyQvBao+yAnCnbkTbo9pIkSOf1fCu9AjgVuRKgZqdIune2OPD3gi
   OUJKvaK4uIvBbpKI4WOkLziX0JKYyVHPer2Moh2oUt4PG2hreeFcgdIyp
   jwBRmiCY3IVUfHZdofdmrOJKkmNHG/B6lPfyxshz+6RqfGr1LIViE2chc
   Mh8+jnfE/4A+ah9zJ1/NxN+dCMTqbne0Yo+g6Go3Ubw49edBpizycB6MB
   49BjQhQBZIlsk5SbOlacGBLWKiuz09UFPbNj/EjSk7L7YfsEuF1+xwaVh
   zdMMMXBGsW6gX1g9/n1H3uiRu6AwtuObbMmyWg0CCgXETLHevPZ0YP0l6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="459544619"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="459544619"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:21:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="912607573"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="912607573"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:20:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:20:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:20:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:20:13 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:19:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhCpTY6k12h4bxZYEW1sgE87bboM/21zB4R/d6bO19nMciE+GznA79fn7hig16NAdUcCWaeuF5N9+rUr80vzsONzIwD6g8Wej/AItmIhXffXLaZGO85Rt8BsDKHm+wqegxchYR8FOhb9K3HSGFzdlSg0pD8bpiBWx2puyyR2PexJhNgdXvGgTcG4pT0q05d2GPBae55jptrGw5Mr4Tp+2zjbu6roG+sBpCbE9KzXyb0ka/qRsveXNp0h192cbGqLdCEx2p3QE8nIzUQiQlyZc2vokxfTcgZkccXXBcmfWZdLac/lVvAjtLpL0eSoCLGvmCCy9ayXyxBuTaIMORInsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5zHamoMILYWTWIFADcdQlccWRwYqykp2LBcy6tN0dU=;
 b=WHN/1woHzIyVyhhUJgki1tvEBG6RU8kBkSyjTtOZ6epK+vFMcNrdWN0s5gHajcE6gI6hq3EE8a05/ybacUJF49sK1G4bcTM5L6eIrzRNVW9YOZzGgiw5rgbqpjR3Hj9pompN0JF32zpHfAfJ64bEF5NTyVAB7RTqC5r+sEGX5PnPgQk0xb9J0qVSgkbEzE86KYESRR0leJ4lH4bisv3AoEzHsnTfTyFU52d0TIskEdIr8sy1iEUEGX+Ni5uJKb6LqLleldSFqbrRgPWfV+VSunE94EBfEQofJDhfrENtr+nIlPw/YtPhGAuty4e9d5ChLTRgMlKkxfpw9PvZSGIEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8024.namprd11.prod.outlook.com (2603:10b6:806:300::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:19:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:19:40 +0000
Message-ID: <c79d7d60-e922-4ca1-bf83-4c4ed739da62@intel.com>
Date: Tue, 28 Nov 2023 14:19:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/26] selftests/resctrl: Pass write_schemata()
 resource instead of test name
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-23-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-23-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:303:86::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: fae8cbda-190f-490c-8d54-08dbf0601d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIRHmhBdhZ+NBk1jkVho0oHqn+JrueZo49yFYwXfe0BoXqh2xK5aAgEdI+18/5IhHRHgkCGsPRMFzwST90/5wZutBgPizbJ6VD1A5DPlh/j3kkX9iJfcWS0jiyqK8yQ4MjBLPO+kTgjyz+Ak0NIyz26Zxkdn8VS2aXyC7oFsIqoom83m+tJ9bXUAy5EzYUpYbLGCFZNIYdQqq6ED3pC2qb0TU35K3A52eM9nt6+DH/jitOJEgKGgkvbH5w7Y8aFr6rHXL+r3jkpHBum970J0ztlntCTZYPP21OYnGkCPHC7Ufehg2+C3Dj0juc02gnDs1bvatqwquE+bqKjkO1JIDw+duS28LCrQXlp6EZmYgIWqzQuhaq1XnXQ01by5WDZmT5hTssiEPECGF1GxZ5UXRsBYs5fLmhuK8w6w+6LBdihMVXq5er3e66H8mcWIhQDPTdpSq7HQr+fRogUHjCbT3h6dKHITIHS/6OHVtk7yIWAl71A4PYe5d+PNNYOC6hyXwgbaVjMhQSy9e3eZxHx96AAEVE3Pykpk4Xj/1gOVH735vNLSzEVYsvHdcdrbQsLF1X8gBK3xEaA0zgBu0OYH+Eow5hiEMU4/bhXH5GByjtWohI0h//kKlgHAKGT5zmM+SMaruwgZZ2I/Mo3bb0Y4CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(41300700001)(36756003)(31686004)(83380400001)(5660300002)(82960400001)(66574015)(26005)(86362001)(2616005)(2906002)(44832011)(6512007)(6506007)(53546011)(8936002)(4326008)(31696002)(8676002)(6486002)(478600001)(316002)(66476007)(66556008)(66946007)(110136005)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEFhNHpVNGR6SWdwUHJJUXlyQVR2UjkwRExMLzV5dThHcjJzd3oza3ZRcUJO?=
 =?utf-8?B?a2dEUE1rdmJnUklDMnFaTi9mQ1pIb1pqd2NXSmdVRDFLWExWYzhibyszSGd3?=
 =?utf-8?B?YkU5UmtXVVFOTVV1VzJqeVdHYTlpYWR4Q0IybnY2bldhQ2NtUkxtdWJiTDJr?=
 =?utf-8?B?VlR5MlM1VFRlczNsR05GMkdOdXBnZy9ub0V5eHVWT2NGMnlxS0ZkZEl4bnBt?=
 =?utf-8?B?bVFra2EyOWN2V3JVbW04N0JZaXBCR2pleXdMbHlBMVlHczBtNmQrd1RTUTBR?=
 =?utf-8?B?dU9VcFJ3UUZPWTVCQ01EVG11Qm04eC8wMDdrZHBFemtFaktnU0RSK2FpVGdL?=
 =?utf-8?B?NVpxdjRhaWxJaUVjb1ZEN3dsT0ZxQWY2VTRiMW5aVHFicjlWdHBMaGhaTzNB?=
 =?utf-8?B?TUZGNUZIK2gwc0ZVTms2MzhPa0NxLzFvN3hVYkZFSmpJWkh4V0w0VFJKTnN3?=
 =?utf-8?B?UmxyVFJxQ1BiY3RnRWtsdExyQTdVcm5LaitrUGZ6cUlFRzhwWUV2cVphdVl1?=
 =?utf-8?B?R3YybnNWd3AyRUFCRUpJRTgxU2xJSVBtdFRsZDhydCtDUk12SDQvbWRtV1NW?=
 =?utf-8?B?bU1hRFdMZ2RSNWhhYVMwWHM1TUorN1BqRVYyNUlaYWRMcGNtSVh6SVNzWUp3?=
 =?utf-8?B?SE44b0VGRndPZXYrUnlFcVhFTGlwcDdBcFBMNzdpek5ueUg0NUpSTmRwWnM2?=
 =?utf-8?B?c09Ha3l4Y1FGaVlNc0VmblVFajRIeUFlZUJaaHZUUWt3V0ZtSVdLUFFXcXRa?=
 =?utf-8?B?aEZTdjBXR1hFVis2RmM4S2xibjdIYTRnMGJZODV1VmpzSDFyTC9FaEZhVXJP?=
 =?utf-8?B?VXFaQVpCaU9oS24zWWowVGRzNWdmRTRucXE5YkpaSUsraGJacnpwUXEwY2Rh?=
 =?utf-8?B?VDA5b1Y0M0ZrU3A0bzVxMlBuZ3IrdCtiMWtGWDVlcGg1SWdxaHNjNEZvSnFx?=
 =?utf-8?B?TWhWajNXZi9PWWpWbGpVUTAzRnl0YVdJTGRYcHNyemJkYWhHSFJOY1MrWFRj?=
 =?utf-8?B?YVc4WjNuWEYvWHJIUlJwRSs1V1pkMlFRVG4yM0ZUN2tlM3dYTldRNWN1bmhv?=
 =?utf-8?B?aS9TTUZFaHlLejA5cjZ0NDRzNlZ3aUswNmtrSXhQZzRmaUREY0lUdGpaK3NF?=
 =?utf-8?B?c3V4Z21iZU1RNGsvYWFsbmU5a2x0NWcwTjFCN0UwcGJPeDBRRFBCRW5LWnFo?=
 =?utf-8?B?MzE5b3BVM3BnZ2EyZWo2SVByQ3FWRjhCVVZ0RjVVOFpYUEUrN1hMbk1ndmwy?=
 =?utf-8?B?WGVSVDhZaU1VNmdVaTZUQkpzREN5MlhONW1ULzJ6N0k4MCt0eDNHNVREYU1E?=
 =?utf-8?B?cjBsMUJhOU95V1NucVkrUXNZRzl2NnBDd2N0U2NUeTZVOFNRclJHU1p5Um5q?=
 =?utf-8?B?Y2E2L01Jb2JNQnl6S0lad0ZOTmxGSnFDWGtsbFFsU0NUUGFjWnZZZ0FvWG00?=
 =?utf-8?B?M1FyRm1YSVVMcGlUTUZYby84YytsYS9TanI0eHdaa0lJV1JqUmFPK0hIWVBh?=
 =?utf-8?B?emNvTWdRR3h4Q29BWmFjaTcvY3Y5c0NNQTZ2NkRHZDVMSTBkblhPeVg4b0Jp?=
 =?utf-8?B?dGlxYytVeUJWZDFmSTZPcDdLWkFwM3hDNjlzOEpVeGlEUCtjbmREczFuaExl?=
 =?utf-8?B?b24wdFBpM3p4SXp2SURZZkZaVE1BMHdHcDdYaEtIYU9EdnhiK2x2bVU4dnR3?=
 =?utf-8?B?TTY4dFVSbmlMK3p0VVlJVFF5YmYraHpNMUoxamFQSXNielhhMU0wWXRrMUVp?=
 =?utf-8?B?WStrSDZnVHl3UXFOQ1I3S1UvYW5Banpsd3dabE04K3NmQUZKTHFoSXhxSDlE?=
 =?utf-8?B?ai9zZ3l2S0V2WkhIVzNCWHBmUG1MalpGWE00YzNDNGFGYkNSSURqQWlJSGIv?=
 =?utf-8?B?NTFzc3gxN2crTHNyMS9wWGpJTEh0VGRyU0QxcUNWczU5ajNyc0lXMG1zNkF0?=
 =?utf-8?B?L0w1VnI0akt5b3V0VUdZWEhodDVFVkd2V1YrdnllOTRMdGVtQWpoVnN5ZXh4?=
 =?utf-8?B?VEwwRTBsYXZScDJwS3ZBOTRyc2VPb1lUeHhSZE9nUjhIeVpnRW85cjZyQTFW?=
 =?utf-8?B?SEdTT2k5Zk5LbnlLczhmWUlBT05LdjFya0V6SnJ0a2NxbVRwc0ZhTnNwRFdL?=
 =?utf-8?B?NUZjOVJrL2NCSDR3U091TjJGRFJ0Y0huN0o0REI1R0h3MEtKWmVxR1phaFNQ?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fae8cbda-190f-490c-8d54-08dbf0601d9a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:19:40.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0SMWUiLpLnVQOs1jDzypPA43Omb+fTVLRBVnFk8Is082HsXXafN1xOghlL+tn+VH3gCy5/ixFNZEhkKvgRbdevn1XpV1MxOUOZAeC0luG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8024
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> write_schemata() takes the test name as an argument and determines the
> relevant resource based on the test name. Such mapping from name to
> resource does not really belong to resctrlfs.c that should provide
> only generic, test-independent functions.
> 
> Pass the resource stored in the test information structure to
> write_schemata() instead of the test name. The new API is also more
> flexible as it enables to use write_schemata() for more than one
> resource within a test.
> 
> While touching the sprintf(), move the unnecessary %c that is always
> '=' directly into the format string.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

...

>  			break;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index b711326b2141..fda5ad812faa 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -502,23 +502,17 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>   * @ctrlgrp:		Name of the con_mon grp
>   * @schemata:		Schemata that should be updated to
>   * @cpu_no:		CPU number that the benchmark PID is binded to
> - * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
> + * @resource:		Resctrl resource (Eg: MB, L3, L2, etc.)
>   *
>   * Update schemata of a con_mon grp *only* if requested resctrl feature is
>   * allocation type
>   *

Note above there remains a usage of "feature" that has just been changed to "resource".

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

