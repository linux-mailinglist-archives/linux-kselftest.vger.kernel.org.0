Return-Path: <linux-kselftest+bounces-5369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FBA861CD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102251F25C89
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 19:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA61514690B;
	Fri, 23 Feb 2024 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OlAeC9dA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49541145358;
	Fri, 23 Feb 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717689; cv=fail; b=opABEcSjOKHTzJ/MeRCKJQfKlDep96ES/4D6/sy21dssUkF/H96lxBVicYXQtaHhi9GoPwdy6w2n/UADdF9X9cKZOZo4pGPM6PKkuVGNXTy0MO+oVi8h2EhPU0GS8GJyGpgNza4W4dIdInH26Due3YuQifcL3rk+5qVYHWnmv/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717689; c=relaxed/simple;
	bh=ZMGWFQBu2utwM/HovH4faXBoZgSSk0IpDTw3TcVSzKI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Its8oRputVwArw+vB3AzCd6/rBKLQvrLcFw89gP4iANXiue72wAm4FP9e2v1Ntj0eqEcefhicE3xE5s6eOX1trZJA/2cyRISJJSq1QGUPruNRC2Xng6HbYuyGOiXCQrEzhx9kvYJC3oVYHu8fn9wjwJpQkYk6EzzuEezo+2wZW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OlAeC9dA; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/QStEhhk5a/hgyhgBmPWty6ehrxfWjVnXA92/7AYwbfSO236+svovvoe7caVbjfUb3WuoAS8VXbXFsIUDiM82opIqL3JKOPLNyqDlleEP/TiufVTS9Vtrl847HceoXVYuiayeMAm6YVhAxnOwPR18cT5zGCXx5HMvLX2j4iOauWhXR0ne56OiHnBXMUy+KJzBiFOrZdEQeR6/TMzKk0Z8EhjIQ0A7LXOMPwEoixzfbZMf7DPE7hKT2lm7ENNQ+rSoDxk3qggsm4oG5PTvEHh72ZQTaSNy8id/i5GVrVuOhsmJntywAvzTn7ndre4fIeQuBmVs4GvFB4zOh6B5yJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbGDGL8u3lYGSAIgaGK6/o1/FOXQE4+/o1euHkstvuM=;
 b=L2xPa2KsZCCPsujUpKRefKdsgf7J59rITrUGb+9dlu/qauCFPaEcoSDwcGspsz8qFfe0d4id783msXlJ0aZoOfKQnZ042RKn/evZEFLBHe0cuf2YjhtRddVIi8i9QItx+hwKf6sAfmqHwehgVJQTxNIVe1GlCmLYgqaQq0q0+WVnRLZlaEopNfp/4bb3voM8ssl08CzAfvZ1Lz9g1Q5yvsOiSLfpTNgjKcDrYmzf6jTmhEqCQiVJaSGAEPrt0bR7FwFSnaPJSuyGYiI53ZcFcYWAgBOXS4LMiHeHtAHgQx1rV+Ed+Ls9aAPyQFjnVjMy27OsQiXA07lsDRge4SLy2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbGDGL8u3lYGSAIgaGK6/o1/FOXQE4+/o1euHkstvuM=;
 b=OlAeC9dAjz4AKj6jiqkKoY0192FYAo4qPOakgRUMb6Pt9n16ItqxUzKE00pPH53+zMc3bwP6Y93kwEsm9T16N8rm1qy1rX0WXSc1bIJbw0j/lQhqnC/A8tnyBUGPUjXfj8wXpgFEupM/23fAzlaV4TJQftTVp4RqKR7FImR9nRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 23 Feb
 2024 19:47:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f4aa:152b:b46f:80a0]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f4aa:152b:b46f:80a0%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 19:47:58 +0000
Message-ID: <fd71d5f7-08b8-4042-b94a-e81cc68c975b@amd.com>
Date: Fri, 23 Feb 2024 13:47:55 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 3/4] selftests/resctrl: Add support for MBM and MBA tests
 on AMD
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>,
 shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 peternewman@google.com, eranian@google.com
References: <cover.1708637563.git.babu.moger@amd.com>
 <cc22790173de9978a6485baca5bc96a8ad8e05a4.1708637563.git.babu.moger@amd.com>
 <6f611a0a-f2ef-1017-07c0-5d805abb80d4@linux.intel.com>
 <efab7efe-d043-448e-bc7e-4a756b4f3367@amd.com>
