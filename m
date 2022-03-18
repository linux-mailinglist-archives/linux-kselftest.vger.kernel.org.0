Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A294DE313
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 21:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbiCRVAY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbiCRVAX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 17:00:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3141B2565;
        Fri, 18 Mar 2022 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647637144; x=1679173144;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ysALJIfwZ1u99K1NhGrtnCt4FJS0XDAnkFdZ+kSnApQ=;
  b=cPtd0qq1SwQEj5YxppwrH6A1yaLl9Nh5OYt47DKU8Vb4Ay6vMVhtsWoP
   yy++TD2tfXdSriEWhMAOWYw9YMljIfrPNIPCsj8+akUHmN5u3Z+4QsS9X
   P09Q2tEGbPLHCwnWYOzVEa+om/VYEISYInJ0dfHWL9JPP5BBjP9UJFrW4
   EXBtt0wSkeBFVmJ/s87Sq8FVSh+QMd7HDcnifmPDjOEww2hnDctcaw+i4
   /pkUVnj4YFF+OW1MlHPvr1pVJ3PTwb6m0nTB7e15oEPz2oXnzAlo6wpMQ
   uMmo3kKIQGYd54BLoR/h2BYcFweyNhm8wbr5CS+pRkwtbIeEYc6aQStl/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="239383746"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="239383746"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 13:59:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="514079515"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 18 Mar 2022 13:59:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 13:59:03 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 13:59:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 18 Mar 2022 13:59:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 18 Mar 2022 13:59:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPU0Zh4m2S8EZVwMYP7wZpR2ecFT5qsKMu7i+6X8/mQCvNqiI0k7LBRVIR7rWNq9Rv5Da7FisN9i4/G7c9bux/TRl7YQ1e0FJ3F2y2iUn8ICeuQgjc2voCxDBtfOijtg8Sj57eECv65D2KEypKQpkr4jbE+TP6GJaRj4qMCVotYi8w4J/36fav/iJRZFTgcePADUJd8FdXd4HFMfyMp57wdvDcsP0Rsa9oBRJM8fHbLFrr6kOZ/rlGWtIkKPB/KaG99SXxAcrZjPzE9vBMnDFmrr0XNwAr+Yrlr9CTT3ZdL0XNeq2MTYo1FuJmU+EeCzHiLbOH/v1BwfH+xIernBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28nm92pzXjx0VBSC+cikKAAY7n0loTUj/sYBlqZlq+o=;
 b=l3w7J7WltQXZCvBnOZhDEAKpPdhC25vsfSSjSM8lTQ8ZAkHSRMjzu5+iWk46v8WH9t023E1RRem3NcmOF+14CJaVx7L3Oye2hKwB8GAaN/oIskawFA8Ipolpe7utN89nPEEU+sObwjZzBrKQN7HvTb8V5OyraaRCzaSeDXUohd+E0lWHz0lonLOE+SGyOJ2+iTPOQazPHnSS6m3fSDr2oh8KJdte8BxMsMG9QLnJCDEI8DZCfNOUvKKd4L5liKY2I9a/EGUd98uowIbMsN0sNND6tgr9ZlJr6OJ9zlAYqhYH31LFiqGJZAneeuWgxB0eDuh4HiS8/wVrdqx0JyNdkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CY4PR11MB1558.namprd11.prod.outlook.com (2603:10b6:910:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 20:58:57 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 20:58:57 +0000
Message-ID: <2c030a61-1847-52e8-ab68-dee5b6e4d7bd@intel.com>
Date:   Fri, 18 Mar 2022 13:58:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v6 3/6] selftests/resctrl: Fix resctrl_tests' return code
 to work with selftest framework
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Shuah Khan" <skhan@linuxfoundation.org>
References: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
 <20220318075807.2921063-4-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220318075807.2921063-4-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:104:5::24) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 340f84fd-1228-4966-b93a-08da09221e78
