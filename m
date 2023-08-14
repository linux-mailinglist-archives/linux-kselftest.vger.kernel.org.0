Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58A177BF67
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 19:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjHNR4y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 13:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjHNR43 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 13:56:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0CDB5;
        Mon, 14 Aug 2023 10:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692035788; x=1723571788;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ogxcpsf2HNjmIUFh68jC1lZpQ4U1h+TzKVYw+pW0yZg=;
  b=aWiTokvuoDBXb/4GeWtSfypXvNDG4iOeIb5UVl83xtadCvj/PCIAQobR
   c1jGg+FqSc5eZO8ypo/L6WJkThqNWBjG2/L46K4CR83CbJeFcFwvWgzNi
   AR0/qsuf1sOhs0bDPhlhZj1aSWal1l5xScHW9rLIlFgix0vhXU3evW9L5
   vrMG8PH4e+DKXzui7BFBAYHX9d0vsWw7vYuzqbS2iavV2IBAuXbGyfn2T
   k6Up9zujh7bcLbGD8qOGKUyLI3FBh+f+dS9vYVfoJ/puGKW6q82mrr1Js
   pUnN/zq9uoZgG8vZijle7gVK4Yt1gOide0GANNFa+8HkDnt6IONecY5Q0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="369575045"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="369575045"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 10:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="1064154647"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="1064154647"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2023 10:56:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:56:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:56:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 10:56:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 10:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4eVIUc+gTDclukY0Zf/IuQceb6jV64Uq96TIyRuYKC3BPlCLnzQ1bt3O5vJF2jCKrJY/mAzJ552c8rQdZrUBh+hJwb6fPqFXia3vVaiqCWd8ruHibj/uYbnUjBKOdGSNacnofUh+KfdAR8xrULqMoA1M1aboejyteYvuZgkH+p7LIWDJhzw7RrZo5TteKSToP51evsvaneeVZtFOktBaGSfM4X+GvjLVraHSMeayR0LNAvpzBGv3cQS9UlXF2an9FdMjI3CrxMpMVMjChHjJhqCzJDWZvkvAgSRjvrISs5gVWbhgiuOKn+sp55LWsawl2355j3B2ZOfzbLzmMP5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsT4LZ9d18Y6/2EgcoPhvfWVvSSMpjMoFuuThAxHY3A=;
 b=TWBsxZSZD5kezspku1cYkcy4PEZ+Klv9w3mmH5kEtojr4E5fpw/Pe4Ac7OCKThmge6X5VpVk3LL9vLVD0hzug6I89SotbC4UnTk7HcsH1rfSsgEPZJbSXFiCzNP5v3ZIKsq6uPpVTdFD5u3h8wsFBjHCfglc2TcDNYbcXEyVu1yrMiCvrIRjrYUSVxAHo3jEhS2pHCEP5O0ALqliOy5DmTY+jhpHxXWpWy7QPUq/xlTOeNqy07vJFuzBU+wOFxfvfv/wbZRAOrGvMhqYvuy3wFsM7cbQYU9/OWBecxfB8S3W9pVh3jnmyEK5t5pQzagkirp+CcAi3mpFr0EI1aSlrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5350.namprd11.prod.outlook.com (2603:10b6:208:31c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 17:56:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 17:56:24 +0000
Message-ID: <dc2406aa-be6f-e641-786e-cf67f790ce78@intel.com>
Date:   Mon, 14 Aug 2023 10:56:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH 7/7] selftests/resctrl: Cleanup benchmark argument parsing
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
 <20230808091625.12760-8-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230808091625.12760-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0242.namprd04.prod.outlook.com
 (2603:10b6:303:88::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: 14cccf31-ee28-4410-7007-08db9cefc65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDdDSE+TIrXK8V9lmMRCKFSVPbeGK0CLiruYJPwgkrGEoU9L2opdHXfAAAQR8e/HLeo5G/I4JtHO6sxjLAt5HHfO25Dhgge/MvmhPsUmuplsaPeNhEsve4IvPUPIsYBukOZi5Qs1oJN92L5NLK2r4hQlT8A5KN9qx3ZeW11lJBVe2NHsLe2PzqYv4Z7sK1SK5cXEPLTxqkwhObskwwedAWy98plK604Gcx8U4cpl85zpJ8yIcGliPFKGKJ7lA7I3CCEw+WYhkOKALLvPDH1QTn4Wjg2kBnzee2Qi0RcOfst6QujyJSUkToQc5bMk6daucfOh5+XgO0l3i8q2+7q4OKVwijBUM7mn9usLASlfr/ASc36t3tyos6deKb0iP7/mS0IfWRqBbeWfJm7miMhQuCbjZx71rx9+beTmimqIa6HDEsQDerC6GLst0XuNPNMWN/WkgRRwIVPJa7tse8yY/uMiu+CDTfnh1bDZ7DYqX8wmPGipRQmK56a4dNtmtgxdZ3nD2KItU+1j/zEDfO8xKa6AwDQaY1mpuPVrQphDJLbOQX2Li5cYQZzE7N05UEpahae0XMaKV0jOgIc+IxOp0BUBjGDHsyO7C8Fos901SZ5YalmoXgiuRva3U3CKmLmsMwvvgrn6YpcdlIm+jpYaFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(1800799006)(186006)(38100700002)(110136005)(6486002)(6666004)(478600001)(82960400001)(2906002)(5660300002)(36756003)(86362001)(31696002)(44832011)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(53546011)(26005)(83380400001)(2616005)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkhySG1JRlNRenFUSHh4QzVHbW0yM2RBQ3NLNnltL1FKMFBhR3Jac0h6d2Rw?=
 =?utf-8?B?Z2x2YVZYKzlaK3RlZVdtZXQ4QnBWdHpOQXNpUnUxZmdWT2w0TVBiYXZhYW9j?=
 =?utf-8?B?UkZwK3dvcXQzckFSbzV1cHV6NElkU2tjczEvMGRkdmMyTTdSK2ZaZXpnbGhW?=
 =?utf-8?B?RkczMG5rZ3dVM1cxcHNuWFNWdklYM09rR1VVYkJuaXFja2QzaG1jQVU1T0Q5?=
 =?utf-8?B?RWhUWUw3ZXBxbTcvcE5iT3VGdTFIL3dQa3ZsaGJFdGEwSCtNQzFMQ3gxd2t5?=
 =?utf-8?B?QmFTOUdkbHhSNnliU0J0QjdUNEhnQlhjVGY3V0hKRDlJMWNwOE5aQURjK1N5?=
 =?utf-8?B?bW1rOTVnUHpvOVF4UEd1Y3pSS1I4ZDNxYWtrM0piZDNJU3R6cnM0aU5uenRt?=
 =?utf-8?B?ejdoL2hQRlRmRzNvR01HZ2V6c3NUdXppT2lwMXlMS2FwZ1BrVGxQczgyNWNT?=
 =?utf-8?B?d1RORm8vbDlHcTN2YjU3aEVncGlkdmViZVNMSCtiNENDRmxTUjNERnE0dk1h?=
 =?utf-8?B?VVh4MFRRS1JrU2Ura3RWUmlFK2RJcnp1YmdYZE9SOVkxVnVSZVVMcjZOQ0xy?=
 =?utf-8?B?eHVFVkE0bVZlYWQ0bmhsVTRrQWdsVGxWaWloQWZxd0loRm5FK0hMU1JnTDRj?=
 =?utf-8?B?SnJ6WVlKakpWOGwvMmZOSXNJb2xudXRJOHNocHROTUZETXFNVkhOWHh2dVpo?=
 =?utf-8?B?d0V2dm82bk9SbS8xdG51c1VPTTNoakVmZFA2ZEh4L09ncXZ0TnlmeW5pZGtw?=
 =?utf-8?B?NExVTVBnSmV5Q3NqMk1tQXlmMEgyVHZRK0hNWkZ4TnVqcldyTitkNy8wWEpJ?=
 =?utf-8?B?NGVqSWFuVkhBNlFVVUR6V3l2SS9VLzhCWHExRkVvVUZua05sb1ZsL0F0aTMw?=
 =?utf-8?B?eGxYd1R6RXpDT0FudlR3SzQzWURYME1LMFM5U3lyY0tiTy9sQnpHbS8vbFYv?=
 =?utf-8?B?SkNoek0xLzZnNkR3REM0dkV2RjBQWHNicnZCbXdMQlpreW51ajVIM2lpODVx?=
 =?utf-8?B?MzVIMjJ6eWxtbTdTYlJkUTV4VE1HbEpwUFZ3VVU0SGw2bEUxVnJEeVd0VG5I?=
 =?utf-8?B?RkJRc1RUeTNLdnVMbGpaMS9KdS82QS9NU0RQTlpGd0VYU0o1MVBFeHl1c1l1?=
 =?utf-8?B?T3czWVlvODFaa2QwbGFCaG1MdVFmTlpzTUc5dVNFUFVXK2tJU1JEam15TExi?=
 =?utf-8?B?SE5BTVptNmE0OVU3VGxGeXRwMzdqZUFTUG9rSDArOVFaR1l4SFNFTWFTT3Z2?=
 =?utf-8?B?end4RVR6VjRha3NSRk1XcHRmYjV1c1pBSzhpQ0FjaTJNWm9UaHVJTzFOQTht?=
 =?utf-8?B?SWRwanlSakQ1MklCdEd0aTU4QVRJcEVXMmlNSHlld0RUWEp1VENzY3RZb0ZY?=
 =?utf-8?B?ck5qU0szU1Bna0E3WEtZTWVOTWcxVzFTbzYxMytRVUNrRGNlNVJ4b2MvS0JZ?=
 =?utf-8?B?WE9EQk9KdVdlMDVSdnJqM2QwaW5Ndk5JQitSdFhMRlpLeWxDM0J4bFVZRERY?=
 =?utf-8?B?YkhvblB6cTRlWTJDeUxkSXVOVU1JWm1HUFV5TXc4aTVyMUVRTUVZN1VVODFW?=
 =?utf-8?B?SGJIRFpHSkxvUFo0NEpHSjVCK2kyZzBDbXFkdTBiaG12T09GRkVGekZjNDFz?=
 =?utf-8?B?TG9oSzhNN3ZjamFUZW5wdmRkNGwrY0IxbmlrekMvTVZJOEdXTkgxUlB4YkdW?=
 =?utf-8?B?YW4ySWg1amRNekpIRXpycHFHanpIWjhEc3oxOTQ4ZGVEZ1d2UHJXamYyY1FY?=
 =?utf-8?B?MEZJcUc1WkN0MWN5MkdvN1JQd1VqbXQ1aXFKb3drbDE4c3JUSFFvWXhOV2Zs?=
 =?utf-8?B?dTdjVFpGNGdtdXkrdWd1NWFKL3ViaDIydjdsUTJoeUxReDJXRk90NlFqT2R4?=
 =?utf-8?B?WXFFYW9BRlR1MXVWamo0MGlHSzh1UUpDVXg2UHErYU9oNHhVZDVscmVYSzho?=
 =?utf-8?B?NjhyTFpsRlNZOGF6RzVPVXpIcXRYTzFDTFNYc21id09hbGptMVVTWGwxQU15?=
 =?utf-8?B?MGUxTVBjYmFucHJuTlJQOXoxdjdFdUhTNUVrS3QxQkpESysvazNzZkRhWkJx?=
 =?utf-8?B?QlhYRlBvY2tTQzM2MTByQmZkWHA2NXhRY1FpQ3RnZ2tOZGRVRVlReGxMeW42?=
 =?utf-8?B?UWgwZkRiNXZrZzdBMGp6UHZPaGdrSGl5RzIyVlQ4TTZzQisrYmsySzhKMDZr?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cccf31-ee28-4410-7007-08db9cefc65f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:56:24.3970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IN9g/8lRAiWgGI/re/xN8uLX6+o6Ct/GWWIFrYuSRIleVEjFA7KMBWDjvZvAmrMj63QmN4fSBwLe1SUmKQUHRe0/NXQoZWHQgxUqj8uAhoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5350
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
> Benchmark argument is handled by custom argument parsing code which is
> more complicated than it needs to be.
> 
> Process benchmark argument within the normal getopt() handling and drop
> entirely unnecessary ben_ind and has_ben variables. If -b is not given,
> setup the default benchmark command right after the switch statement
> and make -b to goto over it while it terminates the getopt() loop.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  .../testing/selftests/resctrl/resctrl_tests.c | 56 +++++++++----------
>  1 file changed, 25 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 81c2ed299e6f..a437aaa69cc5 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -173,25 +173,27 @@ static void run_cat_test(int cpu_no, int no_of_bits)
>  
>  int main(int argc, char **argv)
>  {
> -	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
> -	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
> +	bool mbm_test = true, mba_test = true, cmt_test = true;
> +	int c, cpu_no = 1, i, no_of_bits = 0;
>  	const char *benchmark_cmd[BENCHMARK_ARGS];
> -	int ben_ind, tests = 0;
>  	bool cat_test = true;
> +	int tests = 0;
>  
> -	for (i = 0; i < argc; i++) {
> -		if (strcmp(argv[i], "-b") == 0) {
> -			ben_ind = i + 1;
> -			argc_new = ben_ind - 1;
> -			has_ben = true;
> -			break;
> -		}
> -	}
> -
> -	while ((c = getopt(argc_new, argv, "ht:b:n:p:")) != -1) {
> +	while ((c = getopt(argc, argv, "ht:b:n:p:")) != -1) {
>  		char *token;
>  
>  		switch (c) {
> +		case 'b':
> +			optind--;			/* Back to optarg */

The above tab usage is not clear. Also, tail comments in code has been
found to disturb reading to the point that x86 contributors are explicitly
asked to refrain from using it.
Perhaps rather a short summary of algorithm before the code starts?

Apart from this style nitpick it looks good to me. After that is
handled you can add:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

