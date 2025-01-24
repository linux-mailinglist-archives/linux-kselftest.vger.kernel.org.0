Return-Path: <linux-kselftest+bounces-25125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AA5A1BB25
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 18:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DECB3A3AA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A43B15D5C5;
	Fri, 24 Jan 2025 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LyTuGpET"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A82A23B0;
	Fri, 24 Jan 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737738195; cv=fail; b=tghN6Pmb1J3WxW87aWe82SCHdouhOmZEfH2mwUU8P46km3megrTOamc89ZgNy8h6OvZv7dVvsidpOXmag6b7lc6Q57yRQ+ndijC8X1TDuwEiWvs/9qua8qlNmUcS3PqLXPK02CX5ihiqURglgKu/ijvkHKU4F66phMY7A9hvChA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737738195; c=relaxed/simple;
	bh=n+FN69cde32/9/5hYHvFo3YzYvkUcfafKCOGwrVdCik=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BHacRy5hwSc0CPIc40o9hUK4PKvVQd2ddKpR8/yn25Wj84YgKTJCg0HHzMWR1oFecD2QWBhyL9enOJ2fRaV7neP/SZXdvU1fqKdwfJL4M5fr4HKX9sottR/5KwtcWyqEk+dm9TGbzm9+oBsgOzZDGBcuApF3OXAMJNzz/0rxfhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LyTuGpET; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCtxIM1+TSu8F78M/9fvW86RkunZBOlf+Th//t3sJ8uJCMYoNgEU/VPD6CaCEwItKCaK8umZnoyzipJSOZ+KyjfkiSb6CN3AH4cZLzRMbXJYG3i5Z47Eo1zki5SLc2IunjN+y1Pn+Qsxk1JfX+2iFZp2cGsvtRA/CeDMJodsRMXSVwprMCExvOI1yetUXaA9/Y2jiD54tnCJEr4Opp9zwQoY23nHMkwDkvGYARkNa09GZQ25Du2lDhmwd4Q5uiaKxwaoylbhoB4NW9dvXx68twyjJAlkOaLq2NIoem49MAO0VWjX7j2xgIP28uxjMDLNdrZTksPPFaPB2V1p9ByVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnM0MQvC4RDe2bSl96SHJDhS9DEQ5ec/lCytADkJsZ4=;
 b=fAAGS+DaWk82emwdfI8zVxXTMKv3UVq1wXjvBleDsbIHkfAVUvCkAVF1+sdaulHnYFl3B05wlX2ydu0xln5F+E6s6mUlMpKtymptcDLvXOoiHuD4g1lM8r4y3/yx7ee+JQ+NrTlbZk+g/0w+COM9CCW97L8RAek6UO1CsWEjmlXxlKABWvih1xavtq8YKcIYHqwE1CfHbdRKHja0ExZGqNcM/8gKL+ta4vbFd932TwrLQCPWpsEpbboft18np9GVKzbIYtAelfcZCb39M9qLZJgl6TAlc/Jq7ddL83tRArmMtbA7xcY/M3x65pm70yG7TbnHbPoezG4diRNOOlEIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnM0MQvC4RDe2bSl96SHJDhS9DEQ5ec/lCytADkJsZ4=;
 b=LyTuGpETVyqsafTwrHTflUj3RO8F1KFA/vKXM90EcVxzA07uj39nI+8+Be8JWJDf3pw52/CzfJi2Jh5kAed/j6CPFppbGJtg1D2hprJcyfp1dOviDEzEF2ahSUbGD+7IWbU15OL7+3+Jg9vv1KP6n3cB1LSv11ZZFPGTYXZN9EA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 by CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Fri, 24 Jan
 2025 17:03:11 +0000
Received: from MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda]) by MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 17:03:11 +0000
Message-ID: <00a718cc-e8a6-4e68-b710-a07670f0dcab@amd.com>
Date: Fri, 24 Jan 2025 11:03:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] KVM: SEV: Disable SEV on platform init failure
To: "Nikunj A. Dadhania" <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, shuah@kernel.org, pgonda@google.com,
 ashish.kalra@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250123220100.339867-1-prsampat@amd.com>
 <20250123220100.339867-3-prsampat@amd.com>
 <6e7d7f4b-7a0c-436a-b6a2-5e364411ec87@amd.com>
