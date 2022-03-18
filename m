Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A37E4DE225
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 21:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbiCRUMi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 16:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiCRUMg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 16:12:36 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F76420827E;
        Fri, 18 Mar 2022 13:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647634276; x=1679170276;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/yWvTRnDdXaa8rHxI2jm4rs2DJZD6VPjYml9fmFvUg8=;
  b=Gx8IX2sFLhD12QDnAhqRNCbHMIfR/vb6SOOfDbGBZfWq5+y1CL+kcxBN
   jlqvlR/Q3kPVsCd2U7IiZ0pXUNB8xFUCIq5Ejo1i5w9A4Sv0ALXJLNhNU
   b4WWKlmIH8L+SXhC0gRcLExdehgJ+rfLRHGMVUeZ6qD0jFnWW/HtMLlDi
   p7LmtDfjbzm5O0PWMC+DiD5pYA5OL0qI5GledVcP6nwaOLr16nA8zD+Dz
   rOxJm3hk+fpS3mpi6eH7Bf/DZIaWKsh/ARHQDUfa45KCv5J/fcdbv4SIQ
   DSIDGjuNcsxyTY2EPHwK7+g7YAnkuwVLm4drMogjvzRcrx+YseQUUtGAc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="317927259"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="317927259"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 13:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="599634782"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2022 13:11:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 13:11:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 18 Mar 2022 13:11:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 18 Mar 2022 13:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebMxapqjSt1euxg4AMqN8kKfAeLmuEqFMzt4IWPOR9TVG0D01YNw5btXZ3HRnlh28wzMzucNnot3GY6NsKlvaJCO/JuX2yLPvgFrNVK24qNH/pa4/E7dm9xsH27urSzG9i7sfdQg0bEnQYzHZC+c/qMAtV9zqx5E8ELr1kXyZTdLmre4LhYQzt754+Apnl2msR3fo9tZpHT4oftc8l9Imv9nptOqOhMRnLIPibdWm26O5qMPIGS3MfOhMoKznunzBdXxxBNPxjtIfyhlHRu7wm+g7OiabiRt6rEkkGKsOrqSn+G8rBCQUWcpNIL2uvel+1qhuA0HoOKDfgeUdTmrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOaW4kIj54w7HYhPcaS6ZehF7FfovOMqlsCX26foD0M=;
 b=V1m8rvwIFmBnD1/ZSYFI4Y6GssCplh5glqn/AWgjmqXUc+hkbVwiJwBdeMmppY6boN5mP5I/VFgIVYSFlPXW5PVLDhjTOzEUv5+XbWyOLHXtYb+rc4wF2XOE+3N3LkdA7wtev1ICmlPvod7H0SRESQGXKwp2Wnmzh0JOgH6AB0dGlasY929CVqHxdV6Mu3UgATPW9s2+i4IY7nWfYvhTOg9tBs1x2laCdFhyVwULxBcHfLWcqtlvMiK8gtpv1i7ITuosX+x6sfwLIXqRmC9v3fANZy7Ot5V+jdMRIUrN19DQi33NTT7ibOaPV1psNXu14+f8e8o+sYpFTT26QPQe3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM5PR1101MB2299.namprd11.prod.outlook.com (2603:10b6:4:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 20:11:12 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 20:11:12 +0000
Message-ID: <b04e184e-23db-62ce-288c-54fe482d6265@intel.com>
Date:   Fri, 18 Mar 2022 13:11:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/2] selftest/resctrl: Extend cpu vendor detection
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220316055940.292550-1-tan.shaopeng@jp.fujitsu.com>
 <20220316055940.292550-2-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220316055940.292550-2-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:104:1::30) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36b54850-a315-4b9e-b002-08da091b7271
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2299:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR1101MB2299EB9665F674FEF88E23D7F8139@DM5PR1101MB2299.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b8HPROgxW+AHeMw94lz6C3/QUFiNy2O95qqwkxuOAa8ZZv4qybrQcgf+JLx8s/VrFKk6+bI7kFXURLG0CNnou7EaL48NLVGsMypnzExxqnFFuyVZ1JF9ghK+OYbX/BiALZ2qPFRQuYR/SOdvPXGwdlJuz4oEojJx0gJ5rtDn0lRffYEZiZWJRjnXYzCH1POPcX1MMZiATYajnrsXkeZEPrNyItF+AJ1hRaWidfE9m23+UhjJkIJPUUseoX2Z0blT5ncxUJh6J7G+92AtI7VHUy2/YL3zfv4RmUjc/Bu3XdoXVwmkL35OZ/TO5YGRaz5H1bu1ICWvfNLlh8hqflPYeeNWjReaqPoqgRiFbhd2ndPwsMpPPz320ts6KK2Io2Muqx2uKDnYcBTEwdu6bf53DlG90gXh8+4Gjj77+ubWXAnq+2Y0sP+yiPzEx1XoyXChEev8tQPg6f2h1k5n8aUHp1DlhIbvj+I+4Lau+Cniw6d4yDpo4FNOPMe9AokKf6NJdS6/apA7T34GeY4ISpszFHQXcNgUD/lxCopyBzRBs4FePw5TeIgZIm2ooHPWBlPvh/Rmp6nzTR68ELp6GqSMHOBZot6akHkKbMOTJW1RXRr7I1yF5XYDINJeMNC7OUtGaY7bxFm8idVoZqJVNQeBplV2BpKjaO5wOag64UA5A0l7xvC+riwkdkwyUFcexWl8q0c3FoWJ76ZB+CyBs4ESUyd7e7gQJcZPoJpT8OuFZYV11dfbZfY5n0yM/fL+v/8w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(5660300002)(38100700002)(83380400001)(2906002)(31696002)(26005)(186003)(86362001)(66476007)(2616005)(66556008)(66946007)(82960400001)(6486002)(44832011)(110136005)(508600001)(36756003)(8936002)(6512007)(31686004)(6506007)(53546011)(6666004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFNSXBVYnpBcDhhSGlXMWNMWVdYSmVsUmJ5L0JLWHRIVmZOTkZOdUFDWkFG?=
 =?utf-8?B?SmtYK1RmQVNvNVhWakNIbUhlWDFNWEQwRmhjVXBpRlhJVmkxbDZ5ZTJKS1pB?=
 =?utf-8?B?WnRVZ2Z3YjZzK29IUVY0dG9abTUwUEo3OUU3THJyTFVFQi93bzYwWXdTcVd6?=
 =?utf-8?B?Z0F1Um45TGRpYXQrUkNTeWsvZ2ZjR2JiVXZ4ZlNrY1lta095TXNicHVBRFZT?=
 =?utf-8?B?d2VWV0R3dHRvWTU4Znc5UGN5RmdQNEdYK2RIQVo1aGZ1a3E0ZTh5eXNsNEh5?=
 =?utf-8?B?elpad0trbG51cXhyaW9UdjYwcjRGSEtId0o3ME5rcDB3R1ZJRW9Ea3Y1aDNP?=
 =?utf-8?B?K1VMUHBTSWJyNDkxUXc1ak9FcWtPWEliV2ZWK3dhMTYvQXh6dVFhTkhLa3pk?=
 =?utf-8?B?NHVsZUdvZ3lXRy9Xamt3NUtsRUI2TmFoUjEvQkdaSWFGV2hORFcvcDB6cGpP?=
 =?utf-8?B?MWpRV1JmdEdiQm5PejNyNUIyY2Qyd1g3ZGZJUUdSb0w5MHdTMExRTkM2WWRm?=
 =?utf-8?B?THVvQTQ4YVpNU1R1cXhFZ1EwV3Iza3lEcFVST3FFTGVNSHA5bnlCY25RZEdo?=
 =?utf-8?B?VWtMWlF4eFFZQ1d5cjlZV2RSdXlwSDZzY3hCVktwcjF6eUo4QUxPbG56MEFz?=
 =?utf-8?B?dUlkdlpIajJidHRMRE9raUQ3VTlOZVdFVWUvRDRwRmhNTlpnOFYyanh4dk1Z?=
 =?utf-8?B?MDBCbzFqWEphakRsOEJ6ZmRaenloNUdDcDBpbkczV0dUWGNuQnlrYndYTVFM?=
 =?utf-8?B?VENzWkRqV2dNNk9MK25PaTlaSWUrM3dYY1V1bStrcmJ6ZmJaeXczUU5rNGwr?=
 =?utf-8?B?QzVVelV2YXA3eDFYb24wZE1rRWxhZ0VoTWhWblo0anFTdks4U2FHYzl6QlRL?=
 =?utf-8?B?TEZRekZtRWZVNmxjcHJkMXBGTXZjU2gyTEsvRG1nTXJNZGtSNnc0ekptKys4?=
 =?utf-8?B?dTZTb3A5VStLSEt0SGxtTFNVZlJmN2pHMzIxdmNkSlpkZUMzZEVkNjM3RVFy?=
 =?utf-8?B?cFU0d213ZW9acklHcUFPMmRJL0YrTDd6R2NVMllKeDladGlBTHJXclNVZkNm?=
 =?utf-8?B?SWsvY1lTanJ1UC9YR2FlcEdnTXg1aDBZbXR0REJkc0NQOThHMG5KOEFqSGdo?=
 =?utf-8?B?SkpFOXcxb2JPWDVJRzNSQnNmUm9ZaUpOVitmN2FyazFsUWV6cGJFVVd0bEVV?=
 =?utf-8?B?MjJVVXBnbisvaG0xRXFFaVF4ajRqbTlmQ2tYelhzT2M1ck9kWGUyaWo3TGhi?=
 =?utf-8?B?ckZKbzRnNjU1ZnMyWENHcE93R0FhTkZibGY3U3NxREl0elBpREF3NUpqUUcz?=
 =?utf-8?B?MFQzUUYrMnlUYkVFWHJLOFhJNCtxLzNIWVFRamJRQUgzd2FnV3JiZE5zOWVO?=
 =?utf-8?B?Q1hBRXVkNmVUZ1krNTdsRUlQY1JJcjlnR2FVamJTOWdaSTNKOGtVME94Q0tG?=
 =?utf-8?B?RVE1c3ppSlczdU1KdlJ2Mk93MUVSdWhXMG5CYTA1M2NqUWdHNHIxRVVIRzZX?=
 =?utf-8?B?SnFQUWl1VVo0VDBNL20vblNjM1hoaXVLS1VEdE8ya3doTG9GRi9jWUl6RVF6?=
 =?utf-8?B?ckFZOUx6K0ZSdUpzVERvaFJPcExJVGgyc1JsZFlEbXFuYUxMWWpIbXgyWWpG?=
 =?utf-8?B?MUZOQXA0aGZJMmVVcVdqSnllNUVZcWFOY3RkNjZ1QTR0N0JXTU1WK1UyUUpG?=
 =?utf-8?B?TXJ4eEwyM3FicWtlOGNNbjNUa3lLTDY3ZE45d2VoQnRpVENSRU5iUjAwZ2pt?=
 =?utf-8?B?QTVZc1pScDd2ejlJSUtpTkhLNWF3bVdIb1VkQ3hWbjVpL3AvTDRLM0M3Zi9a?=
 =?utf-8?B?N0M0bHArRkk5TEtHZEFDT2JmSDhiWms3T3I4eUJYdlI2bjNzL0EwV1JtY0VX?=
 =?utf-8?B?bTBNUjBCWW8rd0RsYktJWUwrckpIbmpuNDdoL1Vxd1A3anNNQ1VFZUVUQmcz?=
 =?utf-8?B?QzJLMWtqaVB5SW9UdFozMWZWUWY3cEhKUTRML2RXSi9KZUFOU1pubm5oMmNj?=
 =?utf-8?B?ckZyTnlpZm5RPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b54850-a315-4b9e-b002-08da091b7271
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 20:11:12.1259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSIUoO58z8KDcYoBbyVIBOzEii7TropNL/1845pD7esbt9/H/SoM5Mu1Yq4Eg0ToQ+z/9F1fHbXKjDAXXQUp5+F4xP1KkB3J7EQ/5k21jms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2299
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

Thank you for adding this change.

Please note the typo (selftest vs. selftests) and capitalization
in the subject. It could read:
selftests/resctrl: Extend CPU vendor detection

On 3/15/2022 10:59 PM, Shaopeng Tan wrote:
> Currently, the resctrl_tests only has a function to detect amd vendor.
> Since when the Intel Sub-NUMA Clustering feature is enabled,
> Intel CMT and MBM counters may not be accurate,
> the resctrl_tests also need a function to detect intel vendor.
> And in the future, resctrl_tests will need a function to detect different
> vendors, such as arm.

Please take care of capitalization for CPU and the vendors (AMD, Arm, Intel).

> 
> Extend the function to detect intel vendor as well. Also,
> this function can be easily extended to detect other venders.

intel -> Intel
venders -> vendors

> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c    |  2 +-
>  tools/testing/selftests/resctrl/resctrl.h     |  5 ++-
>  .../testing/selftests/resctrl/resctrl_tests.c | 41 ++++++++++++-------
>  tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
>  4 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index cd4f68388e0f..2daa63991628 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -89,7 +89,7 @@ static int check_results(struct resctrl_val_param *param)
>  
>  	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
>  			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
> -			       !is_amd, false);
> +			       (get_vendor() != ARCH_AMD), false);

