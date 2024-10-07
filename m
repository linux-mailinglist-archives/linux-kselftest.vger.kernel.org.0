Return-Path: <linux-kselftest+bounces-19139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5B9923A9
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 06:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12371F21367
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 04:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA93178276;
	Mon,  7 Oct 2024 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S44gtY0J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2025D477;
	Mon,  7 Oct 2024 04:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728275993; cv=fail; b=oAhcLIlLZpFQrPkVRDuSEt25qhJTmzbyJTwngRaFtWqwjtP0iA39GGs8b4TQvCqm86khBo9nO43mAykl1Kli+y+u6VdFFkeBBEwy9HDRGxXK7/sfjUAWUn20hz8Upw1BsfGmqamSMHUiTg8VPS7G+S0YZABpJ4IoU+DahMUFa7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728275993; c=relaxed/simple;
	bh=mTbGHfqNi1S65n2J2lb/puk6rkBqCVcwHpHTMBUZEYA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HmTNYtkmZfraYdZzbo6afjXNjJGnJXigR3fQk0cVOwVAUVpJLnV5Y/1Y2B/W1309LRw6iC9mCu5hP64qS/8oSMIpif0kObDu2IuUdm+F2Yk8d2UPF6DRWHW9mcJ1RyXtIU+ntx2IBCQY6i6Xjxx0G16atcWI0+pVn7pLo71fLDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S44gtY0J; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZZqa88IqnUxaH0VnKHfA6IWRAl0KVJEXxxXj9q5oVqT+fGijqxJGXwWWpIezoB95I2zzkgnqszk+SrycqEgl7sUjQvk25x8Gp9h/LpqsaS0Q4Oh33m94R1ZEnwkjP8JurOCa1ZX81uCPJ630vOGrS7vjYsEI79U6P7KYNjSkCDY6TuGt68zY1OSlYXhXa5tDtoZaRnX9KvbuQ2zydKkNzkKN6tiDoQDBAsO/EG7ebjbsiwkLCrLxRWvZebFX5vN8IO0/O7/bv1ISFcciYJMB7KntiRZANhcpE97zH1dpI8P2c3/j2ZnBC0GmQmdjcz8HhIVKtZzGzSV3mN6ojx36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88vlVIRWcWcGe9tz7hl7Hmm8zlxHZ6+qiG9/D+CNPKI=;
 b=FRWZL31EnLlAphcl+WuI9HYQxHB9Zci4Y9AbcrxMzxqkpVjnu2CQGrwbmkT5hiwmjmXHxyfPLxJbi5oB+WUK0gmoaFCZEXKGGVd5OTcgl/RtsUDCaLleSEGet3MjYG+pwG28vdAv0YVCgj84n7y01mINwOGFUIyoi7VCo/84qzTu/P9QmRe9pDuIRcWEmQ/3IwW/NRzDDKb7EDD1qgCb5bzRW+JaS7XruMqpP3lhAh9HYMq3khGTxlSPh+elqBhfinA3OKQRcH6ELx0+hME2ZEQF3PLQRfCgFUrvxxrCVP7c5ueujNhk75XrJlG7am2v5t433iaBNeaX5mTKgb9Nhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88vlVIRWcWcGe9tz7hl7Hmm8zlxHZ6+qiG9/D+CNPKI=;
 b=S44gtY0JdZoygQ6vh4/BJIuOEj4M/EarNJDC7uVtyIHKXCGwnfYgkrRvaR81YS7oLbCZUN5UMxmoq7XvvWQnKPCDftZCNiS+xwt6z0mgz++GP7i3xDDT89ALxFNIbYo8o6aGynJhPf6Z/PXlEaBtbKNr5TNFxBGY7zZs1oSI5rU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.22; Mon, 7 Oct 2024 04:39:49 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 04:39:49 +0000
Message-ID: <93f35acc-1a62-4547-9891-18651ecfac4c@amd.com>
Date: Mon, 7 Oct 2024 10:09:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] x86/cpufeatures: Add CPUID feature bit for the Bus
 Lock Threshold
