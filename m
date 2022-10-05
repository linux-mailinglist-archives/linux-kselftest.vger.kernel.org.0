Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776A25F5B3E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 22:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJEUyd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJEUyc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 16:54:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1EC43336;
        Wed,  5 Oct 2022 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665003271; x=1696539271;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qkPY7UBHT1uV3O/2NOP5Y2Hw+ijoVNDT3hPzO4BJsho=;
  b=jV3C1UcJfdCSR7tDdsxwb/F6kTIeWyuSk+XzDkms6sDy/4lRtZhS2HRE
   vkx8qcKk6M26SkMsHZXXmZeWVihqlF7MLDLzz0aAq1SWkRIgR0B8JSc+l
   zqBZlmxzjW8sOc1nXfbuMtZLFV19o3TOU4lKBbSMiydC/5wqRV1UFTqUB
   gE0075JXhUWlrTNEWu/KN0uo1h55SaQNK7zTn0Pl1uA9yU1Fs5JEno0/s
   78hfUQQQ2bvJCcFM3GfLPFY1cqbysGprN3Q1wSyQv76x/wdMMa6dih4Cu
   CbG6b2D8id1/mSvd9iGzOQXNAnM0AW1WsimcOluGyW9Zblrnc+GQrobTe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="286494948"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="286494948"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 13:54:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="602172354"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="602172354"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 05 Oct 2022 13:54:30 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 13:54:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 5 Oct 2022 13:54:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 5 Oct 2022 13:54:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIVbE0rukrE9Nm596yZjBT3qwaOjLNRo56ooymi4iCbtvgB5exusNfDlRCA9qDLoVq3O2lNMfNMMgKeE7IvIWMWGld0oudd7AwaSgNHcAlTDV/lLeYRKVTbrw3LRS7Vmv+tZjUCU1YKOqLvwCld6ZOTsg8lEQ2G4paFaemucW3h3SVb54HJEJ5NNKudyYhTb7G/5hxErHHBJpXvTp5YLmzu1/8nMFKycRZLgBeyJIWm/HffWuK+QOXT7fCLBolyNd4iGF92/zSGC8t72M2MYxxD1tIhqUKkmU+Pbnaa7/ZAwwccwMNjjcRCTtG6rk+6i6YmBOj93gwHnsEyb6hwDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta8woqnjFH84i6Ht0/xGx/hX/FXOGHbr0zDdeVshquE=;
 b=AnhuZMiu9bUHibjtmzbIRckwP70eBB4OrAGg9Rgya7gfnvFiLyu82b9tcDAOQ5a7h1oeR1ISl53MgDFCxislFtJZw2YdpFFGcJSzMv/aQpJUPgYu25VtA4jnKNAnCyqIsayKrEzP+u27ymvm1T4O9nVV3upRlA00XbxlXMZYyhygtnf4scJ86VQ0L+YtKS3yvH/rlDQMfWeTNdoKu1OyCJgiZysyNHp12odHIIR0PiYH5MOR+YC75gkzGLm57Ra26McOwYobdXMFkzOLRjuOmnloIHoEJb3LAgY6424ww2k9uyTcfhNIzBescDxmpSZdAxmMdmn++xQz0CA0ZHFyTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB5988.namprd11.prod.outlook.com (2603:10b6:208:373::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 20:54:28 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.033; Wed, 5 Oct 2022
 20:54:28 +0000
Message-ID: <e59c4bb7-d6fe-ed43-0bfd-124e3930260b@intel.com>
Date:   Wed, 5 Oct 2022 13:54:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [PATCH v2 3/4] selftests/resctrl: Remove duplicate codes that
 clear each test result file
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20221005013933.1486054-1-tan.shaopeng@jp.fujitsu.com>
 <20221005013933.1486054-4-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221005013933.1486054-4-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0382.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::27) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 36289e60-6844-4ce5-f6ba-08daa713cb32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +R42+TzfYhDxhwYlppIS9pCdo+c55Fe/zx67Z0D7fMUIE+40D8ZVK7St8hgT4YC0V03vxXjph45oV7HbO3zJDZyYwrU5T2LsgEwuVG4/sLCEg1Dv7QBWaHLE+Ed6R0/438W7A34EHzIwwwZj5KUC6jOb/14HwrBrFw5k+kpreFAltYaZwOlhyq/CqBCUoRee2q3VLCzGkERheGlJrOp7vG+c5O8JCXKB7GMLeoCr0bAg3w6vIF94r83hNJ+L7jnymHFsomvBWLA2vYIsAymqdQ1l+glPoZHFBtsUfD1AWu1RdEZ6YAJJLbru5oRh5eRCAgIajvVOktikPcWJE1xUGSfy1f0m3Cka9KOQ6dXowSBWwV8uR2bSC1P/s+boPRwxVvgRRVUZyS7/5/DJD0LTOR8ovh3MEN7l+6cHFjGFTPrA7/9fDs7CFa0Y3Pbz5v/m9pbJVnI/4Owc1OVkOvsyMN7JXpgOd0teQP29IcpArw2J2xxlPB1aCU724s1KgmCrXwLBb6POz+DA/d/aoOZC7HKFVAslhdms0o0A5N0rE1wN4/uUB1q65b+9ptPFtraMwVsilrB1M823VBGLeIblML+imBEldseY9PXcGddEYQu9nSL8gaf7137qodu0fH3aBQeGYcIyXrK2ZL+lRa8ulbWGAhWPKiYIIxbRNBsvg8L5CcZWZOdEmT+84INn3D/FyGZJNvNhQUlIDRvxnX3UfFFYZa8FTUlqjwg4ufEr5gf/Dk764UPzLucQv5MATLJdynnsJQ2ZMesPgeM5hY1yo0xOxMXeo3q+wjVFUXdWFqTTFLNFDbnjrMxDGhDLmhJJbN3toI7xWNH/VaDfio9RCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(26005)(2906002)(186003)(83380400001)(82960400001)(38100700002)(66946007)(66556008)(4326008)(8676002)(66476007)(316002)(44832011)(41300700001)(8936002)(5660300002)(53546011)(6666004)(6506007)(110136005)(6512007)(966005)(478600001)(6486002)(2616005)(31686004)(31696002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEtkQmkrUVZ4cTl5b1pnRGFDbFBTY2xzTDFxb2d0NlhsdW5PN3Y4YU9xU3Nk?=
 =?utf-8?B?Vk9qOW5KNk5LVUsvc0ppeGdCU2pBdVJvOXVVaW1tRXdhbXR5Sm1mdkM5d1kr?=
 =?utf-8?B?UTJzT3YxNnhPRFlSWklYdDZMeWV3VlEzK2QrZmE3bFdoSDJEU0EwYU96c3Ro?=
 =?utf-8?B?NG9KQnMzWnY0c2NyRHByR2xGUk1mZWhPY0xzNS9GT29zK25xQUZITXlnb2RF?=
 =?utf-8?B?RTlwRGNsaFdWY1pTc0ZJZ09hYnB5NU9CVW95NEFTUUZiYmJpUVphZDNoMk1G?=
 =?utf-8?B?Nm5RVWJ4Um9aVWQwVE9ScTV2Q0FjR0hIMWxtWTVFYXVqeWZQUWZUMkw4TzRw?=
 =?utf-8?B?a09qeTF4NzE3V0x2V25mY0pUc09SN3lmSENvbWdVaGJtUlFWcmNyYTV6T28r?=
 =?utf-8?B?RVpLSkN0djRYMEZ4djg4R3pIRmllUjNGZGhhZUhnR2FVbFgxYWhhSTV4bWk5?=
 =?utf-8?B?aXNYN2JwYTZhRWszNzJ1Y3prNzJodE4wVHk4SExjbEtDMm9IZVhSS0JTc2t6?=
 =?utf-8?B?RmZCS1pzcS9zekdHcC9PQnVuNjVMSEJKL3N1em5DckxNV25tWGZNT2JsK3Z3?=
 =?utf-8?B?MnN4d1RWSW1YNkZLUzVUM2ZyWmtrVXJNblNiQ1dlVzFnQmxoeXdNeW5BWkI3?=
 =?utf-8?B?ZFJWdUUzd1RPOGo2aFpZcG9leHdlTlpFRlFDV1JHcjErUkw1bzRwN1hJWlJn?=
 =?utf-8?B?RmNaMzNIN1UxQWNxVG1IL3hTZUh1U2xMYjY3WXIzN2dBSXFQckVodXVjejd0?=
 =?utf-8?B?c01JZC82REcvdG5nZThlVU1TWmdlQXBpeks2RXorMFNXdWlySENXbWovVG9F?=
 =?utf-8?B?Q3VaOGFaeDZneG1Jb0lraWRDeHJ6NUpucHVXaFZIam56T2R1Z2svRFN3YVh3?=
 =?utf-8?B?MVYvQTA2UEtxaFlnNWIwYm8rVkRSUy9KVDRTQ0pXanFFbS9hb05zcFNjaWtx?=
 =?utf-8?B?Sm5tZ3FxQlN4MFNqZEgzMVorcUc4OVpoZUJiZE5mYU9RK0l6NDFSOFYwa1k4?=
 =?utf-8?B?TVg1b1AwQ1B0NVVSc1orcGtNdlZURWhESnh4cHBUWXhXRDZHaGxYZzU4ZEF4?=
 =?utf-8?B?ci96MGRwUVdyV2ZxWUt0d2ZhZWJMRnRnUk5ZOFlmZ2VCdHJLcU1OVkUvamNn?=
 =?utf-8?B?U1M1bDNjd3dxRmwxVVljbnIzbEl1NnMzd0VSVFNURHZLeUREaTNaK2NqZmY4?=
 =?utf-8?B?VmFnZERBSStyTU1ObjRIRUdKajEycXh4cy9qaWd4WDlKNzBQRS9OZEowaTFG?=
 =?utf-8?B?aFFFZWJRZFdKdngrY3g5QTJwbmhZTlgwdmw3UDgwNHhvVGlBOTRjL3FHN3ph?=
 =?utf-8?B?Wk5PTFRRNjExeVROODNqdlFBajd3bWV6WEk2Rlk3Q2dORTdLZFcybWhEVDhR?=
 =?utf-8?B?ZjhTVE8wajBmSjlkYndVMEpVRUwrYkdJR29ES1Jadk5LZTZxZ0pFL2YxRlB5?=
 =?utf-8?B?ak96d3lXK0h0WUxKQmRaYjJDaUczQ0xsREMwQjhCUDdQODRNSm1IaXRPODVX?=
 =?utf-8?B?N2ZzVEdEOTI2RVZZNzFYZHlHNkpVT3NFdTRtY1M0NkpCWXI5Z213WTM0ajA2?=
 =?utf-8?B?SWlUT29qUnNjMllka1d2SDVUV3RkSGFXU3NUUjBBMEZWdXNqZGNYTHQ3WWd3?=
 =?utf-8?B?MVRSWm5lZ254Y1RiNWs2RHc0VzhzckdSeDVTRkZMSkl1OVJQU1FubEhuRUlr?=
 =?utf-8?B?OGpOV0dPanM2WkZCK203RDhmaEREcm5uUUtpVlNZWnRkWEZTci9oVFA0MkhI?=
 =?utf-8?B?MEN2M0ROOGMwTCsrQStnUHlsTWFUakg0Z0UxVnZuN0EwMjM5V3BUb1FHbENF?=
 =?utf-8?B?N1JjRXoxTU1ZN21uRlY4Q3BFOWppQTZNaWF2a3BzYmhKRWdXSDkvN2V5a0ti?=
 =?utf-8?B?aGhGZG9iWmgrMU90ZTBUZ1ZkNVVNMHd6OTc1bDViZjdscG40SHlVb3JCRi9G?=
 =?utf-8?B?YW0zTnlIbnpFcjZRSkkxRGtITWttQXhncEdTNW5qbUF3Z1RROUswWTBudHhy?=
 =?utf-8?B?TjNlTUlvRnVpSTJ3N0ZYVmZDY2tjSmM0ZEQya2kzT2pCVVJyWUxFSnRIVnY3?=
 =?utf-8?B?a21BaUNCMDVLajhoakFMQlVWakZndElYT2svZDlQODV5RFJKRVRZRFUwSTNE?=
 =?utf-8?B?UnVRaysrQ3A0MEdZTWpWZFhyMk5xSkg0NFRlR2dxcHVzVWJhK3JDclhWRTd5?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36289e60-6844-4ce5-f6ba-08daa713cb32
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 20:54:28.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3Se/aLDmjjZPf/l0MCpD7iCeRVEdsKbtqwrFhpsldUZVqvZr1qAV9bL7iQdxTy1pBxt4gXqHuOaLrirc0K4xkH57iGC9ZNdK5LOSFx8Jbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 10/4/2022 6:39 PM, Shaopeng Tan wrote:
> Before exiting each test function(run_cmt/cat/mbm/mba_test()),
> test results("ok","not ok") are printed by ksft_test_result() and then
> temporary result files are cleaned by function 
> cmt/cat/mbm/mba_test_cleanup().
> However, before running ksft_test_result(), 
> function cmt/cat/mbm/mba_test_cleanup()
> has been run in each test function as follows:
>   cmt_resctrl_val()
>   cat_perf_miss_val()
>   mba_schemata_change()
>   mbm_bw_change()
> 
> Remove duplicate codes that clear each test result file.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_tests.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index df0d8d8526fc..8732cf736528 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -88,7 +88,6 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
>  	ksft_test_result(!res, "MBM: bw change\n");
>  	if ((get_vendor() == ARCH_INTEL) && res)
>  		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
> -	mbm_test_cleanup();
>  }
>  
>  static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
> @@ -107,7 +106,6 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
>  		sprintf(benchmark_cmd[1], "%d", span);
>  	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
>  	ksft_test_result(!res, "MBA: schemata change\n");
> -	mba_test_cleanup();
>  }
>  
>  static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
> @@ -126,7 +124,6 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
>  	ksft_test_result(!res, "CMT: test\n");
>  	if ((get_vendor() == ARCH_INTEL) && res)
>  		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
> -	cmt_test_cleanup();
>  }
>  
>  static void run_cat_test(int cpu_no, int no_of_bits)
> @@ -142,7 +139,6 @@ static void run_cat_test(int cpu_no, int no_of_bits)
>  
>  	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
>  	ksft_test_result(!res, "CAT: test\n");
> -	cat_test_cleanup();
>  }
>  
>  int main(int argc, char **argv)

I think this is the right direction ... but you fell into the trap that I
warned you about in https://lore.kernel.org/lkml/bdb19cf6-dd4b-2042-7cda-7f6108e543aa@intel.com/
- search for "please be careful".

Reinette
