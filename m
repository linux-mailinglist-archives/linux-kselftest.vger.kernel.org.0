Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C8933972F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 20:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhCLTKR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 14:10:17 -0500
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com ([40.107.93.77]:57760
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234211AbhCLTJy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 14:09:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWh3Sd+b4cy2PMDafH0uoZqbJ121bBdmLBypE/25pTN7Xcoinr80aWj7y/CgtTTKwaD0TwMQXdZ4A8awwr5DDxciptSCalH+v8I6mMHN321HEwKmBt1QrY1FjBc/Dtfcj9LtBgHzLSOEqj8AbhdI9FAjVtiIMY+4yq1swg5JvANeCBqXECWE0NkvZytYnFZlVs84ND1UYw+WRyVwai3plAx6Dzo5xFcrUveHhRsQJkmIdgFRgMWrG+Xg2ahWS7QBp2Equa28xMmevjPmdcLtzdkhp0InuKtRg8FTXxG1p8j5emvsVL0drcoUASX5CmZYRqazLB02zoaQI/DAAv+skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM6veXr/MJ/Ly18kmbMhLnrzi+Eiw38snuPg7j+6Rkc=;
 b=AsooRbLGm5pyIHSGNrY5gp9hO4lM034XQojwN+82M+c77nTd9WcxmhPRc169dDGaZgUqUOSlQ5Se6Trbq7WIKJzEVywtNXIkqUkdRIm3bnLCeaXTnWdKuDDmq1fQQIM8zgR12QI2kxXVu3DjcIDep/U8g9WADNagpTJWOZWFE1l5AKCmqv2zIHldS1bnHaElYeXcv2ikAtURD98qX/arGhHEG+xKMKI/k7y38BcRRoi4qV4xT6EtseTXb9bpZG4NIi9qKUrDEgXerPUpQauSut7QzHVMCSe4t+gynq5JkEzs4TRdgA2RdaDPT05xw+uV93BbyBQbAWBKJ/Fm6dq0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM6veXr/MJ/Ly18kmbMhLnrzi+Eiw38snuPg7j+6Rkc=;
 b=2KAWk933+icR45aLQHaFE10GhqvJyioKZCI7UnZn7ZjRrhW7eum0AjhA6huWsrrqwyuIyvA4bbc7wdC0qpg3kHmepAjsvoP9he5mhYHqq0yF5bOxGP1tj2ljIKMzPzPgj8pc94DpGiJAkgMMsMMNFZdBwIbk8MASbmNixruEtkU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 19:09:52 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::20cf:9ae4:26fb:47b7]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::20cf:9ae4:26fb:47b7%7]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 19:09:52 +0000
Subject: RE: [PATCH v5 04/21] selftests/resctrl: Clean up resctrl features
 check
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
 <20210307145502.2916364-5-fenghua.yu@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <ec07e30f-9d8b-6e68-e3c6-743c3435a0d1@amd.com>
