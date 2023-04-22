Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6B26EB638
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjDVAJR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjDVAJP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:09:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68F22135;
        Fri, 21 Apr 2023 17:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122154; x=1713658154;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GGPwTdDYMCT4zFv31Iszy3AQNI0iGsPu2NiMGbqI6Ms=;
  b=AA7lLkc5GKxGfvJS3Q8QSG/ga/IINg1OUprPZDIKZWtfzBYPWJamncC8
   m6P+E8oyJKBVbEMQdjASLHONi8Ono6hTotFSpMbTKd8IYhbnk3P7k5t/I
   cRJRuRUFbM0n+fZnoAODCeyNP2Yo87fO96w1LWulKj5ZPrVv9kr4jwIJu
   ajm8nwFYeUqhZlI9ulzX7yJMTI341g+kqGNy4qNBypQuAnirF4fvy/gji
   WVact9fFa5vh/ELSQCXu3azewZJQGuyOTS8d0pk0jqpXp0JnqcNUXgQP6
   kJVWRY6DrXoRdFEPK2Ju7Jqg3don4gVZ0vgGAHoG75VbilrcvyRC/duWR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="411380551"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="411380551"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="866852616"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="866852616"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 21 Apr 2023 17:09:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:09:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:09:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8Ywmhd46SHEDxHl9zkAidiUu/eBXoO3IF2TqQ/B0xNBeHTeWAVvfoDmeJyau8KnK7Clu+7iX8oGJuPmYFZL3d5pphrEOHPPcKtaQAdBsrCIEf/4+EV0smONsJcxQdRRWtrB/DUZyf02Lab5wyANc0xBx2BNLrzpaGapi5OgJ53oinDin1ilnp+rOPu2WwtqgzRS7nttgUDS315Vo5tQA09EJIQmt9R0+V0zJLhJfWdKG7NAPx6gS0oCK0glozsUu1I4sSpAHdKL9ePbrdK44IADCWtwBuOpPk+ps16ozkMefcDQRzPbUU7v97DlGgn4ooMS+m8s7hsw2koRUtgCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5384pmH6ftZAusATf/TdFd7tOl2BSkorPfmXmiE66A=;
 b=jHDPAgxfW94olNuSOsJbHkgFjD1fTYbO2sY3NWiIaNLanj31oAqKBSM0y85Xa2jZOrA5+2skMkXgK2o4Bzy3H5hyunm3pb7jLQYsttHZwty8EzvbstVqiWzPoz2tZg/9AHQ/xu9yyTxX/GJZEoKF0T79/UmBJlLIvOj1ANsIRoCq7Dj27ISrY+thmkT0eqkVso2ytMz2gq8sNbS3q8HYRbtU8BjRPdHzTvemHHA1hSlsySQe9GvaDpNIMAelRMLXdSsdU9+XDKH9DqLZS6ujJu3beIj0NAI3jlL3Oac0Cloqqszqt46uLCXvNCAsZ1tIXDNmIEvFapvwf/OcuVy0Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ0PR11MB5937.namprd11.prod.outlook.com (2603:10b6:a03:42c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:09:12 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:09:12 +0000
Message-ID: <74cab34d-767c-aa10-807d-3cbab7907ca9@intel.com>
Date:   Fri, 21 Apr 2023 17:09:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 03/24] selftests/resctrl: Move resctrl FS mount/umount
 to higher level
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-4-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::6) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ0PR11MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2b219c-a6c1-49b0-ac53-08db42c5cd3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTPvDU0HfCx7kc31lKnQ1eBh1uod7FfLMiPGQdYrGdjssI6a1LEfzeEiuTWlf/FA3tCo6GNs9ETESd/8RYyGOPVJDyrEpxWrhyh7LR03Cxlsw9yFe+zF4p4Dz2OC05WIe4HKF7j2M4Enbnmue4t3C+gYOe4pnHOtJ6kcxe195glrC0L70Tj7C/1MbWCKGFkRhcfkf3/Fi+sIuhTDy/7qu1MW3T69Wq7q++nyBPVJOfKixoYllND/gDGXejrmn4WQPrgGq7+klUM2hNYhLv86mrxwzXivQ0fOEg35XvS7+3cQDIqEaonhmbjwb9tKIBtvgTPk3l+0OQ0P4TwK16FO9kxY7b4DCDNpISCtcn3LSMe2zwtW5paeRA8XGprEOqnCIQE0MwiWGi4fwJKTZ69x+XDAaQVxXuVSGPRy0L6pEFGf7A0pEoaVcAFtOwLNZZ66YAcjBE1ghVMNTyh1oYhE2ICQvPClIAb9y+qhDnjy1agxTRJ5PmJUqP+/SMmlwpYXOT58ieTYI/GyjdsLo7AE5rLxsGxUHfx22i3t5Lz++lsfquIS1a+mBTcBZwm5uKcoyiiaaHnkyzOq51DN+3EvxrAaTrM7j4Os+snLJnqckxuUdV5H+SEWfpn16VAWufoRtuddAIwBSTGbB4qeVqeTKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(66476007)(478600001)(5660300002)(66556008)(66946007)(82960400001)(8676002)(8936002)(38100700002)(316002)(110136005)(41300700001)(4326008)(186003)(53546011)(66574015)(83380400001)(2616005)(6486002)(44832011)(6506007)(6512007)(26005)(31696002)(86362001)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVdBSzdBQ1JVbE9PQkY1Y0hTbGRxZGVGVXdaby80OGlMTEdUY1pwWXRhbUtk?=
 =?utf-8?B?aEl4V2NkTmtOR3ZqNEJzL1hxbXZZTWRwYUF1NGNMNXFQYkEyMTZCd2hhbUps?=
 =?utf-8?B?Z2dha0RROTM4WDB2Wm9WeDhQU1JpODF2ZFlJWkpHbW1TeU1jczhaYzZMQ2FP?=
 =?utf-8?B?ZVhjZDFPekpFcGIrSWxOc3BnWDhxMHpESFJMYnc2UXNtSlBNNTgyZGxpdHVq?=
 =?utf-8?B?Z2M2S0ZCUmlPaDEwNm4vYjBLWEFMc1p1TW52MENWWXRXRTMxM0taam1YaWxE?=
 =?utf-8?B?Vk5JYTNaOG5ITXVzeVRjdEVoblR6RkVnUXdHeFJkeGFXTFIvelVRNnlwKzBG?=
 =?utf-8?B?QTJ5MUpqR2ttYzk0RVVVRTJDTkJzd1FkcHlSWDhUU2JHK0IzZmQ3UEljQnRo?=
 =?utf-8?B?VGpLQmFSeCt4TitkdURkWHUydWplUWhTajhCbDh4THdFZk1XWHFIQzR4M0hC?=
 =?utf-8?B?THJibS9TVXZGUE82TVdtRlN2ajJPdkRsb1drYTZRVFJCRlRwSlhlMUczcWlm?=
 =?utf-8?B?a3hBRytTQ09oZmJaSUg3dmViUzVjbHEyQjQxYUpsQ1J6K3d6N0o5NHNCVEV2?=
 =?utf-8?B?ckRVaU9HcUE4dG0zUmxiSWlwU1VqUXdLakgrSnRGY2IxZzZHTTJoeEFmelJX?=
 =?utf-8?B?ck9PcE5BMmZjRzRqQmpHZmo0cDlseDFPQWNQKzI3RlJCQXNyaTlnRTBNT2Rn?=
 =?utf-8?B?aC9tWTZFSE1yMUdsM0s4azVkcTh6dE4zbU1QdkR0L256Uy8xU2h3c0wxNnlr?=
 =?utf-8?B?Q0FZQTRQc2d0eWlVdmZkMGZaVzV5TWtYMllkbVArVGhxQVBjZTBsWis0NUFM?=
 =?utf-8?B?SFZsMlFxNmNXM3d3NGpLWDVxblJ0cEdjWEdRaHdubzRtRlgybTRTRXUzYUhG?=
 =?utf-8?B?eW5TRzZpM21zZ3VWbFVSS2h6dUd0VDBOZmhHR1dLQzkvNFBGdW5RVkdOZU1u?=
 =?utf-8?B?RGx1VDZkeFhRT2MxenVTbVpjRGpuNXY1b1hjT3lwNnhkMlJyL3pNeHcvd3J4?=
 =?utf-8?B?eXpQdzhURVgzTDl5RzBLL1lBMHBHNDlMR0daOHVRQW1WbXhtcEQvQTVIYi8v?=
 =?utf-8?B?VmNnZHN0SDBwdm44cU41ZHVNbC95T2FFZG9MT0ZLcC9QM0VkZEw1QWZBeCtp?=
 =?utf-8?B?M2FtaU92eksvSDkzckErZ2NaMzVFcmFsR013NXRTTXkwb2RIa0VVUHFjUmRS?=
 =?utf-8?B?Yk1KdzgyVmdUQ0V1RmxhMDJPYjlZSFVteENOdlQ2aDlXN2REYS9zaEl3TWgx?=
 =?utf-8?B?MjNrMVJoSVVSbm5yOXd6U3BpWjlySmRoYk9mVm5KMWZKTEY0QjNYU2VraXhy?=
 =?utf-8?B?YkVnaWpzYlQrcW0yK2lDY0k3cmhNcjN3ODBmUEVOM0J3UHhHclVPSUlRRisx?=
 =?utf-8?B?bVB1UlZISFQyVFBRMVA3ZUVvdFo4Q2J1YWpEVEJqdCtVT0FuRVZGTFlZVnZw?=
 =?utf-8?B?OUpoMytPcjVTdEk5bnBPOG9HUm1LRmxIOHZtNkVFRUQvR3Y4dTJUb21Xc1Fx?=
 =?utf-8?B?M0ZSSm1RRWswcURkcSs0cDEzNVNNMWY2Zi9aWHgrNytiS1dMMFF1TWRLZHFi?=
 =?utf-8?B?WVU3RkorUTB0UTNiUXdmRmdLRVV3T253RlNNOFIyVW1rSFBXdWQrTTk2T2JZ?=
 =?utf-8?B?bnZBQVZUK3JyN2l1cGYvK3RVVVlYSWNFOUQ0bWVUREN5TzBWZlIyaUh0YW1K?=
 =?utf-8?B?M1ZqVjdOdGNKUFhKM1l2NU11WXRrL3hQaEk2N2RWdFBEdThKbzV6a21VTGFJ?=
 =?utf-8?B?aFdHK21YaHVtV3hNYzNZSWUvUktvVzVFeU1vellpcURSSHIxZkVHRzdUVm9v?=
 =?utf-8?B?L2M5cG5DNC9pQ1FuSS9TdUtsOFBZNnVSREdObWdhcnh5UURzeFBDRzcyYy9i?=
 =?utf-8?B?WDFNVkh4cm9XZDlncGNOdHpVZW5BSzJLaU10U0xtVUpWMHdKa25LWlZUR2gz?=
 =?utf-8?B?cGVUUWZ4c1RHNHNsbXlTY3VzTW0yWkdoVlZ6T0lVVEhaUWJNVk9ZMGo3T2V3?=
 =?utf-8?B?R1NDNGx3TmJuUjhsK2t5V2dNN2dXM3h6bXZBRFpjMjVyRUx3bmJEU1NLUVFj?=
 =?utf-8?B?b2gvdnJaYWJrakptWjFaQmxXckVXZU9jM0xDZ25SbTEwVGtVMmRzVG1iRk1W?=
 =?utf-8?B?MzJoZExRWENyOHJUSDhmSDZWdjIvbzNxT3BhQ05QemI0RmppanR3ME9mdXJR?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2b219c-a6c1-49b0-ac53-08db42c5cd3e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:09:12.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pZ6R/ntvwzme9TduB/bU2qFxmUJC9di/XVgprGZlh3mrif0anLAueusNQa3ace4VoJUyPV3c9Toah7X1wvvLWlgzKm4zRPJW2CCz3GiBWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5937
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> A few places currently lack umounting resctrl FS on error paths.

