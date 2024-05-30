Return-Path: <linux-kselftest+bounces-10897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AAE8D4491
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 06:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37B11C20F0F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 04:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECA314388C;
	Thu, 30 May 2024 04:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L/d1naLT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4225763;
	Thu, 30 May 2024 04:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717043746; cv=fail; b=GDxs0DHGA9ByTRAFngIXCrZWWa2m/iKxbSvGBsys0G4/6Lw2dbri69UoregnXvPlWzS7cUgHcw59lO9ICsgtzdBMBOOQbWZAaA+oxzgOjpTr6oRKinRE4MNawDlZ3R80/HxrP7VU/schILscopOyHfZma3Cnx9GUwuntSkpP/1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717043746; c=relaxed/simple;
	bh=gDi/e2D+l0QAIkotOCiVMNQ89jUMieVWCwmY8H7TKTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uYN5SyMF4cJmfLLbakTaU0q0ghrw2jnOQLT76Pg7nz3WCh8iUAyJbRl9z9nWBMr6/EScAZrzqV8aNg9j87WAjxVlXx9aqeNfv65JA4Q2dpsDc/pNDUlb7jr7cRKWqZDjUxkAXEWrqzCojwJ14ujkYPP53z2aaRx0UZdeYt5rG3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L/d1naLT; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrowZJYmpXLYwbWxabBNrXSGpt/7otDAf2/B4HtkXIdO8wM9JsU+8jXwqPe3dj+Nb7jgvOs0JGyd37J3ogPFdfuYtpfV/mw9CqPxWsbbYVXYcNow9mvmzbifsngM9Eg5V1gvPSZVJfrvrJWEvErbDHbtjIt8Xq/dBsEhVQ2NcKtaWwceUo2n9roRi9zI8k4OiaMtd/E1KTw8sRow2UXVCVqryfk/RTN8bRBISMV6eQZFvMbr4AcR7GzF96O9zAoIA3s9KTZ3HEwolt+BrNojtIi1gW7Xgm3PjPTb3AeYaDON6yuPWct6AedZ+irWmQ5Qb/bJ/XXGOK5upNMqWT0ygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICHkA+rgHLsdzrhOy0BNyuCm+gO86Dn8VkXXJGazIHA=;
 b=KQDSsnrvwo5R5gwyekq+ZiBcXmtDnQzQSwp0k3guL89aWvB/i3q+ihOomKoQYfhsqrcfcP+lG8MvkqGmONqCQPDUAHnSTaq8sX8DZ7VvSi0FVQ8KSqZbrKnVF+5b8OwPIEZ/cv/mpx6dArmJAQ255f9YgTn8p4cVhePKAZ6vLffteBLGM6ysnmTQVCgfruTzGtjyuagxMHZH0gE1FMdwZRoM7FE9gIZ/yPZeGtmoy9MPRViAudn+UPR/6/p3DsozXsxukgF4mCkTpRUbG5CCPFA6VsxMwtCF9pzLoCe8tvY2Z2PVnbfIUKv138SvAVq2OzqPNtBpWgMOEPBG0wtB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICHkA+rgHLsdzrhOy0BNyuCm+gO86Dn8VkXXJGazIHA=;
 b=L/d1naLTForH5rMFdLFT80V+dxzEva1eWmXgClYTKSzVUiQgWQV+hc2vV17kNEynpN86SqgxAVxEJMLSZJXAOkYkCI8YF/6i1lQXg1z/upkJsVsXShyh3Hqg7E59KTSw/6oyulH6Muj5k7E0G4seYB/nrXFeMIAHNHd5uujCa1U+p3yz8+uIiBGw1WmewOjiHyV9UW8Rl2nJPoqQ/T0fQ9pUA7McwTuoesjAZGjScviXK4sXIfiskZl0c9lC7IONEaYlji0wya/zobMPFi01At8Uyomj7xrpqpqLwyhAwcxPK7Z9iBS4IAzgwbm18QvRPBbWx2aeqVrloEkZwKj+ow==
