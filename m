Return-Path: <linux-kselftest+bounces-26210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56FEA2F8BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 20:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3703A5852
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A7D1F4636;
	Mon, 10 Feb 2025 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iN64Vdti"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF325E463;
	Mon, 10 Feb 2025 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216180; cv=fail; b=OxQhC2itl0/yj81JPSXUZ/41LsXzy9HORLKppHG6IyOMTEVCBIwev0MLztTP4NKRr9xjwSY835eBKsFMtCPcls7nzrVvXwgRsvXAcguXIcpBaJVMHuUrpkVHhnctWJMQn8IuM+qd0dboRaT7yxVobjsZ2q1ye1Uo5+Q2ugyG4KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216180; c=relaxed/simple;
	bh=kRmawHGjR44fzElCwUWT3pEvdhWXBtToxmQQnUxC7E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZhVpd5YyYGjPccp6Sufa8vNMWciD7Oyk8MFa+s34Lg08up7xrSv36y3r7kYcooYkBC34yNrzdtkm36EnKGSJjS1trrZFqrSHsoINGPNF9qDakQYyu3oUmW2OXyqGwza0S8P/MEIW2lUz5Z9TY8mPToFbXlDEvrBFgj9Nv6AmJe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iN64Vdti; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dStBtIAdefcaEaR//yfvXc26TtBm5QebZjpdHPcshJY81hTmsnnyeQ94IC7mnv5iG538wa1ZEygRdtZWpVN7aVFm9urabCmK6Pbi+T9mJRLgGOxNAVwIl8cfPZugMiOhjZ+8NETqJDFcu9WmYc+dF9GWu24tiSJ9DZzS9ct6trDMxbYC5aUMgcqYYGbDx+riY2lhqQSQpxk1GHI7Ntux5/CizUDNFx9DJxA7ki9ruqxfH4o36FWG72PCfquss5AhaR0J0VXrBBFSSx6ZgCI9NBLjI8k1baVuQy7hS0XegBMggKEP5nyeUN5kun7O/IzvwI99tEA9fnJ+7gpPn/lslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZMUxCVp69WYhHe5ROJW8AidBf7CU55pUWp2yom9Gwg=;
 b=ilrKRugjMJ++ul8fjGT0NI2VDTP2LrOL799HTALGyOYSBs2HBOiskNm8sVZPq3isky/kjncpHJpbso60sM6M/Vl458IAGyitao9flaEmTSakpikaSNFNIuau5Yimkx+paYeZth8t9/GxJ6orC5YRKaNmkrlzjRxbIHvYCQAoZWp/4SJo+QUW5eUTMCc1M4qjQ2M6BsvK/inJ1LAGdTTPCrYu3WKE2uVVUDbRkJzm1e5vYEEoAbx8v2ueUnr+zsN1ffz7eCkTXU4UxQRZw55igIGOFF1yjSwHodFiKEyivsY617l213+T6FgRINa+Sv2Rt9iouYDmS7MHpsFP2bdWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZMUxCVp69WYhHe5ROJW8AidBf7CU55pUWp2yom9Gwg=;
 b=iN64VdtisDoowOVTWSU7/ACcUMv+zQwAKnxRjyiw5Lyv6psff/G5sSCYyZ14YxzvaX10Vf8dovkg06T+x6OgHidhxjimvvIxJTv2itqELgY9xIz94IP8GBN6sNbhBi8vdDZFZKEKJDpu+ybpKfFSkefEaJiYQYgqPzUwi/S/03sN+9eLZwpRKBEP3JKJlfAeWP4CI6ogJWOP1sPHoLMt/jf4wpj/qqyrMe6H6dgfjfpQwEVyeMeEYNBrMeWHWKkA2y3B+3lSko3C6AHHdWgaq36fDzBoOxwd4J9iJ48k8sHRje5xMLfJISRwVN5FTa5ONkQewGNiUVKvhmXHtDsemg==
