Return-Path: <linux-kselftest+bounces-5361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83136861B37
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 19:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAE51F228BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17CA143C45;
	Fri, 23 Feb 2024 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1LfqYNAZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AC6142627;
	Fri, 23 Feb 2024 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711894; cv=fail; b=XP/5UIJvRdvpaCjVHEC6BJrlDUgXzlXXyYhMWbNEBJ3YlXC93XJ15SOGHebA2NvAPqgHKu5wQoqWr/ceNSqdYd/uRrzJ2bArwSh2IMOz5uOCQJhGfd6HdMYK1lylRaBnP0cZcodPGksvFqfGMBJkIdUC2B5dbRwjNSu6Z9joQ7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711894; c=relaxed/simple;
	bh=oKWTE/2IvdDt94F9sL7PlZB3s4ClIHCIDa1N5nCsTNk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XKtA77/49Xw49ANtVjFQ55GiZIQtBLRDWFgboAb7E0DSWiAxM/U1sGy1j9gRhFWulZY3GG5URxAfBW5uRhtFbgiOEqj7OMpSSXskN1tuVEm40qdOioodNf80Q4hA8i64ffxM4BOJgBENn4SCPlSz79lCV2VPINNF2pqOzkHUxyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1LfqYNAZ; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X473ZvKZDG7ElfpTU96zbRo0mft2uggz0I7RTnEfV5pZlEqSBSXUjPAXTvqh8/Hc3UNeiPyUAG2ldglpEtGfFjKnlsNnDN/BlT1ZNf7LkDb3gBvL4KlVyDXKg//d7YnTYw25PN/2rQGv4inD6rB+fs/6KAE0OcijfXopHyBjkp5CVMR2kNQbatnV+YQyyeQ5yAap6Li05RiFht8CV3ul2PdWszTnGO+3HQ8rkgaxA/G3o6so6h5C4snRM+EOIXaNdKrCEgkrT8rQOGYfU+nIh6e0GY3xzcfVRh30qWtAZdw9nhi4fTpFJTBySYaC8sbBNoEIQ26eQ6NpuQxFMOAEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yuol3YOFZyBwTFcsHwW0VqOzgyY9yn67UgcBJV4HL4A=;
 b=mnQxmyPtyoN+o/f1McWVXcUasGPoJFvbpCTjCsquU9l594FSCriPoVQMkrVDKA+ZWy21arcXw5INj4rhm5OfYf7g6z5hM8AZ3ML23+1CfR/U1oO4/xQTXmLfqoYOSOgmq2140Gv4uNDKYdMbahpYT63VTPT9qRSyUiJMdjAS95LHl8nY0fqiQ4Rei1iLACSUbIM3m6SQ/URbO1OTqbuJn5mdsJ6djYdg33SsUnipRXiBSUrNo7KzEXwxsiP1GTHls1lROkuzDkpDARongzUfH9G0kR5FUbgJyhVWa1cDPsyBjBUjWvyHmzG5pYkK7ff7ZVDd3LtMFIOvQuMzQrmJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yuol3YOFZyBwTFcsHwW0VqOzgyY9yn67UgcBJV4HL4A=;
 b=1LfqYNAZ3rjx1Pgg7yMmUBbxd2jCSJBTgXk2ijfxSPA0kIT280nATJgStSyqzuEDRMqkgQEjfToXF8w/Es694/TtqwV6k0x71heKG+h41JYex5gF+0jZZGskrcefqqmOBvjZsKrVEYOukiuuclWKvghsskCmqFHdF6Pthw66ACw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 18:11:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f4aa:152b:b46f:80a0]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f4aa:152b:b46f:80a0%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 18:11:27 +0000
Message-ID: <83c38ebc-daff-4531-9a86-a95c84501d99@amd.com>
Date: Fri, 23 Feb 2024 12:11:24 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 1/4] selftests/resctrl: Rename variable imcs and
 num_of_imcs() to generic names
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>,
 shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 peternewman@google.com, eranian@google.com
