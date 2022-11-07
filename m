Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A771620408
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 00:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiKGXyF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 18:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiKGXyE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 18:54:04 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DEF23E84;
        Mon,  7 Nov 2022 15:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667865244; x=1699401244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iXDDpNoBX/8mP9ToVWanl9bQ2LmlM6F2/R6DhWXEbn4=;
  b=kTeJRtdkpMzTazkCOWmzvZxVjrSUFOSF62nGXFrZUnMzsMtKD6Df83En
   UGi4Gip6zEuWE9VklVBBxI/noBNBXbsSkPwB/fMsiOP9ld3VNF8RtsSv2
   Z1SNoefqHsGGsU5GJOasgacn85mNy2RE6LLR298KcLy68rQ2sn4h9Cu7w
   SZEXyLi6Oyl6OVypMUmM/nJo9NopLjfSho0vqTBH1+5n9jdxwKFxJugIn
   7uzwuHFFmv1A1NmHdEU3xxCfspZpon4T7PZOJ/TMfCRa3c4fcv7qrw8q2
   2T0YvUmEuQzIocKqheszcY2oNhC5ULsOUkKcqnHcP0e0xcnwn7k2hCyIi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="312340892"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="312340892"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 15:54:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="761283562"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="761283562"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 07 Nov 2022 15:54:03 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 15:54:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 15:54:02 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 15:54:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqIJepSLewJEkkHADWooxhEGzEkYXYM6eU6loFJNa+/QLYeWRjfE3uGQ3FYKlPCuizYhOzequ6BFGpDXnNErJBcZuTzpqjUZmBGR0epUrtNfIs/K9oVo9Kv8vniMGuAGl7LdcwHg+59XdcVNXVr1IPhi5kMqcSlaUzEjZebML02x2fvxc9KGoXzKzEZ3hcKTqiIPBpP7G+8RsUvsg4dhnk8JymusIxgqV31UkC5snfk6Qp7Zi6xK4tHmMN1/Mad6rHiZ0KOz9NrGx/u26q5r+EGWBhhNTX1baRy81lFKHtIDMsUajlsaYoN2rbEb/eSken3BUdjFMiYCxm2mknUSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dL8hee3sBoCED+dDwc+a0mnSAnXKZ+wfAkdAmOVanFs=;
 b=DlxDR4UjfGx6WHoVvsG2YpnyuvtOu21WyytplUcxvXjbRROfd0j9KRCgefUKtk4YsafpRunZzxKApeTRCX76G9DIJt8937bHQaAa4wiJeA86sAdgCrS9HZFZfSMHv3HCg0ZnHeD3snaVd//tPVuZOCWiicELHG7IRHUyuDLm4TyV8Rzk4vuA6q9l7fY5bR7aD+g/rojyK6MDU1FarwIScPKG4mRyQqICChtqV2VfG1KMhhr+GmkqE7Z8uOMvxhx9osmGQyYzDiRk6BiDGIOalXkMiZkSag8E8l46Lz7y/xKvJ8G393QIOMTp2+PfHXVEutIucOOiEFJcB+JxW++TDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 23:54:00 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 23:54:00 +0000
