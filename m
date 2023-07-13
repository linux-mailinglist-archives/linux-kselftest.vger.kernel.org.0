Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C5A752D3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 00:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjGMWx3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 18:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjGMWx2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 18:53:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86518272E;
        Thu, 13 Jul 2023 15:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689288807; x=1720824807;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=PoiYM5/UUjzAlnGMCrlkwUHgptXtIPEE+kkUytYfX2o=;
  b=WQ4LIP/Q1DRjnT80R6A0UV+7fuKOmtLjzDbydvvcwBu+XBGDbwQM/gi1
   /E0/JyD+qqa6Lu1CgeC8pVZUNrhZRDOqu1nqqvPl6rEoCB7I8pNOXN12V
   A8poTTWrQQlTks8pAm5/PyES0N4cHKsagRyXagtfKSMFu5Cxg32n0b+XM
   oFJIOduats/Hvtjm16G16yLMU6dndQ3dreIINY/nS0mPYw6eHRUHEvMB8
   hJ66/BHyBmzZyWF/vWbm+kRpbeQF3eqjRV620apLI2fkwn3bxiyWV3+kr
   1H7hqlDEzIVyCqS0BJ5BSnb9xRDDmTui3Hyz2+1TK32lzgXAeuQTpdCd8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364207784"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="364207784"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 15:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="792233032"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="792233032"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jul 2023 15:53:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 15:53:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 15:53:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 15:53:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3Q62s4EZnwuW5LEmHjvTJq9c97y5GAmpyWQhQQztZKIVUQBad2/5Q4qEMteRpCYVtiT8CWDhTQT/UgjkpVJ1JWITlqlx3Wxq02z21REAsu67pOctBVE1VsGFdHPqT3ylkYjEmYbburAf/afWGBazdTesnMnJIllptDOVUt6IiIDIqoEuFEc36OrwlJfY4cXRpiJpkQjQ+ps3AFSzV+j3YmhuWlzJ/qD4cTaSEJyGPgYUEj2g63wG5GBlRc5LnJIYEl2H+Wxcp/b8vtkjfQuD74HPwNQon8fT67b29JRIFSvNKFXMBMwpU5yPz8qQCq4AIIMAakCDZDi9939u1lRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwSwnXTsFwQvVH1kOeKY+7HHI2PqliqNdIrQuLhfmgA=;
 b=OLMgN2xaCditFz0acTWRlJ+HsDjbqjWuPaJ32BFg6js1SdmKXnrDxjsS1CyWs7wOwFI5NNjM4VAvX95KCL/nSsqM7qHdohvrz44HnueuOXKdmUP1Vqdsz6RUsHunZyDliQ0nRW9BE7NbB8ef8GoIOWu2AAvAKgnqwlqTzb21fAPUvx7q9pFvr0UHYNNdk8NcQAfvOkcAI/Sxz8Z3nRYb4sROChcVjzCV7XS3uBeGme7YCydbUplagG0cnzln65Aqmno+A1bUTrVvqC5vyfnnePEKADltf2mnzwN1Xdx0N6D0/aqdK5x2AflxolMVdEHTu0lqJizYBu10bsrj/RF+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 22:53:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 22:53:25 +0000
