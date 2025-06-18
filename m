Return-Path: <linux-kselftest+bounces-35296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4523ADEFFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FDF03A28A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80B2EBB96;
	Wed, 18 Jun 2025 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qsDz4U0m";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qsDz4U0m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D152EBBA5;
	Wed, 18 Jun 2025 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257881; cv=fail; b=bmGkxJk49o0ZgQXhWlsUbsZpbcTW+M48O8hzEcceMaML/0SV683As9fFeMuAv8iTCTv6NzcVMVFaRTXnEwkYyyTkEvqWzs1Cg8EQqf9C53/3Fm9yLvNPke+Qx6Qi0OQzgWJQJ66Ki7WYv6/DGdqJemB+9m+7+CG2GMJzVOzX5Ws=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257881; c=relaxed/simple;
	bh=8PAcvS23cquh+3ONPJGtMkRT5ITpbfK0GVhEHJG9qcs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D4/5OLZKJRskC2rPl3QXmf8or+MsrWpv1y3VvTjf0I7vaGfrd1yyBe/w1In7WXGF6PfLPca4uz0Eq2MwAwtIn+Bwc9QAxo+P1Bj1dIJ8yqEsQSFzpWwojOsCQIoLbTBOM3jXkLmvUmqbkULJBQELrtqncCl+5X/Dx3P7SisOaMc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qsDz4U0m; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qsDz4U0m; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZDpqiPg/614CqEuACATDmMhZW9rD7vG4SJri8KFAFFgmHxN14n1jYXVIhyl0r4NTqFPenQ7MtVolFmoUbF1hOBKLL/1oC4cO5LcFwxpJK7SZbyiM80GIfYKWM7NDhK39NsJ4JuUKOJXRcRUKO1y7LpCkyZYDQdhupdjc1sfTosR8djmZIZUv/+cC2JWGeXEwwCqm8SF3Qz+YtQgGfhrtsS/g6MUxwWVO8kYAgxKJLCa26Riyy2D2Ml1LcnAXWxnlHRHyUzAy6PEzf65raGOPo7s1Krz5y4yGqudf9WMULUfnQ9K5us72WR9NDCEgH7mVhl+5fsxwExjzg1urhRL4uQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kUMEggi+vowtZYuVNec+46V1u7Z/+3lG3u4593dO6o=;
 b=JuB8SZIan/ZRNh/Mg3KqshgJTGRuYGg/aO299f7VIQouqbMp6O7n/qdC6rRf3xzdsQyAIvb1GmKTRpNn7fzPgfFqwIVJvS8ielkU+0de33RgRgM2u1nj884NjvFUVY0Jsu/Vaezl9eyk1OuN4z9fSzWJGIxBgl3Pf/6aH4flUzLgkeJi7dVYj+N9mrDiH/MtNIyEBjoYxbmwyzi+OkH/rOeS2RW622GPlpXSonJNz9D8m2HDbQl6agcZy/1jjltfKvdgwTUPlV4fMPhG5PdphI2jN5fsPHEHON4e6X+643a4VrAD4D+s4064O0SJ10rCpsmPYEU/8p75F21R8hmypw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kUMEggi+vowtZYuVNec+46V1u7Z/+3lG3u4593dO6o=;
 b=qsDz4U0mEWLNBjjsfWiCrHfQPfH6RZvN9BwRDVC4rkIngfeoT0Uds+LzOuS8BzdTAXdRWA7ZuYrpyUP9QlsKoWp6aaXDNlpI0kyDxTnLq7C63EEg1FIPPbMiNnJa9BFB5A8+SfBCulrVwOs3jE/LerxrdGUIepsua0KofHB1F/k=
