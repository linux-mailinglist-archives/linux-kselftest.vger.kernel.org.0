Return-Path: <linux-kselftest+bounces-9368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C258BAB82
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 13:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4A51F227DD
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 11:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD009152193;
	Fri,  3 May 2024 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jHk+/Bbg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD86139587;
	Fri,  3 May 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714735330; cv=fail; b=FWkzKZqiezLzg9ck6+TUKhHWdTcVaIwDVXX36bt47t7RitYJZF2NNHWLhQ0H/O045v+I/q13o8wJRwe+sNuN9IHpk3uQYroQJhgw/TfmtRm6Ng0ZxnO45B47ULyGGTmQQbXm1boaUnvJcDRXd9PwLSZOEYz99+QbqIuskFTntHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714735330; c=relaxed/simple;
	bh=fW9iny2zAZuIfmt8PXOvE4nNb37wdQv5V4MZNPExokI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pdCrxjOQw2/VqawYBwjL9PMj5cPC8kWpQmJ3nVVFSWk6+fBB3rzrfyDOHDMbSh+KratXSQHohBuKh8h0XO/okd2obW2L6vES+wsc2esmhudnEzexTTd0TvNNuguzK5jJ/2J/FcRyFzQK1AOBkgOy+5jHgBLqGsr3Uj+4P2pr/+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jHk+/Bbg; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHE80wvsP7cCjxIfkUxg/ZMEurgkdg4vvQ7hV+tvF9/5OK7HYQANPoWXUzBb8x9fpDcru9xMpr7Q8W/JYyWSTdGJeFQx7pNe1UUydEFDuDY27kEjvSLasec820wbukJlUn+ictna5AtnSe9qnkt/oKaOk28R+Q83zY8pANsHtvdp+6jcAlsZo6Jan/uvEWggCzH6WBvJ3wmmZa9eZbIJzdkDPX3LUEnlmeVVVomobOLw2d1U2E6QeotYd1YAKGPz15UPpS00nz9TP3LO44ZM0swqkwYMWIYb7fJQlMx+Q0el8pCvaONYZNlfnMTlROzGYnjqR2Y2o7K6mJIYB7XBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPrYvl/MiNRc2zDLlOxwfOni+KleHEb/Q2o1QgOfdQM=;
 b=WA0PHbrbN20SMMZUEqTcy3dD2eI6ODnzhzzY5jFAgT2S+118rc5qJaLrDPyBphT+/7AmzLkPVI2gGdX4g0lQSXKBQi40g1aaqsP1tEUBnwNDvcKwCz92GfS1YSSvJImIQvqPMP7Z+EGTQqBzTv8NAyq/gmogdCoNbGTdQ81TJFdXcXknx7M69Yi4jxo3DBKws3U4dnAdm0cfQFZ4UiXPrhfQp7v4a0bQFaE4wn3vBYPqlJcS/DHnSG3Lq65DumWXpRSDhYfc5FuIgcBghA/nTw7yhNf6gROHpoPWvCfjrbu0lMsfKT7DCPjTF/nuMqwZ3wA8D/hSRIeoCS9U6hqu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPrYvl/MiNRc2zDLlOxwfOni+KleHEb/Q2o1QgOfdQM=;
 b=jHk+/Bbg3RHblUop7MuxNVRjEwUmaEB3nSW/rC6WGPcjq5p8+ZuwF/N78eqI55g/JxM6EwKL2zi+zNCSKl1MkHPksAMTC9cDNZUrTA35bFB9M9zUVuFzhehectEMxUthQV6+wcQ+RP0V9Kvs6hoanaTk19i0uIvk0UFJdseouQvsdb702ujQjyXAd6XWgrnJH3kxGlFKq3quD4/q2WDotKgFMHHXypOhRVuJMOr5PsVdsKt4Lt0iqi+2cSEjWNTbCVOs98+5HiFdCeUG1Pt6fn4eLCcco2SpHomMcWWWONHNQ4h31aIHALbNO5KfmfFJJHwHREJeiewzJLhEVKnQUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 11:22:05 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::bbac:e733:5c7e:19c6]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::bbac:e733:5c7e:19c6%5]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 11:22:05 +0000
