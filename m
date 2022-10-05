Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2875F5B42
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 22:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJEU41 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 16:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJEU40 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 16:56:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C04DF2A;
        Wed,  5 Oct 2022 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665003385; x=1696539385;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ll1PYdWZEzhoSu3dWdv14KrHsciMIgzgSLO+ibXO0Co=;
  b=Gsl97hVVxqvgnNbCWzsLtY+rEKF/sU6aWj5MrZsX/pBW7wiqlmc5nTwP
   rx4SElrrCRzJknbZfQiFupXNr+I3bmFQHvhemeNZmRAnZ6Ix8Llsy1Ykg
   ocMh+9FOAs44GKiiYshIyjgA0Hzp/q2XENXwhe5TKOjBWufNgoz1E+bU8
   BcrPSI2nzAgR4rkvZPeE6+dQ4bxdDfEy6L4m0iLPFXlV9HRe2l0nl8OC1
   VpyiQe7Uanl7VqxFFZByRN4PvtHR1iGz6q3lf5KHAgQU4U4Pp2yX6AOGw
   0cYWgZbQzT7nV3gAfPJaTxNP/Khay3zT6lgK6K5a6dLz2b/XruLSeNTiY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="282984567"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="282984567"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 13:56:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="619617535"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="619617535"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 05 Oct 2022 13:56:25 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 13:56:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 5 Oct 2022 13:56:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 5 Oct 2022 13:56:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhuGSnFQvSGH14CBUCUdGB/2mhJrDWOjMd5E6ZbxjpK+w9Cyk0ocgFfpKjL07hV/WnDfk49PuCWcGiLm3krUrdz5ZLf108fPirkB8lHA96WPFcts7BQyqpMoc6OJ532c5bujB7iYUCZykh8hXJmnCrb1P3IUSfJzlNw30JMFa4/Q1Rnh4bNmTdusJPvXjXd4LyCg4JuDTd0ifw2QjnFSbbNRTKSAAXcyD+0E/sg/TDRE5uTLwRgfSw2s7nRCIHkM+z+f+pRpJ+r8t/y+vJObCd+3K4knrGVsPuElYpaNAN61UT0PE1mSsbHGLvreEVJ4KjUh3cvAuXJVb8WqEy+Hog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsB9IZFWFmAHgUbmpoOfS3v7/wAq5aXMGdf1ifaJAwQ=;
 b=NyLojfigdH7AQ9bJHzSUpjk7tmfddqqjvPxD1t0qbz3NXZEs4On+sf9WhC2/whIvkZfDEaOPvyfM86Khg3LSm4CAJDyXsb+7Eb7aGY9DjWv+HZZ8FDS9pZ2hm8xXjJmH8HWEaZAIscgd9lBWosiw0y+S5BHhXNS67GfBoI0tyYnQgXAsHD26n1ff1htfNvBkWA/chP2jX+HLEB46uL5beXKoFiRkQb6Xnzc4Ju45gdaw2TzkbOHvSZILATgPDzJ6Y4B7Pq7yBJNAzAp3OUbqkFPKBzkNVYEjsMQOyDAP9/rop4uRk26K4c85FQrsCGBXtBqoUTSfc3mIMEQX1aOG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB5988.namprd11.prod.outlook.com (2603:10b6:208:373::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 20:56:23 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.033; Wed, 5 Oct 2022
 20:56:23 +0000
Message-ID: <10ca9b73-b3e1-4139-6cbf-c362467c7943@intel.com>
Date:   Wed, 5 Oct 2022 13:56:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/4] selftests/resctrl: Fix set up shemata with 100%
 allocation on first run in MBM test.
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20221005013933.1486054-1-tan.shaopeng@jp.fujitsu.com>
 <20221005013933.1486054-2-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221005013933.1486054-2-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cdf47eb-2461-4233-b066-08daa7140fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4bNuR1fl0aiPhXoBWNJyDEUyAnc+ZiV28CpFJ1Ghe3qhDAg+nLrwDIHe/58age+EKe2kbdjre6CW/Yc6yElvZOu8PxueUzAOc0VWWzh34FMKeq0XXn1uf2h125QKVwwUIc2DQwojJ/VZdjIwolABqPuLWhqRRKQ3lpPgWPSmhi5HlQzm6SKAxI3ykiaPmOO//a2/FaSfSEDccKQ7ow8mbRMdGp9tFesX0bZDE//lhXEGkL5ToyY594tRrFnUqYq0rhuC2n2dmQf3WUd2q2xwpCDQNQXIAstgyHeZuvvV8EABZ3zofoalyr8I/rz7DfeXusU3HHiLFAYlgjgZUyCPgAvLiYBEOnk6k3pQqlrM58wOwbOIVtvw+M6M1v/lCU/FT1K/cVvJ5yE1Au1zjH4c2dVkErkPHg50jtd4vxavxSBD2ypY6EOvV0oaNCD4OEM3Z6iKXBhlWmLM44yhgTuyxIXzi9lbCBc5ph91Rp6BkXgUZf9CAO9fiwUBI9jsLtqidVOgWyZZy+rHeR3JAwSKBWheeiRM6l4Xw1pnHVcqkMGht0UT9iy0oqWQHgYZJZ5hBhy0glC/EBwiDaTdDXSx/OK3XIbag22aQUWZda9oJI0ud4hKQGl9S7BsHeZMtcwzye5tDRX5xL6+K7V2tkSFuO0fUJQsJllrS0Zjd+L2VbPzh6Pv4/21aPKGLCxzog4XhY8apdJeAoozD0q/K9LBNKF10uMgddEW5xqKaZ5K244DYN7JiLqfxV6vdQAepZZbmF9yAN6xxH+0GJCwRj0VlXPd7Fcg6jmiEjWk3/cj2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(26005)(2906002)(186003)(83380400001)(82960400001)(38100700002)(66946007)(66556008)(4326008)(8676002)(66476007)(316002)(44832011)(41300700001)(8936002)(5660300002)(53546011)(6506007)(110136005)(6512007)(478600001)(6486002)(2616005)(31686004)(31696002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWlVZ1dpYlBuSlVmQy95U1RqQzFSbU1iVVdYekxHeFRtRXRUZXR0S3FKWGdZ?=
 =?utf-8?B?U1dtWmo0TFNJcDExNFQ2Z2pLZk5qczJ4bjBpQ0F6VktvNGdmSVZKYmxuc1lH?=
 =?utf-8?B?Sk5zdGhIZC81dElSVnJRUFE4KzNudEx5bnpGemgyaTFmamRKMU1VN2NMbnpE?=
 =?utf-8?B?UkVoYnZkOThPZDZsM0UrTy8rQjVxWXduOFc3a0k4ZlIzOVdoVGRTTEFkVDVl?=
 =?utf-8?B?OFlOazNyL2paTGJGNEZubG5HLy9aUy8zd1lJa1BXN2xwMllKUnVCZzMyNzJJ?=
 =?utf-8?B?SFN5dzcyT2h2Y09lNjhsZDhITEMxdXVzNkpOZHVJR1l0dk9EUVo2dmNaMWlM?=
 =?utf-8?B?bGVDVXZtSHJmODRPYUFRZEdXMHVSaVFCeldyWEpnbmkzYTlBK2IyOVJlZjJk?=
 =?utf-8?B?VUNRcml2SE0yVGdjR1RPVmI5Zk8vUGhYZm12cnh4TGxGMG0yajhxNkZVY2JQ?=
 =?utf-8?B?eGo1aHQvSmFIYjdPWFJjcm1kZDNjbkpKdkwxczFlaStTdGRhUEMrM1NjY0dy?=
 =?utf-8?B?TEZoVWZrb0Vrd0NYZUpqZXBtclllSEkrMjhQdzhQTnE5RWhwaXF6VlVjNExY?=
 =?utf-8?B?ZE5BY3VpT05LYnBJV3RmNUVYaGNyVGdDbmZSTEs4NHRjenhMUGhzS3JyYjdV?=
 =?utf-8?B?N3dHRTdNdFJkdysxL0RaMnQrS2FBa3lFWmhXRlh0YjhPWExKdmJvN0NBQVh5?=
 =?utf-8?B?WHlWeTZnMjk4RG02MnE1dVNKQlo3b3VOaUdIdStnWWw1NlhYVkVDM2s4ZVpL?=
 =?utf-8?B?L2l4cHI0UTBOQ21QdXF6bzg2L09aaXQ0cEh5N0pPMVM4RzFId3JXQVI4Wkh1?=
 =?utf-8?B?V3Nzbzl5eUhsbWdOOFNVYmVERFlqbTIvbTdOUy80U0ZlbjJTZzU0amtvcEtt?=
 =?utf-8?B?b25WZ3dPd3FuS0MvKzVGV0hOOXRYUXJNc1FSUld4TGdFTG9uN2RvVEJqZU9C?=
 =?utf-8?B?WUd5QVhQVEplUFNLb1EyMUI2RU1QNGorWUQ0YWkzdXRjVmpuUzBSVW9kMFVP?=
 =?utf-8?B?bXB3S0lhclhKZk1kenlvSGdiY0RSR2VIUnhTdG9oMnduVkZ1L2ZCdzJVdm9u?=
 =?utf-8?B?cllJWmZEWE9vcHA2Nm50alhTOWd6R0FHWHl6TXNwVS9DU2JnQThTTTc5ZlJS?=
 =?utf-8?B?UE1BbjhuU0F5LzVtczhVVWNCais2T3RxUVBhb1M5U3hXMEcxaWlITVRtSEFa?=
 =?utf-8?B?TkwvazVrNjFFbWlyRTZmWWY2Nm5sNnRMeFFTRmtIYjlkdXJia2s2T0NoSE5T?=
 =?utf-8?B?cWg4WjlpNUpoSDBrUlMvdXNUOGxFQUEyUDlWMGxnanltOWY1ZE9HdXFUUSt0?=
 =?utf-8?B?clJLOHlqTUxCVFRmOUhzdkJNUGowZjdNVWJ3bktOc09iSE0xNTNSQXdZQlA5?=
 =?utf-8?B?S2hMTzh5OXErUy92MCswTmNwQnZqS096bUdxNkx6Tk1UcWJGNGpERkhpVlRP?=
 =?utf-8?B?U0ZtQjMyUjJNNmRyMnQ2VUhmRlYyVGYvL1ZMRGhTdlN4Mi8yejdnRDlueGlP?=
 =?utf-8?B?UGdNM0Q5Ry9Oa2o0TStGMDNKYjFqQW5iUTNBWm5kckJHLzE5c21ZMmF6SVBW?=
 =?utf-8?B?eGpQZVBrVkhSU3Q0THI5NS9SZFZUd1V4anpyQk9CeERySlptblhQaWovUGhh?=
 =?utf-8?B?REJUdU5QZFllOS90UFdGU0xmTGY1RE4zZUs2RW9LdzFrbmlMWGRIb0R4KzFQ?=
 =?utf-8?B?OURTZEF3ZEUzSzJFNTNPUGlscHYyNGZqak5ON2NRL1dDSXc0Umlzc1RCUmtS?=
 =?utf-8?B?WFNJT0pEcTh4L3dhQ0g0VUNnYVpVM09FenlRampBcnlTbGJ6MGdzc2drUkZ3?=
 =?utf-8?B?d1U3YnBWekMxVmhpeGxrdVFMbGhOeUxwR1FMbFZEZWRibnUxVFRkQkE5N0J4?=
 =?utf-8?B?Z3l5RGRwYThOdVF5NDFOWkFkV2pFb1VBRVA1OTRPMmJnVlhYRnphMlh2QWhh?=
 =?utf-8?B?SytIdC9YQXJTaW1ZTnVVTEtmSDZnQjBuc29lZklpVTBNc0p4K2h2YWlIL2dU?=
 =?utf-8?B?MXRwZVJFOStKU1VjaDI3L2RpTE9jY2Q3K0lkWURMMXlSMnMxTUtxVjVIL3JL?=
 =?utf-8?B?dW9uL0RJcUI3eTV3U0hqQUNidFVLZ0U4YzFZYno1bmxwRmovSE40bmhmVU5L?=
 =?utf-8?B?cmxhaGQzSmhEVjlpM3FiZjNZcUhxTGFSVjA5eHdueFF3bGpLaE9QL3NOeC9w?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdf47eb-2461-4233-b066-08daa7140fba
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 20:56:23.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uye5YFayBJE/xvQgjemD9ovBXtX0Hqxp4kr24J/w5YlOPUt4kc8PCXL22TUshzcwDdD57mhzpb/xBng4QIHPwjjST8gFDjf4aZULUFJOSC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

