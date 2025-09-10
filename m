Return-Path: <linux-kselftest+bounces-41104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD9FB50C7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 05:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758F45E3F05
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 03:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782C626CE06;
	Wed, 10 Sep 2025 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gW4S65pk";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gW4S65pk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3650247299;
	Wed, 10 Sep 2025 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757476769; cv=fail; b=dtYfvvjWVWzMS+UY5MkPkM9DDNsG6uOPYOdkjZESAUCwZrdTH2O1XIpPfQzLIN2Pk+mpQr6DVrcwjfKqFFIiycP9iR46L+ao5uUGGD9tzrzcz3nkwjbiy8bNgy7dHu/rvn+MFYIrHVZyIzeKfstav+rM+l1h3JN7LikIth7JxWA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757476769; c=relaxed/simple;
	bh=roiW/xWKPIAwEbemTZ8iRRl0eTCgi9BtatFqsFhX3CM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IOsIfsU371WzIoePbCsqN6aBH759XYMLInYuzxU/gdbsrgzaiA2PMMuUaicBXW7MfSXuoF6nBYKJAEocZ/v1tkxo8VMWQs00T85hwhIAGZPl2ajEVCqx8RSUEOamVNZLXh1GTf0cfIvQobxc3OjTB4C7IN1MeqqBtKN0ceW8GMo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gW4S65pk; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gW4S65pk; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LV2piHj4vCYuOJfyAYSoj5HRaTIeABo62D3JUUQxuxrwq7fa1FVohEI5+kLKwhxXMVrGXQYvRh+J5YaWnT4MQZQP12fIqsCOJ2HEgPdaU4xSW86jRgAXa3tvznpADWhZ715mj01VQ/PItR3mfEHt4wvT+DgICR/S0l1N/Foxn9+e4M+HnY62DsZpbHsObind1kHXKUbcdDUF32hFq75XoHey5Ixk08e5nx6Ah4pQ9D0birDkbH9202NrQXXdwmlIyXzX7vEv38W5WBIVrs67TJhMheUi+6LRpDZl1tiug9c9/g2BCLFmu4kfUineFl4fabPHTbqpS/ERA8FRI8c8/w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roiW/xWKPIAwEbemTZ8iRRl0eTCgi9BtatFqsFhX3CM=;
 b=ezIPiK11mU/rHihEHljMMXj803v7kf7s4gxpa/kJiaBkQkf4JTH3WBSyBZxFrqNz+RlItsVUWZ22G0YfpFpxfkmu61x4hXDFA7rGtZaWYKg5iCpNnMSREOg/BKox+0xDqFEalxcN/rWPChSLMJS/JvlOF8QCtx/U+mkDSsPd7NORqGulmVFW11x9UYkDsY5CfJ4qP8BLTcUlk/8ZrfmUqHAzUqsccOzm8RQGDzJO43K/VOAJJ2dfXjzGFrSdfG3ofBK1uUZjxngpeRJyY9p2+W62VlWwhHkHmwmR9nln6c0ydPiwQm2JpktHGWSoDrcqglXX3CJJCvWjkEpk7FGqUg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roiW/xWKPIAwEbemTZ8iRRl0eTCgi9BtatFqsFhX3CM=;
 b=gW4S65pk/7F/4jYWS715sirSdNUevN8OyVDk9ymup5UriIg6PcE9eysYPFH6CsUgBZEtvlnpoAFoT0EGl/Xbi2LqLCAWXfcW/KrOeQxXRr4JQVUHOQXl6Ie2wX8xnMau0+nmpHR3Ewi9zEvUWYgFebEBuC6ml7U+KOdvbo39a7s=
