Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E598A339727
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 20:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhCLTIk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 14:08:40 -0500
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com ([40.107.93.48]:43361
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234107AbhCLTId (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 14:08:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSfZyu5M7tbRt62GFNqYHv02CJiiLYVYg1/uTO0GtxBbaO79OT62uwXnjCdGbPAIjQhkjPKg4Ye5BseF7bvA9P6bQojUwUbs1swQDT9g24CQkwO3MMPsVmSCOZr2HEFVQ/tkj2CewMxpMxOqIWa9M3T8zCJBazLf2L0cHNfqkseHGuSCxQmLmzcqTAdzCCo890j7bIKxpmb2FVCvOHu2+gbe/MROOuYebP4AxHSAFKAllDBdKu37ALrz0mB3jiaoGtI6syxGaMyFX2CppoMJxOOyMDQQWlCkpdTZj72hKqlY7U5oWpLIFxo4Ot9lWTE1mkKxMKKUSzG1IcAePrpbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IG6s0ovuJeMbsQDAecKbHN4gShOUwn/gevZRoUsRxUg=;
 b=UVzpdrespNCn9EDownH0S+LivKyDx42HENUwDA/W/rbPJziJfoh2ptJrbsSOsHXgdXnQqggTjjeEX38tgtdhuC0ciD92jkq7IG1xQapdrg3+mM09IAa6BYogxOxYjkDyqNyyij9C/9BgHcqZY2i9n2rnbX3s/n8vlQ7/UDH4fdSy+8T9fjKxrdaiJDOOvZmSpLT6oOURTKUmwK4apzWIQxrjK86TzgQVU6+PNsBwCb0alJwE6XQTTFlGEzmlxk0kflFIHK9t7Xwkoc3b4hb7wXPopQ6UcvneNVUsEjjJ4eRPQbOM+z1OmFIAP+J1saVRzbR9ZNHXdlYKQSNoINVPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IG6s0ovuJeMbsQDAecKbHN4gShOUwn/gevZRoUsRxUg=;
 b=4CwDscGKgjCdgNBcNBGRYr26/51mW98P1GURLGVSzuhWLHHR4p4gJQFjBNeGd09FR84rn8PZU35x/SYss0b2zcPnWyX8EtTHC7nrauYzYEoNGiev4ZFTisl3UWxC9fJhoJyXHeWd6/u53mEQFAZuH/QhesAACYr1oJIb71buRBg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 19:08:32 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::20cf:9ae4:26fb:47b7]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::20cf:9ae4:26fb:47b7%7]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 19:08:32 +0000
Subject: RE: [PATCH v5 02/21] selftests/resctrl: Fix compilation issues for
 global variables
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
 <20210307145502.2916364-3-fenghua.yu@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <bf2efac2-99bf-5b58-8952-db9291a1eae1@amd.com>
