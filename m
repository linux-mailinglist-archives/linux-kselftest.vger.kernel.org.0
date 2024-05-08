Return-Path: <linux-kselftest+bounces-9670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 922578BF3F1
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 03:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191191F23579
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 01:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA92637;
	Wed,  8 May 2024 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hBUS/1GZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53E633;
	Wed,  8 May 2024 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715131003; cv=fail; b=qyyxjUm880VVdNIbWPwDLHkKKBu9zqOel1n2rW7ZCGUYWa1qgsj1DpgdmON7A7AlQ6LN3E5HNc26geVeP9x8NLJkNuxomETbRAcXqURNBjYLkhyiS+ledIfRMjAZVRUV3/WxqgcSP84HS83/4qE/R7FEfg1wuw1EMqVtKZZs+PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715131003; c=relaxed/simple;
	bh=7pAvIBnJFWLsgFsGOIHaIhVe7O/HPmTBbBIx6W7vpOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GBztPzUHo4MmHBP0DnvcXQuJuNlYLn1lOyaKvj68rxkgzwjkGLbenI+lFWurTc8ENMb1LNy2F4GbDHUrS0WerGCPkJ5VsjY9wuTFRd7HRGvaPT/xAgor5z0WJuczjLRhGyzofJHljOC7B2uC3aiKvx6baD+uYtH0/ggClP+RlYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hBUS/1GZ; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTliWSUM5HJ2HZDv35OFh0knrIivSxMNbNn0VMNwJ1TdqmIjN8VZxZz7mfeD0xaDWU9I4FtvDKiEY4J5aD2MV1CyiTQ7sFqMOYQg6ms3Xkp7v8zgDVyyD2NWadXT3vPnxLJg0HisqvpM4lKjLkHFIR+UFHobBZKpjo0HwukRgDxvqL8uofmhEyp8GT7JsDmCGeQjhd2ZH+rOZkqv3JD9BYnvZnvWw4qvn1DUIhFrzcORjFGGAVCWnGQ78JGO4gGKtkqseQAGtrIlNprx2hvnGV7371w1I0Yxn+X6Y9jPnEZHLzDfjFXqeBCYqv7MbXIQuiqgYTwIuqlPulul54jXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQBvLy2SR6/ARN2c/YkUDhr1ZETM/J5DdF/hqRLQnhs=;
 b=QAi1fgwW3dwHa84bl5chiQhxfQqoZ4OoGkwVQ33o832KmEcIt5n+6GAUvXuKLZ4OMrj+yqFyybpdHYgSrdTpjaobDIg1l/qAhMAqKcVfzBEsMNlWBbLgQgx7c6xHWZchUf7tSC4wsU7mSMEsxRtXgxaH5AwhOcFGD60EwVp71dJfQbFw2xq7YLZYSmloK8Eij5RWMJH9ZRMEKCWOfSYJtXTBDNGEA5+yQNZD5bCBqOaMThDnuN4fCy38b2dYnVzJeDMv6Rj0OkNkaj6TIJ+Ktz4W1lq+A8dAlED9Wh8ID82ceKoekFb0Ay01LHG1OmPpqwyFFs8gGeRIt3aqmJNY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQBvLy2SR6/ARN2c/YkUDhr1ZETM/J5DdF/hqRLQnhs=;
 b=hBUS/1GZtWFbQ6rQFokfKeqYV+bXbaEq1xa2m0SkUJn29EW12F5Kf4jVNYATlOWvAQDHpaQtnoYsBJPOGd06g1cFn9mvwmhpc5XmCOtYsQ4zlPffr9j8lmGjKMEQbrdqEjGua/UOSIFDur1gvR9Ce/HhSo5KxY8fL2wl30zMd6j5iUgFVYsYJ0c2YzcapKUu/iBAFdn0M8y3lHYCivIF2eDMqVnCYAbyoPFVNBN38IKQ2Fcmrgt3ia2W9xdfmj0jcBErprcY/68O3EtLQ6ZWBZO3a0+Lhi9dBfs1xhRgwST1DxJaAhGZ5sK4ph8m6mv7NQ0YlX8gmK7PpebEPp2DnQ==
