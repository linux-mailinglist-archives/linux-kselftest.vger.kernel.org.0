Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C613E7B382D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjI2Q4E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjI2Q4D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 12:56:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0958C1BD;
        Fri, 29 Sep 2023 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696006561; x=1727542561;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2OugTR8LOwulU1rhalKydXvzy3pXnIdrs1D4Uzoza20=;
  b=OVb/dlSnLYgqXPtQSL8HdhHwEfe4OQbe8n0+KQp29KNE0sroBSclPL/d
   Vjxe/2uheQ92pMHPcbWOhMIqEuujY+dYxhYepyS3aZm5L075moy46QS7I
   +RG8XZwe9afNna7UQN6lZeg0Z9TqwXacDmvzTeXVIfYvJkru5JPCTd1di
   k30zTfgFqw6Ny5z1/wZ4GHr1Jn+K4VWN04S21uX7o/RHZFuEZwv34r/Nq
   fKWyCwlxBSDr7Ra3m7DsqPGvHfwK2FWL9VZpzg0FojKn0qOZzSucpU1uj
   sCXHMnP2QzHMx4QSKPCq7reNUhHKlzt45t7x45LfwLuotW0mdtY48+aE8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="385162644"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="385162644"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 09:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="893477529"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="893477529"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 09:54:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 09:56:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 09:55:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 09:55:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 09:55:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfV3MdcoDrkRGk81tTjuhyIGLQC5hcsA99qHudOhQNTP7mv5jvn3oM60KMQS4+/fZvi6w9ecz7/qE/oFqN9Z+0jdZ9Na8xoz9MT4FTBk0K8KIZRMBE1CHJMaRTVqW/QNHN/U+5KZJX9RoCEFqf4C44OGk4zH1fuUS0Ps0xBnsC8Az4BrFaoVbNuxpFLrnsr0VbC5WzTq4aSsWyInoxTgBEWTimj/mjWkWjNzcWnssdMEKics2fjz7P7nok8kfExmm3L+WZimUkf7bdaxSTVMGi1nWdposEzeRHuGPv5YNN0VSPl34bS0S4u1CAsGmw+rqwT7g8x1+evIrfu1vXx/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er1xSjeO+gvoS0gZmwC6mVO2HDTDF+CSSerNPThbAJo=;
 b=hv5U4LKppm9EdlDVa1ut/0nFRoFrKDfMc/cv4/ETMIMG8gJJqOMv6ACr8fbHr1C6OZxEu+Qxe+jbk2mOutL6B5z/naoQvWZFxbU0ADtQHB0nxO0RtgAf4Co7D1SKR4o8dlfpZzcVesLNYyYQcDSeYi4csdYY7LKhotvh2ASqvH8j/E1wremGTwnDb9pDZLmKisNqHSuiVKEEKZbAX/7Ne8VpFFHmATp7T6YxXUMj9yHmLfplhS5nfYMxyNr1kb1VeOrAzkpODvPE5G8S0r/wkBTJC+ORo6n7jYygWGXK3SNHzgs5rcHsGfWI+fD4Mti1Lcf6bvxQWNTKr3CUEKc67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 29 Sep
 2023 16:55:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 16:55:58 +0000
