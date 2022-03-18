Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7C4DE227
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 21:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiCRUM4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbiCRUMy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 16:12:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB8324223E;
        Fri, 18 Mar 2022 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647634295; x=1679170295;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gGm/Z6CK3dw5pgWjnr7CvslkX3M0E7U5rVypvYuWTgM=;
  b=litq5g2bE2JQnO7T2EjP0ruRRlYdwF4SZl4aVAcjBIYsvdRfeAHoHTWC
   WoSkpsV+kPjP4U1at0Goc5oGM31nQKSkyBRPZSaN2sKYlcfNZTNqI3lik
   sb4f1tDFP787kOLVyv8gGqQTDm/B2I+zQaGqRgrLfNfURdIY7ucTzGC3Q
   7/N9MBf9f82ayibGsHUUh7Cxs7p635QxjFcPIbCnGmG+Op4KWGDTR1+nu
   6UZYai5x5UR4JoZJlBQnwDNIMP538BMISb2PIh6Me9ZZHmrzwuXffxH1U
   ac6/C25a9+0BrdOQCZoEaopzWUgbVZ2dVLgcPTjrRti+eOH/DUkaAR0NA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="282027562"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="282027562"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 13:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="558625791"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2022 13:11:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 13:11:33 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 13:11:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 18 Mar 2022 13:11:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 18 Mar 2022 13:11:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaVZo2UBIM8qCOeegSFh0fSlJ5+toGFJbV8ZvbatxAffhghkJX+YucPwxAWMuoCxEukSlrdxvb8RNoRQ53keeE2O8oUWXus0OfWmyP4vtUbThlzIkxOQBx8acbYm3hnjPCXzzG495cTX8ICDHNQq3emNBhWxyNr78rCaOVfwiYQZ/qTwD0K/l7uqijbvdtROMZ6JcrysNAA8SxyEy1f73Qqi/osz0pIK5NDXQu3RcFMwdsoFa1Igbag9pUk4PjJKKxNtoJRcBczHrkNZnUN4Ct2O3/a1Bd93FCWSaL4i0U3bx2weyqs49MbkfoCvTIGchISjRfCCcE97LEbq9LV8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7f392YV5ql2RP5BT7LrFYPiLa1ICDVljDtu68eCEQs=;
 b=M7ZKX8zLNr73y+HIsV5R+LG8c/0K6RXo7/+MAvlw8v4jw1dv8DVO6wDuC1WvCMq5kL1iBhq8ETLgo357HK81sFMtHodc4qAGY4vwBcjCOk8QIpT649P/yaqv1W/brV6G80Dk319yHjvv9aEE6ZRs7kiFcBIYUFwkKTQsXUW0TXEws80sbArW6OU+UXq131FjEwM32wphmFhBTlV8gFWfpaEPie53HX35aPAbkC8sgCmZoHud342W175T+IbKl8iyCnDTJh226xk9DS32481UCd9YUbK5GhW93eTKO5X3EJIVRpAKxpBgLpFQkMAaMd6tYu45QU0LeijaIjc80W+Dlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 20:11:31 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 20:11:31 +0000
Message-ID: <0f5f9bd7-fdfe-ec10-071c-a75f981ff317@intel.com>
Date:   Fri, 18 Mar 2022 13:11:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/2] selftests/resctrl: Print a message if the result
 of MBM&CMT tests is failed on Intel cpu
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220316055940.292550-1-tan.shaopeng@jp.fujitsu.com>
 <20220316055940.292550-3-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220316055940.292550-3-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:104:1::22) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8f0a147-d83b-4f8d-51b1-08da091b7e33