Message-ID: <a8f36d5a-a109-4683-abf1-47f8e7f8a7f0@nvidia.com>
Date: Fri, 3 May 2024 19:21:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] selftest: rtc: Add support rtc alarm content check
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: shuah@kernel.org, avagin@google.com, amir73il@gmail.com,
 brauner@kernel.org, mochs@nvidia.com, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 sdonthineni@nvidia.com, treding@nvidia.com, linux-tegra@vger.kernel.org
References: <20240503014102.3568130-1-jjang@nvidia.com>
 <20240503014102.3568130-2-jjang@nvidia.com>
 <202405030649157e9de2ac@mail.local>
Content-Language: en-US
From: Joseph Jang <jjang@nvidia.com>
In-Reply-To: <202405030649157e9de2ac@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:404:28::25) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f132c0-4a42-4e8a-14da-08dc6b634355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0Z2bFBDNm5naEFhNVNKVHZBbC9GUEtQVFhSWDJtSGMxY202QWVUWXRDc3lT?=
 =?utf-8?B?Qk44ZGlBQ1B0QTF3K1RHZVBDTXBibHRtSFlXKzVYYWpNRFB4WXhadG5uK2hO?=
 =?utf-8?B?WktaTHN5VHJ4WGxFKzRJenZXMStab29WRFRiOEdQU3JlbmdoTG45R3lWMDNZ?=
 =?utf-8?B?ZmhtSURzam5kN002aU00M2RjVVRSYWRlZlBqTzZCNGx2dFFUckVOQmpDN2sx?=
 =?utf-8?B?aFVRNmNDTzdXU1l0cDJMT2ZzKzhNWWwyTndrM2dMUFZhaGtHN2lWSG0xZlJC?=
 =?utf-8?B?S2xsVDQrZXBITWhSZDRXTVo4US9PN0ZVUWJtTHJtQ0hnbng4NmdrNzFaL3o1?=
 =?utf-8?B?bzNFVjdSZGcyS1Z4OVhXNWhSQTNMeDFmVGZ0dlpKVy9wU2Q2YXVjNUdqWFhp?=
 =?utf-8?B?K0gxcFVkbmw1a2RkdGxndXc2Ujk1N1dDZFR3Sm9KQm9XZE9pYVFwNHQ0MVBq?=
 =?utf-8?B?aTZlTUtvaHZSM1dXQjFSbTFzNy9pcFlZcXY3TnMxZExZdWZQVzZjUStZcFR0?=
 =?utf-8?B?TW5rdktORTJvNHFwMVNBMWhDQTN1YVBHZVJ6bUVZRjgzS2FyUXVyVWo0NEFo?=
 =?utf-8?B?eXhJdUVSTFdqK2diQ0VRS1hnS2dkS0dDeENybjRkYkVGQThhM0pBTDZCWWtp?=
 =?utf-8?B?NmNZN0c0Z2lkRVJKb0tTUGdoeHROaGY4TWthSHlFZ1dWQWxQMGlRS25sVmJT?=
 =?utf-8?B?SlpmTFVrdTcwbW5iY1luZ216U1VaMVYzS3ByRnhqaUNZd3V0WHJDMU1pSkxs?=
 =?utf-8?B?SzM5Y1RraFc4TjQ1WjVrVUV6K3NpbTZScUprbkxEQ21BTVRDSHFkZWR4UGZZ?=
 =?utf-8?B?Ri8wUTZXZjg1VXZqOHZYNE1lR0RXZm5hZmhBaGZHRVIreEZ0Z05XLzMyelRV?=
 =?utf-8?B?OC9XQ1J3VTFocXgvbEtvSzI5N0pqaE15T08zWWlVcndYNWcvT0JOWW85ejFR?=
 =?utf-8?B?aENNS0ozTnAwdW0yMnBna09QYkY0WHFCcVZIcXI4TkhTS2o1UzhRU1lrWEN2?=
 =?utf-8?B?d2w5U3lFdndGWjkrbWdHcEVhc2lrRThDallVQnNaTTVNeWNOb0pncWVSUHhx?=
 =?utf-8?B?RUNERytZcnEwNDBoOThiS1FLOEYrbVRzNVhNdkliUEF2WVFjdjVQOUQvVENj?=
 =?utf-8?B?d01zakZ3R2NrcjV6TTNCMjlVckE5R3BvYlVkYjRRYXg0RUtaelNMK2hXUUNP?=
 =?utf-8?B?SjJheWtrdW40eEM0dzQxd1A0Y3BrSnpUZ2JIUVBBQjVUdWNrK2R6VW5BazhD?=
 =?utf-8?B?SHJsaU1JV3Z0bUFIL29TZ1d1aUZiVDQzdTI0MWxFQ3l1MU5LTkNhbEhzRTNM?=
 =?utf-8?B?dHFVREpIZS9NQTJvODNzSWtOeHh0Q1B2T3FXcGRWS2FObDJTM0cwd0dkVjE2?=
 =?utf-8?B?dUN2UkNGbTBobVVqT1hNdmVjaHJBOWQ3TG9kR1pBc1FNcW1ESGR1MVhXUm5x?=
 =?utf-8?B?ZFliN1dlUnczblNJRS9kWnZiWlRGVHhmVzhtcit5eHdxYmdXOUIyWEE5ZUNQ?=
 =?utf-8?B?dlExOWlKakNHN3NxOGZUdEM1Z3FYRUxGVHhaWi9haFViQWViZStIcG5SUmZJ?=
 =?utf-8?B?dWhWNlVXZlJIMW9Bd0dRb2s2OWYwMHZ1Y2kzemV3aCttZ2dLWWNuV05RVzZH?=
 =?utf-8?B?Z3dmMWRwdFZsMmR1THVOVVgzd2Q3SWE3OHF1Q0l4ZWJWUG5MRlU1ZHJxb3lt?=
 =?utf-8?B?eGI0ZkJuZXJSV2JtRlR4QmlNaWh6Q2p0RitpOW4zS2hhbURqSG5ud2ZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUhUVlJhQ253cUU4eTFYZ3pEY1o0eWVDY3BYZC9jMm1OVWJZYW14V0t2alBV?=
 =?utf-8?B?dFBwenpXVnpoS0kvMjIxVDhyVTh5a00vbzB3TVdTK3hjTG54bEpnTEpZLzJa?=
 =?utf-8?B?OFg2R1BVelU1cXFvbittNFdKWC9uSFJsL2hTSWUzalE3UEJ2MVFjcFR1TjRB?=
 =?utf-8?B?Y0ZWSVpETFBPTXlleVJsUVpMSzBNK1kvYmZXMXcwSFF4Q0JWYVhmUXBzbUd0?=
 =?utf-8?B?LysxK0gwN0orRW5pNjBKQ0I5Sm9XTnpaaml0WU5pR09EeGQ4dWFvV3lXNi8y?=
 =?utf-8?B?NE1nSWlDMkxLK21aYTdhMjJCOS9XalRqTWZvTFpUQkd4RkNQNnFiaC9FUTJW?=
 =?utf-8?B?ZzJreVNSc1RnTDRiYzhaRWVWdlVhVVFHNmFqanVxdmIzVDQrelNOTkhFY1FJ?=
 =?utf-8?B?bUVkZE93SmpGT2VlY2pOamp1UFhoNGxkSE1udEVLK3l3Y1dxNDhleUZod1ho?=
 =?utf-8?B?L2cvdno3S0pjOTFCTktITnpZRTJ1RENHVUhpWUVvaEgwcGs4bGxCNVY5Z0hl?=
 =?utf-8?B?SU5rR1BwODJoc1dFQ1lZY2hjbEtWeGF4bVpkTFFxajhtVmY4ZU52ai9zZ2xV?=
 =?utf-8?B?RmRsckJUOFlpSDA2MGlDMlk2Q3EvM1djZWY5ZGRmR0xncGdkdWhBek5EOEs5?=
 =?utf-8?B?cUlua1FlSDl5SzQxaytKc0hZRjQ2ZWF4ekorSFZXdnFBN3pOU1BFaE1rRWhM?=
 =?utf-8?B?SDU2aUVOOURsRVl6R1c3R21YTEMzT3RMTVcwdUhxZmpLK0hlRGJJNG1LYWdS?=
 =?utf-8?B?TUpuM1NuRXZpR25DUlhYczVZUldxVHpBTkRxbmlRYkRjRHdIb0ExLzNLN0hR?=
 =?utf-8?B?QnFWb0tmMWliaE1vYXpVdVg3SjFuTklMZ1NPbUQwOXVzSExwdEdzYzROUHdj?=
 =?utf-8?B?UnV5UFJxeGRZNFZQZ0tLNlQwQzVFQ0QybU9BK0FiM0pFUzRJcENOcnZITXAy?=
 =?utf-8?B?OHMxUWpwZUFYS2FSMkxFSWtMS2ZDbDJ6YUxuWi9DdWZNcG1hUEJ5ZWp5M0RX?=
 =?utf-8?B?V0tMZ1BHdURxcm1rb1o5N3lHcTZGdzlTWENCOEYxQlhQZmVBbTg0U0szRmJZ?=
 =?utf-8?B?UExnUzRwWXl5L1U3TWtKcjJYcEgwdStKN1NEZVRkRStEcHYwSi9CT1kreVZm?=
 =?utf-8?B?SmN4TnkzbUNPckFtSHZuNU9keVBtcjhoeHRtS2ovTmkvQXZoaTZZbkNnMG9Y?=
 =?utf-8?B?ZUlUbHl6MUNGeTg2c2JOV09jQVdiOVdhVEpaM2VpN084OGQwRDN1aTV0Y0Rp?=
 =?utf-8?B?VUwrblNkRE5td1prVkd3Z0l0UnltM1R4bmN1eFkvTXZ1U2ZjQS9MMGJIMFBV?=
 =?utf-8?B?Nk40Q3lRSlVId2liejhEK1doY0hTMk1rSk5iOXJ1TDVwVkNRTmtNMjlIbmJY?=
 =?utf-8?B?R3I0N3psMzE0OW1PRVhlL2ZWdUp4UXgvdC9jMUJIb1N0MGM0S3R4Vlhabm9M?=
 =?utf-8?B?UWRQU2ZyblJUTCswUE1ja1JTbTZ2Wnl6dDRDZ1dnaHFQWFlIU2NLUUhxOU9l?=
 =?utf-8?B?bC9mQUFCbGhsWFBCYWVnTkFPSWJmbnZiL1UvZk1IN2ZQM0FvUFpVdld5NXZK?=
 =?utf-8?B?cEFpQS8yc2t5empibVNQZWpoemgyZE9aaVlDUm80OWEzS3BDK1pNclEvRDA0?=
 =?utf-8?B?SmM1K25wY21ucm0yeGMwSXN1eUJ6cFl2WDZGekQ0SlZ0dU4zR05ZaVZNZ3Bq?=
 =?utf-8?B?U0tIT2ltQUkxQ3FTVnh5dWxDSEYreWJ5d2E0V2dNc2pxT21IMU44U0txVE9a?=
 =?utf-8?B?SGFHTkc1d1orMFdsZGs0UWl1Q0Q2VXRmK0xFS09sV0VTcmhSSkpzYWtsRjNw?=
 =?utf-8?B?Sy93eVhKeEFkeHlPS1Q4RUswQmpKRFQ2Q2dTU2ZxeHk3MDlpb1c0SWhweVEx?=
 =?utf-8?B?U3I5UHpQRkdSVUpSTWNaZzlBWFhhRHhXRmlaLzBiTWpUUDhxVXNPeFlZd2xn?=
 =?utf-8?B?MG9DekdPbGRmY3BNZWppaXA1TjlhU0JnaUdqM3BPTkNuODFFNytPZVAxaDVr?=
 =?utf-8?B?U0ZvYWhwVmNnRURETjBSNHY1ZlppVEV1djJiWFQ2aHNQK0lwRlV0ZXlBcTZr?=
 =?utf-8?B?NTZDWi9nMFlpOXhJaGgxV01jckc0aEdzb04zYzhGaUkzRTlpOVI3V2ZESFFm?=
 =?utf-8?Q?bxlYCIK51pQ3nbcoRGSiD79Wu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f132c0-4a42-4e8a-14da-08dc6b634355
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 11:22:05.6137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbbXcWjmnsooduCLFxKIImQ12a/VUhy4rWB9U1YwI5JEtqSrBq9+DLnntwdy+mWWwgn6m5vLDNqI/vxyRyL/bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405