References: <cover.1708637563.git.babu.moger@amd.com>
 <458712890b9ac90b9e027ac1500881aedd58068c.1708637563.git.babu.moger@amd.com>
 <8e4badb7-6cc5-61f1-e041-d902209a90d5@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8e4badb7-6cc5-61f1-e041-d902209a90d5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: f639646f-f52c-4de1-3cec-08dc349ada61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VWf0r1RCBWD5k+/j7NPnhVabMoo+/W4sEVSYMXHKAyJU0xzUr+dESg86M9J6qA/c26Dzt7ztw3Am6fBmb+6KWQQPWT4wnD0+Tb5ItmkGOekoTcjS+TxwGjzEQ1wSX0nedBrWRsccrHL/3K1swZ+qvEJ6jtMRN4VzFcpy++t+r3QKTGQwRVp8TyPd5FOuFtu2rONkv7TcWi3qfWzcrAKoOI55BNsdfDAjkVrAU7q3IR0xQ02kutKKtpoW6iEF2INDAvbWJQkNCZKpzCFyCEZv5Us9GMGLrO2faMioJI7DrGEleeHyqniW2iMKZ2KrV1eXuGnOZiW2BvxKL6+wRc5vObaY0tWyu4zW2byGXWGJXy71cTH6tUfi/s/3l/aKpFX6I6G73gM95EDDaCAPbU5LiH/CIor5S/C8qf7CHdJTk6sH/zApqKH0sfwBHqhGas3UlFpg+5cbH4oNzk1R7ZyW+h2i9YHNla8/tsnsqF6j8HPp9wrODSAWob5EXAUTWVdLwHdSZZBfy81NhZOlU93/hWH3irIWPoa+niFnPzKaEfE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2syME9QUFlzbEwzRmdzZnFDTUJvcjc1WW9zN3pOMnZXYW5ReEpRb3RhVURz?=
 =?utf-8?B?RmExQ1NiUk5Rb1l3Ujh5ZlcxR2xQUW03TU5HMUdKUloxcFZMWEJwZVpvWmNi?=
 =?utf-8?B?SExrdlBqU2ovZUlUQlpPUEpyeXZ3dnVyVGtOcGdjZ1U1RndWNjhTdW5rUm1r?=
 =?utf-8?B?c2RoL2c2THlhYTRnbTdKTG1ZTTJqK2ZWWHVabzh2ampMMS8rUm9tenZCOWdU?=
 =?utf-8?B?ditXcE1wOENLMTNqejV5YkdLYjltYVJKSXptaFNoV1B0SzVrQy9Fb2xkNE1X?=
 =?utf-8?B?Z0svM3lreENzM0JHdHR4OXdROVRVc1FzV1VkTmxvNmJuRWd6WldpVUg4ekxx?=
 =?utf-8?B?bVV5YUdxZklEdEh4cER0RlBuaHNicm5URGpob1pWWERvMnR2RXllVDlpTzNF?=
 =?utf-8?B?MUZ1ejNVZEk3MGJHQTRUL3czS2lYOUhyTTUrbURiSzQ0Rjh4aERSTWlGQ2VP?=
 =?utf-8?B?WFhOVk8wVlNTQnZUNDFDRlZ4SEM1R0NEblNzdjk2RW10b0Z4SDJzYzdLOGQv?=
 =?utf-8?B?YmlTMElMRGZlcVI0ZkVjbVNzNVM1WVRMV0VkZzYwTlFZdWJzTm0ycTNibEdw?=
 =?utf-8?B?QWhqVnRHZHdnMW5EclBGMFNkRlJVOG1PTXBqbktCZSs3KzJlRWQra293QklC?=
 =?utf-8?B?YVI3WUVUaEUvTGNnRTZqVHRrbm1CMGhKcFFUamgyRytoTE1WQmRrdzJRcWRP?=
 =?utf-8?B?allaZDc4MUlzbDZWNmhUWjhHdVpLN1pWQXgwdVdxUWNmRXlWTWh4dUMzWnpy?=
 =?utf-8?B?RzhHOGxocFJFNEhjdE5IbWp3S1pQNGdqQ1B3TnMrZnFRVWYvRlNZcGR0SzUw?=
 =?utf-8?B?KzA3aDB6dk1hT0h0TS9XT0Erb1RmQldOL1FUVStMeGZ6ZXpJNWFRWDI4UG1v?=
 =?utf-8?B?NVFUWjlrbElTUm5tUkQ1ZVhwbnFGTmMvdjhQOWEwR0dLWE1BZTZubWh0V3N0?=
 =?utf-8?B?ekhwRjJia2dkTDFBNjNXWnllZ2gvNUNJaGpjbmpaaEwxWURVQXJESUdvamMw?=
 =?utf-8?B?NitNUmhGaGx6cHE3U3llMHRKeVV1OEZFMzAxSGsrYm51blFXb1M5VWVDK21L?=
 =?utf-8?B?MHRIZUxndWZlSjBvaE9yYzNsWkFFaUM3eU9QdktLYlA0QWJYV0pMUHM4VzVr?=
 =?utf-8?B?ejBRUVF1NmNaSkM5dmpZYTVFVVZjczEwaVMwQzhVckJwTkFiVGgxTTBTdy9i?=
 =?utf-8?B?WXFDZ0JVakJnWERTeXBjYmhiYm1UL0J0Uy9KMFo2YmtFQ2ZhQWdmelhPazBx?=
 =?utf-8?B?WS8wblBDNEZvQmNvOGhpbmxnQWhCcmN5QVJBRm5XMXcyNXhENC85MWtPVm5r?=
 =?utf-8?B?VWM3SXhON1FRd2d5dzQwaitGblJYUEwwbEY1ZjN0a1JzNWJ1WVNNWGJnRGNO?=
 =?utf-8?B?aXg1MmpEVzZjZU01Wko5VjR4bnNWM0N1RUtTdW5mUTZXcXlVUWFLRThtdkVX?=
 =?utf-8?B?bkpDMWs0M1ZUSHNxL0Qyc0dUYkZ2SXZ2NXhUNnU3TEpMMm5WU21iOHhMMVVT?=
 =?utf-8?B?M0U2a2pSYUFMeFBYd01mbzMvL0R3WCttM0s0dzBEaUdUUGxBeno4cFZTZzR4?=
 =?utf-8?B?VHNRUGI3ZFRZZnBjODQrQzJ5ME1RL0RYNTVOTEhHOHdCdGZqTjNTYjRYQ0Jh?=
 =?utf-8?B?cWlKM1V3UGdZbms3NG9UNjc0TW5NZlJXeUhyNFVGMjZSK1JlTkhObm5MN1Ru?=
 =?utf-8?B?aEoxY1BzbUlYMFQzS2g3b2JTaFBONks4SmRVZ0NJSzVsY0xaZk1pVThBTGd0?=
 =?utf-8?B?Unh2UTc4M25yU0tRd05zMTVJcytQUkJnT2tXNE5YQTF4YVV4bGVzRmxTNEl4?=
 =?utf-8?B?QVEvbjRRcW9lUjVhbEZ5ZCsva29DMGdybDVWNnB4RVZTUlBMWWJWSk1tRHBG?=
 =?utf-8?B?T0paTEV5aW5lQTBPK3cvM3ZyS0dUbXNYNXpzUmZZMjRBWHZLSkdHWVp5bi9m?=
 =?utf-8?B?TlFDbVhuR3U2TXgxaFF0K0JBeU5mcXRHRHVRUXdZSXVEQmlyVXBIbmFJVkpz?=
 =?utf-8?B?T24raTZkOVNRZk14OThnaVUxeDA1TTZWVld2bW0rQjhIN1FsTWlJZlVMRjV5?=
 =?utf-8?B?MTlyZFI1RW8vT3JOYW1FbkZvNHpaTEJzS2Jta1pYVE01ei9mdUt2Y1AvNmJS?=
 =?utf-8?Q?pwhg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f639646f-f52c-4de1-3cec-08dc349ada61
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 18:11:27.4200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjCvOmfZJQ+TrDbhDLeEOJAkGm5ltE34ZfVA7ihCdORGb6ZfKjOSoDx2HP/ToFKX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864

