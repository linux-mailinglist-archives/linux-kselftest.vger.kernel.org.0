Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F2B4D6A27
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Mar 2022 00:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiCKXOg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 18:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiCKXO3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 18:14:29 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FACB7086F;
        Fri, 11 Mar 2022 15:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647040405; x=1678576405;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ri4Ws2Txp1D0CqSYmiZEvXREOcP/Dbd7ogqRINgpo2g=;
  b=gh1sERsdgRHTz6xIgOaGWiF8C8UMLgnvmBp5FZmMdae0P25BlUu+MX+3
   W+7kwf1aVUQYY0DKO9zZ0fPPWXXl7MmyxkvLR+izcuXQ1V6r5FQb5OjRh
   tQPqXw7FectqxF6XM1tMu+V3mwKPm2OkzFpUIvoMvoL7JD8MHR45abifK
   FjJgHSIBp2rK38OcpSyKlsxbI0O1O0ODZahg3nd259xUcvln4wXQTsoV7
   fVRG29FB1RRubfCffovytufiU++hPk2lGSbpHkTfk+Ls/gUexed+vLgMt
   oiVOBlv6Q5l/RhGn/3f0m8EKJ/HGPAVPmzAyoXBxshsK4LMbhSkLx/hy9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="237842153"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="237842153"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 15:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="597259529"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2022 15:13:21 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 15:13:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 11 Mar 2022 15:13:21 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 11 Mar 2022 15:13:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQ5FGBLEpd9OhOTPL7kNadkLhF1AVKqOFrxKViXE5FIaD9BT9HP1BRSn9r8hEgWdal20dyA8m8LWSa4sHWRYS3WzexF3bY4dV9/PJKRvy7I9qVEk2WcwUmr7s4iBwTLKGE/w9E2Dzcm6pFIQ6FG+2xkDKuls2+BVny0MRHXWQzWB9FWfQR+MqlMSd97DP7a1uXGw39KNX679/NAH+Goa72/7YSi7ADQNoaVmzVPdB51z0kAkeLhdlm5OKY61ZYzs5YV6ry4pQJyHYbBsFCSw0eLf8DQLp7oEbuXCKJAcMsMV4DYgEdJww/PnMNnFxNb9L/zgUHZaWPJO8Jk0YQ4W3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEDsGwM+FGYpAC2ZPJRW9wRnQIWdFOfBd1pZVrudvlY=;
 b=VQVDHPn+cbhgPw/3Cn18gFPt4KoCdQ90zdkHDTmJ3tEoq9XczywU1Fcyh5eQbICR9yAatBm0FpxWuttk4rU2EDHfeWTccGf4f+tpaMERVZ2jUBSuKXWcMIs8AKiD6yOuHcYpYrtrFpTMCUcT1vegm8gDgDQUz7MYuDTg4yx+G5DAzubWB6S0hwA5oskPqSNZYQVY4oRFeol8J071qrIdVjREZiu4HF/42a836VdXOc5qgUPn2yxIBM/L51uQ/uRzBj0KvXDpSBwKpcyNJWcWWx0g7e+oOrt30O7UGlTzFJjKdCHxKlHtjH/e76SWQxmH7ZvCLPb36v/saF67dMz+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5740.namprd11.prod.outlook.com (2603:10b6:610:101::7)
 by CY4PR11MB1512.namprd11.prod.outlook.com (2603:10b6:910:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Fri, 11 Mar
 2022 23:13:18 +0000
Received: from CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::b432:16ba:2819:d702]) by CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::b432:16ba:2819:d702%5]) with mapi id 15.20.5061.025; Fri, 11 Mar 2022
 23:13:18 +0000
