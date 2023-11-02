Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0CD7DF922
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 18:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjKBRsP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 13:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjKBRsO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 13:48:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55548196;
        Thu,  2 Nov 2023 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947287; x=1730483287;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cFfgwYkR4ZpFqForrF4ybhjZOkZmi1oQ1dhbFiIbZKE=;
  b=dFVOqxZ/R1REPZj1M8ayX4nSyBPQxDiNc0boPLtTD8xi85dAx7eEm2l+
   hpk4xsEEO1QbqSq5l4lE2N7qqOGe/M5aLURhAvClM1dANBjIM4ltsqRr7
   ik51Fd5K4OqulnP02gJygKL8wGkh8Bq4aB/TT8KgQfRzBnhP9pV/xJELM
   BQTx4UBXxAPjTI2qZwlgIJPEEb3Jp5V8Mqx0MILmJhkhXtsp4Airp20NO
   C09xvx4h/NWU0V/eR5o2FVu2cktqrCvF+VkPWMoumGnhDHW0uYTaEDkSr
   oCOrDgxJbjxDJC08pUdlzPvtuMmheDQaIw8KewImuBZZUOwGB7W+2Lwqn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="368120966"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="368120966"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:48:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="754867559"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="754867559"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 10:48:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:48:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:48:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 10:48:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 10:48:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xk1GB+Q1ITrBFEfnlRcOUECErKsg4GTWT2EZ9QY+49u+GX3UF29Ua1z9vlUSZOhepUZyjaubobAdBgMAWpvCCiC+E40S9NtMEI8njnPGdU8RIjZ4ag7Ft7Mx/2sVd6RDaQrA+fU0pF4dJwLeEcmP9VHxThJktKspcIKdvlRPhW4MZrRVusRmFVWRXHh47zUnS4QfPhTStpWouCNrUnouzmQnHLeYpAFHW9oRYh8YGuZ0bZKNGn11s3JZUYJZSGEvtvW9d/+MOUAn4cuPu/NJBSOkDNLbj8Dx4x2BD5pqH6rTEYy8MtxNPK68OQ29VDmEicGTP5vNstOBaW/Dus/mbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AckkN8zrUIrWMFwmPmrcicw1MFk2L896Wf6yHgRrh80=;
 b=VUHzIF72a844CUyETuk1ltIdFXyN1aOhUt+wTVKmgPbeCXq9MnX6yrT9MlBIeW+r3b3fO9QQt/jR+a59FTj+FedGQPHvi0cpKCdou2oz7Tm/cO3wPXPHTauXgHuFiMJZ/CRKKlJeHvjBNEti9hxxf3Bc8mTGEp+goUlqONxaVpS3s0Wiui4+uYlM4DzofPoWumMSVkKoFT7ftxCdcRul+sh5KmnTJy7NyzKKjmbknA+KGprbI05HLQdwugAQs1ImBUO1xPzIcJW8savPxYbROuspp2MjHe6ICdgTKUrFOje3J55vPwFq1gqvJMtusXu/Oki7aReHksgdTeFIpIQgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB7949.namprd11.prod.outlook.com (2603:10b6:8:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:48:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:48:02 +0000
Message-ID: <83479a22-ef2c-4577-aa07-d4cc2cf90fe6@intel.com>
Date:   Thu, 2 Nov 2023 10:48:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] selftests/resctrl: Exclude shareable bits from
 schemata in CAT test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-7-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231024092634.7122-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: eabc1f70-42db-4936-90c1-08dbdbcbdc05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NaU4OcQr+3HAl5Ko85ZJwDQ9UOhvYvdh6ItJW3PhT8JZX5FyXNfn3feD871RY9vQ5wCBse7LDO5esMPSqywyzbpoCDFeCNRO+ZMEM/g0Ueg0SqOwdgtg3GTp5VMkXxF7Nx7gq0df6xLDdV2Ef2jGhS5I2dqr7iuDHOz2ZWMSp4Ix8ebGVOJLumWNgLEbdgWL/4yrwe0R+K31Ea7rX0jtXGjUAuyEa/p9tHGa5hP43kHoMV45vJb/L8l222pL+z3T7f/kTOYg/mbfFYvQkI9KlfIN8d52Z8rlDrTakyeX6iuaOW2i5VYPpZ92qbojx74/PdgasxYOVO94sFZWqLQS0LlZM/9SdPrftmxGZJ8fIBRsyUuL2WGNhtBZ52DR+Nqr9VhdaiDiHMt7AxHDeLVobBWC6Q6RpOvrnhPgsu8B/QXk2Md15++KP+2gSlpOB+QPDmM12bL4xE7v4exeZ0Ws+bGHdz53OfOE/YVLgaSyvpum+wTRbziQsUnjdZa1r9S8EixTjNVuwjwUKyaBncZwENWaPcZ8DOrMzkM/MkjWT5LlmyPa0f4IX2j8WFOq4GukfhoV41JCS9etS4Veo8shEBgPBobbN+Df7Y8LcER4ERTCGEd2KUMjol6+fkBDi3BSjx7hQM9LTcvDD+/O01EGXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6506007)(2616005)(53546011)(6512007)(83380400001)(26005)(66574015)(82960400001)(5660300002)(36756003)(31696002)(31686004)(66556008)(66946007)(110136005)(66476007)(316002)(6636002)(86362001)(44832011)(8936002)(6486002)(2906002)(38100700002)(8676002)(41300700001)(4326008)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm85VWp4c1pmUmdSWHAzekNNNVhlaURORyt4SktEbE1OVm9haWNhM0l4OWtQ?=
 =?utf-8?B?ZkpIV2FyMGM2b2xIdWFJU1NLcDJJeFRIZit2WlJQanR2dTlBekFwODJOcVRa?=
 =?utf-8?B?Mk9OMjAySGxIZmJtbmxTdWxqVHI3SkdESnUxQnRXazJuN1BEMjFFc1N4VDZ3?=
 =?utf-8?B?Vk1oUHp3SGQ4OWhVd1F1VVJyRmcwcGhCZ2lLRWQ0LzFYSjdDWTRNb0gyRWtE?=
 =?utf-8?B?V1BVOTQwcm8veTNkUmdVRmk1WmdaS2NtVVZuZUhndVpqRjJHamZlcU1NdUU1?=
 =?utf-8?B?V2ZUdjZ0TjFJalJJTVRqY2J3MGMwVUtMZVhFeU92bFlENjMrekZCb0g4M21U?=
 =?utf-8?B?SjVnaEpTN3FwMzhzcmYxclZma0tBV1lqMmlXc1ZnUlN4TUZNMjM5THpzWjJ1?=
 =?utf-8?B?ZTAzY0g1T2VIZklzVTZsUlhiQXE0OTZ3VWFZdG11K2hHMzRES3JSd0NvcTFU?=
 =?utf-8?B?NjErR1VKcnFGcnRmRlJrWnFBVUpOZDloZWtXbnFLV29YeDd4d1lWUVo0am0z?=
 =?utf-8?B?Y3daY2hJdU1pbzJzSjVhQzhWQlQ2S2hPRGRHQmxlc1JKQ2NVSmJyc3dCWmhM?=
 =?utf-8?B?NEFJdWxCSzhWQjFreWNrVUs4eTRib0FjcjQzQ0liTHZxUzBXR2FOalppR0hZ?=
 =?utf-8?B?bjUyUUp6ZTl1OXBuVzkvalkyMWdxTmFoSEFqWjJKRytkU01YSU85aTVEYmZG?=
 =?utf-8?B?bmUwQjNIQm0yV25DdjZla3lEVUdnaXd1dm5nRW42SzhXbm4rY3NXWU1yd3FW?=
 =?utf-8?B?dyt3OVdxaHFFUDdxQURoVEp1MW5TQUpwdE5IdGhrWjZyZTNXSnlCYUU5alc3?=
 =?utf-8?B?M0dNQWtTb2x5VUR2U2NheldzUWpJWGVEVXZTK1gvWDVSRXZnTFl1amdiLzF1?=
 =?utf-8?B?bzBKODFsQVlxdS9uYXpveW0xYWtWZzNOR1J1c3k2dG1XMm5PSVYzRFBSNkhR?=
 =?utf-8?B?V3JBQ2MvQTA2cU9rQlN0UnJXRThZN052NXNRYi9ISWppQUNJTHplWndxUEFu?=
 =?utf-8?B?ZUovTjRwb1IyRi9ZcVdMbkdsb3hqUUlVVzZKeHQzNmVWV1diNWdRVDJnUm5v?=
 =?utf-8?B?bDJFZ0doa2FOYm9sYzlkZkttUElvWkE0b2RQQno2WG54QWE0SEt1WHM0SC9I?=
 =?utf-8?B?YXBhQnFUZFJFWWh0aThiSDhyQzlJVy9abE5LaFNtUGJEREJTYmx4VlpkNW1h?=
 =?utf-8?B?RnRKRHR4S1k3dS9QRDNUTHNIaWFocGVYcCtRUHVNZjdzaXNlQnNXbjU2d05K?=
 =?utf-8?B?RVp0TnN4QVdtaEVKUXhFcTh6cFdEVURiWHp3TjlQTDRwVk5YNHN4ekZlcENM?=
 =?utf-8?B?VU1WQWl4Z2JaWmhEbFFHdVQ5a25aVjZXVUNhR2JtNDMyTjd2RGsrTTRFVExN?=
 =?utf-8?B?eENtbGIzMG5yU2t5QnlETjhDa3VlSlg0YWJKN1ZaM1ZRR1V2Z2YwdXRKM2Vr?=
 =?utf-8?B?eGNLTjc4a0JwaG9uYnA5dVdpaUNlbGM2S3dXRXVrUGJ3c09Nc1dkMEpsY0Jm?=
 =?utf-8?B?OE1GUWpOdW94TDlOd2gxamxWelZVN2VNMHdmMWJpc3NodTRHR09KajJ5OE9N?=
 =?utf-8?B?aERhdnJLdUhkYzJoWUFJcUVETUllNDlOWWFCOUhvZVMwcSs5aFRHdVB4VWlJ?=
 =?utf-8?B?MGt2SkZXVnZqMVdhUlU0Ym1sd0hxR0RtdnVQbGNWSm4yZUg0NHViek11ZStG?=
 =?utf-8?B?c2VxQjE5cUpYUzdEL0lkakhrRW5GY3E4bXN2Vkc5UlFwVXlxekNRME8wa3Fz?=
 =?utf-8?B?ZVB5bVJIRk04bVRBellRYXRiYmJRNHVWNHVRdjhiR0NiQlBrVWFjejdiOVgr?=
 =?utf-8?B?MXNpeTdsWlRUcVhCY2huSGRTa1Z5ck5WaHNVcVZZdEpwTldOdFlDc3NxdVdQ?=
 =?utf-8?B?SVdjRFR3b2E3MlVMbGNsVGNrNjMvemVkQ2VMb09ZUi82ZGV1Ukd4RjMyRW1G?=
 =?utf-8?B?R2ltL3B6c1U0T1hOUHZ1S21pUlhNMmVySzRBTzVYUUw4L2xFTVdaSTB0dE9R?=
 =?utf-8?B?R3cvMVNOMGc1U21vNlVodHhWQlREQVdyZkNkVEpHMzd3c1IydWZ4bUhHWmtT?=
 =?utf-8?B?elVJNCtqOTRzdTYyTDhNVzJ6OW5hdXhOSGFJWGQvNVA1OVZnYW9xaHhCQlRI?=
 =?utf-8?B?TzFMZ3Eya21ZbldiN0hRU0FaRHRqemwwSHJFNnEwZWZ5N2NaSlJObWZ1Umdj?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eabc1f70-42db-4936-90c1-08dbdbcbdc05
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:48:02.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haJTkS9KVykoaFaVCc162HcJCMARTRrDwITr3e68soYIH5AbTkR+xFn17lcz7AYLakwq0avjvKstHQ59fCfiUYLgG3nn2AVVN7VEgy6V0BA=
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
> CAT test doesn't take shareable bits into account, i.e., the test might
> be sharing cache with some devices (e.g., graphics).
> 
> Introduce get_mask_no_shareable() and use it to provision an
> environment for CAT test where the allocated LLC is isolated better.
> Excluding shareable_bits may create hole(s) into the cbm_mask, thus add
> a new helper count_contiguous_bits() to find the longest contiguous set
> of CBM bits.
> 
> create_bit_mask() is needed by an upcoming CAT test rewrite so make it
> available in resctrl.h right away.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c  | 12 ++-
>  tools/testing/selftests/resctrl/resctrl.h   |  3 +
>  tools/testing/selftests/resctrl/resctrlfs.c | 84 +++++++++++++++++++++
>  3 files changed, 95 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 80861c362a53..e5861e7cba7e 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -92,13 +92,17 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	unsigned long l_mask, l_mask_1;
>  	int ret, pipefd[2], sibling_cpu_no;
>  	unsigned long cache_total_size = 0;
> -	unsigned long long_mask;
> +	unsigned long full_cache_mask, long_mask;