Message-ID: <406820f8-1d28-cdde-9494-20231fec0468@intel.com>
Date:   Thu, 13 Jul 2023 15:53:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 05/19] selftests/resctrl: Unmount resctrl FS before
 starting the first test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-6-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0349.namprd04.prod.outlook.com
 (2603:10b6:303:8a::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ef748b-1167-474e-ee49-08db83f3f70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aw5Hw38oQSYceZnXpD7IOkl/zcAFEka6tOL3sAapc2txWcRKmkPkTVG1kabJxopxCUzMqZrvwrJ1ZV16nTauXnp4iPo1Saj+z7a5U75VT9DlOlcj4OLqFvf8cMf3xt0uuOT5B34Nu6zIGAHnr8r2EmyTr0Au6Vw48bES32ri80wT9myaaFq+UASj3F3eWj4/P1bgTuPZRug2gTqUblKe82w+viMDItH2FQR2yzstvL1EoA9FXMgeKITO6oGdvWGw/eA8ty8bzbuxYsYjf9VJQrF+XLEZwUvuP2KrL7kPnzj009cSOfBwDu/XQos3FmfP829D4ELDV732RMjbIoVMP868+spsvmaOTAJr8QZbXGySQ0aXAaFzF6rb3d/gQST7I0iE+bNmPvz47jxDIQmP8EkvRIP3RYxCCDMstI+rtvmozo9m8wgtH1S9SZ01n5mLYw6eb/hgaqfCdTCGTLw4G7pR+Dpof7h89pixmR6sduM50rxjE0t6ngm4VOpuMuKNEnYXy6qEcQU4MYldQ1AIl7sa/373lEs21ePU0+qrUgtIc3O1KdB0DaoMKhGKJCpMDxRUue1Tl268m/TN6Bz2Qz+kaQOahBZnHqAxqKK5VGbdb4fRl1Kged/jwloNO9SQFGUzx8s7RH88llI5vjVxGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(53546011)(186003)(41300700001)(26005)(6506007)(478600001)(110136005)(31686004)(316002)(66556008)(66946007)(66476007)(8936002)(5660300002)(8676002)(44832011)(6666004)(6512007)(6486002)(2616005)(2906002)(83380400001)(38100700002)(82960400001)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDRXcWl6OUU0dUQ2WlRXRUc2RCtuMmxPM0Z2UlAveXdoRE9SM3p4NTEvNC9n?=
 =?utf-8?B?alY2bks1ajZoekNMOGt6MUNseGVpTkdPQTVaZGZDc201ZXRvSS8zdjJjVWRP?=
 =?utf-8?B?VmxQMlJOV05OaGQ4T3JyRXk4U25YNTRQTmVQMW9JNnpIZFlSWS9rMktiOWJ1?=
 =?utf-8?B?NDh2YjB6RUtUMzJtMURFRUdkb1VRdjkwdnNDNEF0VVhRUTQvTnB1NU5qbEs5?=
 =?utf-8?B?R3l4cnRHKzNUK21sQzhhbWRGeC9RbU10UVpCbFcvK2tWdlBlK0ZFa29WZGV0?=
 =?utf-8?B?ckNxNDFtTVpSMHorTEJRL2p4SG1TR1hjZHBHYm9zRmE3c1VjR3loNG81V1FC?=
 =?utf-8?B?ZFNaVmFuT0VaR0VCclRGUVdWMWxQRkV4S2tOUy9ITmZCVjVRSVA4ZC8wYysy?=
 =?utf-8?B?RWFHbkRjd0Q5K3pnUmZDbjk3QTRFQ0JQZnRFeHpwMEN0SnlTRWx0RzFtbnlG?=
 =?utf-8?B?MlBSM3pmVmc0dnh5K2JYVmQ3ZDNycFplRUxTVjR3dXRpV2lBREIwQ2VLZW9K?=
 =?utf-8?B?S1IwMmFsVHRwUk5DWi84ZW5LdjhzeGxEbUhDcUZaZWNJSzBwOEJnWEt6ajE4?=
 =?utf-8?B?aGYrOTBxeUJRNGVZQmZPU290TWtNcUFXZCs5anhDbVdGbFFINmdaVlA4eGpk?=
 =?utf-8?B?U2k5aktyNXlzc1VZVEtqRFIvVitJOTNydnAyYUh3WnNIa0RUOWpwYTExajhh?=
 =?utf-8?B?Q1RhRWIxdGtGZjExL2xpTVlMNE1KZldWdlFIQjJ3WXVaeXBMa3F3a1M3OVMy?=
 =?utf-8?B?cHI5WTZGUWtBa2ZTTkpkZGxCVFJVWDgzV0xxdy9EWCtGblFwQks4ZjFoZUdW?=
 =?utf-8?B?Q21CQWR5dlNSb0Uvb21rOTBOTlo3RTRabWJWV2ZOU2tNcVozQmUyVUZ4WWNl?=
 =?utf-8?B?cGg0aG0xaTR0REdwcG9yTUhQK0FKbmR0aFdxdXlNREdCdHQyRjE4cmVsZHg4?=
 =?utf-8?B?Zml3VEpkNE1VNWVKQkJiZS9idDdmSUJxQzh4UXlOZFZVd0tsdkM3RXBvY2dx?=
 =?utf-8?B?eTZyTVkzYXZ1NXl4RElvblVZUFZ1RkFETFhDMWpxR0cva2dUWkh3dE9salFa?=
 =?utf-8?B?TDI5U0R0Q2NpU3pOa0luNTg3dFNoZ2xrWmh0OVlQaTQwVmxvOXpFbThUS2sy?=
 =?utf-8?B?di95S0cvWnI1WjFUTUxaYW9FalZNbEwwM2Z0ZWdCeENQYm1NeStBQXZXVVZJ?=
 =?utf-8?B?TCt4VmZyRUF3UVVSeENsMDd0dUtSMzlWSVM4TzMwTzFCMzV5NUtxOS84c2M3?=
 =?utf-8?B?RklxektHbUtld1B5T0NNM09idVZYSE1TVlN5emx5VHNEdmZiYzhEcVFsYmR3?=
 =?utf-8?B?cU8wbWxtdVBaSjFBZDFVdmt1aGYyVnhuUDNyY2tDelRQU0I3cGV4WDZMdU4w?=
 =?utf-8?B?UmRFNm1yaVBLb2hTSWFnUm9hcHhQQXREV012bXlyK1lrMkhNeUkxajFlaENW?=
 =?utf-8?B?bFZheUhERGZtaDIxck5xU0JGd1c1ckVyaHhFZHFLdTIzWWwwNmd6Y3IzS0wx?=
 =?utf-8?B?Y0FkQU9JZi9Vak1pZmxWS2lFWDB6UE0yM3R4V0E2SHlyV3hxYnRTeE5TVDRG?=
 =?utf-8?B?V3VCNG1KeHE3cHJndWg1dy9rWTRncE10c2xmcVNwVmNselFFbnFTd0ZwSk81?=
 =?utf-8?B?U212RVdDMjJOaEtrVDBHQTQyNTByRGdWQnlidzhJYXNzalNkSktsR3NQS3pD?=
 =?utf-8?B?aFJ1ZE54aThvYWhkcXV2OHY5V1hzV3JBWlAwckgvbVJaa3UzUFR2YlNSbjlm?=
 =?utf-8?B?MDEyMTI2NWx1SDc4TVlxdSthSm9NTTZKNWRMSGFlVW9sLzNZV0NVTEU1N21K?=
 =?utf-8?B?TkpqU0NPZnpsUDN0ZTdUc1FCR2VBbERSTVYza2lGWTdyMjk2czNKd1FId3Bn?=
 =?utf-8?B?RTZReFJZT09KaUxOTHdyMHJGMWQyTWRQaUpwUnRtVlpMR3lCalpTaVhaQS90?=
 =?utf-8?B?Rk9lcGhUMzZKTzRSdEt1VzJybGlSNm13SVFadUdKaFYxaVU3cDBsSitPZWRw?=
 =?utf-8?B?aE1ZU2pacHg2SVZyRDc1QStMMDVNOWhBV295dmlGSHFxU2JKeXdNMTQrRlZL?=
 =?utf-8?B?Wk42Wk82STZ3RDhtM1JDbmJ3S3VZU0FyZzlUbEVDRkZhNVVrRVVyb21rRGRv?=
 =?utf-8?B?eWFKSFVXS2RIY2RvOUF5TjlqbjgrR1NwQVduYVF6cG1Peks3MXB0U2lFRGpC?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ef748b-1167-474e-ee49-08db83f3f70e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 22:53:24.9690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksfNG9ulhZkNckp7bzdMP6PvdCNTNbKkK5EgSoFmX+2Es3pUWE/EbpcVtkIgEXvLXSThjBWJWpznqTAlz7rp8NoOrcDfZQL1uJyoQrfnvAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4689
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> Resctrl FS mount/remount/umount code is hard to track. Better approach
> is to use mount/umount pair for each test but that assumes resctrl FS
> is not mounted beforehand.
> 
> Change umount_resctrlfs() so that it can unmount resctrl FS from any
> path, and enable further simplifications into mount/remount/umount
> logic by unmounting resctrl FS at the start if a pre-existing
> mountpoint is found.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_tests.c | 2 ++
>  tools/testing/selftests/resctrl/resctrlfs.c     | 6 ++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 9b9751206e1c..b1b2d28b52f7 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -250,6 +250,8 @@ int main(int argc, char **argv)
>  	if (!check_resctrlfs_support())
>  		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
>  
> +	umount_resctrlfs();
> +

umount_resctrlfs() can fail. I think there should be error checking
here and no tests should be run if resctrl cannot be unmounted since
the hardware and resctrl state is not known (without more effort).

>  	filter_dmesg();
>  
>  	ksft_set_plan(tests ? : 4);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index fb00245dee92..23f75aeaa198 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -82,10 +82,12 @@ int remount_resctrlfs(bool mum_resctrlfs)
>  
>  int umount_resctrlfs(void)
>  {
> -	if (find_resctrl_mount(NULL))
> +	char mountpoint[256];
> +
> +	if (find_resctrl_mount(mountpoint))
>  		return 0;

It looks like the intent is to return 0 if find_resctrl_mount()
returns -ENOENT. It is not clear to me that it should also
return 0 if find_resctrl_mount() returns -ENXIO.

>  
> -	if (umount(RESCTRL_PATH)) {
> +	if (umount(mountpoint)) {
>  		perror("# Unable to umount resctrl");
>  
>  		return errno;

Reinette