Received: from DB7PR05CA0042.eurprd05.prod.outlook.com (2603:10a6:10:2e::19)
 by AS8PR08MB8134.eurprd08.prod.outlook.com (2603:10a6:20b:54f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 03:59:22 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:2e:cafe::b2) by DB7PR05CA0042.outlook.office365.com
 (2603:10a6:10:2e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 03:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Wed, 10 Sep 2025 03:59:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBSrYhLWnWxkOmajPw9uXIuPFyQwOBCYMS1J6/AYn326KJwrYXmard9nHeSYClGMumdYyN0njAlSuKqJP4SUEqu3cWIbSbl4EAZ601IF5oPrW+LOuSYZXDjln8CaUG1SldLhPos7q8i+t8swtLAS3K/uNo59MBIa1aZ3c7ihv8lZOiLGjjhFo+m1s6p8zFmpSx4of8X5saQDQV8dae4/tLugtBA33yGWIYXR4aTSDPufD1vwfp75HqGqIAxzXeWHXMQPlCr3jhGXpoh/a5XlyDqODp3X0FWcxmRWKkroakNPhxVRgktXhNOIh7fgl+P21WHAb1HIFcwpL/xpmt3ZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roiW/xWKPIAwEbemTZ8iRRl0eTCgi9BtatFqsFhX3CM=;
 b=GAJAvl++yAFJ5K71mYhcndCrN/c4GEgFiPyDQZmw39OEyFiiStqjWWcfqWkMQNVENjyyOe/b+jZnUD3CV0qDUghVr3dRY33EX6rpy9OMGIMUVEqs2BrPEVPtbwB9w91HwYcXrdQsezjn6i2kZW3tzHg6tqIWFXOma6YPE0UZMzl/SN7ZFYu8EyycWzcNkfO2+8Sdxc6Vc5DaMCkq6tQNvG6zMsu8Ou01DOPes55iTLszrnmEmwavbOUZShiKZP05dqb4BCgZHfFZcB7EFAbvb0iUL4RWMXHOElwTTQRo7Pa9o7YFXqUGPVsECEOyJIXC4iN+SuuZAY3YlmqPPwDItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roiW/xWKPIAwEbemTZ8iRRl0eTCgi9BtatFqsFhX3CM=;
 b=gW4S65pk/7F/4jYWS715sirSdNUevN8OyVDk9ymup5UriIg6PcE9eysYPFH6CsUgBZEtvlnpoAFoT0EGl/Xbi2LqLCAWXfcW/KrOeQxXRr4JQVUHOQXl6Ie2wX8xnMau0+nmpHR3Ewi9zEvUWYgFebEBuC6ml7U+KOdvbo39a7s=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AM7PR08MB5479.eurprd08.prod.outlook.com (2603:10a6:20b:104::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 03:58:44 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 03:58:44 +0000
Message-ID: <0ab335cd-a1f6-447d-8f52-30260b8ae400@arm.com>
Date: Wed, 10 Sep 2025 09:28:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: remove PROT_EXEC req from file-collapse
 tests
To: Zach O'Keefe <zokeefe@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250909190534.512801-1-zokeefe@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250909190534.512801-1-zokeefe@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AM7PR08MB5479:EE_|DB1PEPF000509E5:EE_|AS8PR08MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c91377-2443-466e-23c7-08ddf01e6c2b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UGRJejhMSmUwak9FbjhwU05EQmFadlJjK1ZWS1ZubHVoQWhhTXlwQ1MyYk5u?=
 =?utf-8?B?RUUvOGErcXZaRWJEREFPd3g4VXdFamwrSmRnUThaNEt3VGxKcVJ2Um0xZ3JY?=
 =?utf-8?B?Q1RXeVZYdzdHL1ZVM3RGa0VJcHZYc0FKUXJkNDIvUU9VY1NEbmhLSWI0YWpR?=
 =?utf-8?B?di9ncHZyYTdadWpVSC92QXVzZk51RzRpeisrNStKOGtObW1ZT0NGenZveFNk?=
 =?utf-8?B?QkFlSVNTOTlKTWlrNjQ4OFRzTThTNXdTVHdCRDNQRlZ0THVlUWVMZHpZTXkx?=
 =?utf-8?B?M3c0ejFnSktibTNqTDZDUTg0ZWM1TWVyUk9XKzlHYWtIME1yZGttVGxUeVJF?=
 =?utf-8?B?cGgwVUhJNnlldXRON3hQODdkSlRsM2pBbU44VGVjQ0hIRnlKWVRzVjJvKzVP?=
 =?utf-8?B?LzNsSGJUdnRVbjl1QUhDaUwrOGREanFpZDNkbGJ1OW4wRHNjdDdNeG9YbHFY?=
 =?utf-8?B?RDc5WkxPL1dZaHZDenVWRFJzYnVxdXJDN1VLYmxDczhqZnlWZE1uODFWTWNq?=
 =?utf-8?B?N1Iwd0VMUzNWWEJybmEwU0t2OWs0cUFlNFlDanlwWVZIZHlhR3RicVFibWFR?=
 =?utf-8?B?MUloUGlNTkxyUlZXb0NTVEs4eUphZUk1RWtIaEgvVFJaL0YyM1pXMWdmMk95?=
 =?utf-8?B?QXFxcVYwKzhrb1JKUWF6T1UzUUlPVzB3aSswb1JZcEZzYmxvRkRORHMvOTNx?=
 =?utf-8?B?MDFpbThPNGFUdzRzZVRyanJDalJvNHNEMzVraDlhNDVBSUlBUW9UQTZjRzNE?=
 =?utf-8?B?VWFCZ0F3ZURoSTZxL1BPK3ZFTUpmQ3ZTc3RUT1BxYjQ3ekhZYjhwQ0VqSHha?=
 =?utf-8?B?R3Z0RGlObjhyME9OR2FuK3RMdzVkSzZlYjd6T2daU1dHa3JIbU1EbmNzUFBX?=
 =?utf-8?B?ajZyazZTMVp4amdGUjNFd3A4bFUrMTl1SFJwYlg2dEhNSk5SZUEwY3Q4akRr?=
 =?utf-8?B?a0gxeVJCbENscmJiYTc0czAzME5nUThnYUZpV1kwSkt2L1dsQ3p0NURaQUZ0?=
 =?utf-8?B?ck4zMDBPRVg2Ujg2ZmRzcW5FYlVXb1NLdHdPc2pOaG9VWHN4dXhZN3NJWTdj?=
 =?utf-8?B?KytnRGdWb1UwcG05UWdTRnF1eWZCVGNzbzlkOEQzU1dCVk1NbnkzUmt4bnVW?=
 =?utf-8?B?U1g3MVhvWWtRL1AwckNhSWZiZFNCY0RTdjVNYXNvTXhKdVJpYldRU2s0VGJT?=
 =?utf-8?B?SXJIYzNWN0E3SURpelI2c2FBZUU2ejByRW4zc1NXbEV6V1lBYnM1MW12Q0p6?=
 =?utf-8?B?a1lFQ3BaMFN3eVQ0QlVvYVdMR29DTWwzcGtOVDltdEdGM1RNTTl2bWVVR0x0?=
 =?utf-8?B?N0c5cHVDUlNSRkJYeWU3czc3aFdKb0MxeHdJdHdvaVRoSG5oVWhCM3c5VXhm?=
 =?utf-8?B?TGVnUEhOK1g0OU1wNzVGK3AxcmxzdyswWCs4TWRSS2NOa3RxaDZGand0MDkz?=
 =?utf-8?B?NkFOTUUwRlBPMjhCUXVrNkozTkt1U2thY2VnK2pLTnh2NlBaQjZpOEVxdmxn?=
 =?utf-8?B?MG1OVUdjZ0xPQ1V0Si8ySVhYeTBHeDZQeUJFMEx5VVJWM2RHN0N6VEQrVjgr?=
 =?utf-8?B?NjEzWFFtUVBVY216N3R1RWUvMGNWVTNnVEIvMDF5QjJNcHlQaUlrSkR1SDFo?=
 =?utf-8?B?bkdRa083cnN3cFZsc01tK1dMekNjbzF6MGY4ZW80MXIwRjJob1lIcEN6ZjRq?=
 =?utf-8?B?a1FKUHk3VkMxZnJYZXl5UTFDU1J5ZWhTdW9GRUFPY1dqR3NDb1BycXRmVVgv?=
 =?utf-8?B?cTV2RC9xWm4yQk5oZ1VlMlk0MVpPVmtLa3dYWXpKRXBBN2FjM1I1Q3dYMjk5?=
 =?utf-8?B?d2Q3OEdvZWtjM2ZLWmpDT0VINnR1Z3RtWjJNbFlTUDh6SGRreTFvUC81ZWFG?=
 =?utf-8?B?cEtxQzlIZlNQMEwvN1VsTFFhOWRFRDFtc0VHYjBmUklZQ3hidHIrYlhVVGFC?=
 =?utf-8?B?Z1hCYVdlWUlSajNFZTFuTWIyait5U3ZMWjgyMlN5TWFzcjFUZnAxVTRiM2g5?=
 =?utf-8?B?QXZSb2daY3J3PT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5479
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	af61d3dc-04c9-4166-58d2-08ddf01e562e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|14060799003|82310400026|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SElZMTk3ZUNUcGZicEE4NmNVSk03WG8zazZEblFWd1AxcWZkdDVlaXF2YUFX?=
 =?utf-8?B?VzR5Q2F2THpHMzIzcDA3QzE5bC9nTUU1T2dqbHVTZkQwSzIrRlcyemRWY0Ji?=
 =?utf-8?B?MDhVWjFiR2gwT1k3TmFnNGIxbzFqYnhoQ2EzbTlsbnB4VEdDNWdabEVnbHNZ?=
 =?utf-8?B?QU9GS3FQYUFLQ2hoOXlUQnBtcG1kaUdyZkNuVkdxWEV4QnVVN0lOUzB4ODJX?=
 =?utf-8?B?TW5JN3Z6Q0RLVTRDdnkwSk1EM2llRm9MSUlRbWFSRVZidXJmeXMvdHJsRkg2?=
 =?utf-8?B?L0l1ZmZkbS9NN1B6T2JwdG4vNDdQNmFkNzlFaDlEWmxNR0Jpb2VBaU14azVo?=
 =?utf-8?B?Rkh4Z1hGQWR5Z282UEsxSXpGNVdSUmhFQ2kvd0ZjUWZxa0Y2SWFRL1Q4b2VG?=
 =?utf-8?B?WnVjMjU4dmFTT1FHZG1SOUZabTFhQWN4TEt5eHZRZDF0T2crWWdXbzh2Ti9V?=
 =?utf-8?B?ZTNGOGFiV1loK2s4Um42RURHZzIxYUNWcHI0dW9TN21CSldkNTVrTXRHTXZ5?=
 =?utf-8?B?OElTaENzd1Z3a3RoNFI3Tm1zTXJTZmtBNjgzMjRobTNnd1hrOW8xREhsTzFO?=
 =?utf-8?B?N0FFUzFvVzV3NTc2YjRnZ3lCeCtOcTdBTWRnV2lYZHNnUkZWMDFZL3FuSXR0?=
 =?utf-8?B?QmRHL1hMaW1RaWJZeTA4RnFBYnJQVU05OGlPRjk5c0R1QVo4N2h3b3R5QlUx?=
 =?utf-8?B?cXRUa25wSjJ1c1Y5dktqTEVpVGZNS2E1bFpzUTc1M2J4QWpSenR5NDBIbnVn?=
 =?utf-8?B?Y2k0LzNlU0xGOEZja0x6MUkxM28rTnNwM2tlbDJRL2VwWmU1R2c2UFlrR0Fs?=
 =?utf-8?B?M2hINk9hNVV3TUxFOHpkUkhaNjcrdnh5N2FRNkFML0xHUzBsdkZJR0pjaWx6?=
 =?utf-8?B?cjB6N24zSXdrRDducTV1WlZJR1ZmdTZMbXBEWldXZ2dOM0tpcS9ubU9kbVJu?=
 =?utf-8?B?bmtlbk1BN2tLS3JYZXd5RWhiVEVac1ZSbDdGVlA4WGN0NGtEcVlSSlNNclBW?=
 =?utf-8?B?N1ZPWS82ZDNhOUlFSHdSYzhab2ZnaFRPUU9NZk5XT3ZSczU2M2lWa2lhbi8x?=
 =?utf-8?B?OHhBVkVjL21QY2FscUVUdTZvUG5mckxlTS9HVGY3VDBTWVpaR2RyaE03aG5C?=
 =?utf-8?B?eDlSelduTnozc2tPcEYyektBLzFnT2xuWE5XNmh5RSs4ZzVzUTBqTUhSUWZu?=
 =?utf-8?B?SytPZXNRaitWOXVRazBwVUZRNnpkUWh5Q3VuOVVncFBEdjRpenNyZjlKNm9n?=
 =?utf-8?B?ZnkwU0NYTEYrcTlKZ3pCNnNPcUExbFBSejVGaCtyTUxiVDBrVUhYTk5XZ1cr?=
 =?utf-8?B?eU5YaURCbkViVXhJRzJCa2pvZEdDSk10U2JMei8zK0dBMHhmckR1ZUlUZ3Y0?=
 =?utf-8?B?UEdvT0paQ0F2T3VwWUxlMTF5UmpDTWx2Sk1WZnZscFg2WUFXRnVQNGZnN2sy?=
 =?utf-8?B?OGlMUmoveG15YityeGVONDVhK081TVd6eUNFZCtGV05DSzcwcVd5VE9pUUIy?=
 =?utf-8?B?VERnK0gwSlFTK3V4aWxmYXhydXpiOENyYlUrZkF3ZC9QcjBGR2t5K1UrSUl3?=
 =?utf-8?B?WGV6TjgyM3hRK2RjZW9JN0xRU0lKZHFXd2VqWW1Xa0FCVS9xc2VmTnBnZllX?=
 =?utf-8?B?UHBRUW5Xby9hR05oVndWd1RqbXlpL1JuUHJycEF3ZzcwWWkzbmNva3lDQWta?=
 =?utf-8?B?UTYyUVk3VG5aMTVkSEtxekkzVGZSVUtUQVhkVDkrYmljTTllbmRCV3pRNEJW?=
 =?utf-8?B?d1V4VEp5QWE4R2VKbDYrbk1xRFo3Uk9pQVFXVWlHbjV6RmE3ajIycTA2dGtt?=
 =?utf-8?B?cmt4SEZJN1pLMFBGYVZVNFJtaVhsQmZnTmtsYU4zREdzUjFXb0dWY3dXU1Zl?=
 =?utf-8?B?TUdxY2V1UUpENENkeEdtQnA5TXJzbU41U1RkQkhVOTNsWTJiNGY3enNKTWFJ?=
 =?utf-8?B?TGJMN0VwMitpditvZ0IxUjJvT3pRTWwwUXgxbE9xYllORlhGTWRjanJrOTJY?=
 =?utf-8?B?T25PODhhaGVKNHo5VlVlbUR0VjB6dlE4a2QwNVZ1NlcrbWV4b1ZQdFpFWTNs?=
 =?utf-8?B?ZGNacTFtTENUM1Jpek1KeUZxeFdVWWlYTnRuQT09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(14060799003)(82310400026)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 03:59:20.9942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c91377-2443-466e-23c7-08ddf01e6c2b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8134


On 10/09/25 12:35 am, Zach O'Keefe wrote:
> As of v6.8 commit 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
> thp collapse no longer requires file-backed mappings be created with
> PROT_EXEC.
>
> Remove the overly-strict dependency from thp collapse tests so we test
> the least-strict requirement for success.
>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>

LGTM

Reviewed-by: Dev Jain <dev.jain@arm.com>


