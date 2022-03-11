Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6DC4D6A3A
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Mar 2022 00:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiCKXV1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 18:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiCKXVZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 18:21:25 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC4C1520CA;
        Fri, 11 Mar 2022 15:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647040821; x=1678576821;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sZ4U6SXH1B8m6HrY7484581FZGt4fDJ/dJfagMqENnI=;
  b=X7fKOrnXZVy0CQaNH/w+9v34LCIIpLeYoFVgrq1DTw+Mb226Q//xsxkb
   HF0oXbwIe8EXlZtV3s0lRJTv+J6o3jVzqv18WiGujt2ApB5eXu43hhUjv
   wc7YWeN8Geo47ZvqZ35ki2LKXB95O+3yyFz2tSdGhjwaNJSnqcW2/aomL
   wmzN4DagwGQvMF5bJRrdM+UXSycoCbpL/MtlAH/WPJCoySz9Z2lOJKd/8
   5zpEs+/CmPmbrpvBrg5rcRDDAugNuOcYjio8h5viNL3g+YCVylM3/hKNW
   NpsclNj3IdjAkAhsTtiI2iuosUxF9f6sj5dZzxlKE+oUfKoGQITkrnUhM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255861147"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="255861147"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 15:20:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="539175377"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2022 15:20:20 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 15:20:20 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 15:20:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 11 Mar 2022 15:20:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 11 Mar 2022 15:20:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jogfJMLEPiFz0MFsRl9l70RGw9ECdn5AZVc6pQJyrLBXvHj3NA9t4bMgXc61XizDxQ9mEJUhq8BMzyQMGjQiN2zgd+f4aV/yJmYXDKiFWXgtUQAjnP9QghwB6WPUgsep/A2kq3eyngVx3D1MergP0yxP4ghidkaOjXX1ZmQr0ZsJNeC0tDDTR1T1tz87036pKoNFvLs1mFRxyl5nrDWSUO27/VxKKOTywM0VRsTkm80jJF2PvoFWWVAPVSnq8jf8b/06DbHT3ZS+O/8cS93oe2Y0SAJ2m99owCsIs7szQtiYoUGF5m/+FJxYsTIAMSokhDLMHdD1RVIyHxlB6ntV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WvmHy7+k3AqecEOriYt2tpQ0qBFLV2KiHjLV+xfUX4=;
 b=SOIJ7XvqqS8KW/ipQId+b4qtzkfmsVYqQX8ObdVt2Vvo5vz/g1BG7iCvgmf3pZFwsni9ofnQkeA9JfOrm1KMBIaSua4vp7kZyg4Ob8lE3LjQNF5YKRkREPDBEmVCmF9lU1UoixmXAyUv3f5V7FYdFj9MI3CZIRXw1wa3Yx8NeFWAWX/9xreRZ0mVUa0rJFsiL/XqM+qI6xN7BzfkkwgrHwaILcOg5tibWuxn4M2esyrD/10fiarvop144/AquqTa/4qb46Ws3/H9R8mvpiekufRrudEXAKVq43+ztzM1GwXf2mezFIahfdJA6NKaL9VHU6tU1yx26ZazlvzHZsr0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5740.namprd11.prod.outlook.com (2603:10b6:610:101::7)
 by SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 23:20:18 +0000
Received: from CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::b432:16ba:2819:d702]) by CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::b432:16ba:2819:d702%5]) with mapi id 15.20.5061.025; Fri, 11 Mar 2022
 23:20:17 +0000
