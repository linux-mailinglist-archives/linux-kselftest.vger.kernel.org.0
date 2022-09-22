Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929B85E69D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 19:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiIVRqn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 13:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiIVRqm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 13:46:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FACE8DA1;
        Thu, 22 Sep 2022 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663868801; x=1695404801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oYtVpcrS+6LeL3OPFkvC4ZPxNYHoRn3vzqKJu3T3CGw=;
  b=JVz7GjHUPcLfPUIaA/xLW34CU1oM/T5h7BNSr+BTxDQBHiyly/oS4ixq
   Ro0xuGVthzcTe9ZncJWD0BejbduP6Wl2dlAz2xZDbi4ghG7r9HlYhOBi9
   RakrV6iWtO3sKyGdJfCyGi7W2s1xytBcGYUKpODaJgzigcrYvJ4ODkyxC
   NIDr80Dk/x//FqU1KcoHqiCyDkmmJu1XuE/6LCNxuIGGZMjKYBcMxTjr9
   6xyOGi2Q+zhZ5uaZ1h+uPEgrOspuTnoPE70qcP5AYb59XbTHRiSu66N25
   XytRpu8YDodQTox+k7DiVUqhdS5Hc6I+g6wDw41J3OWO04kARdrCPMfiH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="287461877"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="287461877"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="708976377"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2022 10:46:40 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:46:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 10:46:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 10:46:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONsyqDuZfZqfqhypGB3FZdHulIgHpprFRfJzCMG2DuGNgmQSXF9ZeSY6hH6EbYscRylMXkMR9NljAZ7E42sNoHbihr71q/QAkrIWDgLLV82dbvTalFRlGR6gpktRzrHBsS0r7qcH5IGCYchqOnOSyC2abukP90dNKwFOX3FoxYpstdClhMoNqlp46FWLHnqffNxoS1t7mpebWOYzuM9PT76Z88P4+moly934ArIQbL/E1Bkt+94xYpK2nbrNsexLJbiVJvwvSopMZOCGau8gM+Emz6HmvdCOPn8C0EfuxVBMJEmta2zzINrWheEMHcgK4LooeM+cEbXrXzX6tlinSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yECBKYHZDS4DjE4adPNmpcPZidiS9CfYBw2X7YoYx8s=;
 b=MpPdbqwWhB2dofiWHzwF/umhjUFcjNMkFIqcnPQAry9OHdq6xrofWhdZ64969x5dnx4EL7Vu5aHe8v84d6JhJleuAmmdx2TY1iPnapcoOKJUDbb2FVeOgxHdxRaRMCw5JbHMu5Y4GXVPBZn55Q6Ue2ALNWUAODxeFRD+pTDnr8a96aSTTeLV0QwPYXY3e2rT22hpLSJIqF00bN79R2iJ0kPWwOaNydZabNyGfTwVq8yicK9lUrsCPJyMQV7UYaM3eOZG34Gi7HjQa6vQaxehOicZcNQl/BsS7BFNc9MnL4gbi/FCJuvRWcdUtUf6a5uhXh8r/uz4pwvNxOgB8Ko/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4670.namprd11.prod.outlook.com (2603:10b6:806:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 17:46:33 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%11]) with mapi id 15.20.5654.016; Thu, 22 Sep
 2022 17:46:33 +0000
