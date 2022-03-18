Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3944DE320
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 21:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbiCRVAv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 17:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240976AbiCRVAu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 17:00:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B2D1C34A9;
        Fri, 18 Mar 2022 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647637170; x=1679173170;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RbRmcjrXTYdFf/9F21Z7YNVXo23KXK09ZvEa7RvvB18=;
  b=e/oupNa0iV+GAYHKizTzsWvTLCiTXw7h2Igj0E/E5dk52zStJXkIIUxb
   e09THDTnQPaKPhDa9ElZ4jWxvjeXV5AetbmVfpWZCmNpBsmwD5JiiO267
   By+7Tt9QhTMf96SbeEwU4226XyAH9q1s2wa1NZuiOfjSdd3cXl+WkVHoe
   69RDsfc+eexsNtHxWjD8jYB1IfqwPLZiNfKvYyHj0R3QWl71tzRzS4ReZ
   OHFSALbWpL9hOzRm/ycX6fxr/RpaiOrXQVD1BeAn2wmfn2aSQKtrqOHKE
   czcFKudZCbYX84TVu+RfcHU5ZDPMMOXtNTOSnpIeqp4nIOE88/yWO6sgU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257174144"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257174144"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 13:59:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="517401899"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 18 Mar 2022 13:59:29 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 13:59:29 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 13:59:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 18 Mar 2022 13:59:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 18 Mar 2022 13:59:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9TC0RGquIS1nuk5/m0NUKj3vbUPRkrJfsHTSboUtN4oEDxKD9F7lrhrDPCYy5XwSZkpKJrFpQuXi/JDtBzU5M0BxRWYUximxmFRRXc9kHQjlosZVvkJ4uiWiRQ3r32eq5basB0gdjFnpn5kjtacQuNjqiNeES1fNQ5SHR1wGVzryYK91Xh6hk6XbqA0x5PjB+H3TPn1hH44MOSYmnDb+7LXjgwED5OcdlFCyrzB5SVB+FrQmpFsHLjqidV48IoJHRhhVxp46E0VD8XU7soy8O5E6Uf7NWGmBFkSqCRpku+CdbcFfCGbB5akehpP87ejcfXau+REjNANT76ppygs5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAbc3+VsrLyd1TDdJTChTabR73sUZi5Wa9PcOj0KCW8=;
 b=LB6e3z4aKscp4IIrKnz/YHlvKjpp/0ntQeCtYVOzY1gi/PHe5cKG+KmBpRroU1wEQFj5kfURK8uhd727CypvA4jYzKERoRq0rQXoneT+xMVtmMud4vap8LAWl92U0/ulp3PxE+g0SeHo8K+wJ69W4E7joAJlZhvmvuqm4ZVue4Ou+FXJ2iHUtxAq+mPfv8NX7cdVa8xhPKjvQO4nwMUC42DML558m5/WQtm7Ae2MCUoB5kbUKr6igHEEeZlf+jKVr0dcdjlKOq4WGNMZoBgjPdb9Y8CqbEaBLMyWS7k17RVnTAHUE/5VVvtEC1U0k2eZKhIk5TDCLddsQX5jyiYuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CY4PR11MB1558.namprd11.prod.outlook.com (2603:10b6:910:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 20:59:26 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 20:59:26 +0000
Message-ID: <a9d5ee7f-85cd-4294-2be6-8f7df6c982ad@intel.com>
Date:   Fri, 18 Mar 2022 13:59:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v6 4/6] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
 <20220318075807.2921063-5-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220318075807.2921063-5-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:104:5::32) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f8e4352-358e-46cc-edb9-08da09222fe9
