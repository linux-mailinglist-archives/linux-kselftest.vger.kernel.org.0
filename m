Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12A933973B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 20:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhCLTM4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 14:12:56 -0500
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:8648
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234178AbhCLTMi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 14:12:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBEP5s+Y6v0P1jvVPVz2EB3KsmFnT9Iia7vY+Q6XYY5rjNT970/zVx/tHoWah/XUgG6hM7g08gaESw619KSqTbffjSQSYMuqw5RTlV54oVVGW52xdgqel8wvJPMmJ/+9G0gNCLbU/+oWD7xkefx7acddF4bXndO0LdcB0H+kGI/U4oisZ27eGGy1QbyfHAQoTYMrax5WmM2TmYA5e5oQ6LRd7zgMxmocLjU/efnjBNkZzlOp8p7Dgv7t83w4j9cSSBzly5HT/T1nn05yBaixve/UIC6qMu/pDRnBfqlslG3HcPowst92F//zVcM5Gmm2q0UUHNKHI/AofZavmKX+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PQ4293C/BxEzKM8ORCp9NitmhsJ6kP1WTXlpxTlS08=;
 b=MW0ojMb7W/fgAjRzJgeVQ36CFKl9GzzMsXsbtKRPU73C1fUruSAwwZhCdFNr+8Zn2lY3g7kUxC+b+sZEcWESnYkMbPWUx/fhoS7rBXwr7eQ36aGzInaGkJ1IiPYVB8W+k2r9Qx4yH5Gzz0DCmVtrsfCX1xrESoQn+XxFvdJQ86LrLaUw7M8jkvEKwDuN+36NU4vCDJvZi6YlXyJb5TJ7unfXp/hKN+123yVYnkgO9v1lXTOkX/C0U11pVsLZSzf1vVC753mlh13lMWRctlNsf5qfrHHLrActqjpIv5PCGLFy4+7ytSxZEljCrhKrrzVEMYHkxJe2yNvtPyOxVlwyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PQ4293C/BxEzKM8ORCp9NitmhsJ6kP1WTXlpxTlS08=;
 b=p0nzP1/SgwT7N+RaR093M3PjlajQJtOacMKTKxyYSJdpf3mPXsjgPaIq50WoW564ZR8tlqw4nfRLr0jKuWc5p/ONPsXRovpm2WecspTwUnq6k1sS8uB/Olo9p7r3izhYA36A+kia3m6arRkm2cGaEF6jeTht7bSql/NEqm9ezPk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2461.namprd12.prod.outlook.com (2603:10b6:802:27::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Fri, 12 Mar
 2021 19:12:36 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::20cf:9ae4:26fb:47b7]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::20cf:9ae4:26fb:47b7%7]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 19:12:36 +0000
Subject: RE: [PATCH v5 08/21] selftests/resctrl: Call kselftest APIs to log
 test results
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
 <20210307145502.2916364-9-fenghua.yu@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <d902468d-644f-65e4-1043-81c90fdf4da8@amd.com>