Message-ID: <bdb19cf6-dd4b-2042-7cda-7f6108e543aa@intel.com>
Date:   Thu, 22 Sep 2022 10:46:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 3/5] selftests/resctrl: Remove duplicate codes that clear
 each test result file
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-5-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220914015147.3071025-5-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::36) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4670:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa38f9f-b75f-4ead-5852-08da9cc2636c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pN45mMkTbALkngsFza2QyjI5hXcOYVjW79g8f2tQ8YJNwKijexzlef63L4cwg7qurrmHKyV85pN+ewo+3pM7NSBFg6YWF3JPG+Fzi6V3fAqUqM4+cGCzq2Y3RP3daH5c8hiDG1eltUs0hyRxFfXH6iEkZadGo8TPAF7YDGQ5s8OgYbUfNYbxqJUdzFLXlz1HkMW5m92cgu6Ti3YK/9cHbQUMw1JjMa9O+juDZRo6xjLr3DB/GTLBgLTEyu5L+5A4CuZ1mHNzfQ9xHPYVWC8lxdgUQ0zTX86LB7afJlx29ZAhRU3CarBKY+bCmjQB0HRIUeN964Z5ogX45z7+/HQHaVIoNH8joEXDGK9D0bTHbRe14cnllvQ85IyXsCuoZ/fji6TjeOPxCb1qtH0/Zo75oV/z1M2/U9RmUyn4MRuWtSoU09tsyLMBa1uvoNObew3HbWYalAQqhtDU+7U7TAqmOjAAH79tDihGAvLrDQ9p9gzYERyiBLoEEXLZNC3ZwKn5Gn7mG4VWmwHSLXKIjhOtmKUDP0jOtQmQcSMDBBUwYrz890f+opU1mPdv2YGuUJaDvQ+lfNaivlBS8uulXdEuo5qzS6tomuV0l8UcB3P7dDLvpAf6TEAwkelo+OkbaX9l/cYh4d6MTOWOkqwIWthhY5GJuNIwWi7+XDI8zLXBTRSkuTLiMj/mKH2dp+/l/dCKzBoc2YWCs1uegxZ7yb24NERLQ6EIPZuqUBcd0THH+AloYtkPjbwgrD1S+VzqUwWUjqYWFVaTWB5Kf/YQ/7cZdCWjO657pBBlBikCp1x/UF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(6506007)(36756003)(53546011)(26005)(31686004)(6512007)(66476007)(66556008)(86362001)(110136005)(66946007)(4326008)(8676002)(41300700001)(82960400001)(83380400001)(6486002)(186003)(478600001)(5660300002)(8936002)(31696002)(2616005)(38100700002)(316002)(2906002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTNsakhnOEpMcG80ck1MU1M5OFd5K1RQcml1ZVY5WHZ4MDFXNlpsK3FBRncz?=
 =?utf-8?B?WWpiRG56YURlaHVkVFlHODVWSmtmMW1QbWpuMTB2S0xwZG9yOHRBeE94OGgy?=
 =?utf-8?B?eWJ0K2VmTmtKRVZzeFhreTJZRGtYNm9nVlZtTHUrTDZ6eUxyeXp2MlJyaFZh?=
 =?utf-8?B?cy9uL0dKMVdEcGZzWVpJMk9sODhCcExuTkVuem50UnV0cHZoWWNVSnZOUm9X?=
 =?utf-8?B?SWI1SXVoMXhLVldEbzdocG5JcUJEcmh0dlJBSjZjMFhNbnIzenVXd0lQYmVO?=
 =?utf-8?B?OE0vcExGNHVydE9oLzM2WXhKN2RzT3oySXlES1Erb2JBRGN1aERFWjlpMU1N?=
 =?utf-8?B?SHN2M2QxQWZ2MTZVSWRRaGtubUNmUjhpQWRvamJ1NklyNU80Q21kZERpalRs?=
 =?utf-8?B?eGFCSkduWW5oQ1hDRURjZVpLOUh1U2NnSFl0OUVncTR4aE9jTGNSYkJtY01h?=
 =?utf-8?B?L0JtL0JiWWNEd0lZMkRwMnpLZmJraFVrb2R2QjArRSs5amdqbzZ2dkhhb3Zr?=
 =?utf-8?B?cys0ZmllL2oxK0RLNDRDTVZMdVFMRkI1MWtwSUJWNTR5aGxEWjVhOGxkVndk?=
 =?utf-8?B?VnFlQmQyY2F3ellmZ2dKNVhoc2FaTlRkSlBVbTR3NG9QUTFMNjhnbU1vTnNO?=
 =?utf-8?B?S253WjlaNTl2d3d4SXhaZDR5WHU2MFJRMU93dlZkMkE1TlROdTFaZjdMb3ZL?=
 =?utf-8?B?TGdYM0ZLd2M3VzJlbmJWUnBGWXkvM1B5NDJYa3N6MGlTQ2FSQzBWcEx1YVdz?=
 =?utf-8?B?N3RXMzNOSGZYNHM2Wm5aUHVWVDhyTEZqMXNwYkoxSVlaY2dzcnNXQkdKYUdQ?=
 =?utf-8?B?RWxFNkdXeFovZDBYQkZHMmtDWllPUEhaa2J4RktMYVpvczhkZE1hTy9QZHBY?=
 =?utf-8?B?Sk9xUTJOUVRuSjR5ZjZYZzlHMXJEUVQzTis1OUhuY3drT2l0NEtYekdFYXhZ?=
 =?utf-8?B?TmNQVXo3VXF5U2dOMnhXSkdKWHd4cnlRd0NvYkV0TktjbUxnclliLzhLelo4?=
 =?utf-8?B?WUF5RUpadGtkVzN4NDR6dkRMc2VDUzcwQkVTMmtLc1QzeW1GaXpMNE4vOEx2?=
 =?utf-8?B?SzVZdlpYbFMrYmVjM2dteHhpWWNQdWhWc2pBL2J0YWFPNThyMmlyenFycGxw?=
 =?utf-8?B?YXE0bmpVd0k5bGhyTmFybVRkQzhiWlFFMWlzSCtCYWhJeFVyRU5oMStERjN3?=
 =?utf-8?B?QitOWFg1clhnbzJTZnpZQ2E3MFh0TjFCUEY3cW1waDJCc1YzOXBGenI0eUpZ?=
 =?utf-8?B?RWROclQ0eklrMHFOQ1dhcXdocG1rVHMrNnpMZVdDUEpkcG5HRGQwODdhQ3BI?=
 =?utf-8?B?bU83eXhjMW83MVlVSHlUQkdFR0sxQStRREYyLzFVTytCUEc0bU9EbUprYWpl?=
 =?utf-8?B?SHV0VHBBRGZJUTl3MnYxL3lRSUVxWlh3dWJ1Qmpyd2wzYkRlNjJ1bk9tcXJp?=
 =?utf-8?B?K2VDdjFzYkxLY1dUOHVEK291VGI3b2FkTlo0aUhyZ2hGVzlUNVFUY04ySE1s?=
 =?utf-8?B?VUR6NDdtSm1HaE5XZTQ0ZUNENWovTkdYd3ladFIwS0MwWHFxeGgwUWVGcVJk?=
 =?utf-8?B?V3lPU285WTBRRjFnTXppVUNIRHF1aCs4S0wzOS8zaTBiaWNmK1k2NUZ6a2ZW?=
 =?utf-8?B?VlFGcnhIVVltTjkvRTZZNGE1V3NXOWxmTm1qZHk2eFJoK05oUUJTNXlFZ0R6?=
 =?utf-8?B?akRsS3preVRYL1dUeUJ1ajdmSUlVVkY5dmFGYnRJZGU0QWRwUmMwUFlkNERK?=
 =?utf-8?B?WnBZc1g4elptMzU2Tm5vcmorUmZSTVpaOFpxQ3BVakhNdHE4REJDeWZRckVW?=
 =?utf-8?B?TDV0QWdvY3g5dTAyQ3pIMTVieUxSUzdyTzJFdVRWc3daL2lwZ0dKVklMWlA1?=
 =?utf-8?B?bkFwZlRvNlJoY1FYQmVBaXluNndTdDJTTmlqU3h1eDRyZG5zeG5WYitia01I?=
 =?utf-8?B?QjlhL0h1ZmJDSzNSQXNkOUNqOWRwZEFMRTI5a0ZDVk1WZEtJVk14NEwxRzFU?=
 =?utf-8?B?azMxNFl6M2R2VXBuYklOdGZDNmZ6VlhpbDk0SGV5RGl1R0JLL3lSY0tJZHRs?=
 =?utf-8?B?bzNXR1ZWM081blhmZUwyWEFiQkVxNCtlNVJ3MDF1US82a0N2K1dNWFBFK1Fk?=
 =?utf-8?B?OWNIclM5cjBOYVBLWkhvRkJua3dYcDZGQzdINWxrU28rOGNpNDJySmZzTFNI?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa38f9f-b75f-4ead-5852-08da9cc2636c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:46:33.3542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHMATUjSzYCmBDYQfXV8aulRaVRA03LA/n0MnNWftaqeRv58qt3FwsZaRfIleQofRHXYdjN3810jSdJb8j35J0K9famOmkPH3NEaa/0Mv4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4670
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 9/13/2022 6:51 PM, Shaopeng Tan wrote:
> Before exiting each test function(run_cmt/cat/mbm/mba_test()),
> test results are printed by ksft_print_msg() and then temporary result
> files are cleaned by function cmt/cat/mbm/mba_test_cleanup().
> However, before running ksft_print_msg(), function

before -> after?

> cmt/cat/mbm/mba_test_cleanup()
> has been run in each test function as follows:
>   cmt_resctrl_val()
>   cat_perf_miss_val()
>   mba_schemata_change()
>   mbm_bw_change()
> 
> Remove duplicate codes that clear each test result file.
> 

Another good catch, thank you.

> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c | 1 -
>  tools/testing/selftests/resctrl/cmt_test.c | 2 --
>  tools/testing/selftests/resctrl/mba_test.c | 2 --
>  tools/testing/selftests/resctrl/mbm_test.c | 2 --
>  4 files changed, 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 1c5e90c63254..d1134f66469f 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -221,7 +221,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		kill(bm_pid, SIGKILL);
>  	}
>  
> -	cat_test_cleanup();
>  	if (bm_pid)
>  		umount_resctrlfs();
>  

It makes it much easier to understand code if it is symmetrical. Since the files are
created within cat_perf_miss_val() I think it would be better to perform the cleanup
in the same function. So, keep this cleanup but remove the call from run_cat_test()
instead.

Similar for the cleanups below ... could you please keep them and instead
remove the duplicate cleanup from run_cmt/mbm/mba_test() instead?

When you do so, please be careful since it seems that there is (another!) bug where
the cleanup is not done if the test fails.

> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 8968e36db99d..b3b17fb876f4 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -139,7 +139,5 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>  	if (ret)
>  		return ret;
>  
> -	cmt_test_cleanup();
> -
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 1a1bdb6180cf..93ffacb416df 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -166,7 +166,5 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
>  	if (ret)
>  		return ret;
>  
> -	mba_test_cleanup();
> -
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 38a3b3ad1c76..a453db4c221f 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -134,7 +134,5 @@ int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
>  	if (ret)
>  		return ret;
>  
> -	mbm_test_cleanup();
> -
>  	return 0;
>  }

Thank you

Reinette
