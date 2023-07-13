Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0162752D4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 01:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjGMXA1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 19:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjGMXA0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 19:00:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2252127;
        Thu, 13 Jul 2023 16:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689289225; x=1720825225;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=R5sbcLhLwgza7tpNUusEz1DMSTu2ueGcqRkFIUasLv4=;
  b=Q0oChCOR8hu5fvreguPBnK+9p+fTg/XfmHwjvry9gekToQKplN5GKtU6
   iakl9d9LY1GOhNjJ/TL1msUNfsQopAJj0XB1CMEPBbIlPTjMrSPr75qPf
   cAh7inJpEu+gQEB0GSkG4R8/8g8u88C58OEeacYY0ArxHwvdrSPiX1shp
   EgFAnePRlrzq8IKD1b+vKjjxCCl5AsNW7VaZFS5783SOhd4gQ2sDJWyJm
   0a2VXXWF3JUBomwR2RroydJcNUneQWMjalV3pZCVw1doq2J/bPDSzO2lM
   EoNiBYZv6u2McM1e4VQucTKDbgUuFxYm1ciV+NXdfmbP/8XoraaiP62Y3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="396142571"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="396142571"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 16:00:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="699434373"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="699434373"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2023 16:00:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:00:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 16:00:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 15:59:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIWSSlv9USzwV9eFpSOF29N7i7LdbMcemI6gZjfhzVauG14l378xzouF2W5/19mN0K1KFeeSyAXLOCylxJU/fYx1zlptHg+RuL1VAInw9wuqLHWqDMr3BtmiHF0imeLdMXGZmLUN06FeS7/yUJPlcfcamE9Rz/1AY6od4QAU+RgrhDqnitrl7jJyL8P/PXmhGKn8kQMuELQl7cMSK1vBgHuvNyiSF3gwqDn+8Uyrd5ryZHK/DH0kD4AqSjxWo1O5cjzSzlrHUEMp3Tr5CU8X1X2aDMXKaVgq5yWOynAWgvmRlz+DgMJZmjTXbDSlTl9xzkQs6uWyRqyVoAHItyX5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Bti8nwCn3YDHwjjTJw3JWqsCq4hAbRDs5cHZ2yAOvQ=;
 b=c3Rd2pxDsY0EkuqBVjNVLRFciP46cH7LyLAVBcVoHxiHjstxHdV5qhdy/HFHSpzQre9xhKN4wgqiI3aA5dv26c5UmsQJm41U1rUG/CzS/uItIhSusYLa+4/1jdH7M3CQeuQKTnjrBHF17reZh9aLJAMOcfWqoOOYEjv/udYUtNMbO888WZIeGGVrriGNhsMRR8FEsO0wuRBWTtq/WeM0+U6OBN977nxHDNeFn4/Td+l2k3UelDkEU/pNYfq7fIjWXXhOerXT5YU34uPfcDf2cBuKcxFJjxogSU558+JC05H7eOd8B6DVNcrpp/uKvlnPcefNT1+pb02rCZrB6tZNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Thu, 13 Jul
 2023 22:59:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 22:59:51 +0000