Hi Alexandre,

Thanks for your promptly response, I try to re-send the email again and 
avoid the security scanner to disrupt the external link.


 > procfs for the RTC has been deprecated for a while, don't use it.
 >
 > Instead, you can use the RTC_PARAM_GET ioctl to get RTC_PARAM_FEATURES
 > and then look at RTC_FEATURE_ALARM.

I found old version kernel doesn't support RTC_PARAM_GET ioctl. In order
support old version kernel testing, is it possible to use rtc procfs to
validate wakealarm function for old version kernel ?

Can I move this rtc alarm validation to
<linux_root>/tools/testing/selftests/rtc/rtctest.c ? So we could try to
use RTC_PARAM_GET ioctl first and then roll back to use rtc procfs if 
RTC_PARAM_GET ioctl was not supported.

Thank you,
Joseph.



On 2024/5/3 2:49 PM, Alexandre Belloni wrote:
> On 02/05/2024 18:41:02-0700, Joseph Jang wrote:
>> Some platforms do not support WAKEUP service by default, we use a shell
>> script to check the absence of alarm content in /proc/driver/rtc.
> 
> procfs for the RTC has been deprecated for a while, don't use it.
> 
> Instead, you can use the RTC_PARAM_GET ioctl to get RTC_PARAM_FEATURES
> and then look at RTC_FEATURE_ALARM.
> See https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/tree/rtc.c
> 
>>
>> The script will validate /proc/driver/rtc when it is not empty and then
>> check if could find alarm content in it according to the rtc wakealarm
>> is supported or not.
>>
>> Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
>> as optional")
>>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> Signed-off-by: Joseph Jang <jjang@nvidia.com>
>> ---
>>   tools/testing/selftests/Makefile              |  1 +
>>   tools/testing/selftests/rtc/property/Makefile |  5 ++++
>>   .../selftests/rtc/property/rtc-alarm-test.sh  | 27 +++++++++++++++++++
>>   3 files changed, 33 insertions(+)
>>   create mode 100644 tools/testing/selftests/rtc/property/Makefile
>>   create mode 100755 tools/testing/selftests/rtc/property/rtc-alarm-test.sh
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index e1504833654d..f5d43e2132e8 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -80,6 +80,7 @@ TARGETS += riscv
>>   TARGETS += rlimits
>>   TARGETS += rseq
>>   TARGETS += rtc
>> +TARGETS += rtc/property
>>   TARGETS += rust
>>   TARGETS += seccomp
>>   TARGETS += sgx
>> diff --git a/tools/testing/selftests/rtc/property/Makefile b/tools/testing/selftests/rtc/property/Makefile
>> new file mode 100644
>> index 000000000000..c6f7aa4f0e29
>> --- /dev/null
>> +++ b/tools/testing/selftests/rtc/property/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +TEST_PROGS := rtc-alarm-test.sh
>> +
>> +include ../../lib.mk
>> +
>> diff --git a/tools/testing/selftests/rtc/property/rtc-alarm-test.sh b/tools/testing/selftests/rtc/property/rtc-alarm-test.sh
>> new file mode 100755
>> index 000000000000..3bee1dd5fbd0
>> --- /dev/null
>> +++ b/tools/testing/selftests/rtc/property/rtc-alarm-test.sh
>> @@ -0,0 +1,27 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +if [ ! -f /proc/driver/rtc ]; then
>> +	echo "SKIP: the /proc/driver/rtc is empty."
>> +	exit 4
>> +fi
>> +
>> +# Check if could find alarm content in /proc/driver/rtc according to
>> +# the rtc wakealarm is supported or not.
>> +if [ -n "$(ls /sys/class/rtc/rtc* | grep -i wakealarm)" ]; then
>> +	if [ -n "$(grep -i alarm /proc/driver/rtc)" ]; then
>> +		exit 0
>> +	else
>> +		echo "ERROR: The alarm content is not found."
>> +		cat /proc/driver/rtc
>> +		exit 1
>> +	fi
>> +else
>> +	if [ -n "$(grep -i alarm /proc/driver/rtc)" ]; then
>> +		echo "ERROR: The alarm content is found."
>> +		cat /proc/driver/rtc
>> +		exit 1
>> +	else
>> +		exit 0
>> +	fi
>> +fi
>> -- 
>> 2.34.1
>>
> 

