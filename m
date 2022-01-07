Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFD8486E7A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jan 2022 01:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbiAGAPY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jan 2022 19:15:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:19782 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343763AbiAGAPY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jan 2022 19:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641514524; x=1673050524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HImED4AllFVZU5cfE+fa63EGNy9jtQYCOJpUdAfI/eY=;
  b=E24yaxflmIditQc1owihmluesEd2xc5p4TDPYrMxPDCX2bzH6RUV1TTF
   e7m/wcnQAVDV0RE4DTnOAvnYjj/pXPOgqa1PXaUOYX1BDkoivAvrU4MR5
   lqtPdJcxlZena+uWIYEgpmpS0J8HE3NU6mPDGNRHFmH+r6Uq5kmgX3pn9
   nCkg8jChKC1M341XyW8gWkNE02IWJRiDU6P7TvzKXcBH/2yM77y6m0gn1
   WuMHCaFrK2MrkntQ4q+NzgfQnwmewndakCt8rj+N+WZAetxR8IKf0MxWR
   LzE+GKOoRfv1a9As1jbVsEh2TsedgfTn5Hvgz0UisRafzCDb1knCIddzs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222757798"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="222757798"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="591548648"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2022 16:15:23 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 16:15:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 16:15:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 6 Jan 2022 16:15:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 6 Jan 2022 16:15:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvmJ68Zh8gmHagm5Pa87yVTdyBy4ed7eftd2oT9sYmCm3Xh51sSVedzYPPJ2cRQm4RTix0SiUTf6Ww6RNJykIqMpmUcvpPzK/l9aL4RhrNtNDPNUz394FZ/b69NSgkdVAg59TOMh+euF+fj3Ay2MDwBKbqkX6njUoMD5h+vuPH0ixZGZEQXcqR8RZ4EgNvCwz7c7s1iwxTuoPk8g+6VG1adwwHygv7tpBkMrczUdlhxRkz6rDRkq3efUhm8Y7CwRuBvdoSNpxKzc3J8lnHOY21dHQuEEyfYL677f1m5rZCYRaxV2BbD/GVaYZjdIQhre8hPDzUv/+7cQclrySdFS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGv71SOZxti3JuF2p4ozIyr8v5Saq4w9uxVYEvX/tzA=;
 b=Q9vgqMhkWtxnxD0nBYg5yaZyCJmi6sVCazgRf9Yw2CacYgbitl2OdnSmiDc6i0TJSdJgyun5gFA9zS5onIaXj+lEWbhOu/0aZT9hkYWprDmywkvcbbfqhiicf4nGrLjBF+yRc6mcwUNSNtQEYYl+9GIgs8/z34+zvkgCJBFNbEO7ogEgdaHry+E1ujHMwRdttE2VHavY5BYvH3G05aiU31/fky9b9xXw7RFrlx9Lc4fpugRUsQR1ak6tDRwu6yZYJ+qzkCDyQMHkpne70HN3gt8oYbFMHT9IWzXGI7D5S7FPpBD4dauJwQSFnRSp4QABj1vKNXjFpw9ahRxwEpppdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 00:15:21 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%6]) with mapi id 15.20.4867.010; Fri, 7 Jan 2022
 00:15:21 +0000
Message-ID: <b05d487e-bb8b-56df-8304-6e91323e9d83@intel.com>
Date:   Thu, 6 Jan 2022 16:15:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH v2] selftests/resctrl: Print a message if the result of
 MBM&CMT tests is failed when Intel Sub-NUMA is enabled
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20211213100321.181408-1-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20211213100321.181408-1-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0223.namprd04.prod.outlook.com
 (2603:10b6:303:87::18) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4900c890-391c-47ea-3b80-08d9d172ca99