Hi Ilpo,

On 2/23/24 04:38, Ilpo Järvinen wrote:
> On Thu, 22 Feb 2024, Babu Moger wrote:
> 
>> In an effort to support MBM and MBA tests for AMD, renaming for variable
>> and functions to generic names. For Intel, the memory controller is called
>> Integrated Memory Controllers (IMC). For AMD, it is called Unified
>> Memory Controller (UMC). No functional change.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  tools/testing/selftests/resctrl/resctrl_val.c | 25 ++++++++++---------
>>  1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
>> index 88789678917b..52e23a8076d3 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>> @@ -60,7 +60,7 @@ struct imc_counter_config {
>>  };
>>  
>>  static char mbm_total_path[1024];
>> -static int imcs;
>> +static int number_of_mem_ctrls;
>>  static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
>>  
>>  void membw_initialize_perf_event_attr(int i, int j)
>> @@ -211,15 +211,16 @@ static int read_from_imc_dir(char *imc_dir, int count)
>>  }
>>  
>>  /*
>> - * A system can have 'n' number of iMC (Integrated Memory Controller)
>> - * counters, get that 'n'. For each iMC counter get it's type and config.
>> + * A system can have 'n' number of iMC (Integrated Memory Controller for
>> + * Intel) counters, get that 'n'. In case of AMD it is called UMC (Unified
>> + * Memory Controller). For each iMC/UMC counter get it's type and config.
>>   * Also, each counter has two configs, one for read and the other for write.
>>   * A config again has two parts, event and umask.
>>   * Enumerate all these details into an array of structures.
>>   *
>>   * Return: >= 0 on success. < 0 on failure.
>>   */
>> -static int num_of_imcs(void)
>> +static int get_number_of_mem_ctrls(void)
> 
> It's a bit odd to shorten "memory" and "controller" but not "number". In 
> fact, I'd prefer to use "controllers" in the longer form because ctrls 
> is ambiguous ("control" vs "controller").
> 
> So perhaps num_of_mem_controllers(void) (or that with get_ prefix if you 
> insist).

