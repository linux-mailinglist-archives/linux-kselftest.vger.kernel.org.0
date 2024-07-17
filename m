Return-Path: <linux-kselftest+bounces-13848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6EB9343AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 23:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14902837CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165745B05E;
	Wed, 17 Jul 2024 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D3O8gmRL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865052262B;
	Wed, 17 Jul 2024 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250716; cv=fail; b=eqNPYLey6Qr08Gk/gM6EZWwAfzCyizIY2Orh+NOzTHK07pLRQRyDmchkWiacK5HKPm1N4xYxtclLCoTPAai+KAYX6rHGxPoWH29EzA5WzGLWgbmkbmdPeLEvfydwItdzvFbtvq0flc+lDckUbgBVw+yLEl/fdXyOOkfzgUccqeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250716; c=relaxed/simple;
	bh=e9jfuFk4D5mkCI8v62NrF7r16TlV4vaFvwKtFeoH0ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=boUK3xn6Fg/td5Lv3bStnRTKxhCsjlPEqcauowGG1gNIRKvlcVT2+vkXrfiwP4E/0cDzwESJcverb47lQyaLKx/8irbskzN0aJBsVJnldVgohVdNZ01ZDyH2Ngt9+KcWcfqMXyFe1lsqNx9Yaj3zI9o7UxkIk9aIlZ1maFp9K30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D3O8gmRL; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c796Qac30CUtKny3rLptVg6JBr+vO6t7kmu++B4t5H9kqhFhz1BX9ck2wBq+BmgsJVL33XEACnbrc2AVx6jqCOGYwfLUwlI/9d1sjzV7z0moKr9OoXfeiiamow8bkFi5GVVyUpuB2qznVUVivdMJUcJRblYtiqNr/v7IrydbmWUpwV2O1MyLBEdLBgrAcOfGkMM5z+QATrjwcNQ8bYXSrCsIj6lHAXpwaH7M283XqI/dvB09I/VYhdtN2y/k091xyhn6RK7oRZM3/YXzqhIkILaWhfb6uq5e+/QywS/bnfQ9OS/xttKiFtIBFJ2gF6o7hK2bG/WcXw5fKgUeyzx0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/Uef5r8u1YU89dc+r9g4BeCFAoFTn2he76ej+4GxVY=;
 b=HcLWq/FftNe7/0Pvzq4hpvxorwx/oAD+2hlOonY1PBunkktNl1PhCXTSBzpBLW5sz27vt5mQmEG+GN+pkW3MRUJJmA9DW/w5eSmIdf2OgOErsek9V9In1QEgrfUMNpJbSRLhKwBXrUo1v7b7ed1175qCLTC9kR54KHbWHBLk1d7FQ7b6HwrljfloyqI7VTg5Y7TOMLny2cr1DDfjjRGjNskkSc6piQPqQfmdgAvel+5yyEacLkvIOIaeJpxVT8M4SKlrLp9ZPPOxzTliTydNy+WU4iWCZiv5mJpGL3u5xLVnEG1KmzOCHXL+8Ukga4JUgGeMNuRrLlI+Y+tiWhw/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/Uef5r8u1YU89dc+r9g4BeCFAoFTn2he76ej+4GxVY=;
 b=D3O8gmRL1H72IB1RYyoWDmgjm//OoN618/lDBTH21If2ReWB25HczwlqV/RQ52WIl4wyElacb0WaBHZChZPvAGdymskf9sc98l8lGvIPGAvu7Muyv+9cMss1SsOGOGPtZvB60YWQn2WxwkB9fPI9H7BJ+wLHC3iG/5GPN00zniBgOHaVp09IlNdWf/a7B24IbHq94gKpHq+Bh9Ax6s/nBmWyapuJTX9L1U2DLslFIIQGSFfna7psAcnJ4GB+ca6NHBA0d9xMxvL7Ei0IPnQZOL/L0fpFUwOvJJspEpQXKu7Ok3I740b06bVm/nf0mcsix8nFqL1aZ0GE1bXJF9u5qA==