To: Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, babu.moger@amd.com
References: <20241004053341.5726-1-manali.shukla@amd.com>
 <20241004053341.5726-2-manali.shukla@amd.com>
 <213827CA-4A73-4E3C-A4D1-3B325E34768D@alien8.de>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <213827CA-4A73-4E3C-A4D1-3B325E34768D@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::12) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 37fc9457-1687-4f5b-ec32-08dce68a135b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjRTdG1JbGkybGQxZ3dsbzVSUDVCVWVBSW12WDNWcEpPUDJFVEF6S2tUU0xq?=
 =?utf-8?B?eFQycEs0ZUN3M2dhWGdiTEppRWxDT2taV2U0bXNUazM2NVE0MW1pUDRSNWxX?=
 =?utf-8?B?NDJXOExmblUyVlIvRG5tK1JLMEVITHA0U2JYbUNvRlFBS2Fjbzg3MWdHa0hE?=
 =?utf-8?B?ZmxYK2hYMmpSSkZjdmJnRDFsQ3dRT0F5V2d0MkZIaUlxYTMwcmxxRlN3akVr?=
 =?utf-8?B?OEdPVmdsMkY1emU5YTV1ZjlYb0JFc3FGYnNRMnI4UVFQZUxyck9tNDdoOGhU?=
 =?utf-8?B?N3VLTWFYVWExL2NQMzVoM2gzNS9ueDI4ZzZwajVKWncxTGh4U3c5T2FFTlc0?=
 =?utf-8?B?RDlBemt3Nkk2S3ExVFdYOU96R292ZU41N0xYM2N1NnU4TSt0V0d4WXJocjVR?=
 =?utf-8?B?NHdMZ3BwMnR5eW12dWdCZEZTcms3NzhsRzJreVNxL29PbWV2b0ovSXlkS0o2?=
 =?utf-8?B?UzFIWW9ZN2JwTk8wTjZCU0lKbE5HMVFvTXRNUERZUk9ZTTQ4R25NVTBvSVRN?=
 =?utf-8?B?dWxrait4YlpHZ2t6OW5kdTFjZUswem9EbmVsZDdWTFJhc1ZSSW1PTnIveFFr?=
 =?utf-8?B?NUlFMjZMUTZyY3NBMDN6cDBTYm9YeWdxMzJFK3dzKzhWOUNwRDJ6aFZndmJP?=
 =?utf-8?B?STRIREhDYTVyZHVzU1kwWTZVWTR3K1IvTXNyZnh2ZDRQblRpdlBIVGVWSGhM?=
 =?utf-8?B?OHI2NUJ2MjdMU0Z0emxrYmthd2dNR05jREpaWkJtenljZ1NBb1VaVG91VXFn?=
 =?utf-8?B?cFBiSjlNZ0pCaGtuQjFHRVJ6MWo4VXNDQ2ZMa2U2STdkSXhxK2NWNXBtbGU4?=
 =?utf-8?B?R1NlUDF6RndVd1dCMVNjSlJvQlNFWlJpdmp5YnhYdGJockhGWlE0aTVXL05E?=
 =?utf-8?B?TEtlQ0tzZW5DNjlkTENQa05xZVZ4bkRiSk5VYTBqMWpxTUsvV2RjR09teDQ2?=
 =?utf-8?B?VTNFUUxSRTVIMWRvRWphRFRYN0s1T3FxRU40a0EvbURnYTZhSjhScUdzN0FC?=
 =?utf-8?B?d2k1Y1ZqT0VHemtzZlB0amovWWZWVDJpU1hYRFFoSWVtUkNacm9nNTZrblpm?=
 =?utf-8?B?dGNqbElLL2pPL1pZM3hzNXhybEZMQ3ozb084RUUzMjdWUlhTUVZ1OXBtM29o?=
 =?utf-8?B?Y2lEaGtybFhNenF2czJYWHV2VGRzd2l0dHEraDN6K21uRHo1MjFFb1JWSm9k?=
 =?utf-8?B?MjFpdGRaU2sraXQ3Q2wzZERTdHM1Y3ovblErTFFPdk5UQWtUWXNMQlRFTEZ0?=
 =?utf-8?B?QVk5bFhOUDRVNUpXZStKb1lwUlBGNUdSV08wRFliUUo0N0Y0dFNYbzVWSXMy?=
 =?utf-8?B?aEhtTmdUREVsMC9GSDlCTTN5UUZqU0w2czhOR3N5RWVtY1JrTzhBTUxrYk5O?=
 =?utf-8?B?UmY3Q0s0OE9wODR4VldKNDFndXQweHNRWGcvdjFOQjZzRklyY2h6aWJiWHhy?=
 =?utf-8?B?UzR6MHBLQU1vakpKQ2FlZ2JtR2twMy9EYlR0OXphZ3J6cFplVFJyQ1FoNlN4?=
 =?utf-8?B?WWxVTXBPNlBqQ2Y2QWlhblNXOFdNZnduMlJkQ1QyVUdBVmtqZHk0emp4K1Jj?=
 =?utf-8?B?QzVBSTFJR2pHTmIvak8zWnRYWi9wWUlLSWFvd0MrTVVubUt4L1VOSDVubGdm?=
 =?utf-8?B?Z285UXhia2J0dVRCbG9FNzVYQmgyaGU2ODBhQUVtQWY2SUQzWkVUeHE0ZFBx?=
 =?utf-8?B?bDloQWZ0K1ZFSHF2TjNmT05UQ1dDVUJsZnFzWTQ1am05QW16T0FyZy9KQzNE?=
 =?utf-8?Q?svnP09KURYREA8HW38=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dENOSWI4UWs2MWphYzlKa0dwU3N6UUFvTlU5STNmQ1JjaWlvSU1rdjhZZUFj?=
 =?utf-8?B?ZkJqK1VJNkZ6QlJMd0YzZDhZVS82TitjYnpxZHgzK1FvaDBTbXVFYnZVUHpv?=
 =?utf-8?B?Yjl5ZSs5NEZsK2ZmRElkMHRod0hGdHlGSExFVlJ4elk1bGFPYkpJcWVvbmVR?=
 =?utf-8?B?T2dZWGxZL2piUE13cmdoRFp0bmNldGdBbzdpd1JGb2ZsakhkMVBKOSs3dGt1?=
 =?utf-8?B?ZEgzWTBWNnNYOHZaYTlQY1I0aWhzenJFa01GeG51ODNJQ2swdFlSMVdSL3pB?=
 =?utf-8?B?OUJxRE5qL3NoMzhWbUEvMXJLM0tkUmZPQXIxb09UTXk0ajB4bzRLMk01OU1l?=
 =?utf-8?B?UmRjemZUWkFEZVdoMVQ3bnAxTThiNEc0RnZTVXYyRjR1c25kZ25jajVOR3pS?=
 =?utf-8?B?djBOZXZEbk5WZHpkcDMxcVh0STJ3L3F0TXNOUGdCa1A2OVQ4YkJDRUk2OVZj?=
 =?utf-8?B?VmZ4bW1CYkd2bHprQWpiRThvdHN6RG8vaUxjZ0FPVnBGVWJ4ckhzNlV6bUJi?=
 =?utf-8?B?bkpLUWhzaDZvNGV5WmtnTjhySmVEMXRDOGc1MTBHS3pOWjBwZlA0cjVHdlBt?=
 =?utf-8?B?YjVSamJXVjF4TU5xNWw2YnU5aU8rSXBCTFdVRTc3SVlpeE9OQXdyZEZyK2g0?=
 =?utf-8?B?allCN1lZSEcrdy9hbldKRmN6QzBWc240T3BON1R2WVE1NEZmNU1aV1NiS1Fx?=
 =?utf-8?B?SlNmZjVVNEJhWXB2Z2xKVmxKRDVuc1F1RDRNYms5TzEwZm9zYUN4UzF2T1Mz?=
 =?utf-8?B?TzIyVkxDR2NMdUFBUjVmQzhabS9hMll0djF6Tkg4VzY0S0Z6cUNHREpsQVpP?=
 =?utf-8?B?T2Zrd2thMTVCQm9IYWY1bmNZUW96dW9ubzVZTGwrOGhkWFE1YitNa240cDc5?=
 =?utf-8?B?TkFkajk2Ykw4cUhHd1hrZ2QzTjNGNXM1NGtuNnBpZ2tPRmZlVnVXbWYvclFW?=
 =?utf-8?B?ZDBldlZ6RGNoeHB4NFZsWERXcE5CYW92YXU0cDBxMFM2b0NwM2g4bDJ5QVhk?=
 =?utf-8?B?Q05RbjBHOWg3V2dKalNzdk9tNE1MZDF4UzZxWStCR1ZMQXdPckxlTzd0RGFV?=
 =?utf-8?B?dkhSeGNicE1WWFVOVW5Rc2tFZFU4UGdaZ0N2S3F3TTZpTFBEZnU0MnlTbVVO?=
 =?utf-8?B?ekk0cENOck1jazA1YllOc3Y3QmM4K2NrTy9NWlBHWUtGYU1kL3VMS3NsMGtU?=
 =?utf-8?B?d2w4TCszOEc5eDMrcHZHSTJlVFJLR2tKUk9iMisxdlE5czMxSzBUZkVQb3lB?=
 =?utf-8?B?MzlkYTJEdHVzWFBJVEJWREdQaWtOVlo5aWRaSjlxdUZTbjRIM2kxWG1FV0N2?=
 =?utf-8?B?dFZGdVJ6UXgwaVZFMkMvaDlVeSsyVUlNOUtQNUdRMHJwZkh4N29sa2RUUFlW?=
 =?utf-8?B?QTNZb1ZhVXNmdjZpOXBXV0prNXVvRTR4Q3dvZjM1SmJTYS8vd3d0MjNjVGJq?=
 =?utf-8?B?L1UvWkdnUXFZV2NiRmdzM1VxY01UZ2Y2bzhvUHFpVEsyWGIrb3d5VEdKYkcv?=
 =?utf-8?B?c043OVZzZkZ3UFFabnk2N0g0RTl5RWp6M3F4YzhTbk9PVzd4U1BtL1RDMGpw?=
 =?utf-8?B?bFF1R0p4dElnK2dRRnZFM2dTK3ROekdEWHFiQmtoVDFTV1NML29NeWNheHgx?=
 =?utf-8?B?TDgyWVlQUXhJKytzS3RqZDIxZ0twem5aYjhyNm13L1NPa0cyYStoT3c4UzZI?=
 =?utf-8?B?RGZ0ZzVWNzRaWklQT2pDdWpjcTE4UGIxN3BPYzZDSjVlcXZsS3NtZDdZTWQ0?=
 =?utf-8?B?Uk9ZbHQ4eTRSWnVjTWpKaGlxRW1BRWlFMzNhWEFLb3lMOFoxMXdGWEgyQnly?=
 =?utf-8?B?SDZIaGRvRit4ZktOOCtxdEI1TlBaRVpqYXlFamNJa2xzTGczNnR2aFpHdFdp?=
 =?utf-8?B?c05WSXcrZ3hHYTFBUHgvWWZkck5BVUxpbFpUaGZhT2xCa0d6ZkxNZnFob3Nu?=
 =?utf-8?B?L3U4OWJ0MFVNQU9zMDN5bldQL3NCckRFMXdzelFoSnUvaDBSa1ZTVVBjS3Nh?=
 =?utf-8?B?T0ROVy9vWDE4TEV1eUdRa1RNeVNvVi9yWlBSYzdWODI0L1h5Z0lqOWh6d3hS?=
 =?utf-8?B?SSszVlhXYWZGWDdHNUNtclBVamJTSnZpdWJtekJiallpaGo0TkNxSlRwYmhS?=
 =?utf-8?Q?qzm6oJgj8yGY4PF+UiuiaCeW9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fc9457-1687-4f5b-ec32-08dce68a135b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:39:48.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8eqkp31q3p9rIP05kUgU1m7NNTvUebqGa31/Dalol8pvhCb1ffT+H/aEaF2ovE9CgBMQCCaRmlpYCN25beMzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021

