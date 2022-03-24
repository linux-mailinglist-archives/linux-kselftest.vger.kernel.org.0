Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4064E617A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Mar 2022 11:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349400AbiCXKIk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Mar 2022 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349398AbiCXKIj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Mar 2022 06:08:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528EE9F6D7;
        Thu, 24 Mar 2022 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648116428; x=1679652428;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2wTJqUhbTiSeJFAqsbYNIDeh/uefn7/esQafEyHzMrw=;
  b=JrJ2eHoL9Nox0MYHKAnJbaf+WQqXUY8izK+azbrA2wEoMCoFNRYey5Wm
   nkjn7yqcq/8S21sIVE4pCvfINHG0odEc3w5MFmwIxJuH6hOIk3gZw7Bpd
   xB7aKLFyKnimyDqKN+HtB0cgNjFwqEXkp2XyPbFAVmzd+v2k8963GN9mP
   JYivHjEz/LHvV2s0EIfck/8NcGZydgcN4L0wGAoHyuj7LbzUx4CuY4hWJ
   VyMWFzaYUVd5YL0GFRkvokCgyrMBAz2xkjdT3eKPJGS3PKQUweTpe0vzR
   sb8RqYGoCUwlriOTaOneGNjT7FctJjC4aPfV+8LJDbvC3yfVVnZN/Yi/C
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="321530662"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="321530662"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 03:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="516114279"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2022 03:07:07 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 24 Mar 2022 03:07:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 24 Mar 2022 03:07:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 24 Mar 2022 03:07:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 24 Mar 2022 03:07:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hc0wQenQC5Dninempj3eYVrz0sHsOU17ma7UiyABPb8Zco2XgEKzT1zzPWsVxbhHsrC3PfoFUHaZgojOaQ+drPenDTyBuMdo5ncp5+A7nJxe0OgMp4/AcGD7ZRsRXL6+UUHNoJkhOfzawDKbBNZnb0mfu9LrzupekVLoTkhMpDktoL4NYDOhBBJpOIRpP++UEuDZfkIt2VZw7hbUXtNqZSKONmoBIMWMaR5bvndAYBs46aIA/+GQNeLZjXmSnctiYN+fbG5d1RTpnqmHrouhncigGsUQTu+SOGO+L2HVGek+qVzqosRUqmOC/6xSCbIMASX/zB1qHdP+cr/GNMF0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TttlGMoIYcrmtd4vu/jYcX2VNYhnvEwBvJgVQR64Eog=;
 b=m98N5Mmq5bhk1u/DhIYsB2WPSaRlTIGlhchUqJUsrvGBxQqQCEQdCi7chQHH5vN3L4GTL1XAl+4a6YCxIk5JKI9UVBS+7toluKV9j/cMzZ5ygAkz0EWL2XedLkSDn6KZvxLgd1p1KyAeAS87gWFrchJOWprshz+x8LDWuo6H0UCZtDN6GkfqtQmKkkJbk7xov6ZQqyG9JVMjbx6f5Z1GZAbpRSlhAwXNLgJdC1Ja2lZRpQyWiXt6xLEvrw+nULOtdM4UyeYYtijRbx/jnmRk5UlqM3J3SvK22GNaYoEJiF40pv8DZah5mxXOS8IC9OCP3hUpIxObVhtBf+Q8NeGdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BN6PR11MB4004.namprd11.prod.outlook.com (2603:10b6:405:7c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 10:07:03 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8516:e462:e23c:85fb]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8516:e462:e23c:85fb%6]) with mapi id 15.20.5081.023; Thu, 24 Mar 2022
 10:07:03 +0000
Message-ID: <eb0c4940-569b-656f-424c-4248929cc74c@intel.com>
Date:   Thu, 24 Mar 2022 03:06:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 1/1] selftests/x86/xstate: Add xstate test cases for
 XSAVE feature
Content-Language: en-CA
To:     Pengfei Xu <pengfei.xu@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Heng Su <heng.su@intel.com>, Hansen Dave <dave.hansen@intel.com>,
        "Luck Tony" <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <cover.1646999762.git.pengfei.xu@intel.com>
 <4268a0203fd6e42a31bde3254ee50dd93fd233ea.1646999762.git.pengfei.xu@intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <4268a0203fd6e42a31bde3254ee50dd93fd233ea.1646999762.git.pengfei.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df2a2521-b922-49fc-6a02-08da0d7e0b21
