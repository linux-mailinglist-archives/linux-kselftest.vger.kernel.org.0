Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B51377BF4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 19:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjHNRvd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 13:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjHNRvI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 13:51:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B724172D;
        Mon, 14 Aug 2023 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692035467; x=1723571467;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GLO2H7ASPhAY2gCj5I1K2LXIJEQJfkUx6dCFprOEfso=;
  b=CX8/938gcpScGz77vzLr/RzQWXmke0sxAqjJGKRMKzGJ/DeKeJ01SVTT
   vlOQlFOzPcd1CPrLy6Gmpt1pT4AXuO48x/Cn4+1K5exu3QMytCO4aRgai
   Mxaozvps1jKYqlUpn7wYjiNvkf/GBJPS5ldvCJlbpSuihQ+EomRsKZ8br
   b1GkHE2lj9mHuBk1cQvC9nJ66ER1BP7dCIc3YouP+z+VmjX2t7xMn/ypm
   BRlpfSJF8SoO8pXH1h4pm8UWFRduPBv/d23OX4SEeG7FCGrnQD2F20t3M
   Rjk5U5v6dF0MkraAI0PCZyxyq00+cSBFjakTz6a88gbTUrXPOodU6s2am
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357067041"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="357067041"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 10:50:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736604309"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="736604309"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2023 10:50:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:50:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 10:50:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 10:50:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOG8TN1n6h8s66pQFA2ERxCZoGiFbzSzgPff+W3IZffmF/c2iRmhkD0n3LKeRJT0APr6HganHkOrGX4GtIkTfyqffIaI2U8SgMytDZ4jd7lZmC8DkoT54UJ4cDjXsyCekv88Wh3YItOTW9FecavUOamehiiqIhndjl/nQVfdUhnGN298LAGDAtkXO1ye/m5qqZ1RD+nJmVS2ZlrBE9COyM5cY06FR4ZUY9481ABMdY+rAl3yxooEglhVto94vXuRVTEUgOfXJpZsKOCjrCZFSHw4689mnCmnQ74f3eKtl69QZwDwmq72299sxQabCRpYQMMMJ1Dz89lBybXNwbDrVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAGqz2rgworBXshezOc0hXwBxhO/hjfypIcWJsbIu80=;
 b=hXD6tn2Nsn5AgYEJV5+Z0UERFzsNcPP3r/PlEgycOom9gVAbRYr8JxFhPoaxblb01t0x2gGwm6oe6d9YSUwnaZbuV3XkrSsdDj3ST/DH/5jw0s9sb48a3MhA25Q4kVL9CoYVbi/jBwLgTFY5O6M7gF/VA4UkoaxWhnPQsiK0F8TSlzi8sZN2CgQMLuUlkbBMC7R2HKN/b7l3IYqtl6b/wEdtbg6OQJOCUSF+a/HPfKiDpWbfgdtnS375l2AycUEbMiO7JFgxM2F2s20uqpP+1gRZhLJiWOH92zjY4BgvtFAKUvsxOr+eNly22JaBOpXqD61qxr+DGQCPjt1choJiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 17:50:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 17:50:44 +0000
