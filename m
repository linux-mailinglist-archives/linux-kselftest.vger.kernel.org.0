Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA677DF926
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 18:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344071AbjKBRs4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344995AbjKBRsz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 13:48:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4041E1A1;
        Thu,  2 Nov 2023 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947328; x=1730483328;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dk01ThEXfT2gT3TOHBx2RhLnGBbx5h0TcLlVoFHlMoY=;
  b=GnK5SvSbq8yeIGCdn1wkd54FE7X/kAKRIdKLS76oQzEoaRvWPg0tLQP6
   BZj4sGJ8CJ6pt/L5ShN22bdR05q++by4suO0drAvnhFBxRcnwRTq8hbMP
   vywNtF//R4DGwiZswFnih5yLVe5iOChBapbtWsKFdcn7T4o+cqOT/ijWf
   IuuPaSy95w+wMW5TyqebANUTc51kr+HecIOqhnaGYiG1Fcqi8doFtlq5C
   LtbGIDz46CE8MoQVjlwy2OmBg2ULUUbq0LUVj2jt0OyYY7JxTAZlJaEBA
   83licitx2Clwzf9wn2akVLTva4D6QJbmaHncj92YIJxzqxzq8aQLbm0bF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="475020096"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="475020096"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1092794055"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1092794055"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 10:48:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:48:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:48:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 10:48:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 10:48:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUfVd8C9796jDYvETTxT99CIeIX3e5PQLY0wVNkNPObn5L5/1QvlbLMi0QBrQRVXYUlu1zc8k09hc0yh95Tv1mkkQs64qL9DHoxlvUIWN1a9kWvGHGfins+I6H6AiRhfErAi+16JmTfwkcQ7tIUg8WcnJHnB8nP99wssc9i+Abc2Vujh2TPIJ+rWRecVmAlT51mAQ4eLS3kPaE3gZSbY+z08n1aEVHO/Gs5U0p3nj0dUv4p0ugkcz8SJDfmWrrsC8LRPDYDWh+8ypiZTa8eVqjU7w9ZeYr2GOp2xyIxtbs1EGTB5fNW4aPTaeeNb6gm8KrqUQqBErjQlbupgswLdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRFuci2XTGKZUvGr+FxHDuU/kGORdDvawkrayab6Gcc=;
 b=iloPwy3pK9l8aagLPj5zafipC3ySmY6+bybcEGYJu+eh79zcThsJKf4Og7Dl9r+o2U+4oYWO+FaDGOSJf8U5jejUi8MwN6SbM9lx32LGxMN6yw7qh/afJKmte9u3UijRHlKviDYIgFtXTyHcMeZdoIukYCYxEfbn+hr3F72lqCC+NhrL+QHXD7k+Hs2I/oPjK+OQPDObzPktS6HWAeoV30jTAweGLtogw+MW0i8toMPjyY9DSv9vt0cBUdYuqtVFDRKei3wipr1a+joWemlJ4IxDTtLLFK6Hu/NUm99tXv0g+PlaRa3Bc0j7oLbYdKwRj8rfx6dtMGBdtDD/NTCOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB7949.namprd11.prod.outlook.com (2603:10b6:8:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:48:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:48:44 +0000
Message-ID: <5d504c29-896d-451a-bf85-eaef315bb822@intel.com>
Date:   Thu, 2 Nov 2023 10:48:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] selftests/resctrl: Split show_cache_info() to test
 specific and generic parts
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-9-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231024092634.7122-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a36755-0bd0-437a-2c02-08dbdbcbf507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gg4MCOsk68fBqNlDheE/HDZDuwnVRC2G9Ff9DQMSgHkI2T/lEmITzDmNfjiJY6AJu3DaUzELtXsPuRAAHIe2Y7fWPKj48jd5p9d6EJ+RqruE4LQJe3p2qx6NgTGKvVem/GLaVs2wzb/sLSIrg0Wpoemv1g9/LMNAIll2EIf2AXA5XkNnaet+4sAD5+nOWIlTvN/mSUHVa302W//4CG7Tq1PoJheoh7YmT2pc6zwVVPcBaekrnRJN3XlnSb9rPhg8UGCtw25KGt+W92wLYRNVgkHfhA56p47xHy2ziIE5NaMmJy9B3Cs5engp7lB+J0j9qh7OtM0nYxlBytjjsX3Z4NZAByEEUDJnGsjYbEjuQM+Q2XjvCtKI5OZb0t3H5Tzp86IXVX8/UHNeorbt0/zZChhGKhg66acpCKukA1LPRtOFlzV3FfqlYZ9DpaGmHOwqJ/gyAkDQHCQYQOwes9Y23CFa+Pp7TljaovRvWG5Wf3XldQdkGpoNJ6piw3HVzpBttC34m8gqUIJ5nAY7E6FU99woRdfGpaUwBtpYgpKSdDodvhINq1p05K6NBPNKTCaMSyFdOdIQV/HtjS3EbfHJLPzD2cMmXSnBYb7i4Qi3jhgDvBAkQg2jld3F90Q3tpXwVasLrdaWDy3K3EWgKVzwLXJxGLSiC0UsnqAZeOST9GErDjn3i83llT7/BzToj+pgmf5yrYktWmPAzo9JXy7Qrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6506007)(2616005)(53546011)(6512007)(83380400001)(26005)(66574015)(82960400001)(5660300002)(36756003)(31696002)(31686004)(66556008)(66946007)(110136005)(66476007)(316002)(6636002)(86362001)(44832011)(8936002)(6486002)(2906002)(38100700002)(8676002)(41300700001)(4326008)(478600001)(41533002)(461764006)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODdXd0J5eFN6MkliUUV1SE5sdUpPV2ZoQzBhZFdWN0wvNkRKSDdXc2w5Wkpz?=
 =?utf-8?B?VStGYmQ2YXVjVGQvUzNZb1kwV3ZwUTdnS001WUxXMHpUMXB0b1RkYmxQSFFN?=
 =?utf-8?B?WjU0bVVZaW1Gd1VLcFRLakFXR09hM0JlekFtQVdVbnNyYjhzRU1iUnRjNFlk?=
 =?utf-8?B?NXBvTUcyc2xTM2UvTXZOOEJOUGZ0OVJuRHExV0ZKUzQ0S1o4d2NRd3JxNkJz?=
 =?utf-8?B?WExoS0RCQTdzUkFsNkZzRkVTRFVFYTV6aVY1NnZva201clRLT0lvaDE4SFBM?=
 =?utf-8?B?MHFMaUYrN2NCR014Zlc3czNCZU9OdEZJelFpMHJ1SkE3YXZIcDB2QVRzYjBK?=
 =?utf-8?B?WUtRLzcxRCtNN0dsb0syUmJocE5XempRUFkrZFJEQXE1cDdNQVZyayt5a2VS?=
 =?utf-8?B?Z3ZsTE5xaGswd1N6NEdzSTdEVWE3TXdlK3pvTEJmcEM5MDdpWTlDdFJHUzNs?=
 =?utf-8?B?cWRmSCt6L0czN2huYkg0dHdCR0lkcHFuRml0dmJZcnB5QTZXWndWT3NGYlYr?=
 =?utf-8?B?TnQrMU96MXZWYjhqUlY3ZGRvb3VjbStnN1ZzdlMwbzZJVUYvQ2VUbnpRYjQv?=
 =?utf-8?B?RTRNcG53dlV5Y0xCc0xPSEJDL0lUSUFtT1RsNnBhOWoxWWFGVUd5V3hDK0pP?=
 =?utf-8?B?OHZveVZuODZYZDFiV0tRVFo0UVk1RHcxUWlIaE1ZMWhxdVNzeit4Zms3dnBD?=
 =?utf-8?B?c2QvanNMNHZiNDJNOUxxWm1RRjE3b0VRVFhpSjZWZHdqOEErQXBjSGt3amVO?=
 =?utf-8?B?YStZWDFIaVZGRlVPRmJCdk9qMWNjVmlOWmxJUjk3eXZVYnFGZnRtSTdjYTcz?=
 =?utf-8?B?Zkw2d0h4ZitKaWpWSGtwcEVHMWJZU1lhMmxVSm9Jc1hmbXlEZkVKUUY0ckpW?=
 =?utf-8?B?UnZDMUsvZUNoWkpsdDZTV0xqQXJlUGk3Z2dpZmFrWlJCZW52bmZhbTlCSVRE?=
 =?utf-8?B?ZytqYWk4aWZNcEgyT3ZudkFab3NaNDVzMDl5b1hGYjVNR1VNWlZrd3Jrb0ZI?=
 =?utf-8?B?aGdYTTdHdy9TOTJubHVnT05uZllaTFhtaGJjRWU4b2d2Ky9OOVNRK0lzYjJv?=
 =?utf-8?B?S0tXZkFpTGFzOGR2eVBheUN3M1grYkl2dkRRaElYejNWVW8yR2E2eHpVdWh3?=
 =?utf-8?B?SmdvL0VWSWFJZVVDdER4Q3hSdXlzbjI1Zk5KZHk0VTN6S2xnSFZ0Z20vKzlQ?=
 =?utf-8?B?QXBmYjFPNU9TbXpsdzd4L0RVOHVNSGVtNXYvUmM1eTR0WjlVQ1RoajdXRGhr?=
 =?utf-8?B?VG05aVdxR1VCY1BGL203UHc4aWtrdTMzeXh0T3htUms3SGlUWEwyNUlBL1B3?=
 =?utf-8?B?dlIvZmhrcjhBQ2E1SU9naWR4ZWFmc1czaTQ1MlRtaUZUd0tZKytkSTl0TzY2?=
 =?utf-8?B?YVY4R1luc3FheUpYZm9mL1ZhWFYrd3BVN0dPSWoyNzMwMDhwUElONmFKMzBS?=
 =?utf-8?B?cTJYVytEcXJ4VFB6TG1ROUp4SHBveDVrY0ZuTmJPL2ZtSDd3Z1l2ZnBDcm4r?=
 =?utf-8?B?U3NST1I2SlNwSUl3Y1hlbGRVQlFSNDNGNkhzVDlKMkRieXdxQlpPeVplOWtN?=
 =?utf-8?B?UnJNeFI4NWhza3ZvZUE2ZktSbDE4TDVjQVdvaFlrOFl5bzN2QXZtcml5U1FH?=
 =?utf-8?B?ajl1c0NDY3RRUnltblljckRqTkl3dXl1V1RENHpYemNrMUZ0eGZsYnd6ZzlX?=
 =?utf-8?B?VVJUL0xCV1RFaGw0UERMTWt6ckZGK0tWUHBZbmQ1eUZGWk5oVWgyckxtV1Rt?=
 =?utf-8?B?dXlWRnFhRGdrZ1ZicWdIcHdqYXJwbkpqY0tORWV0Zy9hbDJvY1k0Vlc3L05Z?=
 =?utf-8?B?dW1BTGhTaFRRL1RvaThROHorc0JVakRaMXBqM2ttS1RTaDBlTU93VlE2OXZy?=
 =?utf-8?B?RnEvYWplVDFuRmVHWndKVW5nK1hJeUt1N2dUUyt2Z3BKV3lwZHYvd09TckRx?=
 =?utf-8?B?N0pHUTBVaFhnUytSU2xEcFErcWFGSFpxbnBlYmo2WjBYRUZ1WHBFOHNKblM5?=
 =?utf-8?B?ejdGU2FHTWgwajd2cUtLT2swWFQxeXVFUnNGV0lBSHJzOG1KbC9EWjFUMFlQ?=
 =?utf-8?B?L0lJNFRZb0YxVnFKTmkvczVBWGJObjJBaytyK09wamVNK1RlM2JlL096OXNY?=
 =?utf-8?B?MndaaTRtbXdHKzdBS0JWelM5U1JWU1FVdzBkdFd2eGVDeVkxeU5tV2dBSkxL?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a36755-0bd0-437a-2c02-08dbdbcbf507
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:48:43.9864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ms3AIwaypjnHZUDKILKoWP0d5gCpCWb5UEIhyC73IecZ0Z07nAIY451TqPKCmNEDO+uhVPwV0IyuEXg+43EnrNV9PtfZMp0UTYsTCeE2qKE=
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
> show_cache_info() calculates results and provides generic cache
> information. This makes it hard to alter pass/fail conditions.
> 
> Separate the test specific checks into CAT and CMT test files and
> leave only the generic information part into show_cache_info().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cache.c    | 40 ++++------------------
>  tools/testing/selftests/resctrl/cat_test.c | 30 ++++++++++++++--
>  tools/testing/selftests/resctrl/cmt_test.c | 32 +++++++++++++++--
>  tools/testing/selftests/resctrl/resctrl.h  |  6 ++--
>  4 files changed, 65 insertions(+), 43 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index 299d9508221f..95489d4b42b7 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -267,43 +267,17 @@ int cat_val(struct resctrl_val_param *param, size_t span)
>  }
>  
>  /*
> - * show_cache_info:	show cache test result information
> - * @sum_llc_val:	sum of LLC cache result data
> + * show_cache_info:	show generic cache test information
>   * @no_of_bits:		number of bits
> - * @cache_span:		cache span in bytes for CMT or in lines for CAT
> - * @max_diff:		max difference
> - * @max_diff_percent:	max difference percentage
> - * @num_of_runs:	number of runs
> - * @platform:		show test information on this platform
> - * @cmt:		CMT test or CAT test
> - *
> - * Return:		0 on success. non-zero on failure.
> + * @avg_llc_val:	avg of LLC cache result data
> + * @cache_span:		cache span
> + * @lines:		cache span in lines or bytes

It may be helpful to directly connect it to the other parameter:
	@cache_span in lines or bytes

>   */
> -int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
> -		    size_t cache_span, unsigned long max_diff,
> -		    unsigned long max_diff_percent, unsigned long num_of_runs,
> -		    bool platform, bool cmt)
> +void show_cache_info(int no_of_bits, unsigned long avg_llc_val,
> +		     size_t cache_span, bool lines)
>  {
> -	unsigned long avg_llc_val = 0;
> -	float diff_percent;
> -	long avg_diff = 0;
> -	int ret;
> -
> -	avg_llc_val = sum_llc_val / num_of_runs;
> -	avg_diff = (long)abs(cache_span - avg_llc_val);
> -	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
> -
> -	ret = platform && abs((int)diff_percent) > max_diff_percent &&
> -	      (cmt ? (abs(avg_diff) > max_diff) : true);
> -
> -	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
> -		       ret ? "Fail:" : "Pass:", max_diff_percent);
> -
> -	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
>  	ksft_print_msg("Number of bits: %d\n", no_of_bits);
>  	ksft_print_msg("Average LLC val: %lu\n", avg_llc_val);
> -	ksft_print_msg("Cache span (%s): %zu\n", cmt ? "bytes" : "lines",
> +	ksft_print_msg("Cache span (%s): %zu\n", !lines ? "bytes" : "lines",
>  		       cache_span);

I think it would be easier to read as: lines ? "lines" : "bytes"

Reinette