In-Reply-To: <efab7efe-d043-448e-bc7e-4a756b4f3367@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2d93bc-ec54-47cf-560e-08dc34a85600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FZeh9EQhPvrhMTLUSTRfYbYga/KT0w4x6rUIZxTQ6PstSGzffzY4F3rBlRLv506nvCe+doGt+Ctucj97zSV27dlLvT4IfUAsGSq9/klIqlSBaxeoXKmOzQUTknXnoKe7WVJSqD0BLvfyzyDWTltR7EKEsX5AaJXBfJaSjDNeqHS6wT1FCxjclNd7RbeJrnCAx5FgMhrtiCmwpiZJFhjVdrlxjJ8dzLUiPidKflS1O2O3Lythor0j8z6x2+G/nunjLzc2BJSI2Bu8hAjullKXkLLPm9xF0XLMy57wXfG9htC8xmp4BoOvHWfXsSSkl5TsG1xX1NKqt4TBGrw6fviTnMWpmS/U1/RG2NnsSQljRiX8kgzP0I8Hc5+W2pWXEcf1feAGXhL/AdUJsrr6uc5Rul2x6CAA23/6K5ht0mrmkJeVX7rOvbXILbcb+5l+SdoY4SWDk0x3eUqgrU9kwjvMvVAlQjDRBHVjqe+GldR7dM6c/BCcvOOhUEAedZ962NpsQWlD+UqAdgGJ+cUqSur3nw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVMwaCt2QXExaFlnWnBIZ0NVWE05Sld2ZHNZa0U4aWJhcWIxK0g1cUlvaU5Y?=
 =?utf-8?B?N3BucjRsOFZVL3VGbUJBNmpnQkJzQXZVYkorbEZGbCtPWDBoMzF4WTIyV3Z1?=
 =?utf-8?B?RWowWEdQMTFVRnJXMUZZRlpaTmNCalBYN1RkVE5zcXlCWjdMZmhMS29tU1hx?=
 =?utf-8?B?NTM3RFRxOW5OYnpZTXNEYThXcTJTUnFLY0YvcXhFeHVuVzZubkd3cVlQREE4?=
 =?utf-8?B?UHJQaUx6NEl5QmZFUzBXSGxPT042WHVET1hZMGoxUGZtcmJya2hodVNsd0hw?=
 =?utf-8?B?U0NQUFJuVGpuYlJaS3NDY0MwV09nc1N1MmZZT0VVTEZ4TlE1TVZnZnkwSFM4?=
 =?utf-8?B?aXg3S3FHNDNENUxMYU41c2RxUEt3YVozMGpJL2hZYUJrMnFFWlhOWDBtMGNM?=
 =?utf-8?B?S2QyNkVPOGliNXRKUlNVS21HNGFPTGswWDd5Z0Nadk9YYWM3VGlCcmhQdW9x?=
 =?utf-8?B?VTAyVWwybVFtYTVWYnRYUFlraVFUTC9IYU5GL2hJWXdaVThscUNBT05zYmFa?=
 =?utf-8?B?NFhjejBuNHN4NXlyNm1VQUFKNnU3QjJBMXBtNVFZd0VhMmVXQTRicXVZL2NI?=
 =?utf-8?B?QnQ1VS9Lb2dMalV2cHAzWHAzdUtFWFJwWHN5cWJPQVRLWEhiMDVGSE5iS3E4?=
 =?utf-8?B?eFUzc05UN0Y1NjRsVy9GWDlMb1pmaE41Tm9vL1lvSEp4SjB2Y3c0YnNxWnZZ?=
 =?utf-8?B?Nys5V3BlMGt4OHZEamNSRkFnakxNNW9jOFlnUUZXdUZBTmpkSldHWDhMcldI?=
 =?utf-8?B?Q29UZlpUdVZhTC9jQmZMd0tGQVYzaHhDN3FzRVdISEpxMi9TQlR5K2lqUXhO?=
 =?utf-8?B?UjhaQWNUVXN2bDErNXBtWFFUZkE4RzFXdFpncUZJZHljc2FFQnJHOEMyTmdl?=
 =?utf-8?B?TmtJcEJ4ZUhJK3RSWnM4QTBTd3BxMVUxc2s5SFNlbnRnS3NlRUVhajBmVmV4?=
 =?utf-8?B?enVqN3NKcERHRzZyRmdON0M4VUZEWGZ5MS9YanE4RVpmR2Y4MkNvbGpCTmZn?=
 =?utf-8?B?eHg2YXlPbFg3YkkyZkU0T1FqSi90Q0gzY1FQa1hvYU5BMnBuaUY2RjFEcHlP?=
 =?utf-8?B?V0ppdkFxUXUzZEhCMHRGNHk3Z3VDWk4rYXlQSndBaUhicEc0bVdhSHZDU0VS?=
 =?utf-8?B?cmpvRWhHV3liYXJXK3BwY1pNWGZJdEhCeTJaQlpQZ2dFSDNGWXcrdkpIYXNs?=
 =?utf-8?B?Wk1hVEhRRkVzUjJYTDFuOUFXSDllY0daYVFoVU0xSTEwc2dEOUNHVnp4b28w?=
 =?utf-8?B?bHpRcVNqb1k3NmJ6MHBuZjlidGI4SE9rbnFyMUZwdDRpL3lOQTZxL1NTNDQr?=
 =?utf-8?B?TXBNbTNhbDVXeFR4dkMraDBoc3lMV2ViUWR3eldtb1d3bW11MGJ4YWFzNCtY?=
 =?utf-8?B?Uzc3ZnlBdDdCUUdhWW1TTGsxTzhqWWZZK2ZHYlE0a3EyR0REay9ISWhkNTNs?=
 =?utf-8?B?a0Zick81Y1NFTG4zSXp5T0lUWHB1T3cvNzh0WWNlY05YcWpGWTBhUUFxYktN?=
 =?utf-8?B?bEVSaXBSTHBsSmVmQ1RyZ3FVbFdmZzFqWHl6ZmFva2hGTG4yU3RoRGVsMlNL?=
 =?utf-8?B?ald1NmdTRzFnQlgxT0g1dDlrODcxdkFORGhyMGU4dGlvU0N3TGhQZFVwT0dZ?=
 =?utf-8?B?QzJyOG9EVnJ6LzBFQ1NsSmV2VjBhQ09BUkw1R3ZsZWgveVpPdG9yYkNhVUFI?=
 =?utf-8?B?ek5HejlwWXV5a01QRU9zL1ZqSm5obXJ5TCtCV0JBNmJBMFUraGkwdnV0MTZ6?=
 =?utf-8?B?TE1JVHZvNE84RkVzSDZiSzMwRzhVQTBncTlUOFhXaUZ1Q0tQSzFnalpyeDFj?=
 =?utf-8?B?NVdBSFJBZmdWcVB4S2g1L2Z0ekpWLzNvMTV0ZkVPakdJa3hzYXNoZjVkZUZE?=
 =?utf-8?B?Z0NJZnN1aFBXSTJBTkNFVUV3cnArT3c2WWdVZkFxZGppaHErcHRrYmlBZDI4?=
 =?utf-8?B?SmlZbU41SytxSnE2TVJIMHhLR1RhY1g5TklkTEtHMkF4QllLZEtoUTdSbXFW?=
 =?utf-8?B?L2lNY05ad1lHc1p2dHFiTGk2V3ZUL3pHeUF6ZXIyRnRhbjRjQmRKcFBwRkRl?=
 =?utf-8?B?V1JRVDdMUDRkWkNYVkpmeGJYVFYveUk3dkRZblJPTzRwV083STEvSC84MjBM?=
 =?utf-8?Q?0eIU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2d93bc-ec54-47cf-560e-08dc34a85600
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:47:58.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GjfY9q1FanE+/dIYPnT979noEdvKEM6pMk1PCIW2/XVa+U/hf+ousfgUO6n2nSY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016