You mention "A few places" (plural). In the patch I do see that
cmt_resctrl_val() is missing an unmount. Where are the other places?

> Each and every test does require resctrl FS to be present already for
> feature check. Thus, it makes sense to just mount it on higher level in
> resctrl_tests.c.
> 
> Move resctrl FS mount/unmount into each test function in
> resctrl_tests.c. Make feature validation to simply check that resctrl
> FS is mounted.
> 

...

> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index af71b2141271..426d11189a99 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -86,10 +86,6 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>  
>  	cache_size = 0;
>  
> -	ret = remount_resctrlfs(true);
> -	if (ret)
> -		return ret;
> -
>  	if (!validate_resctrl_feature_request(CMT_STR))
>  		return -1;
>  
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 9b9751206e1c..5c9ed52b69f2 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -77,9 +77,15 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
>  
>  	ksft_print_msg("Starting MBM BW change ...\n");
>  
> +	res = remount_resctrlfs(false);

I think that should be remount_resctrlfs(true). Please note that any of the tests could be
run separately from the command line and thus each test need to ensure a clean
environment, it cannot assume that (a) user space provided it with a clean and/or
unmounted resctrl or (b) that any test was run before it.

> +	if (res) {
> +		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> +		return;
> +	}
> +
>  	if (!validate_resctrl_feature_request(MBM_STR) || (get_vendor() != ARCH_INTEL)) {
>  		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
> -		return;
> +		goto umount;
>  	}
>  

Reinette