Message-ID: <92b3ef73-6347-b52a-69ed-c1b489b11d55@intel.com>
Date:   Thu, 13 Jul 2023 15:59:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 09/19] selftests/resctrl: Convert span to size_t
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-10-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-10-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:303:6b::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO6PR11MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e55f6b-14af-4086-5a2b-08db83f4ddaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTPiT/wKZlllYa8b6+nlTnp7xjR2q5/HNIL7pLDdOn7HjWHwwCLI+Lrv0ANh7W5bK0W49+0oAP8Ccw5h0CInZoA+kfvqIipfYVoRtcTbPqgFoqB3k1Xq1tca94PtLp2IrANwVFxx4IRMf0fPTip6utsOrZA1bJbwT4V2Bo7C5aKi9XZmocydOl7drODB2w9TR6E/nSUACPpu08HmfcjIQbxnq7suqSXS+gamWaQng3Pf86oK4JMy8m5aOiMy54KL1t1d9cB+lZk11++pE8AbRqm60+cnr7XBiGsWhMH7SjWfvzKNocgg78WH3EbbM3dGqCycdinHlqQK0OvmoNZeW5ZIQlMPZyxNFDzA3A0FLDtYb+9J5xVM2y4rBYiox3wJjzDAT9weMLUCsXuvRRxzQKlGs2S+dPhHQY1byTLk7hjO97YOPPae2Z8aPtkNNusYuTcd/ZTm9zv2Z6wTWsGvEYwzKpR010WA5qaTaMtdbxILO9sud0VWPNaqHjG67K/oEkdXK+9c8uv2n9MIQYCNmZ9a6mil/qeisf57SDmTm3z+f3vWCwakc+El+gSPhGM0dvAi4t2oXaizcwHIY7abpYDpjcdEIuXWPfT+rKWqe5eeKeyYfzhoUhEHAjgy1hc6BRtRTJVmYtzK1ESx39A22Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(110136005)(41300700001)(44832011)(66476007)(66946007)(66556008)(478600001)(31686004)(5660300002)(2906002)(8676002)(8936002)(316002)(6486002)(6512007)(82960400001)(31696002)(86362001)(26005)(6506007)(53546011)(186003)(2616005)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXRWTUt1NHc0S21VY2I4TmthNHYxMm9iMXZlaHRHMUNMUXRyS1FxYjBmUDlP?=
 =?utf-8?B?V1E1R0ZNQU02MmRsT0YyUkZycUpiTHUrcWZZUFY4Rk1lOU1nTlJ5UlJuaU9z?=
 =?utf-8?B?bnZYU01PM1ljZ1RSRm1SYWljUmdCQ3FHUk5kazh2aVdndlpudXkwNmVINUlt?=
 =?utf-8?B?blhLMjRhaEpJTzBhWTdlVmxvbmFibWpSY0xDZTdHbVRPMDd2SU5rUzB2NjQy?=
 =?utf-8?B?WngwdUdVMFp6d0hxZGtLa3hoa3NZSXl2NEdmd1dYVDYyZTM4bGVRMy9USXQr?=
 =?utf-8?B?OWwxVXlTWk14dVcrVUUzUExmTVkwR1F4ZHJRMmRiVW5ONGt1WXhZN0tBVEFQ?=
 =?utf-8?B?clkzcGoyeTBIU2xpVS81dDNjVDMrN3N6VjRiSHB3Ui9TUFZHZWtVaXc0NG9w?=
 =?utf-8?B?K3dlWEVObStVUkpDcmJPRSszWWxhYW9nMXk0eFJ3TitZVjY3WVdKR3hFTkRP?=
 =?utf-8?B?SDZ5YU9CQmJ4Sk1yTkQrZkxKRnFUUUN6UlVxSG1SZTUrWVF3ZHJzRTVrZnJD?=
 =?utf-8?B?UWxWYll6ZVlERGFldlFCZkw1VzRpRTUzaGFxa2pwMVhoaGMxU3dNTXF5M2xH?=
 =?utf-8?B?OS9xWUdjM1RvbHJHTjF5bWVqbTNhOUp3dkdEaGl0QmgvNFM2Nkc3d2V2ZGF2?=
 =?utf-8?B?RGF6NVgwVU1OekFPdzR3cVJwdms0dUt2RG4veVcvWFl4RmwwOFovM05iTXJn?=
 =?utf-8?B?aVBJN1d2ZENrd1hBbXdQTnJhR3pKWlhjSTZGQ3BKQkxWYThVVVh5c1VZMlpD?=
 =?utf-8?B?RUUxWG1Oc2NmK1RTMkpjUjM0NGVYZDU2YXdaWUxkcE0yVm4rMDI3dTlEdGRR?=
 =?utf-8?B?NTY2TW4wVnNYT3p0STRZSEFtcTBzc0tKVVFJZTZXVFREb25YSUdjUUI0K2hQ?=
 =?utf-8?B?eHAvK0FtUnVjenpnRFpQa29KNjdpS2dSMmJWOHhielMyY2o5SFczZ3VObk0r?=
 =?utf-8?B?R3ZSM0tyTXdQZ0hjb2xYRzFtSXVwM3VuWFk3YXR6dFFYTG5zaWg3TGRPV0FO?=
 =?utf-8?B?cUhBemRzcWxWb1BJdGNkSzZqNDNmM3NzWDYxTUFidkc0K2YrQ09UZWZ3cFF0?=
 =?utf-8?B?TVk1TnZQYUpZd2MwUm52QlpsOVJBTVZJaFZlQmFWRllUNnpkOHZJbVlxdWdQ?=
 =?utf-8?B?Z0JhRWE1bXdUYlRLSkRyOEY0TEQzZGtHKzlzMXhWQXUrUHVyYnJhVzE1RnAy?=
 =?utf-8?B?Tld3OUs2ZHVFTDdDejRPZkNBR0pFTTRMTllmTGw5YVBHeGp3NlQzTUhuZ0pC?=
 =?utf-8?B?L2FKbnFZbTZ1ejVBR2Z2TVdza1BabmVFRlB4cnI1cGR4eE14emNHZDdNUGlR?=
 =?utf-8?B?RzJKMTZsTHYyQkUyWC95VXM1QVMyS24xVE15eE04STZGQUp5Q0JMWkErN1My?=
 =?utf-8?B?bEdqQi9DaUFFUzZZMktzNUNYdmlBWU1vRkMxUGdrRk00c1k3YW1jL2t1eGEx?=
 =?utf-8?B?eUxUL3BaWjdNNi9YNG5vZ0p2U1FqcnUwY1FNL0JGUDBscTVGc014RGh2ODQ4?=
 =?utf-8?B?c1MwajVjMjdFUHRaRE9Qc0QrZGZKd3JKVFhCdkhJZWFnTWxGNlcvVkxRRWtG?=
 =?utf-8?B?b2huKzhGRTNNMWxxRy80Ymk4U25yc21KNWhad2pQZ2JYM3ZMZW5YSnp4eGdm?=
 =?utf-8?B?bnJLRDFheUF1NUZvb3RrVERDVGp0Sm5NWU5qZXkxclF3bDFoNGwwbUZBejl2?=
 =?utf-8?B?aS8vajFWQ1RsdTV3R2NDUnd0SDBNNyttbTZ0b21Gc3g0RVdFZUdqMnJWMk96?=
 =?utf-8?B?c1NXd0pNY2RIaDJZTjI3SEZnSHNSRzlPd1E5ay9NUmJzQnJIRXZ6V21qNlVz?=
 =?utf-8?B?Qk5UMFRXSEZLY05USFlCVnRJUHhpdlMyZVlZcURxcGNMazdWRmhkUE5rOTJU?=
 =?utf-8?B?cU9rRXFZTFR0Z1RSRXBrcE5MMmFWSnBOWGFLNVEzNG55U2E5MjRDTlJBNkZ5?=
 =?utf-8?B?SWFLQWVEZ0M1Y2NzWUZtUUNEbGxoQVhRVm0raXJlL2dubVRFWE9SWmxxb3o0?=
 =?utf-8?B?UVE3ZjdTY1Y1ZnpxU1R1QWJxSnVTZGhCUTdBdC9pdlRzVEpNQTZMT0E2ZGM4?=
 =?utf-8?B?eHU4REZDU3NCV1FiYWtLazc4SitZOWl1NE5iOWFubmgyNWFMM1JFK1lqQ0Nv?=
 =?utf-8?B?Q1ZLbDZ3T2UyK2pyVytxcDRJdEY2NHBsenpGMUlNVEZsYkhTdXZ1M1pmOWNU?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e55f6b-14af-4086-5a2b-08db83f4ddaf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 22:59:51.8771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yR3+jymYumr8+M2V/ImHl8By1bJT4sfTo6jpfXSXbYrnJmKePoZfENUT4d7HyNMH5kiGSIpvnz75qqlJ/7C7QcWmsrvTlb8GldO5r3KpsT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5586
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:

...

> @@ -188,10 +188,10 @@ fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
>  	return 0;
>  }
>  
> -int run_fill_buf(unsigned long span, int malloc_and_init_memory,
> -		 int memflush, int op, char *resctrl_val)
> +int run_fill_buf(size_t span, int malloc_and_init_memory, int memflush, int op,
> +		 char *resctrl_val)
>  {
> -	unsigned long long cache_size = span;
> +	size_t cache_size = span;
>  	int ret;
>  
>  	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,

Any idea what the purpose being run_fill_buf() is? From what I can tell it is
an unnecessary level of indirection.

...

> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index f622245adafe..8be5b745226d 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -298,7 +298,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
>  void run_benchmark(int signum, siginfo_t *info, void *ucontext)
>  {
>  	int operation, ret, malloc_and_init_memory, memflush;
> -	unsigned long span, buffer_span;
> +	size_t span, buffer_span;
>  	char **benchmark_cmd;
>  	char resctrl_val[64];
>  	FILE *fp;

Do we now need a cast in the initialization of span?

Reinette