X-MS-TrafficTypeDiagnostic: BN9PR11MB5243:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN9PR11MB5243301E2944AD046958A355F84D9@BN9PR11MB5243.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwfMxNm2FLv7kRNTXxVGZcMFX2J8zwZOWensz/H4lC4gkA1AyI0PMwq5lxHVXlyRQ8tiUZZ8A7XtJQx1FtHVzC/dISJ1yDHKHRgcCP3E5eLA2wvhYxJTDZM1ztoz+YE/pIlOg+nU/pTJTnZqOwuBYLqn4tRoFrm6Xrnm2296O4EVVGVMEnLDtblyIWT3gKrc8QodwNd4JszQxm/iSCQX2hRyy2sKHVhqDvw5xbLcbvLkvF/m01rk9UcfQKqe9EwhiNkwc08r4ifix9mru4kJVhxvyP1M0FYlEFrFKyeUSNjPaOdzZMZrgrCLy9U++X+xdtaRpz9ibRNJ/c+hlV9J435V3FTZDMh4AaQv972bVQjVsCElIhQ5wCttS1ryA2KoYP1jobO5rZuGFPilkpmOiI6/r0umxFrvJbdTfO1qFSyvLUgdzKJjs9jQC/pp0xwSZWRDzA3ZZDxwFHi39uIpAs7tJxzbCoQz13jgMY+Us39LZAd9XIHYhWTZn2yhtfujATL49V6eORdx0YCdRM24T1KVUjh9z35oLaSXd78qK1gj0WHvm9dgSqd8xbavU4u+jjguNJlmpHiot/JVJHc0MBJgVlPSNP5a8Er+cDEMy/ZDPASdTyUgXaH6gVOeVhS2vX2uy9Nph/M9r745UdCq0wMGY5Afjhs+2VBcZ/xBeMoAml2B3LsxWHBUfOQpdnIFRm29KuAM3HcDTWZplb+wljps3SpxlLgKBsJUH+BBxaLIN9EPxse1tohRHR4JdSw0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(15650500001)(6512007)(8676002)(6506007)(53546011)(6666004)(66476007)(66556008)(186003)(31686004)(2906002)(83380400001)(110136005)(508600001)(2616005)(316002)(31696002)(8936002)(38100700002)(6486002)(86362001)(82960400001)(66946007)(26005)(44832011)(5660300002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek16eWEyWjI4MzkyMzlMaS9OQUdSTDNlVzd0aUZsVStpWGRrSmt1VjNSZmNY?=
 =?utf-8?B?TDAzb3JLdmNDME9MalBQcjcxbkkrOUpDcnZMdFgxQnI5TWYweDNDMUpVcE9Q?=
 =?utf-8?B?elhVWjVTNG9Ram1aUGJkVUdtalVFaXROb1ZLb2RUTFRVRkE4WUhIUDMzQ0Q3?=
 =?utf-8?B?QytKQWc4bWxXRFpYaVRhNklWT2hmeElmU0Z4RUhZWSt0cnBRL2hxUU02aUhC?=
 =?utf-8?B?a0lxRTV4a3Q0SjRhVis5WWxpU0xXZW5IVFpNTk0rcytZbHpnZXFGdi9uSDZJ?=
 =?utf-8?B?UnhFdlVGeW1tZWh3enYxUitnS2d6cUNna2o1Y1ZBc0ZoS3BaZW8zREdPR0V6?=
 =?utf-8?B?Y3BOcmxTTUptS2cwWHV1RVVWb2NvbHExMjJPekViekRXQzl2RXQ1Zm44SUJ1?=
 =?utf-8?B?b0xUSGFPaHZGVmhLdmhTd1FvU0p6TlJnUHFvYldWS0lPT0JmSEYzZzJqaC9k?=
 =?utf-8?B?dFZWWmxBOTdUeGtQZVUzSXAva0RPbzZ6T3l0MmR5S2haUHlmekF4ZmIxc3Bu?=
 =?utf-8?B?K2xxeXcrVVAxK3lsbm5GMmVicFZjTHhwZXlrUUk0U3ZjQm1rSEFmcm5Wai8z?=
 =?utf-8?B?OTFHRVEvcmtDajB6RGJGRWtjd3h4c1NDc1ptUmQ4L1ZaRXRlQjdGUmF3czYv?=
 =?utf-8?B?YWNDWVE4M3UyOW1rNGQyZ1ZTZ2RHREx0VDhVaks2b3FhQXM5czYzSGxGWUhn?=
 =?utf-8?B?d2dtZU1FQnEvVjEwaEdRT1hvN1h1M1d4U0dWRjdQbkNDMEhKb2xLMEJQMUNj?=
 =?utf-8?B?dHZYcG9xaXc2LzJQRWFsS3EyK0ZpSFpJZVlENDVtWGJhUUtYeXRMSHhqYXpD?=
 =?utf-8?B?ZzVJQVRVaXZOdHNzNTdSZlloek5GZzQwWWJBcU1reEhJTzdnd3p2azNLRy9B?=
 =?utf-8?B?Wm9xeWdtSk91QW1nYjhJcGFwUFM0VDJrL0k0TitTQm5wMWJKbTVJMkp1SjNm?=
 =?utf-8?B?d1FaUXIwbThIa2JvNVV4SnZuWXgzZ1hJelFpa2pVS3gzQzREQ2VRaXptZktD?=
 =?utf-8?B?YVFybDBwbW5UUTU0akFWcVpLV1A1RGVkUjJpRllqRFhTalZ4b1ZmMzBUZGs3?=
 =?utf-8?B?VHM4U0MrUlJOdEZ2d00yU1ovK2QwUG5kelg0dGtSbmJmeWdSWE5ScWlsNmp5?=
 =?utf-8?B?TUxJKzhJSEU5UDBkRWY2NDVkcXhtS0ZuYjhzWlBkU2EvbEY0OVlFbWw1Z0w4?=
 =?utf-8?B?YUxka3hBdGtYUStUWkgwcnUxUVNvc2JqeE0vTmV0bWRvaUNFRzdUWEsxbGg0?=
 =?utf-8?B?TVNOTTZzYjIwQUkzUUxNSDBCbHplWXZMRlFTT2J3ZEtMaXVJNzZ0MVU2bmFV?=
 =?utf-8?B?YzFLN0tnTEE3dWp6TTI3NFBOZnFrbTdYd2xJN0xoOXptWHd1TUVMMEVMTytw?=
 =?utf-8?B?Um1VcDEwNXdYRFFobUtYT1RENmNHTTRjdzRDVnJLTTYyY1BSNWNGcmR2WlRV?=
 =?utf-8?B?OGwrdmNMRjd2bnEzK3g2VFZRVXpEOE9pYmlJbGZwMHJzbzBJOCsrdG94bTM1?=
 =?utf-8?B?S1E1SjZiY3ZpYUpaWkdidlVTbGY5TTFqYzkxM2lqTDJyejZYN2lrSVh6SlNJ?=
 =?utf-8?B?ckJPblhoYkN2Z1VlSko5dWprYVRxakxwaGEyMzdjTW5UeFdDMUR2cnNMVUFs?=
 =?utf-8?B?UjZ3a2FBMGloN2h3VForYWtodEJxM0Rjbk9IZU9pbUNWUWFJVVRGK3VZWSt2?=
 =?utf-8?B?SDVPZU1za0crN3ZPcCtVamdKK0NYeFFob2dSc1pXdjY5d2xYb0V2SXRuaXNS?=
 =?utf-8?B?RWJpNlBkc0laL2p1ZGhEamwxRmNTMmtkM1R0dEZmMXlqSzUzbkJCWkNzam5w?=
 =?utf-8?B?WjhHcDZnUFJCdVFJN0tuZkxBMU5JNnlkcllLZG1YOXRZL2ZIbGhnNkVQdlE4?=
 =?utf-8?B?SG4yZWVPS2VLR2JROUNhOWorbUpGc2UvVGNtNW8xSEpyY0UwaUxMM1NLdUxu?=
 =?utf-8?B?eS9rQXN3azRySFM5dks0YXo2Q0pBb00zdStCbi9CRXAza1htUFE5NDhMUHpP?=
 =?utf-8?B?UUxFYjJ6dFlPVWdKTUFNS3EvempJeWZ5djUvY2tDbEdhWjVpNWFUOHAxa1lo?=
 =?utf-8?B?a3hiNU9SZisrSVBrYlcvYkczb0hEUmlYRVBzUjd3b2E4eTYzc1VJb093Vmc5?=
 =?utf-8?B?SWQxTk02UHJ3UnpPM0lPZXJQU1Y4U29aSEgwRy95WWw3OGUwREtjd3EvR2FH?=
 =?utf-8?B?VnRDT1hyb0JlV3Z0dnlhOXpOTklZRmNOVE1zSUR1eHVNcEIzb0xqc2xXU05w?=
 =?utf-8?Q?JQcyc7ONKhQdLfitluKZ1PCBDqVBcIzk1X+qow1L8M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4900c890-391c-47ea-3b80-08d9d172ca99
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 00:15:20.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sH88/ryoJcAlujMiQlxnpWgO66PtzfLHtrcPgFQIEfpU2dX30CA1y3PrUR+lseWslekkNs/yXQpacj9eN4CZAXJRwTfUUPO/1tm2/odDSck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 12/13/2021 2:03 AM, Shaopeng Tan wrote:
> If the result of MBM&CMT tests is failed when Intel
> Sub-NUMA is enabled, print a possible causes of failure.
> Since when the Intel Sub-NUMA Clustering(SNC) feature is enabled,
> the CMT and MBM counters may not be accurate.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Hello,
> 
> According to the Intel RDT reference Manual,
> when the sub-numa clustering feature is enabled,
> the CMT and MBM counters may not be accurate.
> When running CMT tests and MBM tests on 2nd Generation
> Intel Xeon Scalable Processor, the result may be "not ok".
> If result of MBM&CMT tests is failed when Intel Sub-NUMA is enabled,
> fix it to print a possible cause of failure,
> instead of SKIP these tests in v1.
> 
> Thanks,
> 
>  tools/testing/selftests/resctrl/Makefile      |  1 +
>  tools/testing/selftests/resctrl/cmt_test.c    |  5 ++-
>  tools/testing/selftests/resctrl/mbm_test.c    |  5 ++-
>  tools/testing/selftests/resctrl/resctrl.h     |  2 ++
>  .../testing/selftests/resctrl/resctrl_tests.c | 36 +++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrlfs.c   | 26 ++++++++++++++
>  6 files changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index adfd92145e12..6d257f40e6ac 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,6 +1,7 @@
>  #SPDX-License-Identifier: GPL-2.0
>  
>  CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
> +LDLIBS += -lnuma
>  
>  TEST_GEN_PROGS := resctrl_tests
>  EXTRA_SOURCES := $(wildcard *.c)
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 8968e36db99d..c5a49444c5a0 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -136,8 +136,11 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>  		return ret;
>  
>  	ret = check_results(&param, n);
> -	if (ret)
> +	if (ret) {
> +		if (sub_numa_cluster_enable)
> +			ksft_print_msg("Sub-NUMA Clustering(SNC) feature is enabled, the CMT counters may not be accurate.\n");
>  		return ret;
> +	}
>  
>  	cmt_test_cleanup();
>  
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 8392e5c55ed0..7dc1bdf2d0b8 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -136,8 +136,11 @@ int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
>  		return ret;
>  
>  	ret = check_results(span);
> -	if (ret)
> +	if (ret) {
> +		if (sub_numa_cluster_enable)
> +			ksft_print_msg("Sub-NUMA Clustering(SNC) feature is enabled, the MBM counters may not be accurate.\n");
>  		return ret;
> +	}
>  
>  	mbm_test_cleanup();
>  
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 1ad10c47e31d..4b8ad4fbd016 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -76,6 +76,7 @@ extern pid_t bm_pid, ppid;
>  
>  extern char llc_occup_path[1024];
>  extern bool is_amd;
> +extern bool sub_numa_cluster_enable;
>  
>  bool check_resctrlfs_support(void);
>  int filter_dmesg(void);
> @@ -85,6 +86,7 @@ int umount_resctrlfs(void);
>  int validate_bw_report_request(char *bw_report);
>  bool validate_resctrl_feature_request(const char *resctrl_val);
>  char *fgrep(FILE *inf, const char *str);
> +char *fgrep_last_match_line(FILE *inf, const char *str);
>  int taskset_benchmark(pid_t bm_pid, int cpu_no);
>  void run_benchmark(int signum, siginfo_t *info, void *ucontext);
>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 3be0895c492b..bbab4a7f37ed 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -8,12 +8,15 @@
>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>   *    Fenghua Yu <fenghua.yu@intel.com>
>   */
> +#include <numa.h>
> +#include <string.h>
>  #include "resctrl.h"
>  
>  #define BENCHMARK_ARGS		64
>  #define BENCHMARK_ARG_SIZE	64
>  
>  bool is_amd;
> +bool sub_numa_cluster_enable;
>  
>  void detect_amd(void)
>  {
> @@ -34,6 +37,35 @@ void detect_amd(void)
>  	fclose(inf);
>  }
>  
> +void check_sub_numa_cluster(void)
> +{
> +	FILE *inf = fopen("/proc/cpuinfo", "r");
> +	char *res, *s;
> +	int socket_num = 0;
> +	int numa_nodes = 0;
> +
> +	if (!inf)
> +		return;
> +
> +	res = fgrep_last_match_line(inf, "physical id");
> +
> +	if (res) {
> +		s = strpbrk(res, "1234567890");
> +		socket_num = atoi(s) + 1;
> +		free(res);
> +	}
> +	fclose(inf);
> +
> +	numa_nodes = numa_max_node() + 1;
> +
> +	/*
> +	 * when the Sub-NUMA Clustering(SNC) feature is enabled,
> +	 * the number of numa nodes is twice the number of sockets.
> +	 */
> +	if (numa_nodes == (2 * socket_num))
> +		sub_numa_cluster_enable = true;
> +}


Unfortunately there does not seem to be an architectural way to detect if
SNC has been enabled and the above test is fragile wrt the assumptions
about the topology of the system. What we need is a reliable and
future-proof test but I do not know what that should be.

Reinette
