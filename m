Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786316EB64D
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjDVAOZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjDVAOY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:14:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A16ADD;
        Fri, 21 Apr 2023 17:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122459; x=1713658459;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IoWdon0s8nByMTbHLrsDm3Pm5ZQSOD/kZeejr5+n3lA=;
  b=JTf7iu3ooirGLTS6y3R8O3PedJ5xC6oOr1Z/27yoJ6te16NZ1P5mns/Q
   B3upQhb8WFoJ62rE+P1Z1iG5pSpp9A1xcOYdpKVZs+8/oulzEeE+D/NxB
   fZdcUUcnnBkOo5C2Uk9lmJZId7zF+cWeQNQmIgArroQsAFweHiMbASjOV
   lnHcIY4DWWOgMIDrvthEFCLK2Ka/HnZSCM32XmzhLsTsv8TVaMNXXTWRM
   cwY+gn+clL8fPdeep3WpcjaTP1mks5ewiudbF6o7QxjQp4XulwH5pcHpT
   JYVZdwJxzvf5AViG1b8qGnhplBPcHKMF90eRanZc0QCfd9PBwX2bxi+QB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="348905912"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="348905912"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="781776317"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="781776317"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2023 17:14:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:14:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:14:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:14:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo576zaO4/2ZP+ARvOB7o2s6Lq8TctD+9tc4enXcWwcxN6owjBR6j/nAnCqzUrz4mNJ7GhMGNUqart4UrS+mM2zOkJlJlDvT3O113+hBfW5MHseFbI8RhVFnlQ2is/Hq7yJ4TvZkD472G5MsO4AFuKTJG4TnesnYYg/Nsdp68BIJn+0YtlJKAUWeGQ7yXlqsqM1F+8WLnJaNsjBWK9BnfeiUFPwIQSizs2+wPYKt+oV+WcfNIAADq5v1y1qb8YyUJL0FBhuQgVMilF5fRoIxChG8uQQaIbLLddrv4eBvcfFEnItnhvR2ehd/Bswep2PuCTo8Ig7C+7L0XJswCmks2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVYqJ3f0zVWUxGGEXb99hQdl4SIKTvE/wvTx8oD6WMw=;
 b=akEn8jw8pfJrRLOTDrgpaLFJyf/9FF9EGopc9bnk/YH1BOUiLC/Hx6vwpnnoYF6P8Hlk8t7J1EmWLLlIydQ/oafkMk5gggae9cJc5s2bHEQESVEFiJnxCL3/PBzRj8fEQoCHxm0vIAVsIkVyNuhDI6t6gu1mMGX3tegxkbEUJL005thbULT/CRkKWIRqidI4pPj0hr1nio1MPTVuOO56RQKa3T7SRab9ZeHjpiSGDKv112PzlKNvpJE9vVpmmq0+kI4L+3fcpzwVQB2Hhl0fmZS2/AH3TqQ3lUT6KchKTZQVCoBrJh0PngziCMrQKoJF2qytRqZmxXWQIknkhvMjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:14:16 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:14:16 +0000