Date:   Fri, 12 Mar 2021 13:12:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210307145502.2916364-9-fenghua.yu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0091.namprd05.prod.outlook.com
 (2603:10b6:803:22::29) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN4PR0501CA0091.namprd05.prod.outlook.com (2603:10b6:803:22::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Fri, 12 Mar 2021 19:12:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4805f73d-d7ea-4707-c856-08d8e58acbf1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2461:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2461FBA9CBAD365565E077E6956F9@SN1PR12MB2461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:11;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VatrS38Xhaaa873Efin5jlcJ+F9QddT99i3RY+3iQcFE7ND6Ft1i0m6RKRxoY9pJDDXpXeFcR55JeOzIVy8SnuTs/Q7b/oSuIarxUYIReE2pP3R6PQmIWxPlk2u9loTbaUDw4sDSXgmYX0zOLNzM8fI8P0RqT+dWktigU8Pi46OtnLlI4B7KUN+oZopIR6jbP6wDX+eZx49EYdG/Yb93UoMIrgwXUnz/OVqJLKxI15VBthVhGJXAkkPjxQwqrJ6XX+kwM8gzPWmrgM2cE0O0OQT50T2qCGHc5y4JJC54CMlj2vtrLRE4cYAvJY5ieOdR2A3iIjh8yEZRxk+GPgcra53Q+71/NUvjwI1JO1Rr4BvdZqhIiTI/TRL5z6hVUFG0be/Jr97AJh0Tx5c4a5Qu+UlX2eE9n4w6O5pe1b6TlMBI5wDpypaj4ht7aTNOshu++9L17WUUND+9dUp5HDM7/Tlryw4B/kpgahTG14shGFQ/1GT8h5oWoy9CiVcXQQjrnwQnHCFihZTE2/RG4LGHsg8H9zDNksByXuvFcWSWHJeVDeCjOMbPli3GHLyAWeg2+AKLas9zFANN2andqRsJi1Yh7dYn1WBH85vQ5Duky6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(31686004)(5660300002)(36756003)(956004)(53546011)(52116002)(16576012)(30864003)(31696002)(8936002)(316002)(186003)(66946007)(2906002)(4326008)(83380400001)(110136005)(86362001)(2616005)(478600001)(66476007)(26005)(6486002)(44832011)(66556008)(8676002)(16526019)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?YZ2t43JniccQh1yhiyZPV1ibEn/0GHYmp8C43Jw3tVTwTejpJtx6a5Tl?=
 =?Windows-1252?Q?tfQFAhs8+OP0xlMCo8ej+WS8NL2cxi/facp1qf13pSUv7f7n3V3d0OSJ?=
 =?Windows-1252?Q?eHpbfAbzKJggg7e+0UoB0v0rc/M76gHUm/cU20XqkZg7bZFIlivsafc8?=
 =?Windows-1252?Q?ARgNYzkF1L3FQVaBvXoHAnWB8AS6bompebWJvG6aKMIwUemdk4Rj3H5W?=
 =?Windows-1252?Q?6X8Pkzzo8iJRcNiVcXzFxz7sTvqZSFHyzCB571X2RE7NBATkSKZV52D3?=
 =?Windows-1252?Q?2wP7wAA9lzCya9189WTVmc+sffizGoydlDrrPbMUdmo7UF3C1sYrhISY?=
 =?Windows-1252?Q?g3if/2VYMZSEO0RHBfyTVFvsihyzU+m3iq0QjzzEbx33+jDKRiTkww2e?=
 =?Windows-1252?Q?5jMJUedu9XYniAbKVVXWWJ1yvkW/c7CFKGpI1nlqULv2YTOP30ycmuc2?=
 =?Windows-1252?Q?2LbBwE3VgaGH6xOZrwRDEpg85/H6Dhjn/IFvGGCgyJ85PaR7GmsxCt3G?=
 =?Windows-1252?Q?XCGPe1UI0uE9n2OO2CPw14NM4Dy0xcXVL29uGWTDbjNwq+bGzuvgJ7oc?=
 =?Windows-1252?Q?1xt2UHaZGIxCW3nvN91yOS4mhUw+Bp00ziez3BfjuXT38flOB+sYPkRT?=
 =?Windows-1252?Q?PVBB+lAmndEgmGDSz4S1omT8YefuTuzwyg+xqY/V69r2K3ClY6Af2mn2?=
 =?Windows-1252?Q?6s0Coq22G37SbmudiJ4ZLliVFwbtI52F/o0uQzaVeWdvchEe3x7pcRS7?=
 =?Windows-1252?Q?FEGMtp+TqfTRAr5U7M9+89FfV6TR1xSHS61T8Ft29reliXNEraty1wWr?=
 =?Windows-1252?Q?meoTb7B66UbQiKV/MnDRdGxbmKiX+8IRYy4+Yz5MhA3FEKrHLQbXZOGA?=
 =?Windows-1252?Q?c2KUyX6qougKtqogIqIFSmRwsRrrMjTKVl38CV1r0B7kul71xzJD/rDD?=
 =?Windows-1252?Q?ZnFccbPYWeg6eP+Ywhck7FZD16BBr1pxhJgM2sPaabOH3cUeaZewMKlR?=
 =?Windows-1252?Q?+Db2XV84CfwFfI8lxIAK1d3TCBuvZFoY/QhD16H2p/7qc6ASfvKIJlWC?=
 =?Windows-1252?Q?tHKyEOEsEhHfx20MxsJFi0ldxUlFFlxYIcEIb4DC/E/pT36j6I6Rxcmq?=
 =?Windows-1252?Q?nTZPcKdipBiQbHq3h8QoppiJpcuwIGPXWnP4TITwuyRQ925i8qoTSSzg?=
 =?Windows-1252?Q?xujYPsZEG5rnpYrHuFd3lbwkmwq/IpFv4kGjT0PsOL6BoRDIQ/wSZjxT?=
 =?Windows-1252?Q?ktWLCCqYtm0COenAIomBW9izk7UHVtKjbeQurVjBer0sKWkZ2aedq9jm?=
 =?Windows-1252?Q?6hapgMV4jI4kWO2DwRgr4U459LgKfCOmuZhCwxzPoJ6r33+f4mVUyj98?=
 =?Windows-1252?Q?eDPcMyQJcjGLLXbQqyP8AIssHSvhtI+IQwq3eMDOUW5xZwqWkSBRtDhW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4805f73d-d7ea-4707-c856-08d8e58acbf1
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 19:12:36.4462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bE9GI3QP5g87a76wUiop4/y8udr2HZaOo4mrOVpFv75AyXEzjl0uxWeDUOzgpQgI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2461
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
> Subject: [PATCH v5 08/21] selftests/resctrl: Call kselftest APIs to log test results
> 
> Call kselftest APIs instead of using printf() to log test results
> for cleaner code and better future extension.
> 
> Suggested-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
> Change Log:
> v5:
> - Add this patch (Shuah)
> 
>  tools/testing/selftests/resctrl/cat_test.c    | 37 +++++++--------
>  tools/testing/selftests/resctrl/cmt_test.c    | 42 ++++++++---------
>  tools/testing/selftests/resctrl/mba_test.c    | 24 +++++-----
>  tools/testing/selftests/resctrl/mbm_test.c    | 28 ++++++------
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +-
>  .../testing/selftests/resctrl/resctrl_tests.c | 40 +++++++++--------
>  tools/testing/selftests/resctrl/resctrl_val.c |  4 +-
>  tools/testing/selftests/resctrl/resctrlfs.c   | 45 +++++++------------
>  8 files changed, 105 insertions(+), 117 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c
> b/tools/testing/selftests/resctrl/cat_test.c
> index 20823725daca..0deb38ed971b 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -52,25 +52,28 @@ static int cat_setup(int num, ...)
>  	return ret;
>  }
> 
> -static void show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bits,
> -			    unsigned long span)
> +static int show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bits,
> +			   unsigned long span)
>  {
>  	unsigned long allocated_cache_lines = span / 64;
>  	unsigned long avg_llc_perf_miss = 0;
>  	float diff_percent;
> +	int ret;
> 
>  	avg_llc_perf_miss = sum_llc_perf_miss / (NUM_OF_RUNS - 1);
>  	diff_percent = ((float)allocated_cache_lines - avg_llc_perf_miss) /
>  				allocated_cache_lines * 100;
> 
> -	printf("%sok CAT: cache miss rate within %d%%\n",
> -	       !is_amd && abs((int)diff_percent) > MAX_DIFF_PERCENT ?
> -	       "not " : "", MAX_DIFF_PERCENT);
> -	tests_run++;
> -	printf("# Percent diff=%d\n", abs((int)diff_percent));
> -	printf("# Number of bits: %d\n", no_of_bits);
> -	printf("# Avg_llc_perf_miss: %lu\n", avg_llc_perf_miss);
> -	printf("# Allocated cache lines: %lu\n", allocated_cache_lines);
> +	ret = !is_amd && abs((int)diff_percent) > MAX_DIFF_PERCENT;
> +	ksft_print_msg("cache miss rate %swithin %d%%\n",
> +		       ret ? "not " : "", MAX_DIFF_PERCENT);
> +
> +	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
> +	ksft_print_msg("Number of bits: %d\n", no_of_bits);
> +	ksft_print_msg("Avg_llc_perf_miss: %lu\n", avg_llc_perf_miss);
> +	ksft_print_msg("Allocated cache lines: %lu\n", allocated_cache_lines);
> +
> +	return ret;
>  }
> 
>  static int check_results(struct resctrl_val_param *param)
> @@ -80,7 +83,7 @@ static int check_results(struct resctrl_val_param *param)
>  	int runs = 0, no_of_bits = 0;
>  	FILE *fp;
> 
> -	printf("# Checking for pass/fail\n");
> +	ksft_print_msg("Checking for pass/fail\n");
>  	fp = fopen(param->filename, "r");
>  	if (!fp) {
>  		perror("# Cannot open file");
> @@ -108,9 +111,7 @@ static int check_results(struct resctrl_val_param
> *param)
>  	fclose(fp);
>  	no_of_bits = count_bits(param->mask);
> 
> -	show_cache_info(sum_llc_perf_miss, no_of_bits, param->span);
> -
> -	return 0;
> +	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span);
>  }
> 
>  void cat_test_cleanup(void)
> @@ -146,15 +147,15 @@ int cat_perf_miss_val(int cpu_no, int n, char
> *cache_type)
>  	ret = get_cache_size(cpu_no, cache_type, &cache_size);
>  	if (ret)
>  		return ret;
> -	printf("cache size :%lu\n", cache_size);
> +	ksft_print_msg("cache size :%lu\n", cache_size);
> 
>  	/* Get max number of bits from default-cabm mask */
>  	count_of_bits = count_bits(long_mask);
> 
>  	if (n < 1 || n > count_of_bits - 1) {
> -		printf("Invalid input value for no_of_bits n!\n");
> -		printf("Please Enter value in range 1 to %d\n",
> -		       count_of_bits - 1);
> +		ksft_print_msg("Invalid input value for no_of_bits n!\n");
> +		ksft_print_msg("Please Enter value in range 1 to %d\n",
> +			       count_of_bits - 1);
>  		return -1;
>  	}
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c
> b/tools/testing/selftests/resctrl/cmt_test.c
> index ca82db37c1f7..e5af19335115 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -39,36 +39,33 @@ static int cmt_setup(int num, ...)
>  	return 0;
>  }
> 
> -static void show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
> -			    unsigned long span)
> +static int show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
> +			   unsigned long span)
>  {
>  	unsigned long avg_llc_occu_resc = 0;
>  	float diff_percent;
>  	long avg_diff = 0;
> -	bool res;
> +	int ret;
> 
>  	avg_llc_occu_resc = sum_llc_occu_resc / (NUM_OF_RUNS - 1);
>  	avg_diff = (long)abs(span - avg_llc_occu_resc);
> 
>  	diff_percent = (((float)span - avg_llc_occu_resc) / span) * 100;
> 
> -	if ((abs((int)diff_percent) <= MAX_DIFF_PERCENT) ||
> -	    (abs(avg_diff) <= MAX_DIFF))
> -		res = true;
> -	else
> -		res = false;
> +	ret = (abs((int)diff_percent) > MAX_DIFF_PERCENT) &&
> +	      (abs(avg_diff) > MAX_DIFF);
> 
> -	printf("%sok CMT: diff within %d, %d\%%\n", res ? "" : "not",
> -	       MAX_DIFF, (int)MAX_DIFF_PERCENT);
> +	ksft_print_msg("%scache miss diff within %d, %d\%%\n",
> +		       ret ? "fail: " : "not", MAX_DIFF, (int)MAX_DIFF_PERCENT);
> 
> -	printf("# diff: %ld\n", avg_diff);
> -	printf("# percent diff=%d\n", abs((int)diff_percent));
> -	printf("# Results are displayed in (Bytes)\n");
> -	printf("# Number of bits: %d\n", no_of_bits);
> -	printf("# Avg_llc_occu_resc: %lu\n", avg_llc_occu_resc);
> -	printf("# llc_occu_exp (span): %lu\n", span);
> +	ksft_print_msg("diff: %ld\n", avg_diff);
> +	ksft_print_msg("percent diff=%d\n", abs((int)diff_percent));
> +	ksft_print_msg("Results are displayed in (Bytes)\n");
> +	ksft_print_msg("Number of bits: %d\n", no_of_bits);
> +	ksft_print_msg("Avg_llc_occu_resc: %lu\n", avg_llc_occu_resc);
> +	ksft_print_msg("llc_occu_exp (span): %lu\n", span);
> 
> -	tests_run++;
> +	return ret;
>  }
> 
>  static int check_results(struct resctrl_val_param *param, int no_of_bits)
> @@ -78,7 +75,7 @@ static int check_results(struct resctrl_val_param *param,
> int no_of_bits)
>  	int runs = 0;
>  	FILE *fp;
> 
> -	printf("# checking for pass/fail\n");
> +	ksft_print_msg("checking for pass/fail\n");
>  	fp = fopen(param->filename, "r");
>  	if (!fp) {
>  		perror("# Error in opening file\n");
> @@ -101,9 +98,8 @@ static int check_results(struct resctrl_val_param *param,
> int no_of_bits)
>  		runs++;
>  	}
>  	fclose(fp);
> -	show_cache_info(sum_llc_occu_resc, no_of_bits, param->span);
> 
> -	return 0;
> +	return show_cache_info(sum_llc_occu_resc, no_of_bits, param->span);
>  }
> 
>  void cmt_test_cleanup(void)
> @@ -134,13 +130,13 @@ int cmt_resctrl_val(int cpu_no, int n, char
> **benchmark_cmd)
>  	ret = get_cache_size(cpu_no, "L3", &cache_size);
>  	if (ret)
>  		return ret;
> -	printf("cache size :%lu\n", cache_size);
> +	ksft_print_msg("cache size :%lu\n", cache_size);
> 
>  	count_of_bits = count_bits(long_mask);
> 
>  	if (n < 1 || n > count_of_bits) {
> -		printf("Invalid input value for numbr_of_bits n!\n");
> -		printf("Please Enter value in range 1 to %d\n", count_of_bits);
> +		ksft_print_msg("Invalid input value for numbr_of_bits n!\n");
> +		ksft_print_msg("Please Enter value in range 1 to %d\n",
> count_of_bits);
>  		return -1;
>  	}
> 
> diff --git a/tools/testing/selftests/resctrl/mba_test.c
> b/tools/testing/selftests/resctrl/mba_test.c
> index 6449fbd96096..3a226effe80c 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -56,7 +56,7 @@ static void show_mba_info(unsigned long *bw_imc,
> unsigned long *bw_resc)
>  	int allocation, runs;
>  	bool failed = false;
> 
> -	printf("# Results are displayed in (MB)\n");
> +	ksft_print_msg("Results are displayed in (MB)\n");
>  	/* Memory bandwidth from 100% down to 10% */
>  	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
>  	     allocation++) {
> @@ -78,21 +78,21 @@ static void show_mba_info(unsigned long *bw_imc,
> unsigned long *bw_resc)
>  		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
>  		avg_diff = labs((long)(avg_bw_resc - avg_bw_imc));
> 
> -		printf("%sok MBA schemata percentage %u smaller than %d
> %%\n",
> -		       avg_diff > MAX_DIFF ? "not " : "",
> -		       ALLOCATION_MAX - ALLOCATION_STEP * allocation,
> -		       MAX_DIFF);
> -		tests_run++;
> -		printf("# avg_diff: %lu\n", avg_diff);
> -		printf("# avg_bw_imc: %lu\n", avg_bw_imc);
> -		printf("# avg_bw_resc: %lu\n", avg_bw_resc);
> +		ksft_print_msg("%s MBA schemata percentage %u smaller than
> %d %%\n",
> +			       avg_diff > MAX_DIFF ? "fail:" : "pass:",
> +			       ALLOCATION_MAX - ALLOCATION_STEP *
> allocation,
> +			       MAX_DIFF);
> +		ksft_print_msg("avg_diff: %lu\n", avg_diff);
> +		ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
> +		ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
>  		if (avg_diff > MAX_DIFF)
>  			failed = true;
>  	}
> 
> -	printf("%sok schemata change using MBA%s\n", failed ? "not " : "",
> -	       failed ? " # at least one test failed" : "");
> -	tests_run++;
> +	ksft_print_msg("%s schemata change using MBA\n",
> +		       failed ? "fail:" : "pass:");
> +	if (failed)
> +		ksft_print_msg("at least one test failed");
>  }
> 
>  static int check_results(void)
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c
> b/tools/testing/selftests/resctrl/mbm_test.c
> index ec6cfe01c9c2..2b4f26013d84 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -14,13 +14,13 @@
>  #define MAX_DIFF		300
>  #define NUM_OF_RUNS		5
> 
> -static void
> +static int
>  show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
>  {
>  	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
>  	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
>  	long avg_diff = 0;
> -	int runs;
> +	int runs, ret;
> 
>  	/*
>  	 * Discard the first value which is inaccurate due to monitoring setup
> @@ -35,13 +35,15 @@ show_bw_info(unsigned long *bw_imc, unsigned long
> *bw_resc, int span)
>  	avg_bw_resc = sum_bw_resc / 4;
>  	avg_diff = avg_bw_resc - avg_bw_imc;
> 
> -	printf("%sok MBM: diff within %d%%\n",
> -	       labs(avg_diff) > MAX_DIFF ? "not " : "", MAX_DIFF);
> -	tests_run++;
> -	printf("# avg_diff: %lu\n", labs(avg_diff));
> -	printf("# Span (MB): %d\n", span);
> -	printf("# avg_bw_imc: %lu\n", avg_bw_imc);
> -	printf("# avg_bw_resc: %lu\n", avg_bw_resc);
> +	ret = labs(avg_diff) > MAX_DIFF;
> +	ksft_print_msg("%s MBM: diff within %d%%\n",
> +		       ret ? "fail:" : "pass:", MAX_DIFF);
> +	ksft_print_msg("avg_diff: %lu\n", labs(avg_diff));
> +	ksft_print_msg("Span (MB): %d\n", span);
> +	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
> +	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
> +
> +	return ret;
>  }
> 
>  static int check_results(int span)
> @@ -49,10 +51,10 @@ static int check_results(int span)
>  	unsigned long bw_imc[NUM_OF_RUNS], bw_resc[NUM_OF_RUNS];
>  	char temp[1024], *token_array[8];
>  	char output[] = RESULT_FILE_NAME;
> -	int runs;
> +	int runs, ret;
>  	FILE *fp;
> 
> -	printf("# Checking for pass/fail\n");
> +	ksft_print_msg("Checking for pass/fail\n");
> 
>  	fp = fopen(output, "r");
>  	if (!fp) {
> @@ -76,11 +78,11 @@ static int check_results(int span)
>  		runs++;
>  	}
> 
> -	show_bw_info(bw_imc, bw_resc, span);
> +	ret = show_bw_info(bw_imc, bw_resc, span);
> 
>  	fclose(fp);
> 
> -	return 0;
> +	return ret;
>  }
> 
>  static int mbm_setup(int num, ...)
> diff --git a/tools/testing/selftests/resctrl/resctrl.h
> b/tools/testing/selftests/resctrl/resctrl.h
> index 1a58767a0bd2..ebf88217f9de 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -23,6 +23,7 @@
>  #include <sys/eventfd.h>
>  #include <asm/unistd.h>
>  #include <linux/perf_event.h>
> +#include "../kselftest.h"
> 
>  #define MB			(1024 * 1024)
>  #define RESCTRL_PATH		"/sys/fs/resctrl"
> @@ -68,7 +69,6 @@ struct resctrl_val_param {
>  #define CAT_STR			"cat"
> 
>  extern pid_t bm_pid, ppid;
> -extern int tests_run;
> 
>  extern char llc_occup_path[1024];
>  extern bool is_amd;
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c
> b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 01f7aed7f54e..ebc24992cc2c 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -60,7 +60,7 @@ int main(int argc, char **argv)
>  	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 5;
>  	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64],
> bm_type[64];
>  	char
> benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
> -	int ben_ind, ben_count;
> +	int ben_ind, ben_count, tests = 0;
>  	bool cat_test = true;
> 
>  	for (i = 0; i < argc; i++) {
> @@ -87,12 +87,16 @@ int main(int argc, char **argv)
>  			while (token) {
>  				if (!strncmp(token, MBM_STR,
> sizeof(MBM_STR))) {
>  					mbm_test = true;
> +					tests++;
>  				} else if (!strncmp(token, MBA_STR,
> sizeof(MBA_STR))) {
>  					mba_test = true;
> +					tests++;
>  				} else if (!strncmp(token, CMT_STR,
> sizeof(CMT_STR))) {
>  					cmt_test = true;
> +					tests++;
>  				} else if (!strncmp(token, CAT_STR,
> sizeof(CAT_STR))) {
>  					cat_test = true;
> +					tests++;
>  				} else {
>  					printf("invalid argument\n");
> 
> @@ -118,7 +122,7 @@ int main(int argc, char **argv)
>  		}
>  	}
> 
> -	printf("TAP version 13\n");
> +	ksft_print_header();
> 
>  	/*
>  	 * Typically we need root privileges, because:
> @@ -126,7 +130,7 @@ int main(int argc, char **argv)
>  	 * 2. We execute perf commands
>  	 */
>  	if (geteuid() != 0)
> -		printf("# WARNING: not running as root, tests may fail.\n");
> +		return ksft_exit_fail_msg("not running as root, abort
> testing.\n");
> 
>  	/* Detect AMD vendor */
>  	detect_amd();
> @@ -155,48 +159,46 @@ int main(int argc, char **argv)
>  	sprintf(bw_report, "reads");
>  	sprintf(bm_type, "fill_buf");
> 
> -	check_resctrlfs_support();
> +	if (!check_resctrlfs_support())
> +		return ksft_exit_fail_msg("resctrl FS does not exist\n");
> +
>  	filter_dmesg();
> 
> +	ksft_set_plan(tests ? : 4);
> +
>  	if (!is_amd && mbm_test) {
> -		printf("# Starting MBM BW change ...\n");
> +		ksft_print_msg("Starting MBM BW change ...\n");
>  		if (!has_ben)
>  			sprintf(benchmark_cmd[5], "%s", MBA_STR);
>  		res = mbm_bw_change(span, cpu_no, bw_report,
> benchmark_cmd);
> -		printf("%sok MBM: bw change\n", res ? "not " : "");
> +		ksft_test_result(!res, "MBM: bw change\n");
>  		mbm_test_cleanup();
> -		tests_run++;
>  	}
> 
>  	if (!is_amd && mba_test) {
> -		printf("# Starting MBA Schemata change ...\n");
> +		ksft_print_msg("Starting MBA Schemata change ...\n");
>  		if (!has_ben)
>  			sprintf(benchmark_cmd[1], "%d", span);
>  		res = mba_schemata_change(cpu_no, bw_report,
> benchmark_cmd);
> -		printf("%sok MBA: schemata change\n", res ? "not " : "");
> +		ksft_test_result(!res, "MBA: schemata change\n");
>  		mba_test_cleanup();
> -		tests_run++;
>  	}
> 
>  	if (cmt_test) {
> -		printf("# Starting CMT test ...\n");
> +		ksft_print_msg("Starting CMT test ...\n");
>  		if (!has_ben)
>  			sprintf(benchmark_cmd[5], "%s", "cmt");
>  		res = cmt_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
> -		printf("%sok CMT: test\n", res ? "not " : "");
> +		ksft_test_result(!res, "CMT: test\n");
>  		cmt_test_cleanup();
> -		tests_run++;
>  	}
> 
>  	if (cat_test) {
> -		printf("# Starting CAT test ...\n");
> +		ksft_print_msg("Starting CAT test ...\n");
>  		res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
> -		printf("%sok CAT: test\n", res ? "not " : "");
> -		tests_run++;
> +		ksft_test_result(!res, "CAT: test\n");
>  		cat_test_cleanup();
>  	}
> 
> -	printf("1..%d\n", tests_run);
> -
> -	return 0;
> +	return ksft_exit_pass();
>  }
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c
> b/tools/testing/selftests/resctrl/resctrl_val.c
> index 17770095c98e..48bcd5fd7d79 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -449,7 +449,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>  	kill(bm_pid, SIGKILL);
>  	umount_resctrlfs();
>  	tests_cleanup();
> -	printf("Ending\n\n");
> +	ksft_print_msg("Ending\n\n");
> 
>  	exit(EXIT_SUCCESS);
>  }
> @@ -645,7 +645,7 @@ int resctrl_val(char **benchmark_cmd, struct
> resctrl_val_param *param)
>  		PARENT_EXIT("Child is done");
>  	}
> 
> -	printf("# benchmark PID: %d\n", bm_pid);
> +	ksft_print_msg("benchmark PID: %d\n", bm_pid);
> 
>  	/*
>  	 * Register CTRL-C handler for parent, as it has to kill benchmark
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c
> b/tools/testing/selftests/resctrl/resctrlfs.c
> index b47f4f150189..e3d18e113313 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -10,8 +10,6 @@
>   */
>  #include "resctrl.h"
> 
> -int tests_run;
> -
>  static int find_resctrl_mount(char *buffer)
>  {
>  	FILE *mounts;
> @@ -68,23 +66,17 @@ int remount_resctrlfs(bool mum_resctrlfs)
>  	if (ret)
>  		strcpy(mountpoint, RESCTRL_PATH);
> 
> -	if (!ret && mum_resctrlfs && umount(mountpoint)) {
> -		printf("not ok unmounting \"%s\"\n", mountpoint);
> -		perror("# umount");
> -		tests_run++;
> -	}
> +	if (!ret && mum_resctrlfs && umount(mountpoint))
> +		ksft_print_msg("fail: unmounting \"%s\"\n", mountpoint);
> 
>  	if (!ret && !mum_resctrlfs)
>  		return 0;
> 
> +	ksft_print_msg("mounting resctrl to \"%s\"\n", RESCTRL_PATH);
>  	ret = mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL);
> -	printf("%sok mounting resctrl to \"%s\"\n", ret ? "not " : "",
> -	       RESCTRL_PATH);
>  	if (ret)
>  		perror("# mount");
> 
> -	tests_run++;
> -
>  	return ret;
>  }
> 
> @@ -477,13 +469,10 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char
> *ctrlgrp, char *mongrp,
>  	}
> 
>  out:
> -	printf("%sok writing benchmark parameters to resctrl FS\n",
> -	       ret ? "not " : "");
> +	ksft_print_msg("writing benchmark parameters to resctrl FS\n");
>  	if (ret)
>  		perror("# writing to resctrlfs");
> 
> -	tests_run++;
> -
>  	return ret;
>  }
> 
> @@ -511,7 +500,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int
> cpu_no, char *resctrl_val)
>  		return -ENOENT;
> 
>  	if (!schemata) {
> -		printf("# Skipping empty schemata update\n");
> +		ksft_print_msg("Skipping empty schemata update\n");
> 
>  		return -1;
>  	}
> @@ -552,10 +541,9 @@ int write_schemata(char *ctrlgrp, char *schemata, int
> cpu_no, char *resctrl_val)
>  	fclose(fp);
> 
>  out:
> -	printf("%sok Write schema \"%s\" to resctrl FS%s%s\n",
> -	       ret ? "not " : "", schema, ret ? " # " : "",
> -	       ret ? reason : "");
> -	tests_run++;
> +	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",
> +		       schema, ret ? " # " : "",
> +		       ret ? reason : "");
> 
>  	return ret;
>  }
> @@ -579,18 +567,17 @@ bool check_resctrlfs_support(void)
> 
>  	fclose(inf);
> 
> -	printf("%sok kernel supports resctrl filesystem\n", ret ? "" : "not ");
> -	tests_run++;
> +	ksft_print_msg("%s kernel supports resctrl filesystem\n",
> +		       ret ? "pass:" : "fail:");
> 
>  	dp = opendir(RESCTRL_PATH);
> -	printf("%sok resctrl mountpoint \"%s\" exists\n",
> -	       dp ? "" : "not ", RESCTRL_PATH);
> +	ksft_print_msg("%s resctrl mountpoint \"%s\" exists\n",
> +		       dp ? "pass:" : "fail:", RESCTRL_PATH);
>  	if (dp)
>  		closedir(dp);
> -	tests_run++;
> 
> -	printf("# resctrl filesystem %s mounted\n",
> -	       find_resctrl_mount(NULL) ? "not" : "is");
> +	ksft_print_msg("resctrl filesystem %s mounted\n",
> +		       find_resctrl_mount(NULL) ? "not" : "is");
> 
>  	return ret;
>  }
> @@ -672,9 +659,9 @@ int filter_dmesg(void)
> 
>  	while (fgets(line, 1024, fp)) {
>  		if (strstr(line, "intel_rdt:"))
> -			printf("# dmesg: %s", line);
> +			ksft_print_msg("dmesg: %s", line);
>  		if (strstr(line, "resctrl:"))
> -			printf("# dmesg: %s", line);
> +			ksft_print_msg("dmesg: %s", line);
>  	}
>  	fclose(fp);
>  	waitpid(pid, NULL, 0);
> --
> 2.30.1

In general, this patch has some minor nits. When displaying the messages,
 normally the first character should be capitalized.
ksft_print_msg("checking for pass/fail\n");
should be
 ksft_print_msg("Checking for pass/fail\n");

And
ksft_print_msg("Please Enter value in range 1 to %d\n",count_of_bits);
Should be

ksft_print_msg("Please enter value in range 1 to %d\n", count_of_bits);

I am not too concerned about this. You can improve it if you like it.

