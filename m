Return-Path: <linux-kselftest+bounces-13851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C73593441B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 23:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE8E5B23B8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 21:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D65C18A92D;
	Wed, 17 Jul 2024 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E5gEKTl6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3CD18F2DD;
	Wed, 17 Jul 2024 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252682; cv=fail; b=j/9Oi1OE0iXGQ9bDRgeVyh/9W8bOWVuOqb9g8oAH0LyA0XJquwwAt++Hb4LxhyDCWZgBGCCfjSH/eiI1ZFT/JJbo5lDcYpW5n2WJroSFwE4hhyaf3w0dYs29HhVJiR0fuyLj/E3PJeD2cBbU26z3N7kh754YgZKp/6Q5brv+OSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252682; c=relaxed/simple;
	bh=y3TI4OEzU2WQ62UQSspbzJuwEVkhusYiu1GN8Ws1boM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SpP1vcjGdEfa67X5llg/anAkc0tAqtGaj+ac7XuuHFBZorB+YMhf9+uz9fQi8uyApgnnBbbEX/T+ky0r46XpUxAFXEVlxCdLwIs4Q6VbNOaDHGIKBScKaaL0xuvtTRZyWOwfpotLqe2NwA9fFjEvjdixyVZMdnSxt5Jx96CtL5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E5gEKTl6; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tbmp1jpETIcfRtDuPPtSgSOE7Jl5LOS0NyJ7lzOaPEqkQYny3TTi3Bb4KdRrp+3gUx7cB6ivGPIS8yHBldLuNkO5fvHtiD6gus+2HdEZO5cXjNV3LT5WC+7GFYVKt+fD8WRtgjRSK72ePKf+LSpvjWAqN7NoPrYK9ZwHl1ieud4dDxnTYpbWsK0jxKTJtWYXu7g5MrLYXFgXE4Q0+pBMwFxslCo40jqw16sgcccNGVzsEtsLTccNqGqu6qil5aHOsuWeFc3D27D3hRsA0nckGUGnd22eDIR68RDpjK7zjsGyYOYrX6KqiALF5CDJG4U8MOhdgAEWnifpnhIHi1hHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4hTQdtmX1b9JC/f9Onhh1BVoVF8W1Feq3PcSOgsUXA=;
 b=MVWePSle9wr2NVv3aU0HQ8CrUIkS4Moqwj+M4WOaOCrhlbvcZyHHmrxngb4bbVEhy52tLosDTFQMBs8fMuRgueYGl6PuJ41CT84EI5b6vqCDsZzocP23jpJnBav73Gaa/47c9+7z+6g4auitXupPup4TU9+BOPoj4/m8Is8s3spf0/Kx22XGrHGRsdmI+8ooFkd9ZfTOvosqD0kIENFrQp0k/7MUfUT+Ijyd4pxcWz3BjUXta6dsWkogIONrzY9pifQ2+1PRT7ZpxL0Z3iwLEiAQd7bOZ93M8uu8DadqEoNWA61v4Ls6P0Qh17rX1mjP5+1+oN5z4RfrPDEiL4guqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4hTQdtmX1b9JC/f9Onhh1BVoVF8W1Feq3PcSOgsUXA=;
 b=E5gEKTl6kwhF7u/LrV+fhGdiZpV7Dm8cr7x4a5K6JzHY3sTbMNq+mjv6IgJUWJvv2IciL0g0XELX01UgaqS27oovbgggxIxoGVkPI3V8/TqQTBuimfKQJvDnevSP24UeSA+o1rRWfqt9dLxWCnV+zvryl3SYo3BSzty5kuy3XeV+niLO17f0Fmqvas4vFdvZ5meZqaNQ80cwXBeOH5UIvAE3hIEMTUxEdo5/GJgP1zHqdECTmMPZxkHUD0Yf9t7MsIRN8h9Pn6nOh2Q2ivvA/dhISaq3N4Gizj7a/AZsqLqnfhy975RtYvfL0FCnU9ZAhVwDwfESF4Q7Zbm/p2cLgw==