Message-ID: <59cfa762-24c8-5b53-feca-517250192d65@intel.com>
Date:   Fri, 21 Apr 2023 17:14:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 07/24] selftests/resctrl: Remove duplicated preparation
 for span arg
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-8-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::31) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d4d7ae-ab29-46ad-c676-08db42c6822a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzRAsns962hrsxJ1pIo20GMi6ca3x7UWAQ5dfejO7GH7Dgq6LK7ifUofooISRNe8C7riupKpR/5ayTNcTGuHbni7HHNv7BxgDfuI3qcTTXzpgkk9w/Pvj5kAIw2ye3fZJH6xmTVp6FLqDs3weZHJKA/zOI95vbnoF2cxrAAYzpMdXymGwop7RkKkqfzsvaq0/2qzY0epvkn6v3JBsQa5Xg59Rko6kuQW1jSKQrNeMqLQSMQs0Y/CYLC5tVgpxgjq6nfI1MZ5Ej9hLD3jsGcWaXeEyk+ipatCLoqQZd3sKr31vDvTKUv+FX1IJjM48/98hxD8keVQBHoz9RH7RBZVT4Eb4Gd2WREzatytnLhfGgJ7l4KHHPx0Pz7R6GN78kEcqzhhbtPfPAaT4zZtq8RNYAbtt2uM43ehAbtWi5L/n/rpRqnL2axSYuI/ZYZ6sre3t31zvfp7AgRNi2ezdc8E69eBDjXcgqB1d/v4KTDcSwbKzFuF/bRxXUHubaoY6GKirMCA6fyLOAKdIIIx7X8h2VyET7aAJGZ+8+0pAbW9Ur0lTkbgfoCfEXzQoJhX3O6yB/8A3anNKkAk+L5wgpAxXaChVKgF3vzTPu8KSTvlu0jcrKcjsAG568j4FWv3S+dnPk/fh0JsmJrQ5DyW0Sb22w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(2906002)(8936002)(8676002)(38100700002)(44832011)(5660300002)(36756003)(86362001)(31696002)(6506007)(6486002)(6666004)(6512007)(26005)(110136005)(2616005)(31686004)(83380400001)(478600001)(4326008)(186003)(316002)(53546011)(82960400001)(66556008)(66476007)(66946007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ampRMUd1MkE3K01iT3JnN3NIUXpuOEhUR0pvSnZjRU5tWHZqNC9Ha1B4VW1i?=
 =?utf-8?B?b1d4UGhIa3ltL3NnZWljczNsS0tuTVY1endmemdkdVNqRGlaWlhZQU5odWcw?=
 =?utf-8?B?NzlxRHNjYzdvNUhnNUhlTHVzWDdsRlNldXlpQW8yU2dnNE0xZmh5ZHRELzI5?=
 =?utf-8?B?dFRqMklEUm9tMGpudjd3SXRON1JGcFVjU3FodkxVd2J0dHBSL29aWWY1OUZC?=
 =?utf-8?B?ckk2Tk1DSVBsTjJ1OTBjcHprUzgzNmRiZkhSZVlYNmkzNjBuQlhhTHBYRk5S?=
 =?utf-8?B?ZjVqNHkvK2MxSU1ESUNlU3B1aEQzdjNVbkpJR2lCRzA3MUZPRTI3SWJqZCtD?=
 =?utf-8?B?YWpmbTljUTYwaVE1a0tJZzVtajlJRHpDSGJ3R3ErYlBnVmFMalJ5ZEFQV3RM?=
 =?utf-8?B?U3FQaktoVFZxaXNZTEZQWUYzUisrTTdEWWlNbUI2OWhtdHkyVkJHOUowN2Fq?=
 =?utf-8?B?WG1CbEFSak9DVXE0bXNTYXp5UE5pby9QK1JsRzFRa1U0K0tnQllYL2tPY3dn?=
 =?utf-8?B?cjFqWElVOFBOK0pyTGU4SVBVeE9GdWkveDg3MWxNNjJVbU9ZZ1FtWFdoUW5P?=
 =?utf-8?B?bkd1RU1lTHhVY1VMOE1lM3NNdzdQZzdnay9VUTVQZW5UalJiVkltYUVSNTV1?=
 =?utf-8?B?WTBVRklMdjFHOXU5U0lHeWpHZjhHbjFnNndrNDdCVnNxRFpsOXFPUEh2eXF2?=
 =?utf-8?B?TWtFMGFqRlBEVUVCNzZXMDM0VS9VdFVOOVJ0bjdFaWVEOEphZnRTelZ5ejd2?=
 =?utf-8?B?QUFsMFVNWTBTR08zczAybWtPRlBLSnZlaHVKWXg2elRLRkhoNm5jeENKRDBM?=
 =?utf-8?B?Ry9sSCswSU1tbXc1NS8yeGlXNGRERVNON1QwTlZGSEFkK3RrT3JHRWYxT293?=
 =?utf-8?B?am11MFZKWkhWRXJRS2RIalZRemF1dnhtYUEwaC9XbmhyK1FxWFdFZE5lUkVp?=
 =?utf-8?B?S2YzYzZqTWpzdEJWdWJ5djRQQjhKUE94dFRXNmJpL0tFSWk1TDVHR0k5MG1Z?=
 =?utf-8?B?ZUFubTJWOHBZb1Q4RFRhYWgvTGNzcGxYOEZPQk1JNUJFNzNWT3h1bG5iY3B3?=
 =?utf-8?B?eWtiQndha2ZuYzl5OW9Sb0JaNHFyUUdKWjJ1T29pZ3VqQkp3aXpuM0xFQTZm?=
 =?utf-8?B?VWwzTEhQMnkyeWliK0d4Q1ZhSU1tZ1NxZDByTEErRUp4TzBMVzZYS051RGFk?=
 =?utf-8?B?K1pwdmZOSzREVENWaFNpcEw4K3ppUGJtUC9BVW1oWWVxbHNqTlYwKy9adWtZ?=
 =?utf-8?B?dmlxVlorR2JCOWN6alFuU3ZJVGE3c0lJY096Z1NjOGtnZWJ3VHE0VTFRZU9B?=
 =?utf-8?B?OXNRQUEzNDk4c1pnUnFlc3dWcDJRNmRLNHgyTWFpd2U3MGw2eFcxNi9jYm9j?=
 =?utf-8?B?NEtyTk5XVnlIUFVCV0xWTHVoVXh1R0t3cHN0cFZXT09lellqTjJSZGZ2OGJB?=
 =?utf-8?B?MGV2ekxQVEhpcXc5ZkMrSWQ1c3dIMFkvMHVUZ3JSVXNTakJrcGp5cXdBMkxR?=
 =?utf-8?B?djdkNWNRVkJZY01Dc0p5dHo2SFh6eTlyOCs0NUNTOEtXRzhBbFNFRDFLS2tU?=
 =?utf-8?B?T291R21udlZTZ29jVjB5aVdVYWpma1gzd1Z6U0x4eDBselo4QUVxZzZySzRk?=
 =?utf-8?B?ZXYvZGVwVi9mTytLOHJkUTRpQmR6ZWk3UmtIUzdjeHZrZWc5ZGZad05ZR2V5?=
 =?utf-8?B?Sk9UVUFSUGs0TncwckoyRzl1RXIyLys1NytudFc1T1Q3d0NtcEFkaVlObUpw?=
 =?utf-8?B?aTFTSHV0UWxXUEc4eEtIWXgzcm5KSEgvdVNuckQwcHRaRGhLRTlzRXlJQjBT?=
 =?utf-8?B?dEhhZ0ExMDdDTkFic3YyMy80QnJ1cHk2akhWNm0xWmlMQnVscTJIclJsT3lZ?=
 =?utf-8?B?VGI5ZytIc2lXaE42M2RiZzVyM2d2OXFIZ0gyZmlhenNtYWJnR2FaMzR6Z2Qw?=
 =?utf-8?B?b09BMHBtcnViZVNYMVhSbGNxNkR0aG9SQ3ZIWEhjZ0hqTjhYQmw1M2ZXUzBB?=
 =?utf-8?B?bGsxV016aXFtaUY4a0JyV2pSejBxYVcyNHluYVkvQXZtY3FQUlNmaWpOWWJ4?=
 =?utf-8?B?OVRvRENxMVJpMENpakNCaGl3dGpLa1R5MHlDbEZwZXVmYjVPd04rTFZvVC8z?=
 =?utf-8?B?RS9qQUVCejZkV0ZXb2FJcjZOY0wvTWlJL0pzNzdMa2hGYW5QOE9pQkhEeHk3?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d4d7ae-ab29-46ad-c676-08db42c6822a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:14:16.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZIqbKey1w5frV7xa5geopBlkYjpgjf98QAaoWwCHMl8nLUHJ2ZfluivyXSH1dXPVK3Wu5YTaVXfWtchjidYsj0wiUEzwxkleE0MgQU/db0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> When no benchmark_cmd is given, benchmark_cmd[1] is set to span in
> main(). There's no need to do it again in run_mba_test().
> 
> Remove the duplicated preparation for span argument into
> benchmark_cmd[1] from run_mba_test(). It enables also removing has_ben
> argument from run_mba_test() as unnecessary.

I find the last sentence a bit hard to read. How about
"After this, the has_ben argument to run_mba_test() can be removed.".

> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_tests.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index f1ed2c89f228..3c8ec68eb507 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -99,8 +99,8 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, unsigned long span,
>  	umount_resctrlfs();
>  }
>  
> -static void run_mba_test(bool has_ben, char **benchmark_cmd, unsigned long span,
> -			 int cpu_no, char *bw_report)
> +static void run_mba_test(char **benchmark_cmd, unsigned long span, int cpu_no,
> +			 char *bw_report)
>  {
>  	int res;
>  
> @@ -117,8 +117,6 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, unsigned long span,
>  		goto umount;
>  	}
>  
> -	if (!has_ben)
> -		sprintf(benchmark_cmd[1], "%lu", span);

Can "span" also be removed?

>  	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
>  	ksft_test_result(!res, "MBA: schemata change\n");
>  
> @@ -297,7 +295,7 @@ int main(int argc, char **argv)
>  		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
>  
>  	if (mba_test)
> -		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
> +		run_mba_test(benchmark_cmd, span, cpu_no, bw_report);
>  
>  	if (cmt_test)
>  		run_cmt_test(has_ben, benchmark_cmd, cpu_no);


Reinette
