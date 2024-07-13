Return-Path: <linux-kselftest+bounces-13702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA49302A5
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 02:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784C71C20CCA
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 00:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9272F2B;
	Sat, 13 Jul 2024 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CaEFdFOM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F01849;
	Sat, 13 Jul 2024 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828921; cv=fail; b=CpevTLrt8tFeoasL73UR70tci2g4zRBG4bDC+uvOn4D45RqhURJj9VddtnIgx0jYmoSv9TLbFmDTV6KFtImW1z6kixft9kDXiXZs4NHtOfBeKbuy29hv+/59wJa8wY/1+oWxIDdR/r4Tq0ghC/CxGRF1ZMB1xZ0Zkl9t0bL/p8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828921; c=relaxed/simple;
	bh=wJXWzNqO6SzCgQ0VhpNDyiIa5GL7D969mTpi0FopQ3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jIBLgMhul7/4wquLYUnncQgVAPrCSahFm+J4eBjmvd3aYrmFfRI7aSFCelbzteIYvAF018t+pWZT3B6jCDqQlaFwfjJHnxrdlXd2Dk6ttzQoxY0/tCH+xnh1AOcYLLZwHB1jhTuMZhYy/dHT5i7qtBsJFFB7piSSlgRfC3u+dsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CaEFdFOM; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2bJqY1HO9VLcoACjQa5rgPayYOu5F/dDW/e7s8VryWWGf+VFSRmOIy772uqdaXhW3wfEFtgHuydbnmLlnq32W32chC+FTntKOnDLBcK4wIa6E8L8U68OgA5GKHJBt01FFzhKACm5+byFt1cg9/63mgrAvpIGVmjwDty7W0iREnZhende+IMP8myrz8JvKV4wjZl/C9jh45sXIs8qGxcbdABgy+n9E1qDS0PyAeSgAAFBhvauReCV7E89W6c/Wm0VWARXRhaoHTpUwtfXXc9Y6uPZfRGYoE2Pne8nuKRZUyyX7zJ6q20RzRpiuNbHUUSkwnrhSkjUnCKZ/TJZS8qhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1mT6PlMdzu79a8oj2oSMpn7lPddAo5re8ZN7EDToGo=;
 b=GYYbn+GtuAdzr7TircQxe0jjHfh9zylPa4wXhqwYWOfM9HMZeJpV+vVR6XHVqRMVncQlBy7vyERreyV0ZszGpv8djuzH8Y/I3A76+oZFFw3wkxvoYIDZdCcbZERHUptQPX+xeh90eUkwAa0dDMPrrog0ci+sXfcn34mBCVI1RFFb4DL5SKGWkOhQOAh1r1J+VC/VVoa0aAJ0pDWw5VtntE1YCnCemnluP1s0zOLHnpTdrBeTP63/ULBiojV3aDd+k7uczgMnCyNtz2GT5n3m0KptRDkzi1HbpEEwDdm8qrOPjxhNSXea3mbOoUrs8Fky3MeNnrJgIvnv+odSVnzmfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1mT6PlMdzu79a8oj2oSMpn7lPddAo5re8ZN7EDToGo=;
 b=CaEFdFOMPytTA0r5ZE7f9S4mSLx3DIfitz56IXN/TCBKrHnQdveKiEteZdeSWg67CCljmHDRzRgSEYfKTjcdePwvq2cbDI1zBC1DSR1uNIIF4W/GpQi7mKOHDl+xHsx92zsVrmGzvupFQoV3A9Kzhgy9J3f2Fayqq1b16MSFIfb4qhlKUHL09JQTygPbtrxYSpw7fAX6jic+2yQk1t/rrREj+2natGhmK2u3q5iwqtWz2wCsJnaXpZHM+4fYJnk1ZstewZkPmup9mnIChfBf/wXqZxZSFETuEtinlF9ywzFNPvRQOlv3Wh5mygUwBwedHzLgzd4jsOHBGGJC71Xqjg==
