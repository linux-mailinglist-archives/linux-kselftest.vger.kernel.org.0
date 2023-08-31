Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4866678F48F
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbjHaV0w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 17:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbjHaV0v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 17:26:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85F21BF;
        Thu, 31 Aug 2023 14:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693517206; x=1725053206;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XBn7Eb2F+4k/SoF1jqdLRb7vwG/38Tw7qyGp/lY+CnI=;
  b=ikbs+ArRQUxT/SPq72UFpiK7eYlMW5zkYxbnyS66XvGG7Nh+LJ18Tzb7
   dPNJHMaNS/p8lE3frXZF+yGsbkUPUCEHEFcLJFJp2oFpGKcpUsm06oXaV
   8BYZxBS0RRmNwMiSs8EBxO0W0v9pXzMorI2RYMpgdQQfuBUgIkEJ7KKxz
   ZfsNEWTASlRZJaFxIrFfaX8X7xgNzUo69Z3uxjbXl+WhTYLq4RvLwmchy
   +VY+WZ6SfqcAnNnsOh1u2v4sQpPr8pgdTCqmBjh77CV3v9sGr1PjQ6Anc
   oktfWqXFn5iMA/VEeIXpI9O53jrLLLOayzqRtEJjnIw1JqIigojanGgAl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366297192"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="366297192"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 14:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="733286092"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="733286092"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 14:26:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 14:26:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 14:26:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 14:26:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 14:26:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0BUY/O5r0LTmkHJfmBXk6K1JJbZTzjZmKtLdVivAdLkNBnBbwfK94iQDyvwkJ68eRzSJx3YMuHYkxsCUgYQ080AbAW3rCHuv64G+uW7fI1CcSbvt9b25MDkUcJir6hVBPWRxjoilEOnvXIo5nZ1LCu2nMoIVvs+7kMimUXR5NXvHlqdn1afOi6fq9UkiPV82+qfhZpOcU6JoIwCicJsZKS905NGQFqrYdK+/s2hkBW741Dx8XCFLf37jJCp73R+qdEkA9WuCiHbBccYyuWBMe6rjBe3lhRFlLW2uKGQ23leojAsmZtYZbWJHNX3g5MuNSUeGYc3EzV0mUVDhzUngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkqjaBKDokjn7K8KGdklsxAGIN5b+ZydG4WcpfJSSaU=;
 b=UBsn3hJD3jfnHiVLlAfX1zKaFYqTUfdRA/g0G8P9eErtPv+5Ezg4twnPEOULWiweoleYRuWTDgmhH2reHIc8BiTZc1Vnykao2TUwOr64U+GH3PtJA4XPiFPuf1hDd/VlnVo9hX+dEextu4zC0hRhDv9JgYAbbMLG/6GLwatIrePwWjL6lwX8d9QyLK1FTPCO+ez08MWKSGC1bKyPYvbYXKPE/YctGvsAELXAmRNwXLNbN0Qilt75NBF96u/1xCr4EOG0KNRu3V1C5pb4smuiq0XZOywwGuYUYycyEsR62eqDfQEPeXtOHufW3p77pcetEdQ/lGLZM7i0gb1OK63OoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 21:26:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 21:26:23 +0000
