Return-Path: <linux-kselftest+bounces-9739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141E28C05BB
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 22:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372881C20F0B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 20:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E77B130E3B;
	Wed,  8 May 2024 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rwhv2PSA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B4F12A17F;
	Wed,  8 May 2024 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200370; cv=fail; b=fBkXVxPb5ExMjHOHgkLY8EEyrQc72yEyxouuzU+I93oIw4FawDOEZhmX2Ts+QW4ZyvOgMzklVoSCPB3TyLbocjIBX0hKPn5sa/ARn933U9PY/Z8lwaCiiyQDOOhXmHCj9XBAKBW0godCaAKVvNy3W3bgI/wZPrRzT1xa5Nfk7mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200370; c=relaxed/simple;
	bh=v0KfbpCysaAiEQ82iCMrio1L9fLmlgod2OoxoCiQnWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jpg1xLUeHZgveoUhspMYmcspnhLO583WmP1yqYBHpQFBH8NTDrupYRIvYncLh/K6OxBJYKHvLlI2/18LtnqQlSMK8lnl2I8qwc8fNHEZMI0vGH7+gnMkAzX2ZdT6x3x+JU/7LrK7We3BE/KL3yr3J4EYQMXgcO4jvxMjp41Ih4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rwhv2PSA; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/EOFFPiGK8mbtQFwRI5CZrcw0YTQlC3Q4BFdi1Fahobr8+ueo1I2CGJ9Z0m4/eYizS8zX+0RpNK/OFKlwjlnUx5Z1qE8JVVkf3/B+gz4MJTIe60DHedU2Qob9x13WEqJfygvMKJ3kcsnBZvB5X0MXHKtVcD1Z7owroWljMiHqDrsnhtBnuwcUb9AJnMuC50pfyZrxQIMsteJcDDxgvm/PmWLNJ6nBInkE/xADFVU6kZ2ilgOCt1zM1DDaBxNNtnh2HQva07FHEW3z0+cU8/xibwzy0HOkDOiYvSujh2WX1XGicgqbiPFDAXE6IbdMeAuYhuqHuysibtzi7QpQBa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IENO1pmBLpWY40t9GwJjTG6YOwDxOUY/FhOpJYM1+Mk=;
 b=cynk5jRh5aAsqx+HKiZF+88l14gyb1F0NEL0QWzEA5rxWOtJsljiiD5TL25h/6YX9RcJxFhiKQZPG9ujcV3RMvp1vqIyrYxnvGR+eB4wH44OXexCvpHQ6WTDwVettSXmKKLEYwOJWbF5OIEcLx0gmrdV+jvIdPSWBGc1IsRQysiw9jQweuMszKUHyUaxtmIDtvkje9NNHVsvQIFHSZ40bbM7rLSgI+jsW2TvdJloFoKy2TaNJMrDKYXQ5lnsViJuOZljqmo4pk1/dsHhI3HThJ/SnFOwMbV4/3xZMoS1J4lumK3RCvxSaKttiDCQhQKkBu1jz1tlg83saO2yh3ILSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IENO1pmBLpWY40t9GwJjTG6YOwDxOUY/FhOpJYM1+Mk=;
 b=rwhv2PSAM5OTAJnS6gvx7uCQzI58IncfXE/YogidnJwaDKxNUIDnmwpSFIXBgbl/o+TPBTD7eh8sNStButNYkkTaYf4WfRITxjbLfXSBKjxxHihRZtm43x/LPwhTOaSrbRMtH8C3k4zPbu4GjC0JdHXXUXcXdCIPAN4KMmwCO7KRUdYeKo+L8gH5xmpc7OOLXIIeYXM3iPRPOvKEhI3cVsR9vrbBC3OA0yHfLaN0c4AWtOlAnH5DI/bTYKswsgYy1lgKavv6WIn7eD7OAn4h7Nht0qEwRt0UjajbSkC6k4vDknLgVnG+tsf3RMxH3S7E3I2ksAwbSz1zXUU4uYubvg==
