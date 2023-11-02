Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715D37DF936
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 18:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjKBRwh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 13:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjKBRwf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 13:52:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913E41A1;
        Thu,  2 Nov 2023 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947548; x=1730483548;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=52zFxauIkrBuuCS/R/7Syk/i0Tw4V63nJMjQyIWh/+I=;
  b=YXR1pc8fdFtUnMmSOKwAKmqNZH7U8ha5Cms52j8PdovneOOKqkT8algv
   cgcUPyDLfajHXSa1Qpcp5whtMuWo88fYRt0O387U/ChcSikLkO1e510SF
   IwrsIkJSLNmBNpve91X3uIHxidnWbAMa3ZzCRcQ/5OZKBa22iu5Pi94JH
   l9CCAqDivZZYODdKmNjTps51/fQ4PigLm6ONY2jZpj/EWSueO6eYNN3v+
   EDQXaBu+9rcKV2yrnkRFWrVVjZ1O8+YtA4U0DhfebM98yFKkGsLGoNjrL
   4MaW5VNNubcOPoo58F0NAjx1kK8m7s111Tv+4xo2fBMc+slFmdKIG7wIK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1705530"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1705530"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="9476343"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 10:52:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:52:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 10:52:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 10:52:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFVAXtm6uOOPSBeTv9gJGxRB8PtT94mLj5NxrLHMvP+quwKVZKzJs8qVkpcTLsW9AWrmkYObfY2rKjivwoLtys3nMXHWIZl4BElK2+iFuP5hyrt3PF//m8koKym9FCc/Z+MwVgZiQ6VbrV/lxy6fytkNA06YfgoP6WCg89Yb3F8xR8s3EeXKeJadmliF0J7hqJxR5xJHHtz+OZl/Hy1plBwUInLF2F3S28OBEPziBmQSKcKKNUekGVsEEepVeqmZ+QRnDDZtW9qec903KraCeg3UM2COLqQoZBaTnDsCJNmUdeKxpk5woZjQKtWk0H5gjX1K7c0bzn7anU/H27tTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiUQIZX1/e3QsK1KHbbPG506qTt8vnb5I8c5/e2VzWE=;
 b=TtEUO/NNoJ4iWl/ldww9tSg+FM+V1fI+CfFlu+ZvsKgB8eW3gwtSLI4/8QIBr5cE9Qty7zdwehZ6rHKsMxnVV6t6sR1mck0MMEHwfUnsDZ3jH3EEKrY9vi3iDJxQVVcGodFL4GkrqU/j4BYYyxkXErYrf6Rm8LMzVVhnSPGoV/HDylPYvIVyhDKdZPLszWFZJ1HTLfVhTJBmayYMauiKfee4dVlt8mc1YrSn/OgqRd8iF3IesbAznp7a2ySK9IjVcBC7kvxVfMuxBcilha2mPS7WEDxe+yC76jAEvZuyQ+iZfWgYGq0p9suCeACWR2h02OdGFtoC78z0wP2LAj1gBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8361.namprd11.prod.outlook.com (2603:10b6:610:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:52:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:52:25 +0000
Message-ID: <56769c01-e21d-4775-94f0-ef9f863c1e92@intel.com>
Date:   Thu, 2 Nov 2023 10:52:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] selftests/resctrl: Introduce generalized test
 framework
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-19-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231024092634.7122-19-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: 60832524-c153-4a26-a234-08dbdbcc78fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqJnOlAI+QO9WHP1kAkC/jXyxhjO5/GGU+i1KwrKBALpkDrpH+HfIy96flf2CuYCaNS3Bk5OeXNVbZYzVDCMBiCIsfx5gRN7GKB/Yg9igpZwpdYoOSSPrLVMr3TGG759zoEX5iUB5rSZKQ8kNgjWcpicR4q4AFKzjSjQc/YkT3PEjFmDuJNBjIhgKWJOyn3JdLPyK3AnwNTSQPXnsPJ+8i/mqxRKqKnDa2lG3ugAUKoc2AqekYxcGfouI/KONon9mE2WxnzfVckCQE/KWAc1H8Eua+Wb9GH1Ap509ZLBh6NGWBOImx4kM8Hp7eLSGZv3WCOmiUdoAGNXyQAfwT0GrsOhl4la1YYg2+m0qF1xXFYF2AiIxEi4r0LBQgosgXRiNxbs56mVFvW9v5SCg4dnryPlAFN2rLXxS2BNT535a32yb9ydiXnldNgfNTAyFljE0KGJYS5WQ9cINVtyFTl3n3qIU2ZIfjdB/3pdJs5B1x4CzdXuB9z2luywiu4lDnkW0O2d2/qwzJZNc2veMKzD754QK44o9nvmLPaEObKBKhch6DiC1QoOtVIz6lGSKJEwa2VDho8vjrdAy4efHv7iN1n5TP5ind2A3wJvzehzNKBa8FMEbWaAB756xYXTDzlV0GlEVfojAXjZWp/z5vrWCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(36756003)(6512007)(6506007)(53546011)(26005)(86362001)(2616005)(31696002)(38100700002)(83380400001)(478600001)(66574015)(82960400001)(41300700001)(6486002)(31686004)(316002)(6636002)(110136005)(66556008)(66946007)(66476007)(8676002)(4326008)(44832011)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3FsbVVDUlNsWWVWZitGcitGaFBETzNuWXhOanVqdkNRQnUxQURCcUNjSTVE?=
 =?utf-8?B?S0ZmZVZCdWlibTFJd29WSGEvY1BnN1R0SzR3UnFHczVvT2JYUUNobjBtOXVm?=
 =?utf-8?B?Ky9WeUREcjY4WDN1MHd1M1dDWDhIM3JZSmZVeGtLaHp6cFZGdzRQQzRIbjB4?=
 =?utf-8?B?Ky9uZ0pSdER6N0xIakhISmRLOGRGZE1JNHg2TTNzOEpKYXFtTEIwbldXQTI3?=
 =?utf-8?B?ck5PRUM0ZjdNUG1yZ3VzTUEvNzdOVmtPellHRFpnNXNnbnE4aXA5R0ZvR1lK?=
 =?utf-8?B?VHlRMUNjSS80Z0N4VFpJd0VXMmJGekRUeVRFa1l1UFNCcVBmL0d4VUJ6YlNz?=
 =?utf-8?B?TkJOU1BlUjVzUFA2TUc1cjQ3bDJvYWZWZjFBMTZ0L3haTmJKakM3NDRYZzEy?=
 =?utf-8?B?dGR4Z3N0WkFOajYvV2VvTklxOUtGV1g0b25xYWFGMGVpSHVzQ2trRzVOVzU4?=
 =?utf-8?B?aVdRd2lSR2YwYVlyVlhERmFsTjlseVpJMm1wYkMwaVp3VStsR2I3a2NlMk1O?=
 =?utf-8?B?RXk5UWk5VU5sVzkwckMzSmZ5NERFZmJhYmZsQWpMTHpqNGt0VmJwUVAzdE1m?=
 =?utf-8?B?cHhTay9XNi91N2YyQ1RpOXo5Q2VnUGhqSGZGQ3hLV0wwUGNIdzE3YWNJVWIx?=
 =?utf-8?B?V0NvWHpYckRZMEk5OFRHUU0vR29TSUxOMlBzSS9sWmNCaExtZkM1TGhudTdo?=
 =?utf-8?B?RUFmbUE1a1lxd0JDbHZUbVNoS2ZPVEZPZG5iS2lZdGJ6dFhxVEpPTFExQjZW?=
 =?utf-8?B?VGt4K3R1RDR4c1hrYlJWT3lqU2xNVVNFdk1KZXFxVVVLdnRBOFp5WmZjUkU0?=
 =?utf-8?B?L2tjcXZVOGEwbjZobkdLemtuakpQOXBrdW9PS3BLeVRTNGtEZVZpMGY1U0cv?=
 =?utf-8?B?Y1FGRkc0MjJLWHQzT2NrdjhrbTdaSzhHelN3a3FIRVJuS1Vpa2c1UlRhSlE5?=
 =?utf-8?B?Q3REKzZtVGhlT3RHTVJJRHhZR0haV1FvZE5sTEppOU10ZXdtdzU4ZkpNTmVn?=
 =?utf-8?B?MTNBTDRvOTQzTmo3dHUzamdOSml2dS90N1NsSGZjTGF3RDlLcFhOYmh6MjFz?=
 =?utf-8?B?QThqWnVFU2lFM3VJSXlaMld0dDlhTmRDTUREdDd0RmpsZXM3MHd1TXI3a1FB?=
 =?utf-8?B?QkY0eWdOcEhoTkR0SFM5d0pQdnBMbHovMTAxZ090Z2MvZmU0QjVzMmljQW5h?=
 =?utf-8?B?OVlrYktpd1lOSWRUUVhFZTE2QWtCODVESitVTzY5eWVVUC9ndzNlOW9BMW9D?=
 =?utf-8?B?MGZna3VPUUxFKzRLcmpUQWRlU29ZVVJVeXNVM1VxS3JsWEZGWkpEMFpzS0tK?=
 =?utf-8?B?bkgydUlBSC9XVXl1QmhQYklVOFJsMmhwb3BaVm5iUi9oaWcyODhHK0tXQXho?=
 =?utf-8?B?TGQ1RytIbTZBcVl2TjZXaUFaTVVsSFdsNUd4UzI4dStCaXNYZHJOcWpCanF3?=
 =?utf-8?B?V2kvYk8zU1lZeU1kKzYvbjY1MlBlZmxmN1F3d0JYVG42RWhtSU1LanpuU2gv?=
 =?utf-8?B?NnQ3WUh5MHlka2U5T0pUSllOazZRWk1ub1dCVWJUVVRDRnVRcnN0dk5qRWJY?=
 =?utf-8?B?WkRkczdCRGFSZzI2cVBBYVJoZ0QvZ2poNFZOMmJOMnNxdloxZTJXRXluaFRJ?=
 =?utf-8?B?S3Q4bXE3KzJzVGQ5czRvWm02c1lsV2UxUFdSQzd4ZnAzcHdwQW02WDV5UUJF?=
 =?utf-8?B?WVhmakVPd2J3N2xPUUpkR0pVZGYvVUd3MU9lNTJyMm5GNVJXMkg2UFZYUFJI?=
 =?utf-8?B?bmszMWl4Y0ZMOXdmSVRRaFJiRXNZTkZNd3NQVHJVU2cza3g4V1l4SW1xaUZq?=
 =?utf-8?B?Q0pzNUs2MlgyaFp6TkJLUXJMM3Zsa3BEYU5TMVh1RXRxZ20xU2JTY3J4TFAy?=
 =?utf-8?B?aThFL0x0MU9IUnJXMzdDWUd2NVoweTQ4ODkxUmRqTEYvand6WFpiVE00b0Z6?=
 =?utf-8?B?VDNFNzVXcm4zVWtoMzdBSXVKYksvbG5PQXZCdFNHNEczaXVCOXFlUmlxY0dH?=
 =?utf-8?B?WHdNOElmYlJsbFNCcW5LMzRzSU82RXpsRUgzNGpHangzb21ham1SODNOZGZ2?=
 =?utf-8?B?SWliWCtRSXpiS0RqbXNjUnRVekl4WkZQbngyZG1xT3hQdGVNK2JhakFNOEc5?=
 =?utf-8?B?enNVU0hxNFBSanhvZmRBK3RucnYxUG9qNHJXWWp3eWhnZkVBQjQzL3ppZVNa?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60832524-c153-4a26-a234-08dbdbcc78fa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:52:25.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUMyY0hpJbxDqW162I1qWB2Yv6HL7oTGniuE9l8fz1OB/5bNqEPUcvD8D2oHpkzdakDRS+mrCZ3ZMgmMM14Y8xzF0HLQmKl2V9AS08pjRX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8361
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
...
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index ec6efd36f60a..e017adf1390d 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -37,6 +37,8 @@
>  
>  #define DEFAULT_SPAN		(250 * MB)
>  
> +#define ARRAY_SIZE(arr)		(sizeof(arr) / sizeof((arr)[0]))
> +