Please do maintain reverse fir order.

>  	int count_of_bits;
>  	char pipe_message;
>  	size_t span;
>  
>  	/* Get default cbm mask for L3/L2 cache */
> -	ret = get_cbm_mask(cache_type, &long_mask);
> +	ret = get_cbm_mask(cache_type, &full_cache_mask);
> +	if (ret)
> +		return ret;
> +	/* Get the exclusive portion of the cache */
> +	ret = get_mask_no_shareable(cache_type, &long_mask);
>  	if (ret)
>  		return ret;
>  
> +
> +/*
> + * count_contiguous_bits - Returns the longest train of bits in a bit mask
> + * @val		A bit mask
> + * @start	The location of the least-significant bit of the longest train
> + *
> + * Return:	The length of the contiguous bits in the longest train of bits
> + */
> +static unsigned int count_contiguous_bits(unsigned long val, unsigned int *start)
> +{
> +	unsigned long last_val;
> +	int count = 0;

could count be unsigned int?

> +
> +	while (val) {
> +		last_val = val;
> +		val &= (val >> 1);
> +		count++;
> +	}
> +
> +	if (start) {
> +		if (count)
> +			*start = ffsl(last_val) - 1;
> +		else
> +			*start = 0;
> +	}
> +
> +	return count;
> +}
> +
>  /*
>   * get_cbm_mask - Get cbm bit mask
>   * @cache_type:		Cache level L2/L3
> @@ -253,6 +291,52 @@ int get_cbm_mask(const char *cache_type, unsigned long *mask)
>  	return 0;
>  }
>  
> +/*
> + * get_shareable_mask - Get shareable mask from shareable_bits for given cache
> + * @cache_type:		Cache level L2/L3
> + * @shareable_mask:	shareable mask returned as unsigned long

A nitpick but please be consistent in starting sentences with capital letter.

> + *
> + * Return: = 0 on success, < 0 on failure.
> + */
> +int get_shareable_mask(const char *cache_type, unsigned long *shareable_mask)
> +{
> +	char mask_path[1024];
> +
> +	if (!cache_type)
> +		return -1;

Same question as earlier about error checking.

> +
> +	snprintf(mask_path, sizeof(mask_path), "%s/%s/shareable_bits",
> +		 INFO_PATH, cache_type);
> +
> +	return get_bit_mask(mask_path, shareable_mask);
> +}
> +
> +/*
> + * get_mask_no_shareable - Get CBM mask without shareable_bits for given cache
> + * @cache_type:		Cache level L2/L3
> + * @mask:		mask returned as unsigned long

Apart from comment about capital letter this comment does not seem to
reveal more about what code does.

> + *
> + * Return: = 0 on success, < 0 on failure.
> + */
> +int get_mask_no_shareable(const char *cache_type, unsigned long *mask)
> +{
> +	unsigned long full_mask, shareable_mask;
> +	unsigned int start, len;
> +
> +	if (get_cbm_mask(cache_type, &full_mask) < 0)
> +		return -1;
> +	if (get_shareable_mask(cache_type, &shareable_mask) < 0)
> +		return -1;
> +
> +	len = count_contiguous_bits(full_mask & ~shareable_mask, &start);
> +	if (!len)
> +		return -1;
> +
> +	*mask = create_bit_mask(start, len);
> +
> +	return 0;
> +}

Nicely done, thanks.

> +
>  /*
>   * get_core_sibling - Get sibling core id from the same socket for given CPU
>   * @cpu_no:	CPU number


Reinette