Message-ID: <f300a52c-d65f-fd74-18ce-7d37e76d144f@intel.com>
Date:   Mon, 14 Aug 2023 10:50:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH 5/7] selftests/resctrl: Use pointers to build benchmark
 cmd and make it const
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
 <20230808091625.12760-6-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230808091625.12760-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0279.namprd04.prod.outlook.com
 (2603:10b6:303:89::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fda19a2-f9fd-4133-7e9c-08db9ceefb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAG6OKq0zJnNWieLw9gRgKnOyZVsQwIkxXvg5u9x6mGl0OJbgTkqkYhPwHMrQ73tZKEaPARKDK98FT5sRNLMwIRICZgVje+sKGHA/RRiAYZVOfBcUohikOLYmICEBrRrHV5rETMY8YTsPuzApR0XAkjYhLyC2FqnjpEg3sS0dPV2iquT7H9qq4cwgVY7xG3BgeFmtXPh6QdMpEIlkmJZI0SGHEdRUWEGdqGgccWZD5i1t3m3OwPL2qWcWFpHN1JYL1T6UuQag3xHqK3u4R5tkXoeTB0xTjwtBiSUO0xRh+UtYlm7aeMcWu9U5vAN1yeyXVgPT3VdSSmhZguIqOPOhnUv11SRTS0BxkrPuXNpSGgWxzA7rDuE+oEIGq4lEINa68GAWJwUUmMhgEpres2tsTclk8M/ZHTi7l2k3KesG0PjXjs3N5iNo+f8SpsMuZe12GiTK+xw63pOHR+E52/sKJt/2tlGgtZSnAsyaHkV+KFofI4eZyRg4wiy8P66XJPEbG30oK+y9xMf60NfL3ziYLOJILqpOOPWmsLapeJmsmtbgLfKinKjeTJXU1alfLRtM+w1aZphlvi78zNxYWIRQnxCQ05T2FjjS+UQ8143nWCO+GFMACU9nTPoIpspsOs7FwP8bHOM86r0UfbPBge80Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(1800799006)(186006)(38100700002)(110136005)(6486002)(6666004)(478600001)(82960400001)(2906002)(5660300002)(36756003)(86362001)(31696002)(44832011)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(53546011)(26005)(83380400001)(2616005)(66574015)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2VmOWErSTgycElRaXkzM3YrdCtHTGR3dGZhU2pvNTF1MzRSUmNZRlpCcXov?=
 =?utf-8?B?UlJUTWhvZXJ2S2h0SU90elN3N2pnUGZZclhZVDFHWHpxSVBSZHhvdW1LVFpC?=
 =?utf-8?B?d1hDMjJPWDlUTEpqNEJrVk9jN2xBWlM5eHZMV3JCaG9yekpUYlNZME9vRmtl?=
 =?utf-8?B?UjE1SGpzNGd2Z09ncVplNUpZYlhtc3RXS1prdzdsbnFUQ24xWWJRVW5HaXhY?=
 =?utf-8?B?OC84ZmZaNWVaeGk1cEx3dFVMb20velgrWjVQR0M0eG9qZWV6QnFudk02VlVr?=
 =?utf-8?B?ZmdUTlBseTFNMmZOWDVLdU9Oeng1Sm1hUGd5OUxUUzFrRTQ1Y1g2bmxCdlEx?=
 =?utf-8?B?cUdaQ3VtbkVYMVdTZlQ3cXp1R2JEeGhYQmx6c3ZsbWRwSnBaYjFKR2wyU1Ri?=
 =?utf-8?B?SXpwTkJhdnpIWE8zUHVzU0FFSVY0Z0xoRm1IRkdQYTZwckxGRTRsUnRNSHZj?=
 =?utf-8?B?NXJVTjRFNkEraFYyOUVBOGpCK1NyR0wyOW9UaWtIWk5jWVVabjl1ZHZzWVg5?=
 =?utf-8?B?VmF6ODkwYnYrR3JaekJIK0NmSTJSYkgxNUY2enBPcmJ6RHZhS3NETFoxWVhW?=
 =?utf-8?B?eFNZZUw1RHdTMmwwcXVFOTZyNFhRS0J0Z01KUk5QNG43MjR0aE5QSkowcUNy?=
 =?utf-8?B?NElWNFNjSWpscFlTelNYaEFDbzR3ZmFKMFNZazAwOVc5aWwvTThMMkhGRHlE?=
 =?utf-8?B?Sy8zMFJqeU5sSUJBYzgrbm5JdUZLQWNXK0FEOG81YzhaYWxYRkV1TzV3SVlV?=
 =?utf-8?B?VllCVnhheVRsRnVyb04zWE82bXpnUlQranl1RGZGb3Z6czJhVGl3cnoyQ0cr?=
 =?utf-8?B?Vmo2b0lBRmc0N2lSZFNkcTNJMkZETFVCMzk3TEJSVGVrV2NvcVp2UzFuemQ4?=
 =?utf-8?B?R2FkZkZzYk5DNjhzRUxnSk1RSU5hZzNGTEpaWHJ2ZnIxdGtnd2xCNWZVY0Fl?=
 =?utf-8?B?eTJVbC9JbjFMRkRqNG5CRkY4OXpHTTBKTDQ5ZmIxd3VBN2ZkQVo4Q21MQW1H?=
 =?utf-8?B?UzBJcjhjV01STEt1ZmUreGhhZjE3MmNRbUZxcTlyTk8rZzQrSmQyc09RNnVx?=
 =?utf-8?B?KzdtK0VBWTFQUkV4b2RDMlh3U2xzdjhEL0RjZHpEenBsWVRCdWY3dEUzS0Rt?=
 =?utf-8?B?ODRoajdaajRUR3VCZC9NV1hkb0NkeVlHYm5JcGtvd0FTTG9VcktKaUg4SjVw?=
 =?utf-8?B?cWdvRzVxVXZuQjVYOWt1SWtpV1FQWUdtN0FYeHlJTnV0MFVvRHRVZ1hGTjk3?=
 =?utf-8?B?YTROcWpuaWZpRHBSVjArZWVyZGhFUHFadEoxTmhmL0hvUm5uWWN4eGZrd0xW?=
 =?utf-8?B?Szd5ajZ0a0pwZDQzRDAxV0NWSmNSdzdoSGxZK3R6cDE1amN1Z0RHR0J1NHhY?=
 =?utf-8?B?YSsxTFN5NnNVbk1RR3BOYllsZVZIYS8wZE5sdHZxNDJYYm1QNjFvRDR5d0sr?=
 =?utf-8?B?K1p0eDRjaHJkTWU5MmxvNnlsVlBnT3ZmMTJKSHdLOHBPNVJzaFovVERXZzdh?=
 =?utf-8?B?aWt6a0ZiMFdJMXpFYVZpbmp2TkxtZnFxMEdydmFVT3N4ODYwRnVuUlRxaXpa?=
 =?utf-8?B?b2hhRUxLMGJvK2xBZGJhdU5FNkFmQkRvSjNwbnBTL0wrbnNaZ1d4Q0V6dS85?=
 =?utf-8?B?NXdhaDU2elZrNmJjZUlqN21xWXlZYnhBWTg1YkRmaWNvNEtEVkdFTnVXZzRk?=
 =?utf-8?B?VWtxZk45QWh5WlFMNVpSNElzbDFsNytqVGJlYkRCVzBKZ1ZxL21kay9CT290?=
 =?utf-8?B?K1dJWWtFRDhmYStPd05TV3U4c0FXUUhqZXhCdUd6eWlyNlB5WGtqRUd5cURh?=
 =?utf-8?B?VysrcnQveG1VaFlUQUhBbDh4RVRITkp6ckhpL3QzemRBaGJycW9VRHBxWk5w?=
 =?utf-8?B?d3p6ZGhacE1OalVnVmRoaE1ZWUNmQ0I1RmYzdG5LY0VRQ2R4eGVVQS9oTU5M?=
 =?utf-8?B?Q00vcDN5S0xkZnpadnNieEROVVpxd0lxcnBaam4wbE5xR0c0T1hTc3N0b3VS?=
 =?utf-8?B?VlRETXdmUGgxcWludWxRajZLK2hCVVY1WTNGTkI3US9HR3BCR2hScWw0Z0pC?=
 =?utf-8?B?ZDJKUzRTTkc1UnhwSzRrKzJReFFEdzVxekJVY3JHZ2hMbUt0WGI0aHl3NHc4?=
 =?utf-8?B?cHozNnJGeEQ3N2FNVzhVdjVzMHZGbWkvd2NSQVpWWDVXZEZCTWduSWExZE5D?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fda19a2-f9fd-4133-7e9c-08db9ceefb96
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:50:44.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mz3hzQ1hW45yu+K2nJp5PllyNGQ2iZMQKwQ70m9lzLsd3fa4eyfg9owkZ5hKjd/cOsqpj2RNzyLn8ZGbdYZqoRqsAGy5MioJBkqZxex894Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
> Benchmark parameter uses fixed-size buffers in stack which is slightly
> dangerous. As benchmark command is used in multiple tests, it should

Could you please be specific with issues with current implementation?
The term "slightly dangerous" is vague.

> not be mutated by the tests. Due to the order of tests, mutating the
> span argument in CMT test does not trigger any real problems currently.
> 
> Mark benchmark_cmd strings as const and setup the benchmark command
> using pointers. As span is constant in main(), just provide the default
> span also as string to be used in setting up the default fill_buf
> argument so no malloc() is required for it.

What is wrong with using malloc()?

> 
> CMT test has to create a copy of the benchmark command before altering
> the benchmark command.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cmt_test.c    | 23 ++++++++++---
>  tools/testing/selftests/resctrl/mba_test.c    |  2 +-
>  tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
>  tools/testing/selftests/resctrl/resctrl.h     | 16 ++++++---
>  .../testing/selftests/resctrl/resctrl_tests.c | 33 ++++++++-----------
>  tools/testing/selftests/resctrl/resctrl_val.c | 10 ++++--
>  6 files changed, 54 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 9d8e38e995ef..a40e12c3b1a7 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -68,14 +68,16 @@ void cmt_test_cleanup(void)
>  	remove(RESULT_FILE_NAME);
>  }
>  
> -int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
> +int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
>  {
> +	const char *cmd[BENCHMARK_ARGS];
>  	unsigned long cache_size = 0;
>  	unsigned long long_mask;
> +	char *span_str = NULL;
>  	char cbm_mask[256];
>  	int count_of_bits;
>  	size_t span;
> -	int ret;
> +	int ret, i;
>  
>  	if (!validate_resctrl_feature_request(CMT_STR))
>  		return -1;
> @@ -111,12 +113,22 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>  	};
>  
>  	span = cache_size * n / count_of_bits;
> -	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
> -		sprintf(benchmark_cmd[1], "%zu", span);
> +	/* Duplicate the command to be able to replace span in it */
> +	for (i = 0; benchmark_cmd[i]; i++)
> +		cmd[i] = benchmark_cmd[i];
> +	cmd[i] = NULL;
> +
> +	if (strcmp(cmd[0], "fill_buf") == 0) {
> +		span_str = malloc(SIZE_MAX_DECIMAL_SIZE);
> +		if (!span_str)
> +			return -1;
> +		snprintf(span_str, SIZE_MAX_DECIMAL_SIZE, "%zu", span);

Have you considered asprintf()?

> +		cmd[1] = span_str;
> +	}

It looks to me that array only needs to be duplicated if the
default benchmark is used?

>  
>  	remove(RESULT_FILE_NAME);
>  
> -	ret = resctrl_val(benchmark_cmd, &param);
> +	ret = resctrl_val(cmd, &param);
>  	if (ret)
>  		goto out;
>  

...

> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index bcd0d2060f81..ddb1e83a3a64 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -6,6 +6,7 @@
>  #include <math.h>
>  #include <errno.h>
>  #include <sched.h>
> +#include <stdint.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <string.h>
> @@ -38,7 +39,14 @@
>  
>  #define END_OF_TESTS	1
>  
> +#define BENCHMARK_ARGS		64
> +
> +/* Approximate %zu max length */
> +#define SIZE_MAX_DECIMAL_SIZE	(sizeof(SIZE_MAX) * 8 / 3 + 2)
> +
> +/* Define default span both as integer and string, these should match */
>  #define DEFAULT_SPAN		(250 * MB)
> +#define DEFAULT_SPAN_STR	"262144000"

I think above hardcoding can be eliminated by using asprintf()? This
does allocate memory though so I would like to understand why one
goal is to not dynamically allocate memory.

>  
>  #define PARENT_EXIT(err_msg)			\
>  	do {					\

Reinette
