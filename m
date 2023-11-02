Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD647DF924
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 18:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343712AbjKBRsh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 13:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbjKBRsg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 13:48:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36E3195;
        Thu,  2 Nov 2023 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947309; x=1730483309;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XZwevtLYNukDO+6hdz7OzpYND4oigVaHX+JbFZIEbyc=;
  b=HAI77iivtTxCOU6z7kl2dUdXvjG+OzuK+HEm1Rbmx1X+pQC0ETqZu8t8
   1J5mObWMMDxHBZUeKykGX7FePK+tV9xw8pNB9peO909he3Exd8D/LUH8r
   aiZWVqaA7SKdZofNizIwVuKBnvlbYI6utbBxhMvZOwricr8yxfQ9Xneq1
   no3jTo25OOEQzwS1Hm+P0OY7tyHD3Qfx3EisWUGU07D+8LCgW58E4CC5f
   Pk+JcLFCzYiSncjieulLQeshwwkqGEB+op/Qwam2A2JadDxbsQAGqgJyx
   eMcFsFJKUHzq32NE8+RbW+XkhEJWEmMm7a0vaeRKzSIkQwECv+E6+AFj1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="475020045"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="475020045"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:48:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1092793858"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1092793858"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 10:48:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:48:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:48:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 10:48:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 10:48:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eval8rruOeWrRAAbuG+vkr9xibgdaEsr15v5uFOR+tn4h0hB2d+W2v2IwtN+zLZGyzOmb6O9sqk18Et+/P43wvU2XfuWCsPEHufNszmWoOVS0Xv3wc8/w+6ce3JymHGANQqxuWh5tORlA9Dh+R7ulYCImMrI4aj8lzKdMzcyZsR1fm/vdyEmdduuSr48DiB9ivtWP/xpADTf3JlPu16ayX9Io197sLE8Tvpht8Fj7SdchwpSb4iaw/qRXT+w3451loygsjgQng9oMLfp1DfnNzaY73LMW7AJfA6DWQ99ZR3mXQT+thicw/u/H89AcDY+8uLqQrSXFq3fQBdRh3nblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIA+9S1ULY8ajGtb92k97DV6DVbcyUQjbBLgGXRPHy0=;
 b=XDbSAlqiKNph+2WZsCQ/3yfdQcJb6jSOk1lF4NvyasCsnHxOzztntqGN1IFtR1SkExrY9+AzIGetwQliiFayS/9GI/2inoA1RM11DFICEhQtbprCQ8eqZQFNsY0xST3+2qgE5PzhATpvyx6XYCzibmaG5lysFIC3PeH0WXA2fgPKsyXX1N0Uc5XCFTqE9TPZ6aEhMFvaLe4W+Qt41ggFptL4YuXqxTcTu3Mr83q1M3ueVrxTWTtl0V2bh5TwxfUHsK47Bd1+0scwU5pczi3qRzwoqGS9oSwc8c6VVslokqgwnkSKoXbiEX3EUI/xM8+y3zRjteOQV8phWVIbQgeZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB7949.namprd11.prod.outlook.com (2603:10b6:8:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:48:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:48:22 +0000
Message-ID: <12945b6d-0cc5-4dda-97b3-ec2b597f6ad5@intel.com>
Date:   Thu, 2 Nov 2023 10:48:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] selftests/resctrl: Split measure_cache_vals()
 function
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-8-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231024092634.7122-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c1de1b-218a-4144-f329-08dbdbcbe86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aw484XvKsJzyUpelwzNqg+KeUrMXRty70R09c7PQj1d00/y++S/Nevz4nbdDdMd1A5RS9DkAVBFsIOfTRWTYZpEhY/5K+xDcpDcNxuy7ZQmU+8w4g8C5Ylelx5J/054LX5/KLeTY8ByLVZzfWA/Eel5celvMAU47abmftSxC9btYrUctIu3FS26ovMxj+Tn6xosRf8c4DsKqmQz57CYVJidXYu8s4O1G8F63gcAPwaDlSXR/Pn+Sz3/ys9Aw2D8bqVfJp7Ys4uExcbBC9DlDzUigDZ8GAu1QwKbSrtkCqwYDVLJm43oLhHsAByF6g0ThWAQ+qCQ3BDAJ1iE+G/CikRO6UIXZILoIdsf+t9M5MQqf//DTQkrTnE6eGbBrapN2c2GUjm8SA2PVhcksZzygXvvsP6YbGbE/S+20jLKiXuUEOvZJpEP9Wu4mrLM2RXWdom34474Br5IMvV9qPGcvoq4ID5Kx4bmTZT1Z67O7KX76PIz2Mq8KqmWSDH1XCqVIDx0Kol5pj20UqUEWJBylWfQHzlqoVBikMfSl5nvhleD/VgoXLYtEQ6bofzdUNfmvklYhOrkMrunyfadofsD8I37AVkzDD3KsjtM41LkVpalhEIfD6Pphlb2oScHEmrqzKc/neqVI+NaSuF1JXVRzgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6506007)(2616005)(53546011)(6512007)(83380400001)(26005)(66574015)(82960400001)(5660300002)(36756003)(31696002)(31686004)(66556008)(66946007)(110136005)(66476007)(316002)(6636002)(86362001)(44832011)(8936002)(6486002)(2906002)(38100700002)(8676002)(41300700001)(4326008)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXhYcXZPbmovMWRwWXZPQWRqV01vWS9lcFZGTG5MaThYaEl3S1pzelA5U0lw?=
 =?utf-8?B?dlUyeHZFUVNNUFJkVkdTM21wd2hnTFdWbUV2bnBoRm0wUXFaLzdBdnJSdC9l?=
 =?utf-8?B?dU9RWnZSeUdITGY1UllSMG03NC9aR2Qyb09pZG5GblpTdytxQUxCQlBYelJh?=
 =?utf-8?B?YkkwZ3BiTWgvSE40dEl1ZGNvZk1mOWw5S0pIeEJxYmdjT0JMZG1WZ1hmVkVu?=
 =?utf-8?B?dGdyMTl3T0JYVUNiN0VRMlJ4KzlzNkdEbE5kMkRIb0Q3Q0JMdXczamdkM0RW?=
 =?utf-8?B?R2pZMm5qM0FKbVFWL0tLdlZTNjBnYlhrdUUwdC9NbXNmaHFlNVovdE5JUGZ4?=
 =?utf-8?B?TlhWc0JzZWJTZmE2V0pTa0REcnNIaGIzcUlNellzaUk0em54TXN3TWVWbDd0?=
 =?utf-8?B?b3YxZWJmdjhTdGZuS3N6SnQ0a1hINUN1cUEvY2dWajNlZ3dHazJ3UE9VQy9F?=
 =?utf-8?B?cHpnZ3lZYUNzRHk0UVJQNzE3Z1NMeDF6OGlQOFBhOUIvSStSL1R0bFhLN29k?=
 =?utf-8?B?VVFLS0xERGZoUG9UWnV5NXdZbWd0aU02Sk95aVp5SVg0T1VjTmtzNUNZU2dT?=
 =?utf-8?B?R0RTT01ZUXdtNlZMUm1PL1JaNjZWWFVmS3NKZmtvb2xwSjR6Z1hXN0ZQUFkv?=
 =?utf-8?B?M2FGVmtFdjRreGlIbktjVXpMYjBwSnJpWWpYZFRpUHlyUzRMdkd1RG90UjJ2?=
 =?utf-8?B?dnNubmhPUjhZd2E3UlFQOW11NlBSS216Zy9KUTl3cXJDcGNCRnJLRlJ1YktD?=
 =?utf-8?B?YitSZ2s0eU1JL0RRNUY0VVl0TjVRSnd3a3ArazdWc1dQTmJNdHhFc3NRckFH?=
 =?utf-8?B?S2llQTBsYU1oWGJXK1ZuSGcwRjMxTU5xeFRmQmkyaEVITUpEeTY5M1ZvWEMr?=
 =?utf-8?B?MTA1VWM3MHBNcGZ5b3JpWlUvcklXc3N1K0VLUllrRm5mekpPWHhJemRrUngz?=
 =?utf-8?B?R0hvaytZdDE2aWdHd3U4UUVyMWZ3LzZFWVJOTkFlNG0rK0NPRWZFRXB5eXJo?=
 =?utf-8?B?ZlFkYWRHNFU0WHIrZlNCRmxTdnVmS1FGQ1Q1ZEdIWmZsOS9xdjFhRWFYc1Jq?=
 =?utf-8?B?ZmVtU2lPL25zZURoSXRoWlgvL3VxaFpiR21WaGIvQlJGZ0MrMmVEYnUyakQ0?=
 =?utf-8?B?bExYMFlycUNPeW1KN3BmVW1sRjBJazRUZVZRbU9VZVJVdnV6aXJyeGRnNFhk?=
 =?utf-8?B?alNJUWFlUHNsakVjOTBGYmVUbURFM29EMXZ1TkhaYllNK3I2RS8zTTlsZnYx?=
 =?utf-8?B?WnZsRUdpSVdjcjcxamJxVWh1TUpzTUZMZDBmNkRyQ3A3ZWc2cDRJYnp0SEkz?=
 =?utf-8?B?TFZCRlROVTRUNTFuY0NHSUtXRmpQVjZxTmVtZFkrSUg1QUtJTTAyTk1YQzJ3?=
 =?utf-8?B?eUtFV3QvZVgzWHhoRFVHOGFuZzZOdVk5Q0hyZDRGeS9oMnFkOXZadVEvcE5j?=
 =?utf-8?B?R0VtZ0Nqc1FrVXJPODVoWFJ5VDJpb1pkajNGUThwVW5lZEdZNGljR0xEWGRU?=
 =?utf-8?B?OU43MjVHNGxNckdHVGdaNXhUbjFwZXJuS3lKRmZBNjY5SnVWUDByRjBTWDRH?=
 =?utf-8?B?aHFqSGZUSVpCT3J1WXBDcjZrNCsybCtBcjc3ZStEU2NxOFBOQ3l5Rm9jditJ?=
 =?utf-8?B?aGtKdEprbUJhbnJnM0U4Z1d1VjIzZGVzOFlQTmF5d0lZV09pTi8wU1lhaEVt?=
 =?utf-8?B?eHZiNzQzYUtiUGIrZnFKazZWWTNpT1JmNHhCYVcxTHNvTDd1a1NlWFo1NGp3?=
 =?utf-8?B?aWN1SDV4YWxxbmNSNC9hbE1KeTYwTGNYUlgzaCtFeit6d2VJK05FMEhmdngy?=
 =?utf-8?B?KzVrN2J0RnZnOEo3dDFGZDNqd21aSVBEL1lCaVFiaWdXYUM2elZYbjRmRDJB?=
 =?utf-8?B?aDFRR2Zabllsd1UxWlFjV05lSjhFQnplRk53Y2FVY3ZJcGtwVmJEK1NwUFRI?=
 =?utf-8?B?Um5nMk5NWnJWVzdxbkR0TlpVbmZiTDljN0JOMkhXYVVveUtUY2t5ZGxISzdm?=
 =?utf-8?B?OU02MDRPNzV4VmZSNDZwcmRuUVUzNWVJT1ZrdFUrS1ZsNk9DeHpxMVVrc2lU?=
 =?utf-8?B?ZXBSMGZ2eVhyYWxvVmxuUkVFd3lYZ1NlU28zazgwSlhDSFJ6YmRZcmJhemdC?=
 =?utf-8?B?TDRBbkpaMXZxQ2thUWpkZk81UFFyYUpic3VrNlk4cXBWaGYxWFpXdG5uTzV1?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c1de1b-218a-4144-f329-08dbdbcbe86a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:48:22.8266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieANnHMLJJl5efElTG8rS3IG6esoS6nTgVxso5h5zaIwK8t3ErZKHSIyMjuDBug4/0qNINqsmHQxbVM9cp1kpiUmOImbkjUChwExidDCG70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7949
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
> The measure_cache_vals() function does a different thing depending on