Message-ID: <e15efa69-aa12-dfcb-da65-03b8a5ce76cd@intel.com>
Date:   Fri, 29 Sep 2023 09:55:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/7] selftests/resctrl: Extend signal handler coverage
 to unmount on receiving signal
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20230929112039.7488-1-ilpo.jarvinen@linux.intel.com>
 <20230929112039.7488-3-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230929112039.7488-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: c8661fd4-7299-4139-3a07-08dbc10cf3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGES1rEpWCzvjmPJR+deD4YizO7i+POtyIKuFmPaa7MdaTOq2M03Xzrh7pEkKu2JjgnYzkeDc7KJL/KfLdLTS7bnSP4ODRhlm0LFlXgSjicS+gljt82S7a4AmGrCSM4KnxYJB7Tkb/quEFhjoBTAihDRpyf3EoayORf4TlvpFN9G9stFAEL6ZBolNRXU8rGbibm/KloGLCXfyXy+ZcN+eXqQmyT1XxUPefYoo+cmMh4kGZRnVChM+crNAxzxKPQUdRYxDk++Y/u/dOcoNsjWXMoUhUeV/hBIIwhp4UVLwCnPfRzgX2j7WGjSNjAe9nH8yn07NICf/+BFPtMXru2yJHiOuS4vI8OZIVLLfStqHHCTEkUKCDbUm1/HdefBshFhFjhlFjq9jZcVJcZWsG0plHqhHVzCgrJT24YNu1Wl7FrPCIyDTSTyeSC43Cis89PS86rZNAgqByInSCxZ/aPdpwKxMmYSuTuu04G6xNPtDHFmP5yM8gmFb7QlZgYbYUelfQ1o8ca1zsT+5rpGijv5iyApZM1Cf+UQRTQfT6lRbiS4sLnDzYQCpfVcnD8iAWy4CGgRNVzwRA1/2Uo7DTOsOxFI70Sd6y5HW2e0adZ/+iMkscFHvmUunDS6UJ3B1VyKPCOyTS7f3THtvcJhdEBEag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(41300700001)(66476007)(4326008)(5660300002)(316002)(8676002)(8936002)(110136005)(31686004)(66946007)(66556008)(44832011)(2906002)(6512007)(82960400001)(6486002)(2616005)(53546011)(31696002)(6506007)(86362001)(6666004)(36756003)(26005)(38100700002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW9aZkg3dXBHYWUvaFRveXFTK3p4S3ZZanRSVlJabWl4eU5LS1hsOW1uZmky?=
 =?utf-8?B?Wk05T1VsUExIdGdjMWd5Nkl5R25CQUY5YmJ4SjdLa1lBTmxUdXgwZ2FVVHAy?=
 =?utf-8?B?Y0N5Q1IrT2RYa214eGJYRG9HMmdpejE0YXpWancxTnhLUkFHd3lGUG1JZGw5?=
 =?utf-8?B?bnE2YTJxbXgzeWpSU3QzbWg4KzJNa216ODJieUpCdlZZS2pVYllRb3NxdjVR?=
 =?utf-8?B?blFjK2R4QjhDZ2ZFamlzcHFjQVRmSDdaMXc4U2Rlbk1Kdlpxb3VyOTYzTzhy?=
 =?utf-8?B?MXJlVGZYNzFlZm1xU2hsTFBITFZtZXE5dDBEVkxPMXRoZnBZRkxLY0ZWeGsx?=
 =?utf-8?B?Z0FXYS9SWjFzWmRNSC9lZ3ZTMWg2L0lyakcySkI1aGJJUUxCeFBST2c5bUtO?=
 =?utf-8?B?eEVlenFhbXdDR0R6R3llRHNnTGlsTzVBY2VLMUZXT2sreVdTdkxhNStWZDQy?=
 =?utf-8?B?MkgyZ2xMTjhkRlpxak5weXVRWnZrdE13VnFqYVFqQlJzZU5VeTZxMStPREpW?=
 =?utf-8?B?YUtXR2VSUkQ4VjRyTldCdlc0OVN6MERWVkJjcUlxdllLL2dZc2xUTzZOWVlx?=
 =?utf-8?B?eDB0VDZnT0pmSmRWbUFtY0dhcDE0V1BBUUhnamFldUMwd0h0Y1AwL1ltZUV6?=
 =?utf-8?B?c09ZTFdiVytJenYrTndpbG9lZGlwTEFsRFllUHRJbk83b0JId3E5Qnp2ckx3?=
 =?utf-8?B?UlZxU2dnZHo4aXZzVlBjd1cvUkRmYmJYa3JUcHZUWHhWdG00d1ZmUjlmSURx?=
 =?utf-8?B?WDZXYWJ3aXB5eTNHYk9BVXRqNVlXNEVVaUJJSkw4OGNxcTVwdEtWVHoxS0V4?=
 =?utf-8?B?aGgyV081MTdKdHlMdjN6LzJQWTZ2eEpDeDVqNW9mdkFJT0QyQU91TG5OcTB2?=
 =?utf-8?B?RzNjQUpKclE2cURReVRnK1BubjRnT056VUkzdVZlcGZrRFVhNVplbndKd0Nl?=
 =?utf-8?B?dEczelNYakZYTFlLK1ZHMzBwYjRkdkt2bmh3R1lVbWlMRWlBK3dPVHlpRzdt?=
 =?utf-8?B?Zi9GMW9teDNZalNpTlk3RktEZk9qZ2VPV2JUQ2dyN2xqME9aZUgwYUx3Ui9C?=
 =?utf-8?B?WXhjTnJsTVJ1Qmd3anhFT2VIWGlxZEtVeGRnbVVXcm9WdHhleDBGOTdZQlFN?=
 =?utf-8?B?dkVESHNROG1paFR5KzhJT0FuOEFOamxsa0I2dzhoLzliUllwYzY3SEcxYlRo?=
 =?utf-8?B?QXh2ZEJiMk1SNE9jZStHWWk1Mk5HKzZzWXBhbTVjM0Q4bTMrenY2bWpob3Fq?=
 =?utf-8?B?UFR6blI5aDVxdkp6ck9UOTlVKzlSYnBxemUzSzM2WW1ndXp2cHo5WTZ0QWtS?=
 =?utf-8?B?NnZWa3c2d09lVkJVdnZJa0tSYXNUUnpYeENEdDlxenJjVnVYUWZUVW10SE5t?=
 =?utf-8?B?dWVQTW1ieXo1VzZGOURvVVZ2RVNCQ3V5ZUVCblFlemoyRzZ1VmkxZDA2YmdT?=
 =?utf-8?B?aDVPanNRMGxOdTlaYWVKd3BMWjJpUUZLUTRvb3BRcG9qZHR1c20wd29FeXI4?=
 =?utf-8?B?UjcrdkdjYjM5Wk05TTBTK3J0SFArNDNpZWFrVnhFYURkSUhjd1drS2s4QzZt?=
 =?utf-8?B?Y1BseVpiL2ZCNFhUc0lHY0ZML3VQaDh5NXN2K1kxZzhUQzE1N0tDQjVmVk04?=
 =?utf-8?B?ZlFDdDh5aTFONFdDenVGb3AvU3lOSHRMeUk3a1lvMTd0bDU2N0tyeTJvaHlu?=
 =?utf-8?B?b0tCWjdGa01GT0ZvOXJuOGVkQm1NYVBMSk9YVU5Nb3pJbGxicXE5VWlrMitY?=
 =?utf-8?B?ekZISmZtU0pVOHEwRjBxYUNvakhOYXhudWRERjdsSTJVV0ZRMEFLcTUrS2l2?=
 =?utf-8?B?MU14WUJsYlBLbEpMQkdsTlFpZnhaSlZxQWxMVDFCb1JCQ1lVNTZlaEdVT0dp?=
 =?utf-8?B?L0Z1UFBjQTdGOGsydE5EN3IwK0ZnbWx5WmtHZVZYQlVtM3grYUViTlZkcWtV?=
 =?utf-8?B?OUpCa21QUTJyOUtCVDcxQnVqVHM1c3g2SS83Y1BRczVPWHoyaFQ3dG1PWFRO?=
 =?utf-8?B?dEhoTFd0bXE3eStwTENSNU1mKzBDbFdnbDc1UlpnRzJRei9hUjdaUHJjY1dR?=
 =?utf-8?B?NDFzSzhwUW14UnRlT2RPSWFhQzdyUTFxK2FzWDlZZzZlT2RTZUxUQVRqa3ln?=
 =?utf-8?B?NXlhRGdKVzF2Y01iNE1nczIzdTJHUi9jUGJMMm9XWUNkQWM2SFFuT0pBZHBk?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8661fd4-7299-4139-3a07-08dbc10cf3fc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 16:55:58.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gf04EDB6K8Cj3RM+sIVxNHivEcUU0voXrPzhGlW2bLPEca2Nq+OVV7yBzkUr4cLNiYAiNAT2ui8rEHXgbO+AK1TmeDjhX+tWIwgHf0HhMz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6469
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/29/2023 4:20 AM, Ilpo Järvinen wrote:
...
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 823672a20a43..4eab2fad97fb 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -67,21 +67,45 @@ void tests_cleanup(void)
>  	cat_test_cleanup();
>  }
>  
> -static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
> +static int test_prepare()

Please change to test_prepare(void) (checkpatch error).

>  {
>  	int res;
>  
> -	ksft_print_msg("Starting MBM BW change ...\n");
> +	res = signal_handler_register();
> +	if (res) {
> +		ksft_print_msg("Failed to register signal handler\n");
> +		return res;
> +	}
>  
>  	res = mount_resctrlfs();
>  	if (res) {
> -		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> +		signal_handler_unregister();
> +		ksft_print_msg("Failed to mount resctrl FS\n");
> +		return res;
> +	}
> +	return 0;
> +}
> +
> +static void test_cleanup()

Please change to test_cleanup(void) (checkpatch error).

> +{
> +	umount_resctrlfs();
> +	signal_handler_unregister();
> +}
> +

With the above two reports addressed you can add:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you.

Reinette