Message-ID: <44e4d46d-c0cb-8010-4ec9-34441e1d2cb0@intel.com>
Date:   Fri, 11 Mar 2022 15:20:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH v5 5/6] selftests/resctrl: Update README about using
 kselftest framework to build/run resctrl_tests
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com>
 <20220311072147.3301525-6-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220311072147.3301525-6-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:303:b7::6) To CH0PR11MB5740.namprd11.prod.outlook.com
 (2603:10b6:610:101::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8901fe80-49d1-4962-934a-08da03b5b45d
X-MS-TrafficTypeDiagnostic: SA2PR11MB5180:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA2PR11MB518007C1C651F252B3F94BACF80C9@SA2PR11MB5180.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8O3EPbRPKmKvqWSOvSHnLmOe0S+EFWrrIknWTOcbDQTOFw+MjKYyojGHKWYz4ILQBu1/RyJEqe6ZdnxtXUX7CRwa+xtFYXJc5HQwEJmtPO3s7q/eKPs7L+Tva8R9TRvbO37YTLhY38CBN5yiqutGwT0sf8JePq5eUTi/xQo1/Ukwg2pe/hO8wKJaAGF108aepG4CRYp28sj7KkULjDFbU6Tw0XwJvCgOeC0/i3FkZzcNKFYeMmJcxSZOSuWcbWHwjTYe7duIXXbcor6h3vmZlPOdeigz+z6Fmwmb2BsEt5FGejNCQQyxckHwz3dcBMkv03T0sCzoPsMabtoYAWuFKP5+Nfr50sPvRO2gPdFVhcConGTCYq2123JdzcUp/NZCqHZQGtibQBYFHBJLcU5IZdXNbzIm/ywCLZ8Z0/KEn4BEOR7fTbZ4VxKgKa1J52rTfY5f/dFXmh7XE3Rxfeliae/ShRhRrHnt9TctHpMm9JXtaUF8cQF+KwgLVWoQrYNlqVfe3jgY2DzTasT4u1fHzB4uX+wEMgMeDlwHS6jMVr1piVN/HmV75lC85YlaPE9UOe5mdyxzTLvNiAfu3Mzy5Qn6virzKYra1evZUKqSFqXzLd7Mm2t+38nWJCUXe3f6ExEE05vfbfJ93I96W+sm6SaoRkmBOHUVtCpulvNyTcWJJdk6DkNo779rRZmctUU5oO3i9MwciXSNeNB9LaYy/3s9qwugxtf1CM7SEZWElXRH/c9F/GgJq2FfY9punPW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5740.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6486002)(8936002)(8676002)(508600001)(44832011)(66946007)(66476007)(66556008)(110136005)(316002)(83380400001)(2616005)(53546011)(6666004)(6512007)(6506007)(2906002)(26005)(186003)(31696002)(86362001)(36756003)(38100700002)(31686004)(82960400001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWFWdHZMS3h6VE5pK1JleXZ3SzdtVkFxK0NaZDRheVRZY2lTZVdDbmtaSDlQ?=
 =?utf-8?B?YXVEOFNraU1yNUZPTXFTSll3SXBldjE1TWRxS2s4V3RiUGh0M2poY0M5SWVh?=
 =?utf-8?B?dnBhYzREMjF4ZzVpOVlYMjhoeHBuQVpkRHJrZDU2SVVCNXpueVgyTlNWUTM5?=
 =?utf-8?B?TzA4Q29zY0pzQWtKaDZVMEJCc2FyaWN2bkNkZzc0WU9pT3pXVjJoeWFvOE1r?=
 =?utf-8?B?YXg3dGUyUWQrYTFWdkppRHpnZW1BcHdTcWY4MklRSjZXTmUyOEVRZDZ0eXdK?=
 =?utf-8?B?Nm9DeFV0bWJta3BENTBIOTdIZTl3ckI1YXJwSENkMWpLZFBoUzVoWmhQNVZF?=
 =?utf-8?B?WkpVQkpmRG1MWWpZM09zVW52dkFZeUpwY3VIa0hHMk1qMENRMVh0OVdFT1hz?=
 =?utf-8?B?SUNLbmlIZWdEcnJRS1hud2JJK2gvZ2ZqaVljd0dkTElHYXJLclNNclhQY0tk?=
 =?utf-8?B?UStvT01EU0IrMFBDOTBIZUE0MDVjbWI5YWRtWUN3ZmJVV2x4RGtXSDVlR3NU?=
 =?utf-8?B?U2gwblV4WWtBS1pOTm9LbG1Qby9lSkdCYVpCNm5JRG1pd0VteVpHTEI4QXBh?=
 =?utf-8?B?NTlhdjVpQnNTcHZMd2VoOTdQSDJObHpRclNkNjJpOGFqQTVqa0xSOHpuQkh0?=
 =?utf-8?B?L3ZrRWNmdGJML3VWVGxLRWFwREYxQkl3TzdnZmorY0dxekZJZXVOUS9HOW5l?=
 =?utf-8?B?RmhtRjdqdjlnVkZrakdlN1g1czR5YkJUSHVONnVLTHlIaWFPWk9pR01ZblNo?=
 =?utf-8?B?SFdtemhoem1hbTBtQzFST29xYzNvZlJwSTNSQ1piQ1U0K2tuNGt1a3pUZnNl?=
 =?utf-8?B?S3lnVGIrV0RUaHYzdWE3d1h4NVdYODdIUjlvTEJtTzZ3L3N4TWpBVXhlS0w0?=
 =?utf-8?B?THlvL2o1YmhzclAwbE5OMDZPWjZOOEtQWXhVYzhyU0t5OEtrYXcwTlRBNDVv?=
 =?utf-8?B?WmJ5dVlTaXhpVzNGQUNrTExNYURBeUZaOExaT1g5dXFMemRENDFvWG9xS0JK?=
 =?utf-8?B?Mm5YNmc1VThZUVNnTmk2d05nMkE1T293RjJtV0RTTmZpZE00RS9SblhSUXo4?=
 =?utf-8?B?RjZ6WXMxcHJ5UWE2L01CaWxJUk5QeVpjQTJCZFlvNUlMVFhsSFFldVhsN2xM?=
 =?utf-8?B?M0Fkb1RyWW1ydEE4RWtzYmNuYXFMcElmNGs0NGJpeUxSK09uV0dmVEZLV3Rw?=
 =?utf-8?B?T0dxQnArcDlLSFIwakIvQWxQM21uQ2xqeW1OaWl4RjRyMmk4cVRZUVJVTnUy?=
 =?utf-8?B?QzNVSjhhMnIwNlRjaXlJWjlzdkd2MzE4Q3RXbWRYbDd2TDNKaGY3ZnFDT0ZH?=
 =?utf-8?B?NCs3N09udGRrV2c1N2F0TzZnd1RwRjl1RWtSZGVWVWNQR0w1WjhPOUdnaG5I?=
 =?utf-8?B?ZkhvWjNCd3BndC9QcmE4c2JhQmFBK3VvZkJCS04yb3M4Ullkc1RTaUNDa0Za?=
 =?utf-8?B?bk90R0kxbFQrSlRHZko4UVVMSldPZmRna0VGMm9TMEh0VHp2dHl5c1Zhclgr?=
 =?utf-8?B?QVpUK0FBTyt6bHdQSkwzZHQ1VHZocmF4MUlESDJiM2sxL2tUWk9uYjY5UmU5?=
 =?utf-8?B?QnNEc3JxcFBVc2ZrZXMvbVQ5UHNMUU56dHc3N0ZhYlAvWGEzRzdQZmEvWG1H?=
 =?utf-8?B?a2tUcDV5NzBDNmxWS2tZOHZCckY4cGVNL0Y0M0owUk5Wb25MTmpqR2JCWXJo?=
 =?utf-8?B?N3haUy83YlJrLzhYK0hJLzFOeEtUN1djcW1CUm53d09qVnpNeUZpL2E5RG9Y?=
 =?utf-8?B?TlBjdXFwYnFxVmVXMnpJQ3FRTUlvbjNHUG5mUzNnR1NlU3NwZnpia0FDQjhR?=
 =?utf-8?B?R1JJQmtxYWpmbm5wNXB3T2ZRWnZYQkI0K0FzMStnc3VQR01VVUdaR3V2Sjg4?=
 =?utf-8?B?WU5qWUk5TURoRVYyWDhKTFhSazAxc3ZJS0xHa0N3T0QwS1gzMTE3Rks4eDdS?=
 =?utf-8?B?ZGJLNmpJMFpqdHZScEprZjVGTEUxVzFJazVwaDc1MzFMUmZzR1ZRRXp1NEJW?=
 =?utf-8?B?WVpmbEY0TmZBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8901fe80-49d1-4962-934a-08da03b5b45d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 23:20:17.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCzPmK7Kq/y7bASxyNmeUgLvgXZNoSEgAamzmhOv7Q2YZhbbtSdnKekTMAI+Vkv2jqXyxWeqGFI6hbRvGBpZGzxatH0TCTw9IWQJntbhh8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 3/10/2022 11:21 PM, Shaopeng Tan wrote:
> resctrl_tests can be built or run using kselftests framework.
> Add description on how to do so in README.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/README | 43 ++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
> index 3d2bbd4fa3aa..c74b8246e6c9 100644
> --- a/tools/testing/selftests/resctrl/README
> +++ b/tools/testing/selftests/resctrl/README
> @@ -12,24 +12,49 @@ Allocation test on Intel RDT hardware. More tests will be added in the future.
>  And the test suit can be extended to cover AMD QoS and ARM MPAM hardware
>  as well.
>  
> +resctrl_tests can be run with or without kselftest framework.

Saying "with or without kselftest framework" sounds good. Could you please
keep using that instead of the "use" and "not use" in the new headers?

> +
> +USE KSELFTEST FRAMEWORK
> +=======================

So, here it can be "WITH KSELFTEST FRAMEWORK"

> +
> +* BUILD
> +-------

Please remove the "*" to make it consistent with the "BUILD" later in the file.

> +
> +Build executable file "resctrl_tests" at top level directory of the kernel source.
> + $ make -C tools/testing/selftests TARGETS=resctrl

Please use ":" after the sentence that describes a command that follows. For
example, above would read:

Build executable file "resctrl_tests" from top level directory of the kernel source:
 $ make -C tools/testing/selftests TARGETS=resctrl

(also note me changing "at" to "from")

> +
> +* RUN

Please remove the "*" to make it consistent with the "RUN" later in the file.

> +-----
> +
> +Run resctrl_tests as sudo or root since the test needs to mount resctrl file
> +system and change contents in the file system.
> +Using kselftest framework will run all supported tests of resctrl_tests.

"tests of resctrl_tests." -> "tests within resctrl_tests:"?

> +
> + $ sudo make -C tools/testing/selftests TARGETS=resctrl run_tests
> +
> +More details about kselftest framework as follow.
> +Documentation/dev-tools/kselftest.rst

"More details about kselftest framework can be found in Documentation/dev-tools/kselftest.rst."

> +
> +NOT USE KSELFTEST FRAMEWORK
> +===========================

("WITHOUT KSELFTEST FRAMEWORK")

> +
>  BUILD
>  -----
>  
> -Run "make" to build executable file "resctrl_tests".
> +Build executable file "resctrl_tests" at this directory(tools/testing/selftests/resctrl/).

"at this directory" -> "from this directory"

"." -> ":"

> +  $ make
>  
>  RUN
>  ---
>  
> -To use resctrl_tests, root or sudoer privileges are required. This is because
> -the test needs to mount resctrl file system and change contents in the file
> -system.
> -
> -Executing the test without any parameter will run all supported tests:
> +Run resctrl_tests as sudo or root since the test needs to mount resctrl file
> +system and change contents in the file system.
> +Executing the test without any parameter will run all supported tests.

"." -> ":"

>  
> -	sudo ./resctrl_tests
> + $ sudo ./resctrl_tests
>  
>  OVERVIEW OF EXECUTION
> ----------------------
> +=====================
>  
>  A test case has four stages:
>  
> @@ -41,7 +66,7 @@ A test case has four stages:
>    - teardown: umount resctrl and clear temporary files.
>  
>  ARGUMENTS
> ----------
> +=========
>  
>  Parameter '-h' shows usage information.
>  

Reinette