Received: from MN2PR08CA0006.namprd08.prod.outlook.com (2603:10b6:208:239::11)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 21:11:51 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::58) by MN2PR08CA0006.outlook.office365.com
 (2603:10b6:208:239::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Wed, 17 Jul 2024 21:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 21:11:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Jul
 2024 14:11:35 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Jul
 2024 14:11:34 -0700
Message-ID: <81c79e52-4e77-45c8-bc42-00b5d096d6d9@nvidia.com>
Date: Wed, 17 Jul 2024 14:11:33 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Converting kselftest test modules to kunit
To: Kees Cook <kees@kernel.org>
CC: Muhammad Usama Anjum <usama.anjum@collabora.com>, Shuah Khan
	<shuah@kernel.org>, <davidgow@google.com>, "open list : KERNEL SELFTEST
 FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, <kunit-dev@googlegroups.com>,
	"kernel@collabora.com" <kernel@collabora.com>
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
 <202407150936.C32FE24CA@keescook>
 <8412a936-b202-4313-b5b4-ce6e72a3392f@collabora.com>
 <202407161005.CACE2E355@keescook>
 <11359c6a-9863-4ffd-8fe4-04b777c72c9f@nvidia.com>
 <202407161124.8DF2E794AF@keescook>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <202407161124.8DF2E794AF@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b315c90-707e-4e54-6bb3-08dca6a513a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck9ObEl1Qm94M0EvejVmZVlZc3Y1Z2kvM1paaG41eDZZYVd0N0p0V0Vic2hQ?=
 =?utf-8?B?Tm00MGJNa21HWkZPWDFyazlPUFpPRzMyTDhXMVM4U3B6U21TYVE1eUpWOG9p?=
 =?utf-8?B?ZldOUEx3OElmSGgyRE5kNDcraW44ODVpSU5MVnlwNVFyVHEvTjNjMFRZaVli?=
 =?utf-8?B?OEYrVUR2OVZ0dVBuQyt5UldaMkFpcXl6L3oyNzhqcGpVWXo0WnZ3SmFVOFBB?=
 =?utf-8?B?QzV1MXZ6b2JwTU5vb3RkZWQ5Q2cwSzl5WEFaT2c2Q3pSQ1RhdkgwSEFuZStW?=
 =?utf-8?B?TXQzUHJnUEw3YUJESDlTaHJWcy9JTHYxd0s5VXNzT2RCbzYzTytJRFpwNUFp?=
 =?utf-8?B?b05PYS9QMlIvenc0eTJOc0xzK01oTGpYNTJuZTk4SkRiQXBScUphTTd4VHFn?=
 =?utf-8?B?bmdNeG1yMmFvM21zb0hDVTdJSXhWOVVJSkZFSm9ORnd3Z2k3Vkc5eDVsUnE5?=
 =?utf-8?B?cHd3K2U3bTdKU0dzRE1XUlpENW1GeHgzcHpKR0VnTlZNcStaT1U4S0JFU1pO?=
 =?utf-8?B?bkxQY3B3QVdXRnBhNG9BOWNkSDA1N25Kc1QyQ3g0c2NkT05vdER2Q0E1VXRG?=
 =?utf-8?B?WUZHNXBTYXlDL2xvMUUrN0M5ZVJGaWszVzlPL2VPeXQ0Z0oxMUNpcG9KcFFp?=
 =?utf-8?B?WTk4SDNSSzE4c1E0aDByUXI3Z2xKSjRRUE9NVzVBUHo0MUF2dU1uQ21NK2NC?=
 =?utf-8?B?MUM3NmRhenRsNUlMTEpSZmVBdmoxM3laWDZEeVRhTEZ2Y0ZCNHVaMmI1d2Fs?=
 =?utf-8?B?RDY2QlhkSkdZU0dNRFZSRVRzWWg4am15Vi9RbHdRaHlSa0Y0ZnRvbE9EVWgv?=
 =?utf-8?B?Ynl2U1BpMnZmV2piWURwYXZMSjZDZldLSGx2RkEzZnBsR1ZGbjBMZWtHT0hF?=
 =?utf-8?B?elpCK1ZwVzdUL2hnemNyaVJyaEo3cmtMcnkzYmxxckl4NUlPb3AwQ0JvTml2?=
 =?utf-8?B?WmhrdnpxNCtoQW90Qm1Gc3NqR3RvUVdrYnBqcGQ5TVErTDRkK3JSa0ZsZ2pG?=
 =?utf-8?B?UWoyWnFSd1FSWW9zR2pHY1NOWk10c3NZczRKRmFKaEs3RjNrcEhrQ3NHSjhY?=
 =?utf-8?B?UWMyK2lkTXMyMmphMkZ1NVYreTZEd1J3OUNRZjJrTnNpazkzeFdiSE9mdkZZ?=
 =?utf-8?B?QW0rbEE3MklKci9nRmdmTWhKK0NpcHdtNTd1T0t0cVpHVTJOdWRjU2pySno4?=
 =?utf-8?B?dGg5cG5LaDVQV2pPS0JhY1k1cU1GSmQ0RE9vMXdwYysweDNHT3JHd2ptS3F1?=
 =?utf-8?B?TUIxRkZQdUw2WVBZMTRiNWRZd2diSzV6QnNYQVUyamlwdEdQUjZ2YVlyMU0r?=
 =?utf-8?B?RjRXaGc0NHhld1czZS9zMDNqaHhpakhjOWdvcjJTS2VyL2YxMGNXWmd6NDcv?=
 =?utf-8?B?bk91U0h6blk5Z2lMWlB2aEJiRTkwM1FjTGRkTEpSVjFwSlhYL1RkcTZMdHFM?=
 =?utf-8?B?Qk1jRmdVUjRVVk50UFp6czRZMk1IRW4xZnl2NmZWSjg5NlByamdDT3lyQVB2?=
 =?utf-8?B?VFRuZkFKMmtHdklXOTJpUjhhcDh6a0FROXYrT244c0QyWWJ5TXNNVm94ejgx?=
 =?utf-8?B?T2RjVC9FbkJUWVZ1QTNrN0FxcmJYQ2Jyc0lvRjQ5NEVtZDhoS1R3cUp1VlB1?=
 =?utf-8?B?bW1HaEZNUERZZVNBY2R2VnRlOVQzNXFTcC9sckNNWUY3TVN2aXhZQjRoZlZE?=
 =?utf-8?B?clVKMC9WQ3puTDJ3YlFTTjhidVJac1hURkxUUHlGbHJpWWhzMm1iUm9QTzQw?=
 =?utf-8?B?VXVLTDNnNEJMTWkwL0JBZWRQOGtoU2NiUlhNaW81Y0JrRER2OGptL3d3b2Ev?=
 =?utf-8?B?Y2JodktQUTZKaFdtRWZ1cndLUDBDQTUwS1VwUkNjTmlBT2EwRnJlL0JhNVBQ?=
 =?utf-8?B?VUQ4MUZlQ2UybERRWllZdDFVaU1WV2RZT09zVUhpZlA4YUI0MGdETGRzaWgw?=
 =?utf-8?Q?0qI9cKPCXl7ej2JDW+2z743fn1l1zJlr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 21:11:50.7431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b315c90-707e-4e54-6bb3-08dca6a513a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

On 7/16/24 11:26 AM, Kees Cook wrote:
> On Tue, Jul 16, 2024 at 11:04:06AM -0700, John Hubbard wrote:
>> This is a classic case of testing a kernel API via ioctl into the
>> kernel, so I think it meets your criteria for moving to KUnit.
>> Having said that, I must now go try out KUnit in a bit more depth
>> before I'm sure that this will work out. But it should.
> 
> I've found the docs really helpful:
> https://docs.kernel.org/dev-tools/kunit/
> 
> Searching for *_kunit.c will also give a lot of examples. And the kunit
> folks are really responsive to questions, helping guide finding solutions
> to novel testing needs, etc. :)
> 

OK, yes very helpful. I guess I've got some unique biases, because I
found it extremely odd to put so much emphasis on the arch=UM, as
opposed to loading a kunit kernel module on baremetal and running
tests there. I mean, yes, VMs or user mode Linux have their place,
but baremetal testing is really important (and in many cases, the
only way).

Anyway, this confirms for me that kunit should work perfectly for
converting mm/gup_test.

thanks,
-- 
John Hubbard
NVIDIA