Received: from MW4PR03CA0078.namprd03.prod.outlook.com (2603:10b6:303:b6::23)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 21:44:33 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::e7) by MW4PR03CA0078.outlook.office365.com
 (2603:10b6:303:b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Wed, 17 Jul 2024 21:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.5 via Frontend Transport; Wed, 17 Jul 2024 21:44:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Jul
 2024 14:44:18 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Jul
 2024 14:44:17 -0700
Message-ID: <5d31907f-1ba0-49ad-968d-52991d3268b3@nvidia.com>
Date: Wed, 17 Jul 2024 14:44:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Converting kselftest test modules to kunit
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, David Gow
	<davidgow@google.com>
CC: Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, "open
 list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>, <kunit-dev@googlegroups.com>,
	"kernel@collabora.com" <kernel@collabora.com>
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
 <CABVgOSmD6j2OK1WXXcO+fTRN7PSpMFph8BT3Unko0c+Bv+3bjA@mail.gmail.com>
 <2a5b0ce2-cb82-4a23-bca6-f402cc13627e@collabora.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <2a5b0ce2-cb82-4a23-bca6-f402cc13627e@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f720cd3-3ba8-47cd-7b4c-08dca6a9a525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmVOUGtpKzdjVDMyblA1aXlwUE8xSHZvSnRONk1QSWRURzZZSGpnSlFXM1Rh?=
 =?utf-8?B?NmYyQnFtZ1p4UFBqME1EUkRqM2t4RnR2MHFVQUoxK3h5cmdpUWpqZTZjYlJQ?=
 =?utf-8?B?RUJGMUM1SklCeDNwWlZBalJ1YVRNWmFOa2l0bUVEZmprYkQ3R0wwU0NNZ2Zm?=
 =?utf-8?B?TzFFdW41Nm9VYloyRG1qM3kzUlBiTDFGbk01WUp4NHdiUlZhS2t2eXh1QlZk?=
 =?utf-8?B?RnlFZytCVitUYkp1VE82TnVoSXBSYUZ2TjNoVko2MjJtL2ZyTnlJeGxNVzV4?=
 =?utf-8?B?RUdhbU1VbnlqTDcxcVJXcU9uWSs4QVpqRGp5Wk8wUFczTEVHM2pKdGRsU3Rl?=
 =?utf-8?B?a1dKcTNmaHl0TmJFRkZ5OEVIU2RxOHFvdmRXSUFnSUdNSDhsRTVnSHVhbFZP?=
 =?utf-8?B?c3NVWTdJYk1UYzdxV2NIQU1zYWNRSmtTQlljUzNWVWlDYlo3SitRa08rNGYr?=
 =?utf-8?B?elVwYUpMTDJ0TXluOXRtMVpUaUZxcmM2RGtWWGtGR2hoNHkwQWRDSGFqck9L?=
 =?utf-8?B?dG5pNU1HSGZ2MGNBaXRkWnJxSldoUUtsc1QwV09qVTdmOHVIVDhIMExBbGZZ?=
 =?utf-8?B?ZnFEVU5BZGtSejNydzNhTTZTaXdyRi9YNGU4VzhHdG0yZFlFWVFwS1V2SUFZ?=
 =?utf-8?B?UXRHeXg4OTFqRmJpWlozSnNnVEdxaEJNOXAvY2l5QmN0bk1jbkN4WVJ1eU5Q?=
 =?utf-8?B?Q0hGMHdyOEtESUFyd3ZvRUNJeGlaeDZRTnVwa1Y3M1RVa3U5Ym9zQkt3RDEv?=
 =?utf-8?B?UGpRNHpPOGtQejUrcmxaS0tRN0k5UzhDQUtQUTNBZkVHUUkyRUNoQzVXd0Qw?=
 =?utf-8?B?VkVrcGd4T0tIOUNxOEc1dXA2dkg4ZURiRFNXaFFRcTRuV3h0VWp4Z2lUakVX?=
 =?utf-8?B?ek5SUUN4NzlJNnB0ZjJiMGdGTXlpdTBJTWliZHRiM3lQTjQ2WXdBYSswaVVB?=
 =?utf-8?B?UmkwOHhLY1ZBL1BHVXFIeDNGOEdnSnByek9SSkN3MURKMU9UUFgzYkJEMTFL?=
 =?utf-8?B?UWhnMmtqbTgyM285VVpkNVF5Wm1md0FlYVlldUFjakZ0YXN3bFV4TEtVdDBi?=
 =?utf-8?B?UGtjWVl0a1YzUmhyZ3plYmRYR2MyVitPM0tyUEVjV1JuRythSlV4azFDVUx6?=
 =?utf-8?B?VXRLUmNmQ09ERVZzMDhFYTB4YTdndTJjMXd5UVRpeDRwL3YweEhYcEkrNkND?=
 =?utf-8?B?ZloxTUwzMTN0TDhKS2FNZmt2eUExWWtrc3JKU3cwbHp2QU9VM05oZGZkRTlM?=
 =?utf-8?B?ZWlKR1ZLUlkyd2FranhwV0dWUGVLTVRha0cyQnhiM1Q0QnVGV05nSUkzRlIy?=
 =?utf-8?B?d093SHJpZFV4dEhPRGtMQW9VRk5YWERSUDUzUjFsUTlnQ0k4SFFnOEZnNXZV?=
 =?utf-8?B?UTdYSi95WWczaXhLbkgwZHIySjIvVGtnektwc3BZOHNubHhEYk4rZnJJdU1I?=
 =?utf-8?B?MWVTS0FoTWFXQmNqNWpIbnZsTmFOdjVMWFNoVFMvNEdGS2pvVkx5L29MSFpo?=
 =?utf-8?B?QzRNYTBDSlFVSDFYK0Y0cUxOMURkaEZzUDVybnhzSk1OWi9RUjR0R1NTWW5I?=
 =?utf-8?B?a1pNZmluWmcraTdYVDRTT0YyOWJQUGF4U01aYUZhRHpHWXFpeHB2WGhHT2or?=
 =?utf-8?B?QVE4bDAySEF2SzlZc0I5a01XakNYZXN3LzBybHgyY1NCNjR1bEtyS2tNYjIy?=
 =?utf-8?B?b09Ia1l2UndwMG1HSkZwZzVzdlJ0dTZRUVhOdjI2YVdrQy80Mk1DZ3AzSUFv?=
 =?utf-8?B?cDVKSGZyMjh5QmZlS2toem8wcW94MDYyaUNycHIvbmxYbXdIem45dkJsVlRO?=
 =?utf-8?B?RHRyRVQ5VVdZRE1DVEtrTWZQelZDaUp3d3l3UVBDbllya213K01vdHJPUFpL?=
 =?utf-8?B?Y0Z0RzQwSU9ROStKUTN0L0kwOHZMblEwMVREUldwNkh4UVN5M2NjSFJKUHJJ?=
 =?utf-8?Q?2go6N6qkQPGbI4OIRExiWfKTOnwSDSls?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 21:44:32.9836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f720cd3-3ba8-47cd-7b4c-08dca6a9a525
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161

On 7/17/24 3:47 AM, Muhammad Usama Anjum wrote:
> Hi David,
> 
> On 7/16/24 12:33 PM, David Gow wrote:
>> On Mon, 15 Jul 2024 at 18:09, Muhammad Usama Anjum
>> <usama.anjum@collabora.com> wrote:
>>>
>>> Hi Kees and All,
>>>
>>> There are several tests in kselftest subsystem which load modules to tests
>>> the internals of the kernel. Most of these test modules are just loaded by
>>> the kselftest, their status isn't read and reported to the user logs. Hence
>>> they don't provide benefit of executing those tests.
>>>
>>> I've found patches from Kees where he has been converting such kselftests
>>> to kunit tests [1]. The probable motivation is to move tests output of
>>> kselftest subsystem which only triggers tests without correctly reporting
>>> the results. On the other hand, kunit is there to test the kernel's
>>> internal functions which can't be done by userspace.
>>>
>>> Kselftest:      Test user facing APIs from userspace
>>> Kunit:          Test kernel's internal functions from kernelspace
>>
>> Yes: this is how we'd like to split things up. There are still a few

Me too. It works.

>> cases where you might want to use kselftest to test something other
>> than a user-facing API (if you needed to set up some complicated
>> userspace structures, etc), or cases where KUnit might be used to test
>> something other than individual pieces of functionality, but that
>> categorisation is a good start.
> Yeah, makes sense. It is helpful to find out what others think. I'll be
> back with changes.
> 

At some point we could connect up the two systems, without really
changing any of the guidelines...much. One way to do that would
be to add a tiny bit of kselftest support for easily launching
a kunit baremetal testing, and then reading the results (which
are right there in sysfs) back to user space.

So it would look like a kselftest, but it could run any kernel-based
tests it needs via kunit.

And the two systems can still be used independently.

>>
>> The Documentation/dev-tools/testing-overview.rst page has a more
>> detailed look at when to use which test framework (which basically
>> just repeats those rules):
>> https://docs.kernel.org/dev-tools/testing-overview.html

Yes, a nice example of up-to-date documentation there. And it's
very clear.

>>
>> Cheers,
>> -- David
> 

thanks,
-- 
John Hubbard
NVIDIA