X-MS-TrafficTypeDiagnostic: BN6PR11MB3985:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB3985BF6298A5978388CAE01FF8139@BN6PR11MB3985.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNymu7Emj38Url6sQPPBqR1b77r8/SO7UJKvZ+fPr+siUFjH8e+pR5ashNRTsIzI9/JQ+xyrmN4Kh7CaLWMklQs5kdltsGMvph+1OadDiue9aq0USYkx9GAyAl3iB0hh5C3taShPmc8U1hBVvexXGyxJtAgBpx85wzWlTLE5ykpdcacQ0wNAkPqh4sXjsiEqs6YH8wBlLnKfY97lu/mcIpdInq1xspxnIErTs788Dn5cQhM5bsAu9RDdXE93LAy2t7NCiJzzGvWqQFgNagF+BemC8n0k+xv+uJ3NDNoRibIfZJlbZs7stFDVahLH+TDHBMvLULMZzEPUYDAqijmh3QlZPYKCD0GTDv1f8CISXMkcbMLNNR5XYrVFu6UUoc+0Yp6eIFVNa2fm0b6Oyj8VJnuJeMRDQb8qHbGB0u+2JAEC4T1ylB6kj5rcP+rKLEITm9X5HsJBthibaRE527+u6aq8tGNC1do6nB6PwEPZ40IsUtxzlktrjxpK4RyAn/KHyt6MtuokiP+h9FGKMSU+QnTrLYrw46CKYKiRrbW+bOP2AB+NbMJw8G8php4T7ol0VvSgxkPcG6DwD9FWFPP/swqCAF1Z+VwW9TxHSwC6Vweq3HEIz70kRZnIbdeMsU6l1awfbvz6HI6ILTdXn38VQrHss8EtWLVF7B2zO/Ga9HtpPQ4tddEqxSd/4bIPkMsNe6FKHcYwTyLP1u8uiY3eX4MxWPa1huafA5HK6GnT9mGsqsjvP3MR5UM5jZcv5v+I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(2616005)(83380400001)(6666004)(6512007)(6506007)(36756003)(53546011)(508600001)(6486002)(66476007)(316002)(8676002)(66556008)(44832011)(86362001)(31696002)(15650500001)(2906002)(31686004)(82960400001)(8936002)(38100700002)(66946007)(4326008)(110136005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVVET2Y1elZ3QWR6bXNBNENQYWd4QkxpYjlVS0EvZ0JLN0pZSkZWWEN0Wlpm?=
 =?utf-8?B?RTNPTWVTMkZSZDJHSzRaQnJPOVFJRTJSRWhTVGJ3a0JOZGNIazhERVdwZUZ6?=
 =?utf-8?B?b3ZKaVVUOFI3RlA1d1Q4VmtZS1dBWGQ2d3kvY0k1OEp4UXdETytEdkxnTWhJ?=
 =?utf-8?B?czNvVnBWNmp3U1NPdVByMzFTdmFpbUF2b1grS3doSDdsci9sN1NRQldKOElM?=
 =?utf-8?B?SVF0ODZiTHhIVHVUM09DQkdYVkNkVE5HREhOYmNqMloxR1c3dDhKMTdrdWNT?=
 =?utf-8?B?bFNqbXZvUklKbzRkSjZUTFlDb2pkUk9pZ2szTmRjbmVkdlQwTVNEVkQ1bW01?=
 =?utf-8?B?Nkp5U2QzTE9xWlE5eHIvMERKbkNVUWNpdFp1NTd6UEtyVmsyL3pTSEdDK1Nk?=
 =?utf-8?B?N1dUa3pNdTAvcGVSaTlJa3BTanhMQnA4dkNZSGxsS1BOSU5aaUVrajBxUmhL?=
 =?utf-8?B?K3NmRXRsUWRyWTFVQy9rQVYvSWo5azZURnArL01LK2NBTFprc01wL2R5dDNY?=
 =?utf-8?B?QVd2UDNJa21XbTN2OHZmKytFbGFydXY3bFJSMERoVlRCellKSnJYMGxzRTkx?=
 =?utf-8?B?L0w2UzBKVWQyRjVpcWgvZ2JJaDRUVjJKVDZjb3RzQTdvTzJHbzRJQ1lKb29n?=
 =?utf-8?B?SWZidjVvcUJhcm9oRm5vZTRwdFlDMXdYMGdzQ3VGYmdNZStianRYMUZqQUc3?=
 =?utf-8?B?VHlySFRrc3J0dW1STklxZS9ZRkVhMStFWnBqVHE4bEczVkVhOTF6UEdNK2hB?=
 =?utf-8?B?U0wzbldKOTc0QURweFJVWWszWkJWMVRQQlNTV1Q3dzRadSt3VXpRNDVMM3da?=
 =?utf-8?B?bkZMR2dndW9paEtjY1Y5QnZxb3AyS1UyZXpoaUFNbm9DOFh1QzY5ZWFIVmdk?=
 =?utf-8?B?Y1BzWjRuRlNyUnRFYUdpaGQ1cXdkdHRoNy9IZ0YrclFxWVRTeGVLMjJidTF4?=
 =?utf-8?B?WGVYK1F0WFdSRnlxdzFLNUtGNWNQTHBFRmM5THRRZVF6bEVtZXhwZVBKazV1?=
 =?utf-8?B?NnBmVHRnaDJzdFExS29iV3g4TEVhRlpLOVFVYXluL0lXazI0cXZYdXh1SldQ?=
 =?utf-8?B?RVZQazVlc3hSS0lGT3dyZEV2djllWG1GbVVLNGpPVy9UNHpacHVNa2xZT1Vv?=
 =?utf-8?B?YlhRZDVyamZVZXpRY0R6bU5aMXNSZTBKbEVuQ25VZHpaZ2lkd3ZEWVJWRDJa?=
 =?utf-8?B?Q0JMZ3JiTFdyQzVtTjRSMjJrMlVvdDRuTVdsRXFacStVZW11Wnl6aDBha1hv?=
 =?utf-8?B?c1QwVURXYzZSRU84Mi9DRU94bEtnMjRZUUdkbCtnRDdScnc4anpMZmhrZ0Nn?=
 =?utf-8?B?dWU1L3JSS1F1eUVoMkZOQldxbDFXMEhPRWEwWXhuQU5ZMU40R2puVFpDTEV3?=
 =?utf-8?B?RHdFQUVieE00SlFUOXVySkk4UkJ1djNVdUFQcnpMK2FFVjBQY0ltdGpocFdM?=
 =?utf-8?B?YmtsR25MeUtzTGhkVEFlaEJTbTFUdFFmOUNlUFQ1SXZmM3ZQNDlNU0VSWU1T?=
 =?utf-8?B?UDFxZUIrV3ExZHZrdnZYNEJGOEZXaHhqa2hqVC9EVGFRRUgyZnU1TEVSTHVo?=
 =?utf-8?B?Vk1DbE9hdm8yMjV2cnRGVnNUQTJFU25kOGFCbWVUc2pWOC9GbnVzQlBJbDha?=
 =?utf-8?B?a2RXRWNFMkYyZk1la2FLZ1hYSkxYY01ESmR5eE10cFg5S1AyZzg5RnVpMUlO?=
 =?utf-8?B?VkQ0K3FvZGRsbktYWW1kaTlDMHBmRFB4ajMyYWcxcDRza2RLb1lzOHVhanI1?=
 =?utf-8?B?YlNOTUduOXhKQWZZc1lUeFlGc29LZldzV3pRdDdwTUw4dHAxQnFmdGhuMnlS?=
 =?utf-8?B?b3VQNGtCdm5KejZZNjhDcFQxc09MT3JScXdHbEY5Y0JHVlNsUE5QTjJYSXdD?=
 =?utf-8?B?ZlRPVUFXTy9vcmJObVMrYXRKMjJBQmx6dmszeVdwQU1xU1IxL0hCdVViaEZS?=
 =?utf-8?B?dUlSMlk0MytkRm5nb08xcEQxRThOZkk5RlhGeU9rY2ZXOU4xL2RGdWJwR0sz?=
 =?utf-8?B?K09XWDJMZWlRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f0a147-d83b-4f8d-51b1-08da091b7e33
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 20:11:31.4436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQR+opczXJgxDgobwa15BHBL9SnRBLzJ2xMzLpTJFeS7QqZhAmq+gQv7XWIjiznQwgTRNmRdIFkIjzayu9jgSBuoRVkkGnd06SzQ6W0BWAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3985
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan, 

Please use capitalization for CPU (in subject).

On 3/15/2022 10:59 PM, Shaopeng Tan wrote:
> According to "Intel Resource Director Technology (Intel RDT) on
> 2nd Generation Intel Xeon Scalable Processors Reference Manual",
> When the Intel Sub-NUMA Clustering(SNC) feature is enabled,
> Intel CMT and MBM counters may not be accurate.
> 
> However, there does not seem to be an architectural way to detect
> if SNC is enabled.
> 
> If the result of MBM&CMT test fails on Intel CPU,
> print a message to let users know a possible cause of failure.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index dc548d3e2454..97ad6cfee6ee 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -86,6 +86,8 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
>  		sprintf(benchmark_cmd[5], "%s", MBA_STR);
>  	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
>  	ksft_test_result(!res, "MBM: bw change\n");
> +	if ((get_vendor() == ARCH_INTEL) && res)
> +		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
>  	mbm_test_cleanup();
>  }
>  
> @@ -122,6 +124,8 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
>  		sprintf(benchmark_cmd[5], "%s", CMT_STR);
>  	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
>  	ksft_test_result(!res, "CMT: test\n");
> +	if ((get_vendor() == ARCH_INTEL) && res)
> +		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
>  	cmt_test_cleanup();
>  }
>  

Thank you very much for adding this.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
