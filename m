Return-Path: <linux-kselftest+bounces-5221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 243BB85E69C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 19:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E79128933D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 18:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937638593D;
	Wed, 21 Feb 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KCwsESLM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F8285941;
	Wed, 21 Feb 2024 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541275; cv=fail; b=acIyn1VR/gtg9MB+uce+kWMJs1vzbaCJ/G38gBTgItcRPsgOnLKkjnQ2DrBvsNEWaGEVX4rQ9rMzbehQjmbKNrkmxm2x4UKXmtCzckH2oyTNTG5lgme5n6gmrnm5qA9qktoN7M+9VJaMCO7hG0oa10LShfvADROb1thTECk4c8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541275; c=relaxed/simple;
	bh=o8lUqljxvZGhcfuZR1IQtTPGVPCCkzNuxYwVKEzDbwg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dcSGOpbILpBTKrqlCrvCE8dX+ME2lVbCb4LgdiWe1q4cSp9jcIKcRHerB83z1ykbzOYW20UnvAsEcTMWxc/MMmh3HqIeIKkMknuaziXMLfnktqVm6mVsgCvqisyEu6N29WnsS/vVMxNj8F6htOHGruEFGyv3JVz4qgpUQ+uf1Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KCwsESLM; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIome5t086D74QabXfRmiBxE88XCx9p3Bj/F4TfV1uG+QtHC5tEPviGqidwpY2el8MMKuY2XWXOUt5060TBnd5B23e6TXudKNQbHb06Bl+0/nwdedfZV0zycnd7PJZ2qkwODFslvBC7fOsF3S6W33OtSJ5aP5q4fWcTQoQyts+uhUWji5YN0CTBiNeKEYjw0JZekbKhaIL8hV5Iy0dYGq2sepDwIQEFhKCGQiri+Te0xWPqVWagDaWf5rs5jHoRhmiTwOeUBc7JpZCjc/XHPNO2C73DyhGl+km4ESuVR3ShhpKdjLOJkbOia5o/LN91Kuh33bENl5YYlFfz9lxOlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLT0psKsGJ3r1dy1PAHy5a9WiB2IbS4PK7XcBN+8UqA=;
 b=CE1nNXeJv4FEjsiAvwZKArJSpVpkPhfrTa+NcNldUzGequZ8YwsZBu70spotwKbBzf18DqxcliyDCUrh+9/qDxpFGxQRysg5l7s0o+IqCMd0rCa9vADvzEDS+ITEgE0jLaX54zubdqaXM5B/sUbI4BbWCVhXGjRhLUy3xpN7k5zZM5GO7HvRmv/K6Eiqh6qAQEjjxFMbCwl22QQCoNGjlN98WMt21HDZ3LuohxsLIJYNskCdfApoPXhLhwYJIjdgUvpZnSBpu5xEX4UYfFN/a5cxusdjb4RrCyfT733udSTW/0/Efil4o0jpMEQpU7747IUpxRLdupe/L8B0kWxeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLT0psKsGJ3r1dy1PAHy5a9WiB2IbS4PK7XcBN+8UqA=;
 b=KCwsESLMHwpwVQCg+6GF6vOkK1ThSq2/5VMS99ThvsJwnKXndPiCwU/ZgsCp1mbvooi98hkvJTTHjVkNm2VaFAApw9jxo+tiefIMW3PAq7adGiDAFRSdTF+/Du9rBiNSNmChQXlWuxK1Wg7B7qL8NX8lAmy4n15V1wy9lrormDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 18:47:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dd00:9ab5:4d11:2d1a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dd00:9ab5:4d11:2d1a%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 18:47:46 +0000
Message-ID: <a92eb6e2-1636-4f80-8db9-23bbcf885337@amd.com>
Date: Wed, 21 Feb 2024 12:47:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH] amd_pstate: fix erroneous highest_perf value on
 some CPUs
Content-Language: en-US
To: Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>, oleksandr@natalenko.name
Cc: Perry.Yuan@amd.com, Xiaojian.Du@amd.com, alexander.deucher@amd.com,
 bp@alien8.de, deepak.sharma@amd.com, li.meng@amd.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-pm@vger.kernel.org,
 nathan.fontenot@amd.com, rafael.j.wysocki@intel.com, rafael@kernel.org,
 ray.huang@amd.com, shimmer.huang@amd.com, skhan@linuxfoundation.org,
 viresh.kumar@linaro.org, x86@kernel.org
