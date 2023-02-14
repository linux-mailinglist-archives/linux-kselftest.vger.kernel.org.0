Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C88B6955B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 02:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBNBBF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 20:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBNBBE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 20:01:04 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0D01ADD9;
        Mon, 13 Feb 2023 17:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676336452; x=1707872452;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=CINmP/tE48mLYiq62Lu5dJmT5BKTpAmnpG0OUTfAebM=;
  b=DqCWxuweeHdR/yuNnYzUpKqp2fTp4rQ/xfse02AZdOdjN4MptsKq5td7
   9hV4av+RgCmw+Q22sYNL9gUR4zY3DShha3gY68HQij29f4xJ2So4N24G9
   4yqYE0E6MDUxjZq+dFBd9oaRYkUI5BqB8BkkJ1K6IK/vFcnwvWF9h5swI
   2GmbPdiC783AqiMCINhPp9a2Z+WYbpBVcNiFfAzwynL7SoN+l207GFFF7
   iqtWGznLrd48KeMFwka5gA+gZNkJMjUMwp/Noyb1cLh8ngkFeL2emEv4o
   589sAM0TQ2U7pMeQApu3+gSnq6USZZyGCz/qRmmBY2R6vjdqL8aTls/Dl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="319074580"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="319074580"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 17:00:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="662383882"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="662383882"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 13 Feb 2023 17:00:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 17:00:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 17:00:40 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 17:00:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiBbM96zo8U4WiEMZOJmcfmFzhb1enkiGVl75iW6AoR0AyLuQidjpAwhx1VFSfuPPpD+aE4POgLOnvlUFcAqLhkYJQNVo/hVqsjbZrFuWLB0tzRgugScqa4hgI2WeprrzZ9U5WVvaDM3J+UHWIk/F5kDIhsejxRFBxquoLwXMNXEd80f7+oVvRGKtlhNHEJp8ANoMieyisB/tRUo+5iBCCPZapvqdI2Vp138n5xlzwSJdvYHyZbDNOsoPh6rBkKcNlPEYPIRDrLDxbs9xGbcZTFC5uAKV39so9ijDfrtLWdqftZK/9jtBEq48WI4aIJxUo4FgbH32zzdLIw7vG7AZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xx+HS3rijCAHWLlTwk9Wcz5cbFoRadlYbUnrjqKAE74=;
 b=Ryzx7rhCFd2nLU7m5qit635TzQQ3ccA6VuUK/yPOZkrPBVXjHaPl8zIOq4RY4h8LjHrQD+jCpC2gMFVx8Ybxxsmwt6ZthEwHy7sMrrPxhhdWcZp1TEYessPciAnmg7ZY+4iFP26qvfBv2LFljTTRsVGyVt1L1EdHlkjD46By5M0w/I1WIqcxlQCsDSdR/zrjv98a4YYDFvvEsAMaovKojaGuv/pCqiwEKobjp20kxzzekV6FNNrHfnuaZmO3fFscmyFSWp8/Spqo5gC/mKBDZ83nq7Q2Dl8+PWPQFBwRAZ1l44l2RfdNfYmJoWGab725+ZfyF4RgNPpDAqAQT97p6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 01:00:30 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.024; Tue, 14 Feb
 2023 01:00:29 +0000
