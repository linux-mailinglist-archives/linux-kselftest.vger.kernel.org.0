Return-Path: <linux-kselftest+bounces-5484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E608C869A81
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 16:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121341C2309A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC42C145B0B;
	Tue, 27 Feb 2024 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uDKjm25n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6433214534C;
	Tue, 27 Feb 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048202; cv=fail; b=towPv9J9gHzPi/tNJ460kQQV7JOmeB3Ccf+Az37caTnYpR2t6wbtHuSf+wfUGcoSEtVLafd0W5sJugIGbW4FkhJsdgVWauaZ2C5ay4SQXf0A6TtncdpPlhO4KmsQdOA32PfshKRfFJ2C2qPs9TeezzzsX9jtUSXRTg6R6Sp1ZHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048202; c=relaxed/simple;
	bh=PcCtbggSoMDEcQOVP8lJ+9Snj3UKd1r6LG/bcEnJPBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=maqT+r5iZPKKVyz03zZgUWEOch+khAnfZ6OShkKUqMDSX4IeA9yxQcNnsB6HU7SZVriTuqYmRDYmrC9E538zdEUHbeurq9e3XApmszuUqW8tlGovI7jWWZYItJ2kyNwoMajU26Rry8qKW6ECyKNj9uTYF19UyxAXJPe5twJAwu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uDKjm25n; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX7dzAeMdHXXTxk+k4Aj9WvwpT5IbB1DUouk+akAJoQCF87k987TBtxqrhA7Zl8l/eZ45q/avZqCYjgw9ih2Xm90jq/jB6js+fU8iZXVadtoAThKzUckjep77QBB11K3Qke0yf8l3RtLWDb+Wrcxez7KAZb/aFOXLimUfybDzYKAm8HMN8XT5sPKuZCwIseyTNfN6YSGV9skQSMa2TGk1IceFkbiDC5VJGQl5GJKcnbbbgYxVnmvSlXgHRsOuaKCE+ECsL/THHXmvO93GzQu2APR8LBJn2M0dm+3tqSlpnMyEbMNLJo75Q3OxrMYIGiQXkAvAMXNViEEcLoHahY7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhdG5P+enhd9fsvVuqNHsAKATySyARznzDQgeibv1tA=;
 b=Yr2PV96XX/wJfPnFCSgl5P0jSVpkURJjH7Y1/E8e4KnJly8VGqmuziRpsnk0B1kcqkATPQYlMq+1XLF9RROb+CbOCrFV6+m1gUomaEv/tbdBUCxmOvC2C9QXvRbPXxbPZBv8QMUk03oEROdH7NM9i3VCwMmvEadUDWouhvS1rzE1ShrGvFkaVp4jM4U45new1UdxQyCMUVI4sZ3cMWGiZEFQgycb0Z/Ylp2VzQVpBkXjcVifdCFps2k2++IkFuaMMl2vHGGueX9PpJxNRaoXiWkrP9R6U6h2yC5cMrfQ5FFFS6eYKwlEgf50+NNz72fOZuxOyoulZLBvKfCdXaRoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhdG5P+enhd9fsvVuqNHsAKATySyARznzDQgeibv1tA=;
 b=uDKjm25n9+ldwiUf8LS7gkc/X6+Lqo5CtidXvqsiAFBjV8EMnQEflA7FiXZGvtNKV/1HhW/RiXU9GIYRvBLf7OiNwFMxgkIKUPY/RU+sxRuACedLSYKvm5sw5LDWYtlGRdcGI0nhgAkJLYwltmeQWMelEkaWofMAjwHbeXIqpqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Tue, 27 Feb 2024 15:36:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a1d0:2930:8c24:1ee1]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a1d0:2930:8c24:1ee1%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 15:36:37 +0000
Message-ID: <f1964180-458f-4c22-90f6-bda2aee5dbf8@amd.com>
Date: Tue, 27 Feb 2024 09:36:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate: adjust min/max limit perf
Content-Language: en-US
To: Meng Li <li.meng@amd.com>, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, Huang Rui <ray.huang@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org, Nathan Fontenot <nathan.fontenot@amd.com>,
 Deepak Sharma <deepak.sharma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shimmer Huang <shimmer.huang@amd.com>, Perry Yuan <Perry.Yuan@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Borislav Petkov <bp@alien8.de>