Received: from AS4P190CA0066.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::9)
 by AS8PR08MB8157.eurprd08.prod.outlook.com (2603:10a6:20b:54e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 14:44:33 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:20b:656:cafe::df) by AS4P190CA0066.outlook.office365.com
 (2603:10a6:20b:656::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.34 via Frontend Transport; Wed,
 18 Jun 2025 14:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Wed, 18 Jun 2025 14:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkJlEC05FWCja2NkS0Co9SnH7NYwfW2IL3WXLhJbpZeGXc2iUuaBpNk4N0q3gQThkudSw3IPn0LXcMMUcN7KYkFlbeQvNNZLF8/gpenmmp9W71W3HKZ1hTWfX8SFz7RK8M0rhy3C5iP+cmGgK4KWVT6yB4zKwf4e5XxuktDzw7djTqTXJILk565dGKoxfikAbU+kjeSkAFml9kf+efignFL8kfjtIRbnJ1hj3uPhZQrrfeZIXQIir3wb35MKs9JLw8Aorj0t0QkAC5GKyTHsXcls5RW36E5AZeA0kPCcBiqEv9OkYkvPixKng9aFIThB+wgPZwV9UenAcgg0oZe4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kUMEggi+vowtZYuVNec+46V1u7Z/+3lG3u4593dO6o=;
 b=twtRvfurlMAeKt4GWp0t+0tHlv04YFQyHun+XUAEGd5VsTs0At2NJSmUW+x5iocCRNmnw1ZecdlvPw5vDlX+/h6sC3KA9zdgkgG69pJZAwYXYNuf/NUuo+JYn8VFQ/bPRCSTuJ5dlglzqmw754wTG6Qajlf28reuNSJLWygwmcns6ZfJOD7PM2b5Tn6jX6vdtHXYBsCbWAE6xpanQWN5tBNjT8+1fr6MfvVTf/0j7ildt5/q0QP50CE5hP0ZFyhZXapsRPNa/kUf9Cnlfkv8VhcJvR0dMIdSct97u/Dl+DtrNCwLpAvy/FEA0AyeIqSvBim/mX/4pg2RRCKqUkevRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kUMEggi+vowtZYuVNec+46V1u7Z/+3lG3u4593dO6o=;
 b=qsDz4U0mEWLNBjjsfWiCrHfQPfH6RZvN9BwRDVC4rkIngfeoT0Uds+LzOuS8BzdTAXdRWA7ZuYrpyUP9QlsKoWp6aaXDNlpI0kyDxTnLq7C63EEg1FIPPbMiNnJa9BFB5A8+SfBCulrVwOs3jE/LerxrdGUIepsua0KofHB1F/k=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB5943.eurprd08.prod.outlook.com (2603:10a6:20b:23e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 14:44:00 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 14:44:00 +0000
Message-ID: <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
Date: Wed, 18 Jun 2025 20:13:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250616160632.35250-2-aboorvad@linux.ibm.com>
 <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
 <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
 <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
 <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::19) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB5943:EE_|AMS0EPF000001A2:EE_|AS8PR08MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 173a3eb7-0801-4947-5dc0-08ddae76a37b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RkNYTzdOdWtRcERzTVdvK1dWL2xrMmJKY3B4QWRaNUFBNkhIbDIybVNxTzQ1?=
 =?utf-8?B?cHZZMjJDWVlmTXJsditqYmFRM2NQTTFVUWVVM0QvNGdCQU9TN2ZKNndXNTBX?=
 =?utf-8?B?NUZWTTc5VCtFWDBnQmlDMTM0R1lVRUd1VDAvcC9HNmo1N1BnT0tCczNJS3Ur?=
 =?utf-8?B?U1h1V1pFS2NjcklQNS9PdGNEczNKQjkzMEYwRlNhSmFRaDZXbkoxNHN2TUwz?=
 =?utf-8?B?Y0pmelIwc1J3Mmg2VHFYK1ozWGpRU0xsbzFrcXJLbVhpcW4wWEJZcEt0NUFS?=
 =?utf-8?B?N3RTVEk4Skx6Zm1VTHovOXdBRzJIcnorVGF6Q0daSzE0L1hpNFBXaVRBaTZt?=
 =?utf-8?B?WmpNbFhyS2c2VWE1VVpkbEM1VFFxRDYwSlo4K0pic3VjeUgxam5pYWZ2STBQ?=
 =?utf-8?B?STVsLzJGZ0ZJaXRhVlg4SDVldmVReFhTRUtUSFd4U2FWc3ZURDAxcDZndU5p?=
 =?utf-8?B?d2NWN1pPaGNsVE9WS0svak5OdzBMSkhSRTlpMzJycVppZVVPNy9LZlZPZHRD?=
 =?utf-8?B?QWFiYjRUUTR0THYxa3BJK0FIQ2gvMGM5Z1lPNThTNTRzcmZ0T1VVcW5Cd2JR?=
 =?utf-8?B?ODM5UGo0NFFCNHJ4R2J3QTZjQWZDMklDRmFwa2JiSkdaNjlJbk05Ty9KRWcw?=
 =?utf-8?B?YU5zbWxzQmE1Y1I1b09SaUNQWXgzY3JEZWlPSTBRUHNpNWN6SXdvVEdlWEVn?=
 =?utf-8?B?Nk5mSzF3T3FUeFR4RHBRN3U4c2kyc0xjMFBlbGY3UzlaRHY0L2pqOEkzRU5v?=
 =?utf-8?B?QTRzd3RNQVowbFVmVnJSR3hOdzd0ejdmUWFQcGI0MVE5Zk9OYlEwMmowQmRL?=
 =?utf-8?B?S2szZHc5RFB0UTNxK3JaQ3RpOVhSdFoycFVBS01EQWd0czNTdDFVc0tTY1Ey?=
 =?utf-8?B?ZEpjWmZ0YXJXaGpmelcrM3JvTTMvbTlyQmFCRFBPZTJjOUVaTEUwTzRYY3J3?=
 =?utf-8?B?Si8yWlJwbzZLOTc3c0c4ZWJYeHZwWEFWenhHZ2l3T0xHYi9zekk1QUhpV3Za?=
 =?utf-8?B?TE82WlhiSkRtTXU5UHVYTjRJNWNOelBYeWtrT3RnSURFM2NsM3orcXNkVUFy?=
 =?utf-8?B?VUZrRGM2TWd1QUc1cGp4cUQ3OUVNSU1HRUJTT2RTVnN5QTJYWFVCZmFPYzFu?=
 =?utf-8?B?cjFPREswYnkvQVQ1Y2QzUmZZUzlHRW1YR3RzYmh5SzB1UGVsdXRXREw3WUV3?=
 =?utf-8?B?QzU1MWdLSWU0cWZCTWxJajhiSkxMSHg2U1ZNZ1hQbjJGSEIwUVBDdVNwMWZJ?=
 =?utf-8?B?ajNtenhYUzJzOFJxSmxMK3lhalhYWHA2S2J6OEtpK21Ea2RsNVFXbmRhWEN3?=
 =?utf-8?B?SFA1dUM0d2swblk5djNhVFpVZ2I4dnJaYnB1OWQ1d2FBUHhqNUNjNUlWaW4w?=
 =?utf-8?B?K3lpVGxoa21ETU9xbFBkQ3c4NEtmaldTSXNqTVVBMlNxVjRYNmdCU0tnczlI?=
 =?utf-8?B?N1RMOUlWN0NTTGd1alU3bzd3eEg0d3RRQ0Rzc096Zzk3cFdmWDdTNmZXNHhh?=
 =?utf-8?B?dGZvaFJwUG8xVnMyaStiT3Y0cUVWY2ZjbGdkS1kySnJhNDArcTlNWjRpSjZ4?=
 =?utf-8?B?TnpBelE5eUZSb0h6ODhWYWRsM1Z0UFprZmcxeDhUbEJPK0l0NWQ5eXp6OU81?=
 =?utf-8?B?Wm1nUncxQ3RUa0JHRWl2RGFOYmlrQTBjNU1ucFI1OWNLM2Jwbjh5TXR3eVg3?=
 =?utf-8?B?MnVLTk84T0F1VFZ5a2xQSkJ3MlNrdEthV3l0Rko3dUZBUGZuazNnQ040RmxE?=
 =?utf-8?B?THM1V2VKUDRobnZqT0EwU3pZeXpOVkxhSTFRUE5iNmlla3ZhSksvOVZOaHJr?=
 =?utf-8?B?Mmc0WWIrRlI4YXcxVGZNK3lLUDVGSWt0a1hTMUIwWE4wMGdwaUEzNDBObWcr?=
 =?utf-8?B?Z2N6M01oMkJQSkpFZWhmZlFSZWZSbi8zQllyeWJGK0tmVGtJZDZtVm16a2xK?=
 =?utf-8?Q?7hOYeqgpCgI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5943
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d8223a8b-38a3-4375-cdc4-08ddae76901c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|35042699022|14060799003|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHVvWnR0SVNUQnh6bzl4dzVWWHd2K3F2aW5DWUtQSVRRK3dEcngwSXVDMmpo?=
 =?utf-8?B?d3V6dUVFRWdJdXZDNnRkek93S0c1K0RNcGpLdm5DTU13VWpYS0p2bUxITWRu?=
 =?utf-8?B?ZVgrWkRGNW1JZDB3NkwyOUpKRStkQXF5UUlGTnVhZ0VidVU5Y3g4aFRPZStG?=
 =?utf-8?B?YWxMb0RnVTFjMno1UlFucHJlOVpReHBadlpnNlNyZUgxTS8wOUg0Rjduc3Fz?=
 =?utf-8?B?T2k4cUFxRHdaeXFFbkt1MmYyb2oyZjhEY0NZUFZmcCt1dzZteTJ4SnlUclhi?=
 =?utf-8?B?QTMySTJnY2lkZkE5MFNDUGtsOElvbFpFdWhmdFYwT1hpK1pwZE5SQ2NrS0RG?=
 =?utf-8?B?YiszQllkdVFueEFVUGcvNWpkcFA0b0RLcU5nVUpnU0pqOWY0STFtaTFGdjBa?=
 =?utf-8?B?bXZyaisvMlozM2tlS3dNYXA1NS9YdFcwdHpWL0sxRHhLYkcyVm14MUdyU1ZV?=
 =?utf-8?B?b1dsdVc0T3R5QzVYNWhuU1puUTY5ZHdrTjNhU2IvQ25qb3h2Sm5zMlBaU3Jx?=
 =?utf-8?B?N0paemlUNVJXK3NmTE5tQytsMHZFdXRRWXIwdk9ZMWZjRXZPeTRpYk96djJD?=
 =?utf-8?B?cmh6R2ZmditCUUtaZWx3azliTW5wdWYvZ0ZwK1dGb0VqZmJvN3lhTFJtMWRs?=
 =?utf-8?B?K0dQRlV3bVFQelBCYU1oRTRKaE1BQVpkRXk4dENtUDJWcE5KeHNJWGtoWStq?=
 =?utf-8?B?bHUxazY5bmlvRVdrQ2tOTDhHTU1namppSFYvTnZZT21HWTBCMXNsRTFvMUpv?=
 =?utf-8?B?UURRaGFzMUx3VDRzR2xGNy9sMnFHbjBHaEdjNGhJa2tzU2dGOUVsS0M2SEFN?=
 =?utf-8?B?bjBudjBXZGlhMCs5dDBrQjduM2RFaXcvcnVnQU00NEVBeituclNLckJ4S2My?=
 =?utf-8?B?SFE3Zks5Ylc0NEs0NFExRloyNU11cXdMUG1mNXFFdlpiTUxSaUV2K0M3d1da?=
 =?utf-8?B?dk8yVlFtUTE1aytkL2lzVEcxd2tsSWpiTGgxWFpKc2x4OWFJN3JHcjg3M2NZ?=
 =?utf-8?B?TEFxVXJYL2E2UDFMNEtuWEtxcnY0a3plZGlXTkhtV2J3MUZHaTJ2a0VCald6?=
 =?utf-8?B?RHdaWGtqeEY2em5pS3VwaWtiN2FiZW9yQUh5czZkVGVCc1B0OUZQQ1pmL3E5?=
 =?utf-8?B?NWhJcm91ODRyQjBJSjV6QjdVL2JqVkJoZk5oUElrUXRkU2dVNXlRYlkzTXI4?=
 =?utf-8?B?TW5BdnVnaE11dVcrNzBqcndjc3QvMTBCL1VRR0d1THFYTzRWV2V0ZEFvTjlZ?=
 =?utf-8?B?SnhCY3JlbktwOEJxYzR4ekxKT3grVUlyT21MQi9qYmxYam1HT0pVTWIwLy9O?=
 =?utf-8?B?RFJXZGFpbkovRUdLUndiQzBVclNpTUNxUUpCNWtvVFhKK2NtNENRSlppYmky?=
 =?utf-8?B?RytRQWFWUWhKM0pveHdZYkFJNFVGNFZKNU1Ca2UwbjFER3hCU0NSTy8xKzZB?=
 =?utf-8?B?aDVVbUkvY1pOd2tjUGxESVVTUVpYanppU09Kd0Ztc0dDZE1ZTkp3SEVuT3hK?=
 =?utf-8?B?T2lmK1VHY2F1UDJoWndRdmFtM0lIb3RKeStPU3FEcFI2cVErUFN2Q2tjK21F?=
 =?utf-8?B?SCszUmIyRHIvbjk1c1BodW05a2pLbjlkeVl5ZHdlbjlsQXBPODQ1TWRqZFVt?=
 =?utf-8?B?OWRoNmI2akwvK0I4Rk03RFQ1b1kzalo1aDlsVG5DOFJ2TVBOeFpBc1FqdDN2?=
 =?utf-8?B?b3JON3JIeUJiNzBzZCtSMmJPM1YybWQvWG4xVS9kQ2pTeDJVRC9JS0w3M0xW?=
 =?utf-8?B?MVFmdFBTWkRaUVFLREwzZmt3NGwwSUh2Mm5uR1d6YmR3NUdSUjRWVVFia0lY?=
 =?utf-8?B?RjZYbzA5ZStVL0N5bVVzaTZiMzF6ZUhpNjllWnlaUEpXVWllNkZhdDFZeTNS?=
 =?utf-8?B?VWxTQzczdWpNc2ZhRXoybm85bGc5M24wZVl6NHNCZEgzbUlIYWw5QlRpRVdO?=
 =?utf-8?B?TU1xNW11NGNpdjQ2UzV6MUp2OU1uc1JWT0x3alRtUVFTL2RIWXdBRktDMURr?=
 =?utf-8?B?VDUvNUdqUVhYa2RTbktHTkhsVFkrTVdlQS9Ec2FSUEhMWnJhSzB3TERlUjJV?=
 =?utf-8?Q?niEc5S?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(35042699022)(14060799003)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:44:32.7750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 173a3eb7-0801-4947-5dc0-08ddae76a37b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8157


On 18/06/25 8:05 pm, Lorenzo Stoakes wrote:
> On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
>> On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
>>> On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
>>>> On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
>>>>> On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>>>>> Are you accounting for sys.max_map_count? If not, then you'll be hitting that
>>>>> first.
>>>> run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
>>> Umm, what? You mean overcommit all mode, and that has no bearing on the max
>>> mapping count check.
>>>
>>> In do_mmap():
>>>
>>> 	/* Too many mappings? */
>>> 	if (mm->map_count > sysctl_max_map_count)
>>> 		return -ENOMEM;
>>>
>>>
>>> As well as numerous other checks in mm/vma.c.
>> Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
>> this.
> No problem! It's hard to be aware of everything in mm :)
>
>>> I'm not sure why an overcommit toggle is even necessary when you could use
>>> MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
>>>
>>> I'm pretty confused as to what this test is really achieving honestly. This
>>> isn't a useful way of asserting mmap() behaviour as far as I can tell.
>> Well, seems like a useful way to me at least : ) Not sure if you are in the mood
>> to discuss that but if you'd like me to explain from start to end what the test
>> is doing, I can do that : )
>>
> I just don't have time right now, I guess I'll have to come back to it
> later... it's not the end of the world for it to be iffy in my view as long as
> it passes, but it might just not be of great value.
>
> Philosophically I'd rather we didn't assert internal implementation details like
> where we place mappings in userland memory. At no point do we promise to not
> leave larger gaps if we feel like it :)

You have a fair point. Anyhow a debate for another day.

>
> I'm guessing, reading more, the _real_ test here is some mathematical assertion
> about layout from HIGH_ADDR_SHIFT -> end of address space when using hints.
>
> But again I'm not sure that achieves much and again also is asserting internal
> implementation details.
>
> Correct behaviour of this kind of thing probably better belongs to tests in the
> userland VMA testing I'd say.
>
> Sorry I don't mean to do down work you've done before, just giving an honest
> technical appraisal!

Nah, it will be rather hilarious to see it all go down the drain xD

>
> Anyway don't let this block work to fix the test if it's failing. We can revisit
> this later.

Sure. @Aboorva and Donet, I still believe that the correct approach is to elide
the gap check at the crossing boundary. What do you think?