Shuah worked hard to remove all these copies within kselftest. Please
use the one in kselftest.h instead.

>  #define PARENT_EXIT(err_msg)			\
>  	do {					\
>  		perror(err_msg);		\


...

> @@ -233,25 +183,26 @@ int main(int argc, char **argv)
>  		case 't':
>  			token = strtok(optarg, ",");
>  
> -			mbm_test = false;
> -			mba_test = false;
> -			cmt_test = false;
> -			cat_test = false;
> +			if (!test_param_seen) {
> +				for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++)
> +					resctrl_tests[i]->disabled = true;
> +				tests = 0;
> +				test_param_seen = true;
> +			}
>  			while (token) {
> -				if (!strncmp(token, MBM_STR, sizeof(MBM_STR))) {
> -					mbm_test = true;
> -					tests++;
> -				} else if (!strncmp(token, MBA_STR, sizeof(MBA_STR))) {
> -					mba_test = true;
> -					tests++;
> -				} else if (!strncmp(token, CMT_STR, sizeof(CMT_STR))) {
> -					cmt_test = true;
> -					tests++;
> -				} else if (!strncmp(token, CAT_STR, sizeof(CAT_STR))) {
> -					cat_test = true;
> -					tests++;
> -				} else {
> -					printf("invalid argument\n");
> +				bool found = false;
> +
> +				for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++) {
> +					if (!strcasecmp(token, resctrl_tests[i]->name)) {
> +						if (resctrl_tests[i]->disabled)
> +							tests++;
> +						resctrl_tests[i]->disabled = false;
> +						found = true;
> +					}
> +				}

Could providing multiple "-t" result in the test count not
matching the number of tests run?

> +
> +				if (!found) {
> +					printf("invalid test: %s\n", token);
>  
>  					return -1;
>  				}

A great improvement, thanks.

Reinette