On 2/23/24 13:30, Moger, Babu wrote:
> Hi Ilpo,
> 
> On 2/23/24 04:53, Ilpo Järvinen wrote:
>> On Thu, 22 Feb 2024, Babu Moger wrote:
>>
>>> Add support to read UMC (Unified Memory Controller) perf events to compare
>>> the numbers with QoS monitor for AMD.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>>  .../testing/selftests/resctrl/resctrl_tests.c |  6 +-
>>>  tools/testing/selftests/resctrl/resctrl_val.c | 62 +++++++++++++++++--
>>>  2 files changed, 58 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>>> index 2bbe3045a018..231233b8d354 100644
>>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>>> @@ -104,8 +104,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>>>  	}
>>>  
>>>  	if (!validate_resctrl_feature_request("L3_MON", "mbm_total_bytes") ||
>>> -	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
>>> -	    (get_vendor() != ARCH_INTEL)) {
>>> +	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes")) {
>>>  		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
>>>  		goto cleanup;
>>>  	}
>>> @@ -131,8 +130,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>>  	}
>>>  
>>>  	if (!validate_resctrl_feature_request("MB", NULL) ||
>>> -	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
>>> -	    (get_vendor() != ARCH_INTEL)) {
>>> +	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes")) {
>>>  		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
>>>  		goto cleanup;
>>>  	}
>>
>> These need to be rebased as this code moved into per test files with the 
>> generic test framework. The .vendor_specific field is the new way to make 
>> tests limited to particular vendors.
> 
> Hmm. I picked the latest code from tip/master. Where is the latest code
> now? Is it yet to be submitted?
> 
> I can wait for your code to merge first.