Received: from BY5PR16CA0021.namprd16.prod.outlook.com (2603:10b6:a03:1a0::34)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Sat, 13 Jul
 2024 00:01:56 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::55) by BY5PR16CA0021.outlook.office365.com
 (2603:10b6:a03:1a0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Sat, 13 Jul 2024 00:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.5 via Frontend Transport; Sat, 13 Jul 2024 00:01:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 12 Jul
 2024 17:01:40 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 12 Jul
 2024 17:01:39 -0700
Message-ID: <682e293b-cc0d-4261-90a8-bc6f16df0992@nvidia.com>
Date: Fri, 12 Jul 2024 17:01:38 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/net: fix gro.c compilation failure due to
 non-existent opt_ipproto_off
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
	<afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, Pravin B Shelar <pshelar@ovn.org>, "Willem
 de Bruijn" <willemdebruijn.kernel@gmail.com>, Alexander Mikhalitsyn
	<alexander@mihalicyn.com>, zhujun2 <zhujun2@cmss.chinamobile.com>, "Petr
 Machata" <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, "Benjamin
 Poirier" <bpoirier@nvidia.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Dmitry Safonov <0x7f454c46@gmail.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-actions@lists.infradead.org>, <mptcp@lists.linux.dev>,
	<dev@openvswitch.org>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<stable@vger.kernel.org>, Ignat Korchagin <ignat@cloudflare.com>
References: <20240712235150.99175-1-jhubbard@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240712235150.99175-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 1667e350-5152-4741-711a-08dca2cf0244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXBWV1B4dWExY082ekxQaGRjTWh0UHZwWjI0QTZtNGsveU9PREFaK2N5eWg3?=
 =?utf-8?B?MUI0RXNWVEhXUEZPbURjcVNNdnRNSjllbDIvSjdKTjllaE1MNXhFMktlM3Fa?=
 =?utf-8?B?SERYdVZsODRBUFg2TXk1U0gxSWplWWl1bEU2M2NlMTIrOEx6dVlHb01ORjd1?=
 =?utf-8?B?S2NRRUJqYnFwUU5ObkFvMURobnU4SGNESDlqY05kZksydCtmZ2x1V3lrOXJr?=
 =?utf-8?B?YlZrYzJCNmgzMjNETUZxQ05uenc1aDB0b3Z5cHo2UHlqY0xCaFVCL1FRK3JH?=
 =?utf-8?B?VG85TXgrcjVXWlB6Mk5Ja2RPanNOZ1NCKzRRaytXU3JnNkMrMk93bjdEVE9L?=
 =?utf-8?B?OG1ncm1YMXBuUUpGYmh0Z0FIVkxuK2ZuazFab1dFQzVkMnIvV1MzdWZVcnBE?=
 =?utf-8?B?QkVCb0JaejFUSllWNmp5dy9wc2N1L1M0RkhzTENLZms4YWo0dDVZaGNrR3hH?=
 =?utf-8?B?WUd5RUZOZ3BjUUtNSFRJRHJLZVE2eklUa2VIUk42K1dHRjlIRkxBRWFYc1dT?=
 =?utf-8?B?OExKanIvRkxtRmVzNGY2QVBUZ3UvUlg1K1BHR3ZLdlY0RGk2enQ0SHBiM2tC?=
 =?utf-8?B?aVlwRi8zOGV3RGpEclY2eXoyelRmTm4wT2cwd2lNUEV5blkxMnJNRGUrUnpl?=
 =?utf-8?B?Q3pFaWl1VW5kZW1KNzVPYyt4b2NvTEpKZE1HNmxEdzQwV2wxSGRqZVpTc2xN?=
 =?utf-8?B?QkRKT1FwRW0wK0h0LytsY0xnRDZyb0tqOUgwcVBWM2w3dFBhcENrVlVHYUlk?=
 =?utf-8?B?YXUrMXZMNG11ZDJQMlJJWFJORVFYRGZHT0w3QmRGVXlDdlI1MjhsV2QrbmhL?=
 =?utf-8?B?amZTc2lGbVZFaVJUelhmVzFldzNuR0JDNkQrbHVSU1VWVDBKcjV4cDVpcXAx?=
 =?utf-8?B?VGlIN2hORjJjUlF2elRoMWpySmthMnZNVndiRm5Bc2Z4YkI2NkU2UXhnaTBU?=
 =?utf-8?B?d3cxOG1maDVXeTJrTlVCNWpTWE8rYnQzaVF2M05sRDFiMUNJU09mRW0wcGJO?=
 =?utf-8?B?ZXo2cjh3OEVTcS9IcVZtb3lyUFVBZzlsWDY3N29hTVJTYWVFL1hyZmdCNHB1?=
 =?utf-8?B?SU44a2pTUXVQbmtkbENyT2cyY0NnbmV6V3poTVpFelZWV1VLVUtrMnNmZU1j?=
 =?utf-8?B?QjFTRnNzOHh5aUZvNmFiUkJLdGFnZEQxakJiQ2pLTGNPbmpCNUFRNmlBNWp5?=
 =?utf-8?B?Yk9UWm5zcnd0TmMvWFFySE1zTGNPcFRkQmpzSjFVOVJ6cW5uc1dJVzdzZmho?=
 =?utf-8?B?elJqUkxJWHlyOUVZZGptQU5mdkxpVnVReG1SUVBmNUxkZkRIUStBYUVCaWov?=
 =?utf-8?B?Z1habkFOUGhKSHMwUnNyOXF2QXdKUDVRbEo2eG5OM0tCY2l3cUcrYXdadWxT?=
 =?utf-8?B?U2hOcG1hQ3ZNbTg2aGRFVWk0K0ZYRS90eFluaE81WXFWMEdWVmxaQXhIa1Nn?=
 =?utf-8?B?c0pDMk4rZlVQSkIrdGtjZWxYeHdDUFJYQVh6ZFp4TzFya2N1NkNKVlhaVXRh?=
 =?utf-8?B?bzFPS0U1U3B3eTE4YmQ1TTVtU2VXZUJlQmd0UjYxaXJYYXVFNDlKbDZMdDgv?=
 =?utf-8?B?K29wbzNtU1hINDJTWjFCYzBmNm84ZEtITHZINFFaRXJhMzlpcEd1TG5NSHhN?=
 =?utf-8?B?amROa29meStZZFVxT0V3QmU5NVA2NUp4Z2kwR3F4c2xqK1Rjbjd5YmU3Y2ln?=
 =?utf-8?B?UHYvSS8zc3Rocno0S3kwb0tYc2pXcW5BTWFwamtGNVMxOC9UdUV4eXJRaDNU?=
 =?utf-8?B?U2FKR3ZSbzlhTkRQWGVITFR1UEkrUWkyRnJGUzgrTk1tSUQwcjVBK3FSQWxY?=
 =?utf-8?B?MStoK0YxZEV1eEtZRWNmRHJxQVpOa3pBZE5rVVdXZDVRYnh3UVNTMzgvVTdi?=
 =?utf-8?B?aWhhdEJ1MGpQRkZCVThGZUppVGNKc0Y0Nk85OEZFRitwZFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 00:01:55.9425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1667e350-5152-4741-711a-08dca2cf0244
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458

On 7/12/24 4:51 PM, John Hubbard wrote:
> Linux 6.6 does not have an opt_ipproto_off variable in gro.c at all (it
> was added in later kernel versions), so attempting to initialize one
> breaks the build.

This is the first time I've tried to fix something in linux-stable, and
I'm not sure that I've made it completely clear. This is only for
linux-6.6.y in linux-stable.

thanks,
-- 
John Hubbard
NVIDIA

> 
> Fixes: c80d53c484e8 ("selftests/net: fix uninitialized variables")
> Cc: <stable@vger.kernel.org> # 6.6
> Reported-by: Ignat Korchagin <ignat@cloudflare.com>
> Closes: https://lore.kernel.org/all/8B1717DB-8C4A-47EE-B28C-170B630C4639@cloudflare.com/#t
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/net/gro.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> index b204df4f3332..30024d0ed373 100644
> --- a/tools/testing/selftests/net/gro.c
> +++ b/tools/testing/selftests/net/gro.c
> @@ -113,9 +113,6 @@ static void setup_sock_filter(int fd)
>   		next_off = offsetof(struct ipv6hdr, nexthdr);
>   	ipproto_off = ETH_HLEN + next_off;
>   
> -	/* Overridden later if exthdrs are used: */
> -	opt_ipproto_off = ipproto_off;
> -
>   	if (strcmp(testname, "ip") == 0) {
>   		if (proto == PF_INET)
>   			optlen = sizeof(struct ip_timestamp);
> 
> base-commit: 2ced7518a03d002284999ed8336ffac462a358ec