Date:   Fri, 12 Mar 2021 13:08:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210307145502.2916364-3-fenghua.yu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN1PR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:802:20::27) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN1PR12CA0056.namprd12.prod.outlook.com (2603:10b6:802:20::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 19:08:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8a7cc6c-1bb6-45b3-9663-08d8e58a3a46
X-MS-TrafficTypeDiagnostic: SA0PR12MB4527:
X-Microsoft-Antispam-PRVS: <SA0PR12MB45273C55F91C19D7587101FF956F9@SA0PR12MB4527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:50;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +2mCF348GY7EecaiTdQO0ROvIxeO8R58z+nrkL4BPaIQi2V2r11Qvzrw62MWKkMt8f0u1ouobfdw+vOeVYFXVg94tSTeEheTqVQ7wd6rpK1FfNEpTQ7e+Sma3xt4wuU8BFERKa8m+g8DIlp7A58oN7UGMjku1xx5JBmsmNjlVKn7lj2NC2BzFpFqtLU0Pxo8a2RNfJ3CypKaPgMLKnK2R5OxYiMYV4oIIRE4y9uMi+jyui/8DgNFp1lJ8Y3RePqVAQvVdO1CzDCLNnUMvJ3Mkeq5uNVIVv+ylwcaQvHMTHJ9tvA/6JkhBmtGPH/B5gCgXyXmaMI+7+83ikvDlbvqsi+fKSTUj+sOF5puNvcJm5Z5cIsqU5aBBLKoC0qZMfN0Mq4AyRI+HuqCB0TJPdqTmKfkAtEkUy+I4KKtXxWI1YGbudclOg2mDgN2/fsfpcWuEtXBHNfnm0MHvLShxikqHA0lzxntjNM0Gt0vHDXAfzdjMBzJzYvS4HxZ0wnJSuX1BQETyKGbBlzRJmytfKuVG9QYF2KIgdmuMI4OYAbMfeQvPuiJBlQ0TLwDK1Av/ZgRx/kc9PmU0+QDQBssigjnq/htrtxvMdysY1ifDrT6at5OxiNqKYp03F+32di9wVWwX4dlzVVpnTBobsVJhJgbJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(36756003)(2616005)(66946007)(8936002)(4326008)(478600001)(2906002)(66476007)(186003)(26005)(83380400001)(54906003)(66556008)(52116002)(6486002)(8676002)(31686004)(44832011)(53546011)(86362001)(31696002)(316002)(16526019)(956004)(5660300002)(110136005)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?mpm07Mf2uZz92YBxsxUclcl0AqaiyIU0xJZkbPC0c2aCWMmOGd/y8DRm?=
 =?Windows-1252?Q?gKGX4xluEqalUgZRsmdIQ/x81ykIgW6vrvQA7cCdLzz8KNbklD1Rq4YO?=
 =?Windows-1252?Q?m61IX0/hCIRMYdbqxNo1L2XxxK9GSOA7l+5Ryvvru47fTVLl7nKqyIOw?=
 =?Windows-1252?Q?jUoaSKsQBMt1d8mSBupSyNj3d7ZMmaGsneaF7deBxHrpggQpHIv54uu8?=
 =?Windows-1252?Q?Ev0UKpHFm9QqkvYUXcLay3DOj8V97K9OUdwkiHDvoHyWb34X5JIWQsDU?=
 =?Windows-1252?Q?6yShHH36jFa/hsFeyF2BA/IUs8EGD2nh5itYLcNEigsTT8Ph00y7pwM0?=
 =?Windows-1252?Q?NCwKPck8Cl9HwR5ZYyreqjvOYP0lvaEXBiM4kffiq9AbKdx+e4QIMmXH?=
 =?Windows-1252?Q?/dkO9msZYoTNQM+Vu+zKtvNyX7aLwLvxaNGoaAid49k15L4ie9ea38k7?=
 =?Windows-1252?Q?NQlUB3JuKbTMmVos0p8eUY4v+lfnTT+/uso/7TNIhwP4G73yzVv9hjOJ?=
 =?Windows-1252?Q?7kyNSPpW43YlHnuEZWmoeltXQD+Oezk5nQy84oXqVXLZaLM2+aQjVCjP?=
 =?Windows-1252?Q?4reR4JxQZP7SEh2N/FsRtt+JVYRWqwHDPHbCVaWOEdcDrbfY+YLyZHqw?=
 =?Windows-1252?Q?VWG51IdDr007zOtfnIUi9cgHny8bsm2T5NiXVOC1V+t/1LoHeTqUVROT?=
 =?Windows-1252?Q?qX8Qagh+WLkmQJkGrmzJLucKvsIEbW75T3LvF6RH3Lib0S23Ner6POra?=
 =?Windows-1252?Q?/HqmbL1bcT88XWzmeXpRcZZx9P7p75qeTPlRlMkxSb3Oe5eZXUk+pFZz?=
 =?Windows-1252?Q?8TIgZW6i0MrW8MNj3GLl5uir0sOOgEMxgjDvag/totwsbX5dh+fgTBFK?=
 =?Windows-1252?Q?YRV2AeHclBKER7E+/V7AEMfqlR8XU7rniSplFOwTOEsI90RscQM91gQq?=
 =?Windows-1252?Q?6F46x6oM8uo5GADcfOYuco3F5j5u+CbZ+jCxCxLcAHkHe5tNllabVAcE?=
 =?Windows-1252?Q?8TeLv/FPHW12CZp5QITvUPsVQenJO/MPMjz1KQQ6tqSaq/hS1vfocDuC?=
 =?Windows-1252?Q?GSRMO2bjFuMLgzIYwo1vKA9K9BTQjVR4LqcIWkqnlfQTZLnMWaG7zBjV?=
 =?Windows-1252?Q?2dLrml7HQ7FAIacXzRUW1pwyxM1ccoF3lr/6hWziUNLDMc9AAM6y4DqG?=
 =?Windows-1252?Q?HrG4oeaCi/wotn5UliTbeFnkCVsUT5tYEGCZrGs3jst5Ly35cBCgh97V?=
 =?Windows-1252?Q?sHEIJg/co4i5DY8Hf2hU3zZs0Yea5AYGr1yKBh/1NvleLpYRp+DDPK/+?=
 =?Windows-1252?Q?nydhYVeH8Yz64S3VWLpLIJ9fSAkeDiSirWQRWw5znT88sQlVLQmfOFVn?=
 =?Windows-1252?Q?tF4QuG22mYKMwYYRxHjerUnQtGzBylAXojcXVgpSVjR4CtkV3cmtVXRT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a7cc6c-1bb6-45b3-9663-08d8e58a3a46
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 19:08:32.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rt09a9mZd0PeGbYep7mcXBaQ/kOZN3gPpqyMzIEbBCdcDZHY2aJwODRQLjK1dvkq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Sunday, March 7, 2021 8:55 AM
> To: Shuah Khan <shuah@kernel.org>; Tony Luck <tony.luck@intel.com>;
> Reinette Chatre <reinette.chatre@intel.com>; Moger, Babu
> <Babu.Moger@amd.com>
> Cc: linux-kselftest <linux-kselftest@vger.kernel.org>; linux-kernel <linux-
> kernel@vger.kernel.org>; Fenghua Yu <fenghua.yu@intel.com>
> Subject: [PATCH v5 02/21] selftests/resctrl: Fix compilation issues for global
> variables
> 
> Reinette reported following compilation issue on Fedora 32, gcc version
> 10.1.1
> 
> /usr/bin/ld: cqm_test.o:<src_dir>/cqm_test.c:22: multiple definition of
> `cache_size'; cat_test.o:<src_dir>/cat_test.c:23: first defined here
> 
> The same issue is reported for long_mask, cbm_mask, count_of_bits etc
> variables as well. Compiler isn't happy because these variables are
> defined globally in two .c files namely cqm_test.c and cat_test.c and
> the compiler during compilation finds that the variable is already
> defined (multiple definition error).
> 
> Taking a closer look at the usage of these variables reveals that these
> variables are used only locally to functions such as cqm_resctrl_val()

%s/ locally to functions/locally in two functions

> (defined in cqm_test.c) and cat_perf_miss_val() (defined in cat_test.c).
> These variables are not shared between those functions. So, there is no
> need for these variables to be global. Hence, fix this issue by making
> them static variables.
> 
> Reported-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
> Change Log:
> v5:
> - Define long_mask, cbm_mask, count_of_bits etc as static variables
>   (Shuah).
> - Split this patch into patch 2 and 3 (Shuah).
> 
>  tools/testing/selftests/resctrl/cat_test.c  | 10 +++++-----
>  tools/testing/selftests/resctrl/cqm_test.c  | 10 +++++-----
>  tools/testing/selftests/resctrl/resctrl.h   |  2 +-
>  tools/testing/selftests/resctrl/resctrlfs.c | 10 +++++-----
>  4 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c
> b/tools/testing/selftests/resctrl/cat_test.c
> index 5da43767b973..bdeeb5772592 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -17,10 +17,10 @@
>  #define MAX_DIFF_PERCENT	4
>  #define MAX_DIFF		1000000
> 
> -int count_of_bits;
> -char cbm_mask[256];
> -unsigned long long_mask;
> -unsigned long cache_size;
> +static int count_of_bits;
> +static char cbm_mask[256];
> +static unsigned long long_mask;
> +static unsigned long cache_size;
> 
>  /*
>   * Change schemata. Write schemata to specified
> @@ -136,7 +136,7 @@ int cat_perf_miss_val(int cpu_no, int n, char
> *cache_type)
>  		return -1;
> 
>  	/* Get default cbm mask for L3/L2 cache */
> -	ret = get_cbm_mask(cache_type);
> +	ret = get_cbm_mask(cache_type, cbm_mask);
>  	if (ret)
>  		return ret;
> 
> diff --git a/tools/testing/selftests/resctrl/cqm_test.c
> b/tools/testing/selftests/resctrl/cqm_test.c
> index 5e7308ac63be..de33d1c0466e 100644
> --- a/tools/testing/selftests/resctrl/cqm_test.c
> +++ b/tools/testing/selftests/resctrl/cqm_test.c
> @@ -16,10 +16,10 @@
>  #define MAX_DIFF		2000000
>  #define MAX_DIFF_PERCENT	15
> 
> -int count_of_bits;
> -char cbm_mask[256];
> -unsigned long long_mask;
> -unsigned long cache_size;
> +static int count_of_bits;
> +static char cbm_mask[256];
> +static unsigned long long_mask;
> +static unsigned long cache_size;
> 
>  static int cqm_setup(int num, ...)
>  {
> @@ -125,7 +125,7 @@ int cqm_resctrl_val(int cpu_no, int n, char
> **benchmark_cmd)
>  	if (!validate_resctrl_feature_request("cqm"))
>  		return -1;
> 
> -	ret = get_cbm_mask("L3");
> +	ret = get_cbm_mask("L3", cbm_mask);
>  	if (ret)
>  		return ret;
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h
> b/tools/testing/selftests/resctrl/resctrl.h
> index 39bf59c6b9c5..959c71e39bdc 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -92,7 +92,7 @@ void tests_cleanup(void);
>  void mbm_test_cleanup(void);
>  int mba_schemata_change(int cpu_no, char *bw_report, char
> **benchmark_cmd);
>  void mba_test_cleanup(void);
> -int get_cbm_mask(char *cache_type);
> +int get_cbm_mask(char *cache_type, char *cbm_mask);
>  int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>  int cat_val(struct resctrl_val_param *param);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c
> b/tools/testing/selftests/resctrl/resctrlfs.c
> index 19c0ec4045a4..2a16100c9c3f 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -49,8 +49,6 @@ static int find_resctrl_mount(char *buffer)
>  	return -ENOENT;
>  }
> 
> -char cbm_mask[256];
> -
>  /*
>   * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
>   * @mum_resctrlfs:	Should the resctrl FS be remounted?
> @@ -205,16 +203,18 @@ int get_cache_size(int cpu_no, char *cache_type,
> unsigned long *cache_size)
>  /*
>   * get_cbm_mask - Get cbm mask for given cache
>   * @cache_type:	Cache level L2/L3
> - *
> - * Mask is stored in cbm_mask which is global variable.
> + * @cbm_mask:	cbm_mask returned as a string
>   *
>   * Return: = 0 on success, < 0 on failure.
>   */
> -int get_cbm_mask(char *cache_type)
> +int get_cbm_mask(char *cache_type, char *cbm_mask)
>  {
>  	char cbm_mask_path[1024];
>  	FILE *fp;
> 
> +	if (!cbm_mask)
> +		return -1;

Can cbm_mask be NULL? I see it is statically allocated.
Or should this be if (!(*cbm_mask))? Or did I miss something.

> +
>  	sprintf(cbm_mask_path, "%s/%s/cbm_mask", CBM_MASK_PATH,
> cache_type);
> 
>  	fp = fopen(cbm_mask_path, "r");
> --
> 2.30.1