No need to say "function" when using "()". The above can just be:
"measure_cache_vals() does a different ..."

> the test case that called it:
>   - For CAT, it measures LLC perf misses.
>   - For CMT, it measures LLC occupancy through resctrl.
> 
> Split these two functionalities into own functions the CAT and CMT
> tests can call directly.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cache.c       | 37 ++++++++++---------
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +-
>  tools/testing/selftests/resctrl/resctrl_val.c |  2 +-
>  3 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index bcbca356d56a..299d9508221f 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -170,35 +170,36 @@ static int print_results_cache(char *filename, int bm_pid,
>  	return 0;
>  }
>  
> -int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
> +static int measure_llc_perf(struct resctrl_val_param *param, int bm_pid)
>  {
> -	unsigned long llc_perf_miss = 0, llc_occu_resc = 0, llc_value = 0;
> +	unsigned long llc_perf_miss = 0;
>  	int ret;
>  
>  	/*
>  	 * Measure cache miss from perf.
>  	 */

I'd expect these comments to move as part of a change like this,
but seems like this is merged with other changes in patch 10. Does not
seem like an issue done in this way.

> -	if (!strncmp(param->resctrl_val, CAT_STR, sizeof(CAT_STR))) {
> -		ret = get_llc_perf(&llc_perf_miss);
> -		if (ret < 0)
> -			return ret;
> -		llc_value = llc_perf_miss;
> -	}
> +	ret = get_llc_perf(&llc_perf_miss);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = print_results_cache(param->filename, bm_pid, llc_perf_miss);
> +	return ret;
> +}
> +
> +int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid)
> +{
> +	unsigned long llc_occu_resc = 0;
> +	int ret;
>  
>  	/*
>  	 * Measure llc occupancy from resctrl.
>  	 */
> -	if (!strncmp(param->resctrl_val, CMT_STR, sizeof(CMT_STR))) {
> -		ret = get_llc_occu_resctrl(&llc_occu_resc);
> -		if (ret < 0)
> -			return ret;
> -		llc_value = llc_occu_resc;
> -	}
> -	ret = print_results_cache(param->filename, bm_pid, llc_value);
> -	if (ret)
> +	ret = get_llc_occu_resctrl(&llc_occu_resc);
> +	if (ret < 0)
>  		return ret;
>  
> -	return 0;
> +	ret = print_results_cache(param->filename, bm_pid, llc_occu_resc);
> +	return ret;
>  }
>  
>  /*
> @@ -253,7 +254,7 @@ int cat_val(struct resctrl_val_param *param, size_t span)
>  		}
>  
>  		sleep(1);
> -		ret = measure_cache_vals(param, bm_pid);
> +		ret = measure_llc_perf(param, bm_pid);
>  		if (ret)
>  			goto pe_close;
>  	}


Reinette