These parenthesis should not be needed.

Now that you add better vendor detection it would be clearer to test
for Intel and not "is not AMD".

>  }
>  
>  void cat_test_cleanup(void)
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 1ad10c47e31d..f0ded31fb3c7 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -34,6 +34,9 @@
>  #define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
>  #define L3_MON_FEATURES_PATH	"/sys/fs/resctrl/info/L3_MON/mon_features"
>  
> +#define ARCH_INTEL     1
> +#define ARCH_AMD       2
> +
>  #define PARENT_EXIT(err_msg)			\
>  	do {					\
>  		perror(err_msg);		\
> @@ -75,8 +78,8 @@ struct resctrl_val_param {
>  extern pid_t bm_pid, ppid;
>  
>  extern char llc_occup_path[1024];
> -extern bool is_amd;
>  
> +int get_vendor(void);
>  bool check_resctrlfs_support(void);
>  int filter_dmesg(void);
>  int remount_resctrlfs(bool mum_resctrlfs);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 973f09a66e1e..dc548d3e2454 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -13,25 +13,41 @@
>  #define BENCHMARK_ARGS		64
>  #define BENCHMARK_ARG_SIZE	64
>  
> -bool is_amd;
> -
> -void detect_amd(void)
> +static int detect_vendor(void)
>  {
>  	FILE *inf = fopen("/proc/cpuinfo", "r");
>  	char *res;
> +	char *s = NULL;
> +	int vendor_id = 0;

Please order the declarations based on line length from longest
to shortest (also known as "reverse christmas tree order").

>  
>  	if (!inf)
> -		return;
> +		return vendor_id;
>  
>  	res = fgrep(inf, "vendor_id");
>  
> -	if (res) {
> -		char *s = strchr(res, ':');
> +	if (res)
> +		s = strchr(res, ':');
> +
> +	if (s && !strcmp(s, ": GenuineIntel\n"))
> +		vendor_id = ARCH_INTEL;
> +	else if (s && !strcmp(s, ": AuthenticAMD\n"))
> +		vendor_id =  ARCH_AMD;

Extra white space here.

>  
> -		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
> -		free(res);
> -	}
>  	fclose(inf);
> +	free(res);
> +	return vendor_id;
> +}
> +
> +int get_vendor(void)
> +{
> +	static int vendor = -1;
> +
> +	if (vendor == -1)
> +		vendor = detect_vendor();
> +	if (vendor == 0)
> +		ksft_print_msg("Can not get vendor info...\n");
> +
> +	return vendor;
>  }
>  
>  static void cmd_help(void)
> @@ -207,9 +223,6 @@ int main(int argc, char **argv)
>  	if (geteuid() != 0)
>  		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
>  
> -	/* Detect AMD vendor */
> -	detect_amd();
> -
>  	if (has_ben) {
>  		/* Extract benchmark command from command line. */
>  		for (i = ben_ind; i < argc; i++) {
> @@ -241,10 +254,10 @@ int main(int argc, char **argv)
>  
>  	ksft_set_plan(tests ? : 4);
>  
> -	if (!is_amd && mbm_test)
> +	if ((get_vendor() != ARCH_AMD) && mbm_test)
>  		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
>  
> -	if (!is_amd && mba_test)
> +	if ((get_vendor() != ARCH_AMD) && mba_test)
>  		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
>  

This would end up running the test even if vendor detection failed. Instead of
the negative test with AMD this can be changed to only run the test on
Intel platforms.

>  	if (cmt_test)
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 5f5a166ade60..6f543e470ad4 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -106,7 +106,7 @@ int get_resource_id(int cpu_no, int *resource_id)
>  	char phys_pkg_path[1024];
>  	FILE *fp;
>  
> -	if (is_amd)
> +	if (get_vendor() == ARCH_AMD)
>  		sprintf(phys_pkg_path, "%s%d/cache/index3/id",
>  			PHYS_ID_PATH, cpu_no);
>  	else


Reinette