Message-ID: <afa849bf-e89b-0c48-6bf2-f7ca58940567@intel.com>
Date:   Mon, 7 Nov 2022 15:53:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v3 5/5] selftests/resctrl: Remove duplicate codes that
 clear each test result file
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
 <20221101094341.3383073-6-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221101094341.3383073-6-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH0PR11MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c019f4c-5894-4685-1a35-08dac11b5763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+WSkMaYyc2JXiQRlPhvj/81KJgMze8Ps/eFnX2mIcgcw+XMF+fiFFrZPlym2VZv3QdHRQPyYXYtjf57Jm1mlMacGpXiaHbod0OgGZjr9SmztOdmLRNptIs7S8vndWu6ivHgKzNkAz8ReHCOAix0hbhbmn1dqKiVIg6Xo5oQslPCklv+NREd6akhFR84i4eXwojdei2sV0gQk2+u1GAMkH4YWTEGrbGZLNW/aDhdWKTZKw3uNmYciqwRcmQTvyAFYP9SPD+je3rXk7Q/f/rB7Z01piRNybjVfZOVUeh9fNoVIjOBPhDLgIJV94ZhwRgHo1oNixedEmvVlUQj3Gzy4QxKuw2KtOHhrykh/FtLEC59Cls3N3Kd9PSpVkZaMeHq6D8lj/KbVuG8P9tLMZsFeC5TN2c/1itOvjun9L68MWp38OJWQRK0In1CCHaCv2umA9D+ckKrA80T64Ftttl/KYWX5vXWtvxd8w84K7Le54a7oeE0cxLOssLN4Sc5q3Iz/hzZrIgRd+qGCV/EC0TSIgnj2yOp9P6snkWLSm547yupZ3isMtQ98gJ0cpl7jaTbRm15LNAu9duK07rbhbth0WBOaIsgzNzz5SznELAQLode2xIi3PZyfKjutB7TOEjlpBDKY0HRgMyJfknanYFOI3D0jJPuNF6unMRLhS7lahsxRXtS8RKTIsgxXmtHCFtDEpA1eURWnDZI2pxC9K8BoNBtrvHp0BqSbSPuDBVYhQbVXahfuxeIb8yDpp77PEfJ/oMr65caC3Wc2TmkSIRAc0B8fIJJ1pRppe+mFtESm64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(53546011)(2616005)(26005)(6512007)(186003)(6506007)(83380400001)(44832011)(2906002)(110136005)(478600001)(38100700002)(6486002)(41300700001)(5660300002)(4326008)(8936002)(316002)(66946007)(66556008)(66476007)(8676002)(36756003)(82960400001)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVh5Ump6VFpkWTZXNWxRZ0ptN29LRjdtNDAwMy9rU01pMFlHTVltS1BDanA3?=
 =?utf-8?B?S1QwQ1cySGZITnJBRmtObGdJNnUvNFE1a1JpNzVsYWJjTUU2WEhQV0g5c1BP?=
 =?utf-8?B?dFVDK3czWHZzWTNvdEpvMnZZUzU5RmtIOUtGZFMxOTk3WUI3WjFBZXRUL2g2?=
 =?utf-8?B?VXNWU0dvMHBLVUtCOU5xY216alhFVUdBQWt2NDd3OFBGYzlVQ1NJaTgvRzVy?=
 =?utf-8?B?TDEyV1h1bEZ6aEpSYmxuN1NYek1xYWtMZkJhUHJ6RDlIOXJvTzFyZjJTTnU4?=
 =?utf-8?B?by9sOG53dTFwSjE1eU9QZDBuZ0Nic0FDT3BJMWFMZXVsL0RFTGczRWxSRyt4?=
 =?utf-8?B?WDQybVZDSEdhRFFHNjA5SCtxN0dPLzl1dURlcEk4dWw4WEZheDBOYzV5RTg3?=
 =?utf-8?B?eU5GU3gvaEM4QVVrenA4NTJUZmVSMXl3TURhZTFsSTJDVmkxa01GWEdOK09U?=
 =?utf-8?B?Ukt1MlJqUVdHTmkxSTlqcFZDNU5nVDExSzUvaEw4U0habm54aFRsMkxobDhU?=
 =?utf-8?B?ZW5MMjY2VlJrMkh3TjI4bzNmSmMxSkdhZVUwL1NXZXU2aUlIc3cyUHErQ296?=
 =?utf-8?B?RWY5K2xOMG5xSGtrcVJIK1huYy9YdTl3ZGt3TGxkbFFYcGVFNDN6N09HeUVJ?=
 =?utf-8?B?Vm9VKzZvYmVLVloxQXA5WFFNRzh2dWVFSW5BVzFyNDB1WGI3MU5sbzdENGVH?=
 =?utf-8?B?OHQ0OEVBOHR1TEs3bVltVmxTdDdYWTM4N2NiNFdFb0tuUkZqaURjSDUvU2d1?=
 =?utf-8?B?Wm11Wi9XVDFRLytrTU96Zk5KT084QksvTDZOQUhnV1JLam85SWxKZWJXNzhW?=
 =?utf-8?B?Z3dtVy81MmhsMUFVY3NWM2o2aXdWUUNyT1BZUTJhYWF5cDA4bUE4VktGOUxl?=
 =?utf-8?B?Rk9HeUt6R3dYSnI1SEdndk04UGpiTStpMjNwQWxrZUtoWmFBODBOWjgwNW9F?=
 =?utf-8?B?RTR2Vms0S0tJNnZiWTg1MFp6YmVoZmcydGo3MW13YjRMUmU3VmpNSWNGb2Zk?=
 =?utf-8?B?ZmZkb3NLQXFYd1VDOUhidG9tOFcvU3RGU1R3YmdlTkJ1Q1g0eEp6bTNrZHJa?=
 =?utf-8?B?WXBZMGxkTFNnWEYzRlRjakViSUpLK3dodHhZUkJhaEV4RjQ2eWFIbTlrQ0RD?=
 =?utf-8?B?dlIyYlYwemJPMTI5SnAvU3lyRUYxd3A5bVNGSlBxSTVxYzlLYUM4MzRWSm9p?=
 =?utf-8?B?bUY0NCtlcTBQRHhLZ1dPdHRCUkpObkZDeGEraDJodmFXNzIxN3JCTExHZStr?=
 =?utf-8?B?bmtvRExTQjhxejY5OVVtZEFKNVEvL0k4ejNBd042anBJaERURHdheXdxR1oy?=
 =?utf-8?B?N3BnbWQ5R0x3RWw1WDBxeUJvNGRTL0hHeENXbjYySjNDNXlnRGhucDk2QSs4?=
 =?utf-8?B?TEovVUo3TlZKbFdiVU5QTmVTNkE4bERORnVHWU1teXdocDFFQ1VmWnlwZ0Jy?=
 =?utf-8?B?N0xQVU1ZZnVKZ1dwUk9XR0d5cEhqWFhXMlIwWGJtQXlTT2ZYM1l0b3l3TlRh?=
 =?utf-8?B?aVRxcXZ6dGMwdi9rdnoxYVo4Rm5qTk5CNlZYSE9hYzdsRVdYam1CNk96emNt?=
 =?utf-8?B?T21icVNieHRqOGl6QTFGUzZVaXdxaTQwd0NvRmNOcWwyQk5HT3NuTjYrakpD?=
 =?utf-8?B?UXdpNi9DUU9NUUYzb2JTdWNyOXh1ZmxoZW9idm16LzR6YkQ2cThzeU1LRE1i?=
 =?utf-8?B?NjJ6UzRoUUFIR2hhN3F2RGl5dStlL2dIcnlsREpMcHZoRW5YWEtyaWRiQkkx?=
 =?utf-8?B?V01NVW5IRjVrdERObTdncTRQVTJrUUNQSnJMc0hqTXdIN1RKUnV4QURGMDkz?=
 =?utf-8?B?akM0dUlKYzUyMnFEWnNlL2dabFVrL21XYko1akpNZlZBbUsrVUFzeW1JT25J?=
 =?utf-8?B?K3FtRW9aUG5hQ0h1UitYc2w4cnhQMndnU0VZUk1KNkc3bEoxYTRSdkxjMUQ5?=
 =?utf-8?B?bWZNeC9tUFo1cC9ieU0wQlBiRHN5MktLdmt0REYwWXcvRnprQmJMRnVJM1NK?=
 =?utf-8?B?VUpYZzRHOWVPRENyRXJTKzh2bjR3VWNoUWVGWElkWDBySXlHQmY2WmZrc2hN?=
 =?utf-8?B?OUxvTHdtYU5EZDVBVkZ4ZzdzcDlISDNXeG9VUkFBbGM4em9MOHJBTktvR09p?=
 =?utf-8?B?Z3o2WHlUQXN2TUpGdHRmeWJxYUkrM0kvRTluWm5HUUlLYStZbmJrRmswUmd2?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c019f4c-5894-4685-1a35-08dac11b5763
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 23:54:00.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNpZMtFV1micExx2k8Utiz/v63Z+Mwc7WVcyWulPmTusdHFJdXqNgWLvcqqNlwLBsq3BEIhV5sIrCvKCc4CAh6sGafyaCFukMBz+1zrmQP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 11/1/2022 2:43 AM, Shaopeng Tan wrote:
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