Date:   Fri, 12 Mar 2021 13:09:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210307145502.2916364-5-fenghua.yu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN1PR12CA0060.namprd12.prod.outlook.com
 (2603:10b6:802:20::31) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN1PR12CA0060.namprd12.prod.outlook.com (2603:10b6:802:20::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 19:09:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fb097e0-06b2-4b84-a88c-08d8e58a69b5
X-MS-TrafficTypeDiagnostic: SA0PR12MB4527:
X-Microsoft-Antispam-PRVS: <SA0PR12MB45272590114C6AA96C07FD0C956F9@SA0PR12MB4527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWB7M+oeB3ns6ODe656baRUEFW/mXm31D6hfsWsG4Powcko7K/TyqFtFVf+TPsHw54HJj+Z0WhziTLyN3XC/H6lhcuaaTZF134rXNj0GGYEqQGgt0ShSGqYSTdZs/oBkDVPt8HDMRzzlasjap711Aa21qkhXECmnXuWTFvJGSTHp595qZBrFcZma/KQrRip0SPM1WjE/0Xn76D2MfWPmmJ8LQmpWMbH13Yb5L0rvKV+4tPKrMyB6z7EVS6ln4DDmH8QIUGKwHcLGaeesc6nIxwVARdSQaMQGGCecL0couVGX8s/20cpjt/qh5gLfHoZlEnt0ZDnnuusxOCGjL30tqfR9xiedZBakgHo2WOiGbZvg9u9s5YMqnIViZ7t09vZSvxdDYa8+ec4SlANssVhYCvUfP3F30WyuVJIzSkErYjKIbQHuKgxDWPNzELGKo72o7FIbcUuLq0ibB6hNvEONHpmElkl7Mf4xbB263VMfLwymzdV0qds3zQNUUlIKdl0aqUgjKF4h8W8evpc2TkxDL/7PMs8JlMJn2rIdD+MzKiLvPfRyaS+cST3LQ9bAROQ9XXHZAGKV4nBgBrZrJcxmgiAYLJglz/C/dwLyOE0/LmV7jJWrS5hrAe/iPFIDD0+iccFpmsNW9UVcw3uQUIEPWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(36756003)(2616005)(66946007)(8936002)(4326008)(478600001)(2906002)(66476007)(186003)(26005)(83380400001)(54906003)(66556008)(52116002)(6486002)(8676002)(31686004)(30864003)(44832011)(53546011)(86362001)(31696002)(316002)(16526019)(956004)(5660300002)(110136005)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?jIe1GipO9LGNTB6D6V8jlAi/2nMCUYDuthKNQmLD1CpxNX6Jwplipz59?=
 =?Windows-1252?Q?TYQeEQDO3XQ29JRNtCm9VFfnVY7WT9+3oDC1VWybwxxFp3cjJUAUwO8M?=
 =?Windows-1252?Q?UhblP/tK75phjJM9DfykoMNfGN9O3k9G50Z1mYKtuje+FQKNlSpz/bMP?=
 =?Windows-1252?Q?MBcgi63UnVr5O6Fhl++etBZoaanYuvYhyz/kg7/mMzvjR7n25B2QKJyi?=
 =?Windows-1252?Q?JmiIIWXfxAT70PUct/IkzqR0r2smkWZk7lucSX7k6gtJTXSk5toqDGYJ?=
 =?Windows-1252?Q?VLnJo41CizY0HJ7/Y1ResFx+WC2F/Lo1XrvRwoS5R+EQ1P9yHxwhIHuN?=
 =?Windows-1252?Q?hPbnKalgW8URoDin123oA+t8RDvv7wGgbFCGYdPvo4uykb3GgjL0CFiX?=
 =?Windows-1252?Q?xkSLK2Qk7nU2y7lQ3cklZajbi4osCCN7fsOvTVW92tBdTnOP037R9zsg?=
 =?Windows-1252?Q?TF9aL1wDhZ2n8olkkmZJcxuonfgRQdOtnMN71yTvICpwnhoZjNBwBqOD?=
 =?Windows-1252?Q?GKijSD+4tlzGa4hubuNliCyxLViKyySbD3873np5C+hyV6TiyUadtHuk?=
 =?Windows-1252?Q?HuuayYwpsP9kKSjI5aos3HJ/B2Y72XMgzRzrArVxbH8PMBIlcgI7Doib?=
 =?Windows-1252?Q?8fMcreCVU3MeoDyhfzfOJCKViilbrTLFrrdzl8zFGJWwZ4KTE1zOCD27?=
 =?Windows-1252?Q?f8h92QGS5u1kTiu6OuYDMB6KJW+j+Omp96+D72eVWOd0slaJZqt+2w9k?=
 =?Windows-1252?Q?GX4r8pwulyc2R5zqT6E3ztduyI1eMaPTDeaC8df0rjkhO9+JtvQVHKQc?=
 =?Windows-1252?Q?5HDk2sJnNMXNQhLoArnmoappfaPYlJ1KcGxV5sdVYlPwn9rkvOmOYanM?=
 =?Windows-1252?Q?gnTyeLditiWvhRd7qh1kG8oGhDnlUdHQPeHe9hWrilFxusgT6gf90oMn?=
 =?Windows-1252?Q?7kL15IJqAHluMTVRSThC4pkB0yl8km+2VJYdK+gf+WRWyk/vH7ZJDnIn?=
 =?Windows-1252?Q?StUeRzbD0kXPe/SAF/RSEZTTU8fWjso19wzAotnaluvGROI4lHI29jcn?=
 =?Windows-1252?Q?wb58SKR3yYsucTvNfgZb4TWg/JBwvskXXf1WP79DC4sFtm7pFSmGmd4D?=
 =?Windows-1252?Q?ZkKaWCR6OCYcci7wqkR0MHMN2Ar6ZWpK/vIkjytX2KcX+MmmWwrA5E0z?=
 =?Windows-1252?Q?I3Hu01S5SzJCME7kLb+9UTsA2qxhalCxVLSqA90DqZq4jEA7ivkK/V0t?=
 =?Windows-1252?Q?hzXTPhnriIrEi2bcoEZX6SM4+5gDoo7zw7D4B9IhtqZPjrYvmr8D5++E?=
 =?Windows-1252?Q?T09e4hwAtMGrKQF2rbaG9ml269PHxI3BUXuMNm0wSYKWHkSHN1JAn3T1?=
 =?Windows-1252?Q?x+SJFSZRSlQ8hYl7f5no2JqJMIw2ZAvrIHx7/tjKCeO2FNGyBSs9aXAi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb097e0-06b2-4b84-a88c-08d8e58a69b5
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 19:09:52.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmKB/09fQ6Cv4ZruzNdNienyi0KAXk519zyLxm2Fufp1Gw01E9LMPDlEnP8xMKkJ
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
> Subject: [PATCH v5 04/21] selftests/resctrl: Clean up resctrl features check
> 
> Checking resctrl features call strcmp() to compare feature strings (e.g. "mba",
> "cat" etc). The checkings are error prone and don't have good coding style.
> Define the constant strings in macros and call
> strncmp() to solve the potential issues.
> 
> Suggested-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
> Change Log:
> v5:
> - Remove is_cat() etc functions and directly call strncmp() to check
>   the features (Shuah).
> 
>  tools/testing/selftests/resctrl/cache.c       |  8 +++----
>  tools/testing/selftests/resctrl/cat_test.c    |  2 +-
>  tools/testing/selftests/resctrl/cqm_test.c    |  2 +-
>  tools/testing/selftests/resctrl/fill_buf.c    |  4 ++--
>  tools/testing/selftests/resctrl/mba_test.c    |  2 +-
>  tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
>  tools/testing/selftests/resctrl/resctrl.h     |  5 +++++
>  .../testing/selftests/resctrl/resctrl_tests.c | 12 +++++-----
> tools/testing/selftests/resctrl/resctrl_val.c | 22 +++++++++----------
>  tools/testing/selftests/resctrl/resctrlfs.c   | 17 +++++++-------
>  10 files changed, 41 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c
> b/tools/testing/selftests/resctrl/cache.c
> index 38dbf4962e33..5922cc1b0386 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -182,7 +182,7 @@ int measure_cache_vals(struct resctrl_val_param
> *param, int bm_pid)
>  	/*
>  	 * Measure cache miss from perf.
>  	 */
> -	if (!strcmp(param->resctrl_val, "cat")) {
> +	if (!strncmp(param->resctrl_val, CAT_STR, sizeof(CAT_STR))) {
>  		ret = get_llc_perf(&llc_perf_miss);
>  		if (ret < 0)
>  			return ret;
> @@ -192,7 +192,7 @@ int measure_cache_vals(struct resctrl_val_param
> *param, int bm_pid)
>  	/*
>  	 * Measure llc occupancy from resctrl.
>  	 */
> -	if (!strcmp(param->resctrl_val, "cqm")) {
> +	if (!strncmp(param->resctrl_val, CQM_STR, sizeof(CQM_STR))) {
>  		ret = get_llc_occu_resctrl(&llc_occu_resc);
>  		if (ret < 0)
>  			return ret;
> @@ -234,7 +234,7 @@ int cat_val(struct resctrl_val_param *param)
>  	if (ret)
>  		return ret;
> 
> -	if ((strcmp(resctrl_val, "cat") == 0)) {
> +	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
>  		ret = initialize_llc_perf();
>  		if (ret)
>  			return ret;
> @@ -242,7 +242,7 @@ int cat_val(struct resctrl_val_param *param)
> 
>  	/* Test runs until the callback setup() tells the test to stop. */
>  	while (1) {
> -		if (strcmp(resctrl_val, "cat") == 0) {
> +		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
>  			ret = param->setup(1, param);
>  			if (ret) {
>  				ret = 0;
> diff --git a/tools/testing/selftests/resctrl/cat_test.c
> b/tools/testing/selftests/resctrl/cat_test.c
> index bdeeb5772592..20823725daca 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -164,7 +164,7 @@ int cat_perf_miss_val(int cpu_no, int n, char
> *cache_type)
>  		return -1;
> 
>  	struct resctrl_val_param param = {
> -		.resctrl_val	= "cat",
> +		.resctrl_val	= CAT_STR,
>  		.cpu_no		= cpu_no,
>  		.mum_resctrlfs	= 0,
>  		.setup		= cat_setup,
> diff --git a/tools/testing/selftests/resctrl/cqm_test.c
> b/tools/testing/selftests/resctrl/cqm_test.c
> index de33d1c0466e..271752e9ef5b 100644
> --- a/tools/testing/selftests/resctrl/cqm_test.c
> +++ b/tools/testing/selftests/resctrl/cqm_test.c
> @@ -145,7 +145,7 @@ int cqm_resctrl_val(int cpu_no, int n, char
> **benchmark_cmd)
>  	}
> 
>  	struct resctrl_val_param param = {
> -		.resctrl_val	= "cqm",
> +		.resctrl_val	= CQM_STR,
>  		.ctrlgrp	= "c1",
>  		.mongrp		= "m1",
>  		.cpu_no		= cpu_no,
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c
> b/tools/testing/selftests/resctrl/fill_buf.c
> index 79c611c99a3d..51e5cf22632f 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -115,7 +115,7 @@ static int fill_cache_read(unsigned char *start_ptr,
> unsigned char *end_ptr,
> 
>  	while (1) {
>  		ret = fill_one_span_read(start_ptr, end_ptr);
> -		if (!strcmp(resctrl_val, "cat"))
> +		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
>  			break;
>  	}
> 
> @@ -134,7 +134,7 @@ static int fill_cache_write(unsigned char *start_ptr,
> unsigned char *end_ptr,  {
>  	while (1) {
>  		fill_one_span_write(start_ptr, end_ptr);
> -		if (!strcmp(resctrl_val, "cat"))
> +		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
>  			break;
>  	}
> 
> diff --git a/tools/testing/selftests/resctrl/mba_test.c
> b/tools/testing/selftests/resctrl/mba_test.c
> index 7bf8eaa6204b..6449fbd96096 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -141,7 +141,7 @@ void mba_test_cleanup(void)  int
> mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
> {
>  	struct resctrl_val_param param = {
> -		.resctrl_val	= "mba",
> +		.resctrl_val	= MBA_STR,
>  		.ctrlgrp	= "c1",
>  		.mongrp		= "m1",
>  		.cpu_no		= cpu_no,
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c
> b/tools/testing/selftests/resctrl/mbm_test.c
> index 4700f7453f81..ec6cfe01c9c2 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -114,7 +114,7 @@ void mbm_test_cleanup(void)  int mbm_bw_change(int
> span, int cpu_no, char *bw_report, char **benchmark_cmd)  {
>  	struct resctrl_val_param param = {
> -		.resctrl_val	= "mbm",
> +		.resctrl_val	= MBM_STR,
>  		.ctrlgrp	= "c1",
>  		.mongrp		= "m1",
>  		.span		= span,
> diff --git a/tools/testing/selftests/resctrl/resctrl.h
> b/tools/testing/selftests/resctrl/resctrl.h
> index 12b77182cb44..36da6136af96 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -62,6 +62,11 @@ struct resctrl_val_param {
>  	int		(*setup)(int num, ...);
>  };
> 
> +#define MBM_STR			"mbm"
> +#define MBA_STR			"mba"
> +#define CQM_STR			"cqm"
> +#define CAT_STR			"cat"
> +
>  extern pid_t bm_pid, ppid;
>  extern int tests_run;
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c
> b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 425cc85ac883..4b109a59f72d 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -85,13 +85,13 @@ int main(int argc, char **argv)
>  			cqm_test = false;
>  			cat_test = false;
>  			while (token) {
> -				if (!strcmp(token, "mbm")) {
> +				if (!strncmp(token, MBM_STR,
> sizeof(MBM_STR))) {
>  					mbm_test = true;
> -				} else if (!strcmp(token, "mba")) {
> +				} else if (!strncmp(token, MBA_STR,
> sizeof(MBA_STR))) {
>  					mba_test = true;
> -				} else if (!strcmp(token, "cqm")) {
> +				} else if (!strncmp(token, CQM_STR,
> sizeof(CQM_STR))) {
>  					cqm_test = true;
> -				} else if (!strcmp(token, "cat")) {
> +				} else if (!strncmp(token, CAT_STR,
> sizeof(CAT_STR))) {
>  					cat_test = true;
>  				} else {
>  					printf("invalid argument\n");
> @@ -161,7 +161,7 @@ int main(int argc, char **argv)
>  	if (!is_amd && mbm_test) {
>  		printf("# Starting MBM BW change ...\n");
>  		if (!has_ben)
> -			sprintf(benchmark_cmd[5], "%s", "mba");
> +			sprintf(benchmark_cmd[5], "%s", MBA_STR);
>  		res = mbm_bw_change(span, cpu_no, bw_report,
> benchmark_cmd);
>  		printf("%sok MBM: bw change\n", res ? "not " : "");
>  		mbm_test_cleanup();
> @@ -181,7 +181,7 @@ int main(int argc, char **argv)
>  	if (cqm_test) {
>  		printf("# Starting CQM test ...\n");
>  		if (!has_ben)
> -			sprintf(benchmark_cmd[5], "%s", "cqm");
> +			sprintf(benchmark_cmd[5], "%s", CQM_STR);
>  		res = cqm_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
>  		printf("%sok CQM: test\n", res ? "not " : "");
>  		cqm_test_cleanup();
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c
> b/tools/testing/selftests/resctrl/resctrl_val.c
> index 520fea3606d1..aed71fd0713b 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -397,10 +397,10 @@ static void initialize_mem_bw_resctrl(const char
> *ctrlgrp, const char *mongrp,
>  		return;
>  	}
> 
> -	if (strcmp(resctrl_val, "mbm") == 0)
> +	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
>  		set_mbm_path(ctrlgrp, mongrp, resource_id);
> 
> -	if ((strcmp(resctrl_val, "mba") == 0)) {
> +	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
>  		if (ctrlgrp)
>  			sprintf(mbm_total_path,
> CON_MBM_LOCAL_BYTES_PATH,
>  				RESCTRL_PATH, ctrlgrp, resource_id); @@ -
> 524,7 +524,7 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp,
> const char *mongrp,
>  		return;
>  	}
> 
> -	if (strcmp(resctrl_val, "cqm") == 0)
> +	if (!strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
>  		set_cqm_path(ctrlgrp, mongrp, resource_id);  }
> 
> @@ -579,8 +579,8 @@ int resctrl_val(char **benchmark_cmd, struct
> resctrl_val_param *param)
>  	if (strcmp(param->filename, "") == 0)
>  		sprintf(param->filename, "stdio");
> 
> -	if ((strcmp(resctrl_val, "mba")) == 0 ||
> -	    (strcmp(resctrl_val, "mbm")) == 0) {
> +	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
> +	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
>  		ret = validate_bw_report_request(param->bw_report);
>  		if (ret)
>  			return ret;
> @@ -674,15 +674,15 @@ int resctrl_val(char **benchmark_cmd, struct
> resctrl_val_param *param)
>  	if (ret)
>  		goto out;
> 
> -	if ((strcmp(resctrl_val, "mbm") == 0) ||
> -	    (strcmp(resctrl_val, "mba") == 0)) {
> +	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
> +	    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
>  		ret = initialize_mem_bw_imc();
>  		if (ret)
>  			goto out;
> 
>  		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
>  					  param->cpu_no, resctrl_val);
> -	} else if (strcmp(resctrl_val, "cqm") == 0)
> +	} else if (!strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
>  		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
>  					    param->cpu_no, resctrl_val);
> 
> @@ -710,8 +710,8 @@ int resctrl_val(char **benchmark_cmd, struct
> resctrl_val_param *param)
> 
>  	/* Test runs until the callback setup() tells the test to stop. */
>  	while (1) {
> -		if ((strcmp(resctrl_val, "mbm") == 0) ||
> -		    (strcmp(resctrl_val, "mba") == 0)) {
> +		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
> +		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
>  			ret = param->setup(1, param);
>  			if (ret) {
>  				ret = 0;
> @@ -721,7 +721,7 @@ int resctrl_val(char **benchmark_cmd, struct
> resctrl_val_param *param)
>  			ret = measure_vals(param, &bw_resc_start);
>  			if (ret)
>  				break;
> -		} else if (strcmp(resctrl_val, "cqm") == 0) {
> +		} else if (!strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR))) {
>  			ret = param->setup(1, param);
>  			if (ret) {
>  				ret = 0;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c
> b/tools/testing/selftests/resctrl/resctrlfs.c
> index 2a16100c9c3f..4174e48e06d1 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -334,7 +334,7 @@ void run_benchmark(int signum, siginfo_t *info, void
> *ucontext)
>  		operation = atoi(benchmark_cmd[4]);
>  		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
> 
> -		if (strcmp(resctrl_val, "cqm") != 0)
> +		if (strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
>  			buffer_span = span * MB;
>  		else
>  			buffer_span = span;
> @@ -459,8 +459,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp,
> char *mongrp,
>  		goto out;
> 
>  	/* Create mon grp and write pid into it for "mbm" and "cqm" test */
> -	if ((strcmp(resctrl_val, "cqm") == 0) ||
> -	    (strcmp(resctrl_val, "mbm") == 0)) {
> +	if (!strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)) ||
> +	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
>  		if (strlen(mongrp)) {
>  			sprintf(monitorgroup_p, "%s/mon_groups",
> controlgroup);
>  			sprintf(monitorgroup, "%s/%s", monitorgroup_p,
> mongrp); @@ -505,9 +505,9 @@ int write_schemata(char *ctrlgrp, char
> *schemata, int cpu_no, char *resctrl_val)
>  	int resource_id, ret = 0;
>  	FILE *fp;
> 
> -	if ((strcmp(resctrl_val, "mba") != 0) &&
> -	    (strcmp(resctrl_val, "cat") != 0) &&
> -	    (strcmp(resctrl_val, "cqm") != 0))
> +	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
> +	    strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) &&
> +	    strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
>  		return -ENOENT;
> 
>  	if (!schemata) {
> @@ -528,9 +528,10 @@ int write_schemata(char *ctrlgrp, char *schemata, int
> cpu_no, char *resctrl_val)
>  	else
>  		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
> 
> -	if (!strcmp(resctrl_val, "cat") || !strcmp(resctrl_val, "cqm"))
> +	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
> +	    !strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
>  		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=',
> schemata);
> -	if (strcmp(resctrl_val, "mba") == 0)
> +	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)))
>  		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=',
> schemata);
> 
>  	fp = fopen(controlgroup, "w");
> --
> 2.30.1

I see there are few other references as well.  Like this.

1 cat_test.c  cat_perf_miss_val  135 if
(!validate_resctrl_feature_request("cat"))

2 cqm_test.c  cqm_resctrl_val                  125 if
(!validate_resctrl_feature_request("cqm"))

3 mba_test.c  mba_schemata_change    157 if
(!validate_resctrl_feature_request("mba"))

4 mbm_test.c  mbm_bw_change             131 if
(!validate_resctrl_feature_request("mbm"))

Should you use CAT_STR and CQM_STR etc.. in here as well?

