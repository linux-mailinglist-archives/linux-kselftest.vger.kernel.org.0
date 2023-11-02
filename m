Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75337DF920
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 18:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbjKBRru (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 13:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjKBRrt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 13:47:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EBD197;
        Thu,  2 Nov 2023 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947264; x=1730483264;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1LqgLqgqHqnRcK3LF7d2G1EnmpbmGXjRCVFwI6OriWo=;
  b=jrmBbu6Vqv+3c8wns8tCNYAWLHjPqdn/H5BlGF4ACZsZUci4CMe1CP6k
   mmuFtUVuCyD7AKj34Xurr4d469jY21g3CWYYifW91P6+3NLgb0KknnicD
   bnDQAF+nnW0zU9HeIehwkBWhpyNyOZqiO3kwKgj9WD5KJZauH6h36I/As
   abcVUYXQxzyoX/ovEaYYfI+JQwuHQV/HkAoKeyjM5t6YMjzRFFyAfCA6+
   6fs2Rdn0zwdldmQD5XxYZkWiT5YwxnHSgnjBEW+In6y+vlAOAV685i5M4
   s2Kg138+cm/D4/h38V8soQsJSoY72vn+A6d23hvrqQEJUqd4ZfOIn/rFE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="475019887"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="475019887"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1092793475"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1092793475"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 10:47:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:47:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:47:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 10:47:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 10:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLmxcaWSq0nrsOA3EnsN8s2aHsn1XOsMvVbXAmL4+klQ3xixc6c0pxmIdTm4bblq2siEoqz790WN3VUccdv1wTXi+3mZLonaSlnR6VW+SbJauM/JuL2nWe9rYM6BTOceUl45FPnmMHoEMd42Xw6+XLhjkYuY6V7jECWeWzOCUbHdJe2C87PQPPg/Bd3DRYQe6vWmjXxtmmgk/309CA8gkpF9Y4OrPrSFAp2kw8T00ZD4Zote9cRHTo+uIk6YPJkygwrgM11MXCNjZk+C73yQt9yWKQJlhKLpxMU5yBMifigSwymTNcgdSGn7zWLcaUDZag+R9cOpXLMdBLb0BP1zkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSAx6j71ppF9jy37YRby/0C4L9avG6G7GrIge+AlxUY=;
 b=RJnSDS1PTPHCkZeSWAJ6aG4l2uBCvYw2EcXEBXbqmWB1eOzc5+GaWhWE8KQqHrGLOyLAvhD6ebek9bqfrjHlAUHKoixzmJBRSY8mtvnAf16h/BmoNkM6a5bm0BjL6erKGhcJRKLlQpN8KWrYVc3YXiG7FsCcN6yjOXBj0sxrYd5nqtroXqILVskwfqQYuS5KaDUZc+Ee6H3BMA/qoiCmGn/BXmP95Mo77NfhbCJt9KqUqIWawu5Ex2p+EOTSw7MT4Ge0AVppNKAX5KnU7sFdH5nbaeLmGhiGVmFtL1uULhnHfarbXG7lAOW85ax8YvwnrXjhIvMck49WhcJMIISFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6857.namprd11.prod.outlook.com (2603:10b6:510:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:47:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:47:33 +0000
Message-ID: <3849d986-caf4-41ad-85c7-11f11f986e1c@intel.com>
Date:   Thu, 2 Nov 2023 10:47:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] selftests/resctrl: Create cache_size() helper
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-6-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231024092634.7122-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: cd83f3ef-8eb1-4fc0-c234-08dbdbcbcb27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0N9ZH/fks5ge77VynL2EB2RbhRgY+M8ZFyGsf/hc8sjI62VpAnQCJSA+ox+IVuzci442btpgqat8V2NmDKFoAJ0TtJT1dVW3Y6c967YvVepNcFcAbng+7ypRt+ec7B4gaU12HB71+GwLiqK0d480pbSa8QI973wCBHUNYi6v0uvTpCqnK17PDmeZ+XimilCRI5D1rjkBGt7lz33kcpTeq0JGGY3h+b3KL4hC3MEUlnchLa05aABebV5Q94Ksge6pPISOjgefoYpcifahDT2NzdRckVCXmCnDM3kfIDXNrD4GEG8NlOYYO9Ps/phHrSRosFjdnzUrCiI2hv9HsgzuIzUm5dDE3kRcLi6R6/RktoQ0Fbiv8fKJKmOS5WWcKCPaPYJREFwAe6OuPsUwZuhKNsIAmNEo3TpDr8FUktllCapMGSYXsamr4LKqf8Hw9OsCkKNVqlpb0wb/f6DLf/ciGKYKtudF3dU8WdgrW1+uXnrCFyvVSXU7m7ZD+YjV+kzGxjgFQZbtC1CySIf1k0IMgdDfoiEzxe/ekteqODvyWcdnYqhp+SgImLa3nsl0WNRdGUE7oYT5KrDZoUXvFLFyVpK/Ed+guEa1bGjTW19WnF6ZTn+65bPBrdekqjRJs/cf5lthgldCuHWSw7SltEpAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(6506007)(53546011)(31686004)(38100700002)(82960400001)(2616005)(6512007)(31696002)(41300700001)(86362001)(2906002)(36756003)(316002)(5660300002)(4326008)(8936002)(44832011)(8676002)(66946007)(66556008)(66476007)(110136005)(6636002)(26005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWxNbkpvU3FMM010TzhjQklxd1BjbWx2K3BDUUl2d0NBeHY0YlhoR0lxNEdo?=
 =?utf-8?B?QXY5YzUxSG93citYZWhidCs1TEpwcFFxMERPbE1XcXpBbHIzUEkyT1N3R0VD?=
 =?utf-8?B?SlI0SDZxd1lLK3lVR2JsNytsNmtnb1Vva0xaSVB3QU84c003OC9HWEYvK3R4?=
 =?utf-8?B?UkVINVhOUWtOKzRMa3NWQWczb0JKaWI3cXh5Uks4RFlVbHZNRW9vbStBMEQ0?=
 =?utf-8?B?RlZ2b0pnbzdjQk1tdHZaV2JMdjZIc0Q3aHV1UHQ4WVcrT0ZIWGNxc25ZeW1K?=
 =?utf-8?B?TEhPY0xtem1BZHEyblZrdUlmYWRXQzV2am5FQmQvRVhZa1RUY002Ty9ScTVa?=
 =?utf-8?B?eDZwUEdwZWdzbERjaTMzWjFFOUljK0J3eGZxQmI5N2dMRDBIYnZJamJ2RG9E?=
 =?utf-8?B?Q0JGRklDK2l1MnV3bkcxSEwwUzRlay95bE83THJmRmR6TUNhVENJL3MzZ2I3?=
 =?utf-8?B?ZzIvWkpFV0hrOU02bm1nR3J0TkQ0MElHd1hlZWhtMVVkcjBESFNHUndVUFln?=
 =?utf-8?B?WitaWXl0U0Z2ZHFKZDlCdDZkcTErLyt4WStIK3VDcjN2ZWd0aktqZlRWTWZI?=
 =?utf-8?B?Yjd2a20xaExtWDVxRUdTZEZOVDl2eWtaRXJpK2JveGdpVGlGRUdnUTJCbEYz?=
 =?utf-8?B?ZlFlRW1OZCtyNEQ1V2l5dk9ITW0wVW1qYy9sUG8vUGNhN3ZJc2hyWk80bGNa?=
 =?utf-8?B?d1pQQ1V0aVZrMzdiSEkzMDBpMzRrVVFnOUdYeHJRK09aeUR6T0NDTkw2QWJL?=
 =?utf-8?B?RHIyOTdrS1FXbDJuRS92VXBzWkFmVHkwdndJYSs4a2VaZFd2cy9aV3EzMnE2?=
 =?utf-8?B?azd6VlJMcmFBT01sWlk3R2dGS3FPRFZtWFQrbnN5MzE4M2VNcU5jcGhUQUM5?=
 =?utf-8?B?SlFLa1JNQ1I2U1FYYkRPU1dOUUdCQVlCcE9tbW9JeU5jdGlNMkNZTnhQOVVX?=
 =?utf-8?B?MGorR0diTUZ5YTMySUMrOXdjVm4zQjM0SlVIUDRmMzdNbGxsd0RvQnNyS2Zq?=
 =?utf-8?B?ZjJIbmhISjFnYnNlbVNxSkcxR2EzeWN2WTBPa1ZnbTRjUWZIZzJaNlErb2Vp?=
 =?utf-8?B?YmwzL2pUZzdLaXhXMWk2U2V1KytjVndPNzZLSENLWHlLZ1c2ZnlzUWNvRW1p?=
 =?utf-8?B?aWNBSDJkUFl4eDErMllVekFHYjh1ck1NVUFGc0NxbmsxTHl3SFEvUnFWOXUx?=
 =?utf-8?B?TUQyYVFCZThpTHplT0xMend1ZGtTSjk5K0lFU2c2ckg2S3p5NmIyd0tZTWpj?=
 =?utf-8?B?MVRPWE5RMWZ3T3poNk9sd1g0L3dqYkwvVXRZRmsrSXJuc3V3dk0ySDVRUFlz?=
 =?utf-8?B?L0ZVVncyU0pvaW1yVzdjdkxZTGtTdWt6cnRkMVY0YitibTcvdS8rKzhJcFVM?=
 =?utf-8?B?UTBTejV0dk1nUlcyYUxiMi9zNHk0S1RkTWJ1V1pXU0ZnRmY1bnBST2JON0FY?=
 =?utf-8?B?aU9jNUFRZ2JBcjFqdFJUNXdZQmlBM0lmMHBGeGZNei90SG1jN0UydU04RWpz?=
 =?utf-8?B?dlkwMnFIY0VmL2dWTmtHTGwvKzVHQTZKSDhBUHR4dlMzTGdHQ1Q4bjlPbnBH?=
 =?utf-8?B?dHJoNWduR00wTS9QQjc0L2lEdG9UQjlPNVZFSlBONndYQm41ZHE0OUIwcGhX?=
 =?utf-8?B?RXh4Z0VDQzk2UzZXZE80VkN6Tkw1MklIT2JzZ0o4NzRmTWdJQS80Unl2TVQv?=
 =?utf-8?B?elBNUUJyZkFlZFN6SWhqR1c2akRYWWQ4TVBLTXpJZ3czWmJISDdrTTJjNWVS?=
 =?utf-8?B?eXdQLzF6Z09UTnZmNlJCSjV0WVdrQWljdU0vMzJRYXlTWnpkRnlJVTlOdnhw?=
 =?utf-8?B?cjZ6ckRXaHlMVWIvY1JqNjU5RkdsRncyNERQNk9sMWZOWUtoVU8waWZkOHg5?=
 =?utf-8?B?Zk5Hb3BZTzdJRU1qM3JnSzQ4WUYxVnVEbmNrN1JiQmI0WTFVM0FhbjNpeldw?=
 =?utf-8?B?RGQ5TzhBeGR2UlpDUmZVd0dwQVREV1RsNXFxcEVBa1VSTGJrdGczdHMzMzBk?=
 =?utf-8?B?RHVFYUlRSndlNUJETllJL0hXelpVclMxc2RRckpLMXNBMk9LcGpzcTZwa2U1?=
 =?utf-8?B?RTlBQ082byt6U3VlVU1xWDVDRnI4ZGJ0R1VvekZwanoxRm05ejhva3pQQlRD?=
 =?utf-8?B?OHU2SS90S1VaNjBBdjZaNmI1NFhPZW9WK2VsbDVqbnBBSTAybGdHUDhwS3Ry?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd83f3ef-8eb1-4fc0-c234-08dbdbcbcb27
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:47:33.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USSZzLy/Ho7DtGO2AeYf2G5TWpmsempc1KJ0yCiRpp0nKu4tfWXdzEewx/MWfgS+QFRDHqgTLicyBLNeJzYzhak/eZXgzgC6gSx8yj7vofY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6857
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
> CAT and CMT tests calculate the span size from the n-bits cache
> allocation on their own.
> 
> Add cache_size() helper which calculates size of the cache portion for
> the given number of bits and use it to replace the existing span
> calculations. This also prepares for the new CAT test that will need to
> determine the size of the cache portion also during results processing.
> 
> cache_size local variables were renamed out of the way to
> cache_total_size.

Please do stick to imperative mood ... "Rename cache_size local
variables ..."


...

> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 2f3f0ee439d8..da06b2d492f9 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -117,4 +117,18 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
>  		    unsigned long max_diff_percent, unsigned long num_of_runs,
>  		    bool platform, bool cmt);
>  
> +/*
> + * cache_size - Calculate the size of a cache portion
> + * @cache_size:	Cache size in bytes
> + * @mask:	Cache portion mask
> + * @cache_mask:	Full bitmask for the cache
> + *
> + * Return: The size of the cache portion in bytes.
> + */
> +static inline int cache_size(unsigned long cache_size, unsigned long mask,
> +			     unsigned long cache_mask)
> +{
> +	return cache_size * count_bits(mask) / count_bits(cache_mask);
> +}
> +
>  #endif /* RESCTRL_H */


The get_cache_size() and cache_size() naming appears similar enough to me
to cause confusion. Considering the "portion" term above, what do you think
of "cache_portion_size()" or even "cache_portion_bytes()"?

Reinette
