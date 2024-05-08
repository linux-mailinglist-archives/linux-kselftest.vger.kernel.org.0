Return-Path: <linux-kselftest+bounces-9732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 579128C052E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 21:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B15E1C210DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 19:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E54130AC0;
	Wed,  8 May 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JvEG0syg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9997130A5E;
	Wed,  8 May 2024 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715197223; cv=fail; b=U3C6eNNlm6+l9VhvaAeLwPA8pwoNJ8nfCAFOmcgz+SephXmM5no8op7hRiZxqys0olsuHNhbM9AVwCUU+E3FdmslB8ZCsu/EzLe+tDKwKhJUoy0udYJx+hIbGk8HSJKIDS1pY9fdWZg+lUUMveIXI8th2KbstF1iLDD93QxqRT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715197223; c=relaxed/simple;
	bh=rXjLOSNdwYOP7vvzh0bAf/djJKNTLavDGnepGRABpKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ib3Xjf4jSGosVZ6IV73PeqqJ6bmg2XbJgW9Iyjv7PK5MMw5YuwH29dCSgVIJjzrXYyIDu6sHyOKq0y4Z7KCvZJ1eBCe0CgGzGF2MSibHe2m/xR75ZMoPTEpHoXb4fgvA91clKzkC11JUrew+2o2UsPkZOs9mMxG86uwEbf3W5mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JvEG0syg; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz6D0moPIPnVEcIDfsmWsMcZ3cug06xllqpOij/Uh1KWlMTaA6lZzAg5xVRKObhHbycEtzIkURjDfjCqzyiG4kfkWBjN5RU7bqKpFaCIixLttz5jUX868P9Ukm2a87zLxsyA/ruEFpOk1tufH4pdmyO7GgSSZxh2VAFVsz73GCdk/jKgF4rEMGkjGvJBqcjyMwsO2QSY5rdOxdasjR8TZt/Gt309V5thus1tTeCabAlXFw9Ds/0HmlmMAO/MCuVjfuneIMtdTIGs7P0SHceh4KEGGml1czoYDEn2Qmb93eA5LWDLTbLlzHac6xi/zqZ+cEyryStpytug3qtGUe2nCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImkIz9nL9Hw9LhEygGDEVuNJXasdsN1pVRzc067uTck=;
 b=kmmSoz3XGqZDI2ExAx9GWU01U914ZBt/rKbRGfUaACfjn6oss9rcV7q7NeHqv4yBtHu5SUirC3cU7XbXZGkBZWjnnwsaq/7JCKqZ8xdPYDrRDy2CVntzRBS8UQqD/gtk6lw3JSdLSzINhBI9YT9spZJfvjCB/McZwHjk64YSHT9y4g8MpPP17HlnG/pERm7BNRTFMejK37Lwedvncwg9ko4zQi/SFi4ldTtEechrbORR6dJUXYTnXnRkCewgBCOu7WYWRCQUgaegatuAlCOiN5wMl/rpn9YBsWMoGsI2mIY7Tz89e/WMi3EZK9jH1+nrgpolab6zYyN+/sRrnC2xog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImkIz9nL9Hw9LhEygGDEVuNJXasdsN1pVRzc067uTck=;
 b=JvEG0sygfzRuZuOH3MPi5nZCPV2/g25rCJALejj4o/3gnu0nQTRJH8cj3LAF/TCktPKW46z8Pddikj4BI5e/qPMIm4vXAL7jnkjYy3narfQ0jPYReQtLKWA51KBzW/HUCYrYadjI3Zks4XjCD4hiELT/O6VYy6RVZWK5eZZ6/icYKxYr1sYTgR3hODqR6uCA1B2MjyvIJ4DUYeAdeAek7vNaac14GtOBYh3U6n3H9q/s2247pSw3cbEqYZNm0Nu11skaEv+FrSxJYmfX1KzsQZ/uOKvn7yfF9q7Q1XqbZrN/PW1kv1MryW10LwtPKxLvYSIiTRcKrAyObuJNcixcCA==