X-MS-TrafficTypeDiagnostic: BN6PR11MB4004:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB4004EF8BB620E0823EB3FFC8D8199@BN6PR11MB4004.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVrYRZ48hNZ++KiRizRTDSw9aPpX8tfZEUrhp8lqnn/a14CQ967BEROhihXetZSF7l11Py/pfmhFvMbudWwUpWzO/wl5JYoKXsS/VeD+tFVkGorJkyv31zq1wu60r39vHL+x3S9WBdPRqu7/gc4/buJNJ9FGJLxzE5yg3fIlI5FKQGlxev4mNspkWne2F1g2f6plhA7/cF3s0QoMfNp7wd0KhiFEVttcB6nlqgTCZ/3ctZQ/wSruAnAnRFRM3iIn+qYHiMSjVaz0paoCvuKHEDtctzKVnhO/5Pxa47zqki/8axQcIcUm0ZKbrzYx4v8EFAaYqeW95uzeNQ2+UW5N58S3vUyyHNFwN3OgZ9ZVnZ/xKbL6fdn4I7SOFzIuqm8XKOTMV+7ZM0Rrhy+ZqzsD1SzIaVmLo4QScS1jbwflDX/U30OWLdFNJ2Cnh3UbjCgxqHRZ98fSXrxWnH6pA4ZH1tuCv5qQwy+Wr1QHq9xDgywW8atQXFIf8BKKpVvdnXYIcWEeeMyCLG0begb52WLeAJTlabMUzueRZx+DeFQSYFbBJFIs11UGGnXv1IxZuXrziEsxXLyy2TDv1db5l38w9da8gRnJdvmywddHFofMODfqYu01uOHhAsC9OcAq0R4JOJnwx3ycM+Z9bZGHAj0zvBATlFuDP5qcFG618qvrJkmoZPSYms5DjL6Lbw9LrKBdp6zQlJTkP27DeaxtqkqgRHH5r1PCKXNoL0Z8Y9Ay7em4/IuCqhSc5g0JezuV3JmGMv4Ky8vtdZ01EOuBaNcfMYq6Mgk+8YuntwTzPp8NVgQL6aIR2nqb7piNqRWjgoAo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(54906003)(26005)(186003)(316002)(31686004)(2906002)(4744005)(66946007)(66556008)(4326008)(8676002)(5660300002)(6486002)(2616005)(86362001)(966005)(508600001)(6666004)(66476007)(6506007)(53546011)(8936002)(110136005)(6512007)(31696002)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU5uaDdJL3dEZ2hpbEZGSEpxN3Y2QTZTei9Ld1dXREE1WjBjNHF2cFd0eFJZ?=
 =?utf-8?B?SVh5c3hhZjlHKzllYzNORDh3Z0JxdDd2U3o4bHNxa1JwdisyLzBwOTRYN3Iy?=
 =?utf-8?B?eHFqN2h4STFOekxRYUhQeDNONHBVdHlvc0cyT0xHUXcxMjN5aUQ1NjNybGFr?=
 =?utf-8?B?V1A1Wmx0dWJ4MkQ1UW5BSnA4RGt4ZlFocG5PdmszS1p6bG5qNFBoVTNCckxi?=
 =?utf-8?B?Yk5tcDZyUThQYitkakdQMm1uMnVaRDROV3lOVGE4eW1FNXRMbFpXcW0rWitM?=
 =?utf-8?B?UzhDUXI1WXBkRWwzelBVd0xLWUUyL0szblpob0YvTFBXSnprM2pLSm1hb3Vj?=
 =?utf-8?B?WUdsd1NQdm1nUzJpeEZsVkVMSWsxQkc2R3R6YldtRVltTzUwZldxamtjMlFS?=
 =?utf-8?B?bmttanpaR1VyVFJuNDFDNG0weHZZUWl6QlFGZ0J3Qkx1bWJESWkvZHc1R1Vq?=
 =?utf-8?B?K1FSMGZkTWIvQnVmT00weWVjUHdXSEFwRnZkS1VwSnN6WGk4cWxGd0l0MWp6?=
 =?utf-8?B?VlJLMUk1REt2aS9YeUExN1NNSTFsdTZTcjNHQ3RpSXlTclg4ZndDTlJ4NzVO?=
 =?utf-8?B?dzVzb1RDbHp6NnQvM2c1ZmZTc0l5eFMzckM1Vlc3VktqaFpXb09XNzR3TmZk?=
 =?utf-8?B?RlVGUHhLNmxKRlNBZ0FETTlscFlGOVpHM3BXRkFPWU05QS9yR3RsTjE5Nitq?=
 =?utf-8?B?VVh5em9lRkdsTmIxSVBkWWZpZ3hRSEp4TnEzR2x5YnZZdW5MVXBQRXZwUVlr?=
 =?utf-8?B?a1Ywb2UzSFBVZ1hRcXJDckdmeWFjT0FDU3pxTW9YOGljRzZzYThoR0pLZ0xD?=
 =?utf-8?B?L3hNc054Q0xWMXlCd3dnbFZmRHF5L0NsejVvRjJibTlnNFpKV2ZpVVErUHpC?=
 =?utf-8?B?dFliNnZZbHVtU08rTGVndGpxMXVnMWdCdTJNbXNjc0xOTDRTeVYyZXJLMkpt?=
 =?utf-8?B?TStYUU5NdDVEdGtGeCt4OXdlOW1CRmVCVld2U1JpREF6MlE3Wkp1RWZMVkUx?=
 =?utf-8?B?czFrODRGeHVWYWcyc0YvRXNWVVhqbnc2TDFjTE9qb2c2aEJ4NjFQYUlPbWlH?=
 =?utf-8?B?YUhFR1FnMzJhZDNwMGhrU0FETzh3TTJBMWJ5RjIydVlQc0RpVzkvUGczWEhW?=
 =?utf-8?B?K1VOcW9pV1psaHVSbUlXKzlBL1hBQXRHQmlSdnBRMHdpSkx6cjVjQ2IxRng1?=
 =?utf-8?B?cXpFZ21aMjFMcytTUHd3ZjBUYVh2M09oOW5mWmVXcU9wbUlicG9pclR3UnI3?=
 =?utf-8?B?b1RZWlN5T0l2eVJSYlNPRWcwSmhYOGZTbEtYZUswZkMxN2pneXVqWU5oL1JC?=
 =?utf-8?B?eENPbW56UHhJTnVMd0ZIc0RpcHgwci9SWEtuQ1dmY0NhQnl4ZUpkckhkODdE?=
 =?utf-8?B?b1BlU096NENpVmo4MzZJZTZ3V2J3NG5Zd0R2dm5zam5pdGNxNG9Xc0t4WTFM?=
 =?utf-8?B?Y2RhTmdQN0Z2V2YzOUNCdWxrUkFSbThSZjRBeXA0N25DcjlEdEp2dkFORmZy?=
 =?utf-8?B?UDZETmhzd0U0UnpaS1hCNWVtUUR1UHluellsVEFRVEl4Sm14OTNWODY4QXhv?=
 =?utf-8?B?NmpncEtOWlNNODh2SkdyRVJTWHd2SU84bTRMRlhTcnllWTJrZHdHK3N6QS9I?=
 =?utf-8?B?THlvbkJRS28xeDFrZTlSNHhuY2dvemJUY1Z0RHJFQmJGdG9abnFOKzdGSkI4?=
 =?utf-8?B?NlFRZ3krWTFxbTVHRmZIRnp6Y25pcVRnbDBXd0dkNVk4L0RiR2FSYXFHaG1j?=
 =?utf-8?B?TldzUXV6Z1NTQTZ2ZHdRT1BUL3hBbk4vRXJ3ZmcwejQ1YnltSmNzczNWZ2dZ?=
 =?utf-8?B?M1ZaN0N5UUMvRVNlbHlLLzh0MXZLRjYxMi9IdlNBZVYrQlFFVUJyRk43OGxB?=
 =?utf-8?B?QjNVWXFhdzFaTEZRUmNVZFRIVUVoWHpXaEJZa21EYzgwbDhZRm4vRWd1VWJX?=
 =?utf-8?B?M1NTTU5pN1djYUFjNmxFakR4bEFFV0NSWkNvckQwTGdaUGg2T3U2Ym9Ucnd1?=
 =?utf-8?B?ZFpoM2pQeDU0eEpPRHZVdnhZUUlZNTVNcDFTem5NTWpJY2JQWEk5WncyVXQ0?=
 =?utf-8?B?SXJtdU56MW9ndkRGQXZxUndqb3J5ZWJURjlvTkVVd0wyNXp4TVJiMHVVanFQ?=
 =?utf-8?B?M2lmdmcxNXU5Yzd6QU9NbnJiOFdRR2EzSWlCa2JhYndjaFJIMUdka2ZtcGhZ?=
 =?utf-8?B?UGNGU3ZBMkd1bDFuV2ZtYWlnK1BQTXdYT3htK0dSUEJMUWREcHVPUjYwREFz?=
 =?utf-8?B?TUxSazByOGJReC9vVmRPaHlCZFZBV0JVMkxFeFZJNFVYY1hlVGVadld2VGk0?=
 =?utf-8?B?dzN6WGszS0o4M0d1SVp4R1JFcVR3YjhrQ01HYjdRc3l0SEU4L2RpZDVHSzF1?=
 =?utf-8?Q?jR0TwgdGydpjIsnA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df2a2521-b922-49fc-6a02-08da0d7e0b21
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 10:07:03.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icX/Ad1NRURrBK8h6zYQheX5vc3OQbJvH8PfQozp2HqtcrIJBIcWOxc76SsdXwzWrlTQDCd/1ycybLmyxv8CirwHSBGtYfn0wxTD1CrrF68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4004
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/16/2022 5:40 AM, Pengfei Xu wrote:
> 
> +static inline void check_cpuid_xsave_availability(void)
> +{
> +	uint32_t eax, ebx, ecx, edx;
> +
> +	/*
> +	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
> +	 * support for the XSAVE feature set, including
> +	 * XGETBV.
> +	 */
> +	__cpuid_count(1, 0, eax, ebx, ecx, edx);
> +	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
> +		fatal_error("cpuid: no CPU xsave support");
> +	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
> +		fatal_error("cpuid: no OS xsave support");

We need to skip the test when XSAVE is not available. See the point 
here: https://lore.kernel.org/lkml/8735j8aa9g.ffs@tglx/

Thanks,
Chang