Message-ID: <15acc266-2b92-9064-399b-3d5e4b7ccf85@intel.com>
Date:   Fri, 11 Mar 2022 15:13:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH v5 3/6] selftests/resctrl: Fix resctrl_tests' return code
 to work with selftest framework
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Shuah Khan" <skhan@linuxfoundation.org>
References: <20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com>
 <20220311072147.3301525-4-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220311072147.3301525-4-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0044.namprd15.prod.outlook.com
 (2603:10b6:101:1f::12) To CH0PR11MB5740.namprd11.prod.outlook.com
 (2603:10b6:610:101::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 195fc74a-5198-412f-43eb-08da03b4ba5c
X-MS-TrafficTypeDiagnostic: CY4PR11MB1512:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB15121E215B7F077B06AA1464F80C9@CY4PR11MB1512.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+mY8zA64iMSSqdp1EZXA1nbkPSrUKjlqdfGdai9qPGwF6UZAAMuaIDqumQcMIJ0Sip2n9wWscSp376+GhwY3Fhh5CMA16w/ltCfAw0MYHJ76tPOJwdXjpbv4X/QmA3ojdeT/vkMg+8xsgoGeBkxMh9ZVYYd62B6gUnTnWT3B+FuxBemo1SboPA6sTel0liS7HCPisHxY9ccQgmJ6n7VvpRhzvNHEeQ7lnf5IVWns1RpbhACMEl4B5aXejOUaQgJNS13Mr/ww/di7KEJyLRT1/V3xlhJIpUzVRPD0TE+KXpMJL1eq3zYASO7egYWpzG2Y+yjQdBzkiQYKHcZfzr7g0WanDCMKjhX4uTxLygdIewoI3K18e8yLbl86cwRD54ZeY7LZrmPJqyU1VUEVJWPOS4Q3lkKDMCD+ZtCfR4pPXQJOk6M02P0FRHpIFsRCtUFxphsKaAm+52/lpQPjDHhTPw5/FPT/MWUplur4/pVvyEmr54jvacmTOhrDdIgGuG68hoOzPclTD/g9vbbRDvXtalCue7LOE4DohmVmwGFJnsIhb5EEow33zTdiTcarApxXWsabYOw7vDd0HqZWQKxprs3EOLTPnWcmtb5qSaEdTxTkNZ1auDJvGj3IHq3ztRs9MYBIotNwYXqXeRjec8YJSmjy3KOboUq4THYn5p5AoaIa31L2uPAIJa7VQhXf2tLOZpnTlGcVkH5MVNMIFKexh/uNn8YOf7MEhG4+nvmtsRxriXQ9i0nLNUIFs0i0JtF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5740.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2906002)(5660300002)(26005)(66946007)(6486002)(6666004)(66556008)(66476007)(2616005)(4326008)(8676002)(86362001)(53546011)(38100700002)(44832011)(82960400001)(83380400001)(36756003)(6512007)(31696002)(316002)(8936002)(110136005)(508600001)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDVFWXNCTm9uZ3QwK1NjaHNlRzFsVDBacUtCOFY3WndaUDV5TnEyd3NkbWhN?=
 =?utf-8?B?VHhpMUpndFFMUXhuU0QzWmNlTEllRWZWN1Bja004UldST01OaHVLTCtpaHc0?=
 =?utf-8?B?WjQwdTJsTVNXZWNGSmtPOS84Ym9SSitpMzdxYWZsaEJWejJGQ0lUYmxnU2hM?=
 =?utf-8?B?VVBrN25OZVUrUnNQNm1vMmNBM0lPSnVON0UzT00xbXVGaTFNQks3Y1NiR3hm?=
 =?utf-8?B?Y1oya0lhNzc2aDJWb05iNXJ6ZDdLSThRbngvaCtEN1BNM0ZzNzQrU3RYeDhn?=
 =?utf-8?B?ZmZ3MVpJU05nV3VJOEJmTFB3RGowL1V5bWF0M3RTeGVjaUNFRjdYQlh4Z21k?=
 =?utf-8?B?RGtSWW1Ma3NUL09ZdE16RDBEd0d3MkJERVM2Q2JzWXRDM0lieFVrVXFUR0Mz?=
 =?utf-8?B?R0tLNkU4TGJqVW5QVkkxVXp5eGZiODEydXFNZjFPWjNqUXJrZXFoZDRFV3lt?=
 =?utf-8?B?cGRRNlNGcmlJcGtFSFBUWVVza1RQYkJ4U3Y2NmVmTUFSbTdzTGYwTnkvLy9K?=
 =?utf-8?B?WkFrY0drd1YremNjUitwczRGdkFGV3R5KzVRVW5Ib2dDMm1sdkFmbG5VQUNG?=
 =?utf-8?B?cWh2UzZZMW9VMkF1cUlKcGZEeTZCZHV5VW5TZmFYd1NveXlQbGZFK2RwTnJY?=
 =?utf-8?B?Z0tmVU1GRjRVamtMS1h1ZGMyMFU0MVBPSUdqa25Nc3d2bHVuaDZDUHVoZXJN?=
 =?utf-8?B?VDJ0M1pScks4TFBrT0N3Tm5jNk8vQ0NCejJWeXZnV3NJSlpyS3R4bEJNQ0d4?=
 =?utf-8?B?SndhWlhJNmZLSGVyU0RacStWVXI1QTZYS3c1TklOU0dEUDRsVHlVUHVYVzNF?=
 =?utf-8?B?SDBnRmRVYk94YTU4OVVMM05ZWEpyRE5XL0lqWGVOTnJDS1NZbjlCMkh0WWs5?=
 =?utf-8?B?TWpFalpDT25heDVDOWJGTHJDRm8yWkEwNXhjek5oeEdIam5ybTlodmFnY0FI?=
 =?utf-8?B?Ump5ZXJsVk9qVjdJVmNuUE5aWWhiWVoxVFBhdlJsMHpmdzVwZUtsWmNXVExq?=
 =?utf-8?B?RmN1a2EyKyttU0FWazkxb0xiZGx4M0RJRDZTTW5HTmdES2sraE9xTGR0QWRh?=
 =?utf-8?B?cnhVaDVYdVk2WEYwUmp0UlNDYS9ubzFXM1hHSFVLYnRsN1VhZHUweTF0SUF6?=
 =?utf-8?B?RjhPaVFra1ZSVkUwN1BGZzd4Q3FxL2MvQTFTMTZNTlNybjJVbk1Ceml1a0Fw?=
 =?utf-8?B?OTJSdEptSi9lSHl1L0o2SGdkNkJrcHdjQWxMN0pVVEVoWWZWbDJQR0tHOGVY?=
 =?utf-8?B?T0k3Q3UvWGhWZ1pOV2QrN3Zjdmh6K0hmOFFUeG4ySUpNVlcxZFZPVm1HZTQz?=
 =?utf-8?B?RjVIUWhteVZqQWIyYm1wTk9wY1h1NUJtWW45ZU1vRFI2WEZiMXlJN3JGMHor?=
 =?utf-8?B?QWdOblVZUmR1R1JySGo0Qlc2aHZzNlhVNXZHTS93azl3cm10a29IMldDaUhO?=
 =?utf-8?B?YUhkWm1tWXczcFFJNW9LZkE2bENkK21rc0tDV3J4SEdpTDNZTUpzQXFObTFt?=
 =?utf-8?B?RE00bFRLbDR1QXBqMG85RkZUbndWbXgzS3VWa0tHaHBqNTN1amQxSWJQN3dl?=
 =?utf-8?B?MFk5TkpNWks4dTBjUitOV2gyZ2I5TWs5QW1jdkFzanRQQ1B0aUo3Zks3TDVX?=
 =?utf-8?B?RmZ5V090RnluTmdUMmtaQm4yR05Jd1JQSHMwUE5DWnVhckNCRjFmM0NwZnpq?=
 =?utf-8?B?QWh5cnJUM04wVW82ZnhqeVBEb284NnVRY2JoU2d1bVdrc3JhZnduY2Z0RVJV?=
 =?utf-8?B?K3VnOTdTU2FnWU1ucnZyanZHaWJnYWRjaUYwbnJTcG9XRXFmaXU0WWxMaVp6?=
 =?utf-8?B?MHFiNTJIUEU2TkZFQzd4TGpIeHNMQjJmYTFteTBpTGVwcW5zN2wrY0hJY2Nz?=
 =?utf-8?B?RkhjZmdyQ29uVHBrK0dmWlgyY3oycUpIcFBTV2tuZnZqMnR3RVJEaDRmWDhV?=
 =?utf-8?B?QzdCSXJWelhsSFpwYjdUczZMUXdXVHpzQmJxVUNEdnNMQkhEMXRrRG5vb2VG?=
 =?utf-8?B?RGlsakFab2V6d0dXTzBicmhwZWc0bTYycmhhVXlrb3JTdjY2TDBtOWZ4KzZ4?=
 =?utf-8?B?QTNnV3kyMGFHeU5iZTFMLzltRmNVZGVKd1h1dXIzY1AvaUE1K05BUnlZbmk3?=
 =?utf-8?B?eThiQUxXalY1NUVPM245ek1aZVcvQThlWlB2TUNrcG9IZzRQVzhQaDROTTR5?=
 =?utf-8?B?UVlKSGlXRTNNNDg0QUdJa0tqYk93KzM3TUFIbnQ4ZC9QSWJYOCtjNTNuZXBG?=
 =?utf-8?Q?ipNBYfIGutjpPGuUOoI/Cyw30OdWbMzSYl7zybcrNw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 195fc74a-5198-412f-43eb-08da03b4ba5c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 23:13:18.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaxjYoDbW08mo1NI7AGBMOXYwF9C56K2zSRAFHEm4BiNYE3dysMi+ad39342YmTg3QyK15Znm+2fg7A6ptB5gXgPwCVRAkgt3AoHYv1fHY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1512
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 3/10/2022 11:21 PM, Shaopeng Tan wrote:
> In kselftest framework, if a sub test can not run by some reasons,
> the test result should be marked as SKIP rather than FAIL.
> Return KSFT_SKIP(4) instead of KSFT_FAIL(1) if resctrl_tests is not run
> as root or it is run on a test environment which does not support resctrl.
> 
>  - ksft_exit_fail_msg(): returns KSFT_FAIL(1)
>  - ksft_exit_skip(): returns KSFT_SKIP(4)
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 973f09a66e1e..a44afb05b848 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -205,7 +205,7 @@ int main(int argc, char **argv)
>  	 * 2. We execute perf commands
>  	 */
>  	if (geteuid() != 0)
> -		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
> +		return ksft_exit_skip("Not running as root. Skipping...\n");
>  
>  	/* Detect AMD vendor */
>  	detect_amd();
> @@ -235,7 +235,7 @@ int main(int argc, char **argv)
>  	sprintf(bm_type, "fill_buf");
>  
>  	if (!check_resctrlfs_support())
> -		return ksft_exit_fail_msg("resctrl FS does not exist\n");
> +		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL and PROC_CPU_RESCTRL config options.\n");

The resctrl tests do not depend on or exercise the code enabled when PROC_CPU_RESCTRL
is set so there is no need to require users to enable it. It (PROC_CPU_RESCTRL) is
automatically selected anyway if PROC_FS is enabled.

An explicit check for the existence of /proc/{pid}/cpu_resctrl_groups would be
required if somebody ever does add a resctrl test to exercise the code enabled
by that config. There is no need to require that setting now.

Thus could just be "resctrl FS does not exist. Enable X86_CPU_RESCTRL config option."

>  
>  	filter_dmesg();
>  

Reinette