Message-ID: <88a819d7-b236-aed5-7cb8-6659e3f9f405@intel.com>
Date:   Mon, 13 Feb 2023 17:00:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] selftests/resctrl: Return error if memory is not
 allocated
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
References: <20230208093016.20670-1-ilpo.jarvinen@linux.intel.com>
 <20230208093016.20670-2-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230208093016.20670-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0046.namprd08.prod.outlook.com
 (2603:10b6:a03:117::23) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW3PR11MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: d45d17b2-0e11-45c3-89cf-08db0e26ddd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdxZ4vPHraocnBu15keR38wk5gO+HvckjZ4d4OrJ3PfxTEt89YsL2bjKHU8rPN9/52Hkqv1iHY6QxeEJa6SCBCceDvn6kaQUPmkRAj25q01aTIUoH5NgHxqB9AMbXJhMBcaXfXP4JXj8wXsAOmpfa2R4b2xTdx+jSy9dIN0l4nlPFz/XtoFgT9qmkLpbP5pDxGou9MV3T2YnFet3AZAUQ5IGev4AqMPn54orCMc3AXxvwmzl8sl5awR9P5OL+WPBZ/U/E9jtpPiiRtka5HooJOeEVcsH/Nq7KVq7PLDcka4v6lxxsQ9gqn6s1UYKF1EAaUwQIghl58I813+H0XQVErUgOP68edbdt/Jddllv57GJtjycpcEKxDSfhcJPHsO2o6xLywFPDdK6SEj1RJQDeZ0o2DSzJe5LXeNvjTlUYF0U5n51z2H1y7eFr4gAkThh/NVNQ3R5sLZsez/6RZ/QhEqbamIoMWaZE5n78ijOM54bNaFhx06qaMXep6RGOYKtKM65tGqVYKHD6UqQqJ2YpdIHITUDSb6SsAWtaQpQwqapK3bhzMl8jxrMDjIGb8HwpIH6VBe3w3PCHHtL3JwoJ5FWDRpjTGWDE+SzwKmhbIf1id82ReB4KztuWhdWqblNp50xbKSf7jRn3viGjhXbiU8D6es7FqAfDjTMDfvQxtFFxbf6t5t9tVi9q0+CO2iWWnlA44Huf2B8gV/lggCltUGy6kYOZVA3FDUQzltHySk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199018)(316002)(8676002)(2616005)(83380400001)(86362001)(82960400001)(31696002)(6636002)(110136005)(53546011)(38100700002)(478600001)(36756003)(186003)(26005)(6512007)(6486002)(5660300002)(31686004)(41300700001)(8936002)(6506007)(2906002)(44832011)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU9yMzNYYVBNVnhmRDJBTXZHWEw1YUFRc2grUDdPMGNvanNkUk1RV3o0bE9S?=
 =?utf-8?B?K0lCeXpUc3ozUFBySGNObFZLOEVuU09kbDZ5bmk4MFpvcjE1MmxmK0oxdHZY?=
 =?utf-8?B?aU5odDVZUituUGN2NmxnRmhTRzFCUm04THAxZDh2YlcyU3lNK1c1bncyWEV0?=
 =?utf-8?B?eUszTk9rNEQ5TFc2cGc4VFJLK2JpSU84TWVVUTVwcER6bk5CbEVmVWtjaW13?=
 =?utf-8?B?VzlMR2h3RW5PZmtwTlBOSVdhOGZ3ZVNRMTVSbWhuS2pwV0Y0cW0rNEdOa3Va?=
 =?utf-8?B?SUdRNkxlNmROeWtYUFMra2pTb25iSzhzbW45eVp2ZWhuS0w0dExrVkltNStJ?=
 =?utf-8?B?MWM0LzBOWmFBNGdJUFl6dHRLTVBTdHpyeThqTUxURHlwZHo0QWxsa0c1Nmo0?=
 =?utf-8?B?MXArYmtNVVcrME1HRjVkMHlXYlB2Tkk5Mjh6RUt3czg2ZE5LVkFyWEFsTm1m?=
 =?utf-8?B?NmxhWDlBT1MwOExoeE01Sld5c3JiMi9CTWVyNFAzK0NXQ1hSVk1RT1RIeWpo?=
 =?utf-8?B?UWlrWkwrSmoyVnQ5bDE0KzBRTjZGWnlCMis0STZ6dDdUcUx0cU9zalZMTmNW?=
 =?utf-8?B?M2FXeWVrZndHNnpweUM4cm5JTjdGU2hqUlJKcm9GaG9RQkp2UlZRVXJkdzJE?=
 =?utf-8?B?WFRwQ3l1RnB2TnRSeUhhMzF4cmN4YWczSnY4NmoyWUd6ZUlsbUV3ZHdIbXNS?=
 =?utf-8?B?MjBldUw5ZHU0OEl2UVBxVHpwOTJndDV0eGxYc2ZRWWRhOFFqYUdNdml3NENG?=
 =?utf-8?B?OWNTSEs4WnlkTmhUQkl2dW5TdU5BODdubVlWdi9naVJNTlZUbmNFUEYyalZ4?=
 =?utf-8?B?OXF0M2h5M3gvL3lybnFhNWlVaHFRZFVaSUpnci9BTXNGUGk1K3BwRjA2MzdS?=
 =?utf-8?B?MDVoUlJhVUlsT3M5YjNvdnNGRlc1Y0orN0ZjSGhFTlVzRGVHZVBBMm04TUVp?=
 =?utf-8?B?VDhkL2dKOXAwb002YlhUME0yM0hVQnlFNmJ0ejVVbSt1cFZkdmpHRHVVQkpj?=
 =?utf-8?B?M0pnaU9CSjJEbzhBNjIyNVoydi9jaWhQQlRKM0pQMldRQW9YelFsTmRrZ25i?=
 =?utf-8?B?UkNrUnFYUEV2YWdPMENjNTF6bVFnRzJqSzNsRTBvQ0tncldLOEpkWlZTZ1hP?=
 =?utf-8?B?ZTJOWXVVWTg2eVRYVG02MnBlV2Jzc2NyUy9HUVhXS0ZZamNjYlNxUzVyTFBq?=
 =?utf-8?B?M21WY3hzc3A2eFdEdFVtZllCcVorVXZkdFFMWnJBYVozMS9iU2hudWx2RDIv?=
 =?utf-8?B?MVRtajhYb1Y0VWxpcVNSRmNyUTVBNHNyYStac3hndExsYnhqdTFmVHY3UkU0?=
 =?utf-8?B?MlJTNzY5QjVJeW1Gck9oTlp5N255M1c0QWk3SWE2UVlTZVVoNUs4elE3SEVo?=
 =?utf-8?B?Wi8xYTFmZmFqeWQreHFoK3NsQ3RoaXFjdDAwZS96L3YrLzRaS3l2MFFrcTU4?=
 =?utf-8?B?L3VnZUdyV1BsVTNZUmE5TTRxN3NuMUJ6ZTV3VEt0OEhyRWduTVdYcTFoeDh2?=
 =?utf-8?B?UHRGNHhRaFBkYjJNRy9WbXE3d2JIRmJ5emhpb1lTSDduVXlJOUV6QXRuVHhR?=
 =?utf-8?B?ZzRLTUZUcUVtaVYrc3lXZDVqa1dIZjhBeUhrNktUMFREOHpxRWhFbXI1Vkkx?=
 =?utf-8?B?RW1NV0dSc0tJL1FRYkZMVzUvcE1XUm50eE1PQXRXalF1OVF0TVNvUHN0a1d1?=
 =?utf-8?B?N0ZocXRpVmJsYU5maW1JR3pjNC9pQjZQNXl4d3U1ZXhZVURNcnJVMHVNdnVK?=
 =?utf-8?B?SE04TnFuL3BPdU45UGh4NFpmbXh2OTBYRkl4TVFmUTBpY25adHJPWFVMTlNW?=
 =?utf-8?B?RXJKbmkvdCtKUmRSOUV6N2pxbjl5VWdRcjZrVUo1dFQ1TGZQVVFlcFVXdUtt?=
 =?utf-8?B?T2FycU05WGw3VGMvQWR6S2F6blFOdXZhUGtlQkhCMUs4cGpQeGdBMnBPVStK?=
 =?utf-8?B?VFE4TktXMXlWRk9mRWw1UGtieGlZNUw1K0xBS05wbGxObGkwcU53VmVlZGQ4?=
 =?utf-8?B?NzhiUkFhaHlRbVRIUDMrR25XeHhvaFovdFpveElWRkNwZHJaeUJIRFdRbGhD?=
 =?utf-8?B?ZVI3dzlNVjRSY0RienRaRVBubVh0Q3BDVVROZXlmTVJIK281ZHdTeUZHMndt?=
 =?utf-8?B?dHBWTHBmaGt0cFBpZFBKRGM5elI4VWxob2NrcURITkV2amFndGVrWXVBMEhI?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d45d17b2-0e11-45c3-89cf-08db0e26ddd3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 01:00:29.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znoRG9P6fMMnyyiWP2FftN/4d6G3upavmdvLeBJe5YEjZyAdyZcY7h2GbvIxR9mTTuNSXmuRKecHiX3l8gFkdwtbxJQdtjcJX8VRoj7I9ZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

I do not see a why two patch series are needed for
the resctrl fixes. It may make it easier for everybody if
it is handled as one patch series (with fixes first)?

On 2/8/2023 1:30 AM, Ilpo Järvinen wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> malloc_and_init_memory() in fill_buf isn't checking if memalign()
> successfully allocated memory or not before accessing the memory.
> 
> Check the return value of memalign() and return NULL if allocating
> aligned memory fails.
> 
> Fixes: a2561b12fe39 ("selftests/resctrl: Add built in benchmark")
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Missing your Signed-off-by?

> ---
>  tools/testing/selftests/resctrl/fill_buf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index 56ccbeae0638..f4880c962ec4 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -68,6 +68,8 @@ static void *malloc_and_init_memory(size_t s)
>  	size_t s64;
>  
>  	void *p = memalign(PAGE_SIZE, s);

This may also be a good time to stop using an obsolete call?

> +	if (!p)
> +		return p;

Could you please return NULL explicitly?

>  
>  	p64 = (uint64_t *)p;
>  	s64 = s / sizeof(uint64_t);


Reinette