Received: from SN6PR04CA0099.namprd04.prod.outlook.com (2603:10b6:805:f2::40)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Mon, 10 Feb
 2025 19:36:12 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:f2:cafe::5d) by SN6PR04CA0099.outlook.office365.com
 (2603:10b6:805:f2::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 19:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 19:36:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 11:35:54 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 10 Feb
 2025 11:35:53 -0800
Message-ID: <bd71c705-5f57-4067-b200-fd80b98ddbc9@nvidia.com>
Date: Mon, 10 Feb 2025 11:35:48 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: distro support for CONFIG_KUNIT: [PATCH 0/3] bitmap: convert
 self-test to KUnit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Yury Norov
	<yury.norov@gmail.com>
CC: Tamir Duberstein <tamird@gmail.com>, David Gow <davidgow@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen
 N Rao" <naveen@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Shuah Khan" <shuah@kernel.org>, Kees Cook <kees@kernel.org>, Muhammad Usama
 Anjum <usama.anjum@collabora.com>, <linux-kernel@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kselftest@vger.kernel.org>, Brad Figg <bfigg@nvidia.com>, "David
 Hildenbrand" <david@redhat.com>, Michal Hocko <mhocko@suse.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
 <Z6eaDuXnT_rjVSNS@thinkpad>
 <CAMuHMdUsq_39kgBa8oanXeTzv44HuhS1e5MK7K2jxkVXQ7uWdw@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAMuHMdUsq_39kgBa8oanXeTzv44HuhS1e5MK7K2jxkVXQ7uWdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f9e31b-8c45-4366-4be5-08dd4a0a2cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkhXRld6T2huK0IvVitzdnV2azAvYU50Vm93VnRkYUY0QnUzR044bnN2aGd4?=
 =?utf-8?B?RGhTQmxxNzlYbzM1K2dnTncxK3BkSVRUZGkzZzMvNThNUDJVSHdQNjdxYnZE?=
 =?utf-8?B?d2EvbVoyUk9NcFU1OGlFQzhtTm8zZDFUY2xwUmFjc2g1dldkbkdLaU93NVNa?=
 =?utf-8?B?Z3V1RVlTczFtL3BSalpXUmp5THE3MEFRMUc1V3drYUhIRTlqZWhmWnlFdklw?=
 =?utf-8?B?T3A5b3k1NzFrY21iS1p1MmY4T0dwZ2Evci9wdDcxakhMQnJQaFdlL3FBdzM1?=
 =?utf-8?B?QzdiMmFRTUpDd1Y0WWI1WkJ2NlYyYXhvc3NhTFNyMjFOL3hPTmxhTDZNM0Fq?=
 =?utf-8?B?UnRNb2x0UkpGN0NYNFh0Zms5RW5QU2hRR1JxeFdFeHc2a2J6eGY3alJqZ0Jt?=
 =?utf-8?B?UXp3RFFwZFZNLzdsaHFZMHBObVdLNmlTWVNJOXdXUkFlVDhGRjZtd2d3SStW?=
 =?utf-8?B?VjdCQ2NVWFVaZUZxWkx5eXlzQjZOUXlkazY0QVBTcDlzd1NrY0ZsRjNVQUMz?=
 =?utf-8?B?NUNIakZUVCtVVVEvdHBrQnk1ckxUUERxMVdLVHZVOGtjaVFnVDZmZkk4ZUNV?=
 =?utf-8?B?encrazVjNUVGTmYvMEtRbHZ6ZDlHUkhia0RITURCaisxVWs1eGcvUXBzQjQ5?=
 =?utf-8?B?bnBPWlpFUk5zVlN4elJXZmU5NHJ0L2kyY2ZiZ2JheDNwaG9MNVhKVmIwMkZW?=
 =?utf-8?B?NURjbExRRGlFeklyUlVRVHhwRmpUOW4xOUhmUHltdnA1VW80cVNyUGlRNGc4?=
 =?utf-8?B?ZXM3YmNBVGxpei9OS0g4cERVRFFqOGdpSDlacEN2VHkyanVoVGk1Y2htMUty?=
 =?utf-8?B?VE1qaWFNaVRscUFFRXpKVy9RSU1pM1MwZ0RGbDVNOEFNbTJjYU4rK280aWNr?=
 =?utf-8?B?bW9jbkRCQVpUSXNlMEVkZjQrMUhhVGdtdWFJMHYvL0ZJV2tzRzYyWS82T2Jn?=
 =?utf-8?B?THgwNDUyU1Boby80N21XajA5ZXlxVHRmU0FXUkxHRCt4WnBjeUtJbmVjYW11?=
 =?utf-8?B?TEowSUQrVGtvakZuY3krN1ZsTnNQK0J3UmFwMUo0YVQxVTEzNGNPNm9BV1Fp?=
 =?utf-8?B?ZXE3Rkx6c0NFRVZ4bmRpZTh3WVZCMlpMUDJLeFprMEhiWDZra01PL3dJYnZ5?=
 =?utf-8?B?VzczOENmYmxleXhrQ1NOa2lsUnYvcUZWdEFlQW1EOElGR0JvdThOckl4TUJH?=
 =?utf-8?B?TWpSeiszTVNFOTh4cWxkc0FWT2V2YUdveUpOcUlSMCsrMmI4M3lCMVF2Tkls?=
 =?utf-8?B?aDhnRjN3RzBncXRQTklKTzkzSTZJTERlYWxibTZ4YVFaY1lJeWR1aVdKUXps?=
 =?utf-8?B?T2dCcDBkZ1J5TExuKzBvZjhsaEVmbkxKNFluc0hxU3VQSjA1VVZJTXFqNlBR?=
 =?utf-8?B?VGdnOUlYeEJ0M29Celo0KzB0ZEpLMkw2djJUTEd5bXI4dytmOWhvL0xZNEl0?=
 =?utf-8?B?eHVZTUZuMHFCbkJ0SjUzR3lYZG1rajZhUHY1N2o1dm0zKzlJRi9HOHNyamFo?=
 =?utf-8?B?ZzA4K28xOGw3VDNXR1VvNngvWURRbys2OUFWbU1lU3pmeUVMRndZN0F3OUs2?=
 =?utf-8?B?QXFjMzBSZjEvc0ZiWUd0Y0w0TEdFbHpqVlZpeDNmRjJ5MjVaZFBIb3g5R1g0?=
 =?utf-8?B?eUtRMkZpcllqQ3NnR2FDdU14cEZnejVzRmcrSHRYenppeXZqRTk4c1RSUFo4?=
 =?utf-8?B?UTM5RVQ5K0szTDcrS0hnQUxlMFVZemhLU0U1Q2VhTkxrWE1xcnhlUzlIL254?=
 =?utf-8?B?S2VvNVpObmE0cmtuOHMrQ2ttSldDeThVb1VEeGlEUGZsWkdYc1VrZllSd2Zm?=
 =?utf-8?B?Sk9rbm1McEkzajU3cjg1dXdMN0JMTUxJT20zZHBIalJvUFBCQUM0VGZ6aVpJ?=
 =?utf-8?B?eTlDczlzRUtrS1ZwNlJFblBRcXRXMTdUWFFUM050Nnk5TFV4VlNtUlROelVh?=
 =?utf-8?B?ZDNJN3AyTnA0clpaWUo1bWVncXpzV3NkQm12VzFRVHJsVDd0b2pTQkpHTkx5?=
 =?utf-8?Q?Br0yjLsl1rEDQD5RuELNSf8TR5U5VQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 19:36:11.9120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f9e31b-8c45-4366-4be5-08dd4a0a2cf2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320

On 2/9/25 11:54 PM, Geert Uytterhoeven wrote:
> On Sat, 8 Feb 2025 at 18:53, Yury Norov <yury.norov@gmail.com> wrote:
>> On Fri, Feb 07, 2025 at 03:14:01PM -0500, Tamir Duberstein wrote:
>>> On 7/27/24 12:35 AM, Shuah Khan wrote:
...
>>> The crux of the argument seems to be that the config help text is taken
>>> to describe the author's intent with the fragment "at boot". I think
> 
> IMO, "at boot" is a misnomer, as most tests can be either builtin
> or modular.

Right.

> 
>> KUNIT is disabled in defconfig, at least on x86_64. It is also disabled
>> on my Ubuntu 24.04 machine. If I take your patches, I'll be unable to

OK so I just bought a shiny new test machine, and installed one of the
big name distros on it, hoping they've moved ahead and bought into the kunit
story...

$ grep KUNIT /boot/config-6.8.0-52-generic
# CONFIG_KUNIT is not set

...gagghh! No such luck. One more data point, in support of Yuri's complaint. :)

> 
> I think distros should start setting CONFIG_KUNIT=m.

Yes they should! kunit really does have important advantages for many use
cases, including bitmaps here, and "CONFIG_KUNIT is not set" is the main
obstacle.

Let me add a few people to Cc who might be able to influence some distros.

thanks,
-- 
John Hubbard