I understand there is a typo in the code you are modifying but I do not think
that justifies the same typo in the subject: shemata -> schemata

On 10/4/2022 6:39 PM, Shaopeng Tan wrote:
> There is a comment "Set up shemata with 100% allocation on the first run"
> in function mbm_setup(), but there is an increment bug and the condition
> "num_of_runs == 0" will never be met and write_schemata() will never be
> called to set schemata to 100%. This is currently fine because
> resctl_val_parm->num_resctrlfs is always 1 and umount/mount will be run

resctl_val_parm -> resctrl_val_param
num_resctrlfs -> mum_resctrlfs

> in each test to set the schemata to 100%.
> 
> To make mbm_setup() future code-change proof, fix to call

You could be more specific by indicating that this change will 
support the usage when the test does not unmount/remount resctrl before
the test.

> write-schemata() properly when the function is called for the first time.

write-schemata() -> write_schemata()

> 
> Also, remove static local variable 'num_of_runs' because this is not
> needed as there is resctl_val_param->num_of_runs which should be used

resctl_val_param -> resctrl_val_param

> instead like in cat_setup().

With the move to using a member from the struct I think it would make the
code easier to understand if num_of_runs is explicitly initialized. That is
indeed the norm when looking at the other call sites.

> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/mbm_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 8392e5c55ed0..4a54be314402 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -89,12 +89,11 @@ static int check_results(int span)
>  static int mbm_setup(int num, ...)
>  {
>  	struct resctrl_val_param *p;

p is defined here ...

> -	static int num_of_runs;
>  	va_list param;
>  	int ret = 0;
>  
>  	/* Run NUM_OF_RUNS times */
> -	if (num_of_runs++ >= NUM_OF_RUNS)
> +	if (p->num_of_runs >= NUM_OF_RUNS)

p is used here _before_ it is initialized in the code that follows. 

>  		return -1;
>  
>  	va_start(param, num);
> @@ -102,9 +101,10 @@ static int mbm_setup(int num, ...)
>  	va_end(param);
>  
>  	/* Set up shemata with 100% allocation on the first run. */
> -	if (num_of_runs == 0)
> +	if (p->num_of_runs == 0)
>  		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
>  				     p->resctrl_val);
> +	p->num_of_runs++;
>  
>  	return ret;
>  }

Reinette