Oh. ok. Here it is
https://lore.kernel.org/lkml/cover.1708072203.git.maciej.wieczor-retman@intel.com/

I will rebase it on top of this next revision.

Thanks
Babu

> 
>>
>>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
>>> index 792116d3565f..c5a4607aa9d9 100644
>>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>>> @@ -11,6 +11,7 @@
>>>  #include "resctrl.h"
>>>  
>>>  #define UNCORE_IMC		"uncore_imc"
>>> +#define AMD_UMC			"amd_umc"
>>>  #define READ_FILE_NAME		"events/cas_count_read"
>>>  #define WRITE_FILE_NAME		"events/cas_count_write"
>>>  #define DYN_PMU_PATH		"/sys/bus/event_source/devices"
>>> @@ -146,6 +147,47 @@ static int open_perf_event(int i, int cpu_no, int j)
>>>  	return 0;
>>>  }
>>>  
>>> +/* Get type and config (read and write) of an UMC counter */
>>> +static int read_from_umc_dir(char *umc_dir, int count)
>>> +{
>>> +	char umc_counter_type[1024];
>>
>> PATH_MAX
> 
> ok.
>>
>>> +	FILE *fp;
>>> +
>>> +	/* Get type of iMC counter */
>>> +	sprintf(umc_counter_type, "%s%s", umc_dir, "type");
>>> +	fp = fopen(umc_counter_type, "r");
>>> +	if (!fp) {
>>> +		perror("Failed to open imc counter type file");
>>
>> Please don't add new perror() anymore, I just managed to clean up those
>> in favor of ksft_perror().
> 
> Ok. Will look into it.
>>
>>> +
>>
>> Drop this newline (to slowly move towards more concise error handling 
>> blocks w/o all those extra newlines).
> 
> ok.
> 
>>
>>> +		return -1;
>>
>>
>>> +	}
>>> +	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <= 0) {
>>> +		perror("Could not get imc type");
>>
>> Ditto.
> 
> ok
> 
>>
>>> +		fclose(fp);
>>> +		return -1;
>>> +	}
>>> +
>>> +	fclose(fp);
>>> +
>>> +	imc_counters_config[count][WRITE].type =
>>> +		imc_counters_config[count][READ].type;
>>> +
>>> +	/*
>>> +	 * Setup the event and umasks for UMC events
>>> +	 * Number of CAS commands sent for reads:
>>> +	 * EventCode = 0x0a, umask = 0x1
>>> +	 * Number of CAS commands sent for writes:
>>> +	 * EventCode = 0x0a, umask = 0x2
>>> +	 */
>>> +	imc_counters_config[count][READ].event = 0xa;
>>> +	imc_counters_config[count][READ].umask = 0x1;
>>> +
>>> +	imc_counters_config[count][WRITE].event = 0xa;
>>> +	imc_counters_config[count][WRITE].umask = 0x2;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  /* Get type and config (read and write) of an iMC counter */
>>>  static int read_from_imc_dir(char *imc_dir, int count)
>>>  {
>>
> 

-- 
Thanks
Babu Moger

