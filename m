Return-Path: <linux-kselftest+bounces-24952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF1A19820
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F586188707F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 17:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50731215079;
	Wed, 22 Jan 2025 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZkJRUCqP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020119.outbound.protection.outlook.com [52.101.56.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673362147F0;
	Wed, 22 Jan 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737568700; cv=fail; b=XanUCufKqHSJ4RmDI7os3V0G11TCEkZYt1RRBdJaJL/kWwNNOPVtHcgOEV0z9jEfR187pKbphMQyqq73N7NJfP1EkzliOCYUVZQWyDXuv04w3HyM9NYeuIpfSmZqVhDjeTkn/BTbAIsAHgQgDs8Fg+XDhUbtf0JkRAdTZ78ZLJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737568700; c=relaxed/simple;
	bh=zsR73FZ76exiYODGxmHcsG7dVgG8SbMaZxMPtSwdXJk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qzSfjmQyDLkRm4ysIgkX8xj5wAx8fCT+XlbEyiTRhjJxjUsKBm4FEi/3xZwCvmpHIw08LUw85rJqXronA/c0JUwI1JIxRw3SrWEff4G1sMdM8XV+ZOd/t/3xiEEWIag3cmBm2AzUS5CJiHggEZyR9ILGrZeAmbRe0haz940n1Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZkJRUCqP; arc=fail smtp.client-ip=52.101.56.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5otZzivyIWA6x1u6RDPMC6w0gUZh+PrrjD3ysVGlzH92XFg0YG+0/4C+mb53Y919eCZdNoq+nDUJhtqqeAhXogG3anm+g3lkUumAyL+Idel9G7v5zkTnvI45DqJpnBADhm5zoladFKddUFzKw4kyEyewmwJwnvKo/Sc3OBPC3F3BAXoUD671jpaf4+0aZBksmTTeOOWVNHojIH0XddSueR8kNiZllCnI3CTDF1TWRoohrVMW1CM89Ezaj+LBIwSws9Ic2GWyA/X6hF71J9kFP4pRiZa4cCLDwKobRQ9/a+Yu9ZtMpRsL2PUhCBpm9xXS6/bQD00fkg7rdGssSj/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERc8e2kDqpg9dEbZjNbC8rl7+o2xbbxgUi+2wIuE7Ys=;
 b=H3aIQSFKxIt/E5J5XVzznEwThxbFXLAVa86PbTvm7+FNVx9b5Wo62L+dVRjXgvo7fEk8SBTajfTgPof7ibirgXIKIyYD2nyryGf4ysGRT7ylEdNe2AcSI0SsRqaaskpYB7ylaL+QUoChqAKqGbVZJ2o5THLWQZ27TFBnRvRUY5dgRYieLoGt1DkhRaXDIeFg6Q/YVar4X8mLapFrek8QuC7djGuIV3LLnNQY5o4lTjbi8eW2UhzEAG5ODOsGgnTs/S5kn2TI2shGtv01niapKFnkqp1aF1539PJ0yvK1VOIiikrwj67bCjSrrKf81uU3UM6SkXlEEtlwVb9bFUfH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERc8e2kDqpg9dEbZjNbC8rl7+o2xbbxgUi+2wIuE7Ys=;
 b=ZkJRUCqP/E+NUqJ9qBU+NbIHZbgdiFGFI6yFEaRge5oX60qNIatn1HvqDragxMhSKYZZEHPj4dObxxzdvjDIlAZYFq4hCsDo/0XNLm7Q4LJCyGPUlURw24iYJMOnz4zZ/krz5acFmB47di0WDESPQ7Gqo6JXUWbRgffUs6rnJA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DS1PR01MB8918.prod.exchangelabs.com (2603:10b6:8:222::13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.13; Wed, 22 Jan 2025 17:58:15 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 17:58:14 +0000
Message-ID: <c50051c1-76c4-4db4-bfee-c0e52389a824@os.amperecomputing.com>
Date: Wed, 22 Jan 2025 09:58:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm/huge_memory: allow split shmem large folio to
 any lower order
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250122161928.1240637-1-ziy@nvidia.com>
 <20250122161928.1240637-2-ziy@nvidia.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250122161928.1240637-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::20) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DS1PR01MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e330dd-7c52-4736-b0f8-08dd3b0e57d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG4yRTAzVjVmSzdDclN5L3lFWjhMaERTK1Fvb1RZOGh2M2czOGY3QnFQS01w?=
 =?utf-8?B?dnFkL3ZyTi83cXFtWVBxMGRWbmVsRnNzSDBSR0QyZFhUQlBZSHhhalNNQjNm?=
 =?utf-8?B?RkZuWnFkQ3NEdHc2NWU1T1VDMUVJNUwyNjlYZ2FVTTFjTWNoWjBpM0l3c3NH?=
 =?utf-8?B?RHRPTGtTcnU2YnBmbVJ6N3BZcHN1cHNKVHF3SElvWGtTSXFSY25oWjB4VHFu?=
 =?utf-8?B?eUM4MGgvMFdpcFI1b2J4dEtjbzcrNWlXaDRlNnlJMnJYWTRldTgrSWVQZFdL?=
 =?utf-8?B?WXYrM1ZLNnpVeWhnMmVIMjZCTmx4bjhZbXdSOUxRbmJvRm5hMng1Q25iNHk0?=
 =?utf-8?B?T0U2T2Erd1g2UFN3eHozUCt2OVplWE1vVzJyTHh2WjBaZEtvZkxabFBVazZR?=
 =?utf-8?B?MHRWNm45QW1rQlBhdUM2dS9uQVpxSnRKVUVnRXJsR2FnOEZacno4OXdiM28r?=
 =?utf-8?B?WXNiNmZna3o2MlJnRlRKaTYxTGdvVkxTMDBmOVFXTFUrVTFQYVRZaFRUdmZq?=
 =?utf-8?B?c0YySkdTaWlCbHFycGpwYnNRNmg5cFlCcThBN0h4Y3NUU3ZjR2JXcEZINXhG?=
 =?utf-8?B?VTV5WmlodjcwLzVkelBEc0lyNHZybVdqempWUFM5ZGdUdksrUkw4Nlp3ckJ4?=
 =?utf-8?B?Um95bmFzUXJBM0RzMnh4ZE53KzAzRmpqNnJTZE1iYWt6aGI4M2xNOTZpL25p?=
 =?utf-8?B?SE1LeVN0cGNXdFN2TEdLaEttK2plekRaSjRLTGpIaW5aeStWbjZ2U3NXdk12?=
 =?utf-8?B?eXo5dk9ZWmlJTHQxeWM1ZnRRMTJadXNhTEhxZklrTmdEY1NsbUl4ZHlqc0Zz?=
 =?utf-8?B?cDFWeGE0TjBnRFAyWHhudFE1WEFXZFJDTnpFeUhPWHRZcVpsVHhvNDU1Tk1X?=
 =?utf-8?B?MTA4YnB3cVpRU0pqc2lQWGtIditsWlZaU0c2ZzNDc1lCSlJDdks2VlovSjVH?=
 =?utf-8?B?N3N4RFBGRXVVaFJjODk4YzU0L1hncE4vVzRaeWFzWjM1MEI5b3JiN3BJQ0N2?=
 =?utf-8?B?ckZGU2ZEME0rbUFvL3BKdEtrSE04NTdtRnAyODdRMlNYejNNbndFL1BQdDdi?=
 =?utf-8?B?MTVEZzZEL3FJRlBTM1owaktJVW11R1RaaCt4SW9FWHRtMHJObjU2TTdBRDFH?=
 =?utf-8?B?UzlzckdYVDJIWmxya0l0UXNxT3o1d1BHc0JhQmtwNFphSnFWYjNMVHJTNnJB?=
 =?utf-8?B?QXRHQkNLL3p3UGc4WGxLNHo3SjAxTm5mNG1UMHBSWkltcU03aUc3UlZ3Z1U5?=
 =?utf-8?B?ZFBWekdkRWVXWTZsRnZlNXNFTVRQOFR2RzJlcldlU0Q2d1JHc21OR1FGOVR1?=
 =?utf-8?B?YU9yNjcrVm02R1F3b3hqcnVBM1RLckZFME5WdzJieDJ4Sk5vSFVzRUJyaEty?=
 =?utf-8?B?dXpsZ1FUbW5vdjFEVHVZZDZGbmFTMDI2RVoyNTJDS1l0cnMzSi83SEJlVXYz?=
 =?utf-8?B?bHAxS0VWYkI1MzhTKyt0NDQrMzBqbXBwS0hhekNKRmJLUlplbmtwdzlCa3dT?=
 =?utf-8?B?UkJxanZIQTVPcmpHWXVOc1VWRzNoM3g4a08xS3FNcm1OcmtNTStUdUpURHBW?=
 =?utf-8?B?aVc0U3pHMmk1ekIzaGVxa0ZwSmZaZEpwemloa3F5WFVUVHJiaitnQlRpYWMv?=
 =?utf-8?B?Ynl4SWcxK0ZnazNVbFNETUp5V2MyRkplK2tOQkdDd0JXbGNnZHFzS0xnZTVh?=
 =?utf-8?B?cDRDQmdQekJwOTVzQzRrSExMVENBaTNNL1gweXJ2eVdBRWMxYzFEaC8zZ1Jz?=
 =?utf-8?B?QmxLQXY2VmxDK1drb3JYREpWVFl2R0RyQjNLOGdUT1h2RkxkclJJT3l6TURh?=
 =?utf-8?B?cmlFcE8zNUxPM0xkY3NyN2V1TG9oVGsxK2xRWVU1YzJTY2RTY2ZtUlIwbDVq?=
 =?utf-8?Q?65x6bNGKjz7V2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1d0S3VlWUVLNHZmSDdybDNZaDlEazdTN2JwZkEzNm1vdDc2VCtCWmg3dW9w?=
 =?utf-8?B?eVdvdStOV1doSXppcHFzYTNWd2ovUGE3b0RWYUMvSDI2WG5XQkYvR2oydFgx?=
 =?utf-8?B?OGJrRUhHcm5MT2Y4SVpuR1dnRjUxcFBTR3NxOWpNbmxNazN6UFdTdm9sM0xG?=
 =?utf-8?B?eEovdlpTQy9CTXd3N1J0RGhoOGJRSUhFU2VnTHRJRUY0SlZOTjVSbTZhVFZB?=
 =?utf-8?B?WlJKT0lvSEYwTFNwQ3dqNzFGQXNLUlNPZmg5Zk1zZ0JubUUwWkw4eGtMV1VV?=
 =?utf-8?B?YXhFSWFMRlJWSUh5a0NMeXVDcTZlRUxSK1ZDdWlYWDJCMzRLK2xoOGpRaGIr?=
 =?utf-8?B?N3p1c1hPVDViRm1WN2lpRzVXZ3FqVUdKdlhkVDdzSTdXMXJDN1M0M3VsZzZr?=
 =?utf-8?B?MmhKUjFXc0lkQW1TRUZYbzRJZndieUJONE9NeEh0N29vK1pzY3VCTjZDTnlX?=
 =?utf-8?B?aGdXdFh0Y1hjZHlUbjlaOVpkK2J4cXZJNWk1S0YrMHcycXhkUTVyQjAyMWJ0?=
 =?utf-8?B?ZkkyaThUWW9wUm43WnJxR2phVEsxNC9oVWdic0o2T013TXZUK1lmWFgyUmN1?=
 =?utf-8?B?UTU4Y1dZbEE5VTdWVUZOMzExTGpuVmFzbUNDY0ZybWx2WlhOQWZ6NksrcjJ6?=
 =?utf-8?B?Vlg4Y0FReU95dVgyRWFaY3NwODhzYndsNDNMUmJDajNmQWVqbUNTR3EvZE96?=
 =?utf-8?B?bWdWS29kSmRzaGxKNkhxZFNmRHk4RU1XaUNwM3UwYjA5QUUxdE9oN2Nhblla?=
 =?utf-8?B?WDlXQ3hYd1B6Ujg4QVpMTmd6Mzk3eXd0YVd5RGdicFRpckdvKzVHa1RkWVpU?=
 =?utf-8?B?MXhqVUZvNFZFaEVWRjB5UVFWdi9uRGJPNmgwa3ZleE1JQzRvUnR6YkdPUUNU?=
 =?utf-8?B?MUdPVjhHektKQmJoWmdPaWRCdDgvbDExZkdIMmZSRGhpQllxdjZYSHEzVVZv?=
 =?utf-8?B?U2JldkhvZENpL1RHYlV1M3FzTElxWHFDbllpeHNneThFSHIwSXJKVEs4VlVP?=
 =?utf-8?B?VkZoN1Y2ckRySWR2eVRaOFl1TGM2cXNraGNIcDdET2NMOGhqTjF0ZHk0NVd3?=
 =?utf-8?B?TUduanVEeXdBaWdld2J1UXJTMzRPU0NyRTI2YkdKcXhCRTJrQ3VhMUtzWGhP?=
 =?utf-8?B?OExuY2VmVDdPd3dwSmEwbmFOaTY1Z0FHOXI0K0xTVkRxSXpUUis2VTUreDdm?=
 =?utf-8?B?RjR5WXc5MHBrdnNycEo4NE9RL25xU3NBYVlnZGkvNjdHcmcrY2VQNGRHaldR?=
 =?utf-8?B?WG1Calh5NXVlSk5MdnBGU2N6eCtNWXIzaFRNWFZacWMvMFFBMGVPYUFPOUc3?=
 =?utf-8?B?SVk1RGN1Y2E5R245ZnJkU0RUUExLSXpKV0ZaMXVOeExQeHArY1FoZUE0TFU2?=
 =?utf-8?B?WkdWVHhkaHR5Y2pRQURGKzVzcFRxZ2gxNFpwTVBTR0poWXFCSGY3RVIrc0d2?=
 =?utf-8?B?L2NORndaVUJqdlJ2eWJ1UU5FbGs3RnFxMWU4ei9GVjJJREd2OG5LcnRjVmt0?=
 =?utf-8?B?TTUwRUpOVGVjcHNzSzFYYzZ1VmkyN3pLUnpkanowQTJRVXFkNHRIRGdNTWRE?=
 =?utf-8?B?N0hWcUdIZTlFbUdUOCtURmRKSHdhQzVacVFrbGhPWnFDclhrNkRtUU1kcDFl?=
 =?utf-8?B?Q1llZE9pNk1Ea0Z4ei9mM0ROK0FLaEZraDhpWXVlR1pKbkZ4cXN6eGMrWmRL?=
 =?utf-8?B?SzFwYXJGblNaQjl0d2VTbUYrVEJheC8xKy9sc2FobmlTN3BVdUN2eTNkMEhC?=
 =?utf-8?B?Mk9HTTAwRWtnTWR6THpOd2toOCtBTldYVk9JNWdrYVFNcGZleldGSzkzeUNk?=
 =?utf-8?B?VnlYa09jbnIvSXhxWlhCUGZqM29GY2EyMXczbTgzSTRIdnRJZnhPWlNYanhj?=
 =?utf-8?B?VzZnTncrV0pEb1FoSXQ3R0Y3SG9XZ3pyaGRXNmhkZWloNnRZSFZjekhTSkwr?=
 =?utf-8?B?aUEraExKRlA0ZnFXRjQ4cmkzNnpnZWpnVkcrMzdwL2psK1dzVmV1QXJQSkRX?=
 =?utf-8?B?K0NVRkpwZHZMSno4RjFvamlqWUFhMkhUYzlwOXpxNCt5UGE3Z3lXWjY4ZDRG?=
 =?utf-8?B?eWNQNDRoTzJoN0JzZjBsYU1VVk4wOGV5ZUJHM1gyYXhqWDF3VFRFSCs2RS9W?=
 =?utf-8?B?MU9pSnViZ2VKZDQyLzVScFN4SjEwR0E4aStIWE1wOEFIWmtjZmhrWEcwVE1Z?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e330dd-7c52-4736-b0f8-08dd3b0e57d2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 17:58:14.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F35v+E8xayWbkO8o1h94ihVZojQnXhdCkHCocYKDegDTdC2tSpa7bRfY2gbE2os//TPsO4V6uP2UxQX7yMPzW28pI7m/a9O9ekbwdkPo8jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8918




On 1/22/25 8:19 AM, Zi Yan wrote:
> Commit 4d684b5f92ba ("mm: shmem: add large folio support for tmpfs") has
> added large folio support to shmem. Remove the restriction in
> split_huge_page*().

Reviewed-by: Yang Shi <yang@os.amperecomputing.com>

>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/huge_memory.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3d3ebdc002d5..deb4e72daeb9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3299,7 +3299,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   		/* Some pages can be beyond EOF: drop them from page cache */
>   		if (tail->index >= end) {
>   			if (shmem_mapping(folio->mapping))
> -				nr_dropped++;
> +				nr_dropped += new_nr;
>   			else if (folio_test_clear_dirty(tail))
>   				folio_account_cleaned(tail,
>   					inode_to_wb(folio->mapping->host));
> @@ -3465,12 +3465,6 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   			return -EINVAL;
>   		}
>   	} else if (new_order) {
> -		/* Split shmem folio to non-zero order not supported */
> -		if (shmem_mapping(folio->mapping)) {
> -			VM_WARN_ONCE(1,
> -				"Cannot split shmem folio to non-0 order");
> -			return -EINVAL;
> -		}
>   		/*
>   		 * No split if the file system does not support large folio.
>   		 * Note that we might still have THPs in such mappings due to