Received: from SN7PR04CA0180.namprd04.prod.outlook.com (2603:10b6:806:125::35)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 04:35:39 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::be) by SN7PR04CA0180.outlook.office365.com
 (2603:10b6:806:125::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Thu, 30 May 2024 04:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 04:35:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 21:35:26 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 21:35:26 -0700
Message-ID: <00ba2d8c-6b0f-46f4-bd19-bce19842c356@nvidia.com>
Date: Wed, 29 May 2024 21:35:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/openat2: fix clang build failures:
 -static-libasan, LOCAL_HDRS
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
CC: Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Maciej Wieczor-Retman
	<maciej.wieczor-retman@intel.com>, Christian Brauner <brauner@kernel.org>,
	Alexey Gladkov <legion@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan
	<shuah@kernel.org>
References: <20240504044336.14411-1-jhubbard@nvidia.com>
 <c406383d-e08a-4a12-9e25-1c987b0d678f@arm.com>
 <f715719a-c835-496c-9e99-d249e5607a0b@nvidia.com>
 <1aec9470-9af2-4113-9cbb-9930ccd92a0b@collabora.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <1aec9470-9af2-4113-9cbb-9930ccd92a0b@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: bf35b0f5-0b26-4b43-9732-08dc8061f53f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|1800799015|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFdkS1h3cks4dDcwcU16blNyVkczNmFFYjd6L2swMkVwdFlUeUV2UHlXaHpS?=
 =?utf-8?B?RGZORmN0b29qZjZkYzEzSmFZbzJEdkUvTTJJRDR5ampIZ29VSEU3UFdMc0Js?=
 =?utf-8?B?RkhBMEVEb0Evb0xndEFGcHQ5cFErYUhMNk1GL3RaQ3JBblk0bUpPNWJhNGdU?=
 =?utf-8?B?VEFFTTJoakhTbCs1SFpoVnRaVnMzWkVCb05rbXcrcklKQUlkNUxVMUkwb25i?=
 =?utf-8?B?enFaTTIwQm1FMmZlcXJJYkROYUFxcmVCR0JvMm1SeWFtalBCbkEzTWF5Q043?=
 =?utf-8?B?ZCs4eFBGSHBONDhNay85WmNvLzJnSDVITlcvbnR4Yk9pRll4RU83QTVSekZ3?=
 =?utf-8?B?dlJzVXB2YWloS290VVhHYWZKVTZSUVVERUlObVNpanNrUUFtYXM1VTNvbmVU?=
 =?utf-8?B?cm5lc1cvTVZiTzFRS2RibVY3UlNNcWw2T2h4YmFGbDZaRjZPVkR1bmZVVVZq?=
 =?utf-8?B?S01NQXJ5dE9JSXQzOHV3dGVRR1kxYXNmVUd3a0J6TmplYzNTMlQvaGdrNlda?=
 =?utf-8?B?Q2JnRUhpY2JWQVVORDJ6M01tNEkwVUNicmlRYXRNZ0dIRUhhdDJZMnMxWE1Q?=
 =?utf-8?B?N0F4SFFRVjJJcUhmaHVOYVV2aCtDUmZVb0ZEMnRoOTZ4QkFlZDFhSklEZnlF?=
 =?utf-8?B?TEhabnNRamV5ei9uMm1jRUZ4dVFQbnBYR21RMnl1WVZtQjB3MG5QUzYxN2Uy?=
 =?utf-8?B?cXA0cUVJd3paZjZvZkNrb0dkRll0a1l6eVcrdDZiaWxjTyswbmwwYTVRTkNQ?=
 =?utf-8?B?L2FEYXFjWGYxRVFRKzRFblZWN0RGcjhCbWxqNDJoTDhSdTVURU1QMUVncXBj?=
 =?utf-8?B?QXQwdENDaCtzTkljSUZBODhrb3ZhbXYxU0RGU1N3d2d5NjAzOERRV0dnZTJF?=
 =?utf-8?B?c1lNMXNIRmtHZG9rSGlBKy9aKzI5Wktmc0lZeDdNRzRNb2J2QjF1dVc4SWUx?=
 =?utf-8?B?cUR0eWRDVXRScXYzNCtPRWd1d1QzNW1rSUlIR0k4RHVsNDQ3ZWF1SFlKODhr?=
 =?utf-8?B?Q2lFcmJjaFJDVnZyYnRpczNhN1Zua0M0c1BkSTBkcXFIOU5tUlFrYjRrc3Ew?=
 =?utf-8?B?VVdDa0ZwbEtwRjNXbnIvU25nYlJtSWQ3SlRGeE5zYjhYTFZsTFFZKzk5S1F0?=
 =?utf-8?B?NzJYSlJWeWdLYXZLUmU5SnlNMmlMV2VHcHpDQ2tHQjZTL2lMVTFGNVM2NzBK?=
 =?utf-8?B?cXc4SXloZm90aEplYjRNNmZnNXhyL2RVOWpvcFAxbWpPOWV3aVdMdFR4eTVv?=
 =?utf-8?B?QWJIQVgydk5DcjU2SjYycndROVc4bFhhUGJtUVlwVEhYTzlsOGc2dDJ4TDhW?=
 =?utf-8?B?cjF5c2QvR0RnelpDRlcyblBDTnorNkxNZS96dGRjV0w5VDRjSmJESnpDNUM5?=
 =?utf-8?B?MEJUd3BOR1NPODlUaldyTnJQWGxWUFdtSDNQZGd0Vi9oT29wbW9IaHhvWERs?=
 =?utf-8?B?cUJhSThlbkhESEllUmhseUFZNlo4T1hqa2lqR2YzaEtOdlVkMC9yTGJzbmlX?=
 =?utf-8?B?ZnNKMmU4V1JyTGtac2hkaHcvY0lIU3JOZC9ISmp1RFVrQmNXOVFkK0c1YmMr?=
 =?utf-8?B?cHVBQjkvbFRFcmRXRjlUSHNOQ01TSFhsbzdZbkVyUTdDVU9obk5rTmc3NnhC?=
 =?utf-8?B?d05pQ0RHY09kY2FQRDZpakRzYVZybUpyVDFzR0JyV01yN3pWeGZ3RS9hMTI1?=
 =?utf-8?B?bUJRbi9ubENBVjBHSkpSeUdwV05qemQ0ZnRJN25yQVZUaEExUDJ4NDFUK2Ez?=
 =?utf-8?B?Zk45VURqTENCLzMrcnlqSW9mTVBjQVlwYnlrdkFrWjF2SzFmZmVyVTVEdkNC?=
 =?utf-8?Q?9+fCGoKEry4uIlJamebiHrE1WzFgTAkkXyjms=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 04:35:39.3129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf35b0f5-0b26-4b43-9732-08dc8061f53f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

On 5/29/24 8:58 PM, Muhammad Usama Anjum wrote:
> On 5/10/24 10:56 PM, John Hubbard wrote:
>> On 5/10/24 4:52 AM, Ryan Roberts wrote:
>>> On 04/05/2024 05:43, John Hubbard wrote:
>> ...
>> In Make, the arguments to functions include *all* spaces, so it's good
>> practice to not add spaces in most function calls, unless they are
>> definitely desired.
>>
>> Also, you only ever want one of those $(CC) options, so saying so is a
>> nice touch. Neither of these is a functional issue in [2], but you could
>> do this on top of the patch (I'm only showing the openat2 case):
> I was building with CC=clang and build was still failing. We should be able
> to build by CC=clang and LLVM=1 both. It seems like patches still haven't
> been accepted. Let's get a v2 out to fix this.
> 

Yes, these are about next on the list, and I expect to post a v2 or its moral
equivalent tomorrow or the next day at the latest.

For the CC=clang vs. LLVM=1 issue in particular, I've already posted a
fix, please see my "[PATCH 0/2] selftests/lib.mk: LLVM=1, CC=clang, and
warnings" [1] that went out just yesterday.

[1] https://lore.kernel.org/20240529020842.127275-1-jhubbard@nvidia.com

thanks,
-- 
John Hubbard
NVIDIA