References: <20240227073924.3573398-1-li.meng@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240227073924.3573398-1-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:806:127::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 838d68bf-5516-41da-42b2-08dc37a9e2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eD4n9rN81DfqDIEnMpeWBPpkcDY4sdlW9mP2aYY/VxZ9Df93qe6ZXoLCieXt/hHAdpk5G6UnP2ow9/YoL5R6+9NIVmq+bizoDMcvqmQ+/cQqowoKRUZB/gUAudCfQh3e0TaPQJjSkYFgLW+yooNLkX4+CLPAmRDLdh+mVKk9P+u4eByTcfWTy4W1X5iWBBWyCeRmkKbqMw2E93fqOcDOQu6D1q+aoo2KhPpxlhjwDX1YaZ87Yx1PmW/orXNP7zaZx5lD6Sqz50QLWaSsUhFA5/p459PS5sYMaY6yvOuWHD03a9W+7T6u6J47iEnZILGoaaHiYnm8PBdnDIP/8I9wTWMeU57GPy4xBakrK82OtHN/ws2aaD6gkj26XBMLgwX1a18AukWOM3Wb1/OAYCUePgi6bDoIa+miG9JJGceVvklBN1XNjN/XR2xuYF7fkbVzo6EjPPDtMTkgDzm3modtzmEdnyiJHp78bAH6vNp9dwu2CH6DQo65hP2YHJaUuNHlClL7NE8jq6az+CxXLkrENEEcZQzhlQF15s1sV9E0752ZnAFOkrTbFSKK5aSAKVExQQ6+NVoxk6/lDXXJC4BBL0dNXZ3YplW59EetPvz73QyQY4oBt5MpwCH9lomPwUD1zp+r/HkwxUcUAiz2P03apg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFpoK1dIQTlNZnVnRVhielFobkpDMjlLZ0VZM2JTY3BiNGZxUnU2RXB3SUd5?=
 =?utf-8?B?dUtUa3VBd2lENExGdDF5Tk5KNXRHQWE1V1VBVkdaUTRnTkxRbFJVaGIvS0lX?=
 =?utf-8?B?Rm50SWlzdlFOTkRyTlVYZmtURngxU2NDOEl5aHM5UkhVQmd3b3lKV1h6ZFBy?=
 =?utf-8?B?OGRacEVGY3pmcm1iQ3hISElxTVlyWEdpZEF5MlYxS1J6OTNlNUpReEdpdk5x?=
 =?utf-8?B?ckpTRWwvRSs1M2M0M2pwbS9CdjFON0MySWh6NTR0U1lPcERTOEJ4b2twcnNB?=
 =?utf-8?B?QW0wVnQ4WXNBa0Rtb2JFell6UCt4eVBiOUZzNU1uaytvWEkwR29HTmNjUENm?=
 =?utf-8?B?eFBXaWhmNUhzZkJNR2VHbWJYNFpCeVJobnR1YldMdDNDNTAzeHo0enlRREZ2?=
 =?utf-8?B?TFlrZ0E1WEx1TlZmaTNOR1lya1BoQXA5cThzV3hLcGZ5TUtnVlp4dHBMUXp4?=
 =?utf-8?B?U1ZIdHg2YkFLOU55SXU5WGFxbnR6MWVQV3Z0T3luNGdqV2NXYnB4RFprZzh5?=
 =?utf-8?B?NllNNnJkNlp6aTBscEhTaG5tdUhDeHNubGNHb3A1bU1ZR1FFT0NmU0xSdDVV?=
 =?utf-8?B?OU55L3RSblhMMUF4LzI3UUpvYlpwZllCLy92OTFoVHJ6TVliOXo5eUpZNHli?=
 =?utf-8?B?Z0JIRHRkN2drTy8rb0I1V1hsS01lUFdieWpMbEw1V2VIenhXN3NvOU9UendE?=
 =?utf-8?B?U1hJZFRhdnZQbjhOOENLWXhKY2VSZ2kydDMweE8yZzhRNDNRK0ZiYXpUUUY5?=
 =?utf-8?B?QzRBRTdkMGhRQnd0eGh1aGQxUGc0WVAwNUsxVmJSS2lGSmVOdmltaDVXeE96?=
 =?utf-8?B?VkpxR0NrUG04YkF2blpVR3UreElkcENwemkyTVNUT0VoWk55RmJjaG9JM0Ft?=
 =?utf-8?B?NVVaais5RHQ1cnhmUVpUMnlYUVJDQ09OZ010cWl2SFVRbUZIL3l6ekVLSmJm?=
 =?utf-8?B?WE5SSURwRTRyeFJQU3VOMDVzbFg3cVZGcnRHS213TjlVTlhNNCsrbjNIL1Rv?=
 =?utf-8?B?a0pPVG8zalRrZko4cy9JeVZwWC9ab2oyQk1Sb1hvaXFxajI1dlZlbWRkVjhN?=
 =?utf-8?B?eTVLbk9yZ2ZPUlNINFZjdUxncUlJMUxicHJIblpER3RaMGNQRkxKVlVua0ZK?=
 =?utf-8?B?MVp5a0h4L0xiQUtZVy9KYm91cThrU0N4TFROQ3NQYUVPaVlVeUgydEtyVDZT?=
 =?utf-8?B?cEhEWGh6b2VBUXJsdFU0bEpuZXM1SVptMVp6Q0pjb0tUSW0xeFhmZ2JKZWJO?=
 =?utf-8?B?SW95SUdCTmdDbENFcHdaUXVQZnVhYk0yaUlQTm1pNisrdnQ5R29uTlhUczVr?=
 =?utf-8?B?K3prMjhHbGhaaWdCV0xnbWpnTWZRZHhleEpZRTR3dTUvdGJqZVF2MXdKVlA3?=
 =?utf-8?B?VG90dlAwOVVadTNqa1ZLM2MrVWpzTnNua0dYY3cxVmVhWE5NaHZUaGhhY1JV?=
 =?utf-8?B?ZmRkMU12ZTNZWFM2azRyVmN1R01mUVoxODJEb3dhK1VTZnMzRThOdWFUMTdG?=
 =?utf-8?B?T3RpeWMyY3FwNTFDTUtVUnR5cjluaUlTVXhTSW1sZDFLV0JnOVVwWVZobG1o?=
 =?utf-8?B?T1N4ZFVVUmhQVkN4ZHlwRlRmSVh1UHA2UnNETU9oWmoxV2ZyWWtZYTM2RlZr?=
 =?utf-8?B?dFdhb3BqZUxMVmo4T3dFbUQvL1hISHFiaFdqUlVWd0xVWWJQVG9uYUZ3WFpR?=
 =?utf-8?B?aVF3bGsyb1pnRGRWbjRxNFhOVWV4QXpzckZ2clpHVlh2N09UM3JvZTBMdVM5?=
 =?utf-8?B?bWpjMU9wMXkvNUMvbm81ODZlenhRZ0dWVmdXSk1ldGFDZ094QXZvY3JTZkQv?=
 =?utf-8?B?NnpPTXVRWWs3UHFNbTNrYVdYVEtNemM2ZXpsZitkdWw1V0JmbHVLYUZ6eG9s?=
 =?utf-8?B?RVp5eW1Sbms3OG9SbWlwWWxyREVHdyt1V1VJMm9saFg5MjBLeDNkbFg4dGR6?=
 =?utf-8?B?VUdNRGJPTXJwN0JIaDd5RFJPOE83cVcrQWhWc2pqZXpXTTMrMzhmbFIxQlRv?=
 =?utf-8?B?TnQ0MVRHUG4raWpDUThGOHdMVGw0S3l5Wktva0ZROHV1V1NXcVQ1cXBHcnpw?=
 =?utf-8?B?UllyM1hMTlpaQndYVGdLTE9mdjQyUTh1amdtRjYxazZhUjdmREtqUkpGSUlF?=
 =?utf-8?Q?sSZWVMdz0aPdrJjK6laLTcECa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838d68bf-5516-41da-42b2-08dc37a9e2de
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 15:36:37.6400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77FanXQQMeB3187hML3K0CYGRChwQ95UjBEoounWYIiyEjZ2nrnvVveMd11lyO6t5Ie6Ebb/UibY76zVfpkNgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289

On 2/27/2024 01:39, Meng Li wrote:
> The min/max limit perf values calculated based on frequency
> may exceed the reasonable range of perf(highest perf, lowest perf).
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index aa5e57e27d2b..2015c9fcc3c9 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -484,12 +484,19 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
>   
>   static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>   {
> -	u32 max_limit_perf, min_limit_perf;
> +	u32 max_limit_perf, min_limit_perf, lowest_perf;
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   
>   	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
>   	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
>   
> +	lowest_perf = READ_ONCE(cpudata->lowest_perf);
> +	if (min_limit_perf < lowest_perf)
> +		min_limit_perf = lowest_perf;
> +
> +	if (max_limit_perf < min_limit_perf)
> +		max_limit_perf = min_limit_perf;
> +
>   	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
>   	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
>   	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
> @@ -1387,6 +1394,12 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>   	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
>   	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
>   
> +	if (min_limit_perf < min_perf)
> +		min_limit_perf = min_perf;
> +
> +	if (max_limit_perf < min_limit_perf)
> +		max_limit_perf = min_limit_perf;
> +
>   	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
>   	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
>   