Received: from DS7PR03CA0221.namprd03.prod.outlook.com (2603:10b6:5:3ba::16)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 20:32:44 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::66) by DS7PR03CA0221.outlook.office365.com
 (2603:10b6:5:3ba::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 20:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 20:32:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 13:32:22 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 13:32:21 -0700
Message-ID: <7aeeb366-e28a-4b6c-a9c4-dd16882fd1a1@nvidia.com>
Date: Wed, 8 May 2024 13:32:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Fenghua Yu <fenghua.yu@intel.com>, Valentin Obst
	<kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240508194132.269168-1-jhubbard@nvidia.com>
 <2f172ee0-1c9a-4637-b2fd-574acb9a69a7@intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <2f172ee0-1c9a-4637-b2fd-574acb9a69a7@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 064edbc4-2212-4ddc-a552-08dc6f9e043d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHpRTVhsTlUxMThNMFFpN3ZXbEFHR3NjM2FFaDNOUTY3aEJLVEpUaGdHZkRt?=
 =?utf-8?B?VWp3dGUxYVBUdCtQR3REcUx4bm5IUUJRNlBZMkZEOXVac1hIbmVZcVVYbCtQ?=
 =?utf-8?B?U2FVK1k5RW1jSnBWSDdIR0ZTS3RaRmRwWDdZVlVGVEh0V2djMURLN2R5M3F1?=
 =?utf-8?B?NFVlWmhxZzc1NmJOczhLNnRMVVpCYUl6RXo0dXNDMUVLRW93REwwaW56U05K?=
 =?utf-8?B?eXVOYjMrTm5vc2s1L29QKzk0dW9SZkFtTG5MU3ZCRW9VUHB0bzEzTWhOTTAx?=
 =?utf-8?B?ZWZ2T2UzbGlLT0xZcXVsMUlMZkQzOGFBSzMvVHdJalc0NHIwWHNlZ2x4QzQ3?=
 =?utf-8?B?NkFKZkNPOGtJOFJoME1xWVFqYWllc3JuNm5pWkpsWTF0T212UTgzMzZOQysx?=
 =?utf-8?B?cFVLZTZtSURvUGZrdTA1ZmVNSEJoWFpNVFVJUTN2OVhBUFk2ZndGZWFKT1RD?=
 =?utf-8?B?THhWQ05Cb2V0T01HK1VDeTkvMC9yUURXSXRNQmxJNEx2OGZnVzBLQUdmTjFQ?=
 =?utf-8?B?c3JSU05aMTZRVWtmK1Z3cktKMHNYejhtTkcxaGYraWszMWJwTTBFWG83ditN?=
 =?utf-8?B?elZPRFU0UzBzcHU0blpVRHdpaFFxb1J3ZG95bjFIb2R3ZHNpLzcyMnB1Wldl?=
 =?utf-8?B?OXRQWlFMbnlNKzlNS1JWbEozcEZQQ2FKZkpFUnZZMEMzRUxCdjVqb2lYaXRW?=
 =?utf-8?B?by9xazRtNWhHSjRMb2w3aks2MDlQY3Uyc2lXZ01UZlhXWFVHN2FQeG53cWRq?=
 =?utf-8?B?Q0ZPN251bXBxS3JpTjhtNkFGcTZTU1p1cUZSN1BpUGJUOHVKTHZsY05tcldP?=
 =?utf-8?B?UVhGaHRBU3REbExPSllXVU5qNG5janE1Q0ttSUtRUCtJV2dURndrdERkb0U5?=
 =?utf-8?B?c0pDZXBRV25UUHEyWmtDMUI4WHh5WFFMK0F0L2w3OFVLVlB0TXZIMDZZTXp5?=
 =?utf-8?B?RG9pRzE4aHBQT3VkaXlTYTVwblkrT1RXYkUwUTQ4eFc0U2I5TWh6SHlSVDNC?=
 =?utf-8?B?eUtGV1c0SWw1a1FPaXhmbndON0txa2RPMkRCTTh3SW9tamNWczdHY1Y1UXk4?=
 =?utf-8?B?TDI5dTNpdFlKRFNCZTlpVmsyRDZzV2VwV1Qzc1V3dUpUVTdrM1NjdWtsVWhJ?=
 =?utf-8?B?TU9mUm5QT3pkUmFYQlFVeVJZays5L3JlWlVYYjB0MkJEclhpZGc4WWtBT2ZJ?=
 =?utf-8?B?RGR3QlhTUmJLUlRSblZxbGg0VG9QQmhhbjFYd0JMcHFzOGRCOEdlYnQrcjkw?=
 =?utf-8?B?YTRIb2tjSWhQMk94Vlh6WUQ3RWdOalVIeUpPQlNROXJ1byt0eGVJM1Y1SnhP?=
 =?utf-8?B?S0lGUHpiY2JCZXp2S2pqcU1kZkE3N0pvcTNjTFVRUzN4QXZqelpUQk5iRnRt?=
 =?utf-8?B?ck04eW1KZnNpdTNOLytFMDRQM1o5M0J3bVRrWVBzekk0RkV5WHlNWTFXK1JG?=
 =?utf-8?B?M3lwbDVWOUlFcFRkVzNXMW5rVHRuWmgvWmdjeW9GYm91Nmp3RDRDOUZBZGkx?=
 =?utf-8?B?SHBhUWVYN1BsRGVuSllud0czYnJMOGM2aE9VL1BNUFk1Ymw0YlR5eXFwaWx2?=
 =?utf-8?B?MndZcXhnd1JYd1pYN3N6am1KQ0JGbGZlTFk0RHcyVHd5ZDZoMU84LzRhMDFC?=
 =?utf-8?B?alNMVFNVellXTHRWbVlmR3ZDTTVmSkNBV21uTjZWbHNVR0tIWmpmeEZZVnlk?=
 =?utf-8?B?eEtTL0ZYemlKWXBxbEhxVmtxeDFwSEVmRHdsZlMrc1BibHMrQlFzRmlNWDhW?=
 =?utf-8?B?eTJmSXRwd0hGenpNT2FnQ1dJSmFnWWF1aUhkemxzR1BweW5tSTJ3L3FOQVI5?=
 =?utf-8?B?QWZoY2NQbFh1dHNTS3N3cC8xcXRXZElHa1lvZnYzUjRJRWF2MjZEckFiakxt?=
 =?utf-8?Q?WllMBHdNSf6OK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 20:32:44.4870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 064edbc4-2212-4ddc-a552-08dc6f9e043d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958

On 5/8/24 1:24 PM, Reinette Chatre wrote:
> Hi John,
> 
> On 5/8/2024 12:41 PM, John Hubbard wrote:
...
>> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
>> index 7946e32e85c8..5fffbc9ff6a4 100644
>> --- a/tools/testing/selftests/resctrl/mba_test.c
>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>> @@ -60,7 +60,7 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>>   	/* Memory bandwidth from 100% down to 10% */
>>   	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
>>   	     allocation++) {
>> -		unsigned long avg_bw_imc, avg_bw_resc;
>> +		long avg_bw_imc, avg_bw_resc;
>>   		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
> 
> nit: since you are touching this line, could you please move it down one line to
> establish reverse fir order?
> 
>>   		int avg_diff_per;
>>   		float avg_diff;
>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
>> index d67ffa3ec63a..a4c3ea49b0e8 100644
>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>> @@ -17,7 +17,7 @@
>>   static int
>>   show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>>   {
>> -	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
>> +	long avg_bw_imc = 0, avg_bw_resc = 0;
>>   	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
>>   	int runs, ret, avg_diff_per;
>>   	float avg_diff = 0;
> 
> Same nit here about reverse fir order.
> 
> Thank you very much for sticking with this to fix the warnings.
> With the nitpicks addressed you can add:
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 

Sure, I'll post another one with those two changes and your rb,
thanks for the review(s)!

thanks,
-- 
John Hubbard
NVIDIA