On 10/6/2024 11:56 AM, Borislav Petkov wrote:
> On October 4, 2024 7:33:38 AM GMT+02:00, Manali Shukla <manali.shukla@amd.com> wrote:
>> Misbehaving guests can cause bus locks to degrade the performance of
>> the system. The Bus Lock Threshold feature can be used to address this
>> issue by providing capability to the hypervisor to limit guest's
>> ability to generate bus lock, thereby preventing system slowdown due
>> to performance penalities.
>>
>> When the Bus Lock Threshold feature is enabled, the processor checks
>> the bus lock threshold count before executing the buslock and decides
>> whether to trigger bus lock exit or not.
>>
>> The value of the bus lock threshold count '0' generates bus lock
>> exits, and if the value is greater than '0', the bus lock is executed
>> successfully and the bus lock threshold count is decremented.
>>
>> Presence of the Bus Lock threshold feature is indicated via CPUID
>> function 0x8000000A_EDX[29].
>>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>> arch/x86/include/asm/cpufeatures.h | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index dd4682857c12..77fa8e743ccc 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -382,6 +382,7 @@
>> #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
>> #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
>> #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
>> +#define X86_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* "buslock" Bus lock threshold */
> 
> Why does this feature flag need to be visible in /proc/cpuinfo? 
> 
> 
This was already discussed on [v1] of the same series but never concluded.
As suggested in the discussion [v1], I have added "buslock" to be enumerated
in "/proc/cpuinfo". I really don't have any strong opinions about adding or
removing it from "/proc/cpuinfo". So, I would let maintainers decide how to
go about it.

v1: https://lore.kernel.org/kvm/76355a11-a0ba-4a28-bf51-454facfd59e5@amd.com/T/#mb225b5b5fad2c070d4fadd51a076e9a05330b6a3

-Manali