Received: from CH0PR04CA0069.namprd04.prod.outlook.com (2603:10b6:610:74::14)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 01:16:36 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::7) by CH0PR04CA0069.outlook.office365.com
 (2603:10b6:610:74::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 01:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 01:16:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 18:16:26 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 18:16:26 -0700
Message-ID: <997d7fe0-46c8-4b38-824d-083ab29f54ce@nvidia.com>
Date: Tue, 7 May 2024 18:16:25 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Fenghua Yu <fenghua.yu@intel.com>, Valentin Obst
	<kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20240503234051.21217-1-jhubbard@nvidia.com>
 <9ae11dcb-62e8-4361-9f78-971d4c6e6054@intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <9ae11dcb-62e8-4361-9f78-971d4c6e6054@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c7f25a-abc6-4b71-8495-08dc6efc819b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emdRQ1BOYW05U1NHdWpmWnByYUxtTGRMdkdGeUM1RVpCSmU1RG0ya0ppZHBk?=
 =?utf-8?B?RGJxdkF6d2g4VE5neHJmbnUwd2Z5Mi9GbFJFUzlSUWVMbGorMVJOZlgwakMx?=
 =?utf-8?B?YktYQ043cnZhalFGdndLMTZ0eFdQcENNOHMyaSt2ZjUvNHU1NktQK3plcDBO?=
 =?utf-8?B?bXR4SmpEbmJmOHZpZmlYSzNGVWNXdVNmTUNaalQrQ2J0dEIxRW8zdUNPdGUr?=
 =?utf-8?B?KzJJNXMrSk1wNUZzamxFRks0YWJxcnZlelZMeldMbXo3RHhrRDNKMS9GKzV4?=
 =?utf-8?B?TTBBeUozU1BYSjh6djJCaGZYZ3NBQlE4d3ByMnN2TkpmN25ZZ0hkTmZOSGlU?=
 =?utf-8?B?Lzc3UGgxcFJaTnhmMHdBRVlJRUhVRktFQm10T25YUFRzaEd3SUlJanpoWWtJ?=
 =?utf-8?B?WFI4U1JLMlFVVWNaQlpMWldxejlER2dBeVhLR055cFFjQzhDVi84T1hhM1BU?=
 =?utf-8?B?OWljcjloV3l6ZlZSdEdyUjVVa1dMRFNZM2ZnckVDNmZ2R3FHN1B0eVc3akZl?=
 =?utf-8?B?d2tPZXV5UDVWanNrUWlIKzFkUTU3L2pEWW45dEhiTHBzWTFNVmxDeVcxQU96?=
 =?utf-8?B?TldJcnBQLzZtM3JwNkhCOTg3WVRGTTVneXlPZ2d4UXZPb01sSnJLYW1VQXNL?=
 =?utf-8?B?NS9VZzMwMGY3Z0RKVjhtdVl5eXovaVhrRzdERk5SR3g4OGNJYSsxb0FCUUEw?=
 =?utf-8?B?ZWt2c2J2dDJ4dWtzSzVLZUR3L2s5d2lCUnFVTlJSV1JsRitZampHQy9LVzdV?=
 =?utf-8?B?NHZxaFlQRkNpT2VQSlkrbUxSN2FtcFMveG9RK2x2SXVZdko2UWEzT1RxTHBM?=
 =?utf-8?B?WjU0SVRFRlVnRmJDQ3hQTTVIWDI5cmkxdzNYRHIyUHlaYjhTNDVqNnA4VXdr?=
 =?utf-8?B?TFZITjlldkVuQm9SRERVUzZUTm5SWE53YmZyMkF4UUtOMkpyUU9nc1ArQ0JN?=
 =?utf-8?B?YURSZFFiaStFeVpBZ0xIOHpyQmttODRxWW5WL0lYbkc4NStOY1A3Y0NNWjkw?=
 =?utf-8?B?WmVWUGhyNUVFZVlUUnZoYUtnazhwa0VrdjJ0U211bnlSNkd1UmhheGNUakJH?=
 =?utf-8?B?SHpuTmc4eXVtQWFSeXRzclBWQmtQa1VmTXo0VzFFZG1oYXpybnF6dTRUc05v?=
 =?utf-8?B?bW9hbEl6RU9JSXhPMlg5NG1YMGJkU1M1N2tqZXE2ZXk5YzBjS1R1NGFYVkJh?=
 =?utf-8?B?bUxsOE5tVDIyT0JMRUsraUxPNFlMcDcxaldUTGpIYWFQWXVEUXI2TStNQ0JM?=
 =?utf-8?B?UmhRVTFUVk5HQjNUZjQxYlJiWTlQSXpZR1BDYWFNUm9wVUtPVkpIQnlRaTJM?=
 =?utf-8?B?ZDYyM2lHZ0I1dlJBRm5sbWNFNk1hMzU5R2dkUDNycnc1QU5jQjliRi9XWFhB?=
 =?utf-8?B?am8zUW1jQ1d4bTlpem02c0o2cjBid3huMkgvTEJFWU5jTWVCdnVYVWZ3Y1Zw?=
 =?utf-8?B?alo5V0R5N2tXZUhNTTVUamp6cG9UcjNIOE12bElYRnB3TXJCTCt5aWYxbk1Q?=
 =?utf-8?B?N2dTd01GSzg3UUVVd3QvNWFsOWY1QjhDWDQvb092YjRUa21janhPSU1nNmVz?=
 =?utf-8?B?cFlTMEplbW84WnBLVHQvYU5GNlZSYytxTjdlNnZqNHI0RFZ2S2svY1U0bUhB?=
 =?utf-8?B?S1ZqUnpjYlZ5aGkxd3B1UmU5dmt3eWhvR2oxYi94U1lWcnArQ1cyMHQxYWVP?=
 =?utf-8?B?T0Q2VCtieHFBOWk3S2FFWlREM2FPeVVGOVpmTnBBdFdxNFJINEZLYmFuMm8v?=
 =?utf-8?B?WldSbzArQVBZYk5DUXNyT3ZMdS9TVC9lb2NKam8rOVFFMHdpc0lEVnJySElL?=
 =?utf-8?B?aDRmQVNHSklPRG5ZRU5Kd1cyU0Z5Z3d5VkJ2T0kzRWl5R3BRWXFZd1RzTlRv?=
 =?utf-8?Q?ayBpCyrZfbjXR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 01:16:36.3472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c7f25a-abc6-4b71-8495-08dc6efc819b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226

On 5/7/24 3:30 PM, Reinette Chatre wrote:
...
>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>> index a81f91222a89..af33abd1cca7 100644
>> --- a/tools/testing/selftests/resctrl/cmt_test.c
>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
>> @@ -29,22 +29,22 @@ static int cmt_setup(const struct resctrl_test *test,
>>   	return 0;
>>   }
>>   
>> -static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
>> -			     unsigned long cache_span, unsigned long max_diff,
>> -			     unsigned long max_diff_percent, unsigned long num_of_runs,
>> +static int show_results_info(long sum_llc_val, int no_of_bits,
>> +			     long cache_span, long max_diff,
>> +			     long max_diff_percent, long num_of_runs,
>>   			     bool platform)
>>   {
>> -	unsigned long avg_llc_val = 0;
>> +	long avg_llc_val = 0;
>>   	float diff_percent;
>>   	long avg_diff = 0;
>>   	int ret;
>>   
>>   	avg_llc_val = sum_llc_val / num_of_runs;
>> -	avg_diff = (long)abs(cache_span - avg_llc_val);
>> +	avg_diff = labs(cache_span - avg_llc_val);
>>   	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
>>   
>>   	ret = platform && abs((int)diff_percent) > max_diff_percent &&
>> -	      abs(avg_diff) > max_diff;
>> +	      labs(avg_diff) > max_diff;
>>   
>>   	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
>>   		       ret ? "Fail:" : "Pass:", max_diff_percent);
> 
> The changes in this hunk are unexpected. The changes to this area made by previous
> version was ok, no? It really seems like this just does a brute force of everything

Well, not entirely. That first version was when I still believed clang's
claim that abs()/labs() was a no-op. I've since been corrected! :)

> to long (while taking labs() twice) unnecessarily.

Which part exactly is unnecessary? Are you looking at the function args?
Or something else? I've stared at it too much and am not spotting the
issue yet.

> 
>> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
>> index 7946e32e85c8..707b07687249 100644
>> --- a/tools/testing/selftests/resctrl/mba_test.c
>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>> @@ -60,8 +60,8 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>>   	/* Memory bandwidth from 100% down to 10% */
>>   	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
>>   	     allocation++) {
>> -		unsigned long avg_bw_imc, avg_bw_resc;
>> -		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
>> +		long avg_bw_imc, avg_bw_resc;
>> +		long sum_bw_imc = 0, sum_bw_resc = 0;
>>   		int avg_diff_per;
>>   		float avg_diff;
>>   
> 
> On second look it only seems necessary to change avg_bw_imc and avg_bw_resc. What do you think?

Yes, that works! I'll change it.

> 
> 
>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
>> index d67ffa3ec63a..30af15020731 100644
>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>> @@ -17,8 +17,8 @@
>>   static int
>>   show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>>   {
>> -	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
>> -	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
>> +	long avg_bw_imc = 0, avg_bw_resc = 0;
>> +	long sum_bw_imc = 0, sum_bw_resc = 0;
>>   	int runs, ret, avg_diff_per;
>>   	float avg_diff = 0;
>>
> 
> Same here wrt the avg_ variables.

Also yes here, I'll change that too.


thanks,
-- 
John Hubbard
NVIDIA