From what I can tell this still seem to suffer from the problem where
the test files may not be cleaned. With the removal of mbm_test_cleanup()
the cleanup is now expected to be done in mbm_bw_change().

Note that:

mbm_bw_change()
{
	...

	ret = resctrl_val(benchmark_cmd, &param);
	if (ret)
		return ret;
	
	/* Test results stored in file */	

	ret = check_results(span);
	if (ret) 
		return ret; <== Return without cleaning test result file

	mbm_test_cleanup(); <== Test result file cleaned only when test passed.

	return 0;		
}



>  static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
> @@ -107,7 +106,6 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
>  		sprintf(benchmark_cmd[1], "%d", span);
>  	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
>  	ksft_test_result(!res, "MBA: schemata change\n");
> -	mba_test_cleanup();
>  }

mba_schemata_change() has the same pattern as mbm_bw_change() so test result
files may linger when test fails.

>  
>  static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
> @@ -126,7 +124,6 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
>  	ksft_test_result(!res, "CMT: test\n");
>  	if ((get_vendor() == ARCH_INTEL) && res)
>  		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
> -	cmt_test_cleanup();
>  }

Same pattern again.

>  
>  static void run_cat_test(int cpu_no, int no_of_bits)
> @@ -142,7 +139,6 @@ static void run_cat_test(int cpu_no, int no_of_bits)
>  
>  	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
>  	ksft_test_result(!res, "CAT: test\n");
> -	cat_test_cleanup();
>  }

Patch 4 makes this work. Thanks for doing that.

Reinette

