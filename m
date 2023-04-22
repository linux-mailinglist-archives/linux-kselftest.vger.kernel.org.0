Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5223E6EB672
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjDVAWq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDVAWo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:22:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B121FCD;
        Fri, 21 Apr 2023 17:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122963; x=1713658963;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Te+zb3pLIdSuShARxbKi9jS7xPBOeYIfiKH9ZiHMqeo=;
  b=OUraGudfBohwERogZ8scNUvfwC6SSMiBfH9e1Lnu1syiRfcLtQ0Im3dn
   yydBOZnA8jcXv60aFbBjLpGt69eioWEowHc3gb/ywP/TOA1chPvLQtBc1
   twJasPF8iAsd0d+HBzmBVrvFkMJEiiAFiQLchfoa3nZu4NJ+6fC9UjlBg
   3WLwe8s3RnoOPv4A4cWda6h0yef1Pa5uQMQ7MywPKUAGkEco+mgEvVQKG
   N4p4d9nhfYYGTh+nhAqyYV+wIZefYSadQs17hcww6EMK8VNdGCnjh61iW
   2B1UJWY7wOm2KDWxEFv2nJu7RmuBU+CfY2RmVUXmoeYjAclo1FQnlRYUy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="346129320"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="346129320"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="722938816"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="722938816"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2023 17:22:43 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:22:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:22:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:22:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=da/993kK9Caq7akLmhjYt9fterIwpS4aLUeAH4QB75b6p1tHsjJc3P3w667b0O31Tn62qpPztO40re/rdB8LVTLRviJGy1nfa199HvrfS1L+lBzJyakw9uAKM69qNQIdNelmxjsa4pDiGt7TwBxeuN7Pc7R2Tkzb9MSWpP2sf098egE+ms8nTB86JT124IqAW9bN6Jsg4TJPYF8GOE2BpL2I0EtJQcx54kduEj5bmTckSaKNm/7AR03jhy2RS1JWke63nahet1CjJyThLMad3yP2PfuE9iffoo5CgctzDvNJSscbDqSdn8V+7j10QwV2Sq2obL/KOdYbATKZTtwrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcXtB0iXND2h9wK4XmIjX6lAv4nCf9I3pnGNFSeRlm4=;
 b=g+Ziyx83t3xpcZq8V+AxHpTpUOqP2D+qHYfTsW3ZoABcUoJgI2gO/wv+ZgJtkueOYxx3J6IwoA8wUhazcEZqAhzNR58OtfcOzdn7OtS/35xNaEmADe59IVZ1qW2wrS15Wf5s46X42Ks8BpGSs5DdhwIRvAQzOXtpeoplbsSyA08xuFwXktMJkniF1kQG+czeTWzzV2b8USXjYFwH9M7aJ6g4POQ2dZ6nNMhYD08IFFfrnCxYR4rFpcpT0vUCSO+jo8bJQRgQXEXDvMBpE8wVdbljc6JBShxU/GVmRvBb1tZyZsGkQ0S4VKSlIQ5Yban57GKMK87unOps5ewNzEpENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:22:41 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:22:41 +0000