References: <3868832.mvXUDI8C0e@natalenko.name>
 <20240221172404.99765-1-lucasleeeeeeeee@gmail.com>
 <20240221172404.99765-2-lucasleeeeeeeee@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240221172404.99765-2-lucasleeeeeeeee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9554d8-2e79-45ba-b4d3-08dc330d983c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LzSxSKX+xE/p/Qv42uQY7KDCUXLC0S8uLxka4gRioT9+SquqgTCAs1bHHs3QIBqnjJDBDzyo5H+Q2ZtXsPQHk9UeSid+B5Jibg9VjPwXKKG4e/aztW7XA3Jb3tcDgFeOwdGuZVWq+DyzpDjPG8LHICNNrXYb15yFkS05GBxPyLuLO9oy9TF7EQxjNZusVmwpyhHmrgkjOeh0B/7SaI1KYDMFDD0qxHFBiBi9gwEPSIzJzVDcG2SeuI3QKSIQjIr3j3pt3LKqLk1j3b6VHiDMUySkva+eA8pCBjiAwH/fbuIbJBY6bdyGIq0D+7VfXu7/0j5FjQbsoqrcfOE9mj0upYfm1RN15wNuMi7V62FLPFcHvIUIXf0+9votmyll04PTB+5jni0NN9kD/hjjVN6H4HuMHREHbk+5rE/WzP/qB4SG+Nw5z7lVdFau31Us3nrOwxaDcRYyZrrh1WxkSvzNFkwAs4tRKGJuETMHjy86Yce3n66uuqoBz5q8E10p/DP7SmMsQ6p7IIRRXBpj+cF9Qw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWdaRGFHdWZyWlZIUWdWUCtHajNVSTdkbFY4S2llRTR0YnZPWHFCR0lLQ2Vt?=
 =?utf-8?B?UXNtdTl0cG5qQlVLdmpkRWp6RUxLcVViazJhWFh4WXF3SDJUaFZZUklOcDJn?=
 =?utf-8?B?OTJ0S3h6TlJJYmFnTHNsazBCTlV2SE1uWVk2TVZ4OGJVQkV2dFVHeTdPY0c5?=
 =?utf-8?B?UkxWc3N4MUl3dlFXTkhsd1FLT1haakpRNXVmRitZOE8xRFQ2czRTVGV3Ymo5?=
 =?utf-8?B?RkhhZzJSb1N3MGlRVU5XZThoVHYyRXJoNWhMcEFmNEN1U2xhTnEvQnI2YlNB?=
 =?utf-8?B?MWczTUkyR0g1Q1gvV01RRi9YUzBvS2FaUjhXZS9vVEV6bDV4dTYyWVBjYW5C?=
 =?utf-8?B?NEpMQm10ak5PWmNpQ3pQOGZHTmw3NjdyZFdsQjRYVnJ6MG9jODlOT1c5dkNX?=
 =?utf-8?B?WEtNeGt6RTVNVGdUL2RzWnVwcEcrNDlqV2llTjRDS0l5MXZLQnU3cTN2aXlq?=
 =?utf-8?B?ZUpqMllTOEN0WXdPM0dIajE1MGZDaFZWOGhKT1F6N0tFQVgzalNjLzRwQUly?=
 =?utf-8?B?aTN6L3haQUZyRmd0M2FyOHJteDBFWjhSZHdhMDBXL2xZeDRkUlZ6TkUzcmF2?=
 =?utf-8?B?c0xTdHViU0hFbkJYaTJZcnV6WDhUUEdSVHFINkZXVjQwMUdMQUhteTNMUnRu?=
 =?utf-8?B?cUxCcWpzMGZibEdBSG13VmtRSlc1dkJ6cnc2QitrcUlld01FK3J4N0EvclNo?=
 =?utf-8?B?eS85WWNVdWJSbXhzZks5STJFdG45RFJZRmRPSDRvVTRnZE5qNVV5eTN1MUVY?=
 =?utf-8?B?RDh5QXZqaWRSNlBhTm1CSmVIczRmRm9FMzJCQTJucW9tdnBxaDViYmxCcVNx?=
 =?utf-8?B?Y2NDeUlYVUEzUWlScGdLZTVCKzZQZ1hWNEtFT1Y3OEZIM0xnYm4xS1ViMVRy?=
 =?utf-8?B?NEV0YzJCWVZOV0RQOUZrVnFjTVhDVFpmZ0hiOGVqbDdRQ25PTzROZ05wYXUy?=
 =?utf-8?B?K0hHMzI0SlVKZUlMbEMvRGh6VnF5SjRDVTY5bllEWmk4QlcwVU41ZFg3NmdZ?=
 =?utf-8?B?clZEWWYrdmlVUG0yOFRuOTJxNldvV2pHd1I4STdzandsMlQzd05sUloxWEVE?=
 =?utf-8?B?VGpNR1RQTGpXZVBNQTEyNllWNHFiNi8rdHJNNmlla1dOZ2NONnUya2s3cGNR?=
 =?utf-8?B?aHc1Q1dVTUtNQ2pUTGx1NDJwUEdUaHdWUjVyeit5QkdPWmRnd01MWXJUWTBO?=
 =?utf-8?B?U1dqN1FINmVjOUdETW5tUWxlN21xRG1QNHJscmowa25GRXFsZFhaTFFlUUsy?=
 =?utf-8?B?dll5SmY4TnovbFhybkZYYkc2MnBCMSswYkNnVXV5cEVUNVl3S0oyQzJCc0xD?=
 =?utf-8?B?MEYrdHlIaXErTGJDMWRWSFZFTnhFaXNzUTVSTCt0ZC9UNFYwOXdWcXhjdVFW?=
 =?utf-8?B?TVNvODZNcklrSTdjWXJycmpVaUh6bmoxSWMzMGN3KzJRYjM0d3pTQlUwN2Zy?=
 =?utf-8?B?dlc4RVhMVmZkNlpabGFVbXF1bnBGd1IxUmR2YkNFOThWV1hxZEtTOWl3cCtu?=
 =?utf-8?B?Ky9lUnJQcDRWZ3Q3VzJPZlh4bnpNYzVCb1JRcUNZZkNYVU1oTGVhQzNyZDJn?=
 =?utf-8?B?dTU1T0VLQ2lkQkJvaENEeDFhd1ZkRFc1MGtibzNYMHNTb096UVNraEwxWG9h?=
 =?utf-8?B?c1ZHanNRRURRVGE4bm0ydEZ3VkZaTlhJWXU2Qkc3S2g5Qi9BQVhBQlB6UDNw?=
 =?utf-8?B?eEpkSGlVVTlMK2JNYS9LL255cFgxUnd1cVZxZWRiamtGd0FLTmdIVS93Wklp?=
 =?utf-8?B?QmhqaW00bFVkS3BCT3RQU0RrNFBpenBkVU1sUFlQUDR1UkYvendPRHg1em9r?=
 =?utf-8?B?Q2lnNVFVaXdXL0ZBdys1MTFvN3V1SDNXUElWdmZHdDFBK2pFRnZVOTFKdUU4?=
 =?utf-8?B?MHJBa1RyNzA0WWxLbWJXbFhqZzBIbkFpMzZmY2dEOXdMcE9pR3BKZVVFa2Zx?=
 =?utf-8?B?OWtiTmZGeDhrQkFRRllvcG1Ua3VYQVNiOFBwbmI4OHFZTjd4Y09CK3VmRzJV?=
 =?utf-8?B?cVV2bUwyb0VXSWQrQ0svN0x5bndCSnhadFgweDZRNjlza1lxRE5EajlOUXda?=
 =?utf-8?B?TFZkRFpTdkxJQ09XcUQvOUZuMXc0K0MrS0IwV295MklPelVlRm5jdHBmZDdh?=
 =?utf-8?Q?glOd7upklYOl5IUQbrHDHcg5h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9554d8-2e79-45ba-b4d3-08dc330d983c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 18:47:46.3412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKnymOQsyxr5lg3AfUbGGYZ7uCSkGQOjPwRZLjO1N+JhihQmM4pfGYYh9+U2D2D+f6pb3qdEngYPbd/A7tO9sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413