Sure. num_of_mem_controllers looks good.

> 
>>  {
>>  	char imc_dir[512], *temp;
>>  	unsigned int count = 0;
>> @@ -279,12 +280,12 @@ static int initialize_mem_bw_imc(void)
>>  {
>>  	int imc, j;
>>  
>> -	imcs = num_of_imcs();
>> -	if (imcs <= 0)
>> -		return imcs;
>> +	number_of_mem_ctrls = get_number_of_mem_ctrls();
>> +	if (number_of_mem_ctrls <= 0)
>> +		return number_of_mem_ctrls;
>>  
>>  	/* Initialize perf_event_attr structures for all iMC's */
>> -	for (imc = 0; imc < imcs; imc++) {
>> +	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
> 
> So you renamed imcs, but not imc. Perhaps the variable names could just be 
> "mc" and "mcs"?

How about mem_ctrls ?
> 
>>  		for (j = 0; j < 2; j++)
>>  			membw_initialize_perf_event_attr(imc, j);
>>  	}
>> @@ -309,7 +310,7 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>>  
>>  	/* Start all iMC counters to log values (both read and write) */
>>  	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
>> -	for (imc = 0; imc < imcs; imc++) {
>> +	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
>>  		for (j = 0; j < 2; j++) {
>>  			ret = open_perf_event(imc, cpu_no, j);
>>  			if (ret)
>> @@ -322,7 +323,7 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>>  	sleep(1);
>>  
>>  	/* Stop counters after a second to get results (both read and write) */
>> -	for (imc = 0; imc < imcs; imc++) {
>> +	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
>>  		for (j = 0; j < 2; j++)
>>  			membw_ioctl_perf_event_ioc_disable(imc, j);
>>  	}
>> @@ -331,7 +332,7 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>>  	 * Get results which are stored in struct type imc_counter_config
>>  	 * Take over flow into consideration before calculating total b/w
>>  	 */
>> -	for (imc = 0; imc < imcs; imc++) {
>> +	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
>>  		struct imc_counter_config *r =
>>  			&imc_counters_config[imc][READ];
>>  		struct imc_counter_config *w =
>> @@ -368,7 +369,7 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>>  		writes += w->return_value.value * of_mul_write * SCALE;
>>  	}
>>  
>> -	for (imc = 0; imc < imcs; imc++) {
>> +	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
>>  		close(imc_counters_config[imc][READ].fd);
>>  		close(imc_counters_config[imc][WRITE].fd);
> 
> I've a yet submitted patch to convert these close() calls to use the 
> loop approach which is consistent with the rest of the code, since you
> will end up touching this when you do imc -> mc rename, it would be 
> preferrable if you add one patch into your series which converts them to:
> 
> 		for (j = 0; j < 2; j++)
> 			close(imc_counters_config[mc][j].fd);

Sure. Will do.

> 
> (Given how long kselftest patches tend to linger unapplied, it would 
> make things a lot easier since those changes will obviously conflict 
> otherwise).
> 

Actually, I can wait for you to submit your patches.  Let me know.

-- 
Thanks
Babu Moger