Message-ID: <79d76793-b920-afc1-51e6-9e38781e24f3@intel.com>
Date:   Fri, 21 Apr 2023 17:22:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 23/24] selftests/resctrl: Split show_cache_info() to
 test specific and generic parts
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-24-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-24-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:332::27) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 708ddeb6-efb4-416d-a8ab-08db42c7af54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDHsssxumg6jimMzTjLmmD2HzlfUU5ddGXl0ysCeY43U/aDJu2eFi0xdlagEW1J8vaTmE2JjnW1HeJoVHjB0WNprq86wSX6qu1ksAArzRVCsQr+q7qOgPa9SrhImrEh9UOzqNCF55dfnIgBVSwCvhWIBKlnarR3uw4BCSnk84BI1eZVBEcpmKIozhNuGJyuCbgCy1bajZGXSOn+BanGEiJGc/Ea+9cQT6v7t562uJ69mpE0aZQQkDMJXRCS2rIRYTv44TEdNPJ4VIv9M/6MEY1umK1m0cqh5WkE3XesvpT4CatPDKeToQgUgFOiBqb32oygXOfp+ej/bcEXzzHKT4hZboAvR5i4KAKsLPkB3nbQJXj+WRmv3oprLu0v3spRgU4oRscZJY7ht4sHI1mtZCjdB0cxywApYbZzFn0dfwWCg9s2cC/5tpKPGHCO55vU6e9T1rGZCdYYE5I1oiNgIXipemVPMC+zbFJY+VGQWcPgQdP7tYV7jx09Caz2xMybZuMAlys99d3w1Nr3s7y/h6riR/Dt+629uPaaq6mOA/j5GfLH2uhIYgMEetDsnilLwyCGmI1H5WKeiZM06tclnGMhk33o3XbknyX/kPOozIE/vZy8Ec9wAeBiAiVOW07WMPDlCLxYn4odYyDx+7V4uy+LSxAgfaWHb8fDfiq/RTaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(5660300002)(2906002)(4744005)(41300700001)(82960400001)(8936002)(8676002)(38100700002)(86362001)(31696002)(6486002)(6666004)(53546011)(6506007)(26005)(6512007)(2616005)(478600001)(31686004)(186003)(66946007)(66556008)(66476007)(4326008)(110136005)(316002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmplODFGc2NBWUE1NHVVZnhrdytsWlM2WXBObkpRWk9HY0tUR1VFK0FOZW0x?=
 =?utf-8?B?eUdXNTBXSUJQTmN6T012NUxoeXo1NFh0S3FuZFZaN0wzTUp5Y0l4TkdIZFYr?=
 =?utf-8?B?MU1aa1NDSU5EVytEanhaVUZwZUswSk02R0FhNXdxczdHMTJtK04yU0YxemZH?=
 =?utf-8?B?M084cDZLVjRpVEswd0ZPb0I2SGRhWUhNWE81Y2E2N0hnTG5KMzdpUVBvUEJk?=
 =?utf-8?B?UCtlbXovMjVUM0JtWnpzUGlRWThsUlFvQzhaalBBQXhGVk1ScmdzVGthV3Zo?=
 =?utf-8?B?MFlSZFpWQ3c5NktkR0ZRZ1duMWRuck5qUFlvclV2UkhJZmxvclJteGNXaFF1?=
 =?utf-8?B?dTd4WEFxMHVmdjBIWUJCeTNSU0xBcHYxVE1IMkZHWWpIVDdEeGRQQzFZV0RX?=
 =?utf-8?B?VWs0c0dpeW9FcmN1OTlNREo2Z3oxVStTM2RrZGRvU280OVlSWldranZqRGhh?=
 =?utf-8?B?RWZJMzNLbVdCQkRMMm0yWTJsL2VwRUgrNllzWmQ4UUxjSitweVpWNFBQWFJ0?=
 =?utf-8?B?TUlMOFZuQ0s5Mzc5N3l1dEhFZkc5UnhBc21EU0pQcmJwNDU0SVJZSFlaZDI1?=
 =?utf-8?B?VUVsZUt0WHdRc2cxdnRhOG1GdnRPYTdKdktjZ0tmQzJMa3paTkVsQms1RXFQ?=
 =?utf-8?B?QWI3YzNhVEd4aStob1V5QjVubkR3ejRLdnFPU1ZCWC9vc2UyU0wvV1FkY1RS?=
 =?utf-8?B?WlQ0SFJRSURtZDgrb0t5aThWYTlxZFprQ2dkczB1b2hCMVowRmYzbWRTWjhG?=
 =?utf-8?B?UEJDbFRMMnlZNE9nbXJ2Y1RId3M4SXVjS3psNjdBZWo1UFoyaVU0NStkZTJh?=
 =?utf-8?B?T0tKSmlKR1hKM21Ga3JWYTN3UDM5c25oZVlwc0FvMDF6K3EvSVk5SGp3eUJx?=
 =?utf-8?B?bkhqbkI0NTV2K3UrUDdYS1V1eGhnbkt0Q1RxRjVKVWVqWXpwSlhnMVNDNnFY?=
 =?utf-8?B?M2FleG43NWZGb21JM2o0VFpRWkIyNXJuYWU4NThnT0VZekkvM2c3SlhzQi96?=
 =?utf-8?B?am9hd0xWRmZuL3RiUnlNOFhhWk90YmlJOFVBVFIyYWI5LzdvUlRVSUpaaDVu?=
 =?utf-8?B?YjdhbmpTaVZBNHRvdlNlWVpsSzRqR0xiVm5TSnAxZHRQZGo4L0g1WHBsRGp6?=
 =?utf-8?B?Tk1UYzYxZFNJc01EblZNOHdQOThMRUZ6OVZPRFJXRlJtam9FM0lqOEk0WTlZ?=
 =?utf-8?B?aFEwUThQbXRZR1V4NHFEWEJFK0pHUEg5czNvb3MwRkFFMWtCbjUvRENsUTJZ?=
 =?utf-8?B?US8yT0pHTnUzSDhuV1lPODVzcy9mMXZKRk9MR0ZhSUdmVElOcWFnZUxrNXdC?=
 =?utf-8?B?U3k0ajZsckE2MU9BOU1BeGp1c2o5RFdKcGhlMnpXc0xaWTdSTmVNMXZoczZh?=
 =?utf-8?B?d1NZT2FaL3g2ODd5ZW5YcEZ0b2w0M1FRWUtJbXNuV09YSGs3NitENzZJQkdP?=
 =?utf-8?B?Q2dxNlNOU251VEw3b2RKVEo0UFVVTno1LzVHMC8xVy9yY3lzRmh4cWkzOTZK?=
 =?utf-8?B?bEh3TUZ3aHZyd2hCVmduTlZkaVRob1p3R0ZrUEdsKzB2U3Rldy8xMlV6eGJa?=
 =?utf-8?B?ZTR2MVZJWmk5dGNJeGdKY081UDRDSnBXL3NNK2xhYng2YVhWSkVIcHZlOTg1?=
 =?utf-8?B?ZjlJNFJXYkg2QXpiV2d2dVpDQ1Q1MUpYMVo2bFFxNXFnQnhEcGY4UWJMekpH?=
 =?utf-8?B?dHBVTjJHbXN1RElqMXhiNXVZenJkeHlnWmtGTkdNOFYzV2dmWEhnQ2Q5b25H?=
 =?utf-8?B?TzlZaFZZN0RzWC9vekxsbm9oU1I0aldOcHBYeStmaXZxa2ZNeG5DWXhYQnR6?=
 =?utf-8?B?MnpTU3lhRWtLQ3VmQWxENlBsQ3UvUGJuNWQ5VG9rbUNKOWl3cVgveWtWWUdC?=
 =?utf-8?B?WWptQXoxZ2dkS1F6RWxNcVFQTnRUbllHa1E5eVlOMGdkbGc4YTdmSEptQkFL?=
 =?utf-8?B?OTNKczdLSDYxeWRBaVJ0cmRscUtLOWF3blQ5MnNWdUZEblpDR0p0MW9TU3d3?=
 =?utf-8?B?ekVTNHcvYW1pQjl2YzRnM29QNUdUTllVWnZyYVZxUks0QjY0bWN6cVJVRjV4?=
 =?utf-8?B?bXVEZTJLdFBuMjhaUFVGYWRVYm1WcUNhbkJqUDZVN25LQjVZQjZhT2hjdmsr?=
 =?utf-8?B?TEFrT3pNdUgyQzl3YzNGdDJ1NTFtTVZVdGYyUkFXWXZScFZkRUJ5M2RVa2NL?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 708ddeb6-efb4-416d-a8ab-08db42c7af54
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:22:41.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zmpt+jZPsGH1qaoyFI4B8Fx0UTxuW3aLCGlz0VGrf13/ieRzzKeCHOEpQX9ZlYps+oJhvCDCDaXgwmoZyzMoDIRs7sQEfu05WdhzQbGep4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6304
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:45 AM, Ilpo Järvinen wrote:
> show_cache_info() attempts to do calculate the results and provide
> generic cache information. It makes hard to alter the pass/fail
> conditions.

I find the above hard to read. How about:

	show_cache_info() calculates results and provide
	generic cache information. This makes it hard to alter
	pass/fail conditions.


> 
> Separate the the test specific checks into CAT and CMT test files and

"the the" -> "the"

> leave only the generic information part into show_cache_info().
> 

Reinette