Received: from BN0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:408:142::20)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 19:40:16 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::f) by BN0PR08CA0005.outlook.office365.com
 (2603:10b6:408:142::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 19:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 19:40:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 12:39:54 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 12:39:53 -0700
Message-ID: <8ee4ae34-dd65-4d23-a7fb-883603780f06@nvidia.com>
Date: Wed, 8 May 2024 12:39:53 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: Shuah Khan <shuah@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
References: <20240508190254.266892-1-jhubbard@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240508190254.266892-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6ccf3a-21bc-443d-4d38-08dc6f96af1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0ZoVkZrU3BRakhrUUpyYlJSNlpaMzJUbTZDd3hBMGVGWUtWU3lONXZtT3FU?=
 =?utf-8?B?emdCdzVQTjFOb0NEUFJ5QUt4UW5DeXNNczBFOGZHS2hzWHN3bHR0dm93UHlT?=
 =?utf-8?B?NWFic21vNG1NanlLN2FPWkhNZkdNZnFNV1pqYlU4NDdtRzdjTlpRYkRDekYr?=
 =?utf-8?B?VG03cDNpekp2RWhyMC9ZTkorZ1VIazh3MkNDM0dsbmZja3NFcTBFb3pUTGht?=
 =?utf-8?B?Yk5KUFlNYUJ3MWNGcVNtczBkdmF3SmNZZWp0ZWw2bUw0U2ZZZDYxRUJXSWs2?=
 =?utf-8?B?S1grTFlESzBvMVFZWkdyQ2JmSExUZFJuVXlPUWVhWjNZUmNwVWo1bEJNMDB5?=
 =?utf-8?B?THZqY3YxMit6bHdDS3dwZEpmUTJOak9VNjRMbk9jNE42bjdhYUNkM0ltSGZu?=
 =?utf-8?B?eGF6WGpHdllRcGFKcUs5QkVDN09BcElsbzBhQ0hzeW5zbUptb3lFRmVKMWc4?=
 =?utf-8?B?Y2RiV2hJaCtWV3Y5RzJ5WGtxZFF5Y2liSnI0eVhxRHYrb2hnOHNTTVp6WGVS?=
 =?utf-8?B?bDFranF3UXdCMlhIZTQ4QlJrbGd1bzY0UHdUNTl4dlRDNXVCempiR3QvWGFm?=
 =?utf-8?B?THk2dEZmNE5kM25CYlNGbE9MRk93NDRKUUpONzdyWW1SSEduak10SnVIVXU4?=
 =?utf-8?B?dUM2d0kxL3BrNG5GcXJVY0JuQkRvTFRQOHh0NWhYOXd5dzRpTGlBckZyZ25Y?=
 =?utf-8?B?RFBMcWk1MkxiNzlQcGlUVmhrMGFJYTM1WXNVbWFaSE5RcloxOWJxM3J0elVy?=
 =?utf-8?B?cjF4L1diNTVpWmdMQjFlL2wrTG5zeDd0TFM4em5vQU1CNGh3cEpKK1ZqVkln?=
 =?utf-8?B?dmR1VHhjOFZmVlU3U3R3TStoOWFmSTY5bW0wOHhSdTB1ekVJcnZGVzU4elg2?=
 =?utf-8?B?ZlF3M3MxT0ExNEpVdkJOQk1Ocm5leE1lYmo3UlYvWGEvUXNrNmptY2ZQdEJy?=
 =?utf-8?B?SmRQd25uMTJQMWZ3Yk9na241a3hqNjB6eEVnaFdMdXJyUERQakh6SDBJaG42?=
 =?utf-8?B?WTNxMTAyRnNPOHZWdkRGQlF4MFMzNWc5VUpDbW5FMHVPdENlS3h5TGlrVzA1?=
 =?utf-8?B?OXBTc3F2V3FQc2dsdkI3Y3YyeXVrVGhwS2NHdTBKK0RrckJ1MnVpM3lNY1VU?=
 =?utf-8?B?bXZvdVRKR04zZzZHR2hUYlpPamU1UDkxQ0FmVnhIVDVCczJqQ1hONnhWQWRK?=
 =?utf-8?B?QlhpbTZwR1FJWXlUcVlBVVE5czdxZGplU2FLT3F0RWdsQ2RMeWtseWJyeVRi?=
 =?utf-8?B?Q3cyYlpMeWt2YmZGZWhoVVY3Y1VkTWpxejlXVzJKOEgwNWRFaVNhUGJxU0RC?=
 =?utf-8?B?VGszQnZEOWVSTkIvMG5rVFl5c2ZTNFA5dk5EYUF3TmNialZnVkhoaU1GaXI4?=
 =?utf-8?B?RjhiOXN1dE5BcUJkYUR4UEp5SzVvTVRqdVo4eElnM0dJWkthdVQ2YkIxMDRi?=
 =?utf-8?B?Z2hRYStTWFRnVDJ5UW9YRVhKa2JrSFBpb3ZxeXlRY1BGdytXNWhCN3g5dVpn?=
 =?utf-8?B?TTErWllyWEZrdjhVVlp6Tlh1YS9FU3lJbHFtaFhlWHhCcjdSK24xdFc2SDV6?=
 =?utf-8?B?L3JLSjEzSkhPbkkyVXFGNzdLbXlCRnVxR0xSbWhnSHk5ek1xOFRmWnJQQ2Jk?=
 =?utf-8?B?OVJzRlhCbGRiQU9CUHd3NnFxZnRoajZuWEdwQzBWaktURmRxN2ZuaFdiZ0Jk?=
 =?utf-8?B?L1FCVkFkU2dnRmVPWVducjhnVlRPQVdGVzJLUVNhd2x4aEE3YjB1WEMwV2Fl?=
 =?utf-8?B?MnVUZjE2UERPTTlhN3JPVy9WWXVyQ0xQMlRKU0twSHA2RnNTNm5nNDJ6RHd3?=
 =?utf-8?B?RUVBd2IvdUJTWFJrczYrZTE2bkVvcnBneloyNm1hR1IzdWtNZ0tCTkFwTkg1?=
 =?utf-8?Q?sYAscVDp0EeE9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 19:40:15.1447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6ccf3a-21bc-443d-4d38-08dc6f96af1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036

This was supposed to be a v3 patch. I'll resend as v3, sorry
about creating a confusing email here.

thanks,
-- 
John Hubbard
NVIDIA

On 5/8/24 12:02 PM, John Hubbard wrote:
> When building with clang, via:
> 
>      make LLVM=1 -C tools/testing/selftests
> 
> ...two types of warnings occur:
> 
>      warning: absolute value function 'abs' given an argument of type
>      'long' but has parameter of type 'int' which may cause truncation of
>      value
> 
>      warning: taking the absolute value of unsigned type 'unsigned long'
>      has no effect
> 
> Fix these by:
> 
> a) using labs() in place of abs(), when long integers are involved, and
> 
> b) Change to use signed integer data types, in places where subtraction
>     is used (and could end up with negative values).
> 
> c) Remove a duplicate abs() call in cmt_test.c.
> 
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/resctrl/cmt_test.c | 4 ++--
>   tools/testing/selftests/resctrl/mba_test.c | 2 +-
>   tools/testing/selftests/resctrl/mbm_test.c | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index a81f91222a89..05a241519ae8 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -40,11 +40,11 @@ static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
>   	int ret;
>   
>   	avg_llc_val = sum_llc_val / num_of_runs;
> -	avg_diff = (long)abs(cache_span - avg_llc_val);
> +	avg_diff = (long)(cache_span - avg_llc_val);
>   	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
>   
>   	ret = platform && abs((int)diff_percent) > max_diff_percent &&
> -	      abs(avg_diff) > max_diff;
> +	      labs(avg_diff) > max_diff;
>   
>   	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
>   		       ret ? "Fail:" : "Pass:", max_diff_percent);
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 7946e32e85c8..5fffbc9ff6a4 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -60,7 +60,7 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>   	/* Memory bandwidth from 100% down to 10% */
>   	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
>   	     allocation++) {
> -		unsigned long avg_bw_imc, avg_bw_resc;
> +		long avg_bw_imc, avg_bw_resc;
>   		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
>   		int avg_diff_per;
>   		float avg_diff;
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index d67ffa3ec63a..a4c3ea49b0e8 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -17,7 +17,7 @@
>   static int
>   show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>   {
> -	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
> +	long avg_bw_imc = 0, avg_bw_resc = 0;
>   	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
>   	int runs, ret, avg_diff_per;
>   	float avg_diff = 0;
> 
> base-commit: 45db3ab70092637967967bfd8e6144017638563c
> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
> prerequisite-patch-id: 8d96c4b8c3ed6d9ea2588ef7f594ae0f9f83c279