On 2/21/2024 11:19, Lucas Lee Jing Yi wrote:
> On a Ryzen 7840HS the highest_perf value is 196, not 166 as AMD assumed.
> This leads to the advertised max clock speed to only be 4.35ghz
> instead of 5.14ghz leading to a large degradation in performance.
> 
> Fix the broken assumption and revert back to the old logic for
> getting highest_perf.
> 
> TEST:
> Geekbench 6 Before Patch:
> Single Core:	2325 (-22%)!
> Multi Core:	11335 (-10%)
> 
> Geekbench 6 AFTER Patch:
> Single Core:	2635
> Multi Core:	12487
> 

Yes; the max boost for your system should be 5.1GHz according to the 
specification [1].

Would you please open a kernel Bugzilla and attach an acpidump and dmesg 
for your system?  I believe we need to better understand your system's 
situation before deciding on how to correctly approach it.

[1] https://www.amd.com/en/product/13041

> Signed-off-by: Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 08e112444c27..54df68773620 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -50,7 +50,6 @@
>   
>   #define AMD_PSTATE_TRANSITION_LATENCY	20000
>   #define AMD_PSTATE_TRANSITION_DELAY	1000
> -#define AMD_PSTATE_PREFCORE_THRESHOLD	166
>   
>   /*
>    * TODO: We need more time to fine tune processors with shared memory solution
> @@ -299,15 +298,12 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>   				     &cap1);
>   	if (ret)
>   		return ret;
> -
> -	/* For platforms that do not support the preferred core feature, the
> -	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> -	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> -	 * the default max perf.
> +
> +	/* Some CPUs have different highest_perf from others, it is safer
> +	 * to read it than to assume some erroneous value, leading to performance issues.
>   	 */
> -	if (cpudata->hw_prefcore)
> -		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
> -	else
> +	highest_perf = amd_get_highest_perf();
> +	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
>   		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
>   
>   	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> @@ -329,9 +325,11 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>   	if (ret)
>   		return ret;
>   
> -	if (cpudata->hw_prefcore)
> -		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
> -	else
> +	/* Some CPUs have different highest_perf from others, it is safer
> +	 * to read it than to assume some erroneous value, leading to performance issues.
> +	 */
> +	highest_perf = amd_get_highest_perf();
> +	if (highest_perf > cppc_perf.highest_perf)
>   		highest_perf = cppc_perf.highest_perf;
>   
>   	WRITE_ONCE(cpudata->highest_perf, highest_perf);