X-MS-TrafficTypeDiagnostic: CY4PR11MB1558:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB155867842AFDBB56E951CE78F8139@CY4PR11MB1558.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K0BZFd/3Y02GHTctrt0USgR0eg54CJ1TyoroH8XKcjngalxqFzATNPpp3wsGWrVyDaZjHxaqWsWjrAXdAtSRpf6Hvg1yUPRimqE8y2gWWCPPPt3nDLbeyhfLs3h6kce0rxrdjZ92hoNEkspOlkBOT5CBew9PhShhfpI2S0JxnmhCMHli6qKf7zQ11fRDt+p8IHqNujQz8SOVG+qu3pFCsgRPZr8xqag4WOzUlVN3BAr3zcVZAJhm8+7ApEEh4h6h70wfS/zq+n/MxZTevgAvgrb8qnV5rXw9E54pXbaahLOHixixKw5RB+mlftoDZgUOLGsoHSJFeO8TSxTRwyzsoCAUcVkBipsXZqX6R6Bbsr798pnbCtlpxRluOGn03rGtHZCemC+oquhwdx+XPXaSPuMR1AmdVWnyukDfomDyjPf0BnzUtEvmzo/f/WVHl+sdvQwTZj06NyIu+y+wFA/6QQj3mDcxJQupp9sHWKesOyzT/zUS2kBo4fGXbSSKfvRO8dVtIs0jnUESE2HBSCw95VNlaZc7QznHyPWUkLCKfCNVVTv8iDAIuzWahhXjozKwoAzR/wp32186REP3BFREhUMiwZz4+OPrMiiPdIj/+k/7nN1UT4Nocw5+TAnzlDfBuWYOJu8I2gFyiGP0NQuYqJnlI89M8VlkZY5Wj/DCCtPoDlckdeDRKpYnd4lHuB3jPVKe4W99SNOVu6EaOYz7ntTt+PhPXyIcTEd5FtF4tPDWmWWzj/B1f1MVlkuYPfIE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(26005)(316002)(2616005)(6666004)(8936002)(2906002)(86362001)(6506007)(110136005)(31696002)(6512007)(53546011)(66946007)(66476007)(66556008)(4326008)(8676002)(6486002)(83380400001)(38100700002)(44832011)(5660300002)(36756003)(31686004)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVFUaUsrYjZ3LzlEdFlGRFMyeGZWc1lIL2J6Q2lxSXh4VHFQWVBjY0t3dUU2?=
 =?utf-8?B?eDNUSWZOL3VjSXNYcnhtNjlFZVpYOGdjQ0lUcmptMUhVekpVYUNnTEtyR21j?=
 =?utf-8?B?QmUyOU9hd2lxVjM2NnM0T0FaTkl5NU1vVmxlOVZFZkI3VkRTaktweENRRUlC?=
 =?utf-8?B?eEQ2TGJqc3MvdXVlTnVwYWlVQzZSa3JraVFrL2c5MEFlcStmVUNCaU51S2Jv?=
 =?utf-8?B?eHZXRDArRXVkWjJRRzBDTjlsMjNNampXN2FXV0FMT1JaWG1IUDZDYWNMMzY1?=
 =?utf-8?B?a2FINWRreTdLRXllakJaTE0vWXZ2TEhqaU51bVFIdThxS2tiQUttVm1rSEFt?=
 =?utf-8?B?SUNKOHpkU2dVMmNPZlV0NUNmRlJtSXpvTnJsNm1kWkdzMjdWOW05Z2RkM2lC?=
 =?utf-8?B?OEhFcWl2QUdXY2R6dGZYT3ZlWGV1VGxjajd0WmlXQWtHbGZPNkdvSUdFVDBa?=
 =?utf-8?B?ekhHNWtjY2pNbmZtazMvUHZJL2VDZTA1aWFRZGlNS1lxV0N0ZXBpTkpRQWJ0?=
 =?utf-8?B?VHJ2bjVhUDFpamZZN3dmeldsYzhTNUtLbWtDSVY3eXhVNm5PZ1hqamNlRUVR?=
 =?utf-8?B?c1M1elYwOWh1c0d3cjU5MlQwT1lJcy96ZmtFcDdCZW9pelZaWFh6RlhpUDVl?=
 =?utf-8?B?ZXdrRFNxeDBHMWtPczFmU2RaRVVhOUl4NFVxN1E5ejVieTJQM3RSZWZVNERP?=
 =?utf-8?B?SkI0SUZNQ1R3NGNYd3NoeDNIS2FmUWxzaHpHSFhkUjZBN0RyUFRNc0hYL0tu?=
 =?utf-8?B?QldlME0wNTFrUytDQ2xXZkljcVFLNTVtcndmTlJsRGpuZmVSMFhmVDBRYmsy?=
 =?utf-8?B?dUFNcEtuRGxUV0lZanJKeUMxWkEwWTUwalpxaSszSlhMNjJwK2FUNVRvKzhM?=
 =?utf-8?B?RnR4QzJMclkwbU1VcVp1bm0zKzhQRUR0MldNL09YaUI4OXBZeTUvUG9YMmhY?=
 =?utf-8?B?dGs2Y0JwWFdLcTAwbENDNk14aHI2NUVxK0lMay9qcVU5elUwTk9lVVk4SVc2?=
 =?utf-8?B?S0RLNHU5U1ZWclRTNU5Na2ZZb1pIMXFPOUtsNkRMT3FiWXB0TDRHbjJqdWJU?=
 =?utf-8?B?QzBHZkZHQkxqMUtXMU0wSW9IZkFRcUV5amdNTll1dkJRaW1lUFVEcGM1ZjlZ?=
 =?utf-8?B?UldSSFpjeUNGMHU3WjZOVEM4YktxSUN4RlJDTDBvbVZOWEtCZDdPejA2RWN6?=
 =?utf-8?B?dXcweXFSZFowNkFTOGFTSmtYb0pvdXRMdDltRGxoY0JHSGJXR21aNHNlcXlr?=
 =?utf-8?B?M3crdm9BbTVwVnVDd2xjNU5NNkpDcTVuRzI4VytvRFQ4U2RRRWhDNElvYkd4?=
 =?utf-8?B?azgvbmJSV0s2V25NejV5ZkxvRWo0cUN1YjJtK3lVSXdVTE1IUGJSb0FTUmVa?=
 =?utf-8?B?Q3JSWXI5QUZtejlzNnFTcWpTV0JzTU1qU3ZpMFBoNHlDaEFnNnJnZjJVc0dX?=
 =?utf-8?B?VnhERkdtTG9hZFpqVnEveVgrVVF6MnJrWjVWS3FLbzdHNnl3L21kNldwTmU4?=
 =?utf-8?B?TmJaQVAyL0F4QXYzdnlWQzRYVUlIc1dDaGVDcytoaGxPUTFGR1Q2ei9YSk82?=
 =?utf-8?B?bHliTVAwa3NUV0g2emlSWERrR0xnTmVRalZJdnB3d3RaQTljaWZWZUNpaDBq?=
 =?utf-8?B?SjEwRENTTUVYWG1oeStkT2xjTzJMWWIwa1lKemJrWjFIeURreGhsZEpLSG0w?=
 =?utf-8?B?WXBKanVxY2twVGIzWXB5YVQ4eG84RlNlSzM1WW9qb25kMkluVVVHY250SzNT?=
 =?utf-8?B?Q0tWYUZTd3RDdE1EbDlCMVMrU1cxRy9pclNNVjRzbmJGcXlvQ2Q0NlJMUmhH?=
 =?utf-8?B?TDcvZ21hSk05VlM0OHpiM2lXVUxNcFRPdjVRaWxVZThhMXFLR2FtcnZKR09s?=
 =?utf-8?B?ODJzby92YWNxZFA5STJpaWRLbm5VRXpQeEFtdVpvM2Z5amlOaCtXc082VFZq?=
 =?utf-8?B?TkVEb3BZa3g3NjhLU1ZIai9LVmNBaStTdVl6VWNXK2JhRFkydENHMFJSdzl3?=
 =?utf-8?B?emhUOHA3NkVBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 340f84fd-1228-4966-b93a-08da09221e78
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 20:58:57.3299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvwNdXKaqEpOOGYAPZkYY/y9pqXW4fuXQrluaKhZvjKU2p/Ycv4A7B+KraTSoYDd/WWSEBt+9MsX4qXw5etecjAlghtjxT3V7dKKCZq0fwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1558
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 3/18/2022 12:58 AM, Shaopeng Tan wrote:
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
> index 973f09a66e1e..ed7e1a995b01 100644
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
> +		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config options.\n");
>  
>  	filter_dmesg();
>  

Almost.

"config options" -> "config option"

With that fixed you can add:
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