Content-Language: en-US
From: Pratik Rajesh Sampat <prsampat@amd.com>
In-Reply-To: <6e7d7f4b-7a0c-436a-b6a2-5e364411ec87@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0220.namprd04.prod.outlook.com
 (2603:10b6:806:127::15) To MW6PR12MB7087.namprd12.prod.outlook.com
 (2603:10b6:303:238::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7087:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 131f2077-9e0a-44a5-30fc-08dd3c98fb6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDhNbnVYQU9jM2Z4TnNKMUpOSkQ4aytJM0ZyVU9QaC82UTVVbEJoVUxiWUZx?=
 =?utf-8?B?NTdDVnp1Q3VIcUVlRGNHWFFmVGpiOUdBS09kUU43MjNzN1d2eG0ydThSNG4v?=
 =?utf-8?B?OGRubnZJSEEvYW56UmVhK0o4OUFtQ3NWd3c3SkZUMmRnS0JvN3hqRDY3aEhP?=
 =?utf-8?B?dTllUzNoMDRYOTZKUmJmSWRYNlVWU0RPY1VmOGNDSlZQelF0YXl0TGlHSlVw?=
 =?utf-8?B?NmtDaUJxbEUralo0VGgzcHhEWGZydFBYWHBMUTI3Yk5MY21yN3V2bENPZVhB?=
 =?utf-8?B?TlE3V09vbUwxVlgrSG9LN051RzJwcUMyNU9GTXFJcHZOcHlXODhneVlUN0Q0?=
 =?utf-8?B?RkpiWXYyOS8vblc5TjF5Y1U3dURvdDN1MHFXbll0OE9vWWJFTERta1dzUVBZ?=
 =?utf-8?B?aVRPWkdFNk43QTRZQlFXUWZuS1VqL1dFd2VqNk5zaldWRUdxUGQwQjZmSGJ1?=
 =?utf-8?B?VjFoUUJHMjNxc3M3bnY5NWF2ckhTbEFLYUViclltWjZtOGlwM2pXUndySjhU?=
 =?utf-8?B?N1RBTkdUaHFyYkZ6d0VhdFlLRVAxRHRXZmxmK0RpZTdPUlpZYWpkVC92d3Mx?=
 =?utf-8?B?b1NXZkNiNHYzUitzN2NpTlpjb0RzRVBOWU1yTjdsYTUwWVBOUFlidVlSVmdm?=
 =?utf-8?B?djRRcWxKV1kwSUtFaGtHVFdXd3o1TzQrckhRbUxzZGdodDdpWmFPNHdzSDhW?=
 =?utf-8?B?WVBsOThJb0xSUjVtTkdPTkh6aVdpOVFCaklFUkNnVzlIOWJlV2VXMlRaQ01W?=
 =?utf-8?B?Q01oSi9tUnRKSHZJenk5RUwzNEdQTDVqcFByY2xhOTB0OUtyMS8yMUxTdks1?=
 =?utf-8?B?SnlaZWRQdHdkektubnU4T0lWSDlmR2cvNE1KTHYzZ1ordnpzSDBteWx2VlpI?=
 =?utf-8?B?d3VnZWl3OUlmbk1xWjVyQzZmWVVmTE5LMitMU1l0azJWK3dESXpFam1ySm5v?=
 =?utf-8?B?S2wrUHcrVmUxOWJlWEtuc3luT1poTDZ2ZGhMZ0NJMjdjS2U5N2FPbG44VlJ1?=
 =?utf-8?B?eTZ2aVVHR1pCMGd0QUNoQS9hYzNyVUtxUGtxcG1tZ2lVeGZuRXlCMkV2NnNN?=
 =?utf-8?B?NGY4ZCszbjVVSndubE1MMy9GckFhRmRWNVQ5SzJXVGdMaFFlSXRwVmF5MEhn?=
 =?utf-8?B?aFQ3V3FDNHgvL0U0SUEyZ01ldExMekdkcFd1OE1NYzNLK0lhYSs3R2Zkdm8v?=
 =?utf-8?B?UG0xcWp1M2lQOXJuVnBuNW84MndXNnNIWllBbEh1MVczZXR0dlV6S1dIdjd1?=
 =?utf-8?B?alpEV2pzc1V0VWZGN0VpcEc2QTM5VVFqOTFvUmtnNW9Bc3VkVnd5RTZGN2Qr?=
 =?utf-8?B?NldCY3FCSmt5cTZUL1Q1UDloaWJNN1AyRmJTaTAzY0NLK1VZK2cxcU1IUlkw?=
 =?utf-8?B?SmFjamp0N3o2ZmVTL2xXL2x6N3J3V0c4N1E5NHAyT0xxeUMyR3krblljcGk2?=
 =?utf-8?B?SWlYRjBDYVo4TEhvdDQxQTNnUmhVaTBPUDdYWHVtNUhiUVZHK2pqcHNKVnRp?=
 =?utf-8?B?N1QrenNqNC9QTHdCaDI3emUxNi96TVl4dGNUZG9FNHRlZVFqbEVjZXRxdDU1?=
 =?utf-8?B?T2c1TWIxdC9CVGtlRHBOZjYzZEtmcFNmaUxndDh3enpxRnJTM0NiZ2JLNy9U?=
 =?utf-8?B?ek5hTkJRNWF1U2lLQm5rcDJoaXljUmRNSlhGZnV5MEwvcVJlUWQvN1hYUm1T?=
 =?utf-8?B?ZjJsOVkycVhpV0NiZ3RNQS9GMkJOZlZlTW5Nbk5yQlJwQy8zVEp2NVROTEZ4?=
 =?utf-8?B?MEVTSzFmUFlsdDViVURxMTAyYlJad3BmN1RRUGRjQ1l6VW03SEJhN0tVZ3dv?=
 =?utf-8?B?Qk15M011ZSt3cWxyRXVsaEIwcUduS2w1MEZORnF3RWpnVWhmaUwzaGlhNjBp?=
 =?utf-8?Q?k7gY69Zzuq6/Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7087.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3VGbFpYcnNHN29ub0t2NGNvc0Y2QUROQW1JZURKdlJtWFJ6SHNIbEo5TkFL?=
 =?utf-8?B?alUyUndxeDFpUVIzd2dKTzIvRHdyMFh0N0Yra0F3UjJ6d2NuNFM1cDFVVzB0?=
 =?utf-8?B?cTBGMEMxeEwzc3RRdTBRM1g2OTJUaVRvdklZbHR0OEE2NFU5YTJhOThSWWE4?=
 =?utf-8?B?WThFSjgwT3piWmFCa3hOaHliSXpRRnhta1F2WGZ5ZFhndmNCQnJlVjIrVVc2?=
 =?utf-8?B?dTJscnJlVG8ySlEzQ0VIM3JjZVZ3bW56Ry9KVjVlak05bk1hclZJb3c5bzh0?=
 =?utf-8?B?Rm1jY3BwUmdvOXdkTDRmQ0hOblJFekM3b000WTlFbzVkZXE5ODRJNjBWdUtN?=
 =?utf-8?B?WVB3TTIyNmRQaDlOMW16M3JMSUpvSVY4SUs5L05rQkVuYzdiYW5NcU1qcS9j?=
 =?utf-8?B?SXIvRFVZNHlTMUdzTVRXUVVQdlNUNTNaQlJBSmd4c09uSVpyS3ZwTllqREpE?=
 =?utf-8?B?SC94NUo5aDg5cEpvY1JzREEwSjBzS2FoaGJIUnJJTjliT1o1b0NGYVBVSUQr?=
 =?utf-8?B?NlplTzNQcVZKd2M2MG5GUTZiR2ZsZWFRbEJ4Vk1nY1Jmb1pUTFRBUVdDY0xC?=
 =?utf-8?B?Y3RvZDhHS2dRandlUmpSanlRWFZVTkd2VTV0QmswaVRWODFLMVJpQ2FlSG83?=
 =?utf-8?B?YzBZUWFqb3lIa0F0MmFvTmFpNjZoTWZuVWU0VTVLTmxnN1RhM01OQXAzUjRD?=
 =?utf-8?B?Ry9yRlNiWmNrc1dtNEczWjYrL0ZSWFltaDQzNWl6Z0hnQWpqWHZvTkNnM041?=
 =?utf-8?B?bFNPY2d0dXYrbDUzbHorRFRRRlkvc2tOWnF3R3JVL1prV25zY1o5bXBOZUcy?=
 =?utf-8?B?cElscHhvblgvc2FYNXgwSDFCWEtpWWNRY3djNFZ5OWxhZkt4Vk5IcVFrWmRL?=
 =?utf-8?B?YXlIOHRrV3F2bzVWUjR6ZStjR1lvZHNNVWhsM2J2NGtGcU4xa3RVb1R6UGhN?=
 =?utf-8?B?WVp0NmFHUEhHb1hQcXdQWndiNTQxSGVKZEN2VllmQ0oxNzFiTnFIa1B5R1pV?=
 =?utf-8?B?RXNLZlNsL1dVVnh6aEJkOTM1bEEzQ3JIT1pRSm1ET0FUbzNFSzRwa2daalN4?=
 =?utf-8?B?ODA1M3Q0SUNzQjdOMEtKYU4yb1N0L3dHblJVL0I5SnhEdTZpaG02R3MxQzlz?=
 =?utf-8?B?REwrTEdIL0paMWV3ZS90cnFrL3UwdUtjUUszc3ZTS2RrUHp0QlJuVE5ZcEZP?=
 =?utf-8?B?RVEyM1Vodm51RTBKM2JNNVRHK2d2NjN6Wk5NbERXL3pDNEo1d1pBbHEzOThO?=
 =?utf-8?B?MzlMYXhyVHA4bmpIdElJdGVteEFaeXUxSGcybjFLcDhmSkQ0TU5iN1FCYnR4?=
 =?utf-8?B?Q05GZHNsRm52ek5CdHp4WWlOMExBSW9oMkxKRHBrZlFGaEY0bmRkKzAvK0Zk?=
 =?utf-8?B?R2cwSXgyZkE2dk5WMit0eFNnU3dkZjhqV3BXY2h6dnZzWVVDVmJSUW5mdGdF?=
 =?utf-8?B?RlFtS3V4SjVWWHB6ZWFnUUZ1Z21oTmpmZE1TcWRjVGN2ZUdTNUovMUJ1SmRx?=
 =?utf-8?B?b2hqbnhnVVlEUENxZmhkVXlhaG1sSGt1akcvWmdHSk1KVXpqM21Yb1QzdDd6?=
 =?utf-8?B?WGxEVk92aU5DMHhZOE5sd2NIdEpCYTd2VHFZSEJjYU4weG02eEF4VUYzRUEz?=
 =?utf-8?B?aU11Q3pDQmtOS3RPck5CS3JnS01iUk9abi9UY1MwbDA5dHVpTUpscStVRXk1?=
 =?utf-8?B?QXJlZjlPemcrOWZNQUd5QlRScFo4QjBXWTlTTUdiR3hlbWM4MUI3Q3Y5Tkdr?=
 =?utf-8?B?L3ZnZkVVWVorYnpFTFZtZ2ROU04ybjc2Q2s5NW1WR2U5M3didXZmU2E3WVVy?=
 =?utf-8?B?ZThBaXA3ejVGWXZWZGt6dkM0QkFMOWxqbk53ZHFoRHFKTU93cVBZR1J1S3N3?=
 =?utf-8?B?cVRJZTJ6dEFTRjdqL3NsMnJ1OG1oTEg2djhoUCtUa2dtR1RlRW1USXNPQy9O?=
 =?utf-8?B?bkZVdXZFWFd2b09Zd1lTcGxBTFN5eVJBcVF6MFpDNm9vUEhVNjA2RTBTM1l3?=
 =?utf-8?B?bGdZd200SzVKeXYrMmxFNWNYQjJNWno2VmNncU9pRE5YUmZjeDlGek8yOEVw?=
 =?utf-8?B?bVlqUzk3WUpXZ0U5SjFOYWs5UUhCcmJlRmZHRUVxQ2xaeHQwQSs0TngydEdQ?=
 =?utf-8?Q?qFJqzAgVsiW1u0vH17Oy2FaxI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131f2077-9e0a-44a5-30fc-08dd3c98fb6f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 17:03:10.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6PqpaYUHCntSkFsHhnRZc5zlwELr/bUgvh1e3/a/+67djy1b7xQd0DnPG/i6/oW19eKpPmsKmqfh8IgR2lrrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727

Hi Nikunj,

On 1/24/25 3:56 AM, Nikunj A. Dadhania wrote:
> 
> 
> On 1/24/2025 3:30 AM, Pratik R. Sampat wrote:
>> diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
>> index e841a8fbbb15..3a40b79fb37f 100644
>> --- a/include/linux/psp-sev.h
>> +++ b/include/linux/psp-sev.h
>> @@ -946,6 +946,7 @@ void *psp_copy_user_blob(u64 uaddr, u32 len);
>>  void *snp_alloc_firmware_page(gfp_t mask);
>>  void snp_free_firmware_page(void *addr);
>>  bool snp_fw_valid(void);
>> +bool is_sev_platform_init(void);
>>  
>>  #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
>>  
>> @@ -982,6 +983,8 @@ static inline void snp_free_firmware_page(void *addr) { }
>>  
>>  static inline bool snp_fw_valid(void) { return false; }
>>  
>> +static inline bool is_sev_platform_init(void) { return false; }
>> +
> 
> The naming does not sound right, sev_platform_init() does the SEV firmware platform
> INIT, so how about calling it sev_fw_initialized()?
> 

Sure, this name sounds much better. I can have it renamed.

Best,
Pratik