Message-ID: <73b4d9d0-76a8-3b60-6d7a-2c115b220868@intel.com>
Date:   Thu, 31 Aug 2023 14:26:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 8/8] selftests/resctrl: Cleanup benchmark argument
 parsing
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230831110843.26719-1-ilpo.jarvinen@linux.intel.com>
 <20230831110843.26719-9-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230831110843.26719-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:303:6b::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 39775fc6-5b5a-4eef-5ac3-08dbaa68ed1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8D8VGnp5IfajnvlRoWkz6jkdfyNlKalYBGePFuxcON+Gx9eAyUNBQdu3abxbJIx/P+p9qDfHtvLtp6pULf/7aNt0fcbp8yP7/WD3xZr+NL25LUpg6l9eLRm/oweQlvPmHKDheaZsbjItI1UPNfIP/ZBOj4JENAnSK6n1SLV3B/hHOUHWRrN/aBaZx8I/tV0tKpzlXvD49UgQbhtKRJ3WFiF1X2cxEBVu2uqsJynl2UU86yjG36ZPIksN0GO9kUbDBg0YSACpLa+zqGsd3tsSGOqYCRNJdOlNZIBbLmDLqWu/yE7Ql4fk8cafKl666NGRu6P2TFEiZKlOP3oCLn+2cTggoYCgOB6tXUbXcrk/P2TY/AViBf2TyX3pHATIn3vIAuvDfIP8K9z7tqQ+SYiSWCVrd5qeJ44M1XfhImGsisk4pFidbaSUKfzryaoXfoQkGd8FpIuBnZ/ebg3f3sr8Sz/9eCJhtv7jXJGTcAkZ5enJmFz3dRDMR1CtZtmlon4vH86p6EcfgxSPdlgxpYprQr6jTDRNZKkmaQ8N7+CCABt64yQwG76l3XDcnDM18AMa2SpmiB7tRnXDq/0r1GIF8rfBIpC6hq9SS8vhKZgiGLhwepCjBxWe+AMwp3zAFwrmmpWBJrI2GIu43sVFbJ+ijQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199024)(1800799009)(186009)(2906002)(5660300002)(86362001)(53546011)(316002)(82960400001)(478600001)(31696002)(2616005)(4326008)(8676002)(31686004)(6506007)(6486002)(44832011)(6512007)(8936002)(26005)(38100700002)(66574015)(41300700001)(36756003)(66946007)(66556008)(66476007)(110136005)(83380400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjlkWUMwMkZUeXgzb3FtMTc4VlJ2czZCWm9XRDFvaWJqVjFiZG5MTVkxbm1T?=
 =?utf-8?B?REJ1N0ZWOGR4alFrVHYyb29TblR4Q1h4eXU1S25YQVFJRFZ0d1RpNTNDZys1?=
 =?utf-8?B?N294bm5qQmdHa1pmU2tYcm1oZGIxRDY0Z08yR1JNSjRXdHVWTTVyOE50eWVH?=
 =?utf-8?B?bURPS1hIdkNxOE1iQ3NiekZjMUZ6SlZ5dWszNzlZVTVkVk53OWQ0akxXZE1p?=
 =?utf-8?B?WlE3akZ0dEhFU2pFWmc3T24vdVhZUHhpT0dhR3VZTk03QkxuOTZXVG5Mc3lq?=
 =?utf-8?B?K2ZkY1Y4dnlTMVUxZWZSQXliYisyK0JIaXgvQlljZGFlaXhTWmxJd2NiZVlq?=
 =?utf-8?B?ejEvWEREcS9Qa3BEVk04K0NnQWtwTU55OEQrZm9vME93L2dtMUUvZWQzcmx0?=
 =?utf-8?B?R1lGT2JDVEdJeGQ2Nms3TTVYOUdLRENhQktIbnNldFNhUzBPbHBsby9OVHlR?=
 =?utf-8?B?Uk02RVhNTFRIT0VHZVU3WERrQnl6d1h3V05TSi91eGJqd1V4VS9hWE9lcXV4?=
 =?utf-8?B?c2VGMXRPakhmNjNGVW41VXhoNE5NRkdTMUJtUzdqbUZwMjVqTGJ0TDVpWVZW?=
 =?utf-8?B?aVFsK05GaTFObUk3VVhsWnV2T2tHSGMzTlNwTDFteGdBTlZTUTZjeDJGZDFO?=
 =?utf-8?B?NVljZXJBSlI1MFIzQVN0cGxQcFpmbEk2UmxaVFJDVlh3V2ZyMVRGMUR6U0M1?=
 =?utf-8?B?YWNDUWF5SjN5UG55Y2UvZ0lHRERPUzFYV0xWdUdaT0lxN055UFRzbUxsR2hB?=
 =?utf-8?B?TE94b0Ryai9SZzdxTTdFbWdhbFdYdEdXYmZkRDhIYkpub2V1dWE5U1kybjFk?=
 =?utf-8?B?aW0xM0E4T2paempNYnc1MXgyeVc3akFldXFMa2Q5R2cxNlA0ZEJycDZqcmpR?=
 =?utf-8?B?a0VhOEJSZC9yckt4NmNHMmtya1hYU3BQK2J2YVFSZnNlMlI0amoxaDd1WWFO?=
 =?utf-8?B?bE9iamg1Mks4MXJnSWh2NytUQzBQRmozU0JLK1ZZZmlQb3FibzhwcGo5UXRo?=
 =?utf-8?B?Z3NqZ3Y3aVFOTkRRNHlBRXhnbitvUGZOYWtyY0VqbFp2b1J0cC91Rm9WL2dD?=
 =?utf-8?B?MU1tdFFLQ00vYXRKN05oRURaQ2Y1d3I2Z2lKVFZTMWJoOThBTmRyM2lqbDlj?=
 =?utf-8?B?WWVaRXhWOHZqS3VDTWh6OWJ2TmxuWXVNZWoyYVZ1c1kzdHg0WElxSHNFdEFK?=
 =?utf-8?B?SGJ5L3ZYUWJ0ckgvZkVPaDUzdkJUQUJFZ2E2SDhVK09SS3paNUw0TDE5eS80?=
 =?utf-8?B?WXFmeTJ4MUs1bjBHR1RQM0lYOGJmNUN5eHo5VHBlbGNYeFo5WFNySjZIaGZ3?=
 =?utf-8?B?ZnpETHR2Ty9MS1ZLYndWZm9NcTh6dlFLR3hCeFNERmw4SWhhdnpjbXdROWlR?=
 =?utf-8?B?QXVkRXp5dW81YmxQUTZjZi84WDZVZUtuMHpRK2RkS1JCK1JMNDVKazc3UHl5?=
 =?utf-8?B?cTl3RE5oSzBXUjZ1aytwT0RRMTd2MGR5dTZ5YkVOQ3lFM1ZGTklzM0tiUjFJ?=
 =?utf-8?B?SmtJS3dlbHUwK2htRGc0UVB1c0lUY05HM0JvL3RWZllsSUp0aks0UlZSVDlY?=
 =?utf-8?B?TzhLSkh2ZTFOQ1BOenNLazQwSUs2R3FhelJ0QytiRmJMVi9PUkZkM3Evc21h?=
 =?utf-8?B?RXR4QlM0cVZzZlRIWXV5ZkJHdWdqMllzem9lcEtkRU14T2tuZHZxRU5Fckdx?=
 =?utf-8?B?L3paRmhWMW93eWdBUDRMQnBrZzExTUxXNFIxZFZrQVQxcUNRUHgzUmcyMEls?=
 =?utf-8?B?VktZSC9jZm9sTkFJcjNoeEpYODVwU0FWTkhQeVJNcFN2MXpzdmtwblEyc0Zn?=
 =?utf-8?B?TDhNcm9CektUNmpmNlR2UHhGOEp1Tm5aclROSExVZXZGaVd1RW80WXNzbjNl?=
 =?utf-8?B?U3NyblVtaS9rQnFKUVBuWHpLcXEzWDVXQmxGT0c0VFpIbmQzalRQdWJZQlFY?=
 =?utf-8?B?WVNETllWRzNGZUlqSDB5TUs0RnozQmdzamsvdWNpSGQwcEluU1c2ZGpxeEV0?=
 =?utf-8?B?bzFiVzIyUVl5QkRsMnA4ZDdZUFFlTzJoWnZveXl4Ymo4ZkdGaStpRVo2eWhH?=
 =?utf-8?B?YWw5WXVicjVIdWdOUVZkbUM2QXVLVTFuVE1hY2pQNWUwRlZucFU1dlVoM01O?=
 =?utf-8?B?azArbE9QRUdacW9hSnhDbEJhZW9ucnYrWjJacFcxWTNjTGZNSmd3THlURjVG?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39775fc6-5b5a-4eef-5ac3-08dbaa68ed1a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 21:26:23.5540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8UQLcHJenjMeEyi8cuFB35DITO8d0pRLdElhdRisUhhDoCepRUnFD63V0rxc0UW93qG7tkrmk0hlwPqsgqccZJMOQBE+0Ju3nElFTYrZ3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6744
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/31/2023 4:08 AM, Ilpo Järvinen wrote:
> Benchmark argument is handled by custom argument parsing code which is
> more complicated than it needs to be.
> 
> Process benchmark argument within the normal getopt() handling and drop
> unnecessary ben_ind and has_ben variables. When -b is given, terminate
> the argument processing as -b consumes all remaining arguments.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  .../testing/selftests/resctrl/resctrl_tests.c | 46 +++++++++----------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 48e5afb1530c..831d50a37d78 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -169,27 +169,34 @@ static void run_cat_test(int cpu_no, int no_of_bits)
>  
>  int main(int argc, char **argv)
>  {
> -	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
> -	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
> -	const char *benchmark_cmd[BENCHMARK_ARGS];
> -	int ben_ind, tests = 0;
> +	bool mbm_test = true, mba_test = true, cmt_test = true;
> +	int c, cpu_no = 1, i, no_of_bits = 0;
> +	const char *benchmark_cmd[BENCHMARK_ARGS] = {};
>  	char *span_str = NULL;

Could you please keep reverse fir ordering?

Reinette