X-MS-TrafficTypeDiagnostic: CY4PR11MB1558:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB155802F74777C998B7D3ED64F8139@CY4PR11MB1558.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LZvjVvxCk3UMa3kmrubU9Lmm/diuSIjFtEfolHzw5blQPR8O/UwpZWph2thM8PNxvdo3T+cjCldPU/nKn+kgFrpsE3wRdjmzy3TPWFOBhwC6CZNz7GNKyLiQYxo+V32l0YmgOxnHT5m1y0QT1CSm3KFHPRb2nbZSnv2Co1xdok9sHIawq3/HgcF144Y/mSqnsy/PQYZGOpHW7FTySWqAgnmomuQq/1kyQSy57qB4gjCcVvDLFMKuuKTOMWzwYqAbws1ED+PyKP9gojqOOEqZ77mv1lFgSUUnpf6q5z0p4Wsp6rdkGdPnkOQV8oK+Y3bhxrGMszK6v/iOYINRFkPGl20RRtJJcyG36vYDdhiSXXdjgCphLCR0JyzdMbvMKb1uI50ZYygdhAgkQVUzBjMBxZnUve8sFhnR6NOdNgrsR1VGKl86qlMCgTLQM+1ZP+TrZ4MKTmcfUQCo0BGoo+U09flb9oZ6bMUrcviz9fdaNgtnkBjqmCII+3AxdnuU6klz0nVNorj+XIowWwLocV4TuwwbzulvLIJmbCl88tQq5SJ1xsk4RoYxaS52KDMa7mFrlliZ0Z8eq7MKP6EGtUF1TATybFSUKsaQPyvcUj15wFfiPYtYXXkIVmtf9GFDjslua3T7a2VT0OQfqjf7pnnlb81lfFhq8Iibjv/aLihezQHha+/nSt6cZEIvZNd8275f+sIbdGlqERMQOZnTWhGEm/OeiFmqthOr8A/cMCa/WCaSuzdp7krmRlFk0gbukpF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(26005)(316002)(2616005)(6666004)(8936002)(2906002)(86362001)(6506007)(110136005)(31696002)(6512007)(53546011)(66946007)(66476007)(66556008)(4326008)(8676002)(6486002)(83380400001)(38100700002)(44832011)(5660300002)(36756003)(31686004)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWVGWG9pdnVNRlM5MTRCNDV5SGJXMm84V0RzdEFVWEllYkJoR2NtM0kvV0xk?=
 =?utf-8?B?eldzbmppRmwxS0JwQmtqNWtoNFFHb3ROblVnVWZWbEpyYTY2K3crem4zSnZn?=
 =?utf-8?B?cW1WSG5rNUg4MFQ4Y01OdWlOMFltQ3FWQ2NHbFpwL1UxL0d5NnR4U0NJRldE?=
 =?utf-8?B?dWZMTCtoT3JaaHZQUXJkZldwSFlOTHMyaVlMZTFGRm8yRjRaSzVlNkNGRG12?=
 =?utf-8?B?ZVNYcyt3cHRhNnZHcFZpYXEwYTcrRGtobTRVMW12TmZXY0RXdk9TdTgvdC83?=
 =?utf-8?B?ZVdLZmllcmJuK0I4WlRpdVhZVnNrS01GT1liekRWNmF1emVTVjVTSDFTeHhZ?=
 =?utf-8?B?VWZoYXRTZ0xEM3FSVUJIcEJHWThHaXVCTUtjblZlZFRxbXVIMFQ1VExueEM2?=
 =?utf-8?B?dnk5bngrZzgvN0Z6Y1hMRzF3eWpodGxURjNWV2d3MTBzYmhSb1ZuckZrMGRR?=
 =?utf-8?B?dVBibTdPWnZHNUM3dGo0b3RCQVhhNVpzNWRZaTlpUWRpM3F4WUNEanAyVW5G?=
 =?utf-8?B?WXZzTHl4aEtLS01mcUNLS3BzNWJNa2JDelB6ckhGdVVOQ0svRWN3bjkvU1Uv?=
 =?utf-8?B?VHZNeC9Dc3hvMzFuazVVRWpOZmlnekxjOG1OS0pkclZmWlgvczAvQmVxeU5q?=
 =?utf-8?B?ZUEreERPN0trYkh5dUFVeVZ6Z2UwSkVicDRDd2ZpcWpTbzFRRFk4VnpVOUl3?=
 =?utf-8?B?ODR4ZURicmdOM3o4dWs4MzdHYnU4RFZ5bmk1bzErYzZzWUFvckx6ZUJ1SUcw?=
 =?utf-8?B?d1hVbmF3KzcyOVNHZitUd1dLUkxwTnMrSUZNejNMbHhFSGxya2NHNFdldE9G?=
 =?utf-8?B?VnlMYWJucWdRYjNXdUJMWGR0MG8zUDRuakVkQzVKcW9HQytudk4rSXFuSFN0?=
 =?utf-8?B?RjZQYUZMcjkzdDV4NW5sdHg0RFFqZSt0U3ZBZFI5djFhSWRkWkpQNHpoUGgy?=
 =?utf-8?B?a0JycStKQjRENFZtekJSS0xqL1NQRXBxckxJWVc2NG9DclpLN0R4WlQwejgx?=
 =?utf-8?B?QjBYY0Q3bVdkOHBjMVNzdEhuL05nZ05Pbm1BUXZHbktMNUsxTFZJOEdMWXNt?=
 =?utf-8?B?Smo3MFBlZ0U1UlFwNmo4WkVSQXZYYTg1cDRGaDY2Y0tSTGdjSlg1MThJbmpo?=
 =?utf-8?B?bW9jeVMwM2RubExJWEhuK1VrMEk5VFV4dXpKdmg2dkEzTFpUWmhMVUZENkxK?=
 =?utf-8?B?Rld2UUZVUVBKRjVaVnlKUUpnZTBuOFVuSWg5UURFa0xqZDNWUDhqMzBmbko4?=
 =?utf-8?B?d2hYZnQ5OHlIRXBnSkwzUkhvVEdGa3U5bUJaR244ZHpTbENZMjNnbkZCb3Fw?=
 =?utf-8?B?THdLRjFoMi8zUWVqank5WUhWUDUrSEtEK0xHWExvRkxoWHBtbVJJV05uRWRu?=
 =?utf-8?B?dXVnZ1dGSXZBaHorTEtwT1VyS1Excy9ybGZXbmV4cDdaNUNTeW9yd2s5SGw1?=
 =?utf-8?B?czFmMjlyN1N4WE4xNkx0UTBGd2JWU295VVNHbmUza0tMSDJXNVFtQjE2L3E4?=
 =?utf-8?B?WENEa0ZRNGh4dFBLSTRHUDZ0cXBHWlhnUkh2NVhRU0o5MGlQMENPVC8vUXVB?=
 =?utf-8?B?cXpCMi9ONVp6Mk9YRXlEaVNWTVpzUHZGQzVDa0FMSE1CNkNCNUI5RGNWSlpH?=
 =?utf-8?B?NWhjSVBmMHRwSjNNUkJYRFN5RGRxcXZ0alRpSGh0ZWZacnZicENzK2FPMy9Z?=
 =?utf-8?B?eVJZbDlpOG4xL2EyQkRHcXNrNWFvRTVTeGEvbWR3STNWR2dhbUw4dElXeXBx?=
 =?utf-8?B?QXFsT0dIc2hjSlgvQXRnNFdXOHA1bTJJZnJUM2NqLzl4c3B2TENFZGFKZGVB?=
 =?utf-8?B?dHBZcDVjRmVQeVVnSTFXQ1hWcmU4SEE2ZS9pUGRWeFRmSkRXTWpUOXNKK045?=
 =?utf-8?B?VnJzbnpQWjBjelhtbXcvcGxEMGZCMUkreGZiV0FrWG9RWDRUWVpMZTg5VXkx?=
 =?utf-8?B?UVFIcTAyZUtwcGxqOUpzTkd0aXJYRTdPNTN3aDVrT1pNUkdJM1NhMWpncXpL?=
 =?utf-8?B?b3MwUE9taVNBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8e4352-358e-46cc-edb9-08da09222fe9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 20:59:26.5318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWd3cQNSWy1sgh9FK8eHrJ8/SlRSi1o30/Kip7HD0MySCXjRsVH7FTRvNzqsPsRyjQrceOJJQBAMB8Ual0tt+kgu2JFUjxWqm8vqasAwa8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1558
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 3/18/2022 12:58 AM, Shaopeng Tan wrote:
> In kselftest framework, all tests can be build/run at a time,
> and a sub test also can be build/run individually. As follows:
> $ make kselftest-all TARGETS=resctrl
> $ make -C tools/testing/selftests run_tests
> $ make -C tools/testing/selftests TARGETS=resctrl run_tests
> 
> However, resctrl_tests cannot be run using kselftest framework,
> users have to change directory to tools/testing/selftests/resctrl/,
> run "make" to build executable file "resctrl_tests",
> and run "sudo ./resctrl_tests" to execute the test.
> 
> To build/run resctrl_tests using kselftest framework.
> Modify tools/testing/selftests/Makefile
> and tools/testing/selftests/resctrl/Makefile.
> 
> Even after this change, users can still build/run resctrl_tests
> without using framework as before.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/Makefile         |  1 +
>  tools/testing/selftests/resctrl/Makefile | 17 ++++-------------
>  2 files changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index d08fe4cfe811..6138354b3760 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -52,6 +52,7 @@ TARGETS += proc
>  TARGETS += pstore
>  TARGETS += ptrace
>  TARGETS += openat2
> +TARGETS += resctrl
>  TARGETS += rlimits
>  TARGETS += rseq
>  TARGETS += rtc
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index 6bcee2ec91a9..bee5fa8f1ac9 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,17 +1,8 @@
> -CC = $(CROSS_COMPILE)gcc
>  CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
> -SRCS=$(wildcard *.c)
> -OBJS=$(SRCS:.c=.o)
> +CFLAGS += $(KHDR_INCLUDES)
>  
> -all: resctrl_tests
> +TEST_GEN_PROGS := resctrl_tests
>  
> -$(OBJS): $(SRCS)
> -	$(CC) $(CFLAGS) -c $(SRCS)
> +include ../lib.mk
>  
> -resctrl_tests: $(OBJS)
> -	$(CC) $(CFLAGS) -o $@ $^
> -
> -.PHONY: clean
> -
> -clean:
> -	$(RM) $(OBJS) resctrl_tests
> +$(OUTPUT)/resctrl_tests: $(wildcard *.c)

With the addition of KHDR_INCLUDES care should be taken to ensure
that this work follows the work that introduces this to kselftest since
it is not in mainline yet.

Apart from that, for the resctrl bits:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com> # resctrl changes

Reinette
